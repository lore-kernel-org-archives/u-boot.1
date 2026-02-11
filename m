Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC7FEB597B
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 08:39:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F6678367F;
	Wed, 11 Feb 2026 09:39:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kt14EtKW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4BA183E4C; Wed, 11 Feb 2026 09:39:29 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55A89802C1
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 09:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZQ601/49aUxlf7jZSoecNPa2sK2W043xf2y/qMUhHW4goeuQAg31fiLLtIpMWr/fWHbPnILLcvIq5TE6TQNxpYvku4gCWHGVnXto5OY0C+jW09ybyY/rOdAAJmcz+NkEg8qTgcNUFbHde9oF+SBFziVXmUUiLgpN6jO8VSRKt80xxsy/e17wVeiHXlw9BTt/N70reb+AouLQci/WJu37B28Izfd0OhQi9wN8JP9MJFXnfzxlDRC2K1iKktMz9EGmuMQwDQangGJoSnCceY4fiurPEWtRYf/0op7rMAWr6+U2a2NICr9riNf7eBBKooRaOzZssbzHJ+4LslkdSfNmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9N3LHN3cUhkpMxpMaACewVHlmDM22cCZIN1vSiRdOs=;
 b=vccJQw8/T6hdLmciAbP77fekjC0PfE4PDjENmu7Naes4otMVDP/u55krEpfaixU9guTCqlAXh22zoWlDOCwMlyojnvtp79A8faS0p3CbMfZBwx9jLmUyVMf+TL8ONJ7umnpcjapSacju95zQ39DGBLr7wEixADlx5dx3qsGbIlBcg6YejmJj3leYKyTjKoBk42x7NNxnGAMeVarS+BWPBgJ5ojPnMLSF43xYXK9+Fr8p8vaP/ZLU1TyJriTtZy6JP2+W+LrEnIBw5EIGvsGvH5v+dSQsNFzqRNadQrXFC4x08BscGME4Iteq8TiScyR/VxM+qw+NH5hyZfS+0aOqtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9N3LHN3cUhkpMxpMaACewVHlmDM22cCZIN1vSiRdOs=;
 b=Kt14EtKWcGxOIPT/P4uvnznxkb4Wg2EU8CHZsch6uWuYekjgNC/WXlrDi8OJNSlzXjtmAVLaCxiVtizyPeg+LUi9QMyYlZzilS5vdv1+tqd5W3zawLnNUFh/DUyKBT6D75iRGJF32tslEZ9oCOxyT+sRgIjBB5hi+w3IKPhzzBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 08:39:23 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9587.016; Wed, 11 Feb 2026
 08:39:23 +0000
