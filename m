Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A855109B48C
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 15:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F147083DA6;
	Tue, 31 Mar 2026 17:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UZCYVif1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C10A183E7A; Tue, 31 Mar 2026 17:30:28 +0200 (CEST)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF46E83A41
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 17:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-56d8a5f0e44so5905e0c.1
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 08:30:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774971025; cv=none;
 d=google.com; s=arc-20240605;
 b=bqZCG275Jfc84fu2HY/qFers7h1G4QPCEIKn/aKtMqfBc+2eJ0crlB/qros7LyBhTn
 vEH+Dngx1C1S6foeUDTXNzKVI/kWOifLlZFZh0He2aDlzwm0ou2LfmzJ7C7Uf3PflAZb
 ex2nPzgmbUR1KRmyUGsOFQa3c+221HjHqtmoNKTAT2Oxq3hXFdyUL51bGjvnlXzO3uLG
 YwhA3ggvn/iMxkdtIIi0qSn/hS0Lks+mXf7Ar/vWKhflkyzM5PT1XaMah62WCPl/fxp0
 uoGKAIGU+Hpn0JlSLiwT+RihH1e0VDjwPEWTSUcuVgmKlfDowaHgAe6CUc2rb6TXSDcA
 07SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=K31Eniwp2zpYZm6BRGcjukKk5/MdknEXxEkvE+0PcHk=;
 fh=TXx3CT6oZMv5MJhQVhvCutmyA2K+EAEsoB5O9x64J70=;
 b=BqquFzeCU9K2Y7gCiVSP/iGiFUXNWt9ksFHzLzPC1MUe051Ued4/HnAOuyQ8u4LTGF
 ZJQP0HiddmZKLw3FMSn5slg8QqbXO7Fmtfw3V7ubuil9+sm6pdiUE3HDsRyo+R+unKqn
 l5NpRzZlvCyLyxpNXLREkoknrrOVoULPPN0Av85GfBoMQlF842qFd33nb90+4SN2qaT7
 1sDt/A/1Yx9P5/l7a3dniFwppe/j7MQ2ompQaJq9KZBMz0RGpCDTqdMVZQ2cEw+dc/oO
 PNioXDfM37BemqK11nEFjLlB+yZ6H1mrhG/z9Eao5nT+9hgbSl2Ac8OKFlpgXV1UbK+s
 zBNA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774971025; x=1775575825; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K31Eniwp2zpYZm6BRGcjukKk5/MdknEXxEkvE+0PcHk=;
 b=UZCYVif1B4lyZn0jnsTkoBfEWzyzQ3zcbhILQBsq/V+59xbbPHMjRE9Zb5oZNkbP4v
 SAG/TVH4aUPbk0owhDtxTv7pV3EFnD5I23HZH9rpP/uEo1MdQ/8Yswo7rA8tKnr1KFTB
 NWzW4KiVwr9jBAq99gojJ15jBNu1FTzbwxSeTPSyGG+C8HFqAr0qMvH5xM7GQVdpm1Y/
 WqhhO11G7KS1HoLXvYq0V64yAc5hTi7MwfRn2GoLUDCybfUZX22by2wHGe08qh6HUvtc
 WuzO8XTV+wnK6cSXNpvEwUZIvYLMBGM58Td8PcuTn/lSHou2pnI6W8f5xhFSX97xvFoN
 kpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774971025; x=1775575825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K31Eniwp2zpYZm6BRGcjukKk5/MdknEXxEkvE+0PcHk=;
 b=CdNGIQFO7YLcETkClqLHzcF9IgU1m+eSjVdiJItQRLf8/GI/hIe2wjQUZyRBZOjAQo
 Pah2oqdYbkUENl1RKwP4e+Xcfyc1ciHCXGg4pw4n3HK5AcvfV6owulDeOLlQ/FSztC51
 BnqtnwRMnY0cyR7NausW5NYPMdQKTFSilbXTFA8z17h9t0nP9AIfvkjzMuBza3jwQdmG
 BFU3udWl4YPEhEVWcBEDEUA/nB+ULY51Y1fuqL9M7iuITktWbiwZlqixPgI4XD/1rssG
 c1WReb7sgnUvmyH4WPARbiSzFSOHzKFcvxuFPH53EV8NE5hoHo4ejVF/3fkO5LtwyrIl
 PO/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyiP0CeR+qUxPj/MDQ8v7d6GkpOlBbwY9d+RyUEpqL+ErYSPIoZjvJkEz5pE+BBjUdnpZmZZ4=@lists.denx.de
