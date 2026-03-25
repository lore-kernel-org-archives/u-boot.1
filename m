Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFDD109C040
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 17:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3208838BB;
	Wed, 25 Mar 2026 18:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JZVL/+bq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D806083DA7; Wed, 25 Mar 2026 18:57:33 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E442680077
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 18:57:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b97a9f4b4dcso11286966b.3
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 10:57:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774461451; cv=none;
 d=google.com; s=arc-20240605;
 b=lQNradHkumi5ZfRgKdVGNWYBYbL9P2JHCL9g/TsxCIzubCVZGbmX+bfLHcNz6Zsl/z
 pvkcyJKZPHXQFLMWv92QgeVUK5bcJ/8kPDXWqg4Y8sK5hTf9a0r91mpVJK02fElDxjp3
 PXS05gqx/weNyzw9rn/2C+CbfNvkjUub87LsWJdJcktG7X6cSeJCgbQFnzxftYLnBsH4
 cN6MaGxbY+WhK5jaiMxZjiaWNUcHW2/7HoWDsF8dIk6zTledc7Rb2et3P3IGabxO41dO
 /pliGu96EE3O15S5COYTR3i0XwBc1Ramx6xzG5wT3psLcWrZ8JA+t41h0qSoxcdeIcRI
 siMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jMH/3LuUkMAf1hXUDChbjBc2T9xYD/O2G8JI0YneVjU=;
 fh=2w8mYF4LuweTY133cjdJkKBJK54+rTD/AxCP+o9GCM8=;
 b=bKWfsNHFpe8Kg259boMbFDuZhahL1QiwfLP6/FQZouBOEd+IJFK+KpxrXB0X0W+fyF
 FnyqvYNzSdzBRFRy2Q4gx5sT9yHoqNy8Zm08rFxjEMPbWkj0Plj6bs4H4KGoxaQZbmr1
 CBETho9WcW9dYSpIpM32ON8JMIFEAyaneHJayjfo9kMTedGIVQpQMgVLpDTieKZtfJXx
 cngidzMOtG3tmHJmFc4mXWNal3XnOX+U6g/+tMln64Od/tzn2SRxNfgKkL+UgTB869VO
 EBxgGDvhSA+fyPlxCyyBQboDjh0rSjfl+E11HbY4+2XFYmR5iglhSOYoyR95onqjYiLE
 9vqw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774461451; x=1775066251; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jMH/3LuUkMAf1hXUDChbjBc2T9xYD/O2G8JI0YneVjU=;
 b=JZVL/+bqpD6Spdr4XUGhalGQWLaMbq1MOfFhe9+wK3vijEKzIZQi7pGRk0xt8HEa+P
 m9XkGRMJHHUUyi8Q6PuQEnLoReROr4JdXSLPjvSKufkcKXfJg6nMLYXOdThEXLwq5QPv
 5eSayYIjd9/E7esnu3RCm8UOVTGZ/V4K+K/FY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774461451; x=1775066251;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jMH/3LuUkMAf1hXUDChbjBc2T9xYD/O2G8JI0YneVjU=;
 b=SZ1cqAGulz9sChDdtPGTBWOqJtn4Ib0aqB4DLzAG4rxG7n7sWqGMVnV+7Uq1P9XVmM
 h8npq6jrp+A9HrJpFQ//Bd4WefD9fpIlmgIwuMiIT1LCRq05ugoSaIay+vcMmZt6m3To
 GMuwUQzcKBIXeT3W9uNVeWn2PqTlCJDIK2OfN+iTOXUaVW3a9uyBGjdpe48HJ+3HGKua
 GlxND08snEVR33DXfiMWZMvANjZo4mof8t8OxQzfch9ICXccYNfBpMGdClo4avCpvAMJ
 db5mjJkgDNdoTq40FPcKXQMhhLS0+UnwesJFwvjdbKexAJt8yLcgi0duaLibpElrkwOA
 DK+A==
