Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091A0C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 12:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66A3E871E9;
	Wed, 15 Nov 2023 13:44:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="rnVQHxCM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 065D687197; Wed, 15 Nov 2023 13:44:40 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3478F87160
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 13:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Christian.Taedcke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIURTKV7n/ITu+JThiGyqDcXpwO3ZX+r3sCqloDtBQXTR8rHb/CVMtwRVPDrRXj07yyTqbut5FYB49T3dF6SEu+NCvs7O9RllXU69dNizwpHDWEK3dJ/oMWUacUW8FLPdCNvMT7OfaPuD5vd6D73j9RNt4yTM4XE9U4qZBpcCzm4HhZNbeRR/kyQ5Tef8s+uTitYjwmLQYGknlHK7Wm3du+NqPv3zFqDoKg6y9ewRXq+JYuGEptYgti5Rl1u5iO/Mo0sJLAfIL+EEow3CpmWpZPX5Jb+6LqkfJWzJVd0Z27iFbKE8quN3eFvM7L/hz1yrF0JesJmlWJ4iwxQ18hLNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7j3uQlcC3Tk7233bWUzVtQqnVqBz9NjfBlCYODIkyY8=;
 b=ch0SbFzpf8ZHTHW3abqVUzmRTNE/aBZ3YXhg2Uolq5/4zUAsjIUwCc8i56Jlw5XZDCctjZxD3KBIeBa13pzOUj7EnvE0tgrZfzhtIgUuBo8VSQ552di39MVD4A75VR7fgkWxa5vpqZazFl1S/vlJvx3edwYk6tVaaGAl/wz8EB50N3G+IxXq5i/iprkNRNqk7YAKTrYLMkARkRg5wY7QCjWcZ2i5PnmnhNbTMOm2+3K6JhF2HB2RibXEXEGNywjvq6kjhnFp1f/GnNqHCpo+AdM9NL5+CFvrmxq4Ccxt6t+M+rK8T0bFR/sFEpFGRWsUfr03c7p1B807QvP/MIKYZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7j3uQlcC3Tk7233bWUzVtQqnVqBz9NjfBlCYODIkyY8=;
 b=rnVQHxCMoSvaDhoAv1FzHJdxaovCPiFCGAj7rMeyqHJvQM8Ebpjenjd3IQvlZEzbnO9hGRKGyZekYOOcXiAjdV0Joso6QXr+ecHotd9/MP90lIMGxfjHu3O9bMbneH5uhc4rME5khrX4rjdiQV9vhg8ok0Dp9JkYTST2vRNuYAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com (2603:10a6:208:165::13)
 by AS8PR08MB5911.eurprd08.prod.outlook.com (2603:10a6:20b:292::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Wed, 15 Nov
 2023 12:44:34 +0000
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::a732:6327:19b0:b4d5]) by AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::a732:6327:19b0:b4d5%3]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 12:44:34 +0000
From: christian.taedcke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Christian Taedcke <christian.taedcke@weidmueller.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Qu Wenruo <wqu@suse.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>
Subject: [PATCH v3 0/9] fs: fat: calculate FAT type based on cluster count
Date: Wed, 15 Nov 2023 13:44:15 +0100
Message-Id: <20231115124424.125823-1-christian.taedcke-oss@weidmueller.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::11) To AM0PR08MB4946.eurprd08.prod.outlook.com
 (2603:10a6:208:165::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR08MB4946:EE_|AS8PR08MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee6cd66-e6aa-4cf5-9fe8-08dbe5d89e8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BCn34B4q5u26dnPZrECjTmESriyyCZ9qQcWksExYEt8uBRzBBFjTKsltbX2P9EPlk+47TL4slyDL5kr0zRD5waLvYdGfYbqsR+mb/51FObDxCtddBXQ+sGUgrgfPX5cpT7BQ4L+QCzkD/wJD5/BeWw/hECctF2ijKDl/kDYhL2/O+S/Rqs/g1y2DiW9jSI2RO+PDLUgJykgRMlm6hAH4DF1owWbDboOA+PRwPfgV68WFSqK7PSCpt3cRVif4vgORij/ZMmBWzR/XKKqCy09bEvW8TN8s9uZQlTu4B66s6jN7bh5VnZ6DXyAmPI94ckmPUFfkUMWL0MjA1aQ6sHHjGqOshNtMvP21XpiotEYRk0l5q93QMU4+L09fhuQieOj/4pfHHbgKCWKPvt09Qpc5eAllrmC8S0oK7BgZJeMDxvLN8VcQg/6mYwRv7MhOUPjnZUQ5VQWLoKiYnIRsWjLVs8ZYJK1clvVI2zdSIBVaEBzhMnyJuh4bIs1Og4cmzyMfs2d+/EpVW2XSpIgtpgjGycMmOXbty91x1+XoAuSuW5mG8rKXwqAY/C9QpRdnlYm8mAASfgyaYP5eGZgzkBlJmmkm5BvtXmXckcnZm0S2bDE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB4946.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38350700005)(66476007)(54906003)(66556008)(6916009)(38100700002)(316002)(66946007)(36756003)(86362001)(6512007)(83380400001)(9686003)(26005)(6666004)(6506007)(2616005)(52116002)(478600001)(2906002)(966005)(6486002)(5660300002)(41300700001)(8676002)(7416002)(1076003)(4326008)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+egAG7f5ShzSvkzaG8pJqqpUt/x5bnYc2/5yBt+/ZyOsZKvruSM/e/gkLIO8?=
 =?us-ascii?Q?eIPY8w9B+clmtY07pGQ/zDkQy/1zAdxmb6l9kabw8xFWutwY2llDzsYFEW/n?=
 =?us-ascii?Q?jH0bcBIGXeyqZPgrqV6Zvt7A86UKrZlAPIjaNO0qmS2LezRY8vm06hG221ht?=
 =?us-ascii?Q?nPCaMOzR7N0n86IbdOKbldmi8oq1y+mSaez0FlnWNJjQLceDM2A6KkgNmvqB?=
 =?us-ascii?Q?oIFvpHz4FXDnAh7FSm87GMUQ2qomy48xcuxmcpncxZhczeKWt0qXEXw4gere?=
 =?us-ascii?Q?3qX+EhTJvUjKGCLhGLhpx9QCof4D+gY26LK82WhGpygSetHM4iU+CNAAaXNT?=
 =?us-ascii?Q?syzK2UC5uuVsjQeqC40NMs35MVmkX9hOTkd9b6LMUha3oDWNkJzs/FBxoTi0?=
 =?us-ascii?Q?av+LIlf+ngLwvujIVXal6jcTLBl1VcxqhOx4QLzIS67Xp6gbohyolEXW7Jkx?=
 =?us-ascii?Q?/g8G5o9iuOWNQgO0nUs0YZpu90GfCN0hE1/V3SDItesx0/3xWBV14M7YQ2Bs?=
 =?us-ascii?Q?wXkZH7tKbW9gi8rvyJPgi6vUuookGv3UJT1q/7QxrlplbLBIcM/4sUiqt759?=
 =?us-ascii?Q?uV3WrKNrVfHRc3wdn1X5N/rOOWSj+ZS4MEKwGre+7joF+klKo9FX3z2rTRyF?=
 =?us-ascii?Q?sxK66h0zCjWfPaTO0r7DQpwdfNO1cGC41j3cIhlp/JuqDlE+i1h1FLd/sL6U?=
 =?us-ascii?Q?Rstjd2tGfC72pHt62YNHUeNEuHq+PgTCkFSKKC89/HfcCdTmVUCS6lZQuanI?=
 =?us-ascii?Q?f+Fg+fGSuBh3CPFK2n+3TPf2lkjkDEkhFIMQ3fcmU3K5KwBdHmEF43UeUiZX?=
 =?us-ascii?Q?ZWpeVGLMHI2gLKHJcKBiUjbpS1enFxExdSpG32lgQGy5W8BzZiAxaNPA2IVh?=
 =?us-ascii?Q?ko92ioWSeEsldva+Jyh6OLT0H5uQXQeDN6wERCJXaKK1xAiCg1rVXvOGyJuX?=
 =?us-ascii?Q?KDM+f0FX4ayUO7VuQIDLXqOYBj1n5RoMG2zyjtqzTOZuElxey5GTCFS7ARyx?=
 =?us-ascii?Q?ytt/q+V48LB4aBSSKK5KrqYK01vTNOChTAWoEzwPcmqq8pF5ffr6YChz5q9I?=
 =?us-ascii?Q?8O0lpiG0cuiNAdoteTV7Vx7i5BuvJyyK7Whm0qHVTBmih+NvyK6VXgiKZMsU?=
 =?us-ascii?Q?vG38GEgRJZKjaIIgGosRiVu25ie2wskHh6Ln5VNC2DGjUGrLY34Ua6ArVa4e?=
 =?us-ascii?Q?Ytb3dOuFAbvS3dS7qcQy2J+obgJex0PbNOp9mKcgzft50Q0mCSiKVibtcUA3?=
 =?us-ascii?Q?qQwpFKWFtxxlBzWig0siXvqn6JqijK4qXl+u4Bbo6eXMEtFVXnLDdtprGK46?=
 =?us-ascii?Q?oXcQC43fa6RKyap4lraSJCz1o8fERDluTAVhEA9jH2sE6bi/gFc5bgtcMXKf?=
 =?us-ascii?Q?ugdqt9hjh4KW93FI+rnFbXgaoUWWfuBT6oPaHjOknHyTzGF1KHXvcXzGGqXC?=
 =?us-ascii?Q?JgcIOPeg26nPcOeNxwIPCn06gnasGQ6Am8iWVPoRkjp8FmBrVNJKUYIL1m2t?=
 =?us-ascii?Q?2OMqz0wjGOUED81+8pnmEYS9s0icr83DPf5Zl/3t7bn7olGO/MDLsNPxiAEd?=
 =?us-ascii?Q?7dJB377+YyqIiaa3avBmM413QPBz9m86aqHrx/n5LSkBYmD6TD09UL24md92?=
 =?us-ascii?Q?qMV5ncGdq3k0wQb0YCde+OQBxvngU/NOkaEfc6CinpUX?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee6cd66-e6aa-4cf5-9fe8-08dbe5d89e8d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB4946.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:44:33.9951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3jFuWQOIjFXdgvxvvVzRDZY9plpatSyT9kup1e4IbqGAlw8ZxP9sgQpahj1xBmmVcWGYiavqJOcBEgdF3hBkTxA88jcnz54QSwq0CQYMuos6wIe4E4gB73M25wQyEZm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5911
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
are added in the commit 'fs: fat: add bootsector validity check'.
Only the tests VIII, IX and X are not implemented.

