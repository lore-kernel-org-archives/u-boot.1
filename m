Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88F9E6C5F5
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 03:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59C2289684;
	Tue,  3 Dec 2024 04:11:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACF7788E32; Tue,  3 Dec 2024 04:06:09 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2071a.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::71a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BA7D89612
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 04:06:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hz08EUX4YD9hlK61FBWmwrZ/eTjok2+m3pV5J2WW7O9RuD92r4prjbROiJadZaDDxhgKD+jKDLY5M1oJf2BF2zuA0hV7kVPjIznQasoAM4OMQsdGaXMsmSJR7MdHJZ/q1SpBYZU64uOkltKQN+66omGanYiMBBsnJJBgHFVy1BsebEr+9d6Aremz8LgWEuZmxXbgET45zEIs+RGFgc6DTPuo+bPH8svrGQvJ/O+5U78oDkMKg51fxn04ykgmhviGxks+9v39lxAUep64jmu92r1JMfSSgmIUoI2QV1mFAeX9Q80priYQA8YqhPeqgCW0HXKXE3CdkkPQKY8dSHXAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfTlD5yDg0zYGzBkVPFfhKsQq/RX7M38ybUeRG8Sp9E=;
 b=VaZ7wuiG2IQ9mux7ZNE5fsb4Ic/7s5B+9UMHwV1bc6kP4//Z+QkyDtBcy/Oz+QFvc5Qo3qLJ7ctQbOlCS/d8qvBYYaDlNkMsVcjdfXa/B3Z6egAT4H+UnXXHhUO8x1b4jaODxv5X7sABGkpL6gvhR1vSRaRZm93Bt30lCod11uaXURQz2X3ccNxilS5XKYnDKSyXoq2w+/GH5EV6uieyu6IwFpo52+xeo80oIyqtjYdKIRlfO1iNVXVV2JH/ciJCAkbo7/JETzxeOJJNHOf3mBS6N0Pg2br6AR51iaudi+P8nH7/RHz0STA6BcG74JutP5/e44GApptNNmP4SZBUbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1180.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Tue, 3 Dec
 2024 03:06:31 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8207.010; Tue, 3 Dec 2024
 03:06:31 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v7 12/12] riscv: cpu: jh7110: Sort the list of imply statements
