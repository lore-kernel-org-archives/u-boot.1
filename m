Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702EC606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=y2fviO3v;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=XYUD26Oe
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 284678123F;
	Sat, 28 Nov 2026 13:12:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xkEEOJMsPqkN; Sat, 28 Nov 2026 13:12:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6F6C78128D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871559;
	b=YqFlhiT1XjKcdXgD00XBuDY3EG7ARXjjPReMrkP51zOjMTmMzimRvfZ+Nf9pWJuKtT/L
	 bbsd36EIhQj1usmPGD/V+pz/6B5QlkwV3wX7qV7QBa4lLziQ3csYrKTSzDixI+1yXCslY
	 qVeSOOQ8CVp/+8gsNduNK0V394WgR/E2RZIDOI1qlCkG5JmJUFIvCNuqiKYz079cFcTH2
	 9N+xmrloslN8UUhgjeVW0e+nps6nqsbqJx/06v1brx3zVUzkD4acyyHmveIcK0BRj50gq
	 fOYiXlkoUKIUbYDMZPnrJ+/7Dhx/gbexUykwgHR752wlXDvhpD8WR/S74p2DpaMKdkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871559;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yxeaBfb1PYl2MoMPi9gXoZ973MaoN5XALzMD8vYGrp8=;
	b=nTXBJhSi46dyThjer3osAUO+ockmf+s299/yr5p8ZAsEMKMUW01YYGeAZ+b1pMngkZQl
	 F10aWZgUTjhkZeZWV/9KN6GAN91+eojsNK/MdETiL9e+VMCP0rZZig6dY+FxOVPTT6jk+
	 5lSYDtaBsjavyuA/Z/OG5NOXaCufQCnyQ/sFaNSWEC2D7oVWVq4VmLebPcUiX8zq31CHe
	 zX/YSQigPbsIqszDvxX2vwzmDXcbKGEvygkx5vlD/H+gCaaxHah105+xUj6VBJVu5UMEN
	 /R3RLxqbhjrugZncnl+BZW0L9oHcbC+QIioUmBwV8TWzuzmS6b9hEdFxaoKHzsVqqaQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871559;
	bh=yxeaBfb1PYl2MoMPi9gXoZ973MaoN5XALzMD8vYGrp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y2fviO3vmXvqloa4J7ec+3JfV5ODWJ3mhnNUzDPbYx1BmZE3JTzPw+6v1FS0uXdst
	 +vb+xqTrTmCJzLAhVDjTAJErV7Q09vYFNh68Onb4vcJ2EiXqVscNJROTBkApNJuUM0
	 ls1VzgLIjvCfbG0vc2qJ5BWuy9Lsf2rtPiYpzgq0XuAWoSnBizq/AXo7KvvSfYsXkV
	 GO1kvDCm9A2MmqQ0t0QaQW5IArISe1QYqHVfoNDbZ+SQ9q0v6Ehzr7eR6Cx4LnoQNI
	 3eIQL0HffNwVADgl6HILtw5qqp4dBuLeQf51ImhDIDJfxiFmJRyA7vDrVLq0+fANid
	 +oqkk/FHzqqKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F6C78128D;
	Sat, 28 Nov 2026 13:12:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8552DBF4
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ABCB86064A
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GyYMyJTQcUD6 for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:12:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 92A0360623
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=XYUD26Oe
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 92A0360623
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:27 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a14so87141145e9.1
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871545; x=1796476345;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yxeaBfb1PYl2MoMPi9gXoZ973MaoN5XALzMD8vYGrp8=;
 b=XYUD26OeReKQmHs00mPMhuURDRWXVt+BwDitYnCYPn/upfuw6Bsv1kgPQzeQZiySw4
 xN8Y/EUPNezjI7cXD2zS1JgEzAG5pf1uZV+WgmJEgts2tiDrVasdGsp+2KBirVrFPmUE
 7ci01j5EoKD6I6yNK2sBNAdil9LPLRd3cn9s8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871545; x=1796476345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yxeaBfb1PYl2MoMPi9gXoZ973MaoN5XALzMD8vYGrp8=;
 b=LDVB/G90cvqv7IyjWq9hdfopmP6Jm/qD6mStCOxkkOkLZnXpeSGwiYxa9dXL+pUUej
 5LhHUCUyLcbRV/Ro8SwmS4hkUXEDJMumc1kl0KZcJ/6nHDEba4pPhTnC0utQKEhwL/rn
 LvndPMJIgUJXmpiKyvAcOvOR4I+anPo2YIJsYNyRfSMMfh7dO0xINTDBtRxOt4+bZZYT
 gb5UugxbfLmHRzRq87lPweoT6eVFpjIc3BhuyBa4sAPhBl7vMrLAgT3WRPuC2Ep3XHhC
 0WvOKX80YG/PzvJk5buXUquu2AQ8hwrX0BYMlXM6pwBxZ1q81XI5WfQIvBaQI3Q58VK7
 aQ6Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHkkFWUjS7ZWyih9ZickIMrZ8J5g/o4NQjbrLl2tdd/rQ3ZgBEuIQdZ5mfveNUCFM5Nk6nLLQA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+c0eE7J2yPslF+9nt6L34pD1V0LkFUbTl4HiIVN/w+Go06dIwo
 Ud28VqRiA+Za48SCDjzhKQgvyXmxsIUywjGLhPWjIc7thtNAVsVDr+rmyFDpxMh7RGL6uZEeMHY
 57xoT
X-Gm-Gg: AZFdTZcjYwCtJFfEMPOuIwy/mzKYmRB+1aAwYYiWP48v5eQCftSkcVEzzuxi0fH5d6O
 vG7PmHJvr9tQgr01ahXThHa4dfsvkY4vt0MgXhLyLeKzwMXOrZs1fhUckOs/ZDS8z7ABDwtFRHd
 fKsQPvNckuAnSjZgbvX9dljWNrzkbC4NrOKaVa05pvnXMTFzZtizvvy6KBv6Av0TX7kYGeRL7l4
 ULCzqkbkZtVyxDGBwHHjiT2Ca8uy2KxZnfRMblNBr+TW5No4+W/o4/wjK7JInhPysDpstTR2Jhq
 tfxSalhtpcKqdI2tNB9ub4rbctDXegMQbJ1w7v+IbeR7jMeyicI1RCtb/pC1Sfw55ts+Ys8FeXc
 ESupV5snF7vGbrKcAZljtJypmYU9VQ2X21i8e6t7hPhTMDAfwk3/++B6/tOcjAc0K77UGijqmJM
 BeFPjNJssT9nDQq9bx6MVen3GsyJvyxrAuCohT+B+tUV2ovyPlJkv+JQJ/z28dU1Qyi6/6P7mgE
 KQiwiwQ1/Lr37IQJHWEDsMtFaQ5nRPZyB/HkbhFHu+4zDfqQHpYysCDZu/V8VuAX5ELaJvEhFB+
 DJV12/DOXYy/YsrgqLGJalV96RQg3a57hzmVgyyV2rvP2UGoZrfCWLjKSYW47qPfIhcmcHA/C1i
 2gkwTkY69lvwfxRlkafPF0V2T0lG1+BMSWrLwX8Ci6oMvY+vD9d8Ib9Ah/QfHmTLu/59AkvZlPP
 Oexcytjdqh2qXiGIoud8h5zKnPDw==
X-Received: by 2002:a05:600c:154c:b0:4a2:729:f7ce with SMTP id
 5b1f17b1804b1-4bb8881c378mr558369275e9.8.1795871545358; 
 Sat, 28 Nov 2026 05:12:25 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:12:24 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org (open list)
Subject: [PATCH v3 28/29] board: engicam: stm32mp2: support FWU A/B bank bootup
Date: Sat, 28 Nov 2026 14:10:45 +0100
Message-ID: <20261128131125.2141352-29-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
References: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable the FWU multi-bank update. The FWU metadata are stored in the
boot device, so point the "fwu-mdata-store" property to it at runtime.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

Changes in v3:
- Add Reviewed-by tag

 ...m32mp257d-engicam-microgea-rmm-u-boot.dtsi |  6 +++
 board/engicam/stm32mp2/stm32mp2.c             | 40 +++++++++++++++++++
 configs/stm32mp25-microgea-rmm_defconfig      |  6 +++
 3 files changed, 52 insertions(+)

diff --git a/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi b/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
index 8a3723baa116..3055d661d849 100644
--- a/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
@@ -10,6 +10,12 @@
 	config {
 		u-boot,mmc-env-partition = "u-boot-env";
 	};
+
+	/* moved to the eMMC, when booting from it, by board_fix_fdt() */
+	fwu-mdata {
+		compatible = "u-boot,fwu-mdata-gpt";
+		fwu-mdata-store = <&sdmmc1>;
+	};
 };
 
 &ltdc {
diff --git a/board/engicam/stm32mp2/stm32mp2.c b/board/engicam/stm32mp2/stm32mp2.c
index 64317f271ed7..e15141677775 100644
--- a/board/engicam/stm32mp2/stm32mp2.c
+++ b/board/engicam/stm32mp2/stm32mp2.c
@@ -12,6 +12,7 @@
 #include <env.h>
 #include <event.h>
 #include <extension_board.h>
+#include <fdt_support.h>
 #include <log.h>
 #include <splash.h>
 #include <asm/arch/stm32.h>
@@ -217,6 +218,45 @@ int splash_screen_prepare(void)
 }
 #endif
 
+#if CONFIG_IS_ENABLED(OF_BOARD_FIXUP)
+/*
+ * The FWU metadata are stored in the boot device, the SD card or the
+ * eMMC, so point the "fwu-mdata-store" property to it. The phandle is
+ * replaced in place, since the devicetree is already in use.
+ */
+int board_fix_fdt(void *blob)
+{
+	u32 bootmode = get_bootmode();
+	unsigned int instance = (bootmode & TAMP_BOOT_INSTANCE_MASK) - 1;
+	int node, store;
+	char alias[8];
+	u32 phandle;
+
+	node = fdt_node_offset_by_compatible(blob, -1, "u-boot,fwu-mdata-gpt");
+	if (node < 0)
+		return 0;
+
+	switch (bootmode & TAMP_BOOT_DEVICE_MASK) {
+	case BOOT_FLASH_SD:
+	case BOOT_FLASH_EMMC:
+		break;
+	default:
+		return 0;
+	}
+
+	snprintf(alias, sizeof(alias), "mmc%u", instance);
+	store = fdt_path_offset(blob, alias);
+	if (store < 0)
+		return store;
+
+	phandle = fdt_get_phandle(blob, store);
+	if (!phandle)
+		return -ENOENT;
+
+	return fdt_setprop_inplace_u32(blob, node, "fwu-mdata-store", phandle);
+}
+#endif
+
 int board_late_init(void)
 {
 	const char *fdt_compat;
diff --git a/configs/stm32mp25-microgea-rmm_defconfig b/configs/stm32mp25-microgea-rmm_defconfig
index 0f1b7db7abc8..73f8f7cf96b6 100644
--- a/configs/stm32mp25-microgea-rmm_defconfig
+++ b/configs/stm32mp25-microgea-rmm_defconfig
@@ -14,10 +14,13 @@ CONFIG_CMD_STM32KEY=y
 CONFIG_MFD_STM32_TIMERS=y
 CONFIG_ENV_OFFSET_REDUND=0x940000
 CONFIG_TARGET_MICROGEA_STM32MP257=y
+CONFIG_FWU_NUM_IMAGES_PER_BANK=3
+CONFIG_OF_BOARD_FIXUP=y
 CONFIG_SYS_MEMTEST_START=0x84000000
 CONFIG_SYS_MEMTEST_END=0x88000000
 CONFIG_API=y
 CONFIG_SYS_MMC_MAX_DEVICE=3
+CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
@@ -25,6 +28,7 @@ CONFIG_BOOTCOMMAND="run bootcmd_stm32mp"
 # CONFIG_BOARD_INIT is not set
 CONFIG_SYS_PROMPT="STM32MP> "
 # CONFIG_CMD_BDI is not set
+CONFIG_CMD_FWU_METADATA=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_ADTIMG=y
 # CONFIG_CMD_ELF is not set
@@ -119,3 +123,5 @@ CONFIG_WDT_STM32MP=y
 CONFIG_WDT_ARM_SMC=y
 # CONFIG_UBIFS_SILENCE_DEBUG_DUMP is not set
 CONFIG_ERRNO_STR=y
+CONFIG_FWU_MULTI_BANK_UPDATE=y
+CONFIG_FWU_MDATA_V2=y
-- 
2.43.0

