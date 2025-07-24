Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AF5C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 12:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73B9283881;
	Thu, 24 Jul 2025 14:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vuUpwIC9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8947583885; Thu, 24 Jul 2025 14:10:21 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90EF1835D8
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 14:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLP200XTe6mW8sZUpJMW8tqj1wQ/KIwa0BrTHpp/dpkHIf8NMYLcksSXmPIemoVmWoqJWSv7feeVEqZ9IesY9dnDE07RP1i5b//uvSHiRsdYryzRp48yjx2oINz4YbEbnY+IwFtIjdEunCRsZcf7Q/1y19pDHiFK9YU6oE7dsXt6bSEYXMEQl3FxHQlG8CfZkKg63r5NM6iY6wCI+RUElnaCtccmYT9FXDE4VAVAteES7krbAtnTnd6L93JaW/J3QIZCdwEKFRhHTuc9OMo9qtv1+Ywdb+6cKPXiDvboLyf4vmfF8w7RzMVvUrn6b9zEtakjaDTl+ramWB8sYWoVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHrxWNZ2LqdQNPYruXIuDwgOFDU+rlMhwnfAMQGBWyc=;
 b=XfwxZpLBN4ummRxNATGv7qkAfj8W+9xgWi3SG9D660Q4QE0rjoOrQcPxhcu5nJzyLMPFITQkUMFi6m2xfXsG7x6XiULJegHXtaTQ61zslOR+gwp/N6sUSlctsP4lrDBaHGbWpEx2sGs13rPeLJHs5j4hSsPbPGdBECoqIdonPOqYdXylwX9vq7CzE50p9d4nax6t04vrDCdeqepFDVnhUedtvudqP0wVbPnnf0lR99egB0aHhuZbQbNI/gMIiwy7VW2OzrbruXkZXNR10YJSbGDvSP84jQ3gFXpab+NnKsA70g21qYa03g9QL1N8kGZvJmN/wgquufQLrDOrjU86kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHrxWNZ2LqdQNPYruXIuDwgOFDU+rlMhwnfAMQGBWyc=;
 b=vuUpwIC9qPNfRWQFYmwzmFi3VvWWkywsmEh0bY1t49BRT8o/c75A4/ZIb8p+XyAKWydlh0KIm0QxlhJPMV85yrU4qwcGBq8Laifxwhw7lzHfErsBmADB67RS1cwsT9gW/xtOBxIGXf5wRTX6BdYLpJ6+4tl270ef0XDqFtqZelI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 12:10:15 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 12:10:14 +0000
