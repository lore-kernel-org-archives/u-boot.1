Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36DBC4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 04:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF62487B9A;
	Fri, 15 Dec 2023 05:19:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NnTMGD3H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C63987B81; Fri, 15 Dec 2023 05:19:45 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D40CC87B0D
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 05:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3b9de2332e3so249500b6e.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 20:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702613980; x=1703218780; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JU+ufDRyzFLs9C3Dz5e5OXqcfVjewGL4njGvzPUkPHg=;
 b=NnTMGD3HR7WLBe6eSOmhrYKoPFXgReKDaCudCV+z6sa0wfxMJ0Db1C4+RTuGK5d7Oq
 TEpeSJuWY3st80uovGPUu2fsupZigmhEfK4skg8Uzg6qy56GGurYekrg5imLp3muxKav
 T5fjLubDKco3/v+1QBHUQaB4E9kDPzV2NWFEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702613980; x=1703218780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JU+ufDRyzFLs9C3Dz5e5OXqcfVjewGL4njGvzPUkPHg=;
 b=pK+bAvguAJXW8ydhiRyxOmW+cDzD40X9h9bmGOi1gFf6BuLQ5MAKORBWabXeXx1mx9
 IhoGg18mvJX4og+ZLZkANsftgusZ6/c64tYzpDEQ5voboo407uvLDPC1NT63VkTDAaDR
 lLLIcM1GzETWRpSuu9QD2TVJATptq9BkAmLFrN0QW4Jzna8KphEc/+ucr9+1bnadsAf9
 ptzcXLxbdhV8x3RFC8TRK308kHvzR787c2p48td13F8I0D2ggKteNJvbjRA2yidUj9HI
 s4DlTIemooq6EPsDAacQJTU3z85kmJGAwqNm7or1v1vOo7m8Q0yMWZKZEH+JtKCtTBe7
 FaWw==
X-Gm-Message-State: AOJu0Yy4ppR7AhpCql+qmFCl4fQbH3Zy0dUlsnt7oxXwJ/igZAWBuxRL
 OQluZlko54dKHAfvqO2Mu2VgblppR24RBMmD6sy2/g==
X-Google-Smtp-Source: AGHT+IHGBVZJ4agP3sfzWcxwGCBX+iRkt3COtLvjNZGB8x4Wd7Y1eTpQqV4Ejo9TW9r7LDwEeZeyPg==
X-Received: by 2002:a05:6808:38c4:b0:3ba:eb4:a5a6 with SMTP id
 el4-20020a05680838c400b003ba0eb4a5a6mr10170615oib.42.1702613980479; 
 Thu, 14 Dec 2023 20:19:40 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 be15-20020a056808218f00b003b898ffd8fcsm3601492oib.50.2023.12.14.20.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 20:19:40 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>
Subject: [PATCH v2 15/16] pxe: Allow booting without CMDLINE for the zboot
 method
Date: Thu, 14 Dec 2023 21:19:13 -0700
Message-ID: <20231215041919.2197788-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231215041919.2197788-1-sjg@chromium.org>
References: <20231215041919.2197788-1-sjg@chromium.org>
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

Use zboot_run() to boot rather than the command line. This allows
extlinux to be used (on x86) without CMDLINE being enabled.

Collect any error but do not return it, to match the existing code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/pxe_utils.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index c9da82b8e45f..5ceabfd04ee6 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -568,10 +568,8 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 			  char *initrd_addr_str, char *initrd_filesize)
 {
 	struct bootm_info bmi;
-	char *zboot_argv[] = { "zboot", NULL, "0", NULL, NULL };
 	const char *fdt_addr;
 	ulong kernel_addr_r;
-	int zboot_argc = 3;
 	void *buf;
 	int ret;
 
@@ -625,16 +623,10 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 	}
 
 	bmi.addr_fit = kernel_addr;
-	zboot_argv[1] = kernel_addr;
 
-	if (initrd_addr_str) {
+	if (initrd_addr_str)
 		bmi.conf_ramdisk = initrd_str;
 
-		zboot_argv[3] = initrd_addr_str;
-		zboot_argv[4] = initrd_filesize;
-		zboot_argc = 5;
-	}
-
 	if (!fdt_addr)
 		fdt_addr = env_get("fdt_addr");
 
@@ -657,8 +649,13 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 	else if (IS_ENABLED(CONFIG_BOOTM))
 		ret = bootz_run(&bmi);
 	/* Try booting an x86_64 Linux kernel image */
-	else if (IS_ENABLED(CONFIG_CMD_ZBOOT))
-		do_zboot_parent(ctx->cmdtp, 0, zboot_argc, zboot_argv, NULL);
+	else if (IS_ENABLED(CONFIG_ZBOOT))
+		ret = zboot_run(hextoul(kernel_addr, NULL), 0,
+				initrd_addr_str ?
+					hextoul(initrd_addr_str, NULL) : 0,
+				initrd_addr_str ?
+					hextoul(initrd_filesize, NULL) : 0,
+				0, NULL);
 
 	unmap_sysmem(buf);
 
-- 
2.43.0.472.g3155946c3a-goog

