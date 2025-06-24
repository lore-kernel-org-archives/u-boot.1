Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04450C77B7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 21:05:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6537E82C65;
	Tue, 24 Jun 2025 23:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Y1IvscAJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A71D82C84; Tue, 24 Jun 2025 23:05:39 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D270482B18
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 23:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=falS8bXq4qI0GJ5zyCSaA7aS0ZilG+zK5MofYVYIDKkYOkZz5Ek+2yZk7XS1uoUqoAXxFsiOU4pMoHFCBEg69KHHq6YGCt6W6TYMm0xbxxcoBOqOfPmoAFK7CITpi09YPinqLlXw05OAtlAXQJHhrTutYceXgOGLrmyW4JEKJH5SRfd6sH2BgPzyMK+FpYxUyNTvkFd3Zuni3MgMjyQ57nI3vYkcOb+ng+KUJrxfNYOfl8RT9qt2MG9yWmmd/OGwtmcLd07trhDOAV1li6lXCHFUl7t/qS/OOo+cpLrRPif2LJez2H+4GO8GNCLVBbyCqqXHoCWzsfb66Fv11wfuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfhzYDSY6pO6Rg/JtNmtAT4J0+vkgy3c60QZXvFb8zo=;
 b=qOQZzT/NBKf34qWd4WfNv7se2cNOHZLNm8ci+326WvkouCkCPy2K9z5axYyo7ktsUKNge4QtleWo/uQ9tXNaNyt3CumZTUHuNrl0R0wkdSVqIC2blHZZ1whNIQILTJyRzaJJbofQDg6poYEZdG9M5PUnxitg+AYkrKYsoXGmYviJBdRBSBrKGbTQhztZQVfHDmpSaKr1+Mx0pkOB8N+GTLW1bx5UG1wsd1KCt9dgsO7ACmsLN3YCSICTU+ZN9l52eP0MJA7W3F+ICbvO9cbL/+J3ERTGRx/1ZmikC9zsfbasM0EFi/ajt5uHwIqSiLsZT+m9XJU6z6r5RVGeOQ+oww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfhzYDSY6pO6Rg/JtNmtAT4J0+vkgy3c60QZXvFb8zo=;
 b=Y1IvscAJMgB5RAkZppYbrGQZZuRHS4gFytVBOdK/nuq1mWhN1vfOQdd2jU66hFrs/CrvXx+CTeUJiSQ8zakesgFvjup7CLEM4uxWb+XKv6iY6kTdruvBYYJKVqqSFmFAUG9CrkDkdK9jqzVg+zVeLXvLi/iQdhvOc2FQH6NQq5BTM3E+zHMm4NSfUAu6FJqPkJ7WFKm0/bDSr1TVW5cqKYH/Dmwy4CwBXdWyUUqDHE1Kexzg9R3iOWYVtHvWHLR6dLaK79P/uo23Ji+OzZBFPvQK2iCB2wk1BGFWI8h6d6kUkey1BxGoCSA/dsV1/aoBBs7l1LrP8uzSPurVy1jtXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB10538.eurprd08.prod.outlook.com (2603:10a6:800:205::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 24 Jun
 2025 21:05:35 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 21:05:35 +0000
Message-ID: <62500d98-9489-49e0-9c34-b8033c708687@iopsys.eu>
Date: Wed, 25 Jun 2025 00:05:33 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] common/spl: guard against buffer overflow in
 spl_fit_get_image_name()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Sam Edwards <cfsworks@gmail.com>,
 Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de
References: <20250624153431.46986-1-heinrich.schuchardt@canonical.com>
 <20250624153431.46986-3-heinrich.schuchardt@canonical.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20250624153431.46986-3-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB10538:EE_
