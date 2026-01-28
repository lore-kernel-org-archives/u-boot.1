Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BC1D46BF8
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 19:42:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F335783DFF;
	Wed, 28 Jan 2026 20:42:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="heMk3cmt";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fEhIK10Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0DBA83E63; Wed, 28 Jan 2026 20:42:00 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E047183DA9
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 20:41:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f1Xj24Bvvz9sQX;
 Wed, 28 Jan 2026 20:41:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769629318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=EL1Enut7kBRdiT06KJjFcP5QQaHZtfD1NbmK2Q8N9Bw=;
 b=heMk3cmtwO7eOnsjhVT3LZRf4PgGvPttvwLMwBB+Qu5c24IN5pxpMVNOGUt22SK9jylbiw
 SJ7IveWg6uDxSxrY3c01rSPdFFNyw37VLnPBX64+JgEg/MLgTEelJOg08fjvwJl+M6VPI4
 27gZsjR6A3yGuzhdka7H0BjBhaY2anNamD04l3n+in5Fa3CoX3/aVc/gjmYzc5BBQ+76DD
 UqDiyqDXJlSImOw8gxBTmrTnObxcP/ONchWCfawJJbiz66wik2MXztDBFlmAY+tdeynDwa
 2vxtgOa/5ozqbffBhr6lYcDfOSv6Bg6KNUgdM0Zc2STUh4+YYJCvV/dLiVzDJQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=fEhIK10Y;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769629316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=EL1Enut7kBRdiT06KJjFcP5QQaHZtfD1NbmK2Q8N9Bw=;
 b=fEhIK10Y2Bm/r9ydEQkde+cj4KgUJoG4OIR6A/kt6hR9A6rRbIveVPYN0MfPCrWtYTBuSO
 IjrMQiXbCjZSVgUJAsi5HKKC2V49t1EFg/bKUDvICP/L9oTdtg8eixxVQKZU9HC64HeZob
 DfcMw1W6vYT6P+uRtW/LopMEsDxMqnHT+TEbKTMgMh4I/Yt5cQbDpCbmIYE5BRcuKjKVgW
 mVaD3EzQpwSThpXhS5CifmW+aN1Wq1aExGw/rKhh2fYN7vP1zLlgsR8K03L1ycB4kU12j5
 17spXPDnTUHrSHHR3G3OyJ2o1TpBUNb699x2W4tJhBqTTZ9fh+s2K4+rT+V6Mw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Graf <agraf@csgraf.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: [PATCH v2] cmd: zip: Use map_sysmem() with buffers in the zip command
Date: Wed, 28 Jan 2026 20:41:30 +0100
Message-ID: <20260128194152.278586-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e6de8ff0694ab03e2f8
X-MBO-RS-META: fgdu56ctpcqn7kye35hik748d79iqnbp
X-Rspamd-Queue-Id: 4f1Xj24Bvvz9sQX
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

The current implementation casts an address to a pointer. Make it more
sandbox-friendly by using map_sysmem().

Use symbolic return value for the command while updating
the return value handling.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Alexander Graf <agraf@csgraf.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome@forissier.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Cc: u-boot@lists.denx.de
---
V2: - Add missing unmap_sysmem()
    - Use symbolic CMD_RET_FAILURE/CMD_RET_SUCCESS return values
---
 cmd/zip.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/cmd/zip.c b/cmd/zip.c
index 2d255428822..4bd1179390b 100644
--- a/cmd/zip.c
+++ b/cmd/zip.c
@@ -7,12 +7,15 @@
 #include <command.h>
 #include <env.h>
 #include <gzip.h>
+#include <mapmem.h>
 #include <vsprintf.h>
 
 static int do_zip(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	unsigned long src, dst;
 	unsigned long src_len, dst_len = ~0UL;
+	void *srcp, *dstp;
+	int ret;
 
 	switch (argc) {
 		case 5:
@@ -27,13 +30,21 @@ static int do_zip(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			return cmd_usage(cmdtp);
 	}
 
-	if (gzip((void *) dst, &dst_len, (void *) src, src_len) != 0)
-		return 1;
+	srcp = map_sysmem(src, src_len);
+	dstp = map_sysmem(dst, dst_len);
+
+	ret = gzip(dstp, &dst_len, srcp, src_len);
+
+	unmap_sysmem(dstp);
+	unmap_sysmem(srcp);
+
+	if (ret)
+		return CMD_RET_FAILURE;
 
 	printf("Compressed size: %lu = 0x%lX\n", dst_len, dst_len);
 	env_set_hex("filesize", dst_len);
 
-	return 0;
+	return CMD_RET_SUCCESS;
 }
 
 U_BOOT_CMD(
-- 
2.51.0

