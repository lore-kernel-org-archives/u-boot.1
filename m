Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1047BCDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 06:58:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8413D86E75;
	Thu, 12 Oct 2023 08:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b56P89yG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5910B86E3D; Thu, 12 Oct 2023 08:56:42 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF6F586E4F
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:56:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c9a1762b43so5465435ad.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 23:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697093776; x=1697698576; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W8lRc0pMYF8RL4w6QVC3+/GUvteSpzhCv8BSfqmV018=;
 b=b56P89yGBK7eiQiogWgWS7YVJHzXzDewD2oKyJ2QoXbMDFjBt+IekZpYXNBTkoK8Xk
 nZNPKy8bcnS2sMwG83tPg6M00lgl49xdKIgt5uPJ8Iqs1Oc99dmOvPohd8x0WpoqPMFl
 MhDdJAP9rvFeY8DDlfhTGjoILbfuybx904BkzSShqI3VRLaUIQugWkcRY74s1Ux1NoKG
 l9IHKGyHbO64ZhmrtO574E7yHFRUYqiO6TmVXgVUkBXzWPzrtj0vF/uK/qb+aybbnvhG
 8HDZhmzxbeOkz8C/3PtzNjcTkMikDCd9xU65mOFLvDE+SODYogt1n5M+3p2iSaoIPgnC
 r1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697093776; x=1697698576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W8lRc0pMYF8RL4w6QVC3+/GUvteSpzhCv8BSfqmV018=;
 b=Q3ODKS1gjBGjGjqSkVNdLrma6iJIhUD3RjMOGYabO59qgn4tVQW7qRQfbREHG9mWoC
 yjzPEyMapYFLQToWzTAxY4JVqgb3yWK7u9S5SBb2uzQf7VUTPOmIHT1ex+yJPfuHDLbU
 EagI0sfVEjT7JzldGGicdk0jaWMu6TTTQWEy1iB88xp+mEx7wQ0++YI1Dq+ASnWjnaJv
 ILtPVtANU//VPDdIyb8ZuNL0HBuAB/KZSzK6XLrXBpUjIPjFfqkjVk2rsYY063aRDy3r
 SudaR5JktKp1ONwyLQaiCzSJUyEqUVZBTFBGtDmTE8OUE3MJEzs0CpfWCfiiNT50WJLV
 nj7w==
X-Gm-Message-State: AOJu0YzpOJHgNPRd5Jlqu0MiWSnT8dDl/hqI+BoO2vxmywsKMFEhOV3E
 erJ8ENAShgw/WjPslYjm/lA=
X-Google-Smtp-Source: AGHT+IFmCpV9IpemgoNtzCxl4aVwO/PH8JVI5TnbdlA8c33uwMRti15NMlR6yBLbTocysckR1mZyNw==
X-Received: by 2002:a17:902:6bc9:b0:1b8:a19e:a3d3 with SMTP id
 m9-20020a1709026bc900b001b8a19ea3d3mr20497929plt.52.1697093775950; 
 Wed, 11 Oct 2023 23:56:15 -0700 (PDT)
Received: from cs20-buildserver.lan ([1.200.128.112])
 by smtp.gmail.com with ESMTPSA id
 s19-20020a170902c65300b001bc68602e54sm1096977pls.142.2023.10.11.23.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 23:56:15 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 trini@konsulko.com, jim.t90615@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 2/4] configs: npcm: support more uart baud rate
Date: Thu, 12 Oct 2023 14:53:21 +0800
Message-Id: <20231012065323.2709121-3-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012065323.2709121-1-JJLIU0@nuvoton.com>
References: <20231012065323.2709121-1-JJLIU0@nuvoton.com>
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

add uart baud rate table to arbel(npcm8xx) and poleg(npcm7xx)

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>

Changes for v2:
   - add commit message
Changes for v3:
   - modify CONFIG_SYS_BAUDRATE_TABLE 
---
 include/configs/arbel.h | 5 ++++-
 include/configs/poleg.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/configs/arbel.h b/include/configs/arbel.h
index 891257bc93..29010503d3 100644
--- a/include/configs/arbel.h
+++ b/include/configs/arbel.h
@@ -7,11 +7,14 @@
 #define __CONFIG_ARBEL_H
 
 #define CFG_SYS_SDRAM_BASE		0x0
-#define CFG_SYS_BOOTMAPSZ		(30 << 20)
+#define CFG_SYS_BOOTMAPSZ		(128 << 20)
 #define CFG_SYS_BOOTM_LEN		(20 << 20)
 #define CFG_SYS_INIT_RAM_ADDR	CFG_SYS_SDRAM_BASE
 #define CFG_SYS_INIT_RAM_SIZE	0x8000
 
+#define CFG_SYS_BAUDRATE_TABLE	{ 9600, 14400, 19200, 38400, 57600, 115200, 230400, \						  380400, 460800, 921600 }
+
+
 /* Default environemnt variables */
 #define CFG_EXTRA_ENV_SETTINGS   "uimage_flash_addr=80400000\0"   \
 		"stdin=serial\0"   \
diff --git a/include/configs/poleg.h b/include/configs/poleg.h
index 1e96e838be..2a2d85c8ec 100644
--- a/include/configs/poleg.h
+++ b/include/configs/poleg.h
@@ -13,6 +13,8 @@
 #define CFG_SYS_BOOTMAPSZ            (0x30 << 20)
 #define CFG_SYS_SDRAM_BASE           0x0
 
+#define CFG_SYS_BAUDRATE_TABLE	{ 57600, 115200, 230400, 460800 }
+
 /* Default environemnt variables */
 #define CFG_EXTRA_ENV_SETTINGS   "uimage_flash_addr=80200000\0"   \
 		"stdin=serial\0"   \
-- 
2.34.1

