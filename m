Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3D4CDE03F
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:39:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A00288F41;
	Fri, 27 Sep 2024 00:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JUfOIiww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B472E88F33; Fri, 27 Sep 2024 00:39:41 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A854288966
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:39:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-456757d8871so9480831cf.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390378; x=1727995178; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5iGqa7v5WgIffuRV/lB31jai/hlneLbikW0GIZFY2s=;
 b=JUfOIiwwdxz0XKPsngyWZSclEwvC1MToPhiozyVEvoJ/SxQ39M32WhpSmh1099S3ZV
 qasgHKkK3QDN4Xmm86HFsmgeNLfBlccQhlkzIeKc5rQA/JUp+uw4QaQakEnn+qHv2w4Y
 OlOwx4nPoA3ZJAct3FVhp3aWQ03PYGmemtTAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390378; x=1727995178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S5iGqa7v5WgIffuRV/lB31jai/hlneLbikW0GIZFY2s=;
 b=lXIGeqLTxv65PbMDXn6rYeZlhTiAt+si8SIGcUowGeMC9t1ckiJbJg5JGwytYpQG3A
 l/Pm9kcfhU9QdZW8qTQJkBXKiQI/1zUVl4mQ6+8s5y2FM/Io0ASwALKm6FF9VS6stw5M
 AYPTp093CyfLfJexKimBcq9F9Wj/n8RNGdiVpLqqvg1RVCbTrMZlHqjkicKYsgDf+sqZ
 uHKJiWG1eNS3PHAJo+JZ752zMOaz+WiwdPoJiesATIxv1pL79rOH0BrH0ATkn270F5RG
 3qlBcLBlYUduoSxSJmIdGZ5JwaPzhFDxas8lPJnvgmTcgvpLZ4qHHJIFFH2PHG67cuUy
 syuw==
X-Gm-Message-State: AOJu0YyI4JY8xF1NCJMrdEg655BuThPHMe7WEyc8loaNlIKaTB6xPqsE
 sGPlfsvGNuEeEmnlyaMou5fcn2EcvSJ7K/hJzrDTOQZ2nwuM5ei9ZnOZvini/ai1xLLjJ7J5yzX
 TIPQi7xM=
X-Google-Smtp-Source: AGHT+IFHh6VygTq1ssG7zC9QISbF4wb4JDv16M27RusfZn9A1P1lvWAfq0pirk15TW4yQCqYFlMtOA==
X-Received: by 2002:a05:622a:13d2:b0:458:256:bf7d with SMTP id
 d75a77b69052e-45c9f1e8d32mr15453501cf.22.1727390378406; 
 Thu, 26 Sep 2024 15:39:38 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:39:38 -0700 (PDT)
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
Subject: [PATCH 02/42] scripts: Rename Makefile.spl to Makefile.xpl
Date: Fri, 27 Sep 2024 00:35:27 +0200
Message-ID: <20240926223814.1276764-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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
2.43.0

