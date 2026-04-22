Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B05FA1FE1
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 18:16:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9610B842FC;
	Wed, 22 Apr 2026 20:16:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GrnO3l4q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9B7784312; Wed, 22 Apr 2026 20:16:10 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F84C84178
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 20:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-79ea87af213so95529127b3.0
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 11:16:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776881767; cv=none;
 d=google.com; s=arc-20240605;
 b=hXfgGrh4PR6ZAV/AocytvHwU/qq0ZDZAvJi4HuSgy86id6NFzsfNONrs83lNV04TXK
 /xyNc3HWFX4TDDUTZeCtQQ31ov7GZ9NosU0m3U+/wgNJOeQ6Z5JKaqxCOGM3+6N/LiQH
 ddeYVfpXezzyWexh0iYMcVGBBfmEWXPVe9cvp3H4dCTHaPxW5A0dptE+LHt9jvXrynfj
 ZitM+qHFVA44/8Ls8ZMGdeKppJntb2IruYfpZ0VkYYXQM24pcgJh+MlqL0GUCWcTmB3F
 BH6lW2CF/wznRLWfayEEHVhE16DC6UAkukyZgzUQNDdUEEQ7JwkZHbTjDpDgsPXrK3YB
 QaIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mb4EWD7isy7+VH3EXr5X3vFSMcd03OO7jdB4QvIN2o8=;
 fh=MTfo45vSTzKVBjZkkTJPhGIruFtJ1bW4V8M5Sxk5wKY=;
 b=jEeivfPG8ygeWpmCvMl16vjousCNc+ngiXFhUNikJ1Qv2HFelZp5rJqBDCWGuMcbBj
 SJ+ld8kPAT960W3FIc9yFVFylAThdV7HmI+cx1iu3I3L3Cbt4cFaL7aZGz073sNmf/Vm
 aR62+4Kmka2/LK+kG9hzAtN0IQQciB8yoYrPExMwIEroERliHqSmWNvxE4qN0OZZlYQX
 QyQVv8Ut/cbrT7afk+/nyEOo02eaKFrAZQaQ+yrWgtXI9+svQyYwr3/TfJmZF/2pUQLT
 pA7BNoXllKZP5d5FDznEw5oJABBRMs+KstF+Lg0S83EI6ObWUcSTesGFwSwXlYeoDxdI
 C0sw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776881767; x=1777486567; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mb4EWD7isy7+VH3EXr5X3vFSMcd03OO7jdB4QvIN2o8=;
 b=GrnO3l4qsRFjBDmwN82kuDsOOiqP58dBoatGbG/s3MfzzRdnbFylffWLlGHGDFzaKK
 bRpI2IM8KzVtWxK1l2GWP+rlW3a+EAUf6UxkD/WHILOO5mPrW0U+9YlgCqxVOU6Zanv/
 MaPWb2dkxIdQgNXwQmh95U78OCAcCCvNf9sY5iRfY0O4Pgcnr9FtU386Id2dEjvjwNfv
 p69sq8ucV1RciCwmnRZY0ptOA+ixjCFDbqw5TG4O1BkeS0P8qGhOYfKaQniusrEyIO16
 rHLQ9oKFs8EvCbXZKlDqbZJJdhKzYX/EketiJTkO6A0it0v6PiNF+6rFHL5jiAR56J36
 5syA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776881767; x=1777486567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mb4EWD7isy7+VH3EXr5X3vFSMcd03OO7jdB4QvIN2o8=;
 b=QbW/+PUaYUpw12jzNNwf0xBjhMZYgTG4pd3puoqPr0LBnCLFySngYbfbrhhHcQ2tdR
 BkFWaosCIYhvg9ZUjiNEG8rYbV8GBzk+knIlsFCddf/+R4723Q36UsRj4i6FiS8EsTD/
 z99pvpucaUalg/Sm9l7zkHyFe+syq73614Mz4C7IlHV2KlTqpCOgIeOY+l48GUlfcUNK
 yfwqZnB132l02n1Q8l5TXmM8k+N1UE6H7TKsbmaunBeH18IYg+NggMZ7atsbs3r+WPde
 Nkaho1vuY4sbiq/68U4dlV6KBVJQt7Mt26WxdA2axRxvR+V44s2rCbKAUEfWKZWEzSBC
 Lp5g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3xgIlZYpomLBg1qkhyVmXHWMsO+NWnGctG09njE7YqOqqoAzW42SS1L3yL6kufg6qBgzHnxA=@lists.denx.de
