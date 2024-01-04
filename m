Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BBAC47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 12:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11A9287952;
	Thu,  4 Jan 2024 13:00:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tiSRf6Zx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D77887950; Thu,  4 Jan 2024 13:00:28 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::606])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4A1487954
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 13:00:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwjGIxqLFhPnnXYGbQ7SQ7KBWEk4muB1wWtnJ6sW3tgvQjV4T8OjU/sVIU2KURnoasH/vuBDUyih43GF8OPRcsWG6gw2I6JYt2O+ldvahNsO2DA0yVKbVGKbQ3v9lNLg08jSpUpvlQw6q2M2y0OlOl4CYkF7rUurZLkq6hNAplSF+qU7DwOQ8jYtehfrK1rZQm6NU3mX2aSECSXphFgHrDHsbDbA7dlibivIp+bcJ6icwwjeZEDLwVnDw4Eo3VzupqDdv/gOqC2tRXnuRxijFKLdnLQ1cQrYPgNWJrQwSkFFheHZSNEDPNGv11iitvKmffdNcgeebdZQJ2ChSKVxSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLUSyKwaVmKw4LruhrylMtaHUQ+ClHNizdy5kpleW4A=;
 b=QaJ6wQEyUIPtrKCa5ryL/pqpj+nj/xzkduxm8/JeD1pDlGr1J6h/PEeg0Sy8UZuh09yfrGX1Qgw5P1ADk0sbOLK4EbNvkK/gof2rJYdXkR9/KAt6Tz294v3Pdm/ULs2zxVoYPZmhf3XMlIQBZqBCSoh7Gp39M5h6naP3renDOl2CW+c+4TtjBheTbcb/JYVsOHJuNariR5sKy4VHwsujKoL+gTS/wKPVXXo1XD1Mn2j6/s8CgsKpwIEOB+32Gej290Zq2VUx5LdrGb0ZmCR9WoGFfAta7bC8ESGAfkhCMAA4AGmr5bWjh4HJDuE38UgN430Jqsa+jzf56gFvNDISnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLUSyKwaVmKw4LruhrylMtaHUQ+ClHNizdy5kpleW4A=;
 b=tiSRf6Zx19lhSo4+26c2GQmp8atA/vVHFhWzGej0o1S75l2aWnT/1JtLSnhMLvnzJ4PQrN60Dy49M+4CBmlqFwAbY2SJow735a6p/8Tr6ZKVszmSfshS30RGW6Fr5RYDW5oL5k/wRRJlxgV4KYAGlUk9f5S84HCvT0qqXet3MkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Thu, 4 Jan
 2024 12:00:19 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 12:00:19 +0000
