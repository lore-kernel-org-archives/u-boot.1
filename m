Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832CDEE14D0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 265E086A61;
	Wed,  6 Sep 2023 23:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TlQTTGKu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wWt19Zem";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F421586A3F; Wed,  6 Sep 2023 23:30:55 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4681A86A22
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RgwXY0H0sz9t26;
 Wed,  6 Sep 2023 23:30:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3ZQLU46BmvV1IuLVsClTduT3jipgMqmDy5/JVT9Cdw=;
 b=TlQTTGKuFIRgz0mCVC+8vtrJj2yo2AJ7n3zQH3SQ0+C0PiEtj6qhQNqbYVjKIPjRbLr/5+
 8XU0a3WhkrB4QUtiH6YXfcUtFxFqmDJxQY+h3v7p6JlcPKbFpI+0eacpqEF/Zr83FoMLOP
 i/U9+UeSmJ1NKvfrVZOyE88cbmSzHwPLYeSZzcE1LsPAioxOgrzX/EDCVrzUkvi6TLG5yj
 OCmwQ2b/WCglAD5BOT/6rkmIgyalGoN3yfQ2qtVAzXFXNEFyK2OX+w8w0yd55LpnNYTAb0
 +d0zacSv8h8nm02ebiQPswFMa2PMh+c/1YxTt7XnC5RyhfwPe0ZtBQvXkPDfsw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3ZQLU46BmvV1IuLVsClTduT3jipgMqmDy5/JVT9Cdw=;
 b=wWt19ZemBxQjwdnuhEIp6fgur0XhPa6UYuqmQaFsO+UUIUaP6BGpA9Ml8iSwV2XQ9ySdKc
 CZR/Km9flbC105oGBo17GRCRM+zlVhUfCeemjb9ADbAQTQuZvBiCt6lJQsYCxPU1mKsMVI
 lOYQ3o9yEj0BPXo1fA8GUsrCIttNNe+3PgWWJfAGtH9lVEQ5Ms90ejaq4uC7WWxik1WuG1
 3EeROXPBBMRgBHaoVICpRDjC2GI4V/ry7GOmLwTxpjLs68ejiw6PyyI7Mr1bUCtsBsOT/s
 2Xh5VIVnEHASc9rkdxNns8v40WUD5jY1wAJtKxVaL8X0NTsUKD6s3Y7oBVJiVw==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 20/35] fs: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:30:00 +0200
Message-Id: <20230906213015.203437-21-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ab0ba8d02c3020f83f3
X-MBO-RS-META: zqe36drdetbbf8hr5nc3ritbgsxsw3b8
X-Rspamd-Queue-Id: 4RgwXY0H0sz9t26
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

The last user of the NEEDS_MANUAL_RELOC has been removed in commit
26af162ac8f8 ("arch: m68k: Implement relocation")
Remove now unused NEEDS_MANUAL_RELOC code.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 fs/fs.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/fs/fs.c b/fs/fs.c
index 2b815b1db0f..cfc781bbb8d 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -422,22 +422,6 @@ int fs_set_blk_dev(const char *ifname, const char *dev_part_str, int fstype)
 {
 	struct fstype_info *info;
 	int part, i;
-#ifdef CONFIG_NEEDS_MANUAL_RELOC
-	static int relocated;
-
-	if (!relocated) {
-		for (i = 0, info = fstypes; i < ARRAY_SIZE(fstypes);
-				i++, info++) {
-			info->name += gd->reloc_off;
-			info->probe += gd->reloc_off;
-			info->close += gd->reloc_off;
-			info->ls += gd->reloc_off;
-			info->read += gd->reloc_off;
-			info->write += gd->reloc_off;
-		}
-		relocated = 1;
-	}
-#endif
 
 	part = part_get_info_by_dev_and_name_or_num(ifname, dev_part_str, &fs_dev_desc,
 						    &fs_partition, 1);
-- 
2.40.1

