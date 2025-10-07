Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC3ECCD184
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 08:35:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E5F6838BB;
	Tue,  7 Oct 2025 10:35:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="CW/2lftg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27B7A838C2; Tue,  7 Oct 2025 10:35:53 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24B808388D
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 10:35:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFIaGKS6Og+etcVFlG31lCv/BaBabZXDToDzD9L1XtT5wkCk+P53PyXxcI/CKckDjNSd+7M8fCfPu/z1TKyL9cDgvQ4TiwVov0Xd7INQOd2TVEI2qzHmw35H7ZGaLncvCf8FGkyqTkPRn+Wal6h9iV1FPyCctAd0mUmglzlU6Rh8KCQnhkqGU/tA45AmeoQghjhWb8OFR/sRSxdCdEqdYDpuOxuJXyiqOCfCjiIeCYSAeiqJy+rQEpZEhNna79y/9ajgYHfwFYIuLTiQDlwOg1qIf8OlsnkAO8ix/XrFYDoghLuUWZU7Q/0M5vOWW5Zw8QJNqHJCUIZQ0zmk34rDiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SE8Gal85+VlqgigsIQCz21EdC9Mmsudm5FH79VRZp94=;
 b=qq2H2BuiD3fcWIYQ3jwEfM3dwSvltApxfaVPoADtwF2nDh1am9RNxa/7gWwmedtTPh4KR9iiaDfY5hn43NHKsbfEJ76s6aEW3yQjkzq+45f8Vlje1pzpAga2LVcClP+aSvzkzR6MSlRIIqKKzF/kS3hIcXVpiy065avHHSi6YJJW3gNHlemmzH8QjZdFRnIkeMXXGHk3jcBYcxqpv2m/n8zCrZUubzaJojgtHFIm7kv62rKzAuDTjKt0kMVHelPb6uauvnpBEkp3uKNroPRi6ih8JSd2voYk9RQ3uI7vE7Vk0xrrauu9u3GgPqu44ULntcxhDOolwh7Fk4E2yDxAWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SE8Gal85+VlqgigsIQCz21EdC9Mmsudm5FH79VRZp94=;
 b=CW/2lftg3N/OeTf31eA+NvwmqAaQ9lHdIrUqLTYyROc9O3HWYHTNHPefLIOzMWqzaSjyGFkEIwyKQo3LE0PwolLI9Ug7cbxKiIkIHelyjoHLMz/YB1Kw7T0Y7Sozmx+x/nS9jilEZBPDGnuAoG1MUpb/WeG8Dnx88JglbRmd0CHOz9vv4F/ABsNXv/iewKFiqZz8wcSMBdt01F0VyTWpLVrePfKcs9LK66o5T9RVTADvahQHClygQUGNaWQkHKxRhKazCZGD1E8kGVkujFYgVhhickmOEYYci8i/+PoDQLvqH0LORO4LYS00gYc/Wi+oAFElfsrjtyqrhHF/KA3kDQ==
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::12)
 by PAWP195MB2470.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:362::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 08:35:49 +0000
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582]) by VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 08:35:48 +0000
From: Martin Schwan <M.Schwan@phytec.de>
To: Yannic Moog <Y.Moog@phytec.de>, Tom Rini <trini@konsulko.com>, Teresa
 Remmet <T.Remmet@phytec.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>
Subject: Re: [PATCH] board: phytec: phycore_imx8mp: Add rauc to bootmeths
Thread-Topic: [PATCH] board: phytec: phycore_imx8mp: Add rauc to bootmeths
Thread-Index: AQHcN2N4YJ74O/EeWkWbCYi9WD8ET7S2W/qA
Date: Tue, 7 Oct 2025 08:35:48 +0000
Message-ID: <7e61e1606b4576c6c02a8b0cf9208ad93f4d5fac.camel@phytec.de>
References: <20251002-wip-config-imx8m-bootmeth-rauc-v1-1-e54d43a6fd70@phytec.de>
 <fd8d46a2c6fc2f15a632de44b291ce30deb46cd7.camel@phytec.de>
