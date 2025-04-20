Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD2AC369CF
	for <u-boot@archiver.kernel.org>; Sun, 20 Apr 2025 01:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 382EB815D1;
	Sun, 20 Apr 2025 03:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j/fyYv24";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4793F81F4D; Sun, 20 Apr 2025 03:07:16 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F78980BAD
 for <u-boot@lists.denx.de>; Sun, 20 Apr 2025 03:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-54996d30bfbso2705500e87.2
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 18:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745111233; x=1745716033; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z/K5pwAa0dovreixxsPiz/Mt2heGBN0SS3w4Tjk7rF0=;
 b=j/fyYv247HHDUYg6HS82SGaxaq73FbhwZS2PB88iQy4sLrMVHHLdbMHEeJY2QmDAPY
 ILno0TaygWuN4RZfceJPBcLC5qLwcqDK/p9sw+OZWceMMTnKt8e5/gIJwCFvVoNrYgsL
 506tCG97FKZ0xAvhUaHyALjkxkPWpxko8Yju7Myxoz3I7auuHxZ73Bq9xtVwMwehuprW
 MpATT6ivvMPOD+sdr1wp1rCFgBd+HvHXo1PY3tDHuZWMWF8NdAu1CEjZ96NV3C8NkVrh
 Qg4PQeMxGTWBnQH7sMj3AvQlk8ZPnKth4k/brieb0MfyT1M0qFODdeimgfpcTnXmUCjM
 feCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745111233; x=1745716033;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z/K5pwAa0dovreixxsPiz/Mt2heGBN0SS3w4Tjk7rF0=;
 b=Q6bw5K0CG3VYeqjP5imfQBflWods2+EhgYgq3zqGTh8qB+IXkdRPYqPga/FWV/004y
 jzc6tGbFL8NIv1AcFyBPWAfe84usj11bwu49en41ZoM0pD8Z6TxiORh3XTvOOXOd650C
 qi2O35MlXOTuROU6cSq4wPgcBid8mWPfkU04l7hh22kPkkmd4F1JVV5oQWGVh1ICxHeE
 FeqYEmILJyRIYm0GPQfrlyuTogRad5fw7AfmVkCsYDfNi2vvw38a0pHuNhxqYJjIv0RG
 CZqT7ZcCMyWrp7etBjPUuXBNCUTE2GuJ/oSxGnKPYpjA6dG5Lk9t/QNDPWr0V/Ruy8JI
 6qjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuIsVNn3mbnFiAWOC0hd7oLuPxItMoFUdL9lyvKW5RDpXOrDlzBXpa6ntB6KiUEQwGjmM+Pk0=@lists.denx.de
X-Gm-Message-State: AOJu0Yxoc9q7VgaLE7IX1t5s93xKw0pc9oS7v1ziUSZPQZ+iuh+38ubY
 8Rsd431xlglEm7Xt9qLOiBQ2q+EAnMeX3fQBG+eUix/dmgy7pcNlElF57UJyMc7xgcKs8Eoazzv
 TPChXgOzi0BISuH02XIZPrl4jvqA=
X-Gm-Gg: ASbGncuBR87Lq7D0R5OLAgFMr50hIxEWJKew33CKZGCYAKqhksUJZqS0NgIVB9J7Q43
 z27y0DxcH0uYkvX2IBomrnMduqOXxnEt3mQSEBUU50xYgF6KrCMJmu8BxenEgK91N2DBrjh110/
 sBezQaqz8/RMPdQioT9JVdQVVUZT0iHaSwJOGJ3oLVfA/Pbek6oqSMjw==
X-Google-Smtp-Source: AGHT+IFlyoRaUA4vNFxYDDoVdthEFp3qH6ffg9RSgGW9yy0+MgfJr6LJ+vTs+PzJPZlaNdSFwoBer/plCo/04H5lWHk=
X-Received: by 2002:a05:6512:3da8:b0:545:aa5:d44f with SMTP id
 2adb3069b0e04-54d6e636bb4mr1696261e87.30.1745111233198; Sat, 19 Apr 2025
 18:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250417171101.2566447-1-festevam@gmail.com>
 <5eb55cce-28b0-436a-85c4-dcf86e6c6554@denx.de>
 <CAOMZO5C_9yojvxO1NoNjtTHxD85ZcGd_cK2t-rofyY_Zxm1xcg@mail.gmail.com>
 <CAHCN7xLkDnLX5PHFNjXYn7AFXA5+S22aksgv62PpWpg80ZDQmA@mail.gmail.com>
 <d81112ad-017b-491a-b517-de828dd30c25@denx.de>
In-Reply-To: <d81112ad-017b-491a-b517-de828dd30c25@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 19 Apr 2025 22:07:01 -0300
X-Gm-Features: ATxdqUHD-KrdGkbKJ2pse_ZJEtTv2iOOTwrZxODJxmU_1MVbDZ-VHTL6C5XBGhU
Message-ID: <CAOMZO5CpQ-yv=8GhNv7=yjnA+uzzP9ZmB=P2d+xmhY1ktQJX9A@mail.gmail.com>
Subject: Re: [PATCH v2] clk: fixed-rate: Use "clock-output-names" to name
 fixed clocks
To: Marek Vasut <marex@denx.de>
Cc: Adam Ford <aford173@gmail.com>, trini@konsulko.com, lukma@denx.de, 
 seanga2@gmail.com, francesco.dolcini@toradex.com, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>
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

On Sat, Apr 19, 2025 at 9:48=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:

> Try something like this (also attached), maybe this needs to be made
> generic ?

It works for me:

Tested-by: Fabio Estevam <festevam@gmail.com>
