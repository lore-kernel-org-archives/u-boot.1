Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B9EE77170
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DE488967B;
	Fri,  6 Dec 2024 03:36:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="meWxS7H/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F0548965E; Fri,  6 Dec 2024 03:36:58 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C7EB896A0
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:36:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3a81324bbdcso2357895ab.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452613; x=1734057413; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r+z7xhHs6Fff2kbi3oQStxxohtKhNJ050PabMj88Bb4=;
 b=meWxS7H/9V8MYIPBAuwchkdP696OWivSu0J5yNHIYWlePtFda1tmS5Cai4R/tsEcu8
 STUypAB43KhLK/M4AmybhK98TxKfaSKFAK1OvpDRq3nyLIFbPuelTp/+a+OVX7IzLrYV
 oYQXhstn+IUsCS8WmnK/jKcuNqCBkiGSQkh8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452613; x=1734057413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r+z7xhHs6Fff2kbi3oQStxxohtKhNJ050PabMj88Bb4=;
 b=AHWm7xZn6Efk/WWr382L8fqVaDzdJqhOmjJuc5AMFKKIqdXEwotThW3z7qwwldZ8kh
 TCSsbRV/BBmdOppZlcsHU6IKIok2mZNo9Wgp+6O9FE3MLzCfC5NpZCzwmJ7o9yFhFm98
 yDQIpX4Aio4IlsI1vM8TrDr+FSEXGjSQcMi+cz6Maq4YynlNLKZsw4FS94FGXlfzWXyN
 tqYqCPenxrsj768YKV8fxlbSXpBXfwUYOvkv7G2W/OWvBHygZwaHlakHTBafcKLSOARM
 7XM/K1d1etb56KW08nnXGZrrZv0yE7ndYF7Wr8JvrIFhOKSWRYx40xExX/MUIK/SM+LO
 j2kA==
X-Gm-Message-State: AOJu0Yw1B1WxA9EbOgHTz4CeL48i/1sPYRkiGQ8JMWM3vw9b00dAHiXX
 KclBhofq/HrF1LOAlmbjJUzmjHSEAHUy7ZADSOrI0ADLKVRUa9/bFB0/mg/PaAG96s0AXa4nnWo
 =
X-Gm-Gg: ASbGncvK45EIXtBAoPnV9eZ034g7UOzLbW4eEaNMwjUpzxkpUM6r01fR/XXwh7djqvD
 428OOSNGw4XKF55wt4EubgNFM1Tco6TFpW6E96tDobTpyaHIehdKF02WdMfv4nsvY8E9vY8M/8d
 FNSVlGT4M0bOwcvMh3pdcrMk9bbPUcUwlDittjX0MCcuc+Nm08PY8a19KjbK9Fq3KYrfDQgVuwn
 M913UWoQB5lKBTw3KcmJongu8/3UmPdXgq8+U9TnIyGoxU30VhYqwPVrlRyz5+IJzE9+oFJUrdr
 4ObMW/vYrMU=
X-Google-Smtp-Source: AGHT+IFUq2liH6RDEVKFsTu/lsSHLI6521ae9bXoFwnMbSg3iRqizUWS6nk5dAecT00uMqFooeKMlQ==
X-Received: by 2002:a05:6e02:19c6:b0:3a7:6e97:9877 with SMTP id
 e9e14a558f8ab-3a811e3e7b3mr18548085ab.24.1733452613328; 
 Thu, 05 Dec 2024 18:36:53 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:36:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v3 08/46] x86: Drop the unnecessary base_ptr argument to
 zboot_dump()
Date: Thu,  5 Dec 2024 19:35:47 -0700
Message-Id: <20241206023626.2456858-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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
index d74c404464c..4dfcde68060 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -555,12 +555,13 @@ static void show_loader(struct setup_header *hdr)
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
index b3b78bebaed..a89c3bfd9c5 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -386,7 +386,8 @@ static int do_bootflow_info(struct cmd_tbl *cmdtp, int flag, int argc,
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
2.34.1

