Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A250DC25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 22:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DF71882BE;
	Fri, 31 May 2024 00:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zPI/VEBM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2620884A3; Fri, 31 May 2024 00:16:43 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 241AA88246
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 00:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tanmay.shah@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnoIXS1s387lUDeLqUgAcGSVpaGBVVK8npEcm79sTT4ztrXYj0whYkbTp6vzhS9QvntwMC0VldE1STjnkWoTfPv7DooKLrO0MwOt59yiPnjKzcff6QPM0gkGe3eVQAQKZH4Unn36WVXzZu10+joURNUOpD4/lJFp9FtGw9zMaQXdxbq2cwwiLoyq9PEVmoeTlPxhRj0U5CfLCWq+xDvPfqehbK2smU93e8h5COS5X/AkcpapBAOjU26Zm2fx2wh22fPaq5XbR7y6feI1mJOdVRWwmMGAm3/Wwq5SvkIyxipgGy+Hxkdl+7fH3Ri5eeVszg8zTqAps4LBdjZ/R5p3ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2Fyw+ST6Fm1IK58ral+DgV+4JR00lcj/ZbFlNgzdSs=;
 b=Wb+rVf4xHwUurXf0U1sGT6eevC7/LAdiymW68/WHWV0hEFPSTDgrM2KT+JCE1scAE0WLLresviNlpBWk1LzJFYlByLpPeNY5rPgDAwrX3czeTvzrMYaCqT2m6GwCsOM4I9krsoNEsJph25x7tXNUqBYpocoJpxFvLfnJd+npFAq1GuG6cMNwo8iViOaud2Byl7yUQF1iIs+hxJGVa8NJlrCXnFZ0vrHCdIAhOP4Ba+Xp7FmZ33IP2c2CMdmApRS+J5Jk0+PaPhrg6IQwW+20hSgUS1pJlTh2FJB6R33QOZkqb/sKSQn3vkDa2RM71+NCZ1vxF6LPe+l0DtqE5qxOdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2Fyw+ST6Fm1IK58ral+DgV+4JR00lcj/ZbFlNgzdSs=;
 b=zPI/VEBMjwJdQ0hVPcTP/57wUyDU7kuF5j9L0lhkdFikOT3fJg259f7iGbhTW2TXtfuPGI2Lkb9K+s73yYdxNdNVD+KLeGsC+6hrJt8O4WPyvJwZK21nIfxDAXSuxNCmr7I5SMHPklPyjacGgCskug0cqRZNAi95sJII+hPKSMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 22:16:37 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::5a16:a4db:8bed:1f5d]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::5a16:a4db:8bed:1f5d%5]) with mapi id 15.20.7611.030; Thu, 30 May 2024
 22:16:37 +0000
