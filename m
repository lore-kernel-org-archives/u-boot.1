Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4C8CD98C5
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 02:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 360B284928;
	Thu, 11 Jun 2026 04:54:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="mQPAW2WY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61ADA848D1; Wed, 10 Jun 2026 15:36:51 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55F66848F0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 15:36:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F3E1B3F640
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 13:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1781098609;
 bh=bP+Zju5Jfe2E+rX1XZZWEI6EUhU7FCyMO8ghE9lKadg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=mQPAW2WYzWHYDsWkfLwB3TWC5Zsb2zyS74isWeVvcF60vdE68PdtHHGn2NnkzwITi
 U+ddtBFcj9qti1BmeKkjlwKmiTTQcMoa++CnpWjC5qJGogzFnXfsGZ/5xOY9dRH+l1
 +ZqLNa1gBRp4ivnYy9DgTJs3wHAUDkK/lpQW9nTFjEpX1QprRCgV1DnCLtEknI/x0s
 p07WE7t08T4UdksetxrUS0s3Qsyiv/UpZXoe+FXrrWG5GF+00iZTQsjXpcfUPBnJ2D
 S7BHYMMpcFpxG82e1IUZX/eKJpQ2fHbgZyfdwIYloICNGtfvRRkvEWq7PMQw2soxeJ
 vRtQJNTepUCvDzXH75InsgYIhIQ4QO5XCzdQDTamGhUt2LBObufRcA4RthlK/SfiE3
 F1MQWqxTYXA+tXcS201vHjdn08futIatVR7b3FhNOq08PGPf7pQq8UCi8Vie+qNcYW
 HokP/w08l7hp6hQOwytaTlVbgwRAu9N8NsREUfvyn78JJ1nU1h2uiVn8h8XF+VCHZa
 avZy0YsEiT+7SmJ5TlDjgGRDPgLadNhNAdvve+Gv87gAq0mOcGijVOdtgJfurQKvI2
 68PokdHwv+9/wLtqgpiH45NUcGXo4KWVIQsDuFXEEIWIo6UBlY3rHFZ8UCDQL2MMuJ
 Z8ksvhmYpyuHct+v93VbnI8U=
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2bf1dece2ecso69498885ad.1
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 06:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781098607; x=1781703407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bP+Zju5Jfe2E+rX1XZZWEI6EUhU7FCyMO8ghE9lKadg=;
 b=JKCca/x+LYd6jpSYf3XR5cRU/QxOu0b2segiCuNVpsrU0jBzxGDOxPluZ9utLeejsx
 aoiYoTuHhIBAlCTpcRQ4WDO2lxxojrteqfBwk8dl76IVZEiDT2qoEe215Ke+aXWeyBp4
 ncd6uMQWXkb3aKr2fz3+8xpbtAuA1PMLaJ2moyE3IuS09C/XgyHrdT5XM6tMvKpNjODE
 Pmjr+yxi9odG0a/ZOhrlEaPYeTpr4UYUhtfLxOLqCsISCOn6pvsgBiXF/NY+HrXEn7ck
 GYAw04yrxjouHjEv7aMWcdRBqoq+ES7icqNZD+u8mWCUlN2WrLfa1ypakUpFE0e1OTdp
 t/zQ==
X-Gm-Message-State: AOJu0YzCM6r1rEQGrJ/ig6D5AUsVIVM4Caq+UTYfbD2qrHw0aowY2Qh5
 Oa4eiDm1VvSDG+r4NqayfhDpjGJ/CxUsVI/OcO7DTLfxa8ekdyP9AgQd135mdTcbBNUWSwnlyZN
 ylFEGE8PcRnlzqyley308Q6pcqRy+pF2md7iq4eH6qtdUuAOcw20Tqykm6Xigb0opyzF6jVpKK6
 RPusQ=
