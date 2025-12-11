Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E90D41D65
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 16:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2ABE8389A;
	Thu, 11 Dec 2025 17:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="VTuerCWN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29CBD8309A; Thu, 11 Dec 2025 17:17:47 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CB9F8389A
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 17:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kq2KmnMl56Nddy+2Y9xbxnNzT6dN93Hn8QNr+G4bMFHGRv2cRiZMH5ZJ4x7hls3vyTrcub5RNEH9HCBEnAxq6Vv896hFeqseDYA10rSRJTAIQCjI48qKmrxIJMCcCayE+0V/4BFSO+jTn1wBnMtuOUwUy/vUgTfBy4+SONtGjNoiyS/8w6A/hP2pp3dDmM4wT6SQZ4XmsyfH4q7H6KefUGA85EsNAMaCAAeyQshXzbOAfAuT4Twsx9NlnC/iny6lvPov067hNk8RiRzeakB3UcMCXfz2bdhVWmgVbmgmujnKV8hETjYCIs5iEcJ57BcWadedokGCib91k/DrmZ/msQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDuSLcYc9HGg0kny5cLf3851bQKZOlV56nPFcz53EPA=;
 b=PCLKkrIiHGPfi1KIUtjiLoQK3lnRZSjfy7lIcffA3kHAvmfOg662QrsEWCM/NsMEqUEIFvp4lwh53ifwj34ZV09zTljI+LZ2IJqf4RpwceS94stJmkH6YgNvRl19A2IeqhhzMFOeO6bE+0e1KrlQ1j4S3wN0Ma75Hc6Y0dhuDxIp4x9VdRB+oc1bc4Dr8Bnv0fQ+dEV58oOe1KiGOVrzJXK9NEHVavfogltKo9eG2Es4tCxHCmKYQCtLYfcAZAb9m+qZuEawDr4j2UAlF0GcmgW9OsCF1yzxGrDcJ0htfyOcpTE+8SRuvnZSOunvYAq6RCCuq5iNLodDbOYqxiGQNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDuSLcYc9HGg0kny5cLf3851bQKZOlV56nPFcz53EPA=;
 b=VTuerCWN43AilDo6L6dnaSMcd0ITX+CMyk/XOZD9RlZYMLKFVogRf2p9ksP38Y9tAURYAuko0kCkREekWvIlpqF3SuiDrEuJhCeXdyFnTGIoeMO0+hyjiaV/Q1NUCeaNAoFjyCcSGlTbFwfFGvmT5LsYFZhU9ncjeApuTSdPkuz8/tkuflbdpE4HBAwdm9Xf0IUyWCIoc+quJ/OM/8mZ42cRqwjmLt8vQgbHiH/8sseXXFSAIsENmtLJm88j2yh7YnJ01w9FGB0rTzmIsTvsHijQk3Eru1rPvkBMfukkIJoES9bElvoHZUk/1nm6C8YBYswYF7v/LmgC89YgGJFWCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6537.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:81::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 16:17:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 16:17:37 +0000
