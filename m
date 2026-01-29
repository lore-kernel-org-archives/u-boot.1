Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75A3D46C01
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 01:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F43E83C14;
	Thu, 29 Jan 2026 02:07:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="F8zTMyfk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EE9083DEA; Thu, 29 Jan 2026 02:07:53 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 941ED83BC4
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 02:07:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPZjycKZnJdw+oG+v5e8Tne8pAoD6a6jv/YfSiieVQQIpe1aaN8QmS2+1pcSa+vLgNrUvE0Bt+VOEtYIuul0hXV4XuWr8IjhvIizby8+1NOyE2iocOy/Th+ewTK8JApvag7sKNYmgWvieiSHgqUHjgXFOStW0xhmVYT3IubIg/tg5F+iqtS4v/u34TTtELl8MoyUyHZXbOeY1YH7u3CSYJUplvQgGTH415ISGoZGETKaQyYsOUFXQMO/Klu+GXGzGMLn/YHyGo7skqTApOZEpk26BO3FJFrmmgZtj5A3GZTxG4jWbbG2FyOGNXruvD1MDnaolVXTfUDKu17dXWfL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KInPdQj4KafIzDNNPYocxw1kYfM43obPXVHfFEq3nyk=;
 b=Xcuu6DnTFdIAxbKUmRJq7urZDA98FBFjHlOnpjLxKDlz+IWH+glOHBxdripx+rPFlt2jq6Yv7N84ual0LDpa5Y4O51uAy7UV+EVWn2tqntL8aY1z1zBqJK9zgLT7Cy3Ob5swiN6bMX3QUievskzsNhL6M5F8WR5136GUuESByWf0/P25PuKQRzEEtWsCNhA7zxzPAPzpsfzAe1BNT3x5nVnPRk3dvWSg0YV5TWVOBzkKxk4VICFZp8rlVy1mDKulGU8ZuS6c6OHpkaoyFCv4zKFtF5l/fukKK7gqarRvdPRAQ3KrWRN/0yS+aTWZcwOvtjwaqqSoJnoe/y5NmLXQcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KInPdQj4KafIzDNNPYocxw1kYfM43obPXVHfFEq3nyk=;
 b=F8zTMyfk1DZW7AtgdoPowI4Xv6+TZICh9yndX8zWgkWVtY3ZWwkkReO9sGAa7YxHY9vFdfr4uYre//3xOIlVy7EqpIIjylYccJofmoz49Z1Breb9B1E0B1xhmldS5cGfQLvJZOf+lR+8R+dpy3bXUrtQ7KXcF9rmi7hJ3Gb5meAGiZKNyonIodPrq8CFm7rplxy0HvTN1yOut6uMGT2qLDkMq3afEfKFiHK+e2gS8rUwZQHOmWtqd1Vu0X1bEXI5eFNHSwxqX+xQ5tjeuzjGoG7UkApiqxz9Asw+Bf5VpAyDqlfhX1pQMOA8l1v6VwBJgpKEkbnxvNaiV/eXvJq3rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DS7PR03MB5558.namprd03.prod.outlook.com (2603:10b6:5:2c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 01:07:48 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 01:07:47 +0000
