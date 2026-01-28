Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FFBD46BF6
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 19:41:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F6A783E7A;
	Wed, 28 Jan 2026 20:41:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MOdirfng";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KC+Pg9dt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F8BF83E63; Wed, 28 Jan 2026 20:41:26 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BE2083E83
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 20:41:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4f1XhM70cQz9tRX;
 Wed, 28 Jan 2026 20:41:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769629284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=V0TQUhm7+SrqgMz7naupz3IsaV92armC4Ov2rQ7WHWc=;
 b=MOdirfng59fFqySe8bYZGDOuOV31MWYqXmdsEv6hJq4sdQby7Tg9yMkCVg6UpIRJnQlfOD
 ZRDATNPAjrfZaNXIrcL5Cc8uuABSl3Ws6XtiAuaCIZtdv7VcGkdoYFhJ8DRYEwptCESmwC
 EY8bSwSzfemZiHc1yD658uiyPudODSaDjgWbpLw2b6TGBZxEtp992uIvW6D4LqEx2ctxeo
 4ea2SuAWaCiWfGLRfwYEM1tZq07EugA6y2BuCcjpuoSMlH7ogzMzn90r8VNMsSsn2iu/rH
 FWeFiUbSZydzoh3h6GszZVXPZD/rjHNMh5B42D+u03jR0WBMWQlT6MGJkTAB6w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769629282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=V0TQUhm7+SrqgMz7naupz3IsaV92armC4Ov2rQ7WHWc=;
 b=KC+Pg9dtlB3wxCPh6tuYZ+4ORYvJhn9/3ylYVm90Y85K69BvwTL8G/b4f1zpxU/WZxGuva
 zF2XumgUbg33M/Nia/46gRDun+ibjIgTiwvgnybkIKgLdr1kdsXnw2aTveoZVRM+Fay62R
 W1pQCJ56Y38Y0zuOd/bj+Sn9OJtKcvrUnATKHNQtSNSwuzn3yxw6ngEFmoTjoSfT0GSWWF
 /OXOG6v/rLVMeyPQVIs9s6klseHGstXm0vXTcT3UJQ4qsZ797v5cOT7f5w5q8rhKNEHm+z
 ujJuPdGEQlVRD/ajmuWn4w+PH56MgCpEeTrw9kJULrCfJ98oqtU3eu3LXijAFw==
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
Subject: [PATCH v2] cmd: unzip: Use map_sysmem() with buffers in the gzwrite
 command
Date: Wed, 28 Jan 2026 20:41:04 +0100
Message-ID: <20260128194117.278566-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b53e12fcc876640b2e4
X-MBO-RS-META: c1rgdtqirrxi7xk6hj7bb3iti7z3wm9w
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

Convert 'addr' variable to unsigned long, as that is the return type of
hextoul() and address parameter type of map_sysmem().

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
V2: Add missing unmap_sysmem()
---
 cmd/unzip.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/cmd/unzip.c b/cmd/unzip.c
index da958f12803..ba83995040b 100644
--- a/cmd/unzip.c
+++ b/cmd/unzip.c
@@ -50,11 +50,12 @@ static int do_gzwrite(struct cmd_tbl *cmdtp, int flag,
 {
 	struct blk_desc *bdev;
 	int ret;
-	unsigned char *addr;
+	unsigned long addr;
 	unsigned long length;
 	unsigned long writebuf = 1<<20;
 	off_t startoffs = 0;
 	size_t szexpected = 0;
+	void *addrp;
 
 	if (argc < 5)
 		return CMD_RET_USAGE;
@@ -62,7 +63,7 @@ static int do_gzwrite(struct cmd_tbl *cmdtp, int flag,
 	if (ret < 0)
 		return CMD_RET_FAILURE;
 
-	addr = (unsigned char *)hextoul(argv[3], NULL);
+	addr = hextoul(argv[3], NULL);
 	length = hextoul(argv[4], NULL);
 
 	if (5 < argc) {
@@ -75,7 +76,11 @@ static int do_gzwrite(struct cmd_tbl *cmdtp, int flag,
 		}
 	}
 
-	ret = gzwrite(addr, length, bdev, writebuf, startoffs, szexpected);
+	addrp = map_sysmem(addr, length);
+
+	ret = gzwrite(addrp, length, bdev, writebuf, startoffs, szexpected);
+
+	unmap_sysmem(addrp);
 
 	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
 }
-- 
2.51.0

