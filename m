Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BFCFC6165
	for <u-boot@archiver.kernel.org>; Sat,  3 Jan 2026 00:18:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC29483B27;
	Sat,  3 Jan 2026 01:18:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DrYe0hcb";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="B+k+lWkI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D841183B72; Sat,  3 Jan 2026 01:18:05 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9035183A64
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 01:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4djh3b1nzhz9v6y;
 Sat,  3 Jan 2026 01:18:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767399483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RzS7c/3nj7a69/XaIWeGOU79+yVFlQfvRGkz7dD9PhA=;
 b=DrYe0hcbAcb5+GhRvKxRVzF7VYYs07Lr7G6JJc0r5BGrExPLh99+o9SpiMbih6lRbEiUGE
 uiCzLDuSpXK3e8NLqAHNRwK8207S3gWvM6uZTwt8n9zhdTh+5r8FxNguKdwr7DagD5NeJP
 GCZH0KyPShOkYzSquRdV9ocy4nz+vd25l1uR+R9Pxs1qoGg2YFHjj2XimBpTWRnxY16RKU
 m9G+LDGXC6if3McUZzjfcFg2dkDEv2cr4JpupNZi+PBIst0XpYbTxV+g074976nchaGP/d
 F2JhdVYnco2aEAbXxWx47unrv6dhBWk6aTUYa4P8vssH615lkfN8kRIgrGUMLg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=B+k+lWkI;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767399481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RzS7c/3nj7a69/XaIWeGOU79+yVFlQfvRGkz7dD9PhA=;
 b=B+k+lWkIPeWMKLMY8GegMrVftIT6gVAZDwHF8cGSyoIHIZ0qJzuzBpvb9z9SpDulvAHs31
 XOCI9pHC42ejYpC5jDXJTpyfMFURosADc6r4kfVUzxgpAQFcxjyvmFwJgktuDgxQLwzisB
 IuTSXttD0K/GFIhGytUDSoo9arNRhq5zZ/63yASyn8k9vnutp5L+C4jSXtSvknAdDxnYYs
 yzGutL3OTboGF5sigZqkvn8JrgTrcdT05UZlR3Pi4mYIXntzFVR9A66QNW9HKQnehqWaOf
 osRDsf/lXz8l5sYH0vbWD4uaQCf98Dp/ADk2IYq6PhUKAMpZzYEg2BW6D8W2yQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] misc: Add fixed-layout support
Date: Sat,  3 Jan 2026 01:17:31 +0100
Message-ID: <20260103001759.182898-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: da21d87b9fb858465ff
X-MBO-RS-META: pgndh8g1wqnkoyk5316j3ouothnen5fg
X-Rspamd-Queue-Id: 4djh3b1nzhz9v6y
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

The "fixed-layout" nvmem controller subnode used to be optional wrapper
around nvmem controller cells subnodes. The "fixed-layout" node is now
mandatory in most cases, but in order to support both recent and legacy
DTs, both variants have to be supported.

Implement support for the "fixed-layout" node in the most trivial manner,
check whether the nvmem cell supernode is compatible with "fixed-layout"
and if it is, proceed one level above it to find the nvmem controller.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
---
 drivers/misc/nvmem.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/nvmem.c b/drivers/misc/nvmem.c
index d0cb0a35b81..33e80858565 100644
--- a/drivers/misc/nvmem.c
+++ b/drivers/misc/nvmem.c
@@ -102,6 +102,7 @@ int nvmem_cell_get_by_index(struct udevice *dev, int index,
 	fdt_size_t size = FDT_SIZE_T_NONE;
 	int ret;
 	struct ofnode_phandle_args args;
+	ofnode par;
 
 	dev_dbg(dev, "%s: index=%d\n", __func__, index);
 
@@ -110,7 +111,11 @@ int nvmem_cell_get_by_index(struct udevice *dev, int index,
 	if (ret)
 		return ret;
 
-	ret = nvmem_get_device(ofnode_get_parent(args.node), cell);
+	par = ofnode_get_parent(args.node);
+	if (ofnode_device_is_compatible(par, "fixed-layout"))
+		par = ofnode_get_parent(par);
+
+	ret = nvmem_get_device(par, cell);
 	if (ret)
 		return ret;
 
-- 
2.51.0

