Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D333CAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 07:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A75698328F;
	Thu,  2 Oct 2025 09:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kqNeHvF/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2768080107; Thu,  2 Oct 2025 09:26:26 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCB1C834D4
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 09:26:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGcclk7qN71FNBp9A4BmrfyGHa083hhb4HwbNROSFPKPsIKalUHTungUoiCkZ3PJqltLu8GGF3S4Xp4LJK4iNJ3f9wPrplW5Zi2N773OtEef7fvbMDC+ZLqRbEbIHCoWKRZCgN0IHJnb0YiKAwCvKInXlSKHAqpMmGecWLKphhJ+uBoWqLgmwviXhfwWfPVnOJQ/Xhx+2NsW7CEc5S1OFb6f6g5ULrEt1yoIvlPYP4//cpBF9x7Bew7xrqznbz7h//PEkN/ludLB2dPDfq/HufjblzT3+R0Fm9+wkhg1WYpDnx4p+bCNsFt3rhYbPcio03UibyocLMYjfWi8QGlzIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4ISsov3mp2qRDRiVrq8OgLBpmOWPblJsjmzQz94OJU=;
 b=t2mxyM+lDFdMMtJTbB3q08yhgHjJ5pRDzBiz6wVrbuOMTTZenDDH5/dpwDCzNaTXoafwIX8S5VGqK11bdFOOQJU8RsOEOJgz1yE1hi1Oi+hdyiL9e0XfLiDfTJ5WXLalofLirGF1oRX/9UUseUrpJjQBFur2LpdXntHDQwBC+bN66UPs8Cfi6nR6G4JLrRkJ5eA3bBjV9ZGFT4LpPSLAl3R73lNaTFgY2NkPcUovfRXFtUjwFNqj8C0NaXALGvczT+Lj4F3nLLEkElE1VURXNLXWWS3Z4N7WSaX7Pli5baUH7gAjaBo+GR5CEGSiK+VIGaTCcKTzSlEDDqTDOViT+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4ISsov3mp2qRDRiVrq8OgLBpmOWPblJsjmzQz94OJU=;
 b=kqNeHvF/UMLdWRd1LsIrWmMK8eB9eBceYpJe2QdXYEUaDwIdSWJyZti4WRDBIH+pSlWtOv7/LPCo1JSpvybCrmUocdyJJuxKd3aXqHyBDlOgXXxxgAGTK716nIKiRw9hQBnUmbV/HR56Qj82DDO1ns0kx8ZIrcCrh8GCgaLMevQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 07:26:12 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9160.008; Thu, 2 Oct 2025
 07:26:12 +0000
