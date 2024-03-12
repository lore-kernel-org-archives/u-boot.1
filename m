Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99545C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 14:08:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1374187F4B;
	Tue, 12 Mar 2024 15:08:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bk472wDA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DE5E87F3F; Tue, 12 Mar 2024 15:08:40 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5C9F87F4F
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 15:08:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56878bb1abdso713002a12.1
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 07:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710252516; x=1710857316; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cOy2uF2CBBUxUuHeFfA8fza0Id0OgyUZtvNJr3XBGU0=;
 b=bk472wDAZ+HlsDZdkf+iiZXpoVm6E4STM7W4qboIEL4rrYwvms7C6kfIbWuDTCn8h8
 7bX+Xko3qjTo4OLKVKZsmwsPotepBvC6Mniwrg5Jf+hE9wtIS9F2sNN0ZkY5ihpPdfpB
 cRL36cWmeCIdz7OvkbUA5SsiHeixtzNs6M53sMeK40Upe8dfw2r+BEqXPOHmNYlSNsm8
 AyD9tu0Fuo/CeXxkQK2CMAyvYCKB3AM5RxTSBcTPWtR0JMFYA9HAN7F091SQZDyCbgT7
 AmnRLiMdL2rfatA011SzcsBOTY//KnrNwCnelzBWYrF0C7H7Vy97C7/l6JxggFtGSD3u
 45RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710252516; x=1710857316;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cOy2uF2CBBUxUuHeFfA8fza0Id0OgyUZtvNJr3XBGU0=;
 b=BaURQlB5FlCxXyUQdDE+5DQ54j3/tp4yZX5lq2jBxI66V5K6pBEtJjQ+L5ApuEb7yl
 MTagwRMUmHbCY4Fv0ac/70ztLP+fiKqumWJiH7M8dY6kibx/rttULmTRVEdwfxPdpty3
 MQNJv89kiPb0eiHz985OIsl8uVud4I9HXOt1LfWeKCtTxeppHROdqalVXHQsHrwh12om
 oGb5F6Hc/eDUuYVg2mCWLFHW4iHXKiD+zECBJqmQwl5LFkx5+FqSeJ+oXW07ksWkomvX
 /YxCxDHGldZc2tTK21rwCzxk2Wqv2UoWJW5GIo6k2Udq4V0Kjxn1Gfcfy0lrYJxrAXDY
 W+ag==
X-Gm-Message-State: AOJu0Yynki4WQ5cffzb5mjEmy7eEG3rfNiMMvA4Le820udFxCFDlMjR7
 uxjZTDO3kM80FwM90iqkW7wX/aVL+vTH7dqnxfAjS3FlB1t173TLNfYJGqkxFXN7KC5tLWqKdT8
 6cek=
X-Google-Smtp-Source: AGHT+IF7Ozxi5zXJM7z6pK8nHLPS4DBRxm3URoELAgMew7BjZ2vPBDXcAXcdDr3hfJWAuqhiiGpNQQ==
X-Received: by 2002:a50:c192:0:b0:567:4a1:d80f with SMTP id
 m18-20020a50c192000000b0056704a1d80fmr1519303edf.17.1710252516200; 
 Tue, 12 Mar 2024 07:08:36 -0700 (PDT)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 d23-20020a056402001700b0056857701bf5sm2246086edu.81.2024.03.12.07.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:08:35 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com,
	cfsworks@gmail.com
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 richard.henderson@linaro.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <CFSworks@gmail.com>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
Subject: [PATCH 0/7 v2] Clean up arm linker scripts
Date: Tue, 12 Mar 2024 16:08:22 +0200
Message-Id: <20240312140832.1968215-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
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

The arm linker scripts had a mix of symbols and C defined variables in an
effort to emit relative references instead of absolute ones e.g [0]. A
linker bug prevented us from doing so [1] -- fixed since 2016.
This has led to confusion over the years, ending up with mixed section
definitions. Some sections are defined with overlays and different
definitions between v7 and v8 architectures.
For example __efi_runtime_rel_start/end is defined as a linker symbol for
armv8 and a C variable in armv7.

Linker scripts nowadays can emit relative references, as long as the symbol
definition is contained within the section definition. So let's switch most
of the C defined variables and clean up the arm sections.c file.
There's still a few symbols remaining -- __secure_start/end,
__secure_stack_start/end and __end which can be cleaned up
in a followup series.



For both QEMU v7/v8 bloat-o-meter shows now size difference
$~ ./scripts/bloat-o-meter u-boot u-boot.new
add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
Function                                     old     new   delta
Total: Before=798861, After=798861, chg +0.00%

