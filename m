Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64AAC3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 05:11:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB704878D3;
	Wed,  3 Jan 2024 06:11:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="fUzlltWy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2288878E7; Wed,  3 Jan 2024 06:11:01 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 316A387895
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 06:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEAbSnO5IdQKLAW0AWOoVUeXf+VTeThTZIUPFFIxIuQF/cA8sjdZgkYrGLkQYHJhLMXp8PhcodO3oKp7mFJi4LJiTrtrDGEP8rtLY7f5D0EaGlkrvhdeatGw+x83qzQr+YkgYO4WpI1x4WklBpmGSXchyNLVhP/5VCq3nuJNncAuuUvNaFTObrZmbL0EX4fSHXHrZOPtZrSE30jPHdXrFJk8x1nIUzzu/RDG+H/upnOIDTAyruCARXnoBCZ6Z0cOYDP9y757h7qtyApP6Ilv65lazGqd2SWIbBW+8TytGbJzwglTNInPdYWKHLgQ7VXUWEyF5sCb5Y2nc7Qor6O0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKwP6uKpKNcGgxiZVY4kiTrB8RL3NQIouCHMFlj+Npo=;
 b=YkJRFz212Ga2/X1SnhmyEZ2b0AJ2++6ejX5HJTqR2xNaKjdwJjiP2XLTNH9NWAihuUz2f6kkGUmIyHclMWz2XXTS+1tJ3itjGQ05hz5NPP0gUTf+fxFlu+VJmjqN7DHGiG6q6rq7XoazmQ0OhAsBChd9FxC/r/i7QoJ6Ko7XQUqPuwp9GvNySdVugCrIhxMxZP4dhRjq2L+PNn5p1IilqbwzT+vBweC/vBenRcnJGQhpqv2ila2lbEC3edGcipr3k5yfBnhpBbRqGclTGdDuyHq8Uxx9Gvd10440OCGirhquq6qRQ4yNTypeXwKq13Xm66S28mug8xA1YL/d+MC+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKwP6uKpKNcGgxiZVY4kiTrB8RL3NQIouCHMFlj+Npo=;
 b=fUzlltWyeRBZBUaG2wnN11gF7bNccDVclFLBW2sKRtWsH0JBp8p/vHwyBn/ii0DNP7O3yUlKroGqnxDa2dMAU0L0QPXKDbmHPlfUrtnA06uypGXXHSlbqQ9qd9rQmR+B452aNFy73SX1oRWcjEYUwg/ViztuWz9blBUyd4OV5RJfgcTBNJhq5M8QEyeYAMBPPT1kMAjuKOdTf2fORY9EJh84WdpZf+xQ1fIwRFDGXQKEF1x70UZzxrYvakncATWMYaQ6r0yaY3tt3Xswcw3EtGgijgJk2mVZV26VpbxFExEDpoY8pQMTkEoH4i5P0l7jN5artuNoU+DHDBYiMPZq3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7879.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1bf::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 05:10:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 05:10:57 +0000
Message-ID: <ee42d38d-c306-4451-911e-04ccdf84fc98@siemens.com>
Date: Wed, 3 Jan 2024 06:10:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] sync am65x device tree with Linux v6.7-rc1
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Nishanth Menon <nm@ti.com>, Bryan Brattlof <bb@ti.com>,
 UBoot Mailing List <u-boot@lists.denx.de>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon Glass
 <sjg@chromium.org>, "Su, Bao Cheng (RC-CN DF FA R&D)"
 <baocheng.su@siemens.com>
