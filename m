Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484B0EB48F7
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 10:35:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6A4B83015;
	Thu, 12 Feb 2026 11:35:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="TEPaQuVa";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="X6smdZFN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A991783C4B; Thu, 12 Feb 2026 11:35:42 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11B3A80FA1
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 11:35:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 8eb1ae5407fe11f1b7fc4fdb8733b2bc-20260212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=c5tzHgROMi3hZh9hdXyubOXpQ81bANBO956KpWc+73Q=; 
 b=TEPaQuVayZO6J2zC+gqw7PV1A5jBjFcfagu8o/LgJY7gNE1ZmaQb6mi4Ks6NG/ZjPuBTrZ0dhU633G5BPpfKncjKu7wOkreKU2CHDdJ+FvLHcH/0XEzCkseQ9fLmxG/CfXYICTs+SCd1ce40gAwDc2Zv8qw1HHmhb3bphd9kbSA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:7015ced2-0f6a-49e9-a3db-6a6c18725657, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:a06a395b-a957-4259-bcca-d3af718d7034,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8eb1ae5407fe11f1b7fc4fdb8733b2bc-20260212
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1768436165; Thu, 12 Feb 2026 18:35:32 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Feb 2026 18:35:31 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 12 Feb 2026 18:35:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FnywXcDX0D3y3xjNhx7OIn0cgZTXWMvclKUD1W7pZIyQHilyxwueMjVC/kwxIiHyAgmgRlubc9UYIb2d3c452uE/Wq/Qm8P941l6Fc5T12EQgJ41rvjtk5YOWCglhGlfNiX/R84mNPtZAfk09AQndK3bD1NUImaWgDqYATaL3YRHqxdv6yRybnew97iFZEWZqxu4JukG8qT0uvh/ZnHKA93fosQF8klIqCWpOFA0c9STF+iDmCrMfcNWtNlbskv/lOzUzfKLa3Dqh6sdVmhYXlRX/CTFhOQGK9uEvee21AqHSmWcgtwTdBIgMYCtMHlX/V8VL7OC9P5qWzGK6ydzFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5tzHgROMi3hZh9hdXyubOXpQ81bANBO956KpWc+73Q=;
 b=OHLRgJ7Mpqn81iGF/mNmOnfFwHZlzlwoihEbP8jwmQiz8JaYjHKgSY8QmgDDdcAGY3lAgZQx7KacTHY94kI+k7AV+E0nhl8PSHlB8DebR5rJdvf5kIgA196YQLbcnsmk4D42Nu80esJ+wA4HKCvW94slkrQuNAI0rNkfsUwgBNI+urGVCLp8fALaF3JbJblhswpmSWucMo2NnS7H6oUmhuw8ZlMGHx1m3H0hWMxLRtbfJ6pGCZ4UUunmdonU7sXkiIcbQzVooJ+a3z5xV7ZpWO3yZXLbDmdNsf20ZfuXn5O9UMMSWodqVgCRlZO+jphukQ2qwws04OuPdoT1n9dj8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5tzHgROMi3hZh9hdXyubOXpQ81bANBO956KpWc+73Q=;
 b=X6smdZFNP9PmWUBzmu86C2HXIIpeWrUMbKkJcUjdTpLSjIdRWFOxynR1inyv5YW09xpTKDILLI3Js2zolEQxdygIeS8xmj4TVdcaGHHvLdfc48gUewGilypwNr9j8ZxOMpbC3KdON0gUp0CQlL525yn38OaU57MehdlhpImUm4U=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by KUZPR03MB9357.apcprd03.prod.outlook.com (2603:1096:d10:2c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 10:35:26 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 10:35:26 +0000
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
 <u-boot@lists.denx.de>, Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH v2 2/7] board: mediatek: mt8390_evk: remove empty
 board_init()
Thread-Topic: [PATCH v2 2/7] board: mediatek: mt8390_evk: remove empty
 board_init()
Thread-Index: AQHcmed2sZtb6vD2pEuw5z4xeG2fI7V+4smA
Date: Thu, 12 Feb 2026 10:35:26 +0000
Message-ID: <5307b9a807084112ad23d224b150b9af191b8bf4.camel@mediatek.com>
References: <20260209-mtk-mach-clean-up-duplicates-v2-0-e3b22282c74d@baylibre.com>
 <20260209-mtk-mach-clean-up-duplicates-v2-2-e3b22282c74d@baylibre.com>
