Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4833C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 14:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C2B4881DB;
	Thu,  6 Jun 2024 16:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jxkVr75K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C02798823C; Thu,  6 Jun 2024 16:51:30 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 899CC881D3
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaY/xEN7FtHWQmucsQfdR+CRCObn1nzxEPALvqRJrcfxQQcBKYshxUHJ+JMKvcBPkDktVr9YZcL51LuQv54tjURXiQrkn/VXXdxQXasidlexsR2hah81R5HaWW1cFNq/OyfSrnA3sRxIf+dPiC/j0m0D1Xe1KjCgCacaFVOq7mwkr+83kegs9nUjVkuwiDKlwqDVn616r6n3d2KEvd9YMlYiQLJKnw3PWR7ePLyEELtHyEDPsY8vf49HreHr+lbW7KelTvtvhxh8bbnUBw847QqXYfTIZZHwT5dgVcT3/XB0YBa2ElcMJCOmuyu4jmh5ZiSyeVPDPI13RDTUpTw9QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9Y3EUVsEOwsLpqHgOFOfIfAiaV2ru3+t1cEs+oxURs=;
 b=UdGOshyq3PKWJzJNF/v/4W0FPfZ696VU8aZMovOI5JPKxKQaUKhMLfvgna56EQIEnyEeT9SWhImDR0rPcBgrEXpruoNwT7f+b/mPz7HJmCcRzlqOhiEtrCVyocbXMQq0Hm1jZbG26M7e4B1pwEQETWj0S60qHDqoBwXvEY9KeO6JrOXKraXD3cFfLgeQOnwbrSE4DsE5LqAdEXAekGpujcqohj9x3hSSTzClnYUAOjanZWY8zS0ZyhJoua5fe0gwmD8HMGvobyuX4BYgeuoQkid5GFjxDCgfQ2Yr7XgliHTpnXAW31PiM2gDaE0hGRhZHM9BfeQq+eAu6Vrr8I1nQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9Y3EUVsEOwsLpqHgOFOfIfAiaV2ru3+t1cEs+oxURs=;
 b=jxkVr75K4lDGwoX+5tBl5gEIvDDbdlH+fPN3xZUBYkWonAmXEHldgZ1LYydtxh8H5Sk7gdDkieK0RKy1xJMc5wlDYnuIY7NBtId8RQ4vjPbOugbVGseEf45PjgAcUFlyxWkkZJ18wZuZnljj84g8E7XFaJc+stgPIoXINM9W41E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 14:51:25 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7611.016; Thu, 6 Jun 2024
 14:51:25 +0000
Message-ID: <2c147e8d-6bb5-4391-8e27-6cb42675d87e@amd.com>
Date: Thu, 6 Jun 2024 16:51:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] xilinx: zynqmp: Enable reset_cpu() in SPL
To: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>, Tom Rini <trini@konsulko.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240604135915.405660-1-lukas.funke-oss@weidmueller.com>
 <20240604135915.405660-2-lukas.funke-oss@weidmueller.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240604135915.405660-2-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0066.eurprd04.prod.outlook.com
 (2603:10a6:802:2::37) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM6PR12MB4481:EE_
