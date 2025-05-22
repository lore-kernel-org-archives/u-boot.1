Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8B3C54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 13:05:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EB448309A;
	Thu, 22 May 2025 15:05:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H7DWZKUS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27CEC8309E; Thu, 22 May 2025 15:05:56 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A8F08006D
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 15:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-32918fe5334so47438801fa.1
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 06:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747919153; x=1748523953; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oYjBT0QP/BAqy9duXXruwluHAG6rZjizLXFLhlGSDSQ=;
 b=H7DWZKUSjWe4poAzPG4pf31DRczsLr+IU4R+Mf1R4rrJn2jvY6/usb3xoGS57Olyoj
 iIFZpbKMGz/P0q7vEfMVW+hDpkEPq20Jf/Dp40XQGSyA7ScTraOt16VLN/vi1Homonp1
 +BRiDkDlfTwBW3bnEV5JsBNcmVfUdnhH9a5bE5ftXtXtxTIi5khny3AqKAYjzr0DjWn6
 hKLX539P7hq/1hZRNFota8FzU0Z5WAPMUx1KCfvkNPk8XxanIjkcMdRYnEnTQkd8glsK
 tEfwu91LhmXJnuyUbWY6nDioMAvKv9Tz/MCXKoBViPppLAXNHPxRgbWoBGwygGmrqLpQ
 nTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747919153; x=1748523953;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oYjBT0QP/BAqy9duXXruwluHAG6rZjizLXFLhlGSDSQ=;
 b=xF9PC9rJywfvLPN41PMCQMnA9ZB33q0gZH/bh3ewW7oZsIHPDxETraLrKzzJ5XGBeD
 /fP3fATNd2vqhG+YpMEIW0SilaG72gg4c8OaRfe5LEFkcuFmvRq3r5NHcHbDIat58vHl
 wMikx9olCuzD9n7aN1fJIXYIdIP1v/YzMimHk62MNOZXwZOGjUMWkJLWmPgj2YlOcLQO
 yT5hdwGNAx0sKKWHYQkFKowQg4jki+4uv9wiVDEiapO03j9OuN7OtgLzMNs3NCVgp5Wx
 sfeCxFFk54LCc4Ti85xEBOwHeeSKfxedZDb6eehIw5fQGWm609ve4YGdF9lh7j6qr/8v
 sLcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPiZv4Jy0cvdH23ToWLnkFiC5seopLsU6iDOxLkeK/6oPL4FMc9Zh0vk7XM4/nruYIta2QGTA=@lists.denx.de
X-Gm-Message-State: AOJu0YxEJ19AECChhiw+ZUmgikaYueEUFR3StVbRSQLGeIjb+DlmZq21
 /Wu1A7ydvdTXlRTFmnXEr6TCP+58EFoHFKCaBQ5BT2qfBYIeU+kwELrYL7BlrhhYTqJndWtF0+u
 Orb1F7bNyI4wunuctkpNWUvK1OL5jqjtWrg==
X-Gm-Gg: ASbGnctbLSTg7XzyA0E3L0ViHOm4xA/UljekfGi/6v3DPgVB2p3h8GURgAFaaTwAyw8
 f7qW5LqYTumlX1Yfopv4Mh4Y1wuGX8vMqyAS7KOnRD8zOHyNJab452+i+gn4/qRmZS6UkH7agEr
 QVL6OsaWnZDiKos7k47z828i8rAbIMyWh9WrFylhH3/uKnvB00P2DxVzw8K/MezQk=
X-Google-Smtp-Source: AGHT+IHWKSoiYygSxTp0qxujBYschjBow347FbQkFmCj0tdYX9a1baLWK2DLPjBD3riOJMg3GVEuHNZOQD+vq3uub6A=
X-Received: by 2002:a2e:ae0e:0:b0:30c:11ef:98ea with SMTP id
 38308e7fff4ca-32807733addmr71719401fa.15.1747919153146; Thu, 22 May 2025
 06:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250516104602.2445510-1-primoz.fiser@norik.com>
In-Reply-To: <20250516104602.2445510-1-primoz.fiser@norik.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 22 May 2025 10:05:41 -0300
X-Gm-Features: AX0GCFvxO1COCYjUTUACZbXLZFRFsBU1zjnXptja2WWbNH8pt9fg9-rEh92oGM8
Message-ID: <CAOMZO5DJVs4DXLOir=sZ-5aQ9XOo=_1=KD+JNZc0yWWeXemt6A@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx93-phycore: Migrate to OF_UPSTREAM
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 uboot-imx@nxp.com, Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, u-boot@lists.denx.de, 
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

On Fri, May 16, 2025 at 7:46=E2=80=AFAM Primoz Fiser <primoz.fiser@norik.co=
m> wrote:
>
> Migrate to OF_UPSTREAM for phyCORE-i.MX93 since board can use upstream
> Linux kernel device-tree for phyBOARD-Segin-i.MX93.
>
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Applied, thanks.
