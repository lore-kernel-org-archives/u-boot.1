Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AD7C48286
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 08:25:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DD5387B2A;
	Tue,  6 Feb 2024 09:25:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G1+2ljtZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C8B487B7F; Tue,  6 Feb 2024 09:25:05 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7104587887
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 09:25:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55f279dca99so7637262a12.3
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 00:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707207903; x=1707812703; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TI2jBFPKlsyhk/DunJM6oNjgiU+o9QEiGacrRUszzXc=;
 b=G1+2ljtZbTjIcIpqhI62EqxKmbmpxTN86uQvyEO8qjGpOZ943p4UNMgSk0j3jNv0zh
 xsa9Q+yuUKFV74Xaq0GdD5sAyzCm/KnuJgWlzAXqWuruFLl9Qww12N1zsTtO6ccIDEdQ
 Ebqscx4wPuZa6StF5GP7615pSnZLr/hDXgv7fM2LAiyp8IrAWxJ6E8/+6dnbTmRIMol8
 +nSWzsalH7yD3FfNJBL5TbcQqgSFOlG6LFxXiK/QAGySq9XK3/PWpEiuvqy7TgoHJdi2
 nb1LOOZOZmkgfeAg81AEFIBqXFHQ9zNLARPTmreERLGJzKpc5sOLHG1/ePri2195w8tw
 7tyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707207903; x=1707812703;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TI2jBFPKlsyhk/DunJM6oNjgiU+o9QEiGacrRUszzXc=;
 b=ZIPcAMwRBC/4NFdOKl26RgFc5ZjgS3ifW+06DodNpIueaIBAMP2XYmqDr3mOQYlvIE
 q4K/sePew/MU50GdBxjCrJ7IPge9L9hhcTK9kSbAoXGR/Lnc1yU0xzwC9j8WvwD8PQfp
 fwkJNK3E9Hse1vNYLgF+YDyFoqI95y8lwa68Kt/6Xna0og3PY1ve9hI2oALWMF06A0Zv
 SzzkfjqvccY9/Vzn1w7kRWbNjC64EEJZTCAiQB7CFL5g8dlQvehMWVcaiKPcwHsw+tU/
 k7IFdJJ3dTTdV8Bj2LxGCJRufOXNqnBzPI/VwCnywUE9PKVkAzFA2S5OfOJ6mhNov8Ww
 Q+Iw==
X-Gm-Message-State: AOJu0YwvwnSxRz6/4CGZK4NZsAVT2cV6Wx0nIo+rX2GMavYKRJ80V9F2
 +DTonBlTzNWUq5LjxAkeFNAFB4HMSWhU1s25NBhg21fhj4Aos5eILZ3CVNLnVyT34WUwFsgCE1T
 PGCJnmD2/CuzWfkF/DmNodt9HBEc=
X-Google-Smtp-Source: AGHT+IFMNMPvyllLS4lHFykWCcjuO9Eh2Mcfd1A15hnFp9tDX/hzPqJfuXwNFgSw+suVTjf864ll8LajF3it8SDYY30=
X-Received: by 2002:a05:6402:31f4:b0:55f:11cf:ee54 with SMTP id
 dy20-20020a05640231f400b0055f11cfee54mr1104029edb.32.1707207902147; Tue, 06
 Feb 2024 00:25:02 -0800 (PST)
MIME-Version: 1.0
References: <20240131141426.34926-1-o451686892@gmail.com>
 <20240131141426.34926-4-o451686892@gmail.com>
 <20240205181413.GA1539941@bill-the-cat>
In-Reply-To: <20240205181413.GA1539941@bill-the-cat>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Tue, 6 Feb 2024 16:24:49 +0800
Message-ID: <CAHk0Hov-OBLL0XQ0QQYpN+Z0nSLZM9uEaHuxSaxA9XsXxJefxg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] cmd: rng: Add rng list command
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Etienne Carriere <etienne.carriere@foss.st.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jens Wiklander <jens.wiklander@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
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

Hi Tom,

On Tue, Feb 6, 2024 at 2:14=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jan 31, 2024 at 02:14:26PM +0000, Weizhao Ouyang wrote:
>
> > The 'rng list' command probes all RNG devices and list those devices
> > that are successfully probed. Also update the help info.
> >
> > Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> > Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> > Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>
> > ---
> >  cmd/rng.c | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
>
> Please update doc/usage/cmd/rng.rst as well, thanks.

Ok, I will update it.

BR,
Weizhao

>
> --
> Tom
