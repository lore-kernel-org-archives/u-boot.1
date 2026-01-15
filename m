Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27755D3CCB3
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 07:05:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AD3182C7F;
	Thu, 15 Jan 2026 08:05:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="jjP4SsUI";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="tIDWzilU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74B3683642; Thu, 15 Jan 2026 08:05:27 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 365AA80077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 08:05:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 8b67e3e6f1e011f0bb3cf39eaa2364eb-20260115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=uEVPEaGulDf/ECrw9lFBDtk66PQNH9lt/Eszvds8Rso=; 
 b=jjP4SsUI7DVtb5ghxPeqkRU65zsIsLWR4r1czwGkhMM73wZ0wKvZ3wQ642SQJIgRI2vyli7dHz56G336V7WyNULPxoOpVoK3s3dHfKlAkuJvRAouJimZdO7YPyRXOgAE/1JvdxjRjA6Fenai+9qq1VJ39hWIWrSjWsygAuYalR0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.9, REQID:7ccc7bab-0e13-4862-918a-413c2e174106, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:5047765, CLOUDID:b9f589e8-ef90-4382-9c6f-55f2a0689a6b,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil
 ,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8b67e3e6f1e011f0bb3cf39eaa2364eb-20260115
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1976445871; Thu, 15 Jan 2026 15:05:16 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 15:05:15 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 15 Jan 2026 15:05:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZ8RO9v9yQE6+jCR5qBzXl6gjUYzB8k8yvQwtg0huSKdGSw6nJ6qNo7ZPetraUAewnVdtubus46ne5uHRbk0Jikukt9ikSrW10RSEGJgQ5OLqE+udl9TwDcgqLVtfJ1Fe+YpraS96lP+cb+7Nl3xaoYqDBTvFEZDcZJLZdn2H4F+q2wY/S+dXuRjpnBPhSbxPUqt2soAGbTYfsK8d7LwPkqhzIX8WOVRCD1fD89pbSntbX1yrapntvdan8rlEqDRbnOWVx6x1XB1Xii0/xl4AE0BsKUb+a3wc4Ntl0KQMAddcT2nlgbSRxcuKyN20JOeVJHeUk0eguD8OKDns5BFiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEVPEaGulDf/ECrw9lFBDtk66PQNH9lt/Eszvds8Rso=;
 b=wTw64o5RIBaTVKbPBiBTgLTRzZom2o3feEcWi5tVuLeTztSNNvjgeomwDKdQlu3chZd/domw7zWXdWR1NUdSqCAhPXv3x/tPiYWD+5go6ZTaW7OHfsso1D8GT5aMoW/NnXBZPsxvP7Pga1iGmf01+X0Sejam3RalpWsZmyU/nOs1pfm9SguOR4pXwI0fVyAOzne/q5ilSYfH1cMsMDkeQMPy5Wn5gVwtDhmRn+5NSp+lCErsjZCur4tx1M8rp0hQNYp7bN951xSKdp6URuTxxm1HPbijFo/kr/1lB/arXAesO8VYUPWey+Iu6SE/iFfUIiPmGYsBTIQRGPT2FSGODw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEVPEaGulDf/ECrw9lFBDtk66PQNH9lt/Eszvds8Rso=;
 b=tIDWzilUrW7ADUYuie0PvIeWoVSGnkX0IfbwzflRkAfhFtVFkHolUz5NHRUk+LxmwohMR2ya8AbIyeR63NzpntQR+BO+Bz7ANhrTr+XMb3HgYTJreBF3mGuu4U8RjYue4++7k9gKCrmDU4UAcQmkqIRo94eNIGcwtf6qUY5n9Uw=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYZPR03MB8214.apcprd03.prod.outlook.com (2603:1096:405:26::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 07:05:11 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8%4]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 07:05:11 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "lukma@denx.de" <lukma@denx.de>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, Julien Stephan
 <jstephan@baylibre.com>, Ryder Lee <Ryder.Lee@mediatek.com>, Julien Masson
 <jmasson@baylibre.com>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?=
 <Weijie.Gao@mediatek.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>,
 =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?= <Chris-qj.Chen@mediatek.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/9] clk: mediatek: mt8365: fix missing and out of order
 clocks
