Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA84CD98DA
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 12:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1061C84704;
	Tue, 16 Jun 2026 14:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="bt9fINal";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 674B084869; Tue, 16 Jun 2026 14:58:06 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42DDC846A4
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 14:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiJtHmOpOWGvVOeBkT15aWArGYl2+bwjWXXWI/+aN+fiDkCaV6oAa1WeLdaKv7lZ543jeItHupVaJhET+UXxOQqSJcAjH0OetbJPGSkm72apOxZtQV4cLfM9Tm31zx/ewijD+zfhix32EYXTNr/+spGbD6uIQwh9uuYRp0KisWPvqZrY2Q0qufbsENl8hoOCYiLOw23tKBA8xNjzs5bZ/v5hvSLuYY57+YQIGVyem4j0qyB5mQJxT3o3tlIFN41iuug/M/1ysuYoTGf8VyR0/fq179D8nGNxu7jnZmZ3sZsS/qA37gX0ByWDBlWFFT31yT+cGZ3xB4UfMBcJxIEnQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cveyfrj22XVXpvoEwoB3bXHKCiqbPc/bpmQyYte4Tls=;
 b=FAy3hKqCGfXUNI+AgEGR7Vekbtsug6wc7m/zV76exAA2svfMU9SPXAiMiHXpTtHky0tldNLy13+iP7pt2KcPf91oeK9rUYyBNRWE3eFf8bVMptk0esgqJi0AX2qjn2Cx2JOp7a4iRCX+XRMnjqunfohF1eqp3RD5O5CxAWBjnb81PE4ltjTTKAEkGEH3IQyBpxTi0wyQdiJDjWK/kAZDt4VthRFoeMgZ7B2SfZm/WantYKAur1sxijpNvZoP817aTKEmyI8QE02OD0Mr0mI3h+qNwqz251rv09DOp2/U3arCtqu4jHHhnv/ob2wKJRXNJmfdAD9mP9ZcsqDUBETeaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=linaro.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cveyfrj22XVXpvoEwoB3bXHKCiqbPc/bpmQyYte4Tls=;
 b=bt9fINalBOASeltttPi9cycVSzgJaP7O+CYc63hYzb85mP4cL72Zk6UfuAzIqHqijTCY9xSr3Rk1e12afXPpnJ+fs7awMMhPO2yks5KKTw6t9rJrkfxNK5KzcJjb23QzVL9k0bYbQ3KXEEl7UazgomfHFx/+fHxcs7KavFSJ42aq5rlz4wscKMO2pTpKKApTXmoSQc30Hj/yPi5rzg2DnT9exGtILW5DwjnYxh9Eez9U1L27g5FqyCFZ4/RPH+piCVXKlCvtXRDiKvF9diD+KwkaHXX4+Rxg8169oQBHC0Wn7DrHLQtza4CfL4qfOohV4BtYyn5VT7m4pPznEK9S1g==
Received: from PR3PR09CA0003.eurprd09.prod.outlook.com (2603:10a6:102:b7::8)
 by DB8PR10MB3212.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:58:01 +0000