X-MS-Office365-Filtering-Correlation-Id: b21299d3-9f30-4ef9-b46b-08dc86382350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RG03SVFFMTVuSWJqSW5pU05XZXZmY2p5anBrTDlPalNkdWlZd3JHNGVkdUFl?=
 =?utf-8?B?TURUME8xUllwQkYxa2I1c0RtUnlyZW5kbXpMMndNV3RBU3pyRnlQZjFrSkVr?=
 =?utf-8?B?NHRqTURxUlNpcXZldFZHaTJyRlo5TkM0V0x2UVlaRWJ4RzJVR0hxUlZ2ZEk2?=
 =?utf-8?B?QU5PTzQ5bXpYeHEzRVlrL0I1b1g0aGF2YTJGMkFIU1BZbzZaOGNHVHhhU3VJ?=
 =?utf-8?B?SlBKSXE4NHpESjQxNTNOTlJEYjNGbGJvcWNkYmdzUkdpZU5rSEVwenZZc3hn?=
 =?utf-8?B?SU0wbzRsckhMOTBvQm1JWnpMRjdicUl5MS9aUFJBMW13eWE4YkkxKy9QbW9X?=
 =?utf-8?B?VzU2QUFqZmZpNTBKQzRyZDUrRlBpVEYwb1kxTEdpR3JPVXhQWTFvbTgvd3pG?=
 =?utf-8?B?YWdWTk1Ja0JWOHZxcFQvTnhjOXZjWm5IRUpqQWRtVmpnR25tTWFRTno5aFR6?=
 =?utf-8?B?MWFQdHpJTTl0WHpoUnl5WW9HeGo5TW9VUS9WSk14WUh4Q3JRWnloQ0FVWjgv?=
 =?utf-8?B?QVgwQVZ1dDBFdlJkZ1YrK3hRMzRubWczS3JTYU9MM09RYXFNSFROMXBsc1Rz?=
 =?utf-8?B?OEw1S3cxTDZQblZZSlVBVUxyTXBOV090MVkzbkhkRGxvNmM1aVh3bXBDd1BM?=
 =?utf-8?B?TzJrdGhLdGpGUzQwV3FDMEptOE9xOXUxbmlFbFlyQzgveHZUNHE2NlUwRTB5?=
 =?utf-8?B?YkVNakFUTm9lQzRLQk9uYjhzb2lISWk3amxCT3JNM1U1Syt0NWppdEtDVzBU?=
 =?utf-8?B?TnBIT2lPYWV4Qm5NUFVra3NqY1VEYnQvM1pRM0xzMk1lR0d5MWR2NEhkNEJU?=
 =?utf-8?B?cFoxSVRiOWhBYlBWbzFJVUcwc3B5UVk2OFFvY2E1WXBnSlNJMDhsTGovaDU2?=
 =?utf-8?B?VXRaR3Vlc1h5ekVINk9SamFYYXBOMFJ1MG9vcHBaNysxTmM0K2t6OHVEanpr?=
 =?utf-8?B?TUVKV1ZWK3RLeGtWemxoeURsUDIxUTFadnJWc3h3RjRPVzlrNm03WGdGTVJH?=
 =?utf-8?B?bk1pWmFES3A5QkRjWEFPQnVxak1Wc0VrNmtGU0FKREtSc2k0ZXNLRFVhdU5x?=
 =?utf-8?B?cW1BUlRDT0FFM05SV2tjanBuRS8zaFBPdHdTa0xIbjlWZGtEZDNiYU9PN3JH?=
 =?utf-8?B?NlRkZHkxSmhsaC92VjVpVGR5eEZaS3FvQklZVjRvaXVTR2JsVFE3OHhBOElL?=
 =?utf-8?B?aGZRRU9QWURFL3lxVmVsQ204SCs0cFNyV0dGZEpxWDBQWnVGUzNya0hua0Z4?=
 =?utf-8?B?UzFndGVSb1hoaXFMcURzYlk1aXYxNnNPVXJLcCt4MlV3NmphOVdRbWhiUFlo?=
 =?utf-8?B?WXlkdDZzMmhvb1RaUEg0eGdaSC9JTGNJcldjT0dTeWVNMnNxdkJTa1J2TGFK?=
 =?utf-8?B?OVhGMkxqRVJXbjJTWSt2Um02QTVMSUxoc0d0OEZweWpGN2NRNlVFcERSNlBR?=
 =?utf-8?B?eW9GTlFObVJhNzhCOWtJcGl3bG9GYUtxWUltd1paa0hjVDhteUtkQkVTZTZa?=
 =?utf-8?B?Tmo1YktROEx3aXpjWWpKYXBzQkVUVi9YVGF3czFzQ21KSGhJcHkwbTBteElo?=
 =?utf-8?B?eFY2Z2N1VytUL3ZtcWtUODl5cFZ6MUg5UjVUWjZFbi82S093V1FhaiswM3dr?=
 =?utf-8?B?a1FoMWRNRzM5TUxHaTVER3lDcmMrbngzQ2dRZTNUMkM5cVp2R3RxNzhOeFBE?=
 =?utf-8?B?ME5mbjdKaDZST0R2VnVuVW1COEZkbE8xeDhBZGVwbXJENG9KQmt1akRPRnZn?=
 =?utf-8?Q?LM6dnC0T3X8o77VvA8bwUZyQGVzu/UCx9d4rOp3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WERpNHE2V25la0t1UC9kVVM5OE9OaDJkdkh5aGlYZ25FbStkVndKKy9MNkdN?=
 =?utf-8?B?RVFaa2RuNEZGbEgzUHNCR2svc3dCVlBlaG51bnFObUdzWXlvRWtBUGFpb05i?=
 =?utf-8?B?K2IxbUpEYnBuam1QNFhZOVU3VE1BbkZpSlVCVDJyZTZRZTM4ZkR5a1BxTUt0?=
 =?utf-8?B?YTZNeXZEYnhFa0dibXUwbFpNT280ekFYMG9NeFo2SXFwMXM1RUdDWjhkZGtX?=
 =?utf-8?B?R3p6Uy9xVnE5NDkrazExK2FYekdVZzZRL1Q3YWdPVzVnUGw2LzAzblNmaS96?=
 =?utf-8?B?NWZUSWxaNjlFUjFKckgxaXhVYTZleTFQcjdSdFhmUXBFenNJYzE0S2t2Wmcx?=
 =?utf-8?B?NUJkM3NHQjlXZ3A2bmdmWmpNR2MxZUlzcy9SL0gwMW1DMlQvRUVnNDhFV05x?=
 =?utf-8?B?ajJYcG9NSjEwem5UaDNNMDV5SXJQQnNjVzhFWU9WWXNxYm9NR2FaMXh3QUkv?=
 =?utf-8?B?YnZIMHZ6eHJkNFVtcmpTcGhmcW1xQXJoaVl5RHhZd2xTYVhSdHpqVFhVVXZK?=
 =?utf-8?B?WHowYkpKVUNqbTFwTkcwbkxDVGZGdjhzNkFGVTlrYjBUSHluM0hEdS9wN3lX?=
 =?utf-8?B?RlVIdnc3K3RJV0NxY2xSOHZpUitjdnZQUnZGZWxMSElESVFyZk5iRlpTanpI?=
 =?utf-8?B?VklvbHpkdFl6c3NHdHhpOVhmamZ5dTBsTi9YUWJvc2NXV1NMZnI1b0VsRGMy?=
 =?utf-8?B?WlBhMHBLZ2t0Y0g1UFRNUHcyKzBTZUhBUWFFNFQ4S200LzFObENpNlNsK2JJ?=
 =?utf-8?B?eFFlYnB5V3kvdkNxMm9hYVJpUi9ZYmJOUDdVdXJjTkFiSjlhSU9rVDZJN0FE?=
 =?utf-8?B?c21RLzY2UjBLNUNqYmJ6UWZMT1Jybmx5THZPU2cwdkdwRi9XMGRJTDlEaDcz?=
 =?utf-8?B?dTB0ZWp6SGY2blk0OFJuVmMxUDBJM2d6TWRzQWZUcTJ6TW1xRkRhMGhhengz?=
 =?utf-8?B?QklLUXluaWxTYlFORFlGTkRGVDVDZ0lzRFF3T282UGhteGpTaHZ5aVRnSGRZ?=
 =?utf-8?B?QnEzMDBzSHdYcmdOaXp6dTJ2R0ZEM2czajdyeVEzWEJxQTNkMlhESC9LZUM1?=
 =?utf-8?B?bU1HNGtXVGIvSHdPWnBtUFgweThMTnAyVTJYRC9HUEszUlU4UFdCODd6T3Yx?=
 =?utf-8?B?RVArRG1heHhoQ0x5YlVLTWE2Y1p2S1lzMnJ2ZFZZdi9QMXArL1U1ZS92blBl?=
 =?utf-8?B?a0FMcFVSQTI1dGJLallMTUkyTUZhaGpaY1RrcTFFTytuMmswWjBack1KOEJS?=
 =?utf-8?B?bitvRHBtMVpic05NNnBZUzhIUEJTeGNFNCtidm1OcnJUTkhUT2p3OXUvVFpa?=
 =?utf-8?B?aERFZCtqY0FWNVFHeEZnNXo3WTNsaURJZmlFZ1dhS0lLT21MblFCN0FKdUtY?=
 =?utf-8?B?U05TbFRxNURaV2dseFNUSHFoUklCdGRWSWMxc0dQVlo4VVNqdFpqeTZzeGg3?=
 =?utf-8?B?S0R6SGN2c2VsZDJKQk80dHN5ZGxLeHhkNDJuN0pBMkViNlFYV1ZFbmtWOGZB?=
 =?utf-8?B?SWxCUk1ncE50b2NDMXFQTFBUOStrQ1hNK3NnZGtKTHh5UnlUa3hvKy9CUWg1?=
 =?utf-8?B?Wi9WNXo5d3VQTC9rN1FNOGRmMFVnR3NaZUM2SnA0UldSZW5UWUY3Q3NGaXZ1?=
 =?utf-8?B?ZmNtbEd4WWhZeDMxaGliRFZPdUVDWDkvRjFPVUdocVlXTGw3K1BrTkJPeFpv?=
 =?utf-8?B?ZFkyMTA1V2svbUVJWVFXZmE4V3RHZ3VSWjBFYzk0YXE2NHBGOTdYNDVFNGtK?=
 =?utf-8?B?SEExV2ZPcDJuQTE5RmNqV2xNNlhndS9jUXc2L3pxQ1JMSDlyZWNOZURFZS9D?=
 =?utf-8?B?TDRMelNXMGVzWU45T1doc0J5VzRESk0xakcwUTJVS0p2WTI5S1h3cm9SUlo0?=
 =?utf-8?B?c1ZodS9XZmpWTko2emdvb2ExYVpQVFFRbE1jdkZEcVl4QzVxekhIQkZyZjBr?=
 =?utf-8?B?N3VvYm9oMHNSSUExZkVvTUk5bHdJZnltUTR0U1dueTlSVHU1cnNnWjZqS3dZ?=
 =?utf-8?B?R2hNZ2ovRnljOGFjOThwNjJNWSs0aEt3QlJzcTZ5NWFQOHBBbVU4NGNsUWdw?=
 =?utf-8?B?SEp5TGdLQUlhdVlyY21wODlkQnplZGNjdGxPL3V2NWo0S2t5T0dJRkFLK0pI?=
 =?utf-8?Q?q1UxwiT9C0R8H+So19/Fh0iNO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b21299d3-9f30-4ef9-b46b-08dc86382350
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:51:25.1151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bFsMO4BlLTuX60lZ+A3no7uSVwrZYObmr9b5DY9KwpaSmdversiohuWY9kc9/rc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
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



