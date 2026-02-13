Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05097EDF175
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 15:40:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AC0883AAB;
	Fri, 13 Feb 2026 16:40:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IWjktZDo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CD0183B9D; Fri, 13 Feb 2026 16:40:38 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 808F183015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 16:40:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6wYloi3qSbDLp1a7W6bvPk6hhB4Ww0NU0w3AX+chaNffYrlPhsfhqGf6NFemxbqrQnyMtcXMbBexwbvEY6rqTBYPCGB2bBAJ+L/BxD4lAHZiqtrh/Tvlg+QeUzK+JOgEDdeT0qYELh8ponXajDvI4k1gpoe8Hw5cg08sV3nj2aNfDd5lHlWIdPwussaxtiIp6gT2NR7CmkbU4T9TNjMq/AmVfNjJmxSno279WnGPS0vUQw+LOFIoyJ9aKJSCY0eeIYTugozTf5w8tkUGX1l9JD3hXflcFmAtNitzD9MBNn6ueU326ATmzpZapiFMLG/DeXS3kYBhYmSdRbZh2kmQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4t3VK6JuF4ywB1QOcqO9xeiHLbOFPkGvppISKuXse8=;
 b=bJXyLz7U703NsLFl77bjERdfkaNr/Hqq4IYbUoUxnKFnM8Wl7/eHFhDDhbJBFl5mZob+z47Hfr33ekkaFJc5JjPtpdpNMeG39lQaVa8rPpE+C0jZ4teiNe0UGkX3pzWhNK+AUi21A32u4kkGmeC44LbY2+vA7gctz4eE5fAg2hiUwwFDvnBtTOvgxgDbzXb1JzP2KyayW+LdhggzJFgOlgjHNPO6RALszscT11EaL5+w5Lp3NfjcxZQ+3R1Ex5HXMX0t1SpwnwNK1QoZ7Cx3u0dY/Joyto9FCKcWHVh0TPiq2/njBOB3j/9QvK82mRDLxcDOiPT9HGvGwcw/FcpC9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4t3VK6JuF4ywB1QOcqO9xeiHLbOFPkGvppISKuXse8=;
 b=IWjktZDouq0lyic7qUscyWJzFP6m1ch4OdBzOfCNZ30cU15HAbGK1silhh35tnEHDMFBDIJDMs5h+ElGoCKACwy3JIPHJyaB7UFabPxCATGH1t55ziON8WDhn3/9lDr09dtTMiRg9AlVXoPFhCth+UFcoWlYX6eSNBhPIXuak1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM8PR04MB7812.eurprd04.prod.outlook.com (2603:10a6:20b:245::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 15:40:34 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 15:40:34 +0000
Message-ID: <ab067ad3-652a-4a48-b97a-6943c9a94f2d@cherry.de>
Date: Fri, 13 Feb 2026 16:40:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] rockchip: board: qnap-ts433: Update
 documentation to recent tool versions
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com
Cc: trini@konsulko.com, u-boot@lists.denx.de,
 Daniel Bast <2790401+dbast@users.noreply.github.com>
