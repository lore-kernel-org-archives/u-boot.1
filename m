Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE88FC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 20:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40A9788C12;
	Fri, 19 Jul 2024 22:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YBKQwuXO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E25788C0E; Fri, 19 Jul 2024 22:33:23 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65AF388204
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 22:33:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-75b77be7611so268376a12.3
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 13:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721421200; x=1722026000; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WPowDHH6iw1UznnucGaJReYJWKexVi8IuAP6OsuDOiM=;
 b=YBKQwuXO4H96IF9AUBrjSlaHS36gQ2K08eYn7kXY0vnlOxFEOY4AAqi7vomjOrVVf4
 77xBZXvaI6BXsxQWwHe+VgmK9Csed1wNUCCixTxJ9A66M8HigAuZOlWu4Qfw2R0nri+O
 tv/UjmT1YLngBPg+MD9n2Krs9iYO3yD1kYQefmGqPfiP91L03+F6xgoPAKkG05eC4Q9s
 szFZLqxlyXFZHThDpY29Csxs4ddiyMPKFuavBnmc3+xJ8PU6yPGIee7cSirndN5pSSf6
 es4mRkCjPAnBeidB2/G5+UZFYCx9sW5UIQ2emqMfFrKrAJybOUAhW3Zg6wXwgaP2nrt/
 tdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721421200; x=1722026000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WPowDHH6iw1UznnucGaJReYJWKexVi8IuAP6OsuDOiM=;
 b=hI6N0jYH3s9T0d8rz/9o4+TnsCGsaDoQ09wN0+de2ymVhBZMy9Z/IeJpUQvOd8tenj
 NT80jBeKOZ7j1eEYkjTr9QI+/I9p5gFNhRZ4xmYDfezXS45T5Wjjvzfio7jjtfibzudb
 ajNcF7oPRbcyRORoi0KPTkH4i61Ifw8h2RMxRSV8ad7fNSQkqBFszRBYbMQq7JEIV8/N
 thOTyvF/LyTkNtEIegr6dsE2NvUfDstMKlEHMm+Rs8Daqh5Zy5jEhvUDlZxe8acfS+RS
 rjyhBoilbL1BiaCZzlnaMQ7NiBWs++0VF6/q7dbsxQsElWAHcrcdZHmHzqMN2lVn5uk3
 DncQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvS/THL9wMNIA0JlIXDLw7yOXgK2vxGOy3anYnLkypucKG5jejQsAqAdFMFy2TYVdHT6K1YDmYUAtF7GsSvcYRYy9EjA==
X-Gm-Message-State: AOJu0YyI8JdWU7U3z4Q/VF+WrjVFuF5zZXcIseZcAStR68b0WGj3QGdT
 EP3EyvlpD6a4CD4vQR6UjrFcok1JdnLjbNCUI9bK+ppm61HcAYKK
X-Google-Smtp-Source: AGHT+IEetMtQEDK4UUl5EPVxxCYe9EElNHg194Q4xVCRx7f9fJTOEWuPRGa0M/INlnHAGPzae+tnqQ==
X-Received: by 2002:a17:90b:20b:b0:2cb:4382:99f1 with SMTP id
 98e67ed59e1d1-2cd16191fcdmr739281a91.6.1721421199933; 
 Fri, 19 Jul 2024 13:33:19 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:27e4:cf37:80d4:17f5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ccf8092da9sm2138230a91.37.2024.07.19.13.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 13:33:19 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: breno.lima@nxp.com
Cc: francesco.montefoschi@udoo.org, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 2/4] udoo_neo: Select LTO
Date: Fri, 19 Jul 2024 17:33:09 -0300
Message-Id: <20240719203311.1695523-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240719203311.1695523-1-festevam@gmail.com>
References: <20240719203311.1695523-1-festevam@gmail.com>
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

u-boot.img has grown in such a way that it overwrites the
environment region.

Select CONFIG_LTO to help reducing the U-Boot binary size
and add a build-time size check to avoid U-Boot to overlap
the environment region.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Newly introduced.

 configs/udoo_neo_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/udoo_neo_defconfig b/configs/udoo_neo_defconfig
index 9f9ad0ad5ec7..97e3b379835f 100644
--- a/configs/udoo_neo_defconfig
+++ b/configs/udoo_neo_defconfig
@@ -19,6 +19,9 @@ CONFIG_SPL_SERIAL=y
 CONFIG_SPL=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 # CONFIG_CMD_BMODE is not set
+CONFIG_LTO=y
+CONFIG_HAS_BOARD_SIZE_LIMIT=y
+CONFIG_BOARD_SIZE_LIMIT=523264
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt; run distro_bootcmd"
 CONFIG_SYS_PBSIZE=532
-- 
2.34.1

