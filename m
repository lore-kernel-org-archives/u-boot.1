Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536F9CCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 14:16:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1365838CC;
	Fri, 31 Oct 2025 15:16:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="DOA82p6P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C7F4838EE; Fri, 31 Oct 2025 12:06:45 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA429836F0
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 12:06:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=hans.gfirtner@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wmsle7gPEg4tYVlnVRNcL8rAQPo8avqC5t+1z+CNdRSZHi5RdV08e8TbAuUd7KJj9kj5RpYJ+YQRXLADaFnDOybVV/NW0cMVmPMS3H2oMUYt0fWFeLgHOPTurh8VS6z2z8Yz/3Ad0S/Yt3Dif8j/09fb68kb8zDyKCt50cMqdStumjzvr9JJXQ2oDrVuGTMNdpnLeiNqcB33+9ybGdIjad5bapQCCOtALVWsct61X0i70m3UyaRG3THlxt/y/Xj7vfI453aQZhLS+5xaVBvp1hRvcSI1Cli41NgfWDN6Dylvobge2lLdOu0PtKnzJ8TMUWG4amBmbvy/5wJ4limHuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4usDl91v3uC8eHP3dvSOUe2NA10pq/dE0r1k4xJS5o=;
 b=XGphDhP23abonVPcP9sv3a4UQzLUjS/VuazazKNG3cqsypfIiEYTaT7aKBGdkNoytvuCsL6uuHP/Eka3YsLQaSdK7+Aee1AYF5xySNj3x8zl0BcUKaN6ZGDe4dvQdNu7CGaV37SupGV5u+KBo+yEdKeR9n5A1pSc1GB4vARu8wuy2y2O3gQvS2Z0TqLN6SfIL5tdiif2zbsqqQHDb3cFqxfVPUWg6ZIBVdWm31fGfEKw9FS8hZh2NMrAGQTIJPRHa+KX2Kidydu7bmqwG72MUVq1HXQKoY1qaOEUf/gxU59wdIK/eGPWDPDVfW15Yh6gYD6rIQ9fRqsm/qbgX90tKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4usDl91v3uC8eHP3dvSOUe2NA10pq/dE0r1k4xJS5o=;
 b=DOA82p6PuKAGApzxPQtmTYb0+4IErVxv32D9rGY9I81Zh9p47p8KxDQRCB6vSp0a88xXS84OXhB5mNh9TP3rsxI3Zh0W+SoG1lJ0ecPr4jmGxTn28AgVfP4zaP4CMTXI4DN3M+25excuY/qwx2H98vaXQRJLYh2r5cJc4njhhSs6eWnU19ynpEyesVGVGIKDEUZHqnzi+9maeOal1GI/VZjze2dXWeZQ83KYdRkyzoCdna8EAlB2lNTJSsvRnRxJMFsJgcVfmKbjNaXOP/jILYNBciNwt9EF4CmEtS4Uby8M74c2BKOZHSxy/3dbmHzWJdIfrpD8vu3FrWL0NdgdTQ==
