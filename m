Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA4BCD4F52
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 12:07:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9825E83EF9;
	Mon, 18 May 2026 14:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sttls.nl header.i=@sttls.nl header.b="ZsbrRTYf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA79284119; Mon, 18 May 2026 14:07:13 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C1C1803C6
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 14:07:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Maarten.Brock@sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJu8SlthuR2X1scgj9HnS5cyep8+cE6upqnsKna6DNmvmcoSN2hJH4nU1quCNSgqBPloo5Nhu2vsLfdejGvEk5gWEkkhcpUtRezA5AW+TKOjw1f95fTSRowcpV6b3B9MmSBOtZyv9uxiouca5tadlrsessjLjbXnmlThzourXCpJJsMWNNX+nGrcwAlfCNtseq1ko7OBV+Tr8R/3Pj9fB/kQzrZ01WTVLbZDTxcOP2SZgBHyXiNofjwD7L4yLLi7XdzfOf7/rk+Kti1sJcMZEo6H/ed3icKy04mzToREyb77wjjInS64TMNIwgzTvmc0r/mtDnK+BkgWFpdprLHcWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pCnAXt+TsgkU9KKFadqCcHNnKKZXJPSBfbxe3nKCio=;
 b=AWPdUk0jONB1Euij5U1mxeMWIfTOV/Hf0Ogb5S98uhMYLdfgBNpf5QBJ2O3IcKr862ag4xDNS+HFfNdU753jAESSap3oe4CiPK/vBJGxHId+nTrvYVjz2d2OLWyHvHOWvlOQ15P8/dUXlQgfLT35xYLUvspcsRoo85BoM0aBrvkynR+x1TuwvSAh/bNSW0zsghjCW6SYt+8aDfr2Nd2rBkvJYxct9wLPP3wn3dl7CdWv3P+U7t2VvgdpyhRIE2qyhAco/a6w5wvRnPGiriKI0wLnM+ma5z9Gca6f//mXfgukAxvDQWJlzwINMhBImFUx+c/6mHjB916HInD23wqwoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=amd.com smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pCnAXt+TsgkU9KKFadqCcHNnKKZXJPSBfbxe3nKCio=;
 b=ZsbrRTYfQ/Iq1/6cNuat+3cEfuI1R49RCvp9VzsLtl+QcgonJcaYZN4oPgX8ch9nvlQJulr5p6hbYSg+G2oqfwWOuf4gf3yqBi4gNDRSQNnkXMN+oe2d+G3O3Ceu/cMU2P7s/hyrTs3n02VXn8+i0yaY4wJ3Y6AZ9VOXqCUVdDnGTgvv5cBjjcYTFsmEA9JMth0tGz4H4GsWmEWtsVulbuD1nGRGx+GdzfJzX+PjKq/YABB/WKajsbCIb1A6lEX2RQqSzpjmFzSTmmxh/2Y8dCqDkx9OgVweuBuDqLXElOLSPIprG9q+5a9PiLNNy9buzps1Djp6lAzyD5ZSOscIKg==
Received: from DB3PR06CA0030.eurprd06.prod.outlook.com (2603:10a6:8:1::43) by
 PAVPR05MB10482.eurprd05.prod.outlook.com (2603:10a6:102:2f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 12:07:05 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:8:1:cafe::a7) by DB3PR06CA0030.outlook.office365.com
 (2603:10a6:8:1::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 12:07:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 12:07:04 +0000
Received: from DUZPR08CU001.outbound.protection.outlook.com (40.93.64.68) by
 westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Mon, 18 May 2026 12:07:03 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by AM9PR05MB8733.eurprd05.prod.outlook.com
 (2603:10a6:20b:413::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 12:07:01 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a%4]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 12:07:00 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Michal Simek <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "git@amd.com" <git@amd.com>, Simon Glass
 <sjg@chromium.org>
CC: Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v3 1/5] reset: Add reset_reset() and reset_reset_bulk() API
Thread-Topic: [PATCH v3 1/5] reset: Add reset_reset() and reset_reset_bulk()
 API
Thread-Index: AQHc4rzbCDLskqqraUWKae54XuSMorYTl/zAgAAGb4CAABgoUA==
Date: Mon, 18 May 2026 12:07:00 +0000
Message-ID: <GV2PR05MB1194186BCEE688E85977E22FE83032@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <cover.1778665323.git.michal.simek@amd.com>
 <b8229b9f7b357cf6013e8423831a9af1d69fefdb.1778665323.git.michal.simek@amd.com>
 <GV2PR05MB1194140D0CFDB4D8C63BB998183032@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <0f7c82f8-dfff-4c0b-84c5-41f189ee042b@amd.com>
