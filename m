Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45895C5AD4E
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 23:27:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 787E340510;
	Sun,  9 Aug 2026 23:27:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yslpr78nl-fA; Sun,  9 Aug 2026 23:27:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 19D334036A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786318069;
	bh=YdtTFscdOlujmVEbcHrq0voef4LfOA+WMsAiG2AKwpg=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=lPzb2Uk+Ey48Yu2cxhfsEeDcu1qm4QK28pdg/6OG5LhMNAm6HO6VgWfdMNz6gp1Xq
	 Zwg/RtHNk0eN9IM/fyDoFB4CkVN0yUsy1P4EMtOxBWKR82wgxFoGz/W3fbqpNtK9jH
	 FUUR4NpELRhZJW9U+A0kcy2+K6M9TzHAyXr5aoBD9ugJ2V5yq4EiasawrqSfJ2lb5F
	 YxRVmoBRFgvIAyRNPx8WtGhKod3lxipNxzhcakXuVBlq/A/KM3UHqGWZfZawZGWyIM
	 VFcftMT9qo+5sqKBuKRMOg01XJt5o5O6p9snfno1qZ43yf8nEKzxdRmypjfSeuBu3T
	 abtUK9inLRl0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19D334036A;
	Sun,  9 Aug 2026 23:27:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3655B10E
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 23:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3367C40057
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 23:27:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C4vjBnUbfyU7 for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 23:27:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 17FD14004E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 17FD14004E
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 17FD14004E
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 23:27:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRCJ3AAG/YLkTUpzciylQkkEPhTRn6B/LT+pikse2wh3M+VwMwdOJXRKTMM/q4n03ruHj6QyrZEjXrs7RnQE2Ioj/CkUdU/jxv74k495V3LILD/iqBikIqg6P72UIkTkwXMCYqVRUas5oKepRCU9TnjUvqtLlLsnv2J+/0aUVLadJnpNvpT6t2FUswozrKTzGMp/+myHlPvdV8mWNpIYz1PsGFt60sSF6HkTWYzhGAiFVr5+d5I1LM5WzDDpA0Sx0Jgyb/HrJbEeIaWKyR7UfNVAjgVUrxBTKVxU8CF+AFu13hwBzBurZ3GyQIB6QoGXt0rZn23G/2gZjLkIP2UpIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdtTFscdOlujmVEbcHrq0voef4LfOA+WMsAiG2AKwpg=;
 b=YcstaKqWwuBm+qDFgn99FPV1IuW8QL4vZ6k1YmOurPLOtK5xPZ2/wwui2WN4hMcetYdn5Eej0HALH1ddPQq0SeU6BPQwC0c4UGzlewRxT6fvnZJjnm5uy++CIXn1H1iZHZbQDFhess7E2AEgRcm67SjJ3axn8MBOg3dqVrFyHCn5u7LycL7JWl3Fk18KNw+yKE+6qR2a9W6zSNM0EkvMPa7W7XpVeDqWXsmtrlZgNWkgbLobm6tNJR98teF1SewQE0aT3QMeDyxkP/Nwsu1HSiOgglQjZ2gwoRMShYEZ4HwshgNrBVOs908ruwoV7b2p91wJo03t4jL52nwqnQU2Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AMBPR08MB11570.eurprd08.prod.outlook.com (2603:10a6:20b:6f3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sun, 9 Aug
 2026 23:27:40 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0292.024; Sun, 9 Aug 2026
 23:27:39 +0000
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 David Lechner <dlechner@baylibre.com>, u-boot@lists.u-boot-project.org,
 Markus Gothe <markus.gothe@genexis.eu>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH] pinctrl: airoha: sync with linux-7.3 driver
