Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46661C54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 18:52:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1450F87D26;
	Thu,  7 Mar 2024 19:52:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OO2lK3g+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BC2487D69; Thu,  7 Mar 2024 19:52:34 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E72A87CFF
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 19:52:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33d855caf7dso304941f8f.0
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 10:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709837551; x=1710442351; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pJQo+OrSw8KKzHmTbP7Nu0TkCM4KqAWV35qdvN3NSl8=;
 b=OO2lK3g+epXPZoEfbNvsvY4HuYTT4U0MbBsrYNJosRFcBW18dS8lnMofVCzggNzQkD
 a03fXus0wxWZF0S0GhZg75r0BSoz5f9k5pMAh++JGwDYVxsbSmLwwS7r8VUeQhHXgl6P
 mHAFO3fu9UUs4Aj2i0DeBeJZi3SiB2KOE4AYMpo5RqpEytu3mpU6IZLF9otlTYCrTBcq
 ITqNLoWpUIMOVwnjXsIyPZHAB+xdtugC5ryXEkxcB6kzAXU99PARH1L3t0WXyyk9x25K
 ahuwvMvbtqncp0uLekRQ/anOr4QdO+Hvw4xs/NR5rryHTljHX7D2c5NqAOr01AO+0NId
 hEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709837551; x=1710442351;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pJQo+OrSw8KKzHmTbP7Nu0TkCM4KqAWV35qdvN3NSl8=;
 b=MZE6FqEZmjEjXNgwFpJKH4ANeNF7XL/lEyGA6IWwmz8bq4nWzav7ZOaAIQ8xGQ4uaU
 oVyoQjkNuBeHfx5FVXRWdKgXflsFFYnjqu4CiTMR6yh1MUNUbiP7u95omQ7krT5wDBCe
 nZ8NWPizBP/bnUHz9jO6E9dMvbOQDCTcxIUNMKQeXMGHKQ35FSdMpWbypR6uSLmWf0AM
 w4xz/zNG/680hDjgMW/3fz79BsiDSNbjv/qpcC0wc1TM8kz1GRyBCxtOllNpLl7jqQSp
 l390pmXi3VHO1A3sRuooRM0RLJU/ulMbs9faExmCIJO0WalHMuIQKj/0kfgweNt26Big
 gS/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDpPjX2P2MkcDHUKxEwmirjg+5X6hpvlTZ7Dl2h1Y+RWybi+26ctYsZD7bBy0X8RKyjRMntSA8JEBQc0+m3VmY2C6aMw==
X-Gm-Message-State: AOJu0YxbOjoxbfurz4OazxIRcUJDGliIFaT/+wqcMB9hGPPLvNC4y3D/
 eEqRhlgNQGrqzo0Zic5GEBA+WSWsklS6bF8oUKzGaromEIEgQttEi7aSPTYKiu9UqO/h1xIOJ0c
 NunOPq3P9lb4x8H6LtgtUFZyLFi0=
X-Google-Smtp-Source: AGHT+IFmaYph6MrXkx2QKxiIwLf+9JcyYodKA+PbGdbkt7wu7nTcIR9ZpyiLq2vERz6a9FPLUzn8lJHeLLK50IBTQag=
X-Received: by 2002:a05:600c:444c:b0:412:eee0:a5e4 with SMTP id
 v12-20020a05600c444c00b00412eee0a5e4mr2112562wmn.1.1709837551079; Thu, 07 Mar
 2024 10:52:31 -0800 (PST)
MIME-Version: 1.0
References: <CAF1iuRr6q15aApGB8zPb8M7yWrUahT8H0BjDHnWRp1_Q__KDng@mail.gmail.com>
 <CALeDE9MSQwGU0JXs96egk8y8rc=f+JxtNm3U6u4Fxb8L+jWtkg@mail.gmail.com>
 <CAF1iuRqyTu5xO9JJ-8__w8y7_uQ5SHNd6wunP1sND7QiT7K60A@mail.gmail.com>
 <a7a99523-3e8d-4fde-adf4-3cb6fdc2e94c@moroto.mountain>
 <CAF1iuRoByWEgvOxgSZTi7g+djksK81c2FwoQc-Wy9DDgSmd9dQ@mail.gmail.com>
In-Reply-To: <CAF1iuRoByWEgvOxgSZTi7g+djksK81c2FwoQc-Wy9DDgSmd9dQ@mail.gmail.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Thu, 7 Mar 2024 19:52:19 +0100
Message-ID: <CAByghJZVnnfP11o9=d2RX438Gv3CzKC4hWVr5qi=wRxV-WYdPA@mail.gmail.com>
Subject: Re: ECDSA related PRs
To: Bob Wolff <bob.wolff68@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Bob,

On Thu, Mar 7, 2024 at 12:49=E2=80=AFAM Bob Wolff <bob.wolff68@gmail.com> w=
rote:

> Hey all,
> I'm not opposed to using the kernel ecdsa.c and have taken a quick look a=
t
> `ecdsa_verify()` - but I'd love if someone could point me in the right
> direction for how to set up the context and public key. The
> akcipher_request structure seems to address both the signature and the
> digest, but I am not seeing how to take my public key data and get it
> involved. Any examples of usage, possibly? Doing several google searches
> did not bear fruit for me.
>
> Thanks,
> bob
>
I'd start with the image_sign_info/image_region structs definitions in [1]
and examples of how they are both filled in RSA signature verification
tests in [2],
as ecdsa_verify() also uses them.

Then I would extend the existing ECDSA dummy test in [3] by adding some tes=
t
public key data in DER format, data and encrypted hash of this data, like
it's done
in [2], so you have the way to test your own UCLASS_ECDSA driver
implementation.

And obviously the existing ST UCLASS_ECDSA driver might be a good reference
[4].

Hope this helps!

[1] include/image.h
[2] test/lib/rsa.c
[3] test/dm/ecdsa.c
[4] arch/arm/mach-stm32mp/ecdsa_romapi.c

>
> On Wed, Feb 28, 2024 at 10:57=E2=80=AFPM Dan Carpenter <dan.carpenter@lin=
aro.org>
> wrote:
>
> > On Thu, Feb 22, 2024 at 03:07:01PM -0800, Bob Wolff wrote:
> > > Peter,
> > > Thanks for helping lead me down the right path here.
> > >
> > > WRT tinycrypt, the license is quite permissive.
> > > https://github.com/intel/tinycrypt
> > >
> > > Also, I'd like your advice - I was thinking for the larger patch that
> I'd
> > > do it in two commits. The first would be the addition of the tinycryp=
t
> > > files and the second is the actual changes and additions to support
> ecdsa
> > > verification. I doubt that's controversial. However when I run a tria=
l
> > > `patman` against the tinycrypt commit, I geta huge number of issues:
> > >     *checkpatch.pl <http://checkpatch.pl> found 186 error(s), 380
> > > warning(s), 481 checks(s)*
> > >
> > > What's your advice on this? I would tend to think we'd want to /not/
> > change
> > > the source files directly for such purposes so that updates could be
> > > brought in with greater ease.
> >
> > Yeah.  For this kind of thing you wouldn't want to make a bunch of
> > checkpatch changes.  They sometimes pull crypto and compression
> > libraries into the Linux kernel pretty much unmodified as well for the
> > same reason.
> >
> > Igor's proposal about pull this stuff from the Linux kernel instead
> > seems like a good idea though.
> >
> > regards,
> > dan carpenter
> >
> >
>


--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
http://ua.linkedin.com/in/iopaniuk
