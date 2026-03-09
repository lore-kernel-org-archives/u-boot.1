Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8542CF3C24A
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 13:08:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6CFC83BC7;
	Mon,  9 Mar 2026 14:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dqTiIsQf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02C4A83BC8; Mon,  9 Mar 2026 14:08:46 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4A488063E
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 14:08:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+dW9rv/VQBqrAhC1ds1E9TQoOUH7vSwtPu352AXsbX4MQueMHbT8iKNahld36ZeBE+Gn1+2gvTCYdGkj1urHzaJF7sehJ/lg4SGPsvNKrHaT1DjhvpFehHrv5ZNqW6WylNrqdgIKzgLwLHgn8mQ9vmVuP0VgM1LA/cNWXA/FYU4hNCtjhLVpwiHFqCj6INYhFNhsl4bVk0ZdgOJW7U93EX4V/ByZSTDis/yBlbMyliBXfBud9HYlqKw6xFbBHFaOS+DeprsMhoe1RYhflheOZbfR/LAsa+E4hO2mClsikQedRiu+5C06F2Eoe3rYrp+w7PjSRLWdC9cuP4W354U4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWzIomdVrGGYm8RYUGDcTtPRE+aYNDy4uktF94vTO1Y=;
 b=nEuvhrRC7RyvZgI0Eb8YcYALlJaLJFObyeDdUevQ9LUeGGYqPW6Dp2TkjMPizYz5E8yXnrPzUBbKEnJsFV1oADM2yIvvPM4J9bFBNBYS7F2U0t+hrhbOPu0pLuiYSzIzi0ld341Css2wAaU5L1iX4KZYEjE+J3NtG85ycgg4nqjaFPgcu0guES66w/i6S1Y9u2XQLA6+Z6MbBN7KbdC92Sy95FpNDcTc602FZjfQNW/9OxJ13pIeWaquvJx+vle2SNblJzxJcscsjLby7M8g/2r9BuOi9JaCKjAIzmj0jIbad4PzenzrEfsJCJwsZgYcgSNAD3fbSeLZKSEXYGA2AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=canonical.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWzIomdVrGGYm8RYUGDcTtPRE+aYNDy4uktF94vTO1Y=;
 b=dqTiIsQfmiM4f9pqIMcX9WnQH95z+4qQvJVt9xvEXc/9vyf87Tc2X8hnaRbRtCGcVgAZurlRsX26Yq2Bn/gjksUnCpoyKceLuZ8UbYvP/zKsTPH+SPR3u0ZopjhXa3bk6hkoNm2MXC/MyHTz1F4hfWyNDJGsZB4v+VLHBz21mnc=
