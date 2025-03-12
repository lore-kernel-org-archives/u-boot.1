Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41789C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 13:02:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EC98817D3;
	Wed, 12 Mar 2025 14:01:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="iVrxYrvl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 341CD807D9; Wed, 12 Mar 2025 10:04:40 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFD4B805D7
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 10:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yt9Tf+ANoJn5ECYUo+tl8u7do9uBNhB0vbK0Eo843/atA4axHXnLGo3s1ilgyQRjx9vn4UICMbE2an6YxbXl01XAgPH5HrVKi9SpqUB/DAwz1tgjXe27yQC3pk8DOyw0AYSm7WnKL5aGGxOJkDWG02y/hFE14JpemKOFD7qoqFp3Y+P4qhQU/r2WDlrNUtZMY4P2EC4uQTQ0P1Lqt29KmZaC9udh5zktkxqSuDJTThBEtHpc4VIkX9EJBBYgxawS5qzyLrutRNbjhxZpKKrqxv7EwI3zyMphQgXD5MaLFWEjHH/cmKgDyUCWSuE+pEKOIg8CBh3XfuRPMzGOrIHp6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXHVTyLoM+fel4PyJXu9+xE/W1I866FMq18uJQW1LPU=;
 b=V5hz8/weOSnwFykQJMb3Oz5+fA+ti9AsRiaFJb8IaiAtoDgyY+TUXMtGgJCNEOf1VmbPpRGTWbfzOgfbBlKxESNBlB3YicbklXGVzup9YOPzNrdGQXI0irSUQAcrUuhoTsD0gWBhOWmysuNLcLdmWUD0p1OUjyNVwVYjXaofPgQgULqphp5DtGs6vGkZckbxdYkjuEq+WW7QPMAbzCsE1b6sQz+wufTj+00xpXD5RXvR9ckphfghAee65Ny8UEGvcjHoPp9zDzw2bzE04A1qtRKVq1wd2ap2TUI2Z7rf7iPjxAgm7sKnwKZFRFXekEN1OFsVmde77ayZK+psT8ZztQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXHVTyLoM+fel4PyJXu9+xE/W1I866FMq18uJQW1LPU=;
 b=iVrxYrvl9fdTAj/nD1AYoNfAKlKVAMJhFm6aPkiwdD0F8n1N2xNzGlrOmCybRTY6I4VL+j9Fk+LDOFWzu9lbjbxScgHmNkk1keVD1+eRKaMqXMW0dJGPVTiy6y5cq4qR5qAoSub8PYf2hqB/C3oOGLpBS+PSdmIS+vEUl7FBY5w8igdhnEoxJAZPQo1lIuM1kH8VEGwric2z/JpyO4R43fGgqzIB6kObmNLkoJOwIBhVsdA+831YbLjrNsYO4xn7M9HmvQCeN5vvS6FljWk060M8ai7ftHcyd+FNwWQUJQ7CXm21d08Fp1b3MbV6rCR0ykA+4cbilXHwVzl97sS0kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AM9PR04MB8242.eurprd04.prod.outlook.com (2603:10a6:20b:3ee::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 09:04:36 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 09:04:35 +0000
From: Ye Li <ye.li@nxp.com>
To: festevam@denx.de,
	u-boot@lists.denx.de,
	peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH] imx93_evk: Fix wrong VDDQ voltage setting for LPDDR4x
