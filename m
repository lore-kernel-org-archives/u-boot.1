Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D88C19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 00:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AC2880F56;
	Thu, 27 Feb 2025 01:32:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="M57vF+Uo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DB0D810EB; Thu, 27 Feb 2025 01:32:03 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DDC0808A2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 01:32:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYptZybZBRe+8lTeNeiZImCRqeNZrHW3WkXW7+grMi6jl2EetZ41DvY5OmThbu96eeYGyu9C2OQ7j9SYe4nho3uptKTHNbAk5/w289G+S/voYgAHLVBaGnXuzuJVDbOr2VlhhdUgwnoLEwZ+jPmA5b5GqXnCQKAnlckf255U0P1r2Ea/b2EhWe0K3LjsUCoKnef+RrARJsOJQnK7isTcmXdsD+7KA6rZzTIxi3+VzqWQblp/QC7/rqUHPVkqfP5RxXLlJnp5vCA32glhNMZC/i5OfFDUZm087pA/Skc9cAUl4h3254Jw41mIlwfzces8RNpfypIobqV4Whb8dUHciA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4yH4aN0Z19ivzPIGXqP08a7gpssHmbZd57ugGK0w24=;
 b=R1E3n4yX6iFKwEuqHuYBIcy069xeVAcQdRJ6MJEA7K9Ja+XvZIHcdi+hklRpy+XZG0TYdWK8qJFbqpnOQ+zp1Vuc3LIw/omVSkyM/B5789A5lD5Tpkkmx9JbnWZKKXvzK0m5H5LWYDsclg89MSv0F5hiWmAQ4JQFkuWKya85Q2nB4tcMQ3GKuPkJW5KnVToFSJkJcsitoL07zYPtEyPhEuO6BljTWE6yeyh7Ria4APzBWrB2PH7hlLG3SW6NXveJH44znNmldgXSpK/GKVSwN4hUX3BJc1xHNwuuFxGehyvcKgUocqxwnW0vfT4VgsOax1dWLP2QMmDktGk6Pl45+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4yH4aN0Z19ivzPIGXqP08a7gpssHmbZd57ugGK0w24=;
 b=M57vF+UoeDZH9LjELARk185GD1X/5xyf3qZR9/aKSp+8QTQ9wgMdJt1FC4DmsKMrQIy6stVtnXdDoVabS9ZKAVMCvGlu3ko4odPuEQ1DwSzJSZx57297i6P2F3iatshvVsNS5GWvrMumqncVul3+L7n2hOAr7aFWVC1qjwntvgQzZ2eigHfsJhrRBQzaf27Rd0jJWx0XCcoN73c45O3P8QqLoLv/fZfuPinIwpCRUjTTBRED15anuKTD9meyMMdeQT5Voy1IxJTul+Wg8WJj2YhNr5pbmOKgJsfSTeQd4Aw8UluxKDvcXEbKnyx54D6wozYjGfKiwDEhjl0xbMBR8g==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8920.eurprd04.prod.outlook.com (2603:10a6:10:2e3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 27 Feb
 2025 00:32:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Thu, 27 Feb 2025
 00:31:59 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Andre Przywara <andre.przywara@arm.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
CC: Simon Glass <sjg@chromium.org>, =?utf-8?B?S3ViYSBTemN6b2RyennFhHNraQ==?=
 <kuba@szczodrzynski.pl>, Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy
 Zheng <icenowy@aosc.io>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>
Subject: RE: [PATCH 1/2] sunxi: mmc: Fix T113-s3 MMC clock divider
Thread-Topic: [PATCH 1/2] sunxi: mmc: Fix T113-s3 MMC clock divider
Thread-Index: AQHbiELPNTu8NZZ4TUitLdDXwJQu47NaTTCA
Date: Thu, 27 Feb 2025 00:31:59 +0000
Message-ID: <PAXPR04MB8459D3EB1E61A160A2C2D78188CD2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250226113712.1257061-1-andre.przywara@arm.com>
 <20250226113712.1257061-2-andre.przywara@arm.com>
In-Reply-To: <20250226113712.1257061-2-andre.przywara@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU2PR04MB8920:EE_
x-ms-office365-filtering-correlation-id: 8c773a98-cb4a-4bea-05f6-08dd56c62619
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aHdmbFFxd3lUTGlkcjZHOEJ5ZDJneEtFQXhlUHg2ZG1RMitJeUpXdEpBN01O?=
 =?utf-8?B?UEErUGNkWWZERWlTUTRTa0xPT2pJbitTZVZ0MVNsTy9MZk1XYW1lYldFM2Vn?=
 =?utf-8?B?eFJlUGZRUFlaUDFyb0FTUjlHMXcxWGZsQ1dITmtiZ0Z2MWppN2xZNVRDbDh6?=
 =?utf-8?B?U2t4WUd4TTZscHJjaE03dk5kRDgwa0ViL2swN1l4YWlCYTNQSjZaelpuS01H?=
 =?utf-8?B?b2FaM0xhOFl3azZ3S3I5TFNkODVveGhka1FOMFBCS3EzNG56SUVFRmZRbmlx?=
 =?utf-8?B?bS9qOHpKRS9iMWRqWk93MmVoWksrcitqWW1VeWZZWlJqcHd0VjhobnpHY05Q?=
 =?utf-8?B?K3J5VGVXdXdMNGlGcm9laUI3R0dvWDhzRTcvNkhoWTdLQ2hxd0NaQ2ROdjhy?=
 =?utf-8?B?NkMvaDdScnhiRFNVakt4ZmI0eWd5RjZzSDFNUnhkbXVaVUxOK0dzbElWb1JO?=
 =?utf-8?B?bzJtQWlQaXQ3YzlYQkEwYW1MdUYyalZ3N3ltTGp6Y2Y4UndEQ0NWVzZsdlRr?=
 =?utf-8?B?ai9GRjU4VENpVlE1Wm9xWHN5NlhHUTZOWkwrTXVKelg0Z3hMMHVIZ3RlaDFn?=
 =?utf-8?B?NS9EL3N5b2lJK3NGSjNSZStxVnZxa2tvUi82d0s3UjAwcGFiS2VHeHlWanlu?=
 =?utf-8?B?QmkzeFZkL0t3emJDUTB2RWhCaWJ3L1pCRnBhOFVMRkdydUlYdE5jdUxyWFhN?=
 =?utf-8?B?OXRVaXh5d25YazZyMUtTTWZNN3hac3NIdm95YlZablJ2OWpBdmtIYXNhY1pw?=
 =?utf-8?B?YVQ5cFM1Yy9KdDZVQjdSQ2IveWx6WVBLdDVUUWJKRmk5MnNveDNibWFqRWVi?=
 =?utf-8?B?Y3JHKzVES0xqbWF2OE82MVhlcDAyNXNqWlA5MmlURWg1UGNid1lVSHc3YlF0?=
 =?utf-8?B?WFpqT1I5aHZwYUdjSC9uUXJwbitCR05pWXl0WDAyaXI0TkM0U1RVN0FNQlBx?=
 =?utf-8?B?T21SSVZHUGhYUy9ERWN2dHdjdXdJL3BISnpldlJGTUFuV05kdUpLRUZFOTdn?=
 =?utf-8?B?TTluaVNCNUNHbjhnLzBieU9MeXlpcUZGbG8reFNXdmhlc1FTaE56ZEZnZnJl?=
 =?utf-8?B?UURhTGxId0xQL0JPc3FsS016RXNRZS9la1pERTB4UmZrQ3dQU2ZRRmdFdGdr?=
 =?utf-8?B?WnUxNEtkRkg0eUJTTmxvMWovbElHM2VwclBhazV5b0JmNEsvekNScHFoaERH?=
 =?utf-8?B?VnFENXYwMW16YmxIS01lWTVJajB5b0RsU1BnVEpHZ21WeEhTSzZLREpCaUdw?=
 =?utf-8?B?c1BNOUN6dzZGTnJpMVdxT0VmN3BsK0hzdWovQ0g5THUvRWw1aVhLbnpReVIx?=
 =?utf-8?B?ZjRLVGRQcFVwdWtVWnhNQnZyYnU5aGdwSXJJdE1aR2FCdE80VlArMjJQQVZy?=
 =?utf-8?B?SHY3SjU1c1V6NnlNQ0F2U1pHV3lDOEF6bS9yOCtPQjVjclVLZlkvQ0xkaENk?=
 =?utf-8?B?L2RNNjc0aW00K3pQSVZTTGtIODM3cU8vOFpKcjBxNWV2aGJCOHIxRGFxd3J4?=
 =?utf-8?B?czlvbzNTUFk4cWtHQXg4blF5STJKQmJSQXZwWGI4QzZQL0lYQjlPM0VOc28z?=
 =?utf-8?B?dXZsSEdqbnp3ajhSbjZmcExxdVA3SmFNelFZRkxNdnJtRmk4MDhaTTJaaDZG?=
 =?utf-8?B?UkwxLzR0UXRyUWJ3WlpiczZHbllUVXhzQTJaS2NUWmhRZUNITGpXWFNnT1cr?=
 =?utf-8?B?T3VQcGZvNFZDbEorOThSNGp1R0dSM1NoenVidG1KNE1MNEd1VGcrYnNpWEtz?=
 =?utf-8?B?OU05R3ByQ1luMEI3N1BVbXRrOVUrTFRpckxJUnVZZDNuYXE0NTY1YnNYNGt4?=
 =?utf-8?B?MDlmU0lmaWlTVWlPQjFxYUttc2VzM1JPNUlqck1EQkw2REVJV1JFSGk0bWZi?=
 =?utf-8?B?c0xVdFY3UWNyeWVPWERPSmNQeCticCtndmpTQjdIeERqU09RNVpZL055eEU3?=
 =?utf-8?Q?y8gLFty8RL3/BMJxDGtmbRCSgPqBbw35?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVg1dXhMVkhWOHFQaXNRVkp2V0NDQk8wb3hNSzl4TVJvcXc0OU1WOTg1bmh1?=
 =?utf-8?B?YkFKWDhFU0F6VFErcGhScDlDK1J4MS8rZDRRZm1EenBxN1FKTEY0QTh2SXJo?=
 =?utf-8?B?alRQR2NhTXovdzZEamNKS3BrOEtBYmdUb2tSK1RwMXFaMllMSnl0RWlCVGhu?=
 =?utf-8?B?OGlNbmhEWk5DMXdJVzlZbUpCZ0ZHVmV4S3dvTHRSOVcreVpkYXBqRHk5Tm1j?=
 =?utf-8?B?OFNuZWZrbm03TWdJU2k3bldUQTJmUThZSW55cG5HUTF6aU9jV1pDM3A5aS9y?=
 =?utf-8?B?ODNFaWlhNXU3bjJvbXJDTjk2aUZGdzAzeStkc3l5RVpEaXFla1haRXBib2lJ?=
 =?utf-8?B?eGduZ2FHSDJocmsxb2lPVG9xcDRXZEN5QXBlMVVheUNIYm8yREZjb1BkaDJl?=
 =?utf-8?B?TzltYjl6Wll5ZzhpZllaeXRCdUhLYzV2Q25lWG1EU05keXBTM2t1RHppVVhY?=
 =?utf-8?B?eG1RMWRzUXI3TllENkI5Q2JZczBSZ2dnOXN2OTBmcEk3QmI4Zm1tVktnVml4?=
 =?utf-8?B?SGk2RzkxdllwREZ5YStiUWlYZUd2bWlNeExsMkhnVEQva1JPSzJYbXVNTkRH?=
 =?utf-8?B?d0pCVHMwUmw4UVU0cGtyb3BJVkdkMVVxUEdVVnBCUEdwTm02ZVJ1VXFDMUxj?=
 =?utf-8?B?d2NmSmRqMFFxQllpSGl6amtFeTBWNjducUcxOWxacjBwR1ZPQ2dVdjQyUWc4?=
 =?utf-8?B?ZXZKNVNsOXkvQ3Yyc3FUay8rYzN2K1VyNldWbjBuUEVOTkNkU0xxVm96b0ho?=
 =?utf-8?B?UloyenRYY1hpbFVGSTZva1FNdU1oaWtJRlpja0lZYTJZdWxpNFBxVzgydFAr?=
 =?utf-8?B?NW1iMnJuSXg0U3MvUGh4cC81czFIeXhHblhrdVpldGZyZmVxNnV6QTFiQkIx?=
 =?utf-8?B?eHpRSXhYVXFnYXpwWm5vNFJOckRIMEgzeHJUb1ZkdkVYSXlkbFpKRWI3LzQz?=
 =?utf-8?B?cTVRQ3c3eWM1QWl4MGJId0VMblRvMzRYcWdGVkE0QWZ0dVVSeWNkY0Z1a2Zu?=
 =?utf-8?B?bkJ0QkNlL3E2M1ZWSVF2UTZHdndVZ2lvaUp2ckZTT2ZoWkFJajNLai8vOWNJ?=
 =?utf-8?B?WTBmbHVXT0h0MnJveFdsYm8zMXJzcXVuczE4VHB5YU80RjZvL2VtUzU0b3h1?=
 =?utf-8?B?WHp6V0p6WVBCSi95c1pybU94WTV4cjFzVUR1YkIyanFLZ2g3dUxhQUdiOEo5?=
 =?utf-8?B?MEtzMEUyZFVGK2JialZDSi9CV0JpL0U4K1VQNzdSQUJGZzNVTXlRbDFWSEFD?=
 =?utf-8?B?bi9SbU5ueDZWQXBuSTcvN1RqUzVlaGthOTlnOGNpMzAzTk1UK0RrN2Q3cjNR?=
 =?utf-8?B?QkxVU0dIMDM1cThjNUpyc3dXY0FaSlZkaDc0emlMOEVNcVQ3RklXQXdsa3E5?=
 =?utf-8?B?MmVWcWpnZFRsZmgvOUs4YmsrclJFSW9uU3lvaFhCRlA3L0pWNVFMYkd1eWtl?=
 =?utf-8?B?Yy84eTlSNTNFKzZKaFJ0Y2dnaTJHQXdrVnljUGpsenJhQmZGTVp6eHRHeG5v?=
 =?utf-8?B?TUt2d2hZc280T1Q2N1gxaDJaUHQ5SjZMbnZkd0VPMTlPMEVGVCtTamhzaDVt?=
 =?utf-8?B?ZWE5YVNtWVg1WDFIZGl1QnhWRUhLMGJHZURMQ2pFN2JpdEY4N3MvU3dtbnNz?=
 =?utf-8?B?RGJLY2xrdWgyUnpHUDg4TjhiWEtPbXJEbDVDUDhta0JuZG9FRndITnBCM2FY?=
 =?utf-8?B?VkJ0Tmw3ZFYvSFk3VnkrUWQ4QzczQmxLR2Q1b0xCc3NaVWFZY1hQMXRLTFNk?=
 =?utf-8?B?S2NTbkVScjN2QkdZMlFGN0R1RkIrYkZUaDFoWVpHenZPUE1LelJ0NEs5VVJX?=
 =?utf-8?B?TFB4Z1FZeXpwVG5ZL1NmM1ova3BGanYwdW5TU0dUb0RmQ29MM1BqTVBCbitn?=
 =?utf-8?B?MkRJbkxqSThFNUQ0ZzRxZGMyRmVES0Q0T2krRWl0eFNVZWQ4SEU0Z2lPamYw?=
 =?utf-8?B?YWdSZzVySmZUbllZVjhFZUxpbVc4aG85Um0wVHZnUitzWXBOZk96b3FNUkhy?=
 =?utf-8?B?YmdPNEJ4TytjTXFjVGhIQUJxYmhEVWJGZE43U0d0MXdwY0UrcVR1N0JId2dv?=
 =?utf-8?B?OE1qN0RBRkRYdUE1STZma0lTSUF6MVQyYUFhV0QrOVdHdGMrZVlPQ2x6Y0xq?=
 =?utf-8?Q?ZerI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c773a98-cb4a-4bea-05f6-08dd56c62619
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 00:31:59.8974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: etnTg4EN+ZPBNclCv+KFT/jPqpTUkQOFBhI4ryuFNv/DnmCvxw6gLKquxTFMQEmgBbubz2lg3oPCFiC3tGKcpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8920
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

SGkgQW5kcmUsDQoNCj4gU3ViamVjdDogW1BBVENIIDEvMl0gc3VueGk6IG1tYzogRml4IFQxMTMt
czMgTU1DIGNsb2NrIGRpdmlkZXINCj4gDQo+IE9uIHRoZSBBbGx3aW5uZXIgRDEvUjUyOC9UMTEz
LXMzIFNvQ3MgdGhlIE1NQyBjbG9jayBzb3VyY2UNCj4gc2VsZWN0ZWQgYnkgbXV4IHZhbHVlIDEg
aXMgUExMX1BFUklQSDAoMXgpLCBub3QgKDJ4KSwgYXMgaW4gdGhlIG90aGVyDQo+IFNvQ3MuDQo+
IEJ1dCB3ZSBoYXZlIHN0aWxsIHRoZSBoaWRkZW4gZGl2aXNvciBvZiAyIGluIHRoZSBNTUMgbW9k
IGNsb2NrLCBzbw0KPiBuZWVkIHRvIGV4cGxpY2l0bHkgY29tcGVuc2F0ZSBmb3IgdGhhdCBvbiB0
aG9zZSBTb0NzLg0KPiANCj4gVGhpcyBsZWFkcyB0byB0aGUgYWN0dWFsbHkgcHJvZ3JhbW1lZCBj
bG9jayByYXRlIHRvIGJlIGRvdWJsZQ0KPiBjb21wYXJlZCB0byBiZWZvcmUsIHdoaWNoIGluY3Jl
YXNlcyB0aGUgTU1DIHBlcmZvcm1hbmNlIG9uIHRob3NlDQo+IFNvQ3MuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBBbmRyZSBQcnp5d2FyYSA8YW5kcmUucHJ6eXdhcmFAYXJtLmNvbT4NCj4gUmVwb3J0
ZWQtYnk6IEt1YmEgU3pjem9kcnp5xYRza2kgPGt1YmFAc3pjem9kcnp5bnNraS5wbD4NCj4gLS0t
DQo+ICBkcml2ZXJzL21tYy9zdW54aV9tbWMuYyB8IDcgKysrKysrKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL3N1bnhp
X21tYy5jIGIvZHJpdmVycy9tbWMvc3VueGlfbW1jLmMNCj4gaW5kZXggMGI1NmQxNDA1YmUuLjhm
NzJkNzU4ZTQ2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21tYy9zdW54aV9tbWMuYw0KPiArKysg
Yi9kcml2ZXJzL21tYy9zdW54aV9tbWMuYw0KPiBAQCAtOTIsNiArOTIsMTMgQEAgc3RhdGljIGlu
dCBtbWNfc2V0X21vZF9jbGsoc3RydWN0DQo+IHN1bnhpX21tY19wcml2ICpwcml2LCB1bnNpZ25l
ZCBpbnQgaHopDQo+ICAJCXBsbCA9IENDTV9NTUNfQ1RSTF9QTEw2Ow0KPiAgCQlwbGxfaHogPSBj
bG9ja19nZXRfcGxsNigpOw0KPiAgI2VuZGlmDQo+ICsJCS8qDQo+ICsJCSAqIE9uIHRoZSBEMS9S
NTI4L1QxMTMgbXV4IHNvdXJjZSAxIHJlZmVycyB0bw0KPiBQTExfUEVSSVBIMCgxeCksDQo+ICsJ
CSAqIGxpa2UgZm9yIHRoZSBvbGRlciBTb0NzLiBIb3dldmVyIHdlIHN0aWxsIGhhdmUgdGhlDQo+
IGhpZGRlbg0KPiArCQkgKiBkaXZpZGVyIG9mIDJ4LCBzbyBjb21wZW5zYXRlIGZvciB0aGF0IGhl
cmUuDQo+ICsJCSAqLw0KPiArCQlpZiAoSVNfRU5BQkxFRChDT05GSUdfTUFDSF9TVU44SV9SNTI4
KSkNCg0KVXNlIENPTkZJR19JU19FTkFCTEVEKE1BQ0hfU1VOOElfUjUyOCk/DQoNClJlZ2FyZHMs
DQpQZW5nLg0KDQo+ICsJCQlwbGxfaHogLz0gMjsNCj4gIAl9DQo+IA0KPiAgCWRpdiA9IHBsbF9o
eiAvIGh6Ow0KPiAtLQ0KPiAyLjI1LjENCg0K
