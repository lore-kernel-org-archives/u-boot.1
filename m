Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3C4C25B79
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 09:22:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C4CA88011;
	Thu, 16 May 2024 11:22:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="X/PwpCTb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8566688027; Thu, 16 May 2024 11:21:58 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on070b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C9A287ED1
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 11:21:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+wDLx8LYpkZoZ8umz+YZTh5+IY3BGjKP/2GxAREAo1IXkJXbd8wLUUaQQLdhQ5AefsFr9aI+Cd8QUOyjP01WwdCrNCDL0pxmeGYhFwOfAgjnRelJgzmJ+0bARgXEEbKabQ/iGeEB7Zc8R5xAQPYzIksQgLzALhAsR28t5w5MKh/WjzTjNS42qK5yq9dF8sUIY/A+CFI829JYb6P9J4C8uVL9QSXURO8V5/K7cZMUrK/TnU4DRq4bxzhFSKe0CjksW6MWKCIxLOG/J7UCYtFjD2RiH+IEpjAsBUHkcEH/17tash0RxU0CDEthLwLTP9a114grbJFhhVVnN+Epg6t8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMWpy5GxTbGavicox4nwfbDL2iqB9sbNwcI60juai3Q=;
 b=hXPa07yTBCYCYwDijzF3NiW88DNdyDpUwOblmD8WKAQtE6GznT7+G0BHQiZXH1vMY4IFCrpWIFRPfMvRzPeYQ1ZYAMYGcdtNZnIYicwRSZeRfyxVeoKica3MTDFqgdz5RZKzLhiMO1TEq87lTNE8XBn90vige339RmJx2AFYwH6JwnoKAzFxEwUxjgQBJWiSSm0T3RO1XuPc4ij+7fu6STT0xj07ztJixzQgtcWbTzDeYFDAXNbs/fLYRt7zOPs47jnkAk0FWUWbPkdo5Zmxd7KTuq90rOVVfhulwtgYdVrcvznXvtkJiP4bejOls8IKmnGKeljR6dMS9MApUPF+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMWpy5GxTbGavicox4nwfbDL2iqB9sbNwcI60juai3Q=;
 b=X/PwpCTb+82ehy22LNuLWfjEZcyeMmyEpvJxUstElTaYvOPhb2KJSBBTAmLxV67pMsoDQSthV59r1CL3dtLb7BttgA1Lci+kR3X2zW934+QtrYTOxCUwD2TEtih9+hG/hP79FuHd4j27L6PzEUWTIM4Eb+M/4IIPxEc2vEYyfC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by PA1PR04MB10397.eurprd04.prod.outlook.com (2603:10a6:102:449::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 09:21:53 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 09:21:53 +0000
Message-ID: <1c5c0be5-eb49-4af9-be29-e4ab95e9f8be@cherry.de>
Date: Thu, 16 May 2024 11:21:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] rockchip: RK3588: Enable display cpuinfo support
 on all boards
To: Anand Moon <anand@edgeble.ai>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Andy Yan <andyshrk@163.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, John Clark <inindev@gmail.com>,
 Jagan Teki <jagan@edgeble.ai>, Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Elon Zhang <zhangzj@rock-chips.com>, Joshua Riek <jjriek@verizon.net>
Cc: u-boot@lists.denx.de
References: <20240516090031.2373-1-anand@edgeble.ai>
 <20240516090031.2373-10-anand@edgeble.ai>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240516090031.2373-10-anand@edgeble.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0001.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::20) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|PA1PR04MB10397:EE_
