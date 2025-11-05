Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C54CCFA0D
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 11:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB5B883A83;
	Wed,  5 Nov 2025 12:08:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZxkZUFGr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95B8983A79; Wed,  5 Nov 2025 12:08:55 +0100 (CET)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86F4983A5A
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 12:08:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-63fc72db706so2098507d50.2
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 03:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762340932; x=1762945732; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K4TvP3Gow6KRMe1PKmyE4mGkikucOuJj8Ji1fJKEu7A=;
 b=ZxkZUFGr4xHX/ishiJO7RLHJnl4JgPhNrBeOY7Ogkwdxb13hLRCF45h1Ogax/edSEr
 1GLDDC0obfZRRP6XZm3WIwM+ErrCYtWjnV/u/lyqys6TqVaMyPIMFMQThlwbgE/ixUeC
 oql2HYiG1GlIr2A4DohuiI11MKO2/6JQWvbxFun7o/Te4fKy9B6ugNymYT6K274CGYBg
 +07/Lkvwl4xr+NaqAQB+5VALUVFCTze4FT/SAhuGnp3jhqY1A9tLr8odpXksy+ignRZR
 dppEEGDRyEqCR+iyb9ZHuCuaetWx/q+8c1m5eh6f2ZVWXBz6jxZY4G3pr24yT++7hQHm
 8Q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762340932; x=1762945732;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K4TvP3Gow6KRMe1PKmyE4mGkikucOuJj8Ji1fJKEu7A=;
 b=pnzQpwhF8aZ9Q6+anFdpDLmkHPrvBgJG1+8+2zCc/tKHwSMIobHBYkvujmqvXVVT/l
 zdPRE5QkjA4LcjyyHaSce+p+NrxO+njT0e9FZs5AAWN6qMl0a7tpkwW1nZgV7pvy+g0R
 m6yds9cnYybZuuD0Liabo9dvtUCGULhYRA2vVhxNbbkdpVAgETPwKtqOxdQGQxsFIBBp
 0Vi+tRl7EebZBiQE20ByY5YPyFreilyGAOqSFMM+KtAgprbHVjiAlOICCrp5mxn6Yr9U
 epciM1V8rMpkZZtl5IJbxARY5irB2j2dYiAKhOnCTR3P0qm2gyqkMdHpB4onx+dVFyVP
 YQQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP4omo9aGKJH77oD8/cd8rB0F5pumImgKoCR/eRoUl5woeK0WHE8nrkvubSAzFtcFbcjP9CQA=@lists.denx.de
X-Gm-Message-State: AOJu0YwcwxSnYc2/5gbrSP9GwbDz36yZiH+cuj4rcFf7qafato/ZMaG+
 ZZBcsv7eHHqx794l11d1xGVe6EREW84x6tcSzoBaYzWwl7/lhykXUfa3/rA/OA1/rHtZK54aAj+
 uarI4R+GsN1Y0ZlEJXVTdaN+KLqmTx0U=
X-Gm-Gg: ASbGnctgXYpanFMzLYYWThYALzXXBep3mQtm4+z6NWmGWdNtEQY6K33jUfNW994LaZY
 a//DQjqAmyMer7/4+yiIMgpmjZx6FPBYpeflhi/J+YkqEuel0mNN+6K/SVRkIID6UgawxtC/4x6
 3k7R1QBzuU9chBN/l8RNDnOIzD2Y/gsHulfNpd1zEJN7OvdXMdqqT+EPYBiwyKynWH9UAxmfn9/
 Vw9YPqeLxM1teMBD2OeFxEmN+hoHCy7C9C3uzYjO2Mq9SbEOm45lzCe2V/LHf4=
X-Google-Smtp-Source: AGHT+IE8/JSpF/Qr/N4vQKbQc4AEnD7i6pBMkH1mT+FVDgMFa8enwjKPra8fsteyVtadZbwVwt7vNQaN2gWS/odiFqc=
X-Received: by 2002:a05:690e:2457:b0:63f:c615:ca89 with SMTP id
 956f58d0204a3-63fd3588b30mr1856852d50.55.1762340932272; Wed, 05 Nov 2025
 03:08:52 -0800 (PST)
MIME-Version: 1.0
References: <20251104232209.75544-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251104232209.75544-1-heinrich.schuchardt@canonical.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 5 Nov 2025 19:08:40 +0800
X-Gm-Features: AWmQ_bnBp2sBy23dEks39Qv0947V0zH14O_zw5tcEyX-L6ovl9HqUaaZKTopUX0
Message-ID: <CAEUhbmUPjAJHSd14VPZsTh9SkH_KigyDaCTT=ezNxXnwTu_h0Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_driver: don't leak name in
 efi_bl_create_block_device()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Nov 5, 2025 at 7:22=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> In case of an error always free variable name.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_driver/efi_block_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_driver/efi_block_device.c b/lib/efi_driver/efi_block=
_device.c
> index c389b1920a8..7ce6a45a5f3 100644
> --- a/lib/efi_driver/efi_block_device.c
> +++ b/lib/efi_driver/efi_block_device.c
> @@ -146,7 +146,6 @@ efi_bl_create_block_device(efi_handle_t handle, void =
*interface)
>                                devnum, io->media->block_size,
>                                (lbaint_t)io->media->last_block, &bdev)) {
>                 ret =3D EFI_OUT_OF_RESOURCES;
> -               free(name);
>                 goto err;
>         }
>
> @@ -171,6 +170,7 @@ err:
>         efi_unlink_dev(handle);
>         if (bdev)
>                 device_unbind(bdev);
> +       free(name);
>
>         return ret;
>  }

free() should be inserted right after the blk_create_devicef() call as
the success path also leaks the 'name'.

Regards,
Bin
