Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D7AC67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 18:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DDAF87666;
	Tue,  9 Apr 2024 20:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=rad.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rad.com header.i=@rad.com header.b="Deo9veYp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91F478758B; Tue,  9 Apr 2024 20:55:22 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D24E877AF
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 20:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=rad.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lev_o@rad.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqEVO0Nc1HRJpK7wrHA/ajyppoHOL4JWMstfqHw/syR2qxONYocbo+AnbmBGIOMTNWXvrwrlejQwOnHQRotWbgu0qcQRYynvzmhRDga7OHk5n7+tfLJqLJZ8cyoolC2nxJsiLhc4OUwgti1cdasl6JFMq9emlLsrdG60lhI/p552YbINHU9JBxXqfVtE+zAE5Vy6M4DrW5J11jk1oWTrTBlNFEEH+XmwyIlRcagbKpmW10B3qOnCW22LRzP/Fb2Xdw3RLTc+xDe2QPElYuEgF+pDM50184lUihJK/OOVZQ30Q/kQwF2CNJT2qYqxHPqX4JpsxHuk1rj8fDcSsPhG/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qCVP+iB01kS3uTBCVRKgCMb3mImtkX98c7vpALpR0w=;
 b=GN4nv6sRl108pKJ/SpAisp2nBPFynR7N+YvwDi/dq01eo0iVAvKuVw3rfKsRPRg8ma3pt/wmc+8WwtbHhg4B9theHx/6mgI5vN+v7iK9DsycwbOMFnu2BpbdVH2yZv7wQj0lL5ydHrvdjyR5dHpJzdR+rmxLgakiTIZNv+6DSaN+uCQieCHQ3+KtcbxQbqYSVgxANtROFha0jiXdXvONkXi1TnXXJnl6kbmpEGUFGP5W/ziWztP278HUtZfR7w0b7XrmkTC3T5msTomADZj+BD09Tl5kJIo3fSfKkMuMQC8I4JXXL2jlske/EXjCjJoQVOuKBtTml9zBZRBHyowKXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rad.com; dmarc=pass action=none header.from=rad.com; dkim=pass
 header.d=rad.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rad.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qCVP+iB01kS3uTBCVRKgCMb3mImtkX98c7vpALpR0w=;
 b=Deo9veYpnIR3ZoEFHOel5Uv/w/nOF6wfTMFqCyl7QvJCDWs8l/Bz1hiw7VSEHRkna0PQsPLzFngyPDXsHkqeuzwrNGd7xcQ0RvLFlPoPLn8xS4qMi4cZR/f6UAPP3JNFvmZoZsIQ6WMZfRpn8LHxdUm5KnwoJtUm07Ws7YEMnSQ=
