Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3134FCD4F3C
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 22:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2215788BD6;
	Thu,  5 Sep 2024 00:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qPQUYYxT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vfjrf7WI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00AF788BE1; Thu,  5 Sep 2024 00:34:50 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1063388BCD
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 00:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WzckG5nxZz9sjD
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 00:34:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725489286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yf0kSomJZpDYjQJZ6fVGtEz3EIvByqbR9w8opv3deFA=;
 b=qPQUYYxTmHY/xgV/+QKpWAvOf/wOgMJQD2EvMk0MWJpY3pXhAsm8v+0AA0a7lIX+fTYuvz
 mp3jWgFQ4to8KmppVe6kljVWfE3kScwG4TMVmRdYHIs49e7o83Q5I7Akp1v/GqmbbfN64g
 h3p5kfb0vDF8Z/cZSN+oZ0wTGfD2p0c89G2GXNBWSxHsDXVDZx6TEDhmxSDg2qMG5nH1gY
 fYEDulJzdPDigR21IYxQIdRCiqD0gzqVAoIbQ5vzcQH5vU8yV3PyedCBeZvmQb7eWFFEZ8
 ooIb9WwVCGh82k8bPC4XPlSwOIRPWiM7XV0pm/A2pKml/bTGImsa3m36ShP0mQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725489285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yf0kSomJZpDYjQJZ6fVGtEz3EIvByqbR9w8opv3deFA=;
 b=vfjrf7WImFXvb8UIrxppkajy0eaVEtIxdpPG8vWHeAA+8Il18pFzAgCaBnBhof360FNgw+
 8yZsUygZKZkohKLd5EJI0NMo335owNYKH+YQ8FSGa3p5HE8a6mcJQj2+9oIrE8hXUEC8Ty
 OC9rXdUIsu9bAVPNc++1a1nGgY/+df3o+C4reRVueb1ElqtWYyVl6ninJUJKGRXw7+o4Ux
 B0rpcEh9jW/BJXGgedpp2biweh1b8565Hn/82Isj87tse7iii/VlmaLoulhDlKChGCThEb
 +EUe21RqTPAbG2UyAA8O1nb11KLgkwC5bsMRbCAqOxVV7lpw6ICxCYXnMY/5ag==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH] clk: renesas: Fix missing unbind on driver look up failure
Date: Thu,  5 Sep 2024 00:34:20 +0200
Message-ID: <20240904223434.110863-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: nkjso3becwbkx9wdf3bf8rdkrjxd57rw
X-MBO-RS-ID: 9cda9f033fa6fe7f3d7
X-Rspamd-Queue-Id: 4WzckG5nxZz9sjD
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

In case lists_driver_lookup_name("rst_gen3") fails, the clk_gen3 driver
has to be unbound before erroring out. Reorder the function such that
both clk_gen3 and rst_gen3 drivers are looked up first, if either look
up fails then the function errors out right away. Second, the clk_gen3
is bound, if binding fails, the function still errors out right away
because there is nothing to undo after either lists_driver_lookup_name()
call. Finally, rst_gen3 is bound and if this binding fails, then that
is the only place where clk_gen3 has to be unbound before erroring out.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/clk-rcar-gen3.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/renesas/clk-rcar-gen3.c b/drivers/clk/renesas/clk-rcar-gen3.c
index b84024266f4..ac05788ccc5 100644
--- a/drivers/clk/renesas/clk-rcar-gen3.c
+++ b/drivers/clk/renesas/clk-rcar-gen3.c
@@ -579,23 +579,24 @@ int gen3_cpg_bind(struct udevice *parent)
 	struct cpg_mssr_info *info =
 		(struct cpg_mssr_info *)dev_get_driver_data(parent);
 	struct udevice *cdev, *rdev;
-	struct driver *drv;
+	struct driver *cdrv, *rdrv;
 	int ret;
 
-	drv = lists_driver_lookup_name("clk_gen3");
-	if (!drv)
+	cdrv = lists_driver_lookup_name("clk_gen3");
+	if (!cdrv)
 		return -ENOENT;
 
-	ret = device_bind_with_driver_data(parent, drv, "clk_gen3", (ulong)info,
+
+	rdrv = lists_driver_lookup_name("rst_gen3");
+	if (!rdrv)
+		return -ENOENT;
+
+	ret = device_bind_with_driver_data(parent, cdrv, "clk_gen3", (ulong)info,
 					   dev_ofnode(parent), &cdev);
 	if (ret)
 		return ret;
 
-	drv = lists_driver_lookup_name("rst_gen3");
-	if (!drv)
-		return -ENOENT;
-
-	ret = device_bind_with_driver_data(parent, drv, "rst_gen3", (ulong)cdev,
+	ret = device_bind_with_driver_data(parent, rdrv, "rst_gen3", (ulong)cdev,
 					   dev_ofnode(parent), &rdev);
 	if (ret)
 		device_unbind(cdev);
-- 
2.45.2

