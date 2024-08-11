Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19509C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:56:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 994F088977;
	Sun, 11 Aug 2024 16:51:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dC8MTlLD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17D0388962; Sun, 11 Aug 2024 16:51:32 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6588C8894F
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-816ca307407so134650739f.2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387886; x=1723992686; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vL6h1//yX+LtwdpRCe7LKCMRk0QnucliXDCBozyQUjE=;
 b=dC8MTlLD2auqIcHnPr0ZdpLbdvlT5Bl8QrndPpz08bqWOU2w5sRwVlkx0UdMIbTBLL
 uzvyNizHddC72cKCtiEU0qLlFrJjjj9ReAd1oV9NZoBICnLAc+9NLtsexxRVk+QEcduF
 EAGlrl/9N+q5+FucXQjDuNzAhAPHpsi9Ww9Eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387886; x=1723992686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vL6h1//yX+LtwdpRCe7LKCMRk0QnucliXDCBozyQUjE=;
 b=n9MF+7T59xuh5IHJhPSD3hnAHPjWGuO0jexF1ZCRT9ezy++Xzks+T6pnx6/8dD5Gve
 jrD66yAHDiEzrHdpHS3DkZdwAxXrsMJDIKEr/7AKffPqb1CEtJSEBZawH9/PGo85RGG+
 jUowp0iF99qSE4eNxceyiq86HHehRwgoC3dj0sSHO0mkyv4gMafuDfcPZ/hNNbt0nTAT
 wnXRl8X3p4MJo8FSwNKNob5iFD2xMmw3iJ397RRzItXNfXlyKOtVR/RNq+ob8qZmWKf/
 06QMSZ+IkvSetcumzlZ49lSp5J3tswe5WoGlLYf3HWaxUiuV1fvCelcK920NkFaIoHMM
 lipQ==
X-Gm-Message-State: AOJu0Yziv4gsiT9xLAE+g2fGAt3Nyil2xtRAWjs4RhA9i+xcaw2SsJtl
 bv6OSYL3xyEvgiiRyt/ww8z20+lPv6ZVNtIffubTOQg+XXxiNSLkHN48QxdokZB2DmUGrJPXBMU
 =
X-Google-Smtp-Source: AGHT+IEfSLlIIAWRey6oLKmAAgsNygjFS5TxNoZ4GMuj1mm1Ge+v4uAAozHfCZyV/3B6IKn5r4H2aA==
X-Received: by 2002:a05:6602:15d3:b0:807:f0fb:1192 with SMTP id
 ca18e2360f4ac-8225ece24c2mr995161339f.1.1723387885981; 
 Sun, 11 Aug 2024 07:51:25 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca769fbe17sm1076047173.101.2024.08.11.07.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:51:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 16/18] i2c: Drop i2c_get_bus_num_fdt() and
 i2c_reset_port_fdt()
Date: Sun, 11 Aug 2024 08:50:45 -0600
Message-Id: <20240811145047.4189460-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145047.4189460-1-sjg@chromium.org>
References: <20240811145047.4189460-1-sjg@chromium.org>
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

These functions are 11 years old and are only used by one board. Drop
them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/i2c.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/include/i2c.h b/include/i2c.h
index 282f3cd700f..f468b52cd7b 100644
--- a/include/i2c.h
+++ b/include/i2c.h
@@ -933,24 +933,6 @@ int i2c_set_bus_speed(unsigned int);
 unsigned int i2c_get_bus_speed(void);
 #endif /* CONFIG_SYS_I2C_LEGACY */
 
-/**
- * Find the I2C bus number by given a FDT I2C node.
- *
- * @param blob  Device tree blbo
- * @param node  FDT I2C node to find
- * Return: the number of I2C bus (zero based), or -1 on error
- */
-int i2c_get_bus_num_fdt(int node);
-
-/**
- * Reset the I2C bus represented by the given a FDT I2C node.
- *
- * @param blob  Device tree blbo
- * @param node  FDT I2C node to find
- * Return: 0 if port was reset, -1 if not found
- */
-int i2c_reset_port_fdt(const void *blob, int node);
-
 #endif /* !CONFIG_DM_I2C */
 
 #endif	/* _I2C_H_ */
-- 
2.34.1

