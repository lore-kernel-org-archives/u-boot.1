Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1788FEB48EB
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 10:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCD5D8367F;
	Thu, 12 Feb 2026 11:01:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="QPdlRwBJ";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="s+DGRQIO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BD0A83A47; Thu, 12 Feb 2026 11:01:00 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49B0A83015
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 11:00:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: b50818d607f911f185319dbc3099e8fb-20260212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=FXWPPWMBvMN2AbLWwRZwIU3qnxJaYROByz50mFH6d/g=; 
 b=QPdlRwBJ6a1B3neR5pKl7aR0cqlCJio29V/9yUtO7rfIn4XnHk++pfswJ62wv2KvyG/tzE6p3T90J4jBy2SChkfHKvyxFGiKg+TxbreQoefI7PRbD7CQiAal0VecYRE57u+zLChrGuibjUftSobvMssO8TtFC5B12+RYcBFbr8Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:f66fe42c-fabd-4788-b9fb-b7fd164dc65d, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:4224395b-a957-4259-bcca-d3af718d7034,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil
 ,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b50818d607f911f185319dbc3099e8fb-20260212
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2028590410; Thu, 12 Feb 2026 18:00:49 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Feb 2026 18:00:47 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 12 Feb 2026 18:00:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmELU1IyxXznayqMeC66POwhznU/Y5dwCDNFeqIansoo9z2WL+OFmIPqWWQvcmkHLDSPSHbClIE2+mFUKxKy0oOKIy1t3lV9BcVXULWMJIcPz8p1KKyWHCcPJcJjOOx0W0qZX2r03tRA7aoD3IvEQPqxNeqwoBoAf08za6KpQDcPccLpqOdme057Et16zwHYHBzetWhk3WqNtdGcftbPSwS/2m0nRLb8glgpA4TrmnzzmNQNtTYTDWynQyQZeqwliOAqjDHisSdbe2HX5gNYvlJf8lw5YK0pRBH6Ni+oXTPu2DEqg92yfTqk5RHl9/tFBtDKGML7fnU4m6lsPzxSTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXWPPWMBvMN2AbLWwRZwIU3qnxJaYROByz50mFH6d/g=;
 b=QQJiGVT0PIyd+cf+0qoCoJXdid/9bn29VxNh7eH7kFcG69o7EQyHIvay0e0Be2Nipj7hpRnlYf5rNPDMHXTYJ7S2lhnVFDz9s2Vwcb1MliELAswx+syBEkjT2ljwQsOxIQHLwwViFXlo8clR4bWF22OsjFalqFgzlC6De8TtAuADD9772pyKPky+XcP7wil+qgcrkh6N4xNdSZPNagpa4+T+ImmhTEu6yq5JZaDqIMxJX2yS10pqOag8kIhzaGIFbKr5Vdz6xAqm0X8C/Pg3fwsIkrRt0kDJUweE7Y3qOQSz5zoiMUzwyRHoAtIJUPhE03h4UCaJmrFV2PDkyRE//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXWPPWMBvMN2AbLWwRZwIU3qnxJaYROByz50mFH6d/g=;
 b=s+DGRQIOaEiNUJWyaA3WJsIrQLSp4QyfRnwI7+NukjAtMQt4LzlshIpF84piwJQcSn9bJBa6wrNavKVb4i4y2u33rdSHLCISvIh4IzZvzgIaA/Gd6Rfz1gbQmLLmd40QYwByTVnSfRyqCLKR0eHbLCa5BZpEAAsimKX1bXRl/SA=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYPPR03MB9520.apcprd03.prod.outlook.com (2603:1096:405:381::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 10:00:44 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 10:00:43 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>
CC: David Lechner <dlechner@baylibre.com>, "mkorpershoek@kernel.org"
 <mkorpershoek@kernel.org>, =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?=
 <Chunfeng.Yun@mediatek.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "Ryder Lee" <Ryder.Lee@mediatek.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, "peng.fan@nxp.com"
 <peng.fan@nxp.com>, =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?=
 <Weijie.Gao@mediatek.com>, Julien Masson <jmasson@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "semen.protsenko@linaro.org" <semen.protsenko@linaro.org>
Subject: Re: [PATCH v3] board: mediatek: add MT8370 EVK board support
Thread-Topic: [PATCH v3] board: mediatek: add MT8370 EVK board support
Thread-Index: AQHcmnB8yc2ok/hIlUuq/itxc1YODrV+2AQA
Date: Thu, 12 Feb 2026 10:00:43 +0000
Message-ID: <8e8f7bb90080180be9c0620b354dd54e6aaf7009.camel@mediatek.com>
References: <20260210-add-mt8370-evk-board-v3-1-faf40de5f402@baylibre.com>
In-Reply-To: <20260210-add-mt8370-evk-board-v3-1-faf40de5f402@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYPPR03MB9520:EE_
x-ms-office365-filtering-correlation-id: 41943cad-c01f-4637-cbef-08de6a1d961b
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MnMzUkhmUFJLUHFFMnJxNkY2Q0ZydWk4aFRUN1JRaUNjMWtmZVpBeVRFLzBG?=
 =?utf-8?B?QWIvaWkwdHJZU2RycVJ1dXRvRXNsOG1nZ1JlV280UUVDZUdPUWFOMXVNUDE1?=
 =?utf-8?B?c3JlS25HV2JOOTJtRXlVaG5nQjJ5N1VoLzZRMG9OUzAyTDY4SXhXbVRpbktz?=
 =?utf-8?B?Si9LMWYyZjkvQWwwUWNOTDdCd2dYbk1XMzNPOUh4MGw4a3dzZU1kdW9Majd5?=
 =?utf-8?B?SGpxVENqd2FzYkF6RUUyNVRQbFo3OVBBL0FNaHJjYUlNWExaMFJYc1dpVGVz?=
 =?utf-8?B?U29UbHNPVXZlTlNZYmJ6clh0R1pBNnV5MXViSzhuL3VRU3l0TEFueXBrOW1M?=
 =?utf-8?B?TEc2VzNva1prMnJNeVpsemFkZzJXdXlsbGFQdHVLeDE5OThIYXFDbDFUTDZt?=
 =?utf-8?B?bTVoTS9UWlBnRUxhbU5KRDFmUXFrMDdrVFlydmFKQ2M0UUJjbml2TXJVMEpo?=
 =?utf-8?B?UTBQcklJckFuSVNCd3dpK3lITDk3K1hHdkx1VnZCdEhqTGtPcmVrNmZKVUY3?=
 =?utf-8?B?MCs3KzFuSVlXOHZFZ2l4dTAxTjlXTFU2alBBT01ScTlBNEptWERlYWJiQ2s2?=
 =?utf-8?B?cmNhRkJLUXNWaTlGYkJBQ2JBYkxJSlV5bFhDNzBTUXp1ZGlVaW1lcXVETmQy?=
 =?utf-8?B?S3pvZFB0VDA2NWZKbjRMRjgwMEVPVWM5bU44NXM5aXc3cHlkM1FIdjUyMnc2?=
 =?utf-8?B?WGY1VWxLSUx3aUZWVGpQMHBqQWdnT2xUQUdidkFna2plK0YyWEJKbEhzTExv?=
 =?utf-8?B?RVBwcE0ySUZ6cDVHUHVmUmpTK3hvRWk1Q1dEc1czK0VsM0E2NkVmUU80Q29a?=
 =?utf-8?B?RE5HSDVLMi9WR2NUbVpoQjkvZUVZbnJjNGdPNE50ajArMzdMaU5tTkZuZ04w?=
 =?utf-8?B?MUdmSUtCTEJtRytNY1RabXBPL0hWSlBtc2xydXVuTGRVVnNVOUo2blRYNGVY?=
 =?utf-8?B?SmxlRy9UTzFwWlZFU3FaZzNSOW1kaWt1di9oVWlPTWNPQUxGQkRkRkxSZWtT?=
 =?utf-8?B?UGp3OWQvN3Z1T3I0ZG9tV0ZhQWQ0eVRQZGlSYjlPUWdCVWdoK2YvWWkvTE5J?=
 =?utf-8?B?WHZzOFlGQTZ0VWRLbU9kMkM2S1pnV1ZOaGswY0w3VitTM25ibmdoZ2VaN3hs?=
 =?utf-8?B?UXExL3dhQjkyQytxOGc1azZzTmVlWDVWL2k4b3c2U3RrT2ZnVE1QckZQVEpN?=
 =?utf-8?B?UVRmOE5MdWJ1N3NtM1V4ajVybitJd2FsOU10VzdmeUVrRTdQbG44OTgweDhN?=
 =?utf-8?B?TTJCYlV2Y1hYclp3UzBpOGZ3U2kyQnVpVE82dkZDL1ZSZEZ0ZCtnalIydUkw?=
 =?utf-8?B?QUtHWklpMXl4NUlJZkFSYlVta25ZNUFFejh2eDNnS3JzcmM0V2gwWjBsSGpR?=
 =?utf-8?B?WUhQdlFuZmYxWWNuSng2ZmNoYitNb1RYU2xBdktwclBZT3dWcWk3TE1mbVRM?=
 =?utf-8?B?eEo3djdkUCtOVlZWNElidE85Q0JTUytsb1ZTUTB4SzBEZ0Z1cUNmNlk4TGJo?=
 =?utf-8?B?VG5aRERoZTVjRnVHbXdPWWw4NTdrTTcxZnc0NnI0N2tBSkFON2wxQkZYMnRC?=
 =?utf-8?B?RGtlck1rd0RSVGl1OXJGMUlrOG9hbUc2NWxwYllqa2V0VXcwbWw3QnkzNHBk?=
 =?utf-8?B?cUxqQVBXcWJEb2Q3bkc1NEJxa2pyWmxScnNHT2tCYUFmTnN0QUkwMmZ6ZzJF?=
 =?utf-8?B?bzJ3dnRGeFYzSnhZL0xpc3Nldi9uOWZBeUNJQkNLdDdlTFAwY3BLNFJZcWV3?=
 =?utf-8?B?eWJVQmx5TWNLY29KbVBPajZFZGIyanAzM21BMDZaKytsS0c0NGMrd1ZORm5X?=
 =?utf-8?B?YVFoQk1FYkdmM0hLeVFsR04vQWkrQkJvRTJOMFBhRkJQT1pvY0piS090SlFl?=
 =?utf-8?B?OTB3LzFLdzRXalpmMlVRV0Q5TlFJcTgrbGVsN2V3bGlSOUV3YzJZZ0ozQm5O?=
 =?utf-8?B?dlhJdU5iZkcxTzdXSGdEa2dKcE0wdVRSNnVDLzhUUmpsb1pETFNpMjF2b1ht?=
 =?utf-8?B?NUNFRWxHcXlzZ1habG1hNGtiMVZoZDJpSk53a0Y2TU5GV1YydCtqV0NOcllt?=
 =?utf-8?B?eXBVaVdpM0xpT3NtWnZPN29iMDRFMHU5Qno3ZGtiemUzZHdJblJIZ1FnKzhn?=
 =?utf-8?B?WDVONWx6b1F6dHZiLzRYdjNIN1RkM0VudklnNEpvT24yazQwNklzaHVsblds?=
 =?utf-8?Q?P0cfaiqBOyoDnUZDUgDND3SHg0Xft9RwUKd10Ncg/ICt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2tWbHd2WmFLMVBxMU1TWTJSM1dzaGV0a21KM3BidjhJVWtPM1cyT2l3a1Z6?=
 =?utf-8?B?VkZDdVpoTDVFTk9HZGNtZytZUXBlcjllUldNbEpRd2tHd2J5bjFDVE5MVm44?=
 =?utf-8?B?a0VEUUo1eGZyUUMxQUNuU0plSFc1QXFqT0dDTy9zZGdubjQ2bE5lQXpjMGdr?=
 =?utf-8?B?Zzh3VDU4MzZYeGI2TmMyNUJjeisyNzQvR0dWUW85YVdrdTRFN3FEcjRpSnpx?=
 =?utf-8?B?allWa0RLNkpmd1lZb3FhckdmWEs3YzRmWXQxVEFsSkdrVitiM05kNisyZTU4?=
 =?utf-8?B?a0RlOXpoMHB4OHBBb2RzV2VjcXMraGVQa2RROTk5YVEydi9KNWhJb0k1S1k1?=
 =?utf-8?B?ZnU3L2tkaHhTVWtsSUpCb2VJWUs5NmdjcGxZdXNiS1QzRGMwMmYxY0RpaHY1?=
 =?utf-8?B?NE5yUkNMaWhxU0NOYmFFbXJuQ2hMcXIvMlZ1TE5PSDNXZHBJeExtVDFYekox?=
 =?utf-8?B?ZTRHNEowUVQ5aEhJem1BSlV5NkZFWmIvckpVMHJZT1BCakp3SVIxQnhNQnV4?=
 =?utf-8?B?dzJzYmp6dlNuLzlxa0hXc2xsNTM3NTNjM3VJS05iRlFtRmgzbksxTC9JNnhq?=
 =?utf-8?B?TjBaMmZMMUVLUVNJbnU2dGVFaHZPdVFNVVh1Rmk5TUJ0ZmdOL2paQndqSFA2?=
 =?utf-8?B?ME9LVHZEQUFzNld2SERSVVNZV0VNZ0d2bkgrZ3ZlM3l2VzRPS0hyM1JlaGNU?=
 =?utf-8?B?R3k1TVkveGFSdjdBaFc1blBUNmJTVWxyR0ZuYnFSOFJiUmdOSEROTmZXUXJj?=
 =?utf-8?B?aVBMbnk1RC9HdjJpUk1nWjFPWTV5MDJJS1R5WUc0Q0dEMUNjb1BwaG1QZFNp?=
 =?utf-8?B?SXVFS2tZUWJZQ3RWQ3BaWVM4ZXRKbHlScmEydXFjUlpKZTRzZVM5Tm5tTnF6?=
 =?utf-8?B?Q1BVN2xpWDUwSEdmZkw2ZlJXNEI2Mi91UkNGMnNqTkMvMlc0RXRHQkFTSVk0?=
 =?utf-8?B?UE9DT1RmL040WTFRLzBWRDlEUnM1eHBiSTAwekc1dVllS2pUZk5oTDRrU2h5?=
 =?utf-8?B?ejQ3NktHd25QL0pteWw2VDBkWS9qODRMS2FENnBYcVlMbzBRaGQzdjZ5WUU4?=
 =?utf-8?B?YXNieWxqUnN0ay81c0w5bFJPTFRXdVhkQWpRU0tmR0tXVnc2amJ6ZVhJdmV1?=
 =?utf-8?B?TlJSMVNlOEFiVzJnd2VPSlM0Wko4bmJJR0VGNlNYd0N5YW9hQ0FwV1R4Q0Nm?=
 =?utf-8?B?V0JCNHdHWUJRZTBueklxb0w1dDgrbEN4ZUVFbGdzT1RRemZaanQycTZueHI0?=
 =?utf-8?B?SDAxem5OZ01ibko1S0pRYURwcVEwNXJFVEUyYVBYaUR1dXY0a2pUbDNUdmJG?=
 =?utf-8?B?ajkyL0gzU01xaU9OYmpOSC9WK2tyVUpSVnJwNktyY1lQa3JiS3JGMVpkRWdv?=
 =?utf-8?B?dUVQZ2JEcnVnVGxYcndCeENzazNhdUVzYzd4RTNmUlc0VlA2Q1p0WkwvYk5B?=
 =?utf-8?B?MGQ1cXhDVWJmb3F5N0VDWEdMR3h4bHVzeFNqNVNaWGhVQ244TnliaEFBZ0tp?=
 =?utf-8?B?bi9kZjQ2QXZhZHdLRlNTWGd6Z2EzNHA4ODAwS3F1QWtOOGdlWm5JRnlrcERV?=
 =?utf-8?B?TkxvcE5RZWJJUzRJbCtHaXYzQUJpb1BUUjZvZmp5aHNUaFR5dk85NHYwVndR?=
 =?utf-8?B?eUZiZzlVeHhnU1V1dGJkN3RmOW9nMTdsb25CM1o2Q1RseWRPWHV2aHJSTi9L?=
 =?utf-8?B?S0dydm9TY3ZLYmJNL054VjBFdmJvMFlhMGNrQ2o2clZHMFhxcjhmbDZYUmFu?=
 =?utf-8?B?c0daa2JrZk9SVWdzZ2FPbGlFcklncEhONHpEOG1BOWRzYlUvQjZFOEM2NUJ1?=
 =?utf-8?B?MGlwS3NEdE5wZ3UvRHRXY3k4MWFucUpab1RyZnpDRlF3TXQ1UytOUHcvbnQ5?=
 =?utf-8?B?Wlk2cEZ4bUZhNndZT1BkdXlNZVdNZ2trdVloei8xUTB4YkVFeWJ1NnZVQ0lI?=
 =?utf-8?B?MzQ4ZEVjakdDYVBUTk5pYWlNMW1wNTNKdlpKRjZRb3ROcHNENEJ6blRYNThl?=
 =?utf-8?B?UmQxclpheHRsaXdvVElRZER1NU0vaFM4ajdkc1dWSmZIc3paVm40SUI1Ylp3?=
 =?utf-8?B?ZGp4VGlGZjRLcXN3eTMwSnNEK1JyamdxSEQ1WitDczFRM2ZYOG1ZQVpHU1Qv?=
 =?utf-8?B?ZWt5TklrMnlIM2grREJlVi8raElzeUloRFFpd1hBbDdreDFjb2NGV3AzVnhr?=
 =?utf-8?B?L3pmUS9lKzlMMGVmVG5hN3lIdDRSQ1Iwbm1pcWxYZjFEWXgzdmNSb29qLy9D?=
 =?utf-8?B?d1NPaWNrU1pEbzZxclFLMlhxcDA2WnpwTGZ1dHB1R1F1SlVuTUhXeGxQWW5Y?=
 =?utf-8?B?WDRnTTdoVjNJQm9YTVJJMENsTDEvQ015T1UwTzFpeC9FTCtXMmYwSnRlNTZl?=
 =?utf-8?Q?GO9y+JFxraOpgHzA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9382D75161B8946A310FDA704752363@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41943cad-c01f-4637-cbef-08de6a1d961b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 10:00:43.7773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L7S92d3uVLYvMTnW3PIa7v1RzH0WL2l2TlLUgt5QzfDZ3t8RAohoAwlFwhGR5Nr4os4qixfSnoUTtSK+r63VQ7c9G4Si0Ru3Aei2eKtgjDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR03MB9520
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

T24gVHVlLCAyMDI2LTAyLTEwIGF0IDEwOjM0ICswMTAwLCBKdWxpZW4gU3RlcGhhbiB3cm90ZToN
Cj4gVGhpcyBhZGRzIHN1cHBvcnQgZm9yIHRoZSBNVDgzNzAgRVZLIGJvYXJkIHdpdGggdGhlIGZv
bGxvd2luZw0KPiBmZWF0dXJlcyBlbmFibGVkL3Rlc3RlZDogQm9vdCwgVUFSVCwgV2F0Y2hkb2cg
YW5kIE1NQy4NCj4gDQo+IE1UODM3MCBpcyBiYXNlZCBvbiBNVDgxODguDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBKdWxpZW4gU3RlcGhhbiA8anN0ZXBoYW5AYmF5bGlicmUuY29tPg0KPiAtLS0NCj4g
VGhpcyBzZXJpZXMgZGVwZW5kcyBvbiBbMV0gZm9yIHNldmVyYWwgY2xlYW51cHMgc3VjaCBhcyBt
ZW1vcnkgbWFwLg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSBSZWJhc2VkIG9uIG1hc3Rl
cg0KPiAtIFVwZGF0ZWQgZGVwcyB0byB2MiBvZiBbMV0NCj4gLSBBZGRlZCBtdDgzNzAgZGVmY29u
ZmlnIHRvIGJvYXJkL21lZGlhdGVrL01BSU5UQUlORVJTIGZpbGUNCj4gLSBMaW5rIHRvIHYyOg0K
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjYwMjA2LWFkZC1tdDgzNzAtZXZrLWJvYXJk
LXYyLTEtMTA1YzYwNmY4MGRjQGJheWxpYnJlLmNvbQ0KPiDCoA0KPiANCj4gQ2hhbmdlcyBpbiB2
MjoNCj4gLSBBZGQgZGVmY29uZmlnIGZpbGUsIG1pc3Npbmcgb24gdjENCj4gLSBBZGQgZGVwZW5k
ZW5jeSB0byBbMV0sIGZvciBtZW1vcnkgbWFwIGNsZWFudXANCj4gLSBSZW1vdmUgYm9hcmQvbWVk
aWF0ZWsvbXQ4MzcwX2V2aw0KPiAtIExpbmsgdG8gdjE6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3IvMjAyNjAyMDQtYWRkLW10ODM3MC1ldmstYm9hcmQtdjEtMS0zMTMyZjk1M2Q4NDVAYmF5
bGlicmUuY29tDQo+IMKgDQo+IA0KPiBbMV06DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC8yMDI2MDIwNS1tdGstbWFjaC1jbGVhbi11cC1kdXBsaWNhdGVzLXYxLTAtYjdkNGE0M2MxOGVi
QGJheWxpYnJlLmNvbS8NCj4gwqANCj4gLS0tDQo+IMKgYm9hcmQvbWVkaWF0ZWsvTUFJTlRBSU5F
UlPCoMKgIHzCoCA1ICsrKysrDQo+IMKgY29uZmlncy9tdDgzNzBfZXZrX2RlZmNvbmZpZyB8IDI4
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDMzIGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9ib2FyZC9tZWRpYXRlay9NQUlOVEFJTkVS
UyBiL2JvYXJkL21lZGlhdGVrL01BSU5UQUlORVJTDQo+IGluZGV4IDVkMTk4OTJlMjZiLi41OTU0
NjA3NDM5YSAxMDA2NDQNCj4gLS0tIGEvYm9hcmQvbWVkaWF0ZWsvTUFJTlRBSU5FUlMNCj4gKysr
IGIvYm9hcmQvbWVkaWF0ZWsvTUFJTlRBSU5FUlMNCj4gQEAgLTMsNiArMywxMSBAQCBNOglKdWxp
ZW4gTWFzc29uIDxqbWFzc29uQGJheWxpYnJlLmNvbT4NCj4gwqBTOglNYWludGFpbmVkDQo+IMKg
RjoJY29uZmlncy9tdDgzNjVfZXZrX2RlZmNvbmZpZw0KPiDCoA0KPiArTVQ4MzcwIEVWSw0KPiAr
TToJTWFjcGF1bCBMaW4gPE1hY3BhdWwuTGluQG1lZGlhdGVrLmNvbT4NCj4gK1M6CU1haW50YWlu
ZWQNCj4gK0Y6CWNvbmZpZ3MvbXQ4MzcwX2V2a19kZWZjb25maWcNCj4gKw0KPiDCoE1UODM5MCBF
VksNCj4gwqBNOglKdWxpZW4gTWFzc29uIDxqbWFzc29uQGJheWxpYnJlLmNvbT4NCj4gwqBNOglN
YWNwYXVsIExpbiA8TWFjcGF1bC5MaW5AbWVkaWF0ZWsuY29tPg0KPiBkaWZmIC0tZ2l0IGEvY29u
Zmlncy9tdDgzNzBfZXZrX2RlZmNvbmZpZw0KPiBiL2NvbmZpZ3MvbXQ4MzcwX2V2a19kZWZjb25m
aWcNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAuLjQ4ZDNmNjRh
NDJlDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvY29uZmlncy9tdDgzNzBfZXZrX2RlZmNvbmZp
Zw0KPiBAQCAtMCwwICsxLDI4IEBADQo+ICtDT05GSUdfQVJNPXkNCj4gK0NPTkZJR19DT1VOVEVS
X0ZSRVFVRU5DWT0xMzAwMDAwMA0KPiArQ09ORklHX1BPU0lUSU9OX0lOREVQRU5ERU5UPXkNCj4g
K0NPTkZJR19BUkNIX01FRElBVEVLPXkNCj4gK0NPTkZJR19URVhUX0JBU0U9MHg0YzAwMDAwMA0K
PiArQ09ORklHX05SX0RSQU1fQkFOS1M9MQ0KPiArQ09ORklHX0RFRkFVTFRfREVWSUNFX1RSRUU9
Im1lZGlhdGVrL210ODM3MC1nZW5pby01MTAtZXZrIg0KPiArQ09ORklHX1RBUkdFVF9NVDgxODg9
eQ0KPiArQ09ORklHX01US19NRU1fTUFQX0REUl9TSVpFPTB4MTAwMDAwMDAwDQo+ICtDT05GSUdf
U1lTX0xPQURfQUREUj0weDRjMDAwMDAwDQo+ICtDT05GSUdfSURFTlRfU1RSSU5HPSJtdDgzNzAt
ZXZrIg0KPiArIyBDT05GSUdfQk9BUkRfSU5JVCBpcyBub3Qgc2V0DQo+ICtDT05GSUdfQ01EX0NM
Sz15DQo+ICtDT05GSUdfQ01EX0dQVD15DQo+ICtDT05GSUdfQ01EX01NQz15DQo+ICtDT05GSUdf
Q01EX1BBUlQ9eQ0KPiArQ09ORklHX09GX1VQU1RSRUFNPXkNCj4gK0NPTkZJR19DTEs9eQ0KPiAr
Q09ORklHX01NQ19NVEs9eQ0KPiArQ09ORklHX1BJTkNUUkw9eQ0KPiArQ09ORklHX1BJTkNPTkY9
eQ0KPiArQ09ORklHX1BJTkNUUkxfTVQ4MTg4PXkNCj4gK0NPTkZJR19CQVVEUkFURT05MjE2MDAN
Cj4gK0NPTkZJR19ETV9TRVJJQUw9eQ0KPiArQ09ORklHX01US19TRVJJQUw9eQ0KPiArQ09ORklH
X1dEVD15DQo+ICtDT05GSUdfV0RUX01USz15DQo+ICsjIENPTkZJR19SQU5ET01fVVVJRCBpcyBu
b3Qgc2V0DQo+IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IGI1MjEzYmJmZGNiMTgxMmJlNTEwNDI3
ODU3ODI3ZWU4YmVjYjlmOGYNCj4gY2hhbmdlLWlkOiAyMDI2MDIwNC1hZGQtbXQ4MzcwLWV2ay1i
b2FyZC02ZDJmOTQ2MzBiNjcNCj4gcHJlcmVxdWlzaXRlLWNoYW5nZS1pZDogMjAyNjAyMDUtbXRr
LW1hY2gtY2xlYW4tdXAtZHVwbGljYXRlcy0NCj4gYTZkN2I3NDUzMTc5OnYyDQo+IHByZXJlcXVp
c2l0ZS1wYXRjaC1pZDogYWU5MTkzZjQzMzk1NGUzMmU5MTM4OWZjMWIxNDRhM2E2YzMxZDUxOA0K
PiBwcmVyZXF1aXNpdGUtcGF0Y2gtaWQ6IDI5ODUxMzBjOTI0N2FhNzQ2NTc4ZDA5OTllZjM2YWZh
ZTViZmU4MWENCj4gcHJlcmVxdWlzaXRlLXBhdGNoLWlkOiBkN2YyYmRlNmI4YzI1N2Q5M2FlMzE1
NWRiZTUxYzJiMWU5NTZhODdkDQo+IHByZXJlcXVpc2l0ZS1wYXRjaC1pZDogNjg3OTE4NjZiZGEz
OTljMDc0NDA5NWY0NTZkYTdlNWU1MGY1MGE0OA0KPiBwcmVyZXF1aXNpdGUtcGF0Y2gtaWQ6IGVh
MDkyZWZiYTU0YjI1NThiYzdlYTQ0ZDFhNTNmNWYxYTZmNGYyOTENCj4gcHJlcmVxdWlzaXRlLXBh
dGNoLWlkOiA1ZjExZDY2NTNmNzI1YWYzMjg3NDExNTUzNmQwOGUwNzcyZTJjMzZlDQo+IHByZXJl
cXVpc2l0ZS1wYXRjaC1pZDogNDg3NTQ5N2Q1NmVhZjU3MTc1NDY1ODg4YWJkNTNkZTI3MzhiMTA5
OQ0KPiANCj4gQmVzdCByZWdhcmRzLA0KDQpSZXZpZXdlZC1ieTogTWFjcGF1bCBMaW4gPG1hY3Bh
dWwubGluQG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzIQ0KTWFjcGF1bCBMaW4NCg==
