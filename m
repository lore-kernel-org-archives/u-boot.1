Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809A3D111BD
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 08:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A56028855C;
	Mon,  4 Nov 2024 09:32:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EMCktY2p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4494E8852B; Mon,  4 Nov 2024 09:32:57 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BE6A8855C
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 09:32:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V040p9hmzjw1KQEUQ6vy8ggaimrWqgEoOr9BgwcLSh9RVrjOlfGjIZJNhB5AAIKZPxR+As58Kr0iheuaEAgy308q6rBDgO6yj7lmIeugPasqg7EmvEiMyQIx45bd9+DUbtctDw510yLsx7B3epKJlBC0/GU+eiQ8bM7W25BcjwsK9JdnfAy5z4pxCD2A8U1sItIM8bIOQ2suht8LLzRXE5gHJfyShbWLSSNx5ZRT1j2Vd2l/nbUiH4Lu+sUuu7KIEzrO61MtifkDGEZ0nFwBCf6fYlDUFQcKPqvy3wTu4bPQb3nQ8cjh+u5MGKUUaILbGKBry7dWwR6GqtxWxcLc8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUZqZHuH0wBkegGlBQAyyhgJbq1snFVDKhXeCGatiCw=;
 b=GA3fkFEQnDZJ8CoOiwH3VXa4U4jWokDbrX50IT/AxogiiRzjCFqBpgE3OPkyc8Q8mrzMRvJ0HDVSB5/FfIWzLRJznsvUiqUyB/wnsjZm6Su6ZsB5oRugGnBDg4dzwpZ9UaPz6oM/wLQ9kKVe1t1Gh0E/4TkAGNhAFlk2NVde7uOpEqd41iLkRiPcSKmBIBJRoQu+LykNSIVzFT98cANKPE5STVilXZENTKM4RbUFtLWz49Wa8HjEWQ/oBI3GAJ12fgRB4PnW1BPdb11Za/AcORF0gKCPYI5OG/MMkWndXyWM/VLy/j+4mpo4R19llJPOfe12SMOhcmklXE4CIzQLrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUZqZHuH0wBkegGlBQAyyhgJbq1snFVDKhXeCGatiCw=;
 b=EMCktY2p2c527e4f53+8HeGKVVhWoyNOH/x9neHMmyehfoRThqA/nQBlac8OQkm62lQFH3EOkyCSvh0hRkzwfZrsZJmn5ytJ0ZQEzBksKPnXt6Q3cAgVyEI7pPWSG9BmbQ8i8soENMacmLdxJhhKuvP5QxYCIhCRkYjMnurDMI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 08:32:50 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8093.035; Mon, 4 Nov 2024
 08:32:50 +0000
