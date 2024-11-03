Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6D2E67816
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:38:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 949B18908F;
	Sun,  3 Nov 2024 01:38:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M+dRRSlQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21AD08931F; Sun,  3 Nov 2024 01:38:34 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06F7F89157
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:38:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20c9978a221so31403125ad.1
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730594310; x=1731199110; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=85Q4p/tg2lVNRIQ8pw3ubemw3XvvPUoiOZa3bsJDBGs=;
 b=M+dRRSlQDcQ33UH9Oc0xefikOV0D1SGIIAaa3oqzCrhm307GfpPY9BEhOwe9kbROHR
 ftFjO1aWX9mGc8ZV2yNHEihLOZCgZ0ohpthjn2hO6nXhpNSq78Oq5Ydem6pNMsCLIyQY
 NrM6UZVVEt2gsm+OMlCBZbixx0mvNDiWyLhrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730594310; x=1731199110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=85Q4p/tg2lVNRIQ8pw3ubemw3XvvPUoiOZa3bsJDBGs=;
 b=gWAJsm+GLrnXQKP9nmjXw0V62AEAGaVPrY07qfFJ3+6A8sq5BL1eh41cP0/wz+Y3GU
 fOFYzWaEm5xDir4vpp2WWn7OaXpMGnsIm6iz55yLmt5KyUzPeR+MaTEa/FllpoYwJ0y3
 fLuh4rx9LWDvM3B+uHxi+meoS0tOArdKssPFxeDv8DiXT5Q4stCwuTQ7vscKE+c6Lv/g
 hXjoNCehwd3tOHyIAcDnUbmQVHUk7EpkugXY5+naE3U2qO3KvcH4/OmWvG36QXhXfDcT
 IaeshOl/eV5Acnbuapi0bboHGGGtUzv4rLbNVeya0P8F5BEsUztOV6gekJKoOWToBO9O
 I0Tg==
X-Gm-Message-State: AOJu0Yy8+WuJldwXIsDMsuC4RG7vYVV6cDOBZ2GmJ0mh5tQcn1i1YW4P
 YZj5Q+UJ29ZoPB6TCPiRYSk4G9Dyvq8v0va0xNfSObK6FL1k92a7Gua5g8iu1O+bi0JTcruL/XI
 oNA==
X-Google-Smtp-Source: AGHT+IHpJKpef+JHrKfcPj66ZCQp6JImm1cseMDb+vosbUkn0p+WHoyBTfsl4UnVO1yxaoHj+nd9xQ==
X-Received: by 2002:a17:902:e804:b0:20c:d2e4:dc33 with SMTP id
 d9443c01a7336-210c68d3ffamr405301155ad.14.1730594309627; 
 Sat, 02 Nov 2024 17:38:29 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a63f2sm38987995ad.168.2024.11.02.17.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:38:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 21/25] ide: Drop unused status_led.h header file
Date: Sat,  2 Nov 2024 18:33:13 -0600
Message-ID: <20241103003322.626036-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241103003322.626036-1-sjg@chromium.org>
References: <20241103003322.626036-1-sjg@chromium.org>
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

This header file is not used, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/ide.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/cmd/ide.c b/cmd/ide.c
index 036489fda97..be3078ae88b 100644
--- a/cmd/ide.c
+++ b/cmd/ide.c
@@ -22,10 +22,6 @@
 #include <ide.h>
 #include <ata.h>
 
-#ifdef CONFIG_LED_STATUS
-# include <status_led.h>
-#endif
-
 /* Current I/O Device	*/
 static int curr_device;
 
-- 
2.43.0

