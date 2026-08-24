Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40255C5DF9D
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:44:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91FE440698;
	Mon, 24 Aug 2026 08:44:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UG_cDk_jv8S7; Mon, 24 Aug 2026 08:44:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787561073;
	bh=6GEGIQPkwdyT2naZHzXaQtQLpVz9F1JrUvdeK169cH8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mpy6oUiAragpx+gTpixyXM71nkOLc/EMEtQOi/wO2xvNSQyywHJzFYb7b5QEJhbck
	 Ez4wbLk4bs4CgBPShsKJqQYPuOw5ToKSM5HrjSFXaFISmtynwE+ESk8lyx35LDRC24
	 TTbkt46mAUsrJz1BBs9wTRxoWrRrcyOOVYgxLaedvlvucsAjiFvKMzE0r4mO7Sz4YI
	 QHHs9rLebFdZnn3nVA/uk4Ihbpvgl7KKrAXr71PuvmKGwh1zxrZZMFj9moBplBJa4Y
	 phkGvKcBte0C+f6UNFUE+fPHGgMLp3iMNkN8wmvzMnI5VaJxX2lmZPFpiTd5RwT/gL
	 y11Lrb/WipvKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 945BB4068E;
	Mon, 24 Aug 2026 08:44:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A059B230
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 86B8C80E01
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:44:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nt4oMFF_EkUg for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:44:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=kvL4k4b2
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7517580DFE
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:44:27 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so14541935e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 01:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787561066; x=1788165866;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6GEGIQPkwdyT2naZHzXaQtQLpVz9F1JrUvdeK169cH8=;
 b=kvL4k4b2HM1OfbN51Dqi/Om9qrjxBNGpSn3nafxvbfOXCkJTznoQBzCkhFqx419UDb
 mbFBIavIMDHECN8n5RCCxwZCL9/uJ+DTps5B/A67wVea1NtJrCls2X20RFsd9JCqprL4
 Pmn0aG0N6K8nCSBA9aAK0YfVq/wVbJUCIUuZQ5kiN2iUoijtgZrZ+KbTTC3gKUGTFLlD
 6p7vO5KCICj8u1m3xNURHpC26uqIY25R/i3seH7dHu5gq6euGYT7ZnG/6TAR/dO84eUd
 UifW4O9U2b+L4yUrY7L6g7Ik1qYuPdi7C8AZcVCmHzNjEpwetjUkKi1BWw1Wfu8DCmH8
 bQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561066; x=1788165866;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6GEGIQPkwdyT2naZHzXaQtQLpVz9F1JrUvdeK169cH8=;
 b=l4R1kie57ScSjGZhudC3B+tbk0fr0XrSfdc1WioalogJUYJffkbs7RU5SFUVPaxocK
 NbhlSG5jgOR/hMyb1uvjJuA1KWEj2+oGXhs+4GgoMkBRdXB0M8kl/Mu42QhC3cq2FT+/
 U3uOq2f26iferj98EGy+Cbca4t3QlC4XCqamsrX0g7EcmgDtPZOfaZI6zCCYp6QW57xl
 s8vJ7/8yqv3iHawrt19KcDdACQqEsHDe2rSOAJ8zLKukDM1BKtNY0oS83lhH9MCyRjQR
 qdjWn8bGN3SyqX3PpW4+7U8XkFklFOjTZMWqjVSTyy8xvfp0aDMkmPKNU1dwiZH8HL7Y
 wHUA==
X-Gm-Message-State: AFuF++kL3Zt9n3+VUlKaiogveo63MexkD6rsh57Aqllr68BedA62UFdg
 dkZ34VDzuvGAUQB6PW8UrxWFKpqNdo+4oTh9oSUSBpzQgvn4p/LXMyZ9onyywCO61Qg=
