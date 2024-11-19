Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBFCD44158
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 12:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFEF389592;
	Tue, 19 Nov 2024 13:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=genexis.eu header.i=@genexis.eu header.b="S5UrVdTN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D882B89531; Tue, 19 Nov 2024 10:26:39 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20715.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::715])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7683E88FB9
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 10:26:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=markus.gothe@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBOhVq45+TlV3PKpBzQqS75dTIDhdM/PMvoF62zfGg3RYYg4neBGiWDtGsdC+0p7Hk/uPSJkGTG4ZxSCoCGBCXocjxplEmCTBS8FzpzS2XsJlQU5itrYRbyzCb5HmTdI8RuoZn46HfX0NU4YSeWdhBE8KBS1jHRKNX9kSED9zuqRFRxZOPab0EzGDKExq9aXyzBV7KqShxFEbXosJfwqd2lJeH68XdS2gjOf7ZZ7dh2R/7EqJSAZTQ7MFnoiMSoSiCJb4BDfbOR9Ykq5kFuKEaYXF1AZ6jOiYFmxhVa7gVvLvEtJIZnqqECZHmBDGhvqPeKa4b22C+z3amzu+iUdlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/EXiQFDw8cbkvtnBu258N7WiOVK9C6VSBsex6zGJ2s=;
 b=B53+K5rO819niCtiLt7XYEwqHSwK/c1S5HmcK9imNekp/xmpFMZCyxjiKJpuM9HS1yHW+a/dVNZbjOTMAWBYIHPfZ3Nesoa1Nz5DbTVJ5CjZnhiz66huYT1dOd61N3aupg9KML/TPlDx2+TOu+TFb90Snc3jj+3ywMip4371cVFjSG/8cEYG192mLehJqFVuerykqdU8me9cvKt3u4I4Q0BUWVMqlbTyv9JQZSmgZ1nd1PgSSN8n6FqotwbUyKKwOHUPyS3pLwGXYwc8XyIrZ69OVKemQC9d8IRpxWfH+ib6GL+/rtqOA0jK2LAP172dZ68YlZC9NgULxG3XqlwrUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/EXiQFDw8cbkvtnBu258N7WiOVK9C6VSBsex6zGJ2s=;
 b=S5UrVdTNOd6G97QJH1NKNtMZXdqhhsOHGgEJRD1T89KqqnsMJr4d2zkPde3kE1aH2NnyTq32Tf3EWkGhMYEYovtw+3G3pUF8ybiG3C0emK4DJmV4PUcABRnO7RsO/wQ/lPue61RsAEebcvQ0rnNtQI37yp7YvBbDgjln68J+z0I=
