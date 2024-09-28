Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21662CF6493
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 20:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30132889EF;
	Sat, 28 Sep 2024 22:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GXv7rBPT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDE9F88A47; Sat, 28 Sep 2024 22:00:43 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D0BC88BD2
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 22:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-82aac438539so160724439f.1
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 13:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727553640; x=1728158440; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Q4n9fIwwJuzf7jg66heoCDb7szSn0cqODkLF135vew=;
 b=GXv7rBPTzJC8gQN27EvvCEaI6aO1QBGx/bNq691m4x1YyVscQlsypkABDAKQwfUjBk
 uTWsu48yRkdPBAYLsxH0M8t7QKwDF0KgygNMC+cr8kfwCYJkzTGUnU8ooYnyZZVm4ZGU
 jMDnBZS4GcReVuIRzhI1ChC9eK4rwy8DlPB34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727553640; x=1728158440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Q4n9fIwwJuzf7jg66heoCDb7szSn0cqODkLF135vew=;
 b=RL21i6+Qg2XDpwD6Q25ZIt387RVZ1Ce1HF4rVfMsK5bB0Ru7JAUe9Pa+bzGTO9p+uq
 h7kf8/SL1hKiRxdmMQilig6mhNP8UL8Q/yumQ0pY1TNqMUBRb1VF0Ocwxp8gdjY2vuKT
 Xv+v2K6KIBOgKGuS2Z6qCSvnIq3VNOROm89eDcD8+6wSZJHwCRcbeu0sK0H1GDrh+MhW
 o29r9QpfLry0MqBkgfImPdi4j/YU+T5xP0ZrHxRYW6nM9upASDSn3vXaJnw8hN8QwkY3
 Lf6KJzyR6a24XaShdXdta60a7T2Kb4OHhxvS7aNMe/Kq2IqtnpN3OSJkI5QBSPzuE/af
 1QEg==
X-Gm-Message-State: AOJu0Yw05rXDhfaGX+0PTFF/L/e2cd7b71HNcUwiS+wRQBK0uw6i5C3I
 WhUJbazrwQq9DtWnBiuGcZrMeyJVoejiHQpprcIlYYtdS1G5WM+0B0BPfiep+dyrWbNGR7yrAtO
 SoA==
X-Google-Smtp-Source: AGHT+IH3/KO64OBvHHo6X9bbuf4k1QlAptAI7mokWs9VnhnvgT4+znFpnstDuxL4qSrYULGzpX3OuA==
X-Received: by 2002:a05:6e02:1d10:b0:3a0:4db0:ddbf with SMTP id
 e9e14a558f8ab-3a34515d316mr54722285ab.8.1727553639950; 
 Sat, 28 Sep 2024 13:00:39 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888835307sm1242590173.2.2024.09.28.13.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 13:00:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bryan Brattlof <bb@ti.com>, Greg Malysa <greg.malysa@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ian Roberts <ian.roberts@timesys.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nishanth Menon <nm@ti.com>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 02/30] scripts: Rename Makefile.spl to Makefile.xpl
Date: Sat, 28 Sep 2024 14:00:02 -0600
Message-Id: <20240928200030.194546-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928200030.194546-1-sjg@chromium.org>
References: <20240928200030.194546-1-sjg@chromium.org>
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

Rename this file to indicate that it refers to any non-U-Boot-proper
phase, not just SPL, which is the phase immediately before U-Boot
proper.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 Makefile                               | 6 +++---
 scripts/{Makefile.spl => Makefile.xpl} | 0
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename scripts/{Makefile.spl => Makefile.xpl} (100%)

diff --git a/Makefile b/Makefile
index 300cee2e7f6..4378993ccfd 100644
--- a/Makefile
+++ b/Makefile
@@ -2094,7 +2094,7 @@ spl/u-boot-spl-dtb.hex: spl/u-boot-spl
 	@:
 
 spl/u-boot-spl: tools prepare $(if $(CONFIG_SPL_OF_CONTROL),dts/dt.dtb)
-	$(Q)$(MAKE) obj=spl -f $(srctree)/scripts/Makefile.spl all
+	$(Q)$(MAKE) obj=spl -f $(srctree)/scripts/Makefile.xpl all
 
 spl/sunxi-spl.bin: spl/u-boot-spl
 	@:
@@ -2113,14 +2113,14 @@ tpl/u-boot-tpl.bin: tpl/u-boot-tpl
 	$(TPL_SIZE_CHECK)
 
 tpl/u-boot-tpl: tools prepare $(if $(CONFIG_TPL_OF_CONTROL),dts/dt.dtb)
-	$(Q)$(MAKE) obj=tpl -f $(srctree)/scripts/Makefile.spl all
+	$(Q)$(MAKE) obj=tpl -f $(srctree)/scripts/Makefile.xpl all
 
 vpl/u-boot-vpl.bin: vpl/u-boot-vpl
 	@:
 	$(VPL_SIZE_CHECK)
 
 vpl/u-boot-vpl: tools prepare $(if $(CONFIG_TPL_OF_CONTROL),dts/dt.dtb)
-	$(Q)$(MAKE) obj=vpl -f $(srctree)/scripts/Makefile.spl all
+	$(Q)$(MAKE) obj=vpl -f $(srctree)/scripts/Makefile.xpl all
 
 TAG_SUBDIRS := $(patsubst %,$(srctree)/%,$(u-boot-dirs) include)
 
diff --git a/scripts/Makefile.spl b/scripts/Makefile.xpl
similarity index 100%
rename from scripts/Makefile.spl
rename to scripts/Makefile.xpl
-- 
2.34.1

