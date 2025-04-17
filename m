Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB24C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 11:53:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C20582F5A;
	Thu, 17 Apr 2025 13:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="WG3XhzrX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18BF682F87; Thu, 17 Apr 2025 13:53:27 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20707.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::707])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6417082D18
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 13:53:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqShBhLAJpKC+5HCeDAOKMft4DQ1GYx/qTsha2QnCF6jVwLfwTotrHHNXvLcnuLtoFAZH1TDiirmGkGMayRXvYodk5DPQspxqHv9JEuLk6f375f4A33NAodkGjHYuj1eNwzoKhWO6OjNKZjBtVHtF6jkTJoRDJAav1uhOa/aWtrWqiXbMTVCdykO3RxCUIVLvAW5Zh7B8YQybr7WlSa/qfhyWxOwwztTOShGvrBX0gJb423HJqLao8QmcqMyZ1OPyedo0wesn3A/psmBHTEZOPDRzWtgCbOT+0ei/F0HqK5fIZw0C0Ic4ypmmBqYa2pH/kx4P6zpDfDJWmzbTqtuvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6m50zPGTDAq+LATm2FP2zFz7ahQU9Mr6dNnTehd1HQ=;
 b=j65qYIlbxbPXg7NaK3aIzLIP1juFTlvIdjYsy/pf+3i4FaMjes8xQ26iHR3mMmiXHU0X+kp0Vjv+x5I6vphYZtiARxj+VPPQ3mOTFv/8lJznEukTxBxyAx7glXTVN8q3e1vF43AxaCOIposdEBV4hkbyb+PmkrLqE7Gui7OfCtOxyV43oaMWOXVKcqug0xgESC/7oSe6P4ZFvmEykRs5hPZfb4XWlTqsfdRymSlH1llScOZG/vFTD5wENAni7Nt9/8sPRG9DdlSJ2Dq1UZVZtcyNAc+XAx+Fyav8XiOZVv5mApocZcyuuN1aGehd0JwpqaTiKAFlcGjIEmeux2nrlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6m50zPGTDAq+LATm2FP2zFz7ahQU9Mr6dNnTehd1HQ=;
 b=WG3XhzrXViHpDk8xK+hrtNTnDj4KsOWC3UIYf89Pf8KNYSzuptLW7qEDK8/xEHMs1yAylzr/k5Cg3/NiwOGWlIcpbbisP4PP9hLff30tkmRgS4QOMPbEf/omMg1m7yR4jCeSMzRsH5BOk1q8cVOvVyiAfYqfyGItn1/KKkbO2FyjzpnOGYc7I5GGBg4vuB9DAn3Gtmsef0rFz5o8VNGCdQndrlPAjSh73AVSPXYqJK73sTZu+2bicw9Nr/a4n+eJliIiDZRnn4ZxUBlt0SESKe9qQQm12LQXr087GsD0sW52WV7W1Rnsug9i+1szp4YOfVqE7iKKAzku70Kkw9wDNw==
Received: from PA7P264CA0195.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:376::14)
 by AS4P195MB1888.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:580::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 11:53:20 +0000
