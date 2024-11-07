Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32DED4335B
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 12:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76A6188FBB;
	Thu,  7 Nov 2024 13:54:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kPwAzhs4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F376289259; Thu,  7 Nov 2024 13:54:16 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2C0188D9E
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 13:54:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usmokVLMqzTbQkMg1SpbExzfH0TSYKrSOjMFgb1ebyZva1gnhNLFX9arNGi5ILj/f1I+2lHsf4TZemc8po8pqs6DHzVd5PVpIsLRgcsWVQbMWiL5t7tzLIsvRg/PLxmOwktbDJ8OB/cw7czjOb+e+kdy+PTI1kh9CR0NjB22QGVbx6IKO9G7igD5kIsbR96O02jE9TqrlOl3cHZMxQB4UhpC5jGC1DY148bWR6JuBTMsraBgsYlAV9scMEzx3j6O5YY8Lcyd6OKHtxXZUASI+JCJpFtRXAdDD+aPj3JBY72bExWohN+cT2/jaen1xrGD90d0qdK2EuFdRLRIIAqSig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypuWdNQIMJMmg5quMS4eKSbC/sgifnFuS5IkZV0nQRE=;
 b=VzqjT7D8mWrHLJNuzgR9KE12b6XgH8wHfxxvsDzR36vRs8sw4WdlyEegs+XfCuMmkeFYgxriY23rYJxTksqlniqYrDHYo37WRkOMxkOtZ8J6XgqbnWzRnqc3LUgAkToNMWMvuTC/qpR01E6UfgjBs44zM5cVtqoNlnhwbHUCgXAAx13CzKfzyqm+gAV1rctqunQUlOzxEdZvCuDwPAX8Z7HPcyewq78FXSohx9Ez25BEO5jAWnK1Otlh/KuYrLu1VvAVdfVQSWufrUvX8YdZijkVpFAqZ8mCqn1Ufdazega9mB1mDokVvyCxZJvN138on0AJ7L/qNKplchBi3ZIp6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypuWdNQIMJMmg5quMS4eKSbC/sgifnFuS5IkZV0nQRE=;
 b=kPwAzhs4dppLC5MriV+ypZZlc3W8ETJJeaKlMG7pCQGTZ6Q0X2XmK36DHjYulxAnFhO/UZ2i/mLGY9BCevOv033Ug1HOPXEEVKR+SxKDvGVAWZy2oC4Q0mj2K4VX8U1GFmDrLVg93WfE+0pkgIPmXUlC2yubyB5r2yfvscbpY1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB9040.namprd12.prod.outlook.com (2603:10b6:8:f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 12:54:09 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8114.031; Thu, 7 Nov 2024
 12:54:09 +0000
Message-ID: <409c2b37-046e-4343-9fe0-7cfb818ecd35@amd.com>
Date: Thu, 7 Nov 2024 13:53:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cadence_qspi: Refactor the flash reset functionality
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "vigneshr@ti.com" <vigneshr@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>,
 "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "william.zhang@broadcom.com" <william.zhang@broadcom.com>,
 "stefan_b@posteo.net" <stefan_b@posteo.net>, "git (AMD-Xilinx)" <git@amd.com>
References: <20241028092430.19841-1-venkatesh.abbarapu@amd.com>
 <f52cea21-8171-4fa3-9fb6-b8e54344fd0d@amd.com>
 <SA1PR12MB869780A320010907ACB78979985C2@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
In-Reply-To: <SA1PR12MB869780A320010907ACB78979985C2@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0016.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::28) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB9040:EE_
X-MS-Office365-Filtering-Correlation-Id: c6fbeead-2e87-452a-fdce-08dcff2b4518
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUtqZHloOFJsQVdIcDlHQXFlU1RvU3hzL0dIZktOY2ROVE1ZOHQ3N0RLMllN?=
 =?utf-8?B?OTlrMk4wV1FwVW5UV2pHZXJZdmZwdFQvTnE0cnRlRFpxUHl3dnFvS3JOM0pZ?=
 =?utf-8?B?YTh5VTh2clNPMUxaNG1QWkZIVGFOQlVLay9hMnF2akdidEt2M3YzOEFGcm13?=
 =?utf-8?B?bGZ3dEdnMmNBT3hJcFVHd0FqSG8vcjU5dVpJQ3NjUHpWUVN4OTAwL2FETUw0?=
 =?utf-8?B?eFd3QkE0QzdYYWIzdFUvOXpwd1FaMHJmUGVaT2V4U3hzNnc5R3Blc2NtMld0?=
 =?utf-8?B?TEJQZ1I0WXRnNS9HZFFvK3R4UmVDTHZlNzR4ckVJTmxzOFExQlU3WUlGdlo0?=
 =?utf-8?B?Vm5hWjZtWkxoK3hpL0JBMGwzOXdDSldad2dKYnR0blpiL1gzTzZRU0luMmw2?=
 =?utf-8?B?SHY4em4waDRHVUJCbVErRkswVVhwc05aMGlrZndjMlJwRUVPL0k1TnVYQk9o?=
 =?utf-8?B?Zk9nV2wrM09LM1I3VE1UelpHaTV4RWVOQkNuMmh4cnQzcTYrTTQyRnRCOEVV?=
 =?utf-8?B?UG9mRFJzV1BzWkJjZE43RlFuYTJjbm5yVUtmeGpSZGphWWE0RHRRQi9hQzhx?=
 =?utf-8?B?TUNyVUZWVTNYNVQzdFBKZXFxTmhYT0hKSVI0TUk0WEJvSUdhR3YzVFpUamVu?=
 =?utf-8?B?aDlCM0M4Ykp3Q2lJaFQ2MXpOSlczRHVxNGFMQ1Z5c25yTmJPMWZyQ2gvRTBq?=
 =?utf-8?B?alFQL2dKazZ5STJnMGtKbkdldkZicnErOVBIVnhxb01uRitmaVZUMFlxVXdC?=
 =?utf-8?B?dEFoRXlCYVdrZFRWYWxFZ3d1U2FGNjVRODlKb0tPWXhjKzhJM0tIZkh0SW15?=
 =?utf-8?B?VVFEVTllekMvaHlEUTVIMFFsWlJ3YktMejU2ZkxObkxNT21PS285dHBpSUN3?=
 =?utf-8?B?VXZGK0IyamdvOExWRVgvOUNpbWkwY0FpSy9WSG1UejdRaTZSanZPTS9tQlQy?=
 =?utf-8?B?NDRxb01MbFcyU2lrVTQrMkpRbHpkSUVlMEdqdERSYTFaWHUwS1ByZklCZlFT?=
 =?utf-8?B?S3dNenZmQUMxRGQ0WG9zQzZmc1RKak4wSDlSZTQ5NW42ZzE3RlZITkZOUnZG?=
 =?utf-8?B?NXc2UWphZTMrRWR5d1F1SnpDUG9MVW91VmJqWWIyNjUxelpEcTV0bStLeWIy?=
 =?utf-8?B?bzZEUGJqNmk4R1lsdTZQdGxOQnk5QmVmTHFaUk9rcUV4MVh2R08xbWE2Qngw?=
 =?utf-8?B?U2VRWmdCTVNOK2RpbzNsa0tXSEhwYzFyamNaa1RkV1JaS0ZoQ0JIYmRUNTJq?=
 =?utf-8?B?eWpCM01uaWNpVWY4eDhwaDhoRzk3VlpHV2tRRVpHOFkwbXlQdEdPTTVPUVRs?=
 =?utf-8?B?V3VDa1RUSVFhL0p4Q2hqWjhXczc2UWNZL25vbFF6RGIrZTIxL2hDbEQ5U3RN?=
 =?utf-8?B?SzN2TXNZcndqRUMzUmkwNzRkUWorcHV2SFd5eHkxYUY4ZGlsaUsvbW1URDMy?=
 =?utf-8?B?YmdncDBoYlNrTloxUFVwTFVJWUt3YmE1MVR4K1BDbHJQMXFIUWR1K25zSGtW?=
 =?utf-8?B?eXZKTjJTVGdQLzdzK3ZKMnJpNjg0TzY3UXZyVGRZbSs3V2FEVmRYMG5WWFo1?=
 =?utf-8?B?WVhpdzBuUE4vZVJWRDQvVFBkc3JxSnNMSEh2bnRJaGFGR04vbWFBY2RBdnFo?=
 =?utf-8?B?YnltVkRrUlFmZWRyWXFrSmM1RjZvWVB0eXJ5emlVUVVOZm13NlArdmN2T0N1?=
 =?utf-8?B?aW5LbEF2SHgrWTY2ME12N1E5M2hISmFndXltNWNjZjRIb3pmQ2xlZVgxd0pW?=
 =?utf-8?Q?8g+h7otqHmE11hMQsW8cz8MsK/g2rfWbzNJM2VR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWFtSEFaVzlmQjgwK3V4RzBHQjhjdThkZWVQbVBicFpZZGN6OFJVbkQzTE8r?=
 =?utf-8?B?NGtmZHMrdndYYVlyYjhTaTRueEEvSlZrTm5pbkV1WUVaZ3NGZklUWWhGSGlU?=
 =?utf-8?B?NFdrOHFUWEx6T0hCWk9wa2VJNGlPdnNJakR0K09CeHAxWG5FRXgrVnVmQ0h6?=
 =?utf-8?B?OFRVaURkWWF4cml2QU5UNjNmTFdLZ3NVS2swRnZDSkRxZEJ0SXJYNXAyT3c3?=
 =?utf-8?B?OHVZdUR3VHFPQnBMSEkvUnVsdFcyRHlvM0JiVkJadmFIWFhyeUdGS00wSnhl?=
 =?utf-8?B?ZjNVdHFHeTRRT1dVS1ptSHJSN28yaE1ZREZDS0ZGMDlCMitCTXRjVlFvQkw4?=
 =?utf-8?B?NUFEeTlVTnJOWTZ6UDJ0U09GTzdvbm5IT2N0alZCN3pQUUpUTUtsam1aTlpt?=
 =?utf-8?B?WkZyRmhVYS9ST1RGNzJiZUxrY0dmQnVHUW1BOG9wbmtOSXVzUkUzV1NPVkla?=
 =?utf-8?B?VmxxRHI5MTlpUU9xYmg3eFFQYkw0RnVEZVhFbTNGRkZxK2dFV1VSeDlqclZS?=
 =?utf-8?B?c09EdzU5bUdqNzVVVktNZ1BZdHJhSHVwZjVKQU4xYWdGVXJnUklodjhwMUk3?=
 =?utf-8?B?M1NQNzYzSWhDTnNDZTBoUHNyS2pOaFB5NGZGc0FHZW04clZ2dnpGZDBWejdF?=
 =?utf-8?B?OElaNUlNUFJSYlMrb2gyT2s0T0s4bVJoODdIaEFuK0NPT2FITnJib25xdnhI?=
 =?utf-8?B?KzlwMEZXaGZXZ0FEVVdwZmNBVGswOXVkTElGN2dZUDVTS3JuRCtZMmo5OFJR?=
 =?utf-8?B?bkhGK1dBY3o0RnN6NEpqNWNVRDV4K3JUVjY5Q21WS3RIQkRJUlFoZ1QrZmkw?=
 =?utf-8?B?Nnl4d25Yei83c2Q1Z1ROWG5lZmlCaHFSb29BQ1Bqd2FMV2U5WHl4MWxsaXdp?=
 =?utf-8?B?aEZvYlVSLzZJcjdaYVdKWVQ4MDdqMXloa25CekRYeThUUnlvMURVdGkyVjNs?=
 =?utf-8?B?SVZoQjU2YndSMHUvUGhiSVRoc0FPa1ZoT28xS1VtZWVsQXBBNHJGYVUyQmxh?=
 =?utf-8?B?Rkp6a2ZIOGNUWXFkd2w1QUtGY29JcDZkeVJ3YzV3V1pNRk1jd2NTS216aXRv?=
 =?utf-8?B?TVBsYzN2NGRyTGZLVVdyS3U5Q1QwTkpiTDhlbU9PM3ZxVGxuY3M4aEdvS054?=
 =?utf-8?B?bDhXY0djeFBIQmlITmh6YldSdHJKV2s2ajVJUEpWR3RES28zYkQ0eUxvMVhU?=
 =?utf-8?B?M0tJOHhITzFUbkdQYXNxTE9zSjNMZzdsb0E5Smd2cHQxOVlHVTFKajNONEZQ?=
 =?utf-8?B?aDZqWkdtQ3JwVkpUOFRucTYydk53YU40RjNrYytQL0ZiWS9LRVlZbWF0QWFJ?=
 =?utf-8?B?cHN1M2swZm5VUEZQcVdRTW5QL3YrNE1EazZKcThnWEFCTDRHUTFWeFdKb2Ev?=
 =?utf-8?B?b1lXdWcrODNGR3VIQ2dGcms5OFcxd3lQK05VSHBWY2N5dzFPS2ZHSkZVRDhK?=
 =?utf-8?B?bUJLZDhtcGVUck1BNkNqS2IxQW4rNVVWS2xKWUl1N1VKV0krT3pWbGFkU3Ra?=
 =?utf-8?B?QmF1V0dmNDdyZmh5NGs1VFYrMEUydHRTTGhBdVo5dGpwNjhUUzd0YjdER2JB?=
 =?utf-8?B?TEJLQXR1MTZQQ0dqZUNTQ3JmTWpxUDloeVNQdy82d2xLUUY1aTF4WVhZQXNO?=
 =?utf-8?B?VzBVMmZwMDBpY3lnVDhpRHErQmZoSDZCNnN0dzBUYlZXakhYVDhoS1ZsS0Va?=
 =?utf-8?B?OUJ2NFJGTjhJT2syREVJbnFVMEhnZzdON3RxbS9ieFVuaUZKT0FHZ3VCYW9n?=
 =?utf-8?B?NFJ4SVV1VkEyTlFCSUo4a2l2aURURm0vQVdDdUtBQ1VEZHIxbDFpSlFMbjcw?=
 =?utf-8?B?MDhmdk4xVUN5aE9LRTI4SDRucThZV2lIdkVnUDlmOFBDU0VEWjJ5TlJDRElr?=
 =?utf-8?B?dERXbW5vcURMVyszZXNNZWcyemRjeWJvT2Zjd1cxVG9YWjZNY0lCeVM0NzY2?=
 =?utf-8?B?V1orTGtXZDY2YWdsVFVib3hCUU52K0VRcmMwTVRHL1hSQWl4V05qaE43ejNv?=
 =?utf-8?B?aHczWkZJM1RtSkRNWUlUWGljdW1qRURWSE5pbzVmMDNwZE1tZ0doRVZncVBH?=
 =?utf-8?B?WXpZWW5GV3BTMERzTlpEZ1dsVWlQaHBEWjNuZ0xSckd1dnBYcDZ4Yk5UUFR3?=
 =?utf-8?Q?UNEuvF6tg9JBJW76QIBpTxDuH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fbeead-2e87-452a-fdce-08dcff2b4518
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 12:54:09.0228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRFcRwyYNckMJh42psS0yiQlbegA+DSxVJLgI3G1aYc4tpnIUxdR7LpuUMfERztt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9040
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



