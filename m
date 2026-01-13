Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78842D2F345
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 16:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8757808AF;
	Tue, 13 Jan 2026 17:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="fU8rbVKF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA8DE80B98; Tue, 13 Jan 2026 17:42:37 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE36280077
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 17:42:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvaNSACm+/evErMu+vDH9Zv3vh4eT4d63Rt4xaac66i3d1Hp0M4gCiGnbi7TvXltCgCCXLBcGKDj1LyFGT5pQElLS0hDNSTBi7DaWHCejVuYRNmJh+k3Tij9G3Mh2caJZz9jZoFynVUznEnD9gCS96ZCVt9UVw6lMm2fNJ6yX0qt08X7Hov4hbGviUh1R5XoTxEhhnBtlAYs6iXS2h+fxgY5y9fFp3+93HGRW/z/iGa8cZKglwdUzOntNGhzJ6rqdCtiH/8J+z6S82ES/6dLpRto0DXcAqHg7MEVv9sTBKu60rPX/lX9iXmqKE3xerRmKS/UC++2tecr1FN7GEny+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9QV2RGa9m4qPhWkY7VsGmugaLyCTU4M5IvO7r7Jgac=;
 b=Nq/MzNaYAZDcFJI4lMdYtbXKrsZ5O+2Bh3q6pbtYLrBsjBuu5hoEFA27t+pVanbpQ1BgmYi5fdiKZQ50oiImN0WCByOfGHS6GX2LQnZihLImtncK86DgOA934+WGGd+xCIOyBj/yzXPOfnZVeEYDm4OiIkJNtbWn1dSceDfTxek+vsHYtdFV3mIUNvAoz6oM4TyJm7x5/P5iYFQ6i23RmBFww2crLTVyCfct+pAFdob0kqMpInFUqs+6d4MkO1KunCSMLZACpl6pkZN0fs/p/1tKYt/rXCdAMbKhFXfzk79DhGxy+P1+QGVgGs2kcku6/xPRMCxNNjWon1ym0HeSNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9QV2RGa9m4qPhWkY7VsGmugaLyCTU4M5IvO7r7Jgac=;
 b=fU8rbVKFijhDAHL1rTWGMuKahIhdMxntbkCqWTT0k6Nx20+52nTVpOm0xhUCCAormeqbcfKWvFYvT8HSmfjDnJWSGP/kR9U0lc8jCC2KqNo/5QwmjU7r2mBdmnFOaQT5RbFDd+ieQ5G9XnZ3hy/VW8K5PCq0p7nkrC186ob7KTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI1PR04MB9787.eurprd04.prod.outlook.com (2603:10a6:800:1d8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 16:42:30 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 16:42:30 +0000
Message-ID: <9095dbbf-b039-4fe5-8157-736e46ac0f04@cherry.de>
Date: Tue, 13 Jan 2026 17:41:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: u-boot.dtsi also possible for dtso?
To: Frank Wunderlich <frank-w@public-files.de>, u-boot@lists.denx.de
References: <trinity-3f748198-84ca-4da1-a48d-3f6e1c1818af-1767437709081@trinity-msg-rest-gmx-gmx-live-5bb597646f-r2jdb>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <trinity-3f748198-84ca-4da1-a48d-3f6e1c1818af-1767437709081@trinity-msg-rest-gmx-gmx-live-5bb597646f-r2jdb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0228.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::12) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI1PR04MB9787:EE_
X-MS-Office365-Filtering-Correlation-Id: 28568366-23bf-431d-412b-08de52c2be8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YU9PQlVkWDZUenVVT3d2eXI2bXJtTm5SS2FVY0ZwTW1lYUlZb1g1azRPejJE?=
 =?utf-8?B?cFFLTldsamtwaXFiakUwZzd4QkVNUXFMRDNBYmY0OW4xeEREVGxMZkNYTmNk?=
 =?utf-8?B?amNqYWEzNW1mWUxoL0FzT1I0aENwa3l1Y0JSTDRFUURBUVlSTTlNQzBKWGNJ?=
 =?utf-8?B?dDFGRnJWYkJZdmR6dDhJbHlDek1kUmZGUVJhTUNISjVRaTIrbUkvZFhrU2JC?=
 =?utf-8?B?SU0xOGhtN3lYc3NyLzJZcVdzak9ZekVmNThXUXFhTllMcDZBVW9hb0JIRE9G?=
 =?utf-8?B?ZHhGYTYwNHhQSWtZdzBWelVTbHhiWXczSlUxSXkycUMrVUVyVWtpNHkvN0FQ?=
 =?utf-8?B?M1gyU20vU2pkN2tCdnl0QmliWjZRU3owc3dsaGgwZzdGU3FHblZMTGs2ODkr?=
 =?utf-8?B?SVl3eEhFVzc4RzhVNTFmdWxMZEhSMTVEaU1paGpzRkl0Q2xMdlVJR0xsdmlV?=
 =?utf-8?B?Qkg5SDJFWXg3OTdzaWlha09oRGljTEhmb3A0d0NqRGlRNGYwLy93VXZOYzZJ?=
 =?utf-8?B?RS9jMEx5MkFYdnF5d1hHbUFGeVlhQlJ0bDcxL20rWVVObnRTWUpxSVUyckla?=
 =?utf-8?B?SEZma1d3RlZ0RnM3aVRQV1c4R1QyZTRmaFVBakRPQmhaM1NBb0h2ZWJxYi9C?=
 =?utf-8?B?eU1ORGFlMm51L0lKM0xTS1lJNnAzb0Y4SzNxdWxQZitYdmZ5TTNFajRpZjE1?=
 =?utf-8?B?N2djVCtFOFk5MFdTRlVTOFZFOTd0aGdwaUhPUDVpNDh5SDBVeVlKZVpFOTQ2?=
 =?utf-8?B?TUlPVEVFVmx1bzdxQW1scE11ZWRNZC9uaWhJaFNTK0VKTjVKanNLZHhrN1Rk?=
 =?utf-8?B?cDFtZU1lSWNJK1BIMDU2L01UY3lIemlWVkdiRS8wTnB5bnFXZFBIaHAyNzFx?=
 =?utf-8?B?SUFWYktjbHhiL0VVSExSREI1RHFpU1VadlpOUlNXKytLQTBrbXRnRmErU1d6?=
 =?utf-8?B?Y0Zrb1d5MGxzbzNzTGVkVGZMMXl1c0VFc3g4UDhOdE9qc3FxejJiOXVJWVhl?=
 =?utf-8?B?MGY2c0N3SFlIWlRFejV4RXFrRy9jL3pTdHh2Ky9MWmlybG9PeXdPNFhLUUxs?=
 =?utf-8?B?dldzUW4xRTE4RDR1SjBleEFTN29EZitLWDJTbWtBdXdqNVRldENkSGRpa3o4?=
 =?utf-8?B?YXJyd0h5d0xHbHBydEphVnNmQmlFbWZ1ZzNsMFQ4aGtqaVE4MTBzaEtwK2lD?=
 =?utf-8?B?Y0s2V28wM2NaeUlkc21iNlNvUFRPVWh2NHcwbXNFTFljWEc1ckJpRDF2UFV3?=
 =?utf-8?B?UmZETGt4bWxDMmxmUk5uRloxLzEwUnpDRU9UMFREYmY2VWdIdWJ5TG9UdDBV?=
 =?utf-8?B?cldoaEVQaXJudGY3SHV4T3FwM295b0krSll6WjlocGsrUldmWnYzMUdkcDlD?=
 =?utf-8?B?ZTR4d0Fic0hTbXdKS3ZadkRzKzBMNmxMQjh1TjYzNWdXdXY3cUxMMjRrL2k1?=
 =?utf-8?B?UWRFRFh6N3hiZnJtZytQMThCUksxTHZvYVlIUXVnRDJONWdaUlVQY2RZeG9n?=
 =?utf-8?B?aFhxc3VVZGU0cVRNQU51Q1ppN2owRFp1Y3N3ZFVwTzV4RGNRVm9vNU1ZelI4?=
 =?utf-8?B?RytZUmtnNUNmeW5TS0IyL0dUeEEwL1JZeTZiY3R4ajVsVUs5aG5TM2xiVW9H?=
 =?utf-8?B?elM3UmowQWxXRkFuRkFCSmthUnVlY3loSVFJM2tZWWRTK0F1blNXR1k1VS9F?=
 =?utf-8?B?aThpaHNVZVd6SzJSSTJ4S2VTMjdLQzVhV01ydml1VFRRdU9VdTl2UnUwWVRr?=
 =?utf-8?B?bmFFdDFEVlhub3FlU0VJRjhJS2RKcWNDTzdqdGJiT0lja2JCc1A3UUpGdGx3?=
 =?utf-8?B?NWxUcmhqR2dXQkNlQWt1eUZtNVF1enNkTjhxaDlMeG1OVWo1cmNwZnI4YW5F?=
 =?utf-8?B?L2U4ek9RRXMwVjRnSVBYQVZBWndhNVBFYnJDUWJmNFM4OTVtRE1mYVYxdmFq?=
 =?utf-8?Q?k+/hgrUziGh8Gp3EdUpKqgFzgyccj8as?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emFmQXpMcTdYYmVJa3FsdkFwU1VQdzZhbFdkS0FUeDlhdUl1MWZZYW9wMnF1?=
 =?utf-8?B?a1RVZmJ0amVoVFVYTGliQll5dUpQdVdCQ2Jha0VDT1plZ0kxR1gzdmMzVzh4?=
 =?utf-8?B?Y3gzN1NudkZCeFJ1WUtIMzIyclRSU2xPVXpnRHo4M3pUeUNRWTF3SE5jbEhk?=
 =?utf-8?B?NDR2cHpFeEdxWjhDNlNpMDZmR3c1ZGFocWVvdS9tME9ldzdxZy90K0lTT2NQ?=
 =?utf-8?B?ckxOOXZsMmhDRVovaldVNERkV2N3U3o2Q3VxVy9GWjdkWmVHNE5MRGtSNHdj?=
 =?utf-8?B?KzAxZ2gwY2JWbi82S3M0MGR3ZTdIK1NaaXhmcjJydmRoeEtiSWxJbmM1T2Nx?=
 =?utf-8?B?Q3VzWElES3FlZkhOUThTTm85T0hNdkdIUWZzSGFodGtEem5tU0xFYVhBbHlD?=
 =?utf-8?B?Y2MzdzJsVGZCU1JCa082bzdGak9YRzdxSkVKNmUvZDNUS0phMDZnRzl2YUtI?=
 =?utf-8?B?eGd5Z2ZML29JS2VEREw0eU5QS0c5NWR4TmZvbFRVaUpBSmthZUx0SjRsb09O?=
 =?utf-8?B?QUJtTDJ6aFoydkdyL2VVS1pxbWdLOGEwRmpJNEdQUSs3ajYzZ3c2NkdYdFpE?=
 =?utf-8?B?d3FkZUY1T1Z2Qi9aem04MXNINUdtQzVGY3l0RURTQWNTZEdlWjhRcjhZUkRt?=
 =?utf-8?B?czRCUmZjRnJLNFFPcFplQ3RPSE9jUXFZanpqNG1YQXFtMEV5bTExK1BtUXpo?=
 =?utf-8?B?dTk3N1poQVB0eEJwT1NTZUVZZEpOQWkzcFl0Yno3YVlCQTczZ0RMMDkzYldr?=
 =?utf-8?B?UHpleTFiNmpiemUzZ2ZYVTdRejB2MjIxWWt2Rit2V01XRldYMFBFalBac2Fh?=
 =?utf-8?B?Smd5YjNob3NRVGNHdHUvZkdLWENtT2pOYXdRTGZTZWtZUktON0xsYXNRRHp4?=
 =?utf-8?B?VTFZSUNYVWU3UURFcUQ3L3pwZVZVVld1d3d3UHF4MmNoalliU0VIUk9jTHFR?=
 =?utf-8?B?M21sS0MvUU8zalJaNEFKbXhFRi9FZEZtM3NaZlhDNXVCSnRHbno2dnQyY2ds?=
 =?utf-8?B?WXpWeHRGSHRSWjJRdkdoV3pTMmFqbmhZeThlRU9JcDNuRzh1RlhBOGFkbGlx?=
 =?utf-8?B?OVl2cHN1SXAycXNDN2pVUVBScEFXdGx2SVBCLzhqeWpkQktTM1VxOURmbGt6?=
 =?utf-8?B?dzhwMENheEErNnZiUS9SVE02ZlBFVE4yZjFoU2wyTi8rYzVOcGd3elduL1JX?=
 =?utf-8?B?QVB6cHBTajRnUWgxVk5PMC9ORHcxNndOYm5JV3BHWHYzbUltTTNGWTdESEE0?=
 =?utf-8?B?a2Z6Q3UwaU8zVHF3YXZqcy9Cdkx6cHowWmgrWUthWnY0QzZBaUxpZ3F4TTJm?=
 =?utf-8?B?WDRKek1CNkRBUzgwKzBsMTU3SGRnZkl1dWZYc3MxdG1mY1B4bXllNXloUHo0?=
 =?utf-8?B?N3JrRVRnT1QrZmdYWk5iN0ViRWVQOTJrOGp0SGU3bHJzcnV6V2VrTFgrSEJY?=
 =?utf-8?B?TlUzOFJwK0pMZEo0ckpEUWw5L1NyRmlxYjJiTlB5eDVsZUFTdmErWUFDRW9R?=
 =?utf-8?B?cmJEejduWHVBd0s4WnNicXhCdlFVY25lTzN2OTJkdWNmSllOYVJSVjh3WXR0?=
 =?utf-8?B?SGRRSWpERzVYbDB2ODJqSTlOcWxPK1RJTXJBejJrTFhMalZMVFZONkE3NVBK?=
 =?utf-8?B?akY3amNvSFVOQU1YOTUrUFlROHBiZnN2aTFRNlJnS2Y3V2NEaTYwSDVnYldQ?=
 =?utf-8?B?ZWFLUm1MMHVKRTNpL0N3UmVEeVkxaWN1QTJ0dVR1cGlCRytFdFl6QTBZb2Ja?=
 =?utf-8?B?NkVpK09MclpOQWpPc2toWTluMVgranFXOHgzUzd4VVVmOHlVd3Q1QkpQMDgz?=
 =?utf-8?B?bU1nRUYxNUVFa3Zqd29VK0xWN2R2QmZseVdPM0czY080NmdjQkFpcFM1NkRR?=
 =?utf-8?B?SUg1bWV2OFRGVmdwZ3NjUWowL1B4blhZc1B2M3ZkSjFUZ0N0ckxqZWNwbWNI?=
 =?utf-8?B?UjA3NjZmOFplNHhmMEpCV1ZFbzZsVkp0Uk9oSStsMmp4dWswR0wvL1NZcFE4?=
 =?utf-8?B?SEhuaVRvekNnVlRsV1NKLzlHL281UkhyUmdkTjlEUm1QYkxxc3FCUUlZQWdh?=
 =?utf-8?B?TEgyTC9JcUJtcmQ4RC9WWm5jbHhCNHpsRW5PUnhHMFZScE1lMGlzRmZzbGtz?=
 =?utf-8?B?MURZUWg5M1ZtREpxaVNXcHFjdTVQMWxxbGw0WXRaZGtvQXBXOTlWUW5ROUhj?=
 =?utf-8?B?eDZuL2wwSDZ0WDIrenpudkl2OUp2M0xJZE1Tcnp5YWhjNVlvQmtTallZYlBI?=
 =?utf-8?B?M2crRHJwNU9YSHNXZkllb0Y3SjBoN2Q4R3R0bytOM0YvazY5aFM5YVpDRkNM?=
 =?utf-8?B?MDZwWTZuTFRCendpWU5BcFZBZkEzMFQyS241YXBDN2VlYzQ3bkRLQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 28568366-23bf-431d-412b-08de52c2be8f
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 16:42:30.8435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEMRzlNdof0JsO0wQibOVuZ+j1KjdWWvAC0gYDwpCGm56my1+fHQcqX7M3VrNFy7Y+s03YT1GEAZK86y8fZS0W3iGvjw63XUJJ5wlk4PlK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9787
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

Hi Frank,

On 1/3/26 11:55 AM, Frank Wunderlich wrote:
> Hi,
> 
> i make new attempt to change mediatek boards to OF_UPSTREAM because i found out, that dtbo merging is now possible.
> 
> but i faced a problem:
> 
> e.g. BPI-R3 has 2 SPI-devices (nand,nor) on same spi switchable via hw. i need both in dts to probe the right
> device for linux and to allow install from sdmmc to both of these devices based on hw switch.
> 
> currently in uboot the nor is device 0 (unit-address and reg) and nand is 1. this does not work in linux, so i need a
> way to overwrite the dtso from linux with the new values in uboot.
> 
> for dts there is a way using -u-boot.dtsi files...do they also work for dtso? where do they need to be placed?
> 

I don't understand the issue. Is there code we can look at?

Are you planning on using the exact same DT binary in U-Boot and Linux 
kernel? Why does it matter to Linux that the NOR in U-Boot is device 0?

Cheers,
Quentin
