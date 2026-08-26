Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29290C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:42:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1662607A0;
	Wed, 26 Aug 2026 13:42:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Umlr3zEtXHmE; Wed, 26 Aug 2026 13:42:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787751765;
	bh=vQNcWZx+ayuj1nkQwk6yGePYTSDGFZGUOxIF+QfJaXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IgbJNLDMOTHCZiPDvceOy5kz5dN47MC+FOk6vSzyEu9DzMdhGEUd2rSdu871eSOdS
	 9kpWGla954BcrA0In6neRzKZkZAYd5CcrZVt7WzNv2kECwFYP0BDXeTrH472pKCrCI
	 0duEzx9CzDUQXx3d48SOcxpdXD9XA9fNn+IumtuxncjFmvssX8loXx58+8uzRuknSi
	 8HWUFVykJHSbUTtYmBQTGHQxx9Fy+am5IvcK7ml9MgXZl8D3rd5ws/+rlwz10VGA08
	 510EEqaggjQBC8MAZHhNMlmJdQyGLM3sQ2eRtXSebkex8gAs+k3eq3XWBt1MZ0lXOA
	 a/ceLY8P/AdIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 68D2560763;
	Wed, 26 Aug 2026 13:42:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DBE343C3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:35:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CE24440115
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:35:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9A-JDsPFuMpw for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:35:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=34.2.90.19;
 helo=sonic.asd.mail.yahoo.com; envelope-from=maskachoska@yahoo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com
 header.a=rsa-sha256 header.s=s2048 header.b=ovVIQ5Gd
Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com
 [34.2.90.19]) by smtp2.osuosl.org (Postfix) with ESMTPS id 699C84005F
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787751312; bh=vQNcWZx+ayuj1nkQwk6yGePYTSDGFZGUOxIF+QfJaXE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=ovVIQ5Gd3vPXf1nV1tgUnfcFHxxdSeBjjIkByWacN1H9fh434tCaNsGByViaD8GnIGEiGMKJLnv1QuGFBiriM/+tnNCRO+eEFRKLpCbfT02SnE8irGnaEYeKHc4FRRB+aw8yzI1j1Kq7t91q/kRBxwI4HiMMc32Ss/EzlTSvQ6qprDu5ZgUykhxD/fo9hMNQOvB6OHcoDYOoK3nM0Ruab3IX0smoUZKuAhpP+HZ7JTjce/Puiul1JNXoZDk87WLHLCKYYOYetE8fYZDhsOAveoO9rYlCtd3AoEthDVOS2M7TuEB3vU/ELQDGdEsgQJekGgsUuwQaGk5RdNZsEO8F+A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787751312; bh=l/vqKRFbF3VEEygeX9UIM3m+HVYA3Kx69oFdVuc80c6=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=oxOiEWQ0lljEjFlC9KD63Y9fuYketqMXQUdJTc0mcxeusCD1fl/tK3SooTkPxf8wwPuU1Lw4FHJMbMcH/MO9WIoBm98G1BUX4og43KG8sHUkcJxnYgMleyecw1ULPOg3RK4tDtKrtqi1KR0U+fqTfATa+CpW4XU1Rn32De6Vq4tzvk+ycCEXOaru1EPjGBZmGGbWGgGnOB7BRiDfDiKfkYWyEXQzYO0zM5QiWA4DELrcHqkrfHHF6T0RD7bmfXrpEWqTs+JvD8uXGZRSo3KLljZQe0TM9pZtqrQ2TCFWSIPjUn2M2tAATgfOSwbqfHEh6CeRTqOU6lnA5J97NuA0+w==
X-YMail-OSG: 8znNx70VM1no1wGdJWrY7HMuLCIIJ4ek6ERLi1HA2hIXeetiSht0AIgvFrrI5ox
 DchvzbtSPkth_WGEXunJ96Vm_68ujBfoZzNzrGsIulW3Qy8GCukeZ6H.FjYTM4uJT65VRjaWjiGL
 HRIowHNYVKfd5qgttrK8GHAh_JLZXm49_8whgOQpkbcsxP3V6jeAgfO0GW8N7jQurwR5ip44isPW
 GA3jOlT8LuUX.LTpJXZ9L0ynlkRQvFBUEjJFA1jBe7qW.LX3Lk1tp9PNrydLKcok7ArML_fpz.eB
 FghiHObL.2tX6I4O_dCK.5t7opcXHXkaF4zEMGNNpEM4MLb5AC2nSyNO9xN1mzDFqqOdDYRq3Nk3
 Dyufgp5C3Z.q1VAxHXhjP1RfgRlKjCOrOSLgfSA4MSTytkcWb2ylPWuh095U8NUNgKo6G7fx6fo_
 6lELG6hrasprT1noRcfPel8YUsjqHga9am6VDOuLlzgirEhghTqm3MPySU_QZMUBgWOxeggQN.5W
 h6qqawwWfbnnp6vF9r7NIy5DuqXkW6E6FCSQLoUa3Co0KWsFZCbsTXMY8OrX3MIQ5S0Ni_ugr5WV
 FrBSpTVwJeEIM.iR1XYAQPxRrI9iMoyyp8TziBq1UYydpzFKPtQiv0qtS.eHv.r7e_qUDms5fAwI
 uFzsSLPXl8i2TqAOXYu9bF8ZrMRAvx6gFf7zLvnAsoivZZQ2Wbmo6AXEWtx6tp64th0Db5eA6qoj
 OYu11sFdh9ajV7G5X6jNB5mM4gNoM.CeXFcFsS.yyhG3gIc8yjBJ5WtRMRlF6DejxudQnUPdzkRy
 CJAQiVDZTP4lwctdboVYILWoZH71OgEc0YdjB81PNYM32xZLYcxGnjfZDsQWYIQH2WI6.hol7cwH
 YOgElJmBkdAVuoWBV2Uevd9NWKW5_pTGaOVggABThh_Egt8umrJZNlfhOOoeohLtasYQMOaIQQfT
 kWWoQCh97GGmH1MX_0gqhUK9afpfGsPgDh18LXrBZIhkLxfK4xBvvp6uB1hIseL_zAU6hB1JHjp8
 0S5q_keTKDlFUmaoIPN5zY_XImeHB7SRBu0.QQJsM0Iip1N1Qd70EzwXnjRcjZFt6L.cKyj6Rsx_
 GqLpM8Zu8KUZiv8qGY3BaFxdcIvHJKUVddBowBNrFTZBBDXX6m.jD8_IaAvqcej.t.3bRXHkoxgt
 Obwz0d.DBzljvh.QASuSrs8klvH2.WOdY_fMNza8TOKrMHzIBksqCsjotOlmtNlHc5GDbWD50u_y
 _ll05aW.XHOn.6rxqd597U6B1ZK3y4ewsX78uALOTpOtRaE4YEzBc0iAJEfJG_Zv63v6bDef9E4a
 u1CBCebisJtgZycX5oQ30QoaOep9q2b6Y2z11mTPOCkpQdM0oBgsw9tFPaPXoB2JLdr.JWMVhz5s
 LPT9piDxI3NCSkEzLRBiLeXg1eG8skPntNZWwL0Yy58bjBbeZRhntRhF72jjdNJiI8G00cPKH_ks
 zySHpT6Psf63GjVcCFzFl2Q0iIPuqTpsbuBNFRLMvHvSq.0GAA7LtUBm5iUwloZC8iiK5NjpgQA.
 PxHS6aZt5tTXnf1pCFceO8Xr8JXIFjFgALKGwenTwt4lbemkEtNK0Ynk.40LuKX5VIp9yTk_rFsy
 BuRs2Lm7icq0HOs1JVQtSoHLpAtcZjkQytJVu4sLQK8NGZp4_UCQ7gDU79g6Qj20ONBWbZL57o.X
 yNWXt7SKUy0hHpKb.aU_Iv4XJN12G7IwPka.d5bpz41cPadiInEdiXIv3SukvWm9C2QekU3vEm8E
 ntIB2SsRYmuYZAfPTS_ldcCrRN_FoEyWA_N8638QCu5IwLyttP7NucnuC_vJL6dV73OXxu73fXnO
 ihlHeY0pgcKsdXaY3EAmDJGvIgwW.epNHCYJQ_Jk_sYC.6d8FJSiTuwP7YnNxIX7ZAMAtJYWk2SJ
 Q_tLFq9RBKafx2Xi8MdHh1JnkoUoeUPBiXlkP4StgtYcg6cDDyKSpxkNjZxXll482.AtTbDyRkDu
 zOj8szyp.wojP02yfjqU976m5sqMDdeQ93BHqWiNpR.ih8u_Z8NE83r825ugNnMqerACLOLhCkTP
 WqA--
