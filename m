Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F348C5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 07:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C404F8070C;
	Tue, 10 Jun 2025 09:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="kjBOtrk1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A169080C83; Tue, 10 Jun 2025 09:08:31 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73960805D7
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:08:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CatxNgXRAAyPTKSREOamMVVMFHGc+nGLa2ypDd5ulaskcgIY0YT7ssejEvdzObWc2H4J7GtJThcKLM5pTpa9G9OW+nkKh4nxtr3+p2rKxtVSmyHrrGuRhSGl/vAf0MH3DoJ49xNlTpcp2zkNUzO+LfUVGahposUBc3bSMTiWYJHaxGfq+nnycIvik0QqeQC1Jhnbo7iRq/dpLrwt6Upsj66lFESykSRuUCwDMR+zl0nIvVFiRm5Ft2yyc1hJ1XJeCoWjPdRWfayYIBrBmu0OymYT9DWEAzXczuYY3BtIzbAkjzfoeNoKMeoYOLT6bun5GOd0vmTaO6h1acOpIe6A+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPf4P7U20hxwbZ0O35pvZBKpKpXO1a12Bfq0onHdZ7I=;
 b=sh6h4r6NgCxMJK4OHP7w/xyDmvC3r8htBkEGVqayUJ/zMeoeQX27FuWD9ql1sC5yYR5h4n/O8Rsc5Pv9ckLcpkssawu8Lz9o6mX9xdeUXQMSgITBjQ+1ro/PjVMin11gdQO+U1sOgAOWWhx4vMLEe/xbsrYZX/EAFVx8+vyCp99UNRnWFbgJsavOK5Y7SFcT8GnNscpp91yOt5CnFgdHbFhv9dq8wSJuz4TouiwHbTrAdb+B4gbQGc3OFsu4aKpgDlHTBnfXwZ0PerTalNPWPpW3CxbnGQVwvdKQJjsmYTqUsSYBPKrh1Rjt0tr2+z+aYl0SiARwK/fgjkuMnubM3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPf4P7U20hxwbZ0O35pvZBKpKpXO1a12Bfq0onHdZ7I=;
 b=kjBOtrk1RXW1RTGwzhhIGHUtvuXM/lcvnb+Vtkz4uV4lJQSl6Z/6WEh5kzHP1sWDEiSOjqNkZKJaSltrYhFto0W2kKmacY40iqw4iteLCcuUxOGKz0ETB5naANQvM755z82/z7XiIiAwzRrUvjCN9jZAcBhUsVxlzp9FxIU4EFgfST8qT1pcsljWfx6dCCBzb3dGRR4Ex6OBaK7ltL81bMZ+6ZGLZJCrBc3Y7nKNUA6nzsUwjIudqzOxPpmCltnDU6xQGhNrnGIJbmbWnFltqvBzmjbaW8j/nMFswkd5huiUuuUBe1g+Acu00CK8tGGg6wa69Y79pQdKiWCnIY5nzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SN6PR03MB4288.namprd03.prod.outlook.com (2603:10b6:805:c6::21)
 by CH4PR03MB8018.namprd03.prod.outlook.com (2603:10b6:610:236::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.40; Tue, 10 Jun
 2025 07:08:27 +0000
Received: from SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55]) by SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55%5]) with mapi id 15.20.8835.018; Tue, 10 Jun 2025
 07:08:27 +0000
Message-ID: <7b12653e-d033-4858-9aee-1a8a2f264ffc@altera.com>
Date: Tue, 10 Jun 2025 12:38:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Create FPGA Partial Reconfiguration (fpga pr)
 command
From: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20250524203737.20541-1-nareshkumar.ravulapalli@altera.com>
 <CAFLszTjiRpYaG=Hx2fo5gGowpfkww1t4=W7iaEpgbU3OgWKbuQ@mail.gmail.com>
 <459a6e3d-040e-4130-b643-c822f4008daf@altera.com>
