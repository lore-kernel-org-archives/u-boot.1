Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0661C02183
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 19:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4691080619;
	Mon, 13 Jan 2025 20:10:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WWXycd6I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B3F480619; Mon, 13 Jan 2025 20:10:50 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 133BF801CF
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 20:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ab322ecd75dso23493866b.0
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 11:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736795447; x=1737400247; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JH4fcOvkmpVgjWmOF9nR9LK3ubOXQfUcrHJmXDmHKm8=;
 b=WWXycd6I47mkzAGM0uHXtAxmvbKHASraKHU5ZMyP3j3w2Jh7pB7kzcQUkeNCWXsliL
 901F7nDiqkJVCZsAWwHTb9sHSR8eoArlZwVzN/ZqEtJRQEgvAABDQ0eY71F+mMFBSzsZ
 p2c09PSrWW8CVcariTIdjjJ1qIUc116Z5onjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736795447; x=1737400247;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JH4fcOvkmpVgjWmOF9nR9LK3ubOXQfUcrHJmXDmHKm8=;
 b=ViXbq8UmqL8RwTanK5+MfGdhDMQ6+4Az9cK6CJGhc91i3oX8xsnAtzJbDrjlhSR74E
 38HnxdNzhV/ITDCfEa1uoR9I6B0zANSUW3uxwW3//k9l8HS/WilEIlEXQSjBke3iQn8T
 2l9DBipy27dS24jcrROILjHJelmGCKOJPj+v4H+8sx2xtxd0TulXXTFX47xGHk8se+I1
 5D/N/NhXJPtoiAQ2aYbDYDVvB7ahDkO2nSHhCOtKthA57zCdYZA68+bXtV8iRuF2vSqW
 sd9lPG0LByfCypGhFkl5b2Y6mNl3ZLJ3WOaF8gyKGlG9tIeAQ2+A/NwsRpnr41ln3nyQ
 qM5w==
X-Gm-Message-State: AOJu0Yxjw3uMowaFcsvNSNVbqVfFyYJmHmb9NnxM3AJvFzyP5UpGnFu/
 Fn2WGqIsIEBjNFRYxNT/PiOaxv1eXoOgkrO/NLPT/vlPbrLR+zf2bPfgUhOWMsYb8Yrda/4R+Dj
 qf7BCLuWzDB5i4O0EEygOdyBDV/WSGmiJ6VbIZOfMWmXJ8r4=
X-Gm-Gg: ASbGncuDRKsOqOM/iTYPnoazcRrz5QMygGW3w9DixbOjzQ3rotJeHaSfnn9uJ/MC6+G
 HyG9guE0QPMIjHv4mfyptAPfuZx2MXDYFR4odxA0=
X-Google-Smtp-Source: AGHT+IHmp+2OI1fnJwbJ55+/ZRwNG5ZrcdyaKzQpASjFEJvgissCGd7JGcjjxvSyEUimcqHEEcIoKzfvMp0f4Bp5Fgk=
X-Received: by 2002:a17:907:3d91:b0:ab2:c0b0:3109 with SMTP id
 a640c23a62f3a-ab2c3d4c85emr1386176666b.21.1736795447282; Mon, 13 Jan 2025
 11:10:47 -0800 (PST)
MIME-Version: 1.0
References: <20250113183409.GY3476@bill-the-cat>
In-Reply-To: <20250113183409.GY3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jan 2025 12:10:35 -0700
X-Gm-Features: AbW1kvb17FcRXfHpXOqS78exOG-tcU99bQOBoTBL-aaE4Xg9GaPvWRd1q-yPG_A
Message-ID: <CAFLszTjDx3bBwgnvB2v6ow70a4-XS-fR5UHFdFQNn7Fdytba8w@mail.gmail.com>
Subject: Re: [ANN / RFC] Regular community calls?
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Mon, 13 Jan 2025 at 11:34, Tom Rini <trini@konsulko.com> wrote:
>
> Hey all,
>
> It's been suggested again a few times recently that we should try and
> have some sort of regular open call / video chat as that might help
> clear up some issues. To that end, I'd like to propose we have the first
> one at 9am -0600 UTC (3pm +0 UTC) via Google Meet. This will be a day
> after the v2025.04-rc1 release, and I'll include a link in the release
> email. If this works out well, we can make it a regular thing for the
> day after a release and also try rotating the time, or having a second
> meeting much later in my day that's at a better time for other parts of
> the world.

So do you mean the first one will be in two weeks (i.e. Tues 28th January
America/Europe, Wed for Asia?)

Here are the running notes
<https://docs.google.com/document/d/1YBOMsbM19uSFyoJWnt7-PsOLBaevzQUgV-hiR88a5-o/edit?tab=t.0>
from the previous series.

Regards,
Simon
