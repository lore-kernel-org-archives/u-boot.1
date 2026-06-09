Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E82CCD8C85
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:21:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 513E7848D8;
	Tue,  9 Jun 2026 09:19:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NynFPHC4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF9D8848F0; Tue,  9 Jun 2026 09:19:42 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7CBD8484C
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbsaraRePq0747oBG+L21onLdI+18/Rmy7mX/nFKJ3hxATxOA7qasDpPSM0r1lezbeWWzpgJnIh86AqQ237SFiJTMSnL3XU1yDVro3GBfNtFq0DhwRakV8IKzMrHdTHf3p2VtfunlTuKIUXFgFV6OhjV5BzIg9umKFgift9U/BBqb1kXuJvrBl3pVKnX6GQY0cyGtSlWX5TsIh70h1KuoEEu7CQE/iFAUah19DsiURNgz7NMVEvVRfctLxu/OlbGGua/WxAqE9euIIyaX8UztdZ+90HWeTcd4kcP5eEKzg4d+0BTneTvplWSi9YAS5z9kohaAGmh06QGL3p2Ah0/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CG7KGUn6CkCjxkzxemTz+LblLk56l6B2WSEd8fkxJ9s=;
 b=XZ0i2sdlu6vBVjng2To85OvvGMHkzJYIxA1PR/1zNMyZs3yIZmMGuUyG/wJ5PQ1aXJCX0DHZd79/o2wfwIOfMMIK2CgQMk0gH7NLtjrXiYzMjwTTvjAn3JCRht6vp9Pv8FOvzP+4Ht3/vVBZFBc9g4NoBB+yzxvJWckE69xLgyUOb4J+1IfTEeG21dNsg0+cdkg65Izy5VgFaVQlo+z81AznwsmnTxrEAtTmFsWHmmIIZrklxE30lw+eaRmiXdWj93cYZjYP9ZGugchABjGc8Waz6Pvd1Y6aLw8cr7MMWrQIaldzatDHTpNguxM2m6LuEK8GNFcRgDQ/f/UFSpHbbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CG7KGUn6CkCjxkzxemTz+LblLk56l6B2WSEd8fkxJ9s=;
 b=NynFPHC4Xb2PDejtDQxqChC/D/uhv509M/tqx/Jh/u0NgjYbUosxCssKQdsn3MGjYRn8oIXK/DAA4gBhMJMaaOb4zkTtLwNhwda1of3s1gJh0D3zP5tsscD1bD7y8hjO8A+Us2OwqZDGqk30zQ0Iz5RsAYXLWzciq0FMwREzvZi425dDqrjPI8/6cV7ZzDLUArpRxXDEoaoTOkCVzcTqm0GiYRqPTPXVgbVvPJlfbgra560zd3AJW98ugq9iRqoIWUYwlMg5Ujivip/vNZCaapPqwnWk8jsj1MtiVUU3l9x2O3l/L+MI0y3sJSAu1EjHWJPHadLhOjDzIRcfXOUrOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by DU0PR04MB9693.eurprd04.prod.outlook.com (2603:10a6:10:322::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 07:19:38 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 07:19:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 09 Jun 2026 16:36:29 +0800
Subject: [PATCH v2 12/13] imx8m_evk: Select OF_LIVE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-imx-misc-v2-12-58e1665d55ae@nxp.com>
References: <20260609-imx-misc-v2-0-58e1665d55ae@nxp.com>
In-Reply-To: <20260609-imx-misc-v2-0-58e1665d55ae@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::10) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|DU0PR04MB9693:EE_
X-MS-Office365-Filtering-Correlation-Id: 47baee39-4261-492b-9736-08dec5f776eb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|376014|52116014|18002099003|22082099003|38350700014|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: IW5BdJqGNLq4abNOzQvqN2v0rLghuEwzyrOKu9i/uwxHVXJqGkawb5PwEsblrqNKyqGqQiQUFuCInb7h/D+xCiOczGEc1Yt4VW1x9V78vDsLhAg8hk1nDUVPdv3JJ7QHXPoS7B/rFld7oNPhb1wrsTZ8VWPY7nRqmQ7HJ5DMzlaLFaMX8Mn1Ax5+O0ZrQgA2thEB1w+Swq0TJNZUGmp/7cXJqmM/IuI7xx99lBPuBgJC05eEiRYQu79pjskGBQ7GRvDnPbljNqJRZR4t+40z/VqLG6ySk+VTv0A2NlpPTEoO3kElfw26TdEe0yYxncEnXFS9DkNOuLrehbtsmC2qX5IWkYe8GlDlUmyJPmJHz9/rxTL9dLrm0o+3pTr23ad7SF24sONxk2QeEvUdaGY74R0Cv22ejvcjTwQdQmN0QxHNTF2jtjwwvKqgIJxi/rxIJSB5yoyy9DjSB9kedBmM3dJakc7+gwxwN/rERVB6zK//KxworQynGKVLZ5pIeV6bZ5BSs+Hj5XB5j1nGaACtSn6MfPtmSaSG95Wdvr1GIkl4w/LLYhcV/oaJ7rHJs5QE3yvBh4zRbV2BG+Llzhhzsj2Hm8YfSO40kh+YIueoKX2V0Lp3DCNTx27LYtnf/OsqphFq4RisNzVyHWw4WLvXoZWCGtQ0qw04ytL2oNNlC28p56Rp9OjJd43xqOg5ExgHzOng1zfKaOavmaHTt8LFaru0v5fuRT8iyD8fCtE4vA+tSLhKW0gnUL+AhKgGKW2e
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(18002099003)(22082099003)(38350700014)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnk2K2gvNkpCSlF1R0NETnJYSUltU0h6bG14Z0JvZGYvRnpLWHFXelh1bjhH?=
 =?utf-8?B?bkxuZ2pMNDlXVWtpV3FIbzRJTTBkZGNtZFR3Rno4bzZiUE54UWFGNEV5ak4r?=
 =?utf-8?B?NjdORkhPTzcya1VFanFPbHBGemovRFlqUDR4SHRSckNsTVZMNEdSNGdtQU1t?=
 =?utf-8?B?K09BNStTTkV2SHFZbGxzOTQwcE9KM1RmQ3Y5SmVrYlo5N0Urb3NlUUZ2cW0r?=
 =?utf-8?B?WUlFN3V4d1RDWjl3eFJqQ1F1QUlWbzJHN0lrLzBmQ09PN0JrUUlBWklaMUVz?=
 =?utf-8?B?dG1hUXdMN0FJdER6dHY3VUxzOEhQb3Z6am1kcmNtOTdiWFZPM2xDRnl0WUVO?=
 =?utf-8?B?MXdtaGlPMFRnZUlkSHpaeVRTdFFLZWRhaFZmT1pSMEZqVTJES0MzdmgwYlZU?=
 =?utf-8?B?R2JxcG9HeW5CWlhYUjFiTUI0V2xBTVp1WFJuQzdYN3AzUmdQc3BOTnN5K1Fv?=
 =?utf-8?B?b05hVEVrTVBwOFo2SzVaWlUyN2RDcVVLYmVvNHNKMXdtanUzVmg1SjhGM3J4?=
 =?utf-8?B?d2NsVXBaeXZSdUFkZ2RmTDZaKzgvT3g2aDk3bWZQbkRRSGFnNXNLdFVaRDVa?=
 =?utf-8?B?cTNBZUV3bTVYbHpITVk3dWhQdWVnTlJ0bmp3RE9iOUdXNTlibVhQV2VsOERh?=
 =?utf-8?B?a00yeXdYdmpqNXRQUmlVS0Q2Q1pJdTl2VEZnM1p2TGQyOGtFZU1TSXh1SEJE?=
 =?utf-8?B?Y01zSVBhVWZ5bDZ5VU00VXFjWTVFS1djRUljSzBCQ2htb1k2SjlwYnJYNXhw?=
 =?utf-8?B?cGpIU01Zb2hodkFnWVorSHd4N0RlcGszUzF1ZmdJOVhMMVBiMlA1dVRENWhB?=
 =?utf-8?B?TEJ5YjdBOVNHb09lWlJqNkJuTFFHRzZCNitQYlFiVElZcGJReFUwaEc1eFhm?=
 =?utf-8?B?ZVNjRWZjRFpHeVNXcnpUQ2o3cnJXNzRYRjNHcFNqazlHU3BtQnJpMHNMUkNC?=
 =?utf-8?B?U3V3OTVEQy91ei9pcjZ1aE5sUzROYXZOa0tYaVVMTmhBSFpqODArRFpjczZW?=
 =?utf-8?B?bDh1a2FpTmhNN3hNK2FxekxlT29FTkdGWHhUNDIxVE82aEZNSDdudFRZVVBT?=
 =?utf-8?B?aDk1dlVBK2x2VzVINkRiTVdOdmlIOHdTQ2hobkhTRFlLb2Ficzd3MjA4Q3V5?=
 =?utf-8?B?SkhCdDVJMnlObUEyT1JPY214aURSN2ZEN29MUmNBajZzNXFwRktJUThnYjhU?=
 =?utf-8?B?S2Y4L1IzMEFxQytqLzkrMmxlUm1NUzkrR280TVBScEYvOFBmRHg3QVlFYjFi?=
 =?utf-8?B?RGJQd2hPeWhldVd6USsrTFFXVExIejJnd0tOcEVJQjZKK0ovUDhPQmRBWmZI?=
 =?utf-8?B?TzJMSmJQeElwTS9MK3orK0pYUG1uemF0YjNhN0VkMU5PQkY4bUVteS9xYVdl?=
 =?utf-8?B?K0MwUnpnK00wMmV4WkV3QUZiOWRrTmhEcGRMbGFuRzJOR3hzaHN0eE4xNVYr?=
 =?utf-8?B?N3E2cGJQYVpPTU1iZ2ZXcFZCZjRDM2NhT0pPcExBZXN3cHQwQXVLNjI0TXR0?=
 =?utf-8?B?WGFZSWJqaGd2SUR6ZGxpUlhoY3ZnL3BneGIrZUJLSUwwOW95UnRON2JuTFpE?=
 =?utf-8?B?ZFF1emt4SGh1NzhxRmhDWlJsQWZHVUtjL2xCZ3lPMnpZU1lTcUxySUZKS0F0?=
 =?utf-8?B?YUVIc2ZxNkl0QlIrcGd2ODZlN2NmUWlRcTFLdWFFYVIxLzMxL1krUjlPMDlp?=
 =?utf-8?B?bHJKZE5UeHpzS05HV2JjNmhUcUxkMWJBT1RrempUNXZVWWZEUVFpOWpSVmx3?=
 =?utf-8?B?Q2tPVGlFQzU5MU9DSUNZZEo2WE1xMDFvWmh5RUVTZjBlNzN2V2lkczkzUGVx?=
 =?utf-8?B?M29VWWJWOENjT1dtaW9nYkhUKzVQVkxLeWNpSkZqbUpwekMvVEczM0FsUmJa?=
 =?utf-8?B?eVJaRmo4WGhpdkViY1lwYlF6ZVljakNMczAwUFhLTm1SN3BIUUtUYkl6M2ox?=
 =?utf-8?B?b2FPODZJb0ZlT1RNUzRkUXp0eHk3enQwRDl3TXhGb2JiWDlCK0xPVkFBL2ht?=
 =?utf-8?B?a2huMzUwQThiaXQ1K3lVcGh6LzlXZG15MXpHaDBBTStxamhiaGxTa05JcmpX?=
 =?utf-8?B?U1h3TlRodUREaTc2Yi9KR0p6Y2NYaHJSV1owVlFldStJbTdLOThEeHVpY3J6?=
 =?utf-8?B?Nk1LL0k0NUdrcGhXaWNoSGNIMnpVb2J4MXFUZmJpcmtKSjN5dXd2TUtzakZr?=
 =?utf-8?B?d25OK0dGT1h4RU5xTnlGRkVMS0xGTEtVQWNNbnpibW93Z2dJbTNaWmFYc2ZJ?=
 =?utf-8?B?eUl4WWxBZDNnYXZHeDBlZWI4Qk5zQVl1SmVtdlRpcVpFeWlNeGc5QWNSMkw4?=
 =?utf-8?B?dnFkQW5iYjJzeDZkSFZzY25xaUwrTkxCSVh3YkhPZ09RTXRPTlhRdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47baee39-4261-492b-9736-08dec5f776eb
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:19:37.6950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBDw0tCGqOUlAeIZPGvGseY1W8swAVTLhENKcWhUCsXphDEPUuQ4XzW9mGgoE26dBCJMcUg9my+Ax0dbl7+4KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9693
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

