Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A710DC3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:28:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFCA388875;
	Mon, 29 Jul 2024 17:28:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UPUonYVG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4F6B88875; Mon, 29 Jul 2024 17:28:32 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDA2888852
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:28:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6b7a4668f1fso19853106d6.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266910; x=1722871710; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NZkgutDolLzr/aBNMcadaN0Wsea1+JPjiKUXtJ+3Pb4=;
 b=UPUonYVGPY9WMA0ylRqQ5Sr7v+mXkX4UOPqEDbYZHL6KXIpwCV7C2kbOHm/iW2tIhQ
 8Y3+M7zJdO7qzb4IMw68Obs3jiZFeKtN0acnH5yplwA2ara3T7jrhj2IEXhl8SbHX60D
 DIVuDYRIKnZxnBt1vyH7hnNq+EPm8xEAw3iMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266910; x=1722871710;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NZkgutDolLzr/aBNMcadaN0Wsea1+JPjiKUXtJ+3Pb4=;
 b=RB0BWZbCBMJWs1s53NjNwx1WOe+FpHPPEnYSUPYc6EKRzskiuKpbdwAKssWFcftqbN
 d2X0wyDFuCzvjA0vonzYEsuiGldHNn5QBHb8vIVbAFqzWOnBN2daAUXqcAAHGbn7rC7B
 Z6TCX/nD2TwrK9JjLMBp8mtlkgqcl/KEQnwlMyj7sPCXvrnrdE6aPVaemYwDGu7WeduD
 Jhrtl0IyOd3JgVWVqS1wtZKSCFjk1BLmIcezxwhTd2bBgwfGacZ4vCB7P409eiU7qdgH
 CIHoJGS+SY1Y9D+AvrznpMqUaE8STKsxXUVBngBgyXo5QCYM7r9QpRRbqyrbsy/xvv2t
 wzJQ==
X-Gm-Message-State: AOJu0YwDHZiuUwcR+D1FdzjCwiYM+spMM6UVkYfQfS/YEg3DY3wylqaU
 nNuPPUK51k67wUgMs6S28q//ywElAPlBIWAJPHqaTN3/9paq10ArWh5WOsxOhwmAsiVgFdrfyGI
 t/bgtFjhvUzKtdhVDIgDIxPMD2/NEQHwiMmBR
X-Google-Smtp-Source: AGHT+IGw+h/GV9b/G4bv9a1o7frUlNHohCQYfYzOW6E4+dPUCjGM1TW7gxmISIY3vF0OXLpXagEzMZ7doxK0TqT2SPM=
X-Received: by 2002:ad4:5ba4:0:b0:6b5:4865:948c with SMTP id
 6a1803df08f44-6bb55a41ce9mr100876856d6.27.1722266909785; Mon, 29 Jul 2024
 08:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-41-sughosh.ganu@linaro.org>
 <CAFLszTgSXD3FqwtYjGEHWyt=gxGVZFYCzMs8DDhTkxOg6eW+Og@mail.gmail.com>
 <CADg8p96VOh=QExuK9h0jzvbozXN=fHk651M3LNa-=HCywos86Q@mail.gmail.com>
In-Reply-To: <CADg8p96VOh=QExuK9h0jzvbozXN=fHk651M3LNa-=HCywos86Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:28:19 -0600
Message-ID: <CAFLszTh3AVYEQxiQoKC4=MjswY+i_zh+SaMXYnpGHam13bGo5Q@mail.gmail.com>
Subject: Re: [PATCH 40/40] lmb: ut: re-enable unit tests
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Mon, 29 Jul 2024 at 02:58, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Fri, 26 Jul 2024 at 05:03, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Wed, 24 Jul 2024 at 00:06, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > All the changes needed for making the LMB memory map persistent and
> > > global have been made, including making corresponding changes in the
> > > test code. Re-enable the unit tests on the platforms.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since rfc: New patch
> > >
> > >  configs/sandbox64_defconfig        | 4 +++-
> > >  configs/sandbox_defconfig          | 7 +++----
> > >  configs/sandbox_flattree_defconfig | 4 +++-
> > >  configs/sandbox_noinst_defconfig   | 8 ++++----
> > >  configs/sandbox_spl_defconfig      | 8 ++++----
> > >  configs/sandbox_vpl_defconfig      | 6 ++++--
> > >  configs/snow_defconfig             | 2 +-
> > >  7 files changed, 22 insertions(+), 17 deletions(-)
> >
> > It would be much better to change the tests as needed, so they keep passing.
>
> What issue do you see with this approach? If I have to do what you
> suggest, I will have to put all the test related changes as part of
> the same commit which makes the LMB map persistent and global. I have
> seen this kind of approach taken elsewhere, so really not sure what is
> the problem with this.

Yes, normally when code changes the tests change too, otherwise the
tests are broken on that commit. Disabling them doesn't resolve that.

Once you figure out the save/restore thing you will find the tests
quite easy. I think part of the problem is that you are making the lmb
tests 'special'.

Regards,
Simon
