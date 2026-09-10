Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79254C79FBB
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 12:14:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38E5560B4B;
	Thu, 10 Sep 2026 12:14:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8kAWLn-YMs6y; Thu, 10 Sep 2026 12:14:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9412660B5D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789042458;
	b=YV+OMCDr/HMkJ3EMyJKIcdofMJ15A0nCsLh3bANn6O7pSnCyaeQiTY6GDo9oT8B2pklG
	 4BycVk840FtX07mToq7alBHyJg+CDTJ+4U7Nezq7r29jaiVd4N5jtZngUG8pGV5YXIZs7
	 3YQRWDIVDDphyYPPUqhKsA7DSFBgT4JiTcubTQt9Rl2sOM3qwAJuCqE/w7y9OnODsLgcC
	 GQif9z1r545BXHO6UxBfBMKUD529F5bEer87iZSIOVM4Yh2Ct+HdO1WAUOUMp+Uq+CEcv
	 3kFCZKYQvjM2jzPcnYcdwFJTA6b5D2N0dFnt5bE0JBjnMlfgXgtb/ZZQCA0SAU1LGbQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789042458;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zFgpbnYmSE5ds/Qv6zCkAVp0yJMKFMCl29azivlE3P4=;
	b=QU9Nd5byzXkJxI0KSKwiRmFFGzEaj3jwCSO44G4zDzfOxZDh20+eX+Tk+R4RdW2TPz/a
	 F7NDGUOP46Xr1VtFnq1abqevJzXeX11HDn6LJxSJp9UYuxt7cOtvV1hOGtgb55ZUL9MJO
	 4P7qK3chObMpK7zWDRbCn+EqXwb1O/u6lrFAa0dKhiqp02qLTkfx4cFQ1O3UkisjqBuJA
	 kGWo+qSI5TVPG+RwnfKB8hffBsxeeRwJT81SNiTkuO2Q2n1pbFWx/j1U/ir5YYR/8rOat
	 mc3L2bZmvXgRUJ6b4SGedZ+hl93FAV9lfaKLrVu7nd3P8vDRj0WhpUrBGTq2Up/aAZA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Dw/jhpFz";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789042458;
	bh=zFgpbnYmSE5ds/Qv6zCkAVp0yJMKFMCl29azivlE3P4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DS0ajZgsZkbWkX9rpXaaZ7A2aAJJj+jANiuPb/ie8AOH3bIhbrBBdmApW/oKIjr05
	 eUcOMV+VJG1mCEArTpqLD3CBZAUdE2Uo3GHqn2jUouaDx4Beb9mKrUfx8Zyy6JwkYr
	 QQvoZ16Pi2/MdrRn0UwpyzSpX4zscjh4f0TF+z+IumpDs+wyES/HJjjqt69Jt2Pcke
	 l8hHxV1mOBbuMUZ6iO4+4xegK6dE6NaLRxY8/AkXbJDYxrN6A17OxHOq6zZB+SGFTI
	 DDpXKkZ9G49M8l0CuCGNuDHFqY2qChrm39+W6CUkRWOrGVIadDVnbFi8/6lGj6lDlT
	 U019SsyjQ/OJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9412660B5D;
	Thu, 10 Sep 2026 12:14:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B2395E11
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 09:54:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A416A608A4
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 09:54:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XxXzAiHrSop9 for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 09:54:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C13B860869
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789034048;
 b=ny7HeT1tnrHkgDDAbaMAUTewxnTH+GD/PoDWa+tNIkkuYPrpKa4fygbLZOrQgsa9kT6R
 qfkv/uJbOqxzJWX1EP/8KWC+MOvrcqHYnnYD+Q/N4Bcx0shaZxECME0QfRfE/xo6SEhal
 6mCCy/WzW4BPcrWAXYvmg93l23TnxRXPzHGTk4qSMMKhoBCe/ZYBq9aiP4Y3tkpo+OekZ
 +JLQ95PbGVzQ4wR9lMEcAHHGy0sujjgjtnyknCCerS/nsYldFK3KqTxXiQ/llJDnm8YmU
 PI61CSrS/RrTFBJ+GeH0GNZnfeqF/dJQCPDB58mu+buyZKv2xlt+ACOypVyJ5ZKMNxQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789034048;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=zFgpbnYmSE5ds/Qv6zCkAVp0yJMKFMCl29azivlE3P4=;
 b=iGODmno0bMdJ12KNArJ9rBRVxw001dTkkKtI7MvBtI9wQKvdp+uHI3ax0G/w4BegGRrn
 IutM/5AaBb8HFfXu8FNYOTC37Gosv+0VkyX3UTTGAlJnr8U1SJElJ/LT9FjFHdGBylSyr
 tgNQAVhpBBW+te7iuE8ibshoZJWr3FW1nksdsb0eofaXKYHdOuP7bRyylcKB/DjeOTMBF
 l+1QqSm79LWCDV1omAoAFCkmlKae2kMsDCNnWoh/aKRLmGtWBdrazVIrDcESObk+GR8sr
 muLvlT7txOBE73ORqfVimzUHHgxfJqyCiTP/VxQ7fWQcXyc21ADn35zWzb3J0HxJalg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="Dw/jhpFz"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com;
 envelope-from=imkyufie@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Dw/jhpFz
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C13B860869
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 09:54:08 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-cc4aa02a269so959166a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 02:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789034047; x=1789638847;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zFgpbnYmSE5ds/Qv6zCkAVp0yJMKFMCl29azivlE3P4=;
 b=Dw/jhpFzitvxKfVPahPOa70aq/0/HTTXaUxffNWRVkfvyrDiTOiaqalT/xnBrd/hn9
 h4CJZEWgnEqBZJER2GwnRyaNdpybPfSVhwMv07LXBaTuQVWCkxIt87mkAwvCbNCZVrkL
 HKZnwjCxKNFLEDrW3FmWQOASpGRU3OI1iOWCNBHfyOHU9vvyZoTI2HaIOeSDqaEipYiS
 gmZ4IMwOxieW7HBNLzKUzKDnViq0TJxKnYPAlqrgncMVNjKW632PVttB5FbAlfOr2Xel
 hZRIhTs9OE1rkcJUFqd2AxQ80CpwY2TGo71p6NaS6C4RnpNVhUE43GIbSMB9a6v9r39T
 q7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789034047; x=1789638847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zFgpbnYmSE5ds/Qv6zCkAVp0yJMKFMCl29azivlE3P4=;
 b=W/uaHrxBfM2MFOLLznWzORj9RKTEOt4njaNq/l48zn54UPqooSj6ueVM02B/hTlPdt
 apj+K3wiOw825Dl8CuwYZ/I9syMws2Aia8HHPVxk41dtJAcLexmdy4Yjh0UsAAXmwTSN
 JCUoXyeUxGy4zNpsbmOj4pm1jKwTzZimjnWdfSt+zFHkVCAnxjDj+bgTHizLILp+WElT
 np7qjGaOPl07JcfoctEgKxbqhRkb1bCUfJCok2coVbCMrA/yg6yuwDE/D9pAG0HgGWtk
 5CTbtEQciLuW9CrdFlDNTmndkefogeo4WN5B76GE/2kIMY19n75WWop809wXujgE613l
 Bt9w==