The symbols seem largely unchanged apart from a difference in .bss
as well as the emited sections and object types of the affected variables.

On the output below the first value is from -next and the second comes from
-next + this patchset. The .bss_start/end sections have disappeared from the
newer binaries.

# For example on QEMU v8:
efi_runtime_start
  7945: 0000000000000178     0 OBJECT  GLOBAL DEFAULT    2 __efi_runtime_start
  7942: 0000000000000178     0 NOTYPE  GLOBAL DEFAULT    2 __efi_runtime_start
efi_runtime_stop
  9050: 0000000000000d38     0 OBJECT  GLOBAL DEFAULT    2 __efi_runtime_stop
  9047: 0000000000000d38     0 NOTYPE  GLOBAL DEFAULT    2 __efi_runtime_stop
__efi_runtime_rel_start
  7172: 00000000000dc2f0     0 OBJECT  GLOBAL DEFAULT   10 __efi_runtime_rel_start
  7169: 00000000000dc2f0     0 NOTYPE  GLOBAL DEFAULT   10 __efi_runtime_rel_start
__efi_runtime_rel_stop
  7954: 00000000000dc4a0     0 OBJECT  GLOBAL DEFAULT   10 __efi_runtime_rel_stop
  7951: 00000000000dc4a0     0 NOTYPE  GLOBAL DEFAULT   10 __efi_runtime_rel_stop
__rel_dyn_start
  7030: 00000000000dc4a0     0 OBJECT  GLOBAL DEFAULT   11 __rel_dyn_start
  7027: 00000000000dc4a0     0 NOTYPE  GLOBAL DEFAULT   11 __rel_dyn_start
__rel_dyn_end
  8959: 0000000000102b10     0 OBJECT  GLOBAL DEFAULT   12 __rel_dyn_end
  8956: 0000000000102b10     0 NOTYPE  GLOBAL DEFAULT   11 __rel_dyn_end
image_copy_start
  9051: 0000000000000000     0 OBJECT  GLOBAL DEFAULT    1 __image_copy_start
  9048: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT    1 __image_copy_start
image_copy_end
  7467: 00000000000dc4a0     0 OBJECT  GLOBAL DEFAULT   11 __image_copy_end
  7464: 00000000000dc4a0     0 NOTYPE  GLOBAL DEFAULT   10 __image_copy_end
bss_start
    12: 0000000000102b10     0 SECTION LOCAL  DEFAULT   12 .bss_start
  8087: 0000000000000018     0 NOTYPE  GLOBAL DEFAULT    1 _bss_start_ofs
  8375: 0000000000102b10     0 OBJECT  GLOBAL DEFAULT   12 __bss_start
  8084: 0000000000000018     0 NOTYPE  GLOBAL DEFAULT    1 _bss_start_ofs
  8372: 0000000000102b80     0 NOTYPE  GLOBAL DEFAULT   12 __bss_start
bss_end
    14: 000000000010bc30     0 SECTION LOCAL  DEFAULT   14 .bss_end
  7683: 000000000010bc30     0 OBJECT  GLOBAL DEFAULT   14 __bss_end
  8479: 0000000000000020     0 NOTYPE  GLOBAL DEFAULT    1 _bss_end_ofs
  7680: 000000000010bc30     0 NOTYPE  GLOBAL DEFAULT   12 __bss_end
  8476: 0000000000000020     0 NOTYPE  GLOBAL DEFAULT    1 _bss_end_ofs

# For QEMU v7:
efi_runtime_start
 10703: 000003bc     0 OBJECT  GLOBAL DEFAULT    2 __efi_runtime_start
 10699: 000003c0     0 NOTYPE  GLOBAL DEFAULT    2 __efi_runtime_start
efi_runtime_stop
 11796: 000012ec     0 OBJECT  GLOBAL DEFAULT    2 __efi_runtime_stop
 11792: 000012ec     0 NOTYPE  GLOBAL DEFAULT    2 __efi_runtime_stop
__efi_runtime_rel_start
  9937: 000c40dc     0 OBJECT  GLOBAL DEFAULT    8 __efi_runtime_rel_start
  9935: 000c40dc     0 NOTYPE  GLOBAL DEFAULT    9 __efi_runtime_rel_start
__efi_runtime_rel_stop
 10712: 000c41dc     0 OBJECT  GLOBAL DEFAULT   10 __efi_runtime_rel_stop
 10708: 000c41dc     0 NOTYPE  GLOBAL DEFAULT    9 __efi_runtime_rel_stop
