Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16821CD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 05:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A0238056B;
	Thu, 21 May 2026 07:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WrFtyL/V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F24C846E7; Wed, 20 May 2026 23:52:19 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 428898467A
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 23:52:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=k-scholz@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bG7bgLKh90Yydx1HNnPx1lJO+KQHhCtUo/ygG4BXPRaixcfvBiH7uzf2MxOa2pHH1btvTHTKSB0ItIyrr5qL/7qcHEXn2vIC5JJKIdit8zdCc+x/AZ95b6FbaHPXwDZOc1B8SjLPjiQAcwf1md4UPmktDwxtQ2NoG/VZh9stlXrT8dJR2iT9MGaFLy4mDMRdpcfvyaEzZ0eEdUku/F3bbdPQxeGTh4woaXU1K/4sl8ijEcUVcydH8AYv/e9xZH0YM07s7heCAQ/DxzNI2crKuLbFyL0AKhpFWWkO0GrVN3PLAE6/dqBGyqZWwW+2KONwpKVsb53UDBe35CekiuatiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POWwmzG2gbU52eJB4g5+C2jprmq1MN+IAqtrCKBgWi4=;
 b=VGlwxs9uhGboHHj407aA1z5orxWrqPwCgFhUSFFtuT2i9B5/SsvQhb0tJhkO12aLJ3et1G/gbWaOMyTc/UpwiJ3tlS5CQjdndxUZXozrXWeSZPeIQuGXwQnN5Gs6YsHZjpayen/mf8DDgW8fC4c20q1MObpTqf+Y/DdBHLcXjoaX07W2fvxCep2BM+F1m9npMG7YP9xQJ+n4fTQptQ4dypfst5XL89L2Uskjzyv9sxM2xNMo5z5T2vvfDSKdLUHkwnJpKofv7vjIkKYdzv+0CLP903/gdr6d387K7uZQ/6TBSth73qgzwpKj2LIzAdqjlwm9U2tjI3u63P7fHintPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=dolcini.it smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POWwmzG2gbU52eJB4g5+C2jprmq1MN+IAqtrCKBgWi4=;
 b=WrFtyL/VF8yHTsdCc/61Z+z6Wi+VmLjipj/EI5dx9EV0Dg514n5AmZG/ML3SiVZqMLGGzXynwa4YzObtHoD29FWQxXlsIfm5Yed5sIC75+HOFQO+ZNpC4hNRKv/Eg/U/wo1ySulyi5ZFMmAdzw7UK5wZKe7w+Ociir9wkwx966A=
