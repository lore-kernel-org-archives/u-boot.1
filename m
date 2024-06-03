Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E16C25B76
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 12:27:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2469B882AC;
	Mon,  3 Jun 2024 14:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AF0087FF0; Mon,  3 Jun 2024 10:18:45 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 202CC874D4
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 10:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christian.loehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A87741042;
 Mon,  3 Jun 2024 01:19:06 -0700 (PDT)
Received: from [10.57.83.47] (unknown [10.57.83.47])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAD0E3F792;
 Mon,  3 Jun 2024 01:18:40 -0700 (PDT)
Message-ID: <e0f38bc9-bcc2-4476-a5d4-4f2efaebc0c1@arm.com>
Date: Mon, 3 Jun 2024 09:18:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: obscure microsd detection issue between U-Boot and kernel
To: Tim Harvey <tharvey@gateworks.com>, u-boot <u-boot@lists.denx.de>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <CAJ+vNU3Ns0RVtROcChGAhfO=XbpnzwQv1SehexbgHX6ST6-Piw@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJ+vNU3Ns0RVtROcChGAhfO=XbpnzwQv1SehexbgHX6ST6-Piw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 03 Jun 2024 14:27:46 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 5/31/24 21:47, Tim Harvey wrote:
> Greetings,
> 
> I'm seeing an issue on an imx8mm board (imx8mm-venice-gw73xx) where
> for a specific set of microsd cards if I have accessed the microsd in
> U-Boot with UHS/1.8V the kernel will not recognize that microsd when
> scanning.
> 
> The issue does not occur with all microsd cards but seems to appear
> with a large sample size of a specific card/model (Kingston SDC32 32GB
> SDR104 card). I do not see a signal integrity issue on the scope.
> 
> Instrumenting the kernel the issue is that the host reports a CRC
> error as soon as the first mmc_send_if_cond call which occurs in
> mmc_rescan_try_freq.
> 
> I can avoid the issue by either not accessing the microsd in U-Boot or
> by disabling UHS/1.8V mode in U-Boot therefore what I think is
> happening is that U-Boot leaves the card in UHS/1.8V signalling mode
> and when the kernel scans it sets the voltage back to 3.3V
> standard/default and default timings then issues its clock cycles to
> 'reset' the card and the card does not recognize the reset. I'm
> wondering if this is because the reset is done via clock cycles after
> the kernel has set the I/O voltage back to 3.3V when perhaps the card
> is still in 1.8V mode (although I don't see how that would cause an
> issue)?

It will cause an issue for many cards and might break some cards.

> 
> Is there some sort of MMC 'reset' I can/should do in U-Boot before
> booting the kernel? Has anyone encountered anything like this before?

There is no 'switching back' to 3.3V signalling from UHS 1.8V.
The only way this can be done is therefore a full power-off.
Is that done correctly for your system?
AFAIR spec dictates 500ms of <0.5V on VCC. Note that  driving CLK/signal
lines can also sustain the card somewhat, as leakage is only limited
within operating voltage.
