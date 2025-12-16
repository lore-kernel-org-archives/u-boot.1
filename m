Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B60D5B87C
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 06:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27F6A8334F;
	Tue, 16 Dec 2025 07:40:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gwnh+LHY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3413838A0; Tue, 16 Dec 2025 07:40:20 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA8678334F
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 07:40:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQ2yvoGMzMI52jHQI8Xr6O0KHpZvLgDg5zXYfsLy/GId7XxonW02GxdoaJlOSAxuBRQxgKnqkuFvnZ5nwOQ4FRfFHx1TdR8e1RWaiWVour03gIB4EUHDwk2duZfHJC8iyf+XEEzSlZZIj4Y2hyDB4ZtNTkbtKzcuYGVPeFhlz51BfWzSP6z39zJBfOTgHo/C3RSgiI2sJpvOf+PJkuIG/DOuA/cAAbzYxa3szWtMOe1sPRBgsjowNm48Xte6IV/D+oBcapsSjIB9q5vjLW1PvWy6fwFMS+YgDQ4eO+Ls7rrtVYUid1wfm98lTur2wKHiWxWBU7TOuFtiqYK03Mc0hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VumIanwsa2Ow7p+SDbl3L7+a1wrgDv/OfIOfPmy3ADw=;
 b=yITVQr+rLUxMODct8z5Axa+SIUZxXYkeohVvdRsPEdyHn4fCR2IMh0ZhEPii7xXhFANkeYTtV9CtTGr42HGvhNYK8UPBh8mzanAwF4y6Md9E19QRc6zAbjmAW3jiDmHq3nd0eFPiStaribCRjT+ZkXoTRmXpz47pOfdO4GMx442O0GEEDB/hiQYEJ4Q3IfroMiyeYF9/0QACrP9B8TRTVnAlbA+qxxpD6yoqietnKtyXw8AqSZlLPowjlGKXFV5moQKM4parQvOc+1G4ZaQ0sgyiFpNZTu2vEZqOY0IY005vVRpL+v2PFHoHwcaJKjwT85XqVKRnL/dxiYzVhew6JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VumIanwsa2Ow7p+SDbl3L7+a1wrgDv/OfIOfPmy3ADw=;
 b=gwnh+LHYAxTH5IjlbXu8rB3ZiCbHEDVSeEPOFqepGILJRObxZSw6agXLexgOLZBxXa/y9gV1ZWvKmprN0B8WFDXQFxJfmz7+sb06LQyug4Nc7A/98vbviVVkRN3BEcZ8EUoNFVIfY8yeZhg+WAnNwZPBM+AdlBk9DPDXQfa3/P24Kh3ikPacH/p8z2RSOn4ITPbZ8t6UyP4Q7y7bQtZMsHtElBqckeZmLKuUMvEQaWcan8JFtkUnffz7uJZq11XE3UIShuBPP5xjffGmMeaQlHmaILfUqQY93SsSEh6W4H3AUpUg5h9VyNzBwYufMdjsn4L7gwK0VzgAUTUom+cPpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7794.eurprd04.prod.outlook.com (2603:10a6:20b:247::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 06:40:16 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 06:40:15 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 16 Dec 2025 14:38:39 +0800
Subject: [PATCH v1 7/7] imx8ulp_evk: Enable USB controller at 0x29920000 in
 device mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-imx8ulp-v1-7-504115a53020@nxp.com>
References: <20251216-imx8ulp-v1-0-504115a53020@nxp.com>
In-Reply-To: <20251216-imx8ulp-v1-0-504115a53020@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Marek Vasut <marek.vasut@mailbox.org>, Ye Li <ye.li@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@denx.de>, Sherry Sun <sherry.sun@nxp.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 George Chan <gchan9527@gmail.com>, Simon Glass <sjg@chromium.org>, 
 David Zang <davidzangcs@gmail.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: b4738e90-6032-4922-dabb-08de3c6df8b9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVQ2eUZCeVBiaHlrNFhTRVM2V2xybHd6OEdvL0huOVQwaDBaVFRRdW9jNE9J?=
 =?utf-8?B?T2VOZ3lhSEpucW9PYllnMkJqTTBjSmdTSVdaczBlaFB0QmNxLzdEZFRrL3R3?=
 =?utf-8?B?Ym94QnZDSDFYR0ZkMVhJSi93VERDL3Ruc1VsZ2hKQTlHeW1FRkx0aEtpVHRP?=
 =?utf-8?B?LzlUUEd1T2lzTDlMNVNnWGdBNEM0L0R2OVNYMXBvby9ZZERmNmJ4b3NZbVZ0?=
 =?utf-8?B?MnJiajBINzN3NllJVXBWdDI5RXAycXBKTDdRTUtaY0dpcTJlS2xyVXRJdHJh?=
 =?utf-8?B?MXk3c0FoRnJxamgyM2lRWGlaaTRGVkxnRFViQVQ2NE1hczQrMzFOZi9OUUJx?=
 =?utf-8?B?YU9BRDFuMnp1S2h6NkdGMFVrVWg5RWZVSDFrbzgybExaU011bUZIS09IaGNu?=
 =?utf-8?B?VVNXVnQ1Q1YyWE93cm9QWjEyTkx2V0JjS1UwMmN5WTRsLzlENnNvRWpReGFD?=
 =?utf-8?B?dGlKOXhvVGtFZEljSWlHTjR4RG5UUndJdlVFVWtVUVFoejdNdjBCUWs0OGdO?=
 =?utf-8?B?WDBPRjBhTXorc0oxb29NNXdUc0IwYldFdkhDQzFPVUw2dVZuby9OZG1wcW92?=
 =?utf-8?B?R1pxdllxZjNSWUtPU0ZleGNZRlNQSjROeUpjbTBkMGxBUjlPSjVpM2Z1T3JG?=
 =?utf-8?B?L1RwN2NxZ2xpYUJDR1FtbjllUTQxcVZhb0VvQTFjeHFkVzVBY3Zoc3hCQ21S?=
 =?utf-8?B?bkVMRUR0OTRERUJIWDQvSXV4VFRnR3EzR2NzUGdpOUhJS2hKV1BzN0Q1Mmtw?=
 =?utf-8?B?c2Z0RWd3MGlTK0lzZzdsUHY4OVRmTGt0S0ViUVJNMGVuZGZrUFVnMEFwdElm?=
 =?utf-8?B?b0tORjJydm9BbTREWUNDTFpxRksraTJEVGp5ZWFlSzFBblhjdFFmT2dqWkY4?=
 =?utf-8?B?cXh5WXdRbi9xams0SnhUZGs2NlpyY0N6bW1HZ2hoaTFoWGw1VWxzOFk1dmlj?=
 =?utf-8?B?dm4ydWE3M0tnL3phRmhWM2t3RmF6V0QyNzFRaTQwdWRoY1M4WjFRNWpnYmZU?=
 =?utf-8?B?YmpWNkVrMUkrMFgwTGl1OW45c0VMV2ZMbnRlMWJCY3d2eUI0SWdFVmVtSXVR?=
 =?utf-8?B?MXZrYmFodUJTOGF0UEt2MzBsanJ6TnRZVHhzNXNCMFZiM01CbWJqcjRyMXR5?=
 =?utf-8?B?bnFmUngvd2xGK0p5M3phWEhBSkNOd0lkcDBtMEZJQ3lQZEhRMnN6MWp2RkJk?=
 =?utf-8?B?WFFybWs2M092NUFZOXQzUldDUWFna1dCallnVXFReEVJOFNVb1NHSjU4eUUw?=
 =?utf-8?B?ZHZXWllQRVJ4d1VHQUNTMkM4cklFb3hvOTFZekh6WEVhclZKREJQdWVIcCtj?=
 =?utf-8?B?WU1aZmc4bHJnZGJya3pFTG5mTnZpTlVoaFloZ3NueDVrVDVTVWxGY29QS3kz?=
 =?utf-8?B?QkI5Z3kzY3lqcWNOY3ppSXBZdUtFVFBSaWNtUDNvRXN1K2JXV0xQcjZxOTB0?=
 =?utf-8?B?dFA5TjYyK0Y1OVVIOU1nZmdyd3VVWldNeGFaanVocnlwa0M5ekRaZTh0T2dU?=
 =?utf-8?B?TTU5RnVTMjJRbTB2cWVuVi95WjJxWlNCS01xWElaU1RxK1FwS3dVY3ZUOHZr?=
 =?utf-8?B?OWNwaThLL1VhdFFZV09xdkZFNXAxcHpBMkNPUlhxNVJjUkhQRkdXZ2RPNVFB?=
 =?utf-8?B?YU9QUE9oNituTHd0OHUrTytKaFc0V2lnYmk0M0x1RFJHWXdjaHEwVk9IVkto?=
 =?utf-8?B?NWZKQ2dKeEJoVU11dVkzTU5lVGJWYk9yWjljQld5WU9vc0ZYUWkvdlpMUFlk?=
 =?utf-8?B?eHMzOHdZd1VBaFRVVDd3N3k0WXBUV0p6d2hkNUJlRHpOTWtvMkJIS3d0bnlr?=
 =?utf-8?B?SnRhRERHQXZkRW11dTZ1WVg2M1IzT2VmNXJnYUxFODFXQy9LZU5nd05uZWla?=
 =?utf-8?B?aXFHVFBXSHQ5MFJISFVnMHRmTTlmOU1FVE0xZzJYWUVRNVd6aTdHd0xQeElC?=
 =?utf-8?B?VnQrai9FblpHdVNxTUVMeENZWTZFcEhaUUQwdHlyUk13VWlmWFhoMGlidmRo?=
 =?utf-8?B?THB4NThmdDR5amMvc1lTcnVoZTVEZkRWYzdBeW9hQUpDcXRQQVJEaWxWZGJs?=
 =?utf-8?Q?yOXhES?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmE2dCtCb0s2UEt2c1JXRmpHaVZWK2w5OUgrK2gwdWMrVFAzQXJqOFlMT2pu?=
 =?utf-8?B?M0FEVWZXejFuVlRCMTdkRTFOTXE3RExrU2I1UW1jL0U0M2JzWG13YnkwdmFL?=
 =?utf-8?B?U2NaN2JWT2EvSHZUREx2NDJVeUdtb2kxM0VIN2xzRmQvb0NGM0dZeTBlWnBQ?=
 =?utf-8?B?ZjhFZHhrSmg3bE5NN3pTU0ZSanhZdmw5VXkzZ3dvM3RhaUlPL2N1T3Y0RWVV?=
 =?utf-8?B?SDBuVm1WZ2lpTmtyaG83QXV5Qk5GZld4OEhkUlhkbi80bzFVeGlRTy9iY2FZ?=
 =?utf-8?B?U2pyOUpaWUY5NTdRSEVpbjc5MDEyYjg2bFExZU5WWU9aVnE3em8rVCtic2c5?=
 =?utf-8?B?cjR0dlVzYmJUNmhUUU9mOEF2ZVp2cXNzWmpIVnBrNlpCNzZrblpyeFEyTERJ?=
 =?utf-8?B?SStJUlZNaDR2UFJPc0hXR0VmY1hjVW1oYUdTUlFONUNPQ0diSkJ5NWVGRDNT?=
 =?utf-8?B?d212b1ovS0xPbnlIU1h2NDl0V3NTNk55MlZPMHZkc1NpRUVvdjVualJoemVp?=
 =?utf-8?B?MTA0bG4zUFc1Z3hPRytmekR4OTdTUWg0WTZ4ZnRjS20ycmViWTFkNXRtSHNI?=
 =?utf-8?B?TG1FKzJiMlN5WkE2NTNYbEsxRHJwTVh2R09FbGsrYjdPOFZDaGM3ejI2b0lk?=
 =?utf-8?B?ZXViSC83RFRPT2Z6QkpHWVZLcmhoMUR5ZzdFNC9tU0FPbEJvS01HYThkWUoy?=
 =?utf-8?B?MEVsY1czSGY0RDJEZGptVUVjMmE4dGFZYjZSUHFpSHRDZzR6Z3o2WDR0Mzhu?=
 =?utf-8?B?SzhWajZTS2RTbEhieFNZKzFqb25RZ1p1djk5STk3WEU4b0NVVDdITHVUSWFI?=
 =?utf-8?B?ZkllRWt1OFI3KzExRzlkWC9TK1ZCRWNXVVhYOGVwYWIwNEY4SEg5bDZXdFRO?=
 =?utf-8?B?bk5WTUJuWWNYS1ZpUU50S0d3RnVBL1VzZ0pXYVNJdFRNMUdrUnRLNXhMOXBL?=
 =?utf-8?B?UmtsUkw5amIweTYyOUtUSk53LzBQNjZDUGxSVVFKc0ZTcWRlLzQ3SDZyTFRi?=
 =?utf-8?B?R1JYNWVubWQ0S1hEdExyNnRFRElIcWc0ZktrazVlS1JEaTlpSEtMMWF2Rzly?=
 =?utf-8?B?WTlWdDYrT1c5WEdzSTVSakt4ekx2Z05xeGpjMFM3SWppcnRNRCtFL29reStp?=
 =?utf-8?B?YXNscjFxa0JEWEYvYjM2VFNvb0NpdjcralhDVGw5R09DejVtSUc2UEkxSWJl?=
 =?utf-8?B?Y0taWVNsYzNDSjhCdzlWRWt1dWdCUE9QcjlZSzhnU0M0WTM3am5DOVJVWFB4?=
 =?utf-8?B?Q3J3bTZ3MEh5Vk5BdjhlT0F4RDdFai9WUmYzamlOK3VvMUd3S1hpR3RjUjhy?=
 =?utf-8?B?VUhmQkpFbjVvRHFMNm1IQlp0MzFnR2t1RGVkVzJKUWZ5V3RCQnBmVjN5NFBq?=
 =?utf-8?B?Y21SNHg2Yzc0eFg2VEVDVDdUdU51MUNYMTk4dXVKUXpjVTl2b1VlS1BwNHZt?=
 =?utf-8?B?NjdpMVVWVlY1VUZyL0JSTGdIUzh0ZVBXN1Zuc3BhRVhDeE1rdEl4VDZQd2di?=
 =?utf-8?B?enJXU3B2a0dCeVErMkVndHdCSzRrWCtVWkk2RXNIUFBOQUorckNoWmZzMkVs?=
 =?utf-8?B?VjBYb1p2aVhac0VidHlxZStlc1o2WVBBUWswMEFBUjVlaVFPbFIydlpWV1lx?=
 =?utf-8?B?N3Y2N3FudXZkMEQ3di9QRjk5TWtMSjM0RENqQW0yMzJVUUpUbmFOMm8rZUJN?=
 =?utf-8?B?YnRJVnZLNHNtNHZLMHJ6T2o1OG1hUStOclg3UXhjamlGbzh2a3FUT3RjcnlV?=
 =?utf-8?B?bFkxWElCRFIzazlXSndjRWpzcHUzdHQwZlBmckRCUzhSa2JYdEpmSVdXLzZO?=
 =?utf-8?B?U0I3TDE2VmNobWFvQlhhNWRIRWgyd2NiaDhOT1ozZ3BQTEl3Ty91ZUdnRWxm?=
 =?utf-8?B?QUFFSUY1cFdRTGxqUnBmQUxSM3MzTm84amJoN1JCc2E4enYvYTloMklUb09S?=
 =?utf-8?B?VDhDS29TakZmem1pcW0rSWtMa0w2cXlOOTRtZXk4VW1PUWx1ZGMzbEhHOFUr?=
 =?utf-8?B?U2VHd3J2RHUrQkZMdkVQTkErblJvL1hUWDVwL0RSTnVOL1gzdm5qTzVUK3NK?=
 =?utf-8?B?U1I0UlVGdjVISzdOYW4xMVNQNXN0RzNJU1NENHBUUC9JVktKbWsyT3kzbGpT?=
 =?utf-8?Q?Ds4+LmBbBB1vMnRjPc8xjwmsH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4738e90-6032-4922-dabb-08de3c6df8b9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 06:40:15.7434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fp3k9D7sCxjF6uP61UUgoUaaIDd9v65e0SRqctsriEcxqk0xzGyWia+/zeyQGfsZ/NL0Xwt4Q7U901IAz/SsJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7794
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

Update the i.MX8ULP EVK device tree files and defconfig to enable the
second USB controller (base address 0x29920000) on i.MX8ULP EVK in
device mode, allowing the board to operate as a USB mass storage gadget.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx8ulp-evk-u-boot.dtsi | 17 +++++++++++++++++
 configs/imx8ulp_evk_defconfig        |  7 +++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
index e35653edc29..e4f47bb1dcb 100644
--- a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
@@ -12,6 +12,19 @@
 		status = "okay";
 		bootph-all;
 	};
+
+	aliases {
+		usb_gadget1 = &usbg2;
+		usb1 = &usbotg2;
+	};
+
+	usbg2: usbg2 {
+		compatible = "fsl,imx27-usb-gadget";
+		dr_mode = "peripheral";
+		chipidea,usb = <&usbotg2>;
+		status = "okay";
+		bootph-all;
+	};
 };
 
 &soc {
@@ -38,6 +51,10 @@
 	compatible = "fsl,imx8ulp-usb", "fsl,imx7ulp-usb", "fsl,imx27-usb";
 };
 
+&pinctrl_usb2 {
+	bootph-all;
+};
+
 &iomuxc1 {
 	bootph-all;
 };
diff --git a/configs/imx8ulp_evk_defconfig b/configs/imx8ulp_evk_defconfig
index 5fd73ce4ae9..52994e4f785 100644
--- a/configs/imx8ulp_evk_defconfig
+++ b/configs/imx8ulp_evk_defconfig
@@ -55,6 +55,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_READ=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
@@ -95,4 +96,10 @@ CONFIG_DM_SPI=y
 CONFIG_NXP_FSPI=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="FSL"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_CI_UDC=y
+CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_ULP_WATCHDOG=y

-- 
2.43.0

