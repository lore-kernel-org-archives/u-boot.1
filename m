Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328C4C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 08:28:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A633180077;
	Wed, 26 Feb 2025 09:28:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aQe3ywlZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB52F801DE; Wed, 26 Feb 2025 09:28:48 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1E108004F
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 09:28:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHIpW/t3I70yjMWWGJIQ+/l2eoTXLwkeV3BCkpw9jPopSmRuESmiJ+bpeCzTg4aN1WVraELsBq5eAJu+kg9ZiDMbpj6Lz4BUQ2y6ZkGSqeUqJNQZKaxTPlKtoUVwVdiYntLDjMfhVS15BQ+aLR3QihzBUr0qmCxEmD/+AJYz1ponWyXLxGTYiPZf6HVp15XpJXbKSa4oAC+ZyOCkNheaQM+bCwFYbdv+Bu6/KWvimyGLA2rE6qvYf+J3es9mGME3PELMc7vUJfs+R0y9XcPSoMxg+N+6xgEAKRb2ZC7JKKaxKXVJqWUxE/mkK5xt/U2SkSlbeiK0UGpV36O0fpmztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rA01IT/nr8YlkBIot9YWLapV2wwPUjE7+9ieo8Y7II=;
 b=ulxzq5o00JsN98+Sp0QOVWqavNL7Yck1G4N0QGOHA2Sfk7Le099keBxtZ6aoVleiLXWdFhAjwyFmgg7P4+2NTiy2h7TV3CWlSuoFJKh8mbt8cfa4o6ohzAPSEetcST2L8NXrf35Y4SQ2KlbMGoKAjjg55ED6hQd/tRwV1vSy+yA8N+6u/lgF3vJhatIqSJsMbwUX28WC0rLzb27o5BI1ADj1GBvYgVmdNA+KPCRdP8GHCNLGGir1u3J7WVbXNvnovdH9UgeP0xcPEtFUb2ZMZ6+pAISIbQPjH6CVFZbEiyiE8hQUAwpSBA86KShrSnc4HnBtfJexhzj8lX8qcgCqcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rA01IT/nr8YlkBIot9YWLapV2wwPUjE7+9ieo8Y7II=;
 b=aQe3ywlZyz7O7KAX2aglqJ4WpFwARnKJQFElYyQbSp+A3x9ynmZFHE7mHF1QsZAOIGgwNF2kLqwDJrPolVYUnFVZCgha/Ipph4cZCC/HBfD8bVpHv2qNozYrjZtt+gBGrIeDXdFD6SmYtHROVk53DqpXYSfkQ0pdfmGVJe3m6cw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BN5PR12MB9462.namprd12.prod.outlook.com (2603:10b6:408:2ac::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 08:28:42 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 08:28:42 +0000
Message-ID: <61343d7f-d372-495e-b5b3-0bbe14d05a4b@amd.com>
Date: Wed, 26 Feb 2025 09:28:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Halting auto-boot process in the U-Boot shell
 https://lore.kernel.org/u-boot/20220614060203.33600-1-heinrich.schuchardt@canonical.com/
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 "Kummari, Prasad" <Prasad.Kummari@amd.com>
Cc: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "Begari, Padmarao" <Padmarao.Begari@amd.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>
References: <SJ0PR12MB66857BFB90475FE74294CF0482C22@SJ0PR12MB6685.namprd12.prod.outlook.com>
 <e1cfde30-ae7f-4ae8-9845-0c13eaeae87f@canonical.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <e1cfde30-ae7f-4ae8-9845-0c13eaeae87f@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR15CA0011.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::28) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BN5PR12MB9462:EE_
