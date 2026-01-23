Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0897D74ED8
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 14:15:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF83283B21;
	Fri, 23 Jan 2026 15:15:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="081GHIkN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FBF283B27; Fri, 23 Jan 2026 15:15:50 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5A4E83B0B
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 15:15:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXfy0dcUZl/j1+FQ6Im/UmMEW2VygUY7iSGZLSoMOUSIVU8+N0IB06ZnpWaCBhLbt9lfwM/YPVscN5wl32raYNc3RQYEslZHB6wrSNXepuh31tKRd7k6UbD+btXw1A2yPLwfuyjo18dFVk15Z/GSAI7gDiRQqs+yCRPd9/g8wlnnwxjDaudYszXAmheZKDEnB9USOEUkBO16Mr11NrDtl3uj4Sp8MxGjJPjGd3g0faWml0dBcOBXMVyyWTDfQkcY8Ilit4+NwkU5TwWPxnPEZFc4LAtma7G99dGm9m2VnZgaIDtNqC9Kp1WoOyzvwwUppv335cLmfnL3X89udTxqoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKDsoXC8Qka/eZq2jJsP7L1AMmXiPB4YQprP2rmebpc=;
 b=azIpW6ZcXv6/qAEz1cw8cRcYIi7NMWQxmwqrDVAWwilDbIBVY3hJFryuOONCqj4HOd16ZH1GHlBdR3VqXNDUDBSn0Z4pCEPI53uIBcpqPUg1o7dBFng5avf8ZjUEiFMcNsjsx1LD4vyzXZQLvseyoyrf/8nt/B33vlaMszUUggXqMTVd2GYiX2j3QKfLZTZ2r/qpNXAZH9c1+NfT7S+geCjFPJ5+7uwybfQZfP0ZzCOAIUoxSTDmXYrhrKRCgcvUOhuDioFehGjVkNkBoEhynW+Tq5av0zL62VwpSdU4jEVePr2sCrfQ685JDMRzFgnQ5dQv+8kZzM2qRgj3o1Eq5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKDsoXC8Qka/eZq2jJsP7L1AMmXiPB4YQprP2rmebpc=;
 b=081GHIkNs9WKeuCUeN+beuNGAz/8x1Lr89EWevw1h9GZ6oqicyJq3OPuqnGLtVdWVl+HIC8a6I9GzNrerodJOJsylQvVWKkWDCL4EtGAjBxLDQT58Q3dns7dUgShDnIblM+IZbRnvWIio78/PDeGUlBiZvjWtCvIW7/vFBZ1+NU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 14:15:39 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 14:15:37 +0000
Message-ID: <24f089bd-f102-4859-b6d3-e042bf58cb6d@amd.com>
Date: Fri, 23 Jan 2026 15:15:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] efi_vars: Implement SPI Flash store
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 git@amd.com, Shantur Rathore <i@shantur.com>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Raymond Mao
 <raymondmaoca@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, "Ying-Chun Liu (PaulLiu)"
 <paul.liu@linaro.org>
