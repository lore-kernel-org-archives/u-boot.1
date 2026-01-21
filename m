Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9A8C44536
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 16:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED0158341A;
	Wed, 21 Jan 2026 17:33:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="2sOKuY3q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B56CE83A3B; Wed, 21 Jan 2026 17:33:38 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBA5880077
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 17:33:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=niko.mauno@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDGnCIv9cgP8yPUL2b5cGJzLUr0gKXf81KbncF7UbNrTc4orgyVF7tBOUcy9NM1rmRm6buuZkNym0hJVmWqMEApgKu56kzqAuSfedSm7hY+2vh7VybTYaSxBvleclc1iIWfgGrdF9nQB0M+dK1qSble6X/IX7tDqbPECDhzEe0mTbFjGMaPEmlCSDOJ1Rv6l1J6j07rvBvtiUQLHZ7Y20YPpWGU0JfCKA0XdaP6jFlnjKcH5IwPe5EqZI8Eh7/53Y+TfP+w4jbqIDaB29QTDAi2/Bglh21Vdp7y8Bjexraga8PoXUwLPcxFnb4NHPT2vGpMZkuOW25UYRZJ/HqDRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0QuYYdyDA0ipni1xEOvoxEA84uwXss5X1Q4LRLN3aM=;
 b=zJ1qwp5DaGU1/Xc0KHKZ2DF4vhgHxZguAowYeOiYiG7N5ZdxTRvhQouMZdb6y7zjN3LRl+xh2sw5ifgOW3f/gfNfzUfEmmWwq21tZxcS6q//WFnfKbZTg2buB8OcS/SemkCctcRyzpWi9dUUI0tSETjZvGq5aLghIJhQrSLz7lauKqBMZow9KTdRSigiYMZNP2/QCzizrTtK+JgpCS2QV616hLCoiJ5eRkUv4g3N4GK9TNzVfhn8b4u649M6YBokwuINFMC8aCglf9IkOfS/gl50xbdEFuXrO5TuftJFnM7oRKEK1Yv9E62S5xd6Q0UNoetc9zADG490MmPElqob7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0QuYYdyDA0ipni1xEOvoxEA84uwXss5X1Q4LRLN3aM=;
 b=2sOKuY3qDWhkxefiKIk5c7kjgrKoCjjEZj5bFsURZn46GQ08g829ocl5G2Ptp7ze2izYECAPIn4PpFbjsjYAXoCDJYRmH4hQmZB2ksQW2xja6mjwgq6IL/fuqq3QOrlQJPSKzahlmSX6AXCxTOfZW+uldFmOccpLRR+jbGeRxld5nr1gwDu7YkGSmtvbEFMMPUXbgTmSiRfDihCEtIfaqt4xlrws5ZP7cFE5DfUuK5aEBMmZKaFEgH59jYPSpC6Z6/WeHDhspw600GbYspaKIq0Z730/cmd3m+SJ0MAu5wmdctKIeikpdrJeVuMiIIsq42GGgG6bRKVb99L7+ALZ9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
 by AS8PR06MB7750.eurprd06.prod.outlook.com (2603:10a6:20b:335::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 16:33:32 +0000
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::af93:b150:b886:b2bc]) by AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::af93:b150:b886:b2bc%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 16:33:32 +0000
From: niko.mauno@vaisala.com
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 uboot-imx@nxp.com, vesa.jaaskelainen@vaisala.com,
 Niko Mauno <niko.mauno@vaisala.com>
