Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0311ECD98C7
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 07:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7890D80087;
	Wed, 10 Jun 2026 09:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Su5XOiZg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A457B839A8; Wed, 10 Jun 2026 09:49:51 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACD1080433
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 09:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9YluoLQvpcH2emUoyexdIyXQQq1reSnYy1IKO3go+63v0mG6psYiK3pID1qMj5IroGAVH3Q+WQdag+FfnRG8Iie5YDC8CO/+5xwZYNmUYmVicyJpNI7k15RMB3yiNqkL5Hpb6oIN2zLBfNbxvbC+LemqfvOy0sD8QJkQW/o7R2fm5CXJn0t+E7+HGG2FY8MYF9CV6qLjQeAoBLTg0Ebkztdl24XumlG6+EOr+knvUSq9bHwJQJSRgzr6S5POHUArHey2o/ZPGXbsaFbhVc6sNrLl9Hnyb1C0hFU5wOj9Tk1yUq2VZEt92MlHZHY/Jl8elWH+GAOClMuLVaKnBD2tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giB1XmYp7QRcWaW9jK+HOlBMmle3sA2TxdGIOXh6NPQ=;
 b=UaleQ8vlzL5GZuJ4Km9JiXCiJywvUn+0VKWDshNQQZCN2JkrWEZg9k+C7+ZTOd04pBXB00yaBJeuldjdabQwIfGcTXTQfmQylanMs9kH+u9yFhqDxU5gr3MjqiMDNrgwlWV2gNzQesOhbHxm+OJIoRP5e8AA136TJYQ66YiojLtcFub3n8U7n4H6gvURVXms2he5dF3mfGkPa0nt0WBYNFtHhF/LElLKfao198d702K86YJXY9MuklyF8kwSxg6905IR/7/jeS7G3qOMZSFcUXnu+jnnpH/E/acGOP+8MnszJkhBJxE/4BnGN7B9fa5eKzlKAQlS9M0XRyPLkIVzZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giB1XmYp7QRcWaW9jK+HOlBMmle3sA2TxdGIOXh6NPQ=;
 b=Su5XOiZgm9mRRlu4OgDzil/PnMOQauorpAAjJFIcktHZe4kDeOOJJmVklutdQWKRMWzlsEuuExnaTiVc8tKaBNos1Mt3mUKpQuglJ7yghyiSqV70TPoIES9wkO5qFxzbHLodXFiA3DpFVTagic+GhygprTGO0IEyrm6zhmCpx2WLxlV0nNnEsY6dLb3W6gvdwMuK8NHLVl6RUA2l4oxpT0QBLsOFLwHxh69UySEMHbnREgUceAY+ntYU17u7Hpqyv27scx3rjSsNxhTRUzx6JJ07fK25ceDKsbU7tFVH644NLnhh3E2ZrZdMjoQhp5au+QpAWgVbETZaYumleiX6Ow==
