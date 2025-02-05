Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33537C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 16:48:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B560280104;
	Wed,  5 Feb 2025 17:48:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="J6+FDM0X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B723D80562; Wed,  5 Feb 2025 17:48:09 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89A218003E
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 17:48:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXEC5nNsNPwLUJg+GTLum5tcEFe+NcSHnx10aAymiHzt1IXAHopLM0gAAmPpFUflJ+A3mjSrlNUoYmPxNMOn7hqRMJbGBd9TdSLMbf+d2rlr9fY9Lw4DFy4i3l13oRsl9F20rT5msRiC2pIM2rZ07tm+epqoiBb/ChV0eQAHaJdnBJo7UzhGXVeP//gcuQsDSVxun0TVsWmqiUNtJD+4LrVusnK67guln279rF0fdRQl0KtMIpkeD7yg+nBA5iBOF1GTRn29d4hji6on1Riy6HYZBVlfzCPCjo2XShdVbcDXrhm7PTxGY+RDnKxEKn6qELgMl8vS0rD/FDfCvdQKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxjPuVaGGPoHsr2sL5c9D5zEsWKzrg11E4og6laPcpA=;
 b=eNccGkVhiBNFlOiWDY6V8EV0G8kR90fW9eSs5W/XTvj39kaaztHKVlKW8iG30qbKLWjjJXUwohRaMXXnQXL0pBDIP19HuTw9SZaGES3wHaDKqpd3PgYI7GOKCS4+BfI2uuBTXuZVFLi+x0Vxwtq1qwnbuN+x3KRPUgFTw7av1ZNnO5aiatR/zOHLvPSqzM192906Gw9326dpk9cC/eFsBjHRUxOLNTBmVHv0tmeS6mphNeo7R8NKeb7TRH51EPwtgHb4bBtovNdIBf8i7EO8vDXX4tkuJHRCHnwAhtX+LqFKmbxvP2e7cDxX8I46iDFO7spUehFomya3RDUBGU05fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxjPuVaGGPoHsr2sL5c9D5zEsWKzrg11E4og6laPcpA=;
 b=J6+FDM0XlYtDATo126H69e+zB+l9pSyIsyU8MvMeSltoKa3rDUDwu9cIviFqaAVOf6XFe4VXd00GkRHPzDyJkksvVV0gWTeQA5SUgTDHBswz+lFbGBbQyvsHnjTB1LZTuxmKyxQ9EO60+X+jU3Id6dtOg2J7V0SUU8iqtUCNAy4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10670.eurprd04.prod.outlook.com (2603:10a6:10:58d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 16:48:05 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 16:48:04 +0000
Message-ID: <160e9941-efa9-486a-990b-9105b522046d@cherry.de>
Date: Wed, 5 Feb 2025 17:48:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] rockchip: mkimage: Print boot0 and boot1 parameters
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250129223641.1888833-1-jonas@kwiboo.se>
 <20250129223641.1888833-4-jonas@kwiboo.se>
 <d50be23f-ef3e-46f6-8862-32bc18903bb2@cherry.de>
 <511da0ca-bda7-4ab9-9a4f-b28d638c9343@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <511da0ca-bda7-4ab9-9a4f-b28d638c9343@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0037.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::26) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10670:EE_
