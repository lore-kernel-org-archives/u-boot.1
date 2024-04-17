Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15B2C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 00:03:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1051D87ED1;
	Wed, 17 Apr 2024 02:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JusA1S3z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB22187572; Wed, 17 Apr 2024 02:03:49 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B5DB8842B
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 02:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5d42e7ab8a9so2640426a12.3
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 17:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713312225; x=1713917025; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ozXtCMF/m0+kFuzsAp6FekB+/bTnVGP0t9ZpMVFnnU4=;
 b=JusA1S3za1m0avKEO2YP9frrR4lH6qJl2reu3LKMtZG1myPeDXBki0GxvNVwdtfMX3
 0MZ8R3+yVmNNUHjwDtDgmuCWIk74znSna2GaWhPwN05fXpSu/KRepUwGFFB9c4z7NHES
 6+BUA+s8/8hSTxIzhDbz0AX7nMyOnz+9KNXnB2G0kiJYlcC7QiL2i6lRgv/G1fNqPwJP
 dirDPmor5MFR8gOgJIWcqwQlJLEkvNM6h59laj0xErntLQSexL6frPVtniGeMDI+sbZV
 51Awd0zxRlPmM4UHeWibHgyPhoGno9wzaDMnsxnZLs+BbUXwIKr5m9qc3qS3JIdy5I8T
 Upxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713312225; x=1713917025;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ozXtCMF/m0+kFuzsAp6FekB+/bTnVGP0t9ZpMVFnnU4=;
 b=h3ZdIIyoNVzg8iUA/B1JWKQ+5+qVTnGJUi3a311Pm1BdZ5jHiFCsZQBu/oJ8BwEaiX
 QJDt5b/J7UUH0Rp3BH2Cvhf3iYZoLfMZQaP5t5GtT4dwpsRE3tSK3is69rs4fGqInhDK
 5zSH6ddMX5eXTCZGxP1iag/rC76h8f2yR8oyoY6WcsA9T068H+if1f050qdJcOigaV0c
 ryRClY4K8462Ie9cCuIpHBpaNUh2VzeyI9i5ixZrGST7SCKhnPw7RFrwS0FJBr4mcwiv
 oi++x+S4AA0RjPsyLrIzI1j32xOstVYGKxs6Y65DsE2Xe5PG0XQG4t6cvfIVEvi/6uEE
 6hJg==
X-Gm-Message-State: AOJu0Yyw25XnjeD/ZLLysnSbeWtNq9cZ77GO57pQFMwxHBdsLIxt4RwP
 UTPAVt30GchO5T0e8Q8ooXh7e/WtfofcvwzYLr8iBMDpzCHypXtxJ0W/gQeP8PdHoyMGf9n5Yx8
 ZSitYyW02eLGGwuo+Z6BxgUJXKEAhPfSHe0re8w==
X-Google-Smtp-Source: AGHT+IFCni6qSfKJ8zqyEM9cvYqlclJ9LKG5Qm/x++L++Rhk2S0sUETjQNYJrzap63L3c3zLxhcT17zaf6Hi8fJRofo=
X-Received: by 2002:a17:90a:ec18:b0:2a4:ca45:ded1 with SMTP id
 l24-20020a17090aec1800b002a4ca45ded1mr11591287pjy.28.1713312225536; Tue, 16
 Apr 2024 17:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240416190019.81016-1-raymond.mao@linaro.org>
 <20240416230133.GZ1054907@bill-the-cat>
 <CAEfUkUKFG4pVR3nHw-GM1Ub2SShnSDgA+zhwTNHY+pSkuaHvXg@mail.gmail.com>
 <20240416235020.GB1054907@bill-the-cat>
In-Reply-To: <20240416235020.GB1054907@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 16 Apr 2024 20:03:34 -0400
Message-ID: <CAEfUkU+PJN6e1JEcnpkYZtBraw6KUxr9Dq2v08EDCk9O3STkdw@mail.gmail.com>
Subject: Re: [PATCH 00/23] [RFC] Integrate MbedTLS v3.6 LTS with U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Tue, 16 Apr 2024 at 19:50, Tom Rini <trini@konsulko.com> wrote:

> On Tue, Apr 16, 2024 at 07:47:44PM -0400, Raymond Mao wrote:
> > Hi Tom,
> >
> > On Tue, 16 Apr 2024 at 19:12, Tom Rini <trini@konsulko.com> wrote:
> >
> > > On Tue, Apr 16, 2024 at 11:59:56AM -0700, Raymond Mao wrote:
> > >
> > > [snip]
> > > > [1]: bloat-o-meter output between disabling/enabling MbedTLS
> > > > ```
> > > > add/remove: 231/69 grow/shrink: 12/5 up/down: 60196/-11166 (49030)
> > >
> > > I don't know if this is qemu_arm64 or sandbox.  With buildman's size
> > > comparison functions we see:
> > >             qemu_arm64     : all +75537 bss -88 data +24 rodata +6349
> text
> > > +69252
> > >                u-boot: add: 274/-12, grow: 12/-4 bytes: 72002/-3800
> (68202)
> > > ...
> > >             sandbox        : all +57008 bss +32 data +1632 rodata +352
> > > text +54992
> > >                u-boot: add: 143/-75, grow: 21/-18 bytes: 64058/-16523
> > > (47535)
> > >
> > > So please look in to using buildman to get more details about what's
> > > changing, size-wise. Also, my goodness, that's far too much growth, and
> > > we aren't removing anything? This needs to be a whole switch, not just
> > > an addition. And then look in to what we can tweak / remove. Are we
> > > perhaps not getting our usual link time garbage collection done?
> > >
> > As stated in the cover letter, with this patch set, we still build the
> > original libs
> > (lib/rsa, lib/asn1_decoder.c, lib/crypto/rsa_helper.c, lib/md5.c,
> > lib/sha1.c,
> > lib/sha256.c, lib/sha512.c) for the components outside of EFI loader.
> > Eventually all these will be completely switched and removed.
> > But I think we should do this in a sparated patch set - It is too big for
> > one
> > patch set.
> > So, as the first patch set, this one will introduce MbedTLS and enable it
> > with
> > EFI loader, after they are merged, the next patch set will switch other
> > components
> > to use MbedTLS and remove the original libs.
> > What are your thoughts?
>
> My thoughts are that we need to implement this as the optional
> replacement for the existing libraries. We already have abstractions for
> most if not all of the algorithms I believe. And we need to be able to
> see how much size growth we get from this change because long term we
> don't really want to have two sets of libraries for this functionality
> (as a SW rather than HW implementation).
>
> I see. With this version most of the lib/crypto that are used by EFI loader
(pkcs7, x509, public_key, mscode_parser, etc) are sharing the same
abstractions except the ones for hash.
I can replace them in v2, so that we can compare the final growth by
switching
on/off the MbedTLS build options.

Thanks and regards,
Raymond
