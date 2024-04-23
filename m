Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0890FC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 18:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C1A488085;
	Tue, 23 Apr 2024 20:59:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 350BD88AE0; Tue, 23 Apr 2024 19:41:04 +0200 (CEST)
Received: from PNYPR01CU001.outbound.protection.outlook.com
 (mail-centralindiaazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c408::5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 101C788AD1
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 19:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=siliconsignals.io
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=kishan.dudhatra@siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmQgavQ2gtwdjT3Ov+lOSIQSFjAU1BMWRccld/JIUD83dOaPJ9hV8xUiDrfet2K+Ezfk7kSoZ4HW+VUN9ImzzK5OWmoEKnbWeBM+g4rfLHqghHbN1aTo4L8eG5LwmU1xpRL9bW6f/QZNu/hge6YF2bOsOg8LYSwLgSXH3RxhrqNNuD51MxIHFyYBvv0w3mrQu+NRCDHkRzsX2gG7YFWl6NHAn5mF5F7o18jYFjBA0T/A0+ERb53Gkye2S/f1f2BaK71Wi683LCfZCgXo4C7v54zcI9/dWwvUfc3EKEXrPBN7d5dW4cJu0y2qM6qWKcWkT5h1gQDYYOe9v7K2WVcykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aunrKjmWlZmaBuI57qdTkqaFkQ2WFbLkRa9r2SJs7Rc=;
 b=VgwGCDXCWgThD4CNFdh8sjh3mEZw4gN5oWnQedBS935WNckKewJXk05kYpHeY7SrkafG0V1aLnnbeUum+zWlsAofE1V6lhqxquNtJEH8rOszxpQ6kEmWhVMomU9KdUN6m33iQI/vgXHKO+q8/ZnP3cPQHAgEwwWij/Ta35vDNxgV1MFYp4NABJPC2uozpQkf2ZISBxjeNjXej4+yYM31wVIvcB/0Zg2szJL/paujTjFEjYSG5Y+ocWLZGUyqzeDjDyKCCW9z7z61XLtmHPvKco+bwnRSNHnHU0Gn6XlPgCVHADoZslXeY6fLk2sDhd2SSHbcDuSdP5wOvIEgYyyxGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from MAZPR01MB7912.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:a3::10)
 by MAZPR01MB7456.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:57::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 17:40:58 +0000
Received: from MAZPR01MB7912.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::da4e:be76:93b8:e469]) by MAZPR01MB7912.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::da4e:be76:93b8:e469%3]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 17:40:58 +0000
From: Kishan Dudhatra <kishan.dudhatra@siliconsignals.io>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] cmd: gpt: initialize partition table
Thread-Topic: [PATCH] cmd: gpt: initialize partition table
Thread-Index: AQHalNnYhiArhqWx3UyGTTVrh35sZbF0j8mAgAGPvUE=
Date: Tue, 23 Apr 2024 17:40:58 +0000
Message-ID: <MAZPR01MB79120898886D7F36E0096B1CE1112@MAZPR01MB7912.INDPRD01.PROD.OUTLOOK.COM>
References: <20240422172335.166727-1-kishan.dudhatra@siliconsignals.io>
 <20240422174437.GV1054907@bill-the-cat>