In-Reply-To: <0f7c82f8-dfff-4c0b-84c5-41f189ee042b@amd.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: GV2PR05MB11941:EE_|AM9PR05MB8733:EE_|DU2PEPF00028D11:EE_|PAVPR05MB10482:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f41379-712d-4689-f0a2-08deb4d5f9c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003|4143699003|38070700021;
X-Microsoft-Antispam-Message-Info-Original: CFxbKXqBc4hUKvvV1uhiOwJ8rHJFEvdokNU5viyVinoIhmusjzeoEocGeI/cfbcQRko2z1TlnDy91ZDwUUqugnpxMjSBf0ok8IdT1oGzpFRdV311vrVWzqlNrAnxtDS7yA4hyZfEwL+MWwPCjDr8gODl9uqHT9B47kR61locYvjpPMBBSNUdyYsM7+mD60Pg5ILMGFU1anEQAlgEELDO/3YtZ/HTuqL0LMgl39FrlNQkJTBvKyN1+bzodJVZgTbUyleoFND1otLcXlwNh9G93aSLIiTAOpR83tjGHe4G8a5aZEb2Q/ZfoinBxaXV5LxGo+8icAl4a9NR7Mw2GUOMC8xoPYimuv9iZfv3IU8Ddsp9C93oXKhCyLmbA0E/vMTG2TI9ashhQiwRnSXFvsbXsuIANdJcgZzefIzGrI+sObHQtZEzN1K1oFMD6whoN22hlQUTnYVSBqOtMyIyIBY1LffkG1hWTSbgSRtyLs2fO4518gZbg0+LtRbWy1/0o6d7JS2D+IfBXVmpeXwn7Thzm9YBrdpMSHXPI0R6zp/b8DWOQ6iUUOP8UsV2WUcYjA+ujpOPmYTPfuLb8yfRHEvNgHaa9uYKe+ZNGGJlcb6SW9lLA4nZEUst30UAnwt474vHXHpa1+nFQoi6+D0B41uWFDhXb6mc+4t06ERjfqsYYmGzOB501bVaWDo1zVHDQP4V9SAUYHKl069JRG3hnaHI0saBGlBzuikzDZymJ2mWJWhIBmNXwJBvn7rVMqJFGXcN
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV2PR05MB11941.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Q8xjAABbFJDLip9xZ3SM426/DIXkQw+RyYTySC5jU1tufw6tdSEGRv7do1428jNuCXjbYuDCIcuC17qrE6I9N2sp/UBCz0QFwBI59p+mu9cZ88C4L56rK1LCtpWPviL09em0OIVxkHV7l/UPSj+Hi6vt0PPBF0UU3kEZWjdXFMTkKG/z5h8P5tDswgA+Am/PYo3Qvvr21D2I1QPdJbME6HgXmzVQz9fs8esIk/8vGrw0fYNQFct8k7Wt8BY2nBqQ1YjwVOHhu4wzZW6TCu9OyIXKuD/fn0d1N5UnJqI9mGqWf8bZmKSN85nWjpVLiMgBkaf18oobjZhH/l3glOfj+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR05MB8733
X-CodeTwo-MessageID: 6d9f36b2-fce1-4634-bd92-26cfd7fd45ac.20260518120703@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 02312ec9-8ae4-44ef-97a1-08deb4d5f783
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|35042699022|82310400026|14060799003|36860700016|376014|22082099003|18002099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: cjlnNgCW/tiaKik7JbPfwnGsdP2BlmEULyTGiGAbi18wtba1PCjuiNTxZjsFlBGehgz+4gVTSg+GlCFX6v9edY6FO/PH+fyBYQqrYd1+P2+Gnd3XhmiIu2BphHc4mkwfYBmn7c+Hb364tYhI1tRXiD3myb7VedqwlAdcNgtOM3JNkZkoGeLN0Nu571mTAfftwHQgiTJz8PP5pohMmuDw2dLZH84slE7pU0V56CzAocX1No2feaoqAVXntA2IinuzHo/RyH3semLYj2z10v32H2ypfhLdSkaXtusZoo2qVCaIYQN2EwwC7g2gMN25+nh6bU6kpNkO0pZeK+Ve5DLw+VdwVexoNdOevjrKFNx5wqSEFcu1//KPrRfhTk9ngI9jVKm2P1faelwlGEeQvb8Edss8XixDrGBwZV6Ar5OFrjc/4XkYTa77aiVyKM5vebrn4xjPEDOhuaOi/ZZv5bqOQ2besUsA9n2FeuCni59L6VCzV9c4sjKH7x1EoQOxz7o1Qo3SlUyuuNptOTbpLhbAtpzJyEs3yaT57ry8w3kUw2LXqwKXN4jRcs7EZmZPdDqQJ8tKyPSG2n4Y9MFCJXwFG3sSFdliV4viuhGMoOckp/u7/cON2o5zyPHynU0TFhDC8mNjhM5Ve7Fl1LuQd5c93zUgyHsBKZ54RyLZIwXnW+wwaNyK5g7HTPzqrhdYE3cqsltGjfIuIaMsvzpVjo3HYtuL3sl6MhaU2nYLzMyln6A=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(1800799024)(35042699022)(82310400026)(14060799003)(36860700016)(376014)(22082099003)(18002099003)(56012099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eBm6GkVhSER6RZNk1HhOYypeUAxMmx1o3sWJGb4jxxy6jJy+rvQ4//d3SrJljzl0lwfd0uZkt/gabaCyvhJhgciRtZRxoy/B8WN2dcKhTdknY+59s4Zpof8aThkCMHzd5KG2IZ3tJ6k2Gr6PMLwAV3UIkENnQoXLLhd3l9xoWy9NBM+0mVB5g7mpyzVIucvv5HIzrDJUWEI3BWseRRFD8bJmQSXqcnt89SoYOE0O6iVJN2RmXG83QG440Jc+eLWcJ4zvF1afOICEYtWtowAgCen9S+jPESUqzH3kSSzSpOPaEuk26vN/nvzDt3oA4OinA/DAYOVub0MjdmYjNeZV3RhxF7xNk7aKkaJBVC6TlbGlG7jifq9MDmUEhzhd8G6TB3jJXghw4g3V1BoVAjPikMrQsIiZmyXg4Sl77fw//7EwC5g0IXMqBAyZjiFHRuyq
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 12:07:04.3553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f41379-712d-4689-f0a2-08deb4d5f9c3
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR05MB10482
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

