Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477D1D729E7
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 15:13:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73C6C89436;
	Fri, 29 Nov 2024 16:13:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gfL30H6F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 009898943C; Fri, 29 Nov 2024 16:13:27 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7A1589433
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 16:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7fbd76941ccso1432212a12.2
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 07:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732893203; x=1733498003; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l3buapTtqXDdAH/sCOgE8YFeGFJ6+ok8EoERoC/7Vtc=;
 b=gfL30H6F0cbIiG5TP5n1hkKrLMPvQzQ8YM/CuOSXFxIfiW34sSjOAEEIpMAb8dmGeM
 xM1yK0El4zaJXuu9qV9RZAYLQ3w/RXR246FD7ZBGs8ZpvA5A3a4IpYKNtmL1bIVYZzLo
 rAFe7oMg/5+mK03rsc62CjLM7SqzWrh3kQ9/BLJ5H7pl0ryehtvUg7gGfdL3exlcj3uQ
 G+wxRWADk2jBvrk5bA98OJucrnUiT5Tn3cR2g6b+BFDlK7xFss+GTqYNIq2xmxt9baLp
 f4uTSDFSYMnIForCnjKcsgHK5eMObzCtijcwwbWFoUCvLIMuvU+1NFHvvDnxiUUQaq4P
 T+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732893203; x=1733498003;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l3buapTtqXDdAH/sCOgE8YFeGFJ6+ok8EoERoC/7Vtc=;
 b=OQOg1RtDW4io1N5yvamxR82MIQtx3rRADu/C5dK8+WnIRPMwenNki/WfqmSfVjOuL0
 e/G/6liD4jU0A5f4tzyuLxo5xie9Gl0WrhZPnb9SRYDQCKzIYBwokhFhimrytqzZNV1M
 mMvjtdwvDellY1yF6/lfova6fN1jBvQbPy7hP2Wvkb/k77mzL+HqUt1nwYef3AqBpRoM
 nL+uSxnfMNl/4S+PiasGNtcoxGfr6QrJa8xrCylgF8tL7HpnBVGhlWrxREPXpVq/El24
 ViS8HVjcp9d+0IW1PPdQcs/9GEQ+ur8KryWGzDgv/5BLXKlBJMfD/odnSDYq4iMQxYVI
 GM1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCmGUG8vwTzlqDu/aWwK+G6/PSBhlrgOG5BwAIlLzslwRHqdzYc5NBYLxKElmjlvCMynk7Ot0=@lists.denx.de
X-Gm-Message-State: AOJu0YwDPYTp/ukHPiYbVAqw5uGouKrMLzORhCthZRVXLtKhcr0FsqzQ
 0rQiYqK8hKzEhnYs46DFVLWx1eYkvh6/6+V70CtFPfcBFcX6lRb6
X-Gm-Gg: ASbGnctFyi1rJ/MsnwSNJqmZ8e8pF1TdH6Z8V5tdP12ZrWVLJrRFTFxkVrPHGa4tMpK
 3g4EKfpLK683R0OT/pbDBXyHesTzAbveTj0MHYW6AHx286k+P/VA+j425hTy/itpFHcEF2UcXSk
 ghOvEl9gEVlEZmh7RLP1tGRhLSHc+r0Efhsx1PTaoUTS96YhJKtJ2nlYqvMglgItYcpxZnjuo/h
 LVtgkOo2vOdzB7GzpuiT815uzN28O0vmWZNZzidv0TrA1q8eS2Kwmwf+1FDVoxbtEQ=
X-Google-Smtp-Source: AGHT+IHGWJLqEX/8EM/kNZOkKjXpELg38UQ95TbeWSCqFXdgGiReoj1sqczuxgPU7Dc6pYiYJ5MdEQ==
X-Received: by 2002:a05:6a20:1594:b0:1db:daab:2ae7 with SMTP id
 adf61e73a8af0-1e0e0b2aad8mr18721866637.19.1732893202902; 
 Fri, 29 Nov 2024 07:13:22 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a7c1:5c7a:9f59:7dfc:875e:c37d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254180f760sm3582223b3a.132.2024.11.29.07.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2024 07:13:22 -0800 (PST)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH] verdin-am62: fix FASTBOOT_BUF_ADDR and FASTBOOT_BUF_SIZE
Date: Fri, 29 Nov 2024 12:12:57 -0300
Message-Id: <20241129151257.90607-1-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
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

From: Hiago De Franco <hiago.franco@toradex.com>

The current value of CONFIG_FASTBOOT_BUF_ADDR is incorrect for hardware
with 512MB and 1GB of RAM. The RAM address ranges for these devices are:

- 512MB:
  - Start: 0x80000000
  - End:   0xA0000000
- 1GB:
  - Start: 0x80000000
  - End:   0xC0000000

The current buffer address makes fastboot downloads work only on
hardware with 2GB of RAM.

To fix this issue:
1. Lower CONFIG_FASTBOOT_BUF_ADDR to 0x80080000. This places the buffer
   near the beginning of RAM with a 512KB offset, as starting at exactly
   0x80000000 conflicts with the ATF load address. Following
   K3_ATF_LOAD_ADDR configuration, ATF is loaded at 0x80000000:

  config K3_ATF_LOAD_ADDR
    hex "Load address of ATF image"
    default 0x80000000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5 || SOC_K3_J722S)
    default 0x70000000
    help
      The load address for the ATF image. This value is used to build the
      FIT image header that places ATF in memory where it will run.

2. Reduce the size of the download buffer to 128MB, avoiding overlaps
   with RAMDISK_ADDR_R. This is a good enough value for individual
   downloads.

Theses changes make fastboot downloads work with 512MB and 1GB devices.

Fixes: defe30a78b76 ("verdin-am62: add DFU, USB and UUU fastboot support")
Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 configs/verdin-am62_a53_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/verdin-am62_a53_defconfig b/configs/verdin-am62_a53_defconfig
index 49fb9790e295..6fa1a9d2c552 100644
--- a/configs/verdin-am62_a53_defconfig
+++ b/configs/verdin-am62_a53_defconfig
@@ -122,8 +122,8 @@ CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
 CONFIG_DMA_CHANNELS=y
 CONFIG_TI_K3_NAVSS_UDMA=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
-CONFIG_FASTBOOT_BUF_ADDR=0xC0000000
-CONFIG_FASTBOOT_BUF_SIZE=0x2F000000
+CONFIG_FASTBOOT_BUF_ADDR=0x80080000
+CONFIG_FASTBOOT_BUF_SIZE=0x8000000
 CONFIG_FASTBOOT_UUU_SUPPORT=y
 CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_GPIO_HOG=y
-- 
2.39.5

