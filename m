Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BA6CFB420
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 17:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D85D088A1B;
	Sat,  5 Oct 2024 19:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="J2zuXceU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFC5688A24; Sat,  5 Oct 2024 19:04:44 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5E26889BD
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 19:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c42f406e29so3994483a12.2
 for <u-boot@lists.denx.de>; Sat, 05 Oct 2024 10:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1728147882; x=1728752682;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/LWbIDOE049/z1cRX+hvLHCu0SlvvFGrK+fj+P84TWU=;
 b=J2zuXceU553pZJL8KT3Pk8nXHh3TqS7dts+Tld1ZQPYwqFqk793D15iIOgznN2CBtg
 eXsUvxA7ENECZh6/jknlxbaSEkJKJBOFZJzfnsGjTGnUeFzAwNEJou52UHxitgVbezmJ
 2mVtqShgCu1Zy8WEMf9+o27ly1HcMoWcluIy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728147882; x=1728752682;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/LWbIDOE049/z1cRX+hvLHCu0SlvvFGrK+fj+P84TWU=;
 b=dxoJU1SJ4+3Bi+VKgOQzeco4jaUr2ZLd0Y2B2xNZ57FroBeih9t56NFu7eyj1z0Rs4
 zfqD+NFqCQnS4SD24pCMunLnGmEC6V2oznu45YaPqu1Z/JnLrIWoLIaRZ299V6f9W3/e
 FD1q0yQuiLSB3GdLwLgYWy6/uA61SPQXSjctUzzp1ufTwwKVhItD1tNRLBZbyTk+aLZ9
 8J9y+zK700M7T4PscpSKEPO8f8GiJjSMCD72J+sSj5pRcLgTzuZgz0l1lKFB+yItJ7Uu
 TvnmGyn+TnUgzzH/WJ65Y08EP0aQ/aSWeMhZpOyrfd1g6TWgXFwEdP1iMKojMze1/nnR
 DuFA==
X-Gm-Message-State: AOJu0YwvDdkPe51H9xhNbzgCtY5hDGH7kJPasHNROpLqcrLuKZQpZCUP
 55NR2+nkZXGB8fzb/fI1b0IY4j2+DBShFRxP2hiDcN9Acb8gCFyTCWj7hlCvwWa110YLKS30Ctj
 V09LpzMcXTZwjGUJH3kpipBxBDK6kK4uxoRdprA==
X-Google-Smtp-Source: AGHT+IFlwmMg7TvrAYt8lId7Pbx593wOzmncmsVKLeSBjvo+Im82GdjUi5jc2j+ZfmukmzU1J51R1Rv6+iUMRl3MpoM=
X-Received: by 2002:a17:907:3f96:b0:a99:4262:cc16 with SMTP id
 a640c23a62f3a-a994262cce4mr152576666b.27.1728147882175; Sat, 05 Oct 2024
 10:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240911-brcmnand-fixes-v1-0-be112a20aaf1@linaro.org>
 <CACRpkdaHpgCT28uKerpfoDxMPRhzr862zf7=pgO7CacOEZFUjg@mail.gmail.com>
 <CAOf5uw=hF8f4LKkhvPwOe56L-mMNEaXiQP8eXXcGQ1v+zFSZog@mail.gmail.com>
 <CACRpkdZEgCc8KsGUNkdABnebHLUwz49cM9EaaBViSA4NWcQ0dQ@mail.gmail.com>
In-Reply-To: <CACRpkdZEgCc8KsGUNkdABnebHLUwz49cM9EaaBViSA4NWcQ0dQ@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 5 Oct 2024 19:04:28 +0200
Message-ID: <CAOf5uwkFk58FurpFZy09rYuaadUD5wXEkxCdjPfBHR=pqMGu5g@mail.gmail.com>
Subject: Re: [PATCH 0/7] mtd: nand: brcmnand: Backported fixes from Linux
To: Linus Walleij <linus.walleij@linaro.org>
Cc: U-Boot-Denx <u-boot@lists.denx.de>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Kamal Dasu <kamal.dasu@broadcom.com>, David Regan <dregan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Sep 30, 2024 at 2:54=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Sat, Sep 28, 2024 at 2:51=E2=80=AFAM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
>
> > I have already seen all of them and I follow the thread
> >
> > We will pick them up
>
> Thanks Michael, I will send out the remaining patches adding BCMBCA
> support to the NAND driver as well.
>
> Yours,
> Linus Walleij

First series applied and sent to Tom

Michael


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
