Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDBA109C05B
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 20:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30ACE83CD3;
	Wed, 25 Mar 2026 21:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Kse6KRTP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E8E983E76; Wed, 25 Mar 2026 21:32:10 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB7B183A91
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 21:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-40f387a688dso253135fac.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 13:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774470726; x=1775075526; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N5IJcZSTxwwWf9H1wlKGkBbJMMTrVPLOqfl4GuhAN5s=;
 b=Kse6KRTPFVcJP8kcuxSpiPme+WCnPRN8Utt50f+k+xAGO1w9+xsNzOuyKD6Bfjf1VT
 Ss+0DeqwXDucdlitLjBokOSVGJ/uNJ51iErrrNuOs03cwPOIYwbdWP4INXRzJEJ+FexD
 L4Q/FTpgIXUWZ/GgjmuOQYrpTZhcM/96EwEe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774470726; x=1775075526;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N5IJcZSTxwwWf9H1wlKGkBbJMMTrVPLOqfl4GuhAN5s=;
 b=heRyW8gdOtzjJgyZHgvuEmZlejlshPIQAajPcKyoVqNF9r4lBOblE9vH5c+cDa6Z8U
 UyAnkgw04nPieh1mPyov4hfJJZx7nVfjpigLoQM85aRznAnGbyTjeMf5TwHzCnYTxY+u
 ZngOGhk7oHI8YNXwBZ+1uE7pqnuzK/mZekz9Ge3uh3Nxzy/nxZO0lo0b0XHoDW61LMp6
 8vctxj8gy8IK+rBGJJjxsDeUHR1ArVDGps74AEo2B3+IgcgNLEfeS2fQgnRxn/Mk0POG
 a0uSuujgZXR8ATzq3IHT0s4X439RNv8wRyX1PXbXTGmEsEiRAJZ8GbIQIsq0Lr0krHYS
 4iLg==
X-Gm-Message-State: AOJu0YySoFBz8J9Fjh6Ztei4wQLQseVfIoMWBUaypabBJIMSm+/GymZy
 t/DK4Lt+xNJVwX/yQol7rYtx4cEpHM0A0ss46O7pXHBblpr479a9mbu3PrYu3ZzOoy8=
X-Gm-Gg: ATEYQzzwXjXKuNvhZHEYP16OevDwovFFVxhwSqbmVCfYQXVIt/FrMXAkss+LERFGAcZ
 v+/KS/DMmuWpS8Q9S/CAG9zDV3duIUtkklfgJpucW63C0U48SR17KwX3jLV7F/TR2SGVuH9FXMF
 x+3xc+Oxufnaxa3PIHHsZPgrPtuPXOCSFdzrAzwxRYXI3cn0PYzLjfLxrC/Ke6LXXmo9+ZUqTNq
 huVua3go0MkSwVb1tu7ZD6mTiGnFSvZ6AnrE/3kxvgm6aTIdQ9V+5BYKER6jeh8iQoZA6zg7/VE
 CysxiAy1kpSyFVi39n5CHqJ0eXOPzbB3zMj3OAHMTRJvEPySL0UJ9FTPr7Xv+Q0mMW5WZhXcdbx
 CxX7fiB5v0z4uvN+iA69z9Qgb7igwPbkd3So8eaYRhmAhzYp2hZ8Po151QwWMjlHCKxqDQKV9NM
 CtznohgBY4tVuwUcT7KjHhqR5075m+mwTAB4CAn6V8Ysvk5VYTXs4S1oOBL8G5dEM9KaHqRL1eS
 tpNfRzGjGic1p1LZljRgvaUG+VkJrkEulWfA75ooWxiW1k=
X-Received: by 2002:a05:6871:409c:b0:417:47c0:3504 with SMTP id
 586e51a60fabf-41ca7088a58mr2937430fac.34.1774470726528; 
 Wed, 25 Mar 2026 13:32:06 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41ccb6b1d25sm107735fac.16.2026.03.25.13.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:32:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
In-Reply-To: <20260324184019.987767-1-dlechner@baylibre.com>
References: <20260324184019.987767-1-dlechner@baylibre.com>
Subject: Re: [GIT PULL] Please pull mediatek-for-next-2026-03-24 into next
Message-Id: <177447072568.3473727.2910209623719626896.b4-ty@konsulko.com>
Date: Wed, 25 Mar 2026 14:32:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 24 Mar 2026 13:39:20 -0500, David Lechner wrote:

> The following changes since commit 1ffc541eafc96d5eebcf837ab892dccec3b93568:
> 
>   Merge patch series "DDR configuration refactor and 16GB dual-rank support" (2026-03-23 09:19:00 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-next-2026-03-24
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