X-Gm-Message-State: AOJu0Yz0wuPfSbLk7V6DV/LStEaHJeRVyy9iPz8V6+GxHdHlOcfHExJl
 wiXbD6NaC+g7zLqyXNg6PNS/69hFjcsIW8WfRNpIZ/4LQAwSFP5sVqmsh8oM3kTqm8GgT91oDPD
 bQS19YT8fWfUt21SSVu7sjlR3CRUfQ1hlk9Fih75d
X-Gm-Gg: ATEYQzyMxJnbMknQq7W1oHtB4orIGsgDAdIA22EKdU4gVtxTaotlVCu6VXjJ1m6IQOB
 wccr1+KPwrAT3mQFb9lKu0IK7BYmH35yJ2rt4tQn8bjFzIJlySHXR8cdc8HQ4nmC7EYe0uko909
 AIQdY+oRUlTosh8D+PqoC47YVFNwtUQeuHD6gxdq7iSFihZNjsdTJlM067T8ogGZ2EyDgmlhWnt
 EfykMYst49VyHgfK9dTi6cl5EVB2DQvGCE5MHrWTCHSTtJiSHavO03eh86fsxFJhEoM0S5Hp/Ia
 S8lMI1E=
X-Received: by 2002:a17:907:6b8e:b0:b98:235b:4dfa with SMTP id
 a640c23a62f3a-b9a542bcccfmr287593966b.47.1774461451315; Wed, 25 Mar 2026
 10:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260325130811.447377-1-sjg@chromium.org>
 <20260325165420.GT502704@bill-the-cat>
 <CAFLszTgZpg-anG1J5kyiYk2JJ3dDiiyvuk5AV_PO+ri_b552tA@mail.gmail.com>
 <20260325171540.GU502704@bill-the-cat>
In-Reply-To: <20260325171540.GU502704@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 25 Mar 2026 11:57:17 -0600
X-Gm-Features: AQROBzCKjupKV3dbGe5xhWwMLIn42kt9VQd2mzcVwyMgrfS8y1dN4CNE9jMeoGY
Message-ID: <CAFLszTh3NgpY1VQer2wN9-feOvM8khXaFyp+ePhTpqowGK_qrQ@mail.gmail.com>
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

On Wed, 25 Mar 2026 at 11:15, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Mar 25, 2026 at 11:12:00AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 25 Mar 2026 at 10:54, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Mar 25, 2026 at 07:08:09AM -0600, Simon Glass wrote:
> > > > The generated .S files for fonts, splash screens and EFI apps use
> > > > .incbin with the full prerequisite path. When building with O= this
> > > > bakes an absolute path into the .S file. If the build directory is
> > > > later used on a different machine (e.g. in a container), the assembler
> > > > cannot find the source file.
> > > >
> > > > Use $(src)/$(notdir $<) instead of $< so the .incbin directive contains
> > > > a source-relative path like drivers/video/fonts/nimbus_sans_l_regular.ttf
> > > > rather than an absolute one. Add -Wa,-I$(srctree) to the assembler
> > > > flags so the assembler can resolve these paths.
> > > >
> > > > The DTB and DTBO rules are left unchanged since their prerequisites are
> > > > generated files in the build directory.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >  scripts/Makefile.lib | 7 ++++---
> > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > This is generic kbuild infrastructure now. Is there a fix we're missing
> > > from upstream, a change we haven't pulled in yet (as we need to keep
> > > syncing upwards) or a problem upstream too? Thanks!
> >
> > Linux does this with DTB files in quiet_cmd_wrap_S_dtb:
> >
> > echo '.incbin "$<" ';
> >
> > But Linux only uses generated files in the build directory, never
> > actual source files. The font/splash/EFI .incbin rules are U-Boot
> > additions that aren't in the upstream kbuild. So Linux doesn't have
> > this problem.
>
> Shouldn't we be generating these files in to the build directory too?

These are actually source files, e.g.
drivers/video/fonts/nimbus_sans_l_regular.ttf

Regards,
Simon
