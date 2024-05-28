Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922ECC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:43:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEE97884D1;
	Tue, 28 May 2024 16:43:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="p/ar5dnx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 703D9884D2; Tue, 28 May 2024 16:43:07 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72B1C884CE
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:43:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 71C54400F8
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 14:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1716907384;
 bh=JRHA46RcOL92Frv+uVS2bhPvyslo+sj/SgrR31XaKpg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=p/ar5dnx8lcIPCWU9/njiorO6npGfTRaNVn+EsLzJtTJ1Y1SnuT2lV2/uSVciOgky
 5scX3KBLiXRYVNqmDb84Z7JZa0MCNNPjuIjD5aCPcYq8WG7/4RDem9TcuZ3gmStxXd
 ZCO6jwR5qBRSPmhAWWNPir/SmfP73k9r1XOIePLfNXPmHr0XpjsOOZM3RBVBW4vRCj
 2M6CY9p80gBDJK9pY4LLQVpQnBwYWD+23+CnsZsCt9p/MgryWBRQei+YZCZF/CFvsF
 4yMmZEdmpZ4YH13ATz34+gY8yBk+Mir3GembfBLG5WpirTUXdStTEork48VrQLwXXi
 KyL6/qsaAJu6A==
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-579c92cbe0fso659684a12.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716907383; x=1717512183;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JRHA46RcOL92Frv+uVS2bhPvyslo+sj/SgrR31XaKpg=;
 b=Hkq7qNoQYBXRWANpcdYR625fnM5bzmnw4IMFBJhqe7ocB3i1TkKBNynIEsXY3aBWf8
 cLl5gGGOjrGQwJ4dDn+kRcMHFflEqiQolj4uRl4qHTF4nPOZ7Gj8TLhwj8e2eiR60CDS
 ecSpMelCLJ33vic+GVkxNM3avO4Z7FcrWueMEiXjs/h2wGzVSAVyIseFfFzezuZ4M9DQ
 XqX5zuC/GOTKg30jsQkFA9ERQvBjlJTQPA+PKlOtZkCHIiYM8Rxk72jR87RBBO0blpPl
 RRKxt6nV8eZNI/Z8326bgBc8PYggD0RYkz4WQ65EY0sjKzmRx3XY/p2ibccx/v+sqDxt
 GFVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe4ubOmwzV97tgCz4RFSXWCXVAErbTJKMp9dEIfXlEpMFR+DE4Mdwv8GjW8hhjBZnWuxkI31JzDI2Fo+Qkjb11CCUKpw==
X-Gm-Message-State: AOJu0YzitlHSAY+XnEluimfy8y4iF0mkIpGMtYdRNdbCawPHb4u9ZNNQ
 AfMu60tTtM/6y2GFa3Thg1UbwjQeudFjlFVUsTbltL1phvAy2HWaIsYEjE5dNYxat3snw+X6bey
 xT2Ev+gPNfWzCvZURilAM+pO0pkWixYncZ/M06kXOBQIJskDNoO9Gbs/7qhCLQbGvjjY=
X-Received: by 2002:a50:cd43:0:b0:574:ec33:208a with SMTP id
 4fb4d7f45d1cf-578519a21c0mr8915914a12.28.1716907382968; 
 Tue, 28 May 2024 07:43:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyKCPw6PlNR/1bIMmN2FFDD1ILF77Zx0IBh1fN+n0si9QpSvgNQivdfJXW9rtYJ/6oH7FOHg==
X-Received: by 2002:a50:cd43:0:b0:574:ec33:208a with SMTP id
 4fb4d7f45d1cf-578519a21c0mr8915900a12.28.1716907382616; 
 Tue, 28 May 2024 07:43:02 -0700 (PDT)
Received: from workstation5.. ([2a00:20:d00b:f75d:fdbe:9c2a:66b:5f2b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578f47126f0sm4914986a12.91.2024.05.28.07.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:43:01 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/8] efi_loader: improve device-tree loading
Date: Tue, 28 May 2024 16:42:44 +0200
Message-ID: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
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

v2:
	Update efi_dp_concat() instead of new function efi_dp_merge().
	Carve out a function efi_load_option_dp_join() which we can
	use both for the eficonfig and the efidebug command.
	Rename variables id_dp, final_dp_size.
	Rename create_initrd_dp() to create_lo_dp_part().
	Use enum as parameter for create_lo_dp_part().
	Put all related changes into one patch.

Heinrich Schuchardt (8):
  efi_loader: allow concatenation with contained end node
  cmd: eficonfig: add support for setting fdt
  cmd: efidebug: add support for setting fdt
  efi_loader: load device-tree specified in boot option
  efi_loader: move distro_efi_get_fdt_name()
  efi_loader: return binary from efi_dp_from_lo()
  efi_loader: export efi_load_image_from_path
  efi_loader: load distro dtb in bootmgr

 boot/bootmeth_efi.c                        |  60 +---------
 cmd/eficonfig.c                            |  83 +++++++++----
 cmd/efidebug.c                             | 130 +++++++++++++++------
 include/efi_loader.h                       |  24 +++-
 lib/efi_loader/Makefile                    |   1 +
 lib/efi_loader/efi_bootbin.c               |   2 +-
 lib/efi_loader/efi_bootmgr.c               |  75 +++++++++++-
 lib/efi_loader/efi_boottime.c              |   3 +-
 lib/efi_loader/efi_device_path.c           |  40 ++++---
 lib/efi_loader/efi_device_path_utilities.c |   2 +-
 lib/efi_loader/efi_fdt.c                   | 117 +++++++++++++++++++
 lib/efi_loader/efi_helper.c                |  44 +++++++
 12 files changed, 445 insertions(+), 136 deletions(-)
 create mode 100644 lib/efi_loader/efi_fdt.c

-- 
2.43.0

