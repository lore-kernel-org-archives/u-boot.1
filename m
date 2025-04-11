Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE05C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 03:57:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FAFB83E46;
	Fri, 11 Apr 2025 05:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="exqU5qEu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41F0783E57; Fri, 11 Apr 2025 05:57:50 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDF5582BA4
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 05:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5464xE4Kj7JCV0/LwXyzIOqdye3AjRr1CEqpTaSxs1jjUJAoEyQGB1OCGX9HehY52uFcpsyuFloH+mndvw7ODwX+opSqJm1K9NFrWP9tVfAmE4OkV+FcXINLAam473B75VjpBpTlyn1eBiCOgkoluIcaQBN+BQcCyI3gfCYbu5hIlVeGZGAMZaohhowk10SxL73SHCxrGulw50I++n0LC2d48AHR76YwoO/vVFOmPIwq/7QzlLHnspe4+bO5HNTpnuf9Tk3rcHYihtQLXlcpe1MLk+I4CuHu4AUhOYBnogZN7wxUSMli53QudMa7OGJ9afRR1ZUYWxR4b5HSuAK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Asj6f5R6iTYjfiKFIcTI3bi2nePlZ2Msler9RW9obm0=;
 b=jIRuN+Abbkuo5Q8bIvrdWYQX5MdfLXa5pnMWeh4TX7VLMcasKHWlUNqyB4Zioaw1JyqGXjpGiJsax0JG/z67zcQJK30C8l/IRd43oQ4BcbUCybqUPsgbC2sZsnNk/E8F1Qh4h8vdCQb63KD410hYSj623JJdliJDZSOuBBqCK1a7b1uwGNpMOJH3uimhraGuPZnLtDCNe3aREx/LxT8Mu235FfXfrTeJXnHmF6kKkJi2RoIYRCSWyrI/HPpSYmV3zeI086O826wjcf0b4Hj0t4Bbnqqje1A99SQ+3mif5FtTmxUqIImnJpX9wGvZZzCWrnHdkTwtgInmlyUCB+AalQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Asj6f5R6iTYjfiKFIcTI3bi2nePlZ2Msler9RW9obm0=;
 b=exqU5qEujGRpvAz++50FfJ5kjK4mt/2VfLV/g2xkcWFSCnSdvUtqNX75zxG+alLkTLhbTlO3jTDNhcrc85s9zitIe+TZahyQcgPDI3ZlUIg8vZTxXivqjzhYyTN2XAexHH2Ydlh+jkdg4i/ZFgpFc9si5LvWSiXMVRBYd0p/Xoo=
Received: from CH0PR12MB5266.namprd12.prod.outlook.com (2603:10b6:610:d1::10)
 by DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 03:57:44 +0000
