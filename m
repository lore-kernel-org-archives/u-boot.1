Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D830C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 12:31:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE2F687168;
	Wed,  6 Dec 2023 13:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HG5019cr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFB2887168; Wed,  6 Dec 2023 13:31:29 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1194869B6
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 13:31:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5d96efd26f8so24621447b3.2
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 04:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1701865886; x=1702470686;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KhlAHh+0kwtBQrrvGkpCsY40H06HdgHoxZlBapYb6NE=;
 b=HG5019crNnfe52TYldkLDKxZD1obuoofGDBnZhh2JsJLdvsg7CT3Y1fboR0B/xkqEz
 8X51n9FAuzfsUIhXn5lMAORg/TRBx5oky6sQcCul9Ra+r+830ZDb8qOIJ3bZS/FY7kzJ
 ZkH4DRuw6F3sOTdbSKiwvcPzCOcIB0onzP8vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701865886; x=1702470686;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KhlAHh+0kwtBQrrvGkpCsY40H06HdgHoxZlBapYb6NE=;
 b=kCfmetTCR8KyebTynXEOAEr1+tE3Danh22jHTu9ey2nbZejkJXioP8Vo4rwoi0j1Fa
 t+ptO9Jjxypn4sRMjFl3yS5EAJZ/AWC6zh3eNFgtadjZfZeMOyJEFABrQJfDTJejaxuQ
 wXQO1bE/8xpzQSDN3nZ/AY/AYPx55fOvFBJtnVSuymX0+vCvvc/R2rhH9h0GDNFsMlBP
 FO4ao1vYu2VhY2pU1FpItHixJctwW7Ql0PckPf4+3QXLh7jvRTT4fCIp9vnUywDa4LGu
 nmf+aTMV6dR4m60QA9V6PPQeasZ38/l8cu4kv7R7t7aXtkRpoUkni7RTyv0l8zm3Bq3U
 APlg==
X-Gm-Message-State: AOJu0YzCEk8kLlZPHdUEbIFvzLwThjGPdVT7y4OsOAnMNNHaPNj2WfQp
 98IO3ibRUEXNnyQLja/nwo7soLD0mYlxu5pTDy24Iw==
X-Google-Smtp-Source: AGHT+IG+g8L82ihKmle4TRyajqWcd2I9UMRWWutIx7FxX5cISsPqf0pjhrbd6n0xj9VAsj8bUAtJxGFOD30+tNu20WI=
X-Received: by 2002:a81:4515:0:b0:5d3:f707:1b84 with SMTP id
 s21-20020a814515000000b005d3f7071b84mr603146ywa.5.1701865886271; Wed, 06 Dec
 2023 04:31:26 -0800 (PST)
MIME-Version: 1.0
References: <20230812020319.56580-1-william.zhang@broadcom.com>
In-Reply-To: <20230812020319.56580-1-william.zhang@broadcom.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Wed, 6 Dec 2023 18:01:15 +0530
Message-ID: <CAMty3ZAhpauhwqR=ZT7zDWggnibjW+Dz5_OFDmouH0g3cLOUeA@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm63xx-hsspi: Fix compiler warning
To: William Zhang <william.zhang@broadcom.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, anand.gore@broadcom.com,
 kursad.oney@broadcom.com, 
 noltari@gmail.com, philippe.reynes@softathome.com, tomer.yacoby@broadcom.com, 
 dregan@mail.com, joel.peshkin@broadcom.com, dan.beygelman@broadcom.com
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

On Sat, Aug 12, 2023 at 7:34=E2=80=AFAM William Zhang
<william.zhang@broadcom.com> wrote:
>
> When build for arm64 target, comipler reports the following warning:
> drivers/spi/bcm63xx_hsspi.c: In function =E2=80=98bcm63xx_hsspi_xfer_dumm=
y_cs=E2=80=99:
> include/linux/kernel.h:184:17: warning: comparison of distinct pointer
> types lacks a cast
>   184 |  (void) (&_min1 =3D=3D &_min2);  \
>       |                 ^~
> drivers/spi/bcm63xx_hsspi.c:298:22: note: in expansion of macro =E2=80=98=
min=E2=80=99
>   298 |   size_t curr_step =3D min(step_size, data_bytes);
>
> This change fix this warning by casting the data_bytes to size_t.
>
> Fixes: 0e144ec38cbb ("spi: bcm63xx-hsspi: Add prepend mode support")
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied u-boot-spi/master
