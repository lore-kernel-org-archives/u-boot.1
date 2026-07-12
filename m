Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FF8C43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 13:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 951B684A5D;
	Sun, 12 Jul 2026 15:09:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TY4ACNws";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4E9284A63; Sun, 12 Jul 2026 15:09:25 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDE6684940
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 15:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9TBTDcopB1yD/NBfopK8w79MJXtuON8MDVLZCG+ghuzmVE9uY1rmIisX9/KCESeRLKAO9WzcfuWNNSg/BI7wZ0urmDoy07SqyPtu5oW9ZL+tt3NR3LA1vQBcp/mtnYoVuozoJRRlv7SDUQ+R6NPZFMvU5A7l6AkaldPxhuj0dpwAo1ZdbS9DKermqw7Ol9v76J9KyR6IANqpLp7FBQa73ZhfX3hJqToLykURFpoaErSliEBUtMejm+WXrJUyNghdA/kLMphwuN1e8A5doCGnwcqjPtnocRzk8vHm2svO1hve9nlCA7BnEjDkcyqkP4NWSh8kHo23JnrOCwo7otfig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asieMkrPtB+EAi2toPhwjFlKOoyzRztD/53M7LGYRNo=;
 b=ZwOplFDh6d5aVB62SRJW7sZwo0XcZTqU7OfAjPzitPTWJ+oA7emWY5Wm4/1xlC7dfTGIQbFKG+Z0F6q0czmNjL3cHSpORHoS1kAL5e+GqKnlvTgi503iqjr21XCbScYcStFgnNnQdpXew09dJNmuSyZDMKxsVflGOurMJs1fEalwdVsC6CQjocXHluNdy+xQ5PPP0Gtfqn3ZNSQ9PzX8obwtGMnRFSTu+ze09nAk02S5QMWI/J/4lOcAERcCzwiSCY1YnvwNRbbcXIAcnalWXpqvKr5eRSTTsEy5mLEScfMNl3W69JzKOojWTewrcbQi11nZFysFGiQDliooauulww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asieMkrPtB+EAi2toPhwjFlKOoyzRztD/53M7LGYRNo=;
 b=TY4ACNws0uFIvqg0IAC9MqTF6A9qJdBJdoQ2Kn6SCwFidO2+68eFUEoRsdVGTuXGamMMoqYsrDEHIH69bEYp6Iv4gVhmx2XPkvqrhCtc0MARSJe9fCRs+0ZMKepr3EtUKTLBAhLko1KFXniwUHIcET70Q2bieTE09rAQivrOklQM/DtoL0And3nbIK1y5s62fE8qDzCBbz2256Yxcyvobm+T703AiwfLdP6JI1hDnw4+m4UVN25tbSSnVWD2rGC7ZbpQTM+4TJKY/Jo/NNLXCONc7DrzhUt3YE6dbZhkkIkg4EQiwHhTHfrvR9exNIbXyaDK+lpm17AQwCokpbaYLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GVXPR04MB10945.eurprd04.prod.outlook.com (2603:10a6:150:21e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Sun, 12 Jul
 2026 13:09:21 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0181.019; Sun, 12 Jul 2026
 13:09:21 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 12 Jul 2026 21:07:31 +0800
Subject: [PATCH 4/5] mmc: fix mmc_bwrite() ignoring host get_b_max() callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-mmc-fix-v1-4-99a1136bbe54@nxp.com>
References: <20260712-mmc-fix-v1-0-99a1136bbe54@nxp.com>
In-Reply-To: <20260712-mmc-fix-v1-0-99a1136bbe54@nxp.com>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Eran Moshe <emoshe@gsitechnology.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>, 
 Jimmy Durand Wesolowski <jimmy.wesolowski@mobileye.com>, 
 Iulian Banaga <iulianeugen.banaga@mobileye.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GVXPR04MB10945:EE_
X-MS-Office365-Filtering-Correlation-Id: be6f95a1-8d12-4762-0470-08dee016c9bc
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|1800799024|376014|366016|7416014|6133799003|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: dtvmajXNWbYX9YQPP1LFuhk/IEJnAEAktMhovQ+/WaN6KAqu7xIZIANo+WAZTDPTSKIrE44BVgacwvcjuZZvpTyMm6Dix9wUuhY2poE4QY1a052d+PhtfrfHUlp+YIL3hYPzL2+5r1Y5znnUS+XP2R3Xb3eEZDBLJ/kiUKxEafrj6GLeq4Oz/8ZTjLRgtv49DA4vl4COqeHUh1cviD9lD5u8VNyc/PdFAwDq1Vj9c3YynMOUNwH9jX9bAnG0VgeRnOAGVvw+SYM02THSXxOjsc96RvKjDvJnC4g3x0HhoM9evthRdQKOb3qKRa2+Bx/fSvhqBAnAaGz0z+/i0+kARKtTfrghsfZtVSbaCGXfu8EOSuabnq4oOLtwryWHOa/b5Bv+bleVziFt0h+6U/n1eSScgmVg9ELxw7mGKQHABP1lOKJdl8uFOeZ4meD++rw7g2iiLj6cNndbgZgSIKHIZjY3ilDDTnUsNjuse1noz1ejBDLDoQ5ru8wSMYvi8eh7k/oxseroeult9hAmw9sXtE20uQ7+Ok+YTl41kM+Vq9FJLX732fR9ecRh/rSQ65uWaKHls/cIi0H4gvEhBCmz2H34nx0b96dfcXSisIr9NcEzqI0M4wIjrRnYBKINvjWrA8iGy2ndhZ/2bdiMeZF1WmXFC/IjBxYhG7djQas9hPY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(366016)(7416014)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uy82QUJnL0k4clZ0bTQvMkkybHZKSGFHS05Qd3lHVHhKWlZrZitZbzNlMDZj?=
 =?utf-8?B?bWVHZkVwcTRZMElHb0hqdW51Unl6MnVucFZxVXZwRkhRWkVuRUJxVUdYNEhM?=
 =?utf-8?B?M1JVa2FTM3dWZEN3aWlCSHd1azBUS3o5K1JLQ3g0MXlBTDRFQ2VSUUFKcFln?=
 =?utf-8?B?MVlaanpvRndleDdNR2U1V0s4ZEJIM0pIcWZCdzNHWlhoMlc4dDRXNVJnMTJS?=
 =?utf-8?B?eUIwZURoNjhHNHJ3T0p3QkpFdWtSbXdxQllMempYcHFtb1VHc3lleThPdFJN?=
 =?utf-8?B?a3ZmTStDMk41Q2ZJWDJPazNhL3BhdTNxMGNTOEVvMGFMRDVnTWxxSE5vdzd6?=
 =?utf-8?B?NDQveFRKa0EwVU8yWCtSMVl6eHhqM2NJZGdMSzNSSm5FYkFPR3d2UHpnZGZr?=
 =?utf-8?B?alhYMDZJL0lJWWpGeG1jMzhYMWVQQTg0RkIvMVNNUTNLYldkRnRTMkx6WEtu?=
 =?utf-8?B?dHI3VThBUE9qbmhpVmpEVy9tLzcwbEpCMnAxbWw4c3lpbit4ZUNTRTVLTzJX?=
 =?utf-8?B?aGJvd2RBWFU4aEZMSlNScHg4bWh4T1ZTb21VUzdDb3M1OWQxbkVuemNHT3VN?=
 =?utf-8?B?cU82MUZlSEk1d0F6TWdxZy9YQmRWTnQwVzUxckZJMXlrem4vZXdVOHVzS0ZF?=
 =?utf-8?B?MWgvUVpqWGNxSEs1SEgwTWpOVXJweklZMTB5K3ZFM3F6YWo3L1c0R1hucG9S?=
 =?utf-8?B?SXJJa3JsWWw1MkhEb1NsVS9IWU5EeVFENkpBNm9JY0Q0UVhrdjFCc0k4cEcx?=
 =?utf-8?B?c0NicEYxLzUvOGkrZlJ3ekNzWElGV0FnTjZ1Qkx6SmZDMi8yajN2T09vaCtL?=
 =?utf-8?B?VC9mQzVUMTI4Tk1zZDVqRW1BNFFxSi9USVpGN2pPdE1vYUpxYUlyeTFBczlT?=
 =?utf-8?B?Y3RNSnozMHp2Wmo0Q2MzRGhubGpOZEkvQjBKRHRJL091OEYvQ0F0KzlTajZ3?=
 =?utf-8?B?MlRPMERtcmE5M1JSbDFxWjdPT2R5cjVibHozOENsT2lsenJRYXJoRWloZUVP?=
 =?utf-8?B?ckZuc0dVY1hBd21ybnc5REUvN2U0R0E2b0d5TmdRblhUTmd1YitYcjVrRDJJ?=
 =?utf-8?B?d2FtNHR2Um82VGF1aWU3OVhUZE1IZFlZOXQrdzh5MUxzT29aVldJTTkvVnlh?=
 =?utf-8?B?N2JMSWdWMkVwcUkxRlc2eEh4cU5tZGU5dlhhaHBMSDhqTGZCa1c2K0ZtL0k3?=
 =?utf-8?B?QUNvdndCejNQTGsya1BjYWhVOHFyN0o0cFNCMmFlZ3kySy9pa2JaU05RRm9T?=
 =?utf-8?B?TERFLzZMbTZtUXZrc0Z6SkNHcnVZM1NnOVF0L2syTjMxMEFrWkUyYkU0bENn?=
 =?utf-8?B?elBqNkdsQm5aSTNUWElYK3NLQVdXb3d3b3dRQmsvL0VXMUkzUGVsc0RYMFRC?=
 =?utf-8?B?NnErMmlPZ25HZHIvRERNSkdPVExTVDNMRTRDbU45Nzg1Z0wycFpSdDRON3Az?=
 =?utf-8?B?RytlYmhHMHR2d21rM3RSRFE4M1c2RFdRRFdsZnRCYXlBMkJtenRPZlVOUFlh?=
 =?utf-8?B?TVRMRGI0WGZKa1N6WWlMeTdJWE5TdldWaUt0bU56QWRZMEg0TUdTS0lkL0ll?=
 =?utf-8?B?cGNEWUR2b1VSMnpLS05mYkVCMEVKMFVKanBrNmFxVWdvZ3dmRVVSQ0U4T2Fj?=
 =?utf-8?B?QlF5YmN6M05USGhZNm5ySVd5aFV1NHNYOXpubjVmRUQ5TWVsajMrbE9mWmhM?=
 =?utf-8?B?S29kRUxPemJPd0RuZ2ZWQ0ZkRHFMUEsvMWR1WFlTRmlPbHVIeFNXa1Qwb2Jj?=
 =?utf-8?B?alRFOG1yVGFNYzI4R0ZidU5VTlI0Z3I3T0dqQTl0NDkvOFl2NkVQL0ZPOWR3?=
 =?utf-8?B?eHlRaWlvZEpqaW9aWGlBcmFxSytLenIvcW5GUXg2aXlhYjBuUGZleFVqQ0RR?=
 =?utf-8?B?WjY1blBFSFp3S3ZDaTV4TVlLdDk2Kzd6K1hDM2twWWwybldObU15ZjBrNmtp?=
 =?utf-8?B?dVBpN3ZXckRiVlFmUERUL2psUGxYU0xvM0VEVDlDMGxXOW9xd2RsNENBUjNY?=
 =?utf-8?B?NERWRmtXRzF3RnYvazlUalBpN0FpRm9WUkZtUjZaMmthL1FIc0NzaDIzUlNH?=
 =?utf-8?B?VjBDeGJUZi84VzBReEhGTVRTcDNEUk0zeThtZnJWUnkvVUxTNk1QOVZUUUlC?=
 =?utf-8?B?b2t6T29SdXhmTTZWWFdRVUQ3N0tSdyt5TFM1MUJFbm4yeEQ3L0dxMEp3U2tR?=
 =?utf-8?B?THBZSzdUcnJxbGlwc2lNb09UYTMwaWhkMVlTcnFoR1FsbXdiTEc1ci9CSkxa?=
 =?utf-8?B?MGx1OWExd21KRFEvak9NM1V5cEgvVlRHU1dSNjhKVGZzcnh5b1lwV29SbUha?=
 =?utf-8?B?emgzWXA3ODlEZ0hHODBlMmVMTXFobi9raTJ5YlZxRmFLKy9tL3RVbk9DT0o5?=
 =?utf-8?Q?1b5lbodFuKny3sJZLouBn/L5FMFvgRvWm8WrD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6f95a1-8d12-4762-0470-08dee016c9bc
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2026 13:09:21.4003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9phDD4yWCBM0DYcTzbulWoI3UJJUq9MjbMtLPRNtyTZyOd45Jq5Jn8GbKTsPcoJMin4I27Lihgu9LKBJzplrzHfU2unGjbrOWDsb4oov5JlaD0/NF7hJKHopVOiJoZQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10945
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

From: Peng Fan <peng.fan@nxp.com>

mmc_bwrite() uses mmc->cfg->b_max directly to limit per-transfer block
count. The read path (mmc_bread()) correctly calls mmc_get_b_max()
which dispatches to the host driver get_b_max() callback. This callback
allows host drivers to enforce DMA boundary constraints based on the
buffer address.

Fix mmc_bwrite() to use mmc_get_b_max() to match the read path. This
requires removing the static qualifier from the non-DM mmc_get_b_max()
and adding its declaration to mmc_private.h.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/mmc.c         | 2 +-
 drivers/mmc/mmc_private.h | 4 ++++
 drivers/mmc/mmc_write.c   | 6 ++++--
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index ef7defcde71..5fd12d21f92 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -490,7 +490,7 @@ static int mmc_read_blocks(struct mmc *mmc, void *dst, lbaint_t start,
 }
 
 #if !CONFIG_IS_ENABLED(DM_MMC)
-static int mmc_get_b_max(struct mmc *mmc, void *dst, lbaint_t blkcnt)
+int mmc_get_b_max(struct mmc *mmc, void *dst, lbaint_t blkcnt)
 {
 	if (mmc->cfg->ops->get_b_max)
 		return mmc->cfg->ops->get_b_max(mmc, dst, blkcnt);
diff --git a/drivers/mmc/mmc_private.h b/drivers/mmc/mmc_private.h
index fc45f017e5d..24e68ceb5e6 100644
--- a/drivers/mmc/mmc_private.h
+++ b/drivers/mmc/mmc_private.h
@@ -17,6 +17,10 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout);
 
 int mmc_set_blocklen(struct mmc *mmc, int len);
 
+#if !CONFIG_IS_ENABLED(DM_MMC)
+int mmc_get_b_max(struct mmc *mmc, void *dst, lbaint_t blkcnt);
+#endif
+
 #if CONFIG_IS_ENABLED(BLK)
 ulong mmc_bread(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
 		void *dst);
diff --git a/drivers/mmc/mmc_write.c b/drivers/mmc/mmc_write.c
index 928c05872ca..9cf07b4ad1f 100644
--- a/drivers/mmc/mmc_write.c
+++ b/drivers/mmc/mmc_write.c
@@ -228,6 +228,7 @@ ulong mmc_bwrite(struct blk_desc *block_dev, lbaint_t start, lbaint_t blkcnt,
 	int dev_num = block_dev->devnum;
 	lbaint_t cur, blocks_todo = blkcnt;
 	int err;
+	uint b_max;
 
 	struct mmc *mmc = find_mmc_device(dev_num);
 	if (!mmc)
@@ -240,9 +241,10 @@ ulong mmc_bwrite(struct blk_desc *block_dev, lbaint_t start, lbaint_t blkcnt,
 	if (mmc_set_blocklen(mmc, mmc->write_bl_len))
 		return 0;
 
+	b_max = mmc_get_b_max(mmc, (void *)src, blkcnt);
+
 	do {
-		cur = (blocks_todo > mmc->cfg->b_max) ?
-			mmc->cfg->b_max : blocks_todo;
+		cur = (blocks_todo > b_max) ? b_max : blocks_todo;
 		if (mmc_write_blocks(mmc, start, cur, src) != cur)
 			return 0;
 		blocks_todo -= cur;

-- 
2.51.0

