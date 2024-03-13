Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818BCC54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 16:45:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B7F087EBD;
	Wed, 13 Mar 2024 17:45:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=rad.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rad.com header.i=@rad.com header.b="HlDPdk9v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBFD987EB4; Wed, 13 Mar 2024 17:35:35 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D29A287EA8
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:35:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=rad.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lev_o@rad.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WolwbV79qlMv7G7u4orVlRtiBiJG+hkyok1dNxipOZdUoG9Yt8cKcjw6XNEURMSD6hEi4hdsB26bHux71pf6UwN857MzMkWL2gXirkj2BrrHJNzJ0igkRpVlXTS3DDruUMANTUMdlgFVMBlCZ5K2FsWBwpUJD7EQ6IcPG7sXbSEZECh0xrrOaftbxVpXkpcvkj0WSb/CKVgk00ye4hEjsvAOyFIUAYSawee3SGEY6iyUuTqCz5FndFRAY7xYvTMoHn8ETS7rZue/syalKregMoY4QSNRbXYurxoD2GPm3Uk718gafBsUq2S6eq8xYDqPtKxazhAaMXHSa4ILagaE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HO9uNd1x7B+3VQ7RcSZJ63YPpI9TakvegFHj3zlfzqY=;
 b=kz6XgR/Ezsf8oooqmPsfkbEfXIFEHOuphaei23YkkeZoAO/YW+zOV2T0Kuu90+yO4k5xYNu35e8r/NKBNAUqalEJxhFy2iZBdB14jGnwsAeg783zOyPqpNAD9BGjqy2QEPxioMqG2A2ezFNZv1o7/7aFNJiXuttpU0m3UXLsYG5iJm/e3JmnFYbFRuYgSKFKHQGSwaXoN0HBUgxHnd99eEqQhQzGDCGJ9e7Uk1Fk9k5VPYGQmTta0Fivlkh9suaeOd6lim3NTa+oqoNXu/1KpH8k8j/+31G1Za7/4Ka2NhPwZgFplZ8WUVR+GP+TlfpiMD+dZTt/bdXSl/MtS9xyeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rad.com; dmarc=pass action=none header.from=rad.com; dkim=pass
 header.d=rad.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rad.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HO9uNd1x7B+3VQ7RcSZJ63YPpI9TakvegFHj3zlfzqY=;
 b=HlDPdk9vt2+QZP/XCvapwmjj59eUfBbrWYW3yzfMWRb1lysrX/JUFVbD75ZrRfyHwzdsZ/MlPHXwhJqIqqM/ZHl1CnjixODe1XRvk1d42IgvIhIbDroPwjYMkSEkcHlJUlUbLT65WKYoXnAHAWoFFKYY8DJ3nSKbQ+6y04SZS0A=
