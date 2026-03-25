Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05727109C057
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:22:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BC8283F14;
	Wed, 25 Mar 2026 20:22:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dsuW99Ey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4420683FAF; Wed, 25 Mar 2026 20:22:09 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D58183DA6
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:22:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b8d7f22d405so29317666b.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:22:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774466527; cv=none;
 d=google.com; s=arc-20240605;
 b=BvOi6yqIAwjDjQJ4fR0x1TBB4Oy2bMURoH5hnKt/UjlxzFXfrKHXXebcq6AsoHM05S
 i45bF4z1zEyvOJEoLWxjwjXolfc9wHdT2azYYA2JC8k9uW+P8jEsVcpevz4WDxzHVPf4
 ev3wuZcN9x068M/5K5UaFT/Te1xHRbSslhj8tp5DUZhq7TjCwARYg33RisU8f3FyOvx7
 OP1PaLfYn8w5pd/6wZ1nMYa1iggfU+lWwNE4xVSD07zrZ00Rmt0ymtkAdmRIS4DANlPR
 N5q/TgvLL3cAtiAiAIEcRcbxZU43L3lRMlD9fQUwy3Uhe7XnC+nha3KXGatMqtke1Fie
 1pYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3ZFXvt1LZVkjZn6Sc194QaiH3N+0VlAnM0sIBLFpHxA=;
 fh=2w8mYF4LuweTY133cjdJkKBJK54+rTD/AxCP+o9GCM8=;
 b=M2fiiRvBJNF4Wmqob4x4lHMbv7UqK5FzL2J6Pdu1SCb8qeu0M2N2c5njcLFVquOXfT
 +wYWMyROFGHtEkUjZcTYRCOvea1iawsNN1Xy8NkmzqKmDOOn//M9KjZTxogLe+1inA5J
 rr2OiIKxoVBmacXGI+6+ameegsTuO1MkMmCYitU4nOHrZrOkfItXoPJfyQPvV9nrOQrS
 F9sKX0/d0htsSGl7nwkKvLGxiLe0LlC6vuJp49pVfmwLmDnjn/XQ6t4HmcQPYYbRvaKg
 iY9qkNrDj9lW8NXGOXnpE0w86gT463TZ8DVw21pU1kymTM82wI63UZNftzMxYgSxQQg3
 aq+w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774466527; x=1775071327; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3ZFXvt1LZVkjZn6Sc194QaiH3N+0VlAnM0sIBLFpHxA=;
 b=dsuW99Ey/SdhrBo/ImuoTX7Rhd/uKSbdSMl51EsE7Tctr1zninxJprnjKvijHTvHLt
 we6k5xLOuQoyCBCFWinZ3YutiMjVWxzuTN2Rx0xer4GtGUxGYgjq3mP+9nSBN1koCFg1
 i9PZ7By0ueQCpw4g8/15Y1i03tZ2rBzIanQb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774466527; x=1775071327;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ZFXvt1LZVkjZn6Sc194QaiH3N+0VlAnM0sIBLFpHxA=;
 b=qBPIhcEthihDuySD2CCmYq5g+dVKEdP5E3xY3pMMVuGtoRjf3AlCXgBPPA0HW9DCt2
 VxNVWRMfbOG3ziuot9WryvSOnXQ+IzI/ANV4H2gU2xuNeAIUkFaQhzfWNzg6C8ztD0hY
 wU38w7AYkQLiygAAjskAqPluvK6h4d2XQ+Rb/NKMNvJ4h79wrnIgRX8d5xZldBI1j0uv
 KMfd2TwIHrUlT/AfllUKQquh3sQe5fVbHH2qUj2cJBcdgx1Zl5TWriFpY9hlsnXJecdG
 yST0x2Yw+SuBBI5nU1aRhquC7jnGm1kJAHbilLyWwvQFC50tolAZqxkiB8z6TOyukVA/
 VYVQ==
X-Gm-Message-State: AOJu0YxQ3QnCqBg8nvpfQoIuPIGMfGEAoEEFqnHuo6Pr9LJ/AGZmp6gX
 O7PKW0brf78fCqchr/arbn3S2R/tz2zKObkJsaLaB7+xNFykIsCjyh4H43oMjcDTKIHBqu+qlMt
 945yWnKd6p0enlfBU6N3f6OIAwJShU67sbPNIt1o3