Message-ID: <c5b1aabb-c9e5-42b8-a73e-1ddab887a774@amd.com>
Date: Mon, 4 Nov 2024 09:32:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] zynqmp: Add binman description for SOM
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, neal.frager@amd.com,
 Charlie Johnston <charlie.johnston@loftorbital.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tony Dinh <mibodhi@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <de1b8dbabd5ab7f20d7aac217ec4f5074d39f1da.1728462767.git.michal.simek@amd.com>
 <CAFLszTh6s5n4nzC7UKhFnQuXFOucGA6amjN1eV4NqwjV6-NEeQ@mail.gmail.com>
 <1048553d-4818-4aba-8bd1-c958dc0b7c5e@amd.com>
 <178d29b0-d82c-4b18-a3ed-3d46dcc02446@amd.com>
 <20241101135220.GJ3600562@bill-the-cat>
 <CAFLszTgSX1cn1y3C=QHuVfvVr4486ezaFAL4pmdPAvi6m==Lcg@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAFLszTgSX1cn1y3C=QHuVfvVr4486ezaFAL4pmdPAvi6m==Lcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0032.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::45) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dbc9fcb-3868-4a94-39b8-08dcfcab4496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dyttY3NqV2lhYWpJMndBQzhNZFljSDM4dFJuSHg4RlhXUS83MUJCaEZEUmVD?=
 =?utf-8?B?T29KeDhjeXdBaFJRRDVWb0RZQUkyemJRZTdsL2FKN0ZUVCtXTVJicWk2eEhU?=
 =?utf-8?B?enBSQzJsQVJZQ3B1S3EyQmdwNE9TVG1XbXgrcVNOWE8zb2xPUHJDRHAvMmNC?=
 =?utf-8?B?WUhhb3dCRWRaM3pwN0dBKzN3Y0ZhY1QwRlJMTjdkSHpzK050bTlkSSsybVdu?=
 =?utf-8?B?c1RPNkJzckE1QUQ0UFlRUnRmRWxlY2d3Rm9Cb2MwSEN2UEFHdzIyT1VlRjB5?=
 =?utf-8?B?Y296ZjlwMGZ0UzNhZzJubXJxbG9oZG1uUDk3dG5LT2dhRE9JdndSNVNvZTZx?=
 =?utf-8?B?Mm4yTEsrVStOQllJdEhPeUJDejVlN2h1K21oTXJEbGQ1OUNlSVJMaVE5UzhY?=
 =?utf-8?B?NGlnY2pBSmhRTlFOZS9wdFRlaDZlQ1JqZHh6OFRaV2RNQ3ZaQnNWMGN6Z3Ri?=
 =?utf-8?B?MjFyd3JmZVNmOTRTTk03Q3VINVB3TFZNN2E5OCtWVjNxaGNEdXdZWEozZzJn?=
 =?utf-8?B?aFc4WU0yamRUY1pqemVSV1YyM2JJWThaMGZDN1l1QzFwOFkxa3JCMzUyMWpm?=
 =?utf-8?B?cFJXZ0dQV3dId1Vlblg3cG5xQURpYUxhWllZamo2Sk5DS1NwZzFpS0RiNTJU?=
 =?utf-8?B?SVR1bnNHbFY2SHg3UnZ6QnpMVCtjV3kySU9zL1F0YnBoRXNFR0UwMjY0cENr?=
 =?utf-8?B?UXhQNXNOalBaL2dSSTRRa0p2NVBTaUZNK0ZJcDBoQjBiZ0g4Zzk3UHFTakFK?=
 =?utf-8?B?RDFRb2lVTHZVTGRrUnZxRlVyd3hFWGhyV1hDSnpKWWExN2RDdEplR0NhMWxU?=
 =?utf-8?B?RlR2bitoYlBrN0hHRWxOWk8ySytYMmNRdlNFM2FNaDVrbUV3U3dPNWVHUU5x?=
 =?utf-8?B?dlV1SU5lWWw0QkFSeUFML09Wb3VYa3Y0OTdJOFpHcHBKMkxublR4dkJCd2Rl?=
 =?utf-8?B?NHJQM1N1OXlBVnpLNTNTeldmRlhlbElmd3Y1aHgwSVdENUlpNHVuYXc3Q3Nn?=
 =?utf-8?B?cDB4dDNHTnI4MVBBSzd3dDQyckpJdlBLRzU0Z1U5OHhiUjFRRnhMODRQZkgx?=
 =?utf-8?B?NDJlbnBQUlBPOXNDcGNRcGRkcHFIT0hna2lzTDliTE5VMGxhSEpRYS8xeTdE?=
 =?utf-8?B?dnZiUEczdzh3Rk0rMWR1ZmdGS1VSdXBXYjNtOGY2Q25pbnRZSGVtRUprME1y?=
 =?utf-8?B?TWt1NTBaZ1FveC9oN2Fsd0NXQnJ3L1JwSlZMU3ljckoxUU9LSmNPMDBhcER3?=
 =?utf-8?B?ZHFwZXZQa0JoYlhzTkNlNTBuUjJWcnk2L1l5eEtUc1ZjVFdYcjRCcEpvNWZ2?=
 =?utf-8?B?UEZnOUZuYVc1RDZXNVk3MldRRjJndHZ6anlmS3ZBTDBqVlJzY05YQ1hMT3FH?=
 =?utf-8?B?NCtPSjZiYXduTnlEZElEcWMyUnMrbHNWVHVDNmYwaEhHY0JCaFlWY0hQSHNS?=
 =?utf-8?B?SHJ3bmxjMHl6VkhGWGpxQWdmQytBbjhpejRvN0tlNXRET2FSYVdUVE1pV1RH?=
 =?utf-8?B?dkxUMHU3UVljUGVLbTBrTDBKQUZUb1ZPbEFVRlQxVEUwd2JMc3JVcXV6Slhj?=
 =?utf-8?B?eXNNRHFQRU5mbDBCcjJNUDV1eVhUSC9jV2RkckF2d1RhQStqTGNmTUowQUZt?=
 =?utf-8?B?dmlQdGFpbUFJdkxZd2NScDFScnViMko3eVBHa1dJcHE0WWxOWEpkNXJ2alA4?=
 =?utf-8?B?SG9HdGFFYzVYYndUVFlaUjB3QVpLRnQxanA4bDUwVkZMNHAvTTlscEROVCtP?=
 =?utf-8?Q?rJnZnaERaBeKcXAcJArGyVTRYJcbJhdGnWN8D4F?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGkzK1hWaFJ1VWhHMDVOWUJ5R05sM3ZOOC9wd2VyQnFBSzVmU21CUk9PdXRZ?=
 =?utf-8?B?cU5XR1NtZ0NlTmMrNDVSeDJLd1VVQ0d5b2p0N25vNUJEZGIyUllhM0VpT0NF?=
 =?utf-8?B?S0IwUTEvajNhRmpWeHNwdXVxb1liYlZoNWRXZUt6L2tOTm54MUlsc0c4SkZz?=
 =?utf-8?B?NzIwd0VDbDJHTTRIVUFLTU5QOVhkWnpYMDJJNE92SE8wWmxxalYzcVc0OURH?=
 =?utf-8?B?anlGekV1MzlyVlRVbzNlaUNRN1pUQ3JQMkZvZ1N4S2NtWTB3YWs3VGs2V0xi?=
 =?utf-8?B?Um9KdElqR0hRVUZuSzIyTU44TmhyUDFWL2JMbFpDazhJajIzQ3BheUJHOEpp?=
 =?utf-8?B?bGVmZmo0MitGVTl4TEZyM01QbFl6Z2IzRzRyazQ0akJoOFJjZEJOakpZQkxh?=
 =?utf-8?B?eDhVbEhpNngxVmhSTWxQUitvYk1SWWVOQzlLWVdsTFpzd21zTmVzZVI3dHZy?=
 =?utf-8?B?VFgrdml3WTJ1Ni9NaGFwLzZKL0Z6MTNRMVlyNTBvTHdBU1djTFpXdGFyRkdD?=
 =?utf-8?B?N0hGSy9SbWNmOTNWa1ovdENVdWpsZE1LS0tSa0xwRnBGUy91RE1jZHhNcDdJ?=
 =?utf-8?B?ZzgwM0ZmQUg0VTU2TGRhWUQwNXFnRUFlNXFwNUlVTytSMklBRXNMMkkyUVpT?=
 =?utf-8?B?NGtqWXRkQm5KazJiSzdYZWZTV2hISFNGOUVNWWI4THBjK1M2WEpaUVFtc0pB?=
 =?utf-8?B?N2JNSVJuREorRWlIdkpBQUNTeFBoT3NwOUI2dkk1SC9hdkpUNXk0eDRCK3FD?=
 =?utf-8?B?aEl5ZHorNjYrZWZqbkV0ZE1sL3NKdXhBQjVwbllwWVRHb3QrOEFZUVR3Ymc2?=
 =?utf-8?B?Z3J3L3BZejRlVERQQ041TWg2REU4dzlBRFRORk1GaGZ6S1cxV0ZYYVB1RlBQ?=
 =?utf-8?B?eUhsSFpFV00wMmgxRFc2VWJYYk55dnlvd1g5MUZhK3ErbWQ1cjJxVktVMjY1?=
 =?utf-8?B?UFRXWEdFVHhqbUk2QWxGWDI1SWVkNko3Y0lVbWw4cGZCc0FKSEtCcUltaVAv?=
 =?utf-8?B?Z2xKUzRLSi9tSzlVOW0rb0pGYWFwVzhKTU1QQm9ONU5hR2o5OHdZREVoT1Q5?=
 =?utf-8?B?VHArdVo4L1BpZDIwQm1lTmwvNzRmSU5lUVUrQnB2Q0JhNDA2THB6WUE0UU82?=
 =?utf-8?B?dS81WXNvVG9tUmwrdXprQlJWMDJmQXZIa3YvcFNHNTAxSThYK3JJS0NaTHJS?=
 =?utf-8?B?cFp1cXhnYXpQVkpsL0JYRkVFaUVsQXIyR2YzR3ZmOS9qcTRFK0Y2My9nRkcy?=
 =?utf-8?B?T2NPUkx6dWpHQk1xczNKV2ZCMWc4VlBlN2NpTjRtT3hENW0xSlkyTnE1eFlU?=
 =?utf-8?B?RHNIbHZLajlzWDR4L0xVbjI3SnJoSDhTZTlNWDdaRy9lS2ZPeDlhTWtJdkVu?=
 =?utf-8?B?bzBISHZSQlNwMzQ5VHlGQ2NFZXo1Q3VNU0dFd2d6RVBEcHY5dHNMSTBWVWt2?=
 =?utf-8?B?eUZ4dUJzYXRZSFFDQmFiUDlIM1poUHgvRGdNVnBrQVVZL3Yxck5ubHp4aGwz?=
 =?utf-8?B?bmRXWEsxYWJkTW5Ia1UzT21uSlVQa09lY2dPRzZLYXcxQjJTbVZkSC9SbC84?=
 =?utf-8?B?Ym1tQ0xCM3QzUzhYUTQyekNjQXFoeG0rZkxNNVNOWG5JUkJMbEV1SzFMNGUr?=
 =?utf-8?B?NHpIcG9YNVF5SXdsREhLRDNRRHZRdXlZdWZvREhiZk9xZ29ibmJoQVRKekti?=
 =?utf-8?B?NEFJNXF3TTdCNFIycGNiS2Q5bkZNK01UY3pnaW9RNnlyZWdUVWJCWC85REt1?=
 =?utf-8?B?eTdWWWZCcWFDZGZ6YmFJeUhJR3AyYlB5dVhUSWM3dzlGeFh6Q28yZjJlbWFs?=
 =?utf-8?B?ZFNUNHpDTDhWSlB0MldBVVBYdFl3OGJHSFgzZVRsYytibU8yWTBBY1RDZFhS?=
 =?utf-8?B?VkVmSG9CMlVKZUlRa0IxQmxiTWxoanIzeHppcjZ4U3UzMVRyYkRSVE1Qckdj?=
 =?utf-8?B?dzdmRkdIbVZhWnVQTzBBNk1SY0V3WWJTdENUUWhacWZVRHFWNWdzWEVTVTMx?=
 =?utf-8?B?VzVpNmhLZDBGUmhOaDNHY0VlSTczUnR1TXI2LytvdS9YYVp0SVNKKy9rTkVq?=
 =?utf-8?B?V1U3VC9KeXV2M3JPM2xkbjVCOGlJV3J5SDNyWFFOVmhtRmk5ZW1LOGMwY0Nh?=
 =?utf-8?Q?tHFXd2r7xKEVAXTu4FPSCxSLA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbc9fcb-3868-4a94-39b8-08dcfcab4496
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 08:32:50.2981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4xgleyezGE+RS7s0nPB74VIwU0FxyKmpgmLBy8NHhJ0/A5XiWACLj6O0HBgn1hW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790
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

