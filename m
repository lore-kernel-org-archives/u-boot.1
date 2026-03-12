Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFC2105A594
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 12:47:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AADA841FA;
	Thu, 12 Mar 2026 13:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="E2LPLi3r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7444484189; Thu, 12 Mar 2026 12:23:14 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88CE88416C
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 12:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2+xmuYBPugMesk9g7qqm1D6LjjxZx9iKN2QEIhX9RRbaZqAHk7rrydN4jVFNDq/oAx3bTkSMdWp8UZkc0LxXVmbuY1Q5UwdG3PHtTSH1S9ZqKYXTgtOfwNE0LcRJrOsGuU1akSsc/F64tdY0VAQLlOYFJ8/RWswLoYe7WRB9FEm6C3SbKiZaU++ZfLeNd81CuBkTSc45IIzVt+OSIHkNsCOW13pu7T5yc2kZfNVc7zIezkgx8QKCnYT/0ZAyeHrW7clNdSnHfsNEe+9QmEjNDBPt4YISdWyF993fD8aIEVXtY7DaC/HQmfQGRxWomJEK8B2MQTKjnaH3JYgVa7Gqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9u2yCDqOOlgMUiIbRog5G2K8ufvWZAhrDD4x54W4L4=;
 b=OCfB1pHyN+bJgxP9bh+ZSZ3iRQ4MwHk6mJMyvwIx0UQA1T2OYyhF3ASNPZH9JalOWitLQa8vfs69hM7ZV7iT5+nnCIgvOJT7lKOgo96CY0RIQ6ORXOiMuE/FrdkVw2W2B8wUUm/w+mJIBNltWNio4dQrKEjK39p1qztURyLibKabEVNU+R/smf0hxafP0+htkEtcN3S3LOh5TylVhBUqMHzl3b2pQBMCC4Qz34In71HlpkQnFp875YUUzdDk9JgqWY0EkxrJ+QscbqxgtXNCk5lFVufMRghGPbMz9dDojc/QJUAODmY0kdwLNjhyiu4pOs6UHVJlvBV/sbqddC1Igw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9u2yCDqOOlgMUiIbRog5G2K8ufvWZAhrDD4x54W4L4=;
 b=E2LPLi3rtUbWWoA5NkxfUMWkQ50HEw9HQGlrCXThUuntuH/A8A7cihqbOCI8Yw1jWZWST6EkTeyHoDHjiNYF8Be1fH/cvzWfd+90fwlApzmSm6CIzQmaAUJ4heCBUnfn0jAnkF5afi4osRbqHO9XUc4f/nVtMkRbLYqhHt8HyD26yx2dUGy+0oAXsWbbcObsBQ8lz1CwYfQCYzFiafamHaWNykIhXEygsPhsp+ndcx+ycBobWI+ahEdAG9Ip/gw4NFO3Q1WbgZQVB4efIyTNVhVcPcFUPowgBs8vlgTDKoILA8iO/573mH5bCTgT8TvQ51w6NzngabqV53AX52jfkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by DS0PR03MB7225.namprd03.prod.outlook.com (2603:10b6:8:123::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 11:23:05 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9678.023; Thu, 12 Mar 2026
 11:23:04 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Nikunj Kela <nikunj.kela@sima.ai>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH v1 1/2] net: dwc_eth_xgmac: Move DMA reset and pad calibration
 after PHY init
