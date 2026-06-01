Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC07ECD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58F2284995;
	Mon,  1 Jun 2026 14:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="NUEaMzbX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AFDB846D3; Mon,  1 Jun 2026 10:26:38 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CCA48466E
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 10:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.stein@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=ZlghJFJyNknyy3UUOQHmD2sHPuJhwK9mrZHKo4mfNYs=; b=NUEaMzbXePKDCar3xU2JhgBSjW
 VzF7uFXOkw+f/3IDnifJaf9Qrsizx9uNIeoeaU8gbT9HeqZuVY80e/iwVh+sEJJ7/0lNBZ54Aixv9
 16E17rOxVYVandx7Hw1A7T3BRlLWc2JUX45Di+EQTaqy6mLbUPID3rGSiFFH7oYG+/hExUA6wmDwj
 d4uizucLgAX+/jY6zJUgVwfdKLbSun9+iG1aG3grqK0zLOl5KBdzUa6gzphez4VxWo6rruHLyUMkP
 DAcKxwS3K6KdZEv8AwORT0d961maOS9kbnSKzHIV+GL/zHVzt9nd5FrVjTk/5Az601/QTVqy7JPMT
 NkHbIzbA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wTxyl-0005O5-3B; Mon, 01 Jun 2026 10:26:36 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wTxym-000IXm-0x; Mon, 01 Jun 2026 10:26:35 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	u-boot@lists.denx.de
Subject: [PATCH 1/1] fdt: fix condition for devicetree from bloblist
Date: Mon,  1 Jun 2026 10:26:30 +0200
Message-ID: <20260601082632.238595-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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

On boards without TPL, but SPL enabled, xpl_prev_phase() will return never
return PHASE_TPL. This the condition is always true. This is a problem
for system which use an SDRAM bloblist location and initialize the SDRAM
in SPL. Adjust the condition to take this config into account.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
There is also another possibility for the check. I'm not sure which one
is better or preferred.

--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1829,7 +1829,7 @@ int fdtdec_setup(void)
         * not whether this phase creates one.
         */
        if (CONFIG_IS_ENABLED(BLOBLIST) &&
-           (xpl_prev_phase() != PHASE_TPL ||
+           (xpl_prev_phase() != PHASE_TPL &&
             IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
                ret = bloblist_maybe_init();
                if (!ret) {

 lib/fdtdec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index c67b6e8c133..3f31f9c2aeb 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1829,8 +1829,8 @@ int fdtdec_setup(void)
 	 * not whether this phase creates one.
 	 */
 	if (CONFIG_IS_ENABLED(BLOBLIST) &&
-	    (xpl_prev_phase() != PHASE_TPL ||
-	     IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
+	    !xpl_is_first_phase() &&
+	    (IS_ENABLED(CONFIG_TPL_BLOBLIST) || IS_ENABLED(CONFIG_SPL_BLOBLIST))) {
 		ret = bloblist_maybe_init();
 		if (!ret) {
 			gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
-- 
2.43.0

