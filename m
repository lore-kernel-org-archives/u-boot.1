Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D65C27C43
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 13:02:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC0168844E;
	Wed, 29 May 2024 15:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="abzKDihh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 365038844E; Wed, 29 May 2024 15:02:33 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D31A7883A1
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 15:02:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMO+OVU5MQjyl5Of/GDLdKMipTpVk6TAqNJ7fuwjOEXJN7NF/kooyXwvuE7Xx4eTCunD/MSKLSIJQBbtZyOrl4BX9X90eksyptg9civTMrrkUFS83SdqF9tt8gqYpkSC6aTFDsSZmOjAoXnencHRNQlieIc+v0X7y2vgIfnNT/IogjgacLW6trHBvmAhmE/zfzdZ3wLZS+XnFErolkhUfn24QaMFTifAjSjUvzxfVIbsDx5jNIASMDrWqXWBS5KUk4vKGKXFdM0Ts56WnKXdXORzVX/Kgm56pkUgqIgeVJAQzo0ZpH4Uaj+FoOIFmWB26P46JiKoiI9r954rV1NUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7LjUPXHZqLUb0mDcm0rIig4s46Rg7wZ4gHk/9ztOzo=;
 b=YhAulg8B90TgrzmfnCKE01j4IHUNJaRWWFf4Wcuo1DuM+Sjmizv6KOfX0ZKU3nd24hMqiEBV/7/ZajB+GG2ZkMOj8r1JexYG1ZuDnlALGNPLCu8eGjEWaYFtNW7AvNjPoDIFyjHr47OLH/xBeFhfuda6p7K0ZmWcYrn7LC/o9qsLu2K3kdcDSCwehAOwYxZhq6muiiYZ4Q9yvNzdtxJBJVkhWz8lvstq7rr6zNMhhCpe/zp1AvrRzIyfjAuLqmPPDkbxHx0uFjcsgdkdi/V15UHz5CQdemK2XOVrFc81DKatFHsCKVBNBg692bVulAh8WPlHyFldG1BHkDtQjzVrsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7LjUPXHZqLUb0mDcm0rIig4s46Rg7wZ4gHk/9ztOzo=;
 b=abzKDihhiRh1wWrDK14J1lu8Cu6a3Q4xmnHOX3Bmt9w6b1PD1UXJihZAScn++LyRaAhw76QJeAhC3QTTxNVpjhyQYV48tOLv8ADP+6kgb+2xocvqjhqHAWWbps5IDldusQmjBk710ZfH9vDH+LhYonXrueEquBj4s8JWQ5EmuJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 13:02:26 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Wed, 29 May 2024
 13:02:26 +0000
Message-ID: <e8b985c1-2868-48c9-8bb2-64ccdbefa7b2@amd.com>
Date: Wed, 29 May 2024 15:02:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xilinx: zynqmp: Allow multiboot environment write even
 in saved environment
