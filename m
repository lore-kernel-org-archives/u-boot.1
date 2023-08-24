Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69369C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 12:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B42898651B;
	Thu, 24 Aug 2023 14:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="iXPBMZja";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCEF786587; Thu, 24 Aug 2023 12:17:54 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A8218657A
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=roman.azarenko@iopsys.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYcV3wdxSltoUB/5fSbzNarBD3yrb/AkVvBonzW9OpNriM7Q2sm6L7iT7GkrlVFPfGo9Ah/xJ3OspZtOwAzFQ8o2y73eOM0HzC1hBvOcHkhR4OX9E0nXGzbLFFh9FgoXynGtAFpBX5rMOamRb2yfzNG7/LiUYxXVPadI2p7mj09IxrC2FFbFbfevoheUcZ2d47qjvRoZliPVEcv5QRRWVXXvZDSB0v2mj9bZ1/0Tb/Zo91sK85WCvhk3JtBi1u64QoNvnRSxBAXOcS2q/8OfryFErxWT9j3+V5smdRROOUvYf/tgoNAc09E+ewO7p/Wwsvg130sbmONXi8efDvFe8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0X1JRK2Iubw8Xei1eB1jcADU3RGerqXGnR2uzzHztgU=;
 b=oIE3FYHeva9sXI4GW/DVs20h9oxCtOwyHpWFhKNYwV9Av0ezNMIdeylpXs6QMoiKECTMw+V6Pwdm9eJinZ6t6Jpxtz9pNmnMooicOaSWii593dIA+eTIzwFuFGI0t1ju2kZgxaQdzTAgAZtsgpTpWN/WE/YPon+VSby2Hi113uBikpNVozdDHVRMWTw17P9sJi69sqe+OcidpScBs2Xkswk1LPurBCQrVQfqxvoR3zNS8B917VE0P0QB5vbIl+fVTo4G3MQrD+912yKJ6WBusiw2W2cwXItpTU6d/czdsGg5+PlvZmaQSPcX7qo8D8SaVWVI1N05koKat3zOvTfKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iopsys.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0X1JRK2Iubw8Xei1eB1jcADU3RGerqXGnR2uzzHztgU=;
 b=iXPBMZjakt3J/OaOW8lOrmdcz0Rlsr7vJNr598aXB601sMGyv+vB3snN0K8ZUpd92KZpcGZb8WGAT9BqzU+RyboXDQfG5huYJ7BjPj4ExZmKsrCpYcIGEiKQEqB8/n8UHsMZ1w50/58zUT/3RPxNcnxEfMZVMk1x3jl4lnf0fd0=
