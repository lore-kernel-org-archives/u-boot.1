Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE67ECA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 05:53:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1F6583965;
	Tue,  2 Sep 2025 07:53:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="R0201fvY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF6F383A1A; Tue,  2 Sep 2025 07:53:36 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2071a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::71a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7D7F83443
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 07:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEEBLPQijTC5pjOjMYzAQ0cyHbP1XqH3qY2VuKPL4giFzJ4DK0rjRkTO0peIjBR+FctFzU6qFaml/6/2FsnluDrR8shHXxDU+HBHi+7DOTJmRRYuuD13n5/qDY53KQFY4lz/beu0ekGgHdOB5mKrty5JEn0Yj/oy5x+C0jT6TnkHQpURriq0wWnPwhQsHBaQ5VlmvJ4ZVpc05NI/tjHvrYI/TOqb4UtjwNEAc0f0EgJWDB9OUPANAs6BXz+HhcncU+0TPi95nPtHrdUuw+hgm1C2F6SH9n2/sEg5eep41mzjrf49FMsS0g2D3wCmttR6o1ZrHlSsDARPCIZZGbHDHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+xiKWIYcxYFOvInI4/eGacDjIcegg8LT3BgZ2E/dgU=;
 b=TwtqlhQONXLktkXGzCgQgOEfGMi0D59nchnPDhFOTpMXRt2cfK0o4GBFQSvc/6iv4KO+PQGywsyHT1t7fYOn6slUG512cYYcE3aI+1KCwqjo8sNLJ3BHteapM47w3WKrh70Kb9sh9mW3coCak3Se0VHohTypbzynofFiWfTkb+ROIr02PsLuciToogaGHFHUSqU5Wnqz6Y3ODVbKBu/RQYRMU8oYmJGgyRuJJySDIDEt5BP54Y3JHrAg7dc2FZ1CCKyuxrS/daLhIkPMHxtttAJ1wdRb6qz/wPoNauuhg5SWI1PJ8MK3fSU1Y+ZG4HT2gGtDQFvYlc9wv/eIUH3msQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+xiKWIYcxYFOvInI4/eGacDjIcegg8LT3BgZ2E/dgU=;
 b=R0201fvYAamRAfFcQS8yAGoyLrymYR6V62lOw6EJ3N9690pDV5tfHIXOpNPl48/DctVUmJtyRhs41YGUOd75nm7nnMymUM19EVz9gTV9D+V5GO6igHjkpfaePk7M5cs7+KRh/DgpgBK3mTMw1Qd54T1S1r5VOHmuIyztfmaZvLcF78jYsf2il6gTLgafqz547tYNvT+obxyCtJEqKpsdztLPqV96vFiQNlOLTV5CrdscOD63PVFZQ2RqpwtAzU5puIkMSbrtMJ5Lz0825lPdwaZq13ptKOFPk/7WYIMwIlMmK80dJvs4yylnydlbWGMoI8j4m1RlMdB3kUpCF7oo8Q==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by AM0P195MB0578.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:161::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Tue, 2 Sep
 2025 05:53:33 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%3]) with mapi id 15.20.9052.019; Tue, 2 Sep 2025
 05:53:32 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Fabio Estevam <festevam@gmail.com>, Teresa Remmet <T.Remmet@phytec.de>
CC: "sbabic@nabladev.com" <sbabic@nabladev.com>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>, Wadim Egorov
 <W.Egorov@phytec.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Benjamin
 Hahn <B.Hahn@phytec.de>
Subject: Re: [PATCH v3] Add imx8mp-libra-fpsc board
Thread-Topic: [PATCH v3] Add imx8mp-libra-fpsc board
Thread-Index: AQHcE19XdXRpD9qGKU6t6ZJmp2u1VLR04JcAgAMjkwCAB3DngA==
Date: Tue, 2 Sep 2025 05:53:32 +0000
Message-ID: <9af92c142f4cf88060de28691b9e9384eaad8aad.camel@phytec.de>
References: <20250822-imx8mp-libra-fpsc-v3-1-50ba9cd2d474@phytec.de>
 <2437d9efbf0121ef177f20b084ad19b54a0312f3.camel@phytec.de>
 <CAOMZO5Br+s7HA9e+AXY6qgEhn5RvDkDVEv5xgO4w=cgH+4gZ=A@mail.gmail.com>