I also checked the Linux kernel code (v6.6) and did not find any
checks on 'vistart->fs_type'. This is the reason why is skipped them
here.

See section '2. Size comparisons' for the impact on the binary size.

2. Size comparisons

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
series without the the validity checks of the boot sector:

add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-24 (-24)
Function                                     old     new   delta
read_bootsectandvi                           308     296     -12
fat_itr_root                                 444     432     -12
Total: Before=67977, After=67953, chg -0.04%

So the size of the spl on this arm64 target increases by 88 bytes for
this series. When i remove the validity check the size decreases by 24 bytes.


Changes in v3:
- Enable some fs tests for FAT12
- Add test to detect fat fs type

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

Christian Taedcke (9):
  fs: fat: use get_unaligned_le16 to convert u8[2] to u16
  test: spl: Remove usage of FAT32_SIGN
  fs: fat: calculate FAT type based on cluster count
  fs: fat: simplify gotos from read_bootsectandvi
  fs: fat: add bootsector validity check
  test: Add support to create a fat12 fs
  test: fs: Add fat12 to supported fs of some tests
  test: Add size granularity parameter to mk_fs
  test: fs: Add test to detect fat type

 fs/fat/fat.c                         | 114 ++++++++++++++++++++-------
 include/fat.h                        |   6 --
 test/image/spl_load_fs.c             |   2 +-
 test/py/tests/fs_helper.py           |  11 ++-
 test/py/tests/test_fs/conftest.py    |  53 ++++++++++++-
 test/py/tests/test_fs/test_fs_fat.py |  25 ++++++
 6 files changed, 170 insertions(+), 41 deletions(-)
 create mode 100644 test/py/tests/test_fs/test_fs_fat.py

-- 
2.34.1

