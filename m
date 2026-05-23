Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF92CD5BB1
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 12:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5965D848A2;
	Sat, 23 May 2026 14:23:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AP4y6G2+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C686C84886; Sat, 23 May 2026 14:23:14 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E640A84874
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 14:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxwJzZGCXgkzbqwkSJWxYUNXQFwVU2qiW3pIwrjAoDzPT39dNFTcjXMxVy2aPFh3CsaFV3iyyHjqm0bkQ8In9nUrlnA/zv5rYuE06kXQw3HeAkOQvn+6YumbzroaO3dz/Mv7zCRIGjJI6AavpeUMRHrrwgYGKsaRckfOBA3W0ck42k8NFTesTD7Q4NpLC3+km2ve3lwzfUPgyA8jIm6w9EjTX/JC9vlJbIEzeASReX+P+BBlDfaRLghX3SjBKH5SnFUUxerfVjcRMR7X3LIFtUVSJpPCTtACRAVrNud5uuC7dkRZTmwCsTSOoFbXMImK6FOQrpV5E6fGW05T7G8rMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndhW1hjRm7uk7ERJ13lLFiymnD05+I6oZalGAMnscA4=;
 b=ONRh/7VqUrRMGOe2Wa+rOidSy9IpRZ8aoYSfCuiwUWoLHebduDlaAP16+VNnv/KJgezWvlI9/dkzGKtc0v9cX9C9YXhSCZRyYQYQtmoJ3tfcc3e5Xeqvq3fnL6Aek244AWuU3TS1nYLQ3ybUNKG/uGx0X4RPFTtMXS3OlFV+eyqhohFPD/grl4A2QtjeQ0mvvxLEmUV1gpa32/izMLXhGlGV2L1PwrtsmrkIO0tfcglmVu6OZZKyuk4fk1EwFg4bcoB1tGbeqcOTlCnsHGk1xgGv/m5vf0+xAJvERzZRSvnc6gGLzwyQiNqYt0pgDPNQrkXlPwMzI+NQnaf3L+HXLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndhW1hjRm7uk7ERJ13lLFiymnD05+I6oZalGAMnscA4=;
 b=AP4y6G2+ml1hueJcene6r97fY83aWf7rMKA2fv+0VMtK/sUn6uOmaLI/R2hw8bt5gFrWuw4/JGLp8WQLieesA5JTIQmE2N3iF9/P8bHON4x1zktISgwry+eswkuH7FAvvr2wo3PzMfg2WSHUjgGjsRBJD+l2g3+Mrq/GekOXFWgzkB+u1/KyV5mdI0hyYIUL94NqwP+Hlp+T/bdig8Rmg9922k7qvWxTBOyoSbvDdzO9purVvKxowT9x0KuL5AJBDNvJmRokNiq5aWhoElofuB8ngTKtaQJnEMEYJb2kx4G/n3DE6WJKwy486Hc/zvaBLpCgW1N+db5f9Frnmc6Krw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by GV4PR04MB11976.eurprd04.prod.outlook.com (2603:10a6:150:2e9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sat, 23 May
 2026 12:23:11 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 12:23:11 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 23 May 2026 21:39:47 +0800
Subject: [PATCH 04/13] imx8ulp: cleanup get_imx_type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-imx-misc-v1-4-2898c9eca9f8@nxp.com>
References: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
In-Reply-To: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0255.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::6) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|GV4PR04MB11976:EE_
X-MS-Office365-Filtering-Correlation-Id: de3ba449-bfdd-43f7-63ed-08deb8c60e1d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|52116014|1800799024|18002099003|22082099003|56012099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: dTddm2whSR1pkB2273EgNBLrLpYDpV2YfRqCNb5U0tU8rRmuLalpiQ/4lL0qq3vBW42B4cyLcXi/TQZ4fqc8lTvwuVKx1xfA+Ka2dOcTRXJ95nPpwhBCMf+X+KPTqxfN8qFlr1mu8P0A4qqqba2hTklqiePMJajWo8V0zyWdx6tD1ReSzXysP++ftswL/d3q8+AWXCVt35F88EhzSkuQyV8VJLXOzhz9tyuQK6JgtIN/TBOSGg/GmH5PjmZbjnBit/vv2AAgoA5dx+uxJUj0k/2CElSZ/3xAuE1ELf9uGPN4IDaVxzJhJQZ189P5vEIP5FWPo53ypg2iQ0wPW1Ew05NT2DLgbWvVN6M+OLGlglofngFJduQolUg0cF6oQWN9WnYo5afhm2+VOFne8lyCrL7EtmRHruonMxcxmYgFQCd/Gh+RMdhtoLnLEnPtBYZu51+5ntjukt49P1kRvPSgsPTnuZeVjWZGYeYlGE5aZEPGiQY//9DlwFGAg1sygGPIJvM9z9CVf5CZx7jj5RKB48bI1VxSrd8IZH6TN9R/Y5SfW5aPwELn7xGKkY9jdCQRRi/IRzNSfev2PNRReqY++yLRlGovWJ0cPvJgVUSSvV6UAYr45pN8SnlfTdw4J1M7a0+mU6hzFC8JFiLtIyEyra6JawHX2+oDYoPxUerMfRpmw12K0Fpg7CUSYULWZu2yyqygdGCHDXsD43hDwg812vQ9iufDyUt4gtCTcgXICm0hJCFLBp06/92V8iHCRmkR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(18002099003)(22082099003)(56012099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUtSZHdKMmt6eEFIVzVXYTJNTVh0Tjc4azVCOHBvck5ZZWhqQUZZdXhZMC8x?=
 =?utf-8?B?V2tpYnNsaEZWeFdiK3drcXl4OW41dmlCcWNiK2lENEord3k5U09kRURKbWxu?=
 =?utf-8?B?YWxWQmNSSDB6dFUxdWp5bEtYQkdObW9SbWQvK3RGWjk1cCt2cFd6T0dmQWwr?=
 =?utf-8?B?UmNVaklJMndYekdkdTlOZlVSeHNKcUN1di9BT2dsUUt0cGdneWFZa0JPTFJs?=
 =?utf-8?B?NENLWUdiZCtXc215SjhnNW9SaVAwUXU3emNNdFZJY3FjZVMvYTFxUEdLcmVx?=
 =?utf-8?B?d0xiVy9GK2R1bFJhY3dZeEtyQk5oazJRL0dZcXVxZk5LLzgwbmJCQ3BReFFH?=
 =?utf-8?B?bTI1TTVJYnpHdUp1YkN6WGtrQVlvWjVWejRWWVZjYTBsbjdRMng0Wjk2UXZT?=
 =?utf-8?B?WTVjaVpQNlNxd0t5ZndGTExhbVNWV2xpSjdtUGh3Q2tOalVWdzI5dy9GeHM5?=
 =?utf-8?B?Q3RPUlpXYzB5aG8vem1IVnNvZVJWTHB3amp4S3VVNUMrZVVDOHQvOTRDbHFF?=
 =?utf-8?B?dW9LcXkxbzZxY1MxT3o0dkhPNzZmVHRHRExjVjdWVTVoWTRUL0xZOTlEU0xn?=
 =?utf-8?B?bFdzOXlXM2RDbXpIKzhiZ3l6dW5wQVRQcm9MNEpLeVRTNVRjRW5BMGw3ZGFn?=
 =?utf-8?B?RmU2RUJreTVSYVJmVW8xZTBJKy9yejRxRkQ1UlZQcmlybWZkMUdrOWQ5U29E?=
 =?utf-8?B?VXJ4TlZyVEdSK0l3Zm5OelVYQk1BaG55SGJTdjJRVlhGRU9wY0VxM2RpQWVX?=
 =?utf-8?B?QXQrV3Z3UWFKelFKaEtBMEU5MWZIcFdURElRMnZ0KzFFNFpLR3BMSmdXSzhF?=
 =?utf-8?B?Z2FmL1p3Y1dsNUk0MXdzWlBGUHdWMk9zcEV5SkNSUUsyZWx1a2QvM2VtRlRX?=
 =?utf-8?B?aFBpNUVJT2EwZFV1TyszVWxsS3hWdVFUZWhMNGJrQXl4WHRBRElBRTJ3eEZy?=
 =?utf-8?B?R2ZubDJkLzd2aGFmUVB6a3Q1Rmw1WU1EU093L2ZlY2JQYVBTZ25VNWY1WEFV?=
 =?utf-8?B?UjNkRTdpOFBWLy9iZlhtY2ZkeUNRODRCbWt3UWRVWlNKUTdNanFRTU5BdUZm?=
 =?utf-8?B?Y1E0RW40NDlpb3dyNFEyV2RlR3ZJYmtMK3p2c2pkaFYwVHBnM0lFd1lmS3d5?=
 =?utf-8?B?QVNyZnhjdXl5TFFYUFg3T1dHbnNZR0ZNYmx1RDhtK0hTYjdpM2EyMUpDUmtJ?=
 =?utf-8?B?b2FZa3BOQzgyR0hPbi82ME54eW5sU1k4UCt4Nnd6UUo1TFM1ejdhNTZ2YXd1?=
 =?utf-8?B?MWNiRmp4NWc0bUxNQW5TT1YyZlRtUkRQTjFjN2hUcGtmMzhrSFd3bVpLVkFR?=
 =?utf-8?B?b0FEcEkvTldEU2gwTGk2SjhVL2RUcEtucjdrUDhXVnZpQzhzRDJiY3FSWFRZ?=
 =?utf-8?B?OXlQMkp0eFpTeWtWS3VCajFvOUs4UXRHd0FaRjZ0WnlHNnRzRnI4ZEFydyti?=
 =?utf-8?B?TnJ2ck9LVG5hSWxoYkZmUVE2T1kzY1hOZncvL3VITmhmY0JkWTYwTGptKzZG?=
 =?utf-8?B?NzN3TVBuWjQxZ0RrSGN4U1pBeWJGOVJtWnJtK3FvbEJWNWRsdnBEQ3hzU1Uv?=
 =?utf-8?B?VFQ0dzNwaWJlV29UTWFSWDV2aGdJVkoxckFieVRLbW1UTWZVaGhOa0FwSzNy?=
 =?utf-8?B?YndVRGVVVE9VVTlNc2ZZb2liZHNHNGw5K3Nta1JjWnRHSnVZYk5kKzVoNGRY?=
 =?utf-8?B?dkp5WmRUMStGMjFpWnlmaHlLV3FXN052LzRVTjAreithZjJrMm5zNTRBc1FQ?=
 =?utf-8?B?NEN4QnlkRmFhRlhyelhWZncrcVF6Wkl4bGJrQTNncklOTGlKQkJQRGMxZ09S?=
 =?utf-8?B?QnpKY3ltTkVZbFZ0ODhPMjh6RkRUM0VLVFc3VU5FSGhEd2E3TDF3N2VMMnBq?=
 =?utf-8?B?NXlBa1BVT1hPaWltRmFaQmI3MERxUU5vZ2RWWENnLzNudWRmb0F3K24zaFhG?=
 =?utf-8?B?UkNKV1lwaGllZW5RWEduM2FZNmEyNW9EU3dnUFRZNXZoTWFLbmdjejBNSXJv?=
 =?utf-8?B?NndiRnhYRStGSkJNcUVYVnluSVV0Tm1KZncwRDJMUHlvbDB3eWpaNUMvTVNT?=
 =?utf-8?B?dytwS1RvL1pWNHFMTm56R3lSYjhiWk9mdE5rL250WEFlMU8rWStyZ2VoeDlv?=
 =?utf-8?B?eGRoRGVVR3AvVzI3OFNvc3FGRCttYjlDbHBpeEFJbUtYZVc4ZTA2cDdwQUlK?=
 =?utf-8?B?Qk5wNUxvOW5jNUEySUNxMVdVWGtUSlJvU21CZ2pXc2pTSExaa1RhN2tuZjJo?=
 =?utf-8?B?UlZuMDBsajhuVlpZTGZtbHFIUjMxN0RtWUFGR0NXQ25laU03ZTBNeGdMQ2E0?=
 =?utf-8?B?MjI0ZFkxWEdtdXBrbDNNSDFBS3AxSXlOaXYxTHhTQjQxWjZkWUIyUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de3ba449-bfdd-43f7-63ed-08deb8c60e1d
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 12:23:11.3639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ppVuf89Zxs65zGZtuM37gYaQHzkDZckhkjgjhyzEE3Ojk4d6uvM92onW+K6V32XRIwJPS23CORHMOAhJlALAzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11976
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
index 1ee483065e8..5ddd94d039b 100644
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

