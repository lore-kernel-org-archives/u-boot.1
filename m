Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A016C5AE5A
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 15:37:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56C53885A0;
	Wed, 28 Aug 2024 17:37:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lZM3mR15";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAA7C87EF7; Wed, 28 Aug 2024 17:37:04 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92EAE88744
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 17:37:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42819654737so59083695e9.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 08:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724859422; x=1725464222; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5d1Ak+BRbQ20xzArQeC3PACnrVK6b/O7c6kxR143T5c=;
 b=lZM3mR15cWK0flfL0fy19y6HWWu+2O7W2AzAMkETF3tAEQywRa0tHRCVRvWCRpX41j
 PgtX8se09SbP3HBXg4j05p2p/n33CEFyRwP5Rkgv6LD0S8Xo7bEptNqAlswT50TlHpK2
 8AbIlS43FemjuylyNFgNogWZSNCKd8o9a+api0Af0yAKjRO6LDAvdFkwcB0qp8yqz1sB
 F3JWlMCOlJusqYb5H8+GbdohcWpb3/We8FHL3fxSQS+i8GT4FbfCHLwCSf+RRzCL77Y/
 hKboK9H0TEVtHikQSjZoQ/6LaJQRjKoCDUriJn+x5hQFFJH46wBt4+kDiCGTrNm1+X8q
 zXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724859422; x=1725464222;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5d1Ak+BRbQ20xzArQeC3PACnrVK6b/O7c6kxR143T5c=;
 b=oDdRFkA2k+ldyiuDWHuFPbDQxO5ee57EKkgNLmsWolfXZwwuwMREuNb+Tgra0HcwIm
 jatE+Z2/JEh07xIpbhxIhb4LLNujMDz6/eLBOfyVVEqRI2wP1nQxvKL9TYjGioJOyPVq
 RXGtEaD0AOEBKZH74LEHSw7pwH+dhkJDsEcrUn633+CHqFcvTlKntRHeUmpXugv0JWDd
 fjFGXyiod3fuP5sisyK+9MBde1wEzVLAF9AlXDqhhBJRN5AOR16tyKZfihK9k1wayW10
 VWIXBzfRwO/dsy/EwRZ67nqjhrofEq1SlCvhT/WySCsvxOwWHHQTmqRZxc153M2jxKML
 EZrA==
X-Gm-Message-State: AOJu0YybHTe6xPqerJObn0Mk5wf1gW8dibwJDlxHq0HWRgjN2APB40wx
 qs9Qk8xK3tc+Sga0iUoN7CHi48hWdUSjtUB+lvNf0HNyVAsXbyActN6rbeS2ONgX3fsRCxklm8+
 /xmCKGAd0
X-Google-Smtp-Source: AGHT+IGKrksztXrjlDBz4ym+/EKtf0p8IDA7iSP1mDWyuIIsjbeETQ/a654UCg0ZhMXiYTMQJaXWsw==
X-Received: by 2002:a5d:47a7:0:b0:371:8cf9:27e6 with SMTP id
 ffacd0b85a97d-373118e404cmr14448093f8f.56.1724859421629; 
 Wed, 28 Aug 2024 08:37:01 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:8ac3:aada:f033:985a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749b36a933sm85326f8f.117.2024.08.28.08.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 08:37:01 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Gary Bisson <bisson.gary@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Mathieu Othacehe <m.othacehe@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Sean Anderson <seanga2@gmail.com>,
 Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH] mach-imx: do not use if_changed more than once per target
Date: Wed, 28 Aug 2024 17:36:37 +0200
Message-Id: <20240828153637.1818625-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
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

doc/develop/makefiles.rst has the following note:

  if_changed should not be used more than once per target.
  It stores the executed command in a corresponding .cmd
  file and multiple calls would result in overwrites and
  unwanted results when the target is up to date and only the
  tests on changed commands trigger execution of commands.

The mach-imx Makefile does not follow this recommandation, so fix it
by implementing a single command that performs both the cpp_cfg
and imx9_check actions.

This change fixes an issue with "tools/buildman/buildman imx8ulp_evk"
failing every other time [1].

[1] https://lists.denx.de/pipermail/u-boot/2024-August/563192.html

Fixes: f637dfe8c468 ("mach-imx: Add i.MX93 binman support.")
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 arch/arm/mach-imx/Makefile | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index b311d176d6..5262dca4ff 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -217,8 +217,8 @@ endif
 
 ifeq ($(CONFIG_ARCH_IMX9)$(CONFIG_ARCH_IMX8ULP), y)
 
-quiet_cmd_imx9_check = CHECK    $@
-cmd_imx9_check = $(srctree)/tools/imx9_image.sh $@
+quiet_cmd_cpp_cfg_imx9_check = CHECK    $@
+cmd_cpp_cfg_imx9_check = $(CPP) $(cpp_flags) -D__ASSEMBLY__ -x c -o $@ $< && $(srctree)/tools/imx9_image.sh $@
 
 SPL: spl/u-boot-spl.bin spl/u-boot-spl.cfgout u-boot-container.cfgout FORCE
 
@@ -227,15 +227,13 @@ flash.bin: MKIMAGEOUTPUT = flash.log
 
 spl/u-boot-spl.cfgout: $(IMX_CONFIG) FORCE
 	$(Q)mkdir -p $(dir $@)
-	$(call if_changed_dep,cpp_cfg)
-	$(call if_changed,imx9_check)
+	$(call if_changed_dep,cpp_cfg_imx9_check)
 
 spl/u-boot-spl-ddr.bin: spl/u-boot-spl.bin spl/u-boot-spl.cfgout FORCE
 
 u-boot-container.cfgout: $(IMX_CONTAINER_CFG) FORCE
 	$(Q)mkdir -p $(dir $@)
-	$(call if_changed_dep,cpp_cfg)
-	$(call if_changed,imx9_check)
+	$(call if_changed_dep,cpp_cfg_imx9_check)
 
 flash.bin: spl/u-boot-spl-ddr.bin container.cfgout FORCE
 	$(call if_changed,mkimage)
-- 
2.40.1

