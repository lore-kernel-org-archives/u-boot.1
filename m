Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D159C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 17:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77CF388915;
	Fri, 16 Aug 2024 19:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j3MilbgZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C3B78870B; Fri, 16 Aug 2024 19:53:31 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BABCC88915
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 19:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2f16767830dso24152931fa.0
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 10:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723830799; x=1724435599; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I7+ZzsiPBAe+0CNi6/7tA1cG3De5w4UZI6jFR3xtLDQ=;
 b=j3MilbgZac0aQtYuLhYUibI0k5iMCFbf/4auGAJTrHou80tlres7oT4QulIBQlJfLP
 gahbtrGeA50HLS+laiDdGEJon6e7ZUAJSqAaPBtK7Q7UaFQbwTEE4YmJhojzhzaCIn9B
 ZzRN381m0MKNklo5Ua5mZ93/FBzIcuGWaa0tRxYBcBXsjVG5uxkbFo1Jk7HYvDznSVUW
 5CnQqSlQrYJmghhphil7OsSDKNANki+uVBdl+OJSsavBh7G0wKhUldX1T43rp9ojVCxO
 AFn9a+S/TxY8xR9neO0FqX7bkrStbE5W7xor3AioHXattnO6k8s4CEZVhQNi/hrqfMmP
 qgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723830799; x=1724435599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I7+ZzsiPBAe+0CNi6/7tA1cG3De5w4UZI6jFR3xtLDQ=;
 b=XEcnu/UL9WIxREIigZJGDi2C+9ysG1sGmL6Q9sX9AYFL53ueoGD5HzIh+1IbBo5Vpn
 phCv1cLOoISog3/PDTEgdK2ZCLSfzuKA6uD9fzWNhsRvrN5KOEeKzLvRKDKqtNvB9mCq
 JEgdGl1jqW5gu0h8E8WXzYehMd5x6qsLmhEcPd8TsJhjkuaqSRX6NodEJFjEqbbqGoXU
 qjAEwGiWH7GVGy4cVefYg4SHZfk0xze8skU9329SOL/dIpoWtwGWTOWRKONxUsSFeTDU
 SQNHXsOqOryvQPzCsHVHx9WbFIbrKxoCvgx1TEqQw8eQxs5sLBg8sYgCf+C5i5MJUUNG
 jnkw==
X-Gm-Message-State: AOJu0YyMpWlDbYUyYYkpFtSQUrauafn9ig59OvIZx24bGj2XNWwF4D1F
 X+dfOooKinU084p2lOD7tq5yHV7rGPBAiJ4ZldRxOkU4rTuDu0RWpjbn8hy98CNot/cgjxP4mhl
 alqF83sSU+JH9IxakKIo57hYIoJQi2e0hG4ZbSg==
X-Google-Smtp-Source: AGHT+IFJRNf7Am4RVjCuvZCDVd+wFkKB/W2QLBR8+uf79SYtlwdDau+sO7JpJhhWj1FG1TrvyGr0VMTwYGoBYoriuYA=
X-Received: by 2002:a2e:a545:0:b0:2ee:d5c3:388b with SMTP id
 38308e7fff4ca-2f3be5f8176mr25554741fa.39.1723830798456; Fri, 16 Aug 2024
 10:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-28-sughosh.ganu@linaro.org>
 <CAFLszTh-5c4_OdZs8F_e=giR+ZFjNB1oX8L8cV8hXi9Je6e+5w@mail.gmail.com>
 <CADg8p954ZtuXpC_b_rfkpWuXBGFV40Kp=DJby_oRsTp2GYbcHw@mail.gmail.com>
 <CAFLszTgsbrBefPQ7EGdLbC8fUO=oZUoQ13TYeo=pJzu2Uro_kQ@mail.gmail.com>
 <CADg8p96ogU8isBs6rs+s5-U4XJOXryPDb-MzHTuxwT8L07HQ3A@mail.gmail.com>
In-Reply-To: <CADg8p96ogU8isBs6rs+s5-U4XJOXryPDb-MzHTuxwT8L07HQ3A@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 16 Aug 2024 23:23:07 +0530
Message-ID: <CADg8p978HKb1r9D3e_ZbErrfnKnLy7-bOTfuk2Suc-Qvq7n_ig@mail.gmail.com>
Subject: Re: [PATCH v2 27/32] test: cedit: use allocated address for reading
 file
To: Simon Glass <sjg@chromium.org>
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

On Fri, 16 Aug 2024 at 22:39, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Fri, 16 Aug 2024 at 20:17, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Fri, 16 Aug 2024 at 04:34, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > On Fri, 16 Aug 2024 at 02:02, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sughosh,
> > > >
> > > > On Wed, 14 Aug 2024 at 05:02, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > >
> > > > > Instead of a randomly selected address, use an LMB allocated one for
> > > > > reading the file into memory. With the LMB map now being persistent
> > > > > and global, the address used for reading the file might be already
> > > > > allocated as non-overwritable, resulting in a failure. Get a valid
> > > > > address from LMB and then read the file to that address.
> > > > >
> > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > ---
> > > > > Changes since V1:
> > > > > * Don't use the API version with flags parameter.
> > > > >
> > > > >  test/boot/cedit.c | 6 +++++-
> > > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > >
> > > >
> > > > No, this address needs to work fine without using lmb. Same with any
> > > > other tests. Tests make use of the sandbox memory space memory
> > > > addresses and it makes things easier to code and debug.
> > >
> > > Like I had explained earlier [1], not using the LMB API for allocating
> > > the address results in issues, since the load command internally
> > > checks if the address can be used for reading the dtb. Without this
> > > patch, the cmd_ut test fails. I am not sure why you do not like this
> > > solution. But in any case, can you propose some other solution? I
> > > believe I can tweak the address to some other value, but that would
> > > not be a proper solution, but simply kicking the can down the road.
> > > Thanks.
> >
> > But this is why I suggested having lmb_push() and lmb_pop(), so you
> > should be able to use those in the few tests which have this problem.
>
> Ah yes, I forgot about that change. Let me try running the test again
> and see what I get. Thanks.

Sorry, I think I was hasty in my reply. This would not work. We have
the lmb_push()/lmb_get() functions only for the lmb specific tests. In
this scenario, we have the load command which checks the lmb address
against reservations, which are the "normal operation" memory map. So,
if we have to have this to work, this might need a way of using a new
lmb structure instance for every test. So that every test that gets
invoked, does so like the way the lmb tests are.

-sughosh

>
> -sughosh
>
> >
> > If it becomes more widespread and affects a lot of tests, we could do
> > thing automatically in the test framework, but for now, that doesn't
> > seem necessary.
> >
> > >
> > > -sughosh
> > >
> > > [1] - https://lists.denx.de/pipermail/u-boot/2024-July/560569.html
> >
> > Regards,
> > Simon
