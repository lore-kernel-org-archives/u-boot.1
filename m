Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB37CF8861
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 14:42:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC5D083F1F;
	Thu, 20 Nov 2025 15:42:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="fGg9Zqqx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E69EC83F33; Thu, 20 Nov 2025 15:42:25 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9FA683A6A
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 15:42:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwX6dAQMhOFaj/xegEAvjCuNMgyN5H38njrTUg+y1IJ5SqUYUPMPYZqe4TpYPHJQbzHMxj9/ymINWxF3ggjnnyQjdF7vFxBGE3Xm/kTzBQEfDaKOrL4B/7MwZ65rE5TlaaPLUo3snNEwuHOM5M/vQN+P3LGWC4gwhZ13a2IBaJ/7k48S1+ui2K56VxmbMKyUCsGdiLkG58tCf/MJud0azghoG7zwDPiz6jDZPVWGRHUbo/zPKZjOzIIvrTsphI2fGnH/rNk9xLJczi4IzNkGc3ecGNHFEqXtcTd53lM4oCQnZV1VasNiklJ2L6g9UhwCzsk4kXMXgCG0emeahh8UGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cc2kEn5aQEmL3iHFF5bIspkFGF8L//p3O6aBOyx0Oc=;
 b=xalEMjMNa/bvEPKugTLINmlE8L1fMazDwMQG5RFfv2ZnOIrm92g5TgLHozKhRtEAVYrzYeZQ7Y+6d/F4Reh9DxZBgAZWHPW5ND+f1oV7H1/7BdAEdRcp2rL42tfLxMBWiOsSy/0Z0ie4GvwnWPTp1W10uMB0uCitbs/UYQx7yuhgTF/kd5b0Lb+AblNzj1fNwgNcebPEHgyk0kXSBIPlBwRWxsafkOSRsrCtLO7atgjiolWljYk3H+2YfmtZR4CcTsx9iR3iLN8MUioIEdbBag0RfTJr1EdTqJ2Mw63IvAf0NqLnCGYO6b7eMe59RjBn/An29PWKEUR27v/Jq7N/UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cc2kEn5aQEmL3iHFF5bIspkFGF8L//p3O6aBOyx0Oc=;
 b=fGg9Zqqx5AWLKGyutFY0OkzF/GpyM1f6h85Ul3Yn/c4Ijk3FdMuSrr/pSsaxTTrbXEiCuddrKXMN9v5BV0VqgF58MDXgSQtD4sW7exV0efekYHmZ5sioX6CboXelas6OSScnr7giECWeTGzkBnXWhN3u36N6I22VnliYoG6HJKG91GH+7DG+Ky+o2qd+w1mPHbKlpVEUyMZl6foW7fLhC2uWD9Jnfyjx5/wMx3ZuPsiAdps4SLXACeamclSKpsHvrE/BoqDFVVPf9vNwna6Yay496cnyPtcbAg7daUTocfsKGMl441fpTxr3PMDXs8dDw5JTVrdcLxz4QrolJAwLEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MW4PR03MB6459.namprd03.prod.outlook.com (2603:10b6:303:122::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 14:42:20 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 14:42:20 +0000
Message-ID: <e48238cb-9cf4-4e4c-9a47-63e80c77c822@altera.com>
Date: Thu, 20 Nov 2025 20:12:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] mmc: sdhci-cadence6: socfpga: Fix DT property naming
 convention
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com,
 balsundar.ponnusamy@altera.com
References: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
 <20251110173737.24545-8-tanmay.kathpalia@altera.com>
 <aRwQqNaCcn6f9-Cg@nxa18884-linux>
