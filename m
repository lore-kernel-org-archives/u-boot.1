Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF65C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 08:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19407832DA;
	Tue, 22 Jul 2025 10:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="Gq5GPOzz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3B1A832DA; Tue, 22 Jul 2025 10:31:36 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6241832C8
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 10:31:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D459BC7602; Tue, 22 Jul 2025 10:31:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1753173093; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=A71PPWz0AMejHmdTizcrWcBRpOwbeLnC3T+OfeJNg6w=;
 b=Gq5GPOzz/axzcfQ9Ku1D9mlewq5O8W3/6lruI5looDGgUntmesWhea5gEi7BvUdVLIAR15
 Dw6mQFStL8GqtOwuJMIKMSwZPKnREkUCHImlYn5aSJGKJTw4zDMcz2tdSL1ezaXcHRFulC
 l5xj8kdlZtZqy9DzDdNJW3dyiDexeifF0eF8Be9bUUp/9W2tewxK1zxX/CeBkyh0dLw6qj
 nMjZ1w6oBPdT6S/aCj4P94nZpR1MzraU9Y6ga1kL+/siaa9eZynZ0+jXBKOtP+xCw+cv81
 2LYXn9g6jDbh309Rj7/sZ8UpcKchZMaNXSnkiHHLw5ihev0m0bMYvNW4FnjX4g==
From: Frieder Schrempf <frieder@fris.de>
To: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrick Wildt <patrick@blueri.se>, Tom Rini <trini@konsulko.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Fabio Estevam <festevam@gmail.com>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] imx: power-domain: Fix crash due to uninitialized 'id' field
Date: Tue, 22 Jul 2025 10:31:18 +0200
Message-ID: <20250722083119.64084-1-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

In case of the i.MX8M power-domains (i.MX8MQ, MM, MN) there is only
one power-domain for each device. Therefore the 'id' field in struct
power_domain should always be zero.

Currently if a power-domain is accessed after the initial bind, the
'id' field is left uninitialized. This didn't cause any problems
until the following commits were introduced:

9086b64ca071 ("power-domain: Add support for refcounting (again)")
a785ef24487b ("imx: power-domain: Enable refcounting on imx8mp")

Now the 'id' field gets accessed in the power_domain_off() sequence
and the invalid value causes "Synchronous Abort" failures.

This was observed on a i.MX8MM board when running "usb start" and
then "usb stop".

Fix this issue by setting power_domain->id to '0' in
imx8m_power_domain_of_xlate().

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Fixes: d08a194871fd ("imx: add support for i.MX8MQ power domain controller")
Fixes: 9086b64ca071 ("power-domain: Add support for refcounting (again)")
---
 drivers/power/domain/imx8m-power-domain.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/domain/imx8m-power-domain.c b/drivers/power/domain/imx8m-power-domain.c
index b44aae78e6d..a7e64971a2a 100644
--- a/drivers/power/domain/imx8m-power-domain.c
+++ b/drivers/power/domain/imx8m-power-domain.c
@@ -468,6 +468,8 @@ out_clk_disable:
 static int imx8m_power_domain_of_xlate(struct power_domain *power_domain,
 				      struct ofnode_phandle_args *args)
 {
+	power_domain->id = 0;
+
 	return 0;
 }
 
-- 
2.50.1