In-Reply-To: <20240422174437.GV1054907@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MAZPR01MB7912:EE_|MAZPR01MB7456:EE_
x-ms-office365-filtering-correlation-id: 6221cdf1-2560-44b0-6a97-08dc63bc88f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?UgRcXs219GLnc6Qg6p5d/57MtQ1t5QAbyB6rzhXLigaPprMkV/RrBIaSe6Vx?=
 =?us-ascii?Q?afaadrCL0R2zyMFG9WB1bBiJxsL2+L9UApJm9/qEKvU20qhLlQAGtuM8jTP3?=
 =?us-ascii?Q?S1QPJJwC/eiKrzmRoZNAmXpa3eCeqp99KtV/GF0u6//7jTvswYoEXjw5mT7O?=
 =?us-ascii?Q?K1NfvJNaQam5lVz2YsW7kUx8DdeatViCKb+J7PNlQMNPJR0ZXwSN9R1onegg?=
 =?us-ascii?Q?CWd1SV3rea4udlZFNLHPGj3/Bxvpp1D8lNTyYQX0s50BcPhacBfRjT+V+67T?=
 =?us-ascii?Q?d1gqw05iDfRqUaHYxHxq2awK97Wh4MdlNd/RP4BJRpbH2CdHPm1ziu7eAV7Z?=
 =?us-ascii?Q?uudVxTRZ47U8hwoapJsYUqJgroA7wrBjtdMTVas5YLw7/0z0hJZYk86uVJmc?=
 =?us-ascii?Q?FIOrBwUwROU4rGqN4efjv2GGATUoheU6dQZhuubCCc/MzHuRPlDi3eV17l5X?=
 =?us-ascii?Q?JLK/e0MnOXZ/6cYMdUQYBVdJVMw1yVL5ijhezXyXtN/F73F4JigBNp7f+3F4?=
 =?us-ascii?Q?2iuvSeWMlxk5GrP84TMIDlHa8TR34sIg9/hJpROQ51Qjy/2JKKiYFHl1uYP1?=
 =?us-ascii?Q?VBtxb7YvoHLfMUd6qPAo2PgRWxvd/XZ1nojOi31FM63t/QUpSUx014ecvjNk?=
 =?us-ascii?Q?rBSu5O6s8RXw7MqUU3QhuIIRUXI6Gxh7hgOtM7Qf2YiGCYCv243k0OLtG0ky?=
 =?us-ascii?Q?JA1OwxMYl84lWfFLh23h2cf/SwFWipCrCMt/Tg6ychN5Toeo91BzfYVGkTQi?=
 =?us-ascii?Q?9DgimtdiQz+Y/9JgNNRYKxca3RbbplNCzKYFYiQgwB8pnZilT7B+L7RIw1OD?=
 =?us-ascii?Q?MEsaa8hHiq3j45KCh+HckVo/daejEnqchseoPuHKNKERTT/7fvY3znW7nE1U?=
 =?us-ascii?Q?YGOBU9erGsOlZblB/A/QDYwbxrZ6H4pFjlfXlobjpjX3wgHemg7PbRdJpaw3?=
 =?us-ascii?Q?If0+he6ys/nQ6QZ8vSf8fRj+Bt7y7Y2PzV8DzQYYgH/05l4FO53+qOfdYTYy?=
 =?us-ascii?Q?rVxvaXiFlueXQeY4LR8gaYKeWd8ugQpTYGPd2MnIvaovNsmDfEHFW3LhwL4b?=
 =?us-ascii?Q?x+tYVJsAN/LDmd8DLsI5C5bWTsdQ0BhKTWcJzvvOm0Vy8C5BYyvcdMJh//Zt?=
 =?us-ascii?Q?gD5ZFXl4Tg30njIqGzjkKZDA5oja7nRdDOYufWodMD5slgP6wsDVaOanII2Q?=
 =?us-ascii?Q?42Q3480BY855jszZQocZcIWqf5E0CIs9uPpgKS2FM3soE/4B5MLatwDYqlwQ?=
 =?us-ascii?Q?tD3HJLGMb5gHR/17bHZ/lTIGQvNtwQj+JYusMf5FxK0KhP0hW9f7/Ci4Z+Mf?=
 =?us-ascii?Q?nKcV2pAgj+sPxHMcLNI7bfAKAn9zvMStvXRfnOzRNqdPaA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MAZPR01MB7912.INDPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?85ugKb4CrfYYWN3oBuYltb2a+UMmpVNIRR/ALo+TnkgF13GwJvXHxz/qLQSc?=
 =?us-ascii?Q?Tne4Hl0Ua81R6+siWe4H9p4vM9TBkV6K6RhQMZRzejcSK0ZgKrehBm7b6w+v?=
 =?us-ascii?Q?siY1KSbIZ3neYrgk/aL4mALQd7B2KbL85cZR7G5E59VTWs231KZhnvei4PSf?=
 =?us-ascii?Q?CBaqTGOgOtbNadFIEbGjZoZJQDlH6PMV+qULPFHNUAbJKgodGRDWM9/JdVbZ?=
 =?us-ascii?Q?azv+2qZOVNg98kJ1ph9CIQ/6q5XzRc2nYAhveo1ZdPQx/0n/KI9NMT9pjH2t?=
 =?us-ascii?Q?Bo1tRZWMKPLT5hZWoMsviIKRmxZbKal9aOtbNKUQaSdgWuLZRlana8Pv/dSM?=
 =?us-ascii?Q?zpahkBuZje1M0lKJrM5Fr2vel4o4Pf10lDE+rVBYz+D2JPIMqSsttPXccS17?=
 =?us-ascii?Q?+x4l1sC2OT5mpUKZgOqLhwOlRETyz9LHIpLN3g6n4zTjf7FR1S/JF1hqeAzy?=
 =?us-ascii?Q?W5KBDd0v9aOu1iaETU7FEBuHr5NcgoJQVc/dPqdSqiz59RXPdq4ttiD1TKHW?=
 =?us-ascii?Q?F0vcEx2fw+CEkSnEMGX1sY4HEqMRnpy7h9r3NXyW3Vg84vokoMZ687dXR7jS?=
 =?us-ascii?Q?ZPP+jxteJi7cTevE4DP8Ale8uQGMw/mAo3cCAF2yptG3XbnBhA2GJ9LLrqfc?=
 =?us-ascii?Q?8Hh4yfVLD8vKESJ4pb5I826hr4kayPrKry9Bzx9nxLguG4scDvv+RrwUjHEV?=
 =?us-ascii?Q?ytUJG89jzxjcTDWp5aSDpcWxLVPKD0nB3auJ/iC+6AI9ZhDhHA8V4JUzrM4v?=
 =?us-ascii?Q?WDaBvgMevXA++OgA37c7j2kisTL2baGh1YhMDd72tz72OfOnf/YHROnqUUw8?=
 =?us-ascii?Q?pHEZCpCZig+4WjFR1aYwtLxndhe6lJpCjAThdRNBMtx+St3bKTalWBrTSEKY?=
 =?us-ascii?Q?DuroCDh9o0UgKmYR5u9ZomEuhR/7BcWy0jA6p58acs2B4ZDEztju3hP67UKD?=
 =?us-ascii?Q?gSzEIJC02Q1m4zFBRQHL6OfNwQYWthXjbUhULlTLQVaXga2ElBSetefacI3e?=
 =?us-ascii?Q?4gZxoZCanvTGewTesUIiqyKVmhFXCwaMNMYQ8v6dmexE9abIwV/vWcN+e8G1?=
 =?us-ascii?Q?7kvohDqwT/xiB1kHhdWWLOpJy6J0Nh0sKpy1QK1MjflQrXYM4MscGnn1lWAY?=
 =?us-ascii?Q?CWhbCjbJXxx8M3nARd22RJsXI1oVKiJC4ULjXD2nWycq1Dm2VySGyp2WqdrM?=
 =?us-ascii?Q?Y9wbw7Dbofz1E4U7v+bz9E2+IalpjeSkaFjserC4YolbgVcIHUqLOgxbGKV1?=
 =?us-ascii?Q?lyLRa8zxaBG/fD5TXoC+tjLyZuMgAVY4OwFChQuyIG0/gE9hGxYJBzmpvdfJ?=
 =?us-ascii?Q?BOgf4DtEa/kA38qbgMI/+lKZRkYFaA1wpYXXm6LcrKCB9bHfzehm9g06JaNr?=
 =?us-ascii?Q?MzjObsmpLKMUgPMuLfB510w9HQKNMyzDcgUqEaHeLUG6BFqbHMUhpXeKLlTe?=
 =?us-ascii?Q?MSq5lnPhZtxBt6/IWazISDgSVe/jebUQua8e0NkRmOazDfGi1nINyC1nR6GI?=
 =?us-ascii?Q?J32GVjspRgerpsYDem4S/m0T4KZ9qqXWH3uTIp1B1UCDDSsLGIH/V4lK6cR2?=
 =?us-ascii?Q?Q/1XGQE5HUZj/BrMzSednpuQ4uWEKkK7UoyOermDCPb/tQUS2ASPHzIgC1v5?=
 =?us-ascii?Q?/hx1bi5hSg4YX/2qZrD71T0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MAZPR01MB7912.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6221cdf1-2560-44b0-6a97-08dc63bc88f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 17:40:58.2424 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZ5NyLzQuERxpR1lRm/Fm+q5towmNiYuTLN2zJ4bxBS7UL5O/AxHyseq7xbf9eFo8sJktJKhJODCiy2RhO7W+XNenJiIy7YVn4ksWKtP+crz1c9k1almOyhE4E3rL29C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7456
X-Mailman-Approved-At: Tue, 23 Apr 2024 20:59:14 +0200
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Yes, You are right I observed the issue in MMC device, device required rebo=
ot after writing partitions.

I have checked the fix is required for all the blk device's not just mmc de=
vice.

I have updated the changes in v2.

Thanks,
Kishan





________________________________
From: Tom Rini <trini@konsulko.com>
Sent: Monday, April 22, 2024 11:14:47 PM
To: Kishan Dudhatra <kishan.dudhatra@siliconsignals.io>
Cc: u-boot@lists.denx.de <u-boot@lists.denx.de>
Subject: Re: [PATCH] cmd: gpt: initialize partition table

CAUTION: This email originated from outside the organization. Do not click =
links or open attachments unless you recognize the sender and know the cont=
ent is safe.

