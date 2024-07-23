Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B55C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 14:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A8A288204;
	Tue, 23 Jul 2024 16:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="kzjFmm37";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DD4288840; Tue, 23 Jul 2024 16:18:19 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4A628811C
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 16:18:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t26D0wNsWAcJLSAJn13+hw6fIa1MJNQ9a398HOX+OOyfa8ogeT77Tj9kH6OeZrYPipU1MsAzA+hzaMEoQw5QSkloYT0olqRh/ppijjHYx+XBDeqOktSs0w8Lns4UJVMIURHMGtSTElylPjGfLsL/GjYlPg/OOjDxbVGNuXs8Ih0FxhKE6pkK8DX8Bej0u2UO19UgkcDLkBIZWqtOQpTuHfznQTdPuLP0JQg+CzeERZMlUJIIgxDrHZqCTwd5CH4qSsp1+LQZZQ9z1RNLQ2xCObtPaRYvfGkLP//Sjq1b3NaIEvxpgWnv0zaczBtg9j9zyi39033Eiuax6g06ZW43jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IHOcAnczYXSSlHtI70mOlrnSCKKUbT7vPl0G7/oTuU=;
 b=jLNugMuqqm7abFJCE2yEMsh+pX3BVuJR8cPsttAjwVojGdK1qAXN7mKq9EsO45FdXmk+dcen1zcQ0T1rRIvtSYm36P+SQtsDv6WpY/EYFFdfs1YXxRznw6Xg47k5ORUIvRghZwZ509E4CLH41l74s2fZreZqWa4IT0+7xnNCvexB0ufOZ1GIsyfevq/ezT6DKqq/GjIgm3iV7BoObrFwMNS3Ie3+It3YAqMk6SvqzcQNkTR0jLuIb0dzmwPBLgNpy/uZmF5CYf9kzlPmnRoVxJIDbsV21xhViOF8YY/qhiMRg1FRq3GzrpxCN91m3wPt2GhgiE392Fzt0VYKK5KUSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IHOcAnczYXSSlHtI70mOlrnSCKKUbT7vPl0G7/oTuU=;
 b=kzjFmm37se45a1Ma8z23UogerpCS9tco74mizubrC5j/GxIUcCmI5PezcEosbFTl4Wmxz88qNKf//C7ReQDR9pUQlih9ft3l5m6jfM9GrGzv/4q9fcv0nCxH1YlrSPnIeX2O1qmuBAbPUi980RzrmxHju7I5eQOou98WIxV629E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PA1PR04MB10228.eurprd04.prod.outlook.com (2603:10a6:102:454::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Tue, 23 Jul
 2024 14:18:08 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 14:18:08 +0000
Message-ID: <cd6247f7-af44-4a95-b5c3-57365ab40c90@cherry.de>
Date: Tue, 23 Jul 2024 16:18:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools: Add script to update git subtree projects
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sumit.garg@linaro.org, jerome.forissier@linaro.org, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240722193052.57592-1-raymond.mao@linaro.org>
 <c68ab077-063c-49f0-b345-dffe4db28bb2@cherry.de>
 <CAEfUkUJrDi2MTBbB8hLn6jBv7uXs5__0m=-28J+ZfjGkPDmChw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAEfUkUJrDi2MTBbB8hLn6jBv7uXs5__0m=-28J+ZfjGkPDmChw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0243.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::8) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PA1PR04MB10228:EE_
