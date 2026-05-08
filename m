Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6C1CD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 10:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B913E84B56;
	Fri,  8 May 2026 12:54:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ogtm6UoT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 011B684C19; Fri,  8 May 2026 12:54:28 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6C6D84AE9
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 12:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso17541375e9.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 03:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778237664; x=1778842464; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Dl3y++4dg7q8DTU6+PnkwJTKcc2YdP9bddcOWFwi5U=;
 b=Ogtm6UoTycos+iGeXZyM3dosBF+TjAO+0O44M0+lxYoOS/RhuHxu/xHRo9vv68YdQw
 69g18fi1pnBdgn4kCRUa2Lbl/D+l5LD9xIjsBEzFaI/61G4e6qr3R0dbYZdQlc9XjzxG
 LIpDCuSZw6BUyIV2Y4OLhIe49+ZblmeC4bY5sTDO3OLUK6r5oJEvurJvPBZV2TXFrsB8
 ewhG79G0bv37+hyrz26fXEn/yXkXJnu6XgS5rBuG7VdK3SV6cyjY1Rit3jrfeNCicK5K
 kLYnHlfXRbiAoKUfyARUSL4FKaZwrs0z83OaHWiLl1jTmKVNJuRnBuQE0WNmYZTsqoRs
 oJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778237664; x=1778842464;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2Dl3y++4dg7q8DTU6+PnkwJTKcc2YdP9bddcOWFwi5U=;
 b=h+gG32hPuhp6qlPgKp9tEVuZdU7J+w2Dh962D9XWXlWPAdzAt5bWidlgvu+GXzjXGs
 RYkuNGh8HKh9wijy9n7BojqyhrwviJcq+2TwN6vLipkCrRza2ie8SakCVUhFpAko3oHo
 Kd7IpXTXf8gjRpUVJJICI4kWiftRrh9Gff9eqB+ann3+J2CR4IALc4wZ/nMmJb+muBMg
 aIGwImWkKQCSZkjr6NVP/YPJL1FX+W9HdldzyasiHwGi/hd0zMu1o2OMl9BGtPEdlWwf
 zcG8TcwaV95ICO7UpOMNIJtL3ZWtl3LFbuPLKLNcjGbGAbbt+b242zWIvVVpEZ/L0fW4
 YSmg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9G7OZi6YhOg2+yEoIt0Zij2/oIaQV+aZdmnjQUOHJ+HzPDa3stehvRqS3QPisgoDFh42eXHJ0=@lists.denx.de
X-Gm-Message-State: AOJu0Yyh7/SnXGvsBens3/KMqFPuLEWnY8gNVRKS2hAYbbov4fByyLyd
 YLv+Pxn8JL5JnKlExlZtr14dRHXQF3zrQNd+If+3FOR5T1LmPS1Nz9JYURmr2hGNpls=
X-Gm-Gg: AeBDieugtPyLr8/lbMC9v2eWJhwYh6W38VEsXI6KuF0YqACIgE4KStBOy2HbHA/Wxfe
 0o/ez/v/y/1pox8YLz/7gR9UX0n3Mrq7893MCObyDfAYeGuxOGLQkZ7pXr4A3tZDBgXph4juptA
 GzYZBl3QohLKP6GW+kTJfjTDs2bAErtuQoxeyCZmvmrZwSEgHJcCaPZxecIU25bws96ceBpfTIp
 6Haq2pqmhnc97h4UDytlKV+/e6gJww7hyShi2pTa8Rpq1Mvb6ObTyPQSOH+yIKzPEsn5B4Kpiss
 2MTx+srxV6Gv4h+rb7Vr8js1rjtpcy5sk4yOLXIY8oU5JbNAQJZJgMKZ1AtQSszJaqgtnxgMe6e
 a7OQ4jeAtD9Qb98fr/cdCAAF39sKS5CYlFb/kFcMWUKmnZ34L46oTJyFPWtuHkPyrphcD9zoApM
 VLt0Xba2fP4j20vUWb+IROwtRiFWmjEySnX4zLbndCpsM0jDMFNo01IZEuj4SAxBPNQ2kcRikhX
 4ldcEv0oF3IMrJ/t0cML1lyWJWok31dwJiEz/jrXS2DlrFuWXmGac97rPWAaHFAswsSlcJAK/Rj
 KDL5Hxiq51+l7My7fH+UglqSssKOOUJDwkl0LIdQi7CIei1qRrTg3+wMVgiKYL7qH6wdZ4DLeu0
 bzs/L0krcSDVdM9/pBSEF6wHuOsJDonJY14oZPgnHJT4ybuK4GHCFlM1T6B9KWBpRMgLQi13UOf
 oe8vH8hr3k/aGkdMo07nWpH+n5sXJXWOdMB4nBkoEMc4uqOHk9nwpqGcp5/RNMAh/CjXLEv8da+
 DtEpIlEyfRd8oepKtgZmfRy6Zb1XqNiZLec9syWlHQ=
X-Received: by 2002:a05:600c:4345:b0:489:1fa5:997f with SMTP id
 5b1f17b1804b1-48e51e1abcdmr106646895e9.9.1778237664391; 
 Fri, 08 May 2026 03:54:24 -0700 (PDT)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e642f0da6sm17100565e9.10.2026.05.08.03.54.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 03:54:23 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 May 2026 13:54:22 +0300
Message-Id: <DID8N4QWGCAM.2TUFCE4VQCX4L@linaro.org>
Cc: "Aidan" <aidan@wolfssl.com>
Subject: Re: [[PATCH v2] tpm: Add wolfTPM library support for TPM 2.0 05/12]
 tpm: add wolfTPM library as git submodule
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "David Garske" <david@wolfssl.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0
References: <20260316181447.2986278-1-david@wolfssl.com>
 <20260316181447.2986278-6-david@wolfssl.com>
