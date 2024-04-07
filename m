Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74275CD128A
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 00:46:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B669F87DAB;
	Mon,  8 Apr 2024 02:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=rad.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rad.com header.i=@rad.com header.b="taLN04NO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47E9D87E1D; Sun,  7 Apr 2024 17:52:58 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45C1487ABC
 for <u-boot@lists.denx.de>; Sun,  7 Apr 2024 17:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=rad.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lev_o@rad.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrJ/O5yPOdrnKzfJVPWaOXlCFDHvFWtiIvwzVPmlhUgn9siDnflnRbUd91wsj2TZBtUizK7iKDk2nRGwXgTLRAA/noiZakM0PQpIRAR1GvL4NjZBVEW5k6BISPqGNt94BE1S+VeWOVlNmZ8aoygbp8YK7UeQI231AUjfVIvK7ub6xBOh5QGZ1lheAVyKltoHHH09ICLQREzo1LyGlzDvHJXP7IvjKMWwmdd9sf9g3oZ0VMQThgis/va6Ti0BGFoINWD64TSiWAYItgPZt8E6k10MstSFGpJ9SIZpuPBImfxeUrfLtBpFNZhWm3LMsOXnlfJ6iqwmcyB30QF0r1EpNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lb8YdwxGsokqty4o9EhFBj8lRM5dPXTtQQ5xh7KwNL0=;
 b=fTdYMCnk2Dyv/utee7KiEERw0DVmRBxRGjvXW48b+imb+W6Dk1ngohEoJs2Fx1fUL+1X1fW9q5mfuHP9GP5VCJcTZhRlAiepNlPt6cH8+ftDebQvHCwryoeon6AfXJASikhj6yugdAOasEO2LhYAnIRevvHe/xpWBbOOAS9Tyt7TUhgHLN1qkWh0qUZGHqIPe4phghQlfbLn1Y2xDTUFRJxEWYo5PEwwDkOicE88cIyxPz0Ykd47+9cIeCsJAqsbBdNT7q+zGZENv9JGnBhgviZoSxFwJ/ZeIgMmifYA8/uFiPY6ce08BRBbfEdlen7TTaMq9oti/+QxOE5CVomaPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rad.com; dmarc=pass action=none header.from=rad.com; dkim=pass
 header.d=rad.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rad.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lb8YdwxGsokqty4o9EhFBj8lRM5dPXTtQQ5xh7KwNL0=;
 b=taLN04NO4s7dJASiBaCM18NUHnAnfyemW6SFEXmXlenuyJZXrD/Ej7muAoGHTt1R406Ai9HjQSnAxoZyHwLXk76GR9vBPWogSI9tJQ0c9Lu5B+WKLd47f0JwnE8Xf1uvAvGrsS52Fs2lUmB4Q23TvGcRwr0MUZWkkeoiXUUGqjE=