In-Reply-To: <fd8d46a2c6fc2f15a632de44b291ce30deb46cd7.camel@phytec.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2489:EE_|PAWP195MB2470:EE_
x-ms-office365-filtering-correlation-id: 4d303cc0-3944-4320-9340-08de057c83f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Z29wY25NTnlTTzhKZU9ZUmtYKys2QXIrc3AzamRUSE41aWJ4LzN4YVYwKzBY?=
 =?utf-8?B?d3FpZkJnSFk1emZtZk11WStSdVcveGpNUng2c3dYNWI1SUZaL1hVREUzOEha?=
 =?utf-8?B?N2pxdURiaUhvVGV0ZXFhSnZyWEJZemhqc3FaS0luMWgyUnF6dDdXWXVzYVJE?=
 =?utf-8?B?QklaNzVZVHdiQVVjalFBSHljaUcvYmljUXBSaG5wb0ZSTUhBSnd4dk5GTWxL?=
 =?utf-8?B?ejdQYURSVWRpbjF2NURMSzh6aTJCenh2ZElvV2FjL09UUGVLSnlBRHBzcWxz?=
 =?utf-8?B?Z3Rrb1hlNjZEb1pobW5sWm9lM1RxRnVCYmNnSDdZR3h6NWlyanRGVzRxS0NM?=
 =?utf-8?B?STNuZVRFRFZERzBvQVpKdDJSdVF0QlBrTm9RQUZrZk15ankza3FBT1dKb3dv?=
 =?utf-8?B?dkJEckZhWlpya3RJYlNVR2VFQm4wNitVTlgwQUo3dm90YnhtT3ErZ05RWkVO?=
 =?utf-8?B?M1BzT2lsRHd4akdrTnZGa3BUVlpxUlNseGN3dVM4a0tkTUdYYm9iQ1k0b1pJ?=
 =?utf-8?B?Y2tycXllZGd6c0dXS0F3aUlZRXFKTmVDbFdoT21IMWNhcFg3ZkZId3FDaHVV?=
 =?utf-8?B?QU1SZllhSHZYK3JXMDIxNUZNN2IvOVdIMHVpdTlkTUVadzlFU041NHBUczZF?=
 =?utf-8?B?eWYwa0pmMElIKzJKRGJPY1hGeE9jM2VtWlE0VnZJRy9tTEZUdmRWWXJESjk3?=
 =?utf-8?B?U21Eb3JYamJudEkxbVBvVThpVDd5U29NZUhQZHgwTzIram5FTlZDZXBzeEts?=
 =?utf-8?B?UHhjektPTlRGWGRFeVIvVVEzamR1dWJUWldIMWdCbW40M3pTcUJmL1N5SUhN?=
 =?utf-8?B?SDgrc1FnclhYV0k2ZkxTSUJ2anEvZG0wV1RhRWlSaGJQUEt3czZWUnlJUEQ3?=
 =?utf-8?B?MWpnZ0pGKzdBZzErYU9sbUcxaTR4cFp3TGxWU3BqT2NDa0U3bXZBWkpiSHk5?=
 =?utf-8?B?WFJzVzVUNjdlaGhWQWNLMnRuTmtRU2pXZ0JBcnp2dkE4MlF5N2NURUlzU1p2?=
 =?utf-8?B?VWs4d0dQVVU3VlNXbzNKdUJ0QkpsOFNDV08rR2JPeEk5ZE9ubG93RmFwWktz?=
 =?utf-8?B?T3VIcHpxU1NuV0dLOXFtbjVRMDFickNIVERZZHgwZVd5R0F0bWxBNHFlak5m?=
 =?utf-8?B?Zm4yZWpQaXBsKzBheXBxaHdmcDUwUmpPT2wwQ0tIQTNadUNYWDJjbkIzSWo5?=
 =?utf-8?B?ZVIyK3VCNUhqeDFNelRmbUZmQlhtaU9ic3d5YVRBSHYrSFg2UVdpTkJrTEov?=
 =?utf-8?B?ajd3NXRHSVF6akZoM2x3cWpLbHdzR3g3WnFvRW55MFZiajJSY3FLak4rZUQv?=
 =?utf-8?B?SW53TysrMHVRSi82b0xIZkt4Y0xKb2VYb3dORTFmWEpIWTdNVnhrLytuWDJK?=
 =?utf-8?B?QmgrOUpXcDU0bE9PWTNIVkc5NjlDQXRxUS9nRldiOXdKUXZ2cHBkdi9FeWJU?=
 =?utf-8?B?NW90RVVseDlmUS9jck1MaFAwNU5YR09QWVU5OFB3c1d3RlJmcXBpY3grRXV5?=
 =?utf-8?B?dTFqKzNLNXBvMUhjOFh6bXpWSGNDNG1rREpnYmMwQVRmcmlSMktraTYwZE9t?=
 =?utf-8?B?SVR6WG1kQXpMcUx0b0V5bVJMTGhNMXJORmRCTjRZdWhUWXhUTndBWjVEQ2Ji?=
 =?utf-8?B?U2dLMUdrenNPOWJLOGhFR0ZVTnViQWIrNkVENTF1NlV0YmJVVE1OM05lUFhZ?=
 =?utf-8?B?TmMxTHBZOVRuQ1M2c3J3TkxMU2hnUmRDYU5pQ0I5ZW94TGRrVEhQNEU5Skw1?=
 =?utf-8?B?TTV2WHJJck44ZnBRSDl6SDQ5OG5LT1ZkUFNBa1l1QWJ1d3NlVXR0QmtXZkZs?=
 =?utf-8?B?QXo3NXJEZVdISWRkYkRqL1lBUTN1bUhpenZCYUc2Wi94K2xkQ3V3YkdHM1lJ?=
 =?utf-8?B?a0w1dkRGQ1FSZTFNNDAwYy8rQ3RFaklBZ0F0ME93TFEyZ1pLakRobUNySVNo?=
 =?utf-8?B?bjBFbDZYMUxpc3NvdWIzdlR0QXJnOEtrSWxSZm4yR2QwSFd6MDJYenU0R2R5?=
 =?utf-8?B?NzMvNk1EKzRzcjV1bnlDR1Q5RFhXaGo2TTAxOUlsTU16UWlINXJJMjA4bkxD?=
 =?utf-8?Q?5FJra1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2489.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTd5M0djdnhlK1llK2NBZXNBK0lISU5HZEVuNUdLenhla1RBdWR2TWhvZ1ll?=
 =?utf-8?B?MWZPd09zMXM3aHVaTitmd1JHVGpxU2ZxR3FZa0p3cnpsVUJsd1EzTWFsbUox?=
 =?utf-8?B?TE5QamcvdXFqeW9JbVFPejhhcjF6T2FuV1ZTUkZNaWVVblZ4UUMwaHJsakwr?=
 =?utf-8?B?NmdHR1Z1YldNOVVLODg0TXJEejk1SE1PcUJxZkYrSncvVnZJdkdzUmo1RW5j?=
 =?utf-8?B?SVgwWFFCbExZc2tyV2ZWZDg0Ri9FdkxabjFNWUJoSzE1V245eWFxVDRRQ1Yz?=
 =?utf-8?B?a2syYmxpVEpPMFFZSlViUnF1ZnRhVVA1aHNJTFFkeEU3L3pFNVJqTm1jQ2ZK?=
 =?utf-8?B?UkxNRXRCSGhtZ1drTXluTVNKZit4VHlLdlJWbVlkVTdyN1F1eC9XaXpySjFj?=
 =?utf-8?B?RmsxcEZHRFFjRjM4dUg0NzZxY1V3RTVDZzRKM1pRVDlwNEVlVi9BSmpiMjlu?=
 =?utf-8?B?MVFUT3M0U1p1M25KcXJ3YnZpWU82amczbEgwOFJ1bEpKSk5jRlgxSTJLTVp5?=
 =?utf-8?B?R0M4T0x5Tlp0cTZ1RWRkbEQwZ1dKL0Q1M2lsaFZhZ1NXYjBTem0zTmlYVGdC?=
 =?utf-8?B?VHdqekhPRFMyVDZTZTBHRWltWWkvWFN1UVVSaTFkZVNicy8vd0hGWjVpZlZt?=
 =?utf-8?B?c0o5alJCZHRUdjFFSXhaeWxKckpYSFdLdnF6UHRKVHZ6bFpkTmp1TnFNQjZP?=
 =?utf-8?B?Y0lrS09UK0F3b1ViWmZhMDdBeHpIZkRrOThiaWJDL05EeEFCNSswcjlLMVlv?=
 =?utf-8?B?VWRBQ2F0bGZiU2R6MHpnOUE4QWk1TG9QU3hUejg1VEhmVS8rNCtTNmFhMG5r?=
 =?utf-8?B?Y0VlaU05WXZSbmd3OVZiTWV2SnljYmZpSURrTUdiM0tUNXM2UlZiU3RCSlJT?=
 =?utf-8?B?RVRLb1p6MDZ4eUZuSmhVeUlQUDVkSDJBNWU2K0hWajFvYU9udTVKVXVNOWkw?=
 =?utf-8?B?UkRjQXFrcWlUaktkN1I1NVNBU0YxQ0NEamJ1Yzdib1pnbTZEZG0xbW5uTWhq?=
 =?utf-8?B?TWUwN1hkVmVFamQ2NExla3ZzUktXTThNRHNyS2c1R1UycHdJMURmYnRaWVJw?=
 =?utf-8?B?Y3NyV3p2aDRmUk5Ba3gzclJHbDNSN1dNSVdXSjdwVjlVQ3NiUDc3MWNPb0Jk?=
 =?utf-8?B?MnYybTl5Tks2ODhRR2QxL25XUTFPN2FsMnJiMkpWNkI1TlRHTzdBQ0UwZTlq?=
 =?utf-8?B?NjdIbGNibnpZL2VKZlB2VFY2NXBaUUxFcXBiZ24vVG9ZMmhGUDJNZ3lFa2gw?=
 =?utf-8?B?VVd2TkRDbHVsbElMbERjNS9YRVI4NnV5aGhRUGVKUTJqck82SEtuQnNQam5B?=
 =?utf-8?B?Z0g0YXpqRlVvTzl3cjB0c2FvdDV4aEQ2Q2hjbjlCY3JKZkdFdm1mTGwwS2Zz?=
 =?utf-8?B?Z2RuMzE1SE9HMHA5aDlrYmszd2tlSGlldVYyd1pWb0tGeGtlNkxyaUxIcHRj?=
 =?utf-8?B?QWcyWUtEWHhLQm81bkdOcUloQ05vaGFLVGQrYjFKaFMxRU9pSWpBNUZZSzRt?=
 =?utf-8?B?emNOaFB2SXNGKzhUY211ekNoNDM2SCs5bHNYblM0bDVkQkkwK2ZWajJOQTk0?=
 =?utf-8?B?a3U4OU9qTENHaWtRVFZHU0hER3VjUlhpVDNLWnpoOGl5NUJQa3p6STBvRFp1?=
 =?utf-8?B?aHY3aHlQNmFGUlY3S0RFV0NBeTArMUlRQ05iMUVoekFBcm4xRzB0ZitOQzN6?=
 =?utf-8?B?OXJyYXNnUjFOVy9CME45R3dSMXFkQ0hxZENGWDI1U0NINFdBNnZSZGYwYXB0?=
 =?utf-8?B?azhickM0N0ZaR0d3REd6OFNGSkpVUzZWcU9rNDF1bHM5Uy85NW4wTDU5WFdX?=
 =?utf-8?B?N0dOR0xhTUlWaS9obFhLeFIrZDRWZm1jR0c5SGp4VUFBVC81cGdZSVdBdTAw?=
 =?utf-8?B?bytvQmxsNFh1TXlScXRsRkZDNks1eG5JQ1BSQ1VBSThUMjJlNmVrZE5GN2RB?=
 =?utf-8?B?MzdtTHhEZ05MUHRmbTI5cCtaWWF5S0xQeGw3MlJ0ZEJXWXhYMXhUWGpKWUpX?=
 =?utf-8?B?dEd5eHpCcmdJZXh3RDh1WlQ0MFdNRDJ1MCtWQk8raDQwaU95MFdWOHRBWGxo?=
 =?utf-8?B?OU02aW1IV3dQSEFOWE1MSHNpa1MwOHhYVjRCMDNJY2tEMFBRa2Zxa3pxWk5X?=
 =?utf-8?Q?kPes=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E280CE9A719B99498269135A6FBB1ABD@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d303cc0-3944-4320-9340-08de057c83f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 08:35:48.0709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4wF+us6JINTO5SulzEkcZ5tHZveD4b7rYtHCILJqr7hAY0xXfz563+qQ2iAgrehxxETXUaMU1zTfvPXwQ/ozpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP195MB2470
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

