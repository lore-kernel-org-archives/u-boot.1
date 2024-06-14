Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB7AC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 11:14:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2E4F889A0;
	Fri, 14 Jun 2024 13:14:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AO4fPfor";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17CFF889AD; Fri, 14 Jun 2024 13:14:12 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01B66889A0
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 13:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MC/0+j0JHiqXOaQbbbkWtf0TTCBIZVivQsuTtii5eyi/P4dw19XgWESO2lGNCCVlGz2js0rc6TKXi/QFj6eT1eEvfwYbCGhhLXhk+T0HmmYSbHbOCva0ZTkyC1CV7xZ6hgoVOIW0ImYapsZuKhhtb6zIn8qouzDJWsqf2T1eIhsrt4sDhRH6GtNVt9HzG7RRSmv1ZkiIZSbx2GMwswOH4lWhm/nH9VySQrKQtnx1Erye6b09SGldqItDoxYhY2WK/L68EwNYiwza3N6oJcLa9FfJpuORLIRaeBvkrkMD+IJLuyXkmKMg16mrJAKPEkIkPwptNvgnPChOoft9I+chnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kghYAqBWXGI3xzP6tkKa84VIV1KUBoTNKc2rcpvaaa0=;
 b=XfC9QY8vg0u6Aja4MyQ3zzXCJ7xWTKT6Cr60fNFjV458DXEHhbuhQPgANSHuqmYRCk41gE6Oj5ZESkThNqM0crOAS+PYdna7Pw4ZGScD19N2tPKTsADK1xh/iLbnXwE7HU1HGeH3HKpSGVi93Te8Z7nHmTb1IMaq/ebChGZPc6eXkPHLpbgtu9VJSavLgg2v1iElvNZEErGWbXXtmokagorPNkDfWeQTAePfULJ8eYQ4P+EH7qsgjeR5uEQ5Qd2JhTUyd7OamkHkcQiA1Lx1LybY2iUdt1aeoJAcNKYTWoGqDHKh0UqJWKvgKWzYn5+J4HCw9qMXyGxaXcgoGiFpyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kghYAqBWXGI3xzP6tkKa84VIV1KUBoTNKc2rcpvaaa0=;
 b=AO4fPforXR6SeIV2ywy548t8Nzq1axRyAmNVe2uzZfxOQa3dYjEYF6a5JWZuNHTyOtlUb6BUcExA3XveSXSURAe61KCOfUHzoXKSuc56FYMeiM/te1x7CXVG9T5i2MrT9jouugJ3aE1zSGUmtUqLb7BbgfTgQMdp7vYkhXaWIAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW5PR12MB5624.namprd12.prod.outlook.com (2603:10b6:303:19d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Fri, 14 Jun
 2024 11:14:05 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 11:14:04 +0000
Message-ID: <18dcc100-38c1-4c9f-a88e-03cbaac88cbd@amd.com>
Date: Fri, 14 Jun 2024 13:13:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] xilinx: Add option to load environment from
 outside of
To: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>,
 "vassilisamir@gmail.com" <vassilisamir@gmail.com>,
 "monstr@monstr.eu" <monstr@monstr.eu>, Love Kumar <love.kumar@amd.com>
