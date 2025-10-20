Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926AECCD193
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 12:50:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 025C6807C0;
	Mon, 20 Oct 2025 14:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C356831D5; Mon, 20 Oct 2025 14:50:36 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9094807B1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 14:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.25.82]) (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 10DECB220EE5;
 Mon, 20 Oct 2025 14:50:31 +0200 (CEST)
Message-ID: <6f064f60-db59-4f71-b3e8-dbb00f51b0a8@freeshell.de>
Date: Mon, 20 Oct 2025 05:50:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Booting from SD-card on StarFive VisionFive 2 is broken in master
To: Yao Zi <ziyao@disroot.org>, u-boot@lists.denx.de
Cc: Leo <ycliang@andestech.com>, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Vivian Wang <wangruikang@iscas.ac.cn>
References: <aPYUlyni65Ux8xpq@pie> <aPYXu9HsnCO49riQ@pie>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <aPYXu9HsnCO49riQ@pie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Yao,

On 10/20/25 04:06, Yao Zi wrote:
> On Mon, Oct 20, 2025 at 10:53:11AM +0000, Yao Zi wrote:
>> Hi there,
>>
>> While testing the behavior of my previous patch on JH7110 platforms,
>> it's found that StarFive VisionFive 2 fails to boot from SD-card with
>> current U-Boot master "a58089ad2e4 (fs: semihosting: Use correct
>> variable for error check, 2025-10-02)" with messages like
>>
>> 	U-Boot SPL 2025.10-00669-ga58089ad2e41 (Oct 20 2025 - 10:29:30 +0000)
>> 	DDR version: dc2e84f0.
>> 	Trying to boot from MMC2
>> 	spl: partition error
>> 	Error: -38
>> 	SPL: failed to boot from all boot devices
>> 	### ERROR ### Please RESET the board ###
> 
> Forgot to mention it, this problem was also independently found by
> Vivian Wang in later September, so here's also
> 
> Reported-by: Vivian Wang <wangruikang@iscas.ac.cn>
> 
> Adding her CC as well.
> 
> Best regards,
> Yao Zi

The eMMC / SD Card methods of BootROM loader are deprecated in the
StarFive JH-7110 Technical Reference Manual. Please migrate to using SPI
NOR flash or UART boot methods that are supported.

The lack of support for this method is intentional as a result of
non-compliance in the upstream code review process. In response to the
request to support these deprecated methods I asked for supporting
documentation in the form of BootROM source code (for which StarFive is
in violation of GPL2.0+ by the way, it is required to publish source of
modifications and StarFive have not done this). If we want to support
this deprecated mode I will agree when GPL compliance is adhered to;
this would give us the documentation in form of source code that I
expect to be able to make a reasoned decision about whether or not to
support this deprecated feature set.

If you would like to engage with this discussion it should go to
upstream Linux Kernel Mailing List:

https://lore.kernel.org/lkml/521e5549-de83-49a1-a0e5-e47a2cb275ef@freeshell.de/

-E
