Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92F0C25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 13:21:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE5CA88523;
	Tue,  4 Jun 2024 15:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF1E5883B6; Tue,  4 Jun 2024 09:47:12 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9701F88458
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 09:47:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christian.loehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26B4C1042;
 Tue,  4 Jun 2024 00:47:34 -0700 (PDT)
Received: from [10.57.86.243] (unknown [10.57.86.243])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72DCC3F762;
 Tue,  4 Jun 2024 00:47:08 -0700 (PDT)
Message-ID: <50bfdbf9-2ab0-4111-bf2e-abe4c9ed86fb@arm.com>
Date: Tue, 4 Jun 2024 08:47:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: obscure microsd detection issue between U-Boot and kernel
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <CAJ+vNU3Ns0RVtROcChGAhfO=XbpnzwQv1SehexbgHX6ST6-Piw@mail.gmail.com>
 <e0f38bc9-bcc2-4476-a5d4-4f2efaebc0c1@arm.com>
 <CAJ+vNU0jiVb4caYeQ5HYKZ-dqxcdG1K5pPisJZpfL4q7Sc3zvA@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJ+vNU0jiVb4caYeQ5HYKZ-dqxcdG1K5pPisJZpfL4q7Sc3zvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 04 Jun 2024 15:18:43 +0200
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

On 6/3/24 22:28, Tim Harvey wrote:
> On Mon, Jun 3, 2024 at 1:18 AM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 5/31/24 21:47, Tim Harvey wrote:
>>> Greetings,
>>>
>>> I'm seeing an issue on an imx8mm board (imx8mm-venice-gw73xx) where
>>> for a specific set of microsd cards if I have accessed the microsd in
>>> U-Boot with UHS/1.8V the kernel will not recognize that microsd when
>>> scanning.
>>>
>>> The issue does not occur with all microsd cards but seems to appear
>>> with a large sample size of a specific card/model (Kingston SDC32 32GB
>>> SDR104 card). I do not see a signal integrity issue on the scope.
>>>
>>> Instrumenting the kernel the issue is that the host reports a CRC
>>> error as soon as the first mmc_send_if_cond call which occurs in
>>> mmc_rescan_try_freq.
>>>
>>> I can avoid the issue by either not accessing the microsd in U-Boot or
>>> by disabling UHS/1.8V mode in U-Boot therefore what I think is
>>> happening is that U-Boot leaves the card in UHS/1.8V signalling mode
>>> and when the kernel scans it sets the voltage back to 3.3V
>>> standard/default and default timings then issues its clock cycles to
>>> 'reset' the card and the card does not recognize the reset. I'm
>>> wondering if this is because the reset is done via clock cycles after
>>> the kernel has set the I/O voltage back to 3.3V when perhaps the card
>>> is still in 1.8V mode (although I don't see how that would cause an
>>> issue)?
>>
>> It will cause an issue for many cards and might break some cards.
>>
>>>
>>> Is there some sort of MMC 'reset' I can/should do in U-Boot before
>>> booting the kernel? Has anyone encountered anything like this before?
>>
>> There is no 'switching back' to 3.3V signalling from UHS 1.8V.
>> The only way this can be done is therefore a full power-off.
>> Is that done correctly for your system?
>> AFAIR spec dictates 500ms of <0.5V on VCC. Note that  driving CLK/signal
>> lines can also sustain the card somewhat, as leakage is only limited
>> within operating voltage.
> 
> Hi Christian,
> 
> Are you saying the only way to properly reset from 1.8V is to have a
> VDD supply on the microSD card that can be turned off before booting
> to Linux? We have never had that before and never encountered
> something like this.

Yes, the only safe way to use UHS-I really anyway.
You could disable UHS for u-boot but that still leaves (potentially)
problematic warm-reboots of the board.
Having a (software-controlled) switchable regulator on SD VCC is pretty
common for this reason and you should be able to find it in most dts
for host controllers with sd-uhs-* property.
I'm afraid that the relevant spec section isn't available in the
simplified version.

Kind Regards,
Christian
