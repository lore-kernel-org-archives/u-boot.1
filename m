Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F247C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 13:56:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 802EC819B1;
	Wed, 19 Mar 2025 14:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742392573;
	bh=bTutbFYZrRA5du+iTJ+OA8vD6T9q8KAOn4cIwegpt0g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=0S2fASOsOFjWb32QjvCU7Qh+dYKQtvBj1kBrjdwtWmRJk0Ps7zlebSH0JET0QIeuk
	 CbD2k+dE3O8X7Dg5KTL11NUSgfEUrJteRrKdinZEej+Yh7IpJRA3L+7OnETH//yyzm
	 VJCwLRUGrSwUBiQXm9aSp4AVXpR/CmRtdgZVe1uzLyE423yK95W3l5TzHfbO84NUfA
	 XoxgbuLwo80zXeN8Z1tppf+fh8JfXWVqhEhDhNs/w/FI3p2I5i7V9FKm43/kpImdK+
	 IZQwACys+fx8Z3TyU0fPCswmwbEREcmZzypVtDmSrqpPl2lgrgaeYSPtvydafJRNKp
	 nnC57AS+8D+rA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E33D81CA8; Wed, 19 Mar 2025 14:56:12 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A2BB81951
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 14:56:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="QCnZgCLm"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 744FD101E91CC; Wed, 19 Mar 2025 14:56:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742392569;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=bTutbFYZrRA5du+iTJ+OA8vD6T9q8KAOn4cIwegpt0g=;
 b=QCnZgCLm4nQW/7QFPsO06TseGva+Y+07drSdRzm47H574XpSxIk28936ALKRAMI3y4yn1z
 N3FJXHjLGtVm5HIjhWUNY8hWVYPxltxfc4jmlCM/auOfY+b+bXLwPg03NNz1Fg+M6tBWQj
 kTfGL7H0c8sX52Hc/gY+lPaUGgLxqgOoZvmLvTku6KcXcVcjQS5QC8FMGXIF9FXvwEAi4H
 BKYtopE42ETUNe/GoOIBcBa2r15lfpRTyehnJ830sXmYVM4XhOd6wMdb3Yeuoms4Q7toT4
 z6Gau7ovQn0LMj+BWXJlgIG+8CXNQBenOebdUJ+L/eIn2B+OPWOldi5X2mxFvQ==
Message-ID: <77b1cc96-593a-9856-5d18-b4dba4d5ea6f@denx.de>
Date: Wed, 19 Mar 2025 14:56:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] sunxi: pmic_bus: Move SPL I2C addresses into Kconfig
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Simon Glass <sjg@chromium.org>
References: <20250318003943.6714-1-andre.przywara@arm.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250318003943.6714-1-andre.przywara@arm.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Andre,

On 18.03.25 01:39, Andre Przywara wrote:
> Some of the X-Power AXP PMICs can be ordered with an alternative I2C
> address, for instance an AXP717 could be shipped with address 0x34 or
> with address 0x35. Similarly the AXP803 lists two possible addresses.
> For DM (DT) based drivers this is no problem, but the Allwinner SPL
> code relies on exactly one hardcoded address per PMIC so far.
> 
> Add a Kconfig variable that holds the I2C address used by the PMIC
> accessed in the SPL, and provide the (mostly only one) supported address
> as its default, for the PMICs we use. Boards using the other address
> can easily set this in their defconfig.
> This effectively moves the hardcoding from C code to Kconfig.
> 
> That enables to use the AXP717 on some boards with the new Allwinner
> A523 chip, which use the other I2C address there.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>   arch/arm/mach-sunxi/pmic_bus.c | 27 ++-------------------------
>   drivers/power/Kconfig          | 10 ++++++++++
>   2 files changed, 12 insertions(+), 25 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
