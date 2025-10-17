Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0FECCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 12:40:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 857C583829;
	Fri, 17 Oct 2025 14:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eIyimwsF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C10E83655; Fri, 17 Oct 2025 10:20:19 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56526807B1
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 10:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrWMW5nOO6rxvD+0J0T6XbxKmjqfF4xKC6L8dGCiFOWtx7THJM56MRXq6qQlTKF8HaTRZi7JCFaq/hFqhGl2zGVyzZDzaq0BUQoMXZNKFND2L7iar16NsI2rLkOACmj2Y5H4Ar41FPxJIJ3DSmh5CjdgGnfTgTXB3VUK4lpLl+kenTn0Pc9G8WJg3Sq6s+Log6BgP0cXyKf5mxJ/eSZ8587FQQ725WdwJRRIg/+hQuLHnc1Zes4eaGwCORCflZykOzEuwX1KSO8TlYUI0TaYt9GXFhHcvqYRzP51JtxM1+lXYJ14Bm6ZmfCj10EdiORMnOpoaCKZX6jUNVSwiHirpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgbLNcSDE2z+UGelwj8x6dxvjrLHM5CufQ4/oVK+s7g=;
 b=tYQVmPd9P1Ni56OB0JFSH6E0QeAjpwkWBOi4I69Ku//+rALIy6oXt9FSBF7wjYQglbSiW5CRnp1zL1pLPhQqz0FVtgTJQy+yGTFmFBuFVE9IbXutCttOjba0gDy7PuRtvUmCHZXswPvS1yRzufHbv2JKEBuZSgDUkL5mwksqQ9p0zwAOmmiOzxR9xnlL9GWmtUh6wnjsEbX921ahTFoVxbUGrcSHOxbnxe8e8NNYcfCVoJ3IrPOkWY8uvUxRvfcLTvudbar2Oi90zSLjAxqzXSIATrChXsMdG1I62OYDgwET+nH48sPXN3II3CC/7BavYeMAND4d+RTwcravy6LskQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgbLNcSDE2z+UGelwj8x6dxvjrLHM5CufQ4/oVK+s7g=;
 b=eIyimwsFzevbP13dJ0QeybMgnw4da8AoUc3s7WAAJWWxUPhJZnPCCm5hmiPfcTdrmNbhaMLKPEavv/Mgyo72cs+GudbpHCpZ5MKXY5eJRLzooaQdzbxc0NLVARHFqgqu1+47vlzXanyWTacPhoyB7zMP8e1xF2oJTdt4aLrNTlGiPAA7OEgfciM3BroL3Tstehr0BRye7IpcC/GFNF75I2qiWAdmVcMMcARJFsJgUMvAQxUdGwxIH4lMxOrHNhXsCVY6MXIW/jwsOZJIdeOvTVZGqY3tlfJ5ylh4oVywJcouWGi190jqmXCEEKUlk86Q2fZczNQdraYQzYWUmiHSgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9988.eurprd04.prod.outlook.com (2603:10a6:102:38b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 08:20:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 08:20:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/5] firmware: scmi: Support SCMI LMM/CPU protocol for i.MX95
Date: Fri, 17 Oct 2025 17:32:29 +0800
Message-Id: <20251017-scmi-lmm-v1-0-9fd41e7a5ac0@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC0N8mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0Nz3eLk3EzdnNxcXWMDS8PE1NRUCxNLQyWg8oKi1LTMCrBR0bG1tQA
 pzR5LWgAAAA==