Message-ID: <fec4bd62-0883-40c5-a1a6-cb672e489075@amd.com>
Date: Thu, 24 Jul 2025 14:10:05 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <michal.simek@amd.com>
Subject: [GIT PULL] AMD/Xilinx/FPGA changes for 2025-10-rc1-v
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0173.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::30) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN2PR12MB4158:EE_
X-MS-Office365-Filtering-Correlation-Id: 690a8c6b-1809-4849-1f4f-08ddcaab0bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vzl6VzdtaG96WmpuNzVvZzBOaFo0TWhVQk9FdmNjUFRNc3dyVnVpMjV4US9H?=
 =?utf-8?B?c1FVNW9BdTFESTV0MXFRUktlUDFoVHl3ekdKRjUvQ0JFWXEzc2xJcjVBQ0ox?=
 =?utf-8?B?eEtlNklnbnVJaDl6TllBT2ZOaGxtaElSVXlydXdhK0VoOVFBeTN3ZDNuNnlF?=
 =?utf-8?B?amhrRGdrb09WaWc5R1U2VWZYZENwbHI3a29neVNNNFJueXJxdWFacU1XelZn?=
 =?utf-8?B?WUVZT1l6dkNRVVhSSmhQZnpWVzUzSjRVV21JZzk5T1lKQ0ptZFZwMUJZOGVK?=
 =?utf-8?B?eEJqcnZibElQeEEwcTRFODhXdFhTMUdIamFHRWN4bjZLbVBqTWZ2YUN5VGdV?=
 =?utf-8?B?ellQMko3ZTc2ako3T2VUdkFuaGl0bFBrUVpOOXBld085MjUvcnZaMk1VSzdW?=
 =?utf-8?B?VmJmaTBLNDNaQWs3bEtMczdOT1ZKRzNsS1pXbmU5OWtLUUpTVjI2TG5JclB2?=
 =?utf-8?B?U2V6bjl6QUZ4c05JTlFuV1hEa20xMlphSzRLSVN3a1gxcGNVK2pkME1xTHhk?=
 =?utf-8?B?alZXdWNscXhZZjk3MTl2S3hTVW43V0hCVzVteWdteWYwbnBmdlFKeUU5Rk1B?=
 =?utf-8?B?cUpLMnJ0RlgveUozSjRpWEdyOThpaW9zUlBCQ0VxOHJxcmRERVdWNUNvaTY1?=
 =?utf-8?B?SmlMQUlDV2NNZy84NmlxYmxrZ2RtNHhvN3BvaXlmSS9JN2FKOUE1OGFidEQr?=
 =?utf-8?B?aThvR0V3cUhMN0N6UzRiUDgvNS96a3JITWdwSjB6OFdMNWtxZnZ4eDhmS2I5?=
 =?utf-8?B?R0o0RFl2cHczWmJYTTF0Z3BzR0FqNko5YklUaHZPM3ZvUTRReDZXanFjNWd0?=
 =?utf-8?B?N3cyRjlCcTJ5R0k2WjFMeU9pZzNibnBtYVdTSWlMbFoybXV0OGRDelV4UVFL?=
 =?utf-8?B?UjJUMDBvVGJIaWhDMUxPSFVPcGFtMFlkZGE2bUVaNnpHbnk0bnIzQXdhaFRG?=
 =?utf-8?B?SDRlQ0RHOHpjNHlNNFF6dFA4eWJHY0E0dHJZVGE0dHhObWdwdmNEL3NJV2dH?=
 =?utf-8?B?Q0xuanIzNmNJTDkvUmVxV3JUaHFaOFVvMzR5eldDUmlSRG5sVDhsem1ES1lY?=
 =?utf-8?B?VlZtZmZFTi9rYi9TYitKMXEweGNCS2RNYnJOQ21UVGYxS2xzeDZDSVcvNXpO?=
 =?utf-8?B?M2ZlTlVoWm01R1RyT3VwN0J4Y3RqNGlCbGlXcXdEdEZZaGtFTGZGQUozVTdQ?=
 =?utf-8?B?Skc3TWZweE1JSlRRWUMxdmFsb3JPZmVDWlNCQ1VUMzlldzBqQnpKRlRudkVP?=
 =?utf-8?B?UnZ3YTFLNmRTVVBEb2RXTGlPUFFLY2JwVUgvY1V0VDF0dVpUU0cvc1FMcXBl?=
 =?utf-8?B?bWtHcWVhS2J2OHY4UWhORS9ldnJVR3pRTU95dXZ0N2d2SlkzSWZ0VGsyOTQ1?=
 =?utf-8?B?U2d0a0FOMUcvcUROa0FtV244a2l0QVlQVWNiZVJ5emFMWk96bXA1ZTZXbm1j?=
 =?utf-8?B?OForWFpHZDg3RHV5U0lTY0tsZjg5dTdYeWMrcmsyanI5MmVsUWFpMkZGR1Y4?=
 =?utf-8?B?Z25oYWhYaHdad2xlN294QVlqb3Q5aElUQTB3Mzloa2FGenJoK3VIcWV1TXJ2?=
 =?utf-8?B?TUxIcWZhRXlTdUxSM3FGaU5oT0RqbXR5d3QvY2J1d3M3Qno3d09RYnBoTFN3?=
 =?utf-8?B?QkZVOGYxN3Z5cC9aSzZTN3d1c3AwVHZzYjJURk9FMVRBbTNxNENaZlNydGx1?=
 =?utf-8?B?QWxQdHIyYmJJQU1abTlaMnU3QlZKbG1RWVd3VzhlY0NRWXB2S1F1ZnNoKy8w?=
 =?utf-8?B?QWJuVm9VYXpXK0ZEbTZxZDhEcUNwaXUxRjVyZVU4M2NpS0lPWC9ETDNXODRN?=
 =?utf-8?Q?rV2rHIQr38kBaoDTL11mkZOLq6J9g6rg43kpY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkhEbGxJejA4VVhFdHFnQnByZis2ZDF0RG9vTWFQcllOS1BLbUJJNkt2M0Np?=
 =?utf-8?B?RTZkRDBhUURBSURVT3hCUzZaTmM0WDZ5L1NDV2c4Y0pqbm1mejBYZG41Wksz?=
 =?utf-8?B?VmdJWHZ1NmcxUWpnQlRES2ZKVGVRdlRDbndtNGwrMk1OK0ZIWGlnQldYUVhy?=
 =?utf-8?B?WlVBdDhoa1BpaHh2NE4xMWhjN2drZk8yZWNZV2h4TnVrUlVuaEhBRzJmaUt0?=
 =?utf-8?B?RUV3c3ExK1hpOURrR3NWNTIyaEFERlE0RmlvWWdZL3YwMllXUjdvVzFoZWtp?=
 =?utf-8?B?YXhiL1QwVUFnRmg2TWQ0eVdralhJRnhHQ0NYL09pT1pwK3c5c1BNQWFLQUti?=
 =?utf-8?B?NkFwNWlqeWxMTHRyWTdJcWYyd1RNSEF2bk9md3hLNGhHQVY4TmZoTzRtQlE1?=
 =?utf-8?B?OW8raHQ4YVNRVlVCQlJDVzc4OXhXckpXOGMwQVF5MStSdjVoclRiRktOK1lW?=
 =?utf-8?B?RDRaVTlvQ0cwOC8yWE4wbFg1S29NZUQ2NzRSVWFjMm5OWEVwdGRLaEkySTJt?=
 =?utf-8?B?MDFMZG1HOVZXQVZ4MGRSRVRtQWg5djFWVElnQm1LRjhSem95ck9GTFN3OG9P?=
 =?utf-8?B?ZXpaQUlTOXB3TmpLMGJlQ0orRkNYc05WNnJqTWYranNuTitTS3VEWGtvNUJV?=
 =?utf-8?B?ems3U0RLL3NhUE50d3JPQmxCbjlEZThPbkNrTlAxOEphem9rRGEwa1F2U1Fk?=
 =?utf-8?B?V0hFUVhGL0ZaNHY0cEJoa1YzTGZucW90NGpRaUVvdUs4UGxpNnNFWTdjb1JY?=
 =?utf-8?B?dW5VRHZmMDNMdXRvdmpsYUkzU242NTY0eHRrSGEzU0hhb2pSWmYxbW56R0V4?=
 =?utf-8?B?QndyN3M1M0ZXcm1HV3IvVmNSaGNZdkY4SWp6T09HYlVHRnZhOFArVU53dWg4?=
 =?utf-8?B?UWxCUU5JSkZzemtXZ0xTTzFlZFIxUkhUbysxQngrMHFtN05Ca25DdDZML2JV?=
 =?utf-8?B?V2F6Sk5UZnlXYm1tM3oyZmsvSEpIZGd2Uyt1WCs5WG9qdHl3YUwreEhxT0s0?=
 =?utf-8?B?dHNtN1dXaGtuU2R0bGM5am0xeWhFWlkrSk95ODRIbG0vWGZrNDlEQ0puZUM0?=
 =?utf-8?B?am1ZVk5DZ0xVemNFOUhnV3F3L2lQMWlFbU9rSW5qQmpXK09JbTJYWGRqTGxs?=
 =?utf-8?B?dHAzcElzMGtjdjlvNzk2REZVWTRUenZmQmtud25Hc0llcjUxMTYwNXhwQWVK?=
 =?utf-8?B?YTRVVHRySXpYeVUvN0pEMTlCU0FjT2dxWkVvY1o3bFhIVngxeXZnd3VVOGNZ?=
 =?utf-8?B?ekwzT2IvSnBHeUZBUkMrbW9zYUVBeGxxcUd6MVViVUo1aHdNM2RvTFRLRGZG?=
 =?utf-8?B?bmJGWElYZzFqU21WQmo1NGNJYXViZXMyOGtOKy8zNU1nT3BZc3FwekwxN0ZG?=
 =?utf-8?B?dkhYaXIyaFU5L2ovUVc0WlZmc3AycVhkMHplSXl4MHJtdER3UUpUUXVoUjVR?=
 =?utf-8?B?Y2JVdUplaVI0ZnM0RHVnd212RnFKWDVjRzJSc3JuV2xiWW51V3FkSkxURGZn?=
 =?utf-8?B?T2c0UFJ5NW0wTVpjWU5SOVRHK0lNQm02RzJOa3Fyb2JNL0tzL3pkVE5YZ2wr?=
 =?utf-8?B?U1VjaHRhN2xxTFcyZGtEVUVzZVNsSFdhY2dXeXd4N0JUQ3pHQ3N5L2Y5WlhN?=
 =?utf-8?B?NUFBZ3NZc3R0SXN0TC91VE4zZG9waFI4UTZFQXdMa0llT2lrRWY5Z25OcTRX?=
 =?utf-8?B?azJVTzZpNzl6dG1Xb0ZzTGEvVmdKUmVpelpWdDhjVG42Vk1qdk8vRUE3S0RP?=
 =?utf-8?B?ZW81SE1JcXpiQmgxOFExUkRJVWNuQUcxMkcrRmRPOVNGVitoV2NaWFJDNGk4?=
 =?utf-8?B?RzZXMWhJWWNkY0dKS1ZYcVNNcUNKenlmZ1JrYjFMVDduS29tRXJvOUNSalFs?=
 =?utf-8?B?UUxDb2tNN05pdTNzNjZUZkFoeDRjSm5abjdPMGprUEJzWnlCZVlFYkptakdI?=
 =?utf-8?B?UVlNZlFpN1BvdnVIazVZWGUzZkRPdnNEaitwYmQ0c2Q0OFY3aElwRk96MUVm?=
 =?utf-8?B?S0VlVldPVktyN0lGRjJpV0g0WlB5MlUvYk5Yb3UwK2c2OERXRzZpWkpxY1RQ?=
 =?utf-8?B?cXg4K0JxcWdCeGpMYTJtQUdaZTZwbkovLysyM1dMbDY4ZjExZWpuS3BoRm8x?=
 =?utf-8?Q?corb6OemHyilynvQ2LPXTlGnZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690a8c6b-1809-4849-1f4f-08ddcaab0bf9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 12:10:14.9154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyrYVErHYmbz63wmOnJWx7tlce326XAOzdWnrQrRvRKOrTIhE/TxeODxkqc68UyH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158
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

