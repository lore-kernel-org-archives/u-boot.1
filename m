Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D463C19F32
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C58B816A4;
	Thu,  6 Mar 2025 01:26:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jby3FJSF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3052980805; Thu,  6 Mar 2025 01:26:50 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DD768141E
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:26:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-85adbdf335aso2959239f.2
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220804; x=1741825604; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rfA2Dz6rVGtSqrpnhd4ke3oAITlbzYM7BVbeahAeUcE=;
 b=jby3FJSFtfIOsT+Ksl491aar7kjgId3MBCW/zW5jzgsZKOuuK7AokDnSw6nlokMuuL
 t4BRtxjqo/k6d1yyZuTuJBPcItoq2q9k+YqXUocGyGYACZK/UOgUISuNkP59V106SsYy
 7U5Nm8ointrn3ebLbu+92pE52G1tnVywcsfCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220804; x=1741825604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rfA2Dz6rVGtSqrpnhd4ke3oAITlbzYM7BVbeahAeUcE=;
 b=OzjZuBYjoMXTx16OX34kTZAizmmaG5d3zlHNO+BAq7TRk+Vxf2XPcUuqWIzXXBw6/8
 +zj/gwpJzOSMMdB/7svbHmCxzgh8btW6RS4+ehzdIeG/Jyk7vIOMJvuKVKJ/EHA95aUz
 QK6wA57mHlgjqy65tuzuNsF8+SblTvec/F1EkU7+KpQhacOP5HuxlYlpZ8X21LRUn6sF
 2Bb982bxt0zwDjYPbB/kIbKsJsNZkLbFcQYhGw51Zvv6TvBhRh/+DTHfcUYsbkdgz3ZG
 LzKtc2THpulfKRIhoaYS8/gAUnCTnwAvsHTzBZW3btl5NUtnbjDjzbKWs5OZlbcbeep/
 RYVQ==
X-Gm-Message-State: AOJu0YzprPq5QwVlxkE8N1+7zy4ASAWeVzaRImFq936VwLI4hoqaHDNl
 yi8f56hn27+Szql7Ul4ubWSSHf5FRgE2ofHV2VoSwrcEagoB1+g5weV5C6VCI89Woza5FVpdtXA
 =
X-Gm-Gg: ASbGnctG62Foy/I3TM1kVPybo8qLGGewpjEfRXTweov0GF+QniT0+Vjg9F1B9wF5edI
 W1/LDZ9VpKWW1n19BgPfUwzvoc9nXWIunTjk+UzLfgsY4wND6tJg27Mu8JYSPvK2kp8bqlpmDhf
 GKFivsP6D3Mmyjy2nj28Oog/WEoIUzl0a9HYewsc+d/G8LUbvcTlZI7fZsy3r72pOidkVfeiA1K
 O9qThVPmQmiVjanO9ET6/3DeVpqUQgUyljbKGGY32ha5q82UsV4AWrpVwQy+oSm1rtWbpp6nWrL
 CCmFIyATNhuSePsOgkDdLYULucFB+A3ceQhk8V1pqBH431/8AhHOxcuYtGI3haVEDbSxr/SYCA1
 tuPnyBw==
X-Google-Smtp-Source: AGHT+IE6MXZG9bTggLW+0xpfBTeEpc1Do8ATIiHpxWyeb84OgqAo1Mi8ecYwPXOElUmAmnDdQ25o/A==
X-Received: by 2002:a05:6602:2748:b0:855:c8e0:8b9a with SMTP id
 ca18e2360f4ac-85aff878c65mr539939839f.1.1741220804191; 
 Wed, 05 Mar 2025 16:26:44 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:26:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v5 08/29] x86: Drop the unnecessary base_ptr argument to
 zboot_dump()
Date: Wed,  5 Mar 2025 17:25:02 -0700
Message-ID: <20250306002533.2380866-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306002533.2380866-1-sjg@chromium.org>
References: <20250306002533.2380866-1-sjg@chromium.org>
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

This value is include the bootm_info, so drop the unnecessary parameter.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/zimage.c | 5 +++--
 cmd/bootflow.c        | 3 ++-
 cmd/x86/zboot.c       | 8 +++-----
 include/bootm.h       | 7 ++-----
 4 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index d71285e71d9..145ba0b8ea0 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -554,12 +554,13 @@ static void show_loader(struct setup_header *hdr)
 	printf("\n");
 }
 
-void zimage_dump(struct bootm_info *bmi, struct boot_params *base_ptr,
-		 bool show_cmdline)
+void zimage_dump(struct bootm_info *bmi, bool show_cmdline)
 {
+	struct boot_params *base_ptr;
 	struct setup_header *hdr;
 	int i;
 
+	base_ptr = bmi->base_ptr;
 	printf("Setup located at %p:\n\n", base_ptr);
 	print_num64("ACPI RSDP addr", base_ptr->acpi_rsdp_addr);
 
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index da17fd93b8b..6d0be320bdb 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -385,7 +385,8 @@ static int do_bootflow_info(struct cmd_tbl *cmdtp, int flag, int argc,
 		bootm_init(&bmi);
 		/* we don't know this at present */
 		bootm_x86_set(&bmi, bzimage_addr, 0);
-		zimage_dump(&bmi, bflow->x86_setup, false);
+		bootm_x86_set(&bmi, base_ptr, bflow->x86_setup);
+		zimage_dump(&bmi, false);
 
 		return 0;
 	}
diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index 029ff4eb9fd..ee099ca041b 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -103,15 +103,13 @@ static int do_zboot_go(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_zboot_dump(struct cmd_tbl *cmdtp, int flag, int argc,
 			 char *const argv[])
 {
-	struct boot_params *base_ptr = bmi.base_ptr;
-
 	if (argc > 1)
-		base_ptr = (void *)hextoul(argv[1], NULL);
-	if (!base_ptr) {
+		bmi.base_ptr = (void *)hextoul(argv[1], NULL);
+	if (!bmi.base_ptr) {
 		printf("No zboot setup_base\n");
 		return CMD_RET_FAILURE;
 	}
-	zimage_dump(&bmi, base_ptr, true);
+	zimage_dump(&bmi, true);
 
 	return 0;
 }
diff --git a/include/bootm.h b/include/bootm.h
index fe7f80b88a5..c471615b08c 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -342,13 +342,10 @@ const char *zimage_get_kernel_version(struct boot_params *params,
  *
  * This shows all available information in a zimage that has been loaded.
  *
- * @bmi: Bootm information
- * @base_ptr: Pointer to the boot parameters, typically at address
- *	DEFAULT_SETUP_BASE
+ * @bmi: Bootm information, with valid base_ptr
  * @show_cmdline: true to show the full command line
  */
-void zimage_dump(struct bootm_info *bmi, struct boot_params *base_ptr,
-		 bool show_cmdline);
+void zimage_dump(struct bootm_info *bmi, bool show_cmdline);
 
 /*
  * bootm_boot_start() - Boot an image at the given address
-- 
2.43.0