X-MS-Office365-Filtering-Correlation-Id: dd69ffd5-cad5-4c8d-b802-08dd4604dc5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWRjWG5LSldtUnc5UC8wQlBGdldKb00xMDUzQXJla1ljMVBkLy9OMUR2UUtG?=
 =?utf-8?B?RWZvMUpmdk96d3MxUTl5eUU0elp5bWJNWDIwYTh3eGtnemRNaUVpMDloRTR6?=
 =?utf-8?B?ZitXaytvSFVCOG1rc2E4T3FDS1p2cU51WTE3S1lVbHBvUG5ucXN3d2psTVdZ?=
 =?utf-8?B?R1prZ3ozOGtUUlFoZ0ViSG0rRjVJaUgyVkNGZExnUHVpZ09IenJDaUxacHRV?=
 =?utf-8?B?UUpJay9PNGRnbFh3WGp2b0d4VjhSUGhWa2R2YXh0ZFZVODNUTExDTyswaFFa?=
 =?utf-8?B?eDE2NDN0dCtmNkRUekpLOElMUzNSUGt5ajVaaE55SC8vUUdxMTBYaERlNk9l?=
 =?utf-8?B?ODBzSmN3RXpKQWlpR3l2RVUzeFFDN2RUUWFqS0NXTThWS2lTb2piajRJdnpr?=
 =?utf-8?B?UXQ5UHlBOEhhRzFQR0JFMTVWeFlSdUJTSW1NNW8ydisweUhrNXJlRk5vaXIx?=
 =?utf-8?B?Q3NGQ3dKdU9yd2RYb21EUjh1em1sak56WVJzMTJBVkhBdEowZ2lrR3E4WjBv?=
 =?utf-8?B?Sk9BTkR2cldkSGliM2lQUnc2b2N1bC9JMjgyOHNIZGJibStyZHN5ODRsT3kv?=
 =?utf-8?B?ckNXdWE0TzREM1Rjajc1SzBYVWVoblh4RTFpRGprZDdQSUJzOXZXckN5RVBT?=
 =?utf-8?B?bldUTHNrSGFJTUsyaXFPMjYycXRPUEVjdzF2MVVRSFlhS21XT1BtcllDWHda?=
 =?utf-8?B?MS83VnEvUXdhR1FBTDJlYzZUVjZHZ0dLQ3FDN2tlSVI2VVRCYVB2enMzVDll?=
 =?utf-8?B?NE9ueTBBZFFHQkZaK3hsWVVwZytEVUo1L2VmbFJycE5BU0FKdm9NQUR0eXpx?=
 =?utf-8?B?YlAxalU5M0luRkU1Ry9sRU1DNUVHQUtEa1d2anlkdS9pRlRRMWcwVlNWcmhJ?=
 =?utf-8?B?Qk5iZTMwb3h6Q3cxTkwxaENlQTA4SVJjYS9qQnVMd2lLbk9GekZUc0NDNHVl?=
 =?utf-8?B?WUhPckJTYVgvL3JkOVd6WXVHd3dmblJWOHNCMFcvdEJjRmk3eE1xTDJ4SjlW?=
 =?utf-8?B?Z2JhSlFjYk1FaTlsdllvbmV0M3R1dVU0TWNQaTVPYkxmNFZCQzJqOW0vVjFE?=
 =?utf-8?B?Q2gyMzFwUU9MQVNCRHY2eitKZU4yUng2cWZmUzFpWFFCUVF0Ymd0NG5tM0Jn?=
 =?utf-8?B?TXhaOEIzOVdDS2R5QkZJaXJzMEV2SlM1dlJ5YWVwZDNSdzF2SEVEeHd1MWdp?=
 =?utf-8?B?M0JDOHF5UWJHU29NdXhzdWdQQS9xK2YwQ0ZIcXlWL090cGhmdGh3d1lVcjVx?=
 =?utf-8?B?TVFlSWU0ZFMvUVJOSGNRM3JBRE9Celo1QXJvQlo3TFpuTVhzNnBKT2sydkto?=
 =?utf-8?B?VS95bTB5K3FsM3FsVWkyaCtyQUd5TERaaFM2T01xWHZSMkFVandUVjNyODYx?=
 =?utf-8?B?dmNhSHF0S1FVbFZDb0xkaVA3dEZ6NWlqUm5kaUVsL3RSY3FiUXZycG11bm5K?=
 =?utf-8?B?UkJwYlQwcDZQUzN5M0tJSjBiZjhTbWEvbVFJNVFydHRJV1pFTmg5RHlIaEV5?=
 =?utf-8?B?ckZCY2k1L0hSeE15UVhnSC9ZT0FjM2F6UW5qQy93ZWw3MUp0bDkzWmt0eFRL?=
 =?utf-8?B?eU5GUXJLcmNMc1VFNjhmZ1llazZUNlBia1Y4dkFEb28yNlk4L0RpMkxzY3k0?=
 =?utf-8?B?K1RqOW41ZWVTS1dEdzdIeENUNk1FZnZhcTgyZnRTK0lpb1d5R1hqSE5lUXU1?=
 =?utf-8?B?aEhtRXJCVWh4R2dFYkJRVmJCbW9XTVNEUE4yNjVJUCswa20ydmxwWWk5c2di?=
 =?utf-8?B?ZE1xZ1J0TTlBSzZRT2hwcE9ZeEVPWWpJVXZEamtiWDVKbVpXb25TZW96czFp?=
 =?utf-8?B?R0QyOHg2d2hYejJBazRiTGxUTkVXSHRsSFdDazBYNTd3TWxiZ3NNT1J3Qm15?=
 =?utf-8?Q?M46sFcQjaZU8m?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0MrK29PQXhaYUFTakcyY05DYTZ2ZUhSeVV6NWZUU0hNaU1IRTF1OThrYnNQ?=
 =?utf-8?B?Z3JZTWQ4OXNaMDgvNjIvVkRYSTl5UlhQUGtOZTQ3cDFCRCtDR203ejhUa0tL?=
 =?utf-8?B?SW0zQTYvZFc4NWc1R25hWjYxVnBVRGJINHhCdWQ2YXNmZmdTVFBWVW9wQzdG?=
 =?utf-8?B?UHBNY2gxYUsrclB0Zm5rL2N4eXJLRVBrWmIwSzVYQmpVc3BoS256bllyYUlP?=
 =?utf-8?B?MnRaUTBxUVhMR2hzZ0tENXg4TVFEbXpXSndMVzRoVDBXWlNmdHNINlZOTHcw?=
 =?utf-8?B?MjRGLzVBTHVHNjlsWjdObExuTXh2QVMrdE8yN1Fkb0RMWGdTRktKYW8rTXpw?=
 =?utf-8?B?V1Q5STM5L1YvVHNUZFNYRTg2NlQ5dWRYekJTeDUzU29xVjBJY2ZmRHA1cW1r?=
 =?utf-8?B?cTZyVjBaQXVsb1lZNWgyWTNxazgxdmlyYldEY0hlRW5MU1dXRFJZeGJXMkgv?=
 =?utf-8?B?Z0F6cDV0bU5aRkpRZzJlem1jVXlMdlV4YWpLajhkdUM1T3Z4bVJLR1hlQ3NL?=
 =?utf-8?B?L290d0N4TXBGK1ZCR2JZQVo5NTIzUzdJalJpZXRnWlkrMmpXUVZad2NLM2w1?=
 =?utf-8?B?d2dObG40dUN6Q1pCc1h4KzNKZnZMVTBqTzhZaVhQR1N4SUVMN1BjMWNYOTJC?=
 =?utf-8?B?aTFzQzJRdUJKTnFleko1QUV6VjBSQ3owWlg4UkpscXVmQUFZZGQzeEVhSjZG?=
 =?utf-8?B?T0dMU3grUmowYngvQjFRbUREc0ZPMjVmczlLRmRVWS96a0FubVdCYlJVcGhG?=
 =?utf-8?B?N1FrQzhwbzUvZG9RdUQyc3Z1a2VGd0p4WmY4Z1RWVm5VNEZvc0dxNjhLTkhm?=
 =?utf-8?B?L1lWSTA2YXMvNThST2NjRUVOZHRQNE0yYnBMd1VuZzNaeVZZeDBGV1BTWWF0?=
 =?utf-8?B?c0gvcUhhWXcyY1NhUTByUmJ5TzM1dHE1QzlveldaYTF4NExVbXZjSG9EbVBj?=
 =?utf-8?B?cjRJV0VzaHQxMHh2ckc4T04zeFlnV2NXM3kxNkEwYzJSTE9DazhPdDVhakZY?=
 =?utf-8?B?WENwYUhFVmh1clphZ3FwTlpTeW1yQ1gxWVZWTXlaczlLcmVaSi9GcDc1S25L?=
 =?utf-8?B?WWM2Tm9jQWpTNFRab1dHb1JYbmcwY0xEaVVOQzZ3VmU5SjlkaUp1V2Jhb2Vy?=
 =?utf-8?B?aGYrWmhySnA2OWJBWHZXME5ZNmZPNU53LzJtOGh2Ri9aRllPaVRzS1VoZVRD?=
 =?utf-8?B?eUg3a2xiTGhuTEhDSGNBSFI4dVpNL2x4dU85STlESjB5Z0psTUVhaVlZSjd4?=
 =?utf-8?B?YkkxSVNMWjBENlpMdmd3TXJnTWlFdWpJQStheXFGZjU5a25HbVJUS3ZFYzdE?=
 =?utf-8?B?by9zT2lSOTJORnhxbFZENUtjYkIxL2k2Zmo2QnVnSjVVNk9XdHFoUm1kZWsv?=
 =?utf-8?B?aGFDQkdCU2MzbUk2QU1Lc1VrcnZ0Z0NOR053MTQ4SEs0UUtwbkFZRkVtQUU3?=
 =?utf-8?B?cE8xdW42dnNFZmZwTjNYa2dCWGJtUEVnRlBjaXo3aVdmaGZMTU5jdlExZG1K?=
 =?utf-8?B?S0dia1V1aEk2NXNndS9qV1pKeFk5Y1ZyTXpJQUJzZGI5a3h6NW1MM3huUFdI?=
 =?utf-8?B?RTBJanVtalMyVm9OMWN5NzEyMHBoV2QwbWtVMG8xTnNCRWEydlA5YW52UzJ4?=
 =?utf-8?B?NGxLczdDSXZhK3BtazNuYndDZzNhak8xYVVkU1dkcDZyakZDb2xaa2RYMUpJ?=
 =?utf-8?B?aDZ2TW5qRCtQZFFheXVZTUZrVE51dDV5bklobVdyVTQ1U3kxUHFsdjZ6MEtJ?=
 =?utf-8?B?VVl3Z2VXME9tOGMyTFFoOHFqT0xCWnhBL20yVStzK0taR2hnOFVOVm1oeGhZ?=
 =?utf-8?B?Y0ZjdzRuUEJiT0ZqMlFDbXkxakJHMG9lYWVPU0ZsV3psdjk5VnRMU2NsZkZT?=
 =?utf-8?B?WDYvT0NGTjJ2eWNqaXVvMkJIMXMySVZQMzUxMGRBLzZyMmpNdDBoMmhnWEQ1?=
 =?utf-8?B?WkFOd3VvOGtkaklOb0pReUhuekRLNjhPUTJsRmNXdFg5aDBneTNjT29aRndN?=
 =?utf-8?B?UUdTbnVWb1A5NTZWR1JMNjIyK0Qwem9MelgvdHhzRkRteEFHVnRjVUgzOEdN?=
 =?utf-8?B?Y3E4WGRrT04zdUpwSTJTUncvdVl1SklyTEgxbWUwa2M3QXcwSFhIVlhOYXRr?=
 =?utf-8?B?eVhQd3hUTlJlOGIvN0JDUkhXYTlteEVNb2NUbGhDbDlacmNOL2RkcmcxbXZM?=
 =?utf-8?Q?s/8ZJNGA1WAav/LM8TAf98k=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dd69ffd5-cad5-4c8d-b802-08dd4604dc5d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 16:48:04.8709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4bnWB1qJzoK2SEnFvk1EgjG1flK2Ei+VPUGcTfDwJ0EN1UXDUGDZNUnIT+tgMYmy8V29FRXK0ICgzDxMNUGrLu02IkHMqWobwik5mZB7MA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10670
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

