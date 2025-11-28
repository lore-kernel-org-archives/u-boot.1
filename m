Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D03D116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 14:13:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13D5C845AF;
	Fri, 28 Nov 2025 15:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="ApCsKzUn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EECA384445; Fri, 28 Nov 2025 11:07:22 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C2D583B9B
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 11:07:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJEsdLlBE9zgHGswKAHndgquy9yQxcoNRrvMgiouqtctDbZ0YfVEOioLdnw8l0hDJLVSeop0Jid2Y5eQBGoDQmo9buSQFniI7hPS8hBahtARLIWBxQuyxO6aHtzn2fZzuU9k80nNcNVCoSHRykGhNU1YQ4Qg/pvM32an5XnTgU2v0Ghcc5+0FSR9+MG5OrAbqw/NJSME0UGM4JP38bNBEk1guG+RfKE9ZrQMqfmRih4YKOG3w/mO3eUCIfuJROY91se2LzhuZ/MrRMWKi8NtbzP38b7XWivRQYsemHh61wpKZ5J9OvYmhhHfTAeqDsryAKq/IaugU7sPhrTeUAPiXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4s0BXyopOw7pPz8IQmeoPLzvkzVDAS+M7J7VFK/jV5U=;
 b=sxdqsXHEO7Aa8sKTxaZ/G8JEfs5hau2JL5r6AXGMIG3ybWh4b9HOv7bIm6eCLxSIIEiLbZzJAQeIv5BifUBCa7y3fGII+VWLeMN76GHvcXU4T0eiPQkodW51DhDswEWuwVHBcLK4N+Xn181sSmn1PG/8VvoqQDa9vDvTW2Dn97XyCNZ4nY/L+BYasi59nINFqvGCSdK7Bd8nGWyaNuZDB1Br4oHgzGYDtOf4p+UR47t5Jz+wdtCC3/0fNCKAqhDstW2N1ubAz85sTBA1X4x1tNwu4t7guw9c/Q5zqfsTI6v9rGrw6kQt+J7WyVo3gUNNZpuuDFpbEupKpzsxEi2z/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4s0BXyopOw7pPz8IQmeoPLzvkzVDAS+M7J7VFK/jV5U=;
 b=ApCsKzUnqzCpi8YyZEwPUzLFYjV7Z4Gbt5/iZ4B14d674tkysEIC2RgfOaVEXdxaYRxzgInrcHmCoWk9xCPovSxTEFHrSrb3q4MdEMyjlQfgZ8QsvLQ0kDlgi/MobV0prJ22vUE5MGmcZrwCsLKHjmjRbnA5FLJnGSv4+teA4BxIc5pVgJH1Yd0J1wyo6DBnXphC0QNfkSaUa2YKYdiyucKO2ZGaCbD97EVLcZHAZp8qFNZHvUHCnGwn7AlXi4kTZ2tePfoy60U1NxVKPnngSZjk8/2d0Ah2OXSfNjoGwiDD5fV5wC59myX61+DNa4vYRU/jffec6K3jBRtsk0VyzQ==
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by DB8PR04MB7098.eurprd04.prod.outlook.com (2603:10a6:10:fd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Fri, 28 Nov
 2025 10:07:19 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3%6]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 10:07:19 +0000
From: Alice Guo <alice.guo@nxp.com>
To: "Ross, Fedor" <fedor.ross@ifm.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Ye Li
 <ye.li@nxp.com>, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
 =?utf-8?B?Sm/Do28gUGF1bG8gR29uw6dhbHZlcw==?= <joao.goncalves@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <ravi@prevas.dk>, "Ross, Fedor" <fedor.ross@ifm.com>
Subject: =?utf-8?B?5pKk5ZueOiBbRVhUXSBbUEFUQ0hdIGlteDk6IHNjbWk6IHNvYzogVVNCIGlu?=
 =?utf-8?Q?stance_number_change_for_silicon_revision_B0?=
Thread-Topic: [EXT] [PATCH] imx9: scmi: soc: USB instance number change for
 silicon revision B0
