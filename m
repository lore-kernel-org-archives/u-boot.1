Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96ADCC531CC
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 03:07:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 325F440ACC;
	Fri, 24 Jul 2026 03:07:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CfhAQyK104J0; Fri, 24 Jul 2026 03:07:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 71AD840A9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784862449;
	bh=32jE8pB7nHNlM7oNY09uOntbHHbB7ffFMEwWo5WTfKA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kxPBWll01LCdRWth+3e8SuH2o1U+4DAwZ7OTk7LV2ROeh5PB53rYraBhKTadH9Bwa
	 GQr2ZvdK5magpHDWQ4l7qQwUi+ZJtmtefa4b/S+FNe63af+1RUlLrxXQ2m7DdNkTWc
	 ge6fqecax2tBff0MqQoW1fr1INObsgwXUHE9hsJ5RI5JaUb3+ouTyPOJDisLy/ICBW
	 zVh2t9771dya42WPXksm7xbnWHdLs3CZ64/Ued6O9lqY8fE9BpThS0JSsbbEZVVb7G
	 pIFuNWiQUvOgUd6SHlUINqGYQiBrQemeDNWTHyY827HBIxld+OEwpCgY0Kyw5VGly8
	 u6xzOzF+NIWUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71AD840A9E;
	Fri, 24 Jul 2026 03:07:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B43B22E5
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A679140AA2
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:07:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6ePyI4X2HcmE for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 03:07:26 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3D31A40AC9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3D31A40AC9
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3D31A40AC9
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:07:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmi+036o3Mr7JcnhIUlpGhJtOR0m79YMgJtbpgn9/Xg0NeIiv+crvhLiZAubPVdgBOnMpeNqvsbxsgETG4b2ua1cRJjIq+VmpFDNDz2f9LMitp+DCGF9eeMISNQ+SL72q/jGsU6lUnurXeeGLxxdgfmvtPcsh8PeRFzKB/uAbzwIlBXJT5QHBHA1kerbYjH4w4XHH+zsPNgKRswjDrLL81Jl8w0zCH5si99mFWGQ/NisoXgJ86pY0boQqFr0v/o20G9f3x+TXUGv1cKw2rUrpxpdseM9a9bTN5iXLcC/8WU5JlsfOweBZPhKOmfzSCZTsXtx96MvC1pnaIhZm7hTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32jE8pB7nHNlM7oNY09uOntbHHbB7ffFMEwWo5WTfKA=;
 b=wcRclUD+8cx//h01UQ23ni8x320DHhqeot5tJr0C0tLJYGXonQgHVD0YkT1fJAQQ67XCCbExXUuD9VcStn4dIF1iNNN7RD3Whrvo1OQmusBQnt1M7g2nP8KWce8XD2pAnjcQYd45Jog0x39Sfbe+FS5mkyGxNX6/zizc6KEDZ8IN1y3YiMUZHe899PSXID3LEGc+/uhZYXT+fYKsPrkStgREj8rSXRr4DWA9EPxR8XA9bBYOAUwZje1pr9jCoxgRLe/mE/LXk1Dx1JmCzzLdalAXswvjufj2E1Ladj2gaTMFXieYK5W+YQ9vycH4LAJ6kre2ciapeHM0yn2HxO2KFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by GV4PR04MB11749.eurprd04.prod.outlook.com (2603:10a6:150:2df::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 03:07:23 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 03:07:23 +0000
From: alice.guo@oss.nxp.com
Date: Fri, 24 Jul 2026 11:10:44 +0800
Subject: [PATCH v3 2/3] net: fsl_enetc_xpcs_phy: Add SGMII 1G support for
 i.MX95 Ethernet PHY Wrapper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-imx95-v1-2-7131a9e17fe1@nxp.com>
