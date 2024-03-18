Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C92C54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 11:29:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F50787D82;
	Mon, 18 Mar 2024 12:29:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="Efk58QIY";
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="t6fLbWHx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 817C787CB1; Mon, 18 Mar 2024 12:29:47 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11A6A87E02
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 12:29:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Mihai.Sain@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1710761382; x=1742297382;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZBTbf65vy6gFjiNX3F2KlruJrWpmXY50M6XUbLCc3R8=;
 b=Efk58QIYuv5+YAqUsCSHePYpZsD/tBkLsakcsE25XspLmXrwPdGhNr/d
 3JyTH2txx+65fY82PRV2AmXjUepe0FZMrtuIGxSBM/7O7bxnmbRTCdOEU
 hgLDl/WKdZIji12tpjCT5qMYUhXFvLLxo2RXd9zrnx4rB5HNU0gyheyDF
 hHGbHi875tbHlnJ/+JSqXeEEC26grWZ/aBHiI8hqxSPGIajaVNjMkZ87a
 XaXJhfVccSfPhMZc0VjEJWk74UWjOLdjC2+wVKv9wQmv5MEz+oN0kzQzv
 8KsEh6e1IcLzP0GMI3J7O0AcJAXn0ubBXWQhieJ72xZoLXomNz2arLyt3 g==;
X-CSE-ConnectionGUID: RDY7fVH9QsOG5zQ/vTexcg==
X-CSE-MsgGUID: uJh+43VNTn+XGR0s1MmHlw==
X-IronPort-AV: E=Sophos;i="6.07,134,1708412400"; d="scan'208";a="17753655"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 Mar 2024 04:29:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 04:28:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 04:28:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8hkpvQv/gMCzor0H2VMDKKK5jId+IgkepPTxRfnJ0IiSB3QoDgo2JMcNP2S5GoQxhaz+eoSYl3/iLjaipRYPqLsyyZKi76jC8bRV7jwk0Dqlvx84+3xbb7bTFplNGrArREzBlxkIkim95ZN4vcxYo1OyraNja3HhaGjYi5zDUZTKY5+8KuFmcj46d2Hi3UqgyKiK979yh6AiuKK2PiiiT5cbuxNA2E4K2vn4upLaCmZy9WNW6PO4hF5boNuN/aqQm/XnFBtirrCvNBEI4QQxD3XgjYHtzxfUj432TW4X9GJDQiyLUSC6MD8uML8nNfyD3Zczaefmc9DYsOjEKUfBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBTbf65vy6gFjiNX3F2KlruJrWpmXY50M6XUbLCc3R8=;
 b=V7VJUiy8kQwdyjb+nL2ot8HrpdNvL90j6qkG1BhjCDiDAMh0raEu9vIfOKtHIxd4ToYc/kSvJKXj3XfnWGkQKkTV+tsYJ89EX7bsbrLbrpQaM5TKrkWuymruB9+5gJttb4TG/ytaZQSjQXCLV2rDtezu7pY2e6/nQJtqynMA4EvJR49EUPEH4tkB2u9yVnW3F8TiHyOnlG+56Q/PwZott5o5q8hZQ80T0UgcnETCN+0ffPGXgeTlTn07hzqcY9wXn8FOO9QioPZO5bORgo50x13ri48ds5dj18B0Kacm2P8WLxAdOJCREmxuH9KXyry9fu4InJ6gnhm6IWFOjeKxmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBTbf65vy6gFjiNX3F2KlruJrWpmXY50M6XUbLCc3R8=;
 b=t6fLbWHxCw7nwXhKDF0KtaXxgqr6q8RnmQtUUKFVG5nvkegLnm1FVNxS9sFnUUg/z/9UAveU/uO9FtjMrWPpLJqZ1fQLYES/yxpwT7CS3KWCDmmX+L8UD9LWY7sHyZT8P1IOGTvibMw2jlhVGL1WdrahY/r9j4HnbhV1DwAbPrtZw2s91fMuc2eDmm2dDOv80THC2rpdD1ACxsV5Hw1B50nvb2wCYuzMI2QZ2qONqM/W2Pae+7VPfa7+LonlV2p/GBwo/byC0hnUL0ibp4tNbqrbUVArKKryN+iMWEEnJdlW/N/CljXuPw6DRwZ6rYrljAmqNwUtZQRDZ7DjNXJk0Q==
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by DS0PR11MB8019.namprd11.prod.outlook.com (2603:10b6:8:12e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Mon, 18 Mar
 2024 11:28:39 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::8724:4f0d:7186:266c]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::8724:4f0d:7186:266c%6]) with mapi id 15.20.7409.009; Mon, 18 Mar 2024
 11:28:39 +0000
