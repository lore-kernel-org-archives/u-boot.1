Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00A2C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 14:12:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 341C3805D7;
	Wed, 12 Mar 2025 15:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="emz4+Tt3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9492180756; Wed, 12 Mar 2025 15:12:50 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E3FC801FB
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 15:12:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5498c742661so7179934e87.1
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 07:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741788768; x=1742393568; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=34LBQ/78nb9MoNC+No4T4jmlKWOBbZP6Ck+NzUdQXG4=;
 b=emz4+Tt3JYFj9A7X1olGBmRsC2qMml+YAzx2YdOqCRk/4YI4ACOQXQvgvEtsqTbMly
 GO2fxsWwMQKskjy1HNBwx8D4k2Zfs2wTBos6Zl5UqVUYKuiuUehGDg9WOk8LB3xO/R38
 B9FyUsShKylU5z3y5STG06w07O2a6fUBO2ngpic1oVkdN7Lt/vl3F95L/Jb6J3xN906a
 KnE5aWGdRTUEXEf7vyzHdtEoHTt9SSIey1srsj11/lXNeCq/T4K/3CVBFWX9wk/YRq/c
 fw0WKyf1Ii/BHRnLEEc1xI3qVZYy5EThU4kkRvNRhWDm9mF7VAEL2essi7zXBjQjKXyD
 flvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741788768; x=1742393568;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=34LBQ/78nb9MoNC+No4T4jmlKWOBbZP6Ck+NzUdQXG4=;
 b=KpwTGEuqbDMOHTUzhErdMjLdNH7sHpNCqfop4vWvt7UbNN6jjUXtaKWxF4EKIpqhGT
 ZRIiD2mDmbDQKcKCP0aSq9JSNAYFp5MGayJDdZ3+8tAlACER0WWwPAQJ1SscKtja0kpD
 3LVCfTp9RXUtMipmUEnfPIFDWlWz7vHimBA2ayf6GnXEtXAT+OMaAR81ztcDWnpykGUV
 48e5YiM4vpDTJMiyoSNMH/IK5Vxi02S+zUvbTDM3l0Pr6mPsfh5+MZ5bMtZXpQykEIhf
 MdtYrXypCDGHLpcygJanILRCNBkpYJCmcRy9fka2l0LlK0TcjKkmPsuisn8eSjCqich8
 6D1A==
X-Gm-Message-State: AOJu0YyFIz26DI7Xfp0EskNQDCgRGdQNMP316dzjOKTGj2qKUaO9yIHG
 Vza/3wuebDGJl2LYXIC8+2CSEjus6PGIF4Suo/lXeYFfl3Fb+jlP7aeHQobkvPj2gvQT9Wg+Me/
 hsT8rTdOBaq1nZwV1I29h5xkoOSPBvJV2
X-Gm-Gg: ASbGnct/glt9TagNZAw2oNcsMYOOGEiVhz0dFxYTqAnrBdhGHlSesF7EUy1a8oYYLu3
 5B63nXathlucco5H5KIb5gyDjC70J2SDCuzayWzG/MfG4uSLlTRzoBsIbx8SIR/S8w11GccKhbi
 IxVR0NkxCH8hiwB8tgbA+MD1OGmWz/pxNUSQsWvFoW571Tq9KkhvEq9PYuPw==
X-Google-Smtp-Source: AGHT+IF95ApKVNTFXU3yWQrmYLE1odU/XfMfoE9jDjx+XAhPvTmvy13MC0wNgyPYtuRJSkq7Z3ESOlonaNYad9x9ngg=
X-Received: by 2002:a05:6512:3da3:b0:545:296e:ac28 with SMTP id
 2adb3069b0e04-54990e67291mr8938863e87.24.1741788767610; Wed, 12 Mar 2025
 07:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250310123621.389594-1-vincent.stehle@arm.com>
In-Reply-To: <20250310123621.389594-1-vincent.stehle@arm.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 12 Mar 2025 11:12:35 -0300
X-Gm-Features: AQ5f1Jrv5ymGy87mPzbk0RKYJygCtikFEI-kYQETMzu6lDB7T7RJIGw0O_aVPzM
Message-ID: <CAOMZO5BV1BBP-f++-NzjzEDXCG1-2WVjma8-e5zpi3yLKGeYCA@mail.gmail.com>
Subject: Re: [PATCH] imx8m: soc: cope with existing optee node
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>
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

Hi Vincent,

On Mon, Mar 10, 2025 at 9:36=E2=80=AFAM Vincent Stehl=C3=A9 <vincent.stehle=
@arm.com> wrote:

> --- a/arch/arm/mach-imx/imx8m/soc.c
> +++ b/arch/arm/mach-imx/imx8m/soc.c
> @@ -1270,8 +1270,9 @@ static int ft_add_optee_node(void *fdt, struct bd_i=
nfo *bd)
>                 }
>         }
>
> +       /* Locate the optee node if it exists or create it. */
>         subpath =3D "optee";
> -       offs =3D fdt_add_subnode(fdt, offs, subpath);
> +       offs =3D fdt_find_or_add_subnode(fdt, offs, subpath);
>         if (offs < 0) {
>                 printf("Could not create %s node.\n", subpath);
>                 return offs;

This looks correct.

However, shouldn't we add the optee node only when CONFIG_OPTEE is selected=
?

--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -1235,6 +1235,9 @@ static int ft_add_optee_node(void *fdt, struct
bd_info *bd)
        int offs;
        int ret;

+       if (!IS_ENABLED(CONFIG_OPTEE))
+               return 0;
+
        /*
         * No TEE space allocated indicating no TEE running, so no
         * need to add optee node in dts
