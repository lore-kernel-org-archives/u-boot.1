Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E09CD5BC0
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 05:19:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1639841D7;
	Mon, 25 May 2026 07:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="Rtgb8rbD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A50FB844CF; Mon, 25 May 2026 07:19:34 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D2278405A
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 07:19:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Manikandan.M@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kl6U5j2fP2g3lTcbvsR9tfJLyK3mtnCRBvv8aSF0EN12FlJScob152cOrfgfboc+7a1jCfXjknMtFItinMUjbH6IbbFJdV0DxqzjqRxPEr8yPEv4QlTnJqo7rT0jGexwIzha7Rz8XMgVsYmA4N6f1+LEfv6E0tILn758YqvQdgR9g6OiPLNuHwOOCPINv9NT3r6NeVsHPquxX2zqwUJQzBrSRQgNcbpM3wgbV/4yN2+pkIifSy4MBaGW4AA0KLZXMxYrrsJBPOkkSXUMzPgc8QjYn7m4EXUZgecidnN4C55A0UNXvuEYYrpBLfgc/DhsBQzMYQd56XMTJjL0qHMwNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmNn6gIQVUHDRY/+kRw0xcXQcnVBsMHEcfgnD9eP0TU=;
 b=dGnxMcdgG0G2IpctdEpEhGMxXrgs9BRd1l8/HlPAkPJNb/Y2XtqaxO2GDHDGFlMfzuoZnRf11NpUMU6cfcee9oNMMMjcbAJI9CGCsRd1JgLwdT6JAJZspZs6lbLbQqxYkyW8OVtJbLVx7LXmYKZvBM1OIiaRs1ksiuZfljLq1ldN2pFG4m1I7f1uWQ0/8yakaHpuIHhy/cygmCAMJa9l18Ds6LeQA83VVT8X0gNN6aGzj5b2T8pTW7HktVuwi6kxfoxEx4nPF8E1btR6HmSlvuwyr4bPgvUxRKC+CYJuurt3lCMPeu1GuMbEJWJR24GAt7kgyalvQLu5qj0htImbbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmNn6gIQVUHDRY/+kRw0xcXQcnVBsMHEcfgnD9eP0TU=;
 b=Rtgb8rbD0j+szBts2T4okb6xHAw6aJGx3oRmAagR2CqrzjF3H0IN7BRxUZnuUBT7/iLtzIsV9yem7FCuohqRqxuCKESjIq0gIiACA/LGuCHVC8YYdwvev5fyBqANSFffoLbWuKDDMXvjMBZKKXufKXKXYFl4nHnbZv4bLbNxApfCiW9FfTwE+M7aMQ2A+miEUJTPpw7jC2aWAK4VTXnWXvCIA4SlAnlmgcC5PCKsls858SJvMXd+iTr2fAxV2k43YsM4CUuuOYiM4659/dPmC1wTp7JddZaVOzY87hDrQxH6QQbyPW2O24s9c/2kKUcO9yoe2u9TIKlNKgvwyrRpZQ==
