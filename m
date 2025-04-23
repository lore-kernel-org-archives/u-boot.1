Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDECCC369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 14:26:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 270DE815D1;
	Wed, 23 Apr 2025 16:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NGg2gSvx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C793880F03; Wed, 23 Apr 2025 13:28:49 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 089E4809A5
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 13:28:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=harini.katakam@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQCNFoYcSNLtEX8Ki2lIWurWELSpHoElwrzk0/FkDS34fKl4wQJqY0iVryYtq8W0HK8uz4ouXcUcFmKaRMhQkMbK9PL1pVVrGmrnX0tJa2p4zWTdGAzfjlwMnxRnGRY+yjSMl8Pm3jAvs/4R7jf3UXSvy1bW9kEb+5qpjCpEqXOYC+MgFW1NYMSC9Barm5ycZE/3V/RCpssvDPXOhLsKWgaz0E5IN8zNkAvPlhdX4vcvAZg6d1dxmIald3bDRDy1ZTHGS1KZZTCLG/piN13W9NxVMnAzgqxOE9OEwx13meOd2OzEN3u1MQZ8TfiOoadjvLxWW18Nh4XfD/Ke7DBboA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAU2YsrHHG+/P9+grcrceDnPn4ZRQ8/BOUtrvIac++w=;
 b=rBPtx90LJchGJlOB0Pi7yjDcYCa6L82kZhFwn6jvpcQZNu5gPtzaW7/qgG/4UIH7eE071vNLFlZmi0rlbQrSoa/58X4KWndb4uylPKq9llMsOuwJ9g0ajUvTbdEDPyk0PtIQZV1AvGcfVfZDSzPCgBsMwAw8T4YKJt29yeUcCM7jLIr+Mt8XiUvI+ebTgWIlTJkmBU9avS0N79JT1QQI4dJRk5UNK4ALT1FOmyf50y+7fiBAbNNONhzm5Z8iezxX5ZHe3qI9jKFNkIw/kD4z3HKZKJOykiC5GyP5fS20sObmnjD7B/EfEYYbunLDmdF3iPoTYdwaqm5a0Qk4ohVVug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAU2YsrHHG+/P9+grcrceDnPn4ZRQ8/BOUtrvIac++w=;
 b=NGg2gSvxZSkpKMA4OhJUfnVLh7XDiSDB7Fb9dTtHrKMiHU0JzOGjsUF4eICnxyHBicHgVFbKKumqD3Seh20Z54MKQpU2hmj9VrjWhIALNh4KOzctM+hxrQ18osI4Mp/OVbmh/IcK6o1z5olECG/Hi84/9Mg572p3DvSoRVvhZRE=
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by SN7PR12MB8171.namprd12.prod.outlook.com (2603:10b6:806:322::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 11:28:42 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%3]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 11:28:42 +0000
From: "Katakam, Harini" <harini.katakam@amd.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "joe.hershberger@ni.com" <joe.hershberger@ni.com>, "rfried.dev@gmail.com"
 <rfried.dev@gmail.com>, "Simek, Michal" <michal.simek@amd.com>, "Abbarapu, 
 Venkatesh" <venkatesh.abbarapu@amd.com>
Subject: RE: [PATCH] net: gem: ignore tx_clk if MII is used
Thread-Topic: [PATCH] net: gem: ignore tx_clk if MII is used
Thread-Index: AQHbs6Ia8v5LAhwFF0GMD5wF+Wsbv7Ow2FCAgABEuQA=
Date: Wed, 23 Apr 2025 11:28:42 +0000
Message-ID: <SJ2PR12MB8739D4C7BFF1192979C3BBC29EBA2@SJ2PR12MB8739.namprd12.prod.outlook.com>
References: <20250415150400.136723-1-martin.kaistra@linutronix.de>
 <SJ2PR12MB87391F3A43374B5C2844CFD09EBB2@SJ2PR12MB8739.namprd12.prod.outlook.com>
 <2a5c6fbb-1788-40f7-9c35-9deeb67b0234@linutronix.de>
