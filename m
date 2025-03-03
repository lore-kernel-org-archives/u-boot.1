Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A36C282C5
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 03:53:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 584DE807B1;
	Mon,  3 Mar 2025 04:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oaX69GTP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9E5880F70; Mon,  3 Mar 2025 04:53:10 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4032780786
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 04:53:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1jewIiThjHWlLPm+G18CdpDI2xN+FIJdDDE2vreruyTZJd87wEuszNrYOzlRvXFJnnEsNpH93WzKJ6oerPqhaMi0Q9TsH16+icMKjcYXNSgV93bicVTQwlxITrdm0nGWO+WE8Zr7bLeimCsfwKp3y6fKxwxB90d+fypojfg/bZko4Ogb6uu6WGsEgnUhxnAJVc77W+CXogIRtE2zE9MzML8nlKs0MduiDaVfHb7Mb0se9S9PbGwEWyi5s6Ceoow0S3pTFbJkgfI4elpAUnCYL9fEFUmqS8+VLJ9XqKtgNSK5c59vSLymrwCsh1zkBYTyOTcfcLa2Q4t/mDUMhhVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdai1z5vKtTRmA4oZg3xqqkQJXRfHdj0qeevqQuJwZs=;
 b=Dsf0NzOIrROrH+4Z18fn3csMTbzG5RH70iogXtgAsgwO1uC9q0XgEkVUfBTtwv/8PYKNxJzRPoFrw6GwjoMQTEsWSOpPuou+8nyZTz0XTkb0vEQa/6evrdmh9ZS1U8SkZ4Z3YFSDkjUCpPZzSWygJLmDaMMYKzB3i6vjinQDP0p7n6b/db7k5KeytncW4tflJ1HpR7thbaXZKjRLi2epHj8dLVxUyY82ktLfrHb8FwUkGOMRjODVYZZiE60JhxDLFJCi5Q7YsGAVWqkVcv27owPemtAU1kXB6BsZCvLriiel7eHoIU/tyMQmnDSNUqgh+dHNt8NcqRd+8VRIke+pjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdai1z5vKtTRmA4oZg3xqqkQJXRfHdj0qeevqQuJwZs=;
 b=oaX69GTPzB1/5z0UAkQoP9ooGK2JV0bjv7uanKwfYTGgHfqPXsR4EShL5HnxMHzHfMOD1RTXlp4++2962gmvvYx4jXxIIOlZD87THUdejvRQWHUrxaruVvFgc1WyVYa0KRBpEXNunF9+c1xw3OS/WN6HKlHA1Xuzc0Pci/FoDiOO0wG0cqMdpoK1mGWVU4m4Ms0gEmsHs7Q1mHEwGcf9tCbe/gASrp0VcF3llhmqA2u0Fmc+ZCJamR1i4E7ooTGtKF01flwFjBxSivn64ZzMeNELbUiGETRWKttp+Zj18HGoNGFtILM49S1zDFJekGim4/HCfts1DOljv5hlJWvzBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7703.eurprd04.prod.outlook.com (2603:10a6:20b:23c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 03:53:05 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Mon, 3 Mar 2025
 03:53:05 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: trini@konsulko.com, sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, marex@denx.de
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, viorel.suman@nxp.com, ye.li@nxp.com
Subject: [PATCH v1] mailbox: add i.MX Messaging Unit (MU) driver
Date: Mon,  3 Mar 2025 11:52:31 +0800
Message-ID: <20250303035231.2680198-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0204.apcprd06.prod.outlook.com (2603:1096:4:1::36)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7703:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b0de54-5e31-4aba-3db0-08dd5a06e744
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qRrg5CgnjilxuhMdCZAh4YetlLrJm/9mE0sAQ80gYKFBdTjMyilCgzZX60rA?=
 =?us-ascii?Q?Mw7sqKMvh1qBI2tkJJVdISib2No65Wg0Ywe8Kzo0eGUPHLC8BZ4QTmcjlprF?=
 =?us-ascii?Q?PPyGgfQWCfZTNISSJfBQssJkwqiPLpQI5EK+Buac4NFwdvRoqRIMHYcQDBuj?=
 =?us-ascii?Q?ab440jgjwcPaVKi+I0yKbKtdo0lR90286JCez9E8bXQb2BumCKxrjLeloMo0?=
 =?us-ascii?Q?xZE4/QJdeJvG6OKpGD2v3hvJ1xBp4CyCTA+koIw5J7OT4YWPCUhuLvD47tLY?=
 =?us-ascii?Q?vLQyrEGVzxOMjDqssFf1Ax5IQSwRfJeH3RFVTDpFNCnHMWIINrp8p9OjRo0r?=
 =?us-ascii?Q?RG9gjg0dE1VYg9xdTRVTphs5qg5VQnJglAaMiNOsBgDamjXhDBB5QA06lWnr?=
 =?us-ascii?Q?BYpEyQ9ykDpnkhTtukx4iXZ2PFWHV1ESNwBqCIv7LbJQAtWHprsDq5rHIaWe?=
 =?us-ascii?Q?2PD5cmdzgiLu/JddGinkUbC8G43qv6lbG3P1Cq7Nssv7V5HFS7v0kVAvfGEd?=
 =?us-ascii?Q?VTA2N7RIoar1v5wDkzxrKaIWQ3ngBwtXnbrdQJA0C15i/dzSqWYJ70y53UtJ?=
 =?us-ascii?Q?bv6wKoh7VlM340AhC7LX+Ce+BAvpgApLwe6OOLQLSGQhMFJBglFxpl1F6L64?=
 =?us-ascii?Q?sJ+8HtxUxAl/ejku9uAh7xruFMEJb7hkvD/3V7ibn3GTMx1rYEGfdD9hJcSN?=
 =?us-ascii?Q?aeNPSRztT38sURFehXssb9JoGusvA3KmkkkFFmRIgEsNTQknfR6sOjIF7Iag?=
 =?us-ascii?Q?b/XNX9mcdxlATTGGySI+ZXpbjR4Wmi6PtKPxBGC/G9Q6Tu4hy1jWubWA1Wgj?=
 =?us-ascii?Q?rcnaZ3RmTARNXVHHOcXn+x7odXOTwlseUkjC7nDLWwLV2S8AjLWjOvGBone7?=
 =?us-ascii?Q?Kz836EDkT+g+qkPhpYCqrRAepEvjfoEGzlR3VXhrSkE2a/XCKfwg9L+r1ar9?=
 =?us-ascii?Q?r4Z72eDGYi3T5cB6bjyMBZz/wOvlMS2OC3RnZjSOcdApBH+7uMTnrbVDJNxt?=
 =?us-ascii?Q?QkSYlJyychPiPDAfTzFAwDn8funwFkqvAUzL2TZ1N3jAohKNftNlNcTB2ojg?=
 =?us-ascii?Q?M+0wlWDmk5kumPpV2w+tIdbMu7ADbsmRXmPAgI9pQWKqIKAV6NT6Db0MbI6A?=
 =?us-ascii?Q?hZHISijJrAQ6ql2F8jEFaNvOiuUqs8E/XW1LdYs2sQjs1TK0ZzPuAh2inKow?=
 =?us-ascii?Q?63YXlKoyIy+c53PzJfOskg9mov0I7WyZa7AH2FXHzl8Pjhbs41pFS28Nt2Os?=
 =?us-ascii?Q?ROu2VIjOyNYPOJN8IWFFdIhaj6B24XV7881mT/ONhP7fNcQWgFcuMGJZMhyG?=
 =?us-ascii?Q?4s9VqzdAFSOgaoYepi5KP6+7SNJpRY+e9By7PVxGvCc4h+eE9SCWgofEmE+R?=
 =?us-ascii?Q?o0B10tGm+Lq1S9jUAn9GWwas6u6lJB/r9+WEJKdudQ09RSO9xpr6AkBjwp8y?=
 =?us-ascii?Q?Lf2vEu7zxn/Sz29o2DI1FmCDX73I1C3g?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?69Ln1lQjMziaJ9HZs12pYO9naApJV/4dRaLUrmf7GQpx5t3hcsV6QGyec/Gd?=
 =?us-ascii?Q?uN7ODlnDNqYHPSvxqpbCDZndeKWsoWIkdgQUux1DL7V7OPw4cAjTimWWe0eV?=
 =?us-ascii?Q?bU8F8OKEDqaOSP89upNaHxEKCWSFSfnFAJlyMMGPhqXXryFjTGM8sSmPuaFm?=
 =?us-ascii?Q?fmnHTQ0nF9zeVAChMOYsTPMdEY2drHJJuf25RHXPGnum3Zi0yiQ4dpSPcJYV?=
 =?us-ascii?Q?bAxQfyz6KFkYq2+rLC+e4r2QpTPFk3nQ5L41X0n0LHgzWiH/FDkXgVs7Anvs?=
 =?us-ascii?Q?KpEX7oghJlYrKdNKyGr0C/ME50LWC2GefsmwQ2i11ybHFI4dpPOD4lRbkEeZ?=
 =?us-ascii?Q?8/0QQzajDDf+78xRfV5XLgmPX1Gdf4UYZn+nWikbXCg2UY/3Avq7SnnOAMMw?=
 =?us-ascii?Q?TXwerUzwNXayI+NHXCjWofuPFklFoSSss5qNkGYVOceY6h1jRt3vECPW7uWb?=
 =?us-ascii?Q?C2ieRijX8rLp1bbY5XKj2PbxMupSkM72fg35p/Ws5Gcd9k8gwMwret6/JcuK?=
 =?us-ascii?Q?04HTRRr5GKPnLTAB/94nSze9cE+9PfhL8UwKSHTJrBTNj4qU34kTLR20Pky1?=
 =?us-ascii?Q?WZfQCvx/M6qkI+ITIjRg5stUqrD/nn4fl2DBtTdzSUJ1yzkhczutdKFH/qK7?=
 =?us-ascii?Q?zy3c3JLlJ+luYT0/wGz+WfJ07HXuGDQ5SR4g5ipn2pVUuDBakNANU1P/XzI+?=
 =?us-ascii?Q?LZyhcczipbbrHBLkP4mYGQnd9uwuTg9PAnOs2d5CuEPMLl78U12daoZkcgxu?=
 =?us-ascii?Q?M++Ocvpu0XNPcMCWYXEctnnjsvRvQmJ9dFBej51KtHJtUJa7SrKpmE6aIxOA?=
 =?us-ascii?Q?d4qTUB7LMbw2qvMLmF02rxfeaB0jbqTMnu3p7pqRHPU32Ci8MvT1wbrl27z2?=
 =?us-ascii?Q?MoLv7aF+JX606WopNwkPT+7qzPRdln2O2RFH8KpWthmqMSrJXF2tyi7AsP1z?=
 =?us-ascii?Q?9bf/sSd96q39rN7pIQjbJSu5HQ0MLErmV8Qd9EiuYiH3fuDjAKn2eHr41ufI?=
 =?us-ascii?Q?9jtxpCk9/Uf2RhY92KrTpCGq0lHd6fhltBBi9xZGlCYjK4317fzx0dLuzfaA?=
 =?us-ascii?Q?WIMmLsmXpCoeFiRuh+RVqE9kd221VJRdvhv1MLQPZ1R1930In5hqUB0hGzHQ?=
 =?us-ascii?Q?5Cdt0RlAC7n0MfDdCuYKR9hhwSmQeF3N82fJvPH3vMTFozZS9BHOPw8ZT8wA?=
 =?us-ascii?Q?DC//54ui9TaVVhNuKu37AZ2RI0Lpm4WmLdeQR5BgG973eNMbgyZPKMetTny8?=
 =?us-ascii?Q?Ui4nKjJ5zCEN32OKPGNKcLVGHOSdJHc+uQjHg+6XohDlw7UnLoDw/QAxLSqD?=
 =?us-ascii?Q?5JUUgEFiAzMvPj5gaZ0UNkQKHxvunT9SFeTqdMN4nEUOVdo9E14JnDKulIVa?=
 =?us-ascii?Q?4N3O3ZhdTuaXKsXb+HV12D/uva9bs3Sr06akReTNbhs0v+WAtqVRf1he8qRJ?=
 =?us-ascii?Q?jR1VbZH4yp1s8ts81rLT5Evsz46FpWX8//Ug3g6cNu9vaDqNLAAertySI5yl?=
 =?us-ascii?Q?gRrwqGARKARpUwc7Hhl8pkZ/TRgtET775brLTFlML5cJKTKPM+q4rRNi9CyK?=
 =?us-ascii?Q?Q0dfz/sKKwVyFkV7rali8mS0ERxDFxSgf2PPdMAu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b0de54-5e31-4aba-3db0-08dd5a06e744
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 03:53:05.6857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WiY13OHaJxmUKOQ7Qu3jsWXDpgA6hKFeucPiWKLVV2PEZood03KTS6gIiiXh2v3iNc5J/YCgVGipCa4CNe2aVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7703
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

From: Peng Fan <peng.fan@nxp.com>

This patch provides a driver for i.MX Messaging Unit (MU) using the
commom mailbox framework.

This is ported from Linux (v6.12.8) driver
drivers/mailbox/imx-mailbox.c. Its commit SHA is:
39d7d6177f0c ("mailbox: imx: use device name in interrupt name")

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---

Changes for v1:
 - separate this patch from the patch set "add i.MX95 support"
 - add support for i.MX7ULP and i.MX8ULP

 MAINTAINERS                   |   1 +
 drivers/mailbox/Kconfig       |   7 +
 drivers/mailbox/Makefile      |   1 +
 drivers/mailbox/imx-mailbox.c | 456 ++++++++++++++++++++++++++++++++++
 4 files changed, 465 insertions(+)
 create mode 100644 drivers/mailbox/imx-mailbox.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 687262b355..f13629bc87 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -315,6 +315,7 @@ F:	board/freescale/*mx*/
 F:	board/freescale/common/
 F:	common/spl/spl_imx_container.c
 F:	doc/imx/
+F:	drivers/mailbox/imx-mailbox.c
 F:	drivers/serial/serial_mxc.c
 F:	include/imx_container.h
 
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 67d5ac1a74..4d9f004eba 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -21,6 +21,13 @@ config APPLE_MBOX
 	  such as the System Management Controller (SMC) and NVMe and this
 	  driver is required to get that functionality up and running.
 
+config IMX_MU_MBOX
+	bool "Enable i.MX MU MBOX support"
+	depends on DM_MAILBOX
+	help
+	  Enable support for i.MX Messaging Unit for communication with other
+	  processors on the SoC using mailbox interface
+
 config SANDBOX_MBOX
 	bool "Enable the sandbox mailbox test driver"
 	depends on DM_MAILBOX && SANDBOX
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 6072fa1956..574add6000 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_$(XPL_)DM_MAILBOX) += mailbox-uclass.o
 obj-$(CONFIG_APPLE_MBOX) += apple-mbox.o
