Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244A7E67807
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 16:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74BD389030;
	Sat,  2 Nov 2024 17:32:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QkVJBwt3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F58B89066; Sat,  2 Nov 2024 17:32:03 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27EAF8901F
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 17:32:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5cec93719ccso963673a12.2
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 09:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730565120; x=1731169920; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=prR9isRLQzh4IhmPNUwiOrm+H6xOcq/UEQYX1ZIOHbw=;
 b=QkVJBwt3FEnp1bpob2uDZKaziowrfSWg4Y4bI58OQRKT4uNmunGeY8WEdhpY/xoJOt
 EGf+9CtsgUJi1vxvXObYy+I/PCal/Yw+JrO7Lq16r1r7Xp/nHsfmrFYdkcqx5nuAU7UG
 xT2Oj6i349SBXaYGJdD6upi0zWRHJnxvtMPHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730565120; x=1731169920;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=prR9isRLQzh4IhmPNUwiOrm+H6xOcq/UEQYX1ZIOHbw=;
 b=S2dsEhLNlu9Gl4fA0TYBa+veno78DgSUdXVs2Ph88xkZw0JXNfDHBgB76LcKlBtpzj
 dqFzrKxy9tYNaxn1zYt+zNhKfA8dU1seXXspw770XJDEuREKarGpKwgnxi2yeD3QwbT5
 4JHpSfb6SKRuEHxQk8f6tQFvzw0klcq0zw5a0YV5Dsklc47d7Jtxfl/Ru+UCsULZDvq9
 FrRXM1IvE7B6Oh6BSalIlUxjrgt6G2PX0LTE7OtEafyizTz85HUGqoKYTOYQ05cPbPKG
 Yis0NYtF15HPV8WoB38sYlp0MjJ7l4W2Hus5FT1yAES1/CwuMSGAc4NoHtA/tmhec1iR
 +Fyg==
X-Gm-Message-State: AOJu0YyCo6Qv+lOvRShLGfOq3yPSBTkhKEqpeXJ6gW/br3otWzgB5qPu
 uqAMB1VMbQgJ6Icf1COtZifYZDLJrU2ssvtcOb5FeLkgvvR/yxTdK3g2AfqjajrM/sho7Usw3qE
 Uap17ofxwryGAF1TK7W0dsznckTuWgImidS+J
X-Google-Smtp-Source: AGHT+IHb7K0bw6JYKNhoncBla9e5sXHuuWWkQf77t00B/sChqfTB4zZgccsHe/TU1/fpKQ8x4OS6MJV9QmjCk+67AwY=
X-Received: by 2002:a17:907:9728:b0:a9a:4597:a7f3 with SMTP id
 a640c23a62f3a-a9e3a7f435bmr1433677666b.62.1730565120091; Sat, 02 Nov 2024
 09:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-3-sjg@chromium.org>
 <20241029235303.GC2558755@bill-the-cat>
 <CAFLszThVsDEaFr2EYbfBi3u+MLp5D+OW7HkQKAgeJaAoei6gAw@mail.gmail.com>
 <20241031183416.GC3600562@bill-the-cat>
 <CAFLszThHJ8vbL1qsEoL7sh82TFftcVL9LPn14685i-ybkHq9Pw@mail.gmail.com>
 <20241101170847.GR3600562@bill-the-cat>
In-Reply-To: <20241101170847.GR3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Nov 2024 10:31:47 -0600
Message-ID: <CAFLszTh8G6u=r0RTjdTchgqmPOaLMsfsOvYrPnqLrNd50VXHZQ@mail.gmail.com>
Subject: Re: [PATCH v7 02/11] test: Release board after tests complete
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

On Fri, 1 Nov 2024 at 18:08, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Nov 01, 2024 at 04:33:47PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 31 Oct 2024 at 19:34, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Oct 31, 2024 at 07:00:14PM +0100, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 30 Oct 2024 at 00:53, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Oct 09, 2024 at 07:51:36PM -0600, Simon Glass wrote:
> > > > >
> > > > > > When a board is finished with, the lab may want to power it off, or
> > > > > > perform some other function. Add a new script which is called when tests
> > > > > > are complete.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >
> > > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > >
> > > > > But please note I don't see an up to date version of the
> > > > > u-boot-test-hooks side of this which would include the release wrapper,
> > > > > and presumably files.
> > > >
> > > > Please see my patch from late August "Provide some basic scripts for
> > > > Labgrid integration"
> > >
> > > Yes. There was quite a long discussion on patch 3/3 and I'm not 100%
> > > sure where the next steps there are on what the next iteration should
> > > have. If the release script was it's own patch then I believe the first
> > > 3 patches could be merged today and then that leaves the actual labgrid
> > > stuff that conflicts with my setup to figure out.
> >
> > I tested my patches with my non-Labgrid setup (pyttest, tbot) and it
> > still worked. That's not to say there aren't problems, but I am
> > hopeful that it will not affect you.
>
> I can re-name my scripts to labgrid-trini or whatever, sure. But it
> wasn't clear if what you were suggesting was flexible enough in general
> for how others setup labs too.

Well I can rename mine to labgrid-sjg if that helps. It makes sense,
since we have two ways of operating.

Regards,
Simon
