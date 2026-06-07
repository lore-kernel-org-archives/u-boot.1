Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF95CD8C88
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 02:57:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4831F8063E;
	Sun,  7 Jun 2026 04:57:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="RRpsaTqr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAE9E83314; Sun,  7 Jun 2026 04:57:01 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87AD580433
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 04:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c858b392697so1515013a12.3
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 19:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1780801015; x=1781405815; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YrnvdlBLk542sKV4pYuZh9hknsvlMmKiWR1TNgpZ+JE=;
 b=RRpsaTqrCjO9bMZv2prZruUWXygIKPtb2QnXE8gpDM0dS48uNtTa3XpFjmrbXU6KPS
 6Tc3nm/8M1K+SZkkgLJGAvDaXUOMGPqKjPhWBTmZeWrzGVihvL6WGMeq1kd398gQ1ETZ
 Jesd9GOCHM0/ohw/hsFYl/QsHcN1lQ2WNR/yI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780801015; x=1781405815;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YrnvdlBLk542sKV4pYuZh9hknsvlMmKiWR1TNgpZ+JE=;
 b=sRpsHeKIr74PcmjMmrWyU+Mhy2wJr6V/+9u99uaZNirXI1+SS8wDeIHoAGDRrrrjwr
 ea1cIwwYW4l8LVfWefLiVRESIanLW7akn4HGzbXzoNKAC5WgKJb07UIC6llxn8EsKGQf
 YVWK6ckFpy2IePGIdtO52X6PbF+wR7YmF0M5OCfP304nYxwxkJ13RibI2jehhOiGWcIB
 IzCkX9k5lYGksfDzWaE6SLJwiwUA7JVaqu263+gbgOflMMde4em49xazHMq9hW7LgPQo
 nAFWZGcqNx8hTBlLXiSkJHkdK3QVDXyL0wehZwDcYtic3cGRlcZPnAP1d1jf1OW6GGrb
 VV8g==
X-Gm-Message-State: AOJu0Yy483ZC3e7MjjCWmWLxTz2PyVH6iRCqmRAnu+p5clYnV1G7CedH
 Ywe2e5ym3BCk0TknzyFICd2HvgF/RPJzseQCp0OTrq+5+p353d2dKNrTiPpdz8EPo0k=
X-Gm-Gg: Acq92OHq93CfL67DnTXEgusZyznCMdJBASNA8inNwnFKfOOJh+JeukQwFOLFQwnmZ6C
 eZabIOaK+XbDeZ1HXf1FT9UbmijmTAeVLa7NKZr77V+NXrGVut2wp12DMT3Cl9xyNJ66103a96w
 /xR1eYU6jVsz3v9ucf0RVPMAT4uBDORLpHr5k9b0kQ7VbnY5OUxxmcpmTi7XLc5LGyLkhp1DRGS
 p+NX+zUjHtvqH1XKORHMerXHTzA4arfZyp58SSzFJDfiBnzHnmsaPBBhMIQH2zTVApNwB4r0r3W
 F9/P0EX2vsOJvbdJVx9BrP0gHkvoQB/NPnMg8BtyEuDmpHUjqGTtjswPvy8O8oBE0Y/VfxZPXkL
 UZW55sIx/bhNSm1VZ2/mUZEO5wOtw/lvEMKI+2n0RYyaw73xVJE+j8k/aBq3D6At26VHo/YvC90
 rSwuKAQ8ZWS6BdcbnjpmecCjvzJv11f3We9j+pt8C0DHqXG2rIcp9p2CknFqvc7fyk9JvBry+jd
 QKKus4lz437OqEHuKJLPXI=
X-Received: by 2002:a05:6a00:ad88:b0:82c:9e00:f958 with SMTP id
 d2e1a72fcca58-842b06e2301mr9811450b3a.0.1780801014783; 
 Sat, 06 Jun 2026 19:56:54 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1909097-ipxg00g01sizuokaden.shizuoka.ocn.ne.jp. [153.129.9.97])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-84282372a16sm16446789b3a.18.2026.06.06.19.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 19:56:54 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: u-boot@lists.denx.de,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH] xyz-modem: Select CRC16
