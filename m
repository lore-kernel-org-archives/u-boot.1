Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CF2CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D992884AF1;
	Fri,  8 May 2026 14:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jpTc0j+A";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EDpXKjJc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23EFC84B1E; Fri,  8 May 2026 14:21:34 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A80383DBF
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 14:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gBpBh0XCBz9tpB;
 Fri,  8 May 2026 14:21:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jmv7V6jdNG2zyJE2DXtrmGNstZ+64J+CsDqqy33rz+8=;
 b=jpTc0j+AuxfuJNoTSj1hHeca53nilih/Xjj1qErrFGtC/XiETRL2MdMgXToiC0+NGkXaIL
 4JJamsRnXMfQ9jSAuLZewUIzlohlK47X9ZxBS2wkvyiEBVWhJWvW9e9jj+A2XoOkt03pjq
 dYc+4jJhI3qsxPC5gHGEkekXuaj/FYoiEOgn5yJQQlrC2Q9GliNoIQVNHHeih5dWX9oL7h
 828UbO1PZeOwBD8fK9vYH/JYgY4IGj3n5iXWZ1rvZpZzsW7wRuMoCCKcxTtXZZPnGfkw7q
 KYbxFFGs0+YJl3hZbj5YlSaFxyz6PycrWBMUFaywum+X7szFQvKAxRLu9pxTLg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=EDpXKjJc;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jmv7V6jdNG2zyJE2DXtrmGNstZ+64J+CsDqqy33rz+8=;
 b=EDpXKjJclT0OsbIQlRFd4lVmP2PI2F4eHNpkjBazC2ht+Kqvz9bs2Wc/alw7PlBi/LOuGp
 F2OvHzXYIRLnbm12mhJvknX2Z+7rHVWIpxtquqtr7f1/vdint8aZ/5aMAP61MlSeuIxTO7
 ELFFDwKRhRwGG2y9I0XbLdw02CtPCWQZXtYr8XbxIHi3U7LMef28uLZPB9nVag8/bj+lS3
 05XzlSGO5g/KWZpvMk1MiEwV91B1fFAaRUNmmlgjjAYxEHJXvtChM7o2nSdLNoF5//OiBP
 rtfyE+6pC4phTbIzqnXiTLe7d2jRk9CNl9+4PSlkLu53uCGYjeAXPASiWgoUtA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] nvme: Staticize and constify driver ops
Date: Fri,  8 May 2026 14:21:21 +0200
Message-ID: <20260508122128.512798-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 7nf7p4eh67rpcsht5arox5uxtttwhimf
X-MBO-RS-ID: 3e570f3fffa44b6438a
X-Rspamd-Queue-Id: 4gBpBh0XCBz9tpB
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
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/nvme/nvme-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/nvme-uclass.c b/drivers/nvme/nvme-uclass.c
index 44c88ad27f3..4ab9567450f 100644
--- a/drivers/nvme/nvme-uclass.c
+++ b/drivers/nvme/nvme-uclass.c
@@ -44,7 +44,7 @@ UCLASS_DRIVER(nvme) = {
 	.id	= UCLASS_NVME,
 };
 
-struct bootdev_ops nvme_bootdev_ops = {
+static const struct bootdev_ops nvme_bootdev_ops = {
 };
 
 static const struct udevice_id nvme_bootdev_ids[] = {
-- 
2.53.0

