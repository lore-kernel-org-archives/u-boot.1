Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A00C369D5
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:35:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 165FC8070C;
	Thu, 24 Apr 2025 08:34:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lhvt3Ui2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8211781F45; Thu, 24 Apr 2025 08:34:30 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EC71806FC
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:34:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFFt1ZfhSX18OQJKCHvVbwrl1YYGgVadv5QxpD7m1TdUNffd229VMxeBnHyTLtJUjNGjRJnke/mVuQt15hYubz+4zCCdPr8abMCGVOpUVkU4x7/CMADfYls70lp7RTqOxKmiK7lennJZjdvobesaGOToemvarXWAl6enkz3JlrZ40L3EuU5xQviFU3Kara1IXV2EHh7bSJhqFAH8m9IJqOrNoYNB+ewt0ysBN1jDrO6GNTLtvGt3bNrUiesCot/nTsOXk+QGxCk9wtshvqTXutpjwkg8E50GexzflZqF4bsP1xi8fGO9E4O57hlKyL9btlNRRBIus5NxhEwUD6SCqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9+It9L2QfiZ5GzRSWJHUlr6ud+tpHmWbslmFiKPX4U=;
 b=Fzb/F9GrIZIvFkT2LnKBnw0mEfyo1SV0fD8IZT9UXzrozuJaaS1Nx/Y6zp+2fusgYUICA0naocpPlDwiLLtzyDDUajyiIocyG3qInArJuAVGNGnAx/IlukIXkWSeb36iu50zDlW0nPWVK6fy6gWCD+suDvlJGeOvUDqVyIdNx1r5YWdfOhkKLcfrloHgBL0ry3QNK5efQgqImGPr7csPANwcl5i1lXaGWf/XS7jPM6IasrN4bXeVSiyasTyIMH0upeFSMDe5++snKZlmZl7LSnq8m/AFqYdEd316TkAUApT9fSHcTV+u1PPbYnUXERDJ6tme0C3cPc8b27aaUQ4fIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9+It9L2QfiZ5GzRSWJHUlr6ud+tpHmWbslmFiKPX4U=;
 b=lhvt3Ui2G7THMFmphs4Y9f0wClqq1VBasevJJpdnDDbYTThfjGNeMXla5kedqkSWLpcs+HJ+sUB8YzijydVyG6G6kOgHyAsQRzJbmwOOt+n+GqJacWXIL7hvzX90hCr1WX8jA9CB4aFO5Bp78saUI8BciG257sICMR5ooBi63bnAv6Kq5UdAzYpxPLAwmnbVZepeI1uWFY41Ol+VbLGAw7BPsOZ90Ba1cfvEjKXNyW/6y/RuBfMr/0q6oCIfhFhtvKDNfvOnDHhhN1cTN7iqnMjlvACZ0hSYjWLDm2SmEC2kmEg4MDmImH8MZJ8epUwDjQzkIuX9D8G9syERuAKZWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU2PR04MB8965.eurprd04.prod.outlook.com (2603:10a6:10:2e0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 06:34:27 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:34:27 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Thu, 24 Apr 2025 14:33:05 +0800
Subject: [PATCH v10 09/21] sandbox: add SCMI clock control permissions to
 sandbox
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-imx95-v1-9-10a8449b1e5e@oss.nxp.com>
References: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
In-Reply-To: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU2PR04MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: b88c98a5-3837-4d30-4446-08dd82fa0f6d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjhhbWNxWm0rMXRFbUlncUZaSVMxVUw4WjFqUWR1U1AvQ00wTDdCRFZ0eGMw?=
 =?utf-8?B?UmJWNVIxalA0cjRWU2lua2JyVVJiYW56MFRabTVrcDNtVUlKazF3YVJLUWo3?=
 =?utf-8?B?M1JYNXFkWENDTE1XWUJhQXdwLzF1T1Z6bXN6TnRoUzlxY1VuZHdaZjZZSHlI?=
 =?utf-8?B?ZmNMRFh5Ly93ZjVYUHRoUjdobFJkT0ZpbXhEKzlQd3JtaFNRVEJQak5qNkVz?=
 =?utf-8?B?bFhSLys1N3o4T0Z2R3Y5eGxNR1cvOEczK3o5YXVXdXZ4VjlRbnRwTDdKUHR1?=
 =?utf-8?B?OGVlK2dBa0p0bDQvV2RqVjBNUExldXZndWdzR2Y2cVA5ODdOQndlYzlFMmxj?=
 =?utf-8?B?ZStKRkhNenJVcjIvb2pCdWFCNTdhL3lQV3EyWHkvTHU4bVRobEtkTEs0YnBX?=
 =?utf-8?B?RW5kNVFxUW5tU0dzMER4dWx6VXA0alNDMjRTTkZ6QVZHTEFNYkFjL29qNkQ5?=
 =?utf-8?B?dytGZG43MXNiK011SnlPMXRCZCtWZFhhMmhXdjdFRGxjSnJpcHdLV3ZEM2E4?=
 =?utf-8?B?eWpzcWZPWTJEM1ZYMDMxTVpmT3U4N3NpWGlRM2UveDZsVWUyUmlONlUwZGNY?=
 =?utf-8?B?N3IwSHRQNGtrekNJdHB4OEswT3ZaV3BveG95SkZGdmR6RWlhUTN3UVFHK0tJ?=
 =?utf-8?B?ZUROTUFvbm1hU1NFbkNtNzBBeW1memZXeVR5eUl2SGJheUFhUWZrTUhlNHZG?=
 =?utf-8?B?cXoyOStYYnF0QTIwc1ZmT1VyaloxMHdTaHJ3VUtWR0lLOUpESDYrMU1iRzk4?=
 =?utf-8?B?dDFDRGhXVHVnY2xwWGR1b3I1ZWk3RGNQVHBzSitiRjdDQU9RRTZ3R1MxVzhw?=
 =?utf-8?B?dEZhVHloSjViT2lybElXNGFhaHNiVjMwOUZzNjNickJ5azRCbXMwalVXMDZO?=
 =?utf-8?B?VlFoYzF2aHlOYlFzT3llbUFXLytvcVdPeVIxSlVtdytlMTZRczVjdUd2ZGNy?=
 =?utf-8?B?QUpLM1VxcUFCdVFEZ3N4Uit0SEFHOWxGQXBlMklRNmlESE1tN2Noc3FFQ2hU?=
 =?utf-8?B?R2pWRC9odlpTNVUvTkZmeHZrNHcvbmtaYlBOdW9UUkwyMXV3UkxDZW5yaHdL?=
 =?utf-8?B?aHRUaVJLa0RpUkhJbnkrYVI5MU5CNjJRUlJYSVBpSUlPSDBTdml5OUhPejAw?=
 =?utf-8?B?c3hPY1VWUlgvcGIzbzF6ZTJQSFhLV0JKNkRMeTRtRGNzUVhhSW4yQ0sxTnJ4?=
 =?utf-8?B?S3NhZXpVeUFKenFHQUQxQms4VWpWbTc1TzdtZGQvWnJveUsrOGZkQTlLS0Qz?=
 =?utf-8?B?ODNsRzZpSlFDNHFlaUFTT1o5MW1CVXVFTENlbTNjeUN6S1FWWTVMNldEakkz?=
 =?utf-8?B?ZFVNM2xobkdlcDBPaGRMVXl1eW9maHR5Mm1NOWIwc0Zya3RpRldrZXQ5RS8v?=
 =?utf-8?B?MmhIbEdaUDNLVlpkcER3NWZDMU1jc21GdHhBZjc5UHhTck9kRGtHcEh3Q3JZ?=
 =?utf-8?B?R3pzVC96YnV3MDdBbS9GSElpZ1JZcGc3K0V0ZXBkRklyTWtpa0VJbUU3WVBR?=
 =?utf-8?B?NG1ZaUxFV2t1WGlBcGwwbitQWUgyb0cyTUpncUYvenFUV25CK1FPS2wzcVFE?=
 =?utf-8?B?YytjRUo1SXN6YXY2N0ZqOFBqUlE4UWxxc3BJV0V1Mm1DbTR4MTI1VWQxc1ZH?=
 =?utf-8?B?UWgycTVjL3d6dmloeUhkRTA2OSt5U0Y4QkhEMUN5bWo0UDlObndVVFpieG1y?=
 =?utf-8?B?NWhzYkkzdVg0ODltUW5zRGIrOWZwb3BXMTZXNVI3OWtraUUraTcrdkUyOWFk?=
 =?utf-8?B?N3lsb2ZJTmJCcDNNZ1MvUWpldTdwalk1Ny9XQTJwZzY3a1pZc3c3YW9rdG1z?=
 =?utf-8?B?aEN5aU5oUnZJcnZOai9TZTdBVzBTRGFubjJsUTZ2c1lLeG9KT21hTDQ1dnFi?=
 =?utf-8?B?OVJyQWZvMkFxZFpSU2tiUU5VNFFzU1E3ejJsVUNRNGNBRGQ1RkViNVBDNGFs?=
 =?utf-8?B?NDlKV05tNDdjQVNTM2hsbDlBcE11V3VRMWRFUEJRZkNRT3Nsb0NRTWwvbjlT?=
 =?utf-8?B?R1BBSUMwUDVRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akQwaTVNTmJIQVVCSmFqN1V3WHNzYWVsQ2MxZGJ3QmR6Mmh4TDNGOUlQUHZR?=
 =?utf-8?B?dXlleDFHQlNKY1dYUjhZaVg2U2RxdnQ2N25Wd3hJQVkrTno4eHNacVpLV0lo?=
 =?utf-8?B?ekxHTTloQ0poajlDU0Y3Q2o2R3I0aDhjbXpqM3NtUlErOUpUdU9qR1orenR3?=
 =?utf-8?B?SkZyZ0R5VldFT0JZc0ptajdUTFNVV3Y2Rk5oUm1kQUJ6TTV5MGdSRGRuNHpS?=
 =?utf-8?B?ZGhxN2RlTTNId24vemdHMXE2R3V2TnNGZEJFdEFBREdVUTN1SHk3c3BFRWNI?=
 =?utf-8?B?aHB0T1F0Z1dPcGF0aXJCaVpmSitOdXYxeERvc0V1NUdGc0tLeGFPN2pESWtG?=
 =?utf-8?B?QncwK1VoSXppWFhuVmUxekI2V0VNeTBwMSswVUlMUERjZklpYmVIa2o0NlQx?=
 =?utf-8?B?UDROZm5BVnlyZjMwSDUxUW1pZ3gvUW5JRXhMZmdDeEJLelZzZ080VzlaT1Jl?=
 =?utf-8?B?aVE2NUNuTi9MQzBudEhMYTNIejNnekdDR3dPNnpoNlovRmZvYkJSZnZMOHFJ?=
 =?utf-8?B?MzdpZnpWY0NjTkZSdHBUNmZCb1p3eVppNUZCSXU2cklsQmoxb3BIaC9FM1Zs?=
 =?utf-8?B?aTkyL3ZDQ1VDaWdlcXArUU9kVjBBaTZtaElKVklvQXZxZThKSEZDeFphalVJ?=
 =?utf-8?B?K0x1OUlvUzNLcEkrRkVWbG1jZERLNjliT0sya3BaaE1VYkw2NXRmTzVFdnY1?=
 =?utf-8?B?dmViblJ6cVkxN3pmYW5mL0VPOVkrTGthZ0MzeDkwa1VlaE52aTJxTEhmcjVB?=
 =?utf-8?B?cGtHMEdvWkZ1eHVTNCt6SEduVDlLUGRvMVgrd3E1LzM5NjFzanNDa1A5eHlq?=
 =?utf-8?B?UkxjMHY5SC9ZSW5tNWdJUVZCMFRSbUs0b3ZqS0NHcmdORHpYVDlEdUVubUdR?=
 =?utf-8?B?TUVraFJ2WXdWMnI2MHQwUWhtOFZqS1JnbjhWc3lwM0htaFdiay9XMHgxMkRo?=
 =?utf-8?B?NDdVM2ZidkozZVh4VWdMaU4xUmJUZnN4c1dPNVdMUFB1RzZKTThDdUd6amVM?=
 =?utf-8?B?dVpEUmVURGNJMFpxQUNhNndBczNVWnZ2QWxIbm1DRjEvZXFkalR0dUwwWWFL?=
 =?utf-8?B?bkVRaFRKZ3dSZGFYeS9NUVFiRmZFU24zNHBXOXhZRWJJeDNQWm5jelVhVWxh?=
 =?utf-8?B?anJVQTdPWFZnc3BVdFVwajdTMEtJSkhHLysrT1d5WXJ2dnkyWnhrSE1ac0Jw?=
 =?utf-8?B?WHg1Y0RUYVc1VENsNjNkYWZ3Y1JkeVlERTl3YVdGMTRPWXBDVzRBN1hDd2Jx?=
 =?utf-8?B?aERjUHE1cmJVZW5qOW42cEFwcUl3VlpUdVhNWnF3ZFJ3OHVHa2tKcGJtQ08x?=
 =?utf-8?B?QUllTGFURkZGVGk2L0Mwd0NwcVB1Und0MnBkUmRPODFmM2pDZTU3NEJmSXBC?=
 =?utf-8?B?T3N2YnBtZzBpVE5pMm9aZncyOFIrYkZzanIrUUxvQmJUVGJhc2pLdkJTdXB3?=
 =?utf-8?B?VG03aGRBNHR6YlhVNS9RSUtFRjBvTkcxZ0hhWWp3a1dTcmZSVHBQN0srcVVu?=
 =?utf-8?B?WElvMmVMK2xscDA2ZEI4N0RiTGYxaXREVEJJODlJMmtXakNPdmhadUFUUjJI?=
 =?utf-8?B?M1dPQWcrVVVlRXVBTEZVbGdEbzJxeTJQOWJMZXNxblcxU25sK3lMWkpja0VD?=
 =?utf-8?B?aU9RaGpJZ2M3dmIrQ1YxcVlmWi9icExSejRkUDBSMDJKT3BmbkVhUDcwQmpt?=
 =?utf-8?B?SEhnQ25VNW9NR0tMUlh0QlZmd1NwZDF0c2R0UmdSaUVPSDEzcTFCN1VWSTNM?=
 =?utf-8?B?aU84Qk8rbXhvY3J1dXV1NEs0dlp4UkhaZG1rMVU1YUlTelVRK3QxMVFxc2gv?=
 =?utf-8?B?dnBhMloyaDViRGNCL3JMSkRqd2htZTUzOHRDSFl6S2ZEa2N6TTd0ZFE1L1Nk?=
 =?utf-8?B?RXhsK3o4MWpHUWVIQlR5aUNOVlRmZ1hHbUZoZ3loK1VSMXhiRStOdkQ1M2Nj?=
 =?utf-8?B?ZmU4cE9vdS9LcU9GSnpnOTFoblhmZmUrOXRhTGxrVVdRd015QWUwVktSUXlq?=
 =?utf-8?B?WUkvV1ZaUXFiZXNKbVJ0YXl5RXRzSy9kTFVLRE5mVy9UajhDZjd6clo1QzBs?=
 =?utf-8?B?cEVCYlVpWFN6cUM5eXpEYXBLTnk1YTlORFluVStPVkhTeC80MUVUdE8zS0Fu?=
 =?utf-8?Q?NHR4uC0L+2cWPv0Uo/BDd9doy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88c98a5-3837-4d30-4446-08dd82fa0f6d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:34:27.0582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WmZa9hfPR2+3rGCDwppAXoRgci30FMeMcWzRQv1LPTtS8GW0rvsZ1WopvQSyYajVQSc6BCMdIaCXPSOMOchLsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8965
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

From: Alice Guo <alice.guo@nxp.com>

This patch is used to add SCMI clock control permissions to sandbox for
testing.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/sandbox/include/asm/scmi_test.h       |  2 ++
 drivers/firmware/scmi/sandbox-scmi_agent.c | 56 ++++++++++++++++++++++++++++--
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/arch/sandbox/include/asm/scmi_test.h b/arch/sandbox/include/asm/scmi_test.h
index 619f8f5098c..b30e536a357 100644
--- a/arch/sandbox/include/asm/scmi_test.h
+++ b/arch/sandbox/include/asm/scmi_test.h
@@ -27,10 +27,12 @@ struct sandbox_scmi_pwd {
  * @id:		Identifier of the clock used in the SCMI protocol
  * @enabled:	Clock state: true if enabled, false if disabled
  * @rate:	Clock rate in Hertz
+ * @perm:	Indicating state/parent/rate permission
  */
 struct sandbox_scmi_clk {
 	bool enabled;
 	ulong rate;
+	u32 perm;
 };
 
 /**
diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 19be280ec44..74a87832dcb 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -80,9 +80,9 @@ static struct sandbox_scmi_pwd scmi_pwdom[] = {
 };
 
 static struct sandbox_scmi_clk scmi_clk[] = {
-	{ .rate = 333 },
-	{ .rate = 200 },
-	{ .rate = 1000 },
+	{ .rate = 333, .perm = 0xE0000000 },
+	{ .rate = 200, .perm = 0xE0000000 },
+	{ .rate = 1000, .perm = 0xE0000000 },
 };
 
 static struct sandbox_scmi_reset scmi_reset[] = {
@@ -700,6 +700,21 @@ static int sandbox_scmi_pwd_name_get(struct udevice *dev, struct scmi_msg *msg)
 
 /* Clock Protocol */
 
+static int sandbox_scmi_clock_protocol_version(struct udevice *dev,
+					       struct scmi_msg *msg)
+{
+	struct scmi_protocol_version_out *out = NULL;
+
+	if (!msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	out = (struct scmi_protocol_version_out *)msg->out_msg;
+	out->version = 0x30000;
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
 static int sandbox_scmi_clock_protocol_attribs(struct udevice *dev,
 					       struct scmi_msg *msg)
 {
@@ -740,6 +755,9 @@ static int sandbox_scmi_clock_attribs(struct udevice *dev, struct scmi_msg *msg)
 		if (clk_state->enabled)
 			out->attributes = 1;
 
+		/* Restricted clock */
+		out->attributes |= BIT(1);
+
 		ret = snprintf(out->clock_name, sizeof(out->clock_name),
 			       "clk%u", in->clock_id);
 		assert(ret > 0 && ret < sizeof(out->clock_name));
@@ -837,6 +855,34 @@ static int sandbox_scmi_clock_gate(struct udevice *dev, struct scmi_msg *msg)
 	return 0;
 }
 
+static int sandbox_scmi_clock_permissions_get(struct udevice *dev,
+					      struct scmi_msg *msg)
+{
+	struct scmi_clk_get_permissions_in *in = NULL;
+	struct scmi_clk_get_permissions_out *out = NULL;
+	struct sandbox_scmi_clk *clk_state = NULL;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(*in) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	in = (struct scmi_clk_get_permissions_in *)msg->in_msg;
+	out = (struct scmi_clk_get_permissions_out *)msg->out_msg;
+
+	clk_state = get_scmi_clk_state(in->clock_id);
+	if (!clk_state) {
+		dev_err(dev, "Unexpected clock ID %u\n", in->clock_id);
+
+		out->status = SCMI_NOT_FOUND;
+	} else {
+		out->permissions = clk_state->perm;
+
+		out->status = SCMI_SUCCESS;
+	}
+
+	return 0;
+}
+
 static int sandbox_scmi_rd_attribs(struct udevice *dev, struct scmi_msg *msg)
 {
 	struct scmi_rd_attr_in *in = NULL;
@@ -1193,6 +1239,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			return sandbox_proto_not_supported(msg);
 
 		switch (msg->message_id) {
+		case SCMI_PROTOCOL_VERSION:
+			return sandbox_scmi_clock_protocol_version(dev, msg);
 		case SCMI_PROTOCOL_ATTRIBUTES:
 			return sandbox_scmi_clock_protocol_attribs(dev, msg);
 		case SCMI_CLOCK_ATTRIBUTES:
@@ -1203,6 +1251,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			return sandbox_scmi_clock_rate_get(dev, msg);
 		case SCMI_CLOCK_CONFIG_SET:
 			return sandbox_scmi_clock_gate(dev, msg);
+		case SCMI_CLOCK_GET_PERMISSIONS:
+			return sandbox_scmi_clock_permissions_get(dev, msg);
 		default:
 			break;
 		}

-- 
2.43.0

