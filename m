Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9D9EA71B5
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 01:23:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 569D58428C;
	Mon, 20 Apr 2026 03:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="o6S7nMfK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="u9Bgj8zH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 434178428C; Mon, 20 Apr 2026 03:23:29 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6261984286
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 03:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fzSRf75hzz9tlP;
 Mon, 20 Apr 2026 03:23:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776648207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9sfQ4CaoU2xMDVWuS1f3hMEPLmMaHKxlNk5/JEp6hLc=;
 b=o6S7nMfKjsHuizoRfd5g9oljrLdeA6UP9wQTPa0B+pPXQXBTo4BvP4Ph9qHivk8HwP/4Wx
 c4aOLXDGPvOmJoVqhY6Ib08T7JMZxE+gD6yjxMSk9CRxVMfCy1efxdNBY5xzC5/JeHvufj
 QCMXufsV3dn0CCofZ/La9X6OFOkZwB8QasmVLtmGbPihIksGiHW0L8/N+tlIRRDunvpxUi
 fmsW/ee+u1u3yo3uJumx0f0XA9qxQheMkPqYnmRlpK00334+iTYzL3cuPQvIbmNAW68sG+
 Cfvoi5V0Ty+5VFn+crRPDVm659fGy5cf1uQObOKRHcNOkZamor5uxE4UcPDq5g==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=u9Bgj8zH;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776648205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9sfQ4CaoU2xMDVWuS1f3hMEPLmMaHKxlNk5/JEp6hLc=;
 b=u9Bgj8zHo2ZD6rjA79HVBf65FGD79DWFpFYCKYD5WvPNLYUo9/jKTl2NnBACqMNGTgcGmA
 gRJa82v1K9YSH9h+pm8e7oJVK5Yc4C6f30gIkHLEWZ0CCxpKYJv0UDHHT7k+oyszK8MoLM
 EUGrGkWfLz6O0VO4ubt9Et5UlZ43AOfVAEvSy3lbHwAld2brkHQCwpCETv2Gm2Y7tGQewh
 +krKhD4UMmRLrcDrtKFbVWJ/MlMuwcfhfvGfUpQ7y+zYk7iET1cD8ygeTogWBNAmzYtWCq
 xMfm6WzwAn6BQefxm52H+6V+6TYaH44D2HBaOyATFkIN0koMSs/okSA/C7yi+w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] common: update: Fix TFTP return value handling
Date: Mon, 20 Apr 2026 03:23:07 +0200
Message-ID: <20260420012320.400472-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6bd5eceb798d25a809c
X-MBO-RS-META: 3x9oju5twtqwx7x977cbrjtfp9xwa93k
X-Rspamd-Queue-Id: 4fzSRf75hzz9tlP
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

The net_loop() returns 1 on success, but update_load() returns 0 on
success. Do not assign rv which is the return value of update_load()
to net_loop(), instead assign net_loop() return value to a temporary
variable and then update rv only if the temporary variable is negative.
This way the update_load() now correctly returns 0 on tftp success and
1 only on failure.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 common/update.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/update.c b/common/update.c
index 0bafffede9e..06e53cbd402 100644
--- a/common/update.c
+++ b/common/update.c
@@ -32,7 +32,7 @@ static uchar *saved_prot_info;
 #endif
 static int update_load(char *filename, ulong msec_max, int cnt_max, ulong addr)
 {
-	int rv;
+	int rv, ret;
 	ulong saved_timeout_msecs;
 	int saved_timeout_count;
 	char *saved_netretry, *saved_bootfile;
@@ -54,9 +54,9 @@ static int update_load(char *filename, ulong msec_max, int cnt_max, ulong addr)
 	/* download the update file */
 	image_load_addr = addr;
 	copy_filename(net_boot_file_name, filename, sizeof(net_boot_file_name));
-	rv = net_loop(TFTPGET);
+	ret = net_loop(TFTPGET);
 
-	if (rv < 0)
+	if (ret < 0)
 		rv = 1;
 	else
 		flush_cache(addr, net_boot_file_size);
-- 
2.53.0

