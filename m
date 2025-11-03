Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F97CCFA03
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 09:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E58D683700;
	Mon,  3 Nov 2025 10:25:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="i5arV884";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2042D838AE; Mon,  3 Nov 2025 10:25:34 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E38E836D1
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 10:25:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9HIiubhCYs0kC4ojaOoIpjD6amd6b5bn0yTTfqA0CeDQCzk464Xkt76ITkjepu26oGYrWC4hbL4TodMnPXognot/eWrwcBacarfKjjrNtu7JlCpj8AemOHZrNJ21J3KNHDp17pl5hqj3lM4oSartdMDahIAtElrjv1tWFfeNkQFJW3N8rgZsXaGoTGTaIhCbMvCUCfGIySWqUarYiUEvSs+7ECPUhInQTvQ2RLQpS4GmmVD+A5HX7BHAWZww7qH+is64/ODQi4F8/jLSr5Stms4I7JOYAsloGtPyru/8LN2bilipgTep+nslH+iXopEgf0fp7KHSPa5Yn4c6aXB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMwIkmpLeW3pjNT0vC4uMprkjUYyy/goXZNUr+k4Y3k=;
 b=MHfVeHpTk0G9SGNrAz5b9t2NLPWRmg0JJvSZtCUBBnWsSwFEP7d/Wq5LBm8B0YGtQ3GSNUrPfUSnQXZYaT9KugJRbynp6Nva4FwG6hl0TVApcDxfFiIh4UNdzry+zTrFF94O2JkyqIsHCeE62mTKJxyPCROneF5cx7hu9UzuFDGJS0TLsKkjxkjm+VEiZTO9aUtZyb6p0geC8wxrFGoRvcw+4eL7WAitmGCG6CXwjXb2eEAQRv94wx8Qkjc2dXwt70nqley/m9OPFtKWhGshHHYOXAHdojBn9NBozJ1UjKAzALzLttTcqNdhH+bgJmPKqgi+EJbvdclBmVbiiowx9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMwIkmpLeW3pjNT0vC4uMprkjUYyy/goXZNUr+k4Y3k=;
 b=i5arV884u7lYe8Ua69KMdYTnyY5mrXPOQJtg7kjaiz3ajab0mQrAucyiHlkKC+CtaPnVNVnSZ3VRUmXV2makLmOGMMUMFlzPaNuLz8pm4rx6hLEVBuzbCRpb/Nq3+qpU2ZJABEayJGFaVsReiEEZjsC+ioalY3C1LD145AjRlS/6GTf9sw3zVvD6GWaAeC25/qOqzfDk+OnJZjZ2jHn75sQpwxH4OoRll4eKqombzG3k+7zsG6pD7WJUXIl4gU6ghBjPmZl67HJve4LvJatCDoNBt2nHbhpggL8dcRRCqvCAZhilgSQRWuGQchwnYC21s9NKrO1H8UWYdzojFN+TlQ==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM0PR04MB6897.eurprd04.prod.outlook.com (2603:10a6:208:184::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 09:25:28 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 09:25:28 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Alice Guo <alice.guo@nxp.com>,
 Cristian Marussi <cristian.marussi@arm.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Sean Anderson
 <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, Valentin Caron
 <valentin.caron@foss.st.com>, Ye Li <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2Ml0gZmlybXdhcmU6IHNjbWk6IEFk?=
 =?utf-8?Q?d_clock_v3.2_CONFIG=5FSET_support?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjJdIGZpcm13YXJlOiBzY21pOiBBZGQgY2xvY2sg?=
 =?utf-8?Q?v3.2_CONFIG=5FSET_support?=
Thread-Index: AQHcTKPK04m7aoXL7EKWaMOvRrzCnw==
Date: Mon, 3 Nov 2025 09:25:28 +0000
Message-ID: <PAXPR04MB96441DDF7341ABBC54993642E2C7A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20251027135856.8909-1-marek.vasut+renesas@mailbox.org>
 <PAXPR04MB9644989432FCE67C8B8F87BEE2FAA@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <90fe8028-7e13-4434-bc9d-318b4e778c59@mailbox.org>
In-Reply-To: <90fe8028-7e13-4434-bc9d-318b4e778c59@mailbox.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AM0PR04MB6897:EE_
x-ms-office365-filtering-correlation-id: 339fdbe6-245d-4286-6a4c-08de1abaed66
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|7416014|376014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?aFF3UXRVVDNQeVhGUlJ3R1U4b0xqTENXaHc3aDZoVHRmMFZ6eEoxcFpQNjdj?=
 =?utf-8?B?ckNOZzlDSWNRTlN5dTlKMFNtb0p0N0FIeXlkc3lOaVp0YnQ5OFQrdXFqUUNE?=
 =?utf-8?B?MTM5NURheGY0ZEhJV1I1dmJMUFhDZ2lTM3ZSbXZJR1NITFBYK3NRY1lNNmlE?=
 =?utf-8?B?ZVRkWlVuMGpOWDUydzhaYnpkQjFHSm5xOWdIdFluOVBFZlVPQTkrU1IyZDln?=
 =?utf-8?B?Q3VwUzQ4UFZPYlNURGVRUlcxSEZyeVRpSERHekswTXdSVjFqaEsyMzg3b3Vy?=
 =?utf-8?B?Q0RWbXdqeUhFSXl3R25vQ0ZGbWlQd0R1K2hkS09ZZFZRdnlWZlZCSkxBZGpn?=
 =?utf-8?B?Z0xEdXZZazQzWWVlNG1wZ2YySXVGNFJoWHpmM3N3Sno5U1R3eTQ5ek8wMFpt?=
 =?utf-8?B?dmIyNlBaTFc0dFpnOUN3dXJ6M0tWNVVpN1VCdHp2TU8rMGFVdFFham9VaW1O?=
 =?utf-8?B?ajE5MUZ1Yk1hR2R2dmNvT3VKdTRLQVZDaEZYWE5EZk1sazd5SU9MNllnaVho?=
 =?utf-8?B?L0kxOStRSGJmbXgxaHhJN29aL0pkYzlhM2NhZTRPeWtZaXNPc2FSdnF1cjg2?=
 =?utf-8?B?aE9TbnZqRDJTOWlPWUZLeVgzTFJHMms5QzZEWUxPY3pLVE9JSVhGOVR0Mmcz?=
 =?utf-8?B?aVNEVnFLWnRURE1HVnlrUU80THJrS1JPRVVockxDMzllMEtUSWhUajE2aUho?=
 =?utf-8?B?WElIcTJ1Z21VeDc1WWwvc1JuaXVXbnhUcTgyUllTZWxNSitWRHlMWE8yeHlS?=
 =?utf-8?B?WVU4T2ZpS2VTcFBtOXpGN1JXWmRTdlU2VDJieXMwRGFaUThkNlRaOEdyUWxR?=
 =?utf-8?B?ei9tMEtuUmxYcUFpWGtXdlUwZE5iMDhZNGJEUXY4WU91d1JBQkY2OGlEZ1NE?=
 =?utf-8?B?cUVBNUoycm1yNVpUSGJjQWVyRm83RDVLWnM2ajZLaWhGZjV1aE1jekFQOW40?=
 =?utf-8?B?UmRpb3FUNWpiMGora0xGWnV5eEF0SkxxMXA4L2piY2tqRlppLzVhMWd5SGlq?=
 =?utf-8?B?MUdzV00yY1o3RXQzYjlvVlZFMUpTNUIyTHcxekpKOGVXSzN0dFR6QjlHVVRY?=
 =?utf-8?B?YU0zT0N2MjM0bEo5QUFaeUNkK0cxWStNL2lYNFdJLytycDByYkJldkptckhO?=
 =?utf-8?B?bFYvR21XUnRmcm1Uano1anZwSnUrd0VvVVFNUG9pby8yVkRGMFV5N0huU3dt?=
 =?utf-8?B?eGJTTnB0Z0Y4OXpIOHZnNFYvZmVOT1ZHZUwwZisvYk1VZlUzWmJMcTZXK0dB?=
 =?utf-8?B?K2VwVnMwZXlITXV0ckJlakdaamNUNUVuMjNCVXUwZmJSTEVTMDVaaUE1U0pT?=
 =?utf-8?B?K2tzLy9iWUxXLytuaDVjTHFnbWxSZkRaZmRFYWx5VjZJTFhHbXR3WEtsRzhr?=
 =?utf-8?B?QXRXTEs5VkV0ektpa2lvUGxjbk1zNGdRYmVLZXBqNThJdFZ5dzJHNnNMVXBP?=
 =?utf-8?B?WndxVGFwbFJmQjhqbGovUW93YWF0VnJjK3FzSCtSTXIvQllFT0ZvUnk3VlJ2?=
 =?utf-8?B?K2VtSWwvWDFORzEwOFZRLzh1Q2ZUYjVEd3JQSXpPYUhOY3NvMm5kNzc4SDR5?=
 =?utf-8?B?TEl5RVd3TWlic0tWVGVNSWtpZlo2KzZ3NWd1TzRVWmJJV05mNGIrYThCN0Z2?=
 =?utf-8?B?TlVxdWdGU2I5dHFJZ05GWlNka1MzazlpN2JZSDA3VTMwZ1hmaFRSYnppeXk5?=
 =?utf-8?B?b3Q5RzRHNzFiK0E1RjVZMmRWMnJ4b1IxTk50NUxtYUpOSkkrSU14NHV3UlI0?=
 =?utf-8?B?bEE2NUJ3NU1CUHBZeDVWVDBWQ1ZMQUFZY0lCMjZ5WXprS3g3SFlwMTNEQS9y?=
 =?utf-8?B?c1Y5eHlmd3M5YUIvbStEUTJYeS8yZXFKbHFIcHFUeHRVSEFZT25pVlZvUWRC?=
 =?utf-8?B?dGRhRndxbnAxRjllUHo3TVpmQkNQbkl3MzFqajhOV1BQallXRS9sMjltSTl3?=
 =?utf-8?B?bWZlRFZKSjd2V09tRW51TGZYNm1lelFGeXdaV1VXK3FoaDNjVG9oQ2k3ckNu?=
 =?utf-8?B?RjF3UWpFWUVYNXQ3QmJtQ0ROdWJ1VUtBakJDOW54U3gvUHNPWmpxdlA5Qmhz?=
 =?utf-8?Q?c6nChK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVl2TnNLdkZldC85L1FUbWlwZG5OQmVoSUJrajFBTEdoaW01dGVEY3ZxeFhJ?=
 =?utf-8?B?OTIvZGdaZmVWVGlJSjhXdStJaWNTeGVtSWkvTmxQeFJUbFhGejNaVmJkbUFh?=
 =?utf-8?B?QzdpMDVOaEtsOVoxUUtVaXZJQnJ5dm5YUU9mL3J5UGk0bk5CamlpUm9HMlZo?=
 =?utf-8?B?V0w3N1hHMWJYOGlWTXVXQm45Q1V1OXRHb2xpSmZJNEZkM01IYy9kQk1VL0FK?=
 =?utf-8?B?TCtNcVFDb0xEcFNMcTI0eUZnZDRqam1OZGdDTFVUdXoyTWZTY0ViOERtaHd6?=
 =?utf-8?B?dTJpY1NWeURwU0l5ZU1zdXBSNjV2dG9rc1hsTi9YaENZVTZQdmdWa1QrMGFv?=
 =?utf-8?B?UkZNN3JqdDJhbDFnM1Y4MURZeW9scUM5ZjJqRU5hMXJNK1RERER1NXRnSUNl?=
 =?utf-8?B?VUpIUllaUnAvclBWcmFZTy9OcHpBK1MrbnVMeUFNSnJPeVBwSFV5d2lxZEd0?=
 =?utf-8?B?ZTMwd1pBOCt0cGNLYk9GMnpLS1ZDdEhyVHRoVnl3aE9aQW5nQ1FyU1kvaUk0?=
 =?utf-8?B?ZWFYVk83dmpmTkFjSzd5TFJwUUt4dEgzVUJZWUtIU0tHaTBLejhhL3pvSXRi?=
 =?utf-8?B?Y01FUkJ6NDhrdkVySTBrRWVkMno3N1lxSENFdDRpSGdTUmRnblFUMC9DOXBa?=
 =?utf-8?B?ZTF1eldzL1prWlhEbzVzSmErY2s3Y2RuR0w5R21BSnhMcitYT0dFWWdDS0N6?=
 =?utf-8?B?SzIrdnovdEo1ZDl2a1JqSUpHV2tJRHBQRWdHTW9Mb0EzOENDcG5FdTFGeDZY?=
 =?utf-8?B?NFVPU0lpUEJrTzQvVFVUS3B3MnpscFBmaUZxbFFCYi93OFBwL3ZBcUdIOHV6?=
 =?utf-8?B?YjN6VnMwWlJ2OHJZNURCUnFtOWZqVU9Cbkt1clhVenpibXp0VmdEK1E2S3B4?=
 =?utf-8?B?ZEdhR0FQcWVYaVRTZGJmK2lpVGs5N0FsREE1bDRuZytNRWFTemxHcVFTYVAv?=
 =?utf-8?B?d1RmQnRDTGM3c1VqWnpsSy9MNDB4cloyTlI3R3ZNNW5NMk9hSFZNNXE2ek1X?=
 =?utf-8?B?TmdXR0NaSk9BeVRVbHZaQTlDcEg3ZUJDV2ZFTEFjY2VVWS9ocTEyaS8vOUhs?=
 =?utf-8?B?QXgxc2gxS3NTSU5RdDJKejROOTk3cHRXS0tNblJlWmJUUWt3eU1JbG9wemM0?=
 =?utf-8?B?bExheUNOczNGZkFqbEpPaHRucCtzNDlPb0YrbjJyTzhSbXJIckgvK2VjNGhN?=
 =?utf-8?B?R09YYTB5aE0xTldYWTlyWStyMFZUcCs5eldvb1ZBWXl3bEFVbDBkYnVoejgv?=
 =?utf-8?B?eU5nWmhsbVgza0JodkdWL3cyVDJoUm1jTnFoY3JYWnNPOC9CNHZ0dHNoMTVY?=
 =?utf-8?B?eU14ZVhuampmbW5JUHZUVVlrRm04SmtMU3c2ejlqRzRET1piZDFyb2FqZEVw?=
 =?utf-8?B?bExoL3BVLzV6ZXpwSlNEZlhGTWZKWDJkcy8rbnFxRG44Y1E3MFloOCtxNTBj?=
 =?utf-8?B?eHhES1hGcytGTmU5N2FUQVI4bFdmU2ViWTgzWmtzeEozVlQzaFh0cU5JZHRJ?=
 =?utf-8?B?SVhGL1V2M0NvTzc1NGM5NjY2ZHMzUHJNTnVqL1BIZGU2MVJMeVIxOHByQ24x?=
 =?utf-8?B?YUdyRFNzbTkrL0VPcDNRblkvUmlQd0tNaUw5RDlhSHMwaElxK284TTF6cm1a?=
 =?utf-8?B?alNlWVRDVDNJMmFQRUQxWTNySEVqYU92ZDdHM1NyNjRPdjdYektFOVZIQmlx?=
 =?utf-8?B?YVFOeHN2bytSeVN6Y0RYeVdFb0t0UlFJTS85OGdMM1pxMmNEclN1ZVg1ZmFX?=
 =?utf-8?B?ajNaejQ5Y2Q0Vng3NTlESmFxQWJpbWV0TnVBdFhVN1M3emVkM0ZCdUEzaG9I?=
 =?utf-8?B?YzN4NnJVV2J6SUFGL1pCeXdJTjZ0cWFXWUtnbkhLcmxjRk13UkxXdnJJazhm?=
 =?utf-8?B?WmRBUncwclhSTjZ1ZWkyMkEyUFpaakpSK2NJWitRYnU5NEQ3cWhVdXBGU3FI?=
 =?utf-8?B?OGdBb2NBdmZTaG85eEhDekhQd3VHNm5SRUZTRStQelJzcXFUVmlBSHJOV1p3?=
 =?utf-8?B?L2dPUlp5MG0zaVNkZlZTSmthbFI4YXRtUHVSY3NpS21heFUwallYNkNrZlAz?=
 =?utf-8?B?Y29rRVdyOGFMSEI3VDk0azRvKzV4QmY3TkNpTHh0WmlHZ0FCQ3J0WkNlMFJX?=
 =?utf-8?Q?16G4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339fdbe6-245d-4286-6a4c-08de1abaed66
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 09:25:28.1828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eyq9Zwwaj1My2+oKNsZOBVsp1DMn9TxzC48xxpQ7g8bCxB+GciargGvHFv6o69dhRR3gSFKvCroHilqLzYfEmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6897
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQgPG1hcmVr
LnZhc3V0QG1haWxib3gub3JnPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQxMeaciDPml6UgMToz
OQ0KPiDmlLbku7bkuro6IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPjsg
TWFyZWsgVmFzdXQNCj4gPG1hcmVrLnZhc3V0K3JlbmVzYXNAbWFpbGJveC5vcmc+OyB1LWJvb3RA
bGlzdHMuZGVueC5kZQ0KPiDmioTpgIE6IFZpbmggTmd1eWVuIDx2aW5oLm5ndXllbi54ekByZW5l
c2FzLmNvbT47IEFsaWNlIEd1bw0KPiA8YWxpY2UuZ3VvQG54cC5jb20+OyBDcmlzdGlhbiBNYXJ1
c3NpIDxjcmlzdGlhbi5tYXJ1c3NpQGFybS5jb20+OyBQYXRyaWNlDQo+IENob3RhcmQgPHBhdHJp
Y2UuY2hvdGFyZEBmb3NzLnN0LmNvbT47IFBhdHJpY2sgRGVsYXVuYXkNCj4gPHBhdHJpY2suZGVs
YXVuYXlAZm9zcy5zdC5jb20+OyBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IFNlYW4NCj4g
QW5kZXJzb24gPHNlYW5nYTJAZ21haWwuY29tPjsgVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNv
bT47IFZhbGVudGluDQo+IENhcm9uIDx2YWxlbnRpbi5jYXJvbkBmb3NzLnN0LmNvbT47IFllIExp
IDx5ZS5saUBueHAuY29tPg0KPiDkuLvpopg6IFJlOiDlm57lpI06IFtQQVRDSCB2Ml0gZmlybXdh
cmU6IHNjbWk6IEFkZCBjbG9jayB2My4yIENPTkZJR19TRVQgc3VwcG9ydA0KPiANCj4gT24gMTAv
MjkvMjUgOTo1NCBBTSwgQWxpY2UgR3VvIChPU1MpIHdyb3RlOg0KPiANCj4gSGVsbG8gQWxpY2Us
DQo+IA0KPiA+IEkgdGVzdGVkIHRoaXMgcGF0Y2ggb24gSU1YOTUgYW5kIGhlcmUgaXMgdGhlIGxv
ZzoNCj4gPiBVLUJvb3QgU1BMIDIwMjYuMDEtcmMxLTAwMDAxLWc5YmI2ZjJmYzBmNTcgKE9jdCAy
OSAyMDI1IC0gMTY6NDI6MDINCj4gPiArMDgwMCkgU1lTIEJvb3QgcmVhc29uOiBwb3IsIG9yaWdp
bjogLTEsIGVycmlkOiAtMSBOb3JtYWwgQm9vdCBUcnlpbmcNCj4gPiB0byBib290IGZyb20gTU1D
MiBQcmltYXJ5IHNldCBzZWxlY3RlZCBMb2FkIGltYWdlIGZyb20gTU1DL1NEIDB4ZDcwMDANCj4g
PiBOT1RJQ0U6ICBCTDMxOiB2Mi4xMi4wKHJlbGVhc2UpOmFuZHJvaWQtMTYuMC4wXzEuMC4wLXJj
Mi0yLWdhMjY2ZmY0NTgNCj4gPiBOT1RJQ0U6ICBCTDMxOiBCdWlsdCA6IDEwOjEzOjA3LCBPY3Qg
MTcgMjAyNQ0KPiA+DQo+ID4NCj4gPiBVLUJvb3QgMjAyNi4wMS1yYzEtMDAwMDEtZzliYjZmMmZj
MGY1NyAoT2N0IDI5IDIwMjUgLSAxNjo0MjowMiArMDgwMCkNCj4gPg0KPiA+IENQVTogICBOWFAg
aS5NWDk1IFJldjIuMCBBNTUgYXQgMTgwMCBNSHoNCj4gPiBNb2RlbDogTlhQIGkuTVg5NSAxOVgx
OSBib2FyZA0KPiA+IERSQU06ICAxNS44IEdpQg0KPiA+IENvcmU6ICAyODMgZGV2aWNlcywgMjQg
dWNsYXNzZXMsIGRldmljZXRyZWU6IHNlcGFyYXRlDQo+ID4gTU1DOiAgICJTeW5jaHJvbm91cyBB
Ym9ydCIgaGFuZGxlciwgZXNyIDB4OTYwMDAwMDYsIGZhciAweDANCj4gPiBlbHI6IDAwMDAwMDAw
OTAyMzNmYWMgbHIgOiAwMDAwMDAwMDkwMjMzZjYwIChyZWxvYykNCj4gPiBlbHI6IDAwMDAwMDAw
ZmZmNGRmYWMgbHIgOiAwMDAwMDAwMGZmZjRkZjYwDQo+ID4geDAgOiAwMDAwMDAwMDAwMDAwMDA0
IHgxIDogMDAwMDAwMDBmZGYwODljOA0KPiA+IHgyIDogMDAwMDAwMDAwMDAwMDAwYyB4MyA6IDAw
MDAwMDAwZmRmMTlmMTgNCj4gPiB4NCA6IDAwMDAwMDAwMDAwMDAwMWYgeDUgOiAwMDAwMDAwMDAw
MDAwMDAwDQo+ID4geDYgOiAwMDAwMDAwMDAwMDAxM2YwIHg3IDogMDAwMDAwMDBmZGYwOGJiMA0K
PiA+IHg4IDogMDAwMDAwMDAwMDAwMTNlMCB4OSA6IDAwMDAwMDAwZmRmMDg3ZmMNCj4gPiB4MTA6
IDAwMDAwMDAwMDAwMDAwMDMgeDExOiAwMDAwMDAwMDAwMDAxM2MwDQo+ID4geDEyOiAwMDAwMDAw
MDAwMDAwMDAwIHgxMzogMDAwMDAwMDBmZGYwOGJiMA0KPiA+IHgxNDogMDAwMDAwMDBmZmZmZmZm
YiB4MTU6IDAwMDAwMDAwMDAwMDAwMDINCj4gPiB4MTY6IDAwMDAwMDAwZmZmNjg4N2MgeDE3OiAw
MDAwMDAwMDAwMDAwMDAwDQo+ID4geDE4OiAwMDAwMDAwMGZkZjE5ZGQwIHgxOTogMDAwMDAwMDBm
ZGYyYzY0MA0KPiA+IHgyMDogMDAwMDAwMDAwMDAwMDAwMSB4MjE6IDAwMDAwMDAwMDAwMDAwMDAN
Cj4gPiB4MjI6IDAwMDAwMDAwZmZmYTc3NTAgeDIzOiAwMDAwMDAwMGZkZjI5ZjMwDQo+ID4geDI0
OiAwMDAwMDAwMGZkZjJkZDU4IHgyNTogMDAwMDAwMDAwMDAwMDAwMA0KPiA+IHgyNjogMDAwMDAw
MDAwMDAwMDAwMCB4Mjc6IDAwMDAwMDAwMDAwMDAwMDANCj4gPiB4Mjg6IDAwMDAwMDAwMDAwMDAw
MDAgeDI5OiAwMDAwMDAwMGZkZjA4OTUwDQo+ID4NCj4gPiBDb2RlOiBmOTAwNDdlMiBmOTAwNGJl
MSA5MTAxZTNlMSBmOTAwNGZlMCAoYjk0MDAyYTApIFJlc2V0dGluZyBDUFUgLi4uDQo+ID4NCj4g
PiByZXNldHRpbmcgLi4uDQo+ID4NCj4gPiBTdG9yZSB0aGUgcHJvdG9jb2wgdmVyc2lvbiBpbiBh
IGdsb2JhbCB2YXJpYWJsZSAidmVyIiBkdXJpbmcgcHJvYmUsIGFuZCB1c2UgaXQgaW4NCj4gc2Nt
aV9jbGtfZ2F0ZSgpIGluc3RlYWQgb2YgYWNjZXNzaW5nIHByaXYtPnZlcnNpb24uIEluIHRoaXMg
c2V0dXAsIHRoZSBJTVg5NQ0KPiBib2FyZCBib290cyBzdWNjZXNzZnVsbHkuDQo+IA0KPiBObyBn
bG9iYWwgdmFyaWFibGVzIHBsZWFzZS4NCj4gDQo+IEhvdyBkb2VzIHRoaXMgY3Jhc2ggZXZlbiBo
YXBwZW4gb24gTVg5NSA/IEkgdmVyaWZpZWQgdGhhdCB0aGUgcHJpdmF0ZSBkYXRhIGFyZQ0KPiB0
aGUgc2FtZSBwb2ludGVyIGluIGJvdGggcHJvYmUgYW5kIHNjbWlfY2xrX2dhdGUoKSwgc28gaXMg
dGhlIHBhcmVudCBkZXZpY2UuIEkNCj4gdGhpbmsgdGhpcyBpcyBlaXRoZXIgbm90IHRoZSBjYXNl
IGZvciBNWDk1IChob3cgd291bGQgdGhhdCBoYXBwZW4/KSBvciB0aGUNCj4gcHJpdmF0ZSBkYXRh
IG9yIGRldmljZSBpcyBOVUxMIG9yIHNvbWV0aGluZyA/IENhbiB5b3UgcGxlYXNlIGFwcGx5IHRo
ZSBkaWZmDQo+IGJlbG93IGFuZCBzaGFyZSB0aGUgb3V0cHV0ID8NCj4gDQo+ICINCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY2xrL2Nsa19zY21pLmMgYi9kcml2ZXJzL2Nsay9jbGtfc2NtaS5jIGlu
ZGV4DQo+IDAwNTk2OGU4Yjc1Li5kY2M3MWVhNDIyNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9j
bGsvY2xrX3NjbWkuYw0KPiArKysgYi9kcml2ZXJzL2Nsay9jbGtfc2NtaS5jDQo+IEBAIC0xMzcs
NiArMTM3LDcgQEAgc3RhdGljIGludCBzY21pX2Nsa19nZXRfYXR0aWJ1dGUoc3RydWN0IHVkZXZp
Y2UgKmRldiwgaW50DQo+IGNsa2lkLCBjaGFyICpuYW1lLA0KPiAgIHN0YXRpYyBpbnQgc2NtaV9j
bGtfZ2F0ZShzdHJ1Y3QgY2xrICpjbGssIGludCBlbmFibGUpDQo+ICAgew0KPiAgIAlzdHJ1Y3Qg
c2NtaV9jbG9ja19wcml2ICpwcml2ID0gZGV2X2dldF9wcml2KGNsay0+ZGV2LT5wYXJlbnQpOw0K
PiArcHJpbnRmKCIlc1slZF0gZGV2PSVweCAvICVweCBwcml2PSVweFxuIiwgX19mdW5jX18sIF9f
TElORV9fLCBjbGstPmRldiwNCj4gY2xrLT5kZXYtPnBhcmVudCwgcHJpdik7DQo+ICAgCXN0cnVj
dCBzY21pX2Nsa19zdGF0ZV9pbl92MSBpbl92MSA9IHsNCj4gICAJCS5jbG9ja19pZCA9IGNsa19n
ZXRfaWQoY2xrKSwNCj4gICAJCS5hdHRyaWJ1dGVzID0gZW5hYmxlLA0KPiBAQCAtMzM1LDYgKzMz
Niw4IEBAIHN0YXRpYyBpbnQgc2NtaV9jbGtfcHJvYmUoc3RydWN0IHVkZXZpY2UgKmRldikNCj4g
ICAJcmV0ID0gc2NtaV9nZW5lcmljX3Byb3RvY29sX3ZlcnNpb24oZGV2LCBTQ01JX1BST1RPQ09M
X0lEX0NMT0NLLA0KPiAgIAkJCQkJICAgICZwcml2LT52ZXJzaW9uKTsNCj4gDQo+ICtwcmludGYo
IiVzWyVkXSBkZXY9JXB4IHByaXY9JXB4XG4iLCBfX2Z1bmNfXywgX19MSU5FX18sIGRldiwgcHJp
dik7DQo+ICsNCj4gICAJLyogcmVnaXN0ZXIgQ0NGIGNoaWxkcmVuOiBDTEsgVUNMQVNTLCBubyBw
cm9iZWQgYWdhaW4gKi8NCj4gICAJaWYgKGRldmljZV9nZXRfdWNsYXNzX2lkKGRldi0+cGFyZW50
KSA9PSBVQ0xBU1NfQ0xLKQ0KPiAgIAkJcmV0dXJuIDA7DQo+ICINCj4gDQo+IFRoYW5rIHlvdSAh
DQoNClUtQm9vdCAyMDI2LjAxLXJjMS0wMDIwMC1nZjk5YmE5YzAyZGIyLWRpcnR5IChOb3YgMDMg
MjAyNSAtIDE2OjQwOjAzICswODAwKQ0KDQpDUFU6ICAgTlhQIGkuTVg5NSBSZXYyLjAgQTU1IGF0
IDE4MDAgTUh6DQpNb2RlbDogTlhQIGkuTVg5NSAxOVgxOSBib2FyZA0KRFJBTTogIDE1LjggR2lC
DQpzY21pX2Nsa19wcm9iZVszMDFdIGRldj0wMDAwMDAwMGZkZjFlMTkwIHByaXY9MDAwMDAwMDBm
ZGYyMDAzMA0Kc2NtaV9jbGtfZ2F0ZVsxMzhdIGRldj0wMDAwMDAwMGZkZjJhMzkwIC8gMDAwMDAw
MDBmZGYxZTE5MCBwcml2PTAwMDAwMDAwZmRmMjAwMzANCnNjbWlfY2xrX2dhdGVbMTM4XSBkZXY9
MDAwMDAwMDBmZGYyNDIxMCAvIDAwMDAwMDAwZmRmMWUxOTAgcHJpdj0wMDAwMDAwMGZkZjIwMDMw
Q29yZTogIDI4MyBkZXZpY2VzLCAyNCB1Y2xhc3NlcywgZGV2aWNldHJlZTogc2VwYXJhdGUNCk1N
QzogICBzY21pX2Nsa19nYXRlWzEzOF0gZGV2PTAwMDAwMDAwZmRmMmM2OTAgLyAwMDAwMDAwMGZk
ZjIwYzUwIHByaXY9MDAwMDAwMDAwMDAwMDAwMA0KIlN5bmNocm9ub3VzIEFib3J0IiBoYW5kbGVy
LCBlc3IgMHg5NjAwMDAwNiwgZmFyIDB4MA0KDQo=
