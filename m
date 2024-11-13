Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6E1D462CF
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 16:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C2E188EE0;
	Wed, 13 Nov 2024 17:03:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YgRMmmro";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5BED89586; Wed, 13 Nov 2024 17:03:50 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB93C88DFA
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 17:03:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa1f1f2d508so195201766b.2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 08:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731513828; x=1732118628; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sEUePyulAtBttEBj3pDuZ0c0e+xTxdthhxy03UT3KGc=;
 b=YgRMmmrovhsctDomoNuExb4i///UVepsjtjXpAiX8CtNT4Alz21uwGvU0dbuRFtVAn
 u11b9XkCQsyh26TAgHrtWpXkNPVgBfguHSQ1ovpto1Jd3vhTMMfmTtg89FyGm6EIffB0
 nmhSuaGz9QLSvrk3DT3JqUmKK5+UemcDWEfxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731513828; x=1732118628;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sEUePyulAtBttEBj3pDuZ0c0e+xTxdthhxy03UT3KGc=;
 b=SG/GpAoynu9079gVti3FTudG6DXLg8kpfwHn01K1qsXK9sX0GRX0ZqiAG9CMVaqsCU
 UB1WF7YP/4+9mGd1Sz3QZv7G/uqoNJIrGp0s1KbeJbmLTJ1fD8GejpvwAG+VijSDy6Iv
 T/qOqIDHTvtWj8BMl9DcoCxMfcTtAbo+lPGZIAHrZ9EVxLtEJjwz/AMj1pvh9LgdBMUn
 8R0oJbxohzL1PKwj/XtWh22rgxTvvxacv/18x4CFUJqps1FAp/Yd0uFUvVlNifoo1Ddh
 ctYuI5s9My4VkT0GGK0P/LML8kId97wKaG98Mc0KiTVZxKQ+4ctH8hP1B+6GYctWvcM/
 lOcw==
X-Gm-Message-State: AOJu0Yyw+tMyxMtotFIq9x56M0gjbcsw3l6QPaA/wsc/i2sM3V9KABe0
 WGlrlbMpKF/z19gBeEZDDS0DdW7WMFhL9MNxq5vAz5ZGviUbAT5NFt5LNedracZ40+khnurPEPa
 rP/+V1jGU0hedJK6X6+S7yuRcihG51lk/HRlxf9E0JfqyVMc=
X-Google-Smtp-Source: AGHT+IHYSesxc/iy+PyyywSYVP8oBlREvf+vDhzX9MaAhg30HyOFn75A6cZ454bcizbOnorCcmaFQAxfMYhTY0n9v5g=
X-Received: by 2002:a17:906:ee83:b0:a9e:6712:c27 with SMTP id
 a640c23a62f3a-a9ef0048e17mr2043689266b.49.1731513828023; Wed, 13 Nov 2024
 08:03:48 -0800 (PST)
MIME-Version: 1.0
References: <20241108152350.3686274-1-sjg@chromium.org>
 <20241108152350.3686274-9-sjg@chromium.org>
 <20241113024029.GH3600562@bill-the-cat>
In-Reply-To: <20241113024029.GH3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Nov 2024 09:03:35 -0700
Message-ID: <CAFLszTirek2=_j15W5LCZERTs2TZXawV0o3aGO12dgDJpzTdQw@mail.gmail.com>
Subject: Re: [PATCH 8/9] buildman: Propose a format for extra boards
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, 12 Nov 2024 at 19:40, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Nov 08, 2024 at 08:23:49AM -0700, Simon Glass wrote:
>
> > It has become more common to use config fragments to extend or adjust
> > the functionality of boards in U-Boot.
> >
> > Propose a format for how to deal with this. It is not implemented as
> > yet.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> I think that the first problem is that this patch series is an
> inappropriate method and place to start the discussion.

We had a discussion a year ago but it trailed off.

>
> I also think this gets things backwards as the common case is "make",
> not "buildman". We need more defconfig's that are just base +
> fragment(s) if they're important enough to be a combination that needs
> to be tested and work. A board is not a time-expensive part of CI. A
> pytest run is, a new job itself is.

OK, that would work too. It would also avoid the problem of combinatorial
explosion. But I am not seeing people actually doing that, with rare
exceptions.

Regards,
Simon