SGkgWWFubmljLAoKT24gVHVlLCAyMDI1LTEwLTA3IGF0IDA4OjIyICswMDAwLCBZYW5uaWMgTW9v
ZyB3cm90ZToKPiBIaSBNYXJ0aW4sCj4gCj4gQW0gRG9ubmVyc3RhZywgZGVtIDAyLjEwLjIwMjUg
dW0gMTM6MjAgKzAyMDAgc2NocmllYiBNYXJ0aW4gU2Nod2FuOgo+ID4gQWRkIHJhdWMgdG8gYm9v
dG1ldGhzIHZhcmlhYmxlIGlmIEJPT1RNRVRIX1JBVUMgaXMgZW5hYmxlZC4gVGhpcyBpcwo+ID4g
c2V0dGluZyBhIHByb3BlciBkZWZhdWx0IGZvciBSQVVDIGVuYWJsZWQgc3lzdGVtcy4KPiA+IAo+
ID4gU2lnbmVkLW9mZi1ieTogTWFydGluIFNjaHdhbiA8bS5zY2h3YW5AcGh5dGVjLmRlPgo+ID4g
LS0tCj4gPiDCoGJvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtcC9waHljb3JlX2lteDhtcC5lbnYg
fCA0ICsrKysKPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBk
aWZmIC0tZ2l0IGEvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1wL3BoeWNvcmVfaW14OG1wLmVu
dgo+ID4gYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bXAvcGh5Y29yZV9pbXg4bXAuZW52Cj4g
PiBpbmRleAo+ID4gOWExMjlhMGE0YmZjNDhmMWZhNzBlYTZlMmY4OTVhY2FjM2NhMDVkMi4uNzAw
NDQ5OTdhZGI4YWQxZTRhN2MyNGZhYQo+ID4gNTJmOWQ3OGJlY2IKPiA+IDIyOWUgMTAwNjQ0Cj4g
PiAtLS0gYS9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bXAvcGh5Y29yZV9pbXg4bXAuZW52Cj4g
PiArKysgYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bXAvcGh5Y29yZV9pbXg4bXAuZW52Cj4g
PiBAQCAtMyw3ICszLDExIEBAIGJvb3RjbWQ9Cj4gPiDCoAkJZmFzdGJvb3QgMDsKPiA+IMKgCWZp
Owo+ID4gwqAJYm9vdGZsb3cgc2NhbiAtbGI7Cj4gPiArI2lmZGVmIENPTkZJR19CT09UTUVUSF9S
QVVDCj4gPiArYm9vdG1ldGhzPXJhdWMgc2NyaXB0IGVmaQo+ID4gKyNlbHNlCj4gCj4gY2FuIHNj
cmlwdCBhbmQgZWZpIHN0aWxsIGJlIHVzZWQgd2l0aCByYXVjLCBpLmUuIHRoZXkgYXJlIG5vdAo+
IG11dHVhbGx5Cj4gZXhjbHVzaXZlPwoKVGhleSBhcmUgbm90IGV4Y2x1c2l2ZS4gSWYgdGhlcmUg
aXMgbm8gZGV2aWNlIGZvdW5kIHdpdGggYSB2YWxpZCBSQVVDCnN5c3RlbSBvbiBpdCwgdGhlbiBz
Y3JpcHQgYW5kIEVGSSBhcmUgdHJpZWQgaW4gb3JkZXIuCgo+IFRoZSBtb3RpdmF0aW9uIGlzOiBE
b2VzIGl0IG1ha2Ugc2Vuc2UgdG8gbGlzdCB0aGVtIGFzIHdlbGwgb3Igc2hvdWxkCj4gd2Ugb25s
eSBzZXQKPiBib290bWV0aHM9cmF1Yz8KClRoYXQgaXMgYSBnb29kIHF1ZXN0aW9uLiBUaGlzIGRl
cGVuZHMgb24gd2hldGhlciB3ZSB3YW50IGEgZmFsbGJhY2sgaW4KY2FzZSBubyBSQVVDIHN5c3Rl
bSBpcyBmb3VuZCAoZS5nLiBpbiBjYXNlIGl0IGlzIGZhdGFsbHkgYnJva2VuKSBvcgpub3QuIEEg
ZmFsbGJhY2sgY291bGQgYmUgdXNlZnVsIGluIGNhc2UgdGhlIGJvYXJkIG5lZWRzIHRvIGJlCnJl
Y292ZXJlZC4gVGhlbiBib290aW5nIHZpYSBzY3JpcHQgdGhyb3VnaCBlLmcuIFNEIG9yIG5ldHdv
cmsgY291bGQgYmUKdXNlZnVsLgoKT24gdGhlIG90aGVyIGhhbmQsIHRoZXJlIG1heSBiZSB1c2Ut
Y2FzZXMsIHdoZXJlIHVzZXJzIHdhbnQgdG8gb25seQphbGxvdyBib290aW5nIHZpYSBib290bWV0
aCByYXVjLCBlLmcuIGZvciBzZWN1cml0eSByZWFzb25zLgoKSG93ZXZlciwgYXMgdGhpcyBpcyBh
IGRldmVsb3BtZW50IGFuZCBleGFtcGxlIGJvYXJkIGNvbmZpZ3VyYXRpb24sIGFuZAp0byBrZWVw
IGl0IGluIHN5bmMgd2l0aCBvdXIgQU02KiBib2FyZHMsIEknZCBzdWdnZXN0IGtlZXBpbmcgdGhl
CmJvb3RtZXRoIG9yZGVyIGFzIGlzLgoKUmVnYXJkcywKTWFydGluCgo+IAo+IFlhbm5pYwo+IAo+
ID4gwqBib290bWV0aHM9c2NyaXB0IGVmaQo+ID4gKyNlbmRpZgo+ID4gwqBib290X3RhcmdldHM9
bW1jMiBtbWMxIHVzYiBldGhlcm5ldAo+ID4gwqBib290ZW52X2FkZHJfcj0weDQ5MTAwMDAwCj4g
PiDCoGJvb3Rfc2NyaXB0X2RoY3A9Ym9vdC5zY3IudWltZwo+ID4gCj4gPiAtLS0KPiA+IGJhc2Ut
Y29tbWl0OiA1YjkzYzNlYzdmOWQ2NmRjNDBkMDYyYTQ3YTRhODgwZjdkMzQ2YjdhCj4gPiBjaGFu
Z2UtaWQ6IDIwMjUxMDAyLXdpcC1jb25maWctaW14OG0tYm9vdG1ldGgtcmF1Yy03MjZmZDc5Zjgx
NDUKPiA+IAo+ID4gQmVzdCByZWdhcmRzLAo=
