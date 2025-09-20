Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C7BCAC5A7
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 23:02:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 176B582B07;
	Sun, 21 Sep 2025 01:02:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KBaT0Ce/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF6BE830B4; Sun, 21 Sep 2025 01:01:59 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FB148144A
 for <u-boot@lists.denx.de>; Sun, 21 Sep 2025 01:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-ea3dbcc5410so2305817276.2
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 16:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758409316; x=1759014116; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=puNPbyDZA7POrGp4FJp8IgGYSR0KmKC/MBMhGrLooQc=;
 b=KBaT0Ce/nsuflumfoOPxGOntFohaMrvQn5isH/QB66vbPak5bpnEsjkVmdxsZe/267
 TlTux90538PwNGWxIBGJKXd8R7qnbAeI2te0D6ugn6b0oQCZKMTHASC9b2BtujsNZJMF
 2tA7zOc/kD1IID+1CMsw4ZvwveWFWRQPxlVoEYBmBnUE/h1o11MbTO3a/GjWyJq7bo2c
 TwZ0pdumNQbn7RO5/coLv7gRKko5fw+AP/At3lKxpJCicfzVF3jP+zyEVWsyFvE/uRkW
 QRryQBOkaLNu74NFzaDw+Tk0Omeku+iSASo20scN+h9bAPGLnoxMMTCKozI6SZByolVV
 q1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758409316; x=1759014116;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=puNPbyDZA7POrGp4FJp8IgGYSR0KmKC/MBMhGrLooQc=;
 b=CpNu7xsg4XgcOu5H3Y8DRAG6CHTNH7g+cB+XWpotyZwBrdgVOPVbBRu9k3wYmIdgwO
 18AgNb7Wp/IIc6UzPSmv4cvkDX3ceOjSY46FT0bxG/G8Zg+UXb2QhJZBSmyukJVS62s7
 lW3+iV+Ybr5k2+t8Ee2XJhkwUCDzXhVdRp1D3cc1UwlkXMDbEMFAhKAUf9YSyH8e4enj
 oGWcLOCBQi+FWt1Fis6RD+03Bf13NUZ6S5me5tMvxK7maO0x5A01p0Mzw8jbKTjszrYm
 3wqU5xaoTfIzOCfOEu6rhj8n79QVHvFoGCFnATWF5Ueu8O4Q7Zdp8U2vsVoGWWoZ2CFn
 fzEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKj2fP8J+/oCT0NxArjlfHV3Q91nA3Oqi5rmenqMdi6vTgd2M6bzBBhAHOblN8Xwdb064g1KA=@lists.denx.de
X-Gm-Message-State: AOJu0Yzb4d0ewckwaqQjLOOkpzi4AFXNDIdBZrmn0TCAQgRQEDHZoSI8
 cuxSvjeRB9m4wMTxBzUDGN3pmXsYE1TzAsTTU7anLGrtd8dRiSxN5d91LVlis3NeMsMQA8NtA+T
 4mt0N/fR01yDbXHLRc0O8/z2DIiCm1B2vBE3ocKE7qA==
X-Gm-Gg: ASbGncsqRaWFb7SlODIdFZkdTX5cWQGzlx5KP6436St3mTDbTn10W/6kVquz0OAnBMl
 DsXhNt2mRYJMINRML85wzl7s9N5QBmu+fW9SSAgpuDxr6LIVdDw8ch7Gj4V0b0e1NmnKLeHCI9g
 sfLxW46/ZqZnrY8pO+YsiwMfSWdU8KUAL8oJRH6WAX0viSzrEjHTUJ13jTsGHbZSE+Gpkl+rlsY
 R+W9A==
X-Google-Smtp-Source: AGHT+IFtiK+1Hge63j4T6E8c1OQ7XViRR9UOzgkezi60y1xMGr5g46RNvWIOUd+ZCq6xbGJCr5F9YvKQlUBMGAeMQZo=
X-Received: by 2002:a53:500a:0:b0:631:919:cbb9 with SMTP id
 956f58d0204a3-634779e809fmr4894923d50.9.1758409316102; Sat, 20 Sep 2025
 16:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250529150213.27149-1-richard@nod.at>
 <1752760284.mgMEAqHVhB@nailgun>
 <CAPLW+4nz81kT=uTofbf86sqQnGZYB2d4A=mr5P3zT0kOstRKQA@mail.gmail.com>
 <18562990.Emhk5qWAgF@nailgun>
 <CAPLW+4n42ctJC2j5vUnibcWNYr+V1t8jfmD7p1ju95q8R89C-Q@mail.gmail.com>
In-Reply-To: <CAPLW+4n42ctJC2j5vUnibcWNYr+V1t8jfmD7p1ju95q8R89C-Q@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Sat, 20 Sep 2025 18:01:44 -0500
X-Gm-Features: AS18NWDt3Hgdn3jd8KRQ5WQq2fZvDxA--uPUAbpf-SXq__NXDczfdu80IB_8Kd0
Message-ID: <CAPLW+4=gQjdoQA0qy71iDwAJz-fqekfGsUbar00m0Rm65YTHhA@mail.gmail.com>
Subject: Re: [RFC, PATCH] fdt: Make sure there is no stale initrd left
To: Richard Weinberger <richard@sigma-star.at>
Cc: Tom Rini <trini@konsulko.com>, Richard Weinberger <richard@nod.at>,
 upstream@sigma-star.at, 
 u-boot@lists.denx.de, ddrokosov@salutedevices.com, sjg@chromium.org, 
 tharvey@gateworks.com, ilias.apalodimas@linaro.org, 
 kojima.masahisa@socionext.com, upstream+uboot@sigma-star.at
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

On Thu, Jul 10, 2025 at 12:20=E2=80=AFPM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> On Thu, Jul 10, 2025 at 9:40=E2=80=AFAM Richard Weinberger
> <richard@sigma-star.at> wrote:
> >
> > On Mittwoch, 9. Juli 2025 19:05 Sam Protsenko wrote:
> > > > I think we need to distinguish two cases:
> > > > 1. The caller explicitly does not want to have an initramfs. e.g. y=
ou run  "bootm addr1 - addr3".
> > >
> > > Yes, so fdt_delprop() lines should be probably moved to appropriate
> > > users, e.g. image_setup_linux(). Can you take care of this? I'm in th=
e
> > > middle of something else right now and can't spend too much time on
> > > this. Or we can just revert this patch for now, to fix EFI apps
> > > breakage.
> >
> > I'll try to allocate time for that.
> > Are we in a hurry? I'm fine with reverting but since the next release i=
s months
> > away and the change is only in next I'd first try to find a solution.
> >
>
> No, you're right, we have time. I specifically reported the issue
> instead of sending a revert, so that we can try and look for a
> solution. So I'm ok waiting, if you have time to sort this out. Please
> add me to Cc: when you send a patch, I can test it on my HW for you.
>

Hey Richard,

Did you have a chance to look into reworking this patch? I'm still
carrying a revert locally (to make GBL EFI app work), and would like
to get rid of it. Please advice if you have a plan on handling this in
the near future.

Thanks!

> P.S. The change is in master already btw, not only in -next, it's MW righ=
t now.
>
> > Thanks,
> > //richard
> >
> > --
> > sigma star gmbh | Eduard-Bodem-Gasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
> > ATU 66964118 | FN: 374287y
> >
> >
