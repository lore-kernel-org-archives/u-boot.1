Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B61ECCA476
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 04:18:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98ACE83816;
	Mon, 13 Oct 2025 06:18:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="WfgrCoi5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD02A83678; Sun, 12 Oct 2025 20:56:29 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D7CE83678
 for <u-boot@lists.denx.de>; Sun, 12 Oct 2025 20:56:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDHIcr1oEE7lrtyMZxY7paFEQY51lzWMl4+MQhYIQelwESlnOzPzzzn/ZldwNMlxzb6a7QQMoK4CpF25BwMpMH1uJLkPdrSUFvLsh556owq4YAn1LqbdORYQAvB7Suq2Gs/76AZyLq0dfCJKAU2lcuvrV6F8vd6QBalJAX5FlR8Y5ykWQYS5O8ILSvUcwuMKxMxNiI+7ACmeoiRDoPRnkFs1Krclpyz/Fq3MiZCwwTW/zdB6UgS5QX7RxMt315rEJF7lTAVpbg1UB7+fh8y+3G6WDvsEjp7KiGunStGugDkCUZ37q1lLLbibjU5bxe+MY/erWhpohC/QCyreCpbKrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqZ6Po6vvdXy0Eh4VqzCHVtFcsLvIQTaAAIXMCD+B+U=;
 b=FPSyXJnVnjqHHBO8bMgEcb4vMry5PJ3r8/EF7rJhC01ERJ85BJhxQkE1IWgjDXtm+8j/2ccBbWEvhAQ0aSsxdoKKY3IIqDc1HG+KbTcpVrYm776zURCiudh12r1/4AfjZEPmiwrjHdIrirxp7eUdnQ73G459DZfEk8PvVyGZNpXVRAk8OBgtqmS3sA9rb7YKNDYMfCh/p78ZTYx4M+abLResLq083Ny/pEeaP9xVA6+eO9/fvscZ0ovXda0v1A/0fQ5wrUdhRFz5tpZRLy6Ep5zjwZ+iGdUd9lcVrsYVIC4acVCnIPSM0q29b8b+MsG2NCNw08vfGEgg7XMD+NADow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqZ6Po6vvdXy0Eh4VqzCHVtFcsLvIQTaAAIXMCD+B+U=;
 b=WfgrCoi50lDRN8Fb7wH/6AnsMxxvcxGwbYTTJBl9EWD/EjjywYhQd2NLobQ3NECET18O1TL1ZyJFGZaCu21Dk223qwKsQkWpVNt55dSJulSBHQzcB7s30PumMtRdYmpeuyYxrp1DEQgKQ6kXvgPlMocTNnFLhQ15pSouKpKO2HnxHmHQ1V3LjRbigJobl8h0EKz9HGC1YOvYU63s5j4lpfezZDh3ufUuvxX8ZzO3XXguCOAGjt9CNYTG20z3YHehqPyROFj7mPw/vvH1mr81s42yTT3MF2ialZdEDnNc/0hwX4AjyjXNRE2OfbraJaDRjdZ0T6+Ugfri9wAxrNctCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DM4PR03MB6973.namprd03.prod.outlook.com (2603:10b6:8:40::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Sun, 12 Oct
 2025 18:56:24 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 18:56:24 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com,
 tanmay.kathpalia@altera.com
Subject: [PATCH] gpio: dwapb: Enable SPL support for DWAPB GPIO driver
Date: Sun, 12 Oct 2025 11:55:58 -0700
Message-Id: <20251012185558.23808-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0088.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::29) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DM4PR03MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c8c22f-2744-49b2-fd85-08de09c10ac2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hfwpbHtwnFdu4o3Xa3z3k13wTvp4pYADnyOsju0EujjXu07obqZqigVH03Tl?=
 =?us-ascii?Q?DQLJQ+igeyjW/ZLUyuP0y+99Vfviau4wj8gd4D2N3jc2H2xfuMRYtY8knTEJ?=
 =?us-ascii?Q?zlHTFwoh9dMCNRpQJzcmviPV9wloEKqrO4gEycbaaAYiRAiDOikX42kMGDyF?=
 =?us-ascii?Q?COOjtfI7Ts3s2tU29QJbjx87na8RWhSA0GIzLSaYIOpX9M/doPC/0nmL+3Rr?=
 =?us-ascii?Q?BaBcpXInQ+/ElNOASfWELAlrXVYbAHncnTJxEd5592zE6rtmsn8l/Hq3nJMq?=
 =?us-ascii?Q?1avbSFaT9NaQx5XT66IqSyUpUy98xDyiuPPJIlI+rHxQhf2E8JyngQ8oxkOJ?=
 =?us-ascii?Q?oAjdG6iIHFvgE/yygiphvUc5uVltoVBYPAZ0XfX9BZ5NA4YzJDR8ygjYX/Tf?=
 =?us-ascii?Q?njdagTYHlSGzxnfoDYSZhoK4opnHhKdfZpTN4XpJgiAxS4ZFZt4DGE6W0jUG?=
 =?us-ascii?Q?jdnNU9IKddVgTKP8/r3fnu3cghrepCPcZSUhnQ27r+G1SOCKHkmbnc1E4St5?=
 =?us-ascii?Q?1ZGjRtEJOeQwrciYFlhAQRSbBMDeAokvRxXfMFK1kAQ0AAqet3i2A/WyeHbh?=
 =?us-ascii?Q?1eBzlb2biKfGuLUtabYiTYLCdAzRK3NnPp63cV4PL5FxHfObZMZdYSdPDdUV?=
 =?us-ascii?Q?MO4BUMlq+6y6HuJlzZ4vqnrjGofMrc3kw40x0qFLvAmsugeW83CZMLFA65bW?=
 =?us-ascii?Q?LVbHWjpBz7Kjd591UsETy3dduTYZZNgm0fY0xcvNyE8X8a/F1FS0suKGCn1v?=
 =?us-ascii?Q?tcnpH2rxCjPNL7Pa+KY84NHzy4bFY9am1jjSel3pt46NmcnCUosjFyXmEdKP?=
 =?us-ascii?Q?r84gTlL5AmM5Kz5nWTKwzoUfylR71j2IkyCyfIjcn9mZr3KJr3b6El2dHhT/?=
 =?us-ascii?Q?auUIc2pVcCIjmFXVnU53t4+MQ0dBhTCjalslcUq+NsT9yef13b2EbVFU4e2s?=
 =?us-ascii?Q?0PLjlvdUfRUN6n+Nz4Ara2M+i7bsNh4Hj07YZ+tq2LzS+xkSYjN3vLtuHZK5?=
 =?us-ascii?Q?5o2Uyh9smvYcwUo8r6CYjohbZcFX2O95ekO/DM7eQUyzKrfQQy6AzJ+Jg6RF?=
 =?us-ascii?Q?GudwsxBJYHZkRN4LAluSUu6QkpAiLbZJ3bp0U1fBxrUja9bnIaoI+V/fT/QG?=
 =?us-ascii?Q?9ag8jf9tILsX5lu767ffufCHejwwaZl+o6yAlUL4qgK0sgul/7gldBIvccXv?=
 =?us-ascii?Q?ob6Qrv6dLlHPCXNMKnaARWHnncXjTgwTfonaPybN5NvobEFQaFfwKOxbJE98?=
 =?us-ascii?Q?SudfjyJJtBds/mKlAlp34O5fqwNxSUbcrrbytp+//XNMmKBqRjW5jgZjedvU?=
 =?us-ascii?Q?qUwh0XmZY2XomJhSfKP7gAzE/n1uIibDisKrRJqPzAIQkPuiorlOcMhc2mSi?=
 =?us-ascii?Q?JFHzJTQjdwGG3ZOFH0IeFHTFv4f3Zby4TCiKkDH9gc/XIjoTqJVSngvMJz0M?=
 =?us-ascii?Q?klPw0qjfJMCDBzHbjRr4uZQnlvwX9pWY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1GR3wj5LEEDRw9Do7rPTV4BehA4+Hi3EqC/owKvyl65I6E0Oi39BruPocMtC?=
 =?us-ascii?Q?RJXfplzP7tRBYkQ5UoODBu85f0376PzuPCcZaGuMQfRlL/4a/9+ZiBKavn6T?=
 =?us-ascii?Q?1Y8eUGMs6Hhkm0V7/xQXWeR85hcDHzWUzsrjIzpzPtrxKIDzbm7y1MEG8v8x?=
 =?us-ascii?Q?ChKSTFsjMeTBe9Jb6D2KboAFc1OiULyI8Xh3scsdDD4Ib8rcvjmLck4qOb0g?=
 =?us-ascii?Q?u2W+0K4FdyvfJsYX0eIQi3hWYbVhBjlDIgGegrOdREMT7mNkQyoZ+eM5yLbe?=
 =?us-ascii?Q?6EDMeqfWHLIEB3NBdC/61bs738gUxESaqOLsauLwJW1pESMlR7Mqs29Q9Ssn?=
 =?us-ascii?Q?uAab80CAB9kudVrZW3ed5nBqIpFP4z5kSsiNaP/h49PsZFRmt1Wimt+QUGAo?=
 =?us-ascii?Q?7R5RcBnUnhsIFUrvmJ8U77XeKNZBNeKvUI/9s+Z1benRrxM42yt2zzt3ruzT?=
 =?us-ascii?Q?Ce6slUmCMl8HrupbtPeHkyTTj7tQTGakvypVUyMQmpk9gHQ2V+dumn2a9pgx?=
 =?us-ascii?Q?LUFJ1UePGU9bzQ1NNyf06krV3m3KYGBNcyhI6Dwwp1jTcGaXTG6dQ2Hk4ZhK?=
 =?us-ascii?Q?4L6jU1VsfjdRrkhvxHVPpYCeJw8A9GsAB7zK1x+61DqEuGjIs+WWclmjUyS7?=
 =?us-ascii?Q?1qQkp+TBuj3hNjl3n1ztL2xmIsn3Is+iU228KcXy8oKp/DKoyPKgNS8qsCz3?=
 =?us-ascii?Q?4/1DZx8NjajN6PR7HhvJvkHzgbpdHjWSpL8SnrjXtmsgV0SAw0V4Q7nDpG+H?=
 =?us-ascii?Q?yw1z/dqveihqvXGShDjXaXuT54TyqnbBnothBlo+cNac/INuU0i13s51hE5L?=
 =?us-ascii?Q?Q5yUTrpfUbIYgJgxQejk9Wjw4BQge77CjvFa3l16R1xWuApLfDohLubb3jsh?=
 =?us-ascii?Q?5JXTqr14OXW1ckHqlxDUdy0ClZcEytqQiiln12s6PktaChE8pOWmo0kUiIhK?=
 =?us-ascii?Q?LwNi9Uiy47Zi/WdPevTRE7nGVSGt0ommXy8UBDYNSof9dkqwigC6SNLh5F7O?=
 =?us-ascii?Q?DUa6ihaUh7ncif8JT3OhJSxBtY8RQFOgUsY3G2Md79bZ2ZtYVd0jmfvAfbGX?=
 =?us-ascii?Q?PDWf+iyw4ODfsJQjcaZBAABpNST+i7r02OhoONWJ36FzTkhjOR68UoxfYfZM?=
 =?us-ascii?Q?KR819/teM1O//COu5Vns9uUfza5ADBAR+O4IiMXLDopiwmtZjQggGBJgtxUs?=
 =?us-ascii?Q?D4y7XfzOIP0WBdWXAMOHbCmoiwnXaPoBB9jsPPqEa+tk/3P3egtxSIP/P2w7?=
 =?us-ascii?Q?ficJSiUAmuTClN2zab9dEmxSV5Zs6dWUuNdz1vzNiv9lPCRKZ3sPpKbqVKcS?=
 =?us-ascii?Q?/9YC+WENOt46SusHh5VX76CP5Cy7Of4rgT4jN7eF04YNwRtdKb2TlgJACFwJ?=
 =?us-ascii?Q?pPjb+NV9vaCv7GT3mYj4Jkr75PMT0vUPv1QyvQ/H11tvuBcFROf5V/j+BMy/?=
 =?us-ascii?Q?SFfeoje81w33IMfgSYCLJnwWJscpKXNS+/xXpQ/tSi5QtNUr0uZLkzgx1N2Y?=
 =?us-ascii?Q?aqCYOKGokAZfNyekPoL0T3QBmLPRXtaGsHoj3QtAaFV1FB8tRcsO3Maltkfz?=
 =?us-ascii?Q?UvGC5+raYhc43Ex9CnMErt+Ou3WxV91+kM7/7tso8Re22xqKt9GM14Hl4wQP?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c8c22f-2744-49b2-fd85-08de09c10ac2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 18:56:24.8251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygRSOJI7vSGlPOdT/vcFRBLdfNfG6Mlx2+Z6eRfHhhjIGV7v3Kk8N1qLw3JPiL0R1/h/X2lZYnQkvx+IKdoo7iMgZQVVv8kY9/OcossC2/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6973
