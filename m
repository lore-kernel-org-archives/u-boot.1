Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A9ACD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 08:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F73888362;
	Tue,  2 Apr 2024 10:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="UmdXiClm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E7B987E30; Tue,  2 Apr 2024 10:49:29 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35E4E88352
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 10:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 428FA424A9
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 08:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712047763;
 bh=1CJk8YyTV1W4xY5TIyJqrF7DbOF+Z33g1KK6xyvA9lA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=UmdXiClmPMoyefy1uzsxqYfktrvjTtTopq80ThAbTsU24jpxquk23Sh56qbSdRpj3
 9YxYo+DWjTGB4h+D08WjlMJJzPGqs7Cdrjovb5AIDlta6H/rVECYAubiuv4taSQfY3
 +N6B+vy4zhXIRPRvPFUJpHnGltxj9GR1oeBhAeiHOsFtaC2ovb8psyR++l4Ph+Oltg
 tUDNx4bLwBNfFc1DOzCP3w1d8NL7VkuERtQaiBcXmYD0OVnATqt/a1OYj3/aHnaK4f
 MQpeeRh+NxSBj1bXuRyVgO1DPAlGnNlRJvwJHcAhLam7wOVUaLdcucpHCRYUZ0a9ht
 2v9x1h1yQZI0g==
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d6f7def478so41756941fa.2
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 01:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712047762; x=1712652562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1CJk8YyTV1W4xY5TIyJqrF7DbOF+Z33g1KK6xyvA9lA=;
 b=u0PonWVdd/vXNyCOpyqrS4LcdF5dlBMl5PSaWir88UtBK7O4tTj9XA4A2f8Zt3Z6Jx
 QYXTs0tANiH6ozguwoo8ZrFzOF8TQjXP3BtSEr7+3u9fdC2C0Z+LSQT/y1iX0lyrp2ZJ
 wvvwNHyD4kiOr4oAQ1DG3TeUIG/8/YA3XmoPlmb5o3hisYpFtM1cAZD0oFpqpruy70Mi
 fzOpGdYMJ0Jymth92ZpyQumNUz8NVR/YPU3Hx/GKPiroW8Ux+DATcqA/cwOhwLl13O4l
 LRZcvk+SrpExiGJ42kvigs9sjHEzsHIkzH14gH6SjdFMAp3LFv7lCWrm37KkoyAORkSW
 r90A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZAvdoKJi24+uZ/rr/cDd2F3pVs5rENbbpuEPDH9WdbcNYND8rd35vMvaVqbSxYSjs1L539UQNks4zD6JVS6rmgjy3eQ==
X-Gm-Message-State: AOJu0YxzOGRnfWGPliDb6/a6b6bTrtEMKjvxhifimGSO+if3Djpd5458
 69ZI2ntOy0rRVOTEADMQjJeQe17cDjSmhMQdkcUhpvurT6QVqjE+d6JGg56AvqtsXFR6SxiXcnP
 ZSgV/zi0f9FFqeHPliF8iYqsJ3drH2O4kWvPlzP4jFYM6VRsRIo+yO4PKbs7pIYhhDzE=
X-Received: by 2002:a2e:6a17:0:b0:2d4:269e:59df with SMTP id
 f23-20020a2e6a17000000b002d4269e59dfmr8000468ljc.52.1712047761992; 
 Tue, 02 Apr 2024 01:49:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvFXNM1m0YP9gFM5x9TS6ewTcb3Glj07ZtKQjNgarxH59ylVsoWLx3MtRlWgFaVR4UxXgObA==
X-Received: by 2002:a2e:6a17:0:b0:2d4:269e:59df with SMTP id
 f23-20020a2e6a17000000b002d4269e59dfmr8000446ljc.52.1712047761676; 
 Tue, 02 Apr 2024 01:49:21 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a05600c4f9200b004148c3685ffsm17409318wmq.3.2024.04.02.01.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 01:49:21 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 3/6] riscv: set fdtfile on Milk-V Mars
Date: Tue,  2 Apr 2024 10:49:09 +0200
Message-ID: <20240402084912.43228-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402084912.43228-1-heinrich.schuchardt@canonical.com>
References: <20240402084912.43228-1-heinrich.schuchardt@canonical.com>
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
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
v3:
	no change
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