X-Gm-Gg: Acq92OHgoYoZtYl6YfYJtoDHjwt9Eu80YoFeGFnwJuSztjEnXb22Sv6CAupJ8XprlWS
 PN0hNFPZPvYsSeQ9nUSjKYhST1zyB0yy/4U51cQMioaCYvPdh04ORu7UcbefzJhrFs/zgLIoSC2
 5hk9DjfE29T7ZAc84HtdCQovA/4ABDhXtxwTPqB56deFscFmBYuIzF/9zl89ZuuVpEykO5d78fu
 Fn+hA+6T4bND3GQ5U88YoRX1FbraO23ps1en0PiUFpJ50bycGXY16Os0MUSdD0FPhb4dD5Dev/z
 +RLUFfl+0CtkHFvmlliEf6s0ZalIdrWJdQdbSoT9/IHQGu9TxejV7WAYGBP4WP+jNIb9VSgj21D
 1yN9xxi6QhXI6ohBRZDuo+mrKeEWqfEV5CB8ZZLna25EQRcifMfRlxIi00W74VIXSrw0n2UH9uV
 g2IaKdzmgYnFZQZZF8h/phbilORA==
X-Received: by 2002:a17:902:e752:b0:2b2:5515:661c with SMTP id
 d9443c01a7336-2c1e893d62dmr279261185ad.31.1781098607363; 
 Wed, 10 Jun 2026 06:36:47 -0700 (PDT)
X-Received: by 2002:a17:902:e752:b0:2b2:5515:661c with SMTP id
 d9443c01a7336-2c1e893d62dmr279260795ad.31.1781098606908; 
 Wed, 10 Jun 2026 06:36:46 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16629d042sm257367375ad.60.2026.06.10.06.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 06:36:46 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v1 1/3] mx7ulp_evk: Move environment variables to .env file
Date: Wed, 10 Jun 2026 13:24:22 +0000
Message-ID: <20260610133336.15999-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610133336.15999-1-aristo.chen@canonical.com>
References: <20260610133336.15999-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jun 2026 04:54:05 +0200
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

Move the board environment from CFG_EXTRA_ENV_SETTINGS in the config
header to board/nxp/mx7ulp_evk/mx7ulp_evk.env for better
maintainability. The file is named after CONFIG_SYS_BOARD so it is
selected automatically without setting CONFIG_ENV_SOURCE_FILE.

The generated default environment is unchanged. This was verified by
comparing the output of scripts/get_default_envs.sh before and after the
change, which produced identical results.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 board/nxp/mx7ulp_evk/mx7ulp_evk.env | 59 +++++++++++++++++++++++++++
 include/configs/mx7ulp_evk.h        | 63 -----------------------------
 2 files changed, 59 insertions(+), 63 deletions(-)
 create mode 100644 board/nxp/mx7ulp_evk/mx7ulp_evk.env

diff --git a/board/nxp/mx7ulp_evk/mx7ulp_evk.env b/board/nxp/mx7ulp_evk/mx7ulp_evk.env
new file mode 100644
index 00000000000..f5a384a61de
--- /dev/null
+++ b/board/nxp/mx7ulp_evk/mx7ulp_evk.env
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+
+script=boot.scr
+image=zImage
+console=ttyLP0
+initrd_high=0xffffffff
+fdt_file=imx7ulp-evk.dtb
+fdt_addr=0x63000000
+boot_fdt=try
+earlycon=lpuart32,0x402D0010
+ip_dyn=yes
+mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
+mmcpart=1
+mmcroot=/dev/mmcblk0p2 rootwait rw
+mmcautodetect=yes
+mmcargs=setenv bootargs console=${console},${baudrate} root=${mmcroot}
+loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};
+bootscript=echo Running bootscript from mmc ...; source
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}
+mmcboot=echo Booting from mmc ...;
+	run mmcargs;
+	if test ${boot_fdt} = yes || test ${boot_fdt} = try; then
+		if run loadfdt; then
+			bootz ${loadaddr} - ${fdt_addr};
+		else
+			if test ${boot_fdt} = try; then
+				bootz;
+			else
+				echo WARN: Cannot load the DT;
+			fi;
+		fi;
+	else
+		bootz;
+	fi;
+netargs=setenv bootargs console=${console},${baudrate} root=/dev/nfs
+	ip=:::::eth0:dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=echo Booting from net ...;
+	run netargs;
+	if test ${ip_dyn} = yes; then
+		setenv get_cmd dhcp;
+	else
+		setenv get_cmd tftp;
+	fi;
+	usb start;
+	${get_cmd} ${image};
+	if test ${boot_fdt} = yes || test ${boot_fdt} = try; then
+		if ${get_cmd} ${fdt_addr} ${fdt_file}; then
+			bootz ${loadaddr} - ${fdt_addr};
+		else
+			if test ${boot_fdt} = try; then
+				bootz;
+			else
+				echo WARN: Cannot load the DT;
+			fi;
+		fi;
+	else
+		bootz;
+	fi;
diff --git a/include/configs/mx7ulp_evk.h b/include/configs/mx7ulp_evk.h
index ace1eee70cf..04fe902bbb7 100644
--- a/include/configs/mx7ulp_evk.h
+++ b/include/configs/mx7ulp_evk.h
@@ -27,69 +27,6 @@
 #define PHYS_SDRAM_SIZE			SZ_1G
 #define CFG_SYS_SDRAM_BASE		PHYS_SDRAM
 
