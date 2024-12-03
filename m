Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7030AE74AC8
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDAB1896C3;
	Tue,  3 Dec 2024 20:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l2+Pklhb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F22FD8968D; Tue,  3 Dec 2024 20:45:39 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0371D8967C
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:45:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ee8aa26415so2830955a91.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733255135; x=1733859935; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8BVf6XMlGKcPnU6pKx2ODsHQgnwhqxeA3mAlXbWgK/c=;
 b=l2+Pklhb71Vogk+pWbMRaH/dMAb4qZoqcQ0xWgGnd0TGU3+GOd0rfsa4fgzDCkEy1q
 ghvEMIHOsT+QSGP0IvTNaF7Sp6T1E5vgWobl4Rmig3IX18sY5PqMSBM+pT1FkEW7yZch
 OHVvLMgJ5cQh28KuT4L0UKs+exC012PuVm/aQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733255135; x=1733859935;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8BVf6XMlGKcPnU6pKx2ODsHQgnwhqxeA3mAlXbWgK/c=;
 b=DsYgdZWbKRyNzQnHV1rxH2+NFYMy4LGbhUuBrVcxE21qdeJHVJbX4iu782FymmWak0
 ww5qDGjqXUGeMsWODIsYfhtJxxvBDN73raZLCnXc+Eg2EuHTWTBu3MjUhpGQXvTay1Yg
 UUrR+W/tXCZ6qoRu305RR0gvbnHP42jtRj0wFHhXroWZyu2/KTx3AMmOhbKPg0ua2iR1
 wNvP0opLxGqoeiWyNMrcrQ2YN9bNLtBzQVoQNhrKYPkkUcCabG/PXcQGKNc5Tbh2UWMS
 DB7Gn9IQGJthvJdc+eh+zjSZvhm/ucE+rtJ/2TUY9kIKyr7HoLTym7qMKhZFuc/omW/c
 Wg1w==
X-Gm-Message-State: AOJu0YwxoBEV/mYOl0IhivYnimAQMxp/o1lo0gVkmaUQCpYkzlnEAw63
 cyMKqEeJfPmkBHvxfXZKF5gCrNZIG7mFcnOtCLAxsYRjtf+G6Tvyo29r3F57/GBydzlfS2PKlaD
 uicYVQyvfcej1HHLWmNZmjrxzF+rGN54rUg0o
X-Gm-Gg: ASbGncufO8CTjdzIx9fcYL2ULo1N+SQCS71XCM3/h7Y5HtQsxOnWhpAI6tz9YeKQTTd
 U0qPZhMfTY8XfIMTR2Igs0J6jXtx6yA/m
X-Google-Smtp-Source: AGHT+IFjxDgmYhq84oPIe0A4BvWe1jXd3WNTQcD8uAMnUPebn8aJEOOoi73az5B3OrmOQVnBpc7H5jECtyxmvBpDpwE=
X-Received: by 2002:a17:90b:3803:b0:2ee:edae:75e with SMTP id
 98e67ed59e1d1-2ef011eb672mr4586883a91.13.1733255135582; Tue, 03 Dec 2024
 11:45:35 -0800 (PST)
MIME-Version: 1.0
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-6-sjg@chromium.org>
 <20241201164810.GT3600562@bill-the-cat>
In-Reply-To: <20241201164810.GT3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 12:45:12 -0700
Message-ID: <CAFLszTiLxRdLZb3mykH6L5DLQwL2N+-TiKAzH+aDtGpWa4O46g@mail.gmail.com>
Subject: Re: [PATCH 5/8] fdt: Allow the devicetree to come from a bloblist
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Jerry Van Baren <vanbaren@cideas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marex@denx.de>, Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 mason1920 <mason1920@use.startmail.com>
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

On Sun, 1 Dec 2024 at 09:48, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Dec 01, 2024 at 07:42:33AM -0700, Simon Glass wrote:
> > Standard passage provides for a bloblist to be passed from one firmware
> > phase to the next. That can be used to pass the devicetree along as well.
> > Add an option to support this.
> >
> > Tests for this will be added as part of the Universal Payload work.
> >
> > Note: This is the correct way to deal with bloblist, since it allows
> > boards to choose whether they want to use the devicetree from there, or
> > not.
> >
> > Link: https://patchwork.ozlabs.org/project/uboot/patch/20231226094625.221671-1-sjg@chromium.org/
> > Link: https://patchwork.ozlabs.org/project/uboot/patch/20231228133654.2356023-1-sjg@chromium.org/
> > Link: https://patchwork.ozlabs.org/project/uboot/patch/20231228194725.2482268-1-sjg@chromium.org/
> > Link: https://patchwork.ozlabs.org/project/uboot/patch/20240104014919.413568-1-sjg@chromium.org/
> > Link: https://patchwork.ozlabs.org/project/uboot/patch/20230921015730.1511373-31-sjg@chromium.org/
> > Link: https://patchwork.ozlabs.org/project/uboot/patch/20230830180524.315916-31-sjg@chromium.org/
>
> You should
> %s#https://patchwork.ozlabs.org/project/uboot/patch#https://lore.kernel.org/u-boot
> all of these Links, aside from shorter, it's on much more broadly
> distributed infrastructure. And this is a general comment as well.
>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  common/bloblist.c                  |  1 +
> >  doc/develop/devicetree/control.rst |  3 ++
> >  dts/Kconfig                        |  8 ++++++
> >  include/fdtdec.h                   |  3 +-
> >  lib/fdtdec.c                       | 44 ++++++++++++++++++++++--------
> >  5 files changed, 46 insertions(+), 13 deletions(-)
>
> The rest of this, I need to think on.

It sounds like you have thought about this, and come to the conclusion
that the reverts are not going in. So, for simplicity I'll leave this
patch as is and make a note to use 'lore' in future. I wonder if there
is an easy way to convert between lore and patchwork?

Regards,
Simon
