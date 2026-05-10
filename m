Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1274FCD37B9
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 17:16:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0883846D1;
	Sun, 10 May 2026 19:16:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oMsGt6a2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZANZ6RyE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 481B284694; Sun, 10 May 2026 19:16:15 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CDDC846CB
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 19:16:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gD8dl3PcNz9tkg;
 Sun, 10 May 2026 19:16:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+MT3d+koYCfN6OkV9LcskfOnobR2FxGDfdMAkZhu4SU=;
 b=oMsGt6a21JFAQyxsYsX/wkK++WXGIZYQ/EToVTBGEsVRkkDf7JpBDdIhXouvRVBv28plZz
 Rat9ce80CGbiP/ABNtdh5GNO58XF4Mf9FzHRSqWmjcODxEoosfhxqIl4Eo4aHam68XfxkB
 ekTlLTsRVcci7h+U1gyBlaG+8ci8N1TZnzNn4FkCFOyYFJhgmLoCPUEzQC/1FJLCM5V9gv
 /CqBDV0nQH3gBm5wrgOIyCePrOe38QPpSvDDNq2XX6TxNQSZ/L61Xh+DcMDHkB1f1+S3DW
 UEA7qOkk9i88Sio3dFCrtj+BCz374Gki8lSuUL259tIvNvGU3D3cYl918lq4+Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ZANZ6RyE;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+MT3d+koYCfN6OkV9LcskfOnobR2FxGDfdMAkZhu4SU=;
 b=ZANZ6RyEOFqZ5+zte4PLQgy7kCGg5cJqq1GZ1hqUCRggelhTPgD5t97rytmOtqVzEnRm0z
 cGzRTuIl1OyXNl02kKbPDAumSTuBqFHG6GmgBOKxMExs9CSr4hPekJN2PnztOqokCGL5ZY
 aQowmpNZqV5yCrDxa3PjW94ZLARb9IMulGduI1qfyB9IjTQEGjGCZc0yzeNVPBor4zHJ3I
 LYprjDexM3qyzVbVjM6qkHHwHC8r7RKPPuDHln7vclIw+uWsZYLLsfY/uat6FeJJZrpwlJ
 FnJqPb67KlwDgDfxLjT8f7ov82heIEyafHk8Eym6tJnAx1dGn0nZGi3zzt6P/w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] scsi: bootstd: Staticize and constify driver ops
Date: Sun, 10 May 2026 19:15:53 +0200
Message-ID: <20260510171604.56788-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171604.56788-1-marek.vasut+renesas@mailbox.org>
References: <20260510171604.56788-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: upiiqdp4whu8j9uhzqa981ntkpu6z73t
X-MBO-RS-ID: abe6d2e7d58c58a5032
X-Rspamd-Queue-Id: 4gD8dl3PcNz9tkg
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
 drivers/scsi/scsi_bootdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_bootdev.c b/drivers/scsi/scsi_bootdev.c
index 28e4612f337..71c755be864 100644
--- a/drivers/scsi/scsi_bootdev.c
+++ b/drivers/scsi/scsi_bootdev.c
@@ -37,7 +37,7 @@ static int scsi_bootdev_hunt(struct bootdev_hunter *info, bool show)
 	return 0;
 }
 
-struct bootdev_ops scsi_bootdev_ops = {
+static const struct bootdev_ops scsi_bootdev_ops = {
 };
 
 static const struct udevice_id scsi_bootdev_ids[] = {
-- 
2.53.0

