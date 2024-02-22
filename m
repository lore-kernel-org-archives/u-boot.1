Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB29C48BF8
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 11:29:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE7E6880C0;
	Thu, 22 Feb 2024 12:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PttuxfBA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 582C087E6F; Thu, 22 Feb 2024 10:37:13 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30AE788087
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 10:37:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-59fe5b77c0cso822713eaf.0
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 01:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708594622; x=1709199422; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=14AzahfzBnDkKxuiQC/TmfvLbJfEMKHj6tMXkEc2j6g=;
 b=PttuxfBAySpuDM7bocQcjJv3iW6pQR3D4gaaFAry7w5SyNG/gv2U2owMEwaGLij6C6
 OGdYNMR0Ya5qZL9HQv6MtylGCl1nGTsjVBTQRvgZFgLuPPao1twSD1V700bpsB38yyi6
 08kW7bRa6yz9i82vi9u7KgZ3SMROWVqwKytkSGrmtSrb2xcFxu2buwFBSWpwzt7d6Vmu
 pg6h7fZnbtmYP28rDaqcxT/XMqTGTYWCqydiFVZFsccpuhEkunIqlvYwcBhw934HMy+E
 raER/+2Ub6JDDjhoKSl5e8pazX8O8QlFQN9H+uWRT38oGszRCgV2RaFMixJjtNwZZcl7
 e+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708594622; x=1709199422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=14AzahfzBnDkKxuiQC/TmfvLbJfEMKHj6tMXkEc2j6g=;
 b=wXvBPoLQYnw0Cjkdk0jwhPZs6LWvK76vsSgUmrrLUpxn210i+CcHDMVXMbNLO7io/N
 nmk+tp371rUIwirZ3DzlbgIqbgaSJz/2/2GMDJzWf+MgE3ScMx7wnh76VM2tvZCfhs/m
 NdP+fj6uPPIXujfy+u9nKold55fRr/hMmDGhjrgsYNAxhTBSJEEaFbpj3DuWp7sriKWk
 M/Xkmr+fSOYSr52XZbPHZUoU2R3VS/ukXHsQFQ82jEHC0Op665l6Gj7LHCFinbuRi56g
 DQrokeE2Hv+fIz+kUQ7UyLbDVoupUyv9WfzhoUWnCoy4TtFNXrkFp8LWxavesXyxZ5OE
 86Mw==
X-Gm-Message-State: AOJu0Ywmo/eWt68VGypNmQmLdUEO0ImLV59W6kDSU+0GzUdAPKslTz5V
 Q8vJuA5/bYKWkHnjHRwNUkab0HYmaLZ7CCR09dMeF6YMl0aeIwhoqLPWx/ZNcnH4z8CyKej4SaU
 a
X-Google-Smtp-Source: AGHT+IG0SmZv7NSGy2mX8SZMvvZaqP5W1n//57ZRFkeAZdKC65AyM8S3MWpyFeenn+7xslenkXWrRw==
X-Received: by 2002:a05:6359:412a:b0:17b:5a19:5366 with SMTP id
 kh42-20020a056359412a00b0017b5a195366mr5219350rwc.4.1708594622323; 
 Thu, 22 Feb 2024 01:37:02 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.115]) by smtp.gmail.com with ESMTPSA id
 u20-20020a056a00099400b006e47300e4edsm6208404pfg.183.2024.02.22.01.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 01:37:01 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com, bb@ti.com,
 mark.kettenis@xs4all.nl, festevam@gmail.com, nm@ti.com,
 andre.przywara@arm.com, ijc@hellion.org.uk, paul.barker.ct@bp.renesas.com,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 04/11] Makefile: Allow upstream DT subtree to provide DT
 includes
Date: Thu, 22 Feb 2024 15:06:00 +0530
Message-Id: <20240222093607.3085545-5-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222093607.3085545-1-sumit.garg@linaro.org>
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Feb 2024 12:24:08 +0100
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

Allow platforms to reuse DT headers and dtsi includes directly form
upstream DT subtree which will be frequently synced with Linux kernel.
This will further allow us to drop corresponding DT includes copy from
U-Boot tree.

Also, since the DT includes from upstream DT subtree are done after DT
includes from U-Boot tree, so it shouldn't cause any conflicts.

Tested-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v6:
- None

Changes in v5:
- None

Changes in v4:
- New patch to reuse upstream DT includes by U-Boot as per Brian's use-case
  for TI K3 SoCs.

 Makefile             | 3 ++-
 scripts/Makefile.lib | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9604a4c517e5..0f0c7f30d271 100644
--- a/Makefile
+++ b/Makefile
@@ -835,7 +835,8 @@ UBOOTINCLUDE    := \
 				-I$(srctree)/arch/arm/thumb1/include), \
 			-I$(srctree)/arch/arm/thumb1/include)) \
 	-I$(srctree)/arch/$(ARCH)/include \
-	-include $(srctree)/include/linux/kconfig.h
+	-include $(srctree)/include/linux/kconfig.h \
+	-I$(srctree)/dts/upstream/include
 
 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 9e38d75443c9..12857316c582 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -189,12 +189,17 @@ dtsi_include_list = $(strip $(u_boot_dtsi_options_debug) \
 dtsi_include_list += $(CONFIG_DEVICE_TREE_INCLUDES)
 
 # Modified for U-Boot
+upstream_dtsi_include = $(addprefix -I, $(srctree)/dts/upstream/src/ \
+	$(sort $(dir $(wildcard $(srctree)/dts/upstream/src/$(ARCH)/*/*))) \
+	$(if (CONFIG_ARM64), \
+		 $(sort $(dir $(wildcard $(srctree)/dts/upstream/src/arm64/*/*)))))
 dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
 		 $(UBOOTINCLUDE)                                         \
 		 -I$(dir $<)                                             \
 		 -I$(u_boot_dtsi_loc)                                     \
 		 -I$(srctree)/arch/$(ARCH)/dts/include                   \
 		 -I$(srctree)/include                                    \
+		 $(upstream_dtsi_include)                                \
 		 -D__ASSEMBLY__                                          \
 		 -undef -D__DTS__
 
-- 
2.34.1

