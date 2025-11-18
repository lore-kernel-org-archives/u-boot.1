Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9573BCED603
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 11:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4C1C83C98;
	Tue, 18 Nov 2025 12:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sttls.nl header.i=@sttls.nl header.b="meL8y5tP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A2EA83CE8; Tue, 18 Nov 2025 12:04:11 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F206B83BD2;
 Tue, 18 Nov 2025 12:04:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Maarten.Brock@sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMmXIQhyRFJ5nn1r+eZehovfWn4eIrNl7Mf9H1T+f2Bx8oDBatlZRUx8FtfkVCG1cltUIMUL1b5SqYh0iMuwyrEmS9IVhqvD5Wz1w1luh/bR5HSv/5s8UgNKWe58ecYQbpD0OoC7LLulJnc64mXq1F5ODGhTVwG9/lzK0NxttsbBtiAb0BmQ9w78vDa+Ytkjw2WqoBA+/n9IVinPdUX9vQXbl1+2E4LQiszXwp/2o7aB3kLP+FqbBh92iOifO28KBB/pNCVRZ8z4Cr/L4t4cZKka8LSb4JFSjYcbgREM1Z9fWY/P60hPuLbsOfh85ShvowluvQKAW43oscRWc/UUoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62CGcokhxc2+qC/yQ1+uV7TxpxGYZge96c0nAvRX61s=;
 b=PEH0k3N/DIJK0wyAoJxPZwRtPPl6wb5Zb+/9JtjhcTbIIPAMxgAmAiIyl9t+OnozBr2X4YLnq7PfZb8jcOphlh/MHbTfMKWbvIsOnGDMop5L/bXsv/uQ+pscGyt9+RwQzd7Gh6mJ+qTzlQZkSSrEDkWJcNN9Q1lsPrqQhzUZZeHQokrDvmvA/IDi4p9/MZLgNMfqu1Ir9MRC7aGj5P7xhuiv+8T4vRVeTn9GWIWp5HXlb474H5W7BNZ5mJ26rQOy3IXNZtVhZsz54i4dDi93PgvL90sicRWSDpTgoRS0fSzH+UQy/+IFHpItFsXmzcTh5zMxrbdpo9LXBihiyNsKRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=baylibre.com smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62CGcokhxc2+qC/yQ1+uV7TxpxGYZge96c0nAvRX61s=;
 b=meL8y5tPl7DkLFCX7hvna6VAQpuDFw7SiTAfkOtje+JM/r69GUeZ6tTAlq/iThaoxqn5zHaEJD9tXQYrUulQKd0OyTzMDw29r0P3HSqcsbdRIkUfRDitb3mA8SDWiByGURaJ6/xzvLEvTSR4zMI9wQML7Yc1sKdu3lxaBoDDR0o8ObGjSDIEfcnPX6zU4Kf97mfTWUZgOsc2qt8LWDP78ZvkefRkmlUGeZPVYYv4SnE/rPL4jM84pl2Vy2eBdN1Viu4CwrABSGV80ZkKKGsEv1BYi2U5E3GC6V6pe6xJ/A0g1N+uNzYcTaeRddRFpFPkzY/r16pVKdN2/1sv412AKw==
