Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E501EC01CD
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 11:58:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD5ED84114;
	Mon, 23 Mar 2026 12:58:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="B7oiP/tM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAB808412F; Mon, 23 Mar 2026 12:58:23 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA27584099
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 12:58:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUmVvurxnlR8N/d34Rp3Cn8yV0U5WD3ez8TMsOTIxuUin0cKyseLdy4/cXxcp0HA/j+jYNc795pIhh+giVAIfbgscvUUe5at+QyRCcFzvwClvqnWDLLo5foHVxTdd0UxRFwFMhhVR+qbiBkp0y54CnSTr6J+crCSEsMQEXKXLlnEQcmcJKmKqOHGALEqvED+SPHvWN3LzwnUhaskq0T2d0I+9FkGfyLO7R5VCcyjeLQfRhT9+lSKRjFfCaeqywk5Fv/IhjCu5RqTA/5ousU9aiIobjao4KTdpfj18Vwgnizb7Ps60AVUa6qy8QYYxMXlDKb+T/7PgbAVVgx5EzwaJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfV5fbjpsykraeMsORQdaBoMRb6k4RDI71Ch5LyiKGc=;
 b=hk+CG+LvYcRcVHT1ro/LPWglfwswYIdw+sBJaJxnyAQI3FZ4jcuJrgaJJXQgZgbhHp3mhatWGy6zMkwt1DrCELw262RehdBPFAV2Ewn1s8HhOfNPZhltlt1jCv/cLYSN+3soGq8JOyDZxpQBWVHPT4UGrYHstGA8iwTxZxPNOMUHbc8VAtSRef1a8NHo4UJy/l0sMzgtBc385D7oh72wQiYb683XskoTRiWbjWFV65jd4wbSBZ1nR+dyTu71M2fiXIpYufkQU3pWRtSrzQ8OeGVMLLN31lOTU+C67BgzVlOWY+iRHlhD6TzNVnLL85owE4YGRQLPPoly+u2oCxQbxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfV5fbjpsykraeMsORQdaBoMRb6k4RDI71Ch5LyiKGc=;
 b=B7oiP/tM8W4uH2gPYSJvdeJA544T3CW3X5FtxpxAkRAH6ywUoWo9IgNi6rkDOkS4ByHlYLmqCcSscZ/fXP9gaM5Ywy4SUoN6YPC6UlkO6T1xArVro3PqLifbWPJWoFnrwzN5ISTcnt0LioCfkcXPJPHeVSIOFDkBOf5IhBLShTFZvRAdI5fXo4UcZNyimZOvCOxneqVrmK7wmKD8jBCrG1/GaBTng2ZuJv8yZ3Q4mcHXyg0WvhwfVEL+K/RKr+akvWZYFnUdbbMiPcGho9szniiFx9TdzQXJozrR9Xw7ZQDyCzyJwUCh9PIXQrIUq6YGHJyJM/bWnqbzQCz71RXkXg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU2PR10MB7881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:496::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 11:58:18 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 11:58:18 +0000
From: "Sverdlin, Alexander (SI B PRO TI EAC CCP)"
 <alexander.sverdlin@siemens.com>
To: "y.moog@phytec.de" <y.moog@phytec.de>, "alvin@pqrs.dk" <alvin@pqrs.dk>,
 "trini@konsulko.com" <trini@konsulko.com>, "l.anderweit@phytec.de"
 <l.anderweit@phytec.de>, "quentin.schulz@cherry.de"
 <quentin.schulz@cherry.de>, "charles.cc.zhang@gmail.com"
 <charles.cc.zhang@gmail.com>, "jerome.forissier@arm.com"
 <jerome.forissier@arm.com>, "marek.vasut+renesas@mailbox.org"
 <marek.vasut+renesas@mailbox.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] net: tftp: fix malformed option string parsing
