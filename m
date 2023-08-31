Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A0BCA0FE2
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 23:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2B2A86682;
	Fri,  1 Sep 2023 01:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="M9nauqBU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8519C865A0; Fri,  1 Sep 2023 01:07:15 +0200 (CEST)
Received: from s.wfbtzhsw.outbound-mail.sendgrid.net
 (s.wfbtzhsw.outbound-mail.sendgrid.net [159.183.224.105])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90069866D9
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 01:07:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=from:subject:in-reply-to:references:mime-version:to:cc:
 content-transfer-encoding:content-type:cc:content-type:from:subject:to;
 s=s1; bh=FCpRdz13nICSxUS5ny/6WxWEc0EQ9YmnX1YEvZmN2HI=;
 b=M9nauqBUwgPQ5xUmgQOtQsntieLiJAker5kHxqIyPij20zAIX0tLfn9rmBZQxN5an8to
 hZQ3E7Ggq1AbeVhLghmZiTPRFZ46l9cl7Zzeuru4X7bxTRjfy0lb9j4BSI6ibkT995Tosu
 UQz8kmK3jfvfr+FI1Z09BWogkNwJRpV3tQB4l4RVkQydCybfnjYILIDeH2vOrq4xNHg6Nu
 vOTGByEzahn0+yJ0OEwWSUjpa4+m+QHqI15vWs4fFO1T0iLGlk6kx4KY9VZ9XhSZ7QqSXs
 aUh2LHNYKM1XLEE1Zyl8PhKtK6dC6dWFddgM4ZGrf5hq7daH26oDfBxu2a8jx+sA==
Received: by filterdrecv-77869f68cc-wnrh7 with SMTP id
 filterdrecv-77869f68cc-wnrh7-1-64F11D1E-1C
 2023-08-31 23:07:10.314126364 +0000 UTC m=+9761469.966556288
Received: from bionic.localdomain (unknown) by geopod-ismtpd-4 (SG) with ESMTP
 id 22wBKVZ9QPC-TMvVZTipfA Thu, 31 Aug 2023 23:07:10.097 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 2/3] phy: Return success from generic_setup_phy() when phy
 is not found
Date: Thu, 31 Aug 2023 23:07:10 +0000 (UTC)
Message-ID: <20230831230705.1040105-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230831230705.1040105-1-jonas@kwiboo.se>
References: <20230831230705.1040105-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h+dovFckzrijS5N9O?=
 =?us-ascii?Q?ZnUjqUSQz9kBj8krT4ZKfHsZUyyM=2FhE1WpPj6Ii?=
 =?us-ascii?Q?CR1LA02MGSCxVjpDi3XkmF2iqxDKH3qHrjWHh3U?=
 =?us-ascii?Q?Ied0AokfdDJpXi471Yqk9hkA+h6tgStoeEgysZA?=
 =?us-ascii?Q?K4hwDsRBfXROKmXOSHWQ6MDsj=2FXrN=2Feycb6L3d?=
To: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>
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

Restore the old behavior of ehci_setup_phy() and ohci_setup_phy() to
return success when generic_phy_get_by_index() return -ENOENT.

Fixes: 84e561407a5f ("phy: Add generic_{setup,shutdown}_phy() helpers")
Fixes: 10005004db73 ("usb: ohci: Make usage of generic_{setup,shutdown}_phy() helpers")
Fixes: 083f8aa978a8 ("usb: ehci: Make usage of generic_{setup,shutdown}_phy() helpers")
Fixes: 75341e9c16aa ("usb: ehci: Remove unused ehci_{setup,shutdown}_phy() helpers")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- New patch to fix regression introduced in v2023.01-rc1

 drivers/phy/phy-uclass.c | 4 ++--
 test/dm/phy.c            | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
index d745e7babc12..343c23cead0c 100644
--- a/drivers/phy/phy-uclass.c
+++ b/drivers/phy/phy-uclass.c
@@ -517,8 +517,8 @@ int generic_setup_phy(struct udevice *dev, struct phy *phy, int index)
 
 	ret = generic_phy_get_by_index(dev, index, phy);
 	if (ret) {
-		if (ret != -ENOENT)
-			return ret;
+		if (ret == -ENOENT)
+			return 0;
 	} else {
 		ret = generic_phy_init(phy);
 		if (ret)
diff --git a/test/dm/phy.c b/test/dm/phy.c
index 4da4841f40f7..4f91abca3a02 100644
--- a/test/dm/phy.c
+++ b/test/dm/phy.c
@@ -255,6 +255,11 @@ static int dm_test_phy_setup(struct unit_test_state *uts)
 	ut_asserteq(-EIO, generic_setup_phy(parent, &phy, 2));
 	ut_assertok(generic_shutdown_phy(&phy));
 
+	/* generic_phy_get_by_index fail with -ENOENT */
+	ut_asserteq(-ENOENT, generic_phy_get_by_index(parent, 3, &phy));
+	ut_assertok(generic_setup_phy(parent, &phy, 3));
+	ut_assertok(generic_shutdown_phy(&phy));
+
 	return 0;
 }
 DM_TEST(dm_test_phy_setup, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
-- 
2.42.0

