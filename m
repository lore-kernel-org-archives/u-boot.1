Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020EDC4828C
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 13:16:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F27D487B8C;
	Thu,  1 Feb 2024 14:16:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uUSAOOaO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 880AE878F5; Thu,  1 Feb 2024 14:16:18 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1848878D0
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 14:16:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4406C61EC2;
 Thu,  1 Feb 2024 13:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E94C8C433C7;
 Thu,  1 Feb 2024 13:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706793372;
 bh=z/qfER1D/Gu1DSeZjl4JQD5t9KH/De1R4fVszycRJYw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=uUSAOOaOvkhZyhLbD0dwK8gEEr1/zMYWyCfYKIeH62XOSoC4graf7px1nxQYgAkbS
 ez7Ovgp/uUjKU8UmB36MN2YTZMnrWvMojeUxfkQZX2vIEe36uuyM4hbp4LCjvtyb+M
 LPbGfB8QNCIorejDA5roSxWXpCY2xs5zSeoqV0I2qfUlpB90V6HNN8nmXnnULcj9vr
 0FC3h2dHu+kZbSMKaPFbU2al0J2PFOlUNyQYxf4LmRMyIzdOXXg09LHq64bkqgpGRW
 P3WfdGEqhnOL3IrnpCNkXo1u35yz8vs08sbwgkL9uI14nY4WvER/IiQA4iK1NiNIXj
 wGjTmwBXJ8nHg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D3625C4828F;
 Thu,  1 Feb 2024 13:16:12 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 01 Feb 2024 21:16:08 +0800
Subject: [PATCH 1/3] phy: add generic_setup(shutdown)_phy_bulk()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-ehci-v1-1-bb506cb0f64d@outlook.com>
References: <20240201-ehci-v1-0-bb506cb0f64d@outlook.com>
In-Reply-To: <20240201-ehci-v1-0-bb506cb0f64d@outlook.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706793368; l=3077;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=MQ/Dd5vqnZwQ/TgBb7U0sIhViteC8bd5Xlg1UEte2jM=;
 b=8AB5ofRwZWz2Zi6goOtETmgPOKNmP008oiOFlhBwrKzsXFX8oeFha0eqe52b9nfENiRDfGPzi
 LYWLyLR4VxcAkVT3zjDd2UQY4hF3CiGedERKcMUJK4i4sh780H0iqxq
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Yang Xiwen <forbidden405@outlook.com>

They are the bulk version of generic_setup(shutdown)_phy().

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/phy/phy-uclass.c | 33 +++++++++++++++++++++++++++++++++
 include/generic-phy.h    | 29 +++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
index 0dcfe258bc..d50ebbe3a0 100644
--- a/drivers/phy/phy-uclass.c
+++ b/drivers/phy/phy-uclass.c
@@ -528,6 +528,28 @@ int generic_setup_phy(struct udevice *dev, struct phy *phy, int index)
 	return ret;
 }
 
+int generic_setup_phy_bulk(struct udevice *dev, struct phy_bulk *bulk)
+{
+	struct phy *phys = bulk->phys;
+	int i, ret;
+
+	for (i = 0; i < bulk->count; i++) {
+		ret = generic_setup_phy(dev, &phys[i], i);
+		if (ret) {
+			pr_err("Can't setup PHY%d\n", i);
+			goto phys_setup_err;
+		}
+	}
+
+	return 0;
+
+phys_setup_err:
+	for (; i > 0; i--)
+		generic_shutdown_phy(&phys[i - 1]);
+
+	return ret;
+}
+
 int generic_shutdown_phy(struct phy *phy)
 {
 	int ret;
@@ -542,6 +564,17 @@ int generic_shutdown_phy(struct phy *phy)
 	return generic_phy_exit(phy);
 }
 
+int generic_shutdown_phy_bulk(struct phy_bulk *bulk)
+{
+	struct phy *phys = bulk->phys;
+	int i, ret = 0;
+
+	for (i = 0; i < bulk->count; i++)
+		ret |= generic_shutdown_phy(&phys[i]);
+
+	return ret;
+}
+
 UCLASS_DRIVER(phy) = {
 	.id		= UCLASS_PHY,
 	.name		= "phy",
diff --git a/include/generic-phy.h b/include/generic-phy.h
index eaab749166..2d1bf7c1ea 100644
--- a/include/generic-phy.h
+++ b/include/generic-phy.h
@@ -420,6 +420,16 @@ int generic_phy_power_off_bulk(struct phy_bulk *bulk);
  */
 int generic_setup_phy(struct udevice *dev, struct phy *phy, int index);
 
+/**
+ * generic_setup_phy() - Get, initialize and power on all phys in a phy bulk.
+ *
+ * @dev:	The consumer device.
+ * @bulk:	A pointer to the PHY bulk
+ *
+ * Return: 0 if OK, or negative error code.
+ */
+int generic_setup_phy_bulk(struct udevice *dev, struct phy_bulk *bulk);
+
 /**
  * generic_shutdown_phy() - Power off and de-initialize phy.
  *
@@ -429,6 +439,15 @@ int generic_setup_phy(struct udevice *dev, struct phy *phy, int index);
  */
 int generic_shutdown_phy(struct phy *phy);
 
+/**
+ * generic_shutdown_phy_bulk() - Power off and de-initialize all phys in a phy bulk.
+ *
+ * @bulk:	A pointer to the PHY bulk.
+ *
+ * Return: 0 if OK, or negative error code.
+ */
+int generic_shutdown_phy_bulk(struct phy_bulk *bulk);
+
 #else /* CONFIG_PHY */
 
 static inline int generic_phy_init(struct phy *phy)
@@ -514,11 +533,21 @@ static inline int generic_setup_phy(struct udevice *dev, struct phy *phy, int in
 	return 0;
 }
 
+static inline int generic_setup_phy_bulk(struct udevice *dev, struct phy_bulk *bulk)
+{
+	return 0;
+}
+
 static inline int generic_shutdown_phy(struct phy *phy)
 {
 	return 0;
 }
 
+static inline int generic_shutdown_phy_bulk(struct phy_bulk *bulk)
+{
+	return 0;
+}
+
 #endif /* CONFIG_PHY */
 
 /**

-- 
2.43.0