Thread-Topic: [PATCH 2/9] clk: mediatek: mt8365: fix missing and out of order
 clocks
Thread-Index: AQHccHYhK2w5s289S02ksJ+6f/xOlrVS+aYA
Date: Thu, 15 Jan 2026 07:05:11 +0000
Message-ID: <78dcd04a17910a2c3ee7fe32809413dca2293c68.camel@mediatek.com>
References: <20251218-clk-mtk-mt8365-fixes-v1-0-4f8ff0de3268@baylibre.com>
 <20251218-clk-mtk-mt8365-fixes-v1-2-4f8ff0de3268@baylibre.com>
In-Reply-To: <20251218-clk-mtk-mt8365-fixes-v1-2-4f8ff0de3268@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYZPR03MB8214:EE_
x-ms-office365-filtering-correlation-id: ead306a3-3a79-42b2-70d2-08de54046ced
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?ZzRrTU9sMkZHNmNRbWhzYjlLcXNKajFQeTRWMkI4WFpEdXcyTmpaR0QycSt1?=
 =?utf-8?B?NnVDM3YrYlhGbUJ1Nmwrb1ZCdlhYR3M5eUhuZ0cyeTNJWEgvSFNmcUxxU2FF?=
 =?utf-8?B?c1JkbENVQmZtbi81ZXI3dHN2S1lEQnhnRFRvR1k4RVoxZGdYZWhnYmVKWEEx?=
 =?utf-8?B?bVdFNCtRMGVWMDJwVFpiZ2d5cGZiY3hoamdOZkd2OFJkNEpkT2VxTUJ1T0NJ?=
 =?utf-8?B?Vm83clhWSnpiRFdDWmJQYzdwdElWK2RZdDNkL1I4QTdHTU1hc3UzL1JsdUIx?=
 =?utf-8?B?c1lUZ0xGak92aTM3RDNLOGI5VHliR1BWY1N2MVJXNUc4eHRwN3NPR25WYmM1?=
 =?utf-8?B?aWs2TGJLOHNrbXA0aW1VS1F2cC9STmZUVk9NYi91UWY2TjVHbEgwQW1WRjFh?=
 =?utf-8?B?MzN3YnJXQ3B6Y2RyYVBTOXRUWnh1aldpOEVPVm5QWHVxMURKVUJLU2xKaDh1?=
 =?utf-8?B?eFIwUEYxZ21zVzc0eWhwazdYeWwvVVN3NlpUUlFoekluRlVRby9sbEZFTkph?=
 =?utf-8?B?U2dvejZMNERVVVZZTzg3eG54ZnJLa0dxYkJubE9KTVpLSUlpM0pwNnVJd0F5?=
 =?utf-8?B?N211UWkwVklyTFdhQkJTdnIrd1oyWUpBM0l6Zm15NDd0RExUdzAxMmhneDNz?=
 =?utf-8?B?R2tpOFM2SzY1Y3MrVVF6RlFNaWhaazFjdFpPV2FqSDhncDJZY3ZrY1BRWENB?=
 =?utf-8?B?akx3bU13OWZTMCtjbXAwRURGRVRzUmxkc1VPSDIzZnJwbS84Qk1QZkNFWHBO?=
 =?utf-8?B?d1pOSFE3amFEajZybTBrMUVPZEhXYk1Kc2V2bnpSeGsxSmVrbVpZa3lDUVhW?=
 =?utf-8?B?bjlyaWRRSm5DR1VhbEdFRVdzT0ppWjhKUmk2SWQwQTZaeVcxWHZzYk00VnJT?=
 =?utf-8?B?Q0dmcTgya1ExYjE3WWpxaU82dmRESUJJMHIvamYwbzBUeTdFcHVSRXQ5OTFx?=
 =?utf-8?B?Y2JNUyt2dWpjVlFhajFWeXlqS0xkbE85TDM3aCtjOU1qWWdrVTZEQWZtMThN?=
 =?utf-8?B?cTRVZjVyakowekRQM0FxNEJ6bkV6bnNSdGNyNE52SS92MTJ4dzJObFVZSGc2?=
 =?utf-8?B?Z2wrdWVCNmpiVFAwT1J6YnNSY1BzckNQQld0dXdrY0d3c2VtQ1A3cDIvZDhR?=
 =?utf-8?B?MGxqSjZ3SEhuRW1NeGt0MGNUYlprWGhUOUdIQVZmTVJxcS9wN0tTS3RJNjFn?=
 =?utf-8?B?UG9WZnY3TmtiRGxaMmRITGNOZG4zdGlObVNjZzAwTGo1VG9PenVpcUJJdFk3?=
 =?utf-8?B?Zkp2VHoyQVFpQ1g1U1pwa2dXYnBzd3k2WWVmUTVDR215RlRWV2N2YU9IbEFx?=
 =?utf-8?B?QjREK3JlK3ZxZ21icjhtOUFLM0xQaTBmeVgzVHBBdmhzZDhqTS8wQXU4MHRv?=
 =?utf-8?B?ak4zeW1oNk1obHVHZ1BjajRPaGlsLzNsZW5SdW4rRXJKOWcwZWxWSVloazJZ?=
 =?utf-8?B?OW8yYXVKVjI5dFU4djlVNkFHaTlaZnJxUHpwY1BQTUt4bmNNL2hsYlJwWkRY?=
 =?utf-8?B?QXZBY1NPdmd1YUlxY3lNbVVzdy9EV0FLMno3UnAxeDJTaE1qRE4yK1lnUUc5?=
 =?utf-8?B?ZXFiZHB1M0FQKzRsbXdzcXVEckNBNHMwRXBZZFNDVVRFSWhMakRyd29lMGlv?=
 =?utf-8?B?L1oyQ3ZaZ0MzVkF4a0F0bTd2QURZQXhzRlNUaXFmUXV6UHJRQ2w1RERZNzg4?=
 =?utf-8?B?MDlkcDdCeXY4OGU5M1dINXZjVWp1NXkwd3VQa3RET3lHWXBVNkZtN2FIM0Zo?=
 =?utf-8?B?V1hpOHE5bk1lQXNBUHY1NytFbEM2RDVuaW1kV1ZjZm40dC9OVE9MK2tNTWJ1?=
 =?utf-8?B?cFkvanhFK2JtWnZRbFY4aHhLeHdLNkwxbCs2S0hlRDdUaWlxTThSVmkzMHR1?=
 =?utf-8?B?U0h3VjZoUllJL1VzWW9remFUWHFyeHdiNjMrSXJMQkt1MTkxRXNya3RIb09y?=
 =?utf-8?B?MHl1ZUkrYUxaSTlYSHJmUDlteDUwZm94b3ZjNmlkNnRnNEpEeGJlZCtSY1RI?=
 =?utf-8?B?T1ByOUZLRFpHMGdlT05QMEhWRDdJWS9Hamw3K3UrK1RTYklXZ1FqQ0ZJdGZI?=
 =?utf-8?B?UWYzUTNzVkdLME9DUVlBamQ3UmUzRjdOdmlXZ3owcnZ4YWxVTWpqWTQrbkdU?=
 =?utf-8?B?RkR2YmZpVWd4TjV1SldQNUh6OGgzTGRBODJKMzQ2NFpzVjJmTVQrbVZHNE1G?=
 =?utf-8?B?ZXREVXVzUjhqT2FyZjV6TjFnaW9yNlBsRnJ3K05sbEUzN3BXdWMxS0QxVTRo?=
 =?utf-8?B?S1VYTnVRNHhvY09mcGN0MWZXWEF3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(921020); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VCtPUnRmN05mRTZRQktlS1ZWVEVOSGlVaHhWUGdNWWVvQ1prRG44dExqa3B4?=
 =?utf-8?B?WVJtTlFPZHdJbEMyQXdoQ0ZGY2FycHcyNU5iQ1pmS3NQOTlMZ2trTmh4RjNQ?=
 =?utf-8?B?RjgwNU5Dc3FocDJ4MnB0VXo0V2ZlcjRWTXRjdi9lb0g0Z0FVbG81Snptb0xs?=
 =?utf-8?B?VjUxcXMyUXBZRjR0WDVBR1R0VTgyRGVwV2wyc3R2cmwxZERhUVU5ckNLaUdJ?=
 =?utf-8?B?aTFCdUtYVFdvTDYxNzlSMWZqWldDa282R1FhM2YrT3NUSTZGYm10SCt2ZFRH?=
 =?utf-8?B?OGNQQ21QQXczOFV4cG0rTjdMb3l6VCt2TnJ4NG9XV1ZXazBlK2ozTlFQdm5v?=
 =?utf-8?B?MUVLYjQ3dVBQVlJJRGVkRC91M3hXZnJvM0IxYkxSa0dPUTZhUGM2ejNTWXZK?=
 =?utf-8?B?dktJZ3MvaHZQRkVUNDNGWHJKd0ZCRHRyZE1kYW1PYUFXSStyQjVMdEJ2ZmpE?=
 =?utf-8?B?SnpSOURhWFpHblI3M3U0TVlwQWJyTzc5VGl4OVRIQkVQeE1KeHI3UHM4dEVF?=
 =?utf-8?B?QnlERFhHNkhtMjAxVGRSK09RWmV4eS8xWXB6YXBVbkxmVkNDemVtZHlkVjFE?=
 =?utf-8?B?S2ZVRmRIMzBQaWhqRDJwUEplVjBPTDZqUXpIa0dCL2RodUNOVld4SmlYSWt6?=
 =?utf-8?B?cGorRFEzU3M0MmVqUktsYXUyRHRQLzR6OTZKY3pIS1FrbUN5am1GZEp5b2FJ?=
 =?utf-8?B?Qm1USjZPcXN6eTU4QTd5NFpxZDZkS3JWbHVBWWhxZkViSlVVdnRtM0pTSTRq?=
 =?utf-8?B?MzBoRlNlMWRESlBocjN6eHoxUHFFb2RML1FrZXBjNmxOMnlTYXlIS1Z1bTU4?=
 =?utf-8?B?NzZNS082WGZiWDl6U3ZLS1YrUTVvUVB3cElFOUJSdjdmLzF2WXpONnNoV3h6?=
 =?utf-8?B?eVV3RFpjOWY1RVBEcE5xczh4RmdSWTRBaHZHWU1RK2NzWEduaVFTRHhPNlZR?=
 =?utf-8?B?Z0VVSEZSeFFydWV3OVZHRldJT3lQNmRoanZIU21FOTJ6M0wrSVR5Qk9zT3l3?=
 =?utf-8?B?eXk4aG0yWDhGckFuVkJpM0ZLZ25yMTFKTkR1QlBEOGh2YmE4Z3hhZzRtd2Jl?=
 =?utf-8?B?ZTJWbTMraDBHdHhWZVpCMldBeDFCRDBHa3h4WE44cTdCR3lnS2o1SDBZM0do?=
 =?utf-8?B?S1JYY0dSZ0N3UUJnZXoySWxHZ0IxMU92MXRkeEJlSEdGYXY4bk1QdGwxZDNP?=
 =?utf-8?B?YmU4eHNKRkxmKzFraFJncFBVaXM5eW05V2VSbHVtNjk5aTBodzV2bHBXb1Bx?=
 =?utf-8?B?UEJJeitZa3RzQXh2MHVmZE8vNXh6YlprVm43QzNZRFU5dTJPUFVtNDA3RmdK?=
 =?utf-8?B?K0ptT01mZ2RwUy9rUnFRSWNMbGhOcW1sUmZNcFhyYllPbnJMeWV5NnNoMGZB?=
 =?utf-8?B?NXc3aFpaUXIvNitmenNOK3EzUGNnb045RkYrVjdUTkI2c3czeTQvYmxxZHg3?=
 =?utf-8?B?QTNlb3BZMzdaTVdZdlB4SlZWdEFqb0F2TDdzeThjZy9JSm5tOSs1ekpuSlp6?=
 =?utf-8?B?WFZHYUZMdElqZlJ1ZEprbTlYUm5aU0VkeEFyMWZuMmpQY0RnMjN0U0VHMk5D?=
 =?utf-8?B?dGoybDBQTmtJRDlPY2k3Ym5rSVFwQjhlOXU3WWpRdFRuSU1uMDYrZjhKRkRY?=
 =?utf-8?B?U1B4aEsrUEduYXVORmVHWHJzNnhuMFpWb3NNdUZLejZuaW1GWHUvZFZrUVV1?=
 =?utf-8?B?emxxVGs3U2czQks3OUpLZWZ3VWc3Vmg5MjRYZXJoODdDb25uUjBNZlRucWxP?=
 =?utf-8?B?OFppdlRVVHdtNyswcmpGYmpBUElscTNGbzNQaTBlTTdGbU81bkFpeHY2V2Vh?=
 =?utf-8?B?UkZhd0hLQUFuQ0dEalBlRDBndml3Wk1iOU1oTWg4d2thVU1XNm4ySnBlVmhP?=
 =?utf-8?B?ZHNuRTkwRjYrUk5UZFo2MG9nbmFzRkU2RWxtVG1VRVZtZWQwYWtWRjYvdHNN?=
 =?utf-8?B?aVFmeE5EdkZEdGJkT21PcFM3MEEvK0ZvMVlxZ1BjYUcyZWlZVGR4b3EzbUdz?=
 =?utf-8?B?R3lKVzRhVkRBeSsyL2N2NTB3UW1PSFU2TGJFVDdJVGRXbDUxMUNoWDBoRHda?=
 =?utf-8?B?ZS9RZTNUTXVsN3psek9GOWNYOE81U0ZwdFQ2K29xYkowSlVXV0Rsd2RIWEJW?=
 =?utf-8?B?TDhVc2ZjRC81YkRGeTdqTTVuTmI0TzdOa2lMNnlENGg3TDZLRWR2ZUUzbStG?=
 =?utf-8?B?RGY4Q012c0pjZTJ6NFBrNkUrYnJ6V3pwWWtlUGpzTk9QLzNTekVZV2FCOTRT?=
 =?utf-8?B?bkhYR29jWGtNcTMzNnVXcHU0WklscEhGL016SVJrMUFueDlEV0tMNEZtNXhT?=
 =?utf-8?B?VDVNUXNhdFhYeUw1OUhqbmNmVXh3d1RlMW1heWpjVzJSbEhsNmZWWDJveVg4?=
 =?utf-8?Q?fH8aiZ+YN9r0ZNS8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C075378C88E0D348A5C108DC9BF09573@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead306a3-3a79-42b2-70d2-08de54046ced
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 07:05:11.7069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OOq3SduOAFe6y7GrH6bqLYgrNUew5JwVYk8FvFgGNnkEiK90Q9UkXPKbtsaYXJgj3EFAokiiFJXY59KnaKtD00JLpQq9HOLe/V/k67+q2Qs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8214
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

