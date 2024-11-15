Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C78D65C7E
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:20:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 983C888FC5;
	Fri, 15 Nov 2024 15:20:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l13oIeKf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2393F8907B; Fri, 15 Nov 2024 15:20:18 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D7AB88D29
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:20:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OafbIuaPVk9Tu0pvzJMv8IfTWMj76/sdaRloV7VtOpCKaenMX4gt77cZ0KdKF7CMMy0v7eahZXXir9UL8ACkYFlCm4ejAMeYDEd5183kloLfi+1KDtDCbGAOCVQDfoOzQ/ZMfunuSZdUNMLoq1EnT0F1xLHJ3wk+3OgCyxRj8r8wN/JSluqxKJ4mmjnPv8ZbTS0SZJ9kqmPcHSopy4Gj7/zdWpkEwAkkH3VDFOAmYyp2YahuTiuBAk2MCTF1/AWWq1UbvJghYrL+WXeEN89MmztojZxbpqa3eTBQuPMIxIVYklCsb8bWeoU0G6SL7lcX5Lojta4dYoM70t8p6SjWrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3TqAUJ9CR6ZYgM77WMOKr5xLVzXqei751qlxzDdG6o=;
 b=WFc/xELMY3GYubHfjosWip31HEKxNamD8JbFIVCrx9K12qwQpuFZNbQF7crRkdfo8xvzeNFYHbn+jK2qw5petn7xj6+hEswQ13Ggm1a1xL9t+rHpisScdjzjOt8Ih+sU8phGUZ1jDLnkP7p21I2Uiy+DOfxCMsQUzMNyVAki8FNxpSmGuZ+QJ2XqhF5odKyBPzF6vVVf8azXSYRS4HExYXN2ivwp11z/kMGM2sys0HmPUPguACeCAneDYjOR8IjPZs7RlZR1rxseqHh9/UkQyx/3YsycxegVlvna4v0VRL3fdw8c1RnWQDT6uo4t0X9VaN/FPHxZCa9e6IznKdcMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3TqAUJ9CR6ZYgM77WMOKr5xLVzXqei751qlxzDdG6o=;
 b=l13oIeKf+Mgee6UNGKxsZ0pueKareKfQ57/Ao//BkqWAo23X2xCJEzStUS9yIu1j/DxrPmmt7aq3W7I5uzixsaBn1BLgy/ckecliYBiNKgIPFjqCPNyMgdS6s7NfQJwf83Xp9WPIFAXZCcLXY5uY4c0yG5FUfQuoLylzd+zlPZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB8143.namprd12.prod.outlook.com (2603:10b6:806:333::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 14:20:10 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 14:20:10 +0000
