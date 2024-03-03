Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE977C48BF6
	for <u-boot@archiver.kernel.org>; Sun,  3 Mar 2024 03:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D369187ECA;
	Sun,  3 Mar 2024 04:42:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="HvKVLr+P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7581A87A23; Sun,  3 Mar 2024 03:15:00 +0100 (CET)
Received: from HK2PR02CU002.outbound.protection.outlook.com
 (mail-eastasiaazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c400::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B784876D3
 for <u-boot@lists.denx.de>; Sun,  3 Mar 2024 03:14:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jacky_chou@aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+J2pFdJKyJWbU5syaW0Qq1ayyDEBjSahbq6dCPY4k5ndonmrYKFvWHsMzqafRMXXr6lL/l6F3ra/uqj4Ue5q8pMzwCQTpHb2/JA5cLwQbFcIP/tZVO8QHkHcoa4xKCdCHt+Q47MB/e0ratk/DnGmsE++Lc+J0PGJwRtyk38sZUwSQdZ6nxhR+gjamj8Tezki1qiafrRDxsC2pAOGjqxXgmrt/X8Cf6gK22HZaz3ngdMToSYiWOTB5qbthEIj0bWsjicGhcHIzFNesHqIG5asmAN0/v4wTelIPrT0OS5npF6eS9q3aoE3OlAgeiefL9xUmnsSXSPONdv6LHAes71Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yrS6Imc5d5ec4Eac4H+4v0o1gqOXcgFKRqvpUzPMtQ=;
 b=RAX1rt3O/zAvajhHE4BDFa6XQIO05rnBIfoLZT3tt0xiRGDKzZ/iTHK/LerhVCzI9B96zqdA1N1Iq+bdCgfVfbJ2chTyHYHmtkiG2GAavZT4Uj6BpGerx7KSvq7C/X8z7EZxXotDFOb5YLcTQKdBoh1FXF8xkx2mLU8kxeTLDrjxXE7ntfJkbl4RRAAEItLX1RD8W+aYtFLexjfqrSmCL4+vfnSHJ2+GDAkPFH2wtc+ZGwM6VBlQSSxhnzlkOxOg1tXq4uTR0mo97ZNdk2Og5Iz7pB6PSs1AfgLIwC0NePvnYV201Sjyf/t8RQz+XVi4mAZSgbeu2lo7+sjgmEslYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yrS6Imc5d5ec4Eac4H+4v0o1gqOXcgFKRqvpUzPMtQ=;
 b=HvKVLr+PkEoQS3M1VdyUeBvJtCKdJ5vlJlGrfVjCGT4vGwwZ+RcIicfzUJLt+krCVIyphIM9yFIBd4vTnncoRPM4CM/FwuJ/PkpIjGv+jwKf663nJZrnv5223+KXvFkl3q+cCrerRnzISJLoUwhH1vN5Jstoh7CPvFoQ0T2yoLZKGbwvg2wzvCXFJyzrfB/PZ3BqaBelIRMddBV3WoAFDf5/IlFKP2xt5Je4xnmTkPhlocVL5YPmNkuReTf4bx8gkqRKEHx/CNvfAXRzfN+Mx0rumdQRvwxGPXnPWTVPFoh2Qc7687Lsf0xibcILSiVYazaRKFmrnQ9jM3Gm87xIzw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEZPR06MB5047.apcprd06.prod.outlook.com (2603:1096:101:44::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Sun, 3 Mar
 2024 02:14:44 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::8a5:526c:6c7b:d7e2]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::8a5:526c:6c7b:d7e2%5]) with mapi id 15.20.7316.039; Sun, 3 Mar 2024
 02:14:44 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "joe.hershberger@ni.com" <joe.hershberger@ni.com>, "rfried.dev@gmail.com"
 <rfried.dev@gmail.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "michal.simek@amd.com" <michal.simek@amd.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, BMC-SW <BMC-SW@aspeedtech.com>
Subject: =?big5?B?pl7C0DogW1BBVENIXSBuZXQ6IHBoeTogbmNzaTogQ29ycmVjdCB0aGUgZW5kaWFu?=
 =?big5?Q?_of_the_checksum?=