References: <20260724-imx95-v1-0-7131a9e17fe1@nxp.com>
In-Reply-To: <20260724-imx95-v1-0-7131a9e17fe1@nxp.com>
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5P287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::9) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|GV4PR04MB11749:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f3f9293-0951-4dd0-7d41-08dee930aea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|19092799006|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yvggnlFasidV1kIu9ZfEmljVjqNFdIv/G+Yxuu6umtXgK4F8D/SL+cwqK/rG+MnJb/KgBToyE2e9TGZA1YzkHFFBrOoMFroEEzW4Maop2nO0bP3BJbN0srBPEBDG/uDSlo0TGdqSDt7qLo4PZtcaOoNI0nXX3IAW4SauqAnxYEMDcRML+BoK0RlQ8+wk7xN/ZA+xrIdscw8dHKjriHnKdBNPjHXWaYGAFfTsNwvSvo5ileQxEJploQHpq+iDQoVI/Uaf7WH8rPyZQe8uAT55Dvecdc0ysinFUAo2oxJ+UDP/EkXOccS8cme9pFMgE9S2KUEcb6QG4xhB14G8cx8Nli2AM5fCi65Kf46gtOsYHcFsYXp9SO/AKH93ps2vkORakA6Tc9Xa/6eCCffhCOgxyFsjMFfllXQw54VuYaNs+8paystIB6VGMXKviJZgrQK9vuGYlfXSKAej+C/ybp9aHmiURU8aIZaJwNjs8sEJmX6T63wF5CUfaTAypcVIIP0Om6/rkit6iFygKfz9bV8O0heMuwke6k1oDiW8jtM0msws/9QLGtOFFfYe69ckxxqYmgByoY19pXqwC1bwJqrtg2+gWlV1DSqjmZZ8DIIPvFg+PYrqphLtcf8Z/an2sZIrhbeC1FwRL1v7ghgNZTowvip9ZGKPo+r63qu8mkwcvM0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(19092799006)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXhEWGhGNlFBOGJaTEVqK093NE1zTmNUcVlOUGNGR1hUckw4QW4veUViZXRN?=
 =?utf-8?B?TVIyUGl2YlpMWUVLcG9wRXJpVFgyNDZFWU9WZ0JJOERRYkw4bEdPZW9mL0Zp?=
 =?utf-8?B?bEhMVjk4eXJXODNHeTdSeHE3MTNQTG1FdXM1YTdSSC9NdUt5Rno5TzBKNHdC?=
 =?utf-8?B?UitrQzZSSjh1ZmdNK3ZiNzg4dmhBMG5tNWdJNlpoTmUxMHI2Z1d1QktkMU5l?=
 =?utf-8?B?N0dpYjJLTmRtQktKVG1HcmVYSnluaEMyYUZrK3JTOVh1Qk1mZklNZVd5Q3A1?=
 =?utf-8?B?U3pDUElTaUtBQVgrbVRxR2QxZWZWcFFETUhzUko0dDBPNXlJQXlNU1IxZEtT?=
 =?utf-8?B?a3NubUVrVjJRSVBHRElVZXQ3U0JIVUxNOU92djljS0k5Wllia3pzOHM0bWVD?=
 =?utf-8?B?QXZGTGJQVDZXNU45dHkwUERCR3JXeDFIMDViRTBLcTF0bWNtNmFKUVEvQUdO?=
 =?utf-8?B?aG5UL0lFRWIrQXgzTlptREF2MUFPVXh1blliZVN4SW5VbWUvRlhmdEFnSTNv?=
 =?utf-8?B?L2Z6RG43QnJSY3BtWnIxZm55R2JUd2FwSUdwamNvdU1ib1A1dDZkNVhIcWF5?=
 =?utf-8?B?aGI2T3FrUmErTTJiSDQ3a1I5TWlZZmpVb0NwKzh1Q1hKWnJpSFlJdjFUaG51?=
 =?utf-8?B?UzBaVTk3STNTSmh0dElUR2ZzTkh0T3ZKTWZLVkF3cTlBdS9SZE1vUW9jZTFi?=
 =?utf-8?B?WDBnZXgxWnpHVjQzbm1XRjExT3pad2puSFFWNzRRcmNmNStyZDM4cmo3NGdx?=
 =?utf-8?B?ZlJqMTVUZ2VzdnJjMFJIT1VlV3BBaHFXMlVwTFdJT0IxT2ljbFBJamhYeDBM?=
 =?utf-8?B?ZUpYNUFEMlZyK3Z4dVpyZk91dE05dG1zWE9JVWpWaTNodWwxWG5LWi8veVhE?=
 =?utf-8?B?cEJBQnpBcXg0R01yOEVIOERkeGdUZ2cxN1RONW5ZbkQ5SW5BU2hNTk85Tlk2?=
 =?utf-8?B?TGJzdUVaYXl1NXBVQUhqOXovOEVMQ3Joc3JPTVpwRW9oNU9vQVBqeEEranZ4?=
 =?utf-8?B?K2oxcDlOcnR3aVlIUzkyNW9PY050bzI1aExWT2RKUXo0aDVqU3lLRGVQY3Yv?=
 =?utf-8?B?ZjVsUjl0aUhVa3NXcFpvSUEyNEFLUU1HT3NlR3g5eng2YjlQaUpXaldQSVl0?=
 =?utf-8?B?ZlBBTEtKUTh4NVlYVDNaUFpReGUyMW1aRVJDTUIxaTVveERSQ0JDVWtpemtC?=
 =?utf-8?B?UmVaZHlmazd4QTVoaGh5ZW8xVlowSm56N1AyRUVqM0FBZzRwSWd6ZmFHaytl?=
 =?utf-8?B?YWYxdE90RzNKdU9YZXhnandnZzhtbXZQV1oyOG1IN0VRSnRnMlRTcDIrYWxE?=
 =?utf-8?B?aU1pOFBFSmtHemg0OFpxeXV3b0JIeTR1bExnT2VXY3NoV1lxYkRvM3BKZFhO?=
 =?utf-8?B?UzUwc3k0NzEreng1S0EwMHhqZHdIMGNmbnVJSEJLSGhGdGdERVEzcncxWGlM?=
 =?utf-8?B?SVhpc2g0KzhvbTJJQ3ZaQTJJbWh6ZVN0OWdJYTRQSXpEdmI4WDl0Zjg5RW9Z?=
 =?utf-8?B?WHVIZDBPcWIzSHY3bFJnMDdSSGJOYmRYK3BiZkVCT3JneWk1OHBzK3NBYWVD?=
 =?utf-8?B?ZFVWUStxL0d5M1NCR25yVEduS0JpVUxaUEl2aUczZndNRjRDK1U4YXN0cDl6?=
 =?utf-8?B?NGd0WUJlYk9IWVdKTWlJMENoVlhTK2VZT0Voamt4VFpycW1xNE9RWmlGYXR2?=
 =?utf-8?B?cFA5eENNbE1lZDQ2NXZjamRNL3h6QjU5dElqL2VvTC9uQlJmTEZIVzVkcGF3?=
 =?utf-8?B?ZjVvSlB2TEljNUtoTWJiaUl3bEliWTh3SU1HbERRVFV6VkEwbU5wVHdUSnBs?=
 =?utf-8?B?QlhkZWNsU1JwajhDb2MrYzE5WnBUVk5pWE82RHpxOVBsbGhUdUlTb0VWUjBG?=
 =?utf-8?B?UGQxcUd4cnJvSVpXZjFMZkUvcGVXZlJoZWQ2TndyZjVHWEZIZ0M3Z2xKVU15?=
 =?utf-8?B?MUpUVm5KTXJFSnEyZzB1VlUzeTV4eGpDV1U5SUlwL2xYc2phYjNySTRDWGhN?=
 =?utf-8?B?djNNazFWbGlzR0hqZWU4MWszNm5HdkU5ZkhCRWFEaGhFWkVLdnVaeFJwOVNa?=
 =?utf-8?B?OFFMWGlYMHpqTlhMeFc3UzJBcG16Y3JCUGl6VDhOeXNJK1VjME9ZSG1hdDEv?=
 =?utf-8?B?WmtwM1NmR2dpNW4zTzU2Wk5zYmpDbnl3VW1oTGJINWhmdHhMUnlSb2xMbkN0?=
 =?utf-8?B?djl4dzR0OU9jRWd2dnBMc0ltbHIwRWVUcnR2ZDNKVHVCRDdQWlF0K1VDbWQ5?=
 =?utf-8?B?MEgzWEM3djZBS2hMSHFKTmVVR3k5QnQ1aDk4Mm9XOFBnaUZKVmo5Wk56SHZ4?=
 =?utf-8?B?UENUcERPNXYvWGxKUys1VWpFRVY2TDBHb1QwVlVGTkpVMk1BM1dDTFhGUjBN?=
 =?utf-8?Q?ftrWLJgB4zh72OGOtKMjbrtFzdfi5olXePScR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3f9293-0951-4dd0-7d41-08dee930aea3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 03:07:23.3650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hIUWzlqVyNKOQNCtL2d0jETy2TTJNEIdxX+W/Z/KcEYPAqAizLB02KOW3niZ73aTZmHdRgdWu6akE+W/1n6/aiOaIPksktdYupT4eAYlLA51jJhfcfinnAB4UwbBu5v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11749
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32jE8pB7nHNlM7oNY09uOntbHHbB7ffFMEwWo5WTfKA=;
 b=vCQz5/S+RG1B6J+cELKc6wemrgXMurCN0X1MCqrYbqKuj+23I0a9ZBQCWI9+RJR5VSoqg6e8tYu6taU4Ws6skCnTj8EWqz+of8ECmOVqcM1UnNGCT/DhykHUFUCbfDjnZGw2+RjQG27FHwi1qR/1+uHsQluCj7bTIis6l7mnUkUYg4e725slAYgCWemJ3OiMzZ4oDG5RryG3nGO+c5/07lcyH6/vgcC5vhZ2kQJMr6jrk/VQcgE1EaU8zzTXnP+1wQ2oV9gu04m5rr5532+q4A9QqrDFiHvBfDRmbJDSnG+o9t1awUT9DMwELLxZHPFNzq1extdH4kXKv4ukYKgx5w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.nxp.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=vCQz5/S+
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
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

