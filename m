Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E366AF513ED
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 02:37:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02D63836D3;
	Fri,  6 Mar 2026 03:37:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I53tKIB+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C695E83F9D; Fri,  6 Mar 2026 03:37:11 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5509F83F2E
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 03:37:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-899fa9610bbso81888346d6.0
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 18:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772764628; x=1773369428; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+3vhtq7nm0SYDak4q7umxFHjs0yEt1ngkRA8hiQBkXo=;
 b=I53tKIB+4WEqEyXqdNlNSG9IglG6xAYPK/LYLv/QpfzsfFnEqUZ8zZYOURrV+pTN/F
 0KnRjjoR+lT6Tgj6qlXoSVcQCVsXuhBQ4PusCp87ePP4QuZSGosLS2E9yBwZI9pNKEzZ
 oNprP6/HVdhcZoM3VAkDDnI7FP4DoMj7qFVIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772764628; x=1773369428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+3vhtq7nm0SYDak4q7umxFHjs0yEt1ngkRA8hiQBkXo=;
 b=gqEhGen+3CFfWj3DHeW0lxc5HZ4nNASAuU4Xn+zxu9pUMWyNm6Gu6Cr0Sc653ak7Qe
 z2zaSRhXWAz/PTfM1RjjWgqX4pOKz/4iP28MQh7mFZxTzAsMRtgXt1ggDCOu09poNpvC
 jYe9o/8CR/r21pgr4ErNnKb5EW0a7MMBiwgxSzN3estIZRpXQl50i0y8une4IdVScvfw
 eVA+6rJHqSjmry+4J0DP7BGi2PtgvJ+57V+9BHknI+Rnbhzo1bwk+aXRVA+24wKVsTIb
 FH1/JWoKuaswR7a/M/FERHwSIEHph5J7/Y6cFV0cTjrUjTrSbMiNlKxBRUlqnesYJyPt
 bzfw==
X-Gm-Message-State: AOJu0YzhqwQpxL/3p6WoP3h/kWesxNKOuNMexq0ujLQiog7G1v/AZL1n
 NQYTAIMUVK4qKswkXppOCUl5hWSVC5TqeRYhgdpj6pNt7c3LaUKNZLH+UXfTFVJSgBuM6e6eeHH
 CGNA=
X-Gm-Gg: ATEYQzyjDCakNG9UiMj7gx/cqCs2/Nk22tEssnQTxdSgGzV3eTIpQr370zS7/VX7GEI
 pnioe2jrWIlf0+zI8FbbaSgBA7P7pPJaHIhD0lPR7tQYx33ec37MyUFyW/BuqFticXXk/XsIr2i
 bG/3fyev8W526pYDd2ev+EZB3iBcha3dqkfRMi4pVe3p4mfShpi+vE6L/07VsZ3hr3rHCOVlsyL
 txit+yoNkP9aU1Dh8d9zrNMq/k/0Ug9qH63he3IO1dFBovah8y4rbYfxkeVfMekSaQUooQU9N3F
 RQHxwp7q5xEpujdGeqnNlYyZj9L4zNUIfnocF7bu/XvTdwTdUowMXfIlhpKo5fFQpu8QStymvYT
 PlKviDC3dNB6hOInkj+24xzIrr6ScmM9Q793dgprzRaCNfIDp1KwBcxjPxo9Y5kALFAQ4lGj8BI
 Y631QH+tM2RlxR4ROHHQ==
X-Received: by 2002:a05:6214:f07:b0:89a:b94:3cbb with SMTP id
 6a1803df08f44-89a30a368c7mr6723336d6.22.1772764627566; 
 Thu, 05 Mar 2026 18:37:07 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a316e8eb2sm1063436d6.35.2026.03.05.18.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 18:37:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Aristo Chen <jj251510319013@gmail.com>, Benjamin ROBIN <dev@benjarobin.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 =?UTF-8?q?=E7=89=9B=20=E5=BF=97=E5=AE=8F?= <Zone.Niuzh@hotmail.com>
Subject: [PATCH v4 04/17] bootm: Create bootm_final() for pre-boot cleanup
Date: Thu,  5 Mar 2026 19:36:13 -0700
Message-ID: <20260306023638.2678886-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306023638.2678886-1-sjg@chromium.org>
References: <20260306023638.2678886-1-sjg@chromium.org>
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

Changes in v4:
- Print '(fake run for tracing)' when flag is set
- Use BOOTM_STATE_OS_FAKE_GO instead of new enum bootm_final_t

Changes in v3:
- Fix "the a" typo
- Introduce with all common functionality (not empty)
- Put in bootm.c instead of a separate file
- Squash in patches 2, 3 and 5 from v2

 boot/bootm.c    | 22 ++++++++++++++++++++++
 include/bootm.h | 10 ++++++++++
 2 files changed, 32 insertions(+)

diff --git a/boot/bootm.c b/boot/bootm.c
index 4bdca22ea8c..cba10b5dce7 100644
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
@@ -1194,6 +1195,27 @@ void __weak switch_to_non_secure_mode(void)
 {
 }
 
+void bootm_final(int flag)
+{
+	printf("\nStarting kernel ...%s\n\n",
+	       (flag & BOOTM_STATE_OS_FAKE_GO) ?
+	       " (fake run for tracing)" : "");
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
index 4060cec7fc0..f6958be751a 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -321,4 +321,14 @@ void zimage_dump(struct boot_params *base_ptr, bool show_cmdline);
  */
 int bootm_boot_start(ulong addr, const char *cmdline);
 
+/**
+ * bootm_final() - Announce and do cleanup before boot
+ *
+ * This performs the common pre-boot steps: printing the "Starting kernel"
+ * message, recording bootstage data, and removing active devices.
+ *
+ * @flag: Boot state flags (BOOTM_STATE_OS_FAKE_GO prints a fake-run message)
+ */
+void bootm_final(int flag);
+
 #endif
-- 
2.43.0

