Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFF6C47DA9
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 12:16:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6116E87C37;
	Mon, 29 Jan 2024 13:16:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AedJQnuX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7F6F87D8A; Mon, 29 Jan 2024 13:16:46 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1233876F8
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 13:16:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-db4364ecd6aso2013503276.2
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 04:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1706530603; x=1707135403;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iq++AwmA90ergHe4wVvZRAOl8eLBbfI5Mb3CxxKjf0Y=;
 b=AedJQnuXoWM9vWAcd3BIU1CWEZlK9uAMCe5ijeIgT8XJcKQ5Me2tPrYfAHycqU6RLX
 NB/rfADG7SX6IyKlW8Qr92zSiyY5VkB20qyczxWq9WMl43iv25xBzrEIzQM+53eTsUnM
 4FAmjYOwgZJHneimAlznh4m5lMKALr9LjzWyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706530603; x=1707135403;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iq++AwmA90ergHe4wVvZRAOl8eLBbfI5Mb3CxxKjf0Y=;
 b=PtlMhohmrrmrmm/42FKjM1jcyWwlLPWmj5+/5eQ9eEI/eA2CwRIodIxdA+nPYEigFX
 A4whtFIjiYkIP21sA/6a3zWaKijIjazzVdX/9cMUtc3bIthe1tRdFncfBNPZFtUs4qVa
 lMabxD/XelTNSbRohIVIC8RjHBPlnOk/UW251dINz+PXqDcQ74PakP6EhDUkBYSiwyfz
 Rp1d25kSIeGSu5c8EPoJHssI/91rwaTUruaT1EUKzqk9Vfjk3vLr9e7qHpa6MOH/5fUU
 ZGOE44nJBtNA3KnK5H4ZSX6GlVRf5Bbz3gZt/JHPvioHorzf2Usnq9V1orPg6fpgARdP
 aRJg==
X-Gm-Message-State: AOJu0YwXyY7O8suI8hNN2x7IA/BnMLS/j6GqtQx4hSDnVijAxmOoAZjs
 kKdglLn18p59y62XfJ9IWZY5ATxKRUedb8Tn0DnM+FwYDDYo+GnX2gttyAIu6AqKQhmaqDLPGWD
 qpHwSKjzHZhtPhL+rSWzIBQn2WyP6q8ESKwGz3Q==
X-Google-Smtp-Source: AGHT+IHImZm2GBePHjJUmmqdBjFUji1/TGwDKyGsz8SLQ8DoNJ3vv8047VVzAvgTlstrxRbwrgQH97lfNRzZwK3b7bE=
X-Received: by 2002:a25:908a:0:b0:dc2:4361:b907 with SMTP id
 t10-20020a25908a000000b00dc24361b907mr1799162ybl.108.1706530603481; Mon, 29
 Jan 2024 04:16:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1703220284.git.Takahiro.Kuwano@infineon.com>
 <b7d1dc1da81c1c291b8f6ddb7ac90f2982f00caa.1703220284.git.Takahiro.Kuwano@infineon.com>
In-Reply-To: <b7d1dc1da81c1c291b8f6ddb7ac90f2982f00caa.1703220284.git.Takahiro.Kuwano@infineon.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 29 Jan 2024 17:46:32 +0530
Message-ID: <CAMty3ZD6nUdfkiYx177C42NPj9c1k5Zk8Np1DnyCC+nf168cXg@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] mtd: spi-nor-core: Consolidate setup() hook for
 Infineon(Cypress) S25 and S28
To: tkuw584924@gmail.com
Cc: u-boot@lists.denx.de, vigneshr@ti.com, tudor.ambarus@linaro.org, 
 pratyush@kernel.org, d-gole@ti.com, Bacem.Daassi@infineon.com, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
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

On Fri, Dec 22, 2023 at 11:16=E2=80=AFAM <tkuw584924@gmail.com> wrote:
>
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>
> s28hx_t_setup() only checks sector layout setting. To support multi-die
> package parts like S28HS02GT, it needs to check device size and assign
> ready() hook for multi-die package parts. These are covered in s25_setup(=
)
> so we can consolidate s28hx_t_setup() and s25_setup() into one named
> s25_s28_setup().
>
> spi_nor_wait_till_ready() at the beginning of s28hx_t_setup() can be
> removed since there is no op that makes device busy state before setup.
>
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
