Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F6CC87FD2
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 05:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E816D83BD2;
	Thu,  7 Aug 2025 07:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SED6gD1v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 403C383BDF; Thu,  7 Aug 2025 07:29:15 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E53A83BC9
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 07:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2406fe901fcso6152085ad.3
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 22:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754544536; x=1755149336; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lg3NMZvC4u7rUhSAg1d7YNCwHdT9VdSv/A65meP55u4=;
 b=SED6gD1v36DQ3wVayXJsByF45RRXfcTsdKs/n7Su6MxBCxt0nNo8dYgxlz5HuIqWzk
 cF2l2EQY5F6oiHCZCVIwVQEdEJVd9HQo4/1Q7rMihyS/O/Lai+4MRWgejdNzKmj2KKjN
 pq67AQ1jnqyoj48nA1Nd1uq/Q/kV2SbILxL/Sb6Mix1aCZ6Y9qiUD6WfBS/LBRbX/xXW
 acBY2lziGSwteBlGHVh7kLFKldplv1PqStNU3mqCajhgzqfiZbLyxp3CF7HczvMr0oqf
 wgFsd5VDL6RcMWCNg9VCRBYxDrLUjnTw/zjMe5WzhuVRV1mdIWcmL0XyriqU8aOzAtwu
 /Cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754544536; x=1755149336;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lg3NMZvC4u7rUhSAg1d7YNCwHdT9VdSv/A65meP55u4=;
 b=FJZi1BYEJqytpsjvdV4ujW80PSIAyj6ZlvLz584qax3Y//tB1ljLT4MN93DtHW4yjf
 6731DebU6dXOjz26bMe+pefz63GQQzjgFBBlJei1seJ8wI6mGZgJqC8TYZcQf2y/df1Z
 qrmEgJuSOx9Wt1zINZT+Htb0bIKhLhtOZjuPHMLvZG02sPz+DH7gR92YfbHIVT4n/9Y2
 XP6gdsN8ym4eNMKrt0yN7x8wL/Vh5POsYf8zTNPC4HCpLr55NB5QC0ed0U5KtLnM2c1w
 vVbPlINZ26cfa+uyczy/jhMHTRjosegIY/9CYoIe/pkbxa9VOXVcdHqaEl+tVzupOyiq
 lb0w==
X-Gm-Message-State: AOJu0YyCZt6pQirSKNLHqFsisP35VsbUfvZazkXYySQSYaY6AclcISNJ
 J+0P9b+/mTA/eZmK1Y2pK0Cz4wV9Ir8C+XNVSu2SxjCoWQD8ZRxijI04
X-Gm-Gg: ASbGncur2WIUD/Mg37eLQysC9/aEGbvgdTJsChaoU0imRIVyjzogyHbeg26rRlz9iQ9
 I4G+Z3/lCvEtN6y+vUJVBwLVfY0ChkhiMRbg+KpJ0jp6SHnjR95rbTyYEgXUmfM1IFlmfRvBytu
 lP5KW9wl9pRy5//J6kHN85AeQ8nlVvQpSTOeoSv3xRxzpGlh44DeAGRYHqbossQ3AtgzY5kJVqb
 rCMKCU+te//1qQayTPVs/3qHl4azF9G11kKcRYFGP2Y/nS7u2IOWS72OrwW1wbXICjfozVyaKkd
 Eu2hWzK8+g0nU4mbLqt6WraNgi9wPlZPug4ZiUZpPMKztqEFGrwFB8DUf+4syeDoP7MEeDJNixJ
 JMIC6MLORHCA4XeH0SBpSYMrKvtL9brR7wQ==
X-Google-Smtp-Source: AGHT+IFK/+DKmAdRV0MfyFUmS6e0/Hcx3WYbqwv4h6pejnltkMPo7nmeK6kUx1ZCL7NLdbqNvY/Wrw==
X-Received: by 2002:a17:902:e54b:b0:240:7fcf:ced7 with SMTP id
 d9443c01a7336-242a0aa6bd7mr82459105ad.21.1754544535759; 
 Wed, 06 Aug 2025 22:28:55 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:400:60db:2e0:4cff:fe68:863])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e7d8sm174192685ad.42.2025.08.06.22.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 22:28:55 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com
Cc: u-boot@lists.denx.de,
	Stanley Chu <yschu@nuvoton.com>
Subject: [PATCH v2] net: designware: Fix get_timer value overflow
Date: Thu,  7 Aug 2025 13:28:32 +0800
Message-Id: <20250807052832.2169422-1-JJLIU0@nuvoton.com>
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

get_timer returns a ulong value representing system time in ms.
On a 64-bit system, this ulong value is 64 bits long. However,
the driver stores it in a 32-bit unsigned integer, which overflows
after 49 days up time, causing the driver to get an incorrect time.

Replace the unsigned int variable with a ulong type to properly store
the value returned by get_timer.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/net/designware.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index fce3ef910cb..7ecedc3d7f0 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -486,7 +486,7 @@ static int dw_adjust_link(struct dw_eth_dev *priv, struct eth_mac_regs *mac_p,
 
 #ifdef CONFIG_ARCH_NPCM8XX
 	if (phydev->interface == PHY_INTERFACE_MODE_SGMII) {
-		unsigned int start;
+		ulong start;
 
 		/* Indirect access to VR_MII_MMD registers */
 		writew((VR_MII_MMD >> 9), PCS_BA + PCS_IND_AC);
@@ -532,7 +532,7 @@ int designware_eth_init(struct dw_eth_dev *priv, u8 *enetaddr)
 {
 	struct eth_mac_regs *mac_p = priv->mac_regs_p;
 	struct eth_dma_regs *dma_p = priv->dma_regs_p;
-	unsigned int start;
+	ulong start;
 	int ret;
 
 	writel(readl(&dma_p->busmode) | DMAMAC_SRST, &dma_p->busmode);
-- 
2.34.1

