Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AA1C79FB6
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 13:27:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20BD340813;
	Sat, 12 Sep 2026 13:27:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W1zX5K1NRoui; Sat, 12 Sep 2026 13:27:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6593440818
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789219645;
	b=kdyK/foo7tuKjOdpgJPR5G4FfxDwuZM44nCuoIOA45s6CLueCjK3Uw7QpFEA7tEbM3jq
	 FrLg20b6DKNbGxcELfT3PlJVzGhwexLJxPimKEmxSsvvuLUXTaiB+sa9phqRBOIdgcFfH
	 MqgjP8hbGNpQe7ibZplNrqbSKh/VKIHSH6RLP1KWVayPYvETA/Ly+49msRca/WAmjYpLy
	 EyH4jLBfhwa/4t+Xibq91buR0CQfq1NU1uI4IfQIXQegF8TvTpmd+afDJIFStEUsrRsuN
	 xAOzXNzCRDU5iHQRjBcL0tV8cg+PWdjDKZbp7gkHAZrI6glM4hY+JwHDNaId5qWlrxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789219645;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WkGe+GtQE5P1xs7XtiW9iFQ11uymk3iCzZUVwpZgsTU=;
	b=axB3wN96+XihCGcgX3Hm83PoaPaK/0/SmXfOdfxnurBiobKO/bTBm5Nk9nOV/yXfNmUs
	 sbSleGjzst5I+wzwkXL8wZh1+/Z13nWmcQuhK+dQw9JrBTkQC9B+qHslQoxgjL1UsBk17
	 P3TzkLhvvy5uWqQkVfOuDQ76j7SX2dHgT/2A0qebV4+z0k1g7ojlpaDGTEKI77ys7ibMk
	 IEp+862Ix/Nuwx1CMPpy15g+pvXj6BRRqOGNx2gtz6ZF+3OPKq3HuolKLo1gwkem8uf6j
	 oP+1Cb2AUK9y8VKY2hvUX/iScAxuaVpycwbMwFK2K2PXKvtzc606T2R2pNJl8cdwF5w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789219645;
	bh=WkGe+GtQE5P1xs7XtiW9iFQ11uymk3iCzZUVwpZgsTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VdXsmjsy6qy0UPii71iwNZIsmEoCZ3jrfnKYk2OLZUIS1X2aDGVxsswVmy3B9dEt6
	 txcLeXv2Hmstx47lHMGK/QORjbVnxmOQ/tKS7SINpOhv7k8C/N+rgKTCPsKoXp+iKy
	 9x6Okoi/OqCSFLcYBnTsTflCtbgpFvmrL73ms9RUwvmuO0IGK6hdD6gKguDqkKwY55
	 I81bd+5DTIBUrV4WPz9Nk3oJkeMK/mNT9VfnUKxT6P043yMunS9dONxYekpSUtPkCs
	 rLbhya2Y3EheBCxdH+FwjQ81AF8buW+2XLd5kx9JfU7H6TPVMYKIaYZAOOaHBAHV5b
	 9NqMU86Ue4Opw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6593440818;
	Sat, 12 Sep 2026 13:27:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5049C32F
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 07:27:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 424DF400E4
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 07:27:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZVJAC1sgdtpc for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 07:27:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0CAF340076
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789198071;
 b=N8fPuHCxfrvUSGWsnj8EERuFhwaDolcj98UzWg24mHxsfFxVwgMSD3jHraA+rShs3OtN
 zKKaQcA8PzmwY3P+Ok0X2Uo1TeZ6aM8N9AYA8niSP6mYt7TTPDKIyl7Gt2fopkS1EXRis
 OziVO24OspOr1ZftgOW/OsUftWT/BpbvH6vfFi+iFBvPpzUTgBArr7vXs3mEKb1Y3L5fv
 y6D9HIeIguk3ABv/bruxFOnIidQpbLTR4nFqAHf5Ra7x6QC45aCl1xG7PRqS5VDKbtbdA
 S2RT1jUMmUAj1dowg4r2QaSHl9rEIv60UoF0ugdHJhuIXD5XHUyRaMKdrpHucWojZyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789198071;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=WkGe+GtQE5P1xs7XtiW9iFQ11uymk3iCzZUVwpZgsTU=;
 b=n9Lv/kg+btPL1IUjgxZyxoWcetI+3xdOTZJRrKRlKBfyFSGXvYLI5ZgKSYAPt+u4PX0m
 dm77FD78PsrdioKKCH9YJB+ny+zsep+Lv4qXAlFpkHJl7AwHET5OPFIHlh2leVCQrMSpX
 4uUUwEIsNfk/Uw0Ukk9oup5PEXYWQs7EUPATIRXHW2p8BNGJZ6fiwr2ZF/YVnop19M06d
 CzqVneMX6pubuHzK1Nb7t8OMgwrz9jB4I27aTacwfU6rhgb4uiOhiL/+/WydAqIZfd3lF
 1obtrTuZPz4I0EJcwhf5s/gAFDZRA/M/CvI+pkkCyRkGhAaOELjKgT5fcTn+dexOyyg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cAE63FJF; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com;
 envelope-from=imkyufie@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=cAE63FJF
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0CAF340076
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 07:27:49 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2d8f265cbe6so17225765ad.0
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 00:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789198069; x=1789802869;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WkGe+GtQE5P1xs7XtiW9iFQ11uymk3iCzZUVwpZgsTU=;
 b=cAE63FJF7fzRGMM1jYZKvUzCNNUwMiWR/w6f8tkZqm902hVOD78/aX+0PbaBNEoems
 Fwhq0DOY6X6skCoIozj92oliGw5jlJJkxuph1nQG61/T6kQZCfIUv6qznOhRplJqW7vz
 dreLGonC28zyk703uG5zfRwWI163c0NzEOHFzZRivtGw61D4+DgXzepcop5Zk5ccWbR+
 uiJVxravalfcdt8l5RLkorGVrgkXWSOoUhW7JiFLaxqIzcQzAt9DAe/Ab78pwn2QNP6V
 4PMcMgRa08bHDvai2BHKf+L5UZGZ3gVI1yqsiy4Xw7qUArlXPnOpHT5YGNz86vlPs5Dq
 lKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789198069; x=1789802869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WkGe+GtQE5P1xs7XtiW9iFQ11uymk3iCzZUVwpZgsTU=;
 b=O7RIgaIabdUYybJf/G36ymGLCPJr5cHmMJmJmmrWLp2fPvSq0eBxXgPIAL5cia0OtA
 F4jiwAUp2l3QDAO4vjtKmp3agt/nTYk6jCbVFqLNIN9F9LzEr+/TD//Za92J38yy74WY
 KH/rdhKGMMM/YAwqUofXmy15y/N5bjqAOgBky4oIpJvNjst4rg+QDXJX6rzQGw/5JlCW
 ywwTA/1QwF1Or8FveqqI428tuId1+kyOb25xIxzOhL/OYZ/V3Qwpo7HXwY5z7thBJrVx
 +enNk5+pmIVCssqo0jal4F/CR8pKiYAEEWT4TWJRIV3KE1/cYYB3euE6s27ynqCzo7tK
 lY0w==
