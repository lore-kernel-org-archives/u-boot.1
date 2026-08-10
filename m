Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03267C5AC82
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 12:22:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D0CB80DBC;
	Mon, 10 Aug 2026 12:22:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fZE9VGUN80-b; Mon, 10 Aug 2026 12:22:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 95D7480DA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786364522;
	bh=ABFYpf7FNcsIz43uRV3KZHLDIz8i6UuPB9clDJKmVOE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fekgT/52yC+OEpZhVhEhoyNz1Xkr144no5x/Bi5zD3UD+ocB8un5cvQh+BjMxGBD3
	 MLGvIUvL6mC4CDQAO8jv1RWtlB6zf4TgGdEq0vjtKnXpo6sUjWJoUKoya/flifzkwB
	 l6H9C71U4R0Gw8OjC0Tt/q1qjCMt/3iCRRSRXRyMo8ri0EnTFIzITsy9PJx8qHCVFA
	 gCPAzU+iO29X75zjXdhRyQGYeQRRs72PcRLAInTKMEOU9oHCKsQAgEiyinmKR75AdG
	 vSSDYOsOH1Nt39FRNlHBV0whNWc1hyl9RwtwkNJ0nOidF6utOYZnA45TEr0XujrtHh
	 pf/j4rFWjCwrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95D7480DA9;
	Mon, 10 Aug 2026 12:22:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 229BA2F5
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 12:22:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 08762405D7
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 12:22:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qQrWxENE6bo0 for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 12:21:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.139.77;
 helo=mx0b-00128a01.pphosted.com; envelope-from=caleb.ethridge@analog.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0E274405D6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E274405D6
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com
 [148.163.139.77])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0E274405D6
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 12:21:58 +0000 (UTC)
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
 by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67A9TT6W3080646; Mon, 10 Aug 2026 08:21:56 -0400
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011071.outbound.protection.outlook.com
 [40.93.194.71])
 by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fxn2jbba7-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 08:21:56 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plWQVGhxZaEwYIu/NZ9BcEQ+/bwJ7OOJBrS8rAn5UomOvte/o10TbrUJISkkOY++0Qr5ZDQ7nWVpbdk5zUHdOe3dBTB02TYdeUKIrR3EH5NOL6bP4WsublHsSB4R6ACwMmOL1x3XiTxgIG8l+G42i6vi5XQwU76BzRcyDT5I2zN8NABI1tJjfDsP4s97GFHNXfmrsZG/awtcCiSlPoqEJlJQTpCRoyLGLk4gNwBTbGO6VrUcoDKIaDNd3d4M254/MxtKgW05e6duKfPR6Yd56Kq2L/uNm5aecFVZnTn+G0Q7iGeSVdYXbvubhnV3Z2jPdq9erh/j8f8u5z4jiiTdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABFYpf7FNcsIz43uRV3KZHLDIz8i6UuPB9clDJKmVOE=;
 b=yxy0gRR+XtItRpLbM5NcCftwsv5ebvafqcjgtMYBw4ySrAhC9P9VXFNlnL7BhheReTdRVnyC2YhttQKuNnsymfq0rAE850yw7BtqXzbZH2F48lewF5y3pt6q6pZR1LbdWZge6NFtlK8gDRfmk+rIp3HsDrq0t/xcNymjUw7XN6UCLu38pn7nr3kTTa88eGRC6g3Hob4Y/7jSOkhFfjsZ8l464t6y6A379cIlPcboT1S9RLgH76hruBAcyQcOktTl2+1m6XUQZuE7Obw9ZNbJCBjF5hLXO+PZjLJYsncReDIqpjxNC4+feei07HFgwcG0h/iRnvoH5QmLSwnyQy19Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8) by LV3PR03MB7521.namprd03.prod.outlook.com
 (2603:10b6:408:19f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 12:21:53 +0000
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e]) by LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 12:21:53 +0000
From: Caleb Ethridge <Caleb.Ethridge@analog.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, malysagreg@gmail.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [RESEND PATCH 0/2] sc59x: Disable CONFIG_EFI_LOADER
Date: Mon, 10 Aug 2026 08:21:36 -0400
Message-ID: <cover.1786363875.git.caleb.ethridge@analog.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::8) To LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR03MB989102:EE_|LV3PR03MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af1f737-ef18-48a2-3565-08def6d9f63e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 7gHz/Oqg5PUrRuLJEPFfUjsA9iYTKs59MB7kRSVv6lrMvUp9sBF5l4JAS4jIEO1NRRygeVcxyQPGF1WI2sl+du+TbdEJ5X6SCEv4wo015Sucnsk6WkbhBaIyvewKREnAbY/HmNNaZ0cijZMYxBCv5VkVmjrLE3Jqe2WIgKfFfaCY/qeqvSpR2q2eXjLcCHuUHERgraF4lcjX4FDzayTVlK1FNV2+gCSMdi4s9ALiNQiAaA+Dui63yLQVTRiHwVrNzE0E6iZk8lrsl5a+IFAiaA5MumuGaWbTp3AjB8jSVDl3RkqqPKTrvJmllT4RXG6AGhmxO/laWA4EMLhu/PbZnL9iF3+gVrlXNvmiYnyBQwKQ2C4e1L3/Z3FelBgR2XEdJ32FypAGDRJfL5FynrEK0AYL6YpOpbquojZWnxXguI71VRz7SnkJg1KOue3icVi9151qjQknj+B4roM2vcr50AnVB0lmkl9BhDNZGkLkfiQ2q+CQ9CWPYpSq4H6KxoLDeJlM0KAsPHKlb6mNWxUh9ItQBK1qug8mmmT2gQvw1X6IllWpyPUr4fRBsVmtmrzlL5DU1RNCWNW9ATqv8MI/6a4W68InGetoup5zQp4NCIMeQGARitpxNfSf6ooKAVsR8ArJsRkce9urEZ6I2uocUR2DKMredmxBU1lDQyWgofs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR03MB989102.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pQadUuCOQRCPS9Qu6+8AwK6lEuneCAA6o/ORDkymqZuCdxI2ehLWYuK9q8g1?=
 =?us-ascii?Q?8A4DDh9FdtOMx9I8ZRKgIqz1JQbcU+h7JFR4JA9tYS0fA0JcZV66kmStLv46?=
 =?us-ascii?Q?DDUepyaZVEZcICLaV+RV8b4BTR5sRMnOCeBaf2rCwpVE9Or6GpeZel6yChLt?=
 =?us-ascii?Q?aTWbF5ew70wYUrqQzLnJnEL8fBr7bTkpU3cU8G1EO4L8yRI4XAV0LwIWG9Ek?=
 =?us-ascii?Q?VCRF+3bDXUTgUF+uDsd1vUlBbuqoyaK3ZISZL8OOktVEgYtHSH7M4xqvKU8h?=
 =?us-ascii?Q?3lD2zGK9E4ToEJUvrNZQt7kHFhAt1JF3xJUasor3Y+ZjWPYvk+llnAxfqzmy?=
 =?us-ascii?Q?nU22ZrMheiLlnjnB68UVJI1UJUb8SMYbTpquE/0nlUWCGcgUNJA5c8wwRF+V?=
 =?us-ascii?Q?IIjyDQaLyAvYlnqUdRcBaHAg1fXCPJbfHXdhmD7hd3p+S+lOAK8EvkcxuDly?=
 =?us-ascii?Q?tw0h/bhf5DlOA0Z089azBGLCMfm2H4AiTBrn1Pix3zJACs8xNNFW+q4I0d02?=
 =?us-ascii?Q?TNKYibBFfTJvDFTxj/2boOaenb0xQKlr0i58p0UdyrgxXUtBSiusXmvHpq3u?=
 =?us-ascii?Q?eAjHPgg/3s6PMHqbNA0icio2Q3nYafsBDpWk/TzETWBHewZYixRXv1Dn9vFm?=
 =?us-ascii?Q?iV28xBtyVa/NZCZd/6e66ONq1LfZZMcoI6vATUcnl65ekiZS3lSS+B0gQ2hD?=
 =?us-ascii?Q?hwgqdFP0iR4Ux6XkjDHoYhKKemPwDwk8wBFMzlJfhJn3yAUCjzx0tO65rlBs?=
 =?us-ascii?Q?CPZlPig7mwfn7iHsMh+SKPNoB8fhWzm+GyO7h4SkViZ9VCR6bHueRvg4juYy?=
 =?us-ascii?Q?Hkwc+pNc2gpM8ExsDRvhX13mMKoj0HafjoRTwQjC+tTQARu6JlFVkplX9VcN?=
 =?us-ascii?Q?grqePtT8avw76xCChUPIv/om0Pm8DO8qprhtcbgJFoFoR0ZV3yA7L+Dhsyey?=
 =?us-ascii?Q?xDQI5FkkdO4VssIqK1fixqFUIYblSIB6YejARBVb32zO8X0A0yxq8vU1GXbx?=
 =?us-ascii?Q?/6q2fmGs7dNoIbWtaCWS3e3+VidkyN0OkT3p2P+bpbGaucA19N42Jwqmrwj1?=
 =?us-ascii?Q?U5xayP9m90zKwC4O1xmkvJZpuyEUP5EUSFZ0/quewVDHTEHfm/D+xXP9ZpFl?=
 =?us-ascii?Q?bfdv4UeiWbuwNsgMhuCcQs3x1zdXR56zfKOi3QJLX6bhkJgbYeVYHcK8nUQm?=
 =?us-ascii?Q?mS/WCEjVXIRY+N8q5hqbKj58bUQFWpuU2HqP4hXiNWPE1UPLn5QnC/nMiS9j?=
 =?us-ascii?Q?nKZWZBxBMa8CM9ro5HCtAa67o2CGFmZiy0YcGe+5gcPX4ptQuxRGXcnnewg1?=
 =?us-ascii?Q?XZUHpyUuYp3XshrPzh3h6a2agFpD6LqHlNqHIQyWnPSm8fnja+NeCWHxWM8E?=
 =?us-ascii?Q?uzIR5iGfzycF0eUWvAvscbgm39DeDc0pcotAAgQQzS1ywv2E7etFaolZoYr9?=
 =?us-ascii?Q?SUKcDUD0E6Nurapmb19XSJL+VGqZh9wK5Wf+t6gmNcgjj1bjU+wbvuYurFlY?=
 =?us-ascii?Q?oof+bSTybds8K2qKdR65oOL1uBJGbISm5N68LqJPl1A3kC0pZjzNrh6S8A77?=
 =?us-ascii?Q?C+dS3PWcwLrUjFCQpdkjWHx66juAh0DPHAxfody/JdHSaCnJEBPuMjl41HDP?=
 =?us-ascii?Q?0q1uRNAt3C/eWGCSkcdUXF2yuRVy3uq2TKsIwyfoXEkYsCzkrgwuI9m/prVT?=
 =?us-ascii?Q?YunwqkWFZzM8vUvwmOrfTNyj02V2kO86/XunQNQgkAGk4p2byW0qECgFeUJd?=
 =?us-ascii?Q?snSPd9BfFLsov+YxPCgUsXDrYuhAABs=3D?=
