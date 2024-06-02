Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A561C25B74
	for <u-boot@archiver.kernel.org>; Sun,  2 Jun 2024 08:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B95088096;
	Sun,  2 Jun 2024 10:29:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EMgCZ466";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46A418826D; Sun,  2 Jun 2024 10:29:56 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1433D87FC7
 for <u-boot@lists.denx.de>; Sun,  2 Jun 2024 10:29:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yasuharu.shibata@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f44b42e9a6so26116265ad.0
 for <u-boot@lists.denx.de>; Sun, 02 Jun 2024 01:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717316992; x=1717921792; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WUgvXMkI/ZKNVEDHlpi5SPOt2c6J9DN05Rpc3nbIyb0=;
 b=EMgCZ466xk+vjmHi2W5NHn0qjnGbiA/eQdp5ADZTUQ/M21OzF5m0fRU5FL7cbrZYxI
 pVf9tNgAdkUm7XlcyQpjuLxyMigQ6HPleKXefbvpE2IFhwt5cCZSu3dgL554thvVaMGf
 b0E7v62d6IKeWMNfkYtX0Na0jYmoejKw8mXujo/pcO2KtAcki9gUp1d2lQZ3FR4G/auw
 WX+rXQ5euLesv6bjHstl7sUI3Dx0MQRtJA3aFVrQCJVjgzci0xxhqNP8KyaYHRM6OIod
 U3M+g9PpnV2KKrVnP5wOD6Q8RLvMG6Y56FvEfXO6Hh7Cg98d9lCA8JZvXdXEgq2+yodQ
 vkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717316992; x=1717921792;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WUgvXMkI/ZKNVEDHlpi5SPOt2c6J9DN05Rpc3nbIyb0=;
 b=P0olZdxRDG+vPWB8yELHXC5Oldt5G601OU/Bi/cRIFe0jHWoOfJw1fv2u7Vft7vQz5
 vqAM1lBzc+HPx49LujbLfiGJv/N7N3UJF13WsjxUNjAkCKWLQgMQQNedm1Zz4wbwsJ3F
 26MZ/CFk0t/Trcw88KoBS135uvRH0ivGz4u/GQZSYaxvYGtCae6I5uw/1nGIYUsr4qfC
 RE+lo+yk8GTSVl3JHvgZTz9Ez8AKDuGOWcaVvgoF7aE2bWqreJqKEbx41oAvC0DBDdNZ
 UDwwuZj4pHepLZWnJzHDNZ2IrZ7kbRQS4uZ/Z+WBJnGYgzYJElA4pPazB7ajyPvZfzBu
 /icA==
X-Gm-Message-State: AOJu0Yy2xbPIuXKj00jAz0Ca0cAKG1vY2FfF3itcpA+l1U1EULcyBxvJ
 VSlhVMEDMQNauPvSypCXEy6aoqroM+u5Vrns4ZB7ULbhenWQLfVb
X-Google-Smtp-Source: AGHT+IFojDP+ZS9CjqPfZ+NejHLHU2wN4OaKu9h1Cn1JevI4m+pDD7+u7hPkeotVtsVpETL5Qyj0sQ==
X-Received: by 2002:a17:903:6cb:b0:1f6:18f9:b764 with SMTP id
 d9443c01a7336-1f637024d4cmr47800035ad.30.1717316972786; 
 Sun, 02 Jun 2024 01:29:32 -0700 (PDT)
Received: from localhost.localdomain ([2409:10:d8a0:1500:8a15:9ebf:c34b:b836])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323ea10csm43651115ad.201.2024.06.02.01.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jun 2024 01:29:32 -0700 (PDT)
From: Yasuharu Shibata <yasuharu.shibata@gmail.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Yasuharu Shibata <yasuharu.shibata@gmail.com>
Subject: [PATCH] bcmgenet: fix Rx buffer corruption caused by lack of cache
 flush
Date: Sun,  2 Jun 2024 17:24:03 +0900
Message-Id: <20240602082403.17508-1-yasuharu.shibata@gmail.com>
X-Mailer: git-send-email 2.25.1
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

When bcmgenet complete to write Rx buffer with the DMA,
some U-Boot commands write data to the buffer directly.
Those write data will become dirty in CPU cache.
After this driver calls free_pkt to the buffer,
the buffer is assigned as the future Rx buffer.
At some point, if bcmgenet writes to a buffer with DMA
and CPU cache flushes dirty data to the buffer,
the buffer is corrupted.

This patch calls flush_dcache_range in free_pkt
to immediately flush the data written by U-Boot command
and prevent data corruption.

This issue can be reproduced using wget on Raspberry Pi4.
If wget receives data larger than
RX_BUF_LENGTH * RX_DESCS = 2048 * 256 bytes,
it will timeout due to data corruption.
In addition, if LOG_DEBUG is enabled in net/tcp.c,
the following error log is output.

TCP RX TCP xSum Error

Signed-off-by: Yasuharu Shibata <yasuharu.shibata@gmail.com>
---
 drivers/net/bcmgenet.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/bcmgenet.c b/drivers/net/bcmgenet.c
index 4e1f8ed7a4..a0264dc386 100644
--- a/drivers/net/bcmgenet.c
+++ b/drivers/net/bcmgenet.c
@@ -360,6 +360,10 @@ static int bcmgenet_gmac_free_pkt(struct udevice *dev, uchar *packet,
 				  int length)
 {
 	struct bcmgenet_eth_priv *priv = dev_get_priv(dev);
+	void *desc_base = priv->rx_desc_base + priv->rx_index * DMA_DESC_SIZE;
+	u32 addr = readl(desc_base + DMA_DESC_ADDRESS_LO);
+
+	flush_dcache_range(addr, addr + RX_BUF_LENGTH);
 
 	/* Tell the MAC we have consumed that last receive buffer. */
 	priv->c_index = (priv->c_index + 1) & 0xFFFF;
-- 
2.25.1

