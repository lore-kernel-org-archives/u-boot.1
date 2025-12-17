Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80277D65C49
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 14:45:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA3D183B49;
	Wed, 17 Dec 2025 15:45:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ruZ5TE39";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACF1D83B55; Wed, 17 Dec 2025 15:45:18 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0164D83B32
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 15:45:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ea4xNW+VY2wqTQuY/HZ3wMNTI3mkE8HstcDwZyAKlFMophUUzv/DjkP8cq5P0eqDBV/kDsoR7zlb7phifkT2Dr4RPMJHEmJ0HVHJ6z8kn8FQqautBfxJDr1d9Gvr7p2QhDnGJKQVSRTaKqvze4y8YG7eEUCn9PwNuImAH1PJh8BSLtm60QUIH9WG58E/x3e4nY80MxE04AK8yyk/7cUDIYvuUXarcvxeIeFJo9585Z1CZPEyUQ/6D5d9Cj6OyT13R4T0g2yFSykNzW3j1VpjdO4krtguzuWFXayMdSG2gsGsT33+w/jqV06gpmr1d+42HeMAAqdPP4tFn0Ut76a/lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bU6ecRpfUoRTb5TCoaTjWcy0n40NXZ9n+vu4d85oRLk=;
 b=Z4hERVGirc7Jt8n2u/Z3iNiy/plHHOrF6e8UYJhRsK3okpZrl1gu1Jhk7DPRJLQK0hH70Ixw/fo59n/R3lpe+7iAqTmm8ENXXoWfFdAl0a+VO0X6yvDnyTxdfZpB7po5UFgG0KCeiPQIhtIZNED4o2oE33ZHcUDXtmVKL+AQzqTnCUf52AhUC6hNP9+hXzeq74s4+x5r5ZTgfvIlZiGUZ0l5U95sex8jMq37OSpFX2HTQ0AUj/HBwtxTroYJiXdmKES9PUrO/OKgDiDuELKySmsbQ+zBYXx7EBAqghHV8JBbo3/yESe+J7hJbLjtPiSYxbnaBbxUPaAvgs6pHIUm3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bU6ecRpfUoRTb5TCoaTjWcy0n40NXZ9n+vu4d85oRLk=;
 b=ruZ5TE39RqCgcY6WbHatrT93NtjwrSNnBKC1F9hX09L6Cpw6MYDTyx3AG0LkU/d441QN5599amSrRR2wUZucB69scYOVXbheGsnAi0KYst29XGea642SE44RMnsOz3zz5DMY4RryGfNF1du6wJ1D+UHoHHsIFTjbRjoSgl4gilE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7252.namprd12.prod.outlook.com (2603:10b6:806:2ac::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 14:45:11 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 14:45:11 +0000
Message-ID: <393f39fd-0504-4f3e-8b2f-083433c894f3@amd.com>
Date: Wed, 17 Dec 2025 15:45:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: bdinfo: fix incorrect Kconfig options check for
 print_eth()
To: Quentin Schulz <foss+uboot@0leil.net>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
References: <20251217-bdinfo-lwip-v1-1-849cf060bf12@cherry.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20251217-bdinfo-lwip-v1-1-849cf060bf12@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0024.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::36) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec28af2-d467-425e-aedf-08de3d7ae197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDlRSWJ6QXEvaC9lWU03R2VPSEdPeGdWUTZiN1c5QjQ1REtTcHBNWEhCdGVY?=
 =?utf-8?B?MnRIS0s2alY2RytFMEtZbHp3R1ZHSkdtaS9lL3F2a1J6OHE2QjZ5SXptME9W?=
 =?utf-8?B?Y0FrRm16ODhwYjhaLyswKzJ4SGxYRmJEajBsZ1k5ZEFjdng3M1JPd2U3RkRa?=
 =?utf-8?B?NU9zTTd1QXM0MWE1a0FBZ3k1NHVtcWZrbGVUdVVNd3pRZis0OStqa21xYUkw?=
 =?utf-8?B?M3BXclVYSXpOdmdjdUIrTmdYckFReDQrTUNoRFhOWGZvUDRWZXhTanNHbHBL?=
 =?utf-8?B?M1FQa0N1VGsxR3NTMUJQQ3N5L2lLdkZBbTJNNVpLSUc5RG12S29ka1ZGdVM4?=
 =?utf-8?B?SnFXbHl2OXJmM0xDd3JVNFU2YWZPdHBLS1RKSTBIcTN0WDh6ZE9EdWtjRUI5?=
 =?utf-8?B?VE1kWWdPQmU0T3JXYTFUU3BiYkRMQS8ySWY5Yy9GSXpTakR1U0hMUElnc0tM?=
 =?utf-8?B?MmtZZnZVc1lnN1VBWmZ2OWVZZUNkbEZMWmV2RFpBbnZ6cVkvWDJCTTQ3d08v?=
 =?utf-8?B?ZDVLVGJZYWhBcGF6dVd2UC9oRWlBVXE1Wm5nZXR4aE5mK1oreGlGOUt0Znd0?=
 =?utf-8?B?VWFVUkM0VzFiMmgxUTY1N3RwNkh1ZFowUCs0VmFhRTFpUUVmOWN6ZU92YzRC?=
 =?utf-8?B?TitYVEFxcTR3VFZOU3RYMS9CWjI3eE04SHdmMzVWUGJTYzJJb3VDbkNKSUsw?=
 =?utf-8?B?TUxzSzZmdys1UzR2ckhUQS9MdnZEUWhNSEFDQmt0YnB5ejhrbTdLcnlkKzNo?=
 =?utf-8?B?dG13N0JCMHNOQ0dxWm53NEE4SVR2VUwzRzZILzhRZjRZNjUvOVpKQTFYenBu?=
 =?utf-8?B?dlJ6OWIxTWNFVUV2MGlWSTlCZFRoVkh4MitIN3FSM21BNnJBbENFSzVMcTU3?=
 =?utf-8?B?bkQ4MEdxbzdJbEJCYlY0RGY1c0RYMDV3ZUkyWWJNYnk4YUxyaG1ZaHdnVmhM?=
 =?utf-8?B?aGVHMUVjWDA3SmlTSEVwdVkxMVRPZmNyb3pRM1BiTVZ6anR6cWF5UzhwVzJi?=
 =?utf-8?B?dkVGZERVbjhUSjhzdjlTQTF5dGVKcG85OWwxeWdITU5GZm9IWkhEUXNjSitJ?=
 =?utf-8?B?UlJSK3V4dFpsd1ZrSVB2VGVvNzYrY0tQQlNJNUdHQXlHdmRmY1pJbVF1M3o1?=
 =?utf-8?B?cUltdUNtQUlCQWphQnprKy9yQWtVZ1hzSEpaUGhlamhhdTVkcUxYWVQ5SU5y?=
 =?utf-8?B?Wm93aUpzUEZFdmRtSXFMNENiZXZoK1FIUWRZYm5oVEVmTmZacTc2aHpiTzYz?=
 =?utf-8?B?YUdqbE5EYU4zMmlJbWZNUDFva2dUelBqN0ZzcjhXb0RubTQybUlwYlVMYmY1?=
 =?utf-8?B?VTBHTDlPbXVJOUpMemhCUjdXOWtjbERQa29LU04zRlBKOWtKNEpUWHRMRllM?=
 =?utf-8?B?anRFQVdMa2tHd2tSZC9aSEpEQmdsYm5WenFVcG1tL1MzbTBVOWlEVFBXVmZL?=
 =?utf-8?B?VGF0bC9zLzlGc3d3MDVwUHhlamhmRTdsMkRPWDZteTdQWDBubk1hWGVoeFd1?=
 =?utf-8?B?N2hGNysrKzhMN1IyZWoxRjFwaktuK0RUbk92aURBb1JnV3hyeXFPcTVWczJX?=
 =?utf-8?B?dFozV3pncXVpNFRvam14bHZCUWdtZ0dnQ3pnZG5pdFkyOXAweWJJY1Y4RGkr?=
 =?utf-8?B?TS8vaFZVK0RsRDB1NVIwQ3pEYnl5VVZkeDJSa1hvQXd2SFFUWnBwcW9oUWRH?=
 =?utf-8?B?N3NSRXlMVUNzTkZGWWhzNDFuMk9SMlNNS0M3ZUl6T0VTTDNRTlk0dzlqN1RX?=
 =?utf-8?B?TGgrVi9WMW9hb3NsMVBHNVhEZW9FVmFHNDZqOHRURllmYXdzaGN6dTE4Y1p5?=
 =?utf-8?B?ZXNvbDU5b21iWGpoME92SCtScGlJMTVrbUJwbG40YWtiamd0ejVzRzRTeGZq?=
 =?utf-8?B?K1grMW1lTzA0L0tyMFVmWi8wSkpJSHh6VlEzOTBuNHhnOEtXVXR1ZEgwaHU3?=
 =?utf-8?Q?hBfvNwkZfUatJhPTFhtjx7OlQBN83+oP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU1KY25WUEZaV1FMdXdhWkhxd0ZYNHZRQk0vV3p4RHhPS2FCRWZuMkxyQUJM?=
 =?utf-8?B?cjArV2xDOVl6UUZVMHg1N0ZtYWpwWkdRRG9iN1VLb21adytqVUdkTmp0ckNJ?=
 =?utf-8?B?YW8xOGFEU2FZbTZlNzBuM2g5Nk5aVXNFU2ZtQmhialQ3N3V6SFA2aDdWNktH?=
 =?utf-8?B?U1VYbWNBNkIySWw4ak12ZE9rRHVCUVNvYTUzeWpHSGp6ZG9oZlJGRGNVd1JJ?=
 =?utf-8?B?MVNnVTMrY3RZNGZZeEZTenQ5MjN6YTFDcDQwSXhOK0NDWHVOZXlZVlFZRTVs?=
 =?utf-8?B?SHltOFdCVGxVdEpWMDJLTGhJMlBsWHJiT25NTWZlUVY5ejZ5Qjg5TTUweWFB?=
 =?utf-8?B?WGg0Ync2eklNRmxXQzI1eTRBZUVIdXUzR1NFSVRBL25tb3p3VStvTFlBc2VN?=
 =?utf-8?B?bDdQSElHYkZ3c2RNcG90ZGlHNGNuVWQyN0xrSzlabHhKTSs0ci96dUcxZVZU?=
 =?utf-8?B?L21rV2RCVllKaExnZW0zaUlVemN1Rkg2aFk5WTh5cURyOEFScWdhUWkvbWZH?=
 =?utf-8?B?bUxja2JCdWVpK3RqTzgxWXh1MWhiUG1BeE02bjU0KzRaNlI1b1p1cHM2cnRI?=
 =?utf-8?B?UGU5VU5KMS85bytZbU9VNm9uQlhTU3RMR0FzSFJJQVArVjA1dmZCdllEeVZR?=
 =?utf-8?B?a282UTJCVmJ4UEswU3c0ek5mUnltenlTZG01a0NGaHR2S0RtZ25DNUJDSmdN?=
 =?utf-8?B?L3VlRENGMHJyaGJURWFocllCazdEWFZsWjZPWVFheUZ2aStxcFBlT3JGT1FI?=
 =?utf-8?B?aTM2aFI3K3Y5eFJsaUlYZzRSSEhoNFMxdnBJNG1mRUhTemh5V3Q5dTEybUwz?=
 =?utf-8?B?Kzhra2tZSHF1cmhwQW9PQmdPNGs1RlVqdStML2VhNE1xd0pzRWw3YUtZcXMv?=
 =?utf-8?B?cVN5MkRTVDh1N2tZOEp5WDBZcDFyeC9xMFh3SjZLVzB1Z29qMnl6dG1zVk1K?=
 =?utf-8?B?NFVySWpQNVRucTNMamt4NTlKbGJsK2IySVVHK05TV0lPWU5UUW00U2RqRXc3?=
 =?utf-8?B?VHZjMTMvMnY1S1ZLOW1DVjBVWXVjQ1QrVnlHampMZ3NSSmFGQlFyejFoNFlE?=
 =?utf-8?B?WjA3UTQxZThBcDZpaGoxcUV5KzUxbEtLNE9XSGhETmZSK1hKUXB3RG9KL3oz?=
 =?utf-8?B?b05FQXJ5OWUvSFBmdFM4QkJLSUhBM2hITFc0Qm4rVkc1QlNHQVFCTXREUDNE?=
 =?utf-8?B?YnJOZzBtdmdtbDlESFp3ZHpKSjh2QnY2WnJTTlJyaVIvNnluTzFQUGk3dzE3?=
 =?utf-8?B?YWUwTC8xdlJkRlRCTUNzV3UyUm4wM1hEZ25Ec05OUGorODdxV1FoM0pJV2Rj?=
 =?utf-8?B?ZGoxL2dacDFiS2Fvd3FxWmRVTGQwS1N0c21hTnVwamp3dHQ5Ym8yRGFMYkJN?=
 =?utf-8?B?Q3BmcVpLMG5XekZUVkhjTmFtdFVBbmI5bExIZUV0cmFyamZWR0JuQ0QxL3VN?=
 =?utf-8?B?dnZHUzc3T3J3Um9LRWRIdjRKcVJNQU9wTFUyTU4zZkhENWhXSlhtTnFHY1Zu?=
 =?utf-8?B?d1luczQrZDB0Ym5WUzBSVW1UVFBocnVlaG1UeXZEYnFJWmFGajh1dSswV2lT?=
 =?utf-8?B?RjJBc2s2UURWRXZZQzR6ZVBvN1hxaUNQTXVCNFYvbnhtTENhQ3RRZFIwRm9h?=
 =?utf-8?B?UlNQV1Z6dWwyWFBQanhHeDQ1MUMydHN6MVdKRjZwMUszWnBIL2EveHNHZm5u?=
 =?utf-8?B?L3A2aE5xQ0FvakpyRWptZDBHNENldThvc1kxb2dsVXpDYkNOTVB2Wm1yYzVD?=
 =?utf-8?B?ZWFra0MvVTV3UzFZektJbDBMZzBoc1A0akJUOEVKMThYampubjV1WEdLTUoz?=
 =?utf-8?B?aHdMS05Ycm5kQW5udllwc3Y3ZHh2MnByd1IrMXVIL3NnaXk2bWRneTNHNGk4?=
 =?utf-8?B?QTVwK09LdGpSUzhhSEdrTnFWMks0NzZvSVc0bGxVVDMyWGU4UGFwVU9hNDRh?=
 =?utf-8?B?MzhoVVJhY1haYk9ickQ4Wm5uMzFLbG85RmlkUW96MEpwZDVOZG1pQVJwWXNC?=
 =?utf-8?B?ekkrWUN1UTlPc0pKZW5Qd0p2S29qMUJDeTJUQUY1bDRiNjdGVVJmalBMbmJU?=
 =?utf-8?B?VVNXbUtWbVVSM0Y2RzBYOHFoTHZ2cXZMamgvOHo3N1k3QXhpcUVDL291Ukxq?=
 =?utf-8?Q?/6WJYX3UGq3noiS4vFcoXGuoz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec28af2-d467-425e-aedf-08de3d7ae197
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 14:45:11.6478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Tn36mIdHHsc6k9vRwHz22A6L28dj2Gc2qe8vIlf+q3jo04JsOy4X2cJlE6m2MKN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7252
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



