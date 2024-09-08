Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A15CD4F4C
	for <u-boot@archiver.kernel.org>; Sun,  8 Sep 2024 21:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ED5788B5F;
	Sun,  8 Sep 2024 23:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YdASnl4x";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZH4RQjEi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 215F188AAC; Sun,  8 Sep 2024 23:10:29 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC0CD88AD8
 for <u-boot@lists.denx.de>; Sun,  8 Sep 2024 23:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4X22g64TNFz9sly;
 Sun,  8 Sep 2024 23:10:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725829826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=diBqLOYEN5uJR/Pbjdj1BGTgwXMYk6T7Pp4r0dKgGus=;
 b=YdASnl4xq2LHgdMTmgw56ukgn4W7vDMT1UDrXMM8HDkF1apGETABo9tqva/pIfMJlquTCx
 xjY3Q/SNLC1jHODakNEpnAEZ2Di1gfqvBim8BVLQjrbNw+KHrkAJ17JzEXSBM5ZmCol5lj
 Iu1dUrHkIXbhjkGLoexG2uoBu+oYNBP/PYip4kmwKW6kDzzGCnJsYddg7La5TT94AGuHuV
 FLk9WjrdxLzrhEwoEux0g07+S/SnnBe/mZg7yCrX2oVFC0UNOj2QCFRL3sO5RCZLHAxNBE
 khZ61ZDFUS8EbLDYt3QTCe8DQZBWrU7/KXDsCD/vGbBcwWb/XbTLOH9dCAziZQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725829824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=diBqLOYEN5uJR/Pbjdj1BGTgwXMYk6T7Pp4r0dKgGus=;
 b=ZH4RQjEihKLGso16jFOPhIurPhvr0dvKIeRDAmTMjX+QHzaMfaXS4OR0fHxYate74M0UkD
 YqlSxif2tl3LQGCScXo7BzBawC19v69aWBJnvqLkf0W4u22C5VPwB0kzjQescjwrTaSL4E
 SyXjrAMji2IMr1QHN+1mciYYA/hBnkZQ7A12hSd4x6aBcp4a6J/EBjPBqYTED6Z9bll+Pu
 V3qBD+9gc8p17G05wwoZnuyZiWW2Oq14vaYAMZiAbHQaI2p9Cj2vlGiozAhnmGNUfJ62ol
 6x8VpQpiQ4Js5SkIALhL9q42OXvrluhLRqZJSv49Fv0qJcNn3dZrqXzirS2rjg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Mathieu Othacehe <othacehe@gnu.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 u-boot-qcom@groups.io
Subject: [PATCH v3 3/3] phy: test: Implement sandbox PHY .set_mode and DM test
Date: Sun,  8 Sep 2024 23:09:05 +0200
Message-ID: <20240908210958.230727-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240908210958.230727-1-marek.vasut+renesas@mailbox.org>
References: <20240908210958.230727-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: nb9byteuarfew13duzw7ib15wqapq36b
X-MBO-RS-ID: 22a112c212da8989d95
X-Rspamd-Queue-Id: 4X22g64TNFz9sly
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

Implement trivial extension to the sandbox PHY, which makes it pretend
to support selecting USB Host mode and nothing else. Any other mode is
rejected with -EINVAL. Any submode except for default submode 0 is
rejected with -EOPNOTSUPP . The implementation behaves in this trivial
way to permit easy unit testing using test which is also added in this
commit.

To run the test, use e.g. sandbox64_defconfig and run U-Boot as follows:
$ ./u-boot -Tc 'ut dm phy_setup'

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Mathieu Othacehe <othacehe@gnu.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Xavier Drudis Ferran <xdrudis@tinet.cat>
Cc: u-boot-qcom@groups.io
Cc: u-boot@lists.denx.de
---
V2: New patch
V3: - Rebase on u-boot/next
    - Add RB from Mattijs
---
 drivers/phy/sandbox-phy.c | 13 +++++++++++++
 test/dm/phy.c             |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/phy/sandbox-phy.c b/drivers/phy/sandbox-phy.c
index b159147a765..e70d20432e0 100644
--- a/drivers/phy/sandbox-phy.c
+++ b/drivers/phy/sandbox-phy.c
@@ -72,6 +72,18 @@ static int sandbox_phy_exit(struct phy *phy)
 	return 0;
 }
 
+static int
+sandbox_phy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	if (submode)
+		return -EOPNOTSUPP;
+
+	if (mode != PHY_MODE_USB_HOST)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int sandbox_phy_bind(struct udevice *dev)
 {
 	if (dev_get_driver_data(dev) != DRIVER_DATA)
@@ -96,6 +108,7 @@ static struct phy_ops sandbox_phy_ops = {
 	.power_off = sandbox_phy_power_off,
 	.init = sandbox_phy_init,
 	.exit = sandbox_phy_exit,
+	.set_mode = sandbox_phy_set_mode,
 };
 
 static const struct udevice_id sandbox_phy_ids[] = {
diff --git a/test/dm/phy.c b/test/dm/phy.c
index 8808ca3689c..194cad0bf70 100644
--- a/test/dm/phy.c
+++ b/test/dm/phy.c
@@ -246,6 +246,13 @@ static int dm_test_phy_setup(struct unit_test_state *uts)
 	ut_assertok(generic_setup_phy(parent, &phy, 0, PHY_MODE_USB_HOST, 0));
 	ut_assertok(generic_shutdown_phy(&phy));
 
+	/* set_mode as USB Host passes, anything else is not supported */
+	ut_assertok(generic_setup_phy(parent, &phy, 0, PHY_MODE_USB_HOST, 0));
+	ut_assertok(generic_phy_set_mode(&phy, PHY_MODE_USB_HOST, 0));
+	ut_asserteq(-EOPNOTSUPP, generic_phy_set_mode(&phy, PHY_MODE_USB_HOST, 1));
+	ut_asserteq(-EINVAL, generic_phy_set_mode(&phy, PHY_MODE_USB_DEVICE, 0));
+	ut_assertok(generic_shutdown_phy(&phy));
+
 	/* power_off fail with -EIO */
 	ut_assertok(generic_setup_phy(parent, &phy, 1, PHY_MODE_USB_HOST, 0));
 	ut_asserteq(-EIO, generic_shutdown_phy(&phy));
-- 
2.45.2

