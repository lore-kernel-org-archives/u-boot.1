Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87979C52D71
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 08:59:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33BF988B9E;
	Fri,  9 Aug 2024 10:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="iguhxrl3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D79188B81; Fri,  9 Aug 2024 10:59:14 +0200 (CEST)
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com
 [203.205.221.155])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 461EF88BD6
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 10:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hanyuan-z@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1723193937; bh=/sWW1BfWduQl8GYbmsi545q/7UuaAI4DH7Gg2crcdGU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iguhxrl3SW+itvGBOlfop9xAJkEoHMQUgNDm0y8bmOIpuZdn8J//UMTaAwPsqKTrm
 k9jVVFwIpl87DP5gP+/2E9FpcBiP8XmyqUOAnUam0NpArcwvd1rf0jdWpEsmIU8C5M
 bnZTxMfLSW42nIw8G0ldNQMr+AN/UqkLV8Ojq3ng=
Received: from hyz-wsl.www.tendawifi.com ([166.111.226.87])
 by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
 id EA28703C; Fri, 09 Aug 2024 16:58:34 +0800
X-QQ-mid: xmsmtpt1723193933te4k78332
Message-ID: <tencent_1A122D8E7E00526399AF58CB8DCDBE7FA807@qq.com>
X-QQ-XMAILINFO: MYcyYH/A/+tCdSbXuOhrCfoywNrUemqfk0cra+/FZF31wxmOvaL1M/qnPdsOUu
 o8An2VMYrIp1ELQm5lUjjgJ5JwdFl1r0UNCmMudLHUllWHCKe0UosjR0AO61yAEOo78X0DmjKMbs
 GmLGSvRZNNNyM7b60Akvd+PdGwOYrXwnnbk0T2zw8fSjwWG8tgBI+ICJdI67RldLxGctGElIfRro
 ml/wBuHaH/XayPb1d9pPj8q8r8W8uF88bHcNk1DdwRJjEZXfZPsLtnaDlBEipYdSRm2SAebF0ALB
 hLI4c1wWnZt4u8/Kl94H+SZzFBFWmlmkdanqzhHVea0A0ZOatRlHAqUpMKbBYVwTby/gr421iQpT
 iJysewx055HaAwq3e6P1cPwpEii13GmlrOsePzxgxHp9LNPrPgyJryqGiIPG+1eQj6miicSWfCIg
 4D99A+f7DHUUsPFVL9uXmUleyLiNsGOmCzpq+R+uok/tpcDolX8LiTiKHvbom8PwqSYeK/5zlwmP
 hvh+zr/lTN8A94uWcoFJk/IkBrRAaNOI+Agc4CHdUL7dKcTVxopRJx7j8MWUfOrbEjHIcm8iYog5
 n5nAOs7rKZ6YMZsEt9PgX7Sp5FQj5wwsL5W2sJqQ3YftoTjMHjs2W2iirAaU2o6T+H680f+S8IMI
 97I2qpII/P3eRM7nds/A+8o6zAc8CKXD/DrZMlCmOnVq/SUouxEZwfLDpGYp2NLFLQGXex8e3UBm
 R4Ql3RT8lOor40czDaKeHyLZqnJbrrfXf1iNr5CeRov4fjoADGGaCG6I9MdAUu2sr8dQdLXs96eo
 /g1b3QtqvOUfufLlFW3jyrcbphSBkFjROae8pxgpXRBVLBNsxuwDjd3mnXdSkc06QUHq9XeMbm6X
 pNDz9jX6qol8KQhVJw3DTbsKH+UfXaJnwTQZ5vcVq1c9F5+vkm7XekAW0Vz3dH80k0wc/RA1T38t
 i8J6Vn+60UAeJ9V+kvd4y9jFLrmkZgxBrb0ancLEeD/kI5397VJlHnnPusx3/TC++sDV7pUs7Xh6
 SJulJQavxKtT0U8WZbItiMsFui2fA=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Hanyuan Zhao <hanyuan-z@qq.com>
To: u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Hanyuan Zhao <hanyuan-z@qq.com>,
 Hanyuan Zhao <zhaohy22@mails.tsinghua.edu.cn>