X-Gm-Message-State: AOJu0YwkFRZGdtIqN9TE7txDlnZoXyoA3BqXzH5oZlg0o4U7YjSpZvVL
 O97qK0aavQqdqyMU7GPsaYgu4gW98IwH1TS7xMuVm+vn6RYrlTqD8e2vIf9RS/HxVX702BGPeyy
 RSVULpLIH6eXcN5oft9J4/HbY8YQdG4kGciv2
X-Gm-Gg: ATEYQzw2gRSLisX1YUhdMZtbz5R/IjC75nOs51Xfd6qAcOOZtt97O3mZ34/+oTKkWPk
 m0dR3vDOM8gukJM1jg/xVFkAVeYkQHOyN9FIKUXiOFLYd4qULLDU0u/wA1SbjVHeBrJS24PfB02
 kEDCbCAlk7M6e8w4VZqpL01P0eYADCde9QrpRrNRQ7tWKBpf6IBaarz+Qx7eeTLu8H0g45ApXYk
 oq2yjh8lI+4TuyDA9HEZ7RJKZN2T5kybDH6uB0Gh5KVY0qTyjDajzhgdyS5D6ILCXiwlwvEDF6j
 8xo2GUMpKHgumTSg9aE=
X-Received: by 2002:a05:6102:6895:b0:5dd:c53b:75cc with SMTP id
 ada2fe7eead31-6054fe3e47fmr1645748137.13.1774971024618; Tue, 31 Mar 2026
 08:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
 <20260331100047.34618-2-philippe.reynes@softathome.com>
In-Reply-To: <20260331100047.34618-2-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Tue, 31 Mar 2026 11:30:13 -0400
X-Gm-Features: AQROBzA3au3Kq4hBLpeFvZFefig5s1PBJrLVndaYyJ3fOekqjyFl5p8HpTedcK4
Message-ID: <CAMDkj5wQDhKWJNZoZTxv2vF6LkXjxsh9-6CT=0-MiCXmo6U8dA@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] mbedtls: enable support of ecc
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

