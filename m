Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D4BC3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 05:23:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABF1082CA4;
	Tue, 20 May 2025 07:22:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="haj083N7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B319482CA4; Tue, 20 May 2025 07:22:28 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB39382BD7
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:22:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a361b8a664so3654046f8f.3
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 22:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747718546; x=1748323346; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=myAQLnNyoEYgTL9thFBm6JVTMfd0yPZIgdnmPcYkCAg=;
 b=haj083N7qZ653hN0FtKx+XJV4GjSRV1+HfEmwGeRu8enYWRljQEzuURVKYSQpyvCJJ
 MJO99dG4yMi58KrzBGlpbtDgjlOjGE9ttICRYWa4wLQ9Dc9Zhoym5s6zmLHeNJbDw9I/
 gGVzMW6dfAN/x279F9ZVTeRLqQ1AcBz4NoVebFNHNBtbRzfee7fPBX9Z5mXCi7mkns5B
 lQA1l0Ho3370283AVy9X/SNzXEoDApRaz7nIQJtw78xViqKvu5c3msMKCOuHwV8wjnUu
 xX6z/GQ+eVNJdkwfwhBR34XcHW8qR4MRMQOGX86xcXoEQdK8fkS5nnNx5B3xJDYyrICW
 Tp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747718546; x=1748323346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=myAQLnNyoEYgTL9thFBm6JVTMfd0yPZIgdnmPcYkCAg=;
 b=Vpov/+eLxswwOpIcSpSVT5+qS6zBd+M2KEg0NOfd18pVzK+cU7gJ0hzYA1XP1FeN/5
 AefO930RTt7UiaUmcpK8sj2RCv/U6ImUZg+VgPI0/kjTwq81VxZP4pxcojkl/18QNFkv
 i8Z0y0FZy1LMS4pgU75B0qp71IWTgoeNbN71SDLgmhnHAAt9jKYShb8BwVp8weWsQIl9
 eJuNEvMTJ/Ph0B8e9oOVjhzN2prehNbi8JB5QMdw8gqjzhrn5zoj7gPwpTl1sYaQDk2a
 3/jEtXQXE1rml/0zOnGxkikkhozmGU7wb2G+UoUSfU09kPfDruJykaHlhS36Fb/rvRWJ
 Hc/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjF6YSsTs83n7XGHjqqllldqZICroaSXhCKxs9qMRG/Yqhr2GXq9j+kHFxvUv52mQw+NEwKJs=@lists.denx.de
X-Gm-Message-State: AOJu0YwMff6+35ZgVihpFiZ8il/g3FUW+DTiSOyVFqO+Rjoi67Q35x63
 EI59JaKXPupZB6cATUYsW068fmUHXZD2/ISCGQPpvftLke4H3yx1SoUmSyJ4bo925H0=
X-Gm-Gg: ASbGncujH8FYaLXgU2aJbsoBIlEk0PLQTwL6QmxtrPy1SVIi3Z1cCLh0zKw2FzaqAPj
 kKOVYnCFWQ/lS0C31dsrUeHlhdyegvsUip71RGy0hF43OVKniY0gtMko6+oCNEKiSH82+Q25Lqz
 nSRDGzDDN4Z2ehjuS3P4VdcXU5Bm5fspVvwQoQ21KjxSgSJOikOkD70NUbj0URsTieS8GZB8UnG
 31wUWyugrj2QmXi3NA61w4kdsOYPcl/iFMzZEkXNWARwGrqKM5otGwkYvyxw9CT2M8G1VzMB0Uf
 GIECfpXqkP6st4ZF1mBUPoOQs7JGJZukbL1XXAITyGDHi2tEKovAk2bZtkhVrZcDat8AXeZPIGc
 =
X-Google-Smtp-Source: AGHT+IFWTCHfLCMG7g3dMSP5QJL9aXG+ND8ZvecNdexiaThlfqmmn1DAwppTWH0Db1Tumc3IsEvm+g==
X-Received: by 2002:a05:6000:430c:b0:3a3:6947:6d35 with SMTP id
 ffacd0b85a97d-3a369477158mr7580078f8f.57.1747718546170; 
 Mon, 19 May 2025 22:22:26 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm15100762f8f.71.2025.05.19.22.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 22:22:25 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH 11/24] kbuild: let fixdep directly write to .*.cmd files
Date: Tue, 20 May 2025 08:21:22 +0300
Message-ID: <20250520052153.307194-12-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
References: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
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

Backport from kernel
commit 392885ee82d3 ("kbuild: let fixdep directly write to .*.cmd files")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile               | 13 +++++--------
 scripts/Kbuild.include |  5 ++---
 scripts/Makefile.build | 11 +++++++----
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index 15c7e633b874..09d36b8cbbed 100644
--- a/Makefile
+++ b/Makefile
@@ -2538,14 +2538,11 @@ quiet_cmd_rmdirs = $(if $(wildcard $(rm-dirs)),CLEAN   $(wildcard $(rm-dirs)))
 quiet_cmd_rmfiles = $(if $(wildcard $(rm-files)),CLEAN   $(wildcard $(rm-files)))
       cmd_rmfiles = rm -f $(rm-files)
 
-# read all saved command lines
-
-cmd_files := $(wildcard .*.cmd)
-
-ifneq ($(cmd_files),)
-  $(cmd_files): ;	# Do not try to update included dependency files
-  include $(cmd_files)
-endif
+# read saved command lines for existing targets
+existing-targets := $(wildcard $(sort $(targets)))
+cmd_files := $(foreach f,$(existing-targets),$(dir $(f)).$(notdir $(f)).cmd)
+$(cmd_files): ;        # Do not try to update included dependency files
+-include $(cmd_files)
 
 endif    #ifeq ($(config-targets),1)
 endif    #ifeq ($(mixed-targets),1)
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 2ef687ea895a..6ef66c451eb1 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -274,9 +274,8 @@ if_changed_dep = $(if $(strip $(any-prereq) $(arg-check) ),                  \
 
 cmd_and_fixdep =						             \
 	$(echo-cmd) $(cmd_$(1));                                             \
-	scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(dot-target).tmp;\
-	rm -f $(depfile);                                                    \
-	mv -f $(dot-target).tmp $(dot-target).cmd;
+	scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(dot-target).cmd;\
+	rm -f $(depfile)
 
 # Usage: $(call if_changed_rule,foo)
 # Will check if $(cmd_foo) or any of the prerequisites changed,
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index d90b0b7aa6a0..2f2d5d4afc25 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -410,14 +410,17 @@ FORCE:
 # optimization, we don't need to read them if the target does not
 # exist, we will rebuild anyway in that case.
 
-cmd_files := $(wildcard $(foreach f,$(sort $(targets)),$(dir $(f)).$(notdir $(f)).cmd))
+existing-targets := $(wildcard $(sort $(targets)))
 
-ifneq ($(cmd_files),)
-  include $(cmd_files)
-endif
+-include $(foreach f,$(existing-targets),$(dir $(f)).$(notdir $(f)).cmd)
 
 # Create directories for object files if they do not exist
 obj-dirs := $(sort $(obj) $(patsubst %/,%, $(dir $(targets))))
+# If targets exist, their directories apparently exist. Skip mkdir.
+existing-dirs := $(sort $(patsubst %/,%, $(dir $(existing-targets))))
+obj-dirs := $(strip $(filter-out $(existing-dirs), $(obj-dirs)))
+ifneq ($(obj-dirs),)
 $(shell mkdir -p $(obj-dirs))
+endif
 
 .PHONY: $(PHONY)
-- 
2.49.0

