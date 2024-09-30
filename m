Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B52CF6498
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 01:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5E0A88E2D;
	Mon, 30 Sep 2024 03:50:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZD/bbBqx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EDB388DD4; Mon, 30 Sep 2024 03:50:25 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27A7388DCC
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-82cec47242eso156862039f.0
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661014; x=1728265814; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Q4n9fIwwJuzf7jg66heoCDb7szSn0cqODkLF135vew=;
 b=ZD/bbBqxg/ETIG8NNM3j+6YJbwMK3koVE2CPfKw7qVpFdk6ZyFV0fVuLlFZPEQ3JnP
 MnKIFL1rD1Z7e3DECS7jRsl3onboTBjSj2oCWyc9fviO58OQ8l+eCS1939d3WVUQE4Qm
 uWqwfdPbshJTl4oOFHbHtSUzdkYfiz4APrSl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661014; x=1728265814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Q4n9fIwwJuzf7jg66heoCDb7szSn0cqODkLF135vew=;
 b=CNzzGrVuDi4fuFb2tLWjz6xVmqepGD0KKJteJ6NdniL7E+6CzDh1lsgScRklwJvC2O
 ISiBiycfK2cI/REovaVF6J9Tts7VRmlrsz1vi45bNZkQajrDrdTJ5R6MsaFHTYIDDSSX
 3TS8gQunOOU5gQJ5dpVh7CKZ14zJwKRlIhgQ7M8+e7pjuEXWs0IjThcqnCIiSx/mzvEU
 jwWjOAttSJyDKZ/uLeLyS3JSUdHg1rodO8g3GZ+lNBwc+IMqsm4EJdgBVAjMHtJg/sXA
 vurZLApz5KD+RcTdW+b4tRoRBy8asjNFFbfKp7rlisfZEnp0DwWRW3fcdNQs2YHicqlw
 dq8A==
X-Gm-Message-State: AOJu0YzDgX77Q0QfEK7qRFB009hxJVnaVr8gvl7ZmY+lcXfBINF82Q5J
 wBU/W6h38uIQS/EM6FqsDMy2pjrJoprsSeFcEGCDPZs8SQw/ptm49XBCpDPq7QZtaVJA9uQtZS+
 Q5w==
X-Google-Smtp-Source: AGHT+IFaueSLvHmGE0u53UmKfxwwyTXPN6uEqYxuV2qpoJGmhMZnhY7WyMU7fTmneCHxyxdj7xmsoA==
X-Received: by 2002:a05:6e02:1c89:b0:395:e85e:f2fa with SMTP id
 e9e14a558f8ab-3a3445ec40fmr86441585ab.1.1727661013751; 
 Sun, 29 Sep 2024 18:50:13 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bryan Brattlof <bb@ti.com>, Greg Malysa <greg.malysa@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nishanth Menon <nm@ti.com>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 07/33] scripts: Rename Makefile.spl to Makefile.xpl
Date: Sun, 29 Sep 2024 19:49:30 -0600
Message-Id: <20240930014956.1434060-8-sjg@chromium.org>
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

