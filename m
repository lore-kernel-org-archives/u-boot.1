Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5269C02198
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 02:02:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C189D803CC;
	Tue, 11 Feb 2025 03:02:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aFPmMRvT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2514E8043C; Tue, 11 Feb 2025 03:02:28 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA533800B3
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 03:02:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2fa48404207so4944393a91.1
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 18:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739239343; x=1739844143; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fFEWf0ZAwptFq5u7JBkGnQf0EaXoJhreQJ22HZXMNqE=;
 b=aFPmMRvTMUk5u4ZET+n0v48yKsEgAO9Rh+OhdJ0ciB20OgkzDmet+yE4I6hXCSxr9L
 QEypmtl1rak6gr+E6pegvIFeL4PmPOnA7GU2Bc/zdun2JIsRZ0ejoKRCmZmICwASCWYs
 DmUbRnkzuSyD+FI2uYj97JqgpMjzZ28wJ954V+HywExmWkLt/KBDV+29LwfLCRbeDBci
 dwXdWsR2xcq0ZElGGTFHSfnR8Cd28VBdRRJVcjKkJF60eTBjKeCVrUbzJtWwXgT7vxcN
 BYFAs5DvHuG4690q48W34JgHBKS7XE1poF2jAQL928Xibc+PBLpnsZf7zxqxMEjAf5j7
 QM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739239343; x=1739844143;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fFEWf0ZAwptFq5u7JBkGnQf0EaXoJhreQJ22HZXMNqE=;
 b=S7qw/4RwCsMDbTl1uBROW9pq0UzWRjkQTbHlSF7Ira4uacFZmZA9qwBlGegU50sF8N
 uYg5iTWFNtjdWb/GW1TVPgIhS8JcA200iZPN5EnrzSYhY8ru/p9j7g96jtX9tcl19yXS
 F8+K/wcuREf8DdEeUGSJAtmFLPgO5lXg+NeZ5JeGR9hHMV1foxNXzSi2j3kKjM8JtaQu
 ThtNVtRT2AiL5kLyEgY57F40+CEtFdizbeOv2B3sc7gd9U4kj+1OIscv8QlFy9JPFaRd
 qj85789WDoxnUp5w9N2EAf5OlPt7ccW8Cw4+T0KwOyooXR8PgnQwnoLi16uyC3u/Bo3V
 hdUQ==
X-Gm-Message-State: AOJu0YwSANzaRWYit4pvhX3yXEcbiXBFaUPrko9E5b6Ga/Ryrw72oprA
 7t+axeXzdB+IF9KsKxBVkcxDAs5h4pXpuq5QsE65ZqWBJZkhkVc+
X-Gm-Gg: ASbGncsE6CsJq8jVhernGnjcEZpqHmOEcxjfBWe1pvTlHOoNFfbGKqCpfkCjA5NdzQZ
 EAJyxisN+04R75tg3ebVlYOWgbp/WYKmOfZ/dDdtsWIh25AAxs9mlr31lsGk2NC08aCPoEspIX1
 h6Bw5wj68FC8+pATG8+t7bLCb+yFwqA5GxvAPQur9vY/5Fpw7TPXsFETm03mVP01L0NhK7Rw34W
 EBRimEVUo/7Jszto2vfgflRsiTkWWvjYx7M+sw5DQSU9I9ftHupBxBFPUj6Rm7Tn16HYf0D9iC7
 +pPKamqvNtX7g2g8yi4aDlLyo5U=
X-Google-Smtp-Source: AGHT+IH7G5O49JOUqYbOKm/eP0LDMwpPnd6zKoHhrQmd6D/V8nkhO6p2XXy7YLG3eKyFmKr1DMBltg==
X-Received: by 2002:a17:90b:3dc3:b0:2ee:8ea0:6b9c with SMTP id
 98e67ed59e1d1-2fa24064223mr28935825a91.12.1739239343176; 
 Mon, 10 Feb 2025 18:02:23 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:d909:c503:2e0:4cff:fe68:863])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa09a16e53sm9242393a91.11.2025.02.10.18.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 18:02:22 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] net: designware: Add npcm8xx sgmii pcs support
