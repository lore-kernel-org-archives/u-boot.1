Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F184C56206
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 15:18:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A38A483A5E;
	Fri, 20 Feb 2026 16:18:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L/2W0mUx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2389883A5E; Fri, 20 Feb 2026 16:18:31 +0100 (CET)
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com
 [IPv6:2607:f8b0:4864:20::a32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C539D83936
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 16:18:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-5688b639a19so874150e0c.2
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 07:18:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771600707; cv=none;
 d=google.com; s=arc-20240605;
 b=kA9uuEjRbGL5BXQt7Lhqy6T74hjuv/EdcM43/IniPAo9ioyPp918n0T2LBbQ4i5xa7
 fNYZelAoKGCQEpaX87rCJE1IxFWFpNd3ixR85/hp5qVSsggFkJ+8HrQ+LRCwjo4Gk1F0
 VFy7GjqNVnrl2TI8XAjdjnlgo5onvImwVXob4Ek94KNzr0COG1LZcCVTvfAsSXdfC+wo
 tAPteH3UUjCo0xPbYMgql2xkd9G6TYXSVJBcrRTnw5IxOv6qERDYgCixbtH6k5K/w8VF
 LL5d399PTEb8oMEHa5y6+6IqSUUQ8Yq/cxnx6bNRjC2WY8QQgpbRTkYdgOxLEg/vt7c+
 yFAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DzuSQOWvIWu8n5fXyANwmJOQZYwMGPHEusW2bNmIwOM=;
 fh=NeTHPl7ZxL8y7UUHnhc6CADN717VaVLi+lRuNJ6yeoE=;
 b=ZuVQN28UjXOMRQMcJPw1R8CDug4FLuih/qCe5F1KQ3i9qOXJUd6WzUQ4Ppz5O0CfLe
 ctQVzL1xNKwtGiRQ5t250iUTjesEY+enyuyvqGwLHNSjb1I+/F7Irpt6i5MGgzuwqp/4
 WHR5/kJyzUtwWDUIJIFuz8JvFj5OK9HF6j5lNZm+/oiw59N8vwaA0Hwy7PP4ZQrB0AEQ
 ukbO+M3g6H6piqzl+RWToq4S0k7kohS5BALyGmvXVojat+X2nMhXJlr/d0WvrEI+mSQ7
 QPS83U81ra3F2DLeBhoRRpSB+WJv4Yp2gXf20Oh0jBN41vs0JD3i+i48SbYRhWqpYFhQ
 PLJg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771600707; x=1772205507; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DzuSQOWvIWu8n5fXyANwmJOQZYwMGPHEusW2bNmIwOM=;
 b=L/2W0mUxM7+/K9rOCbVcwXAomJXVsJdAldt1hZMkYaVTIX0HG84lq5kaBh1KoHMXcD
 ZVHdvl32L6pE/7mrKrWQNboC02b8WS1erern3rXvAL0osqR9zpZgbrK4LKlXlwGjQKYG
 6kJrfytLDIHav8T8CRbiJXIjacR8HZ1y7NFD9rzQk3dAKxdp/3/bsXINSyq/iiSl9WTa
 2ytBT4IJLMpINVmiYrQqPWbApBaexJ0hrRUNFJz+nTc53+njojKJa74zZdo0xnQLxhXU
 C4wvBlXgnpsRgdiZsIdKokNb34s50BsRLzqGmoPbY0v0R3km7BK2iH75uICj8Kin3DTa
 8+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771600707; x=1772205507;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DzuSQOWvIWu8n5fXyANwmJOQZYwMGPHEusW2bNmIwOM=;
 b=AOZtrSsaZsdkxotGqjl1Z113t7IrH0jt29EqbbynKnW5qCafRgbq/0Kvy7zrmcD5jR
 Afqid7DdA3R498DgZ+iYS8G+FHgF5RNSrF57Sa30JGwebPKq8FVhFYsuKocsdDZe2OuA
 /8AKz5KqtA2lY6ioV2wV+QUWfHGGTnaJ4IRahs9GQ6+1dBpRbqdpa4v3p9G4svCzGMJy
 zkx0jEkrfZ1vOZuNxz4iyDMJqBtO5QG8/PkRmwcD+LYbG9YVIN0ITkt8VsJBRanzB9Eo
 rKqXd3OIdsDtgMJXbb2fqbJFswdnMmKiSreWvaigSNP4T5hqbCDhdejatPRfRbqbESWl
 tYWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQbQFHZxw0HhFehZhuiaNq8ZFJf6tJbt3CR+1LDFMyE9sZyiGLeOOBQEoMCjhLFBC0KaXXJ7w=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3NWmdwseciOzmjXcZpZ1VTclcXegHPFzmNkdv0gmBLX4aV6Xv
 BlAZGQi/iEDW+24nzg2R/7uVhSfOBlM+PLlZE/rSSithp6DfE4wtk8D0tVFwS5GHCPBg5Nkgg7/
 YTxQefaD2NyAueOSgwBngPAv4L39RJmI=
X-Gm-Gg: AZuq6aLK+pNLzod5hCyNLg9S0r/BuEwIFx+vY19PMN6MAk5FjiYI1QfBBPBY1TB9tNe
 LhMEdZPVbPJ/Gd4chnWhH3816bUUMqZBWrL647rDRCrcJGDTBVKkvzNp8ZyBJuquQ7TfdsqHOgk
 Ui/o2XIY1wy7/RUUSk1A3g6bYnbyNe9Q+U1BQwytoKmrKdJhqirHL8dCdQih9LA+wdmKNvN0rTr
 UUqCt2qCYIQ/XOfve6pGE+HcThnrwBOX0+izA06/puwmVEm2V+AGuAKOzCB31Uc0uluGBqHN6FY
 Qnr8myEa
X-Received: by 2002:a05:6122:32cb:b0:559:5ef5:b196 with SMTP id
 71dfb90a1353d-56889bf9467mr7345203e0c.13.1771600707376; Fri, 20 Feb 2026
 07:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20260219132552.1499698-1-philippe.reynes@softathome.com>
 <20260219132552.1499698-2-philippe.reynes@softathome.com>
In-Reply-To: <20260219132552.1499698-2-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Fri, 20 Feb 2026 10:18:15 -0500
X-Gm-Features: AaiRm53jzaXTeHlpiNZaB7d_g9T0C9L1992BzDlYXIl1DqfQpCnHYqP4f2f5ets
Message-ID: <CAMDkj5wK7H7kZ=3S_VZ3WiuTBF1LOEKE=cBvfkURLJVVhoG8OA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/9] mbedtls: enable support of ecc
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 u-boot@lists.denx.de
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

On Thu, Feb 19, 2026 at 8:26=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Enables the support of ecc in mbedtls.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - move ecdsa to MBEDTLS_LIB_X509
> - enhance depencendies
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

This should be ASN1_DECODER_MBEDTLS.


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
> index dda3f4dd6e4..7d60bcc52aa 100644
> --- a/lib/mbedtls/mbedtls_def_config.h
> +++ b/lib/mbedtls/mbedtls_def_config.h
> @@ -89,6 +89,24 @@
>  #define MBEDTLS_ASN1_WRITE_C
>  #endif
>
> +#if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)

In the 'mbedtls_def_config.h' file, we use the kconfigs without the
'_MBEDTLS' postfix.

Regards,
Raymond

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
