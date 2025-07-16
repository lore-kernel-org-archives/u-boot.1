Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6366AC83F1B
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 07:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DD04831A2;
	Wed, 16 Jul 2025 09:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="CO9EbGIF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3DA483192; Wed, 16 Jul 2025 09:08:37 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E86B82E37
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 09:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dqwy2aLR/JF5uvDfseRdPbJo4n1C+fy17v7B4Swb+mCO6LhpurrDOvc7QM7bfJ3f9pRehWQjQ7lwAexyK3fKoxxVLvVcxj/D1HUeQN/ZoCYHUo4WiGEMHlMFM7IT2mwg4bAM+PED577ifaYW51PSuLYXr/zWHyhAIiDL9m6TC8vANlX1wSFykW6Ybmzue23xuMZmApf867Fzx0cGCXPQBFcf5Jmdv5fIcbkGHFTnSgzyB15oroN/pW4RpKa4UgLZSQJVtL48PnVweBO/1/yDm/HKh1ZR/eW4XexzZYBYPbaIQRjjQB1I9JHTcEJs468RCpMn1KNrGGST75gN6q1okg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=we65j62/HBOwnYMX15wb7S1RiQvp/Gfn/8+GLANMnuk=;
 b=x3IaUW2TR+bKY+eA5+Sz4HmkpS9Y/lMm+QTWPB3BVsV1u6jZVGFrop2FLmvX1eN3k883764mNXz/A78/WdMSq0wRB3d6tMki/LtSD4j9n7epzoXAG4JlheMAKMpktgi34MMIOQ9cLzcosppLHZReeiX4vrRl3U3iWlWIp6U+CKZJ3z2pCg1cR7lVz/OfEa2zg5yz7OoADxhobPV+u0kbSxC0khRweT9IqQy8Ws4WElUt2muaxZAYKwTmAdhjidaV/PZMEceW3wLR11WXC3dItPAueBoEsW2+wyVZSP8nWbC0psvA1z6XNifIaOfvma40zpA+idyidcqMi1+OHLOHUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=we65j62/HBOwnYMX15wb7S1RiQvp/Gfn/8+GLANMnuk=;
 b=CO9EbGIFGWO+vYwGGMseymc/fR5RUZH/aPmkmVIJzD8X0ypOCARJwH/5RoE9y8QlGthqRxFQSfwWJsuwG7oRk3OJOiRyBx348RQrjWbIFfGVi1nJhD6w9zeGmCDr0FUPk2KLno1dRHNzsGxplkn1ANYIr92tJDq3Jp0o+4oqmstUrUHjwNl/2ipqeBIL8IlM6tkbT2vCMT+B181dtmLpcA9FsjO4fn/ACLeVBROzNP+Ef+64ikQeQSOmBcHPPARNUD0enMqFdfGeKNcLUj5DIqKR76e13A6uV26SPXEopOQA/Ahpcb399hi8FhRyMyYmlap/ywd9M+9O9mUOCQ4U7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH7PR03MB7170.namprd03.prod.outlook.com (2603:10b6:510:241::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 07:08:30 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:08:30 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>
Subject: [PATCH v6 00/12] Add Synopsys MIPI I3C Driver support
Date: Wed, 16 Jul 2025 15:07:58 +0800
Message-Id: <20250716070810.8030-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25)
 To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|PH7PR03MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: e72bdee5-0444-4970-c454-08ddc4379149
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MSxHYTqcNS11id7Vlqxx1d61J7pTeFFYNStGJPbq7N3OlXNT08eLkWvzh6hP?=
 =?us-ascii?Q?zvbhBBZn9MUETeKKcMAbVi7YoLReuYhoaOKQJwRn78M9GobRt/eXsu8fz3pk?=
 =?us-ascii?Q?7q4s2opwagyi6ukJK5YLziagE04onEcOOyKq2Z6jurG94H3xJkdlyQbbRxjH?=
 =?us-ascii?Q?VJ5gPZX/Iup2JsvSSgQLnx1VZyqIs+BpYaxG7DeUJpkBIpbvTeScL+U1pc/d?=
 =?us-ascii?Q?OZaIi7VguOmiV5S7MMHYjhhizYuTibZJvajPK9ljS0ARSf/2HwN0te7tf//b?=
 =?us-ascii?Q?vTnGnW9P0AUaf2fJxNDNQphogavt/lFLkET8bXWnpWH7Fk1Yzm21/o5ZYZ83?=
 =?us-ascii?Q?a8nproxW32syWkvL1YSFOA0MQ/IuESyTEX39v+KxoEdHgZN3ttfGRJUmKLb6?=
 =?us-ascii?Q?X0L8EB9dekBkSnlT7nalftsCCEXnoGdp/csNamqL/pB86zguZmVj9Tb4B0z+?=
 =?us-ascii?Q?Cr0GAw8B8Qab51w8/RZdkF4v8+OxJq63DrAmYodzNYsoJZinIVA6P1bGtNTT?=
 =?us-ascii?Q?IyZcwu+lppekFzSQ9ItuFOVmwsLekmaV1n4xTHuSvWKy6yl3ofAOcWkPqnQu?=
 =?us-ascii?Q?cfKFPOdgvjRInSUJI8hQasPsXRbZ1uu5Tk4lYF9YkmP34iaEHl4xeJPBSL14?=
 =?us-ascii?Q?D/frQBxsGj/TTuWIFpd/NTsbXfmoFCzE5XoAe4ynhm7m0gqMyRUk9aVGc6dt?=
 =?us-ascii?Q?shM3AaVD6v7TrLdi8q/gUZG6sN2lLueC74RNaIBRT1a903ffdKuYH0l6ii9h?=
 =?us-ascii?Q?VvBue+FdaB86nnw1BDdgyfVOrbs75oK5Jm1jYAzonmXY6td7yoPVjU0R5pYv?=
 =?us-ascii?Q?Q2QRV3aQAKcDEmx7SIPcMMWI1fdoebpyYioEP0EK9S57KM0HTXGfcOzXJxJr?=
 =?us-ascii?Q?/qfzpqeoU0cDBuzLzveuwtRbXZGZ0MPE6Tl4RLOUQ14sWJw6Gk1vKMUUyHc+?=
 =?us-ascii?Q?h4hIpw68kzlOnnaHky+QlhKLMyYpU9+v7dNJM30GbX784n4G8bBA8ndOjp8b?=
 =?us-ascii?Q?EE3BcokfJyVwvwF9P4Mdx0sxbB6mPGEH8c6bCPFsPWCy5n05iPt3dAO1+I9/?=
 =?us-ascii?Q?cDQ1NfygTlgaxheKWsCaIsFzw6u0cp2EE0HejG/i9H9CCy0fGXXL2GKsVW8Y?=
 =?us-ascii?Q?vjOs26J+54KVBduQ3Y/n5MFSMVSmWIm2ReA7sbh16CNwjXBULv6Sfwq8LV4y?=
 =?us-ascii?Q?s1CS/jKRHv1WWYdQqlEoLAn98zyk9g9fRiCRbdlfN5F/1h0na7ymC6Pgo/tJ?=
 =?us-ascii?Q?Ab6s6BC/hj6xjbsCWPFmnA8wnxC3B7FJVJMOyVRObHFu/Vf/xpWPu+2fSf46?=
 =?us-ascii?Q?12ZCTTWmr2WVivgKLRf3nIFHBjTIWtjKr2qzWtQxIXxw1TUa92SDankqDcZr?=
 =?us-ascii?Q?CZrLdP+/WNiocXxZef1OeSsgDnpuI1KVzGKxHrg5hFtoNtSlwCjNZEApych+?=
 =?us-ascii?Q?qadqwYUKaco=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9pvVg+GeM+X3JexRBL6n3xhSAMc3z+tq+7n2TMAa6YwPYwWJMvjkkUfC+D46?=
 =?us-ascii?Q?0oV7JG3nneBvRV/6Fb2WAd6wgkpxGdvDn6T16xScwHDpVdYL0MaSjfGSYYUv?=
 =?us-ascii?Q?HBe5uBYrMqDA392pxUba/agQpboCrM5tWG/JLD0C9H/zX6PqRC52LA5mMtgp?=
 =?us-ascii?Q?P+rmPCmrOoYkhaitNDS0dWVK59Fsa7ZFh8MQoH5UeJszVYTnzEM6jf3BUAsR?=
 =?us-ascii?Q?E4sCVFlrgDhT4JH7o5At9oJQgAY5V0lewyFqUm6YaqU2ScMwDrwyKsPSKm8o?=
 =?us-ascii?Q?I5/ajRCV1gGrz0vRhiVGjtSe8tO/VHCD4GflM0ht2/y5f/fgXfDlrho3mHpc?=
 =?us-ascii?Q?N+eszruXWoZbXD7iUM7mzwepBVd1i4qeMCBpbGK96rTC6dY45/zdfX18IAQi?=
 =?us-ascii?Q?HEd2Blp6j9FBHMao+lAmnUT673Nij6OrX5OG/3vdCDvvPaIA/Tvofbp0Njse?=
 =?us-ascii?Q?Hb2VxA6UObxyQ7jyWHI/5nnFRzsacTDWxzUCVGQ92eltfqZlKZ496w1hmLgg?=
 =?us-ascii?Q?a5AdKCgUxZMUSCUIRK4ZMVDFcyO5vNKL2b6L8q0ZM/wr/cl5IPwkGXYNYgNq?=
 =?us-ascii?Q?rlCws+TZyU450n+XTidxKnhNnHKn+Ea/RxUrXYghUoGfQP9epGbuHdSTv14j?=
 =?us-ascii?Q?EhtyBOsydEU+QxzO7coannu+U7kj9ES1AcLDuQ93HqInzXRX2bkCfwOkIEt9?=
 =?us-ascii?Q?mtJsmzzoPPUUGvPu8/nCe1Qv8ZkKycBrUUFQOYrpX+/8D8Kmw7WDscSgb5y/?=
 =?us-ascii?Q?cRpYHNaO3o0hVILQX0y8bnN+p8qp8zf1usI3kLht2+ByFlHFMx1j1LHV9EZ5?=
 =?us-ascii?Q?7LuQBUuKqhzpaGjl1kSmD7RpiRSFtzUztlYwI+StzwVwJPP5V3N5ta+IHp6g?=
 =?us-ascii?Q?8Iu3K/n5wGkGIeu2goAAun+9svkbTALVAyD4+W3HLLVBv6YR1n7fLGfDlUJj?=
 =?us-ascii?Q?nDJWh0xcvHVDSHi2hlZS6Ro3Da37Dd26+uyttZA/6N4uqv04aVdBkPgLOdIT?=
 =?us-ascii?Q?9owxNZXj8pwM6gZu0Bmjt/Tzb1XXcmxslnNEEcoS6xv54oUKG8T8wU6FOpKp?=
 =?us-ascii?Q?j5THpu6XguwhuakDCoN4ZL6oSzqGlWt7zd1Hs49SQlmB30m2a4XUMAQN2/Sy?=
 =?us-ascii?Q?9rheCLLhNenXa8+zVLe4D2JFhhDFcXliSlNYSGKFlb41v8mLINnRJKfDOF2D?=
 =?us-ascii?Q?UDzBQE/BjE+llT6G/ChxDp5TSGvHl5tZckoupwgJCRGwWO4S3iw/MDQyGXp0?=
 =?us-ascii?Q?xTi7cQpofK128m4lLXOMJwTOwdBLChO4vSDU0gbSlQHNT6Jy3eCgAU/0VRm3?=
 =?us-ascii?Q?tWy7szxsGfFWLUd+x/XX2Fq0OkHMn8EbS1pBDiulNUjyT2vlKQ67XYPXTXXH?=
 =?us-ascii?Q?03Aey8kQgZxjkCjalnTF4/w9iuXZkwUUWF8V9gdNYWuyy5Kapi/nERCVvECb?=
 =?us-ascii?Q?O/gzwGfQ/HE0BRS20gAEviiJnTf3hpD0VvSnTSgz4VXEt/9WwwzU1VWPuW7V?=
 =?us-ascii?Q?0QUgxl6jU3RuwJHEWLQeOM/KS0Yg2vVnO0IuFU6CUMxN1hsbcW10wHG9DzL3?=
 =?us-ascii?Q?7nUGyc7eJbQXHxGklu6KhpkrtBkLpgQ4z0B4TLqRk0tqj9W1C2Reb6PnRN6T?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e72bdee5-0444-4970-c454-08ddc4379149
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:08:30.0873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0yKGscrWJLV6AI4vZevaxDNs5KugCEPMATNDKyhpL4U8IDuGOG85k5n/wuurHr9CC1oz7Hwny/7nlHX5Og30Ih/qI4gyLinmPy6LWDklfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7170
X-Mailman-Approved-At: Wed, 16 Jul 2025 09:18:59 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@intel.com>