Received: from AM4PEPF00025F9C.EURPRD83.prod.outlook.com
 (2603:10a6:102:b7:cafe::93) by PR3PR09CA0003.outlook.office365.com
 (2603:10a6:102:b7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 12:58:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM4PEPF00025F9C.mail.protection.outlook.com (10.167.16.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.0 via Frontend Transport; Tue, 16 Jun 2026 12:58:01 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 16 Jun
 2026 15:02:15 +0200
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 16 Jun
 2026 14:57:58 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Tue, 16 Jun 2026 14:57:56 +0200
Subject: [PATCH] usb: gadget: dwc2: reset endpoint enabled state on reinit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260616-ums_fix-v1-1-f1f6c903b3fc@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAFNIMWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM0Mz3dLc4vi0zArdtMQUC3NjM0NTkyQzJaDqgqJUoDDYpOjY2loAz1+
 Fo1kAAAA=
X-Change-ID: 20260616-ums_fix-fad8736154b6
To: <u-boot@lists.denx.de>, Stephan Gerhold <stephan.gerhold@linaro.org>
CC: Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.15.2
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9C:EE_|DB8PR10MB3212:EE_
X-MS-Office365-Filtering-Correlation-Id: 1958844a-1b14-4819-7824-08decba6e5b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: G9W/WnQfMpPiFSjIIXg6wmO3k8aJ2Mb7Xd2IRVnsowip87GVX8S0SbT37uloPsipFvB1Bpp15pGCXtiVyh+z+gFNjxSWUzqbF7cdVUMRDjY/f9S8Yxo6dXm3GOIIj1Ese+OV/fuvptcaAMiGyMl8DbWG9Ay+znRcmPq8DDf18Z+5ju/guCSveS1dXxb03Y9PTuCTIv3vrzKQN/av8j7h3nq88lonqMgKoH3csMvykJr6RRwHccE8hpK+kBXfwFrCbE7KiD6HRf2Oq8HOnT2PCos5NT3jho50nTzmrVg97nr5n6W3JfC0tnH2Na7lbsALtUtgMuy+UNX4aJpGYdbFq2sk0lWp/vsgWYniLyOIHY3lEXkR94r1je7lNyBlbtbmwaU63F6F1X/u5x9x1gnxRrZPWM/94zUreqFvALli6BupkW26y3CQNP3QZOmKFMLK1ji+CHY6rpRnIXDbYe+XgwpAbkiXsBp4FTvRpHMvulVCXl1MSTXHlwRIiMya+O44hKJ7XFNhZKBlF+G8Fy+SKEaUdxrcgPwevEAvp8IflTC8u/KFviLbXq5vZfN/1SZ3gy1h0115pY67fiKVnO+FQd7sR1dnUg1mzAL7xOgPydAYyW4pl7WZ4FNrM7aQDgDzD2SkdVgZ7EAYw6P36FVocSHeFUZmOXgHRcnXZIbTURiAp7aSd+Sm/TLyE5OUaVfVmt4MbgPj+wOloXGOZeSFXBptkROumYkeqwvtL1Syk+I=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SE/JWdSCC7dS8n+F99nRJ9H2flYW0/FjCWrhJlk1dbBqOHEGqJeffYkM+4VJTCnaihImhhZZmAgNuJVTPZ9jB+VlgrVLsCj7dRg7oBTVk1C7Nwr680Qhzbu4LA8qmz/vQh6cLgK0kMOHbNGynIRohTfQ9RpK6FsXuA1BtYbgUscAbImkXL6snKlqANafQKNuX+TWhjStwiZGLpOm3+MCQqb/LcY0zZaMIk4CQQz2MHfJQGCUI5BwqWnG9vTnoR9L2rVUi5A/95SCjvl74uswkt01/jBgfYfRw4j48IVw9jzmT7XJNK+G2WiXEZ36mk9S3MmhbkklWpl2L+s+ORZskGaMwajvazhmgI6jOVzR7hLN24dNGHrukHC6FVOY80VRVPslZqXcLUA3P9Qx5jUICTMhvpfMClMPtO4ttKBuUfI/RzQtyd8djADFW88k5kSw
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:58:01.0995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1958844a-1b14-4819-7824-08decba6e5b3
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3212
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

Issue found with STM32MP157C-DK2 board, first usage of "ums 0 mmc 0"
is working, but second execution doesn't. The mass storage is not visible
from host side.

Since commit 59310d1ecb9f ("usb: gadget: introduce 'enabled' flag
in struct usb_ep"), usb_ep_enable() returns early when ep->enabled is
already set.

The DWC2 UDC driver reinitializes its endpoint software state in
udc_reinit(), including descriptor, stopped state and request queues, but
it leaves the generic usb_ep.enabled flag untouched. After stopping UMS
once, endpoints can therefore still look enabled to the gadget core even
though the DWC2 endpoint state has been reset.

On the next "ums 0 mmc 0" run, usb_ep_enable() skips the controller
enable callback, so the host no longer sees a usable USB mass-storage
device.

Clear ep->ep.enabled together with the rest of the DWC2 endpoint state so
each new gadget run programs the hardware endpoints again.

Tested on STM32MP157c-dk2 board.

Fixes: 59310d1ecb9f ("usb: gadget: introduce 'enabled' flag in struct usb_ep")
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/usb/gadget/dwc2_udc_otg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index e475b14b9ac..5752bf3ca70 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -209,6 +209,7 @@ static void udc_reinit(struct dwc2_udc *dev)
 
 		ep->desc = 0;
 		ep->stopped = 0;
+		ep->ep.enabled = false;
 		INIT_LIST_HEAD(&ep->queue);
 		ep->pio_irqs = 0;
 	}

---
base-commit: badd97fe24dfb73b2728c26b433cabe315a27971
change-id: 20260616-ums_fix-fad8736154b6

Best regards,
--  
Patrice Chotard <patrice.chotard@foss.st.com>

