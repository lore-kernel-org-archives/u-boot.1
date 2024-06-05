Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A937C27C52
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 19:41:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C06AB884E7;
	Wed,  5 Jun 2024 21:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lQIv3bVp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAA0A88354; Wed,  5 Jun 2024 21:22:10 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B17F68836C
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 21:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4213870aafdso2242095e9.2
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 12:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717615328; x=1718220128; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uXkXlxaFoE7EdVjfBeOn9iAr3jACb605iugKm19iiDE=;
 b=lQIv3bVpIvffDEOC9QexJH0yaRXo0V6nuHcCT371hDzpt3OfGWBXCeu6u8+KWp+ojt
 81c2e16anhjkXw0hQ4Hiks+a9s+Sz4oMN2Y64Tlo+CiHPRkF4Nk0oY4nshI+h9gJlVcU
 28MDr8DzaMs2PlmVZ405DLqcUzVxOkf42sExCMvPs3VgOrufFYWtFglxARjuZjhe9Eyp
 IwYbR0NEyC3GxrqI2PDiWNvmrmB3kxmcTQvqQNJ3FkX4Xn+TW2izZO5BtZekcipeQ+IB
 End0WJmyM3cq6mNtLh2lYk8j0Pt336aeQSFhthm8z2/qhfdAuPdQ+DvHksjqSSvEA9ar
 tfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717615328; x=1718220128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uXkXlxaFoE7EdVjfBeOn9iAr3jACb605iugKm19iiDE=;
 b=EOxx5sspQPXF2bjmbFSVhdH9elTzFzuT4XDvl+wCi7mTJsQ2tUydWB7vTVy5e2lBP9
 UjtZEMdVztgU0zxDCl/hObdcR460/3ljDPmhbS/B/QdalExzgHGz5+wdJNSGqjz5GLeF
 qcnexBdg8Tcv76CmSnNXiXr+NCqvOzEbVhmZy0BjND4qdNdqEH+AO75r8vBqfOQUCNEl
 bHOHW3LeHmMPNJGt1CMcfz9nC+ng9yqqPJep2rVX9M9LtL5fmMncrryyDWfSBve+ub1z
 WcbsuWMPDihZv9f/KXcmsXgk/nKEEdah1gOvPHT+ynFDWl61ENI4csAyg2XxQvgeIf0X
 HBvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXE0k7AnUdMDMi4zdJ9xuTkXRlIF0YTn5iU3jPHuwCVOQ8fiJcH/q3NAACAchaUF6ONdMacfwtXlBYQKlqkjptH5BQrA==
X-Gm-Message-State: AOJu0YwlpsE3Yac3uzn8YOzDsbe3PXS2fG7TgUJKOmtKbqrpoSc4hnRr
 M22Bm+qsNEiRZaAeocVFjq1iXUPI9Ff+/DghlqqwefHk+OfuuNhn
X-Google-Smtp-Source: AGHT+IErBhjLsRxsMG74ZnVXIuy6g++nKkoDlCz82M9dDcJzW9H8oUZp6W3oAh5397d34nLRCaLFTQ==
X-Received: by 2002:a05:600c:458e:b0:420:2986:ccee with SMTP id
 5b1f17b1804b1-4215633febamr27014155e9.30.1717615328083; 
 Wed, 05 Jun 2024 12:22:08 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4214bf5994csm36079625e9.1.2024.06.05.12.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 12:22:07 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Eugene Uriev <eugeneuriev@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>, Raymond Mao <raymond.mao@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 William Zhang <william.zhang@broadcom.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Pratyush Yadav <p.yadav@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 7/7] ubi: implement support for LED status activity
Date: Wed,  5 Jun 2024 21:21:39 +0200
Message-ID: <20240605192146.19052-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605192146.19052-1-ansuelsmth@gmail.com>
References: <20240605192146.19052-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Jun 2024 21:37:35 +0200
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

Implement support for LED status activity. If the feature is enabled,
make the defined ACTIVITY LED to signal ubi write operation.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 cmd/ubi.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 0a6a80bdd10..c300f1dc853 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -20,6 +20,7 @@
 #include <mtd.h>
 #include <nand.h>
 #include <onenand_uboot.h>
+#include <status_led.h>
 #include <dm/devres.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -417,7 +418,21 @@ int ubi_volume_begin_write(char *volume, void *buf, size_t size,
 
 int ubi_volume_write(char *volume, void *buf, size_t size)
 {
-	return ubi_volume_begin_write(volume, buf, size, size);
+	int ret;
+
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+	status_led_set(CONFIG_LED_STATUS_ACTIVITY,
+		       CONFIG_LED_STATUS_BLINKING);
+#endif
+
+	ret = ubi_volume_begin_write(volume, buf, size, size);
+
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+	status_led_set(CONFIG_LED_STATUS_ACTIVITY,
+		       CONFIG_LED_STATUS_OFF);
+#endif
+
+	return ret;
 }
 
 int ubi_volume_read(char *volume, char *buf, size_t size)
-- 
2.43.0

