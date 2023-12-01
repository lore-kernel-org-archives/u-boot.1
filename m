Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E62C4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 18:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B1E7876F8;
	Fri,  1 Dec 2023 19:44:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fXvQPePK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A94AD87707; Fri,  1 Dec 2023 19:44:37 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9FBB8749E
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 19:44:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a1a0bc1e415so121573066b.0
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 10:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701456275; x=1702061075; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PirjQj5uXhTLy3VIar2gWmw2Fj9+d/ckd4hqhVnESy4=;
 b=fXvQPePKTH7Xe6VHgHXhOAN2aO+xYwZPyVyWemys7RAYyryB945/cNue3upTlRP8Ub
 PC5ohPZk971d36NxVeo+fgG+UP9qm318dOsdu8qqW4vn1jVRWuIi2iT7ho+ysx0vWlzq
 hx7YKg/weuudGKDq66I26E2QEj9cziu6X2/ZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701456275; x=1702061075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PirjQj5uXhTLy3VIar2gWmw2Fj9+d/ckd4hqhVnESy4=;
 b=ge6QqAtNQ1s0g7FCYCNeI3ln7ulJN28HKaUuTxQNgVLCcDnhO0Civ7DHVc2Vswvwd6
 L5go3mOmU8H1F1v+tz85ntpiEfmqs4G5+n8cqOjfcVLingkJncfoESNIP1p1Wh/Ne81V
 DEYRLVNEAeR/81bevMRDiI9UEP3UKIfURrwhtX9C3hd3MlaXo5/swH0UC+luIeAszuqo
 Ixb8675QCeM/fl1VsrrvlwooNYMKrX+4SIjW/R9qMikHVmOv7/wijQUxfuKbncholyVJ
 Xdh0CAdm5y7q8GV4JRLe8/3/H72VBdS/ZGV8PihszdpVkUFkCwE6yGEo77Kt/AQgw80Z
 Fh6g==
X-Gm-Message-State: AOJu0YwGNUv391b/DdrjT2XGCuXJG99FR8SNClSfbWI/sLKczEcFs0Vt
 OR8EF7K5fkjp2zH+5KqfGvT9fHV0SbkdxU2p7z4sNqcbhmqT1qJ/624=
X-Google-Smtp-Source: AGHT+IEtMzSgsmAp3si4vCmT17E7nGTNbK5b6jhIQoLx5xJgYCRTVhHDIBA7+kfofjNvlx/WOgsnj79fTyxJdkhaNbw=
X-Received: by 2002:a17:906:4911:b0:a19:13a8:e7b6 with SMTP id
 b17-20020a170906491100b00a1913a8e7b6mr1309367ejq.32.1701456274935; Fri, 01
 Dec 2023 10:44:34 -0800 (PST)
MIME-Version: 1.0
References: <20231122131154.2444690-1-trini@konsulko.com>
 <20231122131154.2444690-11-trini@konsulko.com>
