Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BA0C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 19:07:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD8B78752A;
	Tue, 18 Jun 2024 21:07:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="gvt3GqPS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9E6983334; Tue, 18 Jun 2024 21:07:33 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 916798824C
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 21:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-041-025.um47.pools.vodafone-ip.de
 [178.202.41.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7E2913F2CC; 
 Tue, 18 Jun 2024 19:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718737650;
 bh=Ffp9pGWTK9nY4PbZWa1rurx+TjscFKTbD+DtxePSW5Q=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=gvt3GqPSZk0ArUXOhgPZWw0ouyEizk0TCxcyJ2GnmDeOBMlmDAGNUy0ppO3R5EhAB
 YWAIJ3wFwqCPpiy39GSeViD7HZwEf43Onx7IVHbaka6TrvY83pW3umD0chDbjTaY56
 t9PWJmGGaZHrDHDjq8QLRdXpTLN6LdJPPlWYDyywR4rXVKSCxi7HoibdXAWZztgIK+
 YYNpmDZvXGZP9ZfxVpjMGUStkohMJSBYCFB/oiskBJRSnJXFec6KRcPMbG+mZy39O2
 zvuzovUGAkKd999AHfTF16oU4VtrY7KweymfJdrM8n5p1YxuE6ISNL/5BUSaR1jp6N
 Eqq4G/JLA8tpw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v4 1/1] usb: informative message if no controller
Date: Tue, 18 Jun 2024 21:07:29 +0200
Message-ID: <20240618190729.15201-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
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

The message 'No working controllers found' provides no clue that this
refers to USB controllers.

Provide a message that refers to USB.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Reviewed-by: Marek Vasut <marex@denx.de>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
v4:
	correct commit message (remove log_info() reference)
v3:
	plural controllers
v2:
	add 'found' at end of message
	keep printf
---
 drivers/usb/host/usb-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
index cd3a07e4c37..bfec303e7af 100644
--- a/drivers/usb/host/usb-uclass.c
+++ b/drivers/usb/host/usb-uclass.c
@@ -387,7 +387,7 @@ int usb_init(void)
 
 	/* if we were not able to find at least one working bus, bail out */
 	if (controllers_initialized == 0)
-		printf("No working controllers found\n");
+		printf("No USB controllers found\n");
 
 	return usb_started ? 0 : -ENOENT;
 }
-- 
2.45.1

