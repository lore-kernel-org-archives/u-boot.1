Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9200C282D2
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59B6D812BB;
	Tue,  4 Mar 2025 16:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gv74MB6U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2D36811B3; Tue,  4 Mar 2025 16:32:06 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD55E80842
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:32:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43bbb440520so27250695e9.2
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741102288; x=1741707088; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bfoPMUhxDr7WVVhzIFejOsPgoKBM+OEDuQ7e7suLhUg=;
 b=Gv74MB6UN+fRVXGH671QPFO7hHvEyQPvJxU7RwLhTRKZPczaj+CxaHSa6DkgqQW1X7
 tP/AfGtCjDEUL9GGlQsp7Fwj+C5XA0SZWwkwB2EGScQlZGN9jo/URKGr+gOJhK1RpQHP
 jF+0t8rc9HR86aQjaKpcv3DnT9cSeLVfyg4PN2BOgRM49kziYKv9lM2T6rek9mXfdkAr
 4PVT1jksf7B/PlzSU8EJKhitzv7NO39xp2wNHOYjLd8RJY6BFOPsoCjKgQuSNXyh4sQu
 IO5s32t9abRymYZf7aJd5ySKD8+5AE1Vu5qVkNaIOxVa+EvUQA4UXG1i4Ma8B4j3wWe+
 I56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102288; x=1741707088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bfoPMUhxDr7WVVhzIFejOsPgoKBM+OEDuQ7e7suLhUg=;
 b=lr43KGYI3cFMeq4T0RYXNiHNJyU1YBNb7T1iIA62B6J+OwjS30cbbvFzYbJouPQL7P
 x6sIKdzPh1q4CnLj1jUqVq4jrZuQwMvBP7yOkqjtUxOZg7gB7i2LVXM04eLPFQtWxz1x
 5fpkmg25++a/MSZcWmRml4d+q0Ae7qSOu4tyJ2wuDPElFqHlmCTlQ8cJZCWE8zNuKq4s
 t2RtKSahBdDHEM40lMai/QwVXlJoe4KVv2R+MElREwmwxfGjN0wMMgFQDAHqYdJcu1rX
 K72v375uYSzQQ2F1TvvSHpV+ItaC6D446sE+vZTExbRIF1E8O3gQtx/fjsEtLXzcUaNd
 6YBA==
X-Gm-Message-State: AOJu0YwTS8AFVVU/eKGyDQI2gjYJw4/NC0anG5UJvgIvn8LPIQqZY4LC
 7g24sMGtJ3e0x7AqQWw101defkyzTQYhcIJ19Om7kDvHm7Li/Rf756PE9pa64ECsthI47ZLwoZy
 O
X-Gm-Gg: ASbGncsaL6/wMGmK22aqtKWwf3ov8gNBGleS61cm30A3FJm9gNRBhlAUJMH2SceDIv8
 iTVTdPJ36NCdxTiWj8XiJlH4i9iRW+mS2erwAj2/9jbO9fWj3sT3yrezfRZ7X01x022CHDPtyos
 rTcmRNdgxjgW4hc3189CkElu3/g2FqK4PyXAqQ9w/jgX5jzAPGjrmVA++rrzSsISt/TUB93pbzE
 jODwQNxHLWlB5so5eRGgVuQaiOndwQcgaueUiaZU9L/UbzdSXWSMlr5BojmiODHR0wXafqUDDha
 +kaql5J54EnMKuEJaQVYXP2HyI6hPnWNAmHPqIOAmGYUKfaR180FCQ==
X-Google-Smtp-Source: AGHT+IEmRlE4KSzIGYv5/lQ6Ou3JGLCaLTuOe4AaE4U0/9Dxrv+TGIinT0XHrMERVlYwV7rbdOw/Aw==
X-Received: by 2002:a05:600c:3513:b0:439:9b39:b31 with SMTP id
 5b1f17b1804b1-43ba66e5f2fmr188931145e9.8.1741102288163; 
 Tue, 04 Mar 2025 07:31:28 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:771e:3d0f:d9c9:2f92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485db82sm17669254f8f.88.2025.03.04.07.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 07:31:27 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>
Subject: [PATCH v3 03/14] riscv: add initjmp()
Date: Tue,  4 Mar 2025 16:24:51 +0100
Message-ID: <20250304152510.2832340-4-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304152510.2832340-1-jerome.forissier@linaro.org>
References: <20250304152510.2832340-1-jerome.forissier@linaro.org>
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

Implement initjmp() for RISC-V.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 arch/Kconfig            |  1 +
 arch/riscv/lib/setjmp.S | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 7a3141e92b3..aa60c5ff03c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -153,6 +153,7 @@ config RISCV
 	bool "RISC-V architecture"
 	select CREATE_ARCH_SYMLINK
 	select HAVE_SETJMP
+	select HAVE_INITJMP
 	select SUPPORT_ACPI
 	select SUPPORT_LITTLE_ENDIAN
 	select SUPPORT_OF_CONTROL
diff --git a/arch/riscv/lib/setjmp.S b/arch/riscv/lib/setjmp.S
index 99d6195827e..6f952a16eee 100644
--- a/arch/riscv/lib/setjmp.S
+++ b/arch/riscv/lib/setjmp.S
@@ -59,3 +59,13 @@ ENTRY(longjmp)
 	ret
 ENDPROC(longjmp)
 .popsection
+
+.pushsection .text.initjmp, "ax"
+ENTRY(initjmp)
+	/* a1: entry point address, a2: stack top */
+	STORE_IDX(a1, 12)
+	STORE_IDX(a2, 13)
+	li  a0, 0
+	ret
+ENDPROC(initjmp)
+.popsection
-- 
2.43.0

