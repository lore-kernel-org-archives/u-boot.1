Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0C6C369CA
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EF6A83348;
	Fri, 18 Apr 2025 16:11:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SIlE5Qgs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCD268327A; Fri, 18 Apr 2025 16:11:49 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0249A83290
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 16:11:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39c31e4c3e5so1296075f8f.0
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 07:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744985505; x=1745590305; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oV06jOcGhgL3zQiSdJCinxggWnUr0Aa60E9KHFCFYe8=;
 b=SIlE5Qgs3ximLOVY/U1d1xZMFOQOIYgqYKDPwtiDr/5iYt4n9p3Le+mxGhugtlckKN
 pe2sl17JG0XgHKyowe0OYvXVwWd7MsBigkyCzV5jcHWAT9u5Qo+cENk1UszHCnXs31Vq
 WRLDVgdWBFqGduVA/pc+50cicEDbFUQp4I3ol1Cko+/5gF4U4zps1V5MCiUIF3jfGpBv
 SLm8PxpsaKjqurI02fXQCRv1Q80HWOHZJZ/KmlsVcErmXTVmRZqU/jO8DadmlDV/gu8q
 WV7u2TtY4WIltewnDZP/n0HHruICGKjuQNYPevLzJ99UvSbIddwyZTpR1OI8+oOq7OJM
 fVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744985505; x=1745590305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oV06jOcGhgL3zQiSdJCinxggWnUr0Aa60E9KHFCFYe8=;
 b=ehU5NxToiad1OtV2BGUVdIzbuckyxIGkGVoP7CYSodLNl6b5GVdZcXiv/TnNeY0nuQ
 EgwGEeRJp41FmPeF3Bn+ABW5CkRBUuJdhn44YUC9qO1jH6qYbuETS8iub3GpsqsObLxu
 wQiHQ84jqhOerUFiPXAAxyk1eBzDvoEhYXQe/g5k4EmdOeNwThovn+kKoMRNpV6u0jlw
 O/W+yd4B5o5XnNj8NNYMS2y9kQxz2U0fwiqMGd4Oapidce+mP/BJpdC04k9gEG5zZcgr
 ebS2lKYSYILEjtd/awWvJwObIAGBbv01s1fbMasVLNYKyV0TYTBVE+nu/fUtIpoAmNnl
 /BpQ==
X-Gm-Message-State: AOJu0YzRaGYqnp6Ko1MuGpYoxM/sGIFzdlfnVctKHvS19tDAlF1DRbsG
 pqlYOC3yk/qiWfwNNenE5aKkT3FDT47uQC6DpzfxjYV/6nfb7WZLortro8q1K1kVLIPN6M45+Uc
 kLMO0+Q==
X-Gm-Gg: ASbGncvk+H14m72uagxtRWIWy1l8i55sGov32nCqDMyfo0JxWXGzLdeWjCPBQ//gv1Q
 Y/PDe9TXO3uTNEZGx6V41WzgwILSTXc2imfqk6gMGQVznT7bVe0LfrmlOYvijqCOBSWyx873BPD
 xWmz1z6PfvxmeHGRPQ3l+5sl7jYsn/C88tStyBsIZDTLRvyZcrMO8lt8TKVk3yOF5cGkeVPujgM
 i55rH3ijFdtlOAgE0CPlfSaTOpXp+ZeYY1YFuIP56GRMwUNJVCP6XEE+sRbWtTqhrt2bcLCdGwe
 PvR2UarlAeXy5TvtLQ7FWlvbpP4hnX5bUFQby+KL8Uc3eXNZng==
X-Google-Smtp-Source: AGHT+IFMYj2KFBl4MESlkMsUnqIbH7g6m3tCrxiHq0Wk180IMXSwJUgStrHmMutJuGkBcEZ6dJ9mJA==
X-Received: by 2002:a05:6000:2281:b0:39c:1257:c7a3 with SMTP id
 ffacd0b85a97d-39efbb23ac3mr2319711f8f.59.1744985505265; 
 Fri, 18 Apr 2025 07:11:45 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1526:5ffd:d63c:cc85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbcc3sm23734385e9.19.2025.04.18.07.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 07:11:44 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 15/17] test: cmd: add test for spawn and wait commands
Date: Fri, 18 Apr 2025 16:09:43 +0200
Message-ID: <20250418141114.2056981-16-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418141114.2056981-1-jerome.forissier@linaro.org>
References: <20250418141114.2056981-1-jerome.forissier@linaro.org>
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

Test the spawn and wait commands.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 test/cmd/Makefile |  1 +
 test/cmd/spawn.c  | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 test/cmd/spawn.c

diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 8596c5ad753..595e4cfcada 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -39,3 +39,4 @@ obj-$(CONFIG_CMD_WGET) += wget.o
 endif
 obj-$(CONFIG_ARM_FFA_TRANSPORT) += armffa.o
 endif
+obj-$(CONFIG_CMD_SPAWN) += spawn.o
diff --git a/test/cmd/spawn.c b/test/cmd/spawn.c
new file mode 100644
index 00000000000..8f48f5ee25c
--- /dev/null
+++ b/test/cmd/spawn.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Tests for spawn and wait commands
+ *
+ * Copyright 2025, Linaro Ltd.
+ */
+
+#include <command.h>
+#include <test/cmd.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+static int test_cmd_spawn(struct unit_test_state *uts)
+{
+	ut_assertok(run_command("wait; spawn sleep 2; setenv j ${job_id}; "
+				"spawn setenv spawned true; "
+				"setenv jj ${job_id}; wait; "
+				"echo ${j} ${jj} ${spawned}", 0));
+	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
+	ut_asserteq_ptr(uts->actual_str,
+			strstr(uts->actual_str, "1 2 true"));
+
+	ut_assertok(run_command("spawn true; wait; setenv t $?; spawn false; "
+				"wait; setenv f $?; wait; echo $t $f $?", 0));
+	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
+	ut_asserteq_ptr(uts->actual_str,
+			strstr(uts->actual_str, "0 1 0"));
+	ut_assert_console_end();
+
+	return 0;
+}
+CMD_TEST(test_cmd_spawn, UTF_CONSOLE);
-- 
2.43.0

