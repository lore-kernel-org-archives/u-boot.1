Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D48CF64A4
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 02:06:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 664F483E40;
	Thu, 20 Nov 2025 03:06:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="mCtpajDX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9146183EA6; Thu, 20 Nov 2025 03:06:11 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BD3483E0E
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 03:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=d.haller@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHkXqEhQHzgVMvDZ7CkGvFKlSROhyujo8eic1Ukzn0rftVTuYxF76MrfRQeW6ytZJonvFIqvjGmv3C0HdMLSouYtc7j2k3ALcbNXQfViA5b5nUeoVBhbeJaGiAzVGfFv228/bE6udWs/StSxbZiUGu/LyARlUIArpZ2HNaAy84v9WAvj/y/iM8/uCQUCT2TgsqdrNsCfcSisYkY2Bh/sloTQYxqEERBvQ5dM3TYLQC1PVOwhz0OdIUEoiXbE/u3Y29HQ1JUN9kDfME5KJ79UQWSTzfwlHQn/n8fsCR7cLIkX2Klxk0VkhZEUBEBGuPYMEu1HVJ2a1KxhW5txa2KwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdoYcbqyQOBm6sN/eeWKTjG5lVx8YSPTgEONXBlUsco=;
 b=nfz6OhbRL7uaQwcvkaHm2M8N06zo5vsZKkbBplPNmtpSBcPd1qxhbzJy0+DcNFKn4q4QmuWY3mB5VC2QdeYYdQodeIAob8MuyIkplXDh8JI0JRuPLmdhgLEhwF7zroI7EJ3VTVWnpDtXetcWOtv3pXL+ai6xwMBl1lHc2UltezNJXO6LV64zvutUwRBZY1P3T1apc+S/fpOv+irxyakujmhjh4geTC6GCLGLTCyntSHE0XJSp92aVlkQu9bRVvasfaFiTPy//vqsZ3H+S+Ig3bvrapaDFzwFTEho7+HpL4eoEPW1yYJdBRT0fONB/ACBeqMRuoPfT0lXHZUKrZpDJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdoYcbqyQOBm6sN/eeWKTjG5lVx8YSPTgEONXBlUsco=;
 b=mCtpajDXLCwZkR+Om8dbDm2UptX8wPhbBxmaeQg4gkj5+4iynxoU0DY4sXRwL+SNlLinvRpxhuXEV3cWk0AtQO5pvuiusJoqtzHVZvgodfStTv5OY6INxkhNggqZai8dIdugG/YhBbEo/Y5ksYqsAhkknsTtjKQ5d/B8pphjNKV9wqy+d/B6MFQiynu3pSGYVjesrQbndjWGkPxZQn1BGCFFzuLk8vcwrmU3p7ipKQoyMgE3zW3SchKO8NGCKNBt9qrDiPVBhEecXWG0T2U5PU9PZfFOtsHl3mA5Qy9McOK1nkwhizR13Th5Q6QR0O274GS1ATW6CAyJVdaLy6eP7Q==
Received: from GV2P195MB2328.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:dc::8) by
 PAXP195MB1376.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:1a4::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Thu, 20 Nov 2025 02:06:06 +0000
