Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E95C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:18:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AE40840AB;
	Fri, 11 Apr 2025 16:18:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Se4RDqaR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17ABF84085; Fri, 11 Apr 2025 16:18:24 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1652484085
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:18:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-30ddad694c1so19555181fa.2
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744381101; x=1744985901; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PAkyxSFtRDh1k2uu0b7fV79WKOEARxwKDqyxOycgqIs=;
 b=Se4RDqaR3BsED7X7GHRS6d03gxL317k/vfyai4kzeEzW4Mj1j2jTw/62cXV/OmqWy3
 1oKpadQA5wMy/u9qgy0DIwzYu5Kv4A93YlWfA4MUUuBrgFgAMuFZz538M8ed2hn75n2e
 +Hy0tEJVBcX8c6TIWAh8a0QbMzSQmkgNizDrvwsnZ8+TAuVD75xCbz5s1RJhH4ezUvaD
 WIbmb5AAJq8Y2JlN7gw/eK6a1YO09XB3k3wXSX3rA0Iguvtl39hsCh0U7LgKOIJpWhPj
 NJ0Rph5SpdWUjpYZ/Leu9r+XRbfPoHhJ1dwciUvarode69TQLRrcem7g1kNlLPE1gCYZ
 L+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744381101; x=1744985901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PAkyxSFtRDh1k2uu0b7fV79WKOEARxwKDqyxOycgqIs=;
 b=p5eSJeuH4z1k7HeaWPFJGU98eHHYxNv4iWzQae8OQb5bIe4BE5XMwWqhm2W98l9aHM
 LVRGI6a2E1p/zzg8bdPDfKsMR+MlMu5Wv1U2GqsG8ugBeAtKoD2UYSConPqUsCeIPi78
 k42hOJUweJ3lU4hjhjoMF+F3Irm+e+YQ7UAJbtbvd05JbC7ZLiI/RU79EIHGonk+rzxS
 nMNyHWAxRLEqaBTMrjG4Ok9XYCUtNAllYSsm7TDTZYIMqKdQEmXcvpkx82DxKUUxeOg3
 ebhtTdI9Kw/uEcnancBx7/amgsUjJStkWYubg1Bej6jkHPgr98eNtSYh5rbJ2ZO6Ip6Q
 +IfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk6MTZOxd6Az01JolnUSCHSuB8lHlDS0HZ3Dc8RwZ7lmv/QbISzRRrKOH/5YVc8zyxyr1bOco=@lists.denx.de
X-Gm-Message-State: AOJu0YxamOwC/drvFAzahpr1nr+Sv2v2+BLFwMtjOArrsSwrRDvy+82I
 6qd5JLTE4KQiCJf+aYZk2Tzh28mryBJYo/lPiDRJ8MJUJ/hQbEAFbVz/nAIENbqF83e0xu5CIHt
 zILSbcGjlLMrY78KfArfBoZee6Cc=
X-Gm-Gg: ASbGncsbOLICn3JI8O+mnIubUuWeoKDJ+eQ54YrZQDHN7JZr3k1mrHpDhEtteenaKu2
 IdKF4wQV1mQed9YqSksLiBMISP0ltMgs1QOMFZkAh+TOycf79gYLFdcJ/o+gGn9fGRBYhBKMqpR
 nGNCPB2/JCiCWVlbKOJKYg/rGygcdVXqckYveLYLGfd+KxEeL4DaUZLg==
X-Google-Smtp-Source: AGHT+IHw2x9+rjUxbH7NHxGHyUAuQU6RZGain6btJZod4d1/CGTBBil1YyusDBRT6SiDEO4SRniPPNmhBAXu8DMrIW4=
X-Received: by 2002:a05:651c:1464:b0:30d:b8a5:9b88 with SMTP id
 38308e7fff4ca-310499fb48dmr10117271fa.20.1744381101128; Fri, 11 Apr 2025
 07:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250410084122.1010297-1-primoz.fiser@norik.com>
In-Reply-To: <20250410084122.1010297-1-primoz.fiser@norik.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 11 Apr 2025 11:18:09 -0300
X-Gm-Features: ATxdqUFNgxMYDx_cakHb4YnufxrSc_URLuoy8r-LBM0tjlKp1MyAyjQuXf0n_-A
Message-ID: <CAOMZO5BmgxiSS_Xk=XX0LD9876ZnwD50uwzVbie-FwLx6vQfbQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Update phyCORE-i.MX93 environment
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Tom Rini <trini@konsulko.com>, upstream@lists.phytec.de, u-boot@lists.denx.de
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

On Thu, Apr 10, 2025 at 5:52=E2=80=AFAM Primoz Fiser <primoz.fiser@norik.co=
m> wrote:
>
> Update PHYTEC phyCORE-i.MX93 environment in mainline U-Boot with changes
> from the downstream fork to get back in sync.
>
> Leonard Anderweit (1):
>   board: phycore-imx93: env: Move bootcmd from defconfig to env
>
> Martin Schwan (1):
>   board: phycore-imx93: env: Add common RAUC boot logic
>
> Primoz Fiser (4):
>   board: phycore-imx93: env: Move fdt and bootenv addresses
>   board: phycore-imx93: env: Add optargs to environment
>   board: phycore-imx93: env: Add prepare_mcore to environment
>   board: phycore-imx93: env: Add option to disable bootenv.txt import

Applied the series, thanks.
