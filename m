Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A870AC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 13:48:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A819807B1;
	Wed,  5 Mar 2025 14:48:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yjm3UlW4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C504E8083E; Wed,  5 Mar 2025 14:48:00 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8044D800C1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 14:47:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=treding@nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPyQCUUaNd6RlMtCL9/HoFrpKMDSz6CYyx2rd6AYokVEscrNZwFUYozgYAREeH4yZAdVnqDL2F0pCmNJjMpN8WnFuuZzWQsairYjCsmCtEYDF0I+0uxKJOobd03zB4VZU18yIe+61LsL4l7O2+x5z5lJApqMGHwsADWLDqc1Jkj0iKXPHAsQZpM/uGyBnYpZjGdpxrb1QEdY+eg2BDw4Mfaj0XiI/f0atyex4B6DieyXav1oYdtXaxAuQ4NSwW5T/m6f66h+B1oG3nXl6sGQ9LsJ5Z+MxUnMxue881z2wIHINAtXC+tShbIdW64Pu3FhnRsR6OYX4u15vEpJRzuKAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30XRiqRwL+J4Eb8tE60b0/MOWJH2Cq8M5pZKijaV4gI=;
 b=MSI0FPLldPnzivLD721tfgu1oCDX0Lz/TJe+3HGOZQ0tc8BBkdET+gr/jzaGguktPiED1FvLYntMXD6PgvMYap9I9FUwxFSsas8tn+L0H90pgjZ2aHO2CVo+hMI/+4gIxPa2xvWhlTrrXbHGPVkzaNPFh0Zz3JQr/xrir6+O50jVqAuijIF+vfxQN9lTcy9rJfCCFgn5RjTQ4D5ol2kJbXKv+lKuUDHbDjC5NQ8jZuGJCjhD+nZNItKrK2FC9QFzKbmdRa7MgZbpuvfsbIQUr3H/6QOnUaSKCkzPgdHGDcf5tK4mVeE3kPtEFUM6c3E7+T+Rzq2VLumUgYKihyTCbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30XRiqRwL+J4Eb8tE60b0/MOWJH2Cq8M5pZKijaV4gI=;
 b=Yjm3UlW4qZOfhlrcyXqSBbyVHapFvwwImbBkIPN3NN0N5uDvsxPQdR2kKBvgBM3wixq3fK4b2w4f7vfOm4jPhrdgimwovsLl4iQdgDyKAt1VfG87xv37ZFzMlqaLaaD2u0Hzqruhtq5El/d5qPIWP9HaGqmT2iiui8I9uxu8uRMBIiGQ4zrm3Dd8/4v+YVZqSjP5WmOAnAi9VwdpOb8im7Lqi8ToeZdnXdIJRz3MvIxrtsh2oR7WIufGCF6SMRQAhcfFL14GjXgshwhpAQAZ7rGuot5xQ1kU1FHSKAlI120IJ7nEMA9YMcTwxERZIeQH1caVSv7AF/oY3oioubnDGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) by
 DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.23; Wed, 5 Mar 2025 13:47:53 +0000
Received: from DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c]) by DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c%6]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 13:47:53 +0000
Date: Wed, 5 Mar 2025 14:47:48 +0100
From: Thierry Reding <treding@nvidia.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Jonas =?utf-8?B?U2Nod8O2YmVs?= <jonasschwoebel@yahoo.de>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/2] ARM: tegra: clock: fix PLLD/PLLD2 related clock
 calculations
Message-ID: <kfyuo4l2w4menkfrb2sbvvp2ptumyed7bvz64vrnpm7lx6dpqe@hxo2633n2poq>
X-NVConfidentiality: public
References: <20250305111213.163428-1-clamor95@gmail.com>
 <20250305111213.163428-2-clamor95@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dakhgaezrmue5mzd"