X-Mailman-Approved-At: Mon, 13 Oct 2025 06:18:05 +0200
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

Add SPL_DWAPB_GPIO configuration option to enable the Designware APB
GPIO driver in SPL builds.

Changes:
- Add SPL_DWAPB_GPIO Kconfig option with SPL_DM_GPIO dependency
- Update Makefile to use CONFIG_$(XPL_)DWAPB_GPIO pattern for
  conditional compilation in both SPL and main U-Boot builds

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 drivers/gpio/Kconfig  | 8 ++++++++
 drivers/gpio/Makefile | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index db077e472a8..00bf974c0f3 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -138,6 +138,14 @@ config DWAPB_GPIO
 	help
 	  Support for the Designware APB GPIO driver.
 
+config SPL_DWAPB_GPIO
+	bool "DWAPB GPIO driver in SPL"
+	depends on SPL_DM_GPIO
+	help
+	  Support for the Designware APB GPIO driver in SPL.
+
+	  If unsure, say N.
+
 config AT91_GPIO
 	bool "AT91 PIO GPIO driver"
 	depends on ARCH_AT91
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 73c94329e36..da2c02b32da 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -4,12 +4,12 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
 ifndef CONFIG_XPL_BUILD
-obj-$(CONFIG_DWAPB_GPIO)	+= dwapb_gpio.o
 obj-$(CONFIG_AXP_GPIO)		+= axp_gpio.o
 obj-$(CONFIG_DM_74X164)		+= 74x164_gpio.o
 endif
 obj-$(CONFIG_$(PHASE_)DM_GPIO) += gpio-uclass.o
 
+obj-$(CONFIG_$(XPL_)DWAPB_GPIO)		+= dwapb_gpio.o
 obj-$(CONFIG_$(PHASE_)DM_PCA953X)	+= pca953x_gpio.o
 
 obj-$(CONFIG_ADI_GPIO)		+= gpio-adi-adsp.o
-- 
2.35.3

