Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC75C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 14:42:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 210188022B;
	Thu, 16 Jan 2025 15:42:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fB14NliS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6788806DD; Thu, 16 Jan 2025 15:42:00 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E064D80214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:41:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-3047818ac17so9397721fa.3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 06:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737038518; x=1737643318; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7h/Pv37Nfw4BTpccO0LQNLOYEFGuQWXxsgKQnoplGuQ=;
 b=fB14NliS9sBUore73+xmVXgo/AWOx4bX5zFS4wxCi6SomNjmuThVB3ugrWYHzL5pJI
 ftYjd2+ABvmA7MzvnAji3UAoWADLGjc16O2BEgkWEJUHpjQ13bhB5RZuuW4G9OK0DK8P
 dPCGhHds2SJbmJTiGJi7IR4WZyboeop1FjPbdA25AVAv03pDvT2divuDiGd5RRjI5TKz
 YbeiviqY3aP4AmgTaTdJQDyNGfP6WGOd7boFEHU1gJVWELfVI78oQ9H3T++d8+utq74l
 E6nTzzYeziWhIu3H9P87QqpyXO4YM+/gg3/QGR6Tc2wYN1j6GdToc7Ug22q6njotb7nR
 3JFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737038518; x=1737643318;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7h/Pv37Nfw4BTpccO0LQNLOYEFGuQWXxsgKQnoplGuQ=;
 b=cEWvGCiAGsJXjd3sKzK1p4h3kvZQ8KAu7ZXEgcChpFAAjaqZJ/oqBL5F9tQ7momz2+
 bT8rip0CLUwQcniLumSUAj8T3LieC+qkhyLYuBMgAJAAe3jYZONW2rUJ+DZmtKur4l0y
 pidgKFczqIyEy04sVfboKJc4kGoHx/OGQRvx0Wyh+GMkrlzLp76nxKudTA3p6GY/Td0F
 5HcvB79V0RdAM7vbd+sBei0pBXgak5nD9AVlgjnukLt7XJCrX4U28/XObeC86I3IHSTT
 f4BJy2OhQj4KLG1MwALUQqG8ci32F2IPa7Be+9XgdKL6pTBzf62Xd9/PSQwjcGhwHikB
 2LNQ==
X-Gm-Message-State: AOJu0YyBQo6GmNYe/p8CpXu8CT3VeKG0C5N+Wn9rZHBEHlfzN24d4saR
 qG8ZNi0NHp1Ndm65HWBjKd/1zST8XbgVdPOZ8v+2xa8nYf94GnTpwYpesMMQBn6Vo/GNZuPSgNG
 bozSz2A+1yWZQ5y6fI37qdPB2yYw=
X-Gm-Gg: ASbGncsjcKqY4J3fNAwH1v2vJmW2TFfK7L7WyTS5hxY/OSv8cIeR+djxOK0/jhK2kXx
 XefsJwn/iy6LdSPRtFH5ggUWcTm0VCH0XwyUBtvR+B2EvHgdcwTURup4jEtj9M/4gTHn0UQ==
X-Google-Smtp-Source: AGHT+IEoDSxDj+4qhLKCtHCLI/FvCk098BSSgbqezhCCZbs+2rnyLAy734W3T5GM+6R/XEVSa4GjyG+IIJAw86PImHY=
X-Received: by 2002:a05:651c:1504:b0:300:c10:7c26 with SMTP id
 38308e7fff4ca-305f4535890mr124607061fa.4.1737038518082; Thu, 16 Jan 2025
 06:41:58 -0800 (PST)
MIME-Version: 1.0
References: <20250113211518.1276899-1-alexander.sverdlin@siemens.com>
In-Reply-To: <20250113211518.1276899-1-alexander.sverdlin@siemens.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 16 Jan 2025 11:41:46 -0300
X-Gm-Features: AbW1kvaEjig7G-euge28zH6QKvAJpMtiPKwbCieeI0HGEXgGGtRV962x0IxvNlw
Message-ID: <CAOMZO5DKUvyTHv8dRy7kQoPcxMpWYj=jQUvt-wRqYYSR7FXLXA@mail.gmail.com>
Subject: Re: [PATCH] configs: capricorn_cxg3: Enable CMD_WDT
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: u-boot@lists.denx.de, Anatolij Gustschin <agust@denx.de>,
 Heiko Schocher <hs@denx.de>, 
 Walter Schweizer <walter.schweizer@siemens.com>, Tom Rini <trini@konsulko.com>
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

On Mon, Jan 13, 2025 at 6:21=E2=80=AFPM A. Sverdlin
<alexander.sverdlin@siemens.com> wrote:
>
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>
> Capricorn boards have WDT (WDT_SIEMENS_PMIC) and U-Boot is not configured
> to trigger the WDT. Enable the "wdt" command to be able to stop the WDT
> from the command line.
>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Applied, thanks.
