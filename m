Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF778109B47B
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 15:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DCC483DA6;
	Tue, 31 Mar 2026 17:02:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bRo71q/H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EA8C83DA7; Tue, 31 Mar 2026 17:02:07 +0200 (CEST)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C88583A41
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 17:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-953ac1602f8so1912804241.1
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 08:02:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774969322; cv=none;
 d=google.com; s=arc-20240605;
 b=H2WKpm7ZhGx92vB/HcRdlJOheJPa8/lVmuYA4y0jtCVwtKomHZwt4CJknSiPGyKejH
 SHd0LlWq01aw0WsL96FE5RMtSd3Y/l79jz+ak0lX+cCKT8+0GC0f2YnFmJFtn4+NJnmd
 xUQeydwvUwa0bbYtu3nDE0nMK7JgotVsKKPlqvDpGwz076v9v2MlpXqKiDUL6MUd0ce+
 9DPWuAAS/DiiI6Y5BaZVK8yTkTZss6Laa+kJZenBsN8ngRhSUtITYm9DsPwwW8pUXvA2
 saBrIVg8GuZqDLK75oACY7PyW8yFlNFqGWUOIaSpJyewZ4X6cEAStqk5Tx73lhE2yQSb
 2fZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gW8wuDXokXC6TtjcczgYGWUYccskpLOLBqyh0va5/1Y=;
 fh=QAit75i6yuJ9dZohpRHqTTeeT9tlSpK3VWLSPiUUb2o=;
 b=Cv7+UqtCRyPjLVaW03+zgG3jM4Bgf7Q6b3jjuOXh+6C/zb6gHJem4C6myLcIPTACi0
 0T73+7BIXX77zkRrktYM+MCUim7yrY8qasgVzApbzd/dyzbWe1KsUrxM6cogkK+PPZFD
 nX1yz/tJAWUVYQy15KPyH+UWT4k1eFBLQnKWNZuQRifmR+bnOaEfOiVA5ACKnYUzAz6B
 rQyG5tZM5gGMGSjcOXZVla3oglCyrAf49ZT9xniY3e+h7lNX1B/ONathGfQ5NHGSeoXn
 0fEyPhX5lHxApJJBaqqrw4K93hhD5QX7pG5EgGJefrQdl9nVdKQQDV2szbaJyLN/1iDB
 5UlA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774969322; x=1775574122; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gW8wuDXokXC6TtjcczgYGWUYccskpLOLBqyh0va5/1Y=;
 b=bRo71q/HCrzZ8plkojd5cTnMkW+wPIQuFxBdaVsVtMJaWybg8/vZvPhARi0yakTSye
 EhnETg+QPxAYziJk3oDbSwdg31utI23VqMeIjPG99ddEDkSRUmgounr0SaepBfKJIx+v
 DlvdjUhSdSRhvG3RGJrufkIHW+L3iq3PdkS30gy7VI7+vhAH1xOUm3PAJU+PxJl2R4C3
 oK0w69CrTGv8nUkUSCoLbPeTnDLYM9y3AahUeXFF4wgOCJgCTUfu1d2iN/7DiLNdrGnX
 udx9bsP7rCoOiCuJl/hj0nWLJ1rY+bXRMiR99MsOlD3IjZ8bYj4OEnoMKZcCgCtM3T3j
 vMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774969322; x=1775574122;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gW8wuDXokXC6TtjcczgYGWUYccskpLOLBqyh0va5/1Y=;
 b=N1e04Dcyy9wijYT3IIWvsFXUq6UgpsATb1uSHdlavJ+AfQO4SNmviyOQ82GdoE5vTp
 MApxmDxftbJ9iIQLq9eKj5XLpvINWjpWtZFjd808LU2W0JsItmgD8sTUMLDu6idctxJf
 zuY0IOyx07WuQRq/LpBrxQCZC0Xawi5CnHgB5WdjqSk67HwHWfNzraYius9KbacY3lCx
 KsoU98KgWtI7F0cZeodUP7FygGOG2yxblCMfvSpXnvhEf4EDQxi4zEcfOsO6j/H4JHO1
 ue6cWB6S5O/TTsrql+RcxRqDdmWWVmdqYn/eLHCzP3p2DgDLjJ8erj1TKb6KZ8pbtjU/
 TSJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwarNbcq/inwX98kAHJWuGte5D95h/KDAamzQY6ED8z2IcvWHx0zpQrG6oEZVx2gjTjaTjL9Q=@lists.denx.de