Thread-Index: AQHcYE7Hmr2H7hwjHUaKv3WlRG8zMQ==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Fri, 28 Nov 2025 10:07:19 +0000
Message-ID: <DU0PR04MB96363FFCBDC1AD5FE7F62707E2DCA@DU0PR04MB9636.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-traffictypediagnostic: DU0PR04MB9636:EE_|DB8PR04MB7098:EE_LegacyOutlookRecall
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c81b172-92e6-4f6f-65d9-08de2e65ea55
x-ms-exchange-recallreportgenerated: true
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?NjI0eUVwL1o1Q1hEOWI2OGl6dE9hQzBRSXp5THEvRkxOME9nOVpXWGZ3ZG12?=
 =?utf-8?B?SUg3VVg4aDdoSkx4VGRnalRJaFdQNEQ5eHhLWlBkK1BycGU3YjY2WExXMU5B?=
 =?utf-8?B?bHZCMlB1VXhldVZncjkzR0dOUVhoV1RSbVZ1SUw0MmY3eVBqd0g0TjRkYnRh?=
 =?utf-8?B?Z1lUeWFxOVNxUmwzWE1NUDB4c0s0MitwS2ZnRUVuMVVSR2crNEZvZ0NTMHM4?=
 =?utf-8?B?aWxIZ1FXTE1NelBXRmxNQWJKQk95NzVpMXkxaEdJWFIrYjhlc1J5R3hZV3lK?=
 =?utf-8?B?S21ZSWE3RTEwdWdrV09RMEhSTVFBdkM0bkV2OEFuT3dpcjV0QVRqR0hkTFBu?=
 =?utf-8?B?Si9pdnpXdXhnK0JqbnhBcXlqd3hhQUVUS1NZUFpNOVZ6UTd0cE9BY0grMXlr?=
 =?utf-8?B?OHNLcnhCcVd0a0srbnpZeU1vbzl1anJpRXcvaE5iZUV5SmcySmgwTUVVTVVa?=
 =?utf-8?B?a0d6OXdWL3BNMlQ4eCtua2Vud09iSVNUc3NHUFJGRDdPWHRIZzgwN3N5VXBP?=
 =?utf-8?B?VlhBZ0drNlh2S0JUT2dxcXBFL1JoV0dUdVMweGJyZlVKcS9HWno2NDkvU1My?=
 =?utf-8?B?R3hhajd1VFlyb01ITTZMUnZwUW45RnE0YXdYME9UZi96SWdRblhwVE1CRWl2?=
 =?utf-8?B?Z0F3QWtOb3NOekQ5Y3haY3pQVUNBcC91S0dySnhiZUU5WWlZSTlUTWgwUFMy?=
 =?utf-8?B?K3ZiVVBQMjJJU1llTEN5SlFUSmFHdXBQdGRoZVhNYmJmTXByY3YyWmdacFpJ?=
 =?utf-8?B?Q1NaR0lmYlcvSCs2eFRDdWFRVXFhdE52RWdNaERiNmZSdzBHMzVtUkkyTE5n?=
 =?utf-8?B?ZnhuM2tFR25jRUcrYUl4MG82SUIvbjB3QTdNWXQzWi9qdFF0YU5HT1FkVUVq?=
 =?utf-8?B?Y3d0aytibThwSHBkOUVWVGVLYmFhOUtjTVJseEJlRkdoWjhKTEZiYlJ4NGQw?=
 =?utf-8?B?OXNXTXFySTliWDg0OUtWb25LTEViMitvbTJJVjZqNnFVWEFaRGtvOFZ6RGQx?=
 =?utf-8?B?MmtUelp5bU1CNVArQ1Q5NUMreWU3cUZMYWhKVGtzbTd4RkViMUtyYW5FRWdl?=
 =?utf-8?B?cVZVb1FqT0VYNzZITFZhV2FseUlSOTBRQkxQSWwrSWluWmZwVStTOERuaXJH?=
 =?utf-8?B?YjBMK2FEeWVMdHZyYmxLRHFqZlVKSkc3OCtiOGtXREdXbkRwVDNDOWdvUmFi?=
 =?utf-8?B?Q2pDNTE3Z051ZTBFN1FRYjdOa3pFVkNTeTk0L3dZYTJLbFBKVW9jNVRwU1Rv?=
 =?utf-8?B?RjAwaVIwOW8ya1Yzam5icGtIRnV1YzV2Qk9KNURJSjhPRXEwQWRISERhSnBO?=
 =?utf-8?B?aEYrVzd4UEFXeWtzMSt0d3IzRjRTRjEwWFhnanNDY3oxZlBFV2RUSG02a2Nv?=
 =?utf-8?B?Wkpjdk5zTkN5RWo4UFh1am5lQ3BraUR6QTVoRUFKNjczUk1Ka2tIbmZuTXpG?=
 =?utf-8?B?dS81aCtvT0oySXY4SldIbnBLOStQWXJMcWYydHU2a0UvL2pseVBKcEZnck1R?=
 =?utf-8?B?cXJmclhKOTdNQ25QeXZhdndlc3VHbDdRN0VjeGZUczVkeXMwdVFBN2ttV3lV?=
 =?utf-8?B?Z2k5WGlWNkxjcHJnVXkyeUZad0IvaTR4cnE2TnAvSGh1azBGOER4b2ZlS1oy?=
 =?utf-8?B?S1RJdUE1M0I2SWFyU0l3alYyRVlhK3VyWVlrQXRhMW1EOWx0a1RnVHcvajlh?=
 =?utf-8?B?V0cxTG9YZGZpTEZpTlJ4eERPNkpaY2NhOU1VcWVVRnNhQ3c5bldzMlZ5b2JX?=
 =?utf-8?B?dlFiYnhZUEwvY0VlT0NhN1hIQjd1ZUdxQ0tQK2hEZmFSQ2xXQ2FqUTVNSUJO?=
 =?utf-8?B?Z0dSWTMzUU1UcjlBMmozbnFlaTVkUlkyL0xiWkVKVUExTHZJVXZMYUJLVDU3?=
 =?utf-8?B?bEpwSzVvY3hUWlNKb0NzWG01RVg1K2JNUDE3cHlYWi90RFRkSGNDSlc1clF1?=
 =?utf-8?B?LzJOWVhFM0RpdW1TTnZtQnN6YUNkdkVqSTc0Sm9JcWxnaFZFODJKVHBpTXRW?=
 =?utf-8?B?dW0vZ3VqUFgrMGtkQVVQZG9UY3dLaUZ1RFJpdXFxSlBTSXI3VmhoUUs5MmtC?=
 =?utf-8?Q?ZO6dVJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:DU0PR04MB9636.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2d4aEdINklOYXBTa0pNSE9heHJOU25oZmlIdVB4V3JacGhIYmFuZkNiSytt?=
 =?utf-8?B?R05jaS9wZTNNUWZKeXJFMUJkVnhHd3dvUlBJRzBiMXZzYzlURGlTdXlhN2Ra?=
 =?utf-8?B?Z0VrbFNKNHFrVFZHb2thQTV2RmhhT21FNHZxZHhBUG9zTEhiRFg2dWQvTGMv?=
 =?utf-8?B?bGswMU91NGgwVXNpNHZCZ1VMeDVsVmQ1Y0FXQmU3bUxESndBNHNna0ZoaDhp?=
 =?utf-8?B?clBVZ1NWY3FWY0kyckNBa0pzNFdXU3ZBRzRGdUxEbGp3a053ZWxIcFRaMXpm?=
 =?utf-8?B?cHF1b1J2NVBtZHF0QmhtTzNEaEFlMlMxYzFvUHFSL2xiMys0T1NGYUFsOWFu?=
 =?utf-8?B?R2ZMOVY4c3NxS21WMC9KR0ptYUYydFVFaFlSc2lXWVI5Ri8yalNpdDB1elRx?=
 =?utf-8?B?c09tTnVYallQV2dZdjBzT3lpcXBoeVlTSDMvSjJqb0lHRVJsYXQxTFdKdGZp?=
 =?utf-8?B?eHRwWXl6a005UjlQcWNXOWNiRjZTYWJDbjBobGZrSCtqTXh4bnI3M2V6Qzh3?=
 =?utf-8?B?MjUvNmt1d3RTYSt5RUw0U2RlZVd5ZDdGRlBYQnVhWlZ5cDB0V3JCR25wMzBP?=
 =?utf-8?B?RVFXaFg2MVJaenZ1Q0crNSt6UkxPZllvSlI4MytLaDZpMlVsMU82MDNZUTYv?=
 =?utf-8?B?SDl2bVRsVzBFak12bVBQRCszUTRTakNreXlGdmRJeW90ZkdWbHhmOS9ocG5a?=
 =?utf-8?B?dTZJbTZ4aXVYSkFTeTRBUm8xQUNsMkpkbEZjRXdvSlI3Ri9Qc0E5Q29iejNG?=
 =?utf-8?B?TE1Yc09uaXpDTUJzRDJ3ZjhQNWZwcXVLcVZQYTBLYkRhRHl1bjhSMnpWZGVG?=
 =?utf-8?B?cE5QN1EwbDlnL1ZUNlJ5eThhOXNReHA1MkVkZGkvRjU2THU4NkEwdWhubFRU?=
 =?utf-8?B?Tk1EN291QklMdUdQam5lbWlPMHlCaHEyZUIzMHR2eWVEZm1JRVJNMHg0dVM2?=
 =?utf-8?B?WkJ4MDQ3YmpBaklhdG0xVkkwSVh3NjdaRjdKOTRBQ20vSTlNZ2NrWk85WjFC?=
 =?utf-8?B?UHVBVVhrQURsS1d6U29GRWJ2QUJFZ0QvYTZ3d084bnlEdnl1alZrZ2hBT1dk?=
 =?utf-8?B?YitMSVhnVGo2NXlHdC9scEhpTjJjYnBVNmxkb1dSSndKcDdTVEdWbTRYL1pY?=
 =?utf-8?B?SVJTVldXNFVDZEJJTjNnWnM0Q1ZGY013S05CRTRCN0R6eThneVk4bXZtSjl3?=
 =?utf-8?B?bGZBQzY5YTVVN1ZjcHNIU2syVHNHbmJXajBIZXNGQzl4ZjJUUDc1dEc5Ni94?=
 =?utf-8?B?WThlR01iN21hMWl2NzJHMEswMGFzY1FNaSs5M0RVajNXdHI3S1BodFJ5eFE3?=
 =?utf-8?B?VmhmZ1FMZ0djcFllaUttc0ZqZUNHMG1mbmxCbUFQaXQwb3JjSmRaaUlwNDFs?=
 =?utf-8?B?aGMxdGU2R0JUNTI1aFNUNnNmcDhOVW1yWVkydmZ1aU9rVzEzUFF0V3pOUWht?=
 =?utf-8?B?Q1JXT3kxMjFQRWgvOTZsUGZlcE5LTXBvcDk2MXZOam9saE5PWjliWnlqRDRs?=
 =?utf-8?B?SmRuNDgzN2pxUDRKMHdmbTZ4VFhtenJVVzFQQnNZM2p3dDAvaXE3cWxuSE8r?=
 =?utf-8?B?UDA2NGpLZlNZRVVIVEtwemNlVVV3Y0Z4WWpUcW9NRko4M2c2U2kvN3VBdmhl?=
 =?utf-8?B?cm9QSnIwWGVoRnRtemFRTXZNT2dpcVM1bWI0MTgwZFF0T0pEbGxjWTZ2cHlJ?=
 =?utf-8?B?eDM1c1BSOTRmTmpkY2ZQVHR1bzFKM0ZyZjRPUmo3QTRRaUloVm83YU4rRkU1?=
 =?utf-8?B?OHhhUVNRSkI5Y1BLWFM5OUFreGQzRVUvcUgyYklpQVZHSXY2ZHdTNk14RWNC?=
 =?utf-8?B?UVdUY1k5bXBSVWlUWlo5aEo3WjFwWXlwMUpGY3Y1SjUzazBlT0pxcUNHWEJ5?=
 =?utf-8?B?ZmZmaW5odk9FWnB6VDFwdHljS2M1dDRPdnh6M3VNM1Q4Y2RuWWNVNWpXcXBS?=
 =?utf-8?B?eUNRUkN5eE1YZ1M0WDJObE4wZVYrUm92UzB4RHkxLzE3KzNEN1lVc0hMT1VO?=
 =?utf-8?B?K1E4VGxXcGcxVlZiMjAwWDUySnREc0t3cE1venNKMjYzeEc4LzlDOXZBcXBr?=
 =?utf-8?B?T2ZjbmdCdTdENkxoa2lBTGRQa25lSmpVb0V2ZHNwWDhGdWlLRWh0a1lIR2FB?=
 =?utf-8?Q?bORs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c81b172-92e6-4f6f-65d9-08de2e65ea55
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 10:07:19.0919 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ukJX6ju3lX0MJ3f8aYeNjFND+5FQ4gOXfmvQ/Ou5SKBudKEffm1nO+KP+YepYHEL1puhFz1DurS56TCk57renQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7098
X-Mailman-Approved-At: Fri, 28 Nov 2025 15:13:01 +0100
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

QWxpY2UgR3VvIOWwhuaSpOWbnumCruS7tuKAnFtFWFRdIFtQQVRDSF0gaW14OTogc2NtaTogc29j
OiBVU0IgaW5zdGFuY2UgbnVtYmVyIGNoYW5nZSBmb3Igc2lsaWNvbiByZXZpc2lvbiBCMOKAneOA
gg==
