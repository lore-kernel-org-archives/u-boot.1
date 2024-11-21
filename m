Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43A5D75BBB
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 05:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D42A896C7;
	Thu, 21 Nov 2024 06:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732166785;
	bh=9Jc7FUrY1MdDJKTXDWJ8zPoKEhalsz+o2YhPvdiy1IQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x8D0Fa1UpUFrz2atr6bdidRHn3a+quGvDXSlik7vFJMKUMqcDOGRzMQ95c++PBR1C
	 zDd0TlSNz4JCFifHnIxhUNDad6hlMeZRNMX/ODLdx573uKAb4vmTAbvGRP1xcDjJei
	 UUm+qxfoaz8RIXmiXdFYP3qN0CvX1NzoFCVzmyIE1vVnqvna8Cz8bacPlOBHsiyhRJ
	 sDw2zJI/xrW9QYRnrsn5PC/U7r7P3oNmaNthJUNUhBtvTwKFahKzSAMhTfS9Kzb1hL
	 0KVfoGODoQX0kOxnFbY64HxRQZTxG8oShMcKxdRdq3k81rASNDuAP7hXgPyDHViUdc
	 fNctI2QXxq5fw==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 93F988969D;
 Thu, 21 Nov 2024 06:26:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732166783;
 bh=9Jc7FUrY1MdDJKTXDWJ8zPoKEhalsz+o2YhPvdiy1IQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ci7Sr4U3aebxOV2HarcpKxMDCF5GInuPDVWO7651GdJUxZWA53gqd6DJ0wKi+9N6C
 ZOVetEvULnmdBl505aTu7AXhu7jYZW6Egvctw5U7U3i3/IavpHkwMl6o4yloL/Eujj
 TvcM0N6wbRF0TebJQZI6HPhuZMfsQIg33k7A7sTiqubsVtsbD599oj0CGtO1GUHCkS
 lR4f3/Ni08LymDTR1Ag5AfCuxrj+h+A4T8nGWCLrLrdtKyx53b7ckA9jjv6rp3YKoA
 iVu6jpcSznO8q50ibozXhTld/yIREX2qZoLtoKIdRV/RF46skxpc+zcgbxzcJYbeny
 qTcJNy6/BJRyg==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Alessandro Zini <alessandro.zini@siemens.com>,
 Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 16/20] siemens: capricorn: get ram size from system
 controller
Date: Thu, 21 Nov 2024 06:25:57 +0100
Message-Id: <20241121052601.72880-17-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241121052601.72880-1-hs@denx.de>
References: <20241121052601.72880-1-hs@denx.de>
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

From: Enrico Leto <enrico.leto@siemens.com>

Get the memory region information from system controller to reduce the
number of platform specific headers. We were aligned on NXP mek board
implementation. This need at least 1 header per memory configuration.

Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
Signed-off-by: Heiko Schocher <hs@denx.de>
---

(no changes since v1)

 board/siemens/capricorn/board.c    | 34 ++++++++++++++++++++++++++++++
 include/configs/capricorn-common.h |  4 +++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/board/siemens/capricorn/board.c b/board/siemens/capricorn/board.c
index decac63db3b..484e2707183 100644
--- a/board/siemens/capricorn/board.c
+++ b/board/siemens/capricorn/board.c
@@ -73,6 +73,40 @@ int board_early_init_f(void)
 	return 0;
 }
 
+#ifndef CONFIG_XPL_BUILD
+void board_mem_get_layout(u64 *phys_sdram_1_start,
+			  u64 *phys_sdram_1_size,
+			  u64 *phys_sdram_2_start,
+			  u64 *phys_sdram_2_size)
+{
+	sc_faddr_t addr_start, addr_end;
+	sc_faddr_t sdram_1_size, sdram_2_size;
+	sc_err_t sc_err;
+
+	sc_err = sc_rm_get_memreg_info(-1, 6, &addr_start, &addr_end);
+	if (sc_err == SC_ERR_NONE) {
+		if (addr_end < 0x100000000) {
+			/* only lower RAM available */
+			sdram_1_size = (addr_end + 1) - PHYS_SDRAM_1;
+			sdram_2_size = 0;
+		} else {
+			/* lower RAM (2 GB) und upper RAM available */
+			sdram_1_size = SZ_2G;
+			sdram_2_size = (addr_end + 1) - PHYS_SDRAM_2;
+		}
+	} else {
+		/* Get default in case it would fail */
+		sdram_1_size = PHYS_SDRAM_1_SIZE;
+		sdram_2_size = PHYS_SDRAM_2_SIZE;
+	}
+
+	*phys_sdram_1_start = PHYS_SDRAM_1;
+	*phys_sdram_1_size = sdram_1_size;
+	*phys_sdram_2_start = PHYS_SDRAM_2;
+	*phys_sdram_2_size = sdram_2_size;
+}
+#endif /* ! CONFIG_XPL_BUILD */
+
 #define ENET_PHY_RESET	IMX_GPIO_NR(0, 3)
 #define ENET_TEST_1	IMX_GPIO_NR(0, 8)
 #define ENET_TEST_2	IMX_GPIO_NR(0, 9)
diff --git a/include/configs/capricorn-common.h b/include/configs/capricorn-common.h
index 1f61b2b6af6..4d95f3fd79b 100644
--- a/include/configs/capricorn-common.h
+++ b/include/configs/capricorn-common.h
@@ -95,7 +95,9 @@
 #define CFG_SYS_SDRAM_BASE		0x80000000
 #define PHYS_SDRAM_1			0x80000000
 #define PHYS_SDRAM_2			0x880000000
-/* DDR3 board total DDR is 1 GB */
+/* Set default values to the smallest DDR we have in capricorn modules
+ * Use it in case the system controller would return an error
+ */
 #define PHYS_SDRAM_1_SIZE		0x40000000	/* 1 GB */
 #define PHYS_SDRAM_2_SIZE		0x00000000	/* 0 GB */
 
-- 
2.20.1

