Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D0CC47422
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 21:02:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E3A387979;
	Sun, 21 Jan 2024 22:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J0OQB5BA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 457FB87708; Sun, 21 Jan 2024 22:02:16 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB05087705
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 22:02:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A0D4BCE240C;
 Sun, 21 Jan 2024 21:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDC46C433C7;
 Sun, 21 Jan 2024 21:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705870930;
 bh=rfTkZjUuZSdNKh1rlWNItJX6G5H9yB1K6D6UzoYxBC8=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=J0OQB5BA5FLW/mgOSDrwWbpZwKAFc12im6vIOH/etRwoYpxsef4nAkONnIEuvzIKk
 4I6hvC+Kk+cZ2kAQFvf5jEdfMdF9n4mMSBtbsimmdpKWO62EGPJtSZSc60TKDwzth/
 dw04cBlF6RUYty38p8zcVWP3Fbs6Y14aMeSm44dvNxZFvvTr0xCxoLlcqxr3NYYetM
 NcEfaGRhOqHUjcjGVjGWY9x1iW9C9EknG3s+QgATMLz/0qgWoywxSQ4jGtOC1kDVvH
 4nHnnp4pVV41BxZoh+nKvmf021TBg695F6ogdb3ShbT+Jmh5C6LGUQJMCSlWAPWsaZ
 8Xt/JzNtyUE1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C507EC47422;
 Sun, 21 Jan 2024 21:02:10 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v2 0/4] net: hifemac: a few cleanups
Date: Mon, 22 Jan 2024 05:02:03 +0800
Message-Id: <20240122-net-v2-0-78a368896f62@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEyGrWUC/1WMQQ7CIBBFr9LMWgyDlaor72G6oHRqJyoYQKJpu
 LvYncv3899bIFJginBqFgiUObJ3FdSmATsbdyXBY2VQUrUS8SgcJdEps1O62xMNLdTnM9DE77V
 y6SvPHJMPnzWa8bf++xmFFCNONBwItbH67F/p7v1ta/0D+lLKF2ommeSYAAAA
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705870930; l=968;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=rfTkZjUuZSdNKh1rlWNItJX6G5H9yB1K6D6UzoYxBC8=;
 b=vfjcjhsui3wt8ON0YId3zYCv34pQo2QkrQUdJoRs8Zwy6OmIc+opgqpVpvUAM+XDTT79eVBrk
 n16W9sldqSZDjBHVPwP05rKek4qPUDeEB9Lfv4ga1ElojqOxyGL1MVU
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

Fix the use of log_msg_ret() and add dev_xxx() for error reporting.

Register mdio subnode as a mdio bus device for hifemac.

Implement ops needed by `net stats`

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v2:
- hisi-femac: add statistics related operations
- Link to v1: https://lore.kernel.org/r/20240119-net-v1-0-d1feb8e16ac6@outlook.com

---
Yang Xiwen (4):
      net: hifemac_mdio: use log_msg_ret() correctly, report error by dev_err()
      net: hifemac: fix log reporting
      net: hifemac: register MDIO bus device for subnode
      net: hifemac: implement `net stats` needed ops

 drivers/net/hifemac.c      | 225 +++++++++++++++++++++++++++++++++++++--------
 drivers/net/hifemac_mdio.c |  11 ++-
 2 files changed, 196 insertions(+), 40 deletions(-)
---
base-commit: f7cca7ccc5117eaafcc2bde91ad1bed6fee7cfc3
change-id: 20240119-net-72a32675eeb4

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>