Date: Tue, 11 Feb 2025 10:02:01 +0800
Message-Id: <20250211020201.238924-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
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

The PCS exists only in GMAC1 and relates to SGMII interface and
is used to control the SGMII PHY.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 arch/arm/include/asm/arch-npcm8xx/gmac.h | 18 ++++++++++++++++
 drivers/net/designware.c                 | 27 ++++++++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-npcm8xx/gmac.h

diff --git a/arch/arm/include/asm/arch-npcm8xx/gmac.h b/arch/arm/include/asm/arch-npcm8xx/gmac.h
new file mode 100644
index 00000000000..f84eedddc22
--- /dev/null
+++ b/arch/arm/include/asm/arch-npcm8xx/gmac.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _NPCM_GMAC_H_
+#define _NPCM_GMAC_H_
+
+/* PCS registers */
+#define PCS_BA			0xF0780000
+#define PCS_IND_AC		0x1FE
+#define SR_MII_MMD		0x3E0000
+#define SR_MII_MMD_CTRL		0x0
+#define SR_MII_MMD_STS		0x2
+#define VR_MII_MMD		0x3F0000
+#define VR_MII_MMD_CTRL1	0x0
+#define VR_MII_MMD_AN_CTRL	0x2
+
+#define LINK_UP_TIMEOUT		(3 * CONFIG_SYS_HZ)
+
+#endif
diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 0a1fff38727..771c1672ae9 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -33,6 +33,9 @@
 #include <linux/printk.h>
 #include <power/regulator.h>
 #include "designware.h"
+#if IS_ENABLED(CONFIG_ARCH_NPCM8XX)
+#include <asm/arch/gmac.h>
+#endif
 
 static int dw_mdio_read(struct mii_dev *bus, int addr, int devad, int reg)
 {
@@ -328,6 +331,7 @@ static int dw_adjust_link(struct dw_eth_dev *priv, struct eth_mac_regs *mac_p,
 			  struct phy_device *phydev)
 {
 	u32 conf = readl(&mac_p->conf) | FRAMEBURSTENABLE | DISABLERXOWN;
+	unsigned int start;
 
 	if (!phydev->link) {
 		printf("%s: No link.\n", phydev->dev->name);
@@ -352,6 +356,29 @@ static int dw_adjust_link(struct dw_eth_dev *priv, struct eth_mac_regs *mac_p,
 	       (phydev->port == PORT_FIBRE) ? ", fiber mode" : "");
 
 #ifdef CONFIG_ARCH_NPCM8XX
+	if( phydev->interface == PHY_INTERFACE_MODE_SGMII) {
+		/* Indirect access to VR_MII_MMD registers */
+		writew((VR_MII_MMD >> 9), PCS_BA + PCS_IND_AC);
+		/* Set PCS_Mode to SGMII */
+		clrsetbits_le16(PCS_BA + VR_MII_MMD_AN_CTRL, BIT(1), BIT(2));
+		/* Set Auto Speed Mode Change */
+		setbits_le16(PCS_BA + VR_MII_MMD_CTRL1, BIT(9));
+		/* Indirect access to SR_MII_MMD registers */
+		writew((SR_MII_MMD >> 9), PCS_BA + PCS_IND_AC);
+		/* Restart Auto-Negotiation */
+		setbits_le16(PCS_BA + SR_MII_MMD_CTRL, BIT(9) | BIT(12));
+
+		printf("SGMII PHY Wait for link up \n");
+		/* SGMII PHY Wait for link up */
+		start = get_timer(0);
+		while (!(readw(PCS_BA + SR_MII_MMD_STS) & BIT(2))) {
+			if (get_timer(start) >= LINK_UP_TIMEOUT) {
+				printf("PHY link up timeout\n");
+				return -ETIMEDOUT;
+			}
+			mdelay(1);
+		};
+	}
 	/* Pass all Multicast Frames */
 	setbits_le32(&mac_p->framefilt, BIT(4));
 
-- 
2.34.1

