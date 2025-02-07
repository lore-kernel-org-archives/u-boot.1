Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2D0C02192
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 06:45:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 727B2807E4;
	Fri,  7 Feb 2025 07:45:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="CTV5G/r9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4501E807FB; Fri,  7 Feb 2025 07:45:02 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2070e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::70e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FD63806FB
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 07:44:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oN8Pve++z9r6LzmlwsBcUN70eLRTySwcekJ6fQbDxusyp2R8U5/gvb7bwEArX+FNnadGZP/fwNTSzHjoByWCnRPGbR4RFZYYCgUYjs1CjNrsOEsL4E292hXP7tYLvJfBalcCNZPxk26rD+cl/Zcz4SVA3BKkFFjohrNaWYXR0pCITrDXFjDUR/HeWq2W1NABGMj3xJEAv1BYOsDBwoA1gO5yMiIVb3g2/TOVQi8+EJh2sOTODflltpaiE+tVZgNqStc4Y2zZtwEXzeXSdGayiqclkE8Zmr2K2Rqid8W5TBAkvGf2pPlFkk05+z5xoRoIf68TGKGwVKuMn7fUiSDG4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48Y9/cw9GvBYHgKTQrMy3/jG2JbrcgWEJqq3f5NTceo=;
 b=V0Bj/TUp4NlWQc/yFFfoQ1mqiF84HxhdPePjyPcrPXceWi7NxGdtTLOEg991a72g99r1JnImJ9IBR0GDDbfuQptco60VKQPS3Y29A7eqrSHh+7sSKvdl6yO1md36e5df9atGeDI76UTtuTN0pMTMeiWVvawF0IJFGEMz5VTBGloRZyOty6yKf/bGCZEz76zDjM6WukEOVMJABmjuZRUtm34QhR6sDppNsccmsssd4o/Lk8pJ/8Jh+PwQUFqPs1Cft50i3cZKWvFN+7Te1LZgmuI3QSnjmggr94nrISg1BpO+pUSbPUbbRsNVUldN6s7XG4mLrkswAVMuwrf+cYY4Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48Y9/cw9GvBYHgKTQrMy3/jG2JbrcgWEJqq3f5NTceo=;
 b=CTV5G/r9QCeMzLIBazSzF0sa49tfBtnJGGlf4OIzYSPrJlig13hI25km+FBHYRcm+SBvnPzqsXYTeJuiCfqe9OsfF34e50Pj5SHQc7tHVSCSuoQYMjglzJ9MlKx+9CY8WoC/bSkDbBz7i14CEVF5kuCn4aqTx8pRpO0w+eHmuXQ4dmk0D5n8lhy9rHTRZwG8BZz+KrmqQwyuWe7irGm7zSFQSTXdt1muca6mvAwn1QgMOsyYQfrfHfJDr/TZamNCnrZNqGpnEEjNSO11HffxeOWDBjL9cALloUz7NNjpg92y3S5QlRf+5I/jM3rCTVstGJlwMOlzaTdtSpCyDodzTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:248::6)
 by AM0P195MB0529.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:16d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 06:44:57 +0000
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981]) by VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981%3]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 06:44:57 +0000
Message-ID: <1e84d016-f16d-40fe-aa1a-aebb97e7534d@phytec.de>
Date: Fri, 7 Feb 2025 07:44:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] phyCORE-AM62x/AM64x: Add RAUC and Secure Boot
To: Tom Rini <trini@konsulko.com>
Cc: w.egorov@phytec.de, ggiordano@phytec.com, joe.hershberger@ni.com,
 u-boot@lists.denx.de, nm@ti.com, d-gole@ti.com, n-francis@ti.com,
 nmorrisson@phytec.com, m.otto@phytec.de, bb@ti.com, upstream@lists.phytec.de
References: <20250205080146.1944928-1-d.schultz@phytec.de>
 <20250205145136.GU1233568@bill-the-cat>
 <4f5235ac-c85d-4183-94c1-17650ccad9c1@phytec.de>
 <20250206170725.GF1233568@bill-the-cat>