Hi Simon,

On 11/2/24 17:28, Simon Glass wrote:
> Hi Michal,
> 
> On Fri, 1 Nov 2024 at 14:52, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Fri, Nov 01, 2024 at 02:09:38PM +0100, Michal Simek wrote:
>>> Hi Simon,
>>>
>>> On 11/1/24 09:27, Michal Simek wrote:
>>>>
>>>>
>>>> On 10/31/24 19:03, Simon Glass wrote:
>>>>> Hi Michal,
>>>>>
>>>>> On Wed, 9 Oct 2024 at 10:33, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>
>>>>>> There is necessary to do some steps to compose boot images. These steps
>>>>>> were in scripts in layers for a while. That's why introduce description via
>>>>>> binman to simplify wiring and remove all scripting around.
>>>>>> This should make sure that everybody is up2date with the latest versions.
>>>>>>
>>>>>> The first step is to create fit image with DTBs with descriptions in
>>>>>> configuration node which is written as regular expression to match all SOM
>>>>>> versions.
>>>>>> Description is there for k24 and k26 in spite of low level psu_init
>>>>>> configuration is different. The reason is that it goes to u-boot.itb image
>>>>>> which is the same for k24 and k26.
>>>>>> u-boot.itb is another image which is generated. It is normally generated
>>>>>> via arch/arm/mach-zynqmp/mkimage_fit_atf.sh but this script is supposed to
>>>>>> be deprecated.
>>>>>> FIT image by purpose is using 64bit addresses to have default option to
>>>>>> move images to high DDR (above 4GB). TF-A and TEE are optional components
>>>>>> but in the most cases TF-A is present all the time and TEE(OP-TEE) is used
>>>>>> by some configurations too.
>>>>>>
>>>>>> 3rd generated image is boot.bin with updated user field which contains
>>>>>> version number. This image can be used with updated Image Selector
>>>>>> which supports A/B update mechanisms with rollback protection.
>>>>>>
>>>>>> 4th image is image.bin which binary file which contains boot.bin and
>>>>>> u-boot.itb together and can be programmed via origin Image Selector.
>>>>>> This image can be also used for creating one capsule which contains both
>>>>>> boot images (in SPL boot flow).
>>>>>>
>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>> ---
>>>>>>
>>>>>> Currently I have this for testing purpose only to find missing bits and
>>>>>> pieces in binman for cases I want to support.
>>>>>>
>>>>>> This patch depends on
>>>>>> https://lore.kernel.org/r/ fbed0251437b61a2f7a85596d7403b5b9c8237c1.1728306322.git.michal.simek@amd.com
>>>>>>
>>>>>> ---
>>>>>>    arch/arm/dts/Makefile                |   1 +
>>>>>>    arch/arm/dts/zynqmp-som-binman.dts   | 224 +++++++++++++++++++++++++++
>>>>>>    arch/arm/mach-zynqmp/Kconfig         |  17 ++
>>>>>>    configs/xilinx_zynqmp_kria_defconfig |   2 +
>>>>>>    4 files changed, 244 insertions(+)
>>>>>>    create mode 100644 arch/arm/dts/zynqmp-som-binman.dts
>>>>>
>>>>> I'm pleased to see this. My only suggestion is to use '/bits/ 64'
>>>>> instead of the macros, for 64-bit values.
>>>>
>>>> When I was playing with it some time ago it didn't work but it works now
>>>> that's why no issue with it.
>>>
>>> One more thing on this one. I pretty much dislike that images are generated
>>> to u-boot root folder. Isn't there a way that they will be written to
>>> separate folder (deploy for example)?
>>
>> Or perhaps $(obj) ?
> 
> Yes $(obj) is where they end up today. I consider output files from
> binman to be on the same level as other files created by the build.
> Then again, it does end up a bit of a mess, when mixed with the output
> files.

Some cleanup would be good. I remember a lot of discussion about if people 
should be using u-boot or u-boot.elf. Answer was simple but if output images are 
in separate folder it would IMHO better to understand.

> I am not keen on 'deploy' as it nothing is being deployed - also it
> sounds like a satellite or military attack.

No problem with different name.

> 
> One long-standing issue is that intermediate files are created in the
> same directory. Perhaps we could put those in a binman-tmp directory?
> They are necessary when things go wrong, but don't need to be used all
> the time.

+1

But I think we should try to move also that images which users should be using 
to separate folder completely. Again it doesn't need to be done by default but a 
way to configure it would be good.

Thanks,
Michal