X-Gm-Gg: AR+sD13o+xUQ7MM+d6MOsrWpM6IVIKvxm+Q4C7DnIOC/vwRgVZgOcbxzDrmlm08zxWT
 XPaOZZdidWyUMgdrhpExqYQQhX41A8mA8Z5Zf9cG+chqgkWVdhI52brif09JKeOdYoD+cHcCedb
 LdGy70lKmYLQ99h2u/Wkq7ISh4aiqYx48dxojFCmqKxLu5rcYuFKByCgljGU+2Lu6rleCxl71+Y
 X6yVN+ljOJAk3hH2mz1Vkm35ImJ/Pv9OQLm0Ol0JSXJnMI3i1yPuHk/qKyJ3QiM/ADweoxiQ7VY
 E9R5SEdA4O9WhVduSYIavV+3saUX2mgkBHSb9FynAhWLPRRwxSoaubxf5nWJGpMmIX5y1sV3vJA
 zClQVRbyD1MFWj+N/KUqNiuNcTt8/GbNahy1qmNZbgYAKPzCe4liwuZ3fHxim39Ue9ugi3XnlZn
 kxCWGybt1+7FQwRe/dXN7e2P3SNH/JaUxrfWA6zP9U1zbMTi8jMqYj4ZdLK4ZQZIZV9w0T/5lZi
 N2sDqSl96p8rivsyDfIw1q0np7jQS1eW9uVgTqUDvq7alfbFMPA5pZJfKbxbjJqmr2tbTfDKFmr
 DtMWhYslbTSlePD7KB9WnDQTpd3eSMbwpDZgrCBn90wBPkplWsm5wUCz
X-Received: by 2002:a05:600c:4f54:b0:496:bbce:fc with SMTP id
 5b1f17b1804b1-499b8354a65mr236034575e9.12.1787561065788; 
 Mon, 24 Aug 2026 01:44:25 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499c35a1aeasm79788475e9.12.2026.08.24.01.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:44:25 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 24 Aug 2026 10:44:16 +0200
Subject: [PATCH v2 1/3] dm: add dm_err() and a driver model log verbosity
 choice
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-improve-logging-on-missing-uclass-v2-1-4bee2cdff72b@baylibre.com>
References: <20260824-improve-logging-on-missing-uclass-v2-0-4bee2cdff72b@baylibre.com>
In-Reply-To: <20260824-improve-logging-on-missing-uclass-v2-0-4bee2cdff72b@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, dlechner@baylibre.com
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

When a fatal driver model error occurs the board often cannot boot, yet
without any extra debug option enabled such errors are not shown: driver
model only had dm_warn(), emitted at WARNING level (or DEBUG when DM_WARN
was disabled). A fatal error deserves a message that is visible out of
the box.

Add a dm_err() helper, logging at ERROR level, and replace the DM_WARN /
SPL_DM_WARN boolean options with a per-stage verbosity choice:

  - DM_NONE: degrade all messages to DEBUG level (smallest size);
  - DM_ERR:  emit dm_err() at ERROR level only (default);
  - DM_WARN: emit both dm_warn() and dm_err().

Each level includes the ones below it, so selecting warnings never
silences errors. A disabled level is not removed entirely: it degrades to
DEBUG level, which is compiled out by default but can still be displayed
when debug logging is enabled (e.g. DEBUG defined or a high enough log
level). So even DM_NONE can still show these messages as debug output.
Production builds can drop the strings by selecting a lower level, while a
fatal error is shown by default during development, including in SPL/TPL.

Note this changes the default behaviour: driver model errors are now
emitted by default (previously nothing was shown unless DM_WARN was
enabled).

The existing DM_DEBUG option is deliberately left untouched here. It works
differently: it adds -DDEBUG to drivers/core/ via the Makefile rather than
selecting a log level, and it is not phase-aware. Unifying it into this
choice, along with converting the DM core debug() statements to
log()/dm_dbg() (as recommended in the "To Do" section of
doc/develop/logging.rst), could be done as a follow-up series.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/core/Kconfig | 75 +++++++++++++++++++++++++++++++++++++++++++---------
 include/dm/util.h    | 19 +++++++++++--
 2 files changed, 79 insertions(+), 15 deletions(-)

diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index ae0c3466772..5e276474b4b 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -45,28 +45,77 @@ config VPL_DM
 	  full malloc() enabled by CFG_TPL_SYS_MALLOC_START,
 	  consider using CONFIG_TPL_SYS_MALLOC_SIMPLE.
 
-config DM_WARN
-	bool "Enable warnings in driver model"
+choice
+	prompt "Driver model log verbosity"
 	depends on DM
