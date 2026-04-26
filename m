Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D93FF885D
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 15:37:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A39784150;
	Sun, 26 Apr 2026 17:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IBkC0bSV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 838CB84178; Sun, 26 Apr 2026 17:36:32 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4897E8419E
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 17:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so60070245e9.0
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 08:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777217788; x=1777822588;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V3edTpCbQLoF2GLZoQuCSJDpFP7hzTahHYvj6ql2yGM=;
 b=IBkC0bSVVCut9ZosFgmuvu7Y0Vvu2s7toNSUXp3PWaXo+H6uGH8V/cAhC7yVuytcMN
 zjLfZ40yUQdqvCZy/GXSadZi81Nc+EZ+4rCl5nChxw8kbXcQhR43KuUNS3tM8ldkmeMe
 vbCmW1xCf4rzvEpo7iTfg8Q3wh4xw3Bzh8ZdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777217788; x=1777822588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V3edTpCbQLoF2GLZoQuCSJDpFP7hzTahHYvj6ql2yGM=;
 b=qjeN8WEGSc102OuOtkqCE7kuHZEEUv6I0cTsgEbQf+mfbTl5rqo3fqiadwwgGLrnjy
 xsfVgWysa55dw++eBSGcilDhyqPLSQRGCmrI/x3QZI8hJ+jD/aaU+JjKpXiyI/r+jUwa
 DfRSa1lB1DNCuSDMqACBxLejT6gzmlj5OJqJnGjk84CjYttp+7Bz52DCbup7ZODWlOAa
 MJ2BzoGdSfXfBa2idQPxg4uDnIL6EUdZoN/f1WzKpb+wORkjux8/7g6BjSiQdrQ8Qok8
 TzsZdlP00Zu0lke5Sncd6iVKl7ZDvSXZf5KY0RlTZjNBQS8g+E4OivHFbtmSfe2AyJwJ
 LJzQ==
X-Gm-Message-State: AOJu0Yx/6ziG4IS7XZCU5oG4VFIcanRyFd1shltqL4oiecDDqgFPm2KO
 fVICnApu/cntI4+nmxE9AbzggImKqEx1CE+36M4ewZaRnF0pM0dBlvvsIfLkyznhTv31DrM1z2S
 gC1MB
X-Gm-Gg: AeBDievAbvSvn0vLhvaul2iAX8hQBY6dh0NdIUi+QS7Jz44Z8N0moQ4KJpbQ9PK/Aj5
 Ohpv98n+eXsaPumLpfLNR8mulyZ0tMiTqUqhgSBy/au8lYiqIApbvawmJI9TosA0FPobTFAqpff
 2lwb9CkFX2o7gNEuKnXRSLlFb15aiDzYqCHiHgnhV/UZkWf29ge8G+fHTWJ6NmdGAqsVFOKKnSk
 ghthYe8pNvXjaBijRgapUCq3y40tKT67qiLSknNEc1bFUYiPOUA0jWL/kt/LHpD5ros99dVjeLn
 0FDxDdxcPT10eB1Kb8sBnD7Mm750gSKxJfK5L4w4OWQM16vIPRTWZEnukPfBiyrfgLJRmv9OdOT
 RT443UyIyaONIWeLzAM2WYk0Yk5rrUphdqR0BvAJt78PikL0TiMoIS5p45vAfyBnRZ1YRCKDLpg
 bpXAVf5lF9LkZFkizor0FYmDOZoFm64KaUJd9Fu2lPePs+jr3Ls++3wExzM7dJ4impO28+8IIcG
 Jx7RUMBmPP8Wsl3vPU39AXgvtCDCKTgZ+OFiqnO4hmakVP29Upc9MQ2dmGFQ22tij9is9wE3xVh
 GDuYLCjBv5i62tXqqcOFlsaWysZDAA==
X-Received: by 2002:a05:600c:888b:b0:488:c80c:c236 with SMTP id
 5b1f17b1804b1-488fb73d525mr476367145e9.5.1777217788500; 
 Sun, 26 Apr 2026 08:36:28 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5499b0edsm388438845e9.14.2026.04.26.08.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 08:36:28 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 5/8] test: cmd: part: add UUID lookup tests
