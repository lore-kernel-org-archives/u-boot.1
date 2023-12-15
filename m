Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6131C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 20:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5463787C52;
	Fri, 15 Dec 2023 21:21:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i20XGHyn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 376C287C32; Fri, 15 Dec 2023 21:21:36 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9E8387C68
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 21:21:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 9B60DCE2F04;
 Fri, 15 Dec 2023 20:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA020C433C7;
 Fri, 15 Dec 2023 20:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702671689;
 bh=SKY4LgXtKD+i6TcOtQoS3pmGKg16zPkxWFl7D+VUbAE=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=i20XGHynKaFTcxWuV99Y2jFuPaJpt1WEJOrWa8MKgSib7uPd5fhkvJ9aC5i/pOAvZ
 1ojexRB1hKajzsPup2inZaA+T0J2Eukl9TIo4bWBiFdARaNN+uxUrXQueStfQgcd2c
 ReZfcILtRCFBZcP6CfljtEBD86/jcjoxUEaq82cTIr+F0TRfLrNZjG8Iia4gyuyNhf
 UJYn2XahEjfTSARXH12Co8XYOPXuXaE/Ibkp0cXiKSsjP9dQKww4v/2IwKZMwsEeuL
 h4GFweTFhMj6ygBWd2oxrPpd7NivKtfU5lbyCFEP5em6Yv+prBnS0QCA1jjWnGa7C/
 JAhU0SJJ1JXog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id BEBC1C4167B;
 Fri, 15 Dec 2023 20:21:29 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 16 Dec 2023 04:21:11 +0800
Subject: [PATCH] test: dm: clk_ccf: fix building error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231216-b4-fix_build-v1-1-b8e79c94744f@outlook.com>
X-B4-Tracking: v=1; b=H4sIADa1fGUC/x3N0QqDMAyF4VeRXC9g46ZjrzJEmjZqoHSjRRHEd
 1/Y5X/g45xQpahUeDUnFNm16idbuFsDYfV5EdRoDdRS58j1yHec9Zh40xQxto+ZmPrw9AMYYV8
 FufgcVkN5S8nGbxET/4/3eF0/jmOJd3MAAAA=
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702671687; l=965;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=+YXHGjJV5RfD1cYTUUsRy7jDcslvBWZ6f1oAnKJy2ik=;
 b=n93+32jLKxGIt2ZK5H1I6ciRL0d34TBI5fIQo9rECktwXXleLGzehEsIHl2j+cHS9rrn0v469
 ETiKx4IKPtFBSK/Voo4BcX3xo1mEBQKsxP2il5JZx6Bpb44/aQ5Rga+
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=hfdpPU3AXR+t7fdv58tXCD4UzRNq+fop2TMJezFlAhM=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230415 with
 auth_id=44
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Yang Xiwen <forbidden405@outlook.com>

Fix unused variable error produced by building tests

Fixes: d3061824 (test: dm: clk_ccf: test ccf_clk_ops)
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
it's detected by u-boot gitlab CI.
---
 test/dm/clk_ccf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/test/dm/clk_ccf.c b/test/dm/clk_ccf.c
index b8be6d6572..5a3c58c6b5 100644
--- a/test/dm/clk_ccf.c
+++ b/test/dm/clk_ccf.c
@@ -18,11 +18,12 @@
 /* Tests for Common Clock Framework driver */
 static int dm_test_clk_ccf(struct unit_test_state *uts)
 {
-	struct clk *clk, *pclk, clk_ccf;
+	struct clk *clk, *pclk;
 	struct udevice *dev, *test_dev;
 	long long rate;
 	int ret;
 #if CONFIG_IS_ENABLED(CLK_CCF)
+	struct clk clk_ccf;
 	const char *clkname;
 	int clkid, i;
 #endif

---
base-commit: c9945276f77921feb8df7be75cced3338d08e8d4
change-id: 20231216-b4-fix_build-d05f2b26c8a7

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>

