Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC42FEB48F3
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 10:12:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A3CF8367F;
	Thu, 12 Feb 2026 11:12:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="UmO49Jwm";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="D8xiy5Y7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87F5A83A47; Thu, 12 Feb 2026 11:12:03 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9448283015
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 11:11:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 3d99448a07fb11f1b7fc4fdb8733b2bc-20260212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=rrebO78L5jjGNfXHyscZGzPKkWQ1xf0QRf0yXlYgih4=; 
 b=UmO49Jwm+1Rd0ELxnB1Ve4fH/+dkw59oDq8B8bedyrzaY61CXzg/eN3yon0hFPATKtnL8NdbIJGTE53AidBlMZgnz7HhqDl12n3sJlPuJl2Vy2GMS8bpXEWzIllxjJuTrmtCd8dCLIWJxwCtoAnYEh3kFpjaUBqU/YXbINk7jk8=;
X-CID-CACHE: Type:Local,Time:202602121811+08,HitQuantity:3
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:f238e357-3503-45c6-b203-000ffa1fcc3c, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:92a29ff0-16bd-4243-b4ca-b08ca08ab1d8,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3d99448a07fb11f1b7fc4fdb8733b2bc-20260212
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2122749798; Thu, 12 Feb 2026 18:11:47 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Feb 2026 18:11:46 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 12 Feb 2026 18:11:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4v4MXfl+1ZPm7YdPQomMD+KLyHcogYgQeNw41XZSs1e17b8x2Pj3+/scVH0g0hdKdzRwN7BL1rZecYCrWXVBjJuFDuYl4DJKoTBhXmNqsupNy3Ddxkr1b5Up2BjgO9qzndq7piqGG1QgbD2VhtVxp1NCltolmhZjb/m9txLrSJVRX1xgF6u35omi0ZHtA5blmP1/HIFjWZuzp6BMILTQz4a/OJX42bfWRdojv9ryQ+JkzfEAipVct2ZxL8pTouq+x2F70ef2P7BmSzFh1SZENT3SH//WrNGo4873/QJrDRXRvT9WSupmPx7rQl12TS16lhaksUdW4XwIpgnqw3wcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrebO78L5jjGNfXHyscZGzPKkWQ1xf0QRf0yXlYgih4=;
 b=SFjEcsKIXj3Q4MRb3BE4oFh583OWR5J4qMPvNRrr+Eenrix0hpkkVMZ2Pqysx+/KzEu0f7UAzriH1CGFWHiWIbHsJGDr5LyhvQzmXDtsg5oidAcdne3jCNgkBUF5bHMb04DTEB55KggXxWZ+Fxi5UbY1l7P4iCHVO6foTP6nhZ1HU4t/6kt5PQr/lwrQTXPU7R1xlKcyEcFZBCZdz9Uj1JCCSXiXYc0sL74/khT9WTEdh0i4GMyAygtxudt4TE/csA2jvOBF3K5uCr8IwtxuTmZFAdfJs3ThI+OrLQJ/Twu/T6BOVk7qw6iw//8j95Ja0sqdmcP+yGSgsiaPieFEGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrebO78L5jjGNfXHyscZGzPKkWQ1xf0QRf0yXlYgih4=;
 b=D8xiy5Y7vV+eUSc6bxPg5C3VYnF7qNe6KnWZxTkiRF2tEVi7Xypz49LJEwmg4A8jMLUro/3K31dzZgqsGXAvdRuoIv0v73YQl0ouvffLumzxWwZva6jT3EaqiWp3mN+t+L/WyD3m0nOBeYeZBdp6dbhxIJ5Ih7qIIB5Goy5fJDg=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYZPR03MB8838.apcprd03.prod.outlook.com (2603:1096:405:a1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 10:11:39 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 10:11:39 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>
CC: "hayashi.kunihiko@socionext.com" <hayashi.kunihiko@socionext.com>,
 "venkatesh.abbarapu@amd.com" <venkatesh.abbarapu@amd.com>,
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>, "n-francis@ti.com"
 <n-francis@ti.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "michal.simek@amd.com"
 <michal.simek@amd.com>, David Lechner <dlechner@baylibre.com>,
 "philipp.tomsich@vrull.eu" <philipp.tomsich@vrull.eu>,
 "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, "sjg@chromium.org" <sjg@chromium.org>, 
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "neil.armstrong@linaro.org"
 <neil.armstrong@linaro.org>, "bb@ti.com" <bb@ti.com>, "j-mcarthur@ti.com"
 <j-mcarthur@ti.com>
Subject: Re: [PATCH v2 3/3] drivers: ufs: fix typo in struct ufs_dev_cmd
 kernel-doc
Thread-Topic: [PATCH v2 3/3] drivers: ufs: fix typo in struct ufs_dev_cmd
 kernel-doc
Thread-Index: AQHcmqmmB9gFVja+XU+OHXX86mZoNLV+2p8A
Date: Thu, 12 Feb 2026 10:11:39 +0000
Message-ID: <c027cfa2cbdbb1a7681847458da7986abc482d3c.camel@mediatek.com>
References: <20260210-ufs-ufs_hba_ops-cleanup-v2-0-dd73da21aa92@baylibre.com>
 <20260210-ufs-ufs_hba_ops-cleanup-v2-3-dd73da21aa92@baylibre.com>
In-Reply-To: <20260210-ufs-ufs_hba_ops-cleanup-v2-3-dd73da21aa92@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYZPR03MB8838:EE_
x-ms-office365-filtering-correlation-id: a8e1a381-6a5c-4673-a0ac-08de6a1f1cd4
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?cGl0dXM1ZW9MZlhUa2xvTlA2ZzcrclV0cFcxN05KS2E0ZU9aN1g4N2djeENp?=
 =?utf-8?B?TTBoWVFrWWxtV1ZCSnNqWDRGTkhLYktVZGdqWXNySlhlS0o1QXlYWTRFOXU1?=
 =?utf-8?B?NGJMSjRHR2xYelVUMUdBTG1ackxtdndKbHhhdnIwQUloZlBOYzBGb0pnNWFW?=
 =?utf-8?B?d3NXdEliRlNRN2YzUnpGcUpSYmtnMUE1Z3p4MTVwZC9SMnNMdk50VU9xYklF?=
 =?utf-8?B?TDlYQkZNbEc0NU1OWWRuc2E2TytpZFhxMVR3Q0pNTDdvaVBIZis4ellxTVdP?=
 =?utf-8?B?SnNVRDFRbUVxSWp3Q2VwSm1RWkpGOEswNzBvdVFueHZwNGNRcDc4aHJ2c1Fk?=
 =?utf-8?B?SlJCOTlreHJNRlkvTFpDU1d0YWtXYWM3VDNOYWNnWWZxOHNhOU8vSS9DV0Fi?=
 =?utf-8?B?NEdJU0laT3AyWEl3TFQra0NNZmZFSVdBcUtjRWtvY3gxalRyT3FIdlppSGtB?=
 =?utf-8?B?UkRwdklyUHRkVk1yS0U3YjhycTBiTFZuUkJpSDdidklnSytzM1BVTGRHS25l?=
 =?utf-8?B?TGFUM25FT09YblB0SXJhc0ZrKzI5M0dVb0FlVFVMR0pud3RqcU4rdEtUWXNo?=
 =?utf-8?B?RVY5bGVIL1VYQXg5NmhnTExkNC90KzRhWnJSeEZ5OVFMNU9teWU3S1dXdlAz?=
 =?utf-8?B?S2JSSTVjYkcwZFJXL3I5N1NraGxxMnd6TTJMRFQxQlZkRWRTcVcwUEQzQXlT?=
 =?utf-8?B?QWcvMjdnbU9iMElvS0VOd2FQYWpzejVhUS9ZcCtGaXFLN3lwWVZRd1VUWmND?=
 =?utf-8?B?Nm1DMm5sWDJaajc1bURYRDFkaC91ZnBEQVpnN3FPQzQ0UVg0ZFVtZGZHUUsx?=
 =?utf-8?B?aU5kcUhNci8zaW1tdzYweVNGTis4RTRPYVpjamlKTnpLOVdPSDJVblJwZEhC?=
 =?utf-8?B?bXFRb1g1VVYvdFpsdVVLTElPV01Vc1M5bmxrTUUzRWJKWmw3ME5yUmw0aVJ0?=
 =?utf-8?B?Z2ZPRGppZkhCQXJ2Skl2ZjRUKytkTzhnRThaWjE1eXNmMkxkc2pZTnhNajAr?=
 =?utf-8?B?Q1ErajI0b0s2V2tjUytqTWdhMUxQbDJzd3N0S1JEUDlua1dPalFyQ2dRVGdT?=
 =?utf-8?B?Tjhjc1JPK2x6WmhkTnZUaDBQWHlxTkFHeFVWdUw4T3B0ejRSeUs3ZWFQcy9z?=
 =?utf-8?B?U2dkWDJkWU4rYnFjZExQeVU3UDBSQm1ENUYybUZpNWhCSkFNaTFaMS8rZzJa?=
 =?utf-8?B?dkVyVmE5U2ZGZVF0TmQ0UlpsbmJJdlViRmJOUGtvM3kyR1J1NDEwTmtOZCsz?=
 =?utf-8?B?MXhNOUFyUWx2MjBQQ2IxYzl1eHJTSDRPT1JDdm9XQmhjdEFYa0NkN2lMN1Yz?=
 =?utf-8?B?QkNxMElOZldzbnZjSHpZNW4rV3NzWnA5d3lBWVhtV3lGNHIrSzFvakM1cUtS?=
 =?utf-8?B?d0RLK2VON3NiaXdubW8zMWEzdytNS1oyeCtidUJVMFhFNHc0VU9KWGFqMmZt?=
 =?utf-8?B?dFJIdEREZFBldjR5TTh4MlRZb0JMajJFaW5SeWI5cjFCUllMUDN3QUFqdnI4?=
 =?utf-8?B?aE9PYjlaSHFxTGxSNFphTlZyRzBFNGVFTEtoNm9Mc0pUYlVlNUJ6VWdQTHMv?=
 =?utf-8?B?Q0wrQmxsZGJhcTRFbks2YkZpV2RWeUNsYzNTNjZDTWMvaEhmUDh6UllwVkNP?=
 =?utf-8?B?Y3E2UzhrcHdDbUNjWUtiQThXS1AyTDdKMnJtL0JtbEpXWDd3ckhTMjFTK0JU?=
 =?utf-8?B?a0sxNVRia2VidXh1M2ZrMnRYcG9rSjRzbmtmcGtjODZORlpHekxYUlhCNXhy?=
 =?utf-8?B?OVZuRDkrYVJqMEQ5aHZCQWM1c3NpMGYyZDEvL2dBbERYSXhiQlJnRTQ5N0pw?=
 =?utf-8?B?aVRTbUdJaXVNM2VTUkpqbGNSeE55QjlJSUZ4OXhRMmVtcmNzMk1pc2Vib2VQ?=
 =?utf-8?B?dGIvbTBnc3o4b2d1V2tpcDFwK0tudWpiazdsU1RDRVphU2pKbEpqcTl1OXZa?=
 =?utf-8?B?ZXFpTHh5RXpuZDdGWHM5d2lxZHB1bFkwOW1DNW5nelNOVzVEd25hR3FDRXN0?=
 =?utf-8?B?UnY4ejhCMzh2UUxLeFFNblpaMml2S09teGwrS0Y2S29FaEpnbnJ3VDREbVlY?=
 =?utf-8?B?bGtUUVJtaFJFbUVLLzRWcjBxWForUkpvalBPR2dhU2krWWZ1SDhiMHFzUlBW?=
 =?utf-8?B?RHpYQWJ6cm1CeHdRODJyMUI4RTUrcEpwNzR0akdVRllNc0ZsQmVjL3JaWXky?=
 =?utf-8?Q?rDsk36D2cEI6Cixn88qh4LU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlVzQmdYa2h1ZFRRM3FBY253UGNQM3U3U0lINU91SmpRbHExNmJhUkRtTXRX?=
 =?utf-8?B?RzhzRkluZDZ0Y3lSZi92VVV6ZGxtMzhaeHl4MGhPQUE4ZmMwY0g5U3UrWkw5?=
 =?utf-8?B?cU12WXdzd2ozdElyanJYS01xb3BxdG5wTmpnRXA3RWpiaVg0TVQ3YWVTYWtY?=
 =?utf-8?B?UnZlVm4xVUE5WUZET1JxVGtXcEdMd1hxS09Oay93ZjBjQkNQL21XeTRoQlNH?=
 =?utf-8?B?em13RDhVd3NFUlVOUVNyeTJXV2lGaUVLUm9QSVBRdHpWNFlYRjM5VmpCVjdB?=
 =?utf-8?B?eWM3WHFFVWRMN0lwMW1ZWEsxZkp2OWxVLzZ1YUowcTdScVhjMllBYldFZlJW?=
 =?utf-8?B?azNyUHNTNGthemU1alRYSE5INDd6c1NSUk0wSDZmU1lLZVJDVGVIdDFoWGl5?=
 =?utf-8?B?WnZ3Vk9CR01DQjIvLzF4SC9hKzZGTCtKWDQ5VmgrY0NzVDVnNVJrUmdHRkRP?=
 =?utf-8?B?OGtFWHVmb3dKSzFScFdiSVEzZ2ZvK0oxUnlZeEdSMGRCT2VIVlU2em5BeFlK?=
 =?utf-8?B?Wm1oazB6TEYvaEt4OXJVZm1OOGVZTmtiRlpUVy9oemlkQVM3Tmw4a0hNeGcr?=
 =?utf-8?B?VWlFdC9rS25BZDZBVVBHWHhoYmttZ05wcHQ3WWQva3NpMnpMbmpTQ0xzRG0r?=
 =?utf-8?B?NHQwaWlNZlA0TlNlSFZxK1BjbjJVdm1iKy9CbWUxbm42cUZoQytkTjdCdGEy?=
 =?utf-8?B?dUJmUzhPbUQza0gwSkxsRFpiZ3hiL1A0RGJHYnJFQjMyTHlLR0hTcytWb0xR?=
 =?utf-8?B?Wm5wY2R3cHQySU5wSE00VlhOeHJrZENSbWttQ0Z4NXlLMUR2Uk8rVVdYRmsv?=
 =?utf-8?B?YjhlRkhNaGI4OEJUMGQ4akNmUmlEbVQyZjFNNWN0N3BZT2hWdGdDZ1EwcDl0?=
 =?utf-8?B?Sk1CeHBlSjAxSkE0R2p4MG1MbDhFRERXdFh0dmhTcGdndjZUWXRuWmlReGtY?=
 =?utf-8?B?VmVDcnhGWDVRZlpsUGErSnJ2c1puMmVrdFhwbEc2T2ozOGVRYXZ2OTBCN0kv?=
 =?utf-8?B?ZHJTSENBYzlqdzFxMkNkLy9iRW1Kd1ZFZFpBKzAxc1VzOGRwQlFkMklYd1pV?=
 =?utf-8?B?YUgrYTliYmc2b0VWeEdSY09MRmNyaXRlTzFnazJNTklzQ1k0UmhYbWNJODlM?=
 =?utf-8?B?YkNxNjNGeWtmSXZSSEJ4bUtZNzdWZjBTSnhra2EyUG8yOW5yZkUrNU5IbHd5?=
 =?utf-8?B?UnM5Sm04bHh5MjJTenoveVpGdnZiMjV3ZWFUZHppQ2lWMlM3ck5QNE5ibHZN?=
 =?utf-8?B?NVBSYlFHclRrOXAzSzZKLzV3VXJSN2tVZCt0S255VW9td2pmbWU2eW9aaC9B?=
 =?utf-8?B?cld0ZVA1TG9hWmhFL0IwV2Vlc3lVYzdqMnNFUG5YcnpPZzBBK04rTkdiV2ht?=
 =?utf-8?B?Nnk1SnlLVEg2cm56Y0w2cWsvUnJkcWhjZWN2K2RuY0VQQlhsOFJZMUFXZ2xQ?=
 =?utf-8?B?aFdqSGJVOHJGNDV3TUhycGZrb1NxeklJcnFvMXZQTXVBZXY1R1lheEdGWjFE?=
 =?utf-8?B?WlBULytEK3pMaE1vb1ZQT05QYmF4V2NHTmlOaWpGbVJoSmtrdGlNaUk3WE9i?=
 =?utf-8?B?V1BFQjZKb1NPUUVtSGtoTGdWUFljR0ZFa1JWUlVvUDRLdkRFTEZUa0s5Znly?=
 =?utf-8?B?Rmd2MzlBUGpXRU5xZEFJZkpiOTRUcDlkeEtiZkpFUkw4aGpIQXA3eFRCdll4?=
 =?utf-8?B?c2NDTXZrVHU3a2pnenpNdytEdGFwRHgwejJTY25uVFJlK1hqQlpsKzZIMGhX?=
 =?utf-8?B?cmhXNWtKVGV1R0NIcFlRVlZFa1RWSmtSVzlUdFVDU0lZeHhkVXNrNzdyZXRK?=
 =?utf-8?B?MStxb2o1RWdsdGludFVFbW1KMjdSSkxiWXRuS2d5Qk02MGI1d09VdHVPWmRu?=
 =?utf-8?B?SncwTEtDUDNMN2IvbWgrUStPT0ZPdEwyVVdzR0JFeHVjKzRnUHkvT0tQSHMr?=
 =?utf-8?B?RU1KamljTXM2TDRtZzRMaEE0KzJ5cG5QVlZvcjVSYyt4OUFhZzBxNGFJQVVK?=
 =?utf-8?B?RGNmQW5PL2J3K3VXVFdYUFRVRWxwYmo4bFhxNjZSRnYyTHZWOFpWY0NsZVdY?=
 =?utf-8?B?dWQzOGdzbEx4dy85ZnYrcS9FMWkwQUNDeUwzQk9nWlZ2d3JNcXFNcGlzRGd6?=
 =?utf-8?B?NXVWNWFaOXBtYTBDR1d5VExrRjJTMXBJeng2a2lKeFh1U01YQ1cwZ3ZiamYr?=
 =?utf-8?B?OUprazltbjNvUktyWUdQbHh0cjlkZktUZEFqekRNOTJpMHVWajEvb1NWckpF?=
 =?utf-8?B?dEpZOHJRakJoNlVUMytHeHNMLzFoYUxETzFJUkpERXZSaXp2V2RBVDEzK1gw?=
 =?utf-8?B?R09jTlowN0VkeW9GYVZYdzVJYzQ4Slp4ZForUGVWTFhRR0dUM1M4b2NMOXZM?=
 =?utf-8?Q?zbtIjXhAN5nv0IGU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BFF1BE142D96848AE090A6B147AC91C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e1a381-6a5c-4673-a0ac-08de6a1f1cd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 10:11:39.2789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kAB6CsUo5RzYp97Tb+XFP+RXkrRBo1hiejnbraxpMDZyrfpNjuOmNgpRwDxkE2bcQlKhPW7HHZ0h7jttsON0JZvg/d8uQ9iwRMZ4MIZuY0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8838
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

T24gVHVlLCAyMDI2LTAyLTEwIGF0IDE3OjIyICswMTAwLCBKdWxpZW4gU3RlcGhhbiB3cm90ZToN
Cj4gRml4ICJhc3NvY2lhdGVkIiB0eXBvIGluIHN0cnVjdCB1ZnNfZGV2X2NtZCBrZXJuZWwtZG9j
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSnVsaWVuIFN0ZXBoYW4gPGpzdGVwaGFuQGJheWxpYnJl
LmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy91ZnMvdWZzLmggfCAyICstDQo+IMKgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91ZnMvdWZzLmggYi9kcml2ZXJzL3Vmcy91ZnMuaA0KPiBpbmRleCA3NDEyNWIxYWIz
MS4uMGY2YzkzZmJjZTcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdWZzL3Vmcy5oDQo+ICsrKyBi
L2RyaXZlcnMvdWZzL3Vmcy5oDQo+IEBAIC01MDksNyArNTA5LDcgQEAgc3RydWN0IHVmc19xdWVy
eSB7DQo+IMKgfTsNCj4gwqANCj4gwqAvKioNCj4gLSAqIHN0cnVjdCB1ZnNfZGV2X2NtZCAtIGFs
bCBhc3Nvc2lhdGVkIGZpZWxkcyB3aXRoIGRldmljZSBtYW5hZ2VtZW50DQo+IGNvbW1hbmRzDQo+
ICsgKiBzdHJ1Y3QgdWZzX2Rldl9jbWQgLSBhbGwgYXNzb2NpYXRlZCBmaWVsZHMgd2l0aCBkZXZp
Y2UgbWFuYWdlbWVudA0KPiBjb21tYW5kcw0KPiDCoCAqIEB0eXBlOiBkZXZpY2UgbWFuYWdlbWVu
dCBjb21tYW5kIHR5cGUgLSBRdWVyeSwgTk9QIE9VVA0KPiDCoCAqIEB0YWdfd3E6IHdhaXQgcXVl
dWUgdW50aWwgZnJlZSBjb21tYW5kIHNsb3QgaXMgYXZhaWxhYmxlDQo+IMKgICovDQo+IA0KDQpS
ZXZpZXdlZC1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCg0KVGhh
bmtzIQ0KTWFjcGF1bCBMaW4NCg0K
