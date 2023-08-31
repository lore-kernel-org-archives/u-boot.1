Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70323C88CB2
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 22:17:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 470AE86763;
	Fri,  1 Sep 2023 00:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="dDBfZvDM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37E65865B0; Fri,  1 Sep 2023 00:16:39 +0200 (CEST)
Received: from s.wfbtzhsv.outbound-mail.sendgrid.net
 (s.wfbtzhsv.outbound-mail.sendgrid.net [159.183.224.104])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55DA68659F
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 00:16:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=from:subject:in-reply-to:references:mime-version:to:cc:
 content-transfer-encoding:content-type:cc:content-type:from:subject:to;
 s=s1; bh=/y8jN5PN+FHjc9rjFKOb/YS3RfO/kOROs6xa/HHGpOo=;
 b=dDBfZvDMO6zN+lT3MOOyu9vNuVfGcCbRQA70XjcGE6xkUuhuLuIODNSryZR3GpgiSd9Z
 6ucvwgJ/UYc2ED25pic4NNFYnWiVP1JZ+hehAk06mPoT+WV/V8u14f6zle5Vcm0kcoGhgf
 GKt/pfC7XT4yD9m3VCb8Sp5TQDmbq/GYy2mmnzS09VmG243ZjBMnsCXNiFFgiNvSC0SOOo
 sJP1ey/ZOmFa6wa8v+FvqhZ0WPljufSbC4XkBUFhZ8jrRGQhOcPiazTTSlc7qIkU0xNTAD
 RdEftLIb2+aV05qlfNKRh+1xIP0JH8sknvCx7E36TUVUbdEPKSF+UDpG1uVZznOw==
Received: by filterdrecv-7765c6879f-sjjbz with SMTP id
 filterdrecv-7765c6879f-sjjbz-1-64F11142-28
 2023-08-31 22:16:34.824854964 +0000 UTC m=+1839260.597120902
Received: from bionic.localdomain (unknown) by geopod-ismtpd-5 (SG) with ESMTP
 id 6TwLGVw0TJ-4AqfOSWbtnA Thu, 31 Aug 2023 22:16:34.592 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/6] phy: Set phy->dev to NULL when
 generic_phy_get_by_index_nodev() fails
Date: Thu, 31 Aug 2023 22:16:35 +0000 (UTC)
Message-ID: <20230831221629.1027552-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230831221629.1027552-1-jonas@kwiboo.se>
References: <20230831221629.1027552-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h50tdBjTBCRbgetR8?=
 =?us-ascii?Q?nBFMjVUCL1wzQWsRY2MTx2YEcUWEFJEEnKrjfNl?=
 =?us-ascii?Q?gKJllBf6QAxlMyIR95jBd32gwNbM=2FkUdNHWxTsG?=
 =?us-ascii?Q?JhbTVCI0mB7igYWsCqG+qvQnpOrF43R8XkuoIr9?=
 =?us-ascii?Q?KUgWl=2F2UXK645Kgpf6Z0+G+RuVRTnCN3xW0eGs?=
To: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Jean-Jacques Hiblot
 <jjhiblot@ti.com>
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

Generic phy helpers typically use generic_phy_valid() to determine if
the helper should perform its function on a passed struct phy.
generic_phy_valid() treat any struct phy having phy->dev set as valid.

With generic_phy_get_by_index_nodev() setting phy->dev to a valid struct
udevice early, there can be situations where the struct phy is returned
as valid when initialization in fact failed and returned an error.

Fix this by setting phy->dev back to NULL when any of the calls to
of_xlate ops, device_get_supply_regulator or phy_alloc_counts fail. Also
extend the dm_test_phy_base test with a test where of_xlate ops fail.

Fixes: 72e5016f878d ("drivers: phy: add generic PHY framework")
Fixes: b9688df3cbf4 ("drivers: phy: Set phy->dev to NULL when generic_phy_get_by_index() fails")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/sandbox/dts/test.dts | 11 +++++++++++
 drivers/phy/phy-uclass.c  |  1 +
 test/dm/phy.c             | 12 +++++++++++-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index f351d5cb84b0..6be212403473 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -431,6 +431,11 @@
 		#phy-cells = <0>;
 	};
 
+	phy_provider3: gen_phy@3 {
+		compatible = "sandbox,phy";
+		#phy-cells = <2>;
+	};
+
 	gen_phy_user: gen_phy_user {
 		compatible = "simple-bus";
 		phys = <&phy_provider0 0>, <&phy_provider0 1>, <&phy_provider1>;
@@ -443,6 +448,12 @@
 		phy-names = "phy1", "phy2";
 	};
 
+	gen_phy_user2: gen_phy_user2 {
+		compatible = "simple-bus";
+		phys = <&phy_provider3 0 0>;
+		phy-names = "phy1";
+	};
+
 	some-bus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
index 0baf314a3471..7d707c022934 100644
--- a/drivers/phy/phy-uclass.c
+++ b/drivers/phy/phy-uclass.c
@@ -195,6 +195,7 @@ int generic_phy_get_by_index_nodev(ofnode node, int index, struct phy *phy)
 	return 0;
 
 err:
+	phy->dev = NULL;
 	return ret;
 }
 
diff --git a/test/dm/phy.c b/test/dm/phy.c
index 09329b9f71f6..2abd27b22d6d 100644
--- a/test/dm/phy.c
+++ b/test/dm/phy.c
@@ -49,7 +49,7 @@ static int dm_test_phy_base(struct unit_test_state *uts)
 	ut_assert(phy2.dev != phy3.dev);
 
 	/* Try to get a non-existing phy */
-	ut_asserteq(-ENODEV, uclass_get_device(UCLASS_PHY, 4, &dev));
+	ut_asserteq(-ENODEV, uclass_get_device(UCLASS_PHY, 5, &dev));
 	ut_asserteq(-ENODATA, generic_phy_get_by_name(parent,
 					"phy_not_existing", &phy1_method1));
 	ut_assert(!generic_phy_valid(&phy1_method1));
@@ -57,6 +57,16 @@ static int dm_test_phy_base(struct unit_test_state *uts)
 						      &phy1_method2));
 	ut_assert(!generic_phy_valid(&phy1_method2));
 
+	/* Try to get a phy where of_xlate fail */
+	ut_assertok(uclass_get_device_by_name(UCLASS_SIMPLE_BUS,
+					      "gen_phy_user2", &parent));
+	ut_asserteq(-EINVAL, generic_phy_get_by_name(parent, "phy1",
+						     &phy1_method1));
+	ut_assert(!generic_phy_valid(&phy1_method1));
+	ut_asserteq(-EINVAL, generic_phy_get_by_index(parent, 0,
+						      &phy1_method2));
+	ut_assert(!generic_phy_valid(&phy1_method2));
+
 	return 0;
 }
 DM_TEST(dm_test_phy_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
-- 
2.42.0

