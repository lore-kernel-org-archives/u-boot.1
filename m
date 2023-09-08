Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3B6EE801F
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 16:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99CA786A08;
	Fri,  8 Sep 2023 18:42:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qutdV/fZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7648386A1F; Fri,  8 Sep 2023 18:42:41 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D020B869F5
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 18:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31c7912416bso2320730f8f.1
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 09:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694191358; x=1694796158; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ScqFyoEU2AOShTtPEcSLoXhSegutv3XmJuJ7rGvgdvM=;
 b=qutdV/fZLqZJTUfBlKW3uNdL6fljez4HOlMxpVmrso/s0JGPtPKvAFVONIPk00BVqv
 gcZJoWwrI49E2gWTZSkRPYJUp4rGbNGItTY315+w2XTn8GxHskx33vUGMiWCHlXbZLFz
 yCdQKRj6nwbWb1XdzIjsNVi0HV6Gn0RlbC4FDRF8SeX/oHoHuJdFv2Yi5Q+2MLkgSak8
 sxRVoHemvyJaI2PmHI+0EiT96sH+BPbSHxHClNYCOXBW0JJ/LnBdm6rmD8Q4HEp0Z4J1
 HhJ2rbSszAOt0OLf99BqCJUYpo+trwo9pFW+MfPs1gPpxBCeKDwFN/KDDWuV60NuMFqq
 kf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694191358; x=1694796158;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ScqFyoEU2AOShTtPEcSLoXhSegutv3XmJuJ7rGvgdvM=;
 b=qlpgFgVAwIB+2EupSWitQM3HS1PtFS8OS0hDgeCFcRuSbL6v0JqPH0zPrNCGf2dkPo
 8ABh/VldUuQ4xAnjY9e2TjXVDOGtDLyhqZlVYDFF64voBEShFHTWdu09KPzg8KOTyBjJ
 r99HBS82EkrD1+BDu2ajPHjUsBCxt7GpDHPPaNlF7adIE8VBFFPI6oRO/yZrub2E2Rkf
 i5zwTEeKyhD8HU57AbmfmINjslvAxc/a2JpQZEuE/x9mtcmHoAGad2onpoUwgjJ61MhW
 TzzG9CG6wp3Tbxv1kdsQ1lNnMFktRmKcsHJVcE9qZlzXrBk0ijZyCjCTSyJST/vpnlSX
 t7WA==
X-Gm-Message-State: AOJu0YyF8ZWOVowphTd0bMf+CdjLQ4lVMxXYDi6wMVFvrlXgmGrTdeaC
 ghLHkOuU2wPtWmM/xBFeX+kgIA==
X-Google-Smtp-Source: AGHT+IF9dumghd3K+bist4rnrmE3x0JS6fmA1yb4lV0k1/thFlhemT/DnBkSYpnr2Zzxn6YQlTVAmg==
X-Received: by 2002:adf:e784:0:b0:317:3c89:7f03 with SMTP id
 n4-20020adfe784000000b003173c897f03mr2583120wrm.5.1694191358288; 
 Fri, 08 Sep 2023 09:42:38 -0700 (PDT)
Received: from hera (ppp089210246083.access.hol.gr. [89.210.246.83])
 by smtp.gmail.com with ESMTPSA id
 s17-20020adff811000000b0030ada01ca78sm2493245wrp.10.2023.09.08.09.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 09:42:37 -0700 (PDT)
Date: Fri, 8 Sep 2023 19:42:35 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, dphadke@linux.microsoft.com,
 macromorgan@hotmail.com, sjg@chromium.org
Subject: Re: [PATCH 2/3] fdt: kaslr seed from tpm entropy
Message-ID: <ZPtO+7sQx5Tuin0n@hera>
References: <20230804233357.65214-1-seanedmond@linux.microsoft.com>
 <20230804233357.65214-3-seanedmond@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804233357.65214-3-seanedmond@linux.microsoft.com>
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

Hi Sean,

On Fri, Aug 04, 2023 at 04:33:56PM -0700, seanedmond@linux.microsoft.com wrote:
> From: Dhananjay Phadke <dphadke@linux.microsoft.com>
>
> Add support for KASLR seed from TPM device. Invokes tpm_get_random()
> API to read 8-bytes of random bytes for KASLR.

Can you elaborate a bit more why you specifically need an RNG from the TPM?

>
> Signed-off-by: Dhananjay Phadke <dphadke@linux.microsoft.com>
> Signed-off-by: Drew Kluemke <ankluemk@microsoft.com>
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> ---
>  boot/image-fdt.c      |  3 +++
>  common/fdt_support.c  | 39 ++++++++++++++++++++++++++++++++++++++-
>  include/fdt_support.h |  1 +
>  lib/Kconfig           |  9 +++++++++
>  4 files changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index f10200f647..127443963e 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -624,6 +624,9 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob,
>  		goto err;
>  	}
>
> +	if (IS_ENABLED(CONFIG_KASLR_TPM_SEED))
> +		fdt_tpm_kaslr_seed(blob);

So, why can't we just add entropy from any available RNG? In Arm world we
could have TF-A, OP-TEE, an RNG hardware or a TPM capable of doing that (or
all of them).

Can't we just do
platform_get_rng_device(&dev);
dm_rng_read(....);

And even if we specifically need an RNG from a TPM, I think it's better to
find a way and teach platform_get_rng_device() to return a list of devices
in priority instead of hardcoding that.

[...]

Thanks
/Ilias

