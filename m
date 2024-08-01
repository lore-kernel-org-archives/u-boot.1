Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2D3C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 14:43:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F06F888B0A;
	Thu,  1 Aug 2024 16:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FrMBXe7p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27C2088B68; Thu,  1 Aug 2024 16:42:40 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB6EB88B58
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 16:42:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b7b349a98aso47113766d6.3
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 07:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722523356; x=1723128156; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KAWtoI5gfeRZVRqSYU0tCslGohSIbXBJ+wqDOrUj0NY=;
 b=FrMBXe7puXuDGOWlohk6RpkGVpZSyOIPmrlp6Qh4LUMWELUrA9p4G0wK0facLlD7br
 W7YxRMMdD2hrpQYVV4QZdbSs/WcQQjPIoxlyJuhRYRxHd3wJEBMVlZB/rYwNFoOzSHCE
 Uk5rVXfH+IpYrMVXZA3jA8HYd1fBtCyZPQduY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722523356; x=1723128156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KAWtoI5gfeRZVRqSYU0tCslGohSIbXBJ+wqDOrUj0NY=;
 b=EcUrNfGpNQR+FEDfSTUKNAh3TD2ao+rKWGiTHQD5ZBZfyytEQL96APEq27/zwM7vY2
 Oe4ucKDk0K8spbC88yTRrpaMRqGTJ76t8jNBjDk6CSgAQhtBE3rtuOxaTUJZxe6gLNsU
 5LSr0SWovuzCWEub8BrHcdESCwBdkieF+fTdVbmov0g3X1qaYiQp9Fh004J6b/i1A1YB
 PxV0buRs21aPcuby2tBDVeA8+8aPJ0IS5VhROzkIEjLvNnuD08SwNAYKfPIL+eAEWPyY
 RFDoXiDAusXokUu0l87qnUS4BCiZAbYaAKS1IrAF+bKdEQX7mpTll69bT6P1cyqqBpqu
 NF/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtb5arICuuIcD8daFkrsGRI4t3yBdszfxJccji1uLMCwBKmvCIa5XoefObuxgGKrYrOFAYw5TmG98riu5T9lgZjU46kA==
X-Gm-Message-State: AOJu0YwmlF2C1Ss542RNG3s7KordQEjcvYJ9Faq+DHA5NGc22DQLeQEa
 O2/Lc+yahK128Xk7RAkQ/P7kY05npwHL81KlqZnFmaGkIlPLLHQhdhr2UUHtXi0PnhHvd+SBgl+
 niUCLrUfA/2n3FHG2CQPDBV+GWe5sKGV/CXqS
X-Google-Smtp-Source: AGHT+IG0F+7ubQ6qFTv4Illz03mYIZWQ4Sfy2bTJYBpGjdoCL2Qw18aOe6cIrpLgTddC/8MnfZQ+RptD43cKUi1EjSg=
X-Received: by 2002:a05:6214:5781:b0:6b5:d90d:ea3c with SMTP id
 6a1803df08f44-6bb98378f87mr5361806d6.3.1722523356148; Thu, 01 Aug 2024
 07:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240731134257.686017-1-admin@hifiphile.com>
In-Reply-To: <20240731134257.686017-1-admin@hifiphile.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Aug 2024 08:42:25 -0600
Message-ID: <CAFLszTiAjodH7P50ryJv7NZCAn5zahT=gBrvs+sNUPX0CDdb-Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] dm: Duplicate uclass name fix and alias
 improvements
To: Zixun LI <admin@hifiphile.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

Hi Zixun,

On Wed, 31 Jul 2024 at 07:43, Zixun LI <admin@hifiphile.com> wrote:
>
> Patch 1 is a tentative fix for duplicate uclass name issue met in
> https://lists.denx.de/pipermail/u-boot/2024-July/560189.html
>
> The idea is to use orignal class name only for sequence alias to keep this
> alias function working and rename the class something else.

Can we rename the gadget uclass to usb_gadget or similar, then update
the aliases?

>
> Patch 2 and 3 make "dm tree", "bind" and "unbind" commands to take care
> of alias sequence numbering. As the alias sequence numbering is more
> meanful than uclass index.
>
> Patch 4 is the actual fix for usb gadet class.
>
> There are some situations where uclass index and device sequence number
> are misused which is not convered by this patch set, for example in
> drivers/net/sandbox.c, uclass_get_device() is used which is based on
> uclass index, while in the comments it says "index - The alias index
> (also DM seq number)"
>
> Zixun LI (4):
>   dm: core: Add a way to specify an alt name for alias sequence
>     numbering
>   dm: core: Show device sequence instead in dm_dump_tree()
>   cmd: bind: Use device sequence instead for driver bind/unbind
>   usb: gadget: udc: Fix duplicate uclass name
>
>  cmd/bind.c                          |  4 ++--
>  drivers/core/device.c               |  3 ++-
>  drivers/core/dump.c                 |  2 +-
>  drivers/core/read.c                 |  7 ++++++-
>  drivers/core/uclass.c               | 11 +++++++++--
>  drivers/usb/gadget/udc/udc-uclass.c |  3 ++-
>  include/dm/read.h                   |  9 ++++++++-
>  include/dm/uclass.h                 |  2 ++
>  8 files changed, 32 insertions(+), 9 deletions(-)
>
> --
> 2.45.2
>

Regards,
Simon