In-Reply-To: <CAOMZO5Br+s7HA9e+AXY6qgEhn5RvDkDVEv5xgO4w=cgH+4gZ=A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|AM0P195MB0578:EE_
x-ms-office365-filtering-correlation-id: 26c9bf10-b3e0-4d2f-f5b9-08dde9e50cc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TWJFMjBFNVcySXdSVTRiaW44eWlXYjZMVWxtcStYMzBvNVl6RlUzNVBnN2tC?=
 =?utf-8?B?ak9uemJtV3VtTnNYRDNXU2FQd2Rma1A0OFVnT1lFaHdnanNSSzF4R0pRMUlH?=
 =?utf-8?B?UC9HSWxnRkdoL2VJUU9WSzVMZ2JnalN5dytuQnJuTUdISVdmQm1pU2N6Ykxr?=
 =?utf-8?B?ZU8vNUM2R0ZnNzY2RVhmQ2Z1cEQwZGZTN1JwejBSdEoxbXFsYlltL0hHUDRo?=
 =?utf-8?B?ZUVUUEhhTlZlVkFDUEFJS01CWW1Ja0RUWXlNSHRZdUVXcnZhaU94dURxYXE4?=
 =?utf-8?B?OWExS2Z5ZlFxK0FZSE0vYThkS1JVMExzb3YyVUtkT0R5cTJnd0pvLzVXbzR2?=
 =?utf-8?B?ck5TZExPd29qZEtkeTA4TURsN1lFbUc2aHdZb21mc1MvWktNMjd2TCswV1Br?=
 =?utf-8?B?VHVQZStCWmdJT2VaS2ZkU2tTcmJmbnNKMFRsUjJhb0FHOWdIckRhVDlSbUd1?=
 =?utf-8?B?R1lTdm05UnFCdFdEMzA0RVZGM2ZDMGhzWTNKZXpsZ1RFYzJFZ0hwWlo3QUxx?=
 =?utf-8?B?WlUyY1ZQRG91a0RQbnJEQ2RrMnNhU0N5Z1pWR3dLVnBVWlBaZHQ3dlZOeDUy?=
 =?utf-8?B?aEZ6WlErdTM1SDIwc20zdzVnaEhibUtjTnBEVXpIaDZMV0pHWExxUEQ0T1pT?=
 =?utf-8?B?ZElwYkJsdk5rVnZpUDV0QmFZSlliMnRxcUlndmZTaEIvVUNZY0ZoNXVXZ2xQ?=
 =?utf-8?B?VEVrRjFjRDlNVlRhTU94cmUyVlVwVUxLczcwOStjU3BEelZQdGNvZGF4c216?=
 =?utf-8?B?bTZYbWs5NmY3a0tKNXNvbERnZFdBL1Fjd2M0REpxYzl2NVErWVRlKzIzcllY?=
 =?utf-8?B?TjZFc1hsQllMKzhRYW5pNzI1UThWZDdMVGdGazd6cml1R1NEdmJiS0JGTEdo?=
 =?utf-8?B?T1pNUGllaVFXZTU1c3E1Vkw0QXpHSFBVY2xmbzZHZXlLVysyczROZzFFdmVo?=
 =?utf-8?B?RG5jQUhRZGVNL28yakZWcjRpSHFGL3pFbWVpT3VpTWhBVjF1THJTTU9yU3Nh?=
 =?utf-8?B?YnozZzNOWGtJR1NZMXNxN1hUQ1Y4ejIvc05mRlFHQzIzNklVd3Z2d3RRU0JW?=
 =?utf-8?B?UkRNaWhXaEdITnY0ZTlWeGtENzBVWDkwNXExV1FKL2VIN3JkQi96Z3ZRaE9w?=
 =?utf-8?B?S1kvUWNEcllPVzVhUHVIS0hGVUdqWGUxS0xRYW51Wk5JY3NxMndaeTM3eC9q?=
 =?utf-8?B?MXJXcmdDWDBtSitTQ1hkZ2FGOUVSUS90YlJud29qNFpyNXA3VDhOR1pqNW9W?=
 =?utf-8?B?QUdLZFQyODRZZW55Zm5IL0poeVU5dHFGNGNHaUxGaEcvaENBb0dNNUplSHNj?=
 =?utf-8?B?bDFDZEVmZk93UFM1RVpJbFE5Y1RKbDJhaVU4Mlg3dFByN0dRVjNIY2dXVzJk?=
 =?utf-8?B?MUZscWVxaUFxby82dkUyMDQvUGgvZXNDcGt2WHFJL3RkTkxoSk96N2hCUXlY?=
 =?utf-8?B?NEYyWkpWcTU5QkNVaXBoVlA2MVFIZmJKVXJwQTdGYTVnZzJrL2pCREY3R2R0?=
 =?utf-8?B?dkxYOGF5SlNKaVp4OTdGYm40OVpuYU9sWGxoVXZxTnVmQ0VFRFlnZFYvMXdv?=
 =?utf-8?B?ekpabzRTWExVTDNGYlZNV2FhVkJaS3JVaXFBamxFcnlGclFTSVlaclZNaHVO?=
 =?utf-8?B?ZUwzRGVIMHExQU5BUG5haC9XMUFPT0hsRW5SbG5WcWpYN3RsSlVLaUlYVk9X?=
 =?utf-8?B?Z05na0VIZzFJTlpwS2ZFVHBVbXd2QmdDYkd6eEFRTjk5TnkxeHhxV0JodWU2?=
 =?utf-8?B?eHQxdGg0RGNTUlZ4WWtHM3hVZW5vSys2WE5pbFc2bDgyZTBuM2JrbkdzSWg5?=
 =?utf-8?B?b2tmSnk5cUFZRnZQdVZ6TUxHbnROdzhOa3lxdEdDYlZtNHY2NHhlYS9wQ0M4?=
 =?utf-8?B?cHFvNFJBbk9yZjNFYnhSanZHdFhrekVORFpVd1gwOWZnZXppMjhwMVVLKzhk?=
 =?utf-8?B?clRZa2lVMXVRRHBhUmxaekxoWUlmMVVnN3A5Vm9zTFdMZjUrNjV1SkpjUnc5?=
 =?utf-8?B?SEYwOGlZanV3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2M0TU5heVRncnN0eGhyMHY1ckc4M1JXSXEvN3UrTncvNjJ1Sm0xcHFiWGNx?=
 =?utf-8?B?eEZRVlJIT1JNY01SRlJjSDJWeC9EbExhSVBISzNVWlR6QUlZVkRZUUgvelN4?=
 =?utf-8?B?ODJibGZRYnc2QTR1SWV3dFAzUzdOMW5KVzN0bTZBclJSb0xkRzJtRWx0MzJm?=
 =?utf-8?B?TmRLMlJ3MlVzOHNXVkZlMWZaTVF5T0tlVzZjbityTzRLVjkwTVJtUHFZUmNk?=
 =?utf-8?B?Y0N5NkRhRzdBVHJNNTMrdzJvcG1zTHZKMDV5SVUxbEZobHpTSnpqWVJIei8r?=
 =?utf-8?B?TkZKUVlkRm9JLzdCUHZ4cktOT3c5TVNsN1o5ZzdQaGRiQW1rZGNoR3lCZlM1?=
 =?utf-8?B?SzF3cFA0UTczRFZlL29WeG90d1k0K0lUbmVpRDM0WGpkN2IrMGd5Qk5uQ2sx?=
 =?utf-8?B?TVdRazRPUHo1VGEwUmMzd0dra3IyeGJCQlhrYmM1R3R6SUpqdXpCTTltYU50?=
 =?utf-8?B?K2p2WXlzTUJLV3pHTzdUQzNyZzNKUm9uQXdEZFFpUW0zRnFjY2RIL2l3NXZG?=
 =?utf-8?B?SVM1YWlka1FSMS84UnRNS3pOMnpVeVkwNkIzU3ZneURoYU4rbHg2TTg1N1k2?=
 =?utf-8?B?MkdLejRaMnVSbEpESWlYUFM0WEJ1K2xUYkpjaFhMZjByTXJ3NTFCSjRFZXRQ?=
 =?utf-8?B?bkdMQ2lqbDNuTmV2Q29xeFpyWFo5NlNGQ0tlTHFvRVNwaXhHckQ4VDlFWHZ6?=
 =?utf-8?B?NUVqbXZEL3J1bEMweEJKa1pCK1Y1bGllQ1N5YkpmcFpEd2dmWU1ZT2d1WnZG?=
 =?utf-8?B?Ly9wM01sbzYwRlJacUMydFViS2RzT095VkgxRDN2K1ZlTW5CR3NMUlR2OUJp?=
 =?utf-8?B?NUxwaExFSWgrQlZuQWlua05GTHpaUGRiTmNEVHRPSWVnZ3JTczFwazVldDYw?=
 =?utf-8?B?VC9TZ0tpV1RESERGM0xHaG1ubkJwMTBDTFJEY0x5N1Y3RUxsTzBQOHg5VHhO?=
 =?utf-8?B?dm5kNDRIUHRVN3NwVXpsbEVGVkpRR2pKWkRiVGhyVTZMem5JQUl2UytkV1VU?=
 =?utf-8?B?S2wrK25FeDd2TGdESy9qUU5oekR0OVRZQ2xCOGFjRUlPcEFrUUc1RndlQ0hD?=
 =?utf-8?B?QnhxOENtV0dJR2toZGlsQWlZTUVFcUtvd0U3bGxUcDFFUm9xS0JrYk40NzR3?=
 =?utf-8?B?OTFEUTNLazB0ZnNmMWVZZUE1OG5oNkpXN29UaHFZSEpOMGY2SkgzdFhLMklK?=
 =?utf-8?B?TDVYcGhCNlZqa09tdHJVdlNnRXNrSW5Mbm5nV3NkeFAyUGx0Tm5hQVNyb2Jw?=
 =?utf-8?B?OXZZNUpmU3dkMURlSExIZ2ZEZmUvYXlKeUdpZU81djRvS1IxazZIclo2V0Jq?=
 =?utf-8?B?TVkyUmJ2RnVmSE1nSU1tUDhKTlE5NDFVc3kvYWwvTzFBMjhYT3B6ZUxmeTZS?=
 =?utf-8?B?S0NDQVY4N3NtNGNTZlNVdkhpT1dXbzFSSEpMMDlWcE9PdkFoUHJqbVArTEp3?=
 =?utf-8?B?emNGdUhtbnRCcVhZTXY1aUVuZ2Z3QWlsNGVqalVyU096eDFtOTFqODQ3MzBT?=
 =?utf-8?B?ellrMWJ5dTlNNWRhN0l4eENwSE5oR2FMVzVDdUFvMk1KR2Jna1YraXl1QlMz?=
 =?utf-8?B?eUVmeDQ2VFVqVms4QkxlUk8rS1VWR09OKzFFdTl5WS93ekVGOUJ0K1hqak41?=
 =?utf-8?B?WTVyWGhYR28xYlNleEFleWU3QWNZalAvSE15Z0E4SVo3K1oyZnNrOWM5VjVW?=
 =?utf-8?B?K25aRUFPcXNWOHFOdWRUS0xMQ2ljTlVRcG5iaVFFSWZJUm5tczFWMmllSVVl?=
 =?utf-8?B?N2hKMVFPU3Z6ZGkrUWVmaHRPL0NmUmJwZTNLZlBEZ1VQdEwyTlpMMU5QbXlv?=
 =?utf-8?B?SDJtOFhiZmlRWmlhdlJISG1zdUpSOSt2S1ozTHBnckZQS0sxVHdmZ21lRkh2?=
 =?utf-8?B?aDR1UTI2TmZwU1NlRUNVenNPR0wyQTRxU3hVMFI0S0VheENxaVE4b01ER1lD?=
 =?utf-8?B?S0FYZE96SWUxYytDRTE4TEwxajdjd0xCOThQZEV5R3ZLbHNkWHgwa1JFQ09U?=
 =?utf-8?B?NmJRbisxd1hHN2lOaVJjcnlsWXovME84YUJHVWxjUDI4QlB2cUxyUWw3WEo2?=
 =?utf-8?B?Ujh4Qy9qcGtUK2tpTFB3aExZNTd3SndPTTdUVHBqZTR2YUUvYnpBeXovUzV2?=
 =?utf-8?Q?0KfA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3889A5A7B154A943B52B8AAF73A2D1BD@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c9bf10-b3e0-4d2f-f5b9-08dde9e50cc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 05:53:32.7239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lwcSKijXJ0bR/CnbkWbb3Q35gU0UEjjgcV9oOtxUye0+YhczaacBvjZqq31Utq7QQrx8q7algWI7tqsyGPi3DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P195MB0578
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

