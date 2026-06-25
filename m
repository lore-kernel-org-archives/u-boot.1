Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6BACDB466
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 08:54:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 043888495E;
	Thu, 25 Jun 2026 10:54:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jQmJhBBE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06A968496E; Thu, 25 Jun 2026 10:54:33 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE929846F4
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:54:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c0be5e548a4so350932166b.3
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 01:54:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782377670; cv=none;
 d=google.com; s=arc-20260327;
 b=H3gx2g92YgKb6yoUQTZNya3HxIVgnZLn7O31KkECXlJHdMwGMwjRPUaThJFQq+2U/Z
 bS6VMzshRyHWZTzHU4ZPYf6kqdOHOjmmNdrxrBHYAfNOwMEWG+ZKd6mjpAz7GLPWQi6V
 +IdDQKTE0WpKN/bPKXpYFUGFPYmqPGvjBhocmChSs74UOSu3iv5PLr7+ViGbid4P05j9
 LYnC7mKdXdP3GBKil1XM0q6NVzYSZEUyNjaMI+R2UlxS0qeKMDqUFzNqgcv7NfNFaQnY
 o0pj6MwYYzqqISQ7PcqYuDnKBWkqlk0p2dXrBykJGHvYC0nczBhEYqE1qn08v9D/9K0f
 hQDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zendW4OMcidXO0gsvMYhIfLCFtNzvmmqYg5Rurh/RKM=;
 fh=fLRK62brYTZwycgRvG3dQoEukv9OpP8T/wrXFkLlCIY=;
 b=mR7SCFZuy3xvjOjgmdC4iLdO7XoUtgdFTRKFR2jgCNUSI5eVll8Xt9RAaRTuTL+lni
 1Ul+r/zfntTj83aw0ETEiH2d/XHPNhUFSGMpmXKoTsqaW9ZPCjt80A+9HJ0WRRk3UuP7
 T2x8CEPxrF0YWwatUpJ/6f+7WsA0zAwLk+3vDLAp5Y0dWf9/DG0a7QkzLG4NJ8S413yw
 gTge9ZKeTgBOWbQAo/4BCt53/ZGJOFlIn8J6rfJVHIbjh8jgtN+B1d7eVZKYNoRWXDYw
 17nfa37mattfBTqHrUq3SOOa/xIWdwVGoDQRb8xKwtuV7sxLjPsaHgfknE9Iyn01jXNr
 j+Pg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782377670; x=1782982470; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zendW4OMcidXO0gsvMYhIfLCFtNzvmmqYg5Rurh/RKM=;
 b=jQmJhBBEDMxs7wpe0EAPxHr5WYUreVIMwSHtjIu/KUSEW8S+JjC44sIqyntErKLUef
 pMX5vju8VeeWVroZeXfQx9WZLs4UFVEyHG8o+vPPqYAHI9gTT3A0gCSw065AiNOTL3Ub
 X3NJ52BZ5zI/9bqYhjyFSdszoYJe1HdlfDRRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782377670; x=1782982470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zendW4OMcidXO0gsvMYhIfLCFtNzvmmqYg5Rurh/RKM=;
 b=aT4IbvTgNzHelTTBScfkCfeHVcxqPGmacPGn5aAZZFOqwdplimigSecbjLz+y7Qbqc
 qMlCnan8Vd9jYWkAFJ3RTVM1W+MexeH2nxBjpBFtACegO9WU4/8d+Zlb4kPGN+hPsMgV
 2EFJXpEyZTy33Zv/Eu2Wl01peiaF5cNjYQLx6Sgxx1Tt9KF+Oa4kJsOSvsij/uoNRnAk
 NnPSoTNvKukzVcQ/TZWnVAQr+zOuw6iF9Lm1XlMQGEvFmWh6xBLnOmRsU9Yudr+v+fAT
 xEf9xmd+uTC1WQ1VCkeLG68T0L3qrx/s429ivyPnSVwgp6zITYdFclCJ6yzNZ1G+c9EO
 dKXA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+JlMO8vTNyOA2gBSpaoxJFpttTaEv2NRcCuKvYLspksd7+TaEVDuYKJ89y2d0FMkQ4o2eKys=@lists.denx.de
X-Gm-Message-State: AOJu0YzDXgVk7nsHgn9aBy8LrX+jTRLwfJE1Y0RHhH1fJcyf3jM+0DRM
 9U1/268fFs8B9ywzwlHb5LD7Z1ZPsFsl7O1eZo/BHCZQHFGkdmfcEligVBMgoDQsbjWv80Etg6p
 hXkEgsBoMXwOgIzVBg7aws6MketUDB4/GcZ6xqVmL
