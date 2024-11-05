Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2737ED2B921
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 13:10:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F2D988FE2;
	Tue,  5 Nov 2024 14:10:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZhQ20qNb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EF118919D; Tue,  5 Nov 2024 14:10:15 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DE9188E3F
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 14:10:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5cacb76e924so7304773a12.0
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 05:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730812213; x=1731417013; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vhhyr4Q5K11geRDdau59K/ybkE07tuqGq3StljJvLUM=;
 b=ZhQ20qNb+NmC950/tqR6jXg8PWRqLYJiYerjD7+VrsREnqdbXJi7Pdb4Pm34Mp7Df5
 ABtpAjMg4k27twibSjHAIecrWmymdfCdugr3i+95oLhKio3y9c37fJm1RyVB91lxzxuT
 vDQ2g37WuCZRP9G3Ffz2Q6JcdboG7I7uPVVjR9viD7S61dW6ZK0tdWg1wZ3sbUyLthFR
 aDjp6tsZa3tgKN8pI0TM71ulOb9wNGJ4pecrUffP/XCMSeYbgJXyFTKe3fXo/TRc2i0T
 0029Zwjrc4dBDmpORQt6pRRe4FQwNs9HiHwa4OGdQT+Y2m4wU6b5xqOYyC+MEa2p11rc
 CDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730812213; x=1731417013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vhhyr4Q5K11geRDdau59K/ybkE07tuqGq3StljJvLUM=;
 b=gorQO2ceSTWY7C0sfufqDybyv9Vi25goto2cXY1FfLZ/CVHmU+FIEqImhVS/p8rtsX
 iwU/IzNSdhTFq/nJ8iXoDJdWRdtTAOP1FUIxbBLL3KUIug7Cm3gYTYYOF4g26PFEthFa
 bFRkbhbJxxAUhvaOIpxyllPP+sQoMcwX+pijzBpZp51tI447VaaYVyimD1eSWdMSU2rh
 xfrPWajOBjK4qTGoqNJ+ZchTGcULxdgEJHKvC/3/E9G6PLYGfmUiCbUMwFaojJlSLz83
 OxNIb5dBbyOwG2Zvuv+QACSdT3ZPyYCdd86JdOlixS9ke23U0Hgx5GPZV2wUmRGvhNGL
 Du1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUkHFqpOphNIFvnF2E2H1spjFihSho6AvU/1CupUWOS33vSBdqxUpuzD1VlcmHoHg3QzU/lO0=@lists.denx.de
X-Gm-Message-State: AOJu0YxDbgGFiT+2crOZ+/tfcWRksvp7EE/CQYFJxK5Nk16z6xmgQLvN
 4reDZgzE68FqOnqsJXBZaShsBrq18+Avbmk/S7MNFBEpLKB12Yh3wIfnMnyq/KBw7X17BBxD2XC
 teKu3BZCGD/ZHJns+msEJWGPN20E=
X-Google-Smtp-Source: AGHT+IFeVhIVA+sE8ZYFtuVOpMqelBZAG4qIwnJFpXMuQvPKSO71SmevPP28IBsxxFY/nFVQebtH50iHC7Bnz7f0vbI=
X-Received: by 2002:a50:ee98:0:b0:5ce:c8ee:7e41 with SMTP id
 4fb4d7f45d1cf-5cec8ee80a3mr7296666a12.22.1730812212538; Tue, 05 Nov 2024
 05:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
 <20241104233227.GA3600562@bill-the-cat>
 <CAFLszThXiK=EzrUStsOBiSQ_pe1-Vdwtg-238BjQd91SMBym7A@mail.gmail.com>
In-Reply-To: <CAFLszThXiK=EzrUStsOBiSQ_pe1-Vdwtg-238BjQd91SMBym7A@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 5 Nov 2024 13:10:00 +0000
Message-ID: <CALeDE9M1PDFmm-oZvSEGwBaN_J77CSKUa8kbkEPQf9XATv8STg@mail.gmail.com>
Subject: Re: [PATCH v12 00/13] net: tcp: improve tcp support in legacy stack
To: Simon Glass <sjg@chromium.org>
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

On Tue, 5 Nov 2024 at 13:03, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> On Mon, 4 Nov 2024 at 16:32, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 28, 2024 at 05:31:30PM +0300, Mikhail Kshevetskiy wrote:
> >
> > > Legacy TCP stack is bad. Here are some of the known issues:
> > >  * tcp packet from other connection can break a current one
> > >  * tcp send sequence always starts from zero
> > >  * bad tcp options processing
> > >  * strange assumptions on packet size for selective acknowledge
> > >  * tcp interface assumes one of the two scenarios:
> > >      - data downloading from remote host to a board
> > >      - request-response exchange with a small packets
> > >    so it's not possible to upload large amount of data from the
> > >    board to remote host.
> > >  * wget test generate bad tcp stream, test should fail but it passes instead
> > >
> > > This series of patches fixes all of the above issues.
> >
> > I know Peter asked on the last one, but I want to ask as well. With lwIP
> > merged, why do we want to add features to the old stack? I can see
> > fixing issues, but not adding new functionality as well. Thanks.
> >
>
> Let's apply this. It has tests and the old stack is still used by a
> lot of boards. At present lwip is only used on one. There is more work
> to do on the new stack, including finishing off the sandbox
> implementation.

I agree with applying the fixes pieces, I do not agree with apply the
HTTP server pieces. This series should actually be split into 3