Cc: "LPolak@arri.de" <LPolak@arri.de>, "trini@konsulko.com"
 <trini@konsulko.com>,
 "santoshsagar.algapally@amd.com" <santoshsagar.algapally@amd.com>,
 "venkatesh.abbarapu@amd.com" <venkatesh.abbarapu@amd.com>,
 "sr@denx.de" <sr@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20240603164738.437834-1-vassilisamir@gmail.com>
 <CAHTX3d+mD+iqJ-+N4W+y5XVUozVqq-n19-zRBBT5BqDs3BpJAg@mail.gmail.com>
 <482398653f2b41292c056eb67077ca29f0b9a7ae.camel@cern.ch>
 <48dc217d-f5ca-4ba0-b174-18b4ba6ac0d8@monstr.eu>
 <a1567b35ac623cfcbcc28ba12f43813f6e3d8887.camel@cern.ch>
 <b0954805-8e3c-4594-956c-9e011f858522@amd.com>
 <96faa31fd92d13a4bfab92a2f65b53cee8423d3b.camel@cern.ch>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <96faa31fd92d13a4bfab92a2f65b53cee8423d3b.camel@cern.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0235.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::30) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW5PR12MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: 13107e09-5115-424f-8943-08dc8c631a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alB4dlhJMXhrbGEvV1JKM21tc0U4L3pqaTdaUjZqOGd6VGNJd05MQldNWW1v?=
 =?utf-8?B?M1M4S0I3THViM3ZDRkNOZllCMFRyRnN1NERyaHZkM0xTUzl0V214N1VTM0JD?=
 =?utf-8?B?SG9QSnlvOXMvdVhEWlo1N0t6dkV1VURKQ0RQVVIrWkNGQW5OS1lNd1Fma0c4?=
 =?utf-8?B?c0Q4QjFyRCs4eTl1dXdvMkJMRnNzWW52YkZPOUhPMzB2cWdhMVBWaHNESXUv?=
 =?utf-8?B?aUFJY0pCUmVLWWJtRGR4Z3dLTlFYNFlwTytYR29Wci9USFN2OFRBYjEyV2dZ?=
 =?utf-8?B?MllVTS9YQ3NsNTBhQzBBc1lLVGpSTnFGYTJpQ1NmQzhoL25oRmxWOHllaU91?=
 =?utf-8?B?amF2bkZaNHlYeExaZk42ZWJIU2g1dHY4eHIzMkFMRktjQnJhNURRQzFUVTRD?=
 =?utf-8?B?OGg1RzhBcXdTZHRycUthdW5FUE1IUGYzeHhSR1ExZDJmdjNQS0dsSkRybDZD?=
 =?utf-8?B?cFl2YXIyaThuUmM2YUlKdTNJdjBnNXN6WDIyMWRGMHJ5eGsrOGJCREQ0TjB5?=
 =?utf-8?B?TDllM0hYN2xyMjdGYWZweXFlN0daUUR5R0hvSEdCMzhuenVubjQyUTdyU3RP?=
 =?utf-8?B?Z1h6bGdQOWxtRjM2UzQyY0JFSHdJZG8wSldtTGNCZ3c2ZmlrbXhCb0t3SXgw?=
 =?utf-8?B?NCtUQ0xhQUN1ZUM2ejVzT0FHcWpyR0tyNjd4bGU1dm1BZGZUQ1dybEovQnhG?=
 =?utf-8?B?NmxTM29RVGVFMjlQTmZJVHVXOXdjU0ZXMnlXUUxjcU5rTDZaRWpqSHREd3g2?=
 =?utf-8?B?YW5pWHhielBTMTc2cm9BV1AyVG12ZmFyTUtXLzJ1OHBoajJFdUFBMmw3b2N2?=
 =?utf-8?B?RGRIS0djU05yd1RGeUlqVWh1UjVMTE1hM3F3cndEcXlpZG1zbzFuaXhZSGdn?=
 =?utf-8?B?NGloSVF3R2picnBoK3RweXUrbGVSdTNYK3kxb28vRVpHTFBjeE9EL0lvSXNk?=
 =?utf-8?B?V1MvbHcrUUNxMGhKY0huSzlVUml5eDVxMjRFZ0xQbzFzcUxucWFlZysya0FY?=
 =?utf-8?B?OGJibzFYK0N4U3RSbGJTYTJ5YStSb0xnbFptTlBrK0poVmhxeUQzSXNnNnha?=
 =?utf-8?B?c09EOUpEVDZEVlo5M2RFQ250QWRXV0RhYU1PU3kwYTJWblZTRkErekZZV05V?=
 =?utf-8?B?NWRreDJoaUovN0JubURkL1F0UkFncnBRUW1zT1dxR1JnZVM5UTF4eVl4Z0JI?=
 =?utf-8?B?SXBLL2JCMVhJZVBYR1QwTTA1bnJMelpTMFhjNi8rWGoxM3ZIcTRlYk9MOUhN?=
 =?utf-8?B?bWxiUm41anZsSDlZWFUzRTBYbWFFUElMVjhZcHRNcFo2b0Z4VE4yYnhtNHlI?=
 =?utf-8?B?bU9heU1uOW1nTE9HVitvL1U3MHBUQmpFRnhwUjUwTU9CSWdzZmgyOXRsVzht?=
 =?utf-8?B?R2xlQnd5SlZzRG5MQXNTQUpub3J2WUg1QnRrOTZtQWxmQ0ZvM2lacndKcEMw?=
 =?utf-8?B?Q1EydkFZbkVWS3prdXd5TkV6RzFzREppSmNNMGxKSmJROVhjSE9QMlJPYTdy?=
 =?utf-8?B?UzU0RDE5dy83OGJONXh4UWVPVUJtb1dhZUlaMVhUZE9kR3NGbHllTmw5YXdr?=
 =?utf-8?B?ZXNTN0NxTFUwV0lZdWFCMXpWWXFUVTFiRnpFL3o2MHYyV0UwaWNvUmZFMnF4?=
 =?utf-8?B?RkNxL3NReXlYTVdTK1YxNnFJM2piOHB5R2F6MlJ3Z2gzcXlqME1ZS3FlNjA0?=
 =?utf-8?B?bjk1L3hYSGRQeUlHM1pqZEJjMXdDOU1pUS9od250VmhRNkJtNDFMOW54ZXlE?=
 =?utf-8?Q?6lusyvyeA46UnQ60aFXdGGylhdwCJcvgfTYaDgG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1dmb0JHb2pIMDdTbmQwVXIreU9QQXVRZXZ6VFlpaGNWNisxWjhGU0h2T3lI?=
 =?utf-8?B?RjBNTzhQMGZhV0VSb1RvMnRObnFEYkdXZWZMVUZFbkJlcGJUSThqNDhCOG12?=
 =?utf-8?B?R1N2K0xHc20xQ1ZLU2JqMlRqQ0c4UmltbUVReW9nWHBBNVlKa1lFajlMV2Zi?=
 =?utf-8?B?K0ZtNmJQeGhTM3dkQm9IQkN2ODduL1VUdnpYckplNCtzTlk3dmZNcmR5SmFF?=
 =?utf-8?B?VmpUbTNkNGt1U2xZSSs4NEczWFgycURWb3lpNGFUUGMwdWMvQ2FYS0N5eXlp?=
 =?utf-8?B?SWNhcnZIejhnYUNGQlhaWktPSStFMVN5R1lJQXBLWHduazkyOCs5V0VlSi9D?=
 =?utf-8?B?TGE4aVJhNjRVeFdwS2lReldmWmlza0ljUDJ3UUpKS1JlSEZYMVNzbko5dzlL?=
 =?utf-8?B?NkZXMENtaWJEbm9SVlc0LzlTZ3FMcVhnN2ZRbkE1dmpXNHhiUUNuenlTdDdS?=
 =?utf-8?B?UjRnYmZ3ZHJwczRJaGRwMU5yWXpyV2JlOGNUdUhXT3ZIZDlPTWFSRDJZYlQx?=
 =?utf-8?B?TXpvZ2h2b0Y1bEF5L28wUEVlaURMUnFXMm1WNitLaGJ2Rm5mNUMwNElCNk1B?=
 =?utf-8?B?SVZtUEJIeHJvY0lNakVuaSs2eldDZUZkL2FnTXZwUzE4UWk3b3lSOUxkeXNj?=
 =?utf-8?B?by9oY08rQUlUWTdUc2l6YytNYTl3L1U0Nk40UHYzRlA4ODBuL2UwNklTaS9i?=
 =?utf-8?B?MHBtODRNcDFWN3RFWU9vcUs4WkxPei9WSk82d2UxWE0yS2VtN0NqOWZyK1RV?=
 =?utf-8?B?NHZkQ3NSdFd3S2o1Z28yNWwyUlQxL3JqaDgxQmQrNEJQeVNOSzRxWHJOVDRX?=
 =?utf-8?B?aFpCL1lFSzIvL0JsREtGQzlwWHpJUmRJdWtWR0llNkF5RlREb0g0dkU4RFpq?=
 =?utf-8?B?WDhXV3A1eDVVWkRYeVIwOExnNWl4Y0kwTnhrODVnTUpWZlVjei9ycWRJMUFn?=
 =?utf-8?B?K2FPM1ZEWm85L0FnbCtpNXQ4bVVBZmlhSkV4SkxZb21lb2tRMXN2eVNPRktM?=
 =?utf-8?B?dnFkQVRQdmJDSzd1bkU5VEp1cFByZ1I3K1gvUzRLK3ZMZ2ZiSkR4M2gzcEhR?=
 =?utf-8?B?MGoxT3RFTFo4em05WVJkVjFrZWVGUUF6UlE4VTI5ckQybWNaMmQ4OUtmV2F4?=
 =?utf-8?B?T1pjRFRsSUhwcFREMzA2RHNmWUJDa0F3djdGczk4N0c2eEJOOEk4d3hic2hX?=
 =?utf-8?B?cFBaTjlZNHkxaDMweFpQeEE5OGdaTHQrbnQ4QW1YZS9WM2xZa1NMcWttWXhD?=
 =?utf-8?B?WE85Vm54T1JHeTlmOC9WaEJ1bUVuamNqOExVcnNPWjJYNDRwcVN6OFVTVlJP?=
 =?utf-8?B?TWVYYnJ0bjU3aUZrSmlUTndoV3EyRkdNZWQxcmxKZVgxQy9xWmZLU0diWGdN?=
 =?utf-8?B?Uld4aklZOGZBbmV1cDhaVVU3ZnN6THluMjJPaTMyeHZNck9GZXQ3NE11M0Jj?=
 =?utf-8?B?NWdRSUY5NUg0WGpxVmlQRGthbkFWNkdUbFZhUUNsOTRsUnBvNlMyZ0svOGs5?=
 =?utf-8?B?TTZmSmdXSy81MFlOOTlXZmtkSXJPa3BoZkpHUG5VZEoxcnlaSmRDejhaYmhX?=
 =?utf-8?B?SkxIOXlyUWlKYnNZRXFvWmFncWZpcmM4WFlvUjIxWTQ5K3h1eEo3eS93MUxr?=
 =?utf-8?B?RjlGeGJKWk9QZWV4TkFlVzdzdDZ0WjZzTU94c09uUE1PV2YrWnE3Q2FJRTAw?=
 =?utf-8?B?ZFkxM2YrTHRFRE0vQkRSS1BvdE9NbXE1RjBYVFhHMjZEaTFMMHQrVElZVnpW?=
 =?utf-8?B?THd3OW1hRUtPNzhFODZKMm90c0EvTmoxdTlBclRsL2w0NUE4NzFWaXZPMUZ3?=
 =?utf-8?B?OEQ3Zm5YQ05JYmNSb091RGJFT3RYdHZsMmcxNjFEZ2htc0dIbUpwaWFYSGhh?=
 =?utf-8?B?ZmVUUkxyTXM0UXd2czVYS3BLR0RMblFWdTUzZkR1MUplTnJacUpJdlp5VlZx?=
 =?utf-8?B?OFZCcVA0S2dqU25uRmhjWFZxc1pxdld1L0VHTEUxZDAvNnUwcnBEajVhdXp3?=
 =?utf-8?B?UXJ2MjRtWDlzZ0NnOVlCUGNqRUwrdTJmRmd2Nm5QYTk4MHJpWmtsMmIrMXZl?=
 =?utf-8?B?ZkJ1cWk3eVE2Mk1uUDBCL2tRb1RmQ0E0Z1RRMDg2OTd3bTMwZFZvYnZ1RHBN?=
 =?utf-8?Q?U4ZQw9Bj+X6PSrwmcbSkquG1v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13107e09-5115-424f-8943-08dc8c631a17
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 11:14:04.7906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eymki5Zj2dWy3HW0BUpxH5c+kdamDOO0C60abIU/4Bdn1a61+sYmrlC1aFe+X06z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5624
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



