Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90F0D116EA
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 09:08:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE6AF842CD;
	Fri, 28 Nov 2025 10:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UEGA5Xww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93CD48432D; Fri, 28 Nov 2025 10:08:46 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3937183B86
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 10:08:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0dvRrvvaTyQVAWZSwPPLdx2pO2UUznYQHSduAljUn1j4feAdZ1HxTiqSZbrPZEmdY7D3AwMmENFRWvDEioXFIzuKkUH0+jLJCRX6HSaeVwdPNOi3cNFtYWgvN6+FaDy3ZiHuzva3VBtcSlsDWpyIpTQMwJXUauOSnnEfbWXuZmqhgYpnnOoti/JWbYmkypicuVfjFjfIjHqITWdIAWuki0qSXRY9gFVsjYusbVpCCDivHGGpuihuXbb0p5mT2nlE/FHavIFZx0n21wNaMCvSFZ/WBtg4ZBflJmScDNFHBmmJNM9lLop1Gb9TolmpAgLQ8Gn7Li+N1avu2Fgyspl/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZs8xxxnco7NnsJSpJ9mCOr6V6PjuiA1oEaDPZLmfRw=;
 b=MhF3KID4FwBOXjBFp2sVDg1nzB9eqOoqJGhZ00V1wzTDy7lbDdjlbd+Y2j124gzVXp/9fVPj70w7cD3kSjDU8WRdbGPzJ9CJELs5gTBxRBj7QgZzLGRk5hKcBbNQUU6mVHuQrQtxO7Sbe6OJQYOGG1CHMzpGhVDxI8c2ULAUpWs/SsOvW59Hf2xmy+bbk6fWwEk5eKVuqo+Mflgm3HGsUv2LHgq44KQAm1rlXwxH/6c5XhEvvYLFk/zydsXd+Q+tb9QbRRfq6fZkfjXB1x6046jfKTGXAlSVUmJEEHrNfExyEWt+/mX8pDlQuJbspDahb3RZ6O+maS8qe4XO0dh91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZs8xxxnco7NnsJSpJ9mCOr6V6PjuiA1oEaDPZLmfRw=;
 b=UEGA5XwwZ9yLhnUoWqxyKkTNk/gEMPRGbrB0g9u24Nne9kD+MQxUrM7zYu1FQqYHUlvOxFH5A46HwID9xj9/Kg8Ie87XeNh117X7gi+UbRLadzL618M2anKeGkpusmB6tGNEmniJMlGYt3PHyRLCozOZdspF8YVFlYz93ZUNkX8H9fhbQHSOb6Nc+XHnfpo/o25c2NTJyTeJ40My0dQLAIa6TYCOyMKiEmnv3hJagLiOCrF15Nx71a9XjcV0mcB9abaTrlxlQeBi4qqxz+5SxSAibZaJjseTtLaj0DNVRt+Pl96XZ4yPSCQbXI1sWhj2qNn4yl6cx8saR2S1xqXPDw==
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by VI1PR04MB9737.eurprd04.prod.outlook.com (2603:10a6:800:1dc::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Fri, 28 Nov
 2025 09:08:41 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3%6]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 09:08:40 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, dl-uboot-imx <uboot-imx@nxp.com>,
 "sbabic@nabladev.com" <sbabic@nabladev.com>, "festevam@gmail.com"
 <festevam@gmail.com>, "trini@konsulko.com" <trini@konsulko.com>
CC: Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, Ji Luo
 <ji.luo@nxp.com>, Alice Guo <alice.guo@nxp.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHYxXSBpbXg5NV9ldms6IEluaXRpYWxpemUgdGhlIEVM?=
 =?gb2312?Q?E_RNG_context?=
