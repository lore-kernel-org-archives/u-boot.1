Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E924CC25B47
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 07:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA64787BF7;
	Fri, 27 Oct 2023 09:44:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LAuU9NJf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E847087BF5; Fri, 27 Oct 2023 09:44:50 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A64AC87BEE
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 09:44:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5b837db1b26so1397621a12.3
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 00:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698392686; x=1698997486; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HHpu+Rm8ojqopyFmvZoFwWv23QDMSH1Pwduu0kJ4/lE=;
 b=LAuU9NJfakCRl72n4yOjhY8zVJ6TjNmsI4ZnbYT5JUaAQOrYC+Jsy7+KuoApAOMRZQ
 XzklDtFhEJ1Lp1mSZs+wPohBBd+GvkOhseBPo78xzo+4O/g2ItcLWs98DCDmBbvxHzVJ
 yyP4saS1c5ky6c524zqG1BMRL5r9/ZIcvJFKNGI9ql/wXxbIKjyfnwAfgxeOnKe52xrQ
 Bs+n/CbN6P9k9vQS/UOp+8CiEbpEYktjdesOepWlJKdUTQkeobKCbG2dTFXX/23HYFHM
 92VGKZ+FFWpxrmOeNMVHp9RCmmjjQoz29QkRrMSrgqIVVr+0iQDZZ/4z6JGmrNUzYkap
 EFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698392686; x=1698997486;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HHpu+Rm8ojqopyFmvZoFwWv23QDMSH1Pwduu0kJ4/lE=;
 b=Suc3N98uxL/+mG312ydfyPlHjycfT+WWqKBS/LplAueDusQiofi58ff3DNfkUvf1hY
 /MrBXogmQJmS3iXeehr+E3g3XqynHRw6nB5UoiKosrNk8Da9l/bAz3vKpeTPREj1UvMM
 tf9/Z/M1+YZIIyXoiygW8mwr3GD8K6azXAvSOFT3LtypgzH0NZI2UzV/iejxGXSrgnQ1
 FHRL5+jz21zKYqSaJQLPFLb8F7IGmbD8/unCWU41dXguqJVx2cf4ZANG40VXslI2xfMQ
 juIDB6sUCjEar0skal85yRhM/eX6QWEMZAUZD8GPiy9irc2TSEJMNz3vDcwy+CKOdLK/
 sEAA==
X-Gm-Message-State: AOJu0Yx12jSWjSC067DjpY78/x/uMprTmKECZBY8u1ckBWJtFOKusFSD
 KoZ4o2C44qwIXjT+pU+7XTj34xP+q9WI2fa+nSA=
X-Google-Smtp-Source: AGHT+IFFk75FZpDvaMig8z2RUtijmOvfG/dLJ/f0fC9dYnd3hbNy9FD4F6bmWuhiyrl9PWEumC5GVQ==
X-Received: by 2002:a17:90a:709:b0:27d:4d6d:8379 with SMTP id
 l9-20020a17090a070900b0027d4d6d8379mr1457646pjl.48.1698392686591; 
 Fri, 27 Oct 2023 00:44:46 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 gt1-20020a17090af2c100b0026b3f76a063sm654937pjb.44.2023.10.27.00.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 00:44:45 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH] scripts/Makefile.lib: print error when no public key is
 specified
Date: Fri, 27 Oct 2023 16:43:26 +0900
Message-Id: <20231027074326.3357618-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The current build system embeds the EFI Signature List(ESL)
into the dtb to be used in the EFI capsule authentication.
This ESL file is specified through the CONFIG_EFI_CAPSULE_ESL_FILE
Kconfig option. If CONFIG_EFI_CAPSULE_ESL_FILE is not specified,
U-boot build ends up with failure but the cause of failure is not
easily understandable. Current error message is as follows.

FATAL ERROR: Error reading file into data: Is a directoryCheck /home/ubuntu/src/ledge/u-boot/arch/arm/dts/.synquacer-sc2a11-developerbox.dtb.pre.tmp for errors
make[2]: *** [scripts/Makefile.lib:355: arch/arm/dts/synquacer-sc2a11-developerbox.dtb] Error 1
make[1]: *** [dts/Makefile:44: arch-dtbs] Error 2
make: *** [Makefile:1165: dts/dt.dtb] Error 2
make: *** Waiting for unfinished jobs....

This commit shows the error message that CONFIG_EFI_CAPSULE_ESL_FILE
must be specified when the EFI capsule authentication is enabled, then
terminate the build with error.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 scripts/Makefile.lib | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 8dc6ec82cd..16bbc277a9 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -339,7 +339,12 @@ cmd_capsule_esl_gen = \
 	$(shell sed "s:ESL_BIN_FILE:$(capsule_esl_path):" $(capsule_esl_input_file) > $@)
 
 $(obj)/.capsule_esl.dtsi: FORCE
+ifeq ($(CONFIG_EFI_CAPSULE_ESL_FILE),"")
+	$(error "CONFIG_EFI_CAPSULE_ESL_FILE is empty, EFI capsule authentication \
+	public key must be specified when CONFIG_EFI_CAPSULE_AUTHENTICATE is enabled")
+else
 	$(call cmd_capsule_esl_gen)
+endif
 
 capsule_esl_input_file=$(srctree)/lib/efi_loader/capsule_esl.dtsi.in
 capsule_esl_dtsi = .capsule_esl.dtsi
-- 
2.34.1