X-Gm-Message-State: AOJu0YwnvF+ZRupd0h9AcLYhnTLOazQvYoRl4/UObSlhQ7oWa8yg/Va6
 ADXZWoiEGGdJ8mQ50Xw1DwcOtN7vrBbQF0VTUatG2ZDtw1fWsS+N9KfrrwDLqZVPxxqpD/urrQx
 qytPK9l46lJ7ZYQlmXEZV/tIEpDjZQUDnxK44XyU=
X-Gm-Gg: AeBDies9fkK6vSAGgzSCPVvUkQR/69iev8EOVhLjFl6SXWWDN9qeqYab0jF91PBkzcZ
 XK4ODhL8U0OQnO9oBXFUpmJjpN11sBoA3K/uDs97vt2WES+IBYXFeNhlwIv15j8sBu/AYPmFQbu
 jfri/SKmnqkvzitTwaBIeIN7N6WY420ZX+QjMcCRSNWNgyvm5wc4lFoIsNCXYODxzfdWj3vom4E
 XoRDqyae6q9eIoxQy4Stt805zD4IRE5jUpqfkrNBv3Rb3bJl94eXmXZzVx0wMQuOQngEjT/qXIc
 wI1vuMEreWFXCeDLzJA=
X-Received: by 2002:a05:690e:1384:b0:64a:ce57:cac4 with SMTP id
 956f58d0204a3-65311b20b91mr16978202d50.24.1776881766930; Wed, 22 Apr 2026
 11:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260421210954.1170437-1-philippe.reynes@softathome.com>
 <20260421210954.1170437-3-philippe.reynes@softathome.com>
In-Reply-To: <20260421210954.1170437-3-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Wed, 22 Apr 2026 14:15:55 -0400
X-Gm-Features: AQROBzC9ddiPN87BuiBb4ZzpZ_k99chZ3aEG05dqg4K2xVGieV2t0gofRCKrzj0
Message-ID: <CAMDkj5zdKyHMFgshNxOLVeDSE1+V4sHzLEB=YNvvdPempc6iuQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/15] mbedtls: enable support of ecc
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 simon.glass@canonical.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Philippe,