Content-Disposition: inline
In-Reply-To: <20250305111213.163428-2-clamor95@gmail.com>
X-ClientProxiedBy: FR2P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::18) To DS0PR12MB8317.namprd12.prod.outlook.com
 (2603:10b6:8:f4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8317:EE_|DM6PR12MB4188:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ee58be-bba7-4844-5e88-08dd5bec53d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWlobjVPOEQ4V25jaldvWVh0SndtbWF3ZWkrc2VVZTlBbGJFMXZJeVNnNHdT?=
 =?utf-8?B?bzRyb3VZcWs1TDZDdjJabWdzRTcwK25HT2dZK1h6NW03NWNWNnJOTlRKeGt4?=
 =?utf-8?B?VHdHamtFVTl0a2VuZytQT2VJU0piVGRZdXQ5eGZsV0JaVkdBTmpoU3hOMXBN?=
 =?utf-8?B?VkFiR2tIcHg2eEhDK1RjUVlORVArRGlVZzRzeE1xRlhUNmFITU1hSnAySEI0?=
 =?utf-8?B?RHdHREJHTXhmVndRSUpVVnNSKzZXLzlOemdXU2R6UUE2VG8vVGJuUTBkYnEy?=
 =?utf-8?B?NC85S2FPL2kyUkFkR3o1SWtQWVZZcnJZempFMG4vV296dklCdXp5SHQvWXlX?=
 =?utf-8?B?L3JXcnl2cU84ZURRUWhuZFJ2eUhOKytJMXRBT1A1RCttckMyOU91UlkrSmFj?=
 =?utf-8?B?R1lFYVhXU1RBYTJCRVNzSmx1SllkdE55WStDNHRrdGVlbVpGc1F1a2VuQWRM?=
 =?utf-8?B?VXJTVDZicElLTG55RkZmRVFqb0MzeEJWWFdobmFOSjVncW80VmVZa01rY1o5?=
 =?utf-8?B?UzNtR2pnZzdtS216cFhUVTBybHhnSHJWSVp5MnlEL2N2YlF3dFQ3ZStMVENI?=
 =?utf-8?B?bHUyNktrREV3NFZNRWpSOVVPU2hJM09XMTF1Y1dlNTNqUzZZeVJ1RDhRQkpH?=
 =?utf-8?B?ZUpINXZPaUpzN0ZpQmZ0REI1dmVrMVBHQUNyU1BUaTJtTEdTTjlxRm9TMFVI?=
 =?utf-8?B?N1NuVW1kanR4cFUxODhsUkdCZHhoSXJnaEVHMFRrTHpSWDJ0OHNvWFJRbG5j?=
 =?utf-8?B?dm1IM0xJWE9UNDZXVWxwUWhMK0pKN2tCNEVvWEwyVmJQY1JUTDFCZXlnQkNN?=
 =?utf-8?B?em01WFpFR2gyQ0RFQWttSFUrK1E3TjZwdVpqWDhid2x2am5NR1U2QVh2Ykkz?=
 =?utf-8?B?ZVY5NndxLzJiaHcrWU1renJrRys1VlZKY1BtQVdKa0tOTHRCZ1dFWVpIQXpB?=
 =?utf-8?B?TDB4aUxtaWlubjlSd3o1NWVKcU94MHR6U2w5a20wNHdPYlo3ZmI4ZHNSQXhT?=
 =?utf-8?B?ZDcrS1BQU3RqNVArY0NNbUZRNVNpN3F5VGd0blFCdFN2STlsK1JCT2lyc0ht?=
 =?utf-8?B?QmtMNVVqdmluTDkzMVNHTk00czRCTW44emZDaUh5cGRXbGVKU0JNa1B6clVo?=
 =?utf-8?B?d1VLSWtLSEVoTE9Bb2xZSEdldFBNNmwzdGpvWXNZQlQ3Y3djTW5SNC9zWHlx?=
 =?utf-8?B?dHpnaGVja080ODEwTXB6SXkva2VPdzA2UE5lV2F4dzhocjY4OXZNZzlvWHc2?=
 =?utf-8?B?K2ExbmxqZ2piVzFkcDZaL0Rsa0pMVm90UlN0Y1ZhTlN2OHlwN01OSWhhSU03?=
 =?utf-8?B?Nkh6ZUdZcks4bGVTeFg3ZWE4YldSUUF2QkdsRWlxcDAwOXBPQ1BmUTdqa0l5?=
 =?utf-8?B?eHVCR0JBOFZaWlc1bnJ3SzRUK3oxTzI1aW5GYTdRSXI5bmNESE9OdEwwNFZN?=
 =?utf-8?B?a3FRcVd4OVZqMWZxdTVNd3Y2TUVCSmR6Nm04Q29wY055WDF3L1NTREtzUE8y?=
 =?utf-8?B?L05uSXg2djhmUXpGczdkZTFTaEVDb20ra3ZLUTdWM2QzYWllaER2dVdXK3Fx?=
 =?utf-8?B?elcxQ1NzL2NZbUxtUmcvVVJmQXljS2lDU3VLanZpdVZETTJDNnl5VkZLUEM2?=
 =?utf-8?B?dVhKY05qNFZjeWlHd29ueUlIcEF0Y283b3ppQ1hFQldZSy9ONVVOSmVVTG80?=
 =?utf-8?B?NFpCSU43Zkk3ZDlETUl0MFFPaEgwUmsxd2V2TEQ1N3ZTdjMvaG5XenhMMUZ0?=
 =?utf-8?B?Y2ZmVWZmRXdOT1dXc1hQYWw0cWhvREVKWFl2NnBxZmdRdXNWdVRCcWk1TGVI?=
 =?utf-8?B?TldNSGwybDYrYzBxQVhTdXAvTE5tc2lXenh1ZGNldFl4TVVRaWJSNUprTUtS?=
 =?utf-8?Q?LSd6qbWTRTglw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzJKSGdGQVROUUowaThOeHlaRWlSbktjZEJFVTRNL1VEM1hETStsalJUM3Qw?=
 =?utf-8?B?ME9IMmhtRU1kcnQyaU9SK2tMb3pTTU1oM29vMEZxcWhlOWgxb0dDdWpwbUlW?=
 =?utf-8?B?REx1NXJwWHQ0L3dRVzBiRTQvNzhvTWtFdTZIeTNiTG1uMS9rcHBHY3U3dFh1?=
 =?utf-8?B?cHR6SUdnRHBYQXZ3cUhzMjdmekpqQStmeEd5U0taaFdPYUY1YjR4WUVCVk1F?=
 =?utf-8?B?V25jY0NhNmd6NlJRYjF1aEJOanpDam5OdFpWdzVmVG0vN3hYS1hNOTd0cU9t?=
 =?utf-8?B?eFZkVjJ6T1lXMUlsVGcvNWJEUHd2bUtEZEppN2pXWmR5c3RlMlRKUzZ1VVYw?=
 =?utf-8?B?ZmhNWFZrTk1yY0Z6a0s1bk1zczlnSXlqWkRNYW0vT3VsZ0tTcnFweUNJN0g1?=
 =?utf-8?B?ckZWajdBY3JnUE1DUlBpRzZQLzZsOGZXSUxwZXB0TjdJR3Q5bk5LWk1YWHFr?=
 =?utf-8?B?TmNUN0VsK0hTQWV4UE1GRFJtY1oxRjZaMi9SeEVVclRXSmlhVHFQeGJoYklT?=
 =?utf-8?B?WHRSVGhUelFzdGJwUzVVWkxvTlVqK2E2RCs4RmNxWDVkWWpDRS9jWDdFSUpY?=
 =?utf-8?B?WGNTMm80VlV4SUJuUWJsTDgrOXUxTXFIWE0vS0hRNjlqZCtKUy9aMVYrRkpO?=
 =?utf-8?B?MlZkOTRJYmdrM1pJOXd6TEFzbk9qT0lQcTF3L0dIZVByOTlyc1d6d3J1YS9U?=
 =?utf-8?B?MG1pZFp3VjhuMlpLbUdvU2hIRFZZT2lQWXphaS92cUgwN2ZIYlhBa2Y5Ti9q?=
 =?utf-8?B?aFdsV3dEN3BvdGhHckxmYmhXSmJucS94ZkF1bzE4Ui9CaFp6eHJ0RUM0ZTJl?=
 =?utf-8?B?UUx1UzNLaXdkQzNrTE96QkhUUFh3aVNuM2YxRmV2cmJad2xLQWtaSXNueDJP?=
 =?utf-8?B?MHFaR3lFdmwveTNoeHBzRnlUbXp1SFdtbUx3cjFnWmhqbCthRnUva0lLeENY?=
 =?utf-8?B?MEZ6YW1rbEM1SEM4RnptcUZVbExHT3FPS1ZQU0c5NWd1azNMZFhlY3dyWFF3?=
 =?utf-8?B?anJBWmZqZ081NkhuZVNhSUFCT1p1SC9HTXI3ZTFwNVoxZE1wWVdIMEhCTkV4?=
 =?utf-8?B?OUtZdVJzVENXV2Rwa0d3ekhBRkY3WHR5VlNyVkhKT3BUV3dBOHdRY2hMWUlO?=
 =?utf-8?B?T1VFNGxabm1ycGxFMEhJQko5OE4wRFlaL0FVRXJWSnNVclB3UDQrcGpFL2dQ?=
 =?utf-8?B?bFh6UVFBYWw2bmUrdkpQZGIzOVY2Z3EyVmR2cUp0S25tek8veFBHaU9sMklt?=
 =?utf-8?B?ZG1IOWFaczBiQm1CQk9IRkE1cnZDQ2lIK1Fib3N2a2dFNDdoSjZMNjBibUJZ?=
 =?utf-8?B?Qkg4S29Bc1BSTFNUaVdXQm5HejRQT2FrL1NqT2RRTm0wWXVoaXhkdUhJSytX?=
 =?utf-8?B?YkEvYjUwSS93b3gwcGh3MWxtcUNINWlhMmp3WWJ3elc1QUtMbkhiT2xDZGMr?=
 =?utf-8?B?Y1JJVWZpTmtHRDdVbFBzWStYM1hQVEcrN3VVcmcvMXI4bVhKd2RkOXFYZnBS?=
 =?utf-8?B?N21jZFdYZ3Y0UnovVWRUa3lyZWk1MVRvU3huZG9PMVJrVldTTTIwbitiT1ow?=
 =?utf-8?B?OGhNakVPd2NzaC9BU25EVzcvUU5FTEQ0WGdvODNZWlc3NWR5TTlqcUxoU3lN?=
 =?utf-8?B?eFpVY3pWUmRvMjBnbVBxMDZKakJ3YnpBUSt0UUFSUWUxdlVFUHIyamVzdTd6?=
 =?utf-8?B?M09sUmlMd2V6M2Joc1k0TVNyUnFnVkRiZnordnR3c0pPK20wR21MYkpQUFFX?=
 =?utf-8?B?NkJrZ3JGOUhLbXpqcVFYdjljSWRyYlNmU2kxcjZBVmNtNngxdW9IR1VxaEpw?=
 =?utf-8?B?ZS9DRUlocWVoU1JaRVBTaTljTmpPdEg5WEVBd0RIYUNOY3hteDlUWVV0c1d0?=
 =?utf-8?B?OHZMd2NWT1NYd0txanRKYm53azAwZjR4Kzk2WGVNa0lyNkxudkNLcDZsMEtx?=
 =?utf-8?B?eXFkSmNIWGRDZXM2S1JyZE9GVExsaW5tZ2l5dnFncjk0NUhVWEVlMVh0UVl6?=
 =?utf-8?B?VUY0dkh1K0RCNWc2WGxLUWV1UTVRUTlkYVFqalJyeWpzM1I4cktmVFdpREVq?=
 =?utf-8?B?NnEwSVpSSzU5bDVxWWxsWEdjTUg1dStGNVFEUEppMytSdHQvSGE2WXI2ZlZF?=
 =?utf-8?B?QW1xdVpnQVN5SDc2NUJZSzdUVUJzUTJTNVdrZW15cGNDMzBUTWg3ODJEY1Nn?=
 =?utf-8?Q?yOk6F6rDIvonrbvp9Nv4H4d8pOjXm9V4w15XcGYZup2i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ee58be-bba7-4844-5e88-08dd5bec53d7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:47:53.5244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxzNs1OrfPa/WCwzXI+/OsPCVMOpzWV5Lik9T52W67qvAW0ycM5gfD8ioc8dH58zfwGzw18NO8MfHaYyJIM3sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188
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

--dakhgaezrmue5mzd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/2] ARM: tegra: clock: fix PLLD/PLLD2 related clock
 calculations
