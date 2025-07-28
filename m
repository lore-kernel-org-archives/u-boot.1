Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FBAC87FCE
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 08:47:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D37BF830EE;
	Mon, 28 Jul 2025 10:46:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="LVb3+C01";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC24182F8E; Mon, 28 Jul 2025 08:56:36 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4743082F00
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 08:56:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cd4G8whbi6XF0FLM+KTc2FzuPxjP/u+Osm2V0R+pDuf2enRHdS4DH2fHPaburMasA51/TzysrdITG/WjNJksaHMan/Yg+LiuzOhOuutsObWyydCR1H3FgygUHhW5ePZvWTaox8XZ+V+QPM/QBtPE90OsLIMzPk0xNq62UT0F9IdojR1RAL9AuxjH+bA0zqTrDhAEvXeiTf7Q8UYYJfmLYzNAaRG//ruLWleWq+8eWU8t4+IVtsS/HIuGw70/8LhULhFCGWUFQ6pM3APSjMxZQ8u0QZeEJSVJERYK0e6ZL2oNV96r7LrnL2mesZQrRelIeGVchvq27uJsR+nrOnrctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvzOOp2ds9gOPnCYMrpD5D1N9S6cYSv16MKOopeSfIA=;
 b=ViTLfaSbmYXP5b0dXW68pJpuQ1Myb+u38QhWq2QIgae2aLTIZNhzKZ8phpt4yCCtrMPYeXVr5K/z6QkAScjRXV6QdlsVJy+ByGpBVsvAiL06YtD3AvB9uQYy6LiZddN9AmtrYRZMTBZQ+xHDaAILVrAghRDJZBlM1QuzZmvvGEe8Py7CNQYQ3XTAHwvzCijJ6cX1vMGzMzDs+DmemtTVh94dolro/urBGwiLE6vuHfCC6Oqz7KXor60MOuq4ZKQROTNXbTRrJQVpO3yW+NqKtWBM0TRLVumMYCpE7LR0zh9wGjoufM7vMhu1txAsWivLcbvFJgOejTL29cTDuSoFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvzOOp2ds9gOPnCYMrpD5D1N9S6cYSv16MKOopeSfIA=;
 b=LVb3+C01/KnPanU55H/zS3B80kDS6H/QJ0NK3woOD0MuGwG9rENJ/yRAtVdJRr+WFxRO5L82kPCQ/UKrtUbmN1QcLf7vG2TEoznKsjlHkc4+VksIvEz5MxhW482g63RcL9oQelUiBQWwBOO302PLGzUgDl2i6vL392UUOJ1/qV3LKrxKDmHkXTDbGLod5q1YQ1JJzBFTq43nmycj0mPZ4Z6EHJH1bb9ed8aXSFU35iRjaMqnf1nDcRKK7nRGhHE3qGNIzpmFfLG8b8S32um3Qkve5s8D+1HbuMDov/7UTpcU12sw54PBs4ycsN010JX5eHy8SnMHg/r8g/91eUwd4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DM4PR03MB6128.namprd03.prod.outlook.com (2603:10b6:5:397::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 06:56:30 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8964.024; Mon, 28 Jul 2025
 06:56:30 +0000
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
Subject: [PATCH v7 00/12] Add Synopsys MIPI I3C Driver support
Date: Mon, 28 Jul 2025 14:56:00 +0800
Message-Id: <20250728065612.6039-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::32) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DM4PR03MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: 398cf342-bc05-4a8f-6708-08ddcda3e11a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7/nKLaEQqDPub/KEB0YI/Bui8S4fteVI7bivNue1LRGnEIcFMjHo+rvUKh3D?=
 =?us-ascii?Q?OObjKqnUUCxXND1+o0u3W/eS3qpzMcC+dpsl10lGkJVdDo/2QWGbL54Iwj3d?=
 =?us-ascii?Q?CyFR60HgSVhOgJCm1xgXSdBSVR4pF6fypZTgfXRfbRUQuUmCBo0eLKSAITfo?=
 =?us-ascii?Q?azOpyxBYsgIWtqNKPJKg6ovyrkB5Cu21ZWjROVIzeGlNjd/JaAvGVa6riLc8?=
 =?us-ascii?Q?GiW5y40uiR2/3tU+l3tFH30T/gzphYUm+x/czmgQU5EWeHFyjHSyn7EXOy6p?=
 =?us-ascii?Q?dOUbPUqMpbfD7ceT2HMGMl7i+w3zqRi32+MXdArkbe02GENKkYMoa0RKoqo2?=
 =?us-ascii?Q?9K+eepEmaGZRGWYuffsWat2fYCsgmhRE6hPw3XA4wUcZ7JUSDm9RYr3uUNh1?=
 =?us-ascii?Q?NKlMvi7HilOdEFZJ+WbxUCz8f5gk8vE5Gq/EtrrbUwH3qHNoYaQQUQQVjX10?=
 =?us-ascii?Q?K3Che4ooTGPuvi6aLVhM/VOfDkDEbggyC6jcadeI/lldQK6VvUkKsNXp0uhs?=
 =?us-ascii?Q?f0XY6A2es77wShGma0GuaVqlRCrUyOTuP/jlk0OJIXES3fAgwyiY96OUdjGz?=
 =?us-ascii?Q?HPOzhBQOwT2aYA8PM5T1SpMgH1OSZojvWrpDiIFgtN19Z1RFGVDrR2aLrqUq?=
 =?us-ascii?Q?49HEgnBC086QzkYXBkJe+g4FSYisKkhSaVynMCzaptK4+ISC9pL595QknC75?=
 =?us-ascii?Q?2NWjdQlnltaU9reEMVg2WGTdQiYYPqevRn5ZJSGDYtxG67gp205X91SXts8W?=
 =?us-ascii?Q?vYxF7q4xCuBCZ4DqfAaleGswtprHRpmvrN/4u+JCReknimsg1QtLeKu9gMLD?=
 =?us-ascii?Q?YrHfIxYfdMiJzKOj9msMLniV/O2GE/N0RRNoMs02GGeuVZeIgi6zmIqtd+in?=
 =?us-ascii?Q?ftFITf3R622elNM6c/m/W4UVV1P/nineWNkjfDtHPSyk1sPGGqKVpM0ND/o9?=
 =?us-ascii?Q?m/uJ4/4+PAKW8szKzpoQ4O3QvCq2x3/qGbOqtDhjv5YeyYRaB59JVo7b3C39?=
 =?us-ascii?Q?vnnzNXPEaNv/MsG3tPZXNgHxVKkXzRhRrB/NnFDZZqWqy5MBh2ROxLi0mMXO?=
 =?us-ascii?Q?m91v+QsMi71Yeptzl3HvbX3mMQitgXf1p65eLe8dRErBdKtSmAylSqhucZYP?=
 =?us-ascii?Q?u3IEA1PRunE8d8JBcj1RFbhEuNTh3fNi5g+FuP1iRV6XO//xlcn4B9HVIDdt?=
 =?us-ascii?Q?2pJqFbAOvBxN68bHqHexgY/H1UDv854flQjXAKI15C4G+h5kPJ5ESvD+INFe?=
 =?us-ascii?Q?rzJdSr1VexTDtSXNq1mEI8nhkeBDWs3D7JH/79JJfiS7I4lPLG9WUJRcUr1j?=
 =?us-ascii?Q?e8mtFeXxnmHsrEKieBo1CA68PW9SwN0Xu7JqFtGz5jz3+EMQABWkXulWApBD?=
 =?us-ascii?Q?aieCSlgvlWzPSznn4S7lK9MaM5+/9igP/+WgPWw63WKM6DeALxcoYHdClWhv?=
 =?us-ascii?Q?8PBYwFCgn0w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rcxzLLaHlowOYC1aS20xqu+zCT6zJhayWXuaxuxM/KjmQqwkDNLyaxrIhJXu?=
 =?us-ascii?Q?BEOiIZldBtCFA7GafbSg+TmaJ+BXpWlk7cEDW+YKbLLDZJyO4X5gJELIjMj1?=
 =?us-ascii?Q?QIa6LNX8VZ5H1pX5y2gBHPAm9gs/lwk0KNr3JuutbO+ppU5QfRWRCC2UBYoJ?=
 =?us-ascii?Q?5EQVzWkbLsDT55O8Pd+9ojgoPR5vjw7QpWXba2hSfCsZX/xfNPhaZqO12WO2?=
 =?us-ascii?Q?Kx9ltXVA3B1DotHTdqFqQ93jKnkONjz4EKhyg2e3VD3WnRdJGPoOEOfgD1yw?=
 =?us-ascii?Q?tlRWA3Y4adQZFuJlq4c4pS+VUkYvkIEhwdYDPYErJGoOUjesjEBXycnCbO/Q?=
 =?us-ascii?Q?FHDKawvcqihif8+jIjYnTCQpptl0DBCrE0UPyMqWUR9xrDeTmvFZo4QbpiQA?=
 =?us-ascii?Q?exFzi1lk49XyNYV4HPd/23pS5qlIJdc60cvq2y6wv36ctROl+W3BYclb0ZYs?=
 =?us-ascii?Q?gw5B/SXp803KhS6osi71kG+crdU3AUrdoH4irhj+R0epi8aQ15aUil3FrOdF?=
 =?us-ascii?Q?S18s1Fa3LfJfiWK2yXZtvR4QyPlSsnQbu90qq+Dmq3OrGQBViMeMtluS5wxr?=
 =?us-ascii?Q?pewLng/uZnK9fduvVqHMDYMoDuAhxbnPz3B3h2DhpoL6YsWDD93IDclHMdrn?=
 =?us-ascii?Q?Ae4F9AoVft2zzDAXonQgOFx5XsT9Pry7aTY89h+nPB5g8tJo0VlNLdMSGipL?=
 =?us-ascii?Q?JCS6lnQC22JQ8JGrtyvj0XWK7tlCgctol39Bj0PFn0PxZQJ8sFUzyknEoI7f?=
 =?us-ascii?Q?fcDb7W0zeNFc+hAU6R5umUDw0KILZuVPyOqdAZDHzERrIt6F4RV3J0mcJ1S6?=
 =?us-ascii?Q?sETdEqlXc+Fb0YaK8GJV7+OWE/n8CDbXw+PIBSpAA2uE6NJWUu4qy1RG41hJ?=
 =?us-ascii?Q?0D7q9rHZx99Zb3eDKP3raruIwxvaCJ3y6e0auwRGDNvkPR+Do4h7IKDVEvBo?=
 =?us-ascii?Q?LwNEw2dU4tYUICCK0feleAs+KA8pEIgbARuXF/l5ES4PYmNfO+shyAoKkAog?=
 =?us-ascii?Q?flAOtRocYWi763YyTah9gvpsMUwZaRzQgYdRjDxDP3Bwvo2B4hpyWBNgG2gw?=
 =?us-ascii?Q?N9bOGh/Sap18WDOGoY+q9fhhxzmcD8Qtr3lyHjxoCzPZsVaKX8QDNosK5VEW?=
 =?us-ascii?Q?YnCyJ76OIp0Rq6kn1o36pJgzYw9BLNwLdVHhqmk7Mqi1/fFONNC1a49Hj4gA?=
 =?us-ascii?Q?LIrB71pU+4CMkiwWaDD5zyl3K6zkHvsEEcYaGQ6Qj4kUp/xtETM0s4y8F+Aq?=
 =?us-ascii?Q?K5liewM0jpDdGEPy4uvPtWYRXSzBwZg5ocY14HuLTl1UVfvgeLpmQk9jQ4/F?=
 =?us-ascii?Q?KIHdHmll9GGuYB21fH52RY02lVJmKhG0keHHmAOC9HwvRe1jHNbG9EjQ83gP?=
 =?us-ascii?Q?W0zIBhKpx8qFCo+krGtU3llMLW/skhAXJHXib+WEYJErSTzzHmrw6I8oY+FU?=
 =?us-ascii?Q?aRKoCnEk/9zVcOWOT09955IkuUjZXah4K0zuw/k/eqLU76Tu3DKJ2sUy2omX?=
 =?us-ascii?Q?MMjMqMvqu6WlgxGxPn2y6PH4UVtgsgLEdG7xkUDihDR8BH50F/hNtDv2kjBL?=
 =?us-ascii?Q?4O2lUvJUI2n4gmkulGyz05tdMwoHk9Ag8p4MS6c4g4WMvYirn++lD+c/DSsD?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398cf342-bc05-4a8f-6708-08ddcda3e11a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 06:56:29.9497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/NVz7YZy8j27ABm3gyfnukKnZd+rBD5E87l7MogiZarjrraxDDiMAxLf5GgtUVgoDmckH8ctsakjVv2G8NY5judSWtQSu05npVZIH0V/Xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6128
X-Mailman-Approved-At: Mon, 28 Jul 2025 10:46:50 +0200
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

v7->v6:
--------
- Remove extra variable in struct udevice
- reuse the existing dev_ofnode to get the node in  master.c

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
[v6]: https://patchwork.ozlabs.org/project/uboot/cover/20250513101913.30880-1-dinesh.maniyam@altera.com/

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
 drivers/i3c/master.c               | 2066 ++++++++++++++++++++++++++++
 drivers/i3c/master/Kconfig         |   11 +
 drivers/i3c/master/Makefile        |    3 +
 drivers/i3c/master/dw-i3c-master.c | 1062 ++++++++++++++
 drivers/i3c/sandbox_i3c.c          |   56 +
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
 33 files changed, 5816 insertions(+)
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