On 6/12/24 17:49, Vasileios Amoiridis wrote:
> On Wed, 2024-06-12 at 17:32 +0200, Michal Simek wrote:
>>
>>
>> On 6/12/24 17:11, Vasileios Amoiridis wrote:
>>> On Wed, 2024-06-12 at 16:47 +0200, Michal Simek wrote:
>>>>
>>>>
>>>> On 6/12/24 15:57, Vasileios Amoiridis wrote:
>>>>> On Wed, 2024-06-12 at 15:42 +0200, Michal Simek wrote:
>>>>>> Hi Vasileios,
>>>>>>
>>>>>> út 4. 6. 2024 v 15:21 odesílatel Vasileios Amoiridis
>>>>>> <vassilisamir@gmail.com> napsal:
>>>>>>>
>>>>>>> From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
>>>>>>>
>>>>>>> Changes in v2:
>>>>>>>            - Remove duplication of custom hardcoded
>>>>>>> env_locations[]
>>>>>>> code.
>>>>>>>            - Add implementation with general
>>>>>>> arch_env_get_location(op,
>>>>>>> prio)
>>>>>>>
>>>>>>> v1:
>>>>>>> https://lore.kernel.org/u-boot/20240522174738.73522-1-vassilisamir@gmail.com/
>>>>>>>
>>>>>>> Vasileios Amoiridis (1):
>>>>>>>      xilinx: Add option to load environment from outside of
>>>>>>> boot
>>>>>>> media
>>>>>>>
>>>>>>>     board/xilinx/versal-net/board.c | 47 ++++++++++++++-----
>>>>>>> -----
>>>>>>> ----
>>>>>>>     board/xilinx/versal/board.c     | 47 ++++++++++++++-----
>>>>>>> -----
>>>>>>> ----
>>>>>>>     board/xilinx/zynq/board.c       | 49 +++++++++++++++----
>>>>>>> -----
>>>>>>> -----
>>>>>>>     board/xilinx/zynqmp/zynqmp.c    | 55 +++++++++++++++++--
>>>>>>> -----
>>>>>>> -----
>>>>>>> ----
>>>>>>>     4 files changed, 101 insertions(+), 97 deletions(-)
>>>>>>>
>>>>>>> --
>>>>>>> 2.34.1
>>>>>>>
>>>>>>
>>>>>> I have to remove this patch from my queue because it is
>>>>>> actually
>>>>>> breaking current behavior.
>>>>>> CI is reporting an issue with it and I did a closer look and
>>>>>> what
>>>>>> is
>>>>>> happening is that if one location has no valid
>>>>>> data it goes and looks at another location from the list.
>>>>>>
>>>>>
>>>>> But that is the desired behavior, if the environment is not in
>>>>> one
>>>>> location to check to the others.
>>>>
>>>> That's how u-boot is written but if device doesn't exist or not
>>>> accessible by
>>>> u-boot it is clear that it shouldn't be used and then behavior is
>>>> correct.
>>>>
>>>
>>> Hmmm, how can a device be not-accessible by u-boot but u-boot still
>>> tries to use it? How could that happen?
>>
>> That Xilinx virtual defconfig are setup in a way that all drivers are
>> enabled
>> via Kconfig but they are not present on all boards.
> 
> Ok, now I understand how that happens.
>> If you look below in defconfig we are have that variables can be in
>> NAND but
>> there is no NAND device on zc702 but still u-boot tries to reach nand
>> and read
>> variables from it.
>>
> 
> So, the ideal scenario would be to U-Boot never try to access the
> device? Because from what I see, is that since the device is not there,
> U-Boot throws an error, and moves on.
> 
>>>
>>> Also, I think that this is a problem of the user, no? If for
>>> example
>>> you have configure ENV_IS_IN_NAND but there is no NAND device, then
>>> with the patch you get a visible error that U-Boot tries to access
>>> NAND which is not there.
>>
>> For our platforms where you can burn boot.bin to any boot medium we
>> had no
>> choice that's why code was written like that that variables are saved
>> all the
>> time to boot medium.
>> Also that I don't want to maintain other defconfigs for slightly
>> different
>> configurations.
>> On products customers should look at our all in one defconfig and
>> disable things
>> which are not needed. And where variables are saved is definitely one
>> of them.
>>
> 
> Well, that makes sense.
> 
>>>
>>>> If device exists and simple varibles are not yet saved there
>>>> going to
>>>> different
>>>> device is IMHO problematic.
>>>>
>>>
>>> Maybe I am still a bit confused, but I think that if you have
>>> defined
>>> ENV_IS_IN_QSPI and ENV_IS_IN_NAND but the environment is not there
>>> then
>>> the behavior that we see is actually correct. U-Boot tries:
>>>
>>> a) Get env from QSPI but fails because env is not there,
>>> b) Get env from NAND but fails because NAND is not there,
>>> c) Get env from nowhere.
>>>
>>> To me, this looks like the correct behavior. Isn't it?
>>
>> This sequence is correct but what it is not correct is when you reach
>> nowhere
>> and you run saveenv you can't really save variables even they can be
>> saved to
>> QSPI. They can't be saved to NAND because it is not present on the
>> board.
>>
> 
> This can be solved by using the env_select command (cmd/nvedit.c) no?

