Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D966CA5FCB
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 13:15:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E19F3811EA;
	Thu,  1 Oct 2026 13:15:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Eb_Pe5NFB7n; Thu,  1 Oct 2026 13:15:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 20DE8811B6
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790860526;
	b=ANY8orNUPbnY+zhOjIEB7PrjdONhYj+kcBwIyHUCyiYT9LbPyzPUT7+q87htqkfg/MUj
	 7NQzTaiBQUp7h7T3fVCMOYVTeSj84lppj3I+ux0JRWoKVe4J9Pxv9H4USylCsdAeppl/X
	 m4tqrKhRMuwC9CYQydkXWJ4KsnANgkStNhCqbOiL8qDQlouJTXa9w2INCGSGSLxC5TQLm
	 d2vdbNcK6GgI8GcWyqcz/8e46159GBjF+qzGSVEHr0JyI5UlxWfPAt1uI9gsYJ8mY8rHl
	 0WH4U/mQc666o/5vR9aCP60ZrIuWkS+AxC4H24UYF2YD5i/19C1KRscjGReLkYV0qfA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790860526;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yqoYLXs6kyxz6vi/WNzsY1sMJzLt0LAII0L5CsnUV3M=;
	b=nuw4X3M3lNQQqKfliQ4/Ji7c157jLybbMPGceVK16HYt1R/PjaerT8UMsXFq0ZjU4y2M
	 Abm8vehqimp6sxfvJVIK0qhK6vVSv8EWTElza2KMEjjiByQgocmbot5kcHhzLKgc9I/Xo
	 J0D/2Sai+8KFC/jVLdD4OLJOC3bqCmmJHWrG4GL05jv7HcFIiscWpnJ3nxhdOtNbJ54Az
	 4Y7gBU2Sh+iKXKWZQ8r8Mau3LEERVRUi0ULZetJ3z2j2S6BCA9QJdGZs+zumqnPAUvevg
	 PknW1ta+S7bVUGe3aRAPPTXCZrOntGfyHAHOAfsH+iFf/24xyS+iUgNuPpwTlIBva7A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=MJK4uUxM;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790860526;
	bh=yqoYLXs6kyxz6vi/WNzsY1sMJzLt0LAII0L5CsnUV3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fMl/U2tBnTjg6Buz9q/yJXDa8I9BkHBCCy8H1wm6Tx4sXeeTkWvojzo6zZ2lLreSf
	 oDaSQFh6B5Kf73PCTMjH42Nk4x8HT/Vnn7ftorZ22lHw7zkRyZlOIFZnUM0vfv2f4R
	 ZQo6TIjUgKfaN8fSuehq5yBjV/JZ4W5bEhW5So+zILv3kqrcJCLpytAuo9by12JVrL
	 wj0Bx5uuaBqEKa7YVNGhOp4daPIoDNVHSiDLwp2Dak8c09RwUywvdOkdloh0kqaEnU
	 TQnK42XSX0HCBsI4u+iI4pkHjE57w79RAXFV5HNwPTBufuuIn4XykEachVYk2Dljrz
	 FyYIS1X6Fyq5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20DE8811B6;
	Thu,  1 Oct 2026 13:15:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C7B3532F
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 13:15:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD44A811B6
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 13:15:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q2nWjj0iicgS for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 13:15:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DE1068119E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790860524;
 b=K3Y7FfgxJRqRRAlY+9aXaMQAKxyEvHHASDPnMbXydnOwKtURgtyNWL+AQXLz11qKFq2F
 S5+ziz9e7a8opBxCdoLw+NecKkjlXJUkeUUpOgqs/ASkk4NusUrJGqVEcZKkESGi3n31G
 fg8a/+F6y8HKxYRBzxHH3nMnddjyXnnzf4PWkZGsOqmm/hKKNdXqG0robiLiKSdcsWlxx
 yeP7th3nKu4QrDWRandYfiVSRlK2QAjfpvM6AyGKAwbxc3g9cKpolGhUNROw7ddwadD7D
 THdpxcCqJIJ3w9Vq2TH49v5FMvqyUqLiOSmPksl4FXFgt35c4dub7PLMLYSH6FU566A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790860524;
 h=Received-SPF:DKIM-Signature:Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:Content-Type:Content-Disposition:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=yqoYLXs6kyxz6vi/WNzsY1sMJzLt0LAII0L5CsnUV3M=;
 b=kLh7U3hgr22+ZvcZK6U8Obl5WHobB5VwEZ4stoNTYDA83oJDRb4rP+0Z8W1idmb6J3Y6
 99rS/2/zpf11aTqGN5/UeaKjComu661Uimw3RR5E4oIF170wZteELyHzprSBj6crsthSv
 nEG/tQjdFNiSmcyIWSRtGuIomwl+314oIt6O6ss2u1F+lyjs4NHr13p0/0FDnVDdUaDXK
 RSAAVy5hYv/dk2ElaAJugn0/GU5ceyXqyISC8ixBdLSs2wf6Ji40aGmN7Tf0OMj82bN/b
 0k7V/Ofz44IqEWVbGOdghfM6fhzMkapuWJXJM8SFS1DFtmvTKwzd9cgYhshUTzQHuNw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=MJK4uUxM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=MJK4uUxM
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE1068119E
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 13:15:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6oe0Q8MyJsR/4gjV2BvdoCNDiiIt1ju4QG2UYR4ICXt232nP+kYZhdPVmoOowWfQav7QmjEbn6eqB4wL6DHLLMbWKwOPBJMkt2LSIi965tAbNWRIPuYglpjGC2EP0qES2Gv4fMDZhdTptTF/tM/ZsTeDeYoW2210LJnL3cwELLDRmoQBUWEAc5ji0rAatFgmmaekVD+BeodyUzGmASV70DC1896KJFSu1rhohHCbGfGhoecY8zDA1z3A9LXpd+jo/P+xeSf275ixGRZDMR3PiASdC/q9DCR2Z2zaEKuAcuEtBJAi6+UBIULLjS9Tv5NA3SqryNuP5jhCYg81EkmCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqoYLXs6kyxz6vi/WNzsY1sMJzLt0LAII0L5CsnUV3M=;
 b=GwkfXhWJ0cKQrT6Ygloy0NIob5SKoM+saqUaCMg2hlbNjueB910vQprXkZzG1hdabiUtvLNtqkugz/ejHCOHbapXdBzkrBTBG3sLg7PkP6YD/CWBMC7yy00b+2XDbPtRvtJioH+VVdkdEz8mYlEokmlE67Yk7OAzOXBl4HLAEIxGB2KxYL9PA8fe2qbj0G9UiD2XgAewytdut2hMXWdeYgNw5E9whpgprEcelvFLUO6QKCCRjhK46LKYjre2ok0ClkG3RaLBQub/u61QIwXzoqijG9BvwuOvQBNjtKHmsUby6pvvhIeOsZLZbv8+NmM9/qa6c6MDBOf7uKFh2Pps0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqoYLXs6kyxz6vi/WNzsY1sMJzLt0LAII0L5CsnUV3M=;
 b=MJK4uUxMgbcAoRrufldytksBlas/NDTONXkf0FufhJaUij7/lD+BeEHP6OoEvy3PU8RQz9/8X+OCO+QsjY+KBT7M2665NBhE/EMCVOTtRmXYNo7CX+fRXFbYPpwdLvt4Ys+//yOuWa1oyZaNk8R0kXXmJdN8oP7TIwDUMUxpSob3YQW7E2+BkNt93W2YDXVS7ktWEJ7Mg0Lhj56YgLPjQ/7yurbE6KTPs8ZKjaZ1lS7AzCd/BX2RwS+gnqoAjP8Z2jVJZe68MRHvK8eQnDwExOKt9Y8N9RmZri0pWBlzdzoTi1gy+7vbQ+hUvc+MFaMKvM+tzT2mLDh7ZNqsMlrgKQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB6902.eurprd04.prod.outlook.com (2603:10a6:20b:107::20)
 by AS5PR04MB11372.eurprd04.prod.outlook.com (2603:10a6:20b:6c7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 13:15:18 +0000
Received: from AM7PR04MB6902.eurprd04.prod.outlook.com
 ([fe80::6d09:9d2a:f8c2:25e6]) by AM7PR04MB6902.eurprd04.prod.outlook.com
 ([fe80::6d09:9d2a:f8c2:25e6%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 13:15:18 +0000
Date: Thu, 1 Oct 2026 16:15:15 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>
Subject: Re: [PATCH v5 06/13] board: lx2160a: serdes: report unknown SD1 cases
Message-ID: <20261001131515.m3464bpjskav62j6@skbuf>
References: <20260929175947.1379710-1-vjardin@free.fr>
 <20260929175947.1379710-1-vjardin@free.fr>
 <20260929175947.1379710-7-vjardin@free.fr>
 <20260929175947.1379710-7-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929175947.1379710-7-vjardin@free.fr>
 <20260929175947.1379710-7-vjardin@free.fr>
X-ClientProxiedBy: BE1P281CA0255.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::20) To AM7PR04MB6902.eurprd04.prod.outlook.com
 (2603:10a6:20b:107::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB6902:EE_|AS5PR04MB11372:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e63ebac-279e-42a8-a768-08df1fbe0a31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|19092799006|1800799024|376014|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info: ErAOMDd2V91hy2EXemQ+89AMwfrSFfO16eqrUvacyHz/tjVfZpQqImAI2thSuQHimbwt+i5ixwSnp0hroMu5ZzmC2OVZP5CQ/Ig8maR5x2A4BMDoYKWNR3+0erZPPNzLJwmb5JlwDu0kD9jAQQtScvq3IySCq9/4UdiWXWehkw7YoA4f40VoVNkQR4yVgSzxrh8pr+bRRaXdkylRKPlSFWA6mhXdiA/VBjwJBOl+9uoWUpdxz3aDeK8l2bKD8SguuRZET03YTuIj7dVTWEIm37F4lOs+e5lj9Ks4CFnu4rLEPAdbaa+6SPZsl09vnqMmNp1TNalO7uC9Z3RzB5Z57LiKx62FQS16zcYJJYy1I2DoN8f/AahqsmDwypR3LkAxdFYKZoIMXm9QKJfCL921V18Z9FAsn32DifsXO/HrqpgJwa+rmKl7EYNjg2oJTZFKtjUns5H37FpmbOwdWLVG+jEyv6l/HnJj4iqce3TuqkBUn/s8ntypTunbteojEcUZx9BEn85QevY4tmvMNpONCr2B04Wvb17KMkcPOXdRe0uPYYeY91nmysbD3KyZI5tLIpWljwL3Qa1Yue+Y5nKx80ttgIh1HRKFlQzmAnON3NFYb25hcvqcBHjqPQyS2WLtcAmaWJ2X9cU5a15OUDKMVcgQRNCW49Www7XEj0DBWIPsP/QjmpzJgMAiRlSQQaQgE+uGE8DDhbb5EQvCin6ifPznKmc0+NpcqzCwpX8RzxQCenthQl57iTb26Xo/UAbU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB6902.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(19092799006)(1800799024)(376014)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wSslMEddOBOLB50PKq28qB6P5r0LnbKQotogCttSysySy+oSDF/WQ9NN6N4x?=
 =?us-ascii?Q?WGP47+IjgMivrfq3CFO8QBF3+8E2+RnAspFR+cO9y+d3hKroBa5AW1RlzLZU?=
 =?us-ascii?Q?PVVHURwwjmGyycsvQzOeONg84WAx2QNqBYAZzhRxn0cIt/FXZX3EeTbPxzjq?=
 =?us-ascii?Q?qs3+JwW5AZ/gJi5mkGrtDiraOSfC1o29ampt6MJpq+d+va0CZ+gHfYKbfoYb?=
 =?us-ascii?Q?b+1dJDtWhy7Ahgfsf15EmaOcC9FJzp9Nl8XI1xTHqwHe/hD/kCbALIjTTABt?=
 =?us-ascii?Q?g2HyRDa18TdSf+dPJprtp4HbRf0EUPj0409XxgkftN1a56MSP8b62TQm1ySt?=
 =?us-ascii?Q?eJnq3Nx7L/HlBnoCTDhFNb+OwPz74DUOcwbTY1DcsdpXy0SmfnyWrj50k3CY?=
 =?us-ascii?Q?ixKv1AY2Gs8OPD35M9nDfEQPCLpjFbmZXEcPGQURbtHd7lSSEmejEFB7R5/5?=
 =?us-ascii?Q?eSXfIAgcNdZzUlbnCuLoscgDsgvstepBCYS2OEQZeBNpoV0Cfy5UPchGdR92?=
 =?us-ascii?Q?FQbYADfBSoWX+nmqMSUiLC8Uoko7UrBdTsqLOqCwAUTRCwz34x8c5hZSyQl6?=
 =?us-ascii?Q?qMuMOySkPAxUPGE0QWfgpoQkuv/c0JuB+ldMZUKYJ5sIPBf5TWxhVGdAy5mC?=
 =?us-ascii?Q?WX3moYQiynMyFfdZ2nxDyg7m2ZGKXKmHE3LmR0Z55+suJE7+tNEDbdMEO/NI?=
 =?us-ascii?Q?OXi2SqnhgqR8OO0GzugIENnrw9eQRJlEAkOmzX1yPylwLOjprVoz1KV6WylP?=
 =?us-ascii?Q?5rVdNDzmXw4pvLqWOmDb28QkQR2tE0BZXjeXEumUwOW/Sf+AA0j8ySt4/TQ1?=
 =?us-ascii?Q?vpl4FJoI3TI6C3vGY9Yv5IQ2aeKhzNY3gTk4rmtlvdivikP3d1hSPEf2sjUt?=
 =?us-ascii?Q?1ml6rSfHogSODUUcW2qsjZLYsVlumDpGHVi9dwwYjN+QtHZDogTGWRvb7hxF?=
 =?us-ascii?Q?6TsKRTN9LKDpZNTSlrUVtnL3N5rSar28jmhs2xhqxhdUHCYm2kw7G1lMFxXW?=
 =?us-ascii?Q?w36+JyzJwbD5QOtm0E/rskbgW8bJtZ124931ADphq/EBsbDfHgW5qajvMpiW?=
 =?us-ascii?Q?Ad9+Gua/mW3/xOQP94NZd0QjZfwMGquatYEvfEr2DBdGDoOT5siz74XDzwJe?=
 =?us-ascii?Q?otlQC2WB4llJp7Or2oyYcyEtw7B/c/9sbzHaqixeTkxX7pnXlSwQZGsgRdZP?=
 =?us-ascii?Q?2en7UrhxMGVZIY1ccrKB/1w3r2e4h6u96wR9pUjmMIanJADtT0VCA/t5iAJ7?=
 =?us-ascii?Q?1aPUBnexNk2D2X6LnEinBjpudNeg8eXsKafk3XaayZlH8xyi2f7k8nJ/hST1?=
 =?us-ascii?Q?J23JUZm/N9ZFLPmY40Mndtb7Lc7r/R1ab1bGVtWquW9Yqi0ZtQg9sJutPwj2?=
 =?us-ascii?Q?aMjCSNf5ZggW61hEtwmcuu6lVrsV1y9cwg17jat8DHpGPMAlUiKdd8bQtgsU?=
 =?us-ascii?Q?rc20a3ggoehgtySPN3C88kQ2kCBXYQIhut24MckRAXKDtTNvNlhyIupj3LMW?=
 =?us-ascii?Q?G5dnK8ONRPZV9AMragrvR4hdvKm+3ASsE1NwsUH8G6PIs4uqhDns2eBaCysa?=
 =?us-ascii?Q?dcS/EMmx0+yHScyp1t2soL3FE3c8rzaPTteThgrUu/pS0o9OKmRnKVYXHGMV?=
 =?us-ascii?Q?WcNXCzXqRKloRmPTF0b7iQqcNvLCifmJZ7hAlvCu8SiNeQX45FBOiFXFZjBX?=
 =?us-ascii?Q?b/IjBTq0k/1tsvcgXDLkMOdCvRd86FOfd0pjGgvq/ficzghtn5dn/FkYlxLm?=
 =?us-ascii?Q?zc2o/iFcNz+TlRV/fcu3sCNlV9HzPrWwlmHo0Xnx8TwEJdFLNzJUIT0ruYQj?=
X-MS-Exchange-AntiSpam-MessageData-1: CcqpaLn9VI6KI+cD7s7hqUIn1r8oFlcGDCc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e63ebac-279e-42a8-a768-08df1fbe0a31
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6902.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 13:15:18.6423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNGlvbaUoVl1Hg7/0oPVjFu2yzkbv14Fm3vrZ+pIHvnGwxIdFq15GIlQRCMWFT22YofErm0Pu+pjgJu6Rh58lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11372
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Tue, Sep 29, 2026 at 07:59:38PM +0200, Vincent Jardin wrote:
> Check and if unknown display:
>   lx2160a serdes: unknown hwconfig serdes1:split, ignored
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> 
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
