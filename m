Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC26FD874E
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 12:06:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 063FC84236;
	Tue, 17 Mar 2026 13:06:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sjaKcpYC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC9E084236; Tue, 17 Mar 2026 13:06:26 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8529C84228
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 13:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tv6FmHTgBmDS9arl1xSjCXI3YLz2seHAn9Adhd6OyFQo3EiTQTvdNsqTVjV2S7y5Yrez455N0HpLthCHBjDh53SjAEDbUKto++NYXXFWMSVHs83WzU5jz0k0PbUcR3424JCLEZnEpsRIOuabon+XUoYFTvy+gsG4qoPCU3icwrxhf5wtWeKILgrPqx1mi4QwDq+Zu6qbkqUpkwvx9JcrMIhx1zX62WCtWsNGLzqLot02p+kcXLh4YrsQ2eWsixb9nkFIZEfKqpdXCCLnfMnieFTHgTGzeC6Kiyk7LHzc7KUdAU6jCgD0q+Ilx/rUlTuspnAzglYs086De0Ubccem2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8X+MTeXSHxOA/PBnyD44hZXma1MJHZL3pM35YhYahlo=;
 b=owu/3APSdhrNEZGU6bi4SB3j970iuToZJQy6FpTUSQ4iO0mYjJiTJQOcOxslLsiPQy9vhDufRkZ3yHX+Vm/k41ksCpYuCf2Iifh4QH3kuJlGkioNS1KIfQJu2nx/N6rBRD4n+7JLUbia9dslgERdsTT8JpxWLtkuVog4rlx6JCf88xpfAgNGTsPjjjpC3BU6OK7TcqnoLxS5Ps5QHfg9B7inQ3THEJPV8vXQRA4x9YfhloEw5WcjHQ/1brYFMeQGjw3Rbkg8QFOQFoAGokQxFnEgizXyEJZU3viNR7Ht+otSyusghfSEZdGYJ9cJCYLOUgL1Mqn5fEoBl2mFOw9p7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8X+MTeXSHxOA/PBnyD44hZXma1MJHZL3pM35YhYahlo=;
 b=sjaKcpYCCXUZOQ8NPEBWgIEpi64yjC66xqzBmGDQqunlLtLFxgiNECuHr5rcGe0PGuOpJGrHMux63T+vIAHyG1EoivfhabKTkxVlFu75B136vjHkn20qUyaPFkJ50ho1pUztAFbhXT2q97x2qNHDkyUiAsT0QaTcQXptPpu2nv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 12:06:21 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 12:06:19 +0000
