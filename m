Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45107CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:09:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A785583F14;
	Mon, 11 May 2026 15:09:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LUZUa5Yr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42B2883F14; Mon, 11 May 2026 15:09:09 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3597C83CD3
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:09:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3660ab73adbso2595092a91.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:09:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778504946; cv=none;
 d=google.com; s=arc-20240605;
 b=WRQDsYnLKo2kyMvHSzjPr61b11XjpAJyFwEzwkqMOeAqdIwD7EhhVVVKO6lbB5mSLT
 TJUVTao+AgU51ufjQdrQ+h9TWMAJvMnIEitHH07joyHbivAihkefnGugbmRhzz099DJN
 xNR8aUU4bjZE8pWt9TXb1D8vpo0t+fE05tKvoD6BZJWXbdKdziCjad/E5mjuzKFEStbp
 xN6LRm/fBCB8WxM1MVNhqRfnvSdkL9kFRW03mPDfDS4ouDgqjecmdB+YQ5DdVKUsaooi
 fga4M/Y4y47IhVYfETQAluAAoNtITehM7cs4Ks0V6WCRO2gCr6tVCkHKnM3GN9JesE2D
 7fdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qHOgOL4TvKU9imjbsnH+uMy5s7829A/HxVqBKlCpZtg=;
 fh=DHWba/x7tuoorNirX1jlfatUYioWd7qRviNee1YRGB0=;
 b=BIlKyOzko62ehGgKG9h/hW8k+pw5gMYEADOMUKsm7lD+t6Rf8Um/pgnoua90mBDfTN
 hoi2qmrtN54KxGl3IGwVrFp6dUt786F8FpFUV1McaWLnl1ZPG+e/fjg7xPgcgyA48eBx
 353dr8MnzhKWaoiYwKo9vr97sBvI5WHmsAa8LVCLSBghaEbNeZzllly9pqRtHJru2ubm
 3iZ/I+7sSnKKLnwC0aWzYC3NVB4z4jEU0lB4efkZGtq+KThppD96eCAtIqGQmIJac0/j
 8d47xnp9OEpkQBo/Z0OkRx23i41jOhzBFUn78k3OvB8uunlI4qSEnMaSTluwZVa8y5VC
 7hPQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778504946; x=1779109746; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qHOgOL4TvKU9imjbsnH+uMy5s7829A/HxVqBKlCpZtg=;
 b=LUZUa5Yrrujq1rcnzyOaG5cc1C/yaRCvfaeqgkwBDv83SC+uQMrgZP8O5Z9aap2gGt
 InLCismS96mQxmjXs6+tXpvfOQeEXRJMcfU3pYM+jdTBdtg2Wz5OB6Vm/yH1xVOtGDcv
 rM2SXQ6tpPmmkjQXTh9ILqtNwaHo3exB9cB+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778504946; x=1779109746;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qHOgOL4TvKU9imjbsnH+uMy5s7829A/HxVqBKlCpZtg=;
 b=YEt4iXqHpfjIR2vR4YgWMFu/GQlmec1fOmyzkSM34I/aiwlqbsIzOoJWl/dWtJRPgK
 7rC4Jg2e1fymAdn/OAvIWx4FnnqSEC98utfVNiJbJuT3Cmn6s+rzWlWdkdP0ZUTRWqqd
 uuYQ7xdlHKx/MgwU4Ilx0EzseP3xsTw7oJoe+804fW8Ikdih5lSFyYEv2gmQA3YT6oG6
 qZdhiiGe2ubWDXtEd0LZFplqtuOVzixic05ZCMLa7EUMZSVe4xK0ESVGwReVQXQl3G/T
 jF5Rhx1mloWhhnTrcX6yAG1b7uxyZbMXk3aeIUdwfPL3f6mrdodGB4DXvwPuC166tX0i
 JSGA==
X-Gm-Message-State: AOJu0Yyynft+435Io0xKNxiiqe0RTZvIaAcLqSDkzxceKG/ePX2/O+4j
 HTtHEyjo5+z6hLQWC7lBVCYpT/RozIeCCLnK/OCNQQTENW7/D/iVDASlGrnjqRCS4fVOYaXGDuv
 QRME6xQHZmEtsxXpmyxOCLhwkEUINHbL/CmTm34V8
X-Gm-Gg: Acq92OFiI0ssfUvsX+T9SzwDkputIz8U+U0VgWenQmdt9PRPvMrxtjlD+SvDd2rAFgC
 NJBOTTk1u8QWwp2jMcKKGUH3SC6Fc69ceFsfOR+HbKnUj/dEksK/UXXq+aTCFf4zQmr7GJHdm6C
 FuOH6Xlgoi5a0cpTpqLq1z3g1D04nV7je2MMXbSpd9Tjd1YVIvSYdvu6EfkvUzuKksCqozuDPan
 Jyi3BpzZhLJenzGwW1yZFQpMaWA+KZjQY7xBOOQllZSpnVUnGSBWII+L5SXvNiDqBIzt6MRKD49
 4MSvBw==
X-Received: by 2002:a17:90b:1dcd:b0:35f:c493:cac5 with SMTP id
 98e67ed59e1d1-36605a7cc23mr17111092a91.16.1778504945733; Mon, 11 May 2026
 06:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
 <20260510171723.56866-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171723.56866-8-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 07:08:01 -0600
X-Gm-Features: AVHnY4LPxPWJqio-PyTFtaCwnXMevQwcGQFK7Y8GT7pAx10oQAysmmT5i6oZKT8
Message-ID: <CAFLszThsasGe1Efsqaw_bMzkT1K45xeXM22Da+8OGa5HDHHWhQ@mail.gmail.com>
Subject: Re: [PATCH 08/11] video: imx: ldb: Staticize and constify driver ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>
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

On 2026-05-10T17:16:56, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> video: imx: ldb: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> drivers/video/imx/ldb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