Message-ID: <4eb837e9-0736-4964-a121-d7556ecc2912@altera.com>
Date: Thu, 29 Jan 2026 09:07:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] Add CoreCourse socfpga Board - AC550
To: Brian Sune <briansune@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>
References: <20260128141816.329533-1-briansune@gmail.com>
 <20260128141816.329533-3-briansune@gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20260128141816.329533-3-briansune@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|DS7PR03MB5558:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d30d5e-b234-47dd-368f-08de5ed2d0e9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzJxdDhwQWpsb2xRZE51SjFwWVdlY0taT1lQQ2NkVytnWXBNNkRHN2FXUlpi?=
 =?utf-8?B?R1hxa0VBMDNGYnBabVVsNlZsRjJJd0hBcXlYdk52RkdRSVhYdmthWlZHd09m?=
 =?utf-8?B?TTJTaVp3SjVIVGpSKzZwMDZzME5Zblh2VDhxWXUyaDhSa2piaHcvbThSd1JU?=
 =?utf-8?B?c2ptQkg2VjZZRk5qMnlsa3JXZDhxaU5vYVY0MlNPN0svWWIwMGQxSGVIOG41?=
 =?utf-8?B?ZlNxWGIzMDBjMEZoaENpSFgwc3kyV3NDalBVVW1qUkpveHdrZmZNcUxxUE1o?=
 =?utf-8?B?M0hRZ2o0V0I4NW9DTC9sR1lSdkZsdUJqM0JJZ2pmRFVjcS9nK0dyNVc5Z0Jn?=
 =?utf-8?B?MVdIWUEzNEZPSlgxYzMxczFiaDBDQUltcWgwMWpaOVYyUjFjK2xScW5ZaGY1?=
 =?utf-8?B?ZUhNMFdHTUZwbk0rUWpiNDhQN1BhaWVOdWNGblVmcm9wamk0SDlaajlsTTJp?=
 =?utf-8?B?T3hTUnAwZXdBTnJwYzB4aXZoOGpjRVJkbVUwL200ZlNnelF5cFRjN2hGN3hy?=
 =?utf-8?B?cVQzZ1dtdTdONlp4eGp5QWZ2aDBpemNKOWtGWEFjR3V0MTdaTHQvUXkzTUFM?=
 =?utf-8?B?bC9hRjNES0d0T01PMzBtMmRSMGxkR3ZyN3NsclpKRW9yRjhDYjRPeHpTcVFU?=
 =?utf-8?B?MmJsRWVKSjRJdHZCbHJ5bXV4Ry90TDdpODJKcTdpM0xIUXl4T0s5UkVYUEpt?=
 =?utf-8?B?a3dTVnl6cXBvQ2hod0Z6YXh6TWhXTnl2RHFGV3ZhM1pjYkpXOGpHYzAxVXdR?=
 =?utf-8?B?QUhIUlFxTWVOKzhWdmhGcDNpVjZ0cVEyeERmRWpWQkN1UDRLR01BYWZUWTk3?=
 =?utf-8?B?WmNsZWxMMWs1UnY2dUpXTzZkaUJYTTM0YTJBQ08vK0lEQUFsRE9ES3h0dndx?=
 =?utf-8?B?OUNzVG9nL0wrOEtpK1JSekcxaDFZUFFiQ3Q0Q1cvWndRWVRpeGdFRUIrRVhs?=
 =?utf-8?B?b3JtLzVtZ0pPOEVkSXUzT3dmVXpXNEgvR1hYQmNTNGhiQXNzUFpoR2NaVm5J?=
 =?utf-8?B?c25raWt2eU1uQjBPZEV1MmxYbmFGdE9qbG9iVGgycnlFcGlxTzR4NzFhaVU4?=
 =?utf-8?B?YzEwbjJjNC9xdUpxaC9hblM1MVpZc0VkT1MreDVvRzhlcmpQMWtaMnc1ZWlB?=
 =?utf-8?B?bzVCeDZVS0U0VG9DdlJRajM1b3Z2Nloxd1pkVXEvdzREbVk2ZUxIMDI3b3NW?=
 =?utf-8?B?dEE2OGhmcG14aUl3SUxyNjlXY1VyeVd2cDE1VTR4OHlLWlNHWlBkK3l1SWdE?=
 =?utf-8?B?VVBuVnRseEdSRExRZlZTdUd2Z2Z6azFZSGpRNmV1ZStldGdNbG11WThRNGYw?=
 =?utf-8?B?cExNcmxjcVhBY2JHVTNtTkliWXZsT2xISDhrdHQ4cjFSTmxFdDExcmhrQmEx?=
 =?utf-8?B?MlFGeVYxdU1vOTZCM09aSy8rMk8xTllBdkRla29xWm1BUFJUcUVRbmNSNjR0?=
 =?utf-8?B?MXlyU2VnSmVvNnJnZ2VYcmxGc0kwZkVxTVBhN3IwNjd0b0tQWUVST1c5bnFu?=
 =?utf-8?B?dzU0UDhvYVNTeS9hMk9vWS9sZUh4dnNGUGJhZjA4LzhiaVJycUUxZk5RbENW?=
 =?utf-8?B?SFMyZzd4YUVMYTZjYldMckU5K2p3bmhYTTRTWFVqYVZXVU9iM1g1QzVsSlFH?=
 =?utf-8?B?VTZmL2oxR1RnbzdLNE1aR0Vxb3FDWjBOK3UvUVF4R1E4bFBmTS9wTThDYlNE?=
 =?utf-8?B?eTB0bFpZZW13b1RXWDNCSklyRTNJOTVmcG95MTNlWCt4T1pMOThrQ29FR2Jm?=
 =?utf-8?B?ZytKVGlrc25KeXFZZEM0TVBoM0s2eGIxN0RXayt1TEhnS3VOemU2OGU3UVVl?=
 =?utf-8?B?N2Y5MjFJK2gzWm1tbVRZSkRJaWFFWWk5ZjBiRGpVVVVpcVdBYlpQaDV3OEkr?=
 =?utf-8?B?MkUvUWJ6TWNjQ3V3dlNwL29ZK1o2U0FZZEZ2SmZRMjdpNmV0cFh4V0NKV011?=
 =?utf-8?B?c3cxbDQ5em93MzU1NytKTVVNaU03dkhHejVQZzVBays3MktpbitRQUhzSFJw?=
 =?utf-8?B?c1RNMTZvL2phczVMbExQMHBZT3ZZbEJhYUgwY3E1WjF4WlJTWi9DZFVzNzlE?=
 =?utf-8?Q?89S6PE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWdZZXJMWGZnWW5GeWFBb3hSMEM5S21MdllTOFBqZmlTMHJHOFJkOGRLd0xI?=
 =?utf-8?B?UlIwYU5jSno2VU1zUzFVSUt0L2p3L3FkdXZNMnF5dEpOMitzTC84b3YwcWdT?=
 =?utf-8?B?NVh3bG9lR2NkdFZJcUdxSEg0dWhBcjFFWHIxRStWOVExRS9RUFU3RmtXRStp?=
 =?utf-8?B?MUcwc0UvUTBwcmFrN3BKN3VhRFpVZlBsbHZGV2MvbHNUNnd2SnlWZi8yby9o?=
 =?utf-8?B?VmVOa0svOXRwbEdDQU5mNVJtWkpYNCttNkd1NnJDVkdFbG5va2pYb3NpTWhN?=
 =?utf-8?B?VWN5SnM0Q1hmWk41L1ErMUhRbUl2WXZEMFhiUVlYKzBOWUlPR09xTGJNeUNt?=
 =?utf-8?B?czdNaTRXbkIwZmlsYy9JMmM5K1ZSOG1HMVh0OXY2UnNhbVZIUmQrSG9hVVhk?=
 =?utf-8?B?TUttWll1ck54SG55ZVdldzFQaFdDakQ3SnZ2MWFxNWhxOWFkM0NQSit2K3F4?=
 =?utf-8?B?YTNRaUovRno4NFhwNWlhYjlMdjlyckNSamFBcWNUZWxva3FqVm9jOEpVWGhs?=
 =?utf-8?B?MGUrTEdkOWwrT3RpZThMb3pJNmVZTVlwcVJzTy84UE52K0lLNDdab1NKS20x?=
 =?utf-8?B?WWhqaUpKNHdodDZISEdOdXVlYTNJM01aSlU2YmRrTC9nY3ZRelBhOXBkVjlJ?=
 =?utf-8?B?aWp2Vjg2SGpJdERQMzhyNndlTGFyOG5mVXFXbzFDQWs1dFJPR1NyM3RQSDJM?=
 =?utf-8?B?ZkJvcFVYQ01BQXYrMytHZ1JDWnNEWFNqVnU1YWxsQmlBa1B3UEJiVWpTeDJH?=
 =?utf-8?B?ZGpldjdxeldwTkhCQW5LbUE4TWdvVFRyZDljYUtlTGZHL0h3U2NUSFkxckFH?=
 =?utf-8?B?bkF1TjVLZllrc3RPQmlwVi9jd1ZqdHNvMll2RTJwMUEva1NadVR2V0V2bVR6?=
 =?utf-8?B?L08vVHgxS1dUZGdFeHAyelhjR3g2aENtZ0ZrR1dQVUlWUTFvcU9BdHJRM2tG?=
 =?utf-8?B?b3VSUWNkamJyWHlhem40R3ZuZ3ZXdVB4QytnamVKUWdYNmpCWFVHaEdjN2JL?=
 =?utf-8?B?OW9DMDBzV2ZRY3ZNaTA3R2R2V0JkeVEvb3pNUXozYllxUXZuQ0ZELzdDMUhp?=
 =?utf-8?B?dzRMOFlSSVg0VDRkcWRkM2FMRHhENVBYZ25QMUNodmVyY1l5L2xIaFZLcGRz?=
 =?utf-8?B?ZUZuTDF5YUlHNTZjOTFrdVkrSXFrQzNSN2pQZFdZbkkvcGtBSjVhOXpEaVVX?=
 =?utf-8?B?amwrZ0o3TDJreFpXRVdPMlhSRE9YNm9BOGN3NkhWd0xLWjVZOHhZcUtDZGM3?=
 =?utf-8?B?cUo0T2V4SitTV0o2QmV3NnlBSHVYN2FuWmRCZy9ROStnazFObWozS0Q2T3F0?=
 =?utf-8?B?UTg2cGllOS9HRHZFTVFYY1FFalJsY0VmVlV6ekc5aXhUMWRJbDNncTVDVkZE?=
 =?utf-8?B?MTNzeCtyVzE0NDFReUM4SEpOdWs0QjVIWTBmaEd0di9QZzl5ai91bHh2U1FL?=
 =?utf-8?B?d2dzVmRxcG8zelRkTE1VN3lZM1RGR3Z5b3pnYVFKSXA5MU9rVTdyczZUNTlM?=
 =?utf-8?B?eWMrNEtUUTBjRElGZ3pjS0xxQURtanRFaEVuQy96OTcvb3Zic2dkbjZvZUJ3?=
 =?utf-8?B?MjBJaXVvRWVPWEtLQksydkhiKzNLNkZqVlVlVVFzRU4xWnVCNy9uLzJlM1dv?=
 =?utf-8?B?aC9wVG42d1NIYXc2Ly8reDVack9kWmZEODBubUc4a05pRU03Ymt5TFltTUZy?=
 =?utf-8?B?YjVoL1NEYW9KN3NSN3lvRGJUVkdPbi9hY0dzeDA0Vk5UL1U4akVPa254bFc5?=
 =?utf-8?B?UnNCVFhrNXJmRVcwTXRXRHZnUFVKM1IzaFZMZDRjS3daNnFXZFJsclgwOXN6?=
 =?utf-8?B?b0pTSjlCSDdEczB6bExoOEJWWEVQdUEvaTVRdlJzM2s2NDRpSUZTMEE2Rk1W?=
 =?utf-8?B?YnJWVTFFbjFGMzFnSkM3bC9KbUpMK256bUpjTUhUcDVYRi9ocFlZRTBrRDYx?=
 =?utf-8?B?RGl4VWlDR3ZrZ2dkMHJScDQ5UDN3UGVLSmdTL2prUGErUXRud2tneFlXNXd2?=
 =?utf-8?B?UEduSWEzT2RrdFlHTlozN0hEdHJpVmtuS1hoQk11czhQSDZtQ2Jta1VsZEhM?=
 =?utf-8?B?Q3JRM3JHSEU1Ulh5L01LRFRMZ0dNcStaQkROVDdreGF2OGl1UllWakZyNUV6?=
 =?utf-8?B?cXJ1RmtNOFN3WFlmTFNRSDdYdVByQm4vcHVjczQ3a0JkTHNweS9rWnJmc255?=
 =?utf-8?B?amk5V2V4S056RW55SCtrOHczUU5lbUFMWmRHbWpBbHc3c0Z4U3pjWklPY2o3?=
 =?utf-8?B?KzIvck14T2xjN24yeUJOeFlpOTVXUHk1dlRXbXE5bXlobStqSmVQK1llUFpZ?=
 =?utf-8?B?QjhNS1p0ZENjYWhpenFuSko4ZHFQVHIrZmVJT2tPeE5hUWVsbXE1b2Nvakd1?=
 =?utf-8?Q?xWbmuOnWj6ZZz1l0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d30d5e-b234-47dd-368f-08de5ed2d0e9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 01:07:47.7837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jc38I/8vQpYQg9XyUaZMeIYs3nOD8DUrpapy7YKwxCN3xuEYI60N/ordyG9Z5Wj4gt+4FIlmZOrlDfcF5G6ZAHjOjGh7NP7cEclFqN3azyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5558
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


