Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818E9CA0FF2
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 05:51:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9663383192;
	Thu, 28 Aug 2025 07:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Td39lXSg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87280831E0; Thu, 28 Aug 2025 07:51:41 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6220A83106
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 07:51:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyKDbFlYTwguetCZV7YrB0E2z2BQJnE1NEn1M6DFn2XvBcDBoAWBNKp/tXmqqpnKHhcpSXjLg+ISWjy8hFBsqTRnLCCOWhnQROHBzla8dGK2IEMSpJe0OM5Az19vDA42LnWptP6hkk2k7NJkkeoAWGyweLOVeDBuYrpxwnN7cggE684yy8OmFK7OPAUrWspMCERk9fPTpHnWTJ7N2YufuUaxGHcW0BatPqG4wXEQRpewrH2FBYjz/66hwjh4uZjm4/Ik5OES2O7AYCPrNPIZehxyV3Th0l3Bl2NBOULaKu8VIOFaqRngj63dTv24OKS5at1my/KWIQRjL13XWXrXMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnuhlFFSv87Q0CWP9QkrV0t697Oo5q4mUg3gz9RbWt0=;
 b=L8FV4JbAYZAJBpZtN79ZXZldo+sB4Vpsr1ATICqHXDkulJ0ulytHunMHGU939rWF0PXvhyfsMuPqNWDW5bUJZmn7YI1ftX5OlUuXnSzQs/CG61aLElH6et7+ymMUxO4SZ7Ruqlb7A3gPWHUl+0X5ozKtVAC6LKo7YYqp/+g5gL44fDxWkVH9yQB5HP7+u2oArkMuKkVMuy7di1OjA2IVClIxpAiNs3a9zAOfn+oFjFZSwooplJeVskdVfbnBQoQkYQe5omv8ovTOVEmNYoJmJFa0uCesrYdd6tUuwXvqEsldlO1kKo8cPsOFDCWHJ6c1T38zYpqsbRSE+66uHl88ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnuhlFFSv87Q0CWP9QkrV0t697Oo5q4mUg3gz9RbWt0=;
 b=Td39lXSg5wHFeUanUQRksFJiYRluXgKXem/FI3209U9DFVG9i42+vNtRBo3sFBSaSKsrV4qC/t3ZQY5bA5XFwYymitW/jmvrjuygLMNoY5MwkSbV0zjSWHQ7KisBrlTWU6lzjUyBqCD7GG9Y9ZtL4rUhNqhpejneHfR//9LD7PA5ACuvpUER8weMS6Ngj3dtxEmLd5x8ST2OJ5dWbQCLR6lpG2AAg359niZAMO2FFG54k+MNLhPk5AvqHj34R+edD00qBEVA/zu5Nn+3Hq8xGq/i0qXtuz+tfWezo372aAImqXJ1WBdycW7TQqFWS+i2MejblZ8XZjywuMrBdH+RbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by SA3PR03MB7304.namprd03.prod.outlook.com (2603:10b6:806:2fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Thu, 28 Aug
 2025 05:51:32 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9073.014; Thu, 28 Aug 2025
 05:51:32 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v3 0/2] Add QSPI RAW partition loading support