X-MS-Office365-Filtering-Correlation-Id: 683486c5-241a-47df-7357-08dcab2246c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bitsTmZUVjNCazFQZENMSW5RVGVBbFZUMitjVnBvZGlCUjdBSmhiV21DNWpW?=
 =?utf-8?B?bVhzTTVxeThrdGtTS1YrS2lXL0YrS1VZbHIvNHFXQndQUmpPM1B4QU54djhy?=
 =?utf-8?B?RlVycXVBa1htM0c1UUQrTGtvM28waFZsRzQ0UU80VCtPMFNobUxmQUxVUlNB?=
 =?utf-8?B?M1YwMU1uYWJYT1JLZW5sN3NxRWpsOXJjY3oyaEdEMnRFaVhSYmV4aFdjRWZX?=
 =?utf-8?B?TWZFZnI0ekVid0tyeTUwdHNDYko5QTZmKzNnY3dsdEhaK0ZIeUlON2gwcVZr?=
 =?utf-8?B?c0dTa1VrUWxYOHlYRUtsdmNKbUt1Tit4c1ErTFFiYlFKb3NrTnVrcC9aQ05X?=
 =?utf-8?B?cEFqZVJjRHUyS2sxaHdWMXh3aFA3ZHNGU0k4clZnMWZkenpqSFlMc0sydCtS?=
 =?utf-8?B?V1ArbkEzRWZWOGovWTluckNKV0Y0WFJaTTFqZ2V6bGxXTlE3MldZcGhuc3hC?=
 =?utf-8?B?ZEpwZHp0bzF1WmNxK1VZS0xZbnU0bzB5ZzE5Z3NmbFRPaUMveHNZb1BlU1lL?=
 =?utf-8?B?NXdBaUdRc2pGcGlFK0puaytoY1psTXFMZDlnTE5QeXZTVVZpeE03YVk2TXBR?=
 =?utf-8?B?U25QZTY4cWN2ZlFrYlJWRE03OHNhVzdhd25iU3RVODgrTlVpSkdGdXQvOTdi?=
 =?utf-8?B?MVVLZjA3cjFDY0gwUVNad0JiU0hoNW9xcFhydTN4UDlLUVA0bUJxemZNa2xz?=
 =?utf-8?B?MUNBTDlMMmd6b1dSVlY3TWFtUmhHSFNJbE1zSHpKUjAxTTZPTGE5elVxUUM1?=
 =?utf-8?B?MWhaTzdWWVVSQ1p5OGpyQWtRd2ZadGc5dEpPak1aZm81YnBPNS9Jd0p0cGp4?=
 =?utf-8?B?Q2IwRG9Hb1ZhYllUVG9rcUFuOENYTllMWENVV0xXK09KVFIwMk80N3dEWDZB?=
 =?utf-8?B?V0p0T3pETytqYnVwQnIxekNkWi92N0ZTS0MyM1owK3hnb2Z5aXlFNSt5ZkxD?=
 =?utf-8?B?UmtvWkdia0w2bFAzWitPRDdCVEV4SHJVaXpaeFY1Z0NVRWUvQk1sSnpJN0k3?=
 =?utf-8?B?VXpnVUN4SUtRRVNhN2Z5UkVWK2ZyRU9ia0crV2lETmM0bWswaHR1enBxMm95?=
 =?utf-8?B?d2VOdkhoV2lNZjZvSWdPaU0xaHBMcTduM01UbTVZbzAvclVOUVc1enlseHdX?=
 =?utf-8?B?Y25VZWJBNnJEdy9ic0ZmejUxY3U2akFSK3RiUjQ3UDJMSUl5enhiWkZKT0tz?=
 =?utf-8?B?Y1hUQW1UUmtDajlueitvbzUrS2hVQmUvMzVockJCeHQ5cUUwazFhN1Yrc0NH?=
 =?utf-8?B?QkVOalBTY3hZL1ExdFMwaW9CMTZ6Y2c5eUwwYWdhSnJ3eWhpclQwblJRVzIv?=
 =?utf-8?B?M2RJL0VwTXM3Wjl1UERkQXdOTFJVMXhiS2EwWmN6T1NQZjY3alg5eHRaeHpq?=
 =?utf-8?B?SE43TDFMT2JEblNwNHFsbDVFRTdzY0tZM0VweEZubEwwRHhiM1pkcnhTWUJZ?=
 =?utf-8?B?ZTFlQ2hUcWxkMDFlU1NvUEtWME5IUWlrZDJVWUdQNDhsSHJaR3Fmbjk2aW1I?=
 =?utf-8?B?cFdHbTFaVlJGOHRma0k3akwrSVp2NDBwM0pMWXN6SzZOdjNRWW5rb2ltVE5v?=
 =?utf-8?B?SG9OcTdiUDE2cWdBbW1aeUF0eFZkY3JRQk5sT3hCSGRxeTRPbzVES2xCMENC?=
 =?utf-8?B?ekNxNWlMd3o1QUFiZytFK1JXLzdGUitEajllL2hibWhCUVZKcHRHZ0tPNzA5?=
 =?utf-8?B?VHJkVUZ0Q05DM3h2ZEZkWERHUTEwN0JCaURDWlUvanYycnl0UnB4blc2UmEw?=
 =?utf-8?Q?vDuIRcrGGoZJ/XLM70=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWM2OWhJL0NCVUxGa2tTVm44NnJJT2FSQnY5V1hQM245cENkRTRyWlVxNGQ1?=
 =?utf-8?B?NUtmMitxamNObGplQ2VkTlBiZTJBNGgrNTNJc250VFFmMWZRWWlLdG9iRmFr?=
 =?utf-8?B?YjZ6SjA4dWV4L0pQbitoMEFlWnFHWHlzMHNoK1JYaHQ2VWVMN1ZUVlB5Q01U?=
 =?utf-8?B?cUc4SXQ0TmYrcnpRdE8zbjE5aTkzRE1pT3g4OW1DaWJQM0I1WDVLRkFrSU5I?=
 =?utf-8?B?N3dHdS9Lc056YTFvdXJmL2V3VGw0VHUvM0xUaVBxRkV0dWFYcDFaRk1ySkZu?=
 =?utf-8?B?RjhLTXgwc1MxSDNIVWJZdW9Sam5OOGI0R3dxR2RHYXBnT2RoQWFQRVJNN3d4?=
 =?utf-8?B?NmkvSnNtRG5TK1p4bG05OGNjclVHMFNYaXBZVFZjdVU0bVg0d2M4aVJvd1J0?=
 =?utf-8?B?TnZDWStldlowQjZxYlNNajFJdXRLRDRYYSt1dDZjUzU4UXlsR0VBSU9zaFhW?=
 =?utf-8?B?UU5xOE53MjBxSHJySEdPbDhQWS9ncGJsa1Zva1diUjZCUjJadkFqWmR4Mk5r?=
 =?utf-8?B?SGdyT1VGOWNyMFdFVG9PVTN3NzJJNS9wUFh5bzM3eklpQmp1RFBRWTQ1Y1U1?=
 =?utf-8?B?VGp6TTBJNWRCKzN4MFkvTmJHcDVtUmRreTU4SWpDcm50SzFrZHBDNHNGK2gv?=
 =?utf-8?B?aFZWemtCaG9xRFZQWUY0cFNOanhDRkRUbXF5eVFnWFBRa0JsbTlYRXJpd0VZ?=
 =?utf-8?B?ZXMvK0M4ZHVzb0JHTnJrUFVxUUlZOEphS2dPbUQrWVIvYUdsb01xUmo0aGo2?=
 =?utf-8?B?a2xpOGFCTERuT0cxZ0RRNUFaWENrOHVOVHJBSlg3MzM3WkVKZnMvaW1oS1NS?=
 =?utf-8?B?TTl2UDg3VEIvaXNNT2NNSzhQNzBWWHVHd1d1anA3cnB2d1ViMXdDTDhaTjBS?=
 =?utf-8?B?N3IwWkhLUUFkeVV0KzRIbzdZN3BQcHZ4SG8ra2p4bmJPeVpPR1BUMlpSdGpC?=
 =?utf-8?B?cDhlalBPS0drY1ZxVU5lc2laMU9BMmhWU2ZLUkVZTXpBNVVLUy91c0JEL1VD?=
 =?utf-8?B?VHFsUzR6Sk52eFl4QytyVkY2T3cyTTFtVG1reTBBTFIwdlIvK2xNTmkyL1Qy?=
 =?utf-8?B?Wk1KbSswcC96QjZSMVdUR2FZWWdpejRFay9zNUsrUkRnNFV2YmR6ZkFiNEVJ?=
 =?utf-8?B?S0JNRUVzMVIxdENqVTc0eFpERWNZek9hQlRkai9NODN3ZjhZa2NqczFJYzY2?=
 =?utf-8?B?emx0L1NWdDJjQmR0QzV1a04vQklCTmg4Z29rSmpCWTJjU1dVVVpkMnNaV2R3?=
 =?utf-8?B?TmJrS29uUWFhak85YUZnYTdQRWE4SXZIdlFTaG1iZGlSdzR6V0l2RFlJSGNT?=
 =?utf-8?B?Nk01eW1UQy82cFo3UVhNdnluZWE3RWcyYUFZNmJ6TGxKbytmSkFWSmJMVG5p?=
 =?utf-8?B?M3I5QjJiVGpzRHFuUTFWc295MmJidlVSbVgvY2RDRnJkRDlEQjdrUEhEYngr?=
 =?utf-8?B?QUFLTHZRM2FMY0dpQkh3S0lWNlhGNlJERUtIaVlZUm1wRU0rbnJXT1RRbFVX?=
 =?utf-8?B?L2g5amNuaVhyOFk5VmVUZ0pxWXozMkdTdFlGOWZaanBYczJKMUh3STdWdGdM?=
 =?utf-8?B?cHFJYVFRVm4wZzlFNVlWbVBEYzQ2bVhLb2xQNkhKWkRWUU5NaFYvNnRZVjVx?=
 =?utf-8?B?YWRoY05XRWpQeVNUQ2R4eE45YmRNODAzR3V0STNqWmk1NTE3cTNkQThrR3Vk?=
 =?utf-8?B?cWxwR0JhS05pdlZnSW1mWncyOHZZWHRzTmNJTmQzMm04ajM0QithdnpQeWYy?=
 =?utf-8?B?ZVZVbDhYN3VLcU1zdUx0V1JWY09LdzF1TkNCMmdBd0N1MXMvRjBSSGxOT09h?=
 =?utf-8?B?OXB2ekgvQklQcy9UWW03SWxHR2EzTzQxNnVBOVRHQ2pkaUdpR01GQUFoU2N1?=
 =?utf-8?B?ZHlVWkxaY3V4U2FLZ25ORE5teVBmZkQ4Q1YvYTQxYWJpMnR5M1JxeUZOTzdF?=
 =?utf-8?B?N0VwNTdlb0NwK1NjajVJbVFtZWp1dExNc0pHUi9FR05uWkRWdUVnL05JQVhx?=
 =?utf-8?B?bXRrTmhMaGFsenhBeTlVQjJlMEJPcThQbHVTZzZDQks3bllOZ1FFMFpmTkh2?=
 =?utf-8?B?RFVRZEFEV1B4RXJpb09qUG11VEVRWVVPOG1FMUtsWkVkWlF0aWZCVHMrVVpz?=
 =?utf-8?B?ZG5MdHdKQlhYa0hkblE1NWtFV2pYdGhOc09aQVYwaEYwdVQvSWRBWWRwSndF?=
 =?utf-8?B?Wmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 683486c5-241a-47df-7357-08dcab2246c1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 14:18:08.5324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czgUomEZJ71pCbBfJHa+Oc89Ro8HO6vz8o49DcDN7EQEXmJbf7T79E2RuUDismh30clNwve52adMORHGAAaZd2wD7crZtigZTnUuLBiSNWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10228
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

