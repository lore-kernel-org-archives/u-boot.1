Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE792C9EC77
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 11:57:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 625C1838A5;
	Mon, 12 Jan 2026 12:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B52WSPDj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAD3583923; Mon, 12 Jan 2026 12:57:13 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 485FA836AC
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 12:57:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8df4DsEk8Sh1I/ScaE9hYmOhZi8Z2vmaXpi4RFM0xUQk7CjGu6GGWsBViIfMTxYumlHM8WTihmbZSL9CH0x+9RkHIsqNW6ZuknUQEkD1bkzcURPk+nNmqCIRb865/tXJG0y8o4yK/quvNEoYGRz3Ppk+NNU2kHw/nM13PQw/S4TryVJg0g/37Cid3tBzc1L8T6XiUYesRxlAyGcdM4a7hvK7/Eqjwb2hq5yfGIcRY/eK8uZ9/X3uoEpfQQcxY3yIZcixLtiw1VYX68v4qK24MM6V3aN4Rj3dk1smcnwc9lEaZr31owcnGqdFbbxlX8zwt1zqVoSGgPvwtPYb5w+fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+E7ni8SYlHKnHYU5MS/EZZ6tRNErGNDUyB/D7/fw2Bo=;
 b=FICyTCFkvmp4X+K/1ZTHPHpsOjkhJWDIoGvTn0b05cUb50FdBdPhzOhSQM+UZPRuJvEM+3vOXxsOMq3LL6EUDqixmtXHM+dzeGvsfgHlloRUb68a1fUOusr6ZqmqoCZsiJgj4l7wentVB8BJCV9jbfgKNLFWIt48ygZK3VNjAWEXniP0jOCiTVJnYxDqF2hiC/70H1DUx6mpdAVWpl5x9wLS7bCcHSr0YXX3wRlRswa0HBUuzxlnkjChuFzncYKs2sOOIaR2jypYBizDJM+GYEPBT4FnW1MwbTjI5RUVsdSk+fJwyrnAIdDYfhmPin/onKrEm2gLEW6kjFVgQwhYcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E7ni8SYlHKnHYU5MS/EZZ6tRNErGNDUyB/D7/fw2Bo=;
 b=B52WSPDjOyFgLFWSZ4tYBqKM8X3TQwH/IRFRlqCPGh60YXvQarhPcLQfkWzP3I//BXB+DvbuDkZCKM2rwcxufqrogRTT/1cytKIH+jXQQpfq9bj+sijPIGR7izQEBNGcZ7qaEM2PCl13BZ2a58Nhl4s3G+QDtSTL7ODGv1xkPkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 11:57:07 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 11:57:07 +0000
Message-ID: <8321da50-81cd-4ef5-baa1-afc051f03cf5@amd.com>
Date: Mon, 12 Jan 2026 12:56:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] arch: dts: zynqmp: align cpu_opp_table with linux
To: Neal Frager <neal.frager@amd.com>, u-boot@lists.denx.de
Cc: jay.buddhabhatti@amd.com, arun.balaji.kannan@amd.com,
 senthilnathan.thangaraj@amd.com, micheal.saleab@amd.com
