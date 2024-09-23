Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8154CF9C71
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 08:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E0458862E;
	Mon, 23 Sep 2024 10:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="dB6Ne4pf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 274E78862E; Mon, 23 Sep 2024 10:22:30 +0200 (CEST)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com
 (mail-tyzapc01on20728.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2011::728])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 549E387FC7
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 10:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chiawei_wang@aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHTOykIicaUc+0DWaM7EMTPSlUpL/ax/0q4HRcu4nHbSyXbZ/Nd+dozu9D1YDEKbFyV80mMGTQ43MUBKWG6uqbD+dedsKgLotqecYuQa9HOKUl8sBEdxRMHXzMkvM0Ey9nWy0UVbVBat74IiEx54v/wtLmgumEAhP8r1Dn1ks0NdPfl6+GBAkDfhe+8L0RO8onSDGETlLUWO4kod5L96r+58gWIPMAkxEjATsNR2LpFeEg/YgzB2DPbcApGZ95/ya9rEK/Ck6EclGrOQENp5t618nyG7u8LmMejqFTbVTrFSNLR4y/IV/k+89S7Xk3jJIBFYC71jOCGtP1CRF1op9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZMnIahFtJQmYyieJgB2mTvbnnMtaNKBkxWuk92mhBI=;
 b=Dvm4XmoE7tQuSF1orcTYYP91wHT2utfnC1Im6EmbPlBgPDZmJ44GYn6VsIX2VVdyOzivWIWafphUiRi6kRSLvEwFxNoD4K8syBBJmyak2I4QZU7WKy9vhPEPiY5q+gPpYNFf7AjdAI4P+tVJONpdHQfYi7S/iYCSX148BbI2eO3JTS174np3dBwqJm33Jz3+GVOcMmlH7qAlyHbMF9BSjHYITsjlD8GQTyD43a9ZhgWj5IRP8+THAWOdjIMeVGXIG0W5pKtpO0c1ZOAyYNPQL6tVCPC5NCqHNBLDtyGIKv5YaLfm0qI+wZzLyRQeqXK68ifhci1WFYXwIC61EYXCTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZMnIahFtJQmYyieJgB2mTvbnnMtaNKBkxWuk92mhBI=;
 b=dB6Ne4pf/3eyZy8gJ6krCTEhBHXCCU0W+BWknSqRM+kuvUkYOkT/C/yji+SxziG8qNxeFmsFcvS2wDBpA6r5Kxo3FHV9IKvMPgFQPcuYfbpa3v7U/n1jM/xJZWtlwd/loq5o0V3XDgdHNN9ednsBXegkEFavOy+52pSP3MDNBwpv04WLyDUDTwv/TDT/0r0mDmik/T4RVJs7Ate5awScNUhB6ZGgo9IdVUiptej476QoUbeh1kfwBj+qtR6yNzLaQNdokMzKJFcWBqVDIbpCNhkzpiEpOe/lrPr/e/eHWfwDyfBTei4dH0WMZKr0iZTtlXyksLopOe7Zi3dA/2Hufg==
