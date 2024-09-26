Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D58CDE03F
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA6D788F9B;
	Fri, 27 Sep 2024 00:42:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gqN+bGMM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 195AC889AA; Fri, 27 Sep 2024 00:42:10 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1327C87B77
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-45816db2939so9597501cf.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390527; x=1727995327; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CYzKnUPGr1wneVCt08++YCgi5LeTIO73Lq3SWktnlFI=;
 b=gqN+bGMMT3kBzGSf8hB+Vfnku+C6kmiTSusuRTeBR/Vcp0cEUYTgbggQb45TbdqISd
 RNNLbAVZn9e3zNhzN/weSZD09uGTllOXjoFiW+H/vu2CA3YrwUJpFtMNnPzQ2OSVZlRX
 /Nlxq7jRz6vlRk2iHX3hjPFE6BCs3g2OknsE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390527; x=1727995327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CYzKnUPGr1wneVCt08++YCgi5LeTIO73Lq3SWktnlFI=;
 b=nnFmZlsNR0/XTDEkpix0QZlxFkijcAZn0xLUpHNASXvSShHCOtzubq9xao4ZvlEvq3
 2g6zJUQ34TBejcHZFBH4WDFyFYOuvqp2vX6Pm9cy6epzi57suauk5prRpNwdceqUTbwe
 eaqnH8aphQ0Vpwh2E2qcunb4PH45bFGtkAe8WUjR4lVcD4Cv+Wqwai2wKi+WRa5AtEwb
 3/y7BVDOKxEzBNnTqRO6J5J4+YoWNA3/JqIBIqaQVp7Uz/SJu06wjrLNX3HEVVoeqhB+
 v22+XVrKqI2IWMaHc9GeiU+JluDTxhHYot0Lb8fde8nT7azQTretf1xxHHg0uAveChti
 ZEKg==
X-Gm-Message-State: AOJu0Yz9TBzbR4XVFtinJI3DF/fzP55HFVXrj6MKQhKyxZc1bdA8VI52
 dE3xQHYXx+QY4C2On+waAhBgY3k4dQ9os1CBJ+nOsyM/Jf3/mGti1FU1jJSFmPuFncn01FTPATT
 jaHqfjC8=
X-Google-Smtp-Source: AGHT+IE2L1/k/B+Zn6DH1Vy5yLL2duPTwPJOWxfQ8Sxe6+MDvD52HMOz10ujs7WeuwicDLAxksBYig==
X-Received: by 2002:ac8:5842:0:b0:458:a70:d9c0 with SMTP id
 d75a77b69052e-45c9f1f41d8mr13034091cf.17.1727390526824; 
 Thu, 26 Sep 2024 15:42:06 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:42:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 15/42] mips: Simplify check for SPL
Date: Fri, 27 Sep 2024 00:35:40 +0200
Message-ID: <20240926223814.1276764-16-sjg@chromium.org>
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

Now that SPL means SPL (only) and is not defined for TPL, simplify some
checks for SPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/mips/mach-mtmips/mt7621/Makefile | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/mips/mach-mtmips/mt7621/Makefile b/arch/mips/mach-mtmips/mt7621/Makefile
index f48083e3559..3ddd6771051 100644
--- a/arch/mips/mach-mtmips/mt7621/Makefile
+++ b/arch/mips/mach-mtmips/mt7621/Makefile
@@ -3,12 +3,5 @@
 obj-y += init.o
 obj-y += serial.o
 
-ifeq ($(CONFIG_XPL_BUILD),y)
-ifeq ($(CONFIG_TPL_BUILD),y)
-obj-y += tpl/
-else
-obj-y += spl/
-endif
-
-obj-y += sram_init.o
-endif
+obj-$(CONFIG_SPL_BUILD) += spl/ sram_init.o
+obj-$(CONFIG_TPL_BUILD) += tpl/ sram_init.o
-- 
2.43.0

