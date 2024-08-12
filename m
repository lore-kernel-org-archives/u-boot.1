Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C94C52D7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 10:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5388A88680;
	Mon, 12 Aug 2024 12:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="aiICIBlV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 426E288703; Mon, 12 Aug 2024 12:44:46 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D7A688680
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 12:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBie9RmrzxtKJ7lN9kjktK33TxMuDTp6YIJ6s7lPvmLwvX8QcrxHmLZc8nJog0Wrp0oILeb+EJsS8UEClqh+BE+6HWWpx8iRlFMkK7yTypNl5awRIbyjbi1UKzzp07ggZnlSFBA2/cE8UdWQudTSVKhkNUn//yxLgwc8O6S3Gb/SQLRmv3KEY/VjQuQpyz6TblcL2H4sHd7ejLykghu3nS79ESJfYJbJB0BXd3l4aVWhYZQ0KaR7SrCkichj+JdZel/B/XsZOJg1iXVSX1RVUdYGa0aSfx53/3lpz7HgKxixFIqjvB3ceoNZRrRb6PlRCdy7Wiszlt7jHU9MR7qvAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9kf2eEw/riC/RtRxzyOMQEgYbTGfolbJHC3aq0Df3M=;
 b=sGu1UIw5MGy8hVJS7doLWlLCaoNfOr7abTLrUykOui4WEOy5wasFBGrLKncFF66wIryqKcuDKn3Aq+8cqpBiLHfC+Iw824pCrcYdKZsXBZbCGXvIgh+9LFfbtbu+qpnQHsj33uKl06huNTr+BU3GUTsaXuDwsdTNje609fc9RwTj5yz61I5OHn9H6XI6G1Iw8h3vJMJpoxDPrGRoVGF6l6LkFsumGFzmDUC1ynHgLIXVLA6Mz5pA2IBnWqw2XUdSyDVFqvJa9n/d+8Gfb5nSer8tDh1OqCe6tIO8/cfoBookX7Zfw1HP5nz55mrp0ofUd7CDJIfjk/C/UAlTxVpS+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9kf2eEw/riC/RtRxzyOMQEgYbTGfolbJHC3aq0Df3M=;
 b=aiICIBlVrB/Vbx7Dycv5i9ZgvoV0dlMB0nwTXNqH1JU4Np16zD/IZSkyGhIVwuCthSsI0FStp0adh6w/IfG8nKdUkKYG3A3iPcV9kFbQSBCw72yuP8qUheUS55ZvN4Er+MsbX40cTlM4gGTLkFPLDPdBuZ4HX/WcL58ewsWHpZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by VI1PR04MB10076.eurprd04.prod.outlook.com (2603:10a6:800:1e0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 10:44:39 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 10:44:39 +0000
Message-ID: <4bdb19d3-db99-4456-b7db-a96153a3f7dd@cherry.de>
Date: Mon, 12 Aug 2024 12:44:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] rockchip: Skip serial pinctrl at pre-reloc phase
To: Jonas Karlman <jonas@kwiboo.se>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240805084350.3895788-1-jonas@kwiboo.se>
 <6df6a6df-f8fc-44c3-9688-6f2ccbd8888d@cherry.de>
 <ea4c0f12-bf49-405a-afdb-3312e1eb8c95@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <ea4c0f12-bf49-405a-afdb-3312e1eb8c95@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0012.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::9) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|VI1PR04MB10076:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a3fd1b4-9c7c-48d3-c101-08dcbabbc42a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFZGZUJsamFGT1dYcTBVSE1rMXhXU2ZZalpxb3F5SSt5a29kd29RRTdCWldp?=
 =?utf-8?B?QkhhWHd1clNoVE03NjQ0OGpUeXY2STBaWkx3Mmt4Z3lSWEFacmZrU2o4eU1r?=
 =?utf-8?B?QWQ0QWU4cWNvdVE0QzJhVlNVaHdjQ3JSb1A3SnJVb0tJVE9wTXJsem0ydHp4?=
 =?utf-8?B?OVVCU1gyV2VkUkpKeHBwTDAxRFpMV0V3QWFieE9jZnhNVjF5Y0dtaHFnclhR?=
 =?utf-8?B?WTBNdWlyS1JqQ09sM2toa0VVdTZ0UmN6bkRacEp6ZjFlOHQ5YW5mQ2xORmVT?=
 =?utf-8?B?b1h4bVRwN1poSThZNGFOd0t0UWtqMTA5aW44d1NJcmlRdENiTW5pLzROTGZP?=
 =?utf-8?B?TFVqSnh6ZWZiQmRjek9YU1hLaVdtUFFRL2E0Z01JRkcxL3pKVEF5NDdiWXBP?=
 =?utf-8?B?N3cwRTM5V20vSEdTeU9RZitFMElHOWg4dGtnUmcwTDM3Nzhoa1Y2bUNncFQz?=
 =?utf-8?B?blhQNTFOSnBKRHAyTDhXcm5xcDExRXRiUnNmdktpZ0Z0Vm5XSFowWVRTQ0Rs?=
 =?utf-8?B?aFRtdlU2bklpMlpPaUYvWmNoOVhCSzNzQ3Z5Q3JvZjEweUhQL1dTWHZTTTB4?=
 =?utf-8?B?K0FEVVNNa0Z2M3Y4WFNYZkl1TGdpKzVMMjVjRHplSENtRGdxTTBNblBMTTd1?=
 =?utf-8?B?MnhUbHoxMHkwSTJZT0RJY0M2UUQ1WVMwRlJnUENZQWtEbXZJck1jT1JKeFBE?=
 =?utf-8?B?SEhDU1JoY2pNL214MDBKNGFITmFtSzllZ3JOSjI0NWJGMWtRRExBNXR5Yitj?=
 =?utf-8?B?dWhlZW00azI4R3BmTHJ3VURGVmQwcUo3bkNzWkNQSDMzM3ZBVUxFaW9Ib2RR?=
 =?utf-8?B?NnlSTitkTkRtYjJBVHhxTU1hNlA5aGpYaE1tWjBTVU9CWVJ1S2hvT1dVMkJE?=
 =?utf-8?B?RSt1UWNOYTZhOXYvVHFZUFVHS0UyUGJzYmRuL3VWQXpqcmRBZXk2VzhuTUQw?=
 =?utf-8?B?UFRIay9vL0JnbnoxOFVWSXdmNUZjZWRjczRhZ0FSaW1INStZZFpWNHF5a05i?=
 =?utf-8?B?VGNkT25SYVkwcVU1aHBJTG9ON3FLb0k5cmtSVmVpblZMYktpd3dxRzBLTWR5?=
 =?utf-8?B?TUMwT0JOWlZva1loK0VnV2tXbGY4cWxOWE5Lb3V5WnFvMWRZUys2cDBxT1RF?=
 =?utf-8?B?OWJXakVrOTZLWk9ueFFNTWhxcndvWlNlQzM2eW1EZHAxM1BxTW9zNXhST1dh?=
 =?utf-8?B?cmc0ZWJQeDdTSkhTRllJaUJKSTBJcm9mWWFpdlpSN2s3WlYzd1NkaU5qYU1x?=
 =?utf-8?B?L1R0UmY1SmhiTFRNT09wTGRxU203RVZWUkZlZ2VoMWJNOUFOdzN3OFpaazBa?=
 =?utf-8?B?R29mazFrNWdESm9hWkZnZGZyamtyNHluOHpYdmhlUjNQSmoybWphUDl3MWE2?=
 =?utf-8?B?UTRReTFrcnFBckVBYXFsSFlSMTAyQW5SV2xFZ2xJT216WjZIZUozcElnVks5?=
 =?utf-8?B?SW5oWWpkaFNqcUVwYjMvbGhpeFVJcGhVNFdnNmNreDBqanNpNTY4YUUvRk5i?=
 =?utf-8?B?blJaMEhpS0tHYk5vWUF4ckVRQmtSajU1NjgzNXV4VU4wSkZ2bnFCMVhuOHRU?=
 =?utf-8?B?dU9EOFJCeDM3OFRrUEhRMk1TZ2FFSG9CVXdCZ1BQLzdrd3pDS3VVanlVMFEy?=
 =?utf-8?B?NWhWUTJ6Y0ViTzZkRitZMTIvZ2FabUF6N1o0Y2pxQkNkNGVEMlVhaVl0RDVk?=
 =?utf-8?B?WG4xSXowWTRwSzFkSlRkbHRYMFB6Y1dNMFJDdHdTQmU4M3NyTmY3S1FRcTIw?=
 =?utf-8?Q?UgHR8cHJsF1VDgBTmo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm0xK2d1cWh2M3hBZmh6ZkwrQkt4Z1k5SkdveHNQQXdkZWxSTXQ3c2J2TXJq?=
 =?utf-8?B?TFc1bnlNMkp6Y09aUWZiTi9oSEhURWtNYUpuQVQ1RkhPMnNEZU03VG96dVpU?=
 =?utf-8?B?UXVuMVRzTTIyWC9HbHJYNTFML1J1RDJzci9GeFQ4N2Y2Ymlldkh6ZDFiUEZ1?=
 =?utf-8?B?TFJBNkdkMk5tck45ZjhDd041YkU2TjNxL1BHR1VwWUZoRDI3SGM5QXdJNmtt?=
 =?utf-8?B?L05oMWVvUkszaXNsWHUxdFVoV1YwRG8zcTRVUFpLOVBOYVZ2TlNTb3BaRExG?=
 =?utf-8?B?MHkydnpaQkVuY1ZaQnlvRjVuK2x4T1dOV3c2ZU4yN0wveUVXdjh5VENQckpQ?=
 =?utf-8?B?ZHpBMmZCTS9Jc2xGUXlic1luaFRSWjBYTUpxUHlpQVV0NVQ2QWFWTWxhMkdS?=
 =?utf-8?B?bVZ3Y1pTa0kwYWNpdW5qY0dJNk1ham9zQ2J3NSs5VGM5dS9seFF1N1M4VTZY?=
 =?utf-8?B?bXZvVG1rUEh4MFQ4dGJZY2laSkNjV3FiUHFzS1V6TXZ0bFlPQ0pDUEZvb2Yy?=
 =?utf-8?B?Q1FJS0g1UU9DVkRSYTZ2WFRVbEQrN01vT0pCK0o2UG1pakEyTFNBbXNEb3F3?=
 =?utf-8?B?cWI2dXRmYlhYK3hCc0JxOWowcVNrWktLeEgvbm1PNU9zSFl2eDZ4WUpBM2Jk?=
 =?utf-8?B?R0RzSmxZOWpNYlpEemlGUS9zSFpFZlhYZkJ4a2M3dVVEd2c5bndQb0N2VXJi?=
 =?utf-8?B?b2lqZ1dSZDRqWllNN2UrL09EbzRnSlhFSEsrNE5UZzB6emZIN3lWSDZxRVpr?=
 =?utf-8?B?WENDUFVPK2YyRUFBRk1vMjVmdk1pODNDaWdNU2tBckJ2NTNDWTBzbWx2dVRm?=
 =?utf-8?B?YmprY0xXN1BlZHFTbk4vWiszeTRNaXAvaDNzT1JONFI2Y0V4SXZuNlVHT01D?=
 =?utf-8?B?TVdGZWsyd1ZBN1FralY2NEVpTnQ4OEpMWGE2eW9PdzVmT21XQS83bGh4bTZr?=
 =?utf-8?B?QlhvU2hiVTdkRkpnR0J1YkhObjM5eTMrTG1TeWtCYVVxWmVneFhEUmlDaUk5?=
 =?utf-8?B?Ym1vdk8zNVFWbERjT1FQUU5NSVp6R2VjOGdpN2NGcmJMRmJXNFRVZlBoVXN5?=
 =?utf-8?B?TjFzT0NQbU14OWNSd0hjTW1DSmxRM250T1poZ1JXUWFNZ050L3pma0xKTlJx?=
 =?utf-8?B?ek1LcUhWam1RajFZNGpSK1duNXRvUVdWdXVvRWlsMlJ0b2I4MGU3UjJQRHRR?=
 =?utf-8?B?U01ucjNsRzhEcjVseW96cHRndjVwWTA0UEx4bjF3Qlh6cm8zWWRiVGhKOWJW?=
 =?utf-8?B?RHhUTUwwUTBvNmFwTUxNM2tlV1Yxdk9XcmRGSWRuZEpWMitpRnJhVTllejRD?=
 =?utf-8?B?ZEhKa1d2emZBMU10UzhJM1JzTW9KVkdOWFRyVitVaytRY21TZ29QdncvL0N0?=
 =?utf-8?B?WVVQRzBxbUpyUXJMKzNrQ0E2b2gwLzExNTVHSG1PeUMzSTAvTDM2NzFIWTdO?=
 =?utf-8?B?UHRpVnV5aURKeksxYmROQlh3Y3NWckhpYkpBMnhaUkNKOUlaT1lncXA3WWRQ?=
 =?utf-8?B?YXhWMkpidk9YZ1FjZ3Urbll2RFdibFM4NXlod0g5OE9scTltZWx3Y3MrTmVs?=
 =?utf-8?B?M3NXU2VyeWVtQysyQVVjWE1qSVg0bUFPS1Z0YnYzZjk3UGlxWVEvdGFNSmpQ?=
 =?utf-8?B?UE1MU1hZTnZpcjRidTBWeGtlNGp6OWVVajE4YUluRy94cloxYXJSc1JzalBX?=
 =?utf-8?B?aTdiQy9tTTR5TlIxSTA0Ty80UGI1NDdrMXhoTWJSOFRiVUEwdkxHZldnOTlQ?=
 =?utf-8?B?QWxZWVJ6enJ6c0tPanNGUXExNzR5UzBxSVdOUGxRUlB3YkFhY2NyL3ViUDFs?=
 =?utf-8?B?WWd5blJkalFoa2hWWDdCYUZ0Ny9XOGlOeFVVM2FUVjBWSmVQdWZ2TTV3Ukdl?=
 =?utf-8?B?d3JURjBjYytPbUpIcCtZVU1STHJ2Q0c0M285ekMwVktCV1dxZnNmb0hIZDcw?=
 =?utf-8?B?eE03Ti83am1qVGxFeGRaTGFUV2xaS1VTY1AwVlZiZldBZ3BLTkcwVXJpaG1n?=
 =?utf-8?B?VVBIb0s4MXBsZno4R2dSSUpoN0JJUmE4aDNyelN0c0VaZFpaamFudVM1cTJV?=
 =?utf-8?B?WmxZcGNsamtSQ2RHbkI5QUdRa3BKc2dKa29qODNJTVZHdElBeElQak9sS0dT?=
 =?utf-8?B?anFLUW13NU91U0diNGllM3pEZTF6MlhxVW9kbzREUHVCZzhOL1NnYnVjdGhL?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3fd1b4-9c7c-48d3-c101-08dcbabbc42a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 10:44:39.3700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtzQuPsoQTMFmDadOaHbQ4EepnWcMVGJqy9v0bKEprDRTcv39SU/b28S4ktiZduF0GCMscHXP2DHbP0BXPX8Yg8EEnWyZvNNFuTjQd+zuhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10076
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