This patchset add Synopsys MIPI I3C Driver support for
Intel Agilex5 devices.

The i3c driver is leveraged from the master/dw-i3c-master.c,
i3c/device.c and i3c/master.c Linux version 6.6.37 LTS
And few header files included to be
part of the migration; i3c/internals.h, include/linux/i3c/ccc.h,
include/linux/i3c/device.h and include/linux/i3c/master.h.
Additional i3c uclass driver and command files added to support
i3c read and write in U-Boot.

Patch status:

Detail changelog can find in commit message.

v6->v5:
--------
- Resolved documentation warning in include/i3c.h
- Move declarations to the top in cmd/i3c.c functions

v5->v4:
--------
- Add header file to doc/api/i3c
- Rephrase function description for i3c.h 
- Separated subcommand as a function for cmd/i3c.c
- Used memory address to transfer msgs from i3c
- Rephrase description in cmd/i3c.rst file
- Replaced int with unsigned for positive variables.

v4->v3:
--------
Resolve ci test:
- Add i3c node in index.rst
- Formating error in i3c.rst
- Resolve cpu_relax undefined for sandbox

v3->v2:
--------
- Squash commit 10 to commit 9
- Resolve index for new files to pass the checkpatch

Commit: sandbox_defconfig: Enable configs for sandbox i3c
Commit: agilex5_defconfig: Enable i3c configs for agilex5
- use savedefconfig