X-Gm-Message-State: AFuF++nEMPW3+nLJ5EPbQF05kr6LER6RZZNWoUi5Afp0Wdu34+2tzlYv
 /zlenT6DIRNSbG9VG5joJHOeo/Fjx/KP3BFNkmAU54K289tmmHoSiHr0jrzy8Q==
X-Gm-Gg: AYBFou1bay0defzAGndiINK9hBNmbn9YMtuChu4EWePxI6PGqdvRUwuBIQu5lirvadV
 lwb+1KOmoNlusCTs2qVx0e2/0dCi+RjVpwojgjZeM4c7MgRIy6way5vSc07wrRSENpIN/Z8Vmat
 chCMOwEV+eeYYbm8yFuegc1677GqZox5hiwpuWRfe/EmOxJ9Jv9cPtJY1IGDPrj8BMw0IQi9d+u
 7QQ5zUTMCaOT2d6nildDBls/Pxf3t1opIiNUVJiRLOdgHkKq77huYUc+Gb68PZLA6aC2aFG1qWU
 Bi/9iuwEtRPVG/EtqbgN7DAlIJNsDShfwu3wDUXZsKoOB7qUrGsY4jceFTVo9yMws6WMyfEY840
 wWwwAT+vlvD15bYNztsnvwg0zC8XhdGBDYMxLXKchTfNyyZ2U3f0B2Igoz8B8lkes/hzkv7Nnru
 pcugTyOAUzSA4XXFDLxoBd0QfZPFY4PVx6nNwLDNr037N1hkKR/sbPXpYrIgvdQsLOwEHnXNCb
X-Received: by 2002:a17:90b:1b06:b0:398:9be9:ab8e with SMTP id
 98e67ed59e1d1-39b2622ba26mr57753108a91.19.1789034047415; 
 Thu, 10 Sep 2026 02:54:07 -0700 (PDT)
Received: from thefoxflat ([2404:c0:7029:b3c6:7b99:50ff:b405:5c31])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d7e77498csm3849455a91.3.2026.09.10.02.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 02:54:06 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Reza Kurniawan <imkyufie@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io
Subject: [PATCH 4/4] clk: qcom: Add Global Clock Controller (GCC) driver for
 MSM8917
Date: Thu, 10 Sep 2026 09:41:47 +0000
Message-ID: <20260910095339.110427-5-imkyufie@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910095339.110427-1-imkyufie@gmail.com>
References: <20260910095339.110427-1-imkyufie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 10 Sep 2026 12:14:04 +0000
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

Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
---

 configs/qcom_defconfig           |   1 +
 drivers/clk/qcom/Kconfig         |   8 ++
 drivers/clk/qcom/Makefile        |   1 +
 drivers/clk/qcom/clock-msm8917.c | 196 +++++++++++++++++++++++++++++++
 4 files changed, 206 insertions(+)
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
index 000000000..2cb1fa961
--- /dev/null
+++ b/drivers/clk/qcom/clock-msm8917.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Clock drivers for Qualcomm MSM8917
+ *
+ * (C) Copyright 2026 Reza Kurniawan <imkyufie@gmail.com>
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
+		cmd_rcgr = 0x02044;
+		break;
+	case GCC_BLSP1_UART2_APPS_CLK:
+		cmd_rcgr = 0x03034;
+		break;
+	case GCC_BLSP2_UART1_APPS_CLK:
+		cmd_rcgr = 0x0c044;
+		break;
+	case GCC_BLSP2_UART2_APPS_CLK:
+		cmd_rcgr = 0x0d034;
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
+		clk_rcg_set_rate_mnd(priv->base, 0x42004,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_SDCC2_APPS_CLK:
+		freq = qcom_find_freq(ftbl_sdcc2_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x43004,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_USB_HS_SYSTEM_CLK:
+		freq = qcom_find_freq(ftbl_usb_hs_system_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x41010,
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