Date: Mon, 10 Aug 2026 02:27:26 +0300
Message-ID: <20260809232726.2436904-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DC00.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::30a) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AMBPR08MB11570:EE_
X-MS-Office365-Filtering-Correlation-Id: b5d714a3-5497-41bf-9fe7-08def66dcd90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|23010399003|10067099003|11063799006|56012099006|3023799007|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: a3XyYAf+GA0qT8uJfevft7tu7NA4sDgBv2VSbr3V37c2hdV/n5fk7W+JMViIvdZ7dot1eQT+ti8VjeHxYtnlXAF2WMmWfgIaLCAiVZ59qgD1XHA1k+k0fq/4/N2GmpPgWAGBsf9mr/NgkN1T2aVXvJL8/qe8KLk4Kzc7CiVEeabUa7aZUm8dv35I8a4rvX5FJsCnMcjVG8EXRFiTdLTrHgETajnnWzEPTCW8YK9NGMtMbg0l9qwPsNyazKM7WsgAKQRb+9QGLxfKGH38WWsCSArfJKvCXhUVn9RycEOh9rwUs8dRVWE6rCvLPw+dUKldeI6xaELfLgrtMkQAhX1Hl1m7LNrALcjQTDqR+gLuV0pSusBrlKAveOV/rj9ENiFnb2A1PACuJeq8XOa5OVAeknQRul8zhjGhOiOd4KLMDfZ8rPhoJj8wU9K8LURfmSvCa10kR50j/6jM/pUxPuArM4y/iNrVtMdNWQPEymOMCL0VCYxncioZ7p9YyAiNwY/hxe2vHAqw8bT8Vz14ZygauTSYMyo3T073Szh4LbofzKGc1OTDcu5efWXfBcTlmpZ0asrnugctO/HrH9KfhaAtgsscNBl2vUON9LxJmwoRYgIETVjkggVJUgT4GVg288y6kqVeomx8+VuH6q/pmZHao23+4f2ON93NxeB5I8zz9uBBrbPpeg0polNob6ivRNq7DBP5h0l+dva/vmejWSFVD+rxA6j2H5/tpDS32iTY3gI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(3023799007)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?COSWdLnBlXIOUxa5O8Zzla1+Ex99tDD7ir78zVJrfyz0FLj5TvsserJ9vhkz?=
 =?us-ascii?Q?LGvgPVmGCdDGX8pWsgbiaEeFjcCAxxKdgAKQqw3NDK6q2tvJ+AkcMnlQ37G6?=
 =?us-ascii?Q?pNvRVUP920z9lxK2AnVZjqEKGZcg5SLXdq3SLlEbl6hRghqzAOg1F2CrPWs2?=
 =?us-ascii?Q?7HjmAeQf5BopWLaCFZYBu2wji0sXA32xZ69pUEXNQQ6SM5LZLEpkG8a8TseW?=
 =?us-ascii?Q?kV6XDsHt6hnIUjPkBzX9jwP/Jg0SgGqxmFK2qmTR8x5ncPBWe2JuNq+xxWWp?=
 =?us-ascii?Q?iiSGJWROIS3X3QjYZIaFXQb1JqYnWGX4HXR/jHUHIAhvk3wPD+xhJ+7r1eCY?=
 =?us-ascii?Q?glngLDpfwHI2H86kgxn7GGhqsRK8jkILojNtGIg3F1oXkAP6A13juhNpegp5?=
 =?us-ascii?Q?lz+wG05AeRS55fjp75Hg+Q4sWYLJ0wxF0KQ9Q1tv/QkdVTyRdFwXEX96onnp?=
 =?us-ascii?Q?DXRnxqUx9fL7zJLDN6TWwdg2sbDAluRQEKcdNobXeMbOUJrA3zAPRY5ImO4x?=
 =?us-ascii?Q?m6XHMCcFJLjNNNT3dSmSQfk8rTv9vh3mSIxPY1vmZ+lM2ojy9yocJgF97Nvy?=
 =?us-ascii?Q?uiVarAbOkKHEVLXMYgWJY6WLJrBiA7mrQ4gaA9llyxe/ExI+rE6LbrE0Pklf?=
 =?us-ascii?Q?7SURo8DkJ7b9yzv0o4MSMdpzJF2Uo+IIy8nQl52qFC1Hu6ytNb0v0BzZYGNw?=
 =?us-ascii?Q?5HNGlEUi1bwqx/jLIs4KyeXbnhTjoK2q6lrZlITUZPiVj8OjFTJxIl0MNPML?=
 =?us-ascii?Q?xTyCLvNbDXHMB5GFnPxi9JVnP/yJOOulK0JMRh6ZpBR8OD1V+C/gPHC/5nKd?=
 =?us-ascii?Q?ZS5poSRtcPoqiv4l8efAXI8IcfruaCRudWqYb0NTTc83FK2jVjQ8zZ7ExOKG?=
 =?us-ascii?Q?nU55V+b+xEo39LTHqEKytdgXLPZXn2WdGcjN/Nx72s9NVYfJF21/QcmVApYk?=
 =?us-ascii?Q?RG9ThbZDceKpejYV6BeDiH7lbz7zJpgfkubjBExNHas252rWbnLmpw/gy6Rw?=
 =?us-ascii?Q?8MkC/G6pnZK0Qiph3vjMjlPYo2RK08zIi0/IRv9oqbGFOHmu3rjRkoHXdZ33?=
 =?us-ascii?Q?3+aPbdUbC/uBuTDks/CqdsMpk6EodU2+uRY4nqlDm/I89am2Z1qVwFufcgcI?=
 =?us-ascii?Q?UXI0CeeC2WS3vU+NmBUBLJjCZ9Cx6qtZxI0F52rocKOW9S6X/akNaPBeWuUm?=
 =?us-ascii?Q?dqc0vLlrzeAjOTgXuPgcuy8Lc/nbqL8Wje+4oyVss3lEvlvtPCMiwyOBAxHT?=
 =?us-ascii?Q?IGvZBd2If2wKXa/goR1EB55t50+nWOcvEx9B8xEJ7kBDoR1x1zENT3JT2BiH?=
 =?us-ascii?Q?EQEOPjZBT7wCtbgZs1kDPAb+Nbj/vn444Hv8B/Gz7AyDCAaNTZEp1311r/GP?=
 =?us-ascii?Q?JuXhnfjq7wrCzCbWbb8OhTkxN4nbzOCQT4T523ymuEg0ChL1RFfXbXl8qelD?=
 =?us-ascii?Q?4a4cjqScKgnZtyucGnF4Yb9XDzQxbyC8aLPzBsXwh3Cd5J4vKD+rayMiZbd+?=
 =?us-ascii?Q?EfZRvcGL4pIu1Zm8Feqhl+3mMFJ6j2FACXHVtrYXrNvpOH+/3poUPDjzyC6/?=
 =?us-ascii?Q?WW3IGH+DIyYU1JiMPPaPGdp5Cm1Yn+YHqpZKphQxOOh/zq2K7uIvVMl0NPea?=
 =?us-ascii?Q?A5Xi+yD2bKZ4UlfUn5WXD20azsdPmFJnoSKTYMIvdi9w5RYJGuMAAiSIFy3Q?=
 =?us-ascii?Q?oWChuBP6Canz6NKuslCh0n53lCZnNfiSu9N1POvdeTf0w5n5FrLWIx6gsu3V?=
 =?us-ascii?Q?wpRi+ZbSJiLdaFi3LI7PDg8Lrpq/kPo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d714a3-5497-41bf-9fe7-08def66dcd90
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2026 23:27:39.6583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNCdaenZGeP6ag/T7ID5okiAZmsXNqDO78XLsBjz8Q9r8MDKU3wDKRKt7jF5D9zCPUR8k1Ws7qmN2be0cwiCM1nP2QtXoesiCTxejAbU2Ds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB11570
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdtTFscdOlujmVEbcHrq0voef4LfOA+WMsAiG2AKwpg=;
 b=DhNzW7M0WIhSdfBOPp9rlQ7ZGVPghdWxteAvhr/j8pplosZ9P00cvLd9qh4/0zGthPyD1TNz12RzobQabq12I2j0sY+VOIV0Z+3v7BSANHbW/5hxQg8hwDETM/6Eyocs5jfMfJaW/6LvvrdmJkvlb4rsMWSa9/XMIpDx/bsGXYUm2tMLty0S24SGis54ZSlZDBSXA/1wyizoV8l/P73oasAoGCnRCSDYDRkubwe/+CiLYz7qxMoqzzWWLqFdbcq8aS2chK1yRklOjniKfaRq17ITJkHRL1gTfW0hoYwU8x6rJFYwnzm8K4KGP0C8qCVRlhnP3E/OR1oFLIBtd/Wu6A==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=iopsys.eu
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=DhNzW7M0
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Mikhail Kshevetskiy via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The code was synced with linux-pinctrl/for-next (future linux-7.3) branch.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/pinctrl/airoha/airoha-common.h  | 27 +---------
 drivers/pinctrl/airoha/pinctrl-airoha.c | 66 ++++++++++++++++---------
 drivers/pinctrl/airoha/pinctrl-an7581.c | 20 ++++----
 drivers/pinctrl/airoha/pinctrl-an7583.c | 42 +++++++++++-----
 drivers/pinctrl/airoha/pinctrl-en7523.c | 48 +++++++++++++++---
 5 files changed, 126 insertions(+), 77 deletions(-)

