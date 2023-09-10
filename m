Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34374EE49A4
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 19:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96D4686C5D;
	Sun, 10 Sep 2023 21:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f+mj8rmZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D57DA86CEC; Sun, 10 Sep 2023 21:13:13 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0196386C85
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 21:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34e12396f6fso14153345ab.1
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 12:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694373189; x=1694977989; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Gb6GV36RFFWEy9tqJFmS0Mge0kT1+HJEwy/960ETMGs=;
 b=f+mj8rmZcuJMbdjjEsDJ1X7uHX5O7NnYRKtBVu/tL2aXrMI4pB1SIbyxcG+DezEEDs
 PVlRfH8gyXXl2Dwjw6q5Ctu7vnJjSjHA3GutlAnPSb/0NS0eIGA2MtE6oeLpOtZPlnhf
 SiAxDlYmdzLtNZlAubWXcby55O8xZWIpDpSeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694373189; x=1694977989;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gb6GV36RFFWEy9tqJFmS0Mge0kT1+HJEwy/960ETMGs=;
 b=cUDfB15EYnMxl2TTgbO4cznQkWh27/L3gyW9mjr90g+ZURErNJpbKE7zUIfpRuHwhI
 Nh+JxVX7GW2llRznukhNt1TcUNo1gVGJqlGg+iGZF+dFFy/a/JCHyggA/YtnR7OC1+jN
 EpXB7tIXZpuAJ5pYLDh+Nob9TFIU377obLMFfxMgeAvI7aDZTrYXB4dzFtZN4cYtuhMe
 JRFqzyLrlAjk3pVlTYElIWjhWFPkZMAwuhfmZW6lUjlt4nu8C/GQS4vMgshnbHKTp5In
 AGKqwuasi3mwyjvp6AnNz0QltjiVkFLeUWTqyEX77slqg/ws/ZzjloVyPZjt3PEqS8Tt
 WDYQ==
X-Gm-Message-State: AOJu0YxsJqIv6riDPriF8+Y0iGsUujpYMTwK246HgRLDShejv9b6Z2hl
 T5Bjs+XAiBRB+FBVbGS8z+rZdwnIvLoPWVpl1Gk=
X-Google-Smtp-Source: AGHT+IHQ+iwAL4UHDr5TmswlrvjaSStsrpp2wdbu+J5hdO0xqoxuGSPxxqIKF7jWMUMcN6SLxOmMYA==
X-Received: by 2002:a05:6e02:1290:b0:349:5e6:4953 with SMTP id
 y16-20020a056e02129000b0034905e64953mr8305166ilq.7.1694373189489; 
 Sun, 10 Sep 2023 12:13:09 -0700 (PDT)
Received: from sjg1.lan (c-73-243-118-188.hsd1.co.comcast.net.
 [73.243.118.188]) by smtp.gmail.com with ESMTPSA id
 u6-20020a92d1c6000000b00345b34fcf34sm1875473ilg.38.2023.09.10.12.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 12:13:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alex Sadovsky <nable.maininbox@googlemail.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v4 1/2] x86: coreboot: Document cbmem console struct
Date: Sun, 10 Sep 2023 13:13:01 -0600
Message-ID: <20230910191304.191580-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
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

Coreboot changed a few years ago to include an overflow flag. Update the
structure to match this.

This comes from coreboot commit:

   6f5ead14b4 ("mb/google/nissa/var/joxer: Update eMMC DLL settings")

Note: There are several implementations of this in coreboot. I have chosen
to follow the one in src/lib/cbmem_console.c

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Reword commit and change title

Changes in v3:
- Drop __packed as it does nothing useful

 arch/x86/include/asm/coreboot_tables.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/coreboot_tables.h b/arch/x86/include/asm/coreboot_tables.h
index 4de137fbab9d..0dfb64babb96 100644
--- a/arch/x86/include/asm/coreboot_tables.h
+++ b/arch/x86/include/asm/coreboot_tables.h
@@ -299,11 +299,24 @@ struct cb_vdat {
 #define CB_TAG_TIMESTAMPS		0x0016
 #define CB_TAG_CBMEM_CONSOLE		0x0017
 
+#define CBMC_CURSOR_MASK	((1 << 28) - 1)
+#define CBMC_OVERFLOW		BIT(31)
+
+/*
+ * struct cbmem_console - In-memory console buffer for coreboot
+ *
+ * Structure describing console buffer. It is overlaid on a flat memory area,
+ * with body covering the extent of the memory. Once the buffer is full,
+ * output will wrap back around to the start of the buffer. The high bit of the
+ * cursor field gets set to indicate that this happened. If the underlying
+ * storage allows this, the buffer will persist across multiple boots and append
+ * to the previous log.
+ */
 struct cbmem_console {
 	u32 size;
 	u32 cursor;
-	char body[0];
-} __packed;
+	u8  body[0];
+};
 
 #define CB_TAG_MRC_CACHE		0x0018
 
-- 
2.42.0.283.g2d96d420d3-goog

