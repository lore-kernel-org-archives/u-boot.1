Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1B5C4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 23:02:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A40D387EA2;
	Sat,  3 Feb 2024 00:02:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pZIY8l76";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F4E087E9D; Sat,  3 Feb 2024 00:02:00 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E59E87EA0
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 00:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 78FC9CE2A37;
 Fri,  2 Feb 2024 23:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7F85C433F1;
 Fri,  2 Feb 2024 23:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706914913;
 bh=XfSE37beJzpzPrXF96yeMvNm267FWmYb60Dr6neV8/I=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=pZIY8l76apWENTnFQ50Zyeu779DEbuw77DxwnPYY2boJNUKjwqC6ViZz5hEGZ8dCP
 2XQ0gsL/pS6BbL7bR5NgEBmUkTK858jv7LXN692jFr0Cyb9eoT9JWXOwQm+CYzDYNU
 CGOzp/uz70Ez/WhvGZXAv5mNx60pX5k9JLoCGKePJSvQuix387J1l3+K5Zs1sdRvek
 6cINSRiMEOPwDAOH4+AX5kac6s4nQDCy2lHEwEVlFtcUcAJULwOTzUVU1Hlpnamw2D
 kM5QfzT5OUHkHjdqY+DVOILSARNrB3MHDiyYAcc1F7NaWMWVeL6DYedqfZmy//AnDj
 4qcA95jeARsoA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDDCC48295;
 Fri,  2 Feb 2024 23:01:53 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH 0/3] usb: dwv3: add glue driver for hi3798mv200
Date: Sat, 03 Feb 2024 07:01:53 +0800
Message-Id: <20240203-hisi-dwc3-v1-0-448050c7b690@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGF0vWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIwNj3QygEt2U8mRjXeNkE/M0c2OT5BQjAyWg+oKi1LTMCrBZ0bG1tQC
 1bbUZWwAAAA==
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Sean Anderson <sean.anderson@seco.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706914914; l=704;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=XfSE37beJzpzPrXF96yeMvNm267FWmYb60Dr6neV8/I=;
 b=oo7IHJM8FAyP0vjIEzi8+e+F+IzUCsnlaoSxQQskPBaHhWW+g9Mvnjj/j7BULcS7s2NAUw46+
 WzfVaXiCWEfDv502OZTDg7QriojAUOlEkNuq4gP5HHC1KXLA8BvaPxr
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

Also edit the prototype of .glue_configure to fulfill our needs.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Yang Xiwen (3):
      usb: dwc3: handle return value of clk_get_rate() correctly
      usb: dwc3: replace argument mode with child ofnode
      usb: dwc3: add glue driver for Hi3798MV200

 drivers/usb/dwc3/core.c         |  2 +-
 drivers/usb/dwc3/dwc3-generic.c | 52 ++++++++++++++++++++++++++++++++++-------
 drivers/usb/dwc3/dwc3-generic.h |  3 +--
 3 files changed, 46 insertions(+), 11 deletions(-)
---
base-commit: 050a9b981d6a835133521b599be3ae189ce70f41
change-id: 20240203-hisi-dwc3-3c47f734cd20

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>

