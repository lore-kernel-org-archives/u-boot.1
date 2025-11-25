Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7B9D0E6ED
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 13:55:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B1D684073;
	Tue, 25 Nov 2025 14:55:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sttls.nl header.i=@sttls.nl header.b="ANFRj34y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF8778407B; Tue, 25 Nov 2025 14:55:32 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6FC88404D
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 14:55:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Maarten.Brock@sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j602rWBxu/XMwik8QcNqOBjt1OyKxaVMTaKGeHZrSidsrnmZQSvriIP8EvoDLhRKOaej08yEG6AmkkBW3R8v0KCxhkdqw9aJJeWjLtf6uNYLsMWhnTsoty0bDW6KmOEk4CprKM9QDuItPXyiFnqZeU1L/452yzhlXP4iimlo3HNZfPExv1CQ2O2HgCAPF/c3ODogtuI6sTuaexUY43PrGqGeamoQLE4MRvWEt/HxWAtf6nhfeJtzQHZ3uxi20gJI35MFGCNjyTcCBhn/6swxmzjUwoGl8z0JF8W6m0cshBc8iKb/o5PjOitPxqYMFnx8ZlDdf0EBCQElWUcaDF2djQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuWnA286ITAOISC4Jykpfk/qIRcPPkkFlZkHXRVbU5g=;
 b=jRm28ba3GC+akbpYdrwpYw6dh9ADAMqJPuo4n5cbJEqPfJJ9nGPG0CV+nKdNduRfikDl4AydyrrQ04ybPayQihADkcoYij1bf/zvWlGNJ3/WFuh4fADd1zTP7l2wZgU0gE6o5yCEKHFvsrLJBvvy01wMLMNrj7kYbMVNsfdyRBphRU7JK71cPmBF28NIpZtPAgEO1d93J4Fp3wN+kveFNT/aHsgVAZ7T6k+U4OLI5UEw1spfr1JgCtowmVpREJvHzD0MAyb02VR+46ZA9yXcmPkjzyXOehdhnphWSOKmWuc0y2zwKNu3wrC8Pt54j4ZLE97b9WiVmrVRsXUPUdHTvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuWnA286ITAOISC4Jykpfk/qIRcPPkkFlZkHXRVbU5g=;
 b=ANFRj34yBaCNN0tz1L+rxxYGwMzNwDLz8zHVFht+se3vSmj8aDGDaTEo9w/2bnugGSjpvjrajX0JtiYbYEfs8D2dCNCxgM9XHjHC90l42656jP8mkb9Z0xDHzqyRwZmppWXR9R4KdxgHXfB3PcRVcSL+r9QWdO+MnT5BYSVZg9+ZFmXzA6SAB8JlfeYxosNcT5pKbGFgduecXei00eIBU4V9hfScF3zxofWTYXwaaOoV98MXOINDwugFKE12Or1lgaWU04n80vZxRshn/EfbtADjZSNXcLdi80eKmW9Y/Q08UZoyO3FWT1N0AFp6mc7YRtQu5uPIc7yFONceUdL1+A==
