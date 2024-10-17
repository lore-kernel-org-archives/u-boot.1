Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5319D2F7D8
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 01:15:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 446AD88DE1;
	Thu, 17 Oct 2024 03:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PtSp9pZl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 218FB88E14; Thu, 17 Oct 2024 03:15:28 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50B4E88DDE
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 03:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-539f84907caso499544e87.3
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 18:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729127722; x=1729732522; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NjqXZZyd8KuKlrHtazOg1T9oVNRlz9G4TV0nHSGkclo=;
 b=PtSp9pZl0+XzhIP/6PDepEj37PZdVitCViPzGUudcuL4CPAN5fA4oe1kC6O3R9xiiL
 5uexR9IFMrIbt0SdorJxfFMrEepotziWG3bwI/s73hFJucajStsiQbipJXQcP+x65/w1
 q4jcXNOAQGa/fbwB0hB0Fts32DVSqGmFPpBMWt41DNF7tpZO/jV7bZOpp5A5tWzLzJzH
 1JHST+WmwL7K9M1C4wrDm0i6WIzLezLaQvlJCrDUz2kRlk2g7CSrOP+aggNIR1z6NJmP
 SDicwf3sD87jR1KE3UlyFHA2Kk2TMeWTKph6fIXtXU1YwB6Unfi8WQgK8y877I+sjWCZ
 R9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729127722; x=1729732522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NjqXZZyd8KuKlrHtazOg1T9oVNRlz9G4TV0nHSGkclo=;
 b=HyhyPsVIqMxyB4SoFIuDKRKIfw2WrhEpJRnBa99H9cfjyvTyTLmEC86/kjyqobeJAI
 x3OL+xXoUJyYyy045nk/QEZ7ZWNlNcxFPfG8QqVZfZrH3zPmOwI3mrvuoqGQfcTfyfB7
 Yh3vz9UO9gKU1bMV3J9ELhEKHKScz1/7gts9UMxr48ZMvjLM0Jm0jhKypvhQblShSP3r
 AuN6umSjNH/x1tnr1slwIbMTAX/ktLWCtpjBSndT9ExWVXLb/QRBmLL2LkblMGaAu1Xx
 7LmTS2mjXp1Qn/zlQuYrq3W3vaSweHdH1CmtGwKu5gBJdVv5DEoNc3/bvcSKevWHc/dV
 BIQg==
X-Gm-Message-State: AOJu0YxLtGz88V58ehthRIF+d27Z8P8uCBaZ31UUzkZFPp1z/CQZ8/pN
 Fi4fZXSFbLtAOPS1qQ83u3ZSU5L7NaboMuvpxIPHlRunyz6QPUcoM2D1vYQ35s6v3LjmPjox8/f
 bLGZvHGR2j5mJJsCqZVA80HmE4ug=
X-Google-Smtp-Source: AGHT+IHrfh+R0WLyh0jIgMrtEnjKA+nClX3iRUUBav7YlpN6wZQxNs5zuEbI3IY68E+g+Agw446egUyWNTYThAlPz30=
X-Received: by 2002:a05:6512:118e:b0:539:f886:31d6 with SMTP id
 2adb3069b0e04-53a03f0461dmr4324042e87.2.1729127722243; Wed, 16 Oct 2024
 18:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20241007120002.25690-1-marex@denx.de>
 <CAOMZO5BX3EvcGAJjKNt-vX9+9se9nzmf19_-4f4gfS59C9Q8Sg@mail.gmail.com>
 <d87b9fc8-5bdb-4e16-a219-51d05230bc80@denx.de>
 <CAOMZO5CGjRXC8kqq8FhDW133Eiw0319we+D9rgjvrs14DMYk-A@mail.gmail.com>
 <CAOMZO5DWaBG=XS+GyP-dCy0kXOBQzwq3BWh4P9uZgbJ6ivDagw@mail.gmail.com>
 <dc206c39-f977-4524-8cd3-4d5dc5f3b9b2@denx.de>
In-Reply-To: <dc206c39-f977-4524-8cd3-4d5dc5f3b9b2@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 16 Oct 2024 22:15:10 -0300
Message-ID: <CAOMZO5CXUDd4AZmDEMQ+rA-YJ0cUCgA3epBMd_wiOYybs+1U2g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dts: Add ability to build fallback DTBOs from
 arch/$(ARCH)/dts
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@linaro.org>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Lothar Rubusch <l.rubusch@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
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

On Wed, Oct 16, 2024 at 10:11=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:

> I sent a V4, there was SPL->XPL symbol rename that git couldn't resolve.
> V4 should apply fine on top of:
>
> 608a31bdec62 ("Merge patch series "Introduce the lwIP network stack"")

Thanks, v4 applies correctly.