X-Exchange-RoutingPolicyChecked: Bk2pB2QYAEGsE+P2FnDS+ldL2M952glUL1nzj7FPpY43LQHMKmPe42+S3y2RVz4QgneDDoqcic7GQDr6BH3j3yrMe8Ymci1zf+v7NGzX6xZTCdvcOUnHIHgnnf6umAVo3Q1YnZDuJkf3fADshNGrVXfeLfHqQhtVSyfXMGxjhRv4+Pd12PcCOeamB/AJhHETdYpbsIDK3v0MQ6FOK6mZsheAjJ3Ha3ksAaFrgGEYWAB5g2RZ4D522mNzhFRMQG91t5iXcKIsaq72/dP8Oj4dEY/kGs8AOe3fTqbjLEAbovHNXVtBvEfkqPt+fj2ZOm2GHcZQjnvkNP4Kvf4t4ehwZw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af1f737-ef18-48a2-3565-08def6d9f63e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR03MB989102.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 12:21:53.3884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHYtukaJeOxbSoLyPqbI+dIKWbAxgENlRWhVMhmjh9CVEKKcu9F/Ine2Uh6X1Kg5nlhremdvfv3LwP4Ptsmov8Poqo4kiY6/fPf6lxzIUaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7521
X-Proofpoint-ORIG-GUID: 6Jfeixp5OFDZNAz0B_4jzLSS9bUPM7yZ
X-Authority-Analysis: v=2.4 cv=SJ1ykuvH c=1 sm=1 tr=0 ts=6a79c264 cx=c_pps
 a=ojhc/3A0J58/V7uwnPnIuw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=gAnH3GRIAAAA:8
 a=7FwiKlg-Ykqa2fLWAkYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEwNSBTYWx0ZWRfX+D6p22Ui4+V8
 xYoNHqKjiOCATbBUZgXSjfV+Grvh5nVca2NutTkIVqQqvcqoJUuu3IRY7v2RLoSgtJNN3aSMkaL
 Gi3IVmmL/IX7sIWrTz7kSprL4EDf9mA6ah6FuplUkHC8sYjm2flgKLr9jC85JVneESEhLFPb58D
 yQlQ8csQTkW/99kgdnnYr8PEt0SAmukbjq6ve99pFsGn9/umnSyAue0bpXVIgB5OcsXfXSMHKG9
 g/pDh+vABDAIivNEMc3AzRup0elIoBQ1OV2V5criC9Pv1bwl7pYIUWEXjEzyH08PpXICEQzK3jV
 r+oyrsVUgb/tbepdsOLRHWQ+6AAyM2CaLRVRQ/vtBjT3cWYyo+JapjeV5VzUTxBIKennEqBMJee
 5eTIs5/W+oLLeVJbtrzH0NXKAHHwGS4mKM3xFCAZ/Rs5DAE82FolWsiR0InJ/EZjfjGEpEH1/Rn
 XpfVyniZOkHr4HsqN8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEwNSBTYWx0ZWRfX2EZh+S4BU0lB
 1bvj3lEWfWzmfFrZPqY+84cSZ6aXbd/bNruyxlYMawV513qYvcB8kH4nfqgaHHHRpk/n0fx5rFb
 O7mrxfm5DJXnsy3PtHUBSY0FnYslwOUFLGYPsJQUPK+ohF1z2T75
