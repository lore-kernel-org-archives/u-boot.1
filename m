Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4F0C3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 15:58:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9716681DD6;
	Mon, 12 May 2025 17:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="kJYN7r+r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0226A82905; Mon, 12 May 2025 17:58:38 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E4B3805D7
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 17:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9NgKefX8qJ7Eq+8x5b5GP2Kvizeu1phsE/3cp1yWWirHSzPjSmcIsxQNRZW8MIW/TEMgOTOhXYAA/P9/tr9BO50hY1YS0/4vq30x3zp8FAvVb1/lFcNdlSgSyfbugZnwFZBZR7l/dcDgNDciZWY6jFIt0hn2bDspnoObXH9B+0WkqIfN7FapQX0c+eGPLw/mJmX3sj5hRUAXo/vvZ0lJ/3HKKQd6onCMxprEFc3kPLq+69unxuZ7cOikUBXVz47SUV1TXsg/AzTF41TL2Pzx/N4PE1gdK8hVQPSHd6Euz9SgxcjEE6pI+DmMA2oK8Dy3pClAqJOvo5B7FMHGz4BZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySV3lJdjqMA79/ym9/Pu2aS1rmaTc2zX4tXx3q13ZJI=;
 b=ghBRrk6IHDSmeQxj1dFfJji7eeEQpae3Tby7YxXQKwKPyGW10FbHOpTVZt5ODHUUNAxo5cSt1cd/a9doSs6cBK36VBTjrdjHXGO/QJn/BZ0IHXcYyobbCJ+3F9BnkQ4Z/IguJmX6inCfiLcz+ZMPPeHgtGPsdWTElgN3m/5AA1v4xIa2SnXYaWmOnLxtofwU9GN7iN0UvPk9iecPj98Tfr7t8b8on/cZd/yXwzXqOtnsa+5vbOXa6q8lZuKVYo7nS9A/qbl2oe9borW5Ptyf+NwevVnfwuIJoQGWktGOInRUs82UOr0QSt8E5wD/bMtn5Ag1fj8MjSibcnpY1IMvrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySV3lJdjqMA79/ym9/Pu2aS1rmaTc2zX4tXx3q13ZJI=;
 b=kJYN7r+rCN9axnDVsQrslTQr6U1sSCGoOcD7y7v+CN7BCmgytpz3V/V0h8u5/X/01AUV6EYK6VYTsK4+4FovgJfnHOzlRRqNjv6O2RZPnuaQlUqJDikDHHXk3urh+KdCVvDrcymvGfSxygz6cu1HGl533Kw75WXDsmYT+xtN97c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8818.eurprd04.prod.outlook.com (2603:10a6:20b:42d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 15:58:33 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 15:58:33 +0000
Message-ID: <7ccf1122-c110-44d7-abfc-0d8b136fff3f@cherry.de>
Date: Mon, 12 May 2025 17:58:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] arm64: dts: allwinner: a100: Add CPU Operating
 Performance Points table
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>,
 Philippe Simons <simons.philippe@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, linux-sunxi@lists.linux.dev,
 Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>
