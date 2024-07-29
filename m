Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE376C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 07:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 792BE82BA7;
	Mon, 29 Jul 2024 09:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ddoBt/8I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20518885F5; Mon, 29 Jul 2024 09:51:44 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2734887E6
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:51:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2eeb1051360so31682241fa.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 00:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722239501; x=1722844301; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0ECG3F8xnFsgu2skQAzp/1aEmIKByg3v10EABqJfvag=;
 b=ddoBt/8It/Jdy36t173EtaxbAZWleEL382CSwPABm6k0/gfV4ee0C3XviPvtGiBOJ5
 9AJO5SegEEAXiIuEVGEjARy9vu5x8RKJ3zQvHJ9mX9wcdM4mqVaDv35lcGqP8XMLOpji
 MJyiP2jaP7bzwjx99mIGVDZfO+0glIrCPSJg8NA2QLtSLBO3m7F08B2j7pnHlBGAPuGM
 YEmvXnnhxdpPcP1q2QENm96vJjD1VzTjcJzrqDxbz+qAyOSWa1A/H+piHMJrxv7HuNJ8
 4bDpnMVDD8bhAX9FFh9lD7gGvfsrGH9UFhXN83Lt6bX+UgO0rqJgrKJNEmyJu4jD4D/2
 Fdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722239501; x=1722844301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0ECG3F8xnFsgu2skQAzp/1aEmIKByg3v10EABqJfvag=;
 b=P8IgQHleuZYFB30W+oOtSFVeRkJJDDcBvR+BItn6GoR6rbUsef0sMcnXx6ZsEkC/QR
 fHn3KKka8+KqS5LVOUnMZQiZjicU11azxz3Supw8oHQcHEF16yLyjCCj4eVEYUptrbtv
 BQqVtC1dKzZHv5hzPk30Yxm6NwlMbatyein+iwVYwIu7k5ELJSJIc7E3dKoIcErMAcc9
 k1LvZSHGbDU1EAgTNKhiPY4KI/m6X9PR/mquDhsANdj3IKKXA0BiJPylBiAjbf+9dYo/
 r1nY7G1UZzR4PGgXDhhogefAtCBKr4/Gi+r5Ys9JB9saRuXJ+/l7ny+Lobm+8E4RH9S6
 RfZA==
X-Gm-Message-State: AOJu0YzGK4GiMwQQT36t5fO1RkMbaAqd+V6A7RUUeKGn7Nlkq7G5Wy8n
 YNGWIGsy24FsQiLan7JcoATpBJbf/q+QUYqbUeNb5OBp+rY5loI+S6s5owWXAJPI+Qd5mfh32Cu
 eFmr9bABJJpqX7LESCzC6zjCpvUhSCuIJmWNRKg==
X-Google-Smtp-Source: AGHT+IHx3UvZnKIMQgErlIXNXH2YcAJPLloL8brplBscXlVC6xX+qomLGRXhYFS0GLJL89s7LTfWRRUewQ2305e2zHQ=
X-Received: by 2002:a2e:2e0c:0:b0:2ef:1b64:5319 with SMTP id
 38308e7fff4ca-2f12ee04091mr43384301fa.11.1722239501084; Mon, 29 Jul 2024
 00:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-17-sughosh.ganu@linaro.org>
 <CAFLszThWjpz47RRhAbrYqu47NnYs3ZtXWe-hE5ABw9dokyQ46g@mail.gmail.com>
In-Reply-To: <CAFLszThWjpz47RRhAbrYqu47NnYs3ZtXWe-hE5ABw9dokyQ46g@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 29 Jul 2024 13:21:29 +0530
Message-ID: <CADg8p941n8H0LD3p9WYs9wSAqC2co5fc68CHK_LMRx6pZn3JKw@mail.gmail.com>
Subject: Re: [PATCH 16/40] lmb: allow lmb module to be used in SPL
To: Simon Glass <sjg@chromium.org>
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

On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 24 Jul 2024 at 00:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > With the introduction of separate config symbols for the SPL phase of
> > U-Boot, the condition checks need to be tweaked so that platforms that
> > enable the LMB module in SPL are also able to call the LMB API's. Use
> > the appropriate condition checks to achieve this.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since rfc:
> > * Replace conditional compilation of lmb code to an if
> >   (CONFIG_IS_ENABLED()) in store_block() and tftp_init_load_addr().
> >
> >  board/xilinx/common/board.c |  2 +-
> >  boot/bootm.c                |  4 ++--
> >  boot/image-board.c          |  2 +-
> >  fs/fs.c                     |  4 ++--
> >  lib/Makefile                |  2 +-
> >  net/tftp.c                  | 40 ++++++++++++++++++-------------------
> >  net/wget.c                  |  4 ++--
> >  7 files changed, 29 insertions(+), 29 deletions(-)
>
> Same question as previous patch...do any platforms need lmb in SPL?

Same answer as my other two emails. This was called for by the maintainers.

-sughosh

>
> The cover letter says "The LMB module is enabled by default for the
> main U-Boot image, while it needs to be enabled for SPL." but I don't
> really understand that.
>
> Regards,
> Simon
