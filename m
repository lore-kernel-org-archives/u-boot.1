Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDD0D6A238
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 21:44:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EA468968D;
	Thu, 14 Nov 2024 22:44:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lh/g/3sl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA6A789690; Thu, 14 Nov 2024 22:44:52 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14F7288FC5
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 22:44:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c9693dc739so1724484a12.3
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 13:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731620690; x=1732225490; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6oyOedpcBUkIxugdiQwCQ+kHW7q65rj/xhFlhh51gIk=;
 b=lh/g/3slDuImNvT9hfr7hqIJpsn+XmMVPrM7G5Ee+I3PymWERs65VzdPxU+TGY1xJP
 ja+sU3GGxvn1BZR1M+i/B4SuabAxyHfOya41MQIzISrdFPacmrLIPVTb94UwP4sGjqsM
 wqpSUYq7UFUxTt+H1177i4aQgb5FpNQhWjp8HaFbTPbPqnnbDrNIMtgJYnGDs0i0Iyo/
 GJkWw/pukLb647w35x9KCEvK3UhjI1SK25ev1yWTtYLte2/VJWV/BlRibsQH4M5qZnTC
 I0BFFnZQWX86SscinmSRKHvzLUmOxGvoMfshKN2RnHvwdv17OKAVJCBGxQj+TL9ha0wo
 IVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731620690; x=1732225490;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6oyOedpcBUkIxugdiQwCQ+kHW7q65rj/xhFlhh51gIk=;
 b=Yq/ukOp6OPT1mffmFSg4AQnigDLje3gh0inInTYLQQ3emnPamqQzKHJjq7L2k5Z621
 u34ca3GCPH3utU+3oadO9Go9/4kDjCn2TFLigod0wbv/TOwmHyoIlPLkASe9sKoO782N
 CBFimzqHzApvUxrVH0+Z8clEOa6UBX0h724OD9jc1Xlv5lsIRzW1mW60p04Gn+HCqz1K
 69MbFygaWET8saflDN2TjZCIxwn8kxec0meK4fqCvmGpsqLyW75WDTMMxoDpkgUXWUu6
 kmsnXYE2ZN+hFLz4eO6qhm90903b2E90ZT9rPQzfrako93bUqQpfNPDAs7HMz7kFXo1V
 aGgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6ceHzuxLIeVsU651tIA+wXqgncYa2rCk09Br320/MMQl6yI7Lpii21lyy+XyEO47KRLLtAgk=@lists.denx.de
X-Gm-Message-State: AOJu0Yzo+qFyC6sLvpg9FsCk7qt+4mW5ETVjT6uA0Zk8hsZyt6X4d4i9
 blkHtuZ34RftqwqojU2l3Fpn1vhzlIN5lMudibaNT6KOFeX428iI8zHxptMcY7GD8QWzhRmaBkZ
 R2qf0GeylhXcfgG/tjGDt1UuUdU0=
X-Google-Smtp-Source: AGHT+IG06yqfkXIkkZYbkYiHiJPUfGDrW4xBOIya5/+s00OKzdb/9fTYpP/8ZikZHzpRMT1mGgVnn2McJni4IRWIcXo=
X-Received: by 2002:a05:6402:210d:b0:5cf:44b3:36c with SMTP id
 4fb4d7f45d1cf-5cf8fc5374dmr112511a12.1.1731620690226; Thu, 14 Nov 2024
 13:44:50 -0800 (PST)
MIME-Version: 1.0
References: <20241114200856.3450012-1-caleb.connolly@linaro.org>
 <cf9b422f-beec-43e4-b0d4-b0bc7838bce3@denx.de>
In-Reply-To: <cf9b422f-beec-43e4-b0d4-b0bc7838bce3@denx.de>
From: Tony Dinh <mibodhi@gmail.com>
Date: Thu, 14 Nov 2024 13:44:32 -0800
Message-ID: <CAJaLiFz9JA2QVxC7PY+t0LU3A1C2Y9GxLH2-DJaDN5W2mufuCg@mail.gmail.com>
Subject: Re: [PATCH v3] cmd: add a fetch utility
To: Marek Vasut <marex@denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sean Anderson <seanga2@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, u-boot@lists.denx.de
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

On Thu, Nov 14, 2024 at 1:36=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 11/14/24 9:08 PM, Caleb Connolly wrote:
>
> [...]
>
> > +             case IP:
> > +                     ipaddr =3D env_get("ipvaddr");
>
> ipvaddr with 'v' in the middle ? Shouldn't that be 'ipaddr' ?
>
> > +                     if (!ipaddr)
> > +                             ipaddr =3D "none";

Other than that ipaddr.
Tested-by: Tony Dinh <mibodhi@gmail.com>

All the best,
Tony
