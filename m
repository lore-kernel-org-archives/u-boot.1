Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C20C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 13:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 143AD835FE;
	Wed,  9 Apr 2025 15:05:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="luSIIaiX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEFA083767; Wed,  9 Apr 2025 15:05:03 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A2A5835CD
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 15:05:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e673822f76so11135036a12.2
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 06:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744203901; x=1744808701; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cvhD64QUpcLBJiTrdya869Qg3fcLV/KwdwOTGMvB92s=;
 b=luSIIaiXosOkaIlHgiR+4v/9Z+k9nZJbm718wqzQh8uTpiO6YcY263bbxvtIhny4NP
 GDAmDMG0JYYLEnaKYhOsfL/Lk4FniLUDvOF//TulAYeL2G2sRIjNCrf72ADYWNVd+/1o
 ujEaxjC2W9H7Okl8jGCnJRsAkiNoT4WswFxa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744203901; x=1744808701;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cvhD64QUpcLBJiTrdya869Qg3fcLV/KwdwOTGMvB92s=;
 b=j1VPepczfMXfRgFrnzPLrbkCqgTZyKpuHMfsTYnczgIZJJwdkzWrn4no8p8h+813FX
 krwqILCrBS4WVDV3t8gm7mVdXN/LU1toBTZmURdQuzsz36ow4owSJoDX4V/UwPwm1RPk
 Rlc9L62Q6LDvq9J1l8Qo2F9qqsPdWtHVd+ZfKL5w8iGCiaZJuPpL6IeVQcxvTADrwFGz
 nkZDsim/dYjPxM0vCXNi/8ceLEg8ZErl3nZzMUU9sXrmHB7MonP+xy8LXXcvSy3dWS3U
 EVhBVO+OYimjil7GUVR5NdYGHoPWEJhcKUWKXzW6ktKHaV3GXtdLp0PrBW5WMG2F5OUe
 W1GA==
X-Gm-Message-State: AOJu0YwbbPy+ZmYbrdQ10EekTH2jW79TmudsO44aeumlvyqE1le2+6aP
 4pnp3tIztkhbwD3LKS0D6y2H52bgauRvsBIksejlPjjOTAEqKIIRz2oIQUn+4eSz/xgmSN9Z0+0
 mV10G/26vavG3RqIEEKs5FNJ8aBGg94+8XqXB
X-Gm-Gg: ASbGncs70a2PckFKARtrhHxncFz3IUayyTVWbYpI+PmiZaZHYhmGBOo1p7EqstBbbLC
 vOKXIuU3Fm0y8P82mcsJWRbnRjk2Bl2LXkIGzYcG8YN4B5jI6oOlxtIZnfttUHss+Evou9xh8Cz
 jB8WsVS0DSZM5tQH5GKaSKzzo=
X-Google-Smtp-Source: AGHT+IGS/9HMm6NePpf82iFl1mNyqZqF54BL6E6XqW1cE01QMogMSBWA1hHngc88pj0Tysr12V5laBv719+11g+mkcw=
X-Received: by 2002:a17:907:b84:b0:ac3:bf36:80e2 with SMTP id
 a640c23a62f3a-aca9b65efc5mr268373166b.20.1744203900395; Wed, 09 Apr 2025
 06:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250407105151.689453-1-sjg@chromium.org>
 <20250408221324.GA5495@bill-the-cat>
In-Reply-To: <20250408221324.GA5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 9 Apr 2025 07:04:48 -0600
X-Gm-Features: ATxdqUGA5TABFd_mFez1jDIpGav47OFZHbwxABSawAJlOX0-PoSHH_WJalF0CFU
Message-ID: <CAFLszTg7-yM0L8uuJyN7Jpsb1LbvOYO76cUWj+H719mfc97mMQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] patman: Separate gitutil fully
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Douglas Anderson <dianders@chromium.org>, 
 Sean Anderson <seanga2@gmail.com>
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

Hi Tom,

On Tue, 8 Apr 2025 at 16:13, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Apr 07, 2025 at 10:51:42PM +1200, Simon Glass wrote:
>
> >
> > The gitutil module uses Patman's settings module, which is not allowed
> > as it is supposed to be a separate package. This series ties up this
> > dependency.
> >
> > This series depends on these two patches being applied:
> >
> > https://patchwork.ozlabs.org/project/uboot/patch/20250227192735.406389-1-sjg@chromium.org/
> > https://patchwork.ozlabs.org/project/uboot/patch/20250328130225.2607974-1-sjg@chromium.org/
> >
> >
> > Simon Glass (5):
> >   patman: Untangle settings from gitutil
> >   patman: Pass the alias dict into gitutil.build_email_list()
> >   patman: Pass the alias dict into gitutil.email_patches()
> >   patman: Pass aliases to Series.MakeCcFile()
> >   patman: Update Series.ShowActions() to pass alias
> >
> >  tools/patman/control.py       | 11 ++++++++---
> >  tools/patman/func_test.py     |  8 ++++----
> >  tools/patman/series.py        | 32 ++++++++++++++++++++++----------
> >  tools/u_boot_pylib/gitutil.py | 34 ++++++++++++++--------------------
> >  4 files changed, 48 insertions(+), 37 deletions(-)
>
> I just want to reiterate my question / request to host these outside of
> the U-Boot sources themselves so they can be managed (both in the sense
> of U-Boot as user and as maintainer of sources) following normal Python
> best practices? I'd be fine even with something under
> https://source.denx.de/u-boot/<something>/patman, etc.

Yes I am working towards that. This series cleans up something missed
in the last series.

After this series there is really just 'patchstream' left, which is
used by buildman and patman. I haven't quite come to terms with the
idea of moving it to u_boot_pylib yet.

What are the best practices you are referring to?

As to location, I can keep it in my tree and just delete it from yours
if you like.

Regards,
Simon
