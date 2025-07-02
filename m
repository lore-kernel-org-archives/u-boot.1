Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7408C83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 07:34:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4327A81FEE;
	Wed,  2 Jul 2025 09:34:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LxLHXC26";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62BA282103; Wed,  2 Jul 2025 09:34:55 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::60c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3806581E13
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 09:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWSyHdDOedgOXmfoTaq+e27UdK4BT8jrHXifHpscS5xj02Trxxz8kiC6FqLDUAU0EmpPB5a9Me6B5m38qpaDJoNKXfrSwxwhrUScARHenG4qEtAIgVWyXuBhjLvT8EjugSsdWnVk8aUgoukvG5fSFVqtvXbLpRn2udDXQM4zdK2XsFLskRH6NT2rCfhN2o5ewTmr0myuK1ZQxtj9GMnIsDvqAxqPSV6mahWtrzhVWX+WlMkR7ex8/pRx+kVLc8abkmIKXXczpSOOsr0FgUGK/QkmI407CBbuR5Fz6hlwsnK1jqwjYgSQbrEdwoC6VTJ2imnmeAhMb3ugG+86akHoIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgzYww9jidyUT5oXR3iuuvbAjYrUMLT2huK59l0p3Tw=;
 b=zCSSx3xZoe662rl4KwChVQBOs5s6KcrCW4+bHf2n+LlJrwcVRETVwi8CWvAa8dffYOtvD4w377gzHOXBNulGiTLv7SJL5g+5DP0f5yRoN7PDUsHYy4+6prh/aXF1DA8H/sN+fTuvEpBhe66SPr9Oj4waOphKfhzZOxt+1tVJqBZNPNafx7zbOfz2OFjEFP8DcQLRVsWBtdV6RTGA+anOR5q4Ny6lM/6BhnSU7SNpJjoNZY05ZqnunYv/YGdeJtqSQASYo5KUAGtLFqDDcgrNR1KAMPpIf9m5Rrq2t4t565FS1G+E1O1ntRHwKxLNJZGwdtDSnMDrVxcGNz/0zGTn2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgzYww9jidyUT5oXR3iuuvbAjYrUMLT2huK59l0p3Tw=;
 b=LxLHXC26E3OMdNCIRHWIEf/dalgSqGG0JvyntQDD7R1LZBxF/jYZL4Ra2Jw6/dvFsCts3WkT1gk9pCP8NaeAoBFVFUXBXOZIRruk41zUwfrN/xCxrRlsuwvcmwJiBELaVn3bbk3Y+z69CTcqcY/xsoDBOUBympD3Ek8MxiZQ4+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 07:34:50 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 07:34:50 +0000
