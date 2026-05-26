Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBD3CD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 06:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BD84846A7;
	Tue, 26 May 2026 08:08:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JgdvCfBN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E5D7846AA; Tue, 26 May 2026 08:08:41 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D844846C0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkz+IaoLcEJWKmGa61+ITfmSuSRUkJBfGqY7fG6vG59Zrdz2quUzo5dXHEoay9hdkeMwL5MRT4J4WCZ3i1e40VCjTWH8L2J0xtAqyw8fumHU5kh0vrh0ScP1FGM5NUc9I9ay0yj0A3qlvbylcVciOqpFBsJ5JzqhODNhTzzdo8mZhvQE0A3hcko9JTGzArJv/d9eT9H9zDD18kpAZ3BnB4n2PKsm7D5SRsQQ5UhoEFYT9WC9zxScq/dRRWRcbMJNU5/2RnTnFkCId7zBaSZRbe5Q6LpgoqdkAWBvIFpIxQdWWdQN0OKfnxxX2sx45972AzPihWZOrNUzWODZFupAxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vp5qWdPydW27bnrVrmdUBMvlioqk6vyrWiwYNqd8QB8=;
 b=USXepWXu4mt7/lCeTtuCaPA31Kcua+odAZWCETi8GVOFx6hqHLH5CmFAjCW0yoRlSNcpLY/0nJsEqHMt3ronvzHCu/o6lMI3Q6BHeJPfY783+9M3Bhu5kq1884h55ohfx3CDlJeXOiXOb2Nn0pnpob7ZqUPgp9Q6mtN9dqV0x1lLjOMBAw16dYm+qrzFE+49weasgAZeEUTQNG+yd20NqFgDNUehTlrMd6CNww75zDGGqpTLtyCrqibwikUSTZapILCDDkL7aCoECuRuHUXGo5zrRdtdMReeE6UewC4dkuf6+W9grCI4JM+2iK4q02w6V299Twnx121qcUXD0lvWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vp5qWdPydW27bnrVrmdUBMvlioqk6vyrWiwYNqd8QB8=;
 b=JgdvCfBN2f3q8RJ87uS75ypDtxT6+loRwkpgPzaCGOXZCh655t5xJpDVeE9AyJRt6z4ywxcA4qY4jhlx0ACG+BuiG1aeEZWLcl7cVg+DyYNNYMcZxwyLn9FN4CtwBQSzfWNMI7JMIt/O8RlGxpTxMS9hoCuvWqczwSgGgz0wplQY7/dfZSLHgtgiCyHDIL8zenzFTKqOyiMO0viIP2Gu0Tl0fVfiMaKcoX5UcOrq/Ri2JKeT8MHtEuR4eM3euNG+1rAWuvwn8Y53w1kF4izSN4wRPe35YGE9Piqg9MLu/uNncoLDbJh22sDTqlFCzM9uskKMkZYUG4861cBql1exZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA1PR04MB10098.eurprd04.prod.outlook.com (2603:10a6:102:45b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 06:08:37 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 06:08:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 26 May 2026 15:25:12 +0800
Subject: [PATCH 3/6] net: calxedaxgmac: Use dev_read_addr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-devfdt-net-v1-3-be3597b85b5e@nxp.com>
References: <20260526-devfdt-net-v1-0-be3597b85b5e@nxp.com>
In-Reply-To: <20260526-devfdt-net-v1-0-be3597b85b5e@nxp.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5P287CA0049.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA1PR04MB10098:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dbc36bf-d4ed-4d6b-e19e-08debaed3984
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|1800799024|52116014|7416014|18002099003|56012099003|22082099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: ibZH+6vJH/BuV659XT/pJUD8cLFiZnfkJYWPuqS7SWTaCgH2oVA3MITYL+6gv8lLnACx9AhLgV3MtMXhKcinx0udmsfxL1jL3gc36Brc7bY5q/EUeO+aZigRoni5B4I4sXVD/9f49cRVKbJmukU1kICJOlWpdOnCapXBBXz+qD2lZBYWqkFSfrZPj3phJD+X6sgp07NTloaiee5HzIj751l/FqsL2oxJbItesM42HC8DWoX+FBGU9XtA3uLyIkFV9CUbU0HEM53lMaBCBa8diPSovLwxEc/UguOFM/LrtJYYRx0cs+x2FlcNBf66njAEYwmq2h/oeYTvq4hy07frau+BH5meYq8ZnlOqJ94wdsJz1qtybZEvxNRHPRaY/uFg+IimolaiJMxRL4jy9xcSwd0YgAkomLnnJHx/CH3H+QLkNyLZNZwuh+th4MedlNpOud7BjIO72dGraD+bRBYw9unB4BAuUS1F7wVQFcAMgrAq6gzk9kfvHlvdg5m5S3bwi/KNaR0IoYp+3sAEqPPAoUPEq/6c18fYBRqg/TUG/6zsUW6F0qHCIPy3G12SadH+QPrqz1nthA2GOPLAAgBwgY2OTVt0jRSvmUYNBfLR/Z7izDEcvWAONL21KIzFERFS6yeXxM+K4sA7V9zHGFz8rwNnmXlRj56p1Oal+tCzxTZRFsimvrVannS2VD2jlsdOwivg5odpNePUEvjzwSDF1hRJ05+Eybb8sggqQvXljrMXUW2t+hjmj5+uzTf1ngs+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(52116014)(7416014)(18002099003)(56012099003)(22082099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1EyN0tuckFxdWFNQ25jYm10Nkc1NHI1ZE13MWd5SVBJVzFFTUs1YUtCRFhD?=
 =?utf-8?B?ZStSMCt2OXFkMXZQbzVUbUNSeG13RzkvaXhPdzc0WWhrcEsybU9udjhGWmJi?=
 =?utf-8?B?WkV6M2lNdUYwdS9qcGEzUWFpNEJGY2Y2YzdZN0d5ak5uaFBHTFByd2FqUVRq?=
 =?utf-8?B?cE4ybXh2Z1c5dXpDY0xtNnJCVDdRd3dCM202a0VKeVJHK0pQSFQ3d0xKdGcv?=
 =?utf-8?B?VDZWZXdBdDJHTjVWTmV6VGxuREhGQjQxa2J5SzNhTHVZaUM0THpkajdIT29J?=
 =?utf-8?B?SHFnd1JidlFEUnp0WlI4L2pwMmlTSDA0QW43QWlMdGZKeW9Oenh5VzVsTG9w?=
 =?utf-8?B?YzFtSWo4WVBVdXFqQlJOMEhhY1o3TzZUU1IzQ0pBUktraEU3Q0RvUzhSRTlU?=
 =?utf-8?B?R2lIOG5GVVNkRXhhdzFyNVFjUEl2b3BlUzZxT0F2TXl0MHVOZXVjcXR5OUIv?=
 =?utf-8?B?aHNHMnBZRGwyVk5KTlBzMnA1eGpXZmZvei81MmhacmJjOEJLMkxXRVUvR1pa?=
 =?utf-8?B?UERlbjIzd1dsb2F0T0NuMGdDaEc2WTVIa2JUQUJYbWYxeGNYd09hT1R0VWhN?=
 =?utf-8?B?YUV4UWl4c2t2eE9aaVZLRzFnVjRaT0VPUjQwY3gwRWQzZ1h6TlM2WmZMTnZW?=
 =?utf-8?B?bmhUWHJBVGd4bzdrM3prbElWbU9CS0FNSFFFZGpuWWp0SXdxRVpOMkFVVXkr?=
 =?utf-8?B?b3RCLzZjcDdyVk1PL0h2OVg3ZVRWNm9pUUE5ckV2SitlVWJUcnQ2TFpYcHZy?=
 =?utf-8?B?TGlGbUpSQTY4MGJGbXhkWXhHOVpQcGdkc3FwYmVHeFRBZWpOZ2tLV2hGUWtV?=
 =?utf-8?B?S3pldkpIZE5vWHZIWDArc0c2dVMyckFRcEtzTGpHZGZUVUEyaHQwTjViRXRT?=
 =?utf-8?B?ODJmVlhsNUIxV1dyc1RsMkdodytMM3B2OGlQUGtNZHBCRFlIUnBXZXZUUU5U?=
 =?utf-8?B?UGFGUytzY1g3cWVMNTRIeWVkSW13VzhBM3hhcW5HRHJtenBTQUdCOGowR0hh?=
 =?utf-8?B?Zm9KNlcwSWN5UG1QVUJ6dnhZK0gvYUI5WitqN0R4K2I3R1VnY3Q0SHR2d2dG?=
 =?utf-8?B?cmJBTTFQWGVvbWFoWTdiVmt2TlBhS0Zpc1p5ZXJ1ck1hK2FnQ2pYZFRvUGJ1?=
 =?utf-8?B?UUlvcndQQ0liaWE1OWJxYU5Ld2F6NmpkSldPclZNOTE3dUVlc0VpWlpVT0hU?=
 =?utf-8?B?UGc0eEFSTncrdG1mUnNPdkFjaFNtQ1NOaXNkK285WWhqR2xUWW1TNzhwVTJG?=
 =?utf-8?B?UkxrR3B6TEpKWEQxeWp4amxKa1Yya1ZQQXVjbWErR05SMTloM010aU9yY01K?=
 =?utf-8?B?K3VRbHAwVjN6SDNQNWZBeEsrVUZZc3RtNnY3Yk16b0szYXg2OFFSZkh1RlQ5?=
 =?utf-8?B?V3ZBR01MU0k0YTIxM2g5QnVXMzR6cUhqODY1Ylp2WlUrR0tiQ2N6aFJLOW9K?=
 =?utf-8?B?SDNkTHQ5UFA5UndYSHpiaG5WbVBacWF6VFRHR3RwcjBwTS9OeERIRGtZam1Y?=
 =?utf-8?B?dEw4UEIyUUJmVDVYUEFDQ2I0Tk5lSU9Hb3BUanNvME80bmpvTTVkRXhLU1JB?=
 =?utf-8?B?Mi9nQ1AydVNUVVhHMWs3UU5VSTY5bUQwTkFKZzdwNDYveTBqcnRLZFA2NmpE?=
 =?utf-8?B?ZmNQbmZRZVRlSTM0YnNOZWV3cHdKbDlqV1NMSnNuOTRUT28rdVkzWUZnYlNC?=
 =?utf-8?B?YXZLMEN4aTZtZk9YYnozb1RTeVJGNVhmSlFRT3d5ZXE3alNhY3NHOVJVSndv?=
 =?utf-8?B?SjVBenN5dGxsR0xNc3ZEejI0bElJZWZxczNQZ05nU0hyRUhRd0RmcDUxbkYx?=
 =?utf-8?B?dlhxcTFNaW5QbzFFaXpsM21mTWlmVEhzaThkT1NacCtoelFRQUdhWmZMb3Ux?=
 =?utf-8?B?VTZPQWFuemw5RGI2alEwRlFlSEEzdjJWUXRCbXoxTlZKZHdHUjRSSlkzL0g1?=
 =?utf-8?B?dmV6cW9vYnZxY29JRzg2Z2ZCbkRKWnVTakJHREhWSHcyc241N3ZzVnZVU1pT?=
 =?utf-8?B?SjVwaDh1eGNUSGUwR0s0M3BFbHkxd3h6TTJ2elFIS2JYTWJidHcrcmI0LzR4?=
 =?utf-8?B?N1ExWDkram5POFg3T3NZUkZhM28yZnpYRmlQR2dPOTBQSll5Zy9paCtGQzVC?=
 =?utf-8?B?RHlyZ0N1L2tvMXhPdWZLWXJGckNTQnd5ZlBjOFdBSFUrVDlGaTVGbzBmS2Fu?=
 =?utf-8?B?bitOVjU2UG1uTzl5UGJMZ1RlV2dIbjJScVZiYTA1c3hqLzdQeUN3bXBvcm9F?=
 =?utf-8?B?elY3S3FtVVZoenRkaDRJd2N0QW1jWitldldPb1ZMNUJjZGF3RnRLZG1ROUNE?=
 =?utf-8?B?S290L0p1TDR2YTRFQ1ZVcjlPU0dJeDBlTkxEclgya2Uyd1VrWGkvUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbc36bf-d4ed-4d6b-e19e-08debaed3984
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:08:36.9920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdYeUufKUKizHK0gtTo2dOmQZabotdG9rcHxawZ89Ik9zlQhRxeIiMuYCf09kmf58p+tt7+Bcz86jpQyVUTSHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10098
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

Use dev_read_addr() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/net/calxedaxgmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/calxedaxgmac.c b/drivers/net/calxedaxgmac.c
index 92990fa6d47..df0ed820e06 100644
--- a/drivers/net/calxedaxgmac.c
+++ b/drivers/net/calxedaxgmac.c
@@ -555,7 +555,7 @@ static int xgmac_ofdata_to_platdata(struct udevice *dev)
 		return -ENOMEM;
 	dev_set_priv(dev, priv);
 
-	pdata->iobase = devfdt_get_addr(dev);
+	pdata->iobase = dev_read_addr(dev);
 	if (pdata->iobase == FDT_ADDR_T_NONE) {
 		printf("%s: Cannot find XGMAC base address\n", __func__);
 		return -EINVAL;

-- 
2.51.0

