Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B267CD98D2
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 16:18:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 471CE84869;
	Sun, 14 Jun 2026 18:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PUzPIOsn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4934784874; Sun, 14 Jun 2026 18:18:47 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63FB78485F
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 18:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-691c5776f35so3936105a12.3
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 09:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781453925; cv=none;
 d=google.com; s=arc-20240605;
 b=h7orEnMBSqEx013AbcI+nqdVQmZivHVWAXKkJQDhdclzeQdCd0jGSdOwIY+5lKZURi
 LNmaNkQWyPtbpC8Plu6AeEFkVCnQ6dpa4QOvO9lh1Neorm6j8takp+MUS04Qkld2Le8n
 pIxnXutf5pM5pud7bl1oUvqzizFAxTY7u/YHz83ATMJiTWsTFHrfULbtcTWEkuebGM8v
 GDbEvcNxU9Ce3aaeRzmcKIZGNRUepMzYRslI2BIw52AsNhwWjw2JfSodebVJVMielGsz
 ja2l6+jBQIvOC3Vnwbsfm7Ziyypbc8xyOQx/2SXAI+XuIyV4L7XDxppt6l34o0d1NPr2
 sOkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nbtJXqbu3sNVldUcfmIMEC5dnxvfI6KR2fVkmo9Sfhg=;
 fh=zR2buvS04tl8yfD/I/5YjPdhsEu7HKufx604qAmmYsI=;
 b=Ohh9UBL/JhulGRdl1Cw1aaY90X3uTMz1yVk2y8lsLMzZ4cHc5rGnsHMzGabGIOv/Vz
 PVnv5yGqQDWe7Wi0Slyr6bNMkb3f1tyBXYlTB5+ggZxPjtIfA5YJjA2zFqIft2pRLQ+x
 G9p5yMha0S7hntWlyKj6KUwnTcYjHmhHjiufVop3FZI1/VdXXSNaXCyVHFshodH3wOgl
 T70Cl76d9FwVRBq2CScuQwYDkAqj/nE4VnK80VqllCIacnVwQNwCiVYM9dpUxRqAzAtO
 R8G+Gl07IXwVXXkJiW73cV9Bor8wcthz4YN+Z02xc1KICpiTvIKfLbY9qGGNV7kozjlA
 w5Tg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781453925; x=1782058725; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nbtJXqbu3sNVldUcfmIMEC5dnxvfI6KR2fVkmo9Sfhg=;
 b=PUzPIOsnF7E6KoNeA6fBLRbD4AIj8koK50C3GzChU0n5kZFdOcR/QARb2lvCJu1BR+
 Fp9jVzTAGh/Ykgo0oPDdDBnhxx/amhwdzTFfkLS7e2o42yI7MTdPSvX9WzhcjL00fwn1
 YQLjjx1CyCWp0FH532KwPi9vHTqEtrhyZr6vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781453925; x=1782058725;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nbtJXqbu3sNVldUcfmIMEC5dnxvfI6KR2fVkmo9Sfhg=;
 b=JjidbcGgLm5/B7yEAcCehmsx74HaPd3tIcY/UQR6V2TtAC75CJm60P6uEnbiMQuDM2
 QSiKIsAPB9UzveV0PrgtIx3Gtq7HcSrq01siqbokCjWb534ecAB++UuWri4qsp5O2CFY
 UfipTof1Kf1WMcPWbUYE1mlDbv4B1rn+Ld3T7fRl5DHLpgdzWCG4C2FW2JWmXdRRxoun
 s3c1pqy4Qf+PHYusGi1gIaQELdsyucVhYbnND4sSuNxamAE7CxZ/G9yqh/oq2re65CNK
 dsvxX6YjvM+AI+21VQbwdNCotOSBJKdUUJ2NRA8axf+I6GukeCj0mFJCRtyiDnaRzSrv
 yZ6Q==
X-Gm-Message-State: AOJu0YzaZOfza3oVbMt6GUi00GcY0limzS9r75ad0ltCSzRt3IOkvoqT
 oq0CtB6zBxCL43OaJbeF/y4BufSlDbsApVcxJKvEshTBd+WVOMBjn9X5wFJSZfS+hLrHljvhdln
 oWjETqq9YPHOQmkx9fk4y2Vri7Zmv/iUmM7oneZkp
X-Gm-Gg: Acq92OGWZqi64Z1L8lz00Wmvqkvs3GuOfoC5yk6T4CzwEj9wDcwPmQXZb0yo33KxSka
 hSZaCAHlBMJ1f/KiOzd0OE3NVC35pn3pF4Oa6qjaxoUTeVInKG2zfmNI7aI3dryE256o/T5cM2k
 ifDDxPZjmz6jCCvNMcx4atXIGSpHQbG8dt/bOV+hySnfwuUVf2oW4QfhbLoLGcoJ61cKarEqMHl
 d5Zg80KGyKiCzAoHuXWgo5bxyqqp3U+p0BVpOreXbCzTbZWdD6fCOaRdYG2qbHJqPGl/tN+elF3
 0rS7tg==
X-Received: by 2002:a05:6402:2354:b0:68b:a17a:f368 with SMTP id
 4fb4d7f45d1cf-693c69ad7c1mr2520324a12.0.1781453924842; Sun, 14 Jun 2026
 09:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
 <20260610-android-binman-v3-2-710298a38fcc@samcday.com>
In-Reply-To: <20260610-android-binman-v3-2-710298a38fcc@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 10:18:32 -0600
X-Gm-Features: AVVi8CdZMCxWiVBhZizgcASNPd_DR6czKguMB5rWPlFLAjWu8ZU-ZgKAqITEGJk
Message-ID: <CAFLszTitOp3NRTC3Hvvh1tvBkLqdjVZ1wF0jgtc6ve8-8HZOjw@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] binman: test name globbing support
To: me@samcday.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>,
 Yannic Moog <y.moog@phytec.de>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Javier Tia <floss@jetm.me>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>, 
 yan wang <yan.wang@softathome.com>, Marek Vasut <marex@nabladev.com>, 
 Denis Mukhin <dmukhin@ford.com>
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

On 2026-06-10T01:27:41, Sam Day via B4 Relay
<devnull+me.samcday.com@kernel.org> wrote:
> binman: test name globbing support
>
> This makes invocations like binman test testAndroid* possible. It also
> composes well with the previous commit that adds support for multiple
> test names: binman test 'testAndroid*' 'testQcdt*' also works as you'd
> expect.
>
> tools/binman/cmdline.py         |  2 +-
>  tools/u_boot_pylib/test_util.py | 12 +++++++-----
>  2 files changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