Message-ID: <7d2c1407-8dfe-424c-ab9a-1960a5e822eb@amd.com>
Date: Thu, 2 Oct 2025 09:26:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: zynqmp: Prevent use of uninitialised variables
To: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20251001-video_zynqmp-v1-1-34f1e59b9c34@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20251001-video_zynqmp-v1-1-34f1e59b9c34@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIZP296CA0001.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a1::10) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY5PR12MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: a52738a6-a800-415c-6e0e-08de0184f6cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGNWQktLOFRkYTIvaU1Sdmw3WXVFeDZUN2srSDRGV0ZiK1hXK1dxYkV2bVJT?=
 =?utf-8?B?NFV5eVhKQlR5QjBEODlURFV4dzNvUElzdVJvSTJrQ0hDZlh1bnFObHArbnp1?=
 =?utf-8?B?c0szTXMxY0NSb3pIUWREWGk3K00vZWNQRVN3SDdjaldpWWR4clgxYjhqSHFZ?=
 =?utf-8?B?RDBPRkRqd1dpckhGV3ZVRFd2aDFPc2NvcDRRQU01eDU1czErdUswYVJrcXBj?=
 =?utf-8?B?VDE2K28yTE1kR3F5UnZXSVVaTEthSitEeExyUEpEbkpmZ1c5enp2MUl5Q2pm?=
 =?utf-8?B?OHo4ZUZCRk5vR0o0YjMybStaci9Rb2NpNVFXaExLOUpiaVp5d3p5T1FROUVh?=
 =?utf-8?B?WXFoZjFBdjc0UkUwckdEVVBvRXUzQStDK3F4bktqcjlMVDgwOXVNNDg3dEYz?=
 =?utf-8?B?eXdWVXYyS3pqRmphckwzaUovbGRzNkRkZGlhZHpvd2NsMDZqVmVXTU9kUHJz?=
 =?utf-8?B?RU91eFQvOVp0ZlUrRlQydWp4bHUwbE5TVTZtWTJrN2lQeXhiVUpQNWJiRlZq?=
 =?utf-8?B?WTRoSU4wT1BoSUl1RU8wbGpMc1VyWHRWQWpYSStyanRRNkU4V1lWVDcvRVpm?=
 =?utf-8?B?K3pQYkkwSTU2aTJ4ejNYVUxzZ2VzeFI3S0JLVjNRK0JiVnRZZXFlRDdFOGsv?=
 =?utf-8?B?T291ZlZiZXlQaFRQek9ha3VXZzFnYktJdzlpa2RTMFdUUGpndlBidHFMdnNU?=
 =?utf-8?B?aG5DWHhvUm8rdzRMbk5BeFF4dFRtUjBZM1NFNjZRQWFHS1pucUgxQnhleTln?=
 =?utf-8?B?Q1BvUHN0ZWsxM2g5VVFMZHFPMGUwZGlOcGExQ253R0Y3cmFNSmwvZU55Z3Zs?=
 =?utf-8?B?NEZORHZXMUpBOVlpeGMwTEwwbk82dVZoOWN2OG5MN2NjQjFuTjNVb1QwMHp0?=
 =?utf-8?B?dGFvcWVSZ1U5cUJ0L21xQ21BODBNS01sOVh2c1FBRDEyUzhKbGlTK0pERjMy?=
 =?utf-8?B?bnI1dDc2U0RnZzYwWTRNa2xXT3ErTGloaHhMRlk4anFlLzJqaWk5NStVb1h4?=
 =?utf-8?B?QkJwbGlrSmhKcVZEVmRKdDByNmZmTHk5MGM1TUpGdVkwdUFQSHJzcjYrbzlh?=
 =?utf-8?B?eFZSSHRxc3V5c0lzOWJvR0Z5UXB0bkE0WEVOMVlRMUtSdGQxQlJDcE1OYTRO?=
 =?utf-8?B?OFRFcDN6eVg2SFB0R2VEa05DbDhEcjBWQ0NIbGVDclA0czk5MExqQ2NiQ09P?=
 =?utf-8?B?UG5CaWxEMENZNXBpbk1UcmhKNGVZbGM1RkhydkR4NDBhbGJqbkNqUDQ3b0N6?=
 =?utf-8?B?dTdLL0ExUVNlRE5tejFzYW5QZytnSlVpSDBtNStsaXI4aHhRQWQvRFpzMmY5?=
 =?utf-8?B?ZWZBN0xsbjNHcmJzMXRtQ2VKOUVnbWlsV0lXREhhL0ZjS3I3WjQ0cGJuODU1?=
 =?utf-8?B?QzVkbzAvODBwNEpYK3MxZG5qS09JZnd5QUZ6U2loc2ViMG5zbGFJNkVmQk5h?=
 =?utf-8?B?TiszRmdKMURLK0ptMGh5azJQalQwakRXeUk3RHVJY2dzN1FCOVJob0NhM3A0?=
 =?utf-8?B?RmNreUgvQU5DNjNvT2RPT1FlTGpiM3NGRDVwN0RMc0pZbDQrc1lxTHpUQVpa?=
 =?utf-8?B?UEpiRmpJUndhSEx5RGN1TUYyZGhqUWhDRnZTZ29RNzJZYVJBMlBiMU5UUTRT?=
 =?utf-8?B?ajhQamRYNjZQSzRZV2dvOHNBRFdXRnZiQ2tWSFdkZlpKQ1NRYTFlaEMrc0xW?=
 =?utf-8?B?QTl6QTJSYnAwNERleXFLUlZQVjdlMGVHWURQSldZMVpPV1U5Mk9BTEc3dVh2?=
 =?utf-8?B?c1haWTJaVnhiNzBEdExYVUtPL09hTGZiWXFnZXo4RzV4TWt2SFF2MjVjbHY1?=
 =?utf-8?B?aVpvc2p6YUx4R3k5MWVIQkh2Z3RvMkErdFZyOHFNYytML0JLb0NkakgyWUp3?=
 =?utf-8?B?RTdpWmUrL1QyUE9jZVFnUGUzWkc0NHdid1E1S05iNEVDVFdISmJNRko2Vk1a?=
 =?utf-8?Q?DG2z1btCvhlxbhcSwDpmBYGHyiH0nYfn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2JMbGZHckRrajJsdW9UMXJDSXVIV1kvK0hkdCtTUlM1WXhKTE5wNlE0ZFpM?=
 =?utf-8?B?QkZDRXNvbk1VYTVneHFYaTNvemZHK0tOTERiZ1lLaXFXT3IwNkh5dWx2SmlL?=
 =?utf-8?B?c2VmaUsyWEQxdlNQL3hjMDVqVTVCNVdka2xOQjZtSkIwbG85cFhJUGdESklI?=
 =?utf-8?B?bmhXUU1rMHV4SE1zejBjQ1JjSlJMK2pIcDdKcFliMTZCVHVWbnRUekl3bmRm?=
 =?utf-8?B?bGFITnE3SDFtTEVRdEV0VGYrVlV2UEErT3NaZS9iYjZlZFA1djNNS1VPMFBt?=
 =?utf-8?B?WDFQcmRhQVl4VllURkFqd29Lb0Y1OHpDSDJFMXBMTEhicGRWOE5JSFgya01r?=
 =?utf-8?B?WitEYXZDRW1KVzJrZ1AybXZzNHdyRERIaElpWUxDeGhIZitRRG5USGI1WjYr?=
 =?utf-8?B?cEhGQ0ZyN0sydzZMTW1xWG8xOTUvREwvcVZ4elVPYXErYStVOTFFeEFYRWs1?=
 =?utf-8?B?anR0T0xpL2oydlBKaW5MWm1IM29mQi9oNFJLRFpRRTFhUWc5VTlId1lFc3Z0?=
 =?utf-8?B?QklMT08rQ0tzUktzbVFWeHQ0TzhMZEhEV3VJRTFKVkJhM24zS08reFcwdjBp?=
 =?utf-8?B?TTNFL0YwRGN6MEFNMGpIU1ZtNGFjOWl5M2kybFpMSnltR1FUalVmQUpFbUVJ?=
 =?utf-8?B?NG1WVWQzL3UxQ3N5T1pGK244cGUxYk9CYzByRHMrRTVhdm9MOERjcTMvRDFN?=
 =?utf-8?B?UTNHQ0lycjdZcXdTQWNzZ1pzYitsNUV3WjVxTGNtUlp0M2VBd0N6V2VQSk5U?=
 =?utf-8?B?SWs1TFJocUJxeEk5bHhReG1VMjlnc0N3UzBqVkxnWWpVSVdRVUM2aE55MWRJ?=
 =?utf-8?B?Q0UyR0p0ZlZMWjcrTE5ZS0pYQ3RvVEh4QVk1ZElzMEJCR3lmT2k0TTRwb1k5?=
 =?utf-8?B?VTBRbE83N201dzRqRDdXUGZkS2F3SXdiaEtPelhzOENHWmpiQTdVSnZ4M0c0?=
 =?utf-8?B?bFBpd3IvWlI4OEpQSUlkRGRabGsvbFBPaEJyUXVEOGVBNFBKN2YrTnRGdGdE?=
 =?utf-8?B?bDZVcU1pL0U4aTlKVytVaTQyMnhYbk9LOEZxVGJGSkE0ZXJIaVYyVDdTbXEw?=
 =?utf-8?B?S3pPeWRHdDNMMmFJSGNCWkRWMU11OGczNElTQnlTWHRnQVVZZ0NVQURsSDhK?=
 =?utf-8?B?VWNFUXM2RFJpRk5SOUl2cXo3bHRPMHl2R2k0T2R6bkNrZk9pSkwyNEZQam9C?=
 =?utf-8?B?Z0cyckdTdXhDaTRFVVVzdkpvMGN0ZlNCV1k3TTFyMWMxOUxvV2JGeSt4eERT?=
 =?utf-8?B?dXJmUFVjdUsrb2VBT2haWXFHODJMSXZuMVhqQUltK25ZbXlwUXYxNUJRUU85?=
 =?utf-8?B?M1ljeUZ0K2swMHQ0MUNtdmRmazJIYjB0TnVOVGtLQ0pnM2hzOUh4a1Vicjlq?=
 =?utf-8?B?TU1YdlIwRVcyc0lRRjlDeXhTSUVtT1MrNG1uR3FjVnNnQjVEK0MvQWFHaWpv?=
 =?utf-8?B?MlQreUIwSzVmMXZ4SFJRZVh6YXBwcjBpSjNJWHJyZithUU00RnUxaWhCUmxQ?=
 =?utf-8?B?MitKMmxQK0piSlBXbmhFNW9ucUQyZHc1cjR4Rjk3d1VlTWN5Tkw3Mmk3c21w?=
 =?utf-8?B?ek16OFJoakZVcnNhZ1I0cHhMMVJ0Q2p3WFJLSlVNWmhBUHNiQ1huRjNOMjZU?=
 =?utf-8?B?a01iNGJTdzFFQTBqZThoSUNWVmRiN2FNS3ZnNWhkWnpsQVRtSlpuWVluVk03?=
 =?utf-8?B?eHRncDA2RzAxenVjM3B6TEZYN1I2eHhHU3lUdWd3TXJpNGN4Uzlyait0WWpK?=
 =?utf-8?B?djNzNmtjR0JRMWJxTG5NKytWNCtlUjRlajNhdkNYbW1qS2kybmJ4RUFJOC8y?=
 =?utf-8?B?MFZHREorSlJnYm8yQWxmeEpUTCtHSmhvelFxQVBMY1Robi9ubXQ5N3ZNbldv?=
 =?utf-8?B?L0ZoQTdUMXc5T3QyWDhDUEdSR2dEWXFCdkFBQXhJVUFucGdVdytIWFZzK1l5?=
 =?utf-8?B?R0FsT2lNaFFQN05Gd3Jubkg2R3lacFdycEN4RVNHQ3o1eHM4ajFHeFBsUnlH?=
 =?utf-8?B?c1YvYmRVVkVBS2NRQ1VCWlB0VlNqUmxWemVMN0xvZzZoK1E0V0VmQXhXY2pT?=
 =?utf-8?B?KzhGamRjSkZ4OFNEOTgwaStibzBXT0JGQ3UzOVJETzFFKzcvQTk2R09CaWZ1?=
 =?utf-8?Q?LhygDfWGP/0MSPOBOxxLl87Py?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52738a6-a800-415c-6e0e-08de0184f6cd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 07:26:12.3715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQcJMNprj8mEpjWkeIFfDCTc3WcyTYpnRShICPTl9vewKQkfMzLzcSlVZ0leXxgC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228
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