Date: Wed, 27 Aug 2025 22:51:17 -0700
Message-Id: <20250828055119.25815-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::10) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|SA3PR03MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 083e01ee-2fdb-4a96-982d-08dde5f6f0d9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u2ibuMAR1GRzuIsskQycpfjgVM9Obbcbi6kh1uAY64BmEQGiijwQmtgVQ4G7?=
 =?us-ascii?Q?EmuNRZTOqjgHgMh2YyKkeBMPJBrbjHSR2o+6bcshg8+k7xuCuHTfk6IOGGMf?=
 =?us-ascii?Q?iytbXpsNa5HAQj/7IVeB8l60oQ+EGXvWM4GnwjMXarLlIwVxXfiLlib91hEW?=
 =?us-ascii?Q?d548Jq1GWMbj2NrwogW09/xjpZVI/gluvQF5W6a0steZb7GPKhHD80L7dflW?=
 =?us-ascii?Q?gDn/xKCELfvaCxgUuYHmSpcIsDNEvIHUYx20m4GJvnkRA3z0Dk+HcBjbGWjP?=
 =?us-ascii?Q?frhRYOaVg0ABoGX0spI2E22b6uPOVNKyiSWdfheqYWOx1f6QVw9yWszo3TYF?=
 =?us-ascii?Q?3e5Kig3p4ECCl4SjSPXI6JwWG9BBB/MoDyI9HM8lJ/OH0GfRqH6UfTjJJJPg?=
 =?us-ascii?Q?xIIHlWPeweBPIoymLcL9WyoBAtRaShPr/dqiCubPr0UYKHSHB0f5CbYMN1fX?=
 =?us-ascii?Q?UARPTGU3tVXGizBmlVpBt6s0d3ULkP9kG59SJH1B6UEFpHCrZF2fsbAi5fe6?=
 =?us-ascii?Q?+Cvm4CvTNFoDUkpQns+zer5gbJgNSOMxhfwC6sCmA9utLm6FG4tO+wMmfoLE?=
 =?us-ascii?Q?KQ6Ij/LELe7NaamIDXB5bZWm/u+gPNvmp6cvcSCRHMbSSFrU921bRKYGCsOT?=
 =?us-ascii?Q?r79U+166Ulz/tv1aILbio2vimm9j072mg8tBfY9Ni6wAsOxXDEyLjp87KpI5?=
 =?us-ascii?Q?5eXWI0L07PzKFFSmFF2VNhHyJczmSQN9rBY4QEejbuFkh88zOEpjdvtw5Si5?=
 =?us-ascii?Q?1LsTAoS9HgG7wX5uoW2v9RJ4q7oULLyQbsd64GqUKWuP/rf4OPDw5rFyYWGQ?=
 =?us-ascii?Q?nKqj5MTe0Uhmd4JIgpMrJsYsbOJjvEwZ6Xds3DB98MLF3fs+1Ka7JKAwiZDO?=
 =?us-ascii?Q?Fw/LXFwSepdJq8whJ8AppNlAwibP/nkq8oxB7deA/4QGKjcj0S/ar1rxlxXB?=
 =?us-ascii?Q?vleCVP+ljh5dWv2BU1NeuWmp4iOhMaYoa3qu6Bp9eK3CfxyFJ3+gfB8pnAXh?=
 =?us-ascii?Q?a4m98dR/t98R6rW6mEARwLGOI++GVfpk+XTEwbdn5MAnAtvICuJoCYaDUVgN?=
 =?us-ascii?Q?0lZhPXAYDrg4hhILMruGbHiZf9Yl5otsBUkvgVaLMoU/7qp6SqBt8P1Ub3iq?=
 =?us-ascii?Q?OpSVQXaV4Ot0c+WRb106GcFHXFkeVHdiP4IE74uDZRUwZiimBus/ntsQ/X6U?=
 =?us-ascii?Q?iHZtN1fUBc37xIsXUf3IZ72Pkf6TYjl3FQhnA5ZKP/Q0cnG5gB0bAtxFa3qH?=
 =?us-ascii?Q?+zQJ+KEQVo0CFmAMeWeLt/Gay3O/80yYskA+dRkgN+HiutXjvSrZ3K5XcRSv?=
 =?us-ascii?Q?EppppE3GjlFxauJCVtkR7qN9qIXNsOGpvdtxL2ASY1gnQov8UDC50jZi5ZA0?=
 =?us-ascii?Q?yxvzW+Dj7B6CmFgbbKCE0WuJ/Ue75x4OpVkFm8o2zDt6ZL4iMRUUnqIpZpcs?=
 =?us-ascii?Q?7/hSnZRkgb8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?scB9+k1IUjeH1ikoIqUtZF3Q/jkPyKdY3cQ7YKx386jJFTaT0pOmlzmdU5Km?=
 =?us-ascii?Q?ks7APHZv8LfAYFQ/QkvuUPFdX/x9tBvRVO+t0T4CSWJwF+slRV3SomkziBwb?=
 =?us-ascii?Q?1CdYj5eKuUq9h6+FETkG4TvPL9ZVqbgaYaVXkNUqRCgc+dfImiCXZTfSZJZM?=
 =?us-ascii?Q?VxM0gMuTyzY+kA9hWetyMCjspULb0ITsRxHzdoiFhdapBu7CJDzwJ9UU083/?=
 =?us-ascii?Q?G1Rq9htvXZ8Yt0mly28jH0UjdgngDgu9cuV2/MNU6aOYcldU7zgMFN3i/wLm?=
 =?us-ascii?Q?X5UPNPuxKy3Pzmk78omnkpfxgMyO1Pj7hBi+FSMrFCl9KtqNqk45nD5lkjcH?=
 =?us-ascii?Q?OxVxazu7BJD0uxJKignBY8BiTKHAaIWcHpE/Co/GrRJNYDis17bEJ9GO0bN8?=
 =?us-ascii?Q?GlgCN4dgT00OSflpzRfHm8TTGWkAFx1QtQuuknueZ0HGLRSivne3NSSII6vV?=
 =?us-ascii?Q?GnH6Fr4dF0juXF0AWgMmrGqWicY+ghf6AuRj47fHJqGjfOwiQJGCEZSxvggU?=
 =?us-ascii?Q?sqNtroLwVV3yWihRp3n0LAgJOjULpuFTqp9cQ+eIz08cmslIM4iaXjYccaQx?=
 =?us-ascii?Q?2IlYwgq57TRInQb8BvD3PYHu9/EQo2uQovNRI571iMSE4tSNA3X2ZZfPKEN2?=
 =?us-ascii?Q?0VDKiUc6ulWGSaxzPhm6euEnDbGPPY1RtBPuix7Hsplaeow/XnDmDoVra0CG?=
 =?us-ascii?Q?QfQbjJGAfHMuImRKtXGAVB7nPBzs5dHG0l9WlXVtgQbJgFLBhp0nx5La7otn?=
 =?us-ascii?Q?CtwzwlD2qlByjUO/Xagl3O47LgoVgdoTcyCdqG5V3bw0LIkTTbOsG/Sgf8/L?=
 =?us-ascii?Q?Ks9CgKQ/7X/uOqKvaSb1eGKFC/19hJKnkjMZzLJ4V64aF1pYLvPyMHu9r99X?=
 =?us-ascii?Q?igJkecKZPR2R+SWcAT+fRteZ7IrLik8tieLfUOrWSBOgOQQkBQ74BtMSyIFF?=
 =?us-ascii?Q?ZupFNSwzYYZWpg9Ku4FKXcqUcTBmde5OoluwcvoXxOL3k1AQH5J1p11TDKyd?=
 =?us-ascii?Q?hh3Wdyt/I1n7/2tP/OHgtbi3WtoEG9YpFIF2950XuMcPQDgFaiemHUODc6Nz?=
 =?us-ascii?Q?aWJqRMBn9212Nf5HzduyPgPzh8NUt+MyzzF//6m2XT0fW1n4S8UnpBZNXTHV?=
 =?us-ascii?Q?rA9vi6jLgo1buaJkT2ZjN52V0ABUlJzUE3+UAE1xwrQdoR1CwPfani4H7LwP?=
 =?us-ascii?Q?DdyCTvSUwZDLqY/1soBpwteUJs1G0xDI6TwMBsnpcNRjdvTVP+USW3TN95wE?=
 =?us-ascii?Q?F0kOeWP/ZPhPNJAPHJ8rSY375QrvXKx0dl5s0OnyeBDeMDPKyiprWIV9WsFn?=
 =?us-ascii?Q?L5yfAv3R+U0PLE+R9d8ZUh+OnROd818tv8ndVt8lDRdyFmVKNabIdKOHiVtj?=
 =?us-ascii?Q?hzFJ4lvTGhLm+xUT3qyZf5dk8zRJqP5dZB3l8S48CtszCMr7yn9YEMF0Ybzk?=
 =?us-ascii?Q?ecCwRwGG48z4lM3WN8mTekhYF3BKzWCu4XOOHGUj/O2rNVL6Fzzh+RtIIffu?=
 =?us-ascii?Q?CmAWUbAx+JQCqzpL9E3GT1Z1q3GBOS66izS25p7MY60eDFOu5YqwEnBvzg7V?=
 =?us-ascii?Q?P/TBtojVAJ7u/x3eTqfnNzYM4qGpUdZkRVT1TXokPQ+Z8GmIrohOmEBNXIXU?=
 =?us-ascii?Q?qXiFPyeP9ndkd6b1Mt5WyC0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 083e01ee-2fdb-4a96-982d-08dde5f6f0d9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 05:51:32.5799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7l5DRW4jIz2LKiah8OBl/zcm1bVSk2lULV/7u2U8Fs0Xp61A7v6FZh1i8p/iuiCIbb/UI8EXo7wmOPJPvrnDGT0Bmj5Pn36+IrNHeTlxEzVtAOcG7NYMWs6JttohtPH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7304
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

Enhanced the generic firmware loader to support QSPI RAW partition
loading. This would enable FPGA configuration bitstream loading
from QSPI RAW partition to program FPGA.

Tested successfully on SoCFPGA devices.

Changes in v3:
- Added warning messages stating explicitly that RAW partition
  doesn't have built-in data integrity support

Naresh Kumar Ravulapalli (2):
  misc: fs_loader: Add QSPI RAW partition loading support
  doc: misc: fs_loader: Add example serial flash config

 doc/device-tree-bindings/misc/fs_loader.txt |  11 ++
 drivers/misc/fs_loader.c                    | 113 +++++++++++++++-----
 include/fs_loader.h                         |  36 ++++++-
 3 files changed, 132 insertions(+), 28 deletions(-)

-- 
2.35.3

