Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB37CE8E8B
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 15:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9759D88E90;
	Thu, 24 Oct 2024 17:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="WtLPefb4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EC3F88F45; Thu, 24 Oct 2024 17:33:21 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 012E788E90
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 17:33:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e292926104bso1178493276.0
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 08:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1729783986; x=1730388786; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DJRDvFofM9oF0WlBQAFhvbKEYUhw15f0WlsFpE5pgrs=;
 b=WtLPefb4jVzcrE5oTFmPXwOF0sFqIk3Qn+rHebvXcMl785NJhaRnoR8ir1EbVPWn8t
 wLoxZsA8QHgx2pyEmLO03kT+OuVwhFPkiOARQsGeEecgDMUg17VwHImfe9lt1ZD28wA1
 vNwqDaFhwOV05HzDQTbQrM7R0vvPUZE1n8V9n0+Bym5H4HCDjC1r10NiEYVIHJZSXi6X
 rdw/T5q1lDANMycdFhLp+K/VN01Z+3RHy+4KSNzBLqkowtlBGuNs3voFqEUajdR66zzz
 ZXnyDU+puUEzyWTTYd39O//A/+d65uPfDtGzF+s0FPI7APpERewwfqnDhBTNIeKp3tL6
 7osQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729783986; x=1730388786;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DJRDvFofM9oF0WlBQAFhvbKEYUhw15f0WlsFpE5pgrs=;
 b=NkrQMebp8mT5O+O/V/GFA3FKqr0qHsO6XiNvRWM3TZ+vv8IrKf+CcNTG6i7y9nCVjT
 8lw4fJS0ATG57OkZPoeYyUoBONAT5gFdxmD3O5c2h91oZPn0iLtjS4HelNwH83aOBhLF
 XuYZMDa2VW562rBSpspfIIVvPPMUaLdZnRzh9cbtuf2WOdGMr1CE/+YzuNpUzY7Abc2Q
 Bvdaj04v+wBewbKVRrLwQjOmWowSy/fIppTqbHrfGaz/HDSWIMJ5OY/IdfHRFTTJii4/
 ZUtcmy0Gb102cLahV6GU1s/fPtLYcXCAZuzPcoJbNtLCmdiUw26EBgzpf5+UJ+BPon2h
 hzXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGREDG8XXXnButlF5mJiJiBV0iRUhQbHga+UpwbQOAoujDqlXurmmgYqFMXeFJkH9PgtLkLuM=@lists.denx.de
X-Gm-Message-State: AOJu0YyqHmy24sg7TItyw0QCvc93TT8yE18Kv8EJllRzSAI+ttB/qDzi
 3Z3ehz/zXck8irN4qOZYmYeDkmJOLxoPBcUs3IUPw+bo1Xm0uzUI+DlgiAyIRQhrX6SnccL1t4h
 HvVmAHHIbKQSkjG098ItyIpDvus9JQPMbmUQa9w==
X-Google-Smtp-Source: AGHT+IF4j1sUC2B4F3ZTteeRjmfYwJuG0xpJReKV637chMN15MolIsiPZPkTqZlWmdgd9heUcioC6ZUyjssvo0TORKc=
X-Received: by 2002:a05:690c:4d45:b0:6e3:1869:8983 with SMTP id
 00721157ae682-6e866331c31mr30991317b3.40.1729783985831; Thu, 24 Oct 2024
 08:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20241024-phytec_imx8m_optee-v1-0-fc6b78bf9a9b@phytec.de>
 <20241024-phytec_imx8m_optee-v1-1-fc6b78bf9a9b@phytec.de>
In-Reply-To: <20241024-phytec_imx8m_optee-v1-1-fc6b78bf9a9b@phytec.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 24 Oct 2024 08:32:53 -0700
Message-ID: <CAJ+vNU2ZrBEoeTrXZspYEUx5_N5sQQabSHCTVUVwP2bhoYWy+Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/6] arm: dts: imx8m: add fit optee node
To: Yannic Moog <y.moog@phytec.de>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, 
 Manuel Traut <manut@mecka.net>, Benjamin Hahn <b.hahn@phytec.de>,
 Teresa Remmet <t.remmet@phytec.de>, 
 Yashwanth Varakala <y.varakala@phytec.de>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
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

