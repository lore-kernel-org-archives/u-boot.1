Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BCECA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 15:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BC9788AD3;
	Mon,  2 Sep 2024 17:27:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="F6+a3Y+e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E163D88B4B; Mon,  2 Sep 2024 17:27:40 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAEA088800
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 17:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVNOB0wryZlwwG8wVoClN5lGdUjwdD+/jxaUATPggLmHSD004QW6BqvWs1xcNsQjHzLvmsohMMqdOCe8RX2usRzhL9Ub6TNJbTdMfnu8bOqw0qc9/x1snloAmAP7faU20wlxyRY9az45MPKe7TgGJlK2CBDN0UcRQdy/eQ2qC+6UoiUEhXhmdeuEpBGEcvJap3Rufa0iBU0MpP8O0YRlq7iiGStnmh0kQekYhjB2cKqLOLLUCmPNZLzol7LYvCpbxvDfGHevtNkIpa5rBrKbA8W/yYZzw9DkgAt219gDXuQWjsJ8ApH1QUxj65Kr0N6tuYAGSZXxA6JMGdjv2WMWvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvM4v7cSwikGS1sf6MKfaWrLP0ADJ0bTkN5L6GsjgtY=;
 b=d2J/+Gc0l2pNN3BDc1bLEyT/JReqO6xyQ4fzR9CJxm/fzWRrliBsML3O0QZTIhrz+ai3ZyIXZq4/TquhYHPQqwtiNpv6wb4hSEUM9rn7T0mfCUR+vGn8fEMmMw0qiM4+E9HfASIoIpBMfaoYdaqogTjUji4WDK1BxTDvYkm1Ivg2Bf1p1KPx91YIWyX/Jr6b1HUjdZtmbZ7Q+jCdu5TqBdHVG7kI+Cm4D/2PdSLJPxszJTXtZGTxHilAu6lN29yH2O3F8o4n+t4TAG2/IIMsnDatTWF0QN+X0XdMSMY2FYLzbd4vNfRPxhArVq9jzunk2ICYfqvfcE6mFBH/3LLPfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvM4v7cSwikGS1sf6MKfaWrLP0ADJ0bTkN5L6GsjgtY=;
 b=F6+a3Y+ebVgSrn3njQzGqSFGfelS/eHWyzdxGJewUyDUp4q4STFq/vNqrEGsWVPSzLZwH3/ybS3VO7pS+ZJpJzAlJ7iJ+Z+lG1W6Hf0rC7IR4P5bMgp4bOCuNQqjPRzqPlb7QpGe4TNL6lElt14HM1IhYIFDAQPkdkTJgC+Rvdo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB8647.eurprd04.prod.outlook.com (2603:10a6:10:2de::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Mon, 2 Sep
 2024 15:27:36 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 15:27:35 +0000
Message-ID: <c28e18cd-d79c-48a4-b46b-a7e769b1174b@cherry.de>
Date: Mon, 2 Sep 2024 17:27:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ram: rockchip: Kconfig: Fix dependency of
 RAM_ROCKCHIP_DEBUG
To: =?UTF-8?Q?=C5=81ukasz_Czechowski?= <lukasz.czechowski@thaumatec.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com
References: <20240827142058.594556-1-lukasz.czechowski@thaumatec.com>
 <20240827142058.594556-3-lukasz.czechowski@thaumatec.com>
 <3c9b636d-2184-42dc-9604-cebe2535f11d@cherry.de>
 <CABd623tpMOoRNXU07LLsvVnyEetLGjhvcQgKMLCp8DO8XutDQQ@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CABd623tpMOoRNXU07LLsvVnyEetLGjhvcQgKMLCp8DO8XutDQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: 8819cda1-0c61-41ea-531d-08dccb63c591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXV6UmVjbjVYQXI4a1JUZ29UeWhvL2txdG82SVBIMGxvZ2xMazNPckdNYUJy?=
 =?utf-8?B?T0pXaWFjMXRyRWgram1NcS9vc0FDU09xV1RQVW9Jc09KTUg0NWVzTTFpZVhN?=
 =?utf-8?B?TDk5V1BVUHhVTGpJaXlOOE5KT29Da0JkQ1NQVkpqblhLbEE3TGRCZnlVUHIy?=
 =?utf-8?B?Q1dleUtJelRsZVV6OUpIM3YwMVlnRFpEcXAwS3RiMmpJSGRnOXMxSkRFbUpF?=
 =?utf-8?B?RXJrR0t5d0EzTDhRR2xaL0M1T2t5eElZMHlBUDRhc3lQNEErcDhDU3RESEQ4?=
 =?utf-8?B?QlM1OEVmZE5pRFZ6NjV2RDdJRDdJUHl2bm04b0RROFR0ekZyRkRWem4vdFZY?=
 =?utf-8?B?R1ZyWVBIREh3dEJJWDlrSnJuc01QYmxkTFQwbzcwbC9MNG5mRHRmazJUV1pr?=
 =?utf-8?B?TFFCU3Ird0pnYWFUbnBzblg0WWx6bFJvZEN0aWkxVGVub0F3VWZFSTZQTGpV?=
 =?utf-8?B?WHVXc2hOaWh5UnBHSlJocU10dGdnSWNYaWtnbG9wSU1OMFZYb0R2MVRJTkQx?=
 =?utf-8?B?NWZjbFZnaU9uL054YTkxb3c2YXdaVllFdnpGVElyQlExcjhWek5PMjYyd0cv?=
 =?utf-8?B?cmJGa2Z3amRQK1RvZ2NiWnFIOHRXV3NsekV4SGpGZnR5QWdUeXIweDdzUHQz?=
 =?utf-8?B?QWdieW94Q3ppYVhDVlpPMHIzRGc3MXlIUU1MSkFuZjE0bzBFWitkdG1UNVZ2?=
 =?utf-8?B?WXUyRURhU015ZWJ2VTNIWUtLb00xRHNHb21MZ1JzRWl5Z0d6VEtuZEtKK1VZ?=
 =?utf-8?B?VDl1V056NEFVbWZZMytQTmppc29nT3VoUWRBNDhRdjNFRWtpMG9uaFRxUjhw?=
 =?utf-8?B?VFFkM3hCZXhOdVlBVTVIUDQ4cDlxcTNPYW5aODlVNUsxSGRvV1NsaEhkcU1j?=
 =?utf-8?B?ZWM0cGs4QmdwMWNpYUtsd3hEeUVJRzVKSmU5YkdRb09mTXNCL2Rnd2t1K0tj?=
 =?utf-8?B?dnFiTzU2UHRRU0hHak5sQnJHL1E1UEpRZGlxTFRSa1FjcnQvM2Vsa2VmS3A2?=
 =?utf-8?B?ZXEzaC9rMnpmQ290RkwyMExJQXI2eExBQndTZGtVSjZyVEs5Q0tua2lUaGpT?=
 =?utf-8?B?eUpFWURVM0NXcTV3VFlqaGpiUzNKdWs1bkxQN3FQa3AzTVEvZnB1WDB1RVVF?=
 =?utf-8?B?WXRoeDI1dmdjVnVMMVo0L2hXTHl6Tlhiby91VHI4dG9adnN1VXlFL2REeWI3?=
 =?utf-8?B?aW9vRHdVNlFtbHFXaVJjNDJHQ2w3N2VveTk3djNQNHpIWVJEa2FIWVhsVytS?=
 =?utf-8?B?QVFrOFcrVUtxNmp1TFArYkNjT1g0R0hpUnJRQmZpY3BERVpPTElCR2tGZFM0?=
 =?utf-8?B?VXNlckxDYUErYWpsdHRHK3dKNUtGaU52UEswMXlGMWxWZUpwdGxiT25Way8w?=
 =?utf-8?B?dDlsN0taMnU2VTVZY2R3M3ZwaGV3Y3hTVkFJeHEvb2Q2emErdGVlVW5ZTGZZ?=
 =?utf-8?B?MEMwUDIxVjl1ZWdnNEE4RWFpSkludHhCT0JNbFZ6TkZEVVVRcHZkUDA0VzlK?=
 =?utf-8?B?aGxlaWRlQVF1MUFRNFMrOEpPVUtoVFpRVXNpZFhBMkdBbU1CellsTmdtdlBV?=
 =?utf-8?B?MEtMVy9hbVFHS3dYK2VPb2ZNYlZmWVRybXpPbC82VElIRDUxbUdjQ3k0ckN0?=
 =?utf-8?B?amdnOGtIZ0ZwbjJDUEliK3ZFZW12Z3kyc0lqMFNCU1h5bGl2cE5SNTBONnZQ?=
 =?utf-8?B?UGhRdHQxazFYVnZKYjB5MVVhUkE1VGVrakVmRnhwMk13Nm9FcnZuK1RseHFU?=
 =?utf-8?B?WnJLNlE0U1lEQlBSanV4SDFvOHI0Vm1Gek9saE5UUWFVMFZnTnJUREdJdERj?=
 =?utf-8?B?dEdldXIrem9UcjZ2R3VzQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjE4bmFjK2lsZXcyZzBGVkxkQnZjdzlCb051WmdnTWZnRXVRVk5WNVBKaUNO?=
 =?utf-8?B?eUJvdStVRUhaRTZIYzJVSlM0cDhXWW92T0tQWE9HQ2pXb0FiRjlPM0hpMXVq?=
 =?utf-8?B?Y3BLTDltbzFPU0NoYnJmZko1dUFPT05Xd3RFRkl4WDVwOWZUT2N0U1BVN1RC?=
 =?utf-8?B?RU45MVJjaEYvRXA5ZmpVNU85K0N1bHgxU1k2cTBRbWF5ZWhVbCt4M2NCWW1N?=
 =?utf-8?B?Z0J4ckVYUkp0RWNVNlpHNjVsWDRJNHhEbzREcVgza2JsaldDWHY4Uk1Gam8r?=
 =?utf-8?B?TUFzNVJpSytudkFITGVDM2dTUDN6TitLTmlyNlVYSGVnNmlsbEgvcnhFeVZi?=
 =?utf-8?B?L0llSGxidmYvL2I3UEt5YkpGOWs0OEhSZjM3QlpVdkcybWZRTU1DRDdzRzhY?=
 =?utf-8?B?dzY1VDdCVGJ3UUZTWmRtR3dTbE85T3lqVU5VMi9LMC91ejRkNDhxUWhzTlJq?=
 =?utf-8?B?cWRXWVBLeHRTdmxXK1g4WnBFeXJ3Tk1FNFJrY1pGakdCZ0RQZ0VPQ05ndzAy?=
 =?utf-8?B?NC9waGRRUTlib2RYa21Rb3RaRTUwTUtEc0tscytyQXcxYXkwZjh6dU9DaXlH?=
 =?utf-8?B?MjdJQWcreEhRKys0WnVOMlk0S0FDT2dqNWppRjVLR3JaMUgydTVDZkdMVUxx?=
 =?utf-8?B?WGc4T3JUY3plY1hUTDd2cFVHNmFqMUtuSjJQcnc3NTdJdnMvNks1ZFVldjJi?=
 =?utf-8?B?ZktqQnRiclJDUlUxU3BueWIxdXlXS2dZMWVHcnYrd0h1T3RTZ0EzcVNHQnJw?=
 =?utf-8?B?UlVENWVYRTFJd0MzVVgwSFBnNmRlNU1DVTY0RXQwMFNuaWoydG5idjloYldV?=
 =?utf-8?B?MU1CcTVjcElvN1hYVlFlajN2cDErTGpPM2dYbHVwZXZKbW9vN3g2NHZTejJD?=
 =?utf-8?B?UitXYzF6d0x3VzV1MGpDbTRIc25ERE5tODVXR045d01xZnMwbGxoak52RHVP?=
 =?utf-8?B?UHRuWGtjZ3FvQWx5eWZ3eURGcytKNitzSG9aNG1KRUJDMDE4Tlp2S1JlTGtt?=
 =?utf-8?B?bmdKVUlUbXhuR2xFb3pXdWlFSFVSbGtsNnRFL2JSa2Uyc1RUV2dKVVZIQ3NZ?=
 =?utf-8?B?NjlsbktuQ1MydHNYUTJtVzJMOExIRjV3L0pvNk1mdDhqSk4zdE9oUzd1Z3dL?=
 =?utf-8?B?cjMxcUprRXl0cEJyamZXajRwVW9LYkQ5WU9ONkRHTnVtSE9GcGMxSnZHWG8x?=
 =?utf-8?B?ejY0cm1TcHdua2NFV2R4bGF3ekFlb0xJYnNwSEMzU3RBYjQyNUora25uOE90?=
 =?utf-8?B?ZlN1aUIxelF4UnNXZ0szd25iclFzYUtGUXNEUTlJbmJITjM2ZFU0cGE0RGRM?=
 =?utf-8?B?a21XTzE5WStySmlVb3FNWEorTnBaTERONGttYlM2MFhwNGJYb0FGd3JyVWFi?=
 =?utf-8?B?TnRwQkg0Q1pWdE1Ga29oZm14UE5uWDZJMWgrdHd3TGthQUxpR3Z3dUxpcjJY?=
 =?utf-8?B?SU5nT0xXaTB0SW1YM2tPYzROamw2Z2V5T0I3dDBCMFNvUHRXdGlick93bmI2?=
 =?utf-8?B?MkdjQ3FtTFlLOFBYZFFNWFRhd2w1RVZ5eW1aa1BnTVNnL1pYZFZrUkpkUnpm?=
 =?utf-8?B?VHJETm5kUUpMeE0xanNONUhnR1g2OWtTNTJPZEZqdkFSS01CVVQrYTNCOFpR?=
 =?utf-8?B?WEZxZDlHc3hCTDliNDh2UnRXZTJrTm5yVVYxRzY2eWorVGVIOU9UUEY3U1ND?=
 =?utf-8?B?aFcrdW83dDJJWDluNTlTTGtHRzhDVWJ4Qi9oZlQrU1A5ZE0wZXFOM0JXVzd6?=
 =?utf-8?B?K0VWNXZaRU43M2ZOYnhxclVpS2FZNTlrSmIxNzZiSnBzL05OSllmRTNCZUg1?=
 =?utf-8?B?MUZ0VTJDZTl2ZGtrNE9ESFdpYXNTVmtkaDhYY1RNcCtYbEg5c2N2VGRDNDRk?=
 =?utf-8?B?Y3l3VW1VaXlDeFFialQvRVlKbERyWFYzM0tmUVZlUXhKQzlpckp4c0hpTEpn?=
 =?utf-8?B?VW5zWUtlZk1KMGRtS1VHRGQzb2ZHVUZOWDNEZEVscWUyeDM0VTFtMTVYOWNj?=
 =?utf-8?B?WEZ6QlZGSk12RFBZdkgrRGp3R004aW5RWlZSZ3d6NVhOcW9NT2dNZndza2d0?=
 =?utf-8?B?VExTQjJWUTVoRmh2bG9sNmNWZEtBUllYaVlUZVlyTkVzV2pUdnk0SSt1aVhU?=
 =?utf-8?B?bVBPV1crTmRCYnV1ZktQMlJtdVRTd29ucjc5WW5YZ2FCbWl3bTd6WG5iR0dF?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8819cda1-0c61-41ea-531d-08dccb63c591
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 15:27:35.7637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikCiy01mV4edJKqPDjQeKCj71wfvDZ7O2HJ7jQqKB4U9dpq2CFa8ygpvTqbBEHLccaLV5E7OVtcxMGMmYklGGRP5dep0pxDmnwla2kbAFW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8647
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

Hi Lukasz,

On 9/2/24 4:57 PM, Łukasz Czechowski wrote:
> Hi Quentin,
> 
> Fair point. Unfortunately the syntax "depends on <symbol> if <expr>"
> seem to be not supported in Kconfig

Shoot, it's the ONLY Kconfig attribute that doesn't support if :)

