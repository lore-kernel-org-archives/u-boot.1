Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B65C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:46:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C395188BBD;
	Wed,  7 Aug 2024 16:46:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BfnUdDHH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D79D388BBD; Wed,  7 Aug 2024 16:46:40 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B77B88BB3
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:46:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7XYfe76RsOPsMQGkE7R8gxYE6fybttnUNh1YftRXj8KQC4FTiZFOERrDkW9t0c4RpHVGyUvmFz17rvvFz9sAJK4dmgOEWxluWbfkJ6If9O8NJQFdOyLGOve4wTvt0HqV8+kE/qSeXWog7nn4vrOLt8s/Fh350NQr+1kawS2ZyJnZGMxxm1rcig4X1Xw8wmAzik21zwf0kK/LxYmfpICn12Bmf6iZGt8B34FljZjHRNjXrISh9ngBpMjjHPta7IbH3s9uQ3LHiXjzf45Mz6E+ns2nh/U0VqaVMGVh6H3+FWzLLNPCekvQeLTI1nnR9Vwu7boyO6VKxhc563Y6AJaqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ARmtJqPpRTQil6R6/zYlipW7FjOMCyHxpDaCNVrFoA=;
 b=XjAqhBemP5AoMxIhSwWGtT3MSzvnUVFEmRKhInusU1SQ+f03/tCfk5cYwAL/iBw6UzN4elpG0XgG4TKAY/O+MyawCt+Gitva4u7rcoA3ag3P8/F3HYl8OJRxdMb4Bd7eyt3Wwh15PgagWy4OsjFPThjtI6bkV9qNHHrg5HcrwNvku0u953dOYDTmudSYiY4LuRFXIRRfMTZXHUeIrWcR5DhcAhO22lvP2ogEcKJ8Q9Y7Y1PyuHpSyB6QW8qARW+fKbpkrEDXAoIPzy5bq01oZY2TZArFBtgBaXJ1yp3J0QDX57/zviqdjg7AgagTxK9KsZF1xUVOHpd7r78NMRa9Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ARmtJqPpRTQil6R6/zYlipW7FjOMCyHxpDaCNVrFoA=;
 b=BfnUdDHH2Uc39/OrDjZ9EmWjsg7A1bZ+WFERjgCXvsl1eDdEioCfZYpCQW6n+p7mg4HHXmP6SlL+PyuAdOe+d/7RpZvQoNUv+jrDSO5K6Mc5OXSgoT6Dvni1IOKSKNsL6zMGlBFpzklAKfMwgzZqx5dz51LileNm6zpSuI1Yieo=
Received: from SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17)
 by SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Wed, 7 Aug
 2024 14:46:33 +0000
Received: from SJ0PR12MB6685.namprd12.prod.outlook.com
 ([fe80::92b0:daca:e351:d6bf]) by SJ0PR12MB6685.namprd12.prod.outlook.com
 ([fe80::92b0:daca:e351:d6bf%4]) with mapi id 15.20.7828.016; Wed, 7 Aug 2024
 14:46:33 +0000
From: "Kummari, Prasad" <Prasad.Kummari@amd.com>
To: Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "git (AMD-Xilinx)"
 <git@amd.com>, "Simek, Michal" <michal.simek@amd.com>, "Abbarapu, Venkatesh"
 <venkatesh.abbarapu@amd.com>, "git@xilinx.com" <git@xilinx.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>, "n-francis@ti.com"
 <n-francis@ti.com>, "d-gole@ti.com" <d-gole@ti.com>
Subject: RE: [PATCH] cmd: sf: prevent overwriting the reserved memory
Thread-Topic: [PATCH] cmd: sf: prevent overwriting the reserved memory
Thread-Index: AQHa5/lJkycRxizd30e+eRTPuO/PwLIaxW8AgABpZSCAAK+VgIAAAimg
Date: Wed, 7 Aug 2024 14:46:33 +0000
Message-ID: <SJ0PR12MB668508ED115E8ED8DB3CF57582B82@SJ0PR12MB6685.namprd12.prod.outlook.com>
References: <20240806120659.686073-1-prasad.kummari@amd.com>
 <CAFLszTgAiRBih1JOtqvBEi8QbVc4-yV7Mq3kam=_FRgw58mtjg@mail.gmail.com>
 <SJ0PR12MB66851EC7FDDD9A61A63E4DE982B82@SJ0PR12MB6685.namprd12.prod.outlook.com>
 <CAFLszTg9VemEeiHkOzh+jnQ84y34V3A+EPU2_YaOJgZwhn=7GQ@mail.gmail.com>