X-Sonic-MF: <maskachoska@yahoo.com>
X-Sonic-ID: e8454780-40ea-4796-b741-234910146828
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-101 with HTTP;
 Wed, 26 Aug 2026 13:35:12 +0000
Received: from dip100.lsn.sg3.yahoo.com ([106.10.223.109])
 by hello (SMTP) with SMTP ID acc4f7a299298e219e9ccf723c2619d7;
 Wed, 26 Aug 2026 13:35:07 +0000 (UTC)
From: AK Sharma <maskachoska@yahoo.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 AK Sharma <maskachoska@yahoo.com>
Subject: [PATCH v2 8/9] board: econet: add EN7528 board support
Date: Wed, 26 Aug 2026 19:04:42 +0530
Message-ID: <e58fd82b5a212c7630bf7046e76283e4d2ec9164.1787736704.git.maskachoska@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787736704.git.maskachoska@yahoo.com>
References: <20260825222211.712836-1-maskachoska@yahoo.com>
 <cover.1787736704.git.maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Aug 2026 13:42:25 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add the EcoNet EN7528 board: board glue, the reference and RAM
defconfigs, and the board header.

Signed-off-by: AK Sharma <maskachoska@yahoo.com>
---
 board/econet/en7528/MAINTAINERS    | 13 +++++++++
 board/econet/en7528/Makefile       |  2 ++
 board/econet/en7528/board.c        | 37 +++++++++++++++++++++++++
 configs/en7528_ram_defconfig       | 43 ++++++++++++++++++++++++++++++
 configs/en7528_reference_defconfig | 38 ++++++++++++++++++++++++++
 include/configs/en7528.h           |  9 +++++++
 6 files changed, 142 insertions(+)
 create mode 100644 board/econet/en7528/MAINTAINERS
 create mode 100644 board/econet/en7528/Makefile
 create mode 100644 board/econet/en7528/board.c
 create mode 100644 configs/en7528_ram_defconfig
 create mode 100644 configs/en7528_reference_defconfig
 create mode 100644 include/configs/en7528.h

