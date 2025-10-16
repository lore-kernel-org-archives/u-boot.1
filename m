Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBA8CCD195
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 13:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7FC4836C8;
	Thu, 16 Oct 2025 15:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="F5rGS444";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FF37836D1; Thu, 16 Oct 2025 15:28:30 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1999F836A3
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 15:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlupAHEaqJ0KhgqPoYMJ+oKj+8XbdUeLlMyBuFuBGOWTCfBFrElBzHeezuTmxcLLQNRca8J77eyrPYDrnGOyEoVH658XU2QVXZo5yenVia7qa9PyIEOb0BmUa1RHJXm3isseyPio8TU4tECu8tYcOnpSd59UAI/u4/jVl+0sUL10q57Q5mVELXoa1asqBWRFk3N/mFIlI39C6HEE9K13wSeeLYAXlJnqjwCKKXpVObg82GwjZEzwvDYv6xYvQSqd1Bl+vRinmGJ3sngKoaLv1p8F85qAZptFujJ4F5g7IPPllN3hGAtJ0Py67vMZ9AsMj2Ws2oaB8Uy49b4Ncg8sCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1HLthdrrX6cEp4llODzSxy5TbrTpbXkefNs/7uzDMk=;
 b=Enc1PIbHjKjyNB2iEUKo3wMJoJx0A222dDiYvF1M0K1xDzaavHLvXz0D6T5+w4eC6HacBH4qEgfgLfsxny0fKtmnAhSISwD5Uh05O/nNEYQ3qZDS/kezf3pVwZSlMtDx2QPcpYDyzoLH4M1s30PWK5cgGj4mdNMcezIzt+DLnndwGANJPI9xcMsyI2CRZSlKAx/qQXAy6mfsZ3ix+fhOAJLjuIqQX6+kbv8OgtY2lIxor/NZT6p2znDlPbVBu+2F1/WNzoyKmmbQDA7eIjLeNo7sDK8Kkesuum/n2c3flxfih85Lzr4L+LC+h/ISxztWNA1Q/s/ky62HSNH8OuuzXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1HLthdrrX6cEp4llODzSxy5TbrTpbXkefNs/7uzDMk=;
 b=F5rGS444rv8H7cKSmf6x6wKw2MGfG1CkOUUhHYjowujDu/if8o1L2sWDaUXVqFUqMimRmDcHxz4dL9kW0K4ZqTxNPq4k3wmfjcwbrpo+9o8ecc3QxXge/8ZHQYXqkpFPeun/qln26ZnOxnlxvdqHPWz/8sVWpcSP9aofabKwVJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA6PR04MB11801.eurprd04.prod.outlook.com (2603:10a6:102:51e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 13:28:26 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 13:28:26 +0000
Message-ID: <6e85c247-9624-472c-bbdb-b35be4fa03a4@cherry.de>
Date: Thu, 16 Oct 2025 15:28:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd/part.c: implement "part name" subcommand
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20251016125247.1594643-1-ravi@prevas.dk>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251016125247.1594643-1-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA6PR04MB11801:EE_
X-MS-Office365-Filtering-Correlation-Id: 89782d4b-61cd-4207-5477-08de0cb7e2da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEE1LzJEbm1VTlY3RXhhN2RXK004eEVLS3FHYzl0YThNWEE5N2NrLzVmc3M5?=
 =?utf-8?B?ZG9hV1ZHU3p0QWJyV01XSjBGYW1zRWtVQ2VNYWJCZ3FuNWdZV0tQRnhDbHFW?=
 =?utf-8?B?MzVYU29ScHl1NEFJdU8rQ3F0ZFZNZzBmZzdGYnR6cHJMODY3TUlRTHIxMDkw?=
 =?utf-8?B?YjlMUnJRbWZNV3NvSzRacm9NUzByTFlkWHhTSVNzdU8xdjg1enlpUDZWT3du?=
 =?utf-8?B?TklBb09xcGVlbzJyaWNzWmN6Uy9ManJLWk4zTURPb0ZBQjUwMm1GcCtEaEZT?=
 =?utf-8?B?M3JvSXpYd3RiMDkyampWRkhCcTJYNFU2dnQzTkROdWYxWGJoQ0lqWlk5WG41?=
 =?utf-8?B?TFpLYUIvb1hqa1I5VzNxNlo4dFFERTd4SWg5eTRmeGozL2hmK20xYWN0dE5i?=
 =?utf-8?B?MFViNUJLcjBnaHJ5NGNpR2NsODRLYXBDSEs0VkZJSVVjRTFrdGh2bGYzOVVF?=
 =?utf-8?B?alJpS0tMYkF6K0xsMVhqUVFYRE4zbEJUTVdXaEloRFo3WDIrRDZSOEp1RGxr?=
 =?utf-8?B?MWdOcjR0ZzlnNmRvbXNQYUYvL0YyZ2pjeTJBbkFHRmV1SHlWb1oxcHQyYlVJ?=
 =?utf-8?B?eStDNE9oc3l4WnNhQ2sySXB2ZjlUUTVYUER1UXdOcmUwQWNIR0FTNElnTEtx?=
 =?utf-8?B?N0J1cVZzemcwaFN0WHkra3krOWpzV2lLN0M1QS9EdUJ1eURhZUJGRXp6V1F1?=
 =?utf-8?B?bUxrbHJTbkduVWU0YkRoVzBJWDRGV3JVaHRVeHQyTkludHNicnRqRnBJTjhU?=
 =?utf-8?B?MHpCbkVBdEVXVlNENU0zKzdVMTM2QTNSeE9pamQrZXVRRVVWT0FkeUJUOEVH?=
 =?utf-8?B?UGpkbU9IeGlna2tGbEE3TlFJUDZ4Q1I2eTV1eUhMcjBtZkYyVVRwV1BBU2NC?=
 =?utf-8?B?V2Rmdm14NnJJUzl2V0luTFZUbFY2Z1FHay9HbGdZc01JRlVhSWdubVpmbity?=
 =?utf-8?B?YmVieHhiMTFSbmgvV1R3TlFPTW56Wko2VGkzcGFWUDRldGg2eHRmem9kU0RB?=
 =?utf-8?B?L09JM2I4UzdXREZlYkdTSkx2WlJUeVBzTC95UWk1Z1R1UnlkQnpzVUJVSHJD?=
 =?utf-8?B?UTd5eFFkOElVRDlRdk1TN1k1cDA4azBYQVU4WXpzZWJuQWNVKzJqSmJyNTNL?=
 =?utf-8?B?M2JGeWp2YW5xRmFySTdacCtMK01wWXcyMVdjQWRldkhhKy9YdHlicGZaRHd3?=
 =?utf-8?B?alE1cFFRWU9iaS80ZkRFK1o5eWFUZzNTR2pjOFZXYk9DL2x2aC9JcHMyeWkx?=
 =?utf-8?B?Y1gxR0hha29JR3BFNWlFZEkrRU9yeGhGRktIR1MzVWRmc0NreU9GNDFhaWJk?=
 =?utf-8?B?VzZjUkZSMzAyRnlRSGRLS3d2YlZlL0x2VnE0MUE5SVZ0RlZWcGdGaEI3NG9n?=
 =?utf-8?B?NmNCNVY2Q0RabmVPMTFLalRUK3ZueEVUdVhHRlFSTVN6T20zRVJzSmVXOUl4?=
 =?utf-8?B?OWd3ZDJlclRjWk9iUWdxd04wWjNGT21qbThMelNPZWtpeC9sU3NXQy9sUjhp?=
 =?utf-8?B?aWM3R2tIMU04WkhaYzZaRW0zZVRiUVgvdXo5U3RhSjJNVUh4WldYdHB6Z0tq?=
 =?utf-8?B?alNYL0g3VUxIT3RuSnEzSmhhTWdSVVZ5dnZkWGQ0NHZZVGgrcWNxMnBLblNq?=
 =?utf-8?B?dGNYU0gydkUvS0JYT2g0MUliVDlabldLNTEzQWRwRFgyZGlSTkQxRnI5azJy?=
 =?utf-8?B?aGs5c3hQUUZZTGtUOXFMMFIzS3owR08waE1KTkhCWjVjclEySy9OaW5HTm1u?=
 =?utf-8?B?ZDgyUlR6YlcrNXhkMFVITk9TQnRBdHpvRVVmWUtpeW92RGdsVEFySFRTVXBj?=
 =?utf-8?B?YmRuZnE1V3d2dkNhQWNjcDg0TlQ4cVpHZ3pZdUpLL0s3djI4MktoUzc4dXlY?=
 =?utf-8?B?UHI0L1A3MXZKQ1U4K1REenNVZkh4b0V3UWFmWnI3VHJHRG1WZ1NnZ1B3eFFz?=
 =?utf-8?Q?eCVV41Rz44akInXr8EO4vOluGRyXe6j3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnJkenJwV25iaXgzS1NERkswUWg1WXBMRmM5aEhXeCtqdml1OFdaWjBBVi9U?=
 =?utf-8?B?OVM4OFdwQXdvMzAvN05ZdUZZeUJ3N3J0VFM3UUZJaDErdXMyRGI2Z1FlcHZ5?=
 =?utf-8?B?WHRlSVJUUTIzNHNmc0xYLytHcTRVTUlHdjl6Und1ZS9Hc01hM1pUMXR1S1lR?=
 =?utf-8?B?dVRVQTBqMFZnc1JLOEhJM3N6YWlwY3dDbWJUM1loZFVNM3hRdkN1MHhBdjUz?=
 =?utf-8?B?OVVEWlY5NkIzWXdVVjVMcUhJS1NrWU9MR0VjQWdvaTFrWWFXSkhtVjJKZGh6?=
 =?utf-8?B?cHZmbm02YUJYYnJHTEs4K2xFbGZhMkpwc2M1N2ppRTRvSXp1N0VodzQzQUFn?=
 =?utf-8?B?S1oxWXpKVFc1dFVoSjdvNWNYTHBnMGlyUXdOeVFNSzg2VEpuMnE3MzIzYnRC?=
 =?utf-8?B?WFBIT1B3SkIrVmkzSEU1ZVdtN0NrVlV6S0ltdGpxa00yeVovdGhPc2MvY25p?=
 =?utf-8?B?b0U4QldQR2ZRbEdwdWsxL21zMXlwYXY1Z0pzVzVFRnp3N2NLZ1ZEVlN2elQ2?=
 =?utf-8?B?Y2wvOHRubmlGTTcvRkJ1YzljQWxKdEsvVGhhWDdXdEpTb0ZWQnFTQzBmTGc0?=
 =?utf-8?B?MEpnQmRYS2RYWjBhNSt4WXBBU1h6dFF0OEYxRG80cHVLby9ob05uK3FTekdT?=
 =?utf-8?B?TGlnOEhZNlZmalZWcno5Rjg0QWFQZzEzMHBST3Zrem4rcGdMYmJWalFXOGlS?=
 =?utf-8?B?c0lPUWNGNStiUDVzQk5TemJLUy8zb2dnTWliYkZoSVZsVjJXek5rR01oSUUw?=
 =?utf-8?B?dDRjMExuT2Rqb0NQWm9nb0hPVU4veFI3dE5Jc0NIWW8yRWF1UFJJL2lsK01t?=
 =?utf-8?B?YmhzVnFOR2ZoMmw1ZjRkdUNBQ0RaV3BVZDZaQ1A5bDI3YWFwc2hrdjY2ZmU3?=
 =?utf-8?B?NHdxSHpSR0RUc0htNVlTT2RNSTlPbHdCU3pPdDI2RWp1SG4zcGJiTkh6ajdV?=
 =?utf-8?B?N1JuSGo0TWtuRitNTzBEaHlHa2p0T0EzS1doMjNuQ3R4UjVQalIrOUpLcHVU?=
 =?utf-8?B?OHhabS9qaHFkbmZUUXIyOEpsc0VlcnR2eGhCWHdHOTdEeElRUXU3QkVJRWxQ?=
 =?utf-8?B?OVdXbFdqVWd5UWlxK0FISUE0YTB0dE5JR1N6TGhZbXVCdTJyS3FOa25ocEFx?=
 =?utf-8?B?bkhUSkNBcExySzN4cXVxc1FzSEd2a2UzYTdMZzRkZytyNHFhOEhNbXppTG04?=
 =?utf-8?B?Q2xhYkNCYkpsa0FGRWRIcnJyaEdzZmN2Mm40elhCcDVQMG1hcll1aFcxUUMz?=
 =?utf-8?B?ZUtncmF2YnZ5TmhkVC9LQjFiWUxPRHEvNjlUOFFKZzBRRmhFbnB3aWdsNFJZ?=
 =?utf-8?B?dkxPMjVzdUdvVmxxcHhmdUpGWjZuSzVHVzY4dkhDNzd2RVJaQmJvaFBiWnk5?=
 =?utf-8?B?cGw0UEVyRHBRVE9OeGZTMFlzajlia2VpcGtTVGlIUmxqbHkyZFBXQ3h6Nzdq?=
 =?utf-8?B?Ymx1QS93YTVmd2hDZUhBVXpxakFNdFNmQzUxVTh5Q243MVEydTN3SnRqeHNs?=
 =?utf-8?B?LzFQejNRYlQ4WXJZdXBNQVVoY0pHMjNYMWRJbHVqVDNYbC9jWlk5K2V1dm5V?=
 =?utf-8?B?RG5jS2R6L1c3NnJ1UWZnSDA2a0xQbElzRzhWb1prOXZrcmY4Q1gzMmlEYkI3?=
 =?utf-8?B?UkhxQ09HdVk2cGkySTRIR0tTK3RoT1BYY1FRT05oUE43bnB3SWNxeEMrYzYy?=
 =?utf-8?B?MnlmWWVwM0dGQmRyV0J1VW55MHJxSWNvQW9Kc0tPa1VVOTErbzlFeUl2YW5t?=
 =?utf-8?B?SE1yQ2VLVE85YVNZd0p4M3RSWkNUVy9RR3g2bTBWR0NDWWFNeFFFeXR3TmZX?=
 =?utf-8?B?cGZ3MTA2MTNZMUYzdFYrVHlBRTh3cks4Z0dzOXhFWTU5dm1maHdPNEF5RGJ2?=
 =?utf-8?B?Q0ZBZzBXT2I2a3BhaVQrQlVaNkJBYlNoZjNRSUxPNUZDemtzUy9WaEJxMGY1?=
 =?utf-8?B?R3JWZTFIampVUE5tTEd2dm1DZ0R5UFhCNENDRUE1QWg2UEhVcDV2eUhsVGFD?=
 =?utf-8?B?RDNKREF1TmtmUHVMWUFzdHJjRTMwYXNsUC9YZnZGUEJnYWVTSmNZQUM3VmEr?=
 =?utf-8?B?cUszUE5mRDhhYVhaZU50UVBCaEYvRWQ5L0tVSFducWhsaDE0VjNMUm03Q0lX?=
 =?utf-8?B?UElEY205am1MY3NkQnZ5VHlaeENZNWJDRWJoOUp4MjNFellhcXZBM0c5ZHZV?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 89782d4b-61cd-4207-5477-08de0cb7e2da
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 13:28:25.9957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckUwzIE1iEk6b5bxB/zV2OJfZ3J+YacZtH7/EZ7LhUV0MaoPpBtt9P/IEMfGnBDTS0y8FK2/Vu1Cgui+pmd3+HoKgV42WgRDTXwu+tFtwWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11801
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

Hi Rasmus,

On 10/16/25 2:52 PM, Rasmus Villemoes wrote:
> This is a natural buddy to the existing "part number", allowing one to
> get the partition name for a given partition number.
> 

Can you update the documentation in doc/usage/cmd/part.rst as well?

> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>   cmd/part.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/cmd/part.c b/cmd/part.c
> index db7bc5819c0..975a0a08a99 100644
> --- a/cmd/part.c
> +++ b/cmd/part.c
> @@ -25,7 +25,8 @@
>   enum cmd_part_info {
>   	CMD_PART_INFO_START = 0,
>   	CMD_PART_INFO_SIZE,
> -	CMD_PART_INFO_NUMBER
> +	CMD_PART_INFO_NUMBER,
> +	CMD_PART_INFO_NAME,
>   };
>   
>   static int do_part_uuid(int argc, char *const argv[])
> @@ -154,6 +155,9 @@ static int do_part_info(int argc, char *const argv[], enum cmd_part_info param)
>   	case CMD_PART_INFO_NUMBER:
>   		snprintf(buf, sizeof(buf), "0x%x", part);
>   		break;
> +	case CMD_PART_INFO_NAME:
> +		snprintf(buf, sizeof(buf), "%s", info.name);

Is it possible info.name is never set by the fs/blk driver? Should we 
initialize this field?

Cheers,
Quentin
