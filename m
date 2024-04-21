Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CF7C4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 20:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 538948830F;
	Sun, 21 Apr 2024 22:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HH6lKIEJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80C1788313; Sun, 21 Apr 2024 22:24:20 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AAAB882DA
 for <u-boot@lists.denx.de>; Sun, 21 Apr 2024 22:24:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2a2cced7482so504624a91.0
 for <u-boot@lists.denx.de>; Sun, 21 Apr 2024 13:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713731054; x=1714335854; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZ2rCfYmhsON6R183mD4MggUhh+yg2etiMnidjibyhw=;
 b=HH6lKIEJzkbPTcbAsEF2RU1xeXSkcnYmr5j7nXR+gcCpPFnhn3qvLWHHw/TA4GzmZX
 cHL2QK3OsGeqdM+abhf+IIofUoEfo+HqBJ4y2X1UtEU47zLx8iWw7n13AT6h7UZYNkM2
 uIKhD3VsOt1PxNVEZ+AQW61akutZRsOaOwplYEdOr2d7GFot9Q5EfVxVALOyxAcMpZr1
 o8TsHdDiyg6sYTI9wzFx8JEFWnPwZy93gDPT/Lter47gnsx1U4RyDWq6AYa0w5kaX2E9
 7+lUPBf/KM/lWry5HUMfivlcyc64TR0NrNuQqg78OkxgM2kpUnTr+G2k7br8Wb5cfTFC
 qNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713731054; x=1714335854;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CZ2rCfYmhsON6R183mD4MggUhh+yg2etiMnidjibyhw=;
 b=tf3QZ7tZb9LjZn6bkZVNw6HhcAij2/K3xHORY6owaHN9Jmg+pKu9CZCEsE/Dga+Xq6
 d/FaKQZjfu5E92M7WG0zgC0kTT5YjhIJ/tizsdKcQzvS7JBz+gPFyixFu3geB5WEGTxh
 vnJdJ4xMhg+vXYCqz8Rgyjy2t8qE2sSuwnMgyvHM2LLhMdvXmlYBSTTQ7czh6gXpTYGC
 eWthIJHztovej2a7m9Bejb/brUJl39FwgWtByY1n+Ow8/vGJt4gFUqu6H6zWjLgnTz+n
 tvbpFJtYWa7ZCf744zS4+9tnsUeX0uPCC2FYbv9aqDDqqbXsPX3ob/wvyDiBqWqIXIq6
 wygQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUshahLjr7r5GfT5qgTZ02GzLHR1WLlkb1LYMvLWBthSzUwd81O+g/9/NyY/KP0Szhh8izDE4lOxVopcjGTagb7pgKaeA==
X-Gm-Message-State: AOJu0YziJonc5DcWUyKVDwUSacuqAIlig8oW2on4tlgtoFD4qgb7Yr5a
 2/QrU8VCjCz9CDPjW/N6nttvp4F3EepzDEkVgNNoitZs4zBcgSeVUTI6m1/5kdgzLL0vMli4A1o
 5994TZv8Y6Wkfbj6LYEueE8jN6uhz6E15
X-Google-Smtp-Source: AGHT+IElgjUrezzR+YhGxU99Q7haCaRRl1IWsONVUkJG/F3ZkG52IO9nrNleqxiz1ObdgFqnwNFxWbsiEMyRjs4tYZw=
X-Received: by 2002:a17:90a:70c7:b0:2a7:aa52:5568 with SMTP id
 a7-20020a17090a70c700b002a7aa525568mr7837921pjm.0.1713731054153; Sun, 21 Apr
 2024 13:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240421140745.25870-1-michael@amarulasolutions.com>
In-Reply-To: <20240421140745.25870-1-michael@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 21 Apr 2024 17:24:03 -0300
Message-ID: <CAOMZO5DbWbsT==bTczp9b4uHuBR6dPsbsHEfoJTugTp4zwTJjg@mail.gmail.com>
Subject: Re: [PATCH] clk: imx8mn: add video clocks support
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
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

Hi Michael,

On Sun, Apr 21, 2024 at 11:07=E2=80=AFAM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Add clocks support for the video subsystem.
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

Which target will make use of these clocks?

As-is this patch adds only dead code.

Adding a defconfig that uses these newly introduced clocks would be nice.

Also, to avoid size increase, please protect this code against
CONFIG_VIDEO or something, like done here:
https://source.denx.de/u-boot/custodians/u-boot-imx/-/commit/2b3310ef13998d=
fd03196a0806e03035212b102c
