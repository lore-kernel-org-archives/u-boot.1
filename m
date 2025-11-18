Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B47CF2562
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 23:21:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FA0F83B99;
	Wed, 19 Nov 2025 00:21:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZhUztuTZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C54983CB1; Wed, 19 Nov 2025 00:21:24 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9263181D6A
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 00:21:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-45034dbaaabso2647195b6e.3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 15:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763508080; x=1764112880; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FrgywdCFQmz6g8I4LLY7UelE0Nkb4TReDDxczM+U4Ew=;
 b=ZhUztuTZQ1XT1ezWGgjXL6f1u54geNbPoMitRiYUaF0ZQz7HyeIUG/kKxq6gIXQVpP
 tsYkYHvisJ+U7WJrvqip7sxeORBoSNhhDW+25vrDChLdlH0MlO4s/A/JBpqaz86vEpPA
 l8yUJ0XCK8cUwADATd3/AIxDE8yASO9IrkgRr33pvz5tDhcysAApoPWYOyk3dYUJBEJS
 qPBMvTZ6t8Lh4sioFhnY6tG801UxDKOcivf8eN9gkeGO1nah8yfsPyoD1dM8WWe0a2Wf
 JpDFyXdam0+KzO3VIYWUOezIdXkIZY6M0t9OdvnrXJ3+eXHIV1sGWZ/kq9Vmg9/ArA20
 V0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763508080; x=1764112880;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FrgywdCFQmz6g8I4LLY7UelE0Nkb4TReDDxczM+U4Ew=;
 b=dGn063/QnWuJfyQkSvECbKriNblu22dCw54LhdEkq2xthuWUi3gx6L48/SeqN5tuSU
 q5Z+fmo6pMMX6TF2+5dZs1zdIa5t/mSZjr6M8F0h8F1Ue0Vx707SpHj/ULmPfIvoaC3V
 Qc4n7QhqNsG3rpfvObWii0clbwRgHTRkZ6C6BkEXxmzYaYgs8bxAVFTO1PprTahFy6WF
 z+Bq/5D6zrFKz9Zld6iyEAZZ0hXWAA6qe+nuBP6f9mGRplQLNBROg8ucJPdEQLE9uBZZ
 UUUUCd9al/hUF1jljbcDIsNp19JgPk7LxvOtxEAX/KVUopZzaVFyGcYymnJqHSNu7+xk
 cBPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbYB9UBPiMT49/7lq2foktOqscY/tlYxpGW9Xs4hPnZhA49OC2FX/bPdue2pz0dlZ0HsfsEwc=@lists.denx.de
X-Gm-Message-State: AOJu0YyNjBR2ZsZt2xVUmCJuWOSHS9WKRexFMCm2LSOxG1dC0j3lt6Vu
 gsA1pZL7Wb1XqDKFg+wHXH7GuUx7v7/QQKonux0Ct9BdqKXa8pCDAoI5N9S/1CHLFiI=
X-Gm-Gg: ASbGncvSn5BA1lsoLinnTuDM45FhCli00ohNhIBVl88G18M7FTuYji4DyRUXs65/eL7
 3VuFtgIlcV4dNQYUukNVQVY3X+p37+EtCsaBktjZdpsbm2QeRUTgvcYzrcweKuNd8I4uKvI/zdD
 ja5kI67bzsAkf5jTkznaCvu2dP4nb3s0Sexzt2QfI3vC0TiyQKHdK9m2YvAh9eQ7HqrTk0NonmC
 pqZAHoDtZXLb1nOuGxpKiW8etdOIxvY6iryGQW2AmgpnB7ACR/vpoP0uKeCdAob0Dbe3pvh+YRE
 oCNwiMdaqvzkC1t0kzSw3K6svfYe1EQk47mZJ2sG5fr35c/LvrtxGVwUY5a4rMPVwjsG5Plbfb4
 suSaNcb+dgLG1sTKkLp3cU3bQ3QBIDghhf4B5Ps/kyK4gnlQX0k2a9O+T6wucStN9SEddnD2yDM
 1Ey6Nk0EeKh+9JNDOdUBa+ER/O5VOANLY=
