Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5539AD3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 02:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C97383C2B;
	Tue,  9 Dec 2025 03:48:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qXSDg23V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BBA283BF1; Tue,  9 Dec 2025 03:48:28 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D59E83C28
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 03:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxOHukzYk8MSgwFQ2OFz8YO4O0DPN9N+j0ElFrbHxjwGpbJVE8S6/d5ZexWe0H60Eafqz3il4FkZWhTVkL4wTEcfznp2w3Q+vD9J3fPwizuzW9FOP0VdKZj49f20Z0fqVOLTEYcMr2tVbZzbbjJu0UMOT/N4bQAk33xGL1GqUoQ5r7mKxe5HpxzUi5jxDLjre+NCwe12oD7+/+HFOvfwj8KE3O9pBALKE3rO1aa9XyjRUvdieXYSwVc6frHUjwkpFroyJZkXxVIQtMXqctC+U93NNCQGm5Sp4oRkfJDtYXdT6cbBbFiBTBAlkAoi95obh/9GEtJGQz21Of5X6HXUcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2eVpD5IS4hlCbCAUnr5LQ+OxPjv520gJsmtPcQb4wA=;
 b=WJ3/2RiCVOXDMIWX0Vakybbx7b6Ar/EBzK/hRS4fH3vRM+YKStGkZ4rijmmJvXsHksACq5m1uadITVPZZBURcpy/7oyOEj8/prWDPTvi4mxnHdy+fq44iudZYiDYj3YHHh7m/pN04Vn76tYxAUFruiHLOPJKx0eQuoGp8qzIMBcdRbZ/z43R2edLVEIjb0FzLJohtwqhDn6mYpw+K1tE306oEksbIcC9DO/g5ziodENpPNVaPJ92hl5Cxo5WUwAv+3b8++419NKuGCNIAlerGQ0eroW/xwDPYJaV42oo05n/e61fCvmlRtN4+Z4RJY38Qk+i0sRoq10enIZ5462EYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2eVpD5IS4hlCbCAUnr5LQ+OxPjv520gJsmtPcQb4wA=;
 b=qXSDg23V27ZGFeUDLPLZE444O/hABjUlIL8tkqC29F5hCyjlvMkujqwiMuR+HHEactdwg5ilAOwRpN8PtfBhafzLh76asesSuFy+qLYD2xYELZR5D3MyIbKPyvfACEkDPiMD15MGdqcqyKbeBvUImLLoNHqd4VB5Mzhj7jaHhPtVcm+TfMTRXVWvXLYFLo8EAJsRwED610sQmoeIp7SE3MNBpBkl8sSbjLdaUxo1YXV0sLb6puZ5EMiPj5MCU/pQF+99/Nu7vSR/i5O8AZr3ncbE4qZ4Lgp8iDzbJEfkVENbzPHz2P9mv46b0J3SmlWlpW1Bc2h/yq+MFR1dUDekAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB11897.eurprd04.prod.outlook.com (2603:10a6:10:61d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Tue, 9 Dec
 2025 02:48:24 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 02:48:24 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 09 Dec 2025 10:47:11 +0800
Subject: [PATCH v2 4/5] imx8ulp: clock: Drop
 CONFIG_USB_MAX_CONTROLLER_COUNT dependency
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251209-imx8ulp-v1-4-97e76ed1d967@nxp.com>
References: <20251209-imx8ulp-v1-0-97e76ed1d967@nxp.com>
In-Reply-To: <20251209-imx8ulp-v1-0-97e76ed1d967@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marex@denx.de>, Marek Vasut <marek.vasut@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Stefano Babic <sbabic@nabladev.com>, Lukasz Majewski <lukma@denx.de>, 
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB11897:EE_
X-MS-Office365-Filtering-Correlation-Id: ef29913d-27d0-4b74-c656-08de36cd6bf8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|7416014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWZRZ1RTR1pZSkQyNHJVdFZ4blJ0ZTBPeVNUbGJsdVhib01ubmhxdElRTlNp?=
 =?utf-8?B?a09qNDZYNEY0UTlnYk1UTlZyb293YW1IKzBRaTlxd2VtN3JaZHk5allQTVpr?=
 =?utf-8?B?RkNQaEFwa3hIaS83TU9DTnBaQVByeHRobjRydS9vNVdQeDhvRkVybmRFbTVW?=
 =?utf-8?B?TW41ajEyVWc3OFp5MmFRUzIxdTJwSjJUMVFabE1pYnZnZzlkdk5ySXFnMFpv?=
 =?utf-8?B?Vk5EQ1UyL25idlJ2bVZQSHIxQUdhbTJzK2FyQXgxRnNoNUJodmJoaWF1cW5T?=
 =?utf-8?B?KzB6Z1hjMVBmM1NQUTZFeXo4TDJWOEFMSm9lU09wU29hY29OWFJyOTJlMlJO?=
 =?utf-8?B?SW5tbE1iMVBRc1UvdDNuSWpSczNlSVg3RCtFcnBtUmVScm9la2F2WjhRQkZu?=
 =?utf-8?B?aEorRUdrcllrVkJSamgvRnhUV25yVGFxcTJTU3BRY1dkZnI3eHhsTXdQMGpk?=
 =?utf-8?B?N3BXQUVYckY2ZlJkYURDSi9YRUJzNFdsR3VmcUxkNzhBa1NuMHhxT3pyNTBY?=
 =?utf-8?B?WHJXKzBYalZRR29tNnNveVBPbUpEcjhkU2lLS2tSZkthL1FSaGwrTHBqQU4y?=
 =?utf-8?B?aWxla2FZMmttQkxyVkNLRWozOW9HNkZTd0xjU1pvSGZvQlJ2VEpBODZiZXN6?=
 =?utf-8?B?bEY1bzh2Y2svdDRhYUdNNGh1Q29uTks4VXBzVkowc2g5eGZ5WExtTmhoYm91?=
 =?utf-8?B?ajlMRzVoTlZEcDIyVFJoaUROM3g2Q0tScDFkTTIrYXowdUZkU3VnUkluNjd1?=
 =?utf-8?B?TmFOUFRqcm13MG91TS82TCtFZEg1bG5qSW1NL2s1Y2VsTDhqL256M1ZYRm5P?=
 =?utf-8?B?dExLMXVodUUvSzcvTEw0V2ZXUitzbytKNUlucjRBSDFuYjFIN0tUdER0SEhJ?=
 =?utf-8?B?RGpwK2xyUGhMVFJPZEd6NUllS1MyNTBLUWJGVHcwcDJDWERzb3k0K1gvYmVv?=
 =?utf-8?B?S0FxRThKTnFpSzhDV2RMdTJrLzNMR21sZHFwc1hWZjJad1QrZlhQdWpEYUMy?=
 =?utf-8?B?U3p6bVRxKzJNQlZIU2hQQzVQbVlnRk1lVEN0M0s0ZDNUQ2tXbnNoOWh2d1Ux?=
 =?utf-8?B?ZHVwaS9TenJsZ1YreFZxQlFRUVZYR1dhR3pQVjVkOUd1ak1HOWlMd1NhZjJj?=
 =?utf-8?B?RXQ5d2hJRTJwVHA3RDVwL3JNSkpnTklFWGpESHZLdWxNZFJGZ3BadGh6eXFP?=
 =?utf-8?B?dUlHeG9HdkJucUkvR3djeVJId2plWnJoTUl6WmovVzFSVzRucU9oT0pPSzIv?=
 =?utf-8?B?UWVTYlYxdUNrVXdDR3lBeTE3dGRHUDJLWWNFV0hrUG9JSDU0T0dNQ1hwNHNF?=
 =?utf-8?B?MmlUSXhtL1RKNnJZaUV3cVY1TEJYYlZyUW00VExHM1pxNWQ5eTVVbTA2amRX?=
 =?utf-8?B?b0VlWkJDOTd1aC9NZXZLd0I1SW16a0VabG5IY0k5YmpKc3JiWndaWVQ0MjVm?=
 =?utf-8?B?YnI4T2RkbHJ6Umx0SmkzWUZhOHdjMURnaEN5TC9GUWloVG43TGFXMSttUVoz?=
 =?utf-8?B?T2NkUFcyenc0VXQ3bWxjQnBJNjRXKzA2WGVTMzk5TnFDSUFwa3lPTXBMTHFl?=
 =?utf-8?B?YWRZdzJjMFdGUUowVEdZbzl4SHlUSjVaZTl5MjRkd2VhTWxDdXE2R0Fjc0RM?=
 =?utf-8?B?WnJBRmIzak10ZHBPV3A5azZIUjBrcXhDMC80S2dhV2YwLzBPdlNSbUcwaDBZ?=
 =?utf-8?B?cVdXcVFpTE5WMGFWaDJFSFRZUlpVTnpDQzhaYVovVzN1VWxiQ05uVzNZSk1O?=
 =?utf-8?B?ZmJBdjRqQy9vN0g0eVVhSEl4ZUszZGYvblAycU5RaUhNV1JtQm0weVZFRjVj?=
 =?utf-8?B?L0h1SlpiRTcvSkU1enhQbFFWZTVXbUZuRytUb2J4WG9EL0dIQUpHcUxFc3Ey?=
 =?utf-8?B?Z0sxeFJVTVRJekp1TlE3bDBTMnNGUFVlNm9HdWpVbXFnbndPekN3d2JOUWww?=
 =?utf-8?B?STc1dUZScWdINE80SWxtMDJpUmNMM25zOGszSzJVc2tqeWE2dG9FeFdwODBx?=
 =?utf-8?B?N2VjZ05zd1ZjZURyZGVlVk9EWHNsMHFNUjNWcldrTVYvV2N1N1JzQWxEZklL?=
 =?utf-8?Q?CyS0Fn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFRIRkNNSHFrUlZBOHZWa2M0UEswc0t0aE9WWUhUMHRHbng5K0RnR05mNHlQ?=
 =?utf-8?B?WDlxb2VDbWMwUDA5ZTZoQTNCcTByZW8vcmN6dkszZyswbUZ0OG9jVUtETnpM?=
 =?utf-8?B?T1hQTHkway9UN2NyOFdnZGhNV2pvK2tHOVA5a3orYS85ajZweUJFbXhjd09w?=
 =?utf-8?B?eVI2d0xEUHJoOUkwR3BoM1lxNnNqYzhSQzVabzhLOG9DZ2NhbU94dFRCWURG?=
 =?utf-8?B?M0w0V2grczExZ1gyRVBNSXJzUUN2bmlUQWFHcXhlbG9ubDYrZi90SkhES3Zv?=
 =?utf-8?B?UlNhTEh5MWl1Uk5HQTdYNnZrQklZRzh6cnljMjd0eTZSVi9JVGY2Y2Ezc1Zo?=
 =?utf-8?B?ektBNXVaVkErYi9yVW9ha3V5MTFBRnl6T0N5U1lkbldUbEZpOWZRU0VMUU8r?=
 =?utf-8?B?RDJVUXB0QXQ5d2N5RmlIUEhnUUdhTGdyZjJXbFdjRzVEYlhoQ3lPaTU5RGVt?=
 =?utf-8?B?WHNURy8zbXNhNEdYQmlJVkJ5WHJWWVZlMWRoNW90WjJsU1lvSkRzZ3BvSUVi?=
 =?utf-8?B?UmtZNWYvcTNoNVh4Q0FweEZpRlRSdEZPZmtVU0FDNG5vZGl5RExobDBNZ242?=
 =?utf-8?B?TFNKSkVjVXJ4SGhMLzREMmFlcFZ1czlESnk3SVh0MVVIbEhwcVN5eDVmU3J3?=
 =?utf-8?B?TVB5aEREbk9ad29zKzJoY1JOV0lmQlY3TytINDBlTkFiTjJyK3Q2V1RQMSt5?=
 =?utf-8?B?b3lRL0MyR0tuOXRRdUtTdzJtdTM1UnpSbElnZHRPQ0NvNTdZQUxzWFNscDlM?=
 =?utf-8?B?b09CSXBrMklNZGhFbGFFdkFBaGNyTEpUQmVwSWlIRWFxK0R6cDMvenZYZ1A3?=
 =?utf-8?B?VUFsdWdQSjFOa3h0WnZjTGtLemdrVU82WnBWQUw4aS92TWdFOS84c3d3bmRi?=
 =?utf-8?B?WGRlLzZpaFhjZ3l5VGdwYWZBNXRmSHYyU3A3dk0vWlBSbXB1WjRhWTdEUkd4?=
 =?utf-8?B?c3dTSFVzbXcraC9wTnNHVFd5TkgyMmxUbDJqK1h4Q1hZN0RiTjl2cEtLTTQx?=
 =?utf-8?B?VVJqVnRVc29adFUzOU9jQ1E3emhyb0pCY0o1aDlBWWtIeGJnQUF5NWVCWXhH?=
 =?utf-8?B?VUw5aGU3SmdWanZ1K1E3Z3RaTE9MOEkvb0x5azlxby95WU9COTlDa21oVzdl?=
 =?utf-8?B?UTBGdkp1Y3VoaHpmRkhRb0liVUZ6cHQzODFhVEV3QjFjM3pUeHUrQzhIS3FN?=
 =?utf-8?B?dlpzZmVvTzlHQlkyZ1FHOUhibEZWWDh2RFpYRkdCa1JEdWFnUVZjVWJHaUd4?=
 =?utf-8?B?Yk1hMHE3UnpneEp4QW5BNlFrT1B6UGhnZHI5REdyRXlxVDIvUi9iR1dYaklE?=
 =?utf-8?B?R3UxNk1XeWlSNEFYL25BUXhBOEdNWHY5WGU0ekxkdWlWUmdJSXE2anlVNkdh?=
 =?utf-8?B?OHFJQllsN000VVd6NEtxQjlCTUEvWE9xQW9ITHR3ODRFdnA1bnZYQzlPeDdt?=
 =?utf-8?B?MmdpbnM3UjlhTzRSb3Rnc3NCZnh2RUE1Y1AxT1FwMk5uRy9JU3RSWFNkVmp4?=
 =?utf-8?B?b1NLWXowRjR0YUFTTXErQXMyVmFFVnhUUU9EdzBBMU94Q29wV3pBMXRLWkpz?=
 =?utf-8?B?NkNwMFdZSm5NRnZrL0JITjdnVWYxZGhQc09sKzhmeWQvOW1jdG8vUngycTE0?=
 =?utf-8?B?SFRVN0h6b1BMMUtQYVd4OWR3V1dULzY0RWdhMHYvRGFaK2RqM1VxUTUraWZM?=
 =?utf-8?B?eTZVVjdVVE92S3M4MGZDUnVjK2hzcHl3ZzdLWlhBSzdBMkYxRDJMRnBINjJS?=
 =?utf-8?B?aDNuRHVqMzB6bGFBTWk1aVFhcE14b2N3QUYxRDJYRmpZRDFLSzByanVCRXVZ?=
 =?utf-8?B?RnZHUEtXSGZ4cHg0K3hOaHNwUzZDWHBQWjFBeWR5Zm1XL2l0eHBHS0FGRjkw?=
 =?utf-8?B?NHUyZjJKN3NRbGFxYUFKeFViK1pwYlhuZ0x6emFNZlVqT2lRU1dFUUxWWVUr?=
 =?utf-8?B?TkxGZUpGTDVkMkQvRlVMWlZjR2J1QXpYdTMxNHJrKzg4QjdpWVFLTXVBZk1l?=
 =?utf-8?B?WVRsYnJlNDhKSlVSai9aWnVTcHQxQ0RuemFhU01wYXd4NE9GNnlrUXpqK3cw?=
 =?utf-8?B?RHJQY2IyS1krUENFYVROeXdMU295MnNTNDRiQ0VSb2ZraVJXV3IzV1pqWUxY?=
 =?utf-8?Q?WnyH25Rwtdc/MvSx0HhJpIQ2v?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef29913d-27d0-4b74-c656-08de36cd6bf8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 02:48:24.1986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1wYz9VX7vcYQL+18/a14KgqrX1o2kTs4RK9ORH7qOG/3EGi65zRWktdD7orYgm7UNhkzyD13DaN5tzTzhdMmyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11897
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

Remove the use of CONFIG_USB_MAX_CONTROLLER_COUNT in
enable_usboh3_clk(), as this option is relevant for non-DM USB. The
i.MX8ULP platform uses DM-based USB, so this dependency is unnecessary.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/imx8ulp/clock.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-imx/imx8ulp/clock.c b/arch/arm/mach-imx/imx8ulp/clock.c
index c390f20d769..faf81262160 100644
--- a/arch/arm/mach-imx/imx8ulp/clock.c
+++ b/arch/arm/mach-imx/imx8ulp/clock.c
@@ -286,14 +286,10 @@ void enable_usboh3_clk(unsigned char enable)
 		pcc_reset_peripheral(4, USB0_PCC4_SLOT, false);
 		pcc_reset_peripheral(4, USBPHY_PCC4_SLOT, false);
 
-#ifdef CONFIG_USB_MAX_CONTROLLER_COUNT
-		if (CONFIG_USB_MAX_CONTROLLER_COUNT > 1) {
-			pcc_clock_enable(4, USB1_PCC4_SLOT, true);
-			pcc_clock_enable(4, USB1PHY_PCC4_SLOT, true);
-			pcc_reset_peripheral(4, USB1_PCC4_SLOT, false);
-			pcc_reset_peripheral(4, USB1PHY_PCC4_SLOT, false);
-		}
-#endif
+		pcc_clock_enable(4, USB1_PCC4_SLOT, true);
+		pcc_clock_enable(4, USB1PHY_PCC4_SLOT, true);
+		pcc_reset_peripheral(4, USB1_PCC4_SLOT, false);
+		pcc_reset_peripheral(4, USB1PHY_PCC4_SLOT, false);
 
 		pcc_clock_enable(4, USB_XBAR_PCC4_SLOT, true);
 	} else {

-- 
2.43.0