Message-ID: <5a8e34ef-9643-4a88-b40b-e8e57cd7a607@siemens.com>
Date: Thu, 11 Dec 2025 17:17:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] arch: arm: mach-socfpga: Adjust a raw sectors for
 MMC loading of U-Boot from SPL
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Sune Brian <briansune@gmail.com>
References: <cover.1764574369.git.jan.kiszka@siemens.com>
 <1046ae695f78304d3e756d2ff3d08aecb0d6ab2e.1764574369.git.jan.kiszka@siemens.com>
 <CANp-EDbL8M=PqT0X_vvHSYmi_9ErR_1oeLO_qs9-3JinA-eiFg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CANp-EDbL8M=PqT0X_vvHSYmi_9ErR_1oeLO_qs9-3JinA-eiFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f71aaf4-4830-4f4c-9ab0-08de38d0cca6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2hrWTRmNHMyV0x0bitUZnZ2MFRqUWN5Yzk2dTBMYUpFb1BnQngra1dnM0tm?=
 =?utf-8?B?T1RjQzRIL3JZUEF0NGhkdjYweFhjSW41ZFV6enpRczNIYnpkYTlPVnRTNFp0?=
 =?utf-8?B?d0dJRzdYOEx4czdLYW95Y3lIbm5pVHQraWEwOWRCSi9mSmFLY3JJd2dHZnJu?=
 =?utf-8?B?U2xPamRxOG9LMWIxN1ltV1hlRVd2MEJ0c0tBUG5MaE5QczFEeVNMSkErT2hK?=
 =?utf-8?B?VW9Pa09CempNNUNqOG5LWkJ2bVBIMTJMUjAwOTJyZUxDUlRpc293R2grL0hZ?=
 =?utf-8?B?SUtWa0ZrYityMldLUlJDVUZvSzNFazdoUGlLVmdlSW9vTDEzR1Ava2NxZUJ6?=
 =?utf-8?B?YTVHVEpQQjM4OGpOMHg1TmtvdzVJQWZiWEl4ZS9qeHdFTWJpTHVwUlZqYmVX?=
 =?utf-8?B?a0p3Qnc4ZjZLbElkQkI2MEdOK2dBRTQ3R3BhUERQTWdPbnRuVWNJMUN0cC9a?=
 =?utf-8?B?emUxTFBiUWRvN0ZTRlVVWSthSjA5aWgzMVdZSDNXWTBtRHRqaWZFQjAzODZW?=
 =?utf-8?B?VDNkWndtMEFmZTlQaWR2TVRsWkNWMFlGZlRSTUhOaDZ0UmMzVXJsYkN1TmhU?=
 =?utf-8?B?cGtqNkFtdHFDUHhBKzlNMlNVYU5GWTc5MGg5WlZjZjJidjhKYXVyNHlJWkNa?=
 =?utf-8?B?NHlUcDd1YnhPRzlROC8vRDZDN0F5NlM3OVRIdDUzQkdRUGgwdno0bUVocE9o?=
 =?utf-8?B?eFk0NUR0bkZoNjA2aktoOE02OTVpUHhScXRuUmlOUGdKaGo5SEZBcHRwWUNH?=
 =?utf-8?B?VklDUDR0MDQxNHRmcWo2ZmVpMkxmajc2R3VpaHQyNjR6cUg0UG5sc2pUeFFz?=
 =?utf-8?B?aTZzbGtCeHNrUWJEblZJbFRFVjdleEkybGY1Ylk3V0p6UnRMNml4cGJuL0lC?=
 =?utf-8?B?S3c1b1VIcy92OFI1bEh1RG9xQ3R3SlFlcngyRHBGaTZsMEF0WDlqMlNsNEJS?=
 =?utf-8?B?NCtSMzduNkhhS1pXMXorRmF0U1pMR2pZUmZXbCtPWklWeTRhOUw4aVQzNm9J?=
 =?utf-8?B?cjIrWE5nUTV5STlnRnlETmZ0aEE1SHorWWhWcWVUbkg2QXZpN0YrdGhTalgz?=
 =?utf-8?B?VG55YUN4Y2V0bGhZNkwwayt6T3BqNTN0QkhFZzFPYmR5SVcyanY4UEsvcTRD?=
 =?utf-8?B?VjFvRkpPZjExa1pENU5tbDZuK1BjbHBqVjRBdmRtOTN6OXpXOHVUMVJ0NDVQ?=
 =?utf-8?B?NnJlRHF3dllTQWMrMm5GTEt3ZGdzb1Bod0xBM2RmQ0M3d0RFSDcvZXU5bFlC?=
 =?utf-8?B?UGZiOWtTeFdMZFR4U2htTnc5RFZoekp5OWVtMERTcW9BeGhFWFc5WGNnc1lN?=
 =?utf-8?B?Wk91YTdsR3pybkwzdFpOQm9wQWQ4cGhpOUFmc3J5K3R4aWJnZkdPS21JQ1V0?=
 =?utf-8?B?OWo2TzdiQ01PdGZDdzkyRnV6UTJXK1ZQUDZIUndNdFhGTTUySnRxalljU00y?=
 =?utf-8?B?ZVBrV3hGOWR5ZlMvaW12VnlYV1A2a05yWTNZREtFWkYwYjlUZUhBNXFXRk93?=
 =?utf-8?B?S0VHcXBTMm5lZWkrcXBYVkRDRlVyYStFaW1td1pYWTBhMW1SMkFYZEU3QTFD?=
 =?utf-8?B?cFJpcDRtYVdVbjNxL2VrLzFWOTcxN0dod3dVZ0d0dUFEZHVhd0daSE5ML2wx?=
 =?utf-8?B?cDFGcFZGVFJ3ckQrN0trbWhENEVEVFdkUFU5UW4yOWNrbnpHRUVmdnpWd3I0?=
 =?utf-8?B?NFZaNmVZbXBic0EzSTlBTFF1QU5rdWtaT1JDMUpsL2ZqUUFtcm81bTN3MDdz?=
 =?utf-8?B?KzZhczhGbXBVamRXTUdVRldGanVxZ2YrY1dkelVNVzUwaitKSTg0eVkvQ0V4?=
 =?utf-8?B?c09PRWVRT210TzdxaHBmTTBOcWJpRHBpb1Z3bEFtM1JTZVN6UGsyUitBUFBN?=
 =?utf-8?B?bXI0MFZQQUoramV2TngzRjFzMTcxcDQ1Ry9JV1JlMlJqalVxL3oydkZsTUha?=
 =?utf-8?Q?ZyZDcljvvgJt7aEs77DEZGaKK9d71/Az?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk9CS3I0Ujk5dENkTGdvRmlDOFZtK3dPT2ZKR3JDMktObVY0UkhiU2Vpck5E?=
 =?utf-8?B?RUpiK002NUVKU2xFNm5mUnhmeXo0NUZhbzY4ZlpsRkFMREJIaS9sTzM4ZzZG?=
 =?utf-8?B?LzdxLytmS2N6QWZhVWZzUlNmK3JFRmFyMUE2VXk0YnY2M0pqSm03MDVyR0ZV?=
 =?utf-8?B?WlFYSkFIMjJOaFBZa2lTRWorVEpKMDdDeVN4U0cxU0Q2by94L2dGamE0RTJ0?=
 =?utf-8?B?bTk2NUY3MXdkek5hbm1SRGNVVmNnNnYyUDZCNGl4dlJUaGFZc2xlRFdJRGNp?=
 =?utf-8?B?a1cxWHdoQTErQVk4V2xoUG5EZmJ0MVk4WklvcmFTa0V4SWZyaVZzeHJEMGFn?=
 =?utf-8?B?WFgrRHBrcm1BeTJlVGFVNmdNRHFKK0xFZlR1YVQzc2VyZllSVC9PNE1KQXAy?=
 =?utf-8?B?eml2ZlI5cnhGaXBzZ3pNNVFsV0E3eENiYVNhaWkwaUp6NkpQdmlMV3lieTJZ?=
 =?utf-8?B?QkkwZEk0dWRSUHA3ZTZONzBXdmNUaDRmSVZZZCs4VER3UDQ4bU9hd1I3aHVu?=
 =?utf-8?B?TUV6Y2Q1cUd3N0R6TzM3T3UwenZLMXN6V255WVRXbjNEeTRHVkJab1lLck1W?=
 =?utf-8?B?T0VnZ1NVTWhxSTk5RVR0R29QdVdXem1jTHBOVDRIZE9LWVBBcUdmNGgxbURH?=
 =?utf-8?B?dmpXM1Y5Y0ZhTlNQd0d1amZOMkt6RUEzakQrb2NzMmZLTklwWCtuVUJDcTYw?=
 =?utf-8?B?aWpYU0UxSDdDNGF3dmVOR0Z6cHBlSUxTMkhNZlpleFhBUjRaUlk4KzRVTEdz?=
 =?utf-8?B?YThVVmJ1bElZL2JLMCtyeXVqM0ZpTnlSNUF6RERteXo2VnQrRGo0aFhTWnZU?=
 =?utf-8?B?aG1VN29ZclY1MVpYRkxLVVpqWnpLKzVXMWk2WUJaeEdKWlNoU0tOQnlxcWs5?=
 =?utf-8?B?eVNRNmpobllQSFFsdldJMnF4Sy9KOUhnQ2p5ckVyS2xHK2RWM0dnMlFQZ0Fq?=
 =?utf-8?B?ZzFtRVBEOS9GUUNYR1NNS3BJUlRrM24zb0lPTDhBc28ra01lTG1Vd0ZwTXVQ?=
 =?utf-8?B?LzdZN3hjaStPNC9YSHk1akNIZjF2eGZEY3NlcldCcHF0ZFduRlo4QWt1Ny94?=
 =?utf-8?B?VUV2UFpRcGNGVWF2TW9wbWFDTERULzZEUVdHbE5TbHVZWWllaUdyRGVjbHNK?=
 =?utf-8?B?VnRVZ2t2UW9ZbHNYU0JjbXRyVkVOZnFKWnV5M2hkRi9MREJFRlRXU054MUww?=
 =?utf-8?B?cGRWcDlzOGpsYTZyNXRSMmxOSExWVkpJTW5QYytLNksyeFduYTRIVFRBZ21n?=
 =?utf-8?B?L0gxR200OU1haGdMUlI0a1pzcG9tTUZUY0tzSEVqcHMzZEdLSGlzUHRGV2lU?=
 =?utf-8?B?QURFbWdBUGxHeE1heUp0Qk5VY3NWU1hzNUpsQXZUakI1Z1QzT1BxYUIyZ2FG?=
 =?utf-8?B?ZFZQQmwyRnVrc0ZBTDh6VFF1NjRjbVRXcmkyZmtlN1RVZFZaV0EySkMwR3p2?=
 =?utf-8?B?T2tlcS9xUFU2eEdCdzFabTF2aUdONHNSWGtyd3JQM3lPUWhoV2NuYldtNkhi?=
 =?utf-8?B?OFhTdnZ1cnlOd2p6UjE5WDJ5eDNzWEpwaWlaeVRzWG5JelQ0dTcxd2JwNXBq?=
 =?utf-8?B?ZjV5T2tYL2RzYmZvWW1zZVNDaDVncEtwSkNDMU9DUm15QThwYnlwVlkyYTBm?=
 =?utf-8?B?dmMwMHpnZ1AvZTF6bzJiSGdhNUErNUVQZUhHd2gxY3lGcDV6b0lIeGt1ZkQ3?=
 =?utf-8?B?MWlYTlJpemFuVXhIandOL1BycFlNeXNzbWVYZmp1U1R1YlZYeXhqSGhEY1ZQ?=
 =?utf-8?B?S3FEWko3QUR4c29hV2NJdmkwWGQraXhRdmZGc1JjMTl6TlM5RDc5MlYwLzZN?=
 =?utf-8?B?cTJSTFdRN0JrY2RlaDdkRktsRHNzRmlTSjdvbHVMWnMvMlVMMTJyd1pmd0tO?=
 =?utf-8?B?Z3cxVHZYQ09YMWtxWXdJbXJSdjlzQWg0NUdCZUNXVmo4LzQ4ZE1wbGpSSEFs?=
 =?utf-8?B?VHd5VDFmNUU1ei94alpia1BpZmNFUGZuejBRb3JVVzhCNXl0QzlqZzJ5ZjVP?=
 =?utf-8?B?cXl6bUswcXFiUE5GVnlzNTlEZDJ4L1daeEx3Nm15eTBjR3BlMzFNTW1iTlRT?=
 =?utf-8?B?WVJiMGVHOTVSWUNwY29PM1lCUjB5akNlb3VLaFF3amhydlkrb3lMWlNJdnow?=
 =?utf-8?B?RCt0MVUvYUNlNzJqT2JvRjQwRE5nNWl6amxwVjJJSC9RQVVkNitUeGhCbFpM?=
 =?utf-8?B?blE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f71aaf4-4830-4f4c-9ab0-08de38d0cca6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 16:17:37.3222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBzSF4QL22fQbB1OMoUKdjIbIsLwY/sKxmcx9QhE4utqsSNSwB7ELhmEo4H/MRXskTwyNLQkkjesHhvWBJiBOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6537
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

On 03.12.25 21:32, Ralph Siemsen wrote:
> Hi Jan,
> 
> On Mon, Dec 1, 2025 at 2:33 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> 
>> diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.c
>> index 28554b7a109..0b04f2bcacf 100644
>> --- a/arch/arm/mach-socfpga/board.c
>> +++ b/arch/arm/mach-socfpga/board.c
>> @@ -209,3 +210,13 @@ void lmb_arch_add_memory(void)
>>         }
>>  }
>>  #endif
>> +
>> +#if (defined(TARGET_SOCFPGA_ARRIA10) || defined(TARGET_SOCFPGA_GEN5)) && \
>> +    defined(CONFIG_XPL_BUILD)
> 
> This seems to be missing two CONFIG_ prefixes:
> 
> #if (defined(CONFIG_TARGET_SOCFPGA_ARRIA10) ||
> defined(CONFIG_TARGET_SOCFPGA_GEN5)) &&
> 

Indeed. I was lacking a target to catch this. v3 is on the way.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