On Tue, Mar 31, 2026 at 6:00=E2=80=AFAM Philippe Reynes
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
>
>  configs/amd_versal2_virt_defconfig       |  1 +
>  configs/qemu_arm64_lwip_defconfig        |  1 +
>  configs/starfive_visionfive2_defconfig   |  1 +
>  configs/xilinx_versal_net_virt_defconfig |  1 +
>  configs/xilinx_versal_virt_defconfig     |  1 +
>  configs/xilinx_zynqmp_kria_defconfig     |  1 +
>  configs/xilinx_zynqmp_virt_defconfig     |  1 +
>  lib/mbedtls/Kconfig                      | 16 ++++++++++++++++
>  lib/mbedtls/Makefile                     | 16 +++++++++-------
>  lib/mbedtls/mbedtls_def_config.h         | 18 ++++++++++++++++++
>  10 files changed, 50 insertions(+), 7 deletions(-)
>
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_vir=
t_defconfig
> index 0344089030c..702bf28405d 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -164,6 +164,7 @@ CONFIG_VIRTIO_MMIO=3Dy
>  CONFIG_VIRTIO_NET=3Dy
>  CONFIG_VIRTIO_BLK=3Dy
>  CONFIG_MBEDTLS_LIB=3Dy
> +CONFIG_ECDSA=3Dy
>  CONFIG_TPM=3Dy
>  # CONFIG_OPTEE_LIB is not set
>  CONFIG_TOOLS_MKFWUMDATA=3Dy
> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_=
defconfig
> index a974970c3d3..ab6302b67eb 100644
> --- a/configs/qemu_arm64_lwip_defconfig
> +++ b/configs/qemu_arm64_lwip_defconfig
> @@ -11,3 +11,4 @@ CONFIG_CMD_WGET=3Dy
>  CONFIG_EFI_HTTP_BOOT=3Dy
>  CONFIG_WGET_HTTPS=3Dy
>  CONFIG_WGET_CACERT=3Dy
> +CONFIG_ECDSA=3Dy
> diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_vi=
sionfive2_defconfig
> index a754134a313..508bd465704 100644
> --- a/configs/starfive_visionfive2_defconfig
> +++ b/configs/starfive_visionfive2_defconfig
> @@ -156,3 +156,4 @@ CONFIG_USB_GADGET=3Dy
>  CONFIG_WDT=3Dy
>  CONFIG_WDT_STARFIVE=3Dy
>  CONFIG_MBEDTLS_LIB=3Dy
> +CONFIG_ECDSA=3Dy
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_ve=
rsal_net_virt_defconfig
> index 323b5606566..8b760beab03 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -154,4 +154,5 @@ CONFIG_VIRTIO_MMIO=3Dy
>  CONFIG_VIRTIO_NET=3Dy
>  CONFIG_VIRTIO_BLK=3Dy
>  CONFIG_MBEDTLS_LIB=3Dy
> +CONFIG_ECDSA=3Dy
>  CONFIG_TPM=3Dy
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal=
_virt_defconfig
> index 652121e27a0..6dd8620cf51 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -168,5 +168,6 @@ CONFIG_VIRTIO_MMIO=3Dy
>  CONFIG_VIRTIO_NET=3Dy
>  CONFIG_VIRTIO_BLK=3Dy
>  CONFIG_MBEDTLS_LIB=3Dy
> +CONFIG_ECDSA=3Dy
>  CONFIG_TPM=3Dy
>  CONFIG_TOOLS_MKFWUMDATA=3Dy
> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp=
_kria_defconfig
> index 8ad05e37189..d23452e96d0 100644
> --- a/configs/xilinx_zynqmp_kria_defconfig
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -219,6 +219,7 @@ CONFIG_VIRTIO_BLK=3Dy
>  CONFIG_BINMAN_DTB=3D"./arch/arm/dts/zynqmp-binman-som.dtb"
>  CONFIG_PANIC_HANG=3Dy
>  CONFIG_MBEDTLS_LIB=3Dy
> +CONFIG_ECDSA=3Dy
>  CONFIG_TPM=3Dy
>  CONFIG_SPL_GZIP=3Dy
>  CONFIG_TOOLS_MKFWUMDATA=3Dy
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp=
_virt_defconfig
> index bb79ddf989e..01370a215d4 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -237,6 +237,7 @@ CONFIG_VIRTIO_BLK=3Dy
>  CONFIG_BINMAN_DTB=3D"./arch/arm/dts/zynqmp-binman.dtb"
>  CONFIG_PANIC_HANG=3Dy
>  CONFIG_MBEDTLS_LIB=3Dy
> +CONFIG_ECDSA=3Dy
>  CONFIG_TPM=3Dy
>  CONFIG_SPL_GZIP=3Dy
>  CONFIG_TOOLS_MKFWUMDATA=3Dy
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index 789721ee6cd..8bf8809198f 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -242,11 +242,16 @@ config MBEDTLS_LIB_X509
>         select X509_CERTIFICATE_PARSER_MBEDTLS if X509_CERTIFICATE_PARSER
>         select PKCS7_MESSAGE_PARSER_MBEDTLS if PKCS7_MESSAGE_PARSER
>         select MSCODE_PARSER_MBEDTLS if MSCODE_PARSER
> +       select ECDSA_MBEDTLS if ECDSA
>         help
>           Enable MbedTLS certificate libraries.
>
>  if MBEDTLS_LIB_X509
>
> +config BIGNUM_MBEDTLS
> +       bool
> +       default n
> +
>  config ASN1_DECODER_MBEDTLS
>         bool "ASN1 decoder with MbedTLS certificate library"
>         depends on MBEDTLS_LIB_X509 && ASN1_DECODER
> @@ -264,6 +269,7 @@ config RSA_PUBLIC_KEY_PARSER_MBEDTLS
>         bool "RSA public key parser with MbedTLS certificate library"
>         depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
>         select ASN1_DECODER_MBEDTLS
> +       select BIGNUM_MBEDTLS
>         help
>           This option chooses MbedTLS certificate library for RSA public =
key
>           parser.
> @@ -292,6 +298,15 @@ config MSCODE_PARSER_MBEDTLS
>           This option chooses MbedTLS certificate library for MS authenti=
code
>           parser.
>
> +config ECDSA_MBEDTLS
> +       bool "Enable ECDSA support with MbedTLS certificate library"
> +       depends on MBEDTLS_LIB_X509
> +       select ASN1_DECODER

