Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B19DC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 15:37:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ADF8C60665;
	Mon, 24 Aug 2026 15:36:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OK7QuMk3cqSF; Mon, 24 Aug 2026 15:36:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787585819;
	bh=z+Pzro5gjNPUySLP9nmJ2lf309WGlcYJ9Z0KX/mlXP4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=A8gZBiUPbkR+EVYuJ9tG298STjY6p5dO4+LHdxsyclKnOi3mysb1UnYhZmzvKnj6M
	 NXBSTS7SMnU7ETEfwYY86dlW8ekEDajtMYv0r+L1tuYSaQi9HkmNY/6pa5y+13c5vu
	 YxBr9MFptSD/lAHR2eJf+pPHCn/imYd5oS4aT+EImKiJN9tAaxt2MQrEJd2UBu/+bW
	 dx1KcwY4AssmQEmJAaIwxCrTZr3c9cMfvuPCzw2JTxsyZN2mi8PztE/hh67uKCBuCx
	 OxdcyrO7i7PE+9j1hAQ4PdLyNYWfAZwm9ANfCk7M7FQF8ieOKy4GAEvk9qrqHGt1W6
	 FNy5clBZ3LFZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DBD4960627;
	Mon, 24 Aug 2026 15:36:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 23906279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:36:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0CC1460627
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:36:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BdNDnz4bL4Wh for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:36:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=HZ3cGAXn
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DA393605EC
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 02BFFB0055A;
 Mon, 24 Aug 2026 17:36:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1787585813;
 bh=e9abFRDKVbLnyV4FthGvYTuA4hn/6Ogjdjh5EOuavu8=;
 h=From:To:Cc:Subject:Date:From;
 b=HZ3cGAXn8SrD6S4PJCg1nqrnprT5e/vj8IC3ev9iCy7IBP9NlCC4PrHkYQfSk7EbE
 aazUCvr7bCT8zpCEJigQxTCObHhUQtu1vIf6eTThloCXm6z/tuX8Gnr9mxG0GNGUGV
 TOgZ1XlHQRsHiM8quPgMoNfwMcGMB9Pk3YPhHakfipPgdR6bXOm7VixWdIAcuu54Ot
 lPHZGYmJiQ49Q2vIXCFKJyqtDGpdSyU8HMRKtfNjdCmSGmKAhcUNzaadXkN9A5Cx6H
 vwDE7zhiAQzwEoPNoSWxyYsbOlcZ0JVVIvBq4n7OiwnfgImKHD7+0dmkAs9FSrjh7Z
 6GgENnzSt1Ygw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1] power: regulator: mpq8785: match the MPS MPQ8646
Date: Mon, 24 Aug 2026 17:36:40 +0200
Message-ID: <20260824153640.2769317-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add the MPQ8646, which handles the same case as the MPQ8785.

It shares the info table, and it shares the VOUT:
both parts report VID in VOUT_MODE while actually encoding VOUT
as DIRECT with m=64 R=1, which mpq8785_identify_vout() already fixes up.

Linux does the same thing from the other side:
drivers/hwmon/pmbus/mpq8646.c intercepts PMBUS_VOUT_MODE in
read_byte_data() and returns DIRECT when the chip says
VID.

Linux gained the compatible in the shared binding
(Documentation/devicetree/bindings/hwmon/pmbus/mps,mpq8785.yaml,
commit e7ba3115134b "dt-bindings: hwmon: pmbus: add MPS MPQ8646"),
which groups it with mps,mpq8785 for mps,vout-fb-divider-ratio-permille,
the same here.

Verified against silicon on a board whose +0V8_VDD rail is an
MPQ8646: the chip self-reports MODEL="MPQ8646" with VOUT_MODE=0x17.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 drivers/power/regulator/Kconfig   | 4 ++--
 drivers/power/regulator/mpq8785.c | 7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index 00a25acfdf9..8d4d6e69e46 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -598,12 +598,12 @@ config DM_REGULATOR_PMBUS_GENERIC
 	  m / b / R coefficients) need handling.
 
 config DM_REGULATOR_MPQ8785
-	bool "MPS MPQ8785 / MPM3695 / MPM82504 PMBus voltage regulator"
+	bool "MPS MPQ8785 / MPQ8646 / MPM3695 / MPM82504 PMBus voltage regulator"
 	depends on DM_REGULATOR_PMBUS_HELPER
 	help
 	  Driver for the Monolithic Power Systems MPQ8785 family of
 	  digital multiphase voltage regulators with PMBus. Supports
-	  MPM3695, MPM3695-25, MPM82504, and MPQ8785. Adapted from the
+	  MPM3695, MPM3695-25, MPM82504, MPQ8785 and MPQ8646. Adapted from the
 	  Linux drivers/hwmon/pmbus/mpq8785.c reference.
 
 config SANDBOX_PMBUS
diff --git a/drivers/power/regulator/mpq8785.c b/drivers/power/regulator/mpq8785.c
index dc321f0e410..72bfaa5bf8c 100644
--- a/drivers/power/regulator/mpq8785.c
+++ b/drivers/power/regulator/mpq8785.c
@@ -32,6 +32,7 @@ enum mpq_chip_id {
 	MPQ_MPM3695_25  = 1,
 	MPQ_MPM82504    = 2,
 	MPQ_MPQ8785     = 3,
+	MPQ_MPQ8646     = 4,
 };
 
 /*
@@ -398,6 +399,7 @@ static struct pmbus_driver_info *mpq8785_pick_info(enum mpq_chip_id chip_id)
 	case MPQ_MPM82504:
 		return &mpm82504_info;
 	case MPQ_MPQ8785:
+	case MPQ_MPQ8646:
 	default:
 		return &mpq8785_info;
 	}
@@ -444,8 +446,8 @@ static int mpq8785_probe(struct udevice *dev)
 		}
 	}
 
-	/* MPQ8785 specific: refine VOUT format from VOUT_MODE. */
-	if (chip_id == MPQ_MPQ8785)
+	/* MPQ8785/MPQ8646 specific: refine VOUT format from VOUT_MODE. */
+	if (chip_id == MPQ_MPQ8785 || chip_id == MPQ_MPQ8646)
 		mpq8785_identify_vout(priv->i2c_dev);
 
 	/* Apply mps,vout-fb-divider-ratio-permille if present in DT. */
@@ -481,6 +483,7 @@ static const struct udevice_id mpq8785_ids[] = {
 	{ .compatible = "mps,mpm3695-25", .data = MPQ_MPM3695_25 },
 	{ .compatible = "mps,mpm82504",   .data = MPQ_MPM82504 },
 	{ .compatible = "mps,mpq8785",    .data = MPQ_MPQ8785 },
+	{ .compatible = "mps,mpq8646",    .data = MPQ_MPQ8646 },
 	{ }
 };
 
---
base-commit: 6073c36b2c8d39afe3ecc789b281667a3ddebc70
branch: for-upstream/power-regulator-mpq8646-v1

-- 
2.43.0

