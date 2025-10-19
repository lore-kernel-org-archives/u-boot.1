Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75A7CCD184
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 15:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EFE2838A5;
	Sun, 19 Oct 2025 17:21:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QLN8sd8j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66E75838AA; Sun, 19 Oct 2025 17:21:16 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A885483893
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 17:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-63c2d72581fso3538835a12.0
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 08:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760887273; x=1761492073; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OwkuDXMHKQ+wvWSPhbBKist9TgWKGGnuhws4IRtxcYo=;
 b=QLN8sd8jOUNN6zM4I2TUhQXbO0waVskzFj30DCJajuf7s36Zp5giO5mXDtV0uozWqp
 gUExtOqcpXKLiRGCVsAM83GpEz8aKG9YNxSV8q8hggSRRf66jWUZaKZ5hest87u5EIi7
 yd7e6tCAtcI0GLCxxeIeu/eaJP+w84J0frsSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760887273; x=1761492073;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OwkuDXMHKQ+wvWSPhbBKist9TgWKGGnuhws4IRtxcYo=;
 b=q2Y9zLX68k1VJiAn1IAG1GBKpaURIQxv93z5vWZvwSR3x2ZAaw4U/i2BWaZnJgng1p
 xQV/vnml0w1ypmKGEO+5A/s3YlSese+nlyGa6BruSeZh8If66UrZecT4dnxlxLhS5vbF
 z59d0QJ+XBAq+lhOSSUJwchqZmlGNwheqnosVWWuTJyVp1ZUU5XbtE51OYgtAQTfqTdC
 d2tajlj1bhXHvYRWi2CVdfFnlA8XfNG1BbNPHCD3xY0qDn/BSQF7itFKaYWEZbympypi
 qOA09TcAcOI/CAQdFX4MGH6Jp/lA5NU1QBhvng6q12a1ZuA3V5uyBZV4P7ehEQ68+pBU
 ymMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlSejkdpXtsewQAQvhsn9/TbMVxZRvBdOc7JqUtfhdajtj7vBfEUzEkXNAL+uAgWDxu5O+ges=@lists.denx.de
X-Gm-Message-State: AOJu0YxIRkjHgGafgJQYnbPOcURLdUD6B8LJR16nQCupZsdMGWHmFYcs
 ci12mcVvNYu+CWkipmnFA4bORlfS0Y/opgihz80YHHYoNEWnxa4JiihDlDNWQWeumR7NOcJYIsf
 Xr9xvxCJ0OX8iEbpEB1qVTVXss6b55m+Vw3kMKX9o
X-Gm-Gg: ASbGncsHTZ+bEMdQnjGnCQwVlsSL4b2igm3J1+9TMCD3L3VyoWwl/UxsP0RlN1G+8ac
 pbtJw8M1PEzODZjEN/nuAjfpL0XaHQsVyWhZt159YDXQmgKsECz3THB5KmJFSMsJ+g0o6HLki0s
 1Z0AG9b1sSIUSHxYYLhzo6WKN2j2mo6PsnFBRuywpQUekWN6j2IGUBoBguP/dJz5fgSjtcIBnwh
 cpWdbuEst090QQwJ/S0oodXfhoc3O/Wp9Hnh/mKqa8FUQJhE3rgyaxbZ+wD8XGOr27Y
X-Google-Smtp-Source: AGHT+IG1BHAHqiAJOWxk4g+f5bNlvVvt2DosPD1PhIfvsLu7y+H2nYa1v8QQtCHdm/GbKJz3fS5LEMa3aqvJ33oFzHY=
X-Received: by 2002:a05:6402:5cb:b0:639:fca4:c471 with SMTP id
 4fb4d7f45d1cf-63c1f6e04eemr9309799a12.28.1760887273063; Sun, 19 Oct 2025
 08:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <a2f2b1cf-aa2a-4628-9d04-f293591f5f9c@siemens.com>
 <59fa7090-9ec0-450c-8ea8-ead768d4e345@siemens.com>
In-Reply-To: <59fa7090-9ec0-450c-8ea8-ead768d4e345@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 19 Oct 2025 16:21:01 +0100
X-Gm-Features: AS18NWA4Gnbu2UButg5NgH5LCcczgdo2tTt-duTSsKBTbRM6WAc_xCCu9J_E_ns
Message-ID: <CAFLszTg5gOP=bNJBBrDsFf-BKYiZF27a0-1t0CgiF6Z0xBD0Zg@mail.gmail.com>
Subject: Re: [PATCH] efi: Select required CMDs from BOOTMETH_EFILOADER
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>, Jerome Forissier <jerome.forissier@linaro.org>
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

Hi Jan,

On Sun, 19 Oct 2025 at 16:02, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 20.08.25 07:50, Jan Kiszka wrote:
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> >
> > There are needed because distro_efi_read_bootflow_net depend on symbols
> > provided by those commands when networking is in use. Imply is too weak.

Reviewed-by: Simon Glass <sjg@chromium.org>

But I would like a bit more info on why 'imply' doesn't do the trick.
Is it due to a depends being wrong somewhere else, perhaps?

> >
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >
> > This obsoletes https://patchwork.ozlabs.org/project/uboot/patch/fffc4713-4f89-4a04-acc6-8b295e453226@siemens.com/.
> >
> >  boot/Kconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index 54ef7052c5c..2813a39b102 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -605,7 +605,8 @@ config BOOTMETH_EXTLINUX_PXE
> >  config BOOTMETH_EFILOADER
> >       bool "Bootdev support for EFI boot"
> >       depends on EFI_BINARY_EXEC
> > -     imply CMD_TFTPBOOT if CMD_NET
> > +     select CMD_TFTPBOOT if CMD_NET
> > +     select CMD_DHCP if CMD_NET
> >       default y
> >       help
> >         Enables support for EFI boot using bootdevs. This makes the
>
> Ping.

Regards,
Simon