On 11/7/24 05:57, Abbarapu, Venkatesh wrote:
> Hi Michal,
> 
>> -----Original Message-----
>> From: Simek, Michal <michal.simek@amd.com>
>> Sent: Wednesday, November 6, 2024 5:17 PM
>> To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>; u-boot@lists.denx.de
>> Cc: jagan@amarulasolutions.com; vigneshr@ti.com; u-kumar1@ti.com;
>> trini@konsulko.com; seanga2@gmail.com; caleb.connolly@linaro.org;
>> sjg@chromium.org; william.zhang@broadcom.com; stefan_b@posteo.net; git (AMD-
>> Xilinx) <git@amd.com>
>> Subject: Re: [PATCH] cadence_qspi: Refactor the flash reset functionality
>>
>>
>>
>> On 10/28/24 10:24, Venkatesh Yadav Abbarapu wrote:
>>> As the flash reset is handled in spi nor core, removing the flash
>>> reset functionality. As the configuration like tristate and hysterisis
>>> need to be enabled by the cdo. Handle the flash reset only for mini
>>> u-boot case.
>>>
>>> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>>> ---
>>>    drivers/spi/cadence_ospi_versal.c | 43 -------------------------------
>>>    drivers/spi/cadence_qspi.c        |  7 +++--
>>>    2 files changed, 5 insertions(+), 45 deletions(-)
>>>
>>> diff --git a/drivers/spi/cadence_ospi_versal.c
>>> b/drivers/spi/cadence_ospi_versal.c
>>> index 222f828f54..de51e4c37f 100644
>>> --- a/drivers/spi/cadence_ospi_versal.c
>>> +++ b/drivers/spi/cadence_ospi_versal.c
>>> @@ -125,48 +125,6 @@ int cadence_qspi_apb_wait_for_dma_cmplt(struct
>> cadence_spi_priv *priv)
>>>    	return 0;
>>>    }
>>>
>>> -#if defined(CONFIG_DM_GPIO)
>>> -int cadence_qspi_versal_flash_reset(struct udevice *dev) -{
>>> -	struct gpio_desc gpio;
>>> -	u32 reset_gpio;
>>> -	int ret;
>>> -
>>> -	/* request gpio and set direction as output set to 1 */
>>> -	ret = gpio_request_by_name(dev, "reset-gpios", 0, &gpio,
>>> -				   GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
>>> -	if (ret) {
>>> -		printf("%s: unable to reset ospi flash device", __func__);
>>> -		return ret;
>>> -	}
>>> -
>>> -	reset_gpio = PMIO_NODE_ID_BASE + gpio.offset;
>>> -
>>> -	/* Request for pin */
>>> -	xilinx_pm_request(PM_PINCTRL_REQUEST, reset_gpio, 0, 0, 0, NULL);
>>> -
>>> -	/* Enable hysteresis in cmos receiver */
>>> -	xilinx_pm_request(PM_PINCTRL_CONFIG_PARAM_SET, reset_gpio,
>>> -			  PM_PINCTRL_CONFIG_SCHMITT_CMOS,
>>> -			  PM_PINCTRL_INPUT_TYPE_SCHMITT, 0, NULL);
>>> -
>>> -	/* Disable Tri-state */
>>> -	xilinx_pm_request(PM_PINCTRL_CONFIG_PARAM_SET, reset_gpio,
>>> -			  PM_PINCTRL_CONFIG_TRI_STATE,
>>> -			  PM_PINCTRL_TRI_STATE_DISABLE, 0, NULL);
>>> -	udelay(1);
>>> -
>>> -	/* Set value 0 to pin */
>>> -	dm_gpio_set_value(&gpio, 0);
>>> -	udelay(1);
>>> -
>>> -	/* Set value 1 to pin */
>>> -	dm_gpio_set_value(&gpio, 1);
>>> -	udelay(1);
>>> -
>>> -	return 0;
>>> -}
>>> -#else
>>>    int cadence_qspi_versal_flash_reset(struct udevice *dev)
>>>    {
>>>    	/* CRP WPROT */
>>> @@ -209,7 +167,6 @@ int cadence_qspi_versal_flash_reset(struct udevice
>>> *dev)
>>>
>>>    	return 0;
>>>    }
>>> -#endif
>>>
>>>    void cadence_qspi_apb_enable_linear_mode(bool enable)
>>>    {
>>> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
>>> index 9c466f8695..f8c3fe8428 100644
>>> --- a/drivers/spi/cadence_qspi.c
>>> +++ b/drivers/spi/cadence_qspi.c
>>> @@ -258,8 +258,11 @@ static int cadence_spi_probe(struct udevice *bus)
>>>    		if (priv->read_delay >= 0)
>>>    			priv->read_delay = -1;
>>>
>>> -	/* Reset ospi flash device */
>>> -	return cadence_qspi_versal_flash_reset(bus);
>>> +	if (!CONFIG_IS_ENABLED(DM_GPIO))
>>
>> I think this is not the right thing to do here.
>> Because there could be boards which requires to do some other GPIO handling out
>> of spi core. I think this patch is introducing limitation for nothing.
>>
>> I would keep origin code and just move this condition to
>> drivers/spi/cadence_ospi_versal.c
> 
> This function cadence_qspi_versal_flash_reset() is specific to AMD only.

yes I know and we shouldn't really bother generic code about it.
I think that function name should be more generic that other platforms can hook 
it up. But logic when versal requires this only when DM_GPIO is not enabled 
should be in vendor specific file.

M