__rel_dyn_start
  9791: 000c41dc     0 OBJECT  GLOBAL DEFAULT   10 __rel_dyn_start
  9789: 000c41dc     0 NOTYPE  GLOBAL DEFAULT   10 __rel_dyn_start
__rel_dyn_end
 11708: 000da5f4     0 OBJECT  GLOBAL DEFAULT   10 __rel_dyn_end
 11704: 000da5f4     0 NOTYPE  GLOBAL DEFAULT   10 __rel_dyn_end
image_copy_start
   448: 0000177c     0 NOTYPE  LOCAL  DEFAULT    3 _image_copy_start_ofs
 11797: 00000000     0 OBJECT  GLOBAL DEFAULT    1 __image_copy_start
   445: 0000177c     0 NOTYPE  LOCAL  DEFAULT    3 _image_copy_start_ofs
 11793: 00000000     0 NOTYPE  GLOBAL DEFAULT    1 __image_copy_start
image_copy_end
   450: 00001780     0 NOTYPE  LOCAL  DEFAULT    3 _image_copy_end_ofs
 10225: 000c41dc     0 OBJECT  GLOBAL DEFAULT   10 __image_copy_end
   447: 00001780     0 NOTYPE  LOCAL  DEFAULT    3 _image_copy_end_ofs
 10222: 000c41dc     0 NOTYPE  GLOBAL DEFAULT    9 __image_copy_end
bss_start
    11: 000c41dc     0 SECTION LOCAL  DEFAULT   11 .bss_start
 11124: 000c41dc     0 OBJECT  GLOBAL DEFAULT   11 __bss_start
 11120: 000c41dc     0 NOTYPE  GLOBAL DEFAULT   11 __bss_start
bss_end
    13: 000cbbf8     0 SECTION LOCAL  DEFAULT   13 .bss_end
 10442: 000cbbf8     0 OBJECT  GLOBAL DEFAULT   13 __bss_end
 10439: 000cbbf8     0 NOTYPE  GLOBAL DEFAULT   11 __bss_end

It's worth noting that since the efi regions are affected by the change, booting
with EFI is preferable while testing. Booting the kernel only should be enough
since the efi stub and the kernel proper do request boottime and runtime
services respectively.
Something along the lines of
> virtio scan && load virtio 0 $kernel_addr_r Image && bootefi $kernel_addr_r
will work for QEMU aarch64.

Tested platforms:
- QEMU aarch64
- Xilinx kv260 kria starter kit & zynq
- QEMU armv7
- STM32MP157C-DK2

[0] commit 3ebd1cbc49f0 ("arm: make __bss_start and __bss_end__ compiler-generated")
[1] binutils commit 6b3b0ab89663 ("Make linker assigned symbol dynamic only for shared object")

Changes since v1:
- bring back overlays for armv7 rel.dyn and bss sections and add a comment
  explaining why we overlay those
- Remove redundant alignment from sections (new patch #7)
- Added r-b tags from Sam
Changes since RFC:
- Rebase on top of -next and get rid of the dragonboard linker script changes.
  Caleb removed that file completely
- Rewrite some commit messages to include the binutils bug details (thanks Sam)

Ilias Apalodimas (7):
  arm: baltos: remove custom linker script
  arm: clean up v7 and v8 linker scripts for bss_start/end
  arm: fix __efi_runtime_rel_start/end definitions
  arm: clean up v7 and v8 linker scripts for __rel_dyn_start/end
  arm: fix __efi_runtime_start/end definitions
  arm: move image_copy_start/end to linker symbols
  arm: remove redundant section alignments

 arch/arm/cpu/armv8/u-boot-spl.lds           |  21 +---
 arch/arm/cpu/armv8/u-boot.lds               |  38 +-----
 arch/arm/cpu/u-boot-spl.lds                 |   2 +-
 arch/arm/cpu/u-boot.lds                     |  66 +++-------
 arch/arm/lib/sections.c                     |  10 --
 arch/arm/mach-aspeed/ast2600/u-boot-spl.lds |   2 +-
 arch/arm/mach-rockchip/u-boot-tpl-v8.lds    |  21 +---
 arch/arm/mach-zynq/u-boot-spl.lds           |   2 +-
 arch/arm/mach-zynq/u-boot.lds               |  67 +++-------
 board/vscom/baltos/u-boot.lds               | 128 --------------------
 include/asm-generic/sections.h              |   3 +
 lib/efi_loader/efi_runtime.c                |   1 +
 12 files changed, 52 insertions(+), 309 deletions(-)
 delete mode 100644 board/vscom/baltos/u-boot.lds

--
2.37.2