Received: from DB8PR06CA0053.eurprd06.prod.outlook.com (2603:10a6:10:120::27)
 by VE1PR05MB7312.eurprd05.prod.outlook.com (2603:10a6:800:1a2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 11:04:02 +0000
Received: from DU6PEPF0000B621.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::1f) by DB8PR06CA0053.outlook.office365.com
 (2603:10a6:10:120::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 11:04:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DU6PEPF0000B621.mail.protection.outlook.com (10.167.8.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 11:04:01 +0000
Received: from DB3PR08CU002.outbound.protection.outlook.com (40.93.64.80) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Tue, 18 Nov 2025 11:04:00 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by AM7PR05MB6882.eurprd05.prod.outlook.com
 (2603:10a6:20b:1a0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 11:03:56 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::8532:a1ae:4fc1:3b89]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::8532:a1ae:4fc1:3b89%3]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 11:03:56 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Markus Schneider-Pargmann <msp@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "jerome.forissier@linaro.org" <jerome.forissier@linaro.org>, Kory Maincent
 <kory.maincent@bootlin.com>, "sjg@chromium.org" <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, U-Boot <u-boot-bounces@lists.denx.de>
Subject: RE: [PATCH v2] board: ti: am335x: Do not call disabled PMIC functions
Thread-Topic: [PATCH v2] board: ti: am335x: Do not call disabled PMIC functions
Thread-Index: AQHcK6J2k0ARc/vCB0CQFuDa/taEm7T3ojYAgAD7MuA=
Date: Tue, 18 Nov 2025 11:03:56 +0000
Message-ID: <GV2PR05MB1194196AFF3F1A7A9B0DFDAD483D6A@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <DB6PR05MB4551D31271569EC04E8EC60F830CA@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250919001117.GA974973@bill-the-cat>
 <DB6PR05MB455171F726E8D6E540141BAE8311A@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250919141058.GT124814@bill-the-cat>
 <DB6PR05MB4551C51511978A6DF29228188311A@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <DB6PR05MB45511C9367B93E1E788A543F8312A@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <DEB8J4DXE9QT.1U8RYJB4CU0N8@baylibre.com>
In-Reply-To: <DEB8J4DXE9QT.1U8RYJB4CU0N8@baylibre.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: GV2PR05MB11941:EE_|AM7PR05MB6882:EE_|DU6PEPF0000B621:EE_|VE1PR05MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fdcf775-286f-4dbf-e0ec-08de26922e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?Q05nOW1kN09aU2hjWlJUdnBRM3ZEaGFDV0NXak41U3Jubm13SHppRUdwelRn?=
 =?utf-8?B?RUxxK1JWQnVvOVoxMzlLbG9oZDNZSXhsY3czWVF2a1RjNUhlaHVsaUxFNVo1?=
 =?utf-8?B?UVI1Sm1BSVZHc2xjMjIzSWVWTGJNK1JnM01hZ0R6U1ZVM1dTbnV6RVQ4c3RU?=
 =?utf-8?B?Z0pad0JoUU1vTnhMcWlPdnFtSnNnYlJNUnpib01pbnQ3Y3g3S3ZZR0c0ZTlu?=
 =?utf-8?B?b0xuZGZLeHFlL2RWMDlpTi9Gby9jL3VqZTlCNUh2OXpTU1hFeVEwU3lXL1Yy?=
 =?utf-8?B?dUZhdkExOG5sLzkxeXJGMVVxMElNalhLdElxUUt5b2hOTUxKaUEyL0djWE1V?=
 =?utf-8?B?UTRwaFJLcWxRdHZnVUpYclNPemtSQzJrZCt2VmdMWTNadWxyV1VpZENsRmZS?=
 =?utf-8?B?dmhlZUZkbWsycmZaeU9Ucmg4ekF0NmlxdTN4aWRJcGFDS2NHZkk3U0p3UUk4?=
 =?utf-8?B?VXVKbWNacmMxbnZLcXhTanZaYkhNNi9mcDhWZHhUQ0FDMXlsS2ltNi8wOFUv?=
 =?utf-8?B?Y0JLRXRtU2pTV29iTW1yb0F3WHoxY1dqT2tZMEVaSCtjeHduUXdEOXBsSjlW?=
 =?utf-8?B?ZC9FaXhJVW5zTmF4a29nNlZZbjVLUUZmdEx4NFNqTVNyS3kzQnVuUUdpd0Vy?=
 =?utf-8?B?MExDQThjM1RML1k1SGlUWGdiN05oS0JyVEhpMUxKaFpLdGhGbTZQZ2VkRVJL?=
 =?utf-8?B?ZXdvdkhSb3g5TkdHVDlIRHRpYkVSc01wVVJHZHNaUmdsSVRkbThwYk9vUG4v?=
 =?utf-8?B?cnNlOGlYUUNpeC9KU1ViOHpnWmN4dVFtdUIrZUVGZHFxY1U1dUJxdEhJeWYy?=
 =?utf-8?B?SUpRSXo1VzlOVlR1QS95TjZqL3JSTFp6VXJKajRQdUNyeVR2MUkzQjUvYm9t?=
 =?utf-8?B?U3FVeDJNa050bEVNMlVVbW1BRUlDc0tKNTNXUjlpRWhyNTZJMURCUHR4T0lG?=
 =?utf-8?B?RW14TmFObTAwNFVpYnFwT1FrS3JnWW9jVnNQRG50REgzU013NDF5RlZVazVQ?=
 =?utf-8?B?WWNEZHd5M3NYcU5nS2hwLy9ZaEk3VDVaNGhmTlFnbzdBazA1V1JQenZOYkQ1?=
 =?utf-8?B?RFVzVFgrYTdQNUdicCtOOWt6by9KUDdxT1kzeU5BajNsemZDWTNNdVcwSXcz?=
 =?utf-8?B?b2tmZm1kQ1orS2h5VDhzZUN0bG12OFNrWlB1OTBRSDVQTkVib044dTdsL0Vu?=
 =?utf-8?B?aTFWRFFNcTl0SXVZcWc5NENGZTZ4Kzg4eElPdm1PU0dTN2dTdk8xSWFpOXNy?=
 =?utf-8?B?aStyWHZLb0U1YUVkc0FxOUdtQ3puWDZzSkVsZFk5WVdnemRwb0JxN0kvQ2xM?=
 =?utf-8?B?UnZwdCtyNFBnc0hMNFdJc0hpS2t2b1lWbTdLT2JqUytZQW92UmxHcy9iaDVI?=
 =?utf-8?B?V1R1TTFMOVZNa251ZlE2S2hpdnA2dFRsREpOWFJmc3JuVWhpc3YwVnozcGRr?=
 =?utf-8?B?UktNdmh6WUxJQWcwNUk2UDI4M1YxV280OGYrc0k1R0hkQno3UXg1ZzZiK0tE?=
 =?utf-8?B?a0VGK0xGTWpYaWtBTmRnVUVTRG1ETXIraGc0WStPMmNaUXdnTnpiOUlLK3Jv?=
 =?utf-8?B?QjkwKzBYU0VUaFZPRTZUTDJZODI4bDdYN1dOdDNubVlzWURYcC81eDNQckU5?=
 =?utf-8?B?cGduU2tJSDVEdHg1T1VJcG1yNzY1a0pvNHhHWTQ2bnhkdkE0YmpXK0lFVEhZ?=
 =?utf-8?B?T2hYaTZIdEtKcTVVZGRyZ1ovbFFWc1RLR3NQTkkxL3JIOUxnbE5sU1BFcnY5?=
 =?utf-8?B?T0djVnNaODlhVk50MjBCNDJRQ1g3Q1dIcGc1YU0yMnVaK0tiV2JJYnM0NWcy?=
 =?utf-8?B?em5iRVMwRDlqNEcxSWpobGt1NW9PNXA2Y2RqRWFDVXIwamx0RFY3M00reGdE?=
 =?utf-8?B?MlYvSWc0SmNLMGhxMUJ2aGVNUG5XUGgyTFJTWVdrczRoT0VYdFhxVDBKd09I?=
 =?utf-8?B?bExYenA0b1grdGoycWFQeTJnWkVsKzE5TGdSTTRqQmFsajhIQk9CVjFLeVkr?=
 =?utf-8?B?Q2hLeDAxNzFtT0RZMlJiRDZNWE05VnloWDYwZThoSmVJeWsvWUpNVksrenNn?=
 =?utf-8?Q?L9jQ/k?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV2PR05MB11941.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR05MB6882
X-CodeTwo-MessageID: cc8d667b-7ffe-4926-8dc4-76230a7eaaf0.20251118110400@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000B621.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4c8d35c5-c408-462f-f33d-08de26922b0b
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|14060799003|82310400026|1800799024|35042699022|36860700013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHFONkxZbnJrZkxibGRqTzlPcUh5VmlDakVnNm9ycWRsa2g4R3ZkcVdKMlJZ?=
 =?utf-8?B?NXhIZkxuMnlVRzJBNEd3Q1FEMGpaRFhvYXpNRTVoNHF0OVFlY28xT21hbWgz?=
 =?utf-8?B?TnRsbmx5U0tIeUN0WWZoZjlMUTFMMGdvMTB5VGdqYWVrbE40ekQzSERJZW5a?=
 =?utf-8?B?dVdpVlc0L3NDVWFkVmFlWU1acm1PMkhiQ21xdWJFZUVQb1pzckhmNWUxdkFn?=
 =?utf-8?B?SXpSMmhQN0lsMU1FcVJlQ2ZVYlZ2NVZ5NWR4N0RFbG1oM0JudjcwRFdIN0Rr?=
 =?utf-8?B?Szl4ZmdRMEV1MjRvT0wvQ1VpK0U0U09oM1o4N2tDVFVkNHdKUCtkVU04RjhT?=
 =?utf-8?B?akxwVWE1Z2o3T3lzVXZGWFpUU2VsYnA0UGU1M2QzWGRYRzJpcWlYcWJMaDFE?=
 =?utf-8?B?WGdrWmo4R0VUd1kwTHlxVGZSaElDMldKMXNpSmVaS2ltMjdpVElBd296cGUz?=
 =?utf-8?B?NThFd0s3K1YzNlhpa3FDYWI0UjdOSmJSd1JuMk9oUDlJM2xCNmFMU3dyNGRx?=
 =?utf-8?B?VjlvOVRRangvbEE5ZHVVN2pCUm1pUnhFOFQ1bUxybklTRHBUMVpvK2FQT2VC?=
 =?utf-8?B?NWorQ0lyMzNtSkhXaTBSaVc4UWd4OS9lMVZvWi9YaUtSWXZWcVBxZld6d3B2?=
 =?utf-8?B?bUJuRUw1dDMzMUxWZkJoM1RNU0F3WS9oRlZKZDFScDVPS3U2Mi9panBxbTRX?=
 =?utf-8?B?V0Jta25VY21wb1NoWWlZeGpMa252dmJpUUloTHVwQXFyWmNhaUZybFZoN1JI?=
 =?utf-8?B?cHpvaTViVlJNdWdUY1RhTTBmZ1liSGxiY0tVa0RvaVQzdGc4NFRvWHdFdEFP?=
 =?utf-8?B?eGtsazAyM0Y4bXpUUTFIcHFKbHpDNndoRElPcTBXcytpckxnYXBkN1Bpc0NG?=
 =?utf-8?B?L2RZeWhNQlpRajhXMUZVQ3VQcTY4cXJoUDRRdXBxZm14VDdlZEhGM2tlZHJj?=
 =?utf-8?B?a3RMK0NkYTRhMFg2SHpxU2pqd3FFNzFLWlY1TVNlNEZZMXJGY2I2UldnZXlp?=
 =?utf-8?B?bkNZcStWWFhuZzl1NlphZmx1b2hzYzhua1Z3QXYzcG9LVU9vOHlsQWFDZFVm?=
 =?utf-8?B?SXpzT1VvbytrVDlKbmU5bkNERkg4NVJpYVhKbjNoK1dYbVJ1cXMxdnA0cVAy?=
 =?utf-8?B?RzVmaE4zSW5LK2l1Vk1OUmdnUS9weE03bGR5aTJJSlJxYU1zUmN2Y3Ryd0lH?=
 =?utf-8?B?YVJsQ0VCV0hHcldESjI5cWdKVGh4MGNkN3N5NytQL21YSWUvU3hHY1RGdVVu?=
 =?utf-8?B?bDFuYjNHcnkyNjNscGNqaDRWSHdxTWJSaUpPL1hFa0ZTOVN6bWN4bnRrMlpI?=
 =?utf-8?B?ZGsyZHp3ekJVZTlWZDRjc1JiQnJsb3BSSlM4V0xoRlVXQlFlUFVDSTFUQXF2?=
 =?utf-8?B?QzlhRGZwcHA4NUhQUTZIUW55djZGSFNwQy9xUkJabkF6eUlIYjU4Q1RaTnMv?=
 =?utf-8?B?V1BRY0JDd0VDSEZRSnBPcFNCUEh6RlFhSE1sS0MvY2xIU2JQYkFkb25UVmJE?=
 =?utf-8?B?amU0dWtpbFNRNnNrNGhzK3ZreUE4VzluTW5UanlIalduMTV6dGNBYVhFMFp0?=
 =?utf-8?B?UHlHYWcvU2Nxc2crMHNuY0FDcGpIanhEVGFoaXNzdXlndlY1czFFOVFud1Np?=
 =?utf-8?B?RFhFTWdSajJNY0Vha2FndkRQSDE5cWFxODIwWlJLdXVIay8xaE41R3YwTXhX?=
 =?utf-8?B?Y2lHTzJ2aldSS20yaUtQR3FWNXZqVVZ4WEIwR0FyM2lIL3NqMEJPaEo4aVpG?=
 =?utf-8?B?TXdVTGIvRGpZS1Z2c2pSbVp0d2kxK1lEbGxjeE5DdEllcmNreURoTUVVcUFY?=
 =?utf-8?B?c0ZXUWxjOGkrSU05VXYrOGdHV3pkY3VCaFFtRnNCV3pOQllYN1Vxdml5dTFE?=
 =?utf-8?B?WXpGWUpVcDIvQkVIcEZUb0toU0hKUUtKRHR1MzNvQXpSVkhVNFNXdGcrRmN3?=
 =?utf-8?B?aEtQZDVQZFBsRVlWYVU1VTNpZkVKTGNoR1hQd2F2VXFRV2wxNk5MVlVHaEdW?=
 =?utf-8?B?THU1eU10RW1lWFppYXNra2U3NU51bGI5Rk0wNzlLSlVqazRNMEF1QkpNRS8v?=
 =?utf-8?B?Tk4zdG1kMThySzlrcjhXRG5Cdk9GZGQ2cFo2Z09FdUhBOGdnMmNmV1FVNDZy?=
 =?utf-8?Q?H5Gg=3D?=
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(376014)(14060799003)(82310400026)(1800799024)(35042699022)(36860700013);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 11:04:01.3877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdcf775-286f-4dbf-e0ec-08de26922e33
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B621.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR05MB7312
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

SGVsbG8gTWFya3VzLA0KDQo+ID4gZGlmZiAtLWdpdCBhL2JvYXJkL3RpL2FtMzM1eC9ib2FyZC5j
IGIvYm9hcmQvdGkvYW0zMzV4L2JvYXJkLmMNCj4gPiBpbmRleCA0YWRhOGI1MzRjMS4uNzEyODE4
ZWMyMzUgMTAwNjQ0DQo+ID4gLS0tIGEvYm9hcmQvdGkvYW0zMzV4L2JvYXJkLmMNCj4gPiArKysg
Yi9ib2FyZC90aS9hbTMzNXgvYm9hcmQuYw0KPiA+IEBAIC00MjYsNiArNDI5LDkgQEAgdm9pZCBz
Y2FsZV92Y29yZXNfZ2VuZXJpYyhpbnQgZnJlcSkNCj4gPiAgew0KPiA+ICAJaW50IHNpbF9yZXYs
IG1wdV92ZGQ7DQo+ID4NCj4gPiArCWlmICghSVNfRU5BQkxFRChDT05GSUdfRE1fUE1JQ19UUFM2
NTkxMCkpDQo+ID4gKwkJcmV0dXJuOw0KPiA+ICsNCj4gDQo+IElmIEkgdW5kZXJzdGFuZCB0aGlz
IGZ1bmN0aW9uIGNvcnJlY3RseSwgdGhlIGZ1bmN0aW9ucyB1c2VkIGZvciB0cHM2NTkxMA0KPiBp
biBzY2FsZV92Y29yZXNfZ2VuZXJpYyBhcmUgbm90IGRlcGVuZGluZyBvbiBDT05GSUdfRE1fUE1J
Q19UUFM2NTkxMCwNCj4gYnV0IG9uIENPTkZJR19TUExfUE9XRVJfVFBTNjU5MTA6DQo+IA0KPiAg
IG9iai0kKENPTkZJR19ETV9QTUlDX1RQUzY1OTEwKSArPSBwbWljX3RwczY1OTEwX2RtLm8NCj4g
ICBvYmotJChDT05GSUdfU1BMX1BPV0VSX1RQUzY1OTEwKSArPSBwbWljX3RwczY1OTEwLm8NCg0K
WW91IGFyZSByaWdodCBhbmQgSSBhcHBvbG9naXNlIGZvciBtYWtpbmcgdGhpcyBtaXN0YWtlLg0K
DQo+IEkgYW0gY3VycmVudGx5IG5vdCBhYmxlIHRvIHRlc3QgdGhlIFRQUzY1MjE3IHBhcnRzIG9m
IHRoaXMgcGF0Y2guDQoNCkkgcmVjaGVja2VkIHRoZSBUUFM2NTIxNyBwYXJ0IGFuZCBzdGlsbCB0
aGluayBpdCBpcyBjb3JyZWN0Lg0KDQo+IEkgd2lsbCBwcm9iYWJseSBzZW5kIGEgZml4IGZvciBh
bTMzNXgtZXZtIHRvbW9ycm93Lg0KPiANCj4gQmVzdA0KPiBNYXJrdXMNCg0KS2luZCBSZWdhcmRz
LA0KTWFhcnRlbg0KDQo=
