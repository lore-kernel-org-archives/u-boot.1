Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE136D2FEF4
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 23:53:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FBB8841FF;
	Wed, 28 Jan 2026 00:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="crmEjy2Z";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pWJ3g7l/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56FA684201; Wed, 28 Jan 2026 00:53:47 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79A94841D7
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 00:53:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4f12L12DLJz9tqK;
 Wed, 28 Jan 2026 00:53:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769558025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Sl0Lqni5J/muyGjzvFzFzPSJwu2CFgbTD2uFbLYam18=;
 b=crmEjy2ZGtYy27awXQ7K36QWOB4gqUP2kMkIJIZvdGcwVa58V1+zcUaeAl6EEgWUsAhxf4
 jWhICtGZeuhVhP62vj7MIZsU5WsSEvLnDAT2dHpNb7cWA7EVLOJApnfrZTpS7iusijFCE3
 K/YjLUgMKoExZLen2HVoZ2jyG46x4ifGXXR1CLbChQ56B/scT32l+aDodJm2eJHeliyn8O
 8pM+bFMLkH12tA5EFl2cRd4ImXaioy/zxKObrBfkJLl1wu+R4oTpuZUgadLhTaVgSIhVKD
 iOCnIyUH5DPGnI8HddQuSRAqx2k1hQcg1WYHP9RBoYdnV7FVGUBGX6DY77CpDQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="pWJ3g7l/";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769558023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Sl0Lqni5J/muyGjzvFzFzPSJwu2CFgbTD2uFbLYam18=;
 b=pWJ3g7l/MkCwMBiZC+trrk04GhLTGTrf5J5fF9iAJ3X34GJidia43qga76OoLWtn4N5xYg
 QDEeCyv6zBSmlUH+prlNTr5LYoWBvj5YPikd4flxO85uuqrZR16xr6aYtjcODyNqj0S/cZ
 qmlQgVIBpEAFVqTILZbKol5OSDg9fyhB+f9ZB1t//eTjjuIOKFYRjc77sGAjPllYFWODcR
 4F8jNLcXhJIqo0w+lquLVXMlwLQWdaF2TldTRXVV1hsX5TT+LCx2a2yzT7fiGzxVnWyoGt
 9q7EcbNF58fqxi/Y3azdfG4dA115BwNzX/cHtiBlxOx60C1F16+dAE8NU9zE5Q==
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
Subject: [PATCH] cmd: zip: Use map_sysmem() with buffers in the zip command
Date: Wed, 28 Jan 2026 00:53:23 +0100
Message-ID: <20260127235339.1503312-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 36f21f67095f13f2158
X-MBO-RS-META: ruopmxytsjfidrhgda1ehqsz8ru6nf4r
X-Rspamd-Queue-Id: 4f12L12DLJz9tqK
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
 cmd/zip.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/cmd/zip.c b/cmd/zip.c
index 2d255428822..1712434ba0a 100644
--- a/cmd/zip.c
+++ b/cmd/zip.c
@@ -7,6 +7,7 @@
 #include <command.h>
 #include <env.h>
 #include <gzip.h>
+#include <mapmem.h>
 #include <vsprintf.h>
 
 static int do_zip(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
@@ -27,8 +28,10 @@ static int do_zip(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			return cmd_usage(cmdtp);
 	}
 
-	if (gzip((void *) dst, &dst_len, (void *) src, src_len) != 0)
+	if (gzip(map_sysmem(dst, dst_len), &dst_len,
+		 map_sysmem(src, src_len), src_len) != 0) {
 		return 1;
+	}
 
 	printf("Compressed size: %lu = 0x%lX\n", dst_len, dst_len);
 	env_set_hex("filesize", dst_len);
-- 
2.51.0

