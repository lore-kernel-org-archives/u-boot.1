Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A951C3601E
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 06:29:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C900580944;
	Mon, 14 Apr 2025 08:28:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J8yws05l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD52B807AE; Mon, 14 Apr 2025 08:28:58 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3714F807AE
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 08:28:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrMr1YjVJD+XDGEKDHicJCSc1f3AEwqAeZ0IIp2BdYCK+7ZCgur1f/4mdyU4WgdGqxQ1/XF9dqUmEkFp+r8a8EQA+WgujZQ8zBP/2KZ/1s28Rkz1dJrrqDGl84Itg1dKACtBOTaWOfX30sX2rMijLBXz/PhrHnF8p91rN0LMd0+mwk3xpPwV1W3U1tXyWylCza5NVimpTbiI/fItbKUuUUxoNyewJOdyOXNiUWuSnt3UAbdfD4qbzASno9g509SOgfyn+B8zsAzbj+cshwsNdivbUjBOcU9YyA89v47GVVQbzLYd3whO3HCnq5pi5M7Bfajh1AHJNbX5rzOA/X3LXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0OSRDJuUUuvFOM3j4CCOGPCUXMjwhgrQEmyArz3IY0=;
 b=Oit81P8ezl+LsQFZPMVz7497Do9ElthMCyT0EwNzi4kE8lpVoghWpjtPyd97Q03zSasP2a86fGOIBC8WHnemHJgxxcePU52JqqcXzOFHy4ycCApPZ0k+1Ylyax0uNECPMnV3mVaaDtDAQL4DBDXVsx727s3bsGed8yClJGVewYSOA97cuV5tWJQLtv7vA6RGhKKw2facrPo88WR5ThtVu6esSxOzt2N1CsZNNewKJ/eHT9Qyuh45SanISVZV+wOli6N3MUCyGM01vBGOrkk/T9swJT40R+ubSktKrSFsw1zvJqXGPWxmTNV0tYL13qjOXRLHSKo0mN0ABe7+z5jcUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0OSRDJuUUuvFOM3j4CCOGPCUXMjwhgrQEmyArz3IY0=;
 b=J8yws05luNfqVzVNCX6mLAaIgJEWO4gwzsrsfJmKKXGvcRITr4eW7wguaT1R9uf7SoysYA5TET77sx1u4FVtPL0jS6ykkZv0r/x0wxeH7/8HNsxm1WlpmF9RnfWZ3INozfVoXG8+t4A6xG3aOO5LjDBu5sClxViLGt0JHxX3NaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 06:28:52 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 06:28:52 +0000
Message-ID: <a421b683-01d8-48bf-999a-7f50fcba3356@amd.com>
Date: Mon, 14 Apr 2025 08:28:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: versal: fix dfu alt buffer clearing
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de
Cc: Jassi Brar <jaswinder.singh@linaro.org>, Marek Vasut <marex@denx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>
References: <20250407170529.893307-1-vincent.stehle@arm.com>
 <20250407170529.893307-4-vincent.stehle@arm.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250407170529.893307-4-vincent.stehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::16) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB9030:EE_
X-MS-Office365-Filtering-Correlation-Id: addff600-7774-42a1-63e3-08dd7b1da00c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1VuL3Y4cS83b1RvU0VnYjlOL3NhczF5L0RIL2tuU0l6WGFac3IydDAvY2p2?=
 =?utf-8?B?dS9UYUFJTmJYYWkya1EvVzFhS2U4Mm1QNG0wSHQzSHNDRHBJaXBLd1BrNjJh?=
 =?utf-8?B?VVgrNmhVcFYzY1F3Z2k4emFrQjlnZ2l4a291Wk81K3A4Q1lFeVhzZnlib0dr?=
 =?utf-8?B?aTk0Sk1wY0hDdndIUFAxSTRJU2grK01OYzRVa2VPV2tadE51WEQ0Q2d4eU8x?=
 =?utf-8?B?MHQvOXFacG50eldocHpZN25ieDNkKzR0Vm00MWQ2NGtheVpPUFRQR0pRM1JS?=
 =?utf-8?B?REJhWFp4czArUlZLVk9pMnlrVmUvZFUwV3U3Z2hDeUpGVjdkTE9TUjN4Um5S?=
 =?utf-8?B?MjhSZDFtWEM4dVp0azRQUVFDc0xwdmljSzF6Sm9mZnBTUUxpcWx1OEFFek1V?=
 =?utf-8?B?YitEVE42QzJCd0JJZm9OUEFpdjRmQ1dTbFZuVU10N2VKOGtKVjF2eGV4YTlz?=
 =?utf-8?B?aUZWTkFVcUpqTk10TzJxVUl1aHZ4ZzJDc2dpSFFvV0s0SVBGSGpwSHl1cUhr?=
 =?utf-8?B?NHZYVUx3Q0lyWTZpZG9yVjZXOFNzc2FpbXlnRDNsNHNJQ0hYSDNaUnpLWHBk?=
 =?utf-8?B?REFiSXhtNk5PaWdseVBES0kySENNMkFUMjlEVVp3UTRYZGxKc3JSZkxTR2pP?=
 =?utf-8?B?b0YrSERWK0tFeUcrbjgydEs2bkt6dkZvMThaRjArUzB4Yy9QL0R2YlRmTWRh?=
 =?utf-8?B?Y211Zy80V0ZhZjZUMlMvdDk1b1Jkc0ZtM3gvdW9iUUxZYmhaWWVpVkZneUdv?=
 =?utf-8?B?WEFMOXE2akROUUxLOW8wY2ZFT3hhcDJrcGxrQklJY3M1ZlFEM0d6Z3lJZlRh?=
 =?utf-8?B?bkdVY2MxdjJZQ0tVcWZ0bURlU2JWdWtOTlhGUlFWN1FjaHF1a3plK3RUNHFo?=
 =?utf-8?B?TUZ0QkJPRkpBUkVFSlppbE1zc2lYWHJwSHBDSDBnYTBRYW5jTEtYOUdQMTQw?=
 =?utf-8?B?Nm5NMHNhOVNxR0MwNG9EVzNnUElqWER1T3A3dUMrR3JSZFVGaEpvOW52T3lh?=
 =?utf-8?B?UlhwU29tT0xROUF3aXhpQ01NYkx6Q1pIMHdsdWd1OXprd25tdWRyOHZWZFZK?=
 =?utf-8?B?ZVFYOWJHTmU4UytCcXFJN2xENkc0T1UyV0ZCR2tnbUh1bFZhWlFnanNpSUlN?=
 =?utf-8?B?OFYyMFlERTFDMnAxVFJBNUlLTlprRG5XeGd0b0twbWpSTHdxK1NwS0Nzbjlm?=
 =?utf-8?B?SjBwSFI1OTc1RnNzQXhDTVBlckR0K0x3V0wrYUlNZUZxdmRRemR6WUFrYUJ1?=
 =?utf-8?B?Z1lBZFVKL01pYm50YytIdUZQNXA3b252aHIwMUtHcXJFRTRSWlU2UVVkNFZJ?=
 =?utf-8?B?QXRvRGE1b2hCRzVxWUpmcVRDSVBWeFU5bVpQM1poVnZqQnVWSzBHNEkycVZL?=
 =?utf-8?B?ZjhBY1Y0K2Q5em9UYzFSbFNUVHVSQXhrVUJuVjNnalFlRkRPdG14bEp5R2Vw?=
 =?utf-8?B?bjcvdzZqcnA4cW1aZWo0RkJWYkhyaTdLSktmd1FuaE05YnhBN0dsakNSemVj?=
 =?utf-8?B?dTVjSG0xekJHdDlrdzlLaGhKdTdGclFuYTVIeWxxMmlNbDFMTituaGRCTHZN?=
 =?utf-8?B?RnRVYkdUWVMxN0Jxdy9XZzdDcHN0MDJ0SFJ6T1pmTTJ6WEZyaU9kK0luUjFK?=
 =?utf-8?B?SGk0cFpzM2VxZVhXOVBEUGFUUDhIY2YvNVRXUCs3ZGFmaTdVZDhBMHQrMS93?=
 =?utf-8?B?ektDWlJkY2gveTZhMlZSWnVQcDlDM3pPSFJhaHBvVTBKQjNvUkYwZkk0THVv?=
 =?utf-8?B?SVRJU1VnRXJEcEZZcVFLSDY3Z1d2Tm1LdE4xTUhxSmRkb2JpWXdrN0k5ek5N?=
 =?utf-8?B?QUw5Q2FUZ1RQVmVycE9LUlBxbGh6aGhHT1RLTENGcnVrVDMyb2Z5VmZmbFRL?=
 =?utf-8?B?NytDdVMvT0p2MW9PekRhUFE0Z0J0K3V3MjJubjJyKzIwNVYycFdYampoRkdh?=
 =?utf-8?Q?EJLAVkIPw1o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTFXSWZTSmVUOURaLzhHQVpUQkR5eW0xdkFkV0wycnZ6dEpoSzc0VkQzd2dJ?=
 =?utf-8?B?K2pZWWpYdDhUNFF6QUdCQkYyLzJ0TzY5NHB6U1JGWFl3bnM1UjhkN0RFK3Vk?=
 =?utf-8?B?NFRhVVMxMlA3T3oyUTQ0SDEzNHNUQmt0MDQ4NVYzZ2VUSlBqVTAwRWhwaEVh?=
 =?utf-8?B?YUFSR0ZXKytFSVhZL3UrYVAyK0J1WFlBTk0vVG51WUFXcXB5Q012eDB4Yll4?=
 =?utf-8?B?cUZ3bktyanMwRTBiYzVWSCtxZXQzdHZZODc4Qkl3YVZncDZtQWwwdUV3MWFJ?=
 =?utf-8?B?UEIwRi9CUFNRSUlGUVpUa1VFMFB6ajNNL25JaENMa0xLN0t3aDdwSWdwVktx?=
 =?utf-8?B?dDZGQUNES3lOVWszWXZ3MWpDbE9oMVZRWlk1K2N5TEZEekVqRUszcG0zbEJN?=
 =?utf-8?B?TUxvb0N4ZWJyVDNrNzB1L3FkUW1sSVFGVjJNZzZuU2o4TC9ZSmxxUnRFNFFz?=
 =?utf-8?B?NDc0b09VL3lHTTFpMmxnUS9zdy9RVCtKZC9sYlNyYlhBS3I4akxYaEx0WEM2?=
 =?utf-8?B?YnVNTENVSXd1M3BsVjRZMW9jR1FEK0xaaDVkQXRscVNieURncnJpQWw0eEF4?=
 =?utf-8?B?dXVMNjVMQ3lLSU4wMXFlbVZ4RVFJbFFKU1Z2M3RqeUkyaE0xa3pOUVB5d2lh?=
 =?utf-8?B?WGhQZ283enczVGVrbWRQSE95MW9pUzloWU1qRUVPNHRjQUt6QmxzUWQvWnNL?=
 =?utf-8?B?b0ZXMXZZVlEwdnBaM2pKSVdKSmlxM0M3UmtpUUlFUjhCcHE4QUd0c3I2enEy?=
 =?utf-8?B?OFNvc2dpNW13T05YaEtPZG53dW93cjg4a1p6MVlaNSt1ZGZSaHEvV01TRWlU?=
 =?utf-8?B?SlFLZzRHd0crNFlxbE9PNFF3bGJtY2JLM21na3Qyam1XcndORVJxcUt5N2Ew?=
 =?utf-8?B?Tnh1Qk1kbHZybEVVS2MraEdXa3d4cDN2Z2Z5T3B0ci9uMms4NUM4NU9jUU9M?=
 =?utf-8?B?NXoveEU1MGpJSnMrNS9pSTdmL04yeVdrV0NMeHdlclE5NEg1a2kxOUtFejRv?=
 =?utf-8?B?ZmFxWW0zNFNGeUV3aDNkMmJXNGNnMytCK0lPVXI5YU8yV2F0RjJaZFExSjVR?=
 =?utf-8?B?OFdKZ1JnV0RXNFl3bHpONDk3UEtKWG83eHhMeHFZN2prY3BsWkZSamxyLy9B?=
 =?utf-8?B?NGhUd1JWS0R0NkRqVlVtR1ZoQ0E5d3IrN3YzeGdPSDBRSDdKdVlhTWhHcExr?=
 =?utf-8?B?MkZhNkZuQ3BJL0NYRTZoeUViNFVQV3NuQXYrd0ZaUy94RUhrSmJZN1p4ekta?=
 =?utf-8?B?Vi92SUM0OXVIV29MYTJPd2VkWCt1QkJwN2ZqbENMVnpiVDVNVnpxRmMzV2VC?=
 =?utf-8?B?dmZqdXRudzY4Y1JTYWlGTkI5VURGd1RGbS9vUitHYTJxQWRLYk5KV3JiaXNN?=
 =?utf-8?B?ajVWK2NBOGVMNDhBLzdTbEtmRWszcHJpcTRQejNoM216cnUwb005UzJ3VkFP?=
 =?utf-8?B?VmNENmRRbkQwcjJWOWVFTHRxelBMTGVnaHY3bjQ0Y2NWZkxFN2lTY1hJT1k1?=
 =?utf-8?B?MHZWY2VadjFma1BxMVl3bnA2MzZnTjdnbG5iRWNVQm1TZEJTN2MxWUFtZmZB?=
 =?utf-8?B?SlJuSE1xN2VMREN4Q0JOd2pKK0F6SUlyY00wQkZVOUFSSnJxK2NHUTVNM2Zr?=
 =?utf-8?B?NXhUclpETlZiaDJKWXI5VnlhTk1ya1RFdDUraUhkM3dTc0RpZlhKT1dFZU5t?=
 =?utf-8?B?Wm1yY0ZISHRxdjV0dHhwRnBKOVBmL0hvQUpLaHhRalpwR3JaS1pCYTdhcjVv?=
 =?utf-8?B?cHA0YU5xRm1rODdBUnkwcGdQVk5uMWFEd2NVdVI4Tks1YnJPY1hhdHNjWFcx?=
 =?utf-8?B?OUtHWkYwTENzQmd3Z0xTYmZkSjQyZVBObTc5REJ0a1NhejRtcURJclRySlZh?=
 =?utf-8?B?YTZnYXJ2YUg0ekk3Z2NPdUxKUXgzbWxVZitnR0hUUUxYRHFoMlRnMzdqNUM3?=
 =?utf-8?B?VklwK0JnREFjTHpnMGVMdUI4ZnZ6QjJpOVE5MmJYT1o3MjhQMDBRNFR5VUh6?=
 =?utf-8?B?amJTMU5DODlHbExFclYrVnpGZFFDS3EwNkd2MVozb0o5dVdyaU1QUDNWNU1F?=
 =?utf-8?B?UllSZ3NhaC9lZG1GandhdExSWWhuSWQyMTJFdmEvOEkyNGhtTGRkczNyREdW?=
 =?utf-8?Q?07RnOkGbu1jcfGaxK//JDnGRI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: addff600-7774-42a1-63e3-08dd7b1da00c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 06:28:52.7062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FB1n26epjxzzMrEdtUjZqjealnAUiFncb9k5buTQzGSwAulPu8YZKvBYoMLyxZKo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9030
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



On 4/7/25 19:05, Vincent Stehlé wrote:
> The set_dfu_alt_info() function calls the ALLOC_CACHE_ALIGN_BUFFER()
> macro to declare a `buf' variable pointer into an array allocated on the
> stack. It then calls the memset() function to clear the useable portion
> of the array using the idiomatic expression `sizeof(buf)'.
> 
> While this would indeed work fine for an array, in the present case we
> end up clearing only the size of a pointer.
> Fix this by specifying the explicit size `DFU_ALT_BUF_LEN' instead.
> 
> Fixes: 064c8978b44f ("arm64: versal: Enable capsule update (SD)")
> Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>   board/xilinx/versal/board.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
> index b4483d00ad1..3edccc979d8 100644
> --- a/board/xilinx/versal/board.c
> +++ b/board/xilinx/versal/board.c
> @@ -396,7 +396,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
>   	if (env_get("dfu_alt_info"))
>   		return;
>   
> -	memset(buf, 0, sizeof(buf));
> +	memset(buf, 0, DFU_ALT_BUF_LEN);
>   
>   	multiboot = env_get_hex("multiboot", multiboot);
>   

Applied.
M
