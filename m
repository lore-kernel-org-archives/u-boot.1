Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018C5C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 08:24:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 362EB8790F;
	Wed, 27 Dec 2023 09:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CD0eR2ff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66A1D878A1; Wed, 27 Dec 2023 09:24:17 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E02B877E5
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 09:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40d5ab2f9f1so11074835e9.3
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 00:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703665455; x=1704270255; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jBR/tlC0jkj2pK1Kxh45keercbsIUp3PedZjE1DZu5o=;
 b=CD0eR2ffx1Tyx4vcsNhUrf7/1w6/A+fbBAYNmZuI4POKFIMHWjNwhRMXkb3XbUmT4Z
 iwAhjPyQ7NorQcYvVwS0s8Fv8VM9R6xuDdX8HEwGEOQgYYJya+u/vuOadB5U5zEwGZGr
 ufU4HDQubeAGZT7etbdpxivFuhiR6gQ/mstQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703665455; x=1704270255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jBR/tlC0jkj2pK1Kxh45keercbsIUp3PedZjE1DZu5o=;
 b=NHR0T5adEBcdwhS5tgov83uoMwk/jQ6xfoHrPb6MgnGkoHIpYkQIhAws7UdpZnT3FH
 1+jUTnl41/G9YHOWFi+mKa9hE0yMxRi5v2bSASrFywk1qNl37f4qGJKfPwLq/0QVFrS+
 6c+lzjqyy2J66d+hT+Tduk0jszXL72Yy8PXxrovyuFpD3N9gKN+bB3yIhHX1ZpbziyPG
 7bVgFFZzgkvd+NkvJ02zWmt1Ncj2GTEUBNxXqS1BYCyTshmmxueey/sm65tj9JFFRcWm
 Ge9QfjnW3wn/D7VU9VoPpVbCiFw1kE6oLBOrbEcRvo9YpnWhYHvqkUDsnPNYHZqddI7q
 oybw==
X-Gm-Message-State: AOJu0YwY5C19BaM7B1IGIglJDZYzX+BSByEXNtnzi0NMNSBDvq6y894i
 H7VUgkvmkl/aBuiiAf63MQpoWLqXTrjf6Zeugh7qC7k0wxMM
X-Google-Smtp-Source: AGHT+IGiRgm50hYhXTlquQCXllsctvWuY+KTW5uLJbJu+PESmRSYCJLi+DTEttMpdhLP/OmvM0pjQw==
X-Received: by 2002:a7b:cbd5:0:b0:40c:5e5f:d3bb with SMTP id
 n21-20020a7bcbd5000000b0040c5e5fd3bbmr3196488wmi.107.1703665454927; 
 Wed, 27 Dec 2023 00:24:14 -0800 (PST)
Received: from tasman.chapterst.org (80-42-48-87.dynamic.dsl.as9105.com.
 [80.42.48.87]) by smtp.gmail.com with ESMTPSA id
 fl15-20020a05600c0b8f00b0040d5e7fa243sm1233552wmb.28.2023.12.27.00.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 00:24:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Michal Simek <monstr@monstr.eu>
Subject: [PATCH 1/9] microblaze: dts: Use the normal build rule
Date: Wed, 27 Dec 2023 08:23:57 +0000
Message-Id: <20231227082405.2202246-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227082405.2202246-1-sjg@chromium.org>
References: <20231227082405.2202246-1-sjg@chromium.org>
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

Build devicetree files using the normal SoC-generic rule. For
microblaze there is actually only one SoC and one board.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/microblaze/dts/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/dts/Makefile b/arch/microblaze/dts/Makefile
index 427a8f9aaca..adc76ddf21f 100644
--- a/arch/microblaze/dts/Makefile
+++ b/arch/microblaze/dts/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-dtb-y += $(shell echo $(CONFIG_DEFAULT_DEVICE_TREE)).dtb
+dtb-$(CONFIG_MICROBLAZE) += microblaze-generic.dtb
 
 include $(srctree)/scripts/Makefile.dts
 
-- 
2.34.1

