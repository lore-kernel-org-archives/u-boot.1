Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F398CF259B
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 02:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DBBC87F19;
	Mon, 14 Oct 2024 04:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="hp2HIZP9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB03987F19; Mon, 14 Oct 2024 04:23:10 +0200 (CEST)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com
 (mail-tyzapc01on20713.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2011::713])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D8D187D1A
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 04:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chiawei_wang@aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjIBb941LFd6rxU5/1YVUGW3xHWvNPxF5XiDeE+IMNyJscsMTSdGJJOD8Dl6CiCbgc7K3hHRPYgAZTKrofH6PHCOhtsMES5IbUeEOKU59YpxlHphFbltFdeD9WVXvW3KrsvRGvAU/7x0K45Dy8/8V8GdCWHZu90eKEFxRSGKQF+j04yZJhzMPKuvSoReCdQfoWysKMO1Tyid0FS0ZNTp8sDiFeVEjb89SASQqLA6oRjry1dh5dTdIg6iY5aDonhFq/dtX094G9GCNB2t35bhBxynBY3Nv+h5p5tJjU2fQlI10jpIloUlEPZtzVrXGmHyqPyG/g404fa6psldF5meIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/6d65PjxQKhL/cbXCHAjraSzHd9Y7iksrgIWi0/qms=;
 b=jpn8/WCHb2oaTrYcsVQJpElCuL8lLcDUP5PtCY1B3sl0J/UStksPVBgWtaphNw9708e/hAsd0TquVtMUuFiTdzH+a9f8Rded3cjnd0k5hzoPbtVznqSPw87BnllDcrSm2iwspM4tf4FTVNbuJWBmu+sgy2X1YaMx0aqBCb7XhD0wmIny6rNBreLTU4Suvmynj6/J3KP602ICwlUE9KCjP5WQFe/4zikEkCFv7J+RnKhFJqivfoXUxQMSHdeDfI9Acrw5r/iK1kQj09T4gWJ0RKwZfu9/QSD4LyVNYk9LfL8A/Nc1ODCzRbOdPCiNZHffObeTZhXWa4rzw3oqrscncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/6d65PjxQKhL/cbXCHAjraSzHd9Y7iksrgIWi0/qms=;
 b=hp2HIZP9Q1K7YoZ6ZmvnESGUxwidjLiOaVbJQwUM1brQi75ZrveIyj+kXkTc6SJ0Woun6iB75rFVfANUZ0Q4AkDdEbHAzoathUlEcKQQU33Y0qPk/5QonWZkrlVNDufyhvwVpaxP+xL/cAUx85rb+Mb5sPG+3RXId9li9D/KlDrt+i3xqLQQiy/yPiniP486TLCyEf+A6pWZGHgYql7Ii1d6nLpbU37VzC5RTdkQpFw2ND0cqQXfPfb/+w4tKjjc3i14sQ7fAjhphxqA7Xq1CWixxqi8PSWubrgUJUW+K8E+lIVtW5vSt8gjf7cbo+J/aoJcZWNHLu39gIHLxoLuYg==
Received: from KL1PR06MB6652.apcprd06.prod.outlook.com (2603:1096:820:f9::5)
 by JH0PR06MB6581.apcprd06.prod.outlook.com (2603:1096:990:33::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.15; Mon, 14 Oct
 2024 02:07:40 +0000
Received: from KL1PR06MB6652.apcprd06.prod.outlook.com
 ([fe80::edf3:95b5:1ae2:7c27]) by KL1PR06MB6652.apcprd06.prod.outlook.com
 ([fe80::edf3:95b5:1ae2:7c27%7]) with mapi id 15.20.8069.009; Mon, 14 Oct 2024
 02:07:40 +0000
From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
To: Tom Rini <trini@konsulko.com>
CC: "sjg@chromium.org" <sjg@chromium.org>, "bob.wolff68@gmail.com"
 <bob.wolff68@gmail.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v2 0/4] aspeed: ast2700: Add Caliptra ECDSA driver
