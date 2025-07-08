Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5231DC83F09
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 13:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A3BC8331F;
	Tue,  8 Jul 2025 15:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kneron.us
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kneron.us header.i=@kneron.us header.b="rou/UhNy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1B328318E; Tue,  8 Jul 2025 03:17:02 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2072c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::72c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37CF783145
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 03:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kneron.us
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chance.yang@kneron.us
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWJGwInFdGO5Q6RC8Rqdmxqk176gcQfzOD7tW7yig7Va1LVZ1BR+uHP/QNLQn68v4qg08828ufnHuUpvRWah32mrDN5yc8VbybGxrND3irJ49A2hVJ7qTP6NfkGEz9XiprnfdJ7dlUkjI/rF3WFxGdaOo7St70u15bNyNmsEedOkUaTTr7XxFqHkd+gqqY7MeVuxvpJ91gW9mOcV04UW5fhDLGLn/s3WIOgVdycUIzMFTtsLMOzeDTTIDTGPn/8aDrRLimYH9aVcbTxmtoPZk8E/k+hD4PKEV5kCyibUT55aHNdixknZYflKYWXVz6VWJUBs2+xbKVLkAxU3ng9ksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1UML1F0DcQ8aBW+QL95cl4OJD0uicJzh7yV2i7Scn0=;
 b=g7xZrdayDXPp+kk7uGfSZWK+Cp896fZYAftL8eYS6IAGLdaVybofHaxCvW4jAShdEuyMbDSoB+FRIcKWK72zX63r6S2Mz2r4t7CTzBQERPpYFf2dJHhJu3BkAzKQIHmtfi7tPcbVUwrckXJpf4UXjEwDjv4cjO1Vm0mGE8Eivo/ZrhqUJcEPDQPaKCtZMgTmFkP6xJJsRG/ja7SXCd+2AZmAucbH20JZCqCeTa4kG8T7hXS2Boj7o5qvVbb1/SaPNMYaBNyAaQHXs5tBy5q7a3G+XDbEF9oxap2gUkJwcNazfjqhmFaCh6yZt4v13NFSwWhYP3IJyigEINuftJ1K6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kneron.us; dmarc=pass action=none header.from=kneron.us;
 dkim=pass header.d=kneron.us; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kneron.us; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1UML1F0DcQ8aBW+QL95cl4OJD0uicJzh7yV2i7Scn0=;
 b=rou/UhNyHOnvlzYcm9KHG1TmBtT2HN9YSsa4okTlUwQH7cZrtUDnVxudl3o/RLdNNG5nN2XWu8B3BTh1CP6p3gJU8RujCGlOiIU9Qxfg/vRCSCcsYUqDvGQ4v3RaoB4uqeJu+lbRNXMBSEyGmDvgOW4KolNEzodiejo5WZzm8d0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kneron.us;
