Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EE1109C049
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 17:12:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E8EF83AAB;
	Wed, 25 Mar 2026 18:12:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OqkVUuTs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5842783CD3; Wed, 25 Mar 2026 18:12:18 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55BCB83A41
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 18:12:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b9358bc9c50so8488066b.1
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 10:12:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774458735; cv=none;
 d=google.com; s=arc-20240605;
 b=lgohFhOXFSVRHzIaahmStOu8zE2WJq18v1HbsQw1uPWJ4B2MKTUGSz6K7uu3I3QJuX
 7On/fzoQQmevE6jTsyBjonyA+6MgBK0A8gzYAp7rZTSxFXKC1Wy3OLA6mh5athrhEtZO
 6a2r0uWyhkzuBvVmETH5lIrtEGnevogngRQ8D71fQ9ROIAzr1aJgvcjuvfKf5CQzvBnA
 FcUDQnzfP1beAt8dybb6luETogiM3/b4f/gFnJVoBVVOTUuEsmHxt0zW0t0N93ute9ex
 z3rhLzyEsBdPcCOgzWE5q24d3qd/Avk7iscRkoPFTYvCpDmSoz8JgmYHxzgDiVHzJWaL
 QtBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=o+/BNoINvYLTGSfhMXhOKhgxJr/KRaweO0u/TT819Dw=;
 fh=2w8mYF4LuweTY133cjdJkKBJK54+rTD/AxCP+o9GCM8=;
 b=RpGWNYldEgQbx/hac30xR1DmBErG9cREItJuvFCYviHvLFj5A2tLc529U8ltYhbUp5
 8vkIUpboyU4As3eJTaNI9/h6AsBABVfyZLWicww91Vyw7uyMqG0aO0iupfQoIEPO8b5r
 Y8XvptPJ00F42nrpVctb7Zb8aG68/A5wib/khMe5pJlfUkRTctbdK42iUp3fKsnyLYP1
 kC26zAf/e20DzUwY03wQamrIa2mnmPktrcbQUX+nGAQB6MMVZKKSBRPYTgNXx64JWLUH
 Ydqkhsvrpg4xXAcUw8OhFmBsuK1N6ToMzNku9WWUHVqc37JyEGzFwHqp04pplNM4CJWm
 JseA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774458735; x=1775063535; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o+/BNoINvYLTGSfhMXhOKhgxJr/KRaweO0u/TT819Dw=;
 b=OqkVUuTs7d4JLo4zcUSfeVs0o25APCHFT0vmTbTtSuAMgTjkEWjwUHjD6aq9EUlOY+
 IXJLM2gs72x6os2AE8bm5+aELNxL/JroUyLL4o3SHqJqDX4lSFtZYPQPekMk7bPloBOU
 UihbDgG/3QCjH5oyHBJSI+8Z3U0CzLSmOoT1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774458735; x=1775063535;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o+/BNoINvYLTGSfhMXhOKhgxJr/KRaweO0u/TT819Dw=;
 b=sEwPlKyDK2t/MhZ8Im8J9/n4FmeVrkXGmAD0FmAof0/oUxOT2nCWEV1JMM/dD2uxZm
 xv3x1jIz1avn6RViuIR8z6eMZijHr3ONUtqT8vuog9OCMxSTazPRmKGT/HQFjfyY5446
 NyffNayWpL8e9k9x9Q5X7XfjB8Wwu43AW3c08n9F29iiCfhswQxpvaaxGDBtw5nU3HzE
 IWBBIA/DOQ1QpgrmyIR5xU4nJa07jBomHDoxWwo8kHQsfbEIpIgZYsRkiLwiYuMWk4YC
 1sXCQxnYgBokXxBR5bb2o9qUUe3Wq9mGLj/HtPjVXny2K84JHfiHj/GD2trb1g/uXdAk
 lMoQ==
X-Gm-Message-State: AOJu0YyOGAQMow6iwYdNdlLAra8mZK6t1yH5d/J71aXGkScHMEG7lN94
 MZQZHc3LHKGkhSHqxR6VJDO9CgcxkQ+/1ScaEzWC5//lFcHlW85AV/8QXaqGV7dM3wEQ3N73dC8
 9ryCdivh0CB1qm0uRRxg492dD+6v2kAsPn5YQBur5Ur1E/Dc1JHpilEuS
X-Gm-Gg: ATEYQzwAUmT5FBIsjqnmFyPk12ubgehPnvttxpADlJL/rA3HPWiOVuuK/1W87tutQt9
 c5VkhNmNrI/feJIX8oX3szwFpdvF90qeWdUr77o+JL0bK0+oDRNXrzjr3GYoIQvXEuOfABR2g9o
 2hmEcWzxGazyj9tuUrOjLJj6ZNPDa8StiMQ81ipSn/WKEtQTgQ/QcRlOf8+ymujne89aQVDtHn5
 6vR44S93xooJNCI5yKJ9JOoM1V0ESiT+4VJH8bvwF9GWfcbMZJZ4xhyM0xGje12Zs6QFWRK6KF6
 7RFjIkg=
X-Received: by 2002:a17:907:3ea5:b0:b98:e4:6d1f with SMTP id
 a640c23a62f3a-b9a542833a1mr277009266b.40.1774458735173; Wed, 25 Mar 2026
 10:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260325130811.447377-1-sjg@chromium.org>
 <20260325165420.GT502704@bill-the-cat>
In-Reply-To: <20260325165420.GT502704@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 25 Mar 2026 11:12:00 -0600
X-Gm-Features: AQROBzCO-ejDFuoRm6ruaiuqqmCDZrN3apcRxRaejGuVLkBSdLg4Fq9TX1VEYbY
Message-ID: <CAFLszTgZpg-anG1J5kyiYk2JJ3dDiiyvuk5AV_PO+ri_b552tA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Use relative paths in generated .incbin directives
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Sam Edwards <cfsworks@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>
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

On Wed, 25 Mar 2026 at 10:54, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Mar 25, 2026 at 07:08:09AM -0600, Simon Glass wrote:
> > The generated .S files for fonts, splash screens and EFI apps use
> > .incbin with the full prerequisite path. When building with O= this
> > bakes an absolute path into the .S file. If the build directory is
> > later used on a different machine (e.g. in a container), the assembler
> > cannot find the source file.
> >
> > Use $(src)/$(notdir $<) instead of $< so the .incbin directive contains
> > a source-relative path like drivers/video/fonts/nimbus_sans_l_regular.ttf
> > rather than an absolute one. Add -Wa,-I$(srctree) to the assembler
> > flags so the assembler can resolve these paths.
> >
> > The DTB and DTBO rules are left unchanged since their prerequisites are
> > generated files in the build directory.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  scripts/Makefile.lib | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
>
> This is generic kbuild infrastructure now. Is there a fix we're missing
> from upstream, a change we haven't pulled in yet (as we need to keep
> syncing upwards) or a problem upstream too? Thanks!

Linux does this with DTB files in quiet_cmd_wrap_S_dtb:

echo '.incbin "$<" ';

But Linux only uses generated files in the build directory, never
actual source files. The font/splash/EFI .incbin rules are U-Boot
additions that aren't in the upstream kbuild. So Linux doesn't have
this problem.

Regards,
Simon
