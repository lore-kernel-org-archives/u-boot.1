Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470A3F33A68
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 14:14:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAF9B8382A;
	Thu,  5 Mar 2026 15:14:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="bUXl0J1Q";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="PL1hoDFL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1A1783E81; Thu,  5 Mar 2026 15:14:21 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1665481E18
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 15:14:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 952dc83a189d11f1a39cd589f645bc18-20260305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=Qlxz3SfueOl/2+FKBTwpLGhv8Z5qNN8OWwUsUdtxRbE=; 
 b=bUXl0J1QlZKnoPOq1qbBCfysVQcepWnU5o2DoZqBoN8n46cchK3wL171+988qbEG2T7j2/NcUBBraVygIQv7QZzAFPWygIbnWVBrPWZUDbUboa8rShLQB1e9raXHG81E4Xe3iPeGIiY+JcWPUYpgFN+j7FXC0o2xeoHMim2TyNc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:b0612f5d-342c-4e36-9957-95545474441f, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:eff64cf1-16bd-4243-b4ca-b08ca08ab1d8,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 952dc83a189d11f1a39cd589f645bc18-20260305
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 344132053; Thu, 05 Mar 2026 22:14:11 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 5 Mar 2026 22:14:10 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 5 Mar 2026 22:14:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMJbvUAK6zlnNhQdm+TkZdcMSyi4Owc2eEj8Bmc7nHZS9SZCf/xfsRa87IRdNSsh605sRHOy3P1h4qmcTmyi+atuh/6zo7SG5EolZjBzscSf25KR01CnNgUIj+KL612p20tL3+lzaFJF7S7UqJbJnV2DpTTKTbCnv1ERGeAvEgsKBrCaE4hsi1AZqvApW0N0C9O6S2ZTw4YMW5hiWfitCo6Tw+xKb6dUjaNbbSZAaMJrp5wXTHpyBBThHTGB14EqRFwt+VLutbIkYPbPWAR/LySa85Ekq0um8E8y6qsD+0ZmTjzj8OQvMZl1J2fVBb0jBitmmGAfW+zBnJbtNCzpaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qlxz3SfueOl/2+FKBTwpLGhv8Z5qNN8OWwUsUdtxRbE=;
 b=l1K52iCzzYXY89UKGekeL0hxkdMveh1SJWqRaJcvHx4BakmlE1/+DPoc3ZV0tkcYGAPpbKiir0GPWEfc4ccM6EyNetMTiq+s5d68/BuM+hFugtFwXIyCIeWShEF6zNTtMCKSExcp5BFhbJC97oDdwPaQb37ccJwAVLBo7OV+ycRpJcFiGv9rylr7xWGulMzdN49F6AqOz/NRz2WtnS7nL1rEInzPnvzu8u6HYWZ2pq9u0pBZYcxetFYpI/elM2tg7B0HSD/esUGkk2cmHIJZnMkbEtzki/dPTJmyxgJ+CrgSysbjYYZ62Ezid1lmD6AJKSOmG6ntlNgQS7bcbdbbMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qlxz3SfueOl/2+FKBTwpLGhv8Z5qNN8OWwUsUdtxRbE=;
 b=PL1hoDFLRKDiz9Qgau1ZPAlgEiD7Y0bot8Jq72FdUlxFLHsYWONxKqPnBKKr6MEvcQndg97hSZd1fUGyRn1SiSJ05Iv9lCvOX8enCQC+46yVJsJImc/N2soeNb8NxDgNCfGmNEedWZu/7rhyqKG5wuleWR7Kttyh/POeVNEAN8o=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by SEYPR03MB8578.apcprd03.prod.outlook.com (2603:1096:101:209::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 14:14:08 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 14:14:08 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "lukma@denx.de" <lukma@denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, Ryder Lee <Ryder.Lee@mediatek.com>, 
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
 <Chris-qj.Chen@mediatek.com>
Subject: Re: [PATCH v4 7/7] clk: mediatek: add clock driver for MT8189
Thread-Topic: [PATCH v4 7/7] clk: mediatek: add clock driver for MT8189
Thread-Index: AQHcq0gU8YKwOFDkzkCyQljWdm/q4LWf/hiA
Date: Thu, 5 Mar 2026 14:14:07 +0000
Message-ID: <1348f10407c0f6d68852bc457bbd1da9fc83de31.camel@mediatek.com>
References: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com>
 <20260303-mtk-mt8189-clocks-v4-7-ee85f8dd2f0d@baylibre.com>
In-Reply-To: <20260303-mtk-mt8189-clocks-v4-7-ee85f8dd2f0d@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|SEYPR03MB8578:EE_
x-ms-office365-filtering-correlation-id: ad08ec4f-53dd-4b2a-8d4e-08de7ac17730
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|921020; 
x-microsoft-antispam-message-info: thLHAaECiGFBE6Hyu1ukeRVr4jYWrdmDlcA2ZRPGeGM3FqfBkEUM+pu7tWoRKMXKvBZUy4m6UUA3tTC2g2pZQoJUxGKMpk999HniieZf+WC4oVyiw00dDNBNnYIp0581CVw2qFtHaC940IVw36IlzBSnZZLTjwtuTpPIVgDEoQ7MsRLTQ95nbFC0bjytxKpolkv6aSNjN2QlbY3obg8ERoi2uwkhpgdArkCqoTdfJfu37W6c/UJMJVOOn9azyFoBpntWuKPBlwcYtDCnk6jqxzsfk6rzzNxiwqReoKwwDXOP/e4p79UHuTBX7z9JC0bhs8czaSaMHHE7IXbTh08xMFxadJse5L4aFwE62Sjmk00Y6DIofEhPbAAiNdNsVodHTUZqiW8mGnYBbx4XcAzuI74bjKclv8LBUqqXWIV5k5ZsK1fFdiPVZMctThzeZR5o6KtMEeD6UqHa/x9y+OG50boArqj4G43VHog3tdAqfw/rLoabUu3IDqJ1T5iypx6NY6iJKXV/8q7/D/hzwZ2ctIQyxDR2h6wXQH+8JRxH/yVb71BnUQ8JScG1QLPfLAnBXZq6kXNMoR3lpSE+tPqesjzsYqS+klSZOgkMKTqhnN4UkiYErVQsnC7R860l9xz9X+CnASDF+biESHf5AncawtwuF5ES6ei+k+5PUlbcyOh/M9yKVSVFThjYu9c9+4pk6Czxav/1Zp4g8hU1yH9OMCrIBMNGTuOll5RQpoK6my35rClmkl66Yf/ZBeI0SFeFSsy8iWYm1eB4MkH+wNRJW6H4L7RB4dUJuJ7KTx1fA9h33z6RLld8opaOWMfCSoi7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(921020); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjFUejAvMzdmU3ZDTTRPaEJncWo2aVB1SFlwQW1tMGtsK2JNQ3ZLcG5ycWJz?=
 =?utf-8?B?alVWM1VreUZDczJpV0NZU2ZXTlhvN0xsVUJySTBMUDFLSW1vT1NRWmpsb3B2?=
 =?utf-8?B?NU01OUQ1WW9OMXRxclRZbTl4c3VzaHZsMDZNYzVUVE5TbXVBVld2UTZJS3R5?=
 =?utf-8?B?K0tMTFRMSGd1RW5Pdnljck5LNzJ5ZkcvbzBud3VOcXFOenNYY1k2QnJmMk9R?=
 =?utf-8?B?QTlmbmdEQ3J1ZTJ5QU56UUxzQmNYbS8xNHRqeHZpakIrQk5uYmZjUFhTaC9N?=
 =?utf-8?B?N2E4QmsvTS92QmQwNDVmbFh2NHV0MzhCQms1bW1SMmxTaHZ0T3pTa1FldzV2?=
 =?utf-8?B?S0ZOYkV3dVJlMnFMeVlCVFRMZkhpOXpISVIwNjJCWGJVajBIempnN0pnejhR?=
 =?utf-8?B?clFYcEY3TGhPOHNoRlpMVG9Ob0ZVekF3NUJ1dms0am5rOEtIbmMwYW0zTzQ0?=
 =?utf-8?B?bk5VUUN3a0JqcU83NnE2RXY5bFQ5RWhVS2hIREJjcWgyRkZsSGo2dTVKYlk1?=
 =?utf-8?B?Y0VtYkxyZzE5ak9yK3RCZDcvNEs5c1lVamhFTVE5bERIMlNqYlF6WUtHck0v?=
 =?utf-8?B?d2U2TE1tVnpJMTlXWUVoazBOdm00ekZJZkpJeFBZWDJ1ODFxZGZMcG9RS0ZX?=
 =?utf-8?B?SXFMLzdkY2l5THV1L3pHR3BiRThQaTAzaVpSWndhWDBtSFllVUp6VmdQcnRI?=
 =?utf-8?B?YzhIUFcrVEs2YnhlenAvbWt2ZXJuTTV6aG96RUpTb2x5cE84b1NzbjhwdHky?=
 =?utf-8?B?U3Y5OXF6WmRKdlNUM05yUkdCb0pEa2VNVW9YbndFYjFnUGVDVFY1TFdoM0sx?=
 =?utf-8?B?QithRWRDOHRTUmcyMzhuL0M4TnhxVEtHWW8yOTNBUHdMMm5sSk9iamtScXlY?=
 =?utf-8?B?QS9RTkxVZWhkRkdXQlZyQmxXV3NCd1JiVUJ1bnFMOE1yaTFwQkxNeEZpNko1?=
 =?utf-8?B?eW5pUDhxQkM3K0V1WFRrRUhlWGx3bjNTZU4rNkdoY1g4eDlkMFNkY2hleUxD?=
 =?utf-8?B?VVQvYUV1T3hwU3pUUFA4YUhyTmFtZkRoYW5iTnNaczVDSVNmaG1WdjNSYjNG?=
 =?utf-8?B?VHFZNDFEcEJZeFlaeld3SVRZSEdKVE44RjEweTQ5dzkxR2FPR1dGb0pGc3pn?=
 =?utf-8?B?TUU2RmRqZVN0RWF6b1NiWm55ampXN0t3RjBCRXNUbEY0dUJzUkhSVFcvamkv?=
 =?utf-8?B?QSs2clZiNWNZVUpBUUtjZ000Q0FRYURpUmR4OThKM29tMG1Rd0tmZyt1R2NJ?=
 =?utf-8?B?bVNUdlE5WTZiNXZVQjRzVTVUZGl4UUhrNGQya1g0R1ZpbDhaMlppVDhrUGJL?=
 =?utf-8?B?b2tvNGJtS2dXaDNrMndPWi9YRHZRcTJ3OEc5ejd5bGgxT25Ud3VTMVIzeHZL?=
 =?utf-8?B?VjJUa2pCUWlEOTJ6VTlZRVlnTTBlMlo3ZnlDL0VlRHpGbzZJSGI3VkNDVHhR?=
 =?utf-8?B?VVEramJPRGUzSEV1Z3VMa3UzZnJwTStxTWJTVGRtbS9MeUFFL1V1RlQ2SHJy?=
 =?utf-8?B?MzBGWmNrU2hDR2VTTDNMdUlLY2h6NkJoQXJxSHR1MDQ2VGRrV0pFYnJBemZu?=
 =?utf-8?B?emVEOEs5bTJ5TGhjaG1yMitOTWxRTGxIOGNNeUtCSlROc2RyQ3RVV2tLcmdu?=
 =?utf-8?B?Zmoxc0Ixb0JnNlc3Z20rZDVYc2RHNDJ4Smhxd29vM3c1UmtWSmpzVjNoYzRC?=
 =?utf-8?B?Vjc0aHJuTVpubllLK1ZxaFBMT2lJUzBTOUc1bHR4Ly9iZktzaG5jTkRCZitn?=
 =?utf-8?B?cXVpOVA0d1Y5cW1zSzRPUFRUTnVXckl1UUpyK3JLUEFCQXQ3eGFSRW9JQVMv?=
 =?utf-8?B?aWpORXNDY2lCdVZYeG5FWHlSWllZT1RxL1FjZkxoemljMU5tQUN4YkN5OWgr?=
 =?utf-8?B?eldYYWFmOW5MYS9xYzdNT3doQVBKVWRSNVpuZ2FBVW9FckJPdU8xZHBHUVhu?=
 =?utf-8?B?cUh0WFVna0tnaS9TWlV0aG1WLzc3ODlhUVlaTFJtTStOZS9TT0txcEVxeStB?=
 =?utf-8?B?OGl4M1FsQTQwMXJDVkx2SElSbXBvcHQvL0xOdlFjTGl5S0diT3gwTlU1bHN5?=
 =?utf-8?B?OXdLcFd5SXRGQWw3TjJkYWhyMjZwQkplWkMrek1pMjVxUk4rVmtaUkpsanU4?=
 =?utf-8?B?UTdzQ2lqdFFOS0x4RTFza1plZzE1Tk1sdjhpYW94ck5DMHZhNXBzanpRaEph?=
 =?utf-8?B?YUFvM3lwMm1Yb0VoZ20xWXZkQ013d3BsSEk2SlRUblEzZll1OWc4N2I0d2p2?=
 =?utf-8?B?Sm9FOHZlVDduS1Z6Q3JHSS9nRGNNeW1ISjRjM3B5TUM5aG40U1p2TUJnMzBC?=
 =?utf-8?B?bW0xQmFqZEJON3UrUkVZT0I5SWx5cFkvSHd3RlRhb0ErMVJkaXRhMXZYMG03?=
 =?utf-8?Q?7s3PCf6MCC1sPPfw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BB7B4371D1D40488B5FCE025EA3CFC0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: l8iDloHlzRMOTI8UMN+oeDbMG41C54PQFugw3jGf/9uSJI1arw+8CNRfxb+jR2DzF8O1vNlwcTiFMMHJyty9YUPGtjzHNlfJOvmR20dGyhGedHAczn5srqepCxXxvDXCTOBc7HoK9uwbLfMnKiRk4/ca33LN1jUMOK/5ffAiA5B+k9YctHD2j8A8cHdCFvv28l+RVfKKUfWIgc+xRiMdmibZfpC2dc2y5s9obKlFZ3pnF1AHEKDawaZAy/snmyfAShXSbXNYnK5Hp0dCrR/mVZJtUJG7PKoYP+A2TtfMhzuX63k0jkri2YPMZMdXeNJ0Ov+HFnkXvPpiXeRmbmKb9Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad08ec4f-53dd-4b2a-8d4e-08de7ac17730
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 14:14:07.9558 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QYky3qHVqwmg1xwiNg3wrnRB9JxYyA328dsgFORKZz9jnKAEb65B3G1bCrrgPgmhvB2VDiqcR5tCSkRkxSU5RctYiRUL7cgrzcWdNtY8JxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8578
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

T24gVHVlLCAyMDI2LTAzLTAzIGF0IDEzOjU0IC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBGcm9tOiBDaHJpcyBDaGVuIDxjaHJpcy1xai5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gDQo+IEFk
ZCBuZXcgY2xvY2sgZHJpdmVyIGZvciBNZWRhaVRlayBNVDgxODkgYW5kIGNvbXBhdGlibGUgU29D
cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzIENoZW4gPGNocmlzLXFqLmNoZW5AbWVkaWF0
ZWsuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxp
YnJlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGli
cmUuY29tPg0KPiAtLS0NCj4gwqBkcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtlZmlsZcKgwqDCoMKg
IHzCoMKgwqAgMSArDQo+IMKgZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE4OS5jIHwgMTc0
OA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+IMKgMiBmaWxlcyBj
aGFuZ2VkLCAxNzQ5IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Ns
ay9tZWRpYXRlay9NYWtlZmlsZQ0KPiBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlDQo+
IGluZGV4IDViZWRlODE5YzBkLi5kNGNhYzZhYWY1MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9j
bGsvbWVkaWF0ZWsvTWFrZWZpbGUNCj4gKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZp
bGUNCj4gQEAgLTEyLDYgKzEyLDcgQEAgb2JqLSQoQ09ORklHX1RBUkdFVF9NVDc5ODgpICs9IGNs
ay1tdDc5ODgubw0KPiDCoG9iai0kKENPTkZJR19UQVJHRVRfTVQ3OTg3KSArPSBjbGstbXQ3OTg3
Lm8NCj4gwqBvYmotJChDT05GSUdfVEFSR0VUX01UODE4MykgKz0gY2xrLW10ODE4My5vDQo+IMKg
b2JqLSQoQ09ORklHX1RBUkdFVF9NVDgxODgpICs9IGNsay1tdDgxODgubw0KPiArb2JqLSQoQ09O
RklHX1RBUkdFVF9NVDgxODkpICs9IGNsay1tdDgxODkubw0KPiDCoG9iai0kKENPTkZJR19UQVJH
RVRfTVQ4MTk1KSArPSBjbGstbXQ4MTk1Lm8NCj4gwqBvYmotJChDT05GSUdfVEFSR0VUX01UODM2
NSkgKz0gY2xrLW10ODM2NS5vDQo+IMKgb2JqLSQoQ09ORklHX1RBUkdFVF9NVDg1MTIpICs9IGNs
ay1tdDg1MTIubw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE4
OS5jDQo+IGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE4OS5jDQo+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwLi45ZTQ4ZDY2OGRiNg0KPiAtLS0gL2Rldi9u
dWxsDQo+ICsrKyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxODkuYw0KPiBAQCAtMCww
ICsxLDE3NDggQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkN
Cj4gKy8qDQo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjYgTWVkaWFUZWsgSW5jLg0KPiArICogQXV0
aG9yOiBDaHJpcyBDaGVuIDxjaHJpcy1xai5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gKyAqIEF1dGhv
cjogRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiArICovDQo+ICsNCj4g
KyNpbmNsdWRlIDxkbS5oPg0KPiArI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL21lZGlhdGVr
LG10ODE4OS1jbGsuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCj4gKw0KPiArI2lu
Y2x1ZGUgImNsay1tdGsuaCINCj4gKw0KDQpbc25pcC4uLl0NCg0KUmV2aWV3ZWQtYnk6IE1hY3Bh
dWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5jb20+DQoNClRoYW5rcywNCk1hY3BhdWwgTGlu
DQo=