Received: from AS8PR04MB8721.eurprd04.prod.outlook.com (2603:10a6:20b:428::10)
 by FRWPR04MB11101.eurprd04.prod.outlook.com (2603:10a6:d10:171::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 07:49:41 +0000
Received: from AS8PR04MB8721.eurprd04.prod.outlook.com
 ([fe80::ca16:532c:71dd:39a5]) by AS8PR04MB8721.eurprd04.prod.outlook.com
 ([fe80::ca16:532c:71dd:39a5%6]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 07:49:41 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2MSAzLzNdIG5ldDogZnNsX2VuZXRj?=
 =?utf-8?Q?:_Add_SGMII_support_for_i.MX95?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjEgMy8zXSBuZXQ6IGZzbF9lbmV0YzogQWRkIFNH?=
 =?utf-8?Q?MII_support_for_i.MX95?=
Thread-Index: AQHc+K2xv83t1y2hM0OSyYMDv9ZaTQ==
Date: Wed, 10 Jun 2026 07:49:41 +0000
Message-ID: <AS8PR04MB87218AEDA50C5655E26E60BEE21A2@AS8PR04MB8721.eurprd04.prod.outlook.com>
References: <20260603-sgmii-v1-0-c4a0af0d5d3d@nxp.com>
 <20260603-sgmii-v1-3-c4a0af0d5d3d@nxp.com>
 <4a12deb6-b10f-4bb3-a6ab-6a4c508dc2a9@nabladev.com>
 <AS8PR04MB8721009281873A84A411AC9BE21C2@AS8PR04MB8721.eurprd04.prod.outlook.com>
 <01f0ff94-a956-435d-b642-fcde56ebf4f3@nabladev.com>
In-Reply-To: <01f0ff94-a956-435d-b642-fcde56ebf4f3@nabladev.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8721:EE_|FRWPR04MB11101:EE_
x-ms-office365-filtering-correlation-id: 51873941-2f13-454f-0090-08dec6c4d47f
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|19092799006|376014|5023799004|11063799006|4143699003|3023799007|56012099006|38070700021|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info: xds9KW/rAhx2dlNVsbLkSYoB0hbkUARr4ZqDU12m5Pma+W7m8uI6GsRp135EZL5i9vn3o7cN6zhFjZ1IRjWmZVxsKbJfjiySprwKENAPoTqiV6VzhGEAFt5gOW8QuSDEVJ78ewm1Y00f2bOo2/dq/X4zcDZoUQK9rKHc9EQr6ze9J+IoG5r3oD85tRqvAjGqJIHrDcvOiCrQpHmSnxAEuZDGEjSbXtAu96glRKppEhDlFv6fsqZT6aPiNgSrLEFLie94tfeQF2QXcr0xmboBqLg2MGzvV63ztD5CTB3izeTddFJ+EO8iFZyXBdiWNWujIGxZ/LsWCqFs+05ZpmLBxOgmMpqbo8OUXdGrxla5pijMwoCz2QOXKd5KNO0wOH9Go8My6hckQxZUf9NPBOrozGhn2SqMdyX8u1HpYwvLUXQZQp6C/uqfHIv1FpEwMMSfBjUI7+gkRBSCBLyNc4cgG4dXjrX9c9x0+Skq7uI8uRmHwM6AvFrZaLkTMrNCbJ1+VHrnZXV1rzj47Tleu8ndEbnS37hPsmw07MGiH2FHzsdzXBfheRmsil0+K09a3RhDpP7phx1qf1YViC8FhObZeugjCjYzE+UDZqOT48bS/HLqliGcYAlFHUeXQhmqBhN4E0VErN7DmMedl5tMNpwj+PNOMMDtibdZcvSylU49WyP+cRu9uxU6UO0Y0ayzA25M+6Ns8Xhz3BngMuusjT8jvIXm18si4U2LypayGYbTsiiiwyaa9sJQzK23yVNqeQUF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8721.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(5023799004)(11063799006)(4143699003)(3023799007)(56012099006)(38070700021)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUZOWjFMS2JpaGwvUHl2OXlXUjAwVS9FMng5azNZZGZabDdHbTNWU0wvVllG?=
 =?utf-8?B?bEVFNnVJVE1TLzdoZnEvUXRpdm82WUxZQnhkU1IzdHdRVnBIdWpXQ1NqODVx?=
 =?utf-8?B?cGl5L0J3VHdrMG05bkR0UkNMNEtnMzNRQ3JDSFVaV00vYkQyNmVyWDJDTlpW?=
 =?utf-8?B?UkVLRDhZUGFEV0VIU1gwc05HaFZzRi80QkNmMVlVOWhtbTFtdFVuMVVLNVZF?=
 =?utf-8?B?RWd1Y1M4TmpFUUNHUnFyemJ4dTFYTDREa01KM2swYmwvTmZIV2FnMTJ0T2JT?=
 =?utf-8?B?R09NQnRTc1NCOElkd2RRYnVFQjdVclNrZXVmcW9xTEtpZFh5N1RxcXdqWTlv?=
 =?utf-8?B?NEh3U1dBdUVEUWNjSWpIQ1hTRFcxRWhkUGxUUXI2U0tUemlUVXcyQmxmVU5w?=
 =?utf-8?B?WlA1V21lVzVYbVk1RysrQ0dvMDNwNThpMTJrUU43NVZBZFNMZ0RhWHdsQitQ?=
 =?utf-8?B?cDZFVFp1ZElZTzBMdVBTSnRJdHJKR1ZXcm5ObFRDVCtxVmQrWmVJMXhvTG50?=
 =?utf-8?B?WHZDTDdPVG9VQjRLQWNCb20zWndUMnFJcDJIVGR3MUVGZTdXR3dYSGJjRFlz?=
 =?utf-8?B?S0VEbTU2MENwK1AxUklOYmZIVEUrdnBnSzdkM2M5aUZnQXhSejVWV3dqQjFZ?=
 =?utf-8?B?M0xtRW5VSzdwZ0RaVUFRbzJvLzJrNGRJb3VoZDZCekdBVU9ZRWdLUS81NUZw?=
 =?utf-8?B?WHlqakZUYjJrWUFwU2dqVHQyZVFZcEhBM1lOLzlGV1Q2WGVvRVJoclQ4c2tv?=
 =?utf-8?B?U1k0azdpSkNIbndFVmF1S2VlQXpSV0k1bnJpZmRVd2MxeEZTMExiNFIvUVlQ?=
 =?utf-8?B?R1dSNWVZMnlrL1Fhdk9LMTk4aWJJOWRZb29uWUhrbHM3bG0rZW9Ga1V0dk5v?=
 =?utf-8?B?aGh1aTR6MHdrS1NrN0pJM2c2TUVXZ3htYWU2RXdxb3JZc0pIZ0dabEp1NHBO?=
 =?utf-8?B?UW0rZGkvKzZ0WG1OU0tmdm9RVEZNVmo3b28xVkVXaWFURmJCcjVtOWxKZWJj?=
 =?utf-8?B?ZzNhQ25DRVZ1L05YRXFJOFRBbGVqZHFmb2ZFMkhuem5ad2dBZ0toVmdPUVlP?=
 =?utf-8?B?L284M2tZc1lWWjhJQ0ZOckJPSHBqVmRlREx0ZHJ3S2grcEk5MllNZEYwaEda?=
 =?utf-8?B?Rkw1TXd5WjAyTFBURDVzS3h3SlY2SFhwTUlUOE4xRHpxSGF6YTNhVTZlMVkz?=
 =?utf-8?B?LzQ0WUJLcDVaRmtYT21CakF6RUdVVHlVUDRVVW9rR0NmbTR4UXBMcFd1MVJi?=
 =?utf-8?B?TkVPQ2xvZGR5a0Z5KzRzTVVxcGV4Q0d2c3Azd2hDdEVlU0FDSGVoRktvaE9z?=
 =?utf-8?B?M3VSbUdwUk0vU1NvYVJGaXlqekVBRXRocHhBcE8veElRTkFCUTRldUEvOEhm?=
 =?utf-8?B?VnVDU1JkR1h6MGRuNS9RY3c3L0pyUDloQmtHaUQ4bDFBb0ZFRktKSG5pdW9p?=
 =?utf-8?B?S1ZFNEp1YXdGVTVOVkIrUzJoUHRJMkVmN1FSOWZ1V0JycitXS1FmOUdPVHVy?=
 =?utf-8?B?SlRWSytzODBqcENZOEU1NU85M2o0emovdUZaOGErdStpOHZhTUNwM3RYOVJa?=
 =?utf-8?B?Q1BVYUhBeXVWV3NhK0VhaWczQ1JEQjRBRW8vYm9Yd3Y2V2E2R2hxT3BxZEpJ?=
 =?utf-8?B?VXVEUGpvcW5FWXE3YXlFbUNSR2lmQktPOVpsZ0VsQVZUZzAydW4rUVN6bU5r?=
 =?utf-8?B?S2N3TE1MNEdxLzU5SXRpcm8vWGZkY2NCaWVUYVdJY2s3a1BHUmV6bFhrd2Rk?=
 =?utf-8?B?UXBxV2FwSmZaV0RiUi9WOWhsbExPTmEyZVJMUWsvazJVUXUwdWVHdDEwYmNP?=
 =?utf-8?B?RDN5Uk1IckZOQWNuOEVrTjAzZmU1aE5CM2d6OHRSNnNKWjlubG42MktSeTFJ?=
 =?utf-8?B?MXNDZkVtTTVYbVNPcmlzTnZwZFdReVZTczdlTlJBRVVRU2o1OWZjYzdTRy9S?=
 =?utf-8?B?c2xPdEdWWks5d2l1RGpXSTFPM1VzZzhONmUzQUFjQ3ZJNUxDQmo5QWg1Z1hj?=
 =?utf-8?B?Ty9hRHczTkVRSFFHNDluUjZ1TGpBd3RCd2hqdFQzbWJaUDhCNjMvVVR6aXVz?=
 =?utf-8?B?dFRZekUyb3VWN3lKdWVhbEtFWmwzS3p2djgvZVlhVXEzbTBNUVZyOGVueGNi?=
 =?utf-8?B?TS9nSVlUTFlqbHpCQ1ZzbHhCcnp0aithc2JnbldHcWxpZkY3N29VcGpKMk1z?=
 =?utf-8?B?SGFvbzR2cFZVYms0ZXVvQTVBRnpidTV4bkVtUDAvWDI1aVdzV0IxU1l3Y1hW?=
 =?utf-8?B?amlmVHR3dmwzemFkRFpxOWY4VTcxVFJZMk9qYXhYdE84QmIvbHJ0bC9zMmQz?=
 =?utf-8?Q?QEXhaGGW7Yu+NiYA0P?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8721.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51873941-2f13-454f-0090-08dec6c4d47f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 07:49:41.3998 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJPGy3fLaQ28NvGwxu9LF7rEpI+oMkdATGfW4YygSrBaVLpVyIHwqx6oLB2D1lQpgjoyFufnYY8aMw8qJYIVpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11101
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQgPG1hcmV4
QG5hYmxhZGV2LmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI25bm0NuaciDjml6UgMjA6NDcNCj4g
5pS25Lu25Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT47IHUtYm9v
dEBsaXN0cy5kZW54LmRlDQo+IOaKhOmAgTogSmVyb21lIEZvcmlzc2llciA8amVyb21lLmZvcmlz
c2llckBhcm0uY29tPjsgVG9tIFJpbmkNCj4gPHRyaW5pQGtvbnN1bGtvLmNvbT47IFllIExpIDx5
ZS5saUBueHAuY29tPjsgQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT47DQo+IENsYXJrIFdh
bmcgPHhpYW9uaW5nLndhbmdAbnhwLmNvbT4NCj4g5Li76aKYOiBSZTog5Zue5aSNOiBbUEFUQ0gg
djEgMy8zXSBuZXQ6IGZzbF9lbmV0YzogQWRkIFNHTUlJIHN1cHBvcnQgZm9yIGkuTVg5NQ0KPiAN
Cj4gT24gNi84LzI2IDg6NTggQU0sIEFsaWNlIEd1byAoT1NTKSB3cm90ZToNCj4gDQo+IEhlbGxv
IEFsaWNlLA0KPiANCj4gPj4+IEFkZCBTR01JSSBpbnRlcmZhY2UgbW9kZSBjb25maWd1cmF0aW9u
IGZvciBpLk1YOTUgcGxhdGZvcm0gaW4gRU5FVEMNCj4gPj4+IGRyaXZlci4NCj4gPj4gV2hpY2gg
UEhZIGRpZCB5b3UgdXNlIGZvciB0aGUgdGVzdHMgaGVyZSA/DQo+ID4+DQo+ID4+IEhhdmUgeW91
IGFsc28gdGVzdGVkIHRoaXMgd2l0aCBhIDEwMC9GdWxsIG9ubHkgKG5vdCAxMDAwL0Z1bGwpDQo+
ID4+IGNhcGFibGUgc3dpdGNoIC0tIGRvZXMgdGhpcyB3b3JrIGluIDEwMC9GdWxsIG5vZGUgb3Ig
ZG9lcyB0aGlzIHdvcmsgb25seSBpbg0KPiAxMDAwL0Z1bGwgbW9kZSA/DQo+ID4NCj4gPiBIaSBN
YXJlaywNCj4gPg0KPiA+IEkgdGVzdGVkIHRoaXMgdXNpbmcgdGhlIEFxdWFudGlhIEFRUjExM0Mg
UEhZLiBUaGUgaW50ZXJmYWNlIHdvcmtzIGNvcnJlY3RseSBpbg0KPiAxMDAwL2Z1bGwgbW9kZSwg
YnV0IGl0IGRvZXMgbm90IHN1cHBvcnQgMTAwL2Z1bGwgbW9kZS4NCj4gRG8geW91IGtub3cgd2h5
IGlzIHRoZSAxMDAvRnVsbCBvcGVyYXRpb24gbm90IHN1cHBvcnRlZCA/DQo+IA0KPiBJIGFsc28g
bm90aWNlZCB0aGUgc2FtZSBpbiBMaW51eCwgYW5kIGFsc28gd2l0aCBEUDgzODY3Lg0KPiANCj4g
SSB3b3VsZCBleHBlY3QgdGhlIFNHTUlJIHRvIGR1cGxpY2F0ZSB0cmFmZmljIG9uIHRoZSBTR01J
SSBidXMgMTB4LzEwMHggaW4NCj4gMTAwL0Z1bGwgYW5kIDEwL0Z1bGwgbW9kZXMsIGlzIHRoaXMg
bm90IHRoZSBjYXNlIHdpdGggTVg5NSBhbmQgU0dNSUkgMUcgPw0KPiANCj4gVGhhbmsgeW91IGZv
ciB5b3VyIGhlbHAgIQ0KDQpUaGlzIGlzIGEgaGFyZHdhcmUgbGltaXRhdGlvbiBvZiB0aGUgaS5N
WDk1IE5FVEMgaW1wbGVtZW50YXRpb24uIFRoZSBTR01JSSBwcm90b2NvbCBpcyBjb250cm9sbGVk
IGJ5IHRoZSBpbnRlcm5hbCBYUENTLCB3aGljaCBkb2VzIG5vdCBzdXBwb3J0IDEwMCBNYnBzIG9y
IDEwIE1icHMgb3BlcmF0aW9uIHRocm91Z2ggc3ltYm9sIHJlcGxpY2F0aW9uICgxMHgvMTAweCBk
dXBsaWNhdGlvbikgb24gdGhlIFNHTUlJIGJ1cy4NCg0KQmVzdCByZWdhcmRzLA0KQWxpY2UgR3Vv
DQoNCg==