On Tue, Apr 21, 2026 at 5:10=E2=80=AFPM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Enables the support of ecc in mbedtls.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - move ecdsa to MBEDTLS_LIB_X509
> - enhance depencendies
> v3:
> - do not use _MBEDTLS in mbedtls_def_config.h
> v4:
> - do not select ECDSA on some configs
> - remove duplicated MBEDTLS_ECP_DP_SECP256K1_ENABLED
> - change dependencies for ECDSA configs
> v5:
> - MBEDTLS_LIB_TLS depends en ECDSA_MBEDTLS
> - update some configs according to previous change
> - build of ecdsa is conditionned by ECDSA_MBEDTLS
>
>  configs/amd_versal2_virt_defconfig       |  3 +++
>  configs/qemu_arm64_lwip_defconfig        |  3 +++
>  configs/sandbox_defconfig                |  1 +
>  configs/starfive_visionfive2_defconfig   |  3 +++
>  configs/xilinx_versal_net_virt_defconfig |  3 +++
>  configs/xilinx_versal_virt_defconfig     |  3 +++
>  configs/xilinx_zynqmp_kria_defconfig     |  3 +++
>  configs/xilinx_zynqmp_virt_defconfig     |  3 +++
>  lib/ecdsa/Kconfig                        |  1 +
>  lib/mbedtls/Kconfig                      | 14 ++++++++++++++
>  lib/mbedtls/Makefile                     | 16 +++++++++-------
>  lib/mbedtls/mbedtls_def_config.h         | 17 +++++++++++++++++
>  12 files changed, 63 insertions(+), 7 deletions(-)
>
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_vir=
t_defconfig
> index 0f4b75c72e1..cbc0789d5b3 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -167,6 +167,9 @@ CONFIG_VIRTIO_MMIO=3Dy
>  CONFIG_VIRTIO_NET=3Dy
>  CONFIG_VIRTIO_BLK=3Dy
>  CONFIG_MBEDTLS_LIB=3Dy
> +CONFIG_ECDSA_MBEDTLS=3Dy
> +CONFIG_ECDSA=3Dy
> +CONFIG_ECDSA_VERIFY=3Dy
>  CONFIG_TPM=3Dy
>  # CONFIG_OPTEE_LIB is not set
>  CONFIG_TOOLS_MKFWUMDATA=3Dy
> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_=
defconfig
> index a974970c3d3..151506eaca2 100644
> --- a/configs/qemu_arm64_lwip_defconfig
> +++ b/configs/qemu_arm64_lwip_defconfig
> @@ -3,6 +3,9 @@
>  CONFIG_ARM=3Dy
>  CONFIG_ARCH_QEMU=3Dy
>
> +CONFIG_ECDSA=3Dy
> +CONFIG_ECDSA_VERIFY=3Dy
> +CONFIG_ECDSA_MBEDTLS=3Dy
>  CONFIG_NET_LWIP=3Dy
>  CONFIG_CMD_DNS=3Dy
>  CONFIG_CMD_NFS=3Dy
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index f26295103f1..15831dd7e04 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -391,6 +391,7 @@ CONFIG_PANIC_HANG=3Dy
>  CONFIG_CMD_DHRYSTONE=3Dy
>  CONFIG_MBEDTLS_LIB=3Dy
>  CONFIG_HKDF_MBEDTLS=3Dy
> +CONFIG_ECDSA_MBEDTLS=3Dy
>  CONFIG_ECDSA=3Dy
>  CONFIG_ECDSA_VERIFY=3Dy
>  CONFIG_RSASSA_PSS=3Dy
> diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_vi=
sionfive2_defconfig
> index 74a24dfd074..77b3146f6cb 100644
> --- a/configs/starfive_visionfive2_defconfig
> +++ b/configs/starfive_visionfive2_defconfig
> @@ -156,3 +156,6 @@ CONFIG_USB_GADGET=3Dy
>  CONFIG_WDT=3Dy
>  CONFIG_WDT_STARFIVE=3Dy
>  CONFIG_MBEDTLS_LIB=3Dy
> +CONFIG_ECDSA_MBEDTLS=3Dy
> +CONFIG_ECDSA=3Dy
> +CONFIG_ECDSA_VERIFY=3Dy
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_ve=
rsal_net_virt_defconfig
> index 3410b874a04..90c04b98e0d 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -155,4 +155,7 @@ CONFIG_VIRTIO_MMIO=3Dy
>  CONFIG_VIRTIO_NET=3Dy
>  CONFIG_VIRTIO_BLK=3Dy
>  CONFIG_MBEDTLS_LIB=3Dy
> +CONFIG_ECDSA_MBEDTLS=3Dy
> +CONFIG_ECDSA=3Dy
> +CONFIG_ECDSA_VERIFY=3Dy
>  CONFIG_TPM=3Dy
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal=
_virt_defconfig
> index d5d60d7f87d..bd3e368d1b4 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -170,5 +170,8 @@ CONFIG_VIRTIO_MMIO=3Dy
>  CONFIG_VIRTIO_NET=3Dy
>  CONFIG_VIRTIO_BLK=3Dy
>  CONFIG_MBEDTLS_LIB=3Dy
> +CONFIG_ECDSA_MBEDTLS=3Dy
> +CONFIG_ECDSA=3Dy
> +CONFIG_ECDSA_VERIFY=3Dy
>  CONFIG_TPM=3Dy
>  CONFIG_TOOLS_MKFWUMDATA=3Dy
> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp=
_kria_defconfig
> index 72a4668b448..7a741416685 100644
> --- a/configs/xilinx_zynqmp_kria_defconfig
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -221,6 +221,9 @@ CONFIG_VIRTIO_BLK=3Dy
>  CONFIG_BINMAN_DTB=3D"./arch/arm/dts/zynqmp-binman-som.dtb"
>  CONFIG_PANIC_HANG=3Dy
>  CONFIG_MBEDTLS_LIB=3Dy
> +CONFIG_ECDSA_MBEDTLS=3Dy
> +CONFIG_ECDSA=3Dy
> +CONFIG_ECDSA_VERIFY=3Dy
>  CONFIG_TPM=3Dy
>  CONFIG_SPL_GZIP=3Dy
>  CONFIG_TOOLS_MKFWUMDATA=3Dy
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp=
_virt_defconfig
> index 1433b63979a..7dd73c48c1b 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -239,6 +239,9 @@ CONFIG_VIRTIO_BLK=3Dy
>  CONFIG_BINMAN_DTB=3D"./arch/arm/dts/zynqmp-binman.dtb"
>  CONFIG_PANIC_HANG=3Dy
>  CONFIG_MBEDTLS_LIB=3Dy
> +CONFIG_ECDSA_MBEDTLS=3Dy
> +CONFIG_ECDSA=3Dy
> +CONFIG_ECDSA_VERIFY=3Dy
>  CONFIG_TPM=3Dy
>  CONFIG_SPL_GZIP=3Dy
>  CONFIG_TOOLS_MKFWUMDATA=3Dy
> diff --git a/lib/ecdsa/Kconfig b/lib/ecdsa/Kconfig
> index ca13b6bfa1f..dac8bcf23dd 100644
> --- a/lib/ecdsa/Kconfig
> +++ b/lib/ecdsa/Kconfig
> @@ -1,6 +1,7 @@
>  config ECDSA
>         bool "Enable ECDSA support"
>         depends on DM
> +       select ASN1_DECODER
>         help
>           This enables the ECDSA (elliptic curve signature) algorithm for=
 FIT
