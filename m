Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F156EC83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 11:20:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57D2D8304F;
	Tue, 29 Jul 2025 13:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Whpty2UT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF0A383145; Tue, 29 Jul 2025 13:20:09 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE6108304F
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 13:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqcHC7IEfGEm0K9oSbR/20mgOXHY+tCa7i6YUKZTBWJ7zKiF+F1lKVHZwF1/5gtwL3edKKMR2x07oyKjg2/f+1pzYE6k9X+iUJ/ZWMr3vinIDR5Tc/5NBM/4O+hJ5oEoQcndLVBy412cKhTXYupqKszFbpC2ihBo8L0Rxj0UaYZ9zEotM1tik2cWW/QwPb4sHyYeAB+1pC0NNlW2zRK+VDuJDmk7Y9MjYCqXdLzjOHJ7M3dEdqxV5UqWjkStKOmedpFO9KjV21ldiIPyAtBXEAj16dD3ghlXuX7yeWvSX+Pof1A77kELdps5ZS95zphn8V8+eqkF0QLJ69E5L93zUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRMUQHJdCmVvpArvc2ksZlTiTrLV0YryL2yzSwg4Ulc=;
 b=beAZ20RGtqFBsixf9Ry2lwk5Ku+mDFAXr3Rnr7UCF2dxKSq1oThZCT5RswP2Y8RvYh5SSA5v1m5XoRw6eImKKgWBFrtTAnqsooVvlZ5OxvljoBMc4ZD4A1IrkqCkcoTiUBvQWscbJLWWLzCSr/PvG5KjIz00IbRQu1MQMM7/KjcUW79aX0VBr6Tm9KUX2QbKSMMZynaoDP5Ln85lGxr0azyqJgRhAj4MOm6SZhxl69mvu+cx07evuKGPB+FPMSHPCk97OeIuij+thFZ86ROK4LtMI29sNG84hW8YU2kduX8RXU0EJ0aweQuREkKFlBZNvUxEckru2af1fUJ6/Sl5rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRMUQHJdCmVvpArvc2ksZlTiTrLV0YryL2yzSwg4Ulc=;
 b=Whpty2UT/dgQQ/1BExGEIscPgXS9teW1lzcwzYkzJ7DBYrr19wKclHG1cTk6TQnSOV5s7eFVCXPLcQvl9WyAWGlh+rxDANFfZm9TyLENjaXPG5V8tlf2+vWaf/gPCFIqeyZksnJSj6SGk6fgRjVWHB9GpFxPyUKthekCK3/wjOEyoUV5NkrvHYlEtFgGnbRMs4G46dVMeLamyLTqxmcvOz1TKwXocZU8m8CjMUE+ju+KMxq8pmlixnPgzUuL/ptRmSb5m7eLDfzZHpACLoVPDRaSmGk5fUAbf3nx9dR1BjIaWt2tHuvfMztfNMsyGxobIrOKvZNQYynJq6HAJX4Raw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB9977.eurprd04.prod.outlook.com (2603:10a6:800:1d9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Tue, 29 Jul
 2025 11:20:05 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 11:20:05 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Sun, 20 Jul 2025 06:13:56 +0800
Subject: [PATCH 5/6] usb: dwc3: gadget: Add delay after software writes
 DCTL in dwc3_gadget_run_stop()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-imx95-v1-5-759619b47b1f@oss.nxp.com>
References: <20250720-imx95-v1-0-759619b47b1f@oss.nxp.com>
In-Reply-To: <20250720-imx95-v1-0-759619b47b1f@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Troy Kisky <troy.kisky@boundarydevices.com>, 
 Adrian Alonso <adrian.alonso@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, 
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB9977:EE_
X-MS-Office365-Filtering-Correlation-Id: aac0616b-5bb2-4a47-d596-08ddce91de51
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWhsUEFyTnNjS3E4bXBqODB2cVpqTnA2bmZaRWJTOS9YWC8yUzVwUXhGajBP?=
 =?utf-8?B?RW9xbk5WdDhUWkZjQ2x4ZDZ0K0V4WE5Cc1ZONzhpbmZxVnlVRXdPVmN6ajJS?=
 =?utf-8?B?Q1hMMXVDb1lYM2NsNmc3WHVZZVF3dDJ3NE1KRlY2dm52UDhMOEVMVnl2TFJ1?=
 =?utf-8?B?WDhzUXV1SDZpSFJ1OFliejZQbDY0ZUw2U2t1TUJEUlR3R3NTWGdXblQ3bHB5?=
 =?utf-8?B?YU1OQVpsSE12ZmhvTWFrREJTcTFzc2g1RWZ1WWhUVVNmSVgzVTc0T1M2ZWZa?=
 =?utf-8?B?VUYvMU1GVTBVLzJXNnBQZVVlclhhLzVWejB4QWxvQXBMYWpCakREbDZXSlYz?=
 =?utf-8?B?eklUZEtzMFN3dTZPdG1jUXN5enhrOW1oY3dBbWlCQXhVK0w5Q096bk5OSW9x?=
 =?utf-8?B?NkZyTENHSS83cGlwek1TdHRUR1NtZ3hSeVFmR2ZTMHNKUnQxRHZ3YTJMR2tp?=
 =?utf-8?B?S2xYWG5YS3pXMVQ0N1Y2VlZaN0w2Z3dOVTBacjdNVmh2QmM2Q2VwTGZwMTVi?=
 =?utf-8?B?dnlPc2Vab1dXMlZhL3d5ZjFMb1htK1J6M1AwQ1NyUGlSYU1QRmQyT1ZSVTZD?=
 =?utf-8?B?elFFcllTb29CakdzOUxDUjZxQnczV2toR1pnT1NtZjNoMmdLTGlpdURYZGtQ?=
 =?utf-8?B?VzhzUEhqTmw0Y0NSOVRYcGFQWUUxd1VHeWpiUTFQM0F1TE4zazB6b1k3RTN0?=
 =?utf-8?B?QWcwVTc0MFcrZERGc3lYVFJOYTErVWRobzMyNlB6aWlwV2tPWUg0bHlwSlRN?=
 =?utf-8?B?c3g0UnRHSWNoK1piRE1PQ1JUTlVKNWRRSE5abmlwUjJFRXBWVmZ4cGtORFR5?=
 =?utf-8?B?Qk55Q3NQNG1wL2k5VElHdlNKRmcvdmFwVXZNdEJtbENxVmpUVEVVTU1EU21s?=
 =?utf-8?B?dmVzQ2c2RFFSZ2lhWWx0czZENUhnM1JJTlFLL2NvcGx3V0FWZHVRRkJjaFJ3?=
 =?utf-8?B?emt0d0tOeVQrUXdnTmRlQjZDelh0UXBwM2dUYjVlcUpVeFlRemN5T0RRQzQw?=
 =?utf-8?B?OGk1UjNXOW8xS3J1cnBPNzVORktGaWdkUjVRV1ZEZU52aU9BN1M4OHNDVUow?=
 =?utf-8?B?TzZwQmhubk5sMWJ3Vm8rWVdpVm45TVlPRkVObHlwTko0VGVHTnB4UDJpakVV?=
 =?utf-8?B?NXQxVGxyTVJ6YnRWb2MweE0weE41U0hudittT0loRDRrZTE2VFFKK3NCc0hw?=
 =?utf-8?B?UFhnMWM4cU1RT1dhWlV0cmIzQ1FlTi9wNHA0UE0yQU9NQmk4aWVPSitlcE1y?=
 =?utf-8?B?QWpkYURia2JLV3hPVTNodG9ZTllCbE42TmlXb2pYeFlqN3VBd1F5TVMyTVpo?=
 =?utf-8?B?YldBUlpsK0NtU0JHNmtiWjdzUEU2MXdadnhJcWxLY01XTXVxbENhd3kzN3pv?=
 =?utf-8?B?dytDeVp3dFB2T01wVFRGNldwcURXVCsrNm1RVHRmTE85OEh6SjFrZlZBY0Yy?=
 =?utf-8?B?NkJVWUsxN0FFZXdOTVpWVXQ0ZVhDT0xsOHNReW5HTC93VTN3dk9RUi9jRmI5?=
 =?utf-8?B?OE82a0pleVZxQU9lRXF0ZTVUaTV2VEVtODNuU3RTSlZySytUN2pqMUltM2pH?=
 =?utf-8?B?RGkwcjFMQWhxZFBGcnlqbEl0MmE2NzlzUzh5VWhySDJsN1owVFBEb0hkSmRG?=
 =?utf-8?B?dkFnRHMyNmJJK0x2Vjc5cFlIdE5ra3dCYnRQZFV0TUZvQWdoNFdkTld4M3hB?=
 =?utf-8?B?ZXh5QlRRQkZYdHVqN1RCME5SODk4ZWpOdTFJNEc3OTc4Q05UQXVMYU9mRFVj?=
 =?utf-8?B?VVQzclR5c0hOL3Z6MmhBRXIrWEpZcHpQYWtLWEZZWGJhODBNT2VreVN2WlZi?=
 =?utf-8?B?ZHVWd1c3NGNCaEJSRHFHQ09Fbks4VjAzem9OV0l2RzdBcFJZRGpHeDlzZTQv?=
 =?utf-8?B?QWJWWkF6RWFQbDZESTFxY1o1N3phWkoyVUhQMmI3SnpjNU5FelAzOUNFblJw?=
 =?utf-8?B?ZkJCOHNFVHhGVWZaZ0k0MmRPOC9yenFta1Jwc2toejFBNjJNT01FS3FVRzdl?=
 =?utf-8?Q?lXbwf0heENZfiPrwFT7q6bp8XjkE/E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkhUdElhOGlySDluMUh1M3d4NEN4RFhoOHVBYXJlQlBwL2JWOHdjRGkvQWZM?=
 =?utf-8?B?eXhNVThOaE1Ya0VwVlZVclcxVGcyYlJwNERwSENGYTByUjNOcWhZaWlTUDUw?=
 =?utf-8?B?RjBlc1hXdTY3eUUzQWRhU1BCM0wyNStRNTdHYkRVdUJZMTByaXNzKzRLUnlM?=
 =?utf-8?B?eC8weUx4T2ZVc1FTZjVYRTlBbE9GN0MwcEJGRlRINkZncVc3SnYxQmg1OEV6?=
 =?utf-8?B?clV6UEtUUERpV3J3eFBheVhkYkpZa1lQRmhlWm5RZTUvSy9jcTNVb2FxeElk?=
 =?utf-8?B?dGVzOXRlTlRPakZhczd0dGM0bDlycHBxTi8zbnVRRWtoMEVMYjdyQllnM3dI?=
 =?utf-8?B?SzBJWFJLSjRYZUxnK1p0V1hjNnpLQWNsNDlXUmk5TGU4alFlWDFIU3hZL2Vl?=
 =?utf-8?B?MStSQ3cwWUpqZlFKUG5tK203WmFVeFZHUlh6V3VTaWUzQnIwdEZHaWxJbENv?=
 =?utf-8?B?YjFNcVh6RmFCQVpiS2wrRlFDUk5jcDVnS092TWpSUGsrbHBTV1l6WlN5TDdL?=
 =?utf-8?B?U0c5N0trRFlhRTZwcmtLcWRiRkFVdWFHdXRxb3kvMkNJNnRiTlhLOHJPL2FX?=
 =?utf-8?B?eFRNcXYzUHdFVjlONWVaMjVobDd1N1MxbzhGS1RaM2hVU2ZlLzRNc2RVaXU2?=
 =?utf-8?B?M1NKVE9aV3NQQk9BbmppbmdjRzlJbkFlUll5blBHZDluejlVUzFGcDBQb1pv?=
 =?utf-8?B?Y0xzZS9kTjN5RW13eXlMcUQ2aXdzUkRVL0ZQc1NvdSsvR09pVmFYb1BaUEk3?=
 =?utf-8?B?WURyZ0dQYkowWjV6QjJMNWdCZzlyNzVJRy9IOWl6a1FjaDFqQ0JhQmRYUG9W?=
 =?utf-8?B?cGtWVERyQ2w2cFBSZE0xS0tqL3IvY25mOHpNS2V5OFpYVDJnd3ZodExleFVU?=
 =?utf-8?B?WVl3Mmh3U1hWQjNWY2tNaWlVbVhxYVMwRWUvU0lpZ0R5OVhNQUg3eHpmVWlz?=
 =?utf-8?B?T0piMWs0bUxwc2tuS0FycDhsaCtvNEVaUlMvNTlNbnh5eWh6WEg5SmRKS2Z0?=
 =?utf-8?B?Q3QxYTNGaEk4Qm41dGZyU1Vqak4xZlczN3ZLa2MwWnZzdmgySFROZDFmRjc4?=
 =?utf-8?B?ZE9vQk85OGFrbyt4WjN4a1pMOUdOY1hNZmI5ZnRTSldXeUFNRFNtUlo1cm5G?=
 =?utf-8?B?WDZNQnVDN0hhc1g4ajl3UnkxZEtKWGpOZFFkNnVZVC8zWUpFYmlnQlNPVFZG?=
 =?utf-8?B?WE9FSm1OeXh0dDZ2MldsSXFUUS92Uys0SHB5M1dFWVU0TW5sWUhBcG1VVmxv?=
 =?utf-8?B?bUFOZlZqTWk4VlhQT0xtd3dNZ2F4dlJTTk1aZzgzRzA5aFpSMkRlYTR6Z0c2?=
 =?utf-8?B?QjFPQy9QazlJT1E3d0pwNUlWekU3TFJXMlRoald0c0lIYzN6S2YxS2NqZGht?=
 =?utf-8?B?d0dMZDVwUmFyUmM4czgxdXVXR1lZS2pjdCtGWVV1SmxGUDdIY0FQTUw0NEN4?=
 =?utf-8?B?M2YzZko0SjZZVzR4a3pSUXphMVhpb3NVUzgzSkx4RkFXUHZnVkNBZW5raS9L?=
 =?utf-8?B?SHFpcytDTnJkcVNTc3d0US8zRXJ4bkFoZmdZWTNCdG8vQ2RnaHFKUjVXejA3?=
 =?utf-8?B?K3JYTGhvYTAzVGlRczRrdFRGS21jZGNNaVNUdkQ5YWp4YUNzUHN3MzdqcWtr?=
 =?utf-8?B?R2s2bFFBMFZWR0xQQUxUREpzNG04UHpFcWdNd0VzUXdvUkpKSUsyR3BaeUdP?=
 =?utf-8?B?cUtIaDY1NC9BeS9MWDFBdTFnYnczVVlJaTlOMjZoQ2pDYTNud3RhdFl4cTJa?=
 =?utf-8?B?TzJjNEFlYVNxbCtxSGlrWGhTTUJEcG5VSjg2aUdmUmMxdFR4QnMxbjV5QTU5?=
 =?utf-8?B?L2FaZHRMMnlPaHUvQitUb0pWVjlUQ0pnYmU3U3Y4TUh6aGkyRFJwYnJzbHd2?=
 =?utf-8?B?MVdSTERaMGhQZFpnUzh2SzA3Tkl3ZzFZQU9zcHpaV1RtMTJBMExZT2M4Q0pm?=
 =?utf-8?B?aTdhZkUrRjVjajhEN3lCcDk4UlA4dFZCSmozMlVjNUptTExlc0djS1liekdI?=
 =?utf-8?B?Y2JjblZjNXpDcDk0aUs1bDlYU09qckJ4L2dld1lBZDQ2MDNjRW5ySzBYRTE5?=
 =?utf-8?B?VC9MKysyZ21ERkFxeWVvbjFIWWl3OWV1YkltMStUUlVkb3c4MVF1RTZkbjd4?=
 =?utf-8?Q?wgwlGz+8PL6X+ruvsJ+xoso8v?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac0616b-5bb2-4a47-d596-08ddce91de51
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 11:20:05.4043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hw5I038wFFrIpaRc94ST1gcaRnrJ8OD9BZrCU8ypyB2MB0CuvqdFhF+GJ1n5scnnF7NbCj1XLCfws7lbgP6q3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9977
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

From: Alice Guo <alice.guo@nxp.com>

When using NXP UUU to download flash.bin to i.MX95 19x19 evk board, it
will get stuck in a loop at sdp_init() without this change.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/usb/dwc3/gadget.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 2b01113d54c..6b2b25c7aa5 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1423,6 +1423,7 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 	}
 
 	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+	mdelay(2);
 
 	do {
 		reg = dwc3_readl(dwc->regs, DWC3_DSTS);

-- 
2.43.0

