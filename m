Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5DFC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 11:16:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26DBA87973;
	Wed, 27 Dec 2023 12:16:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fdjMdnJi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A7078799E; Wed, 27 Dec 2023 12:16:56 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EC1F87837
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 12:16:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50e6ee8e911so3072808e87.1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 03:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703675813; x=1704280613; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HndPvENqKZY6JdwDtzTMGdoKJRkGmm6Eq7uXAVIldSk=;
 b=fdjMdnJiy9YsR2T365VaC/xTupugBlMtjis0gVvmD6Cb9EnckGYP46kVZnkiQvPViw
 kZFC+bW166FPXTVji7dh31Tdz2hjh0CJ9O04kNSDngcyasFkS3FnsyE7dPIK6nCdIkKw
 8q70XyrGUdnviDywmEmgYrjckCZCrRGHRZo1MhOLI2mBTfZ6RwBbS9u9SSNYGKNYQkzw
 i0b7w5TiQfFCjNuBK2BVEltL1Vwq1+Nq2/C1amhE85l7jwYrK3OUGUbwg97as/ObfNn3
 qwzEsVWw9s2LTeBv555NOmCyh8bUdK7Gx21oQ6KhtphtSW49b5r3+LyYhfuwex3Ev7h4
 aw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703675813; x=1704280613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HndPvENqKZY6JdwDtzTMGdoKJRkGmm6Eq7uXAVIldSk=;
 b=Bv4MqhZ4i190PzjfenuteHIEp7mILccxvp+4MeIz0qDVyD68NQrHilWMIMazWLBHnQ
 ksNIhVtf7KvJ8NRk1xUgT9eBqz/szIb+07cxLWRyhSY4HYum3yPYpggfX46mMZ3ZXjIA
 u10Fa+DUJIs6Ujee0T9uIq+bor2k+8coMFsa7DlIbh37sR3k4OYPyQgv84nVPHrboNbq
 DkgTpDqCAJAZ+TIg258Y9l6S4rBiqe0gzU9r8fgV5QgWKj0Jy975lNT7evKP2apcGmWy
 xqI3EVhPL8Nqu9Wa/IdtUuvHtmFfUw83Xus86emR92RRFlenWAeY2S/GHwrl8bPuPEHh
 hoXg==
X-Gm-Message-State: AOJu0YwifOW1uAulwNcyxGZoWH9Wn8cq01NE5hRpRWZUs6uHW/F8k8AT
 Hnx2npMoLvIlBiLyEjmljAGQUhOh5F4jE3hL0WMqSjVwUcYu3g==
X-Google-Smtp-Source: AGHT+IHGDE0ha+X8Ee1trxkJlW1q/rH7Gw7OvMrTqTRmx7/8SE3F2ugcJ6n/TQGnJkFK2O55GtgfNTqAJDS9Wn6GtYI=
X-Received: by 2002:a19:6549:0:b0:50e:2bf0:dd6a with SMTP id
 c9-20020a196549000000b0050e2bf0dd6amr2909896lfj.13.1703675813618; Wed, 27 Dec
 2023 03:16:53 -0800 (PST)
MIME-Version: 1.0
References: <20231227074025.2178825-1-sjg@chromium.org>
In-Reply-To: <20231227074025.2178825-1-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 13:16:17 +0200
Message-ID: <CAC_iWj+7WtSBezi7WPDbPvWh8gRuSDwd5U_nPMM-2iC18+DySQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] smbios: Deal with tables beyond 4GB
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Bin Meng <bmeng.cn@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Troy Kisky <troykiskyboundary@gmail.com>
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

Hi Simon,

Thanks this looks good

On Wed, 27 Dec 2023 at 09:40, Simon Glass <sjg@chromium.org> wrote:
>
> When the malloc() region extends beyond 4GB on ARM we may end up with
> an SMBIOS table in that region.
>
> Add support for writing an SMBIOS3 table, which supports a 64-bit
> address.
>
> Note that this problem does not happen on x86 since it requires the
> tables to be placed just below 1MB in memory, unless
> CONFIG_BLOBLIST_TABLES is enabled.
>
>
> Changes in v4:
> - Bring in this patch from Heinrich's series
> - Check the start of the table rather than the end
>
> Changes in v2:
> - Check the end of the table rather than the start.
> - Add a new patch to correct gd_smbios_start()
> - Add a note about why unmap_system() is called
>
> Heinrich Schuchardt (1):
>   smbios: SMBIOS 3.0 (64-bit) Entry Point structure
>
> Simon Glass (6):
>   smbios: Refactor 32-bit code into an else statement
>   smbios: Move the rest of the SMBIOS2 code
>   smbios: Use SMBIOS 3.0 to support an address above 4GB
>   smbios: Correct gd_smbios_start()
>   efi: Use the correct GUID for the SMBIOS table
>   smbios: Require the caller to align the SMBIOS table
>
>  include/asm-generic/global_data.h |  2 +-
>  include/efi_api.h                 |  4 ++
>  include/smbios.h                  | 37 ++++++++++++--
>  lib/efi_loader/efi_smbios.c       | 14 +++--
>  lib/smbios.c                      | 85 +++++++++++++++++++------------
>  5 files changed, 101 insertions(+), 41 deletions(-)
>
> --
> 2.34.1
>

For the series
Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