References: <cover.1768403729.git.michal.simek@amd.com>
 <da6f7b65cfb5aa81b7ff13848f532cde1b009227.1768403729.git.michal.simek@amd.com>
 <CAC_iWjKrfLXNy6a+bBUAW-xHSicir1TL0vXey2MVz8MxDsMYMA@mail.gmail.com>
 <6b91098b-8072-4691-b2b4-a41ecf6879e2@amd.com>
 <CAC_iWjLBZz1m+9o1PJJegEPE6SGfNvbAe_JuAUrrFTCE=ydOjw@mail.gmail.com>
 <2de4c7cb-4d74-4f8e-a14a-1f09ad880b80@amd.com>
 <CAC_iWjJy=77AVuPUyaJzxgQyGtkkcNcrEQsknLwU0r8e35absA@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAC_iWjJy=77AVuPUyaJzxgQyGtkkcNcrEQsknLwU0r8e35absA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0063.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::40) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ad1ca0-1449-44d0-4244-08de5a89e194
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTViVjc3Tm9CbHM5SEtsSERSTGg5V1daVlo0N1NSUDVUcVNxUVhnQVd5REgr?=
 =?utf-8?B?RitjdFNkdjhQODNsQ2luTjNnd1N2eXhTUjJnOU5CSk0rcDdnUGRGNFZ0UDE0?=
 =?utf-8?B?VFVRaGFvMVFlU212RVJRclBDNSs5ck1EWHhoam9iTE1jYjhhWEVDdTA2aXF6?=
 =?utf-8?B?emU2Z3I1RlY0QlZOOHRqR1hqNi81ZXNNdWhwZ0RJVDRPM1BmS2FWbmxFSk43?=
 =?utf-8?B?RUlyRmFnOWNpc3Nuci96d0FPYS83L3Zqdkh5TzBYZTJMQ3JsL0RKZzJCYnk3?=
 =?utf-8?B?WDJya0dHZkhNWVJadzlTZ0lSV3VCMWRNZnFmOGhiU1ZWSE1yY3h6NTFhWmFr?=
 =?utf-8?B?dVZIbWJKWjlodmNBU3dmT1labUdoNU11RHZFSEVuMEtZQlU2bHp1RkRmZmZl?=
 =?utf-8?B?ckFaRHFFVTlVWWFuNUJWLzJBU04xdGtiTkN1Q093RHUzd3VEUkJpOW82Vkdy?=
 =?utf-8?B?d3d6UUQ2N1k3dmtDekJDNWhieGs0KzVTV0l0WnpiSEtWTTd3ZGV6M2FHTEJ1?=
 =?utf-8?B?M09FRFl5U2RBVzJRM29tS2d1QVRjQ2tpQ3hYd2FQZitLcUxZSGI2azVqVDJQ?=
 =?utf-8?B?Yi9xRXhNeWp2SU5uLzdCbFQvQXlXRVhMdHRBNkZxRDZnUklsbkFtRFhlZGVq?=
 =?utf-8?B?azJvSjJlellpSXBFaXFwdjVlYitaNVJaalg4SFgvenVFd3hZT0JwU0R3eXZW?=
 =?utf-8?B?VFJvSzFyTW1hWjZBSHZKbkU5QU9TNllZZXF5RGRvcjlYMnZaSTZuMUZkWjlR?=
 =?utf-8?B?bFh5ZW0vTWlmN1RVNFYvbVVqdkxwWmhNbWlnTlVNNzJ5NFFDUHNYRU9BVmZ0?=
 =?utf-8?B?SklhRnBxUUdOWjJjV2p6dmQ2MDJhKzZhSFc4eEliS3N3eEE4RlhLLzM5eE00?=
 =?utf-8?B?NkxVMVJYMGtMYUlXZ0M2ZkFwclF4MmhNSU5scmE5djZONnFrYkZEVktkeXE4?=
 =?utf-8?B?QkhUWklWdzVSVXh0Ym5aRVU3Uks1SElReHlyTWs4amNBUlRoUUlnTlBiMXZk?=
 =?utf-8?B?WnRzcFl2a0ptK1JGQllTQU9xYVREN0xaeE9sekFxbTkxaWgxb0ZRcHNCa3k4?=
 =?utf-8?B?eG9xTlFwVDZEd0lRVkxXU1NmQ2hMQVREUTlVcURlRGd2ZkZlNFcvTnRmeTMy?=
 =?utf-8?B?bUlvYXlaYnJPZ0lwa1BESzhVRjlNTy9sM1VrQ3I0UGxFSEJVTEx4aklmcGRl?=
 =?utf-8?B?YURPWXJnM0hPdU9mNzFYK2cyQXFRVzNlSnlNSnpPelVFTGZqOThOSXhpRStl?=
 =?utf-8?B?eGxZdWNxWDBnaXg4WWpaL3NSOEtPWUJjNWZ1aWY2cjV4ZUQ5dzFYVUVWZ01S?=
 =?utf-8?B?UzJwYkRwNTIzcTFON1BlVVhmQ213SmdlcURTZGpRRUtTVHdBMEJCZkVyWWJi?=
 =?utf-8?B?T21GdzVnTWJScW9LcGQ0c0FESlZQU3daWEx4VDRyeHkyZzBzUTZWSE5YeGV6?=
 =?utf-8?B?bDlET1FqOEd5aG4wUFNjOVQyUDJnd3BycEwzUzd1eWxCVE4vclVuZFdJQlVv?=
 =?utf-8?B?R2lQakRCSkpZOXViRHhsUklTcUo4b0hiZWJhZnBBRUxIT0RpTXZHZ0NNU2NR?=
 =?utf-8?B?ZEVaSndidTFWaTVlQ1pSMG54V1gwRlB4TCtxWnZ1TktPWmJsL0lCZ21wY1U3?=
 =?utf-8?B?Y3c5MDVaWUd1aW80dVF2ZTJzQlo2VmtHREhBNFZkSEliekFVR2FrNVJwMW8y?=
 =?utf-8?B?WFdPUjNhbU1OV01naG1Qdk1iTWlNa3psNzgrK1NCa0l3Vjc1Y1NPMTFxeVBs?=
 =?utf-8?B?TUhWVVZmZUl0VUZ6VXRoRGxnS0VZblQzMjNoSUxQaFc3U1BGQXRQNm5IMm5x?=
 =?utf-8?B?WGpFR1MyU0poS1NqOEtNN0o3cE1jRE1vYjRTQnh1aFFPZ2lsUXdYSnVxL21R?=
 =?utf-8?B?bUoxOFZVSWZ2STcya24wMWJEN0dpQlRBdXFwM3hGM1J6eis1cWRxWlM4Zysv?=
 =?utf-8?B?aE52MjB3UnFoRFkzdTZXdWFKOWhwT25pVnUxTTRLUFhHT004Sy9neWhYSnlx?=
 =?utf-8?B?V1VSQXAyMldGRjVPNG9wV3NobkpJQVpmSld3L0NQWTZLeEhtV3NzMXN5ODdJ?=
 =?utf-8?B?dDdieHAxQTFXSi9rR1cyYVdPcDVjUWl2MDJNZ2FUOWo5MXV1Yk1QUFpMQ3NJ?=
 =?utf-8?Q?/vec29YqIdA7HGO1Vmv8ROqEl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUdmYURrTmhvY05zUTlIMEkwUDI5R1lqNkIyTjBaQlROSGlPcGdVV011eW9D?=
 =?utf-8?B?MlhzV2s3WWRITE5KQ1FvZnpWcW5HRkZ6dmo4Qjh4NW82cnlQY3ZScGovbXI3?=
 =?utf-8?B?U3RyZEJ1VDc1ZHNaWEFqYndJeHc5bEsrMGxZWlJpMmZoSTlWempZK0JHMTZa?=
 =?utf-8?B?NDhCZy9WaWw3dk5nakE0L1dHNm5zcDVmR01RTTVtYW9TU29xZDBLRXJQMnBP?=
 =?utf-8?B?ZWtsbWpzN3VOR09FR3huOUlLYW1FL0EycHMvMVNqaDAzempKZTRZdlp2OXpW?=
 =?utf-8?B?ZmtEYzlFWHlqOVM0S1BjK2RMVWxKcFNxNVFvL2NFanREazBKRkxlelAyY0dz?=
 =?utf-8?B?bkRrQ1hpR2FaY01wMzBnZVlpM1RqRUNTV3YrZldORHRQUDRGajhtSWhJdUE4?=
 =?utf-8?B?c1AxNTB5Zlp0bWhYenhYcXBiK2RFbEVvWXM0Znh5RU5iL29GUlNXa1dTWWls?=
 =?utf-8?B?cm5wcnpaZkZRNzVpQnU1RitLTk0yQW9lSVF5S2k3VXdHSkR2K2QzcFJGbDF2?=
 =?utf-8?B?MDI1Lzg1VmNlZEgrWTE1VG05NkYzR2VhMERHWkEzTWlLVmdoKzBLTmE1Wkxs?=
 =?utf-8?B?b3pDMUpyUVhjbC84ZGt3U3FWYmhzU1hrV1N6WjI1TXNyTGZYcVNBY0VrN3pt?=
 =?utf-8?B?THJSdlEvb2tjMXgrS0kzOUVrT1drTXN0ZDFjcGtWU3I0SlNOYnpMRktCNkFa?=
 =?utf-8?B?TzdEQ2RBMmRpZjl3V2NqK0YyZXRaWHRvVTREZnhxRDJjbzR6ZW0wY001bkp6?=
 =?utf-8?B?Wi9mVnVwdmF1RFdtU0tFVkdBRU0veU9uWDU5MmVzeVh6SG93VXpwOERoMCtm?=
 =?utf-8?B?T25jcld4MVFsM0cyN3oxQXAvY05ibklpZEg5eENuSDA5aGZ1eWk5SDZXUjBo?=
 =?utf-8?B?RXZnbzZXdG9HYTN2ckxkR0pGVGlSWDRPcnRUUG9WNFJrMXF4TURtdUFtcWlW?=
 =?utf-8?B?TFVITE5DQkFkZXluS0Y1UU8vNlNnMGVkeEpJSEcwRXdKZVpYeERRRC9QRUdh?=
 =?utf-8?B?WTF3bFRJM2xwRCswM1lpOGdzcGdDaVltQ0RVMlF1WHhzbVZ5UDNBQ08wSFp5?=
 =?utf-8?B?TkVWTU5OTTRBRXVRUkUzRkFodVhlWnE5REordlhZbGs0ZXV3ek50THpWNVVi?=
 =?utf-8?B?RVVCTTdDTHFGckRvSTkrUko3RHY2QUUvdUZRNExQbXl3STFkcVNGR2xPQTFZ?=
 =?utf-8?B?OXRsdzlQZ0ZRVmo3dEkvKzZ5TGF6VCtMRG10YzFpb1RjR2htRHo5b1NJS3gx?=
 =?utf-8?B?Vml1NEQ5UjI0SnFHV1BsU2w0WDlaS1ZZajZsWmNsd3B2cWFHR0h0elpGaXJa?=
 =?utf-8?B?d2MrbDFLV1lCblJ4dkVWc2YzcW9yT2dJOW9YWTk2SG1lWUhKbEV0OWlLQkRQ?=
 =?utf-8?B?UGlTc3VxUnRrWUU0VFNqTXVnSmZzYitnbzJRNW5xYWhjbFd2bVZBRE82eFlI?=
 =?utf-8?B?Wkh1MFIrNkNXSFY1TUFublB1a2pQSUZoaERvWWl0VTk2S3dPZlQyaXJUVDRR?=
 =?utf-8?B?YVRJb2ZjdEVjQXFrNVdRcWkvTnhTVFpUcnNqTXZVYTl2UHNtOVZyMDhxSmFZ?=
 =?utf-8?B?UEhjWmYwVWFrOVhXZDdOWk1neWNRS01kVkcybytuN0gwRVRnKy83V0Y2cC9Y?=
 =?utf-8?B?YWZKZm5GcERNalUrUE5TK2JrVDYyVHNEMW5zNVVscXVRRzk5NUIzVW9KakdW?=
 =?utf-8?B?WU1EUk5EL1FqcE5hTk5mUUNLb3gyNmJvTXhQR0VIcXZIa0VDb01mV05XRm5k?=
 =?utf-8?B?TjZLWjRtYVFjejlMcndMbTBWOFo4bFp5d3ZmSitDeW9ZQTlSbmxxL3JlaDFU?=
 =?utf-8?B?cmZRUWRvV2gzRmtvcGc5VlE5YTQ4K0JXN3hEd2UvYjQrNUFKdG4yUXVsUytT?=
 =?utf-8?B?NGlEMktoY2pPZFl6Vml4bGEwUzkzcms4NlZ1Mi9ubU5FRVl5UC9YU0FEbnNW?=
 =?utf-8?B?d21hcVk3TCtvUVV4Yzl5NFZjU2FldGx1ZHhOZG1DSHdEdCtQa3NqTEczUStZ?=
 =?utf-8?B?TWJ3R0FueGs2L0wrVThwL0RoZ1ZBdWJzRFpwL3kzMUFsT3Z4RnlJKzhuR0RG?=
 =?utf-8?B?a0Q3dE5zRWo0VGpoekt4NUQyNU9IS2d1YkZpWXUwYWFYeDk5Q3dxdXN2WC9p?=
 =?utf-8?B?Mi96b09LUnBQQXFvVkw1ZmY4UkJhNEl2algwWDlpQ0t5cktJQklCb0ljTXNM?=
 =?utf-8?B?RGh4cHJsdEFkbnV6cHpWZ3hlK2NnS09CbmJ5T1JBZHFPY1ZTdE90VlY5eEVt?=
 =?utf-8?B?bkErc2NLZE5WakZJeU1IbmNXT0NkdytlU1JYUzJ2NWd0N0lWTy9SSFVuNFQy?=
 =?utf-8?B?UnZGUzFHK0gxREJOMWdUcm9iMHVWc2hLTS8xU1hvSTIwbFB2cjM1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ad1ca0-1449-44d0-4244-08de5a89e194
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 14:15:37.7501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMxmJDnnQ10EWQqyV8fc29D18AaqVvuumDh22HDYkaC8P2UC3yI8HcOpj9e8yNuK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245
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



