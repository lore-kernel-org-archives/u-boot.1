Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7459CDD563
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 00:17:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C73B4890A7;
	Thu, 19 Sep 2024 02:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="a5SR9HxZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A3108907B; Thu, 19 Sep 2024 02:15:21 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74ACD8909E
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 02:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFlT3fJcyKC1bXG/OPkV/KuJzzoRVlYwR8JSG6QiGZJSwHzcRtq9uSqfYIz5pxeEl/ozyitdxwbHydpMoDaMupRO9lzdO0YENYleNr+iNPRx3H75N51DzM6JvaayacgwuDVTjwqpP6qLoykrpzMom0QSobJKUNe/DavLJeklyyysmV1GlHgQPihJuIK0nyjpjnR62WCetEzqBMNSxU0X8AO+QUcxq3vQfFZGCdM9KZnYtd90ipqtMDY0N7hOcJNietmVRbdBTMxU33BF10LpaBQGx5Feno+BIriDO201HQKoWnmPnNE2snwvsl+I+bN/KOGsq2MVXkDUwexHNsGHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yVHOzAemBeUjT4a7FAGKg4z9fnrlZPQf1Yng29e7sI=;
 b=NoTzTQUSVZHoXcIYK8bFwaENYS/hNl2VHFDN7QGdg44yfpfCHhlAbfpcxefXICXIwMn6EwP+bNXu3NnHhnY/VrPrBVQ8JCCxnBWTj3V7/JoDKaBDUpyTa1n7IudRxKPEu/rvIW2/JFbwmS0WYvbl2o0KizvObrcKIM/QcNabhO+lXpZy2cYVY5lY6nRhBOil/GheHigo+bEYwX2nzdcl/+if3Vdy2MOM0w5ii+6Law8SGIJICcwiHK1I3E59dmZwR6/9COmB/awFt69wAraxmpzdHOMtzw+QeN8UkQFKYKswNu0uBaUuYDgoffcmx1u13wTJhx+HFrIUvhkIdRMD8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yVHOzAemBeUjT4a7FAGKg4z9fnrlZPQf1Yng29e7sI=;
 b=a5SR9HxZw/A+Cvcga0VJAItnV+PIyz/IvlxBMcMeOKUfT1lGXP/6/VSPtYhqvcDsUtSECEV+MyUFMh07Y467mUN6e4Pq4bhHadu75V/HFwtupdZIIr4D9j0+Zz18ZdnLpWdN8JCI6ZyV5yu3W6G9/VocTduoUXkUIXQT4wPKSSSjqcxSSkhQQ+T28XqeWhoAI5GPW43jIe9KkQuPWbEv0Z4uhxJSyUyze7nxMZcuTRXCkKXLBwjhiA1tjW8r2fOAY7ghEWkVauxo7xK7n9COSjpWwtqtvvaIFnAD5o0L2E2cr+2JHjqs2LYQKNh/ugJG8dMBaigD0Idyft1hNtF1Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7872.eurprd04.prod.outlook.com (2603:10a6:102:ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 00:15:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 00:15:16 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 09:18:15 +0800
Subject: [PATCH v2 16/21] imx: Generalize fixup_thermal_trips
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v2-16-0d798d9e08ad@nxp.com>
References: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
In-Reply-To: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: b182d4df-4f74-40a0-02a0-08dcd8402395
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHBUT01IY0x2N1dHRzR1eXdlMERJblV6SE93MTh5WUt4dTg2T21uVU9Ld3d4?=
 =?utf-8?B?ZFZ5YmlxWTAvYTkyTldmcEI2RmdkeGJtSmhYWjdFckVWNW1ZVVRDS1BBZkc2?=
 =?utf-8?B?M2JoejVBRG5KM25DSFdwT1JLM0FXRUxqWi9OUVZLY016V3AwV3hSS3dOL2c1?=
 =?utf-8?B?Qml6SEtISEY1cWh5Zm5uOG92eGhiOCtQMCsrMVFpTHdpRUhIbnJiUExFVS9R?=
 =?utf-8?B?a3BibjlLcVF5K2RHRFpFQ1hId2IzU09kdmFmUENma2lSKytzaWVZc2pwdFc3?=
 =?utf-8?B?L3J3T2ZjbUR2cktqVTJTdEMxUUd6RHBDYnRQc0N6N2wwVzZmUmNzbGJMUUd2?=
 =?utf-8?B?VFVOT042S3FJNk51blZubUFUTnFVQzZPVUo3WUxielhKZjdyNHZIRDY0ejl0?=
 =?utf-8?B?eWtvODRsY2hrOG0yWnhjZERrT0N1d1JsRXhreHhhbXN4Z2EyeEJPUjM1OHll?=
 =?utf-8?B?RG9Fa241Q3hEZ2ZLdG5zS3RnVmxCbmpTVVBnNVVaeTUyQ2xVbHhPRCtmKzRF?=
 =?utf-8?B?RTdXSjdSaFNJZXlYbkZCYXlVZHkrM3hNMkpuREp2MWk4WU9zY3N5Z0g0bHdr?=
 =?utf-8?B?RnRmZGNYR3pGb2YyNFloc24rVmRxTkovd1Q1Yjd4amZsOTdCaTZ4bWpFbFB5?=
 =?utf-8?B?L2hYNmRWaFN1OGJHR3h1NlNudjBtS0JOLzJqeTYzSGIwUEp2L0JTYW9GRWlU?=
 =?utf-8?B?YmUwamNIRnFOaGdIcmtQWmRwOTFSRUFJaENtbTNpbnQrUVMyUjBWeEYwTlRu?=
 =?utf-8?B?OGszOTNZZEFTOEtQVGtZSnNxUDVMMnF2RElwR2tLSGlBcnNQNlcva09TY3hm?=
 =?utf-8?B?alpIMWJ3L3NHTUUrZ3gxcVBjUVBlWStramU5LzRtMzdUb0ptL0hBWDUxRWZI?=
 =?utf-8?B?ZDlqcmlzMkpCb0dMNUNBcUNlditVZ1NCUUtYeHBvYVY4bnBudVR3UFQ2aFpC?=
 =?utf-8?B?UXV2WHpKR0Z3d2pWRGROcE1QUExMOFFhMSsrN2F1ZjI5bGJxam9nbzBncHov?=
 =?utf-8?B?SVM1S3RaY0p4QkFUWm9DcDRZbjBWaVdLS1gvMmhwOWxtbGgyL2hFUW8yTU9v?=
 =?utf-8?B?bVJkZE13WUJFRnVsWDZQNklOUVdxbys2YUF4TDVmWUw4aDVvZGtIWFU0Tkp0?=
 =?utf-8?B?aThhcWljQko3NEZvZU5EcWVlL2dKR1AwQ2tnbTRQSmdrZ3BxS2FtQSs1NExI?=
 =?utf-8?B?UFQ1bGk2TW9aSCsvUDArYWhnUTJSKzdYUERxbFhNR29PMytFdGJGWkgwVC9H?=
 =?utf-8?B?M04rd1hHcDM5c2IyazVGcFZ0WkhqMzZFZWlkbVovSTBDSVVvS1RoSTBTOVFu?=
 =?utf-8?B?RGE5cG1TOTNBOXBvOFBwQ0U3S1V3QXNuaVBLTXJ1Z2dwZzBianZZeStsM1o0?=
 =?utf-8?B?R2xIVWNPZ0RXWEh0UXhrajBHYjE3QmJGVk1QcHZvU2Y5YWE4cXZVTmx1SDJP?=
 =?utf-8?B?bmxlYzM0Tm1MSllnRDRwTXUwSHZNN054SWFsSzdrRVVma3pyYzhWblFGcUNP?=
 =?utf-8?B?aVloRlRIcGNUOGIzSy81UEExYjlQdGJTVjgvbExJRDZlaG9jbnI5cWwvVkRk?=
 =?utf-8?B?dlA4clFCVFh6U2E1OXNHU2VYeXJQdS9lSnRSS3VCZS91dHRwVk9vL3N2cmVy?=
 =?utf-8?B?VnZoVmhuTVY3WjQ4NFFVNS9TTE9EcnRQSmNaUWFQR3BIOWdVdnV6SVJnWmVj?=
 =?utf-8?B?dnF2dG5XZkZNeDBHbGtGc3RkV3RiMEY2bmxYaEp3dU42TkprZkI1N3dpSkpT?=
 =?utf-8?B?RzArZEFKNDJEQ2JrRW56MmJJNTQxYzV5c1pGclB0eUIzRkVmSEhsYzU3Yktu?=
 =?utf-8?B?dUJQNTQ2MFVPK1BzSkFjdGRJRUVwZzNMamx1VjFWV0NubzZEUitHc2tpMFd3?=
 =?utf-8?B?a1FFbWFlRE4xdGtjSGJGUTNuT3JmQWIrZ1V2V3pmQzhMWnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWlad2pWWjdWTlJUeElnY2p2S2hlbUZLTElCOXVTNWl5bWc3RmVJb3BUSlhH?=
 =?utf-8?B?akIxcTAwWjdwc0twNW9uRlpwK0hNaEFIbzV0QVVnZTcyVi9XV1JvSjF5NmRp?=
 =?utf-8?B?MEdCeVVBS0Vhclh1Qk1xZUwrcTMxSHBlSTd5ZHh3VDFlUDZSQXNDU2hRVG5z?=
 =?utf-8?B?eDVsclNZMUtYODBzZ1ROUk5lRjZqcVc4NDdOaVVuUHo1enlzMG1LeVJCSkFn?=
 =?utf-8?B?STUzUmIxZVY3Rnd1TlJUdTk0Sy9FZWpER2VXRGhzenZGMFdCbG1iRDRSQnlq?=
 =?utf-8?B?bmtiTXNBTk5BV1RackxvOHo4WkxKOUxXeU1SeUpBN2NjN3FhYStldTZDQkl1?=
 =?utf-8?B?eGVNTHFoV21qMkl6ZXlLbWw4NlRYSTA3UTBWeHk3N0wxZWFBenVrR0piaXlT?=
 =?utf-8?B?UTFwTzdLWEhwL0I1NTdqUFBwNVcrSkQzV2FxM3gyaXpLU0FpeGpKS0NZb3I0?=
 =?utf-8?B?clZ6TnZRb24wQm04VjZIbGpzbnpMNkpsRFFCK0t6d0c5cVZ3cGxIdzRkeklY?=
 =?utf-8?B?aWUrRWF3dE5NeStkV2lMZmEzRy9wWVp2MkcrOEtNblRCeXJWbVVMN1JVVWJh?=
 =?utf-8?B?K2lxSHhGMW04WE85azlGdTVKTTR0NnZmeW5SYkRqb3lXN2JCRFIrTHRkMlJM?=
 =?utf-8?B?Mnp1UElNQkUxNzVFWTRCQWNydk04TE01UmxyYktGZ001NHVvMi9BZW9wSG9D?=
 =?utf-8?B?R1NJVkFkZ2lrT216SlRoZzlzWitVMjZJcldMNEpsT2xzTjNwUGwrUHp6L1FT?=
 =?utf-8?B?M2JMc2dwY1E5MFZVdlVlV1Q0bGswMklUakhIb2VsRU9GMEdDOVVkUkxETmVp?=
 =?utf-8?B?U0Z3amIxc3pyTWEyOGRGWEhnUkVBVkwvVWdNcXUvTWVJeDVodUpSdzd4R0VZ?=
 =?utf-8?B?M0syU0RtdmtxdXZQT3lWSE1vK3RNVUNKZXR2dC96eEJkT290MzNhZUFIMnZP?=
 =?utf-8?B?dmlTSkY1NXNsYmpOMlVUWnovTVEzZS9vd2VFbm40eUtDQUdGeVNibm40dVBE?=
 =?utf-8?B?WWlYZjVaVzdMYWVOVlJ2czVOdWxKNDlDeUhxdUxpbmFhS3FLd1ZjQWJTRS8x?=
 =?utf-8?B?VFpJLytjMDJRNkxRb2xreDBIUjk5ZnhkNElpRmZwbEg1UWRORkR6WlhLVDlo?=
 =?utf-8?B?dnRmR0pIeFNwT0lLcmkwdk5EUnRXcFAxUEMrTllsWldwdEh0VUNXZFNCNTJi?=
 =?utf-8?B?N0ZwdW5Rakl2MldrcWFyMzduSFBQbGdVZHNYZkx4MmxTTnp0UXg5WGN4N3lP?=
 =?utf-8?B?UFc1Q0dNWmRQbkJ4dVQ1Z2UxNmJYa0w5R1NvTFhRcE0ya2UwQ2FRMFR5VmVj?=
 =?utf-8?B?TWd3U3JkV0E4TXRDMVp3OE9PbHFGNHFYVUpld0tKc2pGRlpRNXJtODJuZmpN?=
 =?utf-8?B?WmpIUFE2TnArdm1ZaVI5WVBCTWc2OWhsZUZoSnh6cWl1QTl1TVJlNVlabkha?=
 =?utf-8?B?T29PcXFrVmdsOUg4NVAra0RqR05iMTJWenhROXZxVTI1Y2hsU0Npc1krZW9U?=
 =?utf-8?B?R0VqeXFmdkdHZWhiQnVsTTI0Ymc5cGZ5QnRZQlhZTVBZaUNJWUwreU54b3Mx?=
 =?utf-8?B?WGxuY3ovUC9McjRzcTd3VWFycmZUNXpxQ2xDRk5uVGtKZ1d6NmM5WFU2ZTdh?=
 =?utf-8?B?QWlLS1JVeUl3eWdhYTIvV3BFY0E0QjRDQUZFcUlhbk1ZQTlEN3h4dEV0MHlo?=
 =?utf-8?B?Y041MU0wR0NIRFB5dUx3T0NVeWQ5N0grREFESmUwalowaWJ2YndQdG8xSVFM?=
 =?utf-8?B?c2srcGN1MkFXWVE1MEZEemRCN0hOMWNjSDY1M3BFSFhqc2ljVWZRRnAxY0tv?=
 =?utf-8?B?Z0RoL1FUaTRFMWp5N1lJMjd5dUFCWmhPcVBkSmlTOUpuczB4amlQTEVpK0Ux?=
 =?utf-8?B?UDhZWGJtUnNPZVlkY2Nib3ZGbUFEQzZrWjZ4VzkxN0M0YzZabFMxdUxFVXcv?=
 =?utf-8?B?Q2VpckNXSmZ2S2YvVFlCbVQxaXBmTndZb2pRQWl4by9YVXB0S3pFY0hvZWlR?=
 =?utf-8?B?YVFMbmk3Y3FJaVV2YzFZdUhCS2pRczJ1eVJHV3QzNU5SVWs4Mm5XTmo3NytI?=
 =?utf-8?B?ZGg0czZob0hrNWpieERTLzVvcE9CZy8vb3l3T2dicjg1QWpOaVN2c1FDY3NU?=
 =?utf-8?Q?4O5Q14AfR1tJE+3PlSmn2gwYq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b182d4df-4f74-40a0-02a0-08dcd8402395
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 00:15:16.7645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdU7g17CPJqG34SUdMs8GXsceHbc8RaagUJVm+4dHKh0rzmMKf+9gFH+l8kO6j4uW+KbstSm20VEJdZxpZpLiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7872
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

i.MX8M and i.MX9 have duplicated fixup_thermal_trips, so move it
to arch/arm/mach-imx/fdt.c to avoid duplicated code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/mach-imx/sys_proto.h |  1 +
 arch/arm/mach-imx/fdt.c                   | 42 +++++++++++++++++++++++++++++++
 arch/arm/mach-imx/imx8m/soc.c             | 42 -------------------------------
 arch/arm/mach-imx/imx9/soc.c              | 42 -------------------------------
 4 files changed, 43 insertions(+), 84 deletions(-)

diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index c146a223b71..31ace977d2b 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -280,4 +280,5 @@ enum boot_device get_boot_device(void);
 
 int disable_cpu_nodes(void *blob, const char * const *nodes_path,
 		      u32 num_disabled_cores, u32 max_cores);
+int fixup_thermal_trips(void *blob, const char *name);
 #endif
diff --git a/arch/arm/mach-imx/fdt.c b/arch/arm/mach-imx/fdt.c
index df6fbf51dba..ac782e3ee63 100644
--- a/arch/arm/mach-imx/fdt.c
+++ b/arch/arm/mach-imx/fdt.c
@@ -85,3 +85,45 @@ int disable_cpu_nodes(void *blob, const char * const *nodes_path, u32 num_disabl
 
 	return 0;
 }
+
+int fixup_thermal_trips(void *blob, const char *name)
+{
+	int minc, maxc;
+	int node, trip;
+
+	node = fdt_path_offset(blob, "/thermal-zones");
+	if (node < 0)
+		return node;
+
+	node = fdt_subnode_offset(blob, node, name);
+	if (node < 0)
+		return node;
+
+	node = fdt_subnode_offset(blob, node, "trips");
+	if (node < 0)
+		return node;
+
+	get_cpu_temp_grade(&minc, &maxc);
+
+	fdt_for_each_subnode(trip, blob, node) {
+		const char *type;
+		int temp, ret;
+
+		type = fdt_getprop(blob, trip, "type", NULL);
+		if (!type)
+			continue;
+
+		temp = 0;
+		if (!strcmp(type, "critical"))
+			temp = 1000 * (maxc - 5);
+		else if (!strcmp(type, "passive"))
+			temp = 1000 * (maxc - 10);
+		if (temp) {
+			ret = fdt_setprop_u32(blob, trip, "temperature", temp);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 68d5762c2ce..dd2d1796e3d 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -1166,48 +1166,6 @@ static int cleanup_nodes_for_efi(void *blob)
 	return 0;
 }
 
-static int fixup_thermal_trips(void *blob, const char *name)
-{
-	int minc, maxc;
-	int node, trip;
-
-	node = fdt_path_offset(blob, "/thermal-zones");
-	if (node < 0)
-		return node;
-
-	node = fdt_subnode_offset(blob, node, name);
-	if (node < 0)
-		return node;
-
-	node = fdt_subnode_offset(blob, node, "trips");
-	if (node < 0)
-		return node;
-
-	get_cpu_temp_grade(&minc, &maxc);
-
-	fdt_for_each_subnode(trip, blob, node) {
-		const char *type;
-		int temp, ret;
-
-		type = fdt_getprop(blob, trip, "type", NULL);
-		if (!type)
-			continue;
-
-		temp = 0;
-		if (!strcmp(type, "critical"))
-			temp = 1000 * maxc;
-		else if (!strcmp(type, "passive"))
-			temp = 1000 * (maxc - 10);
-		if (temp) {
-			ret = fdt_setprop_u32(blob, trip, "temperature", temp);
-			if (ret)
-				return ret;
-		}
-	}
-
-	return 0;
-}
-
 #define OPTEE_SHM_SIZE 0x00400000
 static int ft_add_optee_node(void *fdt, struct bd_info *bd)
 {
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 23e81caa8ec..04b21207a28 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -538,48 +538,6 @@ int print_cpuinfo(void)
 	return 0;
 }
 
-static int fixup_thermal_trips(void *blob, const char *name)
-{
-	int minc, maxc;
-	int node, trip;
-
-	node = fdt_path_offset(blob, "/thermal-zones");
-	if (node < 0)
-		return node;
-
-	node = fdt_subnode_offset(blob, node, name);
-	if (node < 0)
-		return node;
-
-	node = fdt_subnode_offset(blob, node, "trips");
-	if (node < 0)
-		return node;
-
-	get_cpu_temp_grade(&minc, &maxc);
-
-	fdt_for_each_subnode(trip, blob, node) {
-		const char *type;
-		int temp, ret;
-
-		type = fdt_getprop(blob, trip, "type", NULL);
-		if (!type)
-			continue;
-
-		temp = 0;
-		if (!strcmp(type, "critical"))
-			temp = 1000 * (maxc - 5);
-		else if (!strcmp(type, "passive"))
-			temp = 1000 * (maxc - 10);
-		if (temp) {
-			ret = fdt_setprop_u32(blob, trip, "temperature", temp);
-			if (ret)
-				return ret;
-		}
-	}
-
-	return 0;
-}
-
 void build_info(void)
 {
 	u32 fw_version, sha1, res, status;

-- 
2.35.3