On 28/1/2026 10:18 pm, Brian Sune wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> CoreCourse Altera GEN5 Cyclone V board
> do support different size and formfactor.
> Now introducing AC550 C5 to mainstream u-boot
> This is a more complex and unified board with
> feature. More info on [1]
>
> [1] https://corecourse.cn/forum.php?mod=viewthread&tid=29788&extra=page%3D1
>
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>   arch/arm/dts/Makefile                         |   1 +
>   .../dts/socfpga_cyclone5_ac550soc-u-boot.dtsi |  44 ++
>   arch/arm/dts/socfpga_cyclone5_ac550soc.dts    | 118 ++++
>   arch/arm/mach-socfpga/Kconfig                 |   7 +
>   board/corecourse/ac550soc/MAINTAINERS         |   6 +
>   board/corecourse/ac550soc/qts/iocsr_config.h  | 664 ++++++++++++++++++
>   board/corecourse/ac550soc/qts/pinmux_config.h | 222 ++++++
>   board/corecourse/ac550soc/qts/pll_config.h    |  86 +++
>   board/corecourse/ac550soc/qts/sdram_config.h  | 349 +++++++++
>   configs/socfpga_ac550soc_defconfig            |  85 +++
>   include/configs/socfpga_ac550soc.h            |  13 +
>   11 files changed, 1595 insertions(+)
>   create mode 100644 arch/arm/dts/socfpga_cyclone5_ac550soc-u-boot.dtsi
>   create mode 100644 arch/arm/dts/socfpga_cyclone5_ac550soc.dts
>   create mode 100644 board/corecourse/ac550soc/MAINTAINERS
>   create mode 100644 board/corecourse/ac550soc/qts/iocsr_config.h
>   create mode 100644 board/corecourse/ac550soc/qts/pinmux_config.h
>   create mode 100644 board/corecourse/ac550soc/qts/pll_config.h
>   create mode 100644 board/corecourse/ac550soc/qts/sdram_config.h
>   create mode 100644 configs/socfpga_ac550soc_defconfig
>   create mode 100644 include/configs/socfpga_ac550soc.h

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

