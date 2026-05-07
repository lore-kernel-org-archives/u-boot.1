Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F4FCD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 11:01:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F085A84A85;
	Thu,  7 May 2026 13:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="cPsbm2hE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CDEE84A8E; Thu,  7 May 2026 13:01:46 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FD8484A81
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 13:01:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=go5Ur3jXWzAjLcqEqMGpHNf+4TRyKa/WXuBoEw98V1151YiyCYTlKnflu/SbEYjCkSeLgs267kv9dpiAN+R1+o+8ouSx5ZN8I6gmavSwjbhbmx7xL2w6bsThVZKx/kxVkDk1urXpn+fPY8HFPrSVltm++QtQMmcWfiGKQWuOFFhLOOrkmEQ19cQ5A7MwaMXum8fazFmbosKd6AUep48sgo7xFNKEUVIJH1NvduIeSl9c9+E3NHqAOtvx/Zcjj6/+q8sBfCd9bz/Glp3S3iVqjd6+3HiSRM+gLz3D7tRdQRv65XbbS89lTga8xtcnuPB31Ii5tOhxy3HGUNprWeRcBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEa2rFsbDQcEJ2eLo1I2BHL+L7+htWt+68pkO31ZQGI=;
 b=UpQMTbcf6ex22BcZNG2YPbhqJRuztUHEjq5Eg45eZyfikZCepFYEKOG5QhHc3e3ky/UGLCwVyR5Xsqp6C+N/SXuQKb0pg7H/2ur6GhVqDCovX7WXxF8PEcm17g3TjD3LXRIbUv8f1iNGEysPBBAcoV1otkkWwqPrms2lZwCMwyJbipARX75Y3NxPM530Q+n8p9BvSoXu2/GRIfBFThCtTR7bggzy/AyNDMhNAi3Fr4vIisRpeal8XOP6XRZlQmvJUWnyD0ElVzsrZdOeEL9zrpwQ/mpSCxZJL8WCcq5s48qXM17ocnI8fvHk4whVeq72mwrdbSA0668XU14dGCugCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEa2rFsbDQcEJ2eLo1I2BHL+L7+htWt+68pkO31ZQGI=;
 b=cPsbm2hESm93XYNTY7APUv+oOaKqa0bewYruxgMWfji7DhI4eXBsDc1SNEqKcyhFlMubNjdqMu3B6SYW+QGDfXH7MB3CwUf0bzMU/5N111wxG6AIcmSan7j0hc0xyu0OezEHgbQ6Aj/0N3h1T9D8u6sFCDskHlZTiM2k1H2KO9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PA1PR04MB11406.eurprd04.prod.outlook.com (2603:10a6:102:4f1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 11:01:40 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 11:01:40 +0000
Message-ID: <453e3e7f-e975-42a6-9f44-5aaa9a5fd03f@cherry.de>
Date: Thu, 7 May 2026 13:01:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fastboot: read fastboot buffer address from
 fastboot_addr_r
To: =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
 u-boot@lists.denx.de
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
References: <CGME20260430201556eucas1p21ad12913ce5c83e8bf5cef3c4f50d81b@eucas1p2.samsung.com>
 <20260430201503.320359-1-l.stelmach@samsung.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260430201503.320359-1-l.stelmach@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::19) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PA1PR04MB11406:EE_