Received: from PH0PR14MB4360.namprd14.prod.outlook.com (2603:10b6:510:26::18)
 by IA1PR14MB6342.namprd14.prod.outlook.com (2603:10b6:208:422::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 01:16:56 +0000
Received: from PH0PR14MB4360.namprd14.prod.outlook.com
 ([fe80::f91d:52ba:8284:3e02]) by PH0PR14MB4360.namprd14.prod.outlook.com
 ([fe80::f91d:52ba:8284:3e02%3]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 01:16:56 +0000
From: Chance Yang <chance.yang@kneron.us>
Date: Tue, 08 Jul 2025 09:16:47 +0800
Subject: [PATCH] fastboot: Fix has-slot command always returning yes for
 fb_nand
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-master-v1-1-574f8bec645d@kneron.us>
X-B4-Tracking: v=1; b=H4sIAH5xbGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwML3dzE4pLUIt0ks0RTY2NL05Q0A1MloOKCotS0zAqwQdGxtbUAgI5
 ZYVgAAAA=
X-Change-ID: 20250708-master-b6a53395df05
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, morgan.chang@kneron.us, 
 Chance Yang <chance.yang@kneron.us>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1465; i=chance.yang@kneron.us; 
 h=from:subject:message-id;
 bh=NbyBo9N3mxW5uZdFNjNbpi+PbGqxc0mGYQnwivaRZrs=; 
 b=owGbwMvMwCVmsuR+7eedxj8YT6slMWTkFLYwLGCUecIfvyDe9elmw6M+bQX/tsglrXkpzq7Tr
 rro3LznHaUsDGJcDLJiiiyfs5X2e7c0z7t1pWc/zBxWJrAhXJwCMBFOM0aGCXvVRGI+tD86/y4+
 aX6amt20Szor7gRoBB/ZHfTco39qA8N/p43Oba+Orvhv6BF1KSN+06YMweO5sREJayvLZs2MOJr
 OAwA=
X-Developer-Key: i=chance.yang@kneron.us; a=openpgp;
 fpr=F36B22BF4B84839EDAD48CBF34A4DF7DF3B933F8
X-ClientProxiedBy: TPYP295CA0018.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::19) To PH0PR14MB4360.namprd14.prod.outlook.com
 (2603:10b6:510:26::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR14MB4360:EE_|IA1PR14MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c16a65f-be25-456b-8107-08ddbdbd212d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|80162021|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWJDRVNXcmFQQU5EUEJ6QjdWZEs4K205ZzcyT0dQTCsxcEhFMXMwQlZOUzhP?=
 =?utf-8?B?V2NieTdGMExYVlZPS2J1cUZ4bXBMS3VVWWk3TlJIaVBOVUlrVDR0TTl6VTJK?=
 =?utf-8?B?VkZWWFZaSGZ4dGhQT0l5cUtOOXR0MDlmZHM0Q1NOQ0UxYytrSWhzQWVyVTNM?=
 =?utf-8?B?MWRDdElueXBvNGxYd3dvc2Q4dVNxSjFCT2h2V0VUT1ZFY2hRZUI4cDFFbGY2?=
 =?utf-8?B?aExGbUZuekcyZXM5aW5BQ2YydVJ3aERhbjUzUUxhOHRLU2xBelVlR3N4RlRI?=
 =?utf-8?B?ZTdkNWQxcm1KYlQ2a3RsMFBFL2lLdW93RGk0bmgzVGlNbTFYMDBjQzJhdm9C?=
 =?utf-8?B?QWVpWGR0ZzNHSUxEUlpjU1FrMHNoRXJzTGdGQk1hUEl1ZUJIQzYvL3ptcTda?=
 =?utf-8?B?R3lSai94cGhWbXJBZ1NEcDFSSzVaVEFGMUs3QnR1ZU5MR1Q3MTU0Uno3aGNt?=
 =?utf-8?B?THJhQUNieTFZd2pwTXNQVFVRQUVKelp5a0p6enhmeklyYmV4cCtodlhuSzRX?=
 =?utf-8?B?N2hBTnA4ZjBqWlZKR09tSVBKL2d6VTYyampWaUE4QmpXSVd1NzdDYjliSmUw?=
 =?utf-8?B?T2ZPY3lETDY1ck91RFlYdU40Rm5VYmxpTy9xRlJNKzdGNjRoQlE5dUFyY05S?=
 =?utf-8?B?WFBCUmI4WTI2RUFielNZZml4NDdKUkVucm41b04xaFRZcDU1MGVzbjRDUnk2?=
 =?utf-8?B?eCtnUnpWTGFhRGdRb0huVUhFVTNVYWRnK09CQTlTV1VUM1Z4ZjNoUzh3WWVi?=
 =?utf-8?B?Z3BZQmlqaVpTMk10dlcydE0wVGpkbFdtbzVqS1orOG8zUWVaZTQ2RndrTVJC?=
 =?utf-8?B?SHVvZjMyZFM1MEJhaEYrRmFvYzhYZlJKVEZFcHJ6TnRzbnRLYXpSZGV2SFNM?=
 =?utf-8?B?TFFWQm84RHg0c0dZWEZmVkRnQW16Mkk4dkxQQXFmaGZ4Z0l0eGNEUmdta09x?=
 =?utf-8?B?VmJPZnBSQ29oZXpjN3FibGlhZGlLNEpjTnVMaS9Qd3pGbnQvZ0Qzd2s5UXV1?=
 =?utf-8?B?ekJNMld2VFlXY2s3dGdYNE1UK3VFeHBtOWdEMStqZnQ4eXA4VUF1VjBYbXJW?=
 =?utf-8?B?RmwwNEExSG1aOWJUaUFZTDJKWXJHdDhzUlRrZmtsN1AyZXptajNkZ0IweFZF?=
 =?utf-8?B?SS9aYVZNMWRQS3pjendHQStrMGREdXplWVRMME51c0Nzb3RJWVJ1c0N5bzFx?=
 =?utf-8?B?QlB3RVhvVGN5MDVCT00vMUVLZDB6YkFJekJqNldYSEdPOVI1TVFFUlBzN1Rj?=
 =?utf-8?B?YU41QXNrN2xYK3M0ZTVmMHRuZHhQWk5HY0tNK240aGNJWURtTUZqZzhjbFlk?=
 =?utf-8?B?V3VFZk8xTzlFMEg4ZDZQZ0JjeEtnR3dFZVd6dGNnM1RLS2RiSnVUVVhtQ2JK?=
 =?utf-8?B?bVJpUElJKzZROHU4NHg0ejNCcnVSR2JEb05lQ0dXWnd5aDl2dUFpd2dCbjQ3?=
 =?utf-8?B?VFYrRXJGZ1VlUXhvakVKWE5Zc3JJUk9TcEhPQ0lvdng5blYzTUtzRWc1c1JD?=
 =?utf-8?B?b1F6cjBSZ0tBZGRzS2d5SkFFWVdwL1NudDNSNzQrZGM2S3pwbmhHKytha2J5?=
 =?utf-8?B?U1RXTEJsQmFFWG9XeXI5Y0NYOHBydE13cUlKT3Q3SkNzdzVzZ0wwdEREaURY?=
 =?utf-8?B?aHZQVzRsS0RTakxmY2UwOWNLSENDb1lPbTBRdUZ0Z0VZS2RvWTFMdjhYNlJN?=
 =?utf-8?B?SThDRSswYk5oL1JZVHo0cmROem1qenRuN3dCcHhUdUMrRnU2RFJSaUlpZGlP?=
 =?utf-8?B?bTNsRDRnU1pUeGxzV1Zxc1ZabjZwaDFMSVN0Rzg1amxGRkpPYmpSRHRJUVc5?=
 =?utf-8?B?aDVJYloyMUx5T3Vqazg0RGxZT2tzZW9MVVRpclFqRk1vb2JxdzJTay96NDEv?=
 =?utf-8?B?aXNuRy9OWmkrZExyak5iWjg4NVErY3orQjJYUjZEb1p3bC9JN2FVM0UvSUpx?=
 =?utf-8?B?NHlpKy8yRGpNclF3dSsrMUcwLzlhemRjVFc3S2ZKbE85L3Q1SC8vSU9MYUp2?=
 =?utf-8?Q?Xb3+jisn2lJSVXtpqGt0vHI903dA/8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR14MB4360.namprd14.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(80162021)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWFMbFRvSXd2Y1BaQnNWQ3ZsMjkzMFd0UHQ0cldqK1V4dmNQcEpUc3BwcUNo?=
 =?utf-8?B?V0xWWmJVcXR4SXRYU0Y2L21BLzZ1WDBhNmVyeUNpMTZWSGhDWVhvaUJKQ094?=
 =?utf-8?B?aGJMY2hOMmFmNzNVVkgvY2VSWWdTcVhLR3RhclZQUVJWVnVjWXFsbkgrbldR?=
 =?utf-8?B?RmFQMDdueGIrOHZzcjVaUlFhZldkaitwVmNwQmhVQjBLT1dDRVBtcG9kSjUy?=
 =?utf-8?B?SXNNcUt1L3RDS1pVcnRFakM3eHlySVUxbWJaTk9RQ2U3UHRsb1g0NzcyMXVs?=
 =?utf-8?B?amtJNStkNFByMDVCempZNGNjajBhSW05MENDRGkvUW9xUi9odGM4TUt6R1ho?=
 =?utf-8?B?dFplYmNCU3E3REtxbVZlRmh5ZEJ1alNFNS9JZjBPdVN5VTJubkVwRzk2WXVk?=
 =?utf-8?B?TU5jWlVQdkxkUWxUMi9VTk1lZUxZRGk4L2VHUmtDcThnMVRpWDBJbDk5WmVY?=
 =?utf-8?B?V1BEaUlVVDRCOXR4UVhLTzhTUTBlRTd0WGxNTjA5WDlodjd0ait1anhWeUhv?=
 =?utf-8?B?cnI0YkdMQVZjRHpCSmZka29WNWg1MzREa1Yxc3hia2JWTDdCSFl3bXViWEV0?=
 =?utf-8?B?RFEwUGxCTEF3dTN5QVUyN0JvMHR2cVVzZ1FoL1BBT2RxcFQrWGxiWG9WUFB2?=
 =?utf-8?B?UWtmQnNMMmp3MUNxMEFOaExIMmp2NmZWeENxN2h1V1JsdWNiWjB0TkF1K0FB?=
 =?utf-8?B?U2Rrckp2cHZQWWtuN0tCZWhpeml3a2dUS2EwRjZrL20wbzg2UDVtVlBjUmQz?=
 =?utf-8?B?cU9uY0wreUt0SW95L0Z3S0tMN3JwZUZlYVdnR01JODVUa0NSUmh1QXZoczA4?=
 =?utf-8?B?U04yaWF0TXNzd2xqckpkMEd1ZmNUbW1PaDlKL2FOVW94c2UxOGVJemRHRGts?=
 =?utf-8?B?LzB6WnpqWk1JZjlzbFNhNUtoQm40bWRLMzY1QmxyaFgrb2JTQ3NYdjJYdXVo?=
 =?utf-8?B?cS8zRFEzbkkrVk5iRVRGYy94WTFYSGpnbGFHTDF5NEt2T3lkMWFFVkRlMFZn?=
 =?utf-8?B?ZkoxWVhMR2g5bkxNdjNqcm9vZ1B0Ky80eXFXcHExa1FJaHRtOEl4UmdsYjdK?=
 =?utf-8?B?NitPck9lLzZHQzNic0tEVXhab1kya3JPY0RBT2M3cStUQ1J0Vk5rblhxeUla?=
 =?utf-8?B?am8vb2FjWmwrc1Q2YW9GcFdrMWRmZUtvQXNwUlIxWWRya1M3aTMwZnNmT3ZH?=
 =?utf-8?B?VHFJVDVnOUFpd2ZNZnZ5Q1dFU056YmduMk9CYXBpa2NjUFBPajk3RFBBeW9K?=
 =?utf-8?B?V1pRNDRNOWdIRng1MlVFS1R5cElIY2tjL2U2VWVpdzdVOEdXWlkyR3VkY3pP?=
 =?utf-8?B?OWFaYXEzZVFuNjNjcWh1U0NIM0pSYTFOT2tBUit3WThpdDZsZkY0MENqc0NV?=
 =?utf-8?B?MmM5NDFCYloyby90Q0thMFIzam8yeFJsZEVESkhqNnArZGpaNzJlR0hrRkJB?=
 =?utf-8?B?QTNBNWZGZkhyUjZtc1p1K2VnV0pvL25Sb2UyOTMzd1grNFc4S04rdTV5WjE2?=
 =?utf-8?B?am9sODU1SndpbTU5clJJeitGVi9oa1lwUDU5bnc1UWJPcHBocTQ4UDNiL2pG?=
 =?utf-8?B?VzVFcHRpd000M01RYm01d0VEYXZ1aTVxbXk3Wlc4NFpGUHJsWDFkMzlRSEIr?=
 =?utf-8?B?S2JHeXNBeXR5UDdwbDRMc3RDRmRIaXRpbzhNdFFmZnhEVnF3dzRpNGphSWda?=
 =?utf-8?B?VFUyaGp0WFhzY0xuVHlWbkw1QkN1aURrUXMrU2tjSDB3aUwxdCtnMmhsbXE3?=
 =?utf-8?B?S3JRcEFSTlRTVDZXNFlKUEdaMGxORC96SERpcWl0ZFIvRDQ5NVoycTlQMUtr?=
 =?utf-8?B?d2trN29HcWdsV0xaTldET2QwaEdRUG91QTZwSlNSR1NGWEF5a0dzTWZNR1RM?=
 =?utf-8?B?RzVIblhCa25ESXo0aWQ2S0J5UU93UVNrNGluMStOZHVwV1VnQTlrV21jam1q?=
 =?utf-8?B?RVB4Yk9hSDc2SWdQd0tTRkZZZlJ1Y0hoUHpyeEk1T3pmZENuRURrZGs1NEI0?=
 =?utf-8?B?U0tXSHl3cEllL25pN0VNUnhaM2UwNFZJYU9PZDEvVElWR3RRaVcwTXp2WEFt?=
 =?utf-8?B?dlVGL3Q0ZWZHZVVDWWtXS0k0dUFKazlUZnNXUVFoZkNVNFh5WVJlSlpQNGhz?=
 =?utf-8?B?YXFFR2xUeW1xNUZDclROWEhPa2N2T09mVWJhTVRxcTg2WUZuU0QzVDVRamZC?=
 =?utf-8?B?YlE9PQ==?=
X-OriginatorOrg: kneron.us
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c16a65f-be25-456b-8107-08ddbdbd212d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR14MB4360.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 01:16:56.0600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f92b0f4b-650a-4d8a-bae3-0e64697d65f2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLE4OBmbl0OZ0+1h96idoyLlN8UkD3YQizwHmHKyl/H+iQf94dghzZGoNf/hHoGnK72gvxb1PnNShJaBaBkM/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR14MB6342
X-Mailman-Approved-At: Tue, 08 Jul 2025 15:23:43 +0200
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

The issue was a mismatch in return value conventions between functions:
- getvar_get_part_info() expects >= 0 for success
- fb_nand_lookup() returns 0 on success, 1 on failure (from
  find_dev_and_part)

When partition didn't exist, fb_nand_lookup returned 1, but
fastboot_nand_get_part_info passed it directly to getvar_get_part_info,
which treated 1 >= 0 as success, causing has-slot to always return yes.

Fix by converting positive return values to -ENOENT in
fastboot_nand_get_part_info to match the expected error convention.

Signed-off-by: Chance Yang <chance.yang@kneron.us>
---
 drivers/fastboot/fb_nand.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/fastboot/fb_nand.c b/drivers/fastboot/fb_nand.c
index afc64fd5280717ae4041ed70268ccc01cfbb0496..b819541eb8fa6f537ca40fb3ea81bc7aab6118bf 100644
--- a/drivers/fastboot/fb_nand.c
+++ b/drivers/fastboot/fb_nand.c
@@ -157,8 +157,13 @@ int fastboot_nand_get_part_info(const char *part_name,
 				struct part_info **part_info, char *response)
 {
 	struct mtd_info *mtd = NULL;
+	int ret;
+
+	ret = fb_nand_lookup(part_name, &mtd, part_info, response);
+	if (ret > 0)
+		return -ENOENT;
 
-	return fb_nand_lookup(part_name, &mtd, part_info, response);
+	return ret;
 }
 
 /**

---
base-commit: d1d53c252a4a746db5ebcdf0d6de3aa0feec504e
change-id: 20250708-master-b6a53395df05

Best regards,
-- 
Chance Yang <chance.yang@kneron.us>