To: Kory Maincent <kory.maincent@bootlin.com>, u-boot@lists.denx.de
Cc: thomas.petazzoni@bootlin.com, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240529100107.137159-1-kory.maincent@bootlin.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240529100107.137159-1-kory.maincent@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::25) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: 0631150e-0e4a-4085-d94d-08dc7fdf96b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmNtclRXRjlHUjdHVmd5V1QzNlJaMzh4dFBaN2dtekg5bVprczlocTRLZW84?=
 =?utf-8?B?U0VJR0FlVWlRSmlNUUVwNzhyNFB5Z0hmWnp3cHh5K3B1VXdCc21IUzJKdmtl?=
 =?utf-8?B?SGFHWm5Sa2g2YWo1R3NmZVZlcGVkT0lPNUQzM1oyMEwzLzc1c25GcytQSUMw?=
 =?utf-8?B?bkV6RytGQzltTkFxQ1YrSlNiODlqMHBTTXM5N21RVy9lMFZSM0Vwd3lPRkJX?=
 =?utf-8?B?NHNadVFsTjFkcGJuM3NjbVFpQ2ZoNDE2cFZNcjc0NGczdTZmMEZaVWE5SEZD?=
 =?utf-8?B?eFBIa3ZrQiticlp6UE41dmszT1VSQ3lkZkNZSnFiQTA1T1J3Tmw5R0ZjNTdB?=
 =?utf-8?B?RFU5T3lkZmRpY1U1VVVqcG1IUzduc2l3TWVEcFh5OVcvZTcyMXBFNXJFcGE5?=
 =?utf-8?B?RmZPRXJaRjdjZWdVTTlMUCs5VTJuSnEvTkVLYW12S0pLYml6c01vU1ZveGRz?=
 =?utf-8?B?VUJRMi96dUdsYlcxV3hqOTdmcUcyTVplSW5RemNteDNXRFRGWWJXY0NTRCtQ?=
 =?utf-8?B?L0dzak44QnRhQWtNTUo5RC9ZY2ZySklKanVDb3pOeno0aHRNcFNwMmhyNjFh?=
 =?utf-8?B?LzlyVHoweHpaSVUxc1RSL2ZvQU5FZC83Qk1kMTkyOGd5YkVtcXR3blFyTlNG?=
 =?utf-8?B?OTlyNU4rN1NNMmZWM3NFMmZ4QTdRZkp5RzlxRVltaW10aFhEQmhZMEdTMVdN?=
 =?utf-8?B?aklwaVA1MGZsbFZZSDNtalI1YTRncHFkTnprSGlkVWVjTVhxUXoyY1RUWnZ6?=
 =?utf-8?B?ZzFMUFBPT0J1UlhoeXVETG9RWTJlMlJpZTVid3ZxOW9pNitWSlJTUmt0OWEw?=
 =?utf-8?B?Z01uM3pRQ1BBZXI0S0s5WVJNRlpZTGV3aHgvSGdaa3lUamZQemJSMzIvbGdq?=
 =?utf-8?B?ZU5VQzUza1dGYTFVdFNXOWpQRHg2d2NWd3JpdzlvRWxaUkI1OW5MdmNheFVo?=
 =?utf-8?B?Uk1KQkN2Z2NpWVlOZGlXK1NpSGpZQ2Z1M05JSEt3ZmJlaTF2aUp3ZDhiaC9X?=
 =?utf-8?B?QUdjeFF4WnFHNnB3aFgyZXc2RnR5cC9WbGwxRHhDQlpwSFpmVFlBSTVrV09m?=
 =?utf-8?B?cm5YYURnZCszU0pJS1pheFdoN0RxZkV0VlZFUXRlNzdyY0xscytld091WnhW?=
 =?utf-8?B?ZWhrSCtlUVl0NFpCVTFicUNEZFFac1B3VDJneXExRm9XcjBlQlNoYU5HM1hX?=
 =?utf-8?B?OVc3QWsvUkZRVUNmRjhsOUFUcGxwYmEvL3R5Ui9iVDZSeEhjUk15c2wvN1BR?=
 =?utf-8?B?dzZhZTA2c2JacGI5clBXb2YwOE0rR1BsNW51R1laVFkrQ0NwV1FTQUF6WjZZ?=
 =?utf-8?B?K1NwdkgzWkRHQ2EyUU51TGdJSWsrNGI0ZlpkdmNVTzVlYUJsZTRkdTZQOGVD?=
 =?utf-8?B?TWh1Z0tYRDBPYTI0dzdvZGllQzlBbWZ4bHZoWFZiOHc2RmRGa2pEWjVXbHVy?=
 =?utf-8?B?OTk2N2EwVXdQNDBZZ251dENGdUR1UVQ2STg0Y1Z2RU8xSG84YWNyVmw2dmtO?=
 =?utf-8?B?dVplSEdmVjVVd2RSYjFUQVlnU2JjZHNudXNUaTVQU3dIbUNpZGZhUkdMZXN3?=
 =?utf-8?B?RkVmVE5NY0NhNnBIZ2xaR0RYWUFUTi9tMnFlNUlRSldvRUNldVpWOXNJbWRu?=
 =?utf-8?B?QlhIVUtQVFVLaG92Q0k3eDhucWQ4VGxkMElhU04rQ1FHVXR3NUIxNFc2TEZk?=
 =?utf-8?B?L0JNRWo0QUs4N3pnaHlVWUtUdVpUcTZWWWFYU21DS24ybitTaTV4T3BRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHRmbENDcjNqcnNheUk5V2N6cHJRZWoyTGtPVlk2U0tRNElXMDluak11NVBT?=
 =?utf-8?B?MUc0bi95Q1M1c3g1Rk1GaUVEbXNsUG9qNmJCcEFUVmhURWR4NmgxSzd4VWpI?=
 =?utf-8?B?MktkUC9VTXBtWUVZNmxwUWk5WkZycWVLeGh2VTkvZmI5YkdCdXZkenBLWmRt?=
 =?utf-8?B?N2c4WGI1Zm5sR2podVJkWDNrNmlneGFxOEIvQ01wcmR2aUtyakJkdDFkSE16?=
 =?utf-8?B?aURtaUo3Y1pZK3ZJQUZhdGpncVVKWHEzZXJvREJlVWhpS3FpczV1Vnhub1FC?=
 =?utf-8?B?SmNVWmtWL1dTNEROSkZ1YWRCaHRqY1pOdzRHZG4wcitoZUtwYXBsdkpqdFVC?=
 =?utf-8?B?VWZqSHVEb01xS3h0dmlFVzk3aHNtMWtXMXErdG9pQjQyOHJETjYzTEI3Y1FQ?=
 =?utf-8?B?cjZ2YThBMXdyTDlyanp1UWlNOWppVFNmSHdCaGQ5bC9TUFFzN0tPTlR1Q0Zk?=
 =?utf-8?B?U0padFBUQTJmNWVVRVJwd2J4RUlrWWdnaGRDR2tIRWN3VnR4RWp4L1N6NkhE?=
 =?utf-8?B?b0VUMDRwNkR1Z2RFS1NFRnlNUENuRktqSGFKYy9rT0RnV1V6dXo0NmlYSWFm?=
 =?utf-8?B?cDFjcEVaWlZYcW1LZjIxR0VqRnJpVGlGTVJUYWNUMEpmTElENVRvRTNqcCtY?=
 =?utf-8?B?SS9HYVZjaVVZR2hSU29SSmRQalhkMHpOTUdLOGpDbk5YcTZjYXpxS24rdDhS?=
 =?utf-8?B?Rkc0VHhGYmg3LzcxcE14OEpaUDUwd3BLTEp2eXd3R3RYK2NqZkd5YWtseHQr?=
 =?utf-8?B?ZFFIM09iOHQ0OEVmNm9XV3ZQSGJVWmcwSUNQMHlNT2NsczQxRGx3azVPV2w3?=
 =?utf-8?B?S3lNcUJqQTFGcTNiMTFHN3BFd0NCb3JyTDM3bUw1MEVveW9vS01mREFtWG8x?=
 =?utf-8?B?VzJlYVZQelRMVC9LREk4bW43WlNEOXNFb04wMTZBU0hpczEybHo1b3FZZlps?=
 =?utf-8?B?bHlSNkNhRVYrVUxNZGtwTXlLWHdsejU0R0ZmdmZGdTU4c09vbS9ISjMxV3hE?=
 =?utf-8?B?NVo3cUo3UkdGODFiTG1mcjBjT2d1L3FRdUY1VlNNVGMyMEJtcXphcXJXQVZQ?=
 =?utf-8?B?ZmVNU1RtRzZObnJkYUdMZGtmc2c0T2dCWWtkVitmbDlrS2NwWW1QcW9WTGlC?=
 =?utf-8?B?OVFzWW5YYVUyMUlSWS9kYy9IVU1OMk93eG16N2lVZGdJbUsyVUVZRk54QXVo?=
 =?utf-8?B?dldURWI3SnphM1JTQzFocG1jSkVXeThhdy9GV3pCYTVUQThoWWJoS1dkZ3JK?=
 =?utf-8?B?QTZOZXpUbXU5anNTWFRNYVZUZndwcndDZUp4Ym11VWYxTEdmMkdqQy9hWDJy?=
 =?utf-8?B?Y3kwS244VGpvbjZYc1h0ckpCVzVVZ2hTMzB3di9NU0ZQd01SSTZ1eFJBQS8z?=
 =?utf-8?B?Tmt4c2g2T0prRTJpNUh6K3NCNm9ORmE4NFVUd0JUK1FtUHl5TCsyR3ZGSzM1?=
 =?utf-8?B?blg4N0tSNGRydW15VUxhR0ZmckVxaldZNHlZSVZTWlBmc01qRURlSys5a3FW?=
 =?utf-8?B?Y2JYMjhYTkZnMVpHb1Q5QXV5U1ZLbjBwT016SUUyZHd0QThaVXo5LzB4WC9S?=
 =?utf-8?B?Z3NpTlEyS2xGYlRQdHROTUJ0RjF6RzZReXFaMVkrdlcxN1RzRDhxUWYxMHFM?=
 =?utf-8?B?Zi9vNDdpQlZRd3ZBMEp4d3IrU1d6V3FYOWp6RW1TSVg3MEgzMGJoQnlRc1NC?=
 =?utf-8?B?ajVOWjNOR3IwWitVeVkxMVRJWGtTZk90VEVYOG5oYmlPak9tOXB5T3MwMkhP?=
 =?utf-8?B?SzQyWDB0anU3RjgzdVlIWmZTbDQ2YWNyUkdJODdxSzNZVmdSUWRUUHIrREpG?=
 =?utf-8?B?SW8wQjlTaXRPWjNhd3pvdlJIZ3BGMnRLZXZkZkd6VmhvTUZVYzFIb0hHV1hD?=
 =?utf-8?B?UEtjZ0hrcTZSd0VXb2ZyYkFDTEpQRG1yc3lPOU5pNmtJU2NCTmQzbGUxZ2Rz?=
 =?utf-8?B?Mlc3Ykd4SjNJV3d6b2orVEhDd1BWbDZTOTU3UzlZT0FWOUdmTUdyTEJ1QUF3?=
 =?utf-8?B?T0RxalVEb2Rwd2FQUHVNTWJ5eWMvajc2VkVtbkx5Mk15aDVIYmdEL1NWS0VT?=
 =?utf-8?B?RjlxaG91ZFNQcjFyWExNWmxlckI0YzV1Z1BheFNHSFg3Q1N0SHJVclNLeEk5?=
 =?utf-8?Q?XLmYZMiXJVJrvG9xyG6oW7OWd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0631150e-0e4a-4085-d94d-08dc7fdf96b0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 13:02:26.4743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrlF2wB4CsYd4If67PwBqdchSaUwIOrz8+TmUzTieNvc8zd6NpdgTJnHKleUfg5t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
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



On 5/29/24 12:01, Kory Maincent wrote:
> Once the environment was saved, the current multiboot image information
> became unreachable. When dealing with firmware updates, this information
> is necessary alongside the saved environment to know the booted image.
> 
> Move the multiboot environment set operation before the saved environment
> check to ensure this information is always available.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Change in v2:
> - Fix nit in the commit message
> ---
>   board/xilinx/zynqmp/zynqmp.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index f370fb7347a..16292ed1c7e 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -519,6 +519,10 @@ int board_late_init(void)
>   	usb_ether_init();
>   #endif
>   
> +	multiboot = multi_boot();
> +	if (multiboot >= 0)
> +		env_set_hex("multiboot", multiboot);
> +
>   	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
>   		debug("Saved variables - Skipping\n");
>   		return 0;
> @@ -531,10 +535,6 @@ int board_late_init(void)
>   	if (ret)
>   		return ret;
>   
> -	multiboot = multi_boot();
> -	if (multiboot >= 0)
> -		env_set_hex("multiboot", multiboot);
> -
>   	if (IS_ENABLED(CONFIG_DISTRO_DEFAULTS)) {
>   		ret = boot_targets_setup();
>   		if (ret)

Applied.
M
