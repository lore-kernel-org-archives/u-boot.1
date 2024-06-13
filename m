Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6948C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 12:46:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56E8F88935;
	Thu, 13 Jun 2024 14:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YIbwGa7Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3867888F2; Thu, 13 Jun 2024 13:10:36 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3741883D3
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 13:10:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57a1fe6392eso1048269a12.0
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 04:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718277034; x=1718881834; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iRxf/+F7nsIuagKDotcjsgjmEVW42+7OqG/ceBsX7sA=;
 b=YIbwGa7QdM2TttoZ9rNFDkqnPl9GQxafKq19WXp1au/0dmmHf6TY7+QhDQJPNscqpf
 HjLAvYPHmTfDy4xEzFXPDivFqFOkwaiww0+Xu6h9By3Su9EHc3uXUdxU4/5Tw4mncfPI
 rH3xYV5mSx/wLCQU3qu7ugIVjatbM8S4wmpZLewtzTt4Ss5lOieD4FcqSPG1aOn2vYnr
 Z2anuVXqZcEvntfBnbELkD66TTwrXmjdCSG+TjC/gVAkrYJ/+CzyQ7NsevbE2sE3dmu8
 1lI10pwPfZLNpJ3MpcgI7AUBcWcK3SW8f7+3Qfl3o8JwdLlartgOswJm4KXTWHuPIaWh
 Ld6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718277034; x=1718881834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iRxf/+F7nsIuagKDotcjsgjmEVW42+7OqG/ceBsX7sA=;
 b=s9K6zAc398pK47zZi3vHDiK/6z2QftaAHQa+AI4wQAJqCJKS+vucS23VmcPsF2oYz+
 fyv8Qhld6yjp6UuBwzm+tCjbMKgaTvBKGl40OWnzkaOGT0nVoha2G/kzwoLJhniR+Tov
 qcObJTX2PJokJiLh9z1i9oihg2rAI4XRiZRyWG4mebarPOf8MQYD5Sox6PIVhM0EQt2s
 vdZ7CT6wDAXxRnp9Kf297Od+oJRsk/m9DX49PRRH6sCdC0vL8s6kq9b1NgX/ak47VGCw
 0jSbueiBr86Nac+F1EIjVyUdBW3ZgbhQcIhyqNa9hKPJHYrw24naAXelBbgoFE8oVVGG
 l8Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+Xn3ye4NsN2WKhjSvGKVVRuEAXY1odKeulId3CXu2FjnYVH9qHFh0bUklaWPiX+jQvQx6gZ1i76UaQDc0M3J+ksyKXQ==
X-Gm-Message-State: AOJu0Yybwx9M4N+9KIEMNk1MrHlVFOXkUvtzBoXMYEJ2HWt6m2Rm2ll/
 4m01zA6fuB5mLawWTsI1uWFybOOnRTB2PtZ+Tl2AhsITviriiE4r
X-Google-Smtp-Source: AGHT+IHRc1F58ABT84MbWFmqyVIDK4RsVcegrDKAD0ZcpixjkgU/eaVcMfyYNfHQqPNcl+PAyNJplw==
X-Received: by 2002:a17:906:3710:b0:a6f:10d0:fb85 with SMTP id
 a640c23a62f3a-a6f47f7d121mr272323566b.19.1718277034018; 
 Thu, 13 Jun 2024 04:10:34 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a6f56f416dfsm60580366b.164.2024.06.13.04.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 04:10:33 -0700 (PDT)
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
 Jagan Teki <jagan@amarulasolutions.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sergei Antonov <saproj@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Mark Kettenis <kettenis@openbsd.org>, Sumit Garg <sumit.garg@linaro.org>,
 John Crispin <john@phrozen.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Minda Chen <minda.chen@starfivetech.com>, Marek Vasut <marex@denx.de>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Stefan Roese <sr@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Sam Shih <sam.shih@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH v2 12/14] pci: mediatek: make pcie-phy optional for gen3
Date: Thu, 13 Jun 2024 13:09:30 +0200
Message-ID: <20240613110949.11076-13-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613110949.11076-1-ansuelsmth@gmail.com>
References: <20240613110949.11076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Jun 2024 14:43:53 +0200
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
2.43.0