References: <20250511011003.15654-1-andre.przywara@arm.com>
 <20250511011003.15654-4-andre.przywara@arm.com>
 <ab250c1b-d227-404d-b834-300b82b925a9@cherry.de>
 <20250512114645.60bff4cb@donnerap.manchester.arm.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250512114645.60bff4cb@donnerap.manchester.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8818:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e23a6b1-89b7-4e5d-aa6d-08dd916dd90a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LzhCVTZGWEFxcTFwUVhhU1JkeWpVL0J2dS92clpUcWx0clpERzhFN0ZjRG12?=
 =?utf-8?B?dEh1bVQ1R3BKbkl4OEd1SU1vVk4vUDkvbjIwbVl5N1Y1RGQvWkRBUmFvOWM1?=
 =?utf-8?B?WmhKbGl4MEhuOTBUTFo3Sld2cnlsMk1lU0FYV3VUbC82NU5kaTNYNEM2ckN1?=
 =?utf-8?B?M24vT3FPV2p1UjF3QkpxSjJsYU05VlJFRExuTCtnd1llRFg0YzIrRVFhclky?=
 =?utf-8?B?Slc5NzhMaFlpVTh0MThZa0Zuci9GQlowQkx0UVpKM0JXUFpZYWlCbXpCdnFQ?=
 =?utf-8?B?TTJnclNEU0FPVTlGTUpPV2FOb3pDUkc0ek81ekVTajNja0JTNm5sUUg0ellF?=
 =?utf-8?B?dWthWm0rOUtJRzNIUFZQQnFYYXRRS1pad3hpZENhMk5NU0t3NzE1aC9nd0JP?=
 =?utf-8?B?OXpwdnIzNlhEeHdwME9KZVBGR1ptN0V5L1V0dmI5bHh3bVhLZ2pvRzJPYXRJ?=
 =?utf-8?B?bnoyNmNjQms3cUZ4cmhRYU50MzRPTkxyd2VOek54N2Q5MEtlWU5CdTl2LzNE?=
 =?utf-8?B?RDBWWDNnMnBaSDB1U3YyYXpLV012N3QxZVRaTWdHUDRJQk43TmQzaTNBZHZt?=
 =?utf-8?B?MDhiWU1OdG1nZjBzdVdtcStsTTl0anhWOFUyc2pNM2hZL1lGanFtWmovOHJV?=
 =?utf-8?B?L1crbTZRb2ZaQTdQM2ZDL3N4OE1GY1NRY3l3ZGVQRW5XdFZwcUFHUy90WE9h?=
 =?utf-8?B?YjBOdklqTUhUVU8weUZyRW1MRS9vcnBMVjVXTGJlSXVFanJDZFVIWnhZZXFT?=
 =?utf-8?B?MEczNTduTVd6ZHRoTUh6U1YrWVo5VUowSWw5MDF2Z1lUMDB4bmxGSXJLLzBx?=
 =?utf-8?B?dDNPREZjK2pqZE90Q21QdWZCbkdGTWxzUmZEZUdKTkNkMHhPYWFucHFrZXdi?=
 =?utf-8?B?UytqYzJaK2hsQTE2OU5xSmRYU3UwZ1NCcm1qQkNCbmdjbk0xVTN4Z0FpY3hx?=
 =?utf-8?B?Z0NHWUZLYlZqQmxVQkxtaTFNSVB1NmNncVJmUWQwVThQaTF1cDJKSEFEUVFV?=
 =?utf-8?B?TEdwVTAxV3ZmYjJaNGdiME5aYmV6VWxWdVYraVBIRW5YRktyVmF6Qjc4L21R?=
 =?utf-8?B?SkJBaE1ISTRkNHpSa3J2cVdQNE5ldWFwdExFdVNjT0ZEZ1VjbmFxNUhzRWhv?=
 =?utf-8?B?NmRSY09PdzZpOHFlR0JkdDhvY0ljSlJTVVBLMGxNbUxvQmlCUDZlcm0rR0tB?=
 =?utf-8?B?cmROMU5hQ3BIcERWOWY0cFlCZzJlbmRIRDBucVdrdGRQaFgxOEh1S2d3MnUr?=
 =?utf-8?B?SDFCR1ExeXNIcFkwWHJ3eTRKR3M5THN3OU5JM214QTdMYWUxVkxOQzdqS2Fw?=
 =?utf-8?B?R2ZJRXBDWUorTkk5V0lobTgxNEVpb0Q0azJxazZkK1plRndZSXh5NE1JNmlQ?=
 =?utf-8?B?SnFvS010bmIzNkNjY3hPUit6Y0ZocmFEVzZzZ1JEbzRpc1NxWmtZYXJUVzVl?=
 =?utf-8?B?eTNoZVZDMjhhK2NvYUJpcHNnbW1RZUhCa1N6SzJHdVAyTUdCSndOYVExdHlt?=
 =?utf-8?B?cUlrdEpzMms5SUJvSnRCdkU5ZDdCdlJaSFpBWjR2UnVoL2Z2L1hYMWZxR3Qr?=
 =?utf-8?B?TWppOFYwWExCMlVHcU44aDYybTNZeEhiem14dWxMdWhQaEp3N1dPV2MwZSti?=
 =?utf-8?B?dHdGU09KVEFUVktqQkhXSDc4c2QzTDV1a0JBd1R5alYwUDdBK2ZpMEw0bVA0?=
 =?utf-8?B?cFg1TXNVMytadDFxRUZUNHJpY0lKeitiS1dlNXdDa2pIZW9ya1EvYU40RzVK?=
 =?utf-8?B?dHpqRkJaQngvM2VIODd6TzcyYkVmMVZzSkE5azRqT2FyTmdNN0Zpb3U0eVIv?=
 =?utf-8?Q?4r1A16R1yTrnFRvU/NjwXTdT60U+zSiWOpUcA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1NsK1Y3L2g2U2V2OGtxSHFybm1Dc1RRZTgrTW5yWkZVdHFhdmdVKy9WWmFq?=
 =?utf-8?B?SE5DQ0V3dnA1djhDVHhhVmtjYmxGQXdrVnFNMkYyVExTcXFaY3pBbFpuZE1l?=
 =?utf-8?B?RUk4dEs3Q2Y5UVc2aUkxYW84eU1kako0MEhkV09EcEpMcWI4REx6VU93ZkV6?=
 =?utf-8?B?d2dzTDYwS3NBL2JyWFlpcmhJZ0Q3QVhCMEtjd1JCMGpEZXVJdzl0YUIvQUhC?=
 =?utf-8?B?RHJrUlBFM01CTFRLU3J2U2pQSW92SURiNGFTcGxNTnJEUm9FWjZvamNsZjd4?=
 =?utf-8?B?YmNwNHgxMHhLS2FDbjNvSm1rTVAxQUJENEZPVWZqZCtObzBFWkJpUklHa2FQ?=
 =?utf-8?B?V1NTellXZS9VVUhzZGtYcmx5bms0Um1SSHVrZjVvb3htTlNBbW9zSXJsbE41?=
 =?utf-8?B?bHUwMDlpNndicEtKcDhLcWhmMzdkblo4MEhhVHhBWjVJdnpSbmE4QVJMZ1lQ?=
 =?utf-8?B?NU95bHZMbmZmdWtNUkU3Ui9QYzNETGwzMHdyTTRyMUdFNGpMQnVBUzVEVGw4?=
 =?utf-8?B?TFJ5VTU1YUhyeHJPSHJ1SEJabi85WmpORUIySXQxUEExL1V6YVB3YkZNMjFq?=
 =?utf-8?B?cEhrUW5vNFc3ZlpVbnFUS0J2RnVVZm4zdmtEYWhWT1VucUF0dnVIbzYvRDBG?=
 =?utf-8?B?OXNlVmJsb2RFMFRrYjZqREhQN2xrSWdaajBwMllXSVhxWFJTSmJxcysvSHZa?=
 =?utf-8?B?TjhIYVE4VjZzTVBlUVpDUHpRUllwbXRGZHU3dFo4clM0ZS9XUWN3TmlzOGc0?=
 =?utf-8?B?eExBVGhySSsydXdjWkJFTUVRL05sa2tXWEpUZ29nb1I5cHllMUJla1ZLR0ZN?=
 =?utf-8?B?WkQwMHZSOHhmZnJzTlhBSnlHYzNNeVVDOXNvU0tNQUtUOXVPZkJtWmNEc2Np?=
 =?utf-8?B?TTZvbUZ3RHI0ZWtXWW8yZGxZWnRuYnVzUTZMVm84MWRFalNSc2dTZVFOV0tI?=
 =?utf-8?B?MmE3VHFSQ1ZGeFZKOTAzMGUveUt3NjBqcFV3b0lzWGhueW55Z2VyVFk4b2Np?=
 =?utf-8?B?dzJuY1BnQllDZUhDUHo2WE83eUlQVWY1VzVEbzU1SmFsSiszeFN6OWpBazl3?=
 =?utf-8?B?RVFGUkd3a3hyM0FSakJlSk1SNDhkRFo1QWRLOWp2eExsTDRlNjRTSjZyZGpH?=
 =?utf-8?B?Mkp5dE9JQ1lMZVloVFhnOHlNUElGMnVaWTJRdlZVR20yREJIamlBYzBJU0Jm?=
 =?utf-8?B?VjQ4T2hHbmxwdkpCaHp3UEc1TDhGUWNteC9jMmowRlorRWsrcE5wTmxLTmg4?=
 =?utf-8?B?MVlBdHBvbWtpK3k5NU1vNVRyMDF0SUNDa2VCQnVCUk05SGxGTWN4M0Vjb0RL?=
 =?utf-8?B?TTY5cTFhZ3l0L3I4S1drTUFUUDBhZHpFRy9oTlJwZ2JOYkt6RHkvcTRpeW5J?=
 =?utf-8?B?RzFJcFVpcTdDYndFTFpLY3E1WXM5M2RaSEZMeGJDeSs2dUZsYkJGeXlUTW1n?=
 =?utf-8?B?dkNSM3A4OEM4VDdVdEFTVmhKNVhjN2NjRDhVd1JOQ3hPWUZRR0NJSW43MTVS?=
 =?utf-8?B?ZW5FT3dBblF3c1d2WFdJb2Z1RHB5N3FFYlNCT2ZXL3c0czE1cVl2UEFqZmJQ?=
 =?utf-8?B?SERXNnZTT3RQZGpMRGdCek9MR1V5YXZmRG1jc2xzR1o2MWNGL0Y5Z3JFY2JT?=
 =?utf-8?B?amhIVzFKSjdUOFJzTTV5SGpnTFZyZVVqS2pBVzF6SXUzWlVSR0xxcU5CN3FI?=
 =?utf-8?B?eTh5RWRwT0dsRlJ5d21OZ0tEbHNQOSswbGNQTkhmejFqSTVSQ0FQM1c4Vmli?=
 =?utf-8?B?TFJlM25Nd0QxZzNPNU9wbDBtVG9MMllIQ1FBbnYxbnFOSnVRTmQ4MTJFdmo2?=
 =?utf-8?B?RWxkRHNvSXZFTFBOajBaYURlZWo3a0tJMnI3RUxxSHFhdmRHMFkzdjl2OUVW?=
 =?utf-8?B?cFl3eXZ3KzNmODF4TjBXWDFrd0JwM3Bvd056Y2p3MW9DanRSckIwWjVyVTBm?=
 =?utf-8?B?TGJ3OXhCOVpkUmxyUlRWcHVDUVBBSFJnMUVmbjI2bDRoNGFmYVUraW00QkJD?=
 =?utf-8?B?QmExRHdHVWVPZDJRcTlHeVFOTitNTDNNM0hDQ3FKOHAyS2dKWUQ0UVNxUHEw?=
 =?utf-8?B?cUtOalVzMm1CSHIxUm4xNzdQbERWTG1JZW5qMkl5eEtTMGt0cDkyblVOWU9S?=
 =?utf-8?B?djZ1bThpdTN2NFpxRWhzQll4bG1sb2RMM0NnZ3JiZjUwcjlvVUs3aE91Yk1W?=
 =?utf-8?B?MWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e23a6b1-89b7-4e5d-aa6d-08dd916dd90a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 15:58:33.6628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HhlOjVMMYvlWla+nE4cblAwSHEuDEBWslfOLTvOWP30ASasVHfXSqBE+cGrghELUmba/HNWHvQxbbHuK2LGEXzqyYA50EmTcvagHv6yeWE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8818
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