drivers: Enabled Kconfig and Makefile for i3c support
- Add maintainer for i3c

drivers: i3c: Enabled Kconfig and Makefile for DWI3C
- Add empty lines for if/endif

drivers: i3c: Add i3c sandbox simple test.
- Removed DECLARE_GLOBAL_DATA_PTR

v1->v2:
--------
Reorder commits.

Added commits:
- drivers: i3c: Add i3c sandbox simple test.
- test: cmd: Add simple test for i3c
- configs: sandbox_defconfig: Enable configs for sandbox i3c
- configs: agilex5_defconfig: Enable i3c configs for agilex5

History:
--------
[v1]: https://patchwork.ozlabs.org/project/uboot/cover/20250218025705.50051-1-dinesh.maniyam@intel.com/
[v2]: https://patchwork.ozlabs.org/project/uboot/cover/20250314040902.43621-1-dinesh.maniyam@altera.com/
[v3]: https://patchwork.ozlabs.org/project/uboot/cover/20250324083704.26259-1-dinesh.maniyam@altera.com/
[v4]: https://patchwork.ozlabs.org/project/uboot/cover/20250417021840.6212-1-dinesh.maniyam@altera.com/
[v5]: https://patchwork.ozlabs.org/project/uboot/cover/20250513101913.30880-1-dinesh.maniyam@altera.com/

