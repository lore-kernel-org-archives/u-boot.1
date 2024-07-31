Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D656BC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 04:11:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32ED787903;
	Wed, 31 Jul 2024 06:11:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="2b0G2mDf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E2CE88886; Wed, 31 Jul 2024 06:11:44 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20714.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::714])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A2278641A
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 06:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tS/AenxeAoKJlY/M/iR8ARrF+WaRJh6fT1pkdPDWZKSFlhYVL0Jfa/byQwT3W3bTnLE5UQV/CjjHP/omRdgad3zFVvsepIhg+azGrDH4LJk4D4Bp/7pQX187VNxB609icH6AGbBAPB08QQcTBN8e03dWKhvghUR7teThkH6Vcz46rABMrCjJ4ZK/ZLZIaHF2kNkYYRJ7At603v4EgOWOTkq+clstFh7gjONeoZA1SGqDI3BPZCnuBUGojSnwa7zeYtDK42vVFHRTK4mqvFuqsxbf9ZTyPZFqupnyKLTpZFgA4+mPNzucKk5rB9JaYwQ3QnJaY1NRzlMhSPu+qPo0Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzLawb8dV//VHBWFLogbp7s/tUUK0M7A/JzvdkuimYk=;
 b=GRLQcXj0ku1XHKJw2jz1B59UMuEFsANF+b3qIiWQKRN6eKYpT0IaJxLOiZDy0UHubYOxjnXBZA2dOB3808bxmYE610VE6ub5CiRSIeSWXSkij0eNXwETGew4Qxvd7aYFRnHEEVkd5+yextJ+WbTVgdS/O+moQPR8jtfPbqOe+jpWjhT6cFnJPXTNHirA7SGu9mCcNHxc1q2FKVSPbKhEolyODzodQtbPYwWEnDh0KssV50LgB8zNwraMCnzr6LsKDVtQpweGrbcB5DqD7hOLLPdo6wZVNZeVqrR0ABiBUtLDeD3Dml3TRBGZvbmEDwGaPXMp/k3DfgxGBYcIHs6PNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzLawb8dV//VHBWFLogbp7s/tUUK0M7A/JzvdkuimYk=;
 b=2b0G2mDfem62jucts1Tf/p3BWkgVq/nNJVts+pzeH1aljnow5gr9XyKyHlrNgR/4rqQwDJTVmcicEZBgsztqqN8TGBtOVx1AyNekcx5F68sL3yfQfLEQ+xC81QKAG2yTcdZF9jQCZiy9k/YpsTaAUJYiREtpBi+66Y3kFMwbnG329xR4xO99SL+6mhMqX4msxlGRLmry1TnELfn9tQxxQMOgyVqdrgxOORD/YFrZGMEclRz0PS1ND5JSXuajkY3VH32gQvtzyIceZPRV9bMUjONRYIy4RyJ6y9tZIjrvEL+eTMXnJDuLoBPw7Z0KTI0xUOqWxvGDKxvzOdpJ3OpWww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DB4PR08MB8125.eurprd08.prod.outlook.com (2603:10a6:10:384::19)
 by PAVPR08MB8967.eurprd08.prod.outlook.com (2603:10a6:102:326::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 04:11:40 +0000
Received: from DB4PR08MB8125.eurprd08.prod.outlook.com
 ([fe80::e9de:ca06:dae1:ef2f]) by DB4PR08MB8125.eurprd08.prod.outlook.com
 ([fe80::e9de:ca06:dae1:ef2f%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 04:11:39 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 William Zhang <william.zhang@broadcom.com>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 0/2] spi: dtb parsing fixes
Date: Wed, 31 Jul 2024 08:11:27 +0400
Message-Id: <20240731041129.3839918-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0093.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::33) To DB4PR08MB8125.eurprd08.prod.outlook.com
 (2603:10a6:10:384::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR08MB8125:EE_|PAVPR08MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 3676bb1e-ad3f-4a76-f18e-08dcb116e088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GXfrMa+FpiRBFpSz1K2+zKgOTRmC+NWajIrQVOuJXpzk4p5NBdXQKH3w7Y1j?=
 =?us-ascii?Q?qLuTvI9XtnWWkfdfRlTPuNB/QHuEw/HqUXxt1DdDBrUnpHz7lj34NMMs0dpF?=
 =?us-ascii?Q?QGYtzJuZdsd0Q3r0I+0YdcWKpC8+GVnL3/FKNDHlk+DvcbZhTPnW/IAy76q7?=
 =?us-ascii?Q?axgobiTw3M/T6ON3b/izKyu366/Ej6m3DuUYLwBXkte039SO9icTyjLjI4PO?=
 =?us-ascii?Q?2Ui3qkp2AS6rUUZZSZ49AjC9O1Nwzn/8uK3RbF2u5vyTbYE9SE7qk9NlU2Br?=
 =?us-ascii?Q?NacE1600LOVtOLjMC6HZOBqub4xH9PJz+HGvnDF5wNnubx+NHB2WU3orT50U?=
 =?us-ascii?Q?bqoM5wq7Cfp5BXarmdBwXyNflKMQKIb3DraJLJ/KENvOGi+EWY3UyyLfLyf3?=
 =?us-ascii?Q?QSbYmE7ZjObz6I6MVbAAIEQv5ZSOKFW7mEhOv7YTJp4j6SZVYl7pJVi964Wv?=
 =?us-ascii?Q?m5PPb0plV9tqmQrnxQl32ubo3vpbOCHF1ygbk/sZ9jK/fL14Oqe5qCAWJz+n?=
 =?us-ascii?Q?5LEKMqxYFtUkS1Q8XI3h/6yKUA7R85l9Rhg2EfGySLFfiYY/AKxMbNvRShGI?=
 =?us-ascii?Q?C2m6Bg4EgEXOptPZC/Uz32+ZBWN6Z07Xs1n30iJa8FptS/TrYskJ1Pa0NCUG?=
 =?us-ascii?Q?QCb/GC34kZt2zs2WmRBUogfM2NR6Ro3NIhFWRf27THM5xEL1GOnnhuVj2tTE?=
 =?us-ascii?Q?tiEWCyRwXlHLVi/+9qS6kNFeP+qzcPLPt4B+6kGRxQIP10SRCHFpZFAO9CHM?=
 =?us-ascii?Q?/VNoLC9whS6cPIvhmvrp+XilXb+Uml/fSaxUqv8H7/bWZwT473HNuxSYDsp5?=
 =?us-ascii?Q?qkLL24G2hgO+slGIt4KCC2DbccSrYnSuieW/e5UO/ZM3IxeBIKeYoujhDruP?=
 =?us-ascii?Q?772TYF22QjICxpaRUXypFwVZL0llsVhlwCt1GWqU3DQAj+D+YKfQ82YbHCb3?=
 =?us-ascii?Q?mktbic5SN5wln0yDYlbTIfGNPGekuYs+gVfcPjhI5rF/VZagt8e/cpDJEPg/?=
 =?us-ascii?Q?biZj24x2SB0HfTibm6+217UdlHI8s3akARh32HjF5/iCWo0Vdr5pllBYbOU+?=
 =?us-ascii?Q?0svWOMxtj20EjmeDduaoFlZLzdGX96BlPU+KGXUezqxtDdV66LRjjAwz1rWF?=
 =?us-ascii?Q?Iy+AUOyjmpkVrmc/s5YUg80UrgK8XvMdaF1xjC3ixEhtdEutwNbG92ES7ySj?=
 =?us-ascii?Q?fwR983m3XVcjSlbczgqoZa1jZa6xJuww3mZDgbK2i5X1hXnvvIASsvF2Z/a7?=
 =?us-ascii?Q?izu5xoWilLRR61D7gNmGd8zbA12Y0vSEnE4sID4hcsu0WzpciAKZIbxMGduV?=
 =?us-ascii?Q?hgF6c6RVEudAr52C62mxrVEM+IKsGsgQ39yn67UhtbkjlFkjLWi+7mT6kApg?=
 =?us-ascii?Q?c7ipP4NroE7TOXJ8scNEDa6KFG14mlNcsVJ91IUh4JO3z4hW0w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB4PR08MB8125.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x/p7G1IOWu4HIuXGnp9x3CS7keBxW/47lGklldbXLTPVytQbdoG3qP+Cd3tY?=
 =?us-ascii?Q?qqgJyDSMlj01yD1DU+AfH6ubv78A+KAU5Il4nbWg/GMcO3x/77QXJZ18CRKN?=
 =?us-ascii?Q?rovWCIyQ0NBEruj7cAZK79mtW2OIe18OKCKJet0RY3dbC+aB5RR43Eeo0h1h?=
 =?us-ascii?Q?1ldFccMEIGjJ1vxvyktZ6BpRISUkVGT7jE+rJ0zIfThiMP+2X9K71slqHo2z?=
 =?us-ascii?Q?PGx7hCqtWssRvdpeSLyTgenT8hcywDi7pDkPpdlTMH3dqrCdVQV+SNpncfnD?=
 =?us-ascii?Q?GlLdCFLi9WkgMuqsQGv8+Woc6wM0tuchL0iO9G0XSaX+XPgoT0kVEKTdfrVM?=
 =?us-ascii?Q?FoC7PVgOkNMbwa2EzuYaf8/szmlw3xB5tfjI0WmO0qOBZtvtEVnBYLJIsNPh?=
 =?us-ascii?Q?EpN1oHvyvtAMy6uG96qwcHsnWDn+YPeHuj1yeIxlzRO2buSqPhisStkMHfR9?=
 =?us-ascii?Q?+dp4Al0bjk7TCHDLjzT+LH+cJAy3hi4zRGzUOcY95nrGscbWW+2mmqfH02/G?=
 =?us-ascii?Q?WqmRn9TqXUW7s8wiGu8zACFtQ16wud8jpXXLFVSmm8//aeQBKefKjK2TSnK0?=
 =?us-ascii?Q?Ei9ta+oXOtWUwFdZlz1Pj4ocQvSjLUw4lR2Xvi3OAOaZgSYHnBcLeml43kiO?=
 =?us-ascii?Q?px7oDhoOpXUQxTI8PIyartUfKfcXZF2AZT7zK5RCxxdr2oliqD64XwHv72fe?=
 =?us-ascii?Q?tPdLgA0CP1QQX2clIky9M9oRYrmXzxQt7aGA66l18on06Y2nGumwMnuhjqmD?=
 =?us-ascii?Q?GZhJeX0N8Gc73zKmgPEcY45OmdtXsd0dpEjsYA+KOc/w9yQ6Tmu3GkhTNT4A?=
 =?us-ascii?Q?hPKe8S+P0lfU/VmvkcFnpHnfbOX9HW5iUpfcv9okJ75J7O1oYHiKz0e8L2yW?=
 =?us-ascii?Q?ZYdF1PMqSJp+r09evGf4utH7z2J4e7PbSID9dD4w8GZjECf/NYtCyuA24tR2?=
 =?us-ascii?Q?I2ZIEzt0pmPnFxA4RKwnaLaaPU3IWoyj+WSDIO9MdxXkgq6K6cVof4GxbD33?=
 =?us-ascii?Q?BQemTUKiBJ1OxblvoBGQUs8z8Th5HrNiPvFiFZweIJJJzyrv6/adu2+vJBfZ?=
 =?us-ascii?Q?lxQmOlL8vHh4Xt7JhArJjrvx8AGXL9WBpJI/yG39xSrZoe0uYWpO7BSJ4QVM?=
 =?us-ascii?Q?u/xZLmndseVhY8m6lGWv/1PIIE7gI9HCB059y1irSn7ohSYgh872d/g9srZY?=
 =?us-ascii?Q?RLC7zEzuvyLauIPcpjjhigeuvSU8n2Hk9pbtm96ytaZwPADb5y2SlUpZD3mZ?=
 =?us-ascii?Q?tPA9U6720TlfgFUp0NUQtevxh/vNud6HOQjh5amuhRJDZX8PZ5M6KSkHVja5?=
 =?us-ascii?Q?X7+lH+WvM0DCNfKM+vuaJIQhRYRyAPi9/1nk/MV6DgoLRSAKgR7jI2Ki0oaq?=
 =?us-ascii?Q?vE7erqdgGZT+n5h+cjE1GDiBJ/uDOz3rpaon6z30inwNHCqsyN0dnaOdHATA?=
 =?us-ascii?Q?xH6HHmg0/JcCIkKTbvTQb8G1I4GerJN5iNAGfJC71rNvZ4sipifDISKM8HFI?=
 =?us-ascii?Q?6YRNzXYPuFdYyK+Fzm83ic5i46H8rdBtP7QQxMPVyEIo6pCIbhOO6fgMcU44?=
 =?us-ascii?Q?XKfSEsmARlZd6XHHbknDbH6PRERtKPaX+WkzGcIUNfrAxXz1X+BhlvHoghkg?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3676bb1e-ad3f-4a76-f18e-08dcb116e088
X-MS-Exchange-CrossTenant-AuthSource: DB4PR08MB8125.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 04:11:39.7529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: andDDM2mKatBAlNLVTv6iu9sh22lfy8SiNLXb745aaSwxUvholwE94dXOwfGt+JQ2JwSZ5sRfCIWpgM7VYfH1j4ngAxKrfk0cyOkFYyFoVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8967
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

Changes from v1:
 * patches description was updated

Michael Polyntsov (1):
  spi: soft_spi: Parse cs-gpios only if num-chipselects is not <0>

Mikhail Kshevetskiy (1):
  spi: soft_spi: fix miso gpio property name

 doc/device-tree-bindings/spi/soft-spi.txt |  5 +++--
 drivers/spi/soft_spi.c                    | 24 +++++++++++++++++++++--
 2 files changed, 25 insertions(+), 4 deletions(-)

-- 
2.39.2

