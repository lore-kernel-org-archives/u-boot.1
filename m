Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5433BC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 09:42:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E30AA877AD;
	Fri, 10 Nov 2023 10:42:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="bLQKMqxB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6716877BC; Fri, 10 Nov 2023 10:42:31 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1a::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49D0087785
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 10:42:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Christian.Taedcke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ip2rgn+b5tmBxFr1A8ezS7HpVhMW3e5ljs0hHcm9hpMc23h0h1VuCwGPBDxiV4/dKw+j100Qm9llxPJT8vQs0MyqVWZyJ2wXgMK0uslHoY6QlC6pzv5mHYx2JsGpea3ub7aDbXu1fpBB5JH1UHbec0xAO69Pm7tQW5gWhwBOZ5rZUVC4Fdjr7E6/HncCco60yQ0aIAUYgZE9Rt+vlIwHkyNFfuTAnmD7OKsE9FwxRbupDaKOQAlNDzepjoVYjAeotHKqRFLqGAeBn4dFQWa2/gAVwk8rp0Yo9QHL3gRgjAyysaNsEaALydPsAcn5QAW29+1IA4XaHumthrz21boexA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUgRiOwvwjiohU3rD1ySMm0lQgNkxW+dojtUV0MdzkU=;
 b=Y81xFJEeGhYqJF6NGNt7+h9lXr5xxB5Z/1z55SQceNb7Z/DjyE03T/DlmR9Eq57mKJSFA85eF2T+XK6k3l70aapdGgph+GtUP1nm1AYsqAqEF/L8UGlzqQrLxA1ZTs1BkErK+4BV7H53xlwHture/kJY+IbI4YvJRO2q6dCT3VgXDK1x9LwodCVmQByzuLbwseTxSvEv2pSmMm09pdlagwSG8c/Sgj3xMW6KsQtVirLBpLhiAskwOQMOxZD3qSHyk1PASB2IDbu7oG0OahgKlpKPLPajKapGbzb6MT7pxYnPV6JttRadllyDCrEvcRBCaXfCerp7yKjSB5W7iSsbTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUgRiOwvwjiohU3rD1ySMm0lQgNkxW+dojtUV0MdzkU=;
 b=bLQKMqxB/ADNpWkRVbgQc9NugaQ5L4/YZEm0lVmtmWrP3w5RTrWsVMuAfQG0J2ZtolDve5Pvwe8mbLJUdZQLFifCrmwJrZd/DOr/Ojevjw/MkI4xMxjpEpvm9sHGP4wfWnnFldBqRTsUe89erE0lhB6BJOqt7KQ2dNb6MgMTcO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from VE1PR08MB4959.eurprd08.prod.outlook.com (2603:10a6:803:110::20)
 by AS8PR08MB7910.eurprd08.prod.outlook.com (2603:10a6:20b:50b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 09:42:27 +0000
Received: from VE1PR08MB4959.eurprd08.prod.outlook.com
 ([fe80::b592:2cb1:64f4:bcb0]) by VE1PR08MB4959.eurprd08.prod.outlook.com
 ([fe80::b592:2cb1:64f4:bcb0%6]) with mapi id 15.20.6933.029; Fri, 10 Nov 2023
 09:42:27 +0000
From: christian.taedcke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Christian Taedcke <christian.taedcke@weidmueller.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 0/5] fs: fat: calculate FAT type based on cluster count
Date: Fri, 10 Nov 2023 10:42:10 +0100
Message-Id: <20231110094216.50696-1-christian.taedcke-oss@weidmueller.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::8) To VE1PR08MB4959.eurprd08.prod.outlook.com
 (2603:10a6:803:110::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4959:EE_|AS8PR08MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 18134ec9-696f-4677-5fd9-08dbe1d159ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FNoDiBp/b8tvICts8MWjJSir93OuECp1O05uaklGtJwQwEGGFgJCARlPxqOgaQmnPAyw8+t9EbFe3QkaUk6zBWbLQIixKmhy7n+zE+xJoM7BplC/8J1euk/H5wB67sY2+2owfY2Hk7e4V+rgdFFrlNK1ystxkUOooqCmu2kdZw/b+uvcDLg6vi0N2cW5g9hFhjEh8opjLiEeJckX9t9x5LXMKkzrFVJhERl8cOY+1EcR0AlEjIIdSmdzFkufOCZ1ilENAdw0fSww709TN6Cdwt5yApccwEbANpxsfxVlkakpMhIjDcSTMjTG4tvasaSc1svZrI4cPjTqL3HWPJ/PQoZ2ZZ9x/ki4Hb2PR+WoOjgJRm2DDKq5urpXFXDGLsXqn/5DVNyOmbpswJz6FHLJ2wUEQGbuasFM/jolHVlEwceKdXSTh122sWNPZiXwNzR5Vfffh9T4GuTDyO9sShXwQjEwjOowcTJYFAZORR98xfJeMfu2opMVmligsCy821Dusvh2r+GI/F7SWCMLpTZE1yb0PhVf3aQnZFWx6gx5nZZBzHKYQkY7Yh9NjXOk6BbWt3UcE+PcHBIueZtgKZktofMLGDhSfWM+JXyO0wBrdRE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR08MB4959.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6512007)(966005)(26005)(2616005)(9686003)(1076003)(6486002)(478600001)(36756003)(54906003)(66556008)(66946007)(6916009)(316002)(66476007)(6506007)(38350700005)(6666004)(52116002)(8676002)(2906002)(38100700002)(4326008)(8936002)(83380400001)(41300700001)(86362001)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Ndueb+sSp/0aVRLX5VT8XefU/U8TpTH5WHoDu6BRzGVPJJ5NaNo4wwCCWtM?=
 =?us-ascii?Q?iZvU41jZbdsSn/htYBw03vdfaSOE42i6bmT6QfWvzgM9PXKLtHHRf1uS0ECE?=
 =?us-ascii?Q?xad3VjXS1XCquo3UP07JbMEbv7Vb/pd3j8VSOUGUdQFyx/O6kq7/KTarxHa+?=
 =?us-ascii?Q?dL6B/DzjIoInUt440OedeN2EjQhwyJWLHi/uoRLdx/4ppq94F2lRPqqxJYIX?=
 =?us-ascii?Q?KaM5b5U/lJ2JdRcFEA+qQmtqrnUrb9xWrKlHkEpVsBYSTCr5JEnRj1RYlhx9?=
 =?us-ascii?Q?l6AoMVrFE78/CnaRu+oq99m2wWkFh7VkFaIrQGK2GuU0whqcs/e2J7hlZQQP?=
 =?us-ascii?Q?ODplBEyFnhHQUA0W6ui1n0Hk9t3mRVJwEh2WL0VRbrpXxM6IPFS6FjAsaIX1?=
 =?us-ascii?Q?d1P/1Jv78/ahh4pWaSwULNQt6aMNq9kZIGKAuqysHnu56jnKybYNbwFhzVAk?=
 =?us-ascii?Q?IVsmZLISxmltmdkukrsyisXcsIU7nytNVAwKj89cU47/tBaUs2TICqhzjunX?=
 =?us-ascii?Q?qGYWWFQtixojOmiwZNKUzRgVULikd/soz5TiZyl5RIjnIty+K1nOa2afuiUt?=
 =?us-ascii?Q?iSwmYQI/63bJmtZFg6Vgz1RgshFFTz+/qE6YSife/z6Ouv9qQfjnIgBCCglL?=
 =?us-ascii?Q?yaJjaqg2xB74nMiGZgJeaEoanPV+Lh8GVEh/5Va+jpANuWJUU4I9YiYvlzcj?=
 =?us-ascii?Q?ysULthhOfdCkX2gp/zFpUSNm4qYKHJrg3JiSCG1DC0VVtlUTKYhgEX8mf9KV?=
 =?us-ascii?Q?uTcdygI+nUP+eq0CIl1ZyLTSAQkoybM4xQFF++rP/orVyf868m8X9SVulMAb?=
 =?us-ascii?Q?e/iVtj0Ln+5SToouP1YDY6E1fr7t4dMMOGgon+fg+iQ6Gg1vKQPULnNhIphp?=
 =?us-ascii?Q?ojO1fKQF3i2cisot5LrFuQNvMbziSuY9DZesgS3NibhqtkCvRXQFvKU6J43z?=
 =?us-ascii?Q?Z03ISQzXk263bnFhpm+HJG+50m+7mI3fkFywz0V9S/DtUu0oAVGTnX+mflgG?=
 =?us-ascii?Q?+bj6nXAsK/wUnaDUWjr2uE5MSeI0Iei2nCtklHbrzgYpJsq7gQSDETwge2Qu?=
 =?us-ascii?Q?73U0+BONNrwjU3yQqMS28T0OY17CdbXza+7b/7rcKPp6faEyAAb4NUcunFn2?=
 =?us-ascii?Q?whd/W3YcQhA5ZvL/46gUgGtV7AqNLyW/aX60F5qU0n2Zzq0eEzWUorEQzG2Q?=
 =?us-ascii?Q?7yFns//e0n1B24mOVMR05go4ez2+0d9+uuRO/GxVuALSpUXze75PKFJeMhBj?=
 =?us-ascii?Q?rKt0d1D+hFZTzhxpTryZMc+4SuZZKSNQg1Y/MbsNpxeppj0vBgqWuak9+weB?=
 =?us-ascii?Q?UfxSz2grMv4Jl9ElF1gcXcrAWQ7ENt9QTPPqcQW7DHf3Wzdld6hII1asSqI9?=
 =?us-ascii?Q?bEn8XudAdbKY9l+DKV9sVX5QeP34DvmFMN6lIo7ScyAXYdkLiF6IVG3/ML8z?=
 =?us-ascii?Q?AiiocozOIw+Imzd3Zjl1jS1s23Su4mwFa+w+MpBemSXKTeyncv1Wh+9bzPDd?=
 =?us-ascii?Q?UMQP0bnyfwcGGmCw4gn5GtToHfENmekPf1UvkjmZqIPRJV0OcGviMXWfKXDv?=
 =?us-ascii?Q?nWXSfqAQC9kmN0HkBC6VAYKwzrIpglyKRAF+VY9oH5nR0Dz7i8oFNke08tne?=
 =?us-ascii?Q?YHx9NAEmvG/NzzECG/NnJXsD+Qf8VQPEYk26zG0nW2zw?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18134ec9-696f-4677-5fd9-08dbe1d159ae
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4959.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 09:42:27.3452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HAD1422oMACWZHSU6VoN0OH1muuBFI6la+/D9qU7x878RwCWBKjdyVtpcceVfJJcaLosBLxvAl8UH4cw5e3C5E5g0HWe9kK1iTsDaGOobyEs2x5BYWIlRE8jiU87HLCV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7910
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