On 1/23/26 14:01, Ilias Apalodimas wrote:
> On Fri, 23 Jan 2026 at 10:22, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 1/23/26 08:40, Ilias Apalodimas wrote:
>>> On Thu, 22 Jan 2026 at 14:32, Michal Simek <michal.simek@amd.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 1/22/26 13:18, Ilias Apalodimas wrote:
>>>>> Hi Michal,
>>>>>
>>>>> [...]
>>>>>
>>>>>>
>>>>>>     config EFI_RT_VOLATILE_STORE
>>>>>>            bool "Allow variable runtime services in volatile storage (e.g RAM)"
>>>>>> -       depends on EFI_VARIABLE_FILE_STORE
>>>>>> +       depends on EFI_VARIABLE_FILE_STORE || EFI_VARIABLE_SF_STORE
>>>>>
>>>>> Will this work on nands as well? They got a  much shrter lifetime that
>>>>> spi flashes.
>>>>
>>>> I don't think this is valid argument here. Users have options to decide where to
>>>> put them. The same argument can be used for u-boot variables saved in NAND.
>>>> Obviously I can update Kconfig option with saying that you should be careful
>>>> about it but it is user choice.
>>>
>>> Yes I think that's a good idea.
>>>
>>>>
>>>>>
>>>>>>            help
>>>>>>              When EFI variables are stored on file we don't allow SetVariableRT,
>>>>>>              since the OS doesn't know how to write that file. At the same time
>>>>>
>>>>> I am not sure we need to allow this for now. At least not until we've
>>>>> talked to the efitool maintainers and make sure they will accept
>>>>> another 'special' case.
>>>>
>>>> Not a problem for me to disable it for now.
>>>>
>>>>>
>>>>> The problem with allowing this is that if people enable it, boot a
>>>>> linux and do a setvariable, it will return a success. But none of the
>>>>> variables will be preserved after a reboot unless someone manually
>>>>> updates the serial flash contents. In theory, we can preserve the
>>>>> driver  model and the spi drivers in EFI runtime services and allow
>>>>> 'proper' setvariable at runtime.
>>>>
>>>> Wasn't this the same case for file based one? I mean u-boot had it but efi
>>>>
>>>> Yours efivar patch was merged Jun 23, 2025
>>>> But this symbol was introduce in U-Boot April 18, 2024.
>>>
>>> Yes but the patches were sent a long time ago in efivar. If you look
>>> at the original PR date it was a lot eariler [0]. It just took a long
>>> time to discuss and merge.
>>> Apart from that the case for file stored variables is by itself pretty
>>> unique and convincing the maintainers to accept the patch had some
>>> basis. I don't know if they want the same workaround for spi flashes.
>>
>> Correct June, 2024
>> https://github.com/rhboot/efivar/pull/267
>>
>>
>>>>
>>>>
>>>>> However, I think this is not very useful. Having an unprotected to
>>>>> store authenticated EFI variables, is dangerous. Someone can erase the
>>>>> SPI flash and efectively disable secure boot. Due to that, I prefer
>>>>> the current file based approach for EFI variables -- which doesn't
>>>>> store/restore authenticated EFI variables (and which this patch
>>>>> implements). The obvious downside is that enable setvariable at
>>>>> runtime is tricky once again....
>>>>
>>>> Isn't the same happening with file store too?
>>>>
>>>>    From implementation perspective it should be the same as file based. Obviously
>>>> efivar part is missing.
>>>
>>> Yes. However, that commit included instructions on how to set runtime
>>> variables with dd, so people could use it until the efivar changes
>>> were merged.
>>
>> I don't think it is going to be problem too.
>>
>> What about?
>> dd if=/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac-11e818c3130c \
>>      of=/tmp/vars skip=4 bs=1
>> flashcp /tmp/vars /dev/mtdX
> 
> If you manage to test this then yes, please include it on the commit
> message and in the future we can add it to the documentation

yes, I have also tested it on SOM.

Let me send v5 with discussed changes and also with logs.

Thanks,
Michal