References: <20231221174412.210807-1-bb@ti.com>
 <20231221200056.GM2513409@bill-the-cat>
 <20231227123928.rt2wgr3qa7rw5jmf@imitate>
 <b4068fbd-e008-47a3-b2bc-b6c97f44df11@siemens.com>
 <20240102174232.GN2652760@bill-the-cat>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240102174232.GN2652760@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: bb07828e-6022-494d-5f5d-08dc0c1a5e8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FzT9mK7yHqiMo1ZPbTlg0aYzFXqToRT5rPscSVOWAQXUPfebnTbYP1mcdk/LKEoq7WxscuI0wc/KsQFIuIS5NXlc2nfN1mpUIpUuI92belyDUUVJ2Fnk9KudH9/fUyEHG30dqWwX6Nrs209g4ChQJVa0ZZc7U+oe6UL9YnTQPuwdD2n/aDWbqlO3Z/ybb2eqGw/8vyJHNZ4fvCe0I1Byw/MLHdtc0tyuXY9dEAJfxxC0ytZaX0M7eLG0HNJYfr9v2ibNq7BuEjrRjNW4e1ZM1UXKBasxwYYirD0j/HfPRT+ZP2YqnfiWZxu5pnHb+cBFAiCLCpzEWODJJlZXXXbEpwIMI5NF09mWpcsBAUExH6mTd4iDHI2M+t60+c5PBZYtE1vaqaNiDnix9+QuP23C4qUrA0R7YGm2CHakHDhfS4v220TasDXLjINffM7vlII89bTWVdy8wRWkvIiKOFgUUFC7/8oqNAPtFpoM98Mj0fpLaaSMnHNBYufLDpMlQO1NcgI02gZ9i3Zk3RIBX6VRdin83v0/dCHYFOQUKjq4WNc4Z7erHtJGeDBqUaaC+w3jUBJim6TGEt/V2S6hxd6aCNe3/jISjbIZxeaP9gjZ7E4HOo+JY6frWZq5q/Su0Pdo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(41300700001)(107886003)(26005)(82960400001)(38100700002)(44832011)(66556008)(66476007)(66946007)(6916009)(2906002)(36756003)(5660300002)(6486002)(7416002)(966005)(478600001)(86362001)(31696002)(31686004)(316002)(2616005)(8936002)(8676002)(6512007)(6506007)(53546011)(54906003)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW1qcVVwSGVBYmtRUHpMUmtYaGRmZHBZQ2o5YnhVR3BhZFkzS2Ztc2d3VEF4?=
 =?utf-8?B?bDVwYXp2UnBscVNkcS9EMlI2bVUvN0xFNlVLdHZnT0R3enhCdEE5eWh5RkNp?=
 =?utf-8?B?NHJ5Wkt4VWRKUFhkQWVMQnM3ZVA0Q1J6c0xxV0ZUOUhlRXZFdkxkVHBvekRY?=
 =?utf-8?B?bHQ4QmFZS0JqT2llWk1GNlBGUDZONzVKRTVjdXA2dGhwdUdyc0xrOXlKelJl?=
 =?utf-8?B?LzQ5SUdqVFQ3VlI0QVovQktDbzRJT0p2WnY4ZUU5Q1dWVVV5TVNwSjZxRmxD?=
 =?utf-8?B?Vk5jWkhCUjVONWttUDVsV3grVk5YTnFHTEUxR0FhOGNpVmIzWmNKUmw3VENP?=
 =?utf-8?B?UWZQZnE3SFdMVnR3b1BESnBXT2QvT3ZoS3pZRUNWZ1dEZ09nZm9GN1ltaHZL?=
 =?utf-8?B?RmJuTUhNMjJuQWRBWXFBNW9QcWx1UlY0T3BmSHVLTjBpLzFpVVdzQktLU05V?=
 =?utf-8?B?NnBLcC96dG9mTmNjdk5QU3JtNm0vaGJlVVdMcHkzYjJ5MXJTYXZydGExUTFm?=
 =?utf-8?B?d3lTZkY5Z2IwY0hIUTdrYW1aQ3ZqNWg0QVQ3d2R3TURLSFkwVFhmTXVXZDBr?=
 =?utf-8?B?NkJzR056cDhtSEZaMzFCSXZpd3lDSjRqbmZ1eE9hcU5MRkNxRjVjR3FjYjVm?=
 =?utf-8?B?d1JUQ05rSk9CTG0vL0VSNWdyK1RaZ21SOEZpVUd5MXJ0NEZFb0o3d3h6Rmxr?=
 =?utf-8?B?YWZ3a2V4bWZtak4vM3I5cDAxemQvWm1rS1hZV1lRb3RRUjVjU3hNWVZZYXcv?=
 =?utf-8?B?M0I2eGNoWHVPaktWMVlnSDBseS9KcmNpLzNXUkx3ZUZWWU5vQjJ4Zm5vcFRC?=
 =?utf-8?B?MTV4VDFFbEJXUkxKZTBkWXlSOWFSclMyRHAvQ0dhZ3pqS1JkakY0QTRxZHFX?=
 =?utf-8?B?K3N4ZzJkamFnVXQrQTM0a2hjVWRkWnNBRk1CaXo2NG5DOENlR01sUFFDN21I?=
 =?utf-8?B?K05JVUk1aG5pNDhFVUF6TnJCUmdiNFJnS0xhV1dPcVZtLzFwUkUxSWRYYXlV?=
 =?utf-8?B?S09KQmdIamw1SlUxRHhsVGdSSHZ3L3FEeUJFK1h5UEhJTnhEOTdrUCtvOHEw?=
 =?utf-8?B?ckFEamoxcXZqQUQ2bDFXWUN0eS9DK2tsSzBQMzFibm5JaUpBdWpsRWdKUkc5?=
 =?utf-8?B?b1N3QXJRWnc4Y05zZ0dNNmxPcVN4eEthZHh6UlRLNmZZM1k4Nll0Y254RjRs?=
 =?utf-8?B?MGhxanhSNnY4eUFyTVhjaGY5NlFPNlJJNThKS3lhOWtVYW9IM21MZU9EbzJx?=
 =?utf-8?B?dFppTElRWURyQVg4ckRPYzJ2M2FQaW56TnNwNVg0Zjl3V0JvMFFFeWp1R3lw?=
 =?utf-8?B?QWlySHVRakpnQVgzSUVSdkVPKzFUZllKa2x0cnRmTkFRaFUyZzhLd0FaYnR5?=
 =?utf-8?B?UElZT3BBcVhqaUhvM0lPYkd5UDBhMEl5OG9KeFNoNUZDSVpjbjIyQkNSVmdC?=
 =?utf-8?B?SVZ0TlRDNXNLck40RjYrM0k0QjNxeUMrQnZjUFBZNEpSRm5VdEdlSkFvbVhT?=
 =?utf-8?B?Rk1ac0RsSUtxc1B2UGg3cTl5ZGtacEZzN0F6SzNmU2lwTHdIeTdJa2taQ3BP?=
 =?utf-8?B?a0pZSjNyWkY1NjczVldYZjVoSThYRUF1TGZvYjhBWGlXRFBnNWhUeWhNcW9Z?=
 =?utf-8?B?Vm5KejNQeDNORFlTNk91ODM1TlpEUzhyZVFVT3czT2pUTWZFSm1NeTZwbnNr?=
 =?utf-8?B?YXVUL3ZicHlwcXJhV010RkQva3BoaStWYzF0UmNDdEZwYlNERkdSRFVteGpN?=
 =?utf-8?B?R21aMTNDWFkxVU5QeG4zOUxHK1E3cjFaRlBINUI5OG5wWmRZMWxzZzdmR2R0?=
 =?utf-8?B?aU55cmRIcDNlcVFqSGdDaXdqanEvUURVMjdBMmVuKzZxaFF3THRaaExJbDd2?=
 =?utf-8?B?M1Q0LzIwNHpaT3lncXdESkJNajBmdkhHOSt6MDRMOHplbEdkVnRLWjFGakRM?=
 =?utf-8?B?RWFZUUJWZDg1WEZXcHdaVmtLLy92RXN6TGdnL0FaWmwwaUpEbHJhcmg1SGpw?=
 =?utf-8?B?eGExdUVuSCs4NEtJUkViZ25qb2JHdjNJQ215L3R1eFNaSUlZMFBnbm50TTFk?=
 =?utf-8?B?RHllb040dmtXQ3pjd2Q3emswZHdLSnBxWGQ3QmVyZHlBeXNQeEQ4ekpVa3dx?=
 =?utf-8?B?TGZqRFdjYTdVMHlyejZ5VlpnSi9vaUFXOCtOTTV3Z0daNHkzRGNoSHNsNnN5?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb07828e-6022-494d-5f5d-08dc0c1a5e8d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 05:10:57.6058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8I9A1butr2SIMP9vejPCN+YlmdjYDAQ1/aA+t6T/Fj9gBPxy7AnjBezQi8xAUgSHlBUTm2cfL+MIrtg6iZS48g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7879
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

