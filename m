Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2B8CD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 06:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93926846CE;
	Tue, 26 May 2026 08:08:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NRDUdbOx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1974A846E2; Tue, 26 May 2026 08:08:44 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36BE984671
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:08:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJhwTipxPDCKRght+QxTSNr+RST8NVao4QcKx9WEIvZ8cfj008ZjVv1buKkZ6myhjPWgfSxMA7Nzk46BtDc3/MLLU6HmuJ8nPH5hTGPEvOpgZ8PVGaFKnY1Tn5DFJ+osf9wshOAYjrQxlwtLjeZEKmzOUykAiEbe+i0zmw+znVSg1HzRUd1kJBcAREWW+goRZm2kS7df+vs1Hl6LsC0RUyTC8nXoJFm49suJNeOpfsv4yF6URSG+MZnX7IOJoAfk4t1WX246MVJX4lN0KjKAAiN2KeWv6MeY32BaqFEKMB3wTHMmNsxa0dfzY7lYiYg572VzTGLTV4ffpYBeqr401A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPRDxXvYZmvqevRNTWqDzDgneoIdEuGjm8ARakieZZM=;
 b=LgvkF3st1fd0hIm9HA987wcLGNo9uBs/RBk80FU+X7tNhJk6fj6ZteNQH/tekEvZCYPWd99Bsrx5clKq2O22zULIxPZSytqAI35Yy5dizHC+q9esKCN3r3mpXn6rZc4cvG9SpVCRlyNDLj6VyQ1F5tNI7cgqgZH7x5tyNhiWhSDVoz+NDtREf2RXmi7y0MdOFrSfAz64FlSJ3DF/52L/3FNjvmw2MibkIXGHLqTGZfTO8T8i6mtE7S59Wu+O6lGejCr398st1ESshf/hKqM4n4ZTTIESrfuBmc4wpBZHpIGbWvrc0cjvQdrtRaGSPjTrMeHIe7BMyENCs4KDi9a5CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPRDxXvYZmvqevRNTWqDzDgneoIdEuGjm8ARakieZZM=;
 b=NRDUdbOx3rM72Hag0JhNI/nt/b+pusOXvRiBVBhwNDxJwSBz+PPG1bwLve0vDwML04RbT7obaV5uaOm0kkHNs4eqN3HZ2mWDBs/dKsYlcP/fEelH3H49Yj1iNnNRHYGCkj3yStELNIl9HfrcRjDe9QbplbhKqU31MlzBkc4GUfjhMAuWNY1kYzGOAC826I+Chs0ZF6Sn6fzhXwHHs1JnA9O+Sl3xgN9wCneynXk7Zgy9hTazyDNcJjv3o+yecpJLuhVz47+3OtBjltQVtCuMs3ComsYt8g5+AuUcO8iwIsmVJmCI2pn0zHER4HzyCKnayddkdOc0EWNmNtfvBoshhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA1PR04MB10098.eurprd04.prod.outlook.com (2603:10a6:102:45b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 06:08:40 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 06:08:40 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 26 May 2026 15:25:13 +0800
Subject: [PATCH 4/6] net: dc2114x: Use dev_remap_addr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-devfdt-net-v1-4-be3597b85b5e@nxp.com>
References: <20260526-devfdt-net-v1-0-be3597b85b5e@nxp.com>
In-Reply-To: <20260526-devfdt-net-v1-0-be3597b85b5e@nxp.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5P287CA0049.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA1PR04MB10098:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc33603-3a91-45e4-505f-08debaed3ba3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|1800799024|52116014|7416014|18002099003|56012099003|22082099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: kZtC3T/fy7/bwmYEEOKPE+K8va2arS9ItY98nqxK+dMYjpmAlQMhQJFsJIZAKlTrsS/Nb2LvA23mPs7rt5aq6iGKkfxyan9v6J9z8VS/ZPQCcz655P4/qPAkdsCq+HnvsmSfRA+tT/vw5gLE7B6QZepWOr1Q0P77pX1qkjudKMrGecDy59q0voA2c0W+6UFUMaYtNTrQxKc4T9D3or1n5++r4TNhnhlQNPUKN4ukMBw2gDt7rc7+ONY1DICGRKSriyLjfc++LwUv7WseXSY6PaggMbV8n3bivZcHKgc2V9m4689Y2h3hRNF7hYLmUmcO2AyJGq6t//C8NWubO1EOmCb6f3BXMLCUmAXVuJ+5+pO2UYG+4hpUYCIHY3jtbiKMqJSWA1EfuAwdoLc9oyBisxERAR6i2cDK8Re6yIcanBnAKvX3uggNvE6ZyhziKoAatMbtQSoFxLmNyZUfEBR/L4Z/vcQxa4tKdu9pNaSr+dpujdxsHMavXsZzJvLY0gFc4CtF0Y8lDwTmlPlxnmuwJNjtDSpDQOGBClZQm3R1Nl8ckcUt1ojuumw/f2VzHf1E5GE7fWd5uj3PxZy7nWHtGlTmT9mC0gnzaOh6IINO5Zik6fAHpoVJmdY+IzJkYqNA2hOQ+W6busTLmPMCwPPFsfwJT1vN1GHcSBg5/xUD0NyuRSbguJIwP0ss0VQ5y7NG5lpg+cPKW/r9fdhUiWHz4Nikl88BAZc9mTySRw38Qs/Ah/VhRcMkj5JB05uCFRID
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(52116014)(7416014)(18002099003)(56012099003)(22082099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blpvR0pFR0hPempzQVNjRm9rcERZRFcvSk55OHJHV21RNlU3S0NWK1hDMjE4?=
 =?utf-8?B?cW1rcC9EcFBhbmxBdVo4RWlVOFRGOHpZeEV4QTErODVyRWJERlNobDNicWFK?=
 =?utf-8?B?dmo0b1N1RWExYzlRdExuaVFCdDZWT01HOXlHVHZ6WjRZZ0FRYzdoTHVnNFpN?=
 =?utf-8?B?LzdWM2wxWEpQN0Y5S1dXekZ3L1dGQ0FZd3dwY1BYdk5jRmVaWFRpcmt1eUsy?=
 =?utf-8?B?OGFFbkdsYVlTdnljMFJ5V0pnN25EZWJXTVc4OTJXVnB0VlJvUEhlYVRjTU5D?=
 =?utf-8?B?U2ZxV2Uwdis5Z2xQN1lqVkNwM0ROOVRvWHZIeExibU9tSDZzTllLZDdPeXFG?=
 =?utf-8?B?RUlhdDJJUDNXNjRUZmhCOGZZRGEzQkcraTFyK2RmdXdqWkEwbE9lNE5CNHh5?=
 =?utf-8?B?VDIzTlpHTE8rUlRKUTRhMEY3NUt5bk9CY214MCtZclJJaS94cUEwUU00U243?=
 =?utf-8?B?c3lMcFhZUkRvbXZWUHhzbnZhemhndlBCSFFULzZ0WkdzaTAvU3dmWFFheE5y?=
 =?utf-8?B?ZXhmTkFFUk5vL041Q3h4bjl6eHNxd1A2UHJ4SVBqV29CakZSems1WE5sd0ZD?=
 =?utf-8?B?YnVoamsvRFZhWThrY2t0dmw1RFNKYy9KMkM1MVlHVjV3Ums4MEFQdUVkczFS?=
 =?utf-8?B?OW5CTmlicnpOL0NIc0c5ZjBjblBLODZ2M0oySVhoWkhBS29ESWkrYnpjY0dI?=
 =?utf-8?B?QlF2SGk4YlFLVmtObDNLMDVvRzllamU1cXFSd0p2eWp4YTh4ZmdPVE1HOTAz?=
 =?utf-8?B?QUtqN3hFKzExR3hRWlZHd0ViNk0xTW9iY3E3WXZFbmN4alg5N0E5SUFRcmth?=
 =?utf-8?B?RnV3VzQ3K2R6eHZVMDJsekZUbGpTdkZYUms3ekc0dnVkNEJXak1vTjkrZ0wy?=
 =?utf-8?B?NjlaYjJaa3hMSnBtZ3diWU1KeUI2SDNEMHFFQkxkcUw1K2hYeUwrRCt2ckxt?=
 =?utf-8?B?b0R0WCtQaTA5c1oyQUhJdG9NbmxwTVhTeTJIbUJocHJQNFI0VXZnd0gyNHJG?=
 =?utf-8?B?bE9UemNWOGEyOGVkUmFQU1liMGs3b0Z4cmc5aGExbC9OblVEdlVINUNJM0ht?=
 =?utf-8?B?NGlMVDlRanQ1MkgyS1pJZXJENlh6UzU5Z1RjS0RqUHo0QzNtc2JnL2x4dEIx?=
 =?utf-8?B?NHhLaUVWdGJwMVNpZkl5U0xiZ3Zkc1NqWEk2cFpET1kwRytsM3VsN1JFNmF4?=
 =?utf-8?B?M3FGUnh6OVhzWEtQT0VMYVUrdmI4aUZSa0luNjB1aGhNRVFzNVgvdFdRNTVB?=
 =?utf-8?B?ZzdSWW1GZnI2UWdWMHd5NmN6eUFsZzBUd0JNc0NmSlZOR2FIWXR0NUEzckJj?=
 =?utf-8?B?RE14SEgwOGV6cjk1TXBCa1B6Zmk1MG9Ud3FiYmxmbHA1VkVXbzVLUE5CRVRR?=
 =?utf-8?B?YjF3bG5hN3lpbFpFSmpJTHB1UEFIdS84N2FDV2YycWJGUnJOdVM0VTduRmFU?=
 =?utf-8?B?MDlHVldXVTJ4TVFFbm1GeFdBemJIWUZrMUhWRkpHczVoblUyVS9ZM3hDbHhU?=
 =?utf-8?B?ZFFFa3RueEsremtqeHJhYm0xVGNFc3Vnc0c3RGFtODgwbU8xUEhmc1BJVmxy?=
 =?utf-8?B?eEhhYWZXTG1vbGVRV01oOHBpREdtQnZQUkVzTi9IOWxuaUp2c0dDNk5Jd3U4?=
 =?utf-8?B?STduakl1R0k1U0RXc05wWmxtOFFiWXFJanVSWXVrYi9MVGhjeGg1VnJEOEov?=
 =?utf-8?B?U3M5VmlGWXNiSWRLR0VERGV5dENrZFZVTUVHVXFHTVBGVmk0WWllcXhsRzVE?=
 =?utf-8?B?S0w5YWMySGdPckhRa3g3a0wzeXE1NEhxTkxBNjNSOS84QUN2aUlrMFAzNjZQ?=
 =?utf-8?B?SmJJclJPN3ozWHFsNDJGT0s3RWNUTmp6WFN1WXhLcUMvaHBtKzZIMXptOGRQ?=
 =?utf-8?B?R2I2TjM1T0Y0cjBJalJ0K2l5Z3pjMDNoVit6MGxyWUs5ODdJQlRkQkxTQ1Er?=
 =?utf-8?B?SlVwbGR3TkJLck5vRWEwNHJnSk5wM1A0NEFTUGRUaHQwVS9uNUMxbWdKNXF2?=
 =?utf-8?B?MDdsMkJqaUYyOWJ0MVI0akk4Yy9VU05BSVNkWnZjck9xeTBaZDAyKy82cXFC?=
 =?utf-8?B?d3pmRER4b21maHdDcG5vRDdubnRYQUZ1OU1aandjTzRMeXlBbWNDa0UrN0xD?=
 =?utf-8?B?NkxKRDdjRGl3b1JTQkV1Um0rNzZTd0tNNExoMW1odVhiTnlWYjc0TVdtY1k5?=
 =?utf-8?B?ZkZHTWZ5dUhmK2xMWERBNzJkVUF5NHVYWisxVldtRXFHZnVhaHlMRGZnVzR4?=
 =?utf-8?B?TW51ZUh3VWVhNW9jSUdIMDFJb0NCKzJ0VEtpL2RBQ09TdVdIb1gvWjRTVnRm?=
 =?utf-8?B?K3J0ckpTTGkxTzNncEdkQlRqTTQ1NGhrdkVNTFZWVlkwQ1ZhbnJSQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc33603-3a91-45e4-505f-08debaed3ba3
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:08:40.5034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akenXrQ9YCTE5EA7StDHAYHkVDW3tRaqFvoUH5Hvn7GuNrpcZfVyLJT2mQpqjPkknsnAFNylGSb2Y8GkfsTROg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10098
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

Use dev_remap_addr() to simplify code.

dev_remap_addr() does same thing as dev_read_addr() + map_physmem(). And
it supports both live device tree and flat DT backends, avoiding direct
dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/net/dc2114x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dc2114x.c b/drivers/net/dc2114x.c
index 8fa549280aa..2a21eceac57 100644
--- a/drivers/net/dc2114x.c
+++ b/drivers/net/dc2114x.c
@@ -653,7 +653,7 @@ static int dc2114x_of_to_plat(struct udevice *dev)
 	struct eth_pdata *plat = dev_get_plat(dev);
 	struct dc2114x_priv *priv = dev_get_priv(dev);
 
-	plat->iobase = (phys_addr_t)map_physmem((phys_addr_t)devfdt_get_addr(dev), 0, MAP_NOCACHE);
+	plat->iobase = (phys_addr_t)dev_remap_addr(dev);
 	priv->iobase = (void *)plat->iobase;
 
 	return 0;

-- 
2.51.0