On 8/5/24 2:22 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2024-08-05 12:23, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 8/5/24 10:43 AM, Jonas Karlman wrote:
>>> UART pinctrl for serial is typically applied multiple times:
>>> - in external TPL or in TPL for DEBUG_UART in board_debug_uart_init()
>>> - in SPL for DEBUG_UART in board_debug_uart_init()
>>> - in SPL using pinctrl from DT
>>> - in pre-reloc phase using pinctrl from DT
>>> - after relocation using pinctrl from DT
>>>
>>> This series change bootph props for the UART pinctrl to not include them
>>> in pre-reloc phase to save some boot time:
>>>
>>
>> NACK. I feel like this is a hack for vendor trees only.
> 
> I disagree, this just relaxes the bootph props currently enforced by
> <soc>-u-boot.dtsi files. For boards that has special need they can
> still add bootph-all or the bootph-some-ram prop to restore prior
> behavior.
> 
> Also please do not associate me with any vendor, I am a hobbyist :-)
> 

Non-upstream = vendor for me :)

>>
>> 1) The Device Tree represents the hardware. We need the mux at all times.
> 
> I do not think this changes the the description of the hardware in any
> way. The bootph props is currently already more of a representation of
> how software should behave than hardware.
> 
> In general for Rockchip use of the bootph-some-ram prop (pre-relocation
> phase) does not fully make any sense, since we already have full SDRAM
> in SPL.
> 
> If we where to fully follow the dtschema description for the bootph
> props, for Rockchip they should probably map to something like:
> 
> TPL:
> - bootph-pre-sram: Enable this node when SRAM is not available.
> - bootph-pre-ram: Enable this node in the phase that sets up SDRAM.
> 
> SPL:
> - bootph-some-ram: Enable this node in the phase that is run after SDRAM
>                     is working but before all of it is available.
> 
> U-Boot pre-reloc:
> - no prop mapping, we have all SDRAM and can use all devices, ideally
>    for Rockchip we should just do bare minimum to relocate without
>    loading any driver and then move to main post-reloc phase.
> 
> Instead they map to the different U-Boot software stages:
> - bootph-pre-sram: TPL
> - bootph-pre-ram: SPL
> - bootph-some-ram: U-Boot pre-reloc
> 
>> 2) This breaks users who want to have no serial in TPL/SPL but in proper
>> (where you want it as soon as possible I assume, thus pre-reloc).
> 
> Do you know of any such user/board? Adding the bootph-some-ram or
> bootph-all prop can easily be done in <board>-u-boot.dtsi for such
> user/board to restore current behavior.
> 

