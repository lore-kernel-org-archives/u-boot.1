Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6100E77188
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 01:06:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3990B8021D;
	Thu, 19 Dec 2024 02:06:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="NmwbjKhb";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ZciHMfo4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CA98801F5; Thu, 19 Dec 2024 02:06:15 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 778A78021D
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 02:06:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 68aef436bda511efbd192953cf12861f-20241219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-ID:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=SmPjWvAiyQst6hDASvOMmLebyq84yITemDXxuHK8oYA=; 
 b=NmwbjKhbOlGA1YqA41kp/egMddwVJpnKM1Mxun6ao8VVXdrK7JDHpLzsvTV58hmoxrZcZO9qXWLs9rlAv7wo8h7bhdFTMk+s1uOLdBJIWKOGmGACEebAdY4Wt1jSlWAwlpBXmO1WYW8ZNgIgfijXVfWZVOFMc+iJwVdLm+FL7uE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45, REQID:a01e155f-1a78-4b5b-ae3e-64ca95eb08de, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:6493067, CLOUDID:fe00bf28-d2eb-4de2-b5c9-495d1bc17256,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
 :-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
 ,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 68aef436bda511efbd192953cf12861f-20241219
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 455055085; Thu, 19 Dec 2024 09:05:59 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 19 Dec 2024 09:05:58 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP
 Server id
 15.2.1118.26 via Frontend Transport; Thu, 19 Dec 2024 09:05:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1qGXj3eyZjxPId9x3m3XGyla5UGEEAgDuP8LOgOGfeRJl6XQ06kOql1O8ERLpMEWfKbI37KB17etNU44579CIeYMvdCIT5F5NWNdcafr6tGIBigaTeULbNGuLZjA7TS9XxnXrA9FrL4OOs0xMnoFPcaRosDTcUA7GJy48f9FkuK7cowBut2dUDvSvdaqascJJKxuf/hZyJcywHWQ9eFTmP+dAGSeFrJgivy61qffNJFue47ot28EWzlxdc2UyMeZUcbGa/iIh54NqfR+GBGrfF5pVBZ7aY4OV6SiIqplCX3fDFXmPPTPp/gjrIAKg8LAP9PmozGIVx7jeneBwzOFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmHpl6snWkdGOqvYdZ9vvGJdDcTzPvwqnYQ29J9XUy0=;
 b=nqMaH38sK+S4Dv9TP27gr/ahKfCyrytH3e5QtklVAu+bTXSavR+fDjlY7/+a8dn3PhqwlMzKVW1n2/cjL1obW66Xf1t8AEmc/r6KgLQuIBmxuHVvNYGN4rf2SxZ/vSq6wbY0dxABOE8sFP9+V/G4grP+iSRlj5R3SE3EmuohwZM9hRhzRzevUzMj/AMi1nTRB1JrqvHJVIrroq/0NOipJP55nwy0wgGkP8XX4HHTZEgmnVMwR42nSlvWpAs8BmVeztsaz6hxdH4mCOTpVu3p61BrTAFQcCvQ7kAynNQVWEH+cbyDSqOf6NQ3b/jX54w4AThZSFNZE07syz/EXpgUzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmHpl6snWkdGOqvYdZ9vvGJdDcTzPvwqnYQ29J9XUy0=;
 b=ZciHMfo4o/nx3T5KTktzE4KKqQDU9YCkuImv+ap+nx4AYnC3IkjaTA4bVBF3Y/FAZ3O5g7ea92RT7d0wiTHR2gkzYuSi3KMFd5OV3I4gcU7spB7P4YBcs8TCCppvWyvrHpDT2Q9eK0sGkLUkz6X98b81FwFYeL9cPCVAig3vWnw=
