Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F346CDE03E
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:41:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E5E188F9B;
	Fri, 27 Sep 2024 00:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JdoDeFKc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A4DD88EA3; Fri, 27 Sep 2024 00:41:39 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AD0688F9B
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:41:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-45821ebb4e6so10137531cf.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390496; x=1727995296; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fDMN15KSyTcxGhIgLjSnnRA3jdHbMxrT5C+oci3h/gE=;
 b=JdoDeFKc+YABHYcNgsCeIaWodTJCW99u3dKfu31Bv/6s1ns3sgcdNPc9xxcYnwAFGJ
 EXcNWZQZFxJJz3tUSmxiU0SrT5mFnzjW7Z/opoMlZYalxTRhu8yylrCH3VJDRGVihGgk
 rS+D5uF8SvV7KfSvpToXMdQa9w6nLDlf27B/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390496; x=1727995296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fDMN15KSyTcxGhIgLjSnnRA3jdHbMxrT5C+oci3h/gE=;
 b=eS4IuTpUkd/ObBUXkOrkD5xmUQyAEUYY3YuQ/cpTkJpN5VFg/G8GMPxuCiFrh/hdfE
 i/yDf2gR69LCu2ViYvDNOiV7ah2hQSlfly0ZQEQ+dSWi9YWYTBGr3MU8chKN2ehUP9uE
 a/lhnwqI//GhZV8h/mkhdmqoZTcH7oc8qcXBIux/oEhD3FYjIH9PQpbqPjEl6Sv+6cwI
 lfjsRKwV83WUFG2ncJXNgRzw/B85Pc3bz1k8a5dG5y7eVcyUotoccCHQoXUfRaoGHZJC
 h0mR975KPOkCC0nWOVNiCH818kWxnt77vxcpqM9I+fru11Jofl8U2bhpujiPr/ZbulDI
 KOuw==
X-Gm-Message-State: AOJu0YweEsy3cAoTq6e5qQ/yvuAkv2pmSPe0gw9QRIorXnmoiXTr4tj2
 Kx31nZ1plpPMuBcYbZb7/nRg8/2Lwp+zb0MFIGtR7Udht2qogCucsOqULRZ4xt0H4cVqMBh1CAU
 BnnrCeyw=
X-Google-Smtp-Source: AGHT+IGz2imeLam/kvge15tUJVtr+2jzgsgQ/UgSpiGc3VqoLTJ08aYZlh5oFQSTNlnpPO0jMvb0Vg==
X-Received: by 2002:a05:622a:553:b0:458:2756:fdb with SMTP id
 d75a77b69052e-45c9f247775mr17295631cf.29.1727390495856; 
 Thu, 26 Sep 2024 15:41:35 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:41:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 12/42] boot: Drop unnecessary ifdef for LOAD_FIT
Date: Fri, 27 Sep 2024 00:35:37 +0200
Message-ID: <20240926223814.1276764-13-sjg@chromium.org>
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

Use the normal SPL_TPL_ approach for this option.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/boot/Makefile b/boot/Makefile
index 299a22ed689..5bf07e83388 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -58,9 +58,7 @@ obj-$(CONFIG_$(SPL_TPL_)FIT_CIPHER) += image-cipher.o
 
 obj-$(CONFIG_CMD_ADTIMG) += image-android-dt.o
 
-ifdef CONFIG_SPL_BUILD
-obj-$(CONFIG_SPL_LOAD_FIT) += common_fit.o
-endif
+obj-$(CONFIG_$(SPL_TPL_)LOAD_FIT) += common_fit.o
 
 obj-$(CONFIG_$(SPL_TPL_)EXPO) += expo.o scene.o expo_build.o
 obj-$(CONFIG_$(SPL_TPL_)EXPO) += scene_menu.o scene_textline.o
-- 
2.43.0

