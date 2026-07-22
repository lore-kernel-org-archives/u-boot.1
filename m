Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B59C4452B
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 02:51:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43C4580D7C;
	Wed, 22 Jul 2026 02:51:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l-uItCHNn5oW; Wed, 22 Jul 2026 02:51:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8E42A80D5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784688690;
	bh=HBp7Xy3lZnCG9zf+KaArxGbb5hRaF54nPHh9vcIfVuI=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=moQDFm6gy4/euticsgZOlKSh4WFiKR92g7cgDzcFutewnHUiH085Sgc6Q2L8r5ySw
	 uVB0SAyz4segixRyw27picD7NIEAejnxeRIxONKp+9dH5fBN/C0vrSWNJZuAhhndFg
	 9D6VMz87NH0rUDW6UeS+Hf29xy9mwJ1s7GNlC3iKbgge3w9rkgs+nkTfFGH3ZhMEGk
	 zOPmu4Jc87IB27e9cDwiKjGE0qauEyOcWGaHYLynIgyBXO2kaejyK8lTMfITe8TetH
	 nPzVagho7k2rGqyPflu7YKcjOUxMpDj/TXWmvlpDB949bKE34T/DWG5X1jma10LIm5
	 LnkUcNk+++fQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E42A80D5C;
	Wed, 22 Jul 2026 02:51:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 89ED5109C
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 02:51:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B98380D5C
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 02:51:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p4e0V5Wh53tx for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 02:51:29 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=dinesh.maniyam@altera.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8E4DD80D5B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8E4DD80D5B
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E4DD80D5B
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 02:51:27 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 543B7846A4; Wed, 22 Jul 2026 04:51:26 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44471803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 04:51:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YS9xWcNRCyNPdjx7PGoF1D8Uof5Z31GWSFVqvEhoRBnS3RwwzEEmus1heU3IVm+ix7l81EH94iR7U03Z9jYvoEbXL1WWaAYMO1Lx83zFvYGhrjPhUoFGMQumzuUezoeOScnSzygU8N8ete0Z0m48ln6JZn6OppFBUAQ6p31R/lmpbNWAvT4rW5VUikdW3k8pzzZh0NFdJO2HbupxX8Z700flhEDduWkC2WvMrzoVLabeG2u1ONOcSBfju99cJUyNB8HP+UGxexL7afWz9uO7gsVZcIXArownDHJMNo2/InJJVM1fTVcFd7crctlrjyIHBsb+V4K90H7/gPc2ynhIyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBp7Xy3lZnCG9zf+KaArxGbb5hRaF54nPHh9vcIfVuI=;
 b=b/gNpjYuvuzKtuIa6Nn4bWlD1JaSg5hSb3Oqov7zUGfrDhVaY+0sAkAefXl+qJCGXxV8gUxWxg1MpGPrYn16KG7mtXQ9Zey0B0sEXdTrlFaY991ug1FPTOEPqv2jL7m/kVTKCSTcPWg+oBS2HAotmmUhO4PDou4qXk67ByCxwCgmsp2vOHCd13koaXT0BjRM+0J6fGKI4h82PFf/rkEm1CJ5LnCgt1EI5Grmt9rvExAqvt3yz9b8z+ccDgIrgoX33OWaKvUhHtGoCKb20UwjmJdP4jSa1R9OwQijDnQQZkzTbVXkNpulMfFB7YWY917iS2uKIJYyxrjPtg0MUVcTUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by CH2PR03MB5253.namprd03.prod.outlook.com (2603:10b6:610:97::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Wed, 22 Jul
 2026 02:51:19 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 02:51:19 +0000
Message-ID: <a995875e-e8a5-44e8-8c5e-feed84e63b5b@altera.com>
Date: Wed, 22 Jul 2026 10:51:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] i3c: dw: make resets optional in probe
To: Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.denx.de,
 michal.simek@amd.com
