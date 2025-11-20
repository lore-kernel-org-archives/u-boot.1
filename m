Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD98CF8564
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 09:17:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C70788409E;
	Thu, 20 Nov 2025 10:17:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="YASZSiXI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DC98840A2; Thu, 20 Nov 2025 10:17:44 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F49883DBF
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 10:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GxtTQy8Le0HcvbJUaChnqLk3wkYQhERUGWq9Ry4oixsf6+HPH/cvVzIZ9BpuTbI7+fIElF4jqko4uwYy18AAzoyayt6BCeETzzdA/niNJD7GMHz0JBphduWxnlyNFliCpQPOd3ybVdCRCaTP2pfZj7uaD7i7mMG8PNz2+8XBvetiBqncdj3RjA49YQYTi5CwIJp0xYvnr4IGgrw9CKhd6sXu17xSieZMqZUYBXEtvcQKAj73JOwLEepRJbopJo252tUvNnuQ8YOP8QmncgOupRzFUJiKZ/JL1lpkS7GYW4dC29Ow3exbnTyEzRp/cReGJaDIW2k/yIKaY3ET9RNHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQlpt90nSYCb4a5xoO492/W6zsKbwN3DXk9ypWae/FI=;
 b=xZo/An3yt15hfqkqf5qK1+nzwTf+OZuZstUUuxQ3x0wGLGhIDxjsYAdgrElLIfr7QL4NG0xOwCkH2o4/dh1l4qi/EKDrPtVzDNl3WzPP03JdIXRu1PpZvWElnx/Fxt2c/OX0CzgsCTwp6uB5T1+3htNeZm8esU/yVqoE5qGdNxafDqopGv7VqfRwVBEO0JVJKsxgTIglhltLdqQpK8vfdOCoxqCyo1Qjbu6PqfcEEcGViRZxQhHmwuC2hEF2+9+mdMhuYnBl6+J2j7CcrQ5wsqnE7nLe/2OC5YpLnCSyjxKahhryBhppQKjAvlaLJAkq6O7FoYdYMrLEa0O5Yb61KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQlpt90nSYCb4a5xoO492/W6zsKbwN3DXk9ypWae/FI=;
 b=YASZSiXIDwi6gq+z+4Lt9ThO58W5opeQeJunjzKBjryQWEm6DOuKCT3cIWx1G/aMNZMTQjG1TXiKpgnIvTp8hOWloJfpyU3tc0pNIbZB4TrPj5HzhKJOMGmy4wiVCh9rib+m5jY7yCSegfZj+vjgjqzRWQdmQlyT4i4iV2Pf+WbGDciRDUb16BSzbcR3VIChRsSa+rfv8nd6dpx07L4PLBv6Hz2k/rLIvNL0ptjuKziL0iODAg8fUCPm5Mg6WtLnjPvgzWtJV69ivfRahFKtJ9r48YexKhMOvpChY4Caif8FsJHdNYNbrdKUgW6xFYkMYDCHOjxHenrb3e8hECN03Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by PH0PR03MB6576.namprd03.prod.outlook.com (2603:10b6:510:bd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 09:17:37 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9320.013; Thu, 20 Nov 2025
 09:17:37 +0000
Message-ID: <eed1e1f9-b07a-4dd2-a7e5-195778889a55@altera.com>
Date: Thu, 20 Nov 2025 17:17:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] Add optimized Makefile support for SoCFPGA handoff
To: Sune Brian <briansune@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251104223023.1613-1-briansune@gmail.com>
 <7e31b494-1ce1-4fb5-af49-d203830add7e@altera.com>
 <CAN7C2SCBqEajYv8v+meudRN439MeiEGnW5c+eUbMWFL0rcVoWg@mail.gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <CAN7C2SCBqEajYv8v+meudRN439MeiEGnW5c+eUbMWFL0rcVoWg@mail.gmail.com>
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|PH0PR03MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: a30cfc3a-aeec-48d6-0d8c-08de2815a5b2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlFPSnBUbjJiemE1Z2Q0cytCT2NabzdENEFaNjJJZHBaTWQ4dVBQaEFOLy9u?=
 =?utf-8?B?Y0J0eGtVeE4vekZ2N2tVdittVVYwWEN6azZiUVhyMzNzV1lFaE1yYlpmN3pE?=
 =?utf-8?B?bkExVjdiMjFCazdDWE41MzF2SllTK3QzenRnSEthTTAvaUJxZWdBNFRsTFBo?=
 =?utf-8?B?azE0SWxJVEpPVmRnSlUwR1dzT2hwbnF2ZmdXaVg0em9FR2VHaFNPNWczK2x4?=
 =?utf-8?B?U0FJdy92NTYraDErN2xqQmw2amY4SFNGY3pnVC9Ca3FKaWkzdXJqY2tXR0NL?=
 =?utf-8?B?UnkyQm9nVW50c0NaOFk4RzRDSFYyZTgvUHR1SldmVURQMWhqaEZvUWI4REli?=
 =?utf-8?B?c2huZy9wRnpoYTZjZHl5NGd0WldlQ01mN2FjM0RSSUdaTUtabWVaa21jTTBt?=
 =?utf-8?B?a2Y2bGV5cXJlZ09vaGVDajljbHVCeGdSQUhUWXhSby95MUhiL1FWSEUzSDFJ?=
 =?utf-8?B?bmViNUlSUlU5ZURrS3RkbklYOE1zSHdvOHYzOUx5MHdTMzhmOUFhbElrMi9B?=
 =?utf-8?B?UGJJUkJmZXZ0cmJKeEpQaHQrc1pTd3RxeXUzZHFwdFEvYU5uOFI4T0pWdWc4?=
 =?utf-8?B?QXV6eUdCd2wyU0w3UC95K3RPbERyQkRialFBQUJSbTg0c2RrbUd2UW9Lai9D?=
 =?utf-8?B?REtWcTBmQ0JZYVM4d3FMV3FzU3RvcmVMVUFUTkw3TmcwRmdwWGVrRG10L0Nw?=
 =?utf-8?B?M3R6cVM1ejAvTDFtd2VJeWFRemRzTHpnRHREbkZrSjM4UGlSdU9lb1NmRi9j?=
 =?utf-8?B?VStRQndsemxrN3YrSGg5VWVBNmRBeXlNUEU0MkN1OHhlZ000eENOYWZkek1s?=
 =?utf-8?B?aXQ3RmFXa1hZU1ppRG0yOUVqMGZIWkdGeGNibWY3em1xd2JRbmsxZ0Q3Tmdl?=
 =?utf-8?B?R0lodkpJZDREQi9maUJ4eFVRQ2FkNWJBS20rQzBhQXFqalBxa3RjMFdkZWtV?=
 =?utf-8?B?NG9Qd1N0T2tMdnYyajk4Z25yZ0N6UW8xUDdpU3U2bHZKQ2I3azhDNEhTUkps?=
 =?utf-8?B?ei8rNzZTa0oxbW9HYjR4elEzTk5OQk02YjlaWVNuKzV6YUxwZWZNR1VmTUwy?=
 =?utf-8?B?aU5DR2F4T1FzMWVHeW1UMkRsaEs1V2tnLzhzcGkrcTdtdVJzeDcwallvUFl2?=
 =?utf-8?B?d2E4VDZhS2VRSDZNK1YvUlpqenNmTDVKTWFJbE4vNCt3K3ZJTW9xQTFBYWh6?=
 =?utf-8?B?QWRja2o1a1A1YWtIcWJTTzQrVHNZVXBHSld1Y0R6SGlSMk9CMGxiK0ZKb0ZX?=
 =?utf-8?B?a296czNpU3R2MFpJaFhvWGlGYUM0TEtyNGpvNk93dU5sczJPdHpuTzR6clh0?=
 =?utf-8?B?M3BQMzZkWWRWMGZTZThhZGN2clQ4QkhtV09XNSs1RS8zOXBtWmYwb1JtWlBi?=
 =?utf-8?B?OFU2c3V1V0pFV3A1WEtaZy9nUWJHZUdzRHFta3F0TzJwd2tWV0RSclp6d1hF?=
 =?utf-8?B?OXFPMkRYZ1FHWVdpSHA1S2cxZUNsTTNzU1hrdS9tRmZlNFpwTnJEUzE3VWha?=
 =?utf-8?B?dlFxMU1SVmxyL3JqL29zVlRRdDg5KzNSaHl3aXlBd2N0YXNTT0tqUU01RVEv?=
 =?utf-8?B?eWhkeTlQclFZNmd4ZWp1TFBBRXlLTkVNMklvZmpBZkNXc3JFNm1RWjUrQW8z?=
 =?utf-8?B?UmgwaXpGUllYQnJORGd3Sldld0dNaXRlK0xWMWVwamxpaS91b3B6NDFQOVls?=
 =?utf-8?B?dEpuc1hZY1VxZVpVQ3pKV0wyaHJBbzNaMTUwTXh3VVF6RHg2VDlvTVd5NnNY?=
 =?utf-8?B?TDZpVDBEZVBlRXZzY3ZjWld3YWdNd3hzRnlkSStnY3ZOOWk0RUhtYlJZY0NK?=
 =?utf-8?B?b3Z3RzNmK2E4cFBxdCtOV2hwaTg3VFlkdERMOXRTZGppOHNSelVrc3pENHh1?=
 =?utf-8?B?d0hqbkIwTWlKUkwycWZCcjRZb0liZ2NDQjA2NFVGSjhjOE53RldyMGtpRjRX?=
 =?utf-8?Q?bin0znDaQZPZ/trFhPNFFzyDAz6zePof?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTlXdFZqUFFZdENRVFhEK0lmQ1lyK2hhWnhqN2FkQXJST2tQdWJ4N2lWTWc2?=
 =?utf-8?B?OUFTQi9PQUwxQStOOWVabmRTT1VBUmpGYnhGMGxhOWxaVWdMcHlCMkl2YzlG?=
 =?utf-8?B?bTNneXgwOXVCTmtPVlVOQ2tuenpHcDl3dlNGTGpwdmY0SEpOeVUvM0tjbVRP?=
 =?utf-8?B?aGdzTUlMbUcxMytrVXFDZlV1WENVRnZuVE0yakxIcWIrT25WRUl6a2lQRUJj?=
 =?utf-8?B?anRCYVBZMXZlOUVJSUlyMmorOGhsdVdGd1pyeElhMnlmSXdZTnlMQVVDMW5E?=
 =?utf-8?B?N0FadHN1WkRTczN1YWlFOG54YTdBaW5pdTNTdURRcGd2eTlSYzJEYVlGVUww?=
 =?utf-8?B?Rlp3ekxVQll2S3BIS2NPTkhVVDVZWHlmMmpFZWx1ZGZ6UVJJRUlRS2FYZ1F3?=
 =?utf-8?B?VWlFenMxVmJUdWE5V21KaTBJQmxqdEUzMEtncG9TYjgvS1RtV1FrK1I4RUNH?=
 =?utf-8?B?OEJXd0cwbmRoL1h0WkIycFpOSjJ6RkF2V0tEUVd3RVhqWjZLT01VeWpPN3dt?=
 =?utf-8?B?UFRRS0I2cFhvdXJFRjFBeGg4TjNESDE4NU05UTZDSWRhWDFPM1U2c25vY2tl?=
 =?utf-8?B?a0ZPMWhsbHZ0QTNPVEdxTjN4N0lUSGFHSFlRcG9wM2JKL3hkWGJGVnY3Ymdl?=
 =?utf-8?B?Ly94Zm1NYzFlS09hWkp2RWowS0tOcGFjZXV5NDUwRTI2dFRaQ2pQWU1rSHFL?=
 =?utf-8?B?ZXI5VHc2aHljUHVLRDBtSzdoYW80dTVvb0k4OVUrdmVDUkhVaWZkeGlpRGlP?=
 =?utf-8?B?b1Y3c1pOcW45T2pFd1drUDVKNS9IUGx6cUdmdnRJcGluVytFU29OZHhaMWxC?=
 =?utf-8?B?REd5Q2d3ekJGMTNQYktjNzdxZzFxNkN1SDlyQ1VjV0xKVG1vSFFHL3M3bHBa?=
 =?utf-8?B?eDV1OXNlU1p2Vm5JamdDbGdjZENkb2hYMlN0RUs3UFlOd3hITWtVUlJOem9q?=
 =?utf-8?B?NFA3N2c3Vm1scDBlL2pjVjQzMzQ5dmV6dUorVmR4VUk0VnpkSE9tbmYya1lW?=
 =?utf-8?B?cXJkNlRBN0h6UmJCMC9iMGxVUnpoMU0yZGpqeTlJeE8wNlhpeTBZeDc3dWd3?=
 =?utf-8?B?bFcwR2lIanhJUndQU1FjZ3laUjlzRUUwRkdaZkVtYVFFeUZ3VXQ5VFZUTzBN?=
 =?utf-8?B?R2RHc3hjNmo0S1c1VFQ2SytnT1ZsdlUxakNzenpTTGJta3FDQ0NFZmpxR1NY?=
 =?utf-8?B?UUxtUzB6MSsrdnlvajZyQ2ZTRTVrY0o5djdScTh6RjNnVFo0akk1b0lpeXpD?=
 =?utf-8?B?SzRDWjZiSkhRUlNvRWdMV0RqaGs3R0dqdkhtdTdZd0ZkcmoxR0trd0dyVGhK?=
 =?utf-8?B?bHZOYXRsRGxCN2hCTWdhMng3d0ZvTFVHaVB5aCtwZ01mbWxRQWZjdTJFL3Vx?=
 =?utf-8?B?VzlTNmMvR2o0bHV1RmxrMjU0eDl3cU1yaFc2TnFDaTVtb1BLZTkzOW9rOXdE?=
 =?utf-8?B?Nmh3UVArS0tNM1dwenNlT0dob0lrQmdRWC9jWEFuOCtxb1lvRlk5NExFcVlY?=
 =?utf-8?B?TkNIeWRoQVQwZ3JoNCtUWGVwR1ZmMGJQRVpLT1hPOURVRmZwQ09UeDlXSExU?=
 =?utf-8?B?Q1BDclNvZmQzdWx2L29rMFJYNWpFQ010b2phWk4zSGV6ek5GakJwa0xIS1FI?=
 =?utf-8?B?V1BlaGhRaUx4T0tsYUxLUGR2VjlOVmJVTTVhU2ZFVGlYdGpjNitLZDFXSGZ1?=
 =?utf-8?B?R253WGNLQWhHaHhFRnVnODdpaU9Dc3o4OGxncW1ZWG9qYTJGZW42ZTgxeEtV?=
 =?utf-8?B?a1hPWnoyYnY4V0UrL3JkV2U2M25oUnVXbmpBVUcyZWFIRGNqWkNINmlqOWNG?=
 =?utf-8?B?a0NGL0h2STJhdFA0RE9zdFB0SjFjSFlMcERBTTIweW9RWC9JdCt1dy90N0VY?=
 =?utf-8?B?UG9seGRiRkJaT2NweWF3OEQyckV3MW5tSHVXRmhtZVNQbWROSVdiSHByZzdJ?=
 =?utf-8?B?a3FVc3E3eTdpR1A5b0l4TGRWR0JHV28wWTl0elFjVEJrZU1nai96TUJmODJi?=
 =?utf-8?B?ZW1ZT0tQdmF2VktFS3pMUkNEaVNNNVpHTkxmSVU0UlNBY0l5T0lYQ25oYzd6?=
 =?utf-8?B?Qk1EZGVtZ05nbnN3Z0tjWGc4VmpHVVNleEROL05pa3JFVDIwU0pRYjRTVi95?=
 =?utf-8?B?bFdEQkxITldRemx2UTNNNW1HTmpQZXJaT3o2UkFZeElnTUlxSzZvbUY5Z3BQ?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a30cfc3a-aeec-48d6-0d8c-08de2815a5b2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 09:17:37.6937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gApK78o5WM3qPs7d/5eeRwp5AIsM89lOVFb6DKme7I+VM2fBg3SR6VY90EMQSAIL/9LmHuR/gH4TEzdWATXg2IZzKg1ChV//M1b88+nmog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6576
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Brian,

