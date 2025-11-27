Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639D2D116E4
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 02:13:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A29C983B72;
	Thu, 27 Nov 2025 03:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="BvjN8nDF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 845C284284; Thu, 27 Nov 2025 03:13:08 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10F8183A64
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 03:13:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLds2qb7eboZWfXTU4nYsI/h0d92Mrdhp0wJ/Afi9bH31BE67nPKIi4ioUNIPurcKMyKzgKP0w1oJ7zrA48XndxzewdpxMCRyOauVj22gAQh8dBjjv+Xa3SLubmNKgeCNvuV29Kow5KykeaZjiD/74KVGuB30DJ6g1Gjokg4qtNPQJoEf7KOJOTNsydni7WFcHp3inknrWsWK3OuNjZJR6rzIbRU+7tDj24Uv/fh7I0Pt7plaOLhQobaAlVJQKfGBRG44LH+KG2TZpCjTofHLi8DAfzZ2nrjsRHTZpzN7nDXx/k+qNhr92vk41vbHIcjNQaEKNbcvMiw49ilFPmwog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNST/OpoNreTH9j6XC477Mdct/sq4Ug3HtsROSRFt9g=;
 b=rnrjVKQRgt5tL2pNyXoqYtG9yorbQW9Z33ZgAQFY8DqHf934pqoNuO/dLRUqA9W85FO62JlM95qDvMVBzYXpu3kKOuZ3U/BsllKyExb29ANLs2SueAbcXB13lDGW88G5saWp42hJdRCVXXaNk4sjHme/l/AozzWQAW0a50CiBPZYQN7lc4kafw3r0ZWn5vjPUHekaSA8SK0FSXLDOwSSvYKer2OfeuUnZk/Z60uTOu43hpD9unqach1ty/R7O2VM90vhyD6ewpdfBXrX7aIs3SsV0Fz+KwoFXTy2AhxXjxxkJc795vILZILjTTHeKbIgtz97a7M4Sh4kvRkuhJP5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNST/OpoNreTH9j6XC477Mdct/sq4Ug3HtsROSRFt9g=;
 b=BvjN8nDFHFYv3UA2VfpI4z0BlH2ScOiWWasf6ekc9rETclEmq3kIZM7i1QD29EBo7YqoQ9JLtMiPBUNDCygoHZd5RKv6R4pdI3Bu95H9p8FCuWB6HwYk9kFUcM6oLK8so3cfoBhme3POwCSBWKdsjN0lI4IglyDLXwup16Cv4VHn1ug7aqGbCiIpZIDgfVTY/Fr070aorB2VA0uA3awjvaUQQoBc5IIH7ark7DR68dXe8UfP+hwHpT4aSxeRX6LKvhgVHL6khntuo9z2arnXUOK1or68FHxRZylFRQ0h/rgN+hWFkULJJ+V+IyEW2pA8HaMao9dhkM1uccEwidg4yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com (2603:10b6:a03:500::15)
 by SJ0PR03MB6551.namprd03.prod.outlook.com (2603:10b6:a03:38f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 02:13:02 +0000
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c]) by SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c%4]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 02:13:02 +0000
Message-ID: <19c33d9d-4cab-4add-9dff-f3b9e051f146@altera.com>
Date: Thu, 27 Nov 2025 10:12:56 +0800
User-Agent: Mozilla Thunderbird
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
Subject: Re: [PATCH v1 2/8] arm: Fix "file truncated" linker errors from empty
 built-in.a in SPL/TPL/VPL builds
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Brian Sune <briansune@gmail.com>, Tien Fong Chee <tien.fong.chee@intel.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-3-alif.zakuan.yuslaimi@altera.com>
 <3e4de604-292d-4232-893d-db43e29b469c@mailbox.org>
