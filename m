Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7B1D4417C
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 11:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E818809A5;
	Fri, 12 Dec 2025 12:06:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="gzhxVGD2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DED8783045; Fri, 12 Dec 2025 12:06:47 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E390E80433
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 12:06:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRYYklXj5+PKSVLu3Se3VQMDnNWKmdBuwmoqdraM0LNjqWBq0i+tC7bICk/0VR4Ani2iS9FGT2Zwhx8dSIJyiswLved+o/GJlDVjtcmWzVNjdIr1Z/y6ZHyn5iVDst34vx4x8IZPB13a3/Fy1675B6rSoG9h0tA3lg70RwUTXZ9z04iBDqRlH1ASe5759vJEyK2fWq01fiDOSVkmrhbkWtTNoKg9LjYp8Zr4gnljfkF2O+fM3j6UIRkla6yU4Vkfz2n0Nx3ovLvG32XLLgPyWz1613g1PcKA2Zp3kjYQxZX9hO1+83VDClDKwz1yiSqYCYw5AFcOaHj2jRaUgETl7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3Rk8YAdxYxRUicvYE1G1GefJAqCUgbFkXAXjccZUFY=;
 b=VBaRNRpoOprPIvDMnuEcDBfkSq1nYT+Pw3uvT+3IwOVQK9EF+xjx+v6StxaL1HX/M1g7qVwaZy1ylHfNqgyFYr6q/4WEIwcNd7068HPLIgDoo8Vfz6RsDG+bgbsjj+jz/Ss1YqXjdI7hAgbrOf+o+9/PZNckgchjJPWOxe1M1vclRAQEzytiqfi6seyu05sbXHoCqAE7KTFGTr7ZJG/1/IYr2hKBZibmuT/SBfULrJg30KyJt2Zxds7CblQFOn6/ejVdMzi+/wNc5Gc49wV5gSrj3g7CtF+jqea6Cb0uafkAVPUaM08/vDqjfs+7L3hBH3MijPKJgmCLrg7sLWebKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3Rk8YAdxYxRUicvYE1G1GefJAqCUgbFkXAXjccZUFY=;
 b=gzhxVGD2wE/ELi7mrFeKLk5f1cjgfRk4VHjUSK3DYKD1PhVE8qPHy/IwzRptxp8oO9WFIra8z57xCEVnkl5JaIpf6LDNV1kuBFWw0LTo2m1fGVLX9hRJdmhvOa9+lbWwOMCCk6axWtqppYc9LEvoMU7r2g3GjaCTNCyPEuyI5No=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS8PR04MB9079.eurprd04.prod.outlook.com (2603:10a6:20b:446::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Fri, 12 Dec
 2025 11:06:42 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 11:06:42 +0000
Message-ID: <b183c03a-c897-42c9-8999-930e02d9b2e6@cherry.de>
Date: Fri, 12 Dec 2025 12:06:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: part: Fix part argument description for `part number`
To: Jonathan GUILLOT <jonathan@joggee.fr>, u-boot@lists.denx.de
References: <20251211212039.31628-1-jonathan@joggee.fr>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251211212039.31628-1-jonathan@joggee.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::16) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS8PR04MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: a1613689-50d1-47bf-6a0d-08de396e87b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2V6UXd4TVdqMGpjdzIwUnl0U2paU0gwc2tLWis5dXUzM0lzdlNkQ3RSZjJw?=
 =?utf-8?B?dVhQNHdJYWFVSlVCS2s5MjZSYXRpUXpuMFd6RDF1a0dUTkNRYXZHTGVoSy9u?=
 =?utf-8?B?d0R3b1hGVytwNmlQa0ZuSk9DcHg5SjB4OEMwc21rM2h6allnNHNqSmFFR2sr?=
 =?utf-8?B?MDU3dUNqUkh2UlpQQ2h5MGlCYzVncGJ1eittTlFEZlZ2SDNuazBKZ2xLQ1Nr?=
 =?utf-8?B?bkVnbVFSSis5Um1MN1VKeXgxN0NkYzZ6NUp2UDFNSUg4WExTS1ZrYnVUSEpF?=
 =?utf-8?B?eXBidlBUMG16dTJXMkZDL2hVL1l0dURLUFNsRFArVGNMbzJoTDRNamlMWXQy?=
 =?utf-8?B?eVQzL3RrZWVxYVJCMmV6R2xoMm5PSnhWckJVM2NNK09jTjhubjNxNzB2SFV1?=
 =?utf-8?B?RmZDUnZ1MXdVUkhDNmh6ZVlvNU5ndUVlaDVKanU5Mm1aWWhucmFmVytlNUFR?=
 =?utf-8?B?Q3I4MXZWenlrbHNraHMxSWtpRlRINTc5N3pGbVk3ZWNNczk4R0lJdGJyUG5Y?=
 =?utf-8?B?K21tMXI1aWZ4M1NVbUVlanR5MjhoVUlLKzJWNzZMQVExd09DVGFISmdRS2dn?=
 =?utf-8?B?S3RRdEhiRDc1M3AxM05qTEVLdUx3NzlLbllrSXY5R3I5V0U2c2hjNGRIWW5K?=
 =?utf-8?B?Wkt4bkQvK01ibzQyMDhLWlJ6TU53ekZpWFYvS2hPTjFPK3JjcG9wZHVIeC9W?=
 =?utf-8?B?c3U2YlJSOEQwRVQvdUM3VTIwQlI1UG43QW8rMEFXcmE3bXpBc2hXV0MvMTVr?=
 =?utf-8?B?T21lRGV2dCtjY0swcFRzREt5MzRNNjgzbzk5OGV6M2NxM2ZtaldVcWEzQkJx?=
 =?utf-8?B?UC85TUtyRGhqWFR3TXlHTUhaNzZ6dlZab3ZhTlo1K1VTM3oxWkFmWVoxbC9D?=
 =?utf-8?B?YTZMeHVDZUxWalFQQ1VXSW11RUY4TCtweTBKYzQ1QTNkTE1XUEx3eVVGeWlM?=
 =?utf-8?B?UUZkZXpVQytYTWF0UHpMcGo4eFViR0JFQmMxaFAwOWtzejk2UHNITTAyS2ty?=
 =?utf-8?B?UzZrYzhudkkzVUdEY3FnbTJhaUQ5TEMvUVplZFlGRjBmNEZORlJMSUpBRElF?=
 =?utf-8?B?Yk9oK21BUURzV3JpbmtZc1E2eW1MVHFqUFRydHBrYlQxRnZGb3RiSzd0UVJu?=
 =?utf-8?B?cENtRG1BOHplS2I2TWlvOUw4Um1YaTNRbExuS2xjRTNrYXpPMHpZeGN4M0ZJ?=
 =?utf-8?B?ZytzdUZ0c3A2bUFyMEUwbGRTdldhKzR5Ym1rOHlpVVFmWkN4M1g3dFBXM3BI?=
 =?utf-8?B?YnhMMXgwMWFlNDZuUUsxOEVacVIxRmRmaWI1RS9WaW1iakVOR2RmN1ovWXZR?=
 =?utf-8?B?OHJNNDNpTWJ6bVp0MG40V1IxRVJleUdoT3BSZjFpanRNbGpNUE5WZU1uRm5V?=
 =?utf-8?B?YnhzaVdzMGRhYXdNUXBiMDhGUm5ZZ3F6Zm4vaGhBK3VmVzRHYVdNM2hhOTZ5?=
 =?utf-8?B?TkdsT3RFV2pnTnBGMm9ZOWI0V0c5Zm02RWw5elRUZU5TU1Q1NlZqR24wbHA0?=
 =?utf-8?B?eHkwUGJON1IyWU9mUW4vY2NmaUo1TG5TS2RKdkZNWFV5MEtYYTdRamtKUVZL?=
 =?utf-8?B?Q1hhTnJNTklNc2hRQ0tzdXEwSkFpSVlud1pKcE5uYVlNRHdQMDdvQm1aRVR1?=
 =?utf-8?B?bzdHc2VINUQxOERKK1ZnbXFWc2ppOHJUNVlLa1AxZDJyaUlZWXVwQ045c2pB?=
 =?utf-8?B?NDVZQmpVdGh2TkJ2b3k2Y1hVNjdvbzNHM1ZNSzNsTVFES1M0QmQ5Rkg5NFBx?=
 =?utf-8?B?TkhLNTRQbm9kVXlBdDBiWkkrZDE2d3NxTjYwcmwzTFhoK0c3QzRWczQ4dkt5?=
 =?utf-8?B?cCtQSjhEWkppK0VQcEtHYWFabko3alVhMk1OUEJ3b3dkOE9HM2xCeGZKN0N6?=
 =?utf-8?B?YndtMDA3T1FPbmF3dHdRaEJ2cXBMT2ZOYjRGQVljb043eTFUMWRPWmMwaUpY?=
 =?utf-8?Q?UIYQOcP1HEOfa4HsRoBmojdD0+LrmK7d?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDdleWlrdmFOUkRreGF5aVIwNzdZRStHR3F1VkliUFZDVWRsWVpNc09sMWZi?=
 =?utf-8?B?OTJ1QXZma2VjVDg1VEl5dUhNaWNtUkVxbUoxQThJVG0wTkFrQ00vNDFpcndY?=
 =?utf-8?B?VWFMcWpyaWNWT3lBYnUvQ25DajhzajkyZHJJWmdFL3BHSklOa1NFM2NSd201?=
 =?utf-8?B?Uy9iTDRNLzRKenY5UERhSzlQek5aeDBhd09paS9lU2RwaXFEcHFnZDlKUzJQ?=
 =?utf-8?B?MHErdVg5SVdrMGt4eFZlU25TZDdZdGNHbFYwTldrcUhlTzcvcGkrejMyanJs?=
 =?utf-8?B?YmZ5K1Q2NHRzeTJ1elhXRHdtSWJNSVEyeTF3SnliSk9FeHJEaDJsTlVJTHJK?=
 =?utf-8?B?SXd2NFk4eWt4dzhlYzF5Y052bFMxZ3dOSk5Gd1J6UnB3allvTTBwa2tnaWV2?=
 =?utf-8?B?dGZ4VzI3ekFkVkFXVDBGWklsdVdUeUQrNzU1TGNScFQwMTZEUFJDMjhsQjVI?=
 =?utf-8?B?U1ZuN0RWRkpsVkYzWHVWd1hMT3RTelZtMjl1Z2JBcmdNd0NpdWorQkdvOFRH?=
 =?utf-8?B?SmozaDJETHFHZk5sUmNKNVRBTk1EYU92Q1VwcWFmSDhKWDkxYnRHSndJS2VJ?=
 =?utf-8?B?WGQzZFJURWdUN0FKVzFsdDZuV3NkRlkyTkZoMzR1RHl5TGtudkF2YXRLQkla?=
 =?utf-8?B?ak1GTkFlN280MDRNeTErMDg2ay8yTVNWZGY1TDZXeEpybUtyQVJLdXhTWjFq?=
 =?utf-8?B?VUxsRWhZRllSOHM2ZmtrbWIvaTdBVDI2a2ZRZTdKN2lrcDRlZGZOc2hVakNT?=
 =?utf-8?B?NVQ1dFR0RFNUdGt2eXFWbDN3SjNIbW5RdFU0SzY3THY1ZzQ1YWJjNHJDeCtW?=
 =?utf-8?B?VnhUZVFaRkFZeThaNHorNG04R1hBb2hXR2pnZUIveElsVTVwSEk3bWs3bUpN?=
 =?utf-8?B?dVBJNDVPZkwwbEdNWUVaek96OVhPdWs1bm1OV1d6L29GYWh3bytWdGw2WEFS?=
 =?utf-8?B?djRLa2JTQXBTT2xrNkVydjdtZkx0cXZna2t2Q2lFa2YwS2I4SCtQVlNSQXlm?=
 =?utf-8?B?c3RJNEtHckVzN2F1SnZKNkE0L3NWa0prNUtvRmYxU0M2RmZneXlIQWUzWE5U?=
 =?utf-8?B?OUk5MjVielE2eTY5N2FkQmZWT3FhM2tsV05YSHNWR1d5RE9PNFNzUDJ3UXVa?=
 =?utf-8?B?RDVnclJtdjhacUlxdnkyaVpNbUNvRmYxcE1kQ25KYXhGdlJJR3ZucGJCT2py?=
 =?utf-8?B?R3hsTmJ0QlRJNmtVN216ZVR3SEVSZWpjaUdiUlhvdzhEMXdiY2pKb3hWTW9a?=
 =?utf-8?B?UDBJSFo1aWlITk1CMlJIbkZrSFhPckdReU5vWU5ENjZ5UmM4dUlNWWJMWmhY?=
 =?utf-8?B?WnR0MTFncXdFa0pqYUVoN1ZnNmVqUkVUYjZxU2F1SDdtZGxqeVhMYWFraHdv?=
 =?utf-8?B?YjBFeVFZU09lQWgzemJCVXMrWWM0eUJ6T3Y0NEdSbi8rSzhKM0FPZm1mMUND?=
 =?utf-8?B?Rm9NS2hMUFBXSWFtYTNHRHNHUWF0cUpGUm5yalM2b3VIbkMvRFZOZTIxMmhK?=
 =?utf-8?B?SUdrdmZ1dVZRR3RVUFZtWHRMUmFsQlJkaG5ReWM4RGVoZ0dzSFhNUytNM2d4?=
 =?utf-8?B?akc1ZUd4SC9xcXMrUUNpUmYvZm1DeUhZRDJuRGxXUlk3UEtyTkVvc1FWR1BN?=
 =?utf-8?B?WWhVUDNYUFoyZXR0RHJDbzJWYXZPZXFIQ0Y3dFBhUU5ueEVjU1M4U1Jkam1z?=
 =?utf-8?B?eTQyaFVjY1kyM29nc3JCdFJBTVhyajVqaCtWRjlFR0c3cGNCRVIyRGdobEZw?=
 =?utf-8?B?Rm9BRFo4ZXRLS2c5bmlrb3NLYktDRVJlSmRYNTVydklrcHZRRUtYQTdvcG1a?=
 =?utf-8?B?QWlVWGcxdFZjaUhlNjN0Y21yRVlsRnJqcm9Jemo1TEN3MWRINjNFUzJMZEd4?=
 =?utf-8?B?eEsxREFpL2NEOC9uMHJCTUdNbDEwLzZESGJiZ1huMEpzWVI3dVMrcXFvNXp2?=
 =?utf-8?B?UlhHL3BEa0Q5TUx3NURrQWd3NlZmeXpkUzNQRDZLdFhtN2RDM3FQRzBxMlln?=
 =?utf-8?B?cjJvcWRnRElTalFjVGo1SmN2dmtybVc3cElkR2hJOCt6ZHlldmtUY0ZjVGNJ?=
 =?utf-8?B?amZXdGl3NXkxWmhPeWd4eC9WNjV3cVVFMmw4ZDFOTUJHaEhzMG5vdnBDM2po?=
 =?utf-8?B?dnVRSHFzTFljVnpDNkwwcExjWERYNU10ZXlaMVhGZzMxNW8wdTgyV0ZZMEF3?=
 =?utf-8?Q?pHNGDGouRw5EwctNRN1reHs=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a1613689-50d1-47bf-6a0d-08de396e87b8
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 11:06:42.0793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcbPpAJ7s6rspOpF40ECqyHwownplmqCm9XIB9uw11y1kw4AAdSnx7qOgl+nQGe3X5xIEAGHJz39WJyz+WVpRrF0iM8pXll7YlP39RjsQKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9079
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

Hi Jonathan,

On 12/11/25 10:20 PM, Jonathan GUILLOT wrote:
> [You don't often get email from jonathan@joggee.fr. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 

Fixes: ff6ef4b9093f ("doc: man-page for the part command")
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
