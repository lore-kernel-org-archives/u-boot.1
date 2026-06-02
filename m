Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28655CD6E57
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 20:42:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C6A784852;
	Tue,  2 Jun 2026 22:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="X2Hl11kF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 575F984857; Tue,  2 Jun 2026 22:42:38 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F2B884837
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 22:42:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 267DB116696; Tue,  2 Jun 2026 22:42:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1780432955;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=RAVzszeaMnlnCA2i2nh5yrNZ/YUl66zA40LnHjp4yzo=;
 b=X2Hl11kFQ6kLpVXv/p/3lSY9WhXCTSDrJonGdLhVLwRaZhyPXGLoaTSAaN3Pk3EVyTUAHa
 pmGvVwenVe6uHz3nLgKSY+mbF6pxaf1bohX9NoBdYLe3Z2zd8Xibpwujd3YS2No8bR87di
 I6XhmODhl+s2CkIL+Aa+sUU8TdcEZfyLmoG4hxDR4ELiYpCeriyfJDm2onDw7nM+ItO2xh
 qA5tzCK87qWHrCwCw76iC63E+gmzIgdG32x2Z94FXgswV8eqGUPsEdtsBHnRjH8K8/N7ts
 kNk/gU+TeS8qkjl5l4jI/tpjq4+XuuFVRx1xMfqdMx339XDvJcO952SUzgA0xA==
Message-ID: <4dd5cfbf-18d3-4411-bb02-c746611ecceb@nabladev.com>
Date: Tue, 2 Jun 2026 16:11:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] imx9: Add support for saving DDR training data to
 NVM
To: Simona Toaca <simona.toaca@oss.nxp.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, ye.li@nxp.com, simona.toaca@nxp.com,
 viorel.suman@nxp.com, fedor.ross@ifm.com, joao.goncalves@toradex.com,
 ravi@prevas.dk, ping.bai@nxp.com, ji.luo@nxp.com, qijian.guo@nxp.com
References: <cover.1777536451.git.simona.toaca@nxp.com>
 <d9038d69963976399d8e8e26dbf84b98ee1f82da.1777536451.git.simona.toaca@nxp.com>
 <acfe5311-2ec4-48fb-80bd-55c11931b377@nabladev.com>
 <4phebvxijyyk5yd4p7omjlup3iotsqgp6r3kt5aiwgimwg6nyp@hnl3qq4imsf2>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <4phebvxijyyk5yd4p7omjlup3iotsqgp6r3kt5aiwgimwg6nyp@hnl3qq4imsf2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 6/2/26 3:46 PM, Simona Toaca wrote:

Hi,

>>> +	ret = spi_flash_erase_dm(flash, offset, QB_STATE_LOAD_SIZE);
>> Can you please double-check whether "offset" here is always aligned to 64
>> kiB (SPI NOR erase block size) ? If not, this erase here will fail.
>>
>> Thank you
> 
> The erase size of the SPI NOR should actually be 4kiB.

That does not apply to all devices. I assume to align this data to 64 
kiB offset, I would need a replacement AHAB container?

> I added
> a patch a while back enabling SFDP support, so that the erase size is
> parsed correctly and this does not fail. I only enabled it on U-Boot,
> but if you are using SPL you should enable it there too.
> 
> The only reason why I did not enable it for SPL is that there seems
> to not be any defconfig for iMX95/943/952 for booting from SPI NOR.
> 
> Trying 'qb save spi' from eMMC on an iMX943 EVK (with SFDP enabled):
> u-boot=> qb save spi
> SF: Detected mt35xu512aba with page size 256 Bytes, erase size 4 KiB,
> total 64 MiB
> u-boot=> echo $?
> 0
> 
> Without SFDP, 'sf probe' reports 128kiB erase size, not 64kiB.
> 
> I also do not see why I would check if the offset is a multiple of
> the erase size, since the erase fails gracefully.
My understanding is, that the erase operation should erase the QB data 
from the SPI NOR, not ignore failure and keep the data there ?
