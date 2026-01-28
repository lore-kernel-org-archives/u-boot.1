Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29348D46BF6
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 19:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FC1083DFF;
	Wed, 28 Jan 2026 20:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Rm2MHfVr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Coea4Tjn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8722183E7A; Wed, 28 Jan 2026 20:42:36 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F42283DA9
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 20:42:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4f1Xjk0nxZz9tFH;
 Wed, 28 Jan 2026 20:42:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769629354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rZQMYW8sub4Fe1nbeWC+qZqhoDHOLT5PoTzD4MPEi+Q=;
 b=Rm2MHfVr/mgRR561Zb/4XY5gCb3NZ1ED+prFVM3f/R1nk7JmXFziiw5WGp7hV1Z9oAUZjx
 RcKTtl5VHbv5Wh9M+fxcZVEkRNfCnqJ1yygbxr0TCHmMEsU4KF+NctOsGXlDOV0ClHF4VH
 mymQ303/D8e+Djw6HCeTfxI3pwnuhRH6EOD1ot67bniWwAq2l8pR3YWNmA7FsM2F9eG+5a
 KkPSFzQxGkB+4FgFvolPEVjHF31DYivgJDcnvqaLBig5/TPTe1RroNKQLs94wN5ptbgf+s
 yUrW42Rii/6Q9pfMukOoeWShCM+FBin8MWvxTEwxbxdJytifDIbLxyO4tHrNDw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769629351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rZQMYW8sub4Fe1nbeWC+qZqhoDHOLT5PoTzD4MPEi+Q=;
 b=Coea4Tjn/up+se9+PQf8rDk/sXu21yqvaa2LBitKOu+cozaBrBL/eQOqsHQELzfnex1/JC
 78c0FniD1NLVYuaeK7dtskjbBbWlUclawKIhrgmDzofJbaefSQplUWM9BFomDfzzai6ZQS
 85FigUPa14sex17ohb2a6kEojTFV0uoDH59eSaNMDT9eYhBZpDelSV3kk8YtVE8vePZqLb
 64XzPqJpV3cwj0WTsTh2HeBXVduynLU2QWDiutDnV+2eUwnWEvNiwCjvJR+41omvnlnlGI
 aKQfjO0axE4h8x5cFX8TSki5h8qYfs1INaud6zTK9asy0q1bol5MKeMTgQwmww==
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
Subject: [PATCH] cmd: zip: Add missing unmap_sysmem() for buffers in the unzip
 command
Date: Wed, 28 Jan 2026 20:42:03 +0100
Message-ID: <20260128194226.278605-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1d10fa2fbf6c804b090
X-MBO-RS-META: 51pte71j68ff5ticpfd4owcq9cpxkz6u
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

Unmap the sysmem that got mapped by this command.

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
 cmd/unzip.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/cmd/unzip.c b/cmd/unzip.c
index ba83995040b..39af50f488d 100644
--- a/cmd/unzip.c
+++ b/cmd/unzip.c
@@ -16,6 +16,8 @@ static int do_unzip(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	unsigned long src, dst;
 	unsigned long src_len = ~0UL, dst_len = ~0UL;
+	void *srcp, *dstp;
+	int ret;
 
 	switch (argc) {
 		case 4:
@@ -29,14 +31,21 @@ static int do_unzip(struct cmd_tbl *cmdtp, int flag, int argc,
 			return CMD_RET_USAGE;
 	}
 
-	if (gunzip(map_sysmem(dst, dst_len), dst_len, map_sysmem(src, 0),
-		   &src_len) != 0)
-		return 1;
+	srcp = map_sysmem(dst, dst_len);
+	dstp = map_sysmem(src, 0);
+
+	ret = gunzip(srcp, dst_len, dstp, &src_len);
+
+	unmap_sysmem(dstp);
+	unmap_sysmem(srcp);
+
+	if (ret)
+		return CMD_RET_FAILURE;
 
 	printf("Uncompressed size: %lu = 0x%lX\n", src_len, src_len);
 	env_set_hex("filesize", src_len);
 
-	return 0;
+	return CMD_RET_SUCCESS;
 }
 
 U_BOOT_CMD(
-- 
2.51.0

