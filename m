Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16B9CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:42:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DFB584BB7;
	Thu,  7 May 2026 18:42:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pFFgux2z";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YL7uriiI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C7EF84BC3; Thu,  7 May 2026 18:42:54 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3178F84B5D
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:42:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gBJ2g6s87z9ts8;
 Thu,  7 May 2026 18:42:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778172172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3KnpLTnjGFPZlJgG4v9Mh4d1/o5ZEPkn5DAAa3ixB3w=;
 b=pFFgux2zphbeRmiwwCs0d7PD43JR5DFbxwvvy68zgMbqdetBw+lc2CY7eRx6p1FIORbleS
 Pj8nb3LcNPsw60qzZRzfwuK36IZ9DphgaFB1hlTuPp7lqJ35Py/V5IJQMaFg/MjWCND1Jm
 wg3vjD5DIov/lGJJVrYvrwlqgw40gNpxvUDOXBhDj7kqd4BMEWYtkHPjuiQJB8eOSLZQQH
 RRCD2bZ+Vm0PuHuni7bxH9SgdDETEwShl1nGgNCQgamzbOhV2uUsak6cXF1bJY/RCyU8cj
 0joa1Mq7GqphSVmyyjmGJ4uQhFXFxH1/q5kGD0IkIzbWd0RqKvLD7VCMydhKFw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778172170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3KnpLTnjGFPZlJgG4v9Mh4d1/o5ZEPkn5DAAa3ixB3w=;
 b=YL7uriiIpOPvKnrWQV/iJJKYhew62YM/Q/X5QjQ2UWf8XL2s8EJ0xROIJQTfzSJFzo+/xH
 mH3ZkJ+BJNdn/h87d9GwaEzcmFtfv9uCO/FUgVTqkXburS4Cf1fKIsx1xkDH/wOxihacp5
 vM01rCy8xmjnA6VJ6/0i69shAse/vNuGQjU9u4aBQ0TCuDQj8zPsg1Rj2sVQnPdoXiE7jH
 gTEOvde63hs1wI+KeKr4b5uwfgSBsKYXQZFTT0Hi3v3CFZuh++qoTR58lYnbUsk0Jfaf3A
 y4dr932qblcWBp1EmNE4HLfi3SZZu+XtRm5RdJPF2+E7MY//tPH7twb0nBCr+g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] block: ide: Staticize and constify driver ops
Date: Thu,  7 May 2026 18:42:39 +0200
Message-ID: <20260507164248.59353-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: w9fsawe1w9fp7hnsnj17j9ud8uq16xcy
X-MBO-RS-ID: 29ea7c65f4b321f9b6c
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/block/ide.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ide.c b/drivers/block/ide.c
index cab5e1bc92b..fe98d7f783f 100644
--- a/drivers/block/ide.c
+++ b/drivers/block/ide.c
@@ -969,7 +969,7 @@ static int ide_bootdev_hunt(struct bootdev_hunter *info, bool show)
 	return 0;
 }
 
-struct bootdev_ops ide_bootdev_ops = {
+static const struct bootdev_ops ide_bootdev_ops = {
 };
 
 static const struct udevice_id ide_bootdev_ids[] = {
-- 
2.53.0