Subject: [PATCH 2/3] imx93_qsb: Enable AHAB_BOOT by default
Date: Wed, 21 Jan 2026 18:33:57 +0200
Message-ID: <20260121163358.21322-2-niko.mauno@vaisala.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260121163358.21322-1-niko.mauno@vaisala.com>
References: <20260121163358.21322-1-niko.mauno@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3PEPF0001DBEC.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::305) To AS4PR06MB8447.eurprd06.prod.outlook.com
 (2603:10a6:20b:4e2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR06MB8447:EE_|AS8PR06MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: ec1341bb-4f6d-4bca-d117-08de590ad0f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zlg5NmdqN3NQUnlaR0x3VUZGNkZxcXFreFIwaHVJL0htRHZyY2VnSTA1clJ6?=
 =?utf-8?B?bkV2UThRYXI5MEN5M3Y0YS9YWFpVZGNCU3hqZWRCeFZyN2dJdlVUSzRkWTBz?=
 =?utf-8?B?STVjamR1VGNmTTBvOWhMcEo4bWh0bmtCV01uVGxuTHYrcU1Ba1piKzh6YTdT?=
 =?utf-8?B?Z0Q1MG9HQXgxZlF5NG5wdzl0REwrbGRSRmFzUG4ydXRYU1lGT1NXa1dDRk0y?=
 =?utf-8?B?SXYxWGhqaUVjQTlLOUtjeVJXTDJrY0I2MHNyWjdrVzFXWUJFN3oyRnY2Z1pv?=
 =?utf-8?B?YXFab08zRjVLUzBnZ0pTUHRia1Jlc3RQMXp4NTQvSCt4enhobWJuNDNmOW1W?=
 =?utf-8?B?QmZBUC9hdVEraU90MVZUcEZCcmgwTGtpY2dKYkxLb25sdVVqc2VnT3YrS0F1?=
 =?utf-8?B?QWUvMHUyYkFjUUYrY1BFc2hERGluaEFOaUdZc3RhbkdHSkJDOGxFQm9pWi9a?=
 =?utf-8?B?eTlhK1RKRzBRelJ5SUUxSVFtQTZsYWplT1UwYXRDdGtmRTBYQ3V4Q3hhSnI0?=
 =?utf-8?B?TEY4d0tVLzl3dlNDa1A3Nzg5aTFnQ0FhNTZBNXFzR0JtY00zMVV1UlJGU0ZS?=
 =?utf-8?B?Y0FOKzVQNXV0Zzd5OUdqanBMbG92bjc2KzZWOU96TWNsdzQyZG9hVkIvZUFx?=
 =?utf-8?B?NmQ0TnF6T3RGT3NlRE9hUUk5aDVLVjI0cG51dUdmUU9BT0tDSktuN1k4KzNK?=
 =?utf-8?B?Zkc5ZE96RFJaOURsaEszWUFUR1RRaFMzZFdISW55MVBlZHFpbDJWYWZpQVFr?=
 =?utf-8?B?bEQwMUdHdGFuWkZ3T2g0Z0ZIRVNhaVZQOS8zUzRrTWVTQTJBZXJidHVkZE94?=
 =?utf-8?B?Y1RBc2xsVlc2bGV6RHQ0b2JqVnJYL1lBRkZSdFV6bEhyaWx5VEhncjJ3YXM0?=
 =?utf-8?B?Ui9iMVVlbmh4YXZ6KzZuRk9QRDhCOUJBTWpScnowcXhHUW82cDlSVzIzSHhQ?=
 =?utf-8?B?Vlg0S0NQeS85Zm5STTVrOU1VN0NsNmlTRjJ4bVkvYk4zRml0S1ZIOHZCODNJ?=
 =?utf-8?B?T1hDaW1adXJ6YkZsNHhpaTkvM2JjUjdUNjhmWS84VGl6dWpkR3ZrcFZnNktQ?=
 =?utf-8?B?UVFXUVV1MXd4SDVya093bE5qMHAwbFp3czdYYjRWL3BJWjBXeVBRbzJsOWta?=
 =?utf-8?B?eWdoYTh4S2lQMkNxS3hjK3M2Vnp0eHRoTGU2eTBleENxWU9uRlBDbnp2NHRj?=
 =?utf-8?B?NmplbXk1aFNoMlU1aUZ5OHpaNG0vbUEzOFlyQkF1QlQ4ZjdVUmxSamNtQjgy?=
 =?utf-8?B?blVRNHBqYzlWQ0U4RE1iWTM1Z1hSUWZuN0F5SnBnTmV0ejRMTzdVTXFNQzh6?=
 =?utf-8?B?NHloU3gwN0V0aDh5ZzBmdkRiMHA4RDhkM0RvTDFUekJHWW5KM0JzTXFEKzc1?=
 =?utf-8?B?S2dJM2JFeFd0ZG9FQVhTMVdzTHBac2hnSkFRc2lWOGM5cmJ1TGU0SFhyUFdL?=
 =?utf-8?B?bmZZUkJjQXpla3BUejNHUVJZS1ZxQlRidjJNZkgzVkh1R2dtNjBObDJhdUdw?=
 =?utf-8?B?eXFuRE9EcU0wNExuRUlpVStHbkMxZ014MFpkODgxaTh4SVBmcjVkRkxlWjhM?=
 =?utf-8?B?Tk8xOFpSYTJiUEVTMTh6ZlBNWGxYMVEvU1RMdi92YXlEaWVoY3dyNURndExF?=
 =?utf-8?B?VFBmVzExT1MvZTIwZTNyeGxObWhvNHNHeERnbXFyOGVVcmJJaC9zcDlTYnMx?=
 =?utf-8?B?QldiUWUxMkJ4bno5Qmx2YlJWUitkOEpibkFHZ3hxZFFFWkQ0MHg4TW9GZDFh?=
 =?utf-8?B?NHdoZE40SE9oYnpvdU5NU2dWbktVSVRFM2dBMGJ1T0xUekhaZk9xSTZBb0Jo?=
 =?utf-8?B?VVJKaTUxZnRidEptcysyV1pIQTBlclNtNDRJSTN3dHlzRWxwckVmMmU4ckt5?=
 =?utf-8?B?a3pKL3lkUzlkcEVwTkNwOUU5WVRlVExMQzdHbVBsbGM5STc4YzFwMCtqVmtF?=
 =?utf-8?B?Rkd4d2xGaExJYWplQnNsaXdkUW1CMzl2cmlUKyt0T29scVhVNTlMdzN5OGsz?=
 =?utf-8?B?S1ZKVllxNy94UXR1ZXdUNklMY1kwTXBoZDVUYVVyeVdnZkZZTk42c1JqOHBh?=
 =?utf-8?B?MzYzUVlmR1J4RmlLdXIzdUN5UWlEWXZ2NGFLWmRMekV1R1hLbTZGUExtVjBk?=
 =?utf-8?B?UnlWbnNXMFFPUU5tU3RtNEhzdWVxSDI2THNscnEyWHgvYllIQ0pEcFdxZ2Fx?=
 =?utf-8?Q?dMCMHypA0s5EBMFikwnEy3c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR06MB8447.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGtOd3dEeDBMMEFHblB1bHlaT09pT0lvUURiaFB6V0Fpdis2UEZ2M2JEQ3ht?=
 =?utf-8?B?Z3JYVWJKSEV5L0drOGRzK25LM1FCdHArRGRtTzIxcEtWQnR3aG9ySUx1Tzhw?=
 =?utf-8?B?VVNNT3RMbjRFcTRMbFl5OVJUM0dscXo2VFhKN2Z5S09FYUgzMWhsejNqdkNu?=
 =?utf-8?B?ak5GcUdTVW1lL1AwOUI5SE9kcHBsZnNTeXlhUkE5REJZVElLQU15RDRsczlz?=
 =?utf-8?B?MmFnd0E1elMzdlNMdXdLbXQxWVY4N3hSYVhvN0hJY0hoTEsyTkNUOUt4TDlv?=
 =?utf-8?B?VjMvOXZDblhkT0F0TmhkVGkyRDNXNmJRbHVDWitPaHFLbHU0Wmw4LzUvVjJV?=
 =?utf-8?B?ZlJWWExtVHJ0QWRGci9FUWdNemVKVkdDaEpsODdzVTYvY0NVcmZBaVVvV1o5?=
 =?utf-8?B?dFNRSEk4YzhqTTkzMkZ5UGVkYW15a1RTMTF6NHpTVnNQZGhSajNiNTFwWWl1?=
 =?utf-8?B?K1Nyck1UVDkrOHBldExNcGFSRDNOMkF4emxLL1BJU1FnWldHcjVMOU1zVTVP?=
 =?utf-8?B?Tzc4TlBlWTM2dzdsNXJ1S1M1cWFtN3c5NmoxSldyM0pTRW0zTlVUVjE1d1dP?=
 =?utf-8?B?cGU0UG1PZldRMUp5SWxPV0trVEhsa3d0a0tQNWdIYXlpeEdaVEQzdUdSMFZE?=
 =?utf-8?B?RDhteGx2S1kvZnFoOVFQZ2xNc2RaMDRYS013WFZzOTNEM01OUTNZVnUxU0ll?=
 =?utf-8?B?UzNjb3RhRDhRc2V2N1k0QWVzb3NZejJJQVNocWU3dzNlcmtxV1VMdnVPKzNR?=
 =?utf-8?B?KzlWZjFqd2RxOGlWZlJ2QTcvMnZDWVhIc0ZVVVQyQ3dDNzQ3OHNxU296Z0R5?=
 =?utf-8?B?ZEJheVFZemJxQk4zTTh5STIxNWljQUFPTG1aaVIvUytWR3V1MEhEMTc5Vlov?=
 =?utf-8?B?T3N2cCtmcE1nNlUrNExiaE9NUC9TRmM1eTVxMEdIdVJNekpuS1lLSXBmeTh6?=
 =?utf-8?B?TDFyVS9KRS9EOUVoTEc3UEd6aVk5d1p3QS9KeU9ZNHBzM2greWRpUHhaQTJS?=
 =?utf-8?B?MmVmTVBTWXJKcy9TZDZwNUEydU9FWlRTcmdpUTlRMlROVXhKZElsWUlTZmFG?=
 =?utf-8?B?dkRYSm9yOXZOWkprMTJWU1JRWjd0UllaS0F2bFExRzkvNmpuV09mNjVYOFlR?=
 =?utf-8?B?STBwck5DWkpyRnh3VTg5a2ZCT3ZoR1FxcWRUbDNaMlQ2TUU3SGd5bUlielhn?=
 =?utf-8?B?N1EyaGJHV0psRGZBMjVTNTlaSExJdzMrUjBOK1VyVW1qNkxRU05mYTZyaW5v?=
 =?utf-8?B?SUM3UUl0c1VTL1hxdnNVVjRyNkF6WTZZbzJtVFN0bytqUjlNdnNmTXRia1BU?=
 =?utf-8?B?MkNucGk3YjhMODFUdWMzbTJmNjg0d0hZa240aXVVckIycE4xbE9qYXBwcXJY?=
 =?utf-8?B?ZGl1dUd4dnJwbFlhWTlmTUVwOEs3REd2V0hXWFo2QlVyeXBmUlFza0ZScnRj?=
 =?utf-8?B?OWRCVDgxVjMrTElnNUdGZkhRWGNFczJTRXdhWHpsbjVBSTBVNnZCajdxd2dW?=
 =?utf-8?B?dUpHR0VKdVErU2FqaHBSYkdFK2ZCVzl6WEVqbEdDR2J4K3VrWE9tUTY2Mk1h?=
 =?utf-8?B?OUZNZ0QvREVBVC9tTWxnUVJIS0ppUG1uK2pDaFUzZTZPT1Iva1NKVXhzQ1Fi?=
 =?utf-8?B?VFVxMFVWdUtqVUx0Zmp4bE0wWGNTR2tZTlpNUGlrM1VlTURIbCsrMGF1eklv?=
 =?utf-8?B?dTlrT2dCZndGUUl1S0dXRFNPeGxMSnhNbTZjMHU4SUNrYS9Va2NUQTZscHFk?=
 =?utf-8?B?UUIwckJmSUVJUHpVUFdZdGs5bDJkMW10UjBEM3RoeFd0bG9FR1ppRjdZd3Jy?=
 =?utf-8?B?alBsZFRZV0t2NmxyZ2lpekY0a0Y5eGYyd3Y4Mjl6ZnRrZFp1dlZmUE5GK1B2?=
 =?utf-8?B?TVp1SmZvUVBQOW5hb09kbDZNRDhPRlRvUkZHY0JnSUxCeEVrcmd2L1ppRWE4?=
 =?utf-8?B?bHgwb1VzdCtKNlhSdVUzdWZWRjZiazNRbWdDamtqRVpPUkY4Ujdscjkyd0ZR?=
 =?utf-8?B?WnVvTnpzNTJuR2tMZHh5NVg3YTJNWUJ4K2hxaEVUUjFkR0E3ZlAzZXpsM21Z?=
 =?utf-8?B?bkY2c0M3Y0x2YkNhMDFGYlZLRUJkNWhuN1VFNVRKNTZhREhMUGRNU3YxTUJu?=
 =?utf-8?B?TVNIYzNIdGVzaWtveGhIczllNzNMVzBRZ04zb3FqT1VSOGxvOWJPZUp1SXNa?=
 =?utf-8?B?alo3WDFCbDlERDVTRktiaTVZc3poUUhQLzQ2aGtOMUYrUTk3bDJ1SmpqNEtp?=
 =?utf-8?B?WDlhdU9uaHAzMUxMWmtueHQ5YUNWUTVHYVlUVXlqNEZrN1dHYldHbE4xQVE2?=
 =?utf-8?B?NUpyZ3pHVlRKZGcvOUdGUEk2MW1lbTVKZXZ0WHRNV3BWSkR5MEtzVm1Obm5O?=
 =?utf-8?Q?WNDo+DzGtTNs/w24=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1341bb-4f6d-4bca-d117-08de590ad0f9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR06MB8447.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:33:32.5162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdxIp5P4uLKSFiu1LhQjOa+YoaAE5bDkF/PzzrvLZAStmY5gB0OYElQ30jTGQJlcQKrFObfaMfgBpCFPwc3Kbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7750
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

From: Niko Mauno <niko.mauno@vaisala.com>

Enable the support for AHAB secure boot.

With this change, one can issue 'ahab_status' from U-Boot command line,
and see e.g. following kind of output:

  Lifecycle: 0x00000008, OEM Open

      0x0287eed6
      IPC = MU APD (0x2)
      CMD = ELE_OEM_CNTN_AUTH_REQ (0x87)
      IND = ELE_NO_AUTHENTICATION_FAILURE_IND (0xEE)
      STA = ELE_SUCCESS_IND (0xD6)

Suggested-by: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
---
 configs/imx93_9x9_qsb_defconfig            | 1 +
 configs/imx93_9x9_qsb_inline_ecc_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/imx93_9x9_qsb_defconfig b/configs/imx93_9x9_qsb_defconfig
index 7772cc4ed11..913eb821249 100644
--- a/configs/imx93_9x9_qsb_defconfig
+++ b/configs/imx93_9x9_qsb_defconfig
@@ -12,6 +12,7 @@ CONFIG_ENV_OFFSET=0x700000
 CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx93-9x9-qsb"
+CONFIG_AHAB_BOOT=y
 CONFIG_TARGET_IMX93_9X9_QSB=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x18000
diff --git a/configs/imx93_9x9_qsb_inline_ecc_defconfig b/configs/imx93_9x9_qsb_inline_ecc_defconfig
index efa0bbd92ad..3e954a491fc 100644
--- a/configs/imx93_9x9_qsb_inline_ecc_defconfig
+++ b/configs/imx93_9x9_qsb_inline_ecc_defconfig
@@ -12,6 +12,7 @@ CONFIG_ENV_OFFSET=0x700000
 CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx93-9x9-qsb"
+CONFIG_AHAB_BOOT=y
 CONFIG_TARGET_IMX93_9X9_QSB=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x18000
-- 
2.47.3

