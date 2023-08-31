Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AFDEE49B2
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 22:16:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 048CD865B0;
	Fri,  1 Sep 2023 00:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="AzBtQQ7X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB7EC865B0; Fri,  1 Sep 2023 00:16:38 +0200 (CEST)
Received: from s.wrqvwxzv.outbound-mail.sendgrid.net
 (s.wrqvwxzv.outbound-mail.sendgrid.net [149.72.154.232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BE8386680
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 00:16:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=from:subject:in-reply-to:references:mime-version:to:cc:
 content-transfer-encoding:content-type:cc:content-type:from:subject:to;
 s=s1; bh=JTr2huGOS180dVS+xOXUF7qaAk7Zmb3w7RDsA6d8hMg=;
 b=AzBtQQ7XlNf/77l4i3tCcNef1L4zPB7hu4npTdeHAyOBGeMHmtjuC2qb9RXwFiWqcid7
 MuoHguSsy4yMBFlXg31EEtYVgi3AUfH2Hc1JKW0BcatIHU/9mYGzZTOnwzXmfVEMJzF3XV
 KJmIBayXRGOHdTqHflh88iG3Zer7JnmfEg43kNNxKROr+VkiGdqRzId4RqCCMptlXMczUy
 ss0jTl7cC6vhzNzSDN2Y3D8t4NGELkBtPNSgSuoVp7HchFRuiL3hqFOvMjlPMJXCadOEfK
 y2OGEb8U/S4DAaCUTEL/XSxw7Xx27DN2EQsMn+vKMXsNM9B1uM4P6ZC6GFNHL93A==
Received: by filterdrecv-77869f68cc-5c259 with SMTP id
 filterdrecv-77869f68cc-5c259-1-64F11141-C
 2023-08-31 22:16:33.341182531 +0000 UTC m=+9758416.620526600
Received: from bionic.localdomain (unknown) by geopod-ismtpd-5 (SG) with ESMTP
 id bnMrL5ChSTezd0Ww2sJCtg Thu, 31 Aug 2023 22:16:33.124 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/6] phy: Set phy->dev to NULL when generic_phy_get_by_name()
 fails
Date: Thu, 31 Aug 2023 22:16:33 +0000 (UTC)
Message-ID: <20230831221629.1027552-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230831221629.1027552-1-jonas@kwiboo.se>
References: <20230831221629.1027552-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h2mt7nYyOzndSrIKm?=
 =?us-ascii?Q?EAX6xOM8+rL+4VUlfGlPc=2FOosyfRFXPrm1w3G5m?=
 =?us-ascii?Q?CtD2EGk4cKFuLkEl7QmB5xG=2Fx44vFs73gmQBcDB?=
 =?us-ascii?Q?pz8cF7HLkI0zXFMdGna87qWJmnHSm8vhFru6ko5?=
 =?us-ascii?Q?IDEKLfmknj0Jv79AW3f70uyw3anG78rVdTLSiu?=
To: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Jan Kiszka
 <jan.kiszka@siemens.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
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

generic_phy_get_by_name() does not initialize phy->dev to NULL before
returning when dev_read_stringlist_search() fails. This can lead to an
uninitialized or reused struct phy erroneously be report as valid by
generic_phy_valid().

Fix this issue by initializing phy->dev to NULL, also extend the
dm_test_phy_base test with calls to generic_phy_valid().

Fixes: b9688df3cbf4 ("drivers: phy: Set phy->dev to NULL when generic_phy_get_by_index() fails")
Fixes: 868d58f69c7c ("usb: dwc3: Fix non-usb3 configurations")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/phy-uclass.c | 3 +++
 test/dm/phy.c            | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
index 629ef3aa3de5..0baf314a3471 100644
--- a/drivers/phy/phy-uclass.c
+++ b/drivers/phy/phy-uclass.c
@@ -211,6 +211,9 @@ int generic_phy_get_by_name(struct udevice *dev, const char *phy_name,
 
 	debug("%s(dev=%p, name=%s, phy=%p)\n", __func__, dev, phy_name, phy);
 
+	assert(phy);
+	phy->dev = NULL;
+
 	index = dev_read_stringlist_search(dev, "phy-names", phy_name);
 	if (index < 0) {
 		debug("dev_read_stringlist_search() failed: %d\n", index);
diff --git a/test/dm/phy.c b/test/dm/phy.c
index 4d4a083dd0fd..09329b9f71f6 100644
--- a/test/dm/phy.c
+++ b/test/dm/phy.c
@@ -29,7 +29,9 @@ static int dm_test_phy_base(struct unit_test_state *uts)
 	 * Get the same phy port in 2 different ways and compare.
 	 */
 	ut_assertok(generic_phy_get_by_name(parent, "phy1", &phy1_method1));
+	ut_assert(generic_phy_valid(&phy1_method1));
 	ut_assertok(generic_phy_get_by_index(parent, 0, &phy1_method2));
+	ut_assert(generic_phy_valid(&phy1_method2));
 	ut_asserteq(phy1_method1.id, phy1_method2.id);
 
 	/*
@@ -50,6 +52,10 @@ static int dm_test_phy_base(struct unit_test_state *uts)
 	ut_asserteq(-ENODEV, uclass_get_device(UCLASS_PHY, 4, &dev));
 	ut_asserteq(-ENODATA, generic_phy_get_by_name(parent,
 					"phy_not_existing", &phy1_method1));
+	ut_assert(!generic_phy_valid(&phy1_method1));
+	ut_asserteq(-ENOENT, generic_phy_get_by_index(parent, 3,
+						      &phy1_method2));
+	ut_assert(!generic_phy_valid(&phy1_method2));
 
 	return 0;
 }
-- 
2.42.0

