Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C0BE77182
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 16:34:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A3D9801BD;
	Thu, 12 Dec 2024 17:34:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AYyGsSmB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4336801DA; Thu, 12 Dec 2024 17:34:49 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9636580137
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 17:34:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43622354a3eso6097715e9.1
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 08:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734021287; x=1734626087; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bgja4HdiAE7CfW/KKzLKuTU/ho9maomBfDHipSgEcSQ=;
 b=AYyGsSmBxEIagTY72NIjNY1K2C/ahwKbSs/Ed36eNX2MmCgbHGitwjDrsAfDdw9sEe
 X9MuDYh0Zz0LAtg3UFIQkqc3zWB1KEEz0wHdz6yAdJdQVMGZ4sA478yEG3BQuBQdrsMx
 LFCZWKbFRPgSLcVrUQR00Komq0naWzju8Vei3MTkN8NZ1oiVJUCxnvTfvsDmBlORoOG3
 iIP7GyzHRD+B+xKL3rpFNlZirD+/dBmoFxqcday/NY/3gTNnMtwu6SXGB3jImarH7xzG
 4Y1j331wDW9aMVc4CRzKCf6mPLidMGNsZRKo8zA24yZ+5ZdC7WBd7L3/0ydnanrS9tmZ
 stEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734021287; x=1734626087;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bgja4HdiAE7CfW/KKzLKuTU/ho9maomBfDHipSgEcSQ=;
 b=klPaHxGjJtXgybJFNsKBPo4Y3rVblZTYZ25G3ob2nSi+Pu+Ln9Hs5v50sI4JyVUBL6
 MTRPkhIj5Oi6gi2YMSXEXpbonv54aMuy+WFrzM4uEiQ7S5MWnkzFbMawHREF86kWcOD9
 H4PbJOFBMTB30wFFKTU6UOhWOkNz8Y114oMXPGNkzD4wBBz0nIIDPrvr558xag2VExDw
 EpK9c+byye67jeIKBuQrC28kBpM+RW1cajHWS+gtqQ9KLl+ItbBlE7FGILcM7kwHjWjx
 ldDIjL0UlyrwHlIdUBg+gRAxWK3KXfLSl6YVeo0cX1bkONlxdtlsRfYCUIPneCnFZ8B8
 z4dg==
X-Gm-Message-State: AOJu0Yz9aYOA7u3l1M8A6qMytEP/5mGm0KU2irMto6MVBniJGgDbAEZ/
 J+tV1GBVQDuwnWbmBRXbsFl3f90qbFdNvZs2PvRAR9dLjJ4YP4NoKlyDntfxOr8=
X-Gm-Gg: ASbGncvOkS4OwnX8E1/8WxrFeIOHHdAvDADpIciOdtyVakw+LWsfrtHRIuQnG6KL5z6
 FeN1G11FPVDx+0ftSYPhWOs7Gvi6Qh/OLftXSJdkYqHnqt3YPTBzYI6pDn1ADdGHpEoCxSHLYrs
 3jWZ6rgIlDaFsERIDIOzgnN/TevV+bKgxgUbZnaJ+Y87Avqxn1eTsHLiA5aBX7WYKzQ6ERBXOaN
 IljgDjVs/rfSSAgOIzaH0jqMoDMHluWHmrKptreJFrjqpUN3YT5MB7JPuc3Tv/cuxojXxvmRSK3
 +9XRwjjyHFI=
X-Google-Smtp-Source: AGHT+IGFIqRt1cY7/UOAykyVeLjd5JqBdrIgqavE3suoAFMpOVzyWGxr787BzTI6bjv7OWzjFObYzQ==
X-Received: by 2002:a05:600c:1d83:b0:434:f7e3:bfa8 with SMTP id
 5b1f17b1804b1-4361c4590b1mr59282275e9.33.1734021286800; 
 Thu, 12 Dec 2024 08:34:46 -0800 (PST)
