Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C866CE7A91
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 04:01:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43BA286B4E;
	Tue, 26 Sep 2023 06:01:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dawes.za.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail-com.20230601.gappssmtp.com header.i=@gmail-com.20230601.gappssmtp.com header.b="Ta1h/T8x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E25986BE8; Tue, 26 Sep 2023 06:01:53 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 617B786B18
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 06:01:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dawes.za.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogan.dawes@gmail.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1dceb2b8823so2303415fac.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 21:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail-com.20230601.gappssmtp.com; s=20230601; t=1695700910; x=1696305710;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7eohFKjNjv7zK/o6OjgCaWFhxS5h0mMv0VQx3DSXAIk=;
 b=Ta1h/T8xnwfFP7DuTbhn8RIPno2dZ5tv+pbKsUXXALEgSec8TVM4688bZ5z9n4iwBE
 UOXaRIRlUCFtKZK9gAK9yjXT/hjWdxc1G36IPxQ+JUWKVFU8LERYpmsTwV3EeFeaStnB
 QNxPmZCoH1x+gM10L45EyQaL4wW9I/fzs2N8VTrGNhOAfvmd3FnDp9GzWblbLqbjyl3+
 SFVAyj4b0JUMnbQNu1TGiQaYpwCom2uUQ6hAboQPgOAX06I8Dg0Ms3iHqgWrk5WwWwrG
 +PRP0MzgeYBR7dYdx04FSxc3vYHWh9E9Tbn9sFOag3bL3bfROyMVE/2i1lmFUX6g5gzA
 2kGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695700910; x=1696305710;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7eohFKjNjv7zK/o6OjgCaWFhxS5h0mMv0VQx3DSXAIk=;
 b=QTMhaLLQkxrFGsVBJE6St/vVub7ZMVjLUaB0vynEZZsfm5GTrS6xcGcpBJz46BFloI
 CR5cieUV9Mxwe0HireE5ClQpx2rqFoMLQvxxFSD00ymScUDV9+Cr417Uhccciqe7fJE/
 Yv6rT36wdgkptr9E7aZZAq1hp2Bgt8cAXxB7yLIIsiszkP2NFSFGiBROZVLj0316Zloj
 n3DFML85Z2DyLgj1ktbnRWmrRpS5zMlEF9yUeGQCzXgdcmL1MyhqIWBjd003HW6jMSUk
 w0al0swkBxl+efhlCwjwnTDyv8X746jD1fiUjdBc2N+LD77Lmj5/TL9sqlXTHSRMN5XG
 qkeg==
X-Gm-Message-State: AOJu0YyLzxwVYHOmZ+jMGy18tsyXStxASyXzo8h7igF0ZK2rkZxvq6C/
 WTtNpf7pPTE+4Fn1zC/o4kwpN+7Xa+FTdirhNqY=
X-Google-Smtp-Source: AGHT+IGE8D6UnnhVf5YQuu4UbG+padM5WjbeOvFHyof5wx289DEwueak5TkqDh8o7YvLF0tLvv4goAmNCXjz/iGrS64=
X-Received: by 2002:a05:6870:231e:b0:1dd:2087:a469 with SMTP id
 w30-20020a056870231e00b001dd2087a469mr857731oao.29.1695700909846; Mon, 25 Sep
 2023 21:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAOYdKdjW6Ut3QCMWpu8W7TKuuv9OfehC7tdW7-vkdcN8ZbK3Jg@mail.gmail.com>
 <CAOMZO5BtN6xQJ9j35Wz4wH9p5Q=JoC2Ffb1aN-yrTzUeb0AvYQ@mail.gmail.com>
 <CAOYdKdjnVpt=YOrAzjKiaAZomB7=hgAHe1TE+7MM8PK3g+WjRQ@mail.gmail.com>
 <CAOYdKdirq-H+ZaBmy0sT05sL=C=cJWLixgJLsA5ES9PcwZrXyw@mail.gmail.com>
 <CAOMZO5CTG8bqNoP2XO=6VXXquutg-MFqBTbi9Y2q4Dcg0Mfftw@mail.gmail.com>
 <CAOMZO5ArFiQO=BWvDbR91XhADJ0ks4JTe45zOb+z3aaiED2gkg@mail.gmail.com>
 <CAOMZO5CYnkCC5pmG35+8qHqeCaEJwM3Z3eyoJaTrOMMWj5AWWg@mail.gmail.com>
 <CAOYdKdgLaAx8krbBZV=yaUGTwtf6cbgaTU3=+pRKJ4-w_V3_Sg@mail.gmail.com>
 <CAOMZO5DqKS2w1G3iKKGPS_piXx8JcGoWCFOqCQOoB524O9KyOQ@mail.gmail.com>
 <CAOYdKdjPrRT7F_LFf8YeafX1MWep_p91CFdwc-SH8+diCu+2sw@mail.gmail.com>
 <CAOMZO5BzrfvLDrtqBk1dmLqb9-GxzZs8nRVY7GxqCRY34pKg4w@mail.gmail.com>
 <CAOYdKdgyXi5g9zPNOCBtsrA8KV0L1O0Oyh4Ne-Q79Z=EgGs=zw@mail.gmail.com>
 <CAOYdKdhvKEaeyv5zhXiswuF-Kd6ee8FmdN8MoMS9=5VTWVgMXA@mail.gmail.com>
 <CAOMZO5DS2VHPKvVioSW=7fWfnrP63A6wdga6pFmFuSK2QF8gSA@mail.gmail.com>
 <CAOYdKdjALruh9v6HBO-MSjzZM0whYhbA5YLJxbKk7yQk7cznGw@mail.gmail.com>
 <CAOMZO5AVuBxGFF_itcxvdG=W9JoRtyzzeeC+wji__uUOQirwZg@mail.gmail.com>
 <CAOYdKdingLtAvEnth8mSnazQ2fZ_kCsM_2P_dX7tbL2xe9wyVw@mail.gmail.com>
 <CAOMZO5ALK_O-648FaHFrjJc9EiU3J=nvv1rYDiLOGqhjt3mmkA@mail.gmail.com>
 <CAOYdKdjEOsLmkoJdxk1CmLk6_AJFZhuS_7fWxWOm14Av1n7gHA@mail.gmail.com>
 <CAOMZO5BEqwT+t7hw=neAfww_edg61cC6eggr9NNL3OS3jXOY8g@mail.gmail.com>
In-Reply-To: <CAOMZO5BEqwT+t7hw=neAfww_edg61cC6eggr9NNL3OS3jXOY8g@mail.gmail.com>
From: Rogan Dawes <rogan@dawes.za.net>
Date: Tue, 26 Sep 2023 06:01:38 +0200
Message-ID: <CAOYdKdjn39rV-z3wRf8tORvxP4riZaY0=POhaVjeGh2i3C-yUg@mail.gmail.com>
Subject: Re: Trying to boot custom kernel on Wink Hub (i.MX28)
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
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

Hi Fabio,

That prints "LLC", but does not print "Pref".

Rogan


On Tue, 26 Sept 2023 at 02:15, Fabio Estevam <festevam@gmail.com> wrote:

> Hi Rogan,
>
> On Mon, Sep 25, 2023 at 4:27=E2=80=AFPM Rogan Dawes <rogan@dawes.za.net> =
wrote:
> >
> > That outputs LLC about a second after the mxsldr terminates (kinda
> slowly, the individual characters can be seen being emitted one at a time=
),
> and then about 5 seconds later, "Pref". But nothing after that point.
> >
> > At least it looks like there is something happening, which is excellent=
!
>
> I pushed a change in my branch. Please give it a try.
>