Thread-Topic: [PATCH v1] imx95_evk: Initialize the ELE RNG context
Thread-Index: AQHcVHatrOw7DIavo0yONWMxnixY37UH5DsQ
Date: Fri, 28 Nov 2025 09:08:39 +0000
Message-ID: <DU0PR04MB96367EBECA5951D3B9B7925BE2DCA@DU0PR04MB9636.eurprd04.prod.outlook.com>
References: <20251113082145.898431-1-alice.guo@oss.nxp.com>
In-Reply-To: <20251113082145.898431-1-alice.guo@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9636:EE_|VI1PR04MB9737:EE_
x-ms-office365-filtering-correlation-id: 3df98283-3e40-4ac0-cd11-08de2e5db8c2
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?gb2312?B?dzFCSitYSi9kdFJYTnoxc1BlY0U4YTdleVlaU0w4eVozaGhDcFI5VGNsUEl6?=
 =?gb2312?B?dHl6OXpvZmR6OEdXNWNHZEh0bW95VTdTU1BRTVhHTWZMbjVaVkZGcXJJZXNj?=
 =?gb2312?B?eWM2UXRvRHlaQXloY1IwRDJBOGRHcFlYWlE2YmNPZ0pyMXNhbk1DS3ViTy81?=
 =?gb2312?B?QWpIaVpLVis4NEhKR1VWSVBxQzdUU3Z0R2ZUcWJDc3JrZjF0dlpBcG5rZ0I5?=
 =?gb2312?B?L3kvTUxLVmNoT2NJcHNSTzVKR1IwQjRlNHo5RGdhUkNOV2JNNC9LV2g2cVRl?=
 =?gb2312?B?Z2pHbC9zZ3hrMzM1VEwxUXpmV1lwS29lOXNGSXcxVmMyWklrQnlZTnhINXpv?=
 =?gb2312?B?MHdkSVI0bnZOK3ZTY0RnQm1jWFhPaS8yamxzRi9RdjZVcHgyUmN0Um14UWVw?=
 =?gb2312?B?OVpYSnIzcHpveHY5WS9ucjhEdllzckt5OENKMUhLbmJ6SWFqaDlreXpMeXZ6?=
 =?gb2312?B?emtwUmxra1pVbDRLN1AyRUdHbGc0MzEvdnk2Tm5kR1RGSndiUFROSm4rY2ps?=
 =?gb2312?B?S29LTU9aYmtlZjlJQ3p3azB5cCtHVnRBN0pEaXFBRFdtT2wzQzBuOUcyUTND?=
 =?gb2312?B?akJ1V3FmTEpra2pzMEZDVGNyUWE4R25xOEQvdm5hUUppeXpCcTM5TVlyTXN4?=
 =?gb2312?B?RUJXZ3BkL1M5c1RBTTBvY2JpaUl4SURVS0lCaUFscGRCZXAwanVzOWh0Z0h5?=
 =?gb2312?B?NU4xR080TUs3OUMrWEUyZVBucElsR0RsRG1SNVpzaEMxU2ZoZjFVOU92RXJi?=
 =?gb2312?B?aU41S3QvUnFIODk5aTNxQ2VtN1U2NlpwVjdLRDc2VVhvcTVkSndjYjRlMGVt?=
 =?gb2312?B?WVFLejdhdzBQS2NYU0k0ckE5cUtFaWhDSS8rb2d0VXRyQjN3U0tNazBFRHNN?=
 =?gb2312?B?aXJRRVRkaldwMHNvaDd6RlJJZHVkYnpZTVhJdXhvaTJvVmE0OXo0MzZqcFVX?=
 =?gb2312?B?ZEwxcnZQTUxKK0FIeWpUYVdnQ2hVODh1Q2VZV0Frd0xKLzF6SUlUVS9LTC9w?=
 =?gb2312?B?UXVzdVRPM2dFNjhxci8wTTI4ZnE3OE1SdWhJU1BWWGxzYTBUU2ZUTzk1NlJa?=
 =?gb2312?B?Q09qa1Y2UzlBSVF2ZVFEaExoUGZJUng0VHdHTmVlR1ZXczJIWWFqY01iV29t?=
 =?gb2312?B?QVRWU1pXVmlsZXU3YjkyNHpiNkUxMWVXcndJa0x5N2UzTzg1UzBqd0V2aWJN?=
 =?gb2312?B?a0d1eExvS1liLzlNdzZuRitGM1EyV3UySWRaV0RCblFLb01yTEk3YXk2L3pN?=
 =?gb2312?B?SVgzSVRFTmdETzlidWpMcmZRdzN3aWRxdm1OYndjLzFHTHBkeGNXandtRHBC?=
 =?gb2312?B?Y3ZUNnNsQ2hZQWJTb3c4a0l6MWlKUkNXL2N1anhESk8vMzdjaEVOS2dvVnZV?=
 =?gb2312?B?WXhydUVyWFJzT0pzRythbUl6V3lqaDJ5R3FneUhwVTVvRWtMTjVnNkRnRTZE?=
 =?gb2312?B?dE56TXpSZlJDOWFxbVk4M1JOSzQzeUQxdXNwdzN5dzJmRDZxUlpRY1lJWnNi?=
 =?gb2312?B?dU1Sc2puRmgyeGlXenpwWFREa01sblJQVkVuSlNlSE5pTENuMWtyNGcrNll1?=
 =?gb2312?B?b3hBUUg4Yi9PQlh4UWZtUitYUE45OWZOem14OGpJdGtvTElmZVlPTUt3S0J2?=
 =?gb2312?B?YStwanBXZG9VMEIrMEtRYVhVMHB5Nzhjb25LL1RwTHMxTmhhVXRvT0hjTkhw?=
 =?gb2312?B?dDJqM3VxVFdTREl6a1BCcnczQmk5YVM3ZHhpRG9VWERjK3Y0Z1M5QStVL3dF?=
 =?gb2312?B?WDNTSUdBUU1WNDhVUHBnQWxIUlY5RFhYNG1ENVNTd2pyQk9keUI4MDBZaURi?=
 =?gb2312?B?TUJYQmFmYVBKNjZYWVdGZmFpK0dWZXZwanlmUTdQWUx5aXE1U0pFQ1AvMFhL?=
 =?gb2312?B?U2VyeFhsV0ZVcUFOV0VQZGQ2THlBTll5RkFOMDhPTG54dlhUZk1BcFZyL08y?=
 =?gb2312?B?Y2pHcWludHdLcXpCR3hDcU8wcW05NlVLb3hJNHRBS0J3dkwya0FhakQ3Nk1Y?=
 =?gb2312?B?TzRLWVZrNzhzcWhDOWlGdEJOcXBFdXlRS1A4Y3NIRUZBL1VETjA1cnFIdjZD?=
 =?gb2312?Q?cBBBSC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:DU0PR04MB9636.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MnZXbDZsV1JleTZoVFA4VGpLb2NHVmRONVorQTJXNms4bVpmWGN2SHRrRi9U?=
 =?gb2312?B?ZGtTZGNuaTcwbVRSZTRSR09DNUZoc1NLNkdoUTZJRzE4WTZPTExSZmwyMzBO?=
 =?gb2312?B?VS82TmVRd1NvQVc1aVZKdy94aTN6T0RKcHZYV2M3Rm1LZU13OG0zdXVGbnFW?=
 =?gb2312?B?SnJOK1B6SitqN0ZLa2lnUy90azB4VWRDTGcwSi92UHdGcnE1czE2djM4VWtr?=
 =?gb2312?B?TUJQYi85RXVYempNR1BpMCtGVFdoZkdLU3hqcHJveVMwYWVJRG1EZWRENm5U?=
 =?gb2312?B?YXNHSUVmRDU4ajJleHVlOEJURFpCS25uNXBRZ05zOFZZR1VBZ3A4ZmJCdXVE?=
 =?gb2312?B?UHJkVUZJYk5iSTZxd1pIRG9YZFVFTXlpTkExVVJ5Zi9NUjFmVUFpbFlCUkdt?=
 =?gb2312?B?WmgvODV1M0Q2eGxZcis3dG8rdU9WdmwrdzdCYnhQNUpkY21weWlaTDY3RnhB?=
 =?gb2312?B?VS9YN0NsaDFPR3BsNjRaenV4NXh1V0pXT2YrTDAwVzBhbi9wM3VueWVPSkl6?=
 =?gb2312?B?aHJZQm9LZEFsZjlnR2I3bW9pZm5iWnBWVVRzS0VaYUwzVFJpUmovL0dYVWJE?=
 =?gb2312?B?S2NWQU9FNXhoNnlhRXNLRDN2RmR6d1FLdDdkVkdTZVlOdDZUOFVxaGNZRkdG?=
 =?gb2312?B?cjFZeWtYZm5tazhIU0tXdE5UVVJEWTR5ek1IcnVVT1lkaGsyTVFpU0taWGNG?=
 =?gb2312?B?WjFQaUhiWlp2YkQ1a2dBdUdpWmZ2QVRsM1NOdHB5UVpHK1BMcllqNDFZblZx?=
 =?gb2312?B?OW1sakZVN0JNV3paQWdQRHk3ZlJUT3hmcFdNeUpHbTI5MDMvYWRYUjh0SmZX?=
 =?gb2312?B?bEc4UmVYQ2xNOURvS2pCbElhNFV6WUYydDJxN2VvVXlVeUV4L0JwNUoxdC8w?=
 =?gb2312?B?TngrSFpYNmtsaG1VK21oVmZ5d1hGT2FYK3cycUUxbHhXZXBobHBnNWdnbWFu?=
 =?gb2312?B?TTRDeTJXT1FOS25JZkhsak5KTEQ4d0s3UldYVXYySFFWUTk1ZkFHYzUwUGNh?=
 =?gb2312?B?NnpTTEt3Z1FaVS8vSWFYT1ExRlVqSDk3NFBwbjRaS003WVd2Y0diVE5BazRm?=
 =?gb2312?B?UWo4K1lmNmtLMk81TnNINkRxNTYxa0dOOW1mSFc3d09FYzFzOFdqMHdyVVY3?=
 =?gb2312?B?dEZQRjBVa1RiamRVL3NlTDA1VmswbVhhWGhkdVJPcUJGc0F4dUNQNnlvRFc2?=
 =?gb2312?B?TlFxTnAzL21EVm9JMHBtekNiVXRkTXRVekxFbUh3VU1OU3ZKOU9oTDZJSk5J?=
 =?gb2312?B?cFZVL0Yzc01HcWdGcitsRHBVNHp5ekdBZG0xS09tV2toUDB4cmZjTS9SS1dm?=
 =?gb2312?B?N05CeGZMalVvcHViRkdNazdRK2p2cjFmTm1GYVJ0c0FWekN1Uml2WSsrSXFr?=
 =?gb2312?B?eDBXYktzd0dBeEpDQjdDdXJFeitLcEJOdWFWTlk3dldQTXpTRUp0RVVvcDVX?=
 =?gb2312?B?U0o0dm42VDFJME5GV2wzd3lURmVwK3hwcGpCZzJtd3lLUWdLSnExL2NERWtG?=
 =?gb2312?B?ektmbVlNektZSE5qeTVGWS9jYXl0bnlBMTkzY1JPVFYzUXo5bWE2NlN0RVd5?=
 =?gb2312?B?STZSQTF2UEVUM1FjM1pEdkp4RzZGNElIZWlpbVFPek1NQjR3ODk4Rzdob00y?=
 =?gb2312?B?emxhUmZ5NiswSllqeTA5VzBDQldXcEU1Y0c4dGtDR2ZaTUpHelZrczF1ZVlk?=
 =?gb2312?B?V1A0UWhob2tET1ppbGhmN1ZhQlowOU8vc1c4aUFZdUFxSjdrdWxCSUVWelV1?=
 =?gb2312?B?NE5iWHo3cFRjMmFkV0g4WlhMdStlQ1lrNFZqT3ZIZFdId1lkWkR0S3JvS2Zt?=
 =?gb2312?B?UklyU0ZQVnEvSjd2aHBCMnJ1c3NBclRGYjkvSlJtOVJYOXFXTVFzLzNlVE5o?=
 =?gb2312?B?eGMxTTdVRzBDWmdVS2R3eVhZNStmOWFXSnNVNW1tRFVsbDA2bzk2djdKTlox?=
 =?gb2312?B?dFpnODF5NTluajBDa3J6dHdsdDEyN2dYTFVOa2M3enZnSGhQcjN3OXVQRzRU?=
 =?gb2312?B?TENmSEswV0ZvNlByS1B4ZmQrRnpheW9aU01PNzdVTW8rQ2VDam1Kei82VlMv?=
 =?gb2312?B?d3dhWk9rSnRXOFQ0YmZZNzNCWlczQzdwcGtlcGpJandFSU1rZjV6MmNUNTQ4?=
 =?gb2312?Q?DNLw=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df98283-3e40-4ac0-cd11-08de2e5db8c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 09:08:39.9383 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGrQUPJrf1RSK7cSPtoy69Fw8bWk+QKp010ABmorb3+fXV+RY67Z857ALZKZNHj6bNDuEwkFcWd5u8l6b5XFjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9737
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

PiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8/sjLOiBVLUJvb3QgPHUtYm9vdC1ib3VuY2VzQGxp
c3RzLmRlbnguZGU+ILT6se0NCj4gYWxpY2UuZ3VvQG9zcy5ueHAuY29tDQo+ILeiy83KsbzkOiAy
MDI1xOoxMdTCMTPI1SAxNjoyMg0KPiDK1bz+yMs6IHUtYm9vdEBsaXN0cy5kZW54LmRlOyBkbC11
Ym9vdC1pbXggPHVib290LWlteEBueHAuY29tPjsNCj4gc2JhYmljQG5hYmxhZGV2LmNvbTsgZmVz
dGV2YW1AZ21haWwuY29tOyB0cmluaUBrb25zdWxrby5jb20NCj4gs63LzTogWWUgTGkgPHllLmxp
QG54cC5jb20+OyBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IEppIEx1bw0KPiA8amkubHVv
QG54cC5jb20+OyBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiDW98ziOiBbUEFUQ0gg
djFdIGlteDk1X2V2azogSW5pdGlhbGl6ZSB0aGUgRUxFIFJORyBjb250ZXh0DQo+IA0KPiBGcm9t
OiBKaSBMdW8gPGppLmx1b0BueHAuY29tPg0KPiANCj4gT1AtVEVFIHJlcXVpcmVzIGEgdHJ1c3Rl
ZCBSTkcuIFRoaXMgaXMgcHJvdmlkZWQgYnkgRUxFIG9uIGkuTVg5NS4gU3RhcnQgdGhlDQo+IGlu
aXRpYWxpemF0aW9uIG9mIHRoZSBFTEUgUk5HIGNvbnRleHQgYmVmb3JlIE9QLVRFRSBzdGFydHVw
IHRvIGFsbG93IE9QLVRFRSB0bw0KPiBkZXJpdmUgUk5HIGxhdGVyLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogSmkgTHVvIDxqaS5sdW9AbnhwLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQWxpY2UgR3Vv
IDxhbGljZS5ndW9AbnhwLmNvbT4NCj4gLS0tDQo+ICBib2FyZC9mcmVlc2NhbGUvaW14OTVfZXZr
L3NwbC5jIHwgNyArKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvYm9hcmQvZnJlZXNjYWxlL2lteDk1X2V2ay9zcGwuYyBiL2JvYXJk
L2ZyZWVzY2FsZS9pbXg5NV9ldmsvc3BsLmMNCj4gaW5kZXggM2Q2NDA5N2I0YzcuLjQ4YjQ3ZDJh
ZWQ5IDEwMDY0NA0KPiAtLS0gYS9ib2FyZC9mcmVlc2NhbGUvaW14OTVfZXZrL3NwbC5jDQo+ICsr
KyBiL2JvYXJkL2ZyZWVzY2FsZS9pbXg5NV9ldmsvc3BsLmMNCj4gQEAgLTcsNiArNyw3IEBADQo+
ICAjaW5jbHVkZSA8YXNtL2FyY2gvbXUuaD4NCj4gICNpbmNsdWRlIDxhc20vYXJjaC9zeXNfcHJv
dG8uaD4NCj4gICNpbmNsdWRlIDxhc20vbWFjaC1pbXgvYm9vdF9tb2RlLmg+DQo+ICsjaW5jbHVk
ZSA8YXNtL21hY2gtaW14L2VsZV9hcGkuaD4NCj4gICNpbmNsdWRlIDxhc20vc2VjdGlvbnMuaD4N
Cj4gICNpbmNsdWRlIDxoYW5nLmg+DQo+ICAjaW5jbHVkZSA8aW5pdC5oPg0KPiBAQCAtMzIsNyAr
MzMsMTMgQEAgaW50IHNwbF9ib2FyZF9ib290X2RldmljZShlbnVtIGJvb3RfZGV2aWNlDQo+IGJv
b3RfZGV2X3NwbCkNCj4gDQo+ICB2b2lkIHNwbF9ib2FyZF9pbml0KHZvaWQpDQo+ICB7DQo+ICsJ
aW50IHJldDsNCj4gKw0KPiAgCXB1dHMoIk5vcm1hbCBCb290XG4iKTsNCj4gKw0KPiArCXJldCA9
IGVsZV9zdGFydF9ybmcoKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlwcmludGYoIkZhaWwgdG8gc3Rh
cnQgUk5HOiAlZFxuIiwgcmV0KTsNCj4gIH0NCj4gDQo+ICB2b2lkIGJvYXJkX2luaXRfZih1bG9u
ZyBkdW1teSkNCj4gLS0NCj4gMi40My4wDQoNCkdlbnRsZSBwaW5nOiBBbnkgY29tbWVudHMgb24g
dGhpcyBwYXRjaD8NCg0KQmVzdCByZWdhcmRzLA0KQWxpY2UgR3VvDQo=