+obj-$(CONFIG_IMX_MU_MBOX) += imx-mailbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox-test.o
 obj-$(CONFIG_STM32_IPCC) += stm32-ipcc.o
diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
new file mode 100644
index 0000000000..e774cbb1dc
--- /dev/null
+++ b/drivers/mailbox/imx-mailbox.c
@@ -0,0 +1,456 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <mailbox-uclass.h>
+#include <linux/bitfield.h>
+#include <linux/bug.h>
+#include <linux/iopoll.h>
+#include <linux/compat.h>
+
+/* This driver only exposes the status bits to keep with the
+ * polling methodology of u-boot.
+ */
+DECLARE_GLOBAL_DATA_PTR;
+
+#define IMX_MU_CHANS		24
+
+#define IMX_MU_V2_PAR_OFF	0x4
+#define IMX_MU_V2_TR_MASK	GENMASK(7, 0)
+#define IMX_MU_V2_RR_MASK	GENMASK(15, 8)
+
+enum imx_mu_chan_type {
+	IMX_MU_TYPE_TX          = 0, /* Tx */
+	IMX_MU_TYPE_RX          = 1, /* Rx */
+	IMX_MU_TYPE_TXDB        = 2, /* Tx doorbell */
+	IMX_MU_TYPE_RXDB        = 3, /* Rx doorbell */
+	IMX_MU_TYPE_RST         = 4, /* Reset */
+	IMX_MU_TYPE_TXDB_V2     = 5, /* Tx doorbell with S/W ACK */
+};
+
+enum imx_mu_xcr {
+	IMX_MU_CR,
+	IMX_MU_GIER,
+	IMX_MU_GCR,
+	IMX_MU_TCR,
+	IMX_MU_RCR,
+	IMX_MU_xCR_MAX,
+};
+
+enum imx_mu_xsr {
+	IMX_MU_SR,
+	IMX_MU_GSR,
+	IMX_MU_TSR,
+	IMX_MU_RSR,
+	IMX_MU_xSR_MAX,
+};
+
+struct imx_mu_con_priv {
+	unsigned int		idx;
+	enum imx_mu_chan_type	type;
+	struct mbox_chan	*chan;
+};
+
+enum imx_mu_type {
+	IMX_MU_V1,
+	IMX_MU_V2 = BIT(1),
+	IMX_MU_V2_S4 = BIT(15),
+	IMX_MU_V2_IRQ = BIT(16),
+};
+
+struct imx_mu {
+	void __iomem *base;
+	const struct imx_mu_dcfg *dcfg;
+	u32 num_tr;
+	u32 num_rr;
+	/* use pointers to channel as a way to reserve channels */
+	struct mbox_chan *channels[IMX_MU_CHANS];
+	struct imx_mu_con_priv  con_priv[IMX_MU_CHANS];
+};
+
+struct imx_mu_dcfg {
+	int (*tx)(struct imx_mu *plat, struct imx_mu_con_priv *cp, const void *data);
+	int (*rx)(struct imx_mu *plat, struct imx_mu_con_priv *cp);
+	int (*rxdb)(struct imx_mu *plat, struct imx_mu_con_priv *cp);
+	int (*init)(struct imx_mu *plat);
+	int (*of_xlate)(struct mbox_chan *chan, struct ofnode_phandle_args *args);
+	enum imx_mu_type type;
+	u32	xTR;			/* Transmit Register0 */
+	u32	xRR;			/* Receive Register0 */
+	u32	xSR[IMX_MU_xSR_MAX];	/* Status Registers */
+	u32	xCR[IMX_MU_xCR_MAX];	/* Control Registers */
+};
+
+#define IMX_MU_xSR_GIPn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
+#define IMX_MU_xSR_RFn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
+#define IMX_MU_xSR_TEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
+
+/* General Purpose Interrupt Enable */
+#define IMX_MU_xCR_GIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
+/* Receive Interrupt Enable */
+#define IMX_MU_xCR_RIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
+/* Transmit Interrupt Enable */
+#define IMX_MU_xCR_TIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
+/* General Purpose Interrupt Request */
+#define IMX_MU_xCR_GIRn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(16 + (3 - (x))))
+/* MU reset */
+#define IMX_MU_xCR_RST(type)	(type & IMX_MU_V2 ? BIT(0) : BIT(5))
+#define IMX_MU_xSR_RST(type)	(type & IMX_MU_V2 ? BIT(0) : BIT(7))
+
+static void imx_mu_write(struct imx_mu *plat, u32 val, u32 offs)
+{
+	iowrite32(val, plat->base + offs);
+}
+
+static u32 imx_mu_read(struct imx_mu *plat, u32 offs)
+{
+	return ioread32(plat->base + offs);
+}
+
+static u32 imx_mu_xcr_rmw(struct imx_mu *plat, enum imx_mu_xcr type, u32 set, u32 clr)
+{
+	u32 val;
+
+	val = imx_mu_read(plat, plat->dcfg->xCR[type]);
+	val &= ~clr;
+	val |= set;
+	imx_mu_write(plat, val, plat->dcfg->xCR[type]);
+
+	return val;
+}
+
+/* check that the channel is open or owned by caller */
+static int imx_mu_check_channel(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+
+	if (plat->channels[chan->id]) {
+		/* if reserved check that caller owns */
+		if (plat->channels[chan->id] == chan)
+			return 1; /* caller owns the channel */
+
+		return -EACCES;
+	}
+
+	return 0; /* channel empty */
+}
+
+static int imx_mu_chan_request(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp;
+	enum imx_mu_chan_type type;
+	int idx;
+
+	type = chan->id / 4;
+	idx = chan->id % 4;
+
+	if (imx_mu_check_channel(chan) < 0) /* check if channel already in use */
+		return -EPERM;
+
+	plat->channels[chan->id] = chan;
+	chan->con_priv = kcalloc(1, sizeof(struct imx_mu_con_priv), 0);
+	if (!chan->con_priv)
+		return -ENOMEM;
+	cp = chan->con_priv;
+	cp->idx = idx;
+	cp->type = type;
+	cp->chan = chan;
+
+	switch (type) {
+	case IMX_MU_TYPE_RX:
+		imx_mu_xcr_rmw(plat, IMX_MU_RCR, IMX_MU_xCR_RIEn(plat->dcfg->type, idx), 0);
+		break;
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_TXDB:
+	case IMX_MU_TYPE_RXDB:
+		imx_mu_xcr_rmw(plat, IMX_MU_GIER, IMX_MU_xCR_GIEn(plat->dcfg->type, idx), 0);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int imx_mu_chan_free(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+
+	if (imx_mu_check_channel(chan) <= 0) /* check that the channel is also not empty */
+		return -EINVAL;
+
+	/* if you own channel and  channel is NOT empty */
+	plat->channels[chan->id] = NULL;
+	switch (cp->type) {
+	case IMX_MU_TYPE_TX:
+		imx_mu_xcr_rmw(plat, IMX_MU_TCR, 0, IMX_MU_xCR_TIEn(plat->dcfg->type, cp->idx));
+		break;
+	case IMX_MU_TYPE_RX:
+		imx_mu_xcr_rmw(plat, IMX_MU_RCR, 0, IMX_MU_xCR_RIEn(plat->dcfg->type, cp->idx));
+		break;
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_TXDB:
+	case IMX_MU_TYPE_RXDB:
+		imx_mu_xcr_rmw(plat, IMX_MU_GIER, 0, IMX_MU_xCR_GIEn(plat->dcfg->type, cp->idx));
+		break;
+	default:
+		break;
+	}
+
+	kfree(cp);
+
+	return 0;
+}
+
+static int imx_mu_send(struct mbox_chan *chan, const void *data)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+
+	if (imx_mu_check_channel(chan) < 1) /* return if channel isn't owned */
+		return -EPERM;
+
+	return plat->dcfg->tx(plat, cp, data);
+}
+
+static int imx_mu_recv(struct mbox_chan *chan, void *data)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+	u32 ctrl, val;
+
+	if (imx_mu_check_channel(chan) < 1) /* return if channel isn't owned */
+		return -EPERM;
+
+	switch (cp->type) {
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_RXDB:
+		/* check if GSR[GIRn] bit is set */
+		if (readx_poll_timeout(ioread32, plat->base + plat->dcfg->xSR[IMX_MU_GSR],
+			val, val & BIT(cp->idx), 1000000) < 0)
+			return -EBUSY;
+
+		ctrl = imx_mu_read(plat, plat->dcfg->xCR[IMX_MU_GIER]);
+		val = imx_mu_read(plat, plat->dcfg->xSR[IMX_MU_GSR]);
+		val &= IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx) &
+			(ctrl & IMX_MU_xCR_GIEn(plat->dcfg->type, cp->idx));
+		break;
+	default:
+		dev_warn(chan->dev, "Unhandled channel type %d\n", cp->type);
+		return -EOPNOTSUPP;
+	};
+
+	if (val == IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx))
+		plat->dcfg->rxdb(plat, cp);
+
+	return 0;
+}
+
+static int imx_mu_of_to_plat(struct udevice *dev)
+{
+	struct imx_mu *plat = dev_get_plat(dev);
+	fdt_addr_t addr;
+
+	addr = dev_read_addr(dev);
+	if (addr == FDT_ADDR_T_NONE)
+		return -ENODEV;
+
+	plat->base = (struct mu_type *)addr;
+
+	return 0;
+}
+
+static int imx_mu_init_generic(struct imx_mu *plat)
+{
+	unsigned int i;
+	unsigned int val;
+
+	if (plat->num_rr > 4 || plat->num_tr > 4) {
+		WARN_ONCE(true, "%s not support TR/RR larger than 4\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	/* Set default MU configuration */
+	for (i = 0; i < IMX_MU_xCR_MAX; i++)
+		imx_mu_write(plat, 0, plat->dcfg->xCR[i]);
+
+	/* Clear any pending GIP */
+	val = imx_mu_read(plat, plat->dcfg->xSR[IMX_MU_GSR]);
+	imx_mu_write(plat, val, plat->dcfg->xSR[IMX_MU_GSR]);
+
+	/* Clear any pending RSR */
+	for (i = 0; i < plat->num_rr; i++)
+		imx_mu_read(plat, plat->dcfg->xRR + i * 4);
+
+	return 0;
+}
+
+static int imx_mu_generic_of_xlate(struct mbox_chan *chan, struct ofnode_phandle_args *args)
+{
+	enum imx_mu_chan_type type;
+	int idx, cid;
+
+	if (args->args_count != 2) {
+		dev_err(chan->dev, "Invalid argument count %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	type = args->args[0]; /* channel type */
+	idx = args->args[1]; /* index */
+
+	cid = type * 4 + idx;
+	if (cid >= IMX_MU_CHANS) {
+		dev_err(chan->dev, "Not supported channel number: %d. (type: %d, idx: %d)\n",
+			cid, type, idx);
+		return -EINVAL;
+	}
+
+	chan->id = cid;
+
+	return 0;
+}
+
+static int imx_mu_generic_tx(struct imx_mu *plat, struct imx_mu_con_priv *cp,
+			     const void *data)
+{
+	switch (cp->type) {
+	case IMX_MU_TYPE_TXDB_V2:
+		imx_mu_xcr_rmw(plat, IMX_MU_GCR, IMX_MU_xCR_GIRn(plat->dcfg->type, cp->idx), 0);
+		break;
+	default:
+		dev_warn(cp->chan->dev, "Send data on wrong channel type: %d\n", cp->type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int imx_mu_generic_rxdb(struct imx_mu *plat, struct imx_mu_con_priv *cp)
+{
+	imx_mu_write(plat, IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx),
+		     plat->dcfg->xSR[IMX_MU_GSR]);
+
+	return 0;
+}
+
+static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
+	.tx	= imx_mu_generic_tx,
+	.rxdb	= imx_mu_generic_rxdb,
+	.init	= imx_mu_init_generic,
+	.of_xlate = imx_mu_generic_of_xlate,
+	.type	= IMX_MU_V1,
+	.xTR	= 0x0,
+	.xRR	= 0x10,
+	.xSR	= {0x20, 0x20, 0x20, 0x20},
+	.xCR	= {0x24, 0x24, 0x24, 0x24, 0x24},
+};
+
+static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
+	.tx	= imx_mu_generic_tx,
+	.rxdb	= imx_mu_generic_rxdb,
+	.init	= imx_mu_init_generic,
+	.of_xlate = imx_mu_generic_of_xlate,
+	.type	= IMX_MU_V1,
+	.xTR	= 0x20,
+	.xRR	= 0x40,
+	.xSR	= {0x60, 0x60, 0x60, 0x60},
+	.xCR	= {0x64, 0x64, 0x64, 0x64, 0x64},
+};
+
+static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp = {
+	.tx	= imx_mu_generic_tx,
+	.rxdb	= imx_mu_generic_rxdb,
+	.init	= imx_mu_init_generic,
+	.of_xlate = imx_mu_generic_of_xlate,
+	.type	= IMX_MU_V2,
+	.xTR	= 0x200,
+	.xRR	= 0x280,
+	.xSR	= {0xC, 0x118, 0x124, 0x12C},
+	.xCR	= {0x8, 0x110, 0x114, 0x120, 0x128},
+};
+
+static const struct imx_mu_dcfg imx_mu_cfg_imx95 = {
+	.tx	= imx_mu_generic_tx,
+	.rxdb	= imx_mu_generic_rxdb,
+	.init	= imx_mu_init_generic,
+	.of_xlate = imx_mu_generic_of_xlate,
+	.type	= IMX_MU_V2,
+	.xTR	= 0x200,
+	.xRR	= 0x280,
+	.xSR	= {0xC, 0x118, 0x124, 0x12C},
+	.xCR	= {0x8, 0x110, 0x114, 0x120, 0x128},
+};
+
+static const struct udevice_id ids[] = {
+	{ .compatible = "fsl,imx6sx-mu", .data = (ulong)&imx_mu_cfg_imx6sx },
+	{ .compatible = "fsl,imx7ulp-mu", .data = (ulong)&imx_mu_cfg_imx7ulp },
+	{ .compatible = "fsl,imx8ulp-mu", .data = (ulong)&imx_mu_cfg_imx8ulp },
+	{ .compatible = "fsl,imx95-mu", .data = (ulong)&imx_mu_cfg_imx95 },
+	{ }
+};
+
+int imx_mu_of_xlate(struct mbox_chan *chan, struct ofnode_phandle_args *args)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+
+	return plat->dcfg->of_xlate(chan, args);
+}
+
+struct mbox_ops imx_mu_ops = {
+	.of_xlate = imx_mu_of_xlate,
+	.request  = imx_mu_chan_request,
+	.rfree    = imx_mu_chan_free,
+	.send     = imx_mu_send,
+	.recv     = imx_mu_recv,
+};
+
+static void imx_mu_get_tr_rr(struct imx_mu *plat)
+{
+	u32 val;
+
+	if (plat->dcfg->type & IMX_MU_V2) {
+		val = imx_mu_read(plat, IMX_MU_V2_PAR_OFF);
+		plat->num_tr = FIELD_GET(IMX_MU_V2_TR_MASK, val);
+		plat->num_rr = FIELD_GET(IMX_MU_V2_RR_MASK, val);
+	} else {
+		plat->num_tr = 4;
+		plat->num_rr = 4;
+	}
+}
+
+static int imx_mu_probe(struct udevice *dev)
+{
+	struct imx_mu *plat = dev_get_plat(dev);
+	int ret;
+
+	debug("%s(dev=%p)\n", __func__, dev);
+
+	plat->dcfg = (void *)dev_get_driver_data(dev);
+
+	imx_mu_get_tr_rr(plat);
+
+	ret = plat->dcfg->init(plat);
+	if (ret) {
+		dev_err(dev, "Failed to init MU\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+U_BOOT_DRIVER(imx_mu) = {
+	.name = "imx-mu",
+	.id = UCLASS_MAILBOX,
+	.of_match = ids,
+	.of_to_plat = imx_mu_of_to_plat,
+	.plat_auto = sizeof(struct imx_mu),
+	.probe = imx_mu_probe,
+	.ops = &imx_mu_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.43.0