X-MS-Office365-Filtering-Correlation-Id: c9342f40-960d-4821-92b3-08dc75899fb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|376005|7416005|1800799015|921011; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejZ1K3R1MTE3WENFNngrclB0Y2ZhWnhOS3dlUE5vTm1DVlNhUGt5SGMwQW1q?=
 =?utf-8?B?dmxaL1VhUkxjMGdYWmRlNFNGTGpsWHlaanMxMUpITVdLQnFwUXpyeGttcnJ4?=
 =?utf-8?B?aGQya21hWGY0TzNhcG9zV0RSalNjQSt1ZEFtc3IwNkVWRG5lK3hsNHFFeVh0?=
 =?utf-8?B?dUkvcUxEbUR5RUFuYzUrV09EQ1NWeVdmY0J5QVY0V3Q2YXpiUVQyT1RmZm1Z?=
 =?utf-8?B?eWlIQUV4QzJFSUV1OGxOYUFDNmNQN2owUFhXdElwUm10QWZkb1JOd08yYXQv?=
 =?utf-8?B?OGw1U0ZwcFArMTNOV3pyNm13cmZCU3NTWFBnTUtnZHZyTEVjcG5mTUFTaWlz?=
 =?utf-8?B?NzZtU1J0NzBKaEpzVVBwT3VoaTdTOThvUkFXZGNySEtoTnRreXJmZWRPTjd1?=
 =?utf-8?B?bFZpb2lRRTN0ZTROcWwrWGR5UEw3RWQzSi9hUVZNSTJ4MDBCVndQTkhzSGRZ?=
 =?utf-8?B?Yzg1S3NMUGY0SEdiQVFDTjlWUVdEejRQaTBoUnVUTHJxT0VaRnZNNHJhNGI3?=
 =?utf-8?B?UXVER3FYQVkwV3JlRHVzbXhia05IYmVFSDgyYWhJSzlNalFnSC9HWVVtU2dw?=
 =?utf-8?B?ZEpVVVdmVUYyNXcxVU51VUo1R0tFR3BwaDRjMHdxRW1zRjJzTzBVWTNBek0v?=
 =?utf-8?B?ZFdLM1BkN2ZKOTJWMnAvQzdZbitFdUl4bVUrR05OL3ZERWtNTzFnVHRreG4z?=
 =?utf-8?B?NWZRb2hpSzlUT0QvTmxxYWI1V3pKY2Q4Mnh6dG5kV1pKdWJlNGdkWHFBUXMx?=
 =?utf-8?B?OVhFeHJRMWlhamVEUVkyWXlJSkZ3ZFJybkhuZk5GeFN3ZTYxNXpiY2FWMW5H?=
 =?utf-8?B?dmZSMk56eVNQWFhEZTNtNWVnLzZldnh6R3ZHWldsQk9NR2hTdTdoOXYzMmow?=
 =?utf-8?B?NHN0Y3o3YjhBSG5yUWtnVFlKb0t0Uk9DZlNTVld4ODlQb21RR08wbXVEOXdz?=
 =?utf-8?B?VFNPWU8xV050TWpReG53MkdjS1ByYjMrSHZmMjNZTmg1Q09DWVZtKzVwUURE?=
 =?utf-8?B?WStBT1VKWnBNc1hPTHo4cXNPUzRSZUNMdFlobnhYeENQUGczVFlXdUhuVFJj?=
 =?utf-8?B?Y3V5cUpRT2k0bUEwazNCWnhpanoybHlXaTRubzJZZFZqSXVtU2dzQkEyMWNa?=
 =?utf-8?B?Q0RHZ29oTHQrVXZWNHAwNjVHb3JsOFNMVzNOOWhIZEdNRWlOSmt0aDhUTjJD?=
 =?utf-8?B?REUvaXVUcGUxTjFtTGZmcFRWb2dpM3hEWEsrZ1A3K0lySFg0Ym5uM2dQVXB0?=
 =?utf-8?B?SllkQTI0eGo1NTRWZEMra0FveXlpR1FKSlZLR040Yko1QkV5MkhCRU9YLzIy?=
 =?utf-8?B?WldDb09kbnBOU0Y1Mk8wUG13aWFWaG10ZnFFaFByaTd0MVV2UlFCWTR5d0hG?=
 =?utf-8?B?K1o4MDBzRU5HRUMxeEFDblZoaFZjU0ZSSjRkUkNuWnBvSG1qdDh4dnZ2WHJR?=
 =?utf-8?B?bXRSQmpxRlRNYkVTUkFtVFhxdWZlM203ME82cGNXU1JCekJleXJjbTU4M3dK?=
 =?utf-8?B?MEJ4RndFUm1xRG4xbE9GK0ovelFsUTlnWVMzRW9VVFZmWlJDRVdhS2RuWGgx?=
 =?utf-8?B?MXdWUThQbEVXS0xEZG00UVZxaFZ4YlFzeGJSOGtrNVQzK1pSYUcwK2Fnc09J?=
 =?utf-8?B?OVdEYVBBNXdZTDZQWXNGcHB5bVdEbkx0cVdwa3c5Y0RRb2VvMW9BTGpyOHFE?=
 =?utf-8?B?QkhROWQwbmk3WWlvUDAvZ3lvKzZ5M0RBRElkQUxuV25ZdUNDYjRsM2tnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR04MB6589.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011); DIR:OUT; SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0M5ZkY5VktNZVc4dVJpdlJXNzdmMUxBSFF3T0RWWGFlNEFLaDdvRkQ5a0pR?=
 =?utf-8?B?S0o0WUwzWkFuRHdRS2xISkpWYTBWY1FBakZvUnNJaHBxQ2N1VTQzN2pOSDVv?=
 =?utf-8?B?YlhBM25TQ0l3OW5zWmtreE1QMFNnbStrYWJUT3p0dFgwMVlUUXpyTmlYalAv?=
 =?utf-8?B?c3RxNEVFeFZ0eE0yRjlPaWZRaEI1RU5IYlpzSm82VVg2bUh6OXA0bGdRcUdT?=
 =?utf-8?B?elV4SzA4VkUyYTFkL2FTNTJQZW93WVprU3NhZUMvU0t6NmQ1dU16ekFvdis2?=
 =?utf-8?B?cC9UUXhUaS9wQ2s4UzRvK1h3NGFvNUtydTB3Ky94cUdubTZqdlVZZWhWbjEv?=
 =?utf-8?B?d3hWZ1Q1Zi8ySFZVRlpxeGlBNUcyWWtYMVNhZVowUldGZUVOaFlGbk4zYXRj?=
 =?utf-8?B?VWd4UGhQUE9sNk1oUmcyMXhuekZjMk8zZU9BZVFRNHJ0QmU0TitSSGJob0JE?=
 =?utf-8?B?WmcvYll4Vys1cTJ2WTBGQk5FVnJsbDVWRlVITHJDT2wzSU43UVkzMWEyTHN3?=
 =?utf-8?B?MlZ6OUQ4dEhiWEcrcmxTdjMrckdPMTFEcXYzT0JucDR6eFVGd2ZSL3djMk9R?=
 =?utf-8?B?UnByNFhwR2RlZ0R3OWZwa2QrRlB1SDJleWlNa0lnM1ExUnlzTDNPaHVmU1k3?=
 =?utf-8?B?RGZ5UTA2QnVOd3drak9QUWxTRmMybC9pT0pKRUtWaVV5cTBCNTlrNmphaldn?=
 =?utf-8?B?V0Z0Vmd2eFZCUm5FZDZHb2x3M0c5bXZCMmZSM0VWa1BlZys2R3ZyZXNHSS9a?=
 =?utf-8?B?bTdsV2V4S1JVTVdReExrZFU1UXY2OCtLZVRXcW5SN0Y3Q3dSRk1BeGl1a0pZ?=
 =?utf-8?B?b1pwR3BBZk8xWk9VbU1aZ3ZaSGFYM09ETmZsa0RpaVNncGNseGU0N0JTQ0lz?=
 =?utf-8?B?ait3K2VMd0RkZ3dHc2YwbjVCL2x3S3lKRENhaWRqZmRLR25hZ2wxb2lBSWlF?=
 =?utf-8?B?bTJWSjhHWW1UbTlXVSs5Qmo1cEpyc3RxMmtyb1JGbkVuSXo5LzBJb09ESzlw?=
 =?utf-8?B?YnRtd3hCTWNkSEFCRlhVSWd3dmtBZEU2NUg1WVdWbTc4TDZ1dStIYUVBdUR1?=
 =?utf-8?B?cFBRVndPRzdydXliaFJUc2hka3hHRURIQnFrQ1JvYW9PU2NYbVVpRGltMWhY?=
 =?utf-8?B?TW9QMUdFYUZKaG9NdVBaUUtxa1RSUmlOQXB1V0JOWU56ckowaWlqVUM4SjFG?=
 =?utf-8?B?d1kxSmpvdmxOY25TcXQ2RWpDc0hVbTNSWnQ5b2dXb3Bhc1hqNndIWTRlcUxs?=
 =?utf-8?B?YlNBNTdlOW5wZGlrOElLaFN1WnQ2VlhtN2JiOTBSejcrWEowdkdDMWp0OFNK?=
 =?utf-8?B?SWFVZUtNUW5oYkQxdkx2YTA0MjZZeTgrV0UvbFBmMFVSRWhsVUdXN01IcEpB?=
 =?utf-8?B?R2xwMVgyZldCV1g3N09qeUc2ZHp3MzJML1hBQVF4dVJmcW8zSjJXOGNXTHF0?=
 =?utf-8?B?bHd5LzJqZDlob0lMaW84TS8wZk1xR0JoN1ZBbUZVSUZ3bGRUdjZ3VE9FQ0xD?=
 =?utf-8?B?MmtFUjVCMzIyTkNtUXo0Y2I4TS9Cc0trbm94bXlkQy9NZWRHVlVPa240TUM5?=
 =?utf-8?B?cnFwNXhwdTVwRHNESTh4YlB1VGZweUxFKzNpK0kyeE8zTytLNHZQUWZTcW81?=
 =?utf-8?B?Uk9tcEFDV0JiTEEvaysvL1hoRktCdUtOV3NkRDRSMVVqb2twZnlqeVVLU2xC?=
 =?utf-8?B?NGZCRGJCUmV1M1J4UU1iZVdhMnczQktKVE00M2diMjhZODFLdzBhQlhrODlp?=
 =?utf-8?B?NytyckJBS0FBZEtNMS9IUVYrYXhaTGs3RFRHUjIyNzNCK1plSTdpbzliRDlB?=
 =?utf-8?B?QlFZdG1pS2FMMnJUV2dGQ25iNlZJZUJXM3NPNFVxdVU5V3VFNnF0SURZTFdz?=
 =?utf-8?B?eWtZKysrVW43bUJOeVUrb0taYmFrOExaS0tpR2RIWk9KRjI4b3E5emJNUTVx?=
 =?utf-8?B?RnBydlJMd0o5TEJxdUF6WTRMWGgyZXhzenpKelhUdW5pYVNMMUhwaEVRU2ZY?=
 =?utf-8?B?L09TM2JLbEFCaFNsZ3k5cVV0bmNvalZReWo0VDNQb3NsUnMvZTR4SGpwYlJF?=
 =?utf-8?B?Ry84QkZaaHo1OUltRjdlZW5EeUdsd3BqRUV1c2VBeHk2WW9QZ3dtQjlLV0hK?=
 =?utf-8?B?SDJJMldINjkvR3pZNFdRRTFGTmVlcFN3YmpQcUR5MW1ET05ENHZpbXM5amRV?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c9342f40-960d-4821-92b3-08dc75899fb0
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 09:21:53.1162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/Yn+N8comz0Rc+it2nB3CFBY9M8JUkpbj5fCK0V8MinMugKcKCHGr7n7tE3D2J0xXbzoG+IuDQveelpgHerEqK8B18v4FyfQImbhcqrSFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10397
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

