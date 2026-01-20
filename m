Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9832ACA5FD1
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 18:15:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC0D2839E2;
	Tue, 20 Jan 2026 19:15:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="idv+lX2p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6558839E8; Tue, 20 Jan 2026 19:15:17 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9D3382A9E
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 19:15:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GV3DSVVel+7mvIU2k8lB3Xwqb0MW5UsBPH3VKeaYdU4wo8h6TRF5qc/KEVbBKle+T5CqWvefFJO5Dw8e3hIDjloyOtgBRUmjaFD40gB6mxf4aaIdjrcqa6NWu5r4qvp5o4QzbXOsYtxRyiWZcQeh2HcwGHshYsYFSlSTJmOeXACTt4XBDso4BjnfQGjWEVOA688J7W2DSGMssqB6MStEwaihpo5TC1Ojh+5SeqOfdxzKCJBnHMs9RRcHuaq3XBqov2ujRsjFpF4en0j8jsc/WB6kqdqsgKd0uZQedLhgNRH3fLAdJuzAEidMVWdLd0+Xm82qV+oe1idN3Tfcobd/RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3SgY9xeK40txX94un/02mVKQmMbvutaKXarHr9Ymo0=;
 b=MC4nqwiNr89XzChy0gJgGjcWc/bD+b5GPghyychyj+iLYHHNruJk6v+7DAqFmGKXMYuk9ajypy3hSrnyNA9MoAyi55GPhBY9BdETM2E3U67wC++XZiQ20DdD6OVBtF3ekse1RwKpVOzS+T0YF5pF88lkXNF0R5nCk5hzYfGyXDMoxUoWqSE/XrgELa5clcKn7FBLQv/ftkx0GbW4RARuXxVEcBDGcS6jeB7KXrVMpjo/14elOuhkTeAgCwCBXlSCuMVwNO3Wmvv4SJY9EiCE4jAkZWwiOmx32F7rb4Mar5ylSK2azjYPrRV376Qk3PM97uZQ2GRdO4yBd1wCblfkAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3SgY9xeK40txX94un/02mVKQmMbvutaKXarHr9Ymo0=;
 b=idv+lX2pBZ/BsZCIgF8BhxwI5J0qUh1ayODr+fdrvR+XWO5PYx1qV50vcpxbJPnq4VW5c3NzPAjQBWay2NzE8eF3uPYqTNq5BIpcdP5nRJlPtaL6VN816C9SBBISaactg2f91NXr2JbYXFaMJjG3HijNGwIPjs2OK5kVic1BE8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM8PR04MB7938.eurprd04.prod.outlook.com (2603:10a6:20b:24e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Tue, 20 Jan
 2026 18:15:14 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 18:15:13 +0000
Message-ID: <dba2ab4e-e31a-4726-945f-79022c907a74@cherry.de>
Date: Tue, 20 Jan 2026 19:15:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] binman: elf: Check for ELF_TOOLS availability in
 is_valid
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Dmitrii Sharshakov <d3dx12.xx@gmail.com>,
 Andrew Soknacki <asoknacki@gmail.com>
