Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C364C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 06:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E92A187AF4;
	Tue, 31 Oct 2023 07:40:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="z4UQ0zIe";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="lhdx78CG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F47A87510; Tue, 31 Oct 2023 07:40:55 +0100 (CET)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5172287AEE
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 07:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailout.west.internal (Postfix) with ESMTP id 1AD2A3200A46;
 Tue, 31 Oct 2023 02:40:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Tue, 31 Oct 2023 02:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1698734444; x=
 1698820844; bh=OC1CkPaVUP7WTOQElq3Q8vJT5y5dMNnvyS8n+J3jpTI=; b=z
 4UQ0zIexnNOCVj84rGGVtD2EnX33EMyTsTYvCaJre+dYnRV1wU3LB1Z3pdRcOqAg
 /WPhqBo0vgDm6mqJbQZiGqgW08RL8nD1Z9at3t2JMLdVJF8MwL+DEO9lvoJrxbtI
 pkAQEHMR/q2mssZNpHozt4SCX1DWUrtz5nEFdJAq83J0nD051kP4R9o24yxgxRkt
 xWsBDOS9kywVSz+cbD3TVsiq0s+6g/26nYzwCivsa+pkXQsCfazPtBLDqSumsQMu
 8LsFhNJNTcjcO0jJhDAPvoz3cctqF7mJgmK+tQHxqpalc5FM/ORJf/Y/YOaRm+3R
 YTI9lbg+KW9gshSBbjw6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698734444; x=
 1698820844; bh=OC1CkPaVUP7WTOQElq3Q8vJT5y5dMNnvyS8n+J3jpTI=; b=l
 hdx78CGDeDqk5r6fFgBDe2JNjUXiTwCjOp4v1KYcfg4LSbybFHouQe49qxUYJoL7
 YswBTLK6EHDObPA5ni73gRLyQf8mFeTZSHtkAQ4UWRgkrLqGhYnjrUmDm/YhOYKB
 VVT8P4BSuTp+hKPdIrVfcP6Nosu6KRd/auXVrWP5iwMMYEeyLyZGNHWzZEOEot7G
 TfShRhRgnSQ2VnJLsXiTe5OHAohz/w5y8esWWitIX7z62QH1DhR5algX3PrHXI0r
 SbQ/YzKVZu5v5Q31RqTF/NC9Lfm85UNyne5u6dQLqEENO/Qc5XN+d0x1LsEH11Ou
 Bf3jSe8/P6DhnGKuGWxWg==
X-ME-Sender: <xms:bKFAZTpacphGWqCWL8YcfLLMU1B-Ewo-3s2fEhh0yBbeG2nV0GGh7Q>
 <xme:bKFAZdqiLmd4VxLainx30dTkBB3WU92vIZtW_mYov2fTY8yMxO73XJHs-dE7iSzss
 Jt5vKgW7MeaZYPg8A>
X-ME-Received: <xmr:bKFAZQOLg_nhNBOoJ0Ela2ROdmSH2av4OQl8zDS9Zi5GyjRQiNLjWBX8YSAn2LkPCGwxhcFXVSTpz0i36GbskiSW8eJ1OhyMSSTsrmEyNLi8kZXSBwRP407WODh0_hZNWJp_UA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgleeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
 vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
 ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
 udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:bKFAZW5OjnGoCKh1tWBKLxHoe8r5CScBBUj3EvXcPNmyaZ8z0tsH6Q>
 <xmx:bKFAZS79uSHxkXcFADQnZq03uhmyy4Y5XrIJew9RuDWxS8zdet3vyQ>
 <xmx:bKFAZei89kDM1rZ3L-EkOJv9S_NXHT_R2WOKzlZTaqRQdEvmou0dRQ>
 <xmx:bKFAZbHmq9gbY0Smya80Y5h8PuaXjMP3Hydj_8p0BoU4sMtiI4tUWA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 02:40:43 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Icenowy Zheng <icenowy@aosc.xyz>, Hans de Goede <hdegoede@redhat.com>,
 Chen-Yu Tsai <wens@csie.org>, Adam Sampson <ats@offog.org>,
 Stefan Roese <sr@denx.de>, Maxime Ripard <mripard@kernel.org>,
 u-boot@lists.denx.de, Samuel Holland <samuel@sholland.org>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: [PATCH 1/5] power: regulator: Add a driver for the AXP PMIC drivevbus
Date: Tue, 31 Oct 2023 01:39:51 -0500
Message-ID: <20231031064039.50942-2-samuel@sholland.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031064039.50942-1-samuel@sholland.org>
References: <20231031064039.50942-1-samuel@sholland.org>
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

AXP PMICs have a pin which can either report the USB VBUS state, or
driving a regulator that supplies USB VBUS. Add a regulator driver for
controlling this pin. The selection between input and output is done via
the x-powers,drive-vbus-en pin on the PMIC (parent) node.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/power/pmic/axp.c                |  1 +
 drivers/power/regulator/Kconfig         |  7 +++
 drivers/power/regulator/Makefile        |  1 +
 drivers/power/regulator/axp_drivevbus.c | 57 +++++++++++++++++++++++++
 4 files changed, 66 insertions(+)
 create mode 100644 drivers/power/regulator/axp_drivevbus.c

