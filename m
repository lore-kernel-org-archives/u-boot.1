Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CD3C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 13:02:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE64584ADD;
	Thu,  9 Jul 2026 15:02:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ejH0m2pJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD6D984ADD; Thu,  9 Jul 2026 15:02:27 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31C1A84A3E
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 15:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dlk3QMHxgxQ91OsIS6HOWZAIMuBOrtrGamTq69bDt6HMZwMjS7JGM3wSR4m8lBSnT73EtlK3p1Tw4llBCeBKXHKkpUO5VNIcXG98Ju4pZtgwfPkOCcXxgzrX32aPGLFB61o9iZlNchoDR0+lGF0eGWcnQ3JoB71vE00y0tQ5jOPu28KaWlvT7PJ7Gg/ike9NbJxrIDjdx8kUHRy3n3ZHgsmkU4Kc5m+cpB1RkfRobsMdflEla1Hw1Uk2jS1IuafSeO9aHwcVEGIovznVgoFcNmqZqU113ZCRdeBINuB/vYcLeAUJhAK+q8+0KN07pXjbaUOoDgLXmz9evT2V0v5zag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaAHyXPXc68FWGbqcVa2TEcC3SNzZyIkVj2Z0GVvPT4=;
 b=jn17tljy2LQ2Kwj7fukC6b4NifcJgZTm/cfyJ7dv8kn9ZIySSEpUF+3WD5hq682/KGR+RF3rjq2+Zs5HHqprOgYQhYamsNvmqU4lraCcuoitKK/NFASeCihMjrp8GnU9+5+NpolThgwbUq5mU+L6jLITuBk7RFb1CCSCzKCaL4Y5g+TLvAIpOyT9IpWqA2LgpRsvtfdDiOG4PKbUTCHGel/+OlmHbCk5wSjJZuF7hu1iCwSO9eoh30eGSPwnPFhU8zfwbd7uXr2t0s8BQFmHjvkr274JRUK9yiXHnD5ijO6RT3Cqpzut+k6O5apMq1pPJHNGGqJt6g6//8+W886mDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaAHyXPXc68FWGbqcVa2TEcC3SNzZyIkVj2Z0GVvPT4=;
 b=ejH0m2pJ2YV+5uGlgj8IeVVvJxnsyBsr2+nor69V4It0kMCAXONaHrs5y88UR+aDwjr79Y9e7ZyAcIE2Yj47Rya5E2qvsYRq08P2TlpGdVVxaOcV0fa0/zZsOqS4TEz5Qa23H4J+mHmB/KxiEYxAPQY+2ssz81nJb23mmZmyDW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CY5PR12MB6600.namprd12.prod.outlook.com (2603:10b6:930:40::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 13:02:19 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 13:02:19 +0000
Message-ID: <c2c87ebf-e26b-4987-bf78-cc2508ec7ca8@amd.com>
Date: Thu, 9 Jul 2026 15:02:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Add support for RPMI to U-Boot
To: Charles Perry <charles.perry@microchip.com>, u-boot@lists.denx.de
Cc: Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Romain Caritey <romain.caritey@microchip.com>,
 Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>,
 Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Souvik Chakravarty <Souvik.Chakravarty@arm.com>
References: <20260708215200.1331416-1-charles.perry@microchip.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260708215200.1331416-1-charles.perry@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0098.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::13) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CY5PR12MB6600:EE_
X-MS-Office365-Filtering-Correlation-Id: c8517b69-2332-4197-7257-08deddba4ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 1ivV4wIeaTHw7EMkIjXBSBOit/5+l7lH5hHcJ8s+vkTbd6ThPMhfeyj82fSBEfNMBdzR3cCQ5ViFeU28U49mS/wYO5OSKpJGACBYO6HW1D3i5Qs5cobg1ilhMFUAeP/HKIUvjwR+6u2Vz8tMon/G1o9sfvrbnR8PH4n41zi5WR1EmhMc3CSmSaz93kodxfg5GZ0Con6+Ge7+onCY22w9mgdH8IkU51Z7igCef9KrWFALsd2zekx6k3Orahj/UyWgB8irxqu490sSPPq7Tbzdbz2eFd09vI0FacVwl7RHpNkAP2XQcRFqno0038/eYY9uwHdvfdhhRjtm1zeoFjPrh5v/9vfVF1JoftEOYB6onoIpZHpAAvv97RIXfzlttEdRQ5oH1z6EDL+0nlFx37NqKyC0zfdGLNLGc4VInWk2ELgxmNUUdjdNVOwM9eE0l73jvwqEz4lTUEvXQWGVDq7PFPclFeI/xMfGw32Anx1N7PdXuIUo3GFkYJ0chjoOCDs3N3RlqW3RRXTVjvkRXYOS7hd11RXovzJUA9J/w63jT7hsRMSkK431r9RvQvCLPPnXd2sUKdj4C7lckrfR4mVjJXkpqsW6WyaIdfTe7AnVAfY+7KU5JUPn0aY7JUqjE3HhDxUY8O5erKR2UXn2blRDprK6pQ6W2rfAD2BKJN2RZkU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVdSTlJCVTZXTWlKZGtVTm5xZG1LUmQyeTdZUW5CWmllRDQzelBIbGtvZFUr?=
 =?utf-8?B?SG9KbGN3QUppWUdtL3RvcWdVbWpsSEZzODhoOGtlYklTdUVNM0d1TTcyQzB5?=
 =?utf-8?B?RUxlSE1UMGhZSGZobDZtdHhUSHZtMFhhL081WnYxeWdweHltQnRiTVhHamN4?=
 =?utf-8?B?dTN3SlRNdWkrck1tdS93bUpZRFo0S1NsTWxlTzYyRmxNa2paNkJCV0s1SzBS?=
 =?utf-8?B?UDJtSzBvbzRTSWJ0VEJ0NU9Nd1VWTTM5RlRONXV4WmpQS3gzbm9jRDRqZTlQ?=
 =?utf-8?B?U3dCK0l2RnlnMmFiU3FaLzd3UjJVRU12R1pNVEc4ZW0rcnNNaHFrbFJ3eWp2?=
 =?utf-8?B?cSt6ZXZvNi81N2JvZVZHK3c4eSt6NHd1c3RzV2FsUUlTOGY4VVVTNGdRZk9O?=
 =?utf-8?B?RkxYZzhPejk5RGtCMzYvSFVoR0xuT2NxM2RSQmlEMllZUkFGWlp6emczay82?=
 =?utf-8?B?MkpQRXJkYW53SnRJcFhZMmhnTG5oMlZ2YXVmVmJjT2NQWVlZeERWMEc5Y0t0?=
 =?utf-8?B?M25paHo3SnVNR0dvMVJDc1hpNlZXZ010QXBoakZkQU5weDBVUFdnVnJvMHk3?=
 =?utf-8?B?V0MzZFA3N0RWWTcvN3pjcHR0WmdQK3hTVktwSDZGR3NyUWpnV00zdWlFL21y?=
 =?utf-8?B?cEJzL0UyaWZ1QjVpWmxwOU5QbnFyeUhLaEVrNWQ4L1RSbUVQM1JudWdmQmtG?=
 =?utf-8?B?N1dZNldCK3FEYzBxaW1HaExjbFg5SmNhLzV2dlBXTkF2YWNsUGpTZmM1VExr?=
 =?utf-8?B?N0F6ZWlETHg3M09TdHpUNTNYeG8rSGxJY3V1NXVUNC8yL3FQUWdtSXFobzFE?=
 =?utf-8?B?MHV3VXhWUUlhekJlMGVIRFgxcklRbzVzZTdyNi9TRGM0NVJFM21uUWNJWWNU?=
 =?utf-8?B?SzNkZDFkSGRkanFSalNkRVJ0Q3FBdXpKUTlPK1JTcmlKY3RCclJrQUhKQ1lZ?=
 =?utf-8?B?QnJkQ3JpU01vMUF6NUpUMmI0UGZvMWl2WjV5TmlHRXdHUUIvZ3A2ZjUxSk1a?=
 =?utf-8?B?aFBWT3J1NTdGeEVzRzNLZFM2MGVucW83RWoyTG0wSVZzczlTTUZIZ2VZUEFR?=
 =?utf-8?B?NHFrZkxPWGVCdFg5VEpmUTlSa1p3bzh3VTU2LzFybVpMQ1ZWWjFlaThnWURj?=
 =?utf-8?B?NzA2bnZTejNlem1UT2hOOE5iNXZVS1BSbUQvcGpHdlFvR3c5cXoxM0EzZkNJ?=
 =?utf-8?B?dEFSMVVqOXN1dWVaK0F6WVAvS3JzamNTNGxzclF1VVdReExxd0FLK05nYi9q?=
 =?utf-8?B?V3dHVGhKckFCNU41bUdiZ0hlUEJWN0hPdEpzRDdidTBEU3ZnUEZvb2VBWWZk?=
 =?utf-8?B?dlBmUzNPWjVnZktETUlxQitaNHhKQnV1akM0M3ZnWnRCajRQYzA0VGRnTGFQ?=
 =?utf-8?B?aENOenJncE5oUXdFd1BscTZyS1gyZy9MamVqR0M5UzAyMTh0S00zN1YxYUkr?=
 =?utf-8?B?VWhRczBJNDdTWmY4amlWNWtpaG8xTXBPV1VKMW90QzRDWGxQZzVKa2FTWEI5?=
 =?utf-8?B?L2c2VlI5M2NxSnNMNzZ3NTJndzJlZFJZVGt4cFJSQ0hEUlFsWEppQUtwRjZM?=
 =?utf-8?B?STVGMGNNVlMyK0ExVkl0aHBWbDdKRXlObmZ5WnFPTXViaDRuT0V3eWNMWVYx?=
 =?utf-8?B?YlZ3UUVqMEhHcU15dzhuVjJyOURTY3JQdFlabnJtMm9FaS92emtZRzE3aHRp?=
 =?utf-8?B?Ty9RdkQydE81dkozZUZkSTBjb3FQa0FHSHNBcEJrNUx2dkFRcm9KazFvWVFZ?=
 =?utf-8?B?SUJFY3J2Q3p6QTJKbGtkQlVZMWE0ZkRBQUxLVDZZdDBzTUhVdUcxcis2Ull5?=
 =?utf-8?B?RThYMkNTall2cTl6Y2QzaWFmYzVFK0pjQVg5dnN3ZlcxRm5jR0J3b004eWMx?=
 =?utf-8?B?ZE1VUWtFa2I3T1Z4ZS81cEVxNjZlS3BqNWNiTlFkUGtlRjJsYlRDR0pMN1dU?=
 =?utf-8?B?ZVV6NTFtNDN5aGFDZmNxOHJ5bngwaWd2NzJRUHY1bzBiYTR3b1JPWHVzQmsw?=
 =?utf-8?B?T1M0V1BSaWFvT3BRaDMwazd6TnBOdUZMSzREd0hQd0J0WVY5M0txeE1jVUE0?=
 =?utf-8?B?cWRmNlBMR2lUOVNCWnpPc2ZWdzBmeVVyUFlGS1M0OHdwUnBvb0hYTS9CRUYr?=
 =?utf-8?B?OENDVUI4R3ZQUm1DUXN2RXFlK21TcCtQSU5JV3dFODNORmdabEIxc3JVNXU1?=
 =?utf-8?B?NXI2b2RuQ0xHMVRZVmpxUnc5ZEl2bXduZ01GM28vM3M0UXRlZ2JucVpvVlkw?=
 =?utf-8?B?REMrUWtpOVJtZDg4eXZZQ2JOV2U0b04zS2NtTUJwR3MvTnNCM3VDeEdreEQx?=
 =?utf-8?B?V0dOOXRNZzc0Ni9rN2xhLzR0aTJ4MFc2TEhiM1EyRGVuNmtTa0RSUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8517b69-2332-4197-7257-08deddba4ecd
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:02:19.0430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHSBVkqNhY03Hz6jVqMcpJBSwT2t2f4sGNGhg3JQjO/0nsZRkinvOtgfazgozy3U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6600
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



On 7/8/26 23:51, Charles Perry wrote:
> Hello,
> 
> This series adds support for RISC-V Platform Management Interface (RPMI) to
> U-Boot. RPMI is an OS-agnostic protocol for communication between an
> Application Processor (AP) and a Platform Microcontroller (PuC) [1]. The
> goals and purpose of RPMI are similar to ARM's SCMI.

 From the first look it looks like SCMI. Why do you introducing something what 
can be replaced by SCMI?
And SCMI has only specific ARM transport layer but the rest is arch independent.

In our case where we have Microblaze V in programmable logic I can't see any 
reason to use RPMI for talking to the same server if I need to do it from ARM 
side too via SCMI.

I pretty much think that there should be communication with ARM and instead of 
creating another firmware interface talk to each other and have only one which 
can be used across multiple architectures.

Thanks,
Michal