From: Alice Guo <alice.guo@nxp.com>

Add support for initializing the i.MX95 ENET_PHY to 1G SGMII mode. The
initialization sequence is implemented according to i.MX95 Reference
Manual Revision: 5 (2026-03-30).

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/fsl_enetc_xpcs_phy.c | 512 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 512 insertions(+)

diff --git a/drivers/net/fsl_enetc_xpcs_phy.c b/drivers/net/fsl_enetc_xpcs_phy.c
index 006a2bd2238..6414324e7d2 100644
--- a/drivers/net/fsl_enetc_xpcs_phy.c
+++ b/drivers/net/fsl_enetc_xpcs_phy.c
@@ -57,6 +57,8 @@
 #define PMA_MP_16G_25G_TX_MISC_CTRL0			0x1007C
 #define PMA_TX_MISC_CTRL0_TX0_MISC_MASK		GENMASK(7, 0)
 #define PMA_TX_MISC_CTRL0_TX0_MISC(x)		((x) & GENMASK(7, 0))
+#define PMA_MP_12G_16G_25G_TX_STS		0x10080
+#define PMA_TX_STS_TX_ACK_0			BIT(0)
 #define PMA_MP_12G_16G_25G_RX_GENCTRL0			0x100A0
 #define PMA_RX_GENCTRL0_RX_DT_EN_0		BIT(8)
 #define PMA_MP_12G_16G_25G_RX_GENCTRL1			0x100A2
