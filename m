Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094CBC4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 02:59:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 506E7875DF;
	Tue, 28 Nov 2023 03:59:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PiyOF2Q7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1828B8757B; Tue, 28 Nov 2023 03:59:35 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0957E8757B
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 03:59:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-58d12b53293so2852783eaf.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 18:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701140371; x=1701745171; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cGqe/0NyCKHqcz+orMu1/dzDvQqUZWqQf2fh6TwcQ5g=;
 b=PiyOF2Q7X+LdNg91LGyUt0SAybOO+Fv9U2sC3J1nqDfuiWvXlHgrxrQP4cXW6yFw65
 iJDYRANMJQjPXbs0ErV2SR5/EVtmDUtghao7iuU9MaZI+daf/zcwOBi/CcI4l+EACod5
 kp3ulexAiyzfZHp6/OQ1J3Ih63Y7+wBE9sfhg62oBeBnkXGAFCo7KAvJL0g3wDyHzJO0
 ue1lF64V4m4/QPX5hJzFsgFBTWTeK0kVP7+uCe7bNdi9ySBpydyXdBZfaplMNpFWOviE
 VjnntOFRak+vXbMvAq1D7sWwgrBLaes8fVSTaffAa6uOaynL1rAEgyWW92/ZzoJEpBg3
 +B0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701140371; x=1701745171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cGqe/0NyCKHqcz+orMu1/dzDvQqUZWqQf2fh6TwcQ5g=;
 b=slcVoD9zmD/6doD4GvjSzr9EwoqqQqKzLj/uGFS7BVQuEnt6F3uNIByyvhdJb3etoX
 kWY37QNFpO16x8ZvBIY6+ye4WrCXrpSMRdcTct8gSQz1a+rLyJ/Tqx0ng4pznQ/ij8tk
 1RNkIr625jNb1HSL/TEKHWqoUD8/iEt6YoN7ipmpvpe/uBo5y3SIhNp8MFQhVp15EjjS
 qVoDgINfiZPWy5pz4HIoDPPCSd9DsXW9AGQxdiD5oJ26HatMjVPlwG6hPWJ40qaxDUb8
 jdOzB2iT6ajsqrTifyPGZJRGtF0jSCN+UYYVeWz6DprWA5jWDqSHakpUgISt5mRen8BL
 Z7FQ==
X-Gm-Message-State: AOJu0YzjCb61pPKAT4Z7LLb8mn80WutjKzIzB6NXaeCr40RtmjP9Dw9W
 0dO+QfxYILTSk1MJTXJS3DMJIk7LG3fkJGK0U9M=
X-Google-Smtp-Source: AGHT+IFvPkw0+UuPKQ1kmNaq0oy0G8Aux73YS3/4hd8lEolgab5rKz2WEgreguz5EOhEp4HIehAwyRnccwGTBideDaI=
X-Received: by 2002:a4a:3011:0:b0:58d:9ff4:7646 with SMTP id
 q17-20020a4a3011000000b0058d9ff47646mr2343872oof.4.1701140371621; Mon, 27 Nov
 2023 18:59:31 -0800 (PST)
MIME-Version: 1.0
References: <20231107190601.17151-1-semen.protsenko@linaro.org>
 <CAPLW+4=nvd-4WR5duO9N0cbYRfoG63N64jf0uXtN_Rd0LmtpGg@mail.gmail.com>
In-Reply-To: <CAPLW+4=nvd-4WR5duO9N0cbYRfoG63N64jf0uXtN_Rd0LmtpGg@mail.gmail.com>
From: Minkyu Kang <promsoft@gmail.com>
Date: Tue, 28 Nov 2023 11:59:20 +0900
Message-ID: <CALrBrZ1AsQ5o1egh-_b6bWorvKNue41yRsv3pKM6E5HBt6aJxg@mail.gmail.com>
Subject: Re: [PATCH 0/4] serial: s5p: Cleanups
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Mark Kettenis <kettenis@openbsd.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi!

2023=EB=85=84 11=EC=9B=94 22=EC=9D=BC (=EC=88=98) 02:40, Sam Protsenko <sem=
en.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> On Tue, Nov 7, 2023 at 1:06=E2=80=AFPM Sam Protsenko <semen.protsenko@lin=
aro.org>
> wrote:
> >
> > A small collection of cleanup patches for serial_s5p.c driver. Should
> > induce no functional changes.
> >
> > Sam Protsenko (4):
> >   serial: s5p: Remove common.h inclusion
> >   serial: s5p: Use livetree API to get "id" property
> >   serial: s5p: Use named constants for register values
> >   serial: s5p: Improve coding style
> >
> >  drivers/serial/serial_s5p.c | 71 +++++++++++++++++++++----------------
> >  1 file changed, 40 insertions(+), 31 deletions(-)
> >
> > --
>
> + Minkyu
>
> Just a kind reminder to review this series.
>
> Thanks!
>
> > 2.39.2
> >


applied to u-boot-samsung.

Thanks.
Minkyu Kang.