X-Google-Smtp-Source: AGHT+IGZ7J6ZfdJE2eJ1Fl+AGl5FZAajRrDajWvCUupFvcAgpw66piYl6gtYVO3wNr+IQtZIhsCOig==
X-Received: by 2002:a05:6808:6a89:b0:44f:e4a7:74b1 with SMTP id
 5614622812f47-450ef86b39amr433068b6e.3.1763508080324; 
 Tue, 18 Nov 2025 15:21:20 -0800 (PST)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with UTF8SMTPSA id
 5614622812f47-450d7740809sm1686350b6e.15.2025.11.18.15.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 15:21:19 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.denx.de
Subject: [PATCH v3 0/6] board: samsung: e850-96: Support USB boot
Date: Tue, 18 Nov 2025 17:21:13 -0600
Message-ID: <20251118232119.17928-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.47.3
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

When U-Boot is executed during USB boot [1,2] on E850-96 board, two
issues happen:

  1. eMMC fails to initialize
  2. Attempt to use USB PHY driver leads to abort

It was identified that issue #1 happens due to enalbed Flash Memory
Protector bits in MMC block registers during USB boot, and it's handled
in patch series [3].

Issue #2 on the other hand happens because ROM code expects the
bootloader (U-Boot) to download remaining binaries (LDFW and TZSW) over
USB using SMC calls. Before that, the access to USB blocks (USB PHY and
DWC3) is disabled, probably because corresponding TrustZone domains are
configured for access from Secure World only.

This patch series implements downloading LDFW and TZSW firmware over USB
during USB boot, which makes it possible to use U-Boot for flashing
images to eMMC using fastboot and DFU protocols. That in turn simplifies
the U-Boot development, as one can use `dltool' [1] to run U-Boot binary
during USB boot, and update U-Boot on eMMC this way (e.g. using DFU).
It's not possible when using LittleKernel bootloader, as it expects
non-standard Samsung GPT partition, but in case of U-Boot we use the
regular one.

Once this patch series and patch series [3] are applied it'll be
possible to use U-Boot during USB boot. The two series are independent
of each other, and can be applied in any particular order.

Changes in v3:
  - Added PATCH #6 (enter DFU automatically on USB boot)
  - Rebased on top of the most recent master

Changes in v2:
  - PATCH #4: Return 0 on success in load_image_usb()

[1] https://gitlab.com/LinaroLtd/e850-96/tools/dltool
[2] https://docs.u-boot.org/en/latest/board/samsung/e850-96.html
[3] https://lore.kernel.org/u-boot/20251026010658.19271-1-semen.protsenko@linaro.org/

Sam Protsenko (6):
  board: samsung: e850-96: Keep public functions together
  board: samsung: e850-96: Add routines for checking boot dev
  board: samsung: e850-96: Split LDFW loading and init
  board: samsung: e850-96: Add routine for loading images over USB
  board: samsung: e850-96: Load firmwares over USB on USB boot
  board: samsung: e850-96: Enter DFU automatically on USB boot

 board/samsung/e850-96/Makefile  |  2 +-
 board/samsung/e850-96/bootdev.c | 99 +++++++++++++++++++++++++++++++++
 board/samsung/e850-96/bootdev.h | 23 ++++++++
 board/samsung/e850-96/e850-96.c | 71 ++++++++++++++++++-----
 board/samsung/e850-96/fw.c      | 76 ++++++++++++++++++-------
 board/samsung/e850-96/fw.h      | 10 +++-
 6 files changed, 246 insertions(+), 35 deletions(-)
 create mode 100644 board/samsung/e850-96/bootdev.c
 create mode 100644 board/samsung/e850-96/bootdev.h


base-commit: 91861e5a30d217d8e70130c9124c1646f4afef29
-- 
2.47.3

