Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64233C47DDB
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 14:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B43687956;
	Mon, 22 Jan 2024 15:33:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bZvxqQv0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 395BF8785F; Mon, 22 Jan 2024 15:33:30 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 036DB878A1
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 15:33:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7B573614EC;
 Mon, 22 Jan 2024 14:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DA99C433C7;
 Mon, 22 Jan 2024 14:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705934006;
 bh=t8eOdm8eaQWLmDlJrYsiVJeZtCWqqiz2sfmyGJzGwCE=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=bZvxqQv0uF5zbtRVJL7eEuieDLJAk937x8Ku5mjn6tQK3kKmrEtUo1bb/JDxO34zI
 MCEBeCCEsOW5PRop3U1ttQFV7aU8UUGqILQphhgDmS+/eL8zjFjHeGCoZh5nWIFWtd
 aSrTj5NYGjbxXWhBFtHcQX48H2yLrE9ENUxkOMo+MgxOf1dP7cEv93frpdrl+pIAXB
 xI0FlvY6mH4wKVYr3oVrK2ShddyJ7B/zGIwcAJuUmGeg86PwarGchUdMKqF8X7HKvt
 cmFuHiHCAzLXsicbsiN6owJtO4wEHJZwjYmnTQmM0OUMOXin9p1F+ntX+gCTDs8qZ6
 xcDVIoGIfC86w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 10E3FC47DD9;
 Mon, 22 Jan 2024 14:33:26 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v3 0/5] net: hifemac: a few cleanups
Date: Mon, 22 Jan 2024 22:33:19 +0800
Message-Id: <20240122-net-v3-0-f1e80564725b@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK98rmUC/1WMwQ6CMBAFf4Xs2Rq6xVI8+R/GQymLNGprWmw0h
 H+34EWO8/JmJogULEU4FhMESjZa7zKIXQFm0O5KzHaZAUusSs4b5mhkNWqBsj4QtRXk5zNQb99
 r5XzJPNg4+vBZo4kv69ZPnJWs4z21irjURp78a7x7f9sb/4ClkPDPQvxZmK1aaSGVamQvcWvN8
 /wFLb1XZ84AAAA=
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705934004; l=1219;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=t8eOdm8eaQWLmDlJrYsiVJeZtCWqqiz2sfmyGJzGwCE=;
 b=qdYz47FMgb1P5V0vE3zEmPFxFZwcUvFqNasSNFQbJHE22i9ouHT7no25DPH0eX5scloRV0RY9
 PVpN2ew7ZlYCOGvN61Ww9ZZZ6I0xQcFrT7mOR5tdeaC0PWzUFZSQFfW
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

- Fix the use of log_msg_ret() and add dev_xxx() for error reporting.
- Register mdio subnode as a mdio bus device for hifemac.
- Implement ops needed by `net stats`
- Make functions static.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v3:
- hisi-femac: add missing `static` to avoid polluting global namespace.
- Link to v2: https://lore.kernel.org/r/20240122-net-v2-0-78a368896f62@outlook.com

Changes in v2:
- hisi-femac: add statistics related operations
- Link to v1: https://lore.kernel.org/r/20240119-net-v1-0-d1feb8e16ac6@outlook.com

---
Yang Xiwen (5):
      net: hifemac_mdio: use log_msg_ret() correctly, report error by dev_err()
      net: hifemac: fix log reporting
      net: hifemac: register MDIO bus device for subnode
      net: hifemac: implement `net stats` needed ops
      net: hifemac: make some functions static

 drivers/net/hifemac.c      | 229 +++++++++++++++++++++++++++++++++++++--------
 drivers/net/hifemac_mdio.c |  11 ++-
 2 files changed, 198 insertions(+), 42 deletions(-)
---
base-commit: f7cca7ccc5117eaafcc2bde91ad1bed6fee7cfc3
change-id: 20240119-net-72a32675eeb4

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>

