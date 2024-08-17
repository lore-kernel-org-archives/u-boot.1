Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D182C52D7D
	for <u-boot@archiver.kernel.org>; Sat, 17 Aug 2024 15:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06EA38876E;
	Sat, 17 Aug 2024 17:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DCHeuZHy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B53A88600; Sat, 17 Aug 2024 17:57:53 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D411A88403
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 17:57:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6bf8a662467so4246256d6.3
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 08:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723910270; x=1724515070; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2f25YhE39R/ICAaRgXvyR6g7MauWSSitgKCD46V/QxA=;
 b=DCHeuZHy4V6romCwtDwvfjgWNW+L//OCCHV2xZYV0tB6ysBAnmU0j5280HNKBpo+SL
 3ckvMDsZk4NCvbDrgSbbgq9vJZFo+8qmhrklF4aQVh5ZZPORVMgPtb672GhqZGeFYmWX
 FRpOObrhf9hQRBMWRx8IpeCUw0ExmMUELm1oY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723910270; x=1724515070;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2f25YhE39R/ICAaRgXvyR6g7MauWSSitgKCD46V/QxA=;
 b=pi5hEtz79hkUWRbdsP1L4372DtCOP6tmcLKAzl0zhBhLV97QO/bciLrMEKaRcgbYjz
 T7xzIdWaUOSwqp8XZJgl2/hMj/1dGXvFkOTr3DH8svJwY+BfWtOwNK7+3IqgXFDcDbTY
 q5ICUFSl0ht+0N6ow5ewRGLpAiPO9T0bVcYm4QfLH9yEI85xknEZD8fvvQFl5/14eqQn
 KhGGqC87shRA4dszg/eh70azcNI+lFgZSYxBF3dgnOydYUuJKE6Ttu14Q0E7iO+KkF1O
 NKdCdc/2ElDhCTE16L06fvspNOGjn+tWC3ve7NEwEAHeywoqH/qWwZtPuPKVHd7qgCef
 TFIw==
X-Gm-Message-State: AOJu0Yyn9UkXYkU+AQZRHPdDh/TXwpG5X1R2tR2cMYgeCxruCC/YTk1K
 9usDIK4B1DR1aqqsKOI/kNaf1QET67pSWSpC3aNpLGleLniIeK20FGk7FFIScE9qrjyR7uKk0uj
 C7+y+XJtvVM9Tw18+9nTTb0QrBmzgCEG3yPcU
X-Google-Smtp-Source: AGHT+IEQryYuY6z1+4tg4OsjYcpQhl++tNBLsTb+KgyMrd6pRB9qCcd4GSUdfoHqLX8JAIPSpgBYusmfVBdx3Ma8Wd4=
X-Received: by 2002:a05:6214:41a0:b0:6b5:434:cc86 with SMTP id
 6a1803df08f44-6bf7cd79093mr77578246d6.10.1723910269772; Sat, 17 Aug 2024
 08:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-28-sughosh.ganu@linaro.org>
 <CAFLszTh-5c4_OdZs8F_e=giR+ZFjNB1oX8L8cV8hXi9Je6e+5w@mail.gmail.com>
 <CADg8p954ZtuXpC_b_rfkpWuXBGFV40Kp=DJby_oRsTp2GYbcHw@mail.gmail.com>
 <CAFLszTgsbrBefPQ7EGdLbC8fUO=oZUoQ13TYeo=pJzu2Uro_kQ@mail.gmail.com>
 <CADg8p96ogU8isBs6rs+s5-U4XJOXryPDb-MzHTuxwT8L07HQ3A@mail.gmail.com>
 <CADg8p978HKb1r9D3e_ZbErrfnKnLy7-bOTfuk2Suc-Qvq7n_ig@mail.gmail.com>
 <CAFLszThzR=2V=Oqe6iZq8gK1stwEH1_kraFNnSPSQpyGMN3A0A@mail.gmail.com>
 <CADg8p96MUJ9Mq-a06EegsgiKrWt2dvy80cZhRnQmJ9wvuPX66w@mail.gmail.com>
