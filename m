Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5E0C48BEB
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 11:31:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A216F87DE6;
	Thu, 15 Feb 2024 12:30:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=etas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=etas.com header.i=@etas.com header.b="hbblDCEh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3349287D83; Thu, 15 Feb 2024 09:04:40 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C480F879BB
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 09:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=etas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Felix.Nieuwenhuizen@etas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHJ0bIyojfl8TNPdafv13vbE5yKGeuRWucnBeblevxrWRpemngbHiMjZ95zKxG+nYZnfEGJwmVwZLu76qKtUZFW7AQtKxvS9e/hCiTEAMRHPnkYnKerUKCw6P+ED8NUVwFaw6E9mnuaYaRAhqe3NvDF3yLpjtfUmtyLv7MCsgt/a270ewLV0tP+IbYTJGBC38iIinn128UP4Pv6LP5zB1L065Pq7NkJQshTeSfJIjTgjOUTALJorovPenoVsgU0dZtlZijKY+ZhdPesmNoiM3+r5Pecc3RH/BC+lj677bip16SwGHmg5bewTnfZX1uJ77CmU1nR4Laais5yGjADIbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mW4C9hJhY1H3kuAT3HPt/x5GwRXpYac5UNBfXjLD3rI=;
 b=AJTcVgsPq+MCBFiyttjWCx6sIkA8e9dhyiO2oGUxtP29Op4p45SlvhRrCI7qgS5VZDyfLmEg7U0HCLylPaJal0LMggrYC6Zoq8sX7g2KGsJXsvpeLNexxErhx39fEQ3JxTUPaHCb5SrscsoZezHI4ppRNSjSPLDo80hz7jiT7Nhu84aZPC51l3CNg/rhippcM9VpH4SG9mBbMf+BSQzOMDvUJjNgKen+Ax2N+7Cyc+6UtHYgypqr9P/5Fs9JcofrUUtuA/WqAyVUML8AoGWDAN3LaLxaDYU0bwT7rzbxMswpsri2GHGi3YaYrbRwVkP9IJjwgwjC1ZH3h1urXOJLbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=etas.com; dmarc=pass action=none header.from=etas.com;
 dkim=pass header.d=etas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=etas.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mW4C9hJhY1H3kuAT3HPt/x5GwRXpYac5UNBfXjLD3rI=;
 b=hbblDCEhGob3EkKdP9O05aQWgPIh1ECkUTrE+tzCanj9oxkV2NVVzZT9z6ie3xyudRvViHDY5ljthlYvUweQAMkdWm96/SYo6iDRuHG2OGwa1BcaABrvDE6ytdsMuRCbbM2nOOVzKIoM/Nl/Y8PhR4zNBSePjb9HOKUWt8OdqlGc86sjbsrgX/tl3MaA2ygk/I3AAcOoARefp5YhHzsHCDu/KLjVNSi7jf04iLdPxsuKxzHNP6Zo0hWnqWGu1BoUjkjKJ3wGsA5Jj6QeJWHX7oejEJDB8S2Gsk2+r0XylU0YUhVNa0tKFHCxqQY+hpuvD82noZCIqONRlnlxVgqpNQ==
Received: from DB9PR10MB4924.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c1::17)
 by GV1PR10MB6612.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:84::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 08:04:36 +0000
Received: from DB9PR10MB4924.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9164:3161:14cc:2e8c]) by DB9PR10MB4924.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9164:3161:14cc:2e8c%4]) with mapi id 15.20.7292.026; Thu, 15 Feb 2024
 08:04:36 +0000
