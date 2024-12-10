Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB32DE77180
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 16:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDF1D8029E;
	Tue, 10 Dec 2024 17:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kyJ/o5pZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACCD7802D5; Tue, 10 Dec 2024 17:17:40 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97A3F80269
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 17:17:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa543c4db92so344236566b.0
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 08:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733847458; x=1734452258; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e8i9x53NB7xd1bSYFdHjae7wZIvcK+8q0cKMUVpqPaA=;
 b=kyJ/o5pZmW8MY6yDjDAlPC+atWLjSVM0Sa6dXMFY3uWJLXlVmC6oIclgxt6LcYge9A
 MG5JBtxf/62zZLY21fxHF1oW1aSv4fxlUKKeRbBWGQKGMNOcIfS4cStGCDyNT1ooOmA5
 Gjvb2UkmaXl0VgM23teV/UMEs5Sf3i1GF4A6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847458; x=1734452258;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e8i9x53NB7xd1bSYFdHjae7wZIvcK+8q0cKMUVpqPaA=;
 b=bq/67XwB4Mf2mQnzaVkifQERHWLVVv0fULJK+8/vp/JefFtoBLytFt9o21/C23rpl5
 H06T6AvDYurV6tnf0xLP7gh8Tguj0S5gxs4tvQW6vDSzDmlon6KocUOe+XjjXEVw95lj
 vhZ4LN/22dUXwqt1fD+c3U+R8vhfuqrzgcPXjCVQhScQgcbmi5DEn+VTBXi/tBc9BqU+
 wP/91vulWCIGyAGk0/nGlPLKFYnLIUEh+MAocioXzlfP4uT31D9VIT1g9hlzxHu8gFPW
 9QJceYxXUla8at551LuiAMJgfi8oXgdRxb0hND8WrSgVjpS0GvIhWjQ1f4EtbzBt9HPD
 x+3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiZFdZF+51Hd1IEhX+X9QiMIHiZSoUhXwWOg5nOv7mCU1kEf8z1ntSLPjUxkmcPWLM1QhgWu8=@lists.denx.de
X-Gm-Message-State: AOJu0Yyzr+415DLQLyM/k0qLu21qOJ5wCHv6eZofYvIMzPjHPmls5/0u
 SuusK3p8k1fVpBBvdyFP1Jkhx6iwdX82B8TJenmKT+Sn2OV6bfpxSsLaYNDVn7UaURrcboel//y
 5Y7YPusYiViwaHqpYtqP/HCPNH2mZO4iq/qpQ
X-Gm-Gg: ASbGncsbkDvyCaMVzd8u/A+fJf1EQJ4HNoHspl/CWNRH61VcbwOPO3G9QUPjKN1/yI1
 cRKuYKQ8kUBuChUcEIAgJK5ggYwGuxCAp9ru9
X-Google-Smtp-Source: AGHT+IHJjFjNh3qnF8qoarC9GCTwFZKa/CpdKIKSF5944oN/3B3OENG6enKK5VDm46YbifvLl2s7Fu1lLEF4Tl2j4Rg=
X-Received: by 2002:a17:907:9548:b0:aa6:759c:980 with SMTP id
 a640c23a62f3a-aa69cd62729mr434411766b.34.1733847457999; Tue, 10 Dec 2024
 08:17:37 -0800 (PST)
MIME-Version: 1.0
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-10-mjg59@srcf.ucam.org>
 <1a9d7b81-b06f-43bd-969e-2961ad8cd1e0@gmx.de>
In-Reply-To: <1a9d7b81-b06f-43bd-969e-2961ad8cd1e0@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 10 Dec 2024 09:17:26 -0700
Message-ID: <CAFLszThHxSt7-8QScz8+d96PwrZy--MKYsnrhfdCw8TK0c8rLA@mail.gmail.com>
Subject: Re: [PATCH 09/10] Fix efi_bind_block.
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>, 
 Matthew Garrett <mgarrett@aurora.tech>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Tue, 10 Dec 2024 at 01:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 23.11.24 20:55, Matthew Garrett wrote:
> > From: Janis Danisevskis <jdanisevskis@aurora.tech>
> >
> > efi_bind_block had two issues.
> > 1. A pointer to a the stack was inserted as plat structure and thus used
> > beyond its life time.
> > 2. Only the first segment of the device path was copied into the
> > platfom data structure resulting in an unterminated device path.
> >
> > Signed-off-by: Janis Danisevskis <jdanisevskis@aurora.tech>
> > Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> > ---
> >
> >   lib/efi/efi_app_init.c | 29 +++++++++++++++++++++--------
> >   1 file changed, 21 insertions(+), 8 deletions(-)
> >
> > diff --git a/lib/efi/efi_app_init.c b/lib/efi/efi_app_init.c
> > index 9704020b749..cc91e1d74b8 100644
> > --- a/lib/efi/efi_app_init.c
> > +++ b/lib/efi/efi_app_init.c
> > @@ -19,6 +19,15 @@
> >
> >   DECLARE_GLOBAL_DATA_PTR;
> >
> > +static size_t device_path_length(const struct efi_device_path *device_path)
> > +{
> > +     const struct efi_device_path *d;
> > +
> > +     for (d = device_path; d->type != DEVICE_PATH_TYPE_END; d = (void *)d + d->length) {
> > +     }
> > +     return (void *)d - (void *)device_path + d->length;
> > +}
> > +
> >   /**
> >    * efi_bind_block() - bind a new block device to an EFI device
> >    *
> > @@ -39,19 +48,23 @@ int efi_bind_block(efi_handle_t handle, struct efi_block_io *blkio,
> >                  struct efi_device_path *device_path, int len,
> >                  struct udevice **devp)
> >   {
> > -     struct efi_media_plat plat;
> > +     struct efi_media_plat *plat;
> >       struct udevice *dev;
> >       char name[18];
> >       int ret;
> > -
> > -     plat.handle = handle;
> > -     plat.blkio = blkio;
> > -     plat.device_path = malloc(device_path->length);
> > -     if (!plat.device_path)
> > +     size_t device_path_len = device_path_length(device_path);
> > +
> > +     plat = malloc(sizeof(struct efi_media_plat));
> > +     if (!plat)
> > +             return log_msg_ret("plat", -ENOMEM);
> > +     plat->handle = handle;
> > +     plat->blkio = blkio;
> > +     plat->device_path = malloc(device_path_len);
> > +     if (!plat->device_path)
> >               return log_msg_ret("path", -ENOMEM);
> > -     memcpy(plat.device_path, device_path, device_path->length);
> > +     memcpy(plat->device_path, device_path, device_path_len);
> >       ret = device_bind(dm_root(), DM_DRIVER_GET(efi_media), "efi_media",
> > -                       &plat, ofnode_null(), &dev);
> > +                       plat, ofnode_null(), &dev);
> >       if (ret)
> >               return log_msg_ret("bind", ret);
>
> Here you have a memory leak for pointer plat if ret != 0.
>
> Simon suggested a follow up patch. Instead we should fix it in this patch.
>
> @Simon
> The logic in the caller setup_block() looks wrong.
>
> LocateHandle() does not ensure that when you try to read from the block
> device the same still does exist. E.g. if a USB device is removed the
> block IO protocol could be uninstalled and the handle deleted and the
> EFI app may crash. Please, call OpenProtocol() with attribute BY_DRIVER.
>
> HandleProtocol() is considered deprecated. Please, use OpenProtocol()
> instead.

Can you please send a follow-up with your ideas on this?

Regards,
SImon