Content-Language: en-US
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
In-Reply-To: <aRwQqNaCcn6f9-Cg@nxa18884-linux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0246.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::13) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|MW4PR03MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c83c07a-290c-4b69-9daa-08de2843026c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vmk3Nmp4RTE1MEhYdmxubVk5My9yMFpYYUZYNjFXYTdCZzIrQ1k2dGdndnNT?=
 =?utf-8?B?dW5tYjkzM2g4UGhkRkNBUTZzSHJNU1VKTTFxWjIyV3FuSC9iTGFwTjQyUjBJ?=
 =?utf-8?B?elJDRTZkN2xJUU5oTitsbU5ENVNVbTlJdFZFbVRyMW1XbDBFNkx6cis3b1BR?=
 =?utf-8?B?NkJQY2JBYUZBL3FsRVNMK29wTTJIekxuOXY2UWNWM1VjQVV4emYvcmV3Zy9m?=
 =?utf-8?B?bUFsOG1TWTBjZnhSUm1BZGV3Y3RJelhrSE1lQmZEZytoWDZMWnVKS2FpdjI1?=
 =?utf-8?B?L0swNkNMQWZwZW9OSHREaDllVzVMajFSdktsQ2RXY0lFNUxrMEJsZGxVYWhr?=
 =?utf-8?B?dTRYZUFhc3NyaVNFdUUrcWx3REpPZmlTT3F0RURTWTFvaWtiejByT1VGY1Vh?=
 =?utf-8?B?MjBpdHBwdXBmMXZad1lYZXJPYmlKUXNmajAvb1hBcTErOXo0QmhLZE9vdnc1?=
 =?utf-8?B?czl3UzJCamEvbGdJdm8wL00rT2dzOVIyVWN0aElhaFlBTXVGOEp1NEsyc0sz?=
 =?utf-8?B?cVFqYStrUXpqaFIyWXl2NDNQVDdkcDFLK3FwTnZKaGg1Y1h1a21KS3JaekxL?=
 =?utf-8?B?bU9VSDZDR2prS3ExM09JMmJidFJhQkNpZnE4NjR1RTVZanIvUFo4WHRZVlha?=
 =?utf-8?B?c2w3YUtQUHVOQnlSVHRzMzBaY2RJN0RScnlVeVVUNGpHenZOWmczVXFVM0tL?=
 =?utf-8?B?c2xmd1RpbWhqOVhqVytlcE9OcnZzTTZzWThTZ3laN2tOc0VLV3JBODhKV0Vu?=
 =?utf-8?B?U3M4R3lKaGhDSEVoc0llVTVzWHZDclNaWU5iNTZuMHZYYWhBWnZuemp4YVQv?=
 =?utf-8?B?ZnBWa0JONkQvUGx1a2J1OXd3c2tvYXVMVVlCSDlGNUhwR1J0NkQzN0tpMDh6?=
 =?utf-8?B?eFlvQkVSRWh1aTIwc0FpdFozbUdaTFVSS0x5aVZTSWpralFSeE1CL05lYllo?=
 =?utf-8?B?VWkvc3pOMmx3RjBvNXlXNzBwVFJ4U2tQZG1VVm1OZFYyeDdlK0RGV2s3UDFJ?=
 =?utf-8?B?TG9hQlhEMytLT1N3SjQwYmo3eWNoSHkyRkFud2N5RHkzb3p3SDZibENmUkxV?=
 =?utf-8?B?TlZ4dmQ2bkgyRzQrK0FNajdVZXBFdStPOU56MGZ2M1hhb2VnMW03ZXBQMno5?=
 =?utf-8?B?NktBMjNoV2VVY053dkRIbFcwcGw2Y0hMSnRyQ3VxOVhUYmF4Uno4ZXZyb3h3?=
 =?utf-8?B?UjBjenQrMzJhUEo4anVnMVVUeVQrNDJESXVuMXRQZU9acnJZQWRvSmVzQWgw?=
 =?utf-8?B?RWtBd3NMUFp4TTBYT3JSRHZaMks5SG1UbGx6YVV1amZLaDhYWitMYnNTZE11?=
 =?utf-8?B?bTFFZDIyODdaYzBtNVNaanVxbStXRHJYeFNpeG1aNHlrbDBjWS9PNVE1TnBR?=
 =?utf-8?B?MENUK05jSWZGWktTOC9KWUVmNXlJeXQ0WHQxUEFZM0hnVkdaQTZmVEp0QzlT?=
 =?utf-8?B?dnZWeUU4OXdlQnkwMG4wczFheW42ZXJmYVlpZnVVeE5NYkFnUTNOWVc0dE1N?=
 =?utf-8?B?eHdRUTB1MmFXVDJHa05Bb1NIblNpdW5QT0MyWURmSXY5MkQrNkorVW5CQzFh?=
 =?utf-8?B?Y1I5cE5yY0FsYVlTS0dtQTNyWW9TcG9VdFgrNmMwZ0xXdnd4alpLL1FkS0lr?=
 =?utf-8?B?WDQrd2F1Zy9iUkQ4akkrRnU1R1dXT3B5YlJlUHZsZ3Y4cUJwbm0rN2IrdUpN?=
 =?utf-8?B?bUk4WU8yNks1bDEzZFNKT2pLanZOV3hlOHZPRE9uUzhJOEJCU05rdXo4cXpp?=
 =?utf-8?B?WmpVMjZaRllLNCtEdEdZS2lYNlp0Qkd1bys0VHpPSDNrMlJjNEo5dm12SDFt?=
 =?utf-8?B?Wk9kUmJ3L1VETTJOSE8rT0NhMGJCNVFaL004b0FyaHdPbHZrZld3cFFmRy9t?=
 =?utf-8?B?YUFWdWVjS1RieUZpdFpmTXY2YkJqZkM0ek9aSldsVUFXWXhyRW90dU05UCtN?=
 =?utf-8?Q?0GiWAcxpfGftHHQIJtO6FOf5/HxfYRnU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTdQbW5Ka242WkNrVHBENUJHREVuRmZaZkdmdGlxd2owVzBtRnM2dG13elpj?=
 =?utf-8?B?VnNvT0htNWpiNFhCV2ZFZnh4UDFKa1BadGprTHVUQ3VnSkk0alhYZG1na2tj?=
 =?utf-8?B?bDBSZHZUSURNRmFyb21EVFF2RFowT0RFcVZ0M3diZlNZVjVnNHQ0RHFQd25x?=
 =?utf-8?B?Wm9iazNqZHZBN2kxRzZ6OE1tcyt4NGZUMURNM0FNRU5jUjhQd1g2Ny8vZUdE?=
 =?utf-8?B?eXZ5L0xRc0N5WERORmVBMklJdnQyRVhBV1RyZ2pKVzdrMlUvVzRzUzRUVlpn?=
 =?utf-8?B?bjR2TFZ0cCt2cE5ZcGFTcDVWRm9yUkxlZ0JxSmYyM2pvQ2pNTWpNR0tCUVly?=
 =?utf-8?B?UmJOc1hIL2llWllRZ3grb3ZrWDVsSEVEZ3FJZFVHLzBVNFJiQzRyZ2ZoT09N?=
 =?utf-8?B?dER6Wm96dllFRTJpMXhVQVd6SnpJLzN6YkVSd0ZCZGFEald6R1RyYnNVdXZH?=
 =?utf-8?B?ZHR0Z3lodHNOZyswM251SC8wTmd0dHNSa3lud094dlRFTllOdmQ1SnB3dVdq?=
 =?utf-8?B?ZmpFaGgxVVN4MjNPbStRbjVTdXNTTWdrdGdhanpPWk1ML0pkRGxyR0g2aTMy?=
 =?utf-8?B?N2J5K1htdWtITTFTemF3VlZkQVkwNEJRY2ovVXp5VWJDYWxxSXluOFo4amZt?=
 =?utf-8?B?Qnk0RVV5Y0RJL1k5QmxQeTdUSTMvNmxkZlJENkt6SGtJOVUzendGOWtoQUxw?=
 =?utf-8?B?VHl0RFVacm5HWEp4dWtkc202b1k2cXBmTlNLVVdVNTRkOEdBZkZjZURsbDdv?=
 =?utf-8?B?aU0yWE9JYVk5ZzV0d2xza2czbmUrUDR1M1RFWFJjMktBeHFMaUdHbmRZckZK?=
 =?utf-8?B?Zk1vdUwwWUhxcEpiWmZCUlZsTkRza0FCY3Y1Q2dHQkwySHZuMnZYc2k4ZUVk?=
 =?utf-8?B?cGpLVGtLNkNRd2plV3kvNXRmRWROWjh3M0ZnLzNMTS9kUTUxOHd6U1Z4SDZO?=
 =?utf-8?B?SisrNlQ2T0xWK0xZeE5QT2N3UXAyMlJkcjFaZUN2RE5oMVZ3V29EUVF5OHdB?=
 =?utf-8?B?eGJFbmlZbHAwb0RWeUlVYnZoVmYrQk0yNHZtYXgzQ0lOQ0g4SS9UdTBPL0tG?=
 =?utf-8?B?Mng2dFBRbExaUzhKaCtHM0E1RWVacSthNWVoalF0M29takR1Qk9WM1FoSUsz?=
 =?utf-8?B?bWlnSzhxT01BejNBOHFxTkJFcmo0S2prdUIzamJJVFE0WUtGbXR1aEVCdU9y?=
 =?utf-8?B?UDlNU2dzU2dEWDBzT0FVVHZLUGVxa1c4OUFJVlE5eDh3WmpvMmJTblNZK0k4?=
 =?utf-8?B?YlJwWUM3WXhNS2NtREM2ZG5nOUdSVmFVYzVQWmF4VGFhYTV5bXJJWktlekU3?=
 =?utf-8?B?YVV4QkhDQ0lBd1BTaXYwSkFKZGZWc1M5TVEyWUFpWUV0b0RrV1Z3c1FrNGVn?=
 =?utf-8?B?MjhSUzNzTnZvZlN2ZXRnaFpxWGFyM2ZFRXo1NjJsSUFhUkFpcjNDYk5SRjQ0?=
 =?utf-8?B?Z09ZWThWaHQ0amMwam1yRTB2d3Vtd1lpNmZoMkZjYndneFgrSlduQ2lrWjNu?=
 =?utf-8?B?SmtyUkRDMG1kMHU2OG9wMVRiRE94dHVOeU5UQmtOYXVaMFFCNXp6T0QxTUUw?=
 =?utf-8?B?SjhhTUlINFhhelYvTUlnVDF4bEJDMkd4TDE0SVNvSS9jU1UrcHUrWEpEYUV3?=
 =?utf-8?B?bS9tYzBXcDRCVlNqdFMyWTd1aXpOOUNvdVprUTFhaFNPQ0ZOdG0rNWFzaGt5?=
 =?utf-8?B?KzJTSFBQWVpubDl0QXQ4eXlMZmpFNk5ScGZxTExaTDVOUGdpd2FDdDVGQncz?=
 =?utf-8?B?eVJXb3lKRkk4TExJSHo2SEdTNHAvY254V2dxeVA4NXNjajlzaFJ1MDdxaHhK?=
 =?utf-8?B?Y0Z6bGp3TG5VdmlONC9zTy9IQktKQUpFQ0IvcFZjeHRBVnQ0RXloMWNqUUF5?=
 =?utf-8?B?SW1hWHkyMjAvVjFoNXBJaDhtUXFZMHhUMTJBM0NlSnlXNmlBOU1PZVlZZVNT?=
 =?utf-8?B?SHdUeTk0Z0pGS1Qxa2NFN3VOK3pzajQzQXhPaHRqcldtTXRkWjY1NEt2WUNU?=
 =?utf-8?B?SEhJUG5FbHNnQnh6ZHVHYVJqbytHcTJlWXgrdmlhUFA2TS9kRHI3MEY1dEM3?=
 =?utf-8?B?bmFjTVRqdzEvTWlVYndja1BMRGs2dGZlek9DQzNwYS9QVk9FWExDV2o5dnBm?=
 =?utf-8?B?MFV1RXltS0RmeXZ2b25BZkdqZm0vQ0MzS0tSMk1aZnFmaTlkdHBaY2w3ZzVK?=
 =?utf-8?B?L1E9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c83c07a-290c-4b69-9daa-08de2843026c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 14:42:20.5591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5vppwp60mjaubrP1EZEi7VB0/BDWV4nKUHR4u19lGAABAhASpJd1QY92NVGC0F9YUN1ni1rVUQ5d3SRYNuFQlxIg71HROFPz7ByM+3mTMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6459
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



On 11/18/2025 11:52 AM, Peng Fan wrote:
> On Mon, Nov 10, 2025 at 09:37:36AM -0800, Tanmay Kathpalia wrote:
>> 1. Replace underscores with hyphens in device tree property names to
>> follow the standard DT naming convention. This affects all
>> "lpbk_ctrl" properties which are now correctly named "lpbk-ctrl".
> 
> Are these properties in Linux Upstream tree?
> 

No, the Linux upstream tree does not have the Cadence version 6 host 
controller driver, so these properties are not present in Linux.

> I not see users in arch/arm/dts and dts/upstream for the properties.
> 

Currently, there are no users for the Cadence version 6 host controller 
IP. However, we have enabled it in our local repository for our 
platform. Once these changes are merged, I plan to submit the enablement 
patches.

> Regards
> Peng

