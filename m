Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA08DC369A2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 06:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C93980EFB;
	Mon, 14 Apr 2025 08:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JF9o9NqG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85DED81F4D; Mon, 14 Apr 2025 08:29:11 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91B5982054
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 08:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxDyrq9xhgvQg32Vb2yp8q7UDw/GK9n4EMMhb3v2QVomt3RwlxrDPN/bSghtwZ4cEmBA+YWqLNLtuFAZRZGD1bj9G+XwwFz+JXdp9i7K9r+9S/U4I2z2vsFQ+PPalZWSWXKU3IdVi7wfZrn+T9xuvHuXYAyYxuETRloPhY39eCk4FRNRag1EuO0IlmFRBv3zLYa/1pwVk77vJidKyQ298TQtQUJaheWcO8soy9MhaCNp90kguw4HBTcDwvn7w7IUmfhJ58odkeD4rPyVellxTF8cvCrKsysLuNZf1sP+ZLQL1Jvk9lH2Vgq+jxSQaknx3RZI+3nGtK2F/aXgVFlQlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ythfC8YRfEhXvnN/BGb6ZR3WzJK5+rmJx7HxhY2PKQQ=;
 b=d3c7SxFXTyp3AKZ1BybcHpApOmGFa8lu1TGhNNbYjlFWcRhnpnD7Pz7pUBMy4yP5bK35xOHOyUkjOYvIQKPDFsJiUpaouqpKIoIhke3Fxq2ef57fPRpXJdgfyNqMPyzlrXlVfpKhBSsA1xE4R8Obq2Tug5baW9VIUFA8fPWAQKotI3Ulsul83toM9rlbx9AnkLwexJLanqKv95wQhgW3Uy/lb6baZKu8CHx9VL1s0fu2chsNsahSvVFBleddIFdvyHkymS+MKCKiAZyP4zDR6qeGs98Bgts4wYb0G9/e/eLwAwFR0jOP1FQDr5CiBC3Uhf9LPMjXJ6YA9TNTs5R2oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ythfC8YRfEhXvnN/BGb6ZR3WzJK5+rmJx7HxhY2PKQQ=;
 b=JF9o9NqGxspuVbUHadhng61cmsEmPrboB0FYtSXv+kzzRbT06SlreKeAWr9ysOjMmFuPA6yEJtqt20Q6sVmIys2Qiw4XqCRCIAMAWlC9p8JOsMCn7bmmhYX0J97IrCpDkU3kDWe0qaXL6/AnCBgczet/HuqGHRX3cRnWSHzqnBY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BN5PR12MB9461.namprd12.prod.outlook.com (2603:10b6:408:2a8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 06:29:05 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 06:29:05 +0000
Message-ID: <6572f897-595a-4cfd-b697-8f277b7762df@amd.com>
Date: Mon, 14 Apr 2025 08:29:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: zynqmp: fix dfu alt buffer clearing
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de
Cc: Jassi Brar <jaswinder.singh@linaro.org>, Marek Vasut <marex@denx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>
References: <20250407170529.893307-1-vincent.stehle@arm.com>
 <20250407170529.893307-6-vincent.stehle@arm.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250407170529.893307-6-vincent.stehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::16) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BN5PR12MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: ae37393b-af0b-4dbf-e0fe-08dd7b1da790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2FpUkU1RGw4NW1iRmNDK1hsT2NjT2lwYnFkeEQ2eDBBQ1A0QU1TVG43V1Fu?=
 =?utf-8?B?ZzdYWW1mbkcxVDZZcEhMU0xRZHd5SG1tK0gvYU91emRSVFNkdmpvYU5BUEc4?=
 =?utf-8?B?SmVsSisrUTRZQmhkZ3I1Nk5LMGU2Tk9hWHJxRk04aFlsTWVHWWVkM0FXdit1?=
 =?utf-8?B?WHkrbXpPbXVuVHlKcUoxRCs0OFYvRW5wdndSOFE1RlBXTk1wdWdzQWh3SXlH?=
 =?utf-8?B?L2U5ZUo4bFZXMDBKUjJ0dG94MlRDUnN5cDRHUDRoeHAweElpbHRTbmc0OGlO?=
 =?utf-8?B?TDk2Sy83N3ppR1RtVm9tZlVaSjh5cGtOVHJzOWdwS1VzOFd1OHFmTmQxbStN?=
 =?utf-8?B?TU9zVDZjMFUvbWVNU0JHVncxTmpJMkNTZnV1Z2hGaFo5TDBkaW16YmxSNmJF?=
 =?utf-8?B?MHhDZXQ2VnNQY0hrN01OMHNYMWhXVlVxTVFlTkpIOTNhbU1laWZORm55endu?=
 =?utf-8?B?cXY2NVlPeEdCZllqSzI1RFUzMytrbEZWMjlGN3JtQ016cU84WDh1allYTUJX?=
 =?utf-8?B?T0RZVWZTaHNnMHZqUWZ6RmY1di9KMEpnMEphdHIwYlZiZ29idjhEenh0U2h6?=
 =?utf-8?B?MjhVQVBnRXRocUtGekxsSkU3NGh2NzJpcWovTkY4MC91eWNWTkVidDM0NEFq?=
 =?utf-8?B?bFZXNmY3bmhpYUxiZEU0NitXeGR0L1JlN3ZDUitWbmVjaTBpTmZ3MTFBRy95?=
 =?utf-8?B?MnU2MFcyejZ5RGxIUTNLclNCVVpDcU1DK3ZOVXp0bUQ3MHh5MENLc0gzS0Nw?=
 =?utf-8?B?VjUrYmZjbTdKanFtdzFBbkM2bDdUNmhWbm9ndjM5Yi8vT0pOdHBIUkFlSWNo?=
 =?utf-8?B?NmhlK1RuOTJoV25CdVB6SkJ1bWF6Qi9ZaitIbndQeE1weWExYjgwM3d5clZz?=
 =?utf-8?B?cnIyZVlOTWhBQ2V4NWxnQ29lTFhoOGQxODRqMGkrWFVBQ1BPbjBFaW1tV2RH?=
 =?utf-8?B?SWRsWjFwWStOR1JRakFFb0FjbFNLTDVCV2xiOU5tQkJiMlUxQXRmL3JON1Rr?=
 =?utf-8?B?d3E3MkpIcXBhaTJ5TDRyQk1NMDFOUVcvOEZiZ1lRU0hTR2dIMnhwbzZnbVZp?=
 =?utf-8?B?dW50WTJYRFp4eGgvVzhrY2tyUUZjWVNnUEF1VHlPTFRDaUhWVWNCeTFCcUY3?=
 =?utf-8?B?Ri9oLzV2VlRZTVJHTHpxWFJKOUd6UE9JZWFDVURRbTNvS25IUkxvSDhTOHlB?=
 =?utf-8?B?QVhidnVYbVJ5SUFZTVJ0RUJCME1iRHVjVUZPZkNIcFVSc1VtdUNhVjJ5dkZ6?=
 =?utf-8?B?L0FZVDI2cEgxK2pwYlo2ZUdFRitsUzRHb3dMcWJsZ0owLzlOekNzd3NpUzBH?=
 =?utf-8?B?dDAxV1RDK0gvcjFiUGZXc0JaS05xTisyYk9GTW5yOEZHV3VoSjZXaEFHWDFo?=
 =?utf-8?B?UEIvWmYwUENkL2NXV2V4RytXRjlEVmVNVHQ0SHZQSVBqNlF1blZwZ3gySzhH?=
 =?utf-8?B?OTliTDRTbml6SVZIbldjNFNab1paMFpmZ3BpbEk0blpMMTFkbzdOT2pGVlN0?=
 =?utf-8?B?bC9aV0diaXdOWVZUMkdzbjFsbWNkclZ3dkhTU29zYStrZkZWYmgzR1VZcFNB?=
 =?utf-8?B?eWpaa0VvVXAxRnNQenhsVXc1WWdUMGE5Y3gzMUVZMldKUTlOampHOWpGWERz?=
 =?utf-8?B?T2crSHBtOTJmZlBYeCtLS1VVQXRNd0FxQmRHNEV2TVJlY1dxdERTc0JaU2ZC?=
 =?utf-8?B?ZVNzejc5cHl1NGJMRXZrQjVveE9UQ2k5cGZuVE5EbHArTVdFRHlPd0kyL2hl?=
 =?utf-8?B?bDRlaU10VDc4bHBXcXlsMmtmUVpwaTVwVVE2MjVVa0lZRFRDS3hCWFFQK2pX?=
 =?utf-8?B?RUhFTWFjbmE5QWtBdXVUamIwb0p6MEdpcmVTUUhjRTVsckVZYjdneERTU2U5?=
 =?utf-8?B?VTgrc3F0L2FiUGs2V3pmVFU0c2lSYXQwTVFvanVDa2FtTVBUMjUraDVPYndL?=
 =?utf-8?Q?oUGUY3nP1Hw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmxHR2xqRkVvbm5yNlFEeXd2aUkwV001T0VTbEVib2R3cStIUFliZTVxR0Zn?=
 =?utf-8?B?czF4THZJSjNDVHU2NFVzTlVqV3ZxdDNXbXFtZ3FJNStnbTNBTHpwTHcrak9i?=
 =?utf-8?B?L04rWjBkNG9zZCsvZVdUajhCemp3WE1tT3NiOUQ4Vk96TTNsUUJkb1Bqa3Vy?=
 =?utf-8?B?UkxTeWdRcE9JN0RCWWg2OFhObE1uZU5lWS95bENkenpha1hDVzdUNE4vemJ2?=
 =?utf-8?B?TkhNOURuNlFLbGw5elNic1RvdExpd04rOXFaYmdmaWlZV0JPcVBvY1p6MzlZ?=
 =?utf-8?B?NndscmVnK3hJUUhVLzdTSXdkUDBva2JTRWpQWjVvbkFaaWk4dnE4OTNEejEv?=
 =?utf-8?B?Ky9pVUpWSUpNYTYydWsyUkkyQldyNW1FUkJrZGFzNTNiTnVMcGlsT1owQUgw?=
 =?utf-8?B?TjByM0lRZlRhTklkL0Vib0FWYTA0a1dVWU1HT1pJSTYwZHpidjJnRW1rT1ZL?=
 =?utf-8?B?SEQ2VHg0QzU3SHZxMEg0LzNQY1kwMEE0Tmg0YUdPVDIxVlZGT0VxZEVpWStj?=
 =?utf-8?B?WW9RYzZhRi9obFBkTDZlNVF1NzBDTS9jaWlVVGl2eVFjdUhkcGdVend1OEhD?=
 =?utf-8?B?YmVuUEs4UjR5eFJrUFRBNUxQcEM0VVQ4ejZqTy80TG5EU0ZjT0RaWEdnU1E2?=
 =?utf-8?B?ek95S2ZqaU1JWk1xZkk1NktMMGpLR1ViczRnbkhQTElES0ZhdUc3Tk5YN3dw?=
 =?utf-8?B?U0p4UU9NUEwrenpwSDZuNVdLWCtHbU1LMUVWMnE1NG1QbWJXWThRMUI2blk0?=
 =?utf-8?B?ZkxzSHM1UjdnbnJBSmQ1OCtnSkY4ejJVL1B5eWpVeHFSYXg0dktBRHg3aTlq?=
 =?utf-8?B?a2JsYzVlODJCOGxqZ1lNUStXWkYvdEtVUVQ5QkkxT3RJUGRralRldzZZNzFO?=
 =?utf-8?B?WHFtSTBjMVB5LzRoVjlteC9OSER1K0trQzZzcldsMEthUi9pSEUyeCtjN29Z?=
 =?utf-8?B?RFZsSDQ4TkkvWTBPTjhqQmo3dDhsc1E4Vlh4WWJGTzVDWmVEbk9wMml4MHRZ?=
 =?utf-8?B?Q1VhaWhrTEpFOEJmQ0ZDRzBHTzVVRk9ubUJXcHkvKy9rWmthTHAyTnJxdjNr?=
 =?utf-8?B?T255MVAwWEpRaVNMWTY4UU1sVUp6SmZnQ3NSUCtaRTdrUldZdGYrejIxUWRI?=
 =?utf-8?B?VHRSR1lUNXo3NTU1QzdsWS9Cd3ZrcWZmVTlKaVVaVWlkSWNRQitaK21MM2RH?=
 =?utf-8?B?RkRyNFRrVHRBV0dONzRnbkJhbWtyL2lCUVVRQW5RMEpINUtzL1VTNGh0Um40?=
 =?utf-8?B?NGFsSlZaTHU2eXlYSk1HdXc2VjkvWm5KaGlNL05wZ05MTGZTVExkSHBUNWVD?=
 =?utf-8?B?Y29pTTN2cWh2aVRFTGtPcFcxM2RwTEFWdVY1SUE0dUVWR1ZMTVhEQ0dtVDdF?=
 =?utf-8?B?SFkrWjBYSW1XanZNN0phQWhnL1o1eERmZDZFRFVmVUNNWUZnT1Z0ZVRQOG1l?=
 =?utf-8?B?N1BYOWFRMWlOdDdSd1k4S3VNOVNrYkVFZkMxeUZXMHNUeGhHZlpvSFhEelU1?=
 =?utf-8?B?bzVWdjArUlo1K0p4VGRRZFM2NmR1a1dvQUgzWnliK0RPcWxnc0FRMXl4aHpt?=
 =?utf-8?B?d0hsLy96aUlXSmRYVVB1N1p2V1dyZFlON3ZuRjJ4OEwxT3M3R3hzZnJzZCtT?=
 =?utf-8?B?WUE2UVA5YldBWktGL0ZBWVIwZFNLbjczenVxRHZNQmF4TUNzUHVtSGQwNmQz?=
 =?utf-8?B?OElKek9Wdm93RU1zb3RZb1E4M0dvRmx2UGJQOTlqYTNHSkEyNWZQSjFZb1Jw?=
 =?utf-8?B?bFNvWEhGSkt2dnpSNlRHSHNidEdTekl6ZE5OUnhrdDJVVlJTSnBEdGs2b0c0?=
 =?utf-8?B?YXBualh6MUpmR1I1RGlLYnRMb0NueGwzZithaTRXRGYxRWRRY2NRZEFTR1dt?=
 =?utf-8?B?TC9yb3F3VDN1K2dlb3FyR3h0NElKY1BMNUVjR3lMaEE5dXMyOWRteDN5MG02?=
 =?utf-8?B?SStQbndKVWFtbTdhUE0yWUtKZ2gwc0xDbjVHMEJFcG5QYmZoamxqbFd0YlpF?=
 =?utf-8?B?WVU0YkdpQVUrRzc5aEpyY2NsM2lFTkR5NEhKM3NvWHBIMUc2UndhOFdsbHk2?=
 =?utf-8?B?c3U3WkxJVlJoaXBJclhHZlI3aHlmMGkyOEo3SzJLWHdqaGkwKzVRWEVOZGFH?=
 =?utf-8?Q?0PuUnlRq/PLufWC0k/aZbJo51?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae37393b-af0b-4dbf-e0fe-08dd7b1da790
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 06:29:05.3049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOF72QhJyWgQ+v7idyWi0PzpV+e/mPzLQMLEqPZZV+37ch1f3OrfNM+8blhgoMx5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9461
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
> Fixes: b86f43de0be0 ("xilinx: zynqmp: Add support for runtime dfu_alt_info setup")
> Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>   board/xilinx/zynqmp/zynqmp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index 820fb252a3f..687dcd3ac9d 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -669,7 +669,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
>   	if (env_get("dfu_alt_info"))
>   		return;
>   
> -	memset(buf, 0, sizeof(buf));
> +	memset(buf, 0, DFU_ALT_BUF_LEN);
>   
>   	multiboot = multi_boot();
>   	if (multiboot < 0)

Applied.
M
