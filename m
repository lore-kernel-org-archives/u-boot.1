Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97666C021B2
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 01:47:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E3AE8006D;
	Fri, 21 Feb 2025 02:47:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="teNbgyS/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82E8A8007D; Fri, 21 Feb 2025 02:47:53 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 515C08004F
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 02:47:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAITJGU0IbSUgKXVFzw2l6vtc08Hna8ssYSewUjadKQi6sPNGKb8fbNZIiCq19t0yTwT4r6fdM1u0GIZudAhK9VP4AHoJb7hbpLE9kGV87ghTKzFM6vosIju6Ei+w2m67DVIWvoJYrZlYYJZKuT4XyWDoRspXM8c//K4pVUMpT/+sYuVKq94MDHRDXvK2NS4GvU7YN/3BGe2cv1IMaYVUyKTONakCjKXowKUJHkdEVzdm75DbzNLYkviK1SZuC6xIipmog+cHKkzUNJJXUfthW5yM4/9Wizu/0pJKmZXGbV0KUqyoikhsE7QmBrm1cuOhVcukUv4dSkOp9ggZM4OyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4etVBZv8CBEBgQa1YOvehDtHioN6troWZRr//kfDjQ0=;
 b=wJF7LkbvnqeE51na7F74UHrzfs+wqY3H4ugy6FS8jZMRRkvFlO4ljPMsG91ZBtgcxu8oW3tQ5W9rCFh1zSn+829nTyh+MvMuGW6kWtjrVEeGOprk7rcskMXX2Sx9RxgVof6u/4Y46J4OyOQy6FMCWPOhuuDkmwe+1lnHZBib0yDSIkCTxNT+6sSILDutKOlUWD/TkpF2/1zqqVR1qntZ/thvwdBe98z04OKxCv3D51OVjN/zL0sL+K1LIaAB1rv42FS8Wq2za8delmNwIa+JXCPZVgM2et5gGkuSJAAkl7Ih0E9nG5H6IbtvmzEy7n81VVcUpZuU+QuTfctcbwJeHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4etVBZv8CBEBgQa1YOvehDtHioN6troWZRr//kfDjQ0=;
 b=teNbgyS//h74CenAcdYjN+R4CMLiWpCHSSKmVNDNdRAMTbZgz8Iz70xqdP00VLIiuHmtnZ5tDzqu/4lCMJdSAtXIpTyxU79fsSjbGHGCHQ6x1F5hOIVgN4XQZLE4yLXEQz220pDvEnHYZe8fQvfSPxzZ2viHzM042E3qRLj21gEX4idT+ae6LYagxCPpTEgnQRt8T/GFi3oeA4k9ctTqvrBYjeqdP6MztsPk8fN5txwqCXaj14IpyMKrxqQJLtISZ6vM2CfqjRZR8OLXqDM/nlRbx81n43M4FECzJnW5pC5ipZib0s3uu7OJVBwT+tBc2ZvwhrncspqViSYXpnCqoA==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB7490.eurprd04.prod.outlook.com (2603:10a6:20b:2d9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 01:47:49 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 01:47:49 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Subject: =?gb2312?B?u9i4tDogu9i4tDogW1BBVENIIHY0IDA0LzIwXSBmaXJtd2FyZTogc2NtaTog?=
 =?gb2312?Q?add_pin_control_protocol_support_to_SCMI_agent?=
Thread-Topic: =?gb2312?B?u9i4tDogW1BBVENIIHY0IDA0LzIwXSBmaXJtd2FyZTogc2NtaTogYWRkIHBp?=
 =?gb2312?Q?n_control_protocol_support_to_SCMI_agent?=
Thread-Index: AQHbZ1F+XbneYzJjuUCxxW5MfO0jxbNQy1yAgAA1fkA=
Date: Fri, 21 Feb 2025 01:47:49 +0000
Message-ID: <PAXPR04MB9644F7D41AE5AB9EF61FC5DBE2C72@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-4-93b28a514dea@oss.nxp.com>
 <9859d7f3-95ed-40b4-9140-f86638b0e522@denx.de>
 <PAXPR04MB96446C0606C01C6CC5B3622FE2FA2@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <1eb93e8b-0355-4274-a680-f6481e398e5a@denx.de>