X-Gm-Message-State: AOJu0YxB/bsyzIVrdUJeTYtDxMAbkIgBuINzeacTP442ufTlLF5roT+V
 jM90OxQYFOhnCLafgeDgCbIMisurOI53Ks+jx7MM9jIEdrXcMjUzGMR/DkP1sge5MXwmh0ouyVs
 nYQPw7ZcygetasFWdeMl31n9wwvUDmsk=
X-Gm-Gg: ATEYQzzbtL1px4Dv4sg8a8PjbZZ9ocFnoJaUxb09etRvEup3obMmMmVrFI/9bKn9x1/
 iF0LEmcBghSuGWm0eiSqEJ5jjIFDd3eQAQHAQRcSC2E4EbjzFowvpOL4uTsVifQHLFlPwvITsRn
 Ahf921dhZmOvP6PYrm/2bU/X0h3LElbDiSUC/ZhcRmXzRHzT1qk9BJfgvfB+4GoOl3+I/El0+Qy
 KQUszBJP3Xbvq4hwW5HntYEa4fNsOYaVd4cSf2rXZgT1YW/5g/iXpGXFVsDb9T7McQpL5AqB0P6
 qoE/d0fu
X-Received: by 2002:a05:6102:3c86:b0:5db:d36c:89d4 with SMTP id
 ada2fe7eead31-6054fce17ccmr1326289137.3.1774969321473; Tue, 31 Mar 2026
 08:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260219132552.1499698-1-philippe.reynes@softathome.com>
 <20260219132552.1499698-2-philippe.reynes@softathome.com>
 <CAMDkj5wK7H7kZ=3S_VZ3WiuTBF1LOEKE=cBvfkURLJVVhoG8OA@mail.gmail.com>
 <5bfa6dbd-92f3-4aea-b248-b1696f064d5a@softathome.com>
In-Reply-To: <5bfa6dbd-92f3-4aea-b248-b1696f064d5a@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Tue, 31 Mar 2026 11:01:49 -0400
X-Gm-Features: AQROBzCgBXL_jCQ6GE9bsJwV6RHKW_yZO1gnCbqlnLr3dvafuCbw2I5iFKDGrS4
Message-ID: <CAMDkj5yfQrMWGWQ4Z_6fKc2LQM3Q-5VWaPPC=pfbNq0rhZuueA@mail.gmail.com>
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

On Tue, Mar 31, 2026 at 9:00=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Hi Raymond,
>
>
> Sorry for this very later answer.
>
>
> Le 20/02/2026 =C3=A0 16:18, Raymond Mao a =C3=A9crit :
> > This Mail comes from Outside of SoftAtHome: Do not answer, click links =
or open attachments unless you recognize the sender and know the content is=
 safe.
