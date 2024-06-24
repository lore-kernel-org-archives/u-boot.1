Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD74C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:06:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 943A888405;
	Mon, 24 Jun 2024 23:04:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kEGVKmqH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C18C6885A4; Mon, 24 Jun 2024 23:04:48 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5976888590
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-36279cf6414so3854007f8f.3
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719263085; x=1719867885; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XNqKnoO1M7Vvxa76ER/5BqBkhfciKUzVHEdydKoIgrI=;
 b=kEGVKmqH04Of3jw0W1dxQmIok4duNiTv1WVUT4SObGr0NwLHw7OQdPAhKMRC8/+7CO
 UirpAS39Wz1dCn9GORBqJu7n7Vm7vnJTwSnxEYlCaXdr2hv1IQtq1C7AOLjWnh0F152k
 bFHUf3m92VpXU/FsT1NnRgYKwV0I8JsQb9ue0ruWMakdQdk7L3Nov/GI7cBm1d6Vbra3
 XjkubNpc6pvBBFyrzuAwsYvIuTAxfribBWZbHw9nEolOno8eP/CZrq2rMQM1880mmo7E
 4ro1vYiVaGc7/25AADdKEfjDtG5FoH4IFQ0hcwpVaRGfPJH3AqcQZEeHwEnmSRwYHlmO
 q81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719263085; x=1719867885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XNqKnoO1M7Vvxa76ER/5BqBkhfciKUzVHEdydKoIgrI=;
 b=J8jYuNzubIsAKc3xMPMAYiexUwyN/QsYURErzy08hTeEN6ZbYXDAKJ2QzfClkFeukN
 R653BZclCnvCy5J0JNLVzVTFIKVje646IdQlPGs3uawLOIft+S9FBXVS9HFyN9j3aYVF
 e/JfACuSwvi/kdSBCjBbBq25yPWZv6EGYk2/S1IWWHkPQVLs6p3txIhCG8BGuLJkc/Dl
 CXPRAuASb3uWdg35M1Adu3ZGI1o6qusgqvsYOKOf5h4bp7bQANKub95eCRhMwyTK0WlZ
 ZBfNLdpQNQgNCG6LLI+Es6CWxid6wEZ206rdFKqlgJlubvG7efjFCYbBBJCddKFTaWqb
 fH4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVNtLy3xpahbqdQPvN9xgPnMYjs7kSh9AaYledPnRM44NT1tHlEsi4XF3YQgYMx4+dD8w3vtUcRBCMiX4RLE4if3DtBg==
X-Gm-Message-State: AOJu0YxVTIwNeaOKg63tfcna+wzgFZPebJCEycfpzALDe2boGxb5eLCy
 /35i5lLMLIuRFvanfY6VzS97+EzBhY7cQ3KNbV8wgkV03wLqIK9t
X-Google-Smtp-Source: AGHT+IFjQs6WtX2SWx45UU3FOmc7+43R9g3mb4/0jLcKmpHOI+9d6m2dYPmL4WcSZxmeoSyZIZL2iw==
X-Received: by 2002:adf:f7d2:0:b0:366:ddc2:a14a with SMTP id
 ffacd0b85a97d-366e94d6a97mr2914196f8f.40.1719263084735; 
 Mon, 24 Jun 2024 14:04:44 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3664178f5f7sm10968228f8f.19.2024.06.24.14.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:04:44 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Heiko Schocher <hs@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, John Crispin <john@phrozen.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sergei Antonov <saproj@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Marek Vasut <marex@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH v4 12/14] pci: mediatek: make pcie-phy optional for gen3
Date: Mon, 24 Jun 2024 23:03:38 +0200
Message-ID: <20240624210418.19324-13-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240624210418.19324-1-ansuelsmth@gmail.com>
References: <20240624210418.19324-1-ansuelsmth@gmail.com>
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

Set pcie-phy optional for PCIe gen3. MT7988 doesn't require it and
making it mandatory prevent the driver to correctly probe.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/pci/pcie_mediatek_gen3.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pcie_mediatek_gen3.c b/drivers/pci/pcie_mediatek_gen3.c
index 673813b8b75..0149edae0bf 100644
--- a/drivers/pci/pcie_mediatek_gen3.c
+++ b/drivers/pci/pcie_mediatek_gen3.c
@@ -284,9 +284,8 @@ static int mtk_pcie_power_on(struct udevice *dev)
 
 	pcie->priv = dev;
 
-	err = generic_phy_get_by_name(dev, "pcie-phy", &pcie->phy);
-	if (err)
-		return err;
+	/* pcie-phy is optional (mt7988 doesn't need it) */
+	generic_phy_get_by_name(dev, "pcie-phy", &pcie->phy);
 
 	/*
 	 * Upstream linux kernel devine these clock without clock-names
@@ -308,13 +307,15 @@ static int mtk_pcie_power_on(struct udevice *dev)
 	if (err)
 		return err;
 
-	err = generic_phy_init(&pcie->phy);
-	if (err)
-		return err;
+	if (pcie->phy.dev) {
+		err = generic_phy_init(&pcie->phy);
+		if (err)
+			return err;
 
-	err = generic_phy_power_on(&pcie->phy);
-	if (err)
-		goto err_phy_on;
+		err = generic_phy_power_on(&pcie->phy);
+		if (err)
+			goto err_phy_on;
+	}
 
 	err = clk_enable(&pcie->pl_250m_ck);
 	if (err)
@@ -348,7 +349,8 @@ err_clk_tl_26m:
 err_clk_pl_250m:
 	clk_disable(&pcie->pl_250m_ck);
 err_phy_on:
-	generic_phy_exit(&pcie->phy);
+	if (pcie->phy.dev)
+		generic_phy_exit(&pcie->phy);
 
 	return err;
 }
-- 
2.45.1

