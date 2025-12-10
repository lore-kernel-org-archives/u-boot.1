Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CABDD3B9A9
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 07:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C66F283B48;
	Wed, 10 Dec 2025 08:34:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bGtlevf0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C1CD83B4A; Wed, 10 Dec 2025 08:34:46 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 113EF83655
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 08:34:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUKj9AnAn+7De2k4EpqnNEGNCXXsqJMsD/guMnWpiBSo7IEJnHmtwFn41PdfEeTqCTfT/cf84XIqbuBIzWh9vKejcy9mSlA6fk8ZXJKbF41lvqtqYY9MqJuxuZHJKSYz9aQ6vChd4c3qV0rGIzTlcj4Wt5oVIJpUi0e3TgIwjauZiYZyRJWI5EircTfiOiH+PeJnR1as8pGBbsL05ImYX/T/j3CiAboMDEvYnl+Mpjh4taugQdBjadpX5ts5Ff2JeWUHRHsMUgJU1ePh+w/kGezKaem7oLIh4jzhnkCThOeCQIb2xMKqVasjOiPQxWkOy4Sq9fDgKVyJRCgwET8pDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXNBcexdKEW90t6/r+oRMNYqPq8Wj9LyvmSgA6f7AQU=;
 b=STUO+vkPS0ulEFEbnroDg3nzTIqsk7OmKmojnylupQK+ipG4WhrDorKofLWjPzlGQMzOycl1SadJM4FVf48MQmZXWCj8hbmDBIjs9GmdlYGmEyopvk9F50zf3tsPZjxb2apiLaeogNic/xts/Ba9PXZZgupEMsA9qlLsHeOZN1L92F83TfF4z0QD3ln3jze+ZYl/d+rewx2NkuxJjwX2LT++NtlSvLxCjnnngxLQ4T2xuIaTHKylsifSagMrDoIedvMeoQFppDjTOYO3CFFvka/zO/+wz3zI5xq8P4dyQ4k7nvbJPduwg2VGynqAdGATY0pJDS2z+1AFu4Hhnr/JLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXNBcexdKEW90t6/r+oRMNYqPq8Wj9LyvmSgA6f7AQU=;
 b=bGtlevf03313rxtiRSShfm9HJudMD/+xHlVLAk06UziB7E5lG63zPCxzX9ApPxHonabwQWPKY7BwZ4aLFStxtUTbeTN9UL6K597OpkiH/y+627o7sdDnduGNPLLxHpmpcU/s62VHtnUKwyWVHTvtE6io2nync3L1xPCLP7Bql7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 07:34:40 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 07:34:39 +0000