References: <20260114082822.4007128-1-heiko@sntech.de>
 <20260114082822.4007128-5-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260114082822.4007128-5-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::12) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM8PR04MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 2932f343-adde-48a2-6855-08de6b163a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmF1SitBdnVDc3d3VUtGT3llaVhtaklPMWVHdjhicnl1czdkU1EwQnZoWUF0?=
 =?utf-8?B?RTN0S05GZ3dRbHFaMlJoc25NUXAxb29PY2Y5VHJlUGdpUnhEODdsRElHNTB4?=
 =?utf-8?B?MENZUGxBZGhRQksyQnYzTTVmRlBteTNsRXJsV0wyUlRvZjR5THFvT2hyeXVi?=
 =?utf-8?B?dXBDejFEYmNXcmpYVGg2QUhLZDEyWXU2cUNzWmxzanp0N2dDK1UxYW1ubjlp?=
 =?utf-8?B?Qjh1ZHdZMG9DQzJES0hRZjE3NVlQcDJOUzIxbGUrUnFYN2RWLzhoeHhueXhY?=
 =?utf-8?B?b3B0eEsyT0tIQXFCT1BWU0lmczlIejdzV2xZMmQxalgyemRMaElqdEptdEdo?=
 =?utf-8?B?N0VjQUNCSmhHSmVCZVdnOVRQOHdUZmh1NEFXMXp3MEVuOFpmaTFEbFlQb1VS?=
 =?utf-8?B?NzEvMjR5OG56bkRSV2U1MWNsUU5NQmp5bHN1SWhNN2dzdlkxYytESlhjRDhD?=
 =?utf-8?B?eUV5ZXN1eS9DS0dqTkZXZmlXZ2I4UWN4cDlobTVFOWFqRGd0eEo3WUR6U09X?=
 =?utf-8?B?UUtqaXVzeE9SdGxmS1RMVGRjK3JDaVp0UHQrZ0FUTDVaUUxBSXZsYTExVzlM?=
 =?utf-8?B?U2o3YXNGdTdod3k2V2RSeWtzZEYyVHlWNk4xeGZNSmtOSjVUN094SHB5MDgz?=
 =?utf-8?B?MkJlellJV3J4YnBDSEg0OEVmdWNBeVFJTjA3ZjNBMTZmNldUeXJFTitNd3dv?=
 =?utf-8?B?ZHFQclc2ajFVYWdRekdOT2Raa084VXhkUUU3NE01NWRWdW1JK0VpM2owcDVW?=
 =?utf-8?B?a2VTNnpEVHVQSDZIK0NzVDh3L3A0a2d2KzEyTjMrUWx3V2xPS2pyVEY4dDky?=
 =?utf-8?B?dDZXajc1TkxiV1hJbTYyVTZsYWUrUXNmN2dhZjh6Nk1Icnpmb1AyRVJKWWV4?=
 =?utf-8?B?dFJvbytFOWRHRGV2RE9qRzVKZWdVNmczRVRKQzFCbVdybzhBQkIyZER3K0Ri?=
 =?utf-8?B?eFdjYmpCbHFlQml4SmhqQ1VCL09mRnNtTGRKNGJxaytyMXZaTVRlOWVYYWhH?=
 =?utf-8?B?bktsTXlUSkJqaktLb1dyV0VndkFXVXlTWGxObXVFK3ZMcHNsKzdRSlkrWEJw?=
 =?utf-8?B?TmRSMVdJb0IweDI4dDBEejBpL0dvTy9LQVhRRi9TYm53ZHN1UzgyZ29QQlNz?=
 =?utf-8?B?eFdCdmlTY0oyU1Z6RElWT2h2RW01akUvOGpXS241VUVYUWJiU1p2eU1SeGtm?=
 =?utf-8?B?THlXQWhBK0tPcisrSTVzbmxSaDNMMXFiQkx1YW05Z2dETG1NRmRUd1pZZlJQ?=
 =?utf-8?B?eThhNGV6T25CdEl0L2k0RG9IeFljWFg1NFl3RURJTUkxK0o0VW9iNlV5Qkw5?=
 =?utf-8?B?V1o5VjlISEVkcUV5Q1FvY3o3RzRrNEVwaHE5b2VrYUs3SU14blIrZWxxU2dh?=
 =?utf-8?B?MHJNSit6SDNvSVRKc2ZQTlZtVHphd3BPZndzZE1jSlNaUjdvUk5GeFhxQks5?=
 =?utf-8?B?VG5GcWRMUWsrUDZXK1NNNzJqalh6cTJwUG93RkdWSVZQeXowbk9FWm5CMndD?=
 =?utf-8?B?Z0lUMVp5eVViUGRaLzV6TzYrUVFqVDBMcFdscWlaVVZqdURXZUFnSWtFQy83?=
 =?utf-8?B?TUFzWDJNQW02Zk5ONnpnSlV0VktEWkczSXg4R25salI0RmJVTkJkcTgvMlRn?=
 =?utf-8?B?QWYzUE1DZnJadVNsbS9HU0RsUFplWmlpekYwU1pzQ3crQnV4eEMrdTNPNGNE?=
 =?utf-8?B?c0FOaTFuWDhLWHA0Sld5aSs2YWpZOTdvOVJhZWVmZmRTSHNLbUt2R0FnQTc4?=
 =?utf-8?B?bER5RjJIcXUrelRSaEtRbHBiVitvN1hJZFpxVTJnRXRwUDlnR2VsYWx3UUVW?=
 =?utf-8?B?ZjFaNXNKTXduRkNWL3dqSDlQTnBqWlROUlRiMDVSYWRLUklaZzhEc3lpQlRx?=
 =?utf-8?B?LzJ3eEQ3SG5lNXVzekhCZXRiNmRYVk1mWUNoL0s4bkc0NmxXaVhJWkM4UVJV?=
 =?utf-8?B?K0RDcEJMR3g1eXFNaldNWk55b3ZGZlplY0NQVkNMVjJKSFlqTkNMdmhqdEhX?=
 =?utf-8?B?S2ZXZDR0Y3R1QTk3dHErSEJHa0U0cXZlSE5YY3M1SHlWUE54ME5SY1NGUFYv?=
 =?utf-8?B?Y0tyMUg0YytuWmFiRTcvU3VjelM1UlRCeXdQUkg5aHZ0dnlRZ2Y2cy9mdVho?=
 =?utf-8?Q?iCfo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjR6QWZvV0Jvc3FVRFNtVjVUSUo4ajdLRm9xQTc0TVM2cExQYjRzT1BFUVhT?=
 =?utf-8?B?RHN2OTh6K2lCNCtVYWIxak12NU9yd0NzSnp2UXF0eTQ2czB6V3ArTWpiRVV5?=
 =?utf-8?B?YmVjMzRiSVAxeldVbVVnOHR2aGwreHRQaHRqa3h6SGhuaWMvdUNrMU9QcUg1?=
 =?utf-8?B?K2xCc01vZVhTdWZiOVEwZEpnNEtWbDNuNk1HSW5hbDhaaWNWVmdkcjVUQUg3?=
 =?utf-8?B?S2tnaWNTNmhSWlBZUm9xSjFwNjFvUGg4MlFOM2hWZU9JWWF1VXpPaTlwbVJp?=
 =?utf-8?B?R0FWcFBZaXJsOHVtMDVlVEwvTUpsOUo4UGc1TCtYZGVxM2N6QUNTcXFWK1hX?=
 =?utf-8?B?VUptdU53bVBhbVJoayt1S1duQWpJdWE0dm5HbHYvd0xiYmF1TDIrNGs3RUlm?=
 =?utf-8?B?ZjJnUXVnTjRvMVltTjVoam1BbWtuOCt4cklLWk5XbE9URDVhd3N6cThMSkMv?=
 =?utf-8?B?T21DeXp1RHI1S016UElhajFGR2puS0ZDN01TY0MzMlg4NUtPMUp2L3c1UlV2?=
 =?utf-8?B?NjVhMmdZVnhhdDhQbTEvSHFJRm1ONFpZVzM5anVkNGhkWVF1NXF1b3gxVjlZ?=
 =?utf-8?B?bXg5eitiNWg5Y1d3SEVGMXA2YzlTTTRva1hDdnRKR21BRDQ1WDZkYVZJNWN2?=
 =?utf-8?B?ZTdncmV4aXdDZG12NUdGN00xbUQ2b2NsNWxZQ2YwRXRyUmE3RnRpdDFIWnlU?=
 =?utf-8?B?RTFzNEt6US93UUNZSjdudy9LSytld2lHdEhuZzhFYmRPd3Z0UTQyNXl2VXc3?=
 =?utf-8?B?aGdVaVJNcU14c1dldVEvSHNSVEQzRXE0TTRZd1JxNnJMSWlqb0hvRyttUGlQ?=
 =?utf-8?B?QWlBdE5Ba2NtdGxEbmwwT0Z5WmxkeTU1bGVSa0Z3Q0IxY0RveHpJUVZHeW00?=
 =?utf-8?B?QnE5OGx6N2NOallBcTVZUHQxSUhsc2xYQ1V5OEFRbWcyMCtlOVA0UjhUU3J5?=
 =?utf-8?B?YUVWODhRb1ZOSVBpN0E3aTUwT3BZVE8wVUtiSDk2Z1FvdDE1Z2Y0OVRCemZM?=
 =?utf-8?B?dWR1WEEvcjhTeHhkWlM4TTBmL1NPUnl2emZjbzVPNm9aWitiUzR3R2RPV1JZ?=
 =?utf-8?B?bG5md3J3TzNaYmtTM204WmdLK0tKRm51bVE5dHVqTjJEUWNpWTFzM09lUHY3?=
 =?utf-8?B?ZUlWQXBZK25zNmxaQnFLT0RvSDhYRUYyZFBndFREUU9FN2N5aUQyY1d3WnM3?=
 =?utf-8?B?VDcwOG1HZGlJdUpYSzdSZGx6L2tPY0Z3eWx4QUdtNkFZbXZTMXJWNWFaaWNM?=
 =?utf-8?B?akhwWG8wdHZEQldpYmNkejBGdmxHRzYzTENMVmhWbFZDM05CQmVVdUp6aGEw?=
 =?utf-8?B?L3NSd3owYXU5LzhpejJ2bjcrNjRnL0xQek1wSFZKZytMZGhGYWc2ZEZTcVY2?=
 =?utf-8?B?YnI4U0FaVFBoMDJ5cE4wQU44VmM2NDdmZGMyb2taamM2QldTYUJNb2s1Q3Mr?=
 =?utf-8?B?UHg5MmVCenpQU1JGQUVqa0dQT1V5a2xKZWh2NEExazJjZjVURnIrclkvb0pu?=
 =?utf-8?B?R1BiV1Q3cC80Vm1Od2hIQTZNdU5UTU1KMUlac1ZsM2dsSWNlSTFnS0hGSnQz?=
 =?utf-8?B?TksrUGlCUUhVV3FKbStqNmVQNWd0N1JtdWVyZ2Z1ZnlHaUtOQ3pVRHJrSGRB?=
 =?utf-8?B?SHp3dDBBbXZ3RnVvNHl3UnlKc0tsUU10L1dHYWQxN1l4RHFJVnFNeWx1WkhD?=
 =?utf-8?B?amZqOTVvOFVoM3lSbnNrZDRiTmMrOWdoVVAzeXlyTVh3QlRxaTA1WGhLWXhF?=
 =?utf-8?B?Rk1iUm4wK1dwTC8rUXJONmtEWFVJa0xxLzVTV0RNNWdzOWhQUlR3Nk1IRDFh?=
 =?utf-8?B?bSt2V2RMSUgrRWluMDVmVUxaaXh4K0IzQnJZZ3hNTGIreWNQK24vaWd0NkRa?=
 =?utf-8?B?MlhZMzhtd1R5QThFSUZqWkZLMXNDTmFyVzNnOHVHVk0zSThhRzBmVkx3bmpn?=
 =?utf-8?B?bTIyL3RUUnZ3SkZkTkVrYlJoNEdUQlJCQlpZaDJpUnQzWFRDNmYyUTNJZGdi?=
 =?utf-8?B?bjEwcFZCYUNOTTUyTk53SUxrZFVwUkpaWkdBamtDWE5kczZXMSsyOU1SNng4?=
 =?utf-8?B?aXczWDdnZHQ0RXF1T2xFN3hsRjBjWW5xUnd0V2hVOVlFdEIrYk9KdHdTNE1k?=
 =?utf-8?B?S3FKY2t2U2src3BzV0RvN1NML01xSDVucW9YNmYzOVA2dUw2NFEwb1V2amtW?=
 =?utf-8?B?elJiNWtlbWprZU5RaTVwQzNUaWlXb1hybElRL21Od2tSMGMvUmF6Y1RIMkVo?=
 =?utf-8?B?Z3BFN01EejZqRDVoV3RsSjVGaTljaTk5bFlPRGVpSldhc3liRFZ2UDV1Qml4?=
 =?utf-8?B?bHRCRUVNU0QrYU10bmpDd3JlQk1tMVNLMElURzlDSXZtTVZRQm1TNXJGVUUz?=
 =?utf-8?Q?4VJlrQj1QSajKwPMQGSxTvHPiHAIY79lCctUy?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2932f343-adde-48a2-6855-08de6b163a61
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 15:40:34.7782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbkfK/IiJs2/EqdA+ycV9s+L/HUwp8lHmFwagSJFFWbuKV76qBfsehZI5RLxdFWywqu4sP+sCCNpSE1ET+vGUXyE9NUwDztnwR4vsPw9s9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7812
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

Hi Heiko,

On 1/14/26 9:28 AM, Heiko Stuebner wrote:
> ddr_tool was migrated from a binary to a python implementation ddr_tool.py
> The ddr-init binaries were also upgraded to new versions.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