Message-ID: <45cc3cf3-4120-460d-b275-fc019156ce20@amd.com>
Date: Thu, 4 Jan 2024 13:00:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: sf: Fix sf probe crash
Content-Language: en-US
To: Weizhao Ouyang <o451686892@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
References: <20240104114619.280513-1-o451686892@gmail.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240104114619.280513-1-o451686892@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0095.eurprd09.prod.outlook.com
 (2603:10a6:803:78::18) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: ceb754e6-a704-4fae-5895-08dc0d1cb91d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SY8jAp9q0icJxM86NE5ulUfYa73zK5FGwrkBvohWzGci7cNZf/XwMIPa7h0tVVRUAb5A/QZr2vcD3kv/HFIC0pmsa9/x6noxKUd1ySPCmEvxJkWQdHPPE5TQajZ6QsyKdoFVwfdO3SwH8ape9l69l49ZlYnxMxjmnsfyyzeALgNUGJKTUtpXi4WwW5CrTbyrAFbr2nVuNa66ZaNn2DS+fGyJzBw9uKkyQ3R+La8aoZO2YZUhrspWFYCeTao+EhBaBc9vDVmocvqJ2NW7U5U1A+VLbEqSjla+VwIOsWkZAOBqO31lp68JMzT4f8OJBonM3NjWsgGNkD6dJS3d77hokRYNAAv4d12MMNuFqp0tmnWlDAJZlywdL0O9/YUYZkgp7/xhebxMooRIit5KMcKxuiSsIizCVD3fhuNuOgjzpkCZLBCg/f8uKf5CBrD1Tt6PR6Yih/CfDZfzUbGzAYuMDyM35sYp4mEBeXxcFfzXOA6ZXDkVdePNReBVDots8H1eizLt0d/9w0kRWr6YiycFacB/FfXfpc3781OkCWs7hc7ugu1o684h0IB4i1iEd5ZixeB8Wq9x9vcTqtNYEDThyg7v3AeFT9ygNzpMcRKW3f79HF2O3EDsJrag4hgv/TZhtO9abYTpKFgRSbNctRMmlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31686004)(2616005)(53546011)(6506007)(6666004)(6512007)(478600001)(6486002)(26005)(38100700002)(36756003)(86362001)(31696002)(4744005)(2906002)(5660300002)(41300700001)(83380400001)(66946007)(66556008)(66476007)(316002)(110136005)(44832011)(8676002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q01ETEtuKzVpWFdwSmxIMjJpYy9abWN1a044VTFvbkRXVW55MGFSVThZQ3pY?=
 =?utf-8?B?eGY4L0N4UEg2VlNsRU5BTzUvNGhyQWxYOStRaGs2NW9wM0JmV3lybGRXZDhQ?=
 =?utf-8?B?ejR3NFZVdG55NmlNeHdRNDc4aks5S3FnWUkxZHZZMVo0MkdNbFEweVQyYkxu?=
 =?utf-8?B?S1V5R1o4cC9zeU9XZHYwRUNtQlpVWnh6SVF3bVNjU0NpVDIxaGpCMU9VdUMx?=
 =?utf-8?B?N3duaWwyN25NS2RyOFN1OWZjUitsYjdrYjBhM1JHOEpQeFpRMDVvRFJTVUdD?=
 =?utf-8?B?MFNyRHM0WlRFNnl1bjNFZEJGczZheWlnWXBYNVhRUnRTcFJxeUJIb0VONzZo?=
 =?utf-8?B?S3NVOG9PZ2QrcGlPZVdnUjJuYmdrYzBiYTZrZkdjZFVXeWdQdm8xSStucm1H?=
 =?utf-8?B?YUo5UDBRK2p6aURMQjFsY0RiQURwaThVQVNiRFU3QmQzR2l3MENrWEx4R0lJ?=
 =?utf-8?B?OVZvcXQ4NnFHY0ZWdXRBUFg0eWZyR0YwQnpkeVZNNy9CSW8vRjBkQVFQVmpW?=
 =?utf-8?B?QUowT3crc0wzRXAvQlV3b3FaeFhZK0g3TE5ZNitKZGtqOXQzN2VkNVJ4Qk00?=
 =?utf-8?B?KzN4dHdlMEdNaUQwR0xmSUV1OVpXS2JIK1g4UkxBdTQ5Q0VhV2dFQmZxT1JC?=
 =?utf-8?B?NnA5WC80RE1PSG00eXZwMVVjanBrMk8wR1NicmJNVUZzbDFQVXA5UlRCUFJY?=
 =?utf-8?B?eXRPWjl3MERZVHI1a1ArcjFlNzhGTFJUMXJDdzVFTUlLSnBrbWdXL2wyQ21G?=
 =?utf-8?B?UTJnWEpsOEVoS1FTN2FQZ3RteEQxbG8wb3QxS3B1c2FkUUJRWWJ0QllqTStJ?=
 =?utf-8?B?T014dytHQTg4SVBrOC9xM0ozR2JyL1k0SWlLV0xLL0tZWGtEREE1cU9JcXBj?=
 =?utf-8?B?b2IrdnFDLzBqS3V4UkcxSFhzUEcxMUx0aE9MYjBLN2UrdDFNTXdCN215R0Ru?=
 =?utf-8?B?K0M5WG9YUXBYSnYyVUtuSHJFRDhmd28vMFdaUHYvWHNyZ3JoOUtvRHJaa1V4?=
 =?utf-8?B?N2d4bW1rT1VBa01xbU1QV3FqejNnTVJ5OWgwU2FJY0RWZTJkMStaMUhoQ0ZO?=
 =?utf-8?B?WFFxNm05STFvYWFYVm5RK3lkdTFoLzJPYVJvSmpDampTSHMxZkVVRzIvS1Jr?=
 =?utf-8?B?YjhTcFlnVDhOSlhYajJXQXorWDdzWm92T0NCVGU0bDY2ZzVOb3RCQTJhK0pN?=
 =?utf-8?B?VjNyTG5BN3VoWk9OckN4NVA2RGwwSjdIR2pyQjF5ekw3ZmdUZisyOW5HYWtT?=
 =?utf-8?B?WUcxWk5qZ1NUWDVvVE9LbUFySkRaWFc0RU1tOWNXekFVOEx2K0dHUXhaeFIx?=
 =?utf-8?B?V2kwbFkyRWw4SXl6Tm5OanVpSEh3U3h5VVdjMjM0L1BJb1Y3UlFvSm14VFRs?=
 =?utf-8?B?NWtPc1p1dTZkdG84bkpjcjkxZ2dyN3I4SFlvaTZSSmlQWUk3dSs2cGpjdHlM?=
 =?utf-8?B?T2JKOUJTYW91SVpMaktnQWRFa29FdXJGTmxZd3JON2s1MDJFTjM5eHZnL0tN?=
 =?utf-8?B?R01pdHladzU5dnFLZHlFS1hGUWI4MnhNY3g4L1NlSVY0V25SRTZ0UDBMc1o5?=
 =?utf-8?B?MUttc21wWXVFSlFjZjZaT0VqeFltWXFvQ1VycE1iV0RWL2ZNZHBxSTIxWFcy?=
 =?utf-8?B?aEY5c0VWbTNQN1d2NldkOHQzK0xWaVJjQyszQkxmazdSRVM5MDVjV2liL1pL?=
 =?utf-8?B?MVlpWjhGVWlIYUVPMUxMRHc1NHp5U3pxRHlLY3BvRzFaTVdWUFB6ODlhRmtn?=
 =?utf-8?B?c2FnU1M2VGdSWXF0ekpvVkxsamg2cG1QTXRWOTZmL3Zwb09vMTRoYWhHd1dQ?=
 =?utf-8?B?ZmlsTGFLdXJjYm5HNFRoM0JMbEl0TVJ6NnlhTVNTWUo1R00rcHZRQXJHVVNs?=
 =?utf-8?B?cGN5elVpN2VXQm9CVFBoM25zSWJxOGRIZGZ3Y0J0aEJ4TW1NTVFxNVZmcXpx?=
 =?utf-8?B?UWZtUkhUUjRCWDNBTmp1Vk9EeGhjNG1TYUJOYnFvYkF6eDJBNjZSbkUzTCsw?=
 =?utf-8?B?WWpldjhtUDV4eFNHb1AzaWo1UUtKUElHdi9VQjBMcmhFeC96WDdJZHdxdUdE?=
 =?utf-8?B?ZDNuaUtiUDkvTDNMdExEWms0Y0xkU0dPazZIbGlEUFVnUkhTSkNpMHM0Q2Y5?=
 =?utf-8?Q?yjAXQSyENssXnGPCqR5ZJhmYY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb754e6-a704-4fae-5895-08dc0d1cb91d
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 12:00:19.8288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6hRZplT+wsBxSGY6F+0bUEv5qKezYcb97ctVI4h+27GIsBkWFaqiOqkefZrM9Y+w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598
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



On 1/4/24 12:46, Weizhao Ouyang wrote:
> Handle the return value of spi_flash_probe_bus_cs() to avoid sf probe
> crashes.
> 
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> ---
>   cmd/sf.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/cmd/sf.c b/cmd/sf.c
> index 730996c02b..e3866899f6 100644
> --- a/cmd/sf.c
> +++ b/cmd/sf.c
> @@ -135,8 +135,9 @@ static int do_spi_flash_probe(int argc, char *const argv[])
>   	}
>   	flash = NULL;
>   	if (use_dt) {
> -		spi_flash_probe_bus_cs(bus, cs, &new);
> -		flash = dev_get_uclass_priv(new);
> +		ret = spi_flash_probe_bus_cs(bus, cs, &new);

if (ret)
	return ret;

don't you want to rather propagate that error?


Thanks,
Michal