Thread-Topic: [PATCH] net: phy: ncsi: Correct the endian of the checksum
Thread-Index: AQHaWAmpi8UDfpNfV06WGDGE/JDeRbD72TMAgCJLnpw=
Date: Sun, 3 Mar 2024 02:14:43 +0000
Message-ID: <SEYPR06MB513483FE06C897839C5E3E5E9D592@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20240205080228.140001-1-jacky_chou@aspeedtech.com>
 <da9231ac-1386-48fc-81b9-8e027cd5dff5@moroto.mountain>
In-Reply-To: <da9231ac-1386-48fc-81b9-8e027cd5dff5@moroto.mountain>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
undefined: 2707980
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEZPR06MB5047:EE_
x-ms-office365-filtering-correlation-id: 529d482a-ef53-4730-47a3-08dc3b27b104
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 30rA/Dxlj4/AGi4FohqlUwzuCkzXMyEMMK5mh1s3qrSB2bg54+AP1w12adOasrI5g4zNCIbU2I4AxLgJ9pn75BQDMSQ4TlMjcbPuWYMU99oaid/z/N9HSVv8+hJoLGbRm62ZNtLAKnDVj28X4MjaHWGmwudIAz3QGfbtqZ2zqCyyKz1AAN+aDtwq1tGX0ORQVotVN5lDqRxqRHVIwTegFSblgEV/FTYPIZcBCpGBW4KxYhl8/k0LHNdZKmkQsf8MZ9CQV6XdbqBQ9jZHVtswBqtRVyCPR18/HIqTLqstrPHX/UXA8k1/Vu8s4gpn0PPsOySIR94eLdyLgnTy/N1iQoBWra7DW/OB7x9W4F2p5POBZwpmyMvRotUEryhjjPcKPOHsdHBeWXuu5FND+2182jIi9r0aO1HhoNguCAfTcqlw/7ob6jrsOZJqpG+S6tV9wipwQSE1DkvHA0cJL9k7S0Vi157hrNXhACP4V1lqDXO1DoPy1iqSr5xkS78iU1WOC/Up3sWu8dLVLgf6K9YHJkAuIkZpwl1smMIRq4Zitfvfax6BydWMDQF6hNQL5BCf1r1ai3z2AnbSmPQ8+YCIzvWRqKWcM3egHVwF30dyDxBxtwLoJwlT6zLAiqPPWt18qXM/hb8Y72KW2MqXD8t9QNk0ZOcgELzE0TQTbhu9C13N3EbUN04exGnDvNH9v5dsOGRHFZYUrXL2QWX7G7/37t5NNdAfAtH/TaQ8aNNxckM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR06MB5134.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?ZE85UVRyanZDaHJmc1VsWGdHc2xWODJZdmJDM2VNeWtsa1FnOVlTUlhnQlgxZ0Mz?=
 =?big5?B?SlR2NDVFMEVVVWZ4S3JKUW5NRVVWb2wraXN0VmxIbmgvYlprSW94VkxQRlExRDRy?=
 =?big5?B?WjZObURjRTdLSVZzUHJEQXFJZlA5R0JobWhLbEFxZ2V6RHpBb1Y4dWxpSHVia2dI?=
 =?big5?B?cUxJMEZKMTBsNHlPVkhKT0hUa0pnSFFna1lHNUhWcERJWitkdTNnblZHak05czBM?=
 =?big5?B?b3FMbWN1OG9Gd0s2Z1F1c1hXOCs1TEU0L3NPM3BBa1RlWndMYlQzYlQ1ZFdua1dy?=
 =?big5?B?VWJ4V1p1S3FkdDJkRXJDOXVmOUpFdWJYeG4rcm9LR051R1MwUmRjU3lLcGt3cG12?=
 =?big5?B?cll6cXo5YzhmU25FT1BMQnN6ZkZhNWR2enhpRWxYRStNbjBoZ01VUHk1UkpwRTRs?=
 =?big5?B?eGM4eHZERFFTZ1k0bE9jRm0vZy92ckZqbmY5WDBGV3k4UlZ1S3J0cVNEN2NlVXpY?=
 =?big5?B?QlY4WFRZRGRsSld1ZG91QzZaREVZSk5zRFhJWUc3S3ZNUVVpT3lqdGFRdWFJNzdw?=
 =?big5?B?OFhpeXQzazI3S0tFQzRraGJieHlwUGFtOE1vM3NHQ1R4WTcrc0l0Mkl6ViswazA2?=
 =?big5?B?cWJlOWJNVlNqVTFrMWwvaVN4blFlZ0NrbjhxdVJkMDJMK1Ivb3BocThuSlFjSC91?=
 =?big5?B?bC9JdFNhM0M2Zm5nbmtrYVN2YThKbWNCYlU0RmlyRlgrUlFaRVE3TW1oKzRqS1lS?=
 =?big5?B?QXVXczJUdUM4bndjZHFjRGZUVVNzWG5vNnhIc1hKSHZ4MGV6SWthTjhvaFJlVVA0?=
 =?big5?B?R0VWMUV1dGovSUVpYnlHSy9KVWZ1TnlkSWtReG4yL3F3dUtTejRPYXRUT1E3eXZ6?=
 =?big5?B?YUNsRmkrOFNENG9XWlNGR1dDUjQ5djNJZ01PM2JaWjJKYk1QRXM5clZUUDRHaDZ1?=
 =?big5?B?Qjg3QVpzQXU2WmxRME9sWVhNQXNYVnJLV3d1MjNxMkZmZzN5YW84c0dZaDlNU2FF?=
 =?big5?B?QzlHUm0xSEVpekp4Ynl2MEhOTmtNVTdXMnF6TnVmZFdrUUU2eWRUSUdlMTRJK3Vo?=
 =?big5?B?YmdHaDh5b24xVjlRVlVDdWV3WEUrd3RUUktKdnZFeGg4YWxCOE11UUhIWmNhQzEv?=
 =?big5?B?N01XUGhYbkpLNnhZT1FXV0JLYUQvei9pRmNidzFUalMwMUZKMnRna2ZVa1g2bFUx?=
 =?big5?B?R3E3dUxJa2JZWVdGZ2hmSkUzV2JhZzVSL0lydTEyaEhQN0lFLytlZ0VBR2ErNEJI?=
 =?big5?B?b3lkeDNrdmFCU05BMC96WEpsVC9qVTRSZEgrTkp1WCtRbFI3dk9BZU4wMUZkSjNM?=
 =?big5?B?UHN0VjkvS3k2cGhpTnVTZmJMTlhrOGdCdlpZUmtBbGlrNEVxU0FPc2NMbFlCcDg2?=
 =?big5?B?QnB0YW0rY3BwNHEyMXVWL2dnNnhrSzZEaEdvTDhqcWtMY3VseTRjNUQ5WkordFFa?=
 =?big5?B?akpCZ3JhMnRrSVdNV3Y0QzdHZ1dXdUFHbDhrODNJdXZvdGh1RnNQaE9PZjRPZGc2?=
 =?big5?B?M0pzVVRvcTlzQzdISjAxdWNjSU9zKzh5Vi9KY2pOK0JzZ0FjZUU3WllTK0RVcXgw?=
 =?big5?B?T0duVURVMXRGSW8wWGU2UTNBeFkzZUNGbjM3RGUrNGNFUUdCZDhwenhMRWpmdFla?=
 =?big5?B?WCtMajBTWUVZWG1aeUVUbmFNSkw2QU5pd1pYalFZWms2cTdJMFMxSk9vMk9BcmJI?=
 =?big5?B?R0ZRdWowUTczSnUrN2RyY1EwamEyZE16VmRSTFVaeG51WGVRclZjWHZoSi9TMnEv?=
 =?big5?B?SlhTcGhPVHByKzVkSTYrVDFKQVFrSnE3eE5wVW5RN2tieEp4cVoxK05DQjNwZjhP?=
 =?big5?B?ZmZNdjAzbXJBajNaVWtRUUhLVUgveWUwcTdMSW5IRHVScDUxc2Q4bjBxUWRBLy9p?=
 =?big5?B?ZkhMY0lURUFZSEg2em9Nd3AxVkl5a3hYQjBZQUhUT1JwZlpyYnhtQnpKOGtobW52?=
 =?big5?B?YXZmMWNaR1pVa2R6UE44amdYTHI3MXdhM2c5TEFQRGMrZkJ2WlBCNU1hSm9oaTlH?=
 =?big5?B?Y09CQy9Jc3NRbkdWakJ2Vllkb1FoVFdqNXNkcUpPVnBJVUxlVDJvamYvb1lUVS9z?=
 =?big5?Q?ysQWDdehxjVhsmx0?=
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529d482a-ef53-4730-47a3-08dc3b27b104
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2024 02:14:43.9055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pdlxlBQjwicAoQxMorBq4h0Jn+jWN03H6sGpSLnYJvOAAXKRhVVCWKUgahGv4QFQlXK84fEBC4OKgfHVW+PVNiWl0aUrqrgQKATEk0pxgH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5047
X-Mailman-Approved-At: Sun, 03 Mar 2024 04:42:52 +0100
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

