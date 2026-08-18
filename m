Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8A4C5DF7D
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 13:50:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 040674087E;
	Tue, 18 Aug 2026 13:50:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FaXHxKEeU6S4; Tue, 18 Aug 2026 13:50:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A402B4064B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787061045;
	bh=NWtA22MklSUFhb7IN601MDVTD+9TKw0j9YPtYPo0Gj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y+cMUQbf9dCZdkuCoE2PUf8afjTq0b4iCvGOM6Jkf/d7yzqBdGpSAcVSnWcnLRhCc
	 qj9/cMBZi2vI9rAvv/4Su2KKeKv839e8N0leKw/UB1G6vPGwtmIj0ulGOewdl65+NS
	 ynAitONTEGb20hHCAo8rt17kbgnk6QRJKAZfJjdvCeM1+fwKC1nxcyGwOgI4Vg7xeD
	 lWoMcZWjg2nEWmNR21O77Z9xnD27YA2OPKv+OgEO2vPPCNzODjELM3g41AA6iOwhZd
	 MF+ie8qr4KbjHPBPQDW0+SsVxflPXn+ZsqdWW0o97iZ2EKjF2gCPgnIs9+94TDyMo4
	 Q3/DorEIixVeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A402B4064B;
	Tue, 18 Aug 2026 13:50:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 834B8282
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:23:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6906C407F0
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:23:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7KO26i0FzWN4 for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 13:23:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9009D40760
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9009D40760
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=tTIrppk6
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9009D40760
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:23:50 +0000 (UTC)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4F7443F62F
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787059428;
 bh=NWtA22MklSUFhb7IN601MDVTD+9TKw0j9YPtYPo0Gj4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=tTIrppk6lTTccN4Viz+8NAMES6GFEYqAJ/wnT+XGUdbCVHlDGxC+R0E+nUhhzif/H
 k92IUU9UwGJfY30tJ/T3OdJBonkkly+or6YR3UEoIBWI0BrNrVzSrc1blMpKMF7IFT
 yGBih2ymjL2kcA+QVzIE6Bx+JEn63EaTgr1EEakDcaS1/OF6qTiJ9qN4WpR5AHT0Rn
 cHvWbEh7NjRTyflhbbvgPUMNjMNMlIlTgGGdFpZHfA24CkbRKgJ3KBAghmdLNQ9tji
 UhGq/81qY5egfa7032AVKv4OBPhWliTz/VMvjt4sOk9jSUca70sSCzYJHFIbwbDuJO
 Qsvizra9y/ZHFG62ER8+FuvL4oigglZUkNVwdWcJTNxWdjL9md4kRUk5anAJsJkBRW
 wvsiKLyTHbrSTahkZoh5tdhILCSvYgrE7ihPos4tRVjbxsm/OxwMlSxTrJqIIs5+Ge
 gzC+04fmpiXj2W7dXwfuWSMse4Z4PZdMSxL9iC6U4Z5WbX9XABhQaLzdv3uH62fNUL
 6jHMSXh/312rcF+qYeA36sjoY9+bquKUDrcLvyv+gStkRNGw1JPi+akuekp/3B112j
 NGy0flZ9vJqb6sHmmltYs3DPlltDf6hAKhGOE39Z2Ez49nZQUyOg0pImBOuF4wfZGH
 9/XZsuNQuh4+bdLAuf6P5jLM=
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84c4cd31b51so1285591b3a.0
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787059427; x=1787664227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NWtA22MklSUFhb7IN601MDVTD+9TKw0j9YPtYPo0Gj4=;
 b=pY25UafSUz27WlDiE4EJC+6Tfk7jZJR5B8spIYi18UAIEHda0n1bHgjO2bKDXIKJt2
 TQIVRpRVpwqw5B89dKD4cDjt2Rc2PVP8bCDgwREowZRn0buvhynI20YZtCA1ABWOzPiL
 MiBef/XSL+i9libbM0ljcC6ckm5BO8JoowC8EwDIGdE+c1zQd6pEQmY+UMhtIs+VeOst
 782q7rkM8/ARdcOjVhiPjoN9W9PAo6UoBJp7FNTc0gu2S30e9USPMgksa+HsBw7z1L9S
 QD5GHdEVjZ8/Hg7EZs6n8vK2set6ayT+oIuCzujRFf0SoQ9eOkzmc80nZl90Bu7QQzrz
 +2jQ==
