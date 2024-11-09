Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64244D5E37A
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 17:34:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF6B2890AD;
	Sat,  9 Nov 2024 18:34:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l7qaaR1U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5B2B88D3C; Sat,  9 Nov 2024 18:34:08 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63EA5890AD
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 18:34:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9a6b4ca29bso450562766b.3
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 09:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731173645; x=1731778445; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=llZSIm9RTwi+d2GMRKcndXolcRLn0SPxRWEjtUkc5bk=;
 b=l7qaaR1UlZ4eYHJrEo2hzs71ODuJeoS4q8M1125XIUAouO80CNOhstA/HqwiIHPiD2
 P9zCC3gK2w8JJxOMlnkPr524+ncLg4v28f3PbgymAZWWRsfpKD1Lxr1UdpeKGl9cW/DN
 QP+qkNBVuPZ+wvictwfU6R3PnUnNT6AsqUxnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731173645; x=1731778445;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=llZSIm9RTwi+d2GMRKcndXolcRLn0SPxRWEjtUkc5bk=;
 b=kxWSc3TgBTPrqJ68PxtMaMxVt6Z08X3ruEviU9YSNIE8Tr0ItOV70l40Amv3H4WxOn
 oeCX/ihw+6RM5CQ45zr+jv2GuaJWmYbinD7mRgcb7uCjBZEr8T7sdcJT0koGu7evu6dn
 4YxVuRNdAf1TKKotpZTwJQTKtDwNQT85EI9GZQLpfTyLmRnlb2dFAW8Iz3NLtDRh0FZm
 QDZbmpi50ZNUMf5ag+NhbxZaWU7zGQloceRYcp2zuKU5OhuNtnyXHHVHTK4QSJigA6aj
 QtFS70EzEqAg1bzujhOSBrznqwPhEdPopBOqZE9Ubc6lnGmxBjQfyjewI7u8DD20NV1m
 eneg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6M3TlL/CW3CFQOh08ivOwYha+FJmSiCbJR9oM6wtMRUex+CnpSw4NmIzgxw+WzF5np18lEBM=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7U8022GvJYum/X/nW95CeBMYNG6ecAfPQegxlWHsmxiAOmca9
 /Tsg+DyJWLWahnHwKgTWHopWJ6cl6et07FTxe+80A2TDQ0F+AwJ/ObwOo/GTiV1nZ5h4gHAny99
 IgKav3NNMP57ruuwQXKOhixEHFdE69hvypmfr
X-Google-Smtp-Source: AGHT+IH7I7p5UtoGzZqOyUKX+HJEX/5zZPWzQnP+DZdCbWexV1MMqOLc/F8WgXRr6+eD9sHjqkrEcD6g0q5CYHQtzPk=
X-Received: by 2002:a17:907:d2a:b0:a9a:684e:9a64 with SMTP id
 a640c23a62f3a-a9ef005043amr628191466b.61.1731173644329; Sat, 09 Nov 2024
 09:34:04 -0800 (PST)
MIME-Version: 1.0
References: <20241109103141.33983-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241109103141.33983-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 9 Nov 2024 10:33:51 -0700
Message-ID: <CAFLszTiKGRg=1PDP39zJ1XthsmE4GL38xL8uxua_dO+DwhqOxA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: provide valid PXE architecture on sandbox
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
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

On Sat, 9 Nov 2024 at 03:31, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Before this patch the sandbox uses 0xffffffea as PXE architecture.
>
>     => efidebug defaults
>     Default boot path: EFI\BOOT\BOOTSBOX.EFI
>     PXE arch: 0xffffffea
>
> With this patch it uses the PXE architecture that matches the host.
> This allows us to use bootmeth EFI on the sandbox to load an EFI binary.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The way things are, this isn't a valid thing to do. It is returning an
error to indicate that. The error should be checked. If you use -N
then it will do what you want, though.

But what architectures does this work for, with your setup? I haven't
been able to get x86_64 to work. I could perhaps try arm64?

Should we document this use of sandbox for your use case, once it is working?

>
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index bf96f61d3d0..14049378930 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -75,7 +75,7 @@ const char *efi_get_basename(void)
>
>  int efi_get_pxe_arch(void)
>  {
> -       if (efi_use_host_arch())
> +       if (IS_ENABLED(CONFIG_SANDBOX))
>                 return HOST_PXE_ARCH;
>
>         /* http://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xml */
> --
> 2.45.2
>

Regards,
Simon
