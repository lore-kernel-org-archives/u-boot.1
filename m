Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8865EC88E77
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 04:16:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 236CC80DCD;
	Wed, 16 Sep 2026 04:16:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QRaE6M7hudNn; Wed, 16 Sep 2026 04:16:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0557080DB0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789532204;
	b=lBHonL36ekL9J3R200aQViqc1crdR5X2DrKDYFnJJTP51xZ4BNH4sS5kCMNjtz+ZBPHo
	 Zvx5rABB6Hqh3dVDt/MyKvESkr2zkZhd0bSzupzRoH6A6JWMP3jGHqd4Hn6fGkOLgIwLn
	 +l8aaGOv4VeyAW0AVRsvkZfsz97nhWxPeeqePj2DvIFQ8HkrQw7R43GDwPlsd8wfdM8zS
	 0WKvJVs50jzcd5iBwi90r8HbkEIFm8WK7QhF/HllHbx1PL10pUET9BKjXkc6qvdK8j7OK
	 lvHO91oSOpas/5U4HuibAm0NLDqYdMV9+VflTnYwhroYEo5hFyiqwK4SkhTgewrXtdQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789532204;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RYcbEkQBxh4eRL2cjqJIvDpwWD8qMEYmnZe84nY6QE8=;
	b=oWHEkXZw9YiTUlTnsU4F8KJIqqIg81ShENDz32EqkoyKSQN37fJ3C3wdrhHsGx+0rb1j
	 lTL0MOmCU4RsXAhh6KRlWxHHzXolY81NmTWrY+72+PQGE2q1b/Qg8Dj29qzfmDcC72nLL
	 T0mjwAjdRbln4D4mOlZPbYJySUHvsj2cPgrK5oLXX3ZPkQniGQyRkqdLsh53dsQ0iOfwh
	 d4XM8xTmV+R/IlsbMp8T/MsxkNjhV1+OjmFN2C+oWiME1v/NWZihatGzjH+0qwVE4D7eB
	 T9tA5tnPZWSDLQKF3ixlXllLkWwbiJ5Av3B++WehTQ0/4w0WqFlUlizEQ+P2OebhBcQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789532204;
	bh=RYcbEkQBxh4eRL2cjqJIvDpwWD8qMEYmnZe84nY6QE8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qddiHWace2iI0p9508PChEBMOTsr3bgROa19jWLVZf9MBiby6wIEElrQyKUNrqXDf
	 WZRJ+FA5Xq5KX0wl4hO6zrW0uAZBcHW4B8ZCaZEdOAdOtN8B9pqbC3+iYDBnTUMAhF
	 C0YnmDPv/0PhfUYnZ9c31nNAF4WPy4TkBSOYS1ZWIOct1wwBOc/O8FAjGEX8R+Nbac
	 ajvk+j265y2+P1sHWLft1jz0AWhdiuGrRnUmHWddfhc0SyzgM9ndKD2ecoN6OadVOM
	 2XenE8kBxSVCQEuuAB0fPVqyFv5JbZOWQxzm71W16jTd3btTHcaFme5b3AoovZ3LyA
	 vlPaT2NlmEjSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0557080DB0;
	Wed, 16 Sep 2026 04:16:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E5D5C388
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 04:16:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CB6E8400E6
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 04:16:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WYTyiA31_SYz for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 04:16:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org BE26F40076
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789532200;
 b=djq85H9gK7u9rT7lhDrByYDgnbNYAU9uPTPWxHZ4he3BCh0x4g00Kaorp3gviSTWExnW
 s3FEVAVjMU2ZCl3A7WS9/WxeBLFxdilM2OVpJ1UIonNlAI7U39uIRDykp5YEJyphZMpFd
 BX+8uPt2qoSjhmvCNVZ1OC/vqjVMFAV6Emc3K4U5Hum9JfunCsN5J0g3Anw1IOYOG94bx
 BOiprI6XqOosxTWN+46EPhaDyf691LG0t3xMVXWK4ZysJ8a/iZonRi+/17CNDUC4NwYoN
 iPJrSpcRb2oBOmVhO/EsgmV256hdu7iIX5O7PzHEM4J/mulTysIxxqVwLfJwDM8sjnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789532200;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=RYcbEkQBxh4eRL2cjqJIvDpwWD8qMEYmnZe84nY6QE8=;
 b=sWF02TOBHl805d7I61Qztrm5J9xfZDKqdXpE5OGQ/6vTC0MDqD5llkcU4n7eYMA8HZvO
 K/Y2nsK3frLZdMTqkJGBesYoGbKhxrB606tfGPKOrEdwsrdq8g1uKGWt/sQQW1KLE4ptx
 g9QEEOzoxfJMXpupjoCMbBdYRMkT3GiDOverPRov60E1B28YZrD0LBMAzjsHzTBceJffM
 6NMy0gMNFlOlvEjkBScmNlzoKFWjcMhnfrZbXYvIKv8brN4fGYcvCx8YCvYNLvQ+EE2Sr
 Hfj1VbMT2TIEDIrJc9+y7jEtBGqX2/RFoPHbPuvw4PGWRo5JtBsT/odBj6ZiX2xkDbg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=YI6GMjcJ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=imkyufie@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=YI6GMjcJ
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BE26F40076
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 04:16:40 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccafb751so387354a91.2
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 21:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789532200; x=1790137000;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RYcbEkQBxh4eRL2cjqJIvDpwWD8qMEYmnZe84nY6QE8=;
 b=YI6GMjcJG9WMADIwMal3Uvpy5M+s1sAzBmeJ42dlL5qVoull1UKBE1wvcF4UDKfDeB
 NKZAv8oMTNtgON2nGJHTRdllisIwjhcgJoyQgJYl2jT6DBRhy7aKCl+L0VJGgw3FUF76
 TDiyWyejW7hPSZBp2viUy0ZMTSJPh1/63krGJCP7W/564j/07TrYWg/GdKKJawiPqR70
 cpmx1gzljFFoHyeaTuCKG11z1dyBlK5qN50H2hSbpHUxhofZCqxhbEqSsGk7cqpnGMdX
 yotv0/v4YGgaQUAEKL0JW4KeYuW9rbvfTTGga+0vqZt+b+5B42e61HyXFNvWBe2GoTi4
 7MjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789532200; x=1790137000;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RYcbEkQBxh4eRL2cjqJIvDpwWD8qMEYmnZe84nY6QE8=;
 b=q2YiLuBl+toJ4kq46nTVi9KomrLqfAj542Kdd2ahDt0fhvFnBdo5PcfAoEaV8Zbq0t
 sOzVgeXvk8IiPPRBEh8f7meZBI5zVpwXcWpEu/3DtWiuAhUWGBVPT5wOlhyneeDEp9e2
 J6ov3a2nf+C1rG1zZjhNs066V1O42+TVldbTfNr1ZW5GiMZnWFfE3P0Ce9/8/ZSXOLAX
 N6tr1ALiSeeUIz9a/Nfm2f9oaUkioSw6EdLV0VOpta0Fzwg1wQwr0ptt/+Ly18oWtoE0
 mZyNqAWl/do1VFRoe6UY3hNY266CnYWoESqnns4hWT7EFvKxrCJTOamoGP2Kte8UhOgW
 X2tg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4vAq4g9qSQSZXyCgub0FFLoh/3wrNWwHR1yL1hNqZ7QvwDwEBYpxBZKoM0ul/2NrXxxAWu+U=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mJ0TGYkOHUk6WtEEsJDuMxncLsAUXyA4zIjvLAkW3gPMrDSjSG
 qIYGs4KAmRfDkT5DdTr8eQ0TGWqvGiHudD9woLZ/TnnFCnOCl8iTwyec