Received: from BY3PR03CA0024.namprd03.prod.outlook.com (2603:10b6:a03:39a::29)
 by SJ0PR10MB4606.namprd10.prod.outlook.com (2603:10b6:a03:2da::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 21:52:12 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::3b) by BY3PR03CA0024.outlook.office365.com
 (2603:10b6:a03:39a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 21:52:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 21:52:11 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 16:52:10 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 16:52:09 -0500
Received: from DLEE205.ent.ti.com ([fe80::836d:ea8f:955d:d32c]) by
 DLEE205.ent.ti.com ([fe80::836d:ea8f:955d:d32c%13]) with mapi id
 15.02.2562.037; Wed, 20 May 2026 16:52:09 -0500
From: "Scholz, Kevin" <k-scholz@ti.com>
To: "Francis, Neha" <n-francis@ti.com>, Francesco Dolcini
 <francesco@dolcini.it>
CC: Franz Schnyder <fra.schnyder@gmail.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "K, Santhosh Kumar" <s-k6@ti.com>, "Brattlof, Bryan"
 <bb@ti.com>, "Chawdhry, Manorit" <m-chawdhry@ti.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "Kumar, Udit" <u-kumar1@ti.com>, "Gujulan Elango,
 Hari Prasath" <gehariprasath@ti.com>, "Scholz, Kevin" <k-scholz@ti.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2 5/7] arm: dts: k3-am69: ddr: Update to
 v0.12.0 of DDR config tool
Thread-Topic: [EXTERNAL] Re: [PATCH v2 5/7] arm: dts: k3-am69: ddr: Update to
 v0.12.0 of DDR config tool
Thread-Index: AQHcUfoBvqZ8O8Do8kmqePkOB8K03LT7rLaA////sVCAAG3IAIDug+cAgC3/vCA=
Date: Wed, 20 May 2026 21:52:09 +0000
Message-ID: <8d4936cd5b16494e9447d5f64d7b8e11@ti.com>
References: <20251103071035.674604-1-n-francis@ti.com>
 <20251103071035.674604-6-n-francis@ti.com>
 <btgc6fvqwkqlnnmqicvobikkyjpib5lgvda7tfyguwn25bmd2s@hdhibzylbig7>
 <2b1b5496-cbd2-4ac4-85cc-2b8da653bbdd@ti.com>
 <20251120081659.GA12514@francesco-nb>
 <6726eb089e2f41ad9fa4a5ff3d6ceb54@ti.com>
 <20251120144848.GA58464@francesco-nb>
 <fcba4a77-53a2-4f7f-be95-e9cefcf347a3@ti.com>
In-Reply-To: <fcba4a77-53a2-4f7f-be95-e9cefcf347a3@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.219.50.186]
x-c2processedorg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|SJ0PR10MB4606:EE_
X-MS-Office365-Filtering-Correlation-Id: 24406440-2d12-4741-1051-08deb6ba0bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|22082099003|3023799007|4143699003|56012099003|6133799003;
X-Microsoft-Antispam-Message-Info: SpbZLTIAtLTfDREvK2LqFqATejavxYdx919Jh4ya2LlQY+Q+da1TghOV/BpFiZuTrGm/9BBTvPAem2yhLc22Erb719WlV1ssdRAhuFJNwBZumgM6/nSLdpx7bSK/DyYCyAc45CF1PwVu3dvOOSzN8HcNgFAxR288UCc0B3PM068gMIhVgbAC0R6q1s3MdQG7hSN2Kc+acfDhhu8A62MweKhBP0ORrVokreqAuOwU7XtWo2/Umxy5K6bJgPwcy6IkQWFVm4zD0DGbxV/BcTkF29gKngwH5ij+1pAUwHt7DtjqFsDSGFP2BjMZtsUN87n5uBK5G//x2VLfJUgNS7QvxTVdILjy53qUjn0UhDct/zLjpwAwWsabh8JqxUKVhrBqJCrgbQL5GFzlYE1ve1kjBMhAyL0KcZCD/OSo0orGrAvz1NjG1IpN5d+vr5zguLuUMvOLfoPzI3EIUEZXVuhJ96OklgSAU5TyFyeX+2rWA72VC0GWok9fndCtZIMLw0LIdMNbhP20iQf1AphnC1aakPYvnosVIHPrXSr5Zt4lci4pg7JtSwkvnYOgPxQpoYGMMc7xTvUxxC+gJcGLhutOrfbpUm8J8re0S/VZVWEOnf59Kdti8s5bd62gwrz9qM+bICbFvL6r+zX2jBd6zR4fJzJE7VaM9E/4YqWbQ+9jXx+NeuCmENv0QU7CmLx6L+r4WXGng6dJcBpdwP+dRJYbbc+jCdSxuii+xWXil9nZ5MM=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(22082099003)(3023799007)(4143699003)(56012099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r2AdSmkhELVNuktPqFFAw0E3U26vbMSzbIWDxKpzn3sDOSYOqdkEzBXY/E0/mRMYiqZt+e+CZNhsSK5B1RGS696V1tNjXiP68/4F852LDN6J5s+rnrbCNvfKUMuFGKMGaRY5EkSn32fOSPUtgVTyBXaajbc5bPrSlcp8XPtdN5m4rUzYNoVyYFSpp6oP7fAgWA8tgogv4Ax0OQEHcuTuBi4+AraERHL3gbne3us7bKDi+QWjtyHpLAyH6ZswkWhAvWf1Mbm4NO6Vunwn0AZyBH+iOs3EtJ49qadHusfYt6eerIeYrllL+BmnGbQgzB1p3i59ew+eGf6JPKh/7txVf0h2f4mwMmb5Fmw1hbwm1YXcBwA3HbmCC+x3kJjUKFCnq5VDDYs7aIUdKDYuzHmO9pJURhLgSQg2ODnHvSeGbS1ZRISnmWpqBvdNQrVf8qP9
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 21:52:11.2549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24406440-2d12-4741-1051-08deb6ba0bf4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4606
X-Mailman-Approved-At: Thu, 21 May 2026 07:01:44 +0200
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