diff --git a/drivers/pinctrl/airoha/airoha-common.h b/drivers/pinctrl/airoha/airoha-common.h
index 4354b0eb6b4..c8bbc893d42 100644
--- a/drivers/pinctrl/airoha/airoha-common.h
+++ b/drivers/pinctrl/airoha/airoha-common.h
@@ -10,26 +10,6 @@
 #include <dm/device.h>
 #include <dm/pinctrl.h>
 
-/* GPIOs */
-#define REG_GPIO_CTRL				0x0000
-#define REG_GPIO_DATA				0x0004
-#define REG_GPIO_INT				0x0008
-#define REG_GPIO_INT_EDGE			0x000c
-#define REG_GPIO_INT_LEVEL			0x0010
-#define REG_GPIO_OE				0x0014
-#define REG_GPIO_CTRL1				0x0020
-#define REG_GPIO_CTRL2				0x0060
-#define REG_GPIO_CTRL3				0x0064
-#define REG_GPIO_DATA1				0x0070
-#define REG_GPIO_OE1				0x0078
-#define REG_GPIO_INT1				0x007c
-#define REG_GPIO_INT_EDGE1			0x0080
-#define REG_GPIO_INT_EDGE2			0x0084
-#define REG_GPIO_INT_EDGE3			0x0088
-#define REG_GPIO_INT_LEVEL1			0x008c
-#define REG_GPIO_INT_LEVEL2			0x0090
-#define REG_GPIO_INT_LEVEL3			0x0094
-
 #define AIROHA_NUM_PINS				64
 #define AIROHA_PIN_BANK_SIZE			(AIROHA_NUM_PINS / 2)
 #define AIROHA_REG_GPIOCTRL_NUM_PIN		(AIROHA_NUM_PINS / 4)
@@ -84,7 +64,7 @@ struct airoha_pinctrl_conf {
 	struct airoha_pinctrl_reg reg;
 };
 