As I replied in your V2 thread, it is better to depend/select only
_MBEDTLS switches here, and let ECDSA select the common one, for
example:

config ECDSA
select ASN1_DECODER

config MBEDTLS_LIB_X509
select ASN1_DECODER_MBEDTLS if ASN1_DECODER

Regards,
Raymond

> +       select BIGNUM_MBEDTLS
> +       help
> +         This option enables support of ECDSA with the MbedTLS certifica=
te
> +         library.
> +
>  endif # MBEDTLS_LIB_X509
>
>  config MBEDTLS_LIB_TLS
> @@ -301,6 +316,7 @@ config MBEDTLS_LIB_TLS
>         depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
>         depends on ASN1_DECODER_MBEDTLS
>         depends on MBEDTLS_LIB
> +       depends on ECDSA_MBEDTLS
>         help
>           Enable MbedTLS TLS library. Required for HTTPs support
>           in wget
> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> index c5b445bd85c..5433e17cc64 100644
> --- a/lib/mbedtls/Makefile
> +++ b/lib/mbedtls/Makefile
> @@ -39,13 +39,14 @@ mbedtls_lib_crypto-$(CONFIG_$(PHASE_)HKDF_MBEDTLS) +=
=3D \
>  # MbedTLS X509 library
>  obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_X509) +=3D mbedtls_lib_x509.o
>  mbedtls_lib_x509-y :=3D $(MBEDTLS_LIB_DIR)/x509.o
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
> @@ -57,6 +58,12 @@ mbedtls_lib_x509-$(CONFIG_$(PHASE_)X509_CERTIFICATE_PA=
RSER_MBEDTLS) +=3D \
>         $(MBEDTLS_LIB_DIR)/x509_crt.o
>  mbedtls_lib_x509-$(CONFIG_$(PHASE_)PKCS7_MESSAGE_PARSER_MBEDTLS) +=3D \
>         $(MBEDTLS_LIB_DIR)/pkcs7.o
> +mbedtls_lib_x509-$(CONFIG_$(PHASE_)ECDSA_MBEDTLS) +=3D \
> +       $(MBEDTLS_LIB_DIR)/ecdsa.o \
> +       $(MBEDTLS_LIB_DIR)/ecp.o \
> +       $(MBEDTLS_LIB_DIR)/ecp_curves.o \
> +       $(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
> +       $(MBEDTLS_LIB_DIR)/pk_ecc.o
>
>  #mbedTLS TLS support
>  obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_TLS) +=3D mbedtls_lib_tls.o
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
> index dda3f4dd6e4..0c8449afe6a 100644
> --- a/lib/mbedtls/mbedtls_def_config.h
> +++ b/lib/mbedtls/mbedtls_def_config.h
> @@ -89,6 +89,24 @@
>  #define MBEDTLS_ASN1_WRITE_C
>  #endif
>
> +#if CONFIG_IS_ENABLED(ECDSA)
> +#define MBEDTLS_ECDSA_C
> +#define MBEDTLS_ECP_C
> +#define MBEDTLS_BIGNUM_C
> +#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
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