On 12/17/25 15:01, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> CMD_NET_LWIP has never existed so it cannot be right. I'm guessing the
> intent was to allow print_eth() to be called when NET_LWIP is defined
> (NET means "legacy networking stack" as opposed to NET_LWIP which is the
>   newest (and incompatible) stack). There probably was some mix-up
> between CMD_NET and NET options.
> 
> The dependency on CMD_NET seems unnecessary as it seems perfectly fine
> to run bdinfo without CMD_NET (build and run tested). So let's instead
> make the dependency on NET || NET_LWIP.
> 
> Fixes: 95744d2527cb ("cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   cmd/bdinfo.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
> index 20c8c97f0cd..09fe8067642 100644
> --- a/cmd/bdinfo.c
> +++ b/cmd/bdinfo.c
> @@ -152,7 +152,7 @@ static int bdinfo_print_all(struct bd_info *bd)
>   	bdinfo_print_num_l("relocaddr", gd->relocaddr);
>   	bdinfo_print_num_l("reloc off", gd->reloc_off);
>   	printf("%-12s= %u-bit\n", "Build", (uint)sizeof(void *) * 8);
> -	if (IS_ENABLED(CONFIG_CMD_NET) || IS_ENABLED(CONFIG_CMD_NET_LWIP))
> +	if (IS_ENABLED(CONFIG_NET) || IS_ENABLED(CONFIG_NET_LWIP))
>   		print_eth();
>   	bdinfo_print_num_l("fdt_blob", (ulong)map_to_sysmem(gd->fdt_blob));
>   	if (IS_ENABLED(CONFIG_VIDEO))
> @@ -193,8 +193,8 @@ int do_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   		case 'a':
>   			return bdinfo_print_all(bd);
>   		case 'e':
> -			if (!IS_ENABLED(CONFIG_CMD_NET) &&
> -			    !IS_ENABLED(CONFIG_CMD_NET_LWIP))
> +			if (!IS_ENABLED(CONFIG_NET) &&
> +			    !IS_ENABLED(CONFIG_NET_LWIP))
>   				return CMD_RET_USAGE;
>   			print_eth();
>   			return CMD_RET_SUCCESS;
> 

Would it be also possible to also update bdinfo cmd help to cover aem 
parameters? (Separate patch should be fine).

Thanks,
Michal