Thread-Topic: [PATCH] net: tftp: fix malformed option string parsing
Thread-Index: AQHcurTxvX839aFr+UyHXZA9aqPUTrW8A0AA
Date: Mon, 23 Mar 2026 11:58:18 +0000
Message-ID: <63086c74fc1885ded988325e3a3e474310919493.camel@siemens.com>
References: <20260323110516.84423-1-charles.cc.zhang@gmail.com>
In-Reply-To: <20260323110516.84423-1-charles.cc.zhang@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU2PR10MB7881:EE_
x-ms-office365-filtering-correlation-id: 12c7664c-dfe1-4cfb-4693-08de88d37921
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|55112099003|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: j9VcYKitEOJCLQL9zOVhiXIV6kzSSB4W2yuQ8cW/1PGy92aHjaqqXTaEt8nqLfuST9uoTzvPbSdKHaPy8vSrvMoJYSV69ShbGXBPOKpssEc2FIixif6Z+PcPR/wPhjGHJDRx2suLMTrcCF7fNnIZI4O8eSBNR4krtukeUYFJfEkF9LTyqE06DhWZqUC6E8KzmpSaKfCh0+GMxSAks0Uui2bXCPtYD0V3V9za8a1sNqX+vJBMLH7bH0CJvE9/iVtDiJbC1sot+Qt627UKbDoidfTnInlPo1hBO901ZA9SYaG3Q48Q78c6B5vnnLNaCG3J1xFCjig+Mo3MtTvhgWFSWXkxbCMeLRhLhnhkNhgcQrG1wVThjv0kpd/OHyGlPs4Z9cmoZ2XNi/7i/YNSb6TGVMffrUmN+tRnL2FhVaQF/Tmm1aIy0NUw808jbA4iHiu2qSHAQjoDgOAZttCFzbyVXtZZsAGBySKMBhLttNpTzmhPMXBH9f1pk4QKughXblcFeuNX5rJqM6wJatMieuRcCZFeUeL1LH5iXg15g+eNkqWklQR1pxSlMCkbV0kY7bA/Lj3fmlTe9oz9xpv4EpHPfVjLjGOSladScnBQLorK7Tj/khhSt4jNTC6UaT1qjUml29rbiWQvo69gBYUVdxgKPa3pMosoPjxYPohc3KgeGqBGePdyB4Ml7FyK+V5iFHAbUrzqEnjviTB/PD9jlHnx9E6t9RlyysyM4DUgBHQHBT+AAowveVMbOWmFC28um/rH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXVyU3JMV1cyaEpBU2d6dW91eUVNSkZ6QkdaSUZsbHRxVE1vUnMwcUtyV2xN?=
 =?utf-8?B?M2ZzMW9pbXh2ZFpzdVN1bGw2MVNMckxoS1ZvNGJGSXNBVmNXbmVwV3NRZ0Mx?=
 =?utf-8?B?ZkJ0OEc3azBFS0hlSG43WkFWaytMMjRZWDZ6OTQ3eHphTFErTnRFN0t3VjNF?=
 =?utf-8?B?bHJCZTN0dlJDYmt3UjFvalRLN0hVZSt5M0t6REQ2aEF3SVl5dWJwOGZQVVpu?=
 =?utf-8?B?bkxrc3BwOGltMlZzTGxpdlJGMU1ac1JOQlArelhUZ0JOdW1INE4ySEpzUmpr?=
 =?utf-8?B?MjVBZkFDRTEyaTR6UlFOdEl1aUhPREU2WVNVdHdkYWRyNkkyQTQ2R1R2R2VR?=
 =?utf-8?B?NW5lYStHcStJMGVERDEvNTJkN3pXVHJOQzBkczZudjI2OE9nOUhLMWsxMUk4?=
 =?utf-8?B?QmY5NW43L1pwTDF4NXBpN2Y3ejNOTzFNQ0M0MlA2TGhoTEZQZ3ljQ0pWbUtj?=
 =?utf-8?B?REc4eEVkY1Y4elNxR2tQTGtXNFJtWXg3NlowQms5K2VySnN6SWZhS0t2OFds?=
 =?utf-8?B?SW9DZysweWdYMU9tY3V0RHl2QVBONVhGd0VuNEMyZzV4MmxVU0xESVFnTU5K?=
 =?utf-8?B?K1VjMXVNcFU5bTFQNzMrYVRESlczcS9iUXNEYzQ3N0psY2Z2cUZwQVNwMFp6?=
 =?utf-8?B?Z1BxZTVDVFJTL1FKa0Q3RW9ETDZabTFvd01nVlczNmhzdTlpQ0svV21xWGVx?=
 =?utf-8?B?YlE0SENCY21jVTJ0SDlsNW10UGF6WXN5eER5VDh4S3lPUnZiSTJRU05oWXA4?=
 =?utf-8?B?TE5EZ0szY0NoUC9qaHBkbnFsRWM3YUozcTN3VHFtU2FyTXpIOEpwSzhZTWNK?=
 =?utf-8?B?czFOYTFkOHR3eHFSNjQzL2R3VGNIdndaYXBKb2xFcklabkxaaWh2TzZHWko4?=
 =?utf-8?B?b1oyc05ySHZESnFkc1hnNTh3Z1ZUTSt5R3ZkdERUc3VTaytsMDVLK2VOU1ls?=
 =?utf-8?B?cEQxY2V4ZHR3cTVYK1Nya3hCR2F2emZWMVliWnpDR3AzNXoyRnhURGVGcG1U?=
 =?utf-8?B?VlE4T1RTWXAzVzZzRjdWeENGRHNjM1hkZGIzNUltZHplWnBCai9RVUZrb1F1?=
 =?utf-8?B?bzlpM1ZiNzJtS2RoWVU4UEZiaEdha1BOeVVOZnE2U3Fhc2ltZ3JUN2xQM0Fr?=
 =?utf-8?B?eVVreDBrMHZianI1Z21ieGd6dzFlUkRIV3R0WjRRMGVDYjE5bng4ekxPSlNZ?=
 =?utf-8?B?YmN4YjE3b0JsMmIvM2dCTEdpOTVpTlZId0UzelB6WUFZNTJUNlV6am9jemVP?=
 =?utf-8?B?S3A4Q2YvWExyMEhzSHdmOFkwZkFsK092SEE5bjZISjJ0OWVPaWlFTDkrd29Q?=
 =?utf-8?B?dXQ4Q3laTEhHT1ZpdmlDL3hqTEhuNGJWcjJnd1JidHFwNi83RWhxMmEzRDRj?=
 =?utf-8?B?R0VGT04xUjBuNTZEeThMR1YyazRKRlo4eGxlRGVNcUJaYlNncUg2cnRCTlNz?=
 =?utf-8?B?L1M3LzQzdE1BYUdYbSt0NzdsbDBkR3BiU2xPL1hsTlh0UVp1dzdCRnV6SzZq?=
 =?utf-8?B?U0tLOGlvaTRLZ3V3bnNhSVR0ZC91MEhIUUJiNm5mbWdsL3ExSzhLdlh3aVJW?=
 =?utf-8?B?Z0VEK1NzMEo0eGY5bzhQdGhKTytpRDJtMkFBb01OeWtlQ2dKUjIxQ3M3eFNv?=
 =?utf-8?B?RTlGMlhZOEZ5MEVCTUU2cG1vUTdhYXJPbGpMYTAvWGJMVVBlVjIva1F0cUxK?=
 =?utf-8?B?VmVyUjR1cDRBTk90YWI1R09aalJUZjhSdTJVamVTUSt4Y1MxVVh5YVdBTGtJ?=
 =?utf-8?B?VmdiNWJLaHlIZEUwak92K1g1OXYyZTFETy9NMGFZbXAxZlBqTW5HSVF3Q2dv?=
 =?utf-8?B?U3BORWtaQytlMEs3eENwUXBaZ1BEdFhIZFRvTFNERzdNWWl1cjM3aFd0cE82?=
 =?utf-8?B?bWZOc2hYUkJJN0Mvc0ZlS0prYy9KQ0tjOG4rRm1ieTd0YXluak13ZXZZZHVu?=
 =?utf-8?B?ZDd2NFRPQ2lZbkVoYW5GRmF5NStyOXI4dUw2RGxBN1YvYzloVlo1aXd1RjRW?=
 =?utf-8?B?ZGsybTJiMDlLSERmTnpOb0ZSVTh6cHQ1OWJ1WHBJNE5ETTV2TFVPaFc0blBH?=
 =?utf-8?B?eWlkdjE5VEJjV20wcGhESE5QNlNmN25kbnF6ME11RFV4Q004Ui9QSHRlOHA2?=
 =?utf-8?B?dGh1K2ZaYTUwQVFjTmRkcVhoaHdvMFBXNnhSK0xTMVZoYnRCZzZMQUFJU3Yx?=
 =?utf-8?B?ZFlRWUxCa3lEV2c5TnJBdzVtWU0zcVdjUVpjVThTZ2c2SW93MnZRK0E2WFN1?=
 =?utf-8?B?VWZadGlCdVJQT3FDQWx6aUhSVityQXhGQTYza0Y3bnBKdmNkVzVSRTAxM29C?=
 =?utf-8?B?Y0lweGZHOGtkS3VSL0NCb1plRGNZV2FORGpGMzZPc3RHWXpxak5BSkpLZFBN?=
 =?utf-8?Q?/l4ABmY45R20ZilQF9aVpWDXH6OsS1YMygElI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49D54546B258E14FB0CB028F8FDD8D64@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c7664c-dfe1-4cfb-4693-08de88d37921
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 11:58:18.4577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 96UmOzNWjH+rskW2RorXwSJOFuYjc7Y+v3Oc4wnolLP+K2v3lgWcv7PGey7ho0V7Tm0/chg62wEcPfLsGMB9KT7ycKDMVmVUuUJ0G4e3f2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7881
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

