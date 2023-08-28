Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A50C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 17:33:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E48B7864CF;
	Mon, 28 Aug 2023 19:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks-com.20221208.gappssmtp.com header.i=@gateworks-com.20221208.gappssmtp.com header.b="zVbXG7jo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5423D864D2; Mon, 28 Aug 2023 19:33:42 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 518F5864CD
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 19:33:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4bdso55755a12.3
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks-com.20221208.gappssmtp.com; s=20221208; t=1693244019; x=1693848819;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jrDf2dXA/qh/0OgfgEaVVYHDXtCWamtlov9GkBBksM4=;
 b=zVbXG7joc+gO80hrFihsgJDsxXHirs/0sQb5TWHDE8BCxHjPexR5qOmUq9wTEqaxbn
 gcZDxadhEy5MUxN6JYt22x414a4IrEnrLrqQhg6LgeRIwewFDqOFLYswe13BS4wB/1Kb
 8SXjCHhBLO3oWMks1XgV+esr8Qo0ZQ9th7xEgfTsho8u7da+EA9YoVhldCk6Kq1jX+24
 uz977C2FR/apfW/tyiZeYqgUL3serdpZNYZEddEkeCcZECmNsdkn5y21rgrsW+39pfAl
 ssG8cAntgYJXIYXne3VjhkR4N0Vk+YLa3D3PPsR9gbhMJQ34OajROy4gnZIASOnCdSme
 +3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693244019; x=1693848819;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jrDf2dXA/qh/0OgfgEaVVYHDXtCWamtlov9GkBBksM4=;
 b=DXtMVSwebPFFEXo7ompJQ9x56aHXaAOFc/8620S/4nrOyQN62PHFpj3BJA7SSFSjQB
 tcGF4pFaxsoekbmvu7ZQGmR3eJtqnJJ+V54LcrqHLzq2r2ePFNHUtAPs3SnJ4rEvNLti
 Nlytw2f0cGeNZIPoMZrY5aWYWD4BOWuAHqujTJrJFAGLzzPw+cyWc+07wUB71n+ahWgr
 r1Zim7GxCflGLphKLsKkn33qWk5lfNlz5KDq4BqZ9Od8ccB8FOdvdETaVyYl8s1l700D
 qr3rNFPZe3LiUcoyFXNw7IuahRa8prMOobyIG45V+XL90ox6PgbnRCR/DgQ0uIS2hoYs
 lfUg==
X-Gm-Message-State: AOJu0Yy76Q5X1LnlHyS5td6X8onHAR/oU634krQYjrq3o09WcW79gZ/f
 oEklHJsGO8xilG/YR9NEOeFqdwR2kpTV74bx0W8fTA==
X-Google-Smtp-Source: AGHT+IEtHzs75/54l1AFRA/r6k9HnedlQWScLWpYKz2egYe8MiaQRWhX6F3SBsGowMTEV1+OFyUZGmi9B4n+T3l2MX8=
X-Received: by 2002:a17:907:78d2:b0:992:d013:1132 with SMTP id
 kv18-20020a17090778d200b00992d0131132mr18750842ejc.1.1693244016974; Mon, 28
 Aug 2023 10:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230824011804.1501058-1-sjg@chromium.org>
In-Reply-To: <20230824011804.1501058-1-sjg@chromium.org>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 28 Aug 2023 10:33:25 -0700
Message-ID: <CAJ+vNU0PJ3FuHXZqp7xgx0QRK6oE7KSGDOCRafGk-GyNWyduzA@mail.gmail.com>
Subject: Re: [PATCH 1/2] imx: Drop unneeded phandle in FIT template
To: Simon Glass <sjg@chromium.org>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Fabio Estevam <festevam@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neha Malcom Francis <n-francis@ti.com>, Stefano Babic <sbabic@denx.de>, 
 Su Baocheng <baocheng.su@siemens.com>
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

