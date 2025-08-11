Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB579C87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 14:20:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F679832BF;
	Mon, 11 Aug 2025 16:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="CfHR1YGf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9072B832C8; Mon, 11 Aug 2025 16:20:25 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91A6C83013
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 16:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Do4l2NUlu6dkG3kaWxAENUSJfP9QVvedZ0flhx8YhMrCvofZLIOmty7oxxjxfYnD0qlZjC551CehGzj/EVwpA+Iv6x9cCzLfrxsqXmlYfaviMeQMvn3WAYHIyxPl4NjLQnwPqf81FAxujGFN/nWQNNAuEc9EVB/7+mCzftcYiXkNh0/9KZB7sq8akAQhVPrawHV17cgUC2ffAVz5f/Wo4+/NPojV//w1Zs4h/+CK58DuBXUG4x13wBrSVrFRBJbI/vYyMrtMoAhCnrgH7TEBQly36loZTkhU72Xpg3zQWqRcH8QtoK5e+6thnPNYAqXxeANaKBzQ2FuVPCOqm5BbcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZ91qeHXO/L4ThdZCmsVLTMVyoSQCpz4jR9Kp2CmJgc=;
 b=rRf4CgUYuvuCcfUznuFlyp6nLJ6QxyysSQb87lALt64+i07yRR2oQKB/nQKP9UKjldaj7U2ZIGg4LObMb8heHZPdskkXMzcoBcAbDtnO8mk0/9fmWzXq2/REfVm5W3Y5MZaAiHfrYxo2FnXNbWgYJbDDtRdKA2VDyqqPo03EonNsMsD6vwyxBzasssaQLZ7P16p6X7F72WzHpn5rOEONEEBcQv5LuGcC0IXCMbkF1zNoax2d/x6xGzWGM5wVuc7RrjA/U+30oO8Bvrpb81eh4YkxhPg4IoT1AeIR5c+rOF1R6/eb6f6kWOXIn4tW5DcbGGIcIHzO4tHFKcszz/clJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZ91qeHXO/L4ThdZCmsVLTMVyoSQCpz4jR9Kp2CmJgc=;
 b=CfHR1YGfw4KY5R8+kjq9YcLyabnq/ijxAkk83sHB0EDx5TWP6PL8X2w0Qq/gHwlUf5HJI46UtkxsT2sRXYdt99/+6Mq8/eMF/tN+X1IdlYYp+yxQKBaLf08NutoTyhcoFkIHBI2UbBvs1oOLcMt8roZFBMr3eevqR6Uam6PWc3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI2PR04MB11002.eurprd04.prod.outlook.com (2603:10a6:800:280::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.11; Mon, 11 Aug
 2025 14:20:20 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.011; Mon, 11 Aug 2025
 14:20:20 +0000
Message-ID: <1d6e75b2-4006-4f37-9fd6-6dc85e7aa541@cherry.de>
Date: Mon, 11 Aug 2025 16:20:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: renesas: r8a779g3: Set VDDQ18_25_AVB voltage
 on Retronix R-Car V4H Sparrow Hawk EVTB1
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
References: <20250806192456.133098-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250806192456.133098-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0227.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI2PR04MB11002:EE_
X-MS-Office365-Filtering-Correlation-Id: f884319d-1c6f-4c7b-467b-08ddd8e23425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlJBMys4UTYwWDgrWEVQV2psYlo3V2NQSXlTUDBCMmUxOEVwRStaK0U2TVBu?=
 =?utf-8?B?NWNpTEQ0a2x2WFhsVnROTUxNY1FaeWdKSHB3MzcxQ1RvSjNNT21acDE4RVlW?=
 =?utf-8?B?QzN4cmxoVy9kc004WUJ4R3BkWFRzeElSRlEza0VtZmVjSnBmclNsTjFlU1ZP?=
 =?utf-8?B?ZnlHNWV4SnF3VUpaUkFZbjZvS3M2Q3JpVUpaKzZsWDF1YnVqSGNHYktmaE5p?=
 =?utf-8?B?NmRNV0pUdUxIWGtBd3YwalF6Q3VQZXkyZDZERWFsZnpxN0hhQkp5UEFQTzlw?=
 =?utf-8?B?YTBjZUN6ZUt5aCtDYzAvaFphOFhMVFMrRjVqV0lwUFpZczJxenJLdlBkRzY4?=
 =?utf-8?B?dC9qVUoxeWk3NW1ia1dXN2VvSTJ1NityZldvR1ZMc1I0ay9MZ1BuSFdYTjJV?=
 =?utf-8?B?ZTdueGxVSDNXN05RWkUzb3kzLzRQSUp2VWZ3dnMvSTdYK1NEaGtMWUZWL0dR?=
 =?utf-8?B?MHptMGlSQVBTeWZIOG1JRTlNUkkxcmY5V3FFSTY0dko0M0hjV0pWMDJabHE4?=
 =?utf-8?B?WjRjMWpkK3NLZE5mN2Y3VnRvR21QMkdqdGtRWDZROUo0dXpScnRNd0VlQ01x?=
 =?utf-8?B?RmxKRGE3MFVVN05LZlFhcVBUc0hMNm5DVUVRQWtOZ3RkeEFSdHRodWJKR3Bm?=
 =?utf-8?B?dnJEMzNaNzRVQkFUU3dMYnNZaURlNU12cmx5MnBCNUM4NU82Qnhlck1LMUlX?=
 =?utf-8?B?cGlSaXRaRnpjRytNWU5HOHhFMVZTQjZrcTQwNGd3Yk8vY3RsVkVtdVVIYTJa?=
 =?utf-8?B?N05iaTMyUkExNHprK3laWmhrRCtyRFNHL1VvVVVXWlVhREtCazdPcERpanhI?=
 =?utf-8?B?Q2pnMEUvTEpQZUtZWkFpRm4yTmErU0t3bW41Zjk0cFlrNlZiVDhFQUsrTkcz?=
 =?utf-8?B?WGw1V0lTSFd2Z3l5Vk9odnpkS0k4Rzh0Vk5oQUNpRVRsRG5CS25yTExlZlpz?=
 =?utf-8?B?MFQ0WHRtVlVRUGxOajlUQk5Ra0xtajdPeFlFRDQ4cStpUXpTT3hUNDVpYzlI?=
 =?utf-8?B?VnErTEM4TWJoYW4vQWlFZ0lXclIrakxZK0hGSzF1RjhoMzgxVy83dFBuSVZD?=
 =?utf-8?B?a2FhOWhUU0htOFRReFZVSEZlR3F4WGRwNGFrL2hPYzB5SXM5YytFU09pQWZl?=
 =?utf-8?B?eW9ZaUdPai9Hb21kVnpCYjkvMCsyQ3kwL1NQTlJWKzQzYWtkdXZOdTk0WmEz?=
 =?utf-8?B?SEdRSmR2dEFpRWdWdzU0NkNlNWFxVEpFNkVzQUFoQ09HaXlROFpSMkxGaHd3?=
 =?utf-8?B?QjF5TE5jcjJRNEI1UFkyVExBbkk3czM1UFNoOVJ3eDQxcytTUlRBRktuc0hW?=
 =?utf-8?B?RnJUNlp4SFVXbXlXRzl3d3AzV0N5QTZXOVN4VnMySVhNaExoSy9vck1LaWlU?=
 =?utf-8?B?R2hKUWFhSkJLanN5RUhzTW5XQWRLREpraGJMYmtKQ1VPQUZ4M1ZncUpOMVlG?=
 =?utf-8?B?RThwOXNQOWQrSTBwRG5ZUmdZeDRYYUZsWWY2M24wRzVVeTBxRStxQzJFdE9Z?=
 =?utf-8?B?K0Vsa2psLzIrWWRXNVhYallPZk5KM2NsNnNOeDloSmpHNm1Lb3MrNUNUWFF3?=
 =?utf-8?B?Nk5NUDUvajdMcGNtY1Q3VnlzT0RrUTJSTDh5TlZuclBNQ21FNXdkR0RlVjha?=
 =?utf-8?B?bXZDeGJwOXVyNElLdE1aSndWOGdGZFp0c29mN2xISVZuWGk4M0lQR0Vmb3d4?=
 =?utf-8?B?d29GZHpDb0pjMG1JemkvdGpna2hNYWVUWWtuS2JpbDc5eEVhNWdJQmtUMHdT?=
 =?utf-8?B?K0lpUUVicXM1U0RzS0VjVEE2NW9EbG0yWG5nNUV5ZXpncmJPR3JNZnQ5ajI3?=
 =?utf-8?B?bVU1MUZobU02ZU1PMTk5MXVrbmplTFBOYWRXZGhqakQ4RnlOdUU5SkpIdkNP?=
 =?utf-8?B?TGxFRjNJMzgwQzZGRDc0dnlBMHc4eWpmaUdIcWo3Nm1vUWNUZ0pQUC9WWjFz?=
 =?utf-8?Q?4T+1W/czvrM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2o2UlF0RDlhY0swQThXS1ZjRGRYY09VOTFnMThOVUNIa3Z5SmRrMVRBa1d2?=
 =?utf-8?B?clNlWVE3b213NVBWcGs1M2owMXR6ZEEzRG5aWUNDai9RTkd5Wnl6S2xtN1B6?=
 =?utf-8?B?dEVOMCttamlHSjd4aVdTN28yWGdGY3p5WTIxRzdQMzQ4a29LQXB6WmxFYWRi?=
 =?utf-8?B?bVZpR3UzY2JSYVQvK0VyQnA0T1BaQnEwbEhZb2RHb0FYWnZrZWtPNWk1c1pL?=
 =?utf-8?B?MFkraFNUaVZFV3A5eEtTUFZ6aGQrUkI2OXZ0UFNBYjBlSVN0WmVCZmpERjdu?=
 =?utf-8?B?c3dIVjlLSU83SjhnRlo3MzhySkdtcSsyY3p5UVlHSW5Wc0lPZEN4UnhHNXYy?=
 =?utf-8?B?WEpUbWlzTkg0MEJlN0RFcFoyWDhNeEh4dTRNVi9XRDlSbnNVbWtrbCtEeUJa?=
 =?utf-8?B?Y054U0pCTjhPeXJZYVpULys5dmZIdmFOQkh4RktDVWpMemdhTTZrN05wTXVx?=
 =?utf-8?B?YTB2ajFObExQbGpYMFhNelNKa25mV1F3L1VDenhGeUZRb2xaQVNpTEREOWd6?=
 =?utf-8?B?SW15Sk9MMnI3b0x2RXpCQUs3a1owTHRiYlBmRWh4L0o5V1g0SmhiaDI4bXk3?=
 =?utf-8?B?dmtuQUsvOEpnUWh4MFhjUjM1czNxbHBxb0p3RnE3MjNNdEx1VTZqRWxwd3Va?=
 =?utf-8?B?Y0RLcS9GMzBnMzNJbTJJWFBFM20wZEtHaURSb3FVMGpIaTljeEZQVHJ0RjBL?=
 =?utf-8?B?ZXpXTUd1SnFrOUxjM0dSSVZsNmZraW15RGQ0MkpTZ2FOKzVneGk1RmN6c3Ix?=
 =?utf-8?B?dWc5OWR1SlBuMnNIRll4NkptWDRyNWdHbFlRT250ZWhoL2tiNE9XaEJQaTJO?=
 =?utf-8?B?WjJpU25KazBZWE0xR2FrWG9pMG1mSlVzM1RLQ2NzWktWUDJhK2FackRaV0ly?=
 =?utf-8?B?NG1pOUhheGhMRytDQjg4c1o5UGZ2Ymp5cHp1RnZFUjFkeXNPUHB6NGlSd3Nz?=
 =?utf-8?B?UVdKWGl1ekgvVG8vdDJDQ3FwMTl6VXYvWFBxRE5WUzF6Ry9USGkrTFlObEZk?=
 =?utf-8?B?QjJuOFUwZnlPM3pJMHZEL2pvRmc0R05BV3VZUnVtZTBJajBHQWdIMWdvVEc0?=
 =?utf-8?B?OXFuQ25TR0U0alozeXlVUWFCMTdwc1BIVVF2dkF1NEZnVStTWFZ1cERNamt4?=
 =?utf-8?B?amRpZlRjd01JUVk5RGljMUZxWmRyUCtYdWRmZjI2Z3BuYkc4bFFWWkV3WG1D?=
 =?utf-8?B?eDJGS0dmMjdwdUxaM0ErbnBwWG1LK29hWGIyM0dxSHpZd1c1b0NiWXY5TGI3?=
 =?utf-8?B?TE9jQ29zOEdDbHBRZ2F6YWphQ0Z3WkdtR01Xc2R2bHlaeTBiYlBTOVVXN0RF?=
 =?utf-8?B?bGx2SU9Ic2tWdUNTQmVJTXJ3SzlkZjArZkY3UzVwamFvWnVTMUFNL3ZZSnVy?=
 =?utf-8?B?SWwzR1RjRENKZnE0bzdJbEtYcUFlVDRsU2IzK1VBSWlNYW9DSUc3YVg4WTFo?=
 =?utf-8?B?MHBPRERCRWdWbjNTWkRYZ2NvODhFdXhVSGo1TVNrYUJqbStqK3U1NmVlbTgz?=
 =?utf-8?B?VityemVMc3JxcU1PNGY0b09Bam5FZ3FzeGVhZzN4eHVheW5WSEowVEt2TUpE?=
 =?utf-8?B?SnhUOE8vVjRQdXlSVlNxcnovd1ZrZThkUUY1OHRudGJHblREQ2dhMFFxUkpo?=
 =?utf-8?B?eXhtUm1QUUt6ZndHbWd6eXRJVmNpeWJXYUlPRHhNRWZVZ0MybFZXbVZ5bks5?=
 =?utf-8?B?K3ZLbTVRS2U3MEFQR3ZkUjczd003MGh1VVpuWkF2VGZjc3lIeHdWaEg3Z3J2?=
 =?utf-8?B?WEV4UlB4Ym5nTkw0TXVYWlVDVEJnWTdNSEdXdDZRZ1pRemd4V0lrejF5R0N1?=
 =?utf-8?B?elhJd0ZVTy9DRjFVbEZXclNZdlBDUjUvOFNLMmVLUVNRdEswbEdFUVBYQ2Iv?=
 =?utf-8?B?a1R4bnhhakJCb3JaZ09jcDd5aHdtakdzcEZrWmdjNWNJKzNLVHBKNXMzcUxm?=
 =?utf-8?B?L3lEY0xIV3F4WVFybE5yQk1KWlFqNjdvV3c1YXJDTHpkM05Gay9wcTh5eWN3?=
 =?utf-8?B?TmZFaFhmbVJQT3FYTWhHRFNsbk1hdlMxZUgrekF1UjNsNTQwSGl5LzdDRjRo?=
 =?utf-8?B?SU1raGhQWktDczJzZ0JNZEQxWWZYVE5QVzQwSFNKY01RQ0dXNndUanZmU3BN?=
 =?utf-8?B?M01YeDVRZ0FlZFEzbnBZSk5KVHNzK1ZhcFpSZVlBUkxHRERGTkRZbW81NjBr?=
 =?utf-8?B?ZFQwQVVub1JyK3RPNloxNkw2SzFRa1pNVGlYV2MweEZXMm9LQk5PK1JZRWtq?=
 =?utf-8?B?YjJ6NTJNNlNRQlp1cmhXUTRWR1J3PT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f884319d-1c6f-4c7b-467b-08ddd8e23425
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:20:20.6717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLnM7sb8ZN5Z6/4IdEfihKNEBpdHUZxcyFTZNtdqcFsed/OJE+CfM3mKrX9i3zpVymn5d81/J362ZTEcuTJJQJAuNH3rMntDTiT9K7hYogY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11002
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

On 8/6/25 9:24 PM, Marek Vasut wrote:
> The Retronix R-Car V4H Sparrow Hawk EVTB1 uses 1V8 IO voltage supply
> for VDDQ18_25_AVB power rail. Update the AVB0 pinmux to reflect the
> change in IO voltage. Since the VDDQ18_25_AVB power rail is shared,
> all four AVB0, AVB1, AVB2, TSN0 PFC/GPIO POC[7..4] registers have to
> be configured the same way.
> 
> Correct the voltage for EVTA1 boards accordingly by patching the U-Boot
> control DT in SPL.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>   board/renesas/sparrowhawk/sparrowhawk.c              | 12 ++++++++++++
>   .../src/arm64/renesas/r8a779g3-sparrow-hawk.dts      |  4 ++++

NACK. We only allow cherry-picks to dts/upstream. Please use 
tools/update-subtree.sh to cherry-pick from devicetree-rebasing git repo.

Do the change in a -u-boot.dtsi companion DTS file if you cannot wait 
for the Linux kernel to merge the change.

Cheers,
Quentin