SGkgVGVyZXNhLCBGYWJpbywKCkFtIERvbm5lcnN0YWcsIGRlbSAyOC4wOC4yMDI1IHVtIDA5OjE1
IC0wMzAwIHNjaHJpZWIgRmFiaW8gRXN0ZXZhbToKPiBIaSBUZXJlc2EsCj4gCj4gT24gVHVlLCBB
dWcgMjYsIDIwMjUgYXQgOToxOeKAr0FNIFRlcmVzYSBSZW1tZXQgPHQucmVtbWV0QHBoeXRlYy5k
ZT4gd3JvdGU6Cj4gCj4gPiA+ICsKPiA+ID4gKy8qIGRkciB0aW1pbmcgY29uZmlnIHBhcmFtcyAq
Lwo+ID4gPiArc3RydWN0IGRyYW1fdGltaW5nX2luZm8gZHJhbV90aW1pbmcgPSB7Cj4gPiA+ICvC
oMKgwqDCoMKgwqAgLmRkcmNfY2ZnID0gZGRyX2RkcmNfY2ZnLAo+ID4gPiArwqDCoMKgwqDCoMKg
IC5kZHJjX2NmZ19udW0gPSBBUlJBWV9TSVpFKGRkcl9kZHJjX2NmZyksCj4gPiA+ICvCoMKgwqDC
oMKgwqAgLmRkcnBoeV9jZmcgPSBkZHJfZGRycGh5X2NmZywKPiA+ID4gK8KgwqDCoMKgwqDCoCAu
ZGRycGh5X2NmZ19udW0gPSBBUlJBWV9TSVpFKGRkcl9kZHJwaHlfY2ZnKSwKPiA+ID4gK8KgwqDC
oMKgwqDCoCAuZnNwX21zZyA9IGRkcl9kcmFtX2ZzcF9tc2csCj4gPiA+ICvCoMKgwqDCoMKgwqAg
LmZzcF9tc2dfbnVtID0gQVJSQVlfU0laRShkZHJfZHJhbV9mc3BfbXNnKSwKPiA+ID4gK8KgwqDC
oMKgwqDCoCAuZGRycGh5X3RyYWluZWRfY3NyID0gZGRyX2RkcnBoeV90cmFpbmVkX2NzciwKPiA+
ID4gK8KgwqDCoMKgwqDCoCAuZGRycGh5X3RyYWluZWRfY3NyX251bSA9IEFSUkFZX1NJWkUoZGRy
X2RkcnBoeV90cmFpbmVkX2NzciksCj4gPiA+ICvCoMKgwqDCoMKgwqAgLmRkcnBoeV9waWUgPSBk
ZHJfcGh5X3BpZSwKPiA+ID4gK8KgwqDCoMKgwqDCoCAuZGRycGh5X3BpZV9udW0gPSBBUlJBWV9T
SVpFKGRkcl9waHlfcGllKSwKPiA+ID4gK8KgwqDCoMKgwqDCoCAuZnNwX3RhYmxlID0geyA0MDAw
LCB9LAo+ID4gPiArfTsKPiA+ID4gKwo+ID4gCj4gPiBwbGVhc2UgcmVtb3ZlIHRoZSBlbXB0eSBs
aW5lIGF0IEVPRi4KPiAKPiBZZXMsIHRoaXMgY2F1c2VzIGEgd2FybmluZyB3aGlsZSBhcHBseWlu
ZyB0aGlzIHBhdGNoLgo+IAo+ID4gPiArQnVpbGQgVS1Cb290Cj4gPiA+ICteXl5eXl5eXl5eXl4K
PiA+ID4gKwo+ID4gPiArLi4gY29kZS1ibG9jazo6IGJhc2gKPiA+ID4gKwo+ID4gPiArwqDCoCAk
IG1ha2UgZmxhc2guYmluCj4gPiAKPiA+IGxvb2tzIGxpa2UgdGhpcyBzaG91bGQgYmUgcmVtb3Zl
ZC4KPiAKPiBDb3JyZWN0Lgo+IAo+ID4gVGVyZXNhCj4gPiAKPiA+IAo+ID4gPiArwqDCoCAkIG1h
a2UgLWogJChucHJvYykgXAo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgIENST1NTX0NPTVBJTEU9
YWFyY2g2NC1saW51eC1nbnUtIFwKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoCBpbXg4bXAtbGli
cmEtZnBzY19kZWZjb25maWcgXAo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgIGZsYXNoLmJpbgo+
IAo+IFRoZXJlIGlzIG5vIG5lZWQgdG8gcGFzcyAiZmxhc2guYmluIgo+IAo+IEFmdGVyIHJ1bm5p
bmc6Cj4gCj4gbWFrZcKgIGlteDhtcC1saWJyYS1mcHNjX2RlZmNvbmZpZwo+IG1ha2UKPiAKPiBU
aGUgZmxhc2guYmluIHdpbGwgYmUgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkuCgpUaGFua3MgZm9y
IHRoZSBmZWVkYmFjaywgd2lsbCBhZGRyZXNzIGluIHY0LgoKWWFubmljCgo+IAo+IEknbGwgd2Fp
dCBmb3IgdjQuIFRoYW5rcwo=
