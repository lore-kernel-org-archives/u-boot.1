Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB24C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 12:18:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B609380C77;
	Sat, 25 Jan 2025 13:18:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vKmU22xN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VgceWmtw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C3CE80C7E; Sat, 25 Jan 2025 13:18:47 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2285580836
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 13:18:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YgDHS5jJ1z9slN;
 Sat, 25 Jan 2025 13:18:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737807524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iZwV7iRVUuY4hiwqpLseJm+jfnFR4ga7ggSmCoWywyc=;
 b=vKmU22xNjFbAeD6wNGMXH4HMsC8luZk7FTq63Q9cicB85jwimZrFurbb3htqlH9HoGeJaV
 prKdrC/1Y5rg5u9GRyI9A1I2liUSo+las6Vj83EJu5nXWbXE21YPrijA2RWI5REJD9s0fC
 ttLMF87NqT1vXVz5LE3RpFjH3frgxRZ0IziUlU4sZniTLgu7hS6oHxiTPD5ThOJHfX2lTs
 rE0qGL/GrZy4xezHpGdtpZmbAEeOv/JbWg8tZPcoQVaYeIIOmkLNySJdJq5ZZ1GW1o7ODU
 K4e0gcbrhbr2OeKkYBXLdFTAA7I3vdOdnCJF5DauL5OGxfIkPPcdEETzNVyg9A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737807522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iZwV7iRVUuY4hiwqpLseJm+jfnFR4ga7ggSmCoWywyc=;
 b=VgceWmtwr/lD7JQ5fDuz2EhCeRc2ASXJg9v7Rbu43UgzDoV3nTHm4gyOzSFUy0KA5yWU/H
 ILgCv0qWM4AVJEIQeoWiGGqWAz5Jka0oHAGj/hiVrBo5BwwsjDKOsPPB3wQm8uBBm8CitK
 FTxdu3KDBoY5XFzG3llbltN/56R8j2DQ0JsbXumvQjXU4yRmZd2Il+e6Gh+Zy5QvW7bBjZ
 Sx1Q7ywwvAH1LLO5exDxFvBGZE2H1UKi6eWrqomZ6NnoD2GOvRzUULmpiwCKX5aTYJsy/9
 /sJ9VLRV14eJxe9tMz8YwfsZ+UooOjX26ics55IOns0WCh0EvbDsdh4Rz6pXNg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Adam Ford <aford173@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Mario Six <mario.six@gdsys.cc>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] net: miiphybb: Fix short name length
Date: Sat, 25 Jan 2025 13:17:57 +0100
Message-ID: <20250125121825.31138-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: uwp13e9mhktsof4fktsdwu81am7heyip
X-MBO-RS-ID: bf587e560b518140e66
X-Rspamd-Queue-Id: 4YgDHS5jJ1z9slN
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

Multiple drivers copy the MDIO instance name from struct mii_phy to
struct bb_miiphy_bus, but the name field in these two structs have
different lengths, the bb_miiphy_bus one is 16 bytes, the source one
is 32 bytes. Make sure these two lengths are always synchronized, use
MDIO_NAME_LEN for both.

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: - Reword commit message
    - Add RB from Paul
---
 include/miiphy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/miiphy.h b/include/miiphy.h
index 2bb4f62ea76..1e6c7041fdc 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -64,7 +64,7 @@ void mdio_list_devices(void);
 #define BB_MII_DEVNAME	"bb_miiphy"
 
 struct bb_miiphy_bus {
-	char name[16];
+	char name[MDIO_NAME_LEN];
 	int (*init)(struct bb_miiphy_bus *bus);
 	int (*mdio_active)(struct bb_miiphy_bus *bus);
 	int (*mdio_tristate)(struct bb_miiphy_bus *bus);
-- 
2.45.2

