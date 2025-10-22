Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84794CCD1BE
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:21:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 094FC833F6;
	Wed, 22 Oct 2025 09:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Y3kDGOUa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 560F78323A; Wed, 22 Oct 2025 03:56:09 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64CB082B20
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 03:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ke332UaYASMsYiT3rUUHLabA708GJouM0R+ZJbvdU3cd2c0NZ669VpS+hqHXVt7t7JgqZotOcwggF02Hf0y9dBuYr6ueMla5eTRXoiyzmYKe6vI4qGr4AHVnPtbrvu50ZayK3XXVqUKUZIsWx51glWgXCuhLTXg/G4HvldLLvfoe73tNHKGIX18ohIjt9sdpupCzKpQhiq9Gpx4ATJPhLqk3E2qlvjrkvj9l8/IqnB15TyWa+7rUZEHEov+HyQcdO7WEbJcUmWT0nxg7GZO893BDbeDNdNxo4XtSapKr5DTZF4LPMnoHpWiHq2nFAA+a6h9ATQskRgcAcwKzxAqMUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GFdGbNIDQzlgzfh1V9OtSJLajeL1mwtcQgXuWEX7dU=;
 b=TN1VNT1ccPcMGN5ihYswV0MKHtqsBYVx965gDf5ie1xzE8C4yJyXi5VTb4VHxedi4RoBc277juYlXG5D0e8+X7dXgnv1bYILThF5o6O4MuwXEFEezqvARL4ZGta71pTv3T2j++esDU/8qLzeThrw+AQcS1eoRPhF5g8+Ibm6n+oXn4Z67qiR77ghn6Da+sADKwQqC3XFQhw9i0SH4sirn5lHceNYwgTDk1KQzF37INhjHvbZARsEsL4WVWQeSbU6+rbk6Q3eJMrlh+Q9O3HThrbgbxwsPstwrOWKCToK8p+fOgr0GsYFwQruzt5MMgueTF0ILzmmW0v0HSNBsuEf9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GFdGbNIDQzlgzfh1V9OtSJLajeL1mwtcQgXuWEX7dU=;
 b=Y3kDGOUacwwiVruQHHCavvpt6swAUriEdXwgfuniAT1CllB+WzzkdG7quCDXM4R0mWIvs+3bg1aMZoqf1O6xuHaNZX0Mk7iitodHdwtnoaEJxHWBosVSf+c5AKlREody69on6g/X6iCsU7+zuhNHYhaZ2OK+yBGUUnUQpQ/QF/Mjy5xW0fDA2jG60hmzHWxtGKbdFRYC3ZznyNPdBkPQ4iJXYo4HlB1BHDvNuI6Zuo/YDIG/KD/ndU24QPXJ9bu5Nbsx1TBYMTmc5Stfqr6y2BSMWmapsmLUO+I29ARlaNTWFWl3ELCUJzjVL89Zo7QcMcnmRxSGhohhC3we16WBBw==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DBAPR04MB7320.eurprd04.prod.outlook.com (2603:10a6:10:1a8::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Wed, 22 Oct
 2025 01:56:03 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9228.015; Wed, 22 Oct 2025
 01:56:02 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
CC: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, dl-uboot-imx <uboot-imx@nxp.com>, Marek Vasut
 <marek.vasut@mailbox.org>, Marek Vasut <marex@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Alice Guo
 <alice.guo@nxp.com>, Stefano Babic <sbabic@nabladev.com>, Peng Fan
 <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Jindong Yue <jindong.yue@nxp.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Frank Li <frank.li@nxp.com>, Simon Glass
 <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, Minkyu Kang
 <mk7.kang@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>, Minda
 Chen <minda.chen@starfivetech.com>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Paul Barker <paul.barker.ct@bp.renesas.com>, Roger
 Quadros <rogerq@kernel.org>, Joe Hershberger <joe.hershberger@ni.com>, Ramon
 Fried <rfried.dev@gmail.com>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Weijie Gao <weijie.gao@mediatek.com>, Andrew
 Goodbody <andrew.goodbody@linaro.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjMgMDAvMTBdIEVuYWJsZSBVU0IgYW5kIEVORVRD?=
 =?utf-8?Q?_on_i.MX943_EVK?=
Thread-Topic: [PATCH v3 00/10] Enable USB and ENETC on i.MX943 EVK
Thread-Index: AQHcQvcF0P2MpgEG1k6sBigUAABHYA==
Date: Wed, 22 Oct 2025 01:56:02 +0000
Message-ID: <PAXPR04MB9644E01346A04BCC1A649918E2F3A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20251013-imx943usb-v1-0-293e79d4bc12@nxp.com>
 <CAOMZO5CQvaVqhrOUJ9rTXRoR50pOSVWGXWBzj8Uc3vPM9xRA0Q@mail.gmail.com>
 <20251021190004.GF6688@bill-the-cat>
In-Reply-To: <20251021190004.GF6688@bill-the-cat>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|DBAPR04MB7320:EE_
x-ms-office365-filtering-correlation-id: 10962333-da5c-4f7a-0258-08de110e2795
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|19092799006|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?ZlFFR2pQcUJEUThCODJtSURaZ2dMUWpFWGV1N1huNUdmd0k4cWVGWmNmcVVD?=
 =?utf-8?B?TFhiRWdGOFZ5VUdnTGV1bE91cW1aRjVRK3hEWThQSzdTYWVHdXo4dXNOOGNi?=
 =?utf-8?B?LzNHVHA0NTZWME9QU01mdGNJbmdLQVZIcmFYZEZKeGZUb1lxMllMVUdpWStk?=
 =?utf-8?B?RHBLRjNEb0JRaHNuTnZ0Vzd0S3pBZGJTVXFUU3h5VUJETHZSVjhlZDFKKzNj?=
 =?utf-8?B?K0RDZmZVQmVJUmw0dms3WVlZQTZ4TTU3enRTRGdxNXpCUDc0Q1AyVWlscDlT?=
 =?utf-8?B?VFJXQU9KSUNyTS84OCt3TkZHWW5SNUlrYUJwSWR1ZnZqMHEwQjhKNWpEdkZ4?=
 =?utf-8?B?LzZtTFJiR2oxUDhIOUQ1MEMyRHEyeWZTQ0RnV1AvM2VrRVdNa0pabkxxVHZ0?=
 =?utf-8?B?SEZnVjFrZDNjbmtNY0RnaE1RRW5xVnc2dGRZRkNaUVRXcXhGL3RtUis4elFN?=
 =?utf-8?B?Ujc0UUoyclV4Uk9QWkVWWGkvek9aTHNzL1dSdEx5K0VzTjhXSmd2QmJEV1dj?=
 =?utf-8?B?WHgxckFtVXFNRTR1b2RsUyt0T0pPaUpLellaUTUrTUcvbFkzU2gxU2hPbk9u?=
 =?utf-8?B?bmZqZ0c1YVdMUCthVUdvQVpWeEN2RjFuUFdydGcybHUxZGE0NUVXbTRaQy9T?=
 =?utf-8?B?aTZtbmtHblFROXlKYlNqdkVtbFkxU01jRWhoTGRMdWNTemdxV0RQQVpjbXNT?=
 =?utf-8?B?VUJKamV3VGFxUUFzbG9abHRWMFhsQUV2OEJtYmpPenR5NmtoTkthbFNsNXIr?=
 =?utf-8?B?RmNHam15dGlwNlRtZkVXQlB3bmhubHBwM2VwZTgyb0pmeDVadmVsdXVuY3VM?=
 =?utf-8?B?MUhmWUsvMG05UUYzRlpDNmhyNjQrVG1SUjR2RGIwUllaWVRJenUrOEhHQVQ4?=
 =?utf-8?B?TXozaHdiM0dSTlNHVldLMkd0Mmxta2xzSVZiWmdPTEdlUG5QUVVpcmFDWFRo?=
 =?utf-8?B?Uko0TUwyTnBnMEhBd2x0TUlXaW1DV0h4UXBFT2RwcVBnSzRlUUE0VWVMYTdw?=
 =?utf-8?B?cVF5NzAzTFlJVjg0U0c0aXNhZFZ4b2RoajdYcS9mWFBUaThsZXc4L1BneUNY?=
 =?utf-8?B?NjU4NmJjZmFRTjRMRzgzcm9vMnMyUEVleXpwK0M5ZlpHejFaZWt5M2VCa2Rs?=
 =?utf-8?B?OVhHb1kyempKTUFpS2lWN1cyRkNMMGRRYkd0MjFVSS9uaFd4aDlMNUVlNUsv?=
 =?utf-8?B?WFl5MXBVY3d2Vk5kRUpOM2puWWxJd3U2U0FZc1pXckUyekNiL1c5T3AvclFM?=
 =?utf-8?B?VS9FbTgzd0pHdWx0ME1CVXpvWWN2SXd6VTZnZk5XL2xPVnovNGxJK0JvZUpB?=
 =?utf-8?B?Ry9rQjVHdG9STHBqRXErQkhDZVQzZXVza0ZEWHlONVVnUzdWZ1krakhoMEp6?=
 =?utf-8?B?VytQSFVqT1hPei94bTBRb3oxL1B5QWNmQUw0dXJoamdURGFUT3pHWkYxMllh?=
 =?utf-8?B?ZUxIOXdCSUhlMjZOVnlkZ1Z6cldIWmI4VVpVek9uQ25ZamZPT21kdlNDS3dy?=
 =?utf-8?B?T2JWRFdiWHZPcDdlU1BnUGdnejBYek5yOUNQempHSVhSK3hBRzdjajV6NndQ?=
 =?utf-8?B?MmVuSHp2NEV1WDNMeXYrSmVJLzdxUEFtNnVweHc1UEw0TXhlOTJ3UFlXQXpH?=
 =?utf-8?B?SStOWFI3ZE1DMURWb3ZlY0FycmlzWDgzd3FmQVNPQ2p6Y1hla1lXNThFd21S?=
 =?utf-8?B?RExHVnRyOEVWdjRQVVNsU2UrT3I1NFMvbFpBbVp2UmtEWnZGS09raXZxYXZN?=
 =?utf-8?B?cGtFRlkwNkkzb3BBQWN6UUFGVXIzbEhWYWo0ZjNXVnJMV09JZytEQnlaZFU4?=
 =?utf-8?B?MkhYVkJrR0FTbWxvS2taL1dTRmh3dGhYTUhUejN0cU1rOVpBWlJYYTIwZTBH?=
 =?utf-8?B?Y3hFenJHOFBEVjRaSit1c1JYUmQ0UGVaZjRxMTB6ZDcxQ3VmU1ZlQjM5aDdL?=
 =?utf-8?Q?HsoK7/PFYrQWl6wbprvwKm5CgImz24+J?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(366016)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aklYUGpEMEJDOVVETlpWbWoySitIVG9UL2RHWjNxRjVFMlc4NDJWVklwS29C?=
 =?utf-8?B?bzRRdDNRZ2h5WnUwSFBKeEFFb04vODV2SUhyaDZMUmI3eW5JNnQxdzQraFZY?=
 =?utf-8?B?T1lNSytMQkM3c05sOFhBVmIrdzM3VGxNQ2FBMVhkSDk3YVJDNnl1SUg2Q2h4?=
 =?utf-8?B?ODVLY0N5aWVLN1plQzEvWllnV0RDaHJnNUhWTmZ0UnA4TFZFQWV5NzB5TzY0?=
 =?utf-8?B?U0sxMWZzTlNlN21MWjJrVEJzRVBHRUN5Z0tJR0JpQW1zTjhraHBwc2Q2b2RX?=
 =?utf-8?B?ZzNsbS9jKzJ1SWhVRE1KUnE3LzVNNjNZN21IMHJFVFhhWmF3aVVlWHQzV01s?=
 =?utf-8?B?UTlzalNFbm96YlpLazc3RHRKRlJxK0phci9ieUdSZlQrTWY5KzVRTTlNVGRF?=
 =?utf-8?B?T3RzY0lrYzBpVGNvVzJCN283VFBEblVpTVRLODZVWmdFMVRqbEhydjNTUzVn?=
 =?utf-8?B?SmRiTGovcDZFRmkxaW51NXZwdjRVWkU3ajlRMEtJdTUzYUVKUklQVk5HRHND?=
 =?utf-8?B?S3hEaFk5S2hzOTNYSXdCY21FN2tXQm9jWFkzQ0N2L0dFZkx0VWZxakNQeld5?=
 =?utf-8?B?SWdpR1BaeVFPWkhoby9kUHJoaklsb09HWG5GOUtwZW12V3J4UnRmMmVIOTAx?=
 =?utf-8?B?WkV5c3d0RVRYTXVlN3hRMzN5ZnNsOUl5WTBMNWxGcVNTcmZGT2hYQVQ3Z2F6?=
 =?utf-8?B?SzJUbHVhOWh6RGVQUUdTcUFVRUVmdklzVklDWW50bzdWdnFNYUt2dWM5L2wv?=
 =?utf-8?B?NVVDUU5RSVR1a0NGS3hRcWZnZGdiZXcvdU1JY2x4WmJvK2VHcGhEd3p2cFFx?=
 =?utf-8?B?NStjT0NMc1hmVVlKS1d5cm1QK1h5VUl0ZU1xNHFLM0UrV21MclFMSDlKaklX?=
 =?utf-8?B?a2tkSXpwWjlIbm5wTmRqQ0hJUGZaU3QxYXVIYXZtcTN6eTc5SUJ4eWplOWJy?=
 =?utf-8?B?RmJ2cUtRMW1PdkJQY1p6aGtqTFlydDZyYTRJbXh4cUpILzExaGhQVHBCcXpW?=
 =?utf-8?B?cGh2NURVRWRMRGNWblFZMU9oR3d3YU5jR1FBU1dwZ2dNK1NFRnRPUG5yaWpR?=
 =?utf-8?B?QVgvUGMrVzUwMU53SWh3VXo4cnhaTFowdEtCcGxjZTJESjFJc0pQUW52NU10?=
 =?utf-8?B?TW5DOTJkWlhpcnZaYVJTOHJjS0NxMGlHcEFCVVQvbFRsaEJhODhKUCtZaWdC?=
 =?utf-8?B?enNPeDd3ZEdMZTIwRHdQdDhpSTdJTnhON05ldVF1bC9qbStUMkdqM1RKTXNv?=
 =?utf-8?B?eDhTZWpuSGQyQ1ZXRjVFZWVQbmtLcTZCSVo1SjNMNFh6bVBtSzZlMVNuQU1z?=
 =?utf-8?B?eCtnaUlnQzZ1TjZONWdMc3J0Wk5GdUVqdEJtb3BOUW51Y09XdjRIaWNFdlRh?=
 =?utf-8?B?YlE2ZWpjUWRiQTc1d0hFaS9POFBValVqS2NOTHdncGhBeWJYMCtNNHVWSEY4?=
 =?utf-8?B?b0xjOEVySEJVRTlQclg0S3pmaHZORGJIalBkL3JRWWpWZno4VkloTHFEN0Zk?=
 =?utf-8?B?eU5MVzhsQ0pWcnFzS1FpQW92OFhVRVJvM3Fqb2lVMUYwMTR6eWU3bkplTGJG?=
 =?utf-8?B?dXNIQ3FWT05nOHU4WkNudlNKMjVzaUJQZG1HOForOXBzK2dKK2lkdG9HaUJv?=
 =?utf-8?B?Tkxab3J3UDBVUm5SMnU5WmtQTnRTTksyOVJDMmdtQXVMcGFnQ3ZzazZOZlA0?=
 =?utf-8?B?VnlOY3pmVjFSRDg2OEJmS0hmQ1MrRW1xUzhBV1QzcVpXa2R1YVZsWEdjU0NE?=
 =?utf-8?B?SmxoY25LSVdwb1lCRFJoUXpPNGg0NDNnYWZHREZWS1N6STYrZmU3eWhMNWlh?=
 =?utf-8?B?aHF2UU9nWXl6cHd0M1RBRjRzbXlmSUE5d1crTmNDcEFWVGExQmJWL1VnWHhP?=
 =?utf-8?B?NDdCQXVoZkU3bTZ6YUhhNDM2OFNVVFQxUC9wVnc2bFN1czQwaVRFZWsySkhT?=
 =?utf-8?B?Y1VjdmcrcFNXZEoxRlJpckczdGRiclMrNXVnZDBUVVllVlNRaXBKMFhtM3JR?=
 =?utf-8?B?TDcwUmpNK0VjYlhGRWJyb0MxM3ZoNzZXbTFDZUJrMFE3K3QrSjNUNlMvc2NK?=
 =?utf-8?B?NVdtTSt1NmVyWWVWdFF3UHorbmk3OEYwRUJobE1LZzNvUk9tZ0tOU05SQ1cv?=
 =?utf-8?Q?FYi8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10962333-da5c-4f7a-0258-08de110e2795
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 01:56:02.4412 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4kANjn5TWU7Ph44sereiQ9WkZ4BEVS63QHEVM74QeBTsFsv7lpxvqk6z9eXVjH+wPDOS5MFGJnOImivD3yJjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7320
X-Mailman-Approved-At: Wed, 22 Oct 2025 09:21:43 +0200
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogVG9tIFJpbmkgPHRyaW5pQGtv
bnN1bGtvLmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI15bm0MTDmnIgyMuaXpSAzOjAwDQo+IOaU
tuS7tuS6ujogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiDmioTpgIE6IEFs
aWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPjsgdS1ib290QGxpc3RzLmRlbngu
ZGU7DQo+IGRsLXVib290LWlteCA8dWJvb3QtaW14QG54cC5jb20+OyBNYXJlayBWYXN1dA0KPiA8
bWFyZWsudmFzdXRAbWFpbGJveC5vcmc+OyBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT47IE1h
dHRpanMNCj4gS29ycGVyc2hvZWsgPG1rb3JwZXJzaG9la0BrZXJuZWwub3JnPjsgUGF0cmljZSBD
aG90YXJkDQo+IDxwYXRyaWNlLmNob3RhcmRAZm9zcy5zdC5jb20+OyBQYXRyaWNrIFJ1ZG9scGgN
Cj4gPHBhdHJpY2sucnVkb2xwaEA5ZWxlbWVudHMuY29tPjsgQWxpY2UgR3VvIDxhbGljZS5ndW9A
bnhwLmNvbT47IFN0ZWZhbm8NCj4gQmFiaWMgPHNiYWJpY0BuYWJsYWRldi5jb20+OyBQZW5nIEZh
biA8cGVuZy5mYW5AbnhwLmNvbT47IFllIExpDQo+IDx5ZS5saUBueHAuY29tPjsgSmFja3kgQmFp
IDxwaW5nLmJhaUBueHAuY29tPjsgSmluZG9uZyBZdWUNCj4gPGppbmRvbmcueXVlQG54cC5jb20+
OyBNYXJlayBWYXN1dCA8bWFyZWsudmFzdXQrcmVuZXNhc0BtYWlsYm94Lm9yZz47DQo+IEZyYW5r
IExpIDxmcmFuay5saUBueHAuY29tPjsgU2ltb24gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+OyBM
dWthc3oNCj4gTWFqZXdza2kgPGx1a21hQGRlbnguZGU+OyBNaW5reXUgS2FuZyA8bWs3LmthbmdA
c2Ftc3VuZy5jb20+OyBTYW0NCj4gUHJvdHNlbmtvIDxzZW1lbi5wcm90c2Vua29AbGluYXJvLm9y
Zz47IE1pbmRhIENoZW4NCj4gPG1pbmRhLmNoZW5Ac3RhcmZpdmV0ZWNoLmNvbT47IHRoYXJ2ZXlA
Z2F0ZXdvcmtzLmNvbTsgUGF1bCBCYXJrZXINCj4gPHBhdWwuYmFya2VyLmN0QGJwLnJlbmVzYXMu
Y29tPjsgUm9nZXIgUXVhZHJvcyA8cm9nZXJxQGtlcm5lbC5vcmc+OyBKb2UNCj4gSGVyc2hiZXJn
ZXIgPGpvZS5oZXJzaGJlcmdlckBuaS5jb20+OyBSYW1vbiBGcmllZCA8cmZyaWVkLmRldkBnbWFp
bC5jb20+Ow0KPiBKZXJvbWUgRm9yaXNzaWVyIDxqZXJvbWUuZm9yaXNzaWVyQGxpbmFyby5vcmc+
OyBIYW55dWFuIFpoYW8NCj4gPGhhbnl1YW4tekBxcS5jb20+OyBJbGlhcyBBcGFsb2RpbWFzIDxp
bGlhcy5hcGFsb2RpbWFzQGxpbmFyby5vcmc+OyBXZWlqaWUNCj4gR2FvIDx3ZWlqaWUuZ2FvQG1l
ZGlhdGVrLmNvbT47IEFuZHJldyBHb29kYm9keQ0KPiA8YW5kcmV3Lmdvb2Rib2R5QGxpbmFyby5v
cmc+DQo+IOS4u+mimDogUmU6IFtQQVRDSCB2MyAwMC8xMF0gRW5hYmxlIFVTQiBhbmQgRU5FVEMg
b24gaS5NWDk0MyBFVksNCj4gDQo+IE9uIFR1ZSwgT2N0IDIxLCAyMDI1IGF0IDAzOjQxOjU0UE0g
LTAzMDAsIEZhYmlvIEVzdGV2YW0gd3JvdGU6DQo+ID4gSGkgQWxpY2UsDQo+ID4NCj4gPiBPbiBN
b24sIE9jdCAxMywgMjAyNSBhdCAzOjU54oCvQU0gPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT4gd3Jv
dGU6DQo+ID4gPg0KPiA+ID4gQ2hhbmdlcyBmb3IgdjE6DQo+ID4gPiAgLSBBZGRpbmcgVVNCMiBh
bmQgVVNCMyBkZXZpY2UgdHJlZSBub2RlcyB3aXRoIHJlcXVpcmVkIFBIWSBhbmQNCj4gPiA+ICAg
IHJlZ3VsYXRvciBzdXBwb3J0Lg0KPiA+ID4gIC0gRW5hYmxpbmcgRU5FVEMxIGFuZCBFTkVUQzIu
DQo+ID4gPiAgLSBVcGRhdGluZyBLY29uZmlnIGFuZCBEVFNJIGZpbGVzIHRvIHN1cHBvcnQgdGhl
c2UgaW50ZXJmYWNlcy4NCj4gPiA+DQo+ID4gPiBDaGFuZ2VzIGZvciB2MjoNCj4gPiA+ICAtIFJl
c2VuZCBwYXRjaCBzZXJpZXMgd2l0aCB1cGRhdGVkIFRvIGxpc3QuDQo+ID4gPg0KPiA+ID4gQ2hh
bmdlcyBmb3IgdjM6DQo+ID4gPiAgLSBSZW1vdmUgbG9naWNhbGx5IGRlYWQgY29kZSBpbiBpbXg5
NF9saW5rX2NvbmZpZygpLg0KPiA+DQo+ID4gVGhpcyBzZXJpZXMgZG9lcyBub3QgcGFzcyBDSToN
Cj4gPg0KPiA+IGh0dHBzOi8vc291cmNlLmRlbnguZGUvdS1ib290L2N1c3RvZGlhbnMvdS1ib290
LWlteC8tL2pvYnMvMTI3MDE0MQ0KPiA+DQo+ID4gQXMgSSd2ZSBtZW50aW9uZWQgbXVsdGlwbGUg
dGltZXMsIHBsZWFzZSBydW4gdGhlIHNlcmllcyB0aHJvdWdoIENJIG9uDQo+ID4geW91ciBzaWRl
IGZpcnN0Lg0KPiA+DQo+ID4gVGhpcyBpcyBiZWNvbWluZyBhIHBhdHRlcm4gd2l0aCB0aGUgTlhQ
IGZvbGtzJyBzdWJtaXNzaW9ucywgYW5kIHRoaXMNCj4gPiBuZWVkcyB0byBpbXByb3ZlLg0KPiAN
Cj4gSSBhZ3JlZSBhbmQgSSB3YW50IHRvIGxpbmsgdG8NCj4gaHR0cHM6Ly9kb2NzLnUtYm9vdC5v
cmcvZW4vbGF0ZXN0L2RldmVsb3AvY2lfdGVzdGluZy5odG1sI2F6dXJlLXBpcGVsaW5lcw0KPiBo
ZXJlIGFzIHdlbGwgYmVjYXVzZSBpdCB3aWxsIGJlIGJldHRlciBpZiBldmVyeW9uZSBoYXMgdGhl
aXIgb3duIEF6dXJlIHBpcGVsaW5lDQo+IGFuZCBkb2Vzbid0IGdldCBib3R0bGVuZWNrZWQuIFdl
IGNhbiBhbHNvIHdvcmsgb3V0IHNldHRpbmcgdXAgY29udHJpYnV0b3INCj4gcmVwb3NpdG9yaWVz
IGluIG91ciBnaXRsYWIgaWYgdGhhdCB3b3VsZCBoZWxwLCBhbmQgcnVuIENJIHRoZXJlLg0KPiAN
Cj4gLS0NCkhpLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4gSSB0aGluayB0aGUgcGF0Y2gg
c2V0IEkgc2VudCBtYXkgc3RpbGwgcmVjZWl2ZSBjb21tZW50cyBmcm9tIG90aGVyIHJldmlld2Vy
cywgYW5kIGl0IG1pZ2h0IHRha2Ugc2V2ZXJhbCByb3VuZHMgYmVmb3JlIGl0IGlzIGFjY2VwdGVk
LiBNeSBwbGFuIHdhcyB0byBydW4gQ0kgdGVzdGluZyBvbiB0aGUgbGF0ZXIgdmVyc2lvbnMuIEkg
d2lsbCBiZSBtb3JlIG1pbmRmdWwgb2YgdGhpcyBuZXh0IHRpbWUgYW5kIGNvbnNpZGVyIHNldHRp
bmcgdXAgQ0kgZWFybGllciBpbiB0aGUgcHJvY2Vzcy4NCg0KVGhhbmtzIGFnYWluLA0KQWxpY2Ug
R3VvDQo=
