Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFC8C48260
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 21:27:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D49D87E35;
	Thu,  8 Feb 2024 22:27:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VQ2T3Uhc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F2C587CCF; Thu,  8 Feb 2024 22:27:35 +0100 (CET)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED61E87E37
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 22:27:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-55b5a37acb6so58942a12.0
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 13:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707427651; x=1708032451; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pOnBfTr9K8rmcLNbayz7jy9MzldyiVeOccbrY3I+0hM=;
 b=VQ2T3UhchIPiZWEBTzwp+sgTCQ0wTkvTnIJEiWEojJv+hVwG/eB5OTjmg2fIn9hGGk
 gMJfK60eoR5dMpGnvRp0yP/BFqJ/IdB2z8NxGWMiPLgzwtHp2G/dZEDeu4sMmKA8VhDM
 lHhDp+1ebwvulVgSXS1+lIKopwrsgTfjL8XitljgrkQRNL8LdVqBA5kca0CgAUwClqgS
 IWXVR58zijJIOR7nQ0XlOkob26hSZfP3b9fU4UKqS7qNrVraVrBaEjj7NO04IzjQcqk4
 vecflKNe84x4ifgncEL+mT6Zrcp/QnXcLoJr8vjCDHcpRYPoBXOCRuvuxluc8VvLWnsW
 wfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707427651; x=1708032451;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pOnBfTr9K8rmcLNbayz7jy9MzldyiVeOccbrY3I+0hM=;
 b=ceeRp+0l0cCTOkoQRYlDDSLkOmkwX76psA00lcwkAmKr3IEAIh9XCkEEX3oEuaoQfQ
 uZDEdR0XBA+2S+2D+rdoOr4CxmOrf4NEJoHVRy5X+v1ghjJuqmvy0Jp/4jXcfI457LzQ
 nibvl/QTInIm1u+GMgu8y+ez9ad18/MPqIKJDd2zNGcKLyKwZ4i5M8JirS+KM2qShF+R
 KJYzvuISCmzQBU3NDUkj5WAHgXevUMs5PKww/PYVVnjJySnZdNjpyFzb/7eh6A8GEois
 +mKQBmXitHJ4Sk+qaXWbhJEo6mqsS5Amm0He5iR4rrj1mD/yWxpNGSeGU70sWCjIZg8r
 9RVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsZB1zhMaCzUolmnIYj4UqCAvOxzbV54i40H/aaDhSdqmjHl1TK28UGfHwke7kibp4dacaK7RCR7fyjHBSq9xShB7YYQ==
X-Gm-Message-State: AOJu0YzsO1Si3fyK0bnC04KYHPP/wur6yIn+rh3HGFiwxK4x9OrISlaO
 dwSYwqRzvsWuW8Br6iqhNwuMo37foPTTKRZKUjmo1nFxvCUmpBOFbY7knMBtwUaw/scNnZg3tLJ
 g815hpfNC3jopwu8UVkhZ7KdqPZI=
X-Google-Smtp-Source: AGHT+IF0ndLpm+TUHiZq6kC7teSugOGGAYqa2y80Yhg2vaJNPPLHHfiK9Xpb9TnSDgRrIlQ/25qgq4vhDWqFfz2dEEs=
X-Received: by 2002:a05:6a21:339a:b0:19e:3a8e:e722 with SMTP id
 yy26-20020a056a21339a00b0019e3a8ee722mr889432pzb.2.1707427651287; Thu, 08 Feb
 2024 13:27:31 -0800 (PST)
MIME-Version: 1.0
References: <20240208094518.391-1-othacehe@gnu.org>
 <20240208094518.391-2-othacehe@gnu.org>
In-Reply-To: <20240208094518.391-2-othacehe@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 8 Feb 2024 18:27:19 -0300
Message-ID: <CAOMZO5D1sVNMDZ861m8Y9-XVV=rAjLC1LCcfmGtpt4dB=iXZ_w@mail.gmail.com>
Subject: Re: [PATCH 1/2] board: imx93_var_som: Probe ELE MU
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Ye Li <ye.li@nxp.com>, 
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 Simon Glass <sjg@chromium.org>, Mathieu Othacehe <m.othacehe@gmail.com>,
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

On Thu, Feb 8, 2024 at 6:45=E2=80=AFAM Mathieu Othacehe <othacehe@gnu.org> =
wrote:

> diff --git a/board/variscite/imx93_var_som/spl.c b/board/variscite/imx93_=
var_som/spl.c
> index 502e599b91a..0965a2de996 100644
> --- a/board/variscite/imx93_var_som/spl.c
> +++ b/board/variscite/imx93_var_som/spl.c
> @@ -97,6 +97,7 @@ int power_init_board(void)
>         return 0;
>  }
>
> +extern int imx9_probe_mu(void *ctx, struct event *event);

Please put this prototype into a header file.

Currently, it appears in 3 imx93 spl.c files.