diff --git a/board/econet/en7528/MAINTAINERS b/board/econet/en7528/MAINTAINERS
new file mode 100644
index 00000000..44520a14
--- /dev/null
+++ b/board/econet/en7528/MAINTAINERS
@@ -0,0 +1,13 @@
+ECONET/AIROHA EN75XX
+M:	AK Sharma <maskachoska@yahoo.com>
+S:	Maintained
+F:	arch/mips/mach-en75xx/
+F:	arch/mips/dts/econet,en7528*
+F:	board/econet/en7528/
+F:	configs/en7528_*_defconfig
+F:	doc/board/econet/en7528.rst
+F:	doc/board/econet/index.rst
+F:	drivers/serial/serial_en75xx.c
+F:	include/configs/en7528.h
+N:	en75xx
+N:	en7528
diff --git a/board/econet/en7528/Makefile b/board/econet/en7528/Makefile
new file mode 100644
index 00000000..bcca1a9f
--- /dev/null
+++ b/board/econet/en7528/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0+
+obj-y += board.o
diff --git a/board/econet/en7528/board.c b/board/econet/en7528/board.c
new file mode 100644
index 00000000..a168f534
--- /dev/null
+++ b/board/econet/en7528/board.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <dm.h>
+#include <init.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <stdio.h>
+
+#if CONFIG_IS_ENABLED(AIROHA_ETH)
+extern U_BOOT_DRIVER(airoha_eth);
+#endif
+
+int board_init(void)
+{
+	return 0;
+}
+
+int board_late_init(void)
+{
+#if CONFIG_IS_ENABLED(AIROHA_ETH)
+	struct udevice *dev;
+	int ret;
+
+	/*
+	 * Probe the EN751221-family Ethernet parent after the console is up and
+	 * just before initr_net() enumerates UCLASS_ETH devices (mirrors the
+	 * EN7512 reference board).
+	 */
+	ret = uclass_get_device_by_driver(UCLASS_MISC,
+					  DM_DRIVER_GET(airoha_eth), &dev);
+	if (ret && ret != -ENODEV)
+		printf("EN7528 Ethernet probe failed: %d\n", ret);
+#endif
+	return 0;
+}
diff --git a/configs/en7528_ram_defconfig b/configs/en7528_ram_defconfig
new file mode 100644
index 00000000..17aa465c
--- /dev/null
+++ b/configs/en7528_ram_defconfig
@@ -0,0 +1,43 @@
+CONFIG_MIPS=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_MALLOC_LEN=0x100000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x1000
+CONFIG_DEFAULT_DEVICE_TREE="econet,en7528-ram"
+CONFIG_SYS_LOAD_ADDR=0x81800000
+CONFIG_ARCH_EN75XX=y
+CONFIG_BOARD_EN7528_RAM=y
+CONFIG_SYS_MIPS_TIMER_FREQ=200000000
+CONFIG_SYS_LITTLE_ENDIAN=y
+CONFIG_BOOTDELAY=3
+CONFIG_DISPLAY_CPUINFO=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="EN7528> "
+CONFIG_SYS_MAXARGS=16
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_DM=y
+CONFIG_CMD_MTD=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_EFI_PARTITION=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_CLK=y
+CONFIG_DMA=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_DM_MDIO=y
+CONFIG_AIROHA_ETH=y
+CONFIG_PHY=y
+CONFIG_NOP_PHY=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_AIROHA_SNFI_SPI=y
+CONFIG_LZMA=y
diff --git a/configs/en7528_reference_defconfig b/configs/en7528_reference_defconfig
new file mode 100644
index 00000000..4b85a7dd
--- /dev/null
+++ b/configs/en7528_reference_defconfig
@@ -0,0 +1,38 @@
+CONFIG_MIPS=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_MALLOC_LEN=0x100000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x1000
+CONFIG_DEFAULT_DEVICE_TREE="econet,en7528-reference"
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_SERIAL=y
+CONFIG_TPL_SYS_MALLOC_F_LEN=0x1000
+CONFIG_SPL_BSS_START_ADDR=0x80080000
+CONFIG_SPL_BSS_MAX_SIZE=0x10000
+CONFIG_SYS_LOAD_ADDR=0x81800000
+CONFIG_SPL=y
+CONFIG_ARCH_EN75XX=y
+CONFIG_BOARD_EN7528_REFERENCE=y
+CONFIG_SYS_MIPS_TIMER_FREQ=150000000
+CONFIG_MIPS_CACHE_SETUP=y
+CONFIG_MIPS_CACHE_DISABLE=y
+CONFIG_RESTORE_EXCEPTION_VECTOR_BASE=y
+CONFIG_MIPS_BOOT_FDT=y
+CONFIG_SYS_LITTLE_ENDIAN=y
+CONFIG_FIT=y
+CONFIG_BOOTDELAY=3
+CONFIG_DISPLAY_CPUINFO=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_SPL_MAX_SIZE=0x30000
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_TPL=y
+# CONFIG_TPL_FRAMEWORK is not set
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="EN7528> "
+CONFIG_SYS_MAXARGS=8
+CONFIG_CMD_MEMINFO=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_SPL_DM=y
diff --git a/include/configs/en7528.h b/include/configs/en7528.h
new file mode 100644
index 00000000..b8dc2410
--- /dev/null
+++ b/include/configs/en7528.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef __CONFIG_EN7528_H
+#define __CONFIG_EN7528_H
+
+#define CFG_SYS_SDRAM_BASE	0x80000000
+/* Above FIT scratch (0x82000000) and kernel load (0x80020000, up to ~32 MiB). */
+#define CFG_SYS_INIT_SP_OFFSET	0x04000000
+
+#endif
-- 
2.53.0

