Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7B8C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 14:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9846F88636;
	Fri, 26 Jul 2024 16:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G1dEaVF2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48A2C8862F; Fri, 26 Jul 2024 16:55:08 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2218D884CC
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 16:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-44fedc06c03so3674161cf.3
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 07:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722005705; x=1722610505; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HgXwkoXfaL0qjBLd97il0s8tiX7Lb3MTTKHzBl2H2AQ=;
 b=G1dEaVF2R55rrXCzT4IRbliwd6R5t0tJj3Fm3glF+ecfGIKjY6vY3QMYEP3TjMgUsU
 IbNrAA3et2YBX57UCu2mBoleyiQxTqBu5ROorROayjIzcrHBG0ytYtLFPQuffyltJ853
 cSnHEhIWnxbQ+HELdh5Ml4OICfUwVLnThynUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722005705; x=1722610505;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HgXwkoXfaL0qjBLd97il0s8tiX7Lb3MTTKHzBl2H2AQ=;
 b=kvg+pqbJC74DjIe0kEOeWTDnn/mqlhY7kHQl/IoNqY1TtnFDP/L/zhrFdI7vu8k0Lr
 3ki20FQ797RrDwBfZDxiXsY8UkjIj12n+p23u22pbDhldFryc2QStfMIUY3Wz4eXklKy
 TEAJkRB//p9HMAwvLsC9XmAN3SeCP2ZuLQuvTKVsp7m2fzrL3ndUUTcd8tlho65fJqk1
 nHzQE5d3MZD/u1lS9DoJgLKRzDiA+6kFrcqS1snjf0RlX1vgWs6L9UihN5UKXGYmYtcj
 7BDeKbPDIWNjUPY48a47uth5/GpWhKuU97yv4Vy3HdDQRsqbLqDPNdsGTI4xpYhvWEPn
 aaTQ==
X-Gm-Message-State: AOJu0YyYkav3Aohx8V+QhZXQn1FjsAEkAtmFWMN9bNgItXUOdYLq17Zo
 ePfpsHhkJXjoo+eoh0e6I9APO+nAtT0UryyGKHdbN2RPmWN0ZLcj0pr7CvBjF60xMhBLOkgu6hP
 whcQoNdtUUccSRAWT2zSBSCDpmLYQXnVlNPUF
X-Google-Smtp-Source: AGHT+IEEEbEX1uiL0yxwuz5n7x/WIp5bxkqNMy+z1M4HeEkpbfWAbRiCa6pd0/P/QFgf3godcQGkTbQljSruZnbTGNY=
X-Received: by 2002:a05:6214:daf:b0:6b7:b236:6964 with SMTP id
 6a1803df08f44-6bb559a0aefmr185276d6.12.1722005705083; Fri, 26 Jul 2024
 07:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240726140038.194946-1-sjg@chromium.org>
 <20240726140038.194946-4-sjg@chromium.org>
 <20240726143320.GJ989285@bill-the-cat>
In-Reply-To: <20240726143320.GJ989285@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 26 Jul 2024 08:54:52 -0600
Message-ID: <CAFLszTiwRFb+8tGE1w+Qi6fia_qaKm-Xs6OGALBCU-EzTBPMNQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] alist: Add support for an allocated pointer list
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Anand Moon <linux.amoon@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Sean Anderson <sean.anderson@seco.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

On Fri, 26 Jul 2024 at 08:33, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Jul 26, 2024 at 08:00:37AM -0600, Simon Glass wrote:
> > In various places it is useful to have an array of structures, but allow
> > it to grow. In some cases we work around it by setting maximum number of
> > entries, using a Kconfig option. In other places we use a linked list,
> > which does not provide for random access and can complicate the code.
> >
> > Introduce a new data structure, which is a variable-sized list of structs
> > each of the same, pre-set size. It provides O(1) access and is reasonably
> > efficient at expanding linearly, since it doubles in size when it runs out
> > of space.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v4:
> > - Avoid using realloc() unless specifically enabled by Kconfig
>
> Is this really so performance critical that we can't always just use
> malloc/free here?

I would have to write some sort of test suite to get a better feel for
that. The realloc() can be instant if there is space above the current
item, whereas the malloc() approach always does a copy.

It is certainly odd to use malloc()/free() when realloc() is there, so
I think it makes sense to provide the option.

Regards,
SImon