X-MS-Office365-Filtering-Correlation-Id: 7933bde6-33d2-4d5a-172d-08deac280402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|4133799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RBENWJd+D7MuBnwVg+jxSyVZoO8Li0WjIlmKI6NGj72brqpzgNEnq6dkKwq0MH4PbLXAvtDC8KSwJTAuXSebpESdesG3J2cFKYnHz/fdaGsOSW1nsUtcgVr0PHU7QZ/DMRMq2gXY/ls4X4X1hxiMIDgX4WMvq/Gth3i88Ht0rG0Ee2ecW9BGHDmeG43eisjqgkDsAtDoJH9utrFoHw0FfCSrRp802yrbyrXTJb23t5HlpLXXdDf0JLwKpicinLy5QuF+/YLatgE3+YaV4wtQC7xUMsfYwNb5bHQN8X383VwoFUMgF7PeIG95SbfdKKOaB5gJ20gSHiWiq6hQ1pbGk8YLVrerBHf2In/vycbA402FSXU1kJZVPf0Mk1tzekpkAhnFEzpgdtIqs23bIrBETh3IiGAHlaHdx5cm3y/+xQ/HEh8Y8bm1Q1L/5S2/4rB/iqPK0knTROJEhN5vE6GDLUzjpJOJ3RJZfDuhCNUZ1luMlXtQfCFxqM03WH7N6b7caUBH/fX27FoaJrIHRZRsvVIErwC1KdcS2zw7+URljEMiRW0eVlBp6MXEE1wNGNvIJX0RRVrHZgFf9UebLR4p+nlQHm0ARAZX8njJWXe3JXY9KP3g56vDZ9VDswSXw8su6XfgRJYysC5gO6VwwFnFco2rc/x1S6VO+eO+sr0WRbeQ1joXDwArPHT1pLDiSaZ9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(4133799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmUyL1N5RFdmOVRtWEY1R0NwY0ZuNFlKeW5Zeml5KzJ4MnJDQVB3U1JrQml1?=
 =?utf-8?B?aExNdzY3emt2ZnJyaXU2UzN3N0ZjMkxYSENSRWZ5TVp6NjhFaFQwZU9YdEhZ?=
 =?utf-8?B?WStXRzFXUGFNT081NmpBVjJhWVZhdk1iL0xsRFN1bVJBR1ZSK0VNZVZsdVA1?=
 =?utf-8?B?MnhlOWJtcUJtcEdEMVF6dzlaM29ZNXUyZkFjcmFXbGtJMmFBUzZHYTBMb0lS?=
 =?utf-8?B?RWR1VjdoUVJLSWlGNjZXcHZJQXREdkJvK3VDNVNTZU5LVHVabGpvTm5OQjQw?=
 =?utf-8?B?NGpHa2Z0enk0K2xSRVRlMzk0Q3pOREFMWFNVODQxKzE3SWU2Z1UyNDZjbU9X?=
 =?utf-8?B?aW94Y05KZnIwd2czb1pvOVFZL3BIWTRMZWN1MFdOS0E5WGRLMWM1aExOMXJa?=
 =?utf-8?B?SkUxS0cwTHJweG1WS1M3ZWh0Y2pDWEFkbEhMVk9UV3MwUlZJWk1xVy9vKzJ4?=
 =?utf-8?B?TUpBbGxnNDlvb3NBWU5sM1kxKzY4MnJGaUlITTZTbXRqWGxoQU9wRWxDV2VG?=
 =?utf-8?B?QVhnL3dzMXpoL3ZlYXhFYk9MMzBNa2NWaFdmMzVnVlVDdk5EalgvNFhwbHhN?=
 =?utf-8?B?Nzk2enZVNkxtaWFyQzdzSC9SL2o0c2p6YUtab1JqaHdURjNiWmZRcUVTVlM5?=
 =?utf-8?B?WFVZNWd4Q3loMlRxSFFSL0R5SWhybGdkZG1GYmF3a2o2eHRrVGxybUxuL3pB?=
 =?utf-8?B?dE1SbENzbDMxcVJYZXFpNlgxb3d0eDBlWGFFN1NLQWM1OEhhVXBIVEVEYkov?=
 =?utf-8?B?R2ZwU0JKQnpvYStPbmsvd3kzZ3NBcjZKMjBTaTRQMFo4MUxQV1RhMmtraWJn?=
 =?utf-8?B?K0d3U1MzV0RlR3lPV2pxSGd1YU5zOXZXVnNzMFM4UTBneUUvbnpzSklaNERW?=
 =?utf-8?B?UHRGTCtvVXhBaWVHM2ZKaWthcGZUaUh4NWx3YnVWdGZYa0laKzJnV1pSNm13?=
 =?utf-8?B?a09oTEpTTTVJdWdsVXplZy9lMGhBcWk5dVhIaW5oT0FOaHRpRVRPTld4Vmdm?=
 =?utf-8?B?aUgwTXlFeFFHNWNQTWsvZXo1aHBqK0N5blF6UUlDbkV5Z0FWRE1RNHAzYWQy?=
 =?utf-8?B?VXVDbEZWUmMrVGl0RTd5RHd2Z0ZDVVJYNzZmeGdMbjZNenN2b3AxcStpSjJT?=
 =?utf-8?B?bzFTalJISzlxdmR5VmVtV3RZVWZSNEZOZElidWp6U2dtMVgvM0JCV3JIMVoz?=
 =?utf-8?B?U2g0WG9EU05NeWNnTWVzWEYyY01uWVFaNm1oK1RhWG1LMGxKU1p6Z1dyOTVK?=
 =?utf-8?B?ZExaZmZvMDJzd1E3dE5lK1FYSmtBanlOWjdBSzdianI4b1M0bFlRR2RNalMw?=
 =?utf-8?B?MVpNV1lMY2NWcUkxSi9VdkZ6QS9icVI3OCtWWFFSb0l4eUEza0xhYXJRb1c4?=
 =?utf-8?B?dDA4WWtOczRWYm8xUnlOeVZSUnRtZXlCUkZrYkpVZEp6M0N0TzZoR1ZDdDJV?=
 =?utf-8?B?Tkp1TjdPc3hJZ3BLa2t3T0htcGVETGZhMTJMTitNbzF6YUxtS1U4SU43WmxQ?=
 =?utf-8?B?WHBpTEZGV3d4QkVQZllzSnQ3NHJCREM4K3pzWmZCNTVzUUtDdWw0VC83SFRx?=
 =?utf-8?B?WHVqSGhVUUJ0Wi90ZVIyaENiemtCMlIrbkRFc3ZLY3hYVUNydTJhUDUrNVFB?=
 =?utf-8?B?aTRtQmFHRzBTNHFkcDlSTW9rREVNSjl4d0lBcms0MGE0ME9OdjdKeDNSK1JY?=
 =?utf-8?B?Mk5RdmlYMFRBSm9scFkzczIyK3NqTG5iU0hjNXZZK2U1SkkyRnlxQVdBY3dC?=
 =?utf-8?B?bjZyVmNna0l4RDVrZTlBUENDcVJ1QW5SQk44Y21yVFp0Zk1vWXFrMnVBNlR2?=
 =?utf-8?B?MzVaaHY4VENzT29pNG1tNDVoOGlnNDYvWTJKeUZQbS9kdXNHR0RKN240TmYx?=
 =?utf-8?B?T1VTUTlBREF0cGkvenp1UUk4b3pQRUViam43dCt6OUM3VkZzS04xZ2o4a1Zn?=
 =?utf-8?B?ZXNHajY1MjNvZlFkY2Z0Y0xIbnpkejFBclFKTmNlcm1pS0R6SzI1SURYZnZw?=
 =?utf-8?B?d1BIeGZZOVBqcGdTOVM2ZktVZ0NuTnNoNmdab1NlVnhmamNrd1loMWhsSk0r?=
 =?utf-8?B?Vmp4NDJ1N2ZTbDNRSk9hcnVxTk5JNm5xVldXbXN0YTVkMkhXM1NhSG81RDJB?=
 =?utf-8?B?TGlRemEwbThuL3ZYQ1NiNXRISlAwOC82OUhTa0pzTmkrYXltdi9LaHNVdmoz?=
 =?utf-8?B?cXNnZHRVbEJaQyt4QkNpTEhkVzNaWWI1S1VIQzJrMXNFZEswb2xLMElQQjJB?=
 =?utf-8?B?NHN0QWdBSFBZRUdJMW5BWlNOMTJLUk5ZSVNTVWVySGVGa2ZqTkdBb0tIS2NF?=
 =?utf-8?B?RmVOR0pvazFqbExTYzVnQ2RsaGQ4NlZlcGFXTkF6RXZQdlNOQWwwUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7933bde6-33d2-4d5a-172d-08deac280402
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 11:01:40.0428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrR+SsH8/kUCUr5onJbZtFdQET1RngWPQGgPktFW2HGBM5B7/7lhF2nSVo77nmyQTy/Jzi/Lbzqb7d9CFxIHtE5IvEPdwezquLk2Lp1kzRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11406
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

Hi Łukasz,

On 4/30/26 10:14 PM, Łukasz Stelmach wrote:
> [You don't often get email from l.stelmach@samsung.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Following the previous advice (link below) check fastbooot_addr_r
> environment variable for fastboot buffer address.
> 
> Link: https://lore.kernel.org/u-boot/aWiWFrdwvy7-IK63@sumit-xelite/
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>   drivers/fastboot/fb_common.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
> index 68f92c4b887..4579f30b52e 100644
> --- a/drivers/fastboot/fb_common.c
> +++ b/drivers/fastboot/fb_common.c
> @@ -226,7 +226,9 @@ void fastboot_set_progress_callback(void (*progress)(const char *msg))
>    */
>   void fastboot_init(void *buf_addr, u32 buf_size)
>   {
> -       fastboot_buf_addr = buf_addr ? buf_addr :
> +       void *_buf_addr = (void *)env_get_hex("fastboot_addr_r", 0);
> +
> +       fastboot_buf_addr = buf_addr ? buf_addr : _buf_addr ? _buf_addr :
>                                         (void *)CONFIG_FASTBOOT_BUF_ADDR;

Nested ternary conditions are unreadable.

I'm assuming this is the same as

fastboot_buf_addr = buf_addr ? buf_addr : (void 
*)env_get_hex("fastboot_addr_r", CONFIG_FASTBOOT_BUF_ADDR);

?

Cheers,
Quentin