References: <20260112072139.2709127-1-neal.frager@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260112072139.2709127-1-neal.frager@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0010.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::18) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY8PR12MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af7a7ec-f900-4b91-6318-08de51d1b585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2c5VkNRbHowUkF4ZFhFQjV3MTRaSWxKZ2pjalg4MXFMMERxYlRkY3NuV1Rq?=
 =?utf-8?B?cyt6M21NalVUemRDSjkwckppTjQ3ODJONWpwTnJqbjBMK1BMdXltdjh0QjNm?=
 =?utf-8?B?OVJNKzJVdm9HeTNBczFaeDU3ZUVYckpvZ0RFc210eEJRa29jaG9LaXEyL3hy?=
 =?utf-8?B?QVZqK2ZpVHpJSGt0d3Bmb0k1bGoyYW5PMGVOM2JPREdWZnRBYk9hdko0TitZ?=
 =?utf-8?B?WkRSUmtrVHprNzl2OTBGaGVXdWZURHR6T1FCclA5N2FBbnVtMjJRdWRjWmlV?=
 =?utf-8?B?dGxuL0FKbkhDTndScGo4N3pZbXJ3L3E1SFdZeVl2cHBlODYvM1ZDM2QvK1hN?=
 =?utf-8?B?NkdvaHVRQzBVNVh1a0lvY2Q3UVJlZUNGc20rMHVYcG9pUFRaeGsrZDR0MzF4?=
 =?utf-8?B?WlJNQjZTYXBJK3BOZ3hhTmF3M0U1c2hDcWNwWDhnQmQ3ZFpPRDJkVEpnaElY?=
 =?utf-8?B?SWtHMlhBMDJGb0tPckVDbThmR3c5RS9raDJQK3RveWYzbVoxWkllOGUwMFpk?=
 =?utf-8?B?OEZMNzlmLzB3eU04YUo0SkFqUW43dG5SZzVGRFNPZnZDL3hlOWRKa0w2b1Vt?=
 =?utf-8?B?OGNRMDArOXl0dzF6VkMwOVZITlhaZzlUM3ViRnN0Y3doYUw5czJCaVg2akRE?=
 =?utf-8?B?UFRQenV1cHFKd0R1WnQxa0x4S3VydnF5VzVvakNpZWVyZVRaRWV4UG8zK2dn?=
 =?utf-8?B?ZUtMcnJlNDNONHU1bXZJdVIwOEFMVElleWtzNXh0WGo2VEkzZWNOWHpyOFNN?=
 =?utf-8?B?WlQzRGl5b2JzQTk2c2kwaUJpcXhUU3UyaGNoRmdjWHYwdXRMaWg2d1g4WVU2?=
 =?utf-8?B?ekJNOXJEajRaSFM0SDJMTSt5NjgrTnptT2ZEbGlwbDhqdktRNzh5dVlFYVF3?=
 =?utf-8?B?MXVSRUtzRERoSHN4blkvaXRNdUNDWkZaUm5zM09KZ2pwU3J1WFpTL0dmdW5H?=
 =?utf-8?B?QUFzOXZBRlZob3QvcTBNRWNqQjJoNFF2Y2l4WklKZkovekR6cWVHMllkeUhD?=
 =?utf-8?B?TEc1SkRtK2MwUTkrV29MM1VpQW5qQjJPcTVXOWhjVHd4MUhHNm5lZFJWMXox?=
 =?utf-8?B?MG9sTHlscmZETUcrbVpXYjJoSVJ0NTV3bHJpQVNpazJ6SUlMUDQ2UnVCcnRU?=
 =?utf-8?B?M3dES0hITHJUWkU3aWpYcloyVlBhTVVpUC9kZHJMS1B6dkVycjlaZmdIV1Uz?=
 =?utf-8?B?OFd4OTVKTWNVcFF5M05VSVYvUTZPRzB0VUJyZHJxd2hrMldrYk14YWw1WGZZ?=
 =?utf-8?B?a0tUQktsK1Q3S1UybXRzUVRzcHA4VTZwK3kzT1RHMXJiU1RHUkZhL0JLNjlH?=
 =?utf-8?B?VUFhbUVCZDFkN3d1cEp4WlROWVQ4MVVNNllPdU5icTBVMEdKaTVvN05vSXBh?=
 =?utf-8?B?NkQvVW54dmoxV3BKbnAzN0d0Wkp6TGExRUZkK1RTNjlmUURaTmxpS3VuMWNj?=
 =?utf-8?B?RmtxN2M3SitQMEVYYm8zc3YyMVZObmlCdlU2aXFOSGpsb0Ixb0JrZFNwUklt?=
 =?utf-8?B?UUsrNDBJNHduZlI1eUx0WU1FeXRvYmhOeDFvSjByaFdpNXFOakh5YXZmTDlr?=
 =?utf-8?B?WEUwaG13dWtISUhIZ085N0RvNk9laHlCTGROMFBFUmlFNUNlK2I5T0lHK1JZ?=
 =?utf-8?B?eHgzdU12cUVzNXRDZVRXNHFrVUlSNmxMUHgzNEU2cFFoY2RROGZCWms3WjhX?=
 =?utf-8?B?Q1k5N2JnNnVOM083d0Y0dVppRjZnQUN3V1BxaEthV1l1c1luZFp0a0Fkc0F3?=
 =?utf-8?B?bS9aQUJQbVErYnUxOWNzeHlNeDBRY3liRms5bkVwTU96VkZOMkpTaG5WMDNa?=
 =?utf-8?B?K1VKR21ub04vdTdZVElXSGZIZGx1VUlQVHpZME1oY1Q1VkxLcWJ2N1ZSaU5G?=
 =?utf-8?B?NlJoQzBGcitsVENRN2cwTkNDWHc4aUwwc2VSVW15ZWZmNVRJbWgrYU5PVUVD?=
 =?utf-8?Q?pSpMuBUmYahMgVFPZHEY9hfzajjEKDsx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnVONGJscEFpcDAveXY4Y2FFaEY1NUxyT3dBU1BLVGpqbWFsNG45eThRUk9r?=
 =?utf-8?B?ZDg5U2IrajRvb0xEbUxjR1cwWmZGVWNWYUdKSmFQSWp5MzRsYjNmelpUSlJt?=
 =?utf-8?B?dlpGNFdSK2lkL1J6Z25MaXV5YzRSbk1mbmlVQWx2eHBXZVZqZ0gyUitaQlg0?=
 =?utf-8?B?T3JkODl6eC9HQUw2ejl3cGlYSkZCSm1rY0s2RHpBUEVGaHd1VVN3amsvWU9P?=
 =?utf-8?B?THFHVFArLzZkVkYrV3FpdHl3bnBkSUNDY21hcU5PVjlYRWJiMU9yYUNyYUhT?=
 =?utf-8?B?OENzdWczREQvdExYZkhOcDdQcGRJVk83QnhuOXZBOEJlUld5VzhzZ0FqTDFE?=
 =?utf-8?B?eHErWXBuZFRKUFJScmJKVW9WSjZjR2FVS3VMTDJOUEhBR2RtbmlSVGwrS3VQ?=
 =?utf-8?B?ak85TTJ1aTFDUk44MEh6emdiUDkxMXZ5NlRJdVhRNkN3cjFYU1BQQnZaNGoy?=
 =?utf-8?B?djlmNUpWYmpjR3FVbVRNSkVxZ2dkMFVQQjhxZm8wcUdub2tzVWR6V091L2ph?=
 =?utf-8?B?OElrSWM5dmtjaTVXUUZKS3IvRExIcHNjZUkvRnNYTXBvSkZjTHFJVURlM2JC?=
 =?utf-8?B?WU5sQlFnVjFjZ0V6Ly9NSlFqc1JaUkltZ0RQWkVHallVakllU3hobnFQZFYy?=
 =?utf-8?B?a0Zxb0VlUVRud01YMHBnaGEzWis0NXI3Y09QbGw4cG5XMHN6MDZ1aXVpVXVD?=
 =?utf-8?B?czBqRzZSWGoyOWFuc2U1SVBOU0E4bGVQVE82ZHNpSlJUU2MvUVFqMXBjcmR5?=
 =?utf-8?B?RCtZVTZnWUR0bVpDQ09tVXRlRDNlR1l6WmVOODFTdys3OEZzOGNYUU1abFJO?=
 =?utf-8?B?T0I1azE3ZHA3VHpVa3QycmFJYm1CK0JmdjA5WDJWMFFzbTNjQVFuMTIvNk9S?=
 =?utf-8?B?dkZSdzZHSi90SjVYNkF0WHdZM25GYVY5WElpMUs3S1VkcnFaWGVJcTN4aEJO?=
 =?utf-8?B?N0RPdnlNQ3UzeldIblRrM242TjI4b1JMYUtwSXI0NlArdFV4ZjdPbWxrM0o3?=
 =?utf-8?B?cmhvYVFLcEQ3MFBWNEQ2NWRGUlgyaCtYL0FKdHpucW5oTWh1Wk9YQ0twTTd1?=
 =?utf-8?B?aDkyL2tKd2lldzlWbzlkMzBYQUhJa1FTZ3Y1YW1SdWw3RHNQS3dYTjg2c1hD?=
 =?utf-8?B?Tnc4eFFGd2w2U2RvWitZeVpOaE5jYnJaRzdKOGtTWHZnb0ZPYjh3K3FLWWR3?=
 =?utf-8?B?UGhBdDZ3ZXhMSkRWL2FFaURuTmtWWEZ5azRMMEw3bEhlUmZqcXhTc25pR1g3?=
 =?utf-8?B?aVQzUGZKR3V3OUV4ODNKMzdkYXVxd0tDOWpxbmhLaXRlU2R1QXEzcmU0WjBv?=
 =?utf-8?B?bC9sSXBCOC94S202bEgyZFZUZ3Z2djY0VkdXRXEyRzU5Sm5WbW05WlkzeFNT?=
 =?utf-8?B?RVZCUW9abWpxZmZSWmhWalhWNUhOUThHdUt3UHAwcTB6WEt4OFJ4Yk5CL2po?=
 =?utf-8?B?Z3N1RnpBOHNmK1U5T2tWMEpHaitxbE5JUUNXRGV1VkkwbjlTQkRwNncrR0Fz?=
 =?utf-8?B?TVczY3VVc0dzbDhKREE4WVFQRU1RRHBQOTlXODdsS0dMUDVuRHI2SXFEV3Vn?=
 =?utf-8?B?UitVQWlQbmIyL3FKcG1aTEhzSGFMVEEzSWpNZlNINktpajhkSnlodzJza3VS?=
 =?utf-8?B?NVhkY3NreUpxUFRsQXFNc0VFOUswZURxYlZTdUpEbHFGanVuYUJtTzFIZXZZ?=
 =?utf-8?B?eHFRNFE2R1dTRW9NVUhsK0dWemY4YWo0NWJmNHdkbEtFcnFwanZib01yMllJ?=
 =?utf-8?B?bzVZayt6M2xCUTVSdUQyUjJYR0Nrb2pYa3hOQXFXaTk1dmVRRDRzU1FnYjd5?=
 =?utf-8?B?L0E4SW52dy9BM0hBZnJOS3lzK2kyeEg5WWpUb1dmR256blpiTEVWZ2xkMUlo?=
 =?utf-8?B?eVlGNlFJYnlSR3RjNjkyYTh0dkl2SEY4aStibDloRFlnMjQ1a1BnZ3d2djJF?=
 =?utf-8?B?eUVhZ0E4Vm9zTmQ2SmJSc2JzZ2RtZGptQ3FPWEcrUGpkZTJmLzJ1V1VDb0w1?=
 =?utf-8?B?b2dyQ3ZzOStTVmIvUk5xUmt5enI5OUFnT0d6a04zZlBidWQ1RjF4NGlHUG9V?=
 =?utf-8?B?VGNwNmliUVZ6UzY1eTN4TUp0WE1MOHdBTHJvUk5PTmJkdnp4WXdxaSs3TkQ0?=
 =?utf-8?B?RFNsb29JdDBiUlFON3JZT2RSYTlOcGdHeU8vSFZzSjJqcGVLSXpQYjcvclFW?=
 =?utf-8?B?YmZybHVrTWpVMkxtNURyUlkxaFBhVlI3MThMYS9aN1ZTSWRYVjlPaWVQZGIr?=
 =?utf-8?B?TVZ2RG0rdXNlb3hYejZubmNOS2V6Y05HYVVTM3VBRkVmbnFVcWF5d3ZDaGZH?=
 =?utf-8?B?YTBUWS9rcWZpZ3lPdm5pTm5QYWZKM2ltSFh3UUtNdGwvVTA0MC9XZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af7a7ec-f900-4b91-6318-08de51d1b585
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 11:57:07.7265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNM7/aHPWn5bA09mlOYJIgPbm6KxahTczA8n0Yc182KSu+hguBmF725dT+SJRiuH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217
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