From: <Mihai.Sain@microchip.com>
To: <ada@thorsis.com>
CC: <eugen.hristev@collabora.com>, <dario.binacchi@amarulasolutions.com>,
 <michael@amarulasolutions.com>, <Balamanikandan.Gunasundar@microchip.com>,
 <u-boot@lists.denx.de>
Subject: RE: [PATCH 4/4] mtd: nand: raw: atmel: Introduce optional debug
 commands
Thread-Topic: [PATCH 4/4] mtd: nand: raw: atmel: Introduce optional debug
 commands
Thread-Index: AQHacHYz5NjLBjcwWUSp31aMRMD+07E9M2MAgAANRwCAAANSQIAAJy6AgAAAqiA=
Date: Mon, 18 Mar 2024 11:28:39 +0000
Message-ID: <PH8PR11MB68042D7DF9FDA068033F4CEB822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
References: <20240307091014.39796-1-ada@thorsis.com>
 <20240307091014.39796-5-ada@thorsis.com>
 <82a5ea3c-ab95-4460-9685-2676fe18d6b5@collabora.com>
 <PH8PR11MB6804301C3B361D21EADCEE71822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
 <20240318-tug-shrank-ae6315aaa6f4@thorsis.com>
 <PH8PR11MB68045C740982A66703188E70822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
 <20240318-crate-glisten-c4ee6f3469ea@thorsis.com>
