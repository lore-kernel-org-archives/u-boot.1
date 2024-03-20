Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEB0C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 13:19:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6983287F64;
	Wed, 20 Mar 2024 14:19:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="YgXD+0vj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76BA68800B; Wed, 20 Mar 2024 14:19:41 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2072c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::72c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A24FC87E47
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 14:19:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2NDYbtuVG577HIPHtW9/ujJrCOh9swtRc1AvHpMBGaBjrgZoFh+AtHrMbjIeasCAoxgue8XgXU3xruGpgrM+2veRF9M/+/oppUSetEvkL+GsMznIqMs2u7xXoJfGFraLe5pl9BPrb9qmvh6ZPvPHc44eo1NvsuJACKF0NvcZ0Ouotyst0+HKdw6YA0/VnFdOwVA6pCQF5O8AmCQ7vj1NBb0CGQoqJRq7+jQYjJ3OAnMWYr/frxhobqYhL6HBCtFMXlgtdsRkRBAgzMv90nFL+JANHDSg8bFccdDD34eAXMN/bARuGj3iuB2YlW847bzy3q56tfA87gxL9kWy8nUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuIAWhsX/6T8cmd2KLeb5F9CcrMkqoPS2bz1dG7TKOE=;
 b=J0swUB5FkiwKgfePadnmwshOz6jyumTm7oJ1ADxzwDKjhIMiwG7cHte+QQjvYl+/SYVNj43tVLjJNjCWgXvs6QO0aLgSlGVEWZJR7yhnhA7daKWpNANcJQbjGqMA89WqYtNG1H7WICk0uSeBZPr1bRN9UytzlEa39j5uW/nOwT0qU8uYMatbmU9XyAl26YEapjGTwqhDZby0cnXSbC+Yatd/tS9Jda55Pmr811Ua02FMdD+yb6iNeV6oMTfIpeY932smWKtHkRzk0MndzpfsrL2hy3+gFC/RgcjQ3w3tfKFeyXYCsWQ6gJpjkCtbqqk2Jogs/+SbwJD5UOstPGc8og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuIAWhsX/6T8cmd2KLeb5F9CcrMkqoPS2bz1dG7TKOE=;
 b=YgXD+0vj78PfCkWNotrcKG3T3H3Oz0LcL7ckxRt2nhPoFLejfzoi/mep7bctVuK1rtyOBEMF6neIWXToNfjCn6Eak62iffUMd8HlpDMEoB2liZ3B+f+g02SzRG+6PQFUjZPEpgTXDWQM38GUEtibmr4xxcVMbMA02BEwsqpjA18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by GVXPR08MB7797.eurprd08.prod.outlook.com (2603:10a6:150:5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Wed, 20 Mar
 2024 13:19:37 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5%6]) with mapi id 15.20.7386.031; Wed, 20 Mar 2024
 13:19:36 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Bin Meng <bmeng@tinylab.org>, Chanho Park <chanho61.park@samsung.com>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Devarsh Thakkar <devarsht@ti.com>, Fabio Estevam <festevam@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Linus Walleij <linus.walleij@linaro.org>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>, Nikhil M Jain <n-jain1@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH 0/2] Introduce spl_arch_init() for architecture specific
 initialization