On Wed, Aug 23, 2023 at 6:18=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Adding a phandle to a template node is not allowed, since when the node i=
s
> instantiated multiple times, we end up with duplicate phandles.
>
> Drop this invalid constructs.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  arch/arm/dts/imx8mm-cl-iot-gate-optee-u-boot.dtsi | 2 ++
>  arch/arm/dts/imx8mm-u-boot.dtsi                   | 2 +-
>  arch/arm/dts/imx8mn-u-boot.dtsi                   | 2 +-
>  arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi        | 2 ++
>  arch/arm/dts/imx8mp-u-boot.dtsi                   | 4 ++--
>  arch/arm/dts/imx8qm-u-boot.dtsi                   | 2 +-
>  arch/arm/dts/k3-am65-iot2050-boot-image.dtsi      | 8 ++++----
>  7 files changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/dts/imx8mm-cl-iot-gate-optee-u-boot.dtsi b/arch/arm=
/dts/imx8mm-cl-iot-gate-optee-u-boot.dtsi
> index 484e31824b85..d93e1cbd8a71 100644
> --- a/arch/arm/dts/imx8mm-cl-iot-gate-optee-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mm-cl-iot-gate-optee-u-boot.dtsi
> @@ -41,9 +41,11 @@
>         };
>  };
>
> +/* This cannot work since it refers to a template node
>  &binman_configuration {
>         loadables =3D "atf", "fip";
>  };
> +*/
>
>  &fec1 {
>         phy-reset-gpios =3D <&gpio4 22 GPIO_ACTIVE_LOW>;
> diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot=
.dtsi
> index 035282bf0b00..6085128e24ec 100644
> --- a/arch/arm/dts/imx8mm-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mm-u-boot.dtsi
> @@ -140,7 +140,7 @@
>                         configurations {
>                                 default =3D "@config-DEFAULT-SEQ";
>
> -                               binman_configuration: @config-SEQ {
> +                               @config-SEQ {
>                                         description =3D "NAME";
>                                         fdt =3D "fdt-SEQ";
>                                         firmware =3D "uboot";
> diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot=
.dtsi
> index 5046b38e4e29..bc57566a108f 100644
> --- a/arch/arm/dts/imx8mn-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mn-u-boot.dtsi
> @@ -204,7 +204,7 @@
>                         configurations {
>                                 default =3D "@config-DEFAULT-SEQ";
>
> -                               binman_configuration: @config-SEQ {
> +                               @config-SEQ {
>                                         description =3D "NAME";
>                                         fdt =3D "fdt-SEQ";
>                                         firmware =3D "uboot";
> diff --git a/arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi b/arch/arm/dts/im=
x8mp-rsb3720-a1-u-boot.dtsi
> index f3fb44046d5c..c4ea536b29bb 100644
> --- a/arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi
> @@ -162,6 +162,8 @@
>         };
>  };
>
> +/* This cannot work since it refers to a template node
>  &binman_configuration {
>         loadables =3D "atf", "fip";
>  };
> +*/
> diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot=
.dtsi
> index 36e7444a627b..200938a98072 100644
> --- a/arch/arm/dts/imx8mp-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mp-u-boot.dtsi
> @@ -146,7 +146,7 @@
>                                         type =3D "flat_dt";
>                                         compression =3D "none";
>
> -                                       uboot_fdt_blob: blob-ext {
> +                                       blob-ext {
>                                                 filename =3D "u-boot.dtb"=
;
>                                         };
>                                 };
> @@ -155,7 +155,7 @@
>                         configurations {
>                                 default =3D "@config-DEFAULT-SEQ";
>
> -                               binman_configuration: @config-SEQ {
> +                               @config-SEQ {
>                                         description =3D "NAME";
>                                         fdt =3D "fdt-SEQ";
>                                         firmware =3D "uboot";
> diff --git a/arch/arm/dts/imx8qm-u-boot.dtsi b/arch/arm/dts/imx8qm-u-boot=
.dtsi
> index a3e0af48109b..d316e869516f 100644
> --- a/arch/arm/dts/imx8qm-u-boot.dtsi
> +++ b/arch/arm/dts/imx8qm-u-boot.dtsi
> @@ -112,7 +112,7 @@
>                         configurations {
>                                 default =3D "@config-DEFAULT-SEQ";
>
> -                               binman_configuration: @config-SEQ {
> +                               @config-SEQ {
>                                         description =3D "NAME";
>                                         fdt =3D "fdt-SEQ";
>                                         firmware =3D "uboot";
> diff --git a/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi b/arch/arm/dts/=
k3-am65-iot2050-boot-image.dtsi
> index 3ecb461b0110..64318d09cf0a 100644
> --- a/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
> +++ b/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
> @@ -41,7 +41,7 @@
>                                         os =3D "arm-trusted-firmware";
>                                         load =3D <CONFIG_K3_ATF_LOAD_ADDR=
>;
>                                         entry =3D <CONFIG_K3_ATF_LOAD_ADD=
R>;
> -                                       atf: atf-bl31 {
> +                                       atf-bl31 {
>                                         };
>                                 };
>
> @@ -53,7 +53,7 @@
>                                         os =3D "tee";
>                                         load =3D <0x9e800000>;
>                                         entry =3D <0x9e800000>;
> -                                       tee: tee-os {
> +                                       tee-os {
>                                         };
>                                 };
>
> @@ -78,7 +78,7 @@
>                                         compression =3D "none";
>                                         load =3D <CONFIG_SPL_TEXT_BASE>;
>                                         entry =3D <CONFIG_SPL_TEXT_BASE>;
> -                                       u_boot_spl_nodtb: blob-ext {
> +                                       blob-ext {
>                                                 filename =3D "spl/u-boot-=
spl-nodtb.bin";
>                                         };
>                                 };
> @@ -88,7 +88,7 @@
>                                         type =3D "flat_dt";
>                                         arch =3D "arm";
>                                         compression =3D "none";
> -                                       spl_am65x_evm_dtb: blob-ext {
> +                                       blob-ext {
>                                                 filename =3D "spl/dts/k3-=
am65-iot2050-spl.dtb";
>                                         };
>                                 };
> --
> 2.42.0.rc1.204.g551eb34607-goog
>

Simon,

Adding Ying-Chun Liu (PaulLiu) here as he is the maintainer for both
boards being affected here.

I'm not clear if the two affected boards here do have duplicate
phandles due to only having a single dtb in their defconfigs. However
I could not get imx8mm-cl-iot-gate-optee_defconfig,
imx8mp_rsb3720a1_4G_defconfig, or imx8mp_rsb3720a1_6G_defconfig which
use those two files to build with latest master to even check:
  BINMAN  .binman_stamp
Image 'itb' is missing external blobs and is non-functional: blob-ext

/binman/itb/fit/images/fip/blob-ext (fip.bin):
   Missing blob

Some images are invalid
make: *** [Makefile:1115: .binman_stamp] Error 103

So it seems these boards are broken anyway and need some attention so
for both patches:

Acked-by: Tim Harvey <tharvey@gateworks.com>

Is there a test that binman can make to catch any future occurrences
of phandles being added to templates?

Best regards,

Tim
