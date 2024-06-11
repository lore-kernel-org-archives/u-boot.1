Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21214C27C78
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 02:34:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55746887EE;
	Wed, 12 Jun 2024 04:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lsI+rz/3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D307D88757; Wed, 12 Jun 2024 01:15:01 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EED5988315
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 01:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-35f089e35e7so1063748f8f.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 16:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718147699; x=1718752499; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wTfHCeEdThYm0NrWUrNIMKGuPJLSBNhsTTFSCPR2st8=;
 b=lsI+rz/3yIIqzZ0ssXAaaopNs1AGH0avjHCaoVnVUE+z13CgJ2fV4cM6kqf/ym5PZ2
 QEjhmhCbH8Ub0EediHe5qq93ZLeiNNp2RAmIJkQNk1fJN7A/aANaqaSxftLfch+pCQLD
 OdAR4w5OT4RGlq+7MK+UHPtyvOBXA2jGvu8xIHbqQ8X88lEWtJTRsOYdwEk7ENNuNWCV
 /+LVHrTMNGv+O+ylJjAYxb+NW3it1QWZwiLxbBsS9VS/TxYdNxezSXzq0N1MHZuJ5n7v
 kaTuAmKSLfVYHt7LVe4XeTaE/FI9DTAmrbyzaZcVHyBoGAoT0LIetiKz8V2yjbE8jYt0
 MCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718147699; x=1718752499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wTfHCeEdThYm0NrWUrNIMKGuPJLSBNhsTTFSCPR2st8=;
 b=Iftp+upViVuc/l2GetY4CZPKtI6eCC5DDBKu9I1j9i+Yq3o9BQ+g0CuWT4EyYw2KE9
 +eObJ/3CaA4mzVTkcJEGaYwIhtUmrBmDKGIJriWd288KDIByQphaibx2qn5l2BCyeBNF
 3aX3dmourfoccbu3IV/NrqtkMg8ZBM1Oi+nK19gRN1Xj/Y5HeTT50mwEQbUzsBPTuU1j
 //HD+Fk54yHHBxUhqNv8kvq5xJbdJPzvs3vb9GuYbSc+b3dLszyQDepQHEYKLB8HbjuJ
 1U5WliK2u2HBjJyQDR+1otW9s5jgNzTm6qWqKA3CEVbIQo9dcfKmIco9dRIHpvNaIG0i
 HReg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeI6rFnjqQvTvvAdhX6N8jKDc73i+Hv3vtUv4qOJasCq73i0NCb98WB+1BjqD4QJE+OxKM771eDvasnAerbhiknSZQAQ==
X-Gm-Message-State: AOJu0Yx96pdxtwiLbFDRmwVqIDh+0JA1Xanf68LwNBFb3Hmy79w3sd8c
 i7jy5uVMnSMsMpI8VX6dsURxVnpi2MBC5YafI3bT34k1oL0U6iq+
X-Google-Smtp-Source: AGHT+IHHhC8xKVhpefceEi8smgyAtYgHHSIl1UYPcWIWD3DfbZqjvqh3mgC9x3qoy4aYfBzyzqJMnw==
X-Received: by 2002:a05:6000:18a1:b0:35f:2937:811a with SMTP id
 ffacd0b85a97d-35fdf770d63mr116060f8f.12.1718147699202; 
 Tue, 11 Jun 2024 16:14:59 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-35f231d5761sm7052096f8f.35.2024.06.11.16.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 16:14:58 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Simon Glass <sjg@chromium.org>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>, Stefan Bosch <stefan_b@posteo.net>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Subject: [PATCH v3 8/9] ubi: implement support for LED status activity
Date: Wed, 12 Jun 2024 01:14:23 +0200
Message-ID: <20240611231435.10366-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611231435.10366-1-ansuelsmth@gmail.com>
References: <20240611231435.10366-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 12 Jun 2024 04:33:23 +0200
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
 cmd/ubi.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 0a6a80bdd10..37c16048b19 100644
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
@@ -417,7 +418,19 @@ int ubi_volume_begin_write(char *volume, void *buf, size_t size,
 
 int ubi_volume_write(char *volume, void *buf, size_t size)
 {
-	return ubi_volume_begin_write(volume, buf, size, size);
+	int ret;
+
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+	status_led_activity_start(CONFIG_LED_STATUS_ACTIVITY);
+#endif
+
+	ret = ubi_volume_begin_write(volume, buf, size, size);
+
+#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
+	status_led_activity_stop(CONFIG_LED_STATUS_ACTIVITY);
+#endif
+
+	return ret;
 }
 
 int ubi_volume_read(char *volume, char *buf, size_t size)
-- 
2.43.0