On 10/1/25 18:36, Andrew Goodbody wrote:
> The variables 'offset_matrix' and 'csc_matrix' will be used
> uninitialised if video->is_rgb is false. Correct the logic so the
> attempt to use uninitialised variables is not made. Also remove the use
> of these variables as they seem to serve no useful purpose just being
> aliases for arrays.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/video/zynqmp/zynqmp_dpsub.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/video/zynqmp/zynqmp_dpsub.c b/drivers/video/zynqmp/zynqmp_dpsub.c
> index 52af23c3c83592af4442af4fa7e345b85dabd9d2..a0efd3393f5fe2c3a468caec4ad81deef18dbdbf 100644
> --- a/drivers/video/zynqmp/zynqmp_dpsub.c
> +++ b/drivers/video/zynqmp/zynqmp_dpsub.c
> @@ -240,7 +240,6 @@ static void avbuf_video_select(struct udevice *dev, enum av_buf_video_stream vid
>   static void config_gfx_pipeline(struct udevice *dev)
>   {
>   	struct zynqmp_dpsub_priv *dp_sub = dev_get_priv(dev);
> -	u16 *csc_matrix, *offset_matrix;
>   	u32 regval = 0, index = 0, *scaling_factors = NULL;
>   	u16 rgb_coeffs[] = { 0x1000, 0x0000, 0x0000,
>   			     0x0000, 0x1000, 0x0000,
> @@ -262,19 +261,18 @@ static void config_gfx_pipeline(struct udevice *dev)
>   								video->sampling_en;
>   	writel(regval, dp_sub->base_addr + AVBUF_V_BLEND_LAYER1_CONTROL);
>   
> -	if (video->is_rgb) {
> -		csc_matrix = rgb_coeffs;
> -		offset_matrix = rgb_offset;
> -	}
> +	if (!video->is_rgb)
> +		return;
> +
>   	/* Program Colorspace conversion coefficients */
>   	for (index = 9; index < 12; index++) {
> -		writel(offset_matrix[index - 9], dp_sub->base_addr +
> +		writel(rgb_offset[index - 9], dp_sub->base_addr +
>   		       AVBUF_V_BLEND_IN2CSC_COEFF0 + (index * 4));
>   	}
>   
>   	/* Program Colorspace conversion matrix */
>   	for (index = 0; index < 9; index++) {
> -		writel(csc_matrix[index], dp_sub->base_addr +
> +		writel(rgb_coeffs[index], dp_sub->base_addr +
>   		       AVBUF_V_BLEND_IN2CSC_COEFF0 + (index * 4));
>   	}
>   }
> 
> ---
> base-commit: b2d5e46c67002e46ac339ef549ea18cf5adfcd87
> change-id: 20251001-video_zynqmp-8822d6863aea
> 
> Best regards,

Applied.
M