Enable the live DT to reduce the DT parsing time.

Test data on i.MX8MP shows that boot time is decreased by ~%6

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 configs/imx8mm_evk_defconfig      | 1 +
 configs/imx8mm_evk_fspi_defconfig | 1 +
 configs/imx8mn_ddr4_evk_defconfig | 1 +
 configs/imx8mn_evk_defconfig      | 1 +
 configs/imx8mp_evk_defconfig      | 1 +
 configs/imx8mq_evk_defconfig      | 1 +
 6 files changed, 6 insertions(+)

diff --git a/configs/imx8mm_evk_defconfig b/configs/imx8mm_evk_defconfig
index 953968c9092..33c1ae625a4 100644
--- a/configs/imx8mm_evk_defconfig
+++ b/configs/imx8mm_evk_defconfig
@@ -71,6 +71,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/imx8mm_evk_fspi_defconfig b/configs/imx8mm_evk_fspi_defconfig
index 79abe3bfeeb..94174916786 100644
--- a/configs/imx8mm_evk_fspi_defconfig
+++ b/configs/imx8mm_evk_fspi_defconfig
@@ -59,6 +59,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/imx8mn_ddr4_evk_defconfig b/configs/imx8mn_ddr4_evk_defconfig
index 63e75aaf7a6..033d1670d47 100644
--- a/configs/imx8mn_ddr4_evk_defconfig
+++ b/configs/imx8mn_ddr4_evk_defconfig
@@ -62,6 +62,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
diff --git a/configs/imx8mn_evk_defconfig b/configs/imx8mn_evk_defconfig
index 152f04953f8..b7bee8cf276 100644
--- a/configs/imx8mn_evk_defconfig
+++ b/configs/imx8mn_evk_defconfig
@@ -80,6 +80,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index 7af538ee367..d176b42e83d 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -75,6 +75,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
diff --git a/configs/imx8mq_evk_defconfig b/configs/imx8mq_evk_defconfig
index dd0c615032a..d041fbd8268 100644
--- a/configs/imx8mq_evk_defconfig
+++ b/configs/imx8mq_evk_defconfig
@@ -70,6 +70,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y

-- 
2.51.0

