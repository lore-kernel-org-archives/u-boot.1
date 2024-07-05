Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEC4C3814E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jul 2024 13:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0F69889F1;
	Sat,  6 Jul 2024 15:37:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=genexis.eu header.i=@genexis.eu header.b="O6IinvtK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6F2488905; Fri,  5 Jul 2024 23:16:36 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F27578842C
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 23:16:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=genexis.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZA/Q5FMfhOEIwuKE3eKBa2Oekr84UOs5ri6HZ27wgkYZaE5ULWRWbwlIZoUKTcpTvX4XBwsPQH8wUmlGM4hNoMQbIWKHZHnyUQBFwryuAt58ilGbg8IG4r02gYFtOA5ZtQbe9U60Xpl+8axsvoU1DaAJ+HcyIAbDikIiaWlxXyN7SvM7AEIuxHxLoL/Go1465fUmfj3UzVTU7R9AstK0G683GNPYoP/Facrg4VHfkIXc4Shnm1+VghmptfxvX8nMwwpOknFdpP2QYb3wYx7+ITlbTsStPIiO4dfU5Yr/pvwFSLzxm1dqLXYfEFs3uY4AiE90Frsd2jc0yWsbgsDPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ty/Zj6b3VloD/lx0d0ZC4hfa83lj7p8WJrnIkgRRsuw=;
 b=nFnIYEVygU01kN1YwOfRqCbeoacd11odB64AjL11HE1knp3LjyfkZuQlH7RTBY4YuEXYklJTLyF6s6NclHaeuF3faj/koCBMEsDdoDnjHGo5Xa7HLUTXpjpb2+N/FdD5yldysEnOfQTUWb3JDG46PWVEbZhYJIq6ifS611fiR9heyvWumibuQ5gdBkvu2Q7oSJvBhl/1wq5vozlU6I3MY4tkO6R4WtNf+hmEMTwtWQS4Tzupot5EpZ5FYJCMGM8+537teWSXIhbf6G13KX85gUFatBfgXcebGeS8LDlRgpQFYzJDXgYChCKkxDk7IzaVocH7iIj0LBa3ZECKx+bohw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ty/Zj6b3VloD/lx0d0ZC4hfa83lj7p8WJrnIkgRRsuw=;
 b=O6IinvtKFxhimIYmg5IGvtuyFqJNq+ynAXIBcKyn5OPvQWHZ11JfwxHv/7hSGzKXSmI133EuhlE3/fg5WQt69vGv7YwdTh80b6S9JDmMFQ6SiO77Bt0z8eYS9N7lBihA2KFGzqmfOm1ph4qndI1Zh2Gxy4ek//0LrqQpZXEzE0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5715.eurprd08.prod.outlook.com (2603:10a6:20b:1d7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Fri, 5 Jul
 2024 21:16:31 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 21:16:31 +0000
Message-ID: <f0b0749c-e6e7-47b5-8cc5-82d19115f97d@genexis.eu>
Date: Sat, 6 Jul 2024 00:16:26 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] net: tcp: improve tcp support
To: Peter Robinson <pbrobinson@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Marek Vasut <marex@denx.de>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
References: <20240705150431.2274662-1-mikhail.kshevetskiy@iopsys.eu>
 <CALeDE9OrLw4h_iZKb=1BFHUJKPLrPFirVwEb67ynh7dFNJV0Sg@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
