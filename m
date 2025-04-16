Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1009DC369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 11:50:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AB9982DB4;
	Wed, 16 Apr 2025 13:50:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gXIJA8oY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C7C082E38; Wed, 16 Apr 2025 13:50:24 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22D1481F45
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 13:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBYtnueDyIP5NkIItKmMJ7dvYzoMtdw/ZaXBdY27tzpLhzo1ZwhK7/h+tx9Kvya72+3a+kYNdarXOb3hsbj/t7kjvAOMbrWOEO3yMDQXh9W/9kd6wkItgFeFib4nZGcz8xLmwp+R6eH7g4Qu2CQueXQqqK5oGxEz1GU52BCWeUpxtte916muZ9eGxfTkLAUgbGfMb/DOIuI1GLAdhRlDI1NOyx20B8/tdbz+6QbUprfLxx8y5OUgcCUyZjvu5Yu4ToXvvAtNsRh1fpyNkLFZjvHizKIVsCv2IDJUNzklfvEsAHPg4hDaeks6P1r9g/8/0B3Bv5xWrFSPhjUTWBTNGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bcdEQEsLPOJupZPhDfXihvMafoq8bfEBXr24Nn43Bw=;
 b=kDFnvlLEBHfhedihvg5Npng3xYnHuf1iUdvH53+z35FKqV/ag2YhkN+sarwkruDjEDyB74fwBVausiexAwIeLfMog54m5sO32Rg7h0BQ9eIL76ZNXMUGImMSoa/zfs1ULsVnho5m+5k22EPcZKJ6aVWDEG4+4EXoErIZEKKG7CaWGi/DwvR/X2rlHaNMFKAv/aO97wP9cIs1qWMR6BFm9LKb6/g8QcLyUdukcZ8GDm8YMomiIJdPDE+yvCYHq9QZs19lTK4i3dQdE1skfe5MzRoSAfTnkEgLPEO92o0c3dGhAn2KStjG1ZbXUfwXeb7n1VpxYqk1AkBazEK3Sa7Msw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bcdEQEsLPOJupZPhDfXihvMafoq8bfEBXr24Nn43Bw=;
 b=gXIJA8oYu2wCB71GrEYY5G00hg5t64W3wupAW4EDyXpi5VVbgNu9zq9C4vWuj3ftX7VGGhxuRa1A+6538jdbn+12QFzbbYpi3Q8Y+YdegElfKCrBH/+h59CTYp9OZayVrRr6JTyIJ58k0ch3bEs7im8iGON/GFm51x/i/hx2UxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB6011.namprd12.prod.outlook.com (2603:10b6:8:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 11:50:16 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 11:50:16 +0000
Message-ID: <e8365d4d-ff1e-4990-928b-c77c53587e0a@amd.com>
Date: Wed, 16 Apr 2025 13:50:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd: versal2: Add support for saving env based on bootmode
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, joe.hershberger@ni.com,
 marek.vasut+renesas@mailbox.org, cniedermaier@dh-electronics.com,
 xypron.glpk@gmx.de, git@amd.com
References: <20250411154612.107136-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250411154612.107136-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: 1599d213-c81a-4471-b9d5-08dd7cdcda8a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3djcmpDZWJrNEVJR2lCUnAwbzVKWm5sRlZuNmlIaVpONVpnTFJKVmJ5RzBG?=
 =?utf-8?B?V2VwWWg1NnlXYnBzZUJoRVhVWjNQbUtlSjZHRytRcUFIbFVzNllvM3UwWHVF?=
 =?utf-8?B?dXYxNmVRREo3bys5VkpZRUh1eHpxekQ3eGF5MEE3OGJBU0c2WTdjNklPeGlO?=
 =?utf-8?B?N3FzODF0L3dXU3IrVkZ0WlJzQVg3MUNSWnRtazlJUG9tQkFGK0NsS2tKc3Ur?=
 =?utf-8?B?eTBPblJyaFRMdVhOS1VKMUZzdTdObmovQ1V5MjkwRUpwelBYY1lMdXhsbWI0?=
 =?utf-8?B?TzZvKy9HdHN4V3FPUTc0V0h6T3M1MkhpNVI0M1JabkJYZkZYVGtjUjNNVm81?=
 =?utf-8?B?WC9RY3NtbWRxYXJzeTEzRkd1aE1NL2czOUlMT08yRFZhK1JZdzBOaEEzWEZD?=
 =?utf-8?B?NWhRaVo2TmpNdFZOMG4zVnJweEhIZWJodnVwaFRFaVFBaDE3Sk5USTlPWG1B?=
 =?utf-8?B?Z2hSaFNHMmtnUkxvNmYwYUxkQU5DYnBYbE4wYWNNSnAwWWJjK1prZWlOM3ZO?=
 =?utf-8?B?MG95ck1kTWh6TUJxd2NqQmpNY2dFR2tHVTRLZE9hWFVxeTAzc3lXcEFLYThp?=
 =?utf-8?B?NVhEaUF5T2FabldXbXNkNDBBNFhkV1plbG9rVGRtSU42eGlXb015Yk1qdDE4?=
 =?utf-8?B?WmlyRDRubCtjSUQvS0JMT3h5UGUxcnlHTDRjYkhzd3Y5LzRBd25QbDFNOUVz?=
 =?utf-8?B?MlpZSmYwMENiU2ViYzdOdmlycFB3UUh3YW5uNFhGVW92Qjk4Q3FNSEFzK1lo?=
 =?utf-8?B?dWkxcUpxYVdsK1JMaVFlazhhMzJaSVppY0gwODZPb3hyOUttV0FBYUJmSGFa?=
 =?utf-8?B?QjhkUFRHaHFpak5jM1ZBRE16ZTg1S3JKWDZJak5ZRFJacnA2WDRVa0hoQmpz?=
 =?utf-8?B?dFdIcFRPYWtmaGE4SU42MUJsekZyNVl3UUs4akVFaGZWZlJvRTNnOEIzZUlW?=
 =?utf-8?B?dk1mbmpkaGZHdXNwRE1WQkVSRmNjd1VIWDVveklPZG9IU2Q3SktUbGQySnVZ?=
 =?utf-8?B?aGN6dUdTRSs1OWV4R2t0T3preU55eksrVWRLYzNSNCs2ZnlhR1pmMzFGUmpp?=
 =?utf-8?B?U0oxcUpDWkZ5cmtxMThVeGFTY0FBdVpJbXpwUE95c1craWVTcEtJdHRXVTZu?=
 =?utf-8?B?ZytmeVNhSUNVNFEzWnZCajJ5SkZJc29jVS9IQzk4TFFiSzBnK3pxWHRzVXll?=
 =?utf-8?B?c0VlaWxZV0gyZjBTNndOeWVQcmdzRzRBb3lGTnZmSytEMnpJZmtjSWEwaTNT?=
 =?utf-8?B?NlJmdDRWalNtRUVMWHZ3MEhwbjVrRkoxYlJ4ekNISWxSS3VDcGJaUkU3Sk56?=
 =?utf-8?B?N1ZCS1dJeE5nZFUrTDlHS0dWK1NrZ1lxdUFjK1pqakg0STZ3YzVQelhadXhB?=
 =?utf-8?B?Y1FZa1cyTUR2UUpyYWZlSHNVMkI4Z2FkRHQzV3NxOTFVNyt6YUpzTFN0Rmlq?=
 =?utf-8?B?aWhuNEJvQzNQVVRhR2wyT2VobGxuRWZoMk9PRjZ2eXF5eFVsVVFISUpHdzZz?=
 =?utf-8?B?SFNsYTBMNUhJbThQb090WVpoVnRDbzhZMm9DUzRBSHRhS2ZYTklHVHRXcEpC?=
 =?utf-8?B?aWpuWVBxbkFXWEtpUVRLcmZ0SkdHbkhFMkE2RmpFdkFzS1lGTVlHak9aaG4y?=
 =?utf-8?B?SGVNemZnMlNITWZNM1pUSnVDRGpWM1JjSXZuRC85bTNGQWxtejh3QkRNVzdq?=
 =?utf-8?B?NlA2dVhnNG9WSkNQK2ZNMlFFVFF0MUVmR1BnQzg1ZkV3c05HTEZiYTd5d09x?=
 =?utf-8?B?aEJLa1JGRHdBeC9hRkZBb2Q3TUkwL2xKaEhtVnZGVjBhOTY3ZnFRcUlTS291?=
 =?utf-8?B?UDN1RDdUQ3BuTUIrYWxnd21BU2U4RG56dEl6bjVXdkFCWGwwUEdpdVR1N0ZY?=
 =?utf-8?B?VXVlQmM0N01vZml4dnZXZndzTm9DUnhtRUlhOFZCU1c5aHlTMFExZmFJTjA4?=
 =?utf-8?Q?XlWTfJZo1+w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkNac1NqTHhLQ1l6ZkRRRTYrRTZnNStHUXdDZUh0SHEvUTJVamxMZU9ueHlh?=
 =?utf-8?B?N0JtTDZ2T3pFcjFGSHhGTDV0d2VZbEpZRVRWMXh6U1VIMHcyVzl1cmU3OFlL?=
 =?utf-8?B?K3JhSnlKSWdvekM4Sm0vQndNUTllazJtWGJTaCt5Tk9URXdKLzlUT1pWZ3Bl?=
 =?utf-8?B?TkhwaGF4SXFxdDltTWx0czdNOE5obklzY0tWSlQwUTF1L3NPRzhCT1c4c29S?=
 =?utf-8?B?WWk0eU9SNFB6UTBIS2VORVpJTnhEeHRlKzdHaEFzb0NGU1QwaXpIdWcxYUxl?=
 =?utf-8?B?b2hIRXRsSUN0V0VvK0gyNGpST0xDTjd3d1JqUVdOZUYzeldmZkRINitFSlpK?=
 =?utf-8?B?Nk5odFF3SHl6c1NHVnMwbWhsSUJBTzkrNmNmb254aEtydWhZbU16S2VSRmV1?=
 =?utf-8?B?NFpCMDc5TWtWYUNHWnkyb1pvTkFnK2Z0bVFXNnR6VlE2U1h6TkpXbTViNnVk?=
 =?utf-8?B?NjlpVmJYS0NWVUF4ZnZCd2pDZ1lScldLdWtuUE5xd0RQYUVWZWVLNUFEVWJH?=
 =?utf-8?B?azdPcEI5M1JJWXVjOGJkK0U1MlJHWW9yVTNJQTNnZjZHVEZORVBvSDZVRVJK?=
 =?utf-8?B?T2krTGRLbkQ4Z1NCNkRLdG5zZUxUeXVlZldjaTFUV1FBL3pQSG94WXk5QS9l?=
 =?utf-8?B?Mm9oRU1nc0JPZUJEcWlCaXgyR1VraVFZSHdGcFBaQ1Y3UitpWEp6RDY4UWZh?=
 =?utf-8?B?YVhaN2tsKzdZemNlVkx1S1pOM3FXVU9sWGFQa2JqUEJ1UUZIUjF0OUFLOGxM?=
 =?utf-8?B?QUVjemsrRTBsdGFOTGg1MDZLLzNzNFhKY1ZNeFJzVUQxeVVQQkU4RkFuOWZU?=
 =?utf-8?B?Y0IzWUgwYnNNMXB0MTNwUERtS2lRMXV0dkpFZ1plWXZzNk80TWNNY1NET0Na?=
 =?utf-8?B?Z2twS2F0Q2xBQ0VabnFRME40Q0pnR0RkWS9SVmk0dEFOL1NCakVtWEpteExL?=
 =?utf-8?B?SlAzWXA1RUw0RDZ5b1dZaHd5a2c2Wkk5VW5yenF4YkNhMWJ3MVkrTFFjemRo?=
 =?utf-8?B?NVFodUdFdDZidmZid2F5NUEvNXRaamwyOEE1by9NYTliUWIrdldUUHFGNlZy?=
 =?utf-8?B?aDdoVmxONjg4QXVLcm04VVp3cWxWcXBTOG91NG1mSGFnSkNnaGRoN0hrM3lE?=
 =?utf-8?B?MTl0UjgxRmkza041VE5sbnpQcVhKTzV3dmd4UzZLZjBYVk9YR3ZzZURBRmM5?=
 =?utf-8?B?dC84TmU2THo5UlFCUEZ3M2sycCtUY3FUTTkzanFPakt4U3kyUGQyYkN6UTlO?=
 =?utf-8?B?MHBHR21PVXB3LzhwNW80OTJ4WFoxYzNROG5WeDBtMFo3ZENVTHc4TkpudER1?=
 =?utf-8?B?UVh4M1Z4SzU3bEh6RzUwSEJXZFF1WTRET05VMmhmK01SZHVmY0dXajVkZ2R0?=
 =?utf-8?B?Z1BKZHB3aVZRSVlNRW5tQmo0ZXB3bVJkUEV1cWZRTzJBSERXbjZ4K1RKdm1k?=
 =?utf-8?B?STR2Z1JvTDdHNjNKSWs3bno0TXNGQUFrWDhRTjBPdG5DRDRkQVBKWm9ONmZZ?=
 =?utf-8?B?cnp0STRsZExiVHJmcTV1YVBYU0pNc2lvTDI0UStidnNBVGhLbTZFdk5BR1RR?=
 =?utf-8?B?ZElYU1NqWkFnOEZBTFd4QVZrSHVtRHJMdUNIckRwRURTRWc5ekJ2UllhTDhq?=
 =?utf-8?B?ZkFlUnQ4QWMzTXR6aDZzQlVLMmF4bGp6WGVqcjBwUklqUU9yL2ltcFpwTHJk?=
 =?utf-8?B?WGl4azhpSEd1dGF4TFhtejBtSFQ4UktvQ1ErRXJTWWhRbmxRbkMybDl0UHZo?=
 =?utf-8?B?OHh6RE51Q2E1ajM3M0RqTk5oYjBrZTVGNDNFUjNyZWtFZkZMVkNpQTJrMFE0?=
 =?utf-8?B?RG1KTnNsbU1kbVhQZTdQWkE3VEVyRzIxNzdaazhwb2JKcHphU3NXZS9wL0oz?=
 =?utf-8?B?bUJxUGJuczcwQXVSWkpnNFBRMzd1Q290dk9uYmhVNUZoaVlYM2huWUpGMWp6?=
 =?utf-8?B?U2s5N1d6VHVRRTNtb0tsYkEzcis4NDYzSW14YlFRR2pzQlBDby83KzI5NTZi?=
 =?utf-8?B?bEVnRTZzNndJVkdYQzRhNkpzNHZNd2taOElobWJRQnhIelR2RTNBREJDdm82?=
 =?utf-8?B?UFlMRktsZzZTVnA0c1Ixa0g5MXRCV0k3MVRZekNnY0d6aXF5dFNva3BES0JL?=
 =?utf-8?Q?O9YSyXwnShrli8cvZyG309ym5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1599d213-c81a-4471-b9d5-08dd7cdcda8a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:50:16.0244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QW2Q5/dTo5jaRJVzaCGtVZ9cEqrxWWQJiCrkSEzBsXdLYkwcl1uX2yKys8yBPnJh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011
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



On 4/11/25 17:46, Venkatesh Yadav Abbarapu wrote:
> Enable saving variables to MMC(FAT) and SPI based on primary
> bootmode. If bootmode is JTAG, dont save env anywhere(NOWHERE).
> 
> Enable ENV_FAT_DEVICE_AND_PART="0:auto" for Versal Gen2 platform.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   board/amd/versal2/board.c          | 32 ++++++++++++++++++++++++++++++
>   configs/amd_versal2_virt_defconfig |  3 +++
>   env/Kconfig                        |  2 +-
>   3 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
> index 5651d516a9e..23c76238f01 100644
> --- a/board/amd/versal2/board.c
> +++ b/board/amd/versal2/board.c
> @@ -341,3 +341,35 @@ int dram_init(void)
>   void reset_cpu(void)
>   {
>   }
> +
> +#if defined(CONFIG_ENV_IS_NOWHERE)
> +enum env_location env_get_location(enum env_operation op, int prio)
> +{
> +	u32 bootmode = versal_net_get_bootmode();
> +
> +	if (prio)
> +		return ENVL_UNKNOWN;
> +
> +	switch (bootmode) {
> +	case EMMC_MODE:
> +	case SD_MODE:
> +	case SD1_LSHFT_MODE:
> +	case SD_MODE1:
> +		if (IS_ENABLED(CONFIG_ENV_IS_IN_FAT))
> +			return ENVL_FAT;
> +		if (IS_ENABLED(CONFIG_ENV_IS_IN_EXT4))
> +			return ENVL_EXT4;
> +		return ENVL_NOWHERE;
> +	case OSPI_MODE:
> +	case QSPI_MODE_24BIT:
> +	case QSPI_MODE_32BIT:
> +		if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
> +			return ENVL_SPI_FLASH;
> +		return ENVL_NOWHERE;
> +	case JTAG_MODE:
> +	case SELECTMAP_MODE:
> +	default:
> +		return ENVL_NOWHERE;
> +	}
> +}
> +#endif
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index 9911caa0e46..a8d9f5cc777 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -66,6 +66,9 @@ CONFIG_PARTITION_TYPE_GUID=y
>   CONFIG_OF_BOARD=y
>   CONFIG_DTB_RESELECT=y
>   CONFIG_MULTI_DTB_FIT=y
> +CONFIG_ENV_IS_NOWHERE=y
> +CONFIG_ENV_IS_IN_FAT=y
> +CONFIG_ENV_IS_IN_SPI_FLASH=y
>   CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NET_LWIP=y
> diff --git a/env/Kconfig b/env/Kconfig
> index 4438f0b392c..9507aeed12a 100644
> --- a/env/Kconfig
> +++ b/env/Kconfig
> @@ -485,7 +485,7 @@ config ENV_FAT_DEVICE_AND_PART
>   	string "Device and partition for where to store the environemt in FAT"
>   	depends on ENV_IS_IN_FAT
>   	default "0:1" if TI_COMMON_CMD_OPTIONS
> -	default "0:auto" if ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET
> +	default "0:auto" if ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2
>   	default ":auto" if ARCH_SUNXI
>   	default "0" if ARCH_AT91
>   	help

Applied.
M