diff --git a/drivers/power/pmic/axp.c b/drivers/power/pmic/axp.c
index 025dac24f28..e9d34c7d38f 100644
--- a/drivers/power/pmic/axp.c
+++ b/drivers/power/pmic/axp.c
@@ -51,6 +51,7 @@ static const struct pmic_child_info axp_pmic_child_info[] = {
 	{ "cldo",	"axp_regulator" },
 	{ "dc",		"axp_regulator" },
 	{ "dldo",	"axp_regulator" },
+	{ "drivevbus",	"axp_drivevbus" },
 	{ "eldo",	"axp_regulator" },
 	{ "fldo",	"axp_regulator" },
 	{ "ldo",	"axp_regulator" },
diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index eb5aa38c1cc..4fe75cda8fc 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -57,6 +57,13 @@ config SPL_REGULATOR_AXP
 	  Enable support in SPL for the regulators (DCDCs, LDOs) in the
 	  X-Powers AXP152, AXP2xx, and AXP8xx PMICs.
 
+config REGULATOR_AXP_DRIVEVBUS
+	bool "Enable driver for X-Powers AXP PMIC drivevbus"
+	depends on DM_REGULATOR && PMIC_AXP
+	help
+	  Enable support for sensing or driving the USB VBUS on
+	  X-Powers AXP2xx and AXP8xx PMICs.
+
 config REGULATOR_AXP_USB_POWER
 	bool "Enable driver for X-Powers AXP PMIC USB power supply"
 	depends on DM_REGULATOR && PMIC_AXP
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index d9e0cd5949c..8e59056124f 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_$(SPL_)DM_REGULATOR) += regulator-uclass.o
 obj-$(CONFIG_REGULATOR_ACT8846) += act8846.o
 obj-$(CONFIG_REGULATOR_AS3722)	+= as3722_regulator.o
 obj-$(CONFIG_$(SPL_)REGULATOR_AXP) += axp_regulator.o
+obj-$(CONFIG_$(SPL_)REGULATOR_AXP_DRIVEVBUS) += axp_drivevbus.o
 obj-$(CONFIG_$(SPL_)REGULATOR_AXP_USB_POWER) += axp_usb_power.o
 obj-$(CONFIG_$(SPL_)DM_REGULATOR_DA9063) += da9063.o
 obj-$(CONFIG_DM_REGULATOR_MAX77686) += max77686.o
diff --git a/drivers/power/regulator/axp_drivevbus.c b/drivers/power/regulator/axp_drivevbus.c
new file mode 100644
index 00000000000..c463de8786b
--- /dev/null
+++ b/drivers/power/regulator/axp_drivevbus.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <dm.h>
+#include <power/pmic.h>
+#include <power/regulator.h>
+
+#define AXP_VBUS_IPSOUT			0x30
+#define AXP_VBUS_IPSOUT_DRIVEBUS		BIT(2)
+#define AXP_MISC_CTRL			0x8f
+#define AXP_MISC_CTRL_N_VBUSEN_FUNC		BIT(4)
+
+static int axp_drivevbus_get_enable(struct udevice *dev)
+{
+	int ret;
+
+	ret = pmic_reg_read(dev->parent, AXP_VBUS_IPSOUT);
+	if (ret < 0)
+		return ret;
+
+	return !!(ret & AXP_VBUS_IPSOUT_DRIVEBUS);
+}
+
+static int axp_drivevbus_set_enable(struct udevice *dev, bool enable)
+{
+	return pmic_clrsetbits(dev->parent, AXP_VBUS_IPSOUT,
+			       AXP_VBUS_IPSOUT_DRIVEBUS,
+			       enable ? AXP_VBUS_IPSOUT_DRIVEBUS : 0);
+}
+
+static const struct dm_regulator_ops axp_drivevbus_ops = {
+	.get_enable		= axp_drivevbus_get_enable,
+	.set_enable		= axp_drivevbus_set_enable,
+};
+
+static int axp_drivevbus_probe(struct udevice *dev)
+{
+	struct dm_regulator_uclass_plat *uc_plat = dev_get_uclass_plat(dev);
+	int ret;
+
+	uc_plat->type = REGULATOR_TYPE_FIXED;
+
+	if (dev_read_bool(dev->parent, "x-powers,drive-vbus-en")) {
+		ret = pmic_clrsetbits(dev->parent, AXP_MISC_CTRL,
+				      AXP_MISC_CTRL_N_VBUSEN_FUNC, 0);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+U_BOOT_DRIVER(axp_drivevbus) = {
+	.name		= "axp_drivevbus",
+	.id		= UCLASS_REGULATOR,
+	.probe		= axp_drivevbus_probe,
+	.ops		= &axp_drivevbus_ops,
+};
-- 
2.41.0