In-Reply-To: <CALeDE9OrLw4h_iZKb=1BFHUJKPLrPFirVwEb67ynh7dFNJV0Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0176.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: 06fb89b2-d71a-45bd-b398-08dc9d37bd93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHdtaU8yM2NTUzFKL2s3NExsT0dyVWdpREd2aUpyMGRXM2ZWU2dRdmZWODBN?=
 =?utf-8?B?V0NRdUlmQU14bGNtZ0MyYldTNG91UlN2WE8xaCtIOXlSVkNCWG45R0g4eklJ?=
 =?utf-8?B?RkljclRjdGJlMlBLZyszWnBSTmZMNmNTQzc5ZmRLV0x2WmZvZEtuRWwzOGF0?=
 =?utf-8?B?bHNhUzNGckR4VHppSFk3SDhYa2JzNVluSHZQSzAzR2xSRFpQMDJ5OU5DbCto?=
 =?utf-8?B?R281Z2Y4d01NVmp3SzJWUXBNdEcycXBvLzZ1RjEwSk5aZ1p5MGd4R0xEeUx3?=
 =?utf-8?B?cCt2bkZ2Y2R0bnFMMmtRTGNCWWREM1g5N1ovaU9QMzlqK3hIRUJmTDBmdFA4?=
 =?utf-8?B?d2JtSm9LTUt5cG9qc21RWURGLzNHNWY0TlloSGRzY05kdWdoeGErblM2dTVw?=
 =?utf-8?B?VmcrQldYQUZoMzErNEE2TTBYcDUrZXh1eUpDdERqZjFaZTRFNk5yZ2dGbFVG?=
 =?utf-8?B?MTRWWWU5UmVXaEtsVFRNVG5TVmJCN2J6Wnp5alR3TExEWG1oSlhYK3lyRFNR?=
 =?utf-8?B?MkFmRm9EQys0MlRjeXFXOURVY2lLVWhEQnN0b1Nyd1dvQkxXbzNBK1VxL3F1?=
 =?utf-8?B?R3hLMmluYjBNNkpaSWY5aXJHcFptemFsYm1TL0QvTGVoMVBwQUp6TmFYa0Yr?=
 =?utf-8?B?a01zVnJsTjZudWVZV09HNnpSMmVodGthUWNHeXh3MmNEc01jQmxiTG1KL1V5?=
 =?utf-8?B?L0NzSThDbGhQcndJWlNZNjBkNGxZYWI2dEd0ZThpOU54S1hsUUo0MmJobXMx?=
 =?utf-8?B?MFhjUlpMc1Z4V2E4dEhWWmVNZ2kzQlRrWHpxOXZqanYyVU5NbUM3RkZwZWZn?=
 =?utf-8?B?TyszK3UrZkVBbWlJdWFOQXFoWEhteUxYb05ZbEFjZGhOVEd0S0dKVWNQc0R4?=
 =?utf-8?B?UUVpbncwbWxCdCtUN0NEdjB0WW91NFRjYnVBMUthMUx5NXk4MTdpT1o5UUtE?=
 =?utf-8?B?T0FWNHE1RzUraE9Kd0tXajVHQmxpU0tYUUpNQmdSWG5jdWtpMlJ4aVlCNWQ5?=
 =?utf-8?B?SkFKejhNY0R5U3ZLclJuZDAwQ3pwZ3RMK0lFWFZvc1FsRWN0eTd4N0FJSUNU?=
 =?utf-8?B?Q0l1U3gwT2tob0k2T2psY2gzUEQ0R1BxNENXekNSRGpUZHljbGVwYnRYclQv?=
 =?utf-8?B?RFFJcWJhSXl0dTlHQzZuQTlBZDhDS2hIa0kxN1VJbm1PM3RiYzI0V2dCSk9G?=
 =?utf-8?B?YXdHaTcxWmptTm0wTzlCQjdXWlhqZFBSUUN0N2RHY0plaE5VY1Z0T3lXQjdI?=
 =?utf-8?B?RTlDdEtLTTZuWUtjYy9CaG1sR0ZuMnJKU1ViOC9CM0l0VGYxZFcyMnk4aDFQ?=
 =?utf-8?B?RlpPMUVHMW02NjdaTnBlV0lFclNTNVJ3UlkxZ0M3RGc3ekN2am9EVms5Yzl6?=
 =?utf-8?B?R3BJU3NLREZ2RzJwQmwwdTQwSU1UaGpBaERiZ2dnMG44dHFuUHk4VWxGc3oy?=
 =?utf-8?B?Um5hdktlYUVOQVlBZHp6NkJoU2lZbmpyV1RLTFB4ZE5uNHJ0TUlLNG9vUDRR?=
 =?utf-8?B?U2hsdXFSSEhyc3M3TUl5ZHRQNTYvcEdrdktVODdnZERTK3M1OStwRmlJUnFh?=
 =?utf-8?B?b05Md1F0UkdWQ1VwYldrMEh3YXVUMm1xbXZUOCtSWHgwTjVEbXl4V0JPaHVT?=
 =?utf-8?B?UHhkNmdRM0dmNmQzaXdqRklxbEx2MnVOVDJnTzhwYm5yak5CbDVQbkhHQUF6?=
 =?utf-8?B?WEx5LzA3MWpaQ01ZbEVKaXIrbjhHcVNCL3Bzc29iU05sSUpCckcrUHF5OTFZ?=
 =?utf-8?B?M0dCRDZFNUhtWkh2TWxOaTFWQTR1M3ZOVXFqS0pQbVk1ZitoUm1Ud1M3K0tP?=
 =?utf-8?B?ZWRTVTlqQlNyNXh1MjhxQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmZHR1FQMnpZZVFwZ0Z0d2hjZFl0R1Q5R0s0WmFDbjFxZ0FPdm41RGdKMnQ4?=
 =?utf-8?B?RUY3Qk5EbmJ5WTYzRVpQVmJyTkFsa3ZaUFl4ZE04RFREdFd4NzF2bVJabEdK?=
 =?utf-8?B?SVJYdDNNU3E1YWZIcVRzNm1GUEhPRWd4b2srTjh2WjdnRVVvOVF5RW1DTGRj?=
 =?utf-8?B?b0RHTFZZUVl3Y0phakViSFhYWnhrSE96UU9YOTJqTEZwZmJERVNLd0I4aFpr?=
 =?utf-8?B?d1o2amVnVWFRcUdlOGd2WkU0eFNrVCtLckhzOGI0dnF0ZTRKdisvSVZCTzc4?=
 =?utf-8?B?OW5ST0srQ1RxMjlKbEFNUDlVc1dmTFBzMyt6SElrQnJVS2IrVktDWXFhNHhM?=
 =?utf-8?B?Y0Y0ZUJyU0k3eHovMlc4cDR2am1KSWRXMTN0OFI2MG9TQTFyTEZmeTh3SW1G?=
 =?utf-8?B?MmFWRkc5WUNNRG5PNlBmbFJ3ZUNFYmdQMkxybG0xYVhvcklmbGQyejRnM2V3?=
 =?utf-8?B?RllLTVhyNlI2VG5PSjBEYmcvY1JDTTFydXVXWTZoU0g2S0hEMEt3QUM2ajZm?=
 =?utf-8?B?OHJIeUZveWUzQ2V1S3YydHVNVVJtVUl4NEMzVVlYakd0SnM2TnMrZEdMWGV6?=
 =?utf-8?B?SUtOVWQrSVJ5azZSZCtEMUM2ejdsaWFjeFBEWnNuTzNKRDNPN3Y5ODNlSjFN?=
 =?utf-8?B?bFRzSmw4ZlQwYkkwZTg2blNrTTNWelJKRDUyVkpGOUVUOGUvL09UY0pBQU9v?=
 =?utf-8?B?b0FYQ0taSkw5WXNtMG9xOWQxWTNaSXhyMkJMSTRrTlNXd0oxeDEyMmRnelQ4?=
 =?utf-8?B?Y2FZaUQrOG9hS1FuUmdyWUJXTG1FQVhJSG1KZUpEWGFqV1dDTFNqK0NydG1o?=
 =?utf-8?B?VXFZQmRBdjhIM3JJSUdtNjhtY0h1UWk5bXhYR0ZLZVFWK3l3UURZMGJPZHRI?=
 =?utf-8?B?YUxhdCtuKzdkR0tFSUpDQjZIaGQ3STV0ZUswdGNUSHJSTlJ4K0I3K0dIWjNW?=
 =?utf-8?B?ZTZvU1JpYTJhUGFjT282bzlnTGpyMGVZZnpEUGpYVmVYYk5XN3g5aTB3WWdL?=
 =?utf-8?B?Q0htQjZ4eFM1ckxNNlJrdmtrUGxsNjRPSGFERjl0bDJnRHdEK2V3eEhqdGtQ?=
 =?utf-8?B?MzQ2WitkN0tGcXNscHVGL0UxcFhmekVCcUt3WmlpQ1RzZEYwMDJNenhsLzg3?=
 =?utf-8?B?cVV0OGZqL2FPQWtpYkFXU243d05LNTlWMzNoSU10cTBEL1F4K1NBTHdsM244?=
 =?utf-8?B?RElyaHJPNDhBa2xBMDBTc3Q5N1NwRXlCK2Z2SUlzZU5OMWp3VmZyYitXekRr?=
 =?utf-8?B?ZE9DQkxIY1JwUmRISWcxTEpYTjBzaFpGWHJCd29MekI1UUl5UnVjVHp4NnJB?=
 =?utf-8?B?RWNhRmFRV1VNZEpLVzc4aWY4d2RoMHVRNHpsR1kzZFVwajBERXVqbkRLMml0?=
 =?utf-8?B?aTdublZCcDBJNWM0VjBxa0E3TStxb3Fab0hYYzVidDhwbHVFdVZwaGl5ZlBm?=
 =?utf-8?B?M0k2dVhKVklGNm5zblM5OWMwMTFlWlZKb1NTQ3I3WnJpblpwNnRUYlJFY1VY?=
 =?utf-8?B?NEMwQVo1NzhVOVBpZnByVnkzK25sR2NFMWVTN0c3a0psQzlZaitUWnRtT1cw?=
 =?utf-8?B?bjRNWVoyUVBqYXIzMEF6NWtzNUN4WWFrMXJ4bVE4aCtVMEttdDJ4UTdBcEds?=
 =?utf-8?B?eG9tVHZqcXlxQ2JoWG4rRU9nZDlrN04rUm5ieUNUNEZIOVlOYnBWZnZiWXpP?=
 =?utf-8?B?bkFQM0Jzc1dPUWpRaTlCd2FiS1dRN0xhVktrZitHKzJGYUNyM0ZGSGJHNlgz?=
 =?utf-8?B?bzhwanNEMlprS2pQdWVKOGpleTVWY0VUZmVQazNLQU9QUHhXc1RCRUxqZ2x2?=
 =?utf-8?B?ZWpLSjVrRFFuZUw5NHZRY2UreWRqM1ZiVHRURkxkckRrQlJCV2s4REdJbHYz?=
 =?utf-8?B?eElYeEUxb05NUlFMdWFQRUdOTDh1bUNYMEtER1BPNDhtdFZsL09ZRTdrempt?=
 =?utf-8?B?ZDJOMlJrUnl5azBCWU5yQnlkOW5OSjJzK1RMNGJPVEZMWkNia3F6QjhOQzhl?=
 =?utf-8?B?c0crUU9VWCt4OStQSDhHU29Kcy91UENyS0l3Vm1QUUJiVDJxMzdkbkNUUjRj?=
 =?utf-8?B?SlA5U3pwVzN1SDRZQ0Q2by82NXFtUEpRNklOWlBIWDBNQnU3NStkSGUycFdV?=
 =?utf-8?B?Zm5EYlg5ZmNHZVJYekx0TDc0cUdwbm94RTV4WnJNWnFQNUphV2RTVFdmVWpo?=
 =?utf-8?Q?JNDaFwxE6c4lw/8ZEnVCOEg=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fb89b2-d71a-45bd-b398-08dc9d37bd93
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 21:16:31.1391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50LkVGNNikmVqeR00TlDsv7tbnO53n3SCp1Ia7RHvZmY5hDfXDyoUBZlqYYGb76V8tzySH0maLRZt37zyzZus73CYdLNnSx9nWPy4apcaFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5715
X-Mailman-Approved-At: Sat, 06 Jul 2024 15:37:18 +0200
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