X-Proofpoint-GUID: 6Jfeixp5OFDZNAz0B_4jzLSS9bUPM7yZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100105
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=DKIM; bh=ABFYpf7FNcsIz43uRV3KZHLDIz8
 i6UuPB9clDJKmVOE=; b=YIrmIIf6C9fE3ENOP+9+03JZftvQW9iVqCP0L1iz/9l
 g12W9hC3Kt7Zpbeeftd5rdGbaOGSqQHOc5BadTzPqkjtVpMXzuLccgRQQgVes9Kg
 NN6qMKbBOZd6kue4bsNMCntBAaHK/BFZT071p4HDYUzcy6TIzQ5afWBS/GvO8L2c
 c7MyZDV6a3UEJfA5x33gEuzgEILFTRzBYbC7nSDE3Xg11UAX1GnH4Pwly2Wy0KxN
 Ka4bGEjtzghyhCijXW1oShAtH+xan+fpyl9QYXchrftUC364BP1yyMVeqeG9duiB
 rg6AbnW6A5i3DEx4qq9ULle6s7T7d2ZIgOPUR4pNp9g==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256
 header.s=DKIM header.b=YIrmIIf6
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Caleb Ethridge <caleb.ethridge@analog.com>

The sc5xx boards do not use UEFI support, so CONFIG_EFI_LOADER
brings in unused code in the build. This is already disabled for
every board except for the sc598 and sc594 variants, this series
extends this exclusion to those boards.

Caleb Ethridge (2):
  configs: adi: sc598: disable CONFIG_EFI_LOADER
  configs: adi: sc594: disable CONFIG_EFI_LOADER

 configs/sc594-som-ezkit-spl_defconfig  | 1 +
 configs/sc594-som-ezlite-spl_defconfig | 2 +-
 configs/sc598-som-ezkit-spl_defconfig  | 2 +-
 configs/sc598-som-ezlite-spl_defconfig | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.43.0