Thread-Topic: [PATCH v2 0/4] aspeed: ast2700: Add Caliptra ECDSA driver
Thread-Index: AQHbHAPZYq+0BgiifU6B4/27KcA+IbKFg2yA
Date: Mon, 14 Oct 2024 02:07:40 +0000
Message-ID: <KL1PR06MB66520BE44E681DE928BEF15491442@KL1PR06MB6652.apcprd06.prod.outlook.com>
References: <20240927030726.2211297-1-chiawei_wang@aspeedtech.com>
 <20241011173429.GA527278@bill-the-cat>
In-Reply-To: <20241011173429.GA527278@bill-the-cat>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR06MB6652:EE_|JH0PR06MB6581:EE_
x-ms-office365-filtering-correlation-id: fc6b231d-dc13-4cb8-bc4f-08dcebf4fb5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SkJjQTRSRkZVWmoyQy9ZMUVjV3V1SDA5b0FyZ2phZSsyKy9iK2tpUXFkdGkx?=
 =?utf-8?B?OWZHT1ExSTJVdzZIZm5jQ1VSWGtRT01KNmtUcC9UQkg0anlKUzAwcEZLUW1o?=
 =?utf-8?B?WExvN1gxMExhL2MyRnlLelJXU1U2a0o5eGFzVTFSWm9OU210R2xuVml0bGVY?=
 =?utf-8?B?eUdsZURKakhHenIyRVBDUVhGRTJpWEpPQWhyTTZJN252VXJPQkxBc0psb1JN?=
 =?utf-8?B?eUcxVzJjT2p1MHFIZ01VWkhNV1pJU1BLdSttTk11RUU1YlB0ZlBSNzZMMC9C?=
 =?utf-8?B?NnJWL0U2My9FUXRhYmkwU0ljSFdrejhRYTVqYlN0TEc2YTBFRTU1WDFPUlA3?=
 =?utf-8?B?T0RBYkNRVERTUXc3S3ZpcWlsdTJ4K2NOcGx6UEtmWVFpL1RFbjdkajVPVkJ3?=
 =?utf-8?B?dTRLNUg5Y0tXVjlLMmhxWlIwM0xDSmN1bDczc2NRMWVGQ2hzNHh4dU1SZXp5?=
 =?utf-8?B?RVQ0MC8wdnAyaGJqVTQrSWZyL2d1TzB2VUU1dFdQTGhkcHlPOTZGYVZpNlpE?=
 =?utf-8?B?clRaUUFhSEZ3ZDNZc3VYM1FRNlV0ZGM4V0lsUEl1cDV1WVFlbC9OL253WEQv?=
 =?utf-8?B?VzhtWFJZM1k4M2s5KzRFd2lLcXhYL0hFUGdvNkp4ZzRKZVpySTgrcXA5SW1m?=
 =?utf-8?B?UDVTRG9YZlNmTHdUb1hvYWY0UnFLa1lwRFJOYzhRWGZsZzN1VTFYOXp0Q2hm?=
 =?utf-8?B?VWlvQmQva2pRdzF1MTgrZXRCdnU4NU5VelFGRDNkNm44WTFicGppZkV2SStP?=
 =?utf-8?B?dDJqM3ZDTWNJNmFoRkxsdVpJWjB0NUhkK0NPSjVoQzNZeUFOVzVrcFN6bCtD?=
 =?utf-8?B?aVhZT3VTdk1zVmVzdmpHTTE5aVVreWJxS0ZOaDB6bmUybTE0bXQwWVV6cStt?=
 =?utf-8?B?Rk1rZ3gzNWo1enUzTk9NdTY3aDJva1Z2dStHZGhBb0F5a2ROT0sxY0FRNERt?=
 =?utf-8?B?NnNCZFFWcFRXSkVHNEZCM2NZOHRsMy80ais5aStIUUVkeWloc2lpbDg2QW1L?=
 =?utf-8?B?VG05MmsxUlF1N3BNZWtzSjcxZExCMGRVU0k0MGhndXJwa2tLQjhuYjdJb2dr?=
 =?utf-8?B?d2FPMzRGU1N2OTZaeWllSjczWjZCdVJzZk92SlVnZ2RXZWZxTXVIRnZWclJ5?=
 =?utf-8?B?Tm4vY0RQMXYzSkY1VjNRV2pUTXpQYjZzZVFsVDdTTGhvdWREa2RQczFWTGFZ?=
 =?utf-8?B?LzUyT21vODFNVVVDWlJlWlNZemhhRFc5Rm93ZFdTMWRQZVBWL2x4NlJPSGRM?=
 =?utf-8?B?QTBGcXB3aElleE05Zk9Jb29ScUZkU1huZXk4Qm1OT1I2Ym9yc0E1aUZIMDRG?=
 =?utf-8?B?bjNHOVpHVlY3SmZIY2RPY3pXbWluVlhkRjNoRDNWSTBlZzJFeFpvVitGdHI4?=
 =?utf-8?B?SmNKOEtUbzI3ZllHbnJJMW1NeEpvdUw2KzFTNDdQd1YyR25RNUlvREpSRlU2?=
 =?utf-8?B?bloxYkpYWkRZdDlnakQ5QU9yUUlPMHIxVmdzZG9EaXl3bzJxYlE1U1RsS2tB?=
 =?utf-8?B?bk10T1ZGeS94UjZsWUdCL1haYXRubGlLR0ZsUWVmbnNNTE01MFdadlBGZzdy?=
 =?utf-8?B?aDJ4akFabE9KeExUZUdqRGw0ZzBkT21IUUlIcmJzeGZndnNFQkM2Vk5RU1J6?=
 =?utf-8?B?anZvZW1RNkhWSG4ranAxc2YxSCtYV0lYb2JIc1VnS1o3ZG04NldzZjE0WlFK?=
 =?utf-8?B?ZnlMcEZ0Mmg2eVQ1TzZxZTI2TnpwMElacHZrd3BFdHkweFZrSUw4T1F3eFB6?=
 =?utf-8?Q?65OVDVZvEznGJqdpZYDhEAFIBfmGMdPq7ZDY9ya?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR06MB6652.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0s0eEk1TGJlR1JWZ1JUUFdvejJrSFphcnFhRE5QQWs5bEkvUG0wdUVacUdV?=
 =?utf-8?B?RlpLMmtKREtsSHBIRks3WmJ6VzlJdmFmWllIR0xuRjV4Um1seHh4dEVWWGtU?=
 =?utf-8?B?RnhhTkVUeWRYb0QrTkpwajdCaUx6MkFxSHhVRkY1YVRMZmhZL0tmM1cyTUVU?=
 =?utf-8?B?eWJmdEtKb3ZBcWU0R1pPRXpKWkNFOFZrek05WUovQnlvZlhJK0RiaUlYRGxQ?=
 =?utf-8?B?QXBodFMxU1UxMU11ZS93S2RiLzYrVENnVUJ4TjNiZ3J0d0Q2S21qbWowOHRS?=
 =?utf-8?B?NlFzdjVHVjhwUDdZQVFjZjkwWmxjLzMzaUhxdlAyb1lIRWc1Q3Q1Y2tuOEVZ?=
 =?utf-8?B?ZHkydzFwbGNTOHp5YzFvbS9tVVpZdUpPc2FRYVVkVWgrR0xlUlU0Q2xjeTZj?=
 =?utf-8?B?UWNFM0x4VEVxQW0zWXQ2ZjhhUWxVMGFiWkxzTjloZDVjTWNGYWgwZVB3eGgy?=
 =?utf-8?B?Smx0Q3NhZHlMTFFSZEpEM1pHK01xRkJJRmRNWmhSRGgvMEFqTTBHQmNKUEx0?=
 =?utf-8?B?N0Z5Z0VIVHN5T20wdjUvNHMzcnFSMjZIS1NKSnFsMktuVHpTWCtZUUVpVFZ0?=
 =?utf-8?B?ZVl5THV0Z3kyNXdFQVZLL0VWTkI5ZDVNM0ZvQm5GK2RLcFRqNEV4c0cxSEVP?=
 =?utf-8?B?dGowM0IyWUVqZmxKd1U4OHp2Q3liOHRjeWxxU2RPRC9SY2Y2OXh3RDFNbEQr?=
 =?utf-8?B?eGpVdjVoRnhCZG93Ny9qamVxZkx4OVdTQXVxbmtPTUY5bUNyOWFobGVPVU56?=
 =?utf-8?B?WGNycmlQdFI4QnlMaFJIWTBCT3QxY0dCR2xsUG04YUFqUC95bWU5bkpCMXdh?=
 =?utf-8?B?ZUtsVUhsRkFaTWFhVjFKZDJsL1lZQTU2a3hPcXpFZWcyOVBFN1FsbjIrNnpR?=
 =?utf-8?B?UFovZm9Eei8wdTBUalFZdDNMakQxVlNXakN4bEpkNVVDRCswTlo2bXVRTGR3?=
 =?utf-8?B?TEJhRnYybGZwV3AvWlV1WFZkSS9vNWdvVVpSZ05ubXFHRW1yTVdFYlAwV21G?=
 =?utf-8?B?WDhjYU15Qk9xQUwxYXRyblllQVNKRFB3T0s2MVh5ZlFxcEdCZ1MvaFd4RGV0?=
 =?utf-8?B?aU9iREljMEU0K2w0czQ1N0FWTVNGZjZDaXdrTldUYXJVWFBINHp5dDZ0WU1Q?=
 =?utf-8?B?cjNxOUErVXlrYXE4aklnWk9FeDFhdHd5MkJqYTg1UmYyQkM3cjUrWUI0UE9i?=
 =?utf-8?B?U0t0eFh4aWoxaHdtcEtVRjM5R1FnQU9FSW4zSUN0eDM3dGVPWU1kZEw4T3pI?=
 =?utf-8?B?bC9IREVRYnArSitRVWJDb29aRGE4QUR1dlY5b00wZWhYQVppdE1TeXVBWTVM?=
 =?utf-8?B?VzVwbGhhSGxKU3Z5akVrYURSTkNzeFdFS2VpN2ZjQVd2Z3JIZzdXamp2Q0pH?=
 =?utf-8?B?TXpuRWdVUk0ra1IwQ2t1S0g1MS9IT1pTK083NFVIZXBzcDhFV1RaM2tHYnlV?=
 =?utf-8?B?elhZNVVKQjdINzJBOXIyZkYwclBLMGJhTnB3ZzZnM3ZMamYwWWVTT1BTTElS?=
 =?utf-8?B?c2Y3TmdJbm9RZXVSZEJTK3B3MUNhRm9Lb1VDbkhTRTFjZ0l0VHR5elNIVWtQ?=
 =?utf-8?B?VlVPRHk2Qm5NVXQ0MklRTzdpSjZtSE5ybkZFQUxEUDdvSFBoK0cwQVNUU0ph?=
 =?utf-8?B?anFRUnlYVFJUVSszL1lXYXc1WUswM0tCeHVpVUJJM2d0ZjMzdkdnc1ZWVnBm?=
 =?utf-8?B?eG5jc0FYZ2N0a2M0WHM1blBESTlMRlhsZVorVTh4c2JYbmczc21HNDE2aWdP?=
 =?utf-8?B?dmc0VXd4aVRpY3pCZVRkTjRwbWJZRmZML1BlUjI3S3YzMzdJMlFTaHJQK0t5?=
 =?utf-8?B?Umpocitkd1BwdzJsL0czQXFJeHRUTnpiZzFaS1F3TXRPZFU1TXd3bElLVThD?=
 =?utf-8?B?b2w2M0RRd2RPZEpCc2Z5Z3JoQWg3a1hYQ1hUdk1RVWllekViTnJTT2hLRWV1?=
 =?utf-8?B?NE1qbWc4aHlxRVhyU3Zta0xBV2hyeHRib1JWbEIwNWlRTmh6YWFScHVTbWdJ?=
 =?utf-8?B?S0ZXTDlsdDdwM3JwU2J4STlmVE9abzFDdVl1Yk53S0lrMEZ0amRBd3VtQnU3?=
 =?utf-8?B?K1dTd1FPK0dReVVWb0U5bk85aW10cXViU05rdW9RMjI0ejg0SFVXVzhwUE0z?=
 =?utf-8?B?TnJONFNZRGV4N3hDSFVmSUNXN0tmZGxJVVhsdmZ1VjFIQWhxcjdjVFZrdVNp?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6652.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6b231d-dc13-4cb8-bc4f-08dcebf4fb5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 02:07:40.0806 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zGdTx1lD8LA8MVHKqGEi2CnIHU1obGpkSshmBXfxLYiJv87NXWVLGTmEqmlZWoD+pPe1jilCie6LDZ1Ygj3JfRcUD4qwKx6Z4Thsul+IsFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6581
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