From: Christian Taedcke <christian.taedcke@weidmueller.com>


This series fixes an issue where the FAT type (FAT12, FAT16) is not
correctly detected, e.g. when the BPB field BS_FilSysType contains the
valid value "FAT     ".

This issue occures, for example, if a partition is formatted by
swupdate using its diskformat handler. swupdate uses the FAT library
from http://elm-chan.org/fsw/ff/ internally.

See https://groups.google.com/g/swupdate/c/7Yc3NupjXx8 for a
discussion in the swupdate mailing list.

Please refer to the commit messages for more details.



1. Added bootsector checks

Most tests from https://www.win.tue.nl/~aeb/linux/fs/fat/fat-2.html
are added in the latest commit. Only the tests VIII, IX and X are
not implemented.

I also checked the Linux kernel code (v6.6) and did not find any
checks on 'vistart->fs_type'. This is the reason why is skipped them
here.

See section '3. Size comparisons' for the impact on the binary size.

2. Tests

I will try to implement some tests for the next version of this series.

3. Size comparisons

I executed bloat-o-meter from the Linux kernel for an arm64
target (config xilinx_zynqmp_mini_emmc0_defconfig):

Comparison of the binary spl/u-boot-spl between master (rev
e17d174773e9ba9447596708e702b7382e47a6cf) and this patch
series (including the added validity checks of the boot sector):

