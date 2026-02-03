Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3C6E87839
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 15:28:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEE0583BC9;
	Tue,  3 Feb 2026 16:28:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="O2dlM9i/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3D9783BD2; Tue,  3 Feb 2026 16:28:14 +0100 (CET)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazolkn190120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d406::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CE0683B72
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 16:28:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpnF+RJCkn7KWlnMsNyibK505SkqMFLpgIMvqie89CuAkm2D2xgN+o6NVY+YggZGkRaPbsGY38TAQzT1C7eGyQC3J4TLgNPRdf9sBOUxRaWQcbcLFgtPFJzDcgdRcUQ1jEngUSdZjDPQtD1pAVW7VBGtdNUwsiuOFM+EH5nR9kspI+gTDI2p59N0Oz9FdjWWaEXd801/7+84pd1RVUkHHHlsPYy18IjaqZQhZm40n593moOOe70pLDM+N5TGB5Xk5+CWw1LRFHbo24iiUewlq8iVSR4K6TO9WKfi998D4gJg1p0P7bBT5pTMHevhuEx5bz8YCy57VLiDmGgdC3HH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3xLWs3P7kx9b0xf4pmfgpAM9hq7UvQf1Qluf0BXRoM=;
 b=jZIRDY+9oqjDHQ9i/2oLOR3F4gZRxcl3FsPRLUwZta8D8lAv1JQ2SSKyIGGtyf1CpHQ9gNcU1kubGYESnOXUtbiOS7qPn1DWbLbdO9gn/ziCIBawIrwhMy7QfWDguJphwjaXzJYjF+JaSbzAWHYs8WmTzmbVEOXnMN5eu0z3GvnE/QQwUHrj2De5Czwb0nOAvzhcEe3Qy+oNszzcVvELveVPIjrjwuo8wv35F4neEjvsGXHgkaRJn+DpqO8lrWTSsP6WVCbKNkM5ccUnUx694OxKlwWoNUOgPD8roXLkFn9TfNtLAyOZa++5oS2RZJMrp1KQi3DDoWAyCn23lc2LBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3xLWs3P7kx9b0xf4pmfgpAM9hq7UvQf1Qluf0BXRoM=;
 b=O2dlM9i/XFAGSLppzg5UlN7Lb3/7HuOVEyvVOeBl3mD3+YMNw8rblYVB7vepXgvM+0042rP1/PJoNSRIPx9M4zEUWCZXX0O/X1VS+/t9tbJd/s+P9FACIO/1sCZStgsQHh/USEpAxv+g6AcAGmtGVZNcRhBKXzAs6hhmpbrQK9zXIAfoB4c6KHXQsMGrnkpUxGTSd3BAv4mCkd/88bSZuYRcv8EhGQejmoYO5IRIV4qIXBdm50gLcMpk2Hr3o1lZY3YshvrZcc4tZr857x4OVPH46B7nyi9YqkJDW8xJsKtpRHMeV0iPuxo5sli8qmE26uDzO4VwHCsAdgsrZto8NQ==