X-Gm-Gg: AYBFou1YoJgjhFlXCa4llT2OLVHWWr3BO1FpOKv7EaWgBYZj8yzy8vtxoUAUOOFRpjd
 BstDXxHdIxl/UVTcy6eBoc5HFVC+jISb6sW3AtVMwz8wrs3sbjXPqpwtWycBTkogx+hw1+Oe0fn
 f8WX5t9pLMPniN1eJSYdKoOp0u/x0Jun38ANXUknw4L50VySulQ4zFPQdX5fuw201eYyAZaB7N0
 44t7vZiqodCYM8roHEKytvdQJGdoN2LAe5MC4HDZcyASjRvYf7hJoypeRL4WEARu2o0LS965hKM
 aLQPdM67kGAUJPXlsiLp9NvppVCv9+dpFaHgaeHGTdMnqs7001Kv6GfKfHIqRqLugjMYQkm4ehg
 u3i3BzSJ7LXBdFB128ifWO0pGN6VqWfjdCMWqBVuCfblGm798jPR9pZ2Ak4qmDTgTu7yM5i12t/
 sSy2qWp3mlq//AEa3BLJDYK+MPh2tCB7EZk+zowF5B+oovkmbaJYOQGVStt3cWG21Uiq7+6AkZ
X-Received: by 2002:a17:90b:4fcf:b0:39d:ecc8:73b1 with SMTP id
 98e67ed59e1d1-39e1e2bd30emr2901985a91.7.1789532199640; 
 Tue, 15 Sep 2026 21:16:39 -0700 (PDT)
Received: from [127.0.0.2] ([2001:448a:40a4:1818:e1b0:e8af:138:39e6])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bb234c3sm2051689a91.6.2026.09.15.21.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 21:16:38 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Wed, 16 Sep 2026 04:16:03 +0000
Subject: [PATCH v3 2/3] clk: qcom: Add Global Clock Controller (GCC) driver
 for MSM8917
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-msm8917-support-v3-2-35103cb4e01e@gmail.com>
References: <20260916-msm8917-support-v3-0-35103cb4e01e@gmail.com>
In-Reply-To: <20260916-msm8917-support-v3-0-35103cb4e01e@gmail.com>
To: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Cc: Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Lukasz Majewski <lukma@denx.de>, Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Luca Weiss <luca.weiss@fairphone.com>, Reza Kurniawan <imkyufie@gmail.com>
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

Add Global Clock Controller (GCC) driver for MSM8917 to manage clocks,
resets, and gdscs. This driver includes the essential clocks and
resets for U-Boot to function.

Taken from Linux commit 08df884 ("Merge tag 'thermal-7.3-rc3' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm") at
drivers/clk/qcom/gcc-msm8917.c

Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
---
 configs/qcom_defconfig           |   1 +
 drivers/clk/qcom/Kconfig         |   8 ++
 drivers/clk/qcom/Makefile        |   1 +
 drivers/clk/qcom/clock-msm8917.c | 210 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 220 insertions(+)

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
index 000000000..11ee0a7c0
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
+	[MDSS_GDSC] = { 0x4d078 },
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