In-Reply-To: <CADg8p96MUJ9Mq-a06EegsgiKrWt2dvy80cZhRnQmJ9wvuPX66w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 17 Aug 2024 09:57:39 -0600
Message-ID: <CAFLszTicvcqyenucQG-gLFizvnBqEkySsRqDGR65DdVTMUGgvg@mail.gmail.com>
Subject: Re: [PATCH v2 27/32] test: cedit: use allocated address for reading
 file
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
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

On Sat, 17 Aug 2024 at 04:06, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Sat, 17 Aug 2024 at 05:24, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Fri, 16 Aug 2024 at 11:53, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > On Fri, 16 Aug 2024 at 22:39, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > On Fri, 16 Aug 2024 at 20:17, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Sughosh,
> > > > >
> > > > > On Fri, 16 Aug 2024 at 04:34, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > >
> > > > > > On Fri, 16 Aug 2024 at 02:02, Simon Glass <sjg@chromium.org> wrote:
> > > > > > >
> > > > > > > Hi Sughosh,
> > > > > > >
> > > > > > > On Wed, 14 Aug 2024 at 05:02, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > > > >
> > > > > > > > Instead of a randomly selected address, use an LMB allocated one for
> > > > > > > > reading the file into memory. With the LMB map now being persistent
> > > > > > > > and global, the address used for reading the file might be already
> > > > > > > > allocated as non-overwritable, resulting in a failure. Get a valid
> > > > > > > > address from LMB and then read the file to that address.
> > > > > > > >
> > > > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > > > ---
> > > > > > > > Changes since V1:
> > > > > > > > * Don't use the API version with flags parameter.
> > > > > > > >
> > > > > > > >  test/boot/cedit.c | 6 +++++-
> > > > > > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > >
> > > > > > > No, this address needs to work fine without using lmb. Same with any
> > > > > > > other tests. Tests make use of the sandbox memory space memory
> > > > > > > addresses and it makes things easier to code and debug.
> > > > > >
> > > > > > Like I had explained earlier [1], not using the LMB API for allocating
> > > > > > the address results in issues, since the load command internally
> > > > > > checks if the address can be used for reading the dtb. Without this
> > > > > > patch, the cmd_ut test fails. I am not sure why you do not like this
> > > > > > solution. But in any case, can you propose some other solution? I
> > > > > > believe I can tweak the address to some other value, but that would
> > > > > > not be a proper solution, but simply kicking the can down the road.
> > > > > > Thanks.
> > > > >
> > > > > But this is why I suggested having lmb_push() and lmb_pop(), so you
> > > > > should be able to use those in the few tests which have this problem.
> > > >
> > > > Ah yes, I forgot about that change. Let me try running the test again
> > > > and see what I get. Thanks.
> > >
> > > Sorry, I think I was hasty in my reply. This would not work. We have
> > > the lmb_push()/lmb_get() functions only for the lmb specific tests. In
> > > this scenario, we have the load command which checks the lmb address
> > > against reservations, which are the "normal operation" memory map. So,
> > > if we have to have this to work, this might need a way of using a new
> > > lmb structure instance for every test. So that every test that gets
> > > invoked, does so like the way the lmb tests are.
> >
> > Why does the 'load' operation fail? When I revert this patch the tests
> > still seem to pass.
>
> I had not run the tests then. I thought that the address might
> conflict with some existing reservation made with a different flag. I
> have run the tests, and I too see that the CI goes through even with
> this patch dropped. I still think that getting an address from LMB and
> then using it is more robust, but then the same flow is being used in
> many other tests as well. This should work as long as we don't get any
> conflicting reservation with a different flag. I will drop this patch
> in the next version. Thanks.

OK, well let's see if it does cause problems later. We can use the
push/pop feature if needed down the track.

> > > > > If it becomes more widespread and affects a lot of tests, we could do
> > > > > thing automatically in the test framework, but for now, that doesn't
> > > > > seem necessary.
> > > > >
> > > > > > [1] - https://lists.denx.de/pipermail/u-boot/2024-July/560569.html

Regards,
Simon