Date: Wed, 20 Mar 2024 14:19:25 +0100
Message-Id: <20240320131928.1836386-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::7) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|GVXPR08MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a2b54f5-50cd-49cd-1a2f-08dc48e063fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VR2ohd6uchXAPJ+suw99mxA4ci2O890xhOFn9fNkylbH+sCz+ndsrm9sJEt+CA2+KHBXS6s+QMUh45fQbFz9jwe1lIBL3uU4K5KZlF7KiCHuRKqwrFw7Sjf9b4oZoanbxjUs9NLTzvJ7hsher8pltcpzTa9YMNjc8ZjPKgZ4PDnGXA/LFl+bwes9/9IB2muRLFFeqKRnoozh23/4BjMiDyRIOWUjNvjwF8HtvId4rD3TozN0L42sGjbM7LVc1tK/rnYNUeUhGM3rWVIzUH5aXjYo3zbbvE9OVdfXLuPIzDdQqzoD13+mxip6ZiNY07ZR+BAArzCqntLHJ5+vaSQnVEfs6SfdQxbXSQecvroNLNS6nqGVH/LtZ6nbFoE8NcmCx7hpRDnzKqRmVNBaH4hp1RZJakHPLJKMgGcluMWVvi2Eq9cc4VOs7ak90444AOYwp8j/mja3pdQjLNgU57ELgr4WmqeUNWeIQkAEmwHQTPvNVxBw0icV5044W0W3QDdm68Zr8DQWLTxGorux5rEy6hcUSJD6bQz8opV0X4vnC+6CW2KMug9Pg1n6uNeAuuE16cYXJgYq6v+U91JPnvNi/gpDfiTWkr9x1F513XhNK3rOBtH/oUEVtNK/nxBL0G6wjwzd0Qp26yBWrQvhRSutHBR5u3mebbxdG1WDIqy8Fp1eB+jd70DC3Yg2Z56aOzVV5SBK4mDibRQTb1HqX+YzpVIrNdiJjBYkKleIlD0TIrw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vb2jVomfXuqQ2FF68KYmDnZPXYLfAwSRk+9of6sTYhLZBH53JnwMizADanyL?=
 =?us-ascii?Q?Y98+d7DHUmxkX4AN10bQ6wW5j5yNqyzaMrypZm4qfd6QqqJ2n17ShtBV7iNz?=
 =?us-ascii?Q?rDZR/dtfS96k30MHbYw25HQZrt21ZnxItEP7jgrjKfp3EYzjPS9JkS4c8+9/?=
 =?us-ascii?Q?qeOqT3a5kxi/7pbimzzOIFZR+pvZu0oe6bXSNPELVneuRky+lNPzOLjL2ALK?=
 =?us-ascii?Q?4YoScgbcK9vTZEcxBRjDoAoTMCW1YRsPCh4+eOrnQlnc21PxT9fNPGBxj0kg?=
 =?us-ascii?Q?MuX8X/CwdgS4pmtQo1zOISYv4VX3WuVusNpsUc84dajqRNxo9N80hbf8B1D0?=
 =?us-ascii?Q?MqaPyZgVgOzWNWL8WzIKDpJiuj6CQW84Ytgm6idRdvowCn0z4+Cj/JRiPaIY?=
 =?us-ascii?Q?F0RbVI4631fOz9e9VRS4/kXmAfQQhAIPLkIgoEovj6Yq4nl4hSgqU7tzC8bH?=
 =?us-ascii?Q?7yxqRtQnX2CWK55w5ThefKTNyWhQtZxNDO3zFvZju+J+BcZPFKIrlXUzgHmY?=
 =?us-ascii?Q?sBEO5ROa1GlE31geK8zqDMW/sxtSJZuSff74k25ekmCnPvEWLD7DJINR1doE?=
 =?us-ascii?Q?KAc8ICsg+G9klrsgjLaZ8xaW9ee/7fDhWKQdBjeJpPLsZTjQAGh0pLjq0gUV?=
 =?us-ascii?Q?7xmZrIn2O6ZLa1gQaeSGOHqkpwlozQCPYfmXk1c3wSeEjDiTT0xOD+2jCLcT?=
 =?us-ascii?Q?PFsBqu9O52S371VBDcwW09Q4p3Is8F9C/RTJ/p9wQ4Fzr163k/DwZCGSDwgx?=
 =?us-ascii?Q?VRg5go0Wz+mi+g3xdwp6Ke/CongkfUiNfAgYwpuKzjdO5OKSngHdikIE+0QW?=
 =?us-ascii?Q?HkdvkaBifPsds3scryCn76BOdNWn1yNe1A/VssZx9tQsY8W4a0vzaV5zxn0Z?=
 =?us-ascii?Q?gAZal9oWTpMDBIXdXMXTSAnzG2Ykh+0IJKi4RIyoYkNK1gzHr0vSRH3n+N6/?=
 =?us-ascii?Q?TBvHZwoSwGQ5edusEdp9mDjHZBok15Nl5CW0vTMtF9H7z5ioeZt2rV7B3pCU?=
 =?us-ascii?Q?k4OO6vi/UGLpexAeM4CwQ4HQt3aQDCvgifpZ48xZ5fLKeMAwMd50q0bsCxMB?=
 =?us-ascii?Q?8QjMwDz6P6qmOKfokmeGP6IHlXndyRyB6gj7IMQ4a2EEYzEBrgpPc10hozlb?=
 =?us-ascii?Q?CDO4XTR2kTFCtbQovQFaIVWA7+r3V51aXEgC/pRLI0BoHwGWLPc5aTrK78gL?=
 =?us-ascii?Q?lqcbTv7Z9jxoVthYVvH2OCHq5MiKOWkVlGV9qSW10WGtsgxp6eYZqNMLsf/n?=
 =?us-ascii?Q?vaRPKizCOs38PGZ2B+5MmNUXoSajFQNm8UWZTy6eEcBgeXFQrOfm6pyYWzFM?=
 =?us-ascii?Q?wdrmgjK96s31BteXp5Rvf7Oeo3RU5M6BabEx9OWxOVGYQZuUF5lbDU+d6oUG?=
 =?us-ascii?Q?erMfDbclGoAZW2CMNnfqLU0fHx06/MKFufMGWpBffgpWTtF+IPmbjzejlEGZ?=
 =?us-ascii?Q?6+By3orptqQZiOilvp14A8GOGwWQ/EWk/+6KUJEY9sNQdJnAUWGJdaad0f/1?=
 =?us-ascii?Q?NTFVdA9MM0xtQOsGvf6n725hZWkKqaHjSMoEQEpqqohwkuFUhFRpzWa8hA+u?=
 =?us-ascii?Q?y01JhGHzEKt9u+wMjLh4mWP7jTgokZ9ES7C+Ynx+adqLlBgMM64NR81bq9Qq?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2b54f5-50cd-49cd-1a2f-08dc48e063fc
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 13:19:36.8460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9M5PyKtDCOWQ0DcnS4U+Rtt827VHXV4ohQsWcIc5Wj/I5Lb7qki/ig1RWZBs+DTb5meQ/Sl5+QqgAk48Jn/2PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7797
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

From: Lukas Funke <lukas.funke@weidmueller.com>


Currently some architectures use spl_board_init() for their architecture
specific initialization. This prohibits board developers from adding
board init code using said function. This series introduces a new
function in order to separate arch init code from board init code.



Lukas Funke (2):
  spl: Introduce architecture specific init function
  arm64: zynq(mp): Rename spl_board_init() to spl_arch_init()

 arch/arm/Kconfig           | 4 ++--
 arch/arm/mach-zynq/spl.c   | 4 ++--
 arch/arm/mach-zynqmp/spl.c | 4 ++--
 common/spl/Kconfig         | 7 +++++++
 common/spl/spl.c           | 3 +++
 include/spl.h              | 8 ++++++++
 6 files changed, 24 insertions(+), 6 deletions(-)

-- 
2.30.2

