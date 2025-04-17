Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF69C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 04:57:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C5CB8091A;
	Thu, 17 Apr 2025 06:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="dhAIa5+q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08E6882F75; Thu, 17 Apr 2025 04:19:38 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47BDB82CBC
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 04:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBSX9BRzn5vFzYqP6Z48DcK9L6hXzIftaF68DzCDViiDXiFM1y/2K2FQiD0fqubZcdXQ/GhROUnG/hcZ8tWKSeOi4LeLf1Sl2tUjGjm1rueNMEDioMfaUboAABeofzLTnfT0WjYczCftMIRJZy7m2Q1Syt0L96XRu9sx/S8eXg0Y1DITBx9R7PDXb2PddcYT/fNF+HfW6bLSNQW3XLnM8W0chgL0h6rsDrvVkTY02fGagXC/OvHmEfMwmGYQtRepKDc7JJccKCsiav4E9euawyzLpqijvO6OKyGJ6L3KZCVl3m75/MNoaNlmY4JlHZrX6KjAFe/edmmYIEITnBSLCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbI7TCbB+gotu6oPTy8o7RrNfgPrB2xYGzaULtB2w8g=;
 b=FwI9OriDLuk6qGD1yXwo40LSv26wZpHF30akzIOSJg8i7RH1ILDA4kVR5Wwtc64NPxrVh8dqNanj/yMW0aTBCMtbfv0EbSmho6ipZoBEGBHJ42jm9cRSjqh9kNYv3ofIUWdBZ2ibaI2R2pb8kxRm4ENyTpUjN1v6eTSfi+nnqMc+DAViOSu02rd4Oxl7+AJQeCfa/5AKYbcWtrJR5WIaAnvcrs09Aa1NCiJUCDxx0HwQzhi26cCdEkroPBp6lgZf6o/0URMAgSPPPcpKMGwomKogcINwQY03HCwgwpA/pEnwWwCjv3/k4SoIc2/EBAgU3VSeDyfL9A3KElcux9Wq2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbI7TCbB+gotu6oPTy8o7RrNfgPrB2xYGzaULtB2w8g=;
 b=dhAIa5+q9926KocsVbxwFLcMMmXIZL2eCUzinZ0JARyt1Q9GYcCrPlsI/ycsiyCteF/f36YGWZd5ns+SsVgnw1ozgnSSl5wHjFntgRcwMHYg7d8R5o1ylDfNscyRbk/z8GI8QXI10NuQ8bo8KkgtEN+YINfeI479pD0X96gxt8jpXkqcpyyhgVAR0eVk6mLlPsbZtJu58B/HyIpan5JoG6EG/vE3GnITV+NtQ/Mh3xbjGu7lMdq56iQRSlMXKFxz5uj3BfPN1N5FV4sObl9gqpiGc/Iy7p43hRp/NlpQib//SnVdM8firOxiGfM6cRZNsD3ZNiJyN+P3w11TIFnfow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by PH8PR03MB7197.namprd03.prod.outlook.com (2603:10b6:510:25d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 02:19:31 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 02:19:30 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
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
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: [resend v4 00/12] Add Synopsys MIPI I3C Driver support
Date: Thu, 17 Apr 2025 10:18:28 +0800
Message-Id: <20250417021840.6212-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To SA1PR03MB6370.namprd03.prod.outlook.com
 (2603:10b6:806:1b5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6370:EE_|PH8PR03MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 75dadab0-ec5a-44cc-9b24-08dd7d564914
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ass33q5oA7scNrzWpzNTpf0A7pVgRAoZGTvc3w80owOqne5TXG1frICNb4oQ?=
 =?us-ascii?Q?1ZfDdf9oStRnhOm5NvALgSvaYiNjdz8Oq7w+JhdXDiP9qFbMmdGP18n9byhD?=
 =?us-ascii?Q?Tqp23+gRYSiafsZrlYSSqk9bZX40K5J0NP+IrZijkSpDXj86/ku9KD9uFYXh?=
 =?us-ascii?Q?iXH5u+4wshf2Je96KoxS8IOKI+y0AxZqol8AAQNRXdIXao8CfkV0z+/NYIkO?=
 =?us-ascii?Q?tZt1kHJR0dGN46aYtnJrDQE7kA4f35bPhFgO7RD/2TJRvGBUql9Dy+BcUTpW?=
 =?us-ascii?Q?8VHtlOY4PawPkrakpPJ1YNDyKefntxlVG+MIlvFnCoRFLdZxYUkwj5Te0JNG?=
 =?us-ascii?Q?yUCSPX6O/O5DRf2nxOLkrLRRS/FK986PB/oSOG+DFn6a29fZ1Fx7WtQTmKvC?=
 =?us-ascii?Q?9ozkDqrPMYo4wCjID7HRsU3INDY8uJm0yek5frpmtKuhoo6WPUE+glTG7SsS?=
 =?us-ascii?Q?5hL8fAXmQClikJpAR4N+umWnk7zNcwJNrelwwsHwDNdF2xsy1gJ++AQHD+Iy?=
 =?us-ascii?Q?FMClcPRn71i/A1xAEkZTEPXOuZMYm/5DnDKLZlkFOOBmQPRaK938r+CWXQR6?=
 =?us-ascii?Q?oopGDQUCXHez73VDFa+OxCRNMFIIYcaimaSAeQnnyJZOe20G5LhYnuEcFlL9?=
 =?us-ascii?Q?0RozRtXmTM4QahhH+4ap0HP/O3d1NXCJft8Ex4gHWHkYIY6u4YctsqlRMV+J?=
 =?us-ascii?Q?dOhw9YkIVRaV2gUA+KyhysNLeKmGjDQ4cah+3k0XZkA6jmwEFlfYiwjdUXYb?=
 =?us-ascii?Q?lXAyMYF2QX6ez7CKUajwl6pjU9iS/YMTgOPpJwDRIe9R4KPjd99pTv/fXWF5?=
 =?us-ascii?Q?77ni9uEGBJl5mTZXlFh0mYJUpsf6DCfmB6S6ggIN5Eo0Kcw9RQJkeVhnBzPo?=
 =?us-ascii?Q?5r+guyopXpl1ZDD6P53k/Y5tYIZlQn+aZV/hwAtwZqohxNX0B1Nk1IxKsIN+?=
 =?us-ascii?Q?eIZ6Qpo+Jv+zb3Kjy9mMrdrDNe/atTEFfk8h0jqFPV2KK45dzSkilQiUeKtL?=
 =?us-ascii?Q?rTgfZd2mYNX7Ob/c3inMwVBVfvNcu0SeUuvbEEeFtWpJeDxPuqi6M1w0Z+bJ?=
 =?us-ascii?Q?kojBsCUYmTny2GVL+WWTfax+Vm3z28z74tin6fr70XwadDhrY4rstCwUO1Vd?=
 =?us-ascii?Q?pbEJNtVvUCDKJbZ3n2WLiLfrrt3q1DIq+mYwzoxRl8YZQYkuoAQc3njbd8yh?=
 =?us-ascii?Q?rzT3Lx626j+095KT5t3XCaqa2OaD8g4O1789i11ivYqlId+zeDFdNmpgOXPY?=
 =?us-ascii?Q?mq02sp6qVBoPDB8mBV9sVRClBY9DW+KDRYFfokl9pVZcKHEVwwPttf8B0D4r?=
 =?us-ascii?Q?RfvdGHdyS7dU2vEYqDlclqr8MGZdV6ycDL83We9JNFN0dFonujFHcFQmCCDC?=
 =?us-ascii?Q?b5V+CYLeX/HnKGrvYECq/+3M6oZiGo7fchxJOsYQ0k0bc66FL+dc2sDTAh49?=
 =?us-ascii?Q?v46Xsz6Whxs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2jYaLrSLN+7noOmcFkmucsyudPsfrMw3XOhCrUazCfKyq3mKnuQEYsN5XMRx?=
 =?us-ascii?Q?rP4vLoJHMF17EpAs1XjIi/Z459Rtkm3mL/bvAxGMBm4u58esfmF8n0kp7TN9?=
 =?us-ascii?Q?EKo/OILd220VvXiiu96Ajo5eTcQVFymFEmsv8gIY9w+6nse/y3yyrvb2HgNF?=
 =?us-ascii?Q?CH0zoS+FKjHGv0vTBt8JHolD4ZYh+neJQVFAhUSTY8S+LvXSM8zl8YTdS+DH?=
 =?us-ascii?Q?bkB94eP9VQpgi7x1P6TfLLzQMTWlferF/hfJ/RGw6/l02377g1P2amchCOVT?=
 =?us-ascii?Q?WfHaiFKXvY2cocQlxquaP2beVb4m725KF7/VFgr2naO/mi9clOocm8/OjtAm?=
 =?us-ascii?Q?XmQobvABqfNa6i393Lqr41YRx6yzbTrPMxHgY/LmPCK6TyZ9naqgxauRyCsD?=
 =?us-ascii?Q?FVHw+29Hvkhs+rg5EmLcse9MHxnBcO19gmRHlRKPO1pa1s13i21H2KiiNtYC?=
 =?us-ascii?Q?X8DKBByMHnQIdoq3msBajQQ1QunR4a0Mj07sq1qpMPbCx1h+OsIi29JMPtU8?=
 =?us-ascii?Q?Dv2+lN+okYZ6oZgOH8daYqvt4NSoXCgzVUYdoxbocPCQohOM77Kc4Rp0Zrxa?=
 =?us-ascii?Q?v5tlWxbfwS2aRikF2xo+EKp/lB88WUYe+oj0SiSiTN0t0Uh8fPaW9SZCBQvd?=
 =?us-ascii?Q?DmL5NmBGxG2jZxly//pa5wDx1+db9sxmHVsK6wHmMpiSps8sxaXDVb//P728?=
 =?us-ascii?Q?matvfcNSg0sEe6bzTuF46Sdko979wKi4In+G5crkgn5BEKWHNcTkzDfvYUM2?=
 =?us-ascii?Q?whl1SJSbqkqZYaGF2371Pbd7nlonaSfsMvI22+WuLtr1HEktm3EzFgssn6Q/?=
 =?us-ascii?Q?S93MlOOhH9o4Sf+YBLUpHAusZlH21ehZRSc3TqLqLPp0eKj4jmPZp92LQRoX?=
 =?us-ascii?Q?87zhoEr2/Pa9t7WIB1tfd1GixgTxZLQfd6mxOa60xiMhh6NZ5Sx6Tt5JMgzM?=
 =?us-ascii?Q?zLlcF4fRcz2Eb4JFuu7/jK8iKxINvtJ7rbVXM5oqvpAwAKn+CxqYZkbtu0Pp?=
 =?us-ascii?Q?6RcBi+hWTP6jOzDzclOYSXmbRpkz3RWFR7lnbzJoG+CBqvUpXVN19SAZDp1g?=
 =?us-ascii?Q?oDZl9e46WnVSFQPofjT2W+paJfHCy7mFbNNyfW6VllF4qOxl1RCSyZf0HHNQ?=
 =?us-ascii?Q?KHJpvgEe+WWckBPwfXR4K8oRi8QXdT0n6Nd2wX3tX9YPv/ptwNk4O9A1uO8V?=
 =?us-ascii?Q?bXkFGzkM/PZ2igYFBp7zzuhUwPNegVlUn8x3TPHKh8hT4KrzWpXZsvS2op/h?=
 =?us-ascii?Q?xyqG+jgF/eUk423Qxn/yoHXHdRAOB810O5vcSe3UoM+CL471E3v29eMmuh5A?=
 =?us-ascii?Q?QNF0fXo7k3ev/IEv/6BqQjV2fgWydkiTkNTkZOtlYo5zxarpM7eNnt+w+/F6?=
 =?us-ascii?Q?cvWHTBnCW+37rHC0drMLHMamtnq0Az7nTOABdncpO4WV5oSKtajUScTQkIMc?=
 =?us-ascii?Q?rssCc3SD0xlpzimbttb2hAE6WBGW+rrUCV34/okSgtf4wCuoX9yi5iHXRN5g?=
 =?us-ascii?Q?f/d8latvctRsGdsBknm9zvDJWrY1kGV/g7gyrqL8wcdXjqeFKq68SZmKgfPp?=
 =?us-ascii?Q?K110ESGKT0Etav7N5fDp7BYapSkg8jLU0gfOTUwOTrJxORN8mDf2Hv4vHeJ5?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75dadab0-ec5a-44cc-9b24-08dd7d564914
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 02:19:30.8115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhPWIsvx8rPdSWX6nJulrYZFmAyU/q4sFgGMy5fIUEXhvnU7uSHBHerWPD2xV3mI0lTZU+i06tv6LjMLm+FPaVNOw1+mje1sKaW6FPK+ZoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB7197
X-Mailman-Approved-At: Thu, 17 Apr 2025 06:57:49 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

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
 cmd/i3c.c                          |  193 +++
 configs/sandbox_defconfig          |    4 +
 configs/socfpga_agilex5_defconfig  |    3 +
 doc/usage/cmd/i3c.rst              |   98 ++
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
 include/i3c.h                      |   67 +
 include/linux/i3c/ccc.h            |  385 ++++++
 include/linux/i3c/device.h         |  286 ++++
 include/linux/i3c/master.h         |  698 ++++++++++
 test/cmd/Makefile                  |    1 +
 test/cmd/i3c.c                     |   52 +
 test/dm/Makefile                   |    1 +
 test/dm/i3c.c                      |   34 +
 32 files changed, 5663 insertions(+)
 create mode 100644 cmd/i3c.c
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

