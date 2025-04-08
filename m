Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF76CC3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 04:29:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC172830A0;
	Tue,  8 Apr 2025 06:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NSrJBpOB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37CC2831D6; Tue,  8 Apr 2025 06:29:18 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F070983095
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 06:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 9435EA44CC7;
 Tue,  8 Apr 2025 04:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3759C4CEE5;
 Tue,  8 Apr 2025 04:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744086553;
 bh=947pjdNKg8xNZGn7MVwJmnI282jhhDGFvl+07bqQiaY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NSrJBpOBqfQRaunJK2iPuOZcspsoFMU8HMN1eojBD5tGlDOlyVSHFrGjj2dfB3xj2
 hTYt7ymjN/Ej8HVqnpx8Jh+wKy7Je4Y80QHokJYCSK/CGVxYjM6U5UMY7BNX9S6OPO
 SpnX9rt/jRIYejrtbq6Vl5LgJbflvLB61+zCTAn1vlyKCSe72LmXDEBtQGr/fDHoWQ
 PiGE9+00TAfydCcowS9NAUTLVbETaJbANFAFgQuyPvwzgGMT4wWbNKM5NCH5BwrV/3
 UETJHOpHU0JBprvJ/fBeyYZyTxHV1TRIQLVxtQ4If8vUF6O+ohbBTdOw2mxR9ooUYM
 9nvH+TDulwvxA==
Date: Tue, 8 Apr 2025 09:59:07 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de, neil.armstrong@linaro.org, trini@konsulko.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] qcom_defconfig: Disable MMC HS200 mode support
Message-ID: <Z_SmE-gQzzs5HJqi@sumit-X1>
References: <20250407132810.35149-1-sumit.garg@kernel.org>
 <20250407132810.35149-3-sumit.garg@kernel.org>
 <510b1e90-bf1e-4a7b-8a86-c8fbaf485fb6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <510b1e90-bf1e-4a7b-8a86-c8fbaf485fb6@linaro.org>
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

On Mon, Apr 07, 2025 at 04:30:44PM +0200, Caleb Connolly wrote:
> 
> 
> On 4/7/25 15:28, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Currently the msm_sdhci doesn't yet support DLL configurations which are
> > required to enable bus speeds greater that 100MHz. So disable HS200 mode
> > support as of now as it requires bus speeds of 200MHz.
> > 
> > This should fix eMMC issues reported on RB1.
> 
> This fixes the write corruption issues? Nice find!!

Yeah, thanks.

> 
> Is this a problem on ALL Qualcomm platforms? the sdcard seems to work fine
> on other boards, would this reduce their performance?

Yes this problem should affect all Qualcomm platforms but it hasn't been
seen there as mostly SD cards available don't support HS200 mode. The SD
cards usually works in high speed mode whose performance remains
unaffected by this change. It only affects RB1/RB2 as eMMC flash on
these support HS200 mode but the U-Boot driver currently is incapable of
supporting that.

-Sumit

> 
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >   configs/qcom_defconfig | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> > index a2b54b95f19..537806450dc 100644
> > --- a/configs/qcom_defconfig
> > +++ b/configs/qcom_defconfig
> > @@ -81,7 +81,6 @@ CONFIG_QCOM_HYP_SMMU=y
> >   CONFIG_MISC=y
> >   CONFIG_NVMEM=y
> >   CONFIG_I2C_EEPROM=y
> > -CONFIG_MMC_HS200_SUPPORT=y
> >   CONFIG_MMC_SDHCI=y
> >   CONFIG_MMC_SDHCI_ADMA=y
> >   CONFIG_MMC_SDHCI_MSM=y
> 
> -- 
> Caleb (they/them)
> 
