Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F45BC54E67
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 22:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13E6E88058;
	Tue, 26 Mar 2024 23:15:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OwtLyh9+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="D/xGND0O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA3058804C; Tue, 26 Mar 2024 23:15:03 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C315687B89
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 23:15:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4V43yF4bRDz9sWp;
 Tue, 26 Mar 2024 23:15:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1711491301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y3vjzFprV7zRMswWO06m+t1rGw2JlDX26Zi/OjqObsA=;
 b=OwtLyh9+ChIISybklakB691S0sYERVh1AtGNj9UDnHISDltL63SX8TGYH0OgLWTSRf0A6i
 9sdBnV9Ri3O/5Lw0Ox7cf3nm3cCq4iJS5LhtPFjQ5GoK9mBDHoCQtbwDPgwNz4YZwcvoeE
 hVqRbia0ZhoSVzM7QyjLWXAIcHqUrfKuQrR3J98lPxXSTLXWKRvpdyyc7Hh/koXwR8SQ5T
 HsFr2ICbuRETfmqkV9i2OcQQOibxXS+n7l9GfF3inwsIC9l3I5ZHAwCRQ+SFCQXS2Y6Yfc
 O03/ZurGIamNzdp0rpCuT/mZcxrem5P+9tAEPvsG58iMA5C8db2QhIrmZ7Y3cA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1711491299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y3vjzFprV7zRMswWO06m+t1rGw2JlDX26Zi/OjqObsA=;
 b=D/xGND0OZKBnI/As7vLnU7G4Yxf/l7seYkA4Xx7RpLCzofXCPPEGcQiqrxkYl1dtjzzkeC
 5Qpssrmbl3yIArYQtvY1kx3k4wpwzC6ybhoxWzC9F5wlcBWNrmgl4zYLbaq7fAQwc00XR5
 00pzkdek18DGUuye52tp2AIKuyKS3wMgOB0W4+zlGmAhRFq4phpaaXiOTGoPDgdjyIEV7M
 t8sh3CTS4l5NhRtSIsiRvYUbzL4JTVmU7hhcuY2mtt8gYEKUeFQlxaCMr12zsBbz7YLmSN
 y/D08LbROxms1iga/vnYmZp2IAZjc/ufYqFk+oaVpqs+LRaaeIT3yoM/qVR7gQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 2/6] boot: fdt: Clean up env_get_bootm_size()
Date: Tue, 26 Mar 2024 23:13:12 +0100
Message-ID: <20240326221431.55346-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240326221431.55346-1-marek.vasut+renesas@mailbox.org>
References: <20240326221431.55346-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ba928519c6720327cb4
X-MBO-RS-META: 8zsycyi5xpkwjjb4pe86m667oz8amik6
X-Rspamd-Queue-Id: 4V43yF4bRDz9sWp
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

Reduce tmp variable use and remove unnecessary type cast in
env_get_bootm_size(). This aligns the env variable parsing
with env_get_bootm_low(). No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
V2: - New patch
V3: - Reword commit message
V4: No change
---
 boot/image-board.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/boot/image-board.c b/boot/image-board.c
index 3263497a1d5..e3d63745299 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -129,10 +129,8 @@ phys_size_t env_get_bootm_size(void)
 	phys_addr_t start;
 	char *s = env_get("bootm_size");
 
-	if (s) {
-		tmp = (phys_size_t)simple_strtoull(s, NULL, 16);
-		return tmp;
-	}
+	if (s)
+		return simple_strtoull(s, NULL, 16);
 
 	start = gd->ram_base;
 	size = gd->ram_size;
@@ -142,7 +140,7 @@ phys_size_t env_get_bootm_size(void)
 
 	s = env_get("bootm_low");
 	if (s)
-		tmp = (phys_size_t)simple_strtoull(s, NULL, 16);
+		tmp = simple_strtoull(s, NULL, 16);
 	else
 		tmp = start;
 
-- 
2.43.0

