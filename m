Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D610C3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 12:33:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39AD3820E1;
	Mon, 31 Mar 2025 14:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zTeAqi7K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE59C8203B; Mon, 31 Mar 2025 14:31:57 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C274781703
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 14:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so30592575e9.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 05:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743424315; x=1744029115; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oFltWPALYkQiMDNUmSg+en3vLnxEiJ0+n8F2dvwsl/U=;
 b=zTeAqi7Kpax7rmLx2gvAld06GqvAOI+Fjl2OS70DHYpSXVuXzlByFNTHqyhOKn4/vK
 Eg8eMkHmhxNGETe8wRNB397vJ7PsNJk6Ut5F8AKzpVtWOtW03O20U4Ot3fTQnYeGnk12
 +pjmSUwJOwPcWFzILzgEZs1LoaTIoMolh1UCd2hEJONJeTAoc7YQ4UmsJ/Z4YWv/MmGc
 V4kthj86lFUA7im57fgxK+2+ohPqjEKADvU5Wp7YOXkhAfoHFb637ylVU6pEHqyKQ6Rt
 PBJy6g3qyQM37U/314InvqMVGjfW8Wr2lJ3uBiGeqDAGfJ0HN2OjIUmtagZioVYaCrA7
 oQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743424315; x=1744029115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oFltWPALYkQiMDNUmSg+en3vLnxEiJ0+n8F2dvwsl/U=;
 b=ipKuQ5XoA5ZC9E5uKvDRh5WcGZNrcp/q/ortiXsQpMc1bKjvx2rkPV0xk9dQ88SmYr
 blCzkb5FIM/eWwuWkb+EMgOQWYnzkgmSL1ydwM0KdXP83zMhI4FGBqjTxyms48i67X0G
 zvM60KzS5i7aVrnF1/q2qWT0MN47VrdcUQOVmBfOPW+iQ0DmU1EHkQFCKzRU9vyC9Dxl
 H758cMRLWe/O4HxXgnZ7b83gvm/WYz4givkdLSBiCPUbY8ybHVKS2krC66nXKjDT5N3s
 eoIhAcOviSNXoivYQXpBZsm/0cX2IBW5Xl0ik4p3dccKpJofoOQdk8b/O0DNFeJZ1vEk
 EVAg==
X-Gm-Message-State: AOJu0YxiXREJti71VM+3U7LrrM0+uv1OVO3hR/fuNe7GUZ2mnUtK5X2k
 gXJMSytS9olqvufqW9YVlwLnr9U3T+rNuZMKBTWvCL4j/IzDpkWy/7vFcrShIXpTYtLGOBcqPi9
 eZCgZZw==
X-Gm-Gg: ASbGncvfxuqC8bHYMOUBo+uoIgeLtxe/vb5JVTMoSPoB8UJ8YDSfbKzoFhBQ3fLpZqP
 vprjgkwFhmgOi1+8EguPt5ggJ6PtqE2LZag/lvGC+KQ/kwO93oh1fBvkFlBlgPyyUU943mG1m9y
 6VNgy7SpQQJsqxEhmwaKkns7dYZRqnSd64v+Ty39O6jLte7aY6cF/w/SGpHTJKtNk+DEnkiDUdM
 oA9PRqUfRhujz6tKsSDQNrdcuctYKYu0Ci1acnagy1wizRlGsEUe3ohcdjcAM/k1XcH3G7GuG2M
 cXnpUa/At7QOQFGkuJtRBcdkigz12yGfOp6kOq0YTIsAZahUgJqb
X-Google-Smtp-Source: AGHT+IGu9SGW/sLXDEoIeVuDrCw6pJ/a2+QDNqfHTedqdfjIsAM+6KVb/BAjREJ0hMeSQKBc/EAVEg==
X-Received: by 2002:a05:600c:4e12:b0:43d:db5:7af8 with SMTP id
 5b1f17b1804b1-43db628c48bmr71536215e9.21.1743424315078; 
 Mon, 31 Mar 2025 05:31:55 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:f23c:25c9:dc74:be1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6589e4sm11337029f8f.10.2025.03.31.05.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:31:54 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v5 15/16] test: cmd: add test for spawn and wait commands
Date: Mon, 31 Mar 2025 14:31:09 +0200
Message-ID: <20250331123120.2025062-16-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331123120.2025062-1-jerome.forissier@linaro.org>
References: <20250331123120.2025062-1-jerome.forissier@linaro.org>
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
 test/cmd/Makefile |  1 +
 test/cmd/spawn.c  | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 test/cmd/spawn.c

diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index d8a5e77402d..cf47f04851c 100644
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

