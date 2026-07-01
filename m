Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E53C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 12:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCA0584BC1;
	Wed,  1 Jul 2026 14:00:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QMB/fJEB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA0FA84C22; Wed,  1 Jul 2026 14:00:14 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBC92841F2
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 14:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-697564cb69eso1394671a12.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 05:00:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782907212; cv=none;
 d=google.com; s=arc-20260327;
 b=I4QjWuCG1hStfsT3tV87AjmwAD1TkWqy6VpFyMb8kihFVWnGXGK5xC2xqurRZsgrG0
 LkBV4tY+MUskb0ZrScFzkZODyjxOww+zAoffnM/RpVV6qXRmfpdZ2U1797cQzws65zpx
 Za7/yZB827hP54eEEo3owhhPxgmdhcu5IVOnacdVAuQoCsx/C8awpJybaYg9P0P2Jdr7
 SMKRLJXsyEf1LZXLLy96Ss2CiKI6Mf9eInJqP5Z5JO9OSHt8CmjiXy7pNrvrQGcx/8mu
 b2sv/FaeeR2COoF8sS4T4PA7RkDW85w/wzXllcThJ9toR4JOzxXywu0iN1e6qdSHXeLj
 TBEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h8JR2a3a6egLvPACY07QpNE8KVqFapNCAKCUpBvrHTM=;
 fh=6aTww0k35WzsNQ9Nw6xJ4vg18Y7yucnNltbPB2b9AyE=;
 b=D2+jiBRXxaoNMBTH2mV4N+hdIjzTLowY/YYaotx5Nq6eEf952TL6LouFh/KySIBne2
 +uMbPYoFhg+1zuFlDGAOt6H+NycmJuTnhkZMX+8qFxtpI9vZHhurH6UdsAHoCsAwYgaz
 AE8VogTvzfQZoCSCL2hA24pUS4PpnPGqccBUcOjGjqTl5bSmJX3/lzhigo1MMEASL3YV
 14gJkDhRygrUP42SIiAykdZEb1Ud/wvwLEKO9zz/wl2RSolv0Du8vd6qS1b5pn3Qr560
 vUr4Yn0v3zgTRAaokK3sVgrOfpAm6BkjWpSDCRK1MydmhnKidR8Wi01nci9R81H/coJA
 FGjQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782907212; x=1783512012; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h8JR2a3a6egLvPACY07QpNE8KVqFapNCAKCUpBvrHTM=;
 b=QMB/fJEBfQkHaWqOJKD05926CV+91cfogFaaHiWbUj1KxtpswAqMbfOLnTxqCRpZPC
 dakkEkTyyHn/vnezngxj1jELE8m/gUqNWeaOfsDTEyVofrOwcGPWywgGs6lAfyEfh54T
 Ny62lMX18QLx/KC+wrog7mQqttEnvR+T+24s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782907212; x=1783512012;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h8JR2a3a6egLvPACY07QpNE8KVqFapNCAKCUpBvrHTM=;
 b=qj0DQvZpherOech0UtsebJe6TW8LR4MTBauFVo/7yvc88JQPvkacfytymrxZOyKNcq
 5cYCKIfgC2zjJGdoJhbgOVuJAfXzj05ggf6YwpGLZ5+0r745KuuIc9iH7LRWWYypK9Dy
 LtQ8zwYPAw3E9h5B/gnCc2FlpkT2GNHZGoExo8Ahal4H5ua3FAJp+kxIdlM8f0aVmMM3
 vj7oYM+y+2Q62IClozND+dzaNRHQo77MG9iIN5UTfmtV5UgXuXbwSTR9Nyk8Myj80rbI
 Rywd6BBO9dxXuJdkhgcCL24fMuvgZyL7Pi1XJVJgPsF1ZZCH4Mlgx5cvHh0XdAzB7Qh5
 uXFA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq0V1kOu+j956C+T6DyxFoxArsgyBjNNyxXbsNMUbkL/3zPJKfw7ftvYO6o7PIi6RonqxISrso=@lists.denx.de
X-Gm-Message-State: AOJu0YwQsQN/D/TbuLmv96pqb3VmoXM8wpWlTP67LGoMNhqERN++sOv6
 4Xe9NC6+dZuP7SN2GNzqbMdkwa5krM9ID83lCUNZtu7iXT6ODkSahcErQap39tgwFux6PsIP2b2
 SsKoUEI46ACHMZAbmJwIe/N+fBfm0ZdzNdTwpqL+O
X-Gm-Gg: AfdE7ckRcIY7lMb8FZiOJaBSXdTQiG76barGLPKZ58uj/mX+6HW2/CrHc/r2Pp61nbR
 ibICQ2G1a5CAo1TRrmWbHLQJzuVKMKB8FSc78+tbKzq1YS0XqBp7q6cn7dccxJXDzvxpX0xAGeT
 rBV8TyenZbxf67pDo8JCjxNx/qFkSw8ltsSZxAaUFaRWMu8vJfn4b0+qftN/xiHApbBhOd7IgGf
 ep+4FnDCXbOwOeGYJ0dEMiI65mXaINJTqNwoaBPBWSIb5EFTfFQ/z6e3YufK94ZeVMTPuEuJw4b
 W9ITURB3
X-Received: by 2002:a05:6402:2689:b0:698:3b7c:3b42 with SMTP id
 4fb4d7f45d1cf-698a2ce952amr148783a12.33.1782907212234; Wed, 01 Jul 2026
 05:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
 <20260628082810.175862-9-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260628082810.175862-9-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Jul 2026 13:00:00 +0100
X-Gm-Features: AVVi8Cd8_DjOvdzOSUZPXKCjOoMgxr7ezctwsJeQfOXjafAoItG-Cpq2KC6eP6s
Message-ID: <CAFLszTjRdODVL+r+Fwb1G0cupW7_jFK67gMN02XW5nGRO3YabA@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] efi_loader: move file-system helpers to
 efi_app_common
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 u-boot@lists.denx.de
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

On 2026-06-28T08:27:58, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> efi_loader: move file-system helpers to efi_app_common
>
> Move the shared file-system utilities to efi_app_common:
>
> * open_file_system() - open the simple file system protocol, first
>   trying the partition the image was loaded from, then the UEFI system
>   partition.
> * get_config_table()  - look up an EFI configuration table by GUID.
> * save_file()         - write a buffer to a named file, prompting for
>   confirmation if the file already exists.
>
> get_config_table() supersedes the private get_dtb() in dtbdump and
> get_dbg_info() in dbginfodump; both call-sites are updated to use it.
>
> dtbdump's do_save() and initrddump's do_save() are simplified to use
> the common save_file(), eliminating duplicate file-open/write/close
> sequences.
>
> smbiosdump's private get_config_table(), open_file_system() and
> save_file() are removed; the common versions take their place.
> [...]
>
> lib/efi_loader/dbginfodump.c    |  22 +------
>  lib/efi_loader/dtbdump.c        | 120 ++------------------------------------
>  lib/efi_loader/efi_app_common.c | 106 ++++++++++++++++++++++++++++++++++
>  lib/efi_loader/efi_app_common.h |  32 ++++++++++
>  lib/efi_loader/initrddump.c     |  69 ++--------------------
>  lib/efi_loader/smbiosdump.c     | 125 ----------------------------------------
>  6 files changed, 147 insertions(+), 327 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
