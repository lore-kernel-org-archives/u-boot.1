Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B20EB597E
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 09:05:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95A0B83E0E;
	Wed, 11 Feb 2026 10:05:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jgN71dh9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE1F783E0E; Wed, 11 Feb 2026 10:05:21 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 659A883E13
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 10:05:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JsKpBz1pjR2c5YhZvIJFFltHldr6QrRZMvrhB8Kyyr6tD/8H+71gINE6nzO4XrdOtkbWNHL5LZRlruF+RGCm/6NGQkcVXGYF5YGJhYicoRzv7IOV9zEeaXBHx95/2LnXQLIZ96d3uzwUVnZ3O7DeNayQGpLGg7/c4p9vlA3GXZCmbcB/C41J6HccLM5EEOqayYbRoyZW/CiZenwktSHvp8ZcZ54ylX/F0Y56V2aJcuZeQfjcBfBbQhwQgDF6PcIqjRFtktlxSMdjnSkA8S9uIm3ZoVE94d4gJmohPvdJqpj7Wdelc4TO03yIsfqgvFXP1I5liG2Jtikmyh7aG7gl+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3UNSZ7xiWo4COYpJ52nToMURh/eX9bge3Ky/Z4tyO4=;
 b=rUanmxcvG2qxb3NTqaoxoeP0Kmoma9BaOdv++louzTVdJ7IfSIMHJl5iCaZtSa9i6P9nZMUFFg6A+JXlZalLBgAOvV33T5s86QWYmzX0NZx0PSjN7UH5MQSo21gRSoq5quAF2eSRcCwpo8EtXik4+WNCx4aB3rdgtWJ03Xees0ihFNqyfnQ7i0SmNsFuH00cOmNCdRpsGr2NE4C5m9/YIW1fnAQabtNEj04WjwE8oBCaF6cODotRg5Ea6ySeIxghbdyZFmbEIhdobmjbxWzrWIx4G0dZix8nkqXmREyhZJw4xg5Z6qfQtzsDkNVzqru31RES2rcT+iKPmgxlpkuPAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3UNSZ7xiWo4COYpJ52nToMURh/eX9bge3Ky/Z4tyO4=;
 b=jgN71dh9y88b53MoUliHZbHw+28+PTybHqnkaagJiw1Oc5QIxvv+bW1QI3+t7ZcExRMbPoe0J6IB2wMabZ0mBF7N91AOMsn42I/AS4eklelkJJAZY7cNNnO3VTVSW+rV6kkWedrnqML8ES3rstUbur9uLykoWX6mAJWo8aN/yuk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Wed, 11 Feb
 2026 09:05:09 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9587.016; Wed, 11 Feb 2026
 09:05:08 +0000