In-Reply-To: <1eb93e8b-0355-4274-a680-f6481e398e5a@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AM9PR04MB7490:EE_
x-ms-office365-filtering-correlation-id: 4523b812-3abb-4cf0-8a8a-08dd5219bf33
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018; 
x-microsoft-antispam-message-info: =?gb2312?B?L2FwZmo0QkdicWViWFhpNUVVelZ4NG5mQTI2SFcweDc1R1IzVmpaaVZpWlFG?=
 =?gb2312?B?RjRrV1FXeVlFU1pHMUZFVWUweUJnY2k1Z3dYWGpjVU9lQ2pLemxYY0hEM0tS?=
 =?gb2312?B?cklLQk1tMUVGZG1pa0V1NHZObzdQTUQycmpzM3N6Qk9aQU54ZEY3bE9KS3c4?=
 =?gb2312?B?U0JvbWVaMEpydEQwTXFDMDk0M0ZLbk9nRVp1ZjRHTm9Yd2FZYWgvejE1WFpG?=
 =?gb2312?B?TklHWm04RG5lZGNCWWRWdU1UTlZTL29mUWdrTlhtbENnMzFROTVraUp6ZlRq?=
 =?gb2312?B?c2Qvb2ZCd0xTejZtaDZNSnErNk9FWG1GZUxlRlFRbnViQmdxWE9Ma08rZ0p3?=
 =?gb2312?B?UEtMZkJRZXZORkFzblJBZ3pRaHB2U0tPZnRTK0lIdDkveWNLV0h1S1RjOTE1?=
 =?gb2312?B?TmJGZklTZTRYU2FzTHBXamwveEwrMHFYY3hZTUo5Q0xOdEEyaFZNcFdYZm13?=
 =?gb2312?B?YXoxY1duZ2N4a1FEcUNsSnZYSEFINnBUcVdQbDlXQnFJdUpDdXYydjJhVjdK?=
 =?gb2312?B?UGdsdktxajFkQ0t1VmFYM1FGYVpHZ1VUVWR5UmxwNmhKN2NnWkwvU01nNDNB?=
 =?gb2312?B?RWZ1SnZZMnpFeElXU3ZGZkZQbkJabW1LSjZYWnZMdjRtVnpMUXZ4dStGN1JK?=
 =?gb2312?B?ZDV5a3lUeUxJL2lSWC8vODlsYjA3ZjJOdktLSlZWWjFqN0NwRTF3Z0hXLzZi?=
 =?gb2312?B?MEJEUjdyT2l4TnlxdTNrc05jSXNwMDEza3E0QzA2S3Z1QVRLZ1BveDlyTFkr?=
 =?gb2312?B?NFlLcWRCOGF2RU9tVy9uZ1FSQXloeWpIUlNEbDFCNFhEK0p3YWZEL3hwYnhI?=
 =?gb2312?B?SzE1THU1UUVQc0R5L1RGSk4zYU5mZ3IyZUNNL0xZM0w0UEpiQndXbjJYaSti?=
 =?gb2312?B?MlZBNDRTeFRyUkp5YXRMUjgyZEc4cTJrb1dZMy83aGZldzVzTFpucGxEQjNV?=
 =?gb2312?B?Ryt4WUNzZ3YwTlNoVXZ1Z0l1RXBNdDh0a0lOR1BZdjhXUUUvU1ZWbjRkVyt0?=
 =?gb2312?B?MHNTYm5SaStQcERNaHUrVWJsRlZURllWZHNqZ1pKRWJZdUxMMUhLMEMvRlNH?=
 =?gb2312?B?K2FRQm9ZRmxDdkNHRkdEYUNRTWhzQzFsYUZpOWx1eU8zMC9iaG4wRXYyQlBt?=
 =?gb2312?B?N1ZyclgyWHpmU3RsU2drYXozQWVRazc2MmRyd2VJMVAxc1hCcVdUalJmaVEv?=
 =?gb2312?B?bVJFZ1ZKSGgxdUhwalpBbllRdXRFUytNRHdJL0hPRHpiRjFzUEE1UGpBWEdW?=
 =?gb2312?B?Wm52T0hUV0djbDYvNVZtS3dHT29sUjVMUXJObnVkd1JjVVZud0t1eWF0MDNZ?=
 =?gb2312?B?WXVBMkJMRGdnYVZYUjBYRHJTMFhiT0xwMFpmSmRiYjZRWmRINFJub2V5Um9Q?=
 =?gb2312?B?MUFWODNqQjBHMVp4TlEyclRHa0VmVXIycDdKQTBtbGdTNXJ0Q082ek5sMmVZ?=
 =?gb2312?B?Tlc4bmFTeHp4KzZ3RmM0eTJ4ei9PbVgzMFI5d3Q0Vm1DbGhTWjRENklxOWkv?=
 =?gb2312?B?L2xubHBRSHpXK1J3VDdrd1lRbjU0QU9vYUJlemphSHk5MDZtU1BHM0g4MGVQ?=
 =?gb2312?B?aEQ4QXRVVkNlcml3UTVKdVpmUy81TFdtV2t5NlVCckx4WS9EWWlLNjBYZGVL?=
 =?gb2312?B?TDArL2g0WHBlaFBSaDRrMEh0UUFBWEo5OGVVdjIrTkFjM2N2NVZaUU9pVkFX?=
 =?gb2312?B?RzdXL283Z0dIZC9CS0l4WTVDVFROZ3hPUG5NcVdhWkNHSXp5Nm5ueXlOOWt6?=
 =?gb2312?B?dnlGNS8vWHZlMXRiV3NuK0p6djVTUG02b3plb0xsRU0wT0hNcnF3Sm9KUmdF?=
 =?gb2312?B?dXRDTkc1YTBCZnlrN2ppUEttZkpqNit2bVM3L1B6TTJSNER0SXVsR09GRVJE?=
 =?gb2312?B?aHExM3kzRmRVc2RKdjZKZnJmY0RORjN5YUV4bkhnKzFmeFZqUnhRV2FtMXEz?=
 =?gb2312?B?emJyQTl0Z0YzN1cxQ0pJREY2cEwrM3gxQ2d4RVpxUFJ0VWlBbEpTaDVKYjIr?=
 =?gb2312?B?bXlBNnRUTFJBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MmJDdy9Kc3gyUW9WUm9VdmNnUFpETG1CMm8rZHdISkE1d0pPUFVNYXZMNUdI?=
 =?gb2312?B?R2Iyc2xWWTN4MXpkWTVqVEdMTWdhNFRjVmZxbXRMSk82VHVhM1AwMysrRmIy?=
 =?gb2312?B?d1hydy9SMm5WdEpvVmk4NXA2dmFXYWYyRXArMEVqeXZGL1FOOWxwVDhGbGJP?=
 =?gb2312?B?a1ZZWlRyUTVEakRLTENnZTBMR2g0UWloRW05SzcwVUtlYmFwVXFobHFMazJa?=
 =?gb2312?B?K3hDZXFxcGRXZjRMa0tHQm85V253UEVkZWdRQVI0czRZT1VYR3BUdDJ0STht?=
 =?gb2312?B?SG15SmYzdHRSZFhEMHBFMitvUktoZWl4V0QrdmRKSUNEdy9MazltUGptNndT?=
 =?gb2312?B?MXlmUzE4anU5SVl5dXpEbTdMTDdRM3k4R2kxdlI5TjAwUzdJZlU3azJlcjkz?=
 =?gb2312?B?U05GUUFUTUJmUm10QXpJbzhaeGtYNjZnUTBkZ2p5TzhabVgxaVV1cmpZUjhi?=
 =?gb2312?B?d1FBUTB6aGFYNXFLMFZxamx1eGV6TFRMb3hMNDVwQ3ltRTZNTm1rWmFNWmYv?=
 =?gb2312?B?MXhLQzI0UWd2bG5tM3lqKzM0dGV5b1gvSW83NHo0YUQyOVRxTzlRUFNtdDJP?=
 =?gb2312?B?TlN5ZzJ5amdFeVorb3pSelo5dlQzVjZOYmRiQ3dRcXRiK05BeVpQU1ByeUlo?=
 =?gb2312?B?YjBPNkdCcVBDcmhKeldleWNkZFFFZDVOclBraHBCVUpmNk15QTJhTjN4bUdO?=
 =?gb2312?B?VnkxUjJXbER5TEx4WWU0WmsxRnlKUWFsNGhTODFQOS9IY1ZDcDdBeTVwMzVw?=
 =?gb2312?B?c2VTcUpHendtZ05zd0xyNUhkcEx1MmtOeG1DUlJ4RUFWalIzSkV6OFJsbWsr?=
 =?gb2312?B?WVNTMlQ2YjJLRnQ2OHZnTk9UcnRVMnVUeEkwWUtaZ3FEZDVJckhFU2RsaG0x?=
 =?gb2312?B?eVdEanJ2VGg0RXNXQWpwcXRod3FVT1RxMndrajFpazBzN0V3VzJmekdpREQ2?=
 =?gb2312?B?QVFWNzZFV3dpSVFIRHFmUkRpRUcxdUora2xFNEd3WUN6a0pTdGI4WUtPUXZS?=
 =?gb2312?B?dXAzT3Q4MlpuUjdXK3RQM3NoNHJmcHNLSXAxcXdldU9jbEtsaWR1cGV5K3lI?=
 =?gb2312?B?ZUlrT050NzZKZEJGQWJlMDhkV1hPVkFjYTB0THRCRE56Q0xHSCtnR3d3Tmk4?=
 =?gb2312?B?SlNib3JmRjZCYTVtdHRXaTVXdWFCelZXQWUxV3RDNStVaENrYUkzcGt3a1I2?=
 =?gb2312?B?R0RxTFQ2Zy9tbWhkVDdSeGF0U1FrTmpIVHhQcDRqdlB2d2E2ZDdVRSttRUR4?=
 =?gb2312?B?UGcyRnNzMXNKZER1aW5yTzlEOUZpdVJGUkNjQ0xaMzNveVpBMmxnUS9KclNE?=
 =?gb2312?B?V3E0dmhXcGV0NldVZ200eS9GS01EWmFZVkVRK3lGZUhLdHdDbGZicFVUQUNh?=
 =?gb2312?B?WDdqTXNrVUw4YWJTcVVvMGxlLzNIc2JqdTBmVTh0bWVpZ3ZRMFRZdUlJRTFU?=
 =?gb2312?B?ZzBqNlY4UkRRR1FxTFZpcmNQbGE0SEJPc2Y5ZnV5eUQ3WGVuMGVnQTBNRDFi?=
 =?gb2312?B?c3psdk85d2Ewa25HRkoweUE0b2lQV2RDeDU0TEZMSWx6ZGFvaVhrT1NWUXRE?=
 =?gb2312?B?dTZHU2dtamJneUNRZ0pFOVdhSUk0M3VBM3pZSVViUHU0ZmRRTnRwWVBFSTli?=
 =?gb2312?B?cm1vVGdJSDBodklGNmtXdlQ3RzNCU0V5MVA2UzE3R01xSFNzRkpvQ1Y4OTNH?=
 =?gb2312?B?T2lJMkszeWJpMFNSNlEzZTlpUENxOVRtc1F2VFNCQkZrKzNBcnRCL2RKdlA0?=
 =?gb2312?B?b0pqUWlKOGVKeVd1b0hZek8zUUFlaEFva21OMzkyTkozRnJ1aitad3VEdGZG?=
 =?gb2312?B?T2gyalAwcm9WQUJQUjJvVzcwLzlyZVdsNWN1ZE5HRnJ0UVhhd2RuNGowOEtt?=
 =?gb2312?B?azVkRGE4T3VqU3doeGhNYjBWdGxkUGE0MjJjTmQxNmRRUDhCVlF4cllCME5z?=
 =?gb2312?B?U3VLdVdaaGtodzBrTjBlb3N3MmE2K2hPUFhITUpqZ2xEb3oxeU1zYkowLzB3?=
 =?gb2312?B?NW4vUDBncVROVmtwYjhFOVhZWk13bmE3TXNhOG9KNE0weXBOVXlwd29MdzlD?=
 =?gb2312?B?aVp5WWwxS25hRTZUZXpXRUN4enNhZTM5TjdPOWRSaFFINGZCam9lMHYwQnN5?=
 =?gb2312?Q?VbJE=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4523b812-3abb-4cf0-8a8a-08dd5219bf33
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 01:47:49.1868 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2gRla5aCpRwXYeBgFxkZ4U8payA7pvE2BJBig9O2e1n/JO9U4Br9Xfh7x+g3s7JKnprQJnsnNtuKnL8IAgXFVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7490
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

PiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8/sjLOiBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5k
ZT4NCj4gt6LLzcqxvOQ6IDIwMjXE6jLUwjIxyNUgNjozNQ0KPiDK1bz+yMs6IEFsaWNlIEd1byAo
T1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPjsgVG9tIFJpbmkNCj4gPHRyaW5pQGtvbnN1bGtv
LmNvbT47IFN0ZWZhbm8gQmFiaWMgPHNiYWJpY0BkZW54LmRlPjsgRmFiaW8gRXN0ZXZhbQ0KPiA8
ZmVzdGV2YW1AZ21haWwuY29tPjsgZGwtdWJvb3QtaW14IDx1Ym9vdC1pbXhAbnhwLmNvbT47IEx1
a2Fzeg0KPiBNYWpld3NraSA8bHVrbWFAZGVueC5kZT47IFNlYW4gQW5kZXJzb24gPHNlYW5nYTJA
Z21haWwuY29tPjsgU2ltb24NCj4gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+OyBBbHBlciBOZWJp
IFlhc2FrIDxhbHBlcm5lYml5YXNha0BnbWFpbC5jb20+DQo+ILOty806IHUtYm9vdEBsaXN0cy5k
ZW54LmRlOyB0aGFydmV5QGdhdGV3b3Jrcy5jb207IEFsaWNlIEd1bw0KPiA8YWxpY2UuZ3VvQG54
cC5jb20+DQo+INb3zOI6IFJlOiC72Li0OiBbUEFUQ0ggdjQgMDQvMjBdIGZpcm13YXJlOiBzY21p
OiBhZGQgcGluIGNvbnRyb2wgcHJvdG9jb2wNCj4gc3VwcG9ydCB0byBTQ01JIGFnZW50DQo+IA0K
PiBPbiAyLzE4LzI1IDEyOjUzIFBNLCBBbGljZSBHdW8gKE9TUykgd3JvdGU6DQo+IA0KPiBbLi4u
XQ0KPiANCj4gPj4+IEBAIC00MzYsNiArNDQyLDExIEBAIHN0YXRpYyBpbnQgc2NtaV9iaW5kX3By
b3RvY29scyhzdHJ1Y3QgdWRldmljZQ0KPiAqZGV2KQ0KPiA+Pj4gICAgCQkJCWRydiA9IERNX0RS
SVZFUl9HRVQoc2NtaV92b2x0YWdlX2RvbWFpbik7DQo+ID4+PiAgICAJCQl9DQo+ID4+PiAgICAJ
CQlicmVhazsNCj4gPj4+ICsJCWNhc2UgU0NNSV9QUk9UT0NPTF9JRF9QSU5DVFJMOg0KPiA+Pj4g
KwkJCWlmIChJU19FTkFCTEVEKENPTkZJR19QSU5DVFJMX0lNWF9TQ01JKSAmJg0KPiA+Pg0KPiA+
PiBJcyB0aGlzIHBpbmN0cmwgcHJvdG9jb2wgcmVhbGx5IGlteCBzcGVjaWZpYyA/DQo+ID4+DQo+
ID4+IElmIG5vdCwgdGhpcyBuZWVkcyB0byB1c2Ugc29tZSBvdGhlciBjb25maWcgb3B0aW9uIHRv
IGdhdGUgYWNjZXNzIHRvIGl0Lg0KPiA+DQo+ID4gQ3VycmVudGx5LCBpdCBpcyB1c2VkIGZvciBz
b21lIHByb2R1Y3QgZmFtaWxpZXMgb2YgdGhlIGkuTVg5IHNlcmllcyBwcm9kdWN0cy4NCj4gSXMg
dGhlIHByb3RvY29sIGlNWCBzcGVjaWZpYyBvciBpcyBpdCBnZW5lcmljIHByb3RvY29sID8NCg0K
U0NNSV9QUk9UT0NPTF9JRF9QSU5DVFJMIGlzIG5vdCB1bmlxdWUgdG8gaU1YLCBidXQgZHJpdmVy
cy9waW5jdHJsL254cC9waW5jdHJsLXNjbWkuYyAoZHJ2ID0gRE1fRFJJVkVSX0dFVChzY21pX3Bp
bmN0cmxfaW14KSkgaXMgb25seSBmb3IgaU1YLg0KDQo=