On 2/5/25 5:42 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2025-02-05 17:04, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 1/29/25 11:36 PM, Jonas Karlman wrote:
>>> The v2 image format embeds boot0 and boot1 parameters, the vendor tool
>>> boot_merger may write these parameters based on the rkboot miniall.ini
>>> files.
>>>
>>> E.g. a RK3576 boot image may contain a boot1 parameter that signals
>>> BootROM or vendor blobs to use 1 GHz instead of the regular 24 MHz rate
>>> for the high precision timer.
>>>
>>> Add support for printing boot0 and boot1 parameters, e.g.:
>>>
>>>     > tools/mkimage -l rk3576_idblock_v1.09.107.img
>>>     Rockchip Boot Image (v2)
>>>     Boot1 2: 0x100
>>>     Image 1: 4096 @ 0x1000
>>>     - Load address: 0x3ffc0000
>>>     Image 2: 77824 @ 0x2000
>>>     - Load address: 0x3ff81000
>>>     Image 3: 262144 @ 0x15000
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>    tools/rkcommon.c | 18 +++++++++++++++++-
>>>    1 file changed, 17 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
>>> index ad239917d2bd..324820717663 100644
>>> --- a/tools/rkcommon.c
>>> +++ b/tools/rkcommon.c
>>> @@ -62,6 +62,8 @@ struct image_entry {
>>>     * @boot_flag:	[3:0] hash type (0:none, 1:sha256, 2:sha512)
>>>     * @images:	images
>>>     * @hash:	hash or signature for header info
>>> + *
>>> + * Other fields are not used by U-Boot
>>>     */
>>>    struct header0_info_v2 {
>>>    	uint32_t magic;
>>> @@ -69,7 +71,9 @@ struct header0_info_v2 {
>>>    	uint16_t size;
>>>    	uint16_t num_images;
>>>    	uint32_t boot_flag;
>>> -	uint8_t reserved1[104];
>>> +	uint8_t reserved1[32];
>>> +	uint32_t boot0_param[10];
>>> +	uint32_t boot1_param[8];
>>>    	struct image_entry images[4];
>>>    	uint8_t reserved2[1064];
>>>    	uint8_t hash[512];
>>> @@ -491,6 +495,18 @@ static void rkcommon_print_header_v2(const struct header0_info_v2 *hdr)
>>>    
>>>    	printf("Rockchip Boot Image (v2)\n");
>>>    
>>> +	for (i = 0; i < ARRAY_SIZE(hdr->boot0_param); i++) {
>>> +		val = le32_to_cpu(hdr->boot0_param[i]);
>>> +		if (val)
>>> +			printf("Boot0 %d: 0x%x\n", i, val);
>>> +	}
>>> +
>>
>> This seems to indicate that there are 10 4B params for boot0, is that
>> correct? If that's the case I would at least add "param" before %d, the
>> output looked odd to me at first glance.
> 
> That should be correct and is what boot_merger can embed based on the
> [BOOT0_PARAM] section and WORD_n (n=0-9) values from MINIALL.ini.
> 
> The only reason I skipped "param" was because I thought it looked
> prettier to align the "BootX %d" and "Image %d" in the output, can
> change to include "param" :-)
> 

Hehe, could have seen:
Boot1:
- param2: 0x100
- param3: 0x500

as well. I am no UX expert so whatever works best for you :)

>>
>> If they aren't guaranteed to be individual 4B params, what about just
>> printing the whole boot0_param in hex format?
> 
> There is only very few WORD_ values in use in linux-6.1-stan-rkr5 rkbin
> MINIALL.ini files. So I opted to only print out the params that have a
> value different from the default 0x0.
> 
>>
>>> +	for (i = 0; i < ARRAY_SIZE(hdr->boot1_param); i++) {
>>> +		val = le32_to_cpu(hdr->boot1_param[i]);
>>> +		if (val)
>>> +			printf("Boot1 %d: 0x%x\n", i, val);
>>> +	}
>>> +
>>
>> Same remark as for boot0 params instead with 8 4B params for boot1.
> 
> Correct, boot_merger embed WORD_n (n=0-7) from the [BOOT1_PARAM] section
> and also only very few are in use.
> 
> My main test to validate this was to add different values to WORD_n
> under BOOT0/BOOT1_PARAM and then compare with the generated idblock.img.
> 

Cool. Do you know if there's some public sources with appropriate 
licensing for boot_merger for RK35xx? There used to be code in the 
U-Boot fork from Rockchip but they stopped updating boot_merger source a 
few years ago last time I checked.

Could be nice to have it in U-Boot too :)

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
