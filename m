Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90663F3C24F
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 13:19:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BBA783BC8;
	Mon,  9 Mar 2026 14:19:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="irHxUDFQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2187F83F1F; Mon,  9 Mar 2026 14:19:53 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F01D8063E
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 14:19:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mthiFUjsimS/JnnSZcW7uUdLqSYhefj5IxyX9ouim1iwq7jz3ZJzKCV++4Cx3UbBUulzHNEiR400BxmBCgtyoc4gxqh6UzQiMFyF9lmqX7op3sOOdsrs2mV9US8b1J8Rxs7VouV4Bgu6bmPwoJr3QdXdYB63PHlJRFbhy+Eo1PU7TdR7hoaji0i55Si3mpyqI4ItAhyBlo2oqDdRgwVMK2FvoYZ9sVMXBHW9L87C7C8/TCvXSlZ/eVCHNYLpiSacmT6uEOfP6ZFTBvYmYEd7SSiMdxy231nPWdaA/ixJB3TkH+CJtz49X+n5xyJT+Qox48tQCAwGMRE7LoDVoGRzmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAw5Sz1QBojeXnk1cJvEpzLKke0iIfsMqpe3SktwPTA=;
 b=D5K3Dr/JHsVcvoCeJbpOM0vv6m8D/TDLjH3dHeVm9lhTQRI2IPS+6TahEGYgOP4TQBuRS922lMeDUG582xmYMBwOiUfwGIG8dfuZjyF/oPBA5V2WyJILLLfCVw/vGeTlpJ491bvu29jtroENrbnsigpcqXhv3SJIdzyK66mnQykBAplqlYa/QU3fH9fq08zF0MMWbUjQJhIWBecvIEv1pBIZJR1wyrgpEgu71ElM118Q9JtYV4imlxbNlp6FIrBnF1zkXc9K4U5HvI83TWj/R3tPZfiW/mohvGnYTUZg5HY8I3FvF1ZM+OATWKyocje1GOeZKg4l2Vs9PBRADfHUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAw5Sz1QBojeXnk1cJvEpzLKke0iIfsMqpe3SktwPTA=;
 b=irHxUDFQYgRqPB3ywfrxj3zuB4IJd0iXrDGv+YlKgk7zsI+PvTVLrdRwY13fAGn1ehwwmfESNHG6UUxrGIAHjTLijXAqzpEr4aBz5My7dWE/zR71ZPAokEybNjg4k8jVfSLp7+ehyu5Pd0oF1ZwSoRIvhEBtcpD6hGaLBZlJv0o=