Dinesh Maniyam (12):
  drivers: i3c: Add new i3c uclass id
  drivers: i3c: Add driver for MIPI DWI3C
  drivers: i3c: Add i3c uclass driver.
  drivers: Enabled Kconfig and Makefile for i3c support
  drivers: i3c: Enabled Kconfig and Makefile for DWI3C
  drivers: i3c: Add i3c sandbox simple test.
  drivers: i3c: master: Enable probe i3c without slave device
  i3c: master: dw-i3c-master: Fix OD_TIMING for spike filter
  cmd: Add i3c command support.
  test: cmd: Add simple test for i3c
  configs: sandbox_defconfig: Enable configs for sandbox i3c
  configs: agilex5_defconfig: Enable i3c configs for agilex5

 MAINTAINERS                        |    7 +
 arch/sandbox/dts/test.dts          |    8 +
 cmd/Kconfig                        |    6 +
 cmd/Makefile                       |    1 +
 cmd/i3c.c                          |  271 ++++
 configs/sandbox_defconfig          |    4 +
 configs/socfpga_agilex5_defconfig  |    3 +
 doc/api/i3c.rst                    |    8 +
 doc/api/index.rst                  |    1 +
 doc/usage/cmd/i3c.rst              |  146 ++
 doc/usage/index.rst                |    1 +
 drivers/Kconfig                    |    2 +
 drivers/Makefile                   |    1 +
 drivers/i3c/Kconfig                |   27 +
 drivers/i3c/Makefile               |    5 +
 drivers/i3c/device.c               |  262 ++++
 drivers/i3c/i3c-uclass.c           |   38 +
 drivers/i3c/internals.h            |   26 +
 drivers/i3c/master.c               | 2070 ++++++++++++++++++++++++++++
 drivers/i3c/master/Kconfig         |   11 +
 drivers/i3c/master/Makefile        |    3 +
 drivers/i3c/master/dw-i3c-master.c | 1062 ++++++++++++++
 drivers/i3c/sandbox_i3c.c          |   56 +
 include/dm/device.h                |    2 +
 include/dm/uclass-id.h             |    1 +
 include/dw-i3c.h                   |  252 ++++
 include/i3c.h                      |   93 ++
 include/linux/i3c/ccc.h            |  385 ++++++
 include/linux/i3c/device.h         |  286 ++++
 include/linux/i3c/master.h         |  698 ++++++++++
 test/cmd/Makefile                  |    1 +
 test/cmd/i3c.c                     |   50 +
 test/dm/Makefile                   |    1 +
 test/dm/i3c.c                      |   34 +
 34 files changed, 5822 insertions(+)
 create mode 100644 cmd/i3c.c
 create mode 100644 doc/api/i3c.rst
 create mode 100644 doc/usage/cmd/i3c.rst
 create mode 100644 drivers/i3c/Kconfig
 create mode 100644 drivers/i3c/Makefile
 create mode 100644 drivers/i3c/device.c
 create mode 100644 drivers/i3c/i3c-uclass.c
 create mode 100644 drivers/i3c/internals.h
 create mode 100644 drivers/i3c/master.c
 create mode 100644 drivers/i3c/master/Kconfig
 create mode 100644 drivers/i3c/master/Makefile
 create mode 100644 drivers/i3c/master/dw-i3c-master.c
 create mode 100644 drivers/i3c/sandbox_i3c.c
 create mode 100644 include/dw-i3c.h
 create mode 100644 include/i3c.h
 create mode 100644 include/linux/i3c/ccc.h
 create mode 100644 include/linux/i3c/device.h
 create mode 100644 include/linux/i3c/master.h
 create mode 100644 test/cmd/i3c.c
 create mode 100644 test/dm/i3c.c

-- 
2.35.3

