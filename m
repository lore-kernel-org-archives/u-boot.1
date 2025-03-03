Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D7EC19F32
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 02:52:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EB1580F70;
	Mon,  3 Mar 2025 03:52:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="B67iyP+4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 866AF80F70; Mon,  3 Mar 2025 03:52:00 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10EB9807B1
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 03:51:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5DpQEWzgkJ9QcpEBAjVp97HfgSot/wZ7wj6NH6C9spJN3Qm2v3amZktoEKCw41sFhGbayKhN5sbb4wY+3n+77hHMz+snYHLfSDq36EFsOZlBxw4nNe4gJFDQB7JTufknwRv5XO+qFIo/Unh0h3NSAfGPpS8+Vgf+Mn/RgmBFLh3UurdTm+dMLQ13rlNFKtvFMZABpSSqKnwL+q59rG34MYCu3yBTffm5MsHa1yxtu2lIF/ykPKP+bBjiRUW7IXx+qZFOugl438DNEbnC6BjqL2+sxL1wrGp4sH3DATqE4Fafv2GCslQDR6emVNs37qWgt/J2yO3x1X/UA+JUp2TlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GdkDzumekUdWr4szRm4Nbkq2XhiU3y5dc6xxX2Kdv0=;
 b=nN5ikaBgcX7/wBejGXHAiZTJYSoy5tkk8YMKNM9LcoCA+UvZYkSNnDRVC4s3WSkSqUhpSI6SPHivz6DNpbtMASm3poSNDZiBzFnZ0w8vd9GDQBTpJJROi5XM7V66ewEGCQfgA00L//FRFMLxxcXqB034db8zjkybkfyp53yVpACDfNJhmt87AEC27EMuAIKCQQrjSSYVjmmD071qSjnQv6h8Y2fioGYhYdNucVNx4VreU9mzST69ttnwggn3shgDQ/oiyonLjrp/u6CU9YcZv5WvG931l9x/Sel9n1wbDW2Yp1TQ+QQXSZ4xKRvodj8Jy8klv+r/Kev+dZex6FWwHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GdkDzumekUdWr4szRm4Nbkq2XhiU3y5dc6xxX2Kdv0=;
 b=B67iyP+4VpvO9Oh8v6kEeLq3H2dEjKS7HVbAx57fbe1+Ws7ka7JCdsWvnWHtsI169oUXw4UGDP7I8JVo6SyAUk14oSkkhr5movxyCy+iDADudjg8f8upPXOe7slvr7cEcJw6gyRJqKu4n7evWUHUetU/R1e0q+RV3TnuOYrPfKnZiy2xsQhVNPVlHQEBCYk9voHgPNvxP7F3v7I5ug/SUE6eD3/nazGDsXyH5rSQGdRmxWkRoMQ+ymhRNQlJEXXahspYJHd6U4IklR4c8UQlXDi9pVDdKhW7ZJcacfntxI91zNWzUyUt8Mml82ju0Y++kEWZbDRk9FUc/fdBGekvKg==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB10670.eurprd04.prod.outlook.com (2603:10a6:10:58d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 02:51:53 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Mon, 3 Mar 2025
 02:51:53 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo
 <alice.guo@nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Viorel Suman
 <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjYgMDIvMjBdIGZpcm13YXJlOiBzY21pOiBzbXQ6?=
 =?utf-8?Q?_Interrupt_communication_enable?=
Thread-Topic: [PATCH v6 02/20] firmware: scmi: smt: Interrupt communication
 enable
Thread-Index: AQHbic8q/+1lMxMIlEagzT2KZQiGLLNdFbQAgAOkFJA=
Date: Mon, 3 Mar 2025 02:51:53 +0000
Message-ID: <PAXPR04MB964420C8F69517BDE8E406D6E2C92@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
 <20250228-imx95-v1-2-09594e93cc9b@oss.nxp.com>
 <9f02e9b3-a238-4a68-93f7-550bd63dceb2@denx.de>
In-Reply-To: <9f02e9b3-a238-4a68-93f7-550bd63dceb2@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|DU4PR04MB10670:EE_
x-ms-office365-filtering-correlation-id: 8159d573-1f48-413f-804b-08dd59fe5ace
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?aFJxR3FxQ2duRFhZSkFYM1VvemxNUE9KR25oTkRPTHh6WVpRUHJTVU15TGtG?=
 =?utf-8?B?OXNNRVl0UWNIQTM1L2IrdDY1SEpnVTd6QlQybGNDSDNacDJES0FrMytYZ2FG?=
 =?utf-8?B?TkZ1aVQwZ1dvRnRjVzJvQ2pLYnJyeGlHN2FoS3VlM2ZnUC9BdU5QU0Q1MTNx?=
 =?utf-8?B?bWRaMmZCei9xd2RoYzZISDZwamRReXpRTFlzWml2UFplVTNreWVhL3VvZFRR?=
 =?utf-8?B?ZHpxWGhGVkdKS1BWQTJNdzZnTCtJM3kzOGFRaWNNcTRGbi9NMXEzUDJ0VFJt?=
 =?utf-8?B?U1dZOStFRTlWdlovSXgybTRYVW1IMHlkemRaMElPM0RRM2JDNm5yNWYrSlJ5?=
 =?utf-8?B?Uy9uYlRoMVptZThmU1dzSmVhdjhWdVZZRnp6NldBRTMvWmJ5Z1NuU0FyRlhD?=
 =?utf-8?B?YkI2cXdLWG5WcEQwNDRSQlRmMGYxV2hSRWk1aWtLYXlZTmdENGg1RHZpZmJX?=
 =?utf-8?B?V29ZeHd3V1NjMm5kSWIyZGFySHMwZmdZVnlCSVFSdnFPSEpqaWdBcUhWNldM?=
 =?utf-8?B?cnl0dm1yMGtMaGxteGFucUZkbk5JRWkzSW9MY0U3TVJLNHBHcW1BQmF4T1Bw?=
 =?utf-8?B?YUFzYy9ndnVqRG1WcVp6eVRRSFcwYU44OFNxbGlTdm5BUmxUNW9KckEvQ1BO?=
 =?utf-8?B?QjBGc0lPYVRsS3JVemw4ektWMkF1MmJUbjVHQUw1U1JqbllRbktyejNkTzA1?=
 =?utf-8?B?Z0lrRjNnbkUveGcwQ3ZUUkxndHB4Si9KQitjdFFVTHJ2MGRBYVJGR1VrRDlW?=
 =?utf-8?B?d3hvYzlkWGxDVWhvY2NNdkhGMVlrUmZvZVpVSzhvTjhDNnZsSS9sVjlRaW4x?=
 =?utf-8?B?UlBtQk9SQkpIS3RpSCtBUEhCc3lWNlk3M0hnMjA5ejhjNEVKcXRrYUdQRUFG?=
 =?utf-8?B?NTRxcENEcnltRkdXbDl1Mm0vS1pMOCtzUWRlRERNenU4TFlpRFVxbXE1eGVC?=
 =?utf-8?B?eFRrd3krdUFSd2dlYWFNVXFPcndKZHBIcVcwNUNIb0h2N3VGOHAzMHE1T3Zv?=
 =?utf-8?B?RHdrb1pwV1VzZzUzeUd3dVE2V3AyNVE2Y2c3MmZtTGsvU2NCMkExT0lQUyth?=
 =?utf-8?B?NjEzSTgwNWdURW1YaGZEcThHN0ZCSjltZnZPeWFFOXR6MkpCOGMzNjc3MEJU?=
 =?utf-8?B?cGhRNkZDYlQ5dXBzdWl5elVha0tuM2xVeit2WE5EMjhKdHNMMU9aMGJlTjFW?=
 =?utf-8?B?N2ttOUhLMVlxRHRJYWtwUEtUeFBTZTlGQVdRVnA2RmxVZVNCVHRYVTJLQkZv?=
 =?utf-8?B?NGp2K1ZIUHNVWWZkWHVSMDFReGVvNW1mTmd6TkNITUJMTFowc2l5aUhqQk95?=
 =?utf-8?B?VVdWSlczMnFGOWxJZ01ibVRZRVFGSXY0cUlhUVdMdUw5R3NOa09raG9Vc1Z2?=
 =?utf-8?B?MDRSVXI3SmJzMGZLZXhRemwrVFlZVTMwMk55RmQ5NEhSUk9LV3o0QmtqMlRl?=
 =?utf-8?B?V1NqTEswZVN5NzB3QlVVMUVGRFJUN0dXblNvc3NZZFh6UEc4Q3VVQTVlcDFw?=
 =?utf-8?B?ZFIwNzljTzBxL3Rzd0owSTVmVnVJTC9RWDVOVXE3MWpYTkVkNG51Zks2REhC?=
 =?utf-8?B?NWNGMEtyUjFHYWxVMWNHVW1xQ2dJSUJEbE12UWh3NjBLTTVkTWgrRUp0THgw?=
 =?utf-8?B?L25FMXFrSmlhRWtIUkd0Tkhab3BOeC9VZnFCV3NuMnNmSi82SzNMSkZUa1JK?=
 =?utf-8?B?c1o5b01yRnJ0L1ZBQmV2c3pXUGwwbWY3dHBWNm4wdk1hVHVXbFNEVXozT1Vq?=
 =?utf-8?B?L2x2UGdMVXRhQ2NnTjFLdGhjYXZHVURFN0RkTzBPa2pBaWlYUVFRdDd4Ni83?=
 =?utf-8?B?bVVLUlhjRnlKVmRiZUdFOVR4OVo1K1JBeWN1YUZGK3JLR0YwQ1BuM1hoUmMw?=
 =?utf-8?B?a2pZbjR4WVljY2lUN3VpaWhqODI4QjFFdUZGWUYyaVNuRjRnT3o5SlNyK1Mr?=
 =?utf-8?Q?MY5Toaq1Cf7sy5M/derGJmUcZDXwnZe4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VytZdTg5MlRCZjNBQm9pODhjM2l3S081R3ZkM2pvcTRMQUpUcU5KZFQ3WXJV?=
 =?utf-8?B?WGdkdzI0aDZiNStMZDRDaWlLNnB4dy9mdUorZEJZTE5KK1l5cVFwWkNheE51?=
 =?utf-8?B?RDJoUDVtS0szTFBtaTc3TFM2TENEek8vb0dOcGY1REtIZjU1RzVwbWN2M0NG?=
 =?utf-8?B?NCtxMEFwb3JCQ2FQQ08yelV2WnpldmJFS0hoemM4N25TQXRQaEJkekhxK2sx?=
 =?utf-8?B?cHVpNXVRRk9IdzU1Tks3ZDc3aXZWVTV2UTc2TTlpSlpLdWp1ZUNsaW5BRm9P?=
 =?utf-8?B?L2RNN0hGQ2R2Q21tOXVSMmVrZktkYU1OZXBBMmZCVlYxQXVPQ3ErdDVpcVkv?=
 =?utf-8?B?dFFsVnRCUjk5b2RIZHZaWFJ2OVl3UURXSVF5UXlodk1MaEtmWjdjMjY5TUkv?=
 =?utf-8?B?N09BUEd5SmREUGRodVQ2enZXbldVMFFkK3VUN050ZUphenplTVdhcStWdU5l?=
 =?utf-8?B?MEhYcElJejhiWjM5NlVObnBHTkljdlh2OW14NUFuSTVlL1V0NFUxV29hQnFu?=
 =?utf-8?B?TmsyRTFQUEhVZHJCdkRpU3Q2cWtqL2ZpeFF4aWwvVDcwdjVBMjNHK2JidTE0?=
 =?utf-8?B?Nm9laEdsNlJJc1lSMWxZY2Z4WVhCblg2OTRzajh2QUxEYm5JRGNtSEJDWENU?=
 =?utf-8?B?eG5YMkFhN2hiUVBwUS8rTjA4bVl6dWwrbHpEWGNyVWlpTU55WFl5R3dqTldw?=
 =?utf-8?B?cDJXSTZCY3REK2RqVWRTcitRV0RYa0M4ODJ2TElOY25hUyt5YjdBbXlzMnc2?=
 =?utf-8?B?bm1WZ1hRK25ZTFpXWlgxWi9BcVVFTXlOYnM2YlUzbk4wbCs0d2I4aWVhcUJv?=
 =?utf-8?B?aGFKQmhJY20vbzErdmw0SnBpSUhvRlVkQTdkQjJPUytwcGpvYXNkM1M5LzRZ?=
 =?utf-8?B?S0RqSUZ5dk9DRWNrN2lRZkYzQWp0TWx5TUtPM2FBSms4VVV5YUJFaTVyL3JG?=
 =?utf-8?B?blFlLzduTWFpUUZzdzgxZVordklMd3lTaVdZM09Za1ExS09BM0JBeDhuZXdw?=
 =?utf-8?B?TEZoU0tRK0psTnNGNFVodmV3WEJQL1ZKandhb3gyMUNHMmNTZmtvVlYwdnNp?=
 =?utf-8?B?SUJDNVVnT0h4WGNwdTFIMmkvaS9URlVMbDkvVkIvNXRYWGlpMTFnSG1WbGJy?=
 =?utf-8?B?L0lMM3BmNnhyNmxaNFE5dy8wRitEYVhqUFA0L2xUd0N3b3R5MkgrYnZIblNR?=
 =?utf-8?B?N3FrQWN2b0pYYzJDRVJNRDVhMjZ4NXJnbTUrcVZxZE0weTJxbWJQa1ZRNmhr?=
 =?utf-8?B?VHNYWDZwNldEbHh2RFF6aXhxcXRORjJFV2JOdCtqUFQ3K21RRlhzZ0lmRStw?=
 =?utf-8?B?KzV2UlhneHhpb29SV2hqS3ZONXd0Ri9YclViT2VkVTQ1ZEtyTFQra0RWcUNZ?=
 =?utf-8?B?Y3BHTDZlVHVSTXJ5dkZQblFYOEIxVm1xN2NqKzdhekFFRWZCSXVmSkNSeldi?=
 =?utf-8?B?YUo3K1g3dnduQ2U1KzI2RnJzWWxsaEN0TlkwZXVxNTkwemlwSzdIZ3JqYlVH?=
 =?utf-8?B?R290eDBXdWl1L1VrdnM3NXNFbVl4QlNVZERWTXlhWmNmTnI2U3BsaHpCdjRQ?=
 =?utf-8?B?RzlGS0xKaHpwSWJZNERnRUxDTWtucFgyR2JpQlpXcE9ldVBuSnQzTXFvL2h2?=
 =?utf-8?B?d0hiOTAxc3pwQ2RJTXpoRTZ2djFiZHZVZG1ZbUZITTF0RWRHVzA5T0JRbzBF?=
 =?utf-8?B?UUdqN081ekR1OHN2REZGOS95M3VNM2VTRXpkUjBxQlZiNDRNV1hHMklMYTM0?=
 =?utf-8?B?VjAxTnRxWUxuMEU0OGMwNENOZFFLQmNuWTVxVEZham9jZSsyN0s3ZkxCWlVQ?=
 =?utf-8?B?cVFkOGVMNWk4Q1pqWDkveWtvRm9tTTlDK1dBK3Nrdmc2RDNmOWMwYWg3bXp1?=
 =?utf-8?B?VWFlbC82by9GdTNFNzcxM2JmWnZQTDdGSVRuWm5kZGcxM1JMdDljRTB5ZDlj?=
 =?utf-8?B?cG1HZzhIMWlVTmFReVpKL20xV3NWRm5CY3RXbkxpdFI0d1NsMFg2MTZ1YmZV?=
 =?utf-8?B?SlRPeU5yU1c4QjBBT2tuMTVqeGZtallUOHNTdHBsTXBzOC9EUThGUlpGcnU5?=
 =?utf-8?B?VWFZQnVHWkZpTVFXT1hwUU5Vd1ZBVXdBeVlTSWlvQm81WXViUUtrRjAwSXBw?=
 =?utf-8?Q?xPX8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8159d573-1f48-413f-804b-08dd59fe5ace
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 02:51:53.6498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YcYj5GbST6V3z4rviyy0rUPTddAGCam7XylgtmOj+IjzWZgG2yBmf9+1iKQwYgf0vAvhwCLhx6zvwAJBEImT+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10670
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQgPG1hcmV4
QGRlbnguZGU+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDPmnIgx5pelIDM6MTINCj4g5pS25Lu2
5Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT47IFRvbSBSaW5pDQo+
IDx0cmluaUBrb25zdWxrby5jb20+OyBTdGVmYW5vIEJhYmljIDxzYmFiaWNAZGVueC5kZT47IEZh
YmlvIEVzdGV2YW0NCj4gPGZlc3RldmFtQGdtYWlsLmNvbT47IGRsLXVib290LWlteCA8dWJvb3Qt
aW14QG54cC5jb20+OyBMdWthc3oNCj4gTWFqZXdza2kgPGx1a21hQGRlbnguZGU+OyBTZWFuIEFu
ZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT47IFNpbW9uDQo+IEdsYXNzIDxzamdAY2hyb21pdW0u
b3JnPjsgQWxwZXIgTmViaSBZYXNhayA8YWxwZXJuZWJpeWFzYWtAZ21haWwuY29tPjsNCj4gQWxp
Y2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4g5oqE6YCBOiB1LWJvb3RAbGlzdHMuZGVueC5k
ZTsgVmlvcmVsIFN1bWFuIDx2aW9yZWwuc3VtYW5AbnhwLmNvbT47IFllIExpDQo+IDx5ZS5saUBu
eHAuY29tPg0KPiDkuLvpopg6IFJlOiBbUEFUQ0ggdjYgMDIvMjBdIGZpcm13YXJlOiBzY21pOiBz
bXQ6IEludGVycnVwdCBjb21tdW5pY2F0aW9uDQo+IGVuYWJsZQ0KPiANCj4gT24gMi8yOC8yNSAx
MTo1MyBBTSwgQWxpY2UgR3VvIChPU1MpIHdyb3RlOg0KPiA+IEZyb206IFZpb3JlbCBTdW1hbiA8
dmlvcmVsLnN1bWFuQG54cC5jb20+DQo+ID4NCj4gPiBpLk1YOTUgU3lzdGVtIE1hbmFnZXIgdXNl
cyBpbnRlcnJ1cHQgZHJpdmVuIGNvbW11bmljYXRpb24gd2hpY2gNCj4gPiByZXF1aXJlcyB0aGUg
Y2FsbGVyIHRvIHNldCBCaXRbMF0gb2YgY2hhbm5lbCBmbGFncyB0byAxLiBXaGVuDQo+ID4gdHJh
bnNtaXNzaW9uIGNvbXBsZXRlcyBhbmQgdGhlIHByZXZpb3VzIGdlbmVyYWwgcHVycG9zZSBpbnRl
cnJ1cHQgaGFzDQo+ID4gYmVlbiBwcm9jZXNzZWQgYnkgdGhlIG90aGVyIGNvcmUsIGkuTVg5NSBT
eXN0ZW0gTWFuYWdlciB3aWxsIHNldA0KPiA+IEdlbmVyYWwgUHVycG9zZSBJbnRlcnJ1cHQgQ29u
dHJvbCBSZWdpc3RlciAoR0NSKS4gVS1Cb290IHBvbGxzDQo+ID4gR2VuZXJhbC1wdXJwb3NlIFN0
YXR1cw0KPiA+IChHU1IpIHRvIGNoZWNrIGlmIHRoZSBvcGVyYXRpb24gaXMgZmluaXNoZWQuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBWaW9yZWwgU3VtYW4gPHZpb3JlbC5zdW1hbkBueHAuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+ID4g
UmV2aWV3ZWQtYnk6IFllIExpIDx5ZS5saUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVy
cy9maXJtd2FyZS9zY21pL0tjb25maWcgfCAgNiArKysrKysNCj4gPiAgIGRyaXZlcnMvZmlybXdh
cmUvc2NtaS9zbXQuYyAgIHwgMTMgKysrKysrKysrKysrKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2Vk
LCAxOSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2Fy
ZS9zY21pL0tjb25maWcNCj4gPiBiL2RyaXZlcnMvZmlybXdhcmUvc2NtaS9LY29uZmlnIGluZGV4
IDhjZjg1ZjBkN2EuLmViNjJiODg2MTUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9maXJtd2Fy
ZS9zY21pL0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL3NjbWkvS2NvbmZpZw0K
PiA+IEBAIC00MSwzICs0MSw5IEBAIGNvbmZpZyBTQ01JX0FHRU5UX09QVEVFDQo+ID4gICAJaGVs
cA0KPiA+ICAgCSAgRW5hYmxlIHRoZSBTQ01JIGNvbW11bmljYXRpb24gY2hhbm5lbCBiYXNlZCBv
biBPUC1URUUNCj4gdHJhbnNwb3J0DQo+ID4gICAJICBmb3IgY29tcGF0aWJsZSAibGluYXJvLHNj
bWktb3B0ZWUiLg0KPiA+ICsNCj4gPiArY29uZmlnIFNDTUlfVFJBTlNQT1JUX1NNVF9JTlRSDQo+
ID4gKwlib29sDQo+ID4gKwlkZXBlbmRzIG9uIFNDTUlfRklSTVdBUkUNCj4gPiArCWhlbHANCj4g
PiArCSAgRW5hYmxlIGludGVycnVwdCBjb21tdW5pY2F0aW9uIG9mIHNoYXJlZCBtZW1vcnkgYmFz
ZWQgdHJhbnNwb3J0Lg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL3NjbWkvc210
LmMgYi9kcml2ZXJzL2Zpcm13YXJlL3NjbWkvc210LmMNCj4gPiBpbmRleCA2N2QyZjQ1MDAyLi5h
MDQ4OWY5NzE4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUvc2NtaS9zbXQuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvZmlybXdhcmUvc2NtaS9zbXQuYw0KPiA+IEBAIC0yMCw2ICsyMCwx
NiBAQA0KPiA+DQo+ID4gICAjaW5jbHVkZSAic210LmgiDQo+ID4NCj4gPiArc3RhdGljIHZvaWQg
c2NtaV9zbXRfZW5hYmxlX2ludHIoc3RydWN0IHNjbWlfc210ICpzbXQsIGJvb2wgZW5hYmxlKSB7
DQo+ID4gKwlzdHJ1Y3Qgc2NtaV9zbXRfaGVhZGVyICpoZHIgPSAodm9pZCAqKXNtdC0+YnVmOw0K
PiA+ICsNCj4gPiArCWlmIChlbmFibGUpDQo+ID4gKwkJaGRyLT5mbGFncyB8PSBTQ01JX1NITUVN
X0ZMQUdfSU5UUl9FTkFCTEVEOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCWhkci0+ZmxhZ3MgJj0gflND
TUlfU0hNRU1fRkxBR19JTlRSX0VOQUJMRUQ7IH0NCj4gPiArDQo+ID4gICAvKioNCj4gPiAgICAq
IEdldCBzaGFyZWQgbWVtb3J5IGNvbmZpZ3VyYXRpb24gZGVmaW5lZCBieSB0aGUgcmVmZXJyZWQg
RFQgcGhhbmRsZQ0KPiA+ICAgICogUmV0dXJuIHdpdGggYSBlcnJubyBjb21wbGlhbnQgdmFsdWUu
DQo+ID4gQEAgLTQ4LDYgKzU4LDkgQEAgaW50IHNjbWlfZHRfZ2V0X3NtdF9idWZmZXIoc3RydWN0
IHVkZXZpY2UgKmRldiwgc3RydWN0DQo+IHNjbWlfc210ICpzbXQpDQo+ID4gICAJaWYgKCFzbXQt
PmJ1ZikNCj4gPiAgIAkJcmV0dXJuIC1FTk9NRU07DQo+ID4NCj4gPiArCWlmIChJU19FTkFCTEVE
KENPTkZJR19TQ01JX1RSQU5TUE9SVF9TTVRfSU5UUikpDQo+ID4gKwkJc2NtaV9zbXRfZW5hYmxl
X2ludHIoc210LCB0cnVlKTsNCj4gV291bGQgaXQgYmUgcG9zc2libGUgdG8gY2hlY2sgRFQgL2Zp
cm13YXJlL3NjbWkgbm9kZSBmb3IgY29tcGF0aWJsZSA9PQ0KPiAiYXJtLHNjbWkiIGFuZCBwcmVz
ZW5jZSBvZiAibWJveGVzIiBwcm9wZXJ0eSAsIGFuZCBiYXNlZCBvbiB0aGF0ICwgZGV0ZXJtaW5l
DQo+IHRoYXQgdGhpcyBpcyBtYWlsYm94IGJhc2VkIFNDTUkgPw0KDQpIaSBNYXJlaywNCg0KRG8g
eW91IG1lYW4gdGhhdCByZXBsYWNlIElTX0VOQUJMRUQoQ09ORklHX1NDTUlfVFJBTlNQT1JUX1NN
VF9JTlRSKSBieSBjaGVja2luZyAiYXJtLHNjbWkiIGFuZCAibWJveGVzIiBpbiBkZXZpY2UgdHJl
ZT8NCg0KQmVzdCBSZWdhcmRzLA0KQWxpY2UgR3VvDQo=