Received: from PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16)
 by SA1PR12MB6993.namprd12.prod.outlook.com (2603:10b6:806:24c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Mon, 9 Mar
 2026 13:19:40 +0000
Received: from PH0PR12MB7096.namprd12.prod.outlook.com
 ([fe80::9fa7:558:62ae:afdb]) by PH0PR12MB7096.namprd12.prod.outlook.com
 ([fe80::9fa7:558:62ae:afdb%4]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 13:19:40 +0000
From: "Vinay Tilak, Pranav" <Pranav.VinayTilak@amd.com>
To: Jerome Forissier <jerome.forissier@arm.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "Simek, Michal" <michal.simek@amd.com>
CC: "git (AMD-Xilinx)" <git@amd.com>, "Begari, Padmarao"
 <Padmarao.Begari@amd.com>, Tom Rini <trini@konsulko.com>, "nd@arm.com"
 <nd@arm.com>
Subject: RE: [PATCH] net: lwip: scale buffer pool size with TFTP block size
Thread-Topic: [PATCH] net: lwip: scale buffer pool size with TFTP block size
Thread-Index: AQHcrGserHaJY6kj4UqnErnQGLOUGrWl3tEAgABM2HA=
Date: Mon, 9 Mar 2026 13:19:38 +0000
Message-ID: <PH0PR12MB70963209D076B0D27A12FFDFFB79A@PH0PR12MB7096.namprd12.prod.outlook.com>
References: <20260305064033.8726-1-pranav.vinaytilak@amd.com>
 <a3262e83-95dd-46fe-a0cf-fd6d7e429ab1@arm.com>
In-Reply-To: <a3262e83-95dd-46fe-a0cf-fd6d7e429ab1@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-09T13:15:49.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7096:EE_|SA1PR12MB6993:EE_
x-ms-office365-filtering-correlation-id: 401a8924-0bb2-455c-a0b6-08de7dde8520
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: QeCcYXR9rVT3UwoVmwA6yG6AtSZK9pHgkvghGoUTGw3ebb6nWl0Fek2Q7hX4dJ4qlWuBoxlX2GfyyMwRQ3VXZ4dWwOuTd4pOXF/7OKR5OrxFuuERuVPgfU8loDBYnzd3XPN60A8yeO+WA/VaKTrSCuZBg5/8TZtwiAPB8JE84Luhs/Z1IcXKz8STLt2yl66QcFC+AZMxL2f/lY8HQHMvHHivxvl6RWDqzaWCGVxBXm1KuvoJYK4ZeB1WUqSX4l6JU2nZujmTqxBl9NtCTe4JsM0xmKAws5GZ1Nj8+1HJ3U9aR49F23Pv+7ik0bN/wsuMM4GJloodyPZJB7wdC7n/w1A/o8VbTb2+4JErioafFNE3cp1OISfqi3LKEJzAujbZKE/OovrMtqbaSHNhoOE/NEbaxRLbcJ71MdoU/WEBeZ3Eo3sYUrN8knJwFzQbcZYkpzQZQdjMlX5mFn1JbKzdAP4PQ19aCsKPnLNz8Ov8bzWwwj0BLajSY3G/B9rcgG5R5b29IAICqtOCJFaOOk9obu5ZFX+H1n/JpMu/CiMOiySVHRuA0+BTvP2K7bceXk1/7X/GDpE8c5tXaR83rWVUZsMlsxcu221rKse1WLYofPZFjgq7qMa3TIagu+Q8LisfxzbzIjNo3tE3tsiuC1TxA7GoD0uEMGuEVz+0lNjqPbbwC4CLim6Ao7HJwqEHKe5Cu6fDSg2b/fZ4BHby+3N8UE1CHGmOSPvDFW7EooSMk98z3szDZnUe/uVPX+eBhy/r5WG30tQskCi3LkmEOc9pWQEKEGlAqAqDkfwqZOPhOLw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7096.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SklkN2JiU0NJVFVzZFNXR3M4VnovZ2d0OGZoS1dpNXlpV2M1NnBIbmdWWlFV?=
 =?utf-8?B?ZmxiRzJaMVB1WURGbmJQcXlXdTY5dFBGbEJTTkhqdEQ4UitGMXR1OGwvRkZj?=
 =?utf-8?B?dWhITXRYUCtMcG1Jbk1MOXA0NTRkSDcxZkhSKytBekE1bU9FU05ZQ05ndkRu?=
 =?utf-8?B?NG5OWUN1U3FqZnNVWGVyUDZqSGsyVDJ5VElGMnpVNlhOMk1tdm5ad0ZheTlN?=
 =?utf-8?B?SENXKzd2YmUvTGRZNnQyb1FqVm1lc2thaDJ1Z2N4ZlhEUCtEaE1NbHM5eVFT?=
 =?utf-8?B?Tzk3b3llOVpTWndMdTA0bHBBVGZUeXUzdXNzN3Rld0tQTFRiTGtpQjFySjd3?=
 =?utf-8?B?bWI5dG1RZ1htZFRZMGYyVk12cUM4S2d4VzV4TzdnanJybUJnRDFyMnZySEdI?=
 =?utf-8?B?bzJ2ZlFaYjFLMldUaWx6SlZyUXlXYUYxMlBrSmR0NU54R3lQQjFMVXExYkxj?=
 =?utf-8?B?OHd5ZEhTUVkwSXhFVmx0R3ZrUHQ2RGhucWk1Q25pTjg1bHhNZ3lRM0h0ZjNt?=
 =?utf-8?B?SGhjcXJnZ1lZYjBIYmF4V2pGL2hpNGw2bzR0Q0xsT2xGK2ZpdVBIRStIT2NJ?=
 =?utf-8?B?VUZGUVBrNk1sc2Q4K0piWW5USGF2UTRaNEVBcUVhRWo3bzdmSUVtN2V2RFRF?=
 =?utf-8?B?S2FxVWFlL2tQU2VPL091T3QwekNacFZiQ2dsZE1OTjhSNE1haWNwcE1xSGU1?=
 =?utf-8?B?MjNiNURJTXdlT3JvVkRwTXZLYWNTTGVnSTZHdGhQRE50Sm41SXBpbjZWZVFw?=
 =?utf-8?B?YlRlbytoZ05YSjl3TjhGakxqMzdnRkxvQ01vYlYxNGgxRHVXTFFrN2JnU1o1?=
 =?utf-8?B?T0o4S25Cc2MyRjZrOEJNSUpjOERqRjlhSzFXYWhmMVQ5TnJvMnIva1J2Y2hv?=
 =?utf-8?B?NU0yQUJ5QklNRlArVDJCVlBHS3IvZjkzSVcvaW16NDNzcS9YcVFjdlZmalVw?=
 =?utf-8?B?SjdjRHpxK1dmWERmbXprVFhNQjFxdmcwVzVLaC81YlFNRVQ5SFVGUFdFUUZn?=
 =?utf-8?B?NHp6V1oreW1sL1lyS21yT0FVQkRqWk1JSEFSZVVUTXJOWFA2RmdoYVNCMVFS?=
 =?utf-8?B?cEVldHYzL3BDeDBMbklhS04xQzNFOUtJNU1hVHB3UmVaVS9Kc092S0IyYS9Y?=
 =?utf-8?B?bVRrejRxZ21sZ3J0V0ltRW5qemNRU0NqWHB0V0pCOE9vMVFBNW9sQTFEdTgy?=
 =?utf-8?B?bGVyWmJMWVZpVXJEM2NDeFUyNzI3VkZjM1V1VnB0RUpYZlhOcURrZ0lESUVk?=
 =?utf-8?B?MlBRajJhUTFhYjdTTWJWMlZkSTNPb2RBVnRZYU9GNThBbmh5elA1WmxYbjRj?=
 =?utf-8?B?dWF1NnFqcXJoaVk3VW1WUkc1YWYyYk43cmZuL3F0ZTB1dTE4ZENYUGpzQ09V?=
 =?utf-8?B?SFNPQ2ZJYWxSR0N2TVZsQ1pXUG1IQ3hCOE1TOWY1SmhLb1I2dm5TbVpZeSsv?=
 =?utf-8?B?L3N1d215UlhYdGllb0tYRzJkY3B1S1ljMEwrZithcThINWJXVmNQNm1xMzlt?=
 =?utf-8?B?bS9ibGpMdGVXOGFocjdtMFd4Z2JWamdXNlg4MjV1WElxVWhkODV6RHo0NldG?=
 =?utf-8?B?Vk5IWXBjRUoydmNXTVZSclkvdXArdU9FSEZFUkNEQUtTeTdlMmkrUG5MY3c4?=
 =?utf-8?B?RTl2RlV1d3Z3RkhvYTZkRjAzWGNYRWpJODVnVndheE5NTEMrRDVjcUkyTmdQ?=
 =?utf-8?B?elRHU3psYW14Z1FFdld6cUcrdU1jdGdFdXd4Rldsa3htNUVaNDFabEpHdldG?=
 =?utf-8?B?VGFyZ1YraWQ4WjJtN1BhWTAxcjY5VldtaUw3QVRpUis5Zzg5ZE5TOXFWQVEv?=
 =?utf-8?B?M3ZWZWNaV09sOTdXL0xzbXZKZE5VeHBaZkJ2TVRTNDdjN0s4SFllYnBlRTBk?=
 =?utf-8?B?OU1kallvNHlDL2FPeU9UaHFZK296VkRxSi9sTlVjQVd3TXc3emRSd01aSW16?=
 =?utf-8?B?SkZCdnVqci9LY1ErbFhSZGg2Mkx3cGtUQ1hkSnc3enBIaktjanlnMWM0S2d6?=
 =?utf-8?B?ME8zZmdmT2JxbjJ2ZnFDZXRGVzVIMzIwalRheDdDSkRWS29oTVZpcCt1SG84?=
 =?utf-8?B?L0QyZExsMjd6Qm5nT0xURjRpSGdURXdKaGcvOWNrNElIUVpQTTBSQUsxZjVM?=
 =?utf-8?B?Wm9yZjk4MVNQUkpqbk5RNStoM3YyTS9kQit0WVZWQ3JrSzNwOXVxcldtYmQr?=
 =?utf-8?B?Sm5wNkZKZGJXbUdzZWFMYi94RlBNN2t5VTFUbHVvZ0lUNkcxejBsWkQ2YmRS?=
 =?utf-8?B?b1pCeldGMFlMd1B6dG15eUtMVStldENXVVJkZHZKNTlaalpTQmM5M0c3V2Rn?=
 =?utf-8?Q?fX83Yr5ICHrrb1NdWH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7096.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401a8924-0bb2-455c-a0b6-08de7dde8520
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 13:19:38.5195 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wIpxuCM6cpBxi9NhsnZYQ1xMudheDyIM2w0c0u9zqP0SG1KLe+MNyP77efTLoWNS+60tbHHWNXH5Bts1zMVn5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6993
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

W1B1YmxpY10NCg0KSGkgSmVyb21lLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IEplcm9tZSBGb3Jpc3NpZXIgPGplcm9tZS5mb3Jpc3NpZXJAYXJtLmNvbT4NCj4gU2Vu
dDogTW9uZGF5LCBNYXJjaCA5LCAyMDI2IDE6MzggUE0NCj4gVG86IFZpbmF5IFRpbGFrLCBQcmFu
YXYgPFByYW5hdi5WaW5heVRpbGFrQGFtZC5jb20+OyB1LWJvb3RAbGlzdHMuZGVueC5kZTsNCj4g
U2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+DQo+IENjOiBnaXQgKEFNRC1YaWxp
bngpIDxnaXRAYW1kLmNvbT47IEJlZ2FyaSwgUGFkbWFyYW8NCj4gPFBhZG1hcmFvLkJlZ2FyaUBh
bWQuY29tPjsgVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT47DQo+IG5kQGFybS5jb20NCj4g
U3ViamVjdDogUmU6IFtQQVRDSF0gbmV0OiBsd2lwOiBzY2FsZSBidWZmZXIgcG9vbCBzaXplIHdp
dGggVEZUUCBibG9jayBzaXplDQo+DQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVk
IGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVu
aW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4g
SGkgUHJhbmF2LA0KPg0KPiBPbiAwNS8wMy8yMDI2IDA3OjQwLCBQcmFuYXYgVGlsYWsgd3JvdGU6
DQo+ID4gVEZUUCB0cmFuc2ZlcnMgZmFpbCB3aGVuIHRmdHBibG9ja3NpemUgaXMgc2V0IHRvIDgx
OTIgb3IgbGFyZ2VyIGR1ZSB0bw0KPiA+IGluc3VmZmljaWVudCBidWZmZXIgcmVzb3VyY2VzIGZv
ciBJUCBmcmFnbWVudCByZWFzc2VtYmx5Lg0KPiA+DQo+ID4gQWRqdXN0IFBCVUZfUE9PTF9TSVpF
IGFuZCBJUF9SRUFTU19NQVhfUEJVRlMgYmFzZWQgb24NCj4gPiBDT05GSUdfVEZUUF9CTE9DS1NJ
WkUgdG8gc3VwcG9ydCBsYXJnZXIgVEZUUCB0cmFuc2ZlcnMgd2hpbGUga2VlcGluZw0KPiA+IG1l
bW9yeSB1c2FnZSBlZmZpY2llbnQuDQo+ID4NCj4gPiAtIENPTkZJR19URlRQX0JMT0NLU0laRSA+
PSAxMjI4ODpQQlVGX1BPT0xfU0laRT0xOCwNCj4gPiBJUF9SRUFTU19NQVhfUEJVRlM9MTINCj4g
Pg0KPiA+IC0gQ09ORklHX1RGVFBfQkxPQ0tTSVpFID49IDgxOTI6UEJVRl9QT09MX1NJWkU9MTIs
DQo+ID4gSVBfUkVBU1NfTUFYX1BCVUZTPTYNCj4gPg0KPiA+IC0gQ09ORklHX1RGVFBfQkxPQ0tT
SVpFIHVuZGVmaW5lZDogUEJVRl9QT09MX1NJWkU9OCwNCj4gPiBJUF9SRUFTU19NQVhfUEJVRlM9
NA0KPg0KPiBIb3cgYXJlIHRoZXNlIHZhbHVlcyBjb21wdXRlZD8gQ291bGQgeW91IGZpbmQgYSBm
b3JtdWxhIGluc3RlYWQgb2YgdXNpbmcNCj4gI2lmLyNlbGlmLyNlbHNlL2VuZGlmPw0KDQpXZSBj
YW4gdXNlIHRoaXMgZm9ybXVsYSBmb3IgY2FsY3VsYXRpbmcgdGhlIHZhbHVlcyBvZiBQQlVGX1BP
T0xfU0laRSBhbmQgSVBfUkVBU1NfTUFYX1BCVUZTLg0KMTUwMCAoTVRVKSAtIDIwIChJUCBoZWFk
ZXIpID0gMTQ4MCB1c2FibGUgYnl0ZXMvZnJhZ21lbnRzLg0KSVBfUkVBU1NfTUFYX1BCVUZTID0g
KCgoQ09ORklHX1RGVFBfQkxPQ0tTSVpFKSArIDE0NzkpIC8gMTQ4MCkgKyAyDQpbY2VpbGluZyBk
aXZpc2lvbiB0byBjYWxjdWxhdGUgZnJhZ21lbnQgY291bnQgKyBzb21lIGhlYWRyb29tIGZvciBu
ZXh0IGJsb2NrIHN5bmNdLg0KUEJVRl9QT09MX1NJWkUgPSAoSVBfUkVBU1NfTUFYX1BCVUZTKSAq
IDINCltSZWFzc2VtYmx5IGJ1ZmZlcnMgKiAyXS4NCg0KV2UgY2FuIHNjYWxlIG9ubHkgaWYgQ09O
RklHX1RGVFBfQkxPQ0tTSVpFID4gNDA5NiBlbHNlIHVzZSB0aGUgZGVmYXVsdCB2YWx1ZXMuDQo+
DQo+IFRoYW5rcywNCj4gLS0NCj4gSmVyb21lDQo+DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJhbmF2
IFRpbGFrIDxwcmFuYXYudmluYXl0aWxha0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBsaWIvbHdp
cC91LWJvb3QvbHdpcG9wdHMuaCB8IDE1ICsrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMTUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2xpYi9sd2lwL3Ut
Ym9vdC9sd2lwb3B0cy5oIGIvbGliL2x3aXAvdS1ib290L2x3aXBvcHRzLmgNCj4gPiBpbmRleCBl
OGEyYzlkN2EwYS4uYjRmZjMxMDk2ZmUgMTAwNjQ0DQo+ID4gLS0tIGEvbGliL2x3aXAvdS1ib290
L2x3aXBvcHRzLmgNCj4gPiArKysgYi9saWIvbHdpcC91LWJvb3QvbHdpcG9wdHMuaA0KPiA+IEBA
IC02NSw3ICs2NSwxNCBAQA0KPiA+ICAjZGVmaW5lIE1FTV9BTElHTk1FTlQgICAgICAgICAgICAg
ICAgICAgOA0KPiA+DQo+ID4gICNkZWZpbmUgTUVNUF9OVU1fVENQX1NFRyAgICAgICAgICAgICAg
ICAxNg0KPiA+ICsNCj4gPiArI2lmIGRlZmluZWQoQ09ORklHX1RGVFBfQkxPQ0tTSVpFKSAmJiBD
T05GSUdfVEZUUF9CTE9DS1NJWkUgPj0NCj4gMTIyODgNCj4gPiArI2RlZmluZSBQQlVGX1BPT0xf
U0laRSAgICAgICAgICAgICAgICAgIDE4DQo+ID4gKyNlbGlmIGRlZmluZWQoQ09ORklHX1RGVFBf
QkxPQ0tTSVpFKSAmJiBDT05GSUdfVEZUUF9CTE9DS1NJWkUgPj0NCj4gODE5Mg0KPiA+ICsjZGVm
aW5lIFBCVUZfUE9PTF9TSVpFICAgICAgICAgICAgICAgICAgMTINCj4gPiArI2Vsc2UNCj4gPiAg
I2RlZmluZSBQQlVGX1BPT0xfU0laRSAgICAgICAgICAgICAgICAgIDgNCj4gPiArI2VuZGlmDQo+
ID4NCj4gPiAgI2RlZmluZSBMV0lQX0FSUCAgICAgICAgICAgICAgICAgICAgICAgIDENCj4gPiAg
I2RlZmluZSBBUlBfVEFCTEVfU0laRSAgICAgICAgICAgICAgICAgIDQNCj4gPiBAQCAtNzYsNyAr
ODMsMTUgQEANCj4gPiAgI2RlZmluZSBJUF9SRUFTU0VNQkxZICAgICAgICAgICAgICAgICAgIDEN
Cj4gPiAgI2RlZmluZSBJUF9GUkFHICAgICAgICAgICAgICAgICAgICAgICAgIDENCj4gPiAgI2Rl
ZmluZSBJUF9SRUFTU19NQVhBR0UgICAgICAgICAgICAgICAgIDMNCj4gPiArDQo+ID4gKyNpZiBk
ZWZpbmVkKENPTkZJR19URlRQX0JMT0NLU0laRSkgJiYgQ09ORklHX1RGVFBfQkxPQ0tTSVpFID49
DQo+IDEyMjg4DQo+ID4gKyNkZWZpbmUgSVBfUkVBU1NfTUFYX1BCVUZTICAgICAgICAgICAgICAx
Mg0KPiA+ICsjZWxpZiBkZWZpbmVkKENPTkZJR19URlRQX0JMT0NLU0laRSkgJiYgQ09ORklHX1RG
VFBfQkxPQ0tTSVpFID49DQo+IDgxOTINCj4gPiArI2RlZmluZSBJUF9SRUFTU19NQVhfUEJVRlMg
ICAgICAgICAgICAgIDYNCj4gPiArI2Vsc2UNCj4gPiAgI2RlZmluZSBJUF9SRUFTU19NQVhfUEJV
RlMgICAgICAgICAgICAgIDQNCj4gPiArI2VuZGlmDQo+ID4gKw0KPiA+ICAjZGVmaW5lIElQX0ZS
QUdfVVNFU19TVEFUSUNfQlVGICAgICAgICAgMA0KPiA+DQo+ID4gICNkZWZpbmUgSVBfREVGQVVM
VF9UVEwgICAgICAgICAgICAgICAgICAyNTUNCg0KVGhhbmtzLA0KUHJhbmF2IFRpbGFrDQo=
