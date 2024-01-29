Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3675C47422
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 12:15:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55B1D87C37;
	Mon, 29 Jan 2024 13:15:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="e/qMGj4U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 667C087D8D; Mon, 29 Jan 2024 13:15:54 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 317B8876F8
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 13:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-dc64926af85so2005389276.0
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 04:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1706530551; x=1707135351;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dvVNq0oCK3nsF2GI9cT51KdxUGnuFY6W+Yzo/mDt5ME=;
 b=e/qMGj4UTuNhzTyx46QgQ3+/SvAkjJWtgm2xlmZhVwq+BMjZkeaGNOPgGHwQU2uhTc
 qh0cy+jdrlO+igeRWFeH9YfwzEeAbBNee7YtTMYf5UHw7Ab19iTu0982+rGtPZEcUK8n
 eudNRAblY0r4BDVLXzF8MWBttjdEEPWVlf8Io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706530551; x=1707135351;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dvVNq0oCK3nsF2GI9cT51KdxUGnuFY6W+Yzo/mDt5ME=;
 b=pOIlk6EZqieL5iTIYSkEr1itZtEtQ1WDmaF7ogrkvQVqwPVnf/SjR9veUnnHLDDZl3
 w58dYDM1KUjFfSaeAgM6IgKGYVa0GfUyJbej5NDbEiPbs/TmM+Cxb4vCa/OfigiU1CzY
 q6KEzZxUSkT7EAEANWFx7a+AgypYCtPSK9FtiGWJRi5ISqZHbWkMFdFo5zLxqvN2u62z
 cl58YkEMmuOCxiOUOLwnYHjfp0MKf5Jo3/YC398w8NkdB/fq8zv4tZHpyZB3f7MIV0xK
 Bsp4Ug32fBtlH0+tUfl+spwwewDk5B0drvgAQ6WjvDKcDZtJU1Olsy24NyZhln1kM1uo
 Kv3A==
X-Gm-Message-State: AOJu0YxnK6LszIRlfG9pM4G7jXfljyQYpQxO+C2q2hZQZDi0nrD1mlQo
 W2Q4cTpctKcWF0Z0Z4CIWCM3opbOmHIRl+SnlUwCrMLva2IVCAgxbKWl/LP5ueBLgKvjIWdpIxU
 aEPs6v5Pg54E59JxO7N0sk3x/gCU8ij2R/4Y6Bw==
X-Google-Smtp-Source: AGHT+IFUGzUD9PBM9hUZ0JkgxDZnKOM1Mg2qePTCvFjUgy0d/ZYAFO2gkWbS7KKJuLgswwyDlpKdE/0RGDLjmYA88Iw=
X-Received: by 2002:a25:b82:0:b0:dc6:4e33:10b8 with SMTP id
 124-20020a250b82000000b00dc64e3310b8mr2155221ybl.124.1706530550977; Mon, 29
 Jan 2024 04:15:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1703220284.git.Takahiro.Kuwano@infineon.com>
 <590a68b594f61e8ec2315f3c0b17e7dc43a21a5d.1703220284.git.Takahiro.Kuwano@infineon.com>
In-Reply-To: <590a68b594f61e8ec2315f3c0b17e7dc43a21a5d.1703220284.git.Takahiro.Kuwano@infineon.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 29 Jan 2024 17:45:40 +0530
Message-ID: <CAMty3ZAnTZqwd+DgNC=+LF7=_CsegqP3fVHXXp+4Wff3nSDfqQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] mtd: spi-nor-core: Rework s25_mdp_ready() to
 support Octal DTR mode
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
> s25_mdp_ready() handles status polling for multi-die package parts that
> requires to read and check status register for each die. To support
> S28HS02GT(dual-die package with Octal DTR support), rename function and
> use nor->rdsr_dummy in octal DTR mode.
>
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