Message-ID: <92a3aa0d-4d2f-4845-9ac2-6bcb976bced8@amd.com>
Date: Tue, 17 Mar 2026 13:06:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] microblaze: Rework TARGET_MICROBLAZE_GENERIC
 implementation
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260317012412.4162279-1-trini@konsulko.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260317012412.4162279-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:254::22) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS7PR12MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: b5daefe5-4bc5-4cff-7c23-08de841d993d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: acGQILOXcFQVVdtxDjkRzE1UO/Jwkh9wPWtwpHlRN9LY/AKViEmRPrlP19LLKKfavf2vZU+Zg2ZXBLRo97pO0IDni8ovkCwRAk/je36Q8UT8XSqhAt457zLQTScRwDvlCNIKkt3sHPop68HSwtJ6UxvnMnYRToO0DwfwHAsKveftevQ9dH6kb5xUmCxej/+ieqXhImksqDZwPZDHbEGp/1BomUuGLNmxU4kNSy0+MqMLNRSulVX3O+3Bt7USIpEhgpKafp6F5eXybsafXhjETQW85+I0AdmGax9gJs31PorPEx/VufsHUCogGJer7pLg5c4B2+gpYUc50n/eHdVrWXcVDvMwymotkgCJmVaCGWA4GBlI7ATL1FcOd8LRdd2yBAjJkAJ5MaCliXq9Co+rt7gCSRu580CpXyp2KAAkjiDkwVeOf60nYb+jxZxOwFN2tqlemLrUtCksdpJoMQ2U8womT6QUVyzhtZg/PeVDLD8d4QBCls1MvdoiKEv6cPPU6LI6pCKm+Z4waIpDfCM5+sGu4dOAtZPCsVX95aradBtcDTqYU26kQzOlLX85qG7EgXaT5kX+uLkL32LHueliV++GUQOdvojTW/4BjDYmY9SASBITPE9tg27L9YRes0AsY02mzMXAj4NIK1ABpb424lyHqcNssiqDY8D2y0EZHpShlVovOVOn0BG0K2rdQc3LoXuw8paAq8hKmnYbi5oIMCGDlwm/nLdqWoQt/Vjk4wA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXdCVndPeDlOaGI3UWJxWGN1ODU5bmNKbHo3UTJCS1ZQN2V4c20rdW5PajA1?=
 =?utf-8?B?M1JJU0NhUkVrdXMvUjByYWNtblE2SnhrY09taDFWU0JzeXZQL3dNMUVhYmlF?=
 =?utf-8?B?ektpSVZuMHlWT1RJRThhUnJLSDFPNzRQWlRQdWtHSVhVc1pZY1ZwamttdmRW?=
 =?utf-8?B?RlcxUU83a1dOSnlacnNvakthSU9hU3pCZ1UreU9NTysraFFwMUQ0ZHVOU0V1?=
 =?utf-8?B?bG00VzBEMTNPODdpRUlYcXdseTR4Yjk5Z2N1cFlzTk9sRWM2aXZDcS96Q2dK?=
 =?utf-8?B?TC8vSXNPeFpJdjNUZnNhc1IxRGx5WThPbkpyVWdLUUZJVjQ3eWFnMktHNXIy?=
 =?utf-8?B?dmFtMlpLRSthZzhQeStFdG1LRXlYQnNYM0lTdmRCdjhmZ3dSRGJNdVJ6UDlo?=
 =?utf-8?B?NFp0NzFJQ3NJcUdobkhDZEtUVE03aHVLaXNhZE8wZVFiYVNwbDk5ME9EU0ly?=
 =?utf-8?B?a2lhZmRvWlUyVTN6bW1WTGp5LytLSGtIb0U5Rm81akJXVGJJbXRScG5GSVJR?=
 =?utf-8?B?WTRXUGJJVmg3RnFlWmFSN2tSRjdCbnJTMGRHRGNkVW15Q3lVRms1bk42K2xu?=
 =?utf-8?B?NTNjaXlTWTQ0M0g4empTT09nNVVvU05ranNQb2FGYkpTdG5idEZ0WWZ5ZWxw?=
 =?utf-8?B?Y1o4ZHBVdk9FN2M2Rkp6V3FHSGQ5dGZySkhmRnR6VStYYXJaTHpwV05HZDda?=
 =?utf-8?B?eWR1QVNpYkpiZDJVNkp2QVJ0Y0tMS0RnajZiRlpvdElGa2RTQkRrNC9kVFRH?=
 =?utf-8?B?ekFJeG1Ta25zVy82UmQ2akZMK0N4eVBpTU16VGZXMzNxWFBuOVhhTlpIaXhj?=
 =?utf-8?B?bm8xM2dMRjBsWXMvcFA2QzR5WkpkQUJZcHJialU3M0lGWU9hUm1KZzlSa052?=
 =?utf-8?B?bTJLeHBWT2NRMnI1VlNqNi81a0Nwc2haSUVJemhJZ1d5WHFzMmtzVGhUSXNL?=
 =?utf-8?B?Zm0yelhCeWI1ckRSZnYya0YxekUvdHhxcFJYa2JpZTVTTlA3aFBjTmxNOWdR?=
 =?utf-8?B?NU55Tmwwb1RyTTNOKzIxdjYxUWs1OWF6akkzL2pXT1hjVFFjSGtlMmhmSURl?=
 =?utf-8?B?ZzNXVmc5K2lmTC8zZFZneXkvUXZXbVorNUVkcHRwZTVSekN3US81aWEvbksy?=
 =?utf-8?B?TnloZytaV3AxYTJSakp5UXJQNThMS2x5VXdlNWhNRTlESkV5QkYvTFRERFB1?=
 =?utf-8?B?SmlaWWJJZTg5dVZqYk1ZWmZTdVRueUVadGx2SURxNDR5ck91RHBDcFdVaXhu?=
 =?utf-8?B?bFpUYVJSdlRkSStoVzZyTkI1ZUFuTlBzbk9kRVc4TjNJSFhWaysxaTE1YUlV?=
 =?utf-8?B?QUVWNUI4K3h2WmNkZlBoZis5RUdsRWtwLzN0MW9ScllkdzZkQXVCeld6ZGxC?=
 =?utf-8?B?bm5LVXZEMzE3U2x0QloybVVwNmN3SUZuMVdUNHNDZXNKc0F6VVM0QmRVOXBi?=
 =?utf-8?B?TG1UNzFzTVMyT2dISUF1S2UydGEwRU9lQ3p1SFJaRHB2L0ZVR2hhYmxBb25D?=
 =?utf-8?B?WXBha3FKdCt6MUJwWE82L2k3djlqN0ZjVndscjBMaWxTSm16K1kvd05ZQ0Z0?=
 =?utf-8?B?alUreVpsdDJUNnJrbGk3aDNCcmtvWnlIaklqL1pzQ2VkQUR5czdrYkdWdXEw?=
 =?utf-8?B?VHY3STFXNVB0U2Zxd2ttTTRTTllrbHNabm15QmRWYXQvT05naHVJQ3hvTDE5?=
 =?utf-8?B?ck82ek1vL25GSjdEK0dKSmxvdko1TXpEU0RZMi9NN0FFdGRwMXlnaTdaZk9o?=
 =?utf-8?B?TFE4TWxIeU1lWlRFVmlGZmhzYnBJL0JRSSt5ZHluOWVsQWRvTFMvYm52WDhC?=
 =?utf-8?B?OHQ0NS9tdGd2VEZ4TlpqNm93eDJNVFF5R3RtUVRJSGZEYlMzU2VTQnJxTzFk?=
 =?utf-8?B?YkJsUXdNWTA1M0xZdHVFdURSb0s3dDZmcXAxWmpSV0RLckZZZXE0dms5a1lJ?=
 =?utf-8?B?UHpodUFwRkZ0Nk82TnFheVV0NmNIOGYycC9Vdjd2QzQ3SFFYdjViMFcyUFpj?=
 =?utf-8?B?MitobnM1TmNoS0Z6TDNwTTlkTzRRblVMcWF4L0djclFsY01BdFdTbGkvaEEr?=
 =?utf-8?B?SUdJSkdmMXFmS3VEaDJsR21GdVRueWZjNUJiWUppNVRoMll0cFQzR3Jldy9k?=
 =?utf-8?B?K2VkN3hJTjhITWlBOTVVRWdWRGl2QXZXVzBvcm5RM2haRm9nYnZlV1BKWjVv?=
 =?utf-8?B?eHNid0lqMjZ2a0EvM0ZBQnpCOGZOUXdUTkdRNmtGTm1DcFIwS0NJSkFjSkc0?=
 =?utf-8?B?eVdWazhYRGtSNnFEVkhnMUJQYzkxTldCOVQ2ZEhZcUxQTzZqVnZIemJXVHJn?=
 =?utf-8?B?Tmc2UzdTYmNORW80Q210bno1MU1teGxTZXlYVFVISEZMZjJ6THAzZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5daefe5-4bc5-4cff-7c23-08de841d993d
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 12:06:19.4602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7DKgvhyJ8kwd00JhqzATOylDMYJXqnyfQGOqFnp0FAAztW8M/Apb65RyXob+FP1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239
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