On Thu, Oct 24, 2024 at 12:04=E2=80=AFAM Yannic Moog <y.moog@phytec.de> wro=
te:
>
> Add tee node in SoC u-boot device trees. Each board adds their specific
> load and entry addresses for the op-tee image in the respective
> board-u-boot.dtsi file.
>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
>  arch/arm/dts/imx8mm-u-boot.dtsi | 15 ++++++++++++++-
>  arch/arm/dts/imx8mn-u-boot.dtsi | 15 ++++++++++++++-
>  arch/arm/dts/imx8mp-u-boot.dtsi | 15 ++++++++++++++-
>  3 files changed, 42 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot=
.dtsi
> index d31bc822532..e7a6800b771 100644
> --- a/arch/arm/dts/imx8mm-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mm-u-boot.dtsi
> @@ -164,6 +164,19 @@
>                                         };
>  #endif
>
> +                                       tee: tee {
> +                                               description =3D "OP-TEE";
> +                                               type =3D "tee";
> +                                               arch =3D "arm64";
> +                                               compression =3D "none";
> +                                               os =3D "tee";
> +
> +                                               tee-os {
> +                                                       filename =3D "tee=
.bin";
> +                                                       optional;
> +                                               };
> +                                       };
> +
>                                         binman_fip: fip {
>                                                 arch =3D "arm64";
>                                                 compression =3D "none";
> @@ -192,7 +205,7 @@
>                                                 fdt =3D "fdt-SEQ";
>                                                 firmware =3D "uboot";
>  #ifndef CONFIG_ARMV8_PSCI
> -                                               loadables =3D "atf";
> +                                               loadables =3D "atf", "tee=
";
>  #endif
>                                         };
>                                 };
> diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot=
.dtsi
> index 6875c6d44ff..bcb88f0a507 100644
> --- a/arch/arm/dts/imx8mn-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mn-u-boot.dtsi
> @@ -235,6 +235,19 @@
>                                         };
>  #endif
>
> +                                       tee: tee {
> +                                               description =3D "OP-TEE";
> +                                               type =3D "tee";
> +                                               arch =3D "arm64";
> +                                               compression =3D "none";
> +                                               os =3D "tee";
> +
> +                                               tee-os {
> +                                                       filename =3D "tee=
.bin";
> +                                                       optional;
> +                                               };
> +                                       };
> +
>                                         binman_fip: fip {
>                                                 arch =3D "arm64";
>                                                 compression =3D "none";
> @@ -263,7 +276,7 @@
>                                                 fdt =3D "fdt-SEQ";
>                                                 firmware =3D "uboot";
>  #ifndef CONFIG_ARMV8_PSCI
> -                                               loadables =3D "atf";
> +                                               loadables =3D "atf", "tee=
";
>  #endif
>                                         };
>                                 };
> diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot=
.dtsi
> index 56749ccacd2..7a9c616fb1a 100644
> --- a/arch/arm/dts/imx8mp-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mp-u-boot.dtsi
> @@ -185,6 +185,19 @@
>                                         };
>  #endif
>
> +                                       tee: tee {
> +                                               description =3D "OP-TEE";
> +                                               type =3D "tee";
> +                                               arch =3D "arm64";
> +                                               compression =3D "none";
> +                                               os =3D "tee";
> +
> +                                               tee-os {
> +                                                       filename =3D "tee=
.bin";
> +                                                       optional;
> +                                               };
> +                                       };
> +
>                                         @fdt-SEQ {
>                                                 description =3D "NAME";
>                                                 type =3D "flat_dt";
> @@ -204,7 +217,7 @@
>                                                 fdt =3D "fdt-SEQ";
>                                                 firmware =3D "uboot";
>  #ifndef CONFIG_ARMV8_PSCI
> -                                               loadables =3D "atf";
> +                                               loadables =3D "atf", "tee=
";
>  #endif
>                                         };
>                                 };
>
> --
> 2.43.0
>

Hi Yannic,

I've attempted something like this in the past [1] but I added the
load address and made it a Kconfig. It never made it in due to
something happening in CI that I never had a chance to get back to.

What happens with the binman step if you don't have an overlay that
specifies load/entry?

Best Regards,

Tim
[1] https://patchwork.ozlabs.org/project/uboot/patch/20230622173006.3921891=
-1-tharvey@gateworks.com/
