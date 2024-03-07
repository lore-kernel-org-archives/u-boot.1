Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF73C54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 14:56:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B10B387F59;
	Thu,  7 Mar 2024 15:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=cinemo.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=cinemo0.onmicrosoft.com header.i=@cinemo0.onmicrosoft.com header.b="i2wIV7FA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14FFC87E92; Thu,  7 Mar 2024 12:22:43 +0100 (CET)
Received: from DEU01-FR2-obe.outbound.protection.outlook.com
 (mail-fr2deu01on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2623::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78AF487DC1
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 12:22:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=cinemo.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vjaiswal@cinemo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWxM/wPVU+3krEWcoMC3IVGarXiJHGyZ5h9u8uIDDUVMo181I5+teNWJP6AArlsAfRhoax75lDZlP+/wRWOvQ7ffpozR9ziJs960Rb1KE1NHR83wHpEIyLsRaWcdMVhro3lIKYHgutmMC4JLj069M24WcZFZmrkNIln/XFwRenYBmazm+KDJQ/6MPA2zbtLI9DMx+6R5kot5lVOS4VA1YsoHJ1ICwP65U9pSg5EepI846Mj3SSdNcucXZM9Tmx265SPM9UYuFucog/lX/uO/CHym9lzVVsXN/HrGL3X411Zzr6pvmJQ5Q0GiwFQ88HEzaX5HTpUYIQW7y2EyijK+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92jtv3VrKGvz6WFk2XbMJDaBTVRk/yFlMH5iqCJtiK8=;
 b=JDSJUXBzz0hQylzO/od8CYS2iRlSWyqjNy8zHkJXU8Udlj/belGw6H0uJuHPfRaBe2HFz6ho+sUkf7JgKJQ49AsLT7PnO93LMX1nBY2k+lUzW9fi6roiz8KHLxD/uHNlji25hvYbuAv7feJAcmn3pNIkgKAx8jmSadkhIkTEZj+yPnDj9zP+B+WAnidndSBB5Qq0UudnGxqsd8eQoYc6PKDw4VsLVNIi7KVVuGDOPbiq7uxpjfrXYfZpLzv+wgC3o8dSgiX5i1fp6CN97UQrF6RAfqedm/Q3myh5zaFG3i3EUKbHZYq4yPcy3Bf7whqoB5WQH1imyyrjzMbUYYb1uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cinemo.com; dmarc=pass action=none header.from=cinemo.com;
 dkim=pass header.d=cinemo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cinemo0.onmicrosoft.com; s=selector1-cinemo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92jtv3VrKGvz6WFk2XbMJDaBTVRk/yFlMH5iqCJtiK8=;
 b=i2wIV7FAMdvIHpu/p09Pecv19AQ8efu4FjKnTErf9Ow5/AawwnWNLDvr9Lhr0Ku4iJ3oi27dUnGGNfioe/Jucg6/BbYDyRQw0i44vGOHALE4oSGPXHLuGxz1eYyRMRTyy2qhHWk5EKj2qDtwOVMoYj+EQNNwY7jdWOJvmGhqj8k=
Received: from BEZP281MB2965.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:2e::6) by
 FR3P281MB1695.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6c::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.24; Thu, 7 Mar 2024 11:22:38 +0000
