Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24423E909D9
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 16:41:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 059AF83E83;
	Tue, 17 Feb 2026 17:39:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="iA7rVQXT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FFF483C32; Tue, 17 Feb 2026 17:39:26 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1876483D0B
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 17:39:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4D8BD110AE4; Tue, 17 Feb 2026 17:39:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1771346363; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=nv7tqiwvqIK7dKcbZF3mcuG1Fn5nmrfQjNdUkmAANps=;
 b=iA7rVQXT3xfT5MSLqDVBxsgRlK/wHsB/B882TgOiJq+X6Ienc0P2x5gx4MFg0b8o10GtJR
 4C9Bz65vOwN0jlVbegawEaRSW5yiQE6G2CWpbKGu4AKV9HnyN4kBnbbq2V/B3fsfMT0dFG
 CYngITIroVkJT5hzJf6QwjA+4pdHx8V/cxQyG4ElmYEz0lClL+ZQHa2HJINNWdHAGrafZ3
 N2ewJwgx/1u7wC2YWU9mReU7+wm4o8duikSm6K5jFouh6oEmsX2giMlMzuiAbrBR+7+w5Y
 VXf4NZ1M2+ec9FTTIW900W7FtBJIyuVP/LIld4d5nYBCAxx54I1/Sk14DIvJaA==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@oss.nxp.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: [PATCH v3 11/11] siemens: capricorn: protect environment
Date: Tue, 17 Feb 2026 17:39:11 +0100
Message-Id: <20260217163911.31878-12-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260217163911.31878-1-hs@nabladev.com>
References: <20260217163911.31878-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Adrian Freihofer <adrian.freihofer@siemens.com>

With ENV_WRITEABLE_LIST only specific environment variables lisetd in
CFG_ENV_FLAGS_LIST_STATIC are read from the u-boot environment storage.
All other environment variables are set to default values and are not
written back to the storage.

The u-boot environment usually stays for the lifetime of the product.
There is no A/B copy mechanism as for the firmware itself. That means
that incompatible changes to environment variables in future u-boot
versions may lead to serious issues if the old environment is used with
a new u-boot version or vice versa.

Having this protection in place ensures that only a limited set of
environment variables are persisted across u-boot versions. All the
macros not listed in CFG_ENV_FLAGS_LIST_STATIC are now part of the
u-boot binary which is redundant and immutable. This guarantees that
the u-boot version and the default values of these environment variables
are always in sync and cannot be changed at runtime.

ustate and rastate are not relevant for u-boot itself. ustate is used
by swupdate which persists the transaction state in the environment.
rastate is a similar variable used by another user space application.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
Signed-off-by: Heiko Schocher <hs@nabladev.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>

---

(no changes since v2)

Changes in v2:
Added Reviewed-by from Peng
Reworked writeable variable list, as we dropped patch
"env: add w flags for net config in explicit write mode"

 configs/imx8qxp_capricorn.config   |  1 +
 include/configs/capricorn-common.h | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/configs/imx8qxp_capricorn.config b/configs/imx8qxp_capricorn.config
index 626634cb09c..2bae5b1a862 100644
--- a/configs/imx8qxp_capricorn.config
+++ b/configs/imx8qxp_capricorn.config
@@ -12,6 +12,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
+CONFIG_ENV_WRITEABLE_LIST=y
 
 CONFIG_DM_GPIO=y
 CONFIG_AHAB_BOOT=y
diff --git a/include/configs/capricorn-common.h b/include/configs/capricorn-common.h
index 7120a44d186..ee13d2ab950 100644
--- a/include/configs/capricorn-common.h
+++ b/include/configs/capricorn-common.h
@@ -38,6 +38,19 @@
 #define CFG_EXTRA_ENV_SETTINGS \
 	AHAB_ENV
 
+#ifdef CONFIG_ENV_WRITEABLE_LIST
+#define CFG_ENV_FLAGS_LIST_STATIC \
+	"bootcount:dw," \
+	"bootdelay:sw," \
+	"bootlimit:dw," \
+	"partitionset_active:sw," \
+	"rastate:dw," \
+	"sig_a:sw,sig_b:sw," \
+	"target_env:sw," \
+	"upgrade_available:dw," \
+	"ustate:dw"
+#endif
+
 /* Default location for tftp and bootm */
 
 /* On CCP board, USDHC1 is for eMMC */
-- 
2.20.1

