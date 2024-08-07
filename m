Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD3EC52D71
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:20:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F7BB88D10;
	Wed,  7 Aug 2024 16:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ST/TOMst";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B58D588CFB; Wed,  7 Aug 2024 16:20:23 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5793787A6D
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:20:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-260f4c9dfe2so492974fac.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 07:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723040420; x=1723645220; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YtLHfjRIp0fmnCEUj5FNmdNjUl9m1ypCuS7I7ZE+n1A=;
 b=ST/TOMstSVg/1+ac7sImJphEw3u/GFfGmZeJg/JEASn2eJMYAKbYRyVbXBWJxmoWvy
 LYVilNEmASKIWH3oonu5Pa1C9ySraHgy0VFJHEav19C+PO8hrxTc7jqbHqOuNGMHN34u
 7Kvhr8yZZRtAel8b6GbIzc5j0F2dhOdxHCeuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723040420; x=1723645220;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YtLHfjRIp0fmnCEUj5FNmdNjUl9m1ypCuS7I7ZE+n1A=;
 b=Vjj4vMTTgSE0RPqpUFoBvRk6OcAaaBCeKXpRRkbfasO/9uH3Yb9qBIDoWcAfwAts0v
 LrNEb4q7cEw8lC7ivI//mNfNiUACX/0M/nc014amtaFcu6zIoCtBfq9r+bWFdWmocnhB
 1kkRkmm9lR600utNR8pyJfc77WzXbzejDBKBbdWY118FeTBEsyNejwL3uMwG8mSzPhep
 CXQ/Cj6p8aTfYRWDpxnXOAIoga6oLxrdQqqpkW3P/8YZZ9U9jAdwrnoA4MlfAjZeI73y
 7npwCDZn1oI0ArON7iJ7TXVdjXXGRs9Zkzqoqb5tn/hhO0WZnupx+AEosbAou0dSU9r8
 F4Mw==
X-Gm-Message-State: AOJu0Yywb1DHLfXt2h6JmhGpEZOW7ZHm2btCGfxPl6eNEwpJzM6I/br2
 VO2EcFVi2FVHj4TKvnPEyx0/p1DqCLDYQUbncBLK0MQiEETd22d3qBNh61bKNa8=
X-Google-Smtp-Source: AGHT+IFdiaXLtm2jdOU2u2PgpWa5PQTZuaw/RSf05bgYnOStGa4t5uRO54NmYLPunvQ6hS6E8Tyn+Q==
X-Received: by 2002:a05:6870:9a0c:b0:22a:57da:6fec with SMTP id
 586e51a60fabf-26911745244mr1046635fac.16.1723040420035; 
 Wed, 07 Aug 2024 07:20:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-236.totalplay.net. [187.191.8.236])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a6274b8sm3959146fac.42.2024.08.07.07.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 07:20:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Paul Kocialkowski <paulk@sys-base.io>
Cc: Yegor Yefremov <yegorslists@googlemail.com>, 
 Sjoerd Simons <sjoerd.simons@collabora.co.uk>, 
 Govindaraji Sivanantham <Govindaraji.Sivanantham@in.bosch.com>, 
 Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>, 
 "Andrew F . Davis" <afd@ti.com>, 
 =?utf-8?q?Javier_Mart=C3=ADnez_Canillas?= <javier@dowhile0.org>, 
 Felix Brack <fb@ltec.ch>, Heiko Schocher <hs@denx.de>, 
 Enric Balletbo i Serra <enric.balletbo@collabora.com>, 
 Adam Ford <aford173@gmail.com>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 Marcin Niestroj <m.niestroj@grinn-global.com>, 
 Nikita Kiryanov <nikita@compulab.co.il>, Thomas Weber <weber@corscience.de>, 
 Enrico Leto <enrico.leto@siemens.com>, 
 "Derald D . Woods" <woods.technical@gmail.com>, 
 "Matwey V . Kornilov" <matwey.kornilov@gmail.com>, 
 Niel Fourie <lusus@denx.de>, Parthiban Nallathambi <parthiban@linumiz.com>
In-Reply-To: <20240728202501.3204905-1-paulk@sys-base.io>
References: <20240728202501.3204905-1-paulk@sys-base.io>
Subject: Re: [PATCH 00/12] omap configuration cleanups
Message-Id: <172304041827.1708865.1364514024581159069.b4-ty@konsulko.com>
Date: Wed, 07 Aug 2024 08:20:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Sun, 28 Jul 2024 22:24:49 +0200, Paul Kocialkowski wrote:

> Here is a bunch of configuration cleanups for OMAP boards, mostly
> unifying and moving common configuration from board-specific defconfigs
> to Kconfig definitions.
> 
> There's also a cleanup of the sniper (LG Optimus Black) defconfig,
> prior to migrating it to DM/DT in a future follow-up series.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


