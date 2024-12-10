Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7BDE7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 07:13:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4868897B7;
	Tue, 10 Dec 2024 08:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BD8gpyk9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABD7A897B7; Tue, 10 Dec 2024 08:13:23 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DD26897B5
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 08:13:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7fd5248d663so1353604a12.0
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 23:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1733814799; x=1734419599;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DVrcNMr42g6sa23BOjrgdPojwc+PrVOgOGqUcZnwHzQ=;
 b=BD8gpyk90uwC5ZZG7/E7s3ThF2iMxA/rAdJthbmWWz9Asz4CsdjkLVSYuDYBxj+ge2
 TKs+YIaJSLVPCTcFIAkrEeS6wT8uWN3ZhwhImNpySarxscu4LKWYy2LrNqZW3BcvHwHK
 cFtat9TK17y5K4lmmMw73Wb0wY+2ows7pML1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733814799; x=1734419599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DVrcNMr42g6sa23BOjrgdPojwc+PrVOgOGqUcZnwHzQ=;
 b=IIBUE+DKC1f9CkfOd7hPYkChVPqQqbR8z3VvXZV7I36DW66lDgwluVXZcKnwOVgUbx
 K5BXSJp4YTfoLM3pkpl7bVhF36NVz3SxX7YlF5wZLDp0idtnkr77Dj2BlB+RPZ4jc7Bo
 lSUTvw496al/kMt3rFbAzChdifbvQWY89vawWZB3PgbKHEUsBKLZga1MbX+IHAYnVqj/
 OYBpaWVWR/eARUr1UAHRisDV+IaFcv+mg9V5yAMoCfW6mZN9QEOpTQeBfSSGJ6Mt9z5u
 LsZx2iFYpIzB/04x1KnkNaIz+i7a5ygLdpRNhfJdiXLTS0sKO3ITi8+7Vn/iIATej+7C
 MT/g==
X-Gm-Message-State: AOJu0YyqGEROVC8E0v2DCaoKmx2h3VGVBpPZz2Wp5I5z1M8HCdBDky6c
 rHadc3m/enuFDs4ZDmHDMliujp9ChA7gbv+dHegQYYYWfoExDd6SjZoLKd2GhkJp2XFjW+C/t33
 08KbvKut/BX3phu3qjBOfr1yPaMCj0W66sQbz+A==
X-Gm-Gg: ASbGnctjbnARBfENiPldIqJBqETOwlr7BWNk3H028bD1p3Ca7FSLCGOwZ0ufspXUg8C
 JCZGcCoQCYuJpoyLmSLWptu2q2ntl5KQG
X-Google-Smtp-Source: AGHT+IGv+cOe4uQXR+wEecYnlJfSZRwnlz2MIkIHmvWXec3ze4tJ8E3g/S/LAmLnjc00fARuq+WyX4qMCsquI8PGu7s=
X-Received: by 2002:a17:90b:3d46:b0:2ee:b2be:f390 with SMTP id
 98e67ed59e1d1-2ef6aad0b80mr20147701a91.28.1733814799510; Mon, 09 Dec 2024
 23:13:19 -0800 (PST)
MIME-Version: 1.0
References: <20240809121556.3215132-1-marcus.folkesson@gmail.com>
 <ZtFt4rBOzF7Qgm-K@gmail.com>
 <CAOf5uwkhkCuW-st6ZnEVcQv6gDuRXSog_AQh_KQCUECFuyZ3sw@mail.gmail.com>
 <Z1fo_xrE8jLve6pK@gmail.com>
In-Reply-To: <Z1fo_xrE8jLve6pK@gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 10 Dec 2024 08:12:52 +0100
Message-ID: <CAOf5uw=U_eGm1b8_EUUHDVo=eSUatusr3OMQEH-NjvZmAcv92w@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: raw: atmel: remove unnecessary return value
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>, Alexander Dahl <ada@thorsis.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>,
 Igor Prusov <ivprusov@salutedevices.com>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi

Il mar 10 dic 2024, 08:08 Marcus Folkesson <marcus.folkesson@gmail.com> ha
scritto:

> Hello Michael,
>
> On Fri, Aug 30, 2024 at 09:05:27AM +0200, Michael Nazzareno Trimarchi
> wrote:
> > Hi Marcus
> >
> > On Fri, Aug 30, 2024 at 8:59=E2=80=AFAM Marcus Folkesson
> > <marcus.folkesson@gmail.com> wrote:
> > >
> > > On Fri, Aug 09, 2024 at 02:15:43PM +0200, Marcus Folkesson wrote:
> > > > The condition 'ret' is always true as it is never set to other than
> > > > -EIO.
> > > >
> > > > Remove 'ret' and the condition for copy.
> > > >
> > > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > > ---
> > >
> > > Any more thoughts on this?
> >
> > Reviewed-by: Michael Trimarchi <micheal@amarulasolutions.com>
> >
> > It will be included in the next pull request.
>
> Not sure it got included?
>

I will pick today.

Michael

>
> >
> > Michael
> >
>
> Thanks,
> Marcus Folkesson
>