Message-ID: <029fc084-4da3-4bcd-b994-52c6a1789e8c@amd.com>
Date: Wed, 11 Feb 2026 10:04:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: versal2: fix GICD/GICR base addresses for Versal
 Gen 2
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Maheedhar Bollapalli <maheedharsai.bollapalli@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <d0bc3fe1af8409fcfe505e55fb7042a33b845a4e.1770721325.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <d0bc3fe1af8409fcfe505e55fb7042a33b845a4e.1770721325.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0141.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::25) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: ac5a8ae2-52cb-42a1-171f-08de694ca7bf
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K082RTBpc1hFMlNZaElER2EveFBnRjl4aUdoUExZT0ZJOHZhNUxOanEwbTlH?=
 =?utf-8?B?bS9SZEtGSG1tTXFuc3JXaHNRM0FHNUdnMUlBQllFcm9iUkd4WkdQcG5LUXlw?=
 =?utf-8?B?Q2Q5WVNud3NMSkdNVTRlVW01MjNXZTJ1bW1wUnlhSUlVMk5aN1lMMmx6KzUy?=
 =?utf-8?B?aEZncnR6REZtRExvZ1o2SVNjUHU4aVhxcjE5OC9iV1lkM05NU0JHZjl0YkVo?=
 =?utf-8?B?MXZIQjFGNlVaU3dXYnRwSXNGdnhNR1VldmgvbGVidnJJRldXUlBGT3VlYmJm?=
 =?utf-8?B?dHdnendoZ1ZFdzQ5bEtBVlRST0J0Z3p1ejlFMkVET3I5VlEvUytmbUNrMk90?=
 =?utf-8?B?aUpPUFl6YnZSVlhhWXpMMVFtdkVjaDB5a0hkN3lBbmE2TjE5TGEwY2svL25C?=
 =?utf-8?B?T1RRa01uK2ZacVB5QVRMa0htTmdxd1FUOWdFVjZCTEs3dUpjSUZHNktlVEZH?=
 =?utf-8?B?WW9pK3JKeTh5SmUrOVpPZWYvd3Z1Nmhld3lpckRlbmtGRVFqcWJlY0wzZFN6?=
 =?utf-8?B?QnV2cjdJdTlNYVBjdkpwNTM3Nnp1eERaR1F4WUtwZGZucUtoSWlKREJUZ2lF?=
 =?utf-8?B?OTBWNHB1S3JVNyszS2M2cFF3UjJ5K1BCc1VkVTU3dk5veHRLRXQ2elEwUVcr?=
 =?utf-8?B?NmxWM2dab2hMQzMyenhiQjQrN1lwM29kYjJhY1d2QW93RVlhb1NaVUdaVGFx?=
 =?utf-8?B?U29DVXlFbE9YcTcrQ01VUStZbzV4UHhlMWVnWnI3Y0FDd1c5dVpBcjJ3K0hx?=
 =?utf-8?B?RUZpL0QrV2xDN3BwT3daK2RWb3U1UmJER2RkaStJYXRIazJQVXFMd0JlSVZi?=
 =?utf-8?B?akt5RDNGOS92UU1DZVR1VzF6cVdwVjhaeU56clB6M0pSSzZnV0s3bjJmQm5J?=
 =?utf-8?B?UTJMbDJGbm1ZMXBBY3hWRHhtMy9jVW9aMnBidzFpTEU3WGJIZy8xL3dOdEFE?=
 =?utf-8?B?ZkFmUENpTzNMZ3R2ZFBpT29TVytaU1BBZ1I5cnZDdWtSQ0U1VXVEcEVkRWor?=
 =?utf-8?B?dGhvajBWcUlpWW9FV0NaRlRjVW9PTUhkNHo0QUFxWjVPOHcxTzNpNHkva1lD?=
 =?utf-8?B?ajJmK0hnWGh1d0tkVlhqV3ZDVXNrMjZUOE1BdmErbFh3cmlEc3VIbjFONG4y?=
 =?utf-8?B?emFheVoveDhWQ2l1aVhWbFR2b2F1UncwMU9neVlOR1dhZlRzR0VROFR1SGpS?=
 =?utf-8?B?Y25uY2h3eW41dWpQcGRSQjliNDdROTB3T2QvZDBDSE1wWGNwVEgwNy94S1Jy?=
 =?utf-8?B?blpRbk5qSlJqSEFKclA2dXM3Rkl2QTNWRE85ZWVIdFcxaTZxT2ZqQitFcHdk?=
 =?utf-8?B?SUJRak1aaDJrakZFaUVYLzBDQmxOb0Z1ZThYekx0aXVNK0p5ejliTXhrUVF1?=
 =?utf-8?B?aFoyL1pyWnNYdjIwRnZNdUQ3bFFUNjlYdS9PY0haSk1xTlE0RzBsNDFsMHEr?=
 =?utf-8?B?d2xWUGgxSi9pK2FSajZ2dllOTXRtMEJFNFRYZkcyVlVJV1hNZVlNSTNsWlFW?=
 =?utf-8?B?amJKS3JwZGNYNjlibVR2NzZQNEM2Skpobm5kOWIwVHpsRGMyS3p5cVNKS2g2?=
 =?utf-8?B?TlJwY0FmL21Mb2ovOWRFSmZQSkRFcnZESWZXUFc3bDdoNEl5cnExYlMzcS9k?=
 =?utf-8?B?TWJMWWZ2cklyaWt0R2s4dmJjWTJPR2s5Q24rTVFFaW1XSFFDajhsWXAyajY4?=
 =?utf-8?B?SGY1WW9hYVpJRzJsZkFpNzduQXdJY1BBUCtKTThoN3RFemlNb0NEYW4wQWJu?=
 =?utf-8?B?d1BEZ0VCS0oyMGgzdkw0bGRqY2t4dnFZTFVYSVNuNEQydERxR0xqcUlFd3RG?=
 =?utf-8?B?OXdTNWt1bk56emxrR050a0YycGs2dGFyVm1Zcllrd29nK25FQWZ5Wk1yNERY?=
 =?utf-8?B?M1FQdGJ5NHR1RXNZK3Y3L0dkMG9uVVVub2dEOUZ3bWdpMzl4TmVNT094VXBv?=
 =?utf-8?B?aG54WWVENlZ6SUVzQXpZU2daMEhOQ3FsRWtnUlltZWYvZ1BaY2J4UFZXWEpz?=
 =?utf-8?B?WC9TSzN5RktKb0NFT2U2MzIvT1pBUHUxS3FOTExOeWZ2YUh0ZEo5TWtVWWNQ?=
 =?utf-8?B?TTFMa0hSTCtBMFNid0hXc2hrb2VRYndtdzlQWVBJUU5JYisycHkvWWZnWlZ4?=
 =?utf-8?Q?iyKI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3FnL0FOZHF2aElYODQwTi9YQXFzQUpST1J3REVOR2JCcUw1cGVQdHFpaG05?=
 =?utf-8?B?S0tUVGxpVXZ2K3hHYk1qcTZLek4yT3pjSWxDNXAwZDBvRUdVV3Z6b2c2VDdI?=
 =?utf-8?B?ZWpVSGtKRU5CQmtnNjRNcTNGc1NTWkE0eWg3RXhqR0J6b2hWUDMvbGhyVTdj?=
 =?utf-8?B?RmMyMXdmNDdzUFJuNXVwVDlyRDJsc2d4UkNka1E4L1c0bkxSOE1wN3NnT2Vi?=
 =?utf-8?B?RHl0WjN3eXBhTjNvenlmOUFXRDdBT2o2RWFvYlJYUk9mcWl6MmdkMXhGYTlv?=
 =?utf-8?B?eUE0d3gvKzdobUpxZ1lwaHJ3dm81cEZYTnk1MlgrNXh5SGxkQVNjb3NBUGFO?=
 =?utf-8?B?UUh6SElLVHM0aUVVRmVITXN2b1VKL3ZadXRyeDFOMUdaaDVmWmorR0FCR2p5?=
 =?utf-8?B?bGx1SHozWmxTaC9wL3VJTVl3cWhudTVwMHhFeWJYeklEZmZrQ3QvR0l5YXdR?=
 =?utf-8?B?dG9KVk5xMXlGUDM2SGZpYWNtaVBja0hUVzBCdzNFYXNGa3ZaVEZVanhCRita?=
 =?utf-8?B?dUtGcWRoVkJacWlFTUs0N0ZIU0szcTdnY0U5TVZjRDBPOUhqTC9JZlQ4ZFQ2?=
 =?utf-8?B?SDdzeE1Oc0c4SWtGUGtYS0xvN00zekd3emdKY2tpeFpZb2hhSmd0alFDdmpW?=
 =?utf-8?B?STNUbUJiRzFjN2JFeDFZTUpCNzNhOERvbjhXL1Q4b0ZreEJMblNZM0VZSHpI?=
 =?utf-8?B?NGtvK1hsNndLOGlyc29TUEM1TlNtN2VoMlplN3FNMFVrTzBlVlB6bkNuWHpC?=
 =?utf-8?B?ZE9DTkNNSE9TMUJJZEVqWDJFQVlHMHVUMUFFR2JpWVlpOFlMNnVHYU1kT2tZ?=
 =?utf-8?B?L1pUMzd2TDBnSnltSUE3Z0NWUlVFMGVDekovejlQOEdRdG1oRGNWejFvWEUw?=
 =?utf-8?B?UHJ6dDNNNEI4WWZmMzFyTjI4bmZrbXNrSy8vbDlLWUcwdHlYZ1Z6ajJkcUpN?=
 =?utf-8?B?bEVuVHo0Q254STRCU3cyTHhYRDhzbEZNbFcyb0tMcDM1K1BNQ2YxRGljdGJl?=
 =?utf-8?B?ZVppNWVqSFlaakV6TFNZcXo3MFZGQVBTQ3R6YURuWTFaNU1IY09MdVJEc2E4?=
 =?utf-8?B?WW9WQ0NGTExqNFlZUEU3OTZOdGV5OXN4NHhsMSs5aXpFNFRRZGJWYXUrNjVr?=
 =?utf-8?B?TEhIdFkyeXlMck5WSGt2TWJIemZRVnFIVjBCYmF5WDdxeWwrQ0toWGthcUlv?=
 =?utf-8?B?elAwWWdPa2pDYnhLMFNZUXd5VlRycnN5UkhqNGs0RUJwcHlESXJMWDhONUQv?=
 =?utf-8?B?RVdlc1Znb0greHhobzYvTE5tL2k3bWtmR0Nnei9rc2NkRXBqd3hYZTBSM2M1?=
 =?utf-8?B?RkM1eVdLT2h1di9uZmphK2cvc253ZkJhN0Ywbk94L0JLRGx2cGNQUW1KNVRN?=
 =?utf-8?B?d1JLdnhiN0tTUWZmRzBLelhFM2krNG1iRExjVHZ5RnU4Nmh2NEtrR3FhNENY?=
 =?utf-8?B?WVovT0w1ZGIyUnZ3bnl4K1RPVnZnL0hPODE3Mkd0WkFVazl4RXF6N3RXc2sy?=
 =?utf-8?B?ZlpNeXpiSmRaVS9BTXh3RzUraWRlM3J6enlsTzFrcWRkSnp5OHR5REpzUXY1?=
 =?utf-8?B?ZkVTNERCRVdrbWlYRnhNMkMvcTUzYzZqN0lKRkVLV0RINU5lYzBYVEtOa0Vx?=
 =?utf-8?B?OXJ3OUtqeERTVTlnc3ZjOW9MeWhrL0czVEdFWmpJWEF2cVoxQUtyVEc4NkMw?=
 =?utf-8?B?T3hsb2ZwSkNlaXlKR3lEWTFkWFloL3JDa29ubXYxWUx6RmdwWEtUcnpJNFcx?=
 =?utf-8?B?K1VyTTUvZDdFSHpkMlBSWUhZSTFLRnhiTFAxb1F0V2ExOFZzVG50QkFpQWFt?=
 =?utf-8?B?cFFRUVdubDlEeU9SUk9tNUluQTl3Zmw1Q2JZY25QQzAxa1JzUHp6Y3Z2R0h0?=
 =?utf-8?B?MWFMTnkzOTFYMFk3ZXQ0aFJGZFphOHZjSnVJZmUvL2d4OW9qa3RBaFpFTk9S?=
 =?utf-8?B?ZnhZdzI3SE9qQTRlVzdRczltTVVtMTZNUkpWZXM2a1oxOUtvdkNlTm9lNkxs?=
 =?utf-8?B?NmdjTFNlQTdCY2dLaVV1bXB0TkkwTGZQeXRoVUtENEdKRzh2cGluMlkxd3BU?=
 =?utf-8?B?ZG5YT1BMbUNIQzBBeUh6aFNYSHNXbmorQitQN0Z6Q1M5T3JpS1Jrb2h1U21D?=
 =?utf-8?B?cWg2THEzdFlhd0JMMWFhZVlHdVBpM1dzdGFGZFpsT0xKcnd6VnJGRUlRVkM4?=
 =?utf-8?B?ZnBXVURBZWI0c3ZDbkgwejFnZ1ZYZXdLUWd0WVFlNDhBUkQ2TUloTjgxRG0w?=
 =?utf-8?B?dlF3clZGWDVxWGZMS3J1M2xRdisxQ05qeWZBOEdLZkJWVDhtQ2kwN2tVV0R0?=
 =?utf-8?B?b2NtMmJ4c0dHTS93dzdlNSs4M1RoS3pIbFZnc2Zsd3BpT0RQbmdtUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5a8ae2-52cb-42a1-171f-08de694ca7bf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 09:05:08.8862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqm+X+nRHizXh+ZwkzrKYKeeNPInQ733aN4nnuTFTp7RYx0ZQOLoKOP3cVGzKuv8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699
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



