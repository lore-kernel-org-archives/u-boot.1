Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F20CF6493
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 20:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57D6D88D4F;
	Sat, 28 Sep 2024 22:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iY3kvzz6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07BE988CCA; Sat, 28 Sep 2024 22:01:01 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC2A088D1F
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 22:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a2761f1227so11493415ab.0
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 13:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727553657; x=1728158457; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bA7l88sLENpaxsiGI00ZVK1xP8rWG3xOO1Xen2Udj5M=;
 b=iY3kvzz6pFDFCPPbHTNklHlhdcf70NFYoWVegSZ9iP7LQNWLukZklbzdKD1iVSqKQL
 2DNPiKZClsDVkFOErKOAzXVE+8SoOhEtFpyz+y+bWVNrNkSE65GP+9LWEeYWKpk3LcJz
 Kr9ptm8ee3sEqgpSMfMPZpNH/ec6QqnVn+R2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727553657; x=1728158457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bA7l88sLENpaxsiGI00ZVK1xP8rWG3xOO1Xen2Udj5M=;
 b=f7a5STf+D1byR70FYSa3gYHaqker9Uwkuo1zvwQWBEfBv5hYTn7di8GO7wakbmCSgY
 1NVy9CqEo7tfew3Ou4BcvmxNAWL6czHdjRTXEKSMTnkBWIpBZQOClovE/UyIxUpqrMz1
 YpR1ACAIxO8CrCPBuH6Cj8sYJkkgCIM/e97rM1hLb68gpM63Bp6WXCosuTVqioKyORDc
 GU8w5XcbSUXusl9bgcWaU4oropZLqlnbnkOFu1xGVVG3a6YaxTfIhYe07/IAV4BpwH6q
 OuNKX/b2zsM5ojSulUchh5cS3/lMenf7Of7kdx0ZwCmBnmNvUbQOmLhJHXcC3FhnRC5A
 zxww==
X-Gm-Message-State: AOJu0YwVg8JzrrERjiOq4tfvbe5GlZyHZ4kTy8pAQ2kyvEwXvnMNmyDn
 UWoZvhy/ns4VYXRqbec+Cysuum6VPMXUVZyqbp0FrS9CP6QcPyAS/LkADegDi9wo5BanG86ouIq
 D/Q==
X-Google-Smtp-Source: AGHT+IHyb6q6s+DUWd2gUXsYe0EnAvxwzpIB9KM/jKq2PDS3V9lMsr1+mTlEkogY5escJqI26hMxIg==
X-Received: by 2002:a05:6e02:1d10:b0:3a3:3e17:993f with SMTP id
 e9e14a558f8ab-3a345169210mr51145515ab.8.1727553657373; 
 Sat, 28 Sep 2024 13:00:57 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888835307sm1242590173.2.2024.09.28.13.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 13:00:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Stefan Roese <sr@denx.de>
Subject: [PATCH v2 14/30] serial: Make use of the SERIAL define
Date: Sat, 28 Sep 2024 14:00:14 -0600
Message-Id: <20240928200030.194546-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928200030.194546-1-sjg@chromium.org>
References: <20240928200030.194546-1-sjg@chromium.org>
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

This is always enabled for U-Boot proper, so simplify the condition
in the common Makefile.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/Makefile | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/common/Makefile b/common/Makefile
index 9fdad4bc38d..ae8984659c0 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -65,15 +65,7 @@ obj-$(CONFIG_DDR_SPD) += ddr_spd.o
 obj-$(CONFIG_SPD_EEPROM) += ddr_spd.o
 obj-$(CONFIG_HWCONFIG) += hwconfig.o
 obj-$(CONFIG_BOUNCE_BUFFER) += bouncebuf.o
-ifdef CONFIG_XPL_BUILD
-ifdef CONFIG_TPL_BUILD
-obj-$(CONFIG_TPL_SERIAL) += console.o
-else
-obj-$(CONFIG_SPL_SERIAL) += console.o
-endif
-else
-obj-y += console.o
-endif # CONFIG_XPL_BUILD
+obj-$(CONFIG_$(SPL_TPL_)SERIAL) += console.o
 
 obj-$(CONFIG_CROS_EC) += cros_ec.o
 obj-y += dlmalloc.o
-- 
2.34.1

