Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C828CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 11:55:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3346082D32;
	Wed, 13 Aug 2025 13:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Nq7Wio0h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84569834E5; Wed, 13 Aug 2025 13:55:00 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2071b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::71b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E7DA82ADA
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 13:54:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrqRnIyKbvvs1bP075aONm1mp77mJNGZOJwN6wNYhSSEAIVhvseXiwcx/k48gy9O6Z6QVHamqxyPw8nxCUJpva3G6uuOc6I7Nq8UiUz3mcN9OmMaxz2kQGBNdNKIyku8RDOkxzdMrgyBU66GI+cbDRAtcwa1hQ382utIgZAtYK58AMNXcGsMeJYp+2ZHFMBI7nIOemAvedR6arrTmTNzTpEGMPpfodd7ptoNpBRICl3ug8QTSFLDklSf9uqbOATH/dKW/bC4R7OUIPav/ySmNdf1gPH4yTNoZbvBlKS+oyz4L5w0mQbqkL465UcmI8fk6bPXiFgUcJmO1Xr1AL8Ncg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oE8oqTFd1mrBcpfL5ELtKsFP0mSd7jG0xZjIk91xyYs=;
 b=rntEtNtS3nXrzbudLeqC1VbtCK5wHSmZtJBNany/D6f8TX1NeFFKe2U5SltOqbpJDesrG5ns58UpzvTCeIYFY5J7yIzImfQYPO8RTkiqLIa+fwWI93zn6l9wsqONxsuoWdkVoukcyMNutn2D68IH3UDsP/sTQkeVkyBdB3PFiijO86l3s5JfbxBKsZmSJcznPR5siebwzAECjG8MZugEWwqcHRC8shiJ84ieU3o8yvy13kXk2aEcfdD9vJDco+usdqTnhlrmpUdA1Fk2tQwhWjCejm+guvZRdgm0p80TL7qY5EOtV7s+eUlnabGN5SRvZ5nhRJvnR7Z8g9zZGOFflA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oE8oqTFd1mrBcpfL5ELtKsFP0mSd7jG0xZjIk91xyYs=;
 b=Nq7Wio0haZYnRSAXHc7HIol1wv+Hl4Q4aKSyHJSpFNK8GI5yjornFo60HPxhrQGA6olb1yVZ7A1b7iY+W+3lY96DH5Hoq8/n9cnlCzBqIRdAAmk6tC5Nl5XpE5N90mmH+sIvnYv2ClpHVEKtYhxsPvqbo4LtEEdcVwqEFjZwXiYNranl2iSsmaR8ROo1u8XiueEuL8R8/mso5cC1OuxwsrLNofxivhoc5pctvRwhXp+kApErIkNs2d5H7jaWepx4IUR2+fTmQWFAEUfT6YeK7nfeteByaqxSUUPx2P/e5adbSdAaxSLL4C5MeuoDrA2oFcYhlzvmPWAjqpeuXyLJPg==
Received: from AM8P189CA0022.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::27)
 by PA3P195MB2845.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:4d7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Wed, 13 Aug
 2025 11:54:57 +0000