PiBGcm9tOiBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPg0KPiBTZW50OiBTYXR1cmRheSwg
T2N0b2JlciAxMiwgMjAyNCAxOjM0IEFNDQo+IFRvOiBDaGlhV2VpIFdhbmcgPGNoaWF3ZWlfd2Fu
Z0Bhc3BlZWR0ZWNoLmNvbT4NCj4gDQo+IE9uIEZyaSwgU2VwIDI3LCAyMDI0IGF0IDExOjA3OjIy
QU0gKzA4MDAsIENoaWEtV2VpIFdhbmcgd3JvdGU6DQo+IA0KPiA+IEFzcGVlZCBBU1QyNzAwIFNv
Q3MgaW50ZWdyYXRlcyB0aGUgQ2FsaXB0cmEgc2VjdXJlIElQLCB3aGVyZSBhbg0KPiA+IEVDRFNB
Mzg0IHNpZ25hdHVyZSB2ZXJpZmljYXRpb24gSFcgaW50ZXJmYWNlIGlzIGV4cG9ydGVkIGZvciBT
b0MgY3J5cHRvDQo+IG5lZWRzLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZXJpZXMgZmlyc3RseSBl
eHRlbmRzIHRoZSBGSVQgaW1hZ2Ugc2lnbmluZy92ZXJpZnkgY29tbW9uDQo+ID4gY29kZSB0byBz
dXBwb3J0IHRoZSBFQ0RTQTM4NCBhbGdvcml0aG0uIEZvciBiZXR0ZXIgY29udmVuaWVuY2UsIHRo
ZQ0KPiA+IGRldmljZSB0cmVlIGZvciBFQ0RTQSBwdWJsaWMga2V5IHN0b3JhZ2UgaXMgYWxzbyBy
ZXZpc2VkIGJ5IHJlZmVycmluZw0KPiA+IHRvIFJTQSBpbXBsZW1lbnRhdGlvbnMuDQo+ID4NCj4g
PiBBZnRlciB0aGUgRklUIGNvbW1vbiBjb2RlIHJldmlzaW9uLCB0aGUgZHJpdmVyIGlzIGltcGxl
bWVudGVkIGZvcg0KPiA+IEFTVDI3MDAgdG8gbGV2ZXJhZ2UgdGhlIENhbGlwdHJhIEVDRFNBMzg0
IHNpZ25hdHVyZSB2ZXJpZmljYXRpb24uDQo+ID4NCj4gPiBUaGVzZSBhcmUgdmVyaWZpZWQgYnkg
c2lnbmVkIEZJVCBpbWFnZXMgd2l0aCB0aGUgYWxnb3JpdGhtDQo+ICJzaGEzODQsZWNkc2EzODQi
Lg0KPiA+DQo+ID4gdjIgY2hhbmdlOg0KPiA+ICAgLSByZXZpc2UgdGhlIGNvbW1pdCBtZXNzYWdl
IG9mIHBhZGRpbmcgY2hlY2sgcmVtb3ZhbCBmb3IgYmV0dGVyDQo+IGV4cGxhbmF0aW9uDQo+ID4g
ICAtIHJlbW92ZSByZWR1bmRhbnQgY2hlY2sgaW4gc3RhdGljIGZ1bmN0aW9uDQo+ID4gICAtIHJl
dmlzZSBlcnJubyBhbmQgZXJyb3IgbWVzc2FnZSBhcyBzdWdnZXN0ZWQgYnkgU2ltb24NCj4gPiAg
IC0gY29sbGVjdCBSZXZpZXdlZC1ieSB0YWdzDQo+IA0KPiBQbGVhc2UgcmViYXNlIG9uIHRvcCBv
ZiBjdXJyZW50IG1hc3RlciwgdGhhbmtzLg0KDQpJIHdpbGwgcmViYXNlIHRoZSBwYXRjaCBhbmQg
c2VuZCB2My4gVGhhbmtzIQ0KDQpSZWdhcmRzLA0KQ2hpYXdlaQ0K