In-Reply-To: <20260209-mtk-mach-clean-up-duplicates-v2-2-e3b22282c74d@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|KUZPR03MB9357:EE_
x-ms-office365-filtering-correlation-id: 21fade64-b501-4c1c-7875-08de6a226f70
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cHo0T2N2eTExcklzUW13ZzVKcnBtM3R1YWhWTC9iK0hzWGl2VElrMlZZQzZs?=
 =?utf-8?B?YkV0RVdEZkRVS3dpVDVhTUNSVWNWbUhFK1JEZlo4a09hK0JTR3I1WkIveUhS?=
 =?utf-8?B?Nk8vd3JCdHZ6cDc4bkpkN25Bbi8rZDd6OEpzR0tUUFZ5OHdvU1BxRWNjTlNo?=
 =?utf-8?B?YXlrNGR3Um9LdHk5YzBQazVXbmRhdjFjV3lSKysybHJTKytHdzRMWlRreEVI?=
 =?utf-8?B?UWU5ZytBNkp6M2NSaGRDT1FlVUF2aFc3NVhPSHpleDFSQVp6YnAxWmpBS0Fo?=
 =?utf-8?B?a1l1SFBpSG5LU2h0NU1qanNpMlBSakJ4UkJUS3lsYlF5SkM0akM3aTBvcHBk?=
 =?utf-8?B?RnhudStoVGhVRHBNWTdpS1BwZTBRZFpWRThZSzJ3cWV4aDRBV2txSWgzS2VP?=
 =?utf-8?B?U1IxcS93V0xpTXlReDMyZERSY29CdERNOVF0UzBpZWNFaDJ2aGh4WEhWUjRC?=
 =?utf-8?B?WkEzY0NNOVo4TUpwZjJGeUhzV24rcE9LcStwamxRTkRpR3VaSmdPelBJQmEy?=
 =?utf-8?B?U0RycDRIdGQwL09tQkRFVzdkZ2hxOVZ3NURPTnhrbXc3UmJ1SzVPaDh0ekNT?=
 =?utf-8?B?Yy9TTWRKMksvUFNWei9hcTVvU1JLYzV5d0ExUDFTNzZueHJmbWN4cEtJU2dk?=
 =?utf-8?B?YTVzQ0JzbXpPTndob2JzaVI2V3FTRlhmb3BLbW9rVWZLUzIwOFdVbDRjN0xE?=
 =?utf-8?B?cmhmQ2YxWThQcURaT3VUMUtZQkI4MWlLcUc5cGNMOG9NOG9SR1owV1U3SnZt?=
 =?utf-8?B?K25DVXlwTUQvRXFvTko3QnFHVFdHcE15SkxaNHFhYzkxZVkrZ28zcjdIQ2JQ?=
 =?utf-8?B?Tk5kbmRnc21vQ3BuNGhEVVdrdFViV3dXZnFRL21kd0RUd3Y2NThpUkxhbFcx?=
 =?utf-8?B?UEdVSVo3RVM3MG5veE5KY1RPeG91MEFyQmE3SzhWTlQ4SXZxMDljemF4dkFS?=
 =?utf-8?B?VjdaZ0tmMWd2NGVDaTUxYWNVRGFHMFRHZjR1K3hTMHVRcWFmNjRPbCtOY3BO?=
 =?utf-8?B?VlJqZWovYndLakhraHk3Mmo0bkNMTXVjbWlTV0JQOUlqVStweG4zb2dKbWl1?=
 =?utf-8?B?Wm9nOXhUWFJBczdkRUhLcFlwYXhWS05qbkJPTFMvdjJubHViSlZ2dUd6empQ?=
 =?utf-8?B?cFZpS3ljamhQb3QzVFdtQzVINFg3RTdLc3NDWWozNkNJV01vd1pOeEJsUFMv?=
 =?utf-8?B?S0lqZE9lWEwzUW9SS1NTWVYrYk5YSmhGK1VkRUxiV2szVGNsL3RiRnVheDNa?=
 =?utf-8?B?ekRSV3kzMWNLM0xOUU9venhMVVRFNW1BM1ZhWXBldk9RdXJhd2N1emhRcWF2?=
 =?utf-8?B?NERNMHhKVTJsMlZLWmViV25YcWNUWVd1bkhjSlBQeVFVQU9zVkJ5Z2NUNGRW?=
 =?utf-8?B?WVFnK3JKQVhCaDJMRGhJOVBtc1c3MmdpRStZcWkrMWFNb3JHakFBbmcweklu?=
 =?utf-8?B?Q2ZrYmZ5SDhjYy9FbUxFRUNka29VZ2VuWEwvS2xVR3dZb3NQQXY4aU5EWnIr?=
 =?utf-8?B?aEhKYk9iczNTbWZHcUNNSitNSGk5a2kxamJ6OWQwYTJhTDNNUE5CTXRKRjBB?=
 =?utf-8?B?RkdiWVh1K3JmY1BMNVMxV2lOTWR5Qjg4Uk1ybm1nWUt4QTR5RmZ4VnQwTUow?=
 =?utf-8?B?Znc1RGFROStTMXE3a1lCVEZic3NZWk9SVEwxaTc0VWRBSHJqVkYxRWphVDkv?=
 =?utf-8?B?ODhyR3FTRkt2bDZuajJYM2M5YkVPMS96NWp5YS9FdVFXZ0lKa2QxRm8vS3Z0?=
 =?utf-8?B?NHR4S21NbCtzRW1OWk9Vd2FQQ3hpT1JVUHAyd2ZjVGEydWFyQ3BJaWVwTjZI?=
 =?utf-8?B?akJXU2JCS1dsMGJYMWgwWHI5dFFwSDk2WGdmMVA4dHpHdnpTd2pLb3BtWWNt?=
 =?utf-8?B?WWFHREIyYTlmS0tYM2YxQjdBSDZMZnpBMll0UDhmZXN5cnBPRnBJZ0JnVTQ4?=
 =?utf-8?B?TGd4enhCZ2ZJOTIxdkhSWmx0ZEVNTVBheVlIZklRbDJ5OE9FbGtIMWJBekJH?=
 =?utf-8?B?b0Y4eWhnOXNjK0VyTnJpcFpsT3lJdGEvdkU2VTc1TGdMSlROM0dOMkZnMmFM?=
 =?utf-8?B?aTlDT09LZUc4S3JjNkJvSFpiWmJUZEdhWDdtdlhPMDE4TUpmc0V6ZE03dHNS?=
 =?utf-8?B?UmFSWU55WDNLYXl5MEhkL1ErdU5USHY0elVKamFnY00vNmszdklweVBDeTNi?=
 =?utf-8?Q?cG/pYs/wdJAUTeE/p3bR38c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bm5aT2xxTHVBeVc5emxMOUIzemhyV3lSRitJeFVSSHhzaWdZckFtcnJOYlNE?=
 =?utf-8?B?ZytRMHhtMGJuSXFaWDkyZmdmSTZmeXZ4VUxsaEZxaWx0N3NrUVlHVU43d1NX?=
 =?utf-8?B?VlZYSjNFYWpTRG1TYTBudmtrSTBQR1NXSFMxY3p2djdsVmdBd3VsM1FSV1RD?=
 =?utf-8?B?NDZQMHBNQUtFd01LbFlPSHI3ZHlHMVhBR1pVTzlBQ042WjEyY2NFc200NG85?=
 =?utf-8?B?eFRvUWZhMEw4dGNVcVJ1Y0luQkMvaTE3WDJKb2VTSXVhUE9zWnBKajlGT05U?=
 =?utf-8?B?QWpOamw3Z2NRZ1pBQjZlYmlQRGpVOFNaaEplOC83VHhiQ1ZDdFFxVlRiNUJq?=
 =?utf-8?B?cUxnRDJybExFNHcwTG1KSnljcHhFbjBFTFJ0blV1RklpeVQrRVFTWGNyWkZV?=
 =?utf-8?B?OUdCTk5nVzFSdTN1SFFSZWJMNjZFRmV4RDRERnYzc1FRV3dLNm4wczBiSk9z?=
 =?utf-8?B?MDIxUkV1SnNSQUFGaUtHVGJzL0s4L1EzZlk2NzRESG5vLzkzTFNTOUJNcmNo?=
 =?utf-8?B?d0lrMFB6aFRhRE1CeDdkUnQ1eFF4a1NpbVZqR0VyYnFYKzE3Y0ZEbUFJN2ZR?=
 =?utf-8?B?YjZaeGlkdWJQSXBmSnlGa0tVU21iY3hTZzFOeUJjZ0s5dmRhRlJqQUk2Mjlz?=
 =?utf-8?B?VGszZ2RxUGY2dGMyNzJpejlDVXJ2N0J4bHo0aHBubnRjVzlndkRnSE4zUFRr?=
 =?utf-8?B?Qkl6MTNtOC9WUlNGQW05VEtOWnk0d21CRFJoczRiU0hYU1M5TjR1ZnBGeThy?=
 =?utf-8?B?RGc1NURJSmx2VkxvcmN0dk9pOVpFRUxORTNjbVNMbGFJUEw0UGdjV1MvWDFt?=
 =?utf-8?B?aUpLMDlia0FrZnFTZ2FjWHlsT3VNdDNPREhaNHpMc3JybTZOY2NhV2VzU0V3?=
 =?utf-8?B?N1M3MFkvK04wNmV2ZDUvaEI4djFCcStya3pyWHNlQW5SaGxqbVBUSmx3NW05?=
 =?utf-8?B?STEzK2p2QmhsYll4UVBSVU1EMDV6WGplT2pDNmJsK3ZLNXk1dkEzV2Jlcjkv?=
 =?utf-8?B?cFB5WEZOUmFnU2VrN2RieWJveFhaZXBYUVZRVFFtUENlSitHamwvaStNdHQ0?=
 =?utf-8?B?MGJOQ1ZxaXBZQVIycGJJMWZtMVlNeVlBSGVaaHVnNjFBazN2UWpCTi81MDJP?=
 =?utf-8?B?WGdOTEhrNnBWOWJYenl5STluanlXL1M5MG4yMEdrZ2F1dlJmK3hVUkNQV3lX?=
 =?utf-8?B?S20rYlo2cWUvZ3M4VENhbS9QN2RRM1E1a1ZTZ3hqZE1FS09FRTM1ZWYycjln?=
 =?utf-8?B?QTBRM21qeDB4Y0NIbzRCYUF2NjRtQU50YTl3N2F0VGp2V1dVWlQvNUFpYS9P?=
 =?utf-8?B?ZmhtY3hzM1JXTGNoVVBiT3Bnbk1VamxDK2ExQ1pCdFBiR2JHN0JoV3FHaGdB?=
 =?utf-8?B?MzJTZGxGU0hvYzNCWDFZbWlwTEc1bm5xS0gyUGZWQkNMaWtPK1BqbEtUM3M3?=
 =?utf-8?B?RGRSNHZwendaaFJXMjFZVkZWN1MxSnNiWm1WVkhpVFNNOHU1RXZGazJkNFJa?=
 =?utf-8?B?TFhadExSZWZMMjlFSS9JMmJtdWc2U3J6MytwS1pwZnpPeXQyMmswYTg3eFBZ?=
 =?utf-8?B?SHVEWGprVTBEYlNnb0xmVHRPRUVOc0p4ZlAvRDN4NC9Ia0QvQ1BXR0NYVzIw?=
 =?utf-8?B?dVV5VjZSU1NZSmxHQndlU0dSb1JXRHpuNGpRYXpIQzlWZitRYktTdnlJVi9l?=
 =?utf-8?B?ZTJZQk1lK0tHSkx4dDdLMjZNSWplbXJDYmpjMjZ3T3piME1qRTNiSmd1OHFx?=
 =?utf-8?B?RXd1Y2VtOHFtM1FVWE5ycEF1UlBUMEZGVUY0SjBVaHlNZXJIUk1Qak96ZDl2?=
 =?utf-8?B?b3V2V0U2UnExVWVZdlhPOUYxMitDVlZFRFJ2YmtNTDN1Z1dlWmNwaTc5cFF6?=
 =?utf-8?B?eVY1M0VSQWhZUFRSTXh2YTJrUE1ZaDZjcTA0bk11ZFo2N0w3K3NCTzRaVFAr?=
 =?utf-8?B?UnJseFFIYU4xdGdOTzNDWVNuVEVrRHJCTmRRbVczUlBvaUlHWEhCUkpuVDlD?=
 =?utf-8?B?My9yV0lQeUpERGdDNExialdWbm9DVHg2ZDlmWkg4SzZCZmpWUFFpYXA4RXBm?=
 =?utf-8?B?MmwyMmRQQ3prOGl1bmRnbXZ5L3g3ZkwrV1NrV2hlV2t6akZrRGJEa0pTTWVz?=
 =?utf-8?B?TlpGV2x1NlVNZDNmR2k1c092UmE1amUxWEwzMHZUNVMrZDl6akdReWptQ0g3?=
 =?utf-8?B?UmcvdVp1OFVLc3h3aDFQS2ZCUE5SWEdzSDk0eVZpeURRQUJWQ2txRjhVQm5O?=
 =?utf-8?B?U09uNCtuaDJzNVRUSTNoUmRKOUJOck9YWTFMTWt1V3c3OWxmd0hsOS9naHJG?=
 =?utf-8?B?L3RhMUM3UkdrU3pJTzN4RU91N1E2WlprTjhMRzkveVNjeFpJYVJ5d0JOOXV6?=
 =?utf-8?Q?mbxQ6aGXM0ihesTE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60A547017CA1F540A9240D9337B0F9AB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fade64-b501-4c1c-7875-08de6a226f70
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 10:35:26.4063 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i4EOmjs6HvzS7OSi8gag26B/Z6/RE6vKM5cMPa6qw+A+URMxIbwZGTz+b/CYJhEqSP/gD/+SB/VXK0l4sXFFbkvQFhtm8AB8p6WvDpIyfxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR03MB9357
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

