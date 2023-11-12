Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A72C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 03:50:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFDE887545;
	Sun, 12 Nov 2023 04:50:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i40BnISz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69A72870E1; Sun, 12 Nov 2023 04:50:27 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48C4486F88
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 04:50:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-35937f2fadeso14169585ab.2
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 19:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699761013; x=1700365813; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Naq7lggbqFCED+lOh1obzitKj0JAW87Y1eVVSqJdLOE=;
 b=i40BnISzfddimqJ8X7J2efXFiD/sN4AtOglQicG+X/LnX6lE8FYt3uEEJSYl43gZ26
 p/gtGZIyfV2IKHLVha0tfPVhE3fbuZEGmmT9hwwRDR1Ot1kfm/E/JJJgFXD8rU7hlqhp
 Wz9FLMAuH/hOPhU4d7siEGc6tVbRijSSpEdxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699761013; x=1700365813;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Naq7lggbqFCED+lOh1obzitKj0JAW87Y1eVVSqJdLOE=;
 b=iAJDyLGGTH7dpSw6aWgxm0bRSLMPtMUbiYm+ZTTq2s+tCuqZgi1onymuXTjEViiQY6
 7b9t7XgsgUWBQL43vIqaTZQ6+mHWz8dW/lHPl0gJz/VKTAcOQJN8muNi7K36b7Nx8ego
 hRDuESChMHis85DB5U2NmYSrq3I+ZTseN3FzfbkMEW6+XOzq5gtZ5QHC7idFsP+vnxqO
 Hx8HgcEuk5ZbfsjW0DrlI6igipypEU4gNNZ/7NqR50Yf+VWejTx4PdGQOleMgLODW7fs
 aqcb2L2deLwdZJpbIFQCWucS6FNLu81KGG7ytd15tmi8wLqqskJlPpu1GRg6zXcuDR5N
 cSQA==
X-Gm-Message-State: AOJu0YzzDOa82vITsJvu1JI6Jok6ESYHHxReoiENyGRohHAchqvJEHCp
 t+LjMIEGpBC876PPFtmaN5AaYqW1ts3wdcE+a3AiAw==
X-Google-Smtp-Source: AGHT+IFUlSljPuxfi+HFpixQIYhYz6u2EP9FpiDy/amN3eFF8yzqQOMs5Mc/ZY9jBk1/eHLjXpWBfw==
X-Received: by 2002:a6b:140c:0:b0:780:d76c:b640 with SMTP id
 12-20020a6b140c000000b00780d76cb640mr3412801iou.9.1699761013059; 
 Sat, 11 Nov 2023 19:50:13 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a056602305000b007791e286fdbsm817864ioy.21.2023.11.11.19.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 19:50:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 0/5] bootm: Handle compressed arm64 images with bootm
Date: Sat, 11 Nov 2023 20:49:52 -0700
Message-ID: <20231112035001.103897-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
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

This little series corrects a problem I noticed with arm64 images,
where the kernel is not recognised if compression is used:

   U-Boot> tftp image.fit
   Using ethernet@7d580000 device
   TFTP from server 192.168.4.7; our IP address is 192.168.4.147
   Filename 'image.fit'.
   Load address: 0x1000000
   Loading: ##################################################  23 MiB
   	 20.5 MiB/s
   done
   Bytes transferred = 24118272 (1700400 hex)
   U-Boot> bootm
   ## Loading kernel from FIT Image at 01000000 ...
      Using 'conf-768' configuration
      Trying 'kernel' kernel subimage
        Description:  Linux
        Type:         Kernel Image (no loading done)
        Compression:  gzip compressed
        Data Start:   0x01000120
        Data Size:    13662338 Bytes = 13 MiB
      Verifying Hash Integrity ... OK
   Bad Linux ARM64 Image magic!

With this series:

   U-Boot> tftp 20000000 image.fit
   Using ethernet@7d580000 device
   TFTP from server 192.168.4.7; our IP address is 192.168.4.147
   Filename 'image.fit'.
   Load address: 0x20000000
   Loading: ##################################################  23.5 MiB
   	 20.8 MiB/s
   done
   Bytes transferred = 24642560 (1780400 hex)
   U-Boot> bootm 0x20000000
   ## Loading kernel from FIT Image at 20000000 ...
      Using 'conf-768' configuration
      Trying 'kernel' kernel subimage
        Description:  Linux
        Type:         Kernel Image (no loading done)
        Compression:  zstd compressed
        Data Start:   0x20000120
        Data Size:    14333475 Bytes = 13.7 MiB
      Verifying Hash Integrity ... OK
   Using kernel load address 80000
   ## Loading fdt from FIT Image at 20000000 ...
      Using 'conf-768' configuration
      Trying 'fdt-768' fdt subimage
        Description:  Raspberry Pi 4 Model B
        Type:         Flat Device Tree
        Compression:  zstd compressed
        Data Start:   0x215f820c
        Data Size:    9137 Bytes = 8.9 KiB
        Architecture: AArch64
      Verifying Hash Integrity ... OK
      Uncompressing Flat Device Tree to 3aff3010
      Booting using the fdt blob at 0x3aff3010
   Working FDT set to 3aff3010
      Uncompressing Kernel Image (no loading done) to 80000
   Moving Image from 0x80000 to 0x200000, end=2b00000
      Using Device Tree in place at 000000003aff3010, end 000000003afff4c4
   Working FDT set to 3aff3010

   Starting kernel ...

   [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd083]

The problem is that the arm64 magic is checked before the image is
decompressed. However this is only part of it. The kernel_noload image
type should not be permitted with compression, so this series adds a
check for that.

Another issue is that the arm64 handling is done too early, before the
image is loaded. This series moves it to after loading, so that
compression can be handled.

This series also adjusts the 'load' address to be optional, since it is
often not possible to select a load address which can work with all
boards. We can use the kernel_addr_r environment variable instead.

A patch is included to show the kernel load-address, so it is easy to
see what is going on.

One annoying feature of arm64 is that the image is often copied to
another address. It might be possible for U-Boot to figure that out
earlier and decompress it to the right place, but perhaps not.

With all of this it should be possible to boot a compressed kernel on
any of the 990 arm64 boards supported by Linux, although I have only
tested two.

Changes in v2:
- Allow omitting the load address rather than messing with kernel_noload
- Rework the patch based on a better understanding of events
- Add a 'success' case to the cover letter
- Redo how the arm64 support is implemented

Simon Glass (5):
  image: Correct load_bug typo
  image: Show the load address when decompressing
  bootm: Allow omitting the load address
  bootm: Move arm64-image processing later
  boot: Don't allow kernel_noload with compression

 boot/bootm.c                         | 67 ++++++++++++++++++----------
 boot/image.c                         | 13 ++++--
 doc/usage/fit/source_file_format.rst |  7 ++-
 include/image.h                      |  2 +-
 4 files changed, 60 insertions(+), 29 deletions(-)

-- 
2.42.0.869.gea05f2083d-goog

