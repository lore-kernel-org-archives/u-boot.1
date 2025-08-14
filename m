Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC38CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 05:48:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB5B6836D3;
	Thu, 14 Aug 2025 07:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R3q6XRx3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 944158381D; Thu, 14 Aug 2025 07:48:40 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA0A8837A7
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 07:48:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 615825C5949;
 Thu, 14 Aug 2025 05:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F70C4CEF4;
 Thu, 14 Aug 2025 05:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1755150516;
 bh=UmYqS2u2gKO3jABLMnOmSskXKmBdg8nbfe8Pxg+tzp0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=R3q6XRx3bWT1QEKV29DVJ9yzjsZ3QZR5oOxho5zo1jP4w+dbmxKZoqUS+xhp7nOxv
 6KeiRdTjFqYM+ZLaQqEM/tzdV5Oz5MVmjGBHN/1WyPj3HA4dldXrma+oK7UHSWExMq
 Z3xkVCsr34EMMsfEIw/9r6jGDtTXufL5dRDTyQGFVIolObzAOyvUU8UDj4Sv2RIFMu
 JWNQ0kXokuzBk1HLE2dqW/BZj2/XuPHAt2pguUrFK87pp7WLhyFQJ4Mmdqlmj8t0dr
 TbpcFoyf1qQA+hQGyyqHvJuWNOyc/DaG9fqB90BbV46lLFomBHZrLQpdfdVPmqppgu
 oY6+OmSfpjljQ==
Date: Thu, 14 Aug 2025 11:18:19 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, neil.armstrong@linaro.org, trini@konsulko.com,
 dmitry.baryshkov@oss.qualcomm.com, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v2] qcom_defconfig: Add VID/PID to represent fastboot
 device
Message-ID: <aJ14o75G4SnU_Emp@sumit-X1>
References: <20250724111911.67872-1-sumit.garg@kernel.org>
 <4816e2ef-b690-4f56-acf3-9c8b7a491b5f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4816e2ef-b690-4f56-acf3-9c8b7a491b5f@linaro.org>
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

On Wed, Aug 13, 2025 at 03:50:21PM +0200, Casey Connolly wrote:
> Hi Sumit,
> 
> On 24/07/2025 13:19, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Currently fastboot mode is enumerated as VID/PID: 0000:0000 which is
> > not appropriate. On Qcom platforms, fastboot mode is rather enumerated
> > as VID/PID: 18d1:d00d in ABL or from fastboot.efi app. So lets use the
> > same VID/PID pair in U-Boot to represent fastboot mode.
> 
> Since we have different defconfigs going on for Qualcomm, I think it
> makes more sense to set defaults in drivers/usb/gadget/Kconfig like
> rockchip does, then we don't need to update all the defconfigs and we
> can just override them if desired. Would you mind respinning this? Sorry
> this is coming so late...

No worries, Kconfig option sounds reasonable to me. I can spin up a v3
with that.

-Sumit

> 
> Kind regards,>
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> > 
> > Changes in v2:
> > - Rebased to tip of master since v1 didn't apply cleanly there.
> > 
> >  configs/qcom_defconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> > index b9ba7a677d9..4e24a43b888 100644
> > --- a/configs/qcom_defconfig
> > +++ b/configs/qcom_defconfig
> > @@ -140,6 +140,8 @@ CONFIG_USB_XHCI_DWC3=y
> >  CONFIG_USB_DWC3=y
> >  CONFIG_USB_DWC3_GENERIC=y
> >  CONFIG_USB_GADGET=y
> > +CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
> > +CONFIG_USB_GADGET_PRODUCT_NUM=0xd00d
> >  CONFIG_USB_FUNCTION_MASS_STORAGE=y
> >  CONFIG_UFS=y
> >  CONFIG_QCOM_UFS=y
> 
> -- 
> // Casey (she/her)
> 
