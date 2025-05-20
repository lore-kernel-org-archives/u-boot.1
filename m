Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14F4C3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 05:25:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E13E382D33;
	Tue, 20 May 2025 07:23:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b8aI+E0D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D7A582D34; Tue, 20 May 2025 07:23:00 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24F2782BD9
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so56248045e9.3
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 22:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747718577; x=1748323377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZvKd0rmm6pH8M76fz4TMzzrtdqdtkxECc8stvnnL30A=;
 b=b8aI+E0Df9Cw9wh1KZKBeYNCoh8BrKOIE84T5AXqXdITRaCgrArICnd/YEcvFZ4Emn
 PAOckEh0i6ZpOJ8byq/QCtR/T2i89HNKQRUtkLC43FUVMZ7f6aaJFlGmjextbarksQVk
 MFQ+eeippJM5aq4J3gK9wlem8M8LF1UNL3nr8c5lUiWjO37txDGu33OKIt+rPZY/6Z6K
 VwFwI+hv7tXjLOTqSree7SRlxyuNulK6EWnFhACz93d/Tc43cFh2dbbDh+0zbrY8C8Tg
 0eVCMhdaktMOjbVviwIZIH5cG2DjQYNyNVWbAv9j+SDpBLTU3OvOMnI2jitesbvGb3c2
 BHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747718577; x=1748323377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZvKd0rmm6pH8M76fz4TMzzrtdqdtkxECc8stvnnL30A=;
 b=YUs7Sz9FNC6HguIScy98OePEX/m5vFxcntqjs/RW4zj6uJySZlCXKzeBM1XaxH10IA
 ux3y2t4fWeH18DVCMdiLkQlUEi9tZuSOLL4UBxfDVAuKeUURBehaVRsl1uQYjFyAtdAj
 oF/NtHRE33h1PwbOZz30xOkWtq2vEWnsnmocps/RCxxLCb8hdGSjd4H345r3ksOGlnOs
 x0dkKIXiJHtyU40CsI1IecBJhPMIbO/VPtI9VlhEaDbByr2/asBpWXa2/viHOYoXQE7/
 z9gIqTjaO1c2pskFa7hYoEP337aH/o+ZdsAFwyHFlHTBX0YqF6G7dzXdWuKISaNpfa2l
 y+sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCLny3GXRojeAMjQ8EVHsZF5wDnChkuoUQFLLQ6P1ksscUaY88gNHNnJtiwK16PwyDLmS1HoQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwDreqra3mp7NKp0N4lbP3eEWLeUNYqYb0AUZ8d/T26nU8TjcQ4
 tkRS6bwNIc5DKzTSS/dAkjoAmdknqcW5rC+eETwKcZzmuMTJWSFVraWsmXHJd8u87nk=
X-Gm-Gg: ASbGncsiOLBy9Fs70nxSoLDswSQp9tbvpH8lmF/aVU27PzF0beUtK+c7wgUpa5BTDEh
 F9dJaBCpn0HUbRar+jdC5xRKRtx0PGSmi7E/C+l/9KYtRnLVay2xNalGDWx3ToxopMn5XK3FjHQ
 E8BDpPgbOW6qh4s+p81QSxLgJ1udUfnqgfZGxn0s13T6REJiWtLhYWmlal7WtDSCuXPUFzy8Rrq
 FdB4wQa8ThYongV2O+d00ijurHkFleuAE7i5HnmeX1b8FTadgx7gcPpT6bF4ayTCZimQgEPBTo4
 FzTrSdmaIXbwDJES4n1HehZWLXaK3Ww3Nd2xHADzq3xERjx2B90OoDT8cK4CcWkxDDJu2SUKgkA
 =
X-Google-Smtp-Source: AGHT+IGm3kf6LRvF8a4Kqm8iTvy1MpBgV8xZY2f9p/ABXbb/EfdTUA3UDc2rhVL3lcs19ErjQ0Ht7A==
X-Received: by 2002:a05:600c:8507:b0:43c:f597:d582 with SMTP id
 5b1f17b1804b1-442fd608753mr137333235e9.1.1747718577628; 
 Mon, 19 May 2025 22:22:57 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm15100762f8f.71.2025.05.19.22.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 22:22:57 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: [PATCH 24/24] kbuild: add -Werror=strict-prototypes flag
 unconditionally
Date: Tue, 20 May 2025 08:21:35 +0300
Message-ID: <20250520052153.307194-25-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
References: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
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

Backported from kernel
commit eeb5687a7139649e ("kbuild: add -Werror=strict-prototypes flag unconditionally")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 66803f089d48..2890edbcc43f 100644
--- a/Makefile
+++ b/Makefile
@@ -433,7 +433,7 @@ CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
 
 KBUILD_CPPFLAGS := -D__KERNEL__ -D__UBOOT__
 
-KBUILD_CFLAGS   := -Wall -Wstrict-prototypes \
+KBUILD_CFLAGS   := -Wall -Werror=strict-prototypes -Wno-trigraphs \
 		   -Wno-format-security \
 		   -fno-builtin -ffreestanding $(CSTD_FLAG)
 KBUILD_CFLAGS	+= -fshort-wchar -fno-strict-aliasing
-- 
2.49.0