On 02.01.24 18:42, Tom Rini wrote:
> On Tue, Jan 02, 2024 at 08:27:34AM +0100, Jan Kiszka wrote:
>> On 27.12.23 13:39, Nishanth Menon wrote:
>>> On 15:00-20231221, Tom Rini wrote:
>>>> On Thu, Dec 21, 2023 at 11:43:46AM -0600, Bryan Brattlof wrote:
>>>>
>>>>> Hello Everyone!
>>>>>
>>>>> This series gets the am65x booting again along with syncing the device
>>>>> tree files with v6.7-rc1 Linux.
>>>>>
>>>>> The bulk of these patches unify the WKUP SPL board file with the arm64
>>>>> files to make future syncs from Linux much easier. In the end the DTBs
>>>>> should look a lot like what the DTBs look like for the am64x which
>>>>> is fairly similar to the am65x.
>>>>>
>>>>> For those interested in what UART boot looks like:
>>>>>    https://paste.sr.ht/~bryanb/7df8a645dc548912cd806abd5ecab967ef3287bc
>>>>>
>>>>> Thanks for reviewing and happy holidays
>>>>> ~Bryan
>>>>
>>>> For the series,
>>>> Tested-by: Tom Rini <trini@konsulko.com>
>>>>
>>>> Nishanth, does this path work for you?
>>>>
>>>
>>> Other than the minor comments provided in the relevant patches,
>>>
>>> The following files also need sync up with v6.7-rc1.
>>>
>>> k3-am65-iot2050-common-pg2.dtsi
>>> k3-am65-iot2050-common.dtsi
>>> k3-am6528-iot2050-basic-common.dtsi
>>> k3-am6548-iot2050-advanced-common.dtsi
>>> k3-am6548-iot2050-advanced-m2.dts
>>>
>>> Jan - could you look at syncing those once an update to this series is
>>> posted? We could probably have a smoother v6.8-rc1 from then on.
>>>
>>
>> We currently plan to sync once support for the new SM variant is in the
>> upstream DT. Do you see other changes that would benefit from an earlier
>> sync?
> 
> So this sync is because the ref platforms at least do not boot, is
> iot2050 currently booting?

It was booting with ~v2024.01-rc4 before Christmas, didn't try latest
master yet.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