-#define CFG_EXTRA_ENV_SETTINGS \
-	"script=boot.scr\0" \
-	"image=zImage\0" \
-	"console=ttyLP0\0" \
-	"initrd_high=0xffffffff\0" \
-	"fdt_file=imx7ulp-evk.dtb\0" \
-	"fdt_addr=0x63000000\0" \
-	"boot_fdt=try\0" \
-	"earlycon=lpuart32,0x402D0010\0" \
-	"ip_dyn=yes\0" \
-	"mmcdev="__stringify(CONFIG_ENV_MMC_DEVICE_INDEX)"\0" \
-	"mmcpart=1\0" \
-	"mmcroot=/dev/mmcblk0p2 rootwait rw\0" \
-	"mmcautodetect=yes\0" \
-	"mmcargs=setenv bootargs console=${console},${baudrate} " \
-		"root=${mmcroot}\0" \
-	"loadbootscript=" \
-		"fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};\0" \
-	"bootscript=echo Running bootscript from mmc ...; " \
-		"source\0" \
-	"loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}\0" \
-	"loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}\0" \
-	"mmcboot=echo Booting from mmc ...; " \
-		"run mmcargs; " \
-		"if test ${boot_fdt} = yes || test ${boot_fdt} = try; then " \
-			"if run loadfdt; then " \
-				"bootz ${loadaddr} - ${fdt_addr}; " \
-			"else " \
-				"if test ${boot_fdt} = try; then " \
-					"bootz; " \
-				"else " \
-					"echo WARN: Cannot load the DT; " \
-				"fi; " \
-			"fi; " \
-		"else " \
-			"bootz; " \
-		"fi;\0" \
-	"netargs=setenv bootargs console=${console},${baudrate} " \
-		"root=/dev/nfs " \
-		"ip=:::::eth0:dhcp nfsroot=${serverip}:${nfsroot},v3,tcp\0" \
-	"netboot=echo Booting from net ...; " \
-		"run netargs; " \
-		"if test ${ip_dyn} = yes; then " \
-			"setenv get_cmd dhcp; " \
-		"else " \
-			"setenv get_cmd tftp; " \
-		"fi; " \
-		"usb start; "\
-		"${get_cmd} ${image}; " \
-		"if test ${boot_fdt} = yes || test ${boot_fdt} = try; then " \
-			"if ${get_cmd} ${fdt_addr} ${fdt_file}; then " \
-				"bootz ${loadaddr} - ${fdt_addr}; " \
-			"else " \
-				"if test ${boot_fdt} = try; then " \
-					"bootz; " \
-				"else " \
-					"echo WARN: Cannot load the DT; " \
-				"fi; " \
-			"fi; " \
-		"else " \
-			"bootz; " \
-		"fi;\0" \
-
 #define CFG_SYS_INIT_RAM_ADDR	IRAM_BASE_ADDR
 #define CFG_SYS_INIT_RAM_SIZE	SZ_256K
 
-- 
2.43.0