X-Gm-Gg: AfdE7clepjdibjVi+amL9cZLiflkmDv7xumkDNn1ypIADr71udYCsEqhhUzr+T4xwZM
 BogCTOvZOUEcc61hbmHjI2UF2ZoZXhJekN3oE7L58qTnczwhaBuYRVBaiGdo9i7Op0F7QbY5HMV
 8QBWrRlpJJrq8jmPBjQUMbkM9nVm8pd7gjCwCsQVl1kG06SMQABr2DVgRlP3V0a48W37eqzRk7U
 bl8KxcklDxaRtUf9fX+XKRVbfFLN8/Q+lVDClF1/PHvGw8oRCKD8Sq8+4vtlJb5Qleay2NHNg==
X-Received: by 2002:a17:906:6206:b0:bed:87c:b24e with SMTP id
 a640c23a62f3a-c1205eef62emr96318066b.29.1782377670272; Thu, 25 Jun 2026
 01:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
 <20260621081915.19154-9-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260621081915.19154-9-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 09:53:57 +0100
X-Gm-Features: AVVi8Cd77VfZusI1vwBhYrFKIh1pcIXQr8MLA6vMvzS6e4izlnMvHJbrlli0zCQ
Message-ID: <CAFLszTjPS_asG8bHvwzJcfVeGhv9x5O1S_KCJ_qAqJ14o-A8tA@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] efi_loader: move file-system helpers to
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

Hi Heinrich,

On 2026-06-21T08:19:04, Heinrich Schuchardt
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
>  lib/efi_loader/efi_app_common.c | 105 +++++++++++++++++++++++++++++++++
>  lib/efi_loader/efi_app_common.h |  27 +++++++++
>  lib/efi_loader/initrddump.c     |  69 ++--------------------
>  lib/efi_loader/smbiosdump.c     | 125 ----------------------------------------
>  6 files changed, 141 insertions(+), 327 deletions(-)

> diff --git a/lib/efi_loader/efi_app_common.c b/lib/efi_loader/efi_app_common.c
> @@ -199,3 +203,104 @@ efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size)
> +void *get_config_table(const efi_guid_t *guid)
> +{
> +     size_t i;
> +
> +     for (i = 0; i < systable->nr_tables; ++i) {
> +             if (!memcmp(guid, &systable->tables[i].guid, 16))
> +                     return systable->tables[i].table;
> +     }

Please use sizeof(efi_guid_t) rather than the literal 16 - that is
what get_dtb() and get_dbg_info() did before the move. The 16 was
inherited from the smbiosdump copy.

> diff --git a/lib/efi_loader/efi_app_common.c b/lib/efi_loader/efi_app_common.c
> @@ -199,3 +203,104 @@ efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size)
> +efi_status_t save_file(u16 *filename, void *buf, efi_uintn_t size)
> +{
> +     efi_uintn_t ret;

ret should be efi_status_t to match the return type.

> diff --git a/lib/efi_loader/efi_app_common.c b/lib/efi_loader/efi_app_common.c
> @@ -199,3 +203,104 @@ efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size)
> +             if (ret != EFI_SUCCESS) {
> +                     root->close(root);
> +                     error(u"Aborted by user\r\n");
> +                     return ret;
> +             }

The old smbiosdump save_file() did bs->free_pool(buf) on this abort
path while the caller also freed buf unconditionally - a double-free.
Dropping the inner free here quietly fixes that. Worth a sentence in
the commit message so the change in ownership (caller now always owns
buf) is explicit.

> diff --git a/lib/efi_loader/efi_app_common.h b/lib/efi_loader/efi_app_common.h
> @@ -101,4 +101,31 @@ efi_status_t efi_input_yn(void);
> +/**
> + * save_file() - save buffer to a file on the EFI system partition
> + *
> + * @filename:   file name
> + * @buf:        buffer to write
> + * @size:       size of the buffer
> + * Return:      status code
> + */
> +efi_status_t save_file(u16 *filename, void *buf, efi_uintn_t size);

The description is misleading - open_file_system() tries the loaded
image's own partition first and only falls back to the ESP. Please
reword along the lines of 'save buffer to a file on the loaded image's
partition, falling back to the EFI system partition'.

Regards,
Simon
