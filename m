Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C969BD15DB8
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 16:32:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0904E88599;
	Mon, 21 Oct 2024 18:32:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OQRDV0yn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0644D885F4; Mon, 21 Oct 2024 18:32:22 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 170C88657F
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 18:32:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9a2cdc6f0cso642779166b.2
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729528339; x=1730133139; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DIDJKRWb1cH4lDJYBto2MTh7jITssmP9GARA0z6Bd+U=;
 b=OQRDV0yn8cZTCNxuGVe87aiD9Czm1iSP9je9K1YvWptIeda/WrUGrUCanxk+BN8QEp
 ks1emydFAzBHwdK1wceIPjBdHv5MlXIQZNBNSMzxF97g+3UL3lCQO1l3Dphkwlu7PSui
 JoryRtfD7qfv0qd3Ez7MvX3hU/v3j0CBYKnOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729528339; x=1730133139;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DIDJKRWb1cH4lDJYBto2MTh7jITssmP9GARA0z6Bd+U=;
 b=PJv+T2WEN+GsDOPqrcht9jfttnz9RPOr+czmD1k9kY00Y5xHfM0O8jj/BZv+ya/4VV
 V6qS4CYc0JrxAD7DSCT8vo3sBD1hjQ+yQlAr3I5hRpgL8NyQyZVCCPD4lxV7giQRBbtu
 q6oqwHDXFXisiX50sFvMgj3p/xk3xle+ySITCql6dz7c0EHBCAZCXbProhXaKUxSxkEm
 SZPyPPe/8v+X6wFFP4l+4cRtYJaHyrOdfG8K7DKW8jEEU1eXkU4fUCj5iHWuAWR8fTV1
 e3KYuReZqY4u6wzZATLZyQtTL3MxeiDA+5wt9WH7sesR9fZ+iIPENu9iNlc4I7lJZlh4
 V0gA==
X-Gm-Message-State: AOJu0Yyw97cG0cwW3e44vgkoQZV3Z2CX3hc1X/Vh8qIAIyK3RIPvt+Nr
 zlggTMPUuYCUvUn/b8+gLQG7qq6pFbVGkEojVYi8GImNKt2WSAqNKWl7ZueKvXRuqidkMZjTi9g
 FnkY9Hk5GHH1ZcMQ6fjU8eDIMjeKY/ylDxtt+
X-Google-Smtp-Source: AGHT+IHXW5R+bsYMSSY63PBgSLcKQKDMLs1h9/ESwcRqvN18aTVxUg33p/wVSRSApUm6mg8DEyvByDu1/dtn038UcwA=
X-Received: by 2002:a17:906:4788:b0:a9a:38e6:2fdf with SMTP id
 a640c23a62f3a-a9a69cdf917mr1121164666b.64.1729528339551; Mon, 21 Oct 2024
 09:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
 <20241016060523.888804-25-patrick.rudolph@9elements.com>
 <CAFLszTh4Z8p-8d8ASrpUTnNdDhmijDm8fcct-wDWR1nRFxs5JA@mail.gmail.com>
 <CALNFmy1=R4vp6S3H3a_3HTDjGufDxu+Heo-vk=GRjb0aj0z0Dg@mail.gmail.com>
In-Reply-To: <CALNFmy1=R4vp6S3H3a_3HTDjGufDxu+Heo-vk=GRjb0aj0z0Dg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Oct 2024 18:32:08 +0200
Message-ID: <CAFLszTjTA98Re5rWXHpMQZADXU7uLbCayxNTtugYRxHZaFUL_w@mail.gmail.com>
Subject: Re: [PATCH v9 24/37] common: Enable BLOBLIST_TABLES on arm
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
 Tom Rini <trini@konsulko.com>
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

Hi Patrick,

On Mon, 21 Oct 2024 at 10:26, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Hi Simon,
> On Fri, Oct 18, 2024 at 1:18=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Patrick,
> >
> > On Wed, 16 Oct 2024 at 00:16, Patrick Rudolph
> > <patrick.rudolph@9elements.com> wrote:
> > >
> > > Allow to use BLOBLIST_TABLES on arm to store ACPI or other tables.
> > >
> > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > ---
> > > Changelog v9:
> > > - default to BLOBLIST_ALLOC on arm
> > > - Move default for BLOBLIST_SIZE_RELOC up
> > > ---
> > >  common/Kconfig |  2 ++
> > >  lib/Kconfig    | 15 +++++++++------
> > >  2 files changed, 11 insertions(+), 6 deletions(-)
> > >
> >
> > This is fine, but please disable it for snow since it needs the FIXED
> > option for now.
>
> I cannot follow. What needs the FIXED option and what to disable?
> I run this patch on the CI and test_py_sandbox tests are still working.

I mean that snow cannot use BLOBLIST_ALLOC and needs BLOBLIST_FIXED so
if you make ALLOC the default you need to change the default for snow.

My lab is still not running, unfortunately, but I will try to get it
sorted out soon.

Regards,
Simon