Message-ID: <3bd079bd-1b23-4fa5-8f78-96618504c24a@amd.com>
Date: Wed, 2 Jul 2025 09:34:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: zynqmp: Remove PSCI_RESET from mini configurations
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <cb5189d676852cad7ab3c0691490b2d0dac618b4.1751014928.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <cb5189d676852cad7ab3c0691490b2d0dac618b4.1751014928.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0062.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::39) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA0PR12MB4368:EE_
X-MS-Office365-Filtering-Correlation-Id: a45b8520-7045-4951-1dcf-08ddb93aedc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?am9sTWNhZFpJOXI2MlQ1akhSMXUxM3hxR2ZyU2ZFUmpScnBRcEZla0JIVlhv?=
 =?utf-8?B?aDFWQWFjZ3NqQkVvbHY5K0lycU9ScHJINEhwcXZWWUN6UURtem55YUhzaHJM?=
 =?utf-8?B?WjVPRjA1c2UrdktIamordStjZjRpakJwcHUwVCtVSzJ2OS9NRllGVmtJZ0Y4?=
 =?utf-8?B?c1BtMy9XeUNIWU1KYkZPSHNlUmV2TlJMVU1tbzNuZDRrZnNTUnpwR3hSYVZL?=
 =?utf-8?B?cGJnVk05d2paR0VyUHRiY3FtT3haMUU2RUZGUXJza2N6WmxWTkZkMkUrY0o1?=
 =?utf-8?B?NXZSSVJraWI4am9JWi9RdkpZOWVQWC8xT2x1Ym1KcE9aVFJhZERHQ0hvSVh0?=
 =?utf-8?B?a3dqd0RVNjhTQkkxb3N2Mm9EaUFDSEJlb2FzWms2QkVia3U3dGNyZUdGSHFw?=
 =?utf-8?B?S0dURUhTZEoyOUwyRWdhRTN5ZElybzhYL3dPbUs2UWUvMGJ6THJCTEZITUpW?=
 =?utf-8?B?RzhYcFlDeG9MTnE2aW1EajJENTMwR3p5ZTVhQUJ1ejZjSlVoVFYxaC90cTVT?=
 =?utf-8?B?emFJOGE3YWRHSC8xNkJubEZwVWJST0lQUHFWMThYUlc5Y2c5Z2xWYVorMk45?=
 =?utf-8?B?K0o4MlRsTHV6UzJuTTFHTWhHYUNlQVcyMU9zQm1aTHFERjM2NmxPd2ZlU0hy?=
 =?utf-8?B?eE1PMHJSd0g1SUE4TGRtQ0Vmaml1aG1OR3lWUk1GOFVNYkxpczhncGwxRkw0?=
 =?utf-8?B?N1pwR2hTSkNCVFFpZ0ttK2xWQ0loMnpBWEdCUUNvUDhCVjNPM3VPSnlzRytD?=
 =?utf-8?B?RGY3aVJjdE5VcktEWVVLNEM1bVBzODYvcXliWHg4QzlxUjRkbUpYS2Zzemda?=
 =?utf-8?B?QmgxWHVhRE9Sd3pDRW1ONHJ6ZFo1elhhanA1ZUl6UWJ4TVpMbHFhTmhqWDdF?=
 =?utf-8?B?NjUxa1VmUTNOZ3lvOWtqWng0eUtEeWNzYTNkK3YvSTBzUi9kTzBjYWVXMEFs?=
 =?utf-8?B?VytzMUl4ZlNrcG1EZ1hMWjZKZjVEWktKNnh0ZllhOENpZlRjOGRNaEhZUS9O?=
 =?utf-8?B?dkhsdERuZ0Q3NWhOcTBzMjV4WWFESU1tbEVwYVRoTWwydGtUYTdOMHJDN0hI?=
 =?utf-8?B?cFloY3I4U0NFZ0RDUlZXc2xMUzIya1gycEdwZXBBNTBSM2VYeU56bDVNNlNB?=
 =?utf-8?B?cW9BMWJycGI1ZFdVOHg1T2gxVmlBUUJQa0toMEJmZ0hrUUUvQ3d1VmtseUhG?=
 =?utf-8?B?NFV0T3RiRzQvc2pmTmZpakVmRVcxM25BUjZpbXN0d0lFMzNxa1J6WGFnaWUw?=
 =?utf-8?B?Y1dtWDJZNHRoMVc3WGZmNWtibjhMVDRFUEJ0Z1RyNmhDejVtZW9uYTFQODlj?=
 =?utf-8?B?amY3MGZDbWNHWTNPUzRPVnZTUllTQzYxVnE4Q3N2WndkT3cvd21ZNFNZSzJl?=
 =?utf-8?B?cmV2M2g3em5tQWQybkYyZE1QdXBwNjhxcnZLOWMzZ0FzMTViVlF3d3R4YlA0?=
 =?utf-8?B?dEJPeWZtVDd4MVRldGVNeitWTERRdWxjNmc3VkZYMEhna2UrS0gvRVVaOENn?=
 =?utf-8?B?TFdJYTA2RmZqZTZlWWtSclRucmpOZnNJY1Nwa0ZjdUplR3lWMHR3eUJjZWxW?=
 =?utf-8?B?ZUltLzl2d3NpNzFzMmJEMmpOVmVBSDRuY0hzbit4NDhDeHdsd2p4RmY5RVJF?=
 =?utf-8?B?bXpjd3BUSG5ZNjhhWlp3b2k1NCtIVFlWZzZwL2NjaEpIOTFoSUZpWURGeGJZ?=
 =?utf-8?B?M0hkSVJOc0xwOEFWSWlEZDQ0RnVHNzNxWC8wZ2R2SmFZNTdGMnprdGpxNEtq?=
 =?utf-8?B?YXBhQ3Q4ejlLaXZjeS8yQWp1bThvUVRyL0lQSFBtM25uK3NFZ1dUOElmZ1RF?=
 =?utf-8?B?d3lmcWpTMTNlZGRIZWU3SUFHYW9oZlRtUmhlTXg3cDI0ZVlVWjRhb2JCWURr?=
 =?utf-8?B?WWl0RjdRQUVnUHpVMHcyWEptUjFHUWFuTW0raUFYTTNDRnJRSmM2OC9jU2dW?=
 =?utf-8?Q?T0F1tIxyMeU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGxScXFkR21GYmM0UHovd3o3T21OS2RNU1dGa2hiQnd1R24zSHFONm5IaFJX?=
 =?utf-8?B?NmdFZXBmaWN4d1l2WUFIRXo5Y1BEeUNlRjVHRTQydC9QWDJtTnAvOEZnZ2pJ?=
 =?utf-8?B?TUtwWmVsUHd0ZEhFUHkzUmd5Ukx4SFl4VW84WUM0djlOTnUvWCtKWHJrc29i?=
 =?utf-8?B?WFN3RXduTVBwZ0ZnaDFQNm5RZTVBTXF1WStTVmlqRmdPOElTMFhIM1ZkekUz?=
 =?utf-8?B?MGY0MWZSdVFYTUplNk95UDVUTUJGejEzR3RtTWthZCtxQTdOdWk0d0dISW4z?=
 =?utf-8?B?WmZ3MUtJWHY1ZER2Z24wSW9PUmtjM2tqVVY3c3pTZVh0VmJDcHJjRzNvUTYz?=
 =?utf-8?B?aXlOZ3V1SmNubGJzS2V5cVpsb1dJT2JNaFdIOXI0YXZreS9wQWhqaFZvenlh?=
 =?utf-8?B?YWxaNU5XczQwVHZUQTJXUkVaK0hMV0pSWWRmR1hXdkNxcHE3SWdnVCs4VzNI?=
 =?utf-8?B?YWFvVGlHMlN4dnBNZFVFWnE1K0RMd3NZMEtJVDJsdlBKRkYrQmowZlY2R1hG?=
 =?utf-8?B?SjY3OFptMFpmN0M3VmNJQUVSRlVuRE5BTG05S0I4WW1zOW5VRGMyamp6VDdK?=
 =?utf-8?B?Z2JDN0VFdFBEYnVxQkhISDhpMHY4TSsxQjZXMk1qSkNGV0JpNFhpSEdwZHZs?=
 =?utf-8?B?aUR6K2FCbEdYTzBYSjdaZXM5WS91eWU5RHhFSDJKcFlodnFqWjdXN01ib2Ni?=
 =?utf-8?B?dUpHck85SDZNVmxsVU5IYWNiZUtxMERWSUoxMDVXeVVoUDd5WXF3Nnk1YWl6?=
 =?utf-8?B?TEhkU2EyYjArRms5bWpHV3FHajhEdmpDLzhvelBKaHgyMFIxZlZtZkUvWDB4?=
 =?utf-8?B?ekJTOUxydlJBMVR6ZTJITkY5Q0Z4RWJCMGhSZ2JjdlovME04ekJ1M0pEYWhL?=
 =?utf-8?B?M2dXck1JY09iY05XcW1qWi9TNHlKTUk1R0Z5ejZDUjZrUnVvMCt1dDhtSVg5?=
 =?utf-8?B?c0RxSlBmT3FOUUw2dzZ0eFp1SzUyUS8zR0hPcWdld3hBYmhIaFQ1UDlKQlR4?=
 =?utf-8?B?amZRTUdhMEhQRUlOOUlDa29lUmJ3Szlhb1J5UTg1bFdwcGg3NnZJZWw2VS8r?=
 =?utf-8?B?YVRHSDdvUlFMTU1hL29yL3FnSE9NMnNnNXVGSW53QXBVUjRIR3U0a3Z1eEpE?=
 =?utf-8?B?QWZLYnh4b0hRVVRsY2o5a2RXb1BpSXlmODJ1MVNSYzNacTNQb05yOVJ3Nkcv?=
 =?utf-8?B?QmlvWW5zMHBFSlZkNXdjWnF5ekJwQWt1UE03L2RTRDU2aS9HNUlHVDg1UFJo?=
 =?utf-8?B?UGhTZWQyNU02eG1xZVkwZWdrQjFGY2xmeHJmY1JmK0ZHUFhsSUlxZURZOFR4?=
 =?utf-8?B?bXRZWjVtL2ZqdCsybWRkSmErTm5iM0pLTTRVRC9MakV2TTI3SmxyaUtXUENQ?=
 =?utf-8?B?S3lkellENHYxOFZxdTZkc0dzRGZsSUowa2pJMGhpWGUrMi94VnZCZk9zWlBy?=
 =?utf-8?B?N2VSdm5mMnFJb3BsbGJUVEpPR0g3L3MwOGZnblprcDNIUkpoc1ZHbG5ZbWdq?=
 =?utf-8?B?QWhkM3FqM2JQVmdZcWVWN3g4YU1YK2FaQU4xNzBVOE50c1FqVUk0VnBGQ29q?=
 =?utf-8?B?aXJoUWtXQlY1T3RVd2ZTVC84OVlZV1AzaFJKZ3lzVWxnZFhoTGpwaG5ZWDVo?=
 =?utf-8?B?RUVEY2RGSDRSandWcjVPNUgvdiswVnpBRUhpMzB2MUR5RExMNzdlN0NTeWZv?=
 =?utf-8?B?ZWlWb2ZnejZmTFFjRldiS1d0WEk3N05wNXlTRkVzZHA0U0pOWHgrbVdlRHFP?=
 =?utf-8?B?SnlXSGN3LzBDMjg5Z0daRFBYNWxkdlpnVGVwZG1CNnYrdTAxTzVSZkFkaEow?=
 =?utf-8?B?WUp6dzhPUFhVZlEyMU8xNnBsM1FaclkzY0dSZThUNDg5L2ZnMndxZkNPUE1y?=
 =?utf-8?B?QkUwemVYay9GZml6WFI1Vm41QXRTM3lDKzhKQ3BCZTU4WnBDdmZXUklvaG5u?=
 =?utf-8?B?U0ljZEJLdlJ0YzNVaHpZVk4yZFR3NURnVWZUYjkyY2FhdTNBS0J4L2h1Q3B0?=
 =?utf-8?B?T3huVmFaUHU4VUs0T0tnbGkrbkNtUmN6VS9ySkxVRmJ1TXkrdTBoM2hmWVEw?=
 =?utf-8?B?dXhZWElsUlhJMVRSd2o3K1lsWWV5aFRBVVZhaUNEaWJmeVhRTERwOExqZTZD?=
 =?utf-8?Q?iXsbtSsFLDlhhnsj/hMQ5POP6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45b8520-7045-4951-1dcf-08ddb93aedc7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 07:34:50.7556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BXDvRaQlLH/P+ZbW9WaMSSfVZHYlmy4ZSCVZgsRp6wIHt0CKZ8W+jC3aOPpdUHI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368
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