X-Gm-Message-State: AFuF++ks6Ch7IHTUFwlVxzMFuoFD6KKyBqM0B/qUQvEJwkzJgyR2aXfw
 ISHXu5YZFry1/GDygBM3NcXijhO40PMam/+YdOCXyvt1+8vJc96gJb3cpWDiCA==
X-Gm-Gg: AYBFou3tlhcfM+h1VAPCqB11XhPT0i3zA2YhOs2aClEpQ5asAaunNPblorvinhd0h2l
 UYro3W5Ehn3saP2hs2MopI92yB1rf8Gpw18GgSEIfRIOp1Sc+6/nM7GKMwcbSVw9IpLeNMAiFxq
 eKt2BwP1BON+h0DA9KR4XZxM3ElT93wn6ocT893/2XCTYsXXaOlpHnHBmSGOrvLAVC74N1I6jrC
 0aZGlHhFGt0FG6rgsQi2mU2PTzp4dA6GbIEIg3tAbLODrZWh5Jl61owO+ySc96uI0PL1v1B3YyS
 x43ikCegj5rSEk+pApkHWE/vBOZ9z+vUPxlASGwmMyYwQFBAFn35pA1SQ0GoEPfHJbGKMINehro
 NVRQSr1XFFY6xrLIWYDnadj/J39s75j/Iiy8akMU+CdwRG7qJX9cQFIMzSjLlVhR/kgEUKySKPm
 a7rOiAKkRUvYON0z2IzQF7UsVrpwsNlgOqlnQF5yrnUsXHtfTXql8SSqVxGf8fYQ==