@@ -102,6 +104,8 @@
 #define PMA_MP_12G_16G_25G_DFE_TAP_CTRL0		0x100BC
 #define PMA_DFE_TAP_CTRL0_DFE_TAP1_0_MASK	GENMASK(7, 0)
 #define PMA_DFE_TAP_CTRL0_DFE_TAP1_0(x)		((x) & GENMASK(7, 0))
+#define PMA_MP_12G_16G_25G_RX_STS		0x100C0
+#define PMA_RX_STS_RX_ACK_0			BIT(0)
 #define PMA_MP_16G_RX_CDR_CTRL1				0x100C8
 #define PMA_RX_CDR_CTRL1_VCO_TEMP_COMP_EN_0	BIT(0)
 #define PMA_RX_CDR_CTRL1_VCO_STEP_CTRL_0	BIT(4)
@@ -198,6 +202,7 @@
 #define MII_CTRL_AN_ENABLE			BIT(12)
 #define MII_CTRL_SS13				BIT(13)
 #define MII_DIG_CTRL1					0x10000
+#define MII_DIG_CTRL1_EN_2_5G_MODE		BIT(2)
 #define MII_DIG_CTRL1_CL37_TMR_OVR_RIDE		BIT(3)
 #define MII_AN_CTRL					0x10002
 #define MII_AN_CTRL_MII_AN_INTR_EN		BIT(0)