Message-ID: <42b9e2c2-fa18-4d74-a2cc-32d5621a96f4@amd.com>
Date: Wed, 10 Dec 2025 08:34:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common: memtop: Update the MEM_RGN_COUNT macro to 64
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <d9f73d26af832e19dfd79a4b7bfcf09c498a4873.1764169780.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <d9f73d26af832e19dfd79a4b7bfcf09c498a4873.1764169780.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::22) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc979d5-2b15-4ee2-f3ea-08de37be93e6
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVRaQUIvWVhtemN2dDl5VXB3RnhOMitEellVSTJNVFlnZG0yc2tKY1JhdzdH?=
 =?utf-8?B?alEyd2dYd2NSUHlBVTMvWS9jQWIrbEVvOFV3c0hHbUE5aXAyRC9XaWVYWkI0?=
 =?utf-8?B?Z3pHbzJyQ3c5MVlUZjdoS2FEcm5SaEhoRzVmU2l0bitMaXNiVmJCUWN3TnlP?=
 =?utf-8?B?UzE5SXpZekdwMjBLYnNRTGZ4VENBY3Q0Q3NteW11Z2tWYmVyQUdhRUlxckNL?=
 =?utf-8?B?MEJKT3pJYnFmRHdtaDFDVnEvTy80VDBzdWpxUDN2RTlaRDl4Q2pyNGQrdnVw?=
 =?utf-8?B?aXFBeDF5cE43VWZacDBLdFArdWJ3RW80dGN0N3RXU0pWRHZqc0pwcXllMVJa?=
 =?utf-8?B?WmdMSkdaa21KVEFRNVEraE9Xdzl3Z3Q3Y0I1RXhxR2xFbGNyc3djWktKdnMx?=
 =?utf-8?B?WXEvUkpwN2x6Q214WXV6VDFCVHpMd0RGYlAyY0E2VERFUGs1bW5HaGVKMEVS?=
 =?utf-8?B?aW5UK3N5cDA0TFBRVzRWTFpNa0ZsL2RMdEExYkJ2WHd1Vnp3MDFrcTdvUnFR?=
 =?utf-8?B?MnRTUE1iVU42dVRRZEdENFRWL0JoYjQrU0R4eHJsNXk5Z1dIV0hFUW1Yalhw?=
 =?utf-8?B?TjN2Y09Qb1cvdUU0OW5HeTE0Ymh4R0hDRUdDcEtZWFIwZkpUZ2lyUlI3cWs1?=
 =?utf-8?B?cGFpMHZMTDVmQlhQMks0eEEvWnV3dXhtdUdPdkEzMjROYlFzd0xTdDR5ZEdM?=
 =?utf-8?B?OHFiMlczVXFTcmNiZUpGZXp5bE5oMU15bVphMDA5RStHK08vUWV0dUttQmRs?=
 =?utf-8?B?N3JYSTE0N0txVy95emF2RmNEQWxjOTVWRENYYWhTbzFtZGJNdnFOdElXTUY0?=
 =?utf-8?B?VEo2cnV1a05pUi9nR0ZkQTBIRkRkZlNHTjlhZWM3bmhEQmh1MEVMR0w5MVVB?=
 =?utf-8?B?K0pYdnRXbXhuYmdYZHROdTFsRkc2aVEzM0xnU3FlNlhlMTRiN1g2U2NQV1Zr?=
 =?utf-8?B?ZytNT3l0K3FUUU9BZ1hkQkJ0WWVURHRyZHZESE9CTEhLVVpMNXpDQ0tENnU4?=
 =?utf-8?B?a25HMkp1RjJvZXEvdDd3WDRQQUFrZE15bnRoUUEyZUR4UkhtYld6SFZCZGZI?=
 =?utf-8?B?NXVJOEw0NHF5dHMxKyt2Vm9XSzlwb1oyd3NKeUtoNlZycldDTXJwRk9KWlN4?=
 =?utf-8?B?aHZyTllOTUNaSFBzOEMvaEhzbkJkTXUxV3ROUi9OcHg0RmNFalFIVUdXSzlp?=
 =?utf-8?B?c3c2WGNidWFvR3ZEV0o2dWJZUVJiTkxxZ2NmY1V1K09MZ2NLdmlYSThoZVVK?=
 =?utf-8?B?WDBaajFKS1BSRmJnVUdGYk10WlBzaVFlQ291WkZVeGdkYlBXL1dVQkl1bVZD?=
 =?utf-8?B?cDViSW01V1M5YlNzQ3RNdWdqNVJ3bm1SNlVqUWM5dUtPV3U0STdmNzBhNS92?=
 =?utf-8?B?cVYxTGFiSHI3OVZ1TUoyalk5SlV6QU1CNC8rOEJGeVFoS1hKOEo2TEtpSnUy?=
 =?utf-8?B?aG5YbGNvODNIV09TeGVOb0ZWOThJdGtzVFN4QklsakdpdnRmKy9YS0psRFBR?=
 =?utf-8?B?a1ZnMDZpc2ZINjJ1YnBBdHBrOWFLdENMbVZYYjI1RUVQU09OMXBIZXp5VFM0?=
 =?utf-8?B?OTZtODRWSUo5djkyV25VSmhESldkUHlvc3llbUc2d2hVWjFYS1M3cXkxZkUw?=
 =?utf-8?B?aFBzMG1pU1M0QVlTczBRUWtZQUZwdC9VZWRaTnBEUzRmT3FNNk1iYTlaNVlE?=
 =?utf-8?B?QXdsbGk3cTlnNDl4aU90TlNSQXR2a2JZMUthZVJlMUduUTZ2dTVxMkRNSHNu?=
 =?utf-8?B?dG4xM0JoeWMyeTJxUFVvVEF2Tytlc1hvelc3cmRNT1IrT2xIZjJzamVNR3RY?=
 =?utf-8?B?cURONzF1L3hGTVEzRndyblpTUGdGSVJlS2sxbktEc3B4WkZIdkNFdHZBTWtL?=
 =?utf-8?B?SVZDa3V0TUVjOEZrNVNhQ0VYcmJmOEl6UXhkdzAyYjc0Rng5NTJEbVdEOVhL?=
 =?utf-8?Q?msAyCRyNvQgDLGbvePafCuOji+UXwei8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0w0Tm5SbTY3YXlrWWhmd3Yxb0MxK3lsTjQ2dUtWRytjdnFzdjFyUTQrY1RM?=
 =?utf-8?B?OGo3RFpPYTJ2MUN2NXR2dUNNc1hwR1BKcU5HVzIvdUFDdVI2SzhFcnU2Tllw?=
 =?utf-8?B?a0kzWkwvR1VqZllRM0pGWkJZSENSaTR3Y1JFTkV2RUc5dExPSmZpSHhxVHlM?=
 =?utf-8?B?cWI1a3dCZHhQM1ozL0tyTUJXUkp1eEJDTERVNzBqa0t4ZmZNak5kMGM3SEh6?=
 =?utf-8?B?dWhObGxhanV5N1NqUm5GOTQ4YXZScjhOeVhmUTlacXpQeEpkaTZQRG9hdHNW?=
 =?utf-8?B?MHNEWFlPcml4eXJBeGRwdDM1R1cwZjJkanRzQWZGNmNVVzF1S2dPejQ1dnU1?=
 =?utf-8?B?dXZuSVEyYkNKZTZWS0Q2SWVrSGYxWGRDOVlFRGErSGFoTExhVHhScUw0c2Fm?=
 =?utf-8?B?VlJDRS8wTngyYkd5cm8vSVJrVmpvTjU0VlR1NDFsZTg1MzRvTFhHMm9wYVBh?=
 =?utf-8?B?QmRRUVBsRDJwaFFyUmd5eXVocyt4d1VRU1NjTDZoL2pFTjJtNWhOZjlNdnBt?=
 =?utf-8?B?eTJtamRSRmR2NTU3TEVpRTNtd0FlWXNUNnlPTXJYTkh1c2xQTFpTSG11WkJK?=
 =?utf-8?B?cGJrRWJGMlFGazdzZWwxbmFGMm9YNC9NRDNoVldCZnVsK2xPVmRaQ0hNMExM?=
 =?utf-8?B?UVFDcVFOS1d0Wk1OSUVIeTdVMzVLd0dIWXg3QjFQcGpCM0NGT2tzcDMyRDRw?=
 =?utf-8?B?UGVMTEs5NEFGZUl0MlZzRmtGc0tWR3FUWjA1VzRpRnNWZDV2anZHaG1HbXF2?=
 =?utf-8?B?ZklDVjhDQmhwWGpNcitnOTQ3QlpwUDh2U1hJaHcvTForNEEway9LRTRmWCtv?=
 =?utf-8?B?cWc0eDg0bWlFNWsrRldBR1pNdFdGUTZ2Y21GQWFPb2FycDZBYTBBS2ZSZW4z?=
 =?utf-8?B?SndIUllhaUFzR2JCejdXdXkvRDZQZFF1bTVNYkg3bktCWnlYQXVkWmFKTEJk?=
 =?utf-8?B?VTVqNzNuRU5WUjk2MVYrL3lmdnEyN2tUT2pTOFJjTWlEcGY0TWJUMGNyeVIw?=
 =?utf-8?B?RmNSNlVLblFZVkZrVjVjMDJKU2VSOFEyb3E2UEpPSWRsNThFa1JVMytPV3hT?=
 =?utf-8?B?TlhSbUFTcGdlaDgwMDNVNGE0L21XVHVsbzNFTFR2elM1bTdBWUZYdjQvSi9h?=
 =?utf-8?B?RUxaQTAxQjlRdGtDak82eXJPalpYazNmSTlpNFdwaEFoM05obkE2aDViNlh1?=
 =?utf-8?B?OWtZTHZ0UXRrUE9iMktYK3BHaDZXOW5hVVdzNVV1NjMwUk41R1BPMTJSOHVR?=
 =?utf-8?B?NEVQcnkyaTN0Tk56WnYvcHA3QlNkdlAxVzh1eS96TU80ZEtHVldSOGU4QTg1?=
 =?utf-8?B?aWJhRjAvODF0Z1VYOGZMQ3RKc1JKTkMxTzZrTHNIUE5OZ1JMazcxQjhZU3JN?=
 =?utf-8?B?Q2RqZzRVK2JRdkd4VjJXK2NlQ2E1TWc3MXdUSy93b2FzSWtvZTIzWjdSR3gv?=
 =?utf-8?B?Yk50Z09lNjh5MWRhcjI0Y2JCU0pMN20xbnpaVWxTTTg3UFJzSDBpd296RFNj?=
 =?utf-8?B?WGcvZ29GSm02MElxQUgzVjdzYkZYL1hYbzJDQ00ydGY2akMzUThxek5ZUXlQ?=
 =?utf-8?B?Q0pqV1NsRUFjREFpa0VtVUwxRW1yekx3Q1lBNXRPQnFqdHI3WGVaVXBTYTk3?=
 =?utf-8?B?UUVHOElEOUpuREFEZlhSS1hwWW5SQ2FwMTJEVnAvTnV1UGdQekxrbUJGemlX?=
 =?utf-8?B?N3R2OGRNQWtYeFZXaW9tMm0ybVpoR1FpelRIOENJTnVSS2xXU21uTTNIdnZX?=
 =?utf-8?B?QmxHN3ZDNXJkdkxIUHc4bGk5RHFUSllTSjc3QTcxeGpVS3VENWJZYVZ2S0pp?=
 =?utf-8?B?WEcycFE0a2ZBUkE5TFF2ZTAvdFZjMlR2dXcxcHBpNlZrWFJqTE9xYkhjektw?=
 =?utf-8?B?K0NPTENHWUtvT3d1MTF1b2dmZW1tdjh4bmlVV1lHNHV1VlhLbUE0RjNhQWU4?=
 =?utf-8?B?YnJsQUhtUTRybkNVQ0Z4S3R3RUthUDRMSUpvM2hKZlFCSUFJdDJlYUV2ODFp?=
 =?utf-8?B?aUY5cVU5RVZ1Z0dkdXY5Nkh2ekhlTkRDOXVrN1VTR1gvTUNpT3B6dTgyOWhC?=
 =?utf-8?B?VkZydXJvUkpSOVoyMndUUEtaNkZzUXVJcTBOV0lFMXBhVUc3QURKWTNvdzkw?=
 =?utf-8?Q?GiSsJSkjrYHgVwKNBSdy0SlsU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc979d5-2b15-4ee2-f3ea-08de37be93e6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:34:39.9248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+XZvw9cGO+YIf6otcn5ooVmEJXd/sClyuIEMZQDuyleewR61PjYD5S6WAIeZ54r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112
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



On 11/26/25 16:09, Michal Simek wrote:
> From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> 
> Crashes are occurring due to the number of reserved memory regions
> exceeding the current maximum limit of 16. It is recommended to
> increase the supported number of memory regions to 64, as newer
> platforms may utilize more reserved regions.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   common/memtop.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/memtop.c b/common/memtop.c
> index bff27d8211ed..8ad394193f35 100644
> --- a/common/memtop.c
> +++ b/common/memtop.c
> @@ -9,7 +9,7 @@
>   
>   #include <asm/types.h>
>   
> -#define MEM_RGN_COUNT	16
> +#define MEM_RGN_COUNT	64
>   
>   struct region {
>   	phys_addr_t base;

Applied.
M
