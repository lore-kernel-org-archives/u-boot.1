Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E72BEE7FF2
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 13:37:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB7B786A24;
	Fri,  8 Sep 2023 15:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F3EB86A21; Fri,  8 Sep 2023 15:37:16 +0200 (CEST)
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk
 [188.40.203.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAF6A86A1D
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 15:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=codethink.co.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ben@codethink.co.uk
Received: from [134.238.52.102] (helo=rainbowdash)
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1qebfc-004zoK-Qf; Fri, 08 Sep 2023 14:37:12 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
 (envelope-from <ben@rainbowdash>) id 1qebfb-000RDE-0w;
 Fri, 08 Sep 2023 14:37:11 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: u-boot@lists.denx.de
Cc: palmer@dabbelt.com,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 1/2] cache: sifive: clear out the error irqs on init
Date: Fri,  8 Sep 2023 14:37:06 +0100
Message-Id: <20230908133707.104592-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.40.1
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

We are getting a number of cache errors on starting an OS,
so to try and avoid this, clear the errors when we first
probe the cache.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
[ben.dooks@codethink.co.uk: changed from sifive.com address]
---
 drivers/cache/cache-sifive-ccache.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/cache/cache-sifive-ccache.c b/drivers/cache/cache-sifive-ccache.c
index 540e7df138..178bdcc82d 100644
--- a/drivers/cache/cache-sifive-ccache.c
+++ b/drivers/cache/cache-sifive-ccache.c
@@ -51,11 +51,18 @@ static const struct cache_ops sifive_ccache_ops = {
 static int sifive_ccache_probe(struct udevice *dev)
 {
 	struct sifive_ccache *priv = dev_get_priv(dev);
+	void __iomem *base;
 
-	priv->base = dev_read_addr_ptr(dev);
+	priv->base = base = dev_read_addr_ptr(dev);
 	if (!priv->base)
 		return -EINVAL;
 
+	/* read and clear any current errors, possilbly from reset */
+	(void)readl(base + 0x108);
+	(void)readl(base + 0x128);
+	(void)readl(base + 0x148);
+	(void)readl(base + 0x168);
+
 	return 0;
 }
 
-- 
2.40.1

