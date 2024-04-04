Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855ECCD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 07:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77812883C2;
	Thu,  4 Apr 2024 09:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="esEnkOum";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37A7388406; Thu,  4 Apr 2024 09:51:36 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D42C98840C
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 09:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 38060CE2FB7;
 Thu,  4 Apr 2024 07:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C230C43390;
 Thu,  4 Apr 2024 07:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712217091;
 bh=lJNzrB10In6m1J330X+5jZwAoE8Eba/tswMZmUzqkwY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=esEnkOumi3QK31icAKugKl2EvLgXQ+bUsM7uOAo9/Mn3UNDHSE44f6a89fvlLyMwY
 +ggOUMtK9MKX1eO0qkVdkbd0miUL/XIuTUZnTLxRY4ys+ZxAhc3n5Hu4OyZCq6RYcA
 t4x8koj73bw/KLjY8dayjhculvIMOphO7Qw9/ND8j8teiwCtSAA5FNGVgGzj0eS9Ui
 sug+kE5pWbgslTD06opXYvWFnztu/S8aPcG9SWLqHk8NzXfActqaiJemyTJcyb48tg
 qVWkHYSpy2AMr1BbY0bn/tbWaQWx41JAn7+sn54cjuBCFEaG+Eg/RqbQescObjgxmz
 iAog+0CBd+FWg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v4 16/18] cmd: rng: Print "Abort" on -EINTR
Date: Thu,  4 Apr 2024 09:51:05 +0200
Message-ID: <20240404075107.19636-17-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240404075107.19636-1-kabel@kernel.org>
References: <20240404075107.19636-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

In the rng command, print
  Abort
instead of
  Reading RNG failed
if the error number is -EINTR, which can happen if the user pressed
CTRL-C.

Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Stefan Roese <sr@denx.de>
---
 cmd/rng.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/cmd/rng.c b/cmd/rng.c
index b073a6c849..e5ab868112 100644
--- a/cmd/rng.c
+++ b/cmd/rng.c
@@ -17,7 +17,7 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	u8 buf[64];
 	int devnum;
 	struct udevice *dev;
-	int ret = CMD_RET_SUCCESS;
+	int ret = CMD_RET_SUCCESS, err;
 
 	if (argc == 2 && !strcmp(argv[1], "list")) {
 		int idx = 0;
@@ -62,8 +62,9 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	n = min(n, sizeof(buf));
 
-	if (dm_rng_read(dev, buf, n)) {
-		printf("Reading RNG failed\n");
+	err = dm_rng_read(dev, buf, n);
+	if (err) {
+		puts(err == -EINTR ? "Abort\n" : "Reading RNG failed\n");
 		ret = CMD_RET_FAILURE;
 	} else {
 		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET, buf, n);
-- 
2.43.2

