Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC7ACAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 06:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D98468317B;
	Mon, 29 Sep 2025 08:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vk6aJ9O7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9403B831D6; Mon, 29 Sep 2025 08:26:32 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CBE38206E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 08:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/eTXdaGt93eTeW7djFthUYpuLsonCsw8BhxQGM3XFn9SdjaPonUwKPLtAkhYpahQrYeJZRZmsbRurTtkpiVjf1YeE3PsZuioR/P8c9FIENb5qwlK2tdeZbNSlcovpUwoFn+pJ0RwXzsn8QMWcscZSHw+fx4hup/wEeR5Y2ZmAjzTFT73+L18CSfHCIRVHMAgLMPLrykvat96rl2aPYXnv4Igb7RUJv+8W5gi3PFvCFrAeq2Rw6VO26tCcSEBorUkvrQwBqSmTExlOcvg+e7IQTufytYzS0z0HWf24o1pvX/jwAbxXjccLsMzXa/fuHyel0NPC6XwWY44QfiUOgElw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHqofkMxiLe6UNbOHk2sK/fUFNQeXfItQzwXqUd6D+c=;
 b=hLpCTddw1Hj+Lm8WUuiMfsBWloq887ehmM1+dRDn16imgCU8eaVAR7/7G7Qg+no0fJ3YDJuUCSIfoGzKoRE01KWzJSZuz+zERADBpmsnv//gpo0HeRkKJXKrtuZD2P8AV7xaglr7JK9kjWsTICypT1X7P4UdLcjxuWvfrNbeK0I39+NgD/+JoKW7dHOZnQgpHS5z3DOoo4Vq6urj4ayNP80dXeinXRlOVVLS5uS7E5gkhcYZ84IJcPImhQcdiMiWFhxYux/hnHIB4pavIIOdwEnamj5nrqV2iySIVeCQKVoWIImY5FnKEElm7jCNPadWOuFAEKt2mFXkkwex+tLWWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHqofkMxiLe6UNbOHk2sK/fUFNQeXfItQzwXqUd6D+c=;
 b=Vk6aJ9O7phuxB2bmMM70PgK2W9VFpT0MAkKFfp4cz3CKU6vfK3qRB/DDGKou5wIkGVaSRzW7c2+mFaFS2XgkIxoazZJwUBxd2iPucE+D/TsJMCd0YcgnljkcuxnbpyUG8+jYaYJOgO7o0TK9ZTDUwQsYncbIpzzooLfKQLZTPpg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ2PR12MB7847.namprd12.prod.outlook.com (2603:10b6:a03:4d2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 29 Sep
 2025 06:26:25 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9160.008; Mon, 29 Sep 2025
 06:26:25 +0000
Message-ID: <01bcd956-4c0e-4a4e-b66d-af2b8bb66424@amd.com>
Date: Mon, 29 Sep 2025 08:26:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] timer: Tighten CADENCE_TTC_TIMER dependencies
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250926153146.3680952-1-trini@konsulko.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250926153146.3680952-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0074.eurprd04.prod.outlook.com
 (2603:10a6:802:2::45) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ2PR12MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: 8177f85d-5d7e-47ec-ea10-08ddff211d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejkwYjFJbDZtWlhCQ2VVbzJNRTIxeFppYWVHYkRId28yRndKcFRhZFdhbVhE?=
 =?utf-8?B?VktoZVc2RitZbFRyMXkzQnlsUDRSNGk3WjZaWXIyS1JWWnZ1RzhUQTJ3NHpZ?=
 =?utf-8?B?ZUQxeHk1ZGZQNFdoc3dZTlpETWl0RDgyVkorQlVzWEpKd1FxeW1Pa0JSY2xz?=
 =?utf-8?B?L2dTa2dZS0VELzlHM0g0VHBnSVptUVlaUHZJVExteUlJUHlmS3ZZUnpHdXh2?=
 =?utf-8?B?V3JHRGdIbjFRNEhQbU9tTVg3WTNVbDdEMDZsaXNqd1d3WVVPNHFJNldhV1VX?=
 =?utf-8?B?ZkJjRDAxdWI5dEh1cTRNa256NVVYaGlkb0FTQVB1b28vZjBFVkJtRHk0b2V6?=
 =?utf-8?B?Z3NmdjczT2VqQVlMTHp3WFREVlFUQWRQNlNvanlJUjc1QUIwc3pLbC9rOElE?=
 =?utf-8?B?ajFBR1NvUDd3eGRORjdIaHpVVGNBMWREdnNRMm9YV0FuY055bk1TeC9QUjBO?=
 =?utf-8?B?QWdudnFldFR3Y2FwSjRXYlFoOWlZcWFMNjlzZDR4eVpVeGRtamFVcUoyT3hI?=
 =?utf-8?B?TzVVYjZOVmIzVU5SZFF3M2FPeDZvTUVYaWNpc3BpQXJwUWlOUEdHL1ZSMGNB?=
 =?utf-8?B?amo0cFhXd1dpTGFyeEVaQ1FxZklHZjVCYy9FK3BxWDBhUDhZK1U4VXlQRUI2?=
 =?utf-8?B?M1RyaThOVndlS3VzK1hvUlVpQ05yZVNEWkdmUUJwQ1krbE5XU29lOWZNWjRZ?=
 =?utf-8?B?VkQvNDV0KzRNaTB3M1NiYitUZG5jL0xMdkcxcDNyWkpDNGl2eXVHWitaVGND?=
 =?utf-8?B?Skt4d0E5NzF1VG9oZDVBTjE5Wkh1WWJXQWl6L2pTMGhZYjlIaXZJYXFtZzQ3?=
 =?utf-8?B?Z1ZIVmIyR3g2SC9zQmQ4QVpZVHBlbVp4ODRnVW10MU9Cdlp1V2JqV3dveWJj?=
 =?utf-8?B?WXQxSFpXK0RaZldhQ05ubFdDQ014VjlJQm41T05xS0s3TldRSU5WRXNWZ29I?=
 =?utf-8?B?R2hkOGNyblhLbjBxak9TbDh4V2IxZUNXNTNRZGFzdTBCaGdra2Y1WGs4aE9M?=
 =?utf-8?B?ek5qbGxZS0ZzY01GQy9KaDhHV0ZOVmpSaDhoQ0JSQ1FFeStWVFpsOElLUjlX?=
 =?utf-8?B?MTJkTVN5cUx5U2FNR3UrM3lLS2o5cmhZZzNUaVNxVXVkUTVmRUhON2k0bXE5?=
 =?utf-8?B?T0hlSTB4UjlMaHk2MDFTbHlyakpJbkVUV3lRU0QwZXhFd3JLUlBEQXczc052?=
 =?utf-8?B?OCtySzJaWlRGUnRlWTNmbkluK3dtOGEyck1vWWZ4K0E2eUkwNHUzbXVDT2k2?=
 =?utf-8?B?VDZGTUlaZ0ZWTm9HTEQyL2JudkdDaE1tWU9FL0RoVGViZXViSWFubXlyV1ln?=
 =?utf-8?B?ZmFhUi9aQjhpWXlsK2NkcVNVcHA5aTRkcjdnMTYya2laNklHN2wxdG5vMWNt?=
 =?utf-8?B?a2RKWDNoTVZLT0w2R1YzNDI3ZU1hVG5uemZlTU9HSEc0SFQ0QStjVThiV0dN?=
 =?utf-8?B?dFoycG0vWlRHSHdkOHBuZlBtTnJIa0ZQQUsyaUFneFExY3Rtb3F6ZnNGKzYz?=
 =?utf-8?B?SmR5ZWxKaHp0VlZQZjc0WU1ncmQ5VzhsY1FOOUluVU5FVWZ3RU9jaUNTRFB3?=
 =?utf-8?B?KzdkdmZjRXV0b3JKcE9ZenNPdWdqWHk1Vk5QV0FSOFJNNEtHQkxBSFVid3Yy?=
 =?utf-8?B?UjJITHp3ZnRmSlQrRVRSd2o3ZDhheWZYMzFtT1ZTWVJ1eWQ5RnkrSi82YW9Z?=
 =?utf-8?B?bVdYWDI5RUtsWk53Rjg0Nlg0TkxqcUx6YVR1NVMzSUM4c1ZpcUhSY1hRTVU4?=
 =?utf-8?B?VTlNT0VTMmU1NEphRThjenQzd0N0a2VqNTNuVCtiaTd6ZCt5U255VXAyM2FM?=
 =?utf-8?B?SVRPc2NHRWQvRW9uMGUxL0duVjVnWXZQZnJnTGJFdlMxRGxiQVo5QW1ZK1k3?=
 =?utf-8?B?V0tmSktSekt1d2tTUXV5aE1VUkxYdWdUMjZTeVcxTGx0RmJoaDF3am04OU5R?=
 =?utf-8?Q?I0F9i35H9mxjAfDvvlOC1R8sSPKAWH1K?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2Z6cGt4MjFzYzNYaXE4dTBJT0gwNGYxN3Nra2JwYjZ1L2JScWlpYkE4Ync5?=
 =?utf-8?B?b1pzZXNjTjNzVlNpV3BtUTZFVlBFaUpkTjZjUVB0cHN2TFpWY0pPKzkvUGF5?=
 =?utf-8?B?dk01OWZibkNJVDMrNG5hNVcrZllwLy8vWGIwU1B2Qm5JdU82TXY0OFFkMXZ2?=
 =?utf-8?B?Y3E5VmY3QzRQRGZWOVR2ajRUSFpRWDR3SmlDYlAzUEptRjZURndRdzgxMWF5?=
 =?utf-8?B?NDgvNnU0UnRtd1hnK2J3cmtsU0pjdEt4aVI2ZEZpMnVaWXlrSVZ4S25wMDVO?=
 =?utf-8?B?a3ZVYWRMcEducUtlbzE0SkJKYjZkbG1YSSt5ZjhHOG1NR2hNdHBqNDQrZUlo?=
 =?utf-8?B?cmppeTFKV3dqYmR3Y2JsNTN0UU9Lb3NsOERSQitCVnREZlBFUllkWk9RN2x5?=
 =?utf-8?B?a1ZaU1VPc1Q1RVBKc2V3bkZSbHB5SStYL2dReitxMFZJQkFjV0loWHU1YzND?=
 =?utf-8?B?UWRTczFOSVhBaVYrT3hnSHUyV3ZqTGNPcHZHaVBSZjBtSDM3SldKTWpGeVQx?=
 =?utf-8?B?SXNlM1k1OElMcDBqUWQ5dkNtU2FHRytHam05TU5aT2Z5RUowV0oyNFhvWWRC?=
 =?utf-8?B?TXJkalA3TlFOSG15cmdoT1dnNnF0dHNxWklFZi9QM2JTaGZJR1FoeDBKL2xW?=
 =?utf-8?B?cm5sU21Zejh4UVZqRXQxTXdXeWFYNWFRaEtPL21KbTE4N0tEUTIwYkp2MW92?=
 =?utf-8?B?OXRJU1pLMnBRZktRdmx0eDlVc3EzWkE1dklHdjhyeHIySVplbkhmbU9yNFAx?=
 =?utf-8?B?blJleHVQNmVwQXJCTFNuM1ZpcTJWQmFFWHdtTW9mM0x1WHY3cFoxbUhHQ3VJ?=
 =?utf-8?B?V3JTOHBMc05SdFE0amRsYjU3b1daQ3BuU2FoUlRQWU81VTc5cEtQNHlsdXJq?=
 =?utf-8?B?Ymo0amErSW9rTWliUmphbFovKzZzTjc2RXh1V2VrOTZYV3RzRnBtZFNpWFJz?=
 =?utf-8?B?ck4waE5kb09LQW9hbEExNGpzek9KckIxWjErZjl5UGFTZE44eU5JZDk0QzRH?=
 =?utf-8?B?YlQ5ejJhSUpUQy9Yajg0NVVNeVRIRHQrQ09pSE5lRjZHMTBNSWNSK2phZk9v?=
 =?utf-8?B?cnVBNEc2azFKZzB4Q2V2dk40V3F3WkNya0Z1dE82M3dqUDgvdzBsbXVubm55?=
 =?utf-8?B?NU54OVVud1R4OEJjbklwU250akZ5SXNVOGlUUFQ2Q3hCMWJEZ095c29VWGM1?=
 =?utf-8?B?bC9aQnArMXZNRDVtbXRObXY3bzBVWWVFb0lPdnNibVFpSWdLUUo0M1RvdlpB?=
 =?utf-8?B?T1plWXVxSkdlbER2cWZXU1FtajF2Nkxjdk96VG8zSGFQWXFBcStzRWN4YWdu?=
 =?utf-8?B?WEhnTEJvVWNUNWRzUWdWN0hXL29XY0F3K2ZHaTMrSG52TWpwK1J0YmRtWHBN?=
 =?utf-8?B?UWZoNzB2a0k2S0Vpb0RZYUM0N0QveWxYSS9Ra2dTV25VOG9pOG0yeEM3RHlI?=
 =?utf-8?B?bjhqTUZrMjBONlArZ1FlUDUvK0o4MExtU2FHRHFOMmgxemJiM2MvdzdaZTVn?=
 =?utf-8?B?Q0hxYUdyM285a0VEZ1FrSjJCYkZHRWF4Uk5IeXAxWTd5OENBS1RRazFYTDVx?=
 =?utf-8?B?N0dWdXhxaUF1cm94eGQ0dWFaNlVUdnF1OXFFbkpyaHM5Z0RZTEdWV3Bwelh6?=
 =?utf-8?B?WXBkS29QVGREWC94RkFFZjZlNlh1VmZnNmJTYXdidHZES1FkUHhWMUF2MFQ4?=
 =?utf-8?B?bEhteE5RSWVhRVV2dnp1Y3RxUlBBU0hyYnF2Qzl1a3RyWHBiMHFiTFVOZzVt?=
 =?utf-8?B?a2drZEJhVjBDSkhTcUhJNDBzYXF0YWZFTkR6N2JBYk4rNUhrYTNJL0JIbGZv?=
 =?utf-8?B?eFVvT3d4b05ocVFNRTdMNGdabk0rSDdmcDFBOEExYXlmSGJGNjQzbzQ3Y1VL?=
 =?utf-8?B?VzZPR2NTZUJrL3FnUnJDekdYVThYei9jYmRqTy9DcmN5NXJmcm1MaE1HSEpq?=
 =?utf-8?B?bTVBWEpGMExDTWwydC9mbkFMT09ZZ3J4Sjk2b2RtTlVycWJQS00xb3pTeXpJ?=
 =?utf-8?B?VGQxaW02SWdmNUJUcFh0WkpoMktLQzBYS0xCcVgwZ1hUTGt1Q0RWWkRoUUFq?=
 =?utf-8?B?SC9xTWcwS2wzTXNRclMxZmZFTktnY3NHVFhmdE5lcWFnenRXQzZxL2hZdy9r?=
 =?utf-8?Q?SUXTKhgi19029cFoYJmqZhRMy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8177f85d-5d7e-47ec-ea10-08ddff211d51
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 06:26:25.0463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RbeFImTSbA5IXE+BdBZk6FCn6ED8To270GyrPew5MLMWCOT3CtRPX9s9PJBcXkIv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7847
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



On 9/26/25 17:31, Tom Rini wrote:
> This driver implements timer_get_boot_us() which is global namespace and
> can conflict with other implementations of the function for example in
> "allyesconfig". Start by limiting this driver to platforms which use it.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> I know that the help says Zynq or ZynqMP but only the ZYNQMP_R5
> architecture enables this today. I'm happy to expand this dependency
> more however or let someone from AMD v2 this.

I don't have a problem with this because arm64 is using arm timers instead of 
TTC. If there is a need to use TTC we an fix that dependency.

Applied.
Michal