Message-ID: <abadef65-e76d-4954-af91-952da6785608@amd.com>
Date: Thu, 30 May 2024 17:16:34 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] arm64: zynqmp: Update rproc node
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Piyush Mehta <piyush.mehta@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Tom Rini <trini@konsulko.com>
References: <d8247a46f486a612f85767de9b832ad33fa980fe.1717065556.git.michal.simek@amd.com>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <d8247a46f486a612f85767de9b832ad33fa980fe.1717065556.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0029.namprd11.prod.outlook.com
 (2603:10b6:806:d3::34) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|PH7PR12MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: d3764466-9f9c-4bc9-3c3b-08dc80f62c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b00vUVRIOUZTQjhEaHJzMXhxaHJiRm5ydmFQQW1kVUpUQnp1M05lZ0lkUVM5?=
 =?utf-8?B?OXNuRzFiWnhTbDNjQ2Nyb2tScFhGOXpLdUxQa0h2V0QrYUpCVndteDBpbXJO?=
 =?utf-8?B?VnQ3OUxuSEhvWmovbXdiSWl3SnBla1NEZFBQeGFPWFQ2cXd1emNWNUFnSllH?=
 =?utf-8?B?L1g5WmFBVU5aemVISVFxNGxBVDAyTXJNNVozRFNrci9RbkhjVHFZMVVNQi9X?=
 =?utf-8?B?bzJlQTVsNjRtcFoydXQyb0FsY0hoVHhONE9FTkZDa0lnYTExREpGZ215TTlp?=
 =?utf-8?B?enRwcllTbmszamNMekduK3R0K3I2UGRRdHJGbzFYenZ0dUU1RkdteThhZG0v?=
 =?utf-8?B?VVErbk4xNmhjTUphQVVzYXpBa201R2xHMThDOEJMczlXd0cvVDErUDVoWU50?=
 =?utf-8?B?VXo5dUpvdHUrWTJNTU84YVgwcWU2c1prRkxoS2lzVzQrbnhtdi82U1lvZUtB?=
 =?utf-8?B?VWlzb1o3Y0RqNDQ5QUlpd3ZIQjFOakErWnUvcXZja3pxT3JpZTJxRE9QSjJr?=
 =?utf-8?B?K1ZjN2xYQjFtWER2aFcvdlBsd0IrMHJwZ0NZdG1ML1hiTE5tWjN0V2xISlZo?=
 =?utf-8?B?N1hYdU1sS3VnNlZreGR3NnpMZzFRMGRVSEo5OFcvQ05NWmJyR0pidWZXcGZk?=
 =?utf-8?B?aHcxTWhGS1RYVDJWMERNL09tL2Q1TldWaUlzb1JjRkR4d1JvZFo1T1d0ZmV3?=
 =?utf-8?B?MHkrSHBXMmIwQ3dNSEg5M3ZuWUsvcktBbzZYbjROd1RoTXg3R2hTWFdheFc1?=
 =?utf-8?B?YllCWkhSMnpiV2dNN09QNEtLNGFiVGFTWmRYcjdJczFCWEoySlYzbVROdEpj?=
 =?utf-8?B?OU94TEM4d2VXd0xWaFdKVDlnY2lNK3VKUkNYOERXb2tTRStLT0pZQ3EyVEtM?=
 =?utf-8?B?aVJtbU1tVWZONlE0L3BIckVXK2FFc2l0OXR1TVNpRklMeEFJZWE1TXUxWHN2?=
 =?utf-8?B?WWxFSDNBdzdnZXdyRUNFeEl4MTFrUDVGQjJFbDdHaWlHMm1VT1hKMTJQaUc5?=
 =?utf-8?B?MVpGa2Q4anp4S3RDMTdDUmhhTHdBeC95L1dpdXNobGkwck1DNWc1ZUFsZlYx?=
 =?utf-8?B?S1FteW9USXNxRGE4aVRUbWk0aWxBcEpOUHN3b3MwMWFtby96ZmM1cERoQmdI?=
 =?utf-8?B?UUhORUlTa1UxQlYyMDA5eE5MRVhXa2xaU0dick1HdnBDQWJmWjFsL2hzLzlh?=
 =?utf-8?B?RlQxVkMrWS9RSWNXd0Fiak9waXc2Wm5ETjUxYmJxQjVBV0VabjBDbEEybWQx?=
 =?utf-8?B?dmNMeFJrNmpMM3ZybDVtdDN1alJZRjlOSHJTSmVwV3R3ZXg4UllUZTllbitN?=
 =?utf-8?B?UXFiQ3oySjVKenpXQUFGVmJRb1JrWkZVVnpldzk4Znh3RGI3c0RiS3VsUlls?=
 =?utf-8?B?Nkwrd3RBTUVaZDlsQzBoQ1FjL3ZlcGZzdHlobGZEL2h1T2hPSE1aUUdaNFdn?=
 =?utf-8?B?YnBtZG1tVkVzWExtOWd3aHBJNjlPYmZveXRpcWtTM1dCeWY5K1NEWmU2OHVu?=
 =?utf-8?B?RU5Cb1EveEJXWUo3YnZ3MDhGS1F2TUdGWTZRMnJhdGduYTRYcldkYnJrcHhm?=
 =?utf-8?B?MUFiZWQ4ZTQ1aUpBaERVdkt3TlZ2V1hJMG50d1Z6TVh2cDR5MU1EVCsxYm1p?=
 =?utf-8?B?ZTRKcnF1dHNoVjdoTU5mekxvazlFWTVYN0tWVEpIc21CTzJ3SlNnbVM1d2tK?=
 =?utf-8?B?OWI2eUlwbmZrU3pVOCtaWDkwSis4OVpJNlFNdHQ0RDlmeXd6VUdjQWx3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5874.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S25yQ1FhVW9MdGRmRGZ4TzNOdjYzZlpOUUkwTmo5QkZ3SmgyR0EwdFpMZi9y?=
 =?utf-8?B?cTlWS01pZjh3aDNncURFR1JJbTJtUGVLeXhBQWYraktUclU0UUJrNG1KbEpN?=
 =?utf-8?B?dmoxRFdYUU4xRFZYY1kvK2ZOSWVWQUhNYUdGTzdVTTNBVTYzTnFNQTlVWUV2?=
 =?utf-8?B?V1p4Sk0zQ25KcDBwcEtvUDR5WFBkOFpIdWNoeENxOWVrTVBJMkdWbHIya290?=
 =?utf-8?B?YlJMSVF2dG1aM1plZTBXMXBJbS9DZFM3YndvTjUrMW1UdnRpSDJQNUVXeHNO?=
 =?utf-8?B?YUQ1REJ4RmVXMGMxbWwzYWV4MWR3T0QrQjFIR3dSQ3phOTF3WHhjbS85RkxZ?=
 =?utf-8?B?QU9GcTRuUG94eTZQeDBSV1R5ZzliZWNmSkFLR0VYUzV0d1NYb29seElWWGtu?=
 =?utf-8?B?UG9JcnBhQjdlRXBXMkg0TmJsdFk2VHo3d3Z2ODhiajh3OTc4VlFyU2czVlVV?=
 =?utf-8?B?NG5ySUVhR1pxYmkwbFR4RkpET0ZhcUNzSHIxOWV0cURXOE1Nd3cwSWxpbFF4?=
 =?utf-8?B?d255eUNuakhHK0ZMSkxQNjFhYlkrK2JDdmd3dUZ5MDgyTjdMUG9GTXNPUWFR?=
 =?utf-8?B?UEN0TEVwRWJwcnRIc3lVVVU0a3JObTZUS3d6MlRYK21QaElBNmU1TTFtR1Jo?=
 =?utf-8?B?K1dBSm9GL0ZxUVVMNVgxVzZydHhNcUxEcGEwNHMzNS9iMnowalVIWmovdGVX?=
 =?utf-8?B?RCtOT0ZiWGxmTFpGQzFiQndqbHZjSEVHRnpuTHMzcTRGVDNEUm9QeGd4QjhT?=
 =?utf-8?B?VmNGSHprTHl3N29rLzFJRXRHMUR5TnI2ejhGMzhYOUx5T3U2bVNqTlRsZHNi?=
 =?utf-8?B?dFdrQ1Z0bGd3NHo4cmF0aHl3blRaQjV4NnI2NUVqeEw5eFA5czF3K3lFTnI5?=
 =?utf-8?B?WTljYWhibDlyMnNSZXFsMnZxc29nTk1YOUtHUU8yWmMweklkMC92TjNWUWV0?=
 =?utf-8?B?ZFlmV1JBbWE0WGFmVnpaM1owbFJ5MXZIMGNFeGdPR2RNMC8xYWFtejZjSzZQ?=
 =?utf-8?B?R3UyVUl5ekxsVWtQcVdVUFRJazgwZmxJa1JIejgvQlRrMHFLNWNXekN3QXp0?=
 =?utf-8?B?cUZBbS9BL2VZdU9XS1FTOVVzTGlmODlYSjlmNG5NYzY5aldtWnFhRkQvNTFR?=
 =?utf-8?B?dzJCSFdza1prS1grQVB4bTZuVTdjWUI5bmtZRUdVTkxzN2FKUnZ3ejlsOHRD?=
 =?utf-8?B?L2tteXc3YmNRSUo4RDhucnl6VDlQOFdMN1g2UEZQcWwvRUo3NGd1cGsrOG9P?=
 =?utf-8?B?bVRNdzc4SmVGTk1qTWlreExoOGo0UTgwN2I3ZlliN2ZobEJTMkJWemRvdmM0?=
 =?utf-8?B?Q05Ndm9lVXFTRW5nNVhDeVZJUkN2UHkreTBnMCtxV0ZiVldwV1B0WUIveERZ?=
 =?utf-8?B?Tmo3WklVRUJmUkhOZE5SaG5ldUEweHI2WlFHTFc3K0w0Z3hqQTFhYmZlNmhi?=
 =?utf-8?B?eVIyUFFRQUZTamJNazFHcDY4YVcyM25UTVVVVVhPRm5PdERYTjhuUDZ3Ui9P?=
 =?utf-8?B?T09RMTZpME5BeHZjQ3VLWnN0djJZcElLMDZZcFo1Wk50NDI5UlBQWGJTR2tx?=
 =?utf-8?B?UFF2U1FsM003UFZuYitjQXpiZWVsNEN3UTJaVkhUeTFOSGp3T0E4TU9HWVU3?=
 =?utf-8?B?Y1AyQktqWXhzNEI2dzRIbUNvUVllVllVemlqdXBoOUlwZ3BMSlRhZlpiSzNQ?=
 =?utf-8?B?VWEvNjcxemxFc2lzcFhuU2lQNzVYQldtS2tHc1NKbk9xcU1GanZOQ2pBei9W?=
 =?utf-8?B?Y3B5cXlvQTljTGJVc0Vkb0VxRVh6MDYzMkJ0d3dESWxkMVd6b1h3YjRUeWpM?=
 =?utf-8?B?ODYyUjFUZFpoUGhZdWYxT0VnNlhkaEhuT2Z3RDRNMVB0VzdxV1NOUk4ycG5H?=
 =?utf-8?B?bnJsSWpiVHFtN09PTFdHNE14bUR4Q2Jlb1JESXVYNk1KVW1SV05rdU5IZEJt?=
 =?utf-8?B?RWM2dGl2ZzI4U2cxQWJrTWlwYm5QbHlranJqdmR1UFBLaisrSlplQWhtWlJV?=
 =?utf-8?B?T2hNeXdVZloxNXNGM0ZyUjNHS2tBVC9ieVZmQ054a0RaRndNYkV6MTZ3T3BE?=
 =?utf-8?B?RVY1MDYwSE9jcnZmWCt2UFlGWTJQRjJmY2hZdk1JaWNVblg1QzVHNjZuSGFC?=
 =?utf-8?Q?2jt4Nw+ICGb2fSQJKVg+lrlCC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3764466-9f9c-4bc9-3c3b-08dc80f62c3d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 22:16:37.3684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdzAJDB1FnPvN/gs+ZiSY7zvLc/n55/J0ZEHgEueWjL2V9vttQvkqTohlIqNeCB+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282
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