Message-ID: <2ff5a6d3-d9a1-4ac2-b709-72e98b7b1c61@amd.com>
Date: Fri, 15 Nov 2024 15:19:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Introduce MINI configuration
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Padmarao Begari <padmarao.begari@amd.com>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <81d086ccf96f9d601eb4b56a2a88d8bb2dacd48e.1731677784.git.michal.simek@amd.com>
 <20241115141900.GT3600562@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241115141900.GT3600562@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0004.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::16) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: a525143b-4827-4288-b816-08dd05809c98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmVRNkhQd3hrK01FYzVBVnpsZFU1WHkwLzRHblNEa2J4NVFMMW91RCtjTmhu?=
 =?utf-8?B?bWxFUTJCN3lSTmNDdE0xM2RhKzgvQisvTnVDVHNZUjFOa1hXODdMTDdnUkNC?=
 =?utf-8?B?WUxCZzVLOC8vMzNPWm9TTlp0cVhDSmJCbkp4ckFwYTB1QisrY0RvWmplVHp6?=
 =?utf-8?B?ZjluQTlkZG5wMWpRblZpTjlLSWZaVGZ4RGRkS1ladWRiZjFaQjNzM2hIVFR1?=
 =?utf-8?B?UllSQTVYMzNoMHJscC8rbktSQW5qWHpXZEZrMWxyc2NtaGJKUnZHVjdnMkcv?=
 =?utf-8?B?b2d0dGZsaGU4bVJKRno5WUQ0WmZFemdwVkhNQU9Jazk1d2RYenBOZ0YvQ2NE?=
 =?utf-8?B?YUxRakdyZG04OG9xM1BOODNmMmgwRjVEN1h1Wk40U2FxMmk2bnJQR3kwc2sw?=
 =?utf-8?B?ZnpNUk5TSkdCOVVkUFVFMGxNTUdoMk93cjlnSUZxS2htc09Zb2x0Yjd6OGRY?=
 =?utf-8?B?RlFEZyttVlptSkRITkpxcHhpZE9oSTB5Vm5EWnVacXhUMlVTcHp4dDZEV0Z0?=
 =?utf-8?B?RG43NGRxZjB3U1FIMkIvbnJIS1lQZ09VS3FGUHdJdzlKdHBrV20zOUlMQXVh?=
 =?utf-8?B?N1p1MU5YTHpnWEdYTkVLVjZWcVFJOGZKZ1c0V2UxcmRYK3BTSUl4VGFGOGpv?=
 =?utf-8?B?UU50ejdlRkRVS0dXQiswS0lJVmVuRmtJSStGMEs0TWVkYXRjYTdsc1Z1am1m?=
 =?utf-8?B?NVRBU0dBbmZSMHdvbWdKNDhGRFh3OG1acGtPNTg2QnJJWno3bzRsUEJNbldQ?=
 =?utf-8?B?QkhIeEw3aFNyRVA0SlY4RkRBWWtpNi9uM0Y2QmdJSWQ0d3VzK3ROL3ZTeEx4?=
 =?utf-8?B?Wnk0SmlsOGZMUzNoZXFYeHdnQkNDbnhydWM5Q3JJY2Q5SFNVR2Zob3JITS9M?=
 =?utf-8?B?VGxWQ0M0V2dBS0ZEeVBNOGsvVkxKN0Z2MTVmYXgwbTBsc2JKTjFSWkwvU0w4?=
 =?utf-8?B?ME0rYW16MmxhK1RPSUtCSEtGTXZhVnlkeFJYaEhXNU80aXNhKzRkQnVhNHB3?=
 =?utf-8?B?KzVWQ3ZBVTBxSTBnaFFwenN3Zk5NRWtFL20xYlpWSjR6TVY5dFFCcFUxMng1?=
 =?utf-8?B?eDF2ckFONWk0VDRkelZIMUYrM216YUV3RCtWSFlDenJ3STNGZHVQckJvVDJp?=
 =?utf-8?B?ZmQvMDc5YjdOaUJ6d1QrZ2RxQ09xb20xTjdabXZ3b1lySnVkV0FXYkVlbmln?=
 =?utf-8?B?K2UrbjdyeXJ3cVRETnVaTzBvb3U0RjYyL0diUFhpUDlJVlFPVW1hZkJxK0RQ?=
 =?utf-8?B?dk1hbFY3SUNkUjNOVHBvdHQ4U1N2d2pSWDAzeThCSWtZcjdPMllnTXBSYUVT?=
 =?utf-8?B?R1NmemsvTUlJRnBIaGtzZlJhcXBDMGdZeTdEcmR2aHFoUE1KVHE4NWxsRXFL?=
 =?utf-8?B?NkNHMEkvRjJ4VzRNRXZXK1h4RGI4Y0NnbkMrc0tOVTN3SUx4UTN5M2JxdUd4?=
 =?utf-8?B?VWZZVGJ6Zk5QQkFmdG9uMXo5T1ZNY2NHMG1sODQ3MGxyMHBSUzlxOHlDSDMy?=
 =?utf-8?B?SHdybk40UW9uWWxrMG9pTkNvUStVODFCK2pYOWpBQ2lOemw2Nnd1S21BWUt6?=
 =?utf-8?B?TkpYYUFYdWNLWVcweGd6cGJTVFFXM0hyYkRiOW5EVHRCd0VmeFhXaHNVWWR2?=
 =?utf-8?B?OG9xaGREcXd5OHk5WXEzblVIb0s3RGZ5UGhxb1FlS1plV2RjL3NFQ2ZEZFBv?=
 =?utf-8?B?TWQ5OHJCbE9hVllhSG5rbkhvYW5qdW9XOS91NnNIV0Rpdm51U0huc1FIS0Z0?=
 =?utf-8?Q?JdZBsJrGN6BNDB3MinCGiYkDgF+raKsJeOKk3EK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlpWeE5LNk4yMnM1VmdwditqRGhudEVYbXBydUFxZXNQV1VMVTMvdHBWVmlV?=
 =?utf-8?B?ODFqSEE3amgwb20wVW11T1pCcU9qM2syRkIyRWo1VUdoL2oxdWhtbGlUUWhG?=
 =?utf-8?B?MDBkVVI3SGRNcDZXbUJLOVFnUFlhNW1CTmFZR05wYisvV1FjanhuZm5xdExs?=
 =?utf-8?B?TUxsQlBUbC9CREhpVDF2aVk0YzlaOEhBQTh0VGpVdEt1cGk2MHBCbnc5TkNQ?=
 =?utf-8?B?R21yM3l6WFpITG5pRDcrcUpNZDZQQW1ueEVXWDFQa3dDR3EvSFNaQ1VkNThp?=
 =?utf-8?B?YmpQY1FJcmV6aERxUTYwU2xqWkhpZ2RVSHVKSmpQNElkUXBEbGJWNkJVMks1?=
 =?utf-8?B?VkoyTHFkY0xjZVppMThGNStrZC82d2dzNnA1VmFwTVh5ci9XVWkydXhhRVdw?=
 =?utf-8?B?aDRUdUlmV05JVE9lbncxeDNxOHlhV1VJeWIwTTA1UzFRN1NBREJBR2FoekRq?=
 =?utf-8?B?OXlBM1JEUkxnRFdwYW5sRlUrc1BYQnM2WFBXK0NqY1dyN0l4aHN1dGZjdER6?=
 =?utf-8?B?TkZBYjZFbzJiOGs0RHdGazVaOVppd0RFdHVnTW1SbFNYYThRV0g0UThhenJ1?=
 =?utf-8?B?S1VJVFE1dktlKys2NjhTbTlXWHpJUVpvTlpNa0NFYUkzUWtCMHlwckFTS05S?=
 =?utf-8?B?bTFqWVhFb0E0MW1aR1c5K1hiQjl3N2VhUkI4ZkNmZmsxVU1kU1RZM0FVTVZW?=
 =?utf-8?B?RGE5anBTMHRhTkJoZmxFUlh3NklBMGRacVQ3WEtpam13QlVYY1J2c2dXTFVo?=
 =?utf-8?B?U21kQ29aYk1pNTN4R1V5MGpZZEhzbVdrbEtlNnZBb1lqcFo0Ri96YllOYmdu?=
 =?utf-8?B?Q3RWNU5ld3g5cHNKSkxjVHZlQzcwcXpEcFVsQi9RYVVwZlRCeU1Id1I3ejNH?=
 =?utf-8?B?dnN3SWwyc2wwT2tnSnNUWlhxeUV2QnNMQ08yVkFyQlg1RU1EaE13cHYxMTlq?=
 =?utf-8?B?bkQ3Uy9naU55ZXVkTTZsTjl1Zldic2VIR3Uza3d6RmlyNnJpZ1NraG44KzVy?=
 =?utf-8?B?K0t2VldvU1VueEJnN3NqRERBQnFqYjFpYTZnWGFHcExUUlk3YmsrSFRDUmNZ?=
 =?utf-8?B?V0hRd2FZM25pTzd3UEZlMnpwNzBtbmlCM1crMTJCc2VVenpKb05hRldHVXA5?=
 =?utf-8?B?OGdmMnhkeCt3a0FYUTZ0TnZ0N1poRmZWR3EzNTR4MjlHSmFpY1BhaWtxRzdB?=
 =?utf-8?B?bS9NMzF5d2RnU1Jpdlp4SGdnRThWSHdXMmQ3bnl0UTRVS243Tm5Lb0FRL08z?=
 =?utf-8?B?bThjMFhSeGI2d0JNWHRHZU1CNlhoVk9ac1lHOUhpTEQzcHB5dEIxT1owK3Jx?=
 =?utf-8?B?M01odm9SbGJBMi9XQTBYRXBEa2wwcmtNaWVtZElhS1VzRklmbDRnVkJlakRk?=
 =?utf-8?B?ckJwSm1ZbTI0RnNrSkExV2xvaHVhZUpZbzRuSDVaSFAra0RmbWIxZWhZUVVh?=
 =?utf-8?B?Z1dKeDJRNCtvTFNXTDQ0MzNBT0d5eGFtMk9nMUY3bUVBQ3RIWEx3UjNGS3Mw?=
 =?utf-8?B?SkFDaXRtaVNtVm94Q0dFcTE5L1pYUERCcGtSUW5zZEkwKy81UVpwckdjV2Qx?=
 =?utf-8?B?Tk5GYlh4UUZCMEowdmRFY1NFbVNKZWJmcFNSRVNVOU0wVmlMZExVZkVycjBY?=
 =?utf-8?B?SmdBQk5WMnYzc0haVi9SckgvTkl4UHZDYWJibWgyUUs3bnR4SHd4NTUrZVd3?=
 =?utf-8?B?eVd0Tmd4M1pnT3M0WUNLdWUwYk5CaTdNYnNRU2FCODJQK3p4b2FBT1g1S3B5?=
 =?utf-8?B?THo2YnNiRzhaT0dyaXZDWnlxMFp6RWllR0NpNlMyeklERUVPQys5bTJTSkJn?=
 =?utf-8?B?M3kzeEpMVEVZa25QK3ViUmJlMG9QamtoVEgrMWhiTm1BY2Nma2QxTm9aQ2Z6?=
 =?utf-8?B?N1JnOEVodk96bDdhZU9kL3R2WTdkZWNabVpzRzVlUzdqZmRDN0l3UUJkREhl?=
 =?utf-8?B?S2NPZ1hvc3JiaFp5aitwNkRHelBKZ3MrSENGdnNhMWk3b1h2T1ZxTzN2NDlH?=
 =?utf-8?B?Y3h4QkpuNVJTVFZKaVNqQWhHNC9tdzBZMW0rTGw2UlEzaE9FZG84RUh1cGtk?=
 =?utf-8?B?cTFvc2ZyUFU2a2FsRC80dzV6ZkI1cCs1S3VubEo2S2paWmNiVFR0dDEycGRI?=
 =?utf-8?Q?enoQW0S90XnJiB1/jPTMuFNkm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a525143b-4827-4288-b816-08dd05809c98
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:20:10.0234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUJ87DijJiYotSK5Z7isZ8cZfnngsDbHaw2xSHC02Merl9jH6fJr/LDA0uojtV6S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8143
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



