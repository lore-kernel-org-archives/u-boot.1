Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF68CCD187
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 09:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1A08844A5;
	Thu,  9 Oct 2025 11:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q6NmGbiT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8297844B1; Thu,  9 Oct 2025 11:30:25 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DCDA844A5
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 11:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-42486ed0706so4483485ab.0
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 02:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760002222; x=1760607022; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fO/mD54I9g2fcIOF5xKZCsTqZMXgz+OIIS5kJzv6kX0=;
 b=Q6NmGbiTyr8Zpu45hQ/9zWz3Dquhy7PDCvg24i+hVfPjjfQoN1W7tzZsyiZFE7fPWr
 ffY93y9MArxsWpEuv3VR9lhEHoJUwlskmmCcGY/0w/FMt7XciwlafwUh22I3FjvX6ERZ
 8uTWlP7KOY0ot5vtq4yLEC1vc+HclQP6qzRXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760002222; x=1760607022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fO/mD54I9g2fcIOF5xKZCsTqZMXgz+OIIS5kJzv6kX0=;
 b=bLKMfhyhC6wUFuir6L6y4cPIiQKzRefPj6yduZtz9irOiF/i2kt4bNnHivjKCBnWp/
 +JUHdtTcJnpLqcRDgN0nD4+cMcivsrbEt3ucXEyqb69jtnFYAnD6hrS4sm5FsF9Gg9v7
 snsZOyUDvPtQdNaU6qOHd3lL98PiIC9oM1+gIHhwNGXF2xiJDa+7TL53O1ipWMtxDdhj
 xJaq6L+xybFPXL3iLFST7L2YADe2lAY3V/qmNIO3eG+77k0MV52JuKoKjvPujqkGSlBg
 xKLFZGlqj5OI9wDYn5IEDgxGBMH0TyX7Gl5w13lo7tAFXjJyTYJjGTO0l/2qjFRDVN7d
 H8dg==
X-Gm-Message-State: AOJu0YyM4XLCF3rvi3iBLiOytNAmv2pbx/YrNdLJQBV/MNiwq2pWgLca
 VFInlzHKM28xKuJdmQ8M9IhJqlUE85QH6QpKeDUO4DI7xXD5FjlCuNzQ80iADDeEjNGUpMmisN5
 7Z7l+nRHf
X-Gm-Gg: ASbGncunLB39J5feT9M8zdHCzoZHXu5959dv0RFhLJyGDjwC4wc3g0R7hktAHMO9KYc
 bkwupJ2WqUGSeq564NacOs/+v5YPNvrAH1xnpXifJhBa2jmGxTw3WXEPy2nJSIFvv1m7jcsGK17
 WeR0zzZjlyIzO+zbrQ+5JB1Jze9hNvfwCh4j0LZU5SVgqbWvTXHJFpnC6FqQUwJG6mSQtIpjkjj
 HYqZ3/6onTwLLRTEyOrmdjqrahSxvolwdVfE4SHounYgJKdXZhBMXFat19YajIeN7XRfMTc9ed5
 uO+nZxe1L+oI/NyZvJEVTpqNwNyIHSAD1G8NEEPvhC0HoxjVIdoBmGy02dT4BMdXtybovJuMsjK
 OiRdeBr2BSJCOVxWIHWpxvXUhufVcP3t9ehflSDOalAWYsiNC0Zc=
X-Google-Smtp-Source: AGHT+IFBYBsypi6ovjU0VLAnQZVxLyAcCh4w3Mql84p31Ianan/fdnjKCQfU/tYBP3N1Fxrgzw8mQw==
X-Received: by 2002:a05:6e02:1806:b0:424:fd76:2a2d with SMTP id
 e9e14a558f8ab-42f8740e314mr63346955ab.29.1760002221405; 
 Thu, 09 Oct 2025 02:30:21 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ea300f7sm7839341173.16.2025.10.09.02.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 02:30:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
