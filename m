Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6E2EE57F6
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 23:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBB7F886B1;
	Thu, 12 Sep 2024 01:27:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m49nTw5t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A09AE886B1; Thu, 12 Sep 2024 01:27:36 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B51F288009
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 01:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5365aa568ceso430963e87.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 16:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726097254; x=1726702054; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDnjg6ckfHzPwb1Mk5iKmJtcd/3dCg6JiI6TwH9SsTo=;
 b=m49nTw5tm4OTvyGgvhnz2NtQzny8wKiYMb4F3/WMv6w673kmULQdCwdOksdRJ2nrOj
 0QWgv7sVvLT0592cVe2OkAxikVuwqZcDjZlwaT9983Z/0Y5y5KJ74e3/tFtbLy7CoEUg
 uJKf2k0L/JdBOOFjJpFmpAI4Vj59EO62ndfzHCibCJ+KHcdASMXN8HZBF4azOEkhioiL
 dmaZkHRDMoC9q1ea+yZE/ZTzlS7gNhKUjI7Mwo3aw3Mg6OKiwEMMgvbjJyW9epjwAbST
 pLPb6h6qwzWuEHxyHbTMV8odfdGZEm/6k1UQ41Zpo1XAXoUWan0Ap1mU82qLVJ7SoghG
 DDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726097254; x=1726702054;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cDnjg6ckfHzPwb1Mk5iKmJtcd/3dCg6JiI6TwH9SsTo=;
 b=Ty7Wf/+ezG/51vPp8z5d1baRaSMCg7EN9JWPxQNe4TrTv/mBXqgWdkHT5v8S8crJFR
 SDMTLblVBlEXzKsxdCxhHkJFWkaQUy3qvpVijuZQHsHj+4MiyvqOjtqXXKFMQLWRLogA
 3KcEhvqQUv3Kakistg6jfIgvokM+Hf+txe/tdEVtXtQYMKsmZ5fS2NSnnwV2j6NTdVl7
 bg2tK6ny5vlgB3rPFNJ3qHnIcyRfWv73FGLSAPjq8JEbczHecglcIyBemblRqRy9/+wp
 cbHT3gobGUMcXsjr60lRlLiralEOYenaBy6wGgUCsWsDFTREAO/jwrutAfXp3DHd1JS2
 10Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu4oYjiOUi4I/WyOyu+RHfi1Z4x0kIJRilwwoRr/TWjmdb3cyBVJqEWnVKFH5krtwHZdWgk3M=@lists.denx.de
X-Gm-Message-State: AOJu0YyPOb26MLfBtTlW2qOhzYM4fToGZyPJvIoFgDWpdHoUh6TUmj0u
 simJk8gwE2PCZes6BrxzTZcMZi/Q+YmTVPrBHgesKWwlMZOztHC4fLCMgTCveOAg9zxA2cTI7CQ
 DwF9+GRVzJQ04uidaXSmTQneaSc8=
X-Google-Smtp-Source: AGHT+IGUuOUyN/tOHxrUogrbTR9Oppx2AuUuvn7KarRWKBJj68zzuB8MBLxRUUfJPK8mOx5CvjuOSyRbuMbM9L1EWKc=
X-Received: by 2002:a05:6512:3c9f:b0:535:681d:34b0 with SMTP id
 2adb3069b0e04-53678fe6a7emr752640e87.47.1726097253590; Wed, 11 Sep 2024
 16:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240910091359.102121-1-miquel.raynal@bootlin.com>
In-Reply-To: <20240910091359.102121-1-miquel.raynal@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 11 Sep 2024 20:27:22 -0300
Message-ID: <CAOMZO5Brpa547b-8NnSX0CKNBeAC1fxQTk=bTqi4p5mmr=qGfA@mail.gmail.com>
Subject: Re: [PATCH] pwm: imx: Don't drop the enable bit once set
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>
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

On Tue, Sep 10, 2024 at 6:51=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Changing the duty-cycle should not blindly override (and clear) the
> enable (EN) bit if it has already been set. For instance, a PWM
> backlight can be enabled and set to a specific intensity using two
> operations. The order of these operations should not matter.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to u-boot-imx/next, thanks.