Received: from BEZP281MB2965.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7ec3:6650:f2e5:86fa]) by BEZP281MB2965.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7ec3:6650:f2e5:86fa%4]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 11:22:38 +0000
From: Vivek Jaiswal <vjaiswal@cinemo.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: U-boot fails for khadas-edge -v 
Thread-Topic: U-boot fails for khadas-edge -v 
Thread-Index: AQHacIAKth58IDIIyk62Zj6csqiUFQ==
Date: Thu, 7 Mar 2024 11:22:38 +0000
Message-ID: <BEZP281MB29655E047444C987850ED632AB202@BEZP281MB2965.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cinemo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2965:EE_|FR3P281MB1695:EE_
x-ms-office365-filtering-correlation-id: 9193c08e-0762-4a13-28ff-08dc3e98e546
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8QJcR2wUyokrr3689kks3QEswiyQ1xoxx4DqwWH4oLBqqMxyxJrytUDkJs4roXBp21uCgXdJfwRK/d9eFfl0o9/wErb9i7CsrnNJ95SK41GS2BUG/FnR5BKgZBNMcH0Kl4WHIK+/pt82j+DxEmoM7GEwvSobtUoLF5tCHP/Cz8snZlq38FxvSuytIITHG4PlhGvDf3NjMP5FtwDhkUQfPW7fcaTyIzTMFGTq9P5uxjjGCtS2WigZr3sGBn1FSEMvoMFjlyvyNmtPtMyaywe+cUYoQNxGws+EZZmsKWtJbUx0QZUVL1ppNnOonUfKZfAEFIFqczCHxfawpWXc/PTlb3RoCjIh8eknOP2D5kPs2WwSZG4Pa+UQr4EsYqXHwUXOU1SHACf6iHToNhr+Z8uWAx3a0NBQ0CW8tBeLLYFkElOydE3AmIeNitCBxXIevq63WFpmqaN30Bo8R1pfK0+FrYRVlj6odZf7Y89Y5JoUyFr8GalNjJV8PtUQrAFi6iyclfqhapa2yrHFT9jjEvXq8exJLxpbniedyJSOLDe68rMetPrvdxdfgKX0Riund6XRYnzGnSYREKCFyoA7X4J6u7h6xqF6qJAvLGYpbr7E+awx6CEu5WYpzFDxMlOGfYNQSsZkXMnawOjDrCPq65cEj/2+z1iimXNDngrF6/S3iSSv7Ol8utMZseYfqPijlsSi
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BEZP281MB2965.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUVVZU1wRkhLaFlqRFFSakJjdC83RHRnaXlKZ0NnM2lTOHdOWDFtRS9WVCs3?=
 =?utf-8?B?ZGVLQXhvSUMvZ0FBYkE2R3pKUnpncWRUTjJqS0htOTNmNHZEbERBekFFaVZH?=
 =?utf-8?B?Q2UvNHM4TnZaYkw2TTA5U1gzWlN0NzRIOXdZaHhNeHFXdmZ5WmE0dUlXaEFH?=
 =?utf-8?B?bWJCMlBENXQzMFhUalplWG1uOG55TGQ2cnpxd3FEU0RFNHlYUXlxbkpnRG0z?=
 =?utf-8?B?TjRUMG40MHltbnVpUFF4Tk1lSkNHY2pGZWxuRWRxdWk0OGNrV2FkekdaYTNp?=
 =?utf-8?B?dEdyTHVZTVZzZ2hUNks4YS9sZEY0ZnpiYjkvVG1YRHozNmplNGRya0llTmJR?=
 =?utf-8?B?aDZFenhPa3Y5MTc5UHN0TEVDdmZWZU8rWWNjbzJZbWpGZ0ZhM1NjWkhGeU5T?=
 =?utf-8?B?LzlRaUFIWTBPUEorOFliZFJlNVZtMTFkTVlFeEJRbU0yU2dFTW13WmwxdWZM?=
 =?utf-8?B?S0JSU05PNjdLKzNLa1RSRS81M2hlUXFsLytscm1OcFc1SmtodXM5eXNJcm9B?=
 =?utf-8?B?dTFNME1hdkEvSHQ3ejZMaHErUHdHWUtyK3dtSE5MTEtFQWFBanBvQlZKSGEr?=
 =?utf-8?B?SnFKRWNtMTBkclN4NC9SQWMvUVpJdFdKbDdtRkpkVUhOcjJrbmFJTTNVNmtx?=
 =?utf-8?B?N3ZPRWIrSFNFMk02dVpONTAzZ1FueFRwRWxBSGxJR0pWdXg4MzB1dm9PbmV2?=
 =?utf-8?B?RHk2VHN3SFBPN2RyYytrb2Vka0cyc3ZwOTNLWTU1Y0g1WTRQSlQ0K3ZmT0dx?=
 =?utf-8?B?MDVER0dMVFpRSHdhZFZtOXRHb3ZQdURycWs5U2owV3prMEVRNk41REk1N0s5?=
 =?utf-8?B?VnRvb1lualUreVVIL3lTbjhrZGZISHJBV2JOYStYR3ZZZDQwMUVJSm4vM3Nl?=
 =?utf-8?B?M3RxNHJVemVZbytJa1RSYkx5cm9JUmNsZ3FESWs3RHp3ejBvOUdFZExPQnR2?=
 =?utf-8?B?NitJTkExOG1iNThwSjlFTG52UEZyekErdGJnVzlqYmg2L3RZczF4MHVOQzZm?=
 =?utf-8?B?RzFQTlRPVjA4OUlCM1BKOUh6QmVpbldCQ09VSDhhMUJITENlV25VOGI0VlZG?=
 =?utf-8?B?dVRDSktzckc5UHRNa3d4OVBpenc4bjRyZmdGQ3Rtcmk3Ykk4SUFPUE9KZlls?=
 =?utf-8?B?VytPK1padFVsc2dBd21yVXBFbGZxb2hYektKWDhzS3EraWlFTTZaUWg4Qldq?=
 =?utf-8?B?NEc2OWFrekNLTEN2RkVjcU5tbWloeUUvQ25VNU9WZm9Mem1qRDBuZGVFWjVH?=
 =?utf-8?B?YzhQYTRVdjVIK2hXRW5wekF1KzhPb081OGVkeXErNlpmd1Ryb3Q3YVljZ3da?=
 =?utf-8?B?N0hZRFFGYmx1ZThNUndmU0J5K0xSVllDNEFia2gzdTZlVU50NFZpNnl1NzdB?=
 =?utf-8?B?U3RYQytsZnBsWEhXa0M0dUppS0pWRGVZTVRLbFB6akxMY1BKclRKSWVDNURS?=
 =?utf-8?B?UjNnWVBTTTdmL2VjNVI3bkZnMVJoVXlIRjJsVVhEUVE3ZHRrb2lLdkNYeUhQ?=
 =?utf-8?B?dUVDU1plb2lsSFZHTXBqNjJ5QWVza0hDMlljNWE2NHU3TDdzWDZaUUdvOTNu?=
 =?utf-8?B?M3laVGxYTnpxcEVpY0R0TGRnWmJwejQwazlYeUdScURFa2JWVUQ2bnA2NURz?=
 =?utf-8?B?a21tM2xvaEw0WjZTdDFhRVFxTzNMNXJndjNJUEhZMEYwdlpHMHVHZ2RVcEtD?=
 =?utf-8?B?VUxhdC9WNGsxRFhEYjhXTWN4cjdEa3ZuRHRRNXhObTJvZmtCbUNUU2xFZmtm?=
 =?utf-8?B?YTJmYTNudldzSndlcjJ2RnlwZ05ZNUNCYlhtVXBlZzdWQmF0NGcwRVFLdldn?=
 =?utf-8?B?dTB3OWpUVmRXckpLamxSbktET0VqZGhkTyt4OGR1d08rUzMzbGFCYkhwbGNw?=
 =?utf-8?B?M01qSklVNnhYSEJPYnJTNVpmT2FYcGxyU01LdHJ6QWptRHlpZmFKalJTZzhs?=
 =?utf-8?B?Ym1RWk5WOHBXbW9pZTcxVCs4azBuUXVRWExpV1ZCaGY3UXJ4WE1NZlJWZEMx?=
 =?utf-8?B?VEZFeW9SNGZCd1VMZWw5cWROWWZHN2c3aW9aMDZvay9kcDU3algvdkwrTlVy?=
 =?utf-8?B?bDFmeE8rV2paalpwajZQTGN4YmNHclE4b1krK1BuaStmWnNmdUZXay9UU0tt?=
 =?utf-8?Q?2/6g=3D?=
