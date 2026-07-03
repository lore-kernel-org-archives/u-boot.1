Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C95C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 09:13:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AF7D847C8;
	Fri,  3 Jul 2026 11:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ev6v/Zmm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5EDF84119; Fri,  3 Jul 2026 11:13:12 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011032.outbound.protection.outlook.com
 [40.107.130.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF5CA84119
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 11:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGDSQI2Nq+PtaPfdQahnOk2fioiiXhI96psPXTD6VMKXQbMTQPL/lH1da/ov68JJxv/AwGLjOQpf1yAP4h0Z1HSkyyKo/CjopuPoDoQyLQrX72PLCasUz1uQmjc5mWWKbCJQMeZhQmhj9hzbiG3LMQuc94iBGP7CX562Kixd28NjFI6vHk2UWyhd4YTKdvWZG8q7rTRi/5kNmI4io3dlnOTwegn/FfzEb9kYQ7fRVEl3lTolGyinvLKF61sBAkLrZTp3gbqZVIyE8CVtrXhCP/DLM/BKNsJJrXag7nMo2wc6mqE6wkki4bCwpntAkCK+w//MFQCv0/AC4LZg+JthpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZHTih8GyJbB5FcAE22RNT/kzjB5QHcetfuYtlzNaHQ=;
 b=RaUqoSKkeFzOKlrBcgDyl31Yx4pYFyETfxQNyBGvNuex8NYnDCj/Jf9EhP12aweDqwqdTca8NNjfcXK/+Yu+mnnNo3GuXGpuiXigmNw0Rpmrgor9oCK00jV24GYHmOV2LbuMhzR6Pcns8OMhq8IS7RGkP/WRGlWJxRXSD5tEAJ8FbKq/okhffWBfphUrYZy94W2TutVl4Ex1W1mUkxYpWmoDv8SU7ht2R8av9nJ8NHl7u4PWrTdoWYXikbTOyx5X+5t+B5dIz7UGWYd1ZKxJ/BgRrIAxUp8uJG99tcjIL+VrMybU/CzneldEOkziXhRQEcJ4vHW2aJgQSyikhfMb/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZHTih8GyJbB5FcAE22RNT/kzjB5QHcetfuYtlzNaHQ=;
 b=ev6v/ZmmxkgqlIG5kf1qoT8oV/gEf4lDw6V/c/Z15zLWQUGid2FKTe0RHLpnGR2RBUjTlOI9NmW68YQB5oTMwcIoJopMdTZsIefgPMVll2nMJxx+fVZWxXm2BljHAVwE2SVHmremLr9mzWpOiQ0Exmq18VdDYhdNvAZaPE29N0UIr6O6eocN+XwJaosdMBaAI2AGJaTjgnMbUOmWfPPWKzZ1M6EBR+MY4bv/FvHsvt0YuX318pnhSJukZCB0xfCziwJpVir21upxv74g+sAt8RobWWpk0wEGWclXBqfw1WTH5Cz0XJ20Z734yIIZL5FEjzVaMInNye5W95D6XsdjSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DB9PR04MB11579.eurprd04.prod.outlook.com (2603:10a6:10:60c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 09:12:54 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 09:12:54 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 03 Jul 2026 17:11:26 +0800
Subject: [PATCH 3/4] dm: core: Correct calloc arguments
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-dm-core-v1-3-076d395bded4@nxp.com>
References: <20260703-dm-core-v1-0-076d395bded4@nxp.com>
In-Reply-To: <20260703-dm-core-v1-0-076d395bded4@nxp.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DB9PR04MB11579:EE_
X-MS-Office365-Filtering-Correlation-Id: af93f410-22e0-4398-9b9f-08ded8e343d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|19092799006|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: nJBjcxAhi95aDmww7H9suQr8o6nvmCVph3WO3IUC/4XzAGRavfIEWXqmTSK96RfTx0e1PX97pLmP1dx7y2ZSFli+Ia3XVVGN3KE03bQ08ZjhJsJ9csEoTqu0JyPkvQB9nCHVrwLl5cOFA9VFq/qof/OVx2yQuQ0ebM7rd7yV5g5HaBeqsXKaDA0Xw1PvQ7X9ZuvPUJtx+nH+h1Y42KEZS1nrIW1UAGhgQ+muySBxemY7+SoTWONuslYL4oDAG3+SWZNHJyWurUzvkNeEEyX7i67R7mGOf2buwNWHJq1YTYMy95DZD0xwxpbRVJk0uNZ3PrEwPYXeeYZ3v6MyLIO3/spc/4kFsDGDdDaG4bqelwNM1eIkMPFnb9bKl4Bot+d+T6ZWsqSX8la759sUcbCNHf6Q8YX2BFXwskiFebZoweAkY5S5gwuopzII7ubnbbs2sshxsZ0d7LPfnfuWGPA4xxl6jFS1lmcWQoKcrwW04McCtcWA2AVkoXk3CtX6/KkK5oSJIoqRPIvBmrLO6KZFP4RMKn1oD27eyMVc4fkqnvyi0YTkJpyp0iAP3JVPPCcCrwoNVqaE1PczRLqpnia5yc3GXTBFXh9jZiKEeeQlji8LEwfrrwZlrYEbQLK36XtussfU8vVYNZapUhE7SfO+nfrrdrFh2ZVgmkOnVhjmWNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(19092799006)(366016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWNiU1BOUXNxQzVaTW5ta05HL2dPQTYxOEU3ME02RjNLS0IwRUNhMnNzQnlV?=
 =?utf-8?B?V1UvR0V2cFFGekdZb3BOWW5TVmhKME1SLzJwMUFFTDlmNllwZVlqQVdCeDVW?=
 =?utf-8?B?eCt4emdyYXFRemswejYzcEFjVWdNd1lHWnFya2swM3BaWnRCTWlvM3dkcmIr?=
 =?utf-8?B?alZObXUwTUZVNUU1NDJ0TXZmbWIwbnZRdEw5UUg0SnAycjFoVVVIUFJ2dkVx?=
 =?utf-8?B?eWdYT3I4Y2NVTFZ2eEdYQ2UwWFhKbmZObjEvOGcxWjRpWkd6RldIRTgxYzNj?=
 =?utf-8?B?Um0zWVlyMVo1YUVKUG1RUUIxaTJVUmJKRGlFVzR0SC93Ui9memxuVXVNUmN5?=
 =?utf-8?B?dUQxZ0JLeVovRUZmSGxieWQ3cmNsM094WHdhRGJybWhnVHowSDRQbmJnc1FP?=
 =?utf-8?B?Q3p3RFZ3NWxPcisxb3Qra0x1b3ZhL0o5TUYvODRORDkzT05oQmUyd0FEMEVr?=
 =?utf-8?B?U0JVVFdCbEtNaWtGR2RUR1FoaTNTMHBoT2dHV1pjNDZLdG82bC9mQWQyWGhw?=
 =?utf-8?B?ei82L3U4Z21mQkRMbFVkd2FQSi9UTVo5L0czRElISUdmS3F5akt2Sm8wVlYv?=
 =?utf-8?B?c3lUOHhjWDNCbjJ1YlNXKzZsZ21EYzZpS0tRK2U4U1dhMXVSQ3lwRGNEb2ZC?=
 =?utf-8?B?WDhGd1Z5ejNSejUvbEhzaURxQlVHVEVnaUtBVWcwOUFnQUVOcW0vb0w0elp3?=
 =?utf-8?B?MWg3N0x5SGFMUnd2NVBadkVaOXNrVzJXZmFpQldqaHo1VWpjcTRrZWVLRzBx?=
 =?utf-8?B?aWNIb3gvSEZZKzYvdG5FQnhmYnpBVVVXTUI5bmVLd3V1ME1qVS9JNUZURUQr?=
 =?utf-8?B?SUZRLzRNUFNwVTRodFlYalpLa1I4SHhNeVFtRDNTT3U3OTJkRlhad09wUVdE?=
 =?utf-8?B?VmcyL3hXTkdrQkxoN2tuOUdQU3E4SWp3enFPOHZmZVA0cFdpcStkeFoyb2Qr?=
 =?utf-8?B?cUtjNTlGRzZldGZKL0ppdGUrUm1kM1JIb3hQYnRwaDB3di9teXlqeWJPTk5p?=
 =?utf-8?B?SWZXVGJvQXpTcm5pd0pWY1pCR2ZrNUFTSnQyTUU1MkNkNHlrS3ZFdmdPREc5?=
 =?utf-8?B?dmIxcHhiM1FvOFRiWTJiaXgzaWlPSUVxY0tNcUpBRlR3eWtUc3EwNWJXK2FU?=
 =?utf-8?B?V3ZBQ0JHSHV0cE4xb2lvRGo2VGo2c2sxMUs5bE5JaUl0alpjdWs4Y3ExMkxC?=
 =?utf-8?B?U0M3UStsaGljdHNRaEU2WmdiVnMxcCtJa0tJL241NWNaRWUyTDdic2JuMGIy?=
 =?utf-8?B?WUYrc0dET1ovNnVWbk0yaXNLY0JhcWN1cGNmcDZOMS9xWEZPNVEwbEVBc3V1?=
 =?utf-8?B?emplUGJjTW5sRjdmdWZaMmFwQ2grcWVJZmNTWjZnWWhDUEx0MDNRNmV6V3hL?=
 =?utf-8?B?TjVSaEQvSFo1eXcxOHpsZFlPK2xqS3E5czRkSDRFVUR5MjYrQmtUckFIY0V1?=
 =?utf-8?B?QXE0WUJpZWVDSHJVSkF5aThkQnhFZkVCdGNEck1reGtjbUhuMjRGVUdxSndT?=
 =?utf-8?B?UmdwMFVieXBFRFJiRW14ZGxBM3JLK3pUdmg0YXI5TlFPSVdDa2dSeHZHWGo2?=
 =?utf-8?B?MU8wd1NZVm0wa1hKMG43clNlTWZoL3VxczhhQnJkNHZNUUNvdWE3djl2RVk5?=
 =?utf-8?B?NE82Z0Y2TXRxczFGNmc0Z3cxR3UwTzF3TnVzazl0ZVNnRjhSOVRRV001NHV1?=
 =?utf-8?B?bmJjbDRvd0tPNXhHY3lNSWhhckVTMGxseHhyQ2g1bUxZYURUN2hSV2Z1WEF0?=
 =?utf-8?B?Q2ZjaHhGUmwvanlHclJ2cVk4WlNvaU4ydWhFVFZ3ZWo0QjV5QW1KaVdXQjhC?=
 =?utf-8?B?QmhkVys3SlEzanBBZVN1OUQ4WTJCVU5sU0dZMGFTZWVqdE5FcmNORVl5Mk1P?=
 =?utf-8?B?SjRmNys2Q3Y4RTdxZklmSG5SSlZXRnZibXhZcFBmSmlmMVRURXMzenFDK1dO?=
 =?utf-8?B?K01DY3FRd3RoWWU4YzJBdy94OFVOMkgwM1YvQTU4aWhyVkJYV0hRY1JjSW9s?=
 =?utf-8?B?YjFOZkdBRUg3aFdLdmkyU0J3SnFNTGdyTVdYV0Q0YTZBemg4QWJ2UFR1RU13?=
 =?utf-8?B?U01Da01uRDdVb21HQXh2Q0NEMmI5WVBPVDJmTnBzbHRYR24yRElQZWtTLy9R?=
 =?utf-8?B?NWNVWURjNTVsYTM2ZndSU2xUSVlyUUcvUU9DdHQ2K3h4eGlIV2pybXFVQUVS?=
 =?utf-8?B?d2lnZ1VxejJEdFNwdHR5ZlQ0eWUvTmFrL01MSjJ0eXpzbmUvL2RWcm9xQW4v?=
 =?utf-8?B?eFpMZXVId0oyOUNodlpEM1F2dXRXVVd0b1ExZVQ2UURManJSV2x4TUJOd3pQ?=
 =?utf-8?B?dndRRkVzd3haZEJUN0dKZGt1ZUlDU1NITzg0d1Q5MWZKVkYvREdNekF0QTNR?=
 =?utf-8?Q?794Qvpo8H3bB5x86j4jPFShi9KKFS2Rpg67ls?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af93f410-22e0-4398-9b9f-08ded8e343d1
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 09:12:54.1091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jl1VK6LfuGY4d32Ru6RQ2+c/nsyKpc+f8OeDcyg81DpKNwuTd3pNvKsP1zLtizgfe+209xrG54Pt2tZt7WInHstjnZUV+uWW1mKryTxnCpNalmgKPO2ttSjSbl4wbCCI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11579
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

Every other calloc in drivers/core uses calloc(count, size) with count
first. Fix the two reversed calloc(sizeof, 1) calls for consistency.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/core/tag.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/core/tag.c b/drivers/core/tag.c
index a3c5cb7e57c..78b5ee6dc07 100644
--- a/drivers/core/tag.c
+++ b/drivers/core/tag.c
@@ -46,7 +46,7 @@ int dev_tag_set_ptr(struct udevice *dev, enum dm_tag_t tag, void *ptr)
 			return -EEXIST;
 	}
 
-	node = calloc(sizeof(*node), 1);
+	node = calloc(1, sizeof(*node));
 	if (!node)
 		return -ENOMEM;
 
@@ -70,7 +70,7 @@ int dev_tag_set_val(struct udevice *dev, enum dm_tag_t tag, ulong val)
 			return -EEXIST;
 	}
 
-	node = calloc(sizeof(*node), 1);
+	node = calloc(1, sizeof(*node));
 	if (!node)
 		return -ENOMEM;
 

-- 
2.51.0

