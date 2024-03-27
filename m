Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1632CC47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 16:26:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 395BE880F5;
	Wed, 27 Mar 2024 17:24:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E89qIIL8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0EFA88167; Wed, 27 Mar 2024 17:24:23 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD68E8815E
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 17:24:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 866C06160E;
 Wed, 27 Mar 2024 16:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873E7C433F1;
 Wed, 27 Mar 2024 16:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711556659;
 bh=Byf4MgfZju9aSqf4XawStp0+ylEdfVLCefy+fFcjQUI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E89qIIL873WRW5G/1L/hSDZrcm3lInRI8wZST83rFYuluBN37Lyb7O+npiVtS8YCR
 cP7m8zHk/BD3J7QcESfI/bmaWbGk0zA5gII/qqt56yY/JFCq83DBpWxsj3qbOTrnGN
 r93OYhhlBo6dehtuKA5gKHFfhlrNhjumpH00RQ3XGjhYBTKedOTJ4HPFPX7QQkiS22
 GsIIpDcWiv34t7ur45zGD6413I/6NAPZE2oyL0KJ/Wrsnx2BoLjUJ/q2z6ly2cx6gf
 qCKBNpTKucai+mNdBs1HYItq9kkXKHdmq/IPjEal7Jm5FrloOM58cYaJldxZYUIc9b
 FY8JiMH96ChdA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v3 16/18] cmd: rng: Print "Abort" on -EINTR
Date: Wed, 27 Mar 2024 17:23:53 +0100
Message-ID: <20240327162355.24584-17-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240327162355.24584-1-kabel@kernel.org>
References: <20240327162355.24584-1-kabel@kernel.org>
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
---
 cmd/rng.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/cmd/rng.c b/cmd/rng.c
index 52f722c7af..48ba67061b 100644
--- a/cmd/rng.c
+++ b/cmd/rng.c
@@ -17,7 +17,7 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	u8 buf[64];
 	int devnum;
 	struct udevice *dev;
-	int ret = CMD_RET_SUCCESS;
+	int ret = CMD_RET_SUCCESS, err;
 
 	switch (argc) {
 	case 1:
@@ -46,8 +46,9 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
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

