Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9219CF6493
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 20:01:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9886E88AE8;
	Sat, 28 Sep 2024 22:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="grMPKP4X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2255788BEF; Sat, 28 Sep 2024 22:00:45 +0200 (CEST)
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AC44889C5
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 22:00:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x142.google.com with SMTP id
 e9e14a558f8ab-3a0c8c40560so15081595ab.2
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 13:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727553641; x=1728158441; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jRTeZP9TMaov+zTWAcge6tU8S67wWX9qBgffb7szHyU=;
 b=grMPKP4X3SDWv7atw+6HMKSC9wZz15QtW7p34w2yPwPwKIzdqTdkByHhWw/yi2tOw4
 qHCpBe2BhJ0N3Hrdezis7C+23HD2H9PgqtjQaB6fiZigZN3N3wipzxzTTZ38m/PCPjH8
 DPZTDu/7LVoR7CCW+MW8NdsiCGhWd0yoBc0AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727553641; x=1728158441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jRTeZP9TMaov+zTWAcge6tU8S67wWX9qBgffb7szHyU=;
 b=KC4USdXe3FMQrrYkQBcUk7jqOutkwI9ccHkP85SiDMSuQh6Krn10avY44ykkLNqkN8
 dQkPduKY4GoJM18YsNy7g3EHSRxun4s/FIcggC5KUYNlqOs2JShOajPnwt+jMLNhqu8a
 IgLhLhzhIu85ssrcRa1M5NPVD+Z67J3uMzXNYlO00kWu1cEG76ZZ7CPAnX/C1TPFOFk5
 XRakfz0DA0T9WYG4NtqRzVuDcM9XF0sU3Pmv8uzhQdg5X66QF/pcc1xkp01OxQHn83Qy
 poyBVqKOBeVbAie5ge/sHcGRCRnpu0t5LLB1jTRgw5lqeSIr/pDMK9RTjj/LQrZ51PkA
 jVXw==
X-Gm-Message-State: AOJu0YxamqClNzGCrhRhp0z0ls4EaRLD6PRe2+SwFmij+pP/yW7kkxJ6
 4MkwBd2rRM7nMPrGMn5aL98cjzD+QtsUrSphNUyWgS4WDo2T4vPCu+gsp8XDzVX9Fj+vNPosAQU
 LL/tU
X-Google-Smtp-Source: AGHT+IFT43VCVi1Ki3BED7tXECCIUSpcF+CvSvxhEH9SF/2nuIALDvlQRTEQRrn/muQrDlOcEjkowA==
X-Received: by 2002:a05:6e02:20ce:b0:3a2:91f:497b with SMTP id
 e9e14a558f8ab-3a34517e85dmr58342315ab.13.1727553641418; 
 Sat, 28 Sep 2024 13:00:41 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888835307sm1242590173.2.2024.09.28.13.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 13:00:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bryan Brattlof <bb@ti.com>, Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nishanth Menon <nm@ti.com>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 03/30] scripts: Add some comments about autoconf.mk
Date: Sat, 28 Sep 2024 14:00:03 -0600
Message-Id: <20240928200030.194546-4-sjg@chromium.org>
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

Now that the conversion of all CONFIG options to Kconfig is complete,
these files only contain the xPL_BUILD defines. Add a comment to make
this clear.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 scripts/Makefile.xpl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index 1868f1beef6..3091311a3d2 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -20,6 +20,12 @@ _dummy := $(shell [ -d $(obj) ] || mkdir -p $(obj))
 include $(srctree)/scripts/Kbuild.include
 
 -include include/config/auto.conf
+
+# This file contains 0, 1 or 2 lines
+# It is empty for U-Boot proper (where $(obj) is empty)
+# For any xPL build it contains CONFIG_SPL_BUILD=y
+# For TPL builds it has CONFIG_SPL_BUILD=y and CONFIG_TPL_BUILD=y
+# For VPL builds it has CONFIG_SPL_BUILD=y and CONFIG_VPL_BUILD=y
 -include $(obj)/include/autoconf.mk
 
 UBOOTINCLUDE := -I$(obj)/include $(UBOOTINCLUDE)
-- 
2.34.1

