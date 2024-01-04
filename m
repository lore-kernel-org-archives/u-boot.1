Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DC3C4706F
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 04:28:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 695388784E;
	Thu,  4 Jan 2024 05:28:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XoYaFtax";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8538587866; Thu,  4 Jan 2024 05:28:49 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB1F38784E
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 05:28:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0CA0E3F289; 
 Thu,  4 Jan 2024 04:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1704342526;
 bh=uJb8ZtNXzVhzBWsGXvMnxHEriphxM4kP67Pn8g+MCPA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=XoYaFtaxup0DDCbl2Kj/Kh/uNHo8joT0PZQALqDeWtdcpriKffUjDYo7GM4C5yska
 gh2IJEWl5C74RoZROzoF+wrW2oIv+R1hINWT5uCiSInZ7XR5VbXS1lBmhgdsM/QXX6
 NcwhGwiMZiafDq0ZQOYN0Xf4SXCyY2Wsdz/990/76mSB6lq1g1bXG25BemvZV//R9h
 lTkQtOC2bJwce9S4OCf011sR23aARLALylwNqO6P2lLtBNjdlRgpwx6Vhi3MyjDEAb
 bvPx6mmdP4LqTuWnpuAH13ooy/+1nUY0c8janEfdJaDt8WP6497DGrZ4VCAt/s6EJ3
 CgPvvPVShqRdQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Joe Hershberger <joe.hershberger@ni.com>
Cc: Ramon Fried <rfried.dev@gmail.com>, u-boot@lists.denx.de,
 Eugeniu Rosca <erosca@de.adit-jv.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] net: phy: Fix signed shift overflow
Date: Thu,  4 Jan 2024 05:26:23 +0100
Message-ID: <20240104042623.103398-1-heinrich.schuchardt@canonical.com>
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

From: Eugeniu Rosca <erosca@de.adit-jv.com>

Booting R-Car Gen3 arm64 U-Boot with CONFIG_UBSAN=y resulted in:

 =====================================================================
 UBSAN: Undefined behaviour in drivers/net/phy/phy.c:728:19
 left shift of 1 by 31 places cannot be represented in type 'int'
 =====================================================================

Fix it by appending the UL suffix to the numeric literal. While at it,
convert the type of "addr" variable from signed to unsigned, to protect
against shifting the numeric literal by a negative value (which would
lead to yet another undefined behavior).

Fixes: 1adb406b0141 ("phy: add phy_find_by_mask/phy_connect_dev")
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>

* Using U-suffix for integer is sufficient.
* ffs() of non-zero value cannot be 0. But addr being unsigned is
* preferable.
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/net/phy/phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 63b3e46f10..f39ca942f6 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -642,12 +642,12 @@ static struct phy_device *search_for_existing_phy(struct mii_dev *bus,
 {
 	/* If we have one, return the existing device, with new interface */
 	while (phy_mask) {
-		int addr = ffs(phy_mask) - 1;
+		unsigned int addr = ffs(phy_mask) - 1;
 
 		if (bus->phymap[addr])
 			return bus->phymap[addr];
 
-		phy_mask &= ~(1 << addr);
+		phy_mask &= ~(1U << addr);
 	}
 	return NULL;
 }
-- 
2.43.0

