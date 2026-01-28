Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD21DD3568D
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 08:09:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E0F68423D;
	Wed, 28 Jan 2026 09:09:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="bh8YCjHH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73BFD8427F; Wed, 28 Jan 2026 09:09:06 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3E3D83B87
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 09:09:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nS3gXoaSMaJbTj1B1J5zVnI2fcgMih/D/goDyQi79ynSR05SjWfB6aWvZJUcSSrTan/oyjJA3wB0PCzg57X0A2p0Ymeor3TNPa9+oPICu+IWE5Hf7TxwHco5vkRU6V9SxQEuvu+/4Oocd1RnWry8S7Fy4oiutWTXfCbECsjD5HXwdJeM7NAhGc1S0PXpv6MM9jIlSJcA7llC3/S2Pq5jkPy75wrjDJ3k/pv86/SyX8Vcs2WzqqXxo5OqjSp4SQQvwLl6idU5PNUFtB89g/rqFWXUJTWsr0U0F3zGhWd5nx4yVaPlfXUgX+BToHk2xJzc6Te8GvnqCeiyVjOh8e7bhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPtcY0tnusDmDI6pnfvrbYJeq1TeN1PouH8us3ctdkU=;
 b=MQomFdYWthxg675dKr1c2d3MYD6tE/GwfcvzgByfb8hokuZ22oKlAQDkp3erZH60cfS2cYpx5f8kwZLiysO1rPhEs65q3kcTIPRhs7tyA9h63aOODMnmLBrg/fDeo5+CvJ2KWiSjy2RisRjXJCBQ9Z4+Zr18ZU6678u4w/EwpB2L2HdZJhrULgWWthvANLH946LCpA6vVGaI/+kDj+CGBxZxudClRqPSLUU67dERbJGjPFjXgYLZqc5EkqTaeTv+7EQYVdeK2zMklaRhZqj1RXZbUoRO9anUyj9QmtwCpPl+T1QGy0lthdcz8lLOFaAfp2JgZoEKuhjtS5Jw7rBELQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPtcY0tnusDmDI6pnfvrbYJeq1TeN1PouH8us3ctdkU=;
 b=bh8YCjHHbzRGMtnikgWoQHf/1AoU3dYMDeqFfHNCFNfCbiSuCRJP8L1JKdP46W0yqwVFb5V2CvJuKkcn6oNBc3UVJ1+6FqojXm5RjfzcpAVU3Z/6zF/YNbqks7cfdkYagYdiUqP6SoKk0k7fvCZlZ0ypW0FTl5jn8mksm5nNtBt+BRlPykJUxewqFDeNTohbhAP+6DTCW7ZuXRnHWPiPgHQCPykK8jAtGX/mokFIbKkY5NVqDB2pOJaf2QvjErZbSutLX7pB9BeV4H70YK4TU12TBbPPUvsRxDUCIxD9YaKJ6jaOvT+S4/ScUhT/Pdvk0QBnWHP7xs41tO7YoNbVZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DM6PR03MB5179.namprd03.prod.outlook.com (2603:10b6:5:24d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 08:09:01 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 08:09:00 +0000
Message-ID: <1101a999-9e90-4799-9ebf-719323e91fa5@altera.com>
Date: Wed, 28 Jan 2026 16:08:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fix socfpga GEN5 handoff script path
To: Brian Sune <briansune@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>
References: <20260119015522.30558-1-briansune@gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20260119015522.30558-1-briansune@gmail.com>
X-ClientProxiedBy: SG2PR06CA0194.apcprd06.prod.outlook.com (2603:1096:4:1::26)
 To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|DM6PR03MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce2346e-937e-44f1-be34-08de5e447e52
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWRlNVlFaHhFUzJiU201YzZjdGMzTGJVQ01XSGF1QlVwNWhiK1JTUi81YWda?=
 =?utf-8?B?cWxuSHFrdWF4ZjVPTVg1UnRoR1BtZ0JXOVBqcFZJajN6aE1hdVdISnNScDlm?=
 =?utf-8?B?QzdHNHZkMFpIQ2ptYTY1VUdyQ2Zkc3FHSDVLREFLazJmanY5NUI0RDVoK1R6?=
 =?utf-8?B?Zlc5Z1UzUHN4b0E3VHpPbEVWb3U3Rk5tM2xJdnREUnhiM3RWUEdvM2xIM0R0?=
 =?utf-8?B?STJOZ3NvVlJVN2hqVUJLTk5CcElSNXc3aUx4OTdwS3F6aWpzcVF5Um0vR1Bo?=
 =?utf-8?B?VmFLeVE5eXVzZHZjeW5aMVRzcFEzeldwSVUrckN5YU0wUUtCeVp5UnNWTDZ2?=
 =?utf-8?B?TzBXSFJRWmNndWUxYURQWHUxdGhqUzJta2xvU1FVMk9sR3hyd1V6Nk5wdUNT?=
 =?utf-8?B?elE2c0Z4bGFOakFqc01KK3IyQ2tnZzZwQkp1RDFCNERuY1J2cmNPeXdqTndL?=
 =?utf-8?B?Q1FqVzIzb3dBcEFPRGlxYTZVbjBRNEFTTWNVQ0xFeXVwVlRVVGhxRDNsTnZh?=
 =?utf-8?B?cDVmUjJNZTZDYStLak1qZkY1S3Z4NGEyaEd1d2tSa3ZvTGtZUk9uTjEwd0pZ?=
 =?utf-8?B?SU5vdmdrNHpRWXh6NEplVGNDODFycnR5SVo4S1JnY2xxQjJRaS9GanROQTYr?=
 =?utf-8?B?VGFoWlg5Q1o3ZnNVN2hSM3BjRzJQaGVYOHdOamRUOHg0bEdmOWxRaEM3L1c1?=
 =?utf-8?B?WGUyNEt6cEd1UjNzUDZweXVqRlBNbTVsa3dLd1dBRTdtZEdUaEswd3dWaHAw?=
 =?utf-8?B?ZzkyR0Q0RDBJRUhIeDcrT21SaHZwY1QzZ2J1WG9UWHAvNVBOQWxFQ25FQ3NJ?=
 =?utf-8?B?V1dBWWlzSUt2N1ZyOG8vOGsrN0ZUQzlmdkwvM2k5Mjh6ZGxpSVl6VXNSdnA1?=
 =?utf-8?B?c0c2dk43c2JKcEozMFk4cm1KcW0yUjNVUVRGOWROSlA4K25kZlZOaElMZVhV?=
 =?utf-8?B?ZkRIOEEyckZQNlQzQVFDTStIYm1nb1B1ckVOMUpMY3I3eUVUR2gxUzJNaXov?=
 =?utf-8?B?R3FPK1F4ODZBOHNmZzJDRmZCMTBMeUEzSHc0M1hEWW5VYTIwWjB2bzUrTEpH?=
 =?utf-8?B?aEVxNmJseW1QbnlXZkYrYzNaNThwTGppSzVIS2ZHN1kyNG5DYXBYQy9YditE?=
 =?utf-8?B?Umg1SjhrZkt1a2pGeWllWEhZTTRzakhUaW1RdUQvRlN4dmhDRVNaN1F4TTV5?=
 =?utf-8?B?UERYRm5hcm1oM2oxYlJza2pXRm9aME42WnBXSFBGNVRFNjV4V1AxMGhHTjh5?=
 =?utf-8?B?VHM1QVkwbWt5T21aWUNKUkN2SDNyeXJqRnNKaWNSWExyRDlzNkV5MU52eTdm?=
 =?utf-8?B?WjlUS2tqeFRueE82R2lkcDdMakFoZkV5K2JtSm45SFNMOFpZY05ha1Y0RVp3?=
 =?utf-8?B?Y0JhZEJybFRGdzNkUDVTZHc5Nmw1NHBvNmhhUW55MVEzTWhmWTZXRXphY05h?=
 =?utf-8?B?aXZad1o5bGRRbjhQcUVQL09pQjZJYmNSSEhJWEVjaElTR3FCa3hqUStISlVs?=
 =?utf-8?B?cmpuU0RDQXFaQko4Wk5ReGZPVEtpTEZpOHRLelZkeUphTy95bEdNWFJiWmpK?=
 =?utf-8?B?TUNPYTVjbWVsbmlyY09MOGppV3l3aVEyVWFTRlV1TU9ndEJLMHpUVnU5Rkkz?=
 =?utf-8?B?NG12dTYwNkpmMHc0R21nOUJOU3l3U3BjWXRvcXZEdTVWTG8rN0JBWGczRlJJ?=
 =?utf-8?B?NmNONGxKM3lGMnBCN1pVVEtIcGVvRTN0SjZSMndJL0dkelN1NXN5NjZXVC9I?=
 =?utf-8?B?RldQbk4ySFNLQVZZSWZiamZHNGMrTzgzQXZDSEMvUDBDTFB3RTJWenhkYXpH?=
 =?utf-8?B?dE1aRmRET1VxQzRjOFV1eEthWVpMUXF6V1VEc3Y5MDIvZlliRlZrdjdjNk9q?=
 =?utf-8?B?TWlJOEs3QUxzV0VnYkZncHM1M3FwNk1QWUpzc1VNZ21rYjVERG1BTTVlaStr?=
 =?utf-8?B?d0lTSjFpdkZ6b1Nnb1BnNkdDVXlJc2Q4eVAzTjBZZ28vWm02bDhOMGV3VUlu?=
 =?utf-8?B?TVZ6UWpPU0FjR2RVSHRWVFRqRVVEMXptOVNveHl1M3dRSEV5bjFKQ1FpK2lZ?=
 =?utf-8?B?ZktqbkxtUVBSTFgzaHo1N04xUW9acTFaWGt0NkxDMVhEVVV6ejRKTXlmUGhy?=
 =?utf-8?Q?xDNs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEJtTm5XTW5Idk5veXJwQmsraUNHU1RadURKVURsUVE2QUEzLzRydm1HVWJB?=
 =?utf-8?B?WHhMdDV3c2xoNUMwNnFUN2trRVgxaGRadk5CbklWWGZzcjRvUlVtckY0T3Bw?=
 =?utf-8?B?amU5SWZPSmZhR0F6SU5KaUU3Q1A4eERNelJQUngxeXZWMUEzUlgraTg0Qi8y?=
 =?utf-8?B?SXZqSlVtRDA5ZHB6WUhKWUZ1cjlUV0xLSFFvb0pJK0ZOcFVPMzZKVHVZQzBN?=
 =?utf-8?B?eFFpcEZOMjlTZ0ppOHNTQWlwcm53aytxYmRlcnpTY1ZoSWtKNWpTRmtsNDhv?=
 =?utf-8?B?YzFNTytoUWkvQThtVll1UmZkT0RaYzhJV2J2cnQ2VDh2NkxOVTBOcFE2ei9o?=
 =?utf-8?B?d2doUUZYczlMMTA0SU15YU5NSWdTSWttcS9mbW93cWpFL2Ftd250UXlSaEE4?=
 =?utf-8?B?U1NSSGkwbUZFSG15ZmZlOUxaOFlCaUJpekxuNHIxZTRxWno3YzIzUmNVd3VJ?=
 =?utf-8?B?dTMxNGlhTGQ2cjJ5ZkFyekh4ODdMR0U3WGVDdmlzRFU0cG9HcEZJTDVPcUNq?=
 =?utf-8?B?UWxCUDZIQ0NER3lsdHZJNGxyNkZoRHBodlhJQUN3UTBxbWpwVndQbEZ5YTZr?=
 =?utf-8?B?T0NnUnFHQ1cyeUFWZ1k0QVFiSnJMY29lczJLM2MzcTBCUHNYeEFDOUpxT3BY?=
 =?utf-8?B?MFRZYUZESUFTemtsL0VxWlFkM3laYzBYdFczaVBNRDNyYTR2L3NYWTlDVjlw?=
 =?utf-8?B?Rndiem4xMTBZZklXRzg4dy93Yjg5YVVCc1pBL0haS3YvQ2VIbUtKb1dqVGtK?=
 =?utf-8?B?QnFDN1J5dklMc2p0QXk3L2U5NkFldFRMTG9yMDNqWjB0elRNbVh5TzUxQjVR?=
 =?utf-8?B?SzJuem05akg1dEtUK21jVjZVK1MydXlJblRZSWgvWW82UDd1ZGppOUN3VE5H?=
 =?utf-8?B?SUpGaWJ0dzFiL0IyZWVDUUZqdVRIOGt6bjdKSDNWZ2lzdWNDKzZQbHJ1V1Ry?=
 =?utf-8?B?c0k5cnpHS2FBQU1pdlZHMzQ4MUtaNjFiN3J2S3kwT2xpWStHbXBVbFU1ZUJ6?=
 =?utf-8?B?c1dPWUJGZitkeE1FVzdPVmY1QVovc3o0a00zRmpnYUIrbXdYNHJFMk40bldR?=
 =?utf-8?B?bDRUSGVHNU5XWElXa1dmb254bmZsekU5cEE0ZmVpUWJSNTFDb3F2dWtYRTlU?=
 =?utf-8?B?WWlQWVhQODdsNzRiN0J6YkN0QWhjVDMzOHpRYmdtTklaOGFtSWQ0dFMrVU1u?=
 =?utf-8?B?TjdWL3RDVTMwLzJ1QUdBNllGb2l3YkJ5MFBJMTJmU09SVlNiZ2FtT2dQMmM0?=
 =?utf-8?B?cE93ZnZvSFFPcy9ERTk3dW1xa0RoaGVBOXRnSmpyUEFjNzdld1hFL1dvRVBQ?=
 =?utf-8?B?Vm5WN2xaSjRVSEJvaU5jRnZzcnZSdlk1dHNrL0luMk53b1gwT1NFSWhSY2cy?=
 =?utf-8?B?c0F5cWZiR2dydE5lbk03UFRRcGFNZThPRWVUWjU3Vjk0U0xGcU53VjJHRUpa?=
 =?utf-8?B?YUQvKzlOd2p3QVpGdWhTUjIyOE5ZbWVuYlh0eGtQenFMblJQN0N6UXQyN0t1?=
 =?utf-8?B?TnM4TldxRllQMFQ0UERyVmVzS2hCSkZjLytraks1OENYYlRLTFowNzN4cXFV?=
 =?utf-8?B?SUxrRDJyRm1QdXRBdHZoK3hEUDdCR3JrOGFpbHUxVzJHZUpIeUV5Y0grMXNa?=
 =?utf-8?B?cUFQMktyZlFvU1IyTyt0QzQyallZT1YyUStNZDlJV0hOamxmcHM4MjM2N0JC?=
 =?utf-8?B?Vml4M2syK0JaSk00ekMwb2U1eFRST0NqQmp2a08wYmZFODdSRUxtKzE0Sm9G?=
 =?utf-8?B?WWFLYThLdFBXNGlPdnZQMjFVaE5aeFhpdFRvR1hDZmJrVWVpVlRDTlFEdlhR?=
 =?utf-8?B?RFpOdjhDRUp3TzJLQjJieTByNXR2L3ZyN3lkVUtnc3FVUmpiYmZLa2VzN3RJ?=
 =?utf-8?B?RDhhK0QrbkttSWNBK25Db093MEthd2ZEeS9jOGNybnBYcXB3TkRGcU56WVNS?=
 =?utf-8?B?b0p5Q1BiV1Jpai9tbUFobmNENnFQa004aHZYbEZyY3lnaWdnSktVQ3R3UHha?=
 =?utf-8?B?YnN0MTZiS3ZPNXRQemVkVDkzd1Rub25FTWFvNzZteE5tSW04QXlDdERwaDZW?=
 =?utf-8?B?SHNDM294ZDNTNXYvQW4ySEZMWXMwTlJnUWxEVURYR3h1dFJxRUZ5bWFUa2pt?=
 =?utf-8?B?WWRCK3EzajBIT1EyU3hGTGdxcUJxSmRJeFg5QXY0ckpqOHRwL0ZWellFU3FP?=
 =?utf-8?B?UDFnSTRreCs0OENJZndNUGNuK1lrVHZJZTZXTzRYNjU0OUNrb2ZpU04rL3Zt?=
 =?utf-8?B?VzhubkRPeldzd2Rrd1V2WitUTXgzYWtzYlJPbHpXMzFFUU9zZDNFU0p0TVVK?=
 =?utf-8?B?WlQ0TmdaRS9RU2VDLzF5Sy9LbUlKZys4dDV0L0xMY0lWKzNUbVFWZXlvTldy?=
 =?utf-8?Q?tZJaDY/VPfMVcYzY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce2346e-937e-44f1-be34-08de5e447e52
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 08:09:00.7204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9b6wPp11j7uG7XezvLey9KP6gmuDWi7kxteKyepTGSzbfQ/9ApknzhKO55pnLbj2w9ISRLL6NjvGwxPv1W+QnESmMWhN+ti5cB3Zywoqjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5179
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


On 19/1/2026 9:55 am, Brian Sune wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> src variables not longer defined, fixed by srctree
>
> Signed-off-by: Brian Sune<briansune@gmail.com>
> ---
>   arch/arm/mach-socfpga/config.mk | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/config.mk
> index 2290118f747..3909d399895 100644
> --- a/arch/arm/mach-socfpga/config.mk
> +++ b/arch/arm/mach-socfpga/config.mk
> @@ -23,7 +23,7 @@ socfpga_g5_handoff_prepare:
>                  if [ -z "$$VENDOR" ] || [ -z "$$BOARD" ]; then \
>                          exit 0; \
>                  fi; \
> -               BOARD_DIR=$(src)/board/$$VENDOR/$$BOARD; \
> +               BOARD_DIR=$(srctree)/board/$$VENDOR/$$BOARD; \
>                  if [ "$$HANDOFF_PATH" ]; then \
>                          echo "[INFO] Using manually specified handoff folder: $$HANDOFF_PATH"; \
>                  else \
> @@ -44,5 +44,5 @@ socfpga_g5_handoff_prepare:
>                  fi; \
>                  echo "[INFO] Found hiof file: $$HIOF_FILE"; \
>                  echo "[INFO] Running BSP generator..."; \
> -               python3 $(src)/tools/cv_bsp_generator/cv_bsp_generator.py -i "$$HANDOFF_PATH" -o "$$BOARD_DIR/qts" || echo "[WARN] BSP generator failed, continuing..."; \
> +               python3 $(srctree)/tools/cv_bsp_generator/cv_bsp_generator.py -i "$$HANDOFF_PATH" -o "$$BOARD_DIR/qts" || echo "[WARN] BSP generator failed, continuing..."; \
>                  echo "[DONE] SoCFPGA QTS handoff conversion complete."
> --
> 2.34.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com> Best regards, 
Tien Fong