Yes, Lukasz in Cc has a device that is doing that, he'll be fixing a few 
things related to that soon (tm).

I would suggest to have one commit that basically moves bootph-all to 
all boards which currently include the -u-boot.dtsi where bootph-all is, 
and add bootph-pre-sram+pre-ram to -u-boot.dtsi. 0-sum change and then 
on a per-board basis remove this bootph-all? Basically, I'm not sure 
this is a sane default to have. For non-upstreamed boards, they can 
figure this out whenever they contribute. For upstreamed boards, I would 
aim at not possibly breaking stuff in the name of optimization?

The issue I believe is that you wouldn't be able to tell if there are 
users today since this should be a Kconfig symbol selection 
(SPL/TPL_SERIAL for example).

We could start having #ifdefs in -u-boot.dtsi for when $(SPL_TPL_)SERIAL 
is enabled if we wanted too. Not sure it's a welcomed added complexity 
though.

>> 3) This likely also means if BL31 is configured to output on a different
>> UART mux of the same controller for some reason (I've seen weird stuff),
>> now U-Boot proper pre-reloc will not output anything as well.
> 
> Same as for 2), adding the bootph-some-ram or bootph-all can and should
> be done at board level for boards that have special, or weird,
> requirements.
> 

It's just super weird to me to enter some corner cases because it works 
in most cases today and is bringing ~100ms boot time decrease.