SGVsbG8gTWljaGFsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1p
Y2hhbCBTaW1layA8bWljaGFsLnNpbWVrQGFtZC5jb20+DQo+IE9uIDUvMTgvMjYgMTI6MjEsIE1h
YXJ0ZW4gQnJvY2sgd3JvdGU6DQo+ID4NCj4gPiBBbHRob3VnaCBwcm9wZXJseSBjb21tZW50ZWQs
IEkgZmluZCB0aGUgcmVzZXRfcmVzZXRfYnVsaygpIGltcGxlbWVudGF0aW9uDQo+ID4gY291bnRl
cmludHVpdGl2ZS4gQXJlIHdlIHNvIGNlcnRhaW4gdGhhdCB0aGUgTGludXggaW1wbGVtZW50YXRp
b24gaXMgdGhlIHJpZ2h0DQo+ID4gYW5kIG9idmlvdXMgb25lPyBJIHBlcnNvbmFsbHkgd291bGQg
cHJlZmVyIHRvIGhhdmUgaXQgYXNzZXJ0IGFsbCByZXNldHMgYXQgdGhlDQo+ID4gc2FtZSB0aW1l
LiBJdCBpcyBmYXN0ZXIgYW5kIHByZXZlbnRzIHJhY2VzIGlmIHRoZSByZXNldHMgYXJlIGludGVy
ZGVwZW5kZW50Lg0KPiANCj4gV2h5IGRvIHlvdSB0aGluayB0aGF0IGl0IGlzIGZhc3Rlcj8NCj4g
DQo+IEkgZXhwZWN0IHlvdSB3b3VsZCBsaWtlIHRvIGRvIGl0IGxpa2UgdGhpcyByaWdodD8NCj4g
DQo+IGludCByZXNldF9yZXNldF9idWxrKHN0cnVjdCByZXNldF9jdGxfYnVsayAqYnVsaywgdWxv
bmcgZGVsYXlfdXMpDQo+IHsNCj4gCWludCByZXQ7DQo+IA0KPiAJcmV0ID0gcmVzZXRfYXNzZXJ0
X2J1bGsoYnVsayk7DQo+IAlpZiAocmV0KSB7DQo+IAkJZGV2X2VycihidXMsICJGYWlsZWQgdG8g
YXNzZXJ0IHJlc2V0OiAlZFxuIiwgcmV0KTsNCj4gCQlyZXR1cm4gcmV0Ow0KPiAJfQ0KPiANCj4g
CXVkZWxheShkZWxheV91cyk7DQo+IA0KPiAJLyogRGVhc3NlcnQgYWxsIE9TUEkgcmVzZXQgbGlu
ZXMgKi8NCj4gCXJldCA9IHJlc2V0X2RlYXNzZXJ0X2J1bGsoYnVsayk7DQo+IAlpZiAocmV0KSB7
DQo+IAkJZGV2X2VycihidXMsICJGYWlsZWQgdG8gZGVhc3NlcnQgcmVzZXQ6ICVkXG4iLCByZXQp
Ow0KPiAJCXJldHVybiByZXQ7DQo+IAl9DQo+IA0KPiAJcmV0dXJuIDA7DQo+IH0NCg0KVGhhdCBp
cyBjb3JyZWN0Lg0KQW5kIGEgc2luZ2xlIGRlbGF5IG9mIGRlbGF5X3VzIHRha2VzIGxlc3MgdGlt
ZSB0aGFuIE4qZGVsYXlfdXMgKGZvciBOPjEpLCBzbyB0aGUgdG90YWwgc3RhcnR1cCB0aW1lIGlz
IHNtYWxsZXIgKGEuay5hLiBmYXN0ZXIgc3RhcnR1cCkuDQoNCktpbmQgcmVnYXJkcywNCk1hYXJ0
ZW4gQnJvY2sNCg0K
