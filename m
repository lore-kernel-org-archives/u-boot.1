Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C62606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FjWGpdW7;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=yL4tQSHt
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 625C7814BF;
	Wed, 11 Nov 2026 14:21:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3aw1Oa1K2T4c; Wed, 11 Nov 2026 14:21:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9A7538144F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794406897;
	b=kcLfkfCQ/Lbx+NVzRflAPwFp5i1ecaxgGoA87dGUMsUAO5s6kYXhxxk9cWNKwvdwwslG
	 JRG62LcSpEDKGoKD3sNGR0mYSahbl0EEQe2Lopn3efY28WtG35Y2uA/jO73vlI2WIC4nX
	 BfCCVXOx1grdf3/DD2JjsBOamnLwumz9Ay0yqjlAA5nyjlHkUaRHBQOAisCLPOdUiwfVh
	 49L44SsQCfi0qt6PUGse3v7igvqY0dK7vMRUXCGz5qERnZeOhqZzG76P8U4OMV5YwbUuH
	 ZjZaWXVeyNXGg2oLcbn9Whzp2gOJ9xtKCEhy1ge4f6o9oSiQzCp3pbSA0mSwGTKCB2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794406897;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EsIG8AVhI9yyiSwslHM1jgY8cb1V39mprZnf+HDrdP0=;
	b=LOImwhC2YXzGV1gag0QT0qUAzqxExFllx7tQxZni4/TDIRpJWoi5+D36J1jSuWVLq8Fi
	 DhiJLdBKTSmkDO0Oxozq+3O4/WJ5sW8/D/KyyaoYJ9zDsUDYjz+P2x7jxNOBhmFu9TUEY
	 x9DMLO8/YpVCrContasrLtx4D10PQkfltVHI4DUM8nZ3oo5h56lDSlFn52S1rWf8f8G4e
	 sbkayBir0wuPkEV2GgUhCW/mTxxuj+2Qk5eRKjCbVf2ovjv8xmECvhA2VNkRgyRZixR7o
	 9bNVf6xVnT5AIDQlIw68Ryn4vddMa0J+0UsNVZLmtVtCdeBK/CN6ac0DJXZXqByEW+g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794406897;
	bh=EsIG8AVhI9yyiSwslHM1jgY8cb1V39mprZnf+HDrdP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FjWGpdW7utFjYLkRlZk98pAFzisiLn6a6HlLNz4EIynTfVWFY7gdLAg/wl7RS3IZi
	 XGrK/PiXMvZecl79T/QNpc8vzP5gqQj1BEWsq28IGMTSR2SllsJJnokNCxjFcbliPp
	 yedSHmJQcOlfPqC2FATTT/ItngUNSL/QtIiUzrUkOdL9qvZIuBLjgfaGVICMST+Xjw
	 B4WindNX7V8YeZ2OrtI4OAh1k8WoPo8n98KJhMHm/0jVBEfoRyMo8h+CKwYfwrIe22
	 cP6TylzJcj51LArtYiCyHEkUtSrFQYsY0DdPte289W/kNqkMl+CCNb3zAG7gYBSCK6
	 99r0dBBI5o9gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A7538144F;
	Wed, 11 Nov 2026 14:21:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FC69731
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 54D83403B9
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i8NQFIoB3gwm for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 14:21:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9BABE403C5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4b7e:0:8::81"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4b7e:0:8::81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=yL4tQSHt
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9BABE403C5
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:19 +0000 (UTC)
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 5986D22A1B;
 Wed, 11 Nov 2026 15:21:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1794406873;
 bh=EsIG8AVhI9yyiSwslHM1jgY8cb1V39mprZnf+HDrdP0=; h=From:To:Subject;
 b=yL4tQSHtA5gBZpJE9k6KiEcEpZ8FdmqTgeiOPf+FXQ7fh8R8soDlRqbLAWoafMpM3
 AEoSaU/JZaDMzeTsvQX/rQBtKAYUN0LE2ZIKLxLfh++9U+jBVUuiRJ3H9mJy7xbpyH
 2j5eNIAkE3yquUemUHPNYO5w03aDz4U8jQ+udtzgMkZokE5tPyfxEJwbYDWMII9nM+
 o4umyHe17nti9S7kGLzW1qk1fFaPB5AXnwVIaXBehbcxeHgifeczoXYByWFZj2SnFK
 IZcRpR2+snvErbtWrMy2CeaQQ4zP0qrGSIsO7UsMreeAKmxbb7FaF9gckZ7kQFyDkG
 wwWO1DbQynr5w==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 05/15] board: toradex: colibri_imx6: fix do_fuse argv[1]
 NULL deref
Date: Wed, 11 Nov 2026 15:20:53 +0100
Message-ID: <20261111142104.109139-6-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111142104.109139-1-francesco@dolcini.it>
References: <20261111142104.109139-1-francesco@dolcini.it>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Francesco Dolcini <francesco.dolcini@toradex.com>

argv[0] is the command name itself, so argv[1] is only valid once
argc >= 2. Running "updt_fuse" with no arguments has argc == 1 but
still dereferences argv[1] in strcmp(), reading past the argv array.

Fixes: a02d517b0182 ("arm: imx: initial support for colibri imx6")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/colibri_imx6/do_fuse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/toradex/colibri_imx6/do_fuse.c b/board/toradex/colibri_imx6/do_fuse.c
index 8721276bed83..411a6300e1cb 100644
--- a/board/toradex/colibri_imx6/do_fuse.c
+++ b/board/toradex/colibri_imx6/do_fuse.c
@@ -54,10 +54,10 @@ int do_updt_fuse(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	unsigned val;
 	int ret;
-	int confirmed = argc >= 1 && !strcmp(argv[1], "-y");
+	int confirmed = argc >= 2 && !strcmp(argv[1], "-y");
 
 	/* can be used in scripts for command availability check */
-	if (argc >= 1 && !strcmp(argv[1], "-n"))
+	if (argc >= 2 && !strcmp(argv[1], "-n"))
 		return CMD_RET_SUCCESS;
 
 	/* boot cfg */
-- 
2.47.3

