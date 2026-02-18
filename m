Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DAAE9A02C
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 15:18:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C472E83CE3;
	Wed, 18 Feb 2026 16:18:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hlacCceF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3F6683CE3; Wed, 18 Feb 2026 16:18:00 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D111F83D0F
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 16:17:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZ2fUJfV2RQnv6AH0NSAdYpHNMrZQggPT5PmgulEzMR/fJ4ZPV9Qa1YrwGhdmGETJn3omH2QYPFf6LSkO7i+nIiXkULOX7a6bdQKr57onnqGYdJFYS8pV3LyD8Mk8Ulq+oVVwoPQ0SHIkQ652ynWtc1j9CDDNXJc0hlTjaQ/s8eUXOPpanNsejHd8F3WZv6PXmt3nn6yUVNvCZFiUlFKeuHBOrCFrXrQL6YntuleqFblSo5XVimUAXEdvbFfKdwEAIxggC7p3WYoHTie3b62CecIgqh4XJ6qDHFPWFcaL8yUViZ5r5W7QyUOg6M810+mlm5BgrRFyCdcTWqPdIJ8tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCp/6oYPVoSr8xN63tykxrdh/l9jCSpFtz2egqLRAaI=;
 b=nmFr8XdtJcaOEriacCO9HkJ0gFwLcOh2AHPtw5e6wdc7FSLp6D4adKsRAl3qUA3bsPYuY7W9DxciqrsLlQL+jE75E7uJtZUj+SLl7ZUByaqFFghb6ixLhhzcBx5AclHpunjqWlcvX4nmJuByRczIb/XP+Sm3kRVVk0NU/m1S/6/d5pSi6y82CuQ5iHgspfnkSp7j6qwHcV5rGG8dtSQWVRbG1fXyPbhTCRWDapi9kM0CIFm+PP+oTaCrT52SCdR4aWNnKHmhTxlI8QSUe/ktAm6Od7wmGM6uGAa7mYxuYHCDHzk2DCe2mkYAhbiVSSP7/VaSYdND7gMiPlfUjgqoNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCp/6oYPVoSr8xN63tykxrdh/l9jCSpFtz2egqLRAaI=;
 b=hlacCceFELwwGvePSE9ejERCot7dK0SV5hMUTMdMD7vfqLcX9vUVYplVCc8EM+eilyLKfGKRo7i6RMhx32KFepi6+SaRj/N++5xPepOuxqF8lNeI8DavyCYrDDT865b+MOqXZoQkHnc1ji65sudbiaNJhsYWzuyMAl123v1qO+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 15:17:46 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 15:17:46 +0000
Message-ID: <3010524b-9d61-4c03-86ee-af06f995d686@amd.com>
Date: Wed, 18 Feb 2026 16:17:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: mbv: Update stack, heap, and OpenSBI memory
To: Tom Rini <trini@konsulko.com>
Cc: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de,
 git@amd.com
