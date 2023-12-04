Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16633C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 07:35:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB78C87825;
	Mon,  4 Dec 2023 08:35:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DTUDX/PX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA37787812; Mon,  4 Dec 2023 08:35:36 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBF618759E
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 08:35:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2n4tnE9FczZpjSKTfaAbU1squj85MkziMy0T9R153WYrLZCnoa0gJC3+D0PscWCsx2rc5mhfoNEQaQzyht92DNJGNiXeEMG9Gd5wUHjNux5B9EZ70Eg+rfiDeqjSggPzQSV8SHxWu+hKaZaK3HYEMWrfVbtkRFdp9SiMBSgHWN/WykkgyvxYsHHsI+RflXlDyl3q7WQjK87fSL1sOLjql8Q6283T/rZuv99bxpBiAxlc74eFICkTQAONN7dsAqJOEsjGMFP8G1hdx3gDjt7SNJfJGJ597ckCcA/Egv88g2HNeLr2q2KDqw2LPdxDUHOm8PrOy2CmHcaHMOjv2/y9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L30VcXO7nt82WSk4Vfoys7kpOTgy9EnjyNXVQGEA6iA=;
 b=MsPqHHlgZarMlyTwAA2L15DCRHVJfAcxgBgRtzHPWv0ta8WmxqzZYMTs93JtPyLfxGpBrDqBwfAxEPGOfwrv7ilTzloxMQuJ3b6xdjGGwH4nvrOUxVYTLSRaIuPDCiisSXj+AGdXHk8w6ctMAf0cX4oIYVr3nBJxaot6Qfr+ZTZ3FNmmIaTApntfLAnpcxGK4kGVwUlzKBQOKtyruc6wRWD4WzJ3RLFn18GG0KMGKW81SrhIgyEUKSyrcGOHhdd6SOvUJWM2IjVUN8NeUq4Lk89MW1iM1VnDMX+EKBne364jyhqV2yatsWK/0g4RdoIg9P1VwKVLlxws5QV8JXYQNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L30VcXO7nt82WSk4Vfoys7kpOTgy9EnjyNXVQGEA6iA=;
 b=DTUDX/PXhG/AKyCCiqkpXN7/y1trzB4IdgLUWshHPOB5ca1Y7lE10GbMTT48gyEGHlLYNLNqsH/aOlyxkTQRhYf3Xkc8XStccMbqBD+aYw/Mki2xn+2FWUAjWjwCXoGj4uixarPt2UxXdNXaFXuaXgO8R4ZuEhc09SG9uC2dpd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by BN9PR12MB5083.namprd12.prod.outlook.com (2603:10b6:408:134::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 07:35:31 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 07:35:31 +0000
Message-ID: <89451eaa-6e6f-4e8c-81f1-35ba27cdf885@amd.com>
Date: Mon, 4 Dec 2023 08:35:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Add IS25LP02G flash support
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, git@xilinx.com,
 sreekanth sunnam <sreekanth.sunnam@amd.com>
References: <20231204032735.9786-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231204032735.9786-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0047.eurprd03.prod.outlook.com
 (2603:10a6:803:50::18) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|BN9PR12MB5083:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e7174c4-a85c-4bfa-0c00-08dbf49b9829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aRMaS6RSqLbs1NDtJ4nEHwJ2Bbo/GEPkSORMxgDDBpgbuXvmA/gk20M+4DaMwQqdASCrif3FfKvoy8S2K1M2Posh6AxD5DOOxIDUZDVF3RO2Ln97es9+8jJRIKTxc5Aq5bFSg5D3+Rwl2AULws0ifZ2U+kYwFnhH4nvPUAMnScobS8OnHc/FWgrfhxoSzOSrfcewbfVg2PSHyaTtBA3Hw8droDzeBa2DihSNeP08TxSYOZ3EGmGCIJF0T2R8ilxWTmkX0GStcHS5wUkYGdN6SegpP0C7OAyiGM587U7Gm/rddDQHHSUUSAr6aZJlFFOLMGpZLXdRQDv0jQVMD9d+5nsDjRwCHSCs4/siIXB++pLu6QyOUnGJ92FUtNRLChXyVPvJSWzVHhgxD+fY55tOHX5eBP4C3Zs9jIXFgqM8JD4BJqMNu9vJQiDyHgub/sY09bLClAVbHJTiqts6TL9dh/Aa+paXwSiKWjHTS+FfZwJYRGoAlKKwEsf+p/5DXK9I6rMBpclT5OfwOp0XvYpkMgljMEgluIGtdTzNFMFanpHGIUFmfUNQbMM1pBRwIRDhbumAQjLtUQItsJlUH5RZxxinp5CeksMYBzCj4LLZtH/df7pjLA1FMgKm+7GXGjHLonU9JMWPpdz1ZoarMpDE0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31696002)(558084003)(5660300002)(44832011)(86362001)(4326008)(8676002)(8936002)(2906002)(41300700001)(36756003)(2616005)(6512007)(6506007)(53546011)(6486002)(478600001)(26005)(6666004)(38100700002)(31686004)(316002)(66476007)(66556008)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3ZSSTB6R3ZlbTUwMGVEbVl4OXY4bFo4VzhDSDFqWjByNUdwRm9LQ1QzMEpZ?=
 =?utf-8?B?WHdKNmttc1B0VmViMzZEcDVIZmxEKzVDL3l5Ylg0U05hUWFZMExHRFc1LzJq?=
 =?utf-8?B?bVU1TDhqc2orelZMd3RndWEwbkk3NVE1WUxBYzBKNk1QQkxMTnRIdGtrZjFh?=
 =?utf-8?B?NDMwd3BtaDNmaGVUakxVYnFzN08vTm0rVlJZMXoxbnRBSVVjUnFsb1FpcDhH?=
 =?utf-8?B?VG1kOUg2bFIrU1g4K3oycldFZnFTQWk0UWIrSVVySms2cS90eTVsZXJOSElr?=
 =?utf-8?B?TVNkMTRHNGRHODI2TlRQVm5xZ3FLOXhYUzVwTGVxZ3dOM1E5Rk80N2lKQzhL?=
 =?utf-8?B?Q1BiZ1ZCRGNQOHZBN2M3Q0hMZnBNRitnZkpTaHdsU1RBU2RvNGNPeTVzQ0tO?=
 =?utf-8?B?Wlk0dklBQmF3aTBWOEt4UUxzSUFiWUFrNVU4dWl1RVZ3WXkybkxicWlYNnhG?=
 =?utf-8?B?TlRSUTV0a1VxaEpVYTFjN01BMUYyMEJTZ21rVWhjRkY2RThaZ3o5RTA1UHNW?=
 =?utf-8?B?SGJ3cVNCbE02a25WalVXeG8yanNKK3dRV1BnWjgvSGVEQ2dqR2k4aEpBRHZm?=
 =?utf-8?B?d1lsM0JRQ3V3TS85MVMxUFIwSmx6MkNMTEY2K0xLQVpMUFd6NDF0S0tvZFZX?=
 =?utf-8?B?SlZWTWpiMHBxYmZjTWNGK2lYbDVwWFJMVWh3Smx6akFJeTdtdVdjSjV0eTB3?=
 =?utf-8?B?VEY0ZDFMNkEvMmNjclhtMUtiRzAyTS9rN3RXSW83dHZWQnJkK3JOSGtPbXNV?=
 =?utf-8?B?R0M5UEl4Z3AveE1rMWppTHFSazlhWnRtOUJLekFsTFlrRlQ3VUxxZ3UxWks2?=
 =?utf-8?B?a29vZTVZL1E4cUk3NDF2M0tISG5wbVMwZjgwN0lWdGszVFJPcFd2Uzl6elNp?=
 =?utf-8?B?RzF2WnZvSGJFaEsveFBzdmxnTzgyWFUxdEl2THZ3NUJPOUFOU0M0MytwVUNB?=
 =?utf-8?B?T0tLU1JUYWJXWE15bThxcjMvc2FEbU5saFQwemJ4dmhlb2V6WEF1YmhmTk9u?=
 =?utf-8?B?YndsMk02Y3o5OGN2YmlTeWRhbjZ1QkswQWQ2UnNqRkZ1WjRNQjRVc0NpNWlK?=
 =?utf-8?B?Tnc3cHFZS050elR0bklQZG9RRmgzK3QxWlByUFRUMWFiT3RhZjVyZ3c2YVlT?=
 =?utf-8?B?VVJOaVdIVXB4UjR1QWs5Qzc1U0Y2SVh6UGNBMm5LdHZqZXI1bW5qdTZieXEw?=
 =?utf-8?B?eU1nZXlTOXpjZEFKUldyRVNLd29kbzBhalZpNGF5OUI5Y0JKM3E2aW96UFhz?=
 =?utf-8?B?WHVCZGVpQkVTbUtrbGpWdkJPQjJSZjN2R1JveUVOaUNEa29FQ3hWempJSjU1?=
 =?utf-8?B?WGdBOFJTOVdhNTBWRmI2QUJwRkhpUk9ZR250ZDBUYTY5YzVhSENSNmVJMjdi?=
 =?utf-8?B?dG53bUs2Wm9yTmNSNXVpYm9OT3YvVmg2N0pybzl0M09RVm9ad0FvQVdsL0ZO?=
 =?utf-8?B?U3Vqb1lpQjdUNVNvV2hPQUdkRmI4UkcxR2J5S2E2UkVkbkRtWWFzK3l4R0th?=
 =?utf-8?B?TFkyS24yL0k4d3kzVFRmT2t0eFMyZXI1UnNmM1NhL1hpOXd4TWFtUEtrSURt?=
 =?utf-8?B?K0lTMHlhbjIrRG5PeW4zM044MDh0TWR3WU9Bak9OWFlPL0JlS0Z3V1dLZ1JY?=
 =?utf-8?B?N1haMFhzcTZaY1I0MlB4R1RGNjVVYTVIQU1KRkxlMGp2TDhybWhLUnpQdVdm?=
 =?utf-8?B?d3hLZjNsSVhCVElid25pVkttakwvd0M4YzREWWRBVzFzMkVaWVdPZXRENmJr?=
 =?utf-8?B?Y1hXMUFaellVZEwzbitSYjF4N3N4c1VYOURSam52ZFRrdE1IaGs2RGdhNk5V?=
 =?utf-8?B?Y0tJbEhIKzdzZnV2M1FxSmNlL3VSMmsxaGZvR2VJQkJEOVhneGxJZ0ovbXhj?=
 =?utf-8?B?aUYvZk9RVFIyUXFwRXl5bW1yUWcwbWZ6ZTdyRFFtM2JIZkt4R1RJa0YyTXRJ?=
 =?utf-8?B?cFpCcWRxaWkxekF3QzNoSUFKeVBVRXdMTUFLNTFxUTkrRUxIY1RlcGUvbjVu?=
 =?utf-8?B?K0JzSGQwVG0yb3BKa2hxemFFdVdIM1NlZkw2cUF5dDZSNEx5Z2ZKL2pwclVN?=
 =?utf-8?B?ZGpidUlrR0pRL1JISnN4ZlB5RW1ibTJGK1RXdEJZN1p3cjJNbWlCdlZ3M1Bk?=
 =?utf-8?Q?fdxciogoghDJNhqJlWV8LYF7D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7174c4-a85c-4bfa-0c00-08dbf49b9829
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 07:35:31.5594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUOna5gFYuVpcfjSwnLK7Zr0x2B9Z3pv+chpSi8FoZiz2XU6TmhlnEjrcT3K8Qzr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5083
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



On 12/4/23 04:27, Venkatesh Yadav Abbarapu wrote:
> Add support for ISSI 256MB flash IS25LP02G. This part supports 4byte
> opcodes. It also supports dual and quad read.
> 
> Signed-off-by: sreekanth sunnam <sreekanth.sunnam@amd.com>

Likely Sreekanth Sunnam here too?

M
