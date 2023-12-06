Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100D1C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 12:35:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B69887775;
	Wed,  6 Dec 2023 13:35:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="p6qNXKPn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B867087796; Wed,  6 Dec 2023 13:35:40 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94AFB870D9
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 13:35:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5d8ddcc433fso28705237b3.1
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 04:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1701866137; x=1702470937;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SHcHiTpsy3E+y/RqylSoycDPmat09XK+iUKNrf+z6pg=;
 b=p6qNXKPnL27znDOrlmg4FwpQFSqBKJDNx/eBj8xkT945SEOf6/jlOtfrFo4NQLF/KY
 Y6Tb1dAnQm/WzWCOe0Fi4XIPPG5Es2loC18UUXYHtJBWv8ey8BqHYQ4n+fbAU5WvwHyn
 qnWp90V58vT5Lp+LxJ0/vB+Xj89iUwiPwcncw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701866137; x=1702470937;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SHcHiTpsy3E+y/RqylSoycDPmat09XK+iUKNrf+z6pg=;
 b=QE/n0DOkhfHINuqOs3FpxVOGPcSuDEON+dvD/QF2IYZvXLbGWq5u7s1kCbKvEvxW5a
 ft++6fzsYP/6om2qoBYu9OvLfMhUMNkxlV2NiOZhHa9cJjAEW6NdhdWS6Qm+XaAS26dn
 DSB975SjNNBcAOW5k0GDYOuyvCRcyfRXGZgubs+JC2KFXvKn8CaN05XNbYmPageSgd9H
 kkKsHBhxOX0FDcEPI7I2650EekpqoTndE39g6m9sVvyglkGO/TGif/u06W2Jco75SBAU
 shNVgacEhLTlJ03Lmc4QxbNsECkMqv5PhNQlmCqcFX+/8oPI8hHPdlVzVNHsA3Gs4Hht
 028Q==
X-Gm-Message-State: AOJu0YxlX8cyxel4+BC2oWNGuXy6gnm9iHV3mZKpnV0bSEFHaeupRcXT
 MbQcLcm389wvnoALZElFZeM+PdZs9aLbMaf64uu4rw==
X-Google-Smtp-Source: AGHT+IG+5p7sRaC20beHf1BSGheFubc5OfJWSVzkCbKcYv551MjTrwQcQ678C2IG+e6B1C87BiXLVJcTns0AruGqK2o=
X-Received: by 2002:a05:690c:fc2:b0:5d7:1940:8dd9 with SMTP id
 dg2-20020a05690c0fc200b005d719408dd9mr461731ywb.64.1701866137287; Wed, 06 Dec
 2023 04:35:37 -0800 (PST)
MIME-Version: 1.0
References: <20230726214401.929533-1-jonas@kwiboo.se>
In-Reply-To: <20230726214401.929533-1-jonas@kwiboo.se>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Wed, 6 Dec 2023 18:05:26 +0530
Message-ID: <CAMty3ZBdqT5yT0eMVv4x_h1KcrZh62h3hrgoxqhsMoGDQFprRA@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: Add support for Silicon Kaiser sk25lp128
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Vignesh R <vigneshr@ti.com>, u-boot@lists.denx.de
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

On Thu, Jul 27, 2023 at 3:14=E2=80=AFAM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Add support for Silicon Kaiser sk25lp128 SPI NOR flash found in Pine64
> PinePhone Pro and PineTab2.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---

Applied to u-boot-spi/master