X-Gm-Gg: ATEYQzwOieEOa8873No5M3kbBi5jjFzzxfNh4PPbEWTI2wfILIWeXOWCa8kzM1/5976
 l61ggCbm6HXiYRsS/Zq+cKbs5H5aVSY7Q70Oe6VBYXTPIsly5ZrLOKK7Adfdh62pqfWpzNynKSg
 H7lMeaNg5sGyQFI74CkftftbFUpT9e5F1g6RyisAfU9Yasl44/XHyAXaaOiEB567RRXKB9ptU4e
 /MzNBQXvqmxAVvEFzj7MMgqaQKC9qt05b3ws7GQI+4HCJROKAlsSnywyQUJwc9PKPtf/uVP8kHf
 Y6ebh1A=
X-Received: by 2002:a17:906:f59c:b0:b99:6133:aceb with SMTP id
 a640c23a62f3a-b9a3f1a5514mr350284966b.24.1774466526444; Wed, 25 Mar 2026
 12:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260325130811.447377-1-sjg@chromium.org>
 <20260325165420.GT502704@bill-the-cat>
 <CAFLszTgZpg-anG1J5kyiYk2JJ3dDiiyvuk5AV_PO+ri_b552tA@mail.gmail.com>
 <20260325171540.GU502704@bill-the-cat>
 <CAFLszTh3NgpY1VQer2wN9-feOvM8khXaFyp+ePhTpqowGK_qrQ@mail.gmail.com>
 <20260325182619.GV502704@bill-the-cat>
In-Reply-To: <20260325182619.GV502704@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 25 Mar 2026 13:21:54 -0600
X-Gm-Features: AQROBzClyivcecOYQ30gZ_vZjpjbUvz69Gepq01ii6JZozy3iPyWlzR5Ul6p0wM
Message-ID: <CAFLszThCO2a1COB8kBwYfTXM65AGJEugo9MWZAjphQNuX16Y-Q@mail.gmail.com>
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

On Wed, 25 Mar 2026 at 12:26, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Mar 25, 2026 at 11:57:17AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 25 Mar 2026 at 11:15, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Mar 25, 2026 at 11:12:00AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 25 Mar 2026 at 10:54, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Mar 25, 2026 at 07:08:09AM -0600, Simon Glass wrote:
> > > > > > The generated .S files for fonts, splash screens and EFI apps use
> > > > > > .incbin with the full prerequisite path. When building with O= this
> > > > > > bakes an absolute path into the .S file. If the build directory is
> > > > > > later used on a different machine (e.g. in a container), the assembler
> > > > > > cannot find the source file.
> > > > > >
> > > > > > Use $(src)/$(notdir $<) instead of $< so the .incbin directive contains
> > > > > > a source-relative path like drivers/video/fonts/nimbus_sans_l_regular.ttf
> > > > > > rather than an absolute one. Add -Wa,-I$(srctree) to the assembler
> > > > > > flags so the assembler can resolve these paths.
> > > > > >
> > > > > > The DTB and DTBO rules are left unchanged since their prerequisites are
> > > > > > generated files in the build directory.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > >  scripts/Makefile.lib | 7 ++++---
> > > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > >
> > > > > This is generic kbuild infrastructure now. Is there a fix we're missing
> > > > > from upstream, a change we haven't pulled in yet (as we need to keep
> > > > > syncing upwards) or a problem upstream too? Thanks!
> > > >
> > > > Linux does this with DTB files in quiet_cmd_wrap_S_dtb:
> > > >
> > > > echo '.incbin "$<" ';
> > > >
> > > > But Linux only uses generated files in the build directory, never
> > > > actual source files. The font/splash/EFI .incbin rules are U-Boot
> > > > additions that aren't in the upstream kbuild. So Linux doesn't have
> > > > this problem.
> > >
> > > Shouldn't we be generating these files in to the build directory too?
> >
> > These are actually source files, e.g.
> > drivers/video/fonts/nimbus_sans_l_regular.ttf
>
> So, the first thing then is that S_ttf is a local U-Boot rule. Lets
> start by moving this out of scripts/Makefile.lib to
> scripts/Makefile.lib-u-boot as that will make future re-sync work easier
> (and is something we've talked about in the re-sync threads, splitting
> U-Boot specific stuff out to new files). Then 2/2 of that series can be
> this change, thanks.

Almost, but I still need the a_flags change.

Regards,
Simon
