Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92426D42B84
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:00:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E202689440;
	Tue, 12 Nov 2024 14:59:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aK0dodka";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 406A789430; Tue, 12 Nov 2024 14:59:47 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 800CC8945E
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:59:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-83abdaf8a26so217577739f.1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 05:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731419981; x=1732024781; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eSJhevz9AKYz8lbkP+JeRpxLlHMEsRTVyOjYzvGBu9Q=;
 b=aK0dodkamfIBSO+S5zCL29LnWpcNWymfTnzEGoi8ym1jOev37wthU96O2/s0uFsMk6
 GCwsO2LcWc4s5Isn1tzQcJGUZ0D9I7s4On37tKRW/PinwLX8WVfM5sNMMZQdXKu0fn8I
 Kn2vujWwn9NknL5rEpunIBfQB6LCcZvCffdc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731419981; x=1732024781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eSJhevz9AKYz8lbkP+JeRpxLlHMEsRTVyOjYzvGBu9Q=;
 b=fop+JquqLTp1Rr5Ssy0hl+2oFqT5JZ5rBaTsBa+BqgAZfQtXprAmeo0U/7oIkBHwZ+
 gsCRjllYkk27ivnWQGg/rPPggj6oFXr8RzZ0j4FcDLp1+tXvW9xt2VYlt2XJ8st5ntd/
 3Yd62HO/zUasbTmLhTjQ8buT7qKxaedDSlmBDo4HimYFbLgXYGCdH7SWIKjMkuYwQWjJ
 O4Bv0EZA4E1tgh6HxSUT4ztK2jrO69ZCPc94o16pCSHNpcjzF+FoD7Y5ZDEGn0g5w7Q9
 csS1EniibXU5l0Rrhkyx8IkBMPdwDl19RwkdN7mzQ5DtfOHk+Q0tNkfFqkPn8ioMGFtB
 zUuQ==
X-Gm-Message-State: AOJu0YwTuVZwZc1KJePFii5DfHDBmRaqrFaabJ2Gd72OosZJsV85DjLm
 gv3w928Dyip5g6Dy+6XOH0IGkSdknDzr00zU2mlEYC9m+poOM3E/zBFO/gUa6EK0q/PNPFWVmaQ
 =
X-Google-Smtp-Source: AGHT+IGfCPAwxr/xez30SriYv12vjkdGWyRzQP8iluEnmcAxdXhwKogDPXRy91YIzl+kkstiVHStEg==
X-Received: by 2002:a05:6602:14d1:b0:83a:c0ba:73c6 with SMTP id
 ca18e2360f4ac-83e03344165mr1683287239f.11.1731419981022; 
 Tue, 12 Nov 2024 05:59:41 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e132c01besm189203039f.30.2024.11.12.05.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 05:59:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/18] x86: Drop mpspec from the SPL build
Date: Tue, 12 Nov 2024 06:58:59 -0700
Message-Id: <20241112135911.630586-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112135911.630586-1-sjg@chromium.org>
References: <20241112135911.630586-1-sjg@chromium.org>
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

This is not needed in SPL, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/lib/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 43e6a1de77d..a908356e8a6 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -26,7 +26,9 @@ obj-y	+= e820.o
 obj-y	+= init_helpers.o
 obj-y	+= interrupts.o
 obj-y	+= lpc-uclass.o
+ifndef CONFIG_XPL_BUILD
 obj-y	+= mpspec.o
+endif
 obj-$(CONFIG_$(PHASE_)ACPIGEN) += acpi_nhlt.o
 obj-y	+= northbridge-uclass.o
 obj-$(CONFIG_I8259_PIC) += i8259.o
-- 
2.34.1