Received: from AM4PEPF00025F9A.EURPRD83.prod.outlook.com
 (2603:10a6:102:376:cafe::a8) by PA7P264CA0195.outlook.office365.com
 (2603:10a6:102:376::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Thu,
 17 Apr 2025 11:53:20 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM4PEPF00025F9A.mail.protection.outlook.com (10.167.16.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.4 via Frontend Transport; Thu, 17 Apr 2025 11:53:20 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 17 Apr
 2025 13:53:19 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 17 Apr
 2025 13:53:19 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <miquel.raynal@bootlin.com>, <trini@konsulko.com>,
 <jh80.chung@samsung.com>, <sjg@chromium.org>, <ilias.apalodimas@linaro.org>,
 <thomas.petazzoni@bootlin.com>, <ian.ray@gehealthcare.com>,
 <dario.binacchi@amarulasolutions.com>, <aford173@gmail.com>,
 <seanga2@gmail.com>, <nm@ti.com>, <francesco@dolcini.it>
Subject: [PATCH] Revert "power-domain: Add refcounting"
Date: Thu, 17 Apr 2025 13:53:11 +0200
Message-ID: <20250417115311.1905411-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9A:EE_|AS4P195MB1888:EE_
X-MS-Office365-Filtering-Correlation-Id: c5c828b6-d565-44f3-5fea-08dd7da672d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lFWckRqUQmoAWZNsVIArgAbEj1aWAuI61b+vPSIm0JCWYDGE8TqRn9MVXIQc?=
 =?us-ascii?Q?K4DBawCCL+KDgcDkb6Lo5P31UYi9ylKc5HC+Ut0INfZRp8j+cVvlOfPoDBdG?=
 =?us-ascii?Q?DfGG/OCVNB5EnThIA4bF1Esao1lOS4IffGt14Ck7rthOBwjRnqjqotG56kO5?=
 =?us-ascii?Q?Z1f7Y92LTwmY2uJZo2mcU4xYVE1rR851MrVzMZ9Y52dZrjt5tmBClPC9hdGm?=
 =?us-ascii?Q?nyE7j4OGdYqKjRAdEdqUEn68npnQzvHn2HYs+xtVvanAnULvHRctuXUjVml/?=
 =?us-ascii?Q?aySFvizf2UIsVEu3/m0NIObLZg6PdIBO27bQZkpgkiR7CEbU5YXuPXfb+/lJ?=
 =?us-ascii?Q?vHqp75xlVFQHef0JxxgpLe/sdKo52iS7v3esYew04IXoZifwseUzCXHuPfob?=
 =?us-ascii?Q?ydfXRKWum4uKXJ7Xv2PT437WJX1nFpdCtfHKh/QETiZBAAOwaZx/oB91Sj4Z?=
 =?us-ascii?Q?trLK6lTfjC9IlQrmy5QlPrBTGunioRYu9vyprrQkvTUS6a+8EQNml0XfnP1M?=
 =?us-ascii?Q?CadJ2w5rnW0lVpqXdl0hFeZ/vAg4k0LiPws21/+PPnAJ1y3uUnbUat7+7UFH?=
 =?us-ascii?Q?gdX+pkExZb9n8nuhyRvISi5qKzA6ewW5CsPi1rCLA6yMmYT8xgnjipBjODyy?=
 =?us-ascii?Q?4+WutdXamo0wgEB89E6jFrWgWl2FEOK4kTyS7DfSoFkpwkA8EVETpBoZtqFl?=
 =?us-ascii?Q?yhw6M4l8Ygks/G5/s06bMetNrcrWPxS3g9AYPHB1SZIF2H9z3p3s3gd3G2+x?=
 =?us-ascii?Q?jMBnPHI3XCEGL/s25xrgq1woTF+UkwT7bRJSkZ39IEb05KaJh37HQHQTkrGX?=
 =?us-ascii?Q?LFC5+H6VnySCbVdLXOoBfQzMZV2Y1/oiSeZBIJDdOHATpflbpRBi6rUE0x00?=
 =?us-ascii?Q?tI4nryEsyv3A7KPQBAum6hE1hINaF6+J47QMDazQwNHsGUFw2DWZG+z8IshN?=
 =?us-ascii?Q?Ivef3AEDHWVzrtxYSPZ6y4lNgxHTvjTJ7Qe84NnONfh2LKi/iqMaqC49hNXo?=
 =?us-ascii?Q?okh9mU+0xPiHqsrep5a7S84OaeoyD8gM1YuDkJ8QzYhH1Tncsw+DisLjVa2d?=
 =?us-ascii?Q?PbpJ4624MyhPJE0C7sgAEkO/zaYuOoMbVWsuYhmO+iDWbnnK1Z2dn6taWBIV?=
 =?us-ascii?Q?3+l/YsL6A1DP9LDyPHiX7Dul0rbFWLjYSC0B3ZVaPlV/mhdTLHTnsj6G1ek0?=
 =?us-ascii?Q?s6erheEAbp9q2QGD9fNQM2bBe7veVB2/8Hd+doCo/C1kB8UwyPLCWF44O3SO?=
 =?us-ascii?Q?8cERGyxomV3mNhdEkz1ntG6ILeNuBlZsAClc+0YA3sZPhiDuGkIwNpl/gpG/?=
 =?us-ascii?Q?3c+Ky/24v1U356TbiQRSId5Q2JJ8gDK4cMpIzWv6akLA+hBSMXjLopiZTpC2?=
 =?us-ascii?Q?M5L65hFv7BLCV3OWlV05c0ZyOSqH67AC21IQzjNaZxkJmtCRzUNCdB/S1INK?=
 =?us-ascii?Q?Y1EGfpkEs26mSgBNpx7v86Yo58A8ItXtH7UczJ9gC63d6LReWMUHHQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 11:53:20.0622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c828b6-d565-44f3-5fea-08dd7da672d4
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F9A.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1888
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

Unfortunately this change breaks boot on K3 platform.
U-Boot will hang after:

  U-Boot SPL 2025.04-01050-ga40fc5afaec0 (Apr 14 2025 - 07:31:32 +0000)
  SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)')

This reverts commit 197376fbf300e92afa0a1583815d9c9eb52d613a as
suggested in [1].

[1] https://lists.denx.de/pipermail/u-boot/2025-April/587032.html

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 drivers/firmware/scmi/sandbox-scmi_devices.c  |  1 -
 drivers/power/domain/power-domain-uclass.c    | 40 ++-----------
 .../power/domain/sandbox-power-domain-test.c  |  1 -
 include/power-domain.h                        | 60 +++----------------
 test/dm/power-domain.c                        |  2 +-
 5 files changed, 13 insertions(+), 91 deletions(-)

diff --git a/drivers/firmware/scmi/sandbox-scmi_devices.c b/drivers/firmware/scmi/sandbox-scmi_devices.c
index 9f253b0fd40..96c2922b067 100644
--- a/drivers/firmware/scmi/sandbox-scmi_devices.c
+++ b/drivers/firmware/scmi/sandbox-scmi_devices.c
@@ -163,5 +163,4 @@ U_BOOT_DRIVER(sandbox_scmi_devices) = {
 	.priv_auto = sizeof(struct sandbox_scmi_device_priv),
 	.remove = sandbox_scmi_devices_remove,
 	.probe = sandbox_scmi_devices_probe,
-	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
diff --git a/drivers/power/domain/power-domain-uclass.c b/drivers/power/domain/power-domain-uclass.c
index a6e5f9ed036..938bd8cbc9f 100644
--- a/drivers/power/domain/power-domain-uclass.c
+++ b/drivers/power/domain/power-domain-uclass.c
@@ -12,10 +12,6 @@
 #include <power-domain-uclass.h>
 #include <dm/device-internal.h>
 
-struct power_domain_priv {
-	int on_count;
-};
-
 static inline struct power_domain_ops *power_domain_dev_ops(struct udevice *dev)
 {
 	return (struct power_domain_ops *)dev->driver->ops;
@@ -111,49 +107,22 @@ int power_domain_free(struct power_domain *power_domain)
 	return ops->rfree ? ops->rfree(power_domain) : 0;
 }
 
-int power_domain_on_lowlevel(struct power_domain *power_domain)
+int power_domain_on(struct power_domain *power_domain)
 {
-	struct power_domain_priv *priv = dev_get_uclass_priv(power_domain->dev);
 	struct power_domain_ops *ops = power_domain_dev_ops(power_domain->dev);
-	int ret;
 
 	debug("%s(power_domain=%p)\n", __func__, power_domain);
 
-	if (priv->on_count++ > 0)
-		return -EALREADY;
-
-	ret = ops->on ? ops->on(power_domain) : 0;
-	if (ret) {
-		priv->on_count--;
-		return ret;
-	}
-
-	return 0;
+	return ops->on ? ops->on(power_domain) : 0;
 }
 
-int power_domain_off_lowlevel(struct power_domain *power_domain)
+int power_domain_off(struct power_domain *power_domain)
 {
-	struct power_domain_priv *priv = dev_get_uclass_priv(power_domain->dev);
 	struct power_domain_ops *ops = power_domain_dev_ops(power_domain->dev);
-	int ret;
 
 	debug("%s(power_domain=%p)\n", __func__, power_domain);
 
-	if (priv->on_count <= 0) {
-		debug("Power domain %s already off.\n", power_domain->dev->name);
-		return -EALREADY;
-	}
-
-	if (priv->on_count-- > 1)
-		return -EBUSY;
-
-	ret = ops->off ? ops->off(power_domain) : 0;
-	if (ret) {
-		priv->on_count++;
-		return ret;
-	}
-
-	return 0;
+	return ops->off ? ops->off(power_domain) : 0;
 }
 
 #if CONFIG_IS_ENABLED(OF_REAL)
@@ -211,5 +180,4 @@ int dev_power_domain_off(struct udevice *dev)
 UCLASS_DRIVER(power_domain) = {
 	.id		= UCLASS_POWER_DOMAIN,
 	.name		= "power_domain",
-	.per_device_auto = sizeof(struct power_domain_priv),
 };
diff --git a/drivers/power/domain/sandbox-power-domain-test.c b/drivers/power/domain/sandbox-power-domain-test.c
index 5b530974e94..08c15ef342b 100644
--- a/drivers/power/domain/sandbox-power-domain-test.c
+++ b/drivers/power/domain/sandbox-power-domain-test.c
@@ -51,5 +51,4 @@ U_BOOT_DRIVER(sandbox_power_domain_test) = {
 	.id = UCLASS_MISC,
 	.of_match = sandbox_power_domain_test_ids,
 	.priv_auto	= sizeof(struct sandbox_power_domain_test),
-	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
diff --git a/include/power-domain.h b/include/power-domain.h
index ad33dea76ce..18525073e5e 100644
--- a/include/power-domain.h
+++ b/include/power-domain.h
@@ -147,81 +147,37 @@ static inline int power_domain_free(struct power_domain *power_domain)
 #endif
 
 /**
- * power_domain_on_lowlevel - Enable power to a power domain (with refcounting)
+ * power_domain_on - Enable power to a power domain.
  *
  * @power_domain:	A power domain struct that was previously successfully
  *		requested by power_domain_get().
- * Return: 0 if the transition has been performed correctly,
- *         -EALREADY if the domain is already on,
- *         a negative error code otherwise.
+ * Return: 0 if OK, or a negative error code.
  */
 #if CONFIG_IS_ENABLED(POWER_DOMAIN)
-int power_domain_on_lowlevel(struct power_domain *power_domain);
+int power_domain_on(struct power_domain *power_domain);
 #else
-static inline int power_domain_on_lowlevel(struct power_domain *power_domain)
+static inline int power_domain_on(struct power_domain *power_domain)
 {
 	return -ENOSYS;
 }
 #endif
 
 /**
- * power_domain_on - Enable power to a power domain (ignores the actual state
- *		      of the power domain)
- *
- * @power_domain:	A power domain struct that was previously successfully
- *		requested by power_domain_get().
- * Return: a negative error code upon error during the transition, 0 otherwise.
- */
-static inline int power_domain_on(struct power_domain *power_domain)
-{
-	int ret;
-
-	ret = power_domain_on_lowlevel(power_domain);
-	if (ret == -EALREADY)
-		ret = 0;
-
-	return ret;
-}
-
-/**
- * power_domain_off_lowlevel - Disable power to a power domain (with refcounting)
+ * power_domain_off - Disable power to a power domain.
  *
  * @power_domain:	A power domain struct that was previously successfully
  *		requested by power_domain_get().
- * Return: 0 if the transition has been performed correctly,
- *         -EALREADY if the domain is already off,
- *         -EBUSY if another device is keeping the domain on (but the refcounter
- *         is decremented),
- *         a negative error code otherwise.
+ * Return: 0 if OK, or a negative error code.
  */
 #if CONFIG_IS_ENABLED(POWER_DOMAIN)
-int power_domain_off_lowlevel(struct power_domain *power_domain);
+int power_domain_off(struct power_domain *power_domain);
 #else
-static inline int power_domain_off_lowlevel(struct power_domain *power_domain)
+static inline int power_domain_off(struct power_domain *power_domain)
 {
 	return -ENOSYS;
 }
 #endif
 
-/**
- * power_domain_off - Disable power to a power domain (ignores the actual state
- *		      of the power domain)
- *
- * @power_domain:	A power domain struct that was previously successfully
- *		requested by power_domain_get().
- * Return: a negative error code upon error during the transition, 0 otherwise.
- */
-static inline int power_domain_off(struct power_domain *power_domain)
-{
-	int ret;
-
-	ret = power_domain_off_lowlevel(power_domain);
-	if (ret == -EALREADY || ret == -EBUSY)
-		ret = 0;
-
-	return ret;
-}
-
 /**
  * dev_power_domain_on - Enable power domains for a device .
  *
diff --git a/test/dm/power-domain.c b/test/dm/power-domain.c
index 8a95f6bdb90..896cf5b2ae9 100644
--- a/test/dm/power-domain.c
+++ b/test/dm/power-domain.c
@@ -27,7 +27,7 @@ static int dm_test_power_domain(struct unit_test_state *uts)
 
 	ut_assertok(uclass_get_device_by_name(UCLASS_MISC, "power-domain-test",
 					      &dev_test));
-	ut_asserteq(0, sandbox_power_domain_query(dev_power_domain,
+	ut_asserteq(1, sandbox_power_domain_query(dev_power_domain,
 						  TEST_POWER_DOMAIN));
 	ut_assertok(sandbox_power_domain_test_get(dev_test));
 
-- 
2.34.1

