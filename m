Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECCAC27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 14:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BF5F8856B;
	Mon, 10 Jun 2024 16:27:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YHdDZJoW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D9CB88572; Mon, 10 Jun 2024 16:27:26 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CA5088546
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 16:27:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-35f04794973so336894f8f.2
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 07:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718029643; x=1718634443; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRrp7d4UueqbMCk+jYaTmIlu0aCGSOWPCnAkrUUmQXU=;
 b=YHdDZJoWsKRjUscq77U0Qyyz4aRJx8B0veAk9AOVmM5C40Y1dIBYlGRNq7vajfBMav
 iMqpTw8VJMFj9B+M+TdJXBc51IIcesB0TYFQeF0ruSv+cuOWX2Kx19nVs5q5zs9OPxW4
 SmewL1GH42tIP4nxdeB31DfKhgudhVE/VNctUMMkr1XgBJNLgR2q+Pz1EXKRcqyyIHf/
 Z+Byzsk+NzTolTCRJROENXbuKclq6vD/PFH3No1cru6NZkmFS+L7RP6KHCDsBcRZAif4
 4CFBiKZwF0sBFceX5MGGc/ulo0DRTZupgSIAWkaRsHIhAQWumPxBDJTdYTFc8qRiH7d8
 OeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718029643; x=1718634443;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRrp7d4UueqbMCk+jYaTmIlu0aCGSOWPCnAkrUUmQXU=;
 b=reGVB54cARCO4CDCYoYqBSw5Gxx0CGcytlglwWD8zBbtupr/hpdJpPVhUuD6bxo74j
 M38emUhIr181C/AMcyMz6AzvrBXArcGneSWZQbmqQSx8/MFqOmwlBXm4lWmH4H+ln8Dq
 1GkNwlnH8h8N9WFAHt+rYAjAHf1ocr/B3ZVroqzScieFtS7Wp1BCe1+C+f1RGYkbR9bD
 8dmQ4OP+HTnBjXuORfuDIxTQtMnI4jhVomLp5gqo9haWHe2oO9upaehdOX3r8hfIy5Ik
 6YqXeF/4yTPCoqb8pj/aEhPEtN7JCd/PtOt1dhTdShULZ4KdNt9GY0/u8ZGyFDRBvk2S
 a19g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX0lkNKQgNsbFs/5oKVewf8FMDOF9O7O8XBUWjZQsVF9qj5JR9PnRZQf5QyCCA2r99zQT9OKKHRIjzeoadiqAbHAgLqg==
X-Gm-Message-State: AOJu0YwTxy4O6MSR5yLigWoi7Zaa106mQGDc+g+MpvtiKL7G5xGOluzy
 Kh/Ytbbl7cSRtbHYb/mC9oC/4v22d5Zwt+OjEmnUpUAzw2Uf8Q/tSnr9wuj7rPnHF75Y8X2IFdT
 eKCRFnH3K/Uob6hC7YCqlvd9krW0=
X-Google-Smtp-Source: AGHT+IFz+i80BS+gMzan50QnLZS35UyozWqKY6IC1JDmSpSzJDAn+5v2NnqGj/PvdrDqMuGm4f2D+X2NEAyO2iAI2b4=
X-Received: by 2002:a5d:6c65:0:b0:354:cbc3:bd9d with SMTP id
 ffacd0b85a97d-35efea78043mr7155601f8f.0.1718029643340; Mon, 10 Jun 2024
 07:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240606-bootmeth-android-v1-0-0c69d4457cc5@baylibre.com>
 <20240606-bootmeth-android-v1-4-0c69d4457cc5@baylibre.com>
In-Reply-To: <20240606-bootmeth-android-v1-4-0c69d4457cc5@baylibre.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Mon, 10 Jun 2024 16:27:12 +0200
Message-ID: <CAByghJaYD75gbn8fTj53bK7Uf6A3b85T=_X8YVr_cWQ3O41aeg@mail.gmail.com>
Subject: Re: [PATCH 4/6] android: boot: Add set_abootimg_addr() and
 set_avendor_bootimg_addr()
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>, Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Dmitrii Merkurev <dimorinny@google.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, u-boot@lists.denx.de
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

On Thu, Jun 6, 2024 at 2:24=E2=80=AFPM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> The only way to configure the load addresses for both bootimg and
> vendor_bootimg is by using the "abootimg" command.
> If we want to use the C API, there is no equivalent.
>
> Add set_abootimg_addr() and set_avendor_bootimg_addr() so that we can
> specify the load address from C.
>
> This can be useful for implementing an Android bootmethod.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  cmd/abootimg.c  | 10 ++++++++++
>  include/image.h | 14 ++++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/cmd/abootimg.c b/cmd/abootimg.c
> index 88c77d999290..33381e22dec2 100644
> --- a/cmd/abootimg.c
> +++ b/cmd/abootimg.c
> @@ -21,11 +21,21 @@ ulong get_abootimg_addr(void)
>         return (_abootimg_addr =3D=3D -1 ? image_load_addr : _abootimg_ad=
dr);
>  }
>
> +void set_abootimg_addr(ulong addr)
> +{
> +       _abootimg_addr =3D addr;
> +}
> +
>  ulong get_avendor_bootimg_addr(void)
>  {
>         return _avendor_bootimg_addr;
>  }
>
> +void set_avendor_bootimg_addr(ulong addr)
> +{
> +       _avendor_bootimg_addr =3D addr;
> +}
> +
>  static int abootimg_get_ver(int argc, char *const argv[])
>  {
>         const struct andr_boot_img_hdr_v0 *hdr;
> diff --git a/include/image.h b/include/image.h
> index 18e5ced5ab42..6deaf406605e 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -1977,6 +1977,13 @@ u32 android_image_get_version(const void *hdr);
>   */
>  ulong get_abootimg_addr(void);
>
> +/**
> + * set_abootimg_addr() - Set Android boot image address
> + *
> + * Return: no returned results
> + */
> +void set_abootimg_addr(ulong addr);
> +
>  /**
>   * get_avendor_bootimg_addr() - Get Android vendor boot image address
>   *
> @@ -1984,6 +1991,13 @@ ulong get_abootimg_addr(void);
>   */
>  ulong get_avendor_bootimg_addr(void);
>
> +/**
> + * set_abootimg_addr() - Set Android vendor boot image address
> + *
> + * Return: no returned results
> + */
> +void set_avendor_bootimg_addr(ulong addr);
> +
>  /**
>   * board_fit_config_name_match() - Check for a matching board name
>   *
>
> --
> 2.45.0
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>
--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk
