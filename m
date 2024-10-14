Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FBBD1812A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 16:09:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27C3088FBD;
	Mon, 14 Oct 2024 18:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="EcDqC13u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DBE489018; Mon, 14 Oct 2024 18:09:55 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44BEC88DE5
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 18:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mN9A7uKodTjf5zRT3VmzZTPmZnoBeyZrmrVpKfilXgwiQH/KUgcGD1kC0J01jdYqYptW0yuHqKKIJAysx0BaZtSQ4B2+fui73EO12BoZRSiFpAfxxc+Db2Npohr5iFPXldKiVYahzQXzDxcg56adDCYSv2tfoxNXEiUgoxyA/y1WqlDK1xflIdrX23LPacZpQDVS3P+eAXUJw0VW/Key0s+HD/QOfbszcrxe7qO2P5Gl/xQ6J9fpoQDmeAFayUlbow6bo0071qDoaXFXTQDy5dHugNWqtdLwtIonMfiRhUlrZgR/jFdIOgV2xeyCD62z3aGio1l0k1VjJV1jujIm8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpFIdc45UBQPudBF+rbGZ2dqcRvnPNmfRDvG/fVZRcg=;
 b=lJQDiiQnr9D6Kb5M9lK62D+M11XRjzJXaqFVzraDKUeYOvPR19cXr9/pYcO81fGjFZTw+SriV8VJVbDEH/n+j9hhyVdlpoHWSvG2UPrl0wuJ0Hcjt7aT86ukMBKiKf8sjzNWGNCnacArZSLIBZ5qO6b7Kbj4Wa/KNC02n/bsMBuuc+jtj/FlHlTnL6wTd9smEpC0EbNmjCj84s6gF+rvUV2lNk/Ga+MswyvzP7LJdiZyvffT0FbNT5pBFSXGkmqA3+l8Um3TxyTyJm09YxWygcUTysB4gdyjM2lSj2Q6A6ysGK/9+HXKxywS9y6aKHSNxfXHGsRQSX1vAA+0MP6JqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpFIdc45UBQPudBF+rbGZ2dqcRvnPNmfRDvG/fVZRcg=;
 b=EcDqC13u1mDkcMwe1M/2pkojLp5z+6niKMGBvpGbNHDtp2O/vUGpOJJK7/bKVAkHxWmUVxqa9nI1j2R/dQWEAGJx15aRCxbz41PwvkPJyMgloTjv4jaFhIWhGQ4S3Laytx0Z7B6sOrFwigEvj7SOIaKVnhJ2eB9u0/MxYSH2gOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9024.eurprd04.prod.outlook.com (2603:10a6:102:20f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 14 Oct
 2024 16:09:50 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 16:09:50 +0000
Message-ID: <5e6139d0-e064-4097-926a-82d2dd374bcf@cherry.de>
Date: Mon, 14 Oct 2024 18:09:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: device that supports both usb host & usb device modes?
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, u-boot@lists.denx.de
References: <up3oe2ackjkjzugqypzcjzmqs4lgktbhn677lorwmztfwqkki6@s4z5orfn5ca7>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <up3oe2ackjkjzugqypzcjzmqs4lgktbhn677lorwmztfwqkki6@s4z5orfn5ca7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: f930cdad-b945-45cc-5f71-08dcec6aa16f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WW1aVm5CNm10Mk5jR3dkb1RkbFR0M240R2lxU1FzQzJRdHllM2JnVkdqLy9x?=
 =?utf-8?B?b3VGdzRQcXFDWDdNZFVlTEVxaWxyUUtadGQ3cm1zc2hoNGtkbUp0djdIU0t3?=
 =?utf-8?B?SzkrTlh3Nm5oRkw0RDFvTFBPSExFcmUwNWVRTGI3WFlSbnNGVXBnS2hSZ05u?=
 =?utf-8?B?Z0NmY1o5TEtuOGQ1YUhVQUg4bFhwUFVINU9La1UvNjFqaG5IYzg4NmdKMjQ0?=
 =?utf-8?B?YkdpWmNwZmRUeXIxbWJyOTJTWDVrSnZqeXF1YzJSblJGRVRaNnlVMDIxQjRv?=
 =?utf-8?B?ZkIzUlpsbnc0ZVlZS0JpRHFsbGFhdi9HTW90V3N1d1lJd2V2d3p2YmZjWTBW?=
 =?utf-8?B?eUtKY0FwT09JQWRFMVl4M0R6TGorNzNlTHp1RDNCVnBub0hXSURGSXFHMk9I?=
 =?utf-8?B?TjJkUkZEUFRUeDd3K29qSU9obUpCK0NMRGpONjBpVEVVRjFCYlA3K0FTelpj?=
 =?utf-8?B?bXBZZFVLd2pYR0tDeTZqb1YrRUpzTkV0N2U5ZW9JbjBvcHFLUkRIdHh5NnFX?=
 =?utf-8?B?c2pDcExCTUx6T1UzaVd6aGNtN3RDSm9oZTRxNzhiaWVzTkRDMjNLS096TjVC?=
 =?utf-8?B?M0d6Q3FxZEl0ak9pQStUemxpWkoxdDUvUjU5N1c5Mi91Z0dJOTdXeVhpZ1ds?=
 =?utf-8?B?bGhCZGlMTjR6N1lvSDdZb3dIajFSbzk0Mkc3VEdiTXNudE1MbzdNRnZJZTFM?=
 =?utf-8?B?ZnJFYjJkVGx0ZzZQM1hXN25NNUt2SzcyM00xWHR1enRIVnFDcThLNkQyUitR?=
 =?utf-8?B?bVBYUEdkcE5DMWtNQXlRaU9yekRSNUlOWUZEaVd6c0M1TktYY3hWZXZEdkxt?=
 =?utf-8?B?bU5CWTM3Q0FsTUlBYnQxSFdySWx0OUZ0VXVpcDVUUmx4dkhMZGVoUzUrMDVi?=
 =?utf-8?B?N3oyclZpNGtrSlFYY3hoVTVWOWZ0aStKZHB6UGRPcXdpUDhRNXp0L1dwbUJP?=
 =?utf-8?B?TFgwNWJDdmtESUFuc0gzTVlDSUVFSlZlUzIwdDVZZkhaTzVlYnY1QjV5dkl4?=
 =?utf-8?B?TDh0dXJpcGdQTmxxMWYxT2FWZXV6MmQzUEYxcGhELy9qeHFobFNjVyt2YlRE?=
 =?utf-8?B?MlU3cVozRlk0YUJKTFlYNjZIODFneXBaSGdXK2NKMEZKb0dVZG41bm85UnVz?=
 =?utf-8?B?M21MT1RCVkZRWjJKUWJTcTBSai9CbjBFOU44N2hVVUxBLzYycWFWdDhUdHV4?=
 =?utf-8?B?dGJ2YkJXT2FObjV3ZVZ5Q0Q0Q0V6YkNxN2tUcGFyMFdldW1ZUE9lZVVDN3lV?=
 =?utf-8?B?NFFEcC8vUDIxaGVKdUhMU016SWkxWGt1d3RzNm5QSWIvQnpoNlVMelFENTd6?=
 =?utf-8?B?aTBRT2lLYUFyaTNBYThEWGNVYWFGcjdoaUF4MUFxTWl4bXVZendRc3JZS3lh?=
 =?utf-8?B?MG56Q0RqR3ZQdHdETURQSTdpeUsySXNqaWtmMm1FWEk5MTNxTGlMdlUzL2Fy?=
 =?utf-8?B?VStBak01TTZjQ1U2RDA2ZHdrWVFkc1RZWjlUT2dWb1o4QmZvdFNyemFRK3o2?=
 =?utf-8?B?WkRieUE1YjB1SmJQWHVkUnVDVHJNOUpXblROZ3JIR25pTlVOQ0pZV1JhRFBO?=
 =?utf-8?B?aTkyc3NsVHZJYU1iSUU5TjJTR1NiM3hBUmI4ZWMxck0rWldiQVFsYjhhbnk3?=
 =?utf-8?B?dkNsdWwxU3lUeXpkMEsrd2RnbTAvWjVCa0dLcjZHTkdVRFVqVytBTnZqRFky?=
 =?utf-8?B?anVIVmszblc5UVd6SkhCUVAzSFN5YXRUbVpkWGFJckZaZHdYRlJjQmJ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDg0OTBPc2E1YTdWM1dlN1FEVFdkRVpJSVpHUDRxaTJGdHVZUVdGWG81YVI2?=
 =?utf-8?B?MjNkVGxUSVBqTVVCU0RJMXJQR1pHOEdFNWRPSHU2Z0hLZU5Bb3k4bFRNdWxN?=
 =?utf-8?B?MFVoNmtBN3pCcWlzcmlPM25jNTB0cmNZTFI1UjJPSlcyNlVNT28zZWdBR3Yv?=
 =?utf-8?B?dlEwbFhYZVJIdy9OcURCY3NMV0cyenk3WXJJYVVDVC9EeTdRUWIzYnlOcllJ?=
 =?utf-8?B?RjBMRlphRndvYkVUSkpVU0hEbnlia1VQcFpsd1lkbkp0dE1Gc29EQlZOQ2wv?=
 =?utf-8?B?UkIwaThkNHVXdStZQktRRUJycFFZNHpOMzVlRTlmYVFGV29lYnN0dmhsbDlI?=
 =?utf-8?B?S0EvaGRUdjloK2R0clZJdU5ZbGVPU281Vit6TGFQRHhGcDlWSTRrcGNmVjAv?=
 =?utf-8?B?NHZVZnVpVjJJMlI5M0pkZ3ovYzZLSG5OYVpnNE1VSnJEcEhQK1ZLM01WUUlW?=
 =?utf-8?B?d3NWRmxsYWJISjJ0YTgxQ2hKOW1tdTJjZW0xM01ObFdNeUU1WUU2ZCtUbFNo?=
 =?utf-8?B?aUo2cEFoVHFXUi9RYU9qVjJwcUdLNnhJOXNhZEExVk1jRnl5aDVPWG9ORXFF?=
 =?utf-8?B?WTFQYmYzcVNVUWJuUER3bjdVbGJrenVWSDBHcjd4ZStJOE9yUXhaZEdIYjRp?=
 =?utf-8?B?WWlZM0QrQldHdTVBK0xZT2dBZDNHY1ZIMUtvK1JwQ0s5QlYrYkFGUUZxdklI?=
 =?utf-8?B?dzV5WWo0ZE1wK2prN3IxS0hWbmhPaG1DQVZGTGJVM2p6Yk5oSGswWFdZRExP?=
 =?utf-8?B?b0MyemRSQzl5elp0b1dpK1huMC92TncweWFYVkRhejFKVFJGZGpHS2pEa0Y3?=
 =?utf-8?B?ZHdaMUZhYS9HMjlKY0VsT1Zxd2VMVzRkQWQ0RHFWSGNRRU9RQUxiQVJ4REVk?=
 =?utf-8?B?bEJ1RGNmcVE1cmo1N1VzQy9LZzdKa0tCazlPNHpoNnRZZVZ3SnM5bkExT1Ar?=
 =?utf-8?B?eStpdFBBSW9jM1g2UDZjbGZ5K0ZhYzJkNWQ2Z28wd08wWGxyWDRZWHNhTmFR?=
 =?utf-8?B?TVQzaDVtbEZiT2I1QTA3T3BGWUJWSXEya1JRTC93MUdXRzFjWm9iNDNTTlpI?=
 =?utf-8?B?cFh2bGd3STluTUljSHdTUEcyNUxVWDVVcEoweWY3RmRTS2NObkQ1QkJqQW5J?=
 =?utf-8?B?WVBhUnN0SU10Unp5YURVcjdWdFFsaGcyM0Mvc2lXZWJ4ZzRVZ2xyNkNyclFO?=
 =?utf-8?B?enlJYmwwOUVMNWx1M3hEQWhzcW9SN0VhWUMyRjR4YTFvVHpPd2dtU1NkczQz?=
 =?utf-8?B?MHVBbkd6UEg5OEJPa1R1TUNGKzBNNUFNRm9UTmRTQU92OE8xZ0xWN0k5UlhG?=
 =?utf-8?B?aGxCQ0svbXJaM0VISWtacEtydXVQRHN3bjg2WEZmc1EvUncvTDFsbVhBUkpB?=
 =?utf-8?B?VmtMQVk2ZFlSODYxNDdVNE1nTU5aSG9kMjg3SFZXeWRDNlVCODBuMmhFd0lG?=
 =?utf-8?B?a3NWSjRwTExDOWg3Y0g0Z3NYY2xVMG9ZVURYMG1MQU1nL09hcnhmb1NEN3Y5?=
 =?utf-8?B?MjdheFFpUWpJN1VXYk1NdWovQ2x5dWtyUjBXblExbHI1bVJDT2w0bG4ya3Rv?=
 =?utf-8?B?R3RCSlFqQXczMXdHa2pGT0V0U3JIbnNXcUIzZTZGSGFUSGRLKzRVc2V2QVpv?=
 =?utf-8?B?VWVZdnYwM0QxUXJzREphTnB6VjVtbjV1UElTMjNaMWpWTkFUandDR0QvMU5H?=
 =?utf-8?B?ZHpZYm9Ea1VkUy9vbDVmbzhuSzN6eDExenU2UWJ5Zm4wYS9vR3RxN1BpWkha?=
 =?utf-8?B?ZlphZ2tQMUYvN2lQK3lRZ2pLMExvUXo2aU5wendWOHJ4c2ltNXA4Z3R6cG9s?=
 =?utf-8?B?UmlyZlVaVm9VMEhMSkVjRDA1TWVRZnhLalJrWjdQaFJ6Z3ZmbC9WNWN6Z2lI?=
 =?utf-8?B?UE9QOGNqUlUzOWZNODc5dFJndlhvMUhRVDVRRVF3bWh1elpTM3BnSzI2b0k1?=
 =?utf-8?B?SXQ5SUEzYnNmZFM0ZjRxVnZ0QllFNXNLbFg2QnB0RW1YZmp2Z0REUzB1WGs0?=
 =?utf-8?B?SSsyWmFLdGZHdFc5RHA5cHNWV25YUmpjZmtyeTVyUjJVZWdycGxwMUdCU3BE?=
 =?utf-8?B?Y3E5S3Rlc0JuVCtHZ1RjS1FZVEd3RHNzWG9iL05CdGRySkZiY05SdFdSV09s?=
 =?utf-8?B?K1UzSnJHYVI5WWY5TzRtbGFHNC9rU3pXL0NodW0xRG9mWFF5L3gzQzUvOUEx?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f930cdad-b945-45cc-5f71-08dcec6aa16f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 16:09:50.0086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2smXU+qgq0ejT9VAzWTh/Ij+SR2xl91Qflcomke3if2kEgFPU/ENTr0PN6ZfzGBu4+z/K7G8MIwYLOdRkDI3moW0GAj4oy5BVF4Dh0Y0tWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9024
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

Hi Marek,

On 10/10/24 9:31 AM, Marek Behún wrote:
> Hi all,
> 
> I am searching for HW that supports both USB host & USB device/gadget
> mode, on the same USB port, capable of switching between these modes
> at runtime.
> 
> Preferably supported in upstream kernel.
> 

I'm doing a very simple test on our (formerly known as Theobroma 
Systems) RK3399 Puma with Haikou devkit and it seems to work fine 
(insert USB stick into microUSB, detect the stick was connected, remove 
USB stick, loop microUSB to USB, configure as ACM, send 
test123test123test one way and then the other) as I have not commented 
out the test for our internal releases :)

