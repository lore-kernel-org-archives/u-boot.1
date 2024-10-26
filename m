Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAD8D10BE5
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 08:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5D3588DF1;
	Sat, 26 Oct 2024 10:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VKxpRd8e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F056D88B4B; Sat, 26 Oct 2024 10:11:22 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7738588B4B
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 10:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71e49ad46b1so1838654b3a.1
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 01:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729930277; x=1730535077; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u93NYpenY6edniktxX5Gs+TTsmwn02LA1+Gd82ynyCo=;
 b=VKxpRd8eXyEW7kri9J3sVC3Pv8MjFcMi5UpQyH5y8ZYlXjXAVNxkaFDlElHwYzlD8b
 eXdV+FE60yxzsezI2YWK0PVrotsysCOtBCgWfwnUuV/vu49BZU6fZTbfeynTSQIeACQG
 97/FAou7dKovBx5Yf0CQhMSPfG8U5Dkp4pP1jf1afcbPKqaIhH72VOmV3VkqOcT084gi
 mHD1wBVkZdpFSELzX8miAKA1V6SZot4WVIK0UEWIu7zSU9SFaUf9NJGBcC52CtS81trH
 gkDZSHTSmAGNTQlTtaAEYpWSPTgJjs6OLQtpFjnxvVeJLQ8or+sYPej83wCHwIGJ9w8L
 o63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729930277; x=1730535077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u93NYpenY6edniktxX5Gs+TTsmwn02LA1+Gd82ynyCo=;
 b=NDKXK3+S/WZFmNLKFtP67rUVUKQEOCC7K1GQ2fsTzI8royfesaVNsPLGWAE8x+SMKq
 ysDOs4xiR87hJaJNGXs3NcnvBYniErjoDs3Vfq/2kiNnxjqtDg0Hv6RwmqVSC0QoBLGr
 dKz3WKlzP/0X6EEXIjGhB8YLB4C6gLxZMMkh8UCt6b18ua2MqlCB5YhDfbUT2pNtI1l1
 PqdD3XAkDkWsHeraT02JL837pyCjW+rCTNCyFp5DYrovYQNRcrLbPOli43tJuzkfpkYG
 dujVqdSAmuVzj31Sp0/3q7OhiIOHhXtp2QNYRfcy9BhhQLuDKZnDX2HLnGBirFAkpvtg
 hQCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbAF+WfTJaYH9RefG3ojaQsuhxc3mZk6IxoM4O1f0UgFY4pfLO4d+Wcjv4irLLL9X84oDuLmI=@lists.denx.de
X-Gm-Message-State: AOJu0YyxJkVht7gDzjpf9++qsvnib7/1UWahIAK7Ss1CD5Ob/gcki0gm
 eBMWVqBwLaPBxeNM3/H/TMHGIgzXHAR3IjoX/rc2C2h8xKuJoj37q+MkyraLRLJOmeyzPFf7Aoj
 3RZCjhs8W5no91PKsEW5CW4aqgGy1oC09ep0g0HbQkQYk+mFt
X-Google-Smtp-Source: AGHT+IFmktCGFKvedsKLG0Fe7PCUdgfPZt+7c3SU8TqJLwkZYjWTBJAr/FXL3gzd2Jj3XVuMAK/PpQ4A4gY4+zy0J1o=
X-Received: by 2002:a05:6a00:ccf:b0:71e:7745:85b8 with SMTP id
 d2e1a72fcca58-72062f4e66cmr3117841b3a.1.1729930276923; Sat, 26 Oct 2024
 01:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <ZxZk4K4ff1T3gUVm@smile.fi.intel.com>
 <CAFLszTjuodDFZW8fJDL1Q3nByLVzcTTEAeJfws-sbtupCwNd8w@mail.gmail.com>
 <ZxenO05qCbt5IIZS@smile.fi.intel.com>
 <20241023-gizzard-untracked-4a1c6d2f6be6@thorsis.com>
 <ZxkNnJxVHSlxNjSV@smile.fi.intel.com>
In-Reply-To: <ZxkNnJxVHSlxNjSV@smile.fi.intel.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 26 Oct 2024 11:10:40 +0300
Message-ID: <CAC_iWj+adgo3Kyd_j77P3_OWzpad8xOB2Cc8NxsxQNrQrDRi2g@mail.gmail.com>
Subject: Re: enabling W=1 by default
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
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

Hi Andy

On Wed, 23 Oct 2024 at 17:52, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Oct 23, 2024 at 09:52:09AM +0200, Alexander Dahl wrote:
> > Am Tue, Oct 22, 2024 at 04:23:07PM +0300 schrieb Andy Shevchenko:
> > > On Mon, Oct 21, 2024 at 06:32:21PM +0200, Simon Glass wrote:
> > > > On Mon, 21 Oct 2024 at 16:27, Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > >
> > > > > looking at the redness of the output of `make W=1` here is the question:
> > > > > isn't it a good time to enable `make W=1` by default. Yes, I understand
> > > > > the impact, but at least we can do it mandatory for a _new_ code submitted to
> > > > > U-Boot, right?

I think this is a good idea and perhaps we can do it per subsystem. I
cleaned up EFI a few years ago, but some new have crept in.
I've sent a bunch of no brainer patches, once I clean all of it (and
assuming it's doable), I 'll try enabling W=1 as the default for
efi_loader

thanks
/Ilias
> > > > >
> > > > > Ideally I would have what Linux kernel has for a few releases already, i.e.
> > > > > Werror by default and getting close to make a clean builds with that and
> > > > > make W=1` at least against default configurations (yeah, with U-Boot there is
> > > > > probably no default, but sandbox one).
> > > >
> > > > Warnings should be warnings...
> > >
> > > Yes, and ideally the code should not have warnings, right?
> >
> > +1
> >
> > > Otherwise how can we do better? It's quite similar to what you wrote WRT
> > > documenting the function prototypes, the same applies to the new contribution
> > > WRT `make W=1`.
> > >
> > > > if you would like to enable it for CI that is fine by me,
> > >
> > > Yes, that's the idea, but I'm not the owner of any U-Boot CIs,
> > > hence it's a proposal.
> > >
> > > > but the U-Boot makefile shouldn't do it. It defeats the purpose of
> > > > having a distinction between errors and warnings.
> > >
> > > While it's not what I wanted, I disagree on your comment. The idea is to make
> > > rules stricter (for new code) to make it better and that's why Linus enabled
> > > Werror by default in the Linux kernel. And personally I consider that as a good
> > > thing to follow.
> >
> > Long term experience: each time you upgrade your toolchain you get new
> > warnings.  Each package (u-boot, kernel, userland, does not matter
> > which) enabling -Werror breaks the BSP build.  What should a developer
> > do then?  Fix each warning in each foreign project and bring it
> > upstream?  Or disable -Werror?  Last thing is what is usually done.
> > You can see several patches in buildroot or ptxdist disabling -Werror
> > for this reason.
>
> That's why the set of enabled/disabled warnings are spread over W=<n> and hence
> hidden when known to be PITA. W=1 is kinda special in a sense that we put the
> warnings that might affect code generation, size of the binary, etc. In some cases
> it even might prevent security bugs.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
