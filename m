Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1718C47BF4
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 13:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF58883F66;
	Tue,  6 Jan 2026 14:47:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="R2iXpxGP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAA4783F6A; Tue,  6 Jan 2026 14:47:37 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BEEE83F5D
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 14:47:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNDIbZklYlX26W0ZlY5s/gZQVwRUSTZ6nbyhVgLkupgdKivOo/CP+IkXvfj6yTQpVfgi9BUtNy8+SI+Ynj8LR3l3kl5M7xEOUXrLKPnrKlaR1qW+/i3U8odu9u5cgjlla5jAxxo9l7aPc5mHXP9JXCcADF7rrDTjdjr7krh1iJKCsIdYgK6jRwcKlhfkupvRFOwSgw0QqewlPEd/uGNbjqxe949xcXKVrpG7f4JkxHzHzddvVL/OcbFDhegjSBKh82AcCJYuy/M6Z+67D8E9stQx2nRtozxXw837+9qvOZMxBCAsWzZmNeCYus2jCgIIyxwJAGPt/QMXX4Q1/gE64A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Avrpdwy5P3kXGqpuyuEhYJB2Y/1Do8Qql87P0q1eMcM=;
 b=Boxrqf1cHg++OMJwv2vqvFTdY9kDJ8Lst3T9QGkEKUpFZa2s/wWKmJ2Yg5MFj6Xat38FPAhfZgzucuqWcGo1SqOQweh/4RnLuGdeN0Y/AVjHISMQN+f2ViJBbjYw+TFD4LzeM+zIU4RVPvUbiNAT1YpAIRa+uJnFECZJh0PAxzRhDF67uvNSOkEJI5MyQcp68yB62/Z932YUoIMannpVbU/f/svvMQUrUjKbirVRLXrzEBRjmFolWFKaxN72/pnJXKp8QcAI3xOo9sXZ/ruksly5eVWOt9n8JGAJkxMw9DJ+YjZdoSo9FABOmrgYjMKzpHoh2nPcturx6/qvuS8K1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Avrpdwy5P3kXGqpuyuEhYJB2Y/1Do8Qql87P0q1eMcM=;
 b=R2iXpxGPAmqOdCLR/vCkiX/TU/1dGbXoWHWLp6F1dB3v+AMrUOxxAiSfx+gepkJjqd4UkYv+AnaJEASzMDkxGnJj2gH1aaeRwQzO1RdM6vxKIDPpEryY37+l+MccPpco2dOkglUw1OJR6C1+Wiw2UzwAKnaxXyZA7CLHU4p8h75lb1zO/XVc4RgMGywHcJDP2wu6SX5Nipri7+p7cZsN2liBm8sM5J7kACmpBtKHv+OCrVXGrT7CFlJlXlbuunCwxp5nmiFWoRiDY2urNn+iw27l2kFmaQ9diTt36jIcU//CEgN2TjKxojGgkm5BOfa51LQH1AdYsUcjHaMcCs7ESQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5849.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3bf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 13:47:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 13:47:32 +0000
