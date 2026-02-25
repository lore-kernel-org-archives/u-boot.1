Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76C9F357D5
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 06:57:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF32E83DCB;
	Wed, 25 Feb 2026 07:57:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="UpWfzciF";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="BldxHuoN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE53E83946; Wed, 25 Feb 2026 07:57:17 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00DA582A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 07:57:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 3349ddb6121711f1b7fc4fdb8733b2bc-20260225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=idaKbpBs/CG044pj4GnXoviZ6z4lmDUuN68x98QKNQc=; 
 b=UpWfzciFVBkHxX5mbg7CBgoFPrbGKEFC3b6Sm/GxegpqG7sFQyJ9udTt0hRLz3OqrY5dqc/Jq506MIQhRdAhpSxxXCkBLz21V5d7lSfLtrMgb/LJv7dYmUU3oaJ49lhhfkZ03CSOPueZBULgzZD2cfYrCzypqAJocyGPggpJF6U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:6e84281c-5673-46db-a551-6b0ee0d2b2a0, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:e0163f7b-8c8a-4fc4-88c0-3556e7711556,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3349ddb6121711f1b7fc4fdb8733b2bc-20260225
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1458654251; Wed, 25 Feb 2026 14:57:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 25 Feb 2026 14:57:06 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 25 Feb 2026 14:57:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUs32gdacWTseJimE6LWMKsK9dwytOYp1SF/zg6T1fwSnIPv8y9MiPFM8UFVDn0CVqRXGeCz/TtvNdQBYt2R03lSNcFpcvaB8/qUEFzxcRpT9YYd/s33Vrsz7N6Cis0mI/dEyAi9KCIrp409Ys6BjF5FoPEyjCWETbgqV8/6E1CyGysen6JfSlk7mAQVyWTl3XAzGLaHDMAIIjdF8chcoUlvzKbbQfQstFekUj07aZ516SKhw7Sy4s9QfCm5vKN6FwUv4IhLXxy2aacbFjhlD0b8tW+sJ7buIH9DwvKfo0JWaOIuJqL8fEFRgv7Bk6Bzy3k04PS735RwUsEtGvBsuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idaKbpBs/CG044pj4GnXoviZ6z4lmDUuN68x98QKNQc=;
 b=XCp5kwzHPn2UMp0yiNJSAVGHmJBUNXIaXoXKcXDs0teMlOTD+9lbHYismatFker1np7067z5vZB4l5GVPrK5FF+fIMjn9XLMsW2hCw8Thx7yNkqPeSFFR6L0ijzMUwUhZ9q49linPV/FjgtQOMCN/sntErJ2hqcM5EdxEt7hjx5mCekIlfcGX2zae2QIc6H/kw0gkUSlMerJkDOCTbEpqkdgplUccm+sJr36yt+V+FKl1B9mnUEggXNreiKd8pbMploCJ90tKclTcKh+FBZFCKX6C4KsoborIZ/C2W860nNJ1E4btZNrAv/cn3RO6c1Bd5dfvof7I4iAsj2eIZ3AXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idaKbpBs/CG044pj4GnXoviZ6z4lmDUuN68x98QKNQc=;
 b=BldxHuoNU4Io2tq4MJpNczT6CeiL0lakJcrLzspzR9q9oGaFplSiSMiRPrAbhrx9n2bIuCrxRQowVvmC31IYNVNPRW4IrnZRLNUraa6Be+zWo5lc6Keemk1Db/bE5UkPh1wclLjlRqLMQWXnXazpYgyYb9bu+kXvVLR5mjUmV2c=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYQPR03MB9430.apcprd03.prod.outlook.com (2603:1096:405:2fb::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 06:57:03 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 06:57:03 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/3] pinctl: mediatek: increase max number of base
 addresses
Thread-Topic: [PATCH 2/3] pinctl: mediatek: increase max number of base
 addresses
Thread-Index: AQHcmh4YvjCadr4DlEiHc4AeH3pJz7WTE6YA
Date: Wed, 25 Feb 2026 06:57:03 +0000
Message-ID: <e7587ca4aa6ae18fde99faeb399fad914d418549.camel@mediatek.com>
References: <20260209-mtk-pinctl-mt8189-v1-0-a7a3069eda6c@baylibre.com>
 <20260209-mtk-pinctl-mt8189-v1-2-a7a3069eda6c@baylibre.com>
In-Reply-To: <20260209-mtk-pinctl-mt8189-v1-2-a7a3069eda6c@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYQPR03MB9430:EE_
x-ms-office365-filtering-correlation-id: 3b28bae3-ae1c-464e-1b47-08de743b14b9
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VHh1R3k1dG04RzR4ejVYQzZPTjgvZmdrSVNkYURTbTdXdzd4OUoySllGbURx?=
 =?utf-8?B?RjRoSFNXSGhXRnpCSWFOZFQ3OTZFREplbm96aHUyNUw5OHYrdkJLWTNKSGV0?=
 =?utf-8?B?MWM0R2R3cFJQNkE0UEt3SUN4TXNESDZqcGtFbXB1ZVFIdzZpSUQxemZVMW1x?=
 =?utf-8?B?MTRqYk1jbjN0UytPU05IZUJxejZZbmZ0WW96SC9NanlrcTFVSjJ5N2VnUGhI?=
 =?utf-8?B?MFdPTlREc3NjRGIwNVg1OGxjSmdGM2U0VjRDdmRHTHJlVlBrbG1rVmRzdnM3?=
 =?utf-8?B?YkpBTkk0cThpTms1aVQ2aHB1VU1PT0RudVhFQ3dDQVIzN2d3YlR6M2RCeDdX?=
 =?utf-8?B?T2ZaYW40ZisrVnBnOFd4bEtrd2gvU1FYdEpBR1VmZU9kUHN0dFlVQ2VkZ0l2?=
 =?utf-8?B?MGZ4Nk1CaDVkME9kQW5nS0N1TWgvbVpBL2syTTVEclg0Q0JTZThzTHh6MVRr?=
 =?utf-8?B?Zy9zOFMrWkNxUVFGUGF1eG5JSklQbHh4NXBXcUNZM1JHVFExZ2RtTGlQZFdw?=
 =?utf-8?B?YlB2bTN3Y0NETXhOOVpoMFQxTVdGYTNsK1YzQjJQdzZOMjhIaXEzOTdBOTA1?=
 =?utf-8?B?K05FYlZldWZFM001TktvUkNMb1lheXF0a01oakRVaGhqdm5UaEwvMDAvQmpk?=
 =?utf-8?B?Wk1iaEllcGZ1ZXFhdTQ3SFVCN1czVXJURzREZXdBQ01VOXQyOHNrcW0wcDds?=
 =?utf-8?B?WXkyMHpvVUlOUlBIU3V4SnpyazZzQjJwOTFZQXVNOGdndEpKUE9ETURGU3VJ?=
 =?utf-8?B?b2RPQy9WOU5RTHNjY3JjMlZkU1c3bTEyZHpLMXo1MlAvN2tscnAvZGVVOE5J?=
 =?utf-8?B?UTJCcllYOVlWMFVoenMwcmgyTTN5UmkwK2x3WmlhajRJOFkrbnJjdTdabGcr?=
 =?utf-8?B?cW5aajNncC95YmxDUnQ1cmZQMGswb3lZOFFRbVRDYlpUVHdkNko0eGsxSmsz?=
 =?utf-8?B?TE1ieHpVeGc4eEU4QTFlVDRzNFFIam1uOXZtL0dXampGZG1UbUdYRWJ4bEtt?=
 =?utf-8?B?NCtDaHJ4V2VJQlpubURoOTl0b2g4Wi9ySVp4am93bzZMZlpHbVdJK3Z3d0Yv?=
 =?utf-8?B?cGR0RWVwbThTd3BvSGkvYTBHSXBZTFhzM05PTVc5YWVTVHV6TFFNSUphdTY5?=
 =?utf-8?B?amtMYnJoQUlhVGNpYVJpUTN1cmVQU1NIWFQyYzFCY3F6TzB4ekxVNm93cmZn?=
 =?utf-8?B?VjQ0Vk55VjlNVkJwS3k2NmdqZWNXT0p5Z0NWTnJCSThKbksreFhLa2FFT2h4?=
 =?utf-8?B?OGlnTkRiVVhyU0dJM3k1bHBZL2RkdDFCZmVPeWg0TUdoU1Y1OUE4WG5sQ2la?=
 =?utf-8?B?ODQ4bWNSbXUwclpMaVdCTnNERkFmckdKV011c0dNNHVPWHUxbytVckNNU2lt?=
 =?utf-8?B?WkNMWG03Z2xZbHhQcVNxazhnaVhDM0hzT3REcVNDaGFKUXEvek5hUW8xRXA5?=
 =?utf-8?B?WE1pOVpMSE50SHl0ZzR0UWhndkpWOVlIWm8yQVJ4Zm9VWVpha21EQ2g1dE8r?=
 =?utf-8?B?N01iUkd5S2l5WUtnb1Q5bHVmYTByYTJHSTVXUXM1emR5MWwrOTdaZEx2a3Q1?=
 =?utf-8?B?OTBOM1dodnlNOWpLeVdDSFhzb0w1dnVSVmUxTzViS0E3Q1l5UTYzUWFEWkdy?=
 =?utf-8?B?M0IrRlM5ai9RbjJnb2JkSzlkbUhpSlNnZmV6L0E3amtOWDFWNktDZHg5SXd1?=
 =?utf-8?B?bW5BNnpUVStiOEFSZ216clA0ZjBVQnI5TS9Fd1VLTUVjbTNrbGV2aXpxcEJv?=
 =?utf-8?B?d1RydU1uQ3JhNjVjMzJFS1FReE9KdkxDSkJqOWdzaTdOMDZuSXJqWTk4cUYy?=
 =?utf-8?B?THY3QTZIbTIrQzZIZkltZDdGUHEwaW9Va3EzZTFub09GSHpCZjhYdWJhSUYy?=
 =?utf-8?B?alBIUmd1UUdTVkJEdDZCR1dVTW9ndFFGZk5CMmNyaG93MFRiUjhRZ3A0Zzl5?=
 =?utf-8?B?cm52cTlsMGlkcUg4Y0tHSkVTUjJsUUVEbVl0bnVtcVphUnJWbEdTUHRCa2lw?=
 =?utf-8?B?ZjN1bk1uNlpxOXE2NXo2WDRucndWanZlMDNBME5rMVIzaWZPdHpVK2JKdWUy?=
 =?utf-8?B?RndxUGdhbHlId2J0K3BCUWhqY1puSHR4aWhyTXpZZUcrbGRMalFtR082TW9h?=
 =?utf-8?B?bU4wdHJoalJiTHdWTVhxcXNic0lEQVg5T3lCME9aVTZ2SUIySkM5dVpmMWcr?=
 =?utf-8?Q?L/24MsNsyjfCjeRBCEhxToc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rlh1cExDV2JHTE5CcWRNMTJqWWdTOU9lMXJjbzVEdzRLWHFpY04wYnZRWFR1?=
 =?utf-8?B?amxJR09DMUQ2d0NJRUljR1VzVnVPZ2xkRjZOS2ZGR1ErWnQrYkNpMDNCMzJE?=
 =?utf-8?B?aXNaVDhQV0dEajlzaTVBWHZKZUhCS2lUL2NVNHp0b2JVaDBEY0RHbWlVaWla?=
 =?utf-8?B?TWVIdE1ya2kzRlJSbWVic1lab3o5WTRjL2hFeTRzZVRBdHdSZEtHWnhsc2Fq?=
 =?utf-8?B?OXlHRFpQQ29kNFlHWm1sWXl6Si9MenkzUFNVZDJNejBuQ2tGc0pySy9uOU9a?=
 =?utf-8?B?Q3BUb0xDVWY5OUhmQ3crNDZmakFIUXJsNSsxYStOUUVnSWhRQ1RKRVU0YWM1?=
 =?utf-8?B?WGpTblRjUDdQajN5a3pHeHZpeTVPQi85dUd6OUwyWnNZY2oxVFg0aEdNNGRP?=
 =?utf-8?B?KzA4UmRvNG8waSs2N0dZRHAyTzJ5V1B6eFhMRDFSYytrZ1h5dERUTWlRU053?=
 =?utf-8?B?SmlXYWlldjNqTHlva21LLzJNQ3FUcVpDZGw4cG5EMStWWmJ6SWJ2OEdYWVcv?=
 =?utf-8?B?V1k1SXM4di84bmo4cWJVN2t2Um9lZjg4RnB4K1dZNnF4OFdNTXFYVEN3MS9F?=
 =?utf-8?B?d21KdXlsWVkzY0JXYXZTZ2h2ejdkMG4rRGhuaTBtZEdpcmZtN0JYbWhKUS9G?=
 =?utf-8?B?TnJMZVdpOEwzZllES251MFdlTjY2Z0h0K1BLYURpL3VVUzJnVlJpOUVWV2tX?=
 =?utf-8?B?cEhUbzRORzFxN0h5dEV3K3B3d2RwQnhtM0o2QktOWlE4eGExZ2RMWnErV0JL?=
 =?utf-8?B?Rm5aeDBJVXluLzEva0c1enl4YVB3V2dNQXEvVHlHSmJpNzNiM2V2aE9BemhB?=
 =?utf-8?B?NGNSSGNXUFhsNEF4NGpYZUVtQ2VROENzYmQ3WEl2MjFoYmk2bWkrUHg1aFhx?=
 =?utf-8?B?SXJSMFZSYzRYVXV0OWQzU0pVK1VLL1dGek1OblhqQUtzUWkvZXZZYjZIb1Ez?=
 =?utf-8?B?RHczZkc3SHVwNFE2KzJYdFJvd0tEUitEbDk0SkFOZk83UHkxOUlIZFNBOFNW?=
 =?utf-8?B?WW9DYnoyV3pwWk80QThjZCtMb3NTK2NQWVk3UjhHd0RwdVJvd3BpZUVtdHcr?=
 =?utf-8?B?eTJFb01jWit3VlZNTDlacTFLeUZjNjlPMkw5dW1EU0l2eTRobWNxVDQ5UjZy?=
 =?utf-8?B?TnNSSVBvcjFCbHVmVlhqMm9JZGFLSVJ4a05Hak5JUGg0dXpjRXY0UVJrTklC?=
 =?utf-8?B?RWVxaGFjZjA4Qmo4U3JuaStCYVdEWk9DR0tIenNXa1lxMHlQaFRlbzZuNnp2?=
 =?utf-8?B?TVJQdGRURGlBV20rRXVRaVhlditWRHJWeWNOa0hPQVlxOEp1RDZFSFdnRU1w?=
 =?utf-8?B?cGhKelRBY1VKYUJDYklvTG1ON0s2c3ZvNU8zeURpZWJYMmJJRjdQblVqTVdG?=
 =?utf-8?B?Q1dseTNFUG01K3lRaFkzMVBtdEZTUURUaXBLZzh1Z2tzYTF6R2JwSUFiV2Fo?=
 =?utf-8?B?dTVBeHE3RDZFZFl3RnRRWllCbmYveXk1UWxqdDV6SnByQ0pta2dzcEZzV0xl?=
 =?utf-8?B?cHhiNVVDWUlKeDJaN0hESjJTMmxzR1Nzb2tZOGYwMklId1p6QUM0QWhEdzE2?=
 =?utf-8?B?eFljWXV3TURsSmlZbVN2QVpvWWdVRGsvbXArc0kwMEZaK0cvK2V0czFqNG14?=
 =?utf-8?B?ektaUjZxV25NUHlXUTZ2WnUrL0V0aVNEMC9EaDhZTWdCbVA1REpONGhNLzQ0?=
 =?utf-8?B?Y1kvMGVrYzlzVmZqWUw3L0lQTll0d2JNeFZqdUVBcVdJSkR3NXNWZ3grUTAz?=
 =?utf-8?B?K2x3WkFkSFh5bkZFTHg0SnNwTUVpenNSd2ZTRjJOUDlYZ2tZczFpUlkrY1Br?=
 =?utf-8?B?VkRrMWZCbk8vMVlGdDRmM290YW1neFRuU1BLSUwxNFNydytTRWk1cTNRRXNu?=
 =?utf-8?B?S2RWNEhrc2lMUjNyMkhhaWpYUTgwc1BtbjZIdFFpZUpIanRZeGEra3lqL1BO?=
 =?utf-8?B?cUxOWUxRM3kwRmlxM0tpeVVyOTNIaUZIQkYwMUJLZTJFTExJOGtWUCtpZnkz?=
 =?utf-8?B?WncrU0JTTWp1MzRLYmtwTDNFOWJEM1NrRy9hV2FSTFZMVVpFdEpZTkRQdUQr?=
 =?utf-8?B?SWloVU5ub0p6emliUm0yd2EzNlJwdVZUOEpZRmE0VkJwNGRuV053a20vbldE?=
 =?utf-8?B?R3c1YXFuODk1WnRJOVIybURpbE0xOUcydmViZXF2ci94Z2hhRjJvbThiY3RS?=
 =?utf-8?B?RUFuR2REUjQ3d0tKSW5GZ3ZUazVUNWhRK2o2VStUa2M0d1NmWDZMSlZEaXB4?=
 =?utf-8?B?ZWY5Tm1seDVLblJpblRCQjlTSExQdjBzWlMxOXhaQnlSOXltTUY4R1E1NjdP?=
 =?utf-8?B?QWR1SEdqWkFhNDM3ZVFCOHNEbHExOUtuU0g2NmZ3bGd5c05pbmJaZmVURnF0?=
 =?utf-8?Q?xK88Kt0tUGPbVttE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B095CFD3CF79454886D9B43B41AC12B5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WP0BGVlh9FwbY0w9IXmhxAwyA4aMSk3EFBFTaCdJda5PlRJqg7e1YiV4tnz1ppZz4jrKjQ6fZmA0eoYIOQEeNTAcvU62ZHhTE1A1h2NPA+fgovYq+KuG3CldKIlq+/X4fgf3qJC4SC+ALhXrlwOf/x/Vifn8ojjKublhJGiw3t+qF4rSeBVRL3u4gDUfyrlXQmiMlVmPjhOPAWxj1aQS0xsXzF2ihd4H2YjMdof4jviJJSIWLTD5DRcns8KE62kzLsIM1Gf5Mt/+o7i1SI2rhyEv2ZzwoXgRkiRYPMhCY3amNZqIdS3w1IBpqkcXVJiuG9Yrw6LWEi4XN8161tN3bg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b28bae3-ae1c-464e-1b47-08de743b14b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 06:57:03.2322 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KcdKAIWMtDbgdM4/1XRf5puODYElVpw98D2m4Qy2j4hfZDeI4ilCx8AdhmIBpT6SfXMBzfUh5LM0j5FF1WjLtkrVgKloTqhQBUQDVFRYk8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR03MB9430
X-MTK: N
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

T24gTW9uLCAyMDI2LTAyLTA5IGF0IDE3OjM0IC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBJbmNyZWFzZSB0aGUgbWF4aW11bSBudW1iZXIgb2YgYmFzZSBhZGRyZXNzZXMgdGhhdCBjYW4g
YmUgaGFuZGxlZCBieQ0KPiB0aGUNCj4gbWVkaWF0ZWsgcGluY3RybCBkcml2ZXIgZnJvbSAxMCB0
byAxNS4gVGhpcyBpcyBuZWVkZWQgZm9yIHRoZSBNVDgxODkNCj4gd2hpY2ggaGFzIDE1IGJhc2Ug
YWRkcmVzc2VzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJA
YmF5bGlicmUuY29tPg0KPiAtLS0NCj4gwqBkcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3Ry
bC1tdGstY29tbW9uLmggfCAyICstDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waW5jdHJsL21lZGlh
dGVrL3BpbmN0cmwtbXRrLWNvbW1vbi5oDQo+IGIvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3Bp
bmN0cmwtbXRrLWNvbW1vbi5oDQo+IGluZGV4IDE1YWIzYzFiZjA3Li41OGYxMzYxMzYzMyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtbXRrLWNvbW1vbi5o
DQo+ICsrKyBiL2RyaXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLW10ay1jb21tb24uaA0K
PiBAQCAtOSw3ICs5LDcgQEANCj4gwqAjZGVmaW5lIE1US19QSU5DVFJMX1YwIDB4MA0KPiDCoCNk
ZWZpbmUgTVRLX1BJTkNUUkxfVjEgMHgxDQo+IMKgI2RlZmluZSBCQVNFX0NBTENfTk9ORSAwDQo+
IC0jZGVmaW5lIE1BWF9CQVNFX0NBTEMgMTANCj4gKyNkZWZpbmUgTUFYX0JBU0VfQ0FMQyAxNQ0K
PiDCoA0KPiDCoCNkZWZpbmUgTVRLX1JBTkdFKF9hKQkJeyAucmFuZ2UgPSAoX2EpLCAubnJhbmdl
cyA9DQo+IEFSUkFZX1NJWkUoX2EpLCB9DQo+IMKgDQo+IA0KDQpSZXZpZXdlZC1ieTogTWFjcGF1
bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzIQ0KTWFjcGF1bCBMaW4N
Cg==
