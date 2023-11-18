Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07865C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 814A1874CC;
	Sat, 18 Nov 2023 18:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EkUWTDkC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C156286EE5; Sat, 18 Nov 2023 18:11:50 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3A9687006
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:11:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-d9c66e70ebdso2783059276.2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700327505; x=1700932305; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=78gfopZk447sFseu45A+Ovv0q20MRMwpVz8kIYnSves=;
 b=EkUWTDkCk0sip1DFKOtyzO0N2GJ/3cm+F1WoLj2Lg+bFw70A6pAQZ5F7zxbzdddssp
 0Hj1z2Rdxi2xNxrV29zQ/29lD+XgK3nkTsSIhBuM2J2T/jS019yZdXC81qMwvfsyq6c6
 Nuo5m5LPcWQN8AeLAyDlx5nFpMgW1oIAdBwA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700327505; x=1700932305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=78gfopZk447sFseu45A+Ovv0q20MRMwpVz8kIYnSves=;
 b=qRHwTpFoRy91Nefdao9a14ILqkMVzybFcuG6OLHFvmnyUZh7+dCec60XsN/xz6QZMt
 93aqqkuorp+vIwsSJl4jicOa6fg5/HXmB/b46Pm32dSXr0+gm8f24hHmN6lSGTL7OCwW
 9DQx72Yh46EXyrN2ldUUW/51gCPZNA+Oir1arbzoLwZWExqPy9aspWzj2sOCQQFEX/n1
 9ttiywQG0X01YEMlNWrG9Bouum7B4/46cBu3dSs3nkV4G7QsWTSS2qij42zh89YAGr6S
 N21aNMo9XxkgDwp0y+9q/Y6+Rzxv0tMrfchqVqbEUEZKsoWR4HbipDl7PrCiXfdXuUKn
 XjEA==
X-Gm-Message-State: AOJu0YxGm0xYcrRN/XYkgQCa7cuZwSW2mlyfNspQ6+tz1DIoBfoJHhrN
 gFrwhnXJIMQsSSWsX9+k0jaCimFF2yytgf22rkzFfY3SOvXpmcbOzpg=
X-Google-Smtp-Source: AGHT+IETRp7yOl8o8NKiQMPTJZ/GLf5xvpb+yv67x9PykgAbC8bABjjZ+6SNWM7TshV/79ugz2H+6h5TiOUESLC0Iug=
X-Received: by 2002:a5b:ac2:0:b0:d9a:5021:4f34 with SMTP id
 a2-20020a5b0ac2000000b00d9a50214f34mr2338346ybr.15.1700327504841; Sat, 18 Nov
 2023 09:11:44 -0800 (PST)
MIME-Version: 1.0
References: <20231117214925.138486-1-seanedmond@linux.microsoft.com>
 <20231117221002.GC170968@bill-the-cat>
In-Reply-To: <20231117221002.GC170968@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 10:10:03 -0700
Message-ID: <CAPnjgZ3V=iDW7SocU0NFxnp6=hjxq=Gp6427MEu3jN-w_E5ZtA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] [PATCH v4 0/3] [PATCH v3 0/3] BOOTP/DHCPv4
 enhancements
To: Tom Rini <trini@konsulko.com>
Cc: seanedmond@linux.microsoft.com, u-boot@lists.denx.de, xypron.glpk@gmx.de, 
 pbrobinson@gmail.com
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

Hi,

On Fri, 17 Nov 2023 at 15:10, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Nov 17, 2023 at 01:49:22PM -0800, seanedmond@linux.microsoft.com wrote:
>
> > From: Sean Edmond <seanedmond@microsoft.com>
> >
> > In our datacenter application, a single DHCP server is servicing 36000+ clients.
> > Improvements are required to the DHCPv4 retransmission behavior to align with
> > RFC and ensure less pressure is exerted on the server:
> > - retransmission backoff interval maximum is configurable
> >   (environment variable bootpretransmitperiodmax)
> > - initial retransmission backoff interval is configurable
> >   (environment variable bootpretransmitperiodinit)
> > - transaction ID is kept the same for each BOOTP/DHCPv4 request
> >   (not recreated on each retry)
> >
> > For our application we'll use:
> > - bootpretransmitperiodmax=16000
> > - bootpretransmitperiodinit=2000
> >
> > A new configuration BOOTP_RANDOM_XID has been added to enable a randomized
> > BOOTP/DHCPv4 transaction ID.
> >
> > Enhance DHCPv4 sending/parsing option 209 (PXE config file).  A previous
> > patch was accepted.  A new patch fixes a possible double free() and
> > addresses latest review comments.
>
> The changes from revision to revision should be below the "---" in a
> commit and not the commit message itself. Please reword things for v5.
> Thanks.

Plug for patman as it handles multiple versions of change logs automatically:

https://docs.u-boot.org/en/latest/develop/patman.html#how-to-add-tags

Regards,
Simon
