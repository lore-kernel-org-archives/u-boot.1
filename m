Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABF3C25B47
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 06:32:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2514D879B2;
	Wed, 25 Oct 2023 08:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iFxeJcJL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8BC987A03; Wed, 25 Oct 2023 08:30:46 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EF0387A5F
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 08:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-27e1eea2f0dso3195502a91.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 23:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698215436; x=1698820236; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9yfAtkx/MLAaC2e3oTVCEdGrlnmIaFPaJzkqM3lqaYU=;
 b=iFxeJcJLYxOrCgEjsvF7yKCxboLMgZBUiMwZXzg8+LojdI1yozYZTYZY5o8jdKqAz0
 XG5ZizVZDxbhbmoM4U8AiacFZpS+AtnWfPtkIrlxv+E5xLR7kdhhrRfXyp3T6ZdLGthz
 Aw+v3jzZcweWPn894Fb9uWJoH6KkhCbRz33b6DDheTOxUlyyGr0tVCNIyvFihOWuRLEw
 nWBgrMpkw3z+E4M5zEIlwSWs371rJ00FgcG5+QKUY3HjrAJjCWZaw7daqW7N2ZR4m7YJ
 hQXI2/qdjHrA7amhC0hUEm23UX7R6rSl6ErK6sQbIRh1n57XUySSO6xaiVzyHFC+lh0t
 ZkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698215436; x=1698820236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9yfAtkx/MLAaC2e3oTVCEdGrlnmIaFPaJzkqM3lqaYU=;
 b=qPVCnYBAC5yWh/GJ0cxx/DHArtvYQtYYOfeQtJCS/Gzfh12QaXzRWp81uB0neAI+lV
 /jHzUKNqvCIVEgAqMWBEr7O/s6Zofw7ERvGTXZ9jCc7lBmBWlCDQpCEFpIMk/TSZ/QZB
 WG0ISRQWbQ0Z56xaHrDkrV6oFJV16mVTLRtjn83dIc6gkOlERnvDix9KSe5Yi7HH3EOv
 arlfM9UuTcJHlmYwImSQPDVIrvlUvtn4xhQ9cEZ7GW1kPURcHQBtWVwuF9U8PzrwgfQx
 ShhcnoxMCf6jtoF07QQhJDw+hu9Ckp6wHrOFVKwTEcX6pNxKCCAndkyxMxVLpuBS3YoT
 iWgQ==
X-Gm-Message-State: AOJu0YxFZ6burzG6mkWlw7xOoVmVz2FCx56mb5onOKhG2jkJ+KBdF/eq
 KkskpBZiXde6muPKyJ/8pvfPM+Sk3uWy4BZiPbo=
X-Google-Smtp-Source: AGHT+IG87WVqcAYdbFBV4T5YbHxVsxzSQqtNmBr5e2IqRu0wa6wpFqK2TSOYDsJkU6KJSvbuIijhOg==
X-Received: by 2002:a17:90b:1254:b0:279:23a:9e70 with SMTP id
 gx20-20020a17090b125400b00279023a9e70mr11421899pjb.2.1698215436271; 
 Tue, 24 Oct 2023 23:30:36 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 ci7-20020a17090afc8700b0026b46ad94c9sm8223583pjb.24.2023.10.24.23.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 23:30:35 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v8 7/7] doc: uefi: add HTTP Boot support
Date: Wed, 25 Oct 2023 15:28:45 +0900
Message-Id: <20231025062845.3100964-8-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025062845.3100964-1-masahisa.kojima@linaro.org>
References: <20231025062845.3100964-1-masahisa.kojima@linaro.org>
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

This adds the description about HTTP Boot.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 doc/develop/uefi/uefi.rst | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index fb16ac743a..ca9a573669 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -642,6 +642,36 @@ UEFI variables. Booting according to these variables is possible via::
 As of U-Boot v2020.10 UEFI variables cannot be set at runtime. The U-Boot
 command 'efidebug' can be used to set the variables.
 
+UEFI HTTP Boot
+~~~~~~~~~~~~~~
+
+HTTP Boot provides the capability for system deployment and configuration
+over the network. HTTP Boot can be activated by specifying::
+
+    CONFIG_CMD_DNS
+    CONFIG_CMD_WGET
+    CONFIG_BLKMAP
+
+Set up the load option specifying the target URI::
+
+    efidebug boot add -u 1 netinst http://foo/bar
+
+When this load option is selected as boot selection, resolve the
+host ip address by dns, then download the file with wget.
+If the downloaded file extension is .iso or .img file, efibootmgr tries to
+mount the image and boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
+If the downloaded file is PE-COFF image, load the downloaded file and
+start it.
+
+The current implementation tries to resolve the IP address as a host name.
+If the uri is like "http://192.168.1.1/foobar",
+the dns process tries to resolve the host "192.168.1.1" and it will
+end up with "host not found".
+
+We need to preset the "httpserverip" environment variable to proceed the wget::
+
+    setenv httpserverip 192.168.1.1
+
 Executing the built in hello world application
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.34.1

