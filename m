Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8E6C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 18:29:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC5E68283E;
	Thu,  8 May 2025 20:29:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NNmx8cQN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF3108211F; Thu,  8 May 2025 20:29:53 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EF418211F
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 20:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-af59c920d32so855481a12.0
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 11:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746728989; x=1747333789; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JhxAID9F9AzusQGLqEzvawXpPMDF3UyXzFThBkaktKI=;
 b=NNmx8cQN22JRe86Qc0sdF6pmtievd/P+b4QPsh12oLcnZNwRhvtMRJy00MB3m8uFL4
 Ygr62fs7K7QO2tfGZgB68ZQQeh/FDxq28uxWm+ht38IX48G69I7MZ53khH+3VymXAZ/+
 kRJwaHEFWc/Ept8BHUQ12eXyhd8GR15K6vLd/5dQ7Bg1NXsxNWv+uHqeNvXmUHs6z7LP
 6/yVmzVB5wwpWZC0t9/zZAllse2FarwAgHJ9uMRJaZrqQu2Om4EFPDqn69I9ztt0SCEm
 o5G+ZLrN3B35OBnJyuk8uKP530Vyd/VydkjxkCnWl3WPn1G3d+PmkrRldk2HXK5j7IVw
 rLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746728989; x=1747333789;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JhxAID9F9AzusQGLqEzvawXpPMDF3UyXzFThBkaktKI=;
 b=AMUnzy4vrubuOaD7+0sydLkHWBx2ZZxkJHE4tISOZpRneueGvZFn1cYE+I79yw4LwQ
 VPMXGKhq4nr3HnUPwWQeNvT4lPi1Rfqq9j0CiDOiH4edO9xuFSfk5AJ7uEP4ANjqKuVi
 E7+ZJ4hWAsyHvwSCZWe3jW1MLSsLhbzksVFGJAymtNQkEKIx+RP/dMr9GsOIPQoMz6Lr
 NThlzPChtswAxcECHZiHU0YaGjBbuds2rGYNcNL8LBh2PqrRzVcI8wxjyPlU1dAG5Xwx
 tAoy1QoYqIBsG9yktNyVSrersDZzEl8lJMyKq3DLa2dyDwrFVsnRyGXIBG7p1iL2n1uC
 Xbhw==
X-Gm-Message-State: AOJu0YwahTfWmWd0DWmZA/PY1hljSUsJD/KLDUNGmCJeGFallgANA/1N
 IzvC85b1AW9CnMr6BLIKmrQZd7bd0ej7vbuM3kL8ZadeZPvgZzOG9NVSQv0GOAk=
X-Gm-Gg: ASbGncsMCc47rVry/Wj4mkC3kmHv1n/rPrlSumgQksSJT6S19eGAMNza/FFtUzJLgx+
 kCAqaRi1TNaQoVCvDwKmgfcYT1L4O8pXaqQeQe3OmVDe0vLjAyo+LYYymj2lZot3YISbcwdBUqn
 CpxM77hq7rCF+xgYeAh6e+0MjdoC6SDSJ4WNJHU77jItSveFo6Po4Nw/oU2WF6RyIt4OuKmMNDQ
 Vv2iVB6+EEB0xT/q/v7c9PVhZDvJAMy7VAqsVhmTG1bfbE1XyoewEOkSWaVq3PqxeXBEzbYQFP5
 3e4SqvAFUFV86i+Q1rHiTKtcuupF/gxXahthHbbb9+SQnst4ZSAnhvO8xiBASrA=
X-Google-Smtp-Source: AGHT+IFrt2NSjYKe3D8i50TDD6LGA5peB/N/aP74+wP0KKa7xxxmfgY8qqYDqw1qxT6BMq2mZF1vjQ==
X-Received: by 2002:a17:90a:dfd0:b0:30a:214a:c64f with SMTP id
 98e67ed59e1d1-30c3d65cc85mr649614a91.32.1746728989386; 
 Thu, 08 May 2025 11:29:49 -0700 (PDT)
Received: from adriano.. ([186.175.203.217]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30ad4d56981sm2495031a91.28.2025.05.08.11.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 11:29:49 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, o451686892@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 0/3] efi_loader: test EFI booting FIT images with initrd
 and dtb
Date: Thu,  8 May 2025 14:30:31 -0400
Message-ID: <20250508183034.3439777-1-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
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

Test booting a FIT image with an EFI kernel and either a dtb
or an initrd. For this, some changes to dtbdump and initrddump
are needed. test_efi_fit creates a test image as follows:

- helloworld.efi as first "kernel" binary
- dtbdump.efi as second "kernel" binary
- initrddump.efi as third "kernel" binary
- a file of known CRC32 as "initrd"
- a device-tree with a known string
- configurations for each of the "kernel" binaries.

Then during the test run, each "kernel" binary is run. For helloworld.efi expect
'Hello, world'. For initrddump.efi, use the load command to check CRC32
of the initrd. For dtbdump.efi, use the dump command to check for the
presence of a known string in the device-tree.

Adriano Cordova (3):
  scripts/Makefile.lib: add PLATFORM_LIBS to efi linking
  efi_loader: fix dtbdump output color and format
  test/py/test_efi_fit: test fdt and initrd

 lib/efi_loader/dtbdump.c      |  86 ++++++++++++++++---
 scripts/Makefile.lib          |   2 +-
 test/py/tests/test_efi_fit.py | 156 +++++++++++++++++++++++++++-------
 3 files changed, 199 insertions(+), 45 deletions(-)

-- 
2.48.1

