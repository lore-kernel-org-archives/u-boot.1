Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95882C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 03:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3E2D83A3A;
	Fri, 11 Apr 2025 05:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T/+OMQA+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE0A083E44; Fri, 11 Apr 2025 05:57:32 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 910DD82BA4
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 05:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MK4n5XlZdz/6v6UQZhoOvpTr3CMvofoHMXG+8T57UO8vXIR2Bg0aAlAeTz6lVjMd3ujdpNZxKrA/2Pah6uBy6nTyY1h5OfQMccZuQbNFhAMuugUhEU8ArWp4nB9v8MsxJh14N571xlgwfMLS4m+8/wmSMWhB8LyGERET4u//QzQu0ciFNfvl/9ocXJBZjPvwMythQt7su+GQSS8QTpBmy1OfAAu+w0DrCfRvN8XD/F3AspBUgDb+KBP0EM/obs3Wm1nVDDWc3hvHuOtE3DgwHrssey885A9102WgulZx0QsH5FupB7p4rMpKzQzu12pyHol/bg7i3Ksf0XBLIdmVYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dm8avgxcT2BIRGCTVaEl78jxqabnVGcDm+e5nW211w8=;
 b=f5PJKkxNAJmg6oa657z4W7cNfQZyQyfWVGRhuXsQ6ZlnaiYH9EKypVnOyQhPdmg2qSz9f18IIZgoyp6Qn87I/jBSW+ORpJa1Af/F+plAvRNnhKj/7A3uY3nIiBIUKbggaAj1UX4UL/s9pO1ye7UqE8afEHfztzptjPFfYxQKA6OxD8YOnIDkz3yamGwyIRwdH/NmgYAOTVDMge0skp/ovNCEK0MFa6AGPBPFvQelw2dr15rfhzolDvjAodTKd7a5iZQPeNco78hkvfRox/ViksJiMm7QWU46MrjrOqsJQYe/8lHNGM1ygnRx+ebdNnRFtkQ2ZgMBeDQD2yA4lOfebQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dm8avgxcT2BIRGCTVaEl78jxqabnVGcDm+e5nW211w8=;
 b=T/+OMQA+TWsI5vLbwOdD9xOB9BP8zXvxbRB3565wJuYlBFFhVXIWGZCccdJNvyrzdv5TCRtMMMPYQZzh2VBRl1AwknZWk5u9DerB87bae3K3Xu5a24WZDqqh6B/sbXwm+tCXbqR7IySAXoBNtD6UpLMWq/lJ4SYRZZBa8Qc6qm4=
Received: from CH0PR12MB5266.namprd12.prod.outlook.com (2603:10b6:610:d1::10)
 by DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 03:57:27 +0000
Received: from CH0PR12MB5266.namprd12.prod.outlook.com
 ([fe80::2539:1bab:b456:33c8]) by CH0PR12MB5266.namprd12.prod.outlook.com
 ([fe80::2539:1bab:b456:33c8%6]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 03:57:27 +0000
From: "Begari, Padmarao" <Padmarao.Begari@amd.com>
To: =?utf-8?B?VmluY2VudCBTdGVobMOp?= <vincent.stehle@arm.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Jassi Brar <jaswinder.singh@linaro.org>, Marek Vasut <marex@denx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, "Simek, Michal"
 <michal.simek@amd.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>
Subject: RE: [PATCH 4/5] xilinx: zynq: fix dfu alt buffer clearing
Thread-Topic: [PATCH 4/5] xilinx: zynq: fix dfu alt buffer clearing
Thread-Index: AQHbp99oXOd+cssk40C5WnBUHuv6trOd29kA
Date: Fri, 11 Apr 2025 03:57:27 +0000
Message-ID: <CH0PR12MB526694629CE5F94EFF0F6B58ECB62@CH0PR12MB5266.namprd12.prod.outlook.com>
References: <20250407170529.893307-1-vincent.stehle@arm.com>
 <20250407170529.893307-5-vincent.stehle@arm.com>
In-Reply-To: <20250407170529.893307-5-vincent.stehle@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=991b094a-1dd2-41ed-9687-2824678dd1c5;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-11T03:57:08Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5266:EE_|DM4PR12MB7671:EE_
x-ms-office365-filtering-correlation-id: 8e330973-6d5e-41a2-bd16-08dd78acf994
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NXh1am1WRlhMdjgwamVOKzFVRUlYdkF6bk1aR2hZbEJZZ21GSmpSdVNKTEh5?=
 =?utf-8?B?RlhlbE4zeVpIQVRwYkdqdXpnalpQT1VqMEFGOHJsbDIxUlNFUnNFMzdBd0xT?=
 =?utf-8?B?dll1VWEzcVl1WldMZWtmRThCU3Z0OFc1RU0wQVdLWHhMd25DRzR5dm1FOThK?=
 =?utf-8?B?QnFPaHlpQ3kyWkY1QlI1R3FYd2N6R0NWZndURmMvR29xT1FydGIyRVFGNllE?=
 =?utf-8?B?eURZRGhkcXNTcUN5UURwcVh2RFZpa1kzRG9WZ1pwd3pCVEZBVnVOVTBKMi94?=
 =?utf-8?B?b2JZc2V2V0g3REM0b3J4amdzTCtaNVpaMlZzaDdqR1BOUDhPZGZGYVFKVVA4?=
 =?utf-8?B?cm8zYWY0MW1PbWo2MjlXUzV5TGVQNFhtdWR5eWE5djd1UWhFL2REaGdHTnE2?=
 =?utf-8?B?UTFOTjRORWJrVGNKbDVsN2VsS2ZVYmJHbDM3K09hd25NQlgrdHNnbFBpWGQ4?=
 =?utf-8?B?Q0cxTTd1a0IwTWhNWWR4RTJXUmZUZ0dZUTR6a0ZEaEM3RXNIdmoycWRjblY2?=
 =?utf-8?B?Q0pYbzZVWVYzUCszL1Z4WDRRUEw1dnhXclpObk9WeW9tVGtIRFdxc2JWVUdK?=
 =?utf-8?B?RCswTGdpenpHeW5OaU1CTVVNekRIQlFTNWw1dGhLa3BrM01WRDBMUkhmUzJj?=
 =?utf-8?B?QXBBTDMxOTI3ZEs3ak52ZGp5ZVp4Rmd0bFlwYzNsVHFMcytoQlErcVZCYWJH?=
 =?utf-8?B?MU5DVVF0RDdiZGVJL0ZPOVJOWHZJTURtVEVES2tVeHcxTDZ3ODAybmZmMFlo?=
 =?utf-8?B?akNEUVl1Uk5BWnVLWFB4bHRtelhSWmV4UitzZEFydDhma2I4N0tpdnZwcm5z?=
 =?utf-8?B?MUZ2cFM0MTVvNGovejdkVFlEWURVdW5GMHNXSDRNdnZmY2JtYkpiRmIzQ0s2?=
 =?utf-8?B?ZjZ2MkZ1ejBQeHVHNXdQdVd1QnR5dGkwQm9YSVNMQnphY1VlYkhGeWNPM3BN?=
 =?utf-8?B?Yjd3RXNZVzlqUmxkWGRDbytZZ2JJMU5oU3Zvcmh1ZHNtV3g4NXVlTFlWV2tL?=
 =?utf-8?B?eGpNR3EvelFGOGg4bnhycTRRMHQ5S0tnK3pVZkRkZW5zdk1mczNva3V4d0ZM?=
 =?utf-8?B?d2Znb3R3OGFzWmxIbTVPWUVwZVVBZzV5dFdPUVBMSFJ3QWdVa3Z0d1A1S2Jh?=
 =?utf-8?B?RlFUM0dFYUZUa1NwQ1ZUMnRtUlZxZjJjbFB5aDVPN1RkZ2o1UU9uS01uanJ0?=
 =?utf-8?B?NmFNclkrcURoVE5WZ0prRXJ0NHdrTUdvTlhweVZidGttSUFrc0dISThjSGRF?=
 =?utf-8?B?cTFSM3dpVG5oTVcyaUtpM1RyT1QrUWxTZFl4RmFKRGhYRDNSWGhDSjF5TkZx?=
 =?utf-8?B?UCtPOVpqbm5nUUNYRlU4d25IQ0pqQTJZYVBUMTExNkluZ0dPNlJNV3FpMlEv?=
 =?utf-8?B?S1JuaGh3Y3lTb3NVVVVkV0VxREs5OUJnQlg1bWtDM1FxdU1mZnpKOHhVSHdV?=
 =?utf-8?B?eWI4Ym1SR2Vjb3dCWU94UndHdkFhemVCV1U3eGU4VHl1T3ByRzZTdk4vYVF3?=
 =?utf-8?B?aFlHYUlWbG9QMDBKWDUvS2hCNjVvTHFrRjVhN1ZKajRUelZxMnhubk81a2xQ?=
 =?utf-8?B?WVhudzJ4R0FNMnlGeURyQkduOFd2M01kNWNzOFM3K2NTOFRpclk3bzZMSXZs?=
 =?utf-8?B?dEQ2ditLWGNCUzJyMURXeGViZTRaY0d3d1ZxNkdLQzR3K3RKais1MXdVRk1T?=
 =?utf-8?B?T2pTR3Nib1dLVUhpeXozZHdtRlBkdkVSZ2NzOVFlOEV6T29IZGgwZHFRNS9a?=
 =?utf-8?B?dkpiMHUxZ25UWW5mbW4yVUswcTFCdTdnUG03Y0JVT1VreDB4VWp2TTFxaHhM?=
 =?utf-8?B?K0tXSmRUaFJtNlJiZERsOFdlTFJaaTk0ZjJWaFRmWFFJamJUR0JmbVQzdU1X?=
 =?utf-8?B?VVRzZVNyOExOUzBBUzRZTmhiclRnMUljOElKd1lIT1hCd29TYmE2U1d1UDdi?=
 =?utf-8?B?am9jaHNJN1UvaStwcmIwSnNLQ001YXY0Nm9TeWd5ZjJXZitTVi9ZdDdxQjA2?=
 =?utf-8?Q?tlNE6In5wLk7OlolkDN7wcspufyh+g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5266.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckZPcnhpenB1VTVVdWc4TDB1RkJaekFuZjBNcXliUzJoUkJpR1E4Y09CdGpD?=
 =?utf-8?B?cVpiZXU3L3k4V0k1UlJ6SnYrcFVrOFluY29HM1FHRndvWXQ0ZHZYU21LaEZY?=
 =?utf-8?B?TE4xWXhyaWdTMjZBaXNEcGxhNWREb2N4UWtPNVhWOXRSWkw2RDRNaHE3Y2lT?=
 =?utf-8?B?MmxOWkZuOWRmVWtOR2NlNHlxaXZ4L0FkRzd5WHZGRWJVTHFVWXVRZXFDbnhZ?=
 =?utf-8?B?U1h3UVVFT1JBQmQyNXUxaE9zWUExMnlYdXRMWm85aSsyR0NHai9VWTNXaVow?=
 =?utf-8?B?NHdlbWhjaHYyRFh5VldLMng4WmpOSE9DVFVyNi9jK1VvSnA5NDdkd3lZTnhX?=
 =?utf-8?B?cUxpNkVkSnV5NXBSZWJWdWFFS3dUdTJ2UmdIRFM0WlNBMTBmUEJFZ1pyY2lm?=
 =?utf-8?B?bEFjYXlrcGozakl1dTVCUUdWVDFTejViOUw1WkNoVmNSNy81ZTVWZ1NlcnhK?=
 =?utf-8?B?d2pta1NpbUFnbzJsWHplOTVCSkhoWTlOdjZBbE9tTDVMRGYzNTdNYlRmZjZy?=
 =?utf-8?B?UW1OKzUvWG41TjlFOE9xWkIwbzZBbC9nMm5xRFlFVFR6QjNSTnR2aTUvUk0x?=
 =?utf-8?B?ZzFGajNpZTRzbEdGaU9rbEc1Sk5XQUFOZ0JOMXUyT0l3M3ZYcTBrZGJ4S1Ro?=
 =?utf-8?B?a2EzNytZekM4NWVyUFllNHBUaFNqVFlPNkFrQlQxQ0RvS0QzRUdWd3hNUzJZ?=
 =?utf-8?B?b2VnOG11cjJDWmZiY3lTSlJBeDIvV0hOOXRoRzRkbTM1cDJIWEJ0NUVQb2lO?=
 =?utf-8?B?Q245dU9MZTFPYjhoQm9DZzlOUUgyMllGenZtY1duVWFiK3o2Z1JKbVRvRVBE?=
 =?utf-8?B?eEhBMHV4SXNrbWZpM3NNaFV3SWx3OXNSd2VLSGFxY29TenhjNS8rWUwrUEd3?=
 =?utf-8?B?ZEFML0MvMk1pMnNWckxCWmRVRmZzbnJnYnBDamJmNkVhR0dHNGF1R2IraUlo?=
 =?utf-8?B?bVBHQm03VDVwengwRUFhckhNWkZaNyt6UmZBVnFDaEhMUWltTndhZDdyNm1z?=
 =?utf-8?B?QUFVTHliSjRwck5ab2ZlTFpJdmNWUXFmbkpjNENLM3JEaEpZbTI4WHJ3aElk?=
 =?utf-8?B?U2RpTEtkZXF0dUZDKzIrWXh5WS9LdmdVQlVDRTAyL09TY1FiWXNQU3hBVDFV?=
 =?utf-8?B?WVF2S1Z6MVhXWnRxUkFHRHdTVzd3VDFUQ0gwSWZBWWlhcXJydnY2K3kwOUow?=
 =?utf-8?B?TGlBWXZaRktyRE9lNTRsQU14LzZackNLSEFtaWNKTXZtbFMvdjFLTjVDdHoy?=
 =?utf-8?B?UTROMllnUS92dnRnbTFia25BUHlqTkJiWHJrSXRiRUlOOVN2QTQvVFF4QXlO?=
 =?utf-8?B?dWhpY29QOWRBZGllWFpjajB1c25kcERNV0xHK3BrRVEvMkhmdEZjSmRiaVZE?=
 =?utf-8?B?dENTeGkrSU5rZ2c5MFJ4NWoyaHJGdlZVdjhpRUUrdml5K2Q5djl5WU1sNWlM?=
 =?utf-8?B?b3BCL2xuUVAyOEJXQW5scUpKdXVWblY3d2Rrb0UzSXRqWFFES1luM3JxSndO?=
 =?utf-8?B?TEduNHUwUDFtWkdhbzdzd3NLckczVTNPQ3lQSmY1aUN3TDZXNHppdWVLNkZN?=
 =?utf-8?B?M1VhaWR2YnRBcngrTWZhM3l0L0pDRkg2eElFS01FZVNMZ3lLTTExZkxzNnBF?=
 =?utf-8?B?dGpwakVNZVMrc2hJVlg1ZVc4Z2lRbGdPTGpVQnRwVjMzM09xUzd3ZzV5UjJ1?=
 =?utf-8?B?bXdNRHdLb3FrYngrdjVoL09ySm51YzZxU2s3T0w1UFBFUS81eGc1dW5UZjND?=
 =?utf-8?B?eWdBSHJmZ05TL0hhbERKa1RyOUM0Y3JXaXl3Nmx1c0d1VG44ak1lTWR2bCtj?=
 =?utf-8?B?VGhtS2gwYmdzcFdhTzU0UmVhbFgwc2NNMnNjdUtZK1NuMWlBcFVJQkVlZHVr?=
 =?utf-8?B?QTl5amI3RmFBb0F6aER5blV0ZmJ4MGxPSDhYNEt5TkduNndtemovY211OWFJ?=
 =?utf-8?B?QkxHa2R6WGFtTThQRXZYTEloY3lFUmtGT0EzM0RBWUpMMGRQVEkrc1RBQXFR?=
 =?utf-8?B?cEcxNEJ2dm9TYU9ZWi9OMUd0NGhRL21GMXlVZ3dnMUQ4VVNCc0xUaWppVkt5?=
 =?utf-8?B?US90N3FPUkJ6UTFpTDZodld5Uk4vaElMZEU4T0xHZWRVT0hyTXhqa25DMDE3?=
 =?utf-8?Q?Ba0Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5266.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e330973-6d5e-41a2-bd16-08dd78acf994
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 03:57:27.2895 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m/5TUL0Mafzfi3r9cd+E89jEMB72K3UaKi7CJ6Vwb767yArhHuFbKCcyEloxXSpgjirtiTkgrjPWJmikjVY/mA==
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
bT47IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCA0LzVd
IHhpbGlueDogenlucTogZml4IGRmdSBhbHQgYnVmZmVyIGNsZWFyaW5nDQo+DQo+IENhdXRpb246
IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJv
cGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywg
b3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gVGhlIHNldF9kZnVfYWx0X2luZm8oKSBmdW5jdGlvbiBj
YWxscyB0aGUgQUxMT0NfQ0FDSEVfQUxJR05fQlVGRkVSKCkgbWFjcm8NCj4gdG8gZGVjbGFyZSBh
IGBidWYnIHZhcmlhYmxlIHBvaW50ZXIgaW50byBhbiBhcnJheSBhbGxvY2F0ZWQgb24gdGhlIHN0
YWNrLiBJdCB0aGVuIGNhbGxzDQo+IHRoZSBtZW1zZXQoKSBmdW5jdGlvbiB0byBjbGVhciB0aGUg
dXNlYWJsZSBwb3J0aW9uIG9mIHRoZSBhcnJheSB1c2luZyB0aGUgaWRpb21hdGljDQo+IGV4cHJl
c3Npb24gYHNpemVvZihidWYpJy4NCj4NCj4gV2hpbGUgdGhpcyB3b3VsZCBpbmRlZWQgd29yayBm
aW5lIGZvciBhbiBhcnJheSwgaW4gdGhlIHByZXNlbnQgY2FzZSB3ZSBlbmQgdXANCj4gY2xlYXJp
bmcgb25seSB0aGUgc2l6ZSBvZiBhIHBvaW50ZXIuDQo+IEZpeCB0aGlzIGJ5IHNwZWNpZnlpbmcg
dGhlIGV4cGxpY2l0IHNpemUgYERGVV9BTFRfQlVGX0xFTicgaW5zdGVhZC4NCj4NCj4gRml4ZXM6
IGM2N2ZlY2QyMTI1YiAoIkFSTTogenlucTogRW5hYmxlIGNhcHN1bGUgdXBkYXRlIGZvciBxc3Bp
IGFuZCBtbWMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBWaW5jZW50IFN0ZWhsw6kgPHZpbmNlbnQuc3Rl
aGxlQGFybS5jb20+DQo+IENjOiBNaWNoYWwgU2ltZWsgPG1pY2hhbC5zaW1la0BhbWQuY29tPg0K
PiBDYzogVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT4NCg0KQWNrZWQtYnk6IFBhZG1hcmFv
IEJlZ2FyaSA8cGFkbWFyYW8uYmVnYXJpQGFtZC5jb20+DQoNCj4gLS0tDQo+ICBib2FyZC94aWxp
bngvenlucS9ib2FyZC5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9ib2FyZC94aWxpbngvenlucS9ib2Fy
ZC5jIGIvYm9hcmQveGlsaW54L3p5bnEvYm9hcmQuYyBpbmRleA0KPiA4ZGJmYTU2MDQyMy4uZDhk
NGQ1MDIyYWUgMTAwNjQ0DQo+IC0tLSBhL2JvYXJkL3hpbGlueC96eW5xL2JvYXJkLmMNCj4gKysr
IGIvYm9hcmQveGlsaW54L3p5bnEvYm9hcmQuYw0KPiBAQCAtMTc2LDcgKzE3Niw3IEBAIHZvaWQg
c2V0X2RmdV9hbHRfaW5mbyhjaGFyICppbnRlcmZhY2UsIGNoYXIgKmRldnN0cikNCj4gICAgICAg
ICBpZiAoZW52X2dldCgiZGZ1X2FsdF9pbmZvIikpDQo+ICAgICAgICAgICAgICAgICByZXR1cm47
DQo+DQo+IC0gICAgICAgbWVtc2V0KGJ1ZiwgMCwgc2l6ZW9mKGJ1ZikpOw0KPiArICAgICAgIG1l
bXNldChidWYsIDAsIERGVV9BTFRfQlVGX0xFTik7DQo+DQo+ICAgICAgICAgc3dpdGNoICgoenlu
cV9zbGNyX2dldF9ib290X21vZGUoKSkgJiBaWU5RX0JNX01BU0spIHsgICNpZg0KPiBkZWZpbmVk
KENPTkZJR19TUExfRlNfTE9BRF9QQVlMT0FEX05BTUUpDQo+IC0tDQo+IDIuNDcuMg0KDQo=
