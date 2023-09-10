Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCAEEE49A4
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 19:15:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B714086D1C;
	Sun, 10 Sep 2023 21:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S4EXe0ow";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AFC386D18; Sun, 10 Sep 2023 21:14:51 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60BC686AFD
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 21:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d7d50ba994eso3282015276.1
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694373287; x=1694978087; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y476KKce+HIzghI91G16y+k6/o7FwOszLbUpMmz7BQU=;
 b=S4EXe0owmNEeVs4llfGgragynACr77NEDeAwdqpduj5GmB2YNVtCMdJYYzIX7jj0Yx
 dJGD4Ps9qo1cjH07BJSmVuY3Pg7shIK0BxRtmsgpHAiTCb+8yPv3Jjx+UVvlstnmepnU
 2BLcIb6fXahmca2KC2V2F09qpf/Ww9NAus+gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694373287; x=1694978087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y476KKce+HIzghI91G16y+k6/o7FwOszLbUpMmz7BQU=;
 b=h1He811jnuLCNdDWo1RWHmTqH8vFP2YaU0mfdELs2bs2rHjGpG29fMwChfDRxTKlf3
 SUVI1SiHrOksy4ob39EYfYBdDXnvNPL86BNzOYe9xSlTvOpdcxeLw4/tTikBRZm5WdZx
 pRKW/bMSlWLE1j1OxdyNYfrmabvwcWqinrmdQnYDXWb8YaZWfsufiTj2xvH9QsRBZE4X
 9RwlUs5ZVTrjUerWiOMSHMhuD4LTQYU/kxq0B9dEfFEAA1ioMuP9At65r2DNiwfX3cUF
 eMsxnGGHGILRdbNgAxlE7/KB27TY5ijosVfp6OSUZcCS06bscGnhtmB7MAUjw+wRw6Wr
 sFTw==
X-Gm-Message-State: AOJu0YyMF8pMeiaG68izd0uImAnrz+rIW6DhQdlgK/6hECXhdVOSs3B7
 t2R6oUzUKqcWDnh6Zn0YJXVQSwaBkehE0o+v1fIpITyw+bBd/y/K+a0=
X-Google-Smtp-Source: AGHT+IHmic/g1jMUwWo9cMNEva94Gq1ujQjAblIJts8rbrRnIGCoXhQGcqdBmtQ8tfErHTwADUTlHRg4OHozlMvy11o=
X-Received: by 2002:a25:250e:0:b0:d7b:8d9a:4ec5 with SMTP id
 l14-20020a25250e000000b00d7b8d9a4ec5mr8271995ybl.41.1694373286991; Sun, 10
 Sep 2023 12:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230909135235.21242-1-massimo.pegorer+oss@gmail.com>
 <CAC928HZipzfTmucsBOFeta+9od_41AZx7Ot9ErGs4kX0ACOMSw@mail.gmail.com>
In-Reply-To: <CAC928HZipzfTmucsBOFeta+9od_41AZx7Ot9ErGs4kX0ACOMSw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 10 Sep 2023 13:13:20 -0600
Message-ID: <CAPnjgZ0Hc9ATk-j-p=vQk3BH817_zvA7PF7rA9h6fNcvvoUvOA@mail.gmail.com>
Subject: Re: [PATCH] binman: doc: fix reference tag placement for Logging
 section
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Massimo,

On Sun, 10 Sept 2023 at 09:35, Massimo Pegorer
<massimo.pegorer+oss@gmail.com> wrote:
>
> Hi Simon, Heinrich,
>
> Il giorno sab 9 set 2023 alle ore 15:52 Massimo Pegorer
> <massimo.pegorer+oss@gmail.com> ha scritto:
> >
> > Move BinmanLogging reference tag after section "Signing FIT container
> > with private key in an image" and just before section "Logging".
> >
> > Fixes: 0f40e23fd22 ("binman: add documentation for binman sign option")
> > Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> >
> > ---
> > Note that at the end of section "Replacing files in an image" and just
> > before section "Signing FIT container with private key in an image"
> > there is a line which seems a typo or an incomplete sentence:
> >
> >  Repacking an image involves
>
> Any comment about this note? Should I remove this line in a v2?

Yes you can remove it. I suspect I was starting to explain what binman
does to repack...

Regards,
Simon