I am sending you another series of patches for rc1. Gitlab CI is not showing any 
issue. The biggest is FPGA series and there is on patch revert in spi which 
should get to tree.
I have some other patches pending but I want to give others more time for review 
that's why will apply them in future.

Thanks,
Michal


The following changes since commit 3532f1f5edfc97c9dcea723cdeb732eda44bc669:

   block: Remove blk_find_first/next (2025-07-23 17:37:14 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2025.10-rc1-v2

for you to fetch changes up to 27fa1e2c1794cc589d72d485488c0bbb3b877f09:

   firmware: zynqmp: Simplify power-domain driver bind (2025-07-24 09:06:52 +0200)

----------------------------------------------------------------
AMD/Xilinx/FPGA changes for v2025.10-rc1 v2

zynqmp:
- Generate fit-dtb.blob all the time
- Simplify power-domain driver bind

zynqmp_mini:
- Remove PSCI_RESET

fpga:
- Improve user feedback in case of FPGA bitstream load failure

misc:
- Fix kernel-doc in gpio zynq and axi_mrmac

spi:
- Revert fix in STIG mode

----------------------------------------------------------------
Michal Simek (3):
       xilinx: zynqmp: Remove PSCI_RESET from mini configurations
       arm64: zynqmp: Let fit-dtb.blob generated all the time
       firmware: zynqmp: Simplify power-domain driver bind

Pieter Van Trappen (6):
       cmd: fpga: improve user feedback in case of bitstream load failure
       drivers: fpga: add Kconfig dependency
       drivers: fpga: correct compiler errors and warnings
       drivers: fpga: cleanup printf usage
       drivers: fpga: fix function declaration without a prototype
       configs: enable FPGA commands and drivers at sandbox_defconfig

Prasanth Babu Mantena (1):
       Revert "spi: cadence_qspi: Fix odd byte write issue in STIG mode"

Venkatesh Yadav Abbarapu (2):
       gpio: zynq: Fix the documentation warning in zynq_gpio_get_bank_pin
       net: xilinx: Fix kernel-doc for axi_mrmac function parameters

  arch/arm/dts/zynqmp-binman-som.dts               |   2 +-
  cmd/fpga.c                                       | 101 +++++++--------
  configs/sandbox_defconfig                        |  20 +++
  configs/xilinx_zynqmp_mini_defconfig             |   1 +
  configs/xilinx_zynqmp_mini_emmc0_defconfig       |   1 +
  configs/xilinx_zynqmp_mini_emmc1_defconfig       |   1 +
  configs/xilinx_zynqmp_mini_nand_defconfig        |   1 +
  configs/xilinx_zynqmp_mini_nand_single_defconfig |   1 +
  drivers/firmware/firmware-zynqmp.c               |   7 +-
  drivers/fpga/ACEX1K.c                            |   1 +
  drivers/fpga/Kconfig                             |   1 +
  drivers/fpga/fpga.c                              | 103 +++++++--------
  drivers/fpga/ivm_core.c                          |  13 +-
  drivers/fpga/lattice.c                           |   4 +-
  drivers/fpga/spartan2.c                          |   1 +
  drivers/fpga/stratixII.c                         | 132 +++++++++-----------
  drivers/fpga/stratixv.c                          |   2 +-
  drivers/fpga/versalpl.c                          |   1 -
  drivers/fpga/virtex2.c                           |   2 +
  drivers/fpga/xilinx.c                            |   2 +-
  drivers/fpga/zynqmppl.c                          |   4 +-
  drivers/fpga/zynqpl.c                            |   4 +-
  drivers/gpio/zynq_gpio.c                         |   1 +
  drivers/net/xilinx_axi_mrmac.c                   |   4 +-
  drivers/spi/cadence_qspi_apb.c                   |   3 -
  include/fpga.h                                   |   2 +-
  include/stratixII.h                              |   6 +-
  27 files changed, 209 insertions(+), 212 deletions(-)
