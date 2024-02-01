Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84D7C4828F
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 14:05:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA43687C69;
	Thu,  1 Feb 2024 15:05:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qTGUI+Ka";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B8A887BDB; Thu,  1 Feb 2024 15:05:47 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6C3486DD2
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 15:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AD4486144D;
 Thu,  1 Feb 2024 14:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CD3EC433F1;
 Thu,  1 Feb 2024 14:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706796343;
 bh=KW4B22ZfQHHRcm4cEXbaEE074Oc0+WDqCDdlBgm91xo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=qTGUI+KaTIx0VJGJ5B+bAtYlk76JMomlwTeSGWpvdn9Y+wihgrEGuNT4OBuNuhWfY
 Fz1oo4ZVprNQvSApiHTN45gU2mRlrembJjb+8HfwWoGP+slV7JWMxaqd2i+Tba/xs6
 yJP/QawwK3IWKugcZk2zUqjpnMCcmZNSYaLdaJH7WfATE9XKboxxc3smW74ISNGvjd
 QLG8afw/eCK/TfMQYNOhFkIorwvadjz0lm1/zYk0kK0//HVijBIWebW1ELvnMT7Wnq
 F9E8PzmcocSNmDQnypQ+noifTmrDwGaRq+JVy4NtJMR7pzY4c+AvHLDh+Ms4kIPT4R
 HgOFrq8LEYADg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 44E0FC4828D;
 Thu,  1 Feb 2024 14:05:43 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 01 Feb 2024 22:05:43 +0800
Subject: [PATCH v2 2/3] mmc: dw_mmc: Don't return error if data busy
 timeout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-mmc-v2-2-9f09dc1335fd@outlook.com>
References: <20240201-mmc-v2-0-9f09dc1335fd@outlook.com>
In-Reply-To: <20240201-mmc-v2-0-9f09dc1335fd@outlook.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706796342; l=966;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=7I6x1oiNonfhfkY+33Aj1D+ocpUIR/g2QtbazCaveps=;
 b=lPdzazMTK3SbqyId2a6GgZSKuF1bkKJqIsnavlmh4ntQjGooNlkQgJmdTwn9yQcOO94ETSFuu
 46uwv+nYnnoCn4q3qxZyVfAZnXzuKW5pYQaIvJDZSapgLrm4BqGLZ8j
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
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

As described in [1], some poor hardware or cards would fail to release
the bus and keep driving data lines low. Ignore it and send the next cmd
directly seems okay for most cases.

[1]: https://patchwork.kernel.org/project/linux-mmc/patch/1424458179-5456-1-git-send-email-dianders@chromium.org/

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/mmc/dw_mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 400066fa99..e103664145 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -262,8 +262,8 @@ static int dwmci_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
 
 	while (dwmci_readl(host, DWMCI_STATUS) & DWMCI_BUSY) {
 		if (get_timer(start) > timeout) {
-			debug("%s: Timeout on data busy\n", __func__);
-			return -ETIMEDOUT;
+			debug("%s: Timeout on data busy, continue anyway\n", __func__);
+			break;
 		}
 	}
 

-- 
2.43.0