Received: from CH0PR12MB5266.namprd12.prod.outlook.com
 ([fe80::2539:1bab:b456:33c8]) by CH0PR12MB5266.namprd12.prod.outlook.com
 ([fe80::2539:1bab:b456:33c8%6]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 03:57:44 +0000
From: "Begari, Padmarao" <Padmarao.Begari@amd.com>
To: =?utf-8?B?VmluY2VudCBTdGVobMOp?= <vincent.stehle@arm.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Jassi Brar <jaswinder.singh@linaro.org>, Marek Vasut <marex@denx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, "Simek, Michal"
 <michal.simek@amd.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>
Subject: RE: [PATCH 5/5] arm64: zynqmp: fix dfu alt buffer clearing
Thread-Topic: [PATCH 5/5] arm64: zynqmp: fix dfu alt buffer clearing
Thread-Index: AQHbp99vQ4jaw+LsREapWIXG2wcGcLOd2/Jg
Date: Fri, 11 Apr 2025 03:57:43 +0000
Message-ID: <CH0PR12MB5266626B6196D2B0A0FD2DFEECB62@CH0PR12MB5266.namprd12.prod.outlook.com>
References: <20250407170529.893307-1-vincent.stehle@arm.com>
 <20250407170529.893307-6-vincent.stehle@arm.com>
In-Reply-To: <20250407170529.893307-6-vincent.stehle@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=43e8360b-4205-4fb6-8e92-d7cda7ef8233;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-11T03:57:30Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5266:EE_|DM4PR12MB7671:EE_
x-ms-office365-filtering-correlation-id: 1293e183-0710-4b3c-e51e-08dd78ad037f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?anlpR3FKK284TE9aTGp0K3pKWXJWNnhaWG92YmFVamhrdVRuS0xNTG5MUUVO?=
 =?utf-8?B?anA4dFdnQkFRNkRic09QY0JUUWx6K0lpdDgzSElqR0kwZVB3QTA5L0pwWjh3?=
 =?utf-8?B?Y2d6L3c0cFRYczdTYklYdkRRNElia1Bkek9JQVRRK3ZjY2pKRVBsZWZDZGtt?=
 =?utf-8?B?Y0ZhUGtGZmVpNWVLZ3RyY3JESzJTcnVFSnc2TkZsQnU0dVltZzdudzZOSjRC?=
 =?utf-8?B?YUR3VVgwTlN4RHRXRnlzbi9teE9wUzA1Mm5XVkwvSVVKYzZCOC9Dck9TY3BC?=
 =?utf-8?B?MldnRC8vWTN4bTFyZ3o4UUlpckhnbEJCeUdNM3VubC9xelBDMVlnR2FNY1ZV?=
 =?utf-8?B?bXBhZldVYWZ6ZFBIZktWNlR3dWdKM2pjTytEeWhUWUpDQWZwN1R3Vjl4Ry9W?=
 =?utf-8?B?SmlCZXpTempqMXJOWEdPTXJWSzBjbDMvNGZWaW5oMW14Qy9KMkt0UmYrblpQ?=
 =?utf-8?B?WEtZczloQWlwZkpSR3cxTXJKZ2p3SzhYeVk2TzJ5eXVtQkp2dk54RFc1WGFs?=
 =?utf-8?B?RG9TS2o4SzZtUUZhTzRjT0xZU1g0M1lORTA0STlhZU5CTFNiUVNYcWd0QzJk?=
 =?utf-8?B?eEl1WVdCSk1DcTdrWG9CaXNoSlp3NDhqbStvbWZ6QkI5K3FCdmxYM25WWm9Q?=
 =?utf-8?B?amhVN25za0t5c1EyZUpsUjArVWpIV1FXZHI3RVJIclBncWsxUEJBZ1Y4TVFs?=
 =?utf-8?B?QS9YdytzNUt3RXpXbTk5eWFDQkhrajRpRW1ETHArVEtuaERXVEF6TmN0NUk1?=
 =?utf-8?B?OTA3TXVkSDhXdWxYZ2NKQWNzQWMrZk9YR0lNRXhFejM5ejI3b1QrZnhXdnY0?=
 =?utf-8?B?TllEYVc2NGJrVCtMa3NXNmtJY3BUWFFrcENaQUhQb2w5M1dWVjc1RzZMZ1VH?=
 =?utf-8?B?eUZhcndJbUp2aGxNVjR0cExFTzZvVVJoSnhDaTJJTmhUZHBLczVaM3dXWGNo?=
 =?utf-8?B?eTZuTjdjQkU4bzdCWU0xTi9NVWYzaHNTcVFFWU9Lb0RlR01Fcmw2NzVwd0k1?=
 =?utf-8?B?WUFYS0pZM3pmU2NYRUJPMHliRVNXZHM2K3VxdHp2RzZha1N3SktINmhYNGIr?=
 =?utf-8?B?b1RIbktXamRmckkvdWJkdXhXcC84eXJyRGhkVU92bW93bTJ1Zit5ditnbk4w?=
 =?utf-8?B?VS9kKzJNcnBxUW1lN2g0ZFBaalhmeVRieXdnSXAxdTR2eGVwNi9ZSmNjNi9p?=
 =?utf-8?B?aitUUWYwSHZ1c3Q2cEh3TmVlSCsrYzF5T0VvWjNxR0lldEx0aGhDaDAzTFVr?=
 =?utf-8?B?SWcxazdnYm9EU1U1R3BhT2JiaCtzVGVXNGQ4U3JjbmFrcXU5eUk1VFNaajM1?=
 =?utf-8?B?bGNuM29TdnluUklOVytTaCtsTGFmL0VwVjgvWEFmMWp6Tzk2RGZXNmlnaTJ6?=
 =?utf-8?B?cVhqMzRFMHprNksvQ2wwUEM3R21rYWpheUU4T0xIdWFGcjhWZmhkdVpVOVFy?=
 =?utf-8?B?TS9Zb3VzT0EvY1o2QTlsVjBGSjhScWJNMENlaTYzZ3R3ZmdGOVhIZkJtRE4x?=
 =?utf-8?B?amwwNXZHMHdlaXlGTmtBeTkyQnA5NG9VOTBJNXRyT2ZieHVrMWpwMUxyWEdz?=
 =?utf-8?B?ck5zekpzbUJ2L0lBZkJWQ1dVUS9LMXlUbk84N09LVlIzZFFGTUhoN0RHM0Rx?=
 =?utf-8?B?d1N0cWhmQ3F4T1p1Q0Nlbys0MmYvNmdibkhyUHgxSDhWZ05NWTQvZC8xYnNo?=
 =?utf-8?B?N3Z6YW5iUk5FNXByTVBzK3AzME5sWU9IbURNMU00V3YyR1F4TmJYU1JxZmRz?=
 =?utf-8?B?cTZ6akNtY0NqQVZTUllPS0pPUUxWRDFvMXpQcXpjaUhRRGwxdC90SUNFZGha?=
 =?utf-8?B?allHR2RoUGFMazdZYittUmowdVE2S08vVDFBUGpBRVpWbUdpNllPaDZ3anM2?=
 =?utf-8?B?Tm5UeGxnVmF6Q1crTEYrZlY2czRRVmt6VnpEY1Rnek5VM3FNRms1cVlCN1lw?=
 =?utf-8?B?UWlaSVk0SDdMVzZ6ajJEV3pEVWQ0ODlmdUNYWSs5cVE5cXVBOHhnLytVelk4?=
 =?utf-8?B?SGo4RmVjeUd3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5266.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzFzcFBScEpwKy9RQVZDbzB3bHUweXV2R1BIYk5MMUxkSnBIdUs3UVB6eDg3?=
 =?utf-8?B?NkxDNlBvL1V2L2t3Q3R6bW9aRVBKWklSRHRPQ095Z3Yvb0NmdHAvWVdwRHhz?=
 =?utf-8?B?ZnRlWEg2SFl3MHRlV3BpbTNrdmdHQUwyZmlhRFFnaHdxYlFFQUFzV3g4Qm1V?=
 =?utf-8?B?c0ZmaU50SGhyNlJ6K2c0bDBmMjRQTjVRZVlRSmNlV09EMThVbWUvQS8vNzFH?=
 =?utf-8?B?T2xXZTU0TXBhKzZwdVpmSHlNelNlMTRUVnFwc3dydkY4QnpMWkx2Z3dTMFVs?=
 =?utf-8?B?bFlxZFVGd284V1J1MTByelV2V3FQa3NGVlZZejNESDN1Q3Z2RDJxV3JxNisr?=
 =?utf-8?B?T2lKdmpEUmZhTFFwdmQveENRWHNnVDZ1bGJJcGtXNG9wdUp4dmNlMFFrTDZY?=
 =?utf-8?B?cS9VNk1XZjZEZ3QrMlRJamF6MGNRNzhudmNiaHdHWnA2a2t3UmcyQUJlR0w2?=
 =?utf-8?B?NUZWQXRJK1NYb3RFd2RSVHprMC8yOWxDUjZkc2JmNkdHWVRzNWdTMFJVNjFZ?=
 =?utf-8?B?TUs4NExHSVVOSGNXaXFYdUVWODgwK3YwUlZkNkpLamZKRGVXbnJNNzBzV0pB?=
 =?utf-8?B?U2JJZFkzek5ZVE5pR3RJMWphQmpiRHhKU2hCZUlMWGlLOFk2WUVnYWFreUtP?=
 =?utf-8?B?YmtaNG1Fcmt4QW83TEx2dHlxdGpSYW12U3lxRUVsNmU2ckNSK0pRZUh6M0hP?=
 =?utf-8?B?VWtVQVNYc3R1RkRDV0ZvSHp0M09QVWFTZEpqRS9QMlNacHJpV0NNekRLL08v?=
 =?utf-8?B?eS9SaFFkRjFjalVhV3ByTTRLeExVSncvZ084MkM2cVNwb3A3eEw5SStyYktV?=
 =?utf-8?B?VEk0QWxUOHorNWxiMlV3ZGUzUEp1SThaVExwbTBXZy9iQmc3cW55SlhCdkh6?=
 =?utf-8?B?VFUzQXljOVMySFNqWU5wb3RiK0RNcHJIUnB3WnZDd0c0N0xZVlkwTUllN2Iz?=
 =?utf-8?B?WGJXdnlOUGROWGZnUXhnWlVNdzVYUm1zeVplN3ZZOFNpL3VvMk9Cc1NhNXZJ?=
 =?utf-8?B?cWZSUUVMVnI4ZDJEQW9OV2pBc20vd2hmOTlNUDAwUEgrR3pIWW1QbXZKNVBH?=
 =?utf-8?B?WmJQTzIxTTQ5NGxRYW9aWnV6MVh6VzVUblo5RUxsVmZ2Q0hEcWk1NEphMXZz?=
 =?utf-8?B?SjlKMHlmenVZTHpsNm8zcU1EWm9aZDBadHk1T0M3ZUJZWFF0M0lNKzRkMm9C?=
 =?utf-8?B?ZllMN0p2TjVBZTZmNUg2KzIxaThqYlJQWjVuN1N2c0w0bU0xQThUYzJEVUIw?=
 =?utf-8?B?enRDaEc4WU8veTlMWFpJMGFoZlROVGdZTFg0dk1NdVRTRnFoZnNobVpRUStM?=
 =?utf-8?B?VTBPYmF2WmdTZ1J2eWI4ZEl3TXcrSnByaytqS1h4aDJuNUdNOFdqb25DNjRE?=
 =?utf-8?B?ZHJ0UFVsRUQxN0Jpa0diVnY0ajI1ZHByR0EwSFdJMW03UFlTY1kwdzBtT1lP?=
 =?utf-8?B?T0IxaFZxOVFyTXdxazk0YVlKVEhGaHhuTTgyMFJoQThTT0Erd0k0ZnRiSlMv?=
 =?utf-8?B?Q01QM3lscEIvUWhWVnlML1FlL21yMTk0QXJVYm4xNnhwMVI0NytxM1lmRCtJ?=
 =?utf-8?B?TTMrbkVqWDUvcGZvY01ac0NLSk8yNUwzZktuMVJRSURQeFo1cnI3eVB5M0Rw?=
 =?utf-8?B?NW5PRjZrMnU3RHBnRG9mTHUyaVBUandCVVcwYkFCeEI1NHJXMkRReDNNNm1O?=
 =?utf-8?B?NWZQK0tBM3JKS1hwVnQ0NEM2Q1dTK1U5QmNjRmxad1ZZZWxpMTlSaFZxUS9T?=
 =?utf-8?B?eW9ZOHRzeW9wcCs1dlVtSUo3aFlzaUU4ODUvejFSN1BOdzB6cENSQkhrNEd0?=
 =?utf-8?B?WHJiY3ppK3NkbVB2eVlrMG9Uc0NMSEkxZTBZdm54UE9jWnZnbDlCeDVRQnlv?=
 =?utf-8?B?WE4ra2VDL0N6ZVVhQUE3cm9TVHo2L2NpSmxCalliYlZ6ZGNjQ2IzbVlwc1BP?=
 =?utf-8?B?WTAzRWtZT004MStLWkZFSTlpTi9jWUNBWWpEUTgrejZTSjhDV2UxajJWSzFt?=
 =?utf-8?B?Tm9jamVLU0tBZVFwcFk1NWlnV1llUEUrdWZZZzBrQXhvb2FOYXJoMG5SeDR3?=
 =?utf-8?B?RHRjNnR5OUdWM3hVbExEYTF3Tnc2bWo1cXFDb2VsU2s0OGlaVjZIMzV6SW9U?=
 =?utf-8?Q?7nXw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5266.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1293e183-0710-4b3c-e51e-08dd78ad037f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 03:57:43.9807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shHUjcKNK/33LTCmybW8HLvdJA/d17hHYdjS/dcl6fUPz4QswiK7K3qJDHQXL01BVb8Zy7EFvh4GVZEhAY8hNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7671
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiBGcm9tOiBVLUJvb3QgPHUtYm9vdC1ib3VuY2VzQGxpc3RzLmRlbnguZGU+IE9uIEJlaGFs
ZiBPZiBWaW5jZW50IFN0ZWhsw6kNCj4gU2VudDogTW9uZGF5LCBBcHJpbCA3LCAyMDI1IDEwOjM1
IFBNDQo+IFRvOiB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogVmluY2VudCBTdGVobMOpIDx2
aW5jZW50LnN0ZWhsZUBhcm0uY29tPjsgSmFzc2kgQnJhcg0KPiA8amFzd2luZGVyLnNpbmdoQGxp
bmFyby5vcmc+OyBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT47IE1hc2FoaXNhIEtvamltYQ0K
PiA8a29qaW1hLm1hc2FoaXNhQHNvY2lvbmV4dC5jb20+OyBTaW1laywgTWljaGFsIDxtaWNoYWwu
c2ltZWtAYW1kLmNvbT47DQo+IFBhdHJpY2UgQ2hvdGFyZCA8cGF0cmljZS5jaG90YXJkQGZvc3Mu
c3QuY29tPjsgUGF0cmljayBEZWxhdW5heQ0KPiA8cGF0cmljay5kZWxhdW5heUBmb3NzLnN0LmNv
bT47IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCA1LzVd
IGFybTY0OiB6eW5xbXA6IGZpeCBkZnUgYWx0IGJ1ZmZlciBjbGVhcmluZw0KPg0KPiBDYXV0aW9u
OiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHBy
b3BlciBjYXV0aW9uDQo+IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3Ms
IG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IFRoZSBzZXRfZGZ1X2FsdF9pbmZvKCkgZnVuY3Rpb24g
Y2FsbHMgdGhlIEFMTE9DX0NBQ0hFX0FMSUdOX0JVRkZFUigpIG1hY3JvDQo+IHRvIGRlY2xhcmUg
YSBgYnVmJyB2YXJpYWJsZSBwb2ludGVyIGludG8gYW4gYXJyYXkgYWxsb2NhdGVkIG9uIHRoZSBz
dGFjay4gSXQgdGhlbiBjYWxscw0KPiB0aGUgbWVtc2V0KCkgZnVuY3Rpb24gdG8gY2xlYXIgdGhl
IHVzZWFibGUgcG9ydGlvbiBvZiB0aGUgYXJyYXkgdXNpbmcgdGhlIGlkaW9tYXRpYw0KPiBleHBy
ZXNzaW9uIGBzaXplb2YoYnVmKScuDQo+DQo+IFdoaWxlIHRoaXMgd291bGQgaW5kZWVkIHdvcmsg
ZmluZSBmb3IgYW4gYXJyYXksIGluIHRoZSBwcmVzZW50IGNhc2Ugd2UgZW5kIHVwDQo+IGNsZWFy
aW5nIG9ubHkgdGhlIHNpemUgb2YgYSBwb2ludGVyLg0KPiBGaXggdGhpcyBieSBzcGVjaWZ5aW5n
IHRoZSBleHBsaWNpdCBzaXplIGBERlVfQUxUX0JVRl9MRU4nIGluc3RlYWQuDQo+DQo+IEZpeGVz
OiBiODZmNDNkZTBiZTAgKCJ4aWxpbng6IHp5bnFtcDogQWRkIHN1cHBvcnQgZm9yIHJ1bnRpbWUg
ZGZ1X2FsdF9pbmZvIHNldHVwIikNCj4gU2lnbmVkLW9mZi1ieTogVmluY2VudCBTdGVobMOpIDx2
aW5jZW50LnN0ZWhsZUBhcm0uY29tPg0KPiBDYzogTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtA
YW1kLmNvbT4NCj4gQ2M6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+DQoNCkFja2VkLWJ5
OiBQYWRtYXJhbyBCZWdhcmkgPHBhZG1hcmFvLmJlZ2FyaUBhbWQuY29tPg0KDQo+IC0tLQ0KPiAg
Ym9hcmQveGlsaW54L3p5bnFtcC96eW5xbXAuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvYm9hcmQveGls
aW54L3p5bnFtcC96eW5xbXAuYyBiL2JvYXJkL3hpbGlueC96eW5xbXAvenlucW1wLmMgaW5kZXgN
Cj4gODIwZmIyNTJhM2YuLjY4N2RjZDNhYzlkIDEwMDY0NA0KPiAtLS0gYS9ib2FyZC94aWxpbngv
enlucW1wL3p5bnFtcC5jDQo+ICsrKyBiL2JvYXJkL3hpbGlueC96eW5xbXAvenlucW1wLmMNCj4g
QEAgLTY2OSw3ICs2NjksNyBAQCB2b2lkIHNldF9kZnVfYWx0X2luZm8oY2hhciAqaW50ZXJmYWNl
LCBjaGFyICpkZXZzdHIpDQo+ICAgICAgICAgaWYgKGVudl9nZXQoImRmdV9hbHRfaW5mbyIpKQ0K
PiAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPg0KPiAtICAgICAgIG1lbXNldChidWYsIDAsIHNp
emVvZihidWYpKTsNCj4gKyAgICAgICBtZW1zZXQoYnVmLCAwLCBERlVfQUxUX0JVRl9MRU4pOw0K
Pg0KPiAgICAgICAgIG11bHRpYm9vdCA9IG11bHRpX2Jvb3QoKTsNCj4gICAgICAgICBpZiAobXVs
dGlib290IDwgMCkNCj4gLS0NCj4gMi40Ny4yDQoNCg==
