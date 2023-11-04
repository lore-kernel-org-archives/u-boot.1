Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15059C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 16:32:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5767C8712E;
	Sat,  4 Nov 2023 17:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1699115538;
	bh=/dFPSv5AuXhEqGI5aHuoHyBfY8jPuQQiNtnqYkKEdVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ksLz5XCSedFbctiOjMQgjES/tgCRCZLgcrxPXhGYefUJJAwglyfwYORktmCSB0lex
	 BZI29dRQicmEC4rzzmnnxCnjsa/0t5ZfMaFkceKwu8LaruIprh2PVKVTXUO3EghEUq
	 kZCNu1gF8B9gq2BaR/ZpAPMMToFr9tL5/BAHGpNkr6xWCMscGj7eyIQdhDcLyPl5lq
	 0Rl2ag89t5RgqLpu6kTxCdUl5l5iorC+Cp8MzvGF0JyW52ZPUTbEsbAXAF5lSl2u6E
	 3Mcyss+lsqxRB6ThHizar8etYsd3SbFwLgJO/cn445ekk4pB+odLipXitRn1aYKmD5
	 arXQ0aW5KadRQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id EBCB186F63;
 Sat,  4 Nov 2023 17:32:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1699115533;
 bh=/dFPSv5AuXhEqGI5aHuoHyBfY8jPuQQiNtnqYkKEdVk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pNs8L+iqbMlo+09+/tHzfymj3uwW6rfHxNnJOItYxZYMw3OncFW3mhKwzuX9xh64o
 T1buY7RUGtHq0n0m4HNRagfyQNTgkpHHNBbdDhv5x/GReijOIbN+KkjZSTybnW0WVi
 wyjZMENE6OG53Ca+eTfr0i44WZlyjWY/dE0zLiZstoL1Q4jfhh1ZfolexX/zXgDcPn
 JUx3T+ASiy5vzBp+hSoFTz+sa09cXXvHF5wys4HkuqU1xRffhGZgwrRQWAZzl8OnIU
 2wWoNFDzf2nomVwmpwuWnE3pLAAdIHyeMII4Bu/hCQEINCZEC6h61mWugKc1SIoxjr
 tvPE/x39Te6rQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 2/2] arm: stm32: Limit u-boot.itb size to 0x160000 bytes on DH
 STM32MP15 DHSOM
Date: Sat,  4 Nov 2023 17:31:57 +0100
Message-ID: <20231104163203.117382-2-marex@denx.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231104163203.117382-1-marex@denx.de>
References: <20231104163203.117382-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The maximum size of u-boot.itb in SPI NOR on DH STM32MP15 DHSOM is
0x160000 . Define this size in U-Boot config to prevent misconfigured
builds from emitting larger u-boot.itb than the one which fits the
SPI NOR area reserved for the blob.

The SPI NOR layout is as follows:
0x00_0000..0x03_ffff ... SPL 1
0x04_0000..0x07_ffff ... SPL 2
0x08_0000..0x1d_ffff ... U-Boot
0x1e_0000..0x1e_ffff ... Environment 1
0x1f_0000..0x1f_ffff ... Environment 2

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andreas Geisreiter <ageisreiter@dh-electronics.de>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 configs/stm32mp15_dhcom_basic_defconfig | 2 ++
 configs/stm32mp15_dhcor_basic_defconfig | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/configs/stm32mp15_dhcom_basic_defconfig b/configs/stm32mp15_dhcom_basic_defconfig
index 08aac878f8e..1d241529be7 100644
--- a/configs/stm32mp15_dhcom_basic_defconfig
+++ b/configs/stm32mp15_dhcom_basic_defconfig
@@ -25,6 +25,8 @@ CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0xc2000000
 CONFIG_SYS_MEMTEST_START=0xc0000000
 CONFIG_SYS_MEMTEST_END=0xc4000000
+CONFIG_HAS_BOARD_SIZE_LIMIT=y
+CONFIG_BOARD_SIZE_LIMIT=1441792
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0xc1000000
diff --git a/configs/stm32mp15_dhcor_basic_defconfig b/configs/stm32mp15_dhcor_basic_defconfig
index 8cd6924b580..6e0c4a8cf9f 100644
--- a/configs/stm32mp15_dhcor_basic_defconfig
+++ b/configs/stm32mp15_dhcor_basic_defconfig
@@ -23,6 +23,8 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 # CONFIG_ARMV7_VIRT is not set
 CONFIG_SYS_LOAD_ADDR=0xc2000000
+CONFIG_HAS_BOARD_SIZE_LIMIT=y
+CONFIG_BOARD_SIZE_LIMIT=1441792
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0xc1000000
-- 
2.42.0