Hi Raymond,

On 7/23/24 4:05 PM, Raymond Mao wrote:
> Hi Quentin,
> 
> On Tue, 23 Jul 2024 at 03:16, Quentin Schulz <quentin.schulz@cherry.de>
> wrote:
> 
>> Hi Raymond,
>>
>> On 7/22/24 9:30 PM, Raymond Mao wrote:
>>> Recently we are introducing multiple git subtree projects and
>>> it is the right time to have a universal script to update
>>> various subtrees and replace the dts/update-dts-subtree.sh.
>>>
>>> update-subtree.sh is a wrapper of git subtree commands.
>>>
>>> Usage: From U-Boot top directory,
>>> run
>>> $ ./tools/update-subtree.sh pull <subtree-name> <release-tag>
>>> for pulling a tag from the upstream.
>>> Or run
>>> $ ./tools/update-subtree.sh pick <subtree-name> <commit-id>
>>> for cherry-pick a commit from the upstream.
>>>
>>> Currently <subtree-name> supports dts, mbedtls and lwip.
>>>
>>> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>>> ---
>>> Changes in v2
>>> - Refactored the script.
>>> - Update the control doc.
>>>
>>>    doc/develop/devicetree/control.rst |  8 +--
>>>    dts/update-dts-subtree.sh          | 48 -----------------
>>>    tools/update-subtree.sh            | 86 ++++++++++++++++++++++++++++++
>>>    3 files changed, 90 insertions(+), 52 deletions(-)
>>>    delete mode 100755 dts/update-dts-subtree.sh
>>>    create mode 100755 tools/update-subtree.sh
>>>
>>> diff --git a/doc/develop/devicetree/control.rst
>> b/doc/develop/devicetree/control.rst
>>> index ca4fb0b5b10..211f7e4909c 100644
>>> --- a/doc/develop/devicetree/control.rst
>>> +++ b/doc/develop/devicetree/control.rst
>>> @@ -96,12 +96,12 @@ sync the `dts/upstream/` subtree from the
>> devicetree-rebasing repo whenever
>>>    the next branch opens (refer: :doc:`../release_cycle`) with the latest
>> mainline
>>>    Linux kernel release. To sync the `dts/upstream/` subtree, run::
>>>
>>> -    ./dts/update-dts-subtree.sh pull <devicetree-rebasing-release-tag>
>>> +    ./tools/update-subtree.sh pull dts <devicetree-rebasing-release-tag>
>>>
>>>    If required it is also possible to cherry-pick fixes from the
>>>    devicetree-rebasing repository prior to next sync, usage::
>>>
>>> -    ./dts/update-dts-subtree.sh pick <devicetree-rebasing-commit-id>
>>> +    ./tools/update-subtree.sh pick dts <devicetree-rebasing-commit-id>
>>>
>>>
>>>    Configuration
>>> @@ -116,8 +116,8 @@ However, if `dts/upstream/` hasn't yet received
>> devicetree source file for your
>>>    newly added board support then one option is that you can add the
>> corresponding
>>>    devicetree source file as `arch/<arch>/dts/<name>.dts`. To select that
>> add `#
>>>    CONFIG_OF_UPSTREAM is not set` and set `DEFAULT_DEVICE_TREE=<name>`
>> when
>>> -prompted by Kconfig. Another option is that you can use use the "pick"
>> option of
>>> -`dts/update-dts-subtree.sh` mentioned above to bring in the commits
>> that you
>>> +prompted by Kconfig. Another option is that you can use the "pick"
>> option of
>>> +`tools/update-subtree.sh` mentioned above to bring in the commits that
>> you
>>>    need.
>>>
>>>    This should include your CPU or SoC's devicetree file. On top of that
>> any U-Boot
>>> diff --git a/dts/update-dts-subtree.sh b/dts/update-dts-subtree.sh
>>> deleted file mode 100755
>>> index a57b78a41d3..00000000000
>>> --- a/dts/update-dts-subtree.sh
>>> +++ /dev/null
>>> @@ -1,48 +0,0 @@
>>> -#!/bin/sh
>>> -# SPDX-License-Identifier: GPL-2.0+
>>> -#
>>> -# Copyright 2024 Linaro Ltd.
>>> -#
>>> -# Usage: from the top level U-Boot source tree, run:
>>> -# $ ./dts/update-dts-subtree.sh pull <release-tag>
>>> -# $ ./dts/update-dts-subtree.sh pick <commit-id>
>>> -#
>>> -# The script will pull changes from devicetree-rebasing repo into U-Boot
>>> -# as a subtree located as <U-Boot>/dts/upstream sub-directory. It will
>>> -# automatically create a squash/merge commit listing the commits
>> imported.
>>> -
>>> -set -e
>>> -
>>> -merge_commit_msg=$(cat << EOF
>>> -Subtree merge tag '$2' of devicetree-rebasing repo [1] into dts/upstream
>>> -
>>> -[1]
>> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
>>> -EOF
>>> -)
>>> -
>>> -remote_add_and_fetch() {
>>> -    if ! git remote get-url devicetree-rebasing 2>/dev/null
>>> -    then
>>> -        echo "Warning: Script automatically adds new git remote via:"
>>> -        echo "    git remote add devicetree-rebasing \\"
>>> -        echo "
>> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
>> "
>>> -        git remote add devicetree-rebasing \
>>> -
>> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
>>> -    fi
>>> -    git fetch devicetree-rebasing master
>>> -}
>>> -
>>> -if [ "$1" = "pull" ]
>>> -then
>>> -    remote_add_and_fetch
>>> -    git subtree pull --prefix dts/upstream devicetree-rebasing \
>>> -        "$2" --squash -m "${merge_commit_msg}"
>>> -elif [ "$1" = "pick" ]
>>> -then
>>> -    remote_add_and_fetch
>>> -    git cherry-pick -x --strategy=subtree -Xsubtree=dts/upstream/ "$2"
>>> -else
>>> -    echo "usage: $0 <op> <ref>"
>>> -    echo "  <op>     pull or pick"
>>> -    echo "  <ref>    release tag [pull] or commit id [pick]"
>>> -fi
>>> diff --git a/tools/update-subtree.sh b/tools/update-subtree.sh
>>> new file mode 100755
>>> index 00000000000..5946aa1a9e2
>>> --- /dev/null
>>> +++ b/tools/update-subtree.sh
>>
>> We have scripts/ and tools/ directories, this being a shell script I
>> would have intuitively added it to scripts/. So my question is, what's
>> the difference between those two directories :) ?
>>
>> Good question. Personally I think 'scripts' are for those scripts needed
> by other components and 'tools' are for the general purpose utilities
> (not limited to scripts). That is the reason I prefer 'tools'.
> 
>> @@ -0,0 +1,86 @@
>>> +#!/bin/sh
>>> +# SPDX-License-Identifier: GPL-2.0+
>>> +#
>>> +# Copyright (c) 2024 Linaro Limited
>>> +# Author: Raymond Mao <raymond.mao@linaro.org>
>>> +#
>>> +# Usage: from the top level U-Boot source tree, run:
>>> +# $ ./tools/update-subtree.sh pull <subtree-name> <release-tag>
>>> +# Or:
>>> +# $ ./tools/update-subtree.sh pick <subtree-name> <commit-id>
>>> +#
>>> +# The script will pull changes from subtree repo into U-Boot.
>>> +# It will automatically create a squash/merge commit listing the commits
>>> +# imported.
>>> +
>>> +set -e
>>> +
>>> +print_usage() {
>>> +    echo "usage: $0 <op> <subtree-name> <ref>"
>>> +    echo "  <op>           pull or pick"
>>
>> I think pulls are supposed to be done and sent to the ML by maintainers
>> only? At least that's what we're supposed to do for the dts/upstream/
>> directory AFAIR. Is it the same for mbedtls and lwip? If so, maybe
>> explicit this in the usage that only maintainers are supposed to run
>> this script with that option? And if you need to do it, ask the
>> maintainers to do it for you? Does this make sense?
>>
>> The rules of running this script are the same as the original one
> 'dts/update-dts-subtree.sh'. We have the documentation for dts now,
> and will have similar ones for MbedTLS and LWIP soon.
> I didn't add this part yet since both MbedTLS and LWIP patch series
> are still under review.
> 

I'm suggesting we could "improve" this, not that it needs to be done as 
part of this patch :)