SGkgRGFuIENhcnBlbnRlciwNCg0KSSBoYXZlIHZlcmlmaWVkIGl0IG9uIHRoZSBsaXR0bGUtZW5k
aWFuIHBsYXRmb3JtLCBzdWNoIGFzIEFTUEVFRCBBU1QyNjAwLg0KSSB0aGluayBwdXRfdW5hbGln
bmVkX2JlMzIoKSBhbmQgaHRvbmwoKSBmdW5jdGlvbnMgaGF2ZSBubyBlZmZlY3Qgb24gYmlnLWVu
ZGlhbiBwbGF0Zm9ybXMuDQpBbmQga2VlcCBwdXRfdW5hbGlnbmVkX2JlMzIoKSB0byBoZWxwIGFj
Y2VzcyB0aGUgdW5hbGlnbmVkIG1lbW9yeSwgc3VjaCBhcyBwY2hlY2tzdW0gdmFyaWFibGUuDQoN
Cg0KVGhhbmtzLA0KSmFja3kNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCrFI
pfOqzDogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPg0KsUil86TptME6
IDIwMjSmfjKk6zWk6SCkVaTIIDExOjA0DQqmrKXzqsw6IEphY2t5IENob3UgPGphY2t5X2Nob3VA
YXNwZWVkdGVjaC5jb20+DQqwxqW7OiBqb2UuaGVyc2hiZXJnZXJAbmkuY29tIDxqb2UuaGVyc2hi
ZXJnZXJAbmkuY29tPjsgcmZyaWVkLmRldkBnbWFpbC5jb20gPHJmcmllZC5kZXZAZ21haWwuY29t
PjsgdHJpbmlAa29uc3Vsa28uY29tIDx0cmluaUBrb25zdWxrby5jb20+OyBtaWNoYWwuc2ltZWtA
YW1kLmNvbSA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBtYXJlay52YXN1dCtyZW5lc2FzQG1haWxi
b3gub3JnIDxtYXJlay52YXN1dCtyZW5lc2FzQG1haWxib3gub3JnPjsgdS1ib290QGxpc3RzLmRl
bnguZGUgPHUtYm9vdEBsaXN0cy5kZW54LmRlPjsgQk1DLVNXIDxCTUMtU1dAYXNwZWVkdGVjaC5j
b20+DQqlRKauOiBSZTogW1BBVENIXSBuZXQ6IHBoeTogbmNzaTogQ29ycmVjdCB0aGUgZW5kaWFu
IG9mIHRoZSBjaGVja3N1bQ0KDQpPbiBNb24sIEZlYiAwNSwgMjAyNCBhdCAwNDowMjoyOFBNICsw
ODAwLCBKYWNreSBDaG91IHdyb3RlOg0KPiBUaGVyZSBpcyBubyBuZWVkIHRvIHBlcmZvcm0gdGhl
IGVuZGlhbiB0d2ljZSBoZXJlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBKYWNreSBDaG91IDxqYWNr
eV9jaG91QGFzcGVlZHRlY2guY29tPg0KDQpSZXZpZXdlZC1ieTogRGFuIENhcnBlbnRlciA8ZGFu
LmNhcnBlbnRlckBsaW5hcm8ub3JnPg0KRml4ZXM6IGY2NDFhOGFjOTNlMCAoInBoeTogQWRkIHN1
cHBvcnQgZm9yIHRoZSBOQy1TSSBwcm90b2NvbCIpDQoNCkhvdyBkaWQgdGhpcyBldmVyIHdvcms/
ICBXYXMgdGhpcyBhbHdheXMgdGVzdGVkIG9uIGJpZyBlbmRpYW4gaGFyZHdhcmUNCm9yIHdhcyBu
b3RoaW5nIHZlcmlmeWluZyB0aGUgY2hlY2tzdW1zPw0KDQpyZWdhcmRzLA0KZGFuIGNhcnBlbnRl
cg0KDQo=
