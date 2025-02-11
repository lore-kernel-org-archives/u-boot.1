Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2E3C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 13:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C92C803CC;
	Tue, 11 Feb 2025 14:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e1Js2vnx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBC89809D0; Tue, 11 Feb 2025 14:11:09 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 886DA800B3
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 14:11:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5de63846e56so5828011a12.1
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 05:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739279466; x=1739884266; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aosq7R/988EzB2O4OSgEeG0x+nLgD89FgnSsuag4ubk=;
 b=e1Js2vnxH1UaLiLXBWGzKrTJIqljLDhXgvX5vKISkHPzhL1780P21Npx72liw82Fsn
 VrICfzBGSne1qYIh7+Bm5m43GHyEr+XHS+6cKCnkWIjTq9zJO/phAOr2Zal3Rgxnraga
 JSY32LOh9lXqG6cH9mhCkhbGzjb8ZtUVc8A4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739279466; x=1739884266;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aosq7R/988EzB2O4OSgEeG0x+nLgD89FgnSsuag4ubk=;
 b=jjIMqkugMCCi3bz9Su9wZGtZHmXsf6xeo7ooQsTkUgm+pX15DbXAmu8tv5RRAp8e9+
 S3RBQpoWQVW3YJ47FUGWHMO2Bud7Bg4lozxkuHH9WFabLxwAL666nlLfY+AAiZLC86b6
 pVA0Qx9/eDazO8NCXVOEbT5FmHkyDlMXBCE0Kp1yNFEtIrodl0+IUr9kZ/E4p3J5q6vz
 shwQUPgK4JzEvqwJfiOqJHyjELAbNKzS55Ep54E2Uii03gsOuhifktmjaPgDps0Z9NU2
 9Tbv9GiQMQdZHeWUTy3JraYZhgA/mIhrKuhpNEIppstT9AxHCeEAiQzZFpJT7D8HYL2P
 Sk1A==
X-Gm-Message-State: AOJu0YxG/+rTvqBhJct2wR+vMImu48wYTDnA1n/K+IBIAZRp/4cNGeyb
 LsmlFz8vKMmCBqb+ANdT1ONQC10nwM/tWi3ZueFS0QTghReEWuwP08rhEpA+uywZ++FtFDgNPVi
 nmKGAoW5N+A7FRaikE8VJ96muOH4HMGtZ4sckZYFyQ3V7rk0=
X-Gm-Gg: ASbGncup2bQmP2qmkM1HgJ7tlqKyWKX2eajHWrfTp9r64zVQtWYq3ChyyhKvyCykxBS
 obCJn8N2/hxjGij1XZjhyfkEh4RzDZzhAwcT7W2gD2ntOVy5QD6malyBO93/eeJPQdUeT7zxE9i
 NIJKP5nUreEhjgeJokW3VvfJiNTahcEw==
X-Google-Smtp-Source: AGHT+IEYZoxGoQgg2fJG0GCdzU8SBcqbIn2ViIqoQIatDQcFTgce0wdmU7ekvMM+oABuGwPVKxnql4Zp2AkUiaLWH00=
X-Received: by 2002:aa7:dbd4:0:b0:5de:4add:d52f with SMTP id
 4fb4d7f45d1cf-5de9a4c860fmr2578893a12.32.1739279466581; Tue, 11 Feb 2025
 05:11:06 -0800 (PST)
MIME-Version: 1.0
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-34-sjg@chromium.org>
 <20250210143305.GA1233568@bill-the-cat>
In-Reply-To: <20250210143305.GA1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Feb 2025 06:10:54 -0700
X-Gm-Features: AWEUYZkfM5vIEsCdJwsY1i1WZ-L_Stp4tkjVILC5ihIRCAq5jQ4-2gdJpzEXX5E
Message-ID: <CAFLszTgc2GsN-O_7aq+pC_0xeJQjh-qa7EAnN1i3djp0ZO5g-w@mail.gmail.com>
Subject: Re: [PATCH v2 33/35] RFC: Revert "bloblist: Load the bloblist from
 the previous loader"
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
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

On Mon, 10 Feb 2025 at 07:33, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Feb 09, 2025 at 02:14:54PM -0700, Simon Glass wrote:
>
> > The logic of this has become too confusing.
> >
> > The primary issue with the patch is that U-Boot needs to set up a
> > bloblist in the first phase where BLOBLIST is enabled. Subsequent
> > phases can then use that bloblist.
> >
> > But the first phase of U-Boot cannot assume that one exists.
> >
> > Reverting this commit seems like a better starting point for getting
> > things working for all use-cases.
> >
> > Note: The work to tidy this up is apparently underway. For this series,
> > a revert is the easiest path.
> >
> > This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
> >
> > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  common/bloblist.c  | 64 ++++++++++++++--------------------------------
> >  include/bloblist.h | 10 --------
> >  2 files changed, 19 insertions(+), 55 deletions(-)
>
> We aren't reverting this change so if you plan to move this series out of
> your downstream fork you should start from that and stop posting it,
> that just leads to confusion.

Who is 'we', and start from what?

My goal with this series is to have something that actually boots on a
real board, so the bloblist changes are needed for that, particularly
as the 'vbe' board in the lab tests this on the hardware. I
deliberately put these two patches at the end of the series so you can
ignore them if you'd like.

But for now, as I understand it, there are no users of standard
passage in tree, so actually it would be fine to apply them.

Regards,
Simon