> 
>>> +    echo "  <subtree-name> mbedtls or dts or lwip"
>>> +    echo "  <ref>          release tag [pull] or commit id [pick]"
>>> +}
>>> +
>>> +if [ $# -ne 3 ]; then
>>> +    print_usage
>>> +    exit 1
>>> +fi
>>> +
>>> +op=$1
>>> +subtree_name=$2
>>> +ref=$3
>>> +
>>> +set_params() {
>>> +    case "$subtree_name" in
>>> +        mbedtls)
>>> +            path=lib/mbedtls/external/mbedtls
>>> +            repo_url=https://github.com/Mbed-TLS/mbedtls.git
>>> +            remote_name="mbedtls_upstream"
>>> +            ;;
>>> +        dts)
>>> +            path=dts/upstream
>>> +            repo_url=
>> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
>>> +            remote_name="devicetree-rebasing"
>>> +            ;;
>>> +        lwip)
>>> +            path=lib/lwip/lwip
>>> +            repo_url=https://git.savannah.gnu.org/git/lwip.git
>>> +            remote_name="lwip_upstream"
>>> +            ;;
>>> +        *)
>>> +            echo "Invalid subtree name: $subtree_name"
>>> +            print_usage
>>> +            exit 1
>>> +    esac
>>> +}
>>> +
>>> +set_params
>>> +
>>> +merge_commit_msg=$(cat << EOF
>>> +Subtree merge tag '$ref' of $subtree_name repo [1] into $path
>>> +
>>
>> I would recommend adding at the very least the path of the tools used to
>> generate this merge commit (so ./tools/update-subtree.sh or maybe just
>> $0?) or maybe even the full command line that was used to do this merge?
>>
>> Sorry but in any case would we need this commit message only without
> knowing
> the variables?
> 

Less magic for people not aware of those pulls and how they are made.

> 
>>> +[1] $repo_url
>>> +EOF
>>> +)
>>> +
>>> +remote_add_and_fetch() {
>>> +    if [ -z "$(git remote get-url $remote_name 2>/dev/null)" ]; then
>>> +        echo "Warning: Script automatically adds new git remote via:"
>>> +        echo "    git remote add $remote_name \\"
>>> +        echo "        $repo_url"
>>> +        git remote add $remote_name $repo_url
>>> +    fi
>>> +    git fetch $remote_name master
>>> +}
>>> +
>>> +if [ "$op" = "pull" ]; then
>>> +    remote_add_and_fetch
>>> +    git subtree pull --prefix $path $remote_name "$ref" --squash -m
>> "$merge_commit_msg"
>>> +elif [ "$op" = "pick" ]; then
>>> +    remote_add_and_fetch
>>> +    git cherry-pick -x --strategy=subtree -Xsubtree=$path/ "$ref"
>>
>> Should we add -s there too? (or --signoff)
>>
>> As I search for all 'merge' commits in history, they have not
> signed-off tags.

Yes, and I think that's a mistake. Though.... I'm not entirely sure if 
we can add this Signed-off-by tag to the merge commit as well? (with 
what I'm suggesting, we would only fix one of the ways to bring patches 
into dts/upstream or the two other subtrees).

> This patch is to extend the original script to support more git upstream
> repos.

Yup, was just suggesting "improving" this, not necessarily as part of 
this one patch though.

Forgot to say in my earlier mail:
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