On 6/4/24 15:59, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> This commit enables SPL to reset the CPU via PMU-firmware. The usual
> reset mechanism requires bl31 to be loaded which may not be the case in
> SPL.
> 
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
> 
> Changes in v2:
> - Drop 2/2 since reworking ZYNQMP_FIRMWARE dependency is out-of-scope
> 
>   board/xilinx/zynqmp/zynqmp.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index f370fb7347a..a129b1dbbbc 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -40,6 +40,7 @@
>   #include <linux/bitops.h>
>   #include <linux/delay.h>
>   #include <linux/sizes.h>
> +#include <dt-bindings/reset/xlnx-zynqmp-resets.h>
>   #include "../common/board.h"
>   
>   #include "pm_cfg_obj.h"
> @@ -285,6 +286,14 @@ int dram_init(void)
>   #if !CONFIG_IS_ENABLED(SYSRESET)
>   void reset_cpu(void)
>   {
> +	if (!IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE)) {
> +		log_warning("reset failed: ZYNQMP_FIRMWARE disabled");
> +		return;
> +	}
> +
> +	xilinx_pm_request(PM_RESET_ASSERT,
> +			  ZYNQMP_PM_RESET_START + ZYNQMP_RESET_SOFT,

Isn't it easier to use ZYNQMP_PM_RESET_SOFT directly?
Also you can remove that include above to dt binding.

The rest looks good. If you want to make nicer I would put there a comment that 
in case of !CONFIG_ZYNQMP_FIRMWARE xilinx_pm_request is not present compiler 
removes it because of return inside if. If defined in SPL case xilinx_pm_request 
will send command over IPI.

Thanks,
Michal