MIME-Version: 1.0

On Wed, Mar 05, 2025 at 01:12:12PM +0200, Svyatoslav Ryhel wrote:
> From: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
>=20
> While PLLD/D2 is the nominal parent clock, all derived clocks are generat=
ed
> from its single output, plld_out0, which is PLLD/D2 divided by two. Direct
> use of PLLD/D2 is absent in peripheral clock configurations. Therefore,
> clock derivation formulas must take in account this division.
>=20
> Signed-off-by: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/arm/mach-tegra/clock.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)

In Linux we ended up exposing the _out0 branches of the display clocks.
Wouldn't that be a better way to describe this?

Thierry

--dakhgaezrmue5mzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmfIVgQACgkQ3SOs138+
s6EbuhAAtgSMrsiAs+Qu/d9tYHWAEV2Zz+0S0QtZ7Q4i1mhAZMZll6xmifHUwfJe
QXNkQG5LWxClXD9UDA+bI34bAevr5tFG6tlnYgLAk4KXLbIh5RjtGynsY1E1KIh9
6Sf4UjqL2ybbrT+jYQb1RmILtdUd6lnuuZPN/0jdK9w5rT/A2POhaZ6N+biQ2jM7
/Pk+KVTQuTN61BmumbgBlKt74mY2S89ZLwktkEYG33JoZbUVLrdnPJS8vpLZWYvo
gN0ZZi2DgqGWmExt+oOr/itwGa33327yNYp7sHPNuL//Pf20kxuLqdpEExxJeN00
E8+s+uxVT0n2Ot8IOGw0Cx7cXLQC6MQdxVRuK1WOl7CuWQEMRf25KpRVxvWg2FsD
4RkNakxKiOpu+myR/i5CadjgpIiZB1Jl2By34YtjGWlkYlZLBngmoxiYA5mRYyGr
KYtGHHe2eFhN7/L0XK6q+eqVymcrKTluUNv3/vPkHJ+RONqEtpJQ2AH8fUUBWwbM
BJqjSSqxKbXrV6L8VbAny3RRlQP04yjuSDv6TljPUyc4TEW/OPmwKmQ9nc4R2Aha
cAzrTGlvrx/tUDdjQyLU9vtPnCBk1HZ78WJDNnzCWkCLMQvif1ycRnmg7RgB6d+3
wjw2WrOemofeAQFbscigmYztviLtlhiY3J0pIUtMrVPWsuVJZNA=
=7b4A
-----END PGP SIGNATURE-----

--dakhgaezrmue5mzd--