In-Reply-To: <20240318-crate-glisten-c4ee6f3469ea@thorsis.com>
Accept-Language: en-GB, en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|DS0PR11MB8019:EE_
x-ms-office365-filtering-correlation-id: 2b12e23a-81bb-44ca-6c58-08dc473e8f58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 47Iu1oWO+WZKJWNEr/BwepqC+d12RdTSYjIic9dKOQrin/rlaS8rXnr+srHe4HqpYLcMxm5bVOME1IeSMmz4+TAG/35Qsk1Wjmj8YBnJdif0h4SE2l447eN2YMLbCZaQ3iQFtkKYabrMEnR+xHguAP6pXjOIXIAlLo9JB44jk6e/8X8m+b8Lpd6yCKZr7rPXoiB4kb9eqv0syu3cBT9cJQH6hkspYr0YZ/xC8rytx9fqSQtqA+ojoC4hguv3zqS0bweNMLJ50hS3dCyG9FyduEbWC8+CphBGacF2KB+nBeZR7ugpL85W/71qo01bbGDvzFpMGOTsz4z8fSwjUiYAaucSKm0ePJcaIsn2bdyjUHRW17945tiqUER18GPsOvoGLXSfZR0BowWSQ/XCj2XP3UFcUnC2c5KLWOyaca76tyl1jFjEkZ56g8aUzsIww2XIiYajCM6sDhmoAhZMl+7S5sIpllx48wC9gs8+FRlg1kCH94mHVQl6vhmfu6wqyP/UbezXfSoOmpmgg32vhbhkjxRsHf34WEhyo0+5UooQPFbcMjNixUUw8IFt3O9niJOByRtO6un1NmP0uY6uPV3cjc+yAYCCTf5QCDW+lIUJp2UuPkLFLn7cDPZY2eo3xtkiNUst7t4YWP+61jH77LfrT/quJPKeD+4Rw9xZicBnWYkr9yWQu0IIhxCJSadQa3lY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6804.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVpoVkN4alBaNjJ0bndPcThhR0RudkhOK2o5R095UjR0OFBHeUwxKzZqWFJw?=
 =?utf-8?B?Y1R6WjE5a002RmhkQ0RtMExBZWh3REtxZDJ4T0xwcnh1a1ZtMEVrV0wzRmdJ?=
 =?utf-8?B?UGsrWkZ3ampQdjdiOEpFcGhKSzlURGdHK092Z01PbEFsb3JsVUFhTEJ6WlVh?=
 =?utf-8?B?dE9yU1N6MU82bThVNUNtZThWTGNqR29FTmFiNVdDOW4ybTVmdXZyL0w1THVs?=
 =?utf-8?B?TzNIbGY1K2RUdk5GVm1EMUQ3aDU1U3E0cXY1UGt3UG1NZXdxV1k0ZFRhZ0tl?=
 =?utf-8?B?UXRLM3dEYXErRUE4ekhUT3YwZW5nTlhZWG1SeXloV2hEVUd6alJTMmFod1Vp?=
 =?utf-8?B?MW5vN0xySUlHYklqdS9OVzl0Z1R3YjZCS0U2MEJUcTMvcE1Wb1g0SkhBSUdF?=
 =?utf-8?B?Z1lSU2dQbUMydTBLRWo0MHN4ck9Xek1XTXViUzJwVXlsc3dkMnFZOXM5UmRM?=
 =?utf-8?B?TjFRb0srZ09HcWpvWlVQck5DVGp3eVZnSmJtSEM1bnBERHpFeTVWTXRrQVhv?=
 =?utf-8?B?VmZhVks4VTRNc1pTUkY2ajdBbm1PRlpzYWRVMUtUVUNBZFRPeFNUbGtCMDM1?=
 =?utf-8?B?K3l6ZUNaOW42dkMwM2hoZFlJaUxmcnRYNlpRelJOWkpNdWgwWFFQTFpGN2RE?=
 =?utf-8?B?TEF1Y3I4UjFVVURDZnVpaDNhYmdONmJURjVIVHQ0cmNnVjN1Sy84WGx0UkdJ?=
 =?utf-8?B?RmRsQTByU01XNlRBN3Q5TGd0cmkrdWE4S21XUTFOYS9Fck40bTIvT244T1pE?=
 =?utf-8?B?dEpueUNnbCt4TEZNenhCeTV0dTNOMGdEZGZLZ2VzQnR3cDJaTVpuVFVXSVl3?=
 =?utf-8?B?d3oxeHQ0YUQyQjhYbkxxWWNuZkpuYVd2c3BsN3VVYlg1UklNNFV6ZlEyY2Jq?=
 =?utf-8?B?VmhaaE1GVFUzNDBrUG9BUzBYRmQ4N0FDUTZnMytjdXFkWFNCWFRTMWVxVjVI?=
 =?utf-8?B?VUl1TGlsejZCMUFJaEZIV0M1eVdBamxkd21VRW82T3ovaWFETUF3ZE5ZWTFl?=
 =?utf-8?B?NTU1cmRRbmVXVktmREtzc0NmWjFFaFYzWE5kMkFBL0ZJWmRPeXB2dmtMVTN1?=
 =?utf-8?B?SmlFcWNnampsemtGMTV5R0JHaitpNCtiTk4wZ2JPRnJjQm5UVnNyZWNGYjkv?=
 =?utf-8?B?VnFrQisyUk4yTjUva1I2U1Z2YmpJdFQ2Mi92YnFhWk1mWitjS1JZYW12eEE0?=
 =?utf-8?B?VUcrRk56c1VoNytkWkQvYmlNWmNOUGJSNjE4S1lmaDdMZU03dmo4QW1LSFlw?=
 =?utf-8?B?b29XQW9TWHhuRUNteU0vdDlWL1VLZGNZTU5CbTJqR1hlRHIycGNNN0x1eFpW?=
 =?utf-8?B?amFFeUNRTlhuTVlhZUx1ckEySTFNWU1KNG5mR25GSVlQd09wMkFnSnAyUXdL?=
 =?utf-8?B?cmMvRXU2dkN2OGt4MllNNW11aDFMYWdMNkkrbllqdmRsc3VkanZ1TlM3YjZ5?=
 =?utf-8?B?MjQ1OUpINDBlVDFoUXFVM0Q1Wm5iTUwzaGM2WTlBL21kVFBaTUovaHJuNmZm?=
 =?utf-8?B?L29MR1ZBbTBqRExkZkMzb252bVFNcm9hNWVPRkFpcUdUcE5Ra280YWhMZ2ZL?=
 =?utf-8?B?SVRkWUY5cyt1Z0lNcFJ6bGVRVVFhTDhnbko1b2s3REJ3Y0d2T3djYnZuREFz?=
 =?utf-8?B?N1NLcy9FbndzOUdlZUo0K3lVaVdMdGlZd0ZwVTNIMExkdjF0SlUwUnkzZE9m?=
 =?utf-8?B?c1VQalNwTkJObE16QjAreHBwWmc2Z1piWVE1UjZMd3QwRnREZTk4WnZ5c3Zy?=
 =?utf-8?B?TkhIZENRWGxBcWlOZzNyQlNOajFiUE9sYnRuTld0S0UwUXQ0elNEYlR1b0hp?=
 =?utf-8?B?MzN0dTVxamxJWlQ0eU82eDhNRThoallBMlVCTXRlRDlobERFampidGZjQktm?=
 =?utf-8?B?RzdLNHdJRlhaSVMrNmJhbzVGeVk3UUlvWmZGYXZveVZaS2orR0lrbUgwSjZL?=
 =?utf-8?B?Tk0wbllkQUNPZ3hSMkhnL2xVMTBrVGZPMnpBUWFreGhzNHFBdllmVEdsNEt2?=
 =?utf-8?B?cFl1a1haY3FOaGhjRFJlQVBDUFVuS1FDODEvSHcyRnBmYWFVWFFHOVdCRW40?=
 =?utf-8?B?a2t1TnUweW5LenFLNmJpcFo0Zi96eEY0Sllsa0tJWXdQQmZEcWdzOFp1VGJU?=
 =?utf-8?Q?aEcXh677WJaF83Y9bHQC/CFHl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b12e23a-81bb-44ca-6c58-08dc473e8f58
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 11:28:39.7738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dfl8lqNH3kyfQ1yimsefetjrAlkrwf9PcYp0YyrVuxYImK63pYOdf2X+0r17rptxp/8w6lLGYS+s6e17Es13JP3GUeyqh1FnUQseK/U5eeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8019
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

