Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5706ACF395A
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 15:00:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 588E989198;
	Thu, 19 Sep 2024 17:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AcTTjmHz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B13B089198; Thu, 19 Sep 2024 17:00:27 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85615891C5
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 17:00:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-710d2cf2955so585183a34.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 08:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726758024; x=1727362824; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3DvaNs0WE6AdX4opbQ4I6dDd04VWYtX1gxlmqMeV6dU=;
 b=AcTTjmHzY6HqK4cvIARrSMPb6INE8E3nwueaxA4zeIdITHjOaP/j6azy7+hJjhUNZf
 eQHz8FhkvVmb9Zh7zu2EKnO+TzIIN19UBAS3fVqov6teXlinxIAMlswR4NzcvIwdsXvN
 pE6rgUz8qctspiJtV5J2q1GomyCfDdPt2cBTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726758024; x=1727362824;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3DvaNs0WE6AdX4opbQ4I6dDd04VWYtX1gxlmqMeV6dU=;
 b=Ws/bZaU/ecRnRyuUrLW212Z3KwIRsXWeJKrWNpUJ/ihkKSPs9ZCKTgiMhGdjCZJHOQ
 4J2ZDaSV94LHAbvCzG2qOGckkAV3A2W8EzUorEx4aSyd+O044ctam4l/ZAKcDPl5Ehkm
 hR9RkP74YbZbvKUufptJvV79qWSEzcm2uZ0dVfgIplvseQcKLprt9fDagZv3b6bmVfA+
 iiZ+UwxqzCaLSqyTDNQae0Y58ZL1u4JZPb6pinnBUu/u6wDt8hDz9iUltoNb0j371U7+
 PkJeGuV/wSmTeNXQ7n8um9NNb3hRa8s9RmrRVxCEOm8fxQmBP92mMwzkwiuC6dI/6Ml0
 1U5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWe4BHudoug52GqOmbcUhf/Y2bFgC5yrHFKby0UN2dASciRA7aeThWnVI+tPLyieXHy+1XL1dg=@lists.denx.de
X-Gm-Message-State: AOJu0YyupvzL1mpr8Ie2DBuwuJoJa+lFvscTsKcgTy8q2Z1GX1ZsoqxI
 5LUqFFhsnBvBjm2RmLsdFjIj7Vp4r9Q3qvTNdcaYIGi39PMnOqLNobjSjsz2YmQLaWSQ3Gp2x4X
 tldLznXJgV4uHRi2BwYo9zY28VUhCRYAISDbX
X-Google-Smtp-Source: AGHT+IFDfeuRtbtB/KCv+GFee/GGqzg9gr/w8QvNjYzV4sjZHolLUwScLgA22Z3U8E2UqvkNpdL73K7UL2s2HOHZSvA=
X-Received: by 2002:a05:6358:71c6:b0:1b8:34fb:9696 with SMTP id
 e5c5f4694b2df-1bb14e3ee1amr745845455d.14.1726758024210; Thu, 19 Sep 2024
 08:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240914160548.42551-1-heinrich.schuchardt@canonical.com>
 <CAFLszTjL46Gb03MS7znLujAKC0VkgOrUaZMy7XPw-jpw3TELTA@mail.gmail.com>
 <d95b95d2-7afb-42f2-9a01-75d601368be9@canonical.com>
 <CAC_iWjLCnUpnVGuVYnhzo4EaUmKMSZPws3hSzOOvQqirC71hfQ@mail.gmail.com>
In-Reply-To: <CAC_iWjLCnUpnVGuVYnhzo4EaUmKMSZPws3hSzOOvQqirC71hfQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 17:00:13 +0200
Message-ID: <CAFLszTimJuwFKp6DaRDJ22=0tbNPYbcLMT9hcFrC9Rca6vzAyg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_leader: delete rng-seed if having EFI RNG protocol
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
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

Hi,

On Thu, 19 Sept 2024 at 16:32, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi all,
>
> On Thu, 19 Sept 2024 at 17:20, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 19.09.24 16:10, Simon Glass wrote:
> > > Hi Heinrich,
> > >
> > > On Sat, 14 Sept 2024 at 18:06, Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:
> > >>
> > >> For measured be boot we must avoid any volatile values in the device-tree.
> > >> We already delete /chosen/kaslr-seed if we provide and EFI RNG protocol.
> > >
> > > Could you explain a bit why this is, and where this is checked?
> > >>
> > >> Additionally remove /chosen/rng-seed provided by QEMU or U-Boot.
> >
> > Measured boot relies on creating hashes of artifacts and writing these
> > to TPM. If the hashes don't match the OS will either warn or refuse to
> > boot. The device-tree is one of the artifacts that are measured.
> >
> > If we have random values in /chosen, measured boot will fail.
> >
> > When an EFI RNG protocol is provided by the firmware, GRUB and the
> > kernel will use it instead of /chosen/rng-seed and /chosen/kaslr-seed.
>
> There's a comment on top of that function that explains what happens as well.
> In short the EFI stub does not even look at the KASLR seed and never
> randomizes the physical placement of the kernel. It only does that
> when the EFI_RNG protocol is there.

OK thank you. I suppose I am more just wondering why it got added in
the first place?

Regards,
Simon


>
> Regards
> /Ilias
> >
> > Best regards
> >
> > Heinrich
> >
> > >>
> > >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > >> ---
> > >>   include/efi_loader.h          |  2 +-
> > >>   lib/efi_loader/efi_dt_fixup.c | 15 ++++++++++-----
> > >>   lib/efi_loader/efi_helper.c   |  2 +-
> > >>   3 files changed, 12 insertions(+), 7 deletions(-)
> > >
> > > [..]
> > >
> > > Regards,
> > > Simon
> >