On 2/10/26 12:02, Michal Simek wrote:
> From: Maheedhar Bollapalli <maheedharsai.bollapalli@amd.com>
> 
> Versal2 was using wrong GIC base mappings, causing GICR_TYPER reads to
> not match EL1 MPIDR. This led U-Boot to walk beyond the per-CPU GICR
> frames, access out-of-range addresses, and hit a synchronous exception
> during early gic init percpu while booting up on alternate core
> i.e., non cpu0.
> 
> Update Versal Gen 2 headers to the correct Versal Gen 2 bases.
> 
> Signed-off-by: Maheedhar Bollapalli <maheedharsai.bollapalli@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   include/configs/amd_versal2.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/configs/amd_versal2.h b/include/configs/amd_versal2.h
> index 05ddd4eabe16..404af2cd4c65 100644
> --- a/include/configs/amd_versal2.h
> +++ b/include/configs/amd_versal2.h
> @@ -16,8 +16,8 @@
>   /* #define CONFIG_ARMV8_SWITCH_TO_EL1 */
>   
>   /* Generic Interrupt Controller Definitions */
> -#define GICD_BASE	0xF9000000
> -#define GICR_BASE	0xF9060000
> +#define GICD_BASE	0xe2000000
> +#define GICR_BASE	0xe2060000
>   
>   /* Serial setup */
>   #define CFG_SYS_BAUDRATE_TABLE \

Nothing controversial about this that's why applied.
M
