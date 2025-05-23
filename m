Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78955C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 16:33:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BF44832D8;
	Fri, 23 May 2025 18:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OagOszGN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEEA4832D8; Fri, 23 May 2025 18:33:17 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3BCF832C8
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 18:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-601ab204085so2022438a12.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 09:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748017995; x=1748622795; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KG3nl3pG8TdfJZKVi14ULXR0XOW3NuKNwOr0/mnaQm0=;
 b=OagOszGNfcv/uoDzZG2J98ci2HJ4ndTHiYDIkPa2LAty8ct0CG+8WN+9jXrZ9x1Fbo
 JGEuLwNjHWoGAHLR2ejtbntu680Ay6e75N8PKSxCgo6rh9FvUdu95cTyGI5Vkg78eCQw
 gDVKfiQY3cMrdkW57XF83kncmyA86E4bl/zno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748017995; x=1748622795;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KG3nl3pG8TdfJZKVi14ULXR0XOW3NuKNwOr0/mnaQm0=;
 b=dMquqgS304DsbhrSvLOSbhMZkPq7xl2qTNGEP+ubh46eRZjHk15MPxUufO+RfE0ImH
 jfK30reX41Mj9hfiphzNo+Bg8L4BDaFOOl/hUgAGqFunjTDlNXMmagG9gOgHaaIW6ra0
 8nIjZ0D6iPFITl/PCsowsSnX8r6cEie/knLLo1fr/CV5ieeyZ4byba2vLvmkZPHHCrzR
 Yb8ZNX+ScS3W5sue+mH7s2UrI8FyAnTWIcliucEyaSiLFhcLDiGbve3xXScSB63YjmvW
 IiHbDiUNoi3JgnWb5NVzhWHTsLqfS2slEW1oJRSbdkpRTz6DEtLKxuiIW3vfGhBZ0V1O
 oosg==
X-Gm-Message-State: AOJu0Yyxq7eXlkDt/YC+2zNcRM6LrDVv/O0AVhFRNX1uxmDrDBsYGiaf
 FXyQo6CBwyRDenhXeVt4bq5oiqvCbUI8aLxb/bOfs5dmBscvj2cyneXwPKHLPVVJiT/eVEHi9Aa
 DZOq0WoQFw+AmwHnmPZBXN2+Y+8yTNOtIJGMhAQZo
X-Gm-Gg: ASbGncuzq77H87cEY0KrgwmKkF5xFhanESE0a+EZXCgsl3NZhI9Z+QoJFrAKzmaZrhF
 gJixUDdZpLZ0N8kbrf1P00+dNEdJSYL1UcdrZt7vZqYEntAqIPx13pOn4oyWQRV6z6KOVTUs30G
 hFnWWXHInwzBW6oQEcz2RaILCgGc/wXjFhUI9DbrEmST+Hoxt/9wxquQ==
X-Google-Smtp-Source: AGHT+IGydfN36favuknCLiMhWURbtKgYMuQIA47i0+E+DHx/mUH12ViMYraS5oRNam+z2JeglGVOPXCoQzi86wmyL7Q=
X-Received: by 2002:a17:907:2d14:b0:ad5:fae:54c4 with SMTP id
 a640c23a62f3a-ad8596d9822mr16402766b.4.1748017995011; Fri, 23 May 2025
 09:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250504132356.2317305-2-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
 <CAFLszTi6LwvSoNtThF5DzKjJNFzJxB5rk5DjYi9wzsfkiwwjcg@mail.gmail.com>
 <20250523140455.GP100073@bill-the-cat>
In-Reply-To: <20250523140455.GP100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 May 2025 17:32:36 +0100
X-Gm-Features: AX0GCFteJlDgkllD1af2n2ItuFVZmyldohKFy9jYPvAN8LT8mXPLFd1Pib4SwWE
Message-ID: <CAFLszTj1v7dhvdj9vM70OP=Bb8j3FArYHS3SGcpnJO31z3Ns1g@mail.gmail.com>
Subject: Re: [PATCH v2 01/30] patman: Move all non-test logic into control
 module
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Fri, 23 May 2025 at 15:04, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 23, 2025 at 08:19:30AM -0500, Simon Glass wrote:
> > It is easier for tests if the top-level control logic is all in one
> > module. Create a new do_patman() function to handle this. Move the
> > existing code into it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  tools/patman/__main__.py | 49 ++----------------------------------
> >  tools/patman/control.py  | 54 ++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 54 insertions(+), 49 deletions(-)
> >
> > Applied to sjg/master, thanks!
>
> Odd. I thought you had posted this against master or next, intending it
> for mainline, which is why I assigned it to you in patchwork. I see the
> cover letter is missing what commit it's against. And instead here you
> are once again spamming the list and with messages about your personal
> tree. Why?

I'm applying it to my tree and intend to send you a PR at some point,
with collected tools/ patches. So I believe I need to send emails
about applying things and update it in patchwork. Let's discuss this
in a future call.

Regards,
Simon
