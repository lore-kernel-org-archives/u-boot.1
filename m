Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C088CCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 18:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A8BD83B24;
	Sat, 11 Oct 2025 20:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sLkKp0g2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A370683E11; Sat, 11 Oct 2025 11:14:49 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B780683C2B
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ee+KvRDD9LYFLtcQqhIh7/IBYrvRcCrIOmLaypHgyh+sAL/9HMPkqAifu6zJ/25QcQxWC+HziMTYHSDTa6zXxqm9WE+TM6YrLzbtEatiaxow7UHAT1hve6ZlZMpY78rGvO/kIvbpqm8DdH4Ec9+BCF2NnjWfiFlCIFcL+HM/+EU78Z3MHb5wVdqzo3Oyglg5+pd1jotbNPDY+qFPQV3mGs2ub8et2M99UOprLGQ0mwptt04H62j9iubRbe6vL3jJLKHLO/hzrsf6ib4aOZNouwjC7AZM/1o6nk1RsfwrdfHB62DMw3rv+oUcisL2ua01/0YtMVQBz4ZV5onXAxN2eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOumPe5SjZrWxQCoNkSz1g5nlikV5njZ/DcTw7c36pQ=;
 b=wSzbBEbvY7qsv0Tb2M+i8HZ2K6feQsG8aOsh+q64T0tdS7asFb4gsuCdrgP8XbVHhoCGA/QnJNMkKLA59XQE9bXKLdiGw/i1z3v45sOH5LMGW22inzC51Q8tiKuTVOuemJ9i2Yw3ci778JW5MJUBviIOL5qAwxGuxNykO0r83K6LytG3LkS/ZedLVHh+zs1d3wolw5P1J4pa0x/CoHAscqtrSEhB0wnyq4SS4kBWaNaGDEgfCIxPIYoaAYtiHk7fAsU32RHI6h0+UkAAKiYGloKXY6kvR40zkQSftMT5hOTV6g4GTB3HWqJNNixXYPnX1dXO+qMP6rV8jewcWgl+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOumPe5SjZrWxQCoNkSz1g5nlikV5njZ/DcTw7c36pQ=;
 b=sLkKp0g2Ty5/GEEOe60tieWYH3OlaM371qaPT6HrsRPxSsoQpe7yo+Cu7sKIWQ6JRmzeF8Uj819LOiiaP9dDExB3WASbfSLQUuo+1/j+j4wMlOdTcVygi82PxEosjFkooVN24kFvUuUjVGNC1HMYKFGfsXgSntCBYLhd3zlOY3pRx7hIeJiCnJj9KCkTjhCuF3OkONDvCxNsYJekUiw3DRmOxXRNQykXAXL+RLzECgGPTMjyuxPCTkh4LfFuCJukcqmHqnGrScN2VvHjoBXJcvYtFDa12OVtOgNRl9X8Vr7AjudTFl3oH788TLFvMtU4jBbcC/UfPAIL6FTRICDBgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB7129.eurprd04.prod.outlook.com (2603:10a6:10:127::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sat, 11 Oct
 2025 09:14:45 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.007; Sat, 11 Oct 2025
 09:14:45 +0000
From: alice.guo@oss.nxp.com
Date: Sat, 11 Oct 2025 17:12:57 +0800
Subject: [PATCH v2 09/10] net: fsl_enetc_mdio: Add support for phy-supply
 property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-imx943-v1-9-072b9ede2b4e@oss.nxp.com>
References: <20251011-imx943-v1-0-072b9ede2b4e@oss.nxp.com>
In-Reply-To: <20251011-imx943-v1-0-072b9ede2b4e@oss.nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 marek.vasut@mailbox.org
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Minkyu Kang <mk7.kang@samsung.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Tim Harvey <tharvey@gateworks.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB8PR04MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: d43a12f7-12d4-46bc-a344-08de08a69edc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnA1ckQ2NGluNWlHakY5RjVHbUhxcGdMcUtJUnBVNUNlbW1tM1VYSFJVZjZm?=
 =?utf-8?B?Q1VOTDgzeVNCaVJEOVBGWkY0UVhjZXZrNEZjVnBKSjNBcXRrZzUwMmZzdGxn?=
 =?utf-8?B?TkZINmo5T2Yxc2NjWHljRVpVZVp5cUlydFRBT0ZQa1F3NGVxYWdvYlYvclhr?=
 =?utf-8?B?MytDWk93Nmd6SW9ObmE1Z29welB4c1o1cjNnNEpKL3BhZlpUVUJtbG1OU1Fr?=
 =?utf-8?B?STA5NmVxNlJuRmFTRThDQ25VSE82a3l4cDg5d1gwTWFVVW5CVW5UQnhKN3lp?=
 =?utf-8?B?QVZXbDM2bmwxb2NsSUtMeVk4VFNQZG0wcmRuMWZ4cXZNSFJlV2hnenRZc2kw?=
 =?utf-8?B?KzZDVDJuRWlVS1R4ZFRrc243NTdheUFYSWtrK1RCZVpjd0V2MXduWXArSndO?=
 =?utf-8?B?S3BNNVJMWnZVdTViK0lUMERJeENsOVJna0Mram00M2RXajhqREdjbjJEM205?=
 =?utf-8?B?VkZUSk1UcFZ0ZHFkRTFmZzYzOHA5YjVJM1R0TUJaMlFsUk1pM3F0Rk5zclk5?=
 =?utf-8?B?M2RIRG9CRENOOWRudFhucDM0UGp2NEVjcmVENWgyV2pzb1JRR0pQRU1JZkNm?=
 =?utf-8?B?ZFlQdFYzVTNRMnhobExxZ3ZIK0Iya0x0b1hnd1dka1hObGF4R2JYa3hGWHZW?=
 =?utf-8?B?Yi9FYWJXa0dxZU92RVdLOXh3ZkVGTEhvYUNrdnRVWlZHSGtpRG8wR21jWUs3?=
 =?utf-8?B?YVBWeGFZSEw4TUNwZUE3S0lzV3hsaXc5MUUva0U1ZG9vWFgvazJWUnZYdzhQ?=
 =?utf-8?B?UGE3TVd0UHR1bEt0b3c0ZHluMWxmTmo5ejFPYVhsNHhlYjVsVVJiMU93N1BN?=
 =?utf-8?B?VFo4TWcrUkdtVEUwdmZ4SVpaM1RWZkNxZUVVYnB3cllxaGFCNElwZEl6TVlF?=
 =?utf-8?B?VGNKTTdFVFVLNkpGa0RZd3lFdUQvMGNaamVEQVB1SVA2Q0Z5RXF2cm1UZlgv?=
 =?utf-8?B?c3BTaENYN1BZb2xZb0RDanN6Mkx1enVhZVpHTmkrZFBwV2F2ekZjalpQZmhq?=
 =?utf-8?B?dVlHaVFLdmZvRUpIUWtVaXVrVS81c2tMYU13dFRCc213WnlzYU5pcUU3TzZt?=
 =?utf-8?B?NEhPZkJJVFpyYlBiUUN5ZE1aamhzY093dXVhYWg1V1JJZ2dreDdrd08xOTUr?=
 =?utf-8?B?Z3dyNGZBbFMrL0wvYlN3UlRHdzZDa2tCZ21BN2VRZVBBUHZ1SGFTcTQ4d2gr?=
 =?utf-8?B?YWl1ODBNQXl3UUlRS1VmeDN2U3htQUFub0sxUjB2aW1vWS9pdWUwclpJdWJa?=
 =?utf-8?B?VlRVT1Y3QlplRTdwbndVZm9uMGk3azNoanRMTjBRL2dtTC9aRE1JN095VHFa?=
 =?utf-8?B?VUt3andlT2JYY0gzUzBBYTA2R1lhMEZmVk9lZFZXT2xZOFp2ZUtiNklWRm1I?=
 =?utf-8?B?RWg4ZHZOYis4bDFmNWRkTWxuajRnY0EzUkowNTA3N3ZFS0premdsR25WK1RJ?=
 =?utf-8?B?d05uWENqTTQwQmZNR3NHWmdiV3piUTFsT3BLc3JRaElvVnpMZFpRRkdwNGM1?=
 =?utf-8?B?MlNPd0FydEtLQXlUN2lVOEpBd1IxSTZ0MW5MYVVuM1BUUVNqZXdZNmw5RE92?=
 =?utf-8?B?K3BOdE9HRTlCYVV0bld5OGdSZTFYSXZWQ1UvamFZaGNqZEhia2Qwclo5UjU2?=
 =?utf-8?B?TUxXcVVxZzNZRVRGb1Y4Yll5Y2hyUGZ3ajd2bU1xZXVraW1UTXhHTlRRanpE?=
 =?utf-8?B?TCtXQ0RTODI1SVNXektlSWg2R2dmUFE5UHN2bjJwelpXQXJSNTljSFRxR1I1?=
 =?utf-8?B?QmlZWlIzaTg4NUpUYTh2WWNjWmRqNnJNdHIwczV2V1hrYnBJNlViZzRMRGV6?=
 =?utf-8?B?UU41NyszZlhLS21iNE5TQUV0Mm1aOW9qL3pyQ05TZWN2OUxCWFZIZDRhTWli?=
 =?utf-8?B?Ky9OZ1hGNHZpc2dSUmhjTktkdlkxbTFNa0dFellPVXFZVFRBMkNoRVk0RFlo?=
 =?utf-8?B?TXl0SHRUcTQ4VjV1SnRHU0RYd25QK3U4VkJxNElzZ05UZGFUeDhrbTlzdC9C?=
 =?utf-8?B?dkxNNDAzMERSSmR2OVJvcDNnbEYxeHlyRnBIN0NUdmszOExQT2pNQnB6WFl0?=
 =?utf-8?Q?ef0kEH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3VJTXdKSHF0cFRpOCtZbmp0ZXJBQ0ZuSWRDOHZUQkZ5VFFqRmxOcXVFaXps?=
 =?utf-8?B?SnFndWMxZUVvQUE2b282VHY2VGJqa2J1a1BZOXdYbmpVdzVzZU4yaWFvcFpO?=
 =?utf-8?B?NTZEUmJmWi9Ya2dyaTVKMTVPRTk2UEFyMnpvNi9DU2dnMk96WEFjcHB0VG1w?=
 =?utf-8?B?ekMxeUljcnJpYlFOMURLS2s3eFkyMVJ5d2tEbExJSXRZTU4yMnhma1VsUUY1?=
 =?utf-8?B?bDBxSVJKZ2hmMU5vVWdFWFFZWVRVRngyUENvRXR1TGczdDdIMEVpMkJkbkFR?=
 =?utf-8?B?Si9Kd0FaTmxjei9QYk03NVdtZFkzOUJjOFBadUtrWC9lYmc2WTFwZi81VTBh?=
 =?utf-8?B?M3o1TUJSbzRvNmZPekZhNG1iYVkwZml2eFphVC9MWEpJbGNWL2lFenRNUnRN?=
 =?utf-8?B?bDE1YVNDT3dCUkR2WkV3UXN2T0F2TkFxOE4ySkw4TkZyQXBWc3RES1NoT29Y?=
 =?utf-8?B?NU84aE5tanhIZWJHRWZqSjY0QUc4Q3BqSEV1cDFnd1YyK2xsbUNZS3lYQno5?=
 =?utf-8?B?MUFwTVdIUFpNVm12RXVwUERXSlduVzFYUkxFcmlKTUIrSDFOdkJYSU5Vdk5n?=
 =?utf-8?B?bnNKQlNMSUZzbUNLSU1qNDFEL2MrdG9zNjkzQTN6RFk0ZHhnY2J6bVliMXAr?=
 =?utf-8?B?Z3JXZDdlVHZxUFVlelBockdKK3lKbmpvOEIwam85d01BZEtHK2lhYVVweGtB?=
 =?utf-8?B?TXJXNEt2UksyVG8xSGhja3BpcXk2bWFrZWVRYnJLYzVrdVFxQmQvdmx3aWNF?=
 =?utf-8?B?NFR2QlJMcDYzZU4xcURjNmZIQXZycTFtZWN0ejNVano2QUc2MGxGcHRpdUJa?=
 =?utf-8?B?WlRuQXdRRUJJT1NpTlBDZE90cEhnTnV0MXlIeUJpUkY5S2NRb3JPdENocXlF?=
 =?utf-8?B?ODJsWkdrQXJRc1hUVjJMbWpmVDl4YnVJZU1MMlZFU0hUUnl5L214WTZOMHhL?=
 =?utf-8?B?TkN2OTB2NGhNTGt2TmkybXhhY2RmbDZJK3hpRWRrZyszdkpOdHcxNDBTeGY5?=
 =?utf-8?B?ZGtNNnNFb0o2L2t2Q3o0SC9rc0ZNNi9sWjhUamtGTTRNY3gxNHlnRmpFc2x6?=
 =?utf-8?B?bVJGZ09BdVZXNld0L05KS3FwSllpY0o1ZEZ4c2dYam12dUlmVk9LL0lHOCta?=
 =?utf-8?B?TTIyTnp1ZXFsVm5DUVpFL1EySWVQUmxyVXlma1FVKzZGY05ob0NTSDVPaGx5?=
 =?utf-8?B?MG5UUGVLZjhrak1oeFlRZTJKc3VlSElhd0JNUkRKRjlyOGVvRWtRMFhWaGN3?=
 =?utf-8?B?UGFyMWdwOWl4TS9UOGxzTVY0U0xoZGVVRFhBbERvcm5sZHZXNnYrSlNPRVhR?=
 =?utf-8?B?L1RFdTNGTHdzU1VtTnlYekR0QiswNlBjTk5RTUNPbzVZRGdBRkQrdkx1Qlhl?=
 =?utf-8?B?MlJjMDF4VkU5RURCR25zVmF1cjhqdHJYUjlRVmthSjZ4L1ZuWmI4VlNSazNS?=
 =?utf-8?B?b2Vja3YwNUU4ZnJ6eTBDZTA1L1phQW10TUtCZm5PMU8zVC96clg4cWdnN3ky?=
 =?utf-8?B?eVkzdDRrQ3FyMUs3WlkxS1p5QmxVR2dzUTM3am42K1BDNnhkMjFwOG4rZGVw?=
 =?utf-8?B?NHZtL1E0Rk1ONzhVWlhJaGhTaCtlbkxoaWZKLzRBY3R2VW5Ob3c0NFVMMGpn?=
 =?utf-8?B?S1RBK3hhTW5VT1RRdm9BN2traWZFTW1yTkduc0NzMVVhVm5xV3JoQ0hYY0JX?=
 =?utf-8?B?bDlVNG9aSFVzOVpzRjJhRTJJTFczTzhuakVNVDFwUlZyZERYSlE5WHJMNysy?=
 =?utf-8?B?NnhvYzMwZ0hmN3RPdDkvblZZTXE0cUpVa3Z6WXpmWFVjK1JHMnp5YkxIWlRK?=
 =?utf-8?B?L3A3Mmx5elR6NUlHRjhqK3RSaTUrYk03ZFpLNmNueGtBZjFYZkxrbVI5TVhq?=
 =?utf-8?B?Z3RyZGlGc29UckZ4ZXJwYmtJUGYxUW9MZGN6SE4vdlBYRXk4Ym4wMTZZMjhF?=
 =?utf-8?B?Z0xFV3MzVFNFUTBRVnk4Rkc1UEN0YUpMTWhXSWVoL2FtZ1R3L2ptaWlMdmlX?=
 =?utf-8?B?dUJtalZyK3FEVmw0Y0R4NnJTU3VaOXFwdENjL3g2bExRM2hPMVM0WFZXbDIr?=
 =?utf-8?B?dWRDRllWY1pMK3VFWmk2b3VScjRVcXdXVUwwUkdQL1lnT243d3JCcTNDNVZJ?=
 =?utf-8?Q?9IPQyI2rHxIinao/YLISQD0DJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43a12f7-12d4-46bc-a344-08de08a69edc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 09:14:45.7687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LroqMLlwCFwPKrsUWzeyPOSAaPZlBCwbbSoiqJuV9wB8ZsvReGN9prLVgUbc8P6m2G+p55Y/eqmq82A+qwhS2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7129
X-Mailman-Approved-At: Sat, 11 Oct 2025 20:07:05 +0200
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

From: Ye Li <ye.li@nxp.com>

Add support for the optional 'phy-supply' property in the ENETC MDIO
driver. This allows the driver to enable and manage the PHY's power
supply via the regulator framework when specified in device tree.

Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/fsl_enetc_mdio.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/fsl_enetc_mdio.c b/drivers/net/fsl_enetc_mdio.c
index c1d491f2c5a..3d76d92a62a 100644
--- a/drivers/net/fsl_enetc_mdio.c
+++ b/drivers/net/fsl_enetc_mdio.c
@@ -11,6 +11,8 @@
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <miiphy.h>
+#include <linux/delay.h>
+#include <power/regulator.h>
 
 #include "fsl_enetc.h"
 
@@ -135,6 +137,8 @@ static int enetc_mdio_probe(struct udevice *dev)
 	struct pci_child_plat *pplat = dev_get_parent_plat(dev);
 	struct enetc_mdio_priv *priv = dev_get_priv(dev);
 	u16 cmd = PCI_COMMAND_MEMORY;
+	int ret;
+	struct udevice *supply = NULL;
 
 	priv->regs_base = dm_pci_map_bar(dev, PCI_BASE_ADDRESS_0, 0, 0, PCI_REGION_TYPE, 0);
 	if (!priv->regs_base) {
@@ -144,6 +148,27 @@ static int enetc_mdio_probe(struct udevice *dev)
 
 	priv->regs_base += ENETC_MDIO_BASE;
 
+	if (CONFIG_IS_ENABLED(DM_REGULATOR)) {
+		ret = device_get_supply_regulator(dev, "phy-supply",
+						  &supply);
+		if (ret && ret != -ENOENT) {
+			printf("%s: device_get_supply_regulator failed: %d\n",
+			       __func__, ret);
+			return ret;
+		}
+
+		if (supply) {
+			regulator_set_enable(supply, false);
+			mdelay(100);
+
+			ret = regulator_set_enable_if_allowed(supply, true);
+			if (ret) {
+				printf("%s: Error enabling phy supply\n", dev->name);
+				return ret;
+			}
+		}
+	}
+
 	if (pplat->vendor == PCI_VENDOR_ID_PHILIPS)	/* i.MX95 */
 		cmd |= PCI_COMMAND_MASTER;
 

-- 
2.43.0