X-Gm-Message-State: AOJu0Yxlj3o+GD57kD10PorD2jp752vxI9nbpeBuMuyiRqVdQhCSn/QE
 UeUr+YGwnh7XUf8Oap8uuohW5I2l0PuVBZZI3yvVdVdCT7EJAtbPd9DgOT2j1GOQPMi2q7rvKor
 2Wyer0RF2DA9LDo1b5Q91LHGfqNmIOKSqMF/hQw/6eDnCFLB4cSXtiSn//0wd3M5WG3YKL3YHhE
 a7Ne7fAqcWi6QK4XCdbQ==
X-Gm-Gg: AR+sD13Q7ySp9Vg4eSgKz6oVUu3Zz+m9Ijdt9GbpsOf3y4UNflF4lhkdgo4ox2mWjUs
 AUgOZ+zpzX8OYy8H6a4RmQyqUpdKcr1KqCtTutR58Ynw+JfE+UlmW6PNsS7D9wEoLW8zfEnZk8b
 tYx2T/SniC5Ul0YuRj8AgMJkC/mtS0qMPUhMQkHhx66ng9JRWszSZcI1G5tSjct94P6mLvY7F2L
 +T9rWGkezypM7CodY5Rh8JPSXTlpmfYRIT5I73Eh1IAGxNjvapg43fWfnKcqUNukFYps5zocJaj
 rmbrO8lrW1qp2VKiFsJdepe64P36qwsOEjGoBM/fye+5ym31RxY3afwKBHXw4UjjVHk6ZZuWQ9f
 7Z8T02V7VnEvV4okhqJ36w8Z7nQMTfZaV2LJ9DHcMY482d1Sd
X-Received: by 2002:a05:6a00:1d96:b0:836:6f2e:bb6d with SMTP id
 d2e1a72fcca58-851bc3cce42mr5674255b3a.14.1787059426683; 
 Tue, 18 Aug 2026 06:23:46 -0700 (PDT)
X-Received: by 2002:a05:6a00:1d96:b0:836:6f2e:bb6d with SMTP id
 d2e1a72fcca58-851bc3cce42mr5674216b3a.14.1787059426117; 
 Tue, 18 Aug 2026 06:23:46 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b6fc0e84sm1515818b3a.43.2026.08.18.06.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 06:23:45 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, nora.schiffer@ew.tq-group.com,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 0/8] bootm: size the noload buffer from the compressor
 header