X-MS-Office365-Filtering-Correlation-Id: b33a2e2a-fdbd-4736-c933-08ddb362dcd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UU9PeFNHRUhYYTd2ZWZybTlxR2tPMzFTRGtwYjV0RWxJMmFTOHh1RVJCWHVS?=
 =?utf-8?B?MitrVlNjN1ozWW5DMk0vN1NrcVNJV0tETzluTUNaK0JVM3VEcTNhSFRHNU9V?=
 =?utf-8?B?WGh6TlBadWFmTXBVdGUyMVVCdEhHVzhOQ3luNlNCR1dJOTdFV3FuQlNTMXdP?=
 =?utf-8?B?VE5uWWV3eXpDKzgreG9kcFdySEd4di8wWXJRWWVwY01oYWQyNy9Mek5UWm9D?=
 =?utf-8?B?ZXl1TkpFd0YrZ3hYTzV2TmRSN3lqWGpqS3NYazZVUUw2YWtiQU9GWC9IUzEv?=
 =?utf-8?B?V2lWUVNRZENFSmFzK2RaNCt0TXYzUzl5cGRpdWQrWTJCcG5mcVZHK05tYjVQ?=
 =?utf-8?B?RElwZDNvZHRNeTRVMnhUZndKQmkxRWJ3ZUZmS0t6N2VWUjVlYjdFZldpNVdo?=
 =?utf-8?B?bXV6QnZPcHMzYndFL3g3TVVoeFNmeEpvTG1PSysvbWxTeXBaaTZCak51QW93?=
 =?utf-8?B?dlBGUnF6S1BHTnc1UDFLU21ud0I2MXRKSkl5Qmk0N3crRm16cFJmWW1XWHQ4?=
 =?utf-8?B?SUpyemJrWk9IQldQTEw1M25vVnYyeVFnZVNQTWpUMWRtOEFSOEZSMEUwSUlL?=
 =?utf-8?B?Rnc0WURienBDWmNJM0NQZ2xWQTNPOC9iQSt3T3Vxd3ZCT0xVWndKU0phVGNL?=
 =?utf-8?B?emFPRnlVTWF2RzJvNzZJZnpiL0NTU1kvZXV3cjJHMjFTNXNNYlVxcjRwenMz?=
 =?utf-8?B?eUtSYzN3OUZsZytwRldnWTZWZk9NQTdaOW9nVnJJWlcrOC9sbms4TXU2RzBP?=
 =?utf-8?B?clJ3cnJvSjYweUZoMm5oS3hraWErVCtnSUZNNkZRUUhPNUtUNXRyWXNmSWNL?=
 =?utf-8?B?bVFTMVgwY29FeEwwWTFRODhxa2JuVkhDbHFkUFNVT0JKRUt0NVN4ZWc0VXBF?=
 =?utf-8?B?bGNNYWRRb3l6K3hQZENKU2NGUjhMLy9IV2NTeWkwS1V0SXREWkJDa09rcXBQ?=
 =?utf-8?B?Q3JaLzQySUxqR3NEOFdHQUFSdkpWcmhUc2FEY3VpcXZnUzZlZnRUaWROVE5F?=
 =?utf-8?B?T3V0bHprTHZUK2Z2Nll3WmJVTUQrT0pxRUhSdlk1N29TaURCSTU3ZzNEVDc2?=
 =?utf-8?B?YmkxZFFjNklHdDUrTE16OEJnYnpKQmhkRitEaStvN3p1Q2doWS92a2RrZGNu?=
 =?utf-8?B?My9tV0hrRXRQQ0JqZHhRWWRRT2J5WDZGSGF5V2ZKeVg2d2czY1J5c0JKcWhw?=
 =?utf-8?B?L1o5aGQ5cFlqcjdCQThST2RXYVpDT1pRSVlqcmZvcFBCdWwreTFtenFLalFv?=
 =?utf-8?B?TGV2SkRQdFRQQnJyS0tMTDRuWkIweHl3RCtmaFBkcktaaE9Id0pqN1NmMnEy?=
 =?utf-8?B?R1ZzYUJsUTRjbGFOWmptSFBVNUsrUDlwYW9kQk5CN3FmY2JvUmJDNG9MdWkv?=
 =?utf-8?B?bWVqRzRmWmNwL3BDT0ZyUUI2YWFiSWk0ZEpoQ0I4WEhyV2pFczVlZGEyS0Ja?=
 =?utf-8?B?WEc3YnFURThuN2hzVTJ4UDJFakE4b25xWERkczc1SHJwUXRaeVE4bFc1TW4z?=
 =?utf-8?B?VjJ1d2NYQW5IMkRaeDY2REZsaWJZS0pSSExCVzJRSzFobWxRUk1KNmF4WWgv?=
 =?utf-8?B?ZHB3bXNjUmc4c2ZIVk9mcDVSemtnWkp1SlREUkR4UTZpb2lxdG94enBKV0ta?=
 =?utf-8?B?SFE4Q1lYNTk2K1RjV05qSHl0NTVUYTNwNGlyVDNxZS9CWisvQjcxUW1wTWZz?=
 =?utf-8?B?RlJ6SUhyeWlDTmxxQ2oyVWtWWTNKK0ZnS3hTQmRqSGltWnZMVEp1QzdZbm5o?=
 =?utf-8?B?azRsY3p2cE11cTdLb1djVVZhQVlab1pnTWt6bW1FMHpIL2hST0IzQjBlRS9V?=
 =?utf-8?B?QWUyRmdPR1RlR1FxcVU4ZXRjOFBzR0p3SkoySXd5OUZHenhRQzgyV0FpdTV5?=
 =?utf-8?B?VXNoWkZ2WFlScHdRelhvQzBrdnU4Tkl3UWlEUGZQQktrdFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmI1ak02bVZjNEFHQzk4bFRJWGpDM0IzSm9NbUdWQmVKMlVpamVwL2VkVTNh?=
 =?utf-8?B?WmRIUUMzemx2aXhwM0diOGoxVk5FYUZaaDdkVDNWdWdHVzNrd2tFY050TkhR?=
 =?utf-8?B?R0dUWlI3bGRwWng5dUZpU3lmMFJhdlFFOE82Q24wSGdRRWptdzFzR1ZtVFQr?=
 =?utf-8?B?MTRDcFlJLytvMDhiYWpROXcwSEFIUTg3VkxEcE1DRVJLb2pwbXRSSklvNlZm?=
 =?utf-8?B?a2RtLy9KcU10cWY4WFFYNXlIRVlzL3ZXN0FLMy9EOGlGNW9KbGtOeXRaZG83?=
 =?utf-8?B?UlljT2NvYUpxZkNJOGV2M1hvaE5JLzBRWTBIZVR4MDVjSVdDTlRNTmlmSEky?=
 =?utf-8?B?eG1mZjJoRDVZWERkaFZ3TzU4SkVtN2lUMUlLY29jMWEyTmlIKzBBUGt6Tmxk?=
 =?utf-8?B?VlpwcG51S3VGbld0SWxnekdaUDRuTjlKcFJHdXl6OVZJVmpzU1BEdlpMbDhL?=
 =?utf-8?B?VVpINUZ3aHQwM1c1eUdHckdhaHN4ZGNDb2ZTNFh5S1VKQ2JCak1EZkcwOE5I?=
 =?utf-8?B?RUFsclBGZnhnblNYdVEwTWhsblk5WktGNGRORmVmMEkwVEJGSDdMSFJNTTlT?=
 =?utf-8?B?akE0c1hiK3hCSlFmbFZUMGpXem1oRFFLMkZNMEJQbStETWZxQ2pyVTFSN2l2?=
 =?utf-8?B?bE12elowS1NUNTFjbHV0MEZJVVlYQytra2ZKWWJSejRWZzRaeW96TnlhVTY3?=
 =?utf-8?B?SFI5YTNIS29Ja3VqSDlINVVnTFVrYWgyc1JmN0xQNGFoKzhSRjlBQTIzdXFF?=
 =?utf-8?B?Vis5TFlvN2ZxVy9TQzMwMmsyYXVYTVN0QlRpTkJldXdxSmJqVlp2T29vYWNY?=
 =?utf-8?B?VGw2T3gxRjJUMU5PWnk2ZHdqcHJEN0ptRzRKd0NhbUpOWXZWR1htTG1uem03?=
 =?utf-8?B?KzFieTJQbzF1V0xkL0pjSXpLMElsclVmayt3RkcxVVV3RlhUeHBVSEZ4R2xO?=
 =?utf-8?B?OFBseUJ4NWl5ZGpmWVR0UjFxUEgwazlnSUtNUTVxbWdXK3R0T1M3cUJlbmF4?=
 =?utf-8?B?S01TcFBmZ2xkMDhJUDRGTTUxQW0wL1Q4T3pUaWtpK0J6QXdIT3ErMG8wRTBv?=
 =?utf-8?B?cnZSN3lGV3NKcW90bGNZTjh3cjdISE5aMVR5aEZ4VFdlcFExeUhRWGJVdS9G?=
 =?utf-8?B?YWZ3TGx0Q1A5Y1M5ZmVoWmxtZ1VkZFRXOGVMcDdHejhaVERsMHpZcEh5WjlW?=
 =?utf-8?B?N3AwMVByUy9YSjdjRkFXN1pETG9MK1IwSHJ3UG1IWHk3bmpFRWEvT2pqQzZ0?=
 =?utf-8?B?dmJiUDdnelB2TTFZL0gvckwxVHBXR1hydDc4V1BkZVo4SEYxc0poZnFZT2RU?=
 =?utf-8?B?UUs0UHpEWXVNSjRncWFjKzBYUUxUbUpyZ0pkZURYUXh2S0kwY29QRnRIbVVs?=
 =?utf-8?B?VE13elRRSGVCUDY5ZVdPSXJ1Z0xJSm5aZW9adUJwdkNSVXpnVVlQWWE3OHBK?=
 =?utf-8?B?eDVWY2lhQjNTZEtRZS80Y29oN3VlVmNjUFBmWWszZmZkd0Z0eHBmaGg4UXdY?=
 =?utf-8?B?Z1VqY25WYjE1QzFReTB5SHNwR3RmNEZWdlZtS2FRbGdHZEpwZE1lQVQvVWtG?=
 =?utf-8?B?cmRXb2tjeFNSRnllb1ZzTjNNQWh0cEl1L0poYU11bmtHcDg0TytOYkxQbDFE?=
 =?utf-8?B?SjBaanhuWktPbVFpNENuY09heksveUhObi9pMmV2YVZyOWU4ZHRGQ0pzWGJh?=
 =?utf-8?B?eThPK2xkUW00MDF6cVNYUDFGRHBLTFhuZ1pBdGw5T0V2ZTZ3ajdnMkh1VE5W?=
 =?utf-8?B?dDJhOGx4eTJwbUxYOWpHVEV1bk9FVmdFV05ScGpaMVZlUzJqZThUM2hxb3hz?=
 =?utf-8?B?UlJiNm8ydFpBK3R5aU4wNVJXUVF5cXZ0T3pTVEUvbURacWVTM0p3TUwvQi9W?=
 =?utf-8?B?Yy9DVzFUWWZIaiswNDBQMWNFbHlkRW1CNTBpNWJYbEs1RzhhSVlyNGdvMXNo?=
 =?utf-8?B?MFZhUi9xTEwyZmQ0cXBQcENsZUZGVm5FZ0I0dXdZM2hnTjhKY1NVRzhkU1NT?=
 =?utf-8?B?MzBDSU9mVDFWWmdqT2NKc1hCWEgzK0lQc1ZYVEY1dkNJODQ1VGppZEJBa1Y2?=
 =?utf-8?B?UmszWDhvbUo0WmNjUkxrTkk4ZnpqdEgzZmVYWHlkM1E3andLMEFHS1RSZG5W?=
 =?utf-8?B?MmZ4UGs5MkJMZ2hDajZ5RDI1bnFwOVdIbWN4MmdtN3hDMGhHWU04YjJIY2Za?=
 =?utf-8?Q?jrm1O/mL8mrp1rp1sA1TjYw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b33a2e2a-fdbd-4736-c933-08ddb362dcd6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 21:05:35.1194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loTNn67v8+EECYgucc/E4w9NROu/5vb75Qiv++OtuPoZnc73ZwEBlsBVcLPdPqsmArr7IrwzcLp/BMbR5xNiRz/h2c/GGzgC01K+KhyUiZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10538
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


