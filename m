Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370D8CD5BAB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 01:54:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B05CA846D1;
	Mon, 25 May 2026 03:54:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TmpvqAjK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8313846D3; Mon, 25 May 2026 03:54:08 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5FA8846CA
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 03:54:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUXIBRMNIzlt7dY6+5hqlGXZgbQOwSs5MOwGrhY4Vwd2mmTBhc7V5Z4wIBuYnxUF+eYBHirZtSWF1n8wF2PbMFJuYHdXAWIgM6NNgg9CgPbDfiGGwRdLSOxUKpjZCfpv1BuYiO/ygGYFomxp+i7UZIF8LYf7UnNDGfoK9uUr5zHtnzJGa/WXk2SoU5gnq1HdM1UiX7NPJlMs06Sl4ULWoCLMtmNdpJaclvfon5J1ero7ncSvEczjRMiwe2M+eAnU/mRBJuU7W/HPZElte+XdfaqB4FDz+0qcRUwF/NndYXOyF3ZaZsMvH3pEd/k2Ic+RGTWsxSm3jBKwJxxnZNF3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6MZO9Gal57eVA0l3VdnoAHwFkKRzLt9K0JXGYrmYxk=;
 b=HGOO5sD3vNu5kh2Owzw4nqm3SByE+UUX6pHvUOf+0QL8J9loeRpBFyzPOZsJ2jS1KkmFKjx+Jz5qvZmS+vTHzICR4WMhjCdh1fciy1uDzjuG7CuN9C3gjrCMOmVbaYhbm1siUsKxpWEFaqOwOAR9g/7WBRtujQ3P0vUEYLHVIvOUn26LpBvUFFwe64U+am1VAlNOSRLnYJrqAQGFEfDS/eecZ4EgTBJa6I1x6+Ww95ydCu8Li+v04Wa/vJ2o22k923vkSPeavx28bv5YwHqbWS25B/W+x6ygPlKcFrG2hCUZJf+RUUjOs0pJsKUXhtaNgLa2zxiREiX/Xbh0mF6HpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6MZO9Gal57eVA0l3VdnoAHwFkKRzLt9K0JXGYrmYxk=;
 b=TmpvqAjKuIoUmOwVISQmXwR7XCAOSI5n05ng2IORqwiSTmpcuh1zNBW5vM4ZMfun3S8gP7q6k9nBddpXzTANYQjdj9ooa2zipZLfbf0MV3FJYojxMIMu2KUfMvlMpVKbSEVruJ/KvJjArFPs1p5aBw7nXpAEANlto3HeGW/VqunVMVTVyTbPctA6ynvIkZVaAs4Fi7waIyah9j3pashkl0eabt+xc0EoROdEG9zJuXU2qm7Sn6Wb6iCpRY0mKVKM0DoiGH1b/lift1E59Y7kahAWsJjBjsb5phcxguDAaASOEVVCnU8iazFr+e05eREzpZxDyKX8Xow9Dbqr3A4ufw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA1PR04MB10466.eurprd04.prod.outlook.com (2603:10a6:102:450::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 01:54:01 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 01:54:01 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 25 May 2026 11:10:21 +0800
Subject: [PATCH 4/5] clk: hsdk-cgu: Use dev_read_addr_index_ptr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-devfdt-clk-v1-4-f0dee4083e82@nxp.com>
References: <20260525-devfdt-clk-v1-0-f0dee4083e82@nxp.com>
In-Reply-To: <20260525-devfdt-clk-v1-0-f0dee4083e82@nxp.com>
To: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, uboot-snps-arc@synopsys.com
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 Romain Sioen <romain.sioen@microchip.com>, 
 Ryan Wanner <Ryan.Wanner@microchip.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA1PR04MB10466:EE_
X-MS-Office365-Filtering-Correlation-Id: 033769d4-e6a7-4517-85cb-08deba007e68
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|18002099003|22082099003|56012099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: exujoUHUP4rqARilbZd42JNMqK/t+qe9ojwYMZrHuSor10VP+23F7dcOcHoK/WkP1ImA+lcf5ugA8pS/a2F+cJfMWzGSV0lEV8DTkyrFg87lJS9fTUzTL/bUZdszWTCgodPzzIiOSNJG6BrNCHX0fU84M89NsAVUbC/FkRwXWanLGJCP38KrRobPyGkkWpJvB6u8HxqnqIth4cDOlCEKmmU9Uwqifhe32M7kfPFl6/E7wjSW37fas1FSbqKrAG8Wa24fk2ia8yOucmaC9dK7Xf8zJw6LJr1O35HG2wbNcNhMXLGFzfX1jEIpsc1UOHLR2gTb4p4fa+PzUm1t9MTvPb+Ng1jYnX9HcRRbBSJptrfmiMWpiPgwJSPNqz9KhTBzYwnbLR9EnxV/oJsapKl84O6PVQKFFxJWGXWeY6CZSIvVx+Ul9DFsz1y6b+SGgtrOQCQYGfCiONV1Cgi3UiCVyixYEmeDPIF29lZxypUbTpYhlRPVVlPDRqdrOY6/vKs9zbugPLwK3teH/q1vAuGNOiCZAlfpchXL/YmgK1BXmIZVrK2NJZHJsx00xzBnI3nY7IAZKi32I+dU9yMV9NhlwaxrFVca0ogQvMQL54QZmi1Qw4izvbUdPPu/etf2NVv/FZKJIWYi23dgeXXw1Hr1xtwKAi3SzlXuEc7LGY97og6snpSvzpLmVliO6CmPdM6hYizO3UmbUaHYudxBjq/5PDhW+ptVb8ndlt87SiJ/BvwvTJdrhsEp4iFYz8Hm92Kh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(18002099003)(22082099003)(56012099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWozOWdrUXlKWHg4ckwvZWhyRUp5K2xhM0JaRTlmUXEyR1RMdFdESmZIL3RS?=
 =?utf-8?B?ZHhYblNiTEdXejdneGp0QnFMelRzOVA0cTl4ZUlEczRnaTRRQzJvcDF2K29j?=
 =?utf-8?B?cnJXWXlmM0d5M09vdzRBRDl4a0hhMGlCSjErYXlRVWZCYUN1WTk2aWhyY0dy?=
 =?utf-8?B?SStqQ3U3UlA0TDB0dExqaUthME56cHhDMHFXdzN0c1NYNi9pUlRjQm9ldHVD?=
 =?utf-8?B?L1hqWTdTS1NrODB2Q1JWdVNHYnlqcFMydG41RnpnTnJsSGs5TDFPM1hmOGN0?=
 =?utf-8?B?UmRDNjAwMmUzS3BTSUlQbWVvM3NnZXRSdWtLWUE4aVJ2Qk9IdDJLRHJqT3k4?=
 =?utf-8?B?NjcxUUN2c2VEOFFTTHR3aGxMVzIvU3lSL0Jlc1Q4dU0vZGZOZS9BTWpNLzQr?=
 =?utf-8?B?RzYvcUdOWnVOL005MkNMckxpeG5vck83enVKUjNVRXRnQVRKL0hPcVVtRkRG?=
 =?utf-8?B?T1BNVDFBdWtSUFkyd045bXdGSUc4UDQwNm95TDB4blphb2srZjgwUWhCNHFS?=
 =?utf-8?B?VEZMS0RzanBWZ3k2Z0IrZHhCc1g2WHBFeFJraVpIU3piRkM2T3o5NHdTZ25y?=
 =?utf-8?B?Q1hNWFJySlREZTJTTlQ1TlBJSnd0RlJWbzRGY0JVNlZlSHU2U3JmZmxWMGRk?=
 =?utf-8?B?WTZhbkJVakdaSUFTak5nd2pIOFc5UlJtbUEvRU9VdDlqL29xSlRVaFZHcmhw?=
 =?utf-8?B?VWFNRWRGZXZYWWtvajdtZDJ2VmVpajR0WDIySmgvaTlMcFlibDJyaERRamhh?=
 =?utf-8?B?NmExenJYZXcvLysxUG1ZcVVLNlJ1NG05RVZkNlZuVFl1Wlc5dnhsbXBwbEM3?=
 =?utf-8?B?eTNDeGhBNWR3UTJuN240V0cxUlllT2RIZXFmc0I4WkE2NHpZV29OZjJ0cTBo?=
 =?utf-8?B?V3U3TjI5Mm1uMk1nb0puVDc5MDkyTFNuZ2xETFpnQlNHaVUzZkJUTUkyM3dr?=
 =?utf-8?B?N0t2VFlpczFBUW9CbXAwdlh3UFpuRkFjbTNJN1QwWWtVbXVZRWRHMjRQekJH?=
 =?utf-8?B?bTlhYlZyVkJab2g0dy9uMi9ZUDRURGpWY2tWdmhSdWU3OU1WaWticWJGeUZZ?=
 =?utf-8?B?V09tMHA1U1hTaVZuWVJNUDhIaDB4enpVR3gvS0dRVDcyRVlUTHZiSmxLWEk2?=
 =?utf-8?B?MDBFMmlVSDlXb2RvMUdIcFZiaUErZXQyckdOdmdZS1VHRmU3b3JIY2pHblBm?=
 =?utf-8?B?TWM2QmJlRkVBVHN1Qko4ZmlQRUovUzRoTnlaS29vMHhDaTBFWS80ZHFxSjFO?=
 =?utf-8?B?ZTdGNjQ4TkxvbE10ZDk3UUlTK012TzJQTXVaL1JVK3Rtc3o4S1BPSjFsTWZk?=
 =?utf-8?B?bWhVTGI4V3dzSkJSOHRPUDVZQ1VUS3k3eVlrT2xJWnJqdHZDaXBrenhJVksx?=
 =?utf-8?B?d2JnaVV2WEJiYTZxaUVNaTIrQk9yMHkwRExCM0ttNUdUL1BqOVhSd3hpU0Zw?=
 =?utf-8?B?MXdBakZZK1BwYnZVeUVlNkNHK1FsTHZGRjc0NmhKZzhXMkdnVzNxVzhqNVp5?=
 =?utf-8?B?alh6bUFTRytTTEo1OUxuY3QzYitnMmZpN09xajhHZHNvSU5Wdm5UeDlXN3Vh?=
 =?utf-8?B?aGJpR0VldDBHa3FreldpdXlqUzQ3QmNxMUVyUTZZdnlZaytxSEtST1J6QlFC?=
 =?utf-8?B?RnZPaTU1b2JqbFpKanV1TmI4UzFNVzBhYXdtUEEvYnVCSWloUVhVQVZwdi9C?=
 =?utf-8?B?cFYzU2hmazdvd3dYNFBqbVJlM2tlY0hIV0krOGlXRHRHbUdKMGtGWnZUc3pR?=
 =?utf-8?B?THJIQmtSa3NFWGU1QUpSMVRUSFpLaWU2QkJmV3o1eDcxWDNrbWtWS0RVMjcr?=
 =?utf-8?B?TFM0c1JLNDJ3L0YrcXdTV2pYa0F0endKU0hHSmh2TTdJTGpWUVpNZk9lYXNS?=
 =?utf-8?B?RktVMi9nUWFtdGw2RUZFYUUzUi9wQkZvS0xuZy9hZHlBUjBPQ1pLc2krOEZ0?=
 =?utf-8?B?S2V5M0xFOUJUa2ZyMXAramlBYytmZnF5aGUzdW9UaElyZjlYeWN5VFQrbVBa?=
 =?utf-8?B?UVR0VUFOcHExT2g1Y2s5VW1XSVJxc0ZCRkY1L0RWS1gwbWJjZmlqMVpGbjA1?=
 =?utf-8?B?OW9WVGxtYS9kdWpoSmQ2SVdDZExiZ25QVmV3UmxmTGthYXNUNEp5RmJsa2or?=
 =?utf-8?B?ZUhzQ3d1TUpYTllxSmVQczQ5dFF0MDAyN2JsV2UwME80bEx6WnVWRWxhQWZF?=
 =?utf-8?B?ODFDVzRVaHJRUC9sb0hIeElMRWMwbGFiUGczc1F6WG80T0QwVE9aQ2NJc0s0?=
 =?utf-8?B?TUZ1OVFoSGc2bUc2dVRpc2RhcWQ4cjJNL2lFdm9LZEYzUU14eHJNak4wdEpy?=
 =?utf-8?B?MVk5RTNxdGpUQnp3Uk1jd0xaOFl1M2M5cjYzS09Qa3hFdng5ZWZ4Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033769d4-e6a7-4517-85cb-08deba007e68
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 01:54:01.7385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bt3oPbqNcrkQQazC2oi37V4JmVmSP79DhxMAoIMc6hqTdk/FexepssD7BcjVM4S0tfOx9+HAeOhnMQ4ldqZDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10466
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

Replace devfdt_get_addr_index_ptr() with dev_read_addr_index_ptr() when
retrieving the register base address.

dev_read_addr_index_ptr() supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-hsdk-cgu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-hsdk-cgu.c b/drivers/clk/clk-hsdk-cgu.c
index 53655059279..dbc926a4391 100644
--- a/drivers/clk/clk-hsdk-cgu.c
+++ b/drivers/clk/clk-hsdk-cgu.c
@@ -753,11 +753,11 @@ static int hsdk_cgu_clk_probe(struct udevice *dev)
 	else
 		hsdk_clk->map = hsdk_4xd_clk_map;
 
-	hsdk_clk->cgu_regs = devfdt_get_addr_index_ptr(dev, 0);
+	hsdk_clk->cgu_regs = dev_read_addr_index_ptr(dev, 0);
 	if (!hsdk_clk->cgu_regs)
 		return -EINVAL;
 
-	hsdk_clk->creg_regs = devfdt_get_addr_index_ptr(dev, 1);
+	hsdk_clk->creg_regs = dev_read_addr_index_ptr(dev, 1);
 	if (!hsdk_clk->creg_regs)
 		return -EINVAL;
 

-- 
2.51.0

