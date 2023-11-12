Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F569C4167D
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 131FE86FE8;
	Sun, 12 Nov 2023 01:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AW2j4Qfv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FCE886FF2; Sun, 12 Nov 2023 01:45:47 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03FC386E9E
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7a94c5538aeso124549139f.3
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699749942; x=1700354742; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CBYqVkFg+1moEaJVm2gKAQAD6nwqAwa0lx6V+LjrFr8=;
 b=AW2j4QfvRnYrFhzxwtWa0QHlQHvwB0G2bWnRBK6ZNcQlbcX0mbLHdwQlY21m4GdEUz
 EHkftNQOZb8K8frztcrhU3Mjb8G6Kbvhi9bEdmvfWA26WJ46l6quQCfNb84ONmPIiB9E
 tvi/qyZ1+VnmH9l6qR31dwfLMH6VTnF755McU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699749942; x=1700354742;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CBYqVkFg+1moEaJVm2gKAQAD6nwqAwa0lx6V+LjrFr8=;
 b=OD/u0lygW3TuIE7iOk/zxFf7h/GxIkfo5yK4MQrHbMYK1X2p4b59hNqORMwYmo4itG
 sYp+QGa7EUi7ZFVMxD+2JcvXWPheXMtX/4RIMJTy009oCTiiV2oGeZmbd/1ckYOuAgAM
 +8NjHJznBjj736ZvOgYXgGWPKLxeiDF7P7ojvCvRLwJxoaPF6kdGyn0YPEBXp6Y9Q0an
 olRn4xTkEGlEHen43kgFVOZbvKek2CytjEcjiCTp5Wd9zgEGQNpX+2lYFlEkCb85fnEM
 /e3KFDSTvsn7UISfzg9PRSbfWeM3jBGWuGRDmlRCAtTzC7kDTJoK0o6NnRgkvTVxQKPQ
 G0tw==
X-Gm-Message-State: AOJu0YzKXOuHVAFiIKhISkbPF06dPrt4zIZ7C+2TC12gtYY2MA9hPsJe
 DvaYg86Xs7pScD3dyt2HMSZUDsdot5KojtEzPinRuA==
X-Google-Smtp-Source: AGHT+IGCZAEb285d8Y765qaXk56TXfqW/ji0Td+dNzXajsCr+Cz7hfDa0H7jRWJlWf/yAUFn/f4JRA==
X-Received: by 2002:a5d:8ac2:0:b0:795:13ea:477a with SMTP id
 e2-20020a5d8ac2000000b0079513ea477amr4073831iot.8.1699749942536; 
 Sat, 11 Nov 2023 16:45:42 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a5ec111000000b00785cfdd968bsm765277iol.5.2023.11.11.16.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:45:42 -0800 (PST)
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
Subject: [PATCH v2 0/4] bootm: Handle compressed arm64 images with bootm
Date: Sat, 11 Nov 2023 17:45:31 -0700
Message-ID: <20231112004539.80982-1-sjg@chromium.org>
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
where the kernel is not recognised:

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
decompressed.

Another issue is that the load address is read from the 'load' property
even with a kernel_noload image. This means that the kernel is loaded
to address 0, which may not be valid on the board. We can use the
kernel_addr_r environment variable instead.

A patch is included to show the kernel load-address, so it is easy to
see what is going on.

Changes in v2:
- Add a 'success' case to the cover letter

Simon Glass (4):
  bootm: Allow ignoring the load address with kernel_noload
  bootm: Move arm64-image processing later
  image: Show the load address when decompressing
  image: Correct load_bug typo

 boot/bootm.c    | 61 ++++++++++++++++++++++++++++++-------------------
 boot/image.c    | 13 +++++++----
 include/image.h |  2 +-
 3 files changed, 48 insertions(+), 28 deletions(-)

-- 
2.42.0.869.gea05f2083d-goog