X-Received: by 2002:a17:903:1786:b0:2d0:cc92:f7a9 with SMTP id
 d9443c01a7336-2dd2a1d8c60mr135437835ad.4.1789198068847; 
 Sat, 12 Sep 2026 00:27:48 -0700 (PDT)
Received: from thefoxflat ([2404:c0:701d:4e35:a09e:399b:32ec:61ae])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2cfd719dsm21469235ad.59.2026.09.12.00.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 00:27:48 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Reza Kurniawan <imkyufie@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io
Subject: [PATCH v2 4/4] clk: qcom: Add Global Clock Controller (GCC) driver
 for MSM8917
Date: Sat, 12 Sep 2026 07:23:08 +0000
Message-ID: <20260912072619.244101-6-imkyufie@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912072619.244101-2-imkyufie@gmail.com>
References: <20260912072619.244101-2-imkyufie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 12 Sep 2026 13:27:13 +0000
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

Add Global Clock Controller (GCC) driver for MSM8917 to manage clocks,
resets, and gdscs. This driver includes the essential clocks and
resets for U-Boot to function.

Taken from Linux commit 08df884 ("Merge tag 'thermal-7.3-rc3' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm") at
drivers/clk/qcom/gcc-msm8917.c

Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>

---

Changes in v2:
- Change license to GPL-2.0-only
- Mention the source of the ported code
- Use macros for RCGR address constants

v1: https://lore.kernel.org/u-boot/20260910095339.110427-5-imkyufie@gmail.com

 configs/qcom_defconfig           |   1 +
 drivers/clk/qcom/Kconfig         |   8 ++
 drivers/clk/qcom/Makefile        |   1 +
 drivers/clk/qcom/clock-msm8917.c | 210 +++++++++++++++++++++++++++++++
 4 files changed, 220 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-msm8917.c

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 7d4a2b589..59cad58a9 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -57,6 +57,7 @@ CONFIG_CLK_STUB=y
 CONFIG_CLK_QCOM_APQ8016=y
 CONFIG_CLK_QCOM_APQ8096=y
 CONFIG_CLK_QCOM_MILOS=y
+CONFIG_CLK_QCOM_MSM8917=y
 CONFIG_CLK_QCOM_QCM2290=y
 CONFIG_CLK_QCOM_QCS404=y
 CONFIG_CLK_QCOM_QCS615=y
diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 95b650831..d8469ad5f 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -55,6 +55,14 @@ config CLK_QCOM_MILOS
 	  on the Snapdragon Milos SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_MSM8917
+	bool "Qualcomm MSM8917 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon MSM8917 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_QCM2290
 	bool "Qualcomm QCM2290 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 1adca029b..6478ec322 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
 obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
 obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
 obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
