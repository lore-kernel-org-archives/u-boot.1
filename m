Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41467CA0FE1
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 23:07:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 901958669F;
	Fri,  1 Sep 2023 01:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="OJCs4enX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C64F8657F; Fri,  1 Sep 2023 01:07:14 +0200 (CEST)
Received: from s.wrqvtzvf.outbound-mail.sendgrid.net
 (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 776A2866BB
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 01:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=from:subject:in-reply-to:references:mime-version:to:cc:
 content-transfer-encoding:content-type:cc:content-type:from:subject:to;
 s=s1; bh=AvoP8CgEOscBwdf+oeiYQ8kw4m8PvRdlhTMg8jWYQKQ=;
 b=OJCs4enXPAfMrGfIXuPT9KuHsZI1Egxi8Cm8PfPq+IIegeFDBb5xl2Ny7Zjjyo3cdcio
 JwdzDhdD4hfSvlztQsnWiPSEuLuqQOhmg8F70zyb80O2p7TghFMDH5UOx/ZzC3rflT33uz
 Jx/gy3LkTLfFintBoAw5SuIsPfWIPDB+uIyFC/y++0cuRzRoG7gTCn3s30OLQbfiJFRKEZ
 AY7R1EpGMS3h0GaCdfpNugQ4Q2rxWUdBPX9h6Y34O+fjYvw/zWvl/TvHUyNiFfZEoXS0HD
 a/Gb8mr+LFm4G6AFTcL2sAcCaXaA5EqIzF9w6g5eucjXKjiw2O77k4RAAIXV778Q==
Received: by filterdrecv-65f68489c8-twq2m with SMTP id
 filterdrecv-65f68489c8-twq2m-1-64F11D1C-31
 2023-08-31 23:07:08.80314339 +0000 UTC m=+9761459.637002513
Received: from bionic.localdomain (unknown) by geopod-ismtpd-4 (SG) with ESMTP
 id NF35lMBCTBCOyYUpCn1Cvw Thu, 31 Aug 2023 23:07:08.595 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 1/3] phy: Fix generic_setup_phy() return value on power on
 failure
Date: Thu, 31 Aug 2023 23:07:08 +0000 (UTC)
Message-ID: <20230831230705.1040105-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230831230705.1040105-1-jonas@kwiboo.se>
References: <20230831230705.1040105-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h5u7I+CuShiVJEv4V?=
 =?us-ascii?Q?Y2QjfBcbU8jlM8b13seNYw19G38ViwDvZrzdBaB?=
 =?us-ascii?Q?tTc5K6z5qo3vjjpgQsZv7R92Wy8HDuFTdZyWpTS?=
 =?us-ascii?Q?b2NXV4oHiQsJVNRKmK1fGzAUWVMlxt7U0BrLKND?=
 =?us-ascii?Q?5b6ph+qvuk0tCyTAUAAfLiD3zTdzZZvivjHY1E?=
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

generic_phy_exit() typically return 0 for a struct phy that has been
initialized with a generic_phy_init() call.

generic_setup_phy() returns the value from a generic_phy_exit() call
when generic_phy_power_on() fails. This hides the failed state of the
power_on ops from the caller of generic_setup_phy().

Fix this by ignoring the return value of the generic_phy_exit() call and
return the value from the generic_phy_power_on() call.

Fixes: 84e561407a5f ("phy: Add generic_{setup,shutdown}_phy() helpers")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- Move refactor to own patch
- Add unit test

 drivers/phy/phy-uclass.c |  2 +-
 test/dm/phy.c            | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
index 7d707c022934..d745e7babc12 100644
--- a/drivers/phy/phy-uclass.c
+++ b/drivers/phy/phy-uclass.c
@@ -526,7 +526,7 @@ int generic_setup_phy(struct udevice *dev, struct phy *phy, int index)
 
 		ret = generic_phy_power_on(phy);
 		if (ret)
-			ret = generic_phy_exit(phy);
+			generic_phy_exit(phy);
 	}
 
 	return ret;
diff --git a/test/dm/phy.c b/test/dm/phy.c
index 2abd27b22d6d..4da4841f40f7 100644
--- a/test/dm/phy.c
+++ b/test/dm/phy.c
@@ -234,3 +234,27 @@ static int dm_test_phy_multi_exit(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_phy_multi_exit, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
+
+static int dm_test_phy_setup(struct unit_test_state *uts)
+{
+	struct phy phy;
+	struct udevice *parent;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_SIMPLE_BUS,
+					      "gen_phy_user", &parent));
+
+	/* normal */
+	ut_assertok(generic_setup_phy(parent, &phy, 0));
+	ut_assertok(generic_shutdown_phy(&phy));
+
+	/* power_off fail with -EIO */
+	ut_assertok(generic_setup_phy(parent, &phy, 1));
+	ut_asserteq(-EIO, generic_shutdown_phy(&phy));
+
+	/* power_on fail with -EIO */
+	ut_asserteq(-EIO, generic_setup_phy(parent, &phy, 2));
+	ut_assertok(generic_shutdown_phy(&phy));
+
+	return 0;
+}
+DM_TEST(dm_test_phy_setup, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
-- 
2.42.0

