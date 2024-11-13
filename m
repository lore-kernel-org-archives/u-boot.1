Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EA4D637A3
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 18:30:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1F2888EFB;
	Wed, 13 Nov 2024 19:30:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O40oJJJt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 398E888EFB; Wed, 13 Nov 2024 19:30:07 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DA7288DF5
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 19:30:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2fb3ce15172so10773581fa.0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 10:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731522603; x=1732127403; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQs3/8/huGMDVLf14baqSJImKguN1FIlmRBVUSaMgiU=;
 b=O40oJJJtSNbgifStFnTJODXQMzdv7tPSkcy5XERkA7qGtTPPvYUb1ER7Mt2u/Z5Kji
 H6h4+TqdtmhcMe+tDlF8hwwZhM6PZLeyH3x5HvL6G7hDq+t3O7Aat/J2Tj81aaKm4HzA
 dUGrbZBLSod/ZopPhYa6diUnjkpPmx6sw9O3U+Tkx2UEn9ZmD1y5VIjlfG4Ydsd8WQKj
 jiFBAgBtcPgeeA1ooxKTB3oRngdPmaf+vlmFYsDasdEg0X9HEKx0SG1joBxyNQ0yZWML
 cIsrYI53D/HdJ8GAnDN9LjYHsMBzu+wkDW0D6nRv3CBxSztEA3o1o6QPA1Xf5/mbGuoU
 qyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731522603; x=1732127403;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQs3/8/huGMDVLf14baqSJImKguN1FIlmRBVUSaMgiU=;
 b=EBNeTasekCoIV57tSbI52iSFMDRdiVZw4ONONS9MoKIVoeD6zTA9BAGFfYTMnxIPjW
 DKENM7Khc6b441VtHAyEQDtOG4OJ6boKSH7KisVojRa29BQSvdOWSux0au4XTVug7/0X
 lr6iu9YLpYgEF2NnoqgqQjKc1PdtYDhW+S5CFLwt0w2tY1+a5k0wJvD/HR+11LtXzdti
 +PEJZ+StCtqrwKH/XpAp6Mw3gh5Z/GhSAio9ypj0d31PLI8OGfrcmlV9aPXvdjt5eduy
 MSi1cqUWDxFH6jDvX3WecMn0EDkZ/ZuKy49kXwiVH+BdS0tiYHIP3c7GIHlbx/orghqN
 gshA==
X-Gm-Message-State: AOJu0YwNuF896fNeadQxuX6KJzj37KIJOBMBmZeBhefIBf/YNKlT7YaY
 mHEKfKMhrmSVo/0iFD6sdlzLQGmhLN54EHl44mkw2y4wZ8p0F9L1IxLzrXWn4vgx+5sZIsQL6mg
 /QE9H4u0OPPQ+BRsAa54uNiviz1s=
X-Google-Smtp-Source: AGHT+IF+rdH6tOT/AdecJM4+ZtiO/i5nZEUT2l1gB1j+rWG7PYNLAl8FLp02I+v70Pvx6uldAshknbSR61oAITw9Tss=
X-Received: by 2002:a2e:ab0c:0:b0:2ff:5090:8ff9 with SMTP id
 38308e7fff4ca-2ff566689femr1346581fa.5.1731522603133; Wed, 13 Nov 2024
 10:30:03 -0800 (PST)
MIME-Version: 1.0
References: <20241113160037.65679-1-c.stoidner@phytec.de>
 <20241113160037.65679-3-c.stoidner@phytec.de>
In-Reply-To: <20241113160037.65679-3-c.stoidner@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Nov 2024 15:29:51 -0300
Message-ID: <CAOMZO5App0zamP_zcMLEH2ih9=q25VfGEi6k2agoVDAQ2Kwirw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] board: phytec: imx93: Add eeprom-based hardware
 introspection
To: Christoph Stoidner <c.stoidner@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de, 
 Mathieu Othacehe <m.othacehe@gmail.com>, Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Yannic Moog <y.moog@phytec.de>, 
 Primoz Fiser <primoz.fiser@norik.com>, Andrej Picej <andrej.picej@norik.com>, 
 Wadim Egorov <w.egorov@phytec.de>
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

On Wed, Nov 13, 2024 at 1:16=E2=80=AFPM Christoph Stoidner <c.stoidner@phyt=
ec.de> wrote:

> +
> +       eeprom@50 {
> +               bootph-pre-ram;
> +               bootph-some-ram;
> +               compatible =3D "atmel,24c32";
> +               reg =3D <0x50>;
> +               pagesize =3D <32>;
> +               vcc-supply =3D <&buck4>;
> +       };
> +
> +       eepromid@58 {
> +               bootph-pre-ram;
> +               bootph-some-ram;
> +               compatible =3D "atmel,24c32";
> +               pagesize =3D <32>;
> +               reg =3D <0x58>;
> +               size =3D <32>;
> +               vcc-supply =3D <&buck4>;
> +       };

It is OK to place this in imx93-phyboard-segin-u-boot.dtsi for now,
but I assume this will also be sent upstream.

Please confirm.
