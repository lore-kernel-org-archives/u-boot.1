Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F4EC3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 14:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43FE388A4C;
	Tue,  6 Aug 2024 16:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Olkze9r/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A550B88ABF; Tue,  6 Aug 2024 16:58:48 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB91388498
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 16:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4HWKqkl2Yu3Ht+4V8oTueNJpfSpBUSMUWpQWkRiCUuXVz4zXV+jjcKBk2MxhWpY/LPJXHDCNYH8nDcY2P18RweVD9t35Qk12KGzd3WJrM/YYLFEdeUrw+IF83ctxXhLbbXKJlyyki0zFJ6tg6Rkkx83B49UPvlw8OZZoUKBsgu5SNC8i2PYYOlttHN+GCPHiO8sxufPA64YPLfQ39EQWx33jyWEl5QvD9BhgCJXuLZD6LtwAV/UmzwbT7wn8nqXoiG0P+63FjYdKqZ9OIecs8MV5rlXqmNt3axWUwx2jaAL69tMUKg+XwkOQ/zhTcCMWQwCFLjQt1WQj7qVhBW6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LqOjgkBaIPpViENuUDs8OLlFx1gfKp1+HLCj9X6Olk=;
 b=u3t/h7FTQeYcOQUKQ4NRl6n0QkaEUeDts37tYviEo3aJdNr6pGUn40GJmsn+Ls5ZjsRK58Elfx2ZywXxXZ4Gt4fuh0GQ3ViCWIfsHadYO+BETy3iTFdz4NtnUv8B9IVVcvsT7WtQCxa8HXJJUez8M8EHwLXBWXK1ddwTczkTOu2zOCm89dUSxJ2UX8KcbjBJHU2Jw8KHumk67CyQuOCzBWA/yPP7CmWkkth/5hgbXdC6c8uONLSOa7lWT+zH9/0xDJpMnALTmtyznAU5Bkm4En/YFujIXWMixHV5W5ccefptqGYOiGzaLGLbAKkSfLVs0cRU1Xq3TnxRxvRBiEB1ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LqOjgkBaIPpViENuUDs8OLlFx1gfKp1+HLCj9X6Olk=;
 b=Olkze9r/H4yBzcH/m/c1h9LHtRPMdEX2EGnXiK4BF9YfUsc6Vr0FMqy2uox/ZmtVyvejKsxcFI6zosYSeiEW8p8m5YV9jvs1Lplqu2X7UdAnlTYlCUnPthRrR9/+IFshbHuhxNSyH8l9Ym1muqCQ18p3FUMpo35KQLYCWa6IF5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU0PR04MB9419.eurprd04.prod.outlook.com (2603:10a6:10:35a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Tue, 6 Aug
 2024 14:58:39 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 14:58:39 +0000
Message-ID: <e2df12f8-44bf-4474-8f5c-ca44f3068ebf@cherry.de>
Date: Tue, 6 Aug 2024 16:58:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] blk: Correct comment for
 blk_get_devnum_by_uclass_idname()
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-15-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240721152600.3212917-15-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0361.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:82::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU0PR04MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: f772f8a2-dceb-4732-6f1e-08dcb628417b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RU9ob2tScXo4RHk2NS91Rncxb05zL1JicDJtRkRnN3JPVERRMTdxR0J5QnBF?=
 =?utf-8?B?VGh6Q0tHMVhBcmw1SW9mMkJSY1MybEY3YmxRbW9WQnE1b0grL3BSZ1NhYkJW?=
 =?utf-8?B?NFQ4L3dvU09HZk9KRmpRUmpldlRYSjV3MjBld1pHaWhoVHFpUjdWZDUxN0Vq?=
 =?utf-8?B?azVDZmVrd3BIRHdXUGd4NnFxOU5zRVpTUTF3MzZoNXpMMEZhNGZrbi85VWpq?=
 =?utf-8?B?Zk1BWFYzQnRIclp4N0tpcFNLVERwNlFvcTBXaHFDVGlvbFcwb09jTEVSSTFl?=
 =?utf-8?B?QWZTQjVLdEc2VWJWM2U5RXdRRFcxMWpWSGtTRTQyNmZienVPdjZPbTJ1MGJx?=
 =?utf-8?B?bHc5c0VsWVprR0ViMnV6R1RjTUhRb0NTWmt0YnpKRG1BaUJiK0RlOGlWOE9t?=
 =?utf-8?B?akhYaEhlTGw5N05FZlBkTkZiMkxlVkhjenFRTG9JRlhNUWJqalJmcjBlM3I0?=
 =?utf-8?B?L0pyY2ZkMjE3RjFCY3BzSVp3Q0RMUGtab0UzOGYwZUVma0RTbXpidDZOMVMx?=
 =?utf-8?B?clFpVlFsSWxGcXBFaWc4SWlZTEVqZk5CMG1RMVREMXhIMmdvVFFLT0N4aC9q?=
 =?utf-8?B?NWh4dW9USWwyV1QwYnlBN2xoUFplVkc4RzZtelZBSGs3SWJBbTNyRmN2dkxz?=
 =?utf-8?B?RWpaa0NiWWdvbVMxdUk5UkxNOGxlc2oyZDhld0VmekJ1RUxXRXBBa1pDVTNQ?=
 =?utf-8?B?dCtHNHJUK2ZJZnJBa2NsdXNhRyszU2dTN3QvOE5oTU4ybGx0Lzd5TnlYSVBi?=
 =?utf-8?B?R0x0ay9LQTdvc0dBMmxvNWI0UkZIcngvaFM2QXRDMnpXc3Bxc1F5OWdPU3ZZ?=
 =?utf-8?B?N3VKYytWQjdGa0J6SEREMzJtejhVczhiT3lidFdBSmpIMjNYL1ROVEgwYVRF?=
 =?utf-8?B?REtwamp5ZmVHZlBpcHNIeThoblhqc0ZIcUJyS3JiQ0xWVGhoVXVBdmV0QWFD?=
 =?utf-8?B?TU1Pdk00anhRVlgzbjh2YlZHS2lCYmlrQ2REbUlEeDUzVCs2bS9YY0JUZjlO?=
 =?utf-8?B?cldYNnRtMkoraVBaVHdLWTBXelU3ckRpZ2lzRlREckJLWjFDaklEK0JtRERp?=
 =?utf-8?B?TFhvTVNXNkVXUjhmemh4eFEyLzdVZ3YrOFRqeVRSQlJuSUZTeXQrQVRsQVdr?=
 =?utf-8?B?ZGVSY09XTEpUSmtPQXE0QmQ2K1JmTndQRUFzazYwU21IS2NXdjZzTGhBSFRO?=
 =?utf-8?B?dEN0bmNxV2doTWRYN0RGV2RJU0c4TUlwVzBMb0FRK1h5aFZETXNDUHpTMmxq?=
 =?utf-8?B?M0hSbmFCUFB4MVRPWTdXNUI4MklWNFFDalNkcUU1V1gvNC91S2xFN2hDWkRk?=
 =?utf-8?B?TlIydGNOeHhaVWswRU9vLzlwMlA2MHNYbXNyMGpYM01JWDB5cHRMRVVTcnFF?=
 =?utf-8?B?VGFjZ3h2UDdlRGNVbVowMVpUeVpOL29YOHgxSnc5bVJRVGFSTklaL1NReTVC?=
 =?utf-8?B?QStxTFZ3Yjh2ZDFkb0pZWElXZklubG5DUXdoaWhUMHFjdlRFWXRwamtWNlhF?=
 =?utf-8?B?TkM5Y1dFdWltdTcrc1pUbEIyK09qdityeEFDWU92UnZ1ZVZqWkwxZnRNSngr?=
 =?utf-8?B?eEUydG1VYzJmQ3FLSUZ0VUFONldCVXV5VEp6b2x0cDRYdGxmU01uUGdlNTQw?=
 =?utf-8?B?NzVLUkdCNTA1RVZaQ0g4Y2w2Z0NFbWo3ckZyMzBYRjFaS1ExaEdSL0hoeE5p?=
 =?utf-8?B?QmUwbEhIU0hLaEZ4azVCUXpaZHJjWG9tNmF1ZkF6OWhBWWNwbHBtajdTM293?=
 =?utf-8?B?ZUhJRHUyUE0reXRzakdaNmJ4eXJRNzdpY2hNWDdhRFpQeGRMQlBiMzU1WXJ2?=
 =?utf-8?B?dHFKOVp6RGkrMGhxMXR0QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW9wZkVZL1JVNjc4YXJhb2pIYS9kd2lqNkMrdDR5aWNWcCs3bWRNNVdlRVpu?=
 =?utf-8?B?NkQ3WDMvV2hPbnpTRDlXY1Rla0FwMXFzYXpha2lvbm1CdVRueUxUREZGalRV?=
 =?utf-8?B?MUl4MzIvVjdOT3JTaUtoOHJ2WDNxUGxxb2RpZE9aWDJ4UUdjbGVJdERheHNx?=
 =?utf-8?B?VHMrSWdCZ01MTlBXM1JUSnNNUmpQeTJ4c3ZobHhnSWFCVDJxb3ZWZmpRZGNX?=
 =?utf-8?B?NWNyOUhMT3RJL0lBak44Y09YUzY1QVdrdG54L0tOMUhRSk44YjcrRlN3ZHhv?=
 =?utf-8?B?K0xvWC9EVm5vZnNadzh3ckd6LzdMZkFQTTBCcllaejRiSkY1Y05iRGlzUnEv?=
 =?utf-8?B?K1orcDhSdjkwYkU2NXpCNVV3R3k2ck00ZVMxQnI5T1hPNkl0ZGhzalZtSUNq?=
 =?utf-8?B?dlpSZE1Sc3UrMG5lUHUyQzA4TVZObzNJMkFSVUQvUFQyY2dqaTVBeEVRb0E5?=
 =?utf-8?B?UGYxQm5ydTlkUnV4MU92RXhJSk5sUW5RU01NMTVsVExKT3JJdHpkaElWNDNS?=
 =?utf-8?B?WXhEdkx4MnhEYkwyU3lKOFIrT0JyMTFlS1BpOTBRWTNGT3dBZTV2MWJJN0I4?=
 =?utf-8?B?aEkvQ3k5MVZYblV6TUhBbmc0S0wvODM1M0xJQmFhb1ZQMy9jSFc3RkZqTjJt?=
 =?utf-8?B?eHB1UkJBR3VUVDdhNG1OSHFNdnVONzVXRXFVNEdkVDBUY1JaTWFqVUk2Rlh3?=
 =?utf-8?B?V05KNjI3QVI3UDhwY1FaaEVkNHNVNkt3c0N3b20ycVVjSmZ4WnRkdW5TV3p6?=
 =?utf-8?B?UWs2dnEyV0tGc29SUUtza1ZwbGRwdllkMGpyTEEvTjFmenJ4cHN5dUVKK3Vx?=
 =?utf-8?B?dVMyc2oyVHJKTXYxZjd3dkZWYWIrTjVKUlo0NkRpZkFXSW54YW53ZVhuYk1l?=
 =?utf-8?B?N1p0YXMxS25xU1hLU0NNK3N2WDZsdUM1SC8xRk0za1hZZnhwazNlcXd6VXFP?=
 =?utf-8?B?VWNsempod2NvSmVMWkUzY0lyemlyajFNeldWSzlyZHR5VFV2WGh6K3F2M29V?=
 =?utf-8?B?OWczLzUrNTZIbWhpYnVpaTN4R3g4SDdjaFZvZTBPRUxlNUovc295dWJFbG9i?=
 =?utf-8?B?L1pIdHpSR29oUGlHNHd1TnBpYy9XRE5RM3FwRGNVTkdkdjB6K1VZcStzajlx?=
 =?utf-8?B?MU1TcEJsalZYWndpSVErcGc5L2NQQTdkVXVwZEJIZ2ZYQmd6TmVJbXZlOWpz?=
 =?utf-8?B?VEpGb2UrUXFETXJPdnBwQ2JUUjdEeFJkckRrZk9UWmZLVDEvdXFXK2N6OUw4?=
 =?utf-8?B?YnI4T1N3UlpzOVQ4TUZXekpnbFpVNHlaK2lPK0dUMmh5Ni9sVGhXaGZROExX?=
 =?utf-8?B?TXkzc0xScC9GZUhTbXgvbEt1Tjl5d3plRFlocTJLQ1hPQzMzTU5aYWZvRlVO?=
 =?utf-8?B?N281cHhuODg3dkFlSWNPQmdxNmJuaFN4QVNZNm40WlhSd2tLQ1RHVU1kdHRr?=
 =?utf-8?B?VG1nc3Y2WFFrUnU1RnNyUndYdW05L1FIeHBBQ2JmTzREczd6OXQxejI0emk5?=
 =?utf-8?B?clpNY04vcXJMdmMxK0xpWTJKWTRZanF3M2wxbTVyRGRLZEIwOENBOE9LZWUy?=
 =?utf-8?B?SGN6cy9vKzVpTFFEaW5zNDVDbS9Oc3lVMWFDWFVZZWR6SkRnRXpwK1ZLZ1Fj?=
 =?utf-8?B?MVBZWXA0UkhHd1o3dGxyYWtTd2gwKzRoc3FPM1lLUXF0YWN1VTNnNmQ4V0po?=
 =?utf-8?B?NCtCMWFOYVMwUXBJMlFTWmQ5NEhpcno3eGlSSnJtZTRNSTh5ZVZJR0lQZTkw?=
 =?utf-8?B?SU5CQTZyRThHaUg1RWNQS1RBR0RIQjMyKy83MzhKSmY3ZkZOQ1BYWmxHbnRm?=
 =?utf-8?B?T2FGR0JPYUt0ZnIyWHQrbGdEQloxNFNWY3pGUFI5Tm94QWs1RUl0aXpOM1g0?=
 =?utf-8?B?eDRXaTE4S0tTSWhjMzd0QVRSL2RERUtPTjBTU1FKbTBEWlhHNU9pOTlEeUFt?=
 =?utf-8?B?bmF1aURHTGRUbCthT2U2YWtFRk90aUpyeVpFNEFFdVBCWjlmZ3hCT3JVUEJS?=
 =?utf-8?B?VW94QmE4SVFQUGR2cElvdXRHNHQrZnRIOVNLT3NZdkdITmlQb2Q0cG44RlFD?=
 =?utf-8?B?Q1M0bnVvZHFscFRZQ0J3NlIxd1hPWHRVbUtWRkorVkdtOEFBb0s0K2l0bElM?=
 =?utf-8?B?bGFFTW9oMlFtU1M3RmkwNXUrU29XSEVWc0gwNE5ZQjl1c2taRlRSbzRIVG9V?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f772f8a2-dceb-4732-6f1e-08dcb628417b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 14:58:39.4760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FcYVUutok9QoBBpP+yHZ3Q+Fohk6NBaAAqtIPqtED5roZK2qXelJ4NZ1gqiQpwHJ6qHxM2bXHXqTBPd/QQv/cyjsS+MliLrTD0JHHNK7L1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9419
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

Hi Simon,

On 7/21/24 5:25 PM, Simon Glass wrote:
> Update the comment to match the function. Fix the indentation while we
> are here.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Sean Anderson <seanga2@gmail.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
