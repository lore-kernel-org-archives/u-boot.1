Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA657C3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 12:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E115288EE7;
	Thu, 22 Aug 2024 14:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wLYwhNDi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CD3D88C4F; Thu, 22 Aug 2024 14:11:11 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45BE388EEE
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 14:11:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3718c176ed7so344461f8f.2
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 05:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724328667; x=1724933467;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qKDJX/w+xMkUdI8ntWHI6XAvMaiZem1Vx5K24SzCDCQ=;
 b=wLYwhNDidzpRmLdnG7E8sfEgnIqaptzyvv4cle5WGCAVl65EMymWg9MTSvqPC8gY4D
 /qq3knTbTabIyC7FyitbEBAAxQqJ3ECo6Ahp/dbNEDM630bO8/CzIedEAzb8q9k/WJJo
 jrEUqEc10OkdGuHziWsmKMu/s3jEGXX1ndm+F5/d26pITs+eioXR2fD0KOU1p7rayutQ
 XP/kzyYcvIJcmgouAF8wYWsXITH1RQFAggZp7usHw44OUXhMPEDhVo4hGuOzIHgCphtX
 7tfN+xUix6qliHhOkbuAlZieGjWlvLimHGhCzhooTOi2L2G4F77V+eeLxXht5sshbbra
 qRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724328667; x=1724933467;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qKDJX/w+xMkUdI8ntWHI6XAvMaiZem1Vx5K24SzCDCQ=;
 b=nBfBxIltoEukI1loIDUJZEh2hhv8NrYuy7KyFQRuIbB5WYXsPEgZwXg4FrmeaRzZ/O
 azMnMzqKVSYj5yBXueXsi+SAlDzj+O6t/yp0xlUesnCOjt88ObOieLllHKbewbYVcmSv
 CI4R5L9sLKtHIdw0EOkv2lgutrDjoQNSncgOdcUu5Z+D6vOqc1tbyTGum2Jdz79SPQP6
 WNDmMgFrkceqTsHTzB3vHmhnZzvo+wmcb1D4B0YOESHMVhhDWrH/RXFG8pRgB0jgcqPF
 YRaUfDOgxm6lbTb7P7CWovTtDLdO0vwXApjQgFqdECErdLSwsJpfb+oO6Gbt+b7n5aEh
 9VwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwnElxFFH2lOP/J5oRMdLGaUwsM/ro5t0b4h0ShasCqbWIyKxEEY2gxqNJY/yHrPl4cVAGdcE=@lists.denx.de
X-Gm-Message-State: AOJu0YxHKFpSxICASaND/om2JH/F+nXLDIlNsJ0a1XhWGqMz2g3WVtCo
 p+DfJBc+f3g/P+hvUOExLkEwec3QcY3jcVhyoev9BWXtwYindRQJM5dan/+SKlQ=
X-Google-Smtp-Source: AGHT+IHG4Gx4w/ivuvBaqlz0nwVFRpMBPsaL0CD6wSMKpK+U3Um86U0r1DrOkEv6muN3WJBEJbKGxg==
X-Received: by 2002:a5d:6c6f:0:b0:367:9d05:cf1f with SMTP id
 ffacd0b85a97d-372fd585ed7mr4103654f8f.14.1724328666028; 
 Thu, 22 Aug 2024 05:11:06 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42abee86f23sm57102875e9.20.2024.08.22.05.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 05:11:05 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Michael Walle <mwalle@kernel.org>
Subject: [GIT PULL] Please pull u-boot-dfu-20240822
Date: Thu, 22 Aug 2024 14:11:04 +0200
Message-ID: <87h6bcdag7.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Tom,

Please find some fixes for master:

- Fix crash in BCB on invalid block device (reported by coverity)
- Fix booting Android kernel without a ramdisk using fastboot
- Fix ux500 gadget driver ops based on CONFIG_USB_MUSB_HOST

CI job:
- https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/22076

Thanks,
Mattijs

The following changes since commit 0b06e052fb153958d470209dab237f12796cb0da:

  CI: Update to latest Dockerfile (2024-08-21 09:41:20 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20240822

for you to fetch changes up to e49eeb6575152cac4241f3c87471934a726970e9:

  usb: gadget: ux500: Do not redefine ops if CONFIG_USB_MUSB_HOST set (2024-08-22 09:23:33 +0200)

----------------------------------------------------------------
u-boot-dfu-20240822

- Fix crash in BCB on invalid block device (reported by coverity)
- Fix booting Android kernel without a ramdisk using fastboot
- Fix ux500 gadget driver ops based on CONFIG_USB_MUSB_HOST

----------------------------------------------------------------
Marek Vasut (1):
      usb: gadget: ux500: Do not redefine ops if CONFIG_USB_MUSB_HOST set

Mattijs Korpershoek (1):
      cmd: bcb: Fix segfault on invalid block device

Michael Walle (1):
      boot: android: fix booting without a ramdisk

 boot/image-android.c         | 7 +++----
 boot/image-board.c           | 4 +++-
 cmd/bcb.c                    | 4 ++--
 drivers/usb/musb-new/ux500.c | 6 ++----
 include/image.h              | 2 +-
 5 files changed, 11 insertions(+), 12 deletions(-)

