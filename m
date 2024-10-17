Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD807D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0F55891C7;
	Fri, 18 Oct 2024 01:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SolTCLai";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BB1989170; Fri, 18 Oct 2024 01:12:26 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81FC389165
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:12:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6cc2ea27a50so20386816d6.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206742; x=1729811542; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zfmm7KLKt/ue6PkZyYLPDgn605+XpVRD5+Pa+tfXlJQ=;
 b=SolTCLaiwJHgoUE0d/xtDXd6/THhI7DXhjsyuLzhMYKbSm1xwtK0DDN4qed9d2ttKW
 BuxZn42zQcvrGz6/xhcPnOH4qAfWfLNBc1JLh7CsKEwz2o52fwH08W4OXlfTRgtbAccT
 bGGHqY/+WKMINn+LL33u+1IzFK3hs+6Yuew8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206742; x=1729811542;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zfmm7KLKt/ue6PkZyYLPDgn605+XpVRD5+Pa+tfXlJQ=;
 b=GEmb26r8oe/ovAVnJ4h3w/IRNJLkIjfGk6e72roSW6ACjSZlG/NvqVNq/OC4gn/3BS
 CMJgvY0UJcyYRI2TJQawOlrunP2zb3hnuzwEZC/rBRLf2HzXTfIq9qeeQfK4g0m3ymdH
 j1VYTDNyWXqfQ3PzHunEItHYpVjvwLww0uzHa7qoKXrBsQZIPmuSLek2v1kDQ384XoTG
 Iu6SfD7x36obnTtMK2lPug7tvpYj/AykGAvDBZ7gSiMlEIgGLm8a2w1ed20BAWHFAnZ2
 cL+ch1xsq4tCZcPnVb4G/VYr1Bqcwq5YjG8HXtY4y9dybN5qu+y9cszA7btRjsSyGCxq
 DrxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxQTIoFnzBwPEEnbJTfGcTVLiqyRuLOAbcI4l/jCtg3cPAaB/EErt4hs0RN6BqV4k48AZvswo=@lists.denx.de
X-Gm-Message-State: AOJu0YxXem1+BwHPT9k4bCflHCSgu1fpdPpBK3lfDCL52b3H12RBQ0C6
 kY2UmYdcuyg4W8YP0N9Eni1VXp1bYCeFeYQBLX06zoTsQDUUNWy1Lmv/tR0+BSE7OEzHicjn1aR
 mX1CuhVFFG/0at6VYM63iXRnM+zeQ42m+vD2kV+TqNlb4Yms=
X-Google-Smtp-Source: AGHT+IFWNckXtg6A52FQTNISUe2orvHHtr0u/0iRVQQCSBfdUpK8H0urEkoBZqp88JpbftBxXnlvQJBRLs9eJnMn5c0=
X-Received: by 2002:a05:6214:3bc6:b0:6cb:f72e:4eb9 with SMTP id
 6a1803df08f44-6cde18d01a4mr8170116d6.11.1729206742461; Thu, 17 Oct 2024
 16:12:22 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:12:21 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240108153816.GE1610741@bill-the-cat>
References: <20240108153816.GE1610741@bill-the-cat>
 <20240108001455.35638-1-sjg@chromium.org>
 <20240108001455.35638-2-sjg@chromium.org>
 <874jfouq9e.fsf@bloch.sibelius.xs4all.nl>
 <6beec0824542ac0608a5dfad9b88d32a@manjaro.org>
 <CAEUhbmVc06RydZavZHAXS2oBZC=cRt0C801+dxYVYr9qZRvBVA@mail.gmail.com>
Date: Thu, 17 Oct 2024 16:12:21 -0700
X-Google-Sender-Auth: MPLK10dC7-SNgsCg4nwikta5kF8
Message-ID: <CAFLszTh=J7L2yekkhbqZDJxC=zy3T0WiaED+UxDnv8oeccBxDw@mail.gmail.com>
Subject: Re: [PATCH 2/2] coreboot: Switch to a monospaced font
To: Tom Rini <trini@konsulko.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Anatolij Gustschin <agust@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>
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

On Mon, Jan 08, 2024 at 09:09:39PM +0800, Bin Meng wrote:
> + Tom and Anatolij,
>
> On Mon, Jan 8, 2024 at 5:33=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> =
wrote:
> >
> > On 2024-01-08 10:29, Mark Kettenis wrote:
> > >> From: Simon Glass <sjg@chromium.org>
> > >> Date: Sun,  7 Jan 2024 17:14:55 -0700
> > >>
> > >> The default font is proportional, with different character widths.
> > >> Select a monospace font for coreboot so that the 'dm tree' output
> > >> lines
> > >> up correctly.
> > >>
> > >> Update the coreboot tests to match.
> > >
> > > To be honest, I think defaulting to a proportional font is wrong as a
> > > default for something like U-Boot.
> >
> > I agree, it makes very little sense to default to a proportional font.
> >
>
> So we should revert
>
> commit b093753471c1a30d680868a9f4d9f6db090bf0b7 ("video: Add a default
> TrueType font")

Well, I would "fixes" that commit and drop default y there and instead
make the monospace font the default and explain why the switch, rather
than revert.

--=20
Tom

Applied to u-boot-dm, thanks!
