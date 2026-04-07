Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C32EDB7CC
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 07:46:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 805DE83936;
	Tue,  7 Apr 2026 09:46:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qv3fcPqu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA19284034; Tue,  7 Apr 2026 09:46:25 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B228B8352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 09:46:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUvJoAzmXAFzr7RZ77L7WCcvFWAJI8vyFE/rSpxH/ujE0b4LWP/2vuX7m3xhE+x3FkXTvCBMenRHZ8ThnKazSb8xP53YgPoJpKb0IHDYKE+IcgaNQ+54Fqga3yymcCnkbiRAWc0Q7NJVE3TNZXcO604gm3Uapo9pdJk6k2Pq9nYO6MrKzKTkl1x37K5ts6kbK+/EO9a5ET6buYUpSTqTfQRbfSzwX4lUOEgZ863cfi0eF1rnyRh2L0k+iH77Vfk+Wj9Kc0dcBEEKqZNuHj/NQk2R9rxWVZsexbWwJMdxH5NdAq5rdX2PD+V7OWqD0E7CxqJhknaOWInY8IuMliXBgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2pxALRza+EYEAwZA9ezn75kn9uLiTyyLJD3r8PP4v4=;
 b=Z1ntCjIlSP6ESULUtizfkPvodL3JSJlFYacDkPeaQqzSC+tXtyZ15Owu/IJth8XwZlDOw0ouWj8wmgiFRG3KuCwT7xkM2RgHof8PPB8dpV62eUtNhExTit1Ag0+B8cKsKA+j/5aM0x3P1gH/ZVTK7VomauQa/OjsbxUaky1pP3LnKuMXyCzZ0DCvSUDKlojdMPiSgTqsi4vLOXfvKVm299XqAJFoI3yFVTEugdSniXeOdT17yGFWPNHUbSWDk4eGEK+IfIsi/9f7jqDPvWnH3R+LXU/rB9b0pPFRsGQEmlqKrM1puJgq/b6zsGcFlr3LOBW72/GP31zdzZt8EwyGww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2pxALRza+EYEAwZA9ezn75kn9uLiTyyLJD3r8PP4v4=;
 b=qv3fcPqud/qd8xdzafZQhHHt/9VIVhULlSHLfqgyn+mfMUq8zyxaStQRsSIXnKAPpUo+7GMUbwoWQaNgV4TP9Cl5F89pIj/QBSNRp0GpezlVCxq6b15B64rcj5IoQ1AMSQKY6GjM0PWuvPm4WictY4r5BiqstEFVJ9PMXQvdpC/bJEXjBbkCJBxC8I0ykf82FGYVuW2jToGzFFTW7tlnZegdDTtjR3T/dp0tWaq2qdxNRUwRCWNVowNXvM2QbjZiRUYqog9ik9R+Ry8YoEy9xpyp3Drv5a5jwmSDRApxGNf6AnObwHGurFEEIrBE1zGqdaRC9USfAD7X2LvhDjzHew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by FRRPR04MB12570.eurprd04.prod.outlook.com (2603:10a6:d10:1d1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 07:46:21 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 07:46:21 +0000
From: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
To: u-boot@lists.denx.de
Cc: ye.li@nxp.com, peng.fan@nxp.com, simona.toaca@nxp.com,
 viorel.suman@nxp.com, alice.guo@nxp.com, han.xu@nxp.com
Subject: [PATCH] configs: imx9{43, 5}: Enable SPI SFDP support
Date: Tue,  7 Apr 2026 10:57:37 +0300
Message-ID: <20260407075737.2300937-1-simona.toaca@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::7) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|FRRPR04MB12570:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cdde369-9e28-4407-8483-08de9479c272
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: iAMFVaXYOMW+Akn+Y84vzkrQ491GbuLKwAOmm0Ncv2F/vMMh7fsBhC28Eb93wFLmj1jJ/TdIxfALUcI8kVsflOwRD8ek3foZrU6qSV/yVu8NCvMGTqVMRvuQAnOcY5/2tSGOX6MuCdNu52TuccXEnx4g40fp0zr/mq/SsyTBG47h7asGyXZFUFO2K6BkvsTsNgFj0IYAF2MCn/sKhprRaSYhWXS5AlrGCKOxvB/LHYR5lccVnHhYgdOvrDjLHHZ66rqBCbotHg0TdXrRuDS96HhQQ6Wi9rHI1T2hQ+RHNCsi6Y0a0xFnGA5Ul3TGo3ev8k2kGWAU6gEjVcKn7XpwCaao3S7KHw7SfiVVZMz/cJrjlK4dY2ai5RxjpVswHg9qMJRGlpGk3ZR1rLkT5JXQvTN3nZozMqBlUU4LN5VEBEK6/JuC3UcQE3iBDnsVM7/svLSXbfPdwv5iHLRF25dzB0WZzCaEsH4FfcUs7IXsZyKOqhz2N0KYZ5jv4wqOXgGIPLQCgdGbKlrQmaygFou+r6KkxPou1BS86GNi6Nf+T/lTUxDdoAdRUft+Qj+1wSU4MSvvmg5vWMfjKYnDKKJ1TZ9lt1sfgxw7i2vna9YJ8dTbmbXBa3gLMsFLRSXbUV8lzFynBBo0iwR81HqmT5CV45DxptgNllsYytKlXnio7T0Ly/v/aTuNoBz+Rqypm/SK4r3oG/pvkXcK16UfRGsTQC2iNdE53w5Cev3NfF0roiI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cFK4+fSTK18o065ZqGJIGkdpYbUgsGS2YE6xtdI52H3PDQeClIUq6c2Dtyuv?=
 =?us-ascii?Q?LOmoOplwHGRLocBlD8uMv1/6VDE+I7DHzv3kG/Sjiewyi+6fcnKgLNVZdgky?=
 =?us-ascii?Q?iXoUVlX3XD2ZsfK8uxCA79ZF9VcUHBZW+lRhXuS5z/EOL/U4/tXsS+w3ZAiH?=
 =?us-ascii?Q?YnyV+xYhE8r6sL2+4Z+IVt5tbeve/DlsJfNsEnjRt8QIjCbCZ1h3K6v3IpLU?=
 =?us-ascii?Q?u+dIjA0Qt9YTTkqZgzScIOvkj4D9ibK7tOv+0V5Og7hfYH+sHcwfnXyod4kX?=
 =?us-ascii?Q?R6YWR3Q06gRxm9e19P/NOKpNoIbryOO7tOuprZDduVH61r7TDA4vGtkQZzWq?=
 =?us-ascii?Q?qlbqtfxu7eVNXendYdA6G8SG5ohnbvCwc5b36mhs3Pfs3/dhBJ5c1NKPy5C9?=
 =?us-ascii?Q?kwByj7GzDbwyDNGUD++DEeJuonF0TCLUlyNCuPemDuvJiHxNy9kSbPJLyXS1?=
 =?us-ascii?Q?e+qrcYD8IVbfXZ+zWI9AEEQ6wLAb4nxoNWV7Qv9CGUF1dGu0aYKGfG41qxb+?=
 =?us-ascii?Q?M+xIyTL0i1fXSrU8vcvrwUfElgfZH07yEF9fJ7xMYyWxHPfZxWJ0ooVqG3xt?=
 =?us-ascii?Q?0GUAjTndXTduSmlVuO8Xrf4oiaMUBlc9vFq6SyuYfdgJqTSxQ2SQHczf4aWi?=
 =?us-ascii?Q?8LA4hO+YWSsoiTO3BOHc+0eOeDnl7gmzqulgVg3Lwzu2MxS4OGJ98du4CTwn?=
 =?us-ascii?Q?fjWDeu70Dc+XruMoifFHu6ayzlBk211VYb+FCg/4riJX7zbiHWI+HNDie3mt?=
 =?us-ascii?Q?ClItvUBTrjZt3zIWs92HDq6DfnPZOZ6tMs15/hEvzZj+IICyeR3c1TVV7vdr?=
 =?us-ascii?Q?VVPkznxLHUqe0+A3uBp+oPoNKdHhzicHXLGAyvDlrWqABh0MfE9TRN1YS1Ez?=
 =?us-ascii?Q?L23zK6OPDC3XRjmDVhA5TW66D8SxT3/XakM5ZGyNy7bKyNLLdmUjpI0rJFsK?=
 =?us-ascii?Q?36SzdIy3VQm9IgvzU/W5/2seR7cyCCYqVGaVk4RIXtql1yhS8fjMW3xx3JGC?=
 =?us-ascii?Q?cnCQ83m6lMKlgoc3P1GfwE70evb/vjhLuQRXAgdL3ly0KRWZxNRTBeEOGWx0?=
 =?us-ascii?Q?hm0c5yKEZkRnEJKBgvgPkp+w4OyhAjlO/TD3rZFOdcDNSYs78bxBUfBZZ+48?=
 =?us-ascii?Q?lQaqUPsAcdyJaSgylvcr2m6HvZ7DtfqqN2KeaadxyHdNbEF1dtZmOCglHkuv?=
 =?us-ascii?Q?NjQoMyAilGnhpYAT3vyp76FPQ89ACzAQiFTdW2HD4ADH5zLCuEsUrAd+FBCS?=
 =?us-ascii?Q?fXbDgZIIlrnD01kW5EQ5LwUfzvd8SnkE0HAOFYy3msSx4ZfNYzL/g5nyN2TX?=
 =?us-ascii?Q?oLpBR0QccmCaD+v96rI2N6WtGoKpXQjUGp2Ec9xLewc49fiTkyI5rgdrwd61?=
 =?us-ascii?Q?GSTFqGuSngJzA4Syn/NK7Yqhrk+AshSrvEwP+zC9b2kpIwR8BfGuz5WCpNY8?=
 =?us-ascii?Q?lN3f06WR+FlPYR3DqyC1vvTi8sb7PIfrl/9BgmcGpopV9cFak+AI5+UZYHqK?=
 =?us-ascii?Q?RyrnkQkqCRAs9zw67imkOkrJimHcvLma3cOIGxWfOsMM29FoI77J8AN5p3BQ?=
 =?us-ascii?Q?bqLCBC+totSuZos4czL01Ek6pLuVF/HJm+ZQ4JA6sRZwNMYtPniPCB11Pumw?=
 =?us-ascii?Q?YOXpliWlZjgFG4NcI32jt5mvbmVKrJmFzLTNYWTxd5j14Gk7DkMdkVhlbgI4?=
 =?us-ascii?Q?lY4f/lWEasmUOzb7GJEOYw3joFep9LwLrzh2ppgAz1hX5HhzevMpMi0CHQCQ?=
 =?us-ascii?Q?BnNdlHTBaw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cdde369-9e28-4407-8483-08de9479c272
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 07:46:20.9652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XpgJcxoGioUDjKm918qlou/qE5Q4/yWRHpnlIwHa3m082UzV0tM5eyZGiYla1FFK+JUntRxjULovSQv7WabFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRRPR04MB12570
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

From: Simona Toaca <simona.toaca@nxp.com>

This option needs to be enabled so that the
erase size of the SPI NOR device is parsed correctly.

Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
---
 configs/imx943_evk_defconfig | 1 +
 configs/imx95_evk.config     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
index 6acb49e47e2..624ee9b73d1 100644
--- a/configs/imx943_evk_defconfig
+++ b/configs/imx943_evk_defconfig
@@ -109,6 +109,7 @@ CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_SOFT_RESET=y
 CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
 CONFIG_SPI_FLASH_STMICRO=y
diff --git a/configs/imx95_evk.config b/configs/imx95_evk.config
index e7832d86fe9..30ad2e60313 100644
--- a/configs/imx95_evk.config
+++ b/configs/imx95_evk.config
@@ -120,6 +120,7 @@ CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_FSL_USDHC=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_MT35XU=y
 CONFIG_PHYLIB=y
-- 
2.43.0