From: "Nieuwenhuizen Felix (ETAS-DAP/XPC-Fe8)" <Felix.Nieuwenhuizen@etas.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Double free error with ubi_volume_desc/ubi_close_volume
Thread-Topic: Double free error with ubi_volume_desc/ubi_close_volume
Thread-Index: Adpf5FWaRET7VkkPSCuKFbP8PdiGoAAAUMAA
Date: Thu, 15 Feb 2024 08:04:36 +0000
Message-ID: <DB9PR10MB49240DB37425FF4ABEEF6E3C884D2@DB9PR10MB4924.EURPRD10.PROD.OUTLOOK.COM>
References: <DB9PR10MB4924F174A9B11749A43FFD5D884D2@DB9PR10MB4924.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DB9PR10MB4924F174A9B11749A43FFD5D884D2@DB9PR10MB4924.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=etas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB4924:EE_|GV1PR10MB6612:EE_
x-ms-office365-filtering-correlation-id: 1f9a90ba-567f-4030-5ff2-08dc2dfcc055
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cCBv6o3i7j73Zy2oKdEsh3+0kw81XZYxpLmtPD1H7CqdPlhlqubfxdIQUYrxjPiQRrAedeOaZqVrL4kTepeJPLXT/opNW1+qLRF6tvdNaNGVRnB5Fa3zRHYsiM3MOoe0+UNo7EXFss6Tvow4wp2H0i5cCM5Lr/BeTwG0AmAo6ULKQ2L0O5UrhCMUwKpkfu84jiGoX62FGdWIxfI3fw7P22VCoFifCCM/DW8egl4nS8IHDFtwiSuoI27HEa5yAJzcDIm8TkDMahTt2P8KURqcWQ0xYsJathI9+dbyNi/d94ToIdTANDtE6kqWhDs2ZyVUY8YA/VidiUdAwWBmGQoUW3WsrwglpKoUrvh7AdnMf1pSgulWe3689Enh9yrCCowzPT99wk4ZTas3loGX3k1RcrYyOy3BygF1ElT2DDTiGvteMu9lpZgZ72bKu3FK9kUiJVXojDHcI4nN/gGh7xrhaFF25YH2fevgX0DAigKMU1kcCal2AMCMgPt1PPJHOD0EIAxunZ8GOTmTbqlJ6XUPLGVY4JUjwLrYljBBqjz42kA0KTJat4ODbNkv7adaw59Uf2eru/aRfGUK0UsZc7BGcotfXScCQXs4QneoKXup/7DKEr1BR/KAWwf0BLTgwVE1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB4924.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(55016003)(2906002)(5660300002)(83380400001)(26005)(2940100002)(8936002)(6916009)(8676002)(316002)(76116006)(66946007)(66446008)(64756008)(52536014)(66556008)(41300700001)(38070700009)(66476007)(33656002)(71200400001)(9686003)(478600001)(7696005)(6506007)(122000001)(82960400001)(86362001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVVsOVVRTERNL2hDZC9aU251YmMySFNZeitvWU15M3BRaFZGVUhGM2MrUDBk?=
 =?utf-8?B?aHdUa2JKY1psQjJyb1E0L0l0YWhFKzZZdEZ0VlpPdEVndHp3RmlRZWlZRzhr?=
 =?utf-8?B?cWlpZnI1WVF5WG5rOEp6VWhud1hkcHVzVzgwVzRPdVpMMkFLK3IzZ2JzV2Rj?=
 =?utf-8?B?YUhpblpzWlpIcVFQOEhQRTdYbWRzdmFEaWxLTVdMa0NtU2huZjJEM1U5ZGF2?=
 =?utf-8?B?T3BhemFESjNRS21IK1hrNzRUOTJ6UDBLWEVIdVF4WnM5U0F5bkdnaWE3aHc3?=
 =?utf-8?B?clBEQVVqOWU0UFNDTVlYajRZb29SRVF6T1l3UDJMTFIwZkN6d1hmR0NpN3lr?=
 =?utf-8?B?Z0h2bVI1ellhMVBHblRCZGw2MDdlRXQ0K1BNV3VWaHJiZHRBUmo4ckxoSHJj?=
 =?utf-8?B?Vi9yQWpKbzBGcHY1ajRUeXlncnFIbSttSFY4Nk8xYTJmdVh6Mnp1bTJZa1hF?=
 =?utf-8?B?MjFNOHFkLzZvbEVETklaNyt1TXJXb01GUzVUWXg3L1JlRVRHNUlkem41eEZl?=
 =?utf-8?B?cTB1dGFEWGR5Vzc0bzNBSjUvYzN5bmRjbVB0S040SDZ2bkwzRVAxc3AvWUQ2?=
 =?utf-8?B?WWZlbnc4RGp4RXh2Kys0ejk4K2NmU2pFWHdHVXU3d2ZsZjNYMVVCazdBMHpD?=
 =?utf-8?B?YmRlZFJGWTkzSTlpc0lueVg0UU1iUUQ4UmxxU09LbVk3UE1oQ3k2YytVL1hz?=
 =?utf-8?B?cTNVczZyVExVV00vRU1pSUFIMjVtcXh1ajN2ajJkaGlWcmV5K2dFK2dnNS92?=
 =?utf-8?B?b29uTTRjY0dtZ2RPeGlQclFqQmtkVGVhSHFrVzBMMXhEZ2xBTllOUE1ENDFx?=
 =?utf-8?B?K01raHFwb0hIVi9tY2JYVkFXQUYvTWs5dnEzelZXZWtmYktIek5YK1R2UkVs?=
 =?utf-8?B?STMrYnIySFM0bklHdUZIbER3UTdzeCtvRFFqMG5SazUyK1MxU24rdmtFNW9F?=
 =?utf-8?B?bmtidHJnTnRrZHYzUHdFTWRZdXBWSDRVc0l0VGNYNDRzSnBoSTJrbWxLN2FT?=
 =?utf-8?B?dlNEQkdLUlNpdUxJdmh5S1ZIR0FqZGRSa0JoVmIvZzJERWdPS2hPYU1RVHFP?=
 =?utf-8?B?b0thRDRqcTg2R09iSzRzR1RWSlBxOFJ4SzlyWTBPVGNhQnZ4NVBsV0hwOEhL?=
 =?utf-8?B?VnVoT3B3WGxiZ0hvSDFhRlNPYjIyeXljdEk2UE1CajRCVU9SOWdDcUtlVUVC?=
 =?utf-8?B?bmNMRyttejNtajk3SjZXU0I5QWhqa1dwazdJOHRJNjhLVDlVVFpPYktPVDQr?=
 =?utf-8?B?c2tDZHhybkp4aVY5dkI1THpubFE5UG1MUW1qU0paTEhDMnVIcTk2N1g2dXY1?=
 =?utf-8?B?T0JhcnVlZDZyZ1RkK2J3YUZuQkhkQ0M3ZWVzQ2ZOY0FrbzcyMWNDdUJwWGNR?=
 =?utf-8?B?N2JuMkpNUjR5NXhNSGl1eEVXMDZIalNZNlBGLzRKZDY2ZEprM21FWThGbDF4?=
 =?utf-8?B?U2RWRUhPU2ZBazJNUnlybnoxckw0T2FhVHRVYnFtSzMwK3NlSU5JKzZlTllB?=
 =?utf-8?B?RW11c0R4Sm1UYk1KTmFtZmluR3lKV3IrMTFaT2VyTzEwaEhoM3FZVDkraWUv?=
 =?utf-8?B?ME1JY3MzWGFpRm9Md2dWTE9qSDJEZ1Nlb0VxNVVUSlpVdnA2R2VkcGVLUGpY?=
 =?utf-8?B?Z1pDenEvQVdsZEdnWFNzalBlM2NSQUcwRU5HWUVGQ0t1YnRSVmxldkpCQ1lh?=
 =?utf-8?B?anlzbXl2VHFYTy9hZEdFbVJVTHZ3L2Q4aEE2djU4dnMxL2k2THJsWUlMVlkz?=
 =?utf-8?B?WE5vems2dTFTY2tOeXZpSVhWMjVEVmdubFJpUmx5d3NIR0hhVnl5YlF0K3Ro?=
 =?utf-8?B?T0lyZlJackZQWG5nYXozdGpjbnFIUENCTUdmcUlTOXpyRDJnUXdyelhZeitT?=
 =?utf-8?B?T1BNcS94Y1dZOUNpNmdrbjJVMnZYN1Q0UnlCNHBYNXJ3Mm1TUVZWbmNvbUxn?=
 =?utf-8?B?NnF6dGtmekQ4QzRUNnQyTVM2NGhxeWFyVkVCMFJpQjdvdmZUNjVFd3E2R0NB?=
 =?utf-8?B?MGtyOTdJSWRtbU0zNkswcTRXYWcrZVF5c2tORGUybitteWlqYm1IQzk5b1hC?=
 =?utf-8?B?VCtWTGFsbjFDNllUTjBQbjk4MzZzYWNvTzIxWU1MZnB1Zk0yN0M5SmwzTGlm?=
 =?utf-8?Q?cBio=3D?=
MIME-Version: 1.0
X-OriginatorOrg: etas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4924.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9a90ba-567f-4030-5ff2-08dc2dfcc055
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 08:04:36.1265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ufwCOcWX/Ca1khLV3yDeiCbF8NpJOHYKkOn+/L2zBs3Ks/EJy5rrtHYTeF9rfThXRGSKic0QqR7i5sBnzgvOcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6612
X-Mailman-Approved-At: Thu, 15 Feb 2024 12:30:49 +0100
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

SGkgYWxsLA0KDQpJIHNlZW0gdG8gYmUgcnVubmluZyBpbnRvIGEgZG91YmxlIGZyZWUgZXJyb3Ig
d2l0aCB1Ymlfdm9sdW1lX2Rlc2MvdWJpX2Nsb3NlX3ZvbHVtZSBkdXJpbmcgYSB1Ymlmc21vdW50
L3ViaWZzbG9hZC91Ymlmc3Vtb3VudCBzZXF1ZW5jZS4NCg0KVGhpcyBpcyB0aGUgc2VxdWVuY2Ug
dGhhdCBJJ20gc2VlaW5nOg0KDQp1Ymlmc21vdW50DQotIGRvX3ViaWZzX21vdW50DQogIC0gY21k
X3ViaWZzX21vdW50DQogICAgLSB1Ym9vdF91Ymlmc19tb3VudA0KICAgICAgLSB1Ymlmc19tb3Vu
dA0KICAgICAgICAtIG9wZW5fdWJpDQogICAgICAgICAgLSB1Ymlfb3Blbl92b2x1bWUgLT4gcmV0
dXJucyB1Ymlfdm9sdW1lX2Rlc2MgIzENCiAgICAgICAgICAtIG9wZW5fdWJpIHJldHVybnMgdWJp
X3ZvbHVtZV9kZXNjICMxDQogICAgICAgIC0gdWJpX3ZvbHVtZV9kZXNjICMxIHN0b3JlZCBpbiBs
b2NhbCB1YmkgdmFyaWFibGUNCiAgICAgICAgLSB1Ymlmc19maWxsX3N1cGVyDQogICAgICAgICAg
ICAtIHViaV9vcGVuX3ZvbHVtZSByZXR1cm5zIHViaV92b2x1bWVfZGVzYyAjMg0KICAgICAgICAg
ICAgLSB1Ymlfdm9sdW1lX2Rlc2MgIzIgc3RvcmVkIGluIHNiLT5zX2ZzX2luZm8tPnViaQ0KICAg
ICAgICAtIHViaV9jbG9zZV92b2x1bWUodWJpKSBpLmUuIHViaV9jbG9zZV92b2x1bWUodWJpX3Zv
bHVtZV9kZXNjICMxKQ0KICAgICAgICAgIC0ga2ZyZWUodWJpX3ZvbHVtZV9kZXNjICMxKQ0KICAg
ICAgICAtIHNiIHN0b3JlZCBpbiBnbG9iYWwgdWJpZnNfc2IgKGluY2x1ZGluZyB1Ymlfdm9sdW1l
X2Rlc2MgIzIpDQoNCnViaWZzbG9hZA0KLSBkb191Ymlmc19sb2FkDQogIC0gdWJpZnNfbG9hZA0K
ICAgIC0gdWJpZnNfcmVhZA0KICAgICAgLSB1Ymlfb3Blbl92b2x1bWUgLT4gcmV0dXJucyB1Ymlf
dm9sdW1lX2Rlc2MgIzMNCiAgICAgIC0gdWJpX3ZvbHVtZV9kZXNjICMzIHN0b3JlZCBpbiB1Ymlm
c19zYi0+c19mc19pbmZvLT51YmkgKHRoaXMgb3ZlcndyaXRlcyB1Ymlfdm9sdW1lX2Rlc2MgIzIh
KQ0KICAgICAgLSB1YmlfY2xvc2Vfdm9sdW1lKHViaWZzX3NiLT5zX2ZzX2luZm8tPnViaSkgaS5l
LiB1YmlfY2xvc2Vfdm9sdW1lKHViaV92b2x1bWVfZGVzYyAjMykNCiAgICAgICAgLSBrZnJlZSh1
Ymlfdm9sdW1lX2Rlc2MgIzMpDQoNCnViaWZzdW1vdW50DQotIGRvX3ViaWZzX3Vtb3VudA0KICAt
IGNtZF91Ymlmc191bW91bnQNCiAgICAtIHVib290X3ViaWZzX3Vtb3VudA0KICAgICAgLSB1Ymlm
c191bW91bnQodWJpZnNfc2ItPnNfZnNfaW5mbykNCiAgICAgICAgLSB1YmlfY2xvc2Vfdm9sdW1l
KHViaWZzX3NiLT5zX2ZzX2luZm8tPnViaSkgaS5lLiB1YmlfY2xvc2Vfdm9sdW1lKHViaV92b2x1
bWVfZGVzYyAjMykNCiAgICAgICAgICAtIGtmcmVlKHViaV92b2x1bWVfZGVzYyAjMykNCiAgICAg
ICAgICAtIHRoaXMgaXMgYSBkb3VibGUgZnJlZSBlcnJvciwgdWJpX3ZvbHVtZV9kZXNjICMyIHNo
b3VsZCBiZSBjbG9zZWQgaW5zdGVhZCAoYnV0IHRoZSByZWZlcmVuY2UgaGFzIGJlZW4gbG9zdCkh
DQoNClRoZSBpc3N1ZSBzZWVtcyB0byBiZSB0aGF0IHViaWZzX3JlYWQgb3ZlcndyaXRlcyB0aGUg
dWJpX3ZvbHVtZV9kZXNjIHRoYXQncyBzdG9yZWQgaW4gdGhlIHN1cGVyYmxvY2ssIGFuZCB0aHVz
IHViaV92b2x1bWVfZGVzYyAjMiBpcyBuZXZlciBmcmVlZCwgd2hpbGUgdWJpX3ZvbHVtZV9kZXNj
ICMzIGlzIGZyZWVkIHR3aWNlLg0KDQpJJ20gbm90IHN1cmUgd2hhdCB0aGUgY29ycmVjdCBiZWhh
dmlvdXIgc2hvdWxkIGJlOg0KLSBzaG91bGQgdGhlIHZvbHVtZSBiZSBjbG9zZWQgYXQgdGhlIGVu
ZCBvZiB1Ymlmc19tb3VudCwgb3Igc3RheSBvcGVuIHVudGlsIHViaWZzX3Vtb3VudD8NCi0gc2hv
dWxkIHViaWZzX3JlYWQgbm90IG9wZW4gdGhlIHZvbHVtZSBpZiBpdCBpcyBhbHJlYWR5IG9wZW4/
DQoNClRoYW5rcyBpbiBhZHZhbmNlIQ0KDQpSZWdhcmRzLA0KRmVsaXgNCg==