Content-Language: en-US
From: Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <20250206170725.GF1233568@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:610:e5::12) To VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:248::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P195MB2484:EE_|AM0P195MB0529:EE_
X-MS-Office365-Filtering-Correlation-Id: aa2e40a2-9da8-4051-90ee-08dd4742efa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTdaVzR5aWVoNkl4SmY2bHlSb1ZJUFBlRkR6cWxqeVo3RC9BeUIwTWhBNHYw?=
 =?utf-8?B?Yk5vQWhER1RVYmVFRFJkbFlmUC9Ndklka2d4cDkycmp5SFJhYkJJRGJORURC?=
 =?utf-8?B?amJGTFJIaEYrUitiRVhyOGJJc3VONXVTMnVzbmFWTXFsZU1rNXdrMmx3ancy?=
 =?utf-8?B?Z29yY1N0V3Naa2xrVnQ0VUM3eCtMSlVqM3dOWDFOWVpoQmcxT2JIQ04rMXRK?=
 =?utf-8?B?R1g0bXQzSzYyU0ZvT1pKTlREUGx0cEJ3MGVSS3VDcUkxUTBxK3U0YTNOVVJu?=
 =?utf-8?B?Y005T1BLM0VqcU9JdWJ0M1U2SWdaM0JZTUpCYlB4aEI3dVBscHZxL2c1WUhD?=
 =?utf-8?B?ZFUrSkVKV0VBYU5XSVgvYlRxLzgxSVR3OEZ4SkVOOGNsQ1ViYm9CV3loZjRV?=
 =?utf-8?B?eUNuanhPOXVFbElHV200bk8yWDNaSk1pMW10SW95S2NDQzhnQ0FCWVRpUFNh?=
 =?utf-8?B?ZHhIYXB6Z3BGaHlCU3c3dEp3ek4yNkx0SzhVRU9ZeTJ5am1CNHVmT1l6YmZB?=
 =?utf-8?B?cEFrR1V3UUdwY1BaYWlXaUMzaEw4ZGplMSt0Z2xWV1BRUGVaWlU5aTlyVlZD?=
 =?utf-8?B?NHJKNEJZVEZwMmJBQmpPakdRaG85TC85VTVvRWNEUWxpSU5zSk8xdUZ2Tmlx?=
 =?utf-8?B?b2luTkJheUxJd242ZFZBTWRoVnJpSVhDY2hQUm8rRVJ6TUt6QSt6Z3NvNUJ0?=
 =?utf-8?B?SGh3TEdLTHcvYWxCcm5ZaTZXK3lLNDZ5ai9xWkJpdnR5NkJuUU04RzJURUFE?=
 =?utf-8?B?MCtoTlpkc29lTVkvVCtSY0ZOb21PenBaMlh5SEFhM0M1VUNtOUFPcTQxcVM3?=
 =?utf-8?B?Z3pPZHRVT2hHWExocUxPZEFFSE9yZi9CNzAyTi9rZVdVaXdvVFFoYWRJa2lI?=
 =?utf-8?B?Q3pGU1NaaW1kYk1ldWU2TWNCMlJSOUd0MTU1NVNRMk0vRU5jS2RBSHhheFhQ?=
 =?utf-8?B?ME9qcFlmNlNjdkVMVkc5VnlnbzI5dzZla0E5SzdvMmVHNTJVWTdNMUhTck9J?=
 =?utf-8?B?QlRDaEhYK1U3VmE5SVlmTGQ4OEZLc0h5MWM2dzNOcEpWUTRaTlRDUG5UTGFn?=
 =?utf-8?B?blMwSThhSXl1cXlYNG1QaGZoOVV6djkxT29lMkF3WXQ3NDY4SHdBYUZFVDEr?=
 =?utf-8?B?TjRMVU1sSzJPNDdCcHJIQkZQbWg1WjIvU002MHptWXlkNEVnNm5GYnpCZ0N6?=
 =?utf-8?B?UkxsQlVBbE5mTklxYUNnaDlOMmNITmRIOE4vakFtcUg4cTMwRnY1YWQzcHNC?=
 =?utf-8?B?bjlna2RxRkdxSHp3QmQyeW4rVVc4NXpMQ1NEQmlFQ0N1S0hqRkdOaGxKRDhp?=
 =?utf-8?B?YU9pMmx3R25BYW1nZjl3RVdWYVpKQzFoR0xqUzJjVFVYaDhOazJYV1pRSGVV?=
 =?utf-8?B?M3BpNGRxckZMVnZpckE2bXlOYkEyTFVOOXdYNWFnZk5NNGlkNVBJemd3czA3?=
 =?utf-8?B?Vjdua1JDNGZPajQ2N2taYi8wOE9nbCtvYkozT3g4SGtpYko5S1FqZmVBNkxa?=
 =?utf-8?B?cm9UMFlmM2Vpbmp6Qm5YQjNZY2xROXdzTzFrOU8vNlcvQURWZC9UOGpjdnNY?=
 =?utf-8?B?UG0yMk9VbmUyM2dWQzBDMU9pbjAxV2Q1MitIeHNnOFNKVFJBM3lCOVlPbm10?=
 =?utf-8?B?S0EzNDhzQjlzS1pKY0NmT2s2TDc3eHlOSFFIU2JEeENHYUNrVitjVTVnR1hi?=
 =?utf-8?B?enZDRkVBMlQ4VHM3NHdaeXdGVlFGOUFoMlg4WEY2WTZBMGFXL3JrSGxQWGNR?=
 =?utf-8?B?b01kS0N5NFJ1MWhNNVI2azBIaVgyemdtbUFvRThNQUxBRE1FUGw3RW8ydlk5?=
 =?utf-8?B?Q1lRT2JhOGVuL0JNOWFkeThzK2dNUGVKWFprQkZ0dzB0UTZUUWJsY0Zqakwz?=
 =?utf-8?Q?ajic2bMsgJcD8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0P195MB2484.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEdUUDdCcVE4OWdJY0t0YitXNndBdVJLakYzTStVMS9ZOTRLSlk0b3ZWaTNB?=
 =?utf-8?B?MGhhMDNLLzhDTlZkMzFjWFluYklHSm93MnlJY05LMUljbDJDTVgxZmlQZ3FY?=
 =?utf-8?B?c3pDN0Z2emVhaGgva2JpamxXeTYzaEtpV2FRYUN6TDhhWVkyTmpSU0MrVHVH?=
 =?utf-8?B?MmRYeGNvMVpXUGdOVjByclNIUFk0Z0J1UXMwWTdHUWlicWdGcXdVUkE3VGJK?=
 =?utf-8?B?TVdPc3JpRUhaTjZGUExhTTQyWHMvdUdMZUdSR2cyL0lyUDNBWU52ay9yalZ6?=
 =?utf-8?B?Q2JNZkpFUnVyUEd5MmxOSGFlbXBXU3ZIMFAweWpJNExFRHZSSE1GMlZjRE15?=
 =?utf-8?B?WlMwQ2hFRDZSNE5mOVJidjU4TE55L09RTFRkNm1yVXZzVjRhZG44MzVWV0xE?=
 =?utf-8?B?c2tsOHV6cFFtbTZKYjgxUDd5SDAzVzVFbTMrWFl0dkNVZ3d3NzFoSG5aUWd3?=
 =?utf-8?B?SUVpTGdRek9ySlBPcDhkR3FLUERycFlVTC9KalZRR2ZuSUgzcDEyK0dTVlg4?=
 =?utf-8?B?d2RxalFLd1dPcFpNc3llMGhQb0xVMk03NkJWcVZ0YkloSXF5UGUya25mOC9Y?=
 =?utf-8?B?b1pzNmI5SkovMHp1bXZSQ0xBYWFCN3QvaldoSmk1MHN0enBaWXh0cmhYYitn?=
 =?utf-8?B?bWVmOENJb1FKcW1jMFY5c2VXNmJsUXZ3Z0cxVEF3Z0hraVJtZ1NZa1JzeFE4?=
 =?utf-8?B?YWMyTklHbWhRbkluRHI5d1BTT0ZXd0NzK1czV21MdUJQQ2NhQ1Q5YmU2U295?=
 =?utf-8?B?V1JBSHM1QVhwbng2WWpGMWJQTThJU0pGdHJ4NzFKTjhpQlM0VDZsQUt3STNU?=
 =?utf-8?B?eXFwL1ZXd2lYc2tlOGtxMlNpelhCVEtXd0wyUlhNV3BUVkFWM0VMYXJBQlZD?=
 =?utf-8?B?T1Y2Z3JKMHI2eTd4azhCN2MycjN4MUYrVmMwUm4xVDQrbmV5QjFyM0NJWjFZ?=
 =?utf-8?B?enEraXZuL1ZRYUppZGhBTVd6SERIRVhPMDVwbCs1OTdpWjE0em1SZSsvQW5m?=
 =?utf-8?B?MzJVR3lpcWFmQng5VW1tcEFLcmNhcTJtaUs2Q1BRZzgvbmdPTGUxUGVYVjVN?=
 =?utf-8?B?dkNBZCtyYmNRbWZCQUphSUZhU3U0OXRQU2tGdFRzTkJraHA1Z1BuKzFUR1hO?=
 =?utf-8?B?ekp1dDFwV1FqbHN4elZGU2N2MnZTM29rQzNxM1FTWEFVQlUvL3ZaSHI0N0tM?=
 =?utf-8?B?ejBIZXlWb2lFcTc0dlg4UGdhd0NTbXpZWk9KTFZLcTZSa3hNNS9qQWhDSm9N?=
 =?utf-8?B?R2V4MW8yYnlZZ0JmUzUzWVVmUjRDRGxjUkRDcjRYSWJwRGlJam1jV0Y5U1Zh?=
 =?utf-8?B?b091cVF6aS9pY05zVXlBbFFRMUZYaDUyM0FneU96ZnN1dXdBdy9acExjU2hj?=
 =?utf-8?B?aWl0d0M1UWZKOTBkdTNCL3o1bTNpRTdGK2NiSk9ZNVgrV0pmS01sbnpwbmU3?=
 =?utf-8?B?WUpCUWdyKzN0dEZKbU5Db2hYeUY5Um45NlRXQlRTV0p6NDRjTWNva1MrNW1T?=
 =?utf-8?B?RElHL3dLaWFVMUhmVWpRTUs3ZGUvUWEwcFd2TGUwSU1obEU3bVBZVjdGREtP?=
 =?utf-8?B?ZlJwenJHRTQyLzRPcVZhWWJWWlFubTl0bW90YUI5ZGd1MGJ3cVN0Y1VnbmE1?=
 =?utf-8?B?L2d2SUlZZFZoMklPekQvdW5HdFlSN25VcGRGaHM5eWZHYmJHakwzQzJKM29Q?=
 =?utf-8?B?bEtnNnQ3TmdMRGMrcDJpVGNLeDNmNVlpQTBKdVllMDFFTGxjdjZwcXdBYXdn?=
 =?utf-8?B?cURYeTNlaXpKeHBDS3NJa1hnZExJRXhqUkl3dTZXb3ZBS29ManVqVElnbERX?=
 =?utf-8?B?SXFXdHFmdUE5K2tXUVZQWUtNbjh1TlBIeVlpRmJrVTBFbUt0NzVXSmhHd1o2?=
 =?utf-8?B?cFllOHVjN2RGOEthV3BkTXgvRmZGT2UxN0pqeTllbWJNSUZFOE8wai9vN0pZ?=
 =?utf-8?B?amJZd3UycjFuU1Y0ckZuMWlUNk11N2Q0ajlNOG5XVFF6UHgwQXZES1VkYjVN?=
 =?utf-8?B?bTN4eTVQTGV2bUYzeG5kVnVva1RVSytXN3ZSeHp4OFNPRHBXVTg2aTA3Tjdm?=
 =?utf-8?B?TC9oTURXMTJvNFR5WEhqVU8wdUlaNUtKaEplWDM1b013ZEZaK1NNb0VhM2FO?=
 =?utf-8?B?YVZ2MU83Mm1yamk2TVFBREtYZTFualFQYkJGRmUzN25FRkNPT1RtYTJCNm5y?=
 =?utf-8?Q?ThuI05ce3NNvCLBOBSdRMbT2gx446H1HczRduH1w0Nbt?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2e40a2-9da8-4051-90ee-08dd4742efa1