X-Change-ID: 20251017-scmi-lmm-3091aeee8491
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>, 
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2P153CA0041.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::10)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9988:EE_
X-MS-Office365-Filtering-Correlation-Id: d69f047a-80cf-4336-e738-08de0d55ff03
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlRETFFvNWxwZFF1UGdFZWJwZ3l5Zm9CTFk5SFNaWkh4WUg3QWowZ2g3OTFP?=
 =?utf-8?B?MTZLWVowUXczM28vd2liTjQwb3I3RUJXMVVxTXFMeXdUNVUyeXJyUHBoeHZr?=
 =?utf-8?B?cTVvbk5QSFdzY2NSVnRYcUlkdG9UdGh1dVA0bFBTL3dLT0RRakpTYm1md01n?=
 =?utf-8?B?QUlLQlo3enFNekpzaGlxcFhRTnAyVkRPdkZOMUJBeGxXQWdsQUoyV0Uvd2VK?=
 =?utf-8?B?YzlVRFV1ajhZT1RjcGxGY2xWMXg0NjFDSVhmeHBncDFPWlpac0QwczlWVTY3?=
 =?utf-8?B?blg5dEdXRUE5SE5aeGdiOGFUaVREWnU2TWhwWmdWcjY4akNER3kva3FhYlFS?=
 =?utf-8?B?dmlDTGVaMmpmbFl0T0prS09MRTdzQlZTa3g3NWVueFEyNVFGMVYyZVljdVF6?=
 =?utf-8?B?U1dHQS81RDZCVjdOZnU4Sml0cE1MaHFaQkxjSVZ6ZUd3dmFMM0xLbnFSNERT?=
 =?utf-8?B?MHNoTEdYR3g0NmpNK0hNWFJESkxqb0pRdWVKR0tsQ1I4N0M0eHo1ODFVSVp1?=
 =?utf-8?B?ZGxoblBKcXFQVEJnc0pFanMxeUU0KzJwU3dYcnlXazB6dG1yNVd2blA2VEFj?=
 =?utf-8?B?Y1ZZQlZZVkN1WjJrRmxWcjgrUlNERmhjUEY2bmJFWVR6K1A3c0ZGYXpzSDVr?=
 =?utf-8?B?UkpBQ3E3YkgwU0laa3pJUk51UmtuMVllWlNXODZRdkR3NFJtM3pHajRUYThr?=
 =?utf-8?B?MGp1ck51SS9PYklDTnR0Zys5cUFrQUZaM1h6enUzU2pGZysrTHRVRmFrMDQx?=
 =?utf-8?B?T2NVM1NyTUs5anBjV3IyeStHV1hiT0RPdVNNZUxmL1c1bElNWHBPYjZWRXRm?=
 =?utf-8?B?cndlWDl0Unk2TDNJR3lRcnFEZ041QVhmdFppbUxBaXEwYnVYYTBnUW1ZeDM0?=
 =?utf-8?B?MkpGN0lwN0Vnb2ord1lWanVBdWw3WkdHVXBrYmMzQ0xiVktWSGVkcFozODhn?=
 =?utf-8?B?bjREZ2l4eEJjNEdWYkg0SDFwU3N1OU1iZUY0c2x6ZmNaZ09kaGVFYjhrRDRW?=
 =?utf-8?B?bGIyTUVOMWJ2N1FhUG9XQlk2RCtrNktjbS84S0UvMXc5cE5sdzZEcGdvaTEw?=
 =?utf-8?B?VlpzWUcxMzFFS0Mxby9XM0pUaFRKOUFaK01JUnVZc2YvYTROQXpzbVFsQ0l3?=
 =?utf-8?B?cVB6d3hPY2JJZ01GTGxZN005OEVxRU85Q285dms0d1FDajdRRU1WcEJqWGoz?=
 =?utf-8?B?akdxb0ZIcmY3d29EblBWTEQ2c1lHam0xS0NXcW1PeWM3clhZbmZQMjdzYmx0?=
 =?utf-8?B?b2sxQ3NEeXZzcnRBbzFvVUFSOU1mQU5adFV0eHpBQ3duL1I0QXJJcVVIcDQx?=
 =?utf-8?B?ZGlOaDFRS1E3dHRMYzBjN0o1VnRsVDltM3IwOHNJajZnYkNNbzlaa2xqMnNj?=
 =?utf-8?B?dHVYRHhkSkFEZWVHSnZsWEU1a21UZ3A3dUp3OTNqeTl3Uk43Q045SXpadzFk?=
 =?utf-8?B?VXA1aE5peW50cENCSUNlR1VrTVRhL0l3VHdndktuUnpsSEJDd09VUGhqZDgz?=
 =?utf-8?B?RHBQeGwvSTQ4bkVJMEsrNitSZW1Hays0OHd4QzdqNjZvbVdyM2p1V1hCK2sy?=
 =?utf-8?B?WVlXekhCdGttYnRvd3FrWUlRWnBTS01PdUFYQ1FscnBlc1BCOStjVDlIaVJj?=
 =?utf-8?B?WXdUd2UzVU5DMzRoeDBBc3RNczFCOGtIQW5aL3VGdVB5UW55ZXlyLyt5bmtu?=
 =?utf-8?B?a0FLc0tXM0NWZ2JrZ3RqZWpPNEJhR2dSWGZrVkVSRTR0SkN5aWJzUmwzNUFW?=
 =?utf-8?B?dURuenpOM0pHbEZGODVLZCtPK2RPOUNCWll4ZkEwSExBMHNBWmF3QkVvTis2?=
 =?utf-8?B?OVpDaFpWNnA3aXQzZG1rWnptRmx0eU1wUFhiY3NVN1JmcEdoeksySGVSVFFB?=
 =?utf-8?B?SEE2cDJhQUhkTnNLRFBQYWZHc25lc0tmcFdaNVdjNytwSWFDOW1lWFYxVXo1?=
 =?utf-8?B?NmEzeENRZFArQUhBTnhRM2xFZ0loUE5TQ21xKzNKQVlhSWU3TW5TdW1qYUp5?=
 =?utf-8?B?UnN4NTUveFNaZ2ZmRCt4S2FwaU5wVzJjbi9zWFhuVUZkcTdlL3RwQ0hzQXNu?=
 =?utf-8?Q?7deLI3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0xPb0F0WFp2QWs0YUVhTVhmN0JEejJabHdhRi85SnBBZndrL1RnN3o0b085?=
 =?utf-8?B?Y1FHKzd4RUdzc1k0V1BDZzVydGxhMnhoSERCbzdLTVBIMGd0T3UrMkdKNzdK?=
 =?utf-8?B?THJxMnc5aFJueVhkRXc5U0Zja09jYkRLbGJOK3h4ZGttOTdYcGNucWpQYmp6?=
 =?utf-8?B?YTVUK1pVRjZYcXdZLzVHWERBUGwweVJmV2EyMU9vY09EenBicDBobHJSdkhZ?=
 =?utf-8?B?bi9mUWc2YVJqVzdqWXdoQXpwY0JBc1FXbE1LZGRjVm5sOUxqd3ZBSHFWNFdU?=
 =?utf-8?B?Tmx2NXVYUUd3VmlUUVpGd3dVTldMTkJNSHl6cy9odE93WlRPYnRvTXFWYW9W?=
 =?utf-8?B?TU10bTQzdTE2V25iazZkN3NLcHNDL29GWGlRV1RZWktrSmhudEs4TFRrK3RM?=
 =?utf-8?B?WHRWRGp3a0UzUmhwSDhWbC8vd2ZhY2hXV1pLaWdENEVXVUVGL1BWaG4rTXYv?=
 =?utf-8?B?K3JqaU9ydis0UFpQUitXdUtZbzhlZjl3N2piMGlyMkZobXY1WXowakxxWGRq?=
 =?utf-8?B?c0hQMWNHRUNvZVpmMlB5cjJLYXVweVNMYjM2U0EzUkY4cG1xRUI3am5LYVkv?=
 =?utf-8?B?QXFneDNkVVE3MG03K2RLMllKVjFKYUkwYzNNeGtvWUVUSTN3K3h1TkpPUG44?=
 =?utf-8?B?YjZtWXFPYVNiajdvMHR5QlcxaFVicXRQazArUnlUTTJOd3FUM2JXVjh4UEdU?=
 =?utf-8?B?Nysvbm9wV3d6U1d2aGxzbURQTEJCc0YxdTRFUW40c1pZbDN1NU5aWHFYREds?=
 =?utf-8?B?ajJSZlhrTUFLYWw3Q0RpbUJuVWdYazc0NTkvUGZVejVkTW4xbXVRTElNQjZV?=
 =?utf-8?B?SGVBVktDMko0VlcxdGRCRGREYUxFajcvV0p1UEhHRStDN21EQ3Z2MDMrY0th?=
 =?utf-8?B?Ym9LaTdJcDkyUWNjQTlNT3NrdWIxejVjdytSMDMwRHFmVXVHOGdCNDQ0ZkZE?=
 =?utf-8?B?NXFlVXFYSjE2eG9QQVNCSzJrTVpGNlJ2NGJjdnQ4WWR0NEljNGtrZmtqVDgz?=
 =?utf-8?B?alB4NTM2cW8zNHYxWVdRUUZZcldCNks3U0hrL2ZLdCtIZ1l1dmVYaTM0ckdj?=
 =?utf-8?B?cTdsRWZLRWhLNHFpbmhSNTZ1dXFta3hyWDFOYkg2eHRLZ2RlcG91S0pjbEl5?=
 =?utf-8?B?TzBrM3c4T3JYYjVBdXpxbmpEcWN0TWlJRTZWUU40bG9YTDRGWGVCVHY5dU1p?=
 =?utf-8?B?M0Z4Vk9mc2FFQm5lUE1VOHN6aHlkRzk0K1NMY1IxVDdpSHNNU0lBY21Xcjhr?=
 =?utf-8?B?L0JGcHJYK1prVUhZcGdQQkl1VXR0dFoxR3czckJybkxsSDE2d1dOSWZWNnBx?=
 =?utf-8?B?ayt2eC9pL3c0cHdaUEw1ZzJudlRBR3Q4LzB0MU5KRXVNZzlNZldPU3dxVFpQ?=
 =?utf-8?B?SkMyWUkzWC9NVmdLYTZVOGlIN3ZwemM3OTFWdC9Ja0xHZ3VaMGZjY1ptY1N5?=
 =?utf-8?B?cjJsdzhJaDRmeTVVa0N3VE1iM01wVksza0l2UEZIVjhld1ljZ0xDMnRJL3VH?=
 =?utf-8?B?VStZL2krNU8vb0dJTGJJNTVXNjNLUzVhUEFYaWhJZzFuUzROUkE5bGJUYk9X?=
 =?utf-8?B?U3NpSUZNaFlQK0dpUGtla1I1OWNMRHljVFM3b2FQb3crRGc2QkhmQ0twUWt2?=
 =?utf-8?B?OWo1Z21TcHNjbXcyaHhXNWJXMGsva0VZd2Q1bTVHbmthclYvaC9Vc0hLYklC?=
 =?utf-8?B?K2s1ZHM5UTVNUitTYkk3K1YyaDh1eXBvVXFKRldHUEdLZ1JQSXB3OVhMaVZQ?=
 =?utf-8?B?ZHBJYVVHWE12VHZYSHFoVkpoeXdWdU8wZXo3NHN4TndwV0xJQm16c3RXTTJU?=
 =?utf-8?B?dzE4S1RYOXZoMWtmRjlnMlFOU0ZVSU1aQWQ3NEVoOWYyb3lYRkh6WGl2YVJV?=
 =?utf-8?B?SjFFcHVkU3Mvcnh5NWxKZVFPR0w4S1hNMVVMOXBUcHpPYXkwRmZkb2dJK3Ay?=
 =?utf-8?B?cGtiRncwUEVyY0RUWk9vQlRyNHc0RjZVYzBWaHV6Q1k1QWZ1Qm5GNzN4T2Rz?=
 =?utf-8?B?T0ZSeGpwZ21XZVRkVHdERSs0T2FxS2NZQXBNN3pXMzBabzBLTi95NmVCZExR?=
 =?utf-8?B?VlRsU1Bxbk9uUU45WWJPN0lyUUlSa1VnS0ZMajhlVFJwaHhrcDVORGdYSDFt?=
 =?utf-8?Q?GFjOsypQmMbEg/1wzez8u77jW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69f047a-80cf-4336-e738-08de0d55ff03
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:20:13.8774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6Zss9YxL9d4hNgUxDEwGPUpj5SMcZjDc3F4MHtUW7L7LwbZ5PNEJey30aJ0amwTGkDqE3ufDFdkWrR4b4j+Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9988
X-Mailman-Approved-At: Fri, 17 Oct 2025 14:40:46 +0200
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