Message-ID: <c999bfc3-e95c-4a1a-98a2-952ae66959d1@siemens.com>
Date: Tue, 6 Jan 2026 14:47:30 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: cip-dev <cip-dev@lists.cip-project.org>
Subject: Drop default y from CONFIG_EFI_GRUB_ARM32_WORKAROUND?
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0265.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: b68a8392-c0af-4a02-25e0-08de4d2a23fc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHQ1K3RvQnNYOWFqd0Noall2YkhhM3BnQk5tZERTc2FZYTZUeTBHYjluRG5v?=
 =?utf-8?B?Ri8xT3Bvb0tZc1ltazEyUWRQSkl3L1RUOCtUOVNYejZQOTZoZURZd1VkajN6?=
 =?utf-8?B?K2FxTmJQVDNzczlGbjdGRHQyMTF6RUU3aC9uSEJCTmpVQVJQRXM5bkpOQUk1?=
 =?utf-8?B?RW9Ga1hQQWpJS2htYzkyTWExV1prNldBbk5jU2x6c2NadFEwWGdrMGNrZTln?=
 =?utf-8?B?aGhJdHNzNU8vRnViRHRuZjNXK2MrVjVoU0VLWGpEQVdrMTFKQzdnSnc0QWtv?=
 =?utf-8?B?OTBnbEc3V3lBcHVjRlZidGVRYjdrWkJlVmdFcll1TkVwWDNhL21Tc3dBOTgw?=
 =?utf-8?B?N0Y4VE9EOFpxS2pBUDVjMzhRaXRQcjh1R3hMZ0xoSkJibWVGMzBRMFYvT3pw?=
 =?utf-8?B?ODVYUTFXMVp3b2xVNFB2NkoyUVNoNjRDdU43MTdBNEdCbUpkc2ZQWkY4dEY4?=
 =?utf-8?B?TXdkZUxwaEdlNEUzMnpUMWs3OE5Uekgzd3d3MFJBQi9tM3llYjdsWlVmMjMv?=
 =?utf-8?B?Sk9pdEZ4WTk3R1BKZWN2UUZzMjJRakFEM2k2RjVTNGNrN20wbEpha0M2MTdY?=
 =?utf-8?B?UzVUU2QvV3lRbUFvK0xKNHAzai9RNWt3THBPWmFvczdicktxZDRjbm8zWUtO?=
 =?utf-8?B?aTFraXFnRWZsVUZqbDcxVW5IT0hYRHZFVjM0aEpFWk1la1VSMm9yNkVSOVJl?=
 =?utf-8?B?TndWSlF2ZGk2V2pvSjRJYlgxdE1HOVpVcWppZ2dZbll4UXAvVDNST0ZLa3M4?=
 =?utf-8?B?MElyc3M0L3cwRWt3NVJhcUpHMUZ6N3orMEZTakp3MzNOd05CLys1aWgzcWdy?=
 =?utf-8?B?Y3RFZG1kRlA5d0M4NzFWbkwxV2hld1dxK2pLdFZHZWo3bndWcUVXaTNsSkJ6?=
 =?utf-8?B?WVhlbmxXWWVoS0hucmpNWTVKV2J0MlF5LzFYZEd1NTlDL2krSmNSc0VsVnpD?=
 =?utf-8?B?ZGNVZkp4Mk11Qk1WUDE2elN1M1FYVnlaU0JmbmgxL1YzZFFiUnJwR2xvTHRL?=
 =?utf-8?B?NTFka2tEdmtwNHRSQ0duY2x1a3RYTXJvaDh4R3lGZ1RLWUFUeVgwZ2g1cFNp?=
 =?utf-8?B?TEQwVmlNNHhTTnpYckk0NFlaaUZOQnB5MHFhS2xmMFNGeVRnQ09vQ2VyMUpU?=
 =?utf-8?B?QlgvQ2dLT2liT1NSZklGVldOTm9JTTVnaFU2ajhYSTB3V1d3TDZGcitha3Yx?=
 =?utf-8?B?YzV6clJnZXBORytMcnd1dStKb1RCRmxJZVdHY29TR3dXVllGWlFlQXlVb3NH?=
 =?utf-8?B?LzluNlRudFU3OVFRVUhFYXNBSDVPckhiWnpMRDFGN2g3SjVHNzcvUDZXdnY3?=
 =?utf-8?B?RzNqc2FwZ0tjcHNaUmhpYTRrL1hGMmpJU0JPT21xS2V2ekZZUDVjcm5aOER5?=
 =?utf-8?B?Nk5DRFhJOGkrbTVKMjdpNk5ta0UyQWtIVHhqUmdGUVMvcC9uM3FBWjhSNnBz?=
 =?utf-8?B?T0M3RTVONllvZW8rWmZQSVVKcU53Vm1RUTU0MDJZWkV2T2hwNktROE5JYUdj?=
 =?utf-8?B?VkdkSUFPdkJMZDM3TkduK3dnMTczbDBNYVdWMHcyTTRFQ2tOT2NoUkphS1Bp?=
 =?utf-8?B?eUl1ZTUwNUFMbUsxMnJBaDZZS2V5SHFkT0FVSDR6NHA5THlHK290TmN6dUJG?=
 =?utf-8?B?OVJkcWQvT0RCSit4SytIYmtDc3RhaVBGUytJU0M2K2FWQ21HTkdJUUNhcnBI?=
 =?utf-8?B?cExvd0pBL2V6UytFb3h2SmRmRWYwUy9mSVRVa0NqWHppenI5UFFDSWVWLzRD?=
 =?utf-8?B?aHRNZU1tS3lUUG9kYzF4cnIrbEQraWRMUkV3TW9aQmdVOUFKVlJnR3R5Zmp3?=
 =?utf-8?B?RDVnem5kZGpJVnV1Ykg0cm1JNnNDQ1BXa2ZXanhGNUlJelh0UWpaUzBVOXMx?=
 =?utf-8?B?NjArNi9IMEFQODJlZFV6aFhyRGhJMFM2alJIZ2dXazhMYzVJY3RlL0dOMGUv?=
 =?utf-8?B?S1JQYjFLTzdTcWNQeTVWbHNYNjRQUkNYR3kwbjFVd2ppZ3g3dWloNzRPUzRL?=
 =?utf-8?B?UWV3dStxVWlRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUk4TXJQUzd4UENleE5rNk8yaVR2bkc3UTdLUm5TQWxHNUlaU002bmRITEFs?=
 =?utf-8?B?ZVZUU0xjNHVlRmxtaWNOdmpnUk5HdEpiSE1abFJ3UlgwWS9rMHFObGZvTi8r?=
 =?utf-8?B?dGVVb3pnNjVITEtuNVFSR2VOY01zbmJzeXZmcG5iWG9zdjdsNk5jMU8zQ0NQ?=
 =?utf-8?B?UVY4aG5iU0xWYXYrbndTb3RvQnVVRWpGbFlDQ3o3bWIwR3drMkhZbXpydVFD?=
 =?utf-8?B?L3psRG1rT05pUE5lTUgvaWY3YTR6dUZ5VHNXVG9VWEo3b1ZzS2hqTDNZRjdi?=
 =?utf-8?B?TFBWL0QzZ01QYW9Dd21ITW9UK1crbkxyenNJTm9vU3VubkZEbFd1b3laeW5F?=
 =?utf-8?B?aDBRR2F5cFRFZzN6Y2h6aG9uSHp4Ty94dm12dTM0ejI3THR6SmwvK2RmTWtS?=
 =?utf-8?B?cWE5a3FQekZVbWFnUWF6dWRPQ3FDMFVlNXM5Q1NPUkkrb0tyMlNyTDlwaDB5?=
 =?utf-8?B?MmhjY1I2YUZFWEVqamVVWWp5MjdFbzc1WURzVGdHSm1iYmdHSHR0c251WGJw?=
 =?utf-8?B?Qzl3MHJoamJDR0I4MW9yQklyMjA5SVc1c3l2YXFMRndQOWZwMGh0K1EyQVZF?=
 =?utf-8?B?SVk1UlBmNHBKL1kyUTRQRnI4eXZlMzg5elkzNys0QmVzUDV1MmRiM05XRlFs?=
 =?utf-8?B?dXduTDhlc1pGSTZjRzIyMzB6NW5IRm1KMHdqS1FMWTRJV2ExaFQ5SE13OUgv?=
 =?utf-8?B?d3Fkd3grOWhVU2V4bEg5bXFiOEpubmZSanFTaURKK2gyZ2lhc0RXeTd4ZWFq?=
 =?utf-8?B?dEowUGU4YnBkUGFRZm03eDFoRUp4WFlJQ3N5cVFla1B3TTVuVVVhRVNySmFY?=
 =?utf-8?B?Q0JZcndDTzdWT1owYXhTRk12Nmc3ZXQyaVpjYzVqK0R0L0lMR3ZVT2hhVVlX?=
 =?utf-8?B?bzdZWC9zSjN0WlpOTU1Jb1lEWG1FVzdTR3UvTkpOK2FncDlaU0UrVGpueXhv?=
 =?utf-8?B?eFRodTVkVWRRekdqQUdveldPWHhXdFhkV0dMWHpRbGlnUmlFYlFOVlhTdVVs?=
 =?utf-8?B?eEpzSFB0V25LU1hpb3M5cEZVbEZyUE5GTElMZ1J3ZjV0VHQ1ZTF0SmNaVWxv?=
 =?utf-8?B?TTRPWGRHWC9Oa1dyMnY2d1pqUU1NVG1STmk5WExSdXZUMTVNMTI4U0JXYVAw?=
 =?utf-8?B?VVJDTnJxMUpyUE5saHU0Syt2YXR3MTBnRjBpMWJzVVZvS0pHWWRZSlhvVHZt?=
 =?utf-8?B?ZTUxdzF2QTFFVW00cSt3blNLMW95TEcxSmpqeHcwcDFNbGlKK2RhSDNZdVlh?=
 =?utf-8?B?anlHdkpPbkkrRXJOWENnTG1SSGtidzJpVnM1TUEzWGtOQW52RXZzT3pnRFAy?=
 =?utf-8?B?cWIwd0Nzd1lIUUxxWlNpemtLWjBuNVJpNVZGL3dnY2hsakJ6ZjFXYzA5RHZ1?=
 =?utf-8?B?M0hSZzFGT0Vjd3NtUlRvSDNOWUgzVEkwdGJDd1VraHdnWkozZkVPTEpPa3Fh?=
 =?utf-8?B?NE0yUkd0c1Z0SUMxZmFTU0ZEUW8rRGN3SVRvc2ZUQlBLY2lWSWRtY1l5YlNq?=
 =?utf-8?B?QjNBcmNRSGliUVIwclRyU1EwbmhSN0xlb255UnViZm5paUlPSHJ0RGJKN0VO?=
 =?utf-8?B?Ky8wdGh5SnFnNE5heG1sdDQzbXREa0x6RnJNTUZLYWZKNWVEcVlkNjhLM0hQ?=
 =?utf-8?B?RVRWQ3BxQytFMFR5Wlg0RUxhbFM3WGtyYzlEOFhUaWJGTU10cSs0TGlEUVMx?=
 =?utf-8?B?YXgrbGdPRjBSbk1vbDVpTDJiaFBqeHpMd0w1dTh2VXJaSk5zN3NETUhkVS9Z?=
 =?utf-8?B?K1FnZVpQTmhJNXd5MUpCRjloZFAwN1ZxNFRiVmowTFh5NmZLY3kwWTJSaE05?=
 =?utf-8?B?ek12Qk9ndnFyQ3RWcFZuYW9CeWs5SGYzdS9CcmtIN1licmNqYmt1ZU9Sa21z?=
 =?utf-8?B?aFVoRjNnRVM2b1hCTGgwNzlIbSsyVDJCWW41V0lzUVpBMzBERTU5WmJNM2hh?=
 =?utf-8?B?TzdQN3VrVmp0SlByUG5tTGh5NEJBdWJybGZiQVE1YjVxTERtZnNFSFp4YmJp?=
 =?utf-8?B?bjhOeUtxTG1penNWN2pVakFRUy9EVk8ydTFmNG9TREFFODJTcGVYcDhmZ045?=
 =?utf-8?B?UmZIU1Bkc05CT24zNUJTWGkzeVpsR0dQUE9GbTE4VVpWRmErRWNRMFpvS3ll?=
 =?utf-8?B?bVErM1hKU3RhaHgzYnpoUWh1Nnp6Z0ZmSVExMFJvdkMxTlJMOXdPV2t2clZM?=
 =?utf-8?B?dExobm1LbENRazZQb1ZlVlBaMWhEVHZUMlc5TzhmV0w3ZU9tNk9mWWR6TTNZ?=
 =?utf-8?B?dE1QT05ocFRSODdDVStJM2loYTI0eTNQcjdUTDE5R3Nza3lFd20zNGZiWEUy?=
 =?utf-8?B?SGNoV001NWxtc3BXNEM5K1lIa3dxZHZyblBJbEJ4Mzk2UGdjUENGUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68a8392-c0af-4a02-25e0-08de4d2a23fc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 13:47:32.2391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: up8ugoMzrKZxt2/7Ar+yYZEp9VBmAJEnB4e3Vnm/u/v6tqns27sSIONQ9CMpSbokmkYSrkz2hdG8gYcgpz1f0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5849
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

Hi,

it seems that some kernel configs can cause problems with the
CONFIG_EFI_GRUB_ARM32_WORKAROUND. Namely, 6.1-cip and 5.10-cip with its
current defconfigs [1] no longer boot on the BeagleBone Black (other
boards still need validation), both with the more recommendable
systemd-boot and grub. I do not have the motivation to debug the reason
in the kernel / its config, given that everything works fine once the
firmware behaves according to the UEFI spec.

Meanwhile, grub reached 2.12 now which is far away from the old, broken
version of 2019. So, should we rather make this workaround opt-in in 2026?

Jan

[1]
https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/cda3f5841dec33b81f24cedcc32ea09bb58bbfb5/6.1.y-cip/arm/cip_merged_defconfig

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

