Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59842CD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 03:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 422BD8488A;
	Wed,  6 May 2026 05:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="O63Fyy+o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D275A84815; Wed,  6 May 2026 05:57:21 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EB2A847F6
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 05:57:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Manikandan.M@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7YmYjButnkWbtS09BRi0xsZgLJPdI1Nw2U1PovvkQZusxSmLPnqPMM+MH5S8f7Gk6nVvfWaIF1VRuceuDZpqTYp5/zcmJ0o4jdfvD9fqp8NsbBkuvrwrCwgymoUtr4KnxPt2jefCn/TVLmXuxNPdUsPq3iltwiUwZ5YvzXr21LtZ7AJ3DCWMFWCAEwpE07aXgwnVmAt1JlRtci6FY07T8BVjXqugop6NQd5gIM1HnpdX/TVKxBzE8HmFYLcOE2ETT7mJyBOfUcibIBkB4sPFxh8nSWQbo9Do6dj2w1Itqyo9jMtQKB/KyPYhJD0Z1gZsl1fsfV+gFL54dQ2O3OM4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9EYEd1CFyym6X6Om7q3Gq552ssBl2H9fq6n19c0qqM=;
 b=DT9SYfyV41Lxfi74IY6OTMgwfbgVXGReoSQKVE6iWmpR/uR9SYv9DIsO6yqIuUgnt3SaiW3jEJmchtDN52hptCBDQR3VuPioSry+MXUf7UcvqOCqos0Z7kB+hS7feoUKRF/SmPWrQUTAz/lzNjT+H2ZEqveXggxNecVi7/gcblbskyX5ePne/cqPUu7LuGCOd7IgtIEnnfUajeTJ1AEUeMJaIL1rT6euRkCwKvgo3PbtwBXxKeaRcZO5JY5uri48U/Lk0aIDVCw3aQfq7vGKZ7rQkPllw5CXeD3izMbZnTIboL+Wz6ocsH65vomsRr6FkweqpltFYlybBAJ7zYQRxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9EYEd1CFyym6X6Om7q3Gq552ssBl2H9fq6n19c0qqM=;
 b=O63Fyy+oh8eyXR1C1BXqnIqm5pCAJU0I/C3oD4k96sJNwQZNdrs6q+dMG7XowzlD0eXj6a2/PKtLQhwGYln+Vn8y//E7zC3rgK3ZTnJ4Uai0AO7B6yVf+WH4R7UMCvUGRcOaVgKKO8n2p39ReuUYHIV87PASSngU76LraZWvGfrFbVa+W1qTZFU4vLXd1/aLXrZ8frNrm/bQYfEH8C9j+q6JsTOmBgWEKPJ1+chZQbzOIBN+v4m80wkYG52QAeeDwB34kK/HL8UMugxqv5GNih8KCKSspwLE6IKowfsE7PJ+I6YhMZwcuhkXIf82Uw+0ZMEl8dzLEW3CSYcI1FuNYQ==