Content-Language: en-US
In-Reply-To: <459a6e3d-040e-4130-b643-c822f4008daf@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0101.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::11) To SN6PR03MB4288.namprd03.prod.outlook.com
 (2603:10b6:805:c6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR03MB4288:EE_|CH4PR03MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 58206b6c-45bd-46e3-6c14-08dda7ed989c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dU5FRGhxeHlhdjlQSDNEVzNVdWtOOWlUc0FjMTVmMUlPUUtQZC9oRXZySUU2?=
 =?utf-8?B?NmVicjVkM1JKWHJLV1NFOGFreC9sTjNHRkQzd1RySUw0SEpQVkg4NEd3ei9p?=
 =?utf-8?B?M3pCQ3ZzV2hRZWdHNmRVNFAxWTNLeFUwOFM5akFjMVhBUGRjWUEwKzBPcU14?=
 =?utf-8?B?SUhTUUkvcWNEQVR1WjdWQTlZRDlseXd0cDhsb3Q3azlCZUE0STVuTTNEYXNv?=
 =?utf-8?B?Ykk0V25CKzk5RWFXTWFRKzVmVWZ4Si9XbEZGeVU4eUJudSs0c3ZiQTNYSVFm?=
 =?utf-8?B?OGZWQzhWQTBCR29ObDIrekZjSjdYQmtTVk84S24zOWFKam9vNWhoRUdDbHZo?=
 =?utf-8?B?MGlMTmV0Y20zQ3RpV1pnVVpjNG1BQ2MrMGlQMXh1alRkMEZtemV6SXpJeFFI?=
 =?utf-8?B?U0ZaTktmWHNmb21kS1Q0Ry9EeWNBM0hjQXRwQXFPV0dEMFNDb2s1MkV3L0ox?=
 =?utf-8?B?N1lYeHZmcWdRN0NVTFN1OFU3Rm1aU05sRWU1VVkvWjd3RnpSZzQ2Q2NDMmdQ?=
 =?utf-8?B?K0E2N01WV1Z4L0hFVnFoNnltMWRocmwrUW16TDJHZ3R4OGpUcTQyWkQ2K3Bw?=
 =?utf-8?B?NUpHV2lPaUUvaUpwcTYySnROYjk5Y2UrYWVuSFlJeDFObHFrclZPUDlpRjhs?=
 =?utf-8?B?WHY2SUpBNDVVNXVqNzZkd0lLdUU5eDlHdWtzT2hGWEN1ajJXYUc5RmhzcnVW?=
 =?utf-8?B?RXdUamdDaTF2a1RRaHdyZXV5VU91UTh3Wlc4Q0NHR01jQWZ5V1Q0TWZHVG9w?=
 =?utf-8?B?MTA2U1F1QzYrcEJFTVdVK1BwZ0lJRXIwWlZIaDQ3S1AxTjVYWmNkNDBEU0Rs?=
 =?utf-8?B?bUROR0RiU1dhWnZJbnFHUFIzOGQ1K2J4S0VCSzFlR2s3WjkyeXZQSks0ZHJJ?=
 =?utf-8?B?RWlVR2VPSlc3cHRScU1SQ3RZdk44Zzh6RUcwak1vV3FuTktqcFpjb3hwREk3?=
 =?utf-8?B?a2t0TktISWtIS1FaYUNnand3S0tGN3paOXVndER5SjFQL0xFVjdtM3AwTHpB?=
 =?utf-8?B?aWpUM2VmQzhaYjFGYUdablRmQXRVM2pNV3ZHTmZIYlFZeW5tclhTN05IdGJq?=
 =?utf-8?B?TWFNakVtQWx2K2NDbE0zV3lYMGs2V0F6V1d5RjBUVkxQckJXMU9XQThGTG5s?=
 =?utf-8?B?VTd4TG5KY1BwS0ZKeFFsaGxxT1d6VjRlUU4zNHlDS1VIaFFObDMxeHI2S20z?=
 =?utf-8?B?RVlJVEVRTWZzcWFYSFNObWRHN3B5VS9NT3M5NUQ2ZldjbzJLWUxYeTJEMGpC?=
 =?utf-8?B?S3pSRTFqNmpFY3I1a2M3U2RPY2kvWnQ1STVGcFNRNDlWeTl4RVZDbS8vK09q?=
 =?utf-8?B?NWw0SnBzejZTYWlTMm5QcEpUZGdBTW52Y2FhTjlWa052ZFI3ZUU2aE5UTVp4?=
 =?utf-8?B?d09rZXBYeWpkbjY2MmZyTkxNWkVUWlJZd1ErREJBMDF6SkRLMlU4YjBKYmhq?=
 =?utf-8?B?WlFCSXMrUVRFY3NhRDE5NExxL3FhMXQ5cG1JVTFJTFUyU3FveHQ5S3l0SGRW?=
 =?utf-8?B?ZC96ZmNiVWcxZVJSMmlhd3ZQWEU4SG1adHJhTU1FZ3VUSE5jZWwwQjAwNi9Y?=
 =?utf-8?B?Z3V6QnB0WEI0Z3JCRndYWDN2TlhjYlFuVFArMDlLdkdkeXM5NXFqbVlSMDZK?=
 =?utf-8?B?dnd1SjlPbXRiM01wdGtTbzVKTVcvamU2dkVCSndDNVFCbUtpakVPQzdWY0c4?=
 =?utf-8?B?Skw0VDhGNzNMRU5aMGpYWFJONHFBZVZNU293OWpSdGxlL2kvTjNCdTlxOUY0?=
 =?utf-8?B?NlM1VHRPYlZoeEtyMVpCN2ZqZ2ZpTXFRVzBhalRpR0JqL3Z3Y0QwUTBtdFhm?=
 =?utf-8?B?ZlQzQlAxNGhtVnFkS0Rvc0ttMkNqbmlzWmw3MDkvakVsQjlCL05od0JPUFQz?=
 =?utf-8?B?aTZFdjEzNHByMWVlQjV6UHJsMTQ1SGN3bExQNjJkSkZoU1RpSnZpSXBrZmJw?=
 =?utf-8?Q?8UEUXWKN39c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB4288.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnEvSEZIRTQrUmo4UFF5Vk9ESFh5Ync1aEk5TVBCUTViaEJvck8ramJGaGpx?=
 =?utf-8?B?Wmk2VnFtaTRWVXhVUzNLWUE4QjBnVEVwMWdiRkdSYnE2azRaUVBCMlNQZUNo?=
 =?utf-8?B?cUJRN2YwSURFKy83cXN6V0IxaHduY0I2dWpGNzZtY3JDeTBMdU8yS1g4MzZC?=
 =?utf-8?B?UGRtbWQ0cVJzL3hrZjRiNnlIVzFZMDE5Wk5iTjIrK3FPT0MyQ1ZqNEd1eXgy?=
 =?utf-8?B?VSt6QkdrOXEwNnA2WFBXV0hMYUIreHRwcUdTUjF4ZUhPeWtVa2NMYmh1cnpw?=
 =?utf-8?B?VFNRb3F6R2RnR3A5MWk3T29jQzlDWGlJWlpEZ2VIalBXQVBNQ2xpaVdBN1cy?=
 =?utf-8?B?K0xkOTRFbEFIK1AwaU9BZWp3V1ptL090cmpBTlp5a2lQY2lWeE1LZDVBYXVo?=
 =?utf-8?B?Q3hTcFF1djFUU2VLMDB0K01Ba0RRcVU1M2l3blBHNlgvZFM2KytaZWEzK3NP?=
 =?utf-8?B?WjgvZWlFek5yUmZzMy9kMmtkcWFZTkdUblBvZUpQa0lsTnJ0M0JraG9VZlVy?=
 =?utf-8?B?SUhlSTdkQW90RnpkN3IvblFidnh4U2FWU0xFNWxoZHlHYXJ6U3VXWmI2RDNI?=
 =?utf-8?B?Qzc1eGZ0ZDhBNjk5VFFYRnB2UGs0SDkwMjhqN3A3OGRITytOcVlUUWw0Y0hQ?=
 =?utf-8?B?TFViOUVTRDVEMEQwVVlPb0xBN1d0cjgyUWV2dmpXTytYL1M1UlQ4Wmc0S293?=
 =?utf-8?B?Z3pGMWZhS1FWeks1b1E4aVdvWTllNjJaMG1CcHBvZUEvTXZKZm9XcFdaNlE2?=
 =?utf-8?B?Y1hGVGx1UnRlbHNkTU9ZOU1JNEFEbXRvbFhqVDV6NjZldkVyQUdFaWd3MnRR?=
 =?utf-8?B?VUo2a00zdXpsT3BXSzBtZ0xwM1NrZVhCZHJFYjlBSVRaYzhZcmdLZyt1WGVG?=
 =?utf-8?B?SWN0b3AwSXNUSkhoeTlETDFRZXYrTXo4ZjNPR0dwaEJaWk1CVmg1VXV1aktY?=
 =?utf-8?B?b0c5ZS9MSXk0SmpDcEpwRUZwTU5vTEkya0FqR3B5dWVaaFRNb3VNWlBGYzg3?=
 =?utf-8?B?YlppT0lERGdNbzJ0RGVhT1JkYmRzUGo3TGNiWmZ0YTdSa283RTJPK3kvRG5p?=
 =?utf-8?B?cjlKelI4MnZTNjloNTB1dE9yT1Z1MTk2WHpXOHJ6NXE2Q3ZiZDVxaisyU3V0?=
 =?utf-8?B?ZUlmczNEK2dZVmNhbXhlRTFZem5Zd01ZSkRaQ2FwUFRvK3ZmT2l2L05PUTVE?=
 =?utf-8?B?ZHBnWGdQalRyb2o1MmFNbzEzZUgzc2lrZlBHaUVMc29lUHlyK3hVbC9yMEdR?=
 =?utf-8?B?NWJLbmJIbHlsUGdPam83elExYnYvZGhjY2lmdzh6WVV2ZTFJOTVwMExGMlNR?=
 =?utf-8?B?YVNLYU1mUzF1dUQ0VFVGdEFYRDY5c2pDY09KSktSemNNQm11c1JiaEN1VXJ6?=
 =?utf-8?B?TE9sOHNxMm9yUk42bTl4UXoxMVRKbUpVazkxN2hVNTZ0NW1LaHplOFcvNkZG?=
 =?utf-8?B?MGxZUnlCbDV2dmZtM2wwR3I5VTB0N1JGR3E1L0RyNk5ibkxtQzdBVHhOcFFq?=
 =?utf-8?B?ajBkM1RoNVlRNHVDTUgwQWJ0RklFS0ZoODRlUC9mdVBkYks3bDdUYUFHZ1Nn?=
 =?utf-8?B?ZXE2bFpmSVFsOGJSWFhSQy9rMVBSTWRYM1pTVXV4bmV0elRZS3hDS1R3SFN3?=
 =?utf-8?B?TEVtQ29IaldJNXpZUEZianZWbnBwMUR6UGZ0VWp6bVc3LzlmUFVvUGRNODVI?=
 =?utf-8?B?bmpIcmIyUWRMcWMyZ29TVnc1RjZwcWY3d2xlU1RWQTV3NzkvVCsxa2JxbjlU?=
 =?utf-8?B?S0xPUlg3N3BZT2phcnZZWkxOMm9uRnpTZWRwdFkrQU0rQzVSbVB6Yk9YZmox?=
 =?utf-8?B?NG1iUWlubXRJVmp5T0pHNDlBRnBmdURtaGc0Q00xMURUVHBTMVZWSVNoZnJm?=
 =?utf-8?B?bHdzSGl4T2IrVFpjMjFLblNoRUZ3OUpHU0M2U3JydDRJZjhGTGlrbS80ck54?=
 =?utf-8?B?OVNUcmRrWk1TVml3TE85RjVYN2laUVc3TGNzOW1ZcS9lbG53ZktvUFp0Si9E?=
 =?utf-8?B?Q0Nkdm84RHZRM0wzZTgvS0ErT3pOVnp5eUZpV2NGR1dVOE9BWk9DN2N1WFRq?=
 =?utf-8?B?L09GRzJ1b3p0WEo1S2NMUG9MZ1phQ0Y0SFYyM2lxcE5HcHE3SzRMRUFtYUY3?=
 =?utf-8?B?clljb21tS2RoQzByU0FlaUJnaUdWS0RMN0hnSE4xZEpvN2lKZUpJcnFvY3Ji?=
 =?utf-8?Q?di+eT+myzBREjRhJND4kjuw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58206b6c-45bd-46e3-6c14-08dda7ed989c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4288.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 07:08:26.9390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rq68IRpwt6w2/LWIzZm7f4fkW4E3GTQQARtuTT0m6H6BhbazS5Ey8dkMIJS8Q4QhB62ll/AxbAMecXP3w8LTDpZ55UGvQAl5PX9e0Pahahps/K4VpermrU+4nwLtc6Bu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB8018
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

Hi Michal

I need your help to review the following patch series; please help.

On 28-May-25 4:41 PM, Ravulapalli, Naresh Kumar wrote:
> Hi Simon
> 
> On 25-May-25 11:35 PM, Simon Glass wrote:
> 
>> Hi Naresh,
>>
>> On Sat, 24 May 2025 at 21:37, Naresh Kumar Ravulapalli
>> <nareshkumar.ravulapalli@altera.com> wrote:
>>>
>>> Partial Reconfiguration (pr) FPGA command is added to U-Boot console.
>>> The "fpga pr" command supports multiple regions for partial
>>> reconfiguration by specifying the region number. The implementation
>>> of the command is specific to the underlying FPGA device.
>>>
>>> In case of Altera, it is used to freeze the specified partial
>>> reconfiguration region, then user loading the reconfiguration image
>>> followed by unfreezing of the region.
>>>
>>> Test set currently can't be added as the command is implementation
>>> specific. It involves opening of FPGA bridges and loading of external
>>> images during run time. Currently, existing FPGA commands don't
>>> have any tests/sandbox environment. The design is being worked on,
>>> but would take some more time to share and get the community
>>> feedback.
>>>
>>> Changes in v2:
>>> - Change the command implementation to generic FPGA command
>>> - Add usage documentation for the command
>>> - Correct "_" with "-" in alias name in Altera dts files
>>> - Add FPGA partial reconfiguration support for Altera devices
>>> - Address minor comments in v1
>>>
>>> Naresh Kumar Ravulapalli (5):
>>>    drivers: fpga: Add generic partial reconfiguration support
>>>    cmd: Add partial reconfiguration command
>>>    doc: usage: cmd: Add documentation for fpga pr command
>>>    arch: arm: dts: Correct alias name for Altera SoCs
>>>    drivers: fpga: Add partial reconfig support for Altera SoCs
>>>
>>>   .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |   2 +-
>>>   arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi |   3 +-
>>>   .../dts/socfpga_stratix10_socdk-u-boot.dtsi   |   3 +-
>>>   cmd/Kconfig                                   |   8 +
>>>   cmd/fpga.c                                    |  38 ++++
>>>   doc/usage/cmd/fpga.rst                        |  65 +++++++
>>>   drivers/fpga/Kconfig                          |   7 +
>>>   drivers/fpga/altera.c                         | 163 ++++++++++++++++++
>>>   drivers/fpga/fpga.c                           |  37 ++++
>>>   include/altera.h                              |   7 +
>>>   include/fpga.h                                |   3 +
>>>   11 files changed, 333 insertions(+), 3 deletions(-)
>>>   create mode 100644 doc/usage/cmd/fpga.rst
>>>
>>> -- 
>>> 2.35.3
>>>
>>
>> How about creating a uclass for FPGA, with an API? I think it would
>> help to make things more uniform.
> 
> Yes, I agree. While going through the existing FPGA commands, I also
> feel we need to refactor them for uniformity. But this patch series is 
> about adding a command with existing framework, I would like to keep 
> both tasks isolated.
> 
> I will push the refactoring work as a separate patch series.

Kind Regards
Naresh

