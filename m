Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5F5C47DD9
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 01:46:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1B7788019;
	Thu, 28 Mar 2024 02:46:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="POLgVgPm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE72D8808D; Thu, 28 Mar 2024 02:46:33 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26E9C88019
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 02:46:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVdKAE3YyBuhOPr5VBUpWGjG2Nju8Dz1kWbJa/Zy2vCWBCO+x3qwQmHmnBDQk19iMkQGKJttxSxM6Jd8K6M8VSvCZH5rTaCfgU8P4+gNV8H0j/kIpGasT/KgMODfaW2Bo80Nhrb7e0klAL690SHQGUzHfuD0ZKYkGZhijGobIFTrsYfZVbnvi3Wmyd4oQXrEqxghD9q9sAVrkURI9S9IVGhOFkN5VQZvBVaK2DHOwR/FkKIgzrHVa88v5a28pkQwZWVEEjrm1V/cIrYVYHL9y/KbP9mnvFqbUJvS9YkneGw68W6J9BGnyr0YfJC5rjzzZYia+QmdqNnJW8Hxc5SPiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LD42xElRUiTuWdyEAigVDGZ4ZPlSNlCL+RJANGZ2yME=;
 b=V5OP5FOnZz5FGFbhrJirewOaH+zRnvnhLKlUWvSYzIjxB7QHMh3LkFmroXsp7ffNE+EhbV7hKFyPds8RIt/EIzAg6lvEVTv/x+JMVxqLuYmT7soPRnKco6Dvr9XrrJkJh9DRldr18thtRB5v4WlPV6jvU/Soilu+MFE7DEoYyn3mRdh9fPy6SKjgMMzVKSrhTS2ZbOiiNYN7R7vXSso71abbGBHzUvzINM9L15n627gSP2aPDUSqGU+0pdtIel64MPvA0MGPzwiMKL9zes7EUUVU10Kds3U8z7EDDTIYlWf8BgbVdNAigv4iD5RG61z8ZaV557DYNIpGDaLmGf8cYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LD42xElRUiTuWdyEAigVDGZ4ZPlSNlCL+RJANGZ2yME=;
 b=POLgVgPmicIPBblP26hSO17XIUv+JhIJym8zDBBfd8bpgmDk7T9OG5BgLeV0a8B65guiU3uLtQNJ5ARkveIDH2jfsOtJy59NK4XEAi9MCSEJeIgyTz8SVPaW3m3k28dr2HLP7xzKCXsEsogX65eYk/XTTs35cjrkGVx42CKouQw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8496.eurprd04.prod.outlook.com (2603:10a6:10:2c8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 01:46:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Thu, 28 Mar 2024
 01:46:30 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Stefano Babic <sbabic@denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>, Sumit Garg <sumit.garg@linaro.org>, Tom
 Rini <trini@konsulko.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v3 6/6] imx: imx93-11x11-evk: convert to OF_UPSTREAM
Thread-Topic: [PATCH v3 6/6] imx: imx93-11x11-evk: convert to OF_UPSTREAM
Thread-Index: AQHagKH8rJtU4c2iJkO96kz/KNcu/LFMSGMAgAAGgrCAAAIVAIAAEQ8w
Date: Thu, 28 Mar 2024 01:46:30 +0000
Message-ID: <DU0PR04MB9417207264F3F51BDD69EC66883B2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240328-imx93-of-v3-0-4e7f341ed7ea@nxp.com>
 <20240328-imx93-of-v3-6-4e7f341ed7ea@nxp.com>
 <CAOMZO5CXyBTm7JnfYB60hx3oipY76RSY0U-GPaoVJO=Agwr4Vw@mail.gmail.com>
 <DU0PR04MB94172BAF7D3AEB561F2E7842883B2@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAOMZO5B-M0KLVGfdGT9q2Tj_4uYn1bv8wXGickvzwzhAc0nLeg@mail.gmail.com>
