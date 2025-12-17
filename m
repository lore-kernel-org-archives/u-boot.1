Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B982FD65C43
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 12:57:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEB4983B48;
	Wed, 17 Dec 2025 13:57:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JCVpPVhf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B636883AA4; Wed, 17 Dec 2025 08:07:36 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CECF683623
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 08:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5GV2F1TScIdWqj7joM90DZRM2zudK+O3QE6NXeO1F3wueSgueasF3TQYaFHmgaAIzdMuJeLvOEoMWJNG8r+QZqXimys31u/+s9ltlpx4ImDHL+bhzTMME0tYSTWbXCQtf8/I7ybrn3PlDlsGpwt2ABhPiBG/P9RFS0xw4AVw+YLwaa4vIMB5SDAx9Be0RprG0TtqavpxGpu1sx3pDFCtXurtoG4PLSie3EqroICwri8fDG2tXuHuE05XIcPpXefKatKID96xhtCqSgPD1lMojaJSez/Rihxm6hOUG7+8EMe044gY5NTAKltUjQlXTrcjbGW7OrLaG7CVETyKWmLcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HU2De/BGDm0WwP0FZFDWPDKJfClF2YQ/+Cm0dYk90xc=;
 b=x2++AJR2QXGvGb9oD8b+xNhBvBx5tchhA/TAp2FlKQUHX2ZFVlEYkokd71fSy/6MW79Rryxfu6aPY8HF1KMhxfvU+SMCsmPSpHRH7bSEQXow67iuoY8/+H64c/WgbMhG/T6yfrf6N4aNtWh2MBmLYpK4c98LL9e0eSKedGVoXh6Y3sioMG3RsV5Oz13ZLZbKzGNZs9nAZIcly32UpoJRy7i8crfftjKlPbBwe6BHetbKBgmKk5efrA4A88G0lvq1CRnGohA2na1pnBWxK9E8Jo5rS2ixAzDURdHvIJBxOknN8Rn65IQYQ8jvdQv7fS0e6cxLoJ6ker96woja2B4J/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HU2De/BGDm0WwP0FZFDWPDKJfClF2YQ/+Cm0dYk90xc=;
 b=JCVpPVhfxhnAy/UV5bhHKd94Kf2nwtSRUgOetPKHWuDqHvZjNrZrkQD/x1aUKB3rSjF5SKrlw/12jdBxYIQX4Umzo1R7coJcKf9APU4cSCWweG8+ql0qOwKT3GwdHru52tTHxaJWR7hCPx7x9RtQlIwuH3/WaX1IKjRR+HfjvYpNyw3kxqcEDU1uNWMM0J603Yf7Dzr4CPZatJ/TIugPSaGnOTKMBidP+z7ny7HaED3NOm8CMo5TvRFP4bkx6N08pRzEfPvOO9hs4eI1Oow2iUV5gS2VxHjKIVIA3WCs32a8/X+0UDEGO6rwOgP5grOn2XMcFyncIhhKAEkhxviEQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB11338.eurprd04.prod.outlook.com (2603:10a6:10:5d8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 07:07:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 07:07:33 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sbabic@nabladev.com,
	festevam@gmail.com
Cc: marek.vasut+renesas@mailbox.org, uboot-imx@nxp.com, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] imx9: scmi: clock: Correct imx_clk_scmi_enable
Date: Wed, 17 Dec 2025 16:20:59 +0800
Message-ID: <20251217082059.21761-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB11338:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d1fd6bf-afdd-4c21-d35d-08de3d3af2f0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sgw+sVSpYnYWjX7iuFSMDQQ6HZNBrG1k4sJbePt5vC4X1oPos5xNo+rdvDBX?=
 =?us-ascii?Q?Cp5HLtKtrFt/f7moMOt1vXimF/Gpxjv4UNWdWWwDM2uapHGeLKMvnYfJ5amt?=
 =?us-ascii?Q?3cBNHkPhfw38yoY3dXnid+HRE2IL/QLE9mgLBZ5GwC+0WsqX0JvU/6QMgGOE?=
 =?us-ascii?Q?e12tPJ6viZ8Rt7b6gAfAj5c94/jHJckD6BlstWKDRQoaP2OVh52x2dMUFNz9?=
 =?us-ascii?Q?dOxamZULvhFKxqehh7idY5YG0NTZT30MAqylfcfXfcW4FwVcl4M8LNxAWDom?=
 =?us-ascii?Q?8Vrkct9og5uTREURkHJ/EXfTzhWfi8uqW6kuECFfna3Cco5DcqzD9AZwDfwP?=
 =?us-ascii?Q?l1qS2tEkNOEN17M44teAxieiutWsoOdj5yBfTYzBa+Ol5l5tu42zmNOSTFU8?=
 =?us-ascii?Q?mYL/bRyIGGc76zhmFlJIglckNyqgrffisXflNT0J/V8d+At3pQM4nEhEQAPc?=
 =?us-ascii?Q?oC+lH1BOgSoSnVJHsj6zDF0O/SucWj4bASfiSZ5UOR54TJBtIqjGsECN8T9v?=
 =?us-ascii?Q?hGZ/TrEhXBHwkmiQuCB5FVRs54MO3/03gsPjllvT6cOhDDmLLVCqnCnDT4GC?=
 =?us-ascii?Q?fXUvfa+uEbqWbggzsNRtqNtuTsgbUFT09jWgazzgV4ca2v69NkSquW9p/qfm?=
 =?us-ascii?Q?O74/R2uhTowv0Y/9LfnDqGeEY9ELLFnC0dlBGZHAaYJrCo7NlujOTeLetRG3?=
 =?us-ascii?Q?MP7cgdjRNRWMNg5QggmCnon3dVjXI4gDmmCopr5u6bwjwPTAhwe9o86aV6+y?=
 =?us-ascii?Q?dc8u7odHPxwl/PzhkOPsPIrCsUDXTMNoky2lfoAERJLJwWxw583Mk8dx4Aen?=
 =?us-ascii?Q?Sh5RjSFV//dZbDcLNlHJoZSsikdoLXMuM719T0hQQq4T7RAMEqHb3VAQDLrL?=
 =?us-ascii?Q?whqNJUbOL01F+dbUbI6G6Kmk4ii8YUU0iaeMTGZtK/0FY04acgIEWxbLGrcV?=
 =?us-ascii?Q?sKxmL8cxGr4jW+ZtkmsxJCWX1PYJU2ayuMjPlct9oDjWuqKYXj70BW+Gnujv?=
 =?us-ascii?Q?AZtFJJaHoNQM069P0b/8gG5CYXMoMiX1jjQdMk7F6UuswNho2BnIpzPO8YJe?=
 =?us-ascii?Q?oKsw/qxI5EUwR3EPlol0iSrKoeGa2UVoCyBSF4tApYJ+fqDEZz5IUZ3SwDdh?=
 =?us-ascii?Q?PIZzCCcla1ZzGD/byhaEDiEAjAhZRp9kCk/OIR7qdNIdHhJnj7y43P+fRq9W?=
 =?us-ascii?Q?AvTjbNwjEuSS/f9B1KS69xuRKYGLRCsIEe5xT0gLN1EbLWlxwdcsgclrYQmb?=
 =?us-ascii?Q?yAs2GieYy3fM66GCkwfkHvUX74p4smCbBzxAhKApxCmy9VxtPnshUsqXF8OB?=
 =?us-ascii?Q?/HMFCUuuCPn77eMAIWNVeCn+tL1mbiuIp9C5j75pzTAkjpoeDiBlMlJ6EM4Y?=
 =?us-ascii?Q?IjGfT/FNPwK38wKGJh424pPTfNT/vUPi1pX3lDXqgwfLjAxpyeb67n9II0dj?=
 =?us-ascii?Q?G2hmGDx+jkA9QIlq6u7KwCPivMu9f6Rqxm7eApa/8g3S2CiEoXwdMucRD6wr?=
 =?us-ascii?Q?4/uHhxQVvdBrxnjVFKENWE0KE+knCL6zfd+K?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U5ew86m+LrMroptkbkrpR+wU75Hl0JCqjQXqDOzLVKjnQkhSORX7TbqaCa6d?=
 =?us-ascii?Q?/iuxV/oWZMOOcaxtmeq/C1swXDjpGeVhDaFHys7nHFHcbkLn9/XGqmnjGp96?=
 =?us-ascii?Q?8Z5BCeOWuzt/DOOf5vhLluOTZkLYs0xx73kBcd/4MTIyZd0bJWX1jQFPoeeH?=
 =?us-ascii?Q?2FTpJUxwqd4eJUp5r6E+ckngrCnYoLq0iHDNbC7AgqA+P48z+Jt9cHIhI9yv?=
 =?us-ascii?Q?/IOu6EBwwE3YRxbRcFOTC1wN0bqRWMC8svit12n6ny5mDA/4JFa1dl/qzYOl?=
 =?us-ascii?Q?SPdjU7CYZw7R//1PWVePE8zEYTwMHtyhlyPyklK+gWMLE5SGc0FMegQiBfKl?=
 =?us-ascii?Q?4HWaN+L90Z9BQo/0Qa4hQmFkgSB4NSEyhkNM0iB6AxfZxvbt6FVVY8A0BXi3?=
 =?us-ascii?Q?nS3n7rXgpj08/iu3ZASRmwJeQlkG4BEbcDOAXKG8Q+41SBqa7kGfXhxS1TDn?=
 =?us-ascii?Q?hsn55SO/ci5dgkdSi0cmikPLmnYpQGYHWzCIGP3FVgvpUXCp5fHZ1k0pJtbG?=
 =?us-ascii?Q?IQIMbk2r5VT7SiwCtkV2IiA+rkLPR/dwxvHZBmTj+h8B5Puv4UrS+C3dXuzj?=
 =?us-ascii?Q?V0qNMZiPhPXa3F5K7Ac/XT16bSiwRsXzxQlayyL/DKWFHCCjjhWhdzkSJ2mv?=
 =?us-ascii?Q?9i7ZHgnQnG9zX2NTynUAtHiViPLFTEzK3/DqIO2WQLgnza+lcTSRKJETSNwm?=
 =?us-ascii?Q?d0JNwBQ0XXKuoUg4KsqPbtRSkTP7ytPhfaEl9xWU6nY6DXaLzi34j5ky5juI?=
 =?us-ascii?Q?CLpwr2lM2yUM/IN48cPfqee6rmXbr6xgVq+BCzwL7d4fQf2aWkS4CIgylaB5?=
 =?us-ascii?Q?uCnHWB8HojHIK2KEkGhHz6RprEKObfMlghEgcMaHklz8chDinl2/mJ0EgWNG?=
 =?us-ascii?Q?jyDRfR0fQc1Z4QY4XlDwB+jNoOo6RZPP/jMcmnRXl/c1evcYlrrzoluLBmP/?=
 =?us-ascii?Q?U7ytIVJ8JjreEByXiF+qRFqpuKWGQgjyMzL7xJkkrUAP+LhRCgblngb6EhTZ?=
 =?us-ascii?Q?0gLiAPCKkCGk54kttgyF8WRXbMinQtJPGpdqlq63NzuQhiawXaTDbmGokVOZ?=
 =?us-ascii?Q?VrUKmgQ9OTjZ8ZmQqFtT+PegNWIb6gAGZCmSmS7S5VWAXQt95pBc+5I51VTM?=
 =?us-ascii?Q?bILJkjVhaZHIyrPArYLJhoTCK46O44zJraRw9kiEjs0cQ4lJKFiXQGsV0aCS?=
 =?us-ascii?Q?30ZtlKwgXgvRbhEDzsFctaAHXNzk6FG5v29y2RcvZZi3lj9uogPnzYxNdkRE?=
 =?us-ascii?Q?nD7pXOolFFVxGIYu1s3QspnW8cv2xD6eFaY8j7+H2P/whYZjR1I/mhTpPk0B?=
 =?us-ascii?Q?TleZ+vcwDHd7IaAdsAnDLtPt45FWVtKwhk25HTziPFMCz9P0Xwi+QfXKqigJ?=
 =?us-ascii?Q?OEyByjssmlB3pKMCEc6oN27YQmPCD1HfsYp0wZk6SJT/u6tzWRGA3ejCSGZq?=
 =?us-ascii?Q?3Q9GOyIbtUAqyJkL7Dx9ecRpC9VX0f4VlnhC9taMeulsuGHlxGM21mebp0t2?=
 =?us-ascii?Q?J2nbdBNOFp01iiwLw+6dfJjfeTG4l5GlTZ1oisQneKlx9opd2US5x21Mu057?=
 =?us-ascii?Q?nwzZiYDfSVT3oH/RKsgfrlP2jDzJQYw6jj//PiHu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1fd6bf-afdd-4c21-d35d-08de3d3af2f0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 07:07:33.2100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: deZB17m4R0cBfCLDJJGTwulwENb6+3+3SxmHP0Ma3VFyP+OHwmL3OJvh1T0nIIVFpWHS2XVvVfqolwdJ3+YimQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11338
X-Mailman-Approved-At: Wed, 17 Dec 2025 13:57:17 +0100
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

i.MX9 SCMI Supports CLK SCMI version 3.0, so need to use
"scmi_clk_state_in_v2".

Per Spec about extended_config_val: "This field is used to set extended
configuration of the clock device. It can be ignored if extended config
type specified by Bits[23:16] of the attributes field is set to 0."

So no need initialize extended_config_val.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 drop fixes tag

 arch/arm/mach-imx/imx9/scmi/clock_scmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/clock_scmi.c b/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
index 9030dbf600d..a502f19bca5 100644
--- a/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
+++ b/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
@@ -10,7 +10,7 @@
 
 int imx_clk_scmi_enable(u32 clock_id, bool enable)
 {
-	struct scmi_clk_state_in_v1 in = {
+	struct scmi_clk_state_in_v2 in = {
 		.clock_id = clock_id,
 		.attributes = !!enable,
 	};
-- 
2.51.0