Received: from AM2PEPF0001C710.eurprd05.prod.outlook.com
 (2603:10a6:20b:218:cafe::4f) by AM8P189CA0022.outlook.office365.com
 (2603:10a6:20b:218::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Wed,
 13 Aug 2025 11:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C710.mail.protection.outlook.com (10.167.16.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 11:54:57 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 13 Aug
 2025 13:54:55 +0200
Received: from lws-schwan.phytec.de (172.25.32.54) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 13 Aug
 2025 13:54:55 +0200
From: Martin Schwan <m.schwan@phytec.de>
Date: Wed, 13 Aug 2025 13:54:05 +0200
Subject: [PATCH 1/4] bootstd: rauc: Fix segfault when cleaning up slots
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250813-wip-bootmeth-rauc-priv-free-v1-1-1ef928169469@phytec.de>
References: <20250813-wip-bootmeth-rauc-priv-free-v1-0-1ef928169469@phytec.de>
In-Reply-To: <20250813-wip-bootmeth-rauc-priv-free-v1-0-1ef928169469@phytec.de>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Wadim Egorov <w.egorov@phytec.de>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.25.32.54]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C710:EE_|PA3P195MB2845:EE_
X-MS-Office365-Filtering-Correlation-Id: 365b3de0-df59-49af-a86d-08ddda60397d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3k4NmJYc0hyUmFoQlU3elR0YWUxdmtLcHNldGUrMXlQR1N5ZkhkM2JCaW5J?=
 =?utf-8?B?clZ0cVlqbk9CQWp1bm94d3piTkgyMkNGc1dYaitEUC9jNUYranp3TmxERkxl?=
 =?utf-8?B?a0F1QWpCVlNFRlNqa0RjQ0tUYWt6YnBsNGRpK1VqZE42M1Y2NHF1aFl4TjZZ?=
 =?utf-8?B?bTY4OTZRZDZNbXBwSFZ1WU53eWorY0dOeWdyL0NnMTdpUlNuMDhLeFM3YmFv?=
 =?utf-8?B?OTl5dEpyanovY2tLbnE0MmU2VHM3dk9uR0N2QzhKMVduNVJpMkNFSjdpUCt2?=
 =?utf-8?B?WUhoYk9Nb0FyQk5ja0VidDdHNEd4bUd3QmF1dGo1VHdVeHY2VEdnY25BMUJY?=
 =?utf-8?B?aXVwRDAvSlZsUGppRlZIUk5ZQWhFZ0hKUGRCSDUxQ2pJVnR3SmloZEJmeE1z?=
 =?utf-8?B?bnFEdGE4cGIySURYMUJrZ2w3MmVycS9xR3A3aEwwVkd6S0tUOTFxRkFkV0NN?=
 =?utf-8?B?eXdkYzNFYWVJempkNERJSVRhT3ZTTkNhTTJQbDAxNlB6ZkxpZG5kbFQxcEh3?=
 =?utf-8?B?cGRUNit1YVVWM1dxT3NFeEFiQnlxdlAwUzJZNUxHZTNRSjVZdGt3Y1VlcHU1?=
 =?utf-8?B?bmpzdWlLd2orc2drZFJpQ3lEVTFwNnY2b2w3VWdIWDRTZ1VqbVpYVkpqTnE1?=
 =?utf-8?B?YlhoQ1FZTnIzNHpSNmRwelI4ZmhoV05qWXNzRWd0aTRrMDcwdDJvVVkwM3Zv?=
 =?utf-8?B?WVE2Ly9pSm9YaGdiWTc5SnRJRVVXVndDbVVRYWphcitaVFl2bmZSZWZneEwx?=
 =?utf-8?B?Ykg4dnFsS2dVTHJlaVp5MXNpZ0Z1SVZJbFlqL2FCRE8xS3hxSURxMFJrYnlY?=
 =?utf-8?B?M0dlbzJ1UzBScXJHYS9aT3Jmb3hPSkRuRmZCZERoZFBacXNJcVZFRHhOeEl1?=
 =?utf-8?B?UXhzVzNCYno2U2RPYUFIVzFraCt6NFJkVHdTMC82S1JVSEE3VVZEbmQwdUx4?=
 =?utf-8?B?QUJrY20rK1NkWTNaaVZtakNuUGF0U0xtc2p5NHpBOVBQdDQ2L2hkWW96MHJN?=
 =?utf-8?B?WGtFYTlEY29XNDJCWllpSVJvbXlTbEgrMkI2a1oxR3JYRGZJNjRPcmxvQSs0?=
 =?utf-8?B?R1JWbm9taHZIUzlqNDhPRWhQbXI1SnU5Z25yck9kT0VmSUZ1ODdNT1haNXRW?=
 =?utf-8?B?dmtaUmZDWnhoaXphUmNwV1IzdDdKK000TWljNEovd1dxVnVCbDVCYURGREtL?=
 =?utf-8?B?YVlBSElJUm1aM05mUEcxZnFNN0ZMVDVna05IUzBKdi9FUnlCcUtQUHRteTRS?=
 =?utf-8?B?NzQ0MEF6eWNaTjk5eGhJblhNMlEvNlBuRGxFY0tZbXlEZW9aNmFrdkI2Ykx2?=
 =?utf-8?B?YnJ4NkZSbXRkU1YxYXl5S0lHeWJrYVhiU2NrNGxxQkVTc0RadTMySm1Ccy9T?=
 =?utf-8?B?RDlveitrY29Sa2hML0Z2bWZhNDNmbEErUGhPQVQvOHdnNWMyekI2M1FwY2xS?=
 =?utf-8?B?T1lHNURvY0xvL2hVM28zY3NNZ2drZW1BSXIrYjcyN3VDdFpRVnZmaE5sYkd1?=
 =?utf-8?B?Ym9jbVZLYTF0Uk1EZVFXUjBqS3dweXdvOERSZXN4eElsTlhvTndOTWxZMHV0?=
 =?utf-8?B?Q3ptOU9weEF6akxVNFF0eGhrMjNrdHkxQll0QzdxRytwcEFXT1IwS2V4VmM1?=
 =?utf-8?B?Vk1DR0pTSEZFUHJwdFFtRTlZTjEweUo2THY4a3hnTmZ5NXRLa29kQ1BNN05x?=
 =?utf-8?B?R1g2cUFJT1B5a3V0MmlwdlVLYkM1NHRMWkVVY2d6eDBNNHdzUlVjc2Zvbi9s?=
 =?utf-8?B?R2RBdDEvaExvRDAvbVJOTlJyVWtaOWZTNVhBcVBLRVozZklxanZ0cGZSV0o2?=
 =?utf-8?B?S0xrNmdUWVhZdk0ySUVqZkUyQSt2RmswYzl6MVVIYUVmRDA1K1c1OUI2NDlS?=
 =?utf-8?B?QlAzYVBiSFlXTThMa3VlaHFPWExVdDBKYXF3RWJwalVOTWw2Y0cxL3JRa3hx?=
 =?utf-8?B?T1c4Q2xFOTV2RUVXWmZFWk5OcUJkRTJZRGIzK3JtQ0FkeFNtVnhtenR6Sk5H?=
 =?utf-8?B?L2NpSDNja0JpUExtWkZTa3g3ZjdqeDArVDFLZTh5ZmpvcTViaDBhUGt6Y1lV?=
 =?utf-8?Q?CsnbxA?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 11:54:57.2296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 365b3de0-df59-49af-a86d-08ddda60397d
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C710.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3P195MB2845
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

Fix a segfault when cleaning up the slots from the private struct. This
fault was generated by accessing a member of a null pointer.

Signed-off-by: Martin Schwan <m.schwan@phytec.de>
---
 boot/bootmeth_rauc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index cc6180221ed90934801ebd801a7bd1b3fc889aec..a27c85c4ff07b88fd67d6a542c622840245dd397 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -187,7 +187,7 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
 
 	ret = distro_rauc_scan_parts(bflow);
 	if (ret < 0) {
-		for (i = 0; priv->slots[i]->name; i++) {
+		for (i = 0; priv->slots[i]; i++) {
 			free(priv->slots[i]->name);
 			free(priv->slots[i]);
 		}

-- 
2.50.1