Received: from DM3PPF9623118BD.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f3a) by SA1PR11MB6758.namprd11.prod.outlook.com
 (2603:10b6:806:25d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 05:19:27 +0000
Received: from DM3PPF9623118BD.namprd11.prod.outlook.com
 ([fe80::ad98:5674:dd4c:875d]) by DM3PPF9623118BD.namprd11.prod.outlook.com
 ([fe80::ad98:5674:dd4c:875d%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 05:19:26 +0000
From: <Manikandan.M@microchip.com>
To: <peng.fan@oss.nxp.com>, <u-boot@lists.denx.de>, <BMC-SW@aspeedtech.com>,
 <joel@jms.id.au>, <uboot-snps-arc@synopsys.com>
CC: <lukma@denx.de>, <trini@konsulko.com>, <Varshini.Rajendran@microchip.com>, 
 <Balamanikandan.Gunasundar@microchip.com>, <Romain.Sioen@microchip.com>,
 <Ryan.Wanner@microchip.com>, <sjg@chromium.org>,
 <marek.vasut+usb@mailbox.org>, <clamor95@gmail.com>, <hs@nabladev.com>,
 <andrew.goodbody@linaro.org>, <me@ziyao.cc>, <patrice.chotard@foss.st.com>,
 <ryan_chen@aspeedtech.com>, <chiawei_wang@aspeedtech.com>,
 <marek.vasut+renesas@mailbox.org>, <Eugeniy.Paltsev@synopsys.com>,
 <peng.fan@nxp.com>
Subject: Re: [PATCH 1/5] clk: at91: Use dev_read_addr_ptr()
Thread-Topic: [PATCH 1/5] clk: at91: Use dev_read_addr_ptr()
Thread-Index: AQHc6+lXXN9GBW0ApUWQe1sWQ3rK2bYeNEeA
Date: Mon, 25 May 2026 05:19:26 +0000
Message-ID: <f3bbb037-0d8d-447e-9867-febf7b1a399b@microchip.com>
References: <20260525-devfdt-clk-v1-0-f0dee4083e82@nxp.com>
 <20260525-devfdt-clk-v1-1-f0dee4083e82@nxp.com>
In-Reply-To: <20260525-devfdt-clk-v1-1-f0dee4083e82@nxp.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF9623118BD:EE_|SA1PR11MB6758:EE_
x-ms-office365-filtering-correlation-id: 8257c74b-fed3-4a45-a0d6-08deba1d30a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|4143699003|18002099003|22082099003|56012099003|11063799006;
x-microsoft-antispam-message-info: 55ybCA6/WBMdaej7iwcB987Vsa/btXnLKGMacpMZYa4LNhVe6LxJH59RMxDzig+hQjWzqE2VqXwSo09liuVfkUGJIXye5Bua+diI9NjVIR2EpfYYKqWU5SHsvOR9oESFA7TmlGcWfAlVsDgZoRPpM7zBcPWIzSKnmps9X7T8J4vNqKjE/aul3eaGUTb02KR5zpl/Hwv9YxOBWh72BYghX/sY7PPfBHll8f4tXRCM8sJUNkw6Lvziqr5rlSkjWnvKAunlj/e8J+UPSxLa1AY3GZ7JoWeWBMUi3rEeC5+ctf4PsIrYKpxrxXAbeG6cMe8a2bTNrwApcYHVhwsBHNn4ff5HIg6/vfYHRiHRP5B+DuQk9SBhkSnQbXk3kMCZ1LK13MwTnumDa0PnRgVAO/IQkj2XM8Xmhmj/MXCnVB+20y+ZCtX3rIGCXnHRMW8YSBqO0GJcgChrw/b/Ewzum0mRpXSItcUrUnnLGe3RRdx8RhfRdUqBIOXwVy3nUitif2hT/gP4ZjWalYvNv0bLs5mYRXvwdu7EtdX+mR8a/qCsgGV09FmSlHRGsZF12sApzIp7TF7Bf7yXHr6YW8CZQk9L69sGgDgG4b7WlPQREvCDa9ah9pZTtggaiq7twVZQSPmSyJAsx9BQblpr6VoWrVHDBOAwqtU8qSnOe8FSAK5Rlpy2jPZ/NgBVCPbUJ4MwyBEqrCYNG+boumwJbHgPB3LsJhZla7x4jTeLPbzEA+hcWG7akV8ScJ8cHh/+BtNM/hfM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF9623118BD.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(4143699003)(18002099003)(22082099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlIwY1M4eW5hSGtuTGZ5ZkZTMFBRdFA2TW1SMnBYbkZ6ekpRUHo1YXdrMnJQ?=
 =?utf-8?B?T3pMbVdWdythMXZCZGU4dktRb2NGOUlzaU5ETTJCRjN4cmVlTjBxWnM3Qkl1?=
 =?utf-8?B?ZXE1bmh2dzUwWlUrendLZFVqL0l6d3lZTFNCVWw2Wm5wZ2J6TVVhdkRRUytw?=
 =?utf-8?B?eHB5eTlwemZ0MnBnblk1MURIYXYxZ0IwQmxKSXdEUC9zV2xVQTNYNHVWaUt5?=
 =?utf-8?B?eVdBV3BWbG9kYVJtZ0IzSHRzakMwUnhrVnBsTmJ1SXZaQjMzVExoN0ZHNDZi?=
 =?utf-8?B?WkFrSFl5MGlXRElqYm1jM2c5Wmhpdktubk0vb3FKTEJUZkNrbHFkcGhpelUv?=
 =?utf-8?B?cVZERDZrWkpVd1BYNU8xaDVFU04wajNiWUU5cXc0RHhKd3BMR1BGSFBRQ3hq?=
 =?utf-8?B?VDBOV0RzOXhjci9qYlgrWHpXU2U1ZFFEWGJJK0pZdWJnRThLNDVzOTVTYk1t?=
 =?utf-8?B?akRrK1Q0TFdGaHR2R3FFbFR2R091MkVGd2JYSXZJNC9xMjNzWWZmU1Q5aVpC?=
 =?utf-8?B?MkY4NXM5SnlBVjVVYkJ3R3BFRU96RGtIV3ArY05NUHNWUmd4a2I1VUZ2blFS?=
 =?utf-8?B?VVpWQlZONVhxWmFEKyt2bndVVFV1a0JFdG0vZTZ0REUyL1A4R1NmYmZEanFW?=
 =?utf-8?B?L25lUDNHMk1aMGduUFpJNmFQUHVoc0l4ZDdkUHNEb1ZFdEtneFhVbHlYMzNr?=
 =?utf-8?B?Z1RKREc1eXdxM005VVJyRCtQUFlJeTlCWDk4ZEFpRVBMcnlNTVZVaGd2Y1ZN?=
 =?utf-8?B?RGk5YjdwY0ZESE5NL0lwRXY0M1M3TFZXRnRYdlU4cjcwV3RpSlFWVTJaajVz?=
 =?utf-8?B?TGJkT1pQaTdteUtGQm4rUFVEaWFxNzM1SXd6Y0pkREF5QlR0R2JyRnN4WXMy?=
 =?utf-8?B?R1hlZXgzMlJ5RWV2YzBTNWZkbUVRcGpLeGRBMmVFRFVIVXNDTHFGejhZWFZF?=
 =?utf-8?B?Y3ZvMC9lNURkZjk0blRuU2pBaVpRRDlrSnoxRmQ1VEdLWXFLR0VHUmRjYmdV?=
 =?utf-8?B?SjlOMVJ3bWlVSmFGRllYVkZQcCtCMmtKdHVtMVNwRzBXM09GcWZyM1VDdUI3?=
 =?utf-8?B?QnliZGtOOVV2d2F1NU9CVU9WM21DTmQ4ZTAxWGtDRkVuQ0hEdTdRNmNwNHdi?=
 =?utf-8?B?a2JmbkdsSy83czkxMmt3YUFlaElnS3BRQmhiMUhLc09qc3YyWFRJckRYVmpX?=
 =?utf-8?B?WE93cnRoTTFxeVd6cWYzQkh3aWxVSVMwMWo0WElHcU5sVGtYNUJRcERHcHZp?=
 =?utf-8?B?aE41bkdwdGQzZjNNQ0NTVFlUK2NVci9la081M283SkxlMWZjbklaWUZkRzh6?=
 =?utf-8?B?YmRxaHY0OVMwYkNBRm5XRmVKQ1hLNThsS1NGcDlxa0pOdjVBQ0djclN2UnRM?=
 =?utf-8?B?ZmV4OXlrTmkxKzcxSXl0QWpJZFIxbkxEOEhuV0tpMUY3R2ZkZHFWc09TdE9a?=
 =?utf-8?B?ZVl5aWxPZmxoQVJmRUVlM0EvS3dENjE2L0wwZ2EwSDV0SloyR2pkSnR2bXBR?=
 =?utf-8?B?U1ppOXlieUdlMjZtdVExVFVnM0FWdGJLdXpXR0ZZVlQwV2h4VWVmYWx6ZTky?=
 =?utf-8?B?Wlc4c09uUlF0NFlmSGVXcjNWSVVtZ0ZGSUpQRFVML3U3bUdnU0V4NjJiVlFN?=
 =?utf-8?B?blVXYzNTVEgrU3VDTWlvaVJwbU5NeHhTVkNjNGxOL0tUWVJOaFNBZWJoREFH?=
 =?utf-8?B?QW8waFFvZnlHQ0FWMXUxaUsvaHFoc2o4Ly9jQlE2b01CUkY5b05yb0F5dGlu?=
 =?utf-8?B?WlQzb1lJdFNWUXJaOEwrR0lBR1c2bDhVdVRYN2tzc2d2ak9ERVFOQW9VNk9v?=
 =?utf-8?B?QjFDMUN4OGZ2SDNLbDM5K3oyL1pNR1E1bTZlRXNJYnh2OWdDMDVoNUF6eG9p?=
 =?utf-8?B?eFh0bngxM2EyU2ZEcjNJQS9hcmFPWElFLzZxc2ptOVlBeHNod0VkMk1qalFC?=
 =?utf-8?B?S0kxVlltd0Q2LzErdGs2ekl1dTR1ajdkcWFQTkdQenVtSE56NlN6b0ZFWUVl?=
 =?utf-8?B?V25PQXdJdlV5bFF3aGZRL3BFRHFRajJWdXdxcjlxeEM2SytIWEkvZjZYSnc1?=
 =?utf-8?B?ZjFtYW5uQWp1MFZVNnZoS25iYU5ubkZHN3p2aFhIeUFqc2phN21zL3M5NVA3?=
 =?utf-8?B?VXBtSjZQSDl4NGhuTm5EMmpWVzdLMFl3VEFkTFZKa05uVk52WGY3YXRjRXVW?=
 =?utf-8?B?YWpRc0tkL0tYKzYzTVMrb2J0UHBSZEVvNGN3UUhUWGdRWWtJcC9PRnhLLzJ1?=
 =?utf-8?B?VkpFb29iZ3JwRjVlYWMwY3VjT2ZKalQrbURiTUo2eGxjd3BZdlBwM3FqdENz?=
 =?utf-8?B?OVd4L0drVEhxVlFQRksrVzU3OEdDa2JoUm5PZituSS9nSWpWVEpTZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F105DE6DD823E42AC7564536AA99FEE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF9623118BD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8257c74b-fed3-4a45-a0d6-08deba1d30a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 05:19:26.5817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TzEfo/9ulF4Fs/awYQZMtbA9KtFAFcKQV4wjYl5gX6m6d/TZ9dvHiie0dBhtQCjqOOLD8IvndT+MHpPd6AvdX5ciHaLsk5UeCVB1547Aii4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6758
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

SGkgUGVuZyBGYW4sDQoNClRlc3RlZCB0aGUgcGF0Y2ggb24gc2FtOXg3NS1jdXJpb3NpdHkgYm9h
cmQNCg0KVGVzdGVkLWJ5OiBNYW5pa2FuZGFuIE11cmFsaWRoYXJhbiA8bWFuaWthbmRhbi5tQG1p
Y3JvY2hpcC5jb20+DQoNCk9uIDI1LzA1LzI2IDg6NDAgYW0sIFBlbmcgRmFuIChPU1MpIHdyb3Rl
Og0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEZyb206IFBlbmcg
RmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiANCj4gUmVwbGFjZSBkZXZmZHRfZ2V0X2FkZHJfcHRy
KCkgd2l0aCBkZXZfcmVhZF9hZGRyX3B0cigpIHdoZW4gcmV0cmlldmluZyB0aGUNCj4gcmVnaXN0
ZXIgYmFzZSBhZGRyZXNzLg0KPiANCj4gZGV2X3JlYWRfYWRkcl9wdHIoKSBzdXBwb3J0cyBib3Ro
IGxpdmUgZGV2aWNlIHRyZWUgYW5kIGZsYXQgRFQgYmFja2VuZHMsDQo+IGF2b2lkaW5nIGRpcmVj
dCBkZXBlbmRlbmN5IG9uIGRldmZkdF8qIGhlbHBlcnMuDQo+IA0KPiBObyBmdW5jdGlvbmFsIGNo
YW5nZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4N
Cj4gLS0tDQo+ICAgZHJpdmVycy9jbGsvYXQ5MS9zYW05eDYwLmMgIHwgMiArLQ0KPiAgIGRyaXZl
cnMvY2xrL2F0OTEvc2FtOXg3LmMgICB8IDIgKy0NCj4gICBkcml2ZXJzL2Nsay9hdDkxL3NhbWE3
ZDY1LmMgfCA2ICsrKy0tLQ0KPiAgIGRyaXZlcnMvY2xrL2F0OTEvc2FtYTdnNS5jICB8IDYgKysr
LS0tDQo+ICAgZHJpdmVycy9jbGsvYXQ5MS9zY2tjLmMgICAgIHwgNSArKysrLQ0KPiAgIDUgZmls
ZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2Nsay9hdDkxL3NhbTl4NjAuYyBiL2RyaXZlcnMvY2xrL2F0OTEvc2Ft
OXg2MC5jDQo+IGluZGV4IDIyNTFlMjg0NmZhLi4wZDBlMzlkYjU3ZSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9jbGsvYXQ5MS9zYW05eDYwLmMNCj4gKysrIGIvZHJpdmVycy9jbGsvYXQ5MS9zYW05
eDYwLmMNCj4gQEAgLTQyNiw3ICs0MjYsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBtY19jbGtf
c2V0dXAgc2FtOXg2MF9jbGtfc2V0dXBbXSA9IHsNCj4gDQo+ICAgc3RhdGljIGludCBzYW05eDYw
X2Nsa19wcm9iZShzdHJ1Y3QgdWRldmljZSAqZGV2KQ0KPiAgIHsNCj4gLSAgICAgICB2b2lkIF9f
aW9tZW0gKmJhc2UgPSAodm9pZCAqKWRldmZkdF9nZXRfYWRkcl9wdHIoZGV2KTsNCj4gKyAgICAg
ICB2b2lkIF9faW9tZW0gKmJhc2UgPSBkZXZfcmVhZF9hZGRyX3B0cihkZXYpOw0KPiAgICAgICAg
ICB1bnNpZ25lZCBpbnQgKmNsa211eGFsbG9jc1s2NF0sICptdXhhbGxvY3NbNjRdOw0KPiAgICAg
ICAgICBjb25zdCBjaGFyICpwWzEwXTsNCj4gICAgICAgICAgdW5zaWduZWQgaW50IGNtWzEwXSwg
bVsxMF0sICp0bXBjbGttdXgsICp0bXBtdXg7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9h
dDkxL3NhbTl4Ny5jIGIvZHJpdmVycy9jbGsvYXQ5MS9zYW05eDcuYw0KPiBpbmRleCA5ZWEyNTNl
NmZmOC4uOTNmODk5YjY2MTcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL2F0OTEvc2FtOXg3
LmMNCj4gKysrIGIvZHJpdmVycy9jbGsvYXQ5MS9zYW05eDcuYw0KPiBAQCAtODE3LDcgKzgxNyw3
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgew0KPiANCj4gICBzdGF0aWMgaW50IHNhbTl4N19jbGtf
cHJvYmUoc3RydWN0IHVkZXZpY2UgKmRldikNCj4gICB7DQo+IC0gICAgICAgdm9pZCBfX2lvbWVt
ICpiYXNlID0gKHZvaWQgKilkZXZmZHRfZ2V0X2FkZHJfcHRyKGRldik7DQo+ICsgICAgICAgdm9p
ZCBfX2lvbWVtICpiYXNlID0gZGV2X3JlYWRfYWRkcl9wdHIoZGV2KTsNCj4gICAgICAgICAgdW5z
aWduZWQgaW50ICpjbGttdXhhbGxvY3NbNjRdLCAqbXV4YWxsb2NzWzY0XTsNCj4gICAgICAgICAg
Y29uc3QgY2hhciAqcFsxMF07DQo+ICAgICAgICAgIHVuc2lnbmVkIGludCBjbVsxMF0sIG1bMTBd
LCAqdG1wY2xrbXV4LCAqdG1wbXV4Ow0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvYXQ5MS9z
YW1hN2Q2NS5jIGIvZHJpdmVycy9jbGsvYXQ5MS9zYW1hN2Q2NS5jDQo+IGluZGV4IDlmMGIzOTQ1
NDNiLi4wYzE3YThjZjY3YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbGsvYXQ5MS9zYW1hN2Q2
NS5jDQo+ICsrKyBiL2RyaXZlcnMvY2xrL2F0OTEvc2FtYTdkNjUuYw0KPiBAQCAtMTE3Niw3ICsx
MTc2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwbWNfY2xrX3NldHVwIHNhbWE3ZDY1X2Nsa19z
ZXR1cFtdID0gew0KPiANCj4gICBzdGF0aWMgaW50IHNhbWE3ZDY1X2Nsa19wcm9iZShzdHJ1Y3Qg
dWRldmljZSAqZGV2KQ0KPiAgIHsNCj4gLSAgICAgICB2b2lkIF9faW9tZW0gKmJhc2UgPSAodm9p
ZCAqKWRldmZkdF9nZXRfYWRkcihkZXYpOw0KPiArICAgICAgIHZvaWQgX19pb21lbSAqYmFzZSA9
IGRldl9yZWFkX2FkZHJfcHRyKGRldik7DQo+ICAgICAgICAgIHVuc2lnbmVkIGludCAqY2xrbXV4
YWxsb2NzW1NBTUE3RDY1X01BWF9NVVhfQUxMT0NTXTsNCj4gICAgICAgICAgdW5zaWduZWQgaW50
ICptdXhhbGxvY3NbU0FNQTdENjVfTUFYX01VWF9BTExPQ1NdOw0KPiAgICAgICAgICBjb25zdCBj
aGFyICpwWzEyXTsNCj4gQEAgLTExODUsOCArMTE4NSw4IEBAIHN0YXRpYyBpbnQgc2FtYTdkNjVf
Y2xrX3Byb2JlKHN0cnVjdCB1ZGV2aWNlICpkZXYpDQo+ICAgICAgICAgIGJvb2wgbWFpbl9vc2Nf
YnlwYXNzOw0KPiAgICAgICAgICBpbnQgcmV0LCBtdXhhbGxvY2luZGV4ID0gMCwgY2xrbXV4YWxs
b2NpbmRleCA9IDAsIGksIGo7DQo+IA0KPiAtICAgICAgIGlmIChJU19FUlIoYmFzZSkpDQo+IC0g
ICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihiYXNlKTsNCj4gKyAgICAgICBpZiAoIWJhc2Up
DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gDQo+ICAgICAgICAgIG1lbXNl
dChtdXhhbGxvY3MsICAgIDAsIEFSUkFZX1NJWkUobXV4YWxsb2NzKSk7DQo+ICAgICAgICAgIG1l
bXNldChjbGttdXhhbGxvY3MsIDAsIEFSUkFZX1NJWkUoY2xrbXV4YWxsb2NzKSk7DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2Nsay9hdDkxL3NhbWE3ZzUuYyBiL2RyaXZlcnMvY2xrL2F0OTEvc2Ft
YTdnNS5jDQo+IGluZGV4IGYyNGQyNTE4NTdmLi5jNDM2MDM4YWVkMiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9jbGsvYXQ5MS9zYW1hN2c1LmMNCj4gKysrIGIvZHJpdmVycy9jbGsvYXQ5MS9zYW1h
N2c1LmMNCj4gQEAgLTExMDksNyArMTEwOSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcG1jX2Ns
a19zZXR1cCBzYW1hN2c1X2Nsa19zZXR1cFtdID0gew0KPiANCj4gICBzdGF0aWMgaW50IHNhbWE3
ZzVfY2xrX3Byb2JlKHN0cnVjdCB1ZGV2aWNlICpkZXYpDQo+ICAgew0KPiAtICAgICAgIHZvaWQg
X19pb21lbSAqYmFzZSA9IGRldmZkdF9nZXRfYWRkcl9wdHIoZGV2KTsNCj4gKyAgICAgICB2b2lk
IF9faW9tZW0gKmJhc2UgPSBkZXZfcmVhZF9hZGRyX3B0cihkZXYpOw0KPiAgICAgICAgICB1bnNp
Z25lZCBpbnQgKmNsa211eGFsbG9jc1tTQU1BN0c1X01BWF9NVVhfQUxMT0NTXTsNCj4gICAgICAg
ICAgdW5zaWduZWQgaW50ICptdXhhbGxvY3NbU0FNQTdHNV9NQVhfTVVYX0FMTE9DU107DQo+ICAg
ICAgICAgIGNvbnN0IGNoYXIgKnBbMTBdOw0KPiBAQCAtMTExOCw4ICsxMTE4LDggQEAgc3RhdGlj
IGludCBzYW1hN2c1X2Nsa19wcm9iZShzdHJ1Y3QgdWRldmljZSAqZGV2KQ0KPiAgICAgICAgICBi
b29sIG1haW5fb3NjX2J5cGFzczsNCj4gICAgICAgICAgaW50IHJldCwgbXV4YWxsb2NpbmRleCA9
IDAsIGNsa211eGFsbG9jaW5kZXggPSAwLCBpLCBqOw0KPiANCj4gLSAgICAgICBpZiAoSVNfRVJS
KGJhc2UpKQ0KPiAtICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoYmFzZSk7DQo+ICsgICAg
ICAgaWYgKCFiYXNlKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiAg
ICAgICAgICBtZW1zZXQobXV4YWxsb2NzLCAgICAwLCBzaXplb2YobXV4YWxsb2NzKSk7DQo+ICAg
ICAgICAgIG1lbXNldChjbGttdXhhbGxvY3MsIDAsIHNpemVvZihjbGttdXhhbGxvY3MpKTsNCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2F0OTEvc2NrYy5jIGIvZHJpdmVycy9jbGsvYXQ5MS9z
Y2tjLmMNCj4gaW5kZXggZGNhZmZkMzYwZmQuLjQxMGJjMDg4MjQ4IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2Nsay9hdDkxL3Nja2MuYw0KPiArKysgYi9kcml2ZXJzL2Nsay9hdDkxL3Nja2MuYw0K
PiBAQCAtMTI0LDEyICsxMjQsMTUgQEAgVV9CT09UX0RSSVZFUihhdDkxX3NhbTl4NjBfdGRfc2xj
aykgPSB7DQo+ICAgc3RhdGljIGludCBhdDkxX3NhbTl4NjBfc2NrY19wcm9iZShzdHJ1Y3QgdWRl
dmljZSAqZGV2KQ0KPiAgIHsNCj4gICAgICAgICAgc3RydWN0IHNhbTl4NjBfc2NrYyAqc2NrYyA9
IGRldl9nZXRfcHJpdihkZXYpOw0KPiAtICAgICAgIHZvaWQgX19pb21lbSAqYmFzZSA9IGRldmZk
dF9nZXRfYWRkcl9wdHIoZGV2KTsNCj4gKyAgICAgICB2b2lkIF9faW9tZW0gKmJhc2UgPSBkZXZf
cmVhZF9hZGRyX3B0cihkZXYpOw0KPiAgICAgICAgICBjb25zdCBjaGFyICpzbG93X3JjX29zYywg
KnNsb3dfb3NjOw0KPiAgICAgICAgICBjb25zdCBjaGFyICpwYXJlbnRzWzJdOw0KPiAgICAgICAg
ICBzdHJ1Y3QgY2xrICpjbGssIGM7DQo+ICAgICAgICAgIGludCByZXQ7DQo+IA0KPiArICAgICAg
IGlmICghYmFzZSkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiArDQo+ICAg
ICAgICAgIHJldCA9IGNsa19nZXRfYnlfaW5kZXgoZGV2LCAwLCAmYyk7DQo+ICAgICAgICAgIGlm
IChyZXQpDQo+ICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gDQo+IC0tDQo+IDIuNTEu
MA0KPiANCg0KLS0gDQpUaGFua3MgYW5kIFJlZ2FyZHMsDQpNYW5pa2FuZGFuIE0uDQoNCg==
