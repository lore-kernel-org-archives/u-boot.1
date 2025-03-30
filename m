Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9010C36011
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 09:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B3A680F9C;
	Sun, 30 Mar 2025 11:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kx7cWA/m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22AAD81879; Sun, 30 Mar 2025 11:09:32 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9F2380BA8
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 11:09:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e61375c108so4548951a12.1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 02:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743325769; x=1743930569; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LOsvLG/Sgauu7qnysrI/3mcj2q+Ynu7IpaUCO2EiL5E=;
 b=kx7cWA/mAf4qaWtPFJfDzJTsQoGMtuaFilZ8Gt74cVGW1bzebiOfhUUhaVQzBHy22j
 gfDPARvM9UnIC5cqngV4w5N5uECDaLq6qU99iYX92OkgfQosPFvfwyTK6yOEe7yJz1wP
 5qr63wKzsM045+HwBd/j3G/z90/TtKrdczUzkbFmfzaCr+LWFyj8NJZ62iiX/xmSzhlU
 pMfkFOmrgQHow413zj0mEyEyi5QK7PxHVBCq/kBVFZ2OHjf8eLPwpN6kOz5FnYtPj6yH
 nAOcyMoGpAhrRChQKJk/6rNU3YYNRDrXWGwtN5fnKnIXuouV8P944JYFISHYkXcYvH5a
 +bGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743325769; x=1743930569;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LOsvLG/Sgauu7qnysrI/3mcj2q+Ynu7IpaUCO2EiL5E=;
 b=n6fVfElMQJTxtgjozlprCdFcqsZWQy1m/tx0w1pd6jbm4a6t108ecT7Pxx0O24WZW6
 fcq9mlPfZ0T5/dgIraTv5Uc7KSKc5aj8Om4E7X0zhssEPWjlrRicEi6KVpyDEFarI+V1
 nQVl9v4TemT9SnsYwmNyChE96smOhKjYSsCrAUFFzBFxNcylxV1JxMatffiFVm32GKxb
 NKmfz+3eZSpeEG9B6fKGWKxrjohHR4DVCJe+aOQIxrum22yQ3FDKgKY5AJf7bpFJlUTG
 zEGyQJUJoC6DA6tUQW/Ds+eQCswdLaZoEP7UlZSzUuah4EicXmbXmxkQ8MZ9QsuKHJHY
 wBPQ==
X-Gm-Message-State: AOJu0Ywcto64UGayRR3WHs9T+RuEypQmWBGY4SeadhY+7MyhW8Lqo1C+
 qysM74jqAOy2qKmw0Zdso05CX5Nyn3B3c8S06Wr8DnFUVw27xV4O
X-Gm-Gg: ASbGncv8IBuqrCt7qEQ31bbf5+tg47pqnCYLdXi1/Om2GgMkEj4ydVwCzwsuFKaZK/k
 Y/LEHaRLJ2WFEXtpid/XiUKmmTqo6pSRfDlp/xyHz8C/7NzsxcLrKOEkRFQS7FIr2IBRJpioo2a
 UJP3BMFxs5EerzjdQcqwJS6cgMJ2H6pyDHhKXlXI8Pzh7btVhdrNgX0rXjF43z8oAeyGsKB8tZv
 cC+90dq49bPPuMHFCtbspwaDFUNw3PIkUHDhxqxq05HUZ7Kh86QFxh4NeM8D3nR/XtbYlPc+vzg
 cB/YJ4aDnSqcSYOKdB6sD6dAweDzOod1uxqw
X-Google-Smtp-Source: AGHT+IHLHnHRmGGMFjVHt/NgXduVUoIA51Fajs4hzml2/YtSinkBU13Cyf2i2M2GgKRAHdalzEa9xQ==
X-Received: by 2002:a17:907:3da3:b0:ac7:1c1a:d0f6 with SMTP id
 a640c23a62f3a-ac738be3aa2mr405098866b.37.1743325769237; 
 Sun, 30 Mar 2025 02:09:29 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71922ba0fsm453376466b.27.2025.03.30.02.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 02:09:28 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Please pull u-boot-tegra fixes
Date: Sun, 30 Mar 2025 12:09:19 +0300
Message-ID: <20250330090920.9021-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Dear Tom,

The following changes since commit 02d95aaee01a2faf53bba8f1417b55cd02b6a743:

  Merge branch 'next' of https://source.denx.de/u-boot/custodians/u-boot-sunxi into next (2025-03-27 08:10:06 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tegra.git fixes

for you to fetch changes up to 5c0f34a0c9ea2fb34d608a5adb6632230b1c273c:

  configs: mocha: add missing SPL_HAVE_INIT_STACK option (2025-03-30 11:16:47 +0300)

----------------------------------------------------------------
Svyatoslav Ryhel (2):
      configs: ouya: add missing SPL_HAVE_INIT_STACK option
      configs: mocha: add missing SPL_HAVE_INIT_STACK option

 configs/mocha_defconfig | 1 +
 configs/ouya_defconfig  | 1 +
 2 files changed, 2 insertions(+)

Ouya and Mocha were added around the same time SPL_HAVE_INIT_STACK was
introduced by Simon and therefore do not include this config option. It is
critical to add it before any defconfig resync, since the SPL_STACK option
will then be removed.

Commits are rebased onto latest u-boot/next. Sorry for inconvenience.

Thanks,
Svyatoslav Ryhel.
