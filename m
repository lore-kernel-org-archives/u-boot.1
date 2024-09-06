Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA44CE7AB9
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 07:01:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54C6988CF1;
	Fri,  6 Sep 2024 09:01:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X+sKP9Hy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7666B88CF6; Fri,  6 Sep 2024 09:01:43 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D41C88CDF
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 09:01:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5e1972a9622so1042874eaf.0
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 00:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725606100; x=1726210900; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AYzEID0uVXNdmCAHc09sNp8soJ3zoF4rAaYeztLVNhU=;
 b=X+sKP9HyMiKOoCuioWtGiPj2onjTbkA0IfJuaYRq0BGwzDMAp7j92hXV/KLFcRAf9C
 nCYrsK6JGZJsan+51HoYszvuqb8HMJnd2DrkHxTHpeQgDwKTObuZKiagNzV4YfO2vCXR
 nzskJzJgAfxEExBBA7SsMu1YpL+QckeADIJRsrD3vSt5BRdOxd1UKRJ6Uqfz1URfmkxS
 imXCEiTG8LU+aukyUCZLA008l53IdJwH7W2LH8zplU+eLE3+5EYcLPAGQ/0+5dYVjzyo
 +yQhqQ5gw/fM3hGUpxGq1bALwspJY+60v4RC9gCIh9EkoIiGm3oQMmx4gkXN6VgsJlsM
 0ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725606100; x=1726210900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AYzEID0uVXNdmCAHc09sNp8soJ3zoF4rAaYeztLVNhU=;
 b=S7yrK0FaDJo38zjIeKrPHMsdPlTofJynReW+XxAwer76vMlaWsu6qqJpV4MWSUPA0P
 a1knzIFIBhgnnkHq2u2U2g1TCiADwe9yCcReiovJzKQa++dWfiOTg8yYGebNH9rhMXrx
 kgsr7x1PDnlPsS8cjGIefkw45ikm75Ja8aGUguMJijslsZX+WATIr1Dse26xD5t+kJc/
 uVnQs8wkIuMUSc7AetjOCnQoGkFQvF2l3TOqNGJOFA7s9G+832jY1GILJRYmuAEdq18e
 RspmiX2i59LMVmP2wZlxbQFAw+Q9mCCXzRAuPRUPTEm7TmNKVMg1dXrK6/0BJICt7/GO
 xdLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/ekgpR+DoMGGmHtrNMIReCBDdLgdW3gfb3/loUp/hwi1NL938ab8lnaZUItmXKxBcixnY9Es=@lists.denx.de
X-Gm-Message-State: AOJu0YwbLUTMheTeDmsXtTZIdpJRS3uYso33NkKfCVn3rMIJcXnta5O1
 jErcoLpoGvYgQGaMbzMcxNtUu3SrhvBjHan1lTzUkHXgdDtWT7ReTUQoF9BAZFM5TpHcyyV6l7Q
 i1aT1knxRFoJIVQCYwnX1hWGA414AXqUL+E2vPQ==
X-Google-Smtp-Source: AGHT+IHSqFe0S83ar8hnCwzKEMobwMcDb/XsQjTVJN3SfoPZ9rtvCQYRfIII1CHMyzFzlBv27YvR7sSysmfYjNP6lLM=
X-Received: by 2002:a05:6870:2253:b0:277:df58:1647 with SMTP id
 586e51a60fabf-277df582090mr20862846fac.35.1725606099752; Fri, 06 Sep 2024
 00:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <CAFLszTiRy3dkrTVnkV-H=CcCxJH6W5=RBM9tokOiSN-AVXGywA@mail.gmail.com>
 <CALeDE9PqT54MH0riLFng3ONi=rtEa53LsxRgYcV1ENX=ikuV0A@mail.gmail.com>
 <20240904164332.GQ2479150@bill-the-cat>
In-Reply-To: <20240904164332.GQ2479150@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 6 Sep 2024 10:01:03 +0300
Message-ID: <CAC_iWjLfEE4aD+W11z2kaP9Dd8+vtVp8iy4uT4H=pn-NKOCUTQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/28] Integrate MbedTLS v3.6 LTS with U-Boot
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Raymond Mao <raymond.mao@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de,
 manish.pandey2@arm.com, 
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sumit Garg <sumit.garg@linaro.org>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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

Hi Tom

On Wed, 4 Sept 2024 at 19:43, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Sep 04, 2024 at 01:48:43PM +0100, Peter Robinson wrote:
> > Hi Simon,
> >
> > > I wonder if we could leave out the SHA stuff? The algorithms are
> >
> > One of the big advantages of the mbedtls when it comes to all things
> > security is that it's seen a wide audit of it's code which for a lot
> > of usecases is very useful from a security PoV, I'm not sure the
> > amount of audit the U-Boot in project code has had, I'm sure there has
> > been but I've not seen anything published.
>
> Yes, it's a positive in my mind to bring in the assorted hashing
> algorithms from mbedTLS here.

Exactly. So apart from the know shaXXX there's other alogrithms we can
pull directly -- e.g SM2/3/4.
In any case, I looked into mbedTLS. You can override the default
hashing algos with MBEDTLS_SHA256_ALT etc definitions in the config
entry but I don't see the point.

>
> > > stable and this would seem to avoid much of the size growth, and all
> > > the pain of trying to integrate another yet another hashing layer (we
> > > already have normal, progressive and h/w acceleration, plus
> >
> > What's the difference between the first two?
> >
> > > UCLASS_HASH which h/w acceleration should use but that migration never
> >
[...]

Thanks
/Ilias
