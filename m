Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F68F8FA66
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1856983A91;
	Tue, 21 Apr 2026 14:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rWFg6dlw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBEAB842EF; Tue, 21 Apr 2026 14:26:04 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3A8B8425F
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:26:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=td6AO0ijFg9XWIDDZkyLbxqvDOMuiQQwp9XrtdELMzUlrDyD2NYy99QTMmKsYMNMEego8+mtyzKc+jVXlVDAjtqWUXth0Py9u6m4Qc0K/EeMslTSZyoQDAH7eDZgUfnCphYFLqoWslo1GukAT6AoXtQ0g34fOZhn6B9rRzlkPG6V8vKn4q4n+iruI+fdAKmNJ5XvhwRJSdKO3NRirRu/RhDfqlD4zDe+WFaGBd2sGi6LUXtNXiZcT9jQYxrqNtW2Or4rP3cJnxYMoEwcp7KMtklyKJYqTmYFuxoievaLcx1esUivEdaTprXq8zMd7mVEeJUwewEizzObqFHRUyYKuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZH7f9yhWeZFm3YZvZr7DWSiwy9O4/el39TnZGM/o3xo=;
 b=Il86WkSqT8kCBmv5vISmroxYmQSP/XMc8X/CRKBKSm0nSenslHIT6lN1060cN5poL+Z0fhAyeLUJvi0Oa6trL6w+rzZBEYIN1AzCAnI3c56YIk9AuFXCkmpUv2spOjt1sAAWkoWiEFVGunvPda3W+/n4GtBEVYqkvu4/wuQoICy+qxUXk2HGqR9u6TsizkFOpeeIWY+2wB3VAJtzmOUgJCWG4d9QAGCfW+YaIqU7PzmmQbJndFsyf9Keq4g08Dz9DgO63375dfKKBwumtLgTpCwMEpRUmp6bjMfD1+lTxQP0iLNaEPJ5yMdwoNU66+a72ZD8G7kd57yegy+F7Ru96w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH7f9yhWeZFm3YZvZr7DWSiwy9O4/el39TnZGM/o3xo=;
 b=rWFg6dlwEwIYxcalh8bxAStkd6MQP0XqHTfb7lsAG0evHYQehcHdp0u/N5xBcd+kwu46Fz/8pxu41BiHozTb9KWjn/YNkmQwts2linWkSnLF/FI8SafmRSP05L59Ef2xRRS7xqacBGFPoVrQm0Z/2L42HvQ9u08AN9ri71DT/z9oTeS5/2uZHDEIWMY0ERwiFS1D16Zy+wzQx38+jc9AaC5kjGSDmk/M0X6OcSjpjUkhawb0qtcUlrzt80bZ1Ui8Rize4Rr7g7RqwBvosqsULKWCyjbKHYjn6WF+g+x7tvff+DgdJQYl8zrwViWcvGT8lD2ufbz4JmQiP+BEkGChPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9349.eurprd04.prod.outlook.com (2603:10a6:102:2b8::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 12:25:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 12:25:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 21 Apr 2026 21:41:22 +0800
Subject: [PATCH 10/15] imx8mq: evk: Migrate to DM PMIC framework
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-imx8mq-dm-pmic-v1-10-0e2b490542b1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ee616c7f-133b-4182-2d33-08de9fa12412
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|7416014|376014|1800799024|38350700014|56012099003|18002099003|22082099003|18092099006;
X-Microsoft-Antispam-Message-Info: huuNcayi+O7mHG08Lz3FswqLa/qs5fako3GywbS9C6E9bBJYzjA+U680Gt15bAOaTGuPEkiO9vuvY/6Chm0+l8F/yA2PNY1gH+26n1CBkUKyaD7M265TQWoI+G2IDHmkvdN0cSTPezyXWxNo2vuxwdhfNDphVQyO2G5NHkbtQBoRMsu3y36D5OeyVKRDGEWeBm46smXVo5CyhG2Q3Ji6vbb2PjkrW+F/H/wCECdFSxQ7HB8kNSJoWhVmrGLRytfBpBmeaFG1IvdPOg7HtLYJk8O5qaFQ55567sALfx5UjNKcRlG5AHCfpE5oP5anGk0Y0/eBu77/jOBNugRyDzXhCE1qrncQ4KymLhqn8HX0DdSBHBg5s8FlNTx/cgrJYmELKVZnJGxT3T8MnivO5A3YhDFgs1LQL2Dhr0r8lUCxCot4fvqyngm6TbLVtGrN1BI+0rJoKl1RBWMdrQG8ZuOEdqL4MEk3TaJOG6yezZJmUxPpJELnegIS8YD7dHROD3rWgL7HkyjadzqM1TQBzAat1vwSm3TI9AvXmP/askplvFvWKk5UKjiFeg1ZtHvi0hol0KWsqnVg2m6cACBiZBwnzyThsBRXJa0pmFgCji+1PgP+AIe33f/fBvvmIq8aWn7ve8N6oxuQdiX3MRQXKLZjeZ61AZsjL8lEF2vdCWhP/nSVr+2cXALhBwUH2Q33L8L8Vy0A9JhTupykTwZsWXGOiBAUlWmGc5e9Q1gGvwoDj34Copie8/lTYY1NXZLHLTrho/jWJ8dSs3jzco21f3kEm3XhTgGMxm5UsVa3bMDMzdU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014)(56012099003)(18002099003)(22082099003)(18092099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkZQbkdZLzExa0dBT2ZMMk1wQTBvUmdITDc2RkM0VHNkdWxtZTdZcldHcGQx?=
 =?utf-8?B?TzU0ZEpYby9VVDVrU3dvd3FoZG9ieStCVkZkdFBtdTBFTjQ5UGhUUWNQczJS?=
 =?utf-8?B?WU95TFRxeXkyZWl5bkwrTVJNR0JqNFZnS2V6NjNKd2RvQ0NwUW56bWh3OG0w?=
 =?utf-8?B?emhLTkI2K2F2bTN1Skx1V2R2WC9yc1g4dlpkRGVxZDJsTVBDRjgwL2FRVzV0?=
 =?utf-8?B?NjdXRWVHUVJRdVpsU3RkTlFmbks3TTZpaU1ncWhBaVdlWmR2R0NmWnRzNHJw?=
 =?utf-8?B?K2FHZFFlSmRiNkhJZDEyQklPQWJIbTRFN3JvS29IckRVMnRWS3BJZzJKQ1NG?=
 =?utf-8?B?U3l5Ky80dlhiS3RDU2lSWmc5UHF6L1Q4eUNnZmU0MjY0UHNXaXhCdXJnN0c5?=
 =?utf-8?B?WHdpK294VUlDMVFrSHMzUzBCQXpVRktkTEgvTWJqRXFDaDhHUkRpRFdIYVox?=
 =?utf-8?B?QkM1dzRmaThjVXpPZjhZYVBKd2VadU9SUW9kUEZhMjl4N3lsYWlHMHhIOVpH?=
 =?utf-8?B?NHBlZUQxTjZNVGJHZXpBNjRTWGFCRGdGYnFlM3k1N3J3WTNwRWlMT0JCbUky?=
 =?utf-8?B?NG1FQThWWjNES01DY0pWNm1HRy9BdHAxdlplUkt4WVhCODdkWFFleXkzSHpT?=
 =?utf-8?B?cGZHRVR0Sk8xdURkTnAvNFV5VkxJWE5tTUdKKytsSHNQM1FjMm1YR0QwV3NH?=
 =?utf-8?B?WjBzbTRvK2hwNnJqVUVLNVd2KzZWS3ZtcXhnUmpFaFF4bnBZdU1BU3NwWmlj?=
 =?utf-8?B?bEJBV2JYWE9IK3hkMnBOWjM2eXI4WTE3c3Zzb3lRNFRRbmQrODBSYkRRQUJY?=
 =?utf-8?B?ZXNnQ2d6NFJ4VE1pdjU4c0FZaW1YaElqNG5uTXFFaDRxSzMwV1ZuL0hSNlpw?=
 =?utf-8?B?eS9mN0FtZW5pdXR2bjFZUC9ZNjV1bTdXZmVCUFBKOFcxNUhXTFFSWFhFWG14?=
 =?utf-8?B?RlpqT1c5d0ZNWXZtSFBuaEdKSUtRdHd0NkJ3bWEwMEdORGNlYW5LcmRFcHow?=
 =?utf-8?B?ZzFsNlRxNzVBVGJTcERmanB5U3ptTk5HbjUyZFNlNkIrZmllNXlTcmNXWFVP?=
 =?utf-8?B?QmlVWW85OWlLZWY4aVFCc0F6eUZSUVFxbzVnRCtiYzFQODRVeng1dElQYWE1?=
 =?utf-8?B?bExBT09nZHU0OTdsSis1U0tMeFdyeGxZU05OK2Q0Ymx2TW5EaWFXQ2VhRkZZ?=
 =?utf-8?B?UUUvbUw1NXNKUHlBVjgrOVJpZUtxS0Jyb2MxSFdtbU1UNUorWktzY0xCdUM3?=
 =?utf-8?B?MkRGcFgyNDQvUzB0cktGQ2I3aHNoUTVWTXAzMXRqNEwwYUZNT1JhMVpTVm5L?=
 =?utf-8?B?eSt4S2FZY1VmTGIveWRreUpOL1AyOGxPVmpzUUN5UjRRcTE4NWc2SUVybG1m?=
 =?utf-8?B?WTFNL3BxNzJrOFkyR2N2MnVyMFRvQWFrNkZFZ1VSSFViYS9WS1VuTHhIb2RC?=
 =?utf-8?B?ZU1VTXQ3TVpiMDZHaW1KUVQvV25zQjFjTm5NWkpWRzFpM3ZQb1piY2NTS0N4?=
 =?utf-8?B?ZkJmL1FETXJRL21jREEreURobHlxMWVkYnR5anljV242Wi9SRHgzN0N3Z29T?=
 =?utf-8?B?VnBtL0VHb2k2NWFjbFZxRk1FTWZrL3krSVNXa0crZCtBZVNVSmlUWktuY2Fl?=
 =?utf-8?B?azRUclZpclBMeEZBNWJrVUtoWlVxM0NZRkpJL3lTa2t4Uys2dDhFdmRQeDJZ?=
 =?utf-8?B?RCtqOTRmQW8xdmNhWVp1M09BblFUbEpZeGZhazZCZDE0bTZINmZWdGphTEFq?=
 =?utf-8?B?cThVQ3BqWDhtTU5Ib041R2NOZ2dyTXB4bUljVXZkRW5nSUYxOWhvWXhhbWZC?=
 =?utf-8?B?Yy9nendsWFVobWlURlFpUDZ4UmVlbHQ3ejNXdEJ2L0htR0xMR1BCc2g2ZlBE?=
 =?utf-8?B?ZlBBTnU0SFFIOVVZY1RZbW9MR210bHFxdmZackgreTJEeHpMVDU4WFg2YXBa?=
 =?utf-8?B?OXRlOVlubEdpc1FWbmUvcytSWHJpblBXNUJvMU5UQ1RUckVqVUg4ZWJ4MU12?=
 =?utf-8?B?enFFRFJRT0dndzNJYmhydkpySkEzQTRDK0toS0F3S0c3b3ZnTUFuQU9tdUpO?=
 =?utf-8?B?VmlPclJRNlMzTVhMS2ZkUlh6Q1lINDZlQnhiSHF6WTFwOURuS0MrM2lobm0w?=
 =?utf-8?B?WENPbG9HRzZwN2duaUt6elBydVc3QUUxM1NxZ1JGMlc2MUs0MXBPbkZPOC9x?=
 =?utf-8?B?Sm14c28va1krWmJ6U2paR3pkNWhXbTA4VkI0bkNHMFE1cXZDVXpWVzBobmVI?=
 =?utf-8?B?RDNaYzZpd0ZaaGM3clRObWZXbVBsNUdRVmFqSEt4NFNTT2NwN2U5enhScEwy?=
 =?utf-8?B?MHBETWZpbEQrQUtSZ0w3eU1TQjc2UkRwQk95WEY4aFRNaVB2eU1odz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee616c7f-133b-4182-2d33-08de9fa12412
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 12:25:57.8909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2fegZS07sd9h50smqWtSEekrWrACiSmXp2pmZbelUTBvTWKQkXmVBzQ83ZLSmkztvqQtxWrdkdYX3oTM8EZoA==
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

Migrate the i.MX8MQ EVK board to the Driver Model (DM) PMIC framework.
This replaces legacy PMIC handling with DM_PMIC and enables proper
device-model support during SPL.

As part of this transition, enable CONFIG_SPL_DM and the required
DM subsystems such as I2C, PINCTRL, MMC, GPIO, and regulators so the
SPL boot flow continues to work correctly.

Board-specific SPL code is simplified accordingly by removing legacy
I2C, USDHC, and PMIC handling, relying instead on device tree
descriptions and DM drivers.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx8mq-evk-u-boot.dtsi |  88 ++++++++++++++++-
 board/nxp/imx8mq_evk/spl.c          | 185 +++++++-----------------------------
 configs/imx8mq_evk_defconfig        |  21 ++--
 3 files changed, 129 insertions(+), 165 deletions(-)

diff --git a/arch/arm/dts/imx8mq-evk-u-boot.dtsi b/arch/arm/dts/imx8mq-evk-u-boot.dtsi
index d987f68b6ba..ca80dc994b1 100644
--- a/arch/arm/dts/imx8mq-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mq-evk-u-boot.dtsi
@@ -2,19 +2,105 @@
 
 #include "imx8mq-u-boot.dtsi"
 
+&aips1 {
+	bootph-all;
+};
+
+&gpio2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_i2c1 {
+	bootph-all;
+};
+
+&i2c1 {
+	bootph-all;
+};
+
+&soc {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&{/soc@0/bus@30800000/i2c@30a20000/pmic@8} {
+	bootph-all;
+};
+
+&{/soc@0/bus@30800000/i2c@30a20000/pmic@8/regulators} {
+	bootph-all;
+};
+
 &pinctrl_uart1 {
 	bootph-pre-ram;
 };
 
+&uart1 {
+	bootph-pre-ram;
+};
+
 &usdhc1 {
+	bootph-pre-ram;
 	mmc-hs400-1_8v;
+	/delete-property/ vqmmc-supply;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_200mhz {
+	bootph-pre-ram;
 };
 
 &usdhc2 {
+	bootph-pre-ram;
 	sd-uhs-sdr104;
 	sd-uhs-ddr50;
 };
 
-&uart1 {
+&pinctrl_usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_gpio {
+	bootph-pre-ram;
+};
+
+&pinctrl_reg_usdhc2 {
+	bootph-pre-ram;
+};
+
+&reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+#ifdef CONFIG_FSL_CAAM
+&crypto {
+	bootph-pre-ram;
+};
+
+&sec_jr0 {
+	bootph-pre-ram;
+};
+
+&sec_jr1 {
+	bootph-pre-ram;
+};
+
+&sec_jr2 {
 	bootph-pre-ram;
 };
+#endif
diff --git a/board/nxp/imx8mq_evk/spl.c b/board/nxp/imx8mq_evk/spl.c
index 6686fe34126..80322a2ed19 100644
--- a/board/nxp/imx8mq_evk/spl.c
+++ b/board/nxp/imx8mq_evk/spl.c
@@ -9,23 +9,16 @@
 #include <image.h>
 #include <init.h>
 #include <log.h>
-#include <asm/io.h>
 #include <errno.h>
 #include <asm/io.h>
 #include <asm/arch/ddr.h>
-#include <asm/arch/imx8mq_pins.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/clock.h>
-#include <asm/mach-imx/iomux-v3.h>
-#include <asm/mach-imx/gpio.h>
-#include <asm/mach-imx/mxc_i2c.h>
 #include <asm/sections.h>
-#include <fsl_esdhc_imx.h>
-#include <fsl_sec.h>
-#include <mmc.h>
-#include <linux/delay.h>
 #include <power/pmic.h>
 #include <power/pfuze100_pmic.h>
+#include <dm/uclass.h>
+#include <dm/device.h>
 #include <spl.h>
 #include "../common/pfuze.h"
 
@@ -40,166 +33,52 @@ static void spl_dram_init(void)
 		ddr_init(&dram_timing_b0);
 }
 
-#define I2C_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE)
-#define PC MUX_PAD_CTRL(I2C_PAD_CTRL)
-static struct i2c_pads_info i2c_pad_info1 = {
-	.scl = {
-		.i2c_mode = IMX8MQ_PAD_I2C1_SCL__I2C1_SCL | PC,
-		.gpio_mode = IMX8MQ_PAD_I2C1_SCL__GPIO5_IO14 | PC,
-		.gp = IMX_GPIO_NR(5, 14),
-	},
-	.sda = {
-		.i2c_mode = IMX8MQ_PAD_I2C1_SDA__I2C1_SDA | PC,
-		.gpio_mode = IMX8MQ_PAD_I2C1_SDA__GPIO5_IO15 | PC,
-		.gp = IMX_GPIO_NR(5, 15),
-	},
-};
-
-#define USDHC2_CD_GPIO	IMX_GPIO_NR(2, 12)
-#define USDHC1_PWR_GPIO IMX_GPIO_NR(2, 10)
-#define USDHC2_PWR_GPIO IMX_GPIO_NR(2, 19)
-
-int board_mmc_getcd(struct mmc *mmc)
-{
-	struct fsl_esdhc_cfg *cfg = (struct fsl_esdhc_cfg *)mmc->priv;
-	int ret = 0;
-
-	switch (cfg->esdhc_base) {
-	case USDHC1_BASE_ADDR:
-		ret = 1;
-		break;
-	case USDHC2_BASE_ADDR:
-		ret = !gpio_get_value(USDHC2_CD_GPIO);
-		return ret;
-	}
-
-	return 1;
-}
-
-#define USDHC_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE | \
-			 PAD_CTL_FSEL2)
-#define USDHC_GPIO_PAD_CTRL (PAD_CTL_PUE | PAD_CTL_DSE1)
-
-static iomux_v3_cfg_t const usdhc1_pads[] = {
-	IMX8MQ_PAD_SD1_CLK__USDHC1_CLK | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_CMD__USDHC1_CMD | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_DATA0__USDHC1_DATA0 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_DATA1__USDHC1_DATA1 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_DATA2__USDHC1_DATA2 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_DATA3__USDHC1_DATA3 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_DATA4__USDHC1_DATA4 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_DATA5__USDHC1_DATA5 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_DATA6__USDHC1_DATA6 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_DATA7__USDHC1_DATA7 | MUX_PAD_CTRL(USDHC_PAD_CTRL),
-	IMX8MQ_PAD_SD1_RESET_B__GPIO2_IO10 | MUX_PAD_CTRL(NO_PAD_CTRL),
-};
-
-static iomux_v3_cfg_t const usdhc2_pads[] = {
-	IMX8MQ_PAD_SD2_CLK__USDHC2_CLK | MUX_PAD_CTRL(USDHC_PAD_CTRL), /* 0xd6 */
-	IMX8MQ_PAD_SD2_CMD__USDHC2_CMD | MUX_PAD_CTRL(USDHC_PAD_CTRL), /* 0xd6 */
-	IMX8MQ_PAD_SD2_DATA0__USDHC2_DATA0 | MUX_PAD_CTRL(USDHC_PAD_CTRL), /* 0xd6 */
-	IMX8MQ_PAD_SD2_DATA1__USDHC2_DATA1 | MUX_PAD_CTRL(USDHC_PAD_CTRL), /* 0xd6 */
-	IMX8MQ_PAD_SD2_DATA2__USDHC2_DATA2 | MUX_PAD_CTRL(USDHC_PAD_CTRL), /* 0x16 */
-	IMX8MQ_PAD_SD2_DATA3__USDHC2_DATA3 | MUX_PAD_CTRL(USDHC_PAD_CTRL), /* 0xd6 */
-	IMX8MQ_PAD_SD2_CD_B__GPIO2_IO12 | MUX_PAD_CTRL(USDHC_GPIO_PAD_CTRL),
-	IMX8MQ_PAD_SD2_RESET_B__GPIO2_IO19 | MUX_PAD_CTRL(USDHC_GPIO_PAD_CTRL),
-};
-
-static struct fsl_esdhc_cfg usdhc_cfg[2] = {
-	{USDHC1_BASE_ADDR, 0, 8},
-	{USDHC2_BASE_ADDR, 0, 4},
-};
-
-int board_mmc_init(struct bd_info *bis)
-{
-	int i, ret;
-	/*
-	 * According to the board_mmc_init() the following map is done:
-	 * (U-Boot device node)    (Physical Port)
-	 * mmc0                    USDHC1
-	 * mmc1                    USDHC2
-	 */
-	for (i = 0; i < CFG_SYS_FSL_USDHC_NUM; i++) {
-		switch (i) {
-		case 0:
-			init_clk_usdhc(0);
-			usdhc_cfg[0].sdhc_clk = mxc_get_clock(USDHC1_CLK_ROOT);
-			imx_iomux_v3_setup_multiple_pads(usdhc1_pads,
-							 ARRAY_SIZE(usdhc1_pads));
-			gpio_request(USDHC1_PWR_GPIO, "usdhc1_reset");
-			gpio_direction_output(USDHC1_PWR_GPIO, 0);
-			udelay(500);
-			gpio_direction_output(USDHC1_PWR_GPIO, 1);
-			break;
-		case 1:
-			init_clk_usdhc(1);
-			usdhc_cfg[1].sdhc_clk = mxc_get_clock(USDHC2_CLK_ROOT);
-			imx_iomux_v3_setup_multiple_pads(usdhc2_pads,
-							 ARRAY_SIZE(usdhc2_pads));
-			gpio_request(USDHC2_PWR_GPIO, "usdhc2_reset");
-			gpio_direction_output(USDHC2_PWR_GPIO, 0);
-			udelay(500);
-			gpio_direction_output(USDHC2_PWR_GPIO, 1);
-			break;
-		default:
-			printf("Warning: you configured more USDHC controllers(%d) than supported by the board\n", i + 1);
-			return -EINVAL;
-		}
-
-		ret = fsl_esdhc_initialize(bis, &usdhc_cfg[i]);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-#if CONFIG_IS_ENABLED(POWER_LEGACY)
-#define I2C_PMIC	0
 int power_init_board(void)
 {
-	struct pmic *p;
+	struct udevice *dev;
+	int reg;
 	int ret;
-	unsigned int reg;
 
-	ret = power_pfuze100_init(I2C_PMIC);
-	if (ret)
-		return -ENODEV;
-
-	p = pmic_get("PFUZE100");
-	ret = pmic_probe(p);
-	if (ret)
-		return -ENODEV;
+	ret = pmic_get("pmic@8", &dev);
+	if (ret == -ENODEV) {
+		puts("No pmic@8\n");
+		return 0;
+	}
+	if (ret < 0)
+		return ret;
 
-	pmic_reg_read(p, PFUZE100_DEVICEID, &reg);
+	reg = pmic_reg_read(dev, PFUZE100_DEVICEID);
 	printf("PMIC:  PFUZE100 ID=0x%02x\n", reg);
 
-	pmic_reg_read(p, PFUZE100_SW3AVOL, &reg);
+	reg = pmic_reg_read(dev, PFUZE100_SW3AVOL);
 	if ((reg & 0x3f) != 0x18) {
 		reg &= ~0x3f;
 		reg |= 0x18;
-		pmic_reg_write(p, PFUZE100_SW3AVOL, reg);
+		pmic_reg_write(dev, PFUZE100_SW3AVOL, reg);
 	}
 
-	ret = pfuze_mode_init(p, APS_PFM);
+	ret = pfuze_mode_init(dev, APS_PFM);
 	if (ret < 0)
 		return ret;
 
 	/* set SW3A standby mode to off */
-	pmic_reg_read(p, PFUZE100_SW3AMODE, &reg);
+	reg = pmic_reg_read(dev, PFUZE100_SW3AMODE);
 	reg &= ~0xf;
 	reg |= APS_OFF;
-	pmic_reg_write(p, PFUZE100_SW3AMODE, reg);
+	pmic_reg_write(dev, PFUZE100_SW3AMODE, reg);
 
 	return 0;
 }
-#endif
 
 void spl_board_init(void)
 {
 	if (IS_ENABLED(CONFIG_FSL_CAAM)) {
-		if (sec_init())
-			printf("\nsec_init failed!\n");
+		struct udevice *dev;
+		int ret;
+
+		ret = uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(caam_jr), &dev);
+		if (ret)
+			printf("Failed to initialize caam_jr: %d\n", ret);
 	}
 	puts("Normal Boot\n");
 }
@@ -218,6 +97,9 @@ void board_init_f(ulong dummy)
 {
 	int ret;
 
+	/* Clear the BSS. */
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
 	arch_cpu_init();
 
 	init_uart_clk(0);
@@ -226,25 +108,22 @@ void board_init_f(ulong dummy)
 
 	timer_init();
 
-	preloader_console_init();
-
-	/* Clear the BSS. */
-	memset(__bss_start, 0, __bss_end - __bss_start);
-
-	ret = spl_init();
+	ret = spl_early_init();
 	if (ret) {
-		debug("spl_init() failed: %d\n", ret);
+		debug("spl_early_init() failed: %d\n", ret);
 		hang();
 	}
+	preloader_console_init();
 
 	enable_tzc380();
 
-	setup_i2c(0, CONFIG_SYS_I2C_SPEED, 0x7f, &i2c_pad_info1);
-
 	power_init_board();
 
 	/* DDR initialization */
 	spl_dram_init();
 
+	init_clk_usdhc(0);
+	init_clk_usdhc(1);
+
 	board_init_r(NULL, 0);
 }
diff --git a/configs/imx8mq_evk_defconfig b/configs/imx8mq_evk_defconfig
index 3dd6554733d..a03b241a72f 100644
--- a/configs/imx8mq_evk_defconfig
+++ b/configs/imx8mq_evk_defconfig
@@ -4,12 +4,8 @@ CONFIG_TEXT_BASE=0x40200000
 CONFIG_SYS_MALLOC_LEN=0x600000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x200000
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mq-evk"
 CONFIG_TARGET_IMX8MQ_EVK=y
@@ -18,7 +14,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SPL_STACK=0x187ff0
+CONFIG_SPL_STACK=0x920000
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x180000
@@ -73,6 +69,7 @@ CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
@@ -80,31 +77,33 @@ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_DEVICE_INDEX=1
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
+CONFIG_SPL_DM=y
 CONFIG_SAVED_DRAM_TIMING_BASE=0x40000000
 CONFIG_DFU_MMC=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
-CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
-CONFIG_PHYLIB=y
-CONFIG_PHY_ATHEROS=y
 CONFIG_PHY_GIGE=y
 CONFIG_FEC_MXC=y
 CONFIG_MII=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_ATHEROS=y
 CONFIG_PHY=y
 CONFIG_PHY_IMX8MQ_USB=y
 CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
-CONFIG_SPL_POWER_LEGACY=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_IMX8M_POWER_DOMAIN=y
-CONFIG_POWER_PFUZE100=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_PFUZE100=n
+CONFIG_SPL_DM_PMIC_PFUZE100=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_SPL_POWER_I2C=y
+CONFIG_SPL_DM_REGULATOR_GPIO=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_TEE=y

-- 
2.51.0