+obj-$(CONFIG_CLK_QCOM_MSM8917) += clock-msm8917.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
diff --git a/drivers/clk/qcom/clock-msm8917.c b/drivers/clk/qcom/clock-msm8917.c
new file mode 100644
index 000000000..f41e37091
--- /dev/null
+++ b/drivers/clk/qcom/clock-msm8917.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Clock drivers for Qualcomm MSM8917
+ *
+ * (C) Copyright 2026 Reza Kurniawan <imkyufie@gmail.com>
+ *
+ */
+
+#include <clk-uclass.h>
+#include <dm/device.h>
+#include <linux/kernel.h>
+#include <dt-bindings/clock/qcom,gcc-msm8917.h>
+
+#include "clock-qcom.h"
+
+#define CFG_CLK_SRC_GPLL4_SDCC1 (2 << 8)
+
+/* USB clock control register */
+#define USB_HS_SYSTEM_CMD_RCGR	(0x41010)
+
+/* SDCC clock control registers */
+#define SDCC1_APPS_CMD_RCGR	(0x42004)
+#define SDCC2_APPS_CMD_RCGR	(0x43004)
+
+/* UART clock control registers */
+#define BLSP1_UART1_APPS_CMD_RCGR	(0x02044)
+#define BLSP1_UART2_APPS_CMD_RCGR	(0x03034)
+#define BLSP2_UART1_APPS_CMD_RCGR	(0x0c044)
+#define BLSP2_UART2_APPS_CMD_RCGR	(0x0d034)
+
+static const struct gate_clk msm8917_clks[] = {
+	GATE_CLK_POLLED(GCC_BLSP1_UART1_APPS_CLK,	0x0203c, BIT(0), 0x0203c),
+	GATE_CLK_POLLED(GCC_BLSP1_UART2_APPS_CLK,	0x0302c, BIT(0), 0x0302c),
+	GATE_CLK_POLLED(GCC_BLSP2_UART1_APPS_CLK,	0x0c03c, BIT(0), 0x0c03c),
+	GATE_CLK_POLLED(GCC_BLSP2_UART2_APPS_CLK,	0x0d02c, BIT(0), 0x0d02c),
+	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK,		0x4201c, BIT(0), 0x4201c),
+	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK,		0x42018, BIT(0), 0x42018),
+	GATE_CLK_POLLED(GCC_SDCC2_AHB_CLK,		0x4301c, BIT(0), 0x4301c),
+	GATE_CLK_POLLED(GCC_SDCC2_APPS_CLK,		0x43018, BIT(0), 0x43018),
+	GATE_CLK_POLLED(GCC_USB_HS_PHY_CFG_AHB_CLK,	0x41030, BIT(0), 0x41030),
+	GATE_CLK_POLLED(GCC_USB_HS_AHB_CLK,		0x41008, BIT(0), 0x41008),
+	GATE_CLK_POLLED(GCC_USB_HS_SYSTEM_CLK,		0x41004, BIT(0), 0x41004),
+	GATE_CLK_POLLED(GCC_USB2A_PHY_SLEEP_CLK,	0x4102c, BIT(0), 0x4102c)
+};
+
+static const struct freq_tbl ftbl_blsp_uart_apps_clk_src[] = {
+	F(3686400, CFG_CLK_SRC_GPLL0, 1, 72, 15625),
+	F(7372800, CFG_CLK_SRC_GPLL0, 1, 144, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0, 1, 288, 15625),
+	F(16000000, CFG_CLK_SRC_GPLL0, 10, 1, 5),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(24000000, CFG_CLK_SRC_GPLL0, 1, 3, 100),
+	F(25000000, CFG_CLK_SRC_GPLL0, 16, 1, 2),
+	F(32000000, CFG_CLK_SRC_GPLL0, 1, 1, 25),
+	F(40000000, CFG_CLK_SRC_GPLL0, 1, 1, 20),
+	F(46400000, CFG_CLK_SRC_GPLL0, 1, 29, 500),
+	F(48000000, CFG_CLK_SRC_GPLL0, 1, 3, 50),
+	F(51200000, CFG_CLK_SRC_GPLL0, 1, 8, 125),
+	F(56000000, CFG_CLK_SRC_GPLL0, 1, 7, 100),
+	F(58982400, CFG_CLK_SRC_GPLL0, 1, 1152, 15625),
+	F(60000000, CFG_CLK_SRC_GPLL0, 1, 3, 40),
+	F(64000000, CFG_CLK_SRC_GPLL0, 1, 2, 25),
+	{ }
+};
+
+static const struct freq_tbl ftbl_sdcc1_apps_clk_src[] = {
+	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(20000000, CFG_CLK_SRC_GPLL0, 10, 1, 4),
+	F(25000000, CFG_CLK_SRC_GPLL0, 16, 1, 2),
+	F(50000000, CFG_CLK_SRC_GPLL0, 16, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0, 8, 0, 0),
+	F(177770000, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
+	F(192000000, CFG_CLK_SRC_GPLL4_SDCC1, 6, 0, 0),
+	F(200000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
+	F(384000000, CFG_CLK_SRC_GPLL4_SDCC1, 3, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_sdcc2_apps_clk_src[] = {
+	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(20000000, CFG_CLK_SRC_GPLL0, 10, 1, 4),
+	F(25000000, CFG_CLK_SRC_GPLL0, 16, 1, 2),
+	F(50000000, CFG_CLK_SRC_GPLL0, 16, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0, 8, 0, 0),
+	F(177770000, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
+	F(200000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_usb_hs_system_clk_src[] = {
+	F(80000000, CFG_CLK_SRC_GPLL0, 10, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0, 8, 0, 0),
+	F(133330000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
+	F(177780000, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
+	{ }
+};
+
+static int msm8917_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv;
+
+	priv = dev_get_priv(clk->dev);
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static ulong msm8917_uart_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
+	u32 cmd_rcgr;
+
+	switch (clk->id) {
+	case GCC_BLSP1_UART1_APPS_CLK:
+		cmd_rcgr = BLSP1_UART1_APPS_CMD_RCGR;
+		break;
+	case GCC_BLSP1_UART2_APPS_CLK:
+		cmd_rcgr = BLSP1_UART2_APPS_CMD_RCGR;
+		break;
+	case GCC_BLSP2_UART1_APPS_CLK:
+		cmd_rcgr = BLSP2_UART1_APPS_CMD_RCGR;
+		break;
+	case GCC_BLSP2_UART2_APPS_CLK:
+		cmd_rcgr = BLSP2_UART2_APPS_CMD_RCGR;
+		break;
+	default:
+		return 0;
+	}
+
+	freq = qcom_find_freq(ftbl_blsp_uart_apps_clk_src, rate);
+	clk_rcg_set_rate_mnd(priv->base, cmd_rcgr,
+			     freq->pre_div, freq->m, freq->n, freq->src, 16);
+
+	return freq->freq;
+}
+
+static ulong msm8917_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
+
+	switch (clk->id) {
+	case GCC_BLSP1_UART1_APPS_CLK:
+	case GCC_BLSP1_UART2_APPS_CLK:
+	case GCC_BLSP2_UART1_APPS_CLK:
+	case GCC_BLSP2_UART2_APPS_CLK:
+		return msm8917_uart_set_rate(clk, rate);
+	case GCC_SDCC1_APPS_CLK:
+		freq = qcom_find_freq(ftbl_sdcc1_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_SDCC2_APPS_CLK:
+		freq = qcom_find_freq(ftbl_sdcc2_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, SDCC2_APPS_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_USB_HS_SYSTEM_CLK:
+		freq = qcom_find_freq(ftbl_usb_hs_system_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, USB_HS_SYSTEM_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 0);
+		return freq->freq;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static const struct qcom_reset_map msm8917_resets[] = {
+	[GCC_CAMSS_MICRO_BCR]		= { 0x56008 },
+	[GCC_MSS_BCR]			= { 0x71000 },
+	[GCC_QUSB2_PHY_BCR]		= { 0x4103c },
+	[GCC_USB_HS_BCR]		= { 0x41000 },
+	[GCC_USB2_HS_PHY_ONLY_BCR]	= { 0x41034 },
+	[GCC_MDSS_BCR]			= { 0x4d074 },
+};
+
+static const struct qcom_power_map msm8917_gdscs[] = {
+	[MDSS_GDSC] = { 0x4d078, true },
+};
+
+static struct msm_clk_data msm8917_gcc_data = {
+	.resets = msm8917_resets,
+	.num_resets = ARRAY_SIZE(msm8917_resets),
+	.clks = msm8917_clks,
+	.num_clks = ARRAY_SIZE(msm8917_clks),
+	.power_domains = msm8917_gdscs,
+	.num_power_domains = ARRAY_SIZE(msm8917_gdscs),
+
+	.enable = msm8917_enable,
+	.set_rate = msm8917_set_rate,
+};
+
+static const struct udevice_id gcc_msm8917_of_match[] = {
+	{
+		.compatible = "qcom,gcc-msm8917",
+		.data = (ulong)&msm8917_gcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_msm8917) = {
+	.name		= "gcc_msm8917",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_msm8917_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.55.0