Received: from PH7P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::11)
 by CH0PR10MB7498.namprd10.prod.outlook.com (2603:10b6:610:18e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 13:08:34 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:510:326:cafe::46) by PH7P220CA0024.outlook.office365.com
 (2603:10b6:510:326::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 13:08:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 13:08:33 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 08:08:26 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 08:08:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Mar 2026 08:08:26 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 629D8QsU1142343;
 Mon, 9 Mar 2026 08:08:26 -0500
Date: Mon, 9 Mar 2026 08:08:26 -0500
From: Bryan Brattlof <bb@ti.com>
To: Aristo Chen <jj251510319013@gmail.com>
CC: E Shattow <e@freeshell.de>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <al.kochet@gmail.com>,
 <paul.henrys_ext@softathome.com>, <y.moog@phytec.de>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>, <n-francis@ti.com>,
 <afd@ti.com>, <d.schultz@phytec.de>, <d-gole@ti.com>, <ravi@prevas.dk>,
 <carlos.lopezr4096@gmail.com>, <quentin.schulz@cherry.de>,
 <alice.guo@nxp.com>, Aristo Chen <aristo.chen@canonical.com>
Subject: Re: [PATCH v2 0/7] mkimage: Detect FIT image load address overlaps
 and fix related test/DTS issues
Message-ID: <20260309130826.xz7m33vj672hthz2@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20250924113733.uz6hozszbuynemtc@giddy>
 <20250924114317.742ae4ntrb4mvuyq@expert>
 <b07919da-f3fe-49ca-8f76-ab057d8af58a@freeshell.de>
 <CAJwFiGLHDEPMsFyBhX=ogQxX_C+8ac-_9_jeiZYyo=3o0M8ZHA@mail.gmail.com>
 <CAJwFiGLXgsnb75HT45L5Xo-N4LmCBeLGwPi8Yr5zZzNo7mrVNg@mail.gmail.com>
 <873d73f0-34fe-4445-8745-f98734637b0c@freeshell.de>
 <CAJwFiGJsnK3CRhYBYmE0fGpds0AOvVhRv___JaBNPjGhiYRCNA@mail.gmail.com>
 <CAJwFiGKVqRsNjvhd4Qjo8S8AxVMTpTvxu51tCaJA6j6a+7-RAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJwFiGKVqRsNjvhd4Qjo8S8AxVMTpTvxu51tCaJA6j6a+7-RAw@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|CH0PR10MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d5098d-4ddd-47a8-5e49-08de7ddcf7a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|14052099004|13003099007;
X-Microsoft-Antispam-Message-Info: TzVfN10LvzxNNAPBzxgfh/XfBbPLyHnTh3kMpoH2GB9i3LhW4xeYIMAHmR4tKz8JugXYrZgOueAB908p73YyHm/MEKSwdb6dDf7qwIYu2AXQwkI14rcdEO9BjFHFQb7/s6rl5stnDie3Zc6jALGuB565bfuGpJvCYPuB3TNYegzQu6FiirKWiOgBT4R4xdyq/7UugjR7tWGhlklozoCjywV9s9m1F/gulZQGpZmfS9BBokWxHeN808O+2QYTCzDgDU/N8ZgD9Kdb7FUDN9/gmdyQMKZGvHwV/rIAk0Nqo627Wk8CV/txGfIsbNUtwftDMl7tslEcKvVK5iZzJpljUocrUkaErD9VKCbgbPh07efIxyPB7e5vJXgdnUM0at0Hcxb8HJMgHnyMozPoX2A64hI5yqKVQg7jtN7yQbIwyPMgm7YRervT01urIPk7qxYSEe+l3mbT7aFp3TfcVVCB9o/EQ+XCZxoqIhxwDwSm7lxNfV+iDSJ0oOJx4oR7Yioq5ctVFqetC30rmLo3MzVjFTd/f1mk/Xkkyr0uX3WLL0fnCP7la6sybYRUuSX+B1Mqb+tP0fP0UhmCgw0P4ydm5Qi9XaMavuFRm8yFqKj6pQmEG90C5pXI5c4YFHqYPx3GDkqj9JIJKwg3kOebVu+5KTiKNvO98QIliIGaGdAoZDcOJ13gH3hgiVBzXY2lsdeiUmLSbIOuXezYFOEqakoUTDGKFU38YywqkvqBjSkO4pQ=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(14052099004)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +JwQhfDnIHr7LFK56sFaVkZN1Kam0roJie1Yopc/v7xckzxRRC1lyOkhXq2xr4jgoyXW7x8SrjpDPU6IzQcsN1OpEQ1RIpLl7ze2cmdXrbvNhwIKM1sVi5BWkksIzDDyNpgSiR+hnZJs5No4tCWILXuxU6J21bwODAnPO9Xt2GxP50d/zakWGFpeN9AOCDEeN+Ji0GK+KI3z94r5JhUeDjtGv0HOLITK5Fh5lyHiQp+33eHBLuqJrTQES7A2sSdEBTOhTUU/+Kzc9BmqJse+yEi+M4LeIfW6WYkcHC9LFYXcfkZUSEUVdBUBH2dMtTymqx5F9Zhk9ABIArS5TkSUysTfPfCNBwONHjyc5K+nHb074V+2Fssgn4o2Ko3aG62IQA06DUBQaPjMtDpBToTk/Jb2s2TffYitcCxaY8tm7Mhr01ChNK/lrPEMsrLhULb6
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 13:08:33.3480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d5098d-4ddd-47a8-5e49-08de7ddcf7a6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7498
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

On March  9, 2026 thus sayeth Aristo Chen:
> Hi TI folks,
> 
> I have put some thoughts in the github issue[1] that we are discussing
> FIT image spec, could you please take a look when you have time?
> 

Absolutely. Sorry for the delay. I think I have a github filter set long 
ago which probably needs adjusting.

~Bryan

> Best regards,
> Aristo
> 
> [1] https://github.com/open-source-firmware/flat-image-tree/issues/32
> 
> Aristo Chen <jj251510319013@gmail.com> 於 2026年2月10日週二 下午4:16寫道：
> >
> > Hi E Shattow and all,
> >
> > E Shattow <e@freeshell.de> 於 2026年1月14日週三 上午1:29寫道：
> > >
> > > Hi Aristo,
> > >
> > > On 1/13/26 07:09, Aristo Chen wrote:
> > > > Hi E Shattow,
> > > >
> > > > Aristo Chen <jj251510319013@gmail.com> 於 2025年11月5日週三 下午8:21寫道：
> > > >>
> > > >> Hi E Shattow,
> > > >>
> > > >> E Shattow <e@freeshell.de> 於 2025年9月24日 週三 下午9:31寫道：
> > > >>>
> > > >>> Hi Aristo,
> > > >>>
> > > >>> On 9/24/25 04:43, Nishanth Menon wrote:
> > > >>>> On 06:37-20250924, Nishanth Menon wrote:
> > > >>>>> On 10:59-20250914, Aristo Chen wrote:
> > > >>>>>> This patch series enhances FIT image robustness by adding **memory
> > > >>>>>> region overlap detection** to `mkimage` and fixing existing overlaps
> > > >>>>>> in DTS files and `binman` tests.
> > > >>>>
> > > >>>> [...]
> > > >>>>>>
> > > >>>>>
> > > >>>>> Looks like i see a build regression in linux-next after this series.
> > > >>>>
> > > >>>> I fat fingered that one.. sorry, I meant u-boot next.
> > > >>>>
> > > >>>>
> > > >>>> Fails at commit 4d84fa1261eb, last pass was on commit d81c1118580f
> > > >>>>
> > > >>>>>
> > > >>>>> https://gist.github.com/nmenon/b2fc9e7680cc296062c7dced94105f76
> > > >>>>
> > > >>>> I  believe there are outstanding comments on V1 that have'nt been
> > > >>>> addressed either. Can we revert/drop this series for now while the
> > > >>>> comments are addressed?
> > > >>>>
> > > >>>
> > > >>> Similar to Nishanth, I am seeing a build regression, itb.map:
> > > >>>
> > > >>> ImagePos    Offset      Size  Name
> > > >>> <none>      00000000  <none>    itb
> > > >>> <none>      00000000  <none>    fit
> > > >>> <none>      00000000  000c1698  uboot
> > > >>> <none>      00000000  000c1698  u-boot-nodtb
> > > >>> <none>      000c1698  00202128  opensbi
> > > >>> <none>      00000000  00202128  opensbi
> > > >>>
> > > >>> Yields this error:
> > > >>> ...
> > > >>>  MKIMAGE fit-dtb.blob
> > > >>> Warning: not able to get `load` of node 'fdt-1'
> > > >>> Warning: not able to get `load` of node 'fdt-2'
> > > >>> Warning: not able to get `load` of node 'fdt-3'
> > > >>> Warning: not able to get `load` of node 'fdt-4'
> > > >>> Warning: not able to get `load` of node 'fdt-5'
> > > >>> Warning: not able to get `load` of node 'fdt-6'
> > > >>> Warning: not able to get `load` of node 'fdt-7'
> > > >>>   CAT     u-boot-fit-dtb.bin
> > > >>> ...
> > > >>>   MKIMAGE u-boot.img
> > > >>> Warning: not able to get `load` of node 'fdt-1'
> > > >>> Warning: not able to get `load` of node 'fdt-2'
> > > >>> Warning: not able to get `load` of node 'fdt-3'
> > > >>> Warning: not able to get `load` of node 'fdt-4'
> > > >>> Warning: not able to get `load` of node 'fdt-5'
> > > >>> Warning: not able to get `load` of node 'fdt-6'
> > > >>> Warning: not able to get `load` of node 'fdt-7'
> > > >>>   COPY    u-boot.dtb
> > > >>>   MKIMAGE u-boot-dtb.img
> > > >>> Warning: not able to get `load` of node 'fdt-1'
> > > >>> Warning: not able to get `load` of node 'fdt-2'
> > > >>> Warning: not able to get `load` of node 'fdt-3'
> > > >>> Warning: not able to get `load` of node 'fdt-4'
> > > >>> Warning: not able to get `load` of node 'fdt-5'
> > > >>> Warning: not able to get `load` of node 'fdt-6'
> > > >>> Warning: not able to get `load` of node 'fdt-7'
> > > >>>   BINMAN  .binman_stamp
> > > >>> Wrote map file './itb.map' to show errors
> > > >>> binman: Error 1 running 'mkimage -t -F ./itb.fit.fit': Warning: not able
> > > >>> to get `load` of node 'fdt-1'
> > > >>> [Config: conf-1] Error: Overlap detected:
> > > >>>   - uboot: [0x40200000 - 0x402c1698]
> > > >>>   - opensbi: [0x40000000 - 0x40202128]
> > > >>>
> > > >>> make[1]: *** [/tmp/u-boot.2.git/Makefile:1339: .binman_stamp] Error 1
> > > >>> make[1]: Leaving directory '/home/es/build/u-boot'
> > > >>> make: *** [Makefile:198: sub-make] Error 2
> > > >>> make: Leaving directory '/tmp/u-boot.2.git'
> > > >>>
> > > >>> If you would like to reproduce the issue, use config
> > > >>> starfive_visionfive2_defconfig and pass to OPENSBI env variable the path
> > > >>> of opensbi object 'fw_dynamic.bin' built using PLATFORM=generic, with
> > > >>> the ordinary gcc riscv64 toolchain. The starfive visionfive2 board
> > > >>> target in U-Boot supports multiple vendors and boards selected at
> > > >>> runtime and is an example of a more complex FIT usage that you may be
> > > >>> interested in for comparison and testing.
> > > >>>
> > > >>> Best regards,
> > > >>>
> > > >>> -E
> > > >>
> > > >> Sorry that I didn't noticed that my previous email sent to you was not
> > > >> including other people
> > > >>
> > > >> Long story short, I am now able to reproduce the overlap issue that
> > > >> you have encountered, and
> > > >> I spent some time trying to understand what is opensbi, please correct
> > > >> me if I am wrong
> > > >>
> > > >> AFAICT, there will be 2 types of firmware built, one is
> > > >> `fw_payload.bin`, and the other is
> > > >> `fw_dynamic.bin`
> > > >> - fw_payload.bin: contains the next-stage binary, so the file size
> > > >> will be bigger
> > > >> - fw_dynamic.bin: provides information about the next boot stage at
> > > >> runtime, so the size is smaller
> > > >>
> > > >> and here are the size of these 2 files built in my environment
> > > >> ```
> > > >> -rw-rw-r-- 1 ubuntu ubuntu  273048 Oct 25 14:49 fw_dynamic.bin
> > > >> -rw-rw-r-- 1 ubuntu ubuntu 2105656 Oct 25 14:49 fw_payload.bin
> > > >> ```
> > > >>
> > > >> When using my overlap checking mechanism, and passing the
> > > >> fw_dynamic.bin to build U-Boot,
> > > >> there is no overlap issue. However, when using fw_payload.bin, there
> > > >> will be an overlap issue.
> > > >>
> > > >> AFAICT, the SPL will load the opensbi firmware(assuming fw_payload.bin
> > > >> here) first, then load
> > > >> U-Boot into memory, and then jump to opensbi firmware, so I was a bit
> > > >> confused why the
> > > >> overlapped opensbi still works?
> > > >>
> > > >> I will find some time to figure out how the whole loading/booting
> > > >> process looks like, but it would
> > > >> be greatly appreciated if you can share some insight, thanks!
> > > >
> > > > I finally had some time to revisit this and managed to get a VisionFive2
> > > > board for local testing.
> > > >
> > > > While trying to make it bootable I noticed the following docs:
> > > >   - https://docs.u-boot.org/en/latest/board/starfive/visionfive2.html#second-stage-bootloader-opensbi-fw-dynamic-bin-u-boot-main
> > > >   - https://wiki.gentoo.org/wiki/StarFive_VisionFive_2#Building_OpenSBI
> > > >
> > > > Both appear to recommend using OpenSBI’s fw_dynamic.bin when building
> > > > U‑Boot. I couldn’t find any guidance on using fw_payload.bin together
> > > > with U‑Boot, which made me wonder why fw_payload.bin was used in your
> > > > earlier report.
> > > >
> > >
> > > Likely I mixed up the filenames when writing in conversation, as I did
> > > when writing on the opensbi mailing list about a dependency tracking bug
> > > in opensbi build system:
> > >
> > > https://lore.kernel.org/opensbi/0d6bf7c7-7605-4ad6-a35c-54efc5230fb8@sifive.com/
> > >
> > > and
> > >
> > > https://lore.kernel.org/opensbi/36cfe431-40fb-470d-b50e-00a139d480f8@freeshell.de/
> > >
> > > ...which is clearly a mistake to write "OPENSBI=/path/to/fw_payload.bin"
> > > when it should instead be "OPENSBI=/path/to/fw_dynamic.bin",
> > > acknowledged in the follow-up message:
> > >
> > > https://lore.kernel.org/opensbi/32873fc7-2cc8-46d5-9f4e-3a16cf95f48a@freeshell.de/
> > >
> > > > Could you clarify whether there is documentation (or a specific
> > > > requirement) that calls for fw_payload.bin in this flow? If the intended
> > > > path is fw_dynamic.bin, then the overlap issue disappears for me
> > > >
> > >
> > > For the VisionFive2 and derivative boards, I intended to refer to
> > > fw_dynamic.bin only. If I mention otherwise it was in error or for not
> > > knowing what I'm looking at and reporting more information than
> > > required. There are RISC-V boards not related to VisionFive2 or its
> > > StarFive JH-7110 SoC that do use the fw_payload.bin approach but I think
> > > I just didn't notice the difference when transcribing to e-mail.
> > >
> > > > Thanks for your help and guidance.
> > > >>
> > > >> Best regards,
> > > >> Aristo
> > > >
> > > > Best regards,
> > > > Aristo
> > >
> > > Thanks very much for the follow-up,
> > Thanks for letting me know that StarFive VisionFive2 is not affected
> > by my patch!
> >
> > >
> > > -E
> >
> > We’re currently discussing a new proposal[1] for handling TI platforms
> > in the FIT image spec. Ahmad Fatoum has a few questions about
> > TI-specific implementations—could the TI folks on this thread please
> > take a look when you have a moment?
> >
> > Best regards,
> > Aristo
> >
> > [1] https://github.com/open-source-firmware/flat-image-tree/issues/32
