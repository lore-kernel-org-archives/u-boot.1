Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0300C25B7E
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 15:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 261BB884DC;
	Tue, 28 May 2024 17:48:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RqtqClce";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 078138852C; Tue, 28 May 2024 17:48:38 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBA398842A
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 17:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f47784a2adso7376365ad.1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 08:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716911314; x=1717516114; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KorAmDmVaIf6RT4+Ypp8JHga9WPOQQcvZ7UkcDI0suk=;
 b=RqtqClce5F7rAbG0b3hDjbaOzufRK0j4oFwDmd5/kiF95gMxgiB85llFDO5SP++XWf
 bcGSv653FMk9Jgp8l9nH0BrwaoagdWZE29ZXOiQDPfttRwgoFcmTYHD548vgVemdOKqV
 FQxfv/mtFYC9Sfy3NoLQbjU7SXhvNOflSRMPp7oD7vfj3SgK1bfmtkKeLsTxqiBaQXM3
 Fd6sA8kFUmj0Ct7CW5u9bfcs/8kGoJKGunh8JMhOROV8qVtuGRQzsoIu4ezLS45xbzZA
 N+aydOo1zhwQaA1Uzjpv9kuzeZWHyPpWod4lS0KqSB6/bawPt+/IqrSGhqARftOKItUh
 bQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716911314; x=1717516114;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KorAmDmVaIf6RT4+Ypp8JHga9WPOQQcvZ7UkcDI0suk=;
 b=XzBFCXzd6e1t8H5okdBPNgVcK7BwW3sJKBCZPfr/AaCc04NXMIJwIqyDXnLNCV30Qr
 Zlj2MjHcR8/JKNIiJ3VevbEzJt1oTI+WIVjqSMAcpUJUPdnP6efqiW3W87yJeuBotVpM
 inK6fwMXV5fSQjtwzqKTpftEFn5uiZF+qZN5jRZ2HpQaYWZZeAvhNI0Q74WdEflHusm+
 2zH60z7/W7HVv1zhdb1V6u6mHXrXNvEsG1GTAOKNa0gNQqR08RzPFjIyZKk67U5E4h2B
 E0X2CNPnHE5npfdM20fOuUet9yYTmMu9HmFme5G+f/pyEEqFXR1B4Ova1bMsY/Ptucoj
 uRQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeXqXxEJLZL3qvaFGrqzzmqPj65xOvOYfYiTbYUETjqnEY561+DqWhm5qBQ/jkIOcFbceFIney+9io/lvGvRUXjabGvQ==
X-Gm-Message-State: AOJu0Yx8OImskst7wJQ4xa48N72rzq31bJeWetmK0M4pvY/B1FL8/3fp
 fvEPdFI2oXbbwdo8AtObK6CU0CcAlgJHbKoynHn9Nem5EooeqI9ZGkBscA204bW6sJVLFYuFhzM
 epAq30RHM4yTaxO9MHaTVlfBJYrmCmfndM0USzg==
X-Google-Smtp-Source: AGHT+IHzTXmYvczAxvoVrX2Z3dxOtfZPSJ0TNOcBz4DUnfMt2a47KNI9LKEtc+urJpsktfIKSQ7GU/Avsg3DgqetVkI=
X-Received: by 2002:a17:902:d2cc:b0:1f4:9ce1:6e76 with SMTP id
 d9443c01a7336-1f49ce17509mr67492305ad.65.1716911314252; Tue, 28 May 2024
 08:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
 <20240528144252.179247-7-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240528144252.179247-7-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 May 2024 18:47:58 +0300
Message-ID: <CAC_iWj+fS=kqs47YD0d8HR8=vKcPodcQKhGU2=VAdV8xh=BhsQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] efi_loader: return binary from efi_dp_from_lo()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

On Tue, 28 May 2024 at 17:43, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> For finding distro supplied device-trees we need to know from which device
> we are booting. This can be identified via the device-path of the binary.
>
> Up to now efi_dp_from_lo() only could return the initrd or fdt device-path.
> Allow returning the binary device-path, too.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         no change
> ---
>  lib/efi_loader/efi_device_path.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> index c8c8d54f733..52e3313c23a 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -1133,17 +1133,18 @@ ssize_t efi_dp_check_length(const struct efi_device_path *dp,
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

thanks for catching the typo as well

>   * Caller must free the returned value.
>   */
>  struct
> @@ -1154,6 +1155,9 @@ efi_device_path *efi_dp_from_lo(struct efi_load_option *lo,
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
