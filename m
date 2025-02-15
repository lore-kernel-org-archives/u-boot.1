Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689D4C02198
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:26:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64F8080F81;
	Sat, 15 Feb 2025 04:24:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T4K6hJEH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BE0080F81; Sat, 15 Feb 2025 04:24:19 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 386BD80ECC
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:24:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-8556e24b5a1so158483339f.3
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589855; x=1740194655; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GB3ft6coeZM2/i5uYYcK7xK0Kh0y6U9sY/miet/OWag=;
 b=T4K6hJEHnB3PVScuG/bkHXMDO+F2If16xR3WDT3ogD5ki9tLK3sCTA/Ma/exRPD9Or
 bWqEh5z19KVQgUTEbEipCtguCSAvQs8rh6sovuHbWmc1kH/kCOJgbEFRUHrk9jbtljUO
 0KrynQv6GOCpbnuNam7t3AbGjAxSVHcQWb23E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589855; x=1740194655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GB3ft6coeZM2/i5uYYcK7xK0Kh0y6U9sY/miet/OWag=;
 b=XGGN9xmCP8CG615dcK5JfPZMT+h/WaSOOihcZ0plYS9cfIXRu3DaGoLUK7tkgHDIHz
 hqj5Dg9WA0S9+pQr7opncyCaW/7YMImcGedCf/K1IEOeEkFaU0dUrywbgPDKSwFPKAud
 MNCqAYQfpis4xFQFsrVrxdMtoITQP5nIZZQdsM9bDKhI7tExsg7hFbsccck99sg8V2VT
 9RFnS3+UI+IDpH2Rh3wx0RCFKnHIts6YcAqQLQFhbMZ93NC00HvEa6Ue0aIh4YI+U0wR
 e2fhwsxaff9XJFtV7fyBfAZY+rPhls0zA0XGnYS5PDFqlcSG3F6P9s7hqa6BAWrwMpsK
 PAqA==
X-Gm-Message-State: AOJu0YybEssQCCeCpelbR2WrgFMSi+GkFCy+QAzGWIR/IWdjEGnJROo0
 weJaB+gd5BaXJqt0cV9tEnMUE76XZVB3H0q2GTfrrf61wno9CcIsaMmb+CZaSI7X89n+ABqI87E
 =
X-Gm-Gg: ASbGncufJs5/yl2Jbu5pDn16ku5XR0E5MXn8Le/rfV2j9Sk67I7RKLaO9EVsv369Cxc
 1HtxZkStLNjVIg1/5drpgiuZGwdsZgMxXwTWAZR9AvVWIz4X5qXch18984GyhtENET+LaFNz8BR
 kpQd2MaGd7QDm+sktfbIlNV/jB7HBV2/9SEZfuFGB3sWLChxsFL2KJLEYHYXgfb5UhyRa8IO4nZ
 d7Xsj+2RHES20L0mpmyKznYPtx8rebGY3JgRgsCpZFqNG0stzRuYdnU+TWo8J7RpifIGktZLwJK
 3TbRjSehs+XU5hMzLyRhTup8cxksKVC5me7gjJ85V5iBUdhOIw0w
X-Google-Smtp-Source: AGHT+IEuXkNXt5mj5Ms7HaEoLvjvXYLb/gj0DuHiqyJvFcNXZHn3qDBIJJZceJar+i9MtriScvIW5w==
X-Received: by 2002:a05:6602:1489:b0:855:683d:d44f with SMTP id
 ca18e2360f4ac-85579fd3e47mr162503539f.0.1739589855014; 
 Fri, 14 Feb 2025 19:24:15 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:24:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH v4 24/29] efi: arm: Provide startup and relocation code
Date: Fri, 14 Feb 2025 20:22:45 -0700
Message-ID: <20250215032254.4121030-25-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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

Build in the EFI-app startup code as well as the code to relocate U-Boot
to the loaded position, since this is under the control of the previous
firmware.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 arch/arm/lib/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index a41566c816d..a2b8ef96ff5 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -32,6 +32,8 @@ obj-y	+= relocate.o
 endif  # ARM64
 endif  # EFI_APP
 
+obj-$(CONFIG_EFI_APP) += $(EFI_CRT0) $(EFI_RELOC)
+
 obj-$(CONFIG_CPU_V7M) += cmd_boot.o
 obj-$(CONFIG_OF_LIBFDT) += bootm-fdt.o
 obj-$(CONFIG_CMD_BOOTI) += bootm.o image.o
-- 
2.43.0

