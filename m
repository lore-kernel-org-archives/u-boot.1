Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C5DCD3424
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 04:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E34318488B;
	Wed,  6 May 2026 06:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="nOqfSzsz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E2548497A; Wed,  6 May 2026 05:22:38 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5453E84915
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 05:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tze.yee.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xprn0kfdVVEKIMTD+BDA+d9IIwpMdv97NQlNzJythUgwE6HnmUb+B+wmYjyQYExacQlq2eUOQ/aFEkLpHdyL5NS5l6UNS2Nn0u9vuGquPnA3JFvx7tzsUR6VzRghj4uJcoamOfaJJvxYWIG8nYrwoCoufJ4sx4tpmk8vYzQS/k5iEbMSyq5T2H9k9S8uoW4H4/YUe4qxJ3PzRQcujQaxTm7VBscWZiBCfkLiAmWu2FmDZZQxvQmO5vo30SdEHbDUnUvHnrt+bpFByTAoQNyE9WNZ5+Z5YrpapLnoID5qqND+GjevLEQdk5BHHlgusOsfwHHW/OpPR5nRFl5BIdtx9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XM8ZS6JuwjLhku6EL1mCG++af32WquEWDr/x4Og4h9Q=;
 b=wOMYJKgblZwPzeOUoVEr+ILlILvlaxaz1yaZgHorv2Hr9NTuXdNU+/FTKuaHQaFSC0gp5BkkD+L2zRg54spFOOvfgs5LzTf6flX3N7xvuh2UFEySFEi/xXn2BEkedpQDWvHFNYldwDJGU/8jCU6cz6VeY4kzOHudc6N77qpFqNKxUxwqAFbh6zgM8h5ZQgDdPBWLRBYSBjSj0DQhC3MPq40qh8/SjJH5Z/F9xHyjMsRTD5u9jPRmROR6iq1mLrOmL9it3jWeD/nIvdZb84XMUgHIamdpILs087bsjX8nrRc7LpR57Ycx93U9cZpqF2aGWRGkvwdgBJ/mWa4zC7PhMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XM8ZS6JuwjLhku6EL1mCG++af32WquEWDr/x4Og4h9Q=;
 b=nOqfSzszvCHWbuB6xHXgh3BHRuu2PbZUhViVPYkysnFwkdpPvJfzRtpLtKnptSW7BU0j2YcjPCcO5JFR4psHH+I7tWpD+H8w8Mxn+DA+F8QlE8isEjbQ5I9Wi6GSvSNLpMWwin486CLaONv2Gb8z+MD2PPcrZ/+cIOeYtTVw93skkiIQwY47tw/3UvnBFOX5hCp/H7UgM3JOvNgDgnjIwCHD1DaLW4HdZw24adbf2IIkPgIO+E8mJyezR8SlejoeVm9ej3GvaUKrKXhqe0yFH3hUFO4lpy7CK8RF+s8FaF+2+NYOe9Ng7KzBHeI+FusqHrhy36tZ6du8GY/3atd+5A==
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SJ0PR03MB7025.namprd03.prod.outlook.com (2603:10b6:a03:4e0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 03:22:32 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 03:22:31 +0000
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, Peng Fan
 <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, "MANIYAM, DINESH"
 <dinesh.maniyam@altera.com>, "LOK, CHEN HUEI" <chen.huei.lok@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, "YUSLAIMI, ALIF ZAKUAN"
 <alif.zakuan.yuslaimi@altera.com>, "NG, BOON KHAI" <boon.khai.ng@altera.com>
Subject: Re: [PATCH v2 2/2] arm: dts: socfpga: Enable 8-bit embedded device
 support in Agilex5 eMMC device tree
Thread-Topic: [PATCH v2 2/2] arm: dts: socfpga: Enable 8-bit embedded device
 support in Agilex5 eMMC device tree
Thread-Index: AQHc1ro1zOqk6uhEI0+KTRV3j9dNPLX+134AgAGKMoA=
Date: Wed, 6 May 2026 03:22:31 +0000
Message-ID: <68d195c4-61f3-4d93-a1d8-1ca3e906e98f@altera.com>
References: <cover.1777344421.git.tze.yee.ng@altera.com>
 <aa3bb421d60965e147f201d1739830b42ccd7124.1777344421.git.tze.yee.ng@altera.com>
 <cf24618c-2913-4bbe-868f-ea543077fe78@altera.com>
In-Reply-To: <cf24618c-2913-4bbe-868f-ea543077fe78@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5950:EE_|SJ0PR03MB7025:EE_
x-ms-office365-filtering-correlation-id: 40320e09-8e3f-4e0a-3185-08deab1eb5ad
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|55112099003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: fbVTyq0vTq8RRDegqQJfBbE1v/xSXAZ2JzPRJwudhjitYY5E4KUpJa7RDepNisNJxg8+9zi+6tQl8XOPeU3qMRBE1vaVpCsJPob3kDRt847gUlwhEOY3BTWN7qTI3XaYUIZy4rXPJtggnCnUF5kG8q9dBO+oI4BTG5u5/q2WE0xnOSYcMF73EKzezwyHJjIca/oaa+1Al5L5OWHSbj4yeoIyO6voD0V3foJViUiuhkNhP/P/YGMIQnVr/vR5ggnYkc5v0R9H+sTX+WEa53LWbYpecTF20gxavJS0EOUJPa+So+QplL7b8gF2SbBtcT0ZCVjDlbpzdM7yIKxF++FBmiYnkjOvCK0Wu5f34BQeoIaOcK0mAkQN239kSR4fXCXGeLWMopt/BpPw/oKGxHccUXYdC4AvVa+8plEZsT34ATXwOfsLC5iUus4/2nJhrTceGUHfzQ7EpBCXSjXZ7viNu1kBDgoW+4m67ADGWoIEwdawIM2lt9sflco9C3WjoEWz5g54vHeqh0D+YPmhTwnTu3qbmf9+rKraEv2lFVL9JVr8hjGj0Wr4YEmYrQLWUMtGoP1cWQ4Sqe2meNxJIGOhXJCk65y+QrA9Qq1+8cNRef5e9KC/0Ll/6nJgBeAKso5iAJoWfe2M3aeWC0azmtFtOQppRUKhD6I4BXjOlIacprbv8bfmJqG17gZP2nKZI3N7JRDb+ZfXYeJgVTD0TVX+I7gnDAKz7KRQFU0mYKtqNOZiY9AQE6EGLDE4Rd9UMwlU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(55112099003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXFqd0lSTjJNajhhRnAzMlIyaUsrU3hsZi81aEhSTVRRMldmOVNSRVU0c3NQ?=
 =?utf-8?B?cW1BZ1BJU0tkOVA4Q3hSQktpdFlLT1FLL1VOR29tenFCV2VhN0JTS2drNDRB?=
 =?utf-8?B?MmJtcHJPckFCTnc4Y0FyT2ptRUdnWkIvN0NWQWtaalhtaE14L1VZekhPa1hI?=
 =?utf-8?B?NGxkQktQVWtmNlgzV2swVWJ0dW9HTEtZWTJ4SE5taDVIRVVDWnFCeEdIbm1j?=
 =?utf-8?B?dWsxTlpXQTl3TWJMQ0NaYUlzZmFGRDdwNzlrakNVbzMzYW5ocWlBQVFHM0FO?=
 =?utf-8?B?Q2VTdE5wMkIxdXZsR2h4dXZxeVFyM1YwOVlMYU1xOXNaZk1hNUxmeFdQblI0?=
 =?utf-8?B?L0VuS0ZGZXdQdzVVTUYwNzVXZmlSREQxUzVkN3RCQTFSUTBtNVQ5YitiUm10?=
 =?utf-8?B?amZVUTIzTzE4RTIzdHRyVVlQd21INzJyTER3TUtWaElkdStGTmNIckhvWTdh?=
 =?utf-8?B?bHJLcWhCU0x4S3lNZFJyZ2p2RHF0b0dZeEFpRW0wZ3VVSWsySEJlUW4wVnNV?=
 =?utf-8?B?cGxTb3FPN1RBNFBFb1dMSVRNUE9DZFZUNUI3M1dXQ2ZtR3dXWTFRNnkvbzht?=
 =?utf-8?B?d0o1ZmtWaWJiTTFlOTRYTkpmdFBPQ0xCd21sWEROc0lBM0p4WFJDUSs0NXJN?=
 =?utf-8?B?TFhKSkZWR0VzRXo4eWI0ejZReWUvMTRES1NraVZieHV2ZmUwQWVYemhxWXU2?=
 =?utf-8?B?ZGVNSVYwMEUwVnNkcytxYmFDRVZWQ2RUWStjZDlQODk3dmZDUW5JV3UvbnQy?=
 =?utf-8?B?TERURjZLR0IwOG9IZVZtbDBvY3p6bm5zTFMzUTZDYURzNEdYeWxtWmtWK3Rn?=
 =?utf-8?B?TXBxY0YxNzBRS1h4UW80Nkw5T1BONmRPMDVoVUhHaTNDNjBQKzNPeUlCam1M?=
 =?utf-8?B?R2tuNWFIallrK1pFdEpqVks0ZmwrWmsvdys3UE01T3R3N0lZa3l0MFprS1Fk?=
 =?utf-8?B?VW1BcW43QU92MEpMM2h3RTBTUlFIY2QyYmw5WVF6K1l5WUpzWXpXUnkyVUVC?=
 =?utf-8?B?YVIzaithZlZtZ2c2SzZIck5lVC9maVBjZm1RV1ArKzVpTGpza2ZXRWIzVkJV?=
 =?utf-8?B?SEZFWk9CV1ZlZ2ZzbXU2dFBjeksyYVJyRGpIR2lUZzMrdSt6VmZtRFlTT04w?=
 =?utf-8?B?bHorVFpJUWhkMXhYSzlPdWxVY1ZTSEI4czJRWXFPM1pUUEZlNXlzZGx0UCs1?=
 =?utf-8?B?eWxqcE5SM0R0L2pQR0pMb0pkTWdUaERETzJoQ0FxMUlDRExVWGtlYUd4K3Fo?=
 =?utf-8?B?WFRNd2JBNFN1T3A0bnRrMURaTTArTXRqcHlUMFZXaGF5VjNHSlhnUTc2b0dW?=
 =?utf-8?B?K0hyT040TzBhSEJROEJncTVFcTA4Rzk4TFRMdkpuYnFUVHFxSUhnVVlmVklv?=
 =?utf-8?B?VHc4TXEwUkFLUnFLQlBEZGJBQVpaVWdLMzlrOXdEOS9NT2xEN242NFl1WWtn?=
 =?utf-8?B?VzVCTmhvOTdRNEJrQnc3N1RQMmZVa0Jqd2lNU0o1b2FTY3NpVUZCZGQ5OFBa?=
 =?utf-8?B?NVNtei9uSEVsQUQyMkF2Y3BaWjJ2b3ZCZHAvSHYrcEJrZmpvQlljekdzSVQy?=
 =?utf-8?B?Vll6U1RCNVROb0hOa0FlOVVPNXI2M21vay94ZWZmSThmMlZMZnNsK2FCVTFO?=
 =?utf-8?B?VzZwSTJuUWNLNTNmdkZKeFB3WjMvUEJmQ1JkZlR4VzlOazdWRGMrSWE0RkVy?=
 =?utf-8?B?aTl5TzgzSHFwTVRrc2hYT3pnQnFZMUNtVi9UNmJVQTBlT2djTDJEamlMVHZ6?=
 =?utf-8?B?eVRLVVhLdzJvR2x3UWg4dm1ScnpDS1krRWtoUTB3Nk9iaFhpM3FyNDNYY2Rp?=
 =?utf-8?B?TDRMWUF1U0JCK0ZxcC8xNUgxc28wZXB1NTlDdEJvamhCazh5ZFFOeFl6MEJ6?=
 =?utf-8?B?U1JkNndBdXVxYy9YQyt4TXBEQ1YrOEJzMlhTOTY1VWNVenZnT3JjQkhwaWdK?=
 =?utf-8?B?cjUyNTM1enI4c1VSUXNhcW0rZkhoa0sxNllLUmZEMVhSNzZ6MHpRQXNMNmIz?=
 =?utf-8?B?Z21xSDV5R1BUVUlTY2x4bkZmajZPTms1NzhWeUhRTCtvVFR0REw4ZE5nS0M0?=
 =?utf-8?B?b3l5dnNWcVBDaWtVOGdVOGU1aWJxTGQyaW8yNm45aWRoMVNTcGtna2hpc2c3?=
 =?utf-8?B?SkFSaTJPNXY2K1pKY21FbSs4bmZEaXl3R0FzZkU2a3F5WGg1aXF5TXRLeW4y?=
 =?utf-8?B?SjJ3dnErbndjQVBwdlFQNHZYd3ZvODdCWnI4ODVvSzAwRXltL090NG9FaHNl?=
 =?utf-8?B?elV1UnNiZld3TEdSdU9sRlZHbWlNM1N4alRPdU9CRTQ3RUw5M1dSU2Y2ajhF?=
 =?utf-8?B?NEt4QWV0MmE5cm53cVZNMnRKTGo5TzNjYnZONkdqSjFSUXBpS0JLc05qUGla?=
 =?utf-8?Q?csbrmNjkpWAVc8Xw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2160F70B1471AD4A8FBBB9B04296BC4B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40320e09-8e3f-4e0a-3185-08deab1eb5ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 03:22:31.8236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qlgaA7yr650niNwHkHbmg3pMVX1C1YuO6Y8MYLWG/PZZOEX9rwhmMSL7NyKlJGclTEo/+5E/FgneNV4QOVJnCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB7025
X-Mailman-Approved-At: Wed, 06 May 2026 06:52:22 +0200
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

T24gNS81LzIwMjYgMTE6NTEgYW0sIENoZWUsIFRpZW4gRm9uZyB3cm90ZToNCj4gSGkgVHplIFll
ZSwNCj4gDQo+IA0KPiBPbiAyOC80LzIwMjYgMTA6NTMgYW0sIHR6ZS55ZWUubmdAYWx0ZXJhLmNv
bSB3cm90ZToNCj4+IEZyb206IHR6ZXllZW5nIDx0emV5ZWUubmdAYWx0ZXJhLmNvbT4NCj4+DQo+
PiBUaGUgZU1NQyBkZXZpY2UgdHJlZSBpbmhlcml0cyB0aGUgY29uZmlndXJhdGlvbiBmcm9tDQo+
PiBzb2NmcGdhX2FnaWxleDVfc29jZGsuZHRzLg0KPj4NCj4+IENoYW5nZXM6DQo+PiAtIFNldCBT
REhDSSBDYXBhYmlsaXRpZXMgYml0MTggdG8gZW5hYmxlIDgtYml0IGVtYmVkZGVkIGRldmljZSBz
dXBwb3J0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IHR6ZXllZW5nIDx0emV5ZWUubmdAYWx0ZXJh
LmNvbT4NCj4+DQo+PiAtLS0NCj4+IENoYW5nZXMgaW4gdjI6DQo+PiAtIFJlbW92ZSAvZGVsZXRl
LXByb3BlcnR5LyBzZC11aHMtc2RyNTAgYW5kIC9kZWxldGUtcHJvcGVydHkvDQo+PiDCoMKgIHNk
LXVocy1zZHIxMDQgZnJvbSBtbWMgbm9kZQ0KPj4gLSBGaXggd29yZGluZyBpbiBjb21taXQgbWVz
c2FnZQ0KPj4gLSBVcGRhdGUgY29tbWl0IHRpdGxlDQo+PiAtLS0NCj4+IMKgIGFyY2gvYXJtL2R0
cy9zb2NmcGdhX2FnaWxleDVfc29jZGtfZW1tYy5kdHMgfCA1ICsrLS0tDQo+PiDCoCAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybS9kdHMvc29jZnBnYV9hZ2lsZXg1X3NvY2RrX2VtbWMuZHRzIGIvYXJjaC9h
cm0vIA0KPj4gZHRzL3NvY2ZwZ2FfYWdpbGV4NV9zb2Nka19lbW1jLmR0cw0KPj4gaW5kZXggOTJm
ZjhiNGFjZjIuLjUyYWE5MmU0MjkyIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm0vZHRzL3NvY2Zw
Z2FfYWdpbGV4NV9zb2Nka19lbW1jLmR0cw0KPj4gKysrIGIvYXJjaC9hcm0vZHRzL3NvY2ZwZ2Ff
YWdpbGV4NV9zb2Nka19lbW1jLmR0cw0KPj4gQEAgLTE4LDcgKzE4LDYgQEANCj4+IMKgIH07DQo+
PiDCoCAmbW1jIHsNCj4+IC3CoMKgwqAgL2RlbGV0ZS1wcm9wZXJ0eS8gc2QtdWhzLXNkcjEwNDsN
Cj4gDQo+IA0KPiBJIGhhdmUgYSBjb25jZXJuIHJlZ2FyZGluZyB0aGUgdjIgcGF0Y2ggc2VyaWVz
IHRoYXQgSSB3b3VsZCBsaWtlIHlvdSB0byANCj4gdmVyaWZ5Lg0KPiANCj4gSW4gdjIsIHBhdGNo
IDEvMiBtb3ZlcyBzZC11aHMtc2RyNTAgYW5kIHNkLXVocy1zZHIxMDQgZnJvbSANCj4gc29jZnBn
YV9hZ2lsZXg1X3NvY2RrLXUtYm9vdC5kdHNpIGludG8gc29jZnBnYV9hZ2lsZXg1X3NvY2RrLmR0
cyBhcyBhIA0KPiBuZXcgJm1tYyBub2RlLg0KPiANCj4gU2luY2Ugc29jZnBnYV9hZ2lsZXg1X3Nv
Y2RrX2VtbWMuZHRzIHVzZXMgI2luY2x1ZGUgDQo+ICJzb2NmcGdhX2FnaWxleDVfc29jZGsuZHRz
IiBhcyBhIEMgcHJlcHJvY2Vzc29yIHBhc3RlLA0KPiANCj4gdGhlc2UgU0QgVUhTIHByb3BlcnRp
ZXMgd291bGQgYmUgY29tcGlsZWQgaW50byB0aGUgZU1NQyBEVCwgd2hpY2ggaXMgDQo+IGluY29y
cmVjdC4NCj4gDQo+IEluIHYxLCB0aG9zZSBwcm9wZXJ0aWVzIGxpdmVkIG9ubHkgaW4gdGhlIGR0
c2ksIHdoaWNoIGlzIG5vdCBhcHBsaWVkIHRvIA0KPiB0aGUgZU1NQyBidWlsZCBzaW5jZSB0aGUg
ZU1NQyBidWlsZCB1c2VzIGl0cyBvd24gc2VwYXJhdGUgDQo+IHNvY2ZwZ2FfYWdpbGV4NV9zb2Nk
a19lbW1jLXUtYm9vdC5kdHNpLg0KPiANCj4gVGhpcyBtZWFucyB0aGUgZU1NQyBjb21waWxlZCBE
VCB3YXMgY2xlYW4gaW4gdjEuDQo+IA0KPiBUbyB2ZXJpZnkgdGhpcywgcGxlYXNlIHBlcmZvcm0g
dGhlIGZvbGxvd2luZyB0ZXN0Og0KPiANCj4gMS4gUmV2ZXJ0IHNvY2ZwZ2FfYWdpbGV4NV9zb2Nk
a19lbW1jLmR0cyBiYWNrIHRvIGl0cyB2MSBzdGF0ZS4NCj4gDQo+IDIuIFJlbW92ZSB0aGUgL2Rl
bGV0ZS1wcm9wZXJ0eS8gbGluZXMgZm9yIGJvdGggc2QtdWhzLXNkcjUwIGFuZCBzZC11aHMtIA0K
PiBzZHIxMDQgZnJvbSBzb2NmcGdhX2FnaWxleDVfc29jZGtfZW1tYy5kdHMuDQo+IA0KPiAzLiBC
dWlsZCB0aGUgZU1NQyBEVCBhbmQgaW5zcGVjdCB0aGUgY29tcGlsZWQgLmR0YiAoZS5nLiB2aWEg
ZHRjIC1JIGR0YiANCj4gLU8gZHRzKS4NCj4gDQo+IDQuIENvbmZpcm0gd2hldGhlciBzZC11aHMt
c2RyNTAgYW5kIHNkLXVocy1zZHIxMDQgYXJlIGFic2VudCBmcm9tIHRoZSANCj4gZU1NQyBjb21w
aWxlZCBEVC4NCj4gDQo+IElmIHRoZXkgYXJlIGFic2VudCwgaXQgY29uZmlybXMgdGhhdCB0aGUg
L2RlbGV0ZS1wcm9wZXJ0eS8gbGluZXMgaW4gdGhlIA0KPiBlTU1DIERUUyB3ZXJlIGFsd2F5cyBu
by1vcHMuDQo+IA0KPiBJbiB0aGF0IGNhc2UsIHRoZSBjb3JyZWN0IGZpeCBpcyBzaW1wbHkgdG8g
cmVtb3ZlIHRob3NlIG5vLW9wIC9kZWxldGUtIA0KPiBwcm9wZXJ0eS8gbGluZXMgdGhhdCB3ZXJl
IGludHJvZHVjZWQgaW4gdjEgcGF0Y2ggMi8yLA0KPiANCj4gd2l0aG91dCBtb3ZpbmcgYW55IHBy
b3BlcnRpZXMgb3V0IG9mIHRoZSBkdHNpIGludG8gdGhlIGJhc2UgRFRTLg0KPiANCj4gDQo+IEJl
c3QgcmVnYXJkcywNCj4gDQo+IFRpZW4gRm9uZw0KPiANCkhpIFRpZW4gRm9uZywNCg0KVGhhbmtz
IGZvciB0aGUgZGV0YWlsZWQgZ3VpZGFuY2UuDQoNCkkgZm9sbG93ZWQgeW91ciBzdWdnZXN0ZWQg
dmVyaWZpY2F0aW9uIHN0ZXBzIHRvIHJldmVydCBldmVyeXRoaW5nIGFuZCANCnRoZSBTRCBVSFMg
cHJvcGVydGllcyB3ZXJlIGFic2VudCBmcm9tIGVNTUMgY29tcGlsZWQgRFQsIGNvbmZpcm1pbmcg
dGhhdCANCnRoZSAvZGVsZXRlLXByb3BlcnR5LyBsaW5lcyB3ZXJlIGluZGVlZCBuby1vcHMuIEFj
Y29yZGluZ2x5LCBJ4oCZdmUgDQpkcm9wcGVkIHBhdGNoIDEgZnJvbSB2MiBhbmQgc3VibWl0dGVk
IHYzIHdpdGggb25seSB0aGUgcmVtb3ZhbCBvZiB0aGUNCi9kZWxldGUtcHJvcGVydHkvIFNEUiBw
cm9wZXJ0aWVzLCB3aXRob3V0IG1vdmluZyBhbnkgcHJvcGVydGllcyBmcm9tIHRoZSANCmR0c2kg
aW50byB0aGUgYmFzZSBEVFMuDQoNCkFwcHJlY2lhdGUgeW91ciByZXZpZXcgYW5kIHRoZSBjbGFy
aWZpY2F0aW9uLg0KDQpCZXN0IHJlZ2FyZHMsDQpUemUgWWVlDQo=