Received: from PAVPR08MB9819.eurprd08.prod.outlook.com (2603:10a6:102:31f::20)
 by PA4PR08MB6176.eurprd08.prod.outlook.com (2603:10a6:102:ea::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 10:17:50 +0000
Received: from PAVPR08MB9819.eurprd08.prod.outlook.com
 ([fe80::5586:29c1:1bd3:dadd]) by PAVPR08MB9819.eurprd08.prod.outlook.com
 ([fe80::5586:29c1:1bd3:dadd%7]) with mapi id 15.20.6699.026; Thu, 24 Aug 2023
 10:17:50 +0000
From: Roman Azarenko <roman.azarenko@iopsys.eu>
To: "marex@denx.de" <marex@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "sjg@chromium.org" <sjg@chromium.org>, "massimo.pegorer@vimar.com"
 <massimo.pegorer@vimar.com>, "trini@konsulko.com" <trini@konsulko.com>
Subject: Re: [PATCH] tools: ensure zeroed padding in external FIT images
Thread-Topic: [PATCH] tools: ensure zeroed padding in external FIT images
Thread-Index: AQHZ1btubtE4qXbfPkCaw0ot2FXY+q/4LbyAgAEPRIA=
Date: Thu, 24 Aug 2023 10:17:49 +0000
Message-ID: <603b051b057bb632fc9213cb0abc7d2887bf2b67.camel@iopsys.eu>
References: <20230823121417.270511-1-roman.azarenko@iopsys.eu>
 <40263db2-e42a-4997-ddcc-7a1ea7d44d31@denx.de>
In-Reply-To: <40263db2-e42a-4997-ddcc-7a1ea7d44d31@denx.de>
Accept-Language: en-SE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR08MB9819:EE_|PA4PR08MB6176:EE_
x-ms-office365-filtering-correlation-id: 84424205-c33e-4d80-1d4e-08dba48b5ec4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JfrxlhyPTaNRPYVZQ5QnYsrIpAnPuqeyZKJVP8CGPRJxENGjFU8NRwg+ce2YeBVYkfsqkeErolR0QpNGV2pH6Z9Goj617O9zIQxw24a6E1om2X7+nnXCUpyNvu/T/v5Vh+HDHjAwxb+yuN4+5P6Pku0DDlJypeRHaP5DU5Bk+jd6cVZSt13cvowtW9TNZ7dYqOyT1IqLNW5H1HKc/GiY7crycfQyY3PedfbmiE886SUcfyBt33OaYduDTU5BzVPGbr43ymV+NB9EeIQ8y1fOvdFjOxoy49yUYgmyv9GVKy5CjNglylH4QilsjlOuU46c3GglxtC7IatgmuUjxmdzeGhumecpCk54l/JsvVwGZzAWKYOsGRW0O3BTkrALCJN57bIHZAASaJLdgEfljV37VGLiGjSje0phQsALe4rzbxx4+OPJyaqSaY3UnDAtbHkXF0B0pKFxKONnFxiehzUlp9PZ6VvK5axSa/dBJ+YZJuJGtk8EQjQ2vVNAgNA/fcYms8kTy3zBFbWOHsyfiVhbEFP9I+EZLjo//VuPtpYXxpMr+RbBN4axWN80jnprATw1XCVL3FNQd5dHldgo2NIpZFNd9XjUtRcheaX5e/qK4ztUXXMnS3ERvR6pB78BxuRx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR08MB9819.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39850400004)(376002)(136003)(366004)(346002)(1800799009)(186009)(451199024)(2616005)(4326008)(8676002)(8936002)(5660300002)(4744005)(36756003)(44832011)(26005)(71200400001)(38070700005)(38100700002)(122000001)(66946007)(66556008)(76116006)(64756008)(66446008)(66476007)(54906003)(316002)(110136005)(91956017)(478600001)(41300700001)(6512007)(2906002)(6486002)(86362001)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGtEUzRoM2hxeFZiVnZHZ2g2bjFlNElqYTlUSi8wNGQ0aEg3UjIrbmgyVGVT?=
 =?utf-8?B?SmJOQURKaTJ4a2grZnZIN21VV3Qzd2diOFJIb0RsM0xrQU56NjhaaHo5ZTd1?=
 =?utf-8?B?aWlMWnJFZERvV2NWQmJXT1ordy82ZGlZdmJaTG1OZUlmZUZ1emZkMWJLSmdS?=
 =?utf-8?B?RkxkU0hwRnVGNUFhV2xqVDE5Z0ttd2RveEpOdmtmUjJYcWlPdlVub3A2T0ov?=
 =?utf-8?B?U0c2SnovM095cEwvNmxtdmZ0WHE5TWVtTXhqMzc5bExrbVlHbmFYU2pXNngr?=
 =?utf-8?B?Rnl0c0daLzAyZExtbWs3aGl6ZHYwYkVIelVXTkd0N3RueG9aUEpRRXc4UlM5?=
 =?utf-8?B?a3llbDVaVGFJQko3MmlrN1NWcFR2WU9KMlZJQnd0aDU3SHNOd0FoSmdBakt0?=
 =?utf-8?B?M3RVUmNWSzc2cGtOSkV1NFJoYzU1VnNaS1B3QVRSY1dLcWNzWElGMkgxaGlN?=
 =?utf-8?B?Mlphem5TSHh0TFI0bnRJQTJZUVlYbUtuVm12WC9HOVF5WFc5K1A5YU1XUUoy?=
 =?utf-8?B?UFJpWVpDcXRuaG9ScUlPdjJvdzFJb0Nlam02ODUrL21UbUVZTkcvVmRNRVF2?=
 =?utf-8?B?VnY4T0JtYjdPOVRVVHZlZDk1T0kyZWZYRkwxNnJ3bDVOWWdBTWNxdTViUWVV?=
 =?utf-8?B?ZjRUalpOMUZSWm9ZdlJDU0ZpZG93UUFnVGpZemxVK0JLWG50MkdGS1AxdTFB?=
 =?utf-8?B?RzlsVEZtbFI1UUZNUDRSVmpSVHF1eTJMcTdsZjI4ZTV1Z1lMSFdDdWRUUjY4?=
 =?utf-8?B?NTFrU1JpU3ExRUs2bGxsb1U4UitOMVY1WVZ1aWM4RlRtUWRHOWcxQ2ZLSU51?=
 =?utf-8?B?TlFUUUpMa1FydWNwejJxRE9BYzZaY0dGNHlJU1RFQ0NheWF0UDFZOE50ckxn?=
 =?utf-8?B?NEZkdGFDRGhzNHNqVE9DYk81a3IyN2VUMHE5NGR5V2pSYmkyWXc0dTJycm9o?=
 =?utf-8?B?TmlmYnFac1BPMC90YnRxT0dnL3BQZ2dma3hNLzV3RjVNd3F6WklxeUE5U1JL?=
 =?utf-8?B?aE1HVnN1WHl1L3lQYlhtNFZlYW8za0QvdWJDdXcveml4dGhBOGJrb0krM3da?=
 =?utf-8?B?Uis5NkZNKyt2WllWS1dlRTlRSDZDaktzVVFkaHJCbVd4VTIraEdOL3ExUnh5?=
 =?utf-8?B?T1Y1c3VZV2ZKZXpPdDlyTGpYNC9LZWJJVEMrOFRTWHF5dUxkc2FuaVRoNXFN?=
 =?utf-8?B?MmhtQlhrMmE0K2grKzBFMnJwTVJHSzNXdjd6REpJL2tSTUhyQ3JtN2pqWTd0?=
 =?utf-8?B?b0t1ZnJyM0ZLTElWSlRERzk2WUljTkprSWFjbWhYbVRESlJJVlNHU1ZOcTZC?=
 =?utf-8?B?ZUZDN3RuWnlCRTRhT0hXTTVpRzgreHZXRnAwVU1rY0Y4K0JBcDh1bWVtbnV4?=
 =?utf-8?B?ZEtKakFKZjY1dm82TGJvdXdLaHhhUFVyem5TWUdTTmVWRFNVanl6TUYxS2NC?=
 =?utf-8?B?Q0xOUVF3TGxVSThiWXYrcFhQb3NBTm9ZZCtJNGVoanNvdEROWnpyVk55eGVI?=
 =?utf-8?B?Qnh5eG41Nm5od29aekJGK1hNM0lwSmlDSWNHS0NPb3owcFVxUFhvM1JaMlZT?=
 =?utf-8?B?Mi8xU1RCWHFsanpYMEtiVXRocURYUVduMmZYbEhLVFRNcGRBcTM1VHZzdVZN?=
 =?utf-8?B?QkJ4RUdkc1JKcVlOZnFBV2N0bXNoSWFPQmc4cElRb0g2NWpCdWRsc1pFdm5n?=
 =?utf-8?B?bXl4MGpoTzYvSE51a1dFUVM3NjNHSDFNWW5tWFZHRFM5aTJjUzFEN0ZNdDJv?=
 =?utf-8?B?Y2pYNEdLQm5nOW41U0Y2RndGaWNmQUZPWUZLcHNVZ0VocXB0TGNuamp0L245?=
 =?utf-8?B?b1lmRjY0ZTdlN1AyWmtwbWVhMnE3K1oxa01oYS93UStVTDR0a0luNERZaE9x?=
 =?utf-8?B?ZDJUL3JvRkU5T3BkTUFRaHIrQlhoK3MzenhIajc5M21BQ3JtZlRyMTRlU0dh?=
 =?utf-8?B?R0ZVQmpnZnBja3Fmck5zQi9HSVhYUHpZOC9EMXFaajQvN3ptclNqQ2hhZ1Zu?=
 =?utf-8?B?ZGNhNEdiMXNEUzk4OW1wR3JabXI5MlNiVnVHZDJ4N0ZGbWFCWGx2ODkzZDBQ?=
 =?utf-8?B?aE9pTy9pTk4rSXdFQlpnWmVOYjMvOURSZGRnMFBoUTVKc0Z4bmQvQnQ1Z29u?=
 =?utf-8?B?MnZwZHRKNnZpcEVka3ZLb3EzQU80cWJCVU02cElNcmFudEluZXhFMGVOZVNP?=
 =?utf-8?B?SUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EA86BAD578DAA4C91762CCA0E669ECD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR08MB9819.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84424205-c33e-4d80-1d4e-08dba48b5ec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 10:17:49.9786 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ff78d65-2de4-40f5-8675-0569e5c7a65d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O8Elc7XBpOaPXT6lmhZAHOPLDmhZuh5Ii31q7hUDqhf57qmS8eZTSf2TPpk0D5R2a2dtkra1wq/nVtCEjScvSW6PWSPAK/VTYp4HTdABrjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6176
X-Mailman-Approved-At: Thu, 24 Aug 2023 14:51:11 +0200
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

SGVsbG8gTWFyZWssDQoNCk9uIFdlZCwgMjAyMy0wOC0yMyBhdCAyMDowNiArMDIwMCwgTWFyZWsg
VmFzdXQgd3JvdGU6DQo+IENhbiB3ZSB1c2UgbWVtc2V0IGFuZCB6ZXJvIG91dCB0aGUgdHJhaWxp
bmcgcGFydCBvZiB0aGUgYnVmZmVyIGluc3RlYWQNCj4gPw0KDQpUaGF0IGlzIHdoYXQgSSBzdGFy
dGVkIHdpdGgsIGJ1dCBhdCB0aGUgdGltZSB0aGUgZnRydW5jYXRlKCkgYXBwcm9hY2gNCnNlZW1l
ZCBzaW1wbGVyLg0KDQpOb3cgdGhhdCB5b3Ugc3VnZ2VzdGVkIG1lbXNldCB5b3Vyc2VsZiwgSSB0
b29rIGEgc3RhYiBhdCBpdCBhZ2Fpbi4gSQ0KdGhpbmsgSSBnb3QgdG8gdGhlIHBvaW50IHdoZXJl
IEknbSBoYXBweSB3aXRoIHRoZSBsb2dpYywgYW5kIHdpbGwgc3VibWl0DQp2MiB0b21vcnJvdyB0
byBnaXZlIHNvbWUgbW9yZSB0aW1lIGlmIGFueW9uZSBlbHNlIGhhcyBtb3JlIGNvbW1lbnRzIG9u
DQp2MS4NCg0KVGhhbmsgeW91IQ0K
