Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5BEE7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 15:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18497800D2;
	Mon, 16 Dec 2024 16:16:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KWPj15TL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1AF4800D7; Mon, 16 Dec 2024 16:16:10 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD8408003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 16:16:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d3f28881d6so5536679a12.1
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 07:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734362168; x=1734966968; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SV9BwhofTFrXo4DHTY73DdxprAXxy0pwc1F2EryCfAc=;
 b=KWPj15TLUxhfs4o0oqS5oJjC1NqsD2e2AD5CnJNSVv/gpGz5Fh25CLybhpN8Vd7TJm
 dRtraaTxLf6Fw0BISrrWSa36JzbEbVxZZk+TSu+Wp29vunwizI8hzyfLOzc5ojYptm8t
 r6fIqIhq5ViOVyQfwurRoFaxbfV1lQqLUDCpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734362168; x=1734966968;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SV9BwhofTFrXo4DHTY73DdxprAXxy0pwc1F2EryCfAc=;
 b=vzXgXMzuM3kvGtfRTiq/QBd4stu0rWbvlrijAYX8aYTnxtstlVrnqWZxH4tsFCkKIl
 JXpixXOqwOHH1qXmzidBPLHZj/wYHEsju28qCuk6bH/ykWTjwGWg5mWdTmZjWjGn2Ant
 z/vwDQPE/EIbrvJCXnzbFGjZ+YXT2GQrlL1T0o5bHV5Ogc0IIx8V9na23P00VDCq6iCg
 IRg0L99DnVf1o8Jhf6c+AthWldFmxXW1CMlRzWlM9PhaAEstugUPlqiMcTWfBK77o6X+
 tKy6dkLhUrrUW4Wad1UY4bCRMiDBQxgTekgv+cpolmmcWbNlIvzpSCjkGuTZ9KpOfx6L
 B0ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6N5alYkfTa4I14s74kBaLriqWS/2uyRQl0WAIxDlOG0XEB0tbTftQJiUMwx9uKe2skQPsZO0=@lists.denx.de
X-Gm-Message-State: AOJu0YyVoHBOcg7gQUW2V4nxo77lG4LgIFs1VpsD8LfDoGXivWwhv7PK
 OZk+f6iqdnAhn/7BnpZAxXPYVH3M4+qBEd1Six8oWtBWH8Mv3fIzy/BwcHuqE8EF5H7QO6OnDkB
 BDA//PLDJi3mthR1WsLrxa55uZDi4xGbg78zw
X-Gm-Gg: ASbGnctHQFVI3KFeQHzormj19IAqLxUZ4u7CM774l4PqIxbzVx/aG+i1Kt8nIO7SXGI
 qAYYKFI4vI7zsw2pPztRYu/ZNgswpJHRb8hbN1Gk=
X-Google-Smtp-Source: AGHT+IFqccI/CXafTT49PGh9OS3R1Mq6JYBzlFx5e05OVMc+nkcs9IcFwPLD+8/kp581DZ8LmQruOJWWSNs2yfeDt3E=
X-Received: by 2002:a05:6402:4494:b0:5d3:ba42:e9e3 with SMTP id
 4fb4d7f45d1cf-5d63c31e809mr35902839a12.13.1734362168349; Mon, 16 Dec 2024
 07:16:08 -0800 (PST)
MIME-Version: 1.0
References: <20241209162801.288363-1-sjg@chromium.org>
 <20241209162801.288363-9-sjg@chromium.org>
 <c95a1f38-43e7-4198-8763-4856defbc9ba@gmx.de>
In-Reply-To: <c95a1f38-43e7-4198-8763-4856defbc9ba@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 16 Dec 2024 08:15:55 -0700
Message-ID: <CAFLszTgvzCVh8KW3zKW2snc7H4Z82Zz5My1zxQWq-VNnnS0puw@mail.gmail.com>
Subject: Re: [PATCH 8/8] efi: Avoid a memory leak in efi_bind_block() on error
 path
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Matthew Garrett <mgarrett@aurora.tech>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Janis Danisevskis <jdanisevskis@aurora.tech>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, 10 Dec 2024 at 01:15, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 09.12.24 17:28, Simon Glass wrote:
> > Free the memory used if an error occurs.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Suggested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >
> >   lib/efi/efi_app_init.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/efi/efi_app_init.c b/lib/efi/efi_app_init.c
> > index cc91e1d74b8..fec3f348cfb 100644
> > --- a/lib/efi/efi_app_init.c
> > +++ b/lib/efi/efi_app_init.c
> > @@ -60,8 +60,10 @@ int efi_bind_block(efi_handle_t handle, struct efi_block_io *blkio,
> >       plat->handle = handle;
> >       plat->blkio = blkio;
> >       plat->device_path = malloc(device_path_len);
> > -     if (!plat->device_path)
> > +     if (!plat->device_path) {
> > +             free(plat);
>
> As of origin master origin/next (9dd0a9ecaa539ad) plat is a local
> variable and not a pointer. You cannot free it.
>
> If there is some prerequisite patch that is making plat a pointer, you
> should add this correction to that patch.

This patch is for sjg/master as the original series has not landed in
Tom's tree (yet).

>
> Best regards
>
> Heinrich
>
> >               return log_msg_ret("path", -ENOMEM);
> > +     }
> >       memcpy(plat->device_path, device_path, device_path_len);
> >       ret = device_bind(dm_root(), DM_DRIVER_GET(efi_media), "efi_media",
> >                         plat, ofnode_null(), &dev);
>

Regards,
Simon
