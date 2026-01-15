Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAB0D44C48
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 14:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F189B836AC;
	Thu, 15 Jan 2026 15:25:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qVQWhW7e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 781EF836A3; Thu, 15 Jan 2026 15:25:26 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 649C080077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 15:25:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-652fdd043f9so1836389a12.1
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 06:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768487124; x=1769091924;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JaAeDM0jsFxZKxb3tjZSC1MsF2lZpE2rQK1aip4JBW4=;
 b=qVQWhW7ec+9a8HiOGHaJZSQqJswFjodvGoDC3KGk/HJho7p0rcCYIHgqE0Ag1ply5O
 8jYpIJhJqEi2lHitl3Bahckd6B1L9RBAAFUpbLwZNwUCecdiswfAWL13Ayj3wEBiOBK8
 dDUhHZ8usy9LQknT+sfvv6fZG8INrykWopKO95HJ8Rs2uu2Fuy25P4M9mMvFQqIO1+Zg
 vkOAvrbUf/WkF0QBeKLITaLCU4upzPE3a1P7aDkFAdJqFEvVMxxCas+U4jwF80BIZin7
 UCMYY1d7XidU6iv2KbqS0tSG3L5619pMOsVxv7HJVfRW8XBgDYbBzXpK++fu3hF+8vnL
 FVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768487124; x=1769091924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JaAeDM0jsFxZKxb3tjZSC1MsF2lZpE2rQK1aip4JBW4=;
 b=HVKsSurdx9QovrXNPkOwLNKUl1QXsv4kaXMB/nYZeHdFR1aoYhitZu8etTc+FQnmhh
 pZdLvJfyw/wvta8n+kU7/1ybMgqu+RZPPd3UGXh5eerWwTlAzyzZnQ+H1Z1FAY93T/Dq
 M0+bSKKB9FctVSR0Ey5fefnkOWJevZ7UcW+EtQUKbHhNjOJ7hzLEFun1hrRtsm3Q7RZI
 ZPoRQd6I/GpicRPghh1anUamMkLI839Yzl6oZY2F7Q6iTqr1loHO3mfRz9Lp1sNtRY0u
 FquyBfM20bCZMQ6wFXGT1pKy8MEsF4HOPUWfyvEJYwDbK/WajBt48sHmHOpTUjvqxm0f
 ezNg==
X-Gm-Message-State: AOJu0Yz0QnJCZ6QuKZzYq7gOjXDykTKJW0H9GMYiyWSxWnDkVaSRbB7e
 DEDhRQICR/mYgWmZvYdqhobpG+mx3c1pRRJP8307hLsqFcPUyHE6MFw5BzHvvSNEnnktTOSJpkY
 zOcErLomoK5K+72tKL+QvuUo8/5IFGlyWtSBSQIEINg==
X-Gm-Gg: AY/fxX5qDFCxLoiMg4BkQRhiarlyF8t/QD0BNYW+h3GjkaZqv7PPQ+RbaLqnlsQ1NqA
 eFAlis+X7AJYJeXGcx2vydYxUvQzrtJa3Qo8VxZyCPqiKxkrYkvg6Yk41Xr+N+ZikRs9ypCVYWL
 Ruw6TdnnJD3o6nMy6wZEEuT3ydOojwsfM0h6rb5LZtSiWv0hGs4VtpWv9RFN+SL7xGEZobtG/BN
 ScodOWQ+rEI0k6HGVQNppObxLRRfihITNk4uS1DLNiEuDtNQhG/khkjPMf0CFsRar7uo/sYHvTV
 a7ReMoiCLhWlWMjMR3IxXnuEPapT8w==
X-Received: by 2002:a17:907:2da1:b0:b86:e938:1b26 with SMTP id
 a640c23a62f3a-b876775d962mr507680466b.24.1768487123764; Thu, 15 Jan 2026
 06:25:23 -0800 (PST)
MIME-Version: 1.0
References: <20260108-power-regulator-fix-compilation-v2-0-b00cb3268059@baylibre.com>
 <20260108-power-regulator-fix-compilation-v2-3-b00cb3268059@baylibre.com>
 <a850f6cf-bd2e-442e-9898-7b1bb059a27e@cherry.de>
In-Reply-To: <a850f6cf-bd2e-442e-9898-7b1bb059a27e@cherry.de>
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 15 Jan 2026 15:25:12 +0100
X-Gm-Features: AZwV_Qi0AnAYkvHw4142GTmQWMAZgk0fswPohUtYqIl_Rs6ws6HzLiaE7miaf3E
Message-ID: <CAEHHSvaA872nY8zJt8zkpCjFw5E5sri3Aq=VEs5wTGjche9uZQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] power: regulator: common: fix compilation issue
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Ye Li <ye.li@nxp.com>, 
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 David Lechner <dlechner@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
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

Le jeu. 15 janv. 2026 =C3=A0 13:57, Quentin Schulz
<quentin.schulz@cherry.de> a =C3=A9crit :
>
> Hi Julien,
>
> On 1/8/26 3:42 PM, Julien Stephan wrote:
> [...]
> > @@ -51,10 +53,10 @@ int regulator_common_get_enable(const struct udevic=
e *dev,
> >       struct regulator_common_plat *plat)
> >   {
> >       /* Enable GPIO is optional */
> > -     if (!dm_gpio_is_valid(&plat->gpio))
> > -             return true;
> > +     if (CONFIG_IS_ENABLED(DM_GPIO))
>
> Missing check on dm_gpio_is_valid() here?
>

Hi Quentin,
Good catch! I lost it in v2...

I'll send a v3.

Cheers
Julien
> Cheers,
> Quentin