References: <20260109-pyelftools-warning-v2-1-e27784f14c56@gmail.com>
 <20260120154750.420179-1-trini@konsulko.com>
 <80e83cf4-f559-4505-b12c-7696c11e18cf@cherry.de>
 <20260120175504.GO3416603@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260120175504.GO3416603@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::11) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM8PR04MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 992935ce-3b30-43a1-8d51-08de584fdb3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDhOZUlKeEc2UU1xbUF5enJXSHg1L2Nya3d3b215TjE2T0kxc00zais5ZFEx?=
 =?utf-8?B?N0lLRWJ1cDBLN0tmckNiMUhFS3lqWWd0VFlVSFBhaTdDU0xuK2Y1SzFFWDQr?=
 =?utf-8?B?NUFGS0pBSXZuRzhzQ09UUkowL1labjY0UDhuQUFmZTNOMEoyaS9leGFNbzdB?=
 =?utf-8?B?eXRBZG9hanZZbWxGSnZiMmxQZkxoT1o1Tm12eDJsTEZ2OXRnMzEveEkyYlQr?=
 =?utf-8?B?TjZsQ3N4cmhSRnNaYjlWdzZoaERrWkdxTTdySVVneWRLTHlJL3cyNXljMUtj?=
 =?utf-8?B?UXlXbWorRmVPWitod2JaaW1rVXZCeGZqWW5rSHR3ajhuczA3TFRNM0NkZktV?=
 =?utf-8?B?M3BTaW9VUVhEVmxqRDY2ZTJtc1J0L0taWjNDOG4vMkZKbmVRY3M5M0dyOGI4?=
 =?utf-8?B?NTl2MU1zbTRwMC9SRC9IeFI5NUdzMkg5aDZodExvY2Nock0zT21IMGRsYSt4?=
 =?utf-8?B?SThKNWRwU0xiOXc0eFpsQk13MmRPU2F6OEkwK21PQzhJd1hPNFQwQUc0SlRW?=
 =?utf-8?B?WU0xOTBnOXVodUh2Q0drRFcyNHpLYXc5eDA2c3M2YlFWL1ZETnpPd2xXVmhY?=
 =?utf-8?B?M2VDS2pUYk4rRXJMc2NtNU56cHJaTlJCMnlZdDVKb1IrZE9NejZZSm5FVEVM?=
 =?utf-8?B?VUdsUCtyclUxQ0xGY2JqM2pLSWE3UXZhbzIya0JEZS9aMStPZ2ZjK2daWkE1?=
 =?utf-8?B?WHMzUWxHYWdHSXBiKzEvWWIwQ293akJyV0xjS1JhdzA0YjNGdUNNbVdOSFRa?=
 =?utf-8?B?bXdROFN3VityMXo0VE40dklleDlpaXVCeGpKUXRSWldEWkhReUo4RmU0ZFZH?=
 =?utf-8?B?VzFqaUVZWWFXbWp4SmlQSW5ra0o0djNNQlR2QVdmSGFTeWsyeU5MV3d4NHBm?=
 =?utf-8?B?U0RXaUJ2b0RlMzVwVTJUR0Fhd3FZU24zb2orSldPa2tVY2xQVEphSjJUMHBn?=
 =?utf-8?B?eDdlL05CdzRlNFE2dS9CalVQRXh6YW91Rzk3azRIbW5yT0dQY0V5Ti9BcjRh?=
 =?utf-8?B?NHZ2cXZNc3l2SXhZbjIwZ1JSUnZPOGFXMDdMVDhUYTlYQmpNU3pvQXdhRDNi?=
 =?utf-8?B?dVRFV3o4RTQ0WG51d0VoLytjY1lBZ2xXSkF4dUVXZS8wdFIzS0Frd0hZUDRS?=
 =?utf-8?B?cnE1RDhNbS9RT3UyMCtHckw0dFVvaC9XZURhVVArS1E5YXQwMjcyaUFLSjJ5?=
 =?utf-8?B?cjZ1bDIxYm9Zdkdmb21mMHhUbVdpcFY1MHJrUVNzV0JEWmRTNFU2Q1d6TW1H?=
 =?utf-8?B?NmYwd04vSzlhRG9UZmdJanF3TXJ4c0JLbndQTVFiMFlIaWt1TE1wNWtvZDJM?=
 =?utf-8?B?M0pNeHg1UzZsM2d5RklBTGhOTkMvK0NnaGF1VDlKdDJLQ2ZTWXJBSmFMQkgw?=
 =?utf-8?B?NWZEdHNnbjc3TUZwZHViaVZrdzR2QlhLOUdHOTlGNWVxSTRnTXRGamtudVJE?=
 =?utf-8?B?MWhHWTFCdkU2NzQ5THlReUxQckJKcHkySXJSdy8zcDBvYXIwOGF6TC9ROUpx?=
 =?utf-8?B?TDRzSE9KVVFSeEM5OWVaUmhKekNGdFE5UjJadFo4LysyOFVwYnlDSlpNTVEr?=
 =?utf-8?B?bU1tbHRYZHFJamU2bjE2MGN4SnMzNjVzcHFaZm1hR0FTbStTNSt5OFBXTmcr?=
 =?utf-8?B?TmM0c3pWK2dvaTNqN2V2aC9xdDhvaDBwamhuUWRESEQyVjY2b1o4UUUxRlNs?=
 =?utf-8?B?YlpiaktyMmt3QkxERThEbXIvb1pJS3Q4RytzMVE4MUpFRGs4SkhBWnBUNTJW?=
 =?utf-8?B?eUFDQlVOU3lXeFl4UEJXMkRrU1hVU0t2UHdlUnVuVGNvVnBrU1lYRVJZT2ZU?=
 =?utf-8?B?eGNvaUFwdVhVMXdCMnA3bHlZTGRLaFI0OHI5TWFmSXVHQWhSUlpWb0JCUWZw?=
 =?utf-8?B?NjA5WnVOSHRBS3Y1SGUveUQra3luYkNhcE9ZK1VZaXAySzltRmJZNXJONnBP?=
 =?utf-8?B?bTlpNHE4TytPS1BqTU1XektXVkN4c2ZhTUdwWmpIaGJFTlRlZzNvT0hzTUNI?=
 =?utf-8?B?UFlWcE5LVVNaelF1K1B0WTdKc3NUckF0a3Y2MW5hMSs0dlBOak81VlF4V1hV?=
 =?utf-8?B?N0NzUVFQQU9HNVMreVh6ekhXdXhQL0s2Z2QwaGRZenMweFI5UnNkSGh6aDdh?=
 =?utf-8?Q?H824=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0Y4NGd5WHJoNE1hTDFZck1sdW1MNm82NEJUdE8vbEx3ZE1jTHNxTjJTY2VF?=
 =?utf-8?B?QXVDTkZRRHdIdHNkUUE2bnB3WU1EUURaS2djdDlFVUJweHEwUkYvYURxNUpG?=
 =?utf-8?B?YXEwWEVYWTVlUmFYdWVmRUtKY0hFdkVEeEo5WlNUV3F1SUZRRmtjYnFGSzVa?=
 =?utf-8?B?REdqcTlNcWo4NFBmVm9SWU5zdlozb1BFR0RYdWxaRkczM0VRS0dxc2lTamJO?=
 =?utf-8?B?Q1NRSEtkNEpINmk3L1pGSGFSd0V1SFVGZEdBdk5KVkg3SDlxMi9SUnlQZ2lw?=
 =?utf-8?B?QWNVczVwb1pVY2FsbFI4ZXUxMVRHNnFnWitOK1FXWEUzaVRCTm1mbEJ2VFNN?=
 =?utf-8?B?TVhMemY2Vm5sMkpLUCtFU2pPWERzN21JWXN3VkNuekVwWlVvbTBBOGZodlB4?=
 =?utf-8?B?b3loTUltVHFQK1BPQW4rWDg3OGtEcGd5ZmFPQ1RRUVZObVhRdmtOV2RXSDBj?=
 =?utf-8?B?SWE1UWo3M2dtU1c4NE1jUHNHZGs5NW1UWGZmbEZUa2xST0hxUTNPeXV1Nis4?=
 =?utf-8?B?SkpDeFoxUCtmTHJPL1ZDMldnKzdqUXg2aEkyTmhweTl0bTNvdk4xUElFYjZi?=
 =?utf-8?B?ZVpWOUQ5RVhjMzJOUHVpZUZGdi8vbWhyOWdkSDYzZ3lXUGRpczZWT0xhdkJW?=
 =?utf-8?B?TU44UENiaTA5T0I4dlZ0WUVsTlcyL0NoSjVGNXZ5Rkw2N2did3ZjSFQ2ZjhH?=
 =?utf-8?B?MmNvVG15YXRoSzJWQmFjVmwxSjhjVUYvekFtMTNsVExQY0VScVdTTWhLamlm?=
 =?utf-8?B?NlNONWlDYjh2SElmU1FmQUpZNTJJSVhsd0NXZWt1U3ROS1RhWjhEWGtYSzMy?=
 =?utf-8?B?MEJKOW5CY2lQZTdReGtEUzkyMS9XT01jdnZmdW5MOEptU01tUkhGWllNbFov?=
 =?utf-8?B?dC9vM2l2T2FBdVhmYS9KM1FHMjJUUGFCcFlUOUJPNmRUMis1WmtjaDljSHYr?=
 =?utf-8?B?Z2IvZ29Ndys2akxkRDNialNreGZRbnRVY20zV2RUSTFpQ0RjQkEyNVFVaC96?=
 =?utf-8?B?ZHZLblZqRGljTEVJWE9PNnVtRmFiRS91SWZxem56UHpyalZwWFpuWkYvdk12?=
 =?utf-8?B?N2tidUpBK1pidDNQN0VRcWpaYUVETEM4M2VhRDhsWjlKSXRBTFFIdWVkZTM2?=
 =?utf-8?B?dUw3M0dSK3pZbkQ1M2JpcmhQajQrQWlYSW04VHUxWkhzZmtEeGZIOEdJU0Rv?=
 =?utf-8?B?UEszczFJSFV2VXhEa2h2WEtuY3haOVFESkFtRGZaRWVsWUw0eHQ2dHB4UzBN?=
 =?utf-8?B?eDNtWU0xdkJpRVFCSG4wNnBXSnJwdUFWREJmSmVxWUVXcXp5dEp2Mi9MeGtk?=
 =?utf-8?B?TFF0dS90akV1TG9UZW1uVGxWQVlqekJkRnJ2Z3VNdEc1VXpobCtXdi9kdkV4?=
 =?utf-8?B?UklRejd4TlYwZ3A0OFdaRStBdUN4bFo1M0IvVGZjNVBJRVFhWXh4YUFrTExt?=
 =?utf-8?B?cWtERWRBRU5hTWdYSktTMGtXWUJQeXJKdzVheW1aOERUUjJqbnZpdHBzRi9X?=
 =?utf-8?B?dzVlUlk0L1hRQUFCYU1BS0dyV1BxTFMreTlOeWw1OHRtQ2ZPajBaa1NiczNl?=
 =?utf-8?B?ZWlFWTVub2lJVXJ1SjIrL1UvR00wUmNxb2FmSVZlMHFrSDNhaDVmMElYVnBt?=
 =?utf-8?B?SDJEcWYrSFhiSjQ3Zld3ZnRWemd2d28wTzNDcGt2YkZCQzZpVm9rbG51ampR?=
 =?utf-8?B?WlRkTmlmdFh6aHRtaUFRSzNHamZYeEZjR0t6emJDM004QWN0T3NvUGdGbDVh?=
 =?utf-8?B?NmEvcG91RWZ0ejFrdGF3TGNGY2F6N3diTE1UaUtPeDhuakRPRmVoZzNQNVJs?=
 =?utf-8?B?NEs3QVRXT1EvVHZsSVhwRDlTSTRFdTJvZ1ZFdlNTcXJmNGNCNEkzcGR6MXBG?=
 =?utf-8?B?MldhLzBYZXZycmhzdVlVamEvYURaaVZqNGQycEJEM0N2bDBIK0hvTXMzWGZa?=
 =?utf-8?B?UjV2Nnh0UU9IdUY2S3RSQU1XTlhueDdKY1F1K1FtV1lLb2FkaTVJLzNqemlt?=
 =?utf-8?B?TzdsV3ZpUFA3YXhROWFPVndpbmtHaDN5d2xDSGdIdzUwSnIwYTUyUlhqalFG?=
 =?utf-8?B?K3VtT3phU0lMM2tlVjJwSHM5N3pyOVF2Ym1qNTdHdVIxdVJhaWZyeDRZMkdN?=
 =?utf-8?B?bTMrbndtR2phYk1nTk04Wjd2bVpucVVGRFdUcGc5RFV6MXJmMDlkQkZraUhT?=
 =?utf-8?B?U0c3OWEwdVZ4b0JGZXZPcjdSRi9TbWs4U1hPOS9sL3MvS1lHSHBUZnZFVW5V?=
 =?utf-8?B?Tm0xY0Z5Qm5odmFick9Yd25OY0FVMnU2UytZcWFNcXdXbGMwWDFySHRJa2FX?=
 =?utf-8?B?MW11MysvQ3dMZ1FzMmloTzlzVnYyUmhkbkR1ZmJlcUFIdzlLSjkwd3ZzZm5w?=
 =?utf-8?Q?2Xv5jU0m6GIybrhkYm7veB6fTu2PQM/30O1Ms?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 992935ce-3b30-43a1-8d51-08de584fdb3e
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 18:15:13.8200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9e65Wz7f+wcuEBIDNAZdbwxpOIQDALFID7l2vCdL74zA0ubZ4g5Aj+5fbvTc3UsXQatM0zYtBW5KgL886ZMamPtckIMGGfiMQu7TE+1x/R8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7938
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

