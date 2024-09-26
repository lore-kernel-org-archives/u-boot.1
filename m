Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92753CDE03A
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92B0288EAA;
	Thu, 26 Sep 2024 23:33:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g2K7fah3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8FBA88E8C; Thu, 26 Sep 2024 23:33:37 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DFF188E96
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:33:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4582c4aa2c2so8690151cf.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727386414; x=1727991214; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hupsLWmNC/TDpA7gY8yolt3GZB74CF0fO8JN2b/wSOA=;
 b=g2K7fah37Snq1MzECjMzHww7kC1PzNLVXHDdtU1eGVaZqsqPO2yxA0GM0/dhZl8Bjv
 0lYGUHiPsjQZxANoSHzEUWrZXOVXUhavAPzjS8hCVq7Z9HBmvB/1zjT9qopaIGc805gv
 p+1rl1NBALD339DhtcK8fX8FfDUxYbWVroGLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727386414; x=1727991214;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hupsLWmNC/TDpA7gY8yolt3GZB74CF0fO8JN2b/wSOA=;
 b=la5bF7oIYdAq7QUXC8aoOUEotTTcqIv6O4+ikiDJ21YkEE+KDGuRjJdrWad34pFdeb
 Nurdp+87b9QHTpcrUmzeifZH2LUnaXoGMMOweKuBcCzbEg6H9k00b25TRxdX7LGnNbW9
 yOdDRIL2Qww33qtrcHdj4E3fe3Qtn7mvGSvdKwSCxzpEsKZ0tPGDaRDTdSRwu+Xg7VWZ
 hsqV0+enR8N8IXuyT0En0oN48x5hjf7gN2vldOpYXmj0SD4vMB4qNq4wU1SQs1daNfEs
 hYu82PrwJ+m03XCgZY6Axl0VIXbszTvwwEveV4mORstboVGRXkPjo2bdfBOX1HNZGydI
 9lEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzrutFAtDd0oexoh530A9UT1pL3PB/HfrdLadOGunZkrs2mm272Q/YMbu0LvCSau8QjLQOysg=@lists.denx.de
X-Gm-Message-State: AOJu0YyXkhz2BWxPec8f9TV2NxVOygBLZqgSDwuDcz0coGNK3A2rdVJ9
 QL7Kak0LB8lAov7+1NhcDaPctuTAmT2jo0YanVVerHKDmz2Y+0aeQct7wx/KaCuCP3r6PH0/6C8
 WeV20Q2P3Hnhid/cTIjaPdYMTIDkRkPsEM6iX
X-Google-Smtp-Source: AGHT+IG5YAnDVKVqSlVlcHx43BS+4W8n7FbzGruDw9/FcpLhk+X6HIUwB8xXRa4F9hWFc6EJz8Kk8euM3NTmffj2CJo=
X-Received: by 2002:a05:6214:3991:b0:6c7:c8b2:e023 with SMTP id
 6a1803df08f44-6cb3b5c2572mr13931006d6.3.1727386414214; Thu, 26 Sep 2024
 14:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240920225101.2008-1-ansuelsmth@gmail.com>
 <20240920225101.2008-5-ansuelsmth@gmail.com>
In-Reply-To: <20240920225101.2008-5-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:33:21 +0200
Message-ID: <CAFLszTgSLz1APgEpADQpPAZCi65BKMSsYsyGuLmm64s0aTRwnQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] common: board_r: rework BOOT LED handling
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Sean Anderson <seanga2@gmail.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Yang Xiwen <forbidden405@outlook.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>, 
 Alexey Romanov <avromanov@salutedevices.com>, 
 Martin Kurbanov <mmkurbanov@salutedevices.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Artur Rojek <artur@conclusive.pl>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
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

On Sat, 21 Sept 2024 at 00:51, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Rework BOOT LED handling. There is currently one legacy implementation
> for BOOT LED from Status Led API.
>
> This work on ancient implementation used by BOOTP by setting the LED
> to Blink on boot and to turn it OFF when the firmware was correctly
> received by network.
>
> Now that we new LED implementation have support for LED boot, rework
> this by also set the new BOOT LED to blink and also set it to ON before
> entering main loop to confirm successful boot.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  common/board_r.c     | 28 ++++++++++++++++++++--------
>  include/status_led.h | 13 +++++++++++++
>  2 files changed, 33 insertions(+), 8 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