On 19/11/2025 9:08 pm, Sune Brian wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
>> Arria 10 boards require the A10-specific filter script under:  arch/arm/mach-socfpga/qts-filter-a10.sh
>>
>> Invocation pattern: qts-filter-a10.sh <handoff-input-directory> <output-qts-dir>
>>
>> It processes a set of A10-specific XML and RBF inputs such as:
>>
>> pinmux.xml
>> arria10_hps.xml
>> pll.xml
>> emif.xml
>> core.rbf
>> other Qsys-exported XML files
> I had provided new patch and removed the A10.
>
> Second because this is bash script and according to
> what the new tools are supposed to look like.
> Python script is new tools language and should be
> followed accordingly.
>
> As such I will not going to merge A10 to this build flow.
> And any new family handoff should also put to
> the same location as Tom suggestion and also
> make things more clean and better on manage.
> u-boot/tools/a10_bsp_generator.
>
> Meantime, I think it is even better on generalizing
> one folder for all Altera socfpga tools, with
> requirements.txt as well.


Thanks for the clarification.

Understood on the removal of Arria 10 from this flow, since its handoff 
mechanism is different and not based on the |.hiof| format.

Noted on your point about keeping the tooling consistent. We can keep 
this in mind during future clean-ups.

All good from my side. Thanks for the update.

Tien Fong

