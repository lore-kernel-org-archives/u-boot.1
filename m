Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8404C4167B
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:55:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E41587B46;
	Thu, 14 Dec 2023 17:52:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CphpxSPo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C379D87B07; Thu, 14 Dec 2023 17:52:06 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2531C87B0C
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:52:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-35f49b80192so2134945ab.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702572721; x=1703177521; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pbs9enqBC8BWbW5GmhIFPrJNH6FcG637oTYbhc2eyOs=;
 b=CphpxSPoLPIyfIaSuCbuzs6i0iO5OeSF8OY+ExwEBg3xolt1k25qRs4bK1NnwwqSZF
 ludsfqSBV3IBCkISn2EQr/DuMg671g0bdEWlnYqJOsOkYiUtshCj5mT+p0T6wZn9f/Fo
 j2S3jCMqeb02zMRHQT2bJ/PTNsBl+q/maQH70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702572721; x=1703177521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pbs9enqBC8BWbW5GmhIFPrJNH6FcG637oTYbhc2eyOs=;
 b=hi/1LP18EzcYcEXg5rp1X8juw2B+ynzMlIQP3PSIe/dFbq6Qy8d8YLDIxeQMAifhRX
 Cqi5zBP4HiiiFQTBMISM6JA2r/XmFAjXQvTn0Yn7Qmp/asUtDuNSltR0aCzCNlSQJmAC
 cINWA/GJcUFFx2+9Qxv1gMOw6WIgPK3BeqDc1+OS0Jt0WKZeg5IIIvy5+G0/glLz6EOh
 C3T1AYCH3q1m1bSOKJsGY0uRcbf+WKl9srLUl+GpJq8wRvcc9VGR6oCli7elqnPTbLBO
 IdVKova+QpVNA/Oc7uQpgwm1mxFC3PnyTG19AqbOg3xLE0spbhVoECXOKxQDpUJnMSAs
 RjzQ==
X-Gm-Message-State: AOJu0YzvWSxJWOJrFtVBxm6LQ7NgJNs7j8IugNmKY2MQG9DiwvUirMcb
 W9Fe8z1UyDzZINcMS0JkkY9HZHaQKQLsih13LYcN8Q==
X-Google-Smtp-Source: AGHT+IEVZSwH7o/+bgfB8hdMRMN9drjvwjthoNR83BHGGtZWVidYk1cQEZq7KrgpPrA7J7JVKB9mtQ==
X-Received: by 2002:a05:6e02:1a06:b0:35c:d0b2:2c8 with SMTP id
 s6-20020a056e021a0600b0035cd0b202c8mr8309239ild.16.1702572721598; 
 Thu, 14 Dec 2023 08:52:01 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 bn14-20020a056e02338e00b00357ca1ed25esm1228347ilb.80.2023.12.14.08.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 08:52:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 21/21] bootm: Create a function to run through the booti
 states
Date: Thu, 14 Dec 2023 09:50:30 -0700
Message-ID: <20231214094939.v2.21.I95fe77f4a7f3d6c3dba3ecb3aec30a48739198f9@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214165112.2182274-1-sjg@chromium.org>
References: <20231214165112.2182274-1-sjg@chromium.org>
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

In a few places, the booti command is used to handle a boot. We want
these to be done without needing CONFIG_CMDLINE, so add a new
booti_run() function to handle this.

So far this is not used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Rework series to allow OS access to cmdline arguments for bootm

 boot/bootm.c    | 13 +++++++++++++
 include/bootm.h | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/boot/bootm.c b/boot/bootm.c
index 1c5a99817a82..248341c927d9 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1155,6 +1155,19 @@ int bootz_run(struct bootm_info *bmi)
 	return bootm_run_states(bmi, states);
 }
 
+int booti_run(struct bootm_info *bmi)
+{
+	int states;
+
+	bmi->cmd_name = "booti";
+	states = BOOTM_STATE_MEASURE | BOOTM_STATE_OS_PREP |
+		BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO;
+	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
+		states |= BOOTM_STATE_RAMDISK;
+
+	return bootm_run_states(bmi, states);
+}
+
 int bootm_boot_start(ulong addr, const char *cmdline)
 {
 	char addr_str[30];
diff --git a/include/bootm.h b/include/bootm.h
index 4665c7a24fa5..2245503eb0ea 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -176,6 +176,19 @@ int bootm_run(struct bootm_info *bmi);
  */
 int bootz_run(struct bootm_info *bmi);
 
+/**
+ * booti_run() - Run the entire booti process
+ *
+ * This runs through the booti process from start to finish, using the default
+ * set of states.
+ *
+ * This uses bootm_run_states().
+ *
+ * @bmi: bootm information
+ * Return: 0 if ok, something else on error
+ */
+int booti_run(struct bootm_info *bmi);
+
 void arch_preboot_os(void);
 
 /*
-- 
2.43.0.472.g3155946c3a-goog