SGkgQWxleGFuZGVyLA0KDQpJJ20gc29ycnkgZm9yIHF1b3RpbmcgYmVjYXVzZSB0aGUgZW1haWwg
aXMgc2VudCBmcm9tIE91dGxvb2sg4pi5DQoNCj4gPiBVLUJvb3Q+IG5hbmQgaW5mbw0KPiA+DQo+
ID4gRGV2aWNlIDA6IG5hbmQwLCBzZWN0b3Igc2l6ZSAyNTYgS2lCDQo+ID4gICBNYW51ZmFjdHVy
ZXIgIE1BQ1JPTklYDQo+ID4gICBNb2RlbCAgICAgICAgIE1YMzBMRjRHMjhBRA0KPiA+ICAgRGV2
aWNlIHNpemUgICAgICAgIDUxMiBNaUINCj4gPiAgIFBhZ2Ugc2l6ZSAgICAgICAgIDQwOTYgYg0K
PiA+ICAgT09CIHNpemUgICAgICAgICAgIDI1NiBiDQo+ID4gICBFcmFzZSBzaXplICAgICAgMjYy
MTQ0IGINCj4gPiAgIGVjYyBzdHJlbmd0aCAgICAgICAgIDggYml0cw0KPiA+ICAgZWNjIHN0ZXAg
c2l6ZSAgICAgIDUxMiBiDQo+ID4gICBzdWJwYWdlc2l6ZSAgICAgICA0MDk2IGINCj4gPiAgIG9w
dGlvbnMgICAgICAgMHgwMDAwNDIwMA0KPiA+ICAgYmJ0IG9wdGlvbnMgICAweDAwMDI4MDAwDQo+
DQo+IFRoaXMgc2VlbXMgdG8gYmUgdGhlIHNhbWUgTkFORCBjaGlwIGFzIG9uIHRoZSBzYW05eDYw
IGN1cmlvc2l0eSwgYnV0IHlvdXIgb3V0cHV0IGhhcyB0aHJlZSBhZGRpdGlvbmFsIGxpbmVzLCBz
ZWUgbWluZToNCj4gRG8geW91IGhhdmUgc29tZSBhZGRpdGlvbmFsIHBhdGNoZXMgcHJpbnRpbmcg
bWFudWZhY3R1cmVyLCBtb2RlbCwgYW5kIA0KPiBkZXZpY2Ugc2l6ZT8gIEkgY2FuJ3Qgc2VlIHRo
b3NlIGxpbmVzIHByaW50ZWQgaW4NCj4gbmFuZF9wcmludF9hbmRfc2V0X2luZm8oKSBoZXJlLg0K
Pg0KPiBZZXMuIEkgaGF2ZSDwn5iKDQo+ICsgICAgIHByaW50ZigiICBNYW51ZmFjdHVyZXIgICVz
IFxuIiwgY2hpcC0+b25maV9wYXJhbXMubWFudWZhY3R1cmVyKTsNCj4gKyAgICAgcHJpbnRmKCIg
IE1vZGVsICAgICAgICAgJXMgXG4iLCBjaGlwLT5vbmZpX3BhcmFtcy5tb2RlbCk7DQo+ICsgICAg
IHByaW50ZigiICBEZXZpY2Ugc2l6ZSAgICU4ZCBNaUJcbiIsIChpbnQpKGNoaXAtPmNoaXBzaXpl
ID4+IDIwKSk7DQoNClRoaXMgaXMgbmljZSwgYW5kIEkgdGhpbmsgaXQgd291bGQgYmUgdmFsdWFi
bGUgdG8gaGF2ZSB1cHN0cmVhbS4NCk1heWJlIHlvdSBjb3VsZCBzZW5kIGEgcGF0Y2ggZm9yIHRo
YXQ/DQoJU3VyZS4gSSB3aWxsIHNlbmQgdGhlIHBhdGNoICENCg0KPiA+IFUtQm9vdD4gaHNtYyBk
ZWNvZGUNCj4gPg0KPiA+IG1jayBjbG9jayByYXRlOiAyMDAwMDAwMDANCj4gPg0KPiA+IEhTTUNf
U0VUVVAzOiAgICAweDAwMDAwMDAxDQo+ID4gSFNNQ19QVUxTRTM6ICAgIDB4MDcwNDA4MDQNCj4g
PiBIU01DX0NZQ0xFMzogICAgMHgwMDA3MDAwOA0KPiA+IEhTTUNfVElNSU5HUzM6ICAweDg4MDQw
MmYyDQo+ID4gSFNNQ19NT0RFMzogICAgIDB4MDAxZjAwMDMNCj4gPiBOQ1NfUkQ6IHNldHVwOiAw
ICgwIG5zKSwgcHVsc2U6IDcgKDM1IG5zKSwgaG9sZDogMCAoMCBucyksIGN5Y2xlOiA3ICgzNSBu
cykNCj4gPiAgICBOUkQ6IHNldHVwOiAwICgwIG5zKSwgcHVsc2U6IDQgKDIwIG5zKSwgaG9sZDog
MyAoMTUgbnMpLCBjeWNsZTogNw0KPiA+ICgzNSBucykNCj4gPiBOQ1NfV1I6IHNldHVwOiAwICgw
IG5zKSwgcHVsc2U6IDggKDQwIG5zKSwgaG9sZDogMCAoMCBucyksIGN5Y2xlOiA4ICg0MCBucykN
Cj4gPiAgICBOV0U6IHNldHVwOiAxICg1IG5zKSwgcHVsc2U6IDQgKDIwIG5zKSwgaG9sZDogMyAo
MTUgbnMpLCBjeWNsZTogOA0KPiA+ICg0MCBucykgVERGIG9wdGltaXphdGlvbiBlbmFibGVkIFRE
RiBjeWNsZXM6IDE1ICg3NSBucykgRGF0YSBCdXMNCj4gPiBXaWR0aDogOC1iaXQgYnVzIE5XQUlU
IE1vZGU6IDAgV3JpdGUgb3BlcmF0aW9uIGNvbnRyb2xsZWQgYnkgTldFIA0KPiA+IHNpZ25hbCBS
ZWFkIG9wZXJhdGlvbiBjb250cm9sbGVkIGJ5IE5SRCBzaWduYWwNCj4NCj4gVGhpcyBpcyBhbHNv
IGludGVyZXN0aW5nLiAgR2l2ZW4gdGhlIG1jayBjbG9jayByYXRlIGlzIHRoZSBzYW1lIGFzIG9u
IA0KPiBzYW05eDYwLCBJIHdvdWxkIGhhdmUgZ3Vlc3NlZCB0aGUgdGltaW5ncyBzZXQgYnkNCj4g
YXRtZWxfc21jX25hbmRfcHJlcGFyZV9zbWNjb25mKCkgc2hvdWxkIGdpdmUgdGhlIHNhbWUgcmVz
dWx0cywgYm90aCBmb3IgT05GSSB0aW1pbWluZyBtb2RlIDMsIHdoaWNoIGlzIHRoZSBmYXN0ZXN0
IG1vZGUgdGhlIChIKVNNQyBzdXBwb3J0cyBhY2NvcmRpbmcgdG8gY29tbWVudHMgaW4gdGhlIGRy
aXZlci4gIFRoaXMgaXMgdGhlIG91dHB1dCB3aXRoIHRoZSBwYXRjaCBpbiBxdWVzdGlvbiBhcHBs
aWVkIG9uIG5leHQgZm9yIHNhbTl4NjA6DQo+DQo+ICAgICBVLUJvb3Q+IGhzbWMgZGVjb2RlDQo+
DQo+ICAgICBtY2sgY2xvY2sgcmF0ZTogMjAwMDAwMDAwDQo+DQo+ICAgICBTTUNfU0VUVVAzOiAg
ICAgMHgwMDAwMDAwMg0KPiAgICAgU01DX1BVTFNFMzogICAgIDB4MDYwMzA3MDMNCj4gICAgIFNN
Q19DWUNMRTM6ICAgICAweDAwMDYwMDA3DQo+ICAgICBTTUNfTU9ERTM6ICAgICAgMHgwMDFmMDAw
Mw0KPiAgICAgTkNTX1JEOiBzZXR1cDogMCAoMCBucyksIHB1bHNlOiA2ICgzMCBucyksIGhvbGQ6
IDAgKDAgbnMpLCBjeWNsZTogNiAoMzAgbnMpDQo+ICAgICAgICBOUkQ6IHNldHVwOiAwICgwIG5z
KSwgcHVsc2U6IDMgKDE1IG5zKSwgaG9sZDogMyAoMTUgbnMpLCBjeWNsZTogNiAoMzAgbnMpDQo+
ICAgICBOQ1NfV1I6IHNldHVwOiAwICgwIG5zKSwgcHVsc2U6IDcgKDM1IG5zKSwgaG9sZDogMCAo
MCBucyksIGN5Y2xlOiA3ICgzNSBucykNCj4gICAgICAgIE5XRTogc2V0dXA6IDIgKDEwIG5zKSwg
cHVsc2U6IDMgKDE1IG5zKSwgaG9sZDogMiAoMTAgbnMpLCBjeWNsZTogNyAoMzUgbnMpDQo+ICAg
ICBTdGFuZGFyZCByZWFkIGlzIGFwcGxpZWQuDQo+ICAgICBUREYgb3B0aW1pemF0aW9uIGVuYWJs
ZWQNCj4gICAgIFRERiBjeWNsZXM6IDE1ICg3NSBucykNCj4gICAgIERhdGEgQnVzIFdpZHRoOiA4
LWJpdCBidXMNCj4gICAgIE5XQUlUIE1vZGU6IDANCj4gICAgIFdyaXRlIG9wZXJhdGlvbiBjb250
cm9sbGVkIGJ5IE5XRSBzaWduYWwNCj4gICAgIFJlYWQgb3BlcmF0aW9uIGNvbnRyb2xsZWQgYnkg
TlJEIHNpZ25hbA0KPg0KPiBOb3RpY2UgdGhlIHB1bHNlIHRpbWVzIGZvciByZWFkIGFyZSBvbmUg
Y2xvY2sgY3ljbGUgc21hbGxlciB0aGFuIGluIHlvdXIgb3V0cHV0LCBhbmQgdGhlIHRpbWluZ3Mg
Zm9yIHdyaXRlIGFyZSBhbHNvIGRpZmZlcmVudC4gIERvIHlvdSBoYXZlIGNoYW5nZXMgZm9yIGF0
bWVsX3NtY19uYW5kX3ByZXBhcmVfc21jY29uZigpIGFwcGxpZWQgd2hpY2ggYXJlIG5vdCB1cHN0
cmVhbSB5ZXQ/ICBPciBpcyB0aGUgSFNNQyBvbiBzYW1hN2c1NCBzb21laG93IGRpZmZlcmVudCB0
aGFuIG9uIG9sZGVyIFNvQ3M/DQo+DQo+IFllcy4gSSBmb3JjZSB0aW1pbmcgbW9kZSAyIGluIG5h
bmQtY29udHJvbGxlci5jOg0KPiArICAgICBpZiAoY29uZi0+dGltaW5ncy5zZHIudFJDX21pbiA8
IDMwMDAxKSAvLyBmb3JjZSB0aW1pbmcgbW9kZSAyLCANCj4gKyAzNW5zIGZvciByZWFkL3dyaXRl
IGN5Y2xlDQo+DQo+IFRoaXMgd2lsbCBwYXNzIHRoZSBuYW5kIHRvcnR1cmUgdGVzdCDwn5iKDQo+
DQo+IFUtQm9vdD4gbmFuZCB0b3J0dXJlIDB4ODAwMDAwIDB4MTAwMDAwMA0KPg0KPiBOQU5EIHRv
cnR1cmU6IGRldmljZSAwIG9mZnNldCAweDgwMDAwMCBzaXplIDB4MTAwMDAwMCAoYmxvY2sgc2l6
ZSANCj4gMHg0MDAwMCkNCj4gIFBhc3NlZDogNjQsIGZhaWxlZDogMA0KDQpBaCBva2F5LiAgSSBo
YXZlIGFub3RoZXIgcGF0Y2ggaGVyZSBmb3IgbWFudWFsbHkgc2V0dGluZyB0aGUgT05GSSB0aW1p
bmcgbW9kZSBmcm9tIGNvbW1hbmRsaW5lLiAgVGhpcyBpcyBwcm9iYWJseSB0b28gbGF0ZSBmb3Ig
c29tZSBzY2VuYXJpb3MsIGJ1dCBpdCBoZWxwZWQgbWUgd2hlbiB0ZXN0aW5nLiAgSWYgeW91J3Jl
IGludGVyZXN0ZWQgSSBjb3VsZCBzZW5kIGl0IHRvIHRoZSBwdWJsaWMuDQoJWWVzLiBJJ20gdmVy
eSBpbnRlcmVzdGVkICENCglNYXliZSB3ZSBzaG91bGQgYWRkIGFuIGF1dG9tYXRpYyBmYWxsYmFj
ayBmb3IgdGltaW5nIG1vZGUgaW4gbmFuZC1jb250cm9sbGVyLmMg8J+Yig0KCUFzIG9mIG5vdyB0
aGUgZHJpdmVyIGlzIGZvcmNpbmcgdFJDX21pbiB0byAzMG5zIChtb2RlIDMpLCB3aGljaCBpcyBu
b3QgcmVsaWFibGUgZm9yIHNhbWE3IG5mYyBjb250cm9sbGVyIOKYuQ0KCWh0dHBzOi8vZ2l0aHVi
LmNvbS91LWJvb3QvdS1ib290L2Jsb2IvbWFzdGVyL2RyaXZlcnMvbXRkL25hbmQvcmF3L25hbmRf
dGltaW5ncy5jI0wxNjcNCglUaGUgbmFuZCB0b3J0dXJlIGNvbW1hbmQgaGVscGVkIG1lIHRvIG1h
bnVhbGx5IGZvcmNlIHRSQ19taW4gdG8gMzVucyAobW9kZSAyKS4NCglUaGFua3MuDQoNCkdyZWV0
cw0KQWxleA0KDQo+DQo+IE5vdGU6IEknbSBjdXJyZW50bHkgdGVzdGluZyBhIHBhdGNoIGNoYW5n
aW5nIHRoZSBjb21wdXRhdGlvbiBvZiB0aGUgcmVhZCBwdWxzZSBjeWNsZXMgYmFzZWQgb24gYSBw
YXRjaCBmb3IgYXQ5MWJvb3RzdHJhcCBbMV0sIGJ1dCB0aGF0IGlzIG5vdCBhcHBsaWVkIGhlcmUg
Zm9yIHRoZSBvdXRwdXQgcXVvdGVkIGFib3ZlLg0KPg0KPiBHcmVldHMNCj4gQWxleA0KPg0KPiBb
MV0gDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eDRzYW0vYXQ5MWJvb3RzdHJhcC9pc3N1ZXMv
MTc0I2lzc3VlY29tbWVudC0xOTcNCj4gMDY5ODUyNw0KPg0KPiA+DQo+ID4gQmVzdCByZWdhcmRz
LA0KPiA+IE1paGFpIFNhaW4NCg==
