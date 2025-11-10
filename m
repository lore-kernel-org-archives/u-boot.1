Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6158CCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 17:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CBFA83A98;
	Mon, 10 Nov 2025 18:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="lpu4owsj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D53083A8D; Mon, 10 Nov 2025 18:37:57 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D2AB83A8D
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 18:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=df3uaOmYAp8Qv0B20B0b4rqFFIsjZrpykRN6l1e28qvOeup2HWJ6sPOtb+YVdYKTsNLRI1VzQeR3TEmUYruRHiHx8n76DNXjBy8N4ZDad7+aHnONcp6bJ7Zcx+Wwx+p/124rbSPY5/yusC7TrDSpK6VaSpgFO2eaoP0BTG1psrVQb7xtPO7AVYTg+CKOq2V8hR+NvlwD8WmYFpubA71WBH1Ky+3NZMvBmm425eozG8K9XPms6cy0hH19omX1IcfblhvcWd9RruA4AFcSS7UFX1XugtR+P239D38jb2fASthRNmi2CRiZD+9SzJJcntiaEGLRoQQnYXwIH+47K8A21g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Km6kGO8M2Zl0fD5g/1wrmIUZi2qKsWAdOUTt2Oo9L6E=;
 b=KEWMZG9tWgoH7/XKkI71E0X3+r5oL0B0eb046OAYtR1tVczmrGT5DiA7xI1lQCg32A+DAvC9WdCZmJ5J0N54P4GoOD1kWmt1d/zT0J/KcMy/tCoZjsrwUbg0XluWNMvb9eFy9zCRMCTDgovld7U7mFe+VxZhsc5zEOd3O+3PX9qJwAMFji11nb28A1aAy8b07xKLnAlrGsR+bIbidXwgI2gvyPLJkMf9NvRISTuFoKyDjFUAWCi3snhnSxX4WGK1LshjRBOar6fbk2vgt65OEOoqcUaI1leLXzhzP6pZszNVYQ5NM/6LRpNnG9BDttgMBvCAuX+KjxTRVOfAZ4wQjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Km6kGO8M2Zl0fD5g/1wrmIUZi2qKsWAdOUTt2Oo9L6E=;
 b=lpu4owsjp0Frwa8zrPEdTyeqP5VcVYSaQra9uvMAe+9dg01dNAo7t9b57Fcj19xZu711bCKp0gDIeTWr6r9HDFvIcCoBMjbcHR2xiRmXVcpgUi/BaDVK9dKWvI5BKatNDQUk3Jrx7ADnw8mjc1FzvsuYTvGSUVH+2LTnJLxriHtbdD52rflMirGChHW2QADnmNa+KQsPwBfQq16YRNE48ysdTSikxJ8i+QuFcjzlF9Wtl80jJPFW3emVGA1JqYZJL6go+9Lh1iUYuROUZG+OHLQIOaWd/7WnBvTc3mG8uO2AppjYCLB4RGmA7waIoEv9i8mS04cQa7pnyTzc0nQvwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DM4PR03MB5984.namprd03.prod.outlook.com (2603:10b6:5:38b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 17:37:53 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 17:37:53 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com,
 balsundar.ponnusamy@altera.com
Subject: [PATCH 6/8] mmc: sdhci-cadence: Enable software tuning for both SD
 and eMMC interfaces
Date: Mon, 10 Nov 2025 09:37:35 -0800
Message-Id: <20251110173737.24545-7-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
References: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DM4PR03MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c32906-4b55-43b0-9990-08de207fe02b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t0ormuxrVKKdSk5TJJ2vFiLUlYrpPQAclLA9qLdHQdHN8IQDLUCceJf2+VX9?=
 =?us-ascii?Q?EZI8FPjdOsNKY/3Br/GhISKwsZonBM5+k7tgGYSU1WSs6ZDqvJhA+jGY+X6F?=
 =?us-ascii?Q?sYBRtQo1qq6slgSxJ328Z9+dsSyeoJnvFPMJOyrvVQg+QCxTSkD0iiBzBtfn?=
 =?us-ascii?Q?BWfKRwjKuxaMGTm/homloe068xtWc7tlOYzjWTRyS/em+oRg6uY1HErxlRjN?=
 =?us-ascii?Q?mLGhDv2T6EVLungEPFXcIaZzvXvcW2xHoKnE7BovJt3jDS3dhnWBy9nqAAw3?=
 =?us-ascii?Q?VCrTKeqEQbHHBPH+7lA2FSq2+Oksw6tZbBzIj+Mnn2s+t50RkgiO2UkyRN7+?=
 =?us-ascii?Q?bcxjJBE5bwyBhTUmZtMwDJkG09FLSn3lcegxSc0g4g+BoQXSCb7StdBez2fe?=
 =?us-ascii?Q?F607jDNWWUKzXMnr0Js12d8dtxFmYyP4fd+8P1iAlnm8DagfxO0H3EjDedGS?=
 =?us-ascii?Q?QFkaqnfKslFLzMsdkpr5OnlaQ/fepgKbkPyPwpiORD0LjY/CqNTZXhEeWZap?=
 =?us-ascii?Q?BCFwaPG/hDTfD/Yrlmf9zbot7laJ0vb+AkSggYXkjWaxgoDF51YGcZpz82wG?=
 =?us-ascii?Q?mvRAHytT7YIuBhOKOrOZx/8zXKarFdahi+6bj2F0pd7QmuJ3qpZuATAyZ4Tw?=
 =?us-ascii?Q?71HQABYsnsgjqM+nLgMj8TJzygorvcEL6VO0Aj0okaKXj3jkNLOb3V32lcJM?=
 =?us-ascii?Q?nXY+Ib+DmlmMVyL4Ta0GnVoePgXdTIHLmhu89rXfU6lAq/oDRt0meiXM8poa?=
 =?us-ascii?Q?6ojOQ0P6ogdDOMibOkdo45oxR+UfJXbzlTanPDFt9ZOOyApOFY5LVleeImBh?=
 =?us-ascii?Q?hyJjD0x83kr0g3b61q3q56bNAN2g0iTprerOB6vU99KWEUCndJ1JoS2fcRKq?=
 =?us-ascii?Q?WUofQrnkFHqHjRPAZnsOpFLS7dQM2MQ7JwoCyLcweVOwJzQw49bUh63B3DHu?=
 =?us-ascii?Q?gtZMtsMp12YVKEkAcj0LB68IFj/dgr+ixgBV4A9Ju5oXQv0hyzxaEiw9KQVn?=
 =?us-ascii?Q?MzPJaumMq8ELHL2a/R+8w4VPNFUDdWKJmv1SJZAFfd8ePyL4sjq+SwN7ywsh?=
 =?us-ascii?Q?dS0kf6k1UQSVApcQtRrukg5WxgAsa4MKLbVmywD9lDLksSG0RZ2Xo4w0LHX5?=
 =?us-ascii?Q?KSOCBBAjnmkQMPBreNMtiG0bhRDsFE0v463UssY7gxM2Sw9guJwSgHCdkBIE?=
 =?us-ascii?Q?+bTNL+TkpbDM8NKawJ+qoPrPJpp8ZYv8H7ewdngmqx//+laKLwibMlyS/Y9+?=
 =?us-ascii?Q?lg14+341MQXPwaiKI3/sRDX6UpCaZV69JfNBvCGygBy94XMeVGBFkw/we+2A?=
 =?us-ascii?Q?vGyR8krpM85kZZIK2jlP2fOfh2Qdl7jIt79cxe3WBIrcC9iJmhYkDJFyUp+9?=
 =?us-ascii?Q?NdwKt4PAChl5xWsKTEk6ZSYQMpexByI3+iA+oLD2qBf5/vET6ZHsk9W5vMHW?=
 =?us-ascii?Q?ur2lNYi77uT/6Anjyx2jHibcOVs7nZFn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mudCNcd5/3kcitgokgiX/5XukmRIQYxodVFB6KWep117/9f51dlIE4jx/FP6?=
 =?us-ascii?Q?N9KLrb/6UKF7oZ7C/l08cOWnNBSA9c09B9dncR7uTsfI0C6WOlwbqABH8WbT?=
 =?us-ascii?Q?3iJfPfrRLoWI5f0MWAl8rOx5mosdZJYXOmuuviG9Xphbc+LnUgUAz8CrHCxE?=
 =?us-ascii?Q?ikcxZ90NkgsmWOdl6EqkRUGvwiSDGJYJtpiyp1G9NDe0h/EQ0mMwL6w2Dd3k?=
 =?us-ascii?Q?1ArLfp6PbKlrw8pA2Jse9s06xVR98uCXY494iMViDLGV0Ejluu2f2esYyex+?=
 =?us-ascii?Q?xWPWxUDhHyDUh0vtzgS2lXPc5+lzgDv6Bof34dcHoVxLGfm3V+NrHW0HBkeG?=
 =?us-ascii?Q?9N6F1qW9avRtS/nfjt63U9oK/fQEQvog91PUd5AXBengnCGJPp2vYJJTvOjF?=
 =?us-ascii?Q?LrTqQK6oGalaoq0ik10aENHaRWI/0EgQ3GidfQ14hoMmpIOTDfoZ2naIJ0Ga?=
 =?us-ascii?Q?yYPyzk1k+L0qh7+5GfS8mo20xdPQgEA4n8RafddmjsICVeAFXEGH4FS5gpR1?=
 =?us-ascii?Q?6uHT2kMKRL0LI64zJJO79XmZETCcVKLnvr+But3SV3NoHlj5WTThHqc3TCMK?=
 =?us-ascii?Q?/+ZHxJysntDZB2mwj++38VacTYVtYNtri9znnlg4E2D+CQL6hompR/R/dsFl?=
 =?us-ascii?Q?aeTLjGmBJ68Lw2XgF4DwuBJC7Ttmhl4974Ya8tDXGwH3MYg1AcingPSybkmm?=
 =?us-ascii?Q?BweXxIVwyh6qBDiMJrlskJmjJm3Wtm4zbTe5+LSuv0T1riDdBbWrp0WQhq8k?=
 =?us-ascii?Q?rY54GWHnhRpLL6Z4Mhswrg5cLV+aamXeVmgRSF4+5qj1azzFXG+aeE5uneOY?=
 =?us-ascii?Q?e2Pc3UppfyJaka3k8OneopoF+qtVzV/D4LStE8/gsTFk5EoGXN3dacVdHDbr?=
 =?us-ascii?Q?OS0qDqv3XMjfOxb8H7wmxwynxEQefHaXSLmXoKODwKN5yjy5SdBVopKm3cmM?=
 =?us-ascii?Q?X9qI6Ua4TutlU8LgtoXAc5NVlGuodMZSqjFu42LyTJfgH++ugxQ0aPVi4KM8?=
 =?us-ascii?Q?IZS4V6yTigpWa8kwX/QAiiUMywq+OEepHNKj7XTERbyQLVhifVffa/xAFJF5?=
 =?us-ascii?Q?YoCaHA9e+ebhcDVSQtUWb5iBBvslYXlC695j2FrPPgetunEniOjiCJ/uaxx5?=
 =?us-ascii?Q?tvggwom637XsCDBAdPMjKD/a1i69ODXee4CD2QUMq32BkPXtg/U7BDJ0+tst?=
 =?us-ascii?Q?t7t4Q5z2z46AIzaTrFCzNXXXiNhFRIkAh45xr133MzQkwT4OgIAcAMWXs7N0?=
 =?us-ascii?Q?MGaZJY1kyQdfjHDmLNTyGA3xPcQb/iwwG2rNRoBR7m8R9uc/JCvF4BnA3ejK?=
 =?us-ascii?Q?1RWpj4+xDyErITCo+CK9yU3LPkhCaxETHigugDVjDjHmEyJbEZiaE23fey5J?=
 =?us-ascii?Q?GzV1S1Y0CAqkD3KJszO+8ZOjbggYBeEwACxJ43MjnfkMd7Db4YndaBTgFvPA?=
 =?us-ascii?Q?5bdZuK2eBv8sugXr1g891jBlVC97TYN+0kgcTFkSTuqFZZihi6e+PMr3yAdn?=
 =?us-ascii?Q?YcsBCnaYgI2OxVXc6n4XkM4PThSL2xJ/O+JsQ1kYnlcvAhkbLzHxDrwGsBoW?=
 =?us-ascii?Q?W+YuogCm4Bn7Kad9C0wWXQx99nBM1BDJthBtDZKrHTDnw+q6NvTdndM8V1V0?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c32906-4b55-43b0-9990-08de207fe02b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 17:37:53.0077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPbBrQ4hIp7uGBHey6DS8FG3sJjotVLgAWGkGkbYZ/84pl43HeyG7kSYuqWdsIyuRDmN5fYioVjcONJVOQhaMpgiBc0qyvv0k+YIp7Mt6CI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB5984
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

Remove interface type restrictions in sdhci_cdns_execute_tuning() to
enable software tuning for both SD and eMMC devices. The previous
assumption that SD timing should be handled by SDHCI core is incorrect
based on the actual function assignment logic.

The execute_tuning function is assigned based on MMC_SUPPORTS_TUNING
config, which is enabled by both MMC_UHS_SUPPORT and MMC_HS200_SUPPORT.

Changes:
Remove IS_MMC() check that restricted tuning to eMMC only
Remove opcode validation limited to MMC_CMD_SEND_TUNING_BLOCK_HS200

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
---
 drivers/mmc/sdhci-cadence.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/sdhci-cadence.c b/drivers/mmc/sdhci-cadence.c
index 4a54196e06d..de3d42053f0 100644
--- a/drivers/mmc/sdhci-cadence.c
+++ b/drivers/mmc/sdhci-cadence.c
@@ -207,16 +207,10 @@ static int __maybe_unused sdhci_cdns_execute_tuning(struct udevice *dev,
 	int i;
 
 	/*
-	 * This handler only implements the eMMC tuning that is specific to
-	 * this controller.  The tuning for SD timing should be handled by the
-	 * SDHCI core.
+	 * This function performs the tuning process for both SD and eMMC
+	 * interfaces. It sweeps through all available tuning points,
+	 * sending tuning commands at each step.
 	 */
-	if (!IS_MMC(mmc))
-		return -ENOTSUPP;
-
-	if (WARN_ON(opcode != MMC_CMD_SEND_TUNING_BLOCK_HS200))
-		return -EINVAL;
-
 	for (i = 0; i < SDHCI_CDNS_MAX_TUNING_LOOP; i++) {
 		if (sdhci_cdns_set_tune_val(plat, i) ||
 		    mmc_send_tuning(mmc, opcode)) { /* bad */
-- 
2.43.7

