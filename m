Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7936C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 11:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6B5E87C6B;
	Fri, 19 Jan 2024 12:44:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="klf62hoY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBA76871A6; Fri, 19 Jan 2024 12:44:35 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05B5187BB3
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 12:44:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 481FDCE2212;
 Fri, 19 Jan 2024 11:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84FD8C433F1;
 Fri, 19 Jan 2024 11:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705664669;
 bh=GosKtxU73aFIPQGFRc6FM8kcXFBSXm3PgdAcWrgvLFU=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=klf62hoYuVkoUwrgE11ovULuLOb1ICvOSrL5GGe0Y23rwfV7ucCsxDEbyh/9CVBls
 K6Y8RCKPFIeTROQvUqaasNHZ54P+rSnkD3Z69ZguTaz0hBeKNE03hIU/0nJYm8WXgE
 LNI4jE8HA8LllyZNGR95auRSfag2cY7JAme/LomrwegfG2hUUqB5BMb0KPyDLcAvrw
 lXC79BdDrl6n705RSkf7ijvcSvGwkg9A+0ZBMitlf+/BchNgOa6kh8IS+xdZ2Uc34Z
 xriSYdwftGC+Yze3ytGqYjQ2RQj0i30dStnnzGmlaI+EwdbVQa8Kj3rit/UGxZ5KUZ
 OWs09z1cFX+Ww==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 6D045C4725D;
 Fri, 19 Jan 2024 11:44:29 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH 0/3] net: hifemac: a few cleanups
Date: Fri, 19 Jan 2024 19:44:27 +0800
Message-Id: <20240119-net-v1-0-d1feb8e16ac6@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJtgqmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQ0NL3bzUEl1zo0RjIzNz09TUJBMloMqCotS0zAqwKdGxtbUAGnCncVU
 AAAA=
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705664668; l=720;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=GosKtxU73aFIPQGFRc6FM8kcXFBSXm3PgdAcWrgvLFU=;
 b=wo6PsqxSUcI1euxuKNl5x/g0jSkAAKzxOESz/lhi+e4xrYRZcZswBImIMxllHLBoIbLi+0DET
 BnB7BCk/ikJAaXGIL2/dcF+Ixl9yAvChB//S5E+Dk5iCm0wl9uZrDPW
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

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Yang Xiwen (3):
      net: hifemac_mdio: use log_msg_ret() correctly, report error by dev_err()
      net: hifemac: fix log reporting
      net: hifemac: register MDIO bus device for subnode

 drivers/net/hifemac.c      | 138 +++++++++++++++++++++++++++++++++------------
 drivers/net/hifemac_mdio.c |  11 +++-
 2 files changed, 109 insertions(+), 40 deletions(-)
---
base-commit: f7cca7ccc5117eaafcc2bde91ad1bed6fee7cfc3
change-id: 20240119-net-72a32675eeb4

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>