MIME-Version: 1.0
X-OriginatorOrg: cinemo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2965.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9193c08e-0762-4a13-28ff-08dc3e98e546
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 11:22:38.1892 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f67d7a5-8d31-49e4-bdef-c6169c4e9474
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: msgJqRvU7ZTHZIJxqZmdyI8dv03djA4K7KcJxhCyas/HL571MH+MgXkNET02oShf8dTmAIw99OU0G84oRANbPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1695
X-Mailman-Approved-At: Thu, 07 Mar 2024 15:55:57 +0100
Content-Type: text/plain; charset="utf-8"
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

SGVsbG8gVS1ib290IFRlYW0sDQpJIGFtIHVzaW5nIHRoZSB1LWJvb3QgZm9yIEtoYWRhcyBFZGdl
LXYgcmszMzk5IHJvY2tjaGlwOiAgaHR0cHM6Ly9naXRodWIuY29tL2toYWRhcy91LWJvb3QvdHJl
ZS9raGFkYXMtZWRnZXMtdjIwMTcuMDktcmVsZWFzZS12MS4wLjA/dGFiPXJlYWRtZS1vdi1maWxl
DQpBbmQgSSBhbSB1c2luZyBjb25maWd1cmF0aW9uIGZpbGUgOiBodHRwczovL2dpdGh1Yi5jb20v
a2hhZGFzL3UtYm9vdC9ibG9iL2toYWRhcy1lZGdlcy12MjAxNy4wOS1yZWxlYXNlLXYxLjAuMC9j
b25maWdzL3JrMzM5OV9kZWZjb25maWcNCkFmdGVyIGNyZWF0aW5nIHRoZSAud2ljIGltYWdlIHVz
aW5nIHR1dG9yaWFsOiBodHRwczovL2dpdGh1Yi5jb20vSmVmZnlDTi9tZXRhLXJvY2tjaGlwL3Ry
ZWUva2lya3N0b25lP3RhYj1yZWFkbWUtb3YtZmlsZSN2LXN1cHBvcnRpbmctbmV3LW1hY2hpbmUN
CkkgZmxhc2hlZCB0aGUgaW1hZ2UgaW5zaWRlIHRoZSBraGFkYXMgZWRnZS12IHJrMzM5OSAgZGV2
aWNlLg0KZGV2aWNlIDogaHR0cHM6Ly93d3cua2hhZGFzLmNvbS9wcm9kdWN0LXBhZ2UvZWRnZS12
DQoNCkJ1dCB0aGUgYm9vdCBkaWQgbm90IGhhcHBlbmVkICwgcGxlYXNlIGNoZWNrIHRoZSBVUkFS
VCBsb2cgYmVsb3cNCkNvbXBsZXRlIGxvZ3MgOiDigItbaHR0cHM6Ly9yZXMtZ2VvLmNkbi5vZmZp
Y2UubmV0L2Fzc2V0cy9tYWlsL2ZpbGUtaWNvbi9wbmcvdHh0XzE2eDE2LnBuZ11VQVJUX0Vycm9y
LmxvZy50eHQ8aHR0cHM6Ly9jaW5lbW8wLW15LnNoYXJlcG9pbnQuY29tLzp0Oi9nL3BlcnNvbmFs
L3ZqYWlzd2FsX2NpbmVtb19jb20vRVJPa0wwZ1paV1JIa0d2Qmx2SjA2QmtCcjZ0X0NvZ1ZyeUM3
bUFRNm55eF94Zz4NCg0KDQpDYWxsIHRyYWNlDQotLS0tLS0tLS0tLS0tLS0tLS0tDQp4MCA6IDAw
MDAwMDAwMDgzMDAwMDAgeDEgOiAwMDAwMDAwMDAwMDAwMDAwDQp4MiA6IDAwMDAwMDAwMDAwMDAw
MDAgeDMgOiAwMDAwMDAwMDAwMDAwMDAwDQp4NCA6IDAwMDAwMDAwMDAxNzJlMTAgeDUgOiAwMDAw
MDAwMDAwMDAwMDAxDQp4NiA6IDAwMDAwMDAwMDAwMDAwMDggeDcgOiAwMDAwMDAwMDAwMDAwMDA4
DQp4OCA6IDAwMDAwMDAwZjNjNDUyNzggeDkgOiAwMDAwMDEwMDAwMDAwMDAwDQp4MTA6IDAwMDAw
MDAwZmZmZmZmZDAgeDExOiAwMDAwMDAwMDAwMDAwMDA2DQp4MTI6IDAwMDAwMDAwMDAwMTg2OWYg
eDEzOiAwMDAwMDAwMGYzYzQ1MWJjDQp4MTQ6IDAwMDAwMDAwMDgzMDAwMDAgeDE1OiAwMDAwMDAw
MDAwMDAwMDAyDQp4MTY6IDAwMDAwMDAwZjVjYjQwOTggeDE3OiAwMDAwMDAwMDAwZGYzNDA0DQp4
MTg6IDAwMDAwMDAwZjNjNDljZjAgeDE5OiAwMDAwMDAwMDAwMDAwNDAwDQp4MjA6IDAwMDAwMDAw
ZjVkNWZlZjAgeDIxOiAwMDAwMDAwMDAwMDAwMDAwDQp4MjI6IDAwMDAwMDAwMDAwMDAwMDQgeDIz
OiAwMDAwMDAwMGYzYzQ1NDg4DQp4MjQ6IDAwMDAwMDAwZjNjNDU0ODggeDI1OiAwMDAwMDAwMDAw
MDAwMDAwDQp4MjY6IDAwMDAwMDAwMDAwMDAwMDAgeDI3OiAwMDAwMDAwMDAwMDAwNDAwDQp4Mjg6
IDAwMDAwMDAwMDAwMDAwMDAgeDI5OiAwMDAwMDAwMGYzYzQ1MmUwDQoNCg0KQ2FsbCB0cmFjZToN
CiAgUEM6ICAgWzwgZmZmZmZmZmYwYTdhZTAwOCA+XQ0KICBMUjogICBbPCAwMDIwMjBiYyA+XQ0K
DQpTdGFjazoNCiAgICAgICAgWzwgZmZmZmZmZmYwYTdhZTAwOCA+XQ0KICAgICAgICBbPCAwMDIx
OGVhMCA+XQ0KICAgICAgICBbPCAwMDIxODk2MCA+XQ0KICAgICAgICBbPCAwMDIyODdkMCA+XQ0K
ICAgICAgICBbPCAwMDIyOTRhNCA+XQ0KICAgICAgICBbPCAwMDIwODMyNCA+XQ0KICAgICAgICBb
PCAwMDIyZGQ4NCA+XQ0KICAgICAgICBbPCAwMDIxNmMxMCA+XQ0KICAgICAgICBbPCAwMDIxNmRj
NCA+XQ0KICAgICAgICBbPCAwMDIxNjUxNCA+XQ0KICAgICAgICBbPCAwMDIxNmFjOCA+XQ0KICAg
ICAgICBbPCAwMDIxNmRjNCA+XQ0KICAgICAgICBbPCAwMDIxNjRkOCA+XQ0KICAgICAgICBbPCAw
MDIyZDJhOCA+XQ0KICAgICAgICBbPCAwMDIxNzQ2NCA+XQ0KICAgICAgICBbPCAwMDIxNGYzYyA+
XQ0KICAgICAgICBbPCAwMDIxN2FiOCA+XQ0KICAgICAgICBbPCAwMDI4ZWJkOCA+XQ0KICAgICAg
ICBbPCAwMDIxN2QwOCA+XQ0KICAgICAgICBbPCAwMDIwMWIxMCA+XQ0KLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KDQp3aGVuIEkgdHJ5IHRvIHJ1biB0aGUgIi4vc2NyaXB0cy5zdGFja3RyYWNlLnNoIGR1
bXAudHh0Ii4gRm9sbG93aW5nIHdhcyB0aGUgb3V0cHV0Lg0KSSBkb24ndCB1bmRlcnN0YW5kIHdo
YXQgaXMgdGhlIGVycm9yIGFuZCB3aGF0IGRvZXMgIkM6ICAgWzwgZmZmZmZmZmYwYTdhZTAwOCA+
XSIgbWVhbnMuDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCiQgLi91LWJvb3Qvc2NyaXB0cy9zdGFja3RyYWNlLnNoIC4uL3RlbXBEaXIv
ZHVtcF9jbGVhbi50eHQNCg0KU1lNQk9MIEZpbGU6IC4vYnVpbGQvdG1wL3dvcmsvcm9ja2NoaXBf
cmszMzk5X2toYWRhc19lZGdlX3YtcG9reS1saW51eC91LWJvb3Qtcm9ja2NoaXAvMV8yMDE3LjA5
LXIwL2J1aWxkL3UtYm9vdC5zeW0NCg0KQ2FsbCB0cmFjZToNCiAgQzogICBbPCBmZmZmZmZmZjBh
N2FlMDA4ID5dDQogIGRvX2Jvb3RtX2xpbnV4KzB4NWMvMHg3NA0KDQpTdGFjazoNCiAgYm9vdF9z
ZWxlY3RlZF9vcysweDQ4LzB4ODBdDQogIGRvX2Jvb3RtX3N0YXRlcysweDhkMC8weDk1MA0KICBh
bmRyb2lkX2Jvb3Rsb2FkZXJfYm9vdF9rZXJuZWwrMHgxNWMvMHgyNTANCiAgYW5kcm9pZF9ib290
bG9hZGVyX2Jvb3RfZmxvdysweDJhMC8weDJhNA0KICBkb19ib290X2FuZHJvaWQrMHhkMC8weGY4
DQogIGNtZF9wcm9jZXNzKzB4ZGMvMHgxMGMNCiAgcnVuX2xpc3RfcmVhbCsweDZlNC8weDcyOA0K
ICBwYXJzZV9zdHJlYW1fb3V0ZXIrMHgxNzAvMHg2NmMNCiAgcGFyc2Vfc3RyaW5nX291dGVyKzB4
Y2MvMHhlNA0KICBydW5fbGlzdF9yZWFsKzB4NTljLzB4NzI4DQogIHBhcnNlX3N0cmVhbV9vdXRl
cisweDE3MC8weDY2Yw0KICBwYXJzZV9zdHJpbmdfb3V0ZXIrMHg5MC8weGU0DQogIHJ1bl9jb21t
YW5kX2xpc3QrMHg1MC8weDkwDQogIGF1dG9ib290X2NvbW1hbmQrMHg0MC8weDExNA0KICBtYWlu
X2xvb3ArMHg1OC8weDY4DQogIHJ1bl9tYWluX2xvb3ArMHhjLzB4MTANCiAgaW5pdGNhbGxfcnVu
X2xpc3QrMHg1OC8weDk0DQogIGJvYXJkX2luaXRfcisweDIwLzB4MjQNCiAgcmVsb2NhdGlvbl9y
ZXR1cm4rMHg0LzB4MA0KDQpQQyBTdXJyb3VuZGluZyBJbnN0cnVjdGlvbnM6DQotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpCZXN0IFJlZ2Fy
ZHMNClZpdmVrIEphaXN3YWwNCg==