Hi Anand,

This is patch 9/9 but somehow I didn't receive any other patch, nor did 
the mailing list? c.f. 
https://lists.denx.de/pipermail/u-boot/2024-May/thread.html and 
https://lore.kernel.org/u-boot/. Are you registered on the ML?

On 5/16/24 10:59 AM, Anand Moon wrote:
> Imply DISPLAY_CPUINFO Kconfig options to support on all RK3588s and
> RK3588 boards, Its used to determine the reset cause of the board.
> 
> Cc: Jagan Teki <jagan@edgeble.ai>
> Signed-off-by: Anand Moon <anand@edgeble.ai>
> ---
>   arch/arm/mach-rockchip/Kconfig           | 1 +
>   configs/coolpi-4b-rk3588s_defconfig      | 1 -
>   configs/coolpi-cm5-evb-rk3588_defconfig  | 1 -
>   configs/evb-rk3588_defconfig             | 1 -
>   configs/generic-rk3588_defconfig         | 1 -
>   configs/jaguar-rk3588_defconfig          | 1 -
>   configs/nanopc-t6-rk3588_defconfig       | 1 -
>   configs/neu6a-io-rk3588_defconfig        | 1 -
>   configs/neu6b-io-rk3588_defconfig        | 1 -
>   configs/orangepi-5-plus-rk3588_defconfig | 1 -
>   configs/orangepi-5-rk3588s_defconfig     | 1 -
>   configs/quartzpro64-rk3588_defconfig     | 1 -
>   configs/rock5a-rk3588s_defconfig         | 1 -
>   configs/rock5b-rk3588_defconfig          | 1 -
>   configs/toybrick-rk3588_defconfig        | 1 -
>   configs/turing-rk1-rk3588_defconfig      | 1 -
>   16 files changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 2e9c71138e..1b5cc34f99 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -366,6 +366,7 @@ config ROCKCHIP_RK3588
>   	imply SCMI_FIRMWARE
>   	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
>   	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
> +	imply DISPLAY_CPUINFO

This is unnecessary, it's already defaulting to y if building for ARM 
boards: https://elixir.bootlin.com/u-boot/latest/source/common/Kconfig#L596

I also don't think this is SO useful that we need to enable it on all 
rk3588 boards? But also, doesn't hurt, so... whatever I guess :) ?

While looking at the code, I think we can remove the ifdef in 
https://elixir.bootlin.com/u-boot/latest/source/arch/arm/mach-rockchip/cpu-info.c#L47 
because this file is anyway only compiled when CONFIG_DISPLAY_CPUINFO is 
set, c.f. 
https://elixir.bootlin.com/u-boot/latest/source/arch/arm/mach-rockchip/Makefile#L30

which also means...

https://elixir.bootlin.com/u-boot/latest/source/arch/arm/include/asm/arch-rockchip/cru.h#L35 
should probably be ifdef'ed

which means...

https://elixir.bootlin.com/u-boot/latest/source/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c#L64 
should probably also be ifdef'ed (but the config is enabled already 
(well... it wouldn't compile otherwsie), so I guess this is fine?).

Cheers,
Quentin
