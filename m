Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CB4F99C89
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 16:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0739583BC8;
	Sat, 18 Apr 2026 18:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="JoEsOyNm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B42783FC0; Sat, 18 Apr 2026 18:56:20 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D7CA83B99
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 18:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1776531377;
 bh=iIRJlSyTzzEbkE0jcdzDMMGpiTUHMk7szxvgfV/OMnE=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=JoEsOyNmPOg0jaGsElfsZHCOOGTSL7UUGtW1ltea+VgTCUUhFiONpT4BmntWCO/Ar
 aJmoITeRvPRh7afWpHIz8fuARzrVHaEnEsm8vREu/vBIG61TazSIwpDgM6DAQGI3o6
 RgolAMK7e+Wkg6OyJm0pqRPOWgdDQZfcv/Sevz2naKO57J2xtCKq8o4bih214KuriD
 mNHDv2QrCFr+Ckx95PvZunkH+vVfKtROqBbw/e9g1+f8B/XMZ2f+yAcwGMvRZJbBsH
 hdFF2f1YOKZkIp4eWMg825KlNEvMoSZWQfVlmaBmdJCC+SPbjGSgoXK0e9M1U/vf/X
 XpqPbGtIFixKQ==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id A7F54B2203BA;
 Sat, 18 Apr 2026 18:56:16 +0200 (CEST)
Message-ID: <4d549ae6-4dbb-472f-bacc-8f9ca7224a13@freeshell.de>
Date: Sat, 18 Apr 2026 09:56:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to build U-Boot with a custom out-of-tree device tree
To: Johannes Krottmayer <krotti83@proton.me>, u-boot@lists.denx.de
References: <034a4ae4-b579-42b0-b6b0-3a204737156f@proton.me>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <034a4ae4-b579-42b0-b6b0-3a204737156f@proton.me>
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


On 4/18/26 07:40, Johannes Krottmayer wrote:
> Hello,
> 
> This question is generic and also valid for none RISC-V boards.
> I think it's maybe already asked, but didn't find any useful
> information this time. My question is, is it possible to pass
> a specific device tree blob to the build system from U-Boot?
> 
> Example: RISC-V board Starfive VisionFive 2 8GiB variant
> 
> The default in-source-tree device tree from the VisionFive 2 has
> only 4GiB RAM. I own the 8GiB (RAM-IC BiWin BMWZCX32H2A-64G-X)
> variant. So therefore can I pass the device tree blob directly
> to U-Boot's build system without modifying CONFIG_DEFAULT_DEVICE_TREE
> in the device configuration? Exists there an environment variable?
> 
> Want to use U-Boot's EFI subsystem as loader for bare-metal
> environments. And I think when I want to get the memory map
> via EFI there will with the default device tree only <4GiB free
> usable memory shown, although there are 8GiB.
> 
> Thanks in advance!
> 
> Kind regards,
> 
> Johannes K.

What you're asking about VisionFive 2 can be done simply. It is arranged
so that arch/riscv/dts/starfive-visionfive2-u-boot.dtsi is named in
starfive_visionfive2_defconfig DEVICE_TREE_INCLUDES and then that acts
with dts syntax to include the binman specific
starfive_visionfive2-binman.dtsi

Additionally there is the automatic dts inclusion mechanism from
scripts/Makefile.lib approximately source line 230 you can see the
precedence there; An example of this, look at some of my patch series
when I posted before the necessary files to support the series had
landed in devicetree-rebasing, my approach was to create empty
directory/files as necessary in the devicetree-rebasing subtree but to
create the special "<"
whatever-we're-currently-doing-in-the-build-system-u-boot.dtsi which
happens to be the board variant specific empty file I created in
devicetree-rebasing subtree and with our -u-boot.dtsi automatic
inclusion prefix.  It's simple, it just is not easy for me to explain
clearly so I hope you may follow what I am describing.

As long as there is a directory and/or file (may be empty, cannot be
missing entirely) in the subtree for devicetree-rebasing, and suitable
variant board is named in the OF_LIST, then the build will recurse into
the upstream-rebasing for those file targets.

For local testing one approach I've had good success with is to replace
the dts/upstream/src/riscv/starfive directory with a symbolic link to a
local checkout of the linux repository arch/riscv/boot/dts/starfive and
I make my changes in linux repository, then simply recompile U-Boot. I
wish this were a U-Boot compile time option to refer to a local Linux
repository;  I looked into making this change but it's very specific to
devicetree-rebasing with many hardcoded assumptions.

-E