Received: from VI1PR03MB4525.eurprd03.prod.outlook.com (2603:10a6:803:61::24)
 by AM7PR03MB6231.eurprd03.prod.outlook.com (2603:10a6:20b:142::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 16:35:31 +0000
Received: from VI1PR03MB4525.eurprd03.prod.outlook.com
 ([fe80::513d:ab6b:a738:c7a]) by VI1PR03MB4525.eurprd03.prod.outlook.com
 ([fe80::513d:ab6b:a738:c7a%7]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 16:35:31 +0000
From: Lev Olshvang <lev_o@rad.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Ariel Segal <ariel_s@rad.com>
Subject: Help: Marvell Armada  3720 board  verified boot function as
 non-verified 
Thread-Topic: Help: Marvell Armada  3720 board  verified boot function as
 non-verified 
Thread-Index: Adp1ZDWf7HpqPU0sQ4qKLvYIkzOi8g==
Date: Wed, 13 Mar 2024 16:35:30 +0000
Message-ID: <VI1PR03MB45250FAF3DB469286B0B7C038D2A2@VI1PR03MB4525.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_ActionId=12177d41-9453-4633-a60a-244875ef2e7c;
 MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_ContentBits=0;
 MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_Enabled=true;
 MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_Method=Standard;
 MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_Name=defa4170-0d19-0005-0004-bc88714345d2;
 MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_SetDate=2024-03-13T16:09:54Z;
 MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_SiteId=f9047108-cc2c-4e48-97a3-43fad1b3bf9d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rad.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR03MB4525:EE_|AM7PR03MB6231:EE_
x-ms-office365-filtering-correlation-id: b45d2bcf-3391-47a8-130c-08dc437b992b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AIIPcAsv56a3mQeoF0Nj9Gwm4aHgdH1+l/eKOVGY5YXv3w9bVkJ6v56DvBhlP9yhCLwwcvsgSFJgr9T0IJXmRXxGklcsYdNa9DqJA7bT1H7+KbBoxMouAg10ZyDM6/95m7KrdXrqDjl0IiIPUeiyV9OlcLc6Lh70wCFR+KZnCeFTcwPMXmQOT37ySn1zwWHmXMJfrK+JdjMYUpvlbvtgTFvIWLtqi3PNVxydC1OZpVhcjJAVn7PCPR3oeTJA3loaxAJKTspR7Gjeh8tRERYG/A+WSOoLnAv2x4kI5vCKeGeMjoyxAvGjUTjj1Vjfra9Ipw9HxCh84Ut8BZHPP7hR6z8tw7tPo8mt2RuG5E2D3Fl8mFtpFzlSnPh/mMamxipaG7+EgXP1Ddn75ucUhfMFeWuKFQ6zG64SwitTJjLERYsoRP2BpYTndVcTfSeOuXQ5BJ3tdERiKy4eJvW9ulvNImMxvrzIorQQCH7GRinqMhYdkdZDTTdH3N2JSpfQQk6ZSNW6NiifXLBFoOeHb2hOwUOL8i4BzKTvfgo3VULnRTnaCbbMZqMVkn9R76fSjRaRbxG/RTNIyv/XoAqPJA3u54PbxM2FipXWCTLW/RT1lzZkYoMyurK9FNKRapdY+XVl+Uai4ny51i7RiuQLRPH5Jpda0xwq20SZUgjYcLzzDL0yy3adOiytyVjlnNzir1QolWgtPkW/Df60PP/YHALRAQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR03MB4525.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzdJc010bnN5THNpbGdhNDZibHV6Yy9pd0pENW90MDVPNHhlM3ZCdjVWSE55?=
 =?utf-8?B?WkllUm5XZ05odnY3WkdYd2xCRUlLS3ViRUMrcWhJc0ZuS08zZmpwWm4wSCtn?=
 =?utf-8?B?YzNKb2JkTjQxL3FRNnFoYlViT3R2RG9Yd3ZvVnJXMmxEaE9xRWRjNzdkcFZa?=
 =?utf-8?B?RGtKcGhuTzFpckNEN01McWNlTVBxTGNZaXMwdStRR1FvUFc3T0tuL0JsTzg3?=
 =?utf-8?B?eFBkMmwzRWhDK1J1VVJHMmdMMjI4NlJnTFhXK1RENzhiVEZ4Z1JmS1psWjFh?=
 =?utf-8?B?dzNsOTZoUjNFUUpyVmZ3eUQ3by9KQUxQekhaOWc2ejRxRDBaNkRHbXJqZlZV?=
 =?utf-8?B?SmlZYUtvNGZlUHB6M1JhR0R2d01EK2pNNkI3V0RTbXcwYVJaamNEdTRFR2g3?=
 =?utf-8?B?N0V4UmlEWWRSdU1BOGhNM0Ric2l0eVZ6Zk5zNGZSM2plSTRSWEI5NkNQK2tp?=
 =?utf-8?B?bUpkRml3OHpneWUxL0ZWbjBDRW1jcU5zV2pQczJkMW14QU01RExMc3ZSbDVO?=
 =?utf-8?B?N2dWcnByWjV1eWkzTzF3ME4rbUZPWkxtandNYWZkLzZYTEo3QThvSklEeXFL?=
 =?utf-8?B?aXVFRmFIMzhaRk1Eb2c5UkI5M2JCZDZWd1RsWTA1cUJvYk9jQnFxMG5DU1FR?=
 =?utf-8?B?bXh6cmRrZ05Ba2c0eXNrZmVSREg3ZHU3dzFDMHBUQ0NGcThENlhUdTQrT280?=
 =?utf-8?B?UEhUS3RLWUJ2Z2IzTzVqaG1qTEp1d3Y0Nk16TG5ObGNjQ1JJSzBEV0lwNlpa?=
 =?utf-8?B?L21vNjlUZXdLcEE1K1BQZVJ4eWFHL2s0Nm01V0J2MktQNnFnbDZhOUlKNzYw?=
 =?utf-8?B?aVFSbGNMVjFUWGo3WEpNSyttOE04MWlrMHlzbHYyNG8yMjBZbGpRNVZ5Q3VO?=
 =?utf-8?B?SG4yZXdqK1AxQkQ3TDRkKzlGYy9aK2NpTlZ2UlZobnNLdER1TVA0M0VBZ0xv?=
 =?utf-8?B?U1psZ2twRmdQMWx2MFAybXBpVEVISkRmOVZkRUluVnFha0U4MEpyS2lPTzEv?=
 =?utf-8?B?WjN2RDNxUmVpQnNrVTJJNGxGUGFaNzc5QmlrZWV5bVptUzRpN2ljaElDZVBn?=
 =?utf-8?B?OXBNZEFvalZzQ0tKOVVrQ1YrNTdRdDFvTWFCSXYxM1cwVlJZTWZ4WlVURjFP?=
 =?utf-8?B?UFdLK3pIaTgwWkRpTlo2bXV2d1EyT09JOEJrRWRZUEphYmhEWitPdDUzenNJ?=
 =?utf-8?B?NklXK2l0MnRtOHE0NE96K2I0UDc1SHNZbjFmYzEzcDBNSFR2bkRTYjRQdUUv?=
 =?utf-8?B?Vllsbmd3MEREZXB6NCt3S0hNamFtOFZ5dTNQUHZwQ2lQVzVuK1NCU2lYL1hw?=
 =?utf-8?B?d3dRcE15T3JUNzdPR0oxSGQyeW8yZ2k1Q3o1aVpsNzEzTUtJcC8rb2JZays2?=
 =?utf-8?B?UHNFUWtnTjNkc01YTmI1dlMvMGNKdkhyQWk3Tkp4RVd0YmlacUNHQS9HT3Vr?=
 =?utf-8?B?OXltUDhBTnV2UUEyVlNBZFJtdTJ3RUs0cGc1blhIVkhlbWx1OTUrMnZLZUc3?=
 =?utf-8?B?V3BKKzhNWEgwWEs1aEJUT1RYTThOSUptMDFTS3B3a3hYZENRcmUwMVhQM29K?=
 =?utf-8?B?SERIVjRsdUM3WHBqb29IQStVSndRS1hzWXY1cnhJWUVqQ0kzWVJRNnEzclNu?=
 =?utf-8?B?dC80THNraUcrUWpVbGpTUjdwN2FZRGpOblNuUnFmQktUQ2FteFZMd3EvYTU2?=
 =?utf-8?B?SDZNcjRiU0JEK09FVjhBL2RNTDZmWVV3ZWwxamExTTE4UTQzOHZlcWpqMk1z?=
 =?utf-8?B?UTBPbFNSMHhnRHIydkVQUXdDbmloYVFJZnFJRkxsbzN1MnhGSVBvZXBhU2Qy?=
 =?utf-8?B?blVOL0NPRUllRWVYaHR6OHZSU3ZzRVJHTzhwZExVTGNSMHFrMWNzL2hnY041?=
 =?utf-8?B?T0JJUUptRVVXdksxelJ0eFhJUGpyZk9OUUNNOS9mUDVsbVpPOWNVYlU4bmVL?=
 =?utf-8?B?Q01SZUdNVFVyenRMQjMyVGczQ1Bpa0d2eVRDaEFScGc0NkNLeVdhUUFKMytM?=
 =?utf-8?B?d3JEM3lOZ1UvaWZzbXRvK2lxS3NkN1BwUlBHN3pHdmhyZnZnVTVZQVFyajFV?=
 =?utf-8?B?bUVtZ3c5R3dGZXdjZCtiUXkwR2pyRFQ4Z0xlUG5oQ3hFdU9zSVllcUxkWFZ2?=
 =?utf-8?Q?7b1A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: rad.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4525.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45d2bcf-3391-47a8-130c-08dc437b992b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 16:35:30.9327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f9047108-cc2c-4e48-97a3-43fad1b3bf9d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mtffgUJFAavqovlCI23CkGqxfdrQ1LmIlNO+o/ThnqSKWpqt+k/8f74D7mXg1V18
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6231
X-Mailman-Approved-At: Wed, 13 Mar 2024 17:45:05 +0100
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

SGkgTGlzdA0KT3VyIHByb2plY3QgYWxyZWFkeSBzZXZlcmFsIHllYXJzIGRldmVsb3AgZm9yIE1h
cnZlbGwgQXJtYWRhICAzNzIwIGJvYXJkDQoNClJlY2VudGx5IHdlIGRlY2lkZWQgdG8gaW1wbGVt
ZW50IHZlcmlmaWVkIGJvb3QuDQpJIG1vZGlmaWVkIHVib290IGNvbmZpZ3VyYXRpb24gdG8gc3Vw
cG9ydCBGSVQgaW1hZ2UgZm9ybWF0IGFuZCB2ZXJpZnkgc2lnbmF0dXJlIGtlcm5lbCAuIEkgY29t
cGlsZWQgdWJvb3QgYW5kIGFkZGVkIHB1YmxpYyBrZXkgdG8gdS1ib290LmJpbg0KSSBhbHNvIGNy
ZWF0ZWQgc2lnbmVkIGtlcm5lbCBpbWFnZSBhbmQgZW5zdXJlZCB3aXRoIGZpdF9jaGVja19zaWdu
ZWQgaXQgaW5kZWVkIHNpZ25lZC4NClRoZSBwcm9ibGVtIGlzIHRoYXQgTWFydmVsbCByZXF1aXJl
ZCB0byB1c2UgQVRGIHRvb2xzIGFuZCBBMzcwMCB1dGlscyB0byBwcm9kdWNlIGZsYXNoIGltYWdl
Lg0KSSBhcHBsaWVkIHNhbWUgY29tbWFuZCB0byBBVEYgdG8gbWFrZSBmbGFzaCBpbWFnZSBhcyB3
ZSB1c2VkIGJlZm9yZSBmb3Igbm9uLXZlcmlmaWVkIGJlZm9yZS4NCkFURiBtYWRlIGZsYXNoIGlt
YWdlIHdpdGggbm8gZ2xpdGNoLA0KQWZ0ZXIgdHJhbnNmZXJyaW5nIHJlc3VsdGluZyBmbGFzaCB0
byBib2FyZCwgIHUtYm9vdCBjb250aW51ZXMgdG8gYm9vdCBub24tc2lnbmVkIGtlcm5lbCBhbmQg
aW1pbmZvIGNvbW1hbmQgcmVwb3J0cyBlcnJvciDigJx1bmtub3duIGltYWdlIGZvcm1hdOKAnSBv
biB0aGUgbG9hZGVkIHNpZ25lZCBrZXJuZWwsIGkuZS4gaXQgZG9lcyBub3QgcmVjb2duaXplIEZJ
VCBwYXJ0aXRpb24uDQoNCkNhbiBhbnlvbmUgaGVscCBtZSBBU0FQPw0KUmVnYXJkcw0KTEVWDQo=
