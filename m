Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8064E7E638
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:23:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E90E286E79;
	Tue, 26 Sep 2023 16:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e/kra1we";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E7F886EAB; Tue, 26 Sep 2023 16:16:18 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52EFF86E5D
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:16:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3513fa06bafso13422535ab.3
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737765; x=1696342565; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+BJ+yAfXNk2k4u/mHWhJnvfy92a+WyBXzBVHFMa08lU=;
 b=e/kra1weG3Y46tZcK5LwQCUvbz9hvbBxsPcUMQKfr+S2MKSyZHa8UoMcw+DJV5mHLS
 YdyXv+egkRaSMiI1LMR+vntFGNZ0VW6uy4FDhBjY1Jw9nkI6rs2gwxAOZIHxK11VYqB0
 ijY6S1iC1RLBWTDjsXfZrFDvecVPoZ7g8CSY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737765; x=1696342565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+BJ+yAfXNk2k4u/mHWhJnvfy92a+WyBXzBVHFMa08lU=;
 b=QaOjLxXI4PSDN36bVJmRfFkUleGfGYQyya/yPheKz6spWOgSq7AACXip5ktZFP5LPw
 x2zMEya1VPdIkdVGm5snlCU1TIIYJBiZbfUh5Y0Lk4ufh7UWpRvkZ0XldMIF6GNinn9P
 jkerZ8dcxYuZwvNwhUu7+RKic1+/9dB1XCHzBDnOe3fd7YQ69IjTAFIiSN+MsGjebTyJ
 8QxObKYfXpDy2/gCr20CBaMaqBEag58tM6o+Qh80oh9MhTX/PYcJ6wV7R31wa83p04GS
 UfvxnMjD+FEsXCnV+u0Turmq5wK0YIK+8HWNrocn1w5TCJ4Di/cVrfGBsLD7ZR8IOH/8
 w7RQ==
X-Gm-Message-State: AOJu0YwncxzPcU8ihZ5WDzbF5YhXCvQiVYcoGQT5aZY54vxNFKkRslWO
 HHYk+7o6nVDJ6hgSX3ZK8R4vfc9DUOSxxxCrwgc=
X-Google-Smtp-Source: AGHT+IHmEWFmWk4xViP7itr1Slwf2AXajTlPwyUXk4CvRR2hh9OhnUlg6eS6P5Nm3DLcDzKfa9UIPg==
X-Received: by 2002:a92:dcc6:0:b0:34f:ef94:c803 with SMTP id
 b6-20020a92dcc6000000b0034fef94c803mr10372356ilr.25.1695737764949; 
 Tue, 26 Sep 2023 07:16:04 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:16:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 42/44] serial: Drop ns16550 serial_getinfo() in SPL
Date: Tue, 26 Sep 2023 08:14:56 -0600
Message-ID: <20230926141514.2101787-43-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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

This is typically not needed in SPL/TPL and increases the code size.
Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Add new patch to drop ns16550 serial_getinfo() in SPL

 drivers/serial/ns16550.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index eab9537fbae5..5ca2828ae853 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -13,6 +13,7 @@
 #include <ns16550.h>
 #include <reset.h>
 #include <serial.h>
+#include <spl.h>
 #include <watchdog.h>
 #include <asm/global_data.h>
 #include <linux/err.h>
@@ -472,6 +473,10 @@ static int ns16550_serial_getinfo(struct udevice *dev,
 	struct ns16550 *const com_port = dev_get_priv(dev);
 	struct ns16550_plat *plat = com_port->plat;
 
+	/* save code size */
+	if (!spl_in_proper())
+		return -ENOSYS;
+
 	info->type = SERIAL_CHIP_16550_COMPATIBLE;
 #ifdef CONFIG_SYS_NS16550_PORT_MAPPED
 	info->addr_space = SERIAL_ADDRESS_SPACE_IO;
-- 
2.42.0.515.g380fc7ccd1-goog

