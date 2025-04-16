Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3FDC369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 23:31:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66B2082E3F;
	Thu, 17 Apr 2025 01:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O4I5chn7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A72882D17; Thu, 17 Apr 2025 01:31:44 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ED5682D17
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 01:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-85e73562577so17264339f.0
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 16:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744846300; x=1745451100; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bUxY1KmBkANVO8Riq62QJXr3Og48cCt57U1T3D90Lsc=;
 b=O4I5chn7NJCQ0UYaDJeHLiqNxS42wgaWcDcMLwynI+Imrrjsl7PiZlEFtc5jd1Kqxa
 O0sqp1NyjlcxSMgbHy/1GuGuttFERZsTRKRhQLpdx/gxMI1fPAaySryDuwMoBdjYW1lf
 KmJLOU0XFV39LzpKg7nEsboSkMy86mMLEsxj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744846300; x=1745451100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bUxY1KmBkANVO8Riq62QJXr3Og48cCt57U1T3D90Lsc=;
 b=peSK7oyorHWIFV+he4bF7KnqUyDxw97efG9snjRDpPYQR6elltc2Mzjw8KQQrS5A08
 rA/pAR86ox+l5HzRHVt6MGSRFXCJ7khMao7gOBZ4qMSz03lioD0ZDoA/2Ja8BksFh/MS
 c9aWjbxMG6sRvCl3kaOZKnUsA9cAafdje259L2o0S171uIwIzkVjRjofqmVAnZsHaiV7
 Kv3EjW9tct7i0AI5JEPCbpzd/9uNYJwqVaYstvEjnLlu9cN5eXeE9f2djgG5I/T9efgp
 xRfaH/bAzsJpJAF5DduhluV3FGphCNOcRI/0XcZCosNouZidCRUauUpaExO6lKml8VHV
 Dzww==
X-Gm-Message-State: AOJu0YwA06LCzZO0WwmRXmKZWgmqoESrf6dJyZhsBGAPUB0EDhVKKQRG
 Y3Y1DhgvEJ0FZz2efLK1kDbJ5zwhmJgQSE1hgVkrqXyHCMop6kBqUpCbk5lyyg==
X-Gm-Gg: ASbGncuOwEcyZSqDnrlQTG0jr0XPUcOkxXBAPi8VoEZvIYW1pMy3Y6iL+Gk2s+xHbV7
 /V9ZzXdDzCmfZvItHfgwvnocm3qHwBepz6usTuzfyr60hKqlhJhJn5o47LMUeQK47/Wqr1i5q4u
 FMTQP+VFO6KIRZTMgV8zBXIsiy0EHYLwmAXV23X7ExwP45wFNHe/d4Vafv+3hua7qKvL6hLnhnP
 gc7ADjIPxM+hMazsJKYzKgM9kEkGs5KScXMbZJGFxIyYKDC9hj3MZrmepf64fa490zEah5xUNdl
 q6eI7k6ySjmqRO3jId/1rCGGryF8NaX4hhGUzWNg1noUVX9rk7LNw/YrYQDKKEffQXoKmehb5co
 g+A==
X-Google-Smtp-Source: AGHT+IFKmutr5MZKXItXAXswywVpqnoxa6rD3mXCd8irYN3tt8P2wmiomp/2vjfJnLV5SvRutjmTcA==
X-Received: by 2002:a05:6602:1356:b0:85b:40c7:ce54 with SMTP id
 ca18e2360f4ac-861c57ece9fmr477941739f.14.1744846300232; 
 Wed, 16 Apr 2025 16:31:40 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f505dfeb06sm3923588173.95.2025.04.16.16.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 16:31:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH 2/2] ellemere: Add qemu_arm/64_spl board
Date: Wed, 16 Apr 2025 17:31:32 -0600
Message-ID: <20250416233134.2528387-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416233134.2528387-1-sjg@chromium.org>
References: <20250416233134.2528387-1-sjg@chromium.org>
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

These are similar to the existing qemu_arm/64 targets, except that the
'bios' is image.bin (containing both SPL and U-Boot) rather than in
u-boot.bin

They will be used for testing standard passage on QEMU

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 bin/ellesmere/conf.qemu_arm64_spl_na | 1 +
 bin/ellesmere/conf.qemu_arm_spl_na   | 1 +
 2 files changed, 2 insertions(+)
 create mode 120000 bin/ellesmere/conf.qemu_arm64_spl_na
 create mode 120000 bin/ellesmere/conf.qemu_arm_spl_na

diff --git a/bin/ellesmere/conf.qemu_arm64_spl_na b/bin/ellesmere/conf.qemu_arm64_spl_na
new file mode 120000
index 0000000..abbbc02
--- /dev/null
+++ b/bin/ellesmere/conf.qemu_arm64_spl_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu_arm64_spl_na
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu_arm_spl_na b/bin/ellesmere/conf.qemu_arm_spl_na
new file mode 120000
index 0000000..e171c5a
--- /dev/null
+++ b/bin/ellesmere/conf.qemu_arm_spl_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu_arm_spl_na
\ No newline at end of file
-- 
2.43.0

base-commit: b580897053862411a291a477b2a11cf076a6f14c
branch: push3
