Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003D7E7E638
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 052F586EAC;
	Tue, 26 Sep 2023 16:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="rb9/z2l/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A57E086E3A; Tue, 26 Sep 2023 16:16:55 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA4CC86DEB
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:16:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-503397ee920so14174079e87.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695737813; x=1696342613; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mzpore9V7sZeoWXUXRUgr/wobOj5DJMOXKcTTQuevyM=;
 b=rb9/z2l/fu838FlK4iEtY7X0gUHQdNeygXijReatij6IULLzroqPWMwz8mGP92OjuZ
 GPEXrgswe+qpny/t6YaWjS0I+Qe38LIlZatuUxHfJfEmMcRHgiDufDu6f12mxpAMJ4bQ
 v7fS081SsQzVegudoHj66sFkNOimQ1kJ5FR95pIfF/orW4Nz8Mtg7BpjVditwZEWyNKm
 x6jYHGv8bzZfntWnuRwNBcOSOU2KIGzmAJOy+ncn52h/PCo1Spj7gfUMb8TBSMYpxI/o
 det7WpHooXx0BNDhbvASKEDrUIrlX6AA9rI6Y9Fi7wjwnZosu7qsZWjKfrZXPqPALD5r
 Qhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737813; x=1696342613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mzpore9V7sZeoWXUXRUgr/wobOj5DJMOXKcTTQuevyM=;
 b=GoCznQg0CKimHp5xkUlJhgZabQFOB3y1Ot4T7h+nzxlI4juWc7B8mVo33YYjSHxExO
 gLXmq2380TDm8SMJ2kemFEEGjjYznWK2jrxBC0OHreLhYO526TqnMoIJzAy9SQ6ssprO
 BTniNQLztiK/dENY9EPd+6GjVD1jSgCMlkdH22Xx2ng12HRi9gH0v3r3LaJCbiQfn/jM
 IOhrh5qLYo6L0HdyspxTIyiZPfpJBTGCjhP2XiKxhBkCy4hSpWOsSa8dYuZRbg2W8q9q
 18XN/LpZsiEB1km4ypqUVrVMLl7YO0glGne3jjmFKrUpyl87GGtW7eWPxTA2kroqgKcE
 iTWA==
X-Gm-Message-State: AOJu0YzUyh8HkOvbLtSuZmogXtN6WEhLoobTB75D15fxqCVJOuoWxNJK
 z6BBH58RwRXIsbx/Cx4YMt4MZ35/hj9hQpcjU51NEMtB76B599XIBI4=
X-Google-Smtp-Source: AGHT+IGUEE669mzkRPcN7Hc7RsVlhMOhkRywOE/vZzBC4dvH8qglHF7Dg6g1CBlH7b0JsRRp5weGN6TnyPC3472XNYg=
X-Received: by 2002:ac2:5f74:0:b0:4fd:fc36:68a2 with SMTP id
 c20-20020ac25f74000000b004fdfc3668a2mr7412510lfc.1.1695737812687; Tue, 26 Sep
 2023 07:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
 <20230926094124.7024-2-maxim.uvarov@linaro.org>
 <CAPnjgZ2OV8ug3+3ji8nEnK7cwONu7KFa2zSyP5urKWUkQvMqJA@mail.gmail.com>
 <20230926134149.GS305624@bill-the-cat>
In-Reply-To: <20230926134149.GS305624@bill-the-cat>
From: Simon Glass <sjg@google.com>
Date: Tue, 26 Sep 2023 08:16:35 -0600
Message-ID: <CAPnjgZ1iAG8Rw3jVZvFs16AvnGkO=gCsCM3dF1c30biFk4t2xw@mail.gmail.com>
Subject: Re: [PATCHv10 01/15] submodule: add lwIP as git submodule
To: Tom Rini <trini@konsulko.com>
Cc: Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de,
 pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 goldsimon@gmx.de
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

Hi Tom,

On Tue, 26 Sept 2023 at 07:41, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Sep 26, 2023 at 05:37:25AM -0600, Simon Glass wrote:
> > Hi Maxim,
> >
> > On Tue, 26 Sept 2023 at 03:43, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
> > >
> > > add external lwIP library as a git submodule.
> > > Use STABLE-2_2_0_RELEASE tag.
> > >
> > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > > ---
> > >  .gitmodules            | 3 +++
> > >  net/lwip/lwip-external | 1 +
> > >  2 files changed, 4 insertions(+)
> > >  create mode 100644 .gitmodules
> > >  create mode 160000 net/lwip/lwip-external
>
> Do you have comments on the rest of the series?

Not yet, but I should be able to review the rest in a few days. My
main comments before were minor - return codes, tests, error checking.

Regards,
Simon
