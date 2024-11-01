Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A26EE6B240
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 10:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A21088B55;
	Fri,  1 Nov 2024 11:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TcyuVZtB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3745E88B55; Fri,  1 Nov 2024 11:35:30 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5362888A37
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 11:35:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2fb50e84ec7so13077911fa.1
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 03:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730457325; x=1731062125; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8UTkQKwukaiS1F6oup7WjyvLTfKjfbq/1RjnRJnQ69g=;
 b=TcyuVZtBJMNxldzNT7oArZ36q1pK2wLZ1bl5YVcWdoRlA7uc48LAfZHtJuOZ+7t3D3
 M46+gfj6WNnG89RWGzQ7PU6/SaLl+EdvOtozsgoAGkOyJSx/5wUCqsLvwU8t0iOU2va6
 C6kwdVaFmzHCjr5+g4Iby/uEbwL+rD/60Mt/uaBtBnor5jX3eaWmh9dBiMgf647W8Ji0
 B1D9t6wxWoSCD0TVrA5TJHwN9UTmxmH5LnQ1Y7tqI6RwC1i+LpHnjU9RNAao8Kdmiazd
 Pzw9I7xTG13HyNYRNEOe7bVHDxR0tlMTxLsXQq0VVKMqEMh+NfROzGVxoD3G/Vo1bk4m
 CmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730457325; x=1731062125;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8UTkQKwukaiS1F6oup7WjyvLTfKjfbq/1RjnRJnQ69g=;
 b=Qi8c6cjPLKowYOMb/Z9XlTo6HUw93AR0CljeNsY8GAPsfgfHvL83pPEAJ9c7OW6vtA
 ZqmaZ1nfyXUT3u0n8HULNLwgEVq1IsKXyaUcD4GrE3m5qZ23wCYnQyV+sql9bNFdFEQx
 ska5vUjUtsWDvJH3KA2dHnB0+8EHkUVdpiSiVhokOEawIEY3vO89GMwmK1PUXfrGjiu3
 JjjW+84ALp2OliiKgW8DYEz/B883ghhQYYb3QQa29vapEUeQj3++3XNlvOTFpA1oqHcY
 sMD1Lx1ewjpTpOxVVx5AIUORX+0x5bDkjw/L3Iwtevz+aNX8/cCRxzKISjbo+mZlIK5a
 0s2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUM9kB2m82hc+BuHnSDQslOU4t1xVX9klpjB9gRTMgN4pENoRwhxZHbMQaAiLIPQfZ5cdQJ0KU=@lists.denx.de
X-Gm-Message-State: AOJu0YyP1IZ8nkkeX6y9jwLiHNTKlwyDVbPopDegQXmDzfcVGwMXjajn
 oVxydfWMY8cfi1G+IZsUyO7fYc0wPZJsnPr3pDYJ/rjENDGjzzc9
X-Google-Smtp-Source: AGHT+IF0qjCKRxB2ERjlpVTZf3CBJ+h6ysDSpZ7G8ECTVfwpJodGbOQJsD1/TuImRo27XMR7aS1D9w==
X-Received: by 2002:a2e:510a:0:b0:2fb:5ac6:90ef with SMTP id
 38308e7fff4ca-2fcbdf7d71dmr87980351fa.11.1730457325280; 
 Fri, 01 Nov 2024 03:35:25 -0700 (PDT)
Received: from wpc.yadro.com (host-95-152-63-138.dsl.sura.ru. [95.152.63.138])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2fdef5d7400sm5163051fa.45.2024.11.01.03.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 03:35:24 -0700 (PDT)
From: bigunclemax@gmail.com
To: 
Cc: bigunclemax@gmail.com, Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>, Wang Jie <dave.wang@rock-chips.com>,
 u-boot@lists.denx.de
Subject: [PATCH v1 0/3] USB TCPM host (SRC) mode improvements
Date: Fri,  1 Nov 2024 13:34:49 +0300
Message-ID: <20241101103501.21432-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Maksim Kiselev <bigunclemax@gmail.com>

Hello,

First of all I want to thank Sebastian for the work he has done
to add TPCM support.

This series contains some improvements for issues I encountered when
Type-C port acts as a host (source).

The first issue is that the Type-C state machine gets stuck
in TOGGLING state.

The second is that in host mode fusb302 should control VBUS supply via
regulator, but this is not implemented yet.

Therefore, I'd like to discuss several patches that solve issues above.

P.S. Maybe this series may be combined with Sebastian's series
- "USB-PD TCPM improvements"

https://lists.denx.de/pipermail/u-boot/2024-October/570163.html

Best wishes,
Maksim

Maksim Kiselev (3):
  usb: tcpm: fusb302: add missing newline character to debug output
  usb: tcpm: fusb302: add support for set_vbus() callback.
  usb: tcpm: fix toggling in host (SRC) mode

 drivers/usb/tcpm/fusb302.c | 50 +++++++++++++++++++++++++++++++++++---
 drivers/usb/tcpm/tcpm.c    |  8 +++++-
 2 files changed, 53 insertions(+), 5 deletions(-)

-- 
2.45.2