-struct airoha_pinctrl_gpiochip {
+struct airoha_gpiochip_regs {
 	/* gpio */
 	const u32 *data;
 	const u32 *dir;
@@ -93,8 +73,6 @@ struct airoha_pinctrl_gpiochip {
 	const u32 *status;
 	const u32 *level;
 	const u32 *edge;
-
-	u32 irq_type[AIROHA_NUM_PINS];
 };
 
 struct airoha_pinctrl_confs_info {
@@ -119,8 +97,7 @@ struct airoha_pinctrl {
 	struct regmap *regmap;
 
 	struct airoha_pinctrl_match_data *data;
-
-	struct airoha_pinctrl_gpiochip gpiochip;
+	struct airoha_gpiochip_regs *gpio_regs;
 };
 
 struct airoha_pinctrl_match_data {
diff --git a/drivers/pinctrl/airoha/pinctrl-airoha.c b/drivers/pinctrl/airoha/pinctrl-airoha.c
index 60c48c0960c..6245f116bd2 100644
--- a/drivers/pinctrl/airoha/pinctrl-airoha.c
+++ b/drivers/pinctrl/airoha/pinctrl-airoha.c
@@ -18,6 +18,26 @@
 
 #include "airoha-common.h"
 
+/* GPIOs */
+#define REG_GPIO_CTRL				0x0000
+#define REG_GPIO_DATA				0x0004
+#define REG_GPIO_INT				0x0008
+#define REG_GPIO_INT_EDGE			0x000c
+#define REG_GPIO_INT_LEVEL			0x0010
+#define REG_GPIO_OE				0x0014
+#define REG_GPIO_CTRL1				0x0020
+#define REG_GPIO_CTRL2				0x0060
+#define REG_GPIO_CTRL3				0x0064
+#define REG_GPIO_DATA1				0x0070
+#define REG_GPIO_OE1				0x0078
+#define REG_GPIO_INT1				0x007c
+#define REG_GPIO_INT_EDGE1			0x0080
+#define REG_GPIO_INT_EDGE2			0x0084
+#define REG_GPIO_INT_EDGE3			0x0088
+#define REG_GPIO_INT_LEVEL1			0x008c
+#define REG_GPIO_INT_LEVEL2			0x0090
+#define REG_GPIO_INT_LEVEL3			0x0094
+
 #define airoha_pinctrl_get_pullup_conf(pinctrl, pin, val)			\
 	airoha_pinctrl_get_conf((pinctrl), AIROHA_PINCTRL_CONFS_PULLUP,		\
 				(pin), (val))
@@ -85,6 +105,15 @@ static const u32 irq_edge_regs[] = {
 	REG_GPIO_INT_EDGE3
 };
 
+static struct airoha_gpiochip_regs airoha_gpiochip_regs = {
+	.data = gpio_data_regs,
+	.dir = gpio_dir_regs,
+	.out = gpio_out_regs,
+	.status = irq_status_regs,
+	.level = irq_level_regs,
+	.edge = irq_edge_regs,
+};
+
 static int pin_in_group(unsigned int pin, const struct pingroup *grp)
 {
 	for (int i = 0; i < grp->npins; i++) {
@@ -114,7 +143,7 @@ static int airoha_gpio_set(struct airoha_pinctrl *pinctrl, unsigned int gpio,
 	u8 index = gpio / AIROHA_PIN_BANK_SIZE;
 
 	return regmap_update_bits(pinctrl->regmap,
-				  pinctrl->gpiochip.data[index],
+				  pinctrl->gpio_regs->data[index],
 				  BIT(offset), value ? BIT(offset) : 0);
 }
 
@@ -125,28 +154,24 @@ static int airoha_gpio_get(struct airoha_pinctrl *pinctrl, unsigned int gpio)
 	int err;
 
 	err = regmap_read(pinctrl->regmap,
-			  pinctrl->gpiochip.data[index], &val);
+			  pinctrl->gpio_regs->data[index], &val);
 
 	return err ? err : !!(val & BIT(pin));
 }
 
 static int airoha_gpio_get_direction(struct airoha_pinctrl *pinctrl, unsigned int gpio)
 {
-	u32 mask, index, val;
-	int err, field_shift;
+	u32 val, mask;
+	u8 index;
+	int err;
 
-	field_shift = 2 * (gpio % AIROHA_REG_GPIOCTRL_NUM_PIN);
-	mask = GENMASK(field_shift + 1, field_shift);
 	index = gpio / AIROHA_REG_GPIOCTRL_NUM_PIN;
-
 	err = regmap_read(pinctrl->regmap,
-			  pinctrl->gpiochip.dir[index], &val);
+			  pinctrl->gpio_regs->dir[index], &val);
 	if (err)
 		return err;
 
-	if ((val & mask) > BIT(field_shift))
-		return -EINVAL;
-
+	mask = BIT(2 * (gpio % AIROHA_REG_GPIOCTRL_NUM_PIN));
 	return (val & mask) ? GPIOF_OUTPUT : GPIOF_INPUT;
 }
 
@@ -154,24 +179,24 @@ static int airoha_gpio_set_direction(struct airoha_pinctrl *pinctrl,
 				     unsigned int gpio, bool input)
 {
 	u32 mask, index;
-	int err, field_shift;
+	int err;
 
 	/* set output enable */
 	mask = BIT(gpio % AIROHA_PIN_BANK_SIZE);
 	index = gpio / AIROHA_PIN_BANK_SIZE;
-	err = regmap_update_bits(pinctrl->regmap, pinctrl->gpiochip.out[index],
+	err = regmap_update_bits(pinctrl->regmap,
+				 pinctrl->gpio_regs->out[index],
 				 mask, !input ? mask : 0);
 	if (err)
 		return err;
 
 	/* set direction */
-	field_shift = 2 * (gpio % AIROHA_REG_GPIOCTRL_NUM_PIN);
-	mask = GENMASK(field_shift + 1, field_shift);
+	mask = BIT(2 * (gpio % AIROHA_REG_GPIOCTRL_NUM_PIN));
 	index = gpio / AIROHA_REG_GPIOCTRL_NUM_PIN;
 
 	return regmap_update_bits(pinctrl->regmap,
-				  pinctrl->gpiochip.dir[index],
-				  mask, !input ? BIT(field_shift) : 0);
+				  pinctrl->gpio_regs->dir[index], mask,
+				  !input ? mask : 0);
 }
 
 /* pinmux callbacks */
@@ -932,12 +957,7 @@ int airoha_pinctrl_probe(struct udevice *dev)
 	if (IS_ERR(pinctrl->chip_scu))
 		return PTR_ERR(pinctrl->chip_scu);
 
-	pinctrl->gpiochip.data   = gpio_data_regs;
-	pinctrl->gpiochip.dir    = gpio_dir_regs;
-	pinctrl->gpiochip.out    = gpio_out_regs;
-	pinctrl->gpiochip.status = irq_status_regs;
-	pinctrl->gpiochip.level  = irq_level_regs;
-	pinctrl->gpiochip.edge   = irq_edge_regs;
+	pinctrl->gpio_regs = &airoha_gpiochip_regs;
 
 	return 0;
 }
diff --git a/drivers/pinctrl/airoha/pinctrl-an7581.c b/drivers/pinctrl/airoha/pinctrl-an7581.c
index 4f7da74a1cf..5b6e77095ec 100644
--- a/drivers/pinctrl/airoha/pinctrl-an7581.c
+++ b/drivers/pinctrl/airoha/pinctrl-an7581.c
@@ -759,8 +759,8 @@ static const struct airoha_pinctrl_func_group i2c_func_group[] = {
 		.regmap[0] = {
 			AIROHA_FUNC_MUX,
 			REG_GPIO_2ND_I2C_MODE,
-			GPIO_2ND_I2C_MODE_MASK,
-			GPIO_2ND_I2C_MODE_MASK
+			GPIO_2ND_I2C_MODE_MASK | GPIO_I2C_MASTER_MODE_MODE,
+			GPIO_2ND_I2C_MODE_MASK | GPIO_I2C_MASTER_MODE_MODE
 		},
 		.regmap_size = 1,
 	},
@@ -1184,8 +1184,8 @@ static const struct airoha_pinctrl_func pinctrl_funcs[] = {
 static const struct airoha_pinctrl_conf pinctrl_pullup_conf[] = {
 	PINCTRL_CONF_DESC(0, REG_I2C_SDA_PU, UART1_TXD_PU_MASK),
 	PINCTRL_CONF_DESC(1, REG_I2C_SDA_PU, UART1_RXD_PU_MASK),
-	PINCTRL_CONF_DESC(2, REG_I2C_SDA_PU, I2C_SDA_PU_MASK),
-	PINCTRL_CONF_DESC(3, REG_I2C_SDA_PU, I2C_SCL_PU_MASK),
+	PINCTRL_CONF_DESC(2, REG_I2C_SDA_PU, I2C_SCL_PU_MASK),
+	PINCTRL_CONF_DESC(3, REG_I2C_SDA_PU, I2C_SDA_PU_MASK),
 	PINCTRL_CONF_DESC(4, REG_I2C_SDA_PU, SPI_CS0_PU_MASK),
 	PINCTRL_CONF_DESC(5, REG_I2C_SDA_PU, SPI_CLK_PU_MASK),
 	PINCTRL_CONF_DESC(6, REG_I2C_SDA_PU, SPI_MOSI_PU_MASK),
@@ -1245,8 +1245,8 @@ static const struct airoha_pinctrl_conf pinctrl_pullup_conf[] = {
 static const struct airoha_pinctrl_conf pinctrl_pulldown_conf[] = {
 	PINCTRL_CONF_DESC(0, REG_I2C_SDA_PD, UART1_TXD_PD_MASK),
 	PINCTRL_CONF_DESC(1, REG_I2C_SDA_PD, UART1_RXD_PD_MASK),
-	PINCTRL_CONF_DESC(2, REG_I2C_SDA_PD, I2C_SDA_PD_MASK),
-	PINCTRL_CONF_DESC(3, REG_I2C_SDA_PD, I2C_SCL_PD_MASK),
+	PINCTRL_CONF_DESC(2, REG_I2C_SDA_PD, I2C_SCL_PD_MASK),
+	PINCTRL_CONF_DESC(3, REG_I2C_SDA_PD, I2C_SDA_PD_MASK),
 	PINCTRL_CONF_DESC(4, REG_I2C_SDA_PD, SPI_CS0_PD_MASK),
 	PINCTRL_CONF_DESC(5, REG_I2C_SDA_PD, SPI_CLK_PD_MASK),
 	PINCTRL_CONF_DESC(6, REG_I2C_SDA_PD, SPI_MOSI_PD_MASK),
@@ -1306,8 +1306,8 @@ static const struct airoha_pinctrl_conf pinctrl_pulldown_conf[] = {
 static const struct airoha_pinctrl_conf pinctrl_drive_e2_conf[] = {
 	PINCTRL_CONF_DESC(0, REG_I2C_SDA_E2, UART1_TXD_E2_MASK),
 	PINCTRL_CONF_DESC(1, REG_I2C_SDA_E2, UART1_RXD_E2_MASK),
-	PINCTRL_CONF_DESC(2, REG_I2C_SDA_E2, I2C_SDA_E2_MASK),
-	PINCTRL_CONF_DESC(3, REG_I2C_SDA_E2, I2C_SCL_E2_MASK),
+	PINCTRL_CONF_DESC(2, REG_I2C_SDA_E2, I2C_SCL_E2_MASK),
+	PINCTRL_CONF_DESC(3, REG_I2C_SDA_E2, I2C_SDA_E2_MASK),
 	PINCTRL_CONF_DESC(4, REG_I2C_SDA_E2, SPI_CS0_E2_MASK),
 	PINCTRL_CONF_DESC(5, REG_I2C_SDA_E2, SPI_CLK_E2_MASK),
 	PINCTRL_CONF_DESC(6, REG_I2C_SDA_E2, SPI_MOSI_E2_MASK),
@@ -1367,8 +1367,8 @@ static const struct airoha_pinctrl_conf pinctrl_drive_e2_conf[] = {
 static const struct airoha_pinctrl_conf pinctrl_drive_e4_conf[] = {
 	PINCTRL_CONF_DESC(0, REG_I2C_SDA_E4, UART1_TXD_E4_MASK),
 	PINCTRL_CONF_DESC(1, REG_I2C_SDA_E4, UART1_RXD_E4_MASK),
-	PINCTRL_CONF_DESC(2, REG_I2C_SDA_E4, I2C_SDA_E4_MASK),
-	PINCTRL_CONF_DESC(3, REG_I2C_SDA_E4, I2C_SCL_E4_MASK),
+	PINCTRL_CONF_DESC(2, REG_I2C_SDA_E4, I2C_SCL_E4_MASK),
+	PINCTRL_CONF_DESC(3, REG_I2C_SDA_E4, I2C_SDA_E4_MASK),
 	PINCTRL_CONF_DESC(4, REG_I2C_SDA_E4, SPI_CS0_E4_MASK),
 	PINCTRL_CONF_DESC(5, REG_I2C_SDA_E4, SPI_CLK_E4_MASK),
 	PINCTRL_CONF_DESC(6, REG_I2C_SDA_E4, SPI_MOSI_E4_MASK),
diff --git a/drivers/pinctrl/airoha/pinctrl-an7583.c b/drivers/pinctrl/airoha/pinctrl-an7583.c
index 2f6f3651ec8..96864f19141 100644
--- a/drivers/pinctrl/airoha/pinctrl-an7583.c
+++ b/drivers/pinctrl/airoha/pinctrl-an7583.c
@@ -399,7 +399,8 @@ static const int pon_tod_1pps_pins[] = { 32 };
 static const int gsw_tod_1pps_pins[] = { 32 };
 static const int sipo_pins[] = { 34, 35 };
 static const int sipo_rclk_pins[] = { 34, 35, 33 };
-static const int mdio_pins[] = { 43, 44 };
+static const int mdio_pins[] = { 53, 54 };
+static const int mdio1_pins[] = { 43, 44 };
 static const int uart2_pins[] = { 34, 35 };
 static const int uart2_cts_rts_pins[] = { 32, 33 };
 static const int hsuart_pins[] = { 30, 31 };
@@ -413,7 +414,7 @@ static const int jtag_udi_pins[] = { 23, 24, 22, 25, 26 };
 static const int jtag_dfd_pins[] = { 23, 24, 22, 25, 26 };
 static const int pcm1_pins[] = { 10, 11, 12, 13, 14 };
 static const int pcm2_pins[] = { 28, 29, 30, 31, 24 };
-static const int spi_pins[] = { 28, 29, 30, 31 };
+static const int spi_pins[] = { 45, 46, 47, 48 };
 static const int spi_quad_pins[] = { 25, 26 };
 static const int spi_cs1_pins[] = { 27 };
 static const int pcm_spi_pins[] = { 28, 29, 30, 31, 10, 11, 12, 13 };
@@ -490,6 +491,7 @@ static const struct pingroup pinctrl_groups[] = {
 	PINCTRL_PIN_GROUP("sipo", sipo),
 	PINCTRL_PIN_GROUP("sipo_rclk", sipo_rclk),
 	PINCTRL_PIN_GROUP("mdio", mdio),
+	PINCTRL_PIN_GROUP("mdio1", mdio1),
 	PINCTRL_PIN_GROUP("uart2", uart2),
 	PINCTRL_PIN_GROUP("uart2_cts_rts", uart2_cts_rts),
 	PINCTRL_PIN_GROUP("hsuart", hsuart),
@@ -579,6 +581,7 @@ static const char *const uart_groups[] = {
 	"uart2", "uart2_cts_rts", "hsuart", "hsuart_cts_rts",
 	"uart4", "uart5", "npu_uart"
 };
+static const char *const i2c_groups[] = { "i2c0", "i2c1" };
 static const char *const jtag_groups[] = { "jtag_udi", "jtag_dfd" };
 static const char *const pcm_groups[] = { "pcm1", "pcm2" };
 static const char *const spi_groups[] = { "spi_quad", "spi_cs1" };
@@ -715,16 +718,10 @@ static const struct airoha_pinctrl_func_group mdio_func_group[] = {
 		.regmap[0] = {
 			AIROHA_FUNC_MUX,
 			REG_GPIO_PON_MODE,
-			GPIO_SGMII_MDIO_MODE_MASK,
-			GPIO_SGMII_MDIO_MODE_MASK
-		},
-		.regmap[1] = {
-			AIROHA_FUNC_MUX,
-			REG_GPIO_SPI_CS1_MODE,
-			GPIO_MDC_IO_MASTER_MODE_MASK,
-			GPIO_MDC_IO_MASTER_MODE_MASK
+			MDC_0_GPIO_MODE_MASK | MDIO_0_GPIO_MODE_MASK,
+			0
 		},
-		.regmap_size = 2,
+		.regmap_size = 1,
 	},
 };
 
@@ -796,6 +793,28 @@ static const struct airoha_pinctrl_func_group uart_func_group[] = {
 	},
 };
 
+static const struct airoha_pinctrl_func_group i2c_func_group[] = {
+	{
+		.name = "i2c0",
+		.regmap[0] = {
+			AIROHA_FUNC_MUX,
+			REG_GPIO_PON_MODE,
+			I2C0_SCL_GPIO_MODE_MASK | I2C0_SDA_GPIO_MODE_MASK,
+			0
+		},
+		.regmap_size = 1,
+	}, {
+		.name = "i2c1",
+		.regmap[0] = {
+			AIROHA_FUNC_MUX,
+			REG_GPIO_PON_MODE,
+			I2C1_SCL_GPIO_MODE_MASK | I2C1_SDA_GPIO_MODE_MASK,
+			0
+		},
+		.regmap_size = 1,
+	},
+};
+
 static const struct airoha_pinctrl_func_group jtag_func_group[] = {
 	{
 		.name = "jtag_udi",
@@ -1193,6 +1212,7 @@ static const struct airoha_pinctrl_func pinctrl_funcs[] = {
 	PINCTRL_FUNC_DESC("sipo", sipo),
 	PINCTRL_FUNC_DESC("mdio", mdio),
 	PINCTRL_FUNC_DESC("uart", uart),
+	PINCTRL_FUNC_DESC("i2c", i2c),
 	PINCTRL_FUNC_DESC("jtag", jtag),
 	PINCTRL_FUNC_DESC("pcm", pcm),
 	PINCTRL_FUNC_DESC("spi", spi),
diff --git a/drivers/pinctrl/airoha/pinctrl-en7523.c b/drivers/pinctrl/airoha/pinctrl-en7523.c
index 958fcc8418f..f0bb80ffa9b 100644
--- a/drivers/pinctrl/airoha/pinctrl-en7523.c
+++ b/drivers/pinctrl/airoha/pinctrl-en7523.c
@@ -940,6 +940,14 @@ static const struct airoha_pinctrl_func pinctrl_funcs[] = {
 };
 
 static const struct airoha_pinctrl_conf pinctrl_pullup_conf[] = {
+	PINCTRL_CONF_DESC(2, REG_I2C_SDA_PU, I2C_SDA_PU_MASK),
+	PINCTRL_CONF_DESC(3, REG_I2C_SDA_PU, I2C_SCL_PU_MASK),
+	PINCTRL_CONF_DESC(4, REG_I2C_SDA_PU, SPI_CS0_PU_MASK),
+	PINCTRL_CONF_DESC(5, REG_I2C_SDA_PU, SPI_CLK_PU_MASK),
+	PINCTRL_CONF_DESC(6, REG_I2C_SDA_PU, SPI_MOSI_PU_MASK),
+	PINCTRL_CONF_DESC(7, REG_I2C_SDA_PU, SPI_MISO_PU_MASK),
+	PINCTRL_CONF_DESC(8, REG_I2C_SDA_PU, UART1_TXD_PU_MASK),
+	PINCTRL_CONF_DESC(9, REG_I2C_SDA_PU, UART1_RXD_PU_MASK),
 	PINCTRL_CONF_DESC(12, REG_GPIO_L_PU, BIT(0)),
 	PINCTRL_CONF_DESC(13, REG_GPIO_L_PU, BIT(1)),
 	PINCTRL_CONF_DESC(14, REG_GPIO_L_PU, BIT(2)),
@@ -968,11 +976,19 @@ static const struct airoha_pinctrl_conf pinctrl_pullup_conf[] = {
 	PINCTRL_CONF_DESC(37, REG_GPIO_L_PU, BIT(25)),
 	PINCTRL_CONF_DESC(38, REG_GPIO_L_PU, BIT(26)),
 	PINCTRL_CONF_DESC(39, REG_GPIO_L_PU, BIT(27)),
-	PINCTRL_CONF_DESC(40, REG_GPIO_L_PU, BIT(28)),
-	PINCTRL_CONF_DESC(41, REG_GPIO_L_PU, BIT(29)),
+	PINCTRL_CONF_DESC(40, REG_I2C_SDA_PU, PCIE0_RESET_PU_MASK),
+	PINCTRL_CONF_DESC(41, REG_I2C_SDA_PU, PCIE1_RESET_PU_MASK),
 };
 
 static const struct airoha_pinctrl_conf pinctrl_pulldown_conf[] = {
+	PINCTRL_CONF_DESC(2, REG_I2C_SDA_PD, I2C_SDA_PD_MASK),
+	PINCTRL_CONF_DESC(3, REG_I2C_SDA_PD, I2C_SCL_PD_MASK),
+	PINCTRL_CONF_DESC(4, REG_I2C_SDA_PD, SPI_CS0_PD_MASK),
+	PINCTRL_CONF_DESC(5, REG_I2C_SDA_PD, SPI_CLK_PD_MASK),
+	PINCTRL_CONF_DESC(6, REG_I2C_SDA_PD, SPI_MOSI_PD_MASK),
+	PINCTRL_CONF_DESC(7, REG_I2C_SDA_PD, SPI_MISO_PD_MASK),
+	PINCTRL_CONF_DESC(8, REG_I2C_SDA_PD, UART1_TXD_PD_MASK),
+	PINCTRL_CONF_DESC(9, REG_I2C_SDA_PD, UART1_RXD_PD_MASK),
 	PINCTRL_CONF_DESC(12, REG_GPIO_L_PD, BIT(0)),
 	PINCTRL_CONF_DESC(13, REG_GPIO_L_PD, BIT(1)),
 	PINCTRL_CONF_DESC(14, REG_GPIO_L_PD, BIT(2)),
@@ -1001,11 +1017,19 @@ static const struct airoha_pinctrl_conf pinctrl_pulldown_conf[] = {
 	PINCTRL_CONF_DESC(37, REG_GPIO_L_PD, BIT(25)),
 	PINCTRL_CONF_DESC(38, REG_GPIO_L_PD, BIT(26)),
 	PINCTRL_CONF_DESC(39, REG_GPIO_L_PD, BIT(27)),
-	PINCTRL_CONF_DESC(40, REG_GPIO_L_PD, BIT(28)),
-	PINCTRL_CONF_DESC(41, REG_GPIO_L_PD, BIT(29)),
+	PINCTRL_CONF_DESC(40, REG_I2C_SDA_PD, PCIE0_RESET_PD_MASK),
+	PINCTRL_CONF_DESC(41, REG_I2C_SDA_PD, PCIE1_RESET_PD_MASK),
 };
 
 static const struct airoha_pinctrl_conf pinctrl_drive_e2_conf[] = {
+	PINCTRL_CONF_DESC(2, REG_I2C_SDA_E2, I2C_SDA_E2_MASK),
+	PINCTRL_CONF_DESC(3, REG_I2C_SDA_E2, I2C_SCL_E2_MASK),
+	PINCTRL_CONF_DESC(4, REG_I2C_SDA_E2, SPI_CS0_E2_MASK),
+	PINCTRL_CONF_DESC(5, REG_I2C_SDA_E2, SPI_CLK_E2_MASK),
+	PINCTRL_CONF_DESC(6, REG_I2C_SDA_E2, SPI_MOSI_E2_MASK),
+	PINCTRL_CONF_DESC(7, REG_I2C_SDA_E2, SPI_MISO_E2_MASK),
+	PINCTRL_CONF_DESC(8, REG_I2C_SDA_E2, UART1_TXD_E2_MASK),
+	PINCTRL_CONF_DESC(9, REG_I2C_SDA_E2, UART1_RXD_E2_MASK),
 	PINCTRL_CONF_DESC(12, REG_GPIO_L_E2, BIT(0)),
 	PINCTRL_CONF_DESC(13, REG_GPIO_L_E2, BIT(1)),
 	PINCTRL_CONF_DESC(14, REG_GPIO_L_E2, BIT(2)),
@@ -1034,11 +1058,19 @@ static const struct airoha_pinctrl_conf pinctrl_drive_e2_conf[] = {
 	PINCTRL_CONF_DESC(37, REG_GPIO_L_E2, BIT(25)),
 	PINCTRL_CONF_DESC(38, REG_GPIO_L_E2, BIT(26)),
 	PINCTRL_CONF_DESC(39, REG_GPIO_L_E2, BIT(27)),
-	PINCTRL_CONF_DESC(40, REG_GPIO_L_E2, BIT(28)),
-	PINCTRL_CONF_DESC(41, REG_GPIO_L_E2, BIT(29)),
+	PINCTRL_CONF_DESC(40, REG_I2C_SDA_E2, PCIE0_RESET_E2_MASK),
+	PINCTRL_CONF_DESC(41, REG_I2C_SDA_E2, PCIE1_RESET_E2_MASK),
 };
 
 static const struct airoha_pinctrl_conf pinctrl_drive_e4_conf[] = {
+	PINCTRL_CONF_DESC(2, REG_I2C_SDA_E4, I2C_SDA_E4_MASK),
+	PINCTRL_CONF_DESC(3, REG_I2C_SDA_E4, I2C_SCL_E4_MASK),
+	PINCTRL_CONF_DESC(4, REG_I2C_SDA_E4, SPI_CS0_E4_MASK),
+	PINCTRL_CONF_DESC(5, REG_I2C_SDA_E4, SPI_CLK_E4_MASK),
+	PINCTRL_CONF_DESC(6, REG_I2C_SDA_E4, SPI_MOSI_E4_MASK),
+	PINCTRL_CONF_DESC(7, REG_I2C_SDA_E4, SPI_MISO_E4_MASK),
+	PINCTRL_CONF_DESC(8, REG_I2C_SDA_E4, UART1_TXD_E4_MASK),
+	PINCTRL_CONF_DESC(9, REG_I2C_SDA_E4, UART1_RXD_E4_MASK),
 	PINCTRL_CONF_DESC(12, REG_GPIO_L_E4, BIT(0)),
 	PINCTRL_CONF_DESC(13, REG_GPIO_L_E4, BIT(1)),
 	PINCTRL_CONF_DESC(14, REG_GPIO_L_E4, BIT(2)),
@@ -1067,8 +1099,8 @@ static const struct airoha_pinctrl_conf pinctrl_drive_e4_conf[] = {
 	PINCTRL_CONF_DESC(37, REG_GPIO_L_E4, BIT(25)),
 	PINCTRL_CONF_DESC(38, REG_GPIO_L_E4, BIT(26)),
 	PINCTRL_CONF_DESC(39, REG_GPIO_L_E4, BIT(27)),
-	PINCTRL_CONF_DESC(40, REG_GPIO_L_E4, BIT(28)),
-	PINCTRL_CONF_DESC(41, REG_GPIO_L_E4, BIT(29)),
+	PINCTRL_CONF_DESC(40, REG_I2C_SDA_E4, PCIE0_RESET_E4_MASK),
+	PINCTRL_CONF_DESC(41, REG_I2C_SDA_E4, PCIE1_RESET_E4_MASK),
 };
 
 static const struct airoha_pinctrl_match_data pinctrl_match_data = {
-- 
2.53.0