> >
> > Hi Philippe,
> >
> > On Thu, Feb 19, 2026 at 8:26=E2=80=AFAM Philippe Reynes
> > <philippe.reynes@softathome.com> wrote:
> >> Enables the support of ecc in mbedtls.
> >>
> >> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> >> ---
> >> v2:
> >> - move ecdsa to MBEDTLS_LIB_X509
> >> - enhance depencendies
> >>
> >>   configs/amd_versal2_virt_defconfig       |  1 +
> >>   configs/qemu_arm64_lwip_defconfig        |  1 +
> >>   configs/starfive_visionfive2_defconfig   |  1 +
> >>   configs/xilinx_versal_net_virt_defconfig |  1 +
> >>   configs/xilinx_versal_virt_defconfig     |  1 +
> >>   configs/xilinx_zynqmp_kria_defconfig     |  1 +
> >>   configs/xilinx_zynqmp_virt_defconfig     |  1 +
> >>   lib/mbedtls/Kconfig                      | 16 ++++++++++++++++
> >>   lib/mbedtls/Makefile                     | 16 +++++++++-------
> >>   lib/mbedtls/mbedtls_def_config.h         | 18 ++++++++++++++++++
> >>   10 files changed, 50 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_=
virt_defconfig
> >> index 0344089030c..702bf28405d 100644
> >> --- a/configs/amd_versal2_virt_defconfig
> >> +++ b/configs/amd_versal2_virt_defconfig
> >> @@ -164,6 +164,7 @@ CONFIG_VIRTIO_MMIO=3Dy
> >>   CONFIG_VIRTIO_NET=3Dy
> >>   CONFIG_VIRTIO_BLK=3Dy
> >>   CONFIG_MBEDTLS_LIB=3Dy
> >> +CONFIG_ECDSA=3Dy
> >>   CONFIG_TPM=3Dy
> >>   # CONFIG_OPTEE_LIB is not set
> >>   CONFIG_TOOLS_MKFWUMDATA=3Dy
> >> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lw=
ip_defconfig
> >> index a974970c3d3..ab6302b67eb 100644
> >> --- a/configs/qemu_arm64_lwip_defconfig
> >> +++ b/configs/qemu_arm64_lwip_defconfig
> >> @@ -11,3 +11,4 @@ CONFIG_CMD_WGET=3Dy
> >>   CONFIG_EFI_HTTP_BOOT=3Dy
> >>   CONFIG_WGET_HTTPS=3Dy
> >>   CONFIG_WGET_CACERT=3Dy
> >> +CONFIG_ECDSA=3Dy
> >> diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive=
_visionfive2_defconfig
> >> index a754134a313..508bd465704 100644
> >> --- a/configs/starfive_visionfive2_defconfig
> >> +++ b/configs/starfive_visionfive2_defconfig
> >> @@ -156,3 +156,4 @@ CONFIG_USB_GADGET=3Dy
> >>   CONFIG_WDT=3Dy
> >>   CONFIG_WDT_STARFIVE=3Dy
> >>   CONFIG_MBEDTLS_LIB=3Dy
> >> +CONFIG_ECDSA=3Dy
> >> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx=
_versal_net_virt_defconfig
> >> index 323b5606566..8b760beab03 100644
> >> --- a/configs/xilinx_versal_net_virt_defconfig
> >> +++ b/configs/xilinx_versal_net_virt_defconfig
> >> @@ -154,4 +154,5 @@ CONFIG_VIRTIO_MMIO=3Dy
> >>   CONFIG_VIRTIO_NET=3Dy
> >>   CONFIG_VIRTIO_BLK=3Dy
> >>   CONFIG_MBEDTLS_LIB=3Dy
> >> +CONFIG_ECDSA=3Dy
> >>   CONFIG_TPM=3Dy
> >> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_ver=
sal_virt_defconfig
> >> index 652121e27a0..6dd8620cf51 100644
> >> --- a/configs/xilinx_versal_virt_defconfig
> >> +++ b/configs/xilinx_versal_virt_defconfig
> >> @@ -168,5 +168,6 @@ CONFIG_VIRTIO_MMIO=3Dy
> >>   CONFIG_VIRTIO_NET=3Dy
> >>   CONFIG_VIRTIO_BLK=3Dy
> >>   CONFIG_MBEDTLS_LIB=3Dy
> >> +CONFIG_ECDSA=3Dy
> >>   CONFIG_TPM=3Dy
> >>   CONFIG_TOOLS_MKFWUMDATA=3Dy
> >> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zyn=
qmp_kria_defconfig
> >> index 8ad05e37189..d23452e96d0 100644
> >> --- a/configs/xilinx_zynqmp_kria_defconfig
> >> +++ b/configs/xilinx_zynqmp_kria_defconfig
> >> @@ -219,6 +219,7 @@ CONFIG_VIRTIO_BLK=3Dy
> >>   CONFIG_BINMAN_DTB=3D"./arch/arm/dts/zynqmp-binman-som.dtb"
> >>   CONFIG_PANIC_HANG=3Dy
> >>   CONFIG_MBEDTLS_LIB=3Dy
> >> +CONFIG_ECDSA=3Dy
> >>   CONFIG_TPM=3Dy
> >>   CONFIG_SPL_GZIP=3Dy
> >>   CONFIG_TOOLS_MKFWUMDATA=3Dy
> >> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zyn=
qmp_virt_defconfig
> >> index bb79ddf989e..01370a215d4 100644
> >> --- a/configs/xilinx_zynqmp_virt_defconfig
> >> +++ b/configs/xilinx_zynqmp_virt_defconfig
> >> @@ -237,6 +237,7 @@ CONFIG_VIRTIO_BLK=3Dy
> >>   CONFIG_BINMAN_DTB=3D"./arch/arm/dts/zynqmp-binman.dtb"
> >>   CONFIG_PANIC_HANG=3Dy
> >>   CONFIG_MBEDTLS_LIB=3Dy
> >> +CONFIG_ECDSA=3Dy
> >>   CONFIG_TPM=3Dy
> >>   CONFIG_SPL_GZIP=3Dy
> >>   CONFIG_TOOLS_MKFWUMDATA=3Dy
> >> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> >> index 789721ee6cd..8bf8809198f 100644
> >> --- a/lib/mbedtls/Kconfig
> >> +++ b/lib/mbedtls/Kconfig
> >> @@ -242,11 +242,16 @@ config MBEDTLS_LIB_X509
> >>          select X509_CERTIFICATE_PARSER_MBEDTLS if X509_CERTIFICATE_PA=
RSER
> >>          select PKCS7_MESSAGE_PARSER_MBEDTLS if PKCS7_MESSAGE_PARSER
> >>          select MSCODE_PARSER_MBEDTLS if MSCODE_PARSER
> >> +       select ECDSA_MBEDTLS if ECDSA
> >>          help
> >>            Enable MbedTLS certificate libraries.
> >>
> >>   if MBEDTLS_LIB_X509
> >>
> >> +config BIGNUM_MBEDTLS
> >> +       bool
> >> +       default n
> >> +
> >>   config ASN1_DECODER_MBEDTLS
> >>          bool "ASN1 decoder with MbedTLS certificate library"
> >>          depends on MBEDTLS_LIB_X509 && ASN1_DECODER
> >> @@ -264,6 +269,7 @@ config RSA_PUBLIC_KEY_PARSER_MBEDTLS
> >>          bool "RSA public key parser with MbedTLS certificate library"
> >>          depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> >>          select ASN1_DECODER_MBEDTLS
> >> +       select BIGNUM_MBEDTLS
> >>          help
> >>            This option chooses MbedTLS certificate library for RSA pub=
lic key
> >>            parser.
> >> @@ -292,6 +298,15 @@ config MSCODE_PARSER_MBEDTLS
> >>            This option chooses MbedTLS certificate library for MS auth=
enticode
> >>            parser.
> >>
> >> +config ECDSA_MBEDTLS
> >> +       bool "Enable ECDSA support with MbedTLS certificate library"
> >> +       depends on MBEDTLS_LIB_X509
> >> +       select ASN1_DECODER
> > This should be ASN1_DECODER_MBEDTLS.
>
> It was my first try, but I reach an issue.
> If ASN1_DECODER is not selected and we select ASN1_DECODER_MBEDTLS,
> there is a conflict because
> ASN1_DECODER_MBEDTLS depends on ASN1_DECODER. So to avoid this issue, I
> have kept ASN1_DECODER in V3.
>