Date: Sun,  7 Jun 2026 11:56:50 +0900
Message-ID: <20260607025650.3599544-1-daniel@thingy.jp>
X-Mailer: git-send-email 2.53.0
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

CONFIG_LOADB causes the xyzModem code to get built and that code depends
on CONFIG_CRC16. If you don't have something else that selects CONFIG_CRC16
you can unselect it and then the final link will fail:

  LD      u-boot
/usr/bin/m68k-linux-gnu-ld.bfd: common/xyzModem.o: in function `xyzModem_get_hdr':
u-boot/common/xyzModem.c:388:(.text.xyzModem_get_hdr+0x17a): undefined reference to `crc16_ccitt'

Since SPL/TPL can also use the xyzModem code create a Kconfig symbol for
it, select CONFIG_CRC16 there and then select the new symbol from all of
the users.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 cmd/Kconfig            | 1 +
 common/Kconfig         | 6 ++++++
 common/Makefile        | 3 +--
 common/spl/Kconfig     | 1 +
 common/spl/Kconfig.tpl | 1 +
 5 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c71c6824a196..7e6044bad952 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1412,6 +1412,7 @@ config CMD_W1
 config CMD_LOADB
 	bool "loadb"
 	default y
+	select YMODEM
 	help
 	  Load a binary file over serial line.
 
diff --git a/common/Kconfig b/common/Kconfig
index 8e8c733aa295..5eafe05047dc 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1274,3 +1274,9 @@ config IO_TRACE
 	  confirm that the driver behaves the same way before and after a code
 	  change. To add support for your architecture, add '#include
 	  <iotrace.h>' to the bottom of arch/<arch>/include/asm/io.h and test.
+
+config YMODEM
+	bool
+	select CRC16
+	help
+	  Enable xyzModem library code
diff --git a/common/Makefile b/common/Makefile
index d62ea34599ed..bd809e2f34e9 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -99,8 +99,7 @@ obj-$(CONFIG_$(PHASE_)LOG) += log.o
 obj-$(CONFIG_$(PHASE_)LOG_CONSOLE) += log_console.o
 obj-$(CONFIG_$(PHASE_)LOG_SYSLOG) += log_syslog.o
 obj-y += s_record.o
-obj-$(CONFIG_CMD_LOADB) += xyzModem.o
-obj-$(CONFIG_$(PHASE_)YMODEM_SUPPORT) += xyzModem.o
+obj-$(CONFIG_YMODEM) += xyzModem.o
 
 obj-$(CONFIG_$(PHASE_)AVB_VERIFY) += avb_verify.o
 obj-$(CONFIG_$(PHASE_)STACKPROTECTOR) += stackprot.o
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 5fa94098e498..2bd413cbdf12 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1655,6 +1655,7 @@ config SPL_WATCHDOG
 config SPL_YMODEM_SUPPORT
 	bool "Support loading using Ymodem"
 	depends on SPL_SERIAL
+	select YMODEM
 	help
 	  While loading from serial is slow it can be a useful backup when
 	  there is no other option. The Ymodem protocol provides a reliable
diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
index a535b61ecd35..7ab4666d3705 100644
--- a/common/spl/Kconfig.tpl
+++ b/common/spl/Kconfig.tpl
@@ -336,6 +336,7 @@ config TPL_DM_SPI_FLASH
 config TPL_YMODEM_SUPPORT
 	bool "Support loading using Ymodem"
 	depends on TPL_SERIAL
+	select YMODEM
 	help
 	  While loading from serial is slow it can be a useful backup when
 	  there is no other option. The Ymodem protocol provides a reliable
-- 
2.53.0