In-Reply-To: <20231122131154.2444690-11-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 1 Dec 2023 11:44:22 -0700
Message-ID: <CAPnjgZ12X6VRM1CubjBemCOPceSok-5L859aRtxvSOJN=SROiw@mail.gmail.com>
Subject: Re: [PATCH 11/11] lib: Remove <common.h> inclusion from these files
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 22 Nov 2023 at 06:13, Tom Rini <trini@konsulko.com> wrote:
>
> After some header file cleanups to add missing include files, remove
> common.h from all files in the lib directory. This primarily means just
> dropping the line but in a few cases we need to add in other header
> files now.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  lib/abuf.c                                        | 1 -
>  lib/acpi/acpi.c                                   | 1 -
>  lib/acpi/acpi_device.c                            | 1 -
>  lib/acpi/acpi_dp.c                                | 1 -
>  lib/acpi/acpi_table.c                             | 1 -
>  lib/acpi/acpi_writer.c                            | 2 +-
>  lib/acpi/acpigen.c                                | 1 -
>  lib/acpi/base.c                                   | 3 ++-
>  lib/acpi/csrt.c                                   | 2 +-
>  lib/acpi/dsdt.c                                   | 2 +-
>  lib/acpi/facs.c                                   | 2 +-
>  lib/acpi/mcfg.c                                   | 4 +++-
>  lib/acpi/ssdt.c                                   | 3 ++-
>  lib/addr_map.c                                    | 1 -
>  lib/aes.c                                         | 2 +-
>  lib/aes/aes-decrypt.c                             | 1 -
>  lib/asm-offsets.c                                 | 2 +-
>  lib/at91/at91.c                                   | 1 -
>  lib/bch.c                                         | 1 -
>  lib/binman.c                                      | 1 -
>  lib/bzip2/bzlib.c                                 | 3 +--
>  lib/bzip2/bzlib_decompress.c                      | 1 -
>  lib/charset.c                                     | 1 -
>  lib/circbuf.c                                     | 1 -
>  lib/crc16-ccitt.c                                 | 2 --
>  lib/crc32.c                                       | 1 -
>  lib/crc32c.c                                      | 1 -
>  lib/crc8.c                                        | 2 --
>  lib/crypt/crypt-port.h                            | 3 +++
>  lib/crypt/crypt.c                                 | 1 -
>  lib/crypto/x509_public_key.c                      | 1 -
>  lib/date.c                                        | 1 -
>  lib/dhry/cmd_dhry.c                               | 3 ++-
>  lib/dhry/dhry_1.c                                 | 2 +-
>  lib/dhry/dhry_2.c                                 | 2 +-
>  lib/efi/efi.c                                     | 1 -
>  lib/efi/efi_app.c                                 | 1 -
>  lib/efi/efi_info.c                                | 1 -
>  lib/efi/efi_stub.c                                | 1 -
>  lib/efi_driver/efi_block_device.c                 | 1 -
>  lib/efi_driver/efi_uclass.c                       | 1 -
>  lib/efi_selftest/efi_selftest_esrt.c              | 1 -
>  lib/efi_selftest/efi_selftest_miniapp_exception.c | 1 -
>  lib/efi_selftest/efi_selftest_miniapp_exit.c      | 1 -
>  lib/efi_selftest/efi_selftest_miniapp_return.c    | 1 -
>  lib/elf.c                                         | 1 -
>  lib/errno_str.c                                   | 2 +-
>  lib/fdtdec.c                                      | 1 -
>  lib/fdtdec_common.c                               | 1 -
>  lib/fdtdec_test.c                                 | 1 -
>  lib/getopt.c                                      | 2 +-
>  lib/gunzip.c                                      | 1 -
>  lib/gzip.c                                        | 1 -
>  lib/hang.c                                        | 2 +-
>  lib/hash-checksum.c                               | 1 -
>  lib/hashtable.c                                   | 1 -
>  lib/hexdump.c                                     | 2 +-
>  lib/image-sparse.c                                | 1 -
>  lib/initcall.c                                    | 1 -
>  lib/linux_compat.c                                | 1 -
>  lib/list_sort.c                                   | 1 -
>  lib/lmb.c                                         | 1 -
>  lib/lz4.c                                         | 1 -
>  lib/lz4_wrapper.c                                 | 1 -
>  lib/lzma/LzmaDec.c                                | 1 -
>  lib/lzma/LzmaTools.c                              | 1 -
>  lib/lzo/lzo1x_decompress.c                        | 3 ++-
>  lib/md5.c                                         | 1 -
>  lib/membuff.c                                     | 1 -
>  lib/net_utils.c                                   | 2 +-
>  lib/of_live.c                                     | 1 -
>  lib/optee/optee.c                                 | 1 -
>  lib/panic.c                                       | 1 -
>  lib/physmem.c                                     | 2 +-
>  lib/qsort.c                                       | 1 -
>  lib/rand.c                                        | 1 -
>  lib/rc4.c                                         | 3 ---
>  lib/rsa/rsa-keyprop.c                             | 1 -
>  lib/rsa/rsa-mod-exp.c                             | 1 -
>  lib/rsa/rsa-verify.c                              | 1 -
>  lib/rtc-lib.c                                     | 1 -
>  lib/semihosting.c                                 | 3 ++-
>  lib/slre.c                                        | 2 +-
>  lib/smbios-parser.c                               | 1 -
>  lib/smbios.c                                      | 1 -
>  lib/strto.c                                       | 2 +-
>  lib/tables_csum.c                                 | 3 +--
>  lib/time.c                                        | 1 -
>  lib/tiny-printf.c                                 | 1 -
>  lib/tpm-common.c                                  | 1 -
>  lib/tpm-v1.c                                      | 1 -
>  lib/tpm-v2.c                                      | 1 -
>  lib/tpm_api.c                                     | 1 -
>  lib/trace.c                                       | 2 +-
>  lib/uuid.c                                        | 2 --
>  lib/vsprintf.c                                    | 1 -
>  lib/zstd/zstd.c                                   | 2 +-
>  97 files changed, 36 insertions(+), 103 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