Subject: [PATCH v4 2/4] boot: Move obtaining the label into a common file
Date: Thu,  9 Oct 2025 03:29:53 -0600
Message-ID: <20251009092959.260121-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009092959.260121-1-sjg@chromium.org>
References: <20251009092959.260121-1-sjg@chromium.org>
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

The 'bootflow list' command supports looking at the EFI device-path when
available. Move this piece into a common function so it can be used
elsewhere.

Use 'usb' instead of 'usb_mass_storage' for usb so that it fits in the
column space.

This updates the output from 'bootflow list'.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow.c      | 19 +++++++++++++++++++
 cmd/bootflow.c       |  8 +++++---
 include/bootflow.h   |  8 ++++++++
 test/boot/bootflow.c |  2 +-
 4 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 15df7069209..78df09f369d 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -11,6 +11,7 @@
 #include <bootmeth.h>
 #include <bootstd.h>
 #include <dm.h>
+#include <efi_device_path.h>
 #include <env_internal.h>
 #include <malloc.h>
 #include <serial.h>
@@ -1010,3 +1011,21 @@ int bootflow_get_seq(const struct bootflow *bflow)
 
 	return alist_calc_index(&std->bootflows, bflow);
 }
+
+const char *bootflow_guess_label(const struct bootflow *bflow)
+{
+	const char *name = NULL;
+
+	if (bflow->dev) {
+		struct udevice *media = dev_get_parent(bflow->dev);
+
+		if (device_get_uclass_id(media) == UCLASS_MASS_STORAGE)
+			name = "usb";
+		else
+			name = dev_get_uclass_name(media);
+	}
+	if (!name)
+		name = "(none)";
+
+	return name;
+}
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 551dffbb8b8..5b803d4ace5 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -70,10 +70,12 @@ static void report_bootflow_err(struct bootflow *bflow, int err)
  */
 static void show_bootflow(int index, struct bootflow *bflow, bool errors)
 {
+	const char *name = bootflow_guess_label(bflow);
+
 	printf("%3x  %-11s  %-6s  %-9.9s %4x  %-25.25s %s\n", index,
-	       bflow->method->name, bootflow_state_get_name(bflow->state),
-	       bflow->dev ? dev_get_uclass_name(dev_get_parent(bflow->dev)) :
-	       "(none)", bflow->part, bflow->name, bflow->fname ?: "");
+	       bflow->method ? bflow->method->name : "(none)",
+	       bootflow_state_get_name(bflow->state), name, bflow->part,
+	       bflow->name, bflow->fname ?: "");
 	if (errors)
 		report_bootflow_err(bflow, bflow->err);
 }
diff --git a/include/bootflow.h b/include/bootflow.h
index 2ef6eb25cf5..657e3731f11 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -692,4 +692,12 @@ int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
  */
 int bootflow_menu_poll(struct expo *exp, int *seqp);
 
+/**
+ * bootflow_guess_label() - Produce a plausible label for a bootflow
+ *
+ * This uses the uclass name or EFI device-path to come up with a useful label
+ * for display to the user. Ideally it will say "mmc", "usb", nvme", etc.
+ */
+const char *bootflow_guess_label(const struct bootflow *bflow);
+
 #endif
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 7cd83dc7443..73fe3d34d0f 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1301,7 +1301,7 @@ static int bootflow_efi(struct unit_test_state *uts)
 	ut_assert_nextlinen("---");
 	ut_assert_nextlinen("  0  extlinux");
 	ut_assert_nextlinen(
-		"  1  efi          ready   usb_mass_    1  usb_mass_storage.lun0.boo /EFI/BOOT/BOOTSBOX.EFI");
+		"  1  efi          ready   usb          1  usb_mass_storage.lun0.boo /EFI/BOOT/BOOTSBOX.EFI");
 	ut_assert_nextlinen("---");
 	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
 	ut_assert_console_end();
-- 
2.43.0

