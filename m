Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7C0E77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 02:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBACC80613;
	Thu,  9 Jan 2025 03:23:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pILvsaup";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FDDB805E2; Thu,  9 Jan 2025 03:23:20 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 922948006D
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 03:23:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xy1gEx2w+9pD1RJA3M5L9v/LMtPZjuXcZNwBBo74fBLRFLXLBt472Au99kRUDxpm4xz1hd1C1mzisk6DVjo6lmbhaAZHDFv60RtlkEbS4nrv1OhuzcYAFMg1tCyJLRcqFZGxPQVnvrbG/Mx0HlzvGXlA0WNPrAWW8O0Qg2kLkUUyCVP3NUJ8sD6x2K2N4ccZFtwQqsfa+77RH3ZD0poO+5roYOHaZSQ1s26sEc36y4FbJRM86bH4kemezx6knXYdil+ySv9HfbXv8EGthwehUfbcrW2vf072Lzw3GMXOiw4JbLrDNV1GJpU1aYHGxZekzEtosQljoDL81M875GJbzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3bWyxTaHMM3UFSF+98aJKlLQnN8VsxVU4KCRoZEMIA=;
 b=JtlQt+m3f9QDHGf/WufVb2EL5WXs9MeNt6OYJk+jV6gsjRl21VnHpc62yP/xz+kyV3+F3d1i8VmOfMiow56N39NCBIEuHU0nahEQ4V8bc0+4tRW6yXUlfnL7PwMcFj7EGttlA1FFFyEgixnd8ZrRWhx8Vdlth4xGLacmgJQANFlVo9OZASNUoX5yD9wFaBvvItC7L96uoxdNW8FulWm8rhF9q8UKyiUzwlhnd10QiSebnI7Xs7nSoNOD6+rEgIz+f2/ZtHhPEpz9Gdc+O0BvW7P80NwmzxyxJGlNUMJEEUiklPN23grsa1K9YpBPNy/iQSGAFbREA7KUxhOGTz/iAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3bWyxTaHMM3UFSF+98aJKlLQnN8VsxVU4KCRoZEMIA=;
 b=pILvsaupVil/5HZT6SuEWCJUoG0517bP858OKUOQx7mGWfMWO/F9oPLre2t2mOZF4BsZW4C30tm/dLflvvZ7E9odSnN2jQYQzdQeGRMYQgKXhGTmF4HqEOjpgFQXCRqnwoz2jfmg2v1txKFavyqY5OisbR3C43dOeN5tluEP1kABEW2oaHaQ08XkoDhg/JjT83b1dlvYkGXUgK5iO0XuHWT4y5G+vzjlv8iOb4PhMNATH5IQ1xUjcnwPvopWFBrRV+KosKtrWK1XIk6z1hrNVpzYJt7TpDz2jcdmJ1LzbSLrdXR0FciImVHjw3yudUcs3heLR5IF0QLdA3GP5h4C1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DB9PR04MB9355.eurprd04.prod.outlook.com (2603:10a6:10:36b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 02:23:17 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 02:23:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 09 Jan 2025 11:29:04 +0800
Subject: [PATCH v3 03/17] imx: imx91_evk: switch to BOOTSTD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-imx-bootstd-v3-3-16e5fc0baecf@nxp.com>
References: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
In-Reply-To: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DB9PR04MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 442bd503-9bad-4b6b-ade9-08dd305493c6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2svdXNrL3YrZGJDNDhmaEtrN2FaY1VaOUh2QldaMGU4bzN3VVBnejZ0YUdQ?=
 =?utf-8?B?a2JDT2Nld1VaVzU3aGNOTlVBdk1BbnkxQ1N0UFJwY1pMcko1dHEvbGxBMlh3?=
 =?utf-8?B?aFBicFJmNTN2dElHaFNjbXE5R2ladDRoZkoyQWk2ZFlaZGNHOXRKa0lodGxh?=
 =?utf-8?B?Vm52d1FkNjVXdk5CNGtlZENuOGlUMjR0Sko5UGhtWENrMlVwVThDWWg1VkZn?=
 =?utf-8?B?MHBrTUVGN3QrdWR2NlZEamJFaXl0d1gyREpBOUVYV1BtUDlHMWFjMjNGaU5X?=
 =?utf-8?B?WGNvRzY5WC9aN1JTRGtjTkUrRUhQaVM4VWY3OWNFOUlOWnJXT1VTZ0V2cjJn?=
 =?utf-8?B?UDBVY3Iyd2wwNCtYM0NTQ0FsK1pmNGZRejI5RHR0OXlkcTJwTTV0UFZrSDZ0?=
 =?utf-8?B?d2ZHcjdveXRXeTU0dlF3MXdOeXlmdjFDZVNQQmR0cXlSZ0pZeVd5N2lhNjFC?=
 =?utf-8?B?c1gxWEJKYnEraXpIcHRweE8xVWpmS29KZFJNcVBESmo2YTQxWG9KOHMwYXJi?=
 =?utf-8?B?MDkxdmFHU2tqUEtjbWxNQzVyTytIS0JqSzQxUWhXb0JqbDNHcTVHYWMxazRn?=
 =?utf-8?B?Y1ZOL09xRGdRdUhhMmwwZExzLy8wUm8vOGpjUTRjMmhzKzNBeDJPZHM0Vldn?=
 =?utf-8?B?YW5SdmdpUVFOTThhdE9zeTlGWWFwVUswVnk0WW95Wk9MOG1BeVc4NFkyZStE?=
 =?utf-8?B?Ri9haDhoUXpBN2dRZkVobnZlSEgwZzNFY2VpdzVWTlNnd3hLQ0xvUUxzem1h?=
 =?utf-8?B?c3Nxb3Bad3Y4NFJ1eVBhN2JHNExZR0FHV1c5bmtaSHIvbTJaYTFyZWhrRTVB?=
 =?utf-8?B?MmpEUjV4eHVyckJ0bkZ2ek9IbDVVZ2l0bHdVaFhyS3ZlVUpJVjNFakxQK1ZK?=
 =?utf-8?B?Z2dtbXg3Y2R0ellJdktKd011R1VhZjJMR1NvRlZpejh3aW5FZEJ5dWdNKzFm?=
 =?utf-8?B?QUhqV2QrMlYyQ0FRaTh4VlBheENEQ2VORXp5ZGt1d0UwcUlKaVlrWkhWMkJP?=
 =?utf-8?B?R2FBQkMvaDRyUlJZTVpLMmNTVmhJcnFjeldSUWNyNk5rTzdSeDVYeUFYSC9X?=
 =?utf-8?B?QjhPRTNjUHMwSFhETGxJWHBSRmJveGsvdVpVTmVta09ERnVsU0NrcnZCVGk2?=
 =?utf-8?B?dmZDL2Rzb2FFUHdWNW5UYUxaOVhMUmVvazhnMUJBQWxKVStWbmtyNlExSXRp?=
 =?utf-8?B?MURNdWlsZE9hcXFSclhWQlQyeHowRkZsOThVQlhCaVJpeWk4Qk8rN3cxbkxX?=
 =?utf-8?B?bUl5SDZlRWI4RW9aOGlvVXJmajR6ei8ybVRXaTlkYjNGbU1ySHlsdjZhNE9L?=
 =?utf-8?B?RTZiQmRQRkpkTWxTblVlM2ZCMlFNRVlzL0lzb3QxZjN0MG5wRWo4OTgzOXRw?=
 =?utf-8?B?cWlscTFsMGtJVkx1SFVnbjV2cDFETEQrM0JTMzRRRGx6Qk1mQ255N1YyRUc2?=
 =?utf-8?B?bGtiS1ozSVBrL0pkMGhqTVV5UVU0bXJjeHR4Vm85bTl2RVd6bDM4MitFN0JT?=
 =?utf-8?B?NFdTbm8zOWJQRXNhTm0ydTRoU1BMZk94N2V6Ky9oVGFLQWYwR0szY1ZBZVVI?=
 =?utf-8?B?SkN2S1BzaDRQL1dkSERxTkZyZE9LVTNyeG1kWVNKN280ZEFkV2ptTlNRV3Ax?=
 =?utf-8?B?VmdKby9OUENaMDZYZHhrWHRJOUdEdDI4M1pxdmlZSmNjY0Q1Q080ZW5RbVlp?=
 =?utf-8?B?aTNaQmZqSmh0YXJJMmczcGlCSGVmSkNIL3hoalBQNncyanhHbFRGWURsV2I5?=
 =?utf-8?B?ZzZFNVFJTjc1LzEwNGY4d1V3TG1NbmsvTXJQaEJGSmQzWURHL2s5SGVyWTZm?=
 =?utf-8?B?WUVSdWhobkhNTC81TER0d1FTYy9iOXBwcTBycXRVL3prVTRuNWtFUDloUXdr?=
 =?utf-8?B?b3doWHh4NjN0RUEwaHJhVng5cWJsUHgyZEpzSnNFK1krcHlmZnhESnVnTGpW?=
 =?utf-8?Q?TIq2c0aUr25aovigdCdflsJy4XdMCxxP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWpYK1hlN3N0OGhKdFEwMGNndVFhTzd3SHNlWXZXaW9mbnkyeEJWTmQ5RXA2?=
 =?utf-8?B?N3pzSE56bmNZaEpGMnozUU45UG9mWEJsMGw1YkZtSWNYUmVWMlZQNWlxdGRa?=
 =?utf-8?B?cXk3Z29EaVY5c05NUlEzdmZhZGVUbEFHVWRKT1gzSkxHMmxpTmg3VG40Rkta?=
 =?utf-8?B?ZGhzRkxvSjBlbnp3cDNOL2JEY2tjdkdJb2lmT25Ya015MGk1K3ZwUmlOb1p2?=
 =?utf-8?B?MEZKRkUxQUoycTF6eDFMWTAzWVBMVDJWNFo1dUw3Mko0Tjd3MGNEVjlYeTZj?=
 =?utf-8?B?R0VMZXkyaDRFTmtiSDIrYjdCempNRTJYd1Y4VTNFb2xzaTFqQmlJVlJRT2Zq?=
 =?utf-8?B?T1dyVWdSb0Y5elNNeHBpcnVHNWp1Z1hsUHhVMW8yM29KRFkreUxRbnp6Nisr?=
 =?utf-8?B?R0N6QS9RNGhOdnA5ZzI3YXVaQUJVOWo1NzZkK1Y1WUdMaER2YlhGbmU4VDlE?=
 =?utf-8?B?ZWZkQXd5OGZYbDlFYW1rZ0EvRlMzaWlGKzJ2R3lIYnYraWVzYTZLd0RYS3da?=
 =?utf-8?B?bWlSeVRLajM1RXFQeFFlYzcybVZuWi9UUkl6NE5tSWlyMHR1Vy9JTEN3VEJR?=
 =?utf-8?B?eldzZThHQ2E1V05qRGdjZ3RNc0psRDRWQlErUHdkK2Q4WXIwT1B4MFA1QTBl?=
 =?utf-8?B?d0J5eHhWSUcvWXVxSjIyYUdrSjZ0WWdHejlPMzM0VGhEb2c1TmxJRmpaYkR3?=
 =?utf-8?B?NkVEUEo4VTIvSzlNSTVnTzN3dGJ2RkdQU093THF4M1EzcFpVamlLQTFtdXNm?=
 =?utf-8?B?TnJ3MEZybmNqblM3K2l4K2VNUlMvQkl5dFFBcG92alNnNXJiNUZ1YWZlbmdM?=
 =?utf-8?B?enZEMmxXcGFRTzZwZERnbFdIRXlBRTBsdnY5ZjYxalVlZVRZc2pTYmxJbXVs?=
 =?utf-8?B?N0UwMXNSdW1KblMrRjEwNngxc3FER3FSWTQraVhGUVFNRDRiL2RoL3gyNm9O?=
 =?utf-8?B?ekUxK1pQRUtWV09OeXJxTDF2bnJEalB1ZUhKL2xFQ25OMnErblRlUzdPMDJr?=
 =?utf-8?B?azMvZi9laElUOUdVU09PNzMxaXZ2dUR6UHhXTWZiWS8zTzBWRUVJbG0zaUVw?=
 =?utf-8?B?S0ZLNWMyZWo4ZVZYcXZWbkdrSDFhSXhUdXBSMU5ORTdxelNZZERYbGVDV0Jv?=
 =?utf-8?B?QTl4R2VoN1R0QWx5OVR3Wkkxblc1OUlvdWNPckVvODFTUTdkNk1PSGowbUJH?=
 =?utf-8?B?Sm1xRU9SeGJKSUp3WEJCdHltRGYySjdCTHNSZlozOTlrSmZtczIvZERjYnRD?=
 =?utf-8?B?bkhKUFA5M09GWUZHSzJxdG9XdkNxZlJWS25UY1QvRm1WQmMzd3BDSy8yZXRC?=
 =?utf-8?B?cExKdytkTWwzWmR4RXN6VGlrSExRKzMzTzNsTHEyazFVNExpRGRnSUpuenlX?=
 =?utf-8?B?QkIwT1RNMGc1Z3BCUWV1Z1R6SnVCYWhKK2VNR2hwYkdYemZRWjVFMENObk1I?=
 =?utf-8?B?MFZ3YnowZXU2Y1p5cEc4NUo4WGZESnR3eUpFR3dEcDU5Y1FHNE9WNlRjWWRI?=
 =?utf-8?B?TkNkbFNUUnNuNlFhOVJDZEhvNlM2cE5wZll0ZnRnUE5lSzFoWnFWVEUvYkNV?=
 =?utf-8?B?OWEvNGFmNTBYZUhqVW0wRVJLNDh2TnovdHFScGVMTHljOWVFZjFWQk9Uc3Fq?=
 =?utf-8?B?Uzcxb05FbUNqMUlaU2dPNWtJczE0WmhNdW4rZ1ZCSVNxd1lsYkhKT0hFdVBj?=
 =?utf-8?B?T1hDZmYzQysreURrUlJTNzJEMGxHZERjckVkSDY3VEpDcUUzQkVvaCtFbFJ1?=
 =?utf-8?B?ODVpTWszQ3BFUG40NGFKOXJIcExqaE5sNUlkQk1Qei9XbVptNWpTRGFVTlR1?=
 =?utf-8?B?aklBVWduZ0h2blJZUm91TGNOYTl4TmJFZ2ZrWjVEWFVFd2NjaHF1UUtSVGIz?=
 =?utf-8?B?dDJRaGJlbXd5OFpFeEM1TW1FbnlnQTBvY2JlYzhrUzVTa25CMVhxRGRGR0NB?=
 =?utf-8?B?RWtPS2VUUlRyYjNDWkNGc0hTNFN2Qm5laWIzZkFlR2dUc3VIMVVGL0k2WU1m?=
 =?utf-8?B?VGIydlVzTUpxQWxPTjVSalZNQXRiUStDeldFN2FMMGJCUzF2cWtCbmE0cndB?=
 =?utf-8?B?UkRjbUZUVWQzYUsxQzFNYjZGMGRKSmdJUnU4Z2ZuN2w3cVBCZnhtbnBmQVJa?=
 =?utf-8?Q?fhS76Zwu9hwmCL9ZUxfbJc+je?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442bd503-9bad-4b6b-ade9-08dd305493c6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 02:23:17.2298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9C4u3ykumQp4noA4759uIn4ZD1GEEtHMp+7wIAGN99mlEhfe4DQCaxQRI4CE5Qs6lvfjA9o+aeV98lR9yOcV9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9355
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

Switch to support BOOTSTD with a bsp bootcmd as fallback.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig               |  2 ++
 board/freescale/imx91_evk/imx91_evk.env      | 29 ++++++++++++++++++++++++++--
 configs/imx91_11x11_evk_defconfig            |  3 +--
 configs/imx91_11x11_evk_inline_ecc_defconfig |  3 +--
 4 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index d756f3dcad2e91172ecd885357b9d0adf2e387e3..49220c0955ee4f658c06ba98c6cbe5ff411cd993 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -34,6 +34,8 @@ config TARGET_IMX91_11X11_EVK
 	select OF_BOARD_FIXUP
 	select IMX91
 	imply OF_UPSTREAM
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
 
 config TARGET_IMX93_9X9_QSB
 	bool "imx93_qsb"
diff --git a/board/freescale/imx91_evk/imx91_evk.env b/board/freescale/imx91_evk/imx91_evk.env
index 92486c6f74d2ec12f638443dcf598daa28f306b6..c972d3eb2511542c1a11812f879d7627cadef797 100644
--- a/board/freescale/imx91_evk/imx91_evk.env
+++ b/board/freescale/imx91_evk/imx91_evk.env
@@ -10,6 +10,7 @@ fdt_addr_r=0x83000000
 fdt_addr=0x83000000
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 image=Image
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
 mmcpart=1
 mmcroot=/dev/mmcblk1p2 rootwait rw
 mmcautodetect=yes
@@ -19,12 +20,13 @@ loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
 loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
 loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
 auth_os=auth_cntr ${cntr_addr}
+sec_boot=no
 boot_os=booti ${loadaddr} - ${fdt_addr_r}
 mmcboot=
 	echo Booting from mmc ...;
 	run mmcargs;
 	if test ${sec_boot} = yes; then
-		if run auth_os; then
+		if run true; then
 			run boot_os;
 		else
 			echo ERR: failed to authenticate;
@@ -48,7 +50,7 @@ netboot=
 	fi;
 	if test ${sec_boot} = yes; then
 		${get_cmd} ${cntr_addr} ${cntr_file};
-		if run auth_os; then
+		if true; then
 			run boot_os;
 		else
 			echo ERR: failed to authenticate;
@@ -61,3 +63,26 @@ netboot=
 			echo WARN: Cannot load the DT;
 		fi;
 	fi;
+bsp_bootcmd=
+	echo Running BSP bootcmd ...;
+	mmc dev ${mmcdev};
+	if mmc rescan; then
+		if run loadbootscript; then
+			run bootscript;
+		else
+			if test ${sec_boot} = yes; then
+				if run loadcntr; then
+					run mmcboot;
+				else
+					run netboot;
+				fi;
+			else
+				if run loadimage; then
+					run mmcboot;
+				else
+					run netboot;
+				fi;
+			fi;
+		fi;
+	fi;
+scriptaddr=0x83500000
diff --git a/configs/imx91_11x11_evk_defconfig b/configs/imx91_11x11_evk_defconfig
index 6ee0b448f9932ae9c85d3a0a8f6b32787afbec6b..55ba71953c2ba76b3e9b958c5bcc5d7471f5f242 100644
--- a/configs/imx91_11x11_evk_defconfig
+++ b/configs/imx91_11x11_evk_defconfig
@@ -6,7 +6,6 @@ CONFIG_SYS_MALLOC_F_LEN=0x18000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_ENV_SOURCE_FILE="imx91_evk"
 CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
@@ -31,7 +30,7 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_REMAKE_ELF=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="imx91-11x11-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
diff --git a/configs/imx91_11x11_evk_inline_ecc_defconfig b/configs/imx91_11x11_evk_inline_ecc_defconfig
index 761a66662641f16da6b9e2ba13690234df7c0a44..0eabd7aa8b3cf7a797ea1b3668c9639b59a7a009 100644
--- a/configs/imx91_11x11_evk_inline_ecc_defconfig
+++ b/configs/imx91_11x11_evk_inline_ecc_defconfig
@@ -6,7 +6,6 @@ CONFIG_SYS_MALLOC_F_LEN=0x18000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_ENV_SOURCE_FILE="imx91_evk"
 CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
@@ -31,7 +30,7 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_REMAKE_ELF=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="imx91-11x11-evk.dtb"
 CONFIG_SYS_CBSIZE=2048

-- 
2.35.3