References: <20260218063329.396968-1-padmarao.begari@amd.com>
 <20260218141224.GA3233182@bill-the-cat>
 <363a86e6-8ebc-4b76-8bc9-34e317362b71@amd.com>
 <20260218143243.GB3233182@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260218143243.GB3233182@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR10CA0106.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::35) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|DS7PR12MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: 35dd2ee2-64d2-45ce-fc4f-08de6f00decf
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkprUXloeUUwdGszK2RzOEliTkE0dEE2STBwaVFtQUlYMnovN2JKTmNLL1VJ?=
 =?utf-8?B?dkJGNG1EYUh4VERPQ0c0MkRKdk80c1BhdDdhZEt0TXFnWDZCa2JvNkhnK1Mz?=
 =?utf-8?B?RG1tMUkyaS9BYS81d0p3OHpxOUlyaTlJZ2ZnbUxkRHEwenIybU5TVEJPcmFu?=
 =?utf-8?B?TXpjL3JPaE1tNmpOdEF3d25hNThxVlFFTnlDUkR3ZUx4MnJCQ1RzMCszTi9w?=
 =?utf-8?B?ZVBodWRGUlp6YWQ0N2Z1VFZBTjB6eThLaEthUHFJUGR0YmFPOWpnOVdiQ2hv?=
 =?utf-8?B?OHVJam5ieVFuUWNDVEl0TXhTazJaWDZWaTh0dEN3aG5xMVVrVWJaUFl6d1Jw?=
 =?utf-8?B?L21TSDB0dGlodjFmaGZpWU9PK2xFOC80eVBsMUk0NFhJTVFmS25lcVNQaWlL?=
 =?utf-8?B?SGdVdFhEY012RjlSZ0F6eVJYS2ZHcUFsK1lJWlpKdy9zTU10aXE0SHFCRXJ4?=
 =?utf-8?B?SFR3bW4raWJtUFFyYzZ1emVrQm92ZjFFaFEwUlhXSU5UTXZuOWNDK3dlL1Ex?=
 =?utf-8?B?d3ZRRVVFbktPMys4TStzTkFmN0xZL3RZY0RSZS9JVEhzS3VsMWlWcW5KL1VC?=
 =?utf-8?B?dlRDZlVLSEkzQTQxWHBsdkRqandHVEVHb3NOQkpVZHFXN29rKzNmWVhNaGxH?=
 =?utf-8?B?NCtCZDJpZ3RpelVjU1NuaTVSMDhxR0dndEZvU3htNVY2dmV2c2pWbmJ3NHpj?=
 =?utf-8?B?dkN4cXBxWjJRSTQwNndjZnI5aUJqTmN0Y3pwaHF3T05mTnViQ1RpOXFWMWgz?=
 =?utf-8?B?TzdtRVJCWkVUSnhYcFd4N0p6c1grdkJNbVBMS1N3UmJVTXV5Z0lPd25ROC91?=
 =?utf-8?B?TDh2aVFFVFh0QVRyWFBVSzZHRklUWW9rMUV0VTlZcGJWV2ZPSk5pMS9CRzhF?=
 =?utf-8?B?OXRMaXMwNDNtTUlPNW1JYU1RdElWUjVjWU9kemd3aDllVkxRcFQrcGluVnhD?=
 =?utf-8?B?U3hnYmNRYm5QZjRuK2FDOXhZSmFZL1lLcWhNYjFtZTJHRFZweTdpeUtZU3hN?=
 =?utf-8?B?Uzdoc3pPcE9ObWdPN3ZyUEp3RUNldUQ0Y2JCSW9CUGw0Z3gwWmQvR2tRV1dh?=
 =?utf-8?B?WW5MajVTWGFBRFVoM1pHTmNFMUljU2RqcThaWVpTYmFKUCs4QTBNbXVNUTVT?=
 =?utf-8?B?RzF5Z3BlWE9rL2lFY0VaMk5OakpaUVVmamQrdWhRVkVqV1dwMjdCMXBNRGVo?=
 =?utf-8?B?SjFwdVVkTkF4K2dEYzcrbXpFRWt5d3lxcHR1QkhBWkdHRDc3emFGZ3p1bVp5?=
 =?utf-8?B?WmtXTEdTTGxGL2ZSaks2L0toVkpiUFZZeVR1R3RLNG1FUmx6dEd4UGxSeWto?=
 =?utf-8?B?ZTlYc3BGT2VqanRlYnlXcHVvNGxlOWtQUDVTOUFVUmtjMllqeUZQdEh1MVJX?=
 =?utf-8?B?Q2ZKMzF1OTJ4TXEvTXJnOUFhQ1dzVkllb2lNUkVUSlBBaVMvN0NkQUg5SjJ1?=
 =?utf-8?B?dTRBbmdHb1RaeGdqMDBhN2FJMjFkR1dwS2MwcE82K2h1T0FEM2FuVzc1b2tV?=
 =?utf-8?B?cWRhNUtaL1lhaWVUQjF5NjJPSFpqMW1YdjBSUDEzOXFqbEhXeENGc09vem5H?=
 =?utf-8?B?NG80cUF4WXVYTENoTmN0M0tYN0R1UWdDdk9Ga1pUa1RBU1RzRHM2K0VPWE5t?=
 =?utf-8?B?WlJwZ21EcWVJSHhyV3dRYUN0aXI2YkxQSHJVcHVZREFmMEpSRWttWjR0bVV0?=
 =?utf-8?B?VGl5TUw4enJ1bFo3cHl4eU1uZmN3eUl3MVc1VTByL0ZraU9yMXY3NjZqdm5q?=
 =?utf-8?B?cGtkY2hQR1EwVllXSHUrakdSb2VydTQvNlB0MzMwK3ltaUhZR0NhcXhwNlNJ?=
 =?utf-8?B?WlJRM2kwSGNvQlpJTGtpOTNoQUM4UnNla3packhEM2lJWVRTcUlrekJlNFRv?=
 =?utf-8?B?UUVsdGFRMVdxb050eHd4T3lNd0hucFRGZi9zbGlVVFp4RXUyL3FUVlhvcjhm?=
 =?utf-8?B?aTQ2UDBtRzBDR0oxWUxZVHRFVkhGeG80S2lHTncxbUhSeXpBcHp5M2tkUWpB?=
 =?utf-8?B?bVV2WGkyL21qUFVRUnBqQSthL0JiVjByWHZIdHMrODhXSWZaekc0NFVVamRY?=
 =?utf-8?B?ZUxvQlEvelErSk5LK2I0cHRpaGt2aFI4N2lGcSs4M0ZtVkJqZnRod1Q3V2R0?=
 =?utf-8?Q?BatE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkIvcHhia3lUL0VFNnBVNWdiM3lOK0d0UWh1SUNqeWFCMHdqYngyRVZEUUFz?=
 =?utf-8?B?QkszZXB5QWR3QTNEQmZSME5YT3puc3hLN0FpUEFUWk9nb0R0emFxQ1IvRVZ0?=
 =?utf-8?B?cUgvK05nTXYxQWRnOUdlVDhQdkxjVm9IQkIvZ0JKSVBtZGM5a0JZaGpQd295?=
 =?utf-8?B?NDFRTkN3ZURqS1daRFRQZ2NHcmRRdWQ0eDdMVittOHJZUHhEc1QvTjVwZ29a?=
 =?utf-8?B?cWdXclp6aTNmZnFLdWYwZGNGMW1jdFNob2oxYllRQTJCWUU4UW9URDl0Y2Ni?=
 =?utf-8?B?V2NOSzE1Z2dreml5RStSQjBJUWF2Wlo4SW9kR0V3bmZ5T2dQSkhCR243RE1n?=
 =?utf-8?B?UFI0ckNYNkQvVjR4ZUFIbE9PUW05WFdad09YUVhMZWpDZkp4Q0ljQlAxVmww?=
 =?utf-8?B?NHFYemxocXZTVnRBY0ZaTllEcmdRbGN2M0xYOU5MWkI4ME02QU1MWldaaTdl?=
 =?utf-8?B?a3Z2NnFzWERFOHdIajhkU3VjaHZ5R3dBQTEwdStQT3diZ3p0RFZ2MWoyNHBX?=
 =?utf-8?B?NmhySkFCYlB2SDJhdDArWTBmZ0k5ZlRmNFl4UUFuZFdzYWwwMjBvb3VPT2Nx?=
 =?utf-8?B?NTBhcDBsdkg1MHV1dHR4Qkk4ZWNvUlNOZXNieHRFQUc4aWtzbEE4bHo3bDNs?=
 =?utf-8?B?RkpNZ2s0MW0vVWdDNVhwRjIrQ3A4cG1MTVV6clhZRkdkN0lZL0hmbUpzQ2Fs?=
 =?utf-8?B?akE1RlFjaTIvWEkyWnhYd29Lb0JMd3pzajlDTVBjVkEzd0t2VUVYTnhta1p5?=
 =?utf-8?B?ejJoL0NsZmJabVFrR3lBSUpBc0ZKSXM1aDdoOWxkY1ZsT0IxZ0pUallkMURU?=
 =?utf-8?B?VHowRUh2S3gxTmFFQUh3a1lUNXJTekhxYmw0ZFVjb0o2NjgwOU12MWV5VW5C?=
 =?utf-8?B?RkRITmdLc1ZQNXU3QlR1SzVpaXNNWDdjTVN3YWlJblhxWFlnZXJIb21tN1BF?=
 =?utf-8?B?cWVuZE1ZMmZ1eG92ZXl2MitBZzFkTGdBSVp5elM5OFp5MThYOVdsTnhtMDZh?=
 =?utf-8?B?TnFtUHNETHdyMlZkMGsyVEx1T0NURWM2QUdEbis0UE1aSkRvOGJiLytrWisw?=
 =?utf-8?B?c0xteDhRTHpLYUNpejFCNUlJWElzR0tyRUJSczBVbXc1ZXI2ZWJ6ekdMck5W?=
 =?utf-8?B?WElmYklISEFWS2xyNWprcDFMdjFPWkxiMWxNTzQ5eW55U2JpZmJMZ1lLWWow?=
 =?utf-8?B?SXJERTU1ZG02OTE4di9ubkwrYWN3VnhMRitIRmY2eTRCOFY1NWFCUTZNM0cx?=
 =?utf-8?B?d0haTWRwR1VLWVluTnQyWUVTc04wQzZnazZuSGpnMGM0cGhLVlYxRGE3WlRj?=
 =?utf-8?B?cUdZcnlmRzlJNzU4QWpoUEZ1MXdrR2ZXNGhRcnVScW1lOGZQeDVQR1lLR0Vi?=
 =?utf-8?B?dEpBRjdLVGZOZXpUWkJ3SkVCTXFqT05pYWNDbXlFWUk2TDBpS3VqY1IxbW40?=
 =?utf-8?B?bG1nV1BiMEZaWktTU1hOVURjTHArWmhnbXdBMkwzbWVKVmQxVStIY3h2SkNo?=
 =?utf-8?B?N1hva0FRL253RERnTkJ4T0ZXNHVRN21NS0xlS0VSNmNsRTRVUDU2Y3JlMUdi?=
 =?utf-8?B?aE12ZHAwd053VkRLaTVaTENLeEhvSDVIQzk0and5N1FxYm5tU0o4VFVqRmg1?=
 =?utf-8?B?eHJ2a0R2d1pMK09INVZuRHZTT1h2WHJ1QSt1TnBJc0hTTHRWRnF3RkxqR1kr?=
 =?utf-8?B?dk1qOHEwaHZ0QzBjUlJDcC9tUTJoa3hkR2Uzei94ejJFVTRLd0gzWndaTGpT?=
 =?utf-8?B?VWc0bHI3ZzhPaE03WndyNlZTTy9ERDRjTXVwa1N2c1BSaGk2eFJVWkNUeXo5?=
 =?utf-8?B?Y3RCNlFDczRyOXJQdXBLZUhMZXg5UGwrZ1paZHdpL0FKN3BoNk1QZlJ4M2c3?=
 =?utf-8?B?YS9lR2kwR2FxZHZsK3pDcERLNlNqdzFPZTJEOWRITXVkZWtHek5lR1Q3SGo0?=
 =?utf-8?B?ZU04WDNEZ2JLbzNqaWJUWEdjc0NZS3luY3d2R3FGODdVRmdNNVJWeXM5Z1Vh?=
 =?utf-8?B?V0YvWHJ3R0tHZWF0ZTRtUXFtR2NFOExVUnZwMzZ4aWs1SDFnT3o0VGNXdlQz?=
 =?utf-8?B?RUdYZmJOc0s5V3oxZ0ZoT1JlU3k1am51MFoyamZpQXliOFVnbnNtZ1BKWnlx?=
 =?utf-8?B?ZlFHV3YxM2dPWUZkUVIzb2F1K1VjY3Y1b0k4UTlEdXNwOERBdDVQbzN2VWVy?=
 =?utf-8?B?Z3ZkcktzT0l1TFdEd1o0dVBDdUhNUXBEMnp5cG1kaUxEOUxyMFpXY0p6QTdn?=
 =?utf-8?B?OGJidVBCVE1TbVJ6ZkZFRUc2cHp3V1k1MEhZUXVaazBibThLNFZIUFBHN1pF?=
 =?utf-8?B?bU5SdUhWNFVXb0RPYktycUpoK0h0RmxIcnZwaWJMd2xCajhJbDl5Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35dd2ee2-64d2-45ce-fc4f-08de6f00decf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 15:17:46.3486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2WkdPMiFyj+UrKLkJuRa2eH8fa04/Fzp2KYpTTrRF62Prb/0hYu8mCyqswVYvLt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041
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



