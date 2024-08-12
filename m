Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3300C52D7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 10:34:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EA578885D;
	Mon, 12 Aug 2024 12:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KUE3wsCN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85E4588883; Mon, 12 Aug 2024 12:33:19 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E42287F19
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 12:33:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2f035ae0fd1so45322621fa.2
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 03:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723458797; x=1724063597; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sIdfYcgX1Gb6+mMB6ALCPccG2uK9s3uiNEqRh1Rv7gI=;
 b=KUE3wsCN/hUIYUj88nFWd0J4ZPbDs5HXLpCxADu3Z3wUOyROK9t6p7Ks8p5M00Xnnj
 /1k5PV+NI/4XxyxLG3SPq9AjQwY2egwSzQmrhNuZPvLNo4Oj9IznpB/mQj0Wunp1CzBX
 XyWMg90a6Yvqbp2KAovEYHqLhEueyOaJ/qHeUf1P9BzilPONPOLU5ebOdr1BUFSIXMUG
 R+NAHyBPaioNOjxPEcVqF9egBifrido7WnP4+NKDrIcTEOdgKtxarbJ5f2MXETdTM0xU
 arEGeHF+Tw4eHsAR8GL2wqcdjK5sTBoogacCjQoxBv8TibX9FYDFilJQvZkai7Kg3TBt
 5D9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723458797; x=1724063597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sIdfYcgX1Gb6+mMB6ALCPccG2uK9s3uiNEqRh1Rv7gI=;
 b=QrmEFWKcSNHF1fVoe3AdzATJx8ZtGjWvcE2JvAnhI5alK4zU9PhltYz0RcTX5pZ1VJ
 MR9rgDR6Eeuxb2VjL6Tfna7pKXIb7EPazGxRUVSvXuGj52OIn5BYSkakFd0yGi2ogte9
 vcmkST6iMp3Wm644WQkG4t3bOgcWKxFiwS73UnAKwSq8pwg/9V2qsDxzGlN/xBUmdCeN
 TCMCImS9OMtzKnZfPJlE+CH+IEVXkwGEixGgAfeupull+MFerUBCUremvIBz/xaiYOqs
 GVeSi/ougd5afqhlbfZSMy2/G6H23O9MzU8MTvRePsUzWTDBiiwV/7k2reILdqQIFJfJ
 mbeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJygNiKvGCZDEbBsfWeXqilrTXZw59uEjDHW5lVTrAEcotfFZgzc95Td0Emem53Q2ZDzdfz7qqrXskh54tnJtyqA7dxg==
X-Gm-Message-State: AOJu0YxhWrayBQAj5tnNddE6TfIpL2ngITDdG6gO2ftxG8fZCJwZ22GS
 bK0P/yIQxTMnTuPs1CSA/63dk1lNZjh3rGfpmtxM46gC6beRo2T5
X-Google-Smtp-Source: AGHT+IHLahR80ej2T890N6hxqmHCm7tBsOYOb4c7C1xv9mdH+dERl9DQx8izYY51HVk3FDKrQMO9bg==
X-Received: by 2002:a2e:a542:0:b0:2ef:29d4:3d97 with SMTP id
 38308e7fff4ca-2f1a6d02356mr63246971fa.5.1723458796642; 
 Mon, 12 Aug 2024 03:33:16 -0700 (PDT)
Received: from localhost.localdomain
 (host-79-52-250-20.retail.telecomitalia.it. [79.52.250.20])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4290c77f078sm186016425e9.37.2024.08.12.03.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 03:33:16 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
Subject: [PATCH v3 8/9] ubi: implement support for LED activity
Date: Mon, 12 Aug 2024 12:32:50 +0200
Message-ID: <20240812103254.26972-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812103254.26972-1-ansuelsmth@gmail.com>
References: <20240812103254.26972-1-ansuelsmth@gmail.com>
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

Implement support for LED activity. If the feature is enabled,
make the defined ACTIVITY LED to signal ubi write operation.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 cmd/ubi.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 0e62e449327..6f679eae9c3 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -14,6 +14,7 @@
 #include <command.h>
 #include <env.h>
 #include <exports.h>
+#include <led.h>
 #include <malloc.h>
 #include <memalign.h>
 #include <mtd.h>
@@ -488,10 +489,22 @@ exit:
 
 int ubi_volume_write(char *volume, void *buf, loff_t offset, size_t size)
 {
+	int ret;
+
+#ifdef CONFIG_LED_ACTIVITY_ENABLE
+	led_activity_blink();
+#endif
+
 	if (!offset)
-		return ubi_volume_begin_write(volume, buf, size, size);
+		ret = ubi_volume_begin_write(volume, buf, size, size);
+	else
+		ret = ubi_volume_offset_write(volume, buf, offset, size);
 
-	return ubi_volume_offset_write(volume, buf, offset, size);
+#ifdef CONFIG_LED_ACTIVITY_ENABLE
+	led_activity_off();
+#endif
+
+	return ret;
 }
 
 int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t size)
-- 
2.45.2

