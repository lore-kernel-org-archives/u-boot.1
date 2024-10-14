Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89E0D18153
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 21:51:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 680A089214;
	Mon, 14 Oct 2024 23:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gO8rcOfo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BE1A89215; Mon, 14 Oct 2024 23:51:36 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B26D78920D
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 23:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cc1b20ce54so8013816d6.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 14:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728942692; x=1729547492; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zDKA3Xq1nAcsFK9JvGJgw3yQh2VTTeoM/Xe0kgRxxEw=;
 b=gO8rcOfocR1HeTsDjEq7LWIPdrX7acVh9/oJbgWwmlCmDk1aqMx6EppxYjJmDVafhw
 AC613MFYBJ6J4P68sphOe2I4/SeF+ZK4V4SwMq6tPhj2EbhuxZywFpui1t53vi2iQDyj
 sTm3brgoGxWtPuWoT2K++M7yHc6MEkQ5v58qI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728942692; x=1729547492;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zDKA3Xq1nAcsFK9JvGJgw3yQh2VTTeoM/Xe0kgRxxEw=;
 b=hcm0IbZE9duZ0wd8X8qrEbLzSyVK07TM8uwwH7grC+uVhc5hvGUC9c/hv4h3i87AAp
 +XUreV/UZfTynyX26vM/6BsnZK91KEPBl4hr6WvOyoNmGBVfqTE5gLKYo7xEkV1Kpu06
 jgSvPoMZyBwYRnNTOSCAG371r2zASZ1aA1fA3CMsyBS+cl2srq4/DIVs7HtWAuCzV1gR
 MYountVCs+GorgswWiAAoD6RCZz9cu0hz3YAYTlu8BmzsSB3Nn4uV7tKU0p2tJr/AHig
 B9RwgY2hXBxpOSBd2h+6KOHYF3zqx6GYb6KizCdu1z4xiTX68FLfpXpmuYyG89ZOhzI2
 mNVw==
X-Gm-Message-State: AOJu0Yys29qvWfVydlaQCCSRHnWVpJv9E/u6t9yW+TArasmJfyG5ASgL
 ex9cR/9PFpTI+KIBiHKZBEGSJu2c3C/juq/V3gEEVD6p9hdLZ3lL7z3FdkczFhk22BAprfrvGcx
 a7L1G4dcSKLeqNbVIUGaSHwmmMLqD8CuReIWMn5B39yqTFvY=
X-Google-Smtp-Source: AGHT+IFcDkdJdGDZK9MF/+xGUIjXjZdvPc3FMP3fkvO8g1cy9GiranJoHHjr2DxqvsBOYQVa/x9GwJIwB8c+jaxHyr8=
X-Received: by 2002:a05:6214:4981:b0:6cb:f853:9eca with SMTP id
 6a1803df08f44-6cbf9d10272mr172388416d6.25.1728942692735; Mon, 14 Oct 2024
 14:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20241012232231.5638-1-sjg@chromium.org>
 <20241012232231.5638-2-sjg@chromium.org>
 <20241013161520.GM14210@bill-the-cat>
 <CAFLszTjijFBZar31k1QaLUKcFQyD+CGqyo5wH=7agFF1gr-CLQ@mail.gmail.com>
 <20241014211248.GY53053@bill-the-cat>
 <CAFLszTg6fVsasb8=CJLqFm-T9Vys9_hJDeKfAfTmvfWXNcPZZA@mail.gmail.com>
 <20241014214948.GE53053@bill-the-cat>
In-Reply-To: <20241014214948.GE53053@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 15:51:22 -0600
Message-ID: <CAFLszTjJp-+bg8UNTvaLbO77xD2xJyX4aZABg91Cb4jk3oV5pw@mail.gmail.com>
Subject: Re: [PATCH 2/2] qconfig: Ignore defconfigs containing #include
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Mon, 14 Oct 2024 at 15:49, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 14, 2024 at 03:35:23PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 14 Oct 2024 at 15:12, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Oct 14, 2024 at 02:20:00PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sun, 13 Oct 2024 at 10:15, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, Oct 12, 2024 at 05:22:30PM -0600, Simon Glass wrote:
> > > > >
> > > > > > Running "tools/qconfig.py -s" will re-sync files with #include in them
> > > > > > and so un-#include them.
> > > > > >
> > > > > > Ignore these and mark them as failures.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/28
> > > > >
> > > > > How about marking them as warnings? It may be good to re-sync
> > > > > configs/am62px_evm_a53_defconfig for example and then re-add the
> > > > > #include line, but configs/am62x_evm_a53_ethboot_defconfig on the other
> > > > > hand very much should not be resynced. Thanks for getting on this issue
> > > > > so quickly.
> > > >
> > > > Do you mean still do the resync, but show a warning? It does
> > > > obliterate the old defconfig, but I suppose people can just not commit
> > > > the changes. Is that what you are thinking?
> > >
> > > No, sorry for being unclear. I was thinking it should NOT be resynced
> > > but counted as a warning not a failure.
> >
> > Well qconfig doesn't have the concept of a warning, or at least not in
> > the title. How important is this?
>
> I assumed it was using the same status counter bar that buildman uses.
> If you can't easily do warning not error, OK.

No, it's a completely different program, unfortunately.

Regards,
Simon