On 11/15/24 15:19, Tom Rini wrote:
> On Fri, Nov 15, 2024 at 02:36:32PM +0100, Michal Simek wrote:
> 
>> There is no common symbol which mini configurations are using and recent
>> get_mem_top() changes adding 1.3kB without having a way to remove it.
>> That's why introduce new symbol which can be used for removing features
>> which are not requested by these configurations.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> Based on:
>> https://lore.kernel.org/r/20241025172724.195093-3-sughosh.ganu@linaro.org
>> ---
>>   board/xilinx/Kconfig                             | 9 +++++++++
>>   board/xilinx/common/board.c                      | 4 ++++
>>   configs/amd_versal2_mini_defconfig               | 1 +
>>   configs/amd_versal2_mini_emmc_defconfig          | 1 +
>>   configs/amd_versal2_mini_ospi_defconfig          | 1 +
>>   configs/amd_versal2_mini_qspi_defconfig          | 1 +
>>   configs/xilinx_versal_mini_defconfig             | 1 +
>>   configs/xilinx_versal_mini_emmc0_defconfig       | 1 +
>>   configs/xilinx_versal_mini_emmc1_defconfig       | 1 +
>>   configs/xilinx_versal_mini_ospi_defconfig        | 1 +
>>   configs/xilinx_versal_mini_qspi_defconfig        | 1 +
>>   configs/xilinx_versal_net_mini_defconfig         | 1 +
>>   configs/xilinx_versal_net_mini_emmc_defconfig    | 1 +
>>   configs/xilinx_versal_net_mini_ospi_defconfig    | 1 +
>>   configs/xilinx_versal_net_mini_qspi_defconfig    | 1 +
>>   configs/xilinx_zynqmp_mini_defconfig             | 1 +
>>   configs/xilinx_zynqmp_mini_emmc0_defconfig       | 1 +
>>   configs/xilinx_zynqmp_mini_emmc1_defconfig       | 1 +
>>   configs/xilinx_zynqmp_mini_nand_defconfig        | 1 +
>>   configs/xilinx_zynqmp_mini_nand_single_defconfig | 1 +
>>   configs/xilinx_zynqmp_mini_qspi_defconfig        | 1 +
>>   21 files changed, 32 insertions(+)
>>
>> diff --git a/board/xilinx/Kconfig b/board/xilinx/Kconfig
>> index 0ff8440e6e06..a7da97dbae8c 100644
>> --- a/board/xilinx/Kconfig
>> +++ b/board/xilinx/Kconfig
>> @@ -40,6 +40,15 @@ config XILINX_PS_INIT_FILE
>>   
>>   endif
>>   
>> +config MINI
>> +	bool "Mini configuration"
>> +	depends on ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2
>> +	help
>> +	  This option disables features which are not needed for Mini U-Boot
>> +	  configurations. Mini U-Boot is running in EL3 mostly on size contrained
>> +	  systems. It's purpose is to program non volatile memories or running
>> +	  initial memory tests.
> 
> This is too generic of a symbol name. Please use XILINX_MINI or similar
> here, thanks.

No issue.

Thanks,
Michal

