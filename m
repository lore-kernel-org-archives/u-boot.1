Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8641CC27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 09:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6FBF8812C;
	Wed, 12 Jun 2024 11:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="V9RDpfMC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20BDD88763; Wed, 12 Jun 2024 11:58:49 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 148E681F9A
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 11:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52bc29c79fdso5866813e87.1
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 02:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1718186326; x=1718791126;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ULyZZfH7lZkFprtTxQIPJ34k5l+Ovw9yOHLw4IG4yTg=;
 b=V9RDpfMC0NCrlrnjljNHdpGhs0knprFBrRe04vqTmEs8biXMhw8kPdhkLrAjUZmVzU
 W+8KUhoMMlnPKwt5fF4f6BdzSMQcBmX+K+yZnSbGpHyLAh8YwMuXywHFZ2Sk110uCQcV
 2OC3t8OMUypbI25ZUS9Wz4I14v3+8ffwPkGT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718186326; x=1718791126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ULyZZfH7lZkFprtTxQIPJ34k5l+Ovw9yOHLw4IG4yTg=;
 b=TmUJoDO751MIA1o4Tg7/lotJV8Mn50TKu7aLbaTmkGISm2h3FIzfqFnJIh6oNbKAxL
 Wwwb7cjG0hhBqJJ+bbU5+CXmVzSZTpOTLqFKeb+Ue0V0Gmrrc0joUYVv0/X4WRWaeyQo
 pFdfc3JfKmGLHS6UM0s8L1UtGzL6H27FD/6w5wPIx0K78/Abe/yV5vBwYOUWkSdFnfvS
 ugmOfQBLxnH+cE+oP1SvRx0ImjY+1jb+2aoWvj15gD3M4sCnIWsQ0nTqLTr/TZtj9n4K
 n1Sqb2Bzh7s2tFelHuZTWIvVLwi9bJcEGdQB7j62K/kKGmuu1fKEyEioC5lyuczpsF1Y
 zBMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyH940E/9huyi596EBVf570O6y8S95sRvJa538IiEpdrxXHIX4wBVZskQfT/lNjHOuoiovm9iDRpGXNMIvdlvlyA/9jA==
X-Gm-Message-State: AOJu0YzDy4Qa2PvmG5RpyOsbWLrkdbi+0KhJJ3akPjvxU/K0is3tR5ZJ
 dMFTk+ZomOGiZH7BXJnYJO9NPIyi2Zzqzpaae6fGZG3bo7OLYTNOgbpZbEovIooqNvLXTSiVmYP
 0eaBWc4JejJ89FBfu5L0IRk3YonHJoZT77xPIcQ==
X-Google-Smtp-Source: AGHT+IHs3V925DcEGqs/dKjHnvQu4x3c2l9YdAOIw9quEWg5rEMMzkldvE6O9zsBpJTsGS9ohExZLkcEpR/1mZjtDmI=
X-Received: by 2002:a05:6512:3c87:b0:52c:8075:4f3 with SMTP id
 2adb3069b0e04-52c9a3e3cebmr1090671e87.36.1718186326184; Wed, 12 Jun 2024
 02:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240603150749.507797-1-patrick.barsanti@amarulasolutions.com>
 <d66b2844-6e5e-455c-ae71-7d511c2b6e81@mailbox.org>
In-Reply-To: <d66b2844-6e5e-455c-ae71-7d511c2b6e81@mailbox.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 12 Jun 2024 11:58:34 +0200
Message-ID: <CAOf5uwnkDi=Q_v8iwWmc-6WrFph3+04NCOQH4K6MGHhe3mNFYQ@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: Fix include directory for OF_UPSTREAM
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 u-boot@lists.denx.de, 
 trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de, 
 sumit.garg@linaro.org, afd@ti.com, bb@ti.com, mr.bossman075@gmail.com, 
 leon@georgemail.eu
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

Hi Marek

On Wed, Jun 12, 2024 at 11:32=E2=80=AFAM Marek Vasut <marek.vasut@mailbox.o=
rg> wrote:
>
> On 6/3/24 5:07 PM, Patrick Barsanti wrote:
> > Always prioritizing u-boot includes causes problems when trying to migr=
ate
> > boards to OF_UPSTREAM that have different local devicetree files with
> > respect to the upstream ones, if local DT headers are not dropped.
> > At the same time if local and upstream files are the same, migrations
> > can be, and have been, introduced without dropping local DT headers.
> > This also causes problems whenever upstream DTS and DT headers are patc=
hed.
> >
> > For example, now migrating a board based on `imx6ul.dtsi` to OF_UPSTREA=
M
> > breaks it, as there are some missing defines in a local DT header file
> > (`imx6ul-clock.h`); the solution would be to drop it, which has not alw=
ays
> > been done in previous OF_UPSTREAM migration patches for other boards
> > because most of the time the two are the same. This solution is also
> > vulnerable to ABI breakage, although this has not yet happened since th=
e
> > introduction of OF_UPSTREAM support and is unlikely.
> >
> > Maintainers assure backwards compatibility for DT headers when syncing =
the
> > upstream folder with the kernel.
>
> ... upstream directory ...
>
> > The problem is that, at the current state, all boards that have not dro=
pped
> > their local headers when migrating to OF_UPSTREAM will break once the
> > upstream devicetrees are patched, for example, to use any newly added
> > define which is not present in the local DT header file, even if those
> > changes are backwards compatible.
>
> Why not simply remove the headers ?
>

If we remove the headers then other boards that are not migrated, can
have some problem
on building. We should consider not only new boards but even those
that ones are still not migrated.
I think that is already described here

> Add a WARNING if there are local duplicates .
>

Why should a WARNING help here? We would like to have some migration
plans but not break them.

Michael


> [...]
