Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D7AD3B7E2
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 16:35:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F38C83956;
	Mon,  8 Dec 2025 17:35:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="t5IEwxzt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4E1783981; Mon,  8 Dec 2025 17:35:53 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012040.outbound.protection.outlook.com
 [40.107.200.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31EC78312A
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 17:35:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBnQQuvt0x80L3yGIOlcMmSaV+uqAK3jYhlc07VILsufwGw6CyXufLVhx2wRk5vW4utYLx1kTrA2sbjW4yy8sq+hBaQIC+eEAsKbC0hFZGNr/nNtwct4+1Hq7rI5sF51/u/2cd2Dd9LfMbhnBldY2tMiPO0xwtGHvW0J6g/G9pQB4wba9WyyK4BBW6cQq4Nyr+Qogu4CKtyNV4RQev1s9nk+cWgRuUmBa9FeMn8DrmdHQDjPJrFHtmYYwIsqgffI7/72yzGgg+jXHnRNHLco+gb23PKfr+22wXwMVSkW6/BvsFEP6gpkNZi6xILAMb5zH7Rw2TisCiQmX8Iue8HvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mujGDwkkptuE/MqmkAuLZ58cg0VvPCUSAz6suEzNhqI=;
 b=OvJD/0afZB7Q8XFLTvjaEC+D3mg/1QYOGu3/zgmheIf+oDK0dItlkAj5KdtalautQ+UfnllDpEq+Er30W2fpnOoxgltld6tVuYHJPNfCdgNdEIH6Qcm4dwUfGfiovHA/S1wGJ8QkXhyrz4tAwN9mjI0tLccn+e8da9YbucsUH59zk4PfvuqqTSiQz1mjCcwDVcjJXUtJWkWIHGohrvBJAqoCspyxuPGx5XJ2gwm8Ai6HBK3CJBh0iD+3GH53Jmzc9q8WP/NBAM3jFXC1C5CFRbY8whO4bVURCsJU49bUX/s6dIKtJifnkYVLddJLyRq1zNc0cEWoLppBhlOqhG8Fig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=amarulasolutions.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mujGDwkkptuE/MqmkAuLZ58cg0VvPCUSAz6suEzNhqI=;
 b=t5IEwxztPGE6pxdZsflJC/I39n4Exnl6UTJ4F7fT+OsrhnVZVc/j386Ss8HHEsPOFcg2vt46F8SHf3E1xQi+mtCTlHwiY+4QPOgyddBndjAhpHP+FfEXDer3mtkNAE9UN5BayI1Nfo6Fpio9hFx6z/bhZFL93JXPETKT32imF0w=
Received: from CH2PR10CA0020.namprd10.prod.outlook.com (2603:10b6:610:4c::30)
 by CH3PR10MB6786.namprd10.prod.outlook.com (2603:10b6:610:140::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 16:35:33 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::7d) by CH2PR10CA0020.outlook.office365.com
 (2603:10b6:610:4c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 16:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 16:35:32 +0000
Received: from DFLE108.ent.ti.com (10.64.6.29) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20; Mon, 8 Dec
 2025 10:35:27 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Dec 2025 10:35:27 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Dec 2025 10:35:27 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B8GZRlK3917043;
 Mon, 8 Dec 2025 10:35:27 -0600
Date: Mon, 8 Dec 2025 10:35:27 -0600
From: Nishanth Menon <nm@ti.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, "Sean
 Anderson" <seanga2@gmail.com>, <u-boot@lists.denx.de>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Christian Marangi
 <ansuelsmth@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, "Marek
 Vasut" <marex@denx.de>, Simon Glass <sjg@chromium.org>, Jonas Karlman
 <jonas@kwiboo.se>, Ye Li <ye.li@nxp.com>, Michael Trimarchi
 <michael@amarulasolutions.com>
Subject: Re: [PATCH v2 0/3] clk: Return value calculated by ERR_PTR
Message-ID: <20251208163527.oq7vddgodao3legu@unguided>
References: <20251121-clk_uclass_fix-v2-0-74f4ea10e194@linaro.org>
 <176503025989.2523567.16347058613411695182.b4-ty@konsulko.com>
 <20251208153226.moktyjv3irmjlg6q@lingo>
 <20251208153852.GP303283@bill-the-cat>
 <fd494719-1152-44c7-9de8-0e9a370c659b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fd494719-1152-44c7-9de8-0e9a370c659b@linaro.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|CH3PR10MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 0600bdc1-73b8-4ef1-6d53-08de3677ce54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O7i5lM/n1fUyYfBS2uErRxzRwfDVlXUbXf54X0fW11wGftNsUgbJpQwHREJj?=
 =?us-ascii?Q?O5iBFLBe9+6miRIKt1ITMAm5gTIH5Ju586DurIdon6wV3CGnyGRTm7+qae4o?=
 =?us-ascii?Q?S0tSLbD5ga1qRdGKBpu+tpg+Y9Bmmba1v6gDEbrayIMAZqXt5hLkpw2ju/Nx?=
 =?us-ascii?Q?fw84L24GR0+4UAIO8OpPCgUQmz26ls6d/SOONT2RqadfTWdzpadVD2EvibOf?=
 =?us-ascii?Q?w/tgB9utbCJj8ddaLeCwjyA4zliGQIoHmOTA9tcRdZC6AyQmwrwIaJj/tzPI?=
 =?us-ascii?Q?cNAWB0b2JxIpgTQ086nQlJJAiDC1+MbofBtmwvNlN1kdlWmd2xUo5gCKIoIt?=
 =?us-ascii?Q?QKIgDQzkixCdKfwbKLN0WajRJLF6k3xLsO175nOBt9cMM6kqtpasGcqSzUoj?=
 =?us-ascii?Q?WyE/A4YWaeODio08/oDg+xK41batBpz8xYJafsAYJWFuwZzsnzUIRLPWZzKX?=
 =?us-ascii?Q?9C4EFm8k1UV01DvonXN8AO5LynFQa5HpuKyH+TMdbfVcOj1eL9FQti3hUj2T?=
 =?us-ascii?Q?2v8mUtdnZn422sELPLCbAQYyyaMo3vt0TCKYSlpYYLUtytJF8Y3O7LiZ+4hu?=
 =?us-ascii?Q?PIDhKYaPB9Zw8J4abdAP0FefG2PjBeYVny+st32hC7eJgs2zBBveSdjGTp/9?=
 =?us-ascii?Q?KZDtazT1ZxenWwvtgntH+7Rz5CPdCcRwwnWLRBdaD7x5h+vstF9AJsQATQcL?=
 =?us-ascii?Q?xf2wFO6bjxp3A1F7ZuZADE67za1g/yeHo3fHcIeYGS6Yd+MmceB2vpwc5TQB?=
 =?us-ascii?Q?HKF+rN5HCZ5ECxvtt9HLfZ5GCGiF/SUg/zUxC+LrZZtz3PtL/B/oFkkdImL1?=
 =?us-ascii?Q?ZV7m1q9QFgCnXC383hTFH5oY2Q4/oh+oe1HRMZEuTYq7Xn4IWH2bR08RS7F9?=
 =?us-ascii?Q?qwuxiI3uqfe+DK+/lX0g+XHGkB+tXyzZBfyyUWQP/ZRo939eg7c5oRaZjRkx?=
 =?us-ascii?Q?vfV5yggIju0sUORwhxOGicJL2qspprZ8HnmlMgLAFmEjJGOE1+folnwzD6AV?=
 =?us-ascii?Q?2Zh2bJ9AqUluOXoBB6VxKzWlwZ2G9rKuIJnb73ItkQCiFR16rl0BeiJcFAAM?=
 =?us-ascii?Q?zOGuZw5mpQ0jzpRp4xF2DYj6sq7tb3KjhZvsDpIbfmGKPwedV6Yaa9qD8r2E?=
 =?us-ascii?Q?v4ddWOpNqX/yWnwFHQMEHOhhZ0vR1ZBhFBlWbywOA7PwtRSRYf+uQ/Kf4GZQ?=
 =?us-ascii?Q?gp96SF9mqOkOHpOhbhYP+HOkzBE+nQ4y/QpbgaO7L7YaL+tKhPNNE8FS6zDN?=
 =?us-ascii?Q?uJumzhAN5K/k9XsuLBtyLhKmAe9l6hJYweg65rAreDzdPOYHqq4LvuDz7CUB?=
 =?us-ascii?Q?Wl3KWTdj74p15PsoGW+6aF5EYd8K2lA2jvY4RKMjCN+CG5C0socHixNS1DbQ?=
 =?us-ascii?Q?xN1HlTaSxS8KVJ0bu4gaYj+zPhRX82vuncg58irZ0RxjoK5tGKneLbR6xUGD?=
 =?us-ascii?Q?V5AIyQK8rFhP9E6RwN5sS9qSfXhbDyJS/N1GX7ynQ9V0vjGlsUM1xCKypFCo?=
 =?us-ascii?Q?SCcbVhQtZH/8OoUKuUnQKs0nuGv0ELRNcaxK?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 16:35:32.3317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0600bdc1-73b8-4ef1-6d53-08de3677ce54
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6786
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

On 15:52-20251208, Andrew Goodbody wrote:
> 
> 
> On 08/12/2025 15:38, Tom Rini wrote:
> > On Mon, Dec 08, 2025 at 09:32:26AM -0600, Nishanth Menon wrote:
> > > On 08:10-20251206, Tom Rini wrote:
> > > > On Fri, 21 Nov 2025 17:34:30 +0000, Andrew Goodbody wrote:
> > > > 
> > > > > Smatch reported an error where a value calculated by ERR_PTR was not
> > > > > used. Fixing this to return the generated value led to a test failure
> > > > > which meant updating the sandbox clock code so that it would still cause
> > > > > the tests to pass with the above correction.
> > > > > Debugging this problem led to a SIGSEGV which is addressed in 1/3.
> > > > > Possible memory leaks noticed are addressed in 3/3.
> > > > > 
> > > > > [...]
> > > > 
> > > > Applied to u-boot/next, thanks!
> > > > 
> > > > [1/3] clk: Prevent SIGSEGV on debug
> > > >        commit: 1c0a46e2918a1ddf42f51449e45077513dd52417
> > > > [2/3] clk: Return value calculated by ERR_PTR
> > > >        commit: fe780310cfa8bf5a093894b5cd7fe85c6b02fd91
> > > 
> > > This commit seems to have broken TI platforms in next branch.
> > > 
> > > u-boot$ git bisect log
> > > git bisect start
> > > # status: waiting for both good and bad commits
> > > # bad: [bc1819331ece7aa4e7d0573c9cdacdb8efbdb067] Merge patch series "clk: Return value calculated by ERR_PTR"
> > > git bisect bad bc1819331ece7aa4e7d0573c9cdacdb8efbdb067
> > > # status: waiting for good commit(s), bad commit known
> > > # good: [384d3785df4dbe452f9fbb4bd9c9c9e986cdc205] Merge patch series "led: remove unused legacy LED code"
> > > git bisect good 384d3785df4dbe452f9fbb4bd9c9c9e986cdc205
> > > # good: [1e8eff6d7a9ad2c605185e5b3d8c22ccd26733dc] board: ti: CAT24C256WI-GT3 require min. 5ms delay (tWR) between write/read
> > > git bisect good 1e8eff6d7a9ad2c605185e5b3d8c22ccd26733dc
> > > # good: [1165e8efcba0ab3efd1ea4ff956d26746fc386b0] reboot-mode: Correct macro name from U_BOOT_DEVICE to U_BOOT_DRVINFO
> > > git bisect good 1165e8efcba0ab3efd1ea4ff956d26746fc386b0
> > > # bad: [fe780310cfa8bf5a093894b5cd7fe85c6b02fd91] clk: Return value calculated by ERR_PTR
> > > git bisect bad fe780310cfa8bf5a093894b5cd7fe85c6b02fd91
> > > # good: [1c0a46e2918a1ddf42f51449e45077513dd52417] clk: Prevent SIGSEGV on debug
> > > git bisect good 1c0a46e2918a1ddf42f51449e45077513dd52417
> > > # first bad commit: [fe780310cfa8bf5a093894b5cd7fe85c6b02fd91] clk: Return value calculated by ERR_PTR
> > > 
> > > Confirmed by reverting the commit. Looks like
> > > 9ed8fafbcde3425d8817ec5953edd428c7508153 revert is needed again?
> > 
> > Interesting, OK. What Andrew did in commit
> > fe780310cfa8bf5a093894b5cd7fe85c6b02fd91 is more complex than before and
> > there's two stanzas there. Our lab is current being re-worked again
> > right now so I can't test on the K3 platforms I have, but can you please
> > see which of the two changes in clk-uclass.c is the one that breaks
> > these platforms? Thanks!
> What is the breakage please? I did put this series through CI and the only
> issues were due to lack of disk space, so not related to the patches.
> 
> Andrew
> 
Looks like A72 would'nt get started.. adding a bit of print to get an
idea:

https://gist.github.com/nmenon/c0487b99cbd2308ccd11ffe510a780bb

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource
