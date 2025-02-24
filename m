Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C06AC021B5
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 05:58:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55E6880FF4;
	Mon, 24 Feb 2025 06:56:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dlTK+prC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 147AB80F0E; Mon, 24 Feb 2025 06:56:21 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D11EC80F67
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 06:56:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-219f8263ae0so80613615ad.0
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 21:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740376577; x=1740981377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l+6y42zYeab/JziYaoYmc8s1dhHck0UW8k9ZsZG1bX0=;
 b=dlTK+prC8Ur4rCY8Q6HcTLHBFgI28wSkNLy6CjKZLsQJ7eyAqha0LbAizp+cRIAa5o
 l+NTCUppQO5Tuomwior8tGt6aoMSUkYs+QNYd0J2L3Ggx47+eIAN8FYQqAJ/guYGLESL
 W3sBAgTs4xtMH3XASmjUvuUsAd8MxRKLIMGUrW4dVz5EoOQy5OrptvWT1K11Agbiyumr
 xRr5oKPULC3h6lYgk+N/K/OvL2CjLD8PvUMb5Q8TtZ3JhH6xwj70gZzHXRGq+WjK5Iqd
 omZz4s0ZGGqP8Ll15ur1PMWRBa83Q1IfLp9DzvqFnVgHEGsMVX+/eZOPYN87lb8RnQb4
 BpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740376577; x=1740981377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l+6y42zYeab/JziYaoYmc8s1dhHck0UW8k9ZsZG1bX0=;
 b=DaCVBIej2ZDleTLCTPDLruJOCEWPnvK5Q/jfUQQgp3P+JDj5eMAipcdgy8fVgMBPuU
 +7OkiEfkA5Bxz4EGyhnKalUHFSPS52IhfrzasOd1d4VXfH7DO4JzX/vcuCZ/K5gfRsS7
 MEeQXROEQx1rBMKNo5YBEMAA+DEy8e2YJfS/g2gBVNrsQaTZw/UDPk6cnoJQjPr73zhS
 946FdQ/aa5d7n7sf0FrY0WeIq/iqAcc/G+aQLx0iSkba4qSAyC5IAbT3Ea0T1CGs7n5E
 5dDW2/R29swEXJ5dH9n7FMvKddXh/9lXJientS0YRzgxaQhVChJWFR/Vm2/wXwLFHd4L
 NYMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhWdyNvp2eTMSVap6sCcNsWtLLZf5ejLfg1yPDUE8grmQGVtd8TeBT8s/k8Rllf5mLsv8oEjg=@lists.denx.de
X-Gm-Message-State: AOJu0YwCZF+Kh8LhichuJwXwwA/Oo3LSsEy5ZUYCGHDRJwTfHoHf4H+j
 ZvXv15b+HR8bIVsUS/ZeHkOQmCQff2yTuOCe1gz8pcPIlDxNghFH
X-Gm-Gg: ASbGnctMvPFX0AaUkxhohyQ6lJC4JDaloe7MZqp5lXoWXCO//ZI81Btjhf08ZcnCsCX
 YHHh7sel2ZRUE3tIThGIhKxZTKpvevn3YVorf+QAZvjQho0M41bbBNG1UUAieoVBGf4Qp9V0v+E
 CDj7rnHq46R9mTmDjbYp9COWKj76C5go2Pz3cXu5pL/WBmZRCNdEYvcjBYru8P7ChhRFh6DNhad
 SmMAf9/Evcgc1DqXChltWfTM3cVkQva16U7J9XUnBAeAR7lON/KUbrXvgJ24IW0ZTkmYeP1r70E
 ZPEZK5YRVOcrgbKgEmGzwswDpbfzss1hUzerXw==
X-Google-Smtp-Source: AGHT+IF3lkYuXwTfV4lKZHytnUvZrwKTxHTlriiL8oYpH8CdyGWr/Oh5P6Qy7dG4yB6NOqo5ObeUTQ==
X-Received: by 2002:a17:902:d506:b0:216:501e:e314 with SMTP id
 d9443c01a7336-221a0edda05mr160027315ad.20.1740376577395; 
 Sun, 23 Feb 2025 21:56:17 -0800 (PST)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:26ad:d46b:d078:4cca])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7327e17440esm13511692b3a.76.2025.02.23.21.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 21:56:16 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 14/17] makefile: Add READELF command variable
Date: Sun, 23 Feb 2025 21:55:21 -0800
Message-ID: <20250224055524.1334929-15-CFSworks@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250224055524.1334929-1-CFSworks@gmail.com>
References: <20250224055524.1334929-1-CFSworks@gmail.com>
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

This allows setting READELF=llvm-readelf in order to use the LLVM
version of the readelf utility. It also aligns with the practice of not
using $(CROSS_COMPILE) in any build recipes directly, reducing the
number of places where $(CROSS_COMPILE) is used.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c869b5c55fa..c1749e78d6f 100644
--- a/Makefile
+++ b/Makefile
@@ -406,6 +406,7 @@ LDR		= $(CROSS_COMPILE)ldr
 STRIP		= $(CROSS_COMPILE)strip
 OBJCOPY		= $(CROSS_COMPILE)objcopy
 OBJDUMP		= $(CROSS_COMPILE)objdump
+READELF		= $(CROSS_COMPILE)readelf
 LEX		= flex
 YACC		= bison
 AWK		= awk
@@ -2177,7 +2178,7 @@ System.map:	u-boot
 # ARM relocations should all be R_ARM_RELATIVE (32-bit) or
 # R_AARCH64_RELATIVE (64-bit).
 checkarmreloc: u-boot
-	@RELOC="`$(CROSS_COMPILE)readelf -r -W $< | cut -d ' ' -f 4 | \
+	@RELOC="`$(READELF) -r -W $< | cut -d ' ' -f 4 | \
 		grep R_A | sort -u`"; \
 	if test "$$RELOC" != "R_ARM_RELATIVE" -a \
 		 "$$RELOC" != "R_AARCH64_RELATIVE"; then \
-- 
2.45.2

