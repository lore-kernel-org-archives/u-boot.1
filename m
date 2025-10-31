Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9462CCFA02
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 21:29:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DB9D83B1E;
	Fri, 31 Oct 2025 22:29:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HQOq4RUQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5323883B21; Fri, 31 Oct 2025 22:29:33 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37F7D83B1A
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 22:29:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c532d70cfaso1692814a34.1
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 14:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761946170; x=1762550970; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0yorGmP+wcLvchKIGhT7KaXkhAp/JVIN30AGrnarnKA=;
 b=HQOq4RUQ8SVNErkPC9ujvW0q72WtoiczOwtlu7qYZrbI2n/4NEgGvjPcABaAspiM4Y
 q6VaiJcv+YWK/tdq4XB4QplOyvp0ri4B2Mhm/KzfZlUHj3rt4l8fqcO2V0KsLuU2SHGu
 rikgWDZJsh0AmjtJmKrKKNarp4Mb08MRSsNzvWQ5duEf7LLcvqhEBSA8/G26pFlhG5St
 5W1J0L1MlWpFGCCEYK9Lk9LUoXsVcUq2y0RBh32tIK8ZD1mY0RoNZW1h5caoNTvHqo0/
 nWyuICrirB06DYdvdTGsxErod9s9zrlsjyxHpPJc8ZjIqLlIRR1L/c/RnCVLmTgNbvQ+
 LPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761946170; x=1762550970;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0yorGmP+wcLvchKIGhT7KaXkhAp/JVIN30AGrnarnKA=;
 b=muzWaQQ9Q9Ag44ITU5Ky57aVSvIbwaOG//f7PpHMaqFvkbzc/SggN0jzhXEac84nnR
 HbwZdqIRyTkkBlptr09LuWTkvLzzY4XsmdULRu1BemEN4m1hI9wl/Do5EnA0X1ZA7d4j
 1+uO60/dMGPgUizk5cUCB7B0mmvDgyKmuKJqPnWHjeLWqSX7KWD2SmYdVHmeb2a8QeBQ
 BcOw+U64BkeXQtseu1H0K85LIiv4kuqbCbij+FrM+p0R3wuym7xeXZ7eRRMEm2nRdSWJ
 wUnppzE8G1i0YC6f9Nnyo8+VVuKZZ3/E7biYYPhTcN0Tz5AOna/lE+r/+XXg0u3140tG
 lFRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpYqb6mWGDvsBXVfKDf6dCMZvZdoIeYoBo+Ok6R1QkfOxpbmJczFvN1OGWcSegu7LVltf1pVU=@lists.denx.de
X-Gm-Message-State: AOJu0YwJa6H13VIOn4xu4qDIdRRXgV7s4tJfsCbUwDEEuiw4R5rL29Oq
 8OvATu2qCKUiLNgmFjM5OIvqSM62WeiG5rhnloLHQYPwvG1i2LDjkuXRXPiBvenUEV6bSykstKJ
 45dYXq6uHmt+X79RtsOvexROCuz//qHQ=
X-Gm-Gg: ASbGnctqgkXgNaJH31jCpBDFy65X0TZDJs8vXCKeYreIZYxzKifkwd89+e4TE8E00+Z
 QhP05q1F+UBDnoDCciWCHo7hhvnMxo2H87iaArXm1apcv7qPR9yEcExLyqNJweAUhpvY5HcAZ3E
 qlYA6/Fe4ko+nG/cKKsXE7S8GHZibomzjvqLb2rlUd7wEOqCEhKHJ1aqbqCcY3DRdR+1XOCjGhd
 VXJVn01WV6z9yL2/xF4gmKP/ULXd4oQPsHWuTa+Z0hJD/B5RXJ+31/TrWOa4w==
X-Google-Smtp-Source: AGHT+IH//g/0zURkShPbXJgql9lUmuU3xzgsyKrSr0JgJTekmwgWkSqlYAsWl6tlYsXlpDahan8rx8JXiOFrbmtSAKU=
X-Received: by 2002:a05:6830:67e9:b0:7c5:4005:ffe2 with SMTP id
 46e09a7af769-7c6967e80d3mr3203274a34.27.1761946169908; Fri, 31 Oct 2025
 14:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAN7C2SArdbhag_56MwOMGoaEYSLiHbHHo3KFhUS5U03ntEJbGA@mail.gmail.com>
 <20251031191728.GG6688@bill-the-cat>
 <97a6d067-8c57-48cb-ab9b-c5094a798d99@kwiboo.se>
 <CAN7C2SCquwnP5tUE0KLE15wGPqbNE10adEgshXLjRQnTK+JM4g@mail.gmail.com>
 <af9255c6-4217-4784-bfcb-b6d90d79d0aa@kwiboo.se>
In-Reply-To: <af9255c6-4217-4784-bfcb-b6d90d79d0aa@kwiboo.se>
From: Sune Brian <briansune@gmail.com>
Date: Sat, 1 Nov 2025 05:29:19 +0800
X-Gm-Features: AWmQ_blZK0P8hsSiXazsrudfFbuyHKfGh-vOcS_nmcv4CpNAM2cvc1d5O9sWBbs
Message-ID: <CAN7C2SAhJaAnVj+G7xhgVK2+66HM+o4FG4FKaoZZ4WF=aM_ktA@mail.gmail.com>
Subject: Re: [DEBUG] rk3399-nanopi-neo4: SPL SD init may report -5 due to SD
 power-on timing
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

> Please try my suggestion above, the datasheet for the LDO mention 50us
> start-time and card may need one ms to fully init. Defining this timing
> requirement in the device tree that U-Boot SPL uses should match the
> workaround/fix you mention in your original mail.

I want to comment a bit on this statement. The datasheet 50us
is not mentioned as loaded or not. If you read more deeply on page 7.
The settling time is already about 40us w/o loaded. With 1uF and no load
settling time is 50us is not quick. So typical 2mA ideal action on SD card,
and changed to 100mA read current could be hard to tell.

Brian