Received: from VI1PR03MB4525.eurprd03.prod.outlook.com (2603:10a6:803:61::24)
 by DB9PR03MB7402.eurprd03.prod.outlook.com (2603:10a6:10:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 18:55:18 +0000
Received: from VI1PR03MB4525.eurprd03.prod.outlook.com
 ([fe80::1aa3:47e2:3cd7:b66f]) by VI1PR03MB4525.eurprd03.prod.outlook.com
 ([fe80::1aa3:47e2:3cd7:b66f%4]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 18:55:18 +0000
From: Lev Olshvang <lev_o@rad.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: FIT image parameters question - kernel load address, entry point.
Thread-Topic: FIT image parameters question - kernel load address, entry point.
Thread-Index: AdqIFVJ7R20cerWETiGf9/G7vpFLqg==
Date: Tue, 9 Apr 2024 18:55:17 +0000
Message-ID: <VI1PR03MB4525A24D48BF5D9C450A57648D072@VI1PR03MB4525.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_ActionId=e13083e6-0f94-405c-a6b9-b99bcb45afb3;
 MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_ContentBits=0;
 MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_Enabled=true;
 MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_Method=Standard;
 MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_Name=defa4170-0d19-0005-0004-bc88714345d2;
 MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_SetDate=2024-04-06T11:25:37Z;
 MSIP_Label_4d4ac586-bf97-4fe2-b352-319616e2445d_SiteId=f9047108-cc2c-4e48-97a3-43fad1b3bf9d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR03MB4525:EE_|DB9PR03MB7402:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SMm0qbJh8fYBEzdGrKpO/OhgieZmpi5z2aHUcQy8LN2jKNcCEtZtu0CNFbKhXSqrs1CGpZPFR2fMtSfttzBx1lksZsIeRg4CH5DIQYJxSiKj93NOiZuvAa0uo3pzXDkRFc1sLNRjXPdiKjAimu1N6g/ULVrbs6ao/0W2ePyA3aUb6dVaQoIZED9FwaYy+Lq7rpZvRhV2yYh56++Rb47xMiqGmU0TdBQ+YvzBowz/M1UAxDFYWllmzUILokB7EDhjlOdf5Ldrtcfard7SsZsiqT26Rl45ZQ94FMXeGJP+0wMUuuHOGvrVcjXLnUCqTepwsclU5dPGUzhNdaUhZ6ZL9DPWuc/JDSuDj7DkgZ0edTf7B2W1q5HAzgwZpwICY/O14lSzxTGf7AoAB85NlHMVx0fGb9Phz0CmGtH2liQ+YzmYplq21FM5uZzQUkEG28MIAUmagBanctxOYcOWeWBgfmrODOvzclYOWg5NA1KqhvAC3u8g9ty2pNtfmQ7jcdKI3D3lKkBmbt81v1RWH3W7HLPsH2F8efn8zWr4nMSDI+7zZ/+lo27LcPKDfYbBUnsC/L/d9pEpsEA7ev2OhpqCpqpal0rS4W/BaN+u1LjPqxQOq1tzYOer1YJaKQbnQ076cP9IvyUMVhgxXSVGYtwUW8T96/WL+WKuIg5F0f/EbB0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR03MB4525.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZENRUzVnSDdET2VkczA4dHI3YkNNUzRvNnl1eHNPZ3hnMHZHOER4OUhwaVo2?=
 =?utf-8?B?QjE3ZVFTN1loYkYyNi9GYSszbHl0dkFYaTJCTEhRYld3WktNWUdqa0VlZmtI?=
 =?utf-8?B?YWdWajlYZjdrMnFYMnBrRXVpOHV5VFlsUDBpWnJUb0ZHTnB6Uzl4VkNIQzVK?=
 =?utf-8?B?bzZvejZLYmEycW5FK1FlblJFeEpEMUFsbE1mQ3YzNlZXMlVuSHVnWWxBZWM5?=
 =?utf-8?B?azFEWVppR2xtTFNGYW1qS09qenA1M1NRRFdtWGRZdEhXK1pNUzArKzA0Y1p0?=
 =?utf-8?B?NlBHdVA4Tlh3dktPQ3FmZHdGSm5YVnE5WUF1ZkxDYXNRTU1jd2RBd0FRTk00?=
 =?utf-8?B?dmNlQlFEZDlJeEVEZzZQSFhJRUtLZGhNV0RHNXNhYVJmVTUrRUIxTUh5Nmhj?=
 =?utf-8?B?U1RFRVIyOXhiRFNWTEkzVVpIWUhnNkVrR015MWxxRWozRFpqQk1qMEh0ZVQ0?=
 =?utf-8?B?SzFxNTVDd3YvbjhFT0RmS2lKR2RlMTE2TndpZGowM1hsZHhPUklBd3FoMFhr?=
 =?utf-8?B?K2xZbUxKbHBqakdzV0xhY3RWSFF3MGQxdWFmdVlZV2hpaC9wNVp3ZHBFajMv?=
 =?utf-8?B?R2Uzc21sZHd4T2lHc1JpUkZvRjcrZXF2RFk3T2xDK05VYTRIVHdld2YybEU5?=
 =?utf-8?B?RjBrMmRMakNVb3hjS0pjVXNIKzFUUFdQNGtBd2RIc2RNSmQ5UVBRK01xTjZm?=
 =?utf-8?B?Rm9DRFJYS3JHa1QvVVZuU1IraFNlTFptQk1lWGlldEd1WStBSGpBWEFoUHlR?=
 =?utf-8?B?Qm9DVHpBVWdWMGl5UjlPTUgwT0NqVXFoTGFjbmhHZlV6UC9MMkxXOFR6Nmdz?=
 =?utf-8?B?SHJjeUYwL1B0akVobk5Dc2ZobnE0c0lhRmx4M3FNY25xTjVzRjFRNHJsdlBo?=
 =?utf-8?B?UWxrd01oQUNFMjJlbWJDdGxGTTMvOHBVWGZuUmNKT2tlckk2dVR5dGx1THBJ?=
 =?utf-8?B?M3FDTWVzdGxJOWhhRUVaRklDdjVzMDdFZ29yczBpRzZSNDVxYkk5aDFWdTd4?=
 =?utf-8?B?eEdRMzRrd3VuM1N2VWdBN2pFNG1jOS9icFUrdnc5L3N1djYwTkhiY1hZVEk2?=
 =?utf-8?B?a0dwbnpmcU42a2RHV3pZMlp0L0Vjc2FDWmg5QXJiZWY1cXlMd2dDbk9YRzNJ?=
 =?utf-8?B?VWpsT0FYVUQzbGRWNVNPTTlNNzlZOFBMZmdkSEVZMVNCbTJGaEpIVWlGeTdY?=
 =?utf-8?B?UUpZVzZIRW9YUENrTmZqVXJ0QncwU1JQZ3g4cW1OY01waXVHLzZTTGJielZE?=
 =?utf-8?B?S25GTDFucStKVisrSzAyNUNCQ0h1S2JxMytzK0NtRG10L1FOekdrSTNHNTR2?=
 =?utf-8?B?Ym81M2pXN0tVZ05nbzhSRTdWS3N0TGhYd0RTaE42ZjBpTmNoVkdsT3p5OC9F?=
 =?utf-8?B?ZWNPeGI2U3E4RjYzU1NSMmNVQ2E2ZWViWnFUR2FsVHdYYTFVQjMzSTl5VW5n?=
 =?utf-8?B?ZUNJUXNodTBZOERZZmwyNmNsMjJrb20zVkVXOGdId2xmN3RLMlZwRklVNksv?=
 =?utf-8?B?MlhuTStIamJ3V0VtcVBmWmVkbkJHNzcxM0R6S3ZjdG9YNGdXZXFKRDVXeGVV?=
 =?utf-8?B?cTRHRURFYUVqZ2QxeUR5UjR5NEV4K2hxYTNXeWY3aHBhV0NUQ05SSXJORkJ0?=
 =?utf-8?B?dzh3SXc2MTM3UEJCWnZFMDVqR1hDNitseENlb3M4Z3FObm52ajdLVms5ZlNX?=
 =?utf-8?B?YU1yWUtEVWVvdStKZXZqNnlsMjN2eGdkWmx3c0xZUWNYcjBoOGdDWUtlWFNp?=
 =?utf-8?B?QzU0Wi9RZzA0WEhnTW5FS0JNM0pNWXlNdzg1UWJXZWpURGU4NTRXdkJOTHJz?=
 =?utf-8?B?TWo5Z1FxbHEvNnZlckIzMXJaY3BPbEoxTjJTMU90dnpXVkx2WmVEdTZKMjU4?=
 =?utf-8?B?UUtldjVySVViNHB6enZZWHdHMUFVb3hWd05XWXhrWlo3d0kvQjcvRWVGMGhP?=
 =?utf-8?B?RUZGZStNdVlLR1pZdEE4Vi9WNlloUnR6RmFGamY3NjhwK0dhSDQ4azlTZGdx?=
 =?utf-8?B?N05RL1lwWCtXWFo5TjlHcWVuWkpXcnk3THBnbXdVZU52QUNuSVo0dEw4ZnFa?=
 =?utf-8?B?SDNUL3JxaHZEaG9KYTRNSGlXcCttdFlwSTdiSTRzRERleHVQSkpGaWUyNmh5?=
 =?utf-8?B?S2RoSTFWZVFSZUM3Z253ZnMzUTJMN2dQN3dWNlB2YmhES2hqOXBuNGVTOEZX?=
 =?utf-8?Q?sj/2055MhRPn6rWvtPF+mkc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: rad.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4525.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977b6cc5-cf88-4761-579f-08dc58c6995f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 18:55:17.9601 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f9047108-cc2c-4e48-97a3-43fad1b3bf9d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 60ZOkpZtAQcAEVRz8AOuVt+m+n15WGLrMQv6a1fNFaaqGt5TwH1L5IDBWRkSYiIw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7402
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

SGkgTGlzdCwNCg0KTXkgYm9hcmQgLSBBcm1hZGEgMzcyMCBFeHByZXNzb2JpbiBleHRlbmRlZCB3
aXRoIG1hcnZlbGwgc3dpdGNoIGFuZCBjb3VwbGUgb2Ygb3RoZXIgbmV0d29yayBpbnRlcmZhY2Vz
LCAgcnVubmluZyBMaW51eCA0LjE5DQoNCk91ciBwbGF0Zm9ybSBoYXMgMkdCIFJBTSwNClRJTS0x
LjANCldUTUktYXJtYWRhLTE3LjEwLjUtN2RlMzU3Mg0KV1RNSTogc3lzdGVtIGVhcmx5LWluaXQN
Cg0KRERSIHRvcG9sb2d5IHBhcmFtZXRlcnM6DQo9PT09PT09PT09PT09PT09PT09PT09PT0NCmRk
ciB0eXBlICAgICAgICAgICAgICAgRERSMw0KZGRyIHNwZWVkYmluICAgICAgICAgICAxMg0KYnVz
IHdpZHRoICAgICAgICAgICAgICAxNi1iaXRzDQpjcyBudW0gICAgICAgICAgICAgICAgIDINCiAg
Y3NbMF0gLSBncm91cCBudW0gICAgMA0KICBjc1swXSAtIGJhbmsgbnVtICAgICA4DQogIGNzWzBd
IC0gY2FwYWNpdHkgICAgIDEwMjRNaUINCiAgY3NbMV0gLSBncm91cCBudW0gICAgMA0KICBjc1sx
XSAtIGJhbmsgbnVtICAgICA4DQogIGNzWzFdIC0gY2FwYWNpdHkgICAgIDEwMjRNaUINClNWQyBS
RVY6IDUsIENQVSBWREQgdm9sdGFnZTogMS4xNDNWDQoNCkRSQU0gd2luZG93czoNCj09PT09PT09
PT09PT0NCldJTlswXSAtIGJhc2UgYWRkciAgICAgMHg2MDAwMDAwMA0KV0lOWzBdIC0gc2l6ZSAg
ICAgICAgICAweDQwMDAwMDAwDQpXSU5bMV0gLSBiYXNlIGFkZHIgICAgIDB4YTAwMDAwMDANCldJ
TlsxXSAtIHNpemUgICAgICAgICAgMHgyMDAwMDAwMA0KDQo9PT09PT09PT09PT09PT09PT09IA0K
DQpSZWNlbnRseSBJIHNwZW50IHNldmVyYWwgZGF5cyB0cnlpbmcgdG8gZmlndXJlIG91dCB3aGF0
IGtlcm5lbCBsb2FkIGFkZHJlc3MgYW5kIGVudHJ5IHBvaW50IHRvIHVzZSBhcyAgRklUIGltYWdl
IHBhcmFtZXRlcnMuDQoNCkkgc3RhcnRlZCBieSAgYWRkaW5nIHByaW50ayB0byBhcmNoL2FybTY0
L21tL21tdS5jOjQzNiBhbmQgIGdvdCBrZXJuZWwgc3RhcnQgYWRkcmVzcyAweDgwMDAwIHdoZW4g
Ym9hcmQgd2FzIGJvb3RlZCBmcm9tIC9ib290L0ltYWdlDQoNCkkgdGhlbiBwdXQgRklUIGltYWdl
IGludG8gbWVtb3J5IDB4NTAwMDAwIGFuZCBhcHBsaWVkIGJvb3RtICB3aXRoIGEgc2luZ2xlIGFy
Z3VtZW50IC0gYm9vdG0gIDB4NTAwMDAwMA0KVWJvb3Qgc3VjY2Vzc2Z1bGx5IHZlcmlmaWVkIHNp
Z25hdHVyZSBidXQgZnJlZXplIGFmdGVyIG1lc3NhZ2VzDQo+ICAgIExvYWRpbmcgS2VybmVsIElt
YWdlIC4uLiBPSw0KPiAgICBVc2luZyBEZXZpY2UgVHJlZSBpbiBwbGFjZSBhdCAwMDAwMDAwMDA0
ZjAwMDAwLCBlbmQgDQo+IDAwMDAwMDAwMDRmMDVjN2UNCj4NCj4gU3RhcnRpbmcga2VybmVsIC4u
Lg0KDQpLZXJuZWwgaXMgY29tcGlsZWQgd2l0aCBSRUxPQ0FUQUJMRSBjb25maWcgb24sDQpTb21l
IHVib290IHNwZWNpYWxpc3RzIG1ha2UgY2xhaW0gdGhhdCB0aGUgbWVtb3J5IGlzIGNvcnJ1cHRl
ZCwgYnV0IHRoZXJlIGFyZSBubyBvdGhlciBydW5uaW5nIGFjdG9ycw0KDQpTbyBJIHJldHVybiB0
byBteSBxdWVzdGlvbnMgOg0KUXVlc3Rpb24gMS4gV2hhdCBpcyB0aGUgbWFnaWMsIGhvdyBsb2Fk
IGFkZHJlc3MgYW5kIGVudHJ5IGNvdWxkIGJlIGZpZ3VyZWQgPw0KICAgICAgICAgICAgICAgICAg
ICAgIEkgdHJpZWQgbW9yZSB0aGVuIDIwIGRpZmZlcmVudCBhZGRyZXNzZXMgdG8gbm8gc3VjY2Vz
cywgZXhjZXB0IHRoZXQgc29tZSBhZGRyZXNzZXMgaW1tZWRpYXRlbHkgcmVzZXQgYm9hcmQNClF1
ZXN0aW9uIDIuIFdoYXQgc2hvdWxkIEkgY2hvb3NlIGFzIGxvYWQgZmR0IGFkZHJlc3M/DQpRdWVz
dGlvbiAzLiBPbiB3aGF0IGFkZHJlc3MgRklUIGltYWdlIHNob3VsZCBiZSBsb2FkZWQsIEkgbG9h
ZCBpdCB3aXRoIHRmdHAgY29tbWFuZD8NClF1ZXN0aW9uIDQuIFdoYXQgZm9ybSBvZiBib290bSBj
b21tYW5kIHRvIHVzZTsgY2F1c2UgYm9vdG0gbWF5IGFjY2VwdCAzIHBhcmFtZXRlcnMNCiAgICAg
ICAgICAgICAgICAgIChmb3J0dW5hdGVseSBJVSBkbyBub3QgaGF2ZSBpbml0cmQpDQpRdWVzdGlv
biA1LiBJIGNjb25mdXNlZCBieSBEUkFNIHdpbmRvd3MgYmFzZSBhZGRkciAmIHNpemUgdGhhdCB1
Ym9vdCByZXBvcnRzIChzZWUgMzAgbGluZXMgYWJvdmUpDQogICAgICAgICAgICAgICAgICAgICAg
U2hvdWxkIEkganVzdCBpZ25vcmUgaXQsIGNhdXNlIGhpZ2hlciB1cCBJIHNlZSAyIGJhbmtzIG9m
IDFHQiBlYWNoIGFuZCBJIGFtIE9LIHdpdGggSXQuDQo=
