Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8176BC35FFF
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 02:28:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BACD8809D4;
	Thu, 20 Mar 2025 03:28:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="npqkXDSm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C533E80FF0; Thu, 20 Mar 2025 03:28:32 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 123918083E
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 03:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJiDiCopUvHD+X0CBO5Kaw+nHUUfQUvAl3WAx0u7WxXUvs6TTWAilYD7iSr3T0M89yl8wBY5d9bHG/kypWUyACbLjgmIELYkxhXq97pGq3ZDTKyekXgcjkOq5ElYFn+GRSuPjq4ioVEjaJ3p6z6OLHk7tL4FP/8HUtR+TnHQkt71bngfIt4rHWxtf5ot1pJm0iulVyW2VivGrszejUJyrcAqI04gTKjB5O09CrAoxsdlZQMU1DQ1AjEe4h0CMgJ4mNHNPVAuMlomAB2ZJZ0r3rfKSwF9XmqIPGH9U5nNj1Er64m3AUkmDtnvqr5RhM7i5gFOdMXfzt7bDQX0LYlHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhCl+f/04QQDgEAcCgsCxcGubxXn7By8ag+lWlrIa7c=;
 b=Vl8UkwuaKLdnI+1Gk0eH59Sa9Fi6qsQ0D/d22FfOluBgM+rpzygQtV84N/Qv7kwBRmaodxwU9P9vkHNo7LTSlEN9gOaL2Fthkq199p6sTir4cNXXNiNlnGHNI8nXVIPOUMStHWN8r0ojvVf4n/viH55zxm19GVI7AfRui5LxfRzaMYyrDuux6YHUijipyxIiR5aUPhSSS/0Nr3der4E1KfVSm6Z7UY8NfPPOEtx3VQilyaohzLwloAT0UnP7EsUnBOwIZS4dK+N1FPA5QcthLrIASTrrix2ucZGDoMpgvmLGyq74/pi/JRIxGG9ZJ23uQ7axW/D/zGTEYFl5p+uiCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhCl+f/04QQDgEAcCgsCxcGubxXn7By8ag+lWlrIa7c=;
 b=npqkXDSmZpasXXJVD7Tyn4NPC6Ds+fzUSwEEBR3bxAYUrnvEiRK0MqgvZum1OK07B6nq6U1o6nlN9gXcTfrzANcTPvA8ooiGC481A0pW5ipEHngHqxTv7UQ2rmc5GyEUfwIRFkkVP1Dfgej8+GI0bPe1XG7Yisg1pBvYZ0mULs3olvVbA/PQ4qA9hceH9/3WMDUj8ZboBFmZxXOlL1x+rdnDt1uCrHeVPfsEQLXlxamtvgiaWD9RY3r2iLx6TPBTz7JZ0MNVo4v947DqGZaQEkb2ihbWpSlGyYAuP7cjiPYvRufuFeuKAZwH4U/Ep2PXNY9BL4VWSDaO4WXuMNqyQg==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10331.eurprd04.prod.outlook.com (2603:10a6:150:1d0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 02:28:27 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 02:28:27 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio
 Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbnuWkjTog5Zue5aSNOiDlm57lpI06IFtQQVRD?=
 =?utf-8?B?SCB2NCAwNC8yMF0gZmlybXdhcmU6IHNjbWk6IGFkZCBwaW4gY29udHJvbCBw?=
 =?utf-8?Q?rotocol_support_to_SCMI_agent?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbnuWkjTog5Zue5aSNOiBbUEFUQ0ggdjQgMDQv?=
 =?utf-8?B?MjBdIGZpcm13YXJlOiBzY21pOiBhZGQgcGluIGNvbnRyb2wgcHJvdG9jb2wg?=
 =?utf-8?Q?support_to_SCMI_agent?=
Thread-Index: AQHbZ1F+XbneYzJjuUCxxW5MfO0jxbNQy1yAgAA15YCAAQ5sgIADuNAAgAdZAACABABdAIAA1qkAgAKqv4CABvo6AIAP3WrA
Date: Thu, 20 Mar 2025 02:28:27 +0000
Message-ID: <PAXPR04MB9644E5C1DF5B039D6BB65F6DE2D82@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-4-93b28a514dea@oss.nxp.com>
 <9859d7f3-95ed-40b4-9140-f86638b0e522@denx.de>
 <PAXPR04MB96446C0606C01C6CC5B3622FE2FA2@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <1eb93e8b-0355-4274-a680-f6481e398e5a@denx.de>
 <PAXPR04MB9644F7D41AE5AB9EF61FC5DBE2C72@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <5bb207d9-0ad0-4409-9c3d-bdf676cc7698@denx.de>
 <20250224022831.GA9876@nxa18884-linux>
 <c1654174-8473-46a9-9b0b-925b65ab4413@denx.de>
 <PAXPR04MB9644FE1F92AFF132649A7EA5E2C92@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <3b232bda-000e-4f6b-8661-eeb72fc78b67@denx.de>
 <PAXPR04MB96443A9429499C5FF777EDEDE2CB2@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <fb46746a-1d50-4226-8f56-2dade4f52891@denx.de>
In-Reply-To: <fb46746a-1d50-4226-8f56-2dade4f52891@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|GV1PR04MB10331:EE_
x-ms-office365-filtering-correlation-id: ae4f17d1-6d76-48fd-bccf-08dd6756e58d
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZkZPZnRBcHFRKzBPbFZpTVNLcE5obnpBRWtSZWJnVGlIblQwaHYydjRId1pw?=
 =?utf-8?B?ZEhKZDNmUkp6VitSQTYwV0VLQnJYZ3VUaS9hTVpMTnNUTTN2K0Y4RkU2S1VY?=
 =?utf-8?B?UXp0a2tMU3prOHpSaUlHY1pVaHRoeW5ueXBQS1B2cXlSVTNOcTR4U2t3YmpZ?=
 =?utf-8?B?d09xbFArSDBubXQ4bUZiWEZtQWhNa1Y4QWsrVXBZa3c4S0hsb04zUUVvUG5i?=
 =?utf-8?B?K0xLbWp0emdTN1hkUEdNcGdEdm8weGpQT0JTWmtHelQ0MUpaSnZMU1NXZHRB?=
 =?utf-8?B?Z1pHell2d1RJTHNnY1NKVTRnaWZjdU1Benh3TFFXVU80a3MvVjlyNzNHOXkv?=
 =?utf-8?B?dzliU2l6NFAvVG9TakpYbWNxUFh6WHZSTEt0TWUwcXB1dlZQUzhqTzdWcDVs?=
 =?utf-8?B?L2M5MnkySlBSWVphZ0hpVitHRThxZjFoRE5nNE45emZYZmg0MHF3Yks1clVn?=
 =?utf-8?B?aEJjbjV0SzZmSmtTNjI2MzFPR3lUNEZ6a1JveG5OTHcwTTY3eUVmWUxJVllO?=
 =?utf-8?B?UEs1eUs4WS94c2N1MlBPZWNENzZ6ZGNTMVJXZHFmS2FvV21NODBhVHhLS0tQ?=
 =?utf-8?B?eS9xNm4xY0h4ZUFGRjgyOGNLZ0lBRnA4R0IwWndMTXYram1jVVBrWTNwbUdw?=
 =?utf-8?B?MkpNY1ZkQk5MdHRJS2dmaGFIQ0J2QS9ER21VVGtBMkJMMkR1N002TVJLU25r?=
 =?utf-8?B?S0JET2FoN09RdlcrbmQzcHVPbUZ1cTJCU2lWZkgxdGlwUVpJQ0JJQjQvbGVN?=
 =?utf-8?B?VC95V2NYa09QUkcwcVRuRWNtbmFHdkpEU0gwWmVha2piZmh1Mm8rbHBmUFhX?=
 =?utf-8?B?ZHVmd2VmdnZvcCtOM1RSNnpLTVQweGdNeVFvTlFBNFA1NDh0Q3F6QWE0RFJK?=
 =?utf-8?B?WXdCTWhoZGpnV1UyTGhXUy9DbXBNbnFKSFRuZGNldnVjNVF0MlAxUFZGQW5V?=
 =?utf-8?B?ZG5mRWlmeWthdFQyTTA2UGo5aTljeTlJTzkxUU1OK2ZvUnVvaVJpVEdtbWNG?=
 =?utf-8?B?SlFESmo0MFFQU1pmTUZuaEM2VjFMY1hNc3dwRmplSUdOeHZwN2lXcGFUUENh?=
 =?utf-8?B?WXB0TnpPOUNFMW1wek5ZMDhCYWNnNWhwNmVaWGFub29OYUFZbXZtVWtmaU1y?=
 =?utf-8?B?RWw0bjRvYXN1UU8xWkdjZ2ZOU3FaZWo3UEFzWlEvdHhXYUlDVHg4N2ZDNGZQ?=
 =?utf-8?B?S0RHMWhrNHl6TXZscEFqZ0MxMFBZTzVpVVJjczdLaXRRVDFZc1YzN0wyaytS?=
 =?utf-8?B?YStNejBoVkE2bFFFc1JtbUE0TlZQNWZkTHQwQVUrNmxOMlBMU0ZzdUtLMFQ4?=
 =?utf-8?B?Y0NKOE4vTHBkSHdlQmJlaytVcGg0WEFPUmF0S3QvR1diRWRLM0NYajlSaHJq?=
 =?utf-8?B?SU1vZTBkUnpKNzAxc2hZam9nUEVrdldWZGR0cklFNkRDWDJ6SVJnSDhWRnJn?=
 =?utf-8?B?YitseVl4WVpjWFFQejMrSnNGdVNxNGY1dXY2cW9uWWlGZjdBSHN2dE50U0tj?=
 =?utf-8?B?aWpGZWFGZktidXJValhzK1pLTlpqOWtlbzdmb2NldjRIQmhiVUlibEwydUtq?=
 =?utf-8?B?bWlIbmp0TXpRaGFhbC9tS1NNSWg2ZVdxY3VFazlYdlNoUmhEWWFHZG1qMWdU?=
 =?utf-8?B?M0pINXF3U0tJZzE5OGxSa01zbXJjV25aNDRaOVhmM1I3VkhCa09GVlJUNEhi?=
 =?utf-8?B?dVFMR2Qzb1M1cDdFODg5cHhtaklzL2J6V1JkNUNud3RrVy9pYXlET29wTEc3?=
 =?utf-8?B?VjlFNDdBNXpSOXRvZTJ3c2pxU2xrcnhPSXJ1NXVsZ3ZzMXJNbXA5QmhYVEs0?=
 =?utf-8?B?NE40MHN4blNtRzZkSHhPRDZ0WU1ydE4zMnJTZ2N6VjA2OHBRK2QwN1RNUHFn?=
 =?utf-8?B?dVhlZGRqODRLcnRvT1FBNnN0eFFsV25WMnhPNFhCVmRqbkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YStncnk5SmNiSDJublNDRU5XcG0ydDB0VzNzZXoveU5ZWVVkZzJuY2lMSm12?=
 =?utf-8?B?UnZBcGNZQWZGaTVwZW50YjhnVFZMRlU4b2pTUWVWZTBRSlNqdVY2VDNqOVhr?=
 =?utf-8?B?ZmhtVlFrUmtFS1lmbEx5Q0FYeTJmZzlGR0l0dVVnN1RQMTJHQURlMDJsVG0z?=
 =?utf-8?B?dE9rV0s1Q0FLZVI2MkR3Y0hIdDd0RzU0N1dZT1o2RW1FUXIrOFc0T2tUZmhD?=
 =?utf-8?B?b2IxYk53OVBiM3pmMmtDWUk0YWNIbzlDeUhRQ21PbTd5V1RWVmh5YkdYNlRK?=
 =?utf-8?B?VWNRSEdjd3lrYk9TOVVXeG9PS0tHbmphdi9jMHlUTW5KdlRCeGEveVhPRlhR?=
 =?utf-8?B?OGs0dER3MDVJSWxMbDliUFVIOGhSY3JCRkxUSEpLV2VDQ0RoWCtFVFpuZG9m?=
 =?utf-8?B?Mjc2bUI2WDBXOWUveSs4OURGNXlYSFlHN200TkpxV0J3SitZQVR2c2VjazJ1?=
 =?utf-8?B?N1pvcFUwcThMZS9tek5xRmZmN01NY0ZEZnJxNnJJUzJ3MjRsZXV1akx1MXlV?=
 =?utf-8?B?dnYvUGJYQVhXODFmZFJHWVFCYW0wUlhWNkorSDY5cHhxUkYzMHJMZXBWVURN?=
 =?utf-8?B?UnBQa0E0TWQwS2ZKMmJBQzJ4YWJtSm03ZHV2akRMOE8xVEJmblpGNTRwRHhG?=
 =?utf-8?B?NEFFUzFxcjkzWTRoZlFZcFN0OXRUWFhTQ0ZLM0cyMUZadnBBRmhDUk9Wa21C?=
 =?utf-8?B?b3NYWUd3MkRIZEVBSGwzOEYzaDVaRnZjQVZCVHROckY4UnVyMHhKTkxMcTk5?=
 =?utf-8?B?bkpiUWRrc0ZjWFM2c2k2RFNiZ0UvNGVnMXB0WWg0MjZwbGY1cE1FbGN1QlVU?=
 =?utf-8?B?M1BsZU9FN1FNMGdFSDVRbnpTSVRhN002T0h0Q3F5WHM3QnZ5S0hxZ2ppK3NP?=
 =?utf-8?B?RXMxTHdFWlExTk0rK3ZtNFMzVm0xRjFzUUMybnBhZFBlRkI2eUpmUDh3bU1l?=
 =?utf-8?B?eS96cThrWjY4VnM5MXdoSzdpUmdTK2RKSXl0V2FXRjlKdVRHRHhLNVdVNVVH?=
 =?utf-8?B?TTlIZ1o3ZVBvY0RXZTlKZVJYWnFoVUx2NWkyVXN4bHl5UVdaMnBHZWNYOXQy?=
 =?utf-8?B?TVcwTHY4SEU1Y1NsTG1MZUhBWWlUaWhvVU5mZnZVSm43U1BRbWFjQzkvdFY5?=
 =?utf-8?B?ejRtOXBzVlIyYTQrbkJEWTdUODF0RVNoNU1zK29XMVNKa005MG1rRnZLOXUw?=
 =?utf-8?B?dWl4S0pnRkRZcDJ3Y1BhaEFjVDRZcE9NUjNWeElZZitHRWFXZjAyMSttVUtN?=
 =?utf-8?B?ZkoyTFZjdnFDeWVXelN3UUZJOUU2NzluUlFSNjBJc25IQjdNcEx6ay9iRXNU?=
 =?utf-8?B?VVZ0ckt3VTZLb2wyUWNEQjROa09HdzZGd2dXREg5NWovSUU2YnAvN29PdVFr?=
 =?utf-8?B?Q0l1RmlhbjJFelM4WDhOYnl4RVhwbHRXYkpMNXlJZk4zTzBmd3p3Q25kWjFy?=
 =?utf-8?B?NGhHWmcyalRXS05ZZ1RYLy9GQlA2d0U0UTJlYWhBUzY1cFJvTjNzclVwd2Rr?=
 =?utf-8?B?cThneENWcnF3WWhUcFhJMzk3dFoyNldGYVNDU1ZXaGFkaVg3NXRVOXFZc2h3?=
 =?utf-8?B?eUYrZ1lkaCtRTTVKd1duS3UreFZzWFN4U01pYXBVanowMFIxTEt3UVZKNVE0?=
 =?utf-8?B?UmM2RG1yajhwVHJrWktpUTBmemVZckFxck9hb0ZGZWlEU1J2U1VYWmZueUx6?=
 =?utf-8?B?a3NGSzJqZlhiN0pJckgwTHV1UlA5V3Y0RU1rUHVJNGU2Skh1TkpXQ1BkWDVP?=
 =?utf-8?B?MGxSbTZ3K3ZKaTVxTCtaOWZSMTFpSEltbG1URU5ZbUsvV1orVUhYeTl2NXYy?=
 =?utf-8?B?eUpWMHRpc1E3ZDZCbllvUkRvZkJrK3hGVnFKUEE4ZGJvbXRBNlJjL1U5cStn?=
 =?utf-8?B?YUJmZUY0SkE0NjdTbXJ6REtjc1J3UEFkaHFwRWVWbGNiQUJ3U2o5MjFHcVhr?=
 =?utf-8?B?WjYzRDJWNUxUYStQTmx4cnBvdUlrRGw1TTRoUmZicGJXVlNuT2lhcDNSN0N4?=
 =?utf-8?B?eEJzRmZWbEZNdURYcUNiMDU2TXdqaVFrU1RrejU1WkorUGtHVTZ5MDlJQVoz?=
 =?utf-8?B?Q2ZDb3EyU2JFRWlnTGlmQnZRUk0vMktObEtvcTdHZmNYcmhhZFFhSG1LaWgy?=
 =?utf-8?Q?s71t9wNgiQydOBA3amDt/UnaS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4f17d1-6d76-48fd-bccf-08dd6756e58d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 02:28:27.2545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 66tCUPIRn3MZsbnXi4zoMuPf964eTYrY4zk5N2ergYWxkUqNU+a7RXaQ+M++lTTPGWu1tSAFkpB1IEJ7VxS4OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10331
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
QGRlbnguZGU+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDPmnIgxMOaXpSA4OjEwDQo+IOaUtuS7
tuS6ujogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+OyBQZW5nIEZhbiAo
T1NTKQ0KPiA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+IOaKhOmAgTogVG9tIFJpbmkgPHRyaW5p
QGtvbnN1bGtvLmNvbT47IFN0ZWZhbm8gQmFiaWMgPHNiYWJpY0BkZW54LmRlPjsgRmFiaW8NCj4g
RXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPjsgZGwtdWJvb3QtaW14IDx1Ym9vdC1pbXhAbnhw
LmNvbT47IEx1a2Fzeg0KPiBNYWpld3NraSA8bHVrbWFAZGVueC5kZT47IFNlYW4gQW5kZXJzb24g
PHNlYW5nYTJAZ21haWwuY29tPjsgU2ltb24NCj4gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+OyBB
bHBlciBOZWJpIFlhc2FrIDxhbHBlcm5lYml5YXNha0BnbWFpbC5jb20+Ow0KPiB1LWJvb3RAbGlz
dHMuZGVueC5kZTsgdGhhcnZleUBnYXRld29ya3MuY29tOyBBbGljZSBHdW8NCj4gPGFsaWNlLmd1
b0BueHAuY29tPg0KPiDkuLvpopg6IFJlOiDlm57lpI06IOWbnuWkjTog5Zue5aSNOiDlm57lpI06
IFtQQVRDSCB2NCAwNC8yMF0gZmlybXdhcmU6IHNjbWk6IGFkZCBwaW4NCj4gY29udHJvbCBwcm90
b2NvbCBzdXBwb3J0IHRvIFNDTUkgYWdlbnQNCj4gDQo+IE9uIDMvNS8yNSAyOjM2IFBNLCBBbGlj
ZSBHdW8gKE9TUykgd3JvdGU6DQo+IA0KPiBIZWxsbyBBbGljZSwNCj4gDQo+ID4+IC0gQmFzaWNh
bGx5IGR1cGxpY2F0ZSB0aGUgbWVjaGFuaXNtIGluIDc5NDBhOTNlYjk3NyAoIm5ldDogcGh5Og0K
PiA+PiBJdGVyYXRlIG92ZXIgYm90aCByZWdpc3RlcmVkIFBIWXMgYW5kIHN0cnVjdCBwaHlfZHJp
dmVyIGxpbmtlciBsaXN0IiksIGNhbGwgaXQNCj4gZS5nLg0KPiA+PiBVX0JPT1RfU0NNSV9EUklW
RVIoKQ0KPiA+PiAtIFN3aXRjaCBTQ01JIGRyaXZlcnMgdG8gdXNlIFVfQk9PVF9TQ01JX0RSSVZF
UiAsIGhhdmUgZWFjaCBvbmUgbGlzdA0KPiA+PiBhIHByb3RvY29sIElEIChpbnN0ZWFkIG9mIHRo
ZSBQSFkgSURzKSwgYW5kIHRoZW4gdXNlIHRoZQ0KPiA+PiBzY21pX2FnZW50LXVjbGFzcy5jIHRv
IGl0ZXJhdGUgb3ZlciBhbGwgdGhlIGxpbmtlciBsaXN0cw0KPiA+Pg0KPiA+PiBBYm91dCB0aGUg
TVg5NSBzcGVjaWZpY3MgYW5kIGhhbmRsaW5nIHRob3NlLCBpdCBpcyBwb3NzaWJsZSB0byBoYXZl
DQo+ID4+IHR3byBkcml2ZXJzIHdoaWNoIHN1cHBvcnQgdGhlIHNhbWUgaGFyZHdhcmUgY29tcGls
ZWQgaW50byBVLUJvb3QgYW5kDQo+ID4+IGhhdmUgdGhlbSBkZWNpZGUgYXQgYmluZCB0aW1lIHdo
aWNoIGRyaXZlciBzaG91bGQgYmluZCBhbmQgd2hpY2ggbm90LA0KPiA+PiBsb29rIGF0IGRyaXZl
cnMvbXRkL3JlbmVzYXNfcnBjX2hmLmMgcnBjX2hmX3Byb2JlKCkgYW5kDQo+ID4+IGRyaXZlcnMv
c3BpL3JlbmVzYXNfcnBjX3NwaS5jDQo+ID4+IHJwY19zcGlfYmluZCgpIGZvciBleGFtcGxlIG9m
IGRvaW5nIHRoaXMuDQo+ID4+DQo+ID4+IEkgaG9wZSB0aGlzIGhlbHBzIHVudGFuZ2xlIHRoZSBT
Q01JIGltcGxlbWVudGF0aW9uLg0KPiA+DQo+ID4gVGhhbmsgeW91IGZvciBwcm92aWRpbmcgdGhl
IGV4YW1wbGUuIFBsZWFzZSByZXZpZXcgbXkgcGF0Y2ggc2V0Lg0KPiA+IGh0dHBzOi8vcGF0Y2h3
b3JrLm96bGFicy5vcmcvcHJvamVjdC91Ym9vdC9wYXRjaC8yMDI1MDMwNS1pbXg5NS12MS0yLTIN
Cj4gPiA4NmQxNWFjYmI4YUBvc3MubnhwLmNvbS8NCj4gPiBodHRwczovL3BhdGNod29yay5vemxh
YnMub3JnL3Byb2plY3QvdWJvb3QvcGF0Y2gvMjAyNTAzMDUtaW14OTUtdjEtMy0yDQo+ID4gODZk
MTVhY2JiOGFAb3NzLm54cC5jb20vDQo+IA0KPiBJIHdpbGwgdHJ5IHRvIHJldmlldyB0aGlzIHRo
aXMgd2VlaywgSSBhcG9sb2dpemUgZm9yIHRoZSBkZWxheWVkIHJlcGxpZXMuDQoNCkhpIE1hcmVr
LA0KDQpBcmUgeW91IGF2YWlsYWJsZSB0aGlzIHdlZWsgdG8gcmV2aWV3PyDwn5iKDQoNCkJlc3Qg
UmVnYXJkcywNCkFsaWNlIEd1bw0K