add/remove: 0/0 grow/shrink: 1/1 up/down: 100/-12 (88)
Function                                     old     new   delta
read_bootsectandvi                           308     408    +100
fat_itr_root                                 444     432     -12
Total: Before=67977, After=68065, chg +0.13%

When compare the size of the binary spl/u-boot-spl between master this
series without the the validity checks of the boot sector (so i removed the
last commit in this series):

add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-24 (-24)
Function                                     old     new   delta
read_bootsectandvi                           308     296     -12
fat_itr_root                                 444     432     -12
Total: Before=67977, After=67953, chg -0.04%

So the size of the spl on this arm64 target increases by 88 bytes for
this series. When i remove the validity check the size decreases by 24 bytes.


Changes in v2:
- Use get_unaligned_le16 instead of custom macro
- Move code change in test/image/spl_load_fs.c into separate commit
- Use get_unaligned_le16 instead of custom macro
- Extract FAT32 logic from determine_fat_bits() into
  read_bootsectandvi()
- Rename determine_fat_bits() to determine_legacy_fat_bits()
- Keep one goto label instead of removing both
- Move changing gotos from read_bootsectandvi() into separate commit
- Add validity checks for boot sector

Christian Taedcke (5):
  fs: fat: use get_unaligned_le16 to convert u8[2] to u16
  test: spl: Remove usage of FAT32_SIGN
  fs: fat: calculate FAT type based on cluster count
  fs: fat: simplify gotos from read_bootsectandvi
  fs: fat: add bootsector validity check

 fs/fat/fat.c             | 114 +++++++++++++++++++++++++++++----------
 include/fat.h            |   6 ---
 test/image/spl_load_fs.c |   2 +-
 3 files changed, 88 insertions(+), 34 deletions(-)

-- 
2.34.1