i.MX95 System Manager(SM) implements Logical Machine Management(LMM) and
CPU protocol to manage Logical Machine(LM) and CPUs(eg, M7).

To manage M7 in a separate LM or in same LM as U-Boot/Linux itself. LMM APIs
and CPU APIs are needed.

When M7 is in LM 'lm-m7', and this LM is managable by 'uboot-lm',
U-Boot could use LMM_BOOT, LMM_SHUTDOWN and etc to manage 'lm-m7'.

If in same LM, use CPU_START, CPU_STOP, CPU_RESET_VECTOR_SET and etc to
manage M7.

Both LMM/CPU APIs will be used by remoteproc driver.

The documentation could be found in Linux Kernel:
drivers/firmware/arm_scmi/vendors/imx/imx95.rst

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (5):
      firmware: scmi: Conditionally compile protocol support
      firmware: scmi: Cleanup the SCMI MISC ID
      firmware: scmi: Support probe vendor ID 0x80 and 0x82
      firmware: scmi: Add i.MX95 SCMI LMM protocol driver
      firmware: scmi: Add i.MX95 SCMI CPU Protocol

 drivers/firmware/scmi/Kconfig                  |   8 +
 drivers/firmware/scmi/Makefile                 |   1 +
 drivers/firmware/scmi/scmi_agent-uclass.c      |  40 +++++
 drivers/firmware/scmi/vendors/imx/Kconfig      |  15 ++
 drivers/firmware/scmi/vendors/imx/Makefile     |   8 +
 drivers/firmware/scmi/vendors/imx/imx-sm-cpu.c | 179 +++++++++++++++++++++
 drivers/firmware/scmi/vendors/imx/imx-sm-lmm.c | 213 +++++++++++++++++++++++++
 include/scmi_agent-uclass.h                    |  16 ++
 include/scmi_nxp_protocols.h                   |  73 ++++++++-
 include/scmi_protocols.h                       |   3 +-
 10 files changed, 552 insertions(+), 4 deletions(-)
---
base-commit: bf1d8c1fec863b7da2f0d1ed4bd5526275d70dc2
change-id: 20251017-scmi-lmm-3091aeee8491

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

