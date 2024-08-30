Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7489FCA0FFA
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 14:19:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89AA9888FD;
	Fri, 30 Aug 2024 16:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l2yqUyEA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C961688C09; Fri, 30 Aug 2024 16:19:00 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 757F0886E5
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 16:18:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6bf999ac52bso9636786d6.2
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 07:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725027537; x=1725632337; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=szdLqCrUcceDhl1fqxKITOzIYJA70PcGlCJ4fwWPX2w=;
 b=l2yqUyEA/lkA1xN1bpQr5WLUgWYj8Ih3ksbGUVpNnLDXZD+ovq1zAKocyntMKY/IV7
 eLk7QhhbNI8sS8yyRCWuyvAH/aLRgNVQiOVknvcwG42NlALfdTKJKpXwQPo6z4ROl0aW
 EJyWArcKRdHhgzxnYGQp2K3e5uaDc202pDYLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725027537; x=1725632337;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=szdLqCrUcceDhl1fqxKITOzIYJA70PcGlCJ4fwWPX2w=;
 b=goKUJu53aKHBllQztBVmXDRFiJMKkhVKRiQ8hJnTobjnclG6MREI8gfleyHUqXSAkI
 h+nHMI9LOCELjYVceceK3ZLzK0t27q+sX3UPDpRBaY3uULuzE7eb1oX4n6JWhUOfmALV
 I8aU9bg742aDw7ydXhseK6gwYOtiJsoxm8ToTm+bJ0crUKLWq/9oc57hk3RBuBbJP75E
 vxa9IXssHjKLR7lhgiinI6bHLysnFnmjRxuetI5goC8ls7V2glfr/AHGtJe7iZWCsAIc
 TAYFiJd1rbBm+h1JswI/yuWj+TaJF7iWv/qsVwlkL0aInrxXUMSrgtX/o7sG7soMkSxX
 jgAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmQJ1RYXZ2vp27C3IX3nI2bPG3AjjjWLnSrdi7kuLU4AIG9h6/91h4IHDhY/3giF5EZO49TtM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0Rj/yE8KpBwjUwIdTFS+MD/ssfw6Oy5VvMn9z3fCzD1AAzwg3
 lIVIJkhleLJRcXdrKPwVJCKIN4Nm2aQB4CWD1QjcxWcmklPiijsvS8h2KHk7yOCXsrvcVOPWyDK
 ryTF+dy9vafHSxxwolTAuE77HhtHPcZhQLoPk
X-Google-Smtp-Source: AGHT+IGGcWHWKKEpiamW7W2qToPL0w7otMbXVW9QYBl/rFrlfPfCYhF1jsvQjsJJc/vxEkT9aPgD4E3zLxXL18RVbio=
X-Received: by 2002:a05:6214:5888:b0:6b5:65ab:e860 with SMTP id
 6a1803df08f44-6c33e6170cbmr74162386d6.20.1725027537339; Fri, 30 Aug 2024
 07:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724846454.git.jerome.forissier@linaro.org>
 <1a6084e845a0612546a1e86d142208af945c8f77.1724846454.git.jerome.forissier@linaro.org>
 <CAC_iWjL9g0c8UHF3L44b8HEG-2=d57XsDXPpSogthWDPgzPcaw@mail.gmail.com>
 <CAFLszTjLmgXO-31CwAOv1qQ9x0aDk4aHGVkScDF1bz-WhfrHGw@mail.gmail.com>
In-Reply-To: <CAFLszTjLmgXO-31CwAOv1qQ9x0aDk4aHGVkScDF1bz-WhfrHGw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 30 Aug 2024 08:18:46 -0600
Message-ID: <CAFLszTgQNatTrhY_PVwN96tbuRvS=PRqawhH93+1TM9y_Mg79Q@mail.gmail.com>
Subject: Re: [PATCH 09/13] net: wget: allow EFI boot
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Peter Robinson <pbrobinson@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, Marek Vasut <marex@denx.de>
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

Hi Jerome,

On Thu, 29 Aug 2024 at 08:04, Simon Glass <sjg@chromium.org> wrote:
>
> On Thu, 29 Aug 2024 at 01:34, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Wed, 28 Aug 2024 at 15:10, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> > >
> > > wget followed by bootefi currently fails as follows:
> > >
> > >  U-Boot> wget 200000 192.168.0.30:helloworld.efi
> > >  Waiting for Ethernet connection... done.
> > >  HTTP/1.0 200 OK
> > >  Packets received 13, Transfer Successful
> > >  Bytes transferred = 12720 (31b0 hex)
> > >  U-Boot> bootefi 200000
> > >  No UEFI binary known at 200000
> > >  U-Boot>
> > >
> > > Fix the problem by adding the missing efi_set_bootdev() call.
> > >
> > > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > > ---
> > >  net/wget.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
>
> OMG the hack never dies. I hope I will someday create a series to tidy this up.

I'm sorry for that remark, not helpful to collaboration.

Regards,
Simon
