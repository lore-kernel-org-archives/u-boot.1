Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753F5D3C544
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 03:00:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA2B58918F;
	Fri, 18 Oct 2024 05:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Oc+mhFAt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 823718916D; Fri, 18 Oct 2024 05:00:48 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D9DB89175
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 05:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3a3b3f4a48bso5304985ab.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 20:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729220445; x=1729825245; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AVLsxpBGcunrQTDDtHWSxhYKOixndPwt/BjadDE5yL8=;
 b=Oc+mhFAtHYVc4eYCFrfuwfvQJhxczamLpjHplI36kX7OK+8c4zsuV6gpkFy380+YC2
 PdoNeBWdW2d/+WaZCdWaV+7DsVA42LDeoeqFTCUVlDy9btVYENcM7rwK4fO6SCjiT0gd
 0rj4Bn8N8O+IBLWgKViQuIU5sa1Ja9tgXK5j0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729220445; x=1729825245;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AVLsxpBGcunrQTDDtHWSxhYKOixndPwt/BjadDE5yL8=;
 b=ppMXMhVW3Df9k5tf6FSzshQycx7BmbqYPBf5zgKS9efF900AYAr7jcgb018f6gK57k
 XC0ftHxkxwGtodiiba/BJ05RuszAlqkEDjwCgNvc+quUhM2DgDditH8mmIysCjKaW3Xg
 nV9d67f7HC5kj1ZhML54/IgXZPO3li4mMXJ1sQTDMCyNkwTDcjT9uerEnZawiQ8VPg+y
 qZ7aImZ6272lQGtM63JANX3I6twq2aBQwzQ/miHqP2SH5hMHzuY7b9lvUU6Y7KH/CKhC
 t/2Kp/l+u9OLd8uRSzXQZdwui/YvdHhr6jIS/WENGBkH+KQYXN6TuP9tHWGOMVz5Se60
 neDQ==
X-Gm-Message-State: AOJu0YxFIqKZ8Y1ktmfMPQuNDdQj0zzpBrfk6jzWMZ/rJucZVLW7WKt2
 P78Ds4amTNbvLPpMo6MuNSHZxamh2UBK09/aRTK+wC8yfiXRTj3eNCAT04hzAyoBHa+63qdffbo
 =
X-Google-Smtp-Source: AGHT+IHkICowrDmc4opVxoJ6Tv0YV+BZ9+rab/Iqv5Z0ei0VQKrtmjgVws6VW27CMWNCOyKH9qRhrg==
X-Received: by 2002:a05:6e02:1a23:b0:39d:3c87:1435 with SMTP id
 e9e14a558f8ab-3a3e5294362mr34884175ab.1.1729220444902; 
 Thu, 17 Oct 2024 20:00:44 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83e6dsm192499173.39.2024.10.17.20.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 20:00:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>, Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/8] membuff: Add tests and update to support a flag for
 empty/full
Date: Thu, 17 Oct 2024 21:00:19 -0600
Message-Id: <20241018030027.842749-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

The membuff implementation curently has no tests. It also assumes that
head and tail can never correspond unless the buffer is empty.

This series provides a compile-time flag to support a 'full' flag. It
also adds some tests of the main routines.

The data structure is also renamed to membuf which fits better with
U-Boot.

There may be some cases in the code which could be optimised a little,
but the implementation is functional.


Simon Glass (8):
  membuff: Rename functions to have membuf_ prefix
  membuff: Rename the files to membuf
  membuf: Rename struct
  membuf: Include stdbool
  membuf: Correct implementation of membuf_dispose()
  membuf: Add some tests
  membuf: Minor code-style improvements
  membuf: Support a flag for being full

 MAINTAINERS                       |   7 +
 arch/sandbox/include/asm/serial.h |   2 +-
 boot/bootmeth_extlinux.c          |   8 +-
 common/console.c                  |  32 ++--
 drivers/serial/sandbox.c          |  10 +-
 drivers/usb/emul/sandbox_keyb.c   |   8 +-
 include/asm-generic/global_data.h |   6 +-
 include/{membuff.h => membuf.h}   |  98 ++++++------
 lib/Makefile                      |   2 +-
 lib/{membuff.c => membuf.c}       | 134 ++++++++++------
 test/lib/Makefile                 |   1 +
 test/lib/membuf.c                 | 244 ++++++++++++++++++++++++++++++
 12 files changed, 427 insertions(+), 125 deletions(-)
 rename include/{membuff.h => membuf.h} (67%)
 rename lib/{membuff.c => membuf.c} (69%)
 create mode 100644 test/lib/membuf.c

-- 
2.34.1