Subject: [PATCH 5/8] net: dc2114x: remove unused lines and change the var and
 print types
Date: Fri,  9 Aug 2024 16:56:58 +0800
X-OQ-MSGID: <20240809085701.22183-5-hanyuan-z@qq.com>
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

This commit fixes a problem that even though the network card does not report
any issues in transmitting a setup frame, the driver prints the error status
every time. Let's set it for debug use.

Signed-off-by: Hanyuan Zhao <zhaohy22@mails.tsinghua.edu.cn>
---
 drivers/net/dc2114x.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dc2114x.c b/drivers/net/dc2114x.c
index 0b3000cc1d..8a285742a1 100644
--- a/drivers/net/dc2114x.c
+++ b/drivers/net/dc2114x.c
@@ -311,7 +311,7 @@ static void send_setup_frame(struct dc2114x_priv *priv)
 	}
 
 	priv->tx_ring[priv->tx_new].buf = cpu_to_le32(phys_to_bus(priv->devno,
-						      (u32)&setup_frame[0]));
+						      (phys_addr_t)&setup_frame[0]));
 	priv->tx_ring[priv->tx_new].des1 = cpu_to_le32(TD_TER | TD_SET | SETUP_FRAME_LEN);
 	priv->tx_ring[priv->tx_new].status = cpu_to_le32(T_OWN);
 
@@ -326,7 +326,7 @@ static void send_setup_frame(struct dc2114x_priv *priv)
 	}
 
 	if (le32_to_cpu(priv->tx_ring[priv->tx_new].status) != 0x7FFFFFFF) {
-		printf("TX error status2 = 0x%08X\n",
+		debug("TX error status2 = 0x%08X\n",
 		       le32_to_cpu(priv->tx_ring[priv->tx_new].status));
 	}
 
@@ -355,7 +355,7 @@ static int dc21x4x_send_common(struct dc2114x_priv *priv, void *packet, int leng
 	flush_dcache_range((phys_addr_t)packet, (phys_addr_t)(packet + RX_BUFF_SZ));
 
 	priv->tx_ring[priv->tx_new].buf = cpu_to_le32(phys_to_bus(priv->devno,
-						      (u32)packet));
+						      (phys_addr_t)packet));
 	priv->tx_ring[priv->tx_new].des1 = cpu_to_le32(TD_TER | TD_LS | TD_FS | length);
 	priv->tx_ring[priv->tx_new].status = cpu_to_le32(T_OWN);
 
@@ -426,7 +426,7 @@ static int dc21x4x_init_common(struct dc2114x_priv *priv)
 		priv->rx_ring[i].status = cpu_to_le32(R_OWN);
 		priv->rx_ring[i].des1 = cpu_to_le32(RX_BUFF_SZ);
 		priv->rx_ring[i].buf = cpu_to_le32(phys_to_bus(priv->devno,
-					     (u32)net_rx_packets[i]));
+					     (phys_addr_t)net_rx_packets[i]));
 		priv->rx_ring[i].next = 0;
 	}
 
@@ -445,9 +445,9 @@ static int dc21x4x_init_common(struct dc2114x_priv *priv)
 	priv->tx_ring[priv->tx_ring_size - 1].des1 |= cpu_to_le32(TD_TER);
 
 	/* Tell the adapter where the TX/RX rings are located. */
-	dc2114x_outl(priv, phys_to_bus(priv->devno, (u32)&priv->rx_ring),
+	dc2114x_outl(priv, phys_to_bus(priv->devno, (phys_addr_t)priv->rx_ring),
 		     DE4X5_RRBA);
-	dc2114x_outl(priv, phys_to_bus(priv->devno, (u32)&priv->tx_ring),
+	dc2114x_outl(priv, phys_to_bus(priv->devno, (phys_addr_t)priv->tx_ring),
 		     DE4X5_TRBA);
 
 	start_de4x5(priv);
@@ -493,7 +493,6 @@ static struct pci_device_id supported[] = {
 
 static int dc2114x_start(struct udevice *dev)
 {
-	struct eth_pdata *plat = dev_get_plat(dev);
 	struct dc2114x_priv *priv = dev_get_priv(dev);
 	int rval;
 
-- 
2.39.2

