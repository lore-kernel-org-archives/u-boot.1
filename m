Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFB3E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 19:55:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 602A589795;
	Mon,  9 Dec 2024 20:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mhWjsJ0b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 485CB89793; Mon,  9 Dec 2024 20:55:38 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2557C892D9
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 20:55:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-84435dbda4bso214652139f.0
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 11:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733774134; x=1734378934; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DLZTJE2KQw0dAzW/EjxFCqvD2FM8uFJ11njy+/T2ln8=;
 b=mhWjsJ0bSGuXrChNH1Ykc1AxJxmpWTnD8xHCk58noM2Ti3xGzO59PQPQ0DlF1aBL0N
 u1DEgqJ7FIgI/2kXayCdNyUV0+OHr8AfNfzXMY19yCXvbcNJcspyxqyxsjNjQols/dlR
 ZFkzYxgFdkECzPgpU1N0JYgOTGKRoHNUP2uYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733774134; x=1734378934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DLZTJE2KQw0dAzW/EjxFCqvD2FM8uFJ11njy+/T2ln8=;
 b=Ibd/580nuh0yD7DUjd/MpCghAW30kCjFSJWHe71CjrUTTr0TWB1OpI+8bxilkdQI+K
 2EnqD5J42iOS57P1a/BBKFAsZqXX2CwNW4Lkr8I2DIFNlozc6QjYRW4u2DPWUZBho3J6
 4ly8+STAydQK5exxalevFPdd1a99nnUGo/V1+2JQ3MJSOnofb0tDz4in4BPoGDNRVy58
 RwOvHckK84QSj63xqkLtSjiv21wCZE3305Z4D8jcrv/H2ggiIyuG8EOyNixqPNa298WH
 LQrpJtk+FKLYlkUF7LcZ5gxZPey3XlHQNkOkDLp+keuVUwT2NCy9zEYTFCxmYKP2kQ4V
 vewA==
X-Gm-Message-State: AOJu0Yw7UgwJx52bePA/OYNI1ZvS3ZOX6K/pi4w7J3vQ4I8V4s88m8Of
 yZ79QXzZQpSOGOYOaWtn/1zjBpinATYmjPBmJI0K/qAd/VjUSle13+OW8fMratk+bHbb8bnkAII
 =
X-Gm-Gg: ASbGncv5Er44VVTO3iaa/eDumCLEC0egIyPejzkL3ojIUGdCUkzz5e9TiqKw3jMYQJY
 eMxrs/CaPwxyy7R7shkBfnOnZcvMn2ZhfRRj8nRw8B0zQtWcZztSwjyUFHmV/snISfSLncyV/Ry
 nQ9O7djDk9pAbEWENV5qYb0UX0MaCW1dsPnRZfvSHOzi23r/Z2S7ah2QI9j0L6aVkfgnzpO2LvK
 jtyweNStkWEPDrlKEjB3ilUSm19kE5uIiQHthajtHRP+EhBeTxOxAVcV8NkNfb4Pf7jVQab7hg/
 UXLUHLgyBKPvydA=
X-Google-Smtp-Source: AGHT+IHhxoGhWK0tNpgd4xAXVvYWwZnhr045l7sdHg/jhIjzcJT3j9twUuTiAtUycyc/2LuqefsTiw==
X-Received: by 2002:a92:c882:0:b0:3a9:d0e6:abf2 with SMTP id
 e9e14a558f8ab-3a9dd3df1f6mr7581945ab.10.1733774134386; 
 Mon, 09 Dec 2024 11:55:34 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e286146f85sm2348941173.74.2024.12.09.11.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 11:55:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 1/5] rpi: Add myself to the list of maintainers
Date: Mon,  9 Dec 2024 12:55:23 -0700
Message-Id: <20241209195528.730260-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209195528.730260-1-sjg@chromium.org>
References: <20241209195528.730260-1-sjg@chromium.org>
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

Add my own name to the list, since existing maintainers are fairly busy.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add new patch to make myself an rpi maintainer

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c6c0c2a4bc..4b9bb9ef3f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -210,6 +210,7 @@ N:	aspeed
 ARM BROADCOM BCM283X / BCM27XX
 M:	Matthias Brugger <mbrugger@suse.com>
 M:	Peter Robinson <pbrobinson@gmail.com>
+M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	arch/arm/dts/bcm283*
 F:	arch/arm/mach-bcm283x/
-- 
2.34.1