Date: Tue, 18 Aug 2026 13:23:14 +0000
Message-ID: <20260818132332.324173-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809042338.63397-1-aristo.chen@canonical.com>
References: <20260809042338.63397-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 18 Aug 2026 13:50:44 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This is v2 of "bootm: size the noload decompression buffer from the
compressor header". Tom pushed back on v1
(https://patchwork.ozlabs.org/project/uboot/patch/20260809042338.63397-2-aristo.chen@canonical.com/)
on two grounds:

  1. No concrete problem report driving the change.
  2. ~1297 platforms grew by ~170-400 bytes; the change is not
     opt-in, so the size cost falls on everyone.

On the first point, Nora Schiffer replied with a concrete use case
(EFI-in-FIT plus padded loaders such as shim, systemd-boot, and
OpenWrt's lzma-loader can produce compression ratios that outrun the
8x heuristic), and mentioned this is on the road map for TQ-Systems
standard BSPs.

On the second point, v2 reworks the implementation to cut the size
cost, measures it across the format and architecture buckets, and
splits the work per format so each decompressor's support can be
taken or dropped on its own.

Background: for a compressed kernel_noload image, bootm_load_os()
sizes the decompression buffer as ALIGN(image_len * 8, SZ_1M). The
8x heuristic works for typical kernels, but any well-compressed
payload can exceed it, and no fixed multiplier is safe against
arbitrarily compressible input.

Each implementation patch adds a small static header-parse helper in
bootm.c (no new public API) and wires it into a size-hint switch;
helper and switch case are only compiled when the matching
decompressor is enabled, so boards that do not build a format pay no
code for it. gzip's ISIZE is a fixed trailer read, lzma's size a
fixed header read, lz4 mirrors ulz4fn()'s frame-header validation,
and zstd asks zstd_get_frame_header(), whose frame-parsing code
already ships with the zstd decompressor. The header-recorded value
is attacker-controlled, so it is capped at CONFIG_SYS_BOOTM_LEN, and
it is only an allocation hint: the decoder stays authoritative
during the actual decompression.

Text size deltas of the u-boot ELF (size(1), distro gcc 13.3 cross
toolchains); data/bss are unchanged everywhere. To make the columns
directly comparable, the v1 column is v1's implementation commit
cherry-picked onto this series' base, so both columns share one
baseline:

  board          arch     decompressors        v1        v2
  qemu_arm       arm      gzip                +160      +104
  qemu-ppce500   powerpc  gzip                +176      +112
  mt7623n_bpir2  arm      gzip+lzma           +184      +128
  qemu_arm64     arm64    gzip+lzma+lz4       +384      +368
  qemu-riscv64   riscv64  gzip+lzma+lz4       +332      +352
  th1520_lpi4a   riscv64  all four            +412      +404
  am62x_evm_a53  arm64    all four, LTO       +0 *    +8192 *
  qemu-x86       x86      none                +108        -2

  * am62x_evm_a53's number is dominated by the Cortex-A53 erratum
    843419 linker workaround (default-enabled in distro binutils for
    aarch64): symbol-level code growth (nm -S) is +392 for v1 and
    +452 for v2, but those bytes shift which ADRP instructions land
    at the erratum's page offsets, and ld pads each inserted veneer
    to a full 4 KiB page. v2 happens to trigger two such pages here;
    v1 triggered the same two on its own original base and none on
    this one. See the world-build note below.

To see how much each bucket weighs, I configured all 1550 defconfigs
and sorted them by which decompressors they enable next to bootm:

  858  gzip only (722 of them arm, essentially the 32-bit boards)
  530  gzip+lzma+lz4 (494 arm, mostly arm64, plus 36 riscv)
   38  gzip+lzma
   31  bootm with no decompressor at all
   27  gzip+lzma+lz4+zstd
   19  gzip+lz4
   15  gzip+zstd
    6  other combinations
   26  do not link bootm at all

To measure at the same scale as the original objection, I also ran a
full world build (buildman, all 1550 defconfigs, distro plus
kernel.org toolchains, gcc 13.3/14.2) over one branch holding the
base, the v1 implementation, its revert, and this series. 1496
boards built on all four commits with the revert reproducing the
base sizes exactly (44 boards did not build on every commit, and 10
built nondeterministically; both sets were excluded). Of those 1496,
the same 1375 change under either version and the rest are
untouched, including every board without bootm or without a
decompressor:

                                        v1            v2
  mean delta over all boards          +194 B        +166 B
  median delta (changed boards)       +160 B         +96 B
  median, 856 gzip-only boards        +112 B         +80 B
  median, 517 gzip+lzma+lz4 boards    +392 B        +376 B
  boards cheaper with v2                   -          1222
  boards costlier with v2                  -            74

The world build also puts the am62x footnote in proportion: 53
boards under v1 and 49 under v2 (28 in both sets), all arm64, show
size(1) jumps of one or two 4 KiB pages in either direction (min
-8192, max +8192). The mechanism is the Cortex-A53 erratum 843419
linker workaround: when a code change shifts which ADRP instructions
land at page offsets 0xff8/0xffc, ld materialises a 16-byte veneer
and pads it to a full 4 KiB page so the page offsets of all
downstream code stay unchanged. Any few-hundred-byte change re-rolls
which boards are affected, in both directions; symbol-level growth
on every such board I checked matches the byte ranges above.

Since Tom noted the higher growth in his run was on multi-algorithm
platforms: building each patch in sequence on a gzip+lzma+lz4 board
(qemu_arm64) and an all-four board (th1520_lpi4a) gives the
per-format cost directly, in bytes:

               qemu_arm64    th1520_lpi4a
  gzip             +112             +86
  zstd               +0             +62
  lz4              +176            +176
  lzma              +80             +80

(zstd is +0 on qemu_arm64 because that board does not enable it, so
the guard really does compile the helper out.) lz4 is the most
expensive parser because it mirrors ulz4fn()'s frame validation;
zstd is the cheapest because zstd_get_frame_header() already ships
with the decompressor. Since the series is split per format, if the
multi-algorithm cost still looks too high, dropping the lz4 patch
alone would cut the 517-board gzip+lzma+lz4 bucket from a median of
+376 to roughly +200; lz4 images then simply keep the 8x fallback.

In the v1 thread Simon suggested recording the uncompressed size as
a FIT property instead. As discussed there, the two compose: a FIT
property could be layered on top later, with bootm preferring the
property, then the stream header, then the 8x fallback. This series
provides the part that works for every existing image and for the
legacy uImage form of kernel_noload.

Series layout, one decompressor at a time:

  1. gzip helper + wiring
  2. gzip pytests (lying-header overflow, header-sized, boundary)
  3. zstd helper
  4. zstd pytest (guarded by requiredtool zstd)
  5. lz4 helper
  6. lz4 pytest (guarded by requiredtool lz4)
  7. lzma helper
  8. lzma pytests (real size patched into the header field, plus the
     "unknown" size marker fallback; needs no external tool since
     Python's lzma module is in the standard library)

Every patch builds in isolation on sandbox_defconfig and
qemu_arm_defconfig; the seven kernel_noload_decomp pytests and the
full test_fit class pass on sandbox.

Changes in v2:
- split the single implementation patch into per-format patches
  (gzip, zstd, lz4, lzma), each acceptable or droppable on its own
- make the helpers static in bootm.c, compiled only when the
  matching decompressor is enabled, instead of one always-built
  public image_decomp_get_uncompressed_size() in boot/image.c; this
  removes the cost from boards without the formats entirely
- regroup the pytests per format, next to the patch they exercise
- add runtime lzma coverage (header-recorded size and the "unknown"
  marker fallback) in place of v1's parser-only C unit test, which
  cannot reach a static helper
- measure the size cost on a common base across all 1550 boards and
  document the per-bucket numbers and the arm64 erratum-843419 page
  effect in this cover letter

Aristo Chen (8):
  bootm: size the noload gzip decompression buffer from ISIZE
  test: fit: cover the kernel_noload gzip header-size and lying-header
    paths
  bootm: size the noload zstd decompression buffer from
    Frame_Content_Size
  test: fit: cover the kernel_noload zstd header-size path
  bootm: size the noload lz4 decompression buffer from Content_Size
  test: fit: cover the kernel_noload lz4 header-size path
  bootm: size the noload lzma decompression buffer from the header
  test: fit: cover the kernel_noload lzma header-size and unknown-size
    paths

 boot/bootm.c              | 144 ++++++++++++++++++++++-
 test/py/tests/test_fit.py | 282 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 400 insertions(+), 26 deletions(-)

--
2.43.0
