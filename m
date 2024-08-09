Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC93FC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 08:59:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C699F88BB6;
	Fri,  9 Aug 2024 10:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="JtERtB6R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52CAE88BD2; Fri,  9 Aug 2024 10:59:10 +0200 (CEST)
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com
 [203.205.221.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DAD888AF4
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 10:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hanyuan-z@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1723193934; bh=Z1eHy0CgabbN59QbmZAAX8bexKw9UkXCKufX4ULY5j0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JtERtB6RcRszS7zg08k4taz2JrISRvuqrbkcAsunJuTjVDF8J6VBbAtJG81XkP+ZU
 +VJB3rEP9c9JgUbXaxztAc4gz6+fTs6jEdwTJGOmvb2DAeCLSbC7pnc0lWv1irNAug
 7IRdlKgH4eJoCICvWd5n+8oVcvV8v+nV+0QivzfY=
Received: from hyz-wsl.www.tendawifi.com ([166.111.226.87])
 by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
 id EA28703C; Fri, 09 Aug 2024 16:58:34 +0800
X-QQ-mid: xmsmtpt1723193930tm2hsj61k
Message-ID: <tencent_AAA14493C30360CC18ED4BD3D27DB3EDFF05@qq.com>
X-QQ-XMAILINFO: OUUXHEo9i1ukkWyaY0ggVBXe7NQGUxrbEEhLnYxpMYlva7ro24F/w6OoUZBmTD
 Ymol/GxoWZGvTNl1d3EWO+GWYtZUs+6flcJrUtaaBrM8v23WSk/1W+Fa5WrBezxf/8Y2Xnpfkgel
 Fyk3AaoO9EREamW6UmZcZPGSioTG5xB8VseUu5jo0F61hiasXCMKF7vnDkQlMlvjMY0vS2PsUd3o
 7XjKu2A/rETkZVdwqmxoSjk3HvyV00meZo1P62g/kmqPmZbqrAhwuvcoBUJ8hfP3aXfXUJBHtbIt
 Zu1tpEGzibPztuaku1bYM+snabZr/bdD3Cr6TGNTUkFOlVw97+FMF7n7x1TlI0acfI8lhpmXjTON
 6hParoHhS+LK9XobAnI1oBM9K/SktUMYxtOBJmAsl7zjCbeI+zFrS3UnT3MOW0mR5hiEHWoJeZRh
 XP315T/QwItzun9UEL0croI6YA3DaGX0S/CqZKpBsmO4HVQqtqFMRIx7/TnMEC7cUCqsIjGftBY3
 0t+G1mxCemI/pZNe2mIiz0MLHhQk4TKF1alXRelGmvwCQiK1GHi8eilxmHtwYWRWZz/hpE/MTrIz
 mAh+5H9hupvl9y5rm8DFUolVaJ8BTR5XJY2EN8EHGXdA4hOT8nl6I4KlfHDshtSvtMsBpngUmAvt
 NUnuBcl3bdAp0hTT+mumnVz1r8yo54vV18KbPXBu3GAjW/qmwQC99CwwNz2QgE3jj9YmopTC4n86
 UhCN52OBL0WjfGYOhi28VkMlQafPyOSVpbljdR6j4ySUw/+smgOsC8sbfjVITSa/+PZ52vKuhWIF
 mHXk2loRLkI6koCRBl8LqV74akYnI+j2AcIsOtxeYfRq0hiAvO2vLwsM92H8qOerjofbtKEhTP6b
 gvk+lRrVuZGOjP3vZhq4Brr7sXtovE17gUqwS2LqNxyiHvx7/6cB4JCvtepBEmJAAUowK0EK+Tqe
 3aeTJNyrtAU6aQViijkdWiIQyK/+juVLGoyR2N+n4iN2G5Vk1N4dj0Cm3TFHRrETYoEPgsSGs=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Hanyuan Zhao <hanyuan-z@qq.com>
To: u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Hanyuan Zhao <hanyuan-z@qq.com>,
 Hanyuan Zhao <zhaohy22@mails.tsinghua.edu.cn>
Subject: [PATCH 4/8] net: dc2114x: add support for CPUs that have cache
 between the memory and the card
Date: Fri,  9 Aug 2024 16:56:57 +0800
X-OQ-MSGID: <20240809085701.22183-4-hanyuan-z@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809085701.22183-1-hanyuan-z@qq.com>
References: <20240809085701.22183-1-hanyuan-z@qq.com>
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

This commit adds support for the MIPS and LoongArch CPUs, which would use cache
after they jump into U-Boot. This commit requests the CPU to return the
addresses in uncached windows and flushes the cache in need, to make sure the
memory between the CPU and the network card is in consistency.

Signed-off-by: Hanyuan Zhao <zhaohy22@mails.tsinghua.edu.cn>
---
 drivers/net/dc2114x.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dc2114x.c b/drivers/net/dc2114x.c
index cf9f78163a..0b3000cc1d 100644
--- a/drivers/net/dc2114x.c
+++ b/drivers/net/dc2114x.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include <asm/io.h>
+#include <cpu_func.h>
 #include <dm.h>
 #include <malloc.h>
 #include <net.h>
@@ -94,9 +95,17 @@ struct de4x5_desc {
 	u32 next;
 };
 
+/* Assigned for network card's ring buffer:
+ * Some CPU might treat these memories as cached, and changes to these memories
+ * won't immediately be visible to each other. It is necessary to ensure that
+ * these memories between the CPU and the network card are marked as uncached.
+ */
+static struct de4x5_desc rx_ring[NUM_RX_DESC] __aligned(32);
+static struct de4x5_desc tx_ring[NUM_TX_DESC] __aligned(32);
+
 struct dc2114x_priv {
-	struct de4x5_desc rx_ring[NUM_RX_DESC] __aligned(32);
-	struct de4x5_desc tx_ring[NUM_TX_DESC] __aligned(32);
+	struct de4x5_desc *rx_ring; /* Must be uncached to CPU */
+	struct de4x5_desc *tx_ring; /* Must be uncached to CPU */
 	int rx_new;	/* RX descriptor ring pointer */
 	int tx_new;	/* TX descriptor ring pointer */
 	char rx_ring_size;
@@ -276,7 +285,12 @@ static int read_srom(struct dc2114x_priv *priv, u_long ioaddr, int index)
 
 static void send_setup_frame(struct dc2114x_priv *priv)
 {
-	char setup_frame[SETUP_FRAME_LEN];
+	/* We are writing setup frame and these changes should be visible to the
+	 * network card immediately. So let's directly read/write through the
+	 * uncached window.
+	 */
+	char __setup_frame[SETUP_FRAME_LEN] __aligned(32);
+	char *setup_frame = (char *)map_physmem((phys_addr_t)virt_to_phys(__setup_frame), 0, MAP_NOCACHE);
 	char *pa = &setup_frame[0];
 	int i;
 
@@ -337,6 +351,9 @@ static int dc21x4x_send_common(struct dc2114x_priv *priv, void *packet, int leng
 		goto done;
 	}
 
+	/* Packet should be visible to the network card */
+	flush_dcache_range((phys_addr_t)packet, (phys_addr_t)(packet + RX_BUFF_SZ));
+
 	priv->tx_ring[priv->tx_new].buf = cpu_to_le32(phys_to_bus(priv->devno,
 						      (u32)packet));
 	priv->tx_ring[priv->tx_new].des1 = cpu_to_le32(TD_TER | TD_LS | TD_FS | length);
@@ -533,7 +550,8 @@ static int dc2114x_recv(struct udevice *dev, int flags, uchar **packetp)
 	if (!ret)
 		return 0;
 
-	*packetp = net_rx_packets[priv->rx_new];
+	invalidate_dcache_range((phys_addr_t)net_rx_packets[priv->rx_new], (phys_addr_t)(net_rx_packets[priv->rx_new] + RX_BUFF_SZ));
+	*packetp = (uchar *)net_rx_packets[priv->rx_new];
 
 	return ret - 4;
 }
@@ -597,6 +615,9 @@ static int dc2114x_probe(struct udevice *dev)
 
 	priv->devno = dev;
 	priv->enetaddr = plat->enetaddr;
+	priv->rx_ring = (struct de4x5_desc *)map_physmem((phys_addr_t)virt_to_phys(rx_ring), 0, MAP_NOCACHE);
+	priv->tx_ring = (struct de4x5_desc *)map_physmem((phys_addr_t)virt_to_phys(tx_ring), 0, MAP_NOCACHE);
+
 	return 0;
 }
 
-- 
2.39.2