X-MS-Office365-Filtering-Correlation-Id: be1dd164-378b-42ec-eeec-08dd563f93f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|220923002; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejJzUE1TWDk5aVZaV0EvT1VUUlN6aE5qejVOZ3o0dmVMNVAyWGtMaWVqeklq?=
 =?utf-8?B?eExtWXh0T3hJSFpydUVhVGpqd1BGWFdpRU9TSjBZRmJINWF4dEpIWVRYK2Rl?=
 =?utf-8?B?UmVCcFBpeHJNYnNxMFord01WZmtSaDVTM3gvdklOaVVGYnN5ZlR2ZkVBdmZS?=
 =?utf-8?B?a2MxZ0V1RExMT2dOamVFRlFCeGlEUENidE0rczB2cFZobDdNeXl4dWlNREVF?=
 =?utf-8?B?ckhmM0tJQ3ZyTFNjWENOQW5jVkFtemVQUXJ2ekdXNUR0aFJXR1g3OEZCNUMx?=
 =?utf-8?B?T3BEazA1V1RGN0FUYnpvb0s4N1dnUEhMQVJJMDcrZ0Z3YTVvcHBTSXhQQlYx?=
 =?utf-8?B?R3RhOGIrek8wMlQ2dWE4M1kzemJ2ejBzNGFMNnlJL1J5SHZMek1HUy9NY1pM?=
 =?utf-8?B?YUlUZjZEdVlDSGp5NXJON0dwVGFmODFud2JwVWl6c3hWcTYzZTZFV201b1pS?=
 =?utf-8?B?U0cxTTh3SXUrd1Qvcjg2ZnJBeWNNNlJBVXBvckwraEpQTVRtZHZvNXFpcDJS?=
 =?utf-8?B?eXVDTmZDeGF3QVRrQVJpOXkvMjVtQ004eFg2WnRtekJnTjhCSWJvbW4xVjBP?=
 =?utf-8?B?Y0RoRzBOSVBpSXhFVlAwWnQrNjFxK1VWSzZsVEZ5RGprWm5sWmxsMnRUMElz?=
 =?utf-8?B?TTZueVA3Q0Q3bzZlcTFWQU82MXU3aW9QWG9vL1AzbTd1NEg0cWlwMjJXQ3Ft?=
 =?utf-8?B?MlZOdldETFpqSk44UkRPanhqY2xEdGYxTkFZZFFiODRWL3RJNTgweEdxL1ln?=
 =?utf-8?B?V1hIOGRrZG1QR1FnRUFFa3dsdmVvbEdOTTNOYjIwMjN1bkVlUndDdHFxbkJt?=
 =?utf-8?B?ajVEeUlBeWNvZDBJbGZUSDZDQ0NVMUN3Y3greTRrRHM4MHljWmZGajVjUHpa?=
 =?utf-8?B?a2plV2QxaldGWUNjQlBESDhhQlBrUnFpN0hiYVdoNVJvQjlKSS9WcG40cTJp?=
 =?utf-8?B?QjJieWNJRjEyZHF0NXFra1o0OTk1SnpNTEFhWXFTNWRndUsrdmxxTXdtVklJ?=
 =?utf-8?B?MkUwdmtXMm9hSnJNVnQxWXZkK0NFTzd3OVNXL0NSQ3hJQWw5OEZTaGtJSSto?=
 =?utf-8?B?YXJzVU9RalF0b2xIUWhPNXdkWnVLd0dPME9QZ3BqM1hXRUpLZHorQmpRNURC?=
 =?utf-8?B?eUhFakhVcnV0MTJSQ1NjYnR0Vkd5MHo4U2tNaHhHVXd3MHhyOU52QTRZcXQx?=
 =?utf-8?B?UEZKSFZJQkl4Znc5ai9qTWxwUkx6ZXI3VDBwVnhMUmRkUHdxb2EvSWdDYnBv?=
 =?utf-8?B?RGpsVTNLUEYvRU5QcUhmeHJ5TzVPYll1c1h4ZFFZT3UvOUcvUTFSek1CQlpw?=
 =?utf-8?B?UEN3YVlNL1Bva2R1dEt3cGlEMnMvOXNNRVdiQ1hBYUJJY3ZwVGplUHBWV250?=
 =?utf-8?B?Ly9yc0FlVUR2WWgyZjVHMGJlc0ExWEdpTFV3bHZHRi9CWFYvanlnSWozWXNj?=
 =?utf-8?B?L0R4RDlCd3VnWXBOMlBNZWU3MGpNV0FJeUhCTHNKRVlHbWNGQzF1TnlSa1hH?=
 =?utf-8?B?OE92Zlp6Nng1eTUzYzBhV2hiZWphZW0zaGQxZWVWR3FEZDhyNnNmT3JPcUc0?=
 =?utf-8?B?THZUejdnRWRmTVZzbC9SNTFDSmhnKzFwTHRrb1hZWlNTMDB4NTdhRGdTalhS?=
 =?utf-8?B?dkJOYTBRaW5TTWx5VW9kTHRMOENRaXJSSjdCM1FaUjg0OFo2TUdreGtHTktV?=
 =?utf-8?B?cUJIQXdWOGtVNmxXR3FBQ3dBQURZWEhCRGdFVTRVVWtkTS9yY0k0ZXBGU29S?=
 =?utf-8?B?SkdCNGt5T0JaRk5QRWs5N09iZEtwaGdMdlkvTVFET2dWTDJONGtSNXl4elVY?=
 =?utf-8?B?cFJTTGVJcjIwaGlMZlF2WFZSRFB5aGFjTjBvRE9haE55a3JUR2pJM3dXSTc2?=
 =?utf-8?B?S0JpNlREdlJmcDQzTXlMdGllaEJkL08wQXdBM3lXdkVhT1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(220923002); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkJ0eWErSFk0YWV4S1FDSG1oZWRqM0Q3dkpYb2hpOXFMUm1GS25yTVBPTGJC?=
 =?utf-8?B?b0JNY1lZZ1dTYkpxdndFam1TYXp3Smo4eDBhQ3hHQjZnNnh6ejl4OEtpcFlS?=
 =?utf-8?B?OG9kVGUvcmJZQWRxQnB1ajFUeCtsbnZCNGlQM05vS1BLck90Mm8rYXh5ZE9C?=
 =?utf-8?B?MUVpaXFqSDlOSThKNWltRml4dGhGcWM1c2Zzb0NDVk5zbmVkenB4aFlpdnhv?=
 =?utf-8?B?dnl6a2Vnb2NrbVVtQlpsRUs5ZzhOWnFub3lWVDRxenRrTi9zSHl1RmYrT1NL?=
 =?utf-8?B?alBzR055b1E0UWZlY01xNHl6OU5acTRUYzBzSTZYQlhHTkVMMXVMZEFaVTk2?=
 =?utf-8?B?WjN6VVZkd0I3Y29ZSThsV2JIL0tIWWoySHMvWVFET0RHeFBvNFlNZUtrM1Za?=
 =?utf-8?B?TVUyMXNSczRKMVVUaHFYUHVUajJhVXVtaWZ4VnRyWGdpQWxBUGJPTmpTQ2xX?=
 =?utf-8?B?TmxMVTlBSG9EaUdQNXI5Mi9UMHZ5NHZINnNYMVBGYjJ3MHNvUGxUV3FISmJI?=
 =?utf-8?B?MWs5WlEweExDeUw0cENES2FBcFRramNsUXJyTkUybkwyUWphWFduWmYxNVlx?=
 =?utf-8?B?SldQb2FPNEdQUzNoa1VRNyt2ZVQ5RERSWTZUVzNIUjBmVjM2Ri9UY0h4SU1a?=
 =?utf-8?B?NEJaYlJKdjQ2eXBjckJvRkg2cmZXTnhsZTI2c3crMjhEbTU0YTFaRHZUeC83?=
 =?utf-8?B?T1lhWkU2Wk9wR3UrM0RQeXI0bjZSU2w4Wlp2UGxXMDJFYzJFODNKY0JYQ25z?=
 =?utf-8?B?dWM0VWhCam4vQUlERnFseEtQRTdJRFA3Q1hJczkzTlB1dmlHTDNxRmV3OTlo?=
 =?utf-8?B?cSt4QzhYcnhsT1BOSE00b0tDVW16ZnFJZkl2ai9pYlNqd0tHZUlza3pLYkFJ?=
 =?utf-8?B?K0hMUGNyWGN0S01MTVdjMGE5RGYvU0cvL2FYL1BEejFDL2lFR09TWC9zN2lN?=
 =?utf-8?B?aW1FQzBBTEhsNmhDVWM4MGkvUlIrcEF2R0lqRE9IcHFqR2h0YUtQNEJxZGpn?=
 =?utf-8?B?c3FEQjhtd3JNMVg3RWp3QXJTZlpFUDlZQUU5cFRCTVhCL2xVa3Q5bDdlSTRH?=
 =?utf-8?B?R0drMEZLRW1EdmZHZ0tyQWlRellIS0tSeGVNbEpyZUd5WTRQTlUrSE9UVktO?=
 =?utf-8?B?eFZXay8vQUYrZFRsK2FldS9tQnA4SFhvdTYycWp6aEl1bklxTG1RY0xMdTMx?=
 =?utf-8?B?dUthaWk2M2RzdjFFeUV0eGpoOE9sMnlaUGNGWTZlaWVVN3E2RmNoRWt0VmV0?=
 =?utf-8?B?Y2pxNGpVZjg4a3YyTC9aL3dZdVE1SkNuRWNLT1ppYWM1aXJlaFNIQ1NjcjVK?=
 =?utf-8?B?UmY5ZFh4OGh2c0V5T05reFJrKzRJRDBrckZtZHljQ3M3RS9kVnorM3Z4ZnJT?=
 =?utf-8?B?Q3pTQUhrVDBpRHpnaVBCSm8yalFpMkFBYTRlVCtkRzMxLzdsR2R0Q1hEcXpC?=
 =?utf-8?B?Q0dYM2VvRUNZYUJEcURnUEZxNmdWejdxQ1liUmJVZ3lROEp0dk15bE5BOXNW?=
 =?utf-8?B?bW13dUQ5dXlxYkpJYXplY3NqcVg0NkUyS2dQQ3ByUnFSMnQ1RDZXbGF3eU55?=
 =?utf-8?B?bnJUZ0pRV0pPRHNWSzZTQnhmRXFVQzg5aWpMbjlPZ1FXVENlRENhVGxXaGNY?=
 =?utf-8?B?ZExiS3FXU0NsaGhNeWJ0aEh4ajZsNlB5bGRSRW1VaXFqMU0rZXpOUlRRTlVH?=
 =?utf-8?B?VkhQcDhKS2FqOE5iNHlOV01rekc5QXNwNGI4SXRPNGthaVU3WEFtbEFYUUxp?=
 =?utf-8?B?c0Y3eUJoc1Zlc3VkaG43VlZHWkNGeGUyMjhkOHVxTlhDbGYyVk5objlQOGp2?=
 =?utf-8?B?dVNidmIvUnIzN0V3ek9weE4xRTlPV1ArSktEekk2SjZDT2I4NGx6Ui9pYjMv?=
 =?utf-8?B?Q1NKUGtjYlUvZmJQUUl2eTNYVjU0VWZqSUJ4RjlYRngyOWhIUjArVjYzeVFR?=
 =?utf-8?B?cmo0VnM1VFNIWlpWdy9jWDdVVFlmcW9WZnJFK0F3R3RTd3g1a2ZRcGc1dUpk?=
 =?utf-8?B?UzFUdHpyNm1Hd1RMVVFETGNUU2I3Vm8vS0U2dUpKVllUa1pvUWRuWk1EYWdE?=
 =?utf-8?B?NzgybGRWUDJaejNzNzlDWHRKM3ZwUy9kTVJ3UjFIdFZubTBDcVppaHdOTnFF?=
 =?utf-8?Q?5M18SJbwcKSdtj8St1u9cEB+6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1dd164-378b-42ec-eeec-08dd563f93f2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 08:28:42.2784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gthOjKBTKaYytfeZ9CWDUVG/GIa5fPX7+LTKZB7KG2Ii9+4jSJdbFqTH2A3wjenA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9462
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