Hi Andre,

On 5/12/25 12:46 PM, Andre Przywara wrote:
> On Mon, 12 May 2025 11:24:07 +0200
> Quentin Schulz <quentin.schulz@cherry.de> wrote:
> 
>> Hi Andre,
>>
>> On 5/11/25 3:10 AM, Andre Przywara wrote:
>>> Add an Operating Performance Points table for the CPU cores to
>>> enable Dynamic Voltage & Frequency Scaling on the A100.
>>>
>>> Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
>>> [masterr3c0rd@epochal.quest: fix typos in -cpu-opp, use compatible]
>>> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
>>> Link: https://patch.msgid.link/20241031070232.1793078-14-masterr3c0rd@epochal.quest
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>>
>>> [ upstream commit: a8181e6861fec3068f393d77ff81b2aaf4ea4203 ]
>>
>> Did you use tools/update-subtree.sh to cherry-pick those commits? The
> 
> No, I didn't, just remembered that afterwards. This would only work for
> this patch anyways, since the other two DT patches are not yet merged in a
> tagged release (the last one isn't even reviewed yet), so I just added them
> here for completeness, to give people an idea of how the defconfig would
> look like and to allow compile testing.
> 

Considering you're the sunxi maintainer, I assume you wouldn't merge the 
patches knowing that they are not fitting the expected workflow so I'm 
not too worried :)

> The plan was to maybe merge the first two patches (the DRAM code and
> Kconfig bits), then wait for the DT bits to trickle in.
> 

Sounds like a plan! Have fun :)

Cheers,
Quentin