>           image verification in U-Boot. The ECDSA algorithm is implemente=
d
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index 789721ee6cd..e948a8876f6 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -247,6 +247,9 @@ config MBEDTLS_LIB_X509
>
>  if MBEDTLS_LIB_X509
>
> +config BIGNUM_MBEDTLS
> +       bool
> +
>  config ASN1_DECODER_MBEDTLS
>         bool "ASN1 decoder with MbedTLS certificate library"
>         depends on MBEDTLS_LIB_X509 && ASN1_DECODER
> @@ -264,6 +267,7 @@ config RSA_PUBLIC_KEY_PARSER_MBEDTLS
>         bool "RSA public key parser with MbedTLS certificate library"
>         depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
>         select ASN1_DECODER_MBEDTLS
> +       select BIGNUM_MBEDTLS
>         help
>           This option chooses MbedTLS certificate library for RSA public =
key
>           parser.
> @@ -292,6 +296,15 @@ config MSCODE_PARSER_MBEDTLS
>           This option chooses MbedTLS certificate library for MS authenti=
code
>           parser.
>
> +config ECDSA_MBEDTLS
> +       bool "Enable ECDSA support with MbedTLS certificate library"
> +       depends on MBEDTLS_LIB_X509 && ECDSA_VERIFY
> +       select ASN1_DECODER_MBEDTLS if ASN1_DECODER
> +       select BIGNUM_MBEDTLS
> +       help
> +         This option enables support of ECDSA with the MbedTLS certifica=
te
> +         library.
> +
>  endif # MBEDTLS_LIB_X509
>
>  config MBEDTLS_LIB_TLS
> @@ -300,6 +313,7 @@ config MBEDTLS_LIB_TLS
>         depends on X509_CERTIFICATE_PARSER_MBEDTLS
>         depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
>         depends on ASN1_DECODER_MBEDTLS
> +       depends on ECDSA_MBEDTLS

ecdsa is not mandatory for TLS. so this dependency is not correct.

Regards,
Raymond

