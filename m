Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE254EE49A4
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 19:13:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5F3A86CE3;
	Sun, 10 Sep 2023 21:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LnjQU/LE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A9BC86CE3; Sun, 10 Sep 2023 21:13:16 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8214F86C23
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 21:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-34e26daab46so12120415ab.0
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 12:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694373192; x=1694977992; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z4Rjji2C4D8JMDhNc7bsSn/tc9ddbwQ0hNsFkAKz3cU=;
 b=LnjQU/LEflbNurRuLFqOA8AcM1mTCNFmBMnT2GxVnBGJru0nW+3NfLP/ruYL07K1L0
 mN4TfPqtbU8xACF4pDw17PVFzBPKYGu/IRWk5ZjJ0FA+up+OfH9oMoNmjRW+yq5Qs7yJ
 nvXStl/fN/liSEzkkG2hud6dh+jPAQzgxUxNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694373192; x=1694977992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z4Rjji2C4D8JMDhNc7bsSn/tc9ddbwQ0hNsFkAKz3cU=;
 b=G9UBigi5BQJfuecuvPRS6QkeF+v02OdE/q0e1BRaAK0gxyFC+f9YXLaDOwb2zmKCi1
 G7+i/oz9HdA0gUIe/Sa2kBX9VGb0GlyeEja9ohFdiVtEnQToRlABsAbJJGf1cKHJVi93
 PTpdVNJakltqQlOoxV5j5Qn2GTUjkMYQ68sGnN8meX9YqH9xK2QpvzxCuMMZeANe1Ppd
 +NlU5Lsu11iM5x+waYXCKUeW5zhEAdy4g2giL2StqkHRwr5vjFKaqLGfOhHLAkxXHYNd
 v2lETUg1YfT6Z3FQ4ocsX+APH8n00zK9+wnmjRgnZgLKywZrVwqUVR0Qw/xxt7zeip+H
 L64w==
X-Gm-Message-State: AOJu0YxPn6BgekX32K5HQoGmJ3WKHd3Ojg2/W8rlOde7XyApv9XMlQz6
 UQPMFMLrkpOtJbqPLp7jVYH/92VgSM7nyO7U9GE=
X-Google-Smtp-Source: AGHT+IFQQbpnFG6ar15S3T8jml2aODhZzV6ENK0v6jTJw4OIwtGJjhfUoTmMPUoidqrjej6VJCuoNg==
X-Received: by 2002:a05:6e02:1be3:b0:34f:1f1f:f3ca with SMTP id
 y3-20020a056e021be300b0034f1f1ff3camr10328635ilv.23.1694373192127; 
 Sun, 10 Sep 2023 12:13:12 -0700 (PDT)
Received: from sjg1.lan (c-73-243-118-188.hsd1.co.comcast.net.
 [73.243.118.188]) by smtp.gmail.com with ESMTPSA id
 u6-20020a92d1c6000000b00345b34fcf34sm1875473ilg.38.2023.09.10.12.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 12:13:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alex Sadovsky <nable.maininbox@googlemail.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 Jean-Marie Lemetayer <j.lemetayer@kerlink.fr>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: [PATCH v4 2/2] x86: Update cbmem driver
Date: Sun, 10 Sep 2023 13:13:02 -0600
Message-ID: <20230910191304.191580-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230910191304.191580-1-sjg@chromium.org>
References: <20230910191304.191580-1-sjg@chromium.org>
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

Changes in v4:
- Add some comments to help understand the overflow mechanism

Changes in v2:
- Update to support the new overflow mechanism

 drivers/misc/Kconfig         |  8 +++++++
 drivers/misc/cbmem_console.c | 43 ++++++++++++++++++++++--------------
 2 files changed, 34 insertions(+), 17 deletions(-)

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
index 8bbe33d414da..3cbe9fb1a46a 100644
--- a/drivers/misc/cbmem_console.c
+++ b/drivers/misc/cbmem_console.c
@@ -5,27 +5,37 @@
 
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
+
+	/* preserve the overflow flag if present */
+	flags = cons->cursor & ~CBMC_CURSOR_MASK;
+
+	cons->body[pos++] = data;
+
+	/*
+	 * Deal with overflow - the flag may be cleared by another program which
+	 * reads the buffer out, e.g. Linux
+	 */
+	if (pos >= cons->size) {
+		pos = 0;
+		flags |= CBMC_OVERFLOW;
+	}
 
-	cursor = cbmem_console_p->buffer_cursor++;
-	if (cursor < cbmem_console_p->buffer_size)
-		cbmem_console_p->buffer_body[cursor] = data;
+	cons->cursor = flags | pos;
 }
 
 void cbmemc_puts(struct stdio_dev *dev, const char *str)
@@ -40,7 +50,6 @@ int cbmemc_init(void)
 {
 	int rc;
 	struct stdio_dev cons_dev;
-	cbmem_console_p = lib_sysinfo.cbmem_cons;
 
 	memset(&cons_dev, 0, sizeof(cons_dev));
 
-- 
2.42.0.283.g2d96d420d3-goog

