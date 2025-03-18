Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABD6C28B28
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 10:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B058381DF6;
	Tue, 18 Mar 2025 11:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cB0sX2l0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16C0A81CAF; Tue, 18 Mar 2025 11:47:38 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 136CE81D42
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 11:47:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso21748785e9.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 03:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742294855; x=1742899655; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oFltWPALYkQiMDNUmSg+en3vLnxEiJ0+n8F2dvwsl/U=;
 b=cB0sX2l0ahGWOIdKHbXSf+mahpHwC3JaN3OnW89eVaEXwQYzM1WCumiou2/EFQXNN/
 TCBYJW6EB/jKK3QNVW2Nb2ik98X3rzkdCviht4hMSLh/dO3RVwJYNbPA1oqNrOpOxP36
 dIi2x/baVnjonDdOG0mJSeT0MyrrNAyFnkhUht25bdPDQewuAeNBPEThVHdwaxqJhnmM
 LpcZv0WISGWDa323vNfwFlfdGHa9U78NFNQH1U4rxwnfRtjiBS1+DTPGhLChdIxzoYEz
 KUl0VWPvp0nbyQUPff/AYJMU3eZx19T5SQaU5ScbS+2ELZ2wswxIkRU563XcjgCkfwtS
 BNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742294855; x=1742899655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oFltWPALYkQiMDNUmSg+en3vLnxEiJ0+n8F2dvwsl/U=;
 b=gZW9dgUfBmGl3BwbSNMK3T+9BU2f5zE5QJ8zgplNarKoTV4XoSLSkT6uDoJ5pTtpqD
 lxZKyuQZFBvdwt4KuEGB8udr6N+Ft1RlvQsRxf70YxCwzP+fz1vM0KZr75zmwFj4aTE6
 RXk0en/N7a1M2d3q1wUb8MBpRDzgG8Ql8k774Siii6dkZalVWT0X3/fzPHhOZ6t7i4tM
 2Af+f4MFcbBHMsHIruG53onss1r0HOeBr6jdbCA6V2WD52GyxElwznR7jFLcqBu4js5T
 AYDoP3Zj9pBBf+G3GRdwTGnS8U0bjXrwjfKaUuiTd0UZBCeiufWkSK3IWKFE6gTCXWNq
 stmg==
X-Gm-Message-State: AOJu0YxgpcGt6PqI2GQ7+iYLszFB1oMM6kBbNJzLrQsTmRtCFJOR2c7j
 GoXOZVklsKPz0aZCa/UekeG0VrtMzX7djEQ19gnJtt3DIMKSD8VDly2Nce4vJx+2dl8HL1UatSf
 B3q4=
X-Gm-Gg: ASbGnctMvPb2tG64i8v3gHdehBOjxvw/kO6Pt/ONhI3pfEnrJhgOizhlvJD6oF2pmy2
 jE3ay5u9XHznLV4u1hvu0nih3f79VMFj4myfYgeXCNzOJJ9f5V4CkvctIOoWqhRLn1CgctL+BBh
 u/cXN/dzNF4E0EP2wpXct8M0k9++RzDWsBizn+N4I/whITIpbXweI90DbvA0PlEDA4aEqqY1jMX
 TFitqhLcVqmg+XoLQlKQBTr7Qnl2w23NNBYob6ISD5M5XMMxJ4i8GgeRZU18dkT+0+ADoUPAvJJ
 2Pu6X5iAx3CVm+zHJct+kypgqAZXKmn+WUm/PnbSSc+kfkYCmSVGbw==
X-Google-Smtp-Source: AGHT+IHxtQ1yz2pJZGLMSyf2SkSU0rZt61E/92oqX7Cj8t/boNL6lmt0ltE65Sg1EWY1vyMGvKGVjg==
X-Received: by 2002:a05:600c:4f92:b0:43d:9d5:474d with SMTP id
 5b1f17b1804b1-43d3b7cc234mr16180105e9.0.1742294855289; 
 Tue, 18 Mar 2025 03:47:35 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:78bd:2e7e:120c:26bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fdda2dbsm131788185e9.2.2025.03.18.03.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 03:47:35 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v4 13/14] test: cmd: add test for spawn and wait commands
Date: Tue, 18 Mar 2025 11:46:49 +0100
Message-ID: <20250318104659.1114340-14-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318104659.1114340-1-jerome.forissier@linaro.org>
References: <20250318104659.1114340-1-jerome.forissier@linaro.org>
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

