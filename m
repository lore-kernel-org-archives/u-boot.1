Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB94CD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:19:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 341C584878;
	Tue,  9 Jun 2026 09:19:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OFXHIM6Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B564B84878; Tue,  9 Jun 2026 09:19:28 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3FB280087
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQDTJlV0RLEAP2VoT8WTJY1kZ47l6IaYEWqa3sfx9v9tdLLPiY+imFKLxE+C40gIEPMIu8ftvLLSQ/1BlFqtSSUfPwwn3X8qmO66KXtK4KzpUkcPnXjkFJUUrb6VGMOkpcinYDSvELyC9moqu6QBrVtE3jqSdV0mf+uo/kTDMfDb4+FepY4/WnlYR+UerSljfn3ntXuMEXuMn81rSze9ZmrCiRYMzCRb302ElUUzMKOxcRaeo4yOwW8KDuzXE5lfZLrPdn1kRVNfHUkt8ifHwnoQS0cdp5R8ouC2dhUsinqebjnWZehMs+PWlfZVaUOtaqdZdiS7mfIjP9s/rposaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFojeUu5UJKL1MqbQUu6u1JUjsrVsQElNmhxNp2E6+w=;
 b=S9LViM3ETFSCT7jmOjijKlALvtbYeyeDc55lYa3Pbi3Iy9w8NMF2autIbt8N+PxD12DFMINnSG6ARVU4gWZcRRg33+LjABI7/HSOAWDjfo/1POYZXSabKQ4idhHCVv0vfH1rdwQ9/Maxh//wQmjyahKFPg5VKHlpMPPsqB1kXQ2067U0mpPLGdRVi+yLwHPAUV9/jqxhrgN3tJVIWGOUGbPguN6PGXWeByhZNdRnhvQe6KlpM9zVhQZXww4GU1Ns4eRIMM2o7fDRkAZQjldH/wNiX1MiPGKrL6Zdu0IzC7+uqqlouVlAxxRiRqaa/6XQxBhioj6iuowpI4niH0FkvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFojeUu5UJKL1MqbQUu6u1JUjsrVsQElNmhxNp2E6+w=;
 b=OFXHIM6ZSWlqx2nWWJpLbiijswz7YXlSGgjcu/s9KEEPWNHTA7uEwNoE3iCjp9lZOMq/hY1c1GpCWK6BxtgGew3O7oqgAmsVX5eQRugAgdN3U9JtJvE0JQGaEE2KwDUntPoBZ3tqcu2dBNIwLE1Quj7z4bsYm157b6kSfUxP3cLjAp0oC+yo1VbN5fwOR/fPgIEMryS2h+VE3Yh316Zg3lfF6iWBURuhruLP+iME2SLZIQXqM1QV2YSB7j1C69vnPqcDq3GBIdqdgYFQGQyxXZYDP5O+QZdhGbd0isBrEki2OB6+QIVwi0tOsqzGwd5A5YinuzB2R1/3KfW0g/ODKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AS8PR04MB8755.eurprd04.prod.outlook.com (2603:10a6:20b:42e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 9 Jun
 2026 07:19:21 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 07:19:21 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 09 Jun 2026 16:36:21 +0800
Subject: [PATCH v2 04/13] imx8ulp: cleanup get_imx_type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-imx-misc-v2-4-58e1665d55ae@nxp.com>
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
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AS8PR04MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: e2497339-be5e-426c-6822-08dec5f76d36
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|19092799006|366016|376014|1800799024|22082099003|18002099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: uynbZNVKXWo5oOPSyal+Kgk8E5Hb395PelXcH9rDjQU8LttUqXvFvdKwRUT5lKnUwUThRv726dh1byWb6TxfGSN83Bm0tVs+qHim0qSL+NcDPDep3FyM07/MshoXxmjVpPYDBH3bquXnBWuc4ggaAmGdxWD68wv2cPkZepFXGTJ8Y1EGxdVaXGlQ4P6dSs8iMs98coEyFDxTiXvAwoY4368+gKz4fgQVngD6lI7aY2JzugQp6tKgAhNKSCMuGAWor4j8LC31CM/oQtHj826miM4ubDdYnk3NR0CxgXM5AkRXREbXr7MSNWlbTMTM45Ou89jTi8GJzbl/TF2bycpZHnEaqMgavQ57nVyCD6Ol/Rwjma+8wnJ5hji2M3x2723LLZ7aYY4otRFRmWomX9//E46m1NY+dd/ZYbSSSLQVstfLgEDHu4eN6TO1lOiUrZRVVlvo48MsDvmTSYwUybariYS+bmx6uzpVwkk9Rd20wBGYLxsrmwLAdml377lrMqri8C3zetnVdULkUC4c6uXq5xq78t+iyP8Yg2wDH1WEYBKpS8Tcq+CAKMFaWmvf1ONE8/iXltQORBOvWEjupQbLfMxKkv47KiBU0aWg9layIkNz5x3nwZT911mzpmSBmmqE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(19092799006)(366016)(376014)(1800799024)(22082099003)(18002099003)(38350700014)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjJMZWxzS0k1cEd2TWNqWnZHaU1nODM1WWkzVFdpMW0wN01sT0tUeFVCTlZL?=
 =?utf-8?B?VGJiYm41a1hsdVRQRW04R0VYZG9JZ2xlVUp3bzc3N3kxcVBMSUtKbVJBRmZK?=
 =?utf-8?B?WTU3bDdhZmZrOTUycTJsSFFYaE1XK1c0QjVNalVCTStvbUpJK2NMckduQnoy?=
 =?utf-8?B?d2pvaW1oU1VoVmxSeVBYZnlSeWt3Rk96QWRSN3pVM3Q2WEtybE5uTVoxQjBL?=
 =?utf-8?B?MlMwQ3ZrK0NOc3dsYko3TDF2THZFbU10VHpzaXVOZEVMNVMvRGEvQWNGUzk5?=
 =?utf-8?B?RVBteUNrV3pIY0hZcGxveXFtVksvWUIwUzlXZEZkVTJ6RG0zYVdPRmVZQWhL?=
 =?utf-8?B?bWRwazl4KzRFa1RuRTN3V2VEc3IvM2JaOStzSGF0a1ljRzRWVkpSVWFDSFJM?=
 =?utf-8?B?S3NKbHVNMyt1d3cyM1NJdjUwb21Eam0zTzBiOVJNc3ZqVCtnY0MvbDBqTmdG?=
 =?utf-8?B?bC8rQ24wdER0ZDRMcEdsZUJXN3NVK2JzWWRHcDZ6WkNLZ2NPMXJVa2x5aHk0?=
 =?utf-8?B?aDRwMGVxcnJud1grZkIzTW1Zd0oyWmI2c3l6aXdob3k0bmdHMEFHek5SUUk0?=
 =?utf-8?B?NW42M2laM1hvMVRKdFduK3JKdDAxNDVRSExyL2RFMWpTbS9vWkc4S3NMYnly?=
 =?utf-8?B?SVpMRVdIZ3dEY29EWWxGOWhLUjE1am9uWWdxSkp1ZFFPNzRQZ2pvTTZ6a2xS?=
 =?utf-8?B?Sk91MS9icEVmSFNnbDlyMVJMWDRZWndpN01sMnUxdXNGaFYwT25yeHplYVZo?=
 =?utf-8?B?Z0ovUjBZRzB1MEUvY093Sng5YzZCbDV6T3lNSlNYZHBGRERxelpIUTJuemts?=
 =?utf-8?B?YXYwR1JTeWxmRlhEbUVHTU44U2VqY3MxK1NqaXk2ZU1NcHpiNWp6WFZ0Y2Nr?=
 =?utf-8?B?ckpMM2pCMGJTTXlrVDRHU2g0T1JkbEZaZk1CSE01bU54OG5DWXJDSXo5VFlX?=
 =?utf-8?B?cWp1MWlYS0MwMFhzK09NeVlIOHAwVzVzb29nSXg4d3lhS0NxZ0JKM0tPV0RF?=
 =?utf-8?B?UHZTMnJoVUN0ekx0S2xnOExRVXFPV0V6dDF5ZUxlTnk1Y04ySzNYSWplRnky?=
 =?utf-8?B?TFBSck5BU2tsMVBvQkpud2o5MFpFWVdLYlNCdlhyTGdwQ3ZxTlJBbkxGT3l3?=
 =?utf-8?B?MXBFYWpMenRvUVI0UDhNMSs0WnlBQzExT2M1K0dPeDFnRzJYWVNlNEdOYmht?=
 =?utf-8?B?dE4vNWZQcWl4QVpRcC9mbkZucEtJMUFOQVhLakhvSGJudE9kSEpPWjgveSsv?=
 =?utf-8?B?V20vTGtuUnJUaXZ4UTFSRm5kNHZVR21uUHd1VUJIYmV6cTlHekhRMnlCN3Fk?=
 =?utf-8?B?Z01rRGF0TjVJdTB1T25tWW9kOFpIcmlnTTV1ZktSbDFTNHdHRURrOVd3dHZm?=
 =?utf-8?B?MkZXcVNoeTM5Z2NGWmJ6R1MxSGNOTm93R015dDQyak5yY3F6bWJwaFJrL3g1?=
 =?utf-8?B?QXFYcHA1b2l2NkhxNjI5QkhNaEl0YnhnbDhtOTI0ZUlURVd4cW93QUZKR3dy?=
 =?utf-8?B?dGpNT080S2M0RlFSYTdKMzdDWmI4MWNFc1NjOG83dUFqdE1sbUlvWllRcGRC?=
 =?utf-8?B?cDdKN2J5M0RhSXRsOFVnOFYvWDNzYk5CMU9RT1lJTHRuV0lXUFpaNnRhOTlZ?=
 =?utf-8?B?UTdIczNwdDZVV21SbUdYZkxKa2FnbkFwOTdLdzJYZjZqRXZwOXlUcG5jajFs?=
 =?utf-8?B?QXV2MzBjV0lZSGNRclRJTXN1aFIrcWtCNzZBZ2lrcWZXOFFGK0o0eWhJQ2lV?=
 =?utf-8?B?MU03aHVPRFh6akVRS2krMklHZHdTTk5XU2hYZFA5anBPNVYzaHlBb2ozT2M5?=
 =?utf-8?B?UUhrNUNlc1c5SGhKNlpzMnF6QXExaC85ZVBBSHVMaHVlaGM3cXM2T3NudGtV?=
 =?utf-8?B?TFJzUld4VmRxTjVhcFpTV2JTU3RIT1NIQmVQU1A3Q2p5cDFibmttZytnNkcv?=
 =?utf-8?B?OU5WWklZNHZkLzJNbnlWR0tWUnV0eHdlSUFwZjlNdi9zVU5MK0Y5THhaV0Fy?=
 =?utf-8?B?WHYwb0JUTVR0ZU91QkcvWVVCc01xVzg5WEhOR1dqSnAzYlJlVXhnWUEvcDg0?=
 =?utf-8?B?c2trQUNRUS9FMGF2MFA2cDU1UnBuMGl4Mkd5RFlNMmNMTkhFdGV4ODJGc2RJ?=
 =?utf-8?B?MkU0VjlRV3lDRFo0ckRIV1ZpcGNKVWMzUnAwMExRZ3BpVGk4WmNhWW5MN0Rz?=
 =?utf-8?B?TUVYWkdkcVNqMy9pbTNsTThoVUhBaTZWR2dEUTZ1S3ozb0xoUE82eXBZVFRR?=
 =?utf-8?B?VVF3L0FCMEh0bWVLcHRxa0pmU2ttRmg0ZFZNOW1kOXlYOTBhbXgxbHRlQlFD?=
 =?utf-8?B?L3hoSzF0V3R0NncxL292cXpUZk1SaUI3WjRwNVdxcG90ekFjWFNaZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2497339-be5e-426c-6822-08dec5f76d36
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:19:21.3963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndsh/8eTjHvleA2QCg3ZMSEWJ5wx4NG8/o8yoYvlocZX+UmOVfKGL5U1jUDdBmOagxEnvPCRLMyHvIAIvO2M8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8755
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

There is only one SoC and no external user of get_imx_type for i.MX8ULP,
so directly embed the string in print_cpuinfo and drop get_imx_type().

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx8ulp/soc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/mach-imx/imx8ulp/soc.c b/arch/arm/mach-imx/imx8ulp/soc.c
index ccdb949a9da..5502fe5efdd 100644
--- a/arch/arm/mach-imx/imx8ulp/soc.c
+++ b/arch/arm/mach-imx/imx8ulp/soc.c
@@ -254,11 +254,6 @@ static char *get_reset_cause(char *ret)
 }
 
 #if defined(CONFIG_DISPLAY_CPUINFO)
-const char *get_imx_type(u32 imxtype)
-{
-	return "8ULP";
-}
-
 int print_cpuinfo(void)
 {
 	u32 cpurev;
@@ -266,8 +261,7 @@ int print_cpuinfo(void)
 
 	cpurev = get_cpu_rev();
 
-	printf("CPU:   i.MX%s rev%d.%d at %d MHz\n",
-	       get_imx_type((cpurev & 0xFF000) >> 12),
+	printf("CPU:   i.MX8ULP rev%d.%d at %d MHz\n",
 	       (cpurev & 0x000F0) >> 4, (cpurev & 0x0000F) >> 0,
 	       mxc_get_clock(MXC_ARM_CLK) / 1000000);
 

-- 
2.51.0