Content-Language: en-US
In-Reply-To: <3e4de604-292d-4232-893d-db43e29b469c@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To SJ2PR03MB7072.namprd03.prod.outlook.com
 (2603:10b6:a03:500::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR03MB7072:EE_|SJ0PR03MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 643f7876-2ddc-4b44-d1a0-08de2d5a7e0e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akZZZUtkVEt6em1Hd1kvKyt4TDIxNUJ5Y1hrWWpFRWpIVEp4Nk1vdXljblRl?=
 =?utf-8?B?Y3NTc005Sm9yR0crUE1nUWRXNFgwNmo5WnFMOExZemVidmVOWkhQUDJoZDU2?=
 =?utf-8?B?ZWJHdlhmUG9tYWFEb1BsUGc3cTZ1N2pJdU9PS3BHdzZVeW1zVHpZNmYyRzVH?=
 =?utf-8?B?emM2MWV6ZFBJUlZCZWlvOC8xUWFzODNMUWttMDgxQmZpUldwU2FJZmYyUDBL?=
 =?utf-8?B?Q2xGQm1nZkVqSnlQbVFza3hvWDVSbDltS3dwTjZBc0pzd3QraElMNlRaenNT?=
 =?utf-8?B?NDF0TnRTMVd0ZWdXMVRJNm1TTk5nK2NmTFUvK3NQcTRQVnYrUW5XS1g3dG5D?=
 =?utf-8?B?UzB0RVZjMGNNdDVnM2d0TFl1ZDlLbXpMYzRNV2pHZmo1UWlyQnlDc1luMUFZ?=
 =?utf-8?B?YTEzSlR5V2NlTk9Db1Z2RklGRDluQUlCSnVBeWlxT2JEQUF2UTRaL3pKZVRX?=
 =?utf-8?B?WE0yOXo3OXF2WVZnMmNzVEg5Ri9VaDBwMDhGald6T2t3cW5menlxamdBTXF0?=
 =?utf-8?B?UkdET0tmcmI2WktDYlppQmE0S2ZjcmYwY1h6RmxzVjBHK1lZVWNtbWpCYVYv?=
 =?utf-8?B?Y2FCNFk5bkNsT3JrRXNRazV6ZGZKdUJ4SGtDY2VHR1JQeFNzVnlxOVRTVXRP?=
 =?utf-8?B?dWs0VkxDQUZLMERGL1ZyRTdjUVJUOFpPY0ptRC9JK21WdE52REcyakhPM0ZM?=
 =?utf-8?B?b3FOSlFDOU11T3JYazVCdlE3MEFMd001RXhGdnRYU0xlZ2g4TEtZME1SWTh4?=
 =?utf-8?B?ZHlDbmRTMUZLN1NkamRhYXFWMFhNalpjU0p4SHRNRFVmZUtrWmhjOGY4WVl6?=
 =?utf-8?B?NlA5cS9mRzdGS1pib0l2bnBaODRxVGtyclNPT3IzNlMxYVA4eko5MjBTbExW?=
 =?utf-8?B?Z1Zxd2FaMHJqaHplWFlVODM5ZTdXL241QVdGZDNlaDdzckJtM29BcCsweHVH?=
 =?utf-8?B?VXEwbTQ1a0NHZ2RwMmcwcVJJNndRTjVwdXlrSzdEbkEwSXZYTWpzOFNEMTVT?=
 =?utf-8?B?MnRSV3JJTTRWZjRmcE95dVd0S2d5QmV6SGM5UGR0VEZFTVBhR3FhL3RUWkNI?=
 =?utf-8?B?NVB0MW9SbjE2QzBtTkFaWkdodE1wNVE4QnhJRXMvYkdFZ3o3VTZMb2U4enQx?=
 =?utf-8?B?U0NFeXZHSUxKQjd1Q09NeC9IZnMyTHJhL2ptTnR6Wmd1UFREQzExRDF4aS9h?=
 =?utf-8?B?WEFYdkMwb2p0UXR2eWo2Y3VJamg0RXI4ay80QjJHa2NqK0h3TlVCRDhNY3g2?=
 =?utf-8?B?R2dtcmJoVEEzQllodnFRV3RlNFk4U2xyRW12d2RNRFdEYmRTVVkyU1ZJeWp2?=
 =?utf-8?B?d0ZaaFpRMDkwNEVDb2NXZVNYUW1PTm95cUhNc25ZR2JweVVrMDZMZWpiVnFN?=
 =?utf-8?B?aHZKQlJFbU0rVmo5bHU4dXFGc1k2OFNnWm1CejlYRVNLQU5wVjFjWHFWNU9v?=
 =?utf-8?B?MzBtQUVlU0RVL0lSR3VsRkdsbTNES1ZEbG00bGlEZnB4ZGNpWUVud2RPM25E?=
 =?utf-8?B?eTg4NllIcnQ3R2gxTTN5K3B4WlJYdmowY1B3cVNTbXBJMENLNnF5dVdENkpL?=
 =?utf-8?B?RVJCMEYyWlAxT3c1bzk4RlNmTUExdkEvYjcyOHJCMVVFVTdTQ2ZGK21tWjN5?=
 =?utf-8?B?alhUNlFnR3d5WjdTZGZ1bFRSZWsrQnJWd1g4VWkxUm9qYUVmNHdZTG1VU1hz?=
 =?utf-8?B?OUhkUjZrUFZvU0VNMTEvMFEvdmhDdS9GTlpaV2pkQWppZWl1M2RUSCt0UlNY?=
 =?utf-8?B?cWJLbTN6OGoyeDFKUFZMSVVBT1ZaVnZPUVVlbStJc3ZaOGYwTmNFZTdCcm95?=
 =?utf-8?B?b2wzVC9EMUFOZEFaSGlNRjMvQ3VhSnZxcVBYWkFNd2tIQnU0dUszNk1YME1o?=
 =?utf-8?B?cXpkeEpQN3FzYTFNR1hvSWV5dEFtMzl4VXFOaGlWSnJzSjYvWDVPdGJjdzZM?=
 =?utf-8?Q?9lxO7q9Dxk4B3Q1XsW8W/hE5/epEdtfs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR03MB7072.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnRISkJaRkdhMEgzUmxvMDliYklpQzB1RXVFeHBTWndHZGkyWkZLTXFvaVMr?=
 =?utf-8?B?b1Jjb3ZQbW5tNlhkWkhCbWF3NktYQXZYenBVWDREaUlRSUdiVWw5OHNiTVpM?=
 =?utf-8?B?YUxOb0FORUhOTWNjVTNtNG1tZWI0cVdqdExScCt6UFlhLzFmN0xSblFyRlQ3?=
 =?utf-8?B?R296MnJPaXhMajlvNWlHYy9oY3pzWlVNell3c2x6VHkrNjlkTFFkclJnRnc3?=
 =?utf-8?B?MzBXcGx3cWxKelZoUk1MTkRxaWdYWDEyZkJjTE9Kb0FQRzJhd0tET29iRmVh?=
 =?utf-8?B?YnQyT1g0WDViYkxxZDZkVk56TjdsTWhPdVEwN1lSSzRqR2RsYm5QZ2FtM0Nv?=
 =?utf-8?B?dlNKbW5YWjRDQ2lKNmtvT21YSXIrNmhPNS81aGtDTktJcFRBSG5Vd2MySGcw?=
 =?utf-8?B?bmFiZVdzRW5ZZFU4MFo2TVpwNi83aVZ6OGYvWWVGSlhWTERMSTRLcUVuWjZq?=
 =?utf-8?B?ajIxS1phNnZ2V3pZUEdKYjlPOU5yWnJHUVNkK1RoWHFHQm54VXpNenAvWWR4?=
 =?utf-8?B?MzhOdlRmb3V2WitrRUxwbmNEaXlGVTF4dnJhTENHNUJwSldSa0MrdU5wL2RI?=
 =?utf-8?B?UEw5TGdEbGwvMCtuQjJHQ1ZvS1JYMTVaQkMvOGhyNVVMS2xRa1RuSlhEdklU?=
 =?utf-8?B?VE45T2o2QmN0RWNyMnNOK3RMVElSRk5qMDJFQW9xRGFSa1ExOGVyWlFVWVpH?=
 =?utf-8?B?ZDVsVitmcE94QlhicmJvMURianVzRGd2cXgzVjdPY05JM1RGYUxkUzlxNHI0?=
 =?utf-8?B?cFo3SGs0WG85d0plU3plV25TcWU3cnF6M1JXengxMXVYVnF4MnFzSjV0SnR6?=
 =?utf-8?B?eDVtWm1zb1RqelBGcTR1ZzdVTmYrM0RoUzZHRWw3SUVQVHlyWGpKL05XM0VG?=
 =?utf-8?B?SEdIWVdwVm1RZXpBVHRoemZEQSsxS3FuUmZoaytnYTI1eEpudzRtRVRNQU9S?=
 =?utf-8?B?MHhyWXNUMVczWnV1UWt5OExvbVUzZ1VTclFxb2p4ZEh3ZkJtMEVGbWF0ZE9Q?=
 =?utf-8?B?R2YycysrRnJwSXVOZldCY3plcXFrTkE2QnRHZnY1aW9kZmlnQWlCR0gvbVNY?=
 =?utf-8?B?NjZEd1pwYUJxVUQxSjFBVmZ3WDBFaU53RHFZOEZBUFlhMzNCZlZkQjZvMEVq?=
 =?utf-8?B?bktnOHkvOXJOaTdNU3ZWazRwMDUyZnhSL1dSNVordFJyUXFzZitlaSsyZTFJ?=
 =?utf-8?B?MHNnYVhDUFNLL3Vma29BS3FPcjVYNXJ5UFBONnRFMTVqY0FYRE1vU0FoRmFX?=
 =?utf-8?B?bFpCZkJMUVFqeDF0cHlENmUwTDlWL09GUkRidTRsT1FnNzlrcHlBS1pwUDN5?=
 =?utf-8?B?QVNQSEptQ0VlK3FMa0JlUmxEUnhaOFNMa1dOdmZmN3RvN1ZNbFZwYnA5K1Bq?=
 =?utf-8?B?TkdvWCtnUTBqS1lUY2pCZ2lzdWNxdnZrNTNEL3B3QkxVSmdyVlArMEFJbkMr?=
 =?utf-8?B?U1VHeXpOeGFvNXd3TkhBZHhwa0loVlFac2U5V2VVb1lkMUNOL2UvU29vNVRR?=
 =?utf-8?B?amdhV2ZGNTltWXZVa2pkTjNzUzJ0TWhhWlVCcnFuSkgxQWtRWVRpVTlBTWtp?=
 =?utf-8?B?TVByTjZZejhUcVVrdUFHRXlwR1lEZnJvaDF6STA5SUxZWlQxV20vUDhtYmNr?=
 =?utf-8?B?WmJmSTRhVlAwallpcGlnV2h3ZlVkalo3V1d0R09tRndibm85SGxzbVVPZEFC?=
 =?utf-8?B?RmUxRHdiMnNXbVUvK3UyNHQwbC9vNTROMUtmY0grdTdVcDJDMWxCbkFzcFho?=
 =?utf-8?B?cXp0QW1zMzRjcjZac09wendUK1ZlclhmaUM5OU9oQUV1eVdCWk5MYjc2dlAy?=
 =?utf-8?B?OWtCNkFwT05ST3p4c3kyZ1YyekhQZkxQMVBzR0RVVkVrM1RETjhqVXladVlQ?=
 =?utf-8?B?N25hTFp2dHVUcmdCRE9EYlZoTXFUbU8xcWlPQS8rNXVyNFRjL3pIaml6bk9j?=
 =?utf-8?B?MWRwYy84bUVGMnBBQU1ST2xoT1MxU1k0YkIrbkRmR0MvaGpqVEpnWFZVTWNr?=
 =?utf-8?B?V2RaRUV0cm1iaXplUXNBNTRsb3F4SE1zREpFR3A4UVpDYmh1REMzaVhzN25s?=
 =?utf-8?B?dGpydnIvTmxzcXVxaGZIL3lldjZkQm01aWpRcmx0WVBPYmNDdTkwV2t5ZElP?=
 =?utf-8?B?ZGFmL1FCVDVueGNsM2xIWWRtUVJYd0Rpdkp0YUt1S2FLU2RvQ3BpempoRElt?=
 =?utf-8?Q?fmtFU3bBELKUlQYKGBhNVs8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643f7876-2ddc-4b44-d1a0-08de2d5a7e0e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR03MB7072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 02:13:02.2926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: np7Ts0XrP+IngCn3647FXJ2tlzIeF34WJRcMzy12NvZY7yZoLPFFWTHBqYX4C8XF/xOxITGOrBNKgoKNcYAnKxiy2nLgFWJeoIXuHxG2tL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6551
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

Hi Marek,

On 25/11/2025 8:23 pm, Marek Vasut wrote:
> [CAUTION: This email is from outside your organization. Unless you trust 
> the sender, do not click on links or open attachments as it may be a 
> fraudulent email attempting to steal your information and/or compromise 
> your computer.]
> 
> On 11/25/25 9:13 AM, alif.zakuan.yuslaimi@altera.com wrote:
>> From: Tien Fong Chee <tien.fong.chee@intel.com>
>>
>> When building 32-bit ARM SPL (e.g. Arria 10), linking may fail with:
>>
>>      arch/arm/cpu/built-in.a: file not recognized: File truncated
>>      cmd/built-in.a: file not recognized: File truncated
>>      dts/built-in.a: file not recognized: File truncated
>>
>> This happens when a directory (such as arch/arm/cpu/, cmd/, or dts/)
>> produces no object files under SPL. GNU `ar` still creates a zero-length
>> archive, which older ARM 32-bit linkers (arm-linux-gnueabihf-ld) treat as
>> invalid. The final link step then aborts with the "file truncated" error.
>>
>> By contrast, 64-bit SoCFPGA (Agilex 5) builds use aarch64 linkers that
>> tolerate empty thin archives, so the same condition does not cause an
>> error.
>>
>> To make XPL (SPL/TPL/VPL) builds consistent across architectures, this
>> patch ensures each affected directory always contributes at least one 
>> valid
>> object:
>>
>>    * `arch/arm/cpu/Makefile` — add a persistent `dummy.o`
>>    * `cmd/Makefile` — add `dummy.o` only when CONFIG_XPL_BUILD=y
>>    * `dts/Makefile` — add `dummy.o` only when CONFIG_XPL_BUILD=y
>>
>> These dummy objects define no functional code and do not affect runtime
>> behavior. They only guarantee a valid archive for the linker, preventing
>> false "file truncated" errors on strict toolchains.
>>
>> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> Such generic fixes should not be buried in SoC specific series.
> 
> +CC Tom
> 
> Maybe you need a fix similar to
> 
> 37a777e1286e ("Makefile: Make sure all linker input objects exist")
> 
> ?

I already have the referenced commit in my test branch, and I can 
confirm that the same compilation error still appears on CycloneV when 
certain directories produce no SPL objects.

The existing fix ensures that built-in.o is always present, but it does 
not prevent ar from generating empty built-in.a archives, which older 
ARM 32-bit linkers (such as CycloneV toolchains) reject as “file truncated”.

This patch complements the earlier fix by ensuring that each SPL 
directory contributes at least one real object, so the resulting 
built-in.a archives are non-empty and accepted by all toolchains. It 
does not change runtime behavior—only ensures the archives remain valid.

Thanks,
Alif

