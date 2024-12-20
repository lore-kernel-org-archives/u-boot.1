Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE26DE77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 02:56:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 408E6803CF;
	Fri, 20 Dec 2024 03:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TypEKfsC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D892803C8; Fri, 20 Dec 2024 03:55:38 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF18B80362
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 03:55:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8Ad1Nx7Jt2Y27r36FH3NqGUxUOz4GfP3JC4my+OX0dAg90AU7ojI3fNbCPQJddgy0el/9ymtT+ZHfBj3c90gGhBzkjNlpz0gIgbG89Ms0j/OlzAOjrzhQuF9aTogXgeujQTf3YyQHvE61se0fXVkKxOHQCBv2RjJwORbIpGAnmEFHqVZAjo0XDeOzdvmR0HRSbBDVPvnQXq3EgDN5OGR1paRakz4I3z28vLaW6aCJnizUIzQS/b9kx9yVxoPSRKO10QHEX3dnIPitm/DyBEyzmxn3xFThI8k2n11/IUPX6d92J8ZnqmV31QAJLVG+ZbVNSMLNVrHB8xuw77Weu1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MS3FQrglmlIIOXSWKidzBPPpD7jwkCWloNfpfFlYrMs=;
 b=Py4jG+B+1kweUOHvId8wzRPsLg/ZW4rAe3WoXzIWTWrwJlJ/1W47K7mD35eVuKQjpNHZzFQ856OnvjPl9UAxdwrywB4uV+3MG6XExdaTVeNx1nREiYzjHlvHbGvwtTskSfS9F59xotfh3llo93g8u0bFlTNOe2E9hpm1YhWju0V/WNQbAGKN4ynZi4qkTJtJotuyghehYDDsgA7BiliPX91lNwaOlqS3GOqSIi03bQVxLB3KXH22umx0M1PEXecvukIJn1LpOSaWSsPqwjgqYAkF/BfKsv2iPblaWgCVNbj/rH4WDcCGg2m01SpL/OIUMd/gZsE+6t0aadwyNLpB/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MS3FQrglmlIIOXSWKidzBPPpD7jwkCWloNfpfFlYrMs=;
 b=TypEKfsC5eKz63a2OAwNMxBasRDbqBwGpj66b3OM162GYFW4Usz2Y/xNscqKzM6auFsRA/RusYQ2Yp2u0kg/ScYeKf4vYnUobD1SVO8cmoPGKZOc8L5hFerwxLJgfiDC2bVz+nT2it6nV10UU7Ms7WY61BH+z5ePFdpwDPv4X7rtXIVWojbdBKjopd+zmNyHpydio/seFntuJsnOQXNXuenH3dH5+e4GGjDJQfuL71QE3jDYiqwo9kinF7tqAdg4gfIolRjUa1SWGyAGsqVhH0Zo7fBzN+0D+MSnZOn4LqoXM1hAQcKj4w/mnyX42syGdl5p98Zz4mYuzT3N740dNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB10981.eurprd04.prod.outlook.com (2603:10a6:10:58d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 02:55:33 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8251.015; Fri, 20 Dec 2024
 02:55:33 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 20 Dec 2024 10:55:05 +0800
Subject: [PATCH v2 07/17] clk: scmi: check the clock state/parent/rate
 control permissions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-imx95-v1-7-ba81dfd8e369@oss.nxp.com>
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
In-Reply-To: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, marex@denx.de, Alice Guo <alice.guo@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734663311; l=13550;
 i=alice.guo@oss.nxp.com; s=20241220; h=from:subject:message-id;
 bh=KeWcgZbKMlwbK8Z6dPRlj9vEkWz5zfsSvsI9anD4Y5M=;
 b=5KNFg80p3yfxuUk0XDQX3kkKtpL7axJCLrwFxSvZZoJwkT2Sli0K3wg7bYNMbKZhZ/Dyesmga
 ZjbGjbkrQ+rCgoLGaw4dnwdc92kQxT69sPtBNCNUuWpn6G0mx9jgW1P
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=I4wA8H8Q53tsp7q3voqI5LHsTQDw4TELC8szgsg5azM=
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB10981:EE_
X-MS-Office365-Filtering-Correlation-Id: dca72b21-1c9c-48b2-2d15-08dd20a1c54c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWhwTGptTGlRL1BTMm1YRmVjWk8xUWhqWndTMm12b2tBK3RvNm90UWRRSTRM?=
 =?utf-8?B?VW52N1U4OHlRVzRRYW9NZ0w2TCtKYVRYMlZEWVZjbzBxWG5KdkpROVNsQ2ZO?=
 =?utf-8?B?QWFZYzIrMG1KMTFCZ0ZmUjZFODJJV2RFNnJJZkY1aWFrMndsdU8vVHVMd09O?=
 =?utf-8?B?S3hLVnoxZjZWWldjV1dsbHdFTmdPODJOdmZscVF2NXNSdWVhbnAvSWMyRTN5?=
 =?utf-8?B?ZklSOXlvTWZIaDRlVDdtYzR4dnpjanFqTXFFbThmb3VhM3FTajh5Q2F2Q2xX?=
 =?utf-8?B?c0dLZVhTV00zOHVyQkVnNEYvdnRlbnJMaTJQZ0Z6bk0vVEY1MDA3dXBvUkkz?=
 =?utf-8?B?a2lVdGFSVEJCamtWc3Ayb01nNmlibkFLTnJvdnk0TnVsYXBtMGVGZFNjcy9M?=
 =?utf-8?B?N1JlWTVJQXIrNmpORFVDdFkvTHBieDE5YmJYWHN1Nkp2SEhXMW43cGJVRjc2?=
 =?utf-8?B?azBkV3hiY2kzVEdweVBGTkdzUXhaM0M5Ukc5M1BXY3JOOHVRdHVnMFRjRHFa?=
 =?utf-8?B?TGhMK1J5RFJlOWdtelZCSlBaQTFDNWdzQU9oWVhVVHROR1Z6aDNNYmtxWklu?=
 =?utf-8?B?NC84bFdidXNwdHBicjNWSmVMK2F5cmozUnNBajFueVkxZmxBdGU3VzBqUTBm?=
 =?utf-8?B?b3k2bFBYMnFKaVBQbVpBL1l5Q3FyNnUxN0hnUWh2anlsWXZTRmhYd1ZvdlI1?=
 =?utf-8?B?TUdKOFlJVGhOV0hxcGVlalFrK0xaWmdBV3dJSVdETXV6N1g3UE13Q1NlZzE0?=
 =?utf-8?B?azhoSHBQNnA1SmNJZ2s2MWw5QS9UUm42R2tYeHNGMktZM0c3VWg4Zkgvb3pK?=
 =?utf-8?B?bUxtbDdRelpxaHZGVkdwdFBNVTY0MG0vb0I2R1Nocm5NMmtidTgxTmZJMXFq?=
 =?utf-8?B?QjlmQlVlZGdOcXUzWkJ2byttcjlzRHdaQk94STJvSTEvUDMrbU5yVm9TbHpu?=
 =?utf-8?B?ZlZSLy90Q2tQUjRvanMvZDlpUElnSkhDbm5qKzVtN2hQZ2RidEN3Tkx4eGRG?=
 =?utf-8?B?OHZtN0t3cHVwVm9Pc1VJZlJhdW9tNHJmQTFsK1BkTG1PSzlXbzJwNVVlc2VS?=
 =?utf-8?B?NGR0cjdOQ1VubHhLdEVaSWVxVTdyZnJkL3psTUFaSjcrVEwxZkwzaVFlRnpM?=
 =?utf-8?B?T3l5YWVxWW5TS2U0N1NGRVVLMWtPLzNmYlphZ2FxQmNLK01pU3BZaGdkK2g4?=
 =?utf-8?B?cUtuN0NXbDQ1RmJhaVkwRWxqZE8rRUhSQUZ1NjJxV3dyclRUVWFDZ3Jsa2tm?=
 =?utf-8?B?UGJhYWpsdmV6MlZDR0tiZG04MWhMZVRKOTB4TmlySlpWSUxoVTAvTjVEZGFN?=
 =?utf-8?B?eVFvTEVLMFFBQ29BMUI4RWJQcElEaUxENytQK0wrVk9IZVBoNVplODdiZ1JZ?=
 =?utf-8?B?VnBVcDlWWnc3Z2Q4Z1VGNW9ubS94MUhHWHd5VVFBelNCT1dSMFdwL1pmMEE1?=
 =?utf-8?B?QkpIZ1hwWXc0eEVKd3lYblI0WjFONGRiYWdQT0pFOE54cXM5ci9vWjBwQURO?=
 =?utf-8?B?ZVVwNytOOHh6STZ3dWhJaU9EMU1HNldUblMxVkxJRnpMWTl3anJ2R3d3UHRB?=
 =?utf-8?B?cndDK3dtR0ZYRVd1Q3ZNaGY4a01CYkcwcFVVMzdrTk5lTDBRSk5JdWlScm1O?=
 =?utf-8?B?R0t4VDY0eE1PNVVaTHcxZW9MSjUzK1B2V3c5VUh4WEdQbXNuWGF0dnN1K2xG?=
 =?utf-8?B?K1ZtZ3h1TkpzaW1kS1VqUFg0Wk1Xc2kxandwWkNmLzJ0RXBJMytsTDNFSWs0?=
 =?utf-8?B?UTA1alFFdGFkb3grNHM2a0hNUzRKNmxDc2k3Mkc1TlVOTlJDMDRzcXJPcDky?=
 =?utf-8?B?bU5zRE03d1lhYUhMbDNNSHhEU1VIa0pGdll2dHNwWnFaeFphUm42RG90Z0hC?=
 =?utf-8?B?cXdNWUhEaGloZGFSSnIwaW1IRlA3WXBNNTM0Ylp4QXlQd2VOMm5RRnZrM3Nu?=
 =?utf-8?Q?r1VC+b4qyXXx9MvbmeMw9pHvNftf8R78?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHpIRnVwNnF0cnc4N29Ceklrd2ZkK3lJOUhjQ0VnQVg0NEE5UHJERzRVYTdp?=
 =?utf-8?B?MGJEV2xvSjNRNnpKbWhkQVBmbkpaM2tXMUduMXd5eHpnMWhlb2lzY0FNbmtT?=
 =?utf-8?B?VEVkQzVzU2s1R3luK3RyeTdOU3AzU0N0eVRYS3hJWVVDRU43eThOTVRqKzZG?=
 =?utf-8?B?MHJlVHU5NWNWNUxub0c0OE40Wi9NS1NhYm1EdmNCMjBYQS9pck5CZmdiQ2gz?=
 =?utf-8?B?WENJNXp3dW53L1BvM2o2V3dDZlQ1R2tqcm14WjZiMXhPNXNBKzhjOFlFcDFW?=
 =?utf-8?B?b0Vjb3NvWlBCdklmZDJZbUpPMVlhdEQ2Yjd2SHdtSU5hREl6UVBIL2FGTTA3?=
 =?utf-8?B?U2dSS1pHNXFpLzZjcXFqcWwyTDdhS1NFNURxOUNjU2ttRGpJS0RIRWpQSjY3?=
 =?utf-8?B?MFprTVdkemdnMnlHUXBqY1JCaWhTR2F0Ymh2L1ZoakIyRnFmTnJBZUQxcTNY?=
 =?utf-8?B?TWhvc2Vpd3pHdVlycmpld1IwVzNudmZnQklPMTB2cTZnZlpoaFRMcWFxeUx4?=
 =?utf-8?B?N1k2T2tsbnFMWTJCOGxsSm9WMUJ4dDhSWkJIT2RtSllRajROZDBSTE1HcVNi?=
 =?utf-8?B?Ulc4S0JZdTE0cFdNSUlzNVBsWlZxdlNYRExtY1c4N0NJcHVQY2p6MVh6bHpC?=
 =?utf-8?B?S3VnY1ZxVjdNOFNLM1M1R0M2VDVNU3FYdjNidENFU1JkTkZhMk9rdE5mOS9v?=
 =?utf-8?B?SW1ibS84VFNtcmttWTRHTE15NnhFZDBLdCtTYjNqRSt6a2VxYjNuOVlSQ0pD?=
 =?utf-8?B?VlgyNk0vL1pyb0R4M2RPTnArYVNDbkZGdlhUYXhpMkdFSjZkRHlUejRCZXBh?=
 =?utf-8?B?YmMxcjN5VkVWRTJwbmRYV0N6bWtOL2Uxeit0UTJ4amNvNHEva1hGSDk3ajlF?=
 =?utf-8?B?MEpZdmVSaUZxSDd6TVI3T1pwM3RaSzVVMW5BZ3kwTnNIci93Ly9kR1FOMFVZ?=
 =?utf-8?B?Z0pZZllGVjFGOTBDbjk5VEVRNDhpemx1clZEczIrbHZ6cURWMkpLZUhsaTVa?=
 =?utf-8?B?ZlNHdFJDbHUxa0ZaQUMxM1QwSDl6WWlGYStuZlRURVVHcWFBcmFIb0xwM2lt?=
 =?utf-8?B?ck5zaklKckF3aFRnVzZ2eFprRkRGdUErb3NZT3BpR2UzNFYrY0xlZFVXelJo?=
 =?utf-8?B?MjdrV2pBT3dnWThvZS9kS2JFaUY1Q1Q1SzdQSkRQM2hya0Y5MndXQmRKcUZX?=
 =?utf-8?B?cEQranZ1VWFITUw4bkNhbExXT1ZWZmpUcE9NUWtFc1I1Z1BwVTdZNXBMWTdV?=
 =?utf-8?B?LzkreEpzS29wZzNiWE01UFpqT2htdmZJWUR3V0tpTFkzUGo5eXdjcVN3aVF3?=
 =?utf-8?B?enl0RFVWVXZtQzVxZU9hR25DNnVWWWY0R1VpclQxeVdqcityY3NLclJQS0pw?=
 =?utf-8?B?RlkyYy9GL3J3VHo2QWhRdFVueVJicTRkQjlXN0JxVUVCSFRXRFdpNWs4WWp1?=
 =?utf-8?B?Q3dWN2R0R0hBUTFEbVZZU1ZGUVhhUWJ6Qk84Sm41QnNFaktXMUw0Rlg4SlJa?=
 =?utf-8?B?MmQ4UlJsN2pUcG5OKzBXbTRhQjZHVkdZOThSOFQvb0J0WEdJS0I5eDc4UnZC?=
 =?utf-8?B?aHUwTUxkK0dyNWxBK3ZWeGIxREo5aFdEYjRraXo1YytpZE1uSHpXcGg5RFRw?=
 =?utf-8?B?cVJ5L3ViRW1QQytzTjZDb3RET01YRURxREM2SHRMdm02TmJKaGpLdG9UTVli?=
 =?utf-8?B?eDQ2UWJaQnoxNlRYK1NqYUdqU0FtWTVhUVVFSjg3OFpPZ25IOXNLUmlqUDBX?=
 =?utf-8?B?NGw5c0s5VHpZYlVOM0x0dWIxaEtnSzhQSGFPeTA2UjRBNUNDcW93MlhycDhM?=
 =?utf-8?B?d2tVWTlOMHRFRVRvUUlXT3BITjhDQnNzM29TVjBZVWpEM0k5eDU2ZDYxSWFv?=
 =?utf-8?B?bUpObnJraDgxeGpsMzhxaXU0ZWx3WDA4TG5jaUF5V05mbTNGNE5mMStSZVM5?=
 =?utf-8?B?QUQ3b241TDhKL2lHanpCQWJxQW1UZWxPTkdubnlWSWpYVy9FZVNyeERMM0JG?=
 =?utf-8?B?MDN1bG5mZ2RJU1lNdFVuVzN4S2wyQXpMWFU0ODNveC9nU21zNXk1aytuYS9W?=
 =?utf-8?B?Q29JUjNTby9Hb2Q5czI5NDRYUEhQUUtYc0hDc2hZZWlRODcvcVVoZnlFc1Jo?=
 =?utf-8?Q?aWN6U6FPZQ/u8rrTVNPspIIH7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca72b21-1c9c-48b2-2d15-08dd20a1c54c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 02:55:32.9522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2z5XCNhkyyaEMC/kHOpEzvj568MLq86GxScbBwHkyli3qHAVSbtRQbsuyAFCs9R3oOFj1g78Q0Addw0YDdHkRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10981
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

From: Ye Li <ye.li@nxp.com>

SCMI clock management protocol driver in Linux checks clock state,
parent and rate control permissions. To be consistent with the kernel
driver, add this check here.

When using common clock framework (CCF), use the clock signal ID to get
the clock registered by clk_register() in scmi_clk_probe(), and then
obatin the struct clk_scmi variable with container_of().

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/sandbox/include/asm/scmi_test.h       |   2 +
 drivers/clk/clk_scmi.c                     | 173 +++++++++++++++++++++++++++--
 drivers/firmware/scmi/sandbox-scmi_agent.c |  56 +++++++++-
 include/scmi_protocols.h                   |  26 ++++-
 4 files changed, 243 insertions(+), 14 deletions(-)

diff --git a/arch/sandbox/include/asm/scmi_test.h b/arch/sandbox/include/asm/scmi_test.h
index 619f8f5098cdd82ba2343897166c34c82c753422..b30e536a35771ec3e1439c1e64fd09de3728dc50 100644
--- a/arch/sandbox/include/asm/scmi_test.h
+++ b/arch/sandbox/include/asm/scmi_test.h
@@ -27,10 +27,12 @@ struct sandbox_scmi_pwd {
  * @id:		Identifier of the clock used in the SCMI protocol
  * @enabled:	Clock state: true if enabled, false if disabled
  * @rate:	Clock rate in Hertz
+ * @perm:	Indicating state/parent/rate permission
  */
 struct sandbox_scmi_clk {
 	bool enabled;
 	ulong rate;
+	u32 perm;
 };
 
 /**
diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 84333cdd0ccfe566c269f776f39725c69883c25c..af15fa910480989bd21404c7cec516be737704b7 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -12,6 +12,56 @@
 #include <asm/types.h>
 #include <linux/clk-provider.h>
 
+struct clk_scmi {
+	struct clk clk;
+	u32 ctrl_flags;
+};
+
+static int scmi_clk_get_permissions(struct udevice *dev, int clkid, u32 *perm)
+{
+	u32 version;
+	int ret;
+
+	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK, &version);
+	if (ret) {
+		debug("get SCMI clock management protocol version failed\n");
+		return ret;
+	}
+
+	if (version >= CLOCK_PROTOCOL_VERSION_3_0) {
+		struct scmi_clk_get_permissions_in in = {
+			.clock_id = clkid,
+		};
+		struct scmi_clk_get_permissions_out out;
+		struct scmi_msg msg = {
+			.protocol_id = SCMI_PROTOCOL_ID_CLOCK,
+			.message_id = SCMI_CLOCK_GET_PERMISSIONS,
+			.in_msg = (u8 *)&in,
+			.in_msg_sz = sizeof(in),
+			.out_msg = (u8 *)&out,
+			.out_msg_sz = sizeof(out),
+		};
+
+		ret = devm_scmi_process_msg(dev, &msg);
+		if (ret) {
+			debug("get SCMI clock management protocol permissions failed\n");
+			return ret;
+		}
+
+		ret = scmi_to_linux_errno(out.status);
+		if (ret < 0) {
+			debug("the status code of getting permissions: %d\n", ret);
+			return ret;
+		}
+
+		*perm = out.permissions;
+		return 0;
+	}
+
+	debug("SCMI clock management protocol version is less than 3.0.\n");
+	return -1;
+}
+
 static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 {
 	struct scmi_clk_protocol_attr_out out;
@@ -32,7 +82,8 @@ static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 	return 0;
 }
 
-static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name)
+static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
+				 u32 *attr)
 {
 	struct scmi_clk_attribute_in in = {
 		.clock_id = clkid,
@@ -53,6 +104,7 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name)
 		return ret;
 
 	*name = strdup(out.clock_name);
+	*attr = out.attributes;
 
 	return 0;
 }
@@ -78,11 +130,49 @@ static int scmi_clk_gate(struct clk *clk, int enable)
 
 static int scmi_clk_enable(struct clk *clk)
 {
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (CONFIG_IS_ENABLED(CLK_CCF)) {
+		ret = clk_get_by_id(clk->id, &c);
+		if (ret)
+			return ret;
+
+		clkscmi = container_of(c, struct clk_scmi, clk);
+
+		if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
+			return scmi_clk_gate(clk, 1);
+
+		/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+		debug("SCMI CLOCK: the clock cannot be enabled by the agent.\n");
+		return 0;
+	}
+
 	return scmi_clk_gate(clk, 1);
 }
 
 static int scmi_clk_disable(struct clk *clk)
 {
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (CONFIG_IS_ENABLED(CLK_CCF)) {
+		ret = clk_get_by_id(clk->id, &c);
+		if (ret)
+			return ret;
+
+		clkscmi = container_of(c, struct clk_scmi, clk);
+
+		if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
+			return scmi_clk_gate(clk, 0);
+
+		/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+		debug("SCMI CLOCK: the clock cannot be disabled by the agent.\n");
+		return 0;
+	}
+
 	return scmi_clk_gate(clk, 0);
 }
 
@@ -108,7 +198,7 @@ static ulong scmi_clk_get_rate(struct clk *clk)
 	return (ulong)(((u64)out.rate_msb << 32) | out.rate_lsb);
 }
 
-static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
+static ulong __scmi_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct scmi_clk_rate_set_in in = {
 		.clock_id = clk->id,
@@ -133,9 +223,33 @@ static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
 	return scmi_clk_get_rate(clk);
 }
 
+static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
+{
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (CONFIG_IS_ENABLED(CLK_CCF)) {
+		ret = clk_get_by_id(clk->id, &c);
+		if (ret)
+			return ret;
+
+		clkscmi = container_of(c, struct clk_scmi, clk);
+
+		if (clkscmi->ctrl_flags & SUPPORT_CLK_RATE_CONTROL)
+			return __scmi_clk_set_rate(clk, rate);
+
+		/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+		debug("SCMI CLOCK: the clock rate cannot be changed by the agent.\n");
+		return 0;
+	}
+
+	return __scmi_clk_set_rate(clk, rate);
+}
+
 static int scmi_clk_probe(struct udevice *dev)
 {
-	struct clk *clk;
+	struct clk_scmi *clk_scmi;
 	size_t num_clocks, i;
 	int ret;
 
@@ -156,29 +270,44 @@ static int scmi_clk_probe(struct udevice *dev)
 
 	for (i = 0; i < num_clocks; i++) {
 		char *clock_name;
+		u32 attributes;
 
-		if (!scmi_clk_get_attibute(dev, i, &clock_name)) {
-			clk = kzalloc(sizeof(*clk), GFP_KERNEL);
-			if (!clk || !clock_name)
+		if (!scmi_clk_get_attibute(dev, i, &clock_name, &attributes)) {
+			clk_scmi = kzalloc(sizeof(*clk_scmi), GFP_KERNEL);
+			if (!clk_scmi || !clock_name)
 				ret = -ENOMEM;
 			else
-				ret = clk_register(clk, dev->driver->name,
+				ret = clk_register(&clk_scmi->clk, dev->driver->name,
 						   clock_name, dev->name);
 
 			if (ret) {
-				free(clk);
+				free(clk_scmi);
 				free(clock_name);
+				free(&attributes);
 				return ret;
 			}
 
-			clk_dm(i, clk);
+			clk_dm(i, &clk_scmi->clk);
+
+			if (CLK_HAS_RESTRICTIONS(attributes)) {
+				u32 perm;
+
+				ret = scmi_clk_get_permissions(dev, i, &perm);
+				if (ret < 0)
+					clk_scmi->ctrl_flags = 0;
+				else
+					clk_scmi->ctrl_flags = perm;
+			} else {
+				clk_scmi->ctrl_flags = SUPPORT_CLK_STAT_CONTROL | SUPPORT_CLK_PARENT_CONTROL |
+						       SUPPORT_CLK_RATE_CONTROL;
+			}
 		}
 	}
 
 	return 0;
 }
 
-static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+static int __scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct scmi_clk_parent_set_in in = {
 		.clock_id = clk->id,
@@ -197,6 +326,30 @@ static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 	return scmi_to_linux_errno(out.status);
 }
 
+static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (CONFIG_IS_ENABLED(CLK_CCF)) {
+		ret = clk_get_by_id(clk->id, &c);
+		if (ret)
+			return ret;
+
+		clkscmi = container_of(c, struct clk_scmi, clk);
+
+		if (clkscmi->ctrl_flags & SUPPORT_CLK_PARENT_CONTROL)
+			return __scmi_clk_set_parent(clk, parent);
+
+		/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+		debug("SCMI CLOCK: the clock's parent cannot be changed by the agent.\n");
+		return 0;
+	}
+
+	return -ENOTSUPP;
+}
+
 static const struct clk_ops scmi_clk_ops = {
 	.enable = scmi_clk_enable,
 	.disable = scmi_clk_disable,
diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 19be280ec44845369d1f46509978ec9b5b59c60b..74a87832dcb14d63550e450f4bea2632844199e9 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -80,9 +80,9 @@ static struct sandbox_scmi_pwd scmi_pwdom[] = {
 };
 
 static struct sandbox_scmi_clk scmi_clk[] = {
-	{ .rate = 333 },
-	{ .rate = 200 },
-	{ .rate = 1000 },
+	{ .rate = 333, .perm = 0xE0000000 },
+	{ .rate = 200, .perm = 0xE0000000 },
+	{ .rate = 1000, .perm = 0xE0000000 },
 };
 
 static struct sandbox_scmi_reset scmi_reset[] = {
@@ -700,6 +700,21 @@ static int sandbox_scmi_pwd_name_get(struct udevice *dev, struct scmi_msg *msg)
 
 /* Clock Protocol */
 
+static int sandbox_scmi_clock_protocol_version(struct udevice *dev,
+					       struct scmi_msg *msg)
+{
+	struct scmi_protocol_version_out *out = NULL;
+
+	if (!msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	out = (struct scmi_protocol_version_out *)msg->out_msg;
+	out->version = 0x30000;
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
 static int sandbox_scmi_clock_protocol_attribs(struct udevice *dev,
 					       struct scmi_msg *msg)
 {
@@ -740,6 +755,9 @@ static int sandbox_scmi_clock_attribs(struct udevice *dev, struct scmi_msg *msg)
 		if (clk_state->enabled)
 			out->attributes = 1;
 
+		/* Restricted clock */
+		out->attributes |= BIT(1);
+
 		ret = snprintf(out->clock_name, sizeof(out->clock_name),
 			       "clk%u", in->clock_id);
 		assert(ret > 0 && ret < sizeof(out->clock_name));
@@ -837,6 +855,34 @@ static int sandbox_scmi_clock_gate(struct udevice *dev, struct scmi_msg *msg)
 	return 0;
 }
 
+static int sandbox_scmi_clock_permissions_get(struct udevice *dev,
+					      struct scmi_msg *msg)
+{
+	struct scmi_clk_get_permissions_in *in = NULL;
+	struct scmi_clk_get_permissions_out *out = NULL;
+	struct sandbox_scmi_clk *clk_state = NULL;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(*in) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	in = (struct scmi_clk_get_permissions_in *)msg->in_msg;
+	out = (struct scmi_clk_get_permissions_out *)msg->out_msg;
+
+	clk_state = get_scmi_clk_state(in->clock_id);
+	if (!clk_state) {
+		dev_err(dev, "Unexpected clock ID %u\n", in->clock_id);
+
+		out->status = SCMI_NOT_FOUND;
+	} else {
+		out->permissions = clk_state->perm;
+
+		out->status = SCMI_SUCCESS;
+	}
+
+	return 0;
+}
+
 static int sandbox_scmi_rd_attribs(struct udevice *dev, struct scmi_msg *msg)
 {
 	struct scmi_rd_attr_in *in = NULL;
@@ -1193,6 +1239,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			return sandbox_proto_not_supported(msg);
 
 		switch (msg->message_id) {
+		case SCMI_PROTOCOL_VERSION:
+			return sandbox_scmi_clock_protocol_version(dev, msg);
 		case SCMI_PROTOCOL_ATTRIBUTES:
 			return sandbox_scmi_clock_protocol_attribs(dev, msg);
 		case SCMI_CLOCK_ATTRIBUTES:
@@ -1203,6 +1251,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			return sandbox_scmi_clock_rate_get(dev, msg);
 		case SCMI_CLOCK_CONFIG_SET:
 			return sandbox_scmi_clock_gate(dev, msg);
+		case SCMI_CLOCK_GET_PERMISSIONS:
+			return sandbox_scmi_clock_permissions_get(dev, msg);
 		default:
 			break;
 		}
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index d529f8e2697472e60d0cb9c275f34ef0ecaed3ca..9607433c3276f9aa18044c414a5bde3143726cf4 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -731,13 +731,15 @@ int scmi_pwd_name_get(struct udevice *dev, u32 domain_id, u8 **name);
 /*
  * SCMI Clock Protocol
  */
+#define CLOCK_PROTOCOL_VERSION_3_0	0x30000
 
 enum scmi_clock_message_id {
 	SCMI_CLOCK_ATTRIBUTES = 0x3,
 	SCMI_CLOCK_RATE_SET = 0x5,
 	SCMI_CLOCK_RATE_GET = 0x6,
 	SCMI_CLOCK_CONFIG_SET = 0x7,
-	SCMI_CLOCK_PARENT_SET = 0xD
+	SCMI_CLOCK_PARENT_SET = 0xD,
+	SCMI_CLOCK_GET_PERMISSIONS = 0xF
 };
 
 #define SCMI_CLK_PROTO_ATTR_COUNT_MASK	GENMASK(15, 0)
@@ -776,6 +778,7 @@ struct scmi_clk_attribute_in {
 struct scmi_clk_attribute_out {
 	s32 status;
 	u32 attributes;
+#define CLK_HAS_RESTRICTIONS(x)	((x) & BIT(1))
 	char clock_name[SCMI_CLOCK_NAME_LENGTH_MAX];
 };
 
@@ -858,6 +861,27 @@ struct scmi_clk_parent_set_out {
 	s32 status;
 };
 
+/**
+ * @clock_id:	Identifier for the clock device.
+ */
+struct scmi_clk_get_permissions_in {
+	u32 clock_id;
+};
+
+/**
+ * @status:	Negative 32-bit integers are used to return error status codes.
+ * @permissions:	Bit[31] Clock state control, Bit[30] Clock parent control,
+ * 					Bit[29] Clock rate control, Bits[28:0] Reserved, must be zero
+ */
+struct scmi_clk_get_permissions_out {
+	s32 status;
+	u32 permissions;
+};
+
+#define SUPPORT_CLK_STAT_CONTROL	BIT(31)
+#define SUPPORT_CLK_PARENT_CONTROL	BIT(30)
+#define SUPPORT_CLK_RATE_CONTROL	BIT(29)
+
 /*
  * SCMI Reset Domain Protocol
  */

-- 
2.34.1