On 2/26/25 09:23, Heinrich Schuchardt wrote:
> On 2/26/25 07:48, Kummari, Prasad wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>>
>> Hi Heinrich,
>>
>> Regarding below commit.
>>
>> commit 68edbed454b863dbcd197e19e1ab26a0a05c7d85
>> Author:     Heinrich Schuchardt <xypron.glpk@gmx.de>
>> AuthorDate: Tue Jun 14 08:02:03 2022 +0200
>> Commit:     Heinrich Schuchardt <xypron.glpk@gmx.de>
>> CommitDate: Sun Jun 19 15:53:09 2022 +0200
>>
>>      efi_loader: initialize console size late
>>
>>      If CONFIG_VIDEO_DM=n we query the display size from the serial console.
>>      Especially when using a remote console the response can be so late that
>>      it interferes with autoboot.
>>
>> *    Only query the console size when running an EFI binary.*
>>
>> https://lore.kernel.org/u-boot/20220614060203.33600-1- 
>> heinrich.schuchardt@canonical.com/ <https://lore.kernel.org/u- 
>> boot/20220614060203.33600-1-heinrich.schuchardt@canonical.com/>
>>
>> Commit 68edbed454b863dbcd197e19e1ab26a0a05c7d85 modifies the system to query 
>> the console size only when running an EFI binary. However, when 
>> CONFIG_EFI_CAPSULE_ON_DISK is enabled, the console is still being invoked, 
>> which shouldn't happen. This results in issues on our terminal, which cannot 
>> handle the resulting characters, leading to incorrect display and halting the 
>> auto-boot process in the U-Boot shell.
>>
>> *Log Output:*
>>
>> Warning: ethernet@ff0c0000 (eth0) using random MAC address - ee:df:0a:38:a8:c4
>>
>> eth0: ethernet@ff0c0000, eth1: mrmac@a40f0000, eth2: mrmac@a40f1000, eth3: 
>> mrmac@a40f2000, eth4: mrmac@a40f3000
>>
>> Cannot persist EFI variables without system partition
>>
>> Missing TPMv2 device for EFI_TCG_PROTOCOL
>>
>> Missing RNG device for EFI_RNG_PROTOCOL
>>
>> Hit any key to stop autoboot:  0
>>
>> *Versal> [42;173R*
>>
>> *Unknown command '[42' - try 'help'*
> 
> Hello Prasad,
> 
> The terminal emulation seems to be sending a valid reply indicating 42 rows and 
> 173 columns.
> 
> It could be that in your setup you are hitting the time out in term_get_char().
> 
> Could you, please, check what happens if you apply
> 
> --- a/lib/efi_loader/efi_console.c
> +++ b/lib/efi_loader/efi_console.c
> @@ -92,8 +92,7 @@ static int term_get_char(s32 *c)
>          timeout = timer_get_us() + 100000;
> 
>          while (!tstc())
> -               if (timer_get_us() > timeout)
> -                       return 1;
> +               ;
> 
>          *c = getchar();
>          return 0;
> 
> If the failure disappears, next you would have to analyze why the timeout is 
> occurring (e.g. timer_get_us() running too fast).
> 
> If you still get failures, please, add debug output term_read_reply() to 
> understand what is happening.

But why is this send at this stage? Why capsule update needs to be aware about 
size of terminal? I understand that you need to know it for efi application but 
what's the reason to know it capsule update?

Thanks,
Michal


