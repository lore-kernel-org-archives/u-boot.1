Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE6FC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 19:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35D8488D87;
	Wed,  7 Aug 2024 21:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OvVPsD6D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D5FA88D85; Wed,  7 Aug 2024 21:54:40 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7333488D54
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 21:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2f1870c355cso1849421fa.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 12:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723060477; x=1723665277; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FDYXU4/tzHwKGwwfuyp0dk4rPQr8M+VUZCOjilnaZkc=;
 b=OvVPsD6DeTXnk+ygEuDzJr0aLWo9zxS3CzmEPaO8MnnGM6jMEVjXvj+STSahIVHfbj
 rlE/eKoPcbJaPvv+T4CkKM+2LVjDXSqKeK4A3Bz1wA8PPGQ2h5OI/f6amKgjVwNqFBJh
 x+OLAWPegE70kWOGaeevpr0vY40D3beo7kIBsEvDIuVhWf7NxI6og31o1FUdYmyiFevb
 fL7smCSoXclIeK2T27ZvHfBp3fk6xIax1Kau8CmG8kPORzg80m9UQzj+VMpO7woe4vOY
 JoEhn0f4roY6xbo3AClhP2ZZiRDTEn71q2d1UwOuAiiUz5HAG1xFhcG1xh9ansYCwLDI
 3duQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723060477; x=1723665277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FDYXU4/tzHwKGwwfuyp0dk4rPQr8M+VUZCOjilnaZkc=;
 b=iYPhUhX7GwAt8BUhHToX8p0JE1NSdZDCafAOsCGLUYdv73i64gnYVu5vEPsV6eMTAb
 HSaGRhhtEfhqnlM9tSGthDHNKDu4feFUxlKYcHAyhAoZhLzQYSHREaSC5Svns1R7y4ep
 QDNycvIHISCkQNdBw9weicKRZyNa1O+Sq4fJQ+3cQh3j2ePUHuydeECqnAKCXhk/x47S
 FLVJte+fUhfCQoDPxC1ZIi4X0246CRRlk8Cb1jdgtEgD3uSsPIGqmWJNEgoqA6cN4Vrf
 niKMgJSSTpA0JqJVfpM1fG/hVTBB5oU/JITsKW2TgPDBPWjTddXjiFd3HQcHlPqWJePW
 /i+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDvxjDq6pQG2i6BEiLJtT+uYv7pXVe8eDj7LBGXvME/s0DWXmvlvBN5IGjcbcJXoexhDOEp49yoPehZqowuLDLL28Cig==
X-Gm-Message-State: AOJu0YxXlRF8bLqR+n9Cbu8KK6YPfWhOmutjZNm1JRJkEnCkn1HOq/CO
 sJvFC2KFeFX8riDkTOubHC8m3iYX2edLbMdPg6LnLWlYW42tM76v
X-Google-Smtp-Source: AGHT+IFh/gqis7PwSJSrxSN4yGB5Xrt12fQMk6matIcis7jO4paBkmK/OlT9gIqccYdXGBqBKxvyhA==
X-Received: by 2002:a2e:9f0b:0:b0:2ef:2e3f:35da with SMTP id
 38308e7fff4ca-2f15ab399bamr126846351fa.45.1723060476972; 
 Wed, 07 Aug 2024 12:54:36 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-429057a8802sm44383765e9.21.2024.08.07.12.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 12:54:36 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
Subject: [PATCH v2 8/9] ubi: implement support for LED activity
Date: Wed,  7 Aug 2024 21:54:11 +0200
Message-ID: <20240807195413.30456-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807195413.30456-1-ansuelsmth@gmail.com>
References: <20240807195413.30456-1-ansuelsmth@gmail.com>
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
 cmd/ubi.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 92998af2b02..e663e6dfafb 100644
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
@@ -425,7 +426,19 @@ int ubi_volume_begin_write(char *volume, void *buf, size_t size,
 
 int ubi_volume_write(char *volume, void *buf, size_t size)
 {
-	return ubi_volume_begin_write(volume, buf, size, size);
+	int ret;
+
+#ifdef CONFIG_LED_ACTIVITY_ENABLE
+	led_activity_blink();
+#endif
+
+	ret = ubi_volume_begin_write(volume, buf, size, size);
+
+#ifdef CONFIG_LED_ACTIVITY_ENABLE
+	led_activity_off();
+#endif
+
+	return ret;
 }
 
 int ubi_volume_read(char *volume, char *buf, size_t size)
-- 
2.45.2