On 24.06.2025 18:34, Heinrich Schuchardt wrote:
> [You don't often get email from heinrich.schuchardt@canonical.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> A malformed FIT image could have an image name property that is not NUL
> terminated. Reject such images.
>
> Reported-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  common/spl/spl_fit.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index e250c11ebbd..25f3c822a49 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -73,7 +73,7 @@ static int spl_fit_get_image_name(const struct spl_fit_info *ctx,
>                                   const char **outname)
>  {
>         struct udevice *sysinfo;
> -       const char *name, *str;
> +       const char *name, *str, *end;
>         __maybe_unused int node;
>         int len, i;
>         bool found = true;
> @@ -83,11 +83,17 @@ static int spl_fit_get_image_name(const struct spl_fit_info *ctx,
>                 debug("cannot find property '%s': %d\n", type, len);
>                 return -EINVAL;
>         }
> +       /* A string property should be NUL terminated */
> +       end = name + len - 1;
> +       if (!len || *end) {
> +               debug("malformed property '%s'\n", type);
> +               return -EINVAL;
> +       }
>
>         str = name;
>         for (i = 0; i < index; i++) {
>                 str = strchr(str, '\0') + 1;
> -               if (!str || (str - name >= len)) {
> +               if (str > end) {

and if strchr() will return NULL, then str will be equal to 1. In this
case str will be less then end, so the loop will not terminate.


>                         found = false;
>                         break;
>                 }
> --
> 2.48.1
>