On 1/12/26 08:21, Neal Frager wrote:
> Align the cpp_opp_table and pss_ref_clk values with Linux according to the
> following patch submission:
> https://lists.openwall.net/linux-kernel/2025/11/11/424
> 
> Signed-off-by: Neal Frager <neal.frager@amd.com>
> ---
>   arch/arm/dts/zynqmp-clk-ccf.dtsi |  2 +-
>   arch/arm/dts/zynqmp.dtsi         | 16 ++++++++--------
>   2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-clk-ccf.dtsi b/arch/arm/dts/zynqmp-clk-ccf.dtsi
> index 52e122fc7c9..482f432ba7f 100644
> --- a/arch/arm/dts/zynqmp-clk-ccf.dtsi
> +++ b/arch/arm/dts/zynqmp-clk-ccf.dtsi
> @@ -14,7 +14,7 @@
>   		bootph-all;
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
> -		clock-frequency = <33333333>;
> +		clock-frequency = <33333000>;
>   		clock-output-names = "pss_ref_clk";
>   	};
>   
> diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
> index 02e1c4615c7..13cfca66657 100644
> --- a/arch/arm/dts/zynqmp.dtsi
> +++ b/arch/arm/dts/zynqmp.dtsi
> @@ -103,23 +103,23 @@
>   	cpu_opp_table: opp-table-cpu {
>   		compatible = "operating-points-v2";
>   		opp-shared;
> -		opp00 {
> -			opp-hz = /bits/ 64 <1199999988>;
> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
>   			opp-microvolt = <1000000>;
>   			clock-latency-ns = <500000>;
>   		};
> -		opp01 {
> -			opp-hz = /bits/ 64 <599999994>;
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
>   			opp-microvolt = <1000000>;
>   			clock-latency-ns = <500000>;
>   		};
> -		opp02 {
> -			opp-hz = /bits/ 64 <399999996>;
> +		opp-400000000 {
> +			opp-hz = /bits/ 64 <400000000>;
>   			opp-microvolt = <1000000>;
>   			clock-latency-ns = <500000>;
>   		};
> -		opp03 {
> -			opp-hz = /bits/ 64 <299999997>;
> +		opp-300000000 {
> +			opp-hz = /bits/ 64 <300000000>;
>   			opp-microvolt = <1000000>;
>   			clock-latency-ns = <500000>;
>   		};

Applied.
M
