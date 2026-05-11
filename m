Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1658CD37B9
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 12:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 608EC80F0E;
	Mon, 11 May 2026 14:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="g+Um451E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 612B383BC8; Mon, 11 May 2026 14:23:09 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ED4D80398
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 14:23:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3stnfmVOvCc8a9tMTjRMnoEVuYziYSHtBQExUANIdXzIXSx1VRsO3Lktf25E//BeZGuGKc1KJ1WGHKcmR9Ll7wMB71Yog0gCCSqZXqZae6gcIgi20ixvClr09w5YgnHhYaIuRY8CXdcSaxRysEOcBmrBrHwxThfUN95dsJTxGujOudSu2dYkyWsk4BCrgFaTOCkSsE5uT6g+s1V4GJtOv5gEL+V+/TYUoUuOdnVr80L43RyPToKOrjDV0y9hm6FeBK/nzayy2ukwNveQNA3vlhE2kr4MFaxwZxArHgj/3TiM7Tt40mf7jA3B5hGGQ4/Uz6Hfl+/Al0mv5Kb+h34+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xRs3tC3STb2+6uBOnZlSq9RnOMHlwNlG7T9ckW7YCo=;
 b=CmH9kbKTQnZKZox9j5tzljBr2g/Ks2+wsWvV3vQuBmJFgI6BWDLLFYmgcZG/n4wELrtUsXMvMqCGWZuuK7QwoceOB/CDi1Coz1D0b/a/4n6t94t0daFz9Nz80uIQZ9TPrRSGOwOeEK4Z4BurdvG/vO7o9anuehqYJQ4kfAvVDoAl0tscHzCG+Krtpvnh2u+UURcl291wNQCLyVy4wq3B3ZTcvLWE+SU38qWeZQn2hjgGFcDwwlbDEmRcucU7Ph8hnNkFXnAlv4jBshr7/1PVz3cqabMw+k/BH5Tf0gnfH3jDB2CSv4/tcN29IoJs6sHqtbbOt/GQv1k3heIiHKhRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xRs3tC3STb2+6uBOnZlSq9RnOMHlwNlG7T9ckW7YCo=;
 b=g+Um451El4kZngzE2685dCs1x9fmwnMxJ249i/aLofIhSxhIxImmbuRlred/19A7zoxMt1ZnHxo3fhkrdYwKusVDbcx1CWIdLHgtvxiEyeQPXML8vreih25kdipyxXOMMaQ1zWcqW+iDA0YF+hB7TYA6iq47ub+BX9gKzcd7jNaH5v0AVdtv3Y/tw0pTSI/xM08kW8e1xTcSiqO2V9oZoo/oSak5t4nO3qauMUSP+6FO0pRAWOhXRYY2Dc1st4itcnBXvfKNU6Xe3oWVTHlzGvpyktPlrPerc2yKvcVcz/ycbakyuiyeoIaogyjxJvO1W4yNsZKKFRknRp0dQ5u6Ng==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VI1PR10MB7854.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 12:23:03 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 12:23:03 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "james.hilliard1@gmail.com"
 <james.hilliard1@gmail.com>
CC: "peng.fan@nxp.com" <peng.fan@nxp.com>, "mwalle@kernel.org"
 <mwalle@kernel.org>, "matthias.winker@de.bosch.com"
 <matthias.winker@de.bosch.com>, "pbrobinson@gmail.com"
 <pbrobinson@gmail.com>, "marek.vasut+renesas@mailbox.org"
 <marek.vasut+renesas@mailbox.org>, "trini@konsulko.com" <trini@konsulko.com>, 
 "Kiszka, Jan" <jan.kiszka@siemens.com>, "sumit.garg@kernel.org"
 <sumit.garg@kernel.org>, "quentin.schulz@cherry.de"
 <quentin.schulz@cherry.de>, "hs@nabladev.com" <hs@nabladev.com>,
 "dlechner@baylibre.com" <dlechner@baylibre.com>, "daniel@makrotopia.org"
 <daniel@makrotopia.org>, "quic_varada@quicinc.com" <quic_varada@quicinc.com>, 
 "Jin, Le" <le.jin@siemens.com>, "ilias.apalodimas@linaro.org"
 <ilias.apalodimas@linaro.org>, "Schweizer, Walter"
 <walter.schweizer@siemens.com>, "Freihofer, Adrian"
 <adrian.freihofer@siemens.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "dev@benjarobin.fr" <dev@benjarobin.fr>, "pro@denx.de" <pro@denx.de>,
 "philip.molloy@analog.com" <philip.molloy@analog.com>
