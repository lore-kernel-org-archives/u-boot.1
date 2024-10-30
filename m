Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D569D7497E
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 07:58:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17077891D2;
	Wed, 30 Oct 2024 08:58:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="ci3L7Lhe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48ABB890AE; Wed, 30 Oct 2024 08:58:45 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0379C891F4
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 08:58:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nick.hu@sifive.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e2bb1efe78so477348a91.1
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 00:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1730275121; x=1730879921; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1bQgcq6fWj37HuJvQsuLzuAjt+KxlQFbQT8AC/9CdXw=;
 b=ci3L7Lhefu/2YwtTH0ssqzgd8pBLUaa6sf7ZCdaCIyzHykQ7md6io3w60CITX8ovEf
 q4Af+QMLR+fPHkuk43N+r1cbnK9YtUuPhH5iS/qXMPgQGk59fAzbs+J3FuKJNRVW0Qfv
 sFGWHMfCnXzfcBPS3vyWQ8RNJ9RGwvQzLUQvYeudZKSbYzihZIwyavbmoo9osIRITw1P
 tkDY1ASFcB1N4Gb/WSLvlayMC+J0+Mt/+oSMAGTiL0lbz+tJa1WeCfZWoQDwGpuSuFeA
 ZndoHOG8OE+6a5qw2X1SW7KDdFNiDW66Nod8BhbHik8arkeCqj0FlOz3PlLXU/Xw/OiF
 s/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730275121; x=1730879921;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1bQgcq6fWj37HuJvQsuLzuAjt+KxlQFbQT8AC/9CdXw=;
 b=oP1dEi5r/SvAx3w8CPwR9x24paSR+DIqOYgzNGqmUpwiDYakSHO/PRiGZtB/89T1xN
 XAL8etQmecZWcnmlXtbCTNaoGhSYK+kKouEsiE9lHiWtOGiALZUyVHfiXbLNkFZhWfkm
 RBuKNGOwr5dTgsp82eh4/7jqYv/wgd0xRXdg1nX/6ck7j6+pP8cmyDUd2rGQ4duBay5j
 1bIQNmiHA2Tu8MnR3Ft4pxCZdm1QcQ8jGE94ocOP3zDpGPrHvJRN99SJZYh+uPcdaOBr
 js9l4OOhvBKPG/ALJzMn6q03je/rnX1Hufk2iBQex0AUoMFIuzFzIeOmCjSm02xrx4Zd
 f4mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs2s5aeAhniAI+jFZUHwmSGXysrTw3FekawLGD6Q38AzMd/8FZMKE+61HTGTeVkn19axRGF0A=@lists.denx.de
X-Gm-Message-State: AOJu0YyuvOF9h3bmntz8hYSSX1Xn9/partJzxWguGfXNJLXp3WTnCRBI
 dorClrp7MxNao6ulPlxpm0UjlnxFjBqqXz8sIN/W2eS0ShoOIVORFFUTaMtY5to=
X-Google-Smtp-Source: AGHT+IHEj3zDVTGPwoC+z/H24qD4b0vW00OFgtqvTsoUjuceKsIIrsNBu/RcZxKNAiiZW3KsnZVhmA==
X-Received: by 2002:a17:90a:780c:b0:2d8:3f7a:edf2 with SMTP id
 98e67ed59e1d1-2e92f9742demr2256435a91.12.1730275121345; 
 Wed, 30 Oct 2024 00:58:41 -0700 (PDT)
Received: from hsinchu35-syssw01.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e92fa25742sm1011948a91.19.2024.10.30.00.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 00:58:41 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: trini@konsulko.com, u-boot@lists.denx.de, greentime.hu@sifive.com,
 zong.li@sifive.com
Cc: Nick Hu <nick.hu@sifive.com>
Subject: [PATCH] driver: sifive ccache: enable TRUNKCLOCKGATE and
 REGIONCLOCKGATE
Date: Wed, 30 Oct 2024 15:58:36 +0800
Message-Id: <20241030075836.3292824-1-nick.hu@sifive.com>
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

Enable the clock gating bit of ccache when the platform has the ccache0.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
---
 drivers/cache/cache-sifive-ccache.c | 33 ++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/cache/cache-sifive-ccache.c b/drivers/cache/cache-sifive-ccache.c
index cc00b80f60b..2ff5ca701d6 100644
--- a/drivers/cache/cache-sifive-ccache.c
+++ b/drivers/cache/cache-sifive-ccache.c
@@ -14,8 +14,17 @@
 
 #define SIFIVE_CCACHE_WAY_ENABLE	0x008
 
+#define SIFIVE_CCACHE_TRUNKCLOCKGATE	0x1000
+#define SIFIVE_CCACHE_TRUNKCLOCKGATE_DISABLE	BIT(0)
+#define SIFIVE_CCACHE_REGIONCLOCKGATE_DISABLE	BIT(1)
+
 struct sifive_ccache {
 	void __iomem *base;
+	bool has_cg;
+};
+
+struct sifive_ccache_quirks {
+	bool has_cg;
 };
 
 static int sifive_ccache_enable(struct udevice *dev)
@@ -30,6 +39,14 @@ static int sifive_ccache_enable(struct udevice *dev)
 
 	writel(ways - 1, priv->base + SIFIVE_CCACHE_WAY_ENABLE);
 
+	if (priv->has_cg) {
+		/* enable clock gating bits */
+		config = readl(priv->base + SIFIVE_CCACHE_TRUNKCLOCKGATE);
+		config &= ~(SIFIVE_CCACHE_TRUNKCLOCKGATE_DISABLE |
+				SIFIVE_CCACHE_REGIONCLOCKGATE_DISABLE);
+		writel(config, priv->base + SIFIVE_CCACHE_TRUNKCLOCKGATE);
+	}
+
 	return 0;
 }
 
@@ -50,7 +67,9 @@ static const struct cache_ops sifive_ccache_ops = {
 static int sifive_ccache_probe(struct udevice *dev)
 {
 	struct sifive_ccache *priv = dev_get_priv(dev);
+	const struct sifive_ccache_quirks *quirk = (void *)dev_get_driver_data(dev);
 
+	priv->has_cg = quirk->has_cg;
 	priv->base = dev_read_addr_ptr(dev);
 	if (!priv->base)
 		return -EINVAL;
@@ -58,10 +77,18 @@ static int sifive_ccache_probe(struct udevice *dev)
 	return 0;
 }
 
+static const struct sifive_ccache_quirks fu540_ccache = {
+	.has_cg = false,
+};
+
+static const struct sifive_ccache_quirks ccache0 = {
+	.has_cg = true,
+};
+
 static const struct udevice_id sifive_ccache_ids[] = {
-	{ .compatible = "sifive,fu540-c000-ccache" },
-	{ .compatible = "sifive,fu740-c000-ccache" },
-	{ .compatible = "sifive,ccache0" },
+	{ .compatible = "sifive,fu540-c000-ccache", .data = (ulong)&fu540_ccache },
+	{ .compatible = "sifive,fu740-c000-ccache", .data = (ulong)&fu540_ccache },
+	{ .compatible = "sifive,ccache0", .data = (ulong)&ccache0 },
 	{}
 };
 
-- 
2.34.1

