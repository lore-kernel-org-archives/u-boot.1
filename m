Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A10D767F6
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 18:02:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 705F58924F;
	Thu, 31 Oct 2024 19:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JOzOemn9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C44B8892CF; Thu, 31 Oct 2024 19:02:17 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EF55892ED
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 19:02:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7ea8de14848so900954a12.2
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 11:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730397732; x=1731002532; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QZMnVxwWyFGjn4FHW6UWekZIcXfr28gROOJ9DkdrQ+Q=;
 b=JOzOemn91uSFdpknUQSnoo7ZM/TZly8qyKWRGuOszGBHPt4zxvPuGDHoT/V2SRWwio
 q49J3eZ/lOWuy9kGmCG6d/Wo/88bYKrlDuPozmyIJryvMKWg58/2VX5hTGVlTPqwCnl0
 itGwNdZ8HjeC7mENjf+nJANqVBxppwfsr7WXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397732; x=1731002532;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QZMnVxwWyFGjn4FHW6UWekZIcXfr28gROOJ9DkdrQ+Q=;
 b=GSI4rqLgj+DoEqxAwroERIEX1ex/zbHISvjAXKwJFKltUM0dDXvucFiuMbfkxfN8G6
 92DbL1Szm4DzDyhtRsecJs8eQNisCzqFQ1ilHXcl5VFXIgFfxlJQSDo3agNz82Ghig1c
 laJNEDTl5BWZyQyKCFvm+aIKW6GnasWOH4UeJkJfHpQ3FGthoh8835nuZnt20yh7+9vQ
 T7kHrRfj5KJg/Y6Z/nYlE/U+8i3R+/d6pF4c3z/1DNDOS0UmSulrOKIbfdxteXa0x8Tp
 KgzCIkQFHLpz+PYXzFuMb6YKh4mZ6ekYItRH6HCoYab8pRv3qhbEOVK5R2LOCb7e1kgh
 ABkw==
X-Gm-Message-State: AOJu0YwKnycBjFGoQ0d1YLkEv9X+DQHbldMivOi3guQ0hpSB4mHDKLdL
 uyUURpObF7irI2M7W64c6rdJ2J01HAMzM24xZa79FiMF9u5GUOHujf0aRjcU3lMQ27NfS+YrJi2
 ZoRGhlb2QNmg1iOS3V/IxT3OgtBzsj3FZ9tOMIyXUN/EmzTRdUA==
X-Google-Smtp-Source: AGHT+IEF6FabFkVk4DbqzwOfbxnYg+2HL/SL9nOFdiZ9K7VprV1Kg50T9b21Sj59QIVfNqhqdhEGqC8PaLuJbakiPUM=
X-Received: by 2002:a17:90b:254b:b0:2e2:8f39:98d9 with SMTP id
 98e67ed59e1d1-2e93c1a60f7mr5263440a91.18.1730397732595; Thu, 31 Oct 2024
 11:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-5-sjg@chromium.org>
 <20241029235313.GE2558755@bill-the-cat>
In-Reply-To: <20241029235313.GE2558755@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Oct 2024 19:01:56 +0100
Message-ID: <CAFLszTjh7bxon5mvM2y1cfAA40UqdJVq6G=aR_k7dKr1OZXU9A@mail.gmail.com>
Subject: Re: [PATCH v7 04/11] test: Introduce the concept of a role
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Wed, 30 Oct 2024 at 00:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 09, 2024 at 07:51:38PM -0600, Simon Glass wrote:
>
> > In Labgrid there is the concept of a 'role', which is similar to the
> > U-Boot board ID in U-Boot's pytest subsystem.
> >
> > The role indicates both the target and information about the U-Boot
> > build to use. It can also provide any amount of other configuration.
> > The information is obtained using the 'labgrid-client query' operation.
> >
> > Make use of this in tests, so that only the role is required in gitlab
> > and other situations. The board type and other things can be queried
> > as needed.
> >
> > Use a new 'u-boot-test-getrole' script to obtain the requested
> > information.
> >
> > With this it is possible to run lab tests in gitlab with just a single
> > 'ROLE' variable for each board.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> Aside from the "look ma, only one conf file" trick, I still do not see how
> this differs from the typical board/id system we use today. One can
> easily make N symlinks to the generic conf file.

You can still do that if you like. I have always found that approach
confusing, so I prefer the configuration to be in Labgrid. It also
allows me to connect to the boards using an interactive console,
something that isn't possible without some kind of mapping.

Regards,
Simon
