Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296DBCFC5F4
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 18:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 684E089274;
	Thu, 10 Oct 2024 20:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J1e32t9C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAA8F8926D; Thu, 10 Oct 2024 20:50:32 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7924E890FD
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 20:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cbd12b38b4so9894966d6.2
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 11:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728586229; x=1729191029; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PggSi8AkeuYnIMeecZMXD6WTmqVA3cLnw7lSdPjxHWA=;
 b=J1e32t9CWIZpsrQJKWLPNLWmbUZ1QQ5Ux8HoLtLRh+CEELTdEba7hlCdljxSwyw1j5
 Ll2u4U4ZqXa0ThGP1odaXCUtNYfyTVOWEfdPOMcXHcV0aggIAcR03G3rGmipoghoPoTr
 ZPpcI7rnQro8sa8VyryVaji379FdrL4cARgtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728586229; x=1729191029;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PggSi8AkeuYnIMeecZMXD6WTmqVA3cLnw7lSdPjxHWA=;
 b=Q1Kf79LP8jC/1TGvVgYj7K8LLHyQtqzd/LMKgbxVxOY3KQJLX2ynZtmrtAxEK1VfoF
 QW3GHFiVZgs+ACA4IxHdYJsnSbQbvP4gWdYvbRAsUP1MDwsFzU+IAJ7ymTgLiM8Jwbqc
 GfhPSU+ildyK5k+xuM491lo5Q6tD2sl8iS8vVvRo2dDh9EQXRK96h2MjO2ccxJwgNIEl
 4ugJJ2nzRRISsTORv9J5kFjjK/QR3eQfHJZi2G7yN9rmNGdOWvtEXvPW4nHvFe2gtLNs
 vnTYeeM7Xr7pcBaB+vs/dtzeYR8i/0opk8VcC+ZKhQS7cufxTpwkt8lZVjy88nHP+/z9
 1mzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJulkGTi9AFAddhsicMJv2n31PuNXjc8w7xT4WbiDf/mtGKOoKQmvP2xA6KXfHgDSw/wewmm8=@lists.denx.de
X-Gm-Message-State: AOJu0YzhBnKl/EH6J4KSqH2qzaJo6OZ2drrcIxwPeoGSX6rZgKymTXrA
 J/MeP1xjnuR5P3EEqyblCWsxM9gxvPvx56/Zzo1f0a0T2LfYWtYNCXJedsY93OH/VgmZ0dj8ard
 o9sS9P5Jv6qT9e1sIRvXLc7/FJ0Yew1saeM3S0wAx1h04/5I=
X-Google-Smtp-Source: AGHT+IEwO6kRacHhVSuHyrDp2Z3RZd2s97C42fp58PmufPy3UCDsp6dObXTYgjVQQjrfqR4aPC89T+jr+LoK1JahEAU=
X-Received: by 2002:a05:6214:5a01:b0:6cb:9bcc:80cf with SMTP id
 6a1803df08f44-6cbeff3a30dmr700696d6.5.1728586229339; Thu, 10 Oct 2024
 11:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240104132817.278079-1-bmeng@tinylab.org>
 <20240106174108.GY1610741@bill-the-cat>
In-Reply-To: <20240106174108.GY1610741@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 10 Oct 2024 12:50:18 -0600
Message-ID: <CAFLszTiHj8yUuABQsHyAME6V2mdgM5SqocOBAdGksy+B0O9E3A@mail.gmail.com>
Subject: Re: [PATCH] tools: docker: Drop the git user name and email
 configuration
To: Tom Rini <trini@konsulko.com>
Cc: Bin Meng <bmeng@tinylab.org>, u-boot@lists.denx.de
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

Hi Tom,

On Sat, 6 Jan 2024 at 10:41, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jan 04, 2024 at 09:28:17PM +0800, Bin Meng wrote:
>
> > Since commit b45ab9ca6621 ("CI: Update to QEMU 8.0.3"), the manual
> > patch applying was removed, hence there is no need to do a git user
> > name and email configuration.
> >
> > Signed-off-by: Bin Meng <bmeng@tinylab.org>
> >
> > ---
> >
> >  tools/docker/Dockerfile | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> > index c4a2596b48..c12ed0fd9b 100644
> > --- a/tools/docker/Dockerfile
> > +++ b/tools/docker/Dockerfile
> > @@ -179,9 +179,6 @@ RUN git clone git://git.savannah.gnu.org/grub.git /=
tmp/grub && \
> >  RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
> >       cd /tmp/qemu && \
> >       git checkout v8.0.3 && \
> > -     # config user.name and user.email to make 'git am' happy
> > -     git config user.name u-boot && \
> > -     git config user.email u-boot@denx.de && \
> >       ./configure --prefix=3D/opt/qemu --target-list=3D"aarch64-softmmu=
,arm-softmmu,i386-softmmu,m68k-softmmu,mips-softmmu,mips64-softmmu,mips64el=
-softmmu,mipsel-softmmu,ppc-softmmu,riscv32-softmmu,riscv64-softmmu,sh4-sof=
tmmu,x86_64-softmmu,xtensa-softmmu" && \
> >       make -j$(nproc) all install && \
> >       rm -rf /tmp/qemu
>
> I'll apply this next time I update / respin the images but I hadn't
> dropped this part just to make the next time we do need to backport a
> patch easier.

I just found this comment, but it looks like the code is still there?

Regards,
Simon