Subject: Re: [PATCH] env: add Kconfig option for static flags list
Thread-Topic: [PATCH] env: add Kconfig option for static flags list
Thread-Index: AQHc4Afm0+GQBrndjk6vd1c5berlLrYIbgCAgABTwgA=
Date: Mon, 11 May 2026 12:23:03 +0000
Message-ID: <255ba9279f93326fa246d39971729cd957d4bbc5.camel@siemens.com>
References: <20260509230147.1308308-1-james.hilliard1@gmail.com>
 <e1e43a0034dff719e0df12437f8d018d5aed82ae.camel@siemens.com>
In-Reply-To: <e1e43a0034dff719e0df12437f8d018d5aed82ae.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VI1PR10MB7854:EE_
x-ms-office365-filtering-correlation-id: eb4c17d7-0b0d-4be2-6c72-08deaf580c96
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7416014|55112099003|38070700021|11063799003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: qeMSLFxh23/x8qcgCxnCzYWqpM9tcgnz//RE+c0rqsAa5GAHOdy2jP/4AiPKYBxpgSxUKsHP1YnfPi17M+c2cUGpNIdW8SQIV0jbokhdPK+7BiWGkMNklLCtwu7wg7QToIA8RlUseIBw5LfZAiftWwA4gih+PkOB/0ZXMb3BTkETFcOaaAmlmyou0cLgkM7eaXnexcztP0sz9VTxTnWwaQ4sNn1G6CZo/LEuryooeD7EpRn0OMC2R3cY4DVUJtkfble138+hXyGrfZL7eOQXgnvguqwzMvZF88y8Y/wIqwWI5K/609CycnwNFzMItqBzPxANtt2w3V15RutlJNsVHNP+DCtq6EnKClQg0LapYNzdVpL+VreiKX9SQ1gb7lOSEkvHKHa4gFKBWnIF9CZN/mF28Wa2kcCMeOwFIiP8ejWyfXKnvhIARw8xUJb+e5NWQLKiqSYz2EQ8B5rnAmTrDXpLamm1uJIVnPy489Ot2BYl5uzn5pqUb/7E3s3WavlF1mi1dApnFHvSBqypj7eXpP7d7/l5/Jjv2oNg4mU8h3PZ3wyZGglsqhTqgOPwXDU2kEyrX2sVLyhUjYfzJtm7rE4mX2bSPY5QlVhefwEbHq983GWc3b6RkXbXycUztPhGPdjccM4sQRa/w784VCPa1GnxO3tqZHYU0PIZH6BdM2d4/qYv+A2khyOaWA33v/h3cbiIn/bfTI+991aGDQYLHw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(55112099003)(38070700021)(11063799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWE5QUxDUUx4M1NYcmV5Yklja3hpaGROY3Jqc1BxZUVKY3MvMHNoRG5odHhC?=
 =?utf-8?B?UnVsY3BOTVRmaXZrQ1BhUS83RkhiMFBpbDhSMFZlL3U4NFlqWmowcHFyU1BH?=
 =?utf-8?B?L0lVZGV5cmFOaVlDc1AzQ2x4MEQ4cm5VaUR4dzZhTGhyK3hJY0FheVM1T3R4?=
 =?utf-8?B?am0zM2pZN3d6OUw4d3Q2eE5HTW80WFVPSGZDbWprMjdCVzZsbW1Wc1M2VFRq?=
 =?utf-8?B?ZmljaHAxN21QZENvK3ZWOWRlazRSaGhKSk9oRnk2Y3RrVG9xakIrWWYzNFVl?=
 =?utf-8?B?TUYrb28zcFRpcDFNMFBEMDNNRlNRR1MzMEg1eGVuem5XNXFic3FCVDR4UTVW?=
 =?utf-8?B?N3FiL2NJMVY2WS9DSFByZ24xMWNqVXBYU2VidFEyWmxPZ3RxZi8wUUwzU2I3?=
 =?utf-8?B?U2k5S0kvNmRGZ3lEMFo1RGQ5c1AzSEpJdUlRMi83NkNKeTI4UDNTc1pIWGl5?=
 =?utf-8?B?cGZCN2pBZSs2Tjk2bnBNbEZLdmRtNXNTcFJiUmtoZlhCS21DV3R4eWYzWXZU?=
 =?utf-8?B?bzRoejg5TkI2NnRrWXVYYXY1QnVWWXV5MlVtNnNaWnVRSytGY0JYOEhtUkNR?=
 =?utf-8?B?NStXQmZOVG5oVnlLTTZORDI2WlFDUW5NR0tMek5lMnNxZFFiOW1DQ1ZuUjR0?=
 =?utf-8?B?cGdyN0k5V0J3eEJ3MDdOMWxVSzJ2UStOWEVSekZmdlQzSlVVZEFMc2N5dmZv?=
 =?utf-8?B?dnZjTlVkUCt4T3FuQ3NPZ1lCQlZ5M2NjSVYyaFFSdUhRZ0FPVU9uREtxUDdz?=
 =?utf-8?B?aHJCalRCeFQrbWZIRGJoNzVtcjB4SVNwdjFsMERKbHBORVdyR2dXcFVUREtQ?=
 =?utf-8?B?TENaZVljRkFNL1E3UE1CRlZMM2NVYWg0emhDVWg5eEZhNC9WMGVOYUx2eFZ4?=
 =?utf-8?B?dnBsdHB3WWR5QzdWTEpEV3lVdzd0cTBacEwxNnRUM2ZUcWdEUkE2T3kwR1Bz?=
 =?utf-8?B?RVBTRFAyUVd6ZWJRVnJiMi9KYlJwMEN2RWw2dzREbTFreGg4eGVMUHV1MHZG?=
 =?utf-8?B?VFR2SzVtdG5KTlVEeFpRbjRQVEVYaFZrRFdGODJpVmMrRk5BZm5VcFJBR0Z6?=
 =?utf-8?B?bElsN0x1TFBmcXFJWjZQOUdZc2NveGtZWHhmWEFqdW1JbU4vc3ZxWmN1Ui9q?=
 =?utf-8?B?aFpBQ1dwQkJKVHBGamcrQTJ4c3JuNEFWMEJlWW5tekVXaFlrUmpRN0ZEcGl3?=
 =?utf-8?B?allXQVVYVW04bTJlM1Q3NHVoOGJna2w1VHdhRjFNZWNKdjd6N2lWeTN4SHhy?=
 =?utf-8?B?UUZUYzh4NVJ4UHpwUlF3a2p6eGZhUTFqbDZ3MFZZdll2Vis4cTZaVGdTYkIx?=
 =?utf-8?B?UHJJckIrK0VWRXN2bWI1YysvcURDa2FQY1FYNkFyNktueUx1akVrcFBubC83?=
 =?utf-8?B?UTdLcmhYbkdGdzhBK0VudnY4NFVRYlhnd1RjaFlMNnlDYW14ZTNVUFJWeWF6?=
 =?utf-8?B?RWFlTDVIenFCbFNOWnFQckZvaG11aWZnVHZFMVlWb1RUL1hhWFFacjNTZWx5?=
 =?utf-8?B?d2VFdldrdjZOeUJHNzZhQ2NCbDBGcE5GU0Q5QTJpODhSVS9DS1laT29VZk1R?=
 =?utf-8?B?M20yUGVFSWwzL05tUDdXOTNjTXBjSzZyQXJUSU5wa1VvYXhCZDgzQUR6czNa?=
 =?utf-8?B?RDBhTEQraUJrclNUK0dqS0NoUk9YbGFaTWRlZmN5TmtUY1Q2anRiUDBldXhD?=
 =?utf-8?B?d0NXOGs4YnBhSHllWFc4eGZ1czF0UGlrMmw3MVJjdU82b1cyRzhkTkM3MDJN?=
 =?utf-8?B?Uzh2alI2VHcvVXpxdHRqMjRHaVo2am12NFNrSGpWQ0RGSWg2ZHhJK3h3cFQ4?=
 =?utf-8?B?VGp2OEVFNUVjMkZHMEV6b0xvWlF6V3FMbGZNaE9vdEdndWFPa1BtU2s1OHM1?=
 =?utf-8?B?VGc0b0QvOUx3Unl4NlFmdFBXcmRyNHR2Nyt1alpOOEo5cmphcC9ZODBJVlQv?=
 =?utf-8?B?dCtRdGF4Ym9KejZwWTVHZWxsQ2poVks4Uy9wRGhETEQrUi9tOGpHNVBpa3Y1?=
 =?utf-8?B?SElPeEZJcFNqcm5iekVjd0pLazR2MmVCUlVILzRyZkJWU2JOMUJ3d3pZeG9Q?=
 =?utf-8?B?UmRuZkFZOEtrcGl3eHNvbWFDMGJoa2RGRXRLWDhVcHhuTHMzUDhqVWlydXZk?=
 =?utf-8?B?Q1BkU3dabDJqV0hsclc1VEFORXZwRE1iVEFTUXVCZFd6MmtLYlhUVUhtZnEv?=
 =?utf-8?B?LzhQdWdaQXpabWNuYm9hUHByMkpLYzNZS0N5Um42anVjSksvNnJvSHpmMHhw?=
 =?utf-8?B?a1JvREZyN0huQVFKSU1CNnBiY1BCVmlwWk14S3ZkUjVndTBSRzUyYUQvU2xr?=
 =?utf-8?B?bGhJV2VvL0kyT2dlTmZnbXZPNStnd1RBc08zQkJCZldKTDNwU2JpSGdXU1hn?=
 =?utf-8?Q?TszMP9EOxHiXHnKslLjsGIj5vSlTujossI9LUzdhmhQkS?=
