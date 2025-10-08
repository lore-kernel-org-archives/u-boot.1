Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A518CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 13:50:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 761E083D77;
	Wed,  8 Oct 2025 15:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aKtrkoU1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2AF183E21; Wed,  8 Oct 2025 15:50:56 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6EAA839B9
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 15:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-59054fc6a45so3945055e87.3
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 06:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759931454; x=1760536254; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EYuNgkYKOmBjkx7e9zwatXnuxBg0zNmMkRokcfjdNwA=;
 b=aKtrkoU1s/6ePt6YANWbFF9VUUHSatdJ96I8rq0MW2LBllIEYphrZd3zuLVFzm9SJa
 tm1StPuufcKt4c8uRWVuE7b3GprXQEh3VE8MHWiailv0K2eDUtG/Na2DkLRWqAZf/nEd
 uxukbhyzqHzqm32yIrzPDCF2jb6RV7CZ3CibTsZYszmXn12VWOoLqeW7CwzpEymU8BBi
 0XcrDxsPr1OYznHJA62uwJbv30Vqk93AtPXiKnfaKaxP+cFGkT4fQAToDRNfG3B9lapJ
 XhRKoDnt5zVEbWf3XxaIscIOXWfLBj7zbWHNNr7HBec0TU80vb1zRmyul/kaPO3CspnD
 J5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759931454; x=1760536254;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EYuNgkYKOmBjkx7e9zwatXnuxBg0zNmMkRokcfjdNwA=;
 b=T8XmmBt4NknBHXhqs/ZWOzBqy/p2kJAaU6uKnB5BxEiSFHq6hZDZ7cfnVst/VVg+9F
 r3ZXzk36r6TiXVcUUtilWkOo8KBVyFe6wAw1zJo8zJDv03iWldpwcXqIKRPND9OWlVF8
 J/8DV3CZvRWOOYeP473T4UO1+GKrG5phvNwDl3U3PUuB5GhBJpZ0trpMCjyTJZKgof82
 j3WOcDRPEdnlX3q2uc1Gtlnf/7Vyxfi7kSgakDrjyAzr5jAKlKWDPnHQykRgcamumQrE
 /06vrYG+DOKCeVOZhi6pdGqHy/uo6uGHtO6fLiREgi8jhD73wDH6z20ezwYKlGuRnXH3
 IGwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTXc6nCd2G4T8U6JN34apwZOV3kMB78EZDpF2BknMNMNVbOHMQtrCLWLpz0/FcRcYFNz6p/wM=@lists.denx.de
X-Gm-Message-State: AOJu0Yzlv6gC2CsKk+owEhiDxTK8hkw52lxnDxMg78TwOLo79mc666Vp
 fHYzgSikxQKxuuw7nWQuAm5sJsOlpZIycoALnPKVD8YTDitlpA068c2q75iBUWVIsb7NMlal7MU
 Ujg+JPnZ09wfbgVI0zoUlnxbp1VynYR4=
X-Gm-Gg: ASbGncuFOGqVJUayjGfE/o0B8wELTIB31rtz4SXBrotkPFsirZK6tODaAwDxB1iXQnc
 /BoA4S8SbRbYZ846f2EryG65Zt03ZxcqZWU2CFkGlGoZDHT3tjm59cuvPfY0GS8BgMYlEJjWADY
 t4SXqG1H+9C5c1HZyEw5mxUwQShUAXR9+z85T+dZNQN/yl121KH6qBXeNJ3eirWrZyqsWSVumrj
 wAo+vut6ZDzMdELG+/QM993yWUVwjHTqb5WtOONP5+PeKvVbWFI34hrqm/x8Sg=
X-Google-Smtp-Source: AGHT+IH9F9HYEQBkqebjf/mM1630+lhMHUNGQU5ESKIiytiEeh9FEH+yq7W5pPMI3so1nPSzwAzsWJJl4QtDVd3djdw=
X-Received: by 2002:a05:6512:10d4:b0:58b:2b:ac7b with SMTP id
 2adb3069b0e04-5906de8dbd1mr1063733e87.57.1759931453731; Wed, 08 Oct 2025
 06:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20251007074503.21624-1-ernest.vanhoecke@toradex.com>
In-Reply-To: <20251007074503.21624-1-ernest.vanhoecke@toradex.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 8 Oct 2025 10:50:42 -0300
X-Gm-Features: AS18NWDONH4jhcD3f1pt98wO_7GnucPmlAJeRTVSUjBoW5HmE5ZK88wW8pA_Uuo
Message-ID: <CAOMZO5CU5BtAa0DVjSOSa0-Sg2G1CJ6m49VVj2QHWh1=qCC_cg@mail.gmail.com>
Subject: Re: [PATCH v1] arm: dts: imx8mp-toradex-smarc: migrate to OF_UPSTREAM
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
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

Hi Ernest,

On Tue, Oct 7, 2025 at 4:45=E2=80=AFAM Ernest Van Hoecke
<ernestvanhoecke@gmail.com> wrote:

> diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kc=
onfig
> index 74416a788473..c5da27bc366e 100644
> --- a/arch/arm/mach-imx/imx8m/Kconfig
> +++ b/arch/arm/mach-imx/imx8m/Kconfig
> @@ -296,6 +296,7 @@ config TARGET_TORADEX_SMARC_IMX8MP
>         select IMX8MP
>         select SUPPORT_SPL
>         select IMX8M_LPDDR4
> +       imply OF_UPSTREAM
....

> +CONFIG_OF_UPSTREAM=3Dy

As you use 'imply OF_UPSTREAM' in the Kconfig, this
CONFIG_OF_UPSTREAM=3Dy line is not needed and can be removed, right?