T24gTW9uLCAyMDI2LTAyLTA5IGF0IDEwOjM5IC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBSZW1vdmUgZW1wdHkgYm9hcmRfaW5pdCgpIGZ1bmN0aW9uIGFuZCBhZGp1c3QgZGVmY29uZmln
IHRvIG5vdA0KPiByZXF1aXJlDQo+IGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgTGVj
aG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiAtLS0NCj4gwqBib2FyZC9tZWRpYXRlay9t
dDgzOTBfZXZrL210ODM5MF9ldmsuYyB8IDUgLS0tLS0NCj4gwqBjb25maWdzL210ODM5MF9ldmtf
ZGVmY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxICsNCj4gwqAyIGZpbGVzIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2JvYXJk
L21lZGlhdGVrL210ODM5MF9ldmsvbXQ4MzkwX2V2ay5jDQo+IGIvYm9hcmQvbWVkaWF0ZWsvbXQ4
MzkwX2V2ay9tdDgzOTBfZXZrLmMNCj4gaW5kZXggMWNhNDAzNjZhNTUuLjU3MzExOTliZjgzIDEw
MDY0NA0KPiAtLS0gYS9ib2FyZC9tZWRpYXRlay9tdDgzOTBfZXZrL210ODM5MF9ldmsuYw0KPiAr
KysgYi9ib2FyZC9tZWRpYXRlay9tdDgzOTBfZXZrL210ODM5MF9ldmsuYw0KPiBAQCAtNywxMSAr
Nyw2IEBADQo+IMKgI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQo+IMKgI2luY2x1ZGUgPGFzbS9h
cm12OC9tbXUuaD4NCj4gwqANCj4gLWludCBib2FyZF9pbml0KHZvaWQpDQo+IC17DQo+IC0JcmV0
dXJuIDA7DQo+IC19DQo+IC0NCj4gwqBzdGF0aWMgc3RydWN0IG1tX3JlZ2lvbiBtdDgzOTBfZXZr
X21lbV9tYXBbXSA9IHsNCj4gwqAJew0KPiDCoAkJLyogRERSICovDQo+IGRpZmYgLS1naXQgYS9j
b25maWdzL210ODM5MF9ldmtfZGVmY29uZmlnDQo+IGIvY29uZmlncy9tdDgzOTBfZXZrX2RlZmNv
bmZpZw0KPiBpbmRleCA5YmMxZDkyMjU4Ny4uMDY0MzdiZTYyNWUgMTAwNjQ0DQo+IC0tLSBhL2Nv
bmZpZ3MvbXQ4MzkwX2V2a19kZWZjb25maWcNCj4gKysrIGIvY29uZmlncy9tdDgzOTBfZXZrX2Rl
ZmNvbmZpZw0KPiBAQCAtOSw2ICs5LDcgQEAgQ09ORklHX0RFRkFVTFRfREVWSUNFX1RSRUU9Im1l
ZGlhdGVrL210ODM5MC1nZW5pby0NCj4gNzAwLWV2ayINCj4gwqBDT05GSUdfVEFSR0VUX01UODE4
OD15DQo+IMKgQ09ORklHX1NZU19MT0FEX0FERFI9MHg0YzAwMDAwMA0KPiDCoENPTkZJR19JREVO
VF9TVFJJTkc9Im10ODM5MC1ldmsiDQo+ICsjIENPTkZJR19CT0FSRF9JTklUIGlzIG5vdCBzZXQN
Cj4gwqBDT05GSUdfQ01EX0NMSz15DQo+IMKgQ09ORklHX0NNRF9HUFQ9eQ0KPiDCoENPTkZJR19D
TURfTU1DPXkNCj4gDQoNClJldmlld2VkLWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1bC5saW5AbWVk
aWF0ZWsuY29tPg0KDQpUaGFua3MhDQpNYWNwYXVsIExpbg0K