In-Reply-To: <CAOMZO5B-M0KLVGfdGT9q2Tj_4uYn1bv8wXGickvzwzhAc0nLeg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB8496:EE_
x-ms-office365-filtering-correlation-id: 82fdcd2d-90bd-48d0-79f3-08dc4ec8e422
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zrxjc/ralE9hV+/wQUFRBnqt3Ou+AqLt5MuWmZ095Bw2pz6/dl1L+ueV9szdav9q6PPgKnHCyXKR4K90vF5oZ46Q3plHNwGWpDW1Xf0J8linxGGYroDMdc315AYFVYJTmB2rk9QJOMMHPOQ8aR+DygAqNwBmu/uLax49T3fopD154Zqr97Dyotd6Q8TrpAB7HJuw/6XGw0Xs1jOg3Z8yukmeJ4kGKiAXI7GBtE19n+6fMdE4UeNXSU+e+wkOK5sYC8NO3PcZlVGH5kh75/+mhZDoTlTYdQRAWLLGIqIUlCcqe73cgqe47UH0mvg6+wH+jOAmwJYcxQFhSseUOTAE/AePDD+ZRlNeYjCn+ZW4EYMAGqblEmLXRSvE5j0lkD1jeyQjKDWE3YTy4zJemSM28Uq8le3JvGWeSNVn8qU19F5MC0K2ilyWIImsW05V1rpCYZdcnrSN/1qfNWJWtZ27SLe6k+q5XAry7GMQvR5qSs4DFbDpH/Gydrz6p2/H66WGhbmPWm88o++CQ6SgnUSwEscl8Ka73HEeaFr/7W7cLI5A7/L1X8pRMVjkndGxuXFblU8LrbPPtnhtDeCDACk/E+YwDrKWnYNtLztMvkxmdpn+728fucjBz10rDAnr6cmuj5Nxm67fxKs4T3Gku8jiXjZ91PpZdwtDeuEdnM66JGgDewwAR7cxTdhtT2cw0o9BRJcGhz6iyCXEiwiw6/83RIhX7H2S3spiSHZ8oWguIx0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDJ5ZUlITlJ5ZEgzVlRoR3dvZU02eFFRTjRZRHJxR2NJdEFub1hKVCtBRDhR?=
 =?utf-8?B?NW1DYVRCY0k4NEFlZGxLV0RlaTJSSEVuQitveVNnd3pDcEc5TytGY25zck1S?=
 =?utf-8?B?THJFTGp4R3JEYmd2T01wUk83RlhnaGIvUnl4L21WZkVYdzJJVW9CTlpqWTVU?=
 =?utf-8?B?U3dXcW5CVTZhcHlEMWN0c3Znc2lzbFpzQjczQ0lseWJBbzk1YUorYmRnQzBa?=
 =?utf-8?B?cm5IaHlHMFJ5MGRndVd6SkI2UjlpV0FXY3hpdXlmTGkya2hQZy9JaElybUla?=
 =?utf-8?B?M2p4VmNiZE45N3ZmZjN4ekgzV1BBSll6QVUwOUtSOWs4QWpTSmhSNWVtVDEv?=
 =?utf-8?B?TFB4VStLZ1U1RWhRWVRBcWNkbERjK1BrVVh4aXo3bW9oSUZJWStCZUdiSkxy?=
 =?utf-8?B?c0hwcVdFL1YyY01jajc1bGVZR0pPdmIwWXAwaW5lVWRzMGZ1VElZWVdYQmhO?=
 =?utf-8?B?VElyRDY5MnpMakxvQWo1M3dxd2hta0xZa3c2bld5UHZxNjVGN0lscGFLMGYw?=
 =?utf-8?B?dVRPK0lDdHBoWTV1MlE5ajVmOW1CS2xPQmdWNnJzOU1VUEd5WU5tV0ErcHNK?=
 =?utf-8?B?UmtBWGwxWnIvU2xJdG1lSmMrOGtWbHJxbU1PMUh2RUNJWGpmcXNvN2pOYUhv?=
 =?utf-8?B?dXlDSGVFdTQ4T2tUT3RCOGVSWTliM2R4V1QxbEVnZ1hGWVgzdFVGRWFwQVpI?=
 =?utf-8?B?V2VGNHlvOEovTUQvWG1UZ3hRelFZSHR5UEVNQnBiYjhRTXpaWW5xa1dNK1Bn?=
 =?utf-8?B?OVhoT0FlS1FQQ3llbUM0RVd0S2dPeDdKVHRWQ0tqdGZUOTRvTVdMbm9NOFQ0?=
 =?utf-8?B?akt4MVRHRWxOcHVJdXRmWEljcVlseG9VcGZYMUwzSlZRRWhtaUxwdU0rUDUz?=
 =?utf-8?B?MSsvSld3clp6UkYwdHRFN0JKenozWHM3YWd4eHFXeWtYV2kxazYzMk54TFBO?=
 =?utf-8?B?d2pqejQreEc0S0xudy8zdzVSc2pIU3NaS1JFNWlWRENjREJkbnpyMHc4QmtN?=
 =?utf-8?B?N0NvWXUxeEdxYmcxUFZxTXU4YnZZTll4UmVQVG52S09kY0diWXZOR0ZlUTBs?=
 =?utf-8?B?L1JoWXVsdHM2OXo2aEVXbU5WMHFEcjRFZ1ZsTDluUlN0KzhiNnYzWEo1ZmJq?=
 =?utf-8?B?bGROSXdPUU1XQ090aVRYMDluUEhuSE5qTXpXRVg4QUVMSWhnZ0dEUkhKSHVH?=
 =?utf-8?B?OW5PZk5rZUYrOG91U0tvMjdIVVVLaTVQRERWWWxwa2ZHQkZkR2JETHBTVGo4?=
 =?utf-8?B?SXIzaXBqTWczZTllNXpibHp1YUh0K0dGVWkwTEppWGxnazBNR1hYa3hqWllW?=
 =?utf-8?B?cWkxY1BvSTQ0R2lkdHd3VmtZeXhiNDZFY0tlaWR3a2pSL1ltUDgvTmZkcW5Y?=
 =?utf-8?B?TTYrY2VPTUhRcVdCeTk2aHBJQk1XOURWNjRoWjFHcGEzRGhGc01FaVBtWUFR?=
 =?utf-8?B?YzlDOXlSRjhiRFFVdnFUMnZCRmNWbTdQa0ZrMHNSVnh2ZjFXRVFBZ2xhZ3hr?=
 =?utf-8?B?K1hJelkvMU44Q29kQmIwZ2dGTFpZOTZuU256dVI5M1hPdEpadVYvU2lldk5B?=
 =?utf-8?B?SEFEcVlIUlhFOGpiSFM1NHBYQ21FTitCSVlnclZNZHhjWElHSExURDREYVl1?=
 =?utf-8?B?WnYvV1RwT0duWCs1dUsyM1k1dGpLVyt5U0cyYTQ4eGJnZHkweC95N1JsWHZY?=
 =?utf-8?B?ejU5TWxxYThscGRUMXpXQXMwRDFKSUZFWS9xa1ZQaTdQZ2pXVTRZVWNhZDJN?=
 =?utf-8?B?a0xtV3JUc1BDc213ejRYbld0TVA0RmJmSS9ZbzBBdnVmbUFlZFlpUmdvZDBZ?=
 =?utf-8?B?U0VKVjQvbGJrUmI1NVNmNmNXekY0SFQzZnN0WGxPNDkyZlZqNTJmbTl2M2FV?=
 =?utf-8?B?clBrc0tZeUtyMUFCMm5NVUFGVktid1pOcDB5U0x4eFdmZTA1VTFTN28rOVRw?=
 =?utf-8?B?S2V4SUdSVU5ZenNsQ0FxMk9SWWtzdTU1Tms0aW5hcFlQYy9sNTBZSDZKYVVJ?=
 =?utf-8?B?aHl1MXJCR0huVTh2OHkrM1dJTVk1Z0gxQStZcWpSYlIrc2QvdjYyZTBacktP?=
 =?utf-8?B?dSt0UUhjby9OSE5KMnJVZUFMc0VkLzBXNFZmYzBOWTNYaVpTbUNBNmxIeEsx?=
 =?utf-8?Q?cgbY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fdcd2d-90bd-48d0-79f3-08dc4ec8e422
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 01:46:30.7526 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +5GYA1bIHU9meEGcL2Aag6Xg6JpBP54PPATWCjxw4C4eZGsblsCJu4x0jkFM1fWw/a6dfG6AAe0shjaVngpUKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8496
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDYvNl0gaW14OiBpbXg5My0xMXgxMS1ldms6IGNvbnZl
cnQgdG8NCj4gT0ZfVVBTVFJFQU0NCj4gDQo+IEhpIFBlbmcsDQo+IA0KPiBPbiBXZWQsIE1hciAy
NywgMjAyNCBhdCA5OjQw4oCvUE0gUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+IHdyb3RlOg0K
PiANCj4gPiBJIGNvdWxkIGhlbHAgY29udmVydCBhbGwgaW14OTMgYm9hcmRzLCBidXQgSSBjb3Vs
ZCBvbmx5IHRlc3QgbnhwDQo+ID4gaW14OTMgYm9hcmRzLCBub3QgYWJsZSB0byB0ZXN0IG90aGVy
cy4NCj4gDQo+IEp1c3QgY29weSB0aGUgYm9hcmQgbWFpbnRhaW5lcnMgaW4geW91ciBwYXRjaCBh
bmQgdGhleSBjb3VsZCBoZWxwIHRlc3QgdGhlDQo+IGNvbnZlcnNpb24gdG8gT0ZfVVBTVFJFQU0u
DQoNCm9rLCBJIG5lZWQgdXNlIHY2LjktcmMxLWR0cyBmb3IgdGhlIGR0cyB1cHN0cmVhbS4gU29t
ZSBkdHMgbm90IGluIHY2LjgtZHRzLg0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiBUaGFua3Mh
DQo=
