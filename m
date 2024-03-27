Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9BDC47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 13:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 255A8880B2;
	Wed, 27 Mar 2024 14:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GwQcoG8u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEA1A880B2; Wed, 27 Mar 2024 14:11:14 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2748880A6
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 14:11:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSsLSrgWjLmdaO25hDH2n74rqfYBYQJdciFUXkvpUbC0NRuvaMAJecIi4tQ0P8FR6b76keF7Oi0QYzoragTzi9UmaBhlhmN3/xXra7iSXdAkxYntvRMo62IJjR6oXs10FjKKeRUWIc3rMsiL7UhGRhQVREIgLCV9Ha3bNyQaJ8CfmYoj9OY9ePZ8yfPAP9A9spWwx7qv2awpkp70hio1K5rTCWqcAT/zKpZ9MjEI9jKiZDbVIbR/oUCPnVbpJaVU127MpK0WVaey26LmUNRfH45L5g4GIiQKhQ5ZAuSEvsvDURKi/SgZaqGqtrQgLPbwiMbT4zlean5xTII3JhoyfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALStRZ6jmEFDWYxcs4kUdFXB+LdaTSaoYjI0RFiY2SY=;
 b=N+VkVTa3Hm0OAAlqpkW9VvkKpGUPIrUjpEldf/DOLS1ml4VrHG3+PUJNiHkJbHrtFmoAieZ53WyOi56iGEHiP5+2SzKQS2Dpg7zRuEMG5G0DewPCBP5LU9PJ0X0eOaFDcf98HjmDbhVv4cUZRUZ3rBbcgcdDMwCnNZQ8re5oJ8s8bxcX4q3/Q9OQ/OT/7mFoacAK/q6O25LWYJJuDwsgktQlphPV0E0sTZTnFemHFX4O1qK4Sytoq9ELydQh6s3RCgCV2VQ6hXfKc54xeI7UvJHyWe2gUu+sLpwdysByNfhfRxdw695sSt4UyeIJAKkuNb61RSsEseo9gV9nYTPgLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALStRZ6jmEFDWYxcs4kUdFXB+LdaTSaoYjI0RFiY2SY=;
 b=GwQcoG8uug71dvOGKHGLf6SVKvqJG2rd9ehTvGU2zQGclWCdoEvRHCbLi8bk+k2+gt1sjJz+MCtXRRA8TOBIiSk1392p83GImLSRcEXYbifP0AqZYSUy545DGENFxpSuz0so6PZQOkaPdST2x4K4F0hHG8zfn5jwSCxCVK3ZhLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 13:11:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 27 Mar 2024
 13:11:10 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/6] imx93-11x11-evk: convert to OF_UPSTREAM
