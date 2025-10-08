Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1F5CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 10:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CF0E83E81;
	Wed,  8 Oct 2025 12:01:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="dcRY/PSK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C333F8389E; Wed,  8 Oct 2025 12:01:04 +0200 (CEST)
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ba])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8DC283E23
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 12:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1759917662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p4HKzf41yblwb5ZEi3hIbNyvurngWxBH+txeqauhEWc=;
 b=dcRY/PSKF2A2jZ+CRVrTTJ2FqX6JgVIJ7HthewF7xQWrBAxlGBCMHvbL+vpKzWKkEGuQXs
 UJu4blrFsLOvtf+5wJufGzRAcPXaHmh3NbgaIF8/rnAhi1byhZVtk1lI4VmOcR81BhtwJI
 zjCVZG393SGU/txKXMoA6lDANPXwFo1qSW22PofXA18Pb8Qlhlcr3LDqH4hiz4M3TmdYBg
 BOFRGCfhEHp8XdZEjvXVfcq/zPVAiq28Roun951g6fR04o6RxCkiXd34oVOSujMi96drtc
 wpoNsqojspvNJvMvjqz9ZTjN9HcRdWl0rOqwUfNGBgcXv5Rp2xrDJeiR30GBZg==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 08 Oct 2025 10:00:43 +0000
Subject: [PATCH RFC v3 7/8] board: amlogic: add kconfig fragments for SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251008-spl-gx-v3-7-5999637df4b9@postmarketos.org>
References: <20251008-spl-gx-v3-0-5999637df4b9@postmarketos.org>
In-Reply-To: <20251008-spl-gx-v3-0-5999637df4b9@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5933;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=ZDCqaT1tKSS5vqVHVNkdoRL3WD8v9gNsgE+cMggnH4E=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBo5jZU2Oo6C2ZAfnuNpOK2w2BiufMqObITxPOdp
 joA18uSJ2GJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaOY2VAAKCRCEr8vQ14ma
 A8wiD/4pct6GtOevU2XtrSJzUgK1qSHAu2QgLC6HvwbyL6+MKkg5KVs1x9VBhi12dqx8Pqjbdmw
 i4Fd4Cwvr1pi1GI8UI8En9RiZI/3vlbhAmsIBFYC8cL77LmQheWX4/aZnH8dClkY9D57jgRM9Bh
 u4Up3kvN7t77mZAG9cIqpF0vxcIYCI4kHoM4mNn1GOSI0rGtd0cvAvSGRw6lsDy3xysxRtJ3pNt
 WbwbtDHqk0UxmmI4EAj8Cii+XhpIOtfaJNea5eWL+oKiEvWwXTPnd1tv1U6PI4NHadYlo6cH+UY
 kLp9jvMwR2FaXbfN2UomBv7eK8/k0sQgCl0bsERQikmjQaoKCo1Q6kEC1ss+g2Tj3PWF3jR6mBK
 iuhT56feTxYBaOZ7vYYF8+eB1qeIzuSLngPSLBZH8fQgY1AVJOPPcfqfRKTx5Euu35a6waAyOB/
 DWJFRovHZetJJXXuKg+8jT6Tz5zmeLtIBWTwoC3J+f4IZMMEJBPiMQP2dio2PQAxeXlVtU5OhJ3
 el5K1PKo6/j3EG9XSgOJtlK33R5iVd1RWYPQL0pPgMqZDxPGg0MwmcprIrjv5555KYA0i3956mo
 jszh4BkuzhauhyyuQJC7wA6ZilEVmvEf/rw778NXqElCmvPxfmdUfiCiOonhZcZ3xvzSROFxKZz
 VImNdypeeRk7V4g==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
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

Add kconfig fragments for building SPL binaries for:
 · ODROID-C2
 · Videostrong KII Pro
 · Libre Computer LePotato (1 GB and 2 GB variants)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 board/amlogic/p200/spl-odroid-c2.config           | 37 ++++++++++++++++++++++
 board/amlogic/p200/spl-videostrong-kii-pro.config | 38 +++++++++++++++++++++++
 board/amlogic/p212/spl-libretech-cc-1gb.config    | 36 +++++++++++++++++++++
 board/amlogic/p212/spl-libretech-cc-2gb.config    | 38 +++++++++++++++++++++++
 4 files changed, 149 insertions(+)

