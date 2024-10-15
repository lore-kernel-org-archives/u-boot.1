Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C6CD1D879
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 15:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BAB3889CA;
	Tue, 15 Oct 2024 17:28:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gevB8fRl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2255F88AC2; Tue, 15 Oct 2024 17:28:18 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13F75889AA
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 17:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cbce9e4598so36737666d6.2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 08:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729006095; x=1729610895; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GW1tGj45ZlvKoLj8ls4DXSL7mKxgXXr2hdZohEsb1Fk=;
 b=gevB8fRlK/ov2qjwfU8tJWIFoJu2bxs08N+OR2P/ZAIt11gGdWSJHBrqf0KLzYLfWf
 J9GuRfOtEIJcFQkiSDD83PuuzdHyv9Ra6fZsO1QnIFIreSENWuUQSPQoG9J6IJKgfvYC
 rJWCUeoj0El7vxrMBXVHIxUOKn1sK8v/PZnH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729006095; x=1729610895;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GW1tGj45ZlvKoLj8ls4DXSL7mKxgXXr2hdZohEsb1Fk=;
 b=M7L7Uq5qYIqpBxnkYSIisuNPm201dFJIQ4OLVMlaU8foQHr2JP/UoSik5/aXi9LV4c
 qYuW9RaEowQPwMN4pxc0m5HA/jL/by5WUW6ZjOBrpKuOaQVUgKIhtrwcieh6SRpLOaBG
 IAVZn4Igp942TiDrDVQUE8Fk3YfVe+3zw1cLCpasm3Z7fpzDXKAKiZWT9BwmiVJkh/fn
 nolja+Ku6SSY4BEcdg4RHKZ1E4rgVus7T9RavOhYqHHJuIQPGkmr1Nyg6/EOIb+NJOkR
 XvFFmkW9fCrKiDpgYgdjUE5dsCx7EMg5T0KktL2pvfv5iKk2uJY6pSwzA55jjnceVZqu
 w3ow==
X-Gm-Message-State: AOJu0Yzbadrr/gdDKYT9oo5nusL/MtnMu5gywMLgke0Ws8HvYqrEbx08
 C8YRUn3onHwV6hN2YY1UmCFBKeTsBohmTLzTMJWLRYRYskOg/VKb5GvAaaIpbZ1CVrH+23mcJYO
 MylZtj4EktQ8Rq5Ug12fiuLX1z0fX5PfQIksT
X-Google-Smtp-Source: AGHT+IFKRN1qneetaAgM7pBQHzS3Era5xDtl6vKREZOgy1COVT1bU/Qi3j7Zk7sQB8N8tOD1FMPvC2qUk6unQkoQgBc=
X-Received: by 2002:a05:6214:3381:b0:6cb:f039:85a0 with SMTP id
 6a1803df08f44-6cbf9e9f2edmr160782446d6.40.1729006093502; Tue, 15 Oct 2024
 08:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20241015133304.2874735-1-sjg@chromium.org>
 <20241015133304.2874735-3-sjg@chromium.org>
 <CAC_iWjL5+LN4ReAo7LNhRrC1==V8ciCd4M73kUXktV7ufQEhng@mail.gmail.com>
In-Reply-To: <CAC_iWjL5+LN4ReAo7LNhRrC1==V8ciCd4M73kUXktV7ufQEhng@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 15 Oct 2024 09:28:02 -0600
Message-ID: <CAFLszTibyH0jEbZ-G6VifrcmpXmxNq00TnZM3cEAxWpQGQpBZQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] common: Tidy up how malloc() is inited
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Artur Rojek <artur@conclusive.pl>, 
 Christian Marangi <ansuelsmth@gmail.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Eugene Uriev <eugeneuriev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Richard Weinberger <richard@nod.at>, Sean Anderson <seanga2@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Ilias,

On Tue, 15 Oct 2024 at 07:38, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> I did review enough of this series in v1 [0]. Please resend it with
> the proper tags added. Did anything change and you dropped by r-b?
> Because the changelog says no changes

I collect tags with patman...it still doesn't see anything. Which
patch are you referring to?

>
> On Tue, 15 Oct 2024 at 16:33, Simon Glass <sjg@chromium.org> wrote:
> >
> > The call to malloc() is a bit strange. The naming of the arguments
> > suggests that an address is passed, but in fact it is a pointer, at
> > least in the board_init_r() function and SPL equivalent.
> >
> > Update it to work as described. Add a function comment as well.
> >
> > Note that this does adjustment does not extend into the malloc()
> > implementation itself, apart from changing mem_malloc_init(), since
> > there are lots of casts and pointers and integers are used
> > interchangeably.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> > ---
> >
> > (no changes since v1)
> >
> >  common/board_r.c  | 3 +--
> >  common/dlmalloc.c | 8 +++++---
> >  common/spl/spl.c  | 4 +---
> >  include/malloc.h  | 8 ++++++++
> >  4 files changed, 15 insertions(+), 8 deletions(-)

Regards,
Simon
