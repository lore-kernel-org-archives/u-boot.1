Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF084D1038B
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 08:09:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED3D78418C;
	Wed, 26 Nov 2025 09:08:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vHzdrzqH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD50684194; Wed, 26 Nov 2025 09:08:57 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE70184142
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 09:08:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLRXAmQfnh9YyMC2DRlciY7b9WHzlariT0uauOTOCjZbXc0Y/4K737OJEyKVxyELJMuYR2MBu/g7QeU6jSP78IMFW4PDTPGx+dXhgwDwLbqZBW8qwuu9AetWP3r1COJmO7nY9Ij6bPjr3bhZx3qzbXDXtP6bZwnepd4O1WR329yW+jb9MCS7ICrxpcigssCB6CKYObapvQ7xlYTg8rEtDZy2edy+R12BBeoK0/myBkCN7DdOu5AaHxX97A8yx8fz0dft3rCn3tYn+oqdD6HxEH9QASPH6q3OztYvm76qZDcDiNQbJXNM1F8n82N2gtNyzU8wcgks8Zz/ybbUnhyR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6onZ5GWrlVIrIi70waBw6HHEPqJh37ds4vBgiEXu+w=;
 b=rxRZ5c0DxnO18YFCZRRoJdIHhGInnFsI8R0izYgwRZ2YuBivOEhEago3UFfQv9rwxFwfRA62Tkluyd0qYt/r8CEPVYoeHbybd6abROs9NAldEU/C81fvVzNU32TtgTXcus34nxbqRt3bL6tfo5+7nA8F5eMCdE+ZGYYhz2xcrJZLPeXsRAwrmlPBIMpbXxawxItUJ4f2zq9e1yS7GM8QnIqzV4tRstCHmTCFUKWivSml5q8BDVcV+rBa9YqNDlSo1tSXCtRdWRAJnLGz4/ICnw6P6NJGMwal1hVKOvaTv6Da3MZJCLXuO3TvKjL3JN5QpGT50LEn8+wedFvQzmDcKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6onZ5GWrlVIrIi70waBw6HHEPqJh37ds4vBgiEXu+w=;
 b=vHzdrzqHljBw9H+/arJmUKxnrDFRVEIHR+nwMx6YF3XPplOfwmnjnsR1chVdMk9O0/fV2L7xNlmyxXHiCXoEay5ztB+TugcA6U0tdTTycqDLcQv4nuyrbCD4q5ur1CntpvsacfeLSE1Hg2JsllEQzvbhGlw1fZnDDY+grI1oUdw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN6PR12MB8490.namprd12.prod.outlook.com (2603:10b6:208:470::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 08:08:50 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 08:08:50 +0000
Message-ID: <287e32f7-b6ed-4b83-bc05-c0553b4f999e@amd.com>
Date: Wed, 26 Nov 2025 09:08:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: versal: Use __data macro for moving variable to data
 section
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Lukasz Majewski <lukma@denx.de>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>, Sean Anderson
 <seanga2@gmail.com>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <eac8d0ab60a018d6c59aa28c49691839a3eec174.1762511327.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <eac8d0ab60a018d6c59aa28c49691839a3eec174.1762511327.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0082.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::27) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN6PR12MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: af5f9870-1e8d-49be-f217-08de2cc3088a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y21pdVpxRGhPSk4vT0xQb2d4d0FzZURNdmpwQ01OTndmcnpzUzJzTnU5T1Z1?=
 =?utf-8?B?NExjenlxdFNiL0hpbFkrTjlOMExoUE12UitBbTVZYzBJbi8rTTE0Z3ZGL3VB?=
 =?utf-8?B?c015c0k2d2ZIZ3ltVFZrZ0V3NEVCZHhNaElpQW1UNEpIcEVLWHlwUDhWWXMz?=
 =?utf-8?B?N1lVK3NYRXoyd0pKNndaOEgvVXdkWFY4cUdlcGptcGsvdmQ4Qk54UDcwVnoz?=
 =?utf-8?B?Z0QzKy8rYXUzR2FVUEJwczcxMW44WkVCMUNjajJZZGlQdFlVMDZ3Tk1VSlpa?=
 =?utf-8?B?azREVWdXN2h6YVZJMzk3QmlPSFh4YmFmU1RFQmVTUm44S2ZKcUsxUGZRUU1r?=
 =?utf-8?B?ak5SNnJqMXlGVVJWUEFZMytPMHhCUmtKSDJLdmF1ZWN1UTNhYk42RjZYeUl4?=
 =?utf-8?B?L0dTTktWaFVhSGtkSm1NZitHVkExSGpYY1MxSVEwMFNXOS84T0N4czAwUWxm?=
 =?utf-8?B?NFFzdXltcnpPOURJYVdmeWErOUFLaWVZeEd5Z3VvcllqaXQ4MGlkN29VYUln?=
 =?utf-8?B?SlpiVFVZUVAwRXRiR2IvQVRZRitTN040ZXJDRXZFcHZzalVzU1lqMXJsZmxP?=
 =?utf-8?B?ZjVWYjR4YnRzNVNwTnpMaDQvUHN3UHhZdzFPZWFWU0xURGtYZ1NhckRUeFcv?=
 =?utf-8?B?dGNnV2N3MmhXbWp5Yi9la3BRUy9yNStkV3JydTZVb29UV21GdHVVY25hOUo1?=
 =?utf-8?B?YjlRSjY2bUwwTS9UbUt1NmRCd0VIVTZMMHQydXU1YmlmUkM2Q0VxbEl1Y3JT?=
 =?utf-8?B?eXlVa0t6WW14bTVYQVlGOG5aaXc0OHNITk96S0FMRGlPTjFsZXNGTUh4U3RT?=
 =?utf-8?B?ejNjU2VzbXJleW5iQVNodlpaNTNVd3cxWXRGblhWd29nay9BcjFRZ1VOY0dE?=
 =?utf-8?B?cUxraEttakcxU0c2Nm1VMGlEbWxKZk96eXExSmFLQy8xcndsNVJvejlBT2JT?=
 =?utf-8?B?ZmdJMkN1RVd2Zk53WmdZZHo5SWpSS0cyYXB0SEFXb09QUzRoVG1OUndabG5T?=
 =?utf-8?B?RFU0SnFPc0RKUjZzcWtHcGNaWDdFVHpNYkNHQkd6RThIZzB4MTcwU1d5ZUgz?=
 =?utf-8?B?ZnpLUVhpdlRiMXBvOEJwenk5V29OOXlZTExlb0Jaa3pQRzBFVnlWSi80Nnhz?=
 =?utf-8?B?aWNvQzd0K1FPZFFCMXdZckxvU0EwcFlXaW9Yc0VVQU5NcFBERnVHTmw3RzhK?=
 =?utf-8?B?bzc3c0kzRy9lUDREbFlLVlR6b3l1eWJMUklQS09MVFN0aS9mS2NrL0NEeU1i?=
 =?utf-8?B?YnVkSEVVTDFoWWNSb09UV0k0VS8xNmk0SUR0QUlNaFJGaHAyUHhlNnhoSHJJ?=
 =?utf-8?B?dU93eEVrTEJhWEVjNVAwRitLTFFpOGJmT2pSb0JYWFRVYjZBWTZkek9YMUJo?=
 =?utf-8?B?VytNZmhzaGtJd2ZBMFNhWUhpaDJ5dVB3WVJsVlNhKzBwMFFvT0tuNm1Vc3FJ?=
 =?utf-8?B?d09BU1ZzNURtZVpZc0xpMkttaHBlejlIdnc1cWZsYkxJV0ZVTjJ0TnVuQkF1?=
 =?utf-8?B?VUM3V1JueWhpclRrV3YvRWtySnNLN2pxSXpxY2ZlRHZIRzJQcFVuaWlaQVdl?=
 =?utf-8?B?MkRNVGFKWHd1Z0VON2dHeUlPQW04OVlyTkhhOTZNendtTVdWRHVXSzN2SXRX?=
 =?utf-8?B?dk12QWRJOUtQQkdGYlFSbzhRazNNcnZGU3NUdXNmdnJOM3duMXkvdHZlSXht?=
 =?utf-8?B?QkpMektrNTBWUWd0TldnVVo3MEFicjQzSFFmYTB3VkYyNHRuL1A4WmlGVjRT?=
 =?utf-8?B?dmZaaTZrbmRPeDVPMG9lV0xFS1pRNjhZQjlwWHlPY0pyN0hRVlhBYVJEQ2lF?=
 =?utf-8?B?OElsWjZhWCs2TkdTRjlVNjRKRHFwU1hLQVR4TjRUSEVkSnVSbU5SNFZUN2Vl?=
 =?utf-8?B?YWZKdjF3emhjRVBlK0M1RUFCb25xMm9vYTdlYUEvODJaZDd5Q0VYSUZSeU9z?=
 =?utf-8?Q?knZ86HxvCw9sCaroVG5OsXOtxLfTt0Gh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3dKWmRCaHIyV1MzZXJRRno0bFU2WTJGSlNBTXRhb2hIK1NiSjFvVktGSTAy?=
 =?utf-8?B?ZEJGNlhqMG9DS0QxVDlMQVFIbUZpZWl4YTB4aXpIZWhVZS90N3JHMTM1NCtW?=
 =?utf-8?B?aUNQL3puQWtDeFR2NUcxMHVTa0w3OSt5dXpMaUdRS3hGR2c5M2tvbktBbDk4?=
 =?utf-8?B?UHV6NWVxQXBqQmN5VnhDTkxuZkNucGphMHFNSlFNcVE0bHVacklOZ0hXZ3Yz?=
 =?utf-8?B?K3NEQjY0aHh4WHhkYnRwa004YlhwZk9PKyt3cklBemJCQ0VKeXh5MUV3QTQ0?=
 =?utf-8?B?bllwZXVSa3BkUFByakhnd2hCdjVUNXJNT1BQVGtVZHNPbDFSMmVBRjBUNmVn?=
 =?utf-8?B?Sjdad0lNT1d0UXViVFRLcjJtMUZWZEJ4WkhnOW1aTmFMcm9sNG1NaUxvS28y?=
 =?utf-8?B?Ym5sdThpRjJmeTVKbUJjOXdtRkNqYWxMallCbWtMT1NBSDFTRGlRbGd5Vmkw?=
 =?utf-8?B?ejN1b2gwZWFSLzBUNGhHNDdyck9VWmhnak5veWtxTUNTWlJPRm1CK0Rza0xX?=
 =?utf-8?B?VUNKV2daamoyQlNWcGR0ZmJwWjE3R1Z2ejJEMnROUk5BSWdxZHBueUg5cFBM?=
 =?utf-8?B?SEtLZVVFMnZWM0YyTlBlK1AwSG9SOUZPWFQ3WmdNZ3FZSWMzVUQ0cmdjQnAx?=
 =?utf-8?B?WmVncnZjVVRqUlBjbmxaWkN2OGhzSUVHUUpEQjExUTFGanpDZ3hvRkpoV1Fm?=
 =?utf-8?B?ZjNDQjBkUkZlNlZlREdlT2trOEdYQnJsdmhUOUFENlJlRlg5TzBRUHc2U1Va?=
 =?utf-8?B?VFp5Zzhma0FGT3U1ZTBob1hUcmJFbkYyM29KaTA3WnliSUdiRnRzZjZEZnJ4?=
 =?utf-8?B?WVp5dlVtSVNwV0dINlhIMFZWTlFpRGxEd1ppaGNzcTJOU3lDNDdvL0xxS0F3?=
 =?utf-8?B?S1BGNVhBNUJHWFRuZWs4MThHY0xXbTNMNGF1eHpTUGM5WE82WUI3ZWNrdHZL?=
 =?utf-8?B?dUF0V1U1QXlqWjlweDZ2YVNncnUvbFBEYThnck4vZENGYUh3ay9tektsUlU3?=
 =?utf-8?B?UWF0U3hsbjRHK25ETjhmUmF5ZCtVcVhiMDEwb0k3cnJRRVJNUFVMa0haRUE4?=
 =?utf-8?B?aWxnY0F2QWh1MFB0U3lzNThmdVp6azhsWE5WUzZRY1VhWWd5YWFid2YvUWxN?=
 =?utf-8?B?YVBPYmdWYkluSmViY2g4MHZBZk5SSStrVE5QbUJTQXFGNmdLYU1yZWlwK1VD?=
 =?utf-8?B?blVWZnd0QUcwS0xveGxEbCt6T281UXJ6cVB6ZlZRWVNTYkVMYzZPQ09PMm40?=
 =?utf-8?B?cGNlek1IOEtWMHdZeEprNnlXN0RmS2FhUk93TFN6TTZNZHFkRHhvdmFPZ25T?=
 =?utf-8?B?MHN0L0Z2bXJRVnNjaUpRNVJTNlQ4RmZqamZ4ZHhjYzRIS0ZFakRlRnpuVG5M?=
 =?utf-8?B?bmFxWG4xSmJ4bjE2aWpIRjZjK04zb2dTVDdCT3RqVktFSE9zVXVaMlplOVpn?=
 =?utf-8?B?dDNicXpEYlN0TU5xd2pzTVJ6cmdqYXFSZ0h3dUV0MU1hT3lPamZvMm82YXVh?=
 =?utf-8?B?L2xDOHZiSW85R00vL2ZyOWswZHB3YXBrMEdKRXNxVzN2eUo5SWkwSWJIc3Q0?=
 =?utf-8?B?ZzRSVGh4UWREZjNIM3YwblpudnhKdHRTTTNHRGJ3aVgzRS9RVFc4U0JFSXBO?=
 =?utf-8?B?dlZEa0hlNll3bVhHVlp1OXBvNlFUU3FmZCt1UWFkaDlGc21FbEtucGNMRkpu?=
 =?utf-8?B?eStLTEtBS0pCZXJuSGhTd3FnVXRrUHZSMmU2dFlLTlB0V0pVUndrS3pmRGJk?=
 =?utf-8?B?bzcvYkkvNFVYSDhsbmJRbVA4UGpwcHVJTHFGOU9BVDhsU0RhZXd0bEpVek5G?=
 =?utf-8?B?bzIwckdsVnFDZUFsdmZ6bk44Y2hNdTl4VXFJNW5QRm1FWkxOMmlSRzNZWEYy?=
 =?utf-8?B?ZXU5dEZROGVWR3h5bmFTRUNDZEdCU0Urd2FDZFFnNlNwdTNEOW0wdVhXcDl0?=
 =?utf-8?B?RE5JYlp6MlV2VzVQVjlOd0RMMWp6TG1tSTNBNHlwc2ZwRGVudWdnYXM1ZHEw?=
 =?utf-8?B?L1BRN0NEREpIV2NVMnZUMGJlRGl6a3JyTkNvTmg4S2pGRUZVR1djQTEzWjZZ?=
 =?utf-8?B?MTZCcjd1b2EyV3hlWTIySGlRRUgrOTBRRi9PVStPN09RcXp6MXE5M2hDQU9D?=
 =?utf-8?Q?G5HVdpAZios2Mk2Wvznh97OXT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5f9870-1e8d-49be-f217-08de2cc3088a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 08:08:50.7949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6afTuSz5XXlR7K2xRPs3RIK2NoJm7vIouB6ZOs49kj//t2d9mcaILAhEUkd2fqo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8490
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



On 11/7/25 11:28, Michal Simek wrote:
> The commit 1b267fe1824e ("firmware: xilinx: Prepare code for new SMC
> firmware format") introduce new __data macro that's why use it in clock
> driver too.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/clk/clk_versal.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
> index c62a747036d9..0c754943deda 100644
> --- a/drivers/clk/clk_versal.c
> +++ b/drivers/clk/clk_versal.c
> @@ -106,8 +106,8 @@ struct versal_clk_priv {
>   	struct versal_clock *clk;
>   };
>   
> -static ulong pl_alt_ref_clk __section(".data");
> -static ulong ref_clk __section(".data");
> +static ulong __data pl_alt_ref_clk;
> +static ulong __data ref_clk;
>   
>   struct versal_pm_query_data {
>   	u32 qid;
> @@ -116,8 +116,8 @@ struct versal_pm_query_data {
>   	u32 arg3;
>   };
>   
> -static struct versal_clock *clock __section(".data");
> -static unsigned int clock_max_idx __section(".data");
> +static struct versal_clock __data *clock;
> +static unsigned int __data clock_max_idx;
>   
>   #define PM_QUERY_DATA	35
>   

Applied.
M