In-Reply-To: <CAFLszTg9VemEeiHkOzh+jnQ84y34V3A+EPU2_YaOJgZwhn=7GQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6685:EE_|SJ2PR12MB9085:EE_
x-ms-office365-filtering-correlation-id: fe0333b5-8089-4fa3-46fa-08dcb6efbb25
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RE1VT3FrSXBTaUJnWXRMM3ZtS2FLTVMxTzVtaXBVcVhCZVhPUVF5UXduZ2V4?=
 =?utf-8?B?dGZiQkpwQ1Y4dWpxdkNmNHdzSDU5ZmpMV2E1VllHMWR4R0pINmtZZWNYekNI?=
 =?utf-8?B?Vmt2bGF4VzBYai9zbjN3Y2pIdkdBemw1VFd2a3dSOVRML0hsRE1KSlUwaFht?=
 =?utf-8?B?L3dkQlZybTNjb2swMWdEa3Z3NWdhdWVMQVg4V3hCUnV6WXArVUUzRUw5aG1H?=
 =?utf-8?B?UVRuckU1S3hZc2FRRHBCOVZLQ3RPdnJPajVGT2IrSXFzdTlieE1qejhRSUdN?=
 =?utf-8?B?WmVCdlpUc0JKeUlUM1NwbEgvVEVIdTVhNU5VVUNWR3gxNlhqKzRFbnVha0da?=
 =?utf-8?B?RXNTZUJtWktXV0xQWUR5dXVidmsrSkF0TTRIZDdpUTh1TzkxQThYZWRNNDkr?=
 =?utf-8?B?dzRsOGJZNDhPTU54RFhIMWE4MGxGNW14SlM2UzdZWGdQRjhqNFJzK2xLc0kr?=
 =?utf-8?B?VDFQTWc3Q3VZSVk0MTAvZ004MUo4YVdURFFBcDhiRXBZS1piMERXRHNkSytv?=
 =?utf-8?B?YXVZNS9kL3ZXamcvQkh5Y0trc0pEaDdjZTJHRWdTY0hGdFRqRldJWDZSTEFw?=
 =?utf-8?B?UEZlMGFuYzUzUGRkeGMxT0I5Z3lic2tyNy8wT1pEU3p4b3BVREJNVmFXZWVB?=
 =?utf-8?B?VUhSM0NVOEpMb0pQdFJlTURZZEpJOXYrL1dCcHIxOXRwK1Y1bk1vUmVEemxZ?=
 =?utf-8?B?Z2dwSUtGVCtqalNqL2d1STR2WS9QRjJlYmg4OVh6UVNFNVRjN3IwbHYwdkRJ?=
 =?utf-8?B?ZzFBVkZQUUpwTmxyblF2N0ozSmEweVFjTTNuOHdvMXk3Q2gwZFl3WVZlRE5Z?=
 =?utf-8?B?NXludlQwVnJMM1RuS0drQ2VqeFFOVzE1U3dVb1ppa0FLWGNKelFOUmZiWW1P?=
 =?utf-8?B?c0c5NEtzNmFuQS9jeGZ5TGNkY2c0cWNzMXJoTE02QmZ2UnFJb2ZNR3BVYStZ?=
 =?utf-8?B?UGtRZUFxRVBKVjg4ZS9nV0oxMFJxdWYxRzg2SGlVSGhETlV5bFpJQ1hMZnBE?=
 =?utf-8?B?QzI2Y1UyWTlUR25YV2RMQUtMZWRsNFJsbWdqR00zRHdxZWI0ZEtlQVBjbHh4?=
 =?utf-8?B?YkhnalFrMERZaE8rVmVRRUt5RnBPNkk5TUFNWkpwNk1ib3N1NFhkRmR2SnIz?=
 =?utf-8?B?dnZJbUx4bE1FWktDS3FYcU1OWVkwS2ZGdlRMQTlxR3FSdWtBZkJFbDdvZ0RU?=
 =?utf-8?B?YzdSeTlORkNpK2xHeFAyR29rUDAreWIyb0lDaGpBL2trOHh3MTdBT1NsZnhU?=
 =?utf-8?B?d00wQ2Z0VFlpN3A5ckZEZCt6eDlwbUZOMXZPYmFvaE54eTRLUSthREZvcWJv?=
 =?utf-8?B?S3dHb0xoeHdqb0RNanRQVVFSTjNZOXlSVjVwZHZhMjJ5elRFM1dnS0VhbHdY?=
 =?utf-8?B?SURRVUU5SUZVV3cydVh5ZXJPVjVZZ1hpR2tQOFpGNEJwRTdVZk9ZelRDVzRj?=
 =?utf-8?B?ODZrMUhnRmJXekVLeTlVNVVDZnZpSmJFdUkzNFZ0Y21EU2dUa0VFbVdSZ3Bj?=
 =?utf-8?B?UU01c2lDRWMrME5qZzVwQTFlSGpSS0pwZWNLTjFTTkc3OERVTkpoeXJxbG5t?=
 =?utf-8?B?cTZibmozajZJU1lHWER1QUJQT0Y4aW91MXU3SldVdUE2K2JsMlBnOUw0ajdP?=
 =?utf-8?B?K0k4NWNTMndiZ0U5bVJqUlNZOXVLQnJLTmFHTENjNUMvcU5rN3l6SUZYQkRG?=
 =?utf-8?B?amIyNDlmQVNNcFVxQmZjZjkyandpdHBxeUZTb0dGLzY3MDNORjlzcGRJa0dZ?=
 =?utf-8?B?aEpDVWdYOXdKbm4wOHU0WGViK1lwdWxNV2t4V0tKN2gzbjExZ0xZM2U5RXBH?=
 =?utf-8?B?Ym9NRlVKUHM4dkZGd2NyM0RHV1NxbVgvUmVUK3pkdGdqK2dPYTVFUTNoYTgv?=
 =?utf-8?B?cHZCZlo3ajZYSG93TlRwZGtEU2tDT1h5aHJpeHNBVmpDR3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THRvZWhsTmdCNktTT05kemFOYWdsRHJ5TkdpUUJVdkVjYm5NNEptcXZET1pw?=
 =?utf-8?B?REtBNFpCVjhSaEdvV3VwWlpINkJicHBSN3FnVitucmNCS3l6VlhGcVgwOFpF?=
 =?utf-8?B?NVkxYkhaN0p2bnA4aTdiMUFSK3pKTmtrakRMUnFTcTJRY050TnYxaS9URFVV?=
 =?utf-8?B?RVRwK1dQY0QrdHZzQjYyN0hiaHk4Q1hWR01VQUJXREk2TlVWVWVydzVVeFVU?=
 =?utf-8?B?cEZobDZUMzRwL25OWllDcTh5YUhkTmR0OGJEa2NYYzkyR2VVSTh3d3JrMG1U?=
 =?utf-8?B?UGtVYXFoeWJqTWhVT0s3c3JRSmcvTmRTR1RoUXMxNzlpWWJNSWFUM3RQdEk0?=
 =?utf-8?B?T0hLOVYzQmxsa0JYam55MjBjdERwbEU1R0lEQkNldGRwMjR3Ris1OE40UjZG?=
 =?utf-8?B?S0VyYnJDWW1idjEweExQT2V1NWM5RVkzQk9YT2xhQ1NWald3Z3dhTHFQU1ll?=
 =?utf-8?B?dmUyTkx2V1hlR1F0UVlFdUJIRVp2NDliL1FVNnZIbUNCa2VLZlJkNXRudmgx?=
 =?utf-8?B?TS9WNTg4cERMeVNMdlJGVlBFcFlZSGh5dUZ2SGNaUFB4MkFRd05lcDF5aDhn?=
 =?utf-8?B?RGcxVUZ2MlluemVnY1cyakdnQnBxdzZ1aUs5Z2pka2dvc2pqUndZTTZQcFVS?=
 =?utf-8?B?YWs0TW1pS3VmdUpzenhvVzN1ZW8xTUpPQmVEcWRSQVBJWWNBOFRRUWNKK1Fk?=
 =?utf-8?B?Q2NqQ3ZBQVl2c2dCblArbzVKZW1pcWMvblQ1NDIyZFhkL1JTNGtsOWhhZFoy?=
 =?utf-8?B?ZlduNnhvS3I2b1RwR3J3bC9Ub1FrTTZTVUxneS9JL0VERzhkMDhHaFRkMS9s?=
 =?utf-8?B?YlFPYlNDOGU3YmNxQUlHS2dCTHA4UGZKTElqN1hhWHB3NzFUNDlNMzljV2Yr?=
 =?utf-8?B?SXE1QXlWS1RoSllKTkdPamFkRnNGaHNFdFlJcnJncEU0ZXdYTXdVdUFTMW5h?=
 =?utf-8?B?QmxLOFBnckdJYUNacDJWT29ZYks4Y05ncjVPNFZaNUpndkpnUG9WRHJaSVpk?=
 =?utf-8?B?aHEzdDRMR1hLTjlCNDNKYm5kbUoxblFobnBZU0VObHcvaFgxTTNicWlTMVRx?=
 =?utf-8?B?UXphaEtqUkZEN0dzWlVBVUJHbDlqeHJ6L3V0RFJHNkcvZGFzeHBycVl4b2k5?=
 =?utf-8?B?K1NldDJlUFFKZ0pOYzcveE9hMERNMUhEUjRlYXZ3WUNQcFUzOHk2Q1V5WWFo?=
 =?utf-8?B?dDZIYU50NG9admphQXp3dGFWZ1JQNjNOc1ljemVVMHRUd1JXRW50a0R2aUV4?=
 =?utf-8?B?UDZhN1dxRFBqR1lMY2I5aEVTZnRlOTA2M2VyWnVTdkVWMVNWY1RCQVp1Z3E4?=
 =?utf-8?B?UVFLMG9VQTVMN1RZdytvTDZOandPZUEzRWY3MU9MYW1IUUVEdERtd25sS0wx?=
 =?utf-8?B?WlFzZTRtWDh2L1Y4dHFXWDFlTlZZSjB6OE5iZ0lrL1lVT3JDa0M4SXVxRndk?=
 =?utf-8?B?WGFuZUwrZjJMdjExRnlNQ3VYY2lGUU04eCtzTGh2b2IrbVRnQ1o0N0xTRHJq?=
 =?utf-8?B?OGQ3c1ZxRklQM0huOXRMdXZCVUtCUFJTdnBNNXB2MHJqMk9kT3BScXoyM2R3?=
 =?utf-8?B?OGpCOHVMK01MT0Rac1h3bTEwQ2p1b28yN3VwSFFlOVZHbE9XZ1h1TkR5NVBK?=
 =?utf-8?B?Q1R0UkFxbUdUSlBjVSt1ZmRtdkpSNEFhQ1pRV0lncnQ3OWFVeHdUR3dCWDlW?=
 =?utf-8?B?S2xiSldkdE16UlZTUWtBY3l4RGRyVXlYMU1tVCtTSk1ZS203aWZwYUNjdVp6?=
 =?utf-8?B?b0lPTWg2WHpOVTRnTVoxMVJKblpPblBpdGtBcGt4MC9BaUV6b2x5cmIzYXlW?=
 =?utf-8?B?VFR6S0JMODBOYUJMVkRsVGVmUUR1Z3A2eURvTE90NEphRTdyc005a0h4dC84?=
 =?utf-8?B?V3hMNzZRUEhzc21PUXJRVUhwUHRLNUVYOGM4dnJCaXM3ZmkyanlzdjRlcHhx?=
 =?utf-8?B?TWV4TG1zVm5VdC9DZTVKZ0JFQlFuNWx2cXQ2eVFySzNQM000NzBDNWpkM0xW?=
 =?utf-8?B?ajVObnA2ekVZaXNKTFBKMFpRR2FhMk9NOFNBY05JV3p3aU9hUVlSc3ExOUVa?=
 =?utf-8?B?dWlVclRWcUt3RHo1cXpRM0IrZVg2cS84Z0cxSW40djV0WlhDdUk3V3JRRjl2?=
 =?utf-8?Q?Tbm8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0333b5-8089-4fa3-46fa-08dcb6efbb25
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 14:46:33.2953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bSZkTg1oFxCTpj7hW2OwWqfkfPUX4YWajvD7tm80EKSlqgMiy10xYwbkyjdAG9Gi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085
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

