Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13A1D59D6A
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 20:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02B0789A5A;
	Mon, 25 Nov 2024 21:45:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BOOTtk9j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4596389406; Mon, 25 Nov 2024 21:45:14 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA8AE89251
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 21:45:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3a789d422bcso20218985ab.1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 12:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732567510; x=1733172310; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Funs3ZKXLK23KUrMEncRYrDmJu/ptcXUGG3Y9Xu6ia8=;
 b=BOOTtk9js+1BVjZui4pfMQUCkarDkOAy/sZ14RUQor5bktSoX7WjDdZOGmoWyzacsR
 OOu57mD2DRuPmeLkzFwuXU+Em7auTqhJROjW1vkm4QUrAA69ho3yf0B1hE//Qg/cEHah
 zup/cFIDj/ggnjHnqzdxwyUNQ+AZtbxI6eLAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732567510; x=1733172310;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Funs3ZKXLK23KUrMEncRYrDmJu/ptcXUGG3Y9Xu6ia8=;
 b=ewg8Xtz+ZLAj+7XdnjxiRp04vTvFSykhTa1u1ru+gmQ3WIxdEmCJ8iBD1Pxs5o1TKe
 Ke/ma8LPhFDfZ8PkJDSsS0SKXujzzXF3T2HzA1H7aHOHFOMwQ2/HfWr2mg6jO9ZmY6eb
 Eyy9zIIcGtpi4UM/LmBiay6EuecLD9yQrkSs27ervZLzM1lMb8l4f+Xrtd16ORWou+Iz
 rWjDhLj/2yXqqd0SkUJlmzWARuT6xA/9XsQ8wOQY1I5wEys/k1vFeAdLH2AO6hl6ZC12
 4YMEaGD2dS687Tt1BZRQ5gtrBUHTm61lNeUnCq09urOSqCkKjpAhk92/EaoX27o9mgJI
 kaPg==
X-Gm-Message-State: AOJu0YxjJ5F9sIRkG6OZD+L4ARSXAEgp+3HidSYfHVpDogNaieuQxnED
 QDkr8RRFuR4+9OAsUxp4s22ewSPO0NmckDOrLfqvmQkls9q0ZPngyVTklhZunTfTXIsXrK6dTWQ
 =
X-Gm-Gg: ASbGncubxlaG96KWvuz6DOIZYf+IS9Dno+iTh+ZMfSYbhyvcy8zEclzTePdDrqfbvsY
 J0V9xKtcbg0cEdEFlI6MgVQQoomWFL65wyuIRRSxamiWaV9RjVXymWqsSezUEYcK2ddGzNMxR0l
 vQ16nPGt06bGFOZR4xdzDgb9MpEpLTAjKqzYeZ1BrcD1140V0iLRRv8DmYgqeqooklcO4Xgxow5
 xKP+VsOF33MDQQiThpTTDLpczCtFlfB9ZNGHxA6rkNL7CI=
X-Google-Smtp-Source: AGHT+IF0rpiha1o0428wAEZybgNYpH6FCLNVNTn3Ttkn0SJokfgCebkbyVUKu4OxerNn7TI+DN3Dxg==
X-Received: by 2002:a05:6602:1549:b0:835:4d07:9d46 with SMTP id
 ca18e2360f4ac-83ecdd37d4cmr1291447239f.15.1732567509780; 
 Mon, 25 Nov 2024 12:45:09 -0800 (PST)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-841ac8403a2sm26134639f.9.2024.11.25.12.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 12:45:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Janne Grunau <j@jannau.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 00/13] efi: Tidy up confusion between pointers and addresses
Date: Mon, 25 Nov 2024 13:44:39 -0700
Message-ID: <20241125204456.1525752-1-sjg@chromium.org>
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

The EFI-loader implementation converts things back and forth between
addresses and pointers, with not much consistency in how this is done.

Within most of U-Boot a pointer is a void * and an address is a ulong

This convention is very helpful, since it is obvious in common code as
to whether you need to call map_sysmem() and friends, or not.

As part of cleaning up the EFI memory-management, I found it almost
impossible to know in some cases whether something is an address or a
pointer. I decided to give up on that and come back to it when this is
resolved.

This series starts applying the normal ulong/void * convention to the
EFI_loader code, so making things easier to follow.

Link: https://lore.kernel.org/u-boot/20240725135629.3505072-1-sjg@chromium.org/


Simon Glass (13):
  efi: Define fields in struct efi_mem_desc
  efi_loader: Convert efi_get_memory_map() to return pointers
  efi_loader: Show the resulting memory address from an alloc
  efi_loader: Update startimage_exit self-test to check error
  efi_loader: Move some memory-function comments to header
  efi_loader: Use the enum for memory type
  efi_loader: Make more use of ulong
  efi_loader: Tidy up use of addresses
  lmb: Reduce mapmem contortions in lmb_map_update_notify()
  efi_loader: Simplify efi_dp_from_mem()
  efi_loader: Tidy up efi_reserve_memory()
  efi_loader: Drop extra brackets in efi_mem_carve_out()
  efi_loader: Don't try to add sandbox runtime code

 include/efi.h                                 |  15 ++
 include/efi_api.h                             |   6 +-
 include/efi_loader.h                          | 100 +++++--
 lib/efi_loader/efi_bootbin.c                  |   3 +-
 lib/efi_loader/efi_bootmgr.c                  |  11 +-
 lib/efi_loader/efi_boottime.c                 |  51 ++--
 lib/efi_loader/efi_device_path.c              |  18 +-
 lib/efi_loader/efi_dt_fixup.c                 |   8 +-
 lib/efi_loader/efi_helper.c                   |   7 +-
 lib/efi_loader/efi_image_loader.c             |   2 +-
 lib/efi_loader/efi_memory.c                   | 246 +++++++-----------
 lib/efi_loader/efi_var_mem.c                  |   6 +-
 .../efi_selftest_startimage_exit.c            |   6 +-
 lib/lmb.c                                     |  10 +-
 14 files changed, 251 insertions(+), 238 deletions(-)

-- 
2.43.0