Message-ID: <236eab94-717f-4622-8cbf-a337943444a9@amd.com>
Date: Wed, 11 Feb 2026 09:39:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pinctrl: zynqmp: Add SPL support
To: Sean Anderson <sean.anderson@linux.dev>, u-boot@lists.denx.de
References: <20260129184011.3932790-1-sean.anderson@linux.dev>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260129184011.3932790-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIZP296CA0025.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::15) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a9a7694-d669-4057-26c1-08de69490e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUZXT3hLam42NFQ5WTV0cGFRVldySHdLMlpOemtVd254TGxUTWpFRzRtdEs2?=
 =?utf-8?B?RmNCQ1Nud1lVa0pXdzBFNVZuZmc1NUlhVlkxaVV5VHZZTDQyRWhHdVhFRnlz?=
 =?utf-8?B?eHZNdFlLRlhOS0gvMFZKT2dONUxTa2l0S21oRldYN0NqNVdCQkFiS21mekJR?=
 =?utf-8?B?bVQ4Vm9LOWNtdlJnZkIyVFh5UmJjUFpjWGJNbWRhMjlRMUp1eG9YV3ZJN01q?=
 =?utf-8?B?Q2ZzSmoxNjFzTmQ0ZVMyaFlJQTRmNDI2ZllYOHQ3Y1JNZkdvL3ZZR2kxeUhX?=
 =?utf-8?B?SzB1M2NBSnlyOWo5cnQ0NjRxWHNvYTk0OW1uN3dvY2Ywb21Scm9QdVZFTTRh?=
 =?utf-8?B?amZmUkFyQ3FSNVB4dTk1NTBpT3FTcHhuRFZJbFJwdFB6MUczWHRyNHZrTU5s?=
 =?utf-8?B?UStnZDI5V2RVQUIxNHZuMDVRaWU5UWIrNEFjTW5vRGZsaEtyUkRERWtiNDNr?=
 =?utf-8?B?dDQzamw2UUhkbE91dWZGOVJBcHg1RmsrMUF5Z2VuSW10VnRqRlpmaEd1cmJG?=
 =?utf-8?B?QlA5QUVDaUtwc09WamxCbDJUL1JONTRyTG5tT0UzOTAvT3ZzMVM1ZC9rZytY?=
 =?utf-8?B?ODRycUEreEd4RUpQbGVySVV2SHBCOEczYlh0NXBQaExuM1BxVHczRUxMNEdG?=
 =?utf-8?B?TUNVeFdtQ252ZkMwc2VtZWVoekJmNXM1Qy9pZGVuQmJrOHJ1bElPUE9lUjkv?=
 =?utf-8?B?ZDZnaDdnVHFqdEwyRDhOcnRMT3l1bnVXbzVxeHZzSjlpK09LaHhpY3JpZXQ1?=
 =?utf-8?B?cENmYVVJUUNvMFYxRUU2OGVVNEpCanhhdi8xNFhRb053dkk0eEg2dVFoL2R0?=
 =?utf-8?B?OUtIMHdEYUx1dHg5TVlsczZEUkM2K1lsZHFTTWRuR21oMU9LSUlDUFdXczFR?=
 =?utf-8?B?OUIxSUEwNUpoUUVlSDQ1YzE2S2Npbng2b1kzM0pWK0g3dmdZek9nTitUN21v?=
 =?utf-8?B?MTVaaERuN0xWOWFNOXZUZFJ3Ti9LYUcreHIzU0RrLy9LOHVEdmJ1WmVqZ2hS?=
 =?utf-8?B?WENYN2QvcXBobVVmSXFnWmtMditpMW5PY2ZxdTRHL2xWaU1nNFFJTWhsZ3ZP?=
 =?utf-8?B?WnVwNVFRZ1ZPT3FDYldKUlJKYUt5ejlOK0kyZE83Z0cxZFFyaWRUVFJoNUdu?=
 =?utf-8?B?TDNmeVhzV05SdERwZ1g5b08xZWZpN3RLejUvMElCVDRsM2cxVS9LVTBaQkR5?=
 =?utf-8?B?ek1jM1dQbUxtMXp6eEpSWFg2QWlXR1RyYUdwbWZUNkxqQWl3SkJ3OHZmU0dF?=
 =?utf-8?B?MkhFMEpPQ2QwT2ZmRVhvM1o4S3IrU2tUTndLa0ZVTmFJNGMwckpGTWpvMU11?=
 =?utf-8?B?MlVqK1FhTnF3MVNkc1RUUGVmZ084bXlIZkpxVmx0N2NoaEc2L1EzTTliTTVm?=
 =?utf-8?B?SXpmWnBYcldXYTYydjJoM1pYWWZDYzhQSzdrcFZMckV6RnA5SVZQZnpkSlNQ?=
 =?utf-8?B?T0VIa2RNZXhsbDJMclNmcXdBYVRUQm4zaldYZ1lnZnczWGM1dWZYUkZBSmtz?=
 =?utf-8?B?MytnbHdMOStKWjNvSUZHOGtNcTVrdnhBWm5GTGVBR0xRV2tMTkkxd0tSZ292?=
 =?utf-8?B?SXJEOUpDRmQxVEJIOHBRUk5FZXkxYWNmbFpDQzQyWGw0alhxdDFLVk9qcUV6?=
 =?utf-8?B?dnZ5TnhCaEZkVnlpSkRnTEVGVUtUcU1YRHAwNjJtTHE5c1BaTjF6bVdKaS95?=
 =?utf-8?B?bFZtMVFUMGU4dG93V2tyTC9qbzJaOUh1QUduNVlpZkRURTNEQlZlaG9GSUJk?=
 =?utf-8?B?ZENNd1JGMldZMWl6ZG01d0RmclhCVCtFd3RPMGUyOGlheUJDNDVJT2NNWHZG?=
 =?utf-8?B?MjZSM3BKYmpPYjUzTmxQaVVsVkMwRlFPQ0tDMUJwTnJBNmZyeFhkUzhJRlF2?=
 =?utf-8?B?a1J3eTZiR1dVcmZPMWJubUtmMkd0eWlRWWRZL3pHbE1YaWFFcmhWN242WS9p?=
 =?utf-8?B?NER1ZmJ1R0ZqaFFHVlRHNUJVSXdLOFVTdDFwd3lybm12eEZMaVFKWk1kVnhU?=
 =?utf-8?B?SXRiUE9JQ1h0aWFUMndsVC9hY1BnQllEMHFOQ0ltVTZrSXVXU3Z3T1lDYXhr?=
 =?utf-8?B?S3ZqNWNWMEl5VVphTURWMWNCZXRYbU1jZmJJUEtMN1l2UEJsemg5NGtXMngw?=
 =?utf-8?Q?RPfs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkRsQVNXMnZyRU03Z2JkZldFTHBYYUdaeEFmeC83M2JETEdCM1dYbktMZ3Bm?=
 =?utf-8?B?ODVldFJMUWhkOEVvR043QlVySkh6WTV0UHpDaE5SWHdnYSt5cnJGRHBabjJk?=
 =?utf-8?B?TWQyL3Myd21lQkkyRlRuT0IxbjFpZTZ3WjdabHIxYXVQRmZOQ1gvT3VrVStp?=
 =?utf-8?B?TGhMWThiZmNhK1lHR0dGUkZ0empkZzNGd1RjdzhiM3pRWlZDMlNvekw3L2d0?=
 =?utf-8?B?dG5mWWx1Y3pEb1VtazBuUlhyUTBZSXRFN215ZC9lUlc3UGJtdFBBdENkU2Zk?=
 =?utf-8?B?M2FtM0k3R1FpQlh6bVRWNDNjQmxhWm5FQ0kxNm9tblltMkxQaEJjMCtGR1p6?=
 =?utf-8?B?R096VnZBV29tM0U0L3pGTXVWTHpSNCs0ZVhBVnFrUnZpelQvYUp2NVFIS2lX?=
 =?utf-8?B?eUZ1dlRsMlhCVTVadzcyNzY5RU1KL3dzZUdhUS9kNjJ0blMrUUlGT0lRUzNU?=
 =?utf-8?B?K0FSTkZvZlF0MDYxZUY0UHhYUWtUNnJXOVpzRTBPYjVrSWkzM0VKcm1sU1hv?=
 =?utf-8?B?cHF0YUY4b2FkaFFRaGFzSUlCUVNYOWZlekg2bHVlWVo4eXpCWDFSRE91ekJO?=
 =?utf-8?B?SWxuYmpMd0tUK3dHSzJmNlo0TWJ4TlpxZVhzb1FnUUVUVTVvaGFtbElxcGRJ?=
 =?utf-8?B?ZFVuRGRBOEd3L3Y3eUV3L3EzTW5rYkpUMVI1cGV0TFNwL2JSZzZ3TU9qellL?=
 =?utf-8?B?TkdxUzRuQnVSTXREYkFCK1FIcHBlbDhVZW13UUZLYXM5NEtxOElrMkhCL1g0?=
 =?utf-8?B?U2xNYmhTQjhub0plUGlPN3BHYy9EMTVQWVhnYkxSd05KSTljZXA5d0JPQURz?=
 =?utf-8?B?dUo3SUorZTIwSC92dVk1TnFtTXhmY2ZvbEhac2U3Z0hBa1ZPMksvc3l5YnBH?=
 =?utf-8?B?RUcvLzQvWGhWZzh3N2xNdlBWbE1UbEt6NjBiNjlKcHc0OHFKd2FGVVFXVTFn?=
 =?utf-8?B?TFYzclVMVHI1d2FWMTEyeEFHVDlaMXJIZk5oQ29EUGprOW1YNXNaT1BhVkN5?=
 =?utf-8?B?QTVma0NlVUpmblA1ZllnUUpsaVZqZVp1L2xHZW9RdEhiRWpmMDltRDVvYnA5?=
 =?utf-8?B?TmFrZnRUWHhzNHhYV2ZFb1B3cHRZZDU0aW4wV0RQS2xTcDdkcWpHcVhoZWti?=
 =?utf-8?B?bk43SU5aQzYvM09PZ0llVnJKVDRSU2FQV2V0Z2FqbitacldqTXdxb2ZHcG0w?=
 =?utf-8?B?dG1vU2dSbHZnQUx2RktITnJHSFBjc29XQXZRNm1hbmU5ejBvMXdPU2srbEZH?=
 =?utf-8?B?ZUNNd1czajZCL3hRSTdoN1FHUlYvUWdvYUlHY1ZlRTNRN2c4Y0cwMnFKU203?=
 =?utf-8?B?bW4vK3FCK29zNlZwRzZUaWtCSlR5ekpKeFJpQzdpajRMaHJmMVBZNzVLcmNa?=
 =?utf-8?B?c0JYZkdleFJzc2xadDZ5SEVFT1RMdlYzTkhlbWh6ckU5cTEwWmxmWFFBODFD?=
 =?utf-8?B?RHh6OWVyaHcwbGFHbHBHZWt6bnFLNGMyWFhqLzZlWVhPeTdCNG5OZzJEN1ph?=
 =?utf-8?B?bEhyR0M2UWlGamFyeTdnSGJYdXNjL2JJNzNJZ05FeldHZkNWQmxYTVRGck9i?=
 =?utf-8?B?OFFZakwzVmIyTXp2QzhmdjY3RkxHOTcxZ2NMLzhWUGpPRFNpNS84a2w4ekpL?=
 =?utf-8?B?YjdGSnlrdFZtSjQ4N21HN1piQThtTS9iT01hMXBTK3lmU1lobm0xbmJBbmVK?=
 =?utf-8?B?b2lPcEVnQkZjNkV4ampDN1J1cnhGRUhlY2JPdnNxYVpESmFsS0Nmc3czNDhU?=
 =?utf-8?B?eW1CQVIxUEhpdXh0STJmbWxNUVdZTUJmZ0Z6bThZTHlUdFFpL2JjRXBYSWh2?=
 =?utf-8?B?cWo4V3FvT0liYnhnRktacTFSMDBhRFhuUllnL0M1anlJbE1OaHhEODdXbENx?=
 =?utf-8?B?ajdrT2ZlN0JyTnFjWnNNcklzTWs3YXE1MWViK3JXQXUzakpBVXQ2Zjd4dCtl?=
 =?utf-8?B?VU1xd1VqWElMOTZSajJSbVBoMXQwcXNMVGxiVVErTUtqcmpDMmkyK0p1RWdE?=
 =?utf-8?B?UERMeXpHZHhybkJUWjM1Sk1ybnJlRjNqejdjRWVkM1p5OGJjRmRyTTVoOUlH?=
 =?utf-8?B?ajdINlZmRVRCWExVa1F1UnBLVlRWaStkbzFoN296NEFBcG16cVdveWExWjg0?=
 =?utf-8?B?MzVIKzZ0QnovRkd0YjAzeEd0YVY2VkZlSm16UDJHTHJkU1d3c2NadGVscFR0?=
 =?utf-8?B?NkFoWkxtUk9seUlKNmRza1pVS3NOcFBFSWVWYUdheCtlSy9rWW45SDF4bmtY?=
 =?utf-8?B?M2laY1U0dWNBN01vUDd3RDJFdTBqVFFmZHRxRGVkdHBmZTkraEpiSHhNYklm?=
 =?utf-8?B?MkwvMkY4Y1ZVaWlDazNsM3NRYzF2cTNyTGV3ejh6QUFndXFpZTZkQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9a7694-d669-4057-26c1-08de69490e5e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 08:39:23.3713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DxLb//LRXXQ0cxTVU+mv3mtUGUjwi5tG2OiYkp/4H7LnDjfj9y+1xQuzP1/PEaRD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364
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



