Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC2AD44D57
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 14:35:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A74588DED;
	Wed,  6 Nov 2024 15:35:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ONDhv4mt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0011A87E30; Wed,  6 Nov 2024 15:35:14 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 005AA88E89
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 15:35:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZhHX3t85V0B/Nbj6s3KMs2mwrgej5i1RFQugIsozyl6QSBmzfdXguV0lGjtBMRNjiQEghTeV0A1L33jf0M/BSXIgTrX4ofuQEeX/kz4Sv/uLH8yhb3H2LtR5wcRumxUsHTCsKIShsM0S35LBFQpGrP/THu+1vChakDD3OupL9sUkCoLZjzefeX6u3DLl2tTelhAOH9kCQinBvO6RbUqtOvhABc9f/dEh7r/astLaXSm1jFDe+AAxdBAls1+vlBlc/kdOlH0+Gbz0UZM5dYkWqxt5NMSjqenCx7eqQc0GXItA4rEq2mRPB/SOUlvY0tF5CgVypvDJeFSVw048DAXGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=conRTubrDBeU1oM8jZkydzS42weMitKnypp5eL1SgyI=;
 b=DD9mMc/dAALD+I9FbmqYqj4mChf/ijijcH1bePthUcwGGm8CaJyWylbtZnChUW9+2UbOfoHv/PUqpWgTs/4lpDo3o/TmLzR1I/CKtpV74JzFCvnrjBd8NUlRsvkRWIBxgDwdjQzjIQcq/uudBZrcrKW5KCeutrvpOO+PBV6rdIYOCIi8eCurRXOZEndgIySZ2VsA2GyKtnlg2DfQ2GC5p4AoCJG2L0EpRrECpKlvDB01qh+Zp5d23PLMCLw5fZxEQnlQ+BpNmIdLUWrUpwo16SrV1R4AoqrKwwaznsjxeOIw8HHwJtVqMLbryaKDXyNO5He2yQZB8yOjfiq7fbhFAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=conRTubrDBeU1oM8jZkydzS42weMitKnypp5eL1SgyI=;
 b=ONDhv4mtPhZS6TM4aE1Oi9nlj811EF/FsX+TC7Jc7kstSh5xdpDRr4CA17vSlUBOt60H6+KdWjRruflaBDgTvA9SuZ6UuBtDfs7Zh+UYN7uLI3vtrZVYRNoV6GFjwD8Ljhj6dRUH/HlVygYLefRwYI53EG8iQG0HhDPKF3mowWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB10965.eurprd04.prod.outlook.com (2603:10a6:150:207::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Wed, 6 Nov
 2024 14:35:08 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 14:35:08 +0000
Message-ID: <980f5b97-d82b-412c-9450-68271ebc8ac8@cherry.de>
Date: Wed, 6 Nov 2024 15:35:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rockchip: rk3288: Use rk3288-cru.h from dts/upstream
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20241104205906.986837-1-jonas@kwiboo.se>
 <20241104205906.986837-3-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241104205906.986837-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB10965:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a27622c-e414-4f68-e810-08dcfe703674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aU1nT1dxK0xGZkFCK1N4bXJGSEtSMFNQOFl4QWZWS3lCWE8zU3VtaS9BN3M2?=
 =?utf-8?B?YVRzTXFCZ04rUFowN0NwVDhySzIyMllaRS93Qnk5bk5mYThKc2NEUXZlMmI1?=
 =?utf-8?B?NzdYZTFBdlNIWGY1dEMvaXYxQ3NzTXFCVEU0d2VEWSswUGQ1L3ZaaFp6eldv?=
 =?utf-8?B?QVJjYmZoSnIraDVkdHpkNFl5N3RxbEkxTFJEL0hpYzJSV096dVNBUE81K3dn?=
 =?utf-8?B?VzhES25DYU15NzE1VFhIQlpRNFJtK3hRRW11eFJkNERQKzArMDljTkZqOVY2?=
 =?utf-8?B?eTEvWWNsRmRQOWlTOHZIMEo2dUNURFNQakZndTRMTE5kMDUwS0dBeFg5YlY4?=
 =?utf-8?B?VCt1MXdWL3hjTng2b0t1U2FaQk1lWFlwREkwZDd6cERkNzlhSDFsV2hISThS?=
 =?utf-8?B?dU1TRkM3ZkpDTDc3Y3cyWVQwUzYyWnp0cmk0NVhxT3pEbU5IeUpCNERzMW9x?=
 =?utf-8?B?bWJNa25TUXU4amExa2NhR2ZtQlNhUGwvcVUwZ2RHYmRUcXVKeUtGOE10eC8z?=
 =?utf-8?B?cTZwQ3UyWHZmYmNFTGU4eHNObFIzdWVvSFpaMjZwcTZ2OC9ObjZDSzdOczZa?=
 =?utf-8?B?QitiSXd4OVYyeTI4eHVxRUpYMnZpYldRcWtSQk9YRUFoVkkvVnRURXB3M3BX?=
 =?utf-8?B?NndoOHJDelRESmwyOEVoV3FGTFhXWjJXMnBFbU5PSmV5YzRJRjZzU1czNVlY?=
 =?utf-8?B?bmVnTGprZnloSTlWNFgxSit4T1RURmt4Y0pXRXUwTVF6dEZ5b1pDRWZmWVFm?=
 =?utf-8?B?WlJ0UE84aUowdW5MSlEzZTJaUFh6NXlobU8wN3hETkFWN3E0R1pYVjExWHov?=
 =?utf-8?B?emgvQ2JnYjQzR2xQRkd2ZVZVY0liVTZwbHFIYnBBS01IZDUyQm9UK3FNZi9E?=
 =?utf-8?B?dHVKaTFicEVXQkRlS2t6ZUNOdWlDTER3QkJybDQ4eWw2K0h6RkY2ZWV0RDZ5?=
 =?utf-8?B?WTR4WHBqYWZwVGdWNC9zRS8zcVNMaERXNlBlQ0RWcXV6eUFOaGt1eFdJMWlY?=
 =?utf-8?B?TFlVMjYvZVZPb09zOG04MDRBSHJmRGtjYkpPVnBTV29oeXBON0M4Z0xWb2tn?=
 =?utf-8?B?aVMrMVRwczdEZUVxRDNWSFRiRVJBVVZXWlE0WXEvYTN1aDlRR2NxMnpKaHZD?=
 =?utf-8?B?THREc05BaTBxeFlXanpZamlhSURpZEFZVVR6UEd4VEV6Sk5BK3dHVjJUSUZL?=
 =?utf-8?B?YzB3MDZaMU1CL0Z2WXdXK3dVdkJYdFdYaTBsZVdjWnRabFZsSCtoSjRQQUdX?=
 =?utf-8?B?bmVNWjA3L1ZYU3h4K01QR1pZNVVEdnFHUmdKWHhQbnNqeXlDc0dSTUVJZ0dp?=
 =?utf-8?B?WnZYQUVwQ1Z6RWlPOUtHV1RvdlcreG5hR09IU3pRdG4vUjJMQmY3TTRIaGpk?=
 =?utf-8?B?RXg2K1IveURzUC9HWG13TVVWUG9ZbTlQbkR2NWFEaXdoV3RQcVFyRXhTaEVW?=
 =?utf-8?B?clpFWGQ5eDJvakwxZUU3S0RHNDlwOE1ZQU5VeWs1bVJ1TGVHV0hiWmdiM1RI?=
 =?utf-8?B?blNHcFM0R2hDRzVoWTM0VElxWHZxL2ZFRWlDZkVQbGtxTHIzYjlBbTl1RnRI?=
 =?utf-8?B?QytQcnBRSUNsdE1EeHlWek9NbWJNL1NKc2tPWTdUYnU0OTJMWXBPZ2YrSUVj?=
 =?utf-8?B?WXVKS1E0bnZnS0hPWTVueWprdjZPd1Vyck5LNzMyUCtEZ2tGSlRTTHBFV1oy?=
 =?utf-8?B?MmZHNGovckdiYm9VQlIzMVBjQThHWmJuS2FGZUpvWmZpMzhxV1NNYVNpenVu?=
 =?utf-8?Q?iBnZVc+wXPlIecj2p3LA1Gr8K4/E88QGSgcwB4+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1N6UnR6TDdJQWhzdEZsUEphc0gxblJZRUtXWUhVcmFXRHIvVFU4SUl0UWhJ?=
 =?utf-8?B?NFhxblJzV29IN1RaZ3FDVzBDNytFL0p6Nkpqa2k0VjZLeG9oaGpZKzcwRjl6?=
 =?utf-8?B?OXhPR1loMmh4UXBUdm5xTlBXOGhReTFsWEtXblJaU2FsZGFlaHdRYzdYbUVl?=
 =?utf-8?B?RzZ0Qk1CdzBQZzVSWWNienZsblFuYWc1UW5SeGZxTUtEN1ZETnoyajJsKy9J?=
 =?utf-8?B?d2lnZlZVQVpUMVBVZWl5TEJrbE1Gek9QWmRJdkhQYStZL3huNFFsbkQxQTZo?=
 =?utf-8?B?SVd4SFdjbHRkems0d0RwNGdkSm5JbDV3UmUwYkxsUDJHcGdBN0J2Z2JTR0R0?=
 =?utf-8?B?UEErcGNIbXRXRWw5RVBPczNzM0dUeE5MaitsYnozUmlRZ0Y3aTVGN3lISWdN?=
 =?utf-8?B?RExsdFRmcEg4YVpOOHY0dnRQTUxCUmM4a2hUVnd0bWRJSTFMbUl3NTlZeDZE?=
 =?utf-8?B?U1N4VWFCTm1tYVdHaCtUUzZQZkxLQlVKVVpoWmVBNVNPMTNid3BsdWM4Rllv?=
 =?utf-8?B?VWttZGw4NDliUDBWNkdSMWpqekNBQW00S3dlWGRZWnFTWDkrOVEzNFV0U1BV?=
 =?utf-8?B?bDNiZXFrNlM3ajI2VnE3bXpGdGlITkwvM3pJTmIrZzZIWitnaUQ0VktqS2g2?=
 =?utf-8?B?RlhIbTVHYlhINlJiOFFXVDZBNUNWYWJReWhjOE0rTkVOSSsrZjhXdS9HQnZ3?=
 =?utf-8?B?U2loRXNZaEhXK2pwTE9ZTmhWVDBNZHBTSVVibUwvN0dRaUIzd3UzM2VSN01z?=
 =?utf-8?B?TVZBWEdpbjFGUzIzNGIvTFlrRDU3NTZFSys1cHpCeGxZRzJTbzhsckdKandJ?=
 =?utf-8?B?STFLRWIxRmVIcXdxWDdQVFZyNXVHSUVwZzk5QjdZckhFRkZFQ3o3UFMra0Vi?=
 =?utf-8?B?ZGxxbFlyYk1CTE55MHBtajhnTjhHQjFTRGgxVWorbkFVVHZpWVFvUUhoY2NU?=
 =?utf-8?B?eUJXc2VTTFF4bGtMRUVYUEJoekFJakRFREZMbG9pa1dYT24yY0Z4QjNNZ0VZ?=
 =?utf-8?B?c0tLTU5CYm1OSng0eDZDYWg3dG5KWHZkdXVZbDJUSEVxVjdWVTRUYU9pWlor?=
 =?utf-8?B?bXRYejBxc0ZLRXZNdGg2L2RXK1l0cmZOeVIvSFM5aHhhbVBzeENsOWEzM3hk?=
 =?utf-8?B?bkgwNXNSVERTaVEwMjRpTjRKdUdxbmFsVWZXbEIrZ0hnTHNELzNGdW01Q1RK?=
 =?utf-8?B?RTlUM2ZEZFd5VjhpRWNoMWw5VUVUQ0RoK3FzbVcwK0JDUktKRDdzMWVhTXFy?=
 =?utf-8?B?N25hN2lXSUFhMTIzTzQyL3FGbmlCalQ2elpEYmhTM2dodVhVaVRNZG9zU0ha?=
 =?utf-8?B?OFpUQXFIcGJ0aU1xT3hkNzlFVWRIenRNRzUza2czdnppdkd4YmNJcHcvdWFF?=
 =?utf-8?B?THc5U3NtV2FWWXE3WFc0S2drc0g0emZ0a0MxSjYvb1V1S3h2SnI5MUhCa2xX?=
 =?utf-8?B?eUJpS2dCd1hVczVwT1ZzMnkxN0tWM2d0cXRMcTRQSks4aEExUTI1WDJGeVIx?=
 =?utf-8?B?UlQ1amVHSk02aThwVWpnMHRmR2t6OTZQaHNVd3l3QVIwZ1pBUE43Y1Bub1c0?=
 =?utf-8?B?TUNJd203bTJOTVNhK1dCeGovTGtSenp1S2pKZ3hmY2JmZkZ2S21Kd3pnWVV1?=
 =?utf-8?B?N2ZEVXdIWGV5bWgxZWwvMUN5UThJYW13dGNyVThkdlBZNFlEK3QzcWYyQ3gr?=
 =?utf-8?B?K0VmZnhWaEpROUZEVkZTK21zVHBUdS8yR0ZWaExDRGVkRHlMSnhQVjJjR05V?=
 =?utf-8?B?VUxmbXR3aytmM09iOXNEZlhhTSsxQUgxZWhVWmxWVUl1L3VvY3N1dEpuVWJB?=
 =?utf-8?B?eFpYZDc3REdoaXZGK1AvdGpWUzQ0Tms5bXVoNHpBdVRlSUdmTThPTXMwV0tX?=
 =?utf-8?B?bnpzbU9sbW9ZOXQzK1FXWVlQS1lMdWV2eXBSVzRZTjJRWTZBcEp6QVV1bTFR?=
 =?utf-8?B?WlFoS0FXNjlqN2NHOUZiT1B5czNDcDNWRjlRbHI1ZTEwMXZUK0pYL3VZSkgz?=
 =?utf-8?B?VEpoMXFUbFVES3laL3l1dm5tS1NuN1d0YVZ1T0dJbzM4NVBmWnFrMzFndHZm?=
 =?utf-8?B?WWJrWEwvR0s5NUFjaStzdWxEZVI4bTFNMm0rbldzeGlaOElHd3RoNW9tMzd0?=
 =?utf-8?B?ME5iNjE2UUNLSEdnQzExQS9yTEhkenh1ZTB0TVA2ZXVYeXpPRmpMU1U5OXp5?=
 =?utf-8?Q?vQJY1MTxWNeHzrHoMjUNoGc=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a27622c-e414-4f68-e810-08dcfe703674
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 14:35:08.5677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgkEDCwtjD8H2AN3YwtfC3BaTw3k9lnuvKvbF8HzyW9JwoRGa66+jXZFaZfHmrA3Io6f9kystJWjBb5bPt8d8evwvOk22UsrxtxfodUHX6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10965
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

Hi Jonas,

On 11/4/24 9:58 PM, Jonas Karlman wrote:
> clock/rk3288-cru.h in include/dt-bindings is almost identical to the
> version in dts/upstream, remove the copy from include/dt-bindings to
> only use the version from dts/upstream.
> 
> One clk, SCLK_MAC_PLL, is not part of the upstream bindings, this clk is
> not used by any upstream or in-tree DT. For now just ignore this unused
> clk and only workaround a build issue caused by this removal.
> 
> No functional change to board DTs is intended with this removal.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   .../clock/rockchip,rk3288-cru.txt             |  61 ---
>   drivers/clk/rockchip/clk_rk3288.c             |   2 +
>   include/dt-bindings/clock/rk3288-cru.h        | 381 ------------------
>   3 files changed, 2 insertions(+), 442 deletions(-)
>   delete mode 100644 doc/device-tree-bindings/clock/rockchip,rk3288-cru.txt
>   delete mode 100644 include/dt-bindings/clock/rk3288-cru.h
> 
> diff --git a/doc/device-tree-bindings/clock/rockchip,rk3288-cru.txt b/doc/device-tree-bindings/clock/rockchip,rk3288-cru.txt
> deleted file mode 100644
> index c9fbb76573e1..000000000000
> --- a/doc/device-tree-bindings/clock/rockchip,rk3288-cru.txt
> +++ /dev/null
> @@ -1,61 +0,0 @@
> -* Rockchip RK3288 Clock and Reset Unit
> -
> -The RK3288 clock controller generates and supplies clock to various
> -controllers within the SoC and also implements a reset controller for SoC
> -peripherals.
> -
> -Required Properties:
> -
> -- compatible: should be "rockchip,rk3288-cru"
> -- reg: physical base address of the controller and length of memory mapped
> -  region.
> -- #clock-cells: should be 1.
> -- #reset-cells: should be 1.
> -
> -Optional Properties:
> -
> -- rockchip,grf: phandle to the syscon managing the "general register files"
> -  If missing pll rates are not changable, due to the missing pll lock status.
> -
> -Each clock is assigned an identifier and client nodes can use this identifier
> -to specify the clock which they consume. All available clocks are defined as
> -preprocessor macros in the dt-bindings/clock/rk3288-cru.h headers and can be
> -used in device tree sources. Similar macros exist for the reset sources in
> -these files.
> -
> -External clocks:
> -
> -There are several clocks that are generated outside the SoC. It is expected
> -that they are defined using standard clock bindings with following
> -clock-output-names:
> - - "xin24m" - crystal input - required,
> - - "xin32k" - rtc clock - optional,
> - - "ext_i2s" - external I2S clock - optional,
> - - "ext_hsadc" - external HSADC clock - optional,
> - - "ext_edp_24m" - external display port clock - optional,
> - - "ext_vip" - external VIP clock - optional,
> - - "ext_isp" - external ISP clock - optional,
> - - "ext_jtag" - external JTAG clock - optional
> -
> -Example: Clock controller node:
> -
> -	cru: cru@20000000 {
> -		compatible = "rockchip,rk3188-cru";
> -		reg = <0x20000000 0x1000>;
> -		rockchip,grf = <&grf>;
> -
> -		#clock-cells = <1>;
> -		#reset-cells = <1>;
> -	};
> -
> -Example: UART controller node that consumes the clock generated by the clock
> -  controller:
> -
> -	uart0: serial@10124000 {
> -		compatible = "snps,dw-apb-uart";
> -		reg = <0x10124000 0x400>;
> -		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> -		reg-shift = <2>;
> -		reg-io-width = <1>;
> -		clocks = <&cru SCLK_UART0>;
> -	};
> diff --git a/drivers/clk/rockchip/clk_rk3288.c b/drivers/clk/rockchip/clk_rk3288.c
> index 43c44fadbe7a..69a2a9429ffd 100644
> --- a/drivers/clk/rockchip/clk_rk3288.c
> +++ b/drivers/clk/rockchip/clk_rk3288.c
> @@ -902,6 +902,7 @@ static int __maybe_unused rk3288_gmac_set_parent(struct clk *clk, struct clk *pa
>   	const char *clock_output_name;
>   	int ret;
>   
> +#ifdef SCLK_MAC_PLL
>   	/*
>   	 * If the requested parent is in the same clock-controller and
>   	 * the id is SCLK_MAC_PLL ("mac_pll_src"), switch to the internal
> @@ -912,6 +913,7 @@ static int __maybe_unused rk3288_gmac_set_parent(struct clk *clk, struct clk *pa
>   		rk_clrsetreg(&cru->cru_clksel_con[21], RMII_EXTCLK_MASK, 0);
>   		return 0;
>   	}
> +#endif
>   

I don't really like this.

Could we simply remove this part of the code in one commit explaining 
why we remove it (in preparation of syncing the device tree and because 
there's currently no upstream user of that clock). It would make it much 
more obvious from simply the commit title that we did something more 
than simply using the dt-binding upstream header AND also would make it 
easier to revert if anybody ever needs it.

Another option is to upstream that in the Linux kernel first and then we 
don't have to work around that issue. That may be a bit more difficult 
if there are currently no actual (known) users of that clock.

Cheers,
Quentin