Received: from DM3PPF9623118BD.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f3a) by PH7PR11MB7663.namprd11.prod.outlook.com
 (2603:10b6:510:27c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 03:57:15 +0000
Received: from DM3PPF9623118BD.namprd11.prod.outlook.com
 ([fe80::ad98:5674:dd4c:875d]) by DM3PPF9623118BD.namprd11.prod.outlook.com
 ([fe80::ad98:5674:dd4c:875d%6]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 03:57:15 +0000
From: <Manikandan.M@microchip.com>
To: <Charles.Perry@microchip.com>, <u-boot@lists.denx.de>
CC: <jerome.forissier@arm.com>, <trini@konsulko.com>,
 <pranav.vinaytilak@amd.com>, <michal.simek@amd.com>
Subject: Re: [PATCH] net: phy: mscc: add support for the VSC8572
Thread-Topic: [PATCH] net: phy: mscc: add support for the VSC8572
Thread-Index: AQHc3Kbil4v90bpbHUuKhOeFzORLobYAX4gA
Date: Wed, 6 May 2026 03:57:14 +0000
Message-ID: <ac2ab58a-f540-42bd-8e50-95dc9b634079@microchip.com>
References: <20260505135750.3137160-1-charles.perry@microchip.com>
In-Reply-To: <20260505135750.3137160-1-charles.perry@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF9623118BD:EE_|PH7PR11MB7663:EE_
x-ms-office365-filtering-correlation-id: 3fa21e76-da81-46be-3e67-08deab238f63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: gBOK2u52U7+dIiqCm1sMnBb5R/hynbpP7uUxmxcKHvMrBT9OMGglZgT/bngujhcji11DvK/fn81zh+Ly9/TRNtSHf9dbADhcmevqJmC0cL/zRi6yvKtvvvICy+3V6QruQPoc8jknRGb/uvrqPUxVokSrljFhFIPD7L1Er8wh1L2TZY6R4mRtbfwMFX6n8FRBkjdbwSvlCV8hLa1ZO/TEADvrqUiB3NIKC0bfD5MaRvkIvrxKlQqCbYqIjrJYk+t/Hj9rGmQLgzw+ejyRGdNNEQ3ST+/KwwlcunkWTH4HVybugdC7ca+p8F7YSIKbap4mmg+wkBgJ41mnLF3zIiVfqZplpglhObISvV/e3nQybCerrR4R3dO4BwWZKZI+DJZO86IiABvVFaPPrabI0Y+HItw3AgqP/WTTNiuUPdLLSvmIm5MJEc4oGzoJyx61S7asYJDVyqayGbDtaWzB5ayVaQLHtBW3ta7eNn3oHX7qpTAPhE82HC9FJ1tTfy7CNRdfBIMxgW1uA6HtZnPgO2ktuJ1h2csEulmWv+8S26efM0hsjgB8MyrJDu12urT40JctvdsEYBIjgW5az1X1hgrnK1zp/ssAiLMcN70t7NOtr9zGWv9kNns7NKO4KrSN2AHfH635/DaEmtZi/hYqJI3cerSrzxLKrjrFoTWktY/nnT7qNa6ctWSafajsnnCejkd6ZfXCspHdlJaQnwh2GVhQse1z7gaUL70y8ii3L8ZtH8InnsHQtXPYNZ76W/C5dijZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF9623118BD.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlBKWFVNQVd2K1kzUDIzcUNZZ2hNbWxsOXN4TDNaMy9NVlE5UDZ0cjFPR2ND?=
 =?utf-8?B?cGVqbWlPSTBiNUZLWXVad1RDajBaZmxhSCtSdDVRdFF4L0RUWWh4WERsOVJ5?=
 =?utf-8?B?a3kyQzk2a3JYNksrZys5L0dOTW4vRitpOWhDUnh6NitFdWZyeS9xVkVlSkly?=
 =?utf-8?B?aEpHMHkwYnNORVNsN0VtdTFJR0FGVFBYNlJidkNkMEx0TndpNnlYNy9WUTBO?=
 =?utf-8?B?SXcwdW8wWEZrbk8yTlNFemVlbnVvaDJPQWNqblBORTBDdWNzZVVVV042TFZB?=
 =?utf-8?B?Rnc5b3dzamIrU2E0WXNXbzkyeWIreG83Y2RNVmM0cnY4VjZBV1lwUmhTVzZG?=
 =?utf-8?B?NGlxVG5hQnBBUGNwMFZYL2NJTXloUFhWc2tNUXNYdnY5Q3lCN0JqbkpsbFZN?=
 =?utf-8?B?d0x0elgya1JPd0g5bXBZUDh6TU9rM2hVb1RxOTR6bVV5WGVYcFROVTVpUnJj?=
 =?utf-8?B?Z0pEaHVPTkl0MjhOVE1GcmZzSUtpcVVRd0M0UElFUGhvcXJCU05OTFBhbjJT?=
 =?utf-8?B?amxxTWFNSnc3NUVrelJGL1BJN1RhdytYTzRLWElibHRkbU9lenNncys4TFZk?=
 =?utf-8?B?dW5lcDhxNEZwS3JqWEJDTHBCTEJFNXIweC9IaXpTclpBTTVZZ1dkUnZNbUtW?=
 =?utf-8?B?QlN4YTlOaXdhbko0NXp0K3VhNjUvNEdlRmRlY1lvcUxNRm02Ni9mcndEOFky?=
 =?utf-8?B?dmsrT1NwMEhSTXZQaDVrQk9IWGxBa1NpU2VqQ3pQQ2s2YjVIeG8vRXhvVlJX?=
 =?utf-8?B?dzUvb3VkK28rMVErNHF0djNRZXp3RE5JOU9MOVdDZXVHem9QUUIzSjNMSGYw?=
 =?utf-8?B?Z1VPT1pjMGNwWERjUGYvdHpjUDZTbTRjd1FZQy9LZVV1bWJMTWEwNmJlZWVQ?=
 =?utf-8?B?eWEyRWFBak5sK1FLSzl2bk1lS0dTeDE2VEt3RUc3dysyMmlqR2xEbHM5WGpD?=
 =?utf-8?B?eHlMZm1JWDZIN1JoTWF0RWFJNzJGMG5UTFdWNUFFUURFcDcvYTV1WEQ4eVEx?=
 =?utf-8?B?Slc4OTdTWXZNZExuakpxVG5obXZyMUxqL3l5ZU1pMENueUV5cUd6UitTaXRF?=
 =?utf-8?B?S3pjNzJlYVNMOG1udW9kcmkrd1Z2T1EwQzRIVG5HNW85TzA0cnlVbHJRcFA3?=
 =?utf-8?B?amx1amhNM3h4RnFBREtMYk5QR1QxYnFlTEo2WGtHQUFTZzdaR1dwaUw0a1lI?=
 =?utf-8?B?TENVbnRnMDZEbm1rRndIUlJwOFpqUUdVdEp6NFlVUkFVM2Z3dlRvR1BaeElY?=
 =?utf-8?B?ZXRMMWtod2pMVlV1THFCT2pjV3FLQk1Nc21nUlNqc3FCeEtjcmpMeVEwcGhT?=
 =?utf-8?B?dHdER2V5WGZUdnBTNEZnWXNuc0U4d04waDNUK0dlb3FvUlFsSnpBWDJtMEF5?=
 =?utf-8?B?YWJma0tBSVBIaElMOUtteUZVcS9DZ2JNdVk2ZzRxZUU3TVE1cHhZZm85SENj?=
 =?utf-8?B?TE1ZQ25aV1BVcUhSNEQwNWUrVk9YOUJ2b3l2Z29tRFMvRmI4dXpKSjhNNkEr?=
 =?utf-8?B?VEhpSVNGd0FINE15b3IycjNQYWRwa1NyUW1CNkNuOTh2bE00b3J2MzIxcGNG?=
 =?utf-8?B?Y1E2R0dRNlUwMU1uSlM1bUhROU1lWTgyenh1L0dlc243b0VlWkt1NW5KMGpq?=
 =?utf-8?B?MFJoY0poaE04aWtFR2tUcjRaeWlYOTBESG1NL2VLVkRyRTYrN1lMamdxZzFD?=
 =?utf-8?B?QXp1dlgxT2JoNmhGM2hnSFkwQ1VvbEk1bWw5VDB2ckRoZFBFVVJBYVMrQS9H?=
 =?utf-8?B?aFpENnQrK2VjOEl3b3ZIcUhFblF4aVY4NkZoRFpNNzVTUjNETXcwNGpNZlJY?=
 =?utf-8?B?WUFGVVhhOG5qejhtRzc1THk5bmlSZmlkUUcvNUxhUXNJUTdDOGZmSTkwbU5X?=
 =?utf-8?B?Q3ZIczl5SzErZGpQK3lvYTBPSnRhSGd6VkNWbThoS3lVSk9Iem4vb2c0L2xj?=
 =?utf-8?B?aEE2bmxPZW00TS8vVEtyMUYvUE1icWJvR28rc2NHdzZZMTJ0TDUwZVhlN0JQ?=
 =?utf-8?B?UW9CQ0EzbjYzV1BMSUpMRWNFMElEcDNFU3ZkLzZ5bGd5N1k0VmZPc2MranFV?=
 =?utf-8?B?a0RMYWhjdnRYV1pQNXJ6dDZQSlFldkp5ZzgvUXRpQTJncDl4UG1EdnZUdnQ2?=
 =?utf-8?B?ZHV4UE1YWTNEeWVsSEF5ekZvUXBkOTFITkhyZDNreENaRUk2U0dFWUlleWJY?=
 =?utf-8?B?MDJZK3BuZG5Nb2pveGhOOUxtVmlXaXc5ejBMVWZpK3gzQXZRVkNMOEdENkJo?=
 =?utf-8?B?Ky9nWEFycElKTSt0S0x5ZEk4bFI5RG55Wk1KTTlyVTJWbEorbzZuaDB4d1dU?=
 =?utf-8?B?ZUVmd2REL3ZGNUhUVTBVV2RLc29na3N5ZncyVTNpeW5LV29NRmpWQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85EA4692AD4D244E857C4F2B6255DB64@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF9623118BD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa21e76-da81-46be-3e67-08deab238f63
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 03:57:15.0407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lgmyEPigpECJZznLuaz0hFr0ThiDiU1ayqlQiKq9J4CzAxH84uZ1oV6t4dIPqlq5KxTok6pZLQvLGflb7jHwt+N4YTX7y4hEIdrblu0CQ2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7663
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

T24gMDUvMDUvMjYgNzoyNyBwbSwgQ2hhcmxlcyBQZXJyeSB3cm90ZToNCj4gVGhpcyBpcyBzaW1p
bGFyIHRvIHRoZSBWU0M4NTc0IGFjY29yZGluZyB0byB0aGUgTGludXggY29tbWl0IHRoYXQgYWRk
cw0KPiBzdXBwb3J0IGZvciBpdCBbMV0uDQo+IA0KPiBUaGlzIHdhcyB0ZXN0ZWQgb24gYW4gSFgx
MDAwIGJvYXJkIHdpdGggU0dNSUkgKFBJQzY0LUhYIFNvQyB3aGljaCBoYXMgYQ0KPiBHRU0gTUFD
KS4NCj4gDQo+IFsxXTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2RmYWJlMzlhNTJlZmNk
MmNmZmY5MzU4ZjI3MWI4NjczMTQzNTAzYjguMTQ4MDQ5Nzk2Ni5naXQubmVpbGwud2hpbGxhbnNA
Y29kZXRoaW5rLmNvLnVrLw0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hhcmxlcyBQZXJyeSA8Y2hh
cmxlcy5wZXJyeUBtaWNyb2NoaXAuY29tPg0KUmV2aWV3ZWQtYnk6IE1hbmlrYW5kYW4gTXVyYWxp
ZGhhcmFuIDxtYW5pa2FuZGFuLm1AbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9u
ZXQvcGh5L21zY2MuYyB8IDExICsrKysrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDExIGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9waHkvbXNjYy5jIGIv
ZHJpdmVycy9uZXQvcGh5L21zY2MuYw0KPiBpbmRleCAxNjM4N2VlYTQxYjguLmRkN2ExMDA0N2Ji
YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvcGh5L21zY2MuYw0KPiArKysgYi9kcml2ZXJz
L25ldC9waHkvbXNjYy5jDQo+IEBAIC0yMyw2ICsyMyw3IEBADQo+ICAgI2RlZmluZSBQSFlfSURf
VlNDODUwMgkJCTB4MDAwNzA2MzANCj4gICAjZGVmaW5lIFBIWV9JRF9WU0M4NTQwICAgICAgICAg
ICAgICAgICAgMHgwMDA3MDc2MA0KPiAgICNkZWZpbmUgUEhZX0lEX1ZTQzg1NDEgICAgICAgICAg
ICAgICAgICAweDAwMDcwNzcwDQo+ICsjZGVmaW5lIFBIWV9JRF9WU0M4NTcyCQkJMHgwMDA3MDRk
MA0KPiAgICNkZWZpbmUgUEhZX0lEX1ZTQzg1NzQJCQkweDAwMDcwNGEwDQo+ICAgI2RlZmluZSBQ
SFlfSURfVlNDODU4NCAgICAgICAgICAgICAgICAgIDB4MDAwNzA3YzANCj4gICANCj4gQEAgLTE2
MjMsNiArMTYyNCwxNiBAQCBVX0JPT1RfUEhZX0RSSVZFUih2c2M4NTQxKSA9IHsNCj4gICAJLnNo
dXRkb3duID0gJmdlbnBoeV9zaHV0ZG93biwNCj4gICB9Ow0KPiAgIA0KPiArVV9CT09UX1BIWV9E
UklWRVIodnNjODU3MikgPSB7DQo+ICsJLm5hbWUgPSAiTWljcm9zZW1pIFZTQzg1NzIiLA0KPiAr
CS51aWQgPSBQSFlfSURfVlNDODU3MiwNCj4gKwkubWFzayA9IDB4MDAwZmZmZjAsDQo+ICsJLmZl
YXR1cmVzID0gUEhZX0dCSVRfRkVBVFVSRVMsDQo+ICsJLmNvbmZpZyA9ICZ2c2M4NTc0X2NvbmZp
ZywNCj4gKwkuc3RhcnR1cCA9ICZtc2NjX3N0YXJ0dXAsDQo+ICsJLnNodXRkb3duID0gJmdlbnBo
eV9zaHV0ZG93biwNCj4gK307DQo+ICsNCj4gICBVX0JPT1RfUEhZX0RSSVZFUih2c2M4NTc0KSA9
IHsNCj4gICAJLm5hbWUgPSAiTWljcm9zZW1pIFZTQzg1NzQiLA0KPiAgIAkudWlkID0gUEhZX0lE
X1ZTQzg1NzQsDQoNCi0tIA0KVGhhbmtzIGFuZCBSZWdhcmRzLA0KTWFuaWthbmRhbiBNLg0KDQo=
