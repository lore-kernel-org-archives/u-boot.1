Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7624EC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 08:16:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F91F884DD;
	Tue, 18 Jun 2024 10:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="NhEk4FBS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B748883E0; Tue, 18 Jun 2024 10:16:40 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6514884DD
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 10:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-041-025.um47.pools.vodafone-ip.de
 [178.202.41.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4E1EF3F2E5; 
 Tue, 18 Jun 2024 08:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718698596;
 bh=7ZhHo2ZywQ8js9OcWsYQSLyA6DOLyKhWtkxFBkxi2vA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=NhEk4FBSwdpgdVyszk0d5BmFm7nLX4nME3V2joSZ9ex81ffR3DfCETceHru2Qxi1c
 woXjqXOnwZBen6uuLlYWUqHtf/SURk9jhFkkDPeeKBLQrHfzn9m+jmMG9BM0qqRVSO
 VphmylimI8hGjqWdRqu4MsuMVz5mpi1OJmipD1gNgoHzhmYcwftbtM2T+OF4uqFoeB
 g3sdaXGvihnjNXVDMWOT1W+ZwGEbYFPp3jtuaEdEVCnw/xmueHzKRn1mG10oC39Tk8
 Frq+X2XplcSFhJgrr+mP75DhNQ9ff2Mdu0OrOtaT8nK3yOSmxS6TauaDaR7KYzBumh
 ZTx8tDwgC0FoQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] usb: informative message if no controller
Date: Tue, 18 Jun 2024 10:16:32 +0200
Message-ID: <20240618081632.29995-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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
---
v2:
	add 'found' at end of message
	keep printf
---
 drivers/usb/host/usb-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
index a1cd0ad2d66..bd861270af3 100644
--- a/drivers/usb/host/usb-uclass.c
+++ b/drivers/usb/host/usb-uclass.c
@@ -388,7 +388,7 @@ int usb_init(void)
 
 	/* if we were not able to find at least one working bus, bail out */
 	if (controllers_initialized == 0)
-		printf("No working controllers found\n");
+		printf("No USB controller found\n");
 
 	return usb_started ? 0 : -ENOENT;
 }
-- 
2.43.0