In-Reply-To: <2a5c6fbb-1788-40f7-9c35-9deeb67b0234@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b5bf6f19-e862-4442-b0d4-84f9f08c1db7;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-23T11:23:35Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8739:EE_|SN7PR12MB8171:EE_
x-ms-office365-filtering-correlation-id: 7ae7fb92-8204-4d28-2057-08dd825a00b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Qk5nQ1B3K2J1akc5Q1VRSmRGTGdUaTZvRFRTTStYdXFkc2lCdS9iclpXdUN3?=
 =?utf-8?B?ajNVeEViU29EV2lINjVSRk9oUGpHVXFrQWZJbFZxOHlQcUpMalVRMEpVQk1m?=
 =?utf-8?B?K2RTYkMrMStUZFhmNkNmamRJeVJ5dmRWRnZZSVV6T0xrSjBNN2hSMWtuQ1Mx?=
 =?utf-8?B?Z3UxOWtObzR2d1RJUHBKa1QveEZDby9LUVUwb3N3ZE1GOEd2WWtCNTM1Q0JJ?=
 =?utf-8?B?U1UxNjBFWjBuTk11YlVWalhjbTBMMjJiSFRIamI0cy91V3hMcmwvUXM2dXJw?=
 =?utf-8?B?SUJTa1VUakJJUWhJN1dndlRYNWlLNnozdzU5MVNJZ1lZcG5YYjg0TXNucWZx?=
 =?utf-8?B?dHd0M0MzbFR2c2dEaHJkVE5XbzI3UEdvbGVQQzB3VWJ6SjQzeXFjVW40QlBa?=
 =?utf-8?B?aUVyUytkQ3hiUEQ5R01kKy90a1YveEIvcnBBNllDNjhLck9YVmJEa0pVUlFD?=
 =?utf-8?B?OE5pQVgrbG45emVnRWduQVZyYjd0TEVKekVuWkhqK3BNZElYVG5DU0VNamZr?=
 =?utf-8?B?aFR4aTNxOC9ZNmcybnlXalREUXFaZFZDT3BCMnZMVUI0aTNhM3RoTERsVXlo?=
 =?utf-8?B?NXlBQTc5UkQ4NmFzanFLSTRQUFlvRzdnSE9OZXpXcWJDQk1XbU5sQUZZZDdt?=
 =?utf-8?B?UEsrZEk5WGRlMHhFMjMyNjRxRTlnVHFRYnl2RVhDZ2QrOWh0cW9PYVpSdTlv?=
 =?utf-8?B?WGVjNkJBQ3k1M3lKa2N3RlRkS3M5L01BSHR1UVFHMGh5WVNWSFdTVTF4R1F0?=
 =?utf-8?B?R2k3QllHNlBId2Z2ZjUxWXVOTmh6M3Fwb2ExMXhMS1dodzVTSmFpZUdsRG54?=
 =?utf-8?B?VmRSNjBrdjRsQ3N1MFQ0a3c5bnpUR09jM01PU05sNzk5eUhGK3pvWTRaQmlK?=
 =?utf-8?B?Rm9zQmxsTkkrRTgrMDh0NXVPS3NnU1ZxK1BqbU5iNEZpVGdYMzBUcmI4cGor?=
 =?utf-8?B?OGVXYUxHT2J2WDUrVkRXODEvMFBTS2xlNFhqRlgyWmRXelZZdlR2MzRSY1Yw?=
 =?utf-8?B?cDEzby94UFAzellJNDJvNDV4T0Jhb0pJT0Jrcll0NjlmS0g0eGZrSWNOZ2dn?=
 =?utf-8?B?eWEvMm1zSEsrbHZvcmRxeW9mMG43RUYrWTh4MytKWVNFYmNJbGx1NGxzdXNL?=
 =?utf-8?B?SUx6YlRuUkphY2VGUytYSkUvdzhxQTl3MktteGxLblhyYXVuUy9Dam5ZdkZN?=
 =?utf-8?B?c3lnVlVVZldBVVkrNXZSQzBZT3lwV1ZBR0NBelNRampSRHVuZXNxZlVSMGJn?=
 =?utf-8?B?c0hiY2JSeHRyNmlLa3Y0ZUwzOVFIVW9mR0tDZFY1QTlWaDgwK3JVM1ltOWJy?=
 =?utf-8?B?TmxuMS9NbXY1eXo1N3RNU1dOa2ZwMGdrNXJzN1ZuYjN2Yi9MZTd4SWZqYklI?=
 =?utf-8?B?UDRDS2M1U1VlMUNrTWNWTW9zQmh1RndmbmNiM3d3LzlvemZaWDY0bkFMUWNF?=
 =?utf-8?B?bDZuMVdyTGpCSkNYUUZIajAzQ0UzY2k4aDlNL0RZRDJNb25DYzA0anZwVEow?=
 =?utf-8?B?dnBxWTN3am9weWdSOEtYYkxham53NEVCaGNWMFh4VHQva0JjZWtuQnE3TVlH?=
 =?utf-8?B?N3ljeTRneERZVW1FV3FZaDJIMHJsZjN4UTQ5a0NycXYrdUJpc2g5VllYWE1Q?=
 =?utf-8?B?MXg3SXo4Mzdid3N0enpXSy9vRnpESk44NVhYZlFLNjNDSFpXa3F4UGxkMGhi?=
 =?utf-8?B?dUlNdmlVaTZzeDE3QnlRbGV4ZVRjMW94VXdzbEhFSVZZTDU2WGtKSTVuV1h2?=
 =?utf-8?B?NHFLUnFubEpLNEw5U0tPUWRkaFkyeDZhbmw1N1BXMEhva0pLSE1UdExCMldP?=
 =?utf-8?B?clIzOGVLMjE4ODgwZHlvTWd1cC9sODhjNDh2dzUxUE54bHUzbUxVYzF0bkov?=
 =?utf-8?B?enFtdUZoTUo0U2NPYlk4NjNrNmJPSXM3aDBxbFRHVi9wb0ZPZ21tQTRQMXB2?=
 =?utf-8?B?L0N4L1JTNU54UlhnbTU2SVpHZGs3YTdyY1FML29Gc1ZRVTYwZ1QxMjZJQWhF?=
 =?utf-8?B?UjJTTkYyVDNRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WllseFhBYnBIb1JYdi81YXFsVCtHM2RkeERwb3hOWHVTNXVmamdoKzh3dmhk?=
 =?utf-8?B?MFJIci9UWU5takl2eHNyb3d0Mktnc2k4NFZJV3orWFE2WkVVbmhzYi8vRFZy?=
 =?utf-8?B?ZnFHcVEwZ1FBdEVycHU5UU5FNnVZT0VabXZDSXR2YkpwL24vdTR4bDR3Q0pS?=
 =?utf-8?B?dndqbyt6TlhjVzNkeHRvb2hTN3NWYzRLWHBIeWdCL3J6b29LK3BhUTkxQ0lI?=
 =?utf-8?B?NDV5UUpXTXpVcGtWL2pXZHdKellLeTdHU1VST3VjdWRRL1lRSDBpcUcwZjdJ?=
 =?utf-8?B?SjFQWHFEeDlrRG9najI4M1BldEQ2UlExckJwRW04SnZxYjRUeXEvQ2lPb24w?=
 =?utf-8?B?OEhTM1gvRDd3VlBGRmc4WGVoZDhJRHl1Q1d2VzZsV0I2c3RpdUcwT3JJSnQr?=
 =?utf-8?B?OGlqeTY4eXJZdXMvVWVOcFB4bzUzZFZXOTlwVlBoTjErb3UxeXNxSkMzb0hv?=
 =?utf-8?B?d3JoUEUyc0g3M3JDek1oVS9peC9BWlkrWHVqUWtEYUtHY0dRa1kwcGZpZ1U5?=
 =?utf-8?B?RXZKak1hcWRHaDFnQ0RoUm5hcTE5bjZnWFBiaGxaZlpEQnhTSEhYSkhPb0xC?=
 =?utf-8?B?TGtOQnhTK1Q3S0c5QjhYN1k3U2Jockw3THh3ZDdNNFlmS1pIRHhCbjRzQW5a?=
 =?utf-8?B?Q0lSMHI5d1NsVm1yejNhUDZOOWczQ1BnTWh2M0laa3hVQjNlWHc1MHZJU0Zy?=
 =?utf-8?B?NjczMlNidlVxTkw5elJLckl3ZkJjckpNbG1lWGFCMVhHMlRrYkJpZjZpYjdH?=
 =?utf-8?B?Rk5tbU9JMzNZMnczUnl2K1BSSGFnb3YvWnJVOUMzcmZSS2ZGR3ErTzluWlpu?=
 =?utf-8?B?elhiZ0NZMkNjMURCaVZHVHNYWG9aOTFDckJkeVQzRGtmcTl2c1pveGdBbDZq?=
 =?utf-8?B?aVJtTmhrSUc2Rm5pUTFqU2EvOGV2S0tqTmpXTHllNUJ6T2labWFpUWRCMFR6?=
 =?utf-8?B?L0w3RW1SZHJhUzI4TkNwS3paN3NXR3Q3ek1Ha2NFTitqdjdqNGhtYWxZRk5p?=
 =?utf-8?B?amZ1ZFhCazZaZDFxSzEyUXdFYW9JdGpUR0laVlM2Tk81c05hOWZqMGY0TGdM?=
 =?utf-8?B?akVoT2p6d1dBYmJHb3FIdVBkclFQQVMrSlBvVkVzQlZBQTJCT3JJVjlzZ1BD?=
 =?utf-8?B?YzBXN2M4S3o4dkFkZHRUc1JjZnVRbkJwZmZ6UnFxTTZlMU16ZnlOLzJ3K2g3?=
 =?utf-8?B?WHdFbjdMakdWT2x3OTFMM2k0OVcyWnJMSGNNeDFvTkJYVFVZK3p4aGdnRWpZ?=
 =?utf-8?B?OExFeE1QZFNraXFTVzRIWmZnY1JtREVoOVZRdmZoZXdmNDFhTEFxK1ZYNDZn?=
 =?utf-8?B?azc3SEFMV29mbXN1U2l0YXVwWGxETHhiUXhYTjdQcWoyeUU3MXd5cGFHU09O?=
 =?utf-8?B?OXhFYlZoUDlYSXRLamEzUTBRUEdSaU5HektoRjdNUTQrUXBsL0MrT3dyS3U3?=
 =?utf-8?B?Rjk2MjlaeHZRdzZuMmJWVXE5RVNOcVFYdllmREx3ZHZ0RndmYlU5dVN1RG1w?=
 =?utf-8?B?aTJSVGZLTkwzcmRWSTZmWkVnTlU4c1lJeDlyajVuWVlQcTJhZ3htSUJYS2Jt?=
 =?utf-8?B?UVlpOCtQbnNTZlc5dEdyMmFwRzdyMUR1TXRYNWx3MDFOMTBrRXdnWEJDODYz?=
 =?utf-8?B?aXJVVHgwK1dsNDhwTk50SDhXWnMxQmE1T1R4L2R6UjN4dW8vYldDUzBydTg5?=
 =?utf-8?B?U3JYZFRBbnhiaEh3Myt0bHVwU2s2Ky8wK0JRN2RxSTNKS2d6NWJQb0RDVjI2?=
 =?utf-8?B?TUJlb1ZEUXJRQWFQQjd1Q3VyQzhOV3pod0xHZHZUNXFEQXoxUkkvQWtMbG9t?=
 =?utf-8?B?OUppZFBDMU01RGE0dVprZW1Qd3A0RTJraFFlSUp6Sit4MVpESHd2M0lPVkxW?=
 =?utf-8?B?UTVmMWNXQzNwN1FNRHZLc3dnTDRNTHBmamlWYWFkR3JsOHRxZ0kvL3RkczJH?=
 =?utf-8?B?WmQ4WTV6QWhoczdNRTk2ZWdkUm5PMVgwMkV5eFQ1OVJuT1JrT1ByWldUQVo4?=
 =?utf-8?B?UEZrekRPOWpqOEdHVUJBWU14cVlLS0xValBEa1p0WDNvSGRWQ2ppRnNnNFBP?=
 =?utf-8?B?djdPT2FON0NNR0hWdHBPSXB3cGdscWtsK3pPSEk1Tk4yR1VPOUNjVUFwZG1m?=
 =?utf-8?Q?+GrE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae7fb92-8204-4d28-2057-08dd825a00b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 11:28:42.7001 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gRGYy6UkonyOe4Caz/ekchVS57KDMWCkAklTUq3jazwTLxiDS6iF1T0+rYpVLRvt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8171