Received: from TY0PR02MB5551.apcprd02.prod.outlook.com (2603:1096:400:1bc::11)
 by SEZPR02MB6775.apcprd02.prod.outlook.com (2603:1096:101:196::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:28:08 +0000
Received: from TY0PR02MB5551.apcprd02.prod.outlook.com
 ([fe80::77fb:ebe7:31e7:fcfa]) by TY0PR02MB5551.apcprd02.prod.outlook.com
 ([fe80::77fb:ebe7:31e7:fcfa%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 15:28:08 +0000
Message-ID: <TY0PR02MB5551507C4879363FBB96E946969BA@TY0PR02MB5551.apcprd02.prod.outlook.com>
Date: Tue, 3 Feb 2026 23:28:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] clk: support arbitrary clk_register() sequence
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 Simon Glass <simon.glass@canonical.com>
References: <20260120-clk-reparent-v3-0-0d43d4b362ac@outlook.com>
 <20260202201706.GA4073175@bill-the-cat>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20260202201706.GA4073175@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::9)
 To TY0PR02MB5551.apcprd02.prod.outlook.com
 (2603:1096:400:1bc::11)
X-Microsoft-Original-Message-ID: <ec44f677-cbef-4d03-90e9-9e733b9a9e8f@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5551:EE_|SEZPR02MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: bdac5ef0-7662-417b-89e9-08de6338d4b9
X-MS-Exchange-SLBlob-MailProps: Cq7lScuPrnr9cOglUl1urTSFBsjx1OD0eg3VGPBsQBbxA0FCwTCQpwfKS+rGG4qc5aCow2DQ2zX2tdKskL3k297xAR+gaP7892eY2fjvnmMH28Is/Y0Q5/hDiVl46R5U72sko83UQv1thQ1H1rW4IAXNiGNohrGwv3qVgqRhvLpGbF3cQwHEGWb2xjiN8KpFQeBtu3NndTIso1m7MjQbGILnCggRksnSg59OTSKhJ3gKOCTBNj8WwgzwlWaj7pT6MFhTD3DCdDaSVsvmyX3XfsYmzKiTQJE01XzAI7Te9U19anAcokFHQlsDg/hSz9dJXLuuOhYQXbG5LOmDwNTFGY4fFy7maT6k04qGlC70Sr493YlrJllVUKoW+Q1a8JdU72m/3nnAsR6lcTm3OPXobyPCZEc1Y2tGEkzMvm6koF/ifj18OBWA2kQJo+VwxG0R/e7I1uzeWFWVHzXa3FT7w+kMgLW8duZ9tx1VWTpCshzQowO/Rj3KFeGfxiZTFG1v0q77B4ljEiS8An5le4ZVbblTLwCKK9/OrO8cs9Jg/YQXuDR/lYAkMhB5dipAiIGFb+yXBhnASzaxMNGb/HvTYsX4YVZE4AFCwnq4o/jvrsyv6PkL/NdShl2/6VW7tOuyeC+lrgzzLaMlf3h/jvTpTpEHAPhZhJw0j7JhmcJfzFLBTTx/oRrZwRRXU5onArI0xEkwoJd3/VNRnPZzWsKusYmV+EnbExeIKNEFImFm6xbnVnh2IRAMuwi6zxq4mH4hOFZ8bHQOqPg=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799012|8060799015|23021999003|5072599009|51005399006|19110799012|461199028|6090799003|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ay9IU3pVWHBWMXZnVSs4UzNESlBjYy9KbHowSDB5ODlZcURIODFkRUpyaXlD?=
 =?utf-8?B?aVUvek0vN0pJR2hUUGUwWGJFWjBGaFJ0R3Z5Rk5WWVpYR1FsblQwbmtWVDIw?=
 =?utf-8?B?VVBhVzZ1cGRGbllNZTE2QWxIZUYvMmdRYmFIUDBQYWFUYmpSLzluNU4vZ2tx?=
 =?utf-8?B?QS9RR2dpblo2bDJ0TkVYR3VJOUcvRUw5YnR2cGM2UmxKUU52S1prZkpSSVN1?=
 =?utf-8?B?L1BlbVVpUkFiNmNzWno4dGJFVHFrQng4UDEybDY5ejB6OW1ueWhCSHJ2bEpW?=
 =?utf-8?B?V2txK2Vzdk1JTlVQOGZ5TnhVWEZVN1BjTmVua2lQekZzalFLSE5FaFJ5dWVp?=
 =?utf-8?B?TU85TUxtNzZ5MkpGYkhPRzJabDB0VDlXMnA2VWVNNzVST0xqaXpjTTMxRk41?=
 =?utf-8?B?Yko0aTUyK1UrcEY1WGFXVlhWY1M4VHRhR2xZc3ZzSmN0VkM2SGpBL09oR09v?=
 =?utf-8?B?Uno0bjBhcXpkUU5OcFYydG1Hb3VUSXZyd2xiVmMyUjdmQWkvNFE2MisrV2J3?=
 =?utf-8?B?dHY1cGxBSnVPZ1hkRS9mY0xQL0lVbUZkMG5aQmZDU0lDWXU4N1ZMYk5YK1Fr?=
 =?utf-8?B?WWl2SzZEanFxY21pSE5zTlFGbkVJSGZVVXVTVks3L3F5VVVOS2psMCtVTSs0?=
 =?utf-8?B?ZVhZVXgwY3NKdzZPM2w1WHVvRC91Wk81MXZHUkZIL0JFaXY4Y2sxN3RXNjBh?=
 =?utf-8?B?ZHByLy9ZV1VtN1FsK056WUk1WnRFL1hCRFQ2R3ZFalNhanVITEEwOUVSVzd3?=
 =?utf-8?B?WW14cDZRSmtwaGtLT1dmQWJXRzZqdExpOXB3MFpwWDk5QnZGUjB5QlE2WVU3?=
 =?utf-8?B?bjFoUGJ3REgyTnZ4MG83T1ZrNlY1SzhDc25MWFNmcmZWNzc0NzN3K0NPYnBa?=
 =?utf-8?B?Ulh5bnB4WkE1MWFTczltcGxqaWhremN6bFM1ZURXK2pML2VKM3p1TmtNVGR6?=
 =?utf-8?B?U1BrU0FwVmZNdFJ0QVFwaGpJOEt4cy9OYy9BaWJ2RUpFdG5vR1A4SjlsQnhK?=
 =?utf-8?B?d2FGUlNTcnBaMmhCRmhGR2lYdzB3TDljV09MQkFnemVJaHJVL1VvK2FnVTE2?=
 =?utf-8?B?dWM3YWcvdnNnUE5WOHpnVEhDTUY2ZHV6Vkg4U09GWmUvM2xQNWhieEJoMUpU?=
 =?utf-8?B?NzJDQ2diVUR3bDdOelR1azZtVGZNcTJDNnZjRDdaSzc1cEZDRGZqSW9uWENh?=
 =?utf-8?B?aC9GdHBLQ3VneDFIbjJtdE5EOThSTzR5V0IzNHYzQncyeERVVEFnYmxvV2V2?=
 =?utf-8?B?UWEzSHdoT2tkd0FSMlVDWVE0eGpLZCtIZmg2VnBGbnFxaW00UXJ3VjRWM1NK?=
 =?utf-8?B?anNHM01CcTFnT0tpR0dzNXFBZmVtN3pvcWdIREd1WE5NVEFIeTMzaWFFMndH?=
 =?utf-8?B?VmJCVmc1OUY0VDBhckZmSitnUkZYblBmQXIraE8vcWVQL3owNHIyZ1FDQy9h?=
 =?utf-8?B?OHdRRVVvT0JDYUhPQ050S1pwQnN3UG00M1ErY2JIRHBlTXBJVnVPbE5qL2NG?=
 =?utf-8?B?dGVPYURkU3NjWGZ0UkQ5aTJ5bWpleXM0cGlqby9zbHNRM0JCSU9qUDJST2N6?=
 =?utf-8?B?SW9reGcwejR5eCt1dk9nVVlyYmZLVVpjZmU0Unk5OVlLVlJYNEVPMVN1OUVM?=
 =?utf-8?B?YXNxSGYvN0IwMTc5RWNMelVGaVh6NFE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXZqZVo0a2ZPYk8wbVFkSFdRWW9DVkR2OTVMMy9MYUx4bjN5Q0VvUlJKODFx?=
 =?utf-8?B?WEE1NTMrMHByNkJTb1E2MFhUV3VsMEgreVJ2RzIwU2xqQTh5VGNhSFFmc2ZK?=
 =?utf-8?B?SUN6Rk5OZTJQOXRobU5HK1l0eHRqbTlsWi9mQjZUYXRZVis3L3dndlhJa1d5?=
 =?utf-8?B?cVIvK21XV3dmZ1Jra1VwVk9FSG5QTktmbGRjSE9GeTE0d3h3ZG4zNGJCNWR6?=
 =?utf-8?B?bHJvOVB2YTF6VWY0UTBMNWc0RTQvZFBhTVBJV3N1T2RTT3lNVVZ6KzFkU3Bw?=
 =?utf-8?B?N1ZiVjRVVEphM1FIU1ZsZEpTY2ZtZENHUmpwdnNVeG5BN2Y3cXNaSGRRWkR3?=
 =?utf-8?B?dlQ0KytDRDJ4cEZSVTBhcW41aWZkazhUYUdxUHkxWjRmd3JLNXpXR3ZEZkZv?=
 =?utf-8?B?T040dkV5SThNL081Ujl6VmljbFJmYnBlb1pTM1dObTEzS29QOFdaaStaaTdE?=
 =?utf-8?B?ZjN4T3ZGSjJBMXhyWVIrMjJWT1oxc1JDbXRUMDJEcVowK2tFUXhqbkN5MGJz?=
 =?utf-8?B?citvY0kzaDUrL2hxQUF1VVNwWkd2Z2ZxaFU4MURCZTNQa1pRTWZiM21GMUdh?=
 =?utf-8?B?S3Nabksyb05FOTJjR2ROeUd3ZzlzdkF0NjA5UGZ3WGdMeERkcm9aVFVxd213?=
 =?utf-8?B?akcrOGttZ3FKdEM5YkF2RDlVaVBpOE54YktQRFVybjJvdnRVN3Y5Sml1RlVy?=
 =?utf-8?B?OC84di9scE0wMHpUU0dlODBRWnkvWXZwNXkrK3ZMbmVuR0VGK2dUZmRsUDBZ?=
 =?utf-8?B?UkVqU1hZZVo5dDRYdTI4bExXSy9jT3l4dTNlU0Q3elllUmFGY0NJbnAzbGFr?=
 =?utf-8?B?dlJHa2ZuWnViT1FJaElOby9IRHJxUUlVZzZNeGphMjNqcnVUOUdqRVN0QzM3?=
 =?utf-8?B?MG5jb0FNazM5TzF6a3lSeVZqM1ZyUEhyUVNaSkRQQXJFdUhQMVQ1SDMrTFJ3?=
 =?utf-8?B?RzViQks4aEVpR3Zub1U3RzlGY3RMWGsyelloOXdpcGVVWG9RYURUTTRKRUcv?=
 =?utf-8?B?eFJDaGgwZjVWQlhjZlNuNURiQnp4d1g0RVdvMnR0N050R3dUWmpJelpXTkZy?=
 =?utf-8?B?MHUweTdhMVBuSWVpTVF4d053dUR5cXZLQ0Y3MUdYWnJPWi9xcFN4NGFPT290?=
 =?utf-8?B?cGlvbjlLZC9iNFFrL21xdTdMbUxNeG5KZHFNKzRhUzJBZll1RlVZMk9SZnpB?=
 =?utf-8?B?MjNmOU54anBraFNlLzV4b0RJTy9Fc0V3c1VkMlYwc2JhaEJRWlhYZENYc0dO?=
 =?utf-8?B?TWoyRHRvU3gxUkljcFdHWmQzZGR0cTFxY3gwZVA3dlB0RTg2UTd4SHh4TVpW?=
 =?utf-8?B?OU9ud1ZhRXRFL3QxUTBKTkthbWhiaU44Qkt6UzRkbUpKWm5OZmpkVFpVdDZu?=
 =?utf-8?B?RlMwVjdZeE1JTWtKbjBGSmVldTVYUnBadXArdkI5UGFXbzJ5cEVna0pCS1o3?=
 =?utf-8?B?bnRBMjJ2dWlsQUVNYkxoOXZZMEJ5ZktoY2o2ejZZZEhUQ3dtR3k2aDNCSlFn?=
 =?utf-8?B?d0k4d2NodjR0dzU3cE9VcTdlZi90OEswRmE1SHN3U0YzdnptKy8wNlBSV3I1?=
 =?utf-8?B?akdpTDRVbDR2U3NyRnB3eXNBc1dvNGQxWDNzbTc5QmJ2SkdIdFlHYWt5bWZ6?=
 =?utf-8?B?VlEyL2dHTlR0NHltK0NUd3NjMUpubm5QWC9CS21lTWc4UVpjWGNNMFpXcDVW?=
 =?utf-8?B?bTVlRDNJWmxXQnl3Z0dZRzFJd3FCbWFUbXdseUxDWXhMa2dzdmFWcjREMlRy?=
 =?utf-8?B?TndlMUlWbDdMU0ZQMXFrRlExVXJRU1o2SHNSdlp4Qk9Wa2ZvUWZQbnRHck5p?=
 =?utf-8?B?SUlBeWVONlQ4NGhLUW9nN2MvNGlUOFdJdUFCWlE2cW5WMVMwd0RpRDdHekV5?=
 =?utf-8?B?TnN6UVJLK21rUk0rdjRLVXNIUGt0clk1amlSY2tsSHAvNjU4RFRqbm9uaVVX?=
 =?utf-8?B?N0ZDZDZVNVZmTWxhbHZtdTUzWHRMSE9QeXgyclRvNnFGZEJ5ZHUxRUMxbmY5?=
 =?utf-8?B?cWNiY3hxMk1nPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdac5ef0-7662-417b-89e9-08de6338d4b9
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5551.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:28:07.6434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB6775
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

On 2/3/2026 4:17 AM, Tom Rini wrote:
> On Tue, Jan 20, 2026 at 03:07:17AM +0800, Yang Xiwen wrote:
>
>> Currently, the U-Boot clk framework mandates that clock registration
>> begins at the root and proceeds to children. This creates an additional
>> requirement that does not exist in the Linux kernel, making the porting
>> of clk drivers more difficult.
>>
>> This series handles the dependency entirely within the clk framework,
>> allowing drivers the freedom to register clocks in any order.
>>
>> This is achieved by assigning the parent "lazily". The framework caches
>> the parent name in the core clk struct and attempts to resolve the
>> actual parent when clk consumers call clk_get_parent(). The process is
>> transparent to clk consumers as long as they use standard clk framework
>> APIs.
>>
>> I've run `ut dm clk*` and verified these commits do not break any
>> existing test cases. It also passes the new test case.
>>
>> This feature is disabled for xPLs by default. I have not found a clean
>> way to enable this separately for xPLs without introducing a repetitive
>> Kconfig entry (e.g., xPL_CLK_LAZY_REPARENT), which looks very ugly.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> This, like some previous clk reworks, leads to run-time breakage
> (failure to boot) on TI K3 and likely other platforms (I want to say
> some rockchip was broken last time) as well.
>

It's sad to hear that. Could you please provide the log so I can try to 
fix that? This also means our testcases can't cover all cases.


This feature is required by an upcoming Amlogic meson8b clk driver. So I 
want this to be merged eventually.

-- 
Regards,
Yang Xiwen