>         depends on MBEDTLS_LIB
>         help
>           Enable MbedTLS TLS library. Required for HTTPs support
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index c5b445bd85c..a24c8389744 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -39,13 +39,20 @@ mbedtls_lib_crypto-$(CONFIG_$(PHASE_)HKDF_MBEDTLS) +=
=3D \
>  # MbedTLS X509 library
>  obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_X509) +=3D mbedtls_lib_x509.o
>  mbedtls_lib_x509-y :=3D $(MBEDTLS_LIB_DIR)/x509.o
> +mbedtls_lib_x509-$(CONFIG_$(PHASE_)ECDSA_MBEDTLS) +=3D \
> +       $(MBEDTLS_LIB_DIR)/ecdsa.o \
> +       $(MBEDTLS_LIB_DIR)/ecp.o \
> +       $(MBEDTLS_LIB_DIR)/ecp_curves.o \
> +       $(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
> +       $(MBEDTLS_LIB_DIR)/pk_ecc.o
> +mbedtls_lib_x509-$(CONFIG_$(PHASE_)BIGNUM_MBEDTLS) +=3D \
> +       $(MBEDTLS_LIB_DIR)/bignum.o \
> +       $(MBEDTLS_LIB_DIR)/bignum_core.o
>  mbedtls_lib_x509-$(CONFIG_$(PHASE_)ASN1_DECODER_MBEDTLS) +=3D \
>         $(MBEDTLS_LIB_DIR)/asn1parse.o \
>         $(MBEDTLS_LIB_DIR)/asn1write.o \
>         $(MBEDTLS_LIB_DIR)/oid.o
>  mbedtls_lib_x509-$(CONFIG_$(PHASE_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) +=3D \
> -       $(MBEDTLS_LIB_DIR)/bignum.o \
> -       $(MBEDTLS_LIB_DIR)/bignum_core.o \
>         $(MBEDTLS_LIB_DIR)/rsa.o \
>         $(MBEDTLS_LIB_DIR)/rsa_alt_helpers.o
>  mbedtls_lib_x509-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) +=3D \
> @@ -64,7 +71,6 @@ mbedtls_lib_tls-y :=3D \
>         $(MBEDTLS_LIB_DIR)/mps_reader.o \
>         $(MBEDTLS_LIB_DIR)/mps_trace.o \
>         $(MBEDTLS_LIB_DIR)/net_sockets.o \
> -       $(MBEDTLS_LIB_DIR)/pk_ecc.o \
>         $(MBEDTLS_LIB_DIR)/ssl_cache.o \
>         $(MBEDTLS_LIB_DIR)/ssl_ciphersuites.o \
>         $(MBEDTLS_LIB_DIR)/ssl_client.o \
> @@ -82,8 +88,4 @@ mbedtls_lib_tls-y :=3D \
>         $(MBEDTLS_LIB_DIR)/cipher.o \
>         $(MBEDTLS_LIB_DIR)/cipher_wrap.o \
>         $(MBEDTLS_LIB_DIR)/ecdh.o \
> -       $(MBEDTLS_LIB_DIR)/ecdsa.o \
> -       $(MBEDTLS_LIB_DIR)/ecp.o \
> -       $(MBEDTLS_LIB_DIR)/ecp_curves.o \
> -       $(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
>         $(MBEDTLS_LIB_DIR)/gcm.o \
> diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_c=
onfig.h
> index dda3f4dd6e4..d1bbcaa0924 100644
> --- a/lib/mbedtls/mbedtls_def_config.h
> +++ b/lib/mbedtls/mbedtls_def_config.h
> @@ -89,6 +89,23 @@
>  #define MBEDTLS_ASN1_WRITE_C
>  #endif
>
> +#if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
> +#define MBEDTLS_ECDSA_C
> +#define MBEDTLS_ECP_C
> +#define MBEDTLS_BIGNUM_C
> +#define MBEDTLS_ECP_DP_SECP192R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP224R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP256R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP384R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP521R1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP192K1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP224K1_ENABLED
> +#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
> +#define MBEDTLS_ECP_DP_BP256R1_ENABLED
> +#define MBEDTLS_ECP_DP_BP384R1_ENABLED
> +#define MBEDTLS_ECP_DP_BP512R1_ENABLED
> +#endif
> +
>  #endif /* #if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
>
>  #if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS)
> --
> 2.43.0
>
