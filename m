Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C133CC52D71
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 08:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A742188B89;
	Fri,  9 Aug 2024 10:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="ISpCesgL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69ACE88AF4; Fri,  9 Aug 2024 10:59:18 +0200 (CEST)
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com
 [203.205.221.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B48FF88BCD
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 10:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hanyuan-z@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1723193953; bh=kWrVDZ+JEXFDm+b2501J40GY11doJB+bZG7d0g7pxJc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ISpCesgLnjX0Bel25qbzF3rt2/K5HjhjUpAgBnzEPqeXOWj119h9lXfyU8+oO+U9w
 nWFn+BieclyRHY2OyU9Av8+sn78/Wzatwd/Qm2Wl+Qob7yXHYDjugsw+ce7Q2B7Sf4
 CwDFwIF08/J8Jx8HQEjSSAw7nMH6eWYd1oadsy6k=
Received: from hyz-wsl.www.tendawifi.com ([166.111.226.87])
 by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
 id EA28703C; Fri, 09 Aug 2024 16:58:34 +0800
X-QQ-mid: xmsmtpt1723193941tf4www44g
Message-ID: <tencent_57E89FA08481630DE0DE98E0EBC8B269B305@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujAVUbdhU51/kUym5LtFJwUtdpSZY+lp5tE4FlMsFB6AWgdhy1+i
 moCnI1CGi/FbThmRgMlbrgMer3bMbwU57HWjkaV4GPnvZ7I1Mt95L8mEPNNNsNy+kf7wO8o7L2qV
 n+3UXTXWQ6FS1mMs+fKRPdJ+o4OnNJDfRQN/wDRstKV1q0+zG6TCZwnkO+SSQgNnSdWHy/usmydC
 /+GhPOD0URut3uzxZntjgP8ph43tHBnWYMj/5FQGhWbKDj0SKfsycwSRjm6C/Mq5WH0PjXknSlax
 j27wA4/GERQUTumyzn6frLOKuNomVcfpLw3IKBPU4fY2x/4ZL4tfmKLJ11rBLqo/gglbf6mlAjUk
 y4AzdJFoAcYGWPa8yDgKWv2PmcqHG+OnomxlxkAtGNnDgJQSdrJ9GOfkMz5J/ImrQW64AUdn+gjL
 xC5oD4bkId/jbUpTMRFvPpx7jTuzKxX4LsOdH7PXz6TLinkQES6n8SQ2c9wffpRv4ev2PxlVe4G3
 h6D7euN+ls1CCglxT/LPozvbFRPVW65zzC89tZDm3oLqoiAEp48y6BTEft5Pdiqno3SOYzVhICBx
 4r+yVKZjz4fEc5oTVW8nAZkV8qfwC9mH9SuXU7YzUqSpw/yrRX9L0kiLfGg7bnyHcwNuTKzmJhMS
 2xKmCre1cJoZVslHiyJNXBbAYHLLS+KTbnq1ZUGLHIfpk7wdPEkcAg9viwMRgNdoRUI3/Yh6XEty
 zqrZ7TBD+Kwy0BsU2y2lQzAaHmQ24NNnOiUnzE54coLWNe73XoxK3wPfEK5q0t9/D8wudcetV+ga
 H5P4ZwxU0IpdgnbzGo8Yjhk3gAdtbtuz3fbZaQ24nfCr6gv/HxoxFC6bpB24CBQbVDYsJhn2IJnA
 KaXs7OOVIalunI3wzhl5TzIiUVB3uMacHc8jk5TUu+EMhY2FV8yjYoiuthJy7zWFjeiEsd2rgXAp
 UpEIw/2t2WrCdUcCgEtsppSgJJJT/HrQqbvuW1PKxdnoyh9LhMK7Zt1t6bdKXC05SCs0d3vJ37xg
 Ex0kxVk6yBMiWLcDcLIoko94Pn/xE=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Hanyuan Zhao <hanyuan-z@qq.com>
To: u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Hanyuan Zhao <hanyuan-z@qq.com>,
 Hanyuan Zhao <zhaohy22@mails.tsinghua.edu.cn>
Subject: [PATCH 7/8] net: dc2114x: allow users to decide how to tx packets
 according to IP core
Date: Fri,  9 Aug 2024 16:57:00 +0800
X-OQ-MSGID: <20240809085701.22183-7-hanyuan-z@qq.com>
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

Some IP cores of dc2114x or its variants do not comply so well with
the behaviors described by the official document. Originally this
driver uses only one tx descriptor and organizes it as a ring buffer,
which would lead to a problem that one packet would be sent twice.
This commit adds support to prevent this bug if you are using IP
cores with this issue, by using multiple tx descriptors and
organizing them as a real well-defined ring buffer.

Signed-off-by: Hanyuan Zhao <zhaohy22@mails.tsinghua.edu.cn>
---
 drivers/net/Kconfig   | 13 +++++++++++++
 drivers/net/dc2114x.c | 17 ++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index d79d8ad9c4..89bd77da19 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -759,6 +759,19 @@ config TULIP_IGNORE_TX_NO_CARRIER
 	  of this IP core do not detect this error anymore. Say Y to this could
 	  disable handling of this error.
 
+config TULIP_MULTIPLE_TX_DESC
+	bool "Use multiple tx descriptors"
+	depends on TULIP
+	default n
+	help
+	  Some IP cores of dc2114x or its variants do not comply so well with
+	  the behaviors described by the official document. Originally this
+	  driver uses only one tx descriptor and organizes it as a ring buffer,
+	  which would lead to a problem that one packet would be sent twice.
+	  Say Y to this could prevent this bug if you are using IP cores with
+	  this issue, by using multiple tx descriptors and organizing them as
+	  a real well-defined ring buffer.
+
 config XILINX_AXIEMAC
 	select PHYLIB
 	select MII
diff --git a/drivers/net/dc2114x.c b/drivers/net/dc2114x.c
index dc28712221..11dea9b4d7 100644
--- a/drivers/net/dc2114x.c
+++ b/drivers/net/dc2114x.c
@@ -78,10 +78,15 @@
 #else
 #define phys_to_bus(dev, a)	dm_pci_phys_to_mem((dev), (a))
 #endif
+
+/* Number of TX descriptors   */
+#if CONFIG_IS_ENABLED(TULIP_MULTIPLE_TX_DESC)
+#define NUM_TX_DESC 4
+#else
+#define NUM_TX_DESC 1
 #endif
 
 #define NUM_RX_DESC PKTBUFSRX
-#define NUM_TX_DESC 1			/* Number of TX descriptors   */
 #define RX_BUFF_SZ  PKTSIZE_ALIGN
 
 #define TOUT_LOOP   1000000
@@ -312,7 +317,12 @@ static void send_setup_frame(struct dc2114x_priv *priv)
 
 	priv->tx_ring[priv->tx_new].buf = cpu_to_le32(phys_to_bus(priv->devno,
 						      (phys_addr_t)&setup_frame[0]));
+#if CONFIG_IS_ENABLED(TULIP_MULTIPLE_TX_DESC)
+	priv->tx_ring[priv->tx_new].des1 = cpu_to_le32(TD_SET | SETUP_FRAME_LEN);
+	priv->tx_ring[priv->tx_ring_size - 1].des1 |= cpu_to_le32(TD_TER);
+#else
 	priv->tx_ring[priv->tx_new].des1 = cpu_to_le32(TD_TER | TD_SET | SETUP_FRAME_LEN);
+#endif
 	priv->tx_ring[priv->tx_new].status = cpu_to_le32(T_OWN);
 
 	dc2114x_outl(priv, POLL_DEMAND, DE4X5_TPD);
@@ -356,7 +366,12 @@ static int dc21x4x_send_common(struct dc2114x_priv *priv, void *packet, int leng
 
 	priv->tx_ring[priv->tx_new].buf = cpu_to_le32(phys_to_bus(priv->devno,
 						      (phys_addr_t)packet));
+#if CONFIG_IS_ENABLED(TULIP_MULTIPLE_TX_DESC)
+	priv->tx_ring[priv->tx_new].des1 = cpu_to_le32(TD_LS | TD_FS | length);
+	priv->tx_ring[priv->tx_ring_size - 1].des1 |= cpu_to_le32(TD_TER);
+#else
 	priv->tx_ring[priv->tx_new].des1 = cpu_to_le32(TD_TER | TD_LS | TD_FS | length);
+#endif
 	priv->tx_ring[priv->tx_new].status = cpu_to_le32(T_OWN);
 
 	dc2114x_outl(priv, POLL_DEMAND, DE4X5_TPD);
-- 
2.39.2