On 05.07.2024 20:56, Peter Robinson wrote:
> Hi Mikhail,
>
>> This series of patches greatly improve TCP support.
> Where's the changelog of what changed from v1?

no changes, just remove some patches and add a cover letter


>
>> The benefits:
>>  * a lot of bug was fixed
>>  * tcp cliens becomes smaller/simpler
>>  * fix data uploading (now it's possible to transmit a huge
>>    array of data from the board to external server)
>>  * data downloading/uploading with netcat over tcp was added
>>
>> Mikhail Kshevetskiy (9):
>>   net/tcp: fix TCP options processing
>>   net/tcp: fix selective acknowledge
>>   net/tcp: put connection specific data into a tcp_stream structure
>>   net/tcp: add connection info to tcp_stream structure
>>   net/tcp: rename ack_edge and seq_init to more common rcv_nxt and irs
>>   net/tcp: improve tcp framework, use better state machine
>>   net/tcp: simplify tcp header filling code
>>   net/tcp: define a fallback value for rcv_wnd size
>>   net/netcat: add netcat over tcp support
>>
>>  cmd/Kconfig          |    7 +
>>  cmd/net.c            |   34 +-
>>  include/net.h        |    7 +-
>>  include/net/netcat.h |   20 +
>>  include/net/tcp.h    |  227 +++++++-
>>  include/net/wget.h   |    8 -
>>  net/Makefile         |    1 +
>>  net/fastboot_tcp.c   |  190 +++----
>>  net/net.c            |   30 +-
>>  net/netcat.c         |  159 ++++++
>>  net/tcp.c            | 1253 +++++++++++++++++++++++++++++-------------
>>  net/wget.c           |  479 +++++-----------
>>  12 files changed, 1538 insertions(+), 877 deletions(-)
>>  create mode 100644 include/net/netcat.h
>>  create mode 100644 net/netcat.c
>>
>> --
>> 2.39.2
>>
