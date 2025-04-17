Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E37FC369BD
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 00:40:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7424282DB4;
	Thu, 17 Apr 2025 02:40:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BmbW4Lz/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 550EC82EAA; Thu, 17 Apr 2025 02:40:42 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1202982BD6
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 02:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-54d68d0b530so228633e87.0
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 17:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744850439; x=1745455239; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZcPO98uj7lYDfLWTWvGUNlYSEKHRXeAbK4YZOiLNuL0=;
 b=BmbW4Lz/SFMqnGiXx+l6QYbQbM+Xm5etDZsnUFo1DbgtifX8PNi1RXTq56q8uWSS6F
 JcxlHf8QG3a9FP5sHjZRhzoUhIv3f+VAS+FonywRCRRh6efXi4SElu850WAaVx/dcNLY
 +MKgiN1RgRaNkw6jKK3n3WiN/ZmEy4hkeKxXLGCagoG+mrUWR1w7I+Zo8WgeSrzEvRjd
 JepfvnZWeAi6onZI942kKZLKrrIZN2DbyEYcKhLQKNRiu5AEjmjICsP4GHFg2KugvBof
 CJCLtOvGDcaO8L5la4NydIfbXW+yA1w9x1/Z91cuelqbhgmeX0S4/ghi8BB6FkTAltzh
 YYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744850439; x=1745455239;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZcPO98uj7lYDfLWTWvGUNlYSEKHRXeAbK4YZOiLNuL0=;
 b=m5qtYSC93YqjkBZf0KufUNmwFxgqJDn8TWELR9rzRR+layYUm0N6ZHCAPO00Dslyk8
 ikeKBDgpjLhTUMHR6NGYQkHUQNM1L1IiiYy0Ug3NWo/akVQciqn83f23Z5ND9rmTF46p
 A0dg28SqNbs0IXlociToC87BFoR8utc67T5XXbJBKv9XNHhHOB1qjN+GhCWIgzR1DgX/
 NjseWgceUcRkjGPKIrZg7+NgHBXQ/jF2iKWx1/4RASfiLRzHB4keXgp2u8MSwIA9eUGo
 flDiHFzkwVz88pCJX06GmMknUdj4dw2tj6j975pB7Xxw2eeh3wxLuBbSGFv8H+pE3pcf
 hiow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSTf04PFgJfMbEkxJPKXgng61248XUT/n/Cs25XyF7Y9FEJTasJrXn+vWxz99khUih2QtOQ/I=@lists.denx.de
X-Gm-Message-State: AOJu0YwxPhT4zwW3CYAJNFxJd9YzSd7qxB7ygNw+Gs8xARK2TBer9Y6H
 JARlYKutpqPj/RngRGd2+8+yQB2vCh9+2tzJaQQX6U+YGDpf6EzXk6I1CyG8WQ/XCMMzZSJWK/+
 UXb8b4ME5M1o89yPWuAZSaQ2yJj4=
X-Gm-Gg: ASbGncu7yxDLGU1DBZDEGJnW7psia89JPmwHsnIs5BWpf8Z+ubs8hgA2cyKjgvPRB2p
 GXigzMyhSZwWB47+hTjUpMCBXfx+XEESNeHrcKgBhEjMGxvBvIiZbyd+6gYYWZaQQtaY/6zNhrB
 jfph9NQ7svuGkTt8/ALtxXVnp441ouborXEml5O6VhdEEi7kMgifZcaw==
X-Google-Smtp-Source: AGHT+IEgkbWAl74yjWynlncn2WuwGDxJ2AGF6s3zZZuePtBT0zNelmDON5REapK8AD6wxrux2c8lrC6f/qwz2jpaNH0=
X-Received: by 2002:a05:6512:2250:b0:54c:a49:d3de with SMTP id
 2adb3069b0e04-54d64a7b3c7mr1405398e87.10.1744850439105; Wed, 16 Apr 2025
 17:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250323160107.145749-1-marex@denx.de>
 <20250323160107.145749-17-marex@denx.de>
 <20250415142846.GA244333@francesco-nb>
 <CAHCN7xLa5W-AtRso6RUZwZG_sfDm9CHierfzt_WfOqFjSGJZoA@mail.gmail.com>
 <20250415150344.GA246483@francesco-nb>
 <b396cb96-ff95-4822-ad24-ddff2e3b6545@denx.de>
 <CAOMZO5B=j=k8U6to2TDzohS11j4hPWQOho9bdrYCPe0WXtrQjw@mail.gmail.com>
 <20250416092639.GA24345@francesco-nb>
 <db2d623afd944df2bca6d1e4657d4031@dh-electronics.com>
 <CAHCN7xKyoBQPeXDA90-kcBTw7BhObvn6PVzreoUQ5+GjiCewyg@mail.gmail.com>
 <CAHCN7xLgS7FZ4ajbBa+p-_w_s6oHnfMYcZEMsNBNkqkgAG-7Jw@mail.gmail.com>
 <b35218ca-df17-4423-9932-a2ad0ba14e50@denx.de>
 <CAOMZO5CA0_GUr2uQtQgFHe-9wVDCOQwo5HZzZ4sibXEPMpe8cA@mail.gmail.com>
In-Reply-To: <CAOMZO5CA0_GUr2uQtQgFHe-9wVDCOQwo5HZzZ4sibXEPMpe8cA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 16 Apr 2025 21:40:27 -0300
X-Gm-Features: ATxdqUElvkbVBTSetARpb2Df88UZzk9ckAsc3_xKxneCRop6Iz0Mw8tWC2Jjrbc
Message-ID: <CAOMZO5DsfWdawYx_ejCfjig9wB3BrmmqziWWK5_4yGs0U30ASQ@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH v2 16/24] clk: imx: Convert clock-osc-*
 back to osc_*
To: Marek Vasut <marex@denx.de>
Cc: Adam Ford <aford173@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Francesco Dolcini <francesco@dolcini.it>, 
 Fabio Estevam <festevam@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>, 
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>
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

On Wed, Apr 16, 2025 at 8:58=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:

> What do you think about registering the osc clocks like this?
>
> https://paste.debian.net/1369857/

With this patch, "ums 0 mmc 1" works on the imx8mp-evk.