I believe that our RK3588 Tiger with Haikou devkit also supports it 
(same test) but I am not the one who upstreamed nor tested that part 
(and it doesn't work on our devices in peripheral mode on Rockchip BSP 
kernel 5.10/6.1).

I don't think we do anything crazy here on the HW level, so I would say 
anything based on RK3399 and RK3588(S) which advertises an USB OTG port 
should be able to work. For RK3588(S) maybe check if it's on USB-C, as I 
am not entirely sure whether we (upstream kernel) support FUSB302 (used 
in the reference design from Rockchip I believe, so most manufacturers 
do use them to limit risks) USB-C connector for OTG just yet (about to 
though if I remember correctly). Maybe have a look on the side of RK356x 
(RK3566/RK3568) as well, I've seen a few with ROCKUSB enabled in U-Boot, 
which means OTG (at least in peripheral mode) is supported in U-Boot.

For reference, this is the test I run:
"""
#!/bin/sh
# Change UDC environment variable according to USB controller connected 
to USB OTG port

set -eu

UDC=${UDC:-"fc000000.usb"}

cleanup_usb_otg() {
	echo "" > "$CONFIGFS_HOME/usb_gadget/q7-usb-p2/UDC"
	rm "$CONFIGFS_HOME/usb_gadget/q7-usb-p2/configs/conf.1/acm.1"
	rmdir "$CONFIGFS_HOME/usb_gadget/q7-usb-p2/configs/conf.1/strings/0x409/"
	rmdir "$CONFIGFS_HOME/usb_gadget/q7-usb-p2/configs/conf.1/"
	rmdir "$CONFIGFS_HOME/usb_gadget/q7-usb-p2/functions/acm.1/"
	rmdir "$CONFIGFS_HOME/usb_gadget/q7-usb-p2/strings/0x409/"
	rmdir "$CONFIGFS_HOME/usb_gadget/q7-usb-p2/"
}

run_cmd() {
	set -x
	"$@"
	set +x
}

test_serial() {
	TX=$1
	RX=$2
	RXPROOF=$(mktemp)
	ORIG=$(mktemp)

	(cat "$RX" > "$RXPROOF")&
	PID=$!

	printf "test123test123test\n" > "$ORIG"
	# NOTE: \r instead of \n
	# The message is sent only if \r or \n is passed, however the receiving
	# end adds an additional newline. Therefore, to check data integrity the
	# last character is different in the reference file and the message
	# being sent.
	printf "test123test123test\r" > "$TX"

	# Give some time for the message to make it to the other side of the
	# communication before killing the process.
	sleep 1

	kill $PID
	wait $PID || true

	diff "$ORIG" "$RXPROOF"

	rm -rf "$ORIG" "$RXPROOF"
}

CONFIGFS_HOME=$(findmnt --noheadings --types configfs -o target)

if [ -z "$CONFIGFS_HOME" ]; then
	CONFIGFS_HOME=$(mktemp --directory)
	run_cmd mount none -t configfs "$CONFIGFS_HOME"
fi

if [ -e "$CONFIGFS_HOME/usb_gadget/q7-usb-p2" ]; then
	set +e
	run_cmd cleanup_usb_otg
	set -e
fi

run_cmd mkdir "$CONFIGFS_HOME/usb_gadget/q7-usb-p2"

run_cmd echo 0xabcd > "$CONFIGFS_HOME/usb_gadget/q7-usb-p2/idVendor"
run_cmd echo 0xef01 > "$CONFIGFS_HOME/usb_gadget/q7-usb-p2/idProduct"
run_cmd mkdir "$CONFIGFS_HOME/usb_gadget/q7-usb-p2/strings/0x409"
run_cmd echo SN1234567890 > 
"$CONFIGFS_HOME/usb_gadget/q7-usb-p2/strings/0x409/serialnumber"
run_cmd echo Theobroma > 
"$CONFIGFS_HOME/usb_gadget/q7-usb-p2/strings/0x409/manufacturer"
run_cmd echo Tiger-Haikou > 
"$CONFIGFS_HOME/usb_gadget/q7-usb-p2/strings/0x409/product"

run_cmd mkdir "$CONFIGFS_HOME/usb_gadget/q7-usb-p2/configs/conf.1/"
run_cmd mkdir 
"$CONFIGFS_HOME/usb_gadget/q7-usb-p2/configs/conf.1/strings/0x409"
run_cmd echo "USB ACM test" > 
"$CONFIGFS_HOME/usb_gadget/q7-usb-p2/configs/conf.1/strings/0x409/configuration"

run_cmd mkdir "$CONFIGFS_HOME/usb_gadget/q7-usb-p2/functions/acm.1"

run_cmd ln -s "$CONFIGFS_HOME/usb_gadget/q7-usb-p2/functions/acm.1" 
"$CONFIGFS_HOME/usb_gadget/q7-usb-p2/configs/conf.1"

run_cmd echo "$UDC" > "$CONFIGFS_HOME/usb_gadget/q7-usb-p2/UDC"

# Give some time for the ACM device to be probed by the kernel
sleep 2

ACM="/dev/ttyACM0"
GS="/dev/ttyGS$(cat 
"$CONFIGFS_HOME/usb_gadget/q7-usb-p2/functions/acm.1/port_num")"

run_cmd test_serial "$ACM" "$GS"
run_cmd test_serial "$GS" "$ACM"
echo "All good!"
"""

Once run, connect a USB stick to the port, it should be detected.

Cheers,
Quentin