Date: Sun, 26 Apr 2026 17:35:30 +0200
Message-ID: <20260426153617.2039651-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426153617.2039651-1-dario.binacchi@amarulasolutions.com>
References: <20260426153617.2039651-1-dario.binacchi@amarulasolutions.com>
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

Extend the 'part' command unit tests to include partition lookup via
UUID.

This ensures that the 'number', 'start', and 'size' subcommands
consistently handle UUIDs as partition identifiers, maintaining
parity with the name-based lookup functionality.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

(no changes since v3)

Changes in v3:
- Combine run_command() and ut_asserteq() -> ut_asserteq(1, run_command(
- Add Reviewed-by tag of Simon Glass

 test/cmd/part.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/test/cmd/part.c b/test/cmd/part.c
index 5751dd315dd8..0069fe5bfea7 100644
--- a/test/cmd/part.c
+++ b/test/cmd/part.c
@@ -80,6 +80,20 @@ static int cmd_test_part_number(struct unit_test_state *uts)
 				    mmc_dev_num));
 	ut_assertnull(env_get("partnum"));
 
+	for (i = 0; i < ARRAY_SIZE(gpt_parts); i++) {
+		env_set("partnum", NULL);
+		ut_assertok(run_commandf("part number mmc %u %s partnum",
+					 mmc_dev_num, gpt_parts[i].uuid));
+		snprintf(expected, sizeof(expected), "0x%x", i + 1);
+		ut_asserteq_str(expected, env_get("partnum"));
+	}
+
+	env_set("partnum", NULL);
+	ut_asserteq(1, run_commandf("part number mmc %u %s partnum",
+				    mmc_dev_num,
+				    "00000000-0000-0000-0000-000000000000"));
+	ut_assertnull(env_get("partnum"));
+
 	return 0;
 }
 CMD_TEST(cmd_test_part_number, UTF_CONSOLE);
@@ -120,6 +134,21 @@ static int cmd_test_part_start(struct unit_test_state *uts)
 				    mmc_dev_num));
 	ut_assertnull(env_get("partstart"));
 
+	for (i = 0; i < ARRAY_SIZE(gpt_parts); i++) {
+		env_set("partstart", NULL);
+		ut_assertok(run_commandf("part start mmc %u %s partstart",
+					 mmc_dev_num, gpt_parts[i].uuid));
+		snprintf(expected, sizeof(expected), "%lx",
+			 (unsigned long)gpt_parts[i].start);
+		ut_asserteq_str(expected, env_get("partstart"));
+	}
+
+	env_set("partstart", NULL);
+	ut_asserteq(1, run_commandf("part start mmc %u %s partstart",
+				    mmc_dev_num,
+				    "00000000-0000-0000-0000-000000000000"));
+	ut_assertnull(env_get("partstart"));
+
 	return 0;
 }
 CMD_TEST(cmd_test_part_start, UTF_CONSOLE);
@@ -160,6 +189,21 @@ static int cmd_test_part_size(struct unit_test_state *uts)
 				    mmc_dev_num));
 	ut_assertnull(env_get("partsize"));
 
+	for (i = 0; i < ARRAY_SIZE(gpt_parts); i++) {
+		env_set("partsize", NULL);
+		ut_assertok(run_commandf("part size mmc %u %s partsize",
+					 mmc_dev_num, gpt_parts[i].uuid));
+		snprintf(expected, sizeof(expected), "%lx",
+			 (unsigned long)gpt_parts[i].size);
+		ut_asserteq_str(expected, env_get("partsize"));
+	}
+
+	env_set("partsize", NULL);
+	ut_asserteq(1, run_commandf("part size mmc %u %s partsize",
+				    mmc_dev_num,
+				    "00000000-0000-0000-0000-000000000000"));
+	ut_assertnull(env_get("partsize"));
+
 	return 0;
 }
 CMD_TEST(cmd_test_part_size, UTF_CONSOLE);
-- 
2.43.0

