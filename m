Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B2AC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 14:56:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C8E940633;
	Mon, 24 Aug 2026 14:56:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id izXWoPBk2c-c; Mon, 24 Aug 2026 14:56:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787583378;
	bh=3DFoBa3HulM/XVEnlLwactrDJkHt6NbYxn9X+Yq5NHg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0PW4BnQOaL3Fk6uDiky8jEY+OPmugAFR/TG1l/QzHOMNPMRwM37wFjLa89Nr4nnTW
	 e3Ek4Li7LhrA6YQVSoVCXCDFT606+mg6tG+X9dICFrpyZ6ZkoiND5vAFKq2SLuwxoY
	 MVrO/gVMIGRHOT1gEa1xZr2GBsG0rRTDDe7JQ5Qqay9Xgy/FMliRR0CnpexJVeHcx2
	 PQJtbAKnw0TrZl1GY3A4EYnwIw3VijZkn8VVEx+sNB4dw3I0FDnT2zo8AiOL7QXVC7
	 7ThTTc05wLK6eYjc+pI9h7e6XRNzxK4UvGLTp/x+qH5FZIqD/EMX+BdlKhrDdWTxKv
	 WHL8LmgwOdoBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 700C44053C;
	Mon, 24 Aug 2026 14:56:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 673822FD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 14:56:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 508B54053C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 14:56:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SFibykos5Gvw for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 14:56:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::5;
 helo=ch5pr02cu005.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=jgh6Xq2w
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C3AB404EF
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 14:56:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDktM+x20+Ope2t0Ix//ITt7a6mTFqA1ZJMaGFl/9tC5OA6USULO5zLcusOAN60RERqS7KmtpuQnN0hnFWNs9zHS+BnbiNbRMlvhexE1/xiZfdCND57T0NDOf0Um5TCik1RKDOtetFB9vESM8xmjummayRWsBJlXrAyARW4js01EHbKNhCuNcOFA96HtK2X2SxK1l9ghX3ZWriTc1wkHjmJ5HLjwdkPmukwzHBDXT8Mi4tUtY6fbz0VGHDPK+VdEzLrlZzUBNYTwH/Gyr8o5RVjZIRTKUvNC805endc3IkHnQGCH5ShSGcpouo6ybnHvOOswn8XrVAmSRzpQy9iEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DFoBa3HulM/XVEnlLwactrDJkHt6NbYxn9X+Yq5NHg=;
 b=sp6e6NBF4XZgBPBFAt9Ng+JN6dHLyYD7EryOGHo8m5wS/4BdTo2nnsksjA3TbU/OjlSXcW+6U3jWYupuXJQ+jzOBPctlR4GUAQ+1bTzYOV12NEZFiFGL9vDSI3QD5j+4812Gs40qjBve7x+z06byiWuEQBmLA0S8j52RT9YMA/yrkkkxmNRMlEnRo9ae/q5ERrYeDSIFD7TfLaYFupPJgQclryxE9lL7m55pXVQkmQertMd625Sk7Snpr2McbPJvaZDLT3RsZeEyxIGAiDdiWHWMI872ozH1aYo2G80D3DEaFjKsnCAu3SSg3AVLi7T7YHOw4aPE6mcV2bMxLSDYvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DFoBa3HulM/XVEnlLwactrDJkHt6NbYxn9X+Yq5NHg=;
 b=jgh6Xq2wOft9KaCHtVedcuZDkJp42F8YfhryNu7JjWSpRS4/mU/JJzYYN8+DoCF6wKuGV7aHN9Oku5qqBN1UyajI0rYLnTE1c3YMvfp+sj4/g8A9Yu0EdNkBK6VSC7l4bBTvcDHX7N9k7gWxKgfIjsFl90Fw5YGoXEHMm5BPpTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH2PR12MB4278.namprd12.prod.outlook.com (2603:10b6:610:ab::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 14:56:07 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 14:56:06 +0000
Message-ID: <a794f699-85af-46d4-897a-7cc4b837ef56@amd.com>
Date: Mon, 24 Aug 2026 16:56:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] MAINTAINERS: Clean up AMD/Xilinx fragments
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com, Marek Vasut <marex@denx.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
References: <cover.1786605799.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <cover.1786605799.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::12) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH2PR12MB4278:EE_
X-MS-Office365-Filtering-Correlation-Id: d2bcbaf2-98ae-4c00-fb4f-08df01efd385
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: hiuOE6q8HofthEgHnsnFRxvPGyU5t42kGtWcPqqYiBC4FnDcOENOegCJPnpHjyfvYMF4gj4XXP17ttywmiJe4lb1sx3ks+G3rPa3isblxiwMZQfiRArcaUaEyuCwkH8XdMyH/krQqHkU3DCysQyIrTX4F9xNSJ5TiXVeTEMXzj2M6aoAdrQmeHImeVlMvcjauMRvjAR8uEvXfQ2oVoPpfKnUhw4fNMBx2RpSCCgw+m6ZUrqfGvjNGagyTG/5mjatRAcumzlrqh8bLXH9qnwlWBuTefI5pMdxXsqDhiiCIhgDlpbSXu1i7IJubR0vZwIq6ntZAW4r/Nfr2my11vONPxrub5r3gkrqyJ5fH1dokDLI70u5IKYBzF+i5PE7v5k1b7LEXNu69YC7ZL+KCnsBsb+PK6mXadgzGU3kAlNErRjV/0pdO73/np83+Pv7pR/WBoyYvrdy5hlH/dPpevo95CUHYjqpKS2iDjIghyc+NUBaefF1HXKNmvDNZOjE4Eob8CtdEbVtzo0bg03HmYmfGaGBDM6bPlhpUHE7XzW6ZzZSpaiGLJrCwjN7Cjpi/ig4eE38lTzWLc83gzrhqB4zTsEU98YvOOEfaCih/SBA4FOYOGO4lmF8/s23DnIiXv04LBqNvv8HNJeF8odieDNlYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUd0NU85QjY0WmpwS3l5c05yVjdQSGxrcjcralYvK1lOd2FHcVg2MUM4Kys2?=
 =?utf-8?B?NHBOQUVEdmVlWmM2VkhKTmhVZHpZaXM2Z0Y2Qis3eXBwUnAxTGp6NnFZVko2?=
 =?utf-8?B?VzdMVzlFaEM1dXIxOHRqSDRWK25QVHp1N1FMNzBjdkNtNE9Vc0lCQzhDc1Vl?=
 =?utf-8?B?eWFrVWJENS9VV3NxWkNTMXZTbGs4M2RyTkVMbDM5UzVVVHdjcnMrdjMwN1o3?=
 =?utf-8?B?YTNzK0NkSnhhZ29oMVlYU1FOVTJpUHk5ZmM0ZjFLNXpTbW43R2dmUXgrUWhj?=
 =?utf-8?B?WTkxbWd6R2dqTDNJeVdLS2huYjdrSXRwWE1zUFRKSEl3UmpBUlFwb1ltSWtu?=
 =?utf-8?B?UkV1Q0hBWkFpNVppRW95ZVE0NjdFTjVQbWk2Zk5UTUlJalZNMkpvUkRsbTl6?=
 =?utf-8?B?bFVKZWJkeDRNOHdqWkVNaWtlSDNjcEwvQnNtZHJNaGhvTndBZ2lMM0hSTGZI?=
 =?utf-8?B?dzlpS0Zzak9Vc2psQk9HZVlydGQ2YWNKdXBGOGd5RnU2UjRPcVlvclBXSWEx?=
 =?utf-8?B?SHZsYkhIT3p6ZHhYME5KWlZHL0RSb1BlSlBzdkVtZXZQczNDTUtNUzlodWkw?=
 =?utf-8?B?ek0yTUVIVTdhU0VwZXlVUk1OdlVUVDE1OXhzcllOVkVQb2R4V1ZFVlFZQTF6?=
 =?utf-8?B?LzRZcUlVdW9vUnp2ZGFFVHZrdnIzTk10bVNxTmZUTXpTbWw3TXRLdGhiNUNm?=
 =?utf-8?B?MXJ2YXpvaGVIZlZwZ1BjTDZSVk1VQ0c5eHFvSEgvREhCNEdwVzI1MlRqdkpx?=
 =?utf-8?B?NzVuak0wL1VhVFAxZERLNXplT3kzcjBISTJEZ3V5cGI4S3ZVVnNuSmZSM2o3?=
 =?utf-8?B?TExtMXJFMFhlNWxDZ2VHMHJLZ0NsK2FZQ25lejJyZkNSZWNvZHJiVnA5Wno5?=
 =?utf-8?B?VWhva01QMGdBNUp6VmdQNjJaQmpaM2ptS3B2eXZ0NTNSTnhnVUU3QlEwS3Er?=
 =?utf-8?B?SUpwNlNRK0lDY29vT2wzUXh0VlpGV3EyRUFmbmlKWUFBcDRaVHQ0RkZ0UHM2?=
 =?utf-8?B?ZzU4bklzOEJzc2JZOENwRWp3c1Bha3F1bHc2MXF4aHBGYzk0YnU5eFkyemk0?=
 =?utf-8?B?eDNRY29lRzNUQWh3YlF1YnJJNzduZE1ERXVsVzhMMC9DNlc4ZTdielM3QlJI?=
 =?utf-8?B?LzQxVDg5UDE4akpvSWRtYnlEVkNwcmg1eURJL25sK2NmL3lxRXV3M0lINGtl?=
 =?utf-8?B?YS9nZEJWaWNmbjlSbkluNWF4c1ZZcUR5TWcwdVh3VW9WRHI2NWRINFM1NmFu?=
 =?utf-8?B?di9ocmZhWkJmQ2doMW1Mck5XTjlYYy9RN2UvR3RtTmdScUJMUmhxYno4OElM?=
 =?utf-8?B?L2hzZE9pbDRNd0pzRi93dlBUemZvYVV5Z252bDJCaHhSQWxueGJhaU1keWFV?=
 =?utf-8?B?dnJYR1FySHNCQ1VnK25CN0UyelpxdU12bm5XemZUdnlBRThWZXJBZ0p6UURh?=
 =?utf-8?B?TVRHWlpUWGtZQUQxKzkvcUhHb0FXdUhVdUlrd1lORzR5Ukc3R2gyOGNGTUZC?=
 =?utf-8?B?eDltU3RCV210WHRacExwNnJuUG5Md0w5LzlKSUoxd1VMRENSZFVpQmIvTTVL?=
 =?utf-8?B?UUlpTjVkaEphRXQzMWNoTElUQ1VpOGo2WlN5MmZHSXNuS1dmUVp0dWc4ZzRP?=
 =?utf-8?B?MC84bHdzZmRqQ1pCYmp6Y2hyNGdaTjdPVDFiQU1tQnlsM1RiL1piSmtZOVp3?=
 =?utf-8?B?NG9RWXovVTM0c0Q3d3ZwMzk4TnZ6MVUvMk9zSWg5ZG4zR2JQWFFHK2N5SjlR?=
 =?utf-8?B?b3BwN21sNlFYcTFJWEwvUFhjZzJRWDQ0Q1g3SkxVbC95MW5DM09CeFlGZkFp?=
 =?utf-8?B?QkFBSlV2aERrU1E5M2FHSjZFbkw4NDJkTFd6eEhrOWhwZzhqc3J1RU1qc3dT?=
 =?utf-8?B?cGd2VXNWLzVIeDlab0NFdDViSHR3eVd0aDFIUlVHTmE0SDQwcnZPNmJBa1RJ?=
 =?utf-8?B?bXhpdVA5Qi9zbElzVFlHaWE2SWNVejJlcm5uSjFwYStsYTZ3a0NZNUNITFhY?=
 =?utf-8?B?VVhoVW5lMitzVHJ1Q24zTVR6YXMyTmZZZmdUTjBLZEt4ZjZ1ZWI0bEdaYURx?=
 =?utf-8?B?MVdxNXR1R09iVUF6ZHVHUDJXcE9FOFE4Ykw0QjRBOWxXRXFmckgzWXFSVVRr?=
 =?utf-8?B?MmhFcmJjdEVjWitwWFlhWFNsQWx6V1l1aEU3eThrMkxWN2I1ejFoTzRsZVNM?=
 =?utf-8?B?SWFPZWNKWXZtOHFqOWtBU05wdUVvUW9uL013TC9zM3gvSmkzWFpyU3g5RDcw?=
 =?utf-8?B?K3FHbUhSWUN5UkNKaW82TXFxQTZQMHVSa1R6SU9xa09XQit4S1liNGdVZnlG?=
 =?utf-8?B?d2M2VFhYaHorUm5WOXhSNnRSdnVSVmE4Qm5PT0VOb3lFYUc5RVNXUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2bcbaf2-98ae-4c00-fb4f-08df01efd385
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 14:56:06.8681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CybLbLE0Zd0/fTH+pW9lHPvJ/zj6D3cxmRjTs1lNwQoyu5xS/eY+VJS1SdujVBpB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4278
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org



On 8/13/26 09:23, Michal Simek wrote:
> Hi,
> 
> based on my discussion with Marek I have looked at my fragments and put
> together ARM SOC to have only one entry instead of more. Also found that
> move to u-boot-amd is not covered that's why also created one patch to fix
> it.
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (2):
>    MAINTAINERS: Move u-boot-microblaze to u-boot-amd
>    MAINTAINERS: Put together AMD/XILINX platforms to one fragment
> 
>   MAINTAINERS | 74 +++++++++++++++--------------------------------------
>   1 file changed, 21 insertions(+), 53 deletions(-)
> 
> ---
> base-commit: 0b581a9612e46310ee52bf8359165950d38b2a2b
> 

Applied.
M