SGkgQ2hlbmNoZW5nLA0KDQpPbiBNb24sIDIwMjYtMDMtMjMgYXQgMTI6MDUgKzAxMDAsIENoZW5j
aGVuZyBaaGFuZyB3cm90ZToNCj4gV2hlbiBmb3JtYXR0aW5nIHRoZSBURlRQIG9wdGlvbnMgKHRz
aXplLCBibGtzaXplLCB3aW5kb3dzaXplKSwgdGhlDQo+IGNvZGUgcHJldmlvdXNseSB1c2VkIHNw
cmludGYoKSB3aXRoIGVtYmVkZGVkIG51bGwgYnl0ZXMgKCVjKS4gQmVjYXVzZQ0KPiBzcHJpbnRm
KCkgcmV0dXJucyB0aGUgbGVuZ3RoIGV4Y2x1ZGluZyB0aGUgdGVybWluYXRpbmcgbnVsbCBieXRl
LA0KPiBzdWJzZXF1ZW50IHNwcmludGYoKSBjYWxscyBvdmVyd3JvdGUgdGhlIHJlcXVpcmVkIG51
bGwgc2VwYXJhdG9ycy4NCg0KSSdtIG5vdCBjb252aW5jZWQsIHRoZSBhbmFseXNpcyBleHBsYWlu
cyB0aGUgb2JzZXJ2ZWQgZWZmZWN0LA0KDQo+IFRoaXMgY2F1c2VkIHRoZSBvcHRpb25zIHRvIGJl
IGNvbmNhdGVuYXRlZCBpbnRvIGEgc2luZ2xlIG1hbGZvcm1lZA0KPiBzdHJpbmcgKGUuZy4sICJ0
c2l6ZTBibGtzaXplMTQ2OCIpIHdoaWNoIGJyZWFrcyBzdHJpY3QgVEZUUCBzZXJ2ZXJzDQogICAg
ICAgICAgICAgICAgICAgICBeXg0KLi4uIGFzIG1pc3NpbmcgMCBieXRlIGJldHdlZW4gJ2UnIGFu
ZCAnMCcgaXMgbm90IGV2ZW4gYXQgdGhlIGVuZC4uLg0KDQo+IGxpa2UgYXRmdHBkLCBjYXVzaW5n
IHRoZW0gdG8gcmVwbHkgd2l0aCBlbXB0eSBwYWNrZXRzIG9yIGRyb3AgdGhlDQo+IGNvbm5lY3Rp
b24uDQo+IA0KPiBGaXggdGhpcyBieSBleHBsaWNpdGx5IHVzaW5nIHN0cmNweSgpIGZvciB0aGUg
b3B0aW9uIG5hbWVzIGFuZCBtYW51YWxseQ0KPiBhZHZhbmNpbmcgdGhlIHBvaW50ZXIgdG8gZW5z
dXJlIHRoZSBudWxsIGJ5dGVzIGFyZSBwcmVzZXJ2ZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBD
aGVuY2hlbmcgWmhhbmcgPGNoYXJsZXMuY2MuemhhbmdAZ21haWwuY29tPg0KPiAtLS0NCj4gIG5l
dC90ZnRwLmMgfCAzMyArKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9uZXQvdGZ0cC5jIGIvbmV0L3RmdHAuYw0KPiBpbmRleCA1ZjJlMGEyYmMwNi4uNWE4
MDk0NzkxYWIgMTAwNjQ0DQo+IC0tLSBhL25ldC90ZnRwLmMNCj4gKysrIGIvbmV0L3RmdHAuYw0K
PiBAQCAtMzU1LDIwICszNTUsMjkgQEAgc3RhdGljIHZvaWQgdGZ0cF9zZW5kKHZvaWQpDQo+ICAJ
CWRlYnVnKCJzZW5kIG9wdGlvbiBcInRpbWVvdXQgJXNcIlxuIiwgKGNoYXIgKilwa3QpOw0KPiAg
CQlwa3QgKz0gc3RybGVuKChjaGFyICopcGt0KSArIDE7DQo+ICAjaWZkZWYgQ09ORklHX1RGVFBf
VFNJWkUNCj4gLQkJcGt0ICs9IHNwcmludGYoKGNoYXIgKilwa3QsICJ0c2l6ZSVjJXUlYyIsDQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXl5eDQouLi4g
b2YgdGhpcyBmb3JtYXQgc3RyaW5nLg0KDQpBcmUgeW91IHVzaW5nIFVTRV9USU5ZX1BSSU5URiBv
ciBub3Q/DQpEbyB5b3UgdGVzdCB3aXRoIGNvbW1pdCAxYmMxMjViZWNhYTUgKCJ0aW55LXByaW50
ZjogZW1pdCBcMCBhcyAlYyIpPw0KDQo+IC0JCQkJMCwgbmV0X2Jvb3RfZmlsZV9zaXplLCAwKTsN
Cj4gKwkJLyogV3JpdGUgInRzaXplIiArIFwwICovDQo+ICsJCXN0cmNweSgoY2hhciAqKXBrdCwg
InRzaXplIik7DQo+ICsJCXBrdCArPSA2OyAvKiA1IGNoYXJzICsgMSBudWxsICovDQo+ICsNCj4g
KwkJLyogV3JpdGUgdGhlIHZhbHVlICsgXDAgKi8NCj4gKwkJcGt0ICs9IHNwcmludGYoKGNoYXIg
Kilwa3QsICIldSIsIG5ldF9ib290X2ZpbGVfc2l6ZSkgKyAxOw0KPiAgI2VuZGlmDQo+IC0JCS8q
IHRyeSBmb3IgbW9yZSBlZmZpYy4gYmxrIHNpemUgKi8NCj4gLQkJcGt0ICs9IHNwcmludGYoKGNo
YXIgKilwa3QsICJibGtzaXplJWMlZCVjIiwNCj4gLQkJCQkwLCB0ZnRwX2Jsb2NrX3NpemVfb3B0
aW9uLCAwKTsNCj4gIA0KPiAtCQkvKiB0cnkgZm9yIG1vcmUgZWZmaWMuIHdpbmRvdyBzaXplLg0K
PiAtCQkgKiBJbXBsZW1lbnRlZCBvbmx5IGZvciB0ZnRwIGdldC4NCj4gLQkJICogRG9uJ3QgYm90
aGVyIHNlbmRpbmcgaWYgaXQncyAxDQo+IC0JCSAqLw0KPiAtCQlpZiAodGZ0cF9zdGF0ZSA9PSBT
VEFURV9TRU5EX1JSUSAmJiB0ZnRwX3dpbmRvd19zaXplX29wdGlvbiA+IDEpDQo+IC0JCQlwa3Qg
Kz0gc3ByaW50ZigoY2hhciAqKXBrdCwgIndpbmRvd3NpemUlYyVkJWMiLA0KPiAtCQkJCQkwLCB0
ZnRwX3dpbmRvd19zaXplX29wdGlvbiwgMCk7DQo+ICsJCS8qIFdyaXRlICJibGtzaXplIiArIFww
ICovDQo+ICsJCXN0cmNweSgoY2hhciAqKXBrdCwgImJsa3NpemUiKTsNCj4gKwkJcGt0ICs9IDg7
IC8qIDcgY2hhcnMgKyAxIG51bGwgKi8NCj4gKw0KPiArCQkvKiBXcml0ZSB0aGUgdmFsdWUgKyBc
MCAqLw0KPiArCQlwa3QgKz0gc3ByaW50ZigoY2hhciAqKXBrdCwgIiVkIiwgdGZ0cF9ibG9ja19z
aXplX29wdGlvbikgKyAxOw0KPiArDQo+ICsJCWlmICh0ZnRwX3N0YXRlID09IFNUQVRFX1NFTkRf
UlJRICYmIHRmdHBfd2luZG93X3NpemVfb3B0aW9uID4gMSkgew0KPiArCQkJLyogV3JpdGUgIndp
bmRvd3NpemUiICsgXDAgKi8NCj4gKwkJCXN0cmNweSgoY2hhciAqKXBrdCwgIndpbmRvd3NpemUi
KTsNCj4gKwkJCXBrdCArPSAxMTsgLyogMTAgY2hhcnMgKyAxIG51bGwgKi8NCj4gKw0KPiArCQkJ
LyogV3JpdGUgdGhlIHZhbHVlICsgXDAgKi8NCj4gKwkJCXBrdCArPSBzcHJpbnRmKChjaGFyICop
cGt0LCAiJWQiLCB0ZnRwX3dpbmRvd19zaXplX29wdGlvbikgKyAxOw0KPiArCQl9DQo+ICAJCWxl
biA9IHBrdCAtIHhwOw0KPiAgCQlicmVhazsNCj4gIA0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxp
bg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=