x-ms-exchange-antispam-messagedata-1: iYsVXgsVjm6TdF8/kzyRy5/8qQz9m4bfZN7Ib2PcyQlFMD8t4SfasHwZ
Content-Type: text/plain; charset="utf-8"
Content-ID: <905FFCC152EAD24DBA5316ABF4FFADBD@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4c17d7-0b0d-4be2-6c72-08deaf580c96
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 12:23:03.6192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 23LVMp0DljXg77zibCOUcjwnei336Yh4eDRXOdUh4jD7WDQuDCWce/yisekFxDCRV2DyJSCGMFRvAkSBedd3vqhESf6bLXFCWmvcpJw2hqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7854
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

SGkgSmFtZXMsDQoNCk9uIE1vbiwgMjAyNi0wNS0xMSBhdCAwOToyMyArMDIwMCwgQWxleGFuZGVy
IFN2ZXJkbGluIHdyb3RlOg0KPiBPbiBTYXQsIDIwMjYtMDUtMDkgYXQgMTc6MDEgLTA2MDAsIEph
bWVzIEhpbGxpYXJkIHdyb3RlOg0KPiA+IEVudmlyb25tZW50IGNhbGxiYWNrcyBjYW4gYWxyZWFk
eSBiZSBjb25maWd1cmVkIGZyb20gS2NvbmZpZyB3aXRoDQo+ID4gQ09ORklHX0VOVl9DQUxMQkFD
S19MSVNUX1NUQVRJQywgYnV0IHN0YXRpYyBlbnZpcm9ubWVudCBmbGFncyBzdGlsbA0KPiA+IHJl
cXVpcmUgYm9hcmQgaGVhZGVycyB0byBkZWZpbmUgQ0ZHX0VOVl9GTEFHU19MSVNUX1NUQVRJQy4N
Cj4gPiANCj4gPiBBZGQgQ09ORklHX0VOVl9GTEFHU19MSVNUX1NUQVRJQyBhbmQgYXBwZW5kIGl0
IHRvIEVOVl9GTEFHU19MSVNUX1NUQVRJQw0KPiA+IGFmdGVyIHRoZSBsZWdhY3kgQ0ZHX0VOVl9G
TEFHU19MSVNUX1NUQVRJQyB2YWx1ZS4gTm9ybWFsaXplIGV4aXN0aW5nDQo+ID4gQ0ZHX0VOVl9G
TEFHU19MSVNUX1NUQVRJQyBkZWZpbml0aW9ucyB0byBlbmQgd2l0aCBhIGNvbW1hIHNvIHRoZSBL
Y29uZmlnDQo+ID4gbGlzdCBjYW4gYmUgY29uY2F0ZW5hdGVkIGRpcmVjdGx5Lg0KPiA+IA0KPiA+
IFRoaXMgbGV0cyBib2FyZHMgY29uZmlndXJlIHdyaXRlYWJsZS1saXN0IHBvbGljeSBhbmQgdHlw
ZSB2YWxpZGF0aW9uDQo+ID4gZnJvbSBkZWZjb25maWcgd2l0aG91dCBhZGRpbmcgYSBjb25maWcg
aGVhZGVyIHNvbGVseSBmb3IgZW52IGZsYWdzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEph
bWVzIEhpbGxpYXJkIDxqYW1lcy5oaWxsaWFyZDFAZ21haWwuY29tPg0KPiA+IC0tLQ0KPiA+IMKg
UkVBRE1FwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgIDYgKysrKysrDQo+ID4gwqBlbnYvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMyArKysrKysrKysrKysrDQo+ID4gwqBpbmNs
dWRlL2NvbmZpZ3MvY2Fwcmljb3JuLWNvbW1vbi5oIHzCoCAyICstDQo+ID4gwqBpbmNsdWRlL2Nv
bmZpZ3MvaG1pYnNjLmjCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArLQ0KPiA+IMKgaW5jbHVk
ZS9jb25maWdzL2lteDZxLWJvc2NoLWFjYy5owqAgfMKgIDIgKy0NCj4gPiDCoGluY2x1ZGUvY29u
Zmlncy9pb3QyMDUwLmjCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKy0NCj4gPiDCoGluY2x1ZGUv
Y29uZmlncy9zb2NyYXRlcy5owqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArLQ0KPiA+IMKgaW5jbHVk
ZS9lbnZfZmxhZ3MuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMyArKy0NCj4g
PiDCoDggZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvUkVBRE1FIGIvUkVBRE1FDQo+ID4gaW5kZXggNjgzNmE5MTdj
NzkuLmI5NjNjZTIzMDc4IDEwMDY0NA0KPiA+IC0tLSBhL1JFQURNRQ0KPiA+ICsrKyBiL1JFQURN
RQ0KPiA+IEBAIC0xMTA3LDYgKzExMDcsNyBAQCBDb25maWd1cmF0aW9uIFNldHRpbmdzOg0KPiA+
IMKgCQlVc2UgYnVmZmVyZWQgd3JpdGVzIHRvIGZsYXNoLg0KPiA+IMKgDQo+ID4gwqAtIENPTkZJ
R19FTlZfRkxBR1NfTElTVF9ERUZBVUxUDQo+ID4gKy0gQ09ORklHX0VOVl9GTEFHU19MSVNUX1NU
QVRJQw0KPiA+IMKgLSBDRkdfRU5WX0ZMQUdTX0xJU1RfU1RBVElDDQo+ID4gwqAJRW5hYmxlIHZh
bGlkYXRpb24gb2YgdGhlIHZhbHVlcyBnaXZlbiB0byBlbnZpcm9ubWVudCB2YXJpYWJsZXMgd2hl
bg0KPiA+IMKgCWNhbGxpbmcgZW52IHNldC7CoCBWYXJpYWJsZXMgY2FuIGJlIHJlc3RyaWN0ZWQg
dG8gb25seSBkZWNpbWFsLA0KPiA+IEBAIC0xMTMzLDExICsxMTM0LDE2IEBAIENvbmZpZ3VyYXRp
b24gU2V0dGluZ3M6DQo+ID4gwqAJCXIgLSBSZWFkLW9ubHkNCj4gPiDCoAkJbyAtIFdyaXRlLW9u
Y2UNCj4gPiDCoAkJYyAtIENoYW5nZS1kZWZhdWx0DQo+ID4gKwkJdyAtIFdyaXRlYWJsZSBpZiBD
T05GSUdfRU5WX1dSSVRFQUJMRV9MSVNUIGlzIGVuYWJsZWQNCj4gPiDCoA0KPiA+IMKgCS0gQ09O
RklHX0VOVl9GTEFHU19MSVNUX0RFRkFVTFQNCj4gPiDCoAkJRGVmaW5lIHRoaXMgdG8gYSBsaXN0
IChzdHJpbmcpIHRvIGRlZmluZSB0aGUgIi5mbGFncyINCj4gPiDCoAkJZW52aXJvbm1lbnQgdmFy
aWFibGUgaW4gdGhlIGRlZmF1bHQgb3IgZW1iZWRkZWQgZW52aXJvbm1lbnQuDQo+ID4gwqANCj4g
PiArCS0gQ09ORklHX0VOVl9GTEFHU19MSVNUX1NUQVRJQw0KPiA+ICsJCURlZmluZSB0aGlzIHRv
IGEgbGlzdCAoc3RyaW5nKSB0byBhZGQgdG8gdGhlIHN0YXRpYyBmbGFncw0KPiA+ICsJCWxpc3Qu
DQo+ID4gKw0KPiA+IMKgCS0gQ0ZHX0VOVl9GTEFHU19MSVNUX1NUQVRJQw0KPiA+IMKgCQlEZWZp
bmUgdGhpcyB0byBhIGxpc3QgKHN0cmluZykgdG8gZGVmaW5lIHZhbGlkYXRpb24gdGhhdA0KPiA+
IMKgCQlzaG91bGQgYmUgZG9uZSBpZiBhbiBlbnRyeSBpcyBub3QgZm91bmQgaW4gdGhlICIuZmxh
Z3MiDQo+ID4gZGlmZiAtLWdpdCBhL2Vudi9LY29uZmlnIGIvZW52L0tjb25maWcNCj4gPiBpbmRl
eCA3YWJkODJhYjZmMy4uY2E4ZjlhZmYxOWUgMTAwNjQ0DQo+ID4gLS0tIGEvZW52L0tjb25maWcN
Cj4gPiArKysgYi9lbnYvS2NvbmZpZw0KPiA+IEBAIC0zNCw2ICszNCwxOSBAQCBjb25maWcgRU5W
X0NBTExCQUNLX0xJU1RfU1RBVElDDQo+ID4gwqAJwqAgSWYgdGhlIGNhbGxiYWNrIG5hbWUgaXMg
bm90IHNwZWNpZmllZCwgdGhlbiB0aGUgY2FsbGJhY2sgaXMgZGVsZXRlZC4NCj4gPiDCoAnCoCBT
cGFjZXMgYXJlIGFsc28gYWxsb3dlZCBhbnl3aGVyZSBpbiB0aGUgbGlzdC4NCj4gPiDCoA0KPiA+
ICtjb25maWcgRU5WX0ZMQUdTX0xJU1RfU1RBVElDDQo+ID4gKwlzdHJpbmcgIlN0YXRpYyBmbGFn
cyBsaXN0Ig0KPiA+ICsJZGVmYXVsdCAiIg0KPiA+ICsJaGVscA0KPiA+ICsJwqAgVGhlIGVudmly
b25tZW50IGZsYWdzIGFyZSBhc3NvY2lhdGVkIHdpdGggdmFyaWFibGVzIGluIGEgc3RhdGljDQo+
ID4gKwnCoCBsaXN0LiBEZWZpbmUgdGhpcyBsaXN0IGluIHRoZSBzYW1lIGZvcm1hdCBhcw0KPiA+
ICsJwqAgQ0ZHX0VOVl9GTEFHU19MSVNUX1NUQVRJQy4NCj4gPiArDQo+ID4gKwnCoCBXaGVuIENP
TkZJR19FTlZfV1JJVEVBQkxFX0xJU1QgaXMgZW5hYmxlZCwgdGhlICd3JyBhY2Nlc3MgYXR0cmli
dXRlDQo+ID4gKwnCoCBjYW4gYmUgdXNlZCB0byBtYXJrIHZhcmlhYmxlcyBhcyB3cml0YWJsZS4N
Cj4gPiArDQo+ID4gKwnCoCBTcGFjZXMgYXJlIGFsc28gYWxsb3dlZCBhbnl3aGVyZSBpbiB0aGUg
bGlzdC4NCj4gPiArDQo+ID4gwqBjb25maWcgU0FWRUVOVg0KPiA+IMKgCWRlZl9ib29sIHkgaWYg
Q01EX1NBVkVFTlYNCj4gPiDCoA0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2NvbmZpZ3MvY2Fw
cmljb3JuLWNvbW1vbi5oIGIvaW5jbHVkZS9jb25maWdzL2NhcHJpY29ybi1jb21tb24uaA0KPiA+
IGluZGV4IGVlMTNkMmFiOTUwLi45NWEwNWQ2NGQ2OCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRl
L2NvbmZpZ3MvY2Fwcmljb3JuLWNvbW1vbi5oDQo+ID4gKysrIGIvaW5jbHVkZS9jb25maWdzL2Nh
cHJpY29ybi1jb21tb24uaA0KPiA+IEBAIC00OCw3ICs0OCw3IEBADQo+ID4gwqAJInNpZ19hOnN3
LHNpZ19iOnN3LCIgXA0KPiA+IMKgCSJ0YXJnZXRfZW52OnN3LCIgXA0KPiA+IMKgCSJ1cGdyYWRl
X2F2YWlsYWJsZTpkdywiIFwNCj4gPiAtCSJ1c3RhdGU6ZHciDQo+ID4gKwkidXN0YXRlOmR3LCIN
Cj4gDQo+IHRoZSBpbXBsaWNpdCByZXF1aXJlbWVudCB0byBoYXZlIGEgY29tYSBhdCB0aGUgZW5k
IGxvb2tzIGEgYml0IGZyYWdpbGUNCj4gb3IgZXJyb3ItcHJvbmUgdG8gbWUsIEknbSBub3Qgc3Vy
ZSBpZiB0aGVyZSBjb3VsZCBiZSBhIGJldHRlciBvcHRpb24uLi4NCj4gDQo+ID4gwqAjZW5kaWYN
Cj4gPiDCoA0KPiA+IMKgLyogRGVmYXVsdCBsb2NhdGlvbiBmb3IgdGZ0cCBhbmQgYm9vdG0gKi8N
Cj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9jb25maWdzL2htaWJzYy5oIGIvaW5jbHVkZS9jb25m
aWdzL2htaWJzYy5oDQo+ID4gaW5kZXggOTUwZWM4YjE5MGQuLmNjYTU2MmE2NmM5IDEwMDY0NA0K
PiA+IC0tLSBhL2luY2x1ZGUvY29uZmlncy9obWlic2MuaA0KPiA+ICsrKyBiL2luY2x1ZGUvY29u
Zmlncy9obWlic2MuaA0KPiA+IEBAIC0xMCw2ICsxMCw2IEBADQo+ID4gwqANCj4gPiDCoC8qIFBI
WSBuZWVkcyBhIGxvbmdlciBhbmVnIHRpbWUgKi8NCj4gPiDCoA0KPiA+IC0jZGVmaW5lIENGR19F
TlZfRkxBR1NfTElTVF9TVEFUSUMgIkJPT1RfQV9MRUZUOmR3LEJPT1RfQl9MRUZUOmR3LEJPT1Rf
T1JERVI6c3ciDQo+ID4gKyNkZWZpbmUgQ0ZHX0VOVl9GTEFHU19MSVNUX1NUQVRJQyAiQk9PVF9B
X0xFRlQ6ZHcsQk9PVF9CX0xFRlQ6ZHcsQk9PVF9PUkRFUjpzdywiDQo+ID4gwqANCj4gPiDCoCNl
bmRpZg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2NvbmZpZ3MvaW14NnEtYm9zY2gtYWNjLmgg
Yi9pbmNsdWRlL2NvbmZpZ3MvaW14NnEtYm9zY2gtYWNjLmgNCj4gPiBpbmRleCA4NGRhODI1MDY4
NC4uNTY2MmI1OTM0M2UgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9jb25maWdzL2lteDZxLWJv
c2NoLWFjYy5oDQo+ID4gKysrIGIvaW5jbHVkZS9jb25maWdzL2lteDZxLWJvc2NoLWFjYy5oDQo+
ID4gQEAgLTU0LDcgKzU0LDcgQEANCj4gPiDCoAkiZml0cGFydDpkdywiIFwNCj4gPiDCoAkibW1j
cGFydDpkdywiIFwNCj4gPiDCoAkicHJvZHVjdGlvbjpidywiIFwNCj4gPiAtCSJ1c3RhdGU6ZHci
DQo+ID4gKwkidXN0YXRlOmR3LCINCj4gPiDCoA0KPiA+IMKgI2Vsc2UNCj4gPiDCoC8qIFNEIENh
cmQgYm9vdCAqLw0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2NvbmZpZ3MvaW90MjA1MC5oIGIv
aW5jbHVkZS9jb25maWdzL2lvdDIwNTAuaA0KPiA+IGluZGV4IDVjNThjN2JiYWFiLi5mZTNmZDU0
MDVkNyAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2NvbmZpZ3MvaW90MjA1MC5oDQo+ID4gKysr
IGIvaW5jbHVkZS9jb25maWdzL2lvdDIwNTAuaA0KPiA+IEBAIC00Myw3ICs0Myw3IEBADQo+ID4g
wqAJImJvYXJkX3V1aWQ6c3csYm9hcmRfbmFtZTpzdyxib2FyZF9zZXJpYWw6c3csYm9hcmRfYTVl
OnN3LCIJXA0KPiA+IMKgCSJtbGZiOnN3LGZ3X3ZlcnNpb246c3csc2Vib290X3ZlcnNpb246c3cs
IgkJCVwNCj4gPiDCoAkibTJfbWFudWFsX2NvbmZpZzpzdywiCQkJCQkJXA0KPiA+IC0JImV0aDFh
ZGRyOm13LGV0aDJhZGRyOm13LHdhdGNoZG9nX3RpbWVvdXRfbXM6ZHcsYm9vdF90YXJnZXRzOnN3
Ig0KPiA+ICsJImV0aDFhZGRyOm13LGV0aDJhZGRyOm13LHdhdGNoZG9nX3RpbWVvdXRfbXM6ZHcs
Ym9vdF90YXJnZXRzOnN3LCINCj4gPiDCoCNlbmRpZg0KPiA+IMKgDQo+ID4gwqAjZW5kaWYgLyog
X19DT05GSUdfSU9UMjA1MF9IICovDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvY29uZmlncy9z
b2NyYXRlcy5oIGIvaW5jbHVkZS9jb25maWdzL3NvY3JhdGVzLmgNCj4gPiBpbmRleCAwMDZkNjQ5
ZjZlZC4uOWNkMGFiZDYwYWEgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9jb25maWdzL3NvY3Jh
dGVzLmgNCj4gPiArKysgYi9pbmNsdWRlL2NvbmZpZ3Mvc29jcmF0ZXMuaA0KPiA+IEBAIC0xMDgs
NyArMTA4LDcgQEANCj4gPiDCoCAqLw0KPiA+IMKgI2RlZmluZSBDRkdfU1lTX0JPT1RNQVBTWgko
OCA8PCAyMCkJLyogSW5pdGlhbCBNZW1vcnkgbWFwIGZvciBMaW51eAkqLw0KPiA+IMKgDQo+ID4g
LSNkZWZpbmUgQ0ZHX0VOVl9GTEFHU19MSVNUX1NUQVRJQyAiZXRoYWRkcjptdyxldGgxYWRkcjpt
dyxzeXN0ZW0xX2FkZHI6eHcsc2VyaWFsIzpzdyxldGhhY3Q6c3csZXRocHJpbWU6c3ciDQo+ID4g
KyNkZWZpbmUgQ0ZHX0VOVl9GTEFHU19MSVNUX1NUQVRJQyAiZXRoYWRkcjptdyxldGgxYWRkcjpt
dyxzeXN0ZW0xX2FkZHI6eHcsc2VyaWFsIzpzdyxldGhhY3Q6c3csZXRocHJpbWU6c3csIg0KPiA+
IMKgDQo+ID4gwqAvKiBwYXNzIG9wZW4gZmlybXdhcmUgZmxhdCB0cmVlICovDQo+ID4gwqANCj4g
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9lbnZfZmxhZ3MuaCBiL2luY2x1ZGUvZW52X2ZsYWdzLmgN
Cj4gPiBpbmRleCAxMjNmZGJjYjBiYS4uOThiNTBjNzIyMjcgMTAwNjQ0DQo+ID4gLS0tIGEvaW5j
bHVkZS9lbnZfZmxhZ3MuaA0KPiA+ICsrKyBiL2luY2x1ZGUvZW52X2ZsYWdzLmgNCj4gPiBAQCAt
ODksNyArODksOCBAQCBlbnVtIGVudl9mbGFnc192YXJhY2Nlc3Mgew0KPiA+IMKgCU5FVF9GTEFH
UyBcDQo+ID4gwqAJTkVUNl9GTEFHUyBcDQo+ID4gwqAJU0VSSUFMX0ZMQUdTIFwNCj4gPiAtCUNG
R19FTlZfRkxBR1NfTElTVF9TVEFUSUMNCj4gPiArCUNGR19FTlZfRkxBR1NfTElTVF9TVEFUSUMg
XA0KDQpXb3VsZG4ndCBpdCBiZSBhZHZhbnRhZ2VvdXMgdG8ganVzdCBhZGQgIiwiIGhlcmUgXl5e
Pw0KQm90aCBrZWVwaW5nIGJvYXJkIGNvbmZpZyBoZWFkZXJzIHVudG91Y2hlZCBhbmQgbm90IGlt
cG9zaW5nDQpjb21tYSByZXF1aXJlbWVudCBvbiB0aGVtPw0KDQo+IA0KPiBXaGlsZSBvdGhlciBt
YWNyb3MgYXJlIGxvY2FsIHRvIHRoaXMgaGVhZGVyLCBDRkdfRU5WX0ZMQUdTX0xJU1RfU1RBVElD
DQo+IGlzIGV4dGVybmFsIHRvIGl0IGFuZCB0aGUgcmVxdWlyZW1lbnQgdG8gaGF2ZSBhIHRyYWls
aW5nIGNvbWEgaXMgbm90DQo+IG9idmlvdXMuLi4gVGhlIHBhdGNoIGl0c2VsZiBsb29rcyBnb29k
IHRob3VnaCwgYnV0IG1heWJlIHRoZXJlIGlzIGEgd2F5DQo+IHRvIG1ha2UgdGhpcyBtb3JlIHJv
YnVzdC4NCj4gDQo+ID4gKwlDT05GSUdfRU5WX0ZMQUdTX0xJU1RfU1RBVElDDQo+ID4gwqANCj4g
PiDCoCNpZmRlZiBDT05GSUdfQ01EX0VOVl9GTEFHUw0KPiA+IMKgLyoNCg0KLS0gDQpBbGV4YW5k
ZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
