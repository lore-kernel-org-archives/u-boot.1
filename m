Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B064EB64DD
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 17:40:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9EE38696D;
	Mon, 14 Aug 2023 19:40:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VOrGagRk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48D1686963; Mon, 14 Aug 2023 19:40:01 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D564D86927
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 19:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3196fdb3238so1657092f8f.2
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 10:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692034796; x=1692639596;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9FtD53zng8SfU5eoPF99d6/vH+fB+tbapgo7o7i8lM8=;
 b=VOrGagRkL1cuxB3bd+LdYjfXqK3YmJjUTAqknnDvR5yl0mU/nw/EyqfHq6KjiHhOvB
 F6LMbU62JuEgXx+qlUqz/Yxpv0cCv+w1dlBaHI3vnaPJr3z4L9vkyW+mkgHMLENZQxSg
 Sfxyjr7ArQ2nUqRym9jC99tS5gu910cQs9CIqlnccf0jvzFi/JgGH6GkBL2X8Jh68ojH
 yGbu/YAMow4qmZGq7US2VAP87q3cshmJ+4lJTLEqeYhHhsn25fGItb7Rqw0wKnT9Nwsl
 fIZeMfdVoUV/HUAG+VnqE4R/i2PNvr1iY9xGTWAsONneV4LWexqnYLdSx9oVRUrhM41G
 iYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692034796; x=1692639596;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9FtD53zng8SfU5eoPF99d6/vH+fB+tbapgo7o7i8lM8=;
 b=eQ3hGsa5RY6AOppfoRG+5RugKDb+gTueH8igkY+zpJvp2YuPI+L+QBFCgjaeDZmtfD
 i/4LInsSBVqiE4/5DKUkdl34Ol86S5XFkEK4gWC9boV5mwPgbdMZfkmtMwRLWI4je2S4
 Mr6pEHb3H2eDq4czimMq2nms0g41BdvfOlJ0LJMpdKpg1g/pZ8U4EgJpdxZFUqd3nCFw
 gI9gAbKWCjOcaXIN2iOXS4opv/RV+bvZ/oB3j+5rvxwbVBTO/pC1tlETjP9l2FDOo912
 8/ljZxxLBXqqeEYQpvlqiiZy3KMKfQVnTXk3/EXnr+iIrhb4Gv1Niq7TvcsJNmYpmvio
 yEbA==
X-Gm-Message-State: AOJu0YzCROaXWELf/qPV4Ujpi4gFl4qoyZFDlhRl+IXlEcQEu80oqhtw
 nMf9+TjawxqTap1ljvApaDpH6Nj8zIA=
X-Google-Smtp-Source: AGHT+IHfTeIZ77j88I6Bx7GDqvvhVcsjBtruvD+W6FGq7kgnnZpgCVO05mN11uoXy8yvK6HFl2FiMw==
X-Received: by 2002:adf:ef02:0:b0:317:5b76:826 with SMTP id
 e2-20020adfef02000000b003175b760826mr6359699wro.0.1692034796003; 
 Mon, 14 Aug 2023 10:39:56 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 n24-20020a7bcbd8000000b003fbb0c01d4bsm15002406wmi.16.2023.08.14.10.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 10:39:55 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng@tinylab.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Bharat Gooty <bharat.gooty@broadcom.com>, Stefan Roese <sr@denx.de>,
 Qu Wenruo <wqu@suse.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH v2 0/4] arm: qemu: Enable Bochs, console buffering,
 USB keyboard
Date: Mon, 14 Aug 2023 20:39:40 +0300
Message-Id: <20230814173944.288356-1-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Now that the driver for the Bochs VGA card emulated by QEMU is no longer
limited to x86 architectures [1], this series enables it on arm and
arm64 virtual machines to provide a graphical interface. In line with
that series this also enables console buffering and USB keyboard.

Tested with the Debian 12 installer using GRUB EFI:

  $ tools/buildman/buildman -o build/qemu_arm64 --boards=qemu_arm64 -w
  $ cd build/qemu_arm64
  $ curl -L -o debian.img \
      https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/debian-12.0.0-arm64-netinst.iso
  $ qemu-system-aarch64 \
      -machine virt -cpu cortex-a53 -m 4G -smp 4 \
      -bios u-boot.bin \
      -serial stdio -device VGA \
      -nic user,model=virtio-net-pci \
      -device virtio-rng-pci \
      -device qemu-xhci,id=xhci -device usb-kbd -device usb-tablet \
      -drive if=virtio,file=debian.img,format=raw,readonly=on,media=cdrom

And with one using extlinux.conf:

    $ [...]
    $ curl -L -o head.img.gz \
        https://deb.debian.org/debian/dists/bookworm/main/installer-arm64/current/images/netboot/SD-card-images/gtk/firmware.none.img.gz
    $ curl -L -o partition.img.gz \
        https://deb.debian.org/debian/dists/bookworm/main/installer-arm64/current/images/netboot/SD-card-images/gtk/partition.img.gz
    $ zcat head.img.gz partition.img.gz >debian.img
    $ [...]

Both can get to a graphical installer just fine, in addition to U-Boot
video console showing up in a GTK window.

[1] video: bochs: Remove the x86 limitation
https://lore.kernel.org/u-boot/20230723044041.1089804-1-bmeng@tinylab.org/

Changes in v2:
- Add new patch for doc section on booting Linux distros
- Improve and simplify the qemu command line used for testing

v1: https://lore.kernel.org/u-boot/20230808191901.1268429-1-alpernebiyasak@gmail.com/

Alper Nebi Yasak (4):
  arm: qemu: Enable Bochs video support
  arm: qemu: Enable PRE_CONSOLE_BUFFER
  arm: qemu: Enable usb keyboard as an input device
  doc: qemu: arm: Add a section on booting Linux distros

 arch/arm/Kconfig                      | 10 ++++
 board/emulation/qemu-arm/Kconfig      |  4 ++
 board/emulation/qemu-arm/qemu-arm.c   |  5 ++
 board/emulation/qemu-arm/qemu-arm.env |  3 ++
 configs/qemu_arm64_defconfig          |  2 -
 configs/qemu_arm_defconfig            |  2 -
 doc/board/emulation/qemu-arm.rst      | 76 +++++++++++++++++++++++++++
 7 files changed, 98 insertions(+), 4 deletions(-)


base-commit: 832148f675e427060be074c276956962fa9b5cb6
-- 
2.40.1

