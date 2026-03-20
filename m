Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6192D1099B30
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 20:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 439DB84008;
	Fri, 20 Mar 2026 21:53:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L+mXBFSW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CEC283FF9; Fri, 20 Mar 2026 21:53:36 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E044A83FF9
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 21:53:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d1872504cbso2150183a34.0
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774040012; x=1774644812; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=fap3Fm2z06eQcbMy7Qltq5mgZZxfHMaxsnPAGvRSBDk=;
 b=L+mXBFSW0IouLDWLcA4GsIqssfoqBDbY7p8yZzQs6BPiWhWAUG1urKWwhpYgS/9ysw
 Ozf6BEw76REes0ex7MVhQTIFrG439ZQLQE+TTInzk6aE5AzHtVvs2cgJ0MTgMOJFv4bg
 VHplUEA0zu0vMnVrzD/3ESY56RjPkhsOSkD40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774040012; x=1774644812;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fap3Fm2z06eQcbMy7Qltq5mgZZxfHMaxsnPAGvRSBDk=;
 b=snxpg7PcJ2Op2uLwMX9rhILUVEmAUzbjJyyS142GUqKy4UVkLxMrMH5LCGdT8MCWyU
 F0KQBYKAOZ1PNMsfN6Q3LH5v0WaUDPfeAfAQUmlHzkR2AmztaMSGIS7YGf+eRRu/rpVY
 M1/xGoNAZZffqqiBaK1laIvm8Pvcyg1+WzWhaGIiK9nmpa80akZlDXZqeqiCNJpBOap8
 9cC3RAw0x5dQMjLx/0wUNbcyiz6QCudjtnVc7i9Scunz8ys2FALGxUdBnQnPVyCkIL3c
 UaGA31fciQe4BbDD+VgDXjEoUpIUmC92mI3xHHNAS/Y7TUpQi/d+YPhDhCIZRRY7uhKc
 hK9w==
X-Gm-Message-State: AOJu0YxHg8WqwSO3JQwBuZXg7x3iFI1qaCvnyj9jolwpraEqlgnpeitH
 9GqeVhTy8UQH2tl/krPj4yPBwy5ARyVuURBkZg9JgE+ntxIhiUA9K8/ajtDNSD9p9Z3Y4KwlpSW
 PfAA0XiI=
X-Gm-Gg: ATEYQzzJ6C5XGLdwKclAPVNvkw3jWvU67W0oRFVV0mhSju1RGCB6mZDnIJIPF0BguNI
 1Y1mcAWufaY6STrpIQ42SJ1QSAfbBGkqCsciUR0q6SnHiESZ9MLM3qAGJsA/LAglLxEywFcbhGP
 AtVI7yufPfSkco2NBuMJcXgPiZqlAN5nXgYIjHX+dSqo/RJiJFUWyswYG/0FG/cLlP82TGMfwj9
 W0c5sRYKL6YLYlbIY9mfP27O32q0GdtTbDK29JEZl6Vxs+1YCLsLGqfxMzHdwqlmAHhWi4IwKlY
 8CZCTB93UcAYTq1ZCxZu+SeVo6XYrEFUF1Bj2nDlrC4Agm5NnUT5HwAipA9gHHk+1zmXvMZCr7T
 b9zUYPBDuOGwCiei36FsOuudEnFCU5cRIJVD1fYg59U2STFi5moJINf3iauARQ9IvXo4JGzrfJ/
 i5m4kcT3tg9sOVj6zZpsYAg/mmWRBPmRfcIxJGyLkhsfHc6rXKVfdEySTmRvb3S6Nd7yhFfeSHx
 94GfsAGMnPGw8787fiBsYcAHiY2lWamW90YGKMGn2q0g5M2Tfs=
X-Received: by 2002:a05:6830:2713:b0:7d7:f73d:bd7f with SMTP id
 46e09a7af769-7d7f73dbde9mr1328519a34.5.1774040012555; 
 Fri, 20 Mar 2026 13:53:32 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac17471sm3257573a34.7.2026.03.20.13.53.31
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 13:53:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] rtc: Remove legacy DS1338 support
Date: Fri, 20 Mar 2026 14:53:31 -0600
Message-ID: <20260320205331.3788710-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The DS1338 RTC chip is supported in DM mode by the DS1307 driver, and at
this point all users have been using this functionality. It was a
function of Kconfig configuration that implied otherwise. Remove the
unused legacy symbols.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 configs/eb_cpu5282_defconfig          | 2 +-
 configs/eb_cpu5282_internal_defconfig | 2 +-
 drivers/rtc/Kconfig                   | 6 ------
 drivers/rtc/Makefile                  | 1 -
 4 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/configs/eb_cpu5282_defconfig b/configs/eb_cpu5282_defconfig
index e7a78b656a06..64e0267af91d 100644
--- a/configs/eb_cpu5282_defconfig
+++ b/configs/eb_cpu5282_defconfig
@@ -44,6 +44,6 @@ CONFIG_SYS_MAX_FLASH_SECT=128
 CONFIG_MCFFEC=y
 CONFIG_MII=y
 CONFIG_DM_RTC=y
-CONFIG_RTC_DS1338=y
+CONFIG_RTC_DS1307=y
 CONFIG_MCFUART=y
 CONFIG_WDT=y
diff --git a/configs/eb_cpu5282_internal_defconfig b/configs/eb_cpu5282_internal_defconfig
index 137b346e5699..cf25d24bf9d6 100644
--- a/configs/eb_cpu5282_internal_defconfig
+++ b/configs/eb_cpu5282_internal_defconfig
@@ -42,6 +42,6 @@ CONFIG_SYS_MAX_FLASH_SECT=128
 CONFIG_MCFFEC=y
 CONFIG_MII=y
 CONFIG_DM_RTC=y
-CONFIG_RTC_DS1338=y
+CONFIG_RTC_DS1307=y
 CONFIG_MCFUART=y
 CONFIG_WDT=y
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index ef1663f3450e..cb0a672668ea 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -81,12 +81,6 @@ config RTC_DS1337_NOOSC
 	bool "Enable support for no oscillator output in DS1337 driver"
 	depends on RTC_DS1337
 
-config RTC_DS1338
-	bool "Enable DS1338 driver"
-	help
-	  Support for Dallas Semiconductor (now Maxim) DS1338 and compatible
-	  Real Time Clock devices.
-
 config RTC_DS1374
 	bool "Enable DS1374 driver"
 	depends on !DM_RTC
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 9df373d51484..782f5a3bc3da 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -9,7 +9,6 @@ obj-$(CONFIG_$(PHASE_)DM_RTC) += rtc-uclass.o
 obj-$(CONFIG_RTC_ARMADA38X) += armada38x.o
 obj-$(CONFIG_RTC_DAVINCI) += davinci.o
 obj-$(CONFIG_RTC_DS1307) += ds1307.o
-obj-$(CONFIG_RTC_DS1338) += ds1307.o
 obj-$(CONFIG_RTC_DS1337) += ds1337.o
 obj-$(CONFIG_RTC_DS1374) += ds1374.o
 obj-$(CONFIG_RTC_DS1672) += ds1672.o
-- 
2.43.0