diff --git a/board/amlogic/p200/spl-odroid-c2.config b/board/amlogic/p200/spl-odroid-c2.config
new file mode 100644
index 0000000000000000000000000000000000000000..d5ea295bc6d281f3d7770cc841ccbae5aee468a4
--- /dev/null
+++ b/board/amlogic/p200/spl-odroid-c2.config
@@ -0,0 +1,37 @@
+#
+# U-Boot SPL fragment for odroid-c2
+#
+
+CONFIG_SPL=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_SPL_TEXT_BASE=0xd9001000
+CONFIG_SPL_STACK=0xd9013000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0xd900c000
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_BSS_MAX_SIZE=0x1000
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+# CONFIG_SPL_SERIAL_PRESENT is not set
+# CONFIG_SPL_SHA1 is not set
+
+# Enable MMC and serial drivers
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x100
+# CONFIG_SYS_MMCSD_FS_BOOT is not set
+
+# Image things
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_FIT_IMAGE_POST_PROCESS=y
+CONFIG_SPL_MAX_SIZE=0xb000
+CONFIG_SPL_PAD_TO=0x1fe00
+CONFIG_SPL_ATF=y
+CONFIG_SPL_OF_CONTROL=y
+# DRAM configuration
+CONFIG_DRAM_SIZE=2048
+CONFIG_DRAM_2T_MODE=y
+CONFIG_DRAM_TWO_IDENTICAL_RANKS=y
diff --git a/board/amlogic/p200/spl-videostrong-kii-pro.config b/board/amlogic/p200/spl-videostrong-kii-pro.config
new file mode 100644
index 0000000000000000000000000000000000000000..5b3ba9d990840411ef3cef3db3c6aa9d7085b3ef
--- /dev/null
+++ b/board/amlogic/p200/spl-videostrong-kii-pro.config
@@ -0,0 +1,38 @@
+#
+# U-Boot SPL fragment for videostrong-kii-pro
+#
+
+CONFIG_SPL=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_SPL_TEXT_BASE=0xd9001000
+CONFIG_SPL_STACK=0xd9013000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0xd900c000
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_BSS_MAX_SIZE=0x1000
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+# CONFIG_SPL_SERIAL_PRESENT is not set
+# CONFIG_SPL_SHA1 is not set
+
+# Enable MMC and serial drivers
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x100
+# CONFIG_SYS_MMCSD_FS_BOOT is not set
+
+# Image things
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_FIT_IMAGE_POST_PROCESS=y
+CONFIG_SPL_MAX_SIZE=0xb000
+CONFIG_SPL_PAD_TO=0x1fe00
+CONFIG_SPL_ATF=y
+CONFIG_SPL_OF_CONTROL=y
+# DRAM configuration
+CONFIG_DRAM_SIZE=2048
+CONFIG_DRAM_2T_MODE=y
+CONFIG_DRAM_TWO_DIFF_RANKS=y
+
diff --git a/board/amlogic/p212/spl-libretech-cc-1gb.config b/board/amlogic/p212/spl-libretech-cc-1gb.config
new file mode 100644
index 0000000000000000000000000000000000000000..f58bb69325980d582d2d826ebbf28e4700965dfb
--- /dev/null
+++ b/board/amlogic/p212/spl-libretech-cc-1gb.config
@@ -0,0 +1,36 @@
+#
+# U-Boot SPL fragment for libretech-cc (1 GB variant)
+#
+
+CONFIG_SPL=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_SPL_TEXT_BASE=0xd9001000
+CONFIG_SPL_STACK=0xd9013000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0xd900c000
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_BSS_MAX_SIZE=0x1000
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+# CONFIG_SPL_SERIAL_PRESENT is not set
+# CONFIG_SPL_SHA1 is not set
+
+# Enable MMC and serial drivers
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x100
+# CONFIG_SYS_MMCSD_FS_BOOT is not set
+
+# Image things
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_FIT_IMAGE_POST_PROCESS=y
+CONFIG_SPL_MAX_SIZE=0xb000
+CONFIG_SPL_PAD_TO=0x1fe00
+CONFIG_SPL_ATF=y
+CONFIG_SPL_OF_CONTROL=y
+# DRAM configuration
+CONFIG_DRAM_2T_MODE=y
+CONFIG_DRAM_DQS_CORR=y
diff --git a/board/amlogic/p212/spl-libretech-cc-2gb.config b/board/amlogic/p212/spl-libretech-cc-2gb.config
new file mode 100644
index 0000000000000000000000000000000000000000..65d700558e65ca8d819f397a0153be8bf07ae702
--- /dev/null
+++ b/board/amlogic/p212/spl-libretech-cc-2gb.config
@@ -0,0 +1,38 @@
+#
+# U-Boot SPL fragment for libretech-cc (2 GB variant)
+#
+
+CONFIG_SPL=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_SPL_TEXT_BASE=0xd9001000
+CONFIG_SPL_STACK=0xd9013000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0xd900c000
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_BSS_MAX_SIZE=0x1000
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+# CONFIG_SPL_SERIAL_PRESENT is not set
+# CONFIG_SPL_SHA1 is not set
+
+# Enable MMC and serial drivers
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x100
+# CONFIG_SYS_MMCSD_FS_BOOT is not set
+
+# Image things
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_FIT_IMAGE_POST_PROCESS=y
+CONFIG_SPL_MAX_SIZE=0xb000
+CONFIG_SPL_PAD_TO=0x1fe00
+CONFIG_SPL_ATF=y
+CONFIG_SPL_OF_CONTROL=y
+# DRAM configuration
+CONFIG_DRAM_SIZE=2048
+CONFIG_DRAM_2T_MODE=y
+CONFIG_DRAM_DQS_CORR=y
+CONFIG_DRAM_TWO_IDENTICAL_RANKS=y

-- 
2.51.0

