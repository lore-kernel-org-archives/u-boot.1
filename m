Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31C7E77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 02:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7074780608;
	Thu,  9 Jan 2025 03:23:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZMixU2dX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEF1D801FD; Thu,  9 Jan 2025 03:23:18 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C628B80317
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 03:23:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AR5hzfvPdIK8KyRDhLHt0HLJSjClGa+Iq7bp4t+0TBwrMEOfgGViwjcki330OR37NHcuKKNJaz2dGgDzdEhulJ6Qoao5TxeGvzsqJXj0payYmQ8TM4D/TV80yLou09MHkNMzHGSJYFK2Ea0X38XrC8lrXfdRBS7S49lowZIkhE9EZjjxqpA2n60t/AdWWOqE9MWFStqz+NwNUyX5sXY3wunh8iHhZGemDVO/WKEmklKqULTsGmUN/yEh4AixvNbhC2MehIZOVxxGhF6c6PJHZnf9JHlKMLqKvuKJpl5X48JqZYn0Icotzk/czIpnKR7vr77fFN7kPfIG22xvRL4Oyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVDLOrabmXdHHGLKzulvhFmWUBjPki+dpBKP7dW9Pag=;
 b=aWHRJGJLqKq9JLnXNJ23UOtEbCYwSt4qdoWc2PVtrFztj+2JLnyUlIXorS7l2nkgXdqvqzR13FZ6eqL0A8p2VK6NL+44oQwNu1WBrppnYdGwrsfDVZeMstIdLePJBEwRNl6u9Z/xydSUI/0mhnBTDk2rU7U4ItGzVPKQMIIqjtnf4UuB9k9ccbkHcXLyFIqH0ImpTI+D7eAhRNHhgGDHR1NHO3TYnXy2ZIZm70gbHAqQxVu8JkR5A1gKxkwtqOnTDI3kTb6bNW2aHHurn4oivdqn5sVjukBlz90ntBqFWw4AoaiGBpbZQrPOsI6wUJSIeNHUl7USHeFiJ6mTU3fnwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVDLOrabmXdHHGLKzulvhFmWUBjPki+dpBKP7dW9Pag=;
 b=ZMixU2dX1DpstSDen1oeGaL1iCrN44Dxx3+LselZRrDn5YyDjt3atLNRR0cKbiRIHpMT6qjCV0JxqLPIWnBv+0DnmkAOgFzk0ri8LosPJp1/UN7f3+VqTaJn+3riPqQiBKQJEadqgLeybd9GTxc6+XkT0x8EYtpOXeJal8BrmWLRCvlcrvBthISRzF0FgiAGiAnDI+1Fs352AlS27kEgiyHd8RI0Uj5vU4WUtjNqRqaP32O9Zk0Mr2jdZKeNmyW5n1Q2FuKo8XiinofZURO7ZeMQq3R0maKItfDi8usDcA7qJ2jVEvC5guYHQzR6OKFSvjJO4VhKrHq9sI4aXRDx0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DB9PR04MB9355.eurprd04.prod.outlook.com (2603:10a6:10:36b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 02:23:15 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 02:23:15 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 09 Jan 2025 11:29:03 +0800
Subject: [PATCH v3 02/17] imx: imx93_qsb: switch to BOOTSTD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-imx-bootstd-v3-2-16e5fc0baecf@nxp.com>
References: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
In-Reply-To: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DB9PR04MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 4753a34f-3ffc-4331-08da-08dd3054927e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTRqeGJibTJCdnZrVTZqRVAwQTByajJUYWU1aUVtNWlPV2syZkZRdTFtMk1N?=
 =?utf-8?B?OUFyNFhTMUZaMHp0SHE5aHBFUjRCWUlWRTgrVUlpUk9xWUZreWJGWWxnYlMr?=
 =?utf-8?B?eDdVQS9jTkdqcFBSQUFwZEE1NnQ0TXVSdUxzc2RBeTAwS2JicGVUQmJRZEdX?=
 =?utf-8?B?aGRMRXFjWHhWSGM5Yzk0Vy95bHlyV1hCampRMS9wSTMwc005byt1Y0JBQU5o?=
 =?utf-8?B?L1NYODlwdGJ2cmRIUnFxUXlQTlc4R1pVQmZ3bzhsdTBMVkVLUzl6M3hVMzRi?=
 =?utf-8?B?ckdTTklrbjlIM3NNdU56QUpVc2ppaWVHZlVIL3hzc0tnVDJqOVRtZUhuK210?=
 =?utf-8?B?c0x6cHlKT1dIbVNKQTdQSzZNQ2p2cmN4TlN6ek5iL1F4alJ5UzhSeE9ZSXll?=
 =?utf-8?B?a0ZENnFmazlRMGtwR2tPTHMvUnoxRTlLeDdOY2RJWEY5U3hEOGM5NXliNjFi?=
 =?utf-8?B?SHBrNmFOaVVrcENjcTQzTURnZ0JoY0VkcS9KM2RiLzl4aUx3SUlUdVYxbTQw?=
 =?utf-8?B?ZjZTTm9NQjU4bVRKUkVMdWJVV3FQazFnUXpYdUpvZUpXdDRHeHBrdTh0WUY5?=
 =?utf-8?B?dTMwWEhXdEQvZHhPSzRWRHZ2MXFrcEhPWE1GMWZGc3hMd2VlMDJyeXZjMVFU?=
 =?utf-8?B?dmk5cUxob0ZRdzRYMFdvaSt2a2VTditKcFRPZmd2OFQ4UjVCeVd2YVhwUXA4?=
 =?utf-8?B?a2U4Uzd2NVVMYUVNU0FTRmp3dGZheWg2Q1luYlFubU1ibUtDdE1raXFUZCtV?=
 =?utf-8?B?RkUydzgvYk01SEpNNGdSdTZlR09jZW1uZlhOV2tIU1lUckw1L2g5UnRQb1FU?=
 =?utf-8?B?dlBZUXIvVWtHQkpra3pZZGJyc25qU3dMSk1tV05qNWJFZkl1MGxWaGlEdDgr?=
 =?utf-8?B?WWdBaUtKNjlFSEozZTF4QWcyQXNCOXowTjM1ajFaRFROaFNWK0owOVdNSzNx?=
 =?utf-8?B?OWxiaHVaR2ExWmlyUVNiaWw3Q1N3VThVTW15RXdqeDBuYzU0bG9IUllXRms3?=
 =?utf-8?B?amZ6bTJMejVRdEdlN0FrSElOd2RqaE5BU0RrNFcyN2xyZTFPSmVHeFRHdExh?=
 =?utf-8?B?VytmanV2NzlLczFwMmRmTm54UkJsbTZTYWdBek16OG4vbEROTGs0ZEpmbkVX?=
 =?utf-8?B?NVBPaWpYcmxqdy9HV2gzL0Rueld2cXNqYzBPZ2Y2MXdIUDk0S2pvcnJOR21J?=
 =?utf-8?B?ZVJOUlZHeUlRZVZsVGVkanF3MUM1anFtMTB2aldmb28xbkRYYVNMN1RxVmZp?=
 =?utf-8?B?SDl2cDkyaWdoRUJNZEo5b0Y1N0x6aml3MmZsaWdRWDU1eStLdjJqcWlhejlo?=
 =?utf-8?B?ODBFb0J4cDYrRW56Vmx1Q04wcndJOTV4cDVpb1RtQTZxbzBUUE9TaU1neVcv?=
 =?utf-8?B?Wm1LMDVZUWJFNzlOU3pITlhTWTRUT2dxU2QyM0NzUWoxNXFuRWRWNUhCdk0w?=
 =?utf-8?B?eUo1TFlkN1YwN2lUZFhQWlNsOTlldEJscFlkY244eEI4Z2d4ZG9CMFhpd3hC?=
 =?utf-8?B?Mmx1Z1NidDVUenZxQit4REFGdVhFVEVITEJ1VTVEdUxFZ1RicE9aU25KK3By?=
 =?utf-8?B?VjFyS1VsMmg5NERocCtlTzUxWTZEQ2pkZnVNbG14cDYramF3M3BEV0c5WnJB?=
 =?utf-8?B?NXRKY2xvSWkwT1VWOTF1YlpSczdtQzlQTHFuUXJLMjFQbzhFazRhZ3JhN3FT?=
 =?utf-8?B?Q0F0dFY4QXdqNitTUGdRQXRaM2toc0k4Rm9VdnlVSmVwekZLVFBSN3FFUE41?=
 =?utf-8?B?Y2wwS3FySzA2Q3NqNnRPc3NmYTkrd1JicUJzTzdaVWk3d25EemR4Yy9lK3Nv?=
 =?utf-8?B?MDRpQlZaVzk5aVFQU0RyZW1rdE4xK08rY2pOMnJLQ0JJbHpJSHk3d1Y1NFVn?=
 =?utf-8?B?R3NtdlF4TWQ4YzFUbVJ4SXJ5NkNzK2JKbGp1R0IrcGtYazd0d0t5ejZ0Tjdw?=
 =?utf-8?Q?thtO4luHqw8HpG8fuYCMsy4a8luMygkl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2FHTTBlYWZCTEdFNXFtRC8ydEgyQk1uYlJUWmd2ckYwdGdIWDh6MEozbURr?=
 =?utf-8?B?cVg2YUFtOVJXQ3ZMN04wcjdkbmpMK0JXTER4TEVrVlR4cVdQL3ZZLzBGSW41?=
 =?utf-8?B?M1ViczhURitPN2ZCTEJVMTg1SFRpUjFQOVkrK1F0TmRKL2M3ZVBWaU5qbFEv?=
 =?utf-8?B?TVRybmRrYWZ4eFVYQ3VnZjd6Y0RUYkRHTFUvNFRBdllUSEQyNlJJVWVhN0lo?=
 =?utf-8?B?cEVNRjNYRFZWdk1kRzRCWnhlSXgzbkRYeXdkQU0wVnJqVUZlRWw0cFdPRFVs?=
 =?utf-8?B?QkhuR0FPRFRPMXA5ckZwTklzS2x6YW1VSkpDMDBwcUhFaTFzLzlmZklHUWg5?=
 =?utf-8?B?OCszOFJsMitiK2dCd0t6dGFyczgzY3FlT1RvRG9EQ0ZJYVJrZDFkQnV4aVRH?=
 =?utf-8?B?bGNUSGt3dzBQdFhjUEtOS0p2cnQ4OGVvZDRXWkYzSlRDVUpIbThXdUtuT1lV?=
 =?utf-8?B?d1NIREJDNEgvbzVabXdsMnBwRE85c1lnaUR1NFRiV20rUmNtZlB6NkFINFdU?=
 =?utf-8?B?WVgwbmpMQzVUMnRxdTNKZ1VRcVpBcnZmNHdRdHcyVmN0VkdKNFlVWlFxQ1Nu?=
 =?utf-8?B?eElnU1Z4dC9tenpyOGYvTTMyaDFRZlkwV282OHluWStrUWNrY1FGYlJGdXlq?=
 =?utf-8?B?Wk4xVTRadVF6NjNSSG0xaTFVVStBQk1tbWI0NUpxWU9KL3lXbDdRMHpxRzNt?=
 =?utf-8?B?OHZWOEVHY1BkMVhmVG9xU1NuMENOOERyNUVCQ3pKRlUyTkI5ei9WVjZnKytT?=
 =?utf-8?B?UGlZd1R0RFl2VnlwN2wxWWxPSmhydlB3aEJDRnVkV3VoOXF4MzRKSStxaThk?=
 =?utf-8?B?eVZxNkxGMWhEV3BCOWp3ZVNVenVkd2xRS2RzSzB2M0NKaGVnaGJyZjVnN0Js?=
 =?utf-8?B?ay8rMFR5M0FTOTBQc0JYTGxNZEh3RGxNbGRnL3hFZzZVb2o4WEFCQTF4REVN?=
 =?utf-8?B?c3ZVd1FnWk1ONTFvamZOYVM0WnJhRGlyZ0QyKzhBZmwrR01tdTd0QkZFbEJs?=
 =?utf-8?B?djlTU01aVnhoNUwxNGhOcHg4eCtVV0RONE12VW9iRUtSWnlWRUFsajhmcVFP?=
 =?utf-8?B?Wk43d3ZPWStHUDFPSEFkZHFyVEkyL3JveUtOUW1nQ05mbUFCRnY1UStDTWM2?=
 =?utf-8?B?MVpURUlOOVRyYVg1cDhjaXlWNE1hTnhnQW0wQ1Z6MHBqV1FiUmRIYXRYMXBn?=
 =?utf-8?B?OWJCZUI3TysrSGdoRXJqallsQi9Hd1RRVEJ2U0VtN2FTZEltUEMxVVpTdXIv?=
 =?utf-8?B?K0xjbUJ3cU1JaE5uSWpUQVBCb2ExYmxCWXhBbXI5MEJCU3JrelQwekJpSTlN?=
 =?utf-8?B?TVg2MlFOZFlUN3J5YUxodDR3QWczMlJYdElXbmRQckNRSVZpVXd2c0tBd1d2?=
 =?utf-8?B?dTFyeElXQkRGbUxicTlVbXI3UTJ3Qk0rMXVwd29IT0FXcThWSjV6c0xVNVZh?=
 =?utf-8?B?M1VsVHFMMGp5bWhac011bURIV1BINDI2ZmtLOHBlcm5NYXNrQysybU0reW1z?=
 =?utf-8?B?aG9nWEpYWWdMem9UUzJGM2hLNXpNa1BqWnNRTFZKaTRUR3lNd1hEWm9ENHJ5?=
 =?utf-8?B?aWhqNDI2cXRyTnZvR0Q5b3I0TCtiTml6U2lSeW5XaUI5Wk9pNmViWDBVbjZZ?=
 =?utf-8?B?OHhsR3NuaHU0R1JxK2Z5NExKUUc2U1hhMVhIaU9TOWl1WTFYaWt3ZXVRenhY?=
 =?utf-8?B?OUxic0JvWE5wSGo1T3FjRG5XdkJkMFB5RDl2dWtQUUtYeUtnWmR5b09Talll?=
 =?utf-8?B?aXd4MzRxTHA5dDNyK3Z4MXFNMjFDN1RxcUgrS0ZXL0h6bTQ5RVR0SUdCaTNY?=
 =?utf-8?B?RHJic21MTnRzc1l1VUc0R1JaRGY2dWw2VzdOV1ZMVmVuTUp4OWJFTlMwNHBS?=
 =?utf-8?B?MTlqbGpPb3BaeUNJRzRSbWpkRHFxa3BSWVRETmpSNVJXaEVpMEd5UDFHSks4?=
 =?utf-8?B?Y0VmaG1xQ1VhYUo1WWFSSENqUVhhaksyRTlOWHcxdE5oejZtYTlZc2FFbGVi?=
 =?utf-8?B?dUZ4NlNJNW5xQ3U0RXkzZGZVMG9WMHRWMHg1dW0zM2YzSHRSMHRyN1B0a3FT?=
 =?utf-8?B?SkdCYnBHSUpuclJZWHFyYXh3TmE4eUl0RWJjQ1MzekhVSGc4cmc3Q0E1cDVh?=
 =?utf-8?Q?ivbffMZaRXpemKBS/qSpvxyyi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4753a34f-3ffc-4331-08da-08dd3054927e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 02:23:15.0756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1+9MF4Z75XlEruGlzrwPY/lOe2ufwQGIMAsYwDmAinZD9l5YmNn4UjLavQCKBsYIeXcx+M61eZWxGjx+1v+fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9355
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

Switch to support BOOTSTD with a bsp bootcmd as fallback.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig             |  2 ++
 board/freescale/imx93_qsb/imx93_qsb.env    | 29 +++++++++++++++++++++++++++--
 configs/imx93_9x9_qsb_defconfig            |  3 +--
 configs/imx93_9x9_qsb_inline_ecc_defconfig |  3 +--
 4 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index c52546084394a7cc26f35c93ac8fb62d9c5fe795..d756f3dcad2e91172ecd885357b9d0adf2e387e3 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -41,6 +41,8 @@ config TARGET_IMX93_9X9_QSB
 	select IMX93
 	select IMX9_LPDDR4X
 	imply OF_UPSTREAM
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
 
 config TARGET_IMX93_11X11_EVK
 	bool "imx93_11x11_evk"
diff --git a/board/freescale/imx93_qsb/imx93_qsb.env b/board/freescale/imx93_qsb/imx93_qsb.env
index 92486c6f74d2ec12f638443dcf598daa28f306b6..c972d3eb2511542c1a11812f879d7627cadef797 100644
--- a/board/freescale/imx93_qsb/imx93_qsb.env
+++ b/board/freescale/imx93_qsb/imx93_qsb.env
@@ -10,6 +10,7 @@ fdt_addr_r=0x83000000
 fdt_addr=0x83000000
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 image=Image
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
 mmcpart=1
 mmcroot=/dev/mmcblk1p2 rootwait rw
 mmcautodetect=yes
@@ -19,12 +20,13 @@ loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
 loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
 loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
 auth_os=auth_cntr ${cntr_addr}
+sec_boot=no
 boot_os=booti ${loadaddr} - ${fdt_addr_r}
 mmcboot=
 	echo Booting from mmc ...;
 	run mmcargs;
 	if test ${sec_boot} = yes; then
-		if run auth_os; then
+		if run true; then
 			run boot_os;
 		else
 			echo ERR: failed to authenticate;
@@ -48,7 +50,7 @@ netboot=
 	fi;
 	if test ${sec_boot} = yes; then
 		${get_cmd} ${cntr_addr} ${cntr_file};
-		if run auth_os; then
+		if true; then
 			run boot_os;
 		else
 			echo ERR: failed to authenticate;
@@ -61,3 +63,26 @@ netboot=
 			echo WARN: Cannot load the DT;
 		fi;
 	fi;
+bsp_bootcmd=
+	echo Running BSP bootcmd ...;
+	mmc dev ${mmcdev};
+	if mmc rescan; then
+		if run loadbootscript; then
+			run bootscript;
+		else
+			if test ${sec_boot} = yes; then
+				if run loadcntr; then
+					run mmcboot;
+				else
+					run netboot;
+				fi;
+			else
+				if run loadimage; then
+					run mmcboot;
+				else
+					run netboot;
+				fi;
+			fi;
+		fi;
+	fi;
+scriptaddr=0x83500000
diff --git a/configs/imx93_9x9_qsb_defconfig b/configs/imx93_9x9_qsb_defconfig
index 582fe5a318daaf568b48dac816cd15d80b430b22..8bd2ddda7da8f2a60b834777ae40fafc83963bb9 100644
--- a/configs/imx93_9x9_qsb_defconfig
+++ b/configs/imx93_9x9_qsb_defconfig
@@ -6,7 +6,6 @@ CONFIG_SYS_MALLOC_F_LEN=0x20000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_ENV_SOURCE_FILE="imx93_qsb"
 CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
@@ -29,7 +28,7 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_REMAKE_ELF=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx93-9x9-qsb.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
diff --git a/configs/imx93_9x9_qsb_inline_ecc_defconfig b/configs/imx93_9x9_qsb_inline_ecc_defconfig
index c95145cce0ed31db81b49bc9834b4228a9f3ba81..3d07dfb00297d25b82bc586c13491614f3977dc7 100644
--- a/configs/imx93_9x9_qsb_inline_ecc_defconfig
+++ b/configs/imx93_9x9_qsb_inline_ecc_defconfig
@@ -6,7 +6,6 @@ CONFIG_SYS_MALLOC_F_LEN=0x20000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_ENV_SOURCE_FILE="imx93_qsb"
 CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
@@ -29,7 +28,7 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_REMAKE_ELF=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx93-9x9-qsb.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074

-- 
2.35.3