RnJhbmNlc2NvLA0KDQpNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgdGhlIEFxdWlsYSBib2FyZCB3
YXMgcHJldmlvdXNseSBoYXZpbmcgaW50ZXJtaXR0ZW50IGJvb3QgZmFpbHVyZXMsIGhlbmNlIHRo
ZSBjb21wYXJpc29uIG9mIHRoZSBUSSBFVk0gcmVnaXN0ZXIgdmFsdWVzIHZzLiB0aGUgQXF1aWxh
IGJvYXJkIHJlZ2lzdGVyIHZhbHVlcy4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHNpbmNlIHRo
ZW4sIHR3byB1bnJlbGF0ZWQgaXNzdWVzIHdlcmUgaWRlbnRpZmllZCByZXN1bHRpbmcgaW4gdGhl
IG9ic2VydmVkIGJlaGF2aW9yLCBhbmQgYm90aCBoYXZlIGJlZW4gcmVzb2x2ZWQuDQoNCkhvd2V2
ZXIgaW4gZ2VuZXJhbCwgbW9yZSB0aGFuIG9uZSBJTyBzZXR0aW5nIGNhbiBiZSBhZGVxdWF0ZSBm
b3IgYSBnaXZlbiBkZXNpZ24sIGFuZCBpdCBpcyBhbHNvIGFjY2VwdGFibGUgdG8gaGF2ZSBkaWZm
ZXJlbnQgSU8gc2V0dGluZ3MgZm9yIGRpZmZlcmVudCBib2FyZCBkZXNpZ25zIGFuZC9vciBmb3Ig
ZGlmZmVyZW50IEREUlNTIG9uIHRoZSBzYW1lIGJvYXJkLiANCg0KUmVnYXJkcywNCktldmluDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBGcmFuY2lzLCBOZWhhIDxuLWZyYW5j
aXNAdGkuY29tPiANClNlbnQ6IFR1ZXNkYXksIEFwcmlsIDIxLCAyMDI2IDU6MTEgQU0NClRvOiBG
cmFuY2VzY28gRG9sY2luaSA8ZnJhbmNlc2NvQGRvbGNpbmkuaXQ+OyBTY2hvbHosIEtldmluIDxr
LXNjaG9sekB0aS5jb20+DQpDYzogRnJhbnogU2NobnlkZXIgPGZyYS5zY2hueWRlckBnbWFpbC5j
b20+OyB0cmluaUBrb25zdWxrby5jb207IEssIFNhbnRob3NoIEt1bWFyIDxzLWs2QHRpLmNvbT47
IEJyYXR0bG9mLCBCcnlhbiA8YmJAdGkuY29tPjsgQ2hhd2RocnksIE1hbm9yaXQgPG0tY2hhd2Ro
cnlAdGkuY29tPjsgdS1ib290QGxpc3RzLmRlbnguZGU7IEt1bWFyLCBVZGl0IDx1LWt1bWFyMUB0
aS5jb20+OyBHdWp1bGFuIEVsYW5nbywgSGFyaSBQcmFzYXRoIDxnZWhhcmlwcmFzYXRoQHRpLmNv
bT4NClN1YmplY3Q6IFJlOiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggdjIgNS83XSBhcm06IGR0czog
azMtYW02OTogZGRyOiBVcGRhdGUgdG8gdjAuMTIuMCBvZiBERFIgY29uZmlnIHRvb2wNCg0KSGkg
S2V2aW4NCg0KT24gMjAvMTEvMjUgMjA6MTgsIEZyYW5jZXNjbyBEb2xjaW5pIHdyb3RlOg0KPiBI
ZWxsbyBLZXZpbiwNCj4gDQo+IE9uIFRodSwgTm92IDIwLCAyMDI1IGF0IDAyOjIzOjAyUE0gKzAw
MDAsIFNjaG9seiwgS2V2aW4gd3JvdGU6DQo+Pg0KPj4gT0RUIGlzIHVzZXIgY29uZmlndXJhYmxl
IGZyb20gdGhlIFREQTR4IChKNzg0UzQpIEREUiBjb25maWcgdG9vbC4NCj4+IEN1c3RvbSBib2Fy
ZHMgY2FuIG1vZGlmeSB0aGlzIHNldHRpbmcgYXMgbmVlZGVkLg0KPiANCj4gVGhhbmtzIGZvciBl
eHBsYWluaW5nIG1lIHRoZSB0b29sIGFuZCB0aGUgcmVsYXRlZCBjb25maWcgb3B0aW9ucyBhbmQg
DQo+IGNoYW5nZXMsIGhvd2V2ZXIgdGhlIHF1ZXN0aW9uIGlzIHdoeSB5b3UgaGF2ZSB0aGlzIGRp
ZmZlcmVuY2UgaW4geW91ciANCj4gc3BlY2lmaWMgY29uZmlndXJhdGlvbiBmb3IgQU02OUEgU0sg
Ym9hcmQgaW4gd2hpY2ggb25seSBkcmFtMyBoYXMgT0RUIA0KPiBlbmFibGVkLCBhbmQgZHJhbSwg
ZHJhbTEgYW5kIGRyYW0yIG5vdC4gSXMgdGhlIGxheW91dC9zY2hlbWF0aWNzIG9mIA0KPiBEUkFN
MyBkaWZmZXJlbnQgZnJvbSB0aGUgb3RoZXJzPyBXaHk/DQoNCklzIHRoZXJlIGFueSBzcGVjaWZp
YyByZWFzb24gZm9yIGRvaW5nIHRoaXMgYXMgRnJhbmNlc2NvIGhhcyBwb2ludGVkIG91dD8NCg0K
DQo+IA0KPiBGcmFuY2VzY28NCj4gDQoNCi0tDQpUaGFua2luZyBZb3UNCk5laGEgTWFsY29tIEZy
YW5jaXMNCg0K