Received: from hera (ppp176092181030.access.hol.gr. [176.92.181.30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362557c66esm21806255e9.14.2024.12.12.08.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 08:34:46 -0800 (PST)
Date: Thu, 12 Dec 2024 18:34:44 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
Message-ID: <Z1sQpA6eTeh9lbys@hera>
References: <20241212151142.1562825-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212151142.1562825-1-trini@konsulko.com>
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

Hi Tom,

On Thu, Dec 12, 2024 at 09:11:41AM -0600, Tom Rini wrote:
> Introduce an option to control if we expect that a prior stage has
> created a bloblist already and thus it is safe to scan the address. We
> need to have this be configurable because we do not (and cannot) know if
> the address at CONFIG_BLOBLIST_ADDR is in regular DRAM or some special
> on-chip memory and so it may or may not be safe to read from this
> address this early.

Yes this patch makes instead of making the OF_SEPARATE implicitly take
priority

>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  common/Kconfig | 32 ++++++++++++++++++++++++++++++++
>  lib/fdtdec.c   | 11 +++--------
>  2 files changed, 35 insertions(+), 8 deletions(-)
>
> diff --git a/common/Kconfig b/common/Kconfig
> index e8d89bf6eb9d..e8febad0f212 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -1077,6 +1077,14 @@ config BLOBLIST_SIZE
>  	  is set up in the first part of U-Boot to run (TPL, SPL or U-Boot
>  	  proper), and this sane bloblist is used for subsequent phases.
>
> +config BLOBLIST_PRIOR_STAGE
> +	bool "Bloblist was created in a stage prior to U-Boot"
> +	default y
> +	depends on BLOBLIST_FIXED
> +	help
> +	  Select this if the bloblist at CONFIG_BLOBLIST_ADDR was created
> +	  before U-Boot is started.
> +
>  config BLOBLIST_SIZE_RELOC
>  	hex "Size of bloblist after relocation"
>  	default BLOBLIST_SIZE if BLOBLIST_FIXED || BLOBLIST_ALLOC
> @@ -1117,6 +1125,14 @@ config SPL_BLOBLIST_ALLOC
>
>  endchoice
>
> +config SPL_BLOBLIST_PRIOR_STAGE
> +	bool "Bloblist was created in a stage prior to SPL"
> +	default y
> +	depends on SPL_BLOBLIST_FIXED
> +	help
> +	  Select this if the bloblist at CONFIG_BLOBLIST_ADDR was created before
> +	  U-Boot SPL is started.
> +
>  endif # SPL_BLOBLIST
>
>  if TPL_BLOBLIST
> @@ -1146,6 +1162,14 @@ config TPL_BLOBLIST_ALLOC
>
>  endchoice
>
> +config TPL_BLOBLIST_PRIOR_STAGE
> +	bool "Bloblist was created in a stage prior to TPL"
> +	default y
> +	depends on TPL_BLOBLIST_FIXED
> +	help
> +	  Select this if the bloblist at CONFIG_BLOBLIST_ADDR was created before
> +	  U-Boot TPL is started.
> +
>  endif # TPL_BLOBLIST
>
>  if VPL_BLOBLIST
> @@ -1175,6 +1199,14 @@ config VPL_BLOBLIST_ALLOC
>
>  endchoice
>
> +config VPL_BLOBLIST_PRIOR_STAGE
> +	bool "Bloblist was created in a stage prior to VPL"
> +	default y
> +	depends on VPL_BLOBLIST_FIXED
> +	help
> +	  Select this if the bloblist at CONFIG_BLOBLIST_ADDR was created before
> +	  U-Boot VPL is started.
> +
>  endif # VPL_BLOBLIST
>
>  endmenu
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index b06559880296..29bddab4150c 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1669,15 +1669,10 @@ int fdtdec_setup(void)
>  	int ret = -ENOENT;
>
>  	/*
> -	 * If allowing a bloblist, check that first. There was discussion about
> -	 * adding an OF_BLOBLIST Kconfig, but this was rejected.
> -	 *
> -	 * The necessary test is whether the previous phase passed a bloblist,
> -	 * not whether this phase creates one.
> +	 * Only scan for a bloblist and then if that bloblist contains a device
> +	 * tree if we have been configured to expect one.
>  	 */
> -	if (CONFIG_IS_ENABLED(BLOBLIST) &&
> -	    (xpl_prev_phase() != PHASE_TPL ||
> -	     !IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
> +	if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE)) {

Without wider context I am not sure but if that check can fold in
bloblist_maybe_init() and return -X if the config isn't enabled, it's going
to be easier to read

Thanks
/Ilias
>  		ret = bloblist_maybe_init();
>  		if (!ret) {
>  			gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> --
> 2.43.0
>