I looked at it and it is interesting option.
We don't have it enabled by default (and maybe should be enabled). CI test is 
not handling it too.
Love: can you please take a look at it?


>> The issue is that none write initial variable to QSPI that's why
>> there will be
>> all the time bad CRC but location is correct.
>>
>>
>>>>>
>>>>>> On Zynq it behaves like this.
>>>>>>
>>>>>> MMC:   mmc@e0100000: 0
>>>>>> prio 0
>>>>>> Loading Environment from SPIFlash... SF: Detected n25q128a13
>>>>>> with
>>>>>> page
>>>>>> size 256 Bytes, erase size 64 KiB, total 16 MiB
>>>>>> *** Warning - bad CRC, using default environment
>>>>>>
>>>>>> prio 1
>>>>>> Loading Environment from NAND... *** Error - No Valid
>>>>>> Environment
>>>>>> Area found
>>>>>> *** Warning - bad env area, using default environment
>>>>>>
>>>>>> prio 2
>>>>>> Loading Environment from SPIFlash... *** Warning - bad CRC,
>>>>>> using
>>>>>> default environment
>>>>>>
>>>>>> prio 3
>>>>>> Loading Environment from nowhere... OK
>>>>>>
>>>>>>
>>>>>
>>>>> This is the message that we get as well when this patch is not
>>>>> added.
>>>>
>>>> It means you are booting out of QSPI but qspi is not accessible
>>>> by u-
>>>> boot. Correct?
>>>>
>>>>
>>>
>>> Well, we are booting from QSPI but environment is in eMMC. In our
>>> config, we have defined ENV_IS_IN_FAT and ENV_IS_NOWHERE but we
>>> have
>>> not defined ENV_IS_IN_QSPI.
>>
>> ok.
>>
>>
>>>>>> prio is my print to show where code is. Qemu boots out in
>>>>>> QSPI
>>>>>> boot
>>>>>> mode and SPI is tried first and because
>>>>>> this is xilinx_zynq_virt defconfig drivers/env locations for
>>>>>> other
>>>>>> devices are present too. That's why it goes over the list
>>>>>> and it always ends in nowhere which never fails.
>>>>>>
>>>>>> If this runs on real HW then the same behavior is visible and
>>>>>> I
>>>>>> don't
>>>>>> think it is right.
>>>>>> I think this solution should be rethought.
>>>>>> In product current behavior from our code is not the best and
>>>>>> current
>>>>>> U-Boot implementation is not allowing
>>>>>> flexibility too. We are enabling redundant variables which
>>>>>> can be
>>>>>> only
>>>>>> on the same device but not that you have
>>>>>> one copy in QSPI and second in EMMC.
>>>>>> That's why I think location should be pretty much read from
>>>>>> DT.
>>>>>> There is options/u-boot node where location of variables
>>>>>> should
>>>>>> be
>>>>>> described and this should replace
>>>>>> env_get_location().
>>>>>
>>>>> You mean that there should be some type of new U-Boot node that
>>>>> describes where the environment should be located and go and
>>>>> search in this device?
>>>>
>>>> Not sure if node or just dt property which points where that
>>>> variables are stored.
>>>>
>>>>
>>>
>>> This doesn't sound too difficult to do. Still, even if this was
>>> done,
>>> what would the priority be for looking for the environment? For
>>> now,
>>> the code is written in a way to check for the environment only in
>>> the
>>> bootmedia. My patch added a functionality that if the environment
>>> is
>>> not in the bootmedia to check somewhere else. This should be the
>>> order
>>> also if we had this u-boot node? Check first in the bootmedia and
>>> then
>>> check if there is a dt property?
>>
>> I don't think this is going to be that simple. Especially to support
>> redundant
>> variables saved to two different devices.
>>
>>
> 
> To my understanding, I think it is enough to have a dt property that
> says "emmc" or "nand" etc.. that can be read when the
> env_get_location() is executed and the correct env_location is
> selected. What am I missing that makes you think that it is not so
> trivial?
> 
> I don't have that much experience with the U-Boot sources themselves so
> my question might be stupid, I know.

To do it generic it is not just about saying qspi. It is also necessary to say 
where exactly it is for both copies no to be hardcoded via Kconfig.

Something like this.
options {
	u-boot {
		compatible = "u-boot,config";
		env = <&qspi base size>, <&qspi base_redunt size_redunt>;
	};
};

above description should work properly for raw based devices.

Then there are MTD based devices where description can be like this
env = <&mtd_qspi_1>, <&mtd_qspi_2>;
or
env = "partition_name1", "partition_name2";

And also filesystem based
env = <&sdhci 1>, <&sdhci 2>;  // controller + partition ID or GUID.


And I think you should be able to define for example this

env = <&sdhci 1>, <&qspi base size>, <&mtd_qspi_1>;

Which means 3 locations for variables which should have the same content.

For doing it you need to touch all files in env/ folder and change the code 
around CONFIG_SYS_REDUNDAND_ENVIRONMENT.

Thanks,
Michal