X-Mailman-Approved-At: Wed, 23 Apr 2025 16:25:16 +0200
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJ0aW4gS2Fpc3RyYSA8
bWFydGluLmthaXN0cmFAbGludXRyb25peC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBBcHJpbCAy
MywgMjAyNSAxMjo0OCBQTQ0KPiBUbzogS2F0YWthbSwgSGFyaW5pIDxoYXJpbmkua2F0YWthbUBh
bWQuY29tPjsgdS1ib290QGxpc3RzLmRlbnguZGUNCj4gQ2M6IGpvZS5oZXJzaGJlcmdlckBuaS5j
b207IHJmcmllZC5kZXZAZ21haWwuY29tOyBTaW1laywgTWljaGFsDQo+IDxtaWNoYWwuc2ltZWtA
YW1kLmNvbT47IEFiYmFyYXB1LCBWZW5rYXRlc2gNCj4gPHZlbmthdGVzaC5hYmJhcmFwdUBhbWQu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBuZXQ6IGdlbTogaWdub3JlIHR4X2NsayBpZiBN
SUkgaXMgdXNlZA0KPg0KPiBIaSBIYXJpbmksDQo+DQo+IEFtIDIyLjA0LjI1IHVtIDE4OjE3IHNj
aHJpZWIgS2F0YWthbSwgSGFyaW5pOg0KPiA+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQg
SW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+ID4NCj4gPiBIaSBNYXJ0aW4NCj4gPg0KPiA+
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBVLUJvb3QgPHUtYm9vdC1i
b3VuY2VzQGxpc3RzLmRlbnguZGU+IE9uIEJlaGFsZiBPZiBNYXJ0aW4NCj4gPj4gS2Fpc3RyYQ0K
PiA+PiBTZW50OiBUdWVzZGF5LCBBcHJpbCAxNSwgMjAyNSA4OjM0IFBNDQo+ID4+IFRvOiB1LWJv
b3RAbGlzdHMuZGVueC5kZQ0KPiA+PiBDYzogam9lLmhlcnNoYmVyZ2VyQG5pLmNvbTsgcmZyaWVk
LmRldkBnbWFpbC5jb207IFNpbWVrLCBNaWNoYWwNCj4gPj4gPG1pY2hhbC5zaW1la0BhbWQuY29t
Pg0KPiA+PiBTdWJqZWN0OiBbUEFUQ0hdIG5ldDogZ2VtOiBpZ25vcmUgdHhfY2xrIGlmIE1JSSBp
cyB1c2VkDQo+ID4+DQo+ID4+IElmIHRoZSBNSUkgaW50ZXJmYWNlIGlzIHVzZWQsIHRoZSBQSFkg
aXMgdGhlIGNsb2NrIG1hc3RlciwgdGh1cyBkb24ndA0KPiA+PiBzZXQgdGhlIGNsb2NrDQo+ID4N
Cj4gPiBDYW4geW91IHBsZWFzZSBkZXNjcmliZSB5b3VyIEhXIGNvbmZpZ3VyYXRpb24/DQo+DQo+
IG9uIG15IEhXIHRoZSBQUyBHRU0gaXMgY29ubmVjdGVkIHRvIGEgTUlJLXRvLVJNSUkgY29udmVy
dGVyIHdoaWNoIGlzIHRoZW4NCj4gY29ubmVjdGVkIHZpYSBSTUlJIHRvIHRoZSBQSFkuDQo+DQo+
IFRoZSBsaW51eCBkcml2ZXIgKGRyaXZlcnMvbmV0L2V0aGVybmV0L2NhZGVuY2UvbWFjYl9tYWlu
LmMpIGhhcyBhIHNpbWlsYXIgZXhjZXB0aW9uDQo+IGZvciBNSUkgbW9kZSBpbiBtYWNiX3NldF90
eF9jbGsoKS4NCg0KT2ssIHRoYW5rcywgSSBiZWxpZXZlIHRoYXQgZmFsbHMgdW5kZXIgMTAvMTAw
IG9wZXJhdGlvbiB3aXRoIGNsb2NrIHNvdXJjZSBmcm9tDQpQSFkuIFNraXBwaW5nIHR4X2NsayBz
ZXR0aW5nIG1ha2VzIHNlbnNlIHRoZW4uDQoNClJlZ2FyZHMsDQpIYXJpbmkNCg0KPg0KPiBUaGFu
a3MsDQo+IE1hcnRpbg0KPg0KPiA+IEJhc2VkIG9uIHRoZSBzcGVjLA0KPiA+IDEuIEluIDEwLzEw
MCBHTUlJIG1vZGUsIHR4X2NsayB3aWxsIHJ1biBhdCBlaXRoZXIgMi41IE1IeiBvciAyNSBNSHog
YXMNCj4gPiBkZXRlcm1pbmVkIGJ5IHRoZSBleHRlcm5hbCBQSFkgTUlJIGNsb2NrIGlucHV0Lg0K
PiA+IDIuIFdoZW4gdXNpbmcgZ2lnYWJpdCBtb2RlLCB0aGUgdHJhbnNtaXQgY2xvY2sgbXVzdCBi
ZSBzb3VyY2VkIGZyb20gYQ0KPiA+IDEyNSBNSHogcmVmZXJlbmNlIGNsb2NrLg0KPiA+IDMuIElu
IFJNSUkgbW9kZSwgdHhfY2xrIHNob3VsZCBiZSBjb25uZWN0ZWQgdG8gdGhlIHJtaWlfdHhfY2xr
IG91dHB1dHMuDQo+ID4gSW4gYm90aCBjYXNlcyAyIGFuZCAzLCB0aGUgTUFDIGlzIHRoZSBjbG9j
ayBtYXN0ZXIuDQo+ID4NCj4gPiBJZiB5b3UgYXJlIHVzaW5nIGEgSFcgY29ubmVjdGlvbiBzdWNo
IGFzIFp5bnE6DQo+ID4gUFMgR0VNIC0gR01JSSB0byBSR01JSS9TR01JSSBzaGltIC0gRXh0ZXJu
YWwgUEhZLCB0aGVuIHRoZSBJDQo+ID4gdW5kZXJzdGFuZCB0aGF0IHlvdSdsbCBnZXQgc3VjaCBh
biBlcnJvciBtZXNzYWdlIGFuZCB0aGF0IHNob3VsZCBiZQ0KPiA+IHJlbW92ZWQuIEJ1dCBJJ20g
bm90IHN1cmUgaWYgdGhpcyBhcHBsaWVzIHRvIE1JSSB0eXBlLg0KPiA+DQo+ID4gUmVnYXJkcywN
Cj4gPiBIYXJpbmkNCj4gPg0KPiA+PiByYXRlLiBPbiBaeW5xLTcwMDAsIHRoaXMgd2lsbCBwcmV2
ZW50IHRoZSBmb2xsb3dpbmcNCj4gPj4gZXJyb3I6DQo+ID4+ICAgIHp5bnFfZ2VtIGV0aGVybmV0
QGUwMDBiMDAwOiBmYWlsZWQgdG8gc2V0IHR4IGNsb2NrIHJhdGUgMjUwMDAwMDANCj4gPj4NCj4g
Pj4gU2lnbmVkLW9mZi1ieTogTWFydGluIEthaXN0cmEgPG1hcnRpbi5rYWlzdHJhQGxpbnV0cm9u
aXguZGU+DQo+ID4+IC0tLQ0KPiA+PiAgIGRyaXZlcnMvbmV0L3p5bnFfZ2VtLmMgfCAxNCArKysr
KysrKy0tLS0tLQ0KPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDYgZGVs
ZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC96eW5xX2dlbS5j
IGIvZHJpdmVycy9uZXQvenlucV9nZW0uYyBpbmRleA0KPiA+PiA0NjE4MDVhZTUzZi4uNzAzZTIy
NDc5ZDIgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvbmV0L3p5bnFfZ2VtLmMNCj4gPj4gKysr
IGIvZHJpdmVycy9uZXQvenlucV9nZW0uYw0KPiA+PiBAQCAtNTY3LDEyICs1NjcsMTQgQEAgc3Rh
dGljIGludCB6eW5xX2dlbV9pbml0KHN0cnVjdCB1ZGV2aWNlICpkZXYpDQo+ID4+ICAgICAgICB9
DQo+ID4+ICAgI2VuZGlmDQo+ID4+DQo+ID4+IC0gICAgIHJldCA9IGNsa19nZXRfcmF0ZSgmcHJp
di0+dHhfY2xrKTsNCj4gPj4gLSAgICAgaWYgKHJldCAhPSBjbGtfcmF0ZSkgew0KPiA+PiAtICAg
ICAgICAgICAgIHJldCA9IGNsa19zZXRfcmF0ZSgmcHJpdi0+dHhfY2xrLCBjbGtfcmF0ZSk7DQo+
ID4+IC0gICAgICAgICAgICAgaWYgKElTX0VSUl9WQUxVRShyZXQpKSB7DQo+ID4+IC0gICAgICAg
ICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgImZhaWxlZCB0byBzZXQgdHggY2xvY2sgcmF0ZSAl
bGRcbiIsIGNsa19yYXRlKTsNCj4gPj4gLSAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7
DQo+ID4+ICsgICAgIGlmIChwcml2LT5pbnRlcmZhY2UgIT0gUEhZX0lOVEVSRkFDRV9NT0RFX01J
SSkgew0KPiA+PiArICAgICAgICAgICAgIHJldCA9IGNsa19nZXRfcmF0ZSgmcHJpdi0+dHhfY2xr
KTsNCj4gPj4gKyAgICAgICAgICAgICBpZiAocmV0ICE9IGNsa19yYXRlKSB7DQo+ID4+ICsgICAg
ICAgICAgICAgICAgICAgICByZXQgPSBjbGtfc2V0X3JhdGUoJnByaXYtPnR4X2NsaywgY2xrX3Jh
dGUpOw0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgaWYgKElTX0VSUl9WQUxVRShyZXQpKSB7
DQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiZmFpbGVk
IHRvIHNldCB0eCBjbG9jaw0KPiA+PiArIHJhdGUgJWxkXG4iLA0KPiA+PiBjbGtfcmF0ZSk7DQo+
ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4+ICsgICAg
ICAgICAgICAgICAgICAgICB9DQo+ID4+ICAgICAgICAgICAgICAgIH0NCj4gPj4gICAgICAgIH0N
Cj4gPj4NCj4gPj4gLS0NCj4gPj4gMi4zOS41DQo+ID4NCj4NCg0K