On 1/29/26 19:40, Sean Anderson wrote:
> Although the pinctrl pm requests are implemented in the PMU firmware,
> PM_QUERY_DATA is actually implemented in ATF. In SPL (or when running in
> EL3), ATF is not yet running, so we need to implement this API
> ourselves. Do the bare minimum, allowing SPL to enumerate functions, but
> don't bother with groups. Groups take up a lot of space, and can be
> emulated with pins. For example, a node like
> 
> 	display-port {
> 		mux {
> 			groups = "dpaux0_1";
> 			function = "dpaux0";
> 		};
> 	};
> 
> can be replaced by
> 
> 	display-port {
> 		mux {
> 			pins = "MIO34", "MIO35", "MIO36", "MIO37";
> 			function = "dpaux0";
> 		};
> 	};
> 
> While this isn't backwards-compatible with existing devicetrees, it's
> more than enough for SPL where we may only need to mux one or two pins.
> 
> Add SPL_PINCTRL_ZYNQMP to ensure there's no SPL size growth when pinctrl
> is enabled in U-Boot but isn't necessary for SPL. The only config this
> would affect is Kria, but SPL_PINCTRL_GENERIC is disabled so
> SPL_PINCTRL_ZYNQMP is not selected.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
> Changes in v2:
> - Move some defines into zynqmp_firmware.h so they can be reused
> - Calculate a few more constants instead of using literals
> - Add SPL_PINCTRL_ZYNQMP to avoid size growth in SPL
> 
>   drivers/firmware/firmware-zynqmp.c | 101 +++++++++++++++++++++++++++++
>   drivers/pinctrl/Kconfig            |   8 +++
>   drivers/pinctrl/Makefile           |   2 +-
>   drivers/pinctrl/pinctrl-zynqmp.c   |   8 +--
>   include/zynqmp_firmware.h          |   5 ++
>   5 files changed, 117 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
> index f8a9945c1da..fb583580ebe 100644
> --- a/drivers/firmware/firmware-zynqmp.c
> +++ b/drivers/firmware/firmware-zynqmp.c
> @@ -427,6 +427,104 @@ U_BOOT_DRIVER(zynqmp_power) = {
>   };
>   #endif
>   
> +static const char *const pinctrl_functions[] = {
> +	"can0",
> +	"can1",
> +	"ethernet0",
> +	"ethernet1",
> +	"ethernet2",
> +	"ethernet3",
> +	"gemtsu0",
> +	"gpio0",
> +	"i2c0",
> +	"i2c1",
> +	"mdio0",
> +	"mdio1",
> +	"mdio2",
> +	"mdio3",
> +	"qspi0",
> +	"qspi_fbclk",
> +	"qspi_ss",
> +	"spi0",
> +	"spi1",
> +	"spi0_ss",
> +	"spi1_ss",
> +	"sdio0",
> +	"sdio0_pc",
> +	"sdio0_cd",
> +	"sdio0_wp",
> +	"sdio1",
> +	"sdio1_pc",
> +	"sdio1_cd",
> +	"sdio1_wp",
> +	"nand0",
> +	"nand0_ce",
> +	"nand0_rb",
> +	"nand0_dqs",
> +	"ttc0_clk",
> +	"ttc0_wav",
> +	"ttc1_clk",
> +	"ttc1_wav",
> +	"ttc2_clk",
> +	"ttc2_wav",
> +	"ttc3_clk",
> +	"ttc3_wav",
> +	"uart0",
> +	"uart1",
> +	"usb0",
> +	"usb1",
> +	"swdt0_clk",
> +	"swdt0_rst",
> +	"swdt1_clk",
> +	"swdt1_rst",
> +	"pmu0",
> +	"pcie0",
> +	"csu0",
> +	"dpaux0",
> +	"pjtag0",
> +	"trace0",
> +	"trace0_clk",
> +	"testscan0",
> +};
> +
> +/*
> + * PM_QUERY_DATA is implemented by ATF and not the PMU firmware, so we have to
> + * emulate it in SPL. Just implement functions/pins since the groups take up a
> + * lot of rodata and are mostly superfluous.
> + */
> +static int zynqmp_pm_query_data(enum pm_query_id qid, u32 arg1, u32 arg2,
> +				u32 *ret_payload)
> +{
> +	switch (qid) {
> +	case PM_QID_PINCTRL_GET_NUM_PINS:
> +		ret_payload[1] = 78; /* NUM_PINS */
> +		ret_payload[0] = 0;
> +		return 0;
> +	case PM_QID_PINCTRL_GET_NUM_FUNCTIONS:
> +		ret_payload[1] = ARRAY_SIZE(pinctrl_functions);
> +		ret_payload[0] = 0;
> +		return 0;
> +	case PM_QID_PINCTRL_GET_NUM_FUNCTION_GROUPS:
> +		ret_payload[1] = 0;
> +		ret_payload[0] = 0;
> +		return 0;
> +	case PM_QID_PINCTRL_GET_FUNCTION_NAME:
> +		assert(arg1 < ARRAY_SIZE(pinctrl_functions));
> +		memset(ret_payload, 0, MAX_FUNC_NAME_LEN);
> +		strcpy((char *)ret_payload, pinctrl_functions[arg1]);
> +		return 0;
> +	case PM_QID_PINCTRL_GET_FUNCTION_GROUPS:
> +	case PM_QID_PINCTRL_GET_PIN_GROUPS:
> +		memset(ret_payload + 1, 0xff,
> +		       sizeof(s16) * NUM_GROUPS_PER_RESP);
> +		ret_payload[0] = 0;
> +		return 0;
> +	default:
> +		ret_payload[0] = 1;
> +		return 1;
> +	}
> +}
> +
>   smc_call_handler_t __data smc_call_handler;
>   
>   static int smc_call_legacy(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
> @@ -493,6 +591,9 @@ int __maybe_unused xilinx_pm_request(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
>   	      __func__, current_el(), api_id, arg0, arg1, arg2, arg3, arg4, arg5);
>   
>   	if (IS_ENABLED(CONFIG_XPL_BUILD) || current_el() == 3) {
> +		if (CONFIG_IS_ENABLED(PINCTRL_ZYNQMP) &&
> +		    api_id == PM_QUERY_DATA)
> +			return zynqmp_pm_query_data(arg0, arg1, arg2, ret_payload);
>   #if defined(CONFIG_ZYNQMP_IPI)
>   		/*
>   		 * Use fixed payload and arg size as the EL2 call. The firmware
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index 48119694031..06f3dce99b3 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -385,6 +385,14 @@ config PINCTRL_ZYNQMP
>   	  Generic Pinctrl framework and is compatible with the Linux driver,
>   	  i.e. it uses the same device tree configuration.
>   
> +config SPL_PINCTRL_ZYNQMP
> +	bool "Xilinx ZynqMP pin control driver in SPL"
> +	depends on SPL_DM && SPL_PINCTRL_GENERIC && ARCH_ZYNQMP
> +	default PINCTRL_ZYNQMP
> +	help
> +	  Support pin multiplexing control in SPL on Xilinx ZynqMP. Only "pins"
> +	  can be muxed; "groups" are not supported.
> +
>   endif
>   
>   source "drivers/pinctrl/broadcom/Kconfig"
> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> index 33ff7b95ef2..4fb6cef3113 100644
> --- a/drivers/pinctrl/Makefile
> +++ b/drivers/pinctrl/Makefile
> @@ -36,5 +36,5 @@ obj-$(CONFIG_$(PHASE_)PINCTRL_SX150X) += pinctrl-sx150x.o
>   obj-$(CONFIG_$(PHASE_)PINCTRL_STMFX)	+= pinctrl-stmfx.o
>   obj-$(CONFIG_PINCTRL_TH1520)	+= pinctrl-th1520.o
>   obj-y				+= broadcom/
> -obj-$(CONFIG_PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
> +obj-$(CONFIG_$(PHASE_)PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
>   obj-$(CONFIG_PINCTRL_STARFIVE)	+= starfive/
> diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zynqmp.c
> index 7c11ac4c8b8..0b936684f8a 100644
> --- a/drivers/pinctrl/pinctrl-zynqmp.c
> +++ b/drivers/pinctrl/pinctrl-zynqmp.c
> @@ -19,15 +19,11 @@
>   #include <linux/compat.h>
>   #include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
>   
> -#define PINCTRL_GET_FUNC_GROUPS_RESP_LEN	12
> -#define PINCTRL_GET_PIN_GROUPS_RESP_LEN		12
> -#define NUM_GROUPS_PER_RESP			6
> -#define NA_GROUP				-1
> -#define RESERVED_GROUP				-2
> +#define PINCTRL_GET_FUNC_GROUPS_RESP_LEN	(sizeof(s16) * NUM_GROUPS_PER_RESP)
> +#define PINCTRL_GET_PIN_GROUPS_RESP_LEN		(sizeof(s16) * NUM_GROUPS_PER_RESP)
>   #define MAX_GROUP_PIN				50
>   #define MAX_PIN_GROUPS				50
>   #define MAX_GROUP_NAME_LEN			32
> -#define MAX_FUNC_NAME_LEN			16
>   
>   #define DRIVE_STRENGTH_2MA	2
>   #define DRIVE_STRENGTH_4MA	4
> diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
> index 05df49f292a..f5e72625e53 100644
> --- a/include/zynqmp_firmware.h
> +++ b/include/zynqmp_firmware.h
> @@ -185,6 +185,11 @@ enum pm_query_id {
>   	PM_QID_CLOCK_GET_MAX_DIVISOR = 13,
>   };
>   
> +#define NUM_GROUPS_PER_RESP			6
> +#define NA_GROUP				-1
> +#define RESERVED_GROUP				-2
> +#define MAX_FUNC_NAME_LEN			16
> +
>   enum pm_pinctrl_config_param {
>   	PM_PINCTRL_CONFIG_SLEW_RATE = 0,
>   	PM_PINCTRL_CONFIG_BIAS_STATUS = 1,

Applied.
M