On 5/30/24 5:39 AM, Michal Simek wrote:
> remoteproc node should be updated to be aligned with the latest dt-schema.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Once we push all dts to Linux we can change to OF_UPSTREAM but till that
> time we need to keep DTSes in sync.
> ---
>  arch/arm/dts/zynqmp.dtsi                      | 67 +++++++++++++++++--
>  include/dt-bindings/power/xlnx-zynqmp-power.h | 17 ++---
>  2 files changed, 68 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
> index 53a606c340a4..34f592c1a85f 100644
> --- a/arch/arm/dts/zynqmp.dtsi
> +++ b/arch/arm/dts/zynqmp.dtsi
> @@ -314,19 +314,76 @@
>  		ranges;
>  	};
>  
> -	remoteproc {
> +	rproc_lockstep: remoteproc@ffe00000 {
>  		compatible = "xlnx,zynqmp-r5fss";
>  		xlnx,cluster-mode = <1>;
> +		xlnx,tcm-mode = <1>;
>  
> -		r5f-0 {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
> +			 <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
> +			 <0x0 0x10000 0x0 0xffe10000 0x0 0x10000>,
> +			 <0x0 0x30000 0x0 0xffe30000 0x0 0x10000>;
> +
> +		r5f@0 {
> +			compatible = "xlnx,zynqmp-r5f";
> +			reg = <0x0 0x0 0x0 0x10000>,
> +			      <0x0 0x20000 0x0 0x10000>,
> +			      <0x0 0x10000 0x0 0x10000>,
> +			      <0x0 0x30000 0x0 0x10000>;
> +			reg-names = "atcm0", "btcm0", "atcm1", "btcm1";
> +			power-domains = <&zynqmp_firmware PD_RPU_0>,
> +					<&zynqmp_firmware PD_R5_0_ATCM>,
> +					<&zynqmp_firmware PD_R5_0_BTCM>,
> +					<&zynqmp_firmware PD_R5_1_ATCM>,
> +					<&zynqmp_firmware PD_R5_1_BTCM>;
> +			memory-region = <&rproc_0_fw_image>;
> +		};
> +
> +		r5f@1 {
> +			compatible = "xlnx,zynqmp-r5f";
> +			reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
> +			reg-names = "atcm0", "btcm0";
> +			power-domains = <&zynqmp_firmware PD_RPU_1>,
> +					<&zynqmp_firmware PD_R5_1_ATCM>,
> +					<&zynqmp_firmware PD_R5_1_BTCM>;
> +			memory-region = <&rproc_1_fw_image>;
> +		};
> +	};
> +
> +	rproc_split: remoteproc-split@ffe00000 {
> +		status = "disabled";
> +		compatible = "xlnx,zynqmp-r5fss";
> +		xlnx,cluster-mode = <0>;
> +		xlnx,tcm-mode = <0>;
> +
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
> +			 <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
> +			 <0x1 0x0 0x0 0xffe90000 0x0 0x10000>,
> +			 <0x1 0x20000 0x0 0xffeb0000 0x0 0x10000>;
> +
> +		r5f@0 {
>  			compatible = "xlnx,zynqmp-r5f";
> -			power-domains = <&zynqmp_firmware PD_RPU_0>;
> +			reg = <0x0 0x0 0x0 0x10000>, <0x0 0x20000 0x0 0x10000>;
> +			reg-names = "atcm0", "btcm0";
> +			power-domains = <&zynqmp_firmware PD_RPU_0>,
> +					<&zynqmp_firmware PD_R5_0_ATCM>,
> +					<&zynqmp_firmware PD_R5_0_BTCM>;
>  			memory-region = <&rproc_0_fw_image>;
>  		};
>  
> -		r5f-1 {
> +		r5f@1 {
>  			compatible = "xlnx,zynqmp-r5f";
> -			power-domains = <&zynqmp_firmware PD_RPU_1>;
> +			reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
> +			reg-names = "atcm0", "btcm0";
> +			power-domains = <&zynqmp_firmware PD_RPU_1>,
> +					<&zynqmp_firmware PD_R5_1_ATCM>,
> +					<&zynqmp_firmware PD_R5_1_BTCM>;
>  			memory-region = <&rproc_1_fw_image>;
>  		};
>  	};
> diff --git a/include/dt-bindings/power/xlnx-zynqmp-power.h b/include/dt-bindings/power/xlnx-zynqmp-power.h
> index e7eb0960480a..618024cbb20d 100644
> --- a/include/dt-bindings/power/xlnx-zynqmp-power.h
> +++ b/include/dt-bindings/power/xlnx-zynqmp-power.h
> @@ -6,16 +6,12 @@
>  #ifndef _DT_BINDINGS_ZYNQMP_POWER_H
>  #define _DT_BINDINGS_ZYNQMP_POWER_H
>  
> -#define		PD_RPU_0	6
> -#define		PD_RPU_1	7
> -#define		PD_OCM_BANK_0	11
> -#define		PD_OCM_BANK_1	12
> -#define		PD_OCM_BANK_2	13
> -#define		PD_OCM_BANK_3	14
> -#define		PD_TCM_BANK_0	15
> -#define		PD_TCM_BANK_1	16
> -#define		PD_TCM_BANK_2	17
> -#define		PD_TCM_BANK_3	18
> +#define		PD_RPU_0	7
> +#define		PD_RPU_1	8
> +#define		PD_R5_0_ATCM	15
> +#define		PD_R5_0_BTCM	16
> +#define		PD_R5_1_ATCM	17
> +#define		PD_R5_1_BTCM	18
>  #define		PD_USB_0	22
>  #define		PD_USB_1	23
>  #define		PD_TTC_0	24
> @@ -45,6 +41,5 @@
>  #define		PD_CAN_1	48
>  #define		PD_GPU		58
>  #define		PD_PCIE		59
> -#define		PD_PL		69

This last change looks unrelated. Other than that looks good to me.

Thanks.

>  
>  #endif

