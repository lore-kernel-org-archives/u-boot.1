Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C319C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:45:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9EB788227;
	Fri, 22 Mar 2024 12:43:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711107825;
	bh=JFElZ01OsuLEt0y/J3RRtgoWvwPGc+7POH0YTTgQ6F0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jK6UvicLmuGOyFirN/EjfqAbu1mZtD4iq1B14Fh6x+VAqhR9LmbzL5ro5pFVf0ZDF
	 qDDv5hp4tTKt9UUtZC1ygD0lt79WQ02gbioaRv3vJTkbwLVGFilDAYe9hza9oKuHn7
	 9+D5Sk2L/V9YyzAmY+LlrRD1/IeXe+faCOCtImyx4qpf+XaolYpZMYqnTUGCaDIR7f
	 BAFfU2jHA35u6UVye98amNrh2v+Wy8bB/JVU9MLLyi7gt7m/IuSE7KCenbOEGc5P8G
	 xh+hmeFyUH4qhiEYCbYIHmvl7KUvHX35ZHjcQyddXfNaAXglhsUjUaTjQc9E8WAjZm
	 KA4QDNIv6NJnQ==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id EE4848820D;
 Fri, 22 Mar 2024 12:43:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711107820;
 bh=JFElZ01OsuLEt0y/J3RRtgoWvwPGc+7POH0YTTgQ6F0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=e6Qknr+M1oqs22dDdSRsvP+9/uxDqrlI7F5ZL5EMkphcHLqMecxJB3QzW77Y67AYO
 ciGFdSzRo3F0Q/StfjZlUPeneArvFB79gtXizqi2nUqMIKDNwKwkGY0ginbuyj4U2e
 b3+uq1PBLLWRS9Uaxxc0welUHQur1H3kExa9CHzX4P2obGSt18okQpr9cV5SKF2sg4
 kDyP+gd1mi3so2WIUwI98JTVpgvkL87jzRKUy1nkx715jvvuVOlg3ZW4BSxTd/DQ79
 IEmx0vxWOefrUOZDswgDN0e/Uhir7XQwk2/0vKmJK6y065x1p5acI+a/v6t2EacgHl
 hOZYsiXoWYa2g==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>,
	u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/12] config: xea: Enable late board initialization to set
 revision variable
Date: Fri, 22 Mar 2024 12:43:13 +0100
Message-Id: <20240322114315.2720727-11-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240322114315.2720727-1-lukma@denx.de>
References: <20240322114315.2720727-1-lukma@denx.de>
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
index 615d266b8f..5bac614153 100644
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
index bc8c167b1f..c416635b24 100644
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
index 691edc2834..78e59b4cb2 100644
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