The dependency is intentional, I think you should have something like:

config ECDSA
select ASN1_DECODER

config MBEDTLS_LIB_X509
select ASN1_DECODER_MBEDTLS if ASN1_DECODER

config ECDSA_MBEDTLS
select ECDSA
select MBEDTLS_LIB_X509

This makes the kconfig dependency clear - all _MBEDTLS switches are
under their origin.

Regards,
Raymond


> Regards,
> Philippe
>
>
> >
> >
> >> +       select BIGNUM_MBEDTLS
> >> +       help
> >> +         This option enables support of ECDSA with the MbedTLS certif=
icate
> >> +         library.
> >> +
> >>   endif # MBEDTLS_LIB_X509
> >>
> >>   config MBEDTLS_LIB_TLS
> >> @@ -301,6 +316,7 @@ config MBEDTLS_LIB_TLS
> >>          depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
> >>          depends on ASN1_DECODER_MBEDTLS
> >>          depends on MBEDTLS_LIB
> >> +       depends on ECDSA_MBEDTLS
> >>          help
> >>            Enable MbedTLS TLS library. Required for HTTPs support
> >>            in wget
> >> diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
> >> index c5b445bd85c..5433e17cc64 100644
> >> --- a/lib/mbedtls/Makefile
> >> +++ b/lib/mbedtls/Makefile
> >> @@ -39,13 +39,14 @@ mbedtls_lib_crypto-$(CONFIG_$(PHASE_)HKDF_MBEDTLS)=
 +=3D \