X-MS-Exchange-CrossTenant-AuthSource: VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 06:44:57.2137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Y5v/hg3HfIEPXRa04dyPIkNAsSY5jRoD+2aa073wnA6NhA001q4jqvJE+lzZrhyPITX7DZcOwwy0FHOtRUPwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P195MB0529
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


On 06.02.25 18:07, Tom Rini wrote:
> On Thu, Feb 06, 2025 at 11:41:14AM +0100, Daniel Schultz wrote:
>> Hi,
>>
>> On 05.02.25 15:51, Tom Rini wrote:
>>> On Wed, Feb 05, 2025 at 12:01:36AM -0800, Daniel Schultz wrote:
>>>
>>>> This patch series adds support to boot PHYTEC's reference distros for
>>>> RAUC and Secure Boot.
>>>>
>>>> It adds a new Kconfig entry to embed the RAUC boot logic into the K3 MMC
>>>> boot logic. The boot flow itself got extended to run the raucinit function.
>>>>
>>>> It also adds Kconfig entries to pass private keys from an external location
>>>> to U-Boot to sign bootloader images. An additional config entries allows to
>>>> enable FIT image, because our Secure Boot implementation uses fitimages
>>>> instead of normal images.
>>> First, does CI pass with this series? Second, is this also based on the
>>> RAUC support to bootstd series? Thanks.
>> I just ran the CI tests and they pass:
>> https://github.com/u-boot/u-boot/pull/739
> Thanks. I was concerned that with keys and such we might run in to a
> failure to build in CI.
>
>> This is what we have for quite some time to boot RAUC or Secure Boot with
>> our downstream U-Boot. It's not really nice but working... Martin started to
>> work on bootstd implementation after we implemented that. Our plan is get
>> the current boot flow upstream and switch completely to bootstd later this
>> year. Afterwards, we would mark the current boot flow as legacy.
> How challenging for your plans would it be to not upstream the legacy
> path here and just build on the bootstd method entirely? I can certainly
> see why you need to support the legacy model commercially but if we can
> avoid adding it and intending to replace it in the community that would
> make a lower burden here long term. Thanks!

Sure, we can keep the current boot flow on our downstream U-Boot for now 
and will add bootstd later here.

However, there are some patches in this series which are require to sign 
images, device-trees, etc with external keys. I will send a v2 and drop 
all boot flow related patches.

- Daniel

