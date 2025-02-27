Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA905C19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 03:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E56E805C3;
	Thu, 27 Feb 2025 04:11:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="SPUjvQaw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F422807EE; Thu, 27 Feb 2025 04:11:36 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 480FF8006D
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 04:11:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEQ2bBeNiIroP9Loegfi2XHQ6kMIZcLUugiERQGeRtsmi5iRyrqe1F8szCNAD75QsLBaLhycphqe10NKgYSgwoSO/7L1x5buY4+CIUBdM6cJNh7A6/d4IsgEkcF0YCl8es8WKYhDUM4A6jsnZMOlow/SdIPXaqe6OYjpb1AdYuSDtwAZY9wKDYytxkuPuqE118dhRfxzX7vBNfWPVcarh5tVq90cRzwJ5raORoaHCq05So4RxCJ0loS1cRs3hqljIKoach/UD1CV04+9U4mAnrF2bMn4W2TLBpB/r/NTWtq+R6ZbO4LiLbbs+bDTLj1SGq2C63H2fjPAJCPz6fA50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHlBXkrNQZU0APVUWsMERUigyrM+FrtLTjsB9gqpQZA=;
 b=IdTdU7SgRe0FfuJYE6mW0KsRpCW/q0AbrW0dU64EUF05f1GXmxtWqxAnwf6wjr+CF+jiIu8BNn0axNDzN2aAKQtZn5BmDW4HQ3h39/XOKfPRQ27UihiwJWxe2QL806klEVu4StSI71fy0HP67Z7EjPzPZds1g52tKJTnBoKncnfQ9cVGriLD7Uy7zHwVNGA8nKiIDv0sKgsE6X+6znR+eyA+SK6xxz2oXsLfmKY28kHpxT3O3iVNUlea90grQk7dOIQ4V11+uZwUb8RxXrnBjze5kxS00DB/3VLxV+avXhR82kbOepQ5oS2zThiCkNUK6WamNqpTQRBI9j8rtFDa1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHlBXkrNQZU0APVUWsMERUigyrM+FrtLTjsB9gqpQZA=;
 b=SPUjvQawLIGBHpQH0H9HDrwcKLfq8fV9dN4WzFpH7MOWsufqKeUl2Ysuk5KqVk1DezYLFMrGKq1V2BCsANrv4A0MJqlpJzAlgRn1P+Wx7WlGcqzUa/xnA9ydryfGkeSPY6rXA7mcIszrQGUTJWOLqGpoQVSjOWJt/2GoFEVFHKl6jSwyvm5BmBO4Wy0YTsudoIzAE/fzOEHjn2QhKLX78cOEDANb8Fh+1/XeyPEqABXDiQ+mkSAvk+F/ilCBd22S4I7JtYvGm2o3tSlYLtt8sPnRlJu6TtHiwGenCPSCCZSJfxC4zOMnczkeevIxTuWAJ0BE4Wyp0qqyscbaPLZGzQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB7196.eurprd04.prod.outlook.com (2603:10a6:10:123::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Thu, 27 Feb
 2025 03:11:32 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Thu, 27 Feb 2025
 03:11:32 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, dl-uboot-imx <uboot-imx@nxp.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ludwig Nussel
 <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>
Subject: RE: [PATCH 2/2] imx8mm: imx8mm_evk: fix BOOTSTD boot
Thread-Topic: [PATCH 2/2] imx8mm: imx8mm_evk: fix BOOTSTD boot
Thread-Index: AQHbhRpY04AkkA2i5k63U7t2wu8txrNaNoCAgAA9rQCAAAiQgIAAAKYg
Date: Thu, 27 Feb 2025 03:11:32 +0000
Message-ID: <PAXPR04MB84594EF4E0FFE527C9760D8588CD2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250222121711.6697-1-peng.fan@oss.nxp.com>
 <20250222121711.6697-2-peng.fan@oss.nxp.com>
 <CAOMZO5Drcqztvz1jE634sumDZk6Rmw5RJ1GzvvkU0mPJoDg1RQ@mail.gmail.com>
 <20250227022748.GS2640854@bill-the-cat>
 <CAOMZO5CeOjL0iNSQeC-S0u10vx-T-Kkj82-E9Aes5jKTB227tw@mail.gmail.com>
In-Reply-To: <CAOMZO5CeOjL0iNSQeC-S0u10vx-T-Kkj82-E9Aes5jKTB227tw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB8PR04MB7196:EE_
x-ms-office365-filtering-correlation-id: ecdf94cc-37dd-4f02-3f66-08dd56dc6ffe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VnpKMlZFeld6YzFhUWxtK2tSZC80V2FUckVXVjhTcjZuSUtFcytiQUFIbjZG?=
 =?utf-8?B?angyMlpVZEF1YzVHc2QvVTVGYndBVWhvK1A4c2hZY1JjYzBtMVcwQXM0aGlK?=
 =?utf-8?B?LzZWdWhHNENoQStkQnRWN0lyZWZwV3RSWUVHQmJJOGdaRGdoTDd5OFdKeUQ3?=
 =?utf-8?B?aGJFYUFIV2tmZ1NaZFdVSW92bDVHQ01COVNuR3BLN2JUdzN0WUhhZ09SbUsw?=
 =?utf-8?B?Q211Sis5amYvRkdUNmdPb1g5NzFzenRTbFVJcUlYQWF1VWNqb1ZkaEdHQ3o1?=
 =?utf-8?B?amlWaU9sa1hvczYrL3hoU2NwVDJlMzhrb1c1TGRBczZSWmZFRnRXeW5iZTFm?=
 =?utf-8?B?djJXL3VnNmZCbThtcVR6SS80Rkk1VEJ0aEpXRy9tRlFiTFJrNjRaSUtNSmVF?=
 =?utf-8?B?UjV2RTdSYUthWVJZVFg5NmZOZjBTVEpmUXJKNEFobEZjQ2NqUTREVWs5KzN5?=
 =?utf-8?B?bUZmbmNoUzVndlhJSlJGVzJUZ3o4Z0VPYWE2N1FkMldLLzc0SXJyWmxsZDdC?=
 =?utf-8?B?V281WFM0cE5COWVKWXYyVzZUZEJPeXNxNGZONjZCRC9IL292eTl6YUJWbnVH?=
 =?utf-8?B?S2JBVXd6KzluUUxjQ1BFRVc4eXdQWEVEQnlZby9GNHJKcWU0RFNKQ1pla09X?=
 =?utf-8?B?MzQrekxLU3Q2T2RvRTdwOGNyWlV0azVCQVJqaTRHOHJRbGpobGN3dWVseHBH?=
 =?utf-8?B?R0c1ditYdFdTdUxHbkhDSkV1aitTMmk3RllLSUtqc3ExS2xIRlNpbkhkc3BH?=
 =?utf-8?B?OUV0STlNSlMvVnJqUDJ1NEU0OFc3TUNGY2NacXJsdEkrRy9GM3hZLzFTd2s2?=
 =?utf-8?B?bGN2M0J6UFdSTExFQUM0WFJlK1AyZ1ZlNDBTQ1ZEeDFSZVlJdTdUbktmUHRp?=
 =?utf-8?B?bEtUb29MQzdXT1VzS1djUEdaNG5uN2NNNDNDRXBaS3hjU0d3c2hUNTVVenBE?=
 =?utf-8?B?RXRnNFZSL0RqNHYvZTBxTUVmaUdrT2oveHI5NWErYy9sVzVTVW5kUWw5OEJk?=
 =?utf-8?B?d0pyS3JHRzV2RGlZd05PNGRQV3psNzIvV0Zja3IzY0JkMFZUWG9ZTXgrV2hz?=
 =?utf-8?B?eTRBL3FPSVYxemI1Qkd6Qkhtd0tpbnJIdVdZaHU3MXphWDFRcU40R3ZQcWZV?=
 =?utf-8?B?Ykh2MlZTcit6V1JqWS9lRXFWT3E4TmlaaU5lU0J0dlN5dFJJdXdvUDJrcjVW?=
 =?utf-8?B?VkllaDZqRWg5dVkyK0JBZEVtZ1ZtNmkzdWNYcUhwOE1BditZb3QrQkJMV2lj?=
 =?utf-8?B?WEQzSUN1Y2UwNUkxN3dnOFhTcVdUSWh3YU9FQmRxK2c4ODh6Q2pxQUxQMG5r?=
 =?utf-8?B?SWl6eWp4RW1LZ3lSV2lPZnNjL1NNV3dWVkw1ZC95SWpUeVlHU2ExbUI0dmdI?=
 =?utf-8?B?cVVaaWVTanNqQ1d0TGNXcHdCWVlzbHNHZXA1dEJsaDhIcDJaSlJvUlBGMzlK?=
 =?utf-8?B?ZDZIUWUweHczWEwvQVFiem1YbHE5WlhpdDJVQWt3Zzhzb3pJc3V4MnBpZlFX?=
 =?utf-8?B?YnNpaisvMkhwWUoza3F0YzJEejlIdW1SL2ZyT2I2WmdHNC9Bd1REZWR2ZWo2?=
 =?utf-8?B?SWJuMk1kN3YvR05yakpIY0o1Mk5VcGFMbmxWRmpYYS9rNE5teHFxV05PWUxo?=
 =?utf-8?B?S1o1WEhRVWNVSEhOeVhNYmN3S0NXRCtEWEd5YmhRZW9Ua2tpLzJaSmI4ZjRQ?=
 =?utf-8?B?S2FjMGQzTGFGMVdJYzVvSVlZbnF0OHMrZlVJNHRSUHZaZ2o5aXBHZFFHL3Iv?=
 =?utf-8?B?ay9BcDJvcXlmVWdQTTFTaFdsd2hEbHJHSFVlQUZXOG9ob3ZNY0kycFlmdkZO?=
 =?utf-8?B?YXlFQlJtVXdoOWFUUFdlNS9IZ0lUUDJtVitwMDBpeS84Ulc5UEVNNSsyYisy?=
 =?utf-8?B?TUxEak01NTc2dEY0L3BsQVNWRFpja2hjdmQxVU5ESjhIcURVT0Nua29XOWtt?=
 =?utf-8?Q?8EoXV1Vf+WcjhwKJT+8UtSUMAoR78vjo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aE9EZExkNXVsd2J4Q3FoZW1LT00ycVFtU1hKY3lqbStRU08rclowYTVEMis3?=
 =?utf-8?B?VnJSNmdKaXQzblpaMUc1K3BlcUZWVFJLTFdtTlR2UlJ6Q0RES0xQQWZNTFNB?=
 =?utf-8?B?STdwdTV2dUdzNjlsOUJBUzF4akcwbjRxbVRmcTVwazR6WVhQamFOcGZOOWJI?=
 =?utf-8?B?eEFXNWx0emxjYUZEKzFlZWVlS3JMZFFPaUl3VTdmVDl0NTF0cFNWUE1TR084?=
 =?utf-8?B?SDlVSFRKT0hxdWlmb2Jyc3lPQ09kcmVBOXZjSitVTnA2ZTB1cUJpSDNxQXRD?=
 =?utf-8?B?RFlPaGVnZ0NQcE84Vkx6NXFBUkNTaDFmOWM3VThhOWFadFpqUmNJb0FIeVhB?=
 =?utf-8?B?eHVsNTVWdGhsLzRSVVNWZHpYdEdiL0V6cHZFbkJuRDROa2I1SUxMZE02Kytm?=
 =?utf-8?B?TWl0SGZiVTZQWW5JRjVpZ1N3amh5bDNtbzE3RzRRYzJWK25KS2hpMXV1V1NL?=
 =?utf-8?B?UTM2bThmZGlmaEVudXF3WlZqUFdibE43MEUvTkV3WUdlamNsbUludG5jY3Bm?=
 =?utf-8?B?RUJVL1pUclhrTGpkbkdlbFdEZTVTWEdUZTVxL2VQVEQ5ME9XYk1WYzgrTGVQ?=
 =?utf-8?B?Nllyc0lXSUgvcGRxd1lxQSs5N3lSUnoxNy9lOTZ3R2xFczV3My9pLzBXTDZT?=
 =?utf-8?B?T0M2cmovNmxWTkhhM2RoS1M4N3VBeGQxSUd2ZUc4azd3dHRoay8wRDBBTjBi?=
 =?utf-8?B?L0ZubXhVZDRtOWd6cXV3QWxwSGVQNDduZ0FxRjVOeEN4eHJqbDUweTdpUnU3?=
 =?utf-8?B?d1RvM1dtSzZzbEdvQWt2N3hjT21XbU9LdzQwOWxnWnJteEcxcW5JbndrV09I?=
 =?utf-8?B?NGREdW1yeCs4bnB5MHRHTWJzVmhkUWJ6OThETWJ6dngzSXBGWmlsNlhBK3o0?=
 =?utf-8?B?QzR2Z0RGVkJwN0NVTXpYVFhiSU91UzlGLzBtTlF5VUZwM0pVUyt1YzkrOEc3?=
 =?utf-8?B?UGhLVEkxdG9HUEYyWitkbUV0V3p1cktwOXpQZGRKbTRDckZmSXZ4NCt2cDRi?=
 =?utf-8?B?MzArWk9XT2FpWDdhZDhqckRWT2hHQzBPQkhnMmErc1Jza2p4ZzM2MlVqMlVu?=
 =?utf-8?B?WTBkM241dm5aWW1XVlJVQ2ZuUUZ0OGd1aGxqKzdpcjRwbitId2picWpuRG5j?=
 =?utf-8?B?ZmxiNm1LWUQyNlQrUzA4MTZKRzBwMWxWaERPOXVqUTZkZ0h2d0IxVU1XNThO?=
 =?utf-8?B?a3AxVXpZTGMxOExKMnhYTG5kT2JuQUt4L0VFWG03aURIakdCM3dIL0xsZmNl?=
 =?utf-8?B?WWF2Y2NWWUlKWWR6bWNzTytGQ3hoZGoxQWtsL0pRMmpsTE9yekllemtwd0Ro?=
 =?utf-8?B?SCt5SmYwTGVFQ1FmR3JUTVJVOVcwSXFUUmo2MUZqczB0TWZOTElZaktLdTgx?=
 =?utf-8?B?R29nSlg4elRySUM5NVI1TDhWdGNyTzF6OTlnbmlMSnROOG5OMExmVE9sUWZ6?=
 =?utf-8?B?R2I1M2ltMnZZdUtrSnNiMTV3aXZGbUIwK2dmODhteGVzUGNSWHptSUhkUWdM?=
 =?utf-8?B?Q2FpQ0dGc0x1Z2k5WUFQOXByYWZXd3BLTVJ3TXA0ZWxCQ1hMRXNrR0UwVDhY?=
 =?utf-8?B?bEdjWnVURzVmUVVYdHkrd2wzVS82UkJodWc1ekRXcVNYelIxaFgrOFgrUVli?=
 =?utf-8?B?STh1d3N1VHZIRGtpZndCMnIycnFiTWRnaE9aRlJZNXJRcFlDQmNSRHRvL29a?=
 =?utf-8?B?ekdIZVA1RWJVZmYzbHN1VXV5M3Vva3RGaUh2N0xIOEIvT05NeE03SW9uVkY0?=
 =?utf-8?B?S3dVc3ovWW41TUtmVm9mYWlBbFEwU1FwS1BSelA3bTE3RUVBQ3l5eDVheTRh?=
 =?utf-8?B?bndNV3Vnak5KRWh5UWhMVE9WazFPYytrTXlPQTh4dmZIdkg1Wjl1OGhCaTFC?=
 =?utf-8?B?RkUyZEh6MklTemltSVpiUGdScjNDVERXdi9XTlh3TUM5c1AzVk5xV1VleXlI?=
 =?utf-8?B?UnJIYjh1OWZ1dFFrK1piSUp0c3RsMGxuaU8xM1Z0Sjl2YUdQdWNpY0VQc3Y1?=
 =?utf-8?B?YnVZeWZRTWovUG1HOE9vdGJya0RpbHZBQVdvWU9kY2hLVDN6M0NkSGtUQW9t?=
 =?utf-8?B?UThSVGpISWpkT2ZFaXBRSGNKU2lnd2kwank2aGkxaU5xRGs4Z20rVStUYWVy?=
 =?utf-8?Q?nhP0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdf94cc-37dd-4f02-3f66-08dd56dc6ffe
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 03:11:32.7904 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ax92/+fphw9/ErLZEfcp0uDoGi0fCBSLus/buLmdjwp5s4yGykgkEYym2aBQruyBaPRz9dfYBr/g0+TollPukg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7196
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gaW14OG1tOiBpbXg4bW1fZXZrOiBmaXggQk9PVFNU
RCBib290DQo+IA0KPiBPbiBXZWQsIEZlYiAyNiwgMjAyNSBhdCAxMToyN+KAr1BNIFRvbSBSaW5p
IDx0cmluaUBrb25zdWxrby5jb20+DQo+IHdyb3RlOg0KPiANCj4gPiBEaWQgeW91IHJlc2V0IHRo
ZSBlbnZpcm9ubWVudCBhdCBzb21lIHBvaW50IHRvIGJlIHRoZSBuZXcgZGVmYXVsdD8NCj4gDQo+
IFllcywgdGhpcyB3YXMgdGhlIGlzc3VlLCB0aGFua3MuDQo+IA0KPiBCZXNpZGVzIHRoYXQsIEkg
YWxzbyBuZWVkIHRvIHNldCBrZXJuZWxfYWRkcl9yIGZvciB0aGUgYm9vdCB0byBzdWNjZWVkOg0K
PiANCj4gLS0tIGEvYm9hcmQvZnJlZXNjYWxlL2lteDkzX2V2ay9pbXg5M19ldmsuZW52DQo+ICsr
KyBiL2JvYXJkL2ZyZWVzY2FsZS9pbXg5M19ldmsvaW14OTNfZXZrLmVudg0KPiBAQCAtMTYsNiAr
MTYsNyBAQCBtbWNyb290PS9kZXYvbW1jYmxrMXAyIHJvb3R3YWl0IHJ3DQo+IG1tY2F1dG9kZXRl
Y3Q9eWVzICBtbWNhcmdzPXNldGVudiBib290YXJncyAke2poX2Nsa30gJHttY29yZV9jbGt9DQo+
IGNvbnNvbGU9JHtjb25zb2xlfSByb290PSR7bW1jcm9vdH0gIHByZXBhcmVfbWNvcmU9c2V0ZW52
DQo+IG1jb3JlX2NsayBjbGstaW14OTMubWNvcmVfYm9vdGVkDQo+ICtrZXJuZWxfYWRkcl9yPUNP
TkZJR19TWVNfTE9BRF9BRERSDQo+ICBsb2FkaW1hZ2U9ZmF0bG9hZCBtbWMgJHttbWNkZXZ9OiR7
bW1jcGFydH0gJHtsb2FkYWRkcn0gJHtpbWFnZX0NCj4gbG9hZGZkdD1mYXRsb2FkIG1tYyAke21t
Y2Rldn06JHttbWNwYXJ0fSAke2ZkdF9hZGRyX3J9ICR7ZmR0ZmlsZX0NCj4gbG9hZGNudHI9ZmF0
bG9hZCBtbWMgJHttbWNkZXZ9OiR7bW1jcGFydH0gJHtjbnRyX2FkZHJ9ICR7Y250cl9maWxlfQ0K
PiANCj4gVG9tb3Jyb3csIEkgd2lsbCBzZW5kIGEgZm9ybWFsIHBhdGNoIHRoYXQgc2V0cyBrZXJu
ZWxfYWRkcl9yIGZvciBhbGwgdGhlDQo+IGkuTVggRVZLIGJvYXJkcyB0aGF0IGhhdmUgYmVlbiBj
b252ZXJ0ZWQgdG8gYm9vdHN0ZC4NCg0KSSBhbSBqdXN0IHRyeWluZyB5b3VyIHNldHVwLiANCkFw
cHJlY2lhdGUgeW91ciBlZmZvcnQgb24gaGVscGluZyB0aGlzLg0KDQpUaGFua3MNClBlbmcNCg0K
PiANCj4gVGhhbmtzIGZvciB5b3VyIGhlbHANCg==