On 3/17/26 02:24, Tom Rini wrote:
> As exposed by "make randconfig", some symbols such as
> XILINX_MICROBLAZE0_PVR can be set without TARGET_MICROBLAZE_GENERIC but
> have a transitive dependency on it. The easiest path of resolution here
> is that since there is only one valid microblaze "board", rework that
> symbol to be non-optional.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Michal Simek <michal.simek@amd.com>
> ---
>   arch/microblaze/Kconfig | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> index 4261e5009fdc..16c55ddfd95c 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -7,12 +7,8 @@ config SYS_ARCH
>   config STATIC_RELA
>   	def_bool y
>   
> -choice
> -	prompt "Target select"
> -	optional
> -
>   config TARGET_MICROBLAZE_GENERIC
> -	bool "Support microblaze-generic"
> +	def_bool y
>   	select BOARD_LATE_INIT
>   	select DM
>   	select DM_SERIAL
> @@ -26,8 +22,8 @@ config TARGET_MICROBLAZE_GENERIC
>   	select MTD
>   	select SPI
>   	imply CMD_DM
> -
> -endchoice
> +	help
> +	  Support microblaze-generic
>   
>   source "board/xilinx/Kconfig"
>   source "board/xilinx/microblaze-generic/Kconfig"

Applied.
M
