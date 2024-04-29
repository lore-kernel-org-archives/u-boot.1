Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF03C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 23:06:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF5E2889E8;
	Tue, 30 Apr 2024 01:04:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RZ7V921P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D42FB889DE; Tue, 30 Apr 2024 01:04:20 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C47C8889B7
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 01:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-78edc3e7cd9so379175885a.1
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 16:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714431857; x=1715036657; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6LXSRxnH/o+UY5LueyHZIa+Y02QLLgDA0aptGf0ISD4=;
 b=RZ7V921PH+bbBjCH7m2zv+gHnqCbEGzdWBtyNhHIpSaJbh0e6KoscDp5qUORS1eOW5
 HdzAa2LodFE50EedNFIXfgzumKdYKpQ//7IuJw6UUkBs4y1HOT1yCKPDGpfawsgEozcM
 ovh/PUp0UWOat9DJ/XLoTBKI6t/E2dkEyYBNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714431857; x=1715036657;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6LXSRxnH/o+UY5LueyHZIa+Y02QLLgDA0aptGf0ISD4=;
 b=uX2w639OIojGLP28wXmPFhS4xSSWecc+Riu59Axl3xfs5B5KeCFJ6LphE7QJ3BGauL
 f+R1Os4qgfhf89hjtN+mpqTNR5hhITZBd8toQpiYszoF0PvzPIQRy+LWS+lR3KWGyceb
 KmF1hp5AIypNhzn8K2l/gGi9AP1NIEEEjdwMZSthunPYhq979l7NvbLL/ArL9LSau50m
 MhvLCio3+o8574oa8vUEW1QFqGs91b7qhfc/tq29djkpcHgNwalKbOzHt/uyLkMXsNwX
 3V3GgLbZdG7VJ3nAXxp5FALz/3jVfValPxC6yiwU+kUBT1D9DNcbYJtsKNDkIs3vCVOZ
 sClQ==
X-Gm-Message-State: AOJu0Yw6SiO3XVK+qsuYg4fAWluW3A/HNnezNQv/rLLu3jfEfe1ua8/b
 EQA4gudO802QmzbZxhLLPaUjiAVZslfEYk63J6HRPymNfJM2kQiI4+nepaPes6E=
X-Google-Smtp-Source: AGHT+IFvkIuuCPOgLZgZ8BZu5NA+/j3wCzKyIpZYI9obsKXGSqZXznSTC2YkaX7PEzM+/OTw4J0mZQ==
X-Received: by 2002:a05:620a:4003:b0:790:fc1e:7044 with SMTP id
 h3-20020a05620a400300b00790fc1e7044mr3922941qko.31.1714431857651; 
 Mon, 29 Apr 2024 16:04:17 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 h6-20020a05620a13e600b0078f044ff474sm10967156qkl.35.2024.04.29.16.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 16:04:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>, Sean Anderson <seanga2@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Tim Harvey <tharvey@gateworks.com>, Tony Dinh <mibodhi@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Sumit Garg <sumit.garg@linaro.org>, Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 MD Danish Anwar <danishanwar@ti.com>
Cc: u-boot@lists.denx.de, srk@ti.com, r-gunasekaran@ti.com, 
 Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240416092018.3593039-1-danishanwar@ti.com>
References: <20240416092018.3593039-1-danishanwar@ti.com>
Subject: Re: [PATCH v4 0/6] Enable ICSSG Ethernet Driver for AM65x
Message-Id: <171443185492.1749944.17323922626012592468.b4-ty@konsulko.com>
Date: Mon, 29 Apr 2024 17:04:14 -0600
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

On Tue, 16 Apr 2024 14:50:12 +0530, MD Danish Anwar wrote:

> The series introduces device tree and config changes and AM65x
> to enable ICSSG driver. The series also enables SPL_LOAD_FIT_APPLY_OVERLAY
> for AM65x in order to load overlay over spl.
> 
> The ICSSG2 node is added in device tree overlay so that it remains in
> sync with linux kernel.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


