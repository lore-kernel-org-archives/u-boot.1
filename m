Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1055DD69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:47:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 931D689CE1;
	Thu, 28 Nov 2024 16:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JYB2Hphf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6351E893D7; Thu, 28 Nov 2024 16:47:39 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1E6489885
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:47:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3ea4c550a3fso433271b6e.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808854; x=1733413654; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7P77r09JfHmBK9QZe5gjeQx1Pq8lMPhIMIDIYJAfYxI=;
 b=JYB2HphftL43kqJVT1rbZvq06Hx2XiydDNHMhRbFNNnT9ZwKwk92Ay/BGhn3I3Ycw0
 pYCQ1XKo4F7SsGvTpmSyr31Y5kpHUCxCFGJmtg9r8F5t6Ut2y9EMdytv6YfGBlJWJ0wt
 A2edGyhxUJPvi2l/w+OoqHUuLnKEtIUMwrn6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808854; x=1733413654;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7P77r09JfHmBK9QZe5gjeQx1Pq8lMPhIMIDIYJAfYxI=;
 b=fFaU1lbthMZWn0iUtPlqD/3LpAAPy51mgO7Ng5u3edFkslHt8SWBjm6atww6RcQKrN
 EJtIehaQALLBED2fLWDJiZ53LOF+wid+WZnXyBvQG0nX0j8gl8vDkl9ezn7MWmj7kgO+
 L1I10h8uT0F5VKzE6DZL+ChHJZNs80C1d7F82G44g37WLggtA8+bMKap2RJ6RBpi+skZ
 Syj3KL0LhjtWX8WrozVGZ2iWW0IiiPtTr0/U9XjCFwCtTUMV960x3PIiuB1PXgSzVD1b
 oaaGQOGR/pQ/vZyfpSB+BOxA7lq2d9y7oTpJ+0P3UI2hvGROsYSr0nNflDOPLqcLqp5y
 nXXw==
X-Gm-Message-State: AOJu0YwiNbXqYQqfBHWd/TcZ1K2hbjb+xH9vJBwLKYHGAbNx63bc6z8P
 h/+KkY1P/YSCmXuwEMxcyqWujJiLzkSUXeFoRbb+R8TtkX2l5Okhv7XU2a5O4P0g7jbMPwYD+aI
 =
X-Gm-Gg: ASbGncttO95pVN3QWD0xY9pCQauSo1T0WnNgOzXXv3ZXfNw5U6IJuPBAVlWZYhc7DRi
 V2IaRj7KuoUVm/jzCWyhznOyBBXFPfiQ+ClmNIlW8sErEXdRtven3Kt9b5C8UqZI3IZfBKWpc9k
 wQX4qvWKTeSdGk0TJft66aOQpDJMPNGhrOKCbVueaGN77Ikuvd695UtpRiNUHs+vETD9h9SuFGx
 ADf1npZDrOG3VZo+DqUX4qzCeg0IIXqqVXXeOX3EBnU2A==
X-Google-Smtp-Source: AGHT+IF4vPIwp32HEXJprAKox7b5xbBHuMsLEazYjtmsu4WLETihNjTq4Wdu2IhJ168Vi2rI2V8bdA==
X-Received: by 2002:a05:6808:1924:b0:3e6:40b3:e53f with SMTP id
 5614622812f47-3ea6db6166emr8818508b6e.8.1732808854597; 
 Thu, 28 Nov 2024 07:47:34 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86347014sm305419b6e.47.2024.11.28.07.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 07:47:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Janne Grunau <j@jannau.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Matthias Brugger <mbrugger@suse.com>, Moritz Fischer <moritzf@google.com>,
 Patrick Wildt <pwildt@google.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v2 00/28] efi: Tidy up confusion between pointers and addresses
Date: Thu, 28 Nov 2024 08:46:59 -0700
Message-Id: <20241128154727.771871-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

The main changes are:
- Rather than using the external struct efi_mem_desc data-structure for
  internal bookkeeping, create a new one, so it can have different
  semantics
- Within efi_memory.c addresses are used, rather than addresses
  masquerading as pointers. The conversions are done in efi_boottime

Link: https://lore.kernel.org/u-boot/20240725135629.3505072-1-sjg@chromium.org/

Changes in v2:
- Fix missing @
- Note that this holds pointers, not addresses
- Add a new patch with comments where incorrect addresses are used
- Use EFI_PRINT() instead of log_debug()
- Rebase on early patch
- Add new patch to add the EFI-loader API documentation
- Drop the changes to the boottime API
- Add new patch to use a separate stuct for memory nodes
- Drop patch 'Convert efi_get_memory_map() to return pointers'
- Drop patch 'efi_loader: Make more use of ulong'
- Significantly expand and redirect the series

Simon Glass (28):
  efi: Define fields in struct efi_mem_desc
  efi_loader: Fix typos in enum efi_allocate_type
  efi_loader: Drop extra brackets in efi_mem_carve_out()
  efi_loader: Add comments where incorrect addresses are used
  efi_loader: Show the resulting memory address from an alloc
  efi_loader: Update startimage_exit self-test to check error
  efi_loader: Move some memory-function comments to header
  doc: efi: Add the EFI-loader API documentation
  efi_loader: Use the enum for memory type
  efi_loader: Use a separate struct for memory nodes
  efi_loader: Drop virtual_start from priv_mem_desc
  efi_loader: Drop reserved from priv_mem_desc
  efi_loader: Use the enum for the memory type in priv_mem_desc
  efi_loader: Avoid assigning desc in efi_mem_carve_out()
  efi_loader: Move struct efi_mem_list fields together
  efi_loader: Rename struct efi_mem_list to mem_node
  efi_loader: Rename physical_start to base
  efi_loader: Use correct type in efi_add_runtime_mmio()
  efi_loader: Update efi_add_memory_map() to use address
  lmb: Reduce mapmem contortions in lmb_map_update_notify()
  efi_loader: Use addresses in efi_reserve_memory()
  efi_loader: Use addresses in efi_memory
  efi_loader: Update efi_add_runtime_mmio() to pass an address
  efi_loader: Correct address-usage in copy_fdt()
  efi_loader: Drop comments about incorrect addresses
  efi_bootmgr: Avoid casts in try_load_from_uri_path()
  efi_loader: Don't try to add sandbox runtime code
  efi_loader: Simplify efi_dp_from_mem()

 arch/arm/cpu/armv8/fsl-layerscape/cpu.c       |   2 +-
 arch/arm/mach-bcm283x/reset.c                 |   2 +-
 doc/api/efi.rst                               |   3 +
 include/efi.h                                 |  17 +-
 include/efi_loader.h                          | 102 ++++--
 lib/efi_loader/efi_bootbin.c                  |   3 +-
 lib/efi_loader/efi_bootmgr.c                  |  10 +-
 lib/efi_loader/efi_boottime.c                 |  51 ++-
 lib/efi_loader/efi_device_path.c              |  18 +-
 lib/efi_loader/efi_dt_fixup.c                 |   4 -
 lib/efi_loader/efi_helper.c                   |   4 +-
 lib/efi_loader/efi_image_loader.c             |   3 +-
 lib/efi_loader/efi_memory.c                   | 299 +++++++-----------
 lib/efi_loader/efi_runtime.c                  |   7 +-
 lib/efi_loader/efi_var_mem.c                  |   6 +-
 .../efi_selftest_startimage_exit.c            |   6 +-
 lib/lmb.c                                     |  10 +-
 17 files changed, 292 insertions(+), 255 deletions(-)

-- 
2.34.1