+	default DM_ERR
+	help
+	  Select which driver model messages are compiled into the binary.
+	  Each level includes the levels below it. Lower verbosity saves code
+	  size by compiling the message strings out (useful for production
+	  builds), while higher verbosity helps with debugging.
+
+config DM_NONE
+	bool "No messages"
 	help
-	  Enable this to see warnings related to driver model.
+	  Compile out all driver model messages. This gives the smallest code
+	  size, but a fatal condition gives no hint about its root cause.
+
+config DM_ERR
+	bool "Errors"
+	help
+	  Emit driver model error messages via dm_err(), at ERROR level.
+	  These report fatal conditions that typically prevent the board from
+	  booting. Warnings are compiled out.
+
+config DM_WARN
+	bool "Warnings and errors"
+	help
+	  Emit driver model warnings via dm_warn() (WARNING level) in addition
+	  to errors. This is the most verbose and uses the most code space.
 
 	  Warnings may help with debugging, such as when expected devices do
-	  not bind correctly. If the option is disabled, dm_warn() is compiled
-	  out - it will do nothing when called.
+	  not bind correctly.
 
-config SPL_DM_WARN
-	bool "Enable warnings in driver model in SPL"
+endchoice
+
+choice
+	prompt "Driver model log verbosity in SPL"
 	depends on SPL_DM
+	default SPL_DM_ERR
 	help
-	  Enable this to see warnings related to driver model in SPL
+	  Select which driver model messages are compiled into the SPL binary.
+	  See the "Driver model log verbosity" choice for details.
 
-	  The dm_warn() function can use up quite a bit of space for its
-	  strings. By default this is disabled for SPL builds to save space.
+config SPL_DM_NONE
+	bool "No messages"
 
-	  Warnings may help with debugging, such as when expected devices do
-	  not bind correctly. If the option is disabled, dm_warn() is compiled
-	  out - it will do nothing when called.
+config SPL_DM_ERR
+	bool "Errors"
+
+config SPL_DM_WARN
+	bool "Warnings and errors"
+
+endchoice
+
+choice
+	prompt "Driver model log verbosity in TPL"
+	depends on TPL_DM
+	default TPL_DM_ERR
+	help
+	  Select which driver model messages are compiled into the TPL binary.
+	  See the "Driver model log verbosity" choice for details.
+
+config TPL_DM_NONE
+	bool "No messages"
+
+config TPL_DM_ERR
+	bool "Errors"
+
+config TPL_DM_WARN
+	bool "Warnings and errors"
+
+endchoice
 
 config DM_DEBUG
 	bool "Enable debug messages in driver model core"
diff --git a/include/dm/util.h b/include/dm/util.h
index ec518c51d93..89ffaa467aa 100644
--- a/include/dm/util.h
+++ b/include/dm/util.h
@@ -8,12 +8,27 @@
 
 struct dm_stats;
 
+/*
+ * Pick the log level for each helper based on the DM log verbosity choice.
+ * A disabled level falls back to LOGL_DEBUG, which is compiled out by
+ * default. Each level includes the ones below it, so DM_WARN also enables
+ * errors.
+ */
 #if CONFIG_IS_ENABLED(DM_WARN)
-#define dm_warn(fmt...) log(LOGC_DM, LOGL_WARNING, ##fmt)
+#define _DM_WARN_LEVEL	LOGL_WARNING
+#else
+#define _DM_WARN_LEVEL	LOGL_DEBUG
+#endif
+
+#if CONFIG_IS_ENABLED(DM_WARN) || CONFIG_IS_ENABLED(DM_ERR)
+#define _DM_ERR_LEVEL	LOGL_ERR
 #else
-#define dm_warn(fmt...) log(LOGC_DM, LOGL_DEBUG, ##fmt)
+#define _DM_ERR_LEVEL	LOGL_DEBUG
 #endif
 
+#define dm_warn(fmt...) log(LOGC_DM, _DM_WARN_LEVEL, ##fmt)
+#define dm_err(fmt...) log(LOGC_DM, _DM_ERR_LEVEL, ##fmt)
+
 struct list_head;
 
 /**

-- 
2.54.0

