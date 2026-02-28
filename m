Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3823FEE4EE
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 20:20:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 911BD83F0A;
	Sat, 28 Feb 2026 21:20:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GybkFdrg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77D0D83F37; Sat, 28 Feb 2026 21:20:32 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4979283EC6
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 21:20:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d4b9c839b1so1613919a34.1
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 12:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772310028; x=1772914828; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dWsfFQgq5g2FItA/5sK+NI88OZjU4LhbaNcHI/UgSsg=;
 b=GybkFdrgu3PEaQK4FfZeMffOb+U24uWjh6O4jDKz2lzRLdrerm4fUnb4PlMUtBKF0D
 SYikjI1QAPWhy9KkHjNOb4/7C6GbcXMiOh+4S/WQv3SY7mYgNbEf6zvgv7+NSUHLFW5R
 SbRXWmHFyRdmQ5pFjgIHKNyJkucaBVlKra3Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772310028; x=1772914828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dWsfFQgq5g2FItA/5sK+NI88OZjU4LhbaNcHI/UgSsg=;
 b=Ko1Y7cMlsqhq7auq+W/Bu+gyIS4PgFeyo/crgffan24W5tTjTBNKeRefc7zFnszA4f
 hmSbHP94haVsDQnlxcYJ44ckr+BDlo20rD+9zRQV6nb/iEwdXl+F1MVAbA0f9G1H9reX
 71GyDIg+zbA74CpLQ+XhjoJ3xK2wMatVIgtFvhEylpNBBDc0Z/oYk9IrX8MM1UL2Q37S
 u1db9iph1EJZFvZwL5Q7vK6+Amy4sCqlwha5ZhWDyPbBcxaoHf3KBT693BS27qS3w9+i
 yGf/7RUqaNws6fE5LolgmjGxOjmGx/34hvn467/YfFMrHdZeU8j5e6UTmnv99P791slx
 OWCA==
X-Gm-Message-State: AOJu0YxEhWTuvAacLrN4U3BCM/fAmar5h2jeK1yW6p2W8PrjNrAclSH7
 XUzqvGIlousVe0+rMKEo/ymx8r5YRg0Sciv9XrfxVizEYX+0gRmkzATG1Ga2bAd2caxLGWDXEGN
 erL0=
X-Gm-Gg: ATEYQzzYAJEWYt/lSyH5KYBpFoCDGdoSUyXs33rUHyCh7WrsRL2bSC/0hI3W7DZd5Eu
 /mF2KwqroDqHw47nFDE6RPGVAzH/7w9N5QBZah+1xGw+zAi+0G/0iiQ9yZEXTM84lhx4oW9JMkP
 R7ikzXOcv2j6ajsI2F35VQ/BuHHs/b/eMTn7bdy/QgFWjuorv5tHDKgMb+2F+oxZQWFjYUZG1dE
 ydHSsjlbrUsCEGYX3WV0MsSaiH/tmgPhHxDRgrBviwA9L3+lvMG9zmIU3aRUfXdRQVDzlL2f/sf
 IXD60joRxv+1aYTBhX4TT5k8ccub85c3XNEzmB0kLTN8RXmCr94+Glk3md6Y2YPnQfReXwoK13f
 2R3Kb4qhbdKgTidYd5e569U5Z6AkQEQ4abQx4yUPdmMQXYna0m0wTQDXV7kpeaNArsaMAo5r310
 +Wcy9i215/LMYrzs6YKw==
X-Received: by 2002:a05:6830:67fb:b0:7c7:da3:ed22 with SMTP id
 46e09a7af769-7d591c17e7emr6000007a34.32.1772310028507; 
 Sat, 28 Feb 2026 12:20:28 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58644edfbsm6978361a34.6.2026.02.28.12.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 12:20:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Aristo Chen <jj251510319013@gmail.com>, Benjamin ROBIN <dev@benjarobin.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 =?UTF-8?q?=E7=89=9B=20=E5=BF=97=E5=AE=8F?= <Zone.Niuzh@hotmail.com>
Subject: [PATCH v3 04/17] bootm: Create bootm_final() for pre-boot cleanup
Date: Sat, 28 Feb 2026 13:19:52 -0700
Message-ID: <20260228202011.1834493-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228202011.1834493-1-sjg@chromium.org>
References: <20260228202011.1834493-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

There are various functions which announce that booting is imminent and
do related preparation. Most of these are arch-specific.

In practice, most archs do a similar thing. It would be better to
have a common function, with perhaps some events for things that are
really arch- and board-specific.

Create a new bootm_final() function with the common pre-boot steps:
printing the "Starting kernel" message, recording bootstage data,
optionally writing bootstage to the FDT and printing a report, and
removing active devices.

Be careful to avoid using BIT() macros which are not available with host
tools.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

Changes in v3:
- Fix "the a" typo
- Introduce with all common functionality (not empty)
- Put in bootm.c instead of a separate file
- Squash in patches 2, 3 and 5 from v2

 boot/bootm.c    | 20 ++++++++++++++++++++
 include/bootm.h | 20 ++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/boot/bootm.c b/boot/bootm.c
index 4bdca22ea8c..3a69cc0deb0 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -7,6 +7,7 @@
 #ifndef USE_HOSTCC
 #include <bootm.h>
 #include <bootstage.h>
+#include <dm/root.h>
 #include <cli.h>
 #include <command.h>
 #include <cpu_func.h>
@@ -1194,6 +1195,25 @@ void __weak switch_to_non_secure_mode(void)
 {
 }
 
+void bootm_final(enum bootm_final_t flags)
+{
+	printf("\nStarting kernel ...\n\n");
+
+	bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel");
+
+	if (IS_ENABLED(CONFIG_BOOTSTAGE_FDT) && IS_ENABLED(CONFIG_CMD_FDT))
+		bootstage_fdt_add_report();
+	if (IS_ENABLED(CONFIG_BOOTSTAGE_REPORT))
+		bootstage_report();
+
+	/*
+	 * Call remove function of all devices with a removal flag set.
+	 * This may be useful for last-stage operations, like cancelling
+	 * of DMA operation or releasing device internal buffers.
+	 */
+	dm_remove_devices_active();
+}
+
 #else /* USE_HOSTCC */
 
 #if defined(CONFIG_FIT_SIGNATURE)
diff --git a/include/bootm.h b/include/bootm.h
index 4060cec7fc0..8890c37893f 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -16,6 +16,16 @@ struct cmd_tbl;
 #define BOOTM_ERR_OVERLAP		(-2)
 #define BOOTM_ERR_UNIMPLEMENTED	(-3)
 
+/**
+ * enum bootm_final_t - flags to control bootm_final()
+ *
+ * @BOOTM_FINAL_FAKE: true to do everything except actually boot; it then
+ *	returns to the caller
+ */
+enum bootm_final_t {
+	BOOTM_FINAL_FAKE	= 1 << 0,
+};
+
 /**
  * struct bootm_info() - information used when processing images to boot
  *
@@ -321,4 +331,14 @@ void zimage_dump(struct boot_params *base_ptr, bool show_cmdline);
  */
 int bootm_boot_start(ulong addr, const char *cmdline);
 
+/**
+ * bootm_final() - Announce and do cleanup before boot
+ *
+ * This performs the common pre-boot steps: printing the "Starting kernel"
+ * message, recording bootstage data, and removing active devices.
+ *
+ * @flags: Flags to control what this function does
+ */
+void bootm_final(enum bootm_final_t flags);
+
 #endif
-- 
2.43.0