> I can do something like
> 
> depends on !TPL_SILENT_CONSOLE && TPL_RAM || !SPL_SILENT_CONSOLE && SPL_RAM
> 
> instead. What do you think?
> 

Mmmm no, that wouldn't work I think.

E.g. this would allow RAM_ROCKCHIP_DEBUG to be enabled in TPL even if 
TPL_SILENT_CONSOLE is enabled, if SPL_RAM=y and SPL_SILENT_CONSOLE=n.

I think we have two options:
1) depends on (!SPL_SILENT_CONSOLE && SPL_RAM) || !SPL_RAM
depends on (!TPL_SILENT_CONSOLE && TPL_RAM) || !TPL_RAM

This means RAM_ROCKCHIP_DEBUG would be selectable for RAM=y, TPL_RAM=n, 
SPL_RAM=n. I don't think anyone would want TPL_RAM AND SPL_RAM set at 
the same time, so having SPL_SILENT_CONSOLE set but not 
TPL_SILENT_CONSOLE wouldn't be an issue here.

2) Create an SPL and TPL symbol for RAM_ROCKCHIP_DEBUG, i.e. 
SPL_RAM_ROCKCHIP_DEBUG and TPL_RAM_ROCKCHIP_DEBUG.

This is a bit more involved in terms of changes but is closer to how 
U-Boot works when SPL/TPL is involved. We basically would need to change
IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG) into 
CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG) and #ifdef 
CONFIG_RAM_ROCKCHIP_DEBUG into #if CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG).

I assume we would want those new symbols to default to y too. If that's 
the case, then we need to manually disable those symbols in defconfigs 
that disable RAM_ROCMCHIP_DEBUG right now:
configs/anbernic-rgxx3-rk3566_defconfig
configs/neu2-io-rv1126_defconfig
configs/roc-pc-mezzanine-rk3399_defconfig
configs/roc-pc-rk3399_defconfig
configs/rock-pi-n10-rk3399pro_defconfig
configs/rock-pi-n8-rk3288_defconfig
configs/sonoff-ihost-rv1126_defconfig

Cheers,
Quentin
