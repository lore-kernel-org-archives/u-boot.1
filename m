Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741D9C2A073
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 01:49:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACE168398C;
	Mon,  5 Jan 2026 02:49:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="KD/DXjSG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 368A783A26; Mon,  5 Jan 2026 02:49:23 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB25B800AB
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 02:49:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1767577747;
 bh=3vVkikqeQEM70uQSZmbZsL2Sj9Hq6iNmwku6XAAEgDc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KD/DXjSGCLaZGu+aD+pXQMU3fZ1y8Wn5bhBbV3tCuOUP1zpzXZ3JlPycBIU8m5zWO
 cj8JOeKGlK4AaSVJOmKCPFy+1hRzsXuA/98kbx1Cpj7lCX4Lb2GVTISXsqzKeCGWfs
 Ge+mnNk+kYrxtkEmulp6u36/N+UF5tZTMhaVclkgzr0FKKmYM6qQjVPVIGVMPcgnNS
 SlZwZXk03GVewh9uAOi7Th/aYF1GhmW1SdQ1zVrqJTJujC/p4KhIiFPu6p9h5fnZfL
 tfHSR65sFw5x+0OufAjczFcPw/PUkL5hKkrsMG+Xdxthsi2jxZ77ouXyZQ/ojBX2st
 T9bM2k1NPZIvw==
Received: from [IPV6:2605:59c0:2078:cf00:c0b6:e37b:5515:2b98] (unknown
 [IPv6:2605:59c0:2078:cf00:c0b6:e37b:5515:2b98])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 44B4DB2200EC;
 Mon,  5 Jan 2026 02:49:06 +0100 (CET)
Message-ID: <8c751618-ed62-4cc9-abf0-b673f5a15d85@freeshell.de>
Date: Sun, 4 Jan 2026 17:49:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Pull request efi-next-20251225 (for next branch)
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <1faefbf2-e8b0-4c94-85f5-025355915e0d@gmx.de>
 <176669208910.1263958.8972451881709434686.b4-ty@konsulko.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <176669208910.1263958.8972451881709434686.b4-ty@konsulko.com>
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

Hi,

On 12/25/25 11:48, Tom Rini wrote:
> On Thu, 25 Dec 2025 11:13:02 +0100, Heinrich Schuchardt wrote:
> 
>> The following changes since commit baf076aeb32dcdd2b022405088c3288ffc160fcf:
>>
>>    Merge branch 'staging' of
>> https://source.denx.de/u-boot/custodians/u-boot-tegra into next
>> (2025-12-23 08:11:36 -0600)
>>
>> are available in the Git repository at:
>>
>> [...]
> 
> Merged into u-boot/next, thanks!
> 

Tom:

NAK 4c105d2ae7b "Update StarFive Jh7110 common description" that has
been incorrectly applied and the result contains factual errors I did
not author which are now (wrongly) attributed to me:

> diff --git a/doc/board/starfive/jh7110_common.rst
b/doc/board/starfive/jh7110_common.rst
> index 9beab941cc1..77102fcc189 100644
> --- a/doc/board/starfive/jh7110_common.rst
> +++ b/doc/board/starfive/jh7110_common.rst
> @@ -232,16 +232,11 @@ pull-down.
>  RGPIO1 RGPIO0 StarFive loader function @ 0x2A00_0000
>  ====== ====== ======================================
>  0      0      1-bit QSPI Flash offset 0x0
> -0      1      SDIO3.0
> -1      0      eMMC5.0 or eMMC5.1
> +0      1      SDIO3.0 *(deprecated)*
> +1      0      eMMC5.0 or eMMC5.1 *(deprecated)*
>  1      1      UART Serial XMODEM loader
>  ====== ====== ======================================
>
> -Booting from SD-card or eMMC is only available on boards that have
separate
> -switches for RGPIO0 and RGPIO1 (Milk-V Mars, StarFive VisionFive 2,
Pine64
> -Star64). Due to reported compatibility issues with some SD-cards it is
> -considered deprecated by StarFive.
> -
>  According to `JH-7110 Boot User Guide BootROM`_ the StarFive loader
code reads
>  content to SRAM @ 0x0800_0000 from different media selected by
[RGPIO1,RGPIO0].

Please revert 4c105d2ae7b and re-apply from the publicly reviewed patch:

"[PATCH v4] doc: board: starfive: update jh7110 common description"
https://lore.kernel.org/u-boot/20251221113616.166463-1-e@freeshell.de/

-E
