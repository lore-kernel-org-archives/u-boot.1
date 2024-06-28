Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1B5C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 17:42:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3634A88214;
	Fri, 28 Jun 2024 19:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e0bsHeBP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FE94885E1; Fri, 28 Jun 2024 19:41:46 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A41B885D4
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 19:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3636c572257so703581f8f.0
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 10:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719596503; x=1720201303; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LjSjHZSVUfsmeMx05Eww91xEKOYlToiXjeAjUmdtptM=;
 b=e0bsHeBPgmDd+Ez2ONxuae3ku5wTT3uHDI7P4+1UnttGWl+DyXudchysdVyMsBRATO
 9f/yI3qXkjn4d9fHwjZpVKVYs0t3zzdcDkdVvS0DQMBnwGXkZfi2JTrG70+47YTDtc5B
 E/u3Iojh5WLouPmGXamya3WifAowsCEsQ7QCMEpTVJbtS/gLk5X+n1HZCzeWNMww32xl
 sgy/xeAA/0+DucLUT/Wz4YmaD3npvBPLh9CAbHHKinB3N4cjQzMHS4qQLJF74kK6cGsg
 xGXxbXYdmf1hrjT2nMSAuAdkpYHdTTk1R8W8Eg8xaGk35VrL9ywZHHUr/BLPIlW0U4yK
 R5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719596503; x=1720201303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LjSjHZSVUfsmeMx05Eww91xEKOYlToiXjeAjUmdtptM=;
 b=kSUMBSB/jXODw7dJz6rIQbWazz9J+U8Yu6BMsw6SA8Vtb/4jWb8ihpN47gMisO9Pu+
 Iit0H0U064QF/DZ+CKGu76uG/Kgd90HV8mPTsP5tpt8arqTs3PqDBdWPrc9aY3xkok57
 2Sfn2dg5y/n52xkyZMIZ8X0oi2ogK7yU7QkW2iXQmZsAoLlr8zDYfEcPwmbW/Hzu0c4I
 0SABDHmPtmMDWScBUJDsli0NrnahgtYm7BcvfULxxxDC1hdqqqetyiL7Pu1PNsftQABq
 DYV70T0I0+Ijr78pbnE+PQSxQgNxtR+U+o6O9BcUUXiq2Hyd2tVzosVb6Lix4hgSBNdQ
 Zdjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiCt/2Yacxa3gHpiCPQ+6K4a+7ChQU+iCFQXAdzgxJ8+118eTSTselg6AxHk8Qj+sntPsdrQM8IY1uR1uvqYzq5VOOGA==
X-Gm-Message-State: AOJu0YzpV+16mxUE4FSWA7XSdoYHDI+F2jdj4M2BolaZSFzHZAUSNt8Q
 jAKJB8Ji4j8AuABhIuHK/O/QZSQWQyorskorYR3l9xgn1iLxWj18
X-Google-Smtp-Source: AGHT+IGXbSTgnc/GqcvnwZCvY1OeCXm5ozm4jilK8oyCSvvUGackcTcAkYfjpuqDbfyrdPIad+nv7g==
X-Received: by 2002:a5d:5745:0:b0:35f:28eb:5a46 with SMTP id
 ffacd0b85a97d-366e9469f99mr13893891f8f.10.1719596502708; 
 Fri, 28 Jun 2024 10:41:42 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4256b097bd6sm46275635e9.30.2024.06.28.10.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:41:42 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 08/12] clk: mediatek: provide common clk init function for
 infrasys
Date: Fri, 28 Jun 2024 19:40:53 +0200
Message-ID: <20240628174114.8675-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240628174114.8675-1-ansuelsmth@gmail.com>
References: <20240628174114.8675-1-ansuelsmth@gmail.com>
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

Provide common clk init function for infrasys that defaults to topckgen
driver if clock-parent is not defined. This is the case for upstream
DTSI that doesn't provide this entry.

This is needed for infracfg driver that will make use of the unified
gates + muxes implementation.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mtk.c | 22 ++++++++++++++++++----
 drivers/clk/mediatek/clk-mtk.h |  2 ++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 4a057059407..8a7a61d6740 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -707,8 +707,9 @@ const struct clk_ops mtk_clk_gate_ops = {
 	.get_rate = mtk_clk_gate_get_rate,
 };
 
-int mtk_common_clk_init(struct udevice *dev,
-			const struct mtk_clk_tree *tree)
+static int mtk_common_clk_init_drv(struct udevice *dev,
+				   const struct mtk_clk_tree *tree,
+				   const struct driver *drv)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(dev);
 	struct udevice *parent;
@@ -720,8 +721,7 @@ int mtk_common_clk_init(struct udevice *dev,
 
 	ret = uclass_get_device_by_phandle(UCLASS_CLK, dev, "clock-parent", &parent);
 	if (ret || !parent) {
-		ret = uclass_get_device_by_driver(UCLASS_CLK,
-				DM_DRIVER_GET(mtk_clk_apmixedsys), &parent);
+		ret = uclass_get_device_by_driver(UCLASS_CLK, drv, &parent);
 		if (ret || !parent)
 			return -ENOENT;
 	}
@@ -732,6 +732,20 @@ int mtk_common_clk_init(struct udevice *dev,
 	return 0;
 }
 
+int mtk_common_clk_init(struct udevice *dev,
+			const struct mtk_clk_tree *tree)
+{
+	return mtk_common_clk_init_drv(dev, tree,
+				       DM_DRIVER_GET(mtk_clk_apmixedsys));
+}
+
+int mtk_common_clk_infrasys_init(struct udevice *dev,
+				 const struct mtk_clk_tree *tree)
+{
+	return mtk_common_clk_init_drv(dev, tree,
+				       DM_DRIVER_GET(mtk_clk_topckgen));
+}
+
 int mtk_common_clk_gate_init(struct udevice *dev,
 			     const struct mtk_clk_tree *tree,
 			     const struct mtk_gate *gates)
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 4423689803a..e9c8a52ce8f 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -266,6 +266,8 @@ extern const struct clk_ops mtk_clk_gate_ops;
 
 int mtk_common_clk_init(struct udevice *dev,
 			const struct mtk_clk_tree *tree);
+int mtk_common_clk_infrasys_init(struct udevice *dev,
+				 const struct mtk_clk_tree *tree);
 int mtk_common_clk_gate_init(struct udevice *dev,
 			     const struct mtk_clk_tree *tree,
 			     const struct mtk_gate *gates);
-- 
2.45.1

