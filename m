Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1909C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 15:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36C5D881BC;
	Thu, 28 Mar 2024 16:34:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711640080;
	bh=k2bjMeyKh/xTIG66PASgg5gk02BV0nVMbWe8Zk4y7Gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cH7zlfsqviJNVz7CRtV11g1T8AE8LpZZmv8hp3pZlMhhvACJtHpGRvq7avCSz4KJ0
	 g2Br53N9LhDILhFlThvutkc2hV0hgI2EiDOi2kMj3aK1hH/a1RI7Ak6yvUNzE15oBk
	 kRkOwWrpgsM6Wh/l4FgZg1hljP2CeY3MozBi4PQJawlIlGJcfKVHXGLKWCgzbZrZGN
	 lUTPj2aXO75a1D7QZKd8UZo1bCaqujn7HAgoByHZU7xHprY56UaURN7ZnPN2pQRcWt
	 fFHqeSQcJ5tki6QjuoqERHovS04NjK9wlSyp9tQVzB7YpwMylZ/2Qp0UZ+uSrB90K1
	 G3uaNIKdJqpQw==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2B407881A4;
 Thu, 28 Mar 2024 16:34:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711640078;
 bh=k2bjMeyKh/xTIG66PASgg5gk02BV0nVMbWe8Zk4y7Gc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QmqLqEFPkknHG+M5V8qbA3cMM7L4/CYtB1ZkeiPwXP+SYapetApnEfiaoHrOoArWE
 VfU4ys9h1qX6N1xwPnSIzgybsmOHOEfMgiM6cr86AQbp4h+LMQJkVDrReRvbW2Ve68
 zjpADjbiNlxHLW/jWP8xPzw9bvtZ7b+z4vBhyIQkr3RLYOHuvMJcXfGcqwP7+3uBiP
 Oje0A/A6B1hsQNpZ5GSk8hDx1g0j9S/xMca57afcAktBx2SJVPs4BA74o2V1xPA0dh
 7F7zThOXTpdqaonT6uvI3Cyw+t2RLyKGRMzfB1X2HDE1DbFqYJZ/T48GAnJvdGEx6j
 JaUTys2cipxqA==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/6] config: xea: Enable late board initialization to set
 revision variable
Date: Thu, 28 Mar 2024 16:34:13 +0100
Message-Id: <20240328153415.3706637-5-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328153415.3706637-1-lukma@denx.de>
References: <20240328153415.3706637-1-lukma@denx.de>
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

The 'board_som_rev' environment variable will be used to point correct
configuration from the Linux FIT file.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---

 board/liebherr/xea/xea.c       | 12 ++++++++++++
 configs/imx28_xea_defconfig    |  1 +
 configs/imx28_xea_sb_defconfig |  1 +
 3 files changed, 14 insertions(+)

diff --git a/board/liebherr/xea/xea.c b/board/liebherr/xea/xea.c
index d9cf27c81b..90a1e03077 100644
--- a/board/liebherr/xea/xea.c
+++ b/board/liebherr/xea/xea.c
@@ -282,6 +282,18 @@ int board_init(void)
 	return 0;
 }
 
+#if defined(CONFIG_BOARD_LATE_INIT)
+int board_late_init(void)
+{
+	int ret = env_set_ulong("board_som_rev", get_som_rev());
+
+	if (ret)
+		printf("Cannot set XEA's SoM revision env variable!\n");
+
+	return 0;
+}
+#endif
+
 int dram_init(void)
 {
 	return mxs_dram_init();
diff --git a/configs/imx28_xea_defconfig b/configs/imx28_xea_defconfig
index 64a0561a34..6098c1f3be 100644
--- a/configs/imx28_xea_defconfig
+++ b/configs/imx28_xea_defconfig
@@ -39,6 +39,7 @@ CONFIG_BOOTCOMMAND="run ${bootpri} ; run ${bootsec}"
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="run prebootcmd"
 CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/imx28_xea_sb_defconfig b/configs/imx28_xea_sb_defconfig
index 9872d35c1b..8d48d8c507 100644
--- a/configs/imx28_xea_sb_defconfig
+++ b/configs/imx28_xea_sb_defconfig
@@ -23,6 +23,7 @@ CONFIG_BOOTARGS="console=ttyAMA0,115200n8"
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="run prebootcmd"
 CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_BOARD_LATE_INIT=y
 # CONFIG_SPL_FRAMEWORK is not set
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_SPL_BOARD_INIT=y
-- 
2.39.2