Date: Wed, 27 Mar 2024 22:10:44 +0800
Message-Id: <20240327-imx93-of-v1-0-afab6b31422a@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOQoBGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyNz3czcCktj3fw0XVOz1DSjJEuzNKNUIyWg8oKi1LTMCrBR0bG1tQA
 4NdLbWgAAAA==
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ab26656-3b39-42d3-9a97-08dc4e5f5ef0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3m+sDTrqA6PKk2sOCxRpdvYQ1GPu75A5WAsNlLIsFI9XyFYewXbsEoThN5teu8wyge8CB01IiAC8PBnM8xTqKxWm6V9EBJX4HGAWav09qrlY46bKo9R/eZg5NiwI8OWfyiAmZSsDgMj3qaQIsE4T4f5DQ+kdTLjOCe+ihLN5dPOIoSjE/3zwF0L8eQ7tN1Sqhj0hwBnSxchPSZvc/iqFATUYE8Lg79VXPt7+zqncR1YFXAFK/qR0+e0AQAO7x3rh1i6+70hJpZ/Lrzh1q0g1l0siBGq2RijWbLFYV++sZKuevCGEFdfyH/ckvirrMWBTakBHH3klYMXiPD6+Dj95LvHq+kT2FrbyVIg+KTyEP/cvFteIn+jUOjrQfjN5rdLe7atEAzcLvC9IcuQUQzA2oAEnwhSbgg6ifQXFKsLR7VJH9oe+X1oILTqnqURVP5DNl2rZn0Tw1hrSuw27vU3LuTz1oUfzt91ZpctyTcwerrVbkHFINJ6hWmS0feOXtIU0jkkDOWe3a7rIeg33LBjahuEW8jco4aA8oGiObubz7wPWPxZ4py9FLyAkXUyt+FVfvJZ3pViwEnPRMs4ZndmGE0jiKoKuM3nAOJEZVctAylRnvTFBQM8LElG+rZd99qbhxgWp8XBAe6rOrhdZZl2bMPkHu2Vslff7q42aYNmIsNnC8a5xUdBlJUFtocEqFhnZJyKkm3y3hdhkv+CW+T72S36GRouX+OX+n+KA3D28Tl4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(1800799015)(366007)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlJVYmdqSDZveHh6YXlwK2EwUXJCaVhhOTZ5ODBCbExGZkdzZi9MMmJlcHJk?=
 =?utf-8?B?QzZoN2dzejc3ZlRWMmNJVDYwTzhCQWNyRkRSWEJYS2hDbmg2bGttM2hzbVVW?=
 =?utf-8?B?UC9OK2NjSFhLRFdHWEJwYnhVSFZvTXVsK3BIUVpKMmh2SzdESFVzQzBuWjFM?=
 =?utf-8?B?d2EweVJYR0lVa0hXY0dWZ2N0d3QwcVJ2STczS3lqSWlBMWhQcW8xTnZtWXIr?=
 =?utf-8?B?ekM4alBRL3BlVWFadVdhdXJXdEMxZEhZR1RTZFJLbDRpMXJQbUovK1RWSk1N?=
 =?utf-8?B?cURjUXlqKzRydnNXNEk1NlpCUXZwWFMxZXFPbVU5WmdGNFhteFBjMUFEYlEz?=
 =?utf-8?B?WVdtNnkyYlZiYkkzNjZla25yVDVKWHpMYjlySk41Qm1pc0xiUVJUbUl1Wk1Z?=
 =?utf-8?B?ZDZ3UzVDVm9UUTg1Y2hoWkY5SE5tL1Rkd21rM3dwS05hVlF4NG1XTlJyVTlB?=
 =?utf-8?B?aGx2QWwzNklNSXdaVXY1SjAwRTJhc1d3dmJIS0ZDbkNZQWVyM0NVTmVzRDE4?=
 =?utf-8?B?aXNFS092cW9HWW9uV2wzcnJ6aU1tVEtsRVhYcEI2ekJna2lMUkJIZEpvb0ox?=
 =?utf-8?B?SjVPSm9RL2dUVklSWmJ4TzUxdU5tLytkQVYzelZtTkJVdTdBYndXbFlROUw5?=
 =?utf-8?B?aHR6T2Vtc3ZIMiszNk1OZmJadDJMOTBCR0NrKzNVUm01a1l5d3J0aHhteVhh?=
 =?utf-8?B?Qng3NDlCOUoxZTY5aExqSlRKRDZiZmhXR3dMUHY0cXpObmpuNHFteWJCN3Bn?=
 =?utf-8?B?RjkxajFnTEdRSHRNanpSYkgrTVpLY0lnbXBpd2VzMHFRNnlRWllRNXRGL2Q3?=
 =?utf-8?B?bnVWY3o4NFZIdkNJV3FpQVlkbFZGbGVnTmttbFVnRE92SURNSlFFSFkwdnBt?=
 =?utf-8?B?L0EvY3pHbG9tNmhLVENIUWxIZ1U5NnkzRFJzdE9lOSt0a3orOTg1QUtxUkZ3?=
 =?utf-8?B?MFVpT3dna2J0RzhEZ2dZSk9nYnJJNUthQ29oWk5jUUtkN3JjcHk4bVo5M1Ix?=
 =?utf-8?B?SzFZR3Jtd1JkNTJnVmF3cndhN0I3T0E2MWpCZjFGUU5ERU4reG85Q2tadkdG?=
 =?utf-8?B?dWVOQjdLTHRpVk42SlV3aURibTZqRVl3aHhDVjhmQVJIdkxyenk0RVIzcDJn?=
 =?utf-8?B?c2pjcEFJVytPUStOamg0dW02SGw1b1l4bTE0QjgrbFJUNzJ6bmE0TUl3S2pk?=
 =?utf-8?B?bEo5UWFlSWUvek80Tk1yR0hldmZRSXIrMFpBWDlDRTQzZURiVTg3VGhzaFZG?=
 =?utf-8?B?ZzNQekc0RDBTSWV1TnpwOWtRZ2Nyd2xzVDY2RlFwNjZDZDJvSVA1My9pM20r?=
 =?utf-8?B?aVNvMzY5R3Vja0g4Z2lPS3ViTkRxTzVaQ00vMmZjN3JHcEpscnFxaEs0THFT?=
 =?utf-8?B?cjJEM3ZJY0J3YmI2aUZmN0V4TjN3d2NuT0pKTEIrbU5JTWVneG5iYlh0dEho?=
 =?utf-8?B?MEtYaVRXbnFaVDRIM2cyRG9xZVVDbHlRZUNCRTRqcVgxeDZIU2dlUzFRNGw0?=
 =?utf-8?B?aHpCZnF3RXBYMTNMeVpUMHRzZitzSG4wOUwzUDM2ZStEVE1uRlpwU1A3MU9u?=
 =?utf-8?B?UHE1dzU0L0xYVlFSdFVVMlU3a3JGaHFDam9kMERFanI1NzhrcnVHbVhXcFhQ?=
 =?utf-8?B?aDNkL1djUVRDOTJudndCYytOczNhTVNKZDY5V2x4eGR1azUwMDAvOSttUlpU?=
 =?utf-8?B?VGJNdUJhNjVyOWkzczdNWDlPbE1rT3RnU2RzRnhtUkcwYnRBb0I1QzUyc3lo?=
 =?utf-8?B?YmNCVzRHa1AzeDdPNnBTeDFqaHhQem14aUp0KzU0eHZxa3RGZTRsMDg4NEVU?=
 =?utf-8?B?b3pEMHV2RWk4ZW5CbWpMQWQzMS9LYXg0YkFCZEk0Ym1PTm9ub2hsL3V4bjYz?=
 =?utf-8?B?dThaWVVTaXpuMW1UNEwrTlI2SGZ4VXVhRytUUHcwd2RPTWZVMGNQb2FGNC9m?=
 =?utf-8?B?ZVRsS3hlY1hiTW0wcWQ3WEw5clJYZkUzaFFQemJyYmdRNUwyclhrUlRmN2FK?=
 =?utf-8?B?eVdtL282WkFlOTROdnAzb2M5MmJzKzc2bXFUMVR4bnQ5QmZrajA5bk5rS0NN?=
 =?utf-8?B?RnZ0TE5hVjBxU1ZjNnlhVURRWXRrL3pianUxdGU1WE1Ld2ZYYTRULzZnNDRK?=
 =?utf-8?Q?OtGgHwowOgfyIzFwvWSFglyer?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab26656-3b39-42d3-9a97-08dc4e5f5ef0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 13:11:10.4118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0WgUQ+LfolE4j/8JrpxEl7msgIX5hKbNrC4sQwQCjIjbEfFXpnPpSzDKoPSOLiRIAyZTOPgf1GR3lXU4nv+cyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8536
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

