Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45083C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 08:48:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C976A8129F;
	Wed, 19 Mar 2025 09:48:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R2rq+joq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7667981101; Wed, 19 Mar 2025 09:48:47 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 362418141E
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 09:48:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e64405b3b9aso1752947276.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 01:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742374124; x=1742978924; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KJpNcPJgPlPjB0B8OEP1C510gR1prZ6RrJGYA3Pmi6Q=;
 b=R2rq+joq126syfjy6sEZrqlRYC6fiNAWgCYwiHEbS3zHbX54e+QwoLNYVWmn9eyl9z
 OLPRY6TKE3oh0y337D8LH2Dstms1wSSX5fifY2NVm4LnXIR+AD4Y5hWGAlxFveB2gFi8
 aHenxToA/b7WwQc+Hnb+0MZ4tUAto0mOlfJAVKd+tJV8xyewTmSivoIxfAJWoAY5jQ3i
 7EkJ+s4FCjgwiahz4GUwNVHMFGPTp7fk8yJQaMfqpqTd6JHHWCGeHC3/yNk8Nxqmq4GC
 wfzdVUU6DcY8ydVClJ2JeOmb+inXCv9tHp4Ffk8AYDAmrATxwVbDPPz4r5gJLpO8+gAs
 1Y4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742374124; x=1742978924;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KJpNcPJgPlPjB0B8OEP1C510gR1prZ6RrJGYA3Pmi6Q=;
 b=pfqsRiRVDM5YhDbd8CJcOWfzmnCkJygAlJg0xLcPGpVxhkLh/0aoK3+NWmt8Vjs1ga
 WxpH9kgviTEfQ3ey9szA2f9O7Rjd3RqGI1CWUSqQ6lwoTSIUxVgCBEi4wLzbROjQWU58
 qUGC2m+nRa6V91goy5hJQ0kkSbuWyvR1By+N5HRSHQEo28ibr/sU/IhCMqUVmkoaEhDr
 TYK43iOy9yuu9/ZdhKvEoMYufHEvijB4zUueiYTwjlXBTtb0saMehAkP11t/hCD6mlNT
 e2ibwze/T1Urq3tEzaRhClgw3giEqGmxKmlXb6fbTr5nTKj3D2fkxaovM3PcojncOV+x
 qO/w==
X-Gm-Message-State: AOJu0YyLc4t+njfFHK/5Th2ltYpJOym5TTSCPHXgnB7zmJI9ihSw3a27
 UTYuD+3aWgv7XNvAa/KZgoqcyfGr3nX49TsxNbuIhuwfRONQa/Acry3qLwFkxd+riHF+Zv8hcaa
 Ki2xhXf0LUtZeCNV8TbO4NOeYFqsBQo2c5JWhbw==
X-Gm-Gg: ASbGncsWoXDwQ1ODN64dTy27O0OwOqkjtC1baEtMLNB/qkygjzrsAB6Cbhv+XvM/qc8
 6wOKLxKW8PbqsxQU4hRxbMxTQwL3Y0hDHEZji6bqn4D/vgtYfKVtF0kPPfcflffO7IXHOppnuZG
 FObZTtTn3cyxAtmoDk7aiHFuWrI74=
X-Google-Smtp-Source: AGHT+IEgbGp7xliI2hSQzPBPOrDZarIT263ihx4nXXrOB3boMSWcvFdooxQuJQwN58Tt1+vjv74apH/fkAKETVPGfLU=
X-Received: by 2002:a05:6902:4810:b0:e60:78b9:1502 with SMTP id
 3f1490d57ef6-e667b3bf7f8mr2392511276.16.1742374121277; Wed, 19 Mar 2025
 01:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250318132347.646703-1-adriano.cordova@canonical.com>
In-Reply-To: <20250318132347.646703-1-adriano.cordova@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 19 Mar 2025 10:48:05 +0200
X-Gm-Features: AQ5f1JroRxTlRfO1-qAF2kHgBFGg2NmY-ogdlAjXAexsB248fkWHpksbN9OUvLU
Message-ID: <CAC_iWjJgS2oudWw7DTDW4uPtaGvw8MSdzo1VyswX8CLYD9dL0g@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add initrd support to bootm EFI payloads
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, sjg@chromium.org, 
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>
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

Hi Adriano,

On Tue, 18 Mar 2025 at 15:23, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Next boot stages can acces an initrd via a handle with a specific device
> path and an EFI_LOAD_FILE2_PROTOCOL installed on it. In U-Boot, this functionality
> is currently only implemented when booting with the EFI boot manager. This series
> implements this functionality also for the bootm command when the os is of EFI type,
> e.g. when booting FIT images with an EFI kernel.

I'll have a look at the patches shortly. I have a question about the
entire series though.

The initrd was plugged into the efi boot manager because it's easy to
configure entries of
kernel-initrd-dtb. The initrd can also be loaded by passing a kernel
command line parameter.

That parameter can either be initrd=<file> with the limitation that
the initrd needs to be on the same filesystem as the kernel image.
On newer kernels you can also pass initrd=<device path>. I am not sure
what's the best option when loading the initrd for a FIT image.

Thanks
/Ilias



>
> Adriano Cordova (3):
>   efi_loader: efi_load_initrd: provide a memory mapped initrd
>   efi_loader: binary_run: register an initrd
>   bootm: add support for initrd in do_bootm_efi
>
>  boot/bootm_os.c                  |  4 +-
>  cmd/bootefi.c                    |  2 +-
>  include/efi_loader.h             |  4 +-
>  lib/efi_loader/efi_bootbin.c     | 20 +++++++--
>  lib/efi_loader/efi_bootmgr.c     |  2 +-
>  lib/efi_loader/efi_load_initrd.c | 71 +++++++++++++++++++++++++++-----
>  6 files changed, 84 insertions(+), 19 deletions(-)
>
> --
> 2.48.1
>
