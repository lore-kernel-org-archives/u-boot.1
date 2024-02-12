Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B12AC4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 11:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B70B987C1F;
	Mon, 12 Feb 2024 12:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="LLSrogfa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D71A087BC3; Mon, 12 Feb 2024 12:51:13 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 576E187C1F
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 12:51:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAyhQOj+38nOr/dHZ8Dsa7QB2gN/vBn1XAoF+J3OHJVdUPGHYTCsl3ucmv/pu7+4HsShCZVCOUCuKSi66mcYr2/Is0vfxqWG63IT/9y7h+gx8u1jli0Yv5sDEgHk6BiooeRiyppF+lyz88TnlCEia1Boyx8H6wea1AzM3Mh0iwMIsy5fdixvXeaF8W8ghbL9fMdHpXAMYYXKBbLpsaVowVL+fc704ELAWLhaK7s0uBihcId6YlMPq9ebb5U/hcpSqk2DQCmaowLhpHpvmCBQ1UZQe7tQU9ief29mYJExb1j/Msbt9ZY3pp99POf6mJnikN+OMQPp0rXvrAEyeyKyfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qXtp2iJeRJBJDVPIzY2IRXKRBwezlLJ/4MrVSrDH3A=;
 b=UQWFphSd6K3qDB2OXzjFbwUFvg6XtOC55weqcD3RK4s5mLUIPLPXfF1asailyrK2Rs2Eqm/tRi2dzE17g5d5V7XNUyv0k4xkO21WNW70nHPR4EHh3vshs2m6PeKcIBaGu8oGKkMmJp5i0YtTAh35W3mu55Hq4c698RgwG9P7xInVFdKrcqDVi5eFZgS2UegJXa14YFBUm0D0F09ZHIMHohN77LsufktQT3XUIxQ3pLXjTPCEMsR1Exzka3eQQ1X2xEUrM6yzjwydsyC5YjMFmEmjZR1cfnAsUc4ggk6tu0DhfFb6Esq9xxylEIPx6lpBMIEoJ0XWIPW/ZgpVdFlu9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qXtp2iJeRJBJDVPIzY2IRXKRBwezlLJ/4MrVSrDH3A=;
 b=LLSrogfalfkJUvbZNaewihhE1tFmVA0zgGF985kGMAuDoCy4jiWCMqZBE+/HDwDcyF/GjAoSzjw7fYW+d/jWrkdYWE3ZjlZP4oHxMD6iKhpprEEG3/ivMZWfny2PaVd/QXEFE9HfpiDNAJStCrwW8H7tWG5C9tCbwGg6/6Pld26UeR2aqJlLiyJsaBmu1u0387Jd82NPpWZ8HR5PrJNRylgm8DpzyXFt76/dt2ar5MbxvZUX8+w+ZwIJpBFE6LSeRBaacmaMJqyQFDovmlRmthVy+4GhCqZqQCOU0DZDqfJvDOb7FIwm1KQ4Fz7r67Fj1xsXeVhjdibyK5XR2jpHsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Mon, 12 Feb
 2024 11:51:09 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7249.039; Mon, 12 Feb 2024
 11:51:09 +0000
Message-ID: <3b213c6d-9b97-48d1-8c36-4970dd1c4aa8@theobroma-systems.com>
Date: Mon, 12 Feb 2024 12:51:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: rk3399: Update stack and bss addresses
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Nick Xie <nick@khadas.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Deepak Das <deepakdas.linux@gmail.com>, Alexandre Vicenzi <linux@alxd.me>,
 Xiaobo Tian <peterwillcn@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>, Levin Du
 <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de