To support OF_UPSTREAM, a few driver changes are included.
For TMU, still use U-Boot node, I will prepare a kernel update,
then back to U-Boot support.
Add the pmic nodes to x-u-boot.dtsi, since upstream still not has it.
imx93.dtsi still kept because other boards still use it as of now.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (6):
      gpio: imx_rgpio2p: support one address
      serial: lpuart: use ipg clk for i.MX7ULP
      cpu: drop imx9_cpu
      clk: imx93: fix anatop base
      Makefile: tune the include order
      imx: imx93-11x11-evk: convert to OF_UPSTREAM

 Makefile                                 |   6 +-
 arch/arm/dts/Makefile                    |   1 -
 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi | 118 +++++++++++
 arch/arm/dts/imx93-11x11-evk.dts         | 322 -------------------------------
 arch/arm/dts/imx93-u-boot.dtsi           |  15 ++
 arch/arm/mach-imx/imx9/Kconfig           |   1 +
 configs/imx93_11x11_evk_defconfig        |   2 +-
 configs/imx93_11x11_evk_ld_defconfig     |   2 +-
 drivers/clk/imx/clk-imx93.c              |   2 +-
 drivers/cpu/imx9_cpu.c                   | 224 ---------------------
 drivers/gpio/imx_rgpio2p.c               |  42 +++-
 drivers/serial/serial_lpuart.c           |   9 +-
 12 files changed, 186 insertions(+), 558 deletions(-)
---
base-commit: ab8d9ca3044acf51d8ff3bf3c4718c48f30ad606
change-id: 20240327-imx93-of-56ef2b96f2e2

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