Received: from VI1PR03MB4525.eurprd03.prod.outlook.com (2603:10a6:803:61::24)
 by PAVPR03MB9384.eurprd03.prod.outlook.com (2603:10a6:102:307::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 15:52:53 +0000
Received: from VI1PR03MB4525.eurprd03.prod.outlook.com
 ([fe80::1aa3:47e2:3cd7:b66f]) by VI1PR03MB4525.eurprd03.prod.outlook.com
 ([fe80::1aa3:47e2:3cd7:b66f%4]) with mapi id 15.20.7409.053; Sun, 7 Apr 2024
 15:52:52 +0000
From: Lev Olshvang <lev_o@rad.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Armada 3720 alike Board - no PHY devices found by mii info, no ping
Thread-Topic: Armada 3720 alike Board - no PHY devices found by mii info, no
 ping
Thread-Index: AdqJA4xCfksNZ8fqTkKSmP8i3JWo/w==
Date: Sun, 7 Apr 2024 15:52:52 +0000
Message-ID: <VI1PR03MB45252BDD2DD30D08A4172CA08D012@VI1PR03MB4525.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_ActionId=771b5951-a571-4b76-8030-c7fc54bb55a0;
 MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_ContentBits=0;
 MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_Enabled=true;
 MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_Method=Standard;
 MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_Name=defa4170-0d19-0005-0004-bc88714345d2;
 MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_SetDate=2024-04-07T15:22:59Z;
 MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_SiteId=f9047108-cc2c-4e48-97a3-43fad1b3bf9d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR03MB4525:EE_|PAVPR03MB9384:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6PtXEoB3fZhgANYA/wolavPev8cX2ByTEs2qajGsmpfbyLknLTC8j+iZXohEaJXdtbX5XWgn+2ttz6ib41Hb38RnPb+2qNGm8nFeiCi+7Zi813BFbjmn+gfmhOdnoZINQVX+rP938iDjHv/QfJbiQUAuwvPEMg9Qq1goUbhhN3nQjGnmWCXliiFMERSTTo7r9b2SxH35m1TcmX00wLHLIKhYrI41W0BN+IkLp+RH/wJDJ3IUcn+rm9Oy8vnmPQHzhYRimS9J1sba94njrpN5nBcU/sjOuUDgPyc9kfTgsLqwbK1B/ed5Sa6YCasAxrt5etnGEE51DpplL57T42HaXFGtHvGdpiRoy0BsEZYSgSEvxR9hkFUtVxvkN9rNJzd4ajEXFCsTAynm9gTmswlXDiDGt+nDcxpO7GqcvR/VHRdS91cazY0pSquy6r9D2HFFN+MXkah9gJrhcThOxD9q3VWIuPZAlaJyucDJ9YX6J47NtzzHdrKXc8rsv4N4t3kLiFnXKt427DQYPT/GHhsJEcbiifFVNKs4/tdfsvcJgKisu5VlAWjbtrYtpznXX2kfio0vWRL1pFSxNRvIHkXWkc0jMUWhDLCwFTQt5rPaQ14W71Ga6We3JO14B3W/UuvJffHaMYB/ODR1gfGDNOWE/g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR03MB4525.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXgwM2hxdHY2TWVCakg3YWNtVEE4aFdPZkl3SEgvTE53blpIc0VCWVpScys5?=
 =?utf-8?B?T2gvQjJBMTVOWHNIbWlhZm5mSnRXNnZEU21rQ3dVTHZlQ1VZYkUzUjF5OHhV?=
 =?utf-8?B?anc2RDBrTXFyT0szV3luYnhIZFVOeFNyc0RZbVlBWFlrWGxRamR6MWxRRXVJ?=
 =?utf-8?B?c25yTGt6NnpqdTlJL1N3WkMzVU90TWlBNFA5cWk2ZmJpOEZwUVZMcVM5eGVy?=
 =?utf-8?B?L0x1a1lyZU8zMzhPOTBDWnc4QkwzVzZOWWZtT0ZhY2VKOXA4OStGTUI5SXBH?=
 =?utf-8?B?WEFiMlBEMVd4SkRQREJBRko2Si9WUnZ5UlcwSE9MQXRiQ0JQdVRVU0JSTDA4?=
 =?utf-8?B?a2NBWDJXSGRVQlc3djFNRHNhbElVWmJLVGJpZGFVMGQwb015cDRTQWJnK2M0?=
 =?utf-8?B?RXovL3VnMDRQaHZtS0VJTTIzTjZ6S09RcHRiakkrZ0NTSmFoMTQ5Z3oyNDhX?=
 =?utf-8?B?SGI4cFJpaEQ4dzZxRURUTERvaTBBTTVheXFGdUJ4VU45RDZnVU9paGtNcTI3?=
 =?utf-8?B?QXlHT0VNRmo3V0hVek9idGdvSnNIQjAybnhlTkZQdGljeXl6V3JRUEFwUFgr?=
 =?utf-8?B?dE9iTm45dmpFVHpwc3BiM3ZmS1FZMk1BeXhRMSt1NXlOTjYrUXREd2Y1eWth?=
 =?utf-8?B?Vm1mbVp6ZVA3TTB3QmJNV3FaeUR1ZFBmR0k3M3Z4eXMxK0grbHpCakNRNG5O?=
 =?utf-8?B?ZXAvNEg5cmc3bDNBUHFlcFhQazlaUDgwaC9LL0tFNFo0cnFRMjN5TnhuTHBt?=
 =?utf-8?B?VWgySkVSRVQ4UEtvdEVMQXFzSHc2bjZwTHV3QjNNZ1QzcnhSUWVuOVlNTEFX?=
 =?utf-8?B?aG1aOVRRcVBoTkY0enFSVFRjU256a2lJQVU0eEg1MFEySGVKYjlQNk54bFZr?=
 =?utf-8?B?MUZRUHozdXg2cTJsZm5wZU9NZjhaK1NzSTBPS2xKbkhaY2swRldxWkRGTDRq?=
 =?utf-8?B?d1FHalRTTkJWL25ZeGhGUWJvQmdVd0oxVnpIdXRIejlHZVphVG10NTJIb3ht?=
 =?utf-8?B?dlFXSGpVU0hwVkUySFFWK0E0Rm5VdXNuZ0x2Z1pmL0dqZHdoK1Y1eFdOVXNn?=
 =?utf-8?B?REZ1TUFVTmI3U0lCTjFhL0NRVEJKVGRJZlBHdUwvM250RnJvMys4Y0oyM255?=
 =?utf-8?B?UlBERWZRY0g3by9kb1V1clhOMDZnb0ZyUkw4WUE4M096WmxuQXBWZEZ0dU80?=
 =?utf-8?B?M2lkY2NjWnhZVkVHNlZDcGNvbUR0TUNiTE1taE9zVVpKYUJ5SXY1TllBZkcx?=
 =?utf-8?B?bjhzbzlDNUpIajZydm5nR2R1eGZ6TmhwMngvUzVyK2RBeFpvdnMyRmlpQTNL?=
 =?utf-8?B?MGRERmcyaElKUGo2Y0RZNUVKbGU3VDBKdjM5T2NuV3dVRUo3QnllOVdJMFN5?=
 =?utf-8?B?aHNmOEt3L3RmWFd4K2p4UEoxNjJsSE0xNzN3bUFxZVpiWDNzSUFIR1RTODhI?=
 =?utf-8?B?a0VzNWJWMmsxdE13TU9hWENBMEtCdVdRRDRJcmsrSHBJcjhVK3BuWFFTRFky?=
 =?utf-8?B?VnFNcVBkc09LeTBZS25xMm1RK0pXeG9kRGlibTQ1UTN3MnJOdzJ1Wmg5ZjBq?=
 =?utf-8?B?NExBL0JBaVd4OTBSdTRCN3M0LzVrNDVpS1QwdnlnYUE5dllES3JiRFJ5N2p6?=
 =?utf-8?B?emRBMEE3M2V2MW8vQ09wS3pxa2RBMkJVNndaczNQc0ppdTRGcm5NcXlaV0hn?=
 =?utf-8?B?eDhuWFpMZFVUM3lTbGpWbWF4R2ZaYlFvbVE3VDdkRG5Qa1lFOWx0aW9xRDVD?=
 =?utf-8?B?azkxQTVPUC96ejJFUDdJdTlWTDZscUFnakdEZ2xqS3p6dkhLVjNNaEdnQmNW?=
 =?utf-8?B?c0RUVHJmbkE4Z1MrRUcxS0xWU3YybkE0QlR1cXd3aGRsTUhDbmVNSVNKVkRL?=
 =?utf-8?B?VEJzVUQ0NzVqSGRXMnl0U1UrejFWZ0xKNGRwZzVnNjNBM2MzUkcwZDkwWERH?=
 =?utf-8?B?Y1JBb2JlU3JsYUtwa01LOTIrbDVPRTEzam9xR1c5V2oxanVtSXpDcEg2Ynpp?=
 =?utf-8?B?WnArbWhZck9INDlRbUxiRXQ2VWJxTTJDbnFDWHhsSG5SOEV3S3FFZTRGekRq?=
 =?utf-8?B?ckM0NmI1eGFwdi9KbjFpWUZSWUZHUFEyRWhOTFpBc2pEWnNaRjZtcHd1TTNT?=
 =?utf-8?Q?WENA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: rad.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4525.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc6eeda-ec38-47d8-0b09-08dc571ac89d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 15:52:52.6065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f9047108-cc2c-4e48-97a3-43fad1b3bf9d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xbttda4atCrBhbM4nkeGfJ78Vy4PLjaYu4lweTzzH6HRshbGRhzQv4vCYBgFcyL6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9384
X-Mailman-Approved-At: Mon, 08 Apr 2024 02:46:51 +0200
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

SGVsbG8gbGlzdCwNCg0KSSB3b3JrIHdpdGggYSB2YXJpYW50IG9mIE1hcnZlbGwgQXJtYWRhIDM3
MjAgYm9hcmQuDQpSZWNlbnRseSBJIHVwZ3JhZGUgVWJvb3QgdmVyc2lvbiBmcm9tIDIwMTcgdG8g
MjAyMy4wNy4NCkFzIGEgcmVzdWx0IFBJTkcgY29tbWFuZCBmYWlsZWQNCk9yaWdpbmFsIHZlcnNp
b24gb2YgMjAxNyByZXBvcnRzIG9uIG1paSBpbmZvIGNvbW1hbmQNClBDUEU+PiBtaWkgaW5mbw0K
ICAgIFBIWSAweDAxOiBPVUkgPSAweDVBOTg1LCBNb2RlbCA9IDB4MkEsIFJldiA9IDB4MDYsIDEw
MGJhc2VULCBIRFgNCldoaWxzdCBteSBuZXcgMjAyMyBjYW4gbm90IGZpbmQgUEhZIGRldmljZXMN
Cg0KSSBtYWRlIG1pbmltYWwgY2hhbmdlcyB0byBjb25maWd1cmF0aW9uICBhbmQgRGV2aWNlIHRy
ZWUgZmlsZXMuDQpDb21waWxhdGlvbiBwYXNzZWQsIEkgbG9hZGVkIFVib290IHVzaW5nIFVhcnQg
YW5kIGl0IHN1Y2Nlc3NmdWxseSByZWFjaGVkIFBDUEUgcHJvbXB0DQpTbyBJIHRyaWVkIHRvIHRl
c3QgbmV0d29yayAuDQpQaW5nIGNvcnJlY3RseSByZXBvcnRzIGl0IHVzZXMgIGV0aDFAbmV0YTQw
MDAwIGFzIG91dHB1dCBpbnRlcmZhY2UgKGV4YWN0bHkgYXMgIHYyMDE3IGRvZXMpLA0KYnV0IHBp
bmcgZmFpbGVkDQogDQpJIGRpZCBub3QgdG91Y2ggYXQgYWxsIFBIWSBhbmQgZXRoZXJuZXQgcmVs
YXRlZCBkZWZpbml0aW9ucywgbGVhdmluZyB0aGVtIGV4YWN0bHkgYXMgaXQgd2FzLg0KDQpQbGVh
c2UgYWR2aXNlIHdoYXQgdG8gbG9vayBmb3IuDQoNCkkgZG8gbm90IGtub3cgaG93IHRvIHNlbmQg
ZnVsbCBEVFMgZmlsZSB0byBsaXN0LCBwbGVhc2UgaW5zdHJ1Y3QgbWUuDQpNZWFud2hpbGUgSSBk
byBjb3B5LXBhc3RlLg0KSGVyZSBzbmlwcGVkIG9mIERUU0kgZmlsZQ0KLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogICAgY29tcGh5OiBjb21waHlAMTgz
MDAgew0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm1hcnZl
bGwsbXZlYnUtY29tcGh5IiwgIm1hcnZlbGwsY29tcGh5LWFybWFkYS0zNzAwIjsNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MTgzMDAgMHgyOD4sDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwweDFmMzAwIDB4M2QwMDA+Ow0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBtdXgtYml0Y291bnQgPSA8ND47DQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIG1heC1sYW5lcyA9IDwzPjsNCiAgICAgICAgICAgICAgICAgICAg
ICAgIH07DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KSGVyZSB0aGUgcmVs
ZXZhbnQgcGFydCBvZiBEVFMgZmlsZToNCiZjb21waHkgew0KICAgICAgICBwaHkwIHsNCiAgICAg
ICAgICAgICAgICBwaHktdHlwZSA9IDxDT01QSFlfVFlQRV9TR01JSTE+Ow0KICAgICAgICAgICAg
ICAgIHBoeS1zcGVlZCA9IDxDT01QSFlfU1BFRURfMV8yNUc+Ow0KICAgICAgICB9Ow0KDQogICAg
ICAgIHBoeTEgew0KICAgICAgICAgICAgICAgIHBoeS10eXBlID0gPENPTVBIWV9UWVBFX1BFWDA+
Ow0KICAgICAgICAgICAgICAgIHBoeS1zcGVlZCA9IDxDT01QSFlfU1BFRURfMl81Rz47DQogICAg
ICAgIH07DQoNCiAgICAgICAgcGh5MiB7DQogICAgICAgICAgICAgICAgcGh5LXR5cGUgPSA8Q09N
UEhZX1RZUEVfVVNCM19IT1NUMD47DQogICAgICAgICAgICAgICAgcGh5LXNwZWVkID0gPENPTVBI
WV9TUEVFRF81Rz47DQogICAgICAgIH07DQp9Ow0KDQomZXRoMCB7DQogICAgICAgIHN0YXR1cyA9
ICJva2F5IjsNCiAgICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCiAgICAgICAgcGlu
Y3RybC0wID0gPCZyZ21paV9waW5zPiwgPCZzbWlfcGlucz47DQogICAgICAgIHBoeS1tb2RlID0g
InJnbWlpIjsNCiAgICAgICAgcGh5X2FkZHIgPSA8MHgyPjsNCiAgICAgICAgZml4ZWQtbGluayB7
DQogICAgICAgICAgICAgICAgc3BlZWQgPSA8MTAwMD47DQogICAgICAgICAgICAgICAgZnVsbC1k
dXBsZXg7DQogICAgICAgIH07DQp9Ow0KDQomZXRoMSB7DQogICAgICAgIHN0YXR1cyA9ICJva2F5
IjsNCiAgICAgICAgcGh5LW1vZGUgPSAic2dtaWkiOw0KICAgICAgICBwaHlfYWRkciA9IDwweDE+
Ow0KICAgICAgICBmaXhlZC1saW5rIHsNCiAgICAgICAgICAgICAgICBzcGVlZCA9IDwxMDAwPjsN
CiAgICAgICAgICAgICAgICBmdWxsLWR1cGxleDsNCiAgICAgICAgfTsNCn07DQoNCkFuZCBoZXJl
IHNuaXBwZXQgb2YgRFRTSSBmaWxlIDoNCg0KIA0K