> It is also possible to add board specific code that call
> debug_uart_init() early if you want to ensure pinmux without adding the
> unnecessary delay that use of pinctrl in pre-reloc brings.
> 
>>
>> Adding Lukasz in Cc who's trying to fix U-Boot so that this is possible
>> on PX30 (therefore, not just a theoretical use case I'm bringing up ;) ).
>>
>>> - Radxa ROCK Pi S (RK3308): ~80 ms
>>> - Radxa ZERO 3W (RK3566): ~120 ms
>>> - Radxa ROCK 5B (RK3588): ~150 ms
>>>
>>> Similar change has already been applied for RK3328 and RK3399 boards.
>>>
>>
>> Then I believe this was a mistake.
> 
> My wording may have been misleading, when we added broad use of pinctrl props
> to SPL for rk3328/rk3399 we limited so that the uart pinctrl group was only
> enabled for TPL/SPL and not pre-reloc phase, because also including it at
> pre-reloc added 200-300 ms in extra boot time.
> 
> This series tries to apply same findings on remaining Rockchip aarch64
> boards.
> 

What I'm complaining about in this patch series applies as well to the 
patches that are already merged if the intent and result are the same.

>>
>>> The change for PX30 has not been runtime tested, and only include change
>>> for uart2, not uart0 and uart5 used on two of the supported px30 boards.
>>>
>>
>> This means we have uart2 pinctrl at all stages even though we make no
>> use of it?
> 
> Yes, in my opinion the px30-u-boot.dtsi include lots of nodes that seem
> very board specific, some that probably should move to board specific
> u-boot.dtsi files.
> 

That I would welcome.

>>
>> I'm starting to wonder if this optimization isn't orthogonal to having
>> as much support as possible via an <soc>-u-boot.dtsi which was done to
>> make bring-up and maintenance easier. If you're really after
>> optimization AND we keep the pinctrl for the debug uart (thus, not
>> breaking 2) above), then what we want is cleaning up the default
>> px30-u-boot.dtsi and move bootph properties to the board DTS instead?
> 
> Agree, for other aarch64 socs I have already tried to cleanup
> <soc>-u-boot.dtsi to only contain what more than 70-80% of all supported
> boards may need. For rk3399 bob and kevin even use /delete-property/ to
> remove some of the common boothp props because all other rk3399 boards
> benefited from those common boothp props.
> 
> I have no px30 board and the only rk3326 board I do have does not
> include the px30-u-boot.dtsi, so I will not try to do any cleanup of
> that file.
> 

Understood, this falls on someone else's shoulders then :)

>>
>> I was a bit against this "turn-key" solution wrt u-boot DT for
>> rk3568/rk3588 but we went ahead, are we changing our mind now? Just to
>> know what exactly is the direction we are planning to take.
> 
> Please elaborate, I do not understand what you mean by this.
> 

I looked a bit and could only find:
https://lore.kernel.org/u-boot/9d7063f9-c1c9-681c-480b-4c88895e6ccf@theobroma-systems.com/

This doesn't really match what I remembered of an "argument" I believe I 
had with Kever about putting stuff **I** didn't need for my boards in 
<soc>-u-boot.dtsi of which the answer was "I prefer to have something 
that works with minimal work than something that is optimized and 
require more work for newer boards". But cannot find it anymore, so 
maybe it was all in my head :)

Cheers,
Quentin