Received: from KL1PR06MB6652.apcprd06.prod.outlook.com (2603:1096:820:f9::5)
 by TYUPR06MB5947.apcprd06.prod.outlook.com (2603:1096:400:344::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 08:22:17 +0000
Received: from KL1PR06MB6652.apcprd06.prod.outlook.com
 ([fe80::edf3:95b5:1ae2:7c27]) by KL1PR06MB6652.apcprd06.prod.outlook.com
 ([fe80::edf3:95b5:1ae2:7c27%7]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 08:22:16 +0000
From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
To: Simon Glass <sjg@chromium.org>
CC: "trini@konsulko.com" <trini@konsulko.com>, "bob.wolff68@gmail.com"
 <bob.wolff68@gmail.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH 3/4] image-fit-sig: Remove padding check
Thread-Topic: [PATCH 3/4] image-fit-sig: Remove padding check
Thread-Index: AQHbC3ZvZv1qxPAk00OYs1Eh3kBFnrJlC+uQ
Date: Mon, 23 Sep 2024 08:22:16 +0000
Message-ID: <KL1PR06MB66526138CC50E494F892A934916F2@KL1PR06MB6652.apcprd06.prod.outlook.com>
References: <20240902053326.3273410-1-chiawei_wang@aspeedtech.com>
 <20240902053326.3273410-4-chiawei_wang@aspeedtech.com>
 <CAFLszTg8ZLs+BgNySmzhHBOgJUVTxq+FEg=oaCQBNWe+CbR_QQ@mail.gmail.com>
In-Reply-To: <CAFLszTg8ZLs+BgNySmzhHBOgJUVTxq+FEg=oaCQBNWe+CbR_QQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR06MB6652:EE_|TYUPR06MB5947:EE_
x-ms-office365-filtering-correlation-id: c1875a43-89bd-418f-06d1-08dcdba8d5c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cXRoL2dGL2VlYWlDME5JQW1RLzRhalUwa24wU3c3c0E4ZU4rTU1yZ3dOUVlr?=
 =?utf-8?B?RERYYnIrZDllcktRTGs2U2o3KzZZY2pJakZYNEF2MExJckRqa2licWJsK3RV?=
 =?utf-8?B?SzMwdHE5UlhSak1VNDI5bytEQk00a25mUmJ4RmxpdFhKbUF6bHo4a0ZpcktD?=
 =?utf-8?B?KytPUkV5RVdobkUycUZuM0Z2OFRrTksrWmtCN3RIYy9YeC9vVnBaMFZBQ1h2?=
 =?utf-8?B?WStjRU41MVJWZndWMkhmRXNacVBMSW5WaDdVbW5GQ25kbExZMjNKM3c4QkQy?=
 =?utf-8?B?dG16SFZZcDVrczhUbmg5d0cvZXNZUmpjNmViQU9uS05Yc1FUemc2cTJVOXJx?=
 =?utf-8?B?THp0cE5WelJTZ0h2OTVrMSswM1FLL3FjUnljZVdVTTBaT2NUMTR3eTVJelZa?=
 =?utf-8?B?ZmEwa09YWUhLNFN3YzhneUdKK0JpZ0lWR1YxeVhpM0hyU3lNYjNPRURLNVVI?=
 =?utf-8?B?d3Vzc3d4aFp0SzZUMENFWGZwTWx6a2hldGMwdmNWck5VeEh1TTdwVWJZTHBP?=
 =?utf-8?B?QjBxUnNwOU93dy9wVm9DRlM4TTdoUTVlTnBRNHdGS0JOM0RMR3Mrc3B1TFoz?=
 =?utf-8?B?dkpnRXpEOTVURkVZdFZqbmI2ZnZJQ1kyeUFtditYaWRXcTVlbUEzOEYvc0hI?=
 =?utf-8?B?TjNxZXB1WjB4YlVPS0RnbnNiMGtOaXFaU0I2eUtnNkZvV2xweTc0Vjl0NWpv?=
 =?utf-8?B?em40THUycVNmT2VmeXlxV29FYkZwN0hKSG9KVklCblpNenVRKzYzNnA5dU5u?=
 =?utf-8?B?Q21kUHBMelNMNi9QRlloeWdFY2VQSkJBZDFqL0ExTGk1MFFER085R0RmUlA1?=
 =?utf-8?B?SEg0MWR5V2FQaHNld3o0R2lENm1NemFpaURuQVFsK0g4U2NJTWw4Tk5peVhS?=
 =?utf-8?B?RkxWK01oQzRLVHVoQnNoODM2Z3YyOThadWtHWWNsVHYzeUtzVDlOckE1cjR4?=
 =?utf-8?B?ajlETEpsODRMaXFwWEtHTGpNSHFieFNYSHZlVjQ2QTRQRzZ5TlhRMUZUOHh5?=
 =?utf-8?B?OVdrN25EVVNxeW9vWDhFTjBjYkJzeVYxcWgrM1U2RVdBS3l5bTltMzd2dnFi?=
 =?utf-8?B?YWpJcUQrQWkxWWw3UjVHeVpWUkpsNXg3NmJxSWhidkZtRjdvR2tiUDJpY3VT?=
 =?utf-8?B?R3lQSHp6N2t5NzNHS2Q1ditsUUE0THFtL1k0NytLNi9ESjdocDF4djJtQ2JL?=
 =?utf-8?B?eE50dno4NksxYzRQQVEwMGZEczhUMlpxL21EbFZhbnVtem9wd3JrSS9MUDF4?=
 =?utf-8?B?T2lTZWxLNkhZaS9EV1F6WjExTGx5WDkweTAybldrMm9mOHc2UDdkL0dNNjBP?=
 =?utf-8?B?U2pIMlNUYjdEdXg4ZVJHVEZ0Y1RpY0p3enRHczI3dDFnSldleXpnWEk5Z1RF?=
 =?utf-8?B?bDlSdUtwKzIzbXhjTUNJcTFoVU1lelUxM3QvcGRKallycDN5dC9PcjA4b1Nq?=
 =?utf-8?B?bFVqaElJOWFxV3EzWUpvVUZYbmVFMEpNWWhJaHBUZk5SQ1pOYkhOdWlIKzl6?=
 =?utf-8?B?U0hiMUxFZjRJbVRiMHo1YVE2cXNXaFZ3ekFrV1pCR2RoY290SzNQZkt5MnZQ?=
 =?utf-8?B?YjI2U1Q5OWRUWDl2MHU4RGFsQ3N0b215bTFCbllSOFhFQzh2VG94cHNCelZt?=
 =?utf-8?B?bytNdUFGS0YwTzVneEIyMlZnMEl2N0Vnc1VaTWxscVpvVCtOYldIWFVjcElW?=
 =?utf-8?B?RlY0TXBOcER1YkZMblk0eVlJbHh6UENkZ1k1Yll3cFA4NThkN1MveHQ5NTJk?=
 =?utf-8?B?V1VmbWFoMHkralNMblUvdk53M2N6OVNyUE9ldUxRWFZxeUNQeXg5aWs0OG15?=
 =?utf-8?B?UVRUTWVGbWFFcUh3R1NveGdHN2Rqc1YwZ0ZNeWluSVZnM3dOQ1NlaFl4dGdp?=
 =?utf-8?B?dGJ3eEpLazl4TGZZQlRKWnJQWHFJclZGNTVGMG9tVnhPNlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR06MB6652.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHpUcWptTElkUGlmelVtUzRmS3BuL2FvN2g2cWlVdTBzK0RyYXhXeUZ0TnAw?=
 =?utf-8?B?L3h6NHhCSENCR2NGdWYxREhoeWdEcy9zMnl1endSd2RpNHZreURveFB1TEhj?=
 =?utf-8?B?Sm0rZzBwNzlMVFJIRGhoMDllOElINjl5cEdNU2x3Nm4zVG9MeFZLYVJ2bFVa?=
 =?utf-8?B?eVQ0VVRJUDdjcTFmUzJERmZQMDViaGUyS0w3TVFhb3RMNDFtNGtFY0FLVXBY?=
 =?utf-8?B?TzQvVXFtZUM2K0MvY0x0bmNoeFZyNnd1czFIS0RrZWtuV05MaGVWS1lYZ1BS?=
 =?utf-8?B?bFJXZWhnY1I3dXhQWGt2QlhqclUrVkdMMlFRay90QWpZR0xiZlpSQ3c4SFI0?=
 =?utf-8?B?MWxXM1h2V3BTTFZLNE5vcjVmMnBkOGhpa3g1OHhGeWxoT0ZxTk9MeTN4TEhI?=
 =?utf-8?B?dkpzUVVRMWFRVXJ5dUcvR0l6emhQd2ZTYW5rZFYzUFA0by8rR3haWXljOEI1?=
 =?utf-8?B?eEloVUkzZHZUK3BhNlBEVlgzS0czcllDaHJraFlhdnhkMFVMYjJhbllJalpa?=
 =?utf-8?B?WHA4bWlZcVZIR3FUaitGdTR2ZTlJT1E4NEFNVUU1K2Ircnp5MzlwbHZoMm5S?=
 =?utf-8?B?blNmdFQvODNoVWR1dDQzWTJwYUtVdzFxQ1RWV2ZLNHpsc2txY0J0K2tOUzRl?=
 =?utf-8?B?WjdCUjVkWjJPTG9wQ2RTSVhiQzBOSjFGKzZDcTBwSnRMY3FBbWhwaUJKWU94?=
 =?utf-8?B?NHVjZnYxSFhOUnBTdVpvanhDN2tVUTlIYlJlbVBxd281R1ZQV29hS0lvUFl0?=
 =?utf-8?B?ZzBXMTJYNEhPd2JrVGNBcE5jWGZQYWQwQUtEeW1GRC9uMHpNcERPMU1sdnlT?=
 =?utf-8?B?OEg1L3BFTWNGdFJteWo3azd4azNsMkJ1cHZNdHJpUXlpRUtlZzFNa294ZGRF?=
 =?utf-8?B?K3JScnlqdXJTY01LUzFXTldEeHpwRkFueWFTT0d0WFhpbkxhejdOQlVjaEgv?=
 =?utf-8?B?SlJiRzNLVE42YmRLTzh5RS8rQ3hJb045SERtNmlVMm1xYWhURVpNdDRLYXJU?=
 =?utf-8?B?a1hXYjBRYXJ1ZHlCVkRldE9OWGlod21DUnpQNk81aE5ZbnRYbDUrVTRmWnd4?=
 =?utf-8?B?TloyeDFoUVBBSE4xL3FFWUdYaDJmMVRBcGFSRkNkd01ZYmhMM3FFWHdUTHJN?=
 =?utf-8?B?Zmo3SlZKSTBnZWM3RFl3TktNRmE1eWR1WlNJMy9jSVNKMTdoR0RTMk91Y2Ro?=
 =?utf-8?B?M0YrbXhLNkdEYS9mRUtHbDlwTGxKdExJektFS0FYaGlJWjV0aUxsKzNQdmYx?=
 =?utf-8?B?SFNmT0lTVTBhTndkeFRrWHNBRFpmUmhWYjNpYWE0N1ZPbnZPVHJZZkErR1Vo?=
 =?utf-8?B?QXY5WWZBVG5YaDlTNlgxcWNhQ2FyZmFxMlUrb0cweW5RUUoyV3RML1loaVpa?=
 =?utf-8?B?V1QyY3FDOEh6MFpjN1JEZEQvN2pna0MycmJ1b1FnSFMxZDFmM2dPSDlOTlBq?=
 =?utf-8?B?S2J0YzBqRE91OTJYTjBJT0o0MGtXS1NwelJEZE5GZUMzbnhzOHNYOW9VVUJH?=
 =?utf-8?B?eUpQOFliU3hoaHpyanRrcm02MlV3a05PU2lsS29vbmFvZ3JvVXJDYVBPNzAz?=
 =?utf-8?B?S1FLTHhsTmwzNEhQbEZNTW8vR3pBWHFRQnVVZS8yb09aSUVLOFNzUVprV1BD?=
 =?utf-8?B?eGx4ZWtBZ1lYVHk4SjRSeFNGMzI0bEM0elg1Wkl1bFdmWmhqREFGUlBzWW1S?=
 =?utf-8?B?aEVxTDVWOGdjclA0am5uLzgyd1JCcDRSSVRLbnFjMmRqcElkc1RsNlFJVlJT?=
 =?utf-8?B?d0VMMi9sYXluZTUxYWJvRHFsRGZydG1OY0NhcUQwaW9zbHJOVTd3UkdVQTRk?=
 =?utf-8?B?c3NJQ2RQRTlINDAvTmtTcSs4eVZCd3poVytsM2RuREV2VHJ4bzN1VUVVUnRm?=
 =?utf-8?B?cWZzZ1BEQzZ6cEsyS092UXkrUXFSVzNtWExPVFdKTURJYmlaRndsN1pBNFRX?=
 =?utf-8?B?KzJQRG90a09PakpxMG1jRHUxK2FnS1RnT1BCMU9XUlprZ3BRWjNQaTlHdnlu?=
 =?utf-8?B?RXhSMWd0dnNkYmc0Q0oxWHZiSHVOOVJMQkxxN0ZNZzQ5a0oyWWIwVXJlekow?=
 =?utf-8?B?SHJYY0FPVDVMV1FtTTBoMmJaMytweVQwdjJuWi9DOFluWVpxbGJGN1Erb2pu?=
 =?utf-8?B?WWhDRC95TExiS2tNN3dIR1FiT3Nha0ZDc3BtUTg3Z1lFaWdOQ2gwRXhwdmNp?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6652.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1875a43-89bd-418f-06d1-08dcdba8d5c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 08:22:16.6658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9RWJcHFTVdaHjy8IMjEzYpYL0XhGtMHwLCar4vjRwzaroOEWHog74RyWB+mvGyNt40IbDuv5U2eTFJrnIOXLJqOD+LIy4+s8nZvFyxOXRO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5947
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

SGkgU2ltb24sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ltb24g
R2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+DQo+IFNlbnQ6IFNhdHVyZGF5LCBTZXB0ZW1iZXIgMjEs
IDIwMjQgMTI6MDIgQU0+IA0KPg0KPiBIaSwNCj4gDQo+IE9uIE1vbiwgMiBTZXB0IDIwMjQgYXQg
MDc6MzMsIENoaWEtV2VpIFdhbmcNCj4gPGNoaWF3ZWlfd2FuZ0Bhc3BlZWR0ZWNoLmNvbT4gd3Jv
dGU6DQo+ID4NCj4gPiBUaGUgcGFkZGluZyBhbGdvcml0aG0gaXMgbm90IG1hbmRhdG9yeSBmb3Ig
YWxsIHNpZ25pbmcgYWxnb3JpdGhtLg0KPiA+DQo+ID4gRm9yIGV4YW1wbGUsIEVDRFNBIGRvZXMg
bm90IHJlcXVpcmUgYSBwYWRkaW5nIG1ldGhvZC4gVGhlIFJTQSBjYXNlDQo+ID4gd2hpY2ggbmVl
ZHMgUEtDUyBwYWRkaW5nLCB0aGUgYmVsb25naW5nIGluZm8tPmNyeXB0bygpIGFsc28gaGFzIHRo
ZQ0KPiA+IGNoZWNrIG9uIHRoZSB2YWxpZGl0eSBvZiBpbmZvLT5wYWRkaW5nKCkuDQo+IA0KPiBJ
cyB0aGF0IGluIHJzYV92ZXJpZnlfa2V5KCkgPw0KDQpZZXMuDQoNClJlZ2FyZHMsDQpDaGlhd2Vp
DQo=