On 2/18/26 15:32, Tom Rini wrote:
> On Wed, Feb 18, 2026 at 03:18:37PM +0100, Michal Simek wrote:
>>
>>
>> On 2/18/26 15:12, Tom Rini wrote:
>>> On Wed, Feb 18, 2026 at 12:03:15PM +0530, Padmarao Begari wrote:
>>>
>>>> A 2 MB region of DDR memory is allocated for U‑Boot SPL, with the
>>>> heap starting at address 0x80000000 and the stack at 0x80200000.
>>>> However, U‑Boot fails when using OpenSBI v1.8 because OpenSBI begins
>>>> execution at 0x80100000, causing an overlap between the SPL stack
>>>> and the malloc region.
>>>> To resolve this conflict, the SPL heap and stack are moved to
>>>> higher memory addresses, and OpenSBI is relocated to 0x80000000.
>>>> The SPL heap now starts at 0x8C000000, and the stack is placed
>>>> at 0x8F000000. The MB-V requires at least 256MB of DDR to run U-Boot.
>>>>
>>>> 	_________________
>>>> 	|		|0x8FFFFFFF
>>>> 	|_______________|
>>>> 	|  SPL- Stack	|0x8F000000
>>>> 	|		|
>>>>       	|		|
>>>> 	|  SPL - Heap	|
>>>> 	|_______________|0x8C000000
>>>> 	|		|
>>>> 	|		|
>>>> 	| Full U-Boot	|
>>>> 	|_______________|0x81200000
>>>> 	|Load FIT Image |
>>>> 	|_______________|0x80200000
>>>> 	|   OpenSBI     |
>>>> 	|_______________|0x80000000
>>>>
>>>> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
>>>> ---
>>>>    configs/xilinx_mbv32_defconfig       | 4 ++--
>>>>    configs/xilinx_mbv32_smode_defconfig | 2 +-
>>>>    configs/xilinx_mbv64_smode_defconfig | 2 +-
>>>>    3 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> As general feedback, this is something that ought to be in doc/board/
>>> somewhere too. One such existing example is doc/board/ti/am62x_sk.rst
>>> and follow-up patches are fine.
>>
>> Just curious. Memory layout is something what every platform has to deal with.
>> Don't we have any script for it?
> 
> My still current preference is putting reasonable default values in
> Kconfig, so that it's not something that has to be managed in defconfigs
> as it's not typically on the developer to modify per board, but rather
> on whomever is doing the upstream SoC/etc support to say what it is. But
> that's also a little less true for FPGA platforms?

This platform is soft core as classic Microblaze is. Difference is pretty much 
that this is risc-v based ISA. It means memory location is not fixed, memory 
size is not fixed (because there will be users of openamp where small amount of 
memory can be also used).
And IPs base is also moving from one design to another on the same board.

Anyway setup is that SPL is running from small memory - we can call it as OCM 
which by default starts at 0 (but can be changed). And we got only 64kB of 
memory that's why spl stack and heap need to be placed in DDR (which is already 
configured). We had it at DDR start but it is not practical because after 
handoff to opensbi that memory is unused.
That's why make sense to have opensbi at ddr start to use it fully.

Currently BSS is the part of OCM but I can imagine that we will move it to DDR 
too to have more space for text/data/rodata. But the problem is the same how to 
define BSS location.
I don't think this is going to be a problem to get it via tool machinery.

Thanks,
Michal





