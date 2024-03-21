Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D868C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 18:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 046D488125;
	Thu, 21 Mar 2024 19:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="E4BXKC4v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2585A88119; Thu, 21 Mar 2024 19:12:24 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D344C8811C
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 19:12:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B1BE03FBD3
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 18:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1711044736;
 bh=un6VBAN33D3PgLUCORGHDbJliCyI7ezWwEXKN7kn8HE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=E4BXKC4vLBLOy12g9uYT3hp/c8hyPhtZouvo8vmiSAiW7UcIxXfqu4rmvLqcl2qnG
 KzC+6eAEcNmJWO8FoaoHGH0TdtZeC6dJaLqHlAn6zKOzpJ/J1FGHi4eh85YgQKAyp/
 CTtXvf8yW5lP5bzY9K1EkZhgRhKmstQs/YYWICU061bKURSCNrLL/PVuqr+m1Ri91v
 xoN4vMqlbYmn2N0zgnfD37ZJjA1vf/SCgA7ih0YqmfOLJL5PRDgnnACtA22OsAP+fo
 2BDywbAc3TcZDns8fVQH01e2peMvwWKOwB+sr8s57GyRtHt69ezEnGtK7r+VPeG52Q
 6BNQs59WVWGLg==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-41413823c1bso11357645e9.1
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 11:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711044735; x=1711649535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=un6VBAN33D3PgLUCORGHDbJliCyI7ezWwEXKN7kn8HE=;
 b=Xukhl7WQfj4Ka6EHwCJQAuPNFUIvLIXsTzdcY+UC3LCDyZYHzOu7Fkk+fqhtkwWr6E
 lgBt5ck/Ac4tcbpFN40s+08ky+0iqP4yO+djvdmUbEUioeyOgJw10853dhL9oHGxrtDd
 cFfqb8XURp6QUcpMBOYQS6yMzb78nY0hIoVPagpLdpP9HqdAzMRUjR+wCsamTR2Nr+GA
 EhnUoso2/Tb6LNeAKGEP7G6L4zoT9PNrmBY4fe5npDFwGXsqQlmxB90tXp2SAThXy4b6
 Md3YzBkIf3bLfBPEMKPnA45cnpgH69BAzxKF7X3Ns/J8pbkHfOwjBnQLHcs8+9q+pwMp
 UVDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfvbQ6Ca7BJfKTqec7IswJyimEjT3v3gp+fD2YQSbpHCA9FmTE/gidp6OZKftk7R6pyc1lgVHmzSdA9MhrnuhJs4IWbg==
X-Gm-Message-State: AOJu0Yx+CbcyUbD/NZK7QroEl2Fl1FA9yrh1jiiLU3FWMIOlOaMF8Uw4
 /ZB6dUWtMDy26TZp0uciOTGp3oQwRx9QrbB0HUG5lEj4AQKFjrTE/eeEJ1sUOnlzSEgmpvCFK4r
 1wOSYGrO4O6ZB7c+ofOT68KRy7gwq6Ty9rv+AJfErMfyrddtS3mjW2uAv+ojmK7VjJ30=
X-Received: by 2002:a05:600c:1e24:b0:414:6332:fa2a with SMTP id
 ay36-20020a05600c1e2400b004146332fa2amr3383907wmb.9.1711044735264; 
 Thu, 21 Mar 2024 11:12:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+mo+JhMfXFU0cCR57QNQWbYvEH6/fjDrn1YTKiqUTvFDtmOUr2Kapf9ahsPzZNyxiMCnBdA==
X-Received: by 2002:a05:600c:1e24:b0:414:6332:fa2a with SMTP id
 ay36-20020a05600c1e2400b004146332fa2amr3383888wmb.9.1711044734993; 
 Thu, 21 Mar 2024 11:12:14 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 hg10-20020a05600c538a00b004147743bd0dsm1469420wmb.38.2024.03.21.11.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 11:12:14 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Chanho Park <chanho61.park@samsung.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 3/6] riscv: set fdtfile on Milk-V Mars
Date: Thu, 21 Mar 2024 19:11:46 +0100
Message-ID: <20240321181149.177356-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240321181149.177356-1-heinrich.schuchardt@canonical.com>
References: <20240321181149.177356-1-heinrich.schuchardt@canonical.com>
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

Set environment variable fdtfile to the correct value for the Milk-V Mars
board.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	rebase patch
---
 .../visionfive2/starfive_visionfive2.c        | 43 +++++++++++++------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index 76439179fa7..5ae8b850280 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -9,6 +9,7 @@
 #include <dm.h>
 #include <fdt_support.h>
 #include <env.h>
+#include <log.h>
 #include <asm/arch/eeprom.h>
 #include <asm/io.h>
 #include <asm/sections.h>
@@ -17,6 +18,8 @@
 DECLARE_GLOBAL_DATA_PTR;
 #define JH7110_L2_PREFETCHER_BASE_ADDR		0x2030000
 #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
+#define FDTFILE_MILK_V_MARS \
+	"starfive/jh7110-milkv-mars.dtb"
 #define FDTFILE_VISIONFIVE2_1_2A \
 	"starfive/jh7110-starfive-visionfive-2-v1.2a.dtb"
 #define FDTFILE_VISIONFIVE2_1_3B \
@@ -48,24 +51,38 @@ static void set_fdtfile(void)
 {
 	u8 version;
 	const char *fdtfile;
+	const char *product_id;
 
 	fdtfile = env_get("fdtfile");
 	if (fdtfile)
 		return;
 
-	version = get_pcb_revision_from_eeprom();
-	switch (version) {
-	case 'a':
-	case 'A':
-		fdtfile = FDTFILE_VISIONFIVE2_1_2A;
-	        break;
-
-	case 'b':
-	case 'B':
-	default:
-		fdtfile = FDTFILE_VISIONFIVE2_1_3B;
-	        break;
-	};
+	product_id = get_product_id_from_eeprom();
+	if (!product_id) {
+		log_err("Can't read EEPROM\n");
+		return;
+	}
+	if (!strncmp(product_id, "MARS", 4)) {
+		fdtfile = FDTFILE_MILK_V_MARS;
+	} else if (!strncmp(product_id, "VF7110", 6)) {
+		version = get_pcb_revision_from_eeprom();
+
+		switch (version) {
+		case 'a':
+		case 'A':
+			fdtfile = FDTFILE_VISIONFIVE2_1_2A;
+			break;
+
+		case 'b':
+		case 'B':
+		default:
+			fdtfile = FDTFILE_VISIONFIVE2_1_3B;
+			break;
+		}
+	} else {
+		log_err("Unknown product\n");
+		return;
+	}
 
 	env_set("fdtfile", fdtfile);
 }
-- 
2.43.0

