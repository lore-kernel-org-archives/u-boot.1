Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D936C4345F
	for <u-boot@archiver.kernel.org>; Sun, 28 Apr 2024 13:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAE2588294;
	Sun, 28 Apr 2024 15:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XRD1TuF4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9730388299; Sun, 28 Apr 2024 15:29:37 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 826858828B
 for <u-boot@lists.denx.de>; Sun, 28 Apr 2024 15:29:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2def8e58471so53319821fa.0
 for <u-boot@lists.denx.de>; Sun, 28 Apr 2024 06:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714310975; x=1714915775; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=peh5lb/46mTB1rlm8DUp7MaZQRd5dLPYMcutebI6Pgw=;
 b=XRD1TuF46HDXuE40Im70KEk60Q9RpEgvwA03btqy3ox6GTh0ensQ0NqNOAViZL5/4X
 rD0AuoYO6rY30aEma+2OBu3rjovMBtj0t/wBz2In7XLhBJwDEBRL1zlYRAVy1efEeUu1
 xDkKaLA17AFlXKn2kWEBrSEG4+Fzz8Udaa2+9fvCXe1AByJzXLE95kCLUX/IjxRloRnH
 z3ztV/Sfz9BH0mBsAurJYdducjV7T9OywjCRMKHheTSX6NmXrTPtFHfm2aevllBEjtiw
 aMTJf0fJGPXFRbwXytNgh5BV/yMPvtzLrHXz0LDKzvTyE1BqJENOQNYG1dtQYQlrejuY
 +KGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714310975; x=1714915775;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=peh5lb/46mTB1rlm8DUp7MaZQRd5dLPYMcutebI6Pgw=;
 b=kLITrqVM1RkFqThwkdKPkfDfRHzimMT6bASpSqA2pocwjmUDVoZjoecTvysvZwmP5r
 a2b+jaur4W+UJWQMuzZrMHRyP9duiKmi0tiy9IpHQxwaKGGIRLwlxEmJW+0HDcgxPsGm
 iVFyrd2BkR2JGlKXyB63ctCbT28N2Oj3le5Ict6fDYG7g/vLcnSa+CnofHuMn0aNH/YV
 g1VPfOhmbkiVBOcWRqkrRv2MKXqy8huiABM2rPZLkBH9ftYh2FMnDfeWQ8aNYE3tqxfM
 6EF26kXJAAQPSBjSMhgiijXKs/LlBYzr58z6KK2lwvuyW019z3RYRM1WGos0NFbsZ61i
 TleQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3Mm6UeBdiCQmRYdJ22clsiZK3AOyn87Y2Nh/4EFzOZXETdE5U8Rt4BXGc1zEKWkFLwq5PcIvsLvuCOce5Awx0V2BilA==
X-Gm-Message-State: AOJu0Ywt30j3klhuV5qPdR+9TsZrLncS35COZsW+laP7LMDVwr4lrM3C
 Sn5eMyMkP+fRwND9V6EJHgE64xAhDuMxstntAz0mcHe0AQjHC7rS3HR2RhM+sXrOTvwiaM08ILa
 iVJ6vnLGozJyL/Mq0/4cir0GkS9FYcUl3NmtzMw==
X-Google-Smtp-Source: AGHT+IF861ufI+XfkHxSGy/IImFG4TgVhMfAGbk14n6CBixgGYnqWdC1yqaxSputXeLEAAc2AmRZ9Jj1IryRVNSuHA8=
X-Received: by 2002:a2e:be2b:0:b0:2de:8697:e08b with SMTP id
 z43-20020a2ebe2b000000b002de8697e08bmr6422711ljq.26.1714310974620; Sun, 28
 Apr 2024 06:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
 <20240426141321.232236-13-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240426141321.232236-13-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 28 Apr 2024 16:28:58 +0300
Message-ID: <CAC_iWjJrD3BODipSJ=t9_qpAXzefjzRPw_4r2fQAsOqyq8mkYg@mail.gmail.com>
Subject: Re: [RFC 12/14] efi_loader: return binary from efi_dp_from_lo()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de
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

Hi Heinrich

On Fri, 26 Apr 2024 at 17:14, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Up to now efi_dp_from_lo() only could return the initrd or fdt device-path.
> Allow returning the binary device-path to.

Why do we need this?

Thanks
/Ilias
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_device_path.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> index 75fe95c9c1e..c8893f5626b 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -1140,17 +1140,18 @@ ssize_t efi_dp_check_length(const struct efi_device_path *dp,
>  }
>
>  /**
> - * efi_dp_from_lo() - Get the instance of a VenMedia node in a
> - *                    multi-instance device path that matches
> - *                    a specific GUID. This kind of device paths
> - *                    is found in Boot#### options describing an
> - *                    initrd location
> + * efi_dp_from_lo() - get device-path from load option
>   *
> - * @lo:                EFI_LOAD_OPTION containing a valid device path
> - * @guid:      guid to search for
> + * The load options in U-Boot may contain multiple concatenated device-paths.
> + * The first device-path indicates the EFI binary to execute. Subsequent
> + * device-paths start with a VenMedia node where the GUID identifies the
> + * function (initrd or fdt).
> + *
> + * @lo:                EFI load option containing a valid device path
> + * @guid:      GUID identifying device-path or NULL for the EFI binary
>   *
>   * Return:
> - * device path including the VenMedia node or NULL.
> + * device path excluding the matched VenMedia node or NULL.
>   * Caller must free the returned value.
>   */
>  struct
> @@ -1161,6 +1162,9 @@ efi_device_path *efi_dp_from_lo(struct efi_load_option *lo,
>         struct efi_device_path_vendor *vendor;
>         int lo_len = lo->file_path_length;
>
> +       if (!guid)
> +               return efi_dp_dup(fp);
> +
>         for (; lo_len >=  sizeof(struct efi_device_path);
>              lo_len -= fp->length, fp = (void *)fp + fp->length) {
>                 if (lo_len < 0 || efi_dp_check_length(fp, lo_len) < 0)
> --
> 2.43.0
>