> >>   # MbedTLS X509 library
> >>   obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_X509) +=3D mbedtls_lib_x509.o
> >>   mbedtls_lib_x509-y :=3D $(MBEDTLS_LIB_DIR)/x509.o
> >> +mbedtls_lib_x509-$(CONFIG_$(PHASE_)BIGNUM_MBEDTLS) +=3D \
> >> +       $(MBEDTLS_LIB_DIR)/bignum.o \
> >> +       $(MBEDTLS_LIB_DIR)/bignum_core.o
> >>   mbedtls_lib_x509-$(CONFIG_$(PHASE_)ASN1_DECODER_MBEDTLS) +=3D \
> >>          $(MBEDTLS_LIB_DIR)/asn1parse.o \
> >>          $(MBEDTLS_LIB_DIR)/asn1write.o \
> >>          $(MBEDTLS_LIB_DIR)/oid.o
> >>   mbedtls_lib_x509-$(CONFIG_$(PHASE_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) +=
=3D \
> >> -       $(MBEDTLS_LIB_DIR)/bignum.o \
> >> -       $(MBEDTLS_LIB_DIR)/bignum_core.o \
> >>          $(MBEDTLS_LIB_DIR)/rsa.o \
> >>          $(MBEDTLS_LIB_DIR)/rsa_alt_helpers.o
> >>   mbedtls_lib_x509-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) +=
=3D \
> >> @@ -57,6 +58,12 @@ mbedtls_lib_x509-$(CONFIG_$(PHASE_)X509_CERTIFICATE=
_PARSER_MBEDTLS) +=3D \
> >>          $(MBEDTLS_LIB_DIR)/x509_crt.o
> >>   mbedtls_lib_x509-$(CONFIG_$(PHASE_)PKCS7_MESSAGE_PARSER_MBEDTLS) +=
=3D \
> >>          $(MBEDTLS_LIB_DIR)/pkcs7.o
> >> +mbedtls_lib_x509-$(CONFIG_$(PHASE_)ECDSA_MBEDTLS) +=3D \
> >> +       $(MBEDTLS_LIB_DIR)/ecdsa.o \
> >> +       $(MBEDTLS_LIB_DIR)/ecp.o \
> >> +       $(MBEDTLS_LIB_DIR)/ecp_curves.o \
> >> +       $(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
> >> +       $(MBEDTLS_LIB_DIR)/pk_ecc.o
> >>
> >>   #mbedTLS TLS support
> >>   obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_TLS) +=3D mbedtls_lib_tls.o
> >> @@ -64,7 +71,6 @@ mbedtls_lib_tls-y :=3D \
> >>          $(MBEDTLS_LIB_DIR)/mps_reader.o \
> >>          $(MBEDTLS_LIB_DIR)/mps_trace.o \
> >>          $(MBEDTLS_LIB_DIR)/net_sockets.o \
> >> -       $(MBEDTLS_LIB_DIR)/pk_ecc.o \
> >>          $(MBEDTLS_LIB_DIR)/ssl_cache.o \
> >>          $(MBEDTLS_LIB_DIR)/ssl_ciphersuites.o \
> >>          $(MBEDTLS_LIB_DIR)/ssl_client.o \
> >> @@ -82,8 +88,4 @@ mbedtls_lib_tls-y :=3D \
> >>          $(MBEDTLS_LIB_DIR)/cipher.o \
> >>          $(MBEDTLS_LIB_DIR)/cipher_wrap.o \
> >>          $(MBEDTLS_LIB_DIR)/ecdh.o \
> >> -       $(MBEDTLS_LIB_DIR)/ecdsa.o \
> >> -       $(MBEDTLS_LIB_DIR)/ecp.o \
> >> -       $(MBEDTLS_LIB_DIR)/ecp_curves.o \
> >> -       $(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
> >>          $(MBEDTLS_LIB_DIR)/gcm.o \
> >> diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_de=
f_config.h
> >> index dda3f4dd6e4..7d60bcc52aa 100644
> >> --- a/lib/mbedtls/mbedtls_def_config.h
> >> +++ b/lib/mbedtls/mbedtls_def_config.h
> >> @@ -89,6 +89,24 @@
> >>   #define MBEDTLS_ASN1_WRITE_C
> >>   #endif
> >>
> >> +#if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
> > In the 'mbedtls_def_config.h' file, we use the kconfigs without the
> > '_MBEDTLS' postfix.
> >
> > Regards,
> > Raymond
> >
> >> +#define MBEDTLS_ECDSA_C
> >> +#define MBEDTLS_ECP_C
> >> +#define MBEDTLS_BIGNUM_C
> >> +#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
> >> +#define MBEDTLS_ECP_DP_SECP192R1_ENABLED
> >> +#define MBEDTLS_ECP_DP_SECP224R1_ENABLED
> >> +#define MBEDTLS_ECP_DP_SECP256R1_ENABLED
> >> +#define MBEDTLS_ECP_DP_SECP384R1_ENABLED
> >> +#define MBEDTLS_ECP_DP_SECP521R1_ENABLED
> >> +#define MBEDTLS_ECP_DP_SECP192K1_ENABLED
> >> +#define MBEDTLS_ECP_DP_SECP224K1_ENABLED
> >> +#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
> >> +#define MBEDTLS_ECP_DP_BP256R1_ENABLED
> >> +#define MBEDTLS_ECP_DP_BP384R1_ENABLED
> >> +#define MBEDTLS_ECP_DP_BP512R1_ENABLED
> >> +#endif
> >> +
> >>   #endif /* #if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
> >>
> >>   #if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS)
> >> --
> >> 2.43.0
> >>