Received: from GV2P195MB2328.EURP195.PROD.OUTLOOK.COM
 ([fe80::c6fe:e602:7166:f258]) by GV2P195MB2328.EURP195.PROD.OUTLOOK.COM
 ([fe80::c6fe:e602:7166:f258%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 02:06:05 +0000
From: Dominik Haller <d.haller@phytec.de>
To: "trini@konsulko.com" <trini@konsulko.com>, Daniel Schultz
 <d.schultz@phytec.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>
Subject: Re: [Upstream] [PATCH 2/2] board: phytec: phytec_som_detection: Add
 support for phyFLEX
Thread-Topic: [Upstream] [PATCH 2/2] board: phytec: phytec_som_detection: Add
 support for phyFLEX
Thread-Index: AQHcUklTIkxEBcbKt0uad49HM1fenbT639+A
Date: Thu, 20 Nov 2025 02:06:05 +0000
Message-ID: <aff311f21df7dda8f243ef2c60afded83977c4af.camel@phytec.de>
References: <20251110135228.1357377-1-d.schultz@phytec.de>
 <20251110135228.1357377-2-d.schultz@phytec.de>
In-Reply-To: <20251110135228.1357377-2-d.schultz@phytec.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2P195MB2328:EE_|PAXP195MB1376:EE_
x-ms-office365-filtering-correlation-id: 8403bece-c0cc-4ee0-4e1a-08de27d95ce0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?UjJndjU1UEpGNnJIZVVuNGZDaURyKzlTNXE4cTBIVEx5T2JzSVN1VWtYLzVU?=
 =?utf-8?B?cy9HdEZlQ2pxTHgzdHFONkRmd2Rlb1J4K2RyZWpBK0Vic3ZCM2gwVGxKODlZ?=
 =?utf-8?B?NzZqVTd5bGw2UDA2SW9acFVONWJwYlFqa0g1WkxxN2JRWjJSOEtmNjMrOWQ4?=
 =?utf-8?B?OUtEN2xwc1p2dFV3dWtGd2ROeUNMUXNGSG1xMGdtV05vNlFZdXJOSmJmaDIx?=
 =?utf-8?B?WFVaQVRjMDA4bWxtaUYxL1JCbnNXRm5TVWt6czZMZDZCRCtNOW9rZzB6Qkdv?=
 =?utf-8?B?TW5TdThjbm5MN20yUUhiaU5WektRZVpUTkJkVUJrVzVpTEFBbVY0aFRaWXkz?=
 =?utf-8?B?NkZOWW1yYm1ONWpWUFJPRUsvQ3d2THhDcldxaGtob2RLL0w3L1d6bUpBbmJT?=
 =?utf-8?B?eWliazdRVStSTnU4QmE5TXZ5RVk1M1B5QU5uUTEvUkxxdGhRNm5iN1piOUsy?=
 =?utf-8?B?ZFUxMnp2QzNEa1Fyd2greGF2ZWcvT1UxR2t2QWdwNnBPQXNLZW8vUGhWL0Nz?=
 =?utf-8?B?L2h3SFVQVVora2RuT0pYaHRrbWZZRExoTVZ5Q01EaUE2aDJiUUEzK1ViQnFT?=
 =?utf-8?B?NlRqY3Npa1FETGV0WXl4NzVKR2s2dTFuMDYyRXRLSXlaN2t5VFMwbUljVlBn?=
 =?utf-8?B?ckpQQUFsUEtxM2hkOThzMXR4VXB0RldtanloUGQ3blFuRHREM0JlZ0hic3pY?=
 =?utf-8?B?bFdlenJrLzQ0QlVkYWpPckhGOUtMUTZrSlJVQ3VDRkpsMU5XSWhHMUFlVmZS?=
 =?utf-8?B?WUtFNnFMYmFVeEtoSzdyZFRNZ05aZnNvTDJXR05vVjFFdW80S2VwWmhyK1Nw?=
 =?utf-8?B?OTQ3MjZ2N1VOVUQ0VUg3Tkh2S0k0d2VTOFFLdzgrYkN2YWg3VmRxbFo0b29v?=
 =?utf-8?B?VzdTNGZTSUhQdDNBR2NSOUxVTGtSd25TMlN3Ry9LdzFhM3hBeDhqOFRWL3ZS?=
 =?utf-8?B?alAraElYdE15aXJuQ2xUTTNXN0ZkN2VCdEtDUjFrWktrU3R5ZUZwR0JMKy9j?=
 =?utf-8?B?dzMxTEpiNE9ZdE5XR21yZ2RaU2I5MFI1ZFlyS2lLLzg0eUpsZkRPV1c0RG5i?=
 =?utf-8?B?OGFXNS9BTDRodWNNQ3hNZnVaemxMMnlTdHFMWEVYY2QzeWNHaWMvb2hscVFC?=
 =?utf-8?B?ZmFRSmJnTnJ2eFR4VERRUlFkOVpLblFZaUdXR3p1SWl2dlpWaVRWbjQzYWpw?=
 =?utf-8?B?NGlORS96Sjh6UmowU29HVll3NEV4cmhwdTVaUlVDK0J1WG5aOTBqSjRYUjJD?=
 =?utf-8?B?aWlOQXNOL0dBM2o0U1pIY3R6RlRoRjAvU1IvcURnT1dncm8rUmVqVnVCck9P?=
 =?utf-8?B?dGtwYVhOMzc1SS9wVmg2QTVQR1ZSd0RZMUc1MWgrdHFjak1KdFZ0SHREME1x?=
 =?utf-8?B?N3BiUmlMcFhMZ3lhd2VpQS92blh2YjdTWWd5Wkp1VDQvSE8rcjdCaHhBbUhv?=
 =?utf-8?B?MllQcGxIZGg0U1FySkxvY2pTNm1ZeVF5akRDbHFCVGlGREduVElDdnEzMnFD?=
 =?utf-8?B?V3ova0ZEbmlvOTRuS1ZsWjdlWjREVFRKRy9XTnBGMDM0UnNNa2tBcXo4U2Zp?=
 =?utf-8?B?VHhVU1ZqWlZlNmc2V29MemJFeTFKZ1hpZ3hMU28wTDRZV2ZMRzl1dTNMbmlH?=
 =?utf-8?B?VDVtQTB2UlEvYkhyWXlwRHVxQWVUVFBESjR1SnMvZWx6eFRXUWU1QUd1c0Vw?=
 =?utf-8?B?TVl5b3U1VU1Oc0dzQlAycUI2dnExRXkwS3pJOE8wTERvQzFjL1lpQVBjZ3cr?=
 =?utf-8?B?RTgrSE5DRGpJeUFjZ2ZRYURWWUJuSFEvK3JKRmUwUzEwNEdvektUR2I2U0Q5?=
 =?utf-8?B?VThoT0hYckd0aVEycS9GM1RkUWxodkpBNDA2T3FEeGJJSU02T3BBNW5JZnFZ?=
 =?utf-8?B?VXY3SWNXSmhKdnFxSktvbklpOWd5M2txRStSZ3Bxb1VXenFPbzRhNDI0RzVD?=
 =?utf-8?B?QjYvMkRPVHQ2V2pFY2xIU0dmL0pYTHE1cmNwRnhYSmVoZ0RmU2dEV0NwdDF4?=
 =?utf-8?B?S2p2WWRlc1BBcExpTTVyNXJ2anJod3dwcGl0TkQzZ2J4UTdtN1FpQUxTTnVl?=
 =?utf-8?Q?Wjirib?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2P195MB2328.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWJHditwL0x0Y29DMlIwSXpnU3h4a1BROXBBcjVYQjJUTG5DWlYxTHZicTJq?=
 =?utf-8?B?SVh6YjhMYzAzM211M0hSaldJTDNiVmdQOVBDdzRKcW1QVE9FcnJNZVFaMU5U?=
 =?utf-8?B?VHZXTm5ObEt6VjVDbVJVaHJPcHFkN1NpWGR4RW42ejVNb2lYNUdVVEdkRDBh?=
 =?utf-8?B?ZThMckNUV3MxTkZIWUMwUXlBS2NONkVhSUM4NTIvalBPZEQzZ1NwbFZ5SG9J?=
 =?utf-8?B?c2FvWHFWQW9pR0YwOG1Lak5FYzcvUFNKWjV1WmF3Uit6dkh2N3E5RXBHZDhl?=
 =?utf-8?B?aElwdm8vNnh0aUl0UCtMcUtGMHh1QUVuUDltM0JlZitwdlBPTTJ3bE8zRVFt?=
 =?utf-8?B?S3pGaGlTY201ZC81ODI1K2UraG9CakxvVHREbjJsQXN2VFBTbjI4V1lZQUZM?=
 =?utf-8?B?VzZEc1ZBQ0JnVjQyQzFRWDRsZzVjNzdOSXhOVUVzZGdrd0QxMUxUdkdTUHVX?=
 =?utf-8?B?NGp1bVpXMDVSdGIzTlJWNHJhZTJqMlNLMjl6OFpoV0JtZDd0RVBJcDUrdTBn?=
 =?utf-8?B?REV5d0RFc1ZLd2tmNFNiUFVMdHRaOE9oemxsUVkwall2TmpFdm1BT2IyMGJ3?=
 =?utf-8?B?YjEvNHczQzJQMXVxTUk5NzJRdmo3WW5ZNlVoWUVKMU5qSWhPL05KZ3duU0Jj?=
 =?utf-8?B?dFEwMnZmNk1IMTRWYS9FOHpkWHgzc0U1QzlJbFI2aWc2Q2t1Rk0zT0oybHRT?=
 =?utf-8?B?V2duQmdabnp4UTJBTzNsaFFnNm5PMlJFdEsyVnJHQmZSTHdNdmpSUUNmNUF4?=
 =?utf-8?B?enRDRVNMV2NUQmhJVUROWUpRTlFybHdpT0hjTFdnUS9IOGtTTEt3MXdhbGpQ?=
 =?utf-8?B?Rnp4MGhZc01lZjlFRy9VU1lMa0RweTVTYnBranVsa1VaYTEyS2R6cWwrWUtC?=
 =?utf-8?B?OVNVM2h3bTJMQ0M0clQzYUdITFprMzZrQ0xGaHg1aWdaeUZnbURMamRxb0sx?=
 =?utf-8?B?QnZwTzhFSHhYVXdmN3VuTzBpQWF2dmF4bkNtVWJrWFQ5Z3RBUlM0T3RMYkZX?=
 =?utf-8?B?b01JUmg3bFRDN2IydXlJU1FZUHJwZzJvSTYreGY5a2l6dlZWS2h6aGF2dUhy?=
 =?utf-8?B?QmVnQnRGVzh5bzNkVXY1SWNEZGYrVHJtWUU4d01GVW9ScmdQR05Jdmo2Mis5?=
 =?utf-8?B?K3RyYWZRNmw1N0hZeXU2d0tWZE5mZTFFdnRYQnJHd0k1M2VyWjFYQXlTYldv?=
 =?utf-8?B?TUMzbXplSk1nUG4vVUhxcWVpbk1ucWdsdTcrazl2ZjBSNENqeW50YjM3RTdt?=
 =?utf-8?B?VWZ6UEI1d1pRQWoyRTZTZTZVQW1wL0NtOGFQWmQveVRlQmtnWGRaTFRTVDRK?=
 =?utf-8?B?empEbEJxOElaa29wM3dGeEw0U2JPWUFWVDI0NS9KOE0wOXBxTS9kWW40SnND?=
 =?utf-8?B?SFlQejFVa0JQcng4QnJiNGtkSFV5eVM4cEt5dlpzaDB5Tm1sczhaeEdtOGtM?=
 =?utf-8?B?SGZ6Vk5Xa0JaNmFxQmI1ZHlvOUcyMDBWMC95ellnRDU4cm1SRHZMNXlGbnd5?=
 =?utf-8?B?OXh4NVpTV2tZVGdkQWh6eVo4eEpveDN1a2Z1S2hXOFlHU3hEbU0zU1BPU2tl?=
 =?utf-8?B?N2RZSkM1b29BZ2FWTlh4bmxJd1NrdGZYWmtVVEZ6ckFKTm14ZjQ2SVArZ1c0?=
 =?utf-8?B?TGR1R2J5NlhxZlI4b3hpWGJHWjJlbkRhWnNNNXpWcHlDelk3YXd3Ujg2Ryt5?=
 =?utf-8?B?UUQ4a0xJclVSVTZwNUc5L1dBTWRBWnFZNE5hc0trZDVubWVOa1llK3FHdEE5?=
 =?utf-8?B?NnVhZERRYmk0Vkk2WEZWZEpXUmllOGZiYjBwejRDaUV5YUx4Ry9SRlBQQ2l2?=
 =?utf-8?B?ZUxNQVdkdDZuT2ZYTHF3cEhVMkduLzNUODdMc0xOeDcxZi9zV0dGWTZSRkp0?=
 =?utf-8?B?endDT3Budm81TjFta1A0TTdvM1NmenZjUllXN05xWlBDYjNHMlFhcFZVQjRz?=
 =?utf-8?B?ZGhtOWpiSUZ1MkdSckZQRjJCZUI5VC94VmtpV2JlMkQ5S2NCWTd2S21kRmJH?=
 =?utf-8?B?eVoxSFVLdVFXOWIra0hiay82bVFUOThSRk0xaG5DM2ZxRVhPbll3WW9TR3hn?=
 =?utf-8?B?dmtIb0pJOHpXUXBtSzFkUy9kYVd6ZjFaeG9JTGxqYjhxZHc4OFVyMlhxRk10?=
 =?utf-8?B?VVVnRzVBbUJzMUIweEJ5QnZQOXdVZk0vVnBhSHNTQ3hjT1Y0b1ZXOTN2R3Y0?=
 =?utf-8?Q?EAqyzC6R205AGPjHuY0x9PROZiYrQl6ZXqHzNAPlafaJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BE2CD80624EE34AA60915EA06A3C837@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2P195MB2328.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8403bece-c0cc-4ee0-4e1a-08de27d95ce0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 02:06:05.2172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aexoRkOxjdJ8R75gEMVrTFn9xr5uSBQpUdGzqX3q8yTCNukxWGso0vZ4JRT79lJ3Xs14Hx9Ey2DGf4fYnKG2ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1376
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

SGkgRGFuaWVsLA0KDQp0aGUgcGh5RkxFWC1BTTYyTHggaXMgbm90IHVwc3RyZWFtIHlldCBidXQg
c2luY2Ugb3VyIHNvbSBkZXRlY3Rpb24gaXMNCmluIHN5bmMgd2l0aCB1cHN0cmVhbToNCg0KDQpU
ZXN0ZWQtYnk6IERvbWluaWsgSGFsbGVyIDxkLmhhbGxlckBwaHl0ZWMuZGU+DQoNCg0KT24gTW8s
IDIwMjUtMTEtMTAgYXQgMDU6NTIgLTA4MDAsIERhbmllbCBTY2h1bHR6IHdyb3RlOg0KPiBwaHlG
TEVYIGFyZSBTb01zIGJhc2VkIG9uIHRoZSBGUFNDIHN0YW5kYXJkLg0KPiANCj4gQWRkIGFkZGl0
aW9uICJTT00gdHlwZXMiIGZvciB0aGUgcGh5RkxFWCBtb2R1bGVzIGJhc2Ugb24gdGhlDQo+IEZQ
U0MgR2FtbWEgc3BlY2lmaWN0aW9uLiBUaGVzZSBtb2R1bGVzIGNvbWUgaW4gZm91ciBkaWZmZXJu
dA0KPiB2YXJpYW50czsgcHJvdG90eXBlcyAoUFQpLCBzdGFuZGFyZCBwcm9kdWN0IChTUCksIEtT
UCAoS1ApIGFuZA0KPiBLU00gKEtNKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBTY2h1
bHR6IDxkLnNjaHVsdHpAcGh5dGVjLmRlPg0KPiAtLS0NCj4gwqBib2FyZC9waHl0ZWMvY29tbW9u
L3BoeXRlY19zb21fZGV0ZWN0aW9uLmMgfCAzOA0KPiArKysrKysrKysrKysrKysrKysrKy0tDQo+
IMKgYm9hcmQvcGh5dGVjL2NvbW1vbi9waHl0ZWNfc29tX2RldGVjdGlvbi5oIHzCoCA4ICsrKy0t
DQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2JvYXJkL3BoeXRlYy9jb21tb24vcGh5dGVjX3NvbV9kZXRlY3Rp
b24uYw0KPiBiL2JvYXJkL3BoeXRlYy9jb21tb24vcGh5dGVjX3NvbV9kZXRlY3Rpb24uYw0KPiBp
bmRleCBmZjE3MTFjMjRiNC4uMGUzMGVkOWIxYmIgMTAwNjQ0DQo+IC0tLSBhL2JvYXJkL3BoeXRl
Yy9jb21tb24vcGh5dGVjX3NvbV9kZXRlY3Rpb24uYw0KPiArKysgYi9ib2FyZC9waHl0ZWMvY29t
bW9uL3BoeXRlY19zb21fZGV0ZWN0aW9uLmMNCj4gQEAgLTMwOCwxNCArMzA4LDI0IEBAIHN0YXRp
YyBpbnQgcGh5dGVjX2dldF9wcm9kdWN0X25hbWUoc3RydWN0DQo+IHBoeXRlY19lZXByb21fZGF0
YSAqZGF0YSwNCj4gwqAJY2FzZSA3Og0KPiDCoAkJc29tX3R5cGUgPSAxOw0KPiDCoAkJYnJlYWs7
DQo+ICsJY2FzZSA4Og0KPiArCWNhc2UgOToNCj4gKwljYXNlIDEwOg0KPiArCWNhc2UgMTE6DQo+
ICsJCXNvbV90eXBlID0gU09NX1RZUEVfUEZMX0c7DQo+ICsJCWJyZWFrOw0KPiDCoAlkZWZhdWx0
Og0KPiDCoAkJcHJfZXJyKCIlczogSW52YWxpZCBTT00gdHlwZTogJWlcbiIsIF9fZnVuY19fLCBh
cGkyLQ0KPiA+c29tX3R5cGUpOw0KPiDCoAkJcmV0dXJuIC1FSU5WQUw7DQo+IMKgCX07DQo+IMKg
DQo+IC0JbGVuID0gc25wcmludGYocHJvZHVjdCwgUEhZVEVDX1BST0RVQ1RfTkFNRV9NQVhfTEVO
ICsgMSwNCj4gIiVzLSUwM3UiLA0KPiArCWNvbnN0IGNoYXIgKmZtdCA9IChzb21fdHlwZSA9PSBT
T01fVFlQRV9QRkxfRykgPyAiJXMtJTAydSIgOg0KPiAiJXMtJTAzdSI7DQo+ICsNCj4gKwlsZW4g
PSBzbnByaW50Zihwcm9kdWN0LCBQSFlURUNfUFJPRFVDVF9OQU1FX01BWF9MRU4gKyAxLA0KPiBm
bXQsDQo+IMKgCQnCoMKgwqDCoMKgwqAgcGh5dGVjX3NvbV90eXBlX3N0cltzb21fdHlwZV0sIGFw
aTItPnNvbV9ubyk7DQo+IC0JaWYgKGxlbiAhPSBQSFlURUNfUFJPRFVDVF9OQU1FX1NURF9MRU4p
DQo+ICsJaWYgKHNvbV90eXBlICE9IFNPTV9UWVBFX1BGTF9HICYmIGxlbiAhPQ0KPiBQSFlURUNf
UFJPRFVDVF9OQU1FX1BDWF9MRU4pDQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArCWlmIChzb21f
dHlwZSA9PSBTT01fVFlQRV9QRkxfRyAmJiBsZW4gIT0NCj4gUEhZVEVDX1BST0RVQ1RfTkFNRV9Q
RkxfTEVOKQ0KPiDCoAkJcmV0dXJuIC1FSU5WQUw7DQo+IMKgCXJldHVybiAwOw0KPiDCoH0NCj4g
QEAgLTMyNyw2ICszMzcsNyBAQCBzdGF0aWMgaW50IHBoeXRlY19nZXRfcGFydF9udW1iZXIoc3Ry
dWN0DQo+IHBoeXRlY19lZXByb21fZGF0YSAqZGF0YSwNCj4gwqAJc3RydWN0IHBoeXRlY19hcGky
X2RhdGEgKmFwaTI7DQo+IMKgCXVuc2lnbmVkIGludCBrc3BfdHlwZTsNCj4gwqAJaW50IHJlcywg
bGVuOw0KPiArCWNoYXIgKnZhcmlhbnQgPSAiU1AiOw0KPiDCoA0KPiDCoAlpZiAoIWRhdGEtPnZh
bGlkIHx8IGRhdGEtPnBheWxvYWQuYXBpX3JldiA8IFBIWVRFQ19BUElfUkVWMikNCj4gwqAJCXJl
dHVybiAtRUlOVkFMOw0KPiBAQCAtMzQxLDcgKzM1Miw3IEBAIHN0YXRpYyBpbnQgcGh5dGVjX2dl
dF9wYXJ0X251bWJlcihzdHJ1Y3QNCj4gcGh5dGVjX2VlcHJvbV9kYXRhICpkYXRhLA0KPiDCoAkJ
bGVuID0gc25wcmludGYocGFydCwgUEhZVEVDX1BBUlRfTlVNQkVSX01BWF9MRU4gKyAxLA0KPiDC
oAkJCcKgwqDCoMKgwqDCoCAiJXMtJXMuJXMiLCBwcm9kdWN0X25hbWUsIGFwaTItPm9wdCwNCj4g
wqAJCQnCoMKgwqDCoMKgwqAgYXBpMi0+Ym9tX3Jldik7DQo+IC0JCWlmIChsZW4gPCBQSFlURUNf
UEFSVF9OVU1CRVJfU1REX0xFTikNCj4gKwkJaWYgKGxlbiA8IFBIWVRFQ19QQVJUX05VTUJFUl9Q
Q1hfTEVOKQ0KPiDCoAkJCXJldHVybiAtRUlOVkFMOw0KPiDCoAkJcmV0dXJuIDA7DQo+IMKgCX0N
Cj4gQEAgLTM1Myw2ICszNjQsMjcgQEAgc3RhdGljIGludCBwaHl0ZWNfZ2V0X3BhcnRfbnVtYmVy
KHN0cnVjdA0KPiBwaHl0ZWNfZWVwcm9tX2RhdGEgKmRhdGEsDQo+IMKgCQlyZXR1cm4gMDsNCj4g
wqAJfQ0KPiDCoA0KPiArCWlmIChhcGkyLT5zb21fdHlwZSA+PSA4ICYmIGFwaTItPnNvbV90eXBl
IDw9IDExKSB7DQo+ICsJCXN3aXRjaCAoYXBpMi0+c29tX3R5cGUpIHsNCj4gKwkJY2FzZSA4Og0K
PiArCQkJdmFyaWFudCA9ICJQVCI7DQo+ICsJCQlicmVhazsNCj4gKwkJY2FzZSAxMDoNCj4gKwkJ
CXZhcmlhbnQgPSAiS1AiOw0KPiArCQkJYnJlYWs7DQo+ICsJCWNhc2UgMTE6DQo+ICsJCQl2YXJp
YW50ID0gIktNIjsNCj4gKwkJCWJyZWFrOw0KPiArCQl9DQo+ICsNCj4gKwkJbGVuID0gc25wcmlu
dGYocGFydCwgUEhZVEVDX1BBUlRfTlVNQkVSX01BWF9MRU4gKyAxLA0KPiArCQkJwqDCoMKgwqDC
oMKgICIlcy0lcyUwM3UuJXMiLCBwcm9kdWN0X25hbWUsDQo+IHZhcmlhbnQsDQo+ICsJCQnCoMKg
wqDCoMKgwqAgYXBpMi0+a3NwX25vLCBhcGkyLT5ib21fcmV2KTsNCj4gKwkJaWYgKGxlbiAhPSBQ
SFlURUNfUEFSVF9OVU1CRVJfUEZMX0xFTikNCj4gKwkJCXJldHVybiAtRUlOVkFMOw0KPiArCQly
ZXR1cm4gMDsNCj4gKwl9DQo+ICsNCj4gwqAJc3dpdGNoIChhcGkyLT5zb21fdHlwZSkgew0KPiDC
oAljYXNlIDQ6DQo+IMKgCQlrc3BfdHlwZSA9IDM7DQo+IGRpZmYgLS1naXQgYS9ib2FyZC9waHl0
ZWMvY29tbW9uL3BoeXRlY19zb21fZGV0ZWN0aW9uLmgNCj4gYi9ib2FyZC9waHl0ZWMvY29tbW9u
L3BoeXRlY19zb21fZGV0ZWN0aW9uLmgNCj4gaW5kZXggMTg3NDI0YTJiNDQuLmZkZmQzYzk2OWZm
IDEwMDY0NA0KPiAtLS0gYS9ib2FyZC9waHl0ZWMvY29tbW9uL3BoeXRlY19zb21fZGV0ZWN0aW9u
LmgNCj4gKysrIGIvYm9hcmQvcGh5dGVjL2NvbW1vbi9waHl0ZWNfc29tX2RldGVjdGlvbi5oDQo+
IEBAIC0xOCwxMCArMTgsMTIgQEANCj4gwqAjZGVmaW5lIFBIWVRFQ19HRVRfT1BUSU9OKG9wdGlv
bikgXA0KPiDCoAkoKChvcHRpb24pID4gJzknKSA/IChvcHRpb24pIC0gJ0EnICsgMTAgOiAob3B0
aW9uKSAtICcwJykNCj4gwqANCj4gLSNkZWZpbmUgUEhZVEVDX1BST0RVQ1RfTkFNRV9TVERfTEVO
CTcJLy8gUEN4LTAwMA0KPiArI2RlZmluZSBQSFlURUNfUFJPRFVDVF9OQU1FX1BDWF9MRU4JNwkv
LyBQQ3gtMDAwDQo+ICsjZGVmaW5lIFBIWVRFQ19QUk9EVUNUX05BTUVfUEZMX0xFTgk4CS8vIFBG
TC14LTAwDQo+IMKgI2RlZmluZSBQSFlURUNfUFJPRFVDVF9OQU1FX0tTUF9MRU4JOAkvLyBLU1At
MDAwMA0KPiDCoCNkZWZpbmUgUEhZVEVDX1BST0RVQ1RfTkFNRV9NQVhfTEVOCVBIWVRFQ19QUk9E
VUNUX05BTUVfS1NQX0xFTg0KPiAtI2RlZmluZSBQSFlURUNfUEFSVF9OVU1CRVJfU1REX0xFTgkx
MQkvLyBQQ3gtMDAwLQ0KPiBcd3sxLDE3fS5BeA0KPiArI2RlZmluZSBQSFlURUNfUEFSVF9OVU1C
RVJfUENYX0xFTgkxMQkvLyBQQ3gtMDAwLQ0KPiBcd3sxLDE3fS5BeA0KPiArI2RlZmluZSBQSFlU
RUNfUEFSVF9OVU1CRVJfUEZMX0xFTgkxNwkvLyBQRkwteC0wMC14eDAwMC5BeA0KPiDCoCNkZWZp
bmUgUEhZVEVDX1BBUlRfTlVNQkVSX0tTUF9MRU4JMTEJLy8gS1NQLTAwMDAuQXgNCj4gwqAjZGVm
aW5lIFBIWVRFQ19QQVJUX05VTUJFUl9TVERfS1NQX0xFTgkxNgkvLyBQQ3gtMDAwLUtTeDAwLkF4
DQo+IMKgI2RlZmluZSBQSFlURUNfUEFSVF9OVU1CRVJfTUFYX0xFTglQSFlURUNfUFJPRFVDVF9O
QU1FX01BWF9MRU4NCj4gKyAyMQ0KPiBAQCAtMzgsNiArNDAsNyBAQCBlbnVtIHBoeXRlY19zb21f
dHlwZV9zdHIgew0KPiDCoAlTT01fVFlQRV9QQ0wsDQo+IMKgCVNPTV9UWVBFX0tTTSwNCj4gwqAJ
U09NX1RZUEVfS1NQLA0KPiArCVNPTV9UWVBFX1BGTF9HLA0KPiDCoH07DQo+IMKgDQo+IMKgc3Rh
dGljIGNvbnN0IGNoYXIgKiBjb25zdCBwaHl0ZWNfc29tX3R5cGVfc3RyW10gPSB7DQo+IEBAIC00
NSw2ICs0OCw3IEBAIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgcGh5dGVjX3NvbV90eXBlX3N0
cltdID0gew0KPiDCoAkiUENMIiwNCj4gwqAJIktTTSIsDQo+IMKgCSJLU1AiLA0KPiArCSJQRkwt
RyIsDQo+IMKgfTsNCj4gwqANCj4gwqBzdHJ1Y3QgcGh5dGVjX2FwaTBfZGF0YSB7DQoNCg==
