Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF5BC54E58
	for <u-boot@archiver.kernel.org>; Sat, 23 Mar 2024 18:10:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C4D987F95;
	Sat, 23 Mar 2024 19:07:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FcaG609R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 864CE87FC0; Sat, 23 Mar 2024 19:07:44 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6612E87D8D
 for <u-boot@lists.denx.de>; Sat, 23 Mar 2024 19:07:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D0DDF60B2C;
 Sat, 23 Mar 2024 18:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62264C433C7;
 Sat, 23 Mar 2024 18:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711217256;
 bh=ewRGcb1rTah6ovhLRvzrl0VBI34TgLXbLxpwd5A9cVU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FcaG609R/22p/Y0VutDt4vRvSub0pMtqysFX6z70g2XzcOtTYt7I1N8rnd2kFY9Pi
 4TwR77ZWSYRoE0Gxi80WuM6FysU30raUjffMAUEAZY1Dfwtn0cMqAPmZwBTu45dEzE
 p51H0Mdjl68dzBdVoxLSQtYTHU5J0a8uqaBi5Uf2+Uy5yngQB5D1oGxzyx0yZQqmYJ
 Xpem1sq4lMvI0nOihQDh1Mqkrmzl65c7/oLtY3v+KW6Z3wfty7nrZ22AqMjh68YUsX
 tdV2+Boejk7bWwalirGUvzEUphk5icVY59UQjSpjfIsWsgdSU8U2/aGaOydxzfPOYs
 bpGFHHB1B3ZwA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v2 16/18] cmd: rng: Print "Abort" on -EINTR
Date: Sat, 23 Mar 2024 19:07:09 +0100
Message-ID: <20240323180711.5498-17-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240323180711.5498-1-kabel@kernel.org>
References: <20240323180711.5498-1-kabel@kernel.org>
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
if the error number is -EINTR.

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