Date: Tue,  3 Dec 2024 11:04:30 +0800
Message-ID: <20241203030430.26089-13-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241203030430.26089-1-hal.feng@starfivetech.com>
References: <20241203030430.26089-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0013.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::8) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1180:EE_
X-MS-Office365-Filtering-Correlation-Id: 9591c9b4-eb58-4e6e-9f49-08dd13477c7e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|366016|41320700013|921020|38350700014;
X-Microsoft-Antispam-Message-Info: CyUhmPa5rc6Ja2lOq+T/1c4OJuureYKUK0LGUxUg/kDCY00pMlsxA03HTZ9hWDLJlUiUYoGLARqp9s9hMwGyGKjqYdJCQQxQtzSDrbfq4OOTFJ2kS+SXVqVVt8j8p+Wnq4TB6NIHz+f/LQlFozyd/N6/m6mzFMudg2MsCCtjEj6O7sKgdjImVlXlmANOfuJEyL4M2zBCZeVF/07AW0eBCwH/CrOkivrMKCrRjEJhVYgBM2Upj3sodsXncprZEcGdY0M8vgVwfhSSix1vWHtyzngswihNyK3dclhNAWrFfRJ6kWRgwSKNczT9ViDrAXKY9Ay8rgTUVQyHIuCpnqtO/qQb7Nv0ZKz6T0pIZrLZnH1QDuHHrBumAWXP0UYmdzkIN/LCwuUQ/iyQ5/lp+XCajmBun6iY5fIAX3wUk/0vs864qLT1U028Ztg5TMJcfj5O8qQk6KKNNB/7NE0Npq5hA98CwQALDhRctL32l1fga+OOUU5xu7PQtfbLDaFAahMxelPMga9XWL5g7Y9hbk4oHEo3zZWiSkG7wD+8cUFkr1loS7zA24aEQdPOgiJiQbaoUhpIdrUm8cWFEk9efaZ7u/xvPpQSbNTJd0OC2h7JulURwtV2wQHP0rJEm7b6fqtx4hAlBcMl1rOFeEqUmwGwqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(41320700013)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UmsagcxE2QJJaqhLH+AEJYoKX/mHCDK69HHN9HYrKAZ4z/Z2DMj+xfOKwOUG?=
 =?us-ascii?Q?29nuQBNW1BsyFIia/hnID3Hgine3NPLl1YYd3CWyZH6cEt5o+l2pCtHLNG3e?=
 =?us-ascii?Q?BHLDcdTxcJeo9biTSAN0hmG/aTrsPYzh+ZggG6An5fms5SHyqnPRgw//6MQm?=
 =?us-ascii?Q?nD7IT2booiUENqbx8cSOeidmxOhnEUgSGodfloFwjpy/96wSUEEgb78bQCNj?=
 =?us-ascii?Q?/Sdyj9hH3JMXUvsuFh0J0sAsoZp9IcoeCcscFzKbD2M8TH2Vtv6G3Mme8V4V?=
 =?us-ascii?Q?GpgtQHobwyJJaas1YbJ49q/YsUnnQ0xS0fiH02OY6yz9gnxBJx2fs/MrAuJ9?=
 =?us-ascii?Q?5YR+moWLzBgsdHpezx2CwrNfK4fqEleI5VBWzvMZ+bYrBiFR43uWg4wkQvDb?=
 =?us-ascii?Q?zeWU7hYtHvSVN/d5GnH8urAQd16i9+2QGPHflC2QTKPWGZsbNXxTNPbPop2i?=
 =?us-ascii?Q?ySs2GFt7yYpKtw70RUass6gBTnRIBkuuiIlUmZR0H3IdwPYmsdqEYmjikR+F?=
 =?us-ascii?Q?xhVzQ6ou5BU5Xjk9LC06uc7iU1JGXQfqndplhbfvNjjBk+u/YBAKai3IVQVU?=
 =?us-ascii?Q?tbDVHuu3ZyVaMdENhAZd0k/q/Wc5GN9tugpjOPPiPVOByDpAcTv6MES375bT?=
 =?us-ascii?Q?jc5VLjkFNkge5huPeIxHxuwlmzeQtfsdZ3RevTs5HzVbWHPKaTk46wbcYR2r?=
 =?us-ascii?Q?z8Y7aVaEQwtVrv6lW0T0Uc6W7cxiWG73G4HW07bqP1/PHF80oja/eEIUuYXP?=
 =?us-ascii?Q?co0LEj2KjNjkhqP4NcRkrHdJ+c+oexFNh/vnozqMKVaP/5C4yQgW05792bfP?=
 =?us-ascii?Q?vU0g+aeal9u3a0NOA90hX6WQ99aYVdFz6e+aC5qCffPR/aeIRzm5EgbLLS0R?=
 =?us-ascii?Q?Dj23pSFu9bBsw/AqzearKllA3IpGY3yjUEFGOuAVAxvYTQgNUtPTdSsrjNi6?=
 =?us-ascii?Q?YgYelGx3gwsEk991cQU7ba7KnQrqSpQ2J0cd1h/xjk8G3pKB2FkDrXt5mteo?=
 =?us-ascii?Q?0IktBAB4uWUoI7VarwXLc+qNb8jHXlwtyH3vc4bTzxw+Ar+My8OEUelouo4/?=
 =?us-ascii?Q?5CRBg3oLzTZPTL98WSxtAsNLcohhpstHBU0sRcztIlWNhOkGk+rOWCM9jXz0?=
 =?us-ascii?Q?aKOXbKp245AbpdVzqVqKn5W/5vREcB+jt4pIcZ90NcQkLr7pn9enh4Wjxt0w?=
 =?us-ascii?Q?s5YHYU8a139VXXkmLJTL52SDUpUJyUiee/K+ETwXS0657SWlrqKLTWFyJ0UM?=
 =?us-ascii?Q?XvGxzniknl7k+WE0t9XwFysSRb6mNg9LsyOo2TcZaALrfbJ18xR46Tiiuje0?=
 =?us-ascii?Q?XhTLsmUIOTOe1NYQXUfpHdR7w19/+nGFcwgvs5sDfG0abRcHfBpT9/hsQT/0?=
 =?us-ascii?Q?nZXeIKw7OZLZO/HuMeyv9LlhkxyGQFoFkDW8Lp1/PHT5ZmuGqvSzugAD8dMM?=
 =?us-ascii?Q?8FU9Cr3IbFPVZsJt0ywiXG3yasrW9AVAt532+D8UhkfmTQE9vFqUMsjTGlx8?=
 =?us-ascii?Q?WwWOu/zEGfJCSFS2KGss5h49k6yLsKxd29vO6ciV47Gtqftanvozb0fYRmni?=
 =?us-ascii?Q?v8y8NahGdaujAyCySrucUXaCnxFbu6Favt7n2Zwo99rZwhOJTH+PcmCqAngk?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9591c9b4-eb58-4e6e-9f49-08dd13477c7e
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 03:06:30.9725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNiwY3vGM5BOpyQPz9B0GVpcEFpBNp4jIyPTUzCSCV8WSBNArg1+eMFm4AXbFkZ1aGMcGgc75jErWl0Ig7HP8YbgW1+oCK9HQhGc+pcQjgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1180
X-Mailman-Approved-At: Tue, 03 Dec 2024 04:11:50 +0100
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

The imply statements should be sorted in the sequence
of appearance in .config.

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: E Shattow <lucent@gmail.com>
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/cpu/jh7110/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/cpu/jh7110/Kconfig b/arch/riscv/cpu/jh7110/Kconfig
index 9904a60ddd..fa47e55226 100644
--- a/arch/riscv/cpu/jh7110/Kconfig
+++ b/arch/riscv/cpu/jh7110/Kconfig
@@ -16,17 +16,17 @@ config STARFIVE_JH7110
 	select SYS_CACHE_SHIFT_6
 	select SPL_ZERO_MEM_BEFORE_USE
 	select PINCTRL_STARFIVE_JH7110
+	imply SMP
+	imply SPL_RISCV_ACLINT
+	imply SIFIVE_CACHE
+	imply SPL_SYS_MALLOC_CLEAR_ON_INIT
+	imply SPL_LOAD_FIT
+	imply SPL_CPU
+	imply SPL_OPENSBI
+	imply OF_UPSTREAM
+	imply SIFIVE_CCACHE
 	imply MMC
 	imply MMC_BROKEN_CD
 	imply MMC_SPI
-	imply OF_UPSTREAM
-	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
-	imply SIFIVE_CACHE
-	imply SIFIVE_CCACHE
-	imply SMP
 	imply SPI
-	imply SPL_CPU
-	imply SPL_LOAD_FIT
-	imply SPL_OPENSBI
-	imply SPL_RISCV_ACLINT
-	imply SPL_SYS_MALLOC_CLEAR_ON_INIT
+	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
-- 
2.43.2