SGkgU2ltb24sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ltb24g
R2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDcsIDIw
MjQgODowNiBQTQ0KPiBUbzogS3VtbWFyaSwgUHJhc2FkIDxQcmFzYWQuS3VtbWFyaUBhbWQuY29t
Pg0KPiBDYzogdS1ib290QGxpc3RzLmRlbnguZGU7IGdpdCAoQU1ELVhpbGlueCkgPGdpdEBhbWQu
Y29tPjsgU2ltZWssIE1pY2hhbA0KPiA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBBYmJhcmFwdSwg
VmVua2F0ZXNoDQo+IDx2ZW5rYXRlc2guYWJiYXJhcHVAYW1kLmNvbT47IGdpdEB4aWxpbnguY29t
Ow0KPiBqYWdhbkBhbWFydWxhc29sdXRpb25zLmNvbTsgbi1mcmFuY2lzQHRpLmNvbTsgZC1nb2xl
QHRpLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjbWQ6IHNmOiBwcmV2ZW50IG92ZXJ3cml0
aW5nIHRoZSByZXNlcnZlZCBtZW1vcnkNCj4gDQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmln
aW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyDQo+IGNhdXRpb24gd2hl
biBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4g
DQo+IA0KPiBIaSBQcmFzYWQsDQo+IA0KPiBPbiBUdWUsIDYgQXVnIDIwMjQgYXQgMjM6MDUsIEt1
bW1hcmksIFByYXNhZCA8UHJhc2FkLkt1bW1hcmlAYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBI
aSBHbGFzcywNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZy
b206IFNpbW9uIEdsYXNzIDxzamdAY2hyb21pdW0ub3JnPg0KPiA+ID4gU2VudDogV2VkbmVzZGF5
LCBBdWd1c3QgNywgMjAyNCAzOjIxIEFNDQo+ID4gPiBUbzogS3VtbWFyaSwgUHJhc2FkIDxQcmFz
YWQuS3VtbWFyaUBhbWQuY29tPg0KPiA+ID4gQ2M6IHUtYm9vdEBsaXN0cy5kZW54LmRlOyBnaXQg
KEFNRC1YaWxpbngpDQo+IDxnaXRAYW1kLmNvbT47IFNpbWVrLA0KPiA+ID4gTWljaGFsIDxtaWNo
YWwuc2ltZWtAYW1kLmNvbT47IEFiYmFyYXB1LA0KPiBWZW5rYXRlc2gNCj4gPiA+IDx2ZW5rYXRl
c2guYWJiYXJhcHVAYW1kLmNvbT47IGdpdEB4aWxpbnguY29tOw0KPiA+ID4gamFnYW5AYW1hcnVs
YXNvbHV0aW9ucy5jb207IG4tZnJhbmNpc0B0aS5jb207IGQtZ29sZUB0aS5jb20NCj4gPiA+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGNtZDogc2Y6IHByZXZlbnQgb3ZlcndyaXRpbmcgdGhlIHJlc2Vy
dmVkDQo+ID4gPiBtZW1vcnkNCj4gPiA+DQo+ID4gPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3Jp
Z2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3Blcg0KPiA+ID4gY2F1dGlv
biB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5n
Lg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBIaSBQcmFzYWQsDQo+ID4gPg0KPiA+ID4gT24gVHVlLCA2
IEF1ZyAyMDI0IGF0IDA2OjA4LCBQcmFzYWQgS3VtbWFyaSA8cHJhc2FkLmt1bW1hcmlAYW1kLmNv
bT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IEFkZGVkIExNQiBBUEkgdG8gcHJldmVudCBTRiBj
b21tYW5kIGZyb20gb3ZlcndyaXRpbmcgcmVzZXJ2ZWQNCj4gPiA+ID4gbWVtb3J5IGFyZWFzLiBU
aGUgY3VycmVudCBTUEkgY29kZSBkb2VzIG5vdCB1c2UgTE1CIEFQSXMgZm9yDQo+ID4gPiA+IGxv
YWRpbmcgZGF0YSBpbnRvIG1lbW9yeSBhZGRyZXNzZXMuIFRvIHJlc29sdmUgdGhpcywgTE1CIEFQ
SXMgd2VyZQ0KPiA+ID4gPiBhZGRlZCB0byBjaGVjayB0aGUgbG9hZCBhZGRyZXNzIG9mIGFuIFNG
IGNvbW1hbmQgYW5kIGVuc3VyZSBpdA0KPiA+ID4gPiBkb2VzIG5vdCBvdmVyd3JpdGUgcmVzZXJ2
ZWQgbWVtb3J5IGFkZHJlc3Nlcy4gU2ltaWxhciBjaGVja3MgYXJlDQo+ID4gPiA+IHVzZWQgaW4g
VEZUUCwgc2VyaWFsIGxvYWQsIGFuZCBib290IGNvZGUgdG8gcHJldmVudCBvdmVyd3JpdGluZyBy
ZXNlcnZlZA0KPiBtZW1vcnkuDQo+ID4gPg0KPiA+ID4gVGhlIFNQSSBmbGFzaCBtYXkgYmUgdXNl
ZCB0byBsb2FkIG90aGVyIHRoaW5ncywgbm90IGp1c3QgYW4gT1MuIFdoYXQNCj4gPiA+IGlzIHlv
dXIgdXNlIGNhc2Ugb3IgcHJvYmxlbSBoZXJlPw0KPiA+DQo+ID4gW1ByYXNhZF06ICBXZSBoYXZl
IG9ic2VydmVkIHRoYXQgU0YgY29tbWFuZCBjYW4gb3ZlcndyaXRlIHRoZSByZXNlcnZlZA0KPiBh
cmVhIHdpdGhvdXQgdGhyb3dpbmcgYW55IGVycm9ycyBvciB3YXJuaW5ncy4NCj4gPiAgVGhpcyBp
c3N1ZSB3YXMgbm90aWNlZCB3aGVuIHRoZSBURi1BIGFyZWEgaXMgcmVzZXJ2ZWQgaW4gdGhlIERl
dmljZQ0KPiA+IFRyZWUgYXQgYWRkcmVzcyAweGYwMDAwMDAuIFRoZSBzZiBjb21tYW5kIGlzICBj
b3JydXB0aW5nIHRoZSByZXNlcnZlZA0KPiBhcmVhLCAgYW5kIFUtQm9vdCByZWxvY2F0aW9uIGFk
ZHJlc3MgdG9vLg0KPiA+DQo+ID4gRVg6IFRGLUEgcmVzZXJ2ZWQgYXQgZGRyIGFkZHJlc3MgMHhm
MDAwMDAwDQo+ID4NCj4gPiAgICAgICBWZXJzYWwgTkVUPiBzZiByZWFkIDB4MGYwMDAwMDAgMHgw
IDB4MTAwICAgICAtLS0tPiBPdmVyd3JpdGluZyByZXNlcnZlZA0KPiBhcmVhLg0KPiA+ICAgICAg
IGRldmljZSAwIG9mZnNldCAweDAsIHNpemUgMHgxMDANCj4gPiAgICAgICBTRjogMjU2IGJ5dGVz
IEAgMHgwIFJlYWQ6IE9LDQo+ID4NCj4gPiAgICAgIFUtYm9vdCByZWxvY2F0aW9uIGFkZHJlc3Mg
cmVsb2NhZGRyICAgPSAweDAwMDAwMDAwN2ZlYzIwMDANCj4gPg0KPiA+ICAgICAgIFZlcnNhbCBO
RVQ+IHNmIHdyaXRlIDB4MDAwMDAwMDA3N2VjMjAwMCAweDAgMHgxMDAgICAtLT4gT3ZlcndyaXRp
bmcNCj4gcmVzZXJ2ZWQgYXJlYS4NCj4gPiAgICAgICBkZXZpY2UgMCBvZmZzZXQgMHgwLCBzaXpl
IDB4MTAwDQo+ID4gICAgICAgU0Y6IDI1NiBieXRlcyBAIDB4MCBXcml0dGVuOiBPSw0KPiANCj4g
WWVzLiBUaGVyZSBhcmUgbWFueSB0aGluZ3Mgd2hpY2ggY2FuIG92ZXJ3cml0ZSBtZW1vcnksIGUu
Zy4gdGhlIG13DQo+IGNvbW1hbmQuIEl0IGlzIGEgYm9vdCBsb2FkZXIgc28gdGhpcyBpcyBub3Jt
YWwuDQo+IA0KPiBXaGF0IGltYWdlIGFyZSB5b3UgbG9hZGluZyBoZXJlPw0KDQpbUHJhc2FkXSA6
IFdlIGFyZSBsb2FkaW5nIFRGLUEoYmwzMS5lbGYpIGF0IGRkciBhZGRyZXNzIDB4ZjAwMDAwMC4N
Cg0KPiANCj4gUmVnYXJkcywNCj4gU2ltb24NCg==