Received: from CWLP123CA0141.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:87::33)
 by AM7PR05MB6995.eurprd05.prod.outlook.com (2603:10a6:20b:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 13:55:27 +0000
Received: from AMS1EPF0000004A.eurprd04.prod.outlook.com
 (2603:10a6:401:87:cafe::a0) by CWLP123CA0141.outlook.office365.com
 (2603:10a6:401:87::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.18 via Frontend Transport; Tue,
 25 Nov 2025 13:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AMS1EPF0000004A.mail.protection.outlook.com (10.167.16.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 13:55:27 +0000
Received: from GV1PR07CU001.outbound.protection.outlook.com (40.93.214.101) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Tue, 25 Nov 2025 13:55:26 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by AM9PR05MB8578.eurprd05.prod.outlook.com
 (2603:10a6:20b:3a7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 13:55:24 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::8532:a1ae:4fc1:3b89]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::8532:a1ae:4fc1:3b89%3]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 13:55:24 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: U-Boot Mailing List <u-boot@lists.denx.de>
CC: Kory Maincent <kory.maincent@bootlin.com>, "Markus Schneider-Pargmann
 (TI.com)" <msp@baylibre.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] board: ti: am335x: Fix DM_TPS65910 condition
Thread-Topic: [PATCH] board: ti: am335x: Fix DM_TPS65910 condition
Thread-Index: AdxeEXYjcrlv7zAWRnyB3bcdZEXGEw==
Date: Tue, 25 Nov 2025 13:55:24 +0000
Message-ID: <GV2PR05MB11941393665E8D8E4EC9BA1E883D1A@GV2PR05MB11941.eurprd05.prod.outlook.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: GV2PR05MB11941:EE_|AM9PR05MB8578:EE_|AMS1EPF0000004A:EE_|AM7PR05MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 564035a4-348e-462b-39bd-08de2c2a49cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?aDlyRkl6MS9JVHlmQk9JQmtsdzZIbGlTOWlWczkvK25nMGQ1WTFPRGFWVW1p?=
 =?utf-8?B?ZFRRajUwMythbWVOZUdabVg1Uzk3a3B1dE1yQXZRL2psczNOU0pkQUZPUm9x?=
 =?utf-8?B?cXBYVndVZXRyeHZxOGF4blM1MHNqdXN6ZjhRSml0NHpmTlQ4d0lSUXlFTW5N?=
 =?utf-8?B?a21WQ0JMdlJzWGdNSGhlaDQwNmJuRS9FTFAzd1VtRDFOQ21nalB0ZnJpODZL?=
 =?utf-8?B?R1p3NDRKYXZNeDZSejRHT1RJeHZEdHFzMnQzVlRIYk1uVFBBRVR5TWY1dzB2?=
 =?utf-8?B?aVZQM1E0cjBxSXRqTm5Qa3hJOEZieVk0VmIvN1VGTUhxSisrWU5jbXZDK0Q5?=
 =?utf-8?B?NWFIN0tzSmpicWVHT1JnRUo1dEpmZHU3Qmo0VWJ2WVlKOCsrUHg0Q05tU2Uy?=
 =?utf-8?B?eFlHQ3oxL09TS0QvTzVDSk9EZjI0NTdJOEJzNkp1dk8yQVMwM1FtaE9YbVdh?=
 =?utf-8?B?bFRFMFR3NGV1WTJyQlBuOEJRWmwzY2NabUFSOWdOd1ZPMkZnQUtKTUFiNkFk?=
 =?utf-8?B?bS9WMGJ6QlFZd1RzRjhtQWRpQTgvaks2dFJUMkZ2NnpvY0tIRmJqRy9aN1FN?=
 =?utf-8?B?VTBJNWtacHhjZzBMbHJtai9tYm9UOE1IQlV4NTRFQW5XLytKNnYwd1A1TVlK?=
 =?utf-8?B?NUdTZ1lpb1ZqbGtDWWZCTW1JeEFjRjJkR0hLS1RJeDVreXoyM2hCS2ZLd2FV?=
 =?utf-8?B?bm9DeWYzQWRhMTVnck5WbVRVdnovWjlqUmhNdWxlcm5tRlNXeHNZZkRHUGJE?=
 =?utf-8?B?dkVzKzJRT2kzQnFrVDkzOW5URnN1czVrMTVCYUx5OW1WT1M5UEFRVFduRU9N?=
 =?utf-8?B?bi9IbXJzNkxva0dvd0d4bjlzalVWZ0RIc3pkOEVkZnRjR2NiRkJib2JrL21r?=
 =?utf-8?B?V2VoSjJlMTJaekxBaU41UHVPVXpKQmw5VVJleVRrdEUwVkJudUpJKzhsWDln?=
 =?utf-8?B?ZlMrRi85endybTNCdVR5bU1VWVZsdXVCWEl1cjlBenJpSjYycW9mQTlzeDZh?=
 =?utf-8?B?T0JBU2Mrc1ZTMGgyUGViOFBMTmNkSEhQK2hhenNFMXRGVVhCMUNRTTJZM2NT?=
 =?utf-8?B?eENzMG5xVzZ0ZU9QYWNINjBIcVJaTlZ2b1dlODJqdlVqT01kVXRoTGN5ek9X?=
 =?utf-8?B?QWVjKy9LL00rM3M3TTB5TVVlK2h1cE9OR1ZpZGtDK2JwdXBYc25UVmdndmdL?=
 =?utf-8?B?Znp1cCtaTHgxNVorME85OFZyYlkzZFgrVEMwejNLVC9ka3prWkp6Z2ZKeUtT?=
 =?utf-8?B?Z1dKS0lNeXUwSjcvT0RVM1oyZTVtZWNxSmVDZi9TRnFHZWl4WTZNSzIzNysw?=
 =?utf-8?B?OERwN2lNTzU5QVo3WHVMblRMS05ySHBla1Awdlk4SU55Q0lqdW5YSVFmTm0y?=
 =?utf-8?B?am5qa2lpVXdweGxaVFNvay82S29YTGp5RFpZL2w2MHlOeEpLNFdwcFZYV04y?=
 =?utf-8?B?QUR2WWxobmZ0bGpKYzJId2R0R0VlYUpTaGwvWmdZMVhQYVV4Wld1OVYrWmpB?=
 =?utf-8?B?enZLRSs5K0RTblRiWVBzUVUxLzdJZ280bU9Dek9wNUZHMDhOWEdkbHlubHNM?=
 =?utf-8?B?Ym9jZE1LSXNhNWZHY21TT1ZjVjZneGZQSmJZck9QcnZ5ZFZzZDJoa0dLemM2?=
 =?utf-8?B?Lzk4ZUJQd284a01GTmZFMHgzMGxXSkp0eXd1Wng3NklFOXRValIxNXpyazlH?=
 =?utf-8?B?ZHJlM3Rhb3AvUkorNEdaNmI1YTdqbmpjZGRZWEtGc3Z0bUNHZnhEWmN0TXpQ?=
 =?utf-8?B?eE1ISGNtVDRRblYrNlFKamlKMEt6SThKZkJJV1BRVHo3T0R1OUdaR3FMMUhO?=
 =?utf-8?B?YUZVQWt0Uy9qWThDRDRDTFptZWhMSnUxQzVLWHQ0Z1VHaDJvb2lLWHZCdGIx?=
 =?utf-8?B?ZWtMdVJ0cHZvZ3pkKzd5UXlHM1pBTUc4cjVrT3RFQWdTazBVbEZ3V3k2Wm5h?=
 =?utf-8?B?T243ZG5wNUwrZVo3RW5aVkoycHB2Ui92VFVEVXE5N2g4WTlZMDdyMEJFUXIr?=
 =?utf-8?B?TXZSOXFtdk5henNkZWlLbXo3dmlBSEhPMGRLenN3L2lmUnpnTHNFY2FKa0lt?=
 =?utf-8?Q?HpfR+o?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV2PR05MB11941.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700021);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR05MB8578
X-CodeTwo-MessageID: 47eecf4c-6f71-4f70-969a-48cdb89eeac4.20251125135526@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fea4d184-c705-4e7a-125b-08de2c2a4813
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|36860700013|35042699022|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emFBQWJoMG9UNVpKOUJTMUhwaHBTdHA2NEtkSGZSVkY2dHl4amZoSHp4QVpu?=
 =?utf-8?B?Nld2MXdFSFVIemVPUk1CY1JJUW5FVlhpMFNLTW1odzkzQUlvamFxaEZjSmlI?=
 =?utf-8?B?TnlTUFZGTXA0TkI5TjN2N2RCMW1wYXVDQnFDcHM1S0VzTWtabk5JcXExVXE2?=
 =?utf-8?B?aXFSS2thTUlwMW9maWlJdHFnU2wvVmx5Rnd4ek5CaTZZa09sMUs3RDlWeFRv?=
 =?utf-8?B?TXNUTDB0Y1lFVm9mQmVnWUVJNVlYcFQ2eW8zeU9HRmFZRUFKQ2dJVXVHYnJ1?=
 =?utf-8?B?Z0J0WmFZZVNaMTlmSmg1a2lKNnNUbms1UEh1aWFOemtCL0dlaFJ3cFNXbUpC?=
 =?utf-8?B?c0UyRVRTV0krS3EvaVZmUzk1R2ZWcTJFU2ZFSHRKUlZmRHVTbktYaFBHTENU?=
 =?utf-8?B?RzNqRTIyN2E3bGZMTmQzSzVRSTQ4Sm1RdUlwN2VHTndLc1ZjdkxQc1BnSTZw?=
 =?utf-8?B?Z2dpb1NxNzMzRWgxN2JhTTBYOW5zSlVhRkczWC81WFlNTmcvVUlFZ0RCSGhi?=
 =?utf-8?B?bHNRV2xia2NnMDlMNXYwYUxralA0Z0pqQU9rYWJDenFYaG1PT1QzOGxzdlN1?=
 =?utf-8?B?ajhGNFAvdThlYm0ycWN6bU41dTFKR25zS3d3d0hWaGxLZHZzTDkycUFrNHIx?=
 =?utf-8?B?aGIvSEJVMEhCbDFYVjI4d3llTU9rQ0FxZ2w0V1dvaHZ5SVVuNzZLQ1JSOG9l?=
 =?utf-8?B?ckVXSW1ZRXYxT0ZZSm9TUmpjQXdBYis4elp3cUtLYlJxWWxqQ0JWeVJoa3Nz?=
 =?utf-8?B?L2tqanBvZzhQMFdOcTUzNEdIM2JkS2czOE9NN09TVUg0dFRNL0xLSXpDanps?=
 =?utf-8?B?OHV6b2ZDa0VubmRkMHZMbVJWUlNlaXRyNFIveE5xeHJVTjEwTmFWTmNOMm91?=
 =?utf-8?B?T3BHcXkyZWNvWGhOd2VXNkp1NGhPa2gxa2FZKyt0di81VlUzeG9QTnNMSXp1?=
 =?utf-8?B?RHkzY1k2bUdJN0xQdldmYXlQNTFFL3g0bi9rTlZEMVpLQ0JTTkFVbnd2cGpY?=
 =?utf-8?B?R21SSU1sUlNqK0pnUTdiMjlKenlKYm5nbGNQeGxQRnNxVkNIaXdQVUFPbERx?=
 =?utf-8?B?TFdwd01Qd28yNnBlSUxTUkJmMmlCSzkzeGhIVXRoQjhMMmc3bE02b2hBb0xM?=
 =?utf-8?B?bEhqbFVFcXVVdEtydnZzekVuaEw2NmRKZEpBSDNUZ1cxcHpaL1ZkMjQ5V1RH?=
 =?utf-8?B?SEM1Ym43QUg2bmZPdW5GeVVmM2NJVUROVFZYRWg5ZHM4QTNLREVCTmtLYW5Y?=
 =?utf-8?B?Q0dlZXRjZ2UwZ1V0NStWMmovd0VabjM5NmEvNUg0VUhSaFRtZThVMi82Mmc2?=
 =?utf-8?B?Zk5pMGU2WFhpcTV0TmUzWThtRWtkZlZSQlVNU1hPeEpnd0xCQ1NCSXBZcWRr?=
 =?utf-8?B?VU16c0MzeEdJYlNVRU5tRzFjbkZ6bjRJZEd0bDdNWEFNZ3ArempLeWlqRlVz?=
 =?utf-8?B?UHdnR0F1bXNVTDhDbzFqYWp2eUVGTnp5UWhidmQ5UWx6VjFIbmNUVVRweDlj?=
 =?utf-8?B?RzRMT3pDckE4ajlSZi9Ia05Yb3RqblNzSXBTR083VVIwSm0vK1hhMVFGZzg3?=
 =?utf-8?B?YVJhZmdlUUdJbkhlenU0S3EvekJDd08wM2VXNlpyaWRiWHUyNElpSkJycEZV?=
 =?utf-8?B?MGhVZngrNkdqQWdidHVGNFdXSEErbHFsQW83czhBRFUzU1J4L0J4aHJYaFFx?=
 =?utf-8?B?TFVOc28yQWxvMHY2dG9keUgwRnJ2ZHBpbitZOVY0ZkZ1QVlwMXZXUHEvSDNJ?=
 =?utf-8?B?aithNlBESC9MY1NQdExSWnp0Kzg5STBJZHE1QUZ3N3BPNkRRcElzS3ZMV0Yx?=
 =?utf-8?B?eEx6NXJ3b2VpR1R1dmNLSnJzVWJLVGFOY3owdWNTQmpCTThFOURxYW9pMFA5?=
 =?utf-8?B?MnljT3FSL0VlNVNWQm4wb05BWjFmUTdwcUJWRWxDM1ZHN3NTUktDd1ZkbzVK?=
 =?utf-8?B?dmRBd1ZpTDlnNkxjaHBaMzNpdUZtRE92TnV5MDg0cXBqbDRIVHpzNktpQmxT?=
 =?utf-8?B?WjlqL2RGZkJPV0x2YnJKM3lyZjdOZ3FOSEJjWkhhWCs2YXJ2VXRITC9ueTlI?=
 =?utf-8?B?YXdTWnlkQ3FXbTFDVUwwV3BrNENCSUo5bHErN0xXQjRqbE9iWjJHMWRSNGlJ?=
 =?utf-8?Q?nIbc=3D?=
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(14060799003)(36860700013)(35042699022)(376014)(1800799024)(82310400026);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 13:55:27.0618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 564035a4-348e-462b-39bd-08de2c2a49cd
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR05MB6995
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

c2NhbGVfdmNvcmVzX2dlbmVyaWMoKSBjYWxscyBmdW5jdGlvbnMgaW1wbGVtZW50ZWQgaW4NCnRw
czY1OTEwLmMsIG5vdCB0cHM2NTkxMF9kbS5jLiBDaGFuZ2UgZ3VhcmQgZnJvbSBDT05GSUdfRE1f
UE1JQ19UUFM2NTkxMCB0bw0KQ09ORklHX1NQTF9QT1dFUl9UUFM2NTkxMC4NCg0KRml4ZXM6IDBi
OWZmMDg1MTU5MiAoImJvYXJkOiB0aTogYW0zMzV4OiBEbyBub3QgY2FsbCBkaXNhYmxlZCBQTUlD
IGZ1bmN0aW9ucyIpDQpTaWduZWQtb2ZmLWJ5OiBNYXJrdXMgU2NobmVpZGVyLVBhcmdtYW5uIChU
SS5jb20pIDxtc3BAYmF5bGlicmUuY29tPg0KU2lnbmVkLW9mZi1ieTogTWFhcnRlbiBCcm9jayA8
bWFhcnRlbi5icm9ja0BzdHRscy5ubD4NCi0tLQ0KUmVzZW5kIG9mIFtQQVRDSCAwMS8xNV0gYm9h
cmQ6IHRpOiBhbTMzNXg6IEZpeCBETV9UUFM2NTkxMCBjb25kaXRpb24NCmFzIGEgc2VwYXJhdGUg
cGF0Y2ggYXMgcmVxdWVzdGVkIGJ5IFRvbSBSaW5pLg0KLS0tDQoNCiBib2FyZC90aS9hbTMzNXgv
Ym9hcmQuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCg0KZGlmZiAtLWdpdCBhL2JvYXJkL3RpL2FtMzM1eC9ib2FyZC5jIGIvYm9hcmQvdGkv
YW0zMzV4L2JvYXJkLmMNCmluZGV4IDcxMjgxOGVjMjM1Li45MGUzN2E4ZDkxMyAxMDA2NDQNCi0t
LSBhL2JvYXJkL3RpL2FtMzM1eC9ib2FyZC5jDQorKysgYi9ib2FyZC90aS9hbTMzNXgvYm9hcmQu
Yw0KQEAgLTQyOSw3ICs0MjksNyBAQCB2b2lkIHNjYWxlX3Zjb3Jlc19nZW5lcmljKGludCBmcmVx
KQ0KIHsNCiAJaW50IHNpbF9yZXYsIG1wdV92ZGQ7DQogDQotCWlmICghSVNfRU5BQkxFRChDT05G
SUdfRE1fUE1JQ19UUFM2NTkxMCkpDQorCWlmICghSVNfRU5BQkxFRChDT05GSUdfU1BMX1BPV0VS
X1RQUzY1OTEwKSkNCiAJCXJldHVybjsNCiANCiAJLyoNCi0tIA0KMi4zNC4xDQoNCg==
