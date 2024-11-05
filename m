Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA65D2C11B
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 15:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58649891C7;
	Tue,  5 Nov 2024 16:15:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DMgxfQZz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D3198913F; Tue,  5 Nov 2024 16:15:40 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E815F891DB
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 16:15:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9a4031f69fso893406466b.0
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 07:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730819737; x=1731424537; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iW7xuPsduWrSp2H+a+4XC7l0hmcaqMwYXhG5gAvku5I=;
 b=DMgxfQZzunVFazaB76qP08OWOgVyeQkDhfGkvQwnEJhTLWevJPylA1YYhDNVLjEWYP
 Q3qZgnGIDTF4itUYxw1TqdxfuJ6+hCDa6RxFVCMiwV5P7KL3ci53DZBj/F+gb0yNCXSL
 LWFX+jm4lya6QpSPXMz6io7S/1mTDV5Tqvau8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730819737; x=1731424537;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iW7xuPsduWrSp2H+a+4XC7l0hmcaqMwYXhG5gAvku5I=;
 b=I8UwvxvAnR8no+hNMtyw/iPh12xVF7FBDDnWjfREVVXUvzrOrWlq6H6rSKS1TrhHmL
 jcQ+99PMOqzQAo9IjCHWGNWdq892bIIt2jiDgkPOPj+rtWUNTuAYvNTPTWcW0ogFw+vu
 rydCBXTuO0lpsqTvPwZajNU7e96DPrVXdb4x91bVeORseMBphTTeu//Io/1OhqlIWK2X
 yhkkmb/nazCFtLzfk5AyEB9q9DiTy7wsbWSTcvnPfWPWMM6IIfth2BR7KpsWhqrM4bcb
 eZGuPK0VAn8MBzbOvpV83WXJFpmrXkswNQoOS8I02ySpUD3a5ebVHQpuXV4coElpNhib
 fziQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzbN9hEqknlcPj+jRjrBbzI4lrWnxXNBs4gdAlQjrJjSVuVYuncbJ9kefVpQC7j8qGC4ZYrlw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy40W3RwR6qeGhxxhHauvswi7cgwPQSg9biHAF1iJQ/YkZjrjGq
 TtTGsiOWLsKoQ85nNJpdb/SudQSN8TtML8N8Rws483uVB1Pgfq6UDoLer9wQVfF4Hhf7g6ZPavS
 rW0nE6I0Urpe8fwAQInJXz91MPx8OekQ2A5bX
X-Google-Smtp-Source: AGHT+IFHctGLFhbMEKeg+yIlNQ03+MvSvS/IhGXxaSLWChl+OI9J9EDtZFtMBAve41YCNvi64eCyquH0loyLcXZFgPo=
X-Received: by 2002:a17:906:da89:b0:a99:43b2:417e with SMTP id
 a640c23a62f3a-a9de61a2e85mr3506590366b.62.1730819737328; Tue, 05 Nov 2024
 07:15:37 -0800 (PST)
MIME-Version: 1.0
References: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
 <20241104233227.GA3600562@bill-the-cat>
 <CAFLszThXiK=EzrUStsOBiSQ_pe1-Vdwtg-238BjQd91SMBym7A@mail.gmail.com>
 <CALeDE9M1PDFmm-oZvSEGwBaN_J77CSKUa8kbkEPQf9XATv8STg@mail.gmail.com>
In-Reply-To: <CALeDE9M1PDFmm-oZvSEGwBaN_J77CSKUa8kbkEPQf9XATv8STg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Nov 2024 08:15:25 -0700
Message-ID: <CAFLszTjs-7uWNWdaZjhQe-rA5z0qSZxiFeX+WgFofYemW6qiwg@mail.gmail.com>
Subject: Re: [PATCH v12 00/13] net: tcp: improve tcp support in legacy stack
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Anand Moon <linux.amoon@gmail.com>, Baruch Siach <baruch@tkos.co.il>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
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

Hi Peter,

On Tue, 5 Nov 2024 at 06:10, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Tue, 5 Nov 2024 at 13:03, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Tom,
> >
> > On Mon, 4 Nov 2024 at 16:32, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Oct 28, 2024 at 05:31:30PM +0300, Mikhail Kshevetskiy wrote:
> > >
> > > > Legacy TCP stack is bad. Here are some of the known issues:
> > > >  * tcp packet from other connection can break a current one
> > > >  * tcp send sequence always starts from zero
> > > >  * bad tcp options processing
> > > >  * strange assumptions on packet size for selective acknowledge
> > > >  * tcp interface assumes one of the two scenarios:
> > > >      - data downloading from remote host to a board
> > > >      - request-response exchange with a small packets
> > > >    so it's not possible to upload large amount of data from the
> > > >    board to remote host.
> > > >  * wget test generate bad tcp stream, test should fail but it passes instead
> > > >
> > > > This series of patches fixes all of the above issues.
> > >
> > > I know Peter asked on the last one, but I want to ask as well. With lwIP
> > > merged, why do we want to add features to the old stack? I can see
> > > fixing issues, but not adding new functionality as well. Thanks.
> > >
> >
> > Let's apply this. It has tests and the old stack is still used by a
> > lot of boards. At present lwip is only used on one. There is more work
> > to do on the new stack, including finishing off the sandbox
> > implementation.
>
> I agree with applying the fixes pieces, I do not agree with apply the
> HTTP server pieces. This series should actually be split into 3

But what is your objection?

I would much rather just apply it ASAP. It has already gone through 12
versions, during which lwip has been prepared and applied.

The HTTP server is a useful feature and we should be able to use it to
test networking in U-Boot in a more self-contained and performant
manner.

Regards,
SImon
