Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF5BEB48FB
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 10:37:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F6C083015;
	Thu, 12 Feb 2026 11:36:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="LVYG32ls";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="a8+D4d5T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 896FE83CB5; Thu, 12 Feb 2026 11:36:57 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2361980FA1
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 11:36:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: b9688d2a07fe11f1b7fc4fdb8733b2bc-20260212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=tD4cEQdlmtZuukjoaHqTWDp5lU0xxoYLRPsSPoIU5S4=; 
 b=LVYG32lsMQpLqVNTfTmmIn5B+erUZahD2vpVMpV+bE+cu1COapSvRBW8aWALvsu1r9WZ0xWVB4+8k3vt7DvTMgTumCk/EKSXmsO358x8KfuNALlL+A65nCuD7kZgGZHnRuAQn8u8ioSLDuLlCJ3kl8OIomlxQNcob/rhHe6vRGQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:18644e1b-721c-4569-a6d3-bd6cc9500415, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:82d09ff0-16bd-4243-b4ca-b08ca08ab1d8,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b9688d2a07fe11f1b7fc4fdb8733b2bc-20260212
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 882790692; Thu, 12 Feb 2026 18:36:43 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Feb 2026 18:36:42 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 12 Feb 2026 18:36:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kf6g43CRv31NOAi32WBBFllAfhkv6kiUcSxsZGXfSZEP23sHv3VXeN5l8+PBhFInos4k0IgXdjmNdSa1WXZbdIvt5g236emZtGM6YrhTvWhM3ANv+BpISFIy2t2uLvvkjUurB2ItMOmk/mjngMEUPW8IZ3V766IDiwkRGeE+/ioLCTGk2ZQ3+eTYkbzTwxEnVnXSQh89zH2U7+TKDBCfC5E7C3TX2Iy8K48cRUH1xPwl3TGtcgvs5aEe1n7sV3E2KQzaYiy4HtjzOu9qblEB7CzRdjYAXIh35g/KCBfvYje8ZIJcpAH9rppITOAu/QJrN3Sp8tAhe2Ob4dEASLsrZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tD4cEQdlmtZuukjoaHqTWDp5lU0xxoYLRPsSPoIU5S4=;
 b=IfvFAdqvBL1GyQ2COw0SFj5/xa9NBIToWneLWWdQJdCN48LZx9CdJSsiKKXlz3XARgycXwcVO1Z38ZiLYY2nQ6cD1cFtP3eUt3JKewAt+36OpggtDCb0GBFvcic9W56jFFvWEKCmpmBK7nIwm0xIIxJL9bAVSd8Q3FNTgffm/UgU94r79cEjN3KV8Uqr58cCfrjeYMUjtzVHjneu/CjewBQae3WV3SAup4jA3fCM5alO2vwZTpmTQlvQ2HUuMc1LSwovmXGA69KW/d9b/lw7qsOreJZhw8pqgY5lX6Qe3aqogIsWtPtlCGEg/5y67gSRVGgXzRh74d7zk7wZhvEz4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tD4cEQdlmtZuukjoaHqTWDp5lU0xxoYLRPsSPoIU5S4=;
 b=a8+D4d5TgWF5HztYKAiUWMpQhwnj7QJgLMiAnMpwM1jIVJeHow/lmTPgQA80Ctnuwoe/IFF5qoRF0b0zfMAHqlTOTal28YzOcrxStUTCMnf2ef1aeSRJiSzm7Axi2AZgfYGhfjux2g9a3UgUwriF2XCyCt80KEi9wRFuANrImkw=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by KUZPR03MB9357.apcprd03.prod.outlook.com (2603:1096:d10:2c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 10:36:40 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 10:36:40 +0000
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
Subject: Re: [PATCH v2 7/7] arm: mediatek: add CONFIG_MTK_MEM_MAP_DDR_BASE_PHY
Thread-Topic: [PATCH v2 7/7] arm: mediatek: add CONFIG_MTK_MEM_MAP_DDR_BASE_PHY
Thread-Index: AQHcmed7jvJeVS1GhUutAOijtShD67V+4yAA
Date: Thu, 12 Feb 2026 10:36:39 +0000
Message-ID: <be7e068b1380a7a5e0813fb0540b3953f9b88621.camel@mediatek.com>
References: <20260209-mtk-mach-clean-up-duplicates-v2-0-e3b22282c74d@baylibre.com>
 <20260209-mtk-mach-clean-up-duplicates-v2-7-e3b22282c74d@baylibre.com>
In-Reply-To: <20260209-mtk-mach-clean-up-duplicates-v2-7-e3b22282c74d@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|KUZPR03MB9357:EE_
x-ms-office365-filtering-correlation-id: a0124706-8686-4745-60eb-08de6a229b49
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dkpKbnMvU3hpU2VzTkwyWWNFRlZCeXFCQUFwb1VlT1A2T2lIWlNLaVFXdUJG?=
 =?utf-8?B?OGZPVDViK2dXZ0g2TVZ4NmFYMEljdFc3eDZxUHBMOUZ6Zkl1UVNGMVdLV1pU?=
 =?utf-8?B?MjMzdnhLaVBHeVNtdmhHM0hSR3lsSzBjQy9yQjFSUjJTa3d1aHk3VExwcGN1?=
 =?utf-8?B?b2dJWnIzb0dZWFNsYU5wNmJzVkpibWdBOUpOMlF4NTF3ek5nZU5VcjJMRFVX?=
 =?utf-8?B?dDk5MVpmTHlYSlJLbEVZc3d0WlorekNQUGRFYWdsWWFNdWJUTm5ncW9POGxH?=
 =?utf-8?B?ZUZtZzNkT3p3aWtGanczaDlIQ3ZjQVpHOVJ5RCsxTDQ2QjdrM2NkVzNlMmZB?=
 =?utf-8?B?R0VVZEZZOUFSK29oOWsrT3lMZUFVWkFpZWs1enBYODJoRTBBS1FJTk1SRXl5?=
 =?utf-8?B?Z2ExT0dxWXBBL1pZYUh3cjRpNE9qaGtmWDBxRmZhQ01VQ1NSY01vZGoxQTRY?=
 =?utf-8?B?TStOT3V6NmJrR0NOU1oxVkJtbFNiR1VjK2V5UHR6QTJvZUJCcGZ2WXA0ZVNQ?=
 =?utf-8?B?Y1EwSTVSTEVEZ0FnQ0laVmQ5dEt6cDFHYWs4Qllkb1g2TVZvSXFoejhBeFkr?=
 =?utf-8?B?emJpTmNzTjJ5TmtVSURSU2thUUFTcE9EZHJDZVZ6a2lFZkhYbjZ1V3Z1K0xk?=
 =?utf-8?B?aVNkSUI2T2xxbm90WVdMMUlSSmFYMk1BKzlyNk9teTZqZlE4OFJaSTdTVFdH?=
 =?utf-8?B?cUZnajdjeFJzdlNPOGhsZVJvNmlISm5INngyWHE1Zm14VGtDcnl4U1ZlOCsy?=
 =?utf-8?B?cTRrVkdEYkxhZUdwQnlQbG1MVG50YTVRclc3RUpYZ3pTM0E1WDFSc01DbER0?=
 =?utf-8?B?UFhqL2dVOUlyY3J4REdUamJtVC94LzB0b2w4bEtwNW9lNzhCVTdlbmlUdzhr?=
 =?utf-8?B?V2pLQkdVRCtkMGt1aTF2dUV2VElPTnU1VXdORkZvWXhpdmVIaUU0MlAzRzhm?=
 =?utf-8?B?STlxYkhkZXdtK3VuRDhybDBwN3ZQcHMvZTRSRTdteStIL3o4RS9DWFQxSDV3?=
 =?utf-8?B?ektBQ2pFQ1E4d1kva2laNnk2dG9Wd0tkQ3BzT1ZNQXVXcVlPcTVLVHk2ZTRF?=
 =?utf-8?B?UlhhVUZkZ1JFenZkaklFMG00cmwyQnFKZWNidGFpeHd3U1NEWHJHSUtrVjRX?=
 =?utf-8?B?MktpMUFPSVo4Q3lPMHlMVURsbHJCUTNKVFQ3Q1hmQmQxMi9VRmJ1bm1vMzN1?=
 =?utf-8?B?MWVxaGU4VHo0L3VrM1BzM0REYnROT0FxWUw2VlJJOE02a0R4SC9haHM3dnN3?=
 =?utf-8?B?RjIrTWJnVm0yYkMrY3BFVjlRQWl6R2M2L0ZmTWxjZlp0b01RM2czbXFWRElB?=
 =?utf-8?B?MG1oMm13bE9ibEtWMk9XQ0x0N05SckdIZHZlVHR5SkdBR3lEQ0dtR0tvYWVC?=
 =?utf-8?B?OEFzT2d3Y01ZN2tKc1MvWEtCQjFuQmVSdGZTeW56aFNEb2FaaTlHTkJ1dDhk?=
 =?utf-8?B?RlB0STFEb3VzcUlEYXZqMThoTnFubjFhaU04Z1phQ1VZWW4rVmJkejJuWkdK?=
 =?utf-8?B?U1BSOUZ3UkJZS0xrdnNFWEhtUDZ1QmllQkphczJXK0tTdEh3R1NMeTBSRUVD?=
 =?utf-8?B?YmJJL2ZQSmJlY3QvVnJXWlNJemlhaVJXMW94Q0pYVUJhYml1dU91dlRQdWNT?=
 =?utf-8?B?RnViNFVtTUpSNW9OYmtzWjl0ckVQUnlrdjVBaWdxMkMzT3M0MTAxTnVPa3cr?=
 =?utf-8?B?ZGN5M2hKelB3VXo0UFpFSmZxRGJvbzBNVEN6SzRuSi84S29GcEV5UXpleHQy?=
 =?utf-8?B?blc3RlBQREpycDQza2NOUkhBRS9adTNZa3V6UkF6dEhIbFpNVzRya0oyQlRH?=
 =?utf-8?B?Q0JYcVZpS0VUM1FxNXFHUVBZdVBIOUkxUUsxUHBHNGhiZVAvSzZVcXVYNVJN?=
 =?utf-8?B?WWJSUENvcWEvYy8xN1NyNUdPWk5sb2ZxeVAyWEJzK3VXVmRQaWF6U3VRZTh4?=
 =?utf-8?B?Mitad1NGYldOKzVzaUhwb3ZZMnNnMmhEdHlSTm1sUDNwVExLOStqNlhBLytL?=
 =?utf-8?B?Zko1UmpGTVFtZGxqL29uWFhZbUxITGNyWG1MaFZQVHBIaVkvZTRuQzdwdHor?=
 =?utf-8?B?UGM3NTBxcnNUUGxxVnFoQS9qcmJhaXJGMWdIelNkNUZoenk4N2dHS09SZDN2?=
 =?utf-8?B?cmN2OUU4akJ2VmRraHAzTnlmK0MvS3cyRjA0eDB1OGpOTWxUL0kyN1dHNGx6?=
 =?utf-8?Q?+uOW1c23hPivbawBGxvfvDk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHRJQmtjeVV6RkJ2ejNOT0VOSENSQVZEV3lITWZVQkNUMXpLaFRCYlQwWWJW?=
 =?utf-8?B?UlVXa1gxOWVsVWRvZThEOEJhMndKc0pmNFkvYUlNUHBZcURKWURyUWxLeDVh?=
 =?utf-8?B?V0VYKytWQm5ZcS9NbEYwWHFKWXlBZ0lJMzE2QzlQb1hUSERGa21SQ3FnZEhQ?=
 =?utf-8?B?WngyeXQ5bjg0ejI3dUpEMzREMzlOblFvRUt1VGFNeE1ObHVTM3JDbXpNbUpI?=
 =?utf-8?B?Qm8vQ25XVzVDN083d09mZnB2KzQwMGRXb0NYNjk3ZGQzSjJqYlZDaGlsd0Fs?=
 =?utf-8?B?b0FHOWdyVWZxNjl0K2xUU2x6SGZUSFhSSVNIV1NUeG02TjAvbXc2ZWR3dTRJ?=
 =?utf-8?B?RTFiaTIrNXZ1WW1kcCtGSS82R2hzUEIrMEZDWDdFM0VHUW1YYXJybmFOdTJG?=
 =?utf-8?B?RmQ3dnBHQzBURUFiOWdkNHN3R2RFei9XRXo4WTNQclhJMXV6QVAwVXlaZGdp?=
 =?utf-8?B?TFZBSC8xdzFtbC9JZUxaQmdFcnpVdmlSMmFNcTEvRWNPdjZuVG95d3lFUVJ5?=
 =?utf-8?B?dUlaaVNWMS9MUTQyOW9UUlpIUDN0eU8xQW9CaWtiVTZRdUlHRHFCaGdhNVY2?=
 =?utf-8?B?cGIybG01SkpycnpURGRlVEE2MWpDcDJEdU5GN3NtY2tYK1luUFhLOCtGSGFP?=
 =?utf-8?B?bUNQNDlvdTlCVUR1eCtSS043ZGwwYkFBK3NZdFBpdU1hU1pobGpkZEVBN1A2?=
 =?utf-8?B?c2FyL3pvOEdDRE81U2Z5cXh4Tkw1Ukp2eHh4TGg3L0lRemxsdzlaMysrVC95?=
 =?utf-8?B?Y2hsK041R2RzR1RHaXBWalgzeWptYzVobkM1NGp6NEtKdjdIVjRlS1laYkpo?=
 =?utf-8?B?c3I3dHpENlNtRWJ3SVVKT1N5L05KUjVBUW1LSGxMMEo3RVhPaWc2aFFEN1I2?=
 =?utf-8?B?aFZWc29qQzE0Ny9SWTJZZmFBOEkveW5TVXo2d0F0Q0JxcmJ1eUx6akc4M1Fn?=
 =?utf-8?B?TWJMeEtyallObThiQk9ueWtIS0ZtMHZkazVtZThWNndzekFFdncxZWVHTVIz?=
 =?utf-8?B?VlQ5OEZmZENrMVdmcUFQUXZmOFpJam85UzdpR2xnZUlUcThBOEpnK2tiMTQ4?=
 =?utf-8?B?OUNuTmtBMFpUTTArMWRkMnB5WlZUd29IUy9nS1c5WmFPK2E3SVFLK0ZsK2dD?=
 =?utf-8?B?MDNGT0ZTdzZHUnFITkJoeFFoZThoMTFXTEpXalN0U3J1ZFozOE9JMlJJcUdo?=
 =?utf-8?B?VTdGNEl1UUovMFB3YWJFT2FWMWkva1BLSDRIZzNaT21wMFZlT3VESnR6R3Rs?=
 =?utf-8?B?M3pkOEUyeEJoaXhxSThjdlFSU3BqdGlQSDJHRENGSUZobjc1Ykx3NS84b0E4?=
 =?utf-8?B?cVlWUzVmREx3L2VrZ3B1YU9VUFBJeUVlYzVDNjVzZFAwUEt5OHVxQWZPbFdF?=
 =?utf-8?B?QmRoR29zS3hOQ242NTM4a0cwUXVhU2xkNFRCSmlUR1lhVnloZ051Nm1qYzBV?=
 =?utf-8?B?R3FUYWJ1bUdTNGpySDd3WmtmTjQvZEVmcnNhaVF5b3ZGUitIdjloZzZBZ0F1?=
 =?utf-8?B?TTB2YjVpYXM5TVBMTVA5djM3NGlZeFROdWsrRVQrbVB5WW9naWhOTklXMTZP?=
 =?utf-8?B?M1M4NzkyUEwydTFCejNCTXEycUpEaGZDYW04NWR6bDZnTWxyVGdpZU1tK3Y1?=
 =?utf-8?B?TFNzYnByMjRVS2l0amVxYkxDYmVCVzRRMnQ2M1pBcElERVk5RGJ2Ylk4UGxG?=
 =?utf-8?B?RHprYzV0NmQxUW9pVzZYblZramd3Y0hobUNYSis2dy9TSTBjRW1kQytobkx5?=
 =?utf-8?B?ejNpSzhhYjhpOHRraTVzWEEyY2JLd1BzOTJidi8zYzVTRHRlZ2xhaXo0Y29m?=
 =?utf-8?B?SFM1OC81bExRZ050Z1BITU9iT09Zd0pocHUvYUZITmdMY0orMDRlS0w3RDND?=
 =?utf-8?B?ZGRSdFp2VjVtbVl0M09SWi9KUnZVeDZtUzM5UmIxWHZDMVIrZk14YVV0YTZv?=
 =?utf-8?B?Qmo4dVZ5R3FHanBMZSs2c2tSZkpiK3JOZFhIa1FVWG15bkhyeGJKQlhJZEpF?=
 =?utf-8?B?UzZLNUcvMmxlRzM3eWlkeHVPYUFzT2F1K3BWekNGa2hDTDVsZzBhek1RZGtP?=
 =?utf-8?B?QUVNU3kzVjZOZ0cwUTZLUU5BWTIvNjZNdkFtRW5KWXA3Rmw5dUV4VXJpWjFE?=
 =?utf-8?B?TVloZkQzRG1oUVFrTVFkZUpHMjJ0STN0bnNBeEFsWlh4V1dkQ0lpR0lVejBm?=
 =?utf-8?B?dVNjMTZJaUN2cWpVWDJkZm1seEhnanpzOGVydnYrRHVVS3BvblFlL0R1YXNx?=
 =?utf-8?B?cGJFNGx4L3lwUk1rMHJ2MXZrY0ducVA5TVFHQzRmcVRZbitXek9ScmdnTDYr?=
 =?utf-8?B?ZXBYVm1ZOWRmZWZHTkxMVFRIZHZ5QWhQYUFvby9IVEN0Z1dQMGRDN2dId1k3?=
 =?utf-8?Q?ecrSW3/POXsPdhJ0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A66F96890B49F84585A3691EDA584142@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0124706-8686-4745-60eb-08de6a229b49
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 10:36:39.9779 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fp/odbT8kdl/hI/RDzdMDNxi20fEla1+v0CuJUfE6ZlSdM/D682dkej95qEp2DBA4pKuk6WgEZlLn8k59qYKctpug2I47SeIBDS/noI2T/s=
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
PiBBZGQgYSBDT05GSUdfTVRLX01FTV9NQVBfRERSX0JBU0VfUEhZIHZhcmlhYmxlIHRvIHNwZWNp
ZnkgdGhlIEREUg0KPiBiYXNlDQo+IHBoeXNpY2FsIGFkZHJlc3MgZm9yIHRoZSBNZWRpYXRlayBB
Uk12OCBtZW1vcnkgbWFwLiBUaGlzIHdpbGwgYmUgdXNlZA0KPiBieSBNVDgxOTYgaW4gdGhlIGZ1
dHVyZSB3aGljaCBoYXMgYSBkaWZmZXJlbnQgRERSIGJhc2UgYWRkcmVzcyB0aGFuDQo+IG90aGVy
IE1lZGlhdGVrIFNvQ3MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBMZWNobmVyIDxkbGVj
aG5lckBiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiB2MiBjaGFuZ2VzOiBuZXcgcGF0Y2ggaW4gdjIN
Cj4gLS0tDQo+IMKgYXJjaC9hcm0vbWFjaC1tZWRpYXRlay9LY29uZmlnwqDCoMKgwqDCoMKgwqDC
oCB8IDYgKysrKysrDQo+IMKgYXJjaC9hcm0vbWFjaC1tZWRpYXRlay9hcm12OC1tZW0tbWFwLmMg
fCA0ICsrLS0NCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW1lZGlhdGVrL0tjb25maWcg
Yi9hcmNoL2FybS9tYWNoLQ0KPiBtZWRpYXRlay9LY29uZmlnDQo+IGluZGV4IDMzNzE3YTE4NjRm
Li5kMTBhZWRjMzAzYiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vbWFjaC1tZWRpYXRlay9LY29u
ZmlnDQo+ICsrKyBiL2FyY2gvYXJtL21hY2gtbWVkaWF0ZWsvS2NvbmZpZw0KPiBAQCAtMTMyLDYg
KzEzMiwxMiBAQCBlbmRjaG9pY2UNCj4gwqANCj4gwqBpZiBBUk02NA0KPiDCoA0KPiArY29uZmln
IE1US19NRU1fTUFQX0REUl9CQVNFX1BIWQ0KPiArCWhleCAiRERSIHBoeXNpY2FsIGJhc2UgYWRk
cmVzcyINCj4gKwlkZWZhdWx0IDB4NDAwMDAwMDANCj4gKwloZWxwDQo+ICsJCVRhcmdldC1zcGVj
aWZpYyBERFIgcGh5c2ljYWwgYmFzZSBhZGRyZXNzLg0KPiArDQo+IMKgY29uZmlnIE1US19NRU1f
TUFQX0REUl9TSVpFDQo+IMKgCWhleCAiRERSIC5zaXplIGluIG1lbV9tYXAiDQo+IMKgCWRlZmF1
bHQgMHgyMDAwMDAwMDAgaWYgVEFSR0VUX01UNzk4NyB8fCBUQVJHRVRfTVQ3OTg4IHx8DQo+IFRB
UkdFVF9NVDgxODgNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtbWVkaWF0ZWsvYXJtdjgt
bWVtLW1hcC5jIGIvYXJjaC9hcm0vbWFjaC0NCj4gbWVkaWF0ZWsvYXJtdjgtbWVtLW1hcC5jDQo+
IGluZGV4IDM1ODdhMmE5ZGQyLi5jYmFhOWI0YzI2NyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0v
bWFjaC1tZWRpYXRlay9hcm12OC1tZW0tbWFwLmMNCj4gKysrIGIvYXJjaC9hcm0vbWFjaC1tZWRp
YXRlay9hcm12OC1tZW0tbWFwLmMNCj4gQEAgLTUsOCArNSw4IEBADQo+IMKgc3RhdGljIHN0cnVj
dCBtbV9yZWdpb24gbWVkaWF0ZWtfbWVtX21hcFtdID0gew0KPiDCoAl7DQo+IMKgCQkvKiBERFIg
Ki8NCj4gLQkJLnZpcnQgPSAweDQwMDAwMDAwVUwsDQo+IC0JCS5waHlzID0gMHg0MDAwMDAwMFVM
LA0KPiArCQkudmlydCA9IENPTkZJR19NVEtfTUVNX01BUF9ERFJfQkFTRV9QSFksDQo+ICsJCS5w
aHlzID0gQ09ORklHX01US19NRU1fTUFQX0REUl9CQVNFX1BIWSwNCj4gwqAJCS5zaXplID0gQ09O
RklHX01US19NRU1fTUFQX0REUl9TSVpFLA0KPiDCoAkJLmF0dHJzID0gUFRFX0JMT0NLX01FTVRZ
UEUoTVRfTk9STUFMKSB8DQo+IFBURV9CTE9DS19PVVRFUl9TSEFSRSwNCj4gwqAJfSwgew0KPiAN
Cg0KUmV2aWV3ZWQtYnk6IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5jb20+DQoN
ClRoYW5rcyENCk1hY3BhdWwgTGluDQo=
