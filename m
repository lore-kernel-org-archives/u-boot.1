Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22532C7115C
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 18:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 542B482BA1;
	Fri, 20 Jun 2025 20:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gZhWEiIy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C59BD82CBC; Fri, 20 Jun 2025 20:36:24 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8B7D80C83
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 20:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e7b4ba530feso1993002276.1
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 11:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750444581; x=1751049381; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXhgiE+b66FF/iQ7+Kn3NAQQcK5dmxPCvIy5HRd9gZU=;
 b=gZhWEiIyrJ6VX2MC4h5ehi6VAzPg/W2KObgko1yZWFffpm0/Pr+eIkFaSKHyXsUgcO
 wH3SQrTrR/KJbWxxMw/lzOPT13p5Jx6wQMu81PgsGDU2GfmmDttRzTIixRM6FzZvrzmF
 QnzUnVlxDtusWlF/nmM+MKtbdPHRJNUCocJGhMogV/WQZGE4/qKGd5gcCsw7xIVe6hDE
 ukL863HnoicZGaVfXx+qbJpcwpewvdks4qp9XsrDAQkU9mwYfqGZ/vSPfGNLlKb/adNR
 LPGVGZobOASRkC/1eOrbU7vhZklGIyGO2Ko1ni98kDxadgDMKhSyOTPGlQtlNTtuFSXe
 0uBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750444581; x=1751049381;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CXhgiE+b66FF/iQ7+Kn3NAQQcK5dmxPCvIy5HRd9gZU=;
 b=hk3Rk9yVC5qmwZ0yDtez1LvffE1n7BnsXKBR/JCQ3FfhQfidugTsyoXBJ6dRVlQn3x
 zGRJmxfFpJEedB0g0K5dAW4q9J2AyLzKnTx7rtgSw6nSlg4VdXNzzCkxiKi46yc1Ohly
 C8uPvtK1qiqfy4doES4p878VE1urp14FZQ8r3YtoR24ucpIuFRnLrAiGpeODvEsk52sk
 4b7Ot4FQXDcMEUBAkc+BVAo9nXVrSnIB8ggSAUd8GA+cf1rfm2JerQgm4lJMn0cm7WTn
 SfEuIREhdM0teIXcGHUutzeJpPJlTquo2iuMiag9cUVQlCi+ke1+bwAYujq2JK83/xzI
 o2KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKxobsbgbW7C1NdPUc94OTceDY/ewDYj6ck+CGNBNrmJM3DLYGT9sWv8mGZiS2urBOYuWqrkY=@lists.denx.de
X-Gm-Message-State: AOJu0YxJcg1FtwR5GFYT7Xm3FYZ8P0j3Fu60wdWSP4lRx+5bo989yvXq
 h7rHbJ9L3gTL0e4GH5N2pcCdS2ZxSHowfNc/wCHS8GuhW0wb/EtHL/VgSGg6pc7S3WNn78N4GJv
 Px1UZhIx/eQ802wVYBUzSseFk5sRrpZeSGOzwKwN/pg==
X-Gm-Gg: ASbGncv7SY1SmYxolvW7BSaUQMtbJKu2HxqEm5mnvVdA8aOaNyho/mqgik2g08JHCVC
 EaKRamcpIBLCPHNHTqjV1EF40iy9SBaOkmaAQTPd2VTMuTuOXbqM5SQaUVWI7HRsTray34QrGra
 n+6we8DUwH06kijELv7+B33kxIxWa+kaZQmgA7pNoF43Y3Kj6JuoaPRsTNROQmFTr64ZBSdmwgB
 OlbgQ==
X-Google-Smtp-Source: AGHT+IGko/2JQgMBz5VQ4K+4nC0W0gRJOaQXF8EM8lS4jC/V5PjI2EuWf1e5YuzkacpU9vw4UAenVyoztD0zFpHV74c=
X-Received: by 2002:a05:690c:23c2:b0:702:d85:5347 with SMTP id
 00721157ae682-712c67758afmr58936877b3.36.1750444581366; Fri, 20 Jun 2025
 11:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250620022556.10363-1-semen.protsenko@linaro.org>
 <20250620142058.GJ216500@bill-the-cat>
In-Reply-To: <20250620142058.GJ216500@bill-the-cat>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 20 Jun 2025 13:36:09 -0500
X-Gm-Features: AX0GCFsjbcC9PhZ-EpjjjCEdQy6YPHFej3SiLuHkXt2O0rob__gnJQM28eaj0lU
Message-ID: <CAPLW+4=JkVWoNaK5f98fRXOLZOQWc462U=EaDfYsXGmYBDbYnA@mail.gmail.com>
Subject: Re: [PATCH 0/2] board: samsung: e850-96: Fix MMC devices in EFI
To: Tom Rini <trini@konsulko.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Jerome Forissier <jerome.forissier@linaro.org>,
 u-boot@lists.denx.de
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

On Fri, Jun 20, 2025 at 9:21=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Jun 19, 2025 at 09:25:54PM -0500, Sam Protsenko wrote:
>
> > Avoid using MMC in board_init() to make sure disk objects are created i=
n
> > EFI subsystem later.
> >
> > If it's still possible, please take this series for 2025.07, as it make=
s
> > EFI functional on E850-96 board.
> >
> > Sam Protsenko (2):
> >   configs: e850-96: Enable BOARD_LATE_INIT
> >   board: samsung: e850-96: Load LDFW in board_late_init()
> >
> >  board/samsung/e850-96/e850-96.c | 9 +++++++++
> >  configs/e850-96_defconfig       | 1 +
> >  2 files changed, 10 insertions(+)
>
> These should be one patch and also I think you want to disable
> CONFIG_BOARD_INIT ?
>

Thanks for the review! I'll send v2 in an hour. But I wasn't able to
find CONFIG_BOARD_INIT option:

    $ find . -name Kconfig* -exec grep -Hn "\bBOARD_INIT" {} \;

initcall_run_r() seems to always call board_init() for ARM and other
architectures:

    #if CONFIG_IS_ENABLED(ARM) || CONFIG_IS_ENABLED(RISCV) || \
        CONFIG_IS_ENABLED(SANDBOX)
        INITCALL(board_init);    /* Setup chipselects */
    #endif

Interesting thought though. I did a brief analysis, and it looks like
there are 79 boards which have empty board_init() because it's not
possible to disable it at the moment:

    $ grep -Pzrl "\bboard_init\(void\)\n{\n.*return 0;\n}\n" board/ | wc -l
    79

Do you think U-Boot could benefit from having such an option?

Thanks!

> --
> Tom