Date: Wed, 12 Mar 2025 17:04:07 +0800
Message-Id: <1741770247-123217-1-git-send-email-ye.li@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::29)
 To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AM9PR04MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: c9dd6078-7198-4764-4979-08dd6144e8e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+pRb5T1sqnf3rNeohXUwkNKjo/2Mj0OsL0OLwd2aKKYJZiwL4RvlrkkJLwFT?=
 =?us-ascii?Q?OinueCPDNhDcnbtEfF4Nl0jHY4k5UeSHw9wkp7PnARPxEoq4MGBX+nj01JHH?=
 =?us-ascii?Q?OTE+3QtBMtGEDknPqe9PkzDhnAJZt2NKjJYneQzhd6hqnfkF0rBp9dwV80yB?=
 =?us-ascii?Q?P54P9LiPhse6z5aWknlCQ1wxq3ZOHw9j/RsoXXz3YVxnigQltTrJ0r9iPrjK?=
 =?us-ascii?Q?J9KQZesj+5enTWc5lMwmcYKi0jwnPoN27tXvrOOun5WxsJzETmU0ShOAceWQ?=
 =?us-ascii?Q?MHcc/iqSyFLjAvYaNp96aM3wlYRK1uzulSeTaSX747YW+txHHSkM8ImmeW+k?=
 =?us-ascii?Q?6rkWopMiDrj6cQErmxmGTC8QLtlZkpCjkSXYDipkVFpzA9aId/arQnVq1nWg?=
 =?us-ascii?Q?q/ZZBHrmivIsGs2+8ps75fIffqmGja6Jb/5Zq/dIpk9IHBdVKmG8PAkMGuYD?=
 =?us-ascii?Q?T7YdOA4bCdG6rfJAvjHnN8dgd9Zp4YSqbFRwcaAVMnM2CXjYsMgEiJ8GRxNR?=
 =?us-ascii?Q?9GyaTVtUbjFtEQDmhFZyJJN/FJZrxfuE7juNCCcGDO+QZ3JXWFIZWqhrN3Ha?=
 =?us-ascii?Q?ODeLQT+sM19ippxzn2csJGJ/PzKIcAHC0vWU4PXZDusix0Hog21VHqYa2jpL?=
 =?us-ascii?Q?4t+zvL6vMOGGmN2YIDiAYsLv+XDlvBJONYs8q2IeDj8mrvuSqydyzKwi+Ewu?=
 =?us-ascii?Q?n5xulobVUHc9h8WUJ/6Abp810PylKlpUiX1re4uqRsCJ6ksMAQewCZWxGvDX?=
 =?us-ascii?Q?6njDiL8NEUNkuL7JSYshmn/Uo9HAZhDDQEl+VziJRTUXho+IdLiTZakxOJI3?=
 =?us-ascii?Q?xfO+P8CwrSs55DcLfGrK1C4MH7sHltGMyQFSw+yBuTekHMMeB+BK5N1HpcdX?=
 =?us-ascii?Q?OYJYZAiCJr1J5utPS2aGBtTQSIN/qVyBVVy4vJHklrwzXcATo9YjaARIYdaq?=
 =?us-ascii?Q?kz0kbdkxqbjMpAm+sr3oWlWffmqWSIU9kyikGpLPEkGP94aMg06QlzTmtSCX?=
 =?us-ascii?Q?UPI0mAU1SwR5dzY35XQWlruSSK1l/R7F8LaI9fJCW8p+mmQ068yHmxWxEPzW?=
 =?us-ascii?Q?6O7dE6tvTrq/mKCZArDaVyOJQ91BrOCvjl3T2OvRlUXUm8rLnulxyNCd8w8L?=
 =?us-ascii?Q?dsTP0//t1pRd1FiR0J6x4kGfRXk8UuGziKAPV8sjdwgqhjTgegBKzxhsXCGK?=
 =?us-ascii?Q?9e+szPhC+tHCAOGOy1j1J4qRDc4aW1KWv5SpKnkAqDRARifK6HfyaqNSSPFy?=
 =?us-ascii?Q?UfWxINdBqzhBnCuSovSecb5lVoAxJmQsmlGRXdnnj8vFyGtVXwB5wR85Ui0u?=
 =?us-ascii?Q?JIyH5YBbQrzCrs4lIG7YtDcjAIspOqgm3lzy+jWwwBtyowu52FbPN9a0WYDr?=
 =?us-ascii?Q?VEYJ/MLFP7jgO1d0qbBP9aBi9LSbDmCYeg4m8448tgeXeOQzvlTFIGqdpGq7?=
 =?us-ascii?Q?P8zfO4G1SNVZ2FkNoTC1w9eUgmp6aRql?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tG/IuSHyv2ykpMxYKHw5ZEtMSyA9jB1/a7BHKCTjvsKS4N6bZ/nSLdHhJwDU?=
 =?us-ascii?Q?LwSfKlPj1Yeh2uWlcmJ58d59Ot/DK03A1jQ1/RFxZb135UMtqITNoNVyjqcZ?=
 =?us-ascii?Q?KbHIOVkAE4ciGtzse4t0d0BeZ6OLydGO1WGqhXAfD4qbHgraXLQ5nW9Dtg6E?=
 =?us-ascii?Q?ww2SvpQ5ZX9Ih9l7P2QEMfgqRvrVv3gkxl4QSNNGwFvSO5sVKy3KKkdjOdmw?=
 =?us-ascii?Q?R1AXfnX/OtB9uGvv8NBaBxW6fBlya8lqfmuCnKRQPLh57H8cnYcZQfvnX3YE?=
 =?us-ascii?Q?3lCVYbJJ4uKxEhhLGYGWyU9aev+8LkgiytY7wQuSLdF2rPP/ydCCd/86SkLI?=
 =?us-ascii?Q?vIgUq4p4e+sHwDYYcDtQKwyG6oK8GAgwMT6JSapCMkJp1HZTZsMMewUJYd10?=
 =?us-ascii?Q?pvpd8OILhphHy6JHSk5o8uF+HcPU4olfhtP8dGnSfnnUWHnsmcfp6T80YbvK?=
 =?us-ascii?Q?d6fXj/jZuRtjKwrMWmidJFKvoe6ULkB92484/TcTxeTDy2h+kd3w2tDkmpzL?=
 =?us-ascii?Q?zbD1wHheaAmN/rCVpL1V09jMlXKKtwDpJdoJeC9SKglPVWApuFXu/9ddsWHR?=
 =?us-ascii?Q?GCLEPLtANzd0GQILCgnlb674HSEm5USDWjSEa6hHMyepAR84tU47e3ENqKVB?=
 =?us-ascii?Q?I+zpCMZ4r+m2ayKyAPIGoe5zdQ7mqGXC/Q3mk1wYZUt9zuN3Ca41BSeXfZ53?=
 =?us-ascii?Q?HePaMqVzAirxeXneg7H7ECb6yjeB9ZcOE8FjhF8A4+3UwruwV8Fm1NqSUxb9?=
 =?us-ascii?Q?xdcjvawOpHBrcUzRTYOST2Rvn/YEcjKraThdEF1h9ndW8djJeF0ElprKJSxE?=
 =?us-ascii?Q?q8HiYPPv2qCMP2SFhnWWLiqozLacWgiH3ifNoWW91aqDlROe5TKFZXtRe9z8?=
 =?us-ascii?Q?9/MITIvAYHvtUUY9Z4T9Zd8t7lcWXlmV+MaeywmsKHa2PgZ9yQYXErhgtOeC?=
 =?us-ascii?Q?UlzOqvh6j3xJgkrxp7MsYXPjroab6/t6iDCk1YX8KGYTA8Kw2tC2EIcRHbfV?=
 =?us-ascii?Q?j4zUTZVHD5VgoXCvOsM1XkB18NktObycJj0GibFSM2hpwtmMYw3ApdCAHoR4?=
 =?us-ascii?Q?o7M2FBPbRTa2up3YIj3iIklSkvcGDrS8YC1tOnaFygB1vW88H7F72L48lAnM?=
 =?us-ascii?Q?nhDNQBx7EGLp9ZMJ8WteAVPkydhdijC3aFCIxwPfVAubTH6nJeOyioGxx+Fv?=
 =?us-ascii?Q?gnD3lvgV/1cHptnK+lpbPGl+1T5Nq006CFR4e0/p30kM9jf3K1qpxbjQyqMq?=
 =?us-ascii?Q?ugeN1fOGKo4gxXY0oPevvdpc4y+W8ey3T03kN6OfldmxiDsTqaRPXe2TzBu2?=
 =?us-ascii?Q?zovZzOibTURjQwJm1xbzzEp6M6N40o8rVkZbD82gcqc/Bg1WDuJ6ARs4grxN?=
 =?us-ascii?Q?BlXQbtPWi0TFOuRTB6ukPO7x+BQZAGeE0nxuXmEhr5JWgEV5kAbtcu3q8TI8?=
 =?us-ascii?Q?WTnFhULbKGV9ypQkboGfVCp3RwamVkn47AneVrTHlBhs46ecztFhCXXtfl0N?=
 =?us-ascii?Q?2rzklyMQxrCRNuEyr3QbLun+WM9KFEX5aFyojCAUwFwJ45czH96YCC/sakIn?=
 =?us-ascii?Q?lOj0YXaiPsZKxMqzDu4Lv9GJqdZKW4Ya26yW84iE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9dd6078-7198-4764-4979-08dd6144e8e6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 09:04:35.3310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lemrkuUcj+SkOSoojh8dYFniWXaGPnXCzdTE3F2tkzDOUlBusenlM6VlsFUWr3rp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8242
X-Mailman-Approved-At: Wed, 12 Mar 2025 14:01:40 +0100
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

The default PCA9451 BUCK2 volt is 0.6v for LPDDR4x VDDQ. The codes
are actually used for reworking to LPDDR4 which needs VDDQ at 1.1v.
So remove it to avoid LPDDR4x issue.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 board/freescale/imx93_evk/spl.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/board/freescale/imx93_evk/spl.c b/board/freescale/imx93_evk/spl.c
index a214c04ddadf..67a10bbb05b2 100644
--- a/board/freescale/imx93_evk/spl.c
+++ b/board/freescale/imx93_evk/spl.c
@@ -110,11 +110,6 @@ int power_init_board(void)
 		pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, buck_val + 0x4);
 	}
 
-	if (IS_ENABLED(CONFIG_IMX93_EVK_LPDDR4X)) {
-		/* Set VDDQ to 1.1V from buck2 */
-		pmic_reg_write(dev, PCA9450_BUCK2OUT_DVS0, 0x28);
-	}
-
 	/* set standby voltage to 0.65v */
 	if (val & PCA9450_REG_PWRCTRL_TOFF_DEB)
 		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x0);
-- 
2.7.4

