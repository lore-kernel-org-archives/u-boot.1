Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D918C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 19:27:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3908D82A9E;
	Thu, 15 May 2025 21:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a76RpWQh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D17BE82A9E; Thu, 15 May 2025 21:26:58 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B6898129F
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 21:26:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5fcab0243b5so2071817a12.1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 12:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1747337215; x=1747942015; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XiaYpb9/rvAPQVC7mXyA4xePMhwUsG0BtrrAEIKZbhE=;
 b=a76RpWQhNXYQY8bN/sN66wmVHxU4UIyH2IBxND0Duuu3q5l04OJGXly6d8qabPWKIf
 JrAEl+hF7Q3KrDz5QUIj5OB5r53ds4NrSPcgTESSSIhtVDBUQVfGCFenYC1v4sEWYozH
 nH8wNfWvCSeHAuGdjDVCOAqmNUPihn6N7SBiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747337215; x=1747942015;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XiaYpb9/rvAPQVC7mXyA4xePMhwUsG0BtrrAEIKZbhE=;
 b=H40b44wBWoCxI3keeC/yiidLQRFFesYwXBsrMi9G97Q+t6WaFxv/ZFE6tp1HvsaRU0
 8trEJwiTOQjS7o8SmOnkVq1sVrwy3wDzEbSVTLIkNH5iEa1HdnkY7Vv1ISRD72tqMM11
 /P+2opqHNgs3wbel474LMic0D1NQSDG5XV2i8quq2i5QP/5JkJ159ajQvrgtKXw3HII/
 eENQOz+xKPjX/pediHZ15M1tQXYV3JcVh+fKOB4MJb29K/2T2jN2xLNQKrR+nW+EQm+V
 InYEqBgU++9VASKG2Wo52Jk3z3loewjxpA71V9Ga/VszY6uTlhqueMbtywiBp/ZpbQaj
 ASOQ==
X-Gm-Message-State: AOJu0YzqShcR0hb8uIWYKyl0go+hQgDGSEAxs3+1SMBbzcfHFQAZ+i+l
 pSQcnlh/t8WbYKgG4kxw6zxILtWlp19Q2Gvg2anLTM7/2TNar6/cWC+6N6Nh1dViALqgcGMbgRA
 p5QcHjnZtxvq3raNpVTJ1O+R+X2nFgsA1rce8kLIt
X-Gm-Gg: ASbGncs2Q2X4pdMOqS5mp4fqK882afXH+0r03U5YxgvosgICEr4GNZGC5GJLCUoemDm
 /lodImN1h79l/VaKksJHb9RHu8lRyr5OHExVDPgEkI6p2xcCe6gC0O5feVTkWgeXqDnmhOgUHLf
 Y2GOQnKCC03r0VtHDrjlWKpqXeuMsC5BmMjA==
X-Google-Smtp-Source: AGHT+IF3z1Iu9dE1sla3VJd/1o+RjJ1ew6NOfYH6Oyy9YUv6l5NioDniXxIkaxhUcxtnWqlfE02g4qbG5sJpFisPZvg=
X-Received: by 2002:a17:907:7210:b0:ad5:1db5:6ec0 with SMTP id
 a640c23a62f3a-ad52d49a099mr95632566b.20.1747337214905; Thu, 15 May 2025
 12:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250510134253.1581164-1-sjg@chromium.org>
 <20250510154214.v4.9.I56d9d06e5d74724c963eaffbbe1c2aa400b60bb8@changeid>
 <20250514215821.GD603748@bill-the-cat>
In-Reply-To: <20250514215821.GD603748@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 May 2025 21:26:42 +0200
X-Gm-Features: AX0GCFtwZke7cU7q3u4As8BZEpz1geq3Em9qzK2PjBipG2xkDs4MNWG3qRapBGc
Message-ID: <CAFLszTg2vMEVSR--ksh9cVRHBQWxzC++Nf83iDq7utUwku8Hrg@mail.gmail.com>
Subject: Re: [PATCH v4 09/22] passage: arm: Accept a passage from the previous
 phase
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, 
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Xu Zhang <423756212@qq.com>
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

On Wed, 14 May 2025 at 23:58, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, May 10, 2025 at 03:42:07PM +0200, Simon Glass wrote:
>
> > Accept a bloblist and control devicetree from a previous phase in
> > registers 0 to 3, as documented in the Firmware Handoff
> > specification[1].
> >
> > Note that there is currently a weak function called save_boot_params()
> > which happens to save the same registers as are needed for this
> > protocol. But it seems better to implement this feature as a first-class
> > citizen, if for no other reason than that many boards have their own
> > version of save_boot_params() which may not happen to save the required
> > registers. A weak function is not a good basis for an API.
> >
> > [1] https://firmwarehandoff.github.io/firmware_handoff/main/index.html
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> > While some efforts were made to encourage Intel to adopt this
> > specification, this has not yet been successful. However I do intend to
> > use my proposed x86 handoff in U-Boot, once this series is in.
> >
> > Changes in v4:
> > - Update commit message to indicate this can only be for ARM at present
> > - Update commit message to mention why save_boot_params() is not used
> >
> > Changes in v3:
> > - Add support for aarch64 also
> > - Update registers to match the Firmware Handoff protocol
> >
> > Changes in v2:
> > - Use three registers instead of two for the entry
> >
> >  arch/arm/cpu/armv7/start.S | 10 +++++++++-
> >  arch/arm/cpu/armv8/start.S | 12 ++++++++++++
> >  arch/arm/lib/crt0.S        |  6 ++++++
> >  arch/arm/lib/crt0_64.S     |  6 ++++++
> >  4 files changed, 33 insertions(+), 1 deletion(-)
>
> This is what makes me think you aren't actually working on my feedback
> about taking what we have in-tree, now, rather than just forward porting
> your old series and deleting the current code.

Well, yes, I sent this v3 series because I had thought you were
willing to allow me to maintain bloblist. I certainly appreciate the
work in this area, though.

>
> We have save_boot_params doing exactly what it should today, including
> saving off a standard passage and making what was saved available later,
> in an intentional fashion. If, hypothetically, Pi needs to override
> save_boot_param because a future new-firmware-blob does standard passage
> but at run time we want to support both, that's a good thing.
>
> With commit ea3348ebc215 ('Merge patch series "Handoff bloblist from
> previous boot stage"') we already implement the specification in [1]. It
> is not a "which happens to". It is intentional.
>
> I guess the overall challenge here is that you want to do things which
> are a superset of the firmware handoff spec itself?

Yes,, much of this series relates to putting some structure into
things which are passed via standard passage, including validation.

I actually don't understand why you would be keen on using
save_boot_params(), a weak function, used for board-specific features,
to implement standard passage. We should build standard passage in as
a first-class citizen. I certainly don't want to try to implement
things that way on x86.

Regards,
Simon
