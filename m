Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C598EE7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 16:46:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2325A800D7;
	Fri, 13 Dec 2024 17:46:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hITI4Fkk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 333DD80104; Fri, 13 Dec 2024 17:46:08 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3549E800C8
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 17:46:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFCG/qlfWmEKZYTaZSxbSEng6Y5q+QwZVsoSZcu+zUOiF646WZPnJbBpUVQcvaNOeE0fiSsEjeujNnvnzCjxBVRi1bUTTGC1R6C6488Rz5tbI3U5t45MMfW5hLuhOdZe8jEOCbuMS345t0wM2iR4PCIjtnaFFWdqsRHzF9+qR9tkRxObEGTZkR0BUqywOF2/4Z3ufRFcLzOlru5flUXrFKi6BelEZNoG43ZFV1PXT5USm0tiswQf6mCnD+lrKZYUigWbsuZiFW21YruM5RxLElucg2B9sHtFDAu3XfWvLtHwwTUc0tW+jWjQG3hhBRkHU1iYSmrsrYAqzqUoobVY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wj9SB1nE6NMF7XsQaYKCdAH5AYKm5xcS+h/yIphjBt4=;
 b=FIIDPLM4hqtHnTaZ6f1oXJ6JI7mCyMnclq77fQxxN2lHH7vaRh3EgNbYuWgphKzbk03H/YmkKGBb2nNenoflKEEWl4Nc7M9DwuFD6obkBJmMOf6uDSDd6+6voSx0Y24JeYYF35I1zs2/M0ZVdNyXe7AayxtQ4ChEsN8WddFQ9iK5Vyr9ULwJkOD8WbASZXaHS+IwhGbowcvk/e+HAwVhG2oTl7M63/rRzw4xRx/ntNWCRtPet0senYtExm1Bl4KV/YZeOmYXnoGd/ZYqhFGDsuTRjV8RKZ7YIgfnPtdXt3uEstG0BUdDSDZX6luIpbJBwg0oN4CRW6+lRT9QKJTOhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wj9SB1nE6NMF7XsQaYKCdAH5AYKm5xcS+h/yIphjBt4=;
 b=hITI4Fkkk3Be7suk1J55iAykaUDPJBxG1Iz2J7C0041I8ABH8YFKE+f+Va+6LJr69svhiiMCWKgK+bkATEo2amzEI2GFyv349N0Ydh3+9P+mH2tbw8OAfgK8W/B0KMLe54rf6y22l4I2Jmtf9ZSMBVE2qd1YJHQBcHhH7KMhCjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBAPR04MB7381.eurprd04.prod.outlook.com (2603:10a6:10:1a2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Fri, 13 Dec
 2024 16:46:03 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 16:46:03 +0000
Message-ID: <b0186dd6-f5d7-42fa-b7f5-461092d8ee94@cherry.de>
Date: Fri, 13 Dec 2024 17:46:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: Add initial RK3582 support
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20241210222341.3537543-1-jonas@kwiboo.se>
 <20241210222341.3537543-2-jonas@kwiboo.se>
 <e10f729d-cc77-41ba-b165-e32f6e058422@cherry.de>
 <223d5d07-bc97-420c-810f-bbf967ec5af7@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <223d5d07-bc97-420c-810f-bbf967ec5af7@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR4P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBAPR04MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: ed84b85d-5245-4dae-08c4-08dd1b95a1a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUhnVE9RY3VSR0NPSUR6WDVDeCtWSldCSUM1cFo1dXFYQXJwSzVOTDRMNVhI?=
 =?utf-8?B?T1JsZ3dYdklpT0JNeUVoait0azdXZVJ1MGEydklqbXVGMDlpSE9BTnBNaFJP?=
 =?utf-8?B?SFQ2YTB2R1VmeTVKakhQa0dZa0V6M0d1Y1JPOFcydzRhOU1zY0dXNnhWc2tI?=
 =?utf-8?B?RFhHd3NvbWRlZkd4RkltbDVKejVSNXBsMUJ1UFEyUzQrbjZPMXdZMTlDMnlG?=
 =?utf-8?B?bWs3Q3oramsrODBlTnFtdjEyRW1STVFYdTVXNDExalVGT3NIVEFidmR0ZWsx?=
 =?utf-8?B?dkhNWDI5U3BMblZPZWR5eWdNMWZ2VjdpcXdCY3ZMN0NlWjRmNWtEWE1jR254?=
 =?utf-8?B?VUpNT3FYM0d6Mlg1c2xKWGlSWkJtSTArTGt5L2dxV1RpRENOUnNCV29LQ2lR?=
 =?utf-8?B?TGl0NG9PQVRTNUVhNEZSbzFQZklGV3ZBM25reG1IMWFwM3ppSEdYaWhkVWNs?=
 =?utf-8?B?YXFXbThUcEdxNUdpeko1WVVmSVR4L2h4TnRGYU1EL2I3U2RxWVMzdXJsaDM5?=
 =?utf-8?B?T3oxNlpCMXpRQnFxendnVUpHWi9XYm42SzBTaGwvU0dJT00vbTA3Mi9NMkw4?=
 =?utf-8?B?bVR4eVV1a0hUTEZ2YVpJL0RKZ0w0UGxzOW9ndUlOeW00YmpoK2o4aGVlamxw?=
 =?utf-8?B?U3lYTGxJTjQzOVlwdUw4cUlONkdQZ1pvODNneHlpek80dnNJMFpwYkdORXZi?=
 =?utf-8?B?Vk5XODJLR0EydzJLTEZIY1BrMTcwVy9sY1BsRzMvVlg2NmpsZmJ5ZGFmT1A1?=
 =?utf-8?B?T3RWVkdLaSsvWERlNk41Z2cya2ZWY1RvU1hnTnF0eXRPRGZnZTFDd2RiajRt?=
 =?utf-8?B?MnNBVDQzU3pDQTNWYWlzbFNyZStST1FFVVlEU0JBN1B4K2Y4WFFtTGltYWtW?=
 =?utf-8?B?eDBISzFRVXBRckVwazhOc25zZXB0WHhWUlY1OC9XUzlZTGFvbmtOOUsyand1?=
 =?utf-8?B?N3FNVVRIbE9VYjM1RzN4MUV5MEhUc2twVC9xU0xqc0tEaG1ES0prQXBUWDkz?=
 =?utf-8?B?SmxHVFNyWnkxZlhITzRjcUlZT0g5bGV4OXRvWVFNeFo0VTZ0VHFKeWM0aXVt?=
 =?utf-8?B?aHRuWDFJWEN2UGtzcE9Pb3JPcUVKY3hpdVNCR3VNRGV1c3U2UWo0NmlhWG5M?=
 =?utf-8?B?QWg3bkloVmczdEM3blV5VE9lbCt4emtkazVDMVN6YjgyRzMvL3ZjNjhoTzFY?=
 =?utf-8?B?TVBNVzVSaEN0MEdCSFhNbnJ2a2RqL3VVbVFvQXNVKzZDWUM4d3FRUk5ENzIw?=
 =?utf-8?B?T0Mwb3pka0pFeTFMUDVudUhzTFg2VTZKeFIzdjlGNTdZM1UyejVQR1F3ajM4?=
 =?utf-8?B?RkxrUDkyWGV0Z09RVUhZSmthYVNjSVBRK0hCMTg5V3czTVBibUdtckVwdmVF?=
 =?utf-8?B?UVptTUdxRVAwZjdSaUEwUzJWTEQ0NHJWbVFmTUwyc3drQzU4QzdTbGhuZmlq?=
 =?utf-8?B?VmNZMFB0WU1NSWd3anFSN1Q4VDIrRlUzU0lwY0o1bUR4RG1RTS9DOWN3RTYv?=
 =?utf-8?B?RXE5M1FzZlViRTE1YkZMSFFiVnlsOXUyVlY5VWUyeEtRMzNCTUE2bFJhcHlH?=
 =?utf-8?B?OU9qZzQ0ZkNhUVY2a0ZsaUU4Rll6RHU5Ty9RU2txZTF5V0RXaVZXVGdGWGpu?=
 =?utf-8?B?Vk42dGs1ZG1GbkJmeUthalZQWlhnTG1ZT1lLclhIUzdlTGlFWE9Jb01FNkkv?=
 =?utf-8?B?SHJ1NnRXZEZSVFRZNEpneC9MMkQzOEtCRlVNa0JSNFJmNE5vaWU4b3U3Rmx0?=
 =?utf-8?B?b0MyaWxUbE1Ja0RmQzdRdkY5N2pkL2NwdnJiSE9CUTc1MVJTMkxTWkxmRXZR?=
 =?utf-8?Q?iQR3tyM4flb4mUMslisNtAPBjYqviPAsGbfxM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djVhMmVhMTlzWW5CaEdzbkpWQjR6TmVqSmNGT2syK2c0V2cwZVZMRVNSM2w1?=
 =?utf-8?B?VE1Ed3Jlbko1U0M5SDZNZnlYZEo2NGtXUkVBaUFMSDk1ei9vVmc5akg2b25t?=
 =?utf-8?B?elVCM3VCcS9GQjVGVU1NMW45QzBXNVZQWkk4czFmUkxHdlgyY3luOFdCM1Y2?=
 =?utf-8?B?aFpsUXdHMkFJbnRzV0RZS1dPajA4Z3BYNi9hWGYrZWxrMHhOeDdpbnZ4WUhQ?=
 =?utf-8?B?Nms4MHJHaTB1T2ZBcnI4WnZzNlpIK0NkNThoNUhKN0xGaVdCUjVkWmloK0E2?=
 =?utf-8?B?NXRGS3IzY05kL01RZ1NQZ3VIL2tYNWlCeElvOUFLVlB4RlVWZTlOaUFZNm1T?=
 =?utf-8?B?L2RvRWx5bXBTNHR5eVlyMEJuNUVCWit5WVJaOUh5TkE2eVZPS2xHN2lmZWVL?=
 =?utf-8?B?cU5xQ0F3T3IzT0p5ejZZNW1TUFNvL0JBdzZ5VHdZWDB1blViMDMwL3h4azFO?=
 =?utf-8?B?TFYxK2k3Zk5vUnhFU1lldm9DeFlDTTBOV1RTcDNaRUpIdERjbVdkRzdaZVhN?=
 =?utf-8?B?QUZ1UTAzZG1kYXRwWFZmQmlHSUxuRjcwckZ2SlcvUlpyNUdtOWo1ZTNoR3l3?=
 =?utf-8?B?RGJna0tpOWszZEtBdnpIUHpSUzl5VUQ1ZlVROUpZQXAvNTRWWVk4M0xCbE9F?=
 =?utf-8?B?U0ZSK0kzNkNSbUVIOW5mbVZVck5PL25FZ1NOYU1lcFRLSVV5VENKcE02cm5N?=
 =?utf-8?B?WUl0MVlvVHdoY1BSQ0pucVZLQjZFbTlTSXQyTTZkUEZyUWJjV0RtaDRiTEw4?=
 =?utf-8?B?YkhOY2lUdWdqK2lxN3JodHVyU1prb0N4NmVwYzlveDhuMkl2SkVXc0pHWjVh?=
 =?utf-8?B?Q3BITUJOVUZtUjh0TkFlWmVGT2pQN3pvd1QzMUl5d3dvSlZmQWFGbzlzaVQy?=
 =?utf-8?B?VDkrczQyNHFybStDMGR0UWp4cWhtaDRQbjFsaURUVmtHb0FtSm0zakcxRVFn?=
 =?utf-8?B?c2dQQ2ZrZ3hrRVZkNWYvSTBSMytQUm9zbzd6ZEVmV1V6L00xR3E1YkdlWVhC?=
 =?utf-8?B?Sk12SXZnMzlxTVZtRGZwcVgyQ0IzNlFNUDJPUnErZEtNVTdBaC84Q2RITzFy?=
 =?utf-8?B?YXU2THRWZ1RqNlduUUZ3WmhpelFnMXVXK2NZNFF0ckN4TzAwMUM1SFNWdExJ?=
 =?utf-8?B?dDJKeFlUa1oyQ0d5emF1cGJwcTRSb2Q4Z0hNdW0zTWUra0gwY09rbDNVYzNV?=
 =?utf-8?B?YWNibWdiS0dlcFVKZW5JTXo0eDljc0NDaU1leHgxVEkyVG5pdHJ0bGhzQXlN?=
 =?utf-8?B?M1RSNk52dnhtbUMxSTVWZ3dnQ1l3RDBBa1I3VklUcWo0cDQ0TWF4QzR1Y1BI?=
 =?utf-8?B?MTJMNVBmSzBhK2c3cWFQZFRobkMrWnFLM0pxQkd2dm5WVEkvUHNXNjlWZ0pL?=
 =?utf-8?B?N1ppMWViWllBWjhFN09jQ0JYcXRobjBGaXhSOVgxQWcwMnkyQ2FrS3MyajFk?=
 =?utf-8?B?bzNoM3VObDdQRFE1bHpjdEtmVVR0UVVuZW92QUJuektSVndoYmZQTk1VODFU?=
 =?utf-8?B?VjhNeVJtdWVDUHRNSllmajB3K3AxUkQrdHJTd3VBb2Vzd21Ua0o2TGNjQ2I2?=
 =?utf-8?B?NCswVkk3WWpkenVEUXJuNG0wamJaL0JyeEM5RERYK2hnU3hHRFpzV2x6VitR?=
 =?utf-8?B?NDY0emlEL2JIVzhpdmZWd2x5QlozY1R3Zkh0RUJ1WmRFR05rUDFMM3lYcWwr?=
 =?utf-8?B?ODBrbTVyTm9HRGRXdEJISVc2Q09saThjSlNqSjFNMkRBUnI5aXBkenVuZXpZ?=
 =?utf-8?B?QVllTDFJekgzSW1hNFhOVDcyYWE5VDRwRFBVVmsvQmt3QTNrd3RqdWFWdi9E?=
 =?utf-8?B?dEFXTnhjNTd2Q3RtZkg0NmJzUTdyellWcXErOGM1RURSMVN3R3lqZzdtTm9p?=
 =?utf-8?B?SERpNUR5amZxcWFEKzlBcU81cjFIZDYyT2FUTE5sOUNwN2lpSE4yS3d1TGNV?=
 =?utf-8?B?L0MyaEhtSjhFT3Fvalp2SCtLakVnUjRJV2lTOWt3UzF4VCtWM1ZjZ1FTSXJI?=
 =?utf-8?B?TllzNVdsN0pNd1I5Ykd3b3VUM1pUcGpRdnQzd1M5aTFOa0xMUVNUb3BpTUlT?=
 =?utf-8?B?V3YzT2duemVQdEdRWW5HZnFwWWZ0Q2F4d1FJYW5IUnltRXRNWGFQOE05VFcx?=
 =?utf-8?B?UlZMN2dNMitvUFpEYzVWRFEvaWJGaTRzWEYyR2tYbXlEd3FJaFhRT1lWN05l?=
 =?utf-8?B?NkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ed84b85d-5245-4dae-08c4-08dd1b95a1a4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 16:46:03.3661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdLwF5Gr8iYZ2QIQBsblkdMZKr4nls5eiMAM1Qp0Y9UyCiECxuQBKjVXQbELZrpmpdciR8IXDRCqUBn/tjUIQgkTGUSj79YWBmGTs1Jb7Y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7381
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

On 12/13/24 4:20 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2024-12-13 14:43, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 12/10/24 11:23 PM, Jonas Karlman wrote:
>>> The RK3582 SoC is a variant of the RK3588S with some IP blocks disabled.
>>> What blocks are disabled/non-working is indicated by ip-state in OTP.
>>>
>>> This add initial support for RK3582 by using ft_system_setup() to mark
>>> any cpu and/or gpu node with status=fail as indicated by ip-state.
>>>
>>> This apply same policy as vendor U-Boot for RK3582, i.e. two big cpu
>>> cores and the gpu is always failed/disabled.
>>>
>>> Enable Kconfig option OF_SYSTEM_SETUP in board defconfig to make use of
>>> the required DT fixups for RK3582 board variants.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>    arch/arm/mach-rockchip/rk3588/rk3588.c | 128 +++++++++++++++++++++++++
>>>    1 file changed, 128 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
>>> index c1dce3ee3703..06e6318312b2 100644
>>> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
>>> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
>>> @@ -7,6 +7,7 @@
>>>    #define LOG_CATEGORY LOGC_ARCH
>>>    
>>>    #include <dm.h>
>>> +#include <fdt_support.h>
>>>    #include <misc.h>
>>>    #include <spl.h>
>>>    #include <asm/armv8/mmu.h>
>>> @@ -185,6 +186,12 @@ int arch_cpu_init(void)
>>>    
>>>    #define RK3588_OTP_CPU_CODE_OFFSET		0x02
>>>    #define RK3588_OTP_SPECIFICATION_OFFSET		0x06
>>> +#define RK3588_OTP_IP_STATE_OFFSET		0x1d
>>> +
>>> +#define BAD_CPU_CLUSTER0		GENMASK(3, 0)
>>> +#define BAD_CPU_CLUSTER1		GENMASK(5, 4)
>>> +#define BAD_CPU_CLUSTER2		GENMASK(7, 6)
>>> +#define BAD_GPU				GENMASK(4, 1)
>>>    
>>>    int checkboard(void)
>>>    {
>>> @@ -230,3 +237,124 @@ int checkboard(void)
>>>    
>>>    	return 0;
>>>    }
>>> +
>>> +#ifdef CONFIG_OF_SYSTEM_SETUP
>>> +static int fdt_path_del_node(void *fdt, const char *path)
>>> +{
>>> +	int nodeoffset;
>>> +
>>> +	nodeoffset = fdt_path_offset(fdt, path);
>>> +	if (nodeoffset < 0)
>>> +		return nodeoffset;
>>> +
>>> +	return fdt_del_node(fdt, nodeoffset);
>>> +}
>>> +
>>> +static int fdt_path_set_name(void *fdt, const char *path, const char *name)
>>> +{
>>> +	int nodeoffset;
>>> +
>>> +	nodeoffset = fdt_path_offset(fdt, path);
>>> +	if (nodeoffset < 0)
>>> +		return nodeoffset;
>>> +
>>> +	return fdt_set_name(fdt, nodeoffset, name);
>>> +}
>>> +
>>> +int ft_system_setup(void *blob, struct bd_info *bd)
>>> +{
>>> +	static const char * const cpu_node_names[] = {
>>> +		"cpu@0", "cpu@100", "cpu@200", "cpu@300",
>>> +		"cpu@400", "cpu@500", "cpu@600", "cpu@700",
>>> +	};
>>> +	u8 cpu_code[2], ip_state[3];
>>> +	int parent, node, i, ret;
>>> +	struct udevice *dev;
>>> +
>>> +	if (!IS_ENABLED(CONFIG_ROCKCHIP_OTP) || !CONFIG_IS_ENABLED(MISC))
>>> +		return -ENOSYS;
>>> +
>>> +	ret = uclass_get_device_by_driver(UCLASS_MISC,
>>> +					  DM_DRIVER_GET(rockchip_otp), &dev);
>>> +	if (ret) {
>>> +		log_debug("Could not find otp device, ret=%d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	/* cpu-code: SoC model, e.g. 0x35 0x82 or 0x35 0x88 */
>>> +	ret = misc_read(dev, RK3588_OTP_CPU_CODE_OFFSET, cpu_code, 2);
>>> +	if (ret < 0) {
>>> +		log_debug("Could not read cpu-code, ret=%d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	log_debug("cpu-code: %02x %02x\n", cpu_code[0], cpu_code[1]);
>>> +
>>> +	/* skip on rk3588 */
>>> +	if (cpu_code[0] == 0x35 && cpu_code[1] == 0x88)
>>> +		return 0;
>>> +
>>> +	ret = misc_read(dev, RK3588_OTP_IP_STATE_OFFSET, &ip_state, 3);
>>
>> Do you have information about what;s in the third byte? It's not used in
>> this patch series for example, so wondering if it really makes sense to
>> read it and dump it?
> 
> To my knowledge information about rkvenc is stored in the third byte.
> 
> Vendor U-Boot [1] lists following:
> - ip_state[0]: bit0~7 - cpu_mask
> - ip_state[2]: bit0,2 - rkvenc_mask
> - ip_state[1]: bit6,7 - rkvdec_mask
> - ip_state[1]: bit1~4 - gpu_mask
> 
> However, vendor U-Boot also #if out the entire gpu_mask so not fully
> sure if that is correct or even filled in.
> 
> [1] https://github.com/rockchip-linux/u-boot/blob/next-dev/arch/arm/mach-rockchip/rk3588/rk3588.c#L1393-L1404
> 

Yeah, seems to be entirely ignored and the GPU always removed for RK3582 
but kept on RK3583.

>>
>>> +	if (ret < 0) {
>>> +		log_debug("Could not read ip-state, ret=%d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	log_debug("ip-state: %02x %02x %02x\n",
>>> +		  ip_state[0], ip_state[1], ip_state[2]);
>>> +
>>> +	if (cpu_code[0] == 0x35 && cpu_code[1] == 0x82) {
>>> +		/* policy: always disable gpu */
>>> +		ip_state[1] |= BAD_GPU;
>>> +
>>> +		/* policy: always disable one big core cluster */
>>> +		if (!(ip_state[0] & (BAD_CPU_CLUSTER1 | BAD_CPU_CLUSTER2)))
>>> +			ip_state[0] |= BAD_CPU_CLUSTER2;
>>
>> That's a very interesting choice, wondering what's prompted this
>> decision (which I assume comes from vendor tree :) ).
> 
> Not sure myself, my rk3582 boards only have a single rkvdec, kkvenc or
> cpu core marked as bad, have not seen any board with multiple cores
> marked as bad.
> 
> I did a simple tests with only disable the exact cores that was marked
> as bad on the board with a bad cpu core and left all 8 cores enabled on
> the other boards and that seem to run fine.
> 
> Could be related to marketing or thermal, the policy was copied from
> vendor as-is.
> 

I misread the code and thought we only disabled the cluster but this 
actually disables all cores in the second big cluster (and the cluster 
itself). So my comments about removing the cluster node and not 
disabling the cores inside the cluster (which doesn't exist anymore) 
were incorrect.

>>
>>> +	}
>>> +
>>> +	if (ip_state[0] & BAD_CPU_CLUSTER1) {
>>> +		/* fail entire cluster when one or more core is bad */
>>> +		ip_state[0] |= BAD_CPU_CLUSTER1;
>>> +		fdt_path_del_node(blob, "/cpus/cpu-map/cluster1");
>>> +	}
>>> +
>>> +	if (ip_state[0] & BAD_CPU_CLUSTER2) {
>>> +		/* fail entire cluster when one or more core is bad */
>>> +		ip_state[0] |= BAD_CPU_CLUSTER2;
>>> +		fdt_path_del_node(blob, "/cpus/cpu-map/cluster2");
>>> +	} else if (ip_state[0] & BAD_CPU_CLUSTER1) {
>>> +		/* cluster nodes must be named in a continuous series */
>>> +		fdt_path_set_name(blob, "/cpus/cpu-map/cluster2", "cluster1");
>>> +	}
>>> +
>>
>> Nitpick on readability (to me at least, matter of a taste :) )
>>
>> Could suggest:
>>
>> if (ip_state[0] & BAD_CPU_CLUSTER1) {
>>       /* cluster nodes must be named in a continuous series */
>>       fdt_path_set_name(blob, "/cpus/cpu-map/cluster2", "cluster1");
>>
>>       if (!(ip_state[0] & BAD_CPU_CLUSTER2))
>>           /* cluster nodes must be named in a continuous series */
>>           fdt_path_set_name(blob, "/cpus/cpu-map/cluster2", "cluster1");
>> }
>>
>> if (ip_state[0] & BAD_CPU_CLUSTER2) {
>>       /* fail entire cluster when one or more core is bad */
>>       ip_state[0] |= BAD_CPU_CLUSTER2;
>>       fdt_path_del_node(blob, "/cpus/cpu-map/cluster2");
>> }
> 
> Main reason for separation with above rk3582 policy handling was because
> I added the rk3582 policy last second, and it also made it possible to
> easily remove the entire cpu_code == 3582 block if one wants to use all
> cores not marked as bad.
> 
> Also in the vendor U-Boot there is a mention and different policy for a
> RK3583 variant, so current separation may be preferred but will try to
> add some comments in a v2.
> 

Up to you.

I would do:

1. For RK3582, detect if at least one core in a big cluster is broken, 
then mark all cores in the cluster as broken. Do that for both clusters.

2. If all cores in a cluster are broken, remove the cluster and if 
cluster2 still exists, rename to cluster1.

3. Disable the cores according to the bitmask.

The logic hopefully should be similar for all other binning versions of 
RK3582 and if someone wants to ifdef/remove the RK3582 logic of 
disabling the whole cluster, it would be simple without changing the 
rest of the code.

>>
>> For CPU clusters, it seems the bitmask matches how many cores there are
>> in a cluster. Right now we are removing the whole cluster even if only
>> one core in the cluster is broken. But I see later that we only disable
>> the cores marked as bad. The dt-binding says clusters are for one or
>> more cores, so maybe we are too eager here to remove a cluster even if
>> not all cores in the cluster are broken? Do you know what are the
>> possible side effects of removing a cluster but still having one of its
>> cores enabled in DT?
> 
> The code do ip_state[0] |= BAD_CPU_CLUSTER2 when one of the cores in
> cluster 2 is marked as bad, so both cores will be marked as failed.
> 

Yes, misread, sorry for the noise.

> Howerver, the code should probably just remove the cluster if both cores
> are bad, should make it easier if one want to test without any of the
> policy. Will try to re-work this a little bit to make it more readable
> and easy to just comment out any of the policy lines.
> 

Agreed. Cleaner separation of the logic for the cluster removal and the 
core removal.

>>
>>> +	/* gpu: ip_state[1]: bit1~4 */
>>> +	if (ip_state[1] & BAD_GPU) {
>>> +		log_debug("fail gpu\n");
>>> +		fdt_status_fail_by_pathf(blob, "/gpu@fb000000");
>>> +	}
>>> +
>>
>> Here I'm a bit perplexed. We don't define multiple cores in the GPU node
>> on Linux kernel IIRC. I have not a single clue why the bitmask for the
>> GPU is 3 bits, do you have any idea or information?
> 
> The gpu_mask in vendor tree is not used and the gpu is instead always
> disabled for RK3582, and left enabled for RK3583.
> 
> Was not sure if we should try to use the ip-state values or just, so I
> went with a similar approach as for cpu cores, fill all bits in policy
> part and check for any bit in the fail part.
> 

If we still want to read it, we could print its value but zero out the 
bitmask anyway by default. Then force-set it for RK3582.

>>
>>> +	parent = fdt_path_offset(blob, "/cpus");
>>> +	if (parent < 0) {
>>> +		log_debug("Could not find /cpus, parent=%d\n", parent);
>>
>> Any reason for not making this an error message? Are we expecting this
>> code path to be hit in "normal" behavior?
> 
> I do not think it should be possible, maybe only if the code where to
> run on the xPL control FDT.
> 

It depends on OTP and MISC symbols being defined, so probably fine. 
Also, we may actually want to have this working in xPL so that U-Boot 
proper/TF-A/OP-TEE gets the appropriate DTB.

> The return 0 is probably just something left from the early code I
> tested where it just printed what should happen. Will check what happen
> if we return an error here and adjust for v2.
> 

Hehe, didn't even notice that one :)

Otherwise, looks ok to me.

Cheers,
Quentin
