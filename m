Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F4AC2FC04
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 01:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E6F386A7B;
	Thu, 17 Aug 2023 03:58:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bapMptQd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C89BE86A6B; Thu, 17 Aug 2023 03:58:08 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07B9B86A18
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 03:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3a82db15081so6446b6e.0
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 18:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692237484; x=1692842284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TipAsx+cK0KYZ5vCETNklQYS7616ixYO+ifarLLuRYg=;
 b=bapMptQd/6hsYy38sZNPpPTljVzTRLmYalWP1m1XAPxhdTeGdxFiWC4QzMfvax2qpw
 G9wD30wVJfLjsieMnETwxcQOGzI/CEpdhKaz7n/aWpzvXNdsju9uiLQjLet7jpWKvY8D
 kOSGATnlECkJYjNV8t9T1C2OkKuHLlo54utDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692237484; x=1692842284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TipAsx+cK0KYZ5vCETNklQYS7616ixYO+ifarLLuRYg=;
 b=DklP/hoQu5enf92LPsc3z0SqluCAwlsJePlFnyuapDt+d8DEkbdNoVh0wQLGs8Tp7a
 NPB2OdI/ndPwtuK5nc7wTTiSFcUjBmpsaRXIf9vroOJl/h6i6Ev/Sq6HZ+bH/hb+mmV3
 YCGVGBu9SSLaUeSZ3LQjDRcYm+/6ITCLo+GBZurLbsy2+Dknj5sPuViUudGXL3pLuh/y
 iVB3kMFSisgiv3sHl7XEXnZDm1oaUrToIEhn/TnPx/9wnYF3ZDFzpbRUr9OTUYOZSvHt
 kMQL9GNAZO1oCa3H6ohuw4TAUvhi7/6eEgGgMPQRmFo0M/PH9+yQdqMqjo1LKTfuCz1D
 nxpg==
X-Gm-Message-State: AOJu0YxFXojwqDd63W0xhlgld6837rPf7BDeyqLbTwUT3Ca2sXQSn0yk
 eTx6L1nk8hr7eOhj5+uHxO1U/91qb+Q+hJSeVDM=
X-Google-Smtp-Source: AGHT+IEwpfcmCAHRjt1+McMGtXqdXKvYmmjKT2oE+OuEeVyrwecKAJb6aNc3M+CqsU00ZTaUNrAsuA==
X-Received: by 2002:a05:6808:1288:b0:3a7:6385:28ac with SMTP id
 a8-20020a056808128800b003a7638528acmr5382348oiw.4.1692237484619; 
 Wed, 16 Aug 2023 18:58:04 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b12-20020aca674c000000b003a7b5193909sm7026471oiy.19.2023.08.16.18.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 18:58:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 Nable <nable.maininbox@googlemail.com>,
 Coreboot ML <coreboot@coreboot.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Jean-Marie Lemetayer <j.lemetayer@kerlink.fr>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: [PATCH v3 2/2] x86: Update cbmem driver
Date: Wed, 16 Aug 2023 19:57:52 -0600
Message-ID: <20230817015754.776507-2-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230817015754.776507-1-sjg@chromium.org>
References: <20230817015754.776507-1-sjg@chromium.org>
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

This driver is not actually built since a Kconfig was never created for
it.

Add a Kconfig (which is already implied by COREBOOT) and update the
implementation to avoid using unnecessary memory. Drop the #ifdef at the
top since we can rely on Kconfig to get that right.

To enable it (in addition to serial and video), use:

   setenv stdout serial,vidconsole,cbmem

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Update to support the new overflow mechanism

 drivers/misc/Kconfig         |  8 ++++++++
 drivers/misc/cbmem_console.c | 38 +++++++++++++++++++-----------------
 2 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index a6e3f62ecb09..c930e4a361bf 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -122,6 +122,14 @@ config VEXPRESS_CONFIG
 	  configuration bus on the Arm Versatile Express boards via
 	  a sysreg driver.
 
+config CBMEM_CONSOLE
+	bool "Write console output to coreboot cbmem"
+	depends on X86
+	help
+	  Enables console output to the cbmem console, which is a memory
+	  region set up by coreboot to hold a record of all console output.
+	  Enable this only if booting from coreboot.
+
 config CMD_CROS_EC
 	bool "Enable crosec command"
 	depends on CROS_EC
diff --git a/drivers/misc/cbmem_console.c b/drivers/misc/cbmem_console.c
index 8bbe33d414da..7a47a814f638 100644
--- a/drivers/misc/cbmem_console.c
+++ b/drivers/misc/cbmem_console.c
@@ -5,27 +5,30 @@
 
 #include <common.h>
 #include <console.h>
-#ifndef CONFIG_SYS_COREBOOT
-#error This driver requires coreboot
-#endif
-
 #include <asm/cb_sysinfo.h>
 
-struct cbmem_console {
-	u32 buffer_size;
-	u32 buffer_cursor;
-	u8  buffer_body[0];
-}  __attribute__ ((__packed__));
-
-static struct cbmem_console *cbmem_console_p;
-
 void cbmemc_putc(struct stdio_dev *dev, char data)
 {
-	int cursor;
-
-	cursor = cbmem_console_p->buffer_cursor++;
-	if (cursor < cbmem_console_p->buffer_size)
-		cbmem_console_p->buffer_body[cursor] = data;
+	const struct sysinfo_t *sysinfo = cb_get_sysinfo();
+	struct cbmem_console *cons;
+	uint pos, flags;
+
+	if (!sysinfo)
+		return;
+	cons = sysinfo->cbmem_cons;
+	if (!cons)
+		return;
+
+	pos = cons->cursor & CBMC_CURSOR_MASK;
+	flags = cons->cursor & ~CBMC_CURSOR_MASK;
+
+	cons->body[pos++] = data;
+	if (pos >= cons->size) {
+		pos = 0;
+		flags |= CBMC_OVERFLOW;
+	}
+
+	cons->cursor = flags | pos;
 }
 
 void cbmemc_puts(struct stdio_dev *dev, const char *str)
@@ -40,7 +43,6 @@ int cbmemc_init(void)
 {
 	int rc;
 	struct stdio_dev cons_dev;
-	cbmem_console_p = lib_sysinfo.cbmem_cons;
 
 	memset(&cons_dev, 0, sizeof(cons_dev));
 
-- 
2.41.0.694.ge786442a9b-goog

