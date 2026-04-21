Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04255F8FA66
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:25:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09C19842A4;
	Tue, 21 Apr 2026 14:25:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iox9tNG2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1CE984258; Tue, 21 Apr 2026 14:25:36 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD132805D7
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umFYIfAPvCowQEhI9GTSATKPLTST9O1LG+4+4eP3Y357Um1pp6BCe8LSAWODbQDXpZwi4P634ga6eZ3Q8AQiv/kOpGXsF/tWA/u0etI1IsFT8jQNxK+t4LpqSBNVJSMLv9pfjxsLYxHupZTX4R72ZmaRItmfnMzChSlGzzTroG0cc+D8PkhxY7u6w5hIVM+uoBNUt/Hy2r4tv4PwE+YrhaY/td65Gurhu73N0wG3qZzJ8YPtfXLzh6dlFnfMaB95HaHmq9EvZ87rLZHlaZaF/vEWF4+qI9q4BVTbEGM3F9K5NMobssjTejQJC2o/YC5gGibpK+9rKgA8MwUeX1hNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOQpEiqaKjQUqwxvCwlnwvadEho3TteT5aTpV4tUF3M=;
 b=jRj020ymKB2mPVdx18ZDo+VhblDL1upt9FdFvs9o4Fu26lxDRtduZJc54D5DIWKeaL/hl0QlyJ4+qo33o5WjVwKYMyLIHfq9QCV2SzzLekUHy4btgLI6QhzPn7yFTiIzDTuvz/m03/IyrUXnVoSue9YYcl0YjJG+pHDR7/FBQTlFcRdnJ3coycz3XGjk8IAh1gkWJghDnY+BkON0GTfbw7wNEBoxxYvQRHKwNz/b5tgiVmw8D0Xd2G9qDQG7PW36K+0TBnIMqxsQKrwe9rDgK2j/fV69i/cZeopQbTMvjAncqS9LRCHJzNakntm1HCOE5MiWJEdvY0GL1NjTf0gi2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOQpEiqaKjQUqwxvCwlnwvadEho3TteT5aTpV4tUF3M=;
 b=iox9tNG2C/PGZAe5ycdrsSgaXsIobs83yk/rtxx99RkZjFAwFkPPrAJ8IrAzMFmQSaJ5zd+pK6KFgy3qVNlZzBdJlbYkgalIVr+IRIMGrjAFcIa8i8NZSWpEUQomdh091OQen2X+tv0paiZztMH1SWjm6OKmPim9fWQHNJSj0/4hX/7sOvDPuflwSHSHlLIRXHrw2iwU8D1X6mptPgk8hBMH9pNvg2h63eEeF5HLDqoUbAkJWfKS/tUe0VpFrdDZlS6zqypbIvMeeoAnuvnlzoPZxNYv33EjXrk/rv5g3MO7HgJEcoHQepXiflGjM0KpNuyMPpqwC/kd24XXn2bJLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9349.eurprd04.prod.outlook.com (2603:10a6:102:2b8::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 12:25:31 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 12:25:31 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 21 Apr 2026 21:41:18 +0800
Subject: [PATCH 06/15] imx8mq: cm: drop redundant gd clearing in board_init_f
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-imx8mq-dm-pmic-v1-6-0e2b490542b1@nxp.com>
References: <20260421-imx8mq-dm-pmic-v1-0-0e2b490542b1@nxp.com>
In-Reply-To: <20260421-imx8mq-dm-pmic-v1-0-0e2b490542b1@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 kernel@puri.sm
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>, 
 Ye Li <ye.li@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 "Lukas F. Hartmann" <lukas@mntre.com>, Patrick Wildt <patrick@blueri.se>, 
 Marek Vasut <marex@denx.de>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Ilko Iliev <iliev@ronetix.at>, Angus Ainslie <angus@akkea.ca>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MAXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb2ea67-71d5-4527-88c5-08de9fa113eb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|7416014|376014|1800799024|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2mWIr/uggZkMaGPCSH6PbRfqBfk5NpLeBfSum+2jWHLL+2aA5dTmHLtSpbzczNZzQTNBDM/psif0luRP8TH7NsnYKQbTyUlBI4DQd0l+AQ/RM4o9DWYOt5HVwu6AvbVa1I9Sk/Onrb2C52+67H2/Obwl+xfIKR/HhTt95yocW8DoyFutygYcYlP7+FpmmdADQg3gX7IX1grD/5iFiNe3cpV/OaFN0dYlwKHMsooh4hOBaWUcyv/zj8FPol3VxbV7xAJsL7Zm37iJdSJFXG7cyTo2VKAXSXHRU87g8OnB8CIBS3JlrpP+gkKRyclhUWS1zzeOtqyiIytE1oSVcM50HhOO0QmlRUziH2i8o7tLYszuBmT9BJocQ99zKUgZgu10oxd6otDnjxybT3fg23Ec/EWk8d/PMtwADfRnoU8HZrna74BqgcxasEKAom4p72K2ezRCoDz+nliUvqavfErlMrZkvd9ONup1LLk6/2HJsdj3FwT5O1uzL50CQZnowQ4nuiMIP4PATtk4HcqyRSUUYaugOYUtdpeZ4z5mddeDtJ6NgOHNMFAgiqHpv8bxrL6kyZ8HwHUO4edmK2l3G9LG/6pibupa8Cov8N7YeyXrT4pYOESYXuLfhB+vEFGkwkr2TiqDyqOp/NECIpZFcZw2oLT5XgQ6l40xHYdPQu+EY3YW5XlxIxawc8XGqZDhzJQ6+vIi7xcWmxM4s6rTZ0tDT/GZx+vE+D4P22oCip14GeL8SfNrr6v4NG+D7BEIDoi1Psc+enGJsQMEp4WAiTrx0+wLm99TbOaHRYvPxveivpI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHhISFlJU3FYbUtIbUxtMlN1NWJzbWdwa1pRWXlFcHVBSXBTR3JmbG9iY2h0?=
 =?utf-8?B?Z0kzcFV3REJTK1l0dkxEemxNZkphUHh3TGZaMWVFWFFzNDBXTmc0QjVCYkk4?=
 =?utf-8?B?alBGYlFOcjVzT1EzM3krTDMzQ09EKzRwckFZaTlJOXc1M3lHSTFvMzd6N2x6?=
 =?utf-8?B?cnJNMVJGYVplQ2c0VnRKb1dVSDlMNlZoTlNxZnpGbGtJa0ZOa3pZRXNka2lq?=
 =?utf-8?B?UjVyY0pEc2NTZ2I0dU0vMkFFVTQzd1MxUWNtTW1SQVdBajk3QUVRMTg4MDhM?=
 =?utf-8?B?a3h4QzErQklsWVBUdktqdmd6Rk4rbFl1MTZWYncwOFcraVVvd2RNdVZ2YjY4?=
 =?utf-8?B?MXhSbWdMdkFVY3oxRXpEZVNLS21UaHAyZUFBWVVYT2htWTlTNzRtcjdyVUpl?=
 =?utf-8?B?RTlFVFZsOU1RN0cyRmNsRnNPd2RQR3Z6cnBMdnZqS0lpVU5GYVNqSFg2SW9z?=
 =?utf-8?B?RXlUYlk4WW1Pc3hkeVJhNTV0QjdoeCtTb0k4bXpVSExiblNGSUZhMWtjVjRa?=
 =?utf-8?B?MXk3elM4MXF6d200UUt3RjRaZHJNZnptRjRVU3R5OXFJQ2hHNWhoWTRxK2I2?=
 =?utf-8?B?WTFFTkVBa0VoZUxoN25kbkZ0bG4rN0txa3JGV09lK1lVaFVtVXV2TkIyRWhB?=
 =?utf-8?B?NHY0OWI4YlBreHlVczRlbm9QdU5ZSVUrYkdTUzFBcjR0OUNBQ216QW1ZY0tY?=
 =?utf-8?B?UWdua0hjMVQ5dS8wcjM0Nk5qbWxPNXJxNXY1cHBGajVTUXJvWmVsSHhLZnUr?=
 =?utf-8?B?dWM1Tm43SDk5dzR6K0QydmkrQS8vL3VXSndYdmdCTUlFWEhpK0JDUzRZdXho?=
 =?utf-8?B?T2RBR2d5YVNDa2h6eFlYa1dUdUw0NGZERmViVDZ2OWJCNldSOFNWSWhLRWpH?=
 =?utf-8?B?Y0JqSnJaWHBHdktYaGVBOGtiU0pDUmE2TEhyQUJGREJkdTVmWWJ0NUJ0SWRo?=
 =?utf-8?B?M3dMbTlQL1NobElieVVZbmdGRmQ2QmtlSUNxYjRhemVicGhtOW5OL2w2R0lS?=
 =?utf-8?B?VzVuM1hIMncyaVZEQ2UwdFJaQVArTE5qN2hqRThHTmN6RDMxUnQzY0lzeUM3?=
 =?utf-8?B?cUwwbEZadXlQMDMvSkZKSHNic2tKM29rd1E2aDJpMEsyRkFMdFZVZm5WNlBF?=
 =?utf-8?B?U2FVdFVkMUJCcHF6V3JDa281UXhBSWZFcndiQmJKZjJ6UURVUFZVcHlrSFFH?=
 =?utf-8?B?ZW5mWTJodnBEbkNDbUZBREpoUVlvTDV2bXo5OW1KRm40T0h4NWJpbE9nUDVE?=
 =?utf-8?B?VXFDVHYwL09DN0NGTDlpRi94d0VpK2NaWEg3MTh3QnJCQll3Z1RCUWFiQW4w?=
 =?utf-8?B?dWpLcmJWdzZWVGVpRFZDMUEreWdqeUIzWXc0R3lvTlhOdkZPN0JoeDZXL2ZL?=
 =?utf-8?B?a1psaVd4Rld2QUNjdVllM3M0UHRpNWdKd3paaVRCWW1sUFNMNGRMYkZoUXpi?=
 =?utf-8?B?Nm1YQ2Ivd0M3aTlzSmZFTmllenZBUTY3OHc3SjFON1U4OEkzRzhWQ095M0g3?=
 =?utf-8?B?YU1lV2pvcGxOR01pQ3Jqa09YeEorcUMrQUhtb3c4akdqVlhLZVZxV2RHbjNN?=
 =?utf-8?B?YjhkSGlhMmQ1OWVncE5OYlRuVHRsZlNTTVd3TG1tS0VpR0l1bXRkZkhkSVVt?=
 =?utf-8?B?dTNvcjRldmpSOFNqMCs2WEtTeEwrWEwxSFZqazJZUzlkR25BWWNHSHVYTi9G?=
 =?utf-8?B?THRaYitTTkE5VzVtVUVydGdLeXJuNFczRTlRK09ZZlBLYzZhT1hjMnc3TjBx?=
 =?utf-8?B?MU9YcjNPVTBGZndNS0FRTnJQZWlwT21tMTFQQ1E1aTFGVVVBV2MzVHdwbWth?=
 =?utf-8?B?dDF1bW1nU2JlN3A5VFNpNytOaXpnTWJpREJvRnl0aHhzTUxhcHhaTkhFZExm?=
 =?utf-8?B?bVpYd2dPendJQVh6U09LZmdUbGlQVnYvNVJCRVora2pmOTNhL1BsS2pMWUFR?=
 =?utf-8?B?aTd5YktwallRZXlRbnA3VzhQVFdVUWlmTG9SdUM4YkxhdEFEK1lacWdNOTRl?=
 =?utf-8?B?dzBvYUFrZnZKTFVXZm9MSmk5TkJFcFhVdTV1MFREbmoyM3lHaFR3RzFzMDJz?=
 =?utf-8?B?YWpSOENWY2QyenlkbTl3cm4zVkU3SHMxbVpEamxvaVgyRGNtU0sxOXlYcmY1?=
 =?utf-8?B?cmxIaVkzMWxrV1ZVbXp2Zmk4K0VHS0V5cnpEU3JwWWsxUGhlT1lCUzFScWpo?=
 =?utf-8?B?NFdxS0VnM3VxNW94VUVzaE8vU3Q0azFDK3RnMTBFWVV2MWFYYi9PbHZ4Rnpz?=
 =?utf-8?B?N21KZjNITnpTR1JSVFJ3bWRUd2Z4cFErMDRVSnI5bU42UFg3c0x2Zi9MUVI2?=
 =?utf-8?B?RTVrb1k0RXpoQTBxbjNjelNycWtWRnpHNHJ3QVBKUlZWRnVoOE5JUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb2ea67-71d5-4527-88c5-08de9fa113eb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 12:25:30.9364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgKA/0j4Yma0d3b82zx/CU6SckdMRmZrk8SD9I1gmFPWQtG1KKftrB2NBPr++XCliu3cwu+sjCgzSE21dF3EJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9349
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

The global data (gd) area is already zeroed in
board_init_f_init_reserve() before board_init_f() is called.
Remove the duplicate gd clearing from board_init_f().

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/ronetix/imx8mq-cm/spl.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/board/ronetix/imx8mq-cm/spl.c b/board/ronetix/imx8mq-cm/spl.c
index ee0ad20ced4..200562482af 100644
--- a/board/ronetix/imx8mq-cm/spl.c
+++ b/board/ronetix/imx8mq-cm/spl.c
@@ -18,8 +18,6 @@
 #include <linux/delay.h>
 #include <spl.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static void spl_dram_init(void)
 {
 	/* ddr init */
@@ -135,9 +133,6 @@ void board_init_f(ulong dummy)
 {
 	int ret;
 
-	/* Clear global data */
-	memset((void *)gd, 0, sizeof(gd_t));
-
 	arch_cpu_init();
 
 	init_uart_clk(0);

-- 
2.51.0