Received: from AS5PR07MB9799.eurprd07.prod.outlook.com (2603:10a6:20b:651::16)
 by AM8PR07MB8139.eurprd07.prod.outlook.com (2603:10a6:20b:36e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 11:06:41 +0000
Received: from AS5PR07MB9799.eurprd07.prod.outlook.com
 ([fe80::7360:123a:2446:5a3b]) by AS5PR07MB9799.eurprd07.prod.outlook.com
 ([fe80::7360:123a:2446:5a3b%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 11:06:41 +0000
From: "Hans Gfirtner (Nokia)" <hans.gfirtner@nokia.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH] tools: key2dtsi: Write out modulus and r-squared with the
 correct length
Thread-Topic: [PATCH] tools: key2dtsi: Write out modulus and r-squared with
 the correct length
Thread-Index: AQHcSkmvLRQerG+QA0Sk5iquSp9k4bTcFsFQ
Date: Fri, 31 Oct 2025 11:06:41 +0000
Message-ID: <AS5PR07MB97993B2AA03A4CF25DC3C363FAF8A@AS5PR07MB9799.eurprd07.prod.outlook.com>
References: <f7068c43-db26-434a-b039-9a70e210e395@siemens.com>
In-Reply-To: <f7068c43-db26-434a-b039-9a70e210e395@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR07MB9799:EE_|AM8PR07MB8139:EE_
x-ms-office365-filtering-correlation-id: 9cd2a476-7505-48c2-a749-08de186d91e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZDE1WHVVTlB3VXVObm9yTVlPL2RnNmhhRmp5OXJMVFBxUGVRL25MT0JIQ2RH?=
 =?utf-8?B?M0ZSRk5ocFo1ZGJ3K0FLS0hPdEhkWWlNOFlFakNKem9EbE9HSkR3UlJXQmtI?=
 =?utf-8?B?WS91c1NXZjFVSzFkVTFtWUpQb2hDTzFvYVh6Y0YzM0g3dElTYmtTdVJzbnNr?=
 =?utf-8?B?R0lGWERkR0JKL01DSGRTTS82ditGR1IvMXNFMjZFcXU2WVNmRjhLWTBwY3Ba?=
 =?utf-8?B?dlV6RmsvdlNub0NRVlI1V213WmMvOGx4N0RHSGZPT3djaCtBeDdjcVAyRXpM?=
 =?utf-8?B?YzFMczJlMXVMVWk4K0JLakY3dUUyTng1NjVLOG1mZG5zcGdQWExXN2Z2Ymkv?=
 =?utf-8?B?UE1qdzcwM1Z0ZjRibjJNNG9zbXVnVkZObkZhcVNyWUp1eU9pclVobFlRem5E?=
 =?utf-8?B?SlVleTVJYmhybnV4OTNUa3M0TmhLRFpPUUwzUUJ5N3EwNWV5eUNNdzdpOUtz?=
 =?utf-8?B?dWV5U3ZZcGlheGpuWXV1bEhHTE8vYnBJbWY0amdOUTFjSU5uVDNTYVQybjU3?=
 =?utf-8?B?OUNZSGF1MG1oOXkvVnJSMnBXQnFJZlMzaDVaQjNDVXFoUDBDTko1RWxMT0Za?=
 =?utf-8?B?bXRCT2NMMjNPWWg5SWJEMkZIOFdINTFLVW5qMW96aDcrOE5GZTFxSkE1ZlVs?=
 =?utf-8?B?Zk5ob25CMEp4aUlJMVE0MDRIcFNuQjBmTmplWXlvbGlXT1V5K1R6eVA2Q0FJ?=
 =?utf-8?B?RWhWejVuUENxbXErVTdOVTRyUDVxZ3k4RzZxYXI0b2R6ckdIWDFKV3FSaits?=
 =?utf-8?B?RXhDTzhrWCtDUEQySGZTMDV2ZzJYTUNhTk5GNTk2bEJqemo1YnczZWIyMGpl?=
 =?utf-8?B?RStFUlBCdSsyR2tlTm5zQUhUYXN5cFpuU3pqenFzeTY0Z2MzaWp6blR6MFVz?=
 =?utf-8?B?WFFuVGkxeHpYMW82eTA0Z3RYN2hxRGpRUjBnWEdUckg2a3RnMTZRN2NidFN6?=
 =?utf-8?B?eit5MWdXYk93TjlNQllSTnJIYXdXM2RldURzZzRQOUR4UlBFWGRnU0lQenNQ?=
 =?utf-8?B?MXZFbUhUQXRkQVhud2ppRnJnT3VYOUtiVFM0ODlCeGdKaTZvQTNNcUxsRnRs?=
 =?utf-8?B?TnJrQ0hNWGIyb0Z2R3FOM2xNTjQrMG05Y3c3REE2UTJ0R00rOStqQm15QkV5?=
 =?utf-8?B?ZWxwRmp5NzZQdkptMGtjVndIN1g0cHhSZVYrRDVEaDhyN1FzQzVXSDFzd3hp?=
 =?utf-8?B?bWtSVFloM1E0aW5SeG9ISkltSCtFZjhadENKYzRGQUV1bjZSaU9OczZoUXo2?=
 =?utf-8?B?RWU5Q0VIV2hEa1NSUjJkVEkyMGtBa2hYc0FQMEpQc3lHWUpqWHJORThrRVdZ?=
 =?utf-8?B?bmlzQyt3bmhBeldVWWFCV3hxMmJ0alppMGZQNXFUYnpPSUdZZDF5MU9lWEtU?=
 =?utf-8?B?UktBWktlQmp0RlhLTEZ4VUQ3b3hrbERIaG9pVDR0ZjQwVjk0TGkrRW4zSGFO?=
 =?utf-8?B?NjlmNTlra0FkYXZTZm9NY3hPNkZnSzFvaVVRUWgxRS95SXc2eDlzd3U4blRF?=
 =?utf-8?B?d2wwK1NiTXlidTdZSFl3aHB0MEVmaUUyZEQ2WXBRcS9acmVBUW4zNXBHbDJN?=
 =?utf-8?B?a2xrZnNnOVIwdU5PMWVHeUNtZUNIeUhFcDJGYW1vS1VLYkQzT2FkcUhKWHNJ?=
 =?utf-8?B?UUk2UHp3M2E1eFB0dDMwek5rVzUxZkUxY0U2a0NzT0lhRVBCQ0lEU29rWmNy?=
 =?utf-8?B?YjQvK0RyNUpWVEJqOU9RYUdTNi94Tk9YaUhwUE9hK29xYlFmT3NiK0VTK21y?=
 =?utf-8?B?bXdiMzQ4TVYxUGErRnYxbU1QNXptQ043Y3pCYVU5ZWNlUDdhRXNuODNPMTh1?=
 =?utf-8?B?YTJyVGpUWHo0WkR1cHZWSVp0UU9saEtBMkZkT3UrYjN2KzdsUTZTdFpNNzVZ?=
 =?utf-8?B?TnRldzNIZldyWS9sOVFJVDI5K01wb0VXR2wvS29PVTlMWDVOclJXaE1JNWVJ?=
 =?utf-8?B?UnQ1ZWFwRUZMc1h0eWtXc1lzcWdCcUdoU1AxSG91QUk5OWg2QW9zc1owYUpm?=
 =?utf-8?B?NjFYZ0VicjNSMUVOcGh5eUxWUjN4QjZOTkgxeWl0MWExS0dMc1ZRaEtMU3Nr?=
 =?utf-8?Q?cCVYjM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR07MB9799.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWlNZzgzYzJRTFRRVTN3T0d2ZzBxZ0hwdHdxWkpDWHpyNkMwVXF1RnVPUW10?=
 =?utf-8?B?K210R3ZvZWYwbFJKbGVyRnlKUzY1L0hTeTVpUDR1NmFIUHBNYTJCNEp4UStG?=
 =?utf-8?B?eVc3UktrK0NTK3BsR3FuenZIYmx6UE9SS0kvVVRQRjB5YTZob2F3QWRubldY?=
 =?utf-8?B?eWE3eFU3dkd2WHZjRWt1VVpxbmxkTUIzdG1zMDIwdUVxYnRrN2VMR09jWUJ3?=
 =?utf-8?B?dnFLdjdCUkFqUFF1QUxHdWNyRDI1VmFIRGdFTlQwR1BSZHVtdTd5YTBTSTVq?=
 =?utf-8?B?cGtMemVHejUwcTVNS3BQemdNOWZrK1lFTzRTYXFXcEp3RHRlakhFcnl2ZGdy?=
 =?utf-8?B?MVIvaUd4bExkTFZacHFicUQwK2d6d3RIM3J5aXdyWjRNb1FDOFZaSmtYUU1v?=
 =?utf-8?B?cFJoc0tRaWl0QTlYVjRVaUViWHgrOGoxM3U1TUk1c3NBcVJPOTV0cDlnZHpP?=
 =?utf-8?B?OW55dmdZTVUwaW1LQVZxZEJnemxIMHprK0VORXk2Y3BMY2prZ2paKzVMRnpo?=
 =?utf-8?B?VjA1T25qUjluZDc4YS9iWkhRVll1YStTZEx1bWRSYk9pdkpUdjk3bXVOeElK?=
 =?utf-8?B?bXR6K2k5b251emNoaVR6cldoMURXTzg2SnlGM3kxWENGUFBta2NuYjFwUGww?=
 =?utf-8?B?azRXWjV3bnlrekJtK3d5aXJ3UVk5ZzZUZzcycVhyYmdMaVlKOTNYZENWT3A5?=
 =?utf-8?B?S0xTSHZndnZFTitXSUkva2N3b0VPODJZUk9aa0h4eWwwb1ZONzdycXMyQUgx?=
 =?utf-8?B?eTFreGNxZXIwWnF0V1Y4WktmNDRZVmxqWmNnVDkvTmVrQ1VGaHY5b0hzNlhP?=
 =?utf-8?B?YXBsT2NmZXZjY0toZXZncFlncTRwYzFZVHE5OGhsbm9hWnNiYnJ6T3FXcVV0?=
 =?utf-8?B?V0h0WHNnaWQ5ZlZ5RUpOV2ZPT2c0a3VrTFErcG82eUM2aFM4cUcwelZIS29z?=
 =?utf-8?B?aHh1MTQyQmI1UjkwUHQ2WWtTRDZsRVQwTDhpZmtrcHdKcDFiRXZNaFVjLzhO?=
 =?utf-8?B?TlhxSHZKU0xRWnEvRDdxU0FibFh0QmR0QkpJZkxDL1VYcnJBTkNjVndIZ1Nj?=
 =?utf-8?B?RzlnNzFicm9QVStYNlJKUkZKMmpVbkN3STFzZEJIR2hXbHIxWnQwblZST1FC?=
 =?utf-8?B?NDVMaWlhdzR1SXdSeU5xUHIxbk1PS1IvOEszUU1ZSGpqWEJWTHkxeXlEV3pP?=
 =?utf-8?B?b0F1T1ZVNXZ6LzFyS3pnZnliOVBWOFBxQ1Y2elhqWWt5V1NBVVpPclh0UFZD?=
 =?utf-8?B?MTlrRUdLZGpOQ2Q2VGhiWk9oZEFVNEx5Wk41VmFVUlRIbGZQNTV1STk4MlFx?=
 =?utf-8?B?cndCR1JsSXJyV2RDaVArL0VHdW94M3BTdHlNVzYwYysyNTNqdnpWaGpqbWZZ?=
 =?utf-8?B?S3FSK0dvemhMdFlnNkNsZURnM2FLQktZVDhwcHZSYnE1TUZDVmEzeXdGekpL?=
 =?utf-8?B?eld3M25qamk1SGZNa1VDM1NkRVdFTURDWlJqOTVVYTlSRGZuNFE2cmZtNEpW?=
 =?utf-8?B?anFPYVA0V3VVRzNINEwxc2FlNjFSQVk2TFhXbUI5dVBpWFkxbWxhcXBrMTd1?=
 =?utf-8?B?S2hiazBBQ1ExVTk3L0E4OGhjYkFSTW9lS0NkakV5cWc5dzhmSjZoN2txbkVO?=
 =?utf-8?B?cVdKcFFUV1lKOWlwREdzbFVMSlNLdkpOWGFTYzJDS2lieTNIRm1XdXMzckdD?=
 =?utf-8?B?MnhkNmt0Y2FhUjl3Z0ZaNENCRkQzall6UjFPK1VQajlpN1cvMG94dkFYbjZN?=
 =?utf-8?B?MjVBYndOT2ZFMWxjbnB1cS9pd2pwb1RNRm5rV1BVaHdFa3ZvR05UN2hvTmlI?=
 =?utf-8?B?anpJWGYzS0tsQWZMUXRRc1pyaENVRHZpSnQ3bVU1VEdHZ1diN2p3MjI3b01q?=
 =?utf-8?B?Z1Qvb2ZrN0FMWGxGeFFlVDlPQWFmd3MrSlZ6WjJnSVdhRU41U1pzNkJTdkEx?=
 =?utf-8?B?NU9KOGdGSkp6MDBaelM0YWlWalJ1WDVnM3RyMklGdzNJdUxhR3lHd1dWSG10?=
 =?utf-8?B?ZTljVytqb1hrM0VMdzIzTjVEeTFrRWtHS01WVElMUjRZUEcvejJuUHNWNFo5?=
 =?utf-8?B?SDkxSVRmaUV0SlhPSVZHb2tLVXUzYlpnUnQ0NUdIYWN4OXBZaXlHOGNiVWQ4?=
 =?utf-8?Q?rmqBfJhLre8KW3e3zrLKPqueJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR07MB9799.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd2a476-7505-48c2-a749-08de186d91e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 11:06:41.0777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zsjeK/Yd/v5l/o1689XWnXqxOGFQc0NLAW6khT0PrVNsORO/XR9bkqETpmLaKTAvadDW8QEffL0F4/N3G6kyew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8139
X-Mailman-Approved-At: Fri, 31 Oct 2025 15:16:06 +0100
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

SGkgSmFuLCBhbGwsDQoNCllvdXIgZml4IHNlZW1zIHRvIHdvcmsgZmluZSwgYnV0IEkgb25seSB0
ZXN0ZWQgd2l0aCBrZXlzIG9mIHNpemUgMjU2LA0KcGxlYXNlIHNlZSBteSAicnVkZSIgdGVzdCBz
Y3JpcHQgYXR0YWNoZWQ6DQojIS9iaW4vYmFzaA0KDQoNCmZvciBpIGluIHswLi4xMDAwfSBkbw0K
ew0KICAgICAgICBvcGVuc3NsIGdlbnBrZXkgLW91dCBwcml2YXRlS2V5XyRpLmtleSAtYWxnb3Jp
dGhtIFJTQSAtcGtleW9wdCByc2Ffa2V5Z2VuX2JpdHM6MjA0OA0KICAgICAgICBvcGVuc3NsIHJz
YSAtaW4gcHJpdmF0ZUtleV8kaS5rZXkgLXB1Ym91dCA+IHB1YmxpY0tleV8kaS5wdWINCiAgICAg
ICAga2V5MmR0c2kucHkgcHVibGljS2V5XyRpLnB1YiBrZXkyZHRzaV8kaS5kdHNpDQogICAgICAg
IHdjX2NtZD1gZ3JlcCByLXNxdWFyZWQga2V5MmR0c2lfJGkuZHRzaSB8c2VkIC1lICdzL1xzKnJz
YSxyXC1zcXVhcmVkID0gXFtcKC4qXClcXVw7L1wxLydgDQoNCiAgICAgICAgIyBzaXplIG9mIHIt
c3F1YXJlZCBpcyBleHBlY3RlZCB0byBiZSAyNTYsIEkgcHJpbnQgb25lIGFkZGl0aW9uYWwgcGFy
YW1ldGVyIC0+IDI1Nw0KICAgICAgICBlY2hvICIkd2NfY21kICRpIiB8IHdjIHwgYXdrIC1lICd7
aWYgKCQyICE9IDI1Nyl7IHByaW50ICJrZXkgIiwkNCwiOiBFcnJvciB2YWx1ZSAiLCQyO2V4aXQg
LTF9fScNCg0KfQ0KQlINCkhhbnMNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+IA0KU2VudDogRnJpZGF5LCBPY3Rv
YmVyIDMxLCAyMDI1IDEwOjM1IEFNDQpUbzogVS1Cb290IE1haWxpbmcgTGlzdCA8dS1ib290QGxp
c3RzLmRlbnguZGU+OyBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPjsgSGFucyBHZmlydG5l
ciAoTm9raWEpIDxoYW5zLmdmaXJ0bmVyQG5va2lhLmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gdG9v
bHM6IGtleTJkdHNpOiBXcml0ZSBvdXQgbW9kdWx1cyBhbmQgci1zcXVhcmVkIHdpdGggdGhlIGNv
cnJlY3QgbGVuZ3RoDQoNCg0KQ0FVVElPTjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxl
YXNlIGJlIHZlcnkgY2FyZWZ1bCB3aGVuIGNsaWNraW5nIGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNo
bWVudHMuIFNlZSB0aGUgVVJMIG5vay5pdC9leHQgZm9yIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24u
DQoNCg0KDQpGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KDQpBbGln
biB0aGUgaW1wbGVtZW50YXRpb24gdG8gcnNhX2FkZF92ZXJpZnlfZGF0YSgpIGJ5IHdyaXRpbmcg
dGhlIG1vZHVsdXMgYW5kIHItc3F1YXJlZCBwcm9wZXJ0aWVzIHdpdGggdGhlIHNhbWUgbGVuZ3Ro
IGFzIHRoZSBrZXkgaXRzZWxmLiBUaGlzIGZpeGVzIHNpZ25hdHVyZSB2ZXJpZmljYXRpb24gaXNz
dWVzIHdoZW4gb25lIG9mIHRoZSBwYXJhbWV0ZXJzIGhhcyBsZWFkaW5nIHplcm9zLg0KDQpSZXBv
cnRlZC1ieTogSGFucyBHZmlydG5lciAoTm9raWEpIDxoYW5zLmdmaXJ0bmVyQG5va2lhLmNvbT4N
ClNpZ25lZC1vZmYtYnk6IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQotLS0N
Cg0KSGFucywgcGxlYXNlIHZhbGlkYXRlLiBJIG9ubHkgaGFkIGEgZHJ5IHJ1biB3aXRoIHlvdXIg
dGVzdCBrZXkuDQoNCiB0b29scy9rZXkyZHRzaS5weSB8IDIxICsrKysrKysrKysrLS0tLS0tLS0t
LQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL3Rvb2xzL2tleTJkdHNpLnB5IGIvdG9vbHMva2V5MmR0c2kucHkgaW5kZXgg
MWRiYjJjYzk0YmYuLjMyMGVhOTMwYTk3IDEwMDc1NQ0KLS0tIGEvdG9vbHMva2V5MmR0c2kucHkN
CisrKyBiL3Rvb2xzL2tleTJkdHNpLnB5DQpAQCAtMTEsMTAgKzExLDggQEAgZnJvbSBvcy5wYXRo
IGltcG9ydCBiYXNlbmFtZSwgc3BsaXRleHQgIGZyb20gQ3J5cHRvZG9tZS5QdWJsaWNLZXkgaW1w
b3J0IFJTQSAgZnJvbSBDcnlwdG9kb21lLlV0aWwubnVtYmVyIGltcG9ydCBpbnZlcnNlDQoNCi1k
ZWYgaW50X3RvX2J5dGVzdHIobiwgbGVuZ3RoPU5vbmUpOg0KLSAgICBpZiBub3QgbGVuZ3RoOg0K
LSAgICAgICAgbGVuZ3RoID0gKG4uYml0X2xlbmd0aCgpICsgNykgLy8gOA0KLSAgICBieXRlX2Fy
cmF5ID0gbi50b19ieXRlcyhsZW5ndGgsICdiaWcnKQ0KK2RlZiBpbnRfdG9fYnl0ZXN0cihuLCBi
aXRzKToNCisgICAgYnl0ZV9hcnJheSA9IG4udG9fYnl0ZXMoYml0cyAvLyA4LCAnYmlnJykNCiAg
ICAgcmV0dXJuICcgJy5qb2luKFsnezowMnh9Jy5mb3JtYXQoYnl0ZSkgZm9yIGJ5dGUgaW4gYnl0
ZV9hcnJheV0pDQoNCiBhcCA9IEFyZ3VtZW50UGFyc2VyKGRlc2NyaXB0aW9uPSdQdWJsaWMga2V5
IHRvIGR0c2kgY29udmVydGVyJykgQEAgLTM5LDcgKzM3LDggQEAga2V5X25hbWUsIF8gPSBzcGxp
dGV4dChiYXNlbmFtZShhcmdzLmtleV9maWxlLm5hbWUpKQ0KIGtleV9kYXRhID0gYXJncy5rZXlf
ZmlsZS5yZWFkKCkNCiBrZXkgPSBSU0EuaW1wb3J0S2V5KGtleV9kYXRhKQ0KDQotcl9zcXVhcmVk
ID0gKDIqKmtleS5zaXplX2luX2JpdHMoKSkqKjIgJSBrZXkubg0KK2tleV9iaXRzID0ga2V5LnNp
emVfaW5fYml0cygpDQorcl9zcXVhcmVkID0gKDIqKmtleV9iaXRzKSoqMiAlIGtleS5uDQogbjBf
aW52ZXJzZSA9IDIqKjMyIC0gaW52ZXJzZShrZXkubiwgMioqMzIpDQoNCiBvdXQgPSBhcmdzLmR0
c2lfZmlsZQ0KQEAgLTQ3LDExICs0NiwxMyBAQCBvdXQud3JpdGUoJy8ge1xuJykNCiBvdXQud3Jp
dGUoJ1x0c2lnbmF0dXJlIHtcbicpDQogb3V0LndyaXRlKCdcdFx0a2V5LXt9IHt7XG4nLmZvcm1h
dChrZXlfbmFtZSkpICBvdXQud3JpdGUoJ1x0XHRcdGtleS1uYW1lLWhpbnQgPSAie30iO1xuJy5m
b3JtYXQoa2V5X25hbWUpKSAtb3V0LndyaXRlKCdcdFx0XHRhbGdvID0gInt9LHJzYXt9Ijtcbicu
Zm9ybWF0KGFyZ3MuaGFzaCwga2V5LnNpemVfaW5fYml0cygpKSkgLW91dC53cml0ZSgnXHRcdFx0
cnNhLG51bS1iaXRzID0gPHt9PjtcbicuZm9ybWF0KGtleS5zaXplX2luX2JpdHMoKSkpDQotb3V0
LndyaXRlKCdcdFx0XHRyc2EsbW9kdWx1cyA9IFt7fV07XG4nLmZvcm1hdChpbnRfdG9fYnl0ZXN0
cihrZXkubikpKQ0KLW91dC53cml0ZSgnXHRcdFx0cnNhLGV4cG9uZW50ID0gW3t9XTtcbicuZm9y
bWF0KGludF90b19ieXRlc3RyKGtleS5lLCA4KSkpIC1vdXQud3JpdGUoJ1x0XHRcdHJzYSxyLXNx
dWFyZWQgPSBbe31dO1xuJy5mb3JtYXQoaW50X3RvX2J5dGVzdHIocl9zcXVhcmVkKSkpDQorb3V0
LndyaXRlKCdcdFx0XHRhbGdvID0gInt9LHJzYXt9IjtcbicuZm9ybWF0KGFyZ3MuaGFzaCwga2V5
X2JpdHMpKSANCitvdXQud3JpdGUoJ1x0XHRcdHJzYSxudW0tYml0cyA9IDx7fT47XG4nLmZvcm1h
dChrZXlfYml0cykpIA0KK291dC53cml0ZSgnXHRcdFx0cnNhLG1vZHVsdXMgPSBbe31dO1xuJy5m
b3JtYXQoaW50X3RvX2J5dGVzdHIoa2V5Lm4sDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCitrZXlfYml0cykpKSBvdXQud3Jp
dGUoJ1x0XHRcdHJzYSxleHBvbmVudCA9IA0KK1t7fV07XG4nLmZvcm1hdChpbnRfdG9fYnl0ZXN0
cihrZXkuZSwgNjQpKSkgb3V0LndyaXRlKCdcdFx0XHRyc2Esci1zcXVhcmVkID0gW3t9XTtcbicu
Zm9ybWF0KGludF90b19ieXRlc3RyKHJfc3F1YXJlZCwNCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQora2V5X2JpdHMpKSkN
CiBvdXQud3JpdGUoJ1x0XHRcdHJzYSxuMC1pbnZlcnNlID0gPDB4ezp4fT47XG4nLmZvcm1hdChu
MF9pbnZlcnNlKSkgIGlmIGFyZ3MucmVxdWlyZWRfY29uZjoNCiAgICAgb3V0LndyaXRlKCdcdFx0
XHRyZXF1aXJlZCA9ICJjb25mIjtcbicpDQotLQ0KMi41MS4wDQo=