T24gVGh1LCAyMDI1LTEyLTE4IGF0IDE3OjIzIC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBGaXggYSBmZXcgbWlzc2luZyBjbG9ja3MgYW5kIGV2ZW4gbW9yZSBjbG9ja3MgaW4gdGhlIGlu
Y29ycmVjdCBvcmRlci4NCj4gU2luY2UgdGhlIGNsb2NrcyBhcmUgbG9va2VkIHVwIGJ5IGluZGV4
LCBoYXZpbmcgdGhlbSBvdXQgb2Ygb3JkZXIgb3INCj4gc2tpcHBpbmcgYW4gSUQgd2lsbCBsZWFk
IHRvIGluY29ycmVjdCBjbG9ja3MgYmVpbmcgdXNlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERh
dmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy9j
bGsvbWVkaWF0ZWsvY2xrLW10ODM2NS5jIHwgMzIgKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0NCj4gLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDE1IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgz
NjUuYw0KPiBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgzNjUuYw0KPiBpbmRleCBjODg1
NDVmYzdjZi4uYjYzMzJiMTRhZWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL21lZGlhdGVr
L2Nsay1tdDgzNjUuYw0KPiArKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MzY1LmMN
Cj4gQEAgLTgwLDcgKzgwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZml4ZWRfY2xrIHRv
cF9maXhlZF9jbGtzW10NCj4gPSB7DQo+IMKgwqDCoMKgwqDCoMKgIEZBQ1RPUihfaWQsIF9wYXJl
bnQsIF9tdWx0LCBfZGl2LCBDTEtfUEFSRU5UX0FQTUlYRUQpDQo+IA0KPiDCoHN0YXRpYyBjb25z
dCBzdHJ1Y3QgbXRrX2ZpeGVkX2ZhY3RvciB0b3BfZGl2c1tdID0gew0KPiAtwqDCoMKgwqDCoMKg
IFBMTF9GQUNUT1IoQ0xLX1RPUF9TWVNfMjZNX0QyLCAic3lzXzI2bV9kMiIsIENMS19YVEFMLCAx
LCAyKSwNCj4gK8KgwqDCoMKgwqDCoCBQTExfRkFDVE9SKENMS19UT1BfTUZHUExMLCAibWZncGxs
X2NrIiwgQ0xLX0FQTUlYRURfTUZHUExMLA0KPiAxLCAxKSwNCj4gwqDCoMKgwqDCoMKgwqAgUExM
X0ZBQ1RPUihDTEtfVE9QX1NZU1BMTF9EMiwgInN5c3BsbF9kMiIsDQo+IENMS19BUE1JWEVEX01B
SU5QTEwsIDEsIDIpLA0KPiDCoMKgwqDCoMKgwqDCoCBQTExfRkFDVE9SKENMS19UT1BfU1lTUExM
MV9EMiwgInN5c3BsbDFfZDIiLA0KPiBDTEtfQVBNSVhFRF9NQUlOUExMLCAxLCA0KSwNCj4gwqDC
oMKgwqDCoMKgwqAgUExMX0ZBQ1RPUihDTEtfVE9QX1NZU1BMTDFfRDQsICJzeXNwbGwxX2Q0IiwN
Cj4gQ0xLX0FQTUlYRURfTUFJTlBMTCwgMSwgOCksDQo+IEBAIC0xMTAsNyArMTEwLDYgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBtdGtfZml4ZWRfZmFjdG9yIHRvcF9kaXZzW10gPQ0KPiB7DQo+IMKg
wqDCoMKgwqDCoMKgIFBMTF9GQUNUT1IoQ0xLX1RPUF9VTklWUExMM19ENCwgInVuaXZwbGwzX2Q0
IiwNCj4gQ0xLX0FQTUlYRURfVU5JVlBMTCwgMSwgMjApLA0KPiDCoMKgwqDCoMKgwqDCoCBQTExf
RkFDVE9SKENMS19UT1BfTU1QTEwsICJtbXBsbF9jayIsIENMS19BUE1JWEVEX01NUExMLCAxLA0K
PiAxKSwNCj4gwqDCoMKgwqDCoMKgwqAgUExMX0ZBQ1RPUihDTEtfVE9QX01NUExMX0QyLCAibW1w
bGxfZDIiLCBDTEtfQVBNSVhFRF9NTVBMTCwNCj4gMSwgMiksDQo+IC3CoMKgwqDCoMKgwqAgUExM
X0ZBQ1RPUihDTEtfVE9QX01GR1BMTCwgIm1mZ3BsbF9jayIsIENMS19BUE1JWEVEX01GR1BMTCwN
Cj4gMSwgMSksDQo+IMKgwqDCoMKgwqDCoMKgIFBMTF9GQUNUT1IoQ0xLX1RPUF9MVkRTUExMX0Qy
LCAibHZkc3BsbF9kMiIsDQo+IENMS19BUE1JWEVEX0xWRFNQTEwsIDEsIDIpLA0KDQpJJ20gbm90
IGZhbWlsaWFyIHdpdGggY2xvY2sgZHJpdmVyLCBob3dldmVyLCBJJ3ZlIGNvbXBhcmUgdGhpcw0K
bW9kaWZpY2F0aW9uIHdpdGgga2VybmVsJ3MgY2xvY2sgb3JkZXIgdGhlbiBmb3VuZCBzb21lIGRp
ZmZlcmVuY2VzLg0KDQpGb3IgZXhhbXBsZSwNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL2RyaXZlcnMvY2xrL21l
ZGlhdGVrL2Nsay1tdDgzNjUuYyNuMzQNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL2RyaXZlcnMvY2xrL21lZGlh
dGVrL2Nsay1tdDgzNjUuYyNuNjQNCg0KVGhlIG9yaWdpbiBvcmRlciBvZiBjbG9jayBDTEtfVE9Q
X1NZU18yNk1fRDIsIGFuZCBDTEtfVE9QX01GR1BMTCBhcmUNCnRoZSBzYW1lIGFzIGtlcm5lbCB1
cHN0cmVhbS4gQXJlIHRoZSBiZWhhdmlvcnMgb2YgdGhlc2UgY2xvY2tzDQpkaWZmZXJlbnQgZnJv
bSBrZXJuZWwgdXBzdHJlYW0/DQoNCltzbmlwXQ0KDQo+IMKgwqDCoMKgwqDCoMKgIFBMTF9GQUNU
T1IoQ0xLX1RPUF9MVkRTUExMX0Q0LCAibHZkc3BsbF9kNCIsDQo+IENMS19BUE1JWEVEX0xWRFNQ
TEwsIDEsIDQpLA0KPiDCoMKgwqDCoMKgwqDCoCBQTExfRkFDVE9SKENMS19UT1BfTFZEU1BMTF9E
OCwgImx2ZHNwbGxfZDgiLA0KPiBDTEtfQVBNSVhFRF9MVkRTUExMLCAxLCA4KSwNCj4gQEAgLTEy
OCw2ICsxMjcsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19maXhlZF9mYWN0b3IgdG9wX2Rp
dnNbXSA9DQo+IHsNCj4gwqDCoMKgwqDCoMKgwqAgUExMX0ZBQ1RPUihDTEtfVE9QX0FQTEwyX0Qy
LCAiYXBsbDJfZDIiLCBDTEtfQVBNSVhFRF9BUExMMiwNCj4gMSwgMiksDQo+IMKgwqDCoMKgwqDC
oMKgIFBMTF9GQUNUT1IoQ0xLX1RPUF9BUExMMl9ENCwgImFwbGwyX2Q0IiwgQ0xLX0FQTUlYRURf
QVBMTDIsDQo+IDEsIDQpLA0KPiDCoMKgwqDCoMKgwqDCoCBQTExfRkFDVE9SKENMS19UT1BfQVBM
TDJfRDgsICJhcGxsMl9kOCIsIENMS19BUE1JWEVEX0FQTEwyLA0KPiAxLCA4KSwNCj4gK8KgwqDC
oMKgwqDCoCBQTExfRkFDVE9SKENMS19UT1BfU1lTXzI2TV9EMiwgInN5c18yNm1fZDIiLCBDTEtf
WFRBTCwgMSwgMiksDQoNCkFuZCBzbyBvbiBmb3IgdGhlIG90aGVyIHJlLW9yZGVyZWQgY2xvY2tz
Lg0KDQpbc25pcF0NCg0KDQpDb3VsZCB5b3UgaGVscCB0byBleHBsYWluIGhvdyB0byB2ZXJpZnkg
aXQ/DQpEaWQgeW91IGR1bXAgY2xvY2sgdHJlZSBhbmQgY29tcGFyZSB0aGUgb3JkZXJzIGJldHdl
ZW4gdS1ib290IGFuZCBMaW51eA0Ka2VybmVsPw0KRG8gd2UgbmVlZCB0byB1cGRhdGUga2VybmVs
J3MgY2xvY2sgZHJpdmVyIGZvciBNVDgzNjU/DQoNClRoYW5rcw0KTWFjcGF1bCBMaW4NCg0K