Cc: git@amd.com, padmarao.begari@amd.com, Tom Rini <trini@konsulko.com>
References: <20260709091357.1860417-1-pranav.vinaytilak@amd.com>
 <20260709091357.1860417-2-pranav.vinaytilak@amd.com>
Content-Language: en-US
In-Reply-To: <20260709091357.1860417-2-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR03CA0008.apcprd03.prod.outlook.com
 (2603:1096:4:297::14) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|CH2PR03MB5253:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbe4fb8-5984-4af5-1675-08dee79c1b5f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|55112099003|22082099003|18002099003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Je2huKomSp2/i+gLFPndv9m2VoMBD+CNdQZo4Zg9o5mHk12TX8A+0iaJi2fmhFMseoBkgHJizkuIRttZ4vPIv/t6W+4fT+WoNDdA+J+jd12LX4aHDe8GrY2iGXYkewNt6SiEBreZZ3IUkgyJ48UUGWbY4wSuDD5WgrFG5rqikmuLykFqQsoajDrTDumRFM61NKEy8JiMQpguMostbvUEd0mZ0/rFsDAYKM/s0YDiB3iVSK6alw+9zg65WB6g4WET8qCdEsCoUOgxpInB7rMiSwiuFBRMJLTUAk4tq5rCsklOOJDlnSCRnOxZZHJQUyflc0+6w8AUypZkmwNHdICAgH2jhG8HobNXYIiyOcOKESqAgvmhUZLEtIuQ71J55FVVevJDXTVsnHQRmdlu4ntJxjurm9JHtdd93MBHm6y24uWQDrqEyPpn8G/OIW2hm7PFjyDSb5jAuaBdhZsrMmQgfNFh+rqoEXDydyUU+jjeNHjk+R/t2px/FZBlyYEOEG9Q8lh/lnZZw6JTprFLS3pscLOqHAABdXNo+ou4BQ80tBGf8lApbqnIX2mfqoOBdch4Vux6qwgo3ntCKu+5oTOsCJc4TrpRrwxN91CLT/YPbZfKfFpp8GfX2+XJrtcP8mPHw7HoniMK5QFKu948+3Q8fXUz4bKku3UX+WczY4zOQ1c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(55112099003)(22082099003)(18002099003)(4143699003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWx6SkFDTExQZGxzL2pJMVNac2lOeExsanNBeG5va0Zjd2ZMeFlLMkRqNWdR?=
 =?utf-8?B?ZFlsTTFLTkRQYmdvUUxpdGtyQ29xUjZaSCs1djZlcllxcEdKTjh5TitLNkQ1?=
 =?utf-8?B?ajlwbFgzSDZ6USs5dHZudEQxT3lWZWNBY0JGc1lUY3AxMmxhYzRjRDA2d3BT?=
 =?utf-8?B?ZDFNYlU1b1VyYk5NcjBOTW9jMHZRd3BDZW1uUkNybHkxL29NK1hTL3BScVJW?=
 =?utf-8?B?c01ZR0JUNmNGUjl4angrREZpRUlqalhTK01iMURTNWM5eEdiOW1kWVZ5NHZh?=
 =?utf-8?B?YlBwaldla2ZVQ0hQSVFVeEcrd1Ryd2x4U002OUZvZEo3NWVDUVo1dnJObFdo?=
 =?utf-8?B?T0ErVHY3N2t1dkQ2dUZoOXo0dkR4a3Y2VXJzanpOeUNQYVo4T3dpZEkwc0Ir?=
 =?utf-8?B?cEordTh2Zngzc2l0VzZCR1N1ZHJidFNVRkZlSDVsU2dNZDhCWlhrZkgxSlpt?=
 =?utf-8?B?UENhYXlCd3AvWE4wd2ZmMlNWMGhFbnFpQkNHZUNGeUQyc1NHSnQydllQNjAx?=
 =?utf-8?B?WFgwMmxNNUhKTFNaRkRwYldpOUlSOGo4QjI0eVZleTY1U3AveDFrNXB5MXJD?=
 =?utf-8?B?TVFIelRBakNTUVRNd3h1UnJ0VVExcEpoK3lMOUJpRXd4UVhneWM1MGxZZmRY?=
 =?utf-8?B?VmV1Ykl3RXFWZ0RwWTdQSDRqTFhwb1l4OHJTZFRUYzBiMm5jcGZZOTB5Ykx5?=
 =?utf-8?B?RWxRRjFRNUx2WjRCaUtGVTFqWGg5UHZlZ1JuaTI4TUliUTF6NmlUOGlHaEJt?=
 =?utf-8?B?eTBaQmM4YktQQ3kwVWJjek0yVXhXRzFxNk9qSDZrSVpMV2hkYVBSZ21aVEZS?=
 =?utf-8?B?Q1Z1elMyOTJPVDhTMERJK1YxSFBwUXQxcksyTnpqVW91RmNRSXM1Wjlzb1Q0?=
 =?utf-8?B?QkMyREw5WGlQbjZUcS9ZTjhIajQ3RC96MUpydm1xL0NQb2hzdHJvTmFRZDRo?=
 =?utf-8?B?N0ErV3U4ZzdZVnhLN3liTVVib25mSUQ5ZWZtNW9qZW9VWk9MR1VxLzdFcWM0?=
 =?utf-8?B?L3ZhVE9VRkY4TWtRL3JQMDRsUHVKL292K3F1ZVhrVElQVUJPQlJMcWc0UnZP?=
 =?utf-8?B?UzhvRTNUMTZWZm9zL1BwZ1F3TS9OWEZkQkdRbXlzK3BQUDhaNnpRanJsb2ox?=
 =?utf-8?B?czNyVzRINE9Za2J6YmpUaEVQbStlN1F4ZElGMVI3bWtJZ083VjIyTndGV1V3?=
 =?utf-8?B?dmpoSkVJOXRrMUF5R3pKVm1Da3MwUnNndklSZUtCKzNKZCtEckI2cHRVMEFM?=
 =?utf-8?B?Ty82cGEyR1lMYmNuZ2J0YlEyMG8zSG1hYWNDS0p3dGZnWlp6V3VSdHBKTkpi?=
 =?utf-8?B?dFVqOWVVcU0vRXlUd0xPQk9KR01YVUgzazI4a3B5SEZxSHBpSktPaFZoT0F2?=
 =?utf-8?B?RGw4VU9lb2R0clhlSldZVVo0V3BGVE1QdGVLK0tWbFBmbFVlTlRzVUY3OHZC?=
 =?utf-8?B?dHhaODBCaVFMWkh3SkU2eThXMWVodVc2UEFyNWlRNWx6MnRPNExFYWxjVTVr?=
 =?utf-8?B?azIrRUZ2RXdUdG12VWdCRTdTTEVYdUgrVklTOFVocFlXMHFHSGhoTTlNMjRM?=
 =?utf-8?B?RHpwQjJqUGNKTkZtVHNGQysxc0hKRlE1WFdpM3Fscjl1QjhOeVRiT1JMdlo1?=
 =?utf-8?B?RGdvdWZoMkc4TldFaENRdUc4Zi9HR1l5cENjQnNoMWlaa0UvOFVvZVk3OEpn?=
 =?utf-8?B?L1pqQm40L2k0NUI5aFJkNS9JUTNzNytadjlQMkJzejVJVXBjeGRXMHVKbjJD?=
 =?utf-8?B?eGJSUlVZVzVubmFhZFBmd1dtcFdpeGpOL0dua3JKTDViRU9XYUFKZnZvWDB5?=
 =?utf-8?B?Vmhrb1dWZVI4VDg5VEwwdlpPYUZEQ3U5VjExdHZuendCRnZ2MjZWdzQxT0d6?=
 =?utf-8?B?N3hIT2lVZno2NHIycStkSTRtQkdWM0NBQ2Fic0VLQ0ZoZlFIYStlZjZ4UlFx?=
 =?utf-8?B?MnJpd21CV1BESlpmMGJlNGVNY1hEYzEvUmtnQVIzQzZWbFIwY0JDSFc5QVBq?=
 =?utf-8?B?NFNaVldXUkRtVGlra2c5d3U1dm9nY3JmM0hTM3REL3Q0aHhjOEhGSk5Ub1VR?=
 =?utf-8?B?VHZKemY3ZDZvVUpWbWJBdTZEU1FVTExCZzQveFFJVEtyb1FCOWNib3ZjNnZh?=
 =?utf-8?B?Z2JsQjNRZitsWHRRNVZZZWtmWHRKRUY1Q21zUFUxYkJlSUg2eCsxKzM3ck1B?=
 =?utf-8?B?MkRwbUlGWjhsNWNxYTdDRU9QaWVEb1ZhL1p0MXBhZGpDT244SFNsMzlRVHpl?=
 =?utf-8?B?MlluNjVQc21Tak1JRVgwWDJqdXA1MEpaTTZaS1F6UnBFbnRkU1FmSHlKc3hh?=
 =?utf-8?B?UnFNWjY5MXBEMEtuTnh5eG96L2FOcWhSSFVYY01maUJuTkkrZ2Q2UE40V0Nh?=
 =?utf-8?Q?bp+GnmJoxJNOAN34=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbe4fb8-5984-4af5-1675-08dee79c1b5f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 02:51:19.6234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eb/u1vokGXihidsnlPUYds9gwtLK69GC56vsFAi4Xix6BCxwn/d/AM8NeyAiKpq3e+VKENxYebmidWs10jebyY8lxai1o6s7wc0j48Nhi5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5253
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBp7Xy3lZnCG9zf+KaArxGbb5hRaF54nPHh9vcIfVuI=;
 b=qnCs43Dc3V/yxa8DnguOSE7IaBOZwYe0zSQNHNn3rED+hXgmg53c0NtwrNjrdHsKndre7TyYrl3LCJzlPHL2v/EX4Xhibry7CO/teYS9GfJpcCvzNhMsrcH6yPXKlpgId6Ai3ZBbzhY0uNuVgTRaIlfHQXW7O3DBJnMisleMN2anrInPfJhQTXaHCDygv02UqYYCaH33jv81ZkEAPYH0CKNRkuMMiBkGHk0AaTcCIOOef/zqVFJWQC8eFHwRic+/KvoN3qoLGouCWtVktP9sDShVD3u4sCQ+Je0kVieuYilBS8AyfD9G08QAJIUf+zoBH6oI4Bwii9kjAVJbNNpzmg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=qnCs43Dc
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dinesh.maniyam@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="qnCs43Dc"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
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
From: "Maniyam, Dinesh via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Thilak,

On 9/7/2026 5:12 pm, Pranav Tilak wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
> 
> Treat -ENOENT and -ENOTSUPP from reset_get_bulk() as non-fatal to
> support platforms where no resets are defined in the DTS. The resets
> property is not yet documented in the DT binding.
> 
> Fixes: 1009c96f1590 ("drivers: i3c: Add driver for MIPI DWI3C")
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
> ---
>  drivers/i3c/master/dw-i3c-master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index 0c4af7e528a..c6ce54a1d3b 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -972,7 +972,7 @@ static int dw_i3c_probe(struct udevice *dev)
>         }
> 
>         ret = reset_get_bulk(dev, &master->resets);
> -       if (ret) {
> +       if (ret && ret != -ENOTSUPP && ret != -ENOENT) {
>                 dev_err(dev, "Can't get reset: %d\n", ret);
>                 return ret;
>         }
> --
> 2.34.1
> 

Reviewed-by: Dinesh Maniyam dinesh.maniyam@altera.com
