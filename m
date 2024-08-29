Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23389C83F09
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 11:55:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CFF488B94;
	Thu, 29 Aug 2024 13:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bbkYYXEV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C4C988B94; Thu, 29 Aug 2024 13:55:53 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B64AE887EB
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 13:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UY380M6mY/3+xw/MdxTWaa8fOv4OBw3VLTBDDrpacfD1cNDdYMvktnPp5nzw6TTX+KYgsM4xv1yNMl0JP0sQzYbiNNhLpGLklEWV7Sepk1soM7EQrn3edR+0TB7zRDEKXa78JJS4dEyAIVtTotlmGlEBCsnH7oHNKcefUJZG7XJPb62Y+4rc3p35ZrHoGVR4sff7/HRGh/2AQ9oCq1xDTAnXMBbzhE4XbSeePaNC6Qp3okugZRO6wophc7VrwKe/lsLBwCFCyKAHweIkk7oJWIhlVkqERiNjLhqFp/fWfmFfIhVSb6yxuc46+ghqKYqrIYBJL0gvRHAbNOn6Qbq7AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01qm4IRoQXy0zbIU+a6W9RTsGxJxQSEOI2mr7swvXj4=;
 b=aA+XULdNI+2EMLNcCKKIN57odWNvJJVHx3kkUgc/gaDsD3eBw2ezaIDbShEwSNY6i5va3SHKSRcrZsz6+L641LgLbZ5/r9PAitqH1P+D/rSutBqsBPe+KX1W0dYeBJwZujYyZV/l+YHHAI0pezeDoM+tmcPw1Q7mHNfO1kROn0uHdKCX/PmR5GNtU0LgWnLlY4qW0DY8OMcf9brEWbQh5afa3Wcy0ZpMfvB+EfHQi1RcE8HUI1lJbAV7GOgJUxtfr7VnSzZlFkY+gZwdGSRQeBRkxjnbww4Rw+2wxWvKXftI7TuFMK2dmsbMb0d6TvqAo56yljHuksKqawXe/v109w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01qm4IRoQXy0zbIU+a6W9RTsGxJxQSEOI2mr7swvXj4=;
 b=bbkYYXEVTKPoopsoLozrFqdj34vl7PqEs7tmYsTha6AGP+cEMoe2YzxZP3vqLwaC8tMMMJcsUKbhZFyyWf/9xJ6vm2rH57ub44WpFXWEpUtEx5RfZwejk434izAIHs7kK+jNEkrFxJ/jX7qJ4pG0jzfIkA4nUyF2sfLhZKUx2bk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7369.namprd12.prod.outlook.com (2603:10b6:806:298::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Thu, 29 Aug
 2024 11:55:46 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 11:55:46 +0000
Message-ID: <c2997186-e574-4e2e-92b3-39ed6c2224c4@amd.com>
Date: Thu, 29 Aug 2024 13:55:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/py: spi: Set the expected error message
To: Love Kumar <love.kumar@amd.com>, u-boot@lists.denx.de
Cc: git@xilinx.com
References: <6df888784a8f6fc4957cd870e35501f15130753a.1724916742.git.love.kumar@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <6df888784a8f6fc4957cd870e35501f15130753a.1724916742.git.love.kumar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0114.eurprd04.prod.outlook.com
 (2603:10a6:803:64::49) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d81730-3da9-4826-c0eb-08dcc8218449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TklMNnU4Q3RPeEk1NERuckdJOGZjemhEUGRJWlJtcHVxU1VTVjVHK3dYSzBk?=
 =?utf-8?B?Rmgzd0R0Qm9ONWpRbGhuU21nMVRyZlVPazh5Nm9qMFRpWGliMGQzZE50cWRt?=
 =?utf-8?B?bTNnZm9oK3VTWWhMVDBCSTZwZzdvMkZKdWN4eDVqK2E2MzN1N3k0R3pFY1Vm?=
 =?utf-8?B?dGF1dVB6S0Rld01oUHNpQ3pwY2oyWWNITWRKcUFMVDh1aVVkbGd6Q2sxRU1V?=
 =?utf-8?B?LzJQb2dmT2dyMU8wbnZ0YW1OZUxNUTMwd3h3T3g2Z0hlQldwM0xrcnY5akto?=
 =?utf-8?B?Mm5GUktQSkRWWXpOVHVTalRickRSYW5HT0hZTmdkLzBjNFpJTldXclVYcGhx?=
 =?utf-8?B?S1p0UjlWbTRzNEUzVkh1R2Y5YXNZYmd3RE4rK3Q3MXF4T2ZZK1grL0QwbnpW?=
 =?utf-8?B?c0tGRW9LN1dKazcxNk51b3JGTnNhdkh2QXJnL0w5SG1zQ0FnMkYyRWErNnVo?=
 =?utf-8?B?WlF1RXNQbWJZbHVFdTRtZ09SZG91UHJaZlhmbVROL1cveXRzSFFVam9DMUxh?=
 =?utf-8?B?ZHpIQmlsQ1F6OHgzbm52eFRRejlhcG0xUCtjSnp4RGlmNUIyZmVrbi9yVEtr?=
 =?utf-8?B?SVJHaXkydXBZdGdaZlJNZjJxSWFZZ1d0K2x4LytmMEVWK3JQcGdvZ0RXTEh1?=
 =?utf-8?B?Z0hSLzV6aXo5Qko1N2ZUb3dYL05PUmJMS0JXMSt5b2hXYktQWUhUV0VSMjFr?=
 =?utf-8?B?RkQ4bnVycFdOSkFSV3RMbTlaNC9UN3YrTkdSaUxYNy9ucHQwbndJbTltcHRV?=
 =?utf-8?B?dHQrcEJNVVh2QU9HRVVqcGZTcjhqVlRlM0lRbGQ3M0U3b1lUNzJEMmxURVFk?=
 =?utf-8?B?dVZNcG5kZEhPeGpGaWM1S2ZES05pQ3RqM1hBb1BPak1FUXYwSkRMdU5Zc0hN?=
 =?utf-8?B?UTlSVmFJd1BtWElQNmo4T2ppdGtFdnRiRXlpMEI4RHl0NzB4NFlpOXo0VlFQ?=
 =?utf-8?B?WGloTlJiMGwxSkhVL3dvd3l4VWZiNDhIUXE2bkNLVXp4UzduSE5DUzVod1Fp?=
 =?utf-8?B?NnpyTEx3M0xNOGV0T282SWgvdUt6NVZCcUowR0JwSUlHWTlaWU12eGhHWSsy?=
 =?utf-8?B?RklhVWRDcHg5aHVzV3IranNCL2xJVGpNcm44cVFGN2FxdlVseTdJaXkyODkv?=
 =?utf-8?B?UmwyTEJOSXpiY0NxWlM2Rk03MFRXVkR0c1poNUhhODBXc0loOHFQYmlPQ0hr?=
 =?utf-8?B?bHZpOWZhNTFxNGIyMm15ZWRmS0tpZ3EvTHc0OUQ3bnNGNlhqUHU3T2RYL1Zl?=
 =?utf-8?B?alhDbHZrT3Jwa1VZdkI2UkpIdWt0Wk1WZXlTV3RrSUZveElWcHhCWGNrbnZh?=
 =?utf-8?B?ODVuUVB3NGFwZTVWQVJnVGVEZDNiSXFXQlBwdzJaYWpBT3pVSmxqb1phOWZS?=
 =?utf-8?B?amg1SG52eEtycUpIdWFpbTVWcHdqamU0Q3MyRkViYU1PZlBGUkpqdDB2UzVG?=
 =?utf-8?B?a2ZOR05USCsyZFJQakRjNTUzZFZCditWR0FlbEhIRkd5VGpKOTY5QmRSbzhC?=
 =?utf-8?B?UGFpYVllRzNkd204UVpya1lMTmkvcW9hTHpsYnZJOThqVVFJNjhJRHhObytJ?=
 =?utf-8?B?YjhOaEdzLzJmZWhxNVF0ejBpUXNWTGR4TWFwVzdDenRseERYUWxFOXQ3MTFn?=
 =?utf-8?B?enVUM0JsS1kxYUhqNHRXQTRKc1pRWkI1N1NYMWNhVmsxbEdUKzByUkJzeDcr?=
 =?utf-8?B?cDJWSHJzWFp1bGR1VURZOFg2amJMbzRsd3FmdVBuUjNPTDkzMGNjYlNsdlVm?=
 =?utf-8?B?ek1JcVpYRzRWSEZwYmpNU1hNT0JBQTVoZ2tHRHZnV3J3ODdsNjVDeTRZbXNJ?=
 =?utf-8?B?RUY5NjRFMmtHM3ptZnZZZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGt4VXRYR0t0UENmdGZ2RU1IWmpNbzVvdThEZkQ5YzUyVXlqUFVZWTIzM0Jy?=
 =?utf-8?B?ZVU4Z2I5QkN6K2lLeXV0d1pNV0hEVXB5WGI1bWl4T21vb2x3UmdUd1JQUmpS?=
 =?utf-8?B?Sk85NTBQTXQwaFhvZDZydUxnR3JLRHFYTjlBNHpoeERhUlRHdTQxRno4cXJS?=
 =?utf-8?B?eGs3bUFzTUhPNlc5ZWxkeStyK3pYU0taYkp4aGxRaFo5T0RYTitSMHRySHNJ?=
 =?utf-8?B?MzZvaG9tRE1lSTNSQkR5eFpsYTNETDNYRzlCTmYxaHdLTTRJZ3BHc2JpMnZW?=
 =?utf-8?B?aVFCM0VZQXU1UkZhbDdScmpHT2NlZnphNTB0dXZ4eVJYREg3YTRNV0QzakNj?=
 =?utf-8?B?dVdxK3l4UVJUcFRSbjMxcm5Yc0RxT0ZkdWdNY1hXUmFoTkdpdHZqNXVvNGJ4?=
 =?utf-8?B?UW1UNHlVbkRTYUY0QWNsY09YK1d0SDNSdmYyNzN6QkpWMjFPckpoYXJiY2pV?=
 =?utf-8?B?TzhCOHVscDBWNWFBbEViT3Y4Zk9iU2NjeUtHRERZQjdHSnVKdHpyaVJWMEg3?=
 =?utf-8?B?Q1lUR2JvMDN4TzllSSsyQ2hLT2ZqTFcrTDdpUWJNbHYzMFM4WmVqekNMajV4?=
 =?utf-8?B?NHptZ21YUUovRWJVVU9yRmN5UWxEQlM0eHJZNGEyTUhLOE41NjVNNEJ0bFhL?=
 =?utf-8?B?bGs3ekNEZXVOcUhrbGh4dUVJTVVzdEJOOG8vRk8rNUtmeGJTdWxpTDNTUzVl?=
 =?utf-8?B?cGJhVzlPeENmNUJOT1ZIVVA4RDk4RC9tVEhnM09rV25kd2hENkhiOW9QSXhI?=
 =?utf-8?B?QVJsUzBjSHhyQmVWR3R2VlN4SkRLQ2U1RDNwd0s1VldWZmJ5WUU1c1c4dkdo?=
 =?utf-8?B?SmdzSGZ0Q1N4aERLdno3bFBSamt4SUt0ZlBUSUVoQ25iREc0UnU0RnhZbjlD?=
 =?utf-8?B?emthS0dWeVdydFlSODRQRTUxN1p6UjdkVVBmQlBQOVVpenRnRmVURzVzMjFl?=
 =?utf-8?B?ejVDM2o3eURPQmRNRDV5YWkxZ1d6M3RJZ2xpbFp0Q0J3K1pSQnlkcTNBTVBw?=
 =?utf-8?B?R3c1RDVHSFBacEZPOVB6c09yNkR6K3lUdFFzTUxrdkNkTU5ETU1JdmFUb0Nk?=
 =?utf-8?B?eUZ4aWMwcnNZR3dGNFZLcHJYcm9KSlYvQ2UySjhlMEFHZjJyWk94dmo5T1pC?=
 =?utf-8?B?dE1CVWpvQkorT2dYL1ZveWcxZHlSSUhqS0ZCdldsTm1FUHNmZldBRHplcHgw?=
 =?utf-8?B?Zk5YUVRCRERjRTRVZk1nc2xUOG9aWDlsVk54Sng4LzVpMmFBS2NsNGRncnd6?=
 =?utf-8?B?NUIwMGRleDJ4WWhQSzFVakJRSE5ZQzIyaVZRVHdiakprQUU5Z3IzOUNjU2tH?=
 =?utf-8?B?TE4wSTNORHVPUHNieFBXejFrbnlkSDgrMGxZb3BTQUpGYWpJaEUzRDJMb0tu?=
 =?utf-8?B?alNKWS9HSG53VzZTOU80VGdDR3gxMUhkbkdKR1p0Zkl5UzMwdm1ySzQ0bm5N?=
 =?utf-8?B?L0hNOTF4WkVDS3BsdEF1YU1NalJTWHlSU3lTZ0hhbThYL2Z0NXpkTHhCQkxr?=
 =?utf-8?B?NDkvM1FGUGh1RFZHN0RSN01lalhxNU5xR0tEKzVwZjJWT1dpdzJsK3M0M3VN?=
 =?utf-8?B?WGhEc0VRSnVJOENzZ2FyS2xCSDgvSnZNZEVBY1A2ZDdETTN4U1hscGVySFp0?=
 =?utf-8?B?SHlWdFkweDZRK2lTaUZyNXVLNmpPb3Bna3hqQnlwMElCOTNiTmtUUlA4YzZ5?=
 =?utf-8?B?NkRHKzVoK1RlOHlPMlpua0U2cTRjS3d5WnlHTUdGeEtXZFMxK3laa3FSSFBi?=
 =?utf-8?B?S2VSaUkwOWhDOE5hV1M1ZWtwenlUZGxIanJQTUFJRHJBUVlxd1NNa1BNQlFW?=
 =?utf-8?B?a3dIYmhpbS9hYldhZm1oSmZpZ0x1S3V6bTJnWnFqQXJqMmUwWFlGVXI5VkJI?=
 =?utf-8?B?L05vTU9HRW5nTDdPWDZFLzlsWEZmMitabW15QnpQYUpTUVZzcTVFbXhzMi9J?=
 =?utf-8?B?czYvNHd1MllEVjFNZUtQVllBRlI3aUdiRWpCRnZOVWFOdytUa0lYYXg0cGFS?=
 =?utf-8?B?RUU4elN5UEZwNjZDeFk0TTl5c1ArR0xwNzV6dlNrME05WkJCRHFlZVN5WWhZ?=
 =?utf-8?B?T05TV3MzbmxablozL05Pc2x1VkxWUlY3SkxHdjlDOTNOcEpKQTJrRWd4QXQx?=
 =?utf-8?Q?U1O70gD25359MnFF3Jm88UKWe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d81730-3da9-4826-c0eb-08dcc8218449
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 11:55:46.0973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RK9vyhVxoUkvQtNkj43L3OHqCzq5KA0IDt8qMyvGWQvE0R9uaquVCkA4reXwkLsw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7369
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



On 8/29/24 09:33, Love Kumar wrote:
> If erase/write/read size is 0 then it throws the mentioned error message
> when debug message ie enabled as per "899fb5aa8becc159b1eb086d8828c4e8eb28f121"

you should use this format not just sha1.

899fb5aa8bec ("cmd: sf/nand: Print and return failure when 0 length is passed")

> , setting it to None as debug message is not enabled by default for
> testing.
> 
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
>   test/py/tests/test_spi.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/test/py/tests/test_spi.py b/test/py/tests/test_spi.py
> index c81eca5fba6e..3160d58540f2 100644
> --- a/test/py/tests/test_spi.py
> +++ b/test/py/tests/test_spi.py
> @@ -646,7 +646,7 @@ def test_spi_negative(u_boot_console):
>   
>           # If erase size is 0
>           esize = 0
> -        error_msg = 'ERROR: Invalid size 0'
> +        error_msg = None
>           flash_ops(
>               u_boot_console, 'erase', start, esize, 0, 1, error_msg, EXPECTED_ERASE
>           )
> @@ -685,7 +685,7 @@ def test_spi_negative(u_boot_console):
>           # if Write/Read size is 0
>           offset = random.randint(0, 2)
>           size = 0
> -        error_msg = 'ERROR: Invalid size 0'
> +        error_msg = None
>           flash_ops(
>               u_boot_console, 'write', offset, size, addr, 1, error_msg, EXPECTED_WRITE
>           )

M
