Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C443CA0FF0
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 23:48:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C92D83189;
	Wed, 27 Aug 2025 01:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ah1JVGHC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E962783192; Wed, 27 Aug 2025 01:48:09 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0415883145
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 01:48:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-afcb78ead12so863130666b.1
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 16:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756252087; x=1756856887; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iSSqXg4dg/KEnkJ/sMTEcj193pd7sXJap3bDFnABy+A=;
 b=ah1JVGHCbZ6YRWByuuo1ruEIPUBm3UINKIRzoCRrdCwCAC0cDnk+gP1jJFpxOSsg1y
 IwXK2LbULuWwytwqNRfcWtLnga5lzjxL/OImXQPyKl+SRwUn/iHEI+d62czifoJOVum4
 +BsYtARlLtetkk3wq1stsLU/kO3v2p+zWxMDXVYXvKKtN61yVADZp+OEFAiyysfe4AON
 K1RHbfJAbTTjU7zpTNNDoJrScaqUsdli72H9bb8u+KmJCfC3BV6AXpQpcOD7rsAuUo74
 KiSw7mCLrmSn2P0IkWuw1/89EQrSR+Ed11h99Xx+qz9S5eTWInu9/sTqOf5oXCjdAWxm
 V4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756252087; x=1756856887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iSSqXg4dg/KEnkJ/sMTEcj193pd7sXJap3bDFnABy+A=;
 b=bG5BtsTO+Y+ylXlFd0K1xMi3PyK2vm/XcGH8bzQR69CQnBawLl98/eh5kIC3A5U1XZ
 FtZ6LPdhApK0rIV5WGMlnPXIz9qI0+9zZIzmltiHhwrnjDnapVtAtGvT6vI2SZHSB7WA
 mFhrp1WPmCJ/jQBZcwRzSn3NiysYGhmYt0QN1A/jcreAp6/E31LTMSPtkvXFvLcv44co
 XRsHKS5K3LIcTA2CGPKbi23T8w63bf8jaYlv7L0ff4ahQ9CW+R7GgPwQ9vvLTPiGOhQ3
 TUvRpd9Q4WlDWF8T+N1k/YRVFO/daI+j9iU8rfQxOWS8RWKHqn4ZBiIEqVtLEy4/5/RG
 mZSA==
X-Gm-Message-State: AOJu0YzgQXwBAMf60vujXojxF2kdLr+MBHihmVNHyjJgR4c/KgSUcsjY
 Dx0GSTH8gd5BaKHInE+vT6dsdnsFjBrZtum1cmSQ22yIVH6MXTN7pqXXacXkqsvAMNedT0B6mng
 QK+d0VovVvQzBy7LNEXGoG+qu9jHrO6WpvbeyuZ5diA==
X-Gm-Gg: ASbGncuCzyfdz1XEX3O17FkGj5B+kmDE+Mq+nRvC/6H0gILDYB5wU1Rv27ySDwn92Qo
 acMmpG6HhIhunre73m2c1YQ4bBaGfqqHsUTiy9zbqbXZ5uIB7px39YfN5iURE+XJVN4SJz5I+NQ
 YEj29MCH1/u5FfcXA9qBWObd4MziNoyc4JvlaSg2+8ImtHpwqGz4iqrByO8LnhypypINbpB1Jxj
 2CN8W6YNE2+Air+NHYouNYtf7G6yjOuJ8orX3w=
X-Google-Smtp-Source: AGHT+IGK/Yx1mv/YFS5ywu0IuoSX5BzGRCNgzFft1Rx8JkxRcn8bqLaXgmj8xMHkO0sbq8M36Suit6M/1/KGlPxoEwc=
X-Received: by 2002:a17:906:398f:b0:afe:b7b5:555a with SMTP id
 a640c23a62f3a-afeb7b56482mr171919766b.63.1756252087285; Tue, 26 Aug 2025
 16:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
 <20250825224459.682403-5-adrianocarvalho.pt@gmail.com>
 <20250825230044.GB124814@bill-the-cat>
In-Reply-To: <20250825230044.GB124814@bill-the-cat>
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Date: Wed, 27 Aug 2025 00:47:56 +0100
X-Gm-Features: Ac12FXydI1RYDCKO8NkzFzqqnW0F2p6ZLDHDMiflATWeNKAhNET2Bul-lmA1Fjg
Message-ID: <CACAHuLCyX_32AQozgt-Wf18b7ia5m3nRJZ7bA=M9oM1mwh-OXA@mail.gmail.com>
Subject: Re: [PATCH 4/7] doc: make pdfdocs: Ensure SVG files are converted to
 PDF before the compilation of *.tex files
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
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

On Tue, 26 Aug 2025 at 00:00, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Aug 25, 2025 at 11:44:47PM +0100, Adriano Carvalho wrote:
>
> > SVG files are not handled directly in the *.tex files.
> > This commit adds sphinxcontrib.inkscapeconverter (from the sphinxcontrib-svg2pdfconverter package) to sphinx's extensions in conf.py to ensure SVG files are converted to PDF before the compilation of *.tex files.
> > The needed steps are also updated and inkscape is specified as a dependency.
>
> This seems very heavy, is there not some other conversion we can do in
> order to support PDF output?
>
> --
> Tom

The extension itself is quite simple.

inkscape on the other hand, according to apt-rdepends has 755
dependencies on Ubuntu 25.04.

rsvg-convert (librsvg2-bin) "only" has 179.

So, instead of sphinxcontrib.inkscapeconverter we can use
sphinxcontrib.rsvgconverter and reduce the number of dependencies
quite significantly.

Does this address your concern?

Com os melhores cumprimentos. / Best regards.
Adriano Carvalho