Hi Tom,

On 1/20/26 6:55 PM, Tom Rini wrote:
> On Tue, Jan 20, 2026 at 06:36:33PM +0100, Quentin Schulz wrote:
>> Hi Tom,
>>
>> On 1/20/26 4:47 PM, Tom Rini wrote:
>>> From: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
>>>
>>> Check if elftools package is available before running DecodeElf().
>>>
>>> This clarifies the error message and adds the required test for
>>> coverage.
>>>
>>> Signed-off-by: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
>>> Signed-off-by: Andrew Soknacki <asoknacki@gmail.com>
>>> Reviewed-by: Tom Rini <trini@konsulko.com>
>>> [trini: Add the test provided by Andrew on IRC, to fix coverage]
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>> Changes in v3:
>>> - Add the test, provided by Andrew, to address the coverage failure in
>>>     CI
>>> ---
>>>    tools/binman/elf.py      |  2 ++
>>>    tools/binman/elf_test.py | 12 ++++++++++++
>>>    2 files changed, 14 insertions(+)
>>>
>>> diff --git a/tools/binman/elf.py b/tools/binman/elf.py
>>> index 6ac960e04196..899c84ad36d6 100644
>>> --- a/tools/binman/elf.py
>>> +++ b/tools/binman/elf.py
>>> @@ -570,6 +570,8 @@ def is_valid(data):
>>>        Returns:
>>>            bool: True if a valid Elf file, False if not
>>>        """
>>> +    if not ELF_TOOLS:
>>> +        raise ValueError("Python: No module named 'elftools'")
>>>        try:
>>>            DecodeElf(data, 0)
>>>            return True
>>> diff --git a/tools/binman/elf_test.py b/tools/binman/elf_test.py
>>> index 5b1733928986..3ad0bf4c4b09 100644
>>> --- a/tools/binman/elf_test.py
>>> +++ b/tools/binman/elf_test.py
>>> @@ -373,6 +373,18 @@ class TestElf(unittest.TestCase):
>>>            self.assertEqual(True, elf.is_valid(data))
>>>            self.assertEqual(False, elf.is_valid(data[4:]))
>>> +    def test_is_valid_fail(self):
>>> +        """Test calling is_valid() without elftools"""
>>> +        old_val = elf.ELF_TOOLS
>>> +        try:
>>> +            elf.ELF_TOOLS = False
>>> +            with self.assertRaises(ValueError) as e:
>>> +                elf.is_valid(b'')
>>> +            self.assertIn("Python: No module named 'elftools'",
>>> +                      str(e.exception))
>>> +        finally:
>>> +            elf.ELF_TOOLS = old_val
>>> +
>>
>> I'm not sure this is a good idea. The issue is that you're modifying the
>> variable from a python module. The check may be run by other tests at the
>> same time in different threads and I think the tests will unnecessarily be
>> skipped or fail?
>>
>> I think we may want something like:
>>
>> @unittest.mock.patch('binman.elf.ELF_TOOLS', False)
>> def test_is_valid_fail(self):
>> ?
> 
> It's following the same practice as all of the other tests however. I

Which is probably incorrect. Also not sure about the os.environ 
modification... probably should also be a global or temporary mock.

> might do a follow-up to try what you suggest, since learning about how
> to fix this problem yesterday I realized that I can fix I think my "no
> cover" in commit 66be03b7ee19 ("binman: blob_dtb: improve error message
> when SPL is not found") correctly now, as I think it's the same kind of
> failure.
> 

Yeah, you can likely mock self.FdtContents() to return None, None to 
trigger the FileNotFoundError exception with the desired parameters. The 
only issue is whether self.FdtContents is called multiple times within 
the same function (maybe from functions/methods called from that 
function), then it gets harder.

> Personally, I find the exercise as an example of testing for tests sake.

Coverage test is difficult. Sometimes it's unnecessary tests so it makes 
the coverage tool happy we don't regress. How does one decide which 
tests mean something /me shrugs.

> We didn't (and can't?) have a test that caught the real problem, which
> is a lack of elftools giving a hard to understand error message. The
> patch from Dmitrii fixes that real problem (re-use the test+raise logic
> other functions do), but python testing requests a test for this new
> failure.
> 

I haven't looked much into it, but reading elf.py, I didn't like that 
some methods require elftools and some not. I'm wondering if we 
shouldn't split them in two and have the one that relies on elftools not 
even check if it's there. It imports the module, done. If it cannot, 
it'll complain about
NameError: name 'ELFFile' is not defined
NameError: name 'ELFError' is not defined. Did you mean: 'EOFError'?
and it's up to the caller to handle whether it should be a hard failure 
(not catch it) or not?
or we could also just raise an Exception to tell the user to install 
pyelftools if we really need a hint at what to do when the exception is 
raised.

Quentin
