Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1896C54E71
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 02:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15C29880A8;
	Wed, 20 Mar 2024 03:18:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="dk8pUQuN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 639CD8808B; Wed, 20 Mar 2024 03:18:37 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA8238808F
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 03:18:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-609f359b7b1so73583287b3.1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 19:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1710901112; x=1711505912;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=spEbaOvTu8JBGlszRtOzMPxGz0VKc8utZk9uv4RjvRc=;
 b=dk8pUQuNWsv69zSEaDlENdBpHj/IZYXnJDS3xYWKGLy+HmctXzOpsKZUsHjFpLwQBq
 q/+cFmCN7pWKmx6YIxMI/PXrYEG/WWHFQh1PqVAcD1IfrPbZ3+jKoNBsSjD6Hp7bvs33
 e79229eniAxr7LpEAKv8Fxg2phN4ijy7r2eGEpVqzHLhfvknCB4XbxHFA4OSgEG2UjfG
 T64PB+BgyQ+BgOmMEG+L59TzzqipsjLepRlZ8+yiS8xWKtLWG1pwEMU/+34qSHyKk0I3
 wyCY8dSm0i62/f93iWy2sM/CL+SYUW3nTufPZ5IARIbsV4Oikc+TvnNzUzCZXaS4jo34
 mGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710901112; x=1711505912;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=spEbaOvTu8JBGlszRtOzMPxGz0VKc8utZk9uv4RjvRc=;
 b=LJdSrGsm67yKitE3MqK+D7TjUtmnNIHJmvlZ2iEQLvAst453Xvx/ygeC/CS4NPil7u
 IhC6HH9P30KDUcnWk/dD0g0fUuumAT1eoe7richeYznvVzleEWLk73btGB9URq0Br+yY
 141KpZcsUsipLemnOTyuvekNvZFN+/EYZeT3F1YPW1d0cetZ2PbaCRs+QPYHxQ6f/li3
 5ZjlBxbEGsQU2NcU4MV7bBTg9xHXXToqw6UgTkyjM9QlOaXVhkV/8vUcwacjSH3zhJGI
 i8net9ASxuLf0hht1y8+bfC/GA3uRvMFcWb4tSaBkBGnTGNM+Gor661hBZ+8X3N9MfNa
 TT1A==
X-Gm-Message-State: AOJu0YxSQ0r5DIinNavX3SMUHGu5saLoZq2r24ud8AVpHT4CnqeWihiZ
 +3PiVqHgB0M7uqrkKJlPlCUEHSdayORozlrEnc+lx2ROmUVC5HfrHQnJjgCpD9PGHNLItxM8/0K
 GOg==
X-Google-Smtp-Source: AGHT+IE6kS2hnRKHvhHUWDe22oRxORxh3UJBjlnAqjLdQuXC1wLl7hyRMiBVtzS8ZvWeJOzrIX2j3g==
X-Received: by 2002:a0d:c704:0:b0:608:e133:7ece with SMTP id
 j4-20020a0dc704000000b00608e1337ecemr5132257ywd.36.1710901112377; 
 Tue, 19 Mar 2024 19:18:32 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 u69-20020a0deb48000000b0060a5422ce26sm2653949ywe.116.2024.03.19.19.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 19:18:31 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de
Cc: Greg Malysa <greg.malysa@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Shengyu Qu <wiagn233@outlook.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] build: Revive and update LDR format support
Date: Tue, 19 Mar 2024 22:16:07 -0400
Message-Id: <20240320021607.9518-1-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.38.2
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

LDR format files are used primarily by Analog Devices processors but may
be of interest to other vendors. Previously support existed for this
format as part of the U-Boot build, but it has been unmaintained and
unused for a long time. In preparation for adding support for modern ADI
processors that use LDR, modernize the LDR support:

- Introduce CONFIG_LDR_CPU as the CPU string recognized by the LDR tool
  may not be the same as CONFIG_CPU
- Add an SPL target that repackages u-boot-spl inside an LDR file

An almost identical target for packaging u-boot into an LDR file already
exists and did not need to be created.

Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>

---

Changes in v2:
 - Add HAS_LDR prerequisite to avoid prompting for LDR_CPU on unrelated
   platforms
 - Fixed accidentally moving 'source "api/Kconfig"' which is unrelated
   to this patch


---
 Kconfig              | 14 ++++++++++++++
 Makefile             |  2 +-
 scripts/Makefile.spl |  5 +++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index 5710934000..bccacb773a 100644
--- a/Kconfig
+++ b/Kconfig
@@ -715,6 +715,20 @@ config SYS_CLK_FREQ
 	  A static value for the CPU frequency.  Note that if not required
 	  for a given SoC, this can be left at 0.
 
+config HAS_LDR
+	bool
+	help
+	  Enables building .ldr targets for U-Boot and SPL. This does not
+	  automatically build any additional targets with make or buildman.
+
+config LDR_CPU
+	string "CPU name to be passed to LDR utility."
+	depends on HAS_LDR
+	help
+	  Set the CPU name for the -T parameter in the LDR utility.  This is
+	  generally used on processors from Analog Devices, but may be also
+	  be useful for other vendors.
+
 source "api/Kconfig"
 
 endmenu		# General setup
diff --git a/Makefile b/Makefile
index a2bc9d5903..db3272a439 100644
--- a/Makefile
+++ b/Makefile
@@ -1328,7 +1328,7 @@ u-boot-nodtb.bin: u-boot FORCE
 
 u-boot.ldr:	u-boot
 		$(CREATE_LDR_ENV)
-		$(LDR) -T $(CONFIG_CPU) -c $@ $< $(LDR_FLAGS)
+		$(LDR) -T $(CONFIG_LDR_CPU) -c $@ $< $(LDR_FLAGS)
 		$(BOARD_SIZE_CHECK)
 
 # binman
diff --git a/scripts/Makefile.spl b/scripts/Makefile.spl
index 407fc52376..58d6a452e5 100644
--- a/scripts/Makefile.spl
+++ b/scripts/Makefile.spl
@@ -381,6 +381,11 @@ $(obj)/$(BOARD)-spl.bin: $(obj)/u-boot-spl.bin
 	$(objtree)/tools/mkexynosspl) $(VAR_SIZE_PARAM) $< $@
 endif
 
+$(obj)/u-boot-spl.ldr: $(obj)/u-boot-spl
+	$(CREATE_LDR_ENV)
+	$(LDR) -T $(CONFIG_LDR_CPU) -c $@ $< $(LDR_FLAGS)
+	$(BOARD_SIZE_CHECK)
+
 quiet_cmd_objcopy = OBJCOPY $@
 cmd_objcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $(OBJCOPYFLAGS_$(@F)) $< $@
 
-- 
2.38.2