References: <20240212005914.3512640-1-jonas@kwiboo.se>
 <20240212005914.3512640-3-jonas@kwiboo.se>
 <d8e10b17-0571-4ebc-9783-2301c429c6b3@theobroma-systems.com>
 <c3f2027d-3d87-4b71-bb13-35090640dc9a@kwiboo.se>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <c3f2027d-3d87-4b71-bb13-35090640dc9a@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::16) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AS8PR04MB8642:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f1a62c-1888-47c2-2ddd-08dc2bc0e736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6dGTMBmgwzt4+iz1X1hh9HPQNdTLVxd/BqUbiFvyfTux1IZDxN+a++Vcwo2YIGpniXky5KuNySzw5FwBpJcsZ3wtOyClRAz02YvqnWDH+dY5zViJ85GCHQGfLu7gVYKIYIe0hPTtse87PHtAhraDuC/NKpweklJAw/1O3tCu8mVbuNQUQA15gli4L6lPaBgNbDsrK9txlChPTrW2TDeBzyaDfCcbOw+TI3KVxLLYAv7NFGuriJ0xg+wK54Zgnr5uaGPFfwy1j43+nQGM9gTKtN2Yy3STYzWqc2Nc32b4W0iCQrq9UaBgW5cKNWtF2dulnJiczXFaOxipVpjF6nKq6s6v0PRGVUfJVSY2KDpVl8f/vJqJRzf6ixH7PwPC50k5ftgIsViUBAWKb7SFKpxkAtcy9ULC9Ov6wa83PSBYuKC5R3d6pwOgx5k6VWCthgLLt8bTVFpXLY6I2YVrbeMLqAL9ab3beK93Q1Sq5bvY5k6y3wTxlH/UR4mv/Uk81PszYTXwfsap9Oyn5iFjtQGL4kCfop1IHIW4rFDFe1NJmD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39850400004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(8676002)(4326008)(8936002)(66946007)(316002)(6916009)(66476007)(66556008)(36756003)(54906003)(5660300002)(2906002)(7416002)(44832011)(6666004)(15650500001)(38100700002)(6512007)(2616005)(53546011)(6506007)(83380400001)(86362001)(478600001)(966005)(6486002)(31696002)(31686004)(41300700001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UStRWlEvcjV0c2RvSHM1UTJ2NVFET0MvNUZYRDBSM0M4ZHNSdDFaZTUxTVRq?=
 =?utf-8?B?bTdabjdJMkhLOFdpL3pjeVNRMG84ZGNIeFg1czltbU1OaURTSklxVFVIVVBu?=
 =?utf-8?B?d1VXcTFFRzd4MDFaQzNrQkJzY1R1ZW53Y3ZEVWk5U1J3L2l4ei9YRk5WbHN5?=
 =?utf-8?B?cDFiY2x3dnVXYnErTEFpTEtDNXNmQXIzTjFZdHBiME5iZlA1TDUrQ3FPdnVC?=
 =?utf-8?B?RjNqWWRjekJmNWxLM2dBWVRMNXpFdWFmWnN6OEhZbDJuamZKZnFTZmlDZU9j?=
 =?utf-8?B?NHI5UUxEcm04MG43QVIySFdWc0M0Uk9wRjRaYW9ObVlOeERlSWhKaHVwekdC?=
 =?utf-8?B?RUlEa3FiWXRjejlFSFRMZEdPVGRWM3g4MDhDRjhPcWRtekNqZFJIb1J2Y1Rz?=
 =?utf-8?B?MFBWOWRvZmFMRWt0bHBXZkRyVkRsemNyYk9UcWlBNUlZLzZ0UXUxeGhPWXJl?=
 =?utf-8?B?UCtvb1BGWmEzOElhRmR0aFhEQjh3QkhWTzdYdGFVT1NuOTRkU0dzWVlFejVw?=
 =?utf-8?B?bXhoZWRxSGJuK3l1TjlsTFZOaWRHQTU4ckNSR2dQUnNPRDhyZGxJSGJ0a1N2?=
 =?utf-8?B?bnJrQ1JkSEpFbG40aEJ0NXkxMC8wNHlEUEpGUmRHZlc1cDMyelpFTkVqcnVy?=
 =?utf-8?B?R2JiUUd0R2JaT2o1aDR1THNseC9VZWJvdjhrSXJFOEJnTmhBTERXZmxqSUhi?=
 =?utf-8?B?TWU5VnVHQnVvYVVMeVRoUmU1eDdVbUowQXk1aW9zRGZPM3B6QVBvMVYwQnM5?=
 =?utf-8?B?djBkSlV5MVdaR0NrM2RBS3c4Ykw3UXlEWk10QllzVXdHU05SRExabzZUa3Ry?=
 =?utf-8?B?K0hySEpkV1JsUmtDdDFFUUhZRG1JTG1qcmVnZ2Nhdmx0aVo0Y1AzR3BBdER5?=
 =?utf-8?B?a3A1TzRaQTI5aHgrc3hpdVpBL1ZnMWVNQmJWYkFFd2xVeVViaTgvdlM3M09n?=
 =?utf-8?B?RkkrVzVpeFU4QkROd2IvUm1JY2lyNE03cWFUUUY5MmFneGllRmVlS0RJVStm?=
 =?utf-8?B?aUIxSmFHbVR4UDlWbnNsQThhaFVlTlFyeVp2WXRkSCs3Z3JMS1crMkhrVnFh?=
 =?utf-8?B?MjNBWXdwSnFGQUIwL0hkdk5yS2xUUzZSSGYrUklIRmVrL2tjVTZWMkwvYlFM?=
 =?utf-8?B?Nlk4cktYYng3ZHp0dkc2WStYZEhOWlFxa0N3MDVZZStaMEVIeEhpRDhicXRU?=
 =?utf-8?B?TTNOams0cVBjQ2kxSGdDNWYxdGxLamZVeWxWbDcvQ3A5V3Q2Y3BlbGxVK3kv?=
 =?utf-8?B?OXZkN3hrejlyNHpNS3p6K21lRERnNFVYdmx1b3llQ252dk8wYjJ2K0ZqQUNG?=
 =?utf-8?B?Zk1TNEZYQmFqYkZhOW5YWjVBTWozK3VyTUlDTEppM21yaWZESGpSLzhMa3Bn?=
 =?utf-8?B?VmNtMjZpa0R3Z2tORjVVQlRoSmx3RzNyb1BZT3Brb20za2w3K3hYaXBVUjV2?=
 =?utf-8?B?LzNybWlqK3RBR0JUQlVIclVwRkYrRy9mRlpiMUFRVUdRTFZRWUVGbjJqZDBz?=
 =?utf-8?B?QTg3ci85QXFiUnhnblpxUjdLTGdEMUZFYUh2bDFUb20rSHVhckJmOWRRQUg1?=
 =?utf-8?B?NFZZUW5zUk5TeDJmV3pnd1oyVWRveFNoSE90c2xmbWVLTy9vUlR3ejNWdHJ2?=
 =?utf-8?B?ODN6VTlDbXlBYjZSRVYxdjdyUU14ZUZuSi80dU95UVg0RlYrU0lEaDJBZmM1?=
 =?utf-8?B?RE00RFpuSGdNc0FMVFo3YkpiK0RlbFVpTktabGRiN1U5Vk9EWURWemRkM0VC?=
 =?utf-8?B?UnB1bU02M3lGanI1OUdFMTd4cTloS3Z5QjJDYUtQdUcramNPOTM4SVo5TkIx?=
 =?utf-8?B?RmlJeFkyYzNsZVozamRJdFQzMjBWR1RQNWdxd2pxdVVMUkZNYm9HcyttdEhk?=
 =?utf-8?B?T3pkVllaT0ZvOUxHSXpVZVd1czhCaGxuTC9RLzBTN05TMWlobCtsZERoS2Fr?=
 =?utf-8?B?ejBvSDZZNzRLMzlnRU9mN1NmeHJaMzE2QjhHTXhCNzU3TXU1TEwzT0l2WkxM?=
 =?utf-8?B?MUJKelVNQ0RWL1ZIUDdHemMwd283clRpUUdBT0EyS2IyTzJOQmJ2YU4yaFRI?=
 =?utf-8?B?ZURSUTNIMUZ5T3h5OVZwa05BWVhVMnl1b2VLcGg0dU9uVzcvSUlienhzSkwz?=
 =?utf-8?B?d1VwajgxanhnVTV0V29HbGMyL29MVkFmREFocldIOE4vUEwvOEpKQTJmVWEv?=
 =?utf-8?B?M2h6MTgxZCtuejZLampTSmNjYWp4aEZKVzkrUjY5UHBBNm5ETk9KOWRkbkZi?=
 =?utf-8?B?b0pETDVyVWF6WWQybjZZeC9Cc21nPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f1a62c-1888-47c2-2ddd-08dc2bc0e736
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 11:51:09.3800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yl6lYb6kIEQCSNbXOp6fc976AJme151FiY/X1h2kuHV3CYByi04D3SQL6PFZLF2jf1aadZUxyxUSjCFI51hPy978fpNYYQxrBoOu+MGwoPma0V4fi/sW3OvYjGv/vTj6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8642
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

Hi Jonas,

On 2/12/24 12:08, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2024-02-12 11:37, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 2/12/24 01:59, Jonas Karlman wrote:
>>> With the stack and text base used by U-Boot SPL and proper on RK3399
>>> there is a high likelihood of overlapping when U-Boot proper + FDT nears
>>> 1 MiB in size.
>>>
>>> Currently the following memory layout is used:
>>> - 0x00000000 (@0 MiB): U-Boot SPL text base
>>> - 0x00040000 (@256 KiB): TF-A
>>> - 0x00200000 (@2 MiB): U-Boot proper text base
>>> - 0x00300000 (@3 MiB): U-Boot proper init stack
>>> - 0x00400000 (@4 MiB): U-Boot SPL init stack
>>> - 0x00400000 (@4 MiB): U-Boot SPL bss
>>> - 0x02000000 (@64 MiB): U-Boot SPL reloc stack
>>> - 0x08400000 (@132 MiB): optional OPTEE
>>>
>>> SPL load TF-A, U-Boot proper and optional OPTEE after SPL stack has
>>> relocated, meaning that there is room for close to 2 MiB (@2-4 MiB).
>>> However, the initial stack used by U-Boot proper is limiting the size
>>> of U-Boot proper + FDT to below 1 MiB (@2-3 MiB).
>>>
>>> Instead change to use the following memory layout:
>>> - 0x00000000 (@0 MiB): U-Boot SPL text base
>>> - 0x00040000 (@256 KiB): TF-A
>>> - 0x00200000 (@2 MiB): U-Boot proper text base
>>> - 0x00400000 (@4 MiB): U-Boot SPL init stack
>>> - 0x00800000 (@8 MiB): U-Boot proper init stack (changed)
>>> - 0x02000000 (@32 MiB): U-Boot SPL bss (changed)
>>> - 0x04000000 (@64 MiB): U-Boot SPL reloc stack
>>> - 0x08400000 (@132 MiB): optional OPTEE
>>>
>>> This should leave room for loading and running a U-Boot proper close
>>> to 6 MiB (@2-8 MiB) in size. When U-Boot proper has relocated is should
>>> be possible to use @2-132 MiB and @164 MiB+ for scripts, kernel etc.
>>>
>>> With the moved SPL reloc stack it is also possible to use a much larger
>>> malloc area in SPL, e.g. using default SPL_STACK_R_MALLOC_SIMPLE_LEN.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>
>> Do we not need to update memory addresses in the environment as well?
> 
> The addresses in environment is to my knowledge only used in U-Boot
> proper after relocation. And at that time we should be free to use @2+
> MiB up to somewhere close to gd ram_top/relocaddr. The optional Rockchip
> OPTEE blobb may occupy @132-164 MiB, but I do not think loading OPTEE
> blobs works as-is, so that may not be a big issue.
> 

Upstream OP-TEE OS seems to support RK3399, c.f. 
https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/plat-rockchip/platform_rk3399.c

I cannot say whether it works, I have no knowledge of any of our 
customers using it (but that predates my joining Theobroma, so maybe 
long time customers do use it?). However, we do use an upstream-based 
OP-TEE OS for one of our PX30-based boards, so I would say Rockchip's 
OP-TEE OS is not the only option so we shouldn't just disregard this 
location in RAM... especially since ramdisk_addr_r starts at 96MiB. But 
since we're not changing that location.... people who would have this 
issue, would have encountered the issue by now already (provided they 
load a ramdisk bigger than 36MiB). So let's ignore that one actually :)

> So to my knowledge we do not need to update any of the memory addresses
> in the environment as well.
> 
>>
>> scriptaddr=0x00500000
>>
>> This is at 5MiB if I'm not mistaken?
>>
>> Basically everything in include/configs/rk3399_common.h in
>> ENV_MEM_LAYOUT_SETTINGS needs to be updated to be located after 164MiB?
>>
>> Did I misunderstand something? I find it weird the current values seems
>> to be located after U-Boot SPL bss and that e.g.
>>
>> kernel_addr_r=0x02080000
>>
>> is at 32.5MiB, and with U-Boot SPL reloc stack currently at 64MiB... a
>> 31.5+MiB kernel Image would mess up the data there? (what do we need it
>> for BTW once in U-boot proper after relocation?).
> 
> After SPL has jumped to TF-A and U-boot proper any memory used by SPL
> can be overwritten/used for something else.
> 
> My understanding is as follow:
> - SPL always need access to bss
> - SPL need access to init stack until it has relocated to reloc stack
> - SPL will load FIT images using the reloc stack, at this time only
>    SPL code, bss and reloc stack matters
> - U-boot proper will use its init stack until it has relocated to end
>    of memory. Until U-Boot proper has relocated it will use init stack
> - We could use same memory position for init stack for SPL and proper,
>    e.g. SPL_SHARES_INIT_SP_ADDR=y without any issue
> - After U-Boot proper has relocated we should be free to use @2+ MiB
>    up to where U-Boot proper was relocated.
> 

Not sure how Falcon boot fit in all of this and whether it makes use of 
the environment variable (likely in the SPL binary itself).

Was this from experience and/or is there some literature in U-Boot git 
repo already? Couldn't find much in the 5min I looked for it :)

Thanks for the taking the time to explain this, much appreciated.

>>
>> Side question, what about making those values the default for RK3399
>> instead of having it in each defconfig? This could grow quickly out of
>> hands to move this to the Kconfig symbol itself, so not sure it's that
>> interesting to the project, but raising this anyway.
> 
> Agree, was trying to define these as defaults in soc Kconfig, but that
> rearranged some values in other defconfigs so I avoided doing that in
> this series. Also touching each defconfig helped me ping board
> maintainers of the change.
> 
> Hopefully a follow-up series can move these, and other options, into
> soc Kconfig.
> 

I was more suggesting adding:
"""
diff --git a/Kconfig b/Kconfig
index 00ed1ecc173..b816e536674 100644
--- a/Kconfig
+++ b/Kconfig
@@ -249,6 +249,7 @@ config HAS_CUSTOM_SYS_INIT_SP_ADDR
  config CUSTOM_SYS_INIT_SP_ADDR
  	hex "Static location for the initial stack pointer"
  	depends on HAS_CUSTOM_SYS_INIT_SP_ADDR
+	default 0x800000 if ROCKCHIP_RK3399
  	default TEXT_BASE if TFABOOT

  config SYS_MALLOC_F
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 6405374bcc1..08b71713b79 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -121,6 +121,7 @@ config SPL_BSS_START_ADDR
  	default 0x81f80000 if ARCH_SUNXI && MACH_SUNIV
  	default 0x4ff80000 if ARCH_SUNXI && !(MACH_SUN9I || MACH_SUNIV)
  	default 0x2ff80000 if ARCH_SUNXI && MACH_SUN9I
+	default 0x02000000 if ROCKCHIP_RK3399
  	default 0x1000 if ARCH_ZYNQMP

  choice
"""

So that boards could still override it in defconfigs if they really want 
to. I don't have knowledge of any other way to provide an overridable 
default?

Anyway, a topic for another series, nothing requiring to block this 
series, so:

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin
