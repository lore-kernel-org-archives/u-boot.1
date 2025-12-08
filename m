Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FAFD3ABEF
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 07:22:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 510C38397D;
	Mon,  8 Dec 2025 08:22:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="P8417wi7";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="lN0LyOVR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A33188397D; Mon,  8 Dec 2025 08:22:49 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FDC38397A
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 08:22:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: ac6d1ec8d40611f0b2bf0b349165d6e0-20251208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-ID:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=xZ3JrUw5j5WNh+yI72AyABhyJsPFI9xx0jDwwc5YexM=; 
 b=P8417wi7Iz5vrK9qbBYocUBp4DMJZVcw6BKaHlbriRnu1b3RlvlXWiKOjc9Wzp/HLcli+z5oNJYzHvKawYuCllvewzg+Z5MwuHk+ZZPZ7/y6iMDWmdIhNeuVxVBROA7Y4/ChH8BtyxQCG/tHiTWF15Ow1AWP4V2hVK8DXmoAcck=;
X-CID-CACHE: Type:Local,Time:202512081522+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6, REQID:48b49191-28cc-40fc-9746-21862e318db4, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:a9d874c, CLOUDID:29584528-e3a2-4f78-a442-8c73c4eb9e9d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:1,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ac6d1ec8d40611f0b2bf0b349165d6e0-20251208
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2014003951; Mon, 08 Dec 2025 15:22:37 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 8 Dec 2025 15:22:32 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Mon, 8 Dec 2025 15:22:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGCHKWdXj06a8vy9GFbQFX/4DneryjxqdFNkQLJqkpJDKbaGVj5+H8CiO2c+JnbqtS1nqLvYL9m4LhajogvczHGZIdX31zjQxLEMj+z826kk5P5vALK1jX9WcmCW1ElugscoAhupEgI7ste662OGa0HDjp9+jD3hvhLNIuQcItvJfDmAYv0PtYM3OfE6i0e6M/HVAAJ26zH01a7JqHcW9u8l4Rhbh03f9/v6BeK0/Nw/CIC1iMz/NZvomNLbjRVicnN1srZHRTqKwXC071YKolh00KWAboctk9MbnzyDBTfd/f5Kkthptr9+k90m/3vM35aw+PcQaAONpng6MhfX9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZtwnswwxKp0awhWCDMgVebBvPrxziX/79xSj6dVrdc=;
 b=QZDVlCHGlGy/Is+MmltBFZqAy1HKHMkpGdUv8veRvpmKPh7ejV7LRxLco2LJYGfMp1eBl8RR3Wf/GiPs1iLFfaro8SciRqV3Mpeb3bybWWQ/XKTKbCSYh4lP5t2rrwJkp/PGhfubHtmzqeYJkN7Q2yWjiGDpDDcVZ6LjXetGM0tIu3zyOaYmqG6IGUaE94TDkZKvayGezomK9hv/Cy4W8iey3Leo0jJh6zyV3gQuzjxDXGdysM95kg70WynzjxiYMPvpXxNE0EgmCLJYOXHzHCihWNSF5YO7dZ8zC4am4WIkWuXGRk7BPCX7znUZEcDkluWq6UDnHMvZabNK/Xs3RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZtwnswwxKp0awhWCDMgVebBvPrxziX/79xSj6dVrdc=;
 b=lN0LyOVRG6e9/3oXU38LTpJxEbt/ynMNJWWZFFG9nvausFzCWN58u10VSKPe3+NWRcXg1l5dRYRZ2FfDkf+a/T5p8VrRwqIlfCfIp6JbJViJ6zBB2kDBpKUJYQHTg/lfpz3oQ6eUDTgnXcQFqyvBccldL3cSb2hEtSu//W88uSQ=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYSPR03MB7649.apcprd03.prod.outlook.com (2603:1096:400:42a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 07:22:28 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 07:22:27 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>, "David
 Lechner" <dlechner@baylibre.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
CC: =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>, 
 "lukma@denx.de" <lukma@denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>, "seanga2@gmail.com"
 <seanga2@gmail.com>, Ryder Lee <Ryder.Lee@mediatek.com>, "macpaul@gmail.com"
 <macpaul@gmail.com>, "semen.protsenko@linaro.org"
 <semen.protsenko@linaro.org>
Subject: Re: [PATCH] arm: dts: mediatek: switch mt8365 to OF_UPSTREAM
Thread-Topic: [PATCH] arm: dts: mediatek: switch mt8365 to OF_UPSTREAM
Thread-Index: AQHcXjRa9T3F2dZmkkSZPFazDnk52bUSbtIAgADIKoCABDNpAA==
Date: Mon, 8 Dec 2025 07:22:27 +0000
Message-ID: <cbb7164df669bc2fbdd20456db756cd823b1095f.camel@mediatek.com>
References: <20251125-arm-dts-mediatek-switch-mt8365-to-of_upstream-v1-1-707eee6dfdbc@baylibre.com>
 <7021158b1829c5daabf62b1901a8b4988a940a92.camel@mediatek.com>
 <0e33d7ce-5b72-4edf-95c0-799acd445c19@baylibre.com>
In-Reply-To: <0e33d7ce-5b72-4edf-95c0-799acd445c19@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYSPR03MB7649:EE_
x-ms-office365-filtering-correlation-id: d3ae75d6-47da-42b3-2eef-08de362a8a70
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?blRBaDludkVuMGJrTFZWTm51YW01M2FJN3VlNUpLNE1lMExwdkNycFNzTHpt?=
 =?utf-8?B?b1RrUFQ4ZkIwVWUxQzk4UWtVUlZOdm8zdFVlayt3N2ZGRXpVLzBhN0JpUVZh?=
 =?utf-8?B?eDNsODlnTjdIRjM1VFd6MkFyVzJvcXdZckZJMDU2ZmthRHk2VU15aHB2a1B5?=
 =?utf-8?B?RFpicUV6Szkrdzl5aC9tc3k4RFV6VExMOWZjRS9lOUpEZHNadUt3T3l5NTR0?=
 =?utf-8?B?QTh1WmlCaXBQdG4xU2Q0YVE3WVR2YW13SXZ1RWtuM0xkNU1vQ3NOOHdEczRs?=
 =?utf-8?B?cVZNcHdwWHJHczZwc2lQYnhaT3MxOUUwYnM0SE5SS1R0TnlaUEVsTzFzY0Zv?=
 =?utf-8?B?THhKUnhaSjQyRDVIMXJsZXBEMU56SUN3ZnRWeUtsT3JUZno1TGdoY3lJRmdh?=
 =?utf-8?B?VytkcXFUVjIxS3B2UFBwek5mOWYzZW15ZmY0cWdldXUvbGhheU5MekMzWUVZ?=
 =?utf-8?B?WFdCSERtOENiNllCV21uMzczWXZ4MWxPeWxjOXRkLzM5NjVMUDBJMERsbUky?=
 =?utf-8?B?U1JsWHg2NU0vNkRZeGlKcGloaTBjZnpuL3RxWU9qMGVzTVZnRHd6blpsbm1N?=
 =?utf-8?B?VU93QjNmMklYQVYzTzB2bzRuNnRkYmJNbytiSkhYTEhCQlBYN1QzVXRJUFpJ?=
 =?utf-8?B?d0wzRCtuNXZQR2RYT0FQcDRHVVRsakJoejQyNjRkUUErWjNJTTJqWndYdHkv?=
 =?utf-8?B?NVRmVlRkRHJOOFlZeHVjWTN5NHBSK3MvQVExUDlidUZOU0tUWGQxaU9uNDJQ?=
 =?utf-8?B?OEtBRDhQdVhkVXdkVjAyU2JyODUwWFhoQ244c1FqTWZUaXBCTHdkWlA5N3Jj?=
 =?utf-8?B?dTZjQzVNY0lVTG1PbWpxQWk0WCt1cGt3LzkzMEMwS29xUy94R3hwMGk1L3BG?=
 =?utf-8?B?YUJVQ0daTjZFQjFRbUVjcUtZcFZrVWxTSUZSM3Z2VWVIbjdiZHJzYk93eng2?=
 =?utf-8?B?NnlNQ3l4ZUJyaEt6L3pDMFdhWTVBRXUvSXB1TlRkdlo3S1FOMnJDcmpuZUl2?=
 =?utf-8?B?MW1Jc0RiK0k3dXFqRTdPeXlMWTFCbThsWkFCSGVXd0xkbHlNVVpweGVZaUFx?=
 =?utf-8?B?ZlBSSVo2c1RZTGE2NWJaQjg0c3ZESVFmM0QvN3BjUlo2N3crNWtpRnRraEtI?=
 =?utf-8?B?NVF0Qmw3OFd6WU9YcVY3anRXMkljc3Q5ZTVja3U5VTdaeHFWVzRYdG1tUlZ2?=
 =?utf-8?B?dGdBN3FDUE42cXlyUjlPNUZCVUN5OTAxQ3ppU29UNVdLMzJTWUhoeHV0WkR6?=
 =?utf-8?B?enhWa2pLWlJPOTI2UlVQdVZpcmxxTlVGdXZrK0ZTNlBta0dUTDk0T2tWYVJH?=
 =?utf-8?B?bVk3NmVpYk1HRTVhcmc0UnBkYWZVNnVXVjNRbEc3RzVYVW54NHlCamdDVGk3?=
 =?utf-8?B?OEczSzBDV0tZeHhNNCtuNjJBSDNIcFN6alN6cmxIOHdVbGVNMm1DVVczL01G?=
 =?utf-8?B?NmFoNTl6T1FMRjhTWWNlZldWUkZRK292MWQ0b215cVgvZHdHV0t0dGo4RndB?=
 =?utf-8?B?aElVaVFCKzJmdFlyVHVmRU1UelgrSDl5U2pwUEhnOUhLbVQrWkh3ZjJmazZI?=
 =?utf-8?B?MnJLMVh2RE5jd2NoRDQ0cXV4R3djUW9pZ0d0M0Y1cHAvaU55N2ZPaUR3bHV5?=
 =?utf-8?B?S2pQbW12TzlnQkszOEYwbSt2ZTRoUlNSd3U5aTlvUDAwY0Z1a2JMcnIzWk9X?=
 =?utf-8?B?OThoWjg5bFlzY2xxTmEzZDJjc0U1UGxmRGlCR2Z0akxpSDl5YnhISy9CcTIr?=
 =?utf-8?B?NExEclBGT0hWUE5UaldjUkkrL0ZvcTJYTmpFdWZ2U1pGbWl1ekFxaTJ4Y1BL?=
 =?utf-8?B?NnpEeUVGV21BS0JYdDlMaGVuTjE3UUF1d0xOQlJ6WjJkRnFxWjU1N1BudFBh?=
 =?utf-8?B?cFhQdVJLbU43UFN3bXRvU3RSSmhTaFpncGUzdEYrNFNtVXZLdEFvaGZVVWUr?=
 =?utf-8?B?RjUrV2pDaDNjejVYMHdpOWJxRUNXL2o2WG9Xd1J2cENTUlcrQVdsaVZFQUUz?=
 =?utf-8?B?dk9FZ1VRYk0zNjliZFNBNHBqMDRQaXhJcVFOMTQ1RWJLTWtxbklRais3citQ?=
 =?utf-8?Q?ZhnDdM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnJ1L1cyMXZ2dTY4OHVNNnhpaWtpV3JlSXpSMit0VnJ6T2RCU0lSY0dPYjI4?=
 =?utf-8?B?dVZPcHN0NGZ0ZFZjWitaSVo5VUNRMnJJdWxBTyt6ZmRLcldEZkRlRE82emp2?=
 =?utf-8?B?akQwM1VGOFI3cVRSSklDbFFkOUxmTGg0MENxQ1YxaTNIYi9POFI0MUdHYlNI?=
 =?utf-8?B?bHBuZFpnSE1iY0RnajYrbHAzRkNiaU1WbjFrdzdHcWFDUzR1NFZFVXlaWm9V?=
 =?utf-8?B?VGcrMm0vMmFHR0VVc3Q1NHQxcG1FNUgxVTk0RlgxTFBiV0lrOThHb3JHNklW?=
 =?utf-8?B?TTlQK1FHYUNJbndPUVRZOGxzTVVpMFpvTW40eHZsZ1pQTzZ5WlhNTEcvS1RG?=
 =?utf-8?B?a3M0VTlpdkUydm5ScHVSR3Q0UmJ5aDFDMVFmYXYyb0cxZ24reVp3TmthQm91?=
 =?utf-8?B?RTRkUXhvVlpLejV3RExOdXJiT3RMVTRFUDRncXFqZlpMNEFYTW5XUFE5M1pr?=
 =?utf-8?B?Qjg3YTdYcmR2TGpNODUrZnB5c01RUk9vNmRCRkh2OGVhaHV2TFloTlZ6cHJt?=
 =?utf-8?B?L0FXUGlDekkwSzh3cXVNcVpybzRrRUZHNGlsRnplalVjN1BSMit5M3dkcmFs?=
 =?utf-8?B?MmxveGYyUHJjc0pWWUpGRWJEVFdGUUdLbG44ZzdnMkpSeVVFNjRuWk5KTmR1?=
 =?utf-8?B?R0NWREdTcEx5a09vYWVmbUFWZWt5YkZFb1g4ZWJwVXJDckJJdjlrcExMK1pR?=
 =?utf-8?B?Qkg5T2RZcjJrZnVSQ0JKRkYwbDBERVo0YmMyV2cxemkxVlVWV0ZKYkFGZ2ZE?=
 =?utf-8?B?WTI0aW05Q3k2Z01jQVowcmQ0TDBxZmprcHR2ejBzUjJhY2ZyLzRKbGJNVm5n?=
 =?utf-8?B?ckQ5dXJEMzFEdWc5UWxLT1ZXRTFVcWQ2bkJzdkdick1iSk5telh4MUpFb282?=
 =?utf-8?B?MWdUZTdCaHpmN0FiU21BSkxGMUNlUGVWVnZHYTl1NlJSZlVBR1VXK0d1ZStG?=
 =?utf-8?B?ZUhWQnVIODZZeFBLbjM3L29jZCs2ZmxrSkNrQVFjUThLK2Z3SzdDNnRSVzJV?=
 =?utf-8?B?VitwUjZkeWRQSWJMRkVycURob1VqNmF2ekg5OGF4THNTazliQUk3eDAwUUVG?=
 =?utf-8?B?RzRSbkUySnhkNDJNYVdxQ21jSXA5SEJXUUZNTWt3WGF5eFdDaUR5YWdnMENo?=
 =?utf-8?B?eUdPQUptVzVUY2RIamlxWEVvb052RkxDMU9vWmhLZkJBaHYvZXlqRW5jVFdB?=
 =?utf-8?B?Y0ZTZ1FMYTFUMXgxNkI4L0pjenN1aHJuOWUvTTNrd2ZTVkljb1dkdG1NaEJj?=
 =?utf-8?B?NGJncHVLQWp1Y2xoVk1uUHJ2N0JyY3NSd1V0ZmFLeGtUYTZOTTVVZGs4enJ0?=
 =?utf-8?B?NnNOM05Xb2dVQ0lVaGZ2NXdnRW43NUFyamlJcHJIY0NxUGlQZHplc1FaSGV3?=
 =?utf-8?B?SnZlK1dOVEE1UTZsQ2tzQUxZNm9vL2NZNnFLWHlJL3o5VzBid3lGRVRSV1pW?=
 =?utf-8?B?RG9zZWhHdXVidjZkeEVJUEtEOFRZZGx3L01QOW0rTzFadTJibGpkUXM3RkRh?=
 =?utf-8?B?QXlFUyt6Q21iMEUrTkVWNy82RzJIdU9Sd0Q0RDdJU3JieU80WlJTL0xLbU5h?=
 =?utf-8?B?aTBJTE9sTU5uNUw3dmZuUmdhQm1Md2ZGRzhBaW1rQko2QnZNeElaaThDZ2gx?=
 =?utf-8?B?U3dxU2dTMGRGVW8xV0tCVDFacldoYzJYbjdxdENCMUhab2RLSENFemZ1WUNG?=
 =?utf-8?B?cm93eE80NGcyQ1RSWnhSMjN2a1YzUVlncyt2OE12bHF3WE5Ob1psYy81Uk1z?=
 =?utf-8?B?dGMyRnB1ejN2Z2QycVlONGN5dmJCaG5mblFDdjFTL1FJb1RNVGUzUkN0dlJ5?=
 =?utf-8?B?MFVJMUlEVWFMUm9RL2N2ZW55NWxPMHQ4MHFMcytNTnhMK2x3WkZyOEkyNXJD?=
 =?utf-8?B?UWpWSEtKdDFlRVA5bUJackhjRTBWb2ovdEVpQXphYWdmbUgvak1WK2RtYWVC?=
 =?utf-8?B?dmxDTzRwNy8vSUQ5a3RWT3pHcDhITFRGa09KMXFVeDNzbENodjdEYTg5bmNN?=
 =?utf-8?B?K0VxK1pxdFRQVTJwdThKcE5MSno5UERLbTVSNmRoM3pyYmM1U2xRN0hEUjZI?=
 =?utf-8?B?Yzk0aHFVOGdXU0xuTVV3N0FIS056cXNTV1ZOcTdlRGlyYXFEWWVhUS9jVVZs?=
 =?utf-8?B?cFdHZEJaUVEvcGJjMnRMcFloU3lmUDZrU3lOTzMwZStOdlpSWlErRXFMZUl5?=
 =?utf-8?B?a2c9PQ==?=
Content-ID: <694FCF197ED224409517F4CF7EC69126@apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ae75d6-47da-42b3-2eef-08de362a8a70
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2025 07:22:27.2052 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qwWcN8ucHDa5H0DvJDBrQJHcekrLXDwcM3LMgkCQmAv7UjvoOtHp8kn3TIROyhRufb5KYq9Rs/fkcfr01ZRwxOm0A85idf84euLS4s13tUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7649
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

T24gRnJpLCAyMDI1LTEyLTA1IGF0IDA5OjEzIC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gDQo+IA0KPiBPbiAxMi80LzI1IDk6MTYgUE0sIE1hY3BhdWwgTGluICjmnpfm
mbrmlowpIHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAyNS0xMS0yNSBhdCAxMTozNSAtMDYwMCwgRGF2
aWQgTGVjaG5lciB3cm90ZToNCj4gPiA+IA0KPiA+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2Ug
ZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMNCj4gPiA+IHVudGlsDQo+ID4g
PiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+ID4gDQo+
ID4gPiANCj4gPiA+IENoYW5nZSBtdDgzNjVfZXZrX2RlZmNvbmZpZyB0byB1c2UgQ09ORklHX09G
X1VQU1RSRUFNPXkgYW5kDQo+ID4gPiBkZWxldGUNCj4gPiA+IHRoZQ0KPiA+ID4gVS1Cb290IGNv
cHkgb2YgdGhlIGRldmljZXRyZWUgc291cmNlIGZpbGVzIGZvciBtdDgzNjUuDQo+ID4gPiANCj4g
PiA+IFRoZSB1cHN0cmVhbSBkZXZpY2V0cmVlIGlzIGlkZW50aWNhbCB0byB0aGUgVS1Cb290IG9u
ZSBiZWluZw0KPiA+ID4gcmVtb3ZlZA0KPiA+ID4gKG90aGVyIHRoYW4gaGF2aW5nIG1vcmUgbm9k
ZXMgZm9yIGRldmljZXMgbm90IHVzZWQgYnkgVS1Cb290IGFuZA0KPiA+ID4gdXBzdHJlYW0gZml4
ZWQgYSBjb21wYXRpYmxlIHN0cmluZyBpbiAmc2Nwc3lzLCBhbHNvIG5vdCBhZmZlY3RpbmcNCj4g
PiA+IFUtQm9vdCkuDQo+ID4gPiANCj4gPiA+IFRoZXJlIHdhcyBvbmUgbWlub3IgZ2xpdGNoIHdp
dGggdXBzdHJlYW0gbWlzc2luZyBhIGZldyB0b3Bja2dlbg0KPiA+ID4gbWFjcm8NCj4gPiA+IGRl
ZmluaXRpb25zLCBzbyB0aG9zZSBhcmUgYWRkZWQgdG8gdGhlIGNsb2NrIGRyaXZlciBkaXJlY3Rs
eSBhcyBhDQo+ID4gPiB3b3JrYXJvdW5kLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBE
YXZpZCBMZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IMKg
YXJjaC9hcm0vZHRzL210ODM2NS1ldmsuZHRzwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8IDQxOCAtLS0tLS0tLS0tDQo+ID4gPiAtLQ0KPiA+ID4gwqBhcmNoL2FybS9k
dHMvbXQ4MzY1LmR0c2nCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgODQwIC0tLS0tLS0tLS0NCj4gPiA+IC0tLS0NCj4gPiA+IC0tLS0tLS0tLS0NCj4gPiA+
IMKgYm9hcmQvbWVkaWF0ZWsvbXQ4MzY1X2V2ay9NQUlOVEFJTkVSU8KgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoMKgIDEgLQ0KPiA+ID4gwqBjb25maWdzL210ODM2NV9ldmtfZGVmY29uZmlnwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMyArLQ0KPiA+ID4gwqBkcml2
ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MzY1LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgIDQgKw0KPiA+ID4gwqBpbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL21lZGlhdGVrLG10
ODM2NS1jbGsuaCB8IDM3NSAtLS0tLS0tLS0tDQo+ID4gPiAtDQo+ID4gPiDCoDYgZmlsZXMgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCAxNjM1IGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gDQo+
ID4gVGhhbmtzIGZvciB5b3VyIG9ic2VydmF0aW9uIQ0KPiA+IEhvd2V2ZXIsIHRoZXJlIGFyZSBz
b21lIGJhc2ljIGNoZWNrcyBzaG91bGQgYmUgcmFuIGFuZA0KPiA+IHBsZWFzZSBrZWVwIGluIG1p
bmQgYmVmb3JlIHlvdSBzZW5kIHRoZSBwYXRjaC4NCj4gPiANCj4gPiAxLiBQbGVhc2UgYWx3YXlz
IHB1dCB0aGUgTWFpbnRhaW5lcnMgYW5kIFJldmlld2VycyAocnVuDQo+ID4gLi9zY3JpcHQvZ2V0
X21haW50YWluZXIucGwpIGluICJUbzoiIHdoZW4geW91DQo+ID4gc2VuZCB0aGUgcGF0Y2guDQo+
ID4gT3RoZXJ3aXNlIHJldmlld2VycyBtaWdodCBzaW1wbHkgZmlsdGVyIG1haWwgdG8gdGhlIG90
aGVyIGZvbGRlcnMNCj4gPiBpbiBtYWlsIGNsaWVudCBhbmQgc2tpcCBpdC4NCj4gDQo+IEkgdXNl
ZCBgYjQgcHJlcCAtLWF1dG8tdG8tY2NgIGFuZCB0aGlzIGlzIHRoZSBkZWZhdWx0IHdheSBpdCBo
YW5kbGVzDQo+IGl0LiBJIGNhbg0KPiBwdXQgZXZlcnlvbmUgYXMgVG86IG5leHQgdGltZS4NCj4g
DQo+ID4gDQo+ID4gMi4gUGxlYXNlIGFsd2F5cyBydW4gLi9zY3JpcHQvY2hlY2twYXRjaC5wbCBh
bmQgY2hlY2sgZXJyb3JzDQo+ID4gYmVmb3JlIHNlbmQgb3V0IHRoZSBwYXRjaC4NCj4gDQo+IEkg
ZGlkIHJ1biB0aGlzIGFuZCBkaWQgbm90IGdldCB0aGVzZSBlcnJvcnMuIEkgY2FuIHNlZSB0aGF0
IHlvdXINCj4gZW1haWwgc2VydmVyDQo+IGhhcyBtb2RpZmllZCB0aGUgZW1haWwgYnkgYWRkaW5n
ICJFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QNCj4gY2xpY2sgbGlua3MNCj4gb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZQ0K
PiBjb250ZW50LiIuIEkNCj4gYmVsaWV2ZSB0aGF0IHlvdXIgZW1haWwgc2VydmVyIGhhcyBhbHNv
IGNoYW5nZWQgaXQgdG8gV2luZG93cyBsaW5lDQo+IGVuZGluZ3MNCj4gZHVyaW5nIHRoaXMgcHJv
Y2Vzcy4NCj4gDQo+ID4gSSd2ZSBkb3dubG9hZCB0aGlzIHBhdGNoICgubWJveCkgZnJvbSBldm9s
dXRpb24gYW5kIGZvdW5kDQo+ID4gdGhlIGZvbGxvd2luZyBlcnJvcnMgbXVzdCBiZSBmaXhlZC4N
Cj4gDQo+IFlvdSBzaG91bGQgYmUgYWJsZSB0byBnZXQgYW4gdW5tb2RpZmllZCB2ZXJzaW9uIG9m
IHRoZSBwYXRjaCBmcm9tOg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvdS1ib290LzIw
MjUxMTI1LWFybS1kdHMtbWVkaWF0ZWstc3dpdGNoLW10ODM2NS10by1vZl91cHN0cmVhbS12MS0x
LTcwN2VlZTZkZmRiY0BiYXlsaWJyZS5jb20vcmF3DQo+IA0KPiANCg0KVGhhbmtzIGZvciBoZWxw
aW5nIHRvIGNsYXJpZnkgdGhpcyBpc3N1ZS4NCkkndmUgcmVwb3J0ZWQgdGhpcyBpc3N1ZSB0byB0
aGUgSVQgZGVwYXJ0bWVudCBpbnNpZGUgTWVkaWFUZWsuDQoNCj4gPiBFUlJPUjogRE9TIGxpbmUg
ZW5kaW5ncw0KPiA+ICMxODA5OiBGSUxFOiBjb25maWdzL210ODM2NV9ldmtfZGVmY29uZmlnOjg6
DQo+ID4gK0NPTkZJR19ERUZBVUxUX0RFVklDRV9UUkVFPTNEIm1lZGlhdGVrL210ODM2NS1ldmsi
Xk0kDQo+ID4gDQo+ID4gRVJST1I6IERPUyBsaW5lIGVuZGluZ3MNCj4gPiAjMTgxNTogRklMRTog
Y29uZmlncy9tdDgzNjVfZXZrX2RlZmNvbmZpZzoxNDoNCj4gPiArQ09ORklHX09GX1VQU1RSRUFN
PTNEeV5NJA0KPiA+IA0KPiA+IEVSUk9SOiBwYXRjaCBzZWVtcyB0byBiZSBjb3JydXB0IChsaW5l
IHdyYXBwZWQ/KQ0KPiA+ICMxODI4OiBGSUxFOiBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4
MzY1LmM6MTQ6DQo+ID4gDQo+ID4gDQo+ID4gRVJST1I6IERPUyBsaW5lIGVuZGluZ3MNCj4gPiAj
MTgyOTogRklMRTogZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODM2NS5jOjE1Og0KPiA+ICsv
KiBNaXNzaW5nIHRvcGNrZ2VuIGNsb2NrcyBkZWZpbml0aW9uIGluIGR0LWJpbmRpbmdzICovXk0k
DQo+ID4gDQo+ID4gRVJST1I6IERPUyBsaW5lIGVuZGluZ3MNCj4gPiAjMTgzMDogRklMRTogZHJp
dmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODM2NS5jOjE2Og0KPiA+ICsjZGVmaW5lIENMS19UT1Bf
Q0xLMjZNwqDCoMKgwqDCoMKgwqDCoCAxNDFeTSQNCj4gPiANCj4gPiBFUlJPUjogRE9TIGxpbmUg
ZW5kaW5ncw0KPiA+ICMxODMxOiBGSUxFOiBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MzY1
LmM6MTc6DQo+ID4gKyNkZWZpbmUgQ0xLX1RPUF9DTEszMkvCoMKgwqDCoMKgwqDCoMKgIDE0Ml5N
JA0KPiA+IA0KPiA+IEVSUk9SOiBET1MgbGluZSBlbmRpbmdzDQo+ID4gIzE4MzI6IEZJTEU6IGRy
aXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgzNjUuYzoxODoNCj4gPiArXk0kDQo+ID4gDQo+ID4g
dG90YWw6IDcgZXJyb3JzLCAyIHdhcm5pbmdzLCAwIGNoZWNrcywgMzYgbGluZXMgY2hlY2tlZA0K
PiA+IA0KPiA+IEJlc3QgcmVnYXJkcywNCj4gPiBNYWNwYXVsIExpbg0KPiA+IA0KDQpCZXN0IHJl
Z2FyZHMsDQpNYWNwYXVsIExpbg0K
