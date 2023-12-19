Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03980C35274
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 00:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 302CB8744F;
	Tue, 19 Dec 2023 01:17:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fyo0/Zou";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA1DD874D9; Tue, 19 Dec 2023 01:17:21 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75DEE8718F
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 01:17:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5c67fdbe7d4so633943a12.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 16:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702945038; x=1703549838; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z6q6Fmxd6AHFluJfj/zrRQKq5SCBuemjCvKmjM5c/gg=;
 b=fyo0/Zoup+OjIYp509xZ8IM14YaNirRImGfvEn3w31JENPbWCiH9Oe6N2pEHeq9SGp
 XA9OK4wNqoP17EZpkWf9E6OWCHEvG7o4Ie7cheFbN6GQdaK/HwKrk06KBXGXOVKLqxby
 H65YlTWfknVcmQqPHnlGj8rR44d8xz/VmNMT8HOeLtCeHgd2HPBVyhj9LniLT5vLNRWO
 Q0MdvCyXPxES24cRBVs/Ota8b0+4gAsXyFWalBPRuB72fyUgo94plT4KvByFcx9P5d1S
 iVnGBhkRCpzSdM69oeSlXKQ076oTQTeNWrEgo2CzBECXzwwIdKHV3ptRy0zylMWJGTIU
 jwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702945038; x=1703549838;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z6q6Fmxd6AHFluJfj/zrRQKq5SCBuemjCvKmjM5c/gg=;
 b=Rst/Uwr8nhdGXWHnZH7lFyCFwmLasSeRr13IftG8vT9geibKrEHbCB484mNc9hQw8Z
 nvKG3hpym9e7hiRTTMJtGeZUhUPS0Z6dDvTKWN/Sr7G9tAwTiitNt5Ft3EOTF5bWkuhw
 OY3D0otOs6OvcX0QXxC3sRZ3hPH5FGH381m4OaUveaxvQdbtYT4FH4Uxe6BfAhxr3gr+
 tX/7qqUl0SZs7uYkwNuarooTISTQRJejM+nQIbrPDxBDHLQwxzhdCPhrmOSHuFWBqwVy
 i1aWNxDkdxZoicLje67qiwsttOuQIZX0DLI8mRBcUyJ8/fNQiqNf+gMIOndH8APD5WTA
 zgAg==
X-Gm-Message-State: AOJu0YwaLkCtFs3WVhd6N7VUSle3EnBVBlNsmJd6QfoPnGoPZvJG0CwC
 zaXJf2OjXH1RyAUyoAXf9bM2eg==
X-Google-Smtp-Source: AGHT+IFmBIEsfqpN+sSojNqFsFv2LATPOKnxKTAFH8Ip2EKJt8depAP8BypSgZr4rWRAaw/2L/CsmA==
X-Received: by 2002:a05:6a20:7d9c:b0:18f:c77b:9fdd with SMTP id
 v28-20020a056a207d9c00b0018fc77b9fddmr40388811pzj.1.1702945037710; 
 Mon, 18 Dec 2023 16:17:17 -0800 (PST)
Received: from octopus ([2400:4050:c3e1:100:3aac:5efb:223c:7d9c])
 by smtp.gmail.com with ESMTPSA id
 f13-20020a170902e98d00b001d0511c990csm2421238plb.237.2023.12.18.16.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 16:17:17 -0800 (PST)
Date: Tue, 19 Dec 2023 09:17:14 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3 3/4] net: tftp: remove explicit efi configuration
 dependency
Message-ID: <ZYDhClYupQxNJ++a@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>, trini@konsulko.com,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de
References: <20231218023842.281336-1-takahiro.akashi@linaro.org>
 <20231218023842.281336-4-takahiro.akashi@linaro.org>
 <CAPnjgZ0qw7j3TCMN+xH6ONaWvUyRvkWpsZJd2PQWHYBhZkTD6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0qw7j3TCMN+xH6ONaWvUyRvkWpsZJd2PQWHYBhZkTD6g@mail.gmail.com>
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

On Mon, Dec 18, 2023 at 08:01:46AM -0700, Simon Glass wrote:
> Hi AKASHI,
> 
> On Sun, 17 Dec 2023 at 19:39, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > Now it is clear that the feature actually depends on efi interfaces,
> > not "bootefi" command. efi_set_bootdev() will automatically be nullified
> > if necessary efi component is disabled.
> >
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  net/tftp.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >
> 
> I have the same comment here as the 'fs' patch.
> 
> > diff --git a/net/tftp.c b/net/tftp.c
> > index 88e71e67de35..2e335413492b 100644
> > --- a/net/tftp.c
> > +++ b/net/tftp.c
> > @@ -302,12 +302,10 @@ static void tftp_complete(void)
> >                         time_start * 1000, "/s");
> >         }
> >         puts("\ndone\n");
> > -       if (IS_ENABLED(CONFIG_CMD_BOOTEFI)) {
> 
> Shouldn't this depend on your new CONFIG? What happens if EFI_LOADER
> is not enabled?

The trick is in efi_loader.h.
If EFI_LOADER (more specifically CONFIG_EFI_BINARY_EXEC) is not defined,
this function gets voided.  See patch#1 in this version.

I took this approach in order not to make users much worried about
what config be used as they are not familiar with UEFI implementation.

-Takahiro Akashi

> > -               if (!tftp_put_active)
> > -                       efi_set_bootdev("Net", "", tftp_filename,
> > -                                       map_sysmem(tftp_load_addr, 0),
> > -                                       net_boot_file_size);
> > -       }
> > +       if (!tftp_put_active)
> > +               efi_set_bootdev("Net", "", tftp_filename,
> > +                               map_sysmem(tftp_load_addr, 0),
> > +                               net_boot_file_size);
> >         net_set_state(NETLOOP_SUCCESS);
> >  }
> >
> > --
> > 2.34.1
> >
> 
> Regards,
> Simon
