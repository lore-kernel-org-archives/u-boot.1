Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A3CC6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 18:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F0E888296;
	Sat, 30 Mar 2024 19:07:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="flKbkM1P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43C9088299; Sat, 30 Mar 2024 19:07:29 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3733488273
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 19:07:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-29f8ae4eae5so939957a91.0
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 11:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711822046; x=1712426846; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yXh0HT1LuafteRU4oWhx+idmMrocYQLEL+3MygG33CA=;
 b=flKbkM1PFlvVdxS7D0Uq+6hlGEUujU4iE4GvYR94dmrPVtafqc2NpVuob5UdHImKSy
 ywabzFg67t3mKK+seAIWXdVRlsjhzm5vX2WTdXBAi0t+/wdjC2Pr+f76v3rW3878bqAa
 p3fRIhqqmj1vn2W+WyjkRK2Bkpu9ahf3h12tq5Sy+4LzqjglvE5pi2caCCW8g0A7TynS
 1ersp1Mxwd+GEe7Yh1GTfhpca6Pi4kMycaEv4NZdkSbinbP3+Q/P8bkqhXRliK22L81E
 PCwXPpgVeJ04ynT1OyyD1pPnec0gcZgNuJeuFQZs7+4+6kayuK6UcP9GbJ5Mk4rmG0iZ
 qHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711822046; x=1712426846;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yXh0HT1LuafteRU4oWhx+idmMrocYQLEL+3MygG33CA=;
 b=iLPf0eKUSQprhlHy/EXC+7rPJ/qVx6p2WEy+ZxIv8lRAPVy/s8Z48339/ddPd/laGF
 0N6t06b5w/cCQ5jUgtsi9yjgdNrmvKhFNB9rWDgohTpg2FcJR5MXlzCgDuZ4qQlvNvmt
 hd5WDhzPaH2ioKDw29irIQq4P7erIbonA+0NztN3pBJTc2XQI8QO1nT60A42k+zdYMjs
 /kQHAfUwAW6tZVCyjRXMqNMIY86rkH2aKwBLeWDPXpDYQ+LohvYxLeNTrHXa092Zi/z9
 gb+Snrq022FZoFxSk67NJLq8slh0JWmo4fCIzRwrDD0N47UsHqfw31sYmwb7zgTbxRsS
 lvaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQDPbw79R6LJwKfsIqVxQ1S/bV3nxh6spOYiHz/G321U2Rh7gRtbqw00RRLdEHkmunpC/UgndHai4MVET3FRk2kvieVQ==
X-Gm-Message-State: AOJu0Ywvvfl18yHA5Y1xO6gBljnssbq/1Itmi/W0mMYaPIuaSjMyl9ev
 Nq9hNjnuevG99DtbYrIyc/1hplQkRk0CgJxywa6DEk64iyedYzTi5ymIXQ02pjHnezt9Q/7TBxl
 wbmMUUQwt5T8Kc7meiLcHEF93+LY=
X-Google-Smtp-Source: AGHT+IGYZFizcN3Ma5TDp74tXhZu9rDa5s7JMwgRVv1DB2BzKykP9b3d/y7MtRZHB3qmlRsmJFZfBB7HFAqaWao0ygY=
X-Received: by 2002:a17:90b:1bc5:b0:2a2:e20:f9e2 with SMTP id
 oa5-20020a17090b1bc500b002a20e20f9e2mr5274251pjb.2.1711822045728; Sat, 30 Mar
 2024 11:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <1711622882-61969-1-git-send-email-ye.li@nxp.com>
In-Reply-To: <1711622882-61969-1-git-send-email-ye.li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 30 Mar 2024 15:07:15 -0300
Message-ID: <CAOMZO5C5UmX2xT_GQUdumdVGBwap16AokKKYe_JJN5oZLnyd1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: imx9: Correct imx9_probe_mu prototype
To: Ye Li <ye.li@nxp.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, peng.fan@nxp.com, uboot-imx@nxp.com, 
 ye.li@oss.nxp.com
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

On Thu, Mar 28, 2024 at 7:48=E2=80=AFAM Ye Li <ye.li@nxp.com> wrote:

> -       ret =3D imx9_probe_mu(NULL, NULL);
> +       ret =3D imx9_probe_mu();

This series breaks the build because you missed updating phycore_imx93 and
imx93_var_som:

board/phytec/phycore_imx93/spl.c:       ret =3D imx9_probe_mu(NULL, NULL);
board/variscite/imx93_var_som/spl.c:    ret =3D imx9_probe_mu(NULL, NULL);

Please fix and resend.