@@ -959,6 +964,513 @@ timeout:
 	return -ETIMEDOUT;
 }
 
+static int imx95_xpcs_phy_mplla_configuration_sgmii(struct udevice *dev)
+{
+	ulong begin;
+	u16 val;
+
+	/* 2 Config MPLL for SGMII */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL);
+	val = u16_replace_bits(val, 0x6, PMA_REF_CLK_CTRL_REF_RANGE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL);
+	val &= ~PMA_REF_CLK_CTRL_REF_CLK_DIV2;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL);
+	val |= PMA_REF_CLK_CTRL_REF_MPLLA_DIV2;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val &= ~PMA_MPLLA_CTRL2_MPLLA_DIV8_CLK_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val |= PMA_MPLLA_CTRL2_MPLLA_DIV10_CLK_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val &= ~PMA_MPLLA_CTRL2_MPLLA_DIV16P5_CLK_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val = u16_replace_bits(val, 0, PMA_MPLLA_CTRL2_MPLLA_TX_CLK_DIV_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val |= PMA_MPLLA_CTRL2_MPLLA_DIV_CLK_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val = u16_replace_bits(val, 0x14, PMA_MPLLA_CTRL2_MPLLA_DIV_MULT_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_MPLLA_CTRL1);
+	val &= ~PMA_MPLLA_CTRL1_MPLLA_SSC_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_MPLLA_CTRL1);
+	val &= ~PMA_MPLLA_CTRL1_MPLLA_SSC_CLK_SEL;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_MPLLA_CTRL5);
+	val = u16_replace_bits(val, 0, PMA_MPLLA_CTRL5_MPLLA_SSC_FRQ_CNT_PK_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL5, val);
+
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL4, 0);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_MPLLA_CTRL5);
+	val &= ~PMA_MPLLA_CTRL5_MPLLA_SSC_SPD_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL5, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_MPLLA_CTRL1);
+	val &= ~PMA_MPLLA_CTRL1_MPLLA_FRACN_CTRL_MASK;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL0);
+	val = u16_replace_bits(val, 0x20, PMA_MPLLA_CTRL0_MPLLA_MULTIPLIER_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1);
+	val = u16_replace_bits(val, 0x5, PMA_TX_GENCTRL1_VBOOST_LVL_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1, val);
+
+	val = PMA_MPLLA_CTRL3_MPLLA_BANDWIDTH(0xA035);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL3, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MISC_CTRL0);
+	val = u16_replace_bits(val, 0x11, PMA_MISC_CTRL0_RX_VREF_CTRL_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MISC_CTRL0, val);
+
+	val = PMA_MISC_CTRL2_SUP_MISC(1);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_MISC_CTRL2, val);
+
+	val = PMA_VCO_CAL_REF0_VCO_REF_LD_0(0x2a);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_VCO_CAL_REF0, val);
+
+	val = PMA_VCO_CAL_LD0_VCO_LD_VAL_0(0x540);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_VCO_CAL_LD0, val);
+
+	val = PMA_RX_PPM_CTRL0_RX0_CDR_PPM_MAX(0x12);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_PPM_CTRL0, val);
+
+	/* 3 Configure LANE0 for SGMII */
+	val = PMA_TX_MISC_CTRL0_TX0_MISC(0x0);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_TX_MISC_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_RATE_CTRL);
+	val = u16_replace_bits(val, 0x3, PMA_TX_RATE_CTRL_TX0_RATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_RATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
+	val &= ~PMA_MPLL_CMN_CTRL_MPLLB_SEL_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val = u16_replace_bits(val, 0x1, PMA_TX_GENCTRL2_TX0_WIDTH_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1);
+	val |= PMA_TX_GENCTRL1_VBOOST_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1, val);
+
+	val = PMA_TX_BOOST_CTRL_TX0_IBOOST(0xf);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_BOOST_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x0, PMA_TX_EQ_CTRL0_TX_EQ_PRE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL1);
+	val = u16_replace_bits(val, 0x0, PMA_TX_EQ_CTRL1_TX_EQ_POST_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x28, PMA_TX_EQ_CTRL0_TX_EQ_MAIN_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_RATE_CTRL);
+	val = u16_replace_bits(val, 0x3, PMA_RX_RATE_CTRL_RX0_RATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_RATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0, PMA_RX_EQ_CTRL0_CTLE_POLE_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x12, PMA_RX_EQ_CTRL0_CTLE_BOOST_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL3);
+	val = u16_replace_bits(val, 0x1, PMA_RX_GENCTRL3_LOS_TRSHLD_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL3, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_RX_CDR_CTRL1);
+	val |= PMA_RX_CDR_CTRL1_VCO_STEP_CTRL_0;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_RX_CDR_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_RX_CDR_CTRL1);
+	val |= PMA_RX_CDR_CTRL1_VCO_TEMP_COMP_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_RX_CDR_CTRL1, val);
+
+	val = PMA_RX_MISC_CTRL0_RX0_MISC(0x16);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_MISC_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val = u16_replace_bits(val, 0x1, PMA_RX_GENCTRL2_RX0_WIDTH_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val &= ~PMA_RX_GENCTRL1_RX_DIV16P5_CLK_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_CDR_CTRL);
+	val &= ~PMA_RX_CDR_CTRL_CDR_SSC_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_CDR_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL3);
+	val &= ~PMA_RX_GENCTRL3_LOS_LFPS_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL3, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_GENCTRL4);
+	val |= PMA_RX_GENCTRL4_RX_DFE_BYP_0;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_GENCTRL4, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_ATTN_CTRL);
+	val = u16_replace_bits(val, 0x0, PMA_RX_ATTN_CTRL_RX0_EQ_ATT_LVL_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_ATTN_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x4, PMA_RX_EQ_CTRL0_VGA1_GAIN_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x4, PMA_RX_EQ_CTRL0_VGA2_GAIN_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_DFE_TAP_CTRL0);
+	val = u16_replace_bits(val, 0x0, PMA_DFE_TAP_CTRL0_DFE_TAP1_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_DFE_TAP_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_RX_CDR_CTRL1);
+	val = u16_replace_bits(val, 0x1, PMA_RX_CDR_CTRL1_VCO_FRQBAND_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_RX_CDR_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val |= PMA_RX_GENCTRL1_RX_TERM_ACDC_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_IQ_CTRL0);
+	val = u16_replace_bits(val, 0x0, PMA_RX_IQ_CTRL0_RX0_DELTA_IQ_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_IQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5);
+	val &= ~PMA_RX_EQ_CTRL5_RX_ADPT_SEL_0;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5);
+	val = u16_replace_bits(val, 0x3, PMA_RX_EQ_CTRL5_RX0_ADPT_MODE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5, val);
+
+	/* 4 Configure XPCS for 1G SGMII */
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_CTRL2),
+		   PCS_CTRL2_PCS_TYPE_SEL(0x1));
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
+	val &= ~MII_CTRL_SS13;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
+	val |= MII_CTRL_SS6;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_EQ_CTRL4);
+	val &= ~PMA_RX_EQ_CTRL4_CONT_ADAPT_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_EQ_CTRL4, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x6, PMA_RX_EQ_CTRL0_CTLE_BOOST_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0, val);
+
+	val = PMA_RX_MISC_CTRL0_RX0_MISC(0x6);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_MISC_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5);
+	val = u16_replace_bits(val, 0x0, PMA_RX_EQ_CTRL5_RX0_ADPT_MODE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1);
+	val &= ~PMA_TX_GENCTRL1_TX_CLK_RDY_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1, val);
+
+	/* 4.1 Assert soft reset */
+	val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DIG_CTRL1));
+	val |= PCS_DIG_CTRL1_VR_RST;
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DIG_CTRL1), val);
+
+	/* 4.2 Poll for SRAM initialization done */
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_SRAM);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (!(val & PMA_SRAM_INIT_DN));
+
+	/* Assert SRAM external loading done */
+	xpcs_phy_write(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_0),
+		       GLOBAL_CTRL_EX_0_PHY_SRAM_BYPASS);
+
+	/* 4.3 Poll for vendor-specific soft reset */
+	begin = get_timer(0);
+	do {
+		val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DIG_CTRL1));
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PCS_DIG_CTRL1_VR_RST);
+
+	/* 4.4 Assert TX0 clock is active and stable */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1);
+	val |= PMA_TX_GENCTRL1_TX_CLK_RDY_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0, PMA_TX_EQ_CTRL0_TX_EQ_PRE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x28, PMA_TX_EQ_CTRL0_TX_EQ_MAIN_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL1);
+	val = u16_replace_bits(val, 0x0, PMA_TX_EQ_CTRL1_TX_EQ_POST_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL1, val);
+
+	val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL));
+	val &= ~PCS_DEBUG_CTRL_SUPRESS_LOS_DET;
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL));
+	val &= ~PCS_DEBUG_CTRL_RX_DT_EN_CTL;
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL), val);
+
+	return 0;
+
+timeout:
+	return -ETIMEDOUT;
+}
+
+static int xpcs_phy_common_init_seq_2(struct udevice *dev, bool an)
+{
+	ulong begin;
+	u16 val;
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
+	if (an)
+		val |= MII_CTRL_AN_ENABLE;
+	else
+		val &= ~MII_CTRL_AN_ENABLE;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL));
+	val |= PCS_DEBUG_CTRL_TX_PMBL_CTL;
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL), val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 2, PMA_POWER_STATE_CTRL_TX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
+	val |= PMA_MPLL_CMN_CTRL_MPLL_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
+
+	mdelay(1);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val |= PMA_TX_GENCTRL2_TX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val |= PMA_RX_GENCTRL2_RX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_RX_GENCTRL2_RX_REQ_0);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_TX_GENCTRL2_TX_REQ_0);
+
+	mdelay(1);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val &= ~PMA_TX_GENCTRL2_TX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val &= ~PMA_RX_GENCTRL2_RX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_STS);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_TX_STS_TX_ACK_0);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_STS);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_RX_STS_RX_ACK_0);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 0, PMA_POWER_STATE_CTRL_TX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val &= ~PMA_TX_GENCTRL0_TX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
+	val &= ~PMA_POWER_STATE_CTRL_TX_DISABLE_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
+	val |= PMA_MPLL_CMN_CTRL_MPLL_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val &= ~PMA_RX_GENCTRL1_RX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
+	val &= ~PMA_RX_POWER_STATE_CTRL_RX_DISABLE_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 0, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val |= PMA_TX_GENCTRL0_TX_DT_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0);
+	val |= PMA_RX_GENCTRL0_RX_DT_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val |= PMA_TX_GENCTRL2_TX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val |= PMA_RX_GENCTRL2_RX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_RX_GENCTRL2_RX_REQ_0);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_TX_GENCTRL2_TX_REQ_0);
+
+	mdelay(1);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val &= ~PMA_TX_GENCTRL2_TX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val &= ~PMA_RX_GENCTRL2_RX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_STS);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_TX_STS_TX_ACK_0);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_STS);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_RX_STS_RX_ACK_0);
+
+	return 0;
+
+timeout:
+	return -ETIMEDOUT;
+}
+
+int imx95_xpcs_phy_sgmii_1g_config(struct udevice *dev)
+{
+	int ret;
+
+	xpcs_phy_reg_lock(dev);
+
+	ret = xpcs_phy_common_init_seq_1(dev);
+	if (ret)
+		return ret;
+
+	ret = imx95_xpcs_phy_mplla_configuration_sgmii(dev);
+	if (ret)
+		return ret;
+
+	ret = xpcs_phy_common_init_seq_2(dev, true);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 u32 xpcs_phy_get_id(struct udevice *dev)
 {
 	int ret;

-- 
2.34.1