Received: from PAXPR08MB7320.eurprd08.prod.outlook.com (2603:10a6:102:223::18)
 by AS2PR08MB10177.eurprd08.prod.outlook.com (2603:10a6:20b:64f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 09:26:34 +0000
Received: from PAXPR08MB7320.eurprd08.prod.outlook.com
 ([fe80::d43d:9b22:dfac:df0f]) by PAXPR08MB7320.eurprd08.prod.outlook.com
 ([fe80::d43d:9b22:dfac:df0f%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 09:26:34 +0000
From: Markus Gothe <markus.gothe@genexis.eu>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH] Bitbanging MDIO driver for DM framework.
Thread-Topic: [PATCH] Bitbanging MDIO driver for DM framework.
Thread-Index: AQHbD2qhIEHd3MAJnE2y0Ih7OyQ8FLKbHiQAgCONRgA=
Date: Tue, 19 Nov 2024 09:26:34 +0000
Message-ID: <eb0c7d6e-fa93-4547-b8b4-0419a11caacd@genexis.eu>
References: <d7d1e0ca-f0cf-4458-a52d-0e8ba1b85bdb@genexis.eu>
 <20241027183150.GK4959@bill-the-cat>
In-Reply-To: <20241027183150.GK4959@bill-the-cat>
Accept-Language: en-SE, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR08MB7320:EE_|AS2PR08MB10177:EE_
x-ms-office365-filtering-correlation-id: d7ed7749-4d1c-4ad9-5431-08dd087c42cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eGI0OWh6T3MvenFCT1dqYlpjSERnK2lPNHlPcmdzM2h0Z0pxdW1IMzNIbklT?=
 =?utf-8?B?LzZpWGthdlZubTVUWUpMbjBHTlduOVVXL3FYY0dsOUdOdjFHbnpzWUo1aW8x?=
 =?utf-8?B?Y0p0SFA4OVlFNUZYOUJ1MEhZNWE2NEw5WTFtWWMvbXdUOXh6OHRxakU3ME1p?=
 =?utf-8?B?N20zKzJmVGJLd2MrSWxPemY0WVhCbjNwQTZJQlpLT0NuUG15VHNLOGlOeCtp?=
 =?utf-8?B?TnRJUzRqMUVNU3hXcmhBRkNsVlI4MUQ4UUdjSHUrOUlZMDdKREVzQXBxWS9v?=
 =?utf-8?B?OFhtMmdCQWJvZjVMTXAweXNveXJmV213REt6VnhJUzI4ZjlmZHpocCtUSjRp?=
 =?utf-8?B?TlcrK3BxOXRTMnZZdzRRcUJFQ0VOZkx3VU1rWTJqbzN2TnoxR29DMGN6bzk1?=
 =?utf-8?B?UWFQMDBCY1AxeFRyc0FOY3RXN1pzQ21zd0c4eGhSa3d2dG0zUTV0NjhSTTB6?=
 =?utf-8?B?MGw1L2Nmc080Rk9QUjhhZVhlQWRDaFQ5M2FuT0RnczkzNzZTOXdRR282cHFk?=
 =?utf-8?B?WVFZSExwSm9wdG50c2xtQjJpazJoYTlUQ1RDWEpMVko5RDg3K1VPRVBXeGNq?=
 =?utf-8?B?Z1hrbUNBUmY3ZlNCcm9lL3NrTlloK2h3dkh2VThabW9tZDIzSzNRU3NtQ2tz?=
 =?utf-8?B?ek1vNFI5aG1iU2N0SmVrUGltYVBnVVhxOVoxYkVreVhGMnNqSXZtdERWbTRm?=
 =?utf-8?B?NlhpTjN1VGcrUGJlUkRxUFFpRWJVRHhGRWZyWUdZMjc4V3lHSFlOZlk1cnR5?=
 =?utf-8?B?QWJKMWJzaFNZVEhMWGdxTGk4NWZ3SDhCQWRrYTN5ZnAxWEt6ZW9DMmo4TWpD?=
 =?utf-8?B?dWlGSWp3aUdWRndpQlRnWDhLRHFhbTFwaXBBN1QvSy8yenN5RmRMOTZPZkNP?=
 =?utf-8?B?UFRZSitMY3ZzSWJiMW54NjA0Nzc0VzY1b2VRQ05WN1VWUndCTzFjdkEza21v?=
 =?utf-8?B?VFY4SUJ5MWNmaHNyTTl4cnRjMVlTbDI4bmhtTU9CNjVhMjFtUVFTMUhKbzl4?=
 =?utf-8?B?YWVZaHk3OGJmZitsb2dUL0dveXA1b3o3d3hFcWtGY3dZTzdtYk4vUVYwNUEr?=
 =?utf-8?B?c2xOWXNFblU1VlBsTGNxeEw5U0VSM092TTdXNlVuWDF4YUdJY25RK1JYVVdl?=
 =?utf-8?B?c0Q4eFEzMTBtVGZLcXl1dkpxdXBFMjlheGVsMXo1cE9rNHRMNXY0UGo4V1FS?=
 =?utf-8?B?bys1WnV3SEwrblo1SHpsZHhFVzdleHBGc0ZlQWRTNk9wYzhOWS9ySkN5eTFr?=
 =?utf-8?B?WVdvN3p2ZC84eXZNS280L1VOSGVJdUdRRjYxUGoxbEdpWURwRXpFdkdEa3Ra?=
 =?utf-8?B?M0FlMGc3a0x1cGZvOVNxQ1NsalpBTzBTSmR4WVVDYlpPQk0vNkROTGdyS2pB?=
 =?utf-8?B?N3d0aGkzNnpoZnJmdkdIOWtMaUdqOFR1MFZIYWdOamhyaEdmaVQ0bUNjNUFE?=
 =?utf-8?B?MGx5bzdCUWVoVDd4VG1peEdteWlKVHlKcGlXNVE1Wno0L3Fab1VqMkgwVW44?=
 =?utf-8?B?d0FhL3FrQkoxVEVKWUFHVmJJUmM3NWlRei91MXFINzh4WEp4elNkY1psdisz?=
 =?utf-8?B?aVNlSnRpSmdvbVppYldwMEN0MXFFQXhrWWpGSFlnL2NnWlV4VDBBL3VvdWFD?=
 =?utf-8?B?cDU5QTA5NisvZHpac1FkUUIrWjJzemVKUnBpWi9oL1hZK0N4WnpIN3RmOGNV?=
 =?utf-8?B?ek8vZmdYOU5KTlFtTm5WdDR3WUQvTGNNNndaOGUvalBlM2g5cTdrem1RVGFq?=
 =?utf-8?B?T1IrN2d0Z2pGL1hzNmoxS1QzU0YvNmxFa3lVdlczWkFtR0RMb1k5MHN4Y0k3?=
 =?utf-8?B?K1Bwd2I5ZlFWYTY4MktUMmswbzlnUVNNS1BUUFNzZkFaN3dvUHYxaTJRRHVD?=
 =?utf-8?Q?mqzxV9RjWRTDA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB7320.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFRhenBGRWcwclF6ajN4MlFMbjJEa3FJUmpqNDZqaTB1M1dleG9jVDlHR1VH?=
 =?utf-8?B?M0JBT1NYVndEMWo0NmJpV3hVc1AwQktNK2dOSXorYXE0S1FGY042Tk5nTUIy?=
 =?utf-8?B?Y2dQOXF3bHRQQmpDK3c4OElEWkg2UWQ5SXh5cFFTa1JLVHNHL2l3eFUvMjhU?=
 =?utf-8?B?c2dRbkN3VThhSjBSaEd1ODJpSnNqQWVlNlo0WG9WNWR5T3VMOGJ6a3RaR24v?=
 =?utf-8?B?VzZadktEZzNYMXlpVDJrMmg1TEk3NVBUTW1OSkMycklOZmZ2dVRYWmE1TXNJ?=
 =?utf-8?B?TnZCOG9GMitPZkFlYWpoMWhlTmVvRGRINmlzVUQ2Sm1QK25MSnd1Mzk4eEl4?=
 =?utf-8?B?K21DL2d2aVVpWXhsRnhFRlR5NTJTRm50OS9LMEFtV2xkTnJZRHlXaTZ6cmY4?=
 =?utf-8?B?cXVad2NEZDR0MjE3QkVvWnkrYjJkR1VJbU9vcjJCeTg0SHFMR0NaMTF2dVFI?=
 =?utf-8?B?NllrL2F5dHVGQyswa3g1OXRpeTBMblkwOVN2VmZNNTdvbTEyTkxENlNXM3lU?=
 =?utf-8?B?UkhrRDcyWWlmRk45M3NyV2s0ZGlMbzZ4NDFDYnpxUnNLNnpINHpLZXk1amY4?=
 =?utf-8?B?cXpZOHNycStwclNVSFRtWmRvMFZmRTNFTk1MWHV6ZmxpYm5mazE2UXdQamFn?=
 =?utf-8?B?UVg0MnlQNTdwWm5Nd0N0QkxsOERjTTlpbDB1cU1TRnN2MmxiVW9PZVJ5YjZL?=
 =?utf-8?B?MVFKZit0ZWN1QTNIdm9HR0pKYWlxS3Qxck16dlBmYkNiQmlkeG9UcldQRUQw?=
 =?utf-8?B?dyt3WFR0UWpwcFZkMk9hbE8rYU9hN1VsZ2U3WldoMmxlelN1UTJOaU1jNXZR?=
 =?utf-8?B?ckZnSUxyU3pSR1NaNExMZVZ3N2ZGUVZhcjdnYkFVTkd6eEllY2lIWlBJeGdU?=
 =?utf-8?B?eEZWNEYySk1hKzhzalA0RmNKekMwVlBNNmJsWVpUUGxwZ0dNblo4ZU9OYUJO?=
 =?utf-8?B?SFAvNWJzVHh1OXp6YTVXWkZqR2luZjVRbnFCL0NKNnQxODFPSVpMYjNVdXFx?=
 =?utf-8?B?UVdWbk9LeDRuekVtZVlJbm1lMUpsbUJIZFVnSDUvVlVQLytyUnJSZjBEZld6?=
 =?utf-8?B?T3pVazgyQm9Bdm00Qjg3Szg0cytHTXpkRUpHUGx3amJVT0ZUbWozUU4wUlRn?=
 =?utf-8?B?cFJqalQ4Wm9QdTlRZ3NFUGkxT0h2VFBhY0FjWGJ2aTErQUo5bTNpcytjejN1?=
 =?utf-8?B?RnVJN3hxMEFVZDlpQWJoVDdzaXBMSHpGM00zS055VnpNeFlYaDJickxHazZD?=
 =?utf-8?B?MWJEamVlUkZnaTBYQkxjTUZ6VWFvU3FIVnNWcklMSDltMW1LVVc3Tk5ETDRO?=
 =?utf-8?B?cmZXdEJCZGNzdDU2Z3c4WFBSKzR5Y3FHdnBXc1ZCZEM3R0lyY0djdGh6eS9z?=
 =?utf-8?B?c2JPSGt1SjA4OFY2SmJNc1ppeUc3Q0tiMkpkVFZKZzc1bWc0UEdqdGw0VC9a?=
 =?utf-8?B?TERxdXhyT2x3N0FKMXY3bStIRmU4MVI5YWVrSUczUmZhNzQrYW45U0lzZTR2?=
 =?utf-8?B?aTNmeldUbmtaM1dZZWg5NE81VmhZbXhOQXdYRURyMUgvQVNiUnFXSjcwSS9z?=
 =?utf-8?B?ekZmZk51OXFBSHJQekJvWnd2UVdZcGlscHk1QVl6SlVmTk45c05ZcXljS3JJ?=
 =?utf-8?B?azk4OFpmSEoraUl0eWhFajNFVVVDc3RtZUx0YmkzYm5jYWxFaUhLY2llSzhL?=
 =?utf-8?B?ZE9Lb1RNKzQ3VGIwbmpmdXhwQ1VNTmJVR2NlaUt2K0pJdFJoRDI5bnB6MXB0?=
 =?utf-8?B?cWdTbEd0NE90MjFRVkxXOTRZVXBEUmRtNUdFWi9qcUVWMVFEbXJvYUtSK0Rx?=
 =?utf-8?B?Qkp1WDVQb1JqaEtiVjdXVnRzV24wMXhsUWo1UEtKVmZPSjF3djl2NC9TKzls?=
 =?utf-8?B?d3U3WXY4ZDF1QkRtaE9Nc05wdUN0Sng3NTJXYlhyQ3Z5ZU1UbGFUa2c4MFgy?=
 =?utf-8?B?UFJtN3VZNXNwZGpSRU1MREZPditZUHNjZ3BmNDhtYmpCcDB1aEpZeUpVY1Y5?=
 =?utf-8?B?ZW43cHBNM0YwOHVjbktFWGxmREhyZzhOeDNFNXpFYlZXeHpJK0ZTNXZiN2Jj?=
 =?utf-8?B?bmlpUC9xK3RKaUhXS0hOSUJkV0VhZGI0dWs2Qlp0WXM4UllhN1NZajdyMEtG?=
 =?utf-8?Q?XAGQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <96E1D1B0E4714E4B9C189AC821EA7307@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB7320.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ed7749-4d1c-4ad9-5431-08dd087c42cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 09:26:34.5442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7kUSykkBvdZpwuCzUZdU4jp4PobSyGGrBzMVDEhSyw7N1IGnuoThNEhPE2F5rYVowPTnfBtslDaN9mQtPWAQMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10177
X-Mailman-Approved-At: Tue, 19 Nov 2024 13:57:58 +0100
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

SGVsbG8sDQpwbGVhc2Ugc2VlIGh0dHBzOi8vZ2l0aHViLmNvbS91LWJvb3QvdS1ib290L3B1bGwv
Njk1DQoNCkJSLA0KTWFya3VzDQoNCk9uIDI3LzEwLzIwMjQgMTkuMzEsIFRvbSBSaW5pIHdyb3Rl
Og0KPiBPbiBXZWQsIFNlcCAyNSwgMjAyNCBhdCAwNDo0NzozOFBNICswMDAwLCBNYXJrdXMgR290
aGUgd3JvdGU6DQo+DQo+PiBMaW51eCBEVFMgY29tcGF0aWJsZSBNRElPIGJpdGJhbmdpbmcgZHJp
dmVyLg0KPj4gQm90aCBjbGF1c2UgMjIgYW5kIGNsYXVzZSA0NSBNRElPIHN1cHBvcnRlZCBhbmQg
dmFsaWRhdGVkLg0KPj4NCj4+IEhlYXZpbHkgYmFzZWQgb24gdGhlIExpbnV4IGRyaXZlcnMgKG1v
cmUgb3IgbGVzcyB0aGUgc2FtZSBjb2RlIGJhc2UpLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IE1h
cmt1cyBHb3RoZSA8bWFya3VzLmdvdGhlQGdlbmV4aXMuZXU+DQo+IFVuZm9ydHVuYXRlbHkgdGhl
IHdoaXRlc3BhY2UgaW4gdGhpcyBwYXRjaCB3YXMgdG90YWxseSBicm9rZW4gd2hlbg0KPiBwb3N0
aW5nIGFuZCBjYW5ub3QgZWFzaWx5IGJlIGFwcGxpZWQuIENhbiB5b3UgcGxlYXNlIHJldHJ5PyBU
aGFua3MuDQo+DQo=