In-Reply-To: <20260316181447.2986278-6-david@wolfssl.com>
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

We decided a while back to use subtress for importing external trees.
mbedTLS, dts and lwIP work as such, so please convert to a subtree.

tools/update-subtree.sh is what we use to merge the latest updates.

Regards
/Ilias

On Mon Mar 16, 2026 at 8:14 PM EET, David Garske wrote:
> From: Aidan <aidan@wolfssl.com>
>
> Add wolfTPM (https://github.com/wolfSSL/wolfTPM) as a git submodule
> at lib/wolftpm. wolfTPM is a portable, open-source TPM 2.0 stack
> licensed under GPLv2, providing native API access to all TPM 2.0
> commands and a wrapper API for common operations.
>
> The build system additions:
>
> .gitmodules:
>   Registers the wolfTPM submodule pointing to the upstream repo.
>
> lib/Kconfig:
>   Adds CONFIG_TPM_WOLF option under library routines, which selects
>   SHA1 and implies DM_RNG.
>
> lib/Makefile:
>   When CONFIG_TPM_WOLF and CONFIG_TPM_V2 are both enabled, compiles
>   wolfTPM core source files (tpm2.c, tpm2_packet.c, tpm2_tis.c,
>   tpm2_wrap.c, tpm2_param_enc.c) and the HAL layer (tpm_io.c).
>   Sets -I include paths and -DWOLFTPM_USER_SETTINGS.
>
> Signed-off-by: Aidan Garske <aidan@wolfssl.com>
> ---
>  .gitmodules  |  3 +++
>  lib/Kconfig  | 13 +++++++++++++
>  lib/Makefile | 18 ++++++++++++++++++
>  lib/wolftpm  |  1 +
>  4 files changed, 35 insertions(+)
>  create mode 100644 .gitmodules
>  create mode 160000 lib/wolftpm
>
> diff --git a/.gitmodules b/.gitmodules
> new file mode 100644
> index 00000000000..3f95a7c3eb9
> --- /dev/null
> +++ b/.gitmodules
> @@ -0,0 +1,3 @@
> +[submodule "lib/wolftpm"]
> +	path =3D lib/wolftpm
> +	url =3D https://github.com/wolfssl/wolfTPM.git
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 931d5206936..24477ea53c9 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -500,6 +500,19 @@ config TPM
>  	  If you want a fully functional TPM enable all hashing algorithms.
>  	  If you enabled measured boot all hashing algorithms are selected.
>
> +config TPM_WOLF
> +    bool "Enable wolfTPM support"
> +	depends on DM
> +	imply DM_RNG
> +	select SHA1
> +    help
> +        This option enables support for wolfTPM in U-Boot. WolfTPM can b=
e
> +		used to update ARM specific platforms. Enabling this option allows
> +		U-Boot to interact with the TPM using wolfTPM commands such as
> +		firmware updates, PCR extend, and more. It is especially useful on
> +		platforms that require support for secure boot and other TPM-related
> +		functionality.
> +
>  config SPL_TPM
>  	bool "Trusted Platform Module (TPM) Support in SPL"
>  	depends on SPL_DM
> diff --git a/lib/Makefile b/lib/Makefile
> index 70667f3728c..76025cc77d8 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_BITREVERSE) +=3D bitrev.o
>  obj-y +=3D list_sort.o
>  endif
>
> +# U-boot TPM
>  obj-$(CONFIG_$(PHASE_)TPM) +=3D tpm-common.o
>  ifeq ($(CONFIG_$(PHASE_)TPM),y)
>  obj-$(CONFIG_TPM) +=3D tpm_api.o
> @@ -64,6 +65,23 @@ obj-$(CONFIG_EFI_TCG2_PROTOCOL) +=3D tpm_tcg2.o
>  obj-$(CONFIG_MEASURED_BOOT) +=3D tpm_tcg2.o
>  endif
>
> +# wolfTPM with TPM 2.0 support (including TPM firmware update)
> +ifeq ($(CONFIG_TPM_WOLF),y)
> +ifeq ($(CONFIG_TPM_V2),y)
> +ccflags-y +=3D -I$(srctree)/lib/wolftpm \
> +             -I$(srctree)/include/configs \
> +             -DWOLFTPM_USER_SETTINGS
> +obj-y +=3D wolftpm/hal/tpm_io.o
> +obj-$(CONFIG_WOLFTPM_LINUX_DEV) +=3D wolftpm/src/tpm2_linux.o
> +obj-y +=3D wolftpm/src/tpm2.o
> +obj-y +=3D wolftpm/src/tpm2_packet.o
> +obj-y +=3D wolftpm/src/tpm2_tis.o
> +obj-y +=3D wolftpm/src/tpm2_wrap.o
> +obj-y +=3D wolftpm/src/tpm2_param_enc.o
> +obj-y +=3D wolftpm.o
> +endif
> +endif
> +
>  obj-$(CONFIG_$(PHASE_)CRC8) +=3D crc8.o
>  obj-$(CONFIG_$(PHASE_)CRC16) +=3D crc16.o
>  obj-$(CONFIG_$(PHASE_)CRC16) +=3D crc16-ccitt.o
> diff --git a/lib/wolftpm b/lib/wolftpm
> new file mode 160000
> index 00000000000..664db130d57
> --- /dev/null
> +++ b/lib/wolftpm
> @@ -0,0 +1 @@
> +Subproject commit 664db130d57bfa18a3254a0ddc126da1beeb9895