On 6/27/25 11:02, Michal Simek wrote:
> There is no reason to call reset in these size constrained configurations
> that's why remove it to get some space.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/xilinx_zynqmp_mini_defconfig             | 1 +
>   configs/xilinx_zynqmp_mini_emmc0_defconfig       | 1 +
>   configs/xilinx_zynqmp_mini_emmc1_defconfig       | 1 +
>   configs/xilinx_zynqmp_mini_nand_defconfig        | 1 +
>   configs/xilinx_zynqmp_mini_nand_single_defconfig | 1 +
>   5 files changed, 5 insertions(+)
> 
> diff --git a/configs/xilinx_zynqmp_mini_defconfig b/configs/xilinx_zynqmp_mini_defconfig
> index 33f85f77ce3e..8aa4c8dc77dc 100644
> --- a/configs/xilinx_zynqmp_mini_defconfig
> +++ b/configs/xilinx_zynqmp_mini_defconfig
> @@ -11,6 +11,7 @@ CONFIG_DEFAULT_DEVICE_TREE="zynqmp-mini"
>   CONFIG_SYS_LOAD_ADDR=0x8000000
>   CONFIG_XILINX_MINI=y
>   CONFIG_SYS_MEM_RSVD_FOR_MMU=y
> +# CONFIG_PSCI_RESET is not set
>   CONFIG_SYS_MEMTEST_START=0x00000000
>   CONFIG_SYS_MEMTEST_END=0x00001000
>   CONFIG_REMAKE_ELF=y
> diff --git a/configs/xilinx_zynqmp_mini_emmc0_defconfig b/configs/xilinx_zynqmp_mini_emmc0_defconfig
> index 2ddaecd5875a..66e0d5242821 100644
> --- a/configs/xilinx_zynqmp_mini_emmc0_defconfig
> +++ b/configs/xilinx_zynqmp_mini_emmc0_defconfig
> @@ -16,6 +16,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x80000
>   CONFIG_SYS_LOAD_ADDR=0x8000000
>   CONFIG_SPL=y
>   CONFIG_XILINX_MINI=y
> +# CONFIG_PSCI_RESET is not set
>   CONFIG_REMAKE_ELF=y
>   # CONFIG_MP is not set
>   # CONFIG_EFI_LOADER is not set
> diff --git a/configs/xilinx_zynqmp_mini_emmc1_defconfig b/configs/xilinx_zynqmp_mini_emmc1_defconfig
> index 31bba1712fb3..cded70f8f2f1 100644
> --- a/configs/xilinx_zynqmp_mini_emmc1_defconfig
> +++ b/configs/xilinx_zynqmp_mini_emmc1_defconfig
> @@ -16,6 +16,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x80000
>   CONFIG_SYS_LOAD_ADDR=0x8000000
>   CONFIG_SPL=y
>   CONFIG_XILINX_MINI=y
> +# CONFIG_PSCI_RESET is not set
>   CONFIG_REMAKE_ELF=y
>   # CONFIG_MP is not set
>   # CONFIG_EFI_LOADER is not set
> diff --git a/configs/xilinx_zynqmp_mini_nand_defconfig b/configs/xilinx_zynqmp_mini_nand_defconfig
> index 3b202b04ab3f..f5c79779df3d 100644
> --- a/configs/xilinx_zynqmp_mini_nand_defconfig
> +++ b/configs/xilinx_zynqmp_mini_nand_defconfig
> @@ -11,6 +11,7 @@ CONFIG_ENV_SIZE=0x80
>   CONFIG_DEFAULT_DEVICE_TREE="zynqmp-mini-nand"
>   CONFIG_SYS_LOAD_ADDR=0x8000000
>   CONFIG_XILINX_MINI=y
> +# CONFIG_PSCI_RESET is not set
>   CONFIG_REMAKE_ELF=y
>   # CONFIG_MP is not set
>   CONFIG_FIT=y
> diff --git a/configs/xilinx_zynqmp_mini_nand_single_defconfig b/configs/xilinx_zynqmp_mini_nand_single_defconfig
> index 67e1a6e7037f..fa58f2a73c0d 100644
> --- a/configs/xilinx_zynqmp_mini_nand_single_defconfig
> +++ b/configs/xilinx_zynqmp_mini_nand_single_defconfig
> @@ -11,6 +11,7 @@ CONFIG_ENV_SIZE=0x80
>   CONFIG_DEFAULT_DEVICE_TREE="zynqmp-mini-nand"
>   CONFIG_SYS_LOAD_ADDR=0x8000000
>   CONFIG_XILINX_MINI=y
> +# CONFIG_PSCI_RESET is not set
>   CONFIG_REMAKE_ELF=y
>   # CONFIG_MP is not set
>   CONFIG_FIT=y

Applied.
M