Received: from SI6PR03MB9045.apcprd03.prod.outlook.com (2603:1096:4:23d::10)
 by KL1PR03MB8374.apcprd03.prod.outlook.com (2603:1096:820:137::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 01:05:56 +0000
Received: from SI6PR03MB9045.apcprd03.prod.outlook.com
 ([fe80::53c9:58ef:a15f:6183]) by SI6PR03MB9045.apcprd03.prod.outlook.com
 ([fe80::53c9:58ef:a15f:6183%7]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 01:05:56 +0000
From: =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>
To: "trini@konsulko.com" <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>
Subject: Re: [PATCH 02/10] arm: dts: mt7629: fix sgmii clock selection for
 ethernet
Thread-Topic: [PATCH 02/10] arm: dts: mt7629: fix sgmii clock selection for
 ethernet
Thread-Index: AQHbUF8uuQgGU5w6uUSaybREylnR57Lql2AAgAIsLwA=
Date: Thu, 19 Dec 2024 01:05:56 +0000
Message-ID: <736f5ee9cf318dfb787caa7eb9ebd649dddd3e56.camel@mediatek.com>
References: <cover.1734406967.git.weijie.gao@mediatek.com>
 <0c13bda7a1809c7bc6a6782b4f942670a9ff10d1.1734406968.git.weijie.gao@mediatek.com>
 <20241217155514.GO1505244@bill-the-cat>
In-Reply-To: <20241217155514.GO1505244@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR03MB9045:EE_|KL1PR03MB8374:EE_
x-ms-office365-filtering-correlation-id: 3f4e13ae-7597-4d91-70d5-08dd1fc94af7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M1RyQTlOMW96RWMwSXFDYTgwNjF2S3p1NUtqRlZob2xTY2Fqd1dLZjY1dU15?=
 =?utf-8?B?TGRvNG5HNzZvcXVEZjJ6emVaaFQ4OTZzeUI4dVFrRDR0amhuMXdJd0tHSURF?=
 =?utf-8?B?Y1djQlNBUVlnN0xSWlNOZjZyQXFpdFh3MzJ5ZnYrV3U4WkplVjdKd1ZQTXRU?=
 =?utf-8?B?QjBlOVBWU2Y0SXFXMmdqQ0pXRlZaZ2NldEM5ZVVJSmFjUkU3bFcybUVpOWhS?=
 =?utf-8?B?S3FtZVZrUE5xLzZnK3JxWWVKNWZoWjlWbHNxQTdHbVFXWVg5MEdoK1lhU0Q3?=
 =?utf-8?B?cUdWOG1wUm1xS2pJbEk1S05hRTF3MHExN1ZCYkJXWldVOXpBSGFWbUI0NGlm?=
 =?utf-8?B?emlnbHVWS1JnT3E4M2taa25BTXg4VlBmWmJsdXk0QWRXRUpwWnJGOTZ4TVRi?=
 =?utf-8?B?MUU0T3JEaCtsZ05QamxZNDlucUpBeGkwanRhbGVkOG44SWhUREVUTVJZa2Jl?=
 =?utf-8?B?cjJtNEF5cFpZUzZ2Zmx0a3cva0NPK0x6Y0ZTVnRNQzQ0enBGYW1kVWlTSDJU?=
 =?utf-8?B?b05uQUVzbzVVTGdjODdJb1drYlNRZ3BOMmJ1dnRkVnE2YlRHOEh6VCtDOWFk?=
 =?utf-8?B?UFdtdmp0MU5GdHpQWnZKUWw3S3BuTkVvZHRjYUpsNUxRUW9kaWFrSElsVzdz?=
 =?utf-8?B?N0F6Nk5UVmhwR1ltUXdaQytSWXd1UUt2MFF4KzNXZTdVaTlndUNXa2FCNmNX?=
 =?utf-8?B?U3MrVzBtTnNkK3NsTXh4RURUb2pCK2F5OEtkUWdUcTFpbzgxaWt0SmZSeGJi?=
 =?utf-8?B?SlRQQ1NUUzNKTnJTWmIvcFBUc1VPUU82OHFBYkFFdnhhOHc3YVkxZklhTGpH?=
 =?utf-8?B?MGJLZlV2OGFieFFsTUgwcW1aOS9VMjhRN0w5U1B4b0NmRXJOM1hDMDYwQllm?=
 =?utf-8?B?Wll3RnduN1R5R0ErRTBIOU5IdlY0SmIxcXZvOUVMR2hNTys2Umsra2prK1Zj?=
 =?utf-8?B?MUdKQ3VreWpuRlVsVWNGbkNyd2xOT1dvb0JvUTJ1OE9XWXN3UGhtNHBHaHdI?=
 =?utf-8?B?dkZvQXg1QWVkQi85VTVwQ3dZZUlHaTIvZHViQkhOVDlOL1grY0N3STZpTDhn?=
 =?utf-8?B?MVlCZjRZclhaaVZOWW9oN0xya2hNSnhmd29hWTd0RHpWaHMvSEdlbU9rdFZW?=
 =?utf-8?B?YjRxZ0pGU2RPR0R3NG52RTJvZGdPQklPbFhLdEc0QVF1bEVnVjNYL3psbmJ0?=
 =?utf-8?B?Wm9nQjZOaEJSY3grekk1TVUrTEZhcFEvZHlUZGltTFhMZGlMNWVWTUc1TTZK?=
 =?utf-8?B?UlhKNzgzTUZOWFRSU2FtOGZ4SUdiSDU5SFY3KzhhZm1VN2txMm1PdzJoNFdk?=
 =?utf-8?B?R0NmVjJXWjFvSFBnWGRoeFo5ZVRhK0tOR1hhTVRXaGtnUll6SWVIY1F5RHRK?=
 =?utf-8?B?Umg3aW9ZcVM3YlM3WG15dVMvZE5FSmRKZjN6dFhpcWV0QjEwajliZ0FudmxN?=
 =?utf-8?B?VHlBanhPM2NYZXlKVzAvcVd0amRWRmRvMHRBOE4zZ296OWVLWmk3VWZaVDBV?=
 =?utf-8?B?UmlpTGFBbzhlai9uMmI3dGt4cnN5a2t4aFBEK0lrVmd5ODNYejJMRWpjRTJw?=
 =?utf-8?B?RElIWkc3bmNZVzNIdVZxSWlNWndnVm9tWkw3dUptODN3aG1BZm9MRmtFNTlx?=
 =?utf-8?B?cTRNWllsY3RneUovSVprNzFwZnhjaUdGbkV4NDh0Q210eHVybEJiMytZQzY5?=
 =?utf-8?B?dUZueVYrbEJ2ZExHbTZ4WHJCcGx2UG5pZnBFcVRzZDRlVVdPajR2Q3JKT2Jy?=
 =?utf-8?B?MHo0QnZNaUdjZlAxejVlbmJTditXWEFkNlRrOU9MNVBBUElLWmlhWlQ3dC9O?=
 =?utf-8?B?YUk3WXh2ekdGWHhpekRnOHhXL2Y5THEvcXkxODVYK3piLzcxUVE2SXVBdEJH?=
 =?utf-8?B?QUV1R3A0YmZvS3lyUDZOaTlTeG9ObTNGSFE1MFFjYkJOeXEydEwzOUVyWmtL?=
 =?utf-8?Q?eGuwSm24nS6Apx1aiA/W9Xkq6DAeNYkJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR03MB9045.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1ltMXlmYTloS0Nzc1VHWVZJZkFJT1FFalJkRkxUVEZaTk5YMTg3VXM4UzVO?=
 =?utf-8?B?bmVkbkZ4QXhUMWRMakIrQkhVVXBmNWFHU0NnY1Jpdy94WDVFMWc4N241dGtm?=
 =?utf-8?B?UHlIU3dLdEhGU1NwRG5nNWE5YVEvZzlyZTNhK0syZTB1MkNhNWRrcS9CUnpQ?=
 =?utf-8?B?aW84UGxHRG4yS0g5UmNMdXRRSlNqMTFZODlLMjBKMTNnV1lkUUg2NzB4UUxj?=
 =?utf-8?B?S0VwWTFFcWIwWWhlOC9uSk82Z1JqZ016blR2R1AxTVVQOVEzRTZ5YUhpMzc1?=
 =?utf-8?B?T2RxdzE3d1htdnI5MGpzTzhWNWY2ZVFRNHVjNFBXTXlFTklMRGZCbGFFRjB6?=
 =?utf-8?B?VS9OTlMxN1N0dDNMc1RjYmVOMGhIVVNPL3lxaWFjY250eVEyMmU1ZEhxQUlu?=
 =?utf-8?B?U3JkZnRtTlh4dW5raTZFMmpxOU5WYUVVZEZCS2tqbWdyQlpRaWdjNTRZRm1a?=
 =?utf-8?B?emZ1akEvNmVjRUNQLzR1UnVNTmNITTM0QUFkZU5JREpVRzhSR3BiN2RQUzFU?=
 =?utf-8?B?NDU0am9tOUswQ1pSNkNQakdseWhjYmkrNlBlWWxMY1AvVHhDMzRPS0F0eHZF?=
 =?utf-8?B?YzNCNStTYkpHeGgzbWkyaHhDTlRpS0c1U0pveUlVbjFmbURReS9KV2pJRjMx?=
 =?utf-8?B?NXBhUmRiUmZjbWFUcTNjS1pGREVoNnlBR1JGK3h2M1ZFZU5LNlZqRDh5US9k?=
 =?utf-8?B?b215dmZUd0FyL0xxM1AvNEpjbWhraEVsMzR2YjZzMkhLUm16YzJRcmJ0ZVd1?=
 =?utf-8?B?d1NXR3dXWmhxMUhJVjQyMmVzZ1lPWXlxdHh2ZU1vOXY4aTJ2ejVMMVdBY2ly?=
 =?utf-8?B?UVhnTGlwVkMvaUpmSGdncTdBSGs0MEcxb1FuQjYvOGFJWG0xdjhkNktUanZL?=
 =?utf-8?B?ekoybG9mdmhuZTBFaGdpdmdkaWV1aEsrVHg2ZC96S2lwNEN0bm5EVE1jSXlK?=
 =?utf-8?B?RFBLYmpYekxGYWxXZjM4UFRVbVd2L2lMOVJadXpJaXdsYTVjR0ROQ1ppWEJ4?=
 =?utf-8?B?N2dYVFphMkRYRTZsayt1R0NHbzA5blZQODhLVUdlMTQzTmk0REdlRVcrWTNC?=
 =?utf-8?B?KzlqYVFrYWhvV2tOdnBVMy9aVHNWTHJOaGptYjgwUmdKQlpsa2g2R3EvSXBX?=
 =?utf-8?B?djZrUHV4Y0R1MFRadVRoVU0ya1loV1FtK2R3YlloMHZYVE5WSDhOL1lwNm1E?=
 =?utf-8?B?VFpWVnorY2VnM3FhczFJMEl3cHhGcVpRa3pKaWZiUEhGSnhrK1YzblBlTGhE?=
 =?utf-8?B?akRMQ045VHc2VGZ4UnlQTVJieTRjajFiU0lKMHVhdzJBa1Nuazd1ZEszQ2Nn?=
 =?utf-8?B?azd1TXRMZFlVQ0tNRGthaVd5aVArWGlnWU5UY3RyZ2lBTE9PL2FBVm1EVXY1?=
 =?utf-8?B?cU54blQ5VEdEL1pzZEY0eWRQQjh2SHhNNlZhQ1c5NVF0R2Y4ejFuL0FCWVpz?=
 =?utf-8?B?NDE0Ry8wZFMwZlJRVFEramlvN0VVWks4bmVReG5JdFVvMDM0MTV2MC9jMzEx?=
 =?utf-8?B?a0lMNFU4SnZJUjc0bEJ1RlZjRUZPQ2liM2puUDBtKzVPbjBuYTFNWkt1TlBy?=
 =?utf-8?B?TjVleTdXMEVBWnNkemZCWGYyNE51eFdXaTZtVmJ2Y0EzOTB5UEI2MXVSbUhZ?=
 =?utf-8?B?VG5WSWNQWkI3RXhQeXBjRkt2Y3YxTHNCU1kvMEtkWGQxSzhHak11V0JhY0ZG?=
 =?utf-8?B?WTVianlGOUxoRDNQL1RpS202NEVwbVREeHloa2hSVWdCeUJlaFdiZ2NEYmhN?=
 =?utf-8?B?QW50ekMzTzdTR0l4TC9EbHdvNTVPQnc2Ni8xWHRXUjhNeHE5YjNaNXVOM25x?=
 =?utf-8?B?TUsyVlVvVldxWmdGcjI3MmZIcnhsZU9MQ2ZkQm1tSTM1RnRUYm5QSVZ2Rzhk?=
 =?utf-8?B?RHJCLzdYL3NtemYwcWdXeHZhNFhuZHVmOTlOR211aFlRa3BYZEI3N2c1SWZD?=
 =?utf-8?B?c2JxeTF4WXBRMlZ0RVZHWHAwUEt6alJZdTBEdVV1Ym9Fa0V4TnN3VmhKUi85?=
 =?utf-8?B?RjBDVEFnamV1UjljUHVOclhDbFdML09oZ0ZESEVQRExGTnMxM3RqZ0I5SkQ4?=
 =?utf-8?B?TGF1V2prZXhSSk1raVBSUVMyTjk5S1BieG9zbG5VRTVLWUR1N1duM3BSMHpW?=
 =?utf-8?B?WGgvYVkwV0hnL0FqMWE4TFozdklXemd6dW83enlDU0ovdE9pNmZUU0tDSnV5?=
 =?utf-8?B?UGc9PQ==?=
Content-ID: <592E4D5FC6705A4284D62319AC77671C@apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR03MB9045.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4e13ae-7597-4d91-70d5-08dd1fc94af7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 01:05:56.2621 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Opg6xMp4mtt5O+fDbIoExOLtt3kG4fIZaDyxFXafZw+yULiPzwUytFWUn4pJ+llTU9iIR94HHSQndDo66qOS3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8374
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

T24gVHVlLCAyMDI0LTEyLTE3IGF0IDA5OjU1IC0wNjAwLCBUb20gUmluaSB3cm90ZToNCj4gT24g
VHVlLCBEZWMgMTcsIDIwMjQgYXQgMDQ6Mzk6MjBQTSArMDgwMCwgV2VpamllIEdhbyB3cm90ZToN
Cj4gDQo+ID4gU2V0dXAgY29ycmVjdCBwYXJlbnQgb2YgY2xvY2sgQ0xLX1RPUF9TR01JSV9SRUZf
MV9TRUwgdG8gYWxsb3cNCj4gPiBzZ21paXN5czEgd29yayBjb3JyZWN0bHkuDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogV2VpamllIEdhbyA8d2VpamllLmdhb0BtZWRpYXRlay5jb20+DQo+ID4g
LS0tDQo+ID4gIGFyY2gvYXJtL2R0cy9tdDc2MjkuZHRzaSB8IDQgKysrLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBXaGF0IGlzIHRo
ZSBwbGFuIGZvciBzd2l0Y2hpbmcgdG8gT0ZfVVBTVFJFQU0/IFRoYW5rcyENCj4gDQoNCkFzIHRo
aXMgcGF0Y2ggc2VyaWVzIGlzIGZvciBtdGhfZXRoIGRyaXZlciwgd2UnbGwgc2VuZCBhbm90aGVy
IHBhdGNoDQp0byBzd2l0Y2ggdG8gT0ZfVVBTVFJFQU0gbGF0ZXIgKGl0J3Mgbm90IHJlYWR5IHll
dCkNCg==
