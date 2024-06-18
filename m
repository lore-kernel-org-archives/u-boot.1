Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17CAC2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 12:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B891488307;
	Tue, 18 Jun 2024 14:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="di540vtT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14B5288356; Tue, 18 Jun 2024 14:44:07 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 847CF88354
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 14:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6312f1f83d9so40066357b3.2
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 05:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718714643; x=1719319443; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QmEGWyV/CzqBEg+uHswYpoq0MhVBQXxeYjCihdVptRU=;
 b=di540vtTcaypHzg6oO1kUL2Vbx0lcASMs9pz88zFNnwX0iE+aMAM7W0dLZ3aGj9Rn/
 EjhwaJgCCL+EkRry8FN5Nb53zkQ8GgRgFS1Yyb4ppslUIypwO5ySfdBt2qoFaiJiGz5s
 PAgnlezLlSFeNE3GQtySQvjkN2gaEJ6uDJogs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718714643; x=1719319443;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QmEGWyV/CzqBEg+uHswYpoq0MhVBQXxeYjCihdVptRU=;
 b=bRT0Cq7WL6f2hNMWSHnZUYNAfK9cj+RRumUy2HIiKEw5dsq8HFpRLWn6TytAbzgLBD
 cSb5owOGnjvCFD/NaUUUgwe2Sdq87uAX3opv7LitaurjsSQFJX9ZmFaG8pvh4dBQWkx4
 FLsfbbHDBWfkgNcxIf5OLFF5UTOok1GqKo5bx+KKYnUw9/T+MwV72ZwFqq+qO4aedEU5
 d5pwc2qBe3FVeYxhTNpvl6qCLHtO18UoSKfH2wJdETpOu+7As+qMEQR1caNH7ArxXkj8
 16UqpWAuZBXddYXjOqatO+thLJT3DtHM2a3bv22wCaqNUnaLywflM671/dyO6i42J8a0
 EgWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1/wjRWKZhmm00uXrgy8mJMwk4nnZCkwIH6eqG9E1txhmdfMW/UltEwXy7BS4TuWuItqZoqtjjG4NmPgXBTuRS9Wk/HA==
X-Gm-Message-State: AOJu0YxGperpEhxORM3ImwmP0dMHlybLKHUi5LchAEHPf7n9LpxR/Mro
 jJsfK8BvZhxkhy/IJkHw0vT3pB0AWKKZ3OIHPmRQ8A4zVLN1U9LV8xbzIKh5dqHe+OD8KdIexFM
 j/eaaKnJCo9mGA0Gg1+RdnMxagq2Qm7g1mCgy
X-Google-Smtp-Source: AGHT+IHgMEUr34ol/NC/rcD0dcEBKcBaK3vShEVqRheV6Lg9d/QQtEtfWDkibiDuzv0iH/DaIRfEJ9ODXzpOBitJMZw=
X-Received: by 2002:a81:e54c:0:b0:630:b6f6:33bd with SMTP id
 00721157ae682-6322235daa8mr109024787b3.1.1718714643380; Tue, 18 Jun 2024
 05:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240618060546.9681-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240618060546.9681-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 18 Jun 2024 06:43:52 -0600
Message-ID: <CAFLszTgft5spNgid12mVLWiQ6jsSya3zQEQMK96-Gpb1huAVfg@mail.gmail.com>
Subject: Re: [PATCH 1/1] cmd: link to doc/usage/fit/x86-fit-boot.rst
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Tue, 18 Jun 2024 at 00:05, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Replace the outdated link.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
