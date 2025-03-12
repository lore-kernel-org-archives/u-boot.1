Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1084AC28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 08:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EE52817D3;
	Wed, 12 Mar 2025 09:38:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wxCLb9DH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8816481335; Wed, 12 Mar 2025 09:38:09 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::613])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47026811C1
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 09:38:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSQFC7mufWvLUea5rOpcwM68f7isR7ab7OBoAI4mYvdmLaWEo6xlv6TMkhGjrWsKr3KE09vIPwcwyASk5aq7OW2ddd+r5OtprwUKHz+80m4pAub1x2uXmhEsF9vkpw6HYfzLB5Vhpg5IB2jZm21zh3fPobJcIcmFjPqHbZU4PMJwILOKn3Tjkwp6VFYnjc2QcPuk66a1Cobd4+A4JuCZYedk91MkrngaDTGaiMxoJwPnivkPiXFXgQoE+PHhpBAEG3E/QKhjsT271NVM4W431GFLypRjBXTXyS4zb908RxDcy7IaH3LSoxAbU7rUhvS1O1LXzIF3TjaNBbYlJCGatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgzOSzqly/wG47bRhIPG+e59Qohl2fnNYswWAXGQnGc=;
 b=jWMogNCFyNcW9Hm34p8Ap52G6IDPcpnwsOaP9pPHxDuBeYBS4aiBvjlXW0qDh8YIizQsAGdONzeSWDiweymNhtnmICYfvie4HDh3Fl6+0HJbRUngYaMNDHvlWtn1D1gArcji/VwEmUbGI5FqiHAKc/DB68kxLjjWlTKgevmpk9OWpY0M7NKUOCYG2HJ0N4G/AC5CdBTILX4uLRHVtWaVV/WH2YsbAWoT60SlgvzGqTG0TOGL8d9iyPRBZBcRXvzNx9sx0mwL+HnbWwRZS7Q3jW8/UKJLx5QWEq29k4+yzexNMyGhnu+2httqIFYDZ99B5yXV2gRwZNwDiR18LAHlTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgzOSzqly/wG47bRhIPG+e59Qohl2fnNYswWAXGQnGc=;
 b=wxCLb9DHmBWCdftpw/BNnhls1ACnHaVJRO+cCmBv8FVvqAXiHETog7uhaJUmZNW/QlfrjPSev46Ff48ct56mwns85dpAH5kEEjRqttxNCLrYGGAuQRpPCiy+uznqW0sr5UfLrzgirCd8z+xvgTN5isr6SZE6ypY7WnvYr+ebgGFIqSRqW3T7Cp+huapWq1c7hdjMY2fHvk2FFmzsyw8vGLdia2AJXcBjykshYV8KhS1uiqoexfLxlU1kNjlfwHUbOFOGUWu0C85zkMNuw6dOYoH6Cdz0/9DcygWjGyE05UyTywvAYaTYbm8hpl+PoTwRIj9as0ubLmunjuDEbHLLDQ==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10752.eurprd04.prod.outlook.com (2603:10a6:150:203::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 08:38:04 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 08:38:04 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "sbabic@denx.de" <sbabic@denx.de>, 
 "festevam@gmail.com" <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 "lukma@denx.de" <lukma@denx.de>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "alpernebiyasak@gmail.com"
 <alpernebiyasak@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Peng Fan
 <peng.fan@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, Ye Li
 <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjJdIG1haWxib3g6IGFkZCBpLk1YIE1lc3NhZ2lu?=
 =?utf-8?Q?g_Unit_(MU)_driver?=
Thread-Topic: [PATCH v2] mailbox: add i.MX Messaging Unit (MU) driver
Thread-Index: AQHbjNLRPmm0L66O/0614amIdbADSbNriNIAgABzHeA=
Date: Wed, 12 Mar 2025 08:38:04 +0000
Message-ID: <PAXPR04MB9644F55A72EE2E676C53A21EE2D02@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250304065740.2732356-1-alice.guo@oss.nxp.com>
 <aa93e408-ad8b-4ac9-b853-05cc8ca190a2@denx.de>
In-Reply-To: <aa93e408-ad8b-4ac9-b853-05cc8ca190a2@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|GV1PR04MB10752:EE_
x-ms-office365-filtering-correlation-id: ad0a05f2-f036-44d2-745a-08dd614134f6
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?dWw1R2FUU1RPWUduN29kVDMrZHBjZ1kydWJnYXVzZFVNbndlNnAwUlNLaCtx?=
 =?utf-8?B?YzZ2ZkJhdm5WeEtGWHhXOE5FNXFOYVVaVFVZZTd0VUt5ZjhGc1lZdFNFeHdN?=
 =?utf-8?B?TzR5UHQ5MHMvZ1BWOWptUzlMZU5TakUzVi9GNWlsMnVPdGNvRHZCY2h2L09v?=
 =?utf-8?B?dGtEM1JyQnFadkpKeGVhSGNla0hueHpPR3pNTytrbXlBRjVWU3d4WnJYa3hR?=
 =?utf-8?B?bHcybHluREg3WEtWRU56Smo3WFZqZHE3OG01K3NIcjNDdVBBaFZ1U1MrTnBp?=
 =?utf-8?B?TWNqc2dzQXpRZnFrVVlEc21LUHpYczhmbzRyZFNkeHFoU0dvWDYrcUJiRkg0?=
 =?utf-8?B?UXhCT2VFOTFuWTBlbUl1UXByYk1sMHpMSGZDRUcxaW9uVWpITHdtUWxlWXJa?=
 =?utf-8?B?NVZZcEl1TG1NNWo1YStKckx4SjNSelVaVk1JVFpFMW1hcHBGanQ5Yk03U1A0?=
 =?utf-8?B?T3NTaGpvMS9nbldsYTNlUDJieG5TR29DU24raFZ0YXpQRU9PNzlKZmNWNkNO?=
 =?utf-8?B?bTVUUFllKyt0Q0xDckhGTW5WTUViNUxnQk4vb1NWcVY2K0t2dFZYQm4xMjQ4?=
 =?utf-8?B?QjNkcklMbCtiR3ZyalhqS0ZKZnlHU2dDYnNCdGNVYVVoTTZCRzVZUG5lMEZE?=
 =?utf-8?B?VUNsMUR5ZmFubWZmVGN0djRQV1BQbXpCb0V0ZktVdExEcG56eldIcFJ0WHRl?=
 =?utf-8?B?MmdhblNGNi9uYk9qRVplVE42RlBHeFAzV2JaV1RSQi9mWWNpdDhLK3J5aEUw?=
 =?utf-8?B?bHpwTGVBbEd1bTNjVEQ0ajlVd2N3NXRPNWdvR2g4T2xwZFkxT2hEOTEvUzc0?=
 =?utf-8?B?Znozd2p4N3FhNE95VHRIZ2pyYXJOTDMybE1wc3BIUU9iSEZhYzg4QnJiTjg1?=
 =?utf-8?B?ZE1IZVM4RUNCSU5VOEJxREJYaCtwd3FJSFVjRXhHVFFZdlFTNit6UlYrM2lz?=
 =?utf-8?B?aHFjRzJOeFJQZ0R3dytyc251Skt0a2J0alIvRzB5dXhxMkE3WVBMT2w1NWVB?=
 =?utf-8?B?bWVvaFl0ODFqMXEvdWkyNmIyRzNOWEhxa0NCVGZvWUtXcVFZQmRtMmZpU2VV?=
 =?utf-8?B?aTMreHZvRlg3dXpJMnZ1VmFrOEJoMEl1R2dMNTZpcUtsVlJxVFZGZXEzOGth?=
 =?utf-8?B?eHRjYldmeUcyZS9rQ1VTSVRXN3lpRHlIdFdLSzFCakc1bG9PcmJkTnFUbm0r?=
 =?utf-8?B?b0s0dzFLUXN6YXlkeThlSGRYb1hYODV0TEpNUTBmZFp2dFBzQ1d1MktYS21h?=
 =?utf-8?B?anFKdElseGRvU0NWWTlXZ0hZbk1kUXFYcTVyNGQzSXdWMllQK2p6VDNtN3Yy?=
 =?utf-8?B?eG5qNXNIUmwvTDRmSnlPNk43azBBa0JkSXFzOFl1bzhtMXNnSWIrVGlxL21U?=
 =?utf-8?B?ak90dHhzaGZ6K3h1bFNBZzdqUW9ITitXZ0plYm5lTUNOZ0R0RGZObEtlemtj?=
 =?utf-8?B?SHA2ZUpwSWlwS3o1Mm5McHMwdFpmWGJ6b2tBZkZPbzcwd0QzZ2l6UWU5dEpL?=
 =?utf-8?B?U1ZvekE3Q1pIOGFOTzhwVlh1a3hsVG1CZVlWUmFpYm9USmF1SzlpanpiVzdh?=
 =?utf-8?B?UitjZkx1TmZud3c0MlhXbE5Wc0FXbmpvcUlUbVlnRUs5NGlpTWtkc1hVeE9X?=
 =?utf-8?B?YWsxQlBWWTNVdEE0S21ZMDFUd1pJMlk5VTFLV0Z0T0Vma2Y1RXdtRmhmWnVM?=
 =?utf-8?B?Y3dSRTltb0NpTXluSFFad0hMb0N2Q3djcTVyN0RxMHE0d2l1bGJNMG5ZOTRr?=
 =?utf-8?B?UGEwWTV6QU84bHAwSFVZeVo5aEthNHhQS3VqODBUT2J0NVdRLzlZMXIyNDlp?=
 =?utf-8?B?SzBQZFpvak8vL3hOS0VDK3dRK2lPdXJCNmZ3bVJpbXg5MkxTWXdSNDVXc2tt?=
 =?utf-8?B?Z3dEVGhMc2wrMTdKL2pYRWVjam1xWTkwbHhTZGVwMXpDenZJRnhrMXRSSkcv?=
 =?utf-8?B?dkYwNW9xYlpuK29aa0tCQ2UwQTUwWVNNRUVka3VEcWk2clIvQU96amtob1RS?=
 =?utf-8?B?MUVkSjZYSDJnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmJZZzBIYzljY2haNUhidXNGSzZ5bGVORUhKc3VYOFdUa3U1VmpTYUw2S2Fq?=
 =?utf-8?B?ZzRySmhwbGdVekgza2hNbXZUTlptMGdaUHJJU2M2bGNKTEY4cm9TZGJ4ckh6?=
 =?utf-8?B?d0RlQ29mbEgxRXB4djJBaW5aZExja0E0S3J4UHlTSVh1REIyZVVjckJiamxm?=
 =?utf-8?B?Qm5Dckw1bXVJUXZZajdYa3FiOElGVnJYbjJEa2RSOWFnbHNNS2hBUDlyQThH?=
 =?utf-8?B?WFplUzdid0EyVjRyRklpUUI3MkY4a3JmdHh3ZU04UTF0RUs3aWtQSFArRitF?=
 =?utf-8?B?c2N4NzFlQWFhcXFlZFFjNE5keUhhaWZyZzBWdG9IdGJicmZQZXpKMG5GcXNj?=
 =?utf-8?B?Q1p4U04rcFh3UUxISmNrSDNZNi9tVk9nbWdLYkdSYkFzbTVuRlhPdjFtRVRF?=
 =?utf-8?B?M2krUEZaTnM4MlJjUG5iaExFZk1ZSFIvUXBkNHdWWWNDMzNHcVBhZDRSckRF?=
 =?utf-8?B?SGJsOENTNUtnZmorNnVYWGYyVzVLZGl6TFNzMys2WlRpQ3lJVG1vTE9ZYWtv?=
 =?utf-8?B?eVlyUTd4ckZDWTlLempmYkQ3a1owOEJpVDNXSTNzVVZjczBTUnQ1WCtEUkZJ?=
 =?utf-8?B?WlF1eElaOU5pMVRlMkVVZjVyV3A1MXlaVk9yNDJJditnaWJIanl6K1dWZXA4?=
 =?utf-8?B?dmJSdXNqVjJLTFZpclVEeTAzZ1hTYzB3VUs5VWlHVFowZzMxdUZvNzgvZXhl?=
 =?utf-8?B?N3NUNENCK0EyeEVVM3BSQkZQSjNOcTIwNTZpcXl1UVZJeG9xWW9nbFR1cktJ?=
 =?utf-8?B?Z0hHa0pmdlQ5KzFBMU5PNkVSUjBQSlJMTWFlV2JHZVN4dFNCSkpPb3ZMUXE1?=
 =?utf-8?B?R05JM216T2lTMU9VN3dhY3htMW41aUIxeE9tMjhSMk96cDQvNUE4elRYTXFk?=
 =?utf-8?B?MzgydU9EVHVYczYwaDYrakkvNmJCSXArNnN6YzVBQWJxc2tNRCsySzNCeWl0?=
 =?utf-8?B?TnU1SDc0QlBNR0ZRUW1tSW9lN2k3dGlQN092Y05DTHRwL1pCZTk3MzZRWkYr?=
 =?utf-8?B?bktSRWdUTjdHdFdrazZxMmV6N0JaOHRuZUlkZjZLK1pxSXBJQWZLNVpid3Rp?=
 =?utf-8?B?VWx0c2pEV2R0R0pJamp3SDVabFYxdTVYaVVRMGRCZ0QyOXR0WW9McUZtWmNK?=
 =?utf-8?B?QmZaWm1NKy9nRGMzcy9LU21rQmFTNnI2b05TQjJjdXZOWEFQcFA2b2dXRXRP?=
 =?utf-8?B?M00vaFVzQmxIYU9sT0xVcGhaWDUxclRqMGMxOTYzRC9ybk5RRFF2UDMrZmxz?=
 =?utf-8?B?YnI4bFBOc3QyL3crL3dER0dGdHNoUlB6MTlhSEVOa2FuWEtYL01IbkRIcDFi?=
 =?utf-8?B?U1hSYXBJMkR2M0lkWFkwazBSK3N2U1FiOVBZazZLdnZYM2ZkU2x5VkROYXJw?=
 =?utf-8?B?K2NBTE51M3FNTEs2bWxnQVoydkxTY1VJaUNyRmFCZkNieWg0dnJtMHE1Qm9n?=
 =?utf-8?B?dkpkNjVWTUV2OVFDRXZXVStTb1FCM2FCRTJWdW16RHpnVDV6Ky9ra21OVEF6?=
 =?utf-8?B?ZXNzODkwTkw0M1JrUjJDOU55ZXVOVjFZQ2NjRnlmZHB5d0pkVWJBZDFxRW5s?=
 =?utf-8?B?b25nYXRtWWhxRXVpMXFwL3dKQi9IYmRrNVAzVGt0OGVEUzFWdng1MzlOUkFJ?=
 =?utf-8?B?RUw4RTRPeGVPSUxZZ0lEUkM1ME1lYmFsM1liakNPU3ZrUUVSU0NMMWRxREVo?=
 =?utf-8?B?N0owcTdVcnBxQTY0QktZSXlxWnVzS0xmUDZSTTRIVU42bmh0QVRuUnVlT3lY?=
 =?utf-8?B?ZU50MzJPbkRoUko5cmh1WTFpaVh2SnZBNlVwbERGakJTK1VvLzVOYzFiR0p2?=
 =?utf-8?B?RWMrUnBaUUJiT3BPNU5yZ1c1N3FTSWRjQjNWUGFCR2xIMmNlRktqTXdyNVg3?=
 =?utf-8?B?QXRMTGkwdTgvT084Ti9ZL0J4WGxKVlllSkVNMGJqNkdOUXdQU0NubjU0NU9X?=
 =?utf-8?B?TlY4VUtad2xlNU1UVFFtVmhVaUpLZ1dyWFFQK0FYZFVndDNKblErRWpOUStw?=
 =?utf-8?B?aDMvK1ZxcUdsbW9TaGVmRE9CdXRDeTlkTUEzZkNJS1lSWFptSU5STlhWYVY3?=
 =?utf-8?B?ckovWUg2Uk5oVDJzM2NPZmJaNUd0dThWZ3lPVWxYNEJ5L3NnVnFKWVpxNEhV?=
 =?utf-8?Q?CR1s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0a05f2-f036-44d2-745a-08dd614134f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 08:38:04.5463 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vnlBCq5ZR0ytkbQkQjN9X68oLAzK6OvZfLED13I2tVO909LQyqf16CoELSOxwqKtSSgaMWoxrU+GpcwrY9nQYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10752
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
QGRlbnguZGU+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDPmnIgxMOaXpSA4OjEzDQo+IOaUtuS7
tuS6ujogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+OyB0cmluaUBrb25z
dWxrby5jb207DQo+IHNiYWJpY0BkZW54LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLXVib290
LWlteCA8dWJvb3QtaW14QG54cC5jb20+Ow0KPiBsdWttYUBkZW54LmRlOyBzZWFuZ2EyQGdtYWls
LmNvbTsgc2pnQGNocm9taXVtLm9yZzsNCj4gYWxwZXJuZWJpeWFzYWtAZ21haWwuY29tDQo+IOaK
hOmAgTogdS1ib290QGxpc3RzLmRlbnguZGU7IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPjsg
VmlvcmVsIFN1bWFuDQo+IDx2aW9yZWwuc3VtYW5AbnhwLmNvbT47IFllIExpIDx5ZS5saUBueHAu
Y29tPg0KPiDkuLvpopg6IFJlOiBbUEFUQ0ggdjJdIG1haWxib3g6IGFkZCBpLk1YIE1lc3NhZ2lu
ZyBVbml0IChNVSkgZHJpdmVyDQo+IA0KPiBPbiAzLzQvMjUgNzo1NyBBTSwgQWxpY2UgR3VvIChP
U1MpIHdyb3RlOg0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+
ID4gVGhpcyBwYXRjaCBwcm92aWRlcyBhIGRyaXZlciBmb3IgaS5NWCBNZXNzYWdpbmcgVW5pdCAo
TVUpIHVzaW5nIHRoZQ0KPiA+IGNvbW1vbSBtYWlsYm94IGZyYW1ld29yay4NCj4gPg0KPiA+IFRo
aXMgaXMgcG9ydGVkIGZyb20gTGludXggKHY2LjEyLjgpIGRyaXZlcg0KPiA+IGRyaXZlcnMvbWFp
bGJveC9pbXgtbWFpbGJveC5jLiBJdHMgY29tbWl0IFNIQSBpczoNCj4gPiAzOWQ3ZDYxNzdmMGMg
KCJtYWlsYm94OiBpbXg6IHVzZSBkZXZpY2UgbmFtZSBpbiBpbnRlcnJ1cHQgbmFtZSIpDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBWaW9yZWwgU3VtYW4gPHZpb3JlbC5zdW1hbkBueHAuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6
IFllIExpIDx5ZS5saUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+DQo+ID4gQ2hhbmdlcyBmb3IgdjI6
DQo+ID4gICAtIHJlbW92ZSBzdXBwb3J0IGZvciBpLk1YOFVMUA0KPiBXaHkgPw0KDQpUaGUgY29t
cGF0aWJsZSAiZnNsLGlteDh1bHAtbXUiIGhhcyBiZWVuIHVzZWQgaW4gZHJpdmVycy9taXNjL2lt
eF9lbGUvZWxlX211LmMuIEN1cnJlbnRseSwgdGhlIE1VIGZvciBpLk1YOFVMUCBpcyBub3QgdXNl
ZCBpbiBVLUJvb3QsIHNvIEkgZG8gbm90IGFkZCBpdC4NCg==
