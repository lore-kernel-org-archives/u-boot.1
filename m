Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71595E64A87
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 12:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C18F388BFB;
	Tue,  3 Dec 2024 13:38:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R/FmghjW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 110C7893AE; Tue,  3 Dec 2024 13:38:30 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBC04881FD
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 13:38:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJzOCLhzRL09rLRqIqsHvbHKbsc7UYCHMMHPRD/XlBZgc+U9lrxyRKq/Xu6KHVglB6RR6kEmDh9dkGzDk8wmNP7DCR/Y8r6ZiJ7xkgOBpXODg6oZiRYoWiSxidehrXA6H8j8jfaFzPsgoU0an6zlacH11PUlueVCRAYUTYXpGy34U4Sa1Iy6ZjbvUSSO/JWUUMPKf5oKAVxsLarukFugv44vV3eFVA/xeTNzonHzcDG4nyAn+NJK0iIpmdKnj436VDYOvDcrD30mdYu3yUTNfBw4tI/KqrXtLeWbl4fWwe2XPljxvbTH+KG8jC4Og7Gh393r1aSFlkf9UmdJQZcbeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btJSti9DCQZJdemPqizh9mXeKgebTBhZfNPgSmgBtRw=;
 b=uBanqBHYPj8biEM61YUc+uW2rU3QekhM5Y6Ypmrsc2pujpjYzDKrUwpqT0vkEt3AzWXeB9BRTbwg6BO5V7d4u9T187193L/LAdeg0UbPiA98l0jEHNmbVK3GEXxCHtR1kwm4t1aXWJOHPn6sDIlg1Vwdw5ANaF+SG95Q0k/k5z8xPhPEKkIe++H272rS64i4kJBuJEcXsdbIF8ucwOcEX/2NolfarceQB7lj0gFM6qRv8LFWFB7I+rLZh64PLYQwOTqDvYddJZNNqkO4nRb5mAXadGHiwCGJlvkg6m6A59h2Vm1rBecrCswGYFafpRCAqj8wxbtvR4gkgLJqX8G2ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btJSti9DCQZJdemPqizh9mXeKgebTBhZfNPgSmgBtRw=;
 b=R/FmghjW4ZzFKcapZlp9Qnj5tAcuCOY6hogJiZWdcFteRBprsTH2fuRRKNDBuBZXni3+NlKna9T2HYH2MVRw54XUaiZqjjl55OTPqCOp1sgcFgCxZL/qu7TjWielLVbru8RtH553WvM8m4N8qjDBGHtOP4zv8PulVxFAZq4DRtMcjflUUggi6sJ6FleBehFezw25iTnOlx/8sQpeLJOVskNYtYfFeRFl5mOWIl+vDUzhe40ZCc6Z4yhtvidTUGbtyzFUb43m47kQw/AASDxnzSAxstf8QcJ9ilmwo0GLWWz0eIRlgbaTaFPeSFV4DfdBpz5GIRomNHgKXvcMIEvxLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBAPR04MB7351.eurprd04.prod.outlook.com (2603:10a6:10:1b2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Tue, 3 Dec
 2024 12:38:26 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 12:38:26 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 Michal Simek <michal.simek@amd.com>
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] smbios: address build warning
Date: Tue,  3 Dec 2024 21:42:57 +0800
Message-Id: <20241203134257.5067-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBAPR04MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a8ba5a-6d8d-4979-57a3-08dd1397618c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmgvVzd4VS9SS3YwaEdOdC9uMUFXVWg0TS9IT1NoWVVaZ2c0KzN1anNKYkRI?=
 =?utf-8?B?aGpES0ltVStSYnE2bVZsSzJaN01sRjRYVFNVTE1oTEcvUE1Pa21MRU5VWWtN?=
 =?utf-8?B?TXk4dHhqSDlVMzgxdjN4bERSRW5mWkQrSVFoS3AzYlozQW1wTGQxa09mOW1t?=
 =?utf-8?B?cms4TVU1QzBiSGN4TUNSOEI0QlA3TVQwR2VEa09PeFE2T2p1L1g0WXhUNVA1?=
 =?utf-8?B?R1VIL1M4bEswWFpGWVVVRWdNTitUcnlUUjNuVkZIcDBhczVsNXArSytzdGZ6?=
 =?utf-8?B?Mno0Y2Vzd0wxU00wY3FzOWVuTURsV25xTTBmcDd1ZlpUOXprOHFoQWM1VWF6?=
 =?utf-8?B?S1luS1NnVHl1bWVPekJFbERpMGJKRHdET2UwZGlHWVUrOW5waytaanFoSWpS?=
 =?utf-8?B?QVJRWmFjd090QW10T2VYZTBENDZESGY5d2dMTDg3enpKdStDWWZlN1AvOHlR?=
 =?utf-8?B?a0JUS0NRZFhKLzhHRlpqb1VwQmdQeEQ2VWVOUnk1dm5SQUFQOUExbWpDQ1Bs?=
 =?utf-8?B?SDVwV0NlOGtiL2hWVklwOVFhejJVRHd6MGRTci80MWl0SFV6SkdwdDJ1VlVE?=
 =?utf-8?B?eWdQOU8raUhqR0tlY2tFVUZyRnVacEVSNnRxelhkS3ZROU8zbVFUT0ZsVURP?=
 =?utf-8?B?VVplQks2MFlQaDFxSkd6RFhCTm53WThTdlk1SWZVbUNxdkNmVlBUMDhaQVQ5?=
 =?utf-8?B?ZlZjSVZSUnIzSExFREhhY3NyaHlmaDRORDFEclVYU2ZBQzdmTVMyQkVpV1Aw?=
 =?utf-8?B?TFc3R2dCcUJJNk5jNlVlSTBXVStwamV1QVJ1WEdnSnN4Y2xhZWJKcjlXTWVX?=
 =?utf-8?B?L3NtcHhOQWVCRG8vSzFFRUFjb0JFL0dtQTRGb1JOMk1jbXZiKy9BbFRwS0l3?=
 =?utf-8?B?QkJvbmR1M3Jub3Q1cHN4M3pmb2dpYlVtU2Q2WjYxVWswR0pCNmtScWtlK3p2?=
 =?utf-8?B?NHAxSUQ3QWF0WFJLVnMwa2N0aTQ5SU1oUkUvcnJqRmZ1aHJGRkNRdFp2RWRK?=
 =?utf-8?B?T1dlSVdxSFNUSEUzU1VpYkRnbDRxbkV2eHhIZWZ1NUF6WU1OTmhsVzl6ZlVv?=
 =?utf-8?B?bkF5dDY4STAxUmpYcTRHc0dESEV3dEZsMTVNcG1kY3FvS0piM0kvM3VpZkcr?=
 =?utf-8?B?T0xRcnFld2x2a2Y0azRTRjBUWVpKNy92SkcwODFxbUQydGJ3N0pUQVoycGNY?=
 =?utf-8?B?bWkwcG85ZGdXUXFLckdBWVRNK0ZZT0ROM2d0VHRkeS8xYU5wcGxDdTJ4SjR5?=
 =?utf-8?B?cXM0akdwUWV0enZudUo1RmxEaHZ2RC9SaHB4UFBXN3BZNWlNekIyNlZsWkFM?=
 =?utf-8?B?a3NoOUtWTHh4RkZtM25lOTdTaDFkdjkvbFgvemFNc2xUck5UaEI5Q3NUbmRj?=
 =?utf-8?B?cy80dE9kUy9SNUJjMzVoT01uUkFYZGNHeWJaRVNzc3Zac1ZrSk1XK0tJd2ox?=
 =?utf-8?B?cGNRWk15RUw0K0RyV014UVZjbDFLU2NzR1FwMCsrdlRMbGVJSDc1YithdWpN?=
 =?utf-8?B?UzA2U1Z1enp1VGQxZ25nM3JxckZaUUdPM000djEzT0ptdy8rVDlNTTZxZ3Fo?=
 =?utf-8?B?dnJGWUk3YU5SYlBhRXQzSGJqRSs0NzBrN3dxbTF4OHhybmVVWHluT203TXRC?=
 =?utf-8?B?NFRzeUhWNEx1SDVPYUZaZk0vbExISDZ1RFlNZkhyZVQ5bFdSazNvcHZML285?=
 =?utf-8?B?UFJxeW11UTFoUlN4QVBVYS8xQmlhQVBUSXQ4c3BucFFwWVhta2R0TjZVODNL?=
 =?utf-8?B?RUo5eExLRmZyUnoxZjJDRkZZdlRmSTlkVlhQb1h3NUxSLzBZdjM5bnA0QXIr?=
 =?utf-8?B?QUpYazVwSjVLMVJSV3VkQW1yU2dmb2FPZHoyM2YyczF5NmVYenRhUkZsZmkr?=
 =?utf-8?B?ZUhOU0praTlsTVNOS3haOVFPYVFEZC9tSDlLU08rUGs2Tnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3A3L3hRNWgzanpYNkplZG95TnByQzQxR2VlblpJTTdlK2J4bVlYblVrQUhY?=
 =?utf-8?B?ejQ1SjFySzVha2hWd3BoendtblhwUzlVMTVTMGttdEVWSFFJVXhPTjBEM3BS?=
 =?utf-8?B?b0FqVCtIZ21GREthS3Q4bXM4djFQQVRMSkdmdTV0VTlrSDk3cmRjbDZwQk1W?=
 =?utf-8?B?UHJibU04QldldC92TGJ0Vk45OFp6bURycUJ6TzFlZSs4TVJzVFNmS29DeUFo?=
 =?utf-8?B?Z1gzMG5BaHhRa3Mxa0ZWcFlybDFSNzhrM0JSN0s4dko2NUVNT3BQNWVhNExT?=
 =?utf-8?B?TjVNLzhvbmR1aXFjTlppOE91RnpXVkp2QTlONGlsT25ZUEkwQms4bmlaSURt?=
 =?utf-8?B?UE5EanM4TGFvaVhTTWpOd0ZBbFkwOTAvSFRhNSs4eE82cGxSQWVxcUs4bXVW?=
 =?utf-8?B?OGpCQVRTa0VaMG5ueTY3Y0piOTlyczB2a2tBWlNpZW9IYnUyV2hZU1FCVGRJ?=
 =?utf-8?B?K2Mxbi9ueHVsdUh5TS9pNFdPbS9zdjloYzRQQjE5aUZSOFJ1enBOMTFqK01H?=
 =?utf-8?B?ZFkySzZGRDFZclJQNUZxWEdlajM2S1NzVEpTcm9reHNvbUw5bEVLSkt1VzNv?=
 =?utf-8?B?cHNQNzBibU5XTDFSNDRuTHl2WkI3VkQydkdleWhiNjlNYkxueE4vVzBhSy9T?=
 =?utf-8?B?YlFGajJteURCSGU5cm1xL2w2Qk1PS2tEV2dFSEpnS1V2R09PR2o3OFpZYi96?=
 =?utf-8?B?blJwTU9aakFOVC80aE1STFRod3c1VW04Y2FVVzllcGNuZHpiMDAxbUo2c1Rr?=
 =?utf-8?B?OTYxbUxjakpmRU9za3pEakYzNExQVDZkbkRQS2VZbU8rdzB5VWZtcU1HMWo3?=
 =?utf-8?B?TUF3YUsweDZJYzJPUG9VamtKMTl0ZVZWS2ZkS2w1aGlESGJFOEJHeFhqUndL?=
 =?utf-8?B?TjBhNWwrd1FJYzZ3dlkwTzd0TnhNVWZMZEtMOE5seE8wK2dSNUZyL0lYQXBQ?=
 =?utf-8?B?TlM0dFlCNmswSndIOHIzU2NMQlJ6ZjlyYUh1ODFjaE96VU9ib3kxdDUzT1ZG?=
 =?utf-8?B?c3FHdDZzTzUyMlJMa2E0bzNTcnNVa1NrK1ppQnNQeklMOEVHQlNONXk5RHhE?=
 =?utf-8?B?S1RudVR1d21zZ1ByYkprbE1ObXdIejJkWTBFanE5RHVVZ0Q5UEdVOGllSkVa?=
 =?utf-8?B?OXZPekJRZzZBaktodW1WdGZrMmZuVUc2VHZndGt3aDlqbUxacmdnWWlMb2xw?=
 =?utf-8?B?Zjc1SjRhRVdrOEYwblZZaS9HaElBSUpDa1pxcXVDSncwUFJGTVY4YVJYOUov?=
 =?utf-8?B?dExBdGtuWWs0M3dKUDZ0T2E3UUxTc1ZWbHloenhOUC8zTkZtQnc5dmRDNzNB?=
 =?utf-8?B?a2MvN2lsZ0pkeUxnbFBZU1NEYmsyZnBRQ0VXQ3ZsaDNOdTMycHIyTnBacUZD?=
 =?utf-8?B?bEcrSDZ0OCt4WDVwbWw0aWJqUHZUbUZobEdmWXBEbWR1b1Y0cDdEQm8rNDFp?=
 =?utf-8?B?QkN4YTRQOXV5V01TNlk1V2oxYm5WL2R3VFFWVlVuczhjT2hqdmt2U1QzQ24r?=
 =?utf-8?B?RHVnS0UrQlhQcXQzblN0N3pYWmpFUGY5UjlJdGtXdnpQMnc5aHdadFVEdEpv?=
 =?utf-8?B?Ri9kMUF2M1NaZEU0M1JkQWFPRTdHQmlVWXEwV0NsU0J1UkQvTkFNcHRpcDFh?=
 =?utf-8?B?YWRsWE5CckQ0OHFXTCszMm5HSjdqS2UwVnFJU3pCR1ljQUcwM3oxTWJublRa?=
 =?utf-8?B?NzdZbEp4cmlid0J4Q2UvUTZic3FrY09mbkhURmw0VDlFNnBCMTR1YVEzbnE3?=
 =?utf-8?B?K0NCZmZtSUh6Q1liUzZPM1hmY3cvTzNXVHRRMXd3RjdsbUZURURURHltUHBt?=
 =?utf-8?B?ajB4Z3lCdXcxUlVvdTdES3hGWkRsQjFwOFcvekdhVXA2Y2t2dDRIaDlRbDRB?=
 =?utf-8?B?ekRScGlWTUVNZXovRUd6K3hKQlpyVUkwM3A2R3dqTWlUNFcyZTBGQnNrMjFQ?=
 =?utf-8?B?c2RTUTBYekwrUFg1ZndqcEV0cFlLc2swZHkxT0tRZkFnM2FOeVMrMEhRMms3?=
 =?utf-8?B?dm9xaW03cmd3b2EvZFc1elU2RXp3UDhaSVY0dlAyQWx4dEloWDhXTzdqYzNo?=
 =?utf-8?B?NnRjUzAzM2hHeGtydS9nZTAyVlpDV1duSzBteUk0aDQvK3FDUGhuOWtqcTlF?=
 =?utf-8?Q?7jahkeCBHBDg1pvyW3mAhicvI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a8ba5a-6d8d-4979-57a3-08dd1397618c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 12:38:25.9568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XT7a2rLKvkFE+LPDpgd+W0s7wS7Sn+GCQfqkRHH3jgK45eLFa3TktgAzdvBWYMm8dAjtPNz2vArJzenM7jGwQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7351
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

From: Peng Fan <peng.fan@nxp.com>

include display_options.h to address build warning:
lib/smbios.c: In function ‘smbios_update_version’:
lib/smbios.c:305:9: warning: implicit declaration of function ‘print_buffer’
[-Wimplicit-function-declaration]
         print_buffer((ulong)ptr, ptr, 1, old_len + 1, 0);
         ^~~~~~~~~~~~

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 lib/smbios.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/smbios.c b/lib/smbios.c
index a36d4b4e54a..defb6b42f45 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -7,6 +7,7 @@
 
 #define LOG_CATEGORY	LOGC_BOARD
 
+#include <display_options.h>
 #include <dm.h>
 #include <env.h>
 #include <linux/stringify.h>
-- 
2.35.3

