Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DA3CF6495
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 01:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BA9988EF9;
	Mon, 30 Sep 2024 03:51:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ifE0mQKo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF72B88F04; Mon, 30 Sep 2024 03:51:01 +0200 (CEST)
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7681388F30
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x144.google.com with SMTP id
 e9e14a558f8ab-3a275a7649dso13869475ab.2
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661046; x=1728265846; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D6r/1UW/KMsXVCGYuHt51qXUMKcIwJt8UNbm14lPuhk=;
 b=ifE0mQKovqEv14EJ9LDqBm0h6NDLcxRM4tEajKtgghVj3QSJ5bHsewolyDOwrDxzKg
 Q0akDuMuGVCJ7X4x4NE7iWGECRErwte8f4jofpiVxgAx/+6AAxyBV43Zlu978ZBgvDXC
 LSs5ePqr/5eirfHDPrAOSoQu8TMU4XNIJhT38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661046; x=1728265846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D6r/1UW/KMsXVCGYuHt51qXUMKcIwJt8UNbm14lPuhk=;
 b=p7FvhPKpK3DvZ6BbhYVVjThlg/0ecxhpwDbcW3Agxs3VTkoBsRVpsjCzxwwMkSIpDd
 pkmfPYHhmeDLPWfqB8ErU2EwtC1wCgQTc+1EuTWY2hMfhwU6jrW0uOhccJWFCjZf5G2f
 l0t752Rc2NMlfvPgNPn36LAXPk1CBFQ+PDf7EwNZY1schu4CDj41kyPaCwoIl1K4Eyns
 VWZtcH8QNrJ8Lq5Y08rTkrb6M5ky4JgYfm3mrx82PPOwmIZUKPCOO9FPNYa21yXApPnk
 svlq7ylChlA0LO1hK9CBKFThRDRQF0quT0yY9ZP45zp05qWjKGZ+/VcbqxcbFRQQGWwF
 4ffg==
X-Gm-Message-State: AOJu0YxQw9TLgO4YP0BSD8xHQeqRpkAiMPUUfjNwbVDSmon32tAcUYEd
 yNDQxrQD7xb3QlMQFNr/B9zwQVna7g6+tGffQaV1vUw2e5oT9ruYp2kQbSj3/OOjJOZ/oDkua6J
 uczTn
X-Google-Smtp-Source: AGHT+IFbSExoI6s8No+MZRgQSgjSTvEReaEmCSkaGaS2ypnCsHmSnc+trxWO5H5ki6YjaspJGNBUjQ==
X-Received: by 2002:a05:6e02:2188:b0:3a0:9088:e2a4 with SMTP id
 e9e14a558f8ab-3a3452bee09mr70940755ab.21.1727661046020; 
 Sun, 29 Sep 2024 18:50:46 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bryan Brattlof <bb@ti.com>, Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH v3 28/33] xpl: Define CONFIG_SPL_BUILD only for the SPL build
Date: Sun, 29 Sep 2024 19:49:51 -0600
Message-Id: <20240930014956.1434060-29-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
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

Make this define mean SPL only, not TPL, VPL, etc.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 scripts/Makefile.autoconf | 4 ++--
 scripts/Makefile.xpl      | 7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.autoconf b/scripts/Makefile.autoconf
index d7544022a31..c1eab2f3a1d 100644
--- a/scripts/Makefile.autoconf
+++ b/scripts/Makefile.autoconf
@@ -87,11 +87,11 @@ spl/u-boot.cfg: include/config.h FORCE
 
 tpl/u-boot.cfg: include/config.h FORCE
 	$(Q)mkdir -p $(dir $@)
-	$(call cmd,u_boot_cfg,-DCONFIG_XPL_BUILD -DCONFIG_SPL_BUILD -DCONFIG_TPL_BUILD)
+	$(call cmd,u_boot_cfg,-DCONFIG_XPL_BUILD -DCONFIG_TPL_BUILD)
 
 vpl/u-boot.cfg: include/config.h FORCE
 	$(Q)mkdir -p $(dir $@)
-	$(call cmd,u_boot_cfg,-DCONFIG_XPL_BUILD -DCONFIG_SPL_BUILD -DCONFIG_VPL_BUILD)
+	$(call cmd,u_boot_cfg,-DCONFIG_XPL_BUILD -DCONFIG_VPL_BUILD)
 
 include/autoconf.mk: u-boot.cfg
 	$(call cmd,autoconf)
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index 08453f0b415..b43ff998679 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -21,9 +21,10 @@ include $(srctree)/scripts/Kbuild.include
 
 -include include/config/auto.conf
 
-# This file contains 0, 2 or 3 lines
+# This file contains 0, or 2 lines
 # It is empty for U-Boot proper (where $(obj) is empty)
-# For any xPL build it contains CONFIG_SPL_BUILD=y and CONFIG_XPL_BUILD=y
+# For any xPL build it contains CONFIG_XPL_BUILD=y
+#    - for SPL builds it also contains CONFIG_SPL_BUILD=y
 #    - for TPL builds it also contains CONFIG_TPL_BUILD=y
 #    - for VPL builds it also contains CONFIG_VPL_BUILD=y
 -include $(obj)/include/autoconf.mk
@@ -31,7 +32,9 @@ include $(srctree)/scripts/Kbuild.include
 UBOOTINCLUDE := -I$(obj)/include $(UBOOTINCLUDE)
 
 KBUILD_CPPFLAGS += -DCONFIG_XPL_BUILD
+ifeq ($(CONFIG_SPL_BUILD),y)
 KBUILD_CPPFLAGS += -DCONFIG_SPL_BUILD
+endif
 ifeq ($(CONFIG_TPL_BUILD),y)
 KBUILD_CPPFLAGS += -DCONFIG_TPL_BUILD
 else
-- 
2.34.1