Date: Thu, 12 Mar 2026 19:22:46 +0800
Message-ID: <20260312112247.30570-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::6) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|DS0PR03MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: dfce9a8a-0e71-48b5-c2ec-08de8029ba65
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|55112099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: AELByXmiftcU4s7RlvqiC0gOogT7iL17meCDakSzaK4/RKdtfJC+kIRdoWxsYLlibz30snP7kWYK7mD7wGgGtfLU/AHCRspBRYclSCquOOxJ4DlOw9k2yjkyahg5NShVja6jnowyAc/I9WtRx4nRKWcpG+zUMhVAYTyyOr/BqzI4yt2DmBzIyA6XAHFl1Hsqj4/2FUmbMIO+Ky66w2rCsN1XarPxfiSKU/3awOW+5VvnL9a65Sms1eGnMlKA7U7ejIq9JsnY3+kmdh2d52iW6CD4JEbQSQSV16AwXUOw9UpPXZbOHi3CRuMopiml3t7fZb5rI35oKuBCaUcRcL0QI8rrTqgqQ4C54GWPc4CyLzQlNJph4MN3nWD+IowfN1QKXxxTDAXd7PCoOZL9OzQQPPFFSG+cCtx8vKE/ksr0/xsDdaa8xn8u99yJ3kRnd7RD8Rq1N0lF0dTh/94gElCg+cVyXg00+QfwDS6S1qrfWNu4dCT7l3qpNTCHYB9uEVzITsmsgBbB4lVLEdSAO8Lm9N+aRTD/9vP4lq9X8L3fiEHVRWyLtloiQ/VxDccerWZZwhW4RMLkngz8bh4KXp+GtQBI/VyaQ2wI3m9Zj90sW263qYArYvtMAmaaCWX1b+IPqFuz/QrCXUjqGBYJ3cjHgjYyAXMlOxp/klJ4Byw6DoJ0QxqLNtPF9zk/VV3ay/s6iKcPl7uKwEgWyeFu4huI1Vq9tsY9u7/PZNCxNEpiG+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T/ag1ojdOnLpqDrHOqlCGrvLzVaXQsVXs+uXrUbR6pgkkam55zIiEatm58VK?=
 =?us-ascii?Q?xa6umvT6r2J0e7rQhqimz785C72wJu6s8ltZScC4wheLx8+Ym3T/XiLqMbiO?=
 =?us-ascii?Q?UX50g9RS0m9LUIq0zFj8gJ63u+ftzWOHW/smLqsiSl4PvGXxPuo6wpA5Kv7r?=
 =?us-ascii?Q?XOMXUHt2+N6ggbu3teO3tFYotwQ+MfLYVu2tmNkU7up8Mh/1zbSkfdbBCWM9?=
 =?us-ascii?Q?uYG6AXCxUNHq9A2sx+LYXLR+sown4cr32QcQ9U4Jyft6wkvfzMxf6fHKTfqf?=
 =?us-ascii?Q?YTInewMYmusVk3IrXeF6C9BsKld7nymZq7DNtYuE4cX+Y10RhuSIcqxljMUM?=
 =?us-ascii?Q?fvy80DDne14h0o74u5F90/1HUoS3NDB1l1Og/uHiqeugTEH1z2jLqMv1Q5nT?=
 =?us-ascii?Q?4qZHoUvV1GYSGOU546Y0tpUJ2rssAm+w+oJTlmqwHHu3Z2yavVnd12HuSSrv?=
 =?us-ascii?Q?OVa9Qikrs5w8ppCU83oOcgWzq7+/48J4VhxE1C2MSE7LMf2kJBVzUEetf1a0?=
 =?us-ascii?Q?whkuMyOuGXtjPkQWUo1mnlvv+YNqTmmC+7coHIhilToc9+ca6zpKdjQP2vM8?=
 =?us-ascii?Q?781rrlyxZKNrFyUEWROOaCjnC8KuZg2xqJvFHa91/TH2TVnVVoqMoMaPMymC?=
 =?us-ascii?Q?W0NLVLpMFf9mKUUL2bcZszBpAX/GXbYslbA+Ofon05Mq4lddNmYSNcwGNc32?=
 =?us-ascii?Q?tlNOl71EoTkGc6SgsaoExAi3Dvoj1HEqxX9hpOOF5qQaWpgOg5T56Wmml59U?=
 =?us-ascii?Q?5m7folDDIBg1jBBqqlo9QqCKEl1r1hbJhhMUn+uOIfRjGEnGdL355+Ad4LyZ?=
 =?us-ascii?Q?ay5bYraXKDbPCpgYG0Wclwr5tKxG0J8IyynIQx0krP76N9u0C/V5ShJD3oIW?=
 =?us-ascii?Q?wgETXTQJKAQj4Uq/QTjumsE0cKgoE1NEe9ae0iKglTOH44XG0MRHmycAxsyp?=
 =?us-ascii?Q?+XnlyXRfeLqWnNBMVaO5gaqtc3/hs0L0YI7oSiyhmlmXWtWYHGGWgBOXYRRF?=
 =?us-ascii?Q?oz9+0AbFxiFtfzoW3cSEweN8ZC9DcFMThLp19QBkeeGLC7SX7XfEbUVdfVPP?=
 =?us-ascii?Q?3OvTVAqLz320FbZB0VunZ6LVuKvjxbBSzYgTcG6viXCf4USGtGOCUGSSpg9M?=
 =?us-ascii?Q?NW0w3YyKuOzGGWQ4bfRwzBwlbJQPrcXK5LA+Mp0h0jZU4QFNOQgsE5w+TCvo?=
 =?us-ascii?Q?dkD8KF08AywSJ+9K7TSbNQ/X4U41pONKFLXcNWy1DxE/41in97irwh+IRIox?=
 =?us-ascii?Q?jRHFd/heyJcS5HaI0mraDMtzCU6DVY0Q5HJan9uw7RkDSMfmPa9xYsJA0fJn?=
 =?us-ascii?Q?h0+/MeyJ5y+0GXi+gEZxte4mLoZYBaSnEomN8xQfx2y5hVzb4EpJGlBk8bMN?=
 =?us-ascii?Q?Lyr5RO1LOz/G1T9Nk+HQ6CUqzyGYdiyrBT4qEk7GZ37ktk0fZ+XtK6k/q6Pv?=
 =?us-ascii?Q?o2gw6tICCIiL0YZGZ2SeA6BjwQcaI4hBQ7HQH9Ggmci5GPGCbTmgTtLkHWUS?=
 =?us-ascii?Q?+1InBWKN8Ey8cqlA33BN3fZmgirb/ZtINJbFL2AeakIQ4RYPqbNxWBl/rZb6?=
 =?us-ascii?Q?i3QG570UT3Ist8/V1fNnEk76o7ErirvtJF3GTpDNIA92uJEN8+0fHc3cEQDO?=
 =?us-ascii?Q?7Y9az/UonUJqSvs0zMwwHE2FpPjN25w4sSNsa1FpfMkHJasZGUxKZj+cvPl0?=
 =?us-ascii?Q?yQo1fqQ1VwaQ9XNdjmxixEXJ44Yn5WssR5BPsNmzPuRfWtodHyJrIAKy7TW6?=
 =?us-ascii?Q?ZdtNboXvPw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfce9a8a-0e71-48b5-c2ec-08de8029ba65
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 11:23:04.8345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: noXcVWQ9rGZMsKZnzUjssduZ1MuuCVjNOIrknV+uKKRoNGcos6hqPVpJ81AYB9XIeNaizueKCjSy/dGvN1d8+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7225
X-Mailman-Approved-At: Thu, 12 Mar 2026 13:47:21 +0100
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

