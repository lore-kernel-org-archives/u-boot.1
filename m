Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E41E7D240
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 07:01:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B5BD86CBC;
	Tue, 26 Sep 2023 08:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kBbGLzNd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 124C686D7D; Tue, 26 Sep 2023 08:58:52 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAFFE86D7B
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 08:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-690f8e63777so1514256b3a.0
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 23:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695711528; x=1696316328; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GLIlsAiaYGyWD9uAANY4anGfvdQ5dSKKNYsox/E0Q4A=;
 b=kBbGLzNddXDq/PITS5+T+chrbowFeIXEBTJ/HiERox2O3pcq/cONpPh77F6sKZYvPJ
 RLOIN79C4dOQab40ng+Md031GG4b6DBdHIh8zskAVaYZ2vG9zxnMFAY+45ufzX5C/8/7
 50b7MnlmsvKixZOt/fF8smNU8Fkm/bDp+6gJDt90aGubNpkPEeWp2cUPg6B91MTtVC4Q
 GgnpwqWdtIAIHWgTSkAymKEt6fmSC7h2/HTIS6A8fO4HlwejTIbftLi4Dg5FvBm1J1DK
 zkqPsUEjHRMNIuc5wIJMR8vjLzS6U81PvJmTHsc8qcB8hS/L+tX8z8WybSM1MI437XxN
 Ag9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695711528; x=1696316328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GLIlsAiaYGyWD9uAANY4anGfvdQ5dSKKNYsox/E0Q4A=;
 b=c0b+Lhyh1wc5M2dY2OuEzZm8Xv2P52f4qZjV4hroO31Hlk4yZBoJlDXYBSMSgmZ2uN
 HbL3geURAkOB1wc+qBrf7QTgvpTIatRbs1t7g/VsdBgWH+JQS4cUCUUISN7hdKARkVap
 IAmhiF3zvA8KASDwtBbmBbnjsLToDsidCLk78IQ9rTsx8N8IDnQtFRcklCB9oQ5iW5FZ
 kCDZSfqjieruoi2tJ2wScFjoJTNubzeMlo34+3TkAjoSWmyN8yRF8epCz5zWlNIgPahQ
 5I2MkMg2jI3DNgjt+VSDPVjuTvcVi5mIr/AamkyeQSSJrRfZZAxRoO5odNqh84UeaZ04
 b3Vw==
X-Gm-Message-State: AOJu0YyYbth+ApxsEmc7c2mYKjooh4HtEN7huvTgOvMSR2pfxQwIt5YW
 BZxVlLxXTBwoXdgwQBujNO4pQQ==
X-Google-Smtp-Source: AGHT+IEBECzuDbEKCmt1DRfh+c0Dkwe59r87HN2fTydNFjtXCLNXDntKz/2QmSbIYnG+pemaEjDNbA==
X-Received: by 2002:a05:6a00:b56:b0:68e:369b:a123 with SMTP id
 p22-20020a056a000b5600b0068e369ba123mr10727796pfo.1.1695711528189; 
 Mon, 25 Sep 2023 23:58:48 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:6585:aea6:5002:a825])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a639242000000b0057825bd3448sm8758874pgn.51.2023.09.25.23.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 23:58:47 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v5 16/16] test: dm: add scmi command test
Date: Tue, 26 Sep 2023 15:57:50 +0900
Message-Id: <20230926065750.734440-17-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926065750.734440-1-takahiro.akashi@linaro.org>
References: <20230926065750.734440-1-takahiro.akashi@linaro.org>
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

In this test, "scmi" command is tested against different sub-commands.
Please note that scmi command is for debug purpose and is not intended
in production system.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
v4
* move 'base'-related changes to the prior commit
* add CONFIG_CMD_SCMI to sandbox_defconfig
v3
* change char to u8 in vendor/agent names
v2
* use helper functions, removing direct uses of ops
---
 configs/sandbox_defconfig |  1 +
 test/dm/scmi.c            | 53 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 1cd1c2ed7cd5..3906476bb4fc 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -122,6 +122,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AES=y
 CONFIG_CMD_TPM=y
 CONFIG_CMD_TPM_TEST=y
+CONFIG_CMD_SCMI=y
 CONFIG_CMD_BTRFS=y
 CONFIG_CMD_CBFS=y
 CONFIG_CMD_CRAMFS=y
diff --git a/test/dm/scmi.c b/test/dm/scmi.c
index d4ff60e00069..949e49bd2c35 100644
--- a/test/dm/scmi.c
+++ b/test/dm/scmi.c
@@ -206,6 +206,59 @@ static int dm_test_scmi_base(struct unit_test_state *uts)
 
 DM_TEST(dm_test_scmi_base, UT_TESTF_SCAN_FDT);
 
+static int dm_test_scmi_cmd(struct unit_test_state *uts)
+{
+	struct udevice *agent_dev;
+
+	/* preparation */
+	ut_assertok(uclass_get_device_by_name(UCLASS_SCMI_AGENT, "scmi",
+					      &agent_dev));
+	ut_assertnonnull(agent_dev);
+
+	/* scmi info */
+	ut_assertok(run_command("scmi info", 0));
+
+	ut_assert_nextline("SCMI device: scmi");
+	ut_assert_nextline("  protocol version: 0x20000");
+	ut_assert_nextline("  # of agents: 2");
+	ut_assert_nextline("      0: platform");
+	ut_assert_nextline("    > 1: OSPM");
+	ut_assert_nextline("  # of protocols: 3");
+	ut_assert_nextline("      Clock management");
+	ut_assert_nextline("      Reset domain management");
+	ut_assert_nextline("      Voltage domain management");
+	ut_assert_nextline("  vendor: U-Boot");
+	ut_assert_nextline("  sub vendor: Sandbox");
+	ut_assert_nextline("  impl version: 0x1");
+
+	ut_assert_console_end();
+
+	/* scmi perm_dev */
+	ut_assertok(run_command("scmi perm_dev 1 0 1", 0));
+	ut_assert_console_end();
+
+	ut_assert(run_command("scmi perm_dev 1 0 0", 0));
+	ut_assert_nextline("Denying access to device:0 failed (-13)");
+	ut_assert_console_end();
+
+	/* scmi perm_proto */
+	ut_assertok(run_command("scmi perm_proto 1 0 14 1", 0));
+	ut_assert_console_end();
+
+	ut_assert(run_command("scmi perm_proto 1 0 14 0", 0));
+	ut_assert_nextline("Denying access to protocol:0x14 on device:0 failed (-13)");
+	ut_assert_console_end();
+
+	/* scmi reset */
+	ut_assert(run_command("scmi reset 1 1", 0));
+	ut_assert_nextline("Reset failed (-13)");
+	ut_assert_console_end();
+
+	return 0;
+}
+
+DM_TEST(dm_test_scmi_cmd, UT_TESTF_SCAN_FDT);
+
 static int dm_test_scmi_clocks(struct unit_test_state *uts)
 {
 	struct sandbox_scmi_agent *agent;
-- 
2.34.1

