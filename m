Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01307C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 21:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE382846B4;
	Mon,  6 Jul 2026 23:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kCZ2uN3X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EA62848BF; Mon,  6 Jul 2026 23:54:59 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5562D801A9
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 23:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cace91f112so29715065ad.0
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 14:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783374896; x=1783979696; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K+/EUQvO6Yain5Bui6b529b5yzSvnk0WdmPg/KqzhHs=;
 b=kCZ2uN3X9CoJCcr7qNoc/nUxsr2k1BlDiGGsGv7rDX33M4cv9QQdM61uXftjvRLQSC
 WcjNBY8IiAVikHJAQzEDMPLjsXNOyEDpSKAu6PaY/rHOhEy6EmDlxAMd9uWrYo4PMvey
 CMKctyBRY8xNXh4Bp/boWQGQ+z4A1oRaTOGoe+Z4BkcBi0k+Nk9MZSmS3yTfz6RqFXbr
 ll7cnlzAEoFx25a0jUdwoteQa2OQMAtjWwefUt3frkSmFWyFm7aGYBoRL+i7CB0WxcFq
 DH5InDrTuTT/c08OjyaDvXBOzEKJWzrvNkqu2m1v8UrqaWQXuXxV7cv9kNxgP9s34w6+
 G1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783374896; x=1783979696;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K+/EUQvO6Yain5Bui6b529b5yzSvnk0WdmPg/KqzhHs=;
 b=A5NdH6yE/ofkFM8z+3gDYRFQgtMWlDy+dx1UPDBox6SR+89nOY/jf74oAWalkTXCxH
 loXjNWaezEjt+SQxNwZccDP1GwJ5ZYFT6BuEdmOyzlK85+oSq67IA9OrljNSAIvgZiQb
 Eo11fzyv7MHy1wHkArFieB4qjFxOf93ecoNbWxjNt6sWP4/xW8+sqbJYJ3KPqjj9llr6
 2H+M38SbjvJ5BEd6LIrGecbdxQcyE+8mBrXGgisnpgeaMmHREFAiAmxiR5PdDeDygG0g
 w0dMknPrP0YspU/fl5Rr17uCDiMw5ceS8XjhkuU8K5e46pAsiNr1zZG+fALp+2c+VGXy
 PayA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrIWSF3YouobhNP/P8skqykxbxJsniqqVwXghLB1h/xT2ga+e7Sd6+FK64SlUwK3vBjxW3k7YU=@lists.denx.de
X-Gm-Message-State: AOJu0YyNZ5uVyEGWmhC+zwrSVTFqkv2/x5Pyn9UDIOmATIg2dZrkMROc
 rxd1NvQWFjH6xrapsgl4dsNizpjSu8ImkEGAu+N+svN+dta3//Gq+VdJSZq8LA==
X-Gm-Gg: AfdE7ckuNOUwgLw1iiPSdTKee8me9AxO2S3qH4OePZ5Xuc4FaaD199ZVrWSF3MA8M9b
 3asV/RHpihtY5lUq1xUC9pehsyMPkTDi9y+JWxz8BtYd98AW6ZlQl+yiPDFy0CQVu5Xek1dAU7u
 ClpNXCn00O70BPC24U0NLoHobEQf0rqi62DcRobP6iKy2jh0lwdySIRLaTrjVBH+G/0o3IT7pF9
 Mjg4HU4uOfjRaFIh2/StsMtwmfjgnTAf9AtxMWorMonL8Amoyigk2CkmqsNqf5+r6CFNOj+xh6a
 e6CtELPtCAwq3RxjrjyA7H/iZCgkgpnIg1mZan4kV47S/b29W3RFpRWwJc0Hy5/U6MGDDytwN5q
 5HvMcnNQpsqUDyYTl4+86gzPi/GN8k72EURsGs/5OrXXD7A2mQtw20VvPWkORHoebLF1R+/JOaM
 86hYCMt4o3VcG6ajaJFlAk6pkzm+3tbnsDAsi5D3WpMklApwsleQ+5GVCcMGuIuO4nMjtNoq7Qy
 LNXjTu9YOFQ
X-Received: by 2002:a05:6a21:a383:b0:3bf:d1f9:b1d5 with SMTP id
 adf61e73a8af0-3c08efad6fcmr2646569637.60.1783374895700; 
 Mon, 06 Jul 2026 14:54:55 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174a56d64sm650864eec.17.2026.07.06.14.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 14:54:55 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com, bmeng.cn@gmail.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com, jerome.forissier@arm.com
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 u-boot@lists.denx.de, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 0/4] fs: Add 9P filesystem support over virtio
Date: Mon,  6 Jul 2026 21:54:42 +0000
Message-ID: <20260706215446.4068820-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
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

Add 9P network filesystem support to U-Boot.

It allows U-Boot to directly mount host directories in virtualization
environments via virtio.

The functionality has been verified on qemu arm64 by successfully
loading a Linux kernel image and an initramfs image via 9P, and booting
to the Linux shell.

To test with QEMU:
  -fsdev local,id=fsdev0,path=/path/to/host/dir,security_model=none \
  -device virtio-9p-device,fsdev=fsdev0,mount_tag=rootfs

U-Boot usage:
  => virtio scan
  => ls 9p - /
  => load 9p - $kernel_addr_r /Image
  => load 9p - $ramdisk_addr_r /initramfs.cpio
  => booti $kernel_addr_r $ramdisk_addr_r:$filesize $fdtcontroladdr

Kuan-Wei Chiu (4):
  net: 9p: Add 9P2000 protocol support
  fs: 9p: Add 9P filesystem support
  virtio: 9p: Add 9P transport driver
  MAINTAINERS: Add entry for 9PFS

 MAINTAINERS                    |   8 +
 drivers/virtio/Kconfig         |   7 +
 drivers/virtio/Makefile        |   1 +
 drivers/virtio/virtio-uclass.c |   1 +
 drivers/virtio/virtio_9p.c     |  75 +++++++++
 fs/9p/9p.c                     | 137 +++++++++++++++++
 fs/9p/Kconfig                  |   8 +
 fs/9p/Makefile                 |   5 +
 fs/Kconfig                     |   2 +
 fs/Makefile                    |   1 +
 fs/fs.c                        |  35 +++++
 include/9p.h                   |  82 ++++++++++
 include/fs.h                   |   1 +
 include/virtio.h               |   4 +-
 net/9p/Kconfig                 |   5 +
 net/9p/Makefile                |   5 +
 net/9p/client.c                | 272 +++++++++++++++++++++++++++++++++
 net/Kconfig                    |   2 +
 net/Makefile                   |   1 +
 19 files changed, 651 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virtio/virtio_9p.c
 create mode 100644 fs/9p/9p.c
 create mode 100644 fs/9p/Kconfig
 create mode 100644 fs/9p/Makefile
 create mode 100644 include/9p.h
 create mode 100644 net/9p/Kconfig
 create mode 100644 net/9p/Makefile
 create mode 100644 net/9p/client.c

-- 
2.55.0.rc2.803.g1fd1e6609c-goog

