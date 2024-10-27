Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095E3D1356F
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 16:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8457F88113;
	Sun, 27 Oct 2024 17:37:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BEzkGQn3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2743888B1F; Sun, 27 Oct 2024 17:37:43 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E90B85B66
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 17:37:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c9693dc739so4704563a12.3
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 09:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730047059; x=1730651859; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FRrfcfTfGggqFpsiWGvsB54mBvhTWIE0TbLJQK8rVC4=;
 b=BEzkGQn3MFZIQSUkfcgs+JYbooy06yBOEBBi0JHfF1nijW3yoxnF/LOwnx1GoXx4UB
 iDGXgEIfk77t4CmmZUOHP/WhB3BPl/m16OH4xEcZ+6nyzjboAUMVnQncjWhhny9oXXSV
 Avt00S48O+ukMqXm36VMJfX77KzGL/Ln1z7NikS0CnDTsjtDWIA+XOjzB03rm9Q2u4D1
 gWfWyI3cQR/meuUH3Pa2hHozn3uKUXWAHxjTIMiDs0PywNPagJP8mH7pIwO+yyWPOCnT
 RSfg0ifehFcZFDDrVBFklDLS+p6w3HzvKruNmCxJHn1j4gIZJ8hiCbbVPKuXh/VVrh+j
 csvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730047059; x=1730651859;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FRrfcfTfGggqFpsiWGvsB54mBvhTWIE0TbLJQK8rVC4=;
 b=q0o0E7UMwzKgwNPUveAD5BkRDlfh6IttVcSOl/GFm6ql98QJlmPZELQ8/0N6gc+l7E
 kEICcm9e+Pz5omcqtKvyaKDxAFf/qlGpx54kGrZiHDm+4XnfhlNuDlY/Yj47o6FiJSSN
 jpNT4N4pUZlp04XVfxIApw0oD/2TiPtV5kQ4QE8KYoQUYqsREdBYtXc9BWi8ImmQpZgQ
 znfhGxgZlMTzuZt5WhuwlgBTiL5iGpbkVhW7LYW8PKuYWHDNx9F5xFJ1+3Op3eDlhFUL
 jfs7Dyb+T6RseUe3OTx2AO5l3FpqmZJlrI3FoQJsRewoeudKxd0Z6axlwWQpZLhXFxF4
 6/AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn1/BwZp7kkWMdCg+/PX8RcAoIhNX7u1v1CRwtx5j7e3CRuGzC7Mhlj+A5Dw8b2woP5QNdkac=@lists.denx.de
X-Gm-Message-State: AOJu0YxUBZUQpr1CrIcgMDvWYpMHSluChJTb91l7FnQqbhtU7Ovp8xbg
 onamDlYHJeRgKw1OznYgamWBH+/dLcABn/NRfYTyT3mHLBfjyeaq6n5kXAm7oZFo5dUjgyCq1xH
 Ss/PiIWK5WjIpgQuRJpizBxvwMKM=
X-Google-Smtp-Source: AGHT+IH8V7/JS2BHcxuk+Y7TI2weI7fDVLL8amOBN5aTO3pHmZoCgygvMiE9Bt9zcu1GvMcAgEZQUR/fRLT7oIS9Dtg=
X-Received: by 2002:a05:6402:40c2:b0:5cb:b616:5ed6 with SMTP id
 4fb4d7f45d1cf-5cbbf871f1cmr5583612a12.5.1730047058331; Sun, 27 Oct 2024
 09:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241009105054.1879054-1-mikhail.kshevetskiy@iopsys.eu>
 <20241027160647.GA1956477@bill-the-cat>
In-Reply-To: <20241027160647.GA1956477@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 27 Oct 2024 16:37:26 +0000
Message-ID: <CALeDE9Ms6oA5VJmUR1P9AmzLCCtxS0+4du-RLNu7FeitU7MfMA@mail.gmail.com>
Subject: Re: [PATCH v11 00/13] net: tcp: improve tcp support
To: Tom Rini <trini@konsulko.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Simon Glass <sjg@chromium.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Anand Moon <linux.amoon@gmail.com>, Baruch Siach <baruch@tkos.co.il>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
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

On Sun, 27 Oct 2024 at 16:32, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 09, 2024 at 01:50:41PM +0300, Mikhail Kshevetskiy wrote:
>
> > U-Boot support of LWIP is not ready for a moment, but we already have
> > some kind of tcp support. Unfortunately this support is really bad.
> >
> > Some of the known issues:
> >  * tcp packet from other connection can break a current one
> >  * tcp send sequence always starts from zero
> >  * bad tcp options processing
> >  * strange assumptions on packet size for selective acknowledge
> >  * tcp interface assumes one of the two scenarios:
> >      - data downloading from remote host to a board
> >      - request-response exchange with a small packets
> >    so it's not possible to upload large amount of data from the
> >    board to remote host.
> >  * wget test generate bad tcp stream, test should fail but it passes instead
> >
> > This series of patches fixes all of the above issues.
>
> Please rebase this as it no longer applies now that lwIP has been
> merged.

Now that lwip has been merged I think it makes sense to look at using
that code if you really must have a httpd server on U-Boot.