- Move DMA software reset and pad calibration in xgmac_start() to occur
  after the PHY is initialized and connected.
- This ensures the PHY is ready before performing these operations,
  which is necessary for proper recovery after reboot.

This change fixes issues where the PHY did not recover from power-down
state after a Linux reboot, for the board using Micrel KSZ90x1 PHY.

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 drivers/net/dwc_eth_xgmac.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dwc_eth_xgmac.c b/drivers/net/dwc_eth_xgmac.c
index 458b87af7a2..2ab5ec5f0d9 100644
--- a/drivers/net/dwc_eth_xgmac.c
+++ b/drivers/net/dwc_eth_xgmac.c
@@ -497,20 +497,6 @@ static int xgmac_start(struct udevice *dev)
 
 	xgmac->reg_access_ok = true;
 
-	ret = wait_for_bit_le32(&xgmac->dma_regs->mode,
-				XGMAC_DMA_MODE_SWR, false,
-				xgmac->config->swr_wait, false);
-	if (ret) {
-		pr_err("%s XGMAC_DMA_MODE_SWR stuck: %d\n", dev->name, ret);
-		goto err_stop_resets;
-	}
-
-	ret = xgmac->config->ops->xgmac_calibrate_pads(dev);
-	if (ret < 0) {
-		pr_err("%s xgmac_calibrate_pads() failed: %d\n", dev->name, ret);
-		goto err_stop_resets;
-	}
-
 	/*
 	 * if PHY was already connected and configured,
 	 * don't need to reconnect/reconfigure again
@@ -559,6 +545,20 @@ static int xgmac_start(struct udevice *dev)
 		goto err_shutdown_phy;
 	}
 
+	ret = wait_for_bit_le32(&xgmac->dma_regs->mode,
+				XGMAC_DMA_MODE_SWR, false,
+				xgmac->config->swr_wait, false);
+	if (ret) {
+		pr_err("%s XGMAC_DMA_MODE_SWR stuck: %d\n", dev->name, ret);
+		goto err_stop_resets;
+	}
+
+	ret = xgmac->config->ops->xgmac_calibrate_pads(dev);
+	if (ret < 0) {
+		pr_err("%s xgmac_calibrate_pads() failed: %d\n", dev->name, ret);
+		goto err_stop_resets;
+	}
+
 	/* Configure MTL */
 
 	/* Enable Store and Forward mode for TX */
-- 
2.43.7

