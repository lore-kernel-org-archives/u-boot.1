Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD379C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED48D885A3;
	Fri, 26 Apr 2024 16:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="S9W/eO/V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF444885AF; Fri, 26 Apr 2024 16:13:50 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB0798857C
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C0CE43F17D
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 14:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714140826;
 bh=Xn6nWubBL19EDGjrFqb3XXxecvSzg5HtQsQJBUwrJrs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=S9W/eO/VHDHzY0MPi2w8difOIpAXSZDEjUDpRc84nILqJHKuC5jEeolEFaDrElY0S
 1jDdm9EqpyCX4sKRcAIsE0Wl+cZ4Rso0cOqu+cMBEeuxHF864spYie0g7rt9DJ2FVS
 m3dzp46KzJkoPDT0r+I9Q/ZBwJ67EAKkZZk5CbB06FLLzWPMeNKTlsCpzmI7FIJKXg
 6vk6zr+N1qfWxvn8k0oyndOHLxP8p1CafZLWSbwukClOSfnodsvvCmZqXxycVQy/P1
 OPjUziaXewvFKTpiedzaG4YVZikSFLxZ/udC3QHDLhsauoBbv19zBNT3/AEEm2SMyM
 wStTFyxD4asGw==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4147de378b9so10114415e9.3
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 07:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714140826; x=1714745626;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xn6nWubBL19EDGjrFqb3XXxecvSzg5HtQsQJBUwrJrs=;
 b=iJAAvkEjqlU3Qx8sCxCrOtZA38Uz4jKrTsHBXO+/50LUO0QNSvImjfI4BV3CsSqn9i
 x1GlUQF1R88BM6ojvMF5LKHuyAOV0lq56mqkjS3NbTvU0plCoKoGJl/EPmYYrw6CLps4
 yNycN5c4tgQK1Wbz2oX5ReduhYsi8JknTSpqTTPP/dJu5M7FbSJE8z+M05U0lcAX7/Sv
 35JJ4IxYQyxVZQ7H9I4ckVfB/U5T6JrKTqPgjXu3m5ietx9xANDM6Eq0BxEWiclj8ngw
 gRGnO4g2kyCNL35a5EubsXL1gXxCt2oUps1r2Vkd5zr7bwd/wKBj3PTHX8EfOf1s7COQ
 FZOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI5gnyvtbyduiLTJdoPWWXi6PWVnVyNWBzKE0K3jyXtPSvjhOtUFnlHlZF7jK5f5CCvyjPUfa1+Bb5p0rPMkbXUiITcw==
X-Gm-Message-State: AOJu0Yx8QmOUbrWMVZlOwtcw1VVbvwu/6rOLZU9tx9EDsksewDMjKqO0
 xIhOLn0V+UxvPM4xFo1uwkAIUk8G1HNCJMYdV3CDS4HsqsuRFOf91X+mTzDISgil8tPxgoUOwDU
 MOzdzd6L8c3vLX3KLrAW3YBQS+qpAE39aMsy42sB0oyN/u6Ahtoj36V0riQVREiZcEjg=
X-Received: by 2002:a05:600c:3546:b0:419:f505:8a7e with SMTP id
 i6-20020a05600c354600b00419f5058a7emr2020159wmq.3.1714140826118; 
 Fri, 26 Apr 2024 07:13:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/b9o6Q5j/Yu4UzqhYt1ATMv+W11PzCO1qACFPF3FKdZWxUKPb1gLww/tHc9UjgVMB2suqLQ==
X-Received: by 2002:a05:600c:3546:b0:419:f505:8a7e with SMTP id
 i6-20020a05600c354600b00419f5058a7emr2020144wmq.3.1714140825707; 
 Fri, 26 Apr 2024 07:13:45 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 s20-20020adfa294000000b003455e5d2569sm1460593wra.0.2024.04.26.07.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 07:13:44 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 00/14] efi_loader: improve device-tree loading
Date: Fri, 26 Apr 2024 16:13:07 +0200
Message-ID: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
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

In U-Boot EFI boot options can already specify both an EFI binary and
an initrd. With this series we can additionally define the matching
device-tree to be loaded in the boot option.

With the last patch the boot manager will fall back the device-tree
specified by $fdtfile in directories '/dtb/', '/', or '/dtb/current/'
on the boot device if no device-tree is specified in the boot
option or via a bootefi command parameter.

Heinrich Schuchardt (14):
  efi_loader: pass GUID by address to efi_dp_from_lo
  efi_loader: library function efi_dp_merge
  efi_loader: simplify efi_dp_concat()
  cmd: eficonfig: add support for setting fdt
  cmd: efidebug: add support for setting fdt
  efi_loader: superfluous efi_restore_gd after EFI_CALL
  cmd: terminate efidebug test bootmgr early on error
  efi_loader: improve error handling in try_load_entry()
  efi_loader: do not install dtb if bootmgr fails
  efi_loader: load device-tree specified in boot option
  efi_loader: move distro_efi_get_fdt_name()
  efi_loader: return binary from efi_dp_from_lo()
  efi_loader: export efi_load_image_from_path
  efi_loader: load distro dtb in bootmgr

 boot/bootmeth_efi.c                           |  60 +-----
 cmd/bootefi.c                                 |   1 -
 cmd/eficonfig.c                               |  90 +++++++--
 cmd/efidebug.c                                |  89 +++++++--
 include/efi_loader.h                          |  15 +-
 lib/efi_loader/Makefile                       |   1 +
 lib/efi_loader/efi_bootbin.c                  |   2 +-
 lib/efi_loader/efi_bootmgr.c                  | 186 +++++++++++++-----
 lib/efi_loader/efi_boottime.c                 |   3 +-
 lib/efi_loader/efi_device_path.c              |  77 +++++---
 lib/efi_loader/efi_device_path_utilities.c    |   2 +-
 lib/efi_loader/efi_fdt.c                      | 117 +++++++++++
 lib/efi_loader/efi_helper.c                   |   6 +-
 lib/efi_loader/efi_load_initrd.c              |   2 +-
 test/py/tests/test_efi_secboot/test_signed.py |  28 +--
 .../test_efi_secboot/test_signed_intca.py     |  10 +-
 .../tests/test_efi_secboot/test_unsigned.py   |   6 +-
 17 files changed, 489 insertions(+), 206 deletions(-)
 create mode 100644 lib/efi_loader/efi_fdt.c

-- 
2.43.0

