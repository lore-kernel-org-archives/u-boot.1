Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D01D1950B
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 17:17:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D261483B27;
	Mon, 26 Jan 2026 18:17:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h/7cXrPw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BFAE83B72; Mon, 26 Jan 2026 18:17:28 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 856898063E
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 18:17:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-59b6f04cae6so4904629e87.2
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 09:17:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769447846; cv=none;
 d=google.com; s=arc-20240605;
 b=FbZ/0DFzFmOQH2F3XnT6WhKk0uE8YrfUEQ07lF+WlkR5hOB7UBTOw0HJCbc0OO0HPs
 afXl45Yp21rTHGR893ayzhPAUymc/EYu4fxdy/pEb7kRUHAX3DRVzS8fTy7gB8RbMsCU
 W053r8zZAeX9RpbjJ8MUI05iWS2yO7AFYRMVwUnzI6xiK2Ex2bNZ+685BhOF4IWJIGEW
 Fj4SvtynKWhiOIc21ZoRX4CCelzyFXOizM/coEixoDxHg2Gz8FpoF/N/HLVblMqh6lZZ
 LKKIybKlNayV0/g0OKi0AQTSgeE+v1Wi8d24dyQu8tqT7iSyACgThIHIEN5AN8DG0/KO
 sifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rUtYAmUdcK35Fwijf7BaXpZVwgbmaMLKlPG33t14uvA=;
 fh=0lCQd4lbQfpZRUiS/+m7QEqhokTgoH2l04CtF2iPC5c=;
 b=BVx51J6/hB5xTa7d7/XeDG9SIZ21O98Hb+DThqX7yaPwCl9KVrj7Ok2w11W11Y7EeU
 MO34FITWOqCu2iYfYPu6b/fjQwxXtKnxWiuWYRMclKJcDzbWHlHB8em8zgNhqs3zUHTb
 TqqrDTaodd2eTucBOygLkCdNGdnhDRsgAV8TebA4UmNk14bu2GDfjCKF8YyMhceQXMnE
 DG5IEUaodGVBCOzT4J353oJ3DHAzupGIqGkp1kO2byy62odyQKaSTcc0H4rfboBHk/Bv
 IlDnVtQY3RDO+EgugbnpqHLTNAlSspbZQndhhkfeMADq6Eo2AxOMoABn8vcz2hbqvwWr
 c1AA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769447846; x=1770052646; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rUtYAmUdcK35Fwijf7BaXpZVwgbmaMLKlPG33t14uvA=;
 b=h/7cXrPw/aFAYca0OetKdewxuzZ2+UIJ05VdP+Nd1G4KjZEKBZ5e4xuIaSrPZL4VM5
 CaPgyha9lYgRVxzLcPXVhAmtAdnpuM3hFJY3WCW/MOdPyeHBpsccby5RfS4O8vzhNxtU
 nkqu5XzabFvEopFgFn2y0Sh3uQzCK7NM8dZoVMrJ7QlV9s1ON9d0YDkVDepBbZxl5lMm
 dynv3/1RfGkCPCruyuNbn2a4RpE/14Z2DAAonuHzEe87OxwmmghXePKpmvz+pqG5T1rq
 FGt558wL1VTZFxphxJ49Q5WDccF+hWaqTnYrFOSsFcCg8ZEiJejFLaWvRz6Unzq9iGHw
 VDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769447846; x=1770052646;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rUtYAmUdcK35Fwijf7BaXpZVwgbmaMLKlPG33t14uvA=;
 b=n3EHy5cJO5BROo6nTJTP4a/zeqzGvPigxJvahlj2wvyNQ8nJPhQWAPZOml0CgQW93h
 IBdVG5t30VtcGIB1JvocsIPj5x21HX0Hgldl46IPpiLitnj7A9leD/i4ZVlo3iEJ4o0S
 nCxCOH5EoaWhgyY9+sWFteqaoINT0+YAlYb4Ww3F08UQoJsMY9f0edRf7FeVCiZ3+UMQ
 pTcerJ8awFkRqs73yBZZYpE5mSrRH+xMHR0PDcC0lAz29lDz9SD/eDQBRjEW388iZPGI
 zh+X5gY9s9OJnNKEljs9lB2WGa5mYOrJYrM2DTQnq3t1HHTDgSg+NwDUrWgenb1M+jCI
 ZGHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP+vjaXUELzLzt7S2OPeZJqFybETeg2iYvFJfJ1roYBqhRAgzE20AaMXjiTHUhIKD9y8c91oY=@lists.denx.de
X-Gm-Message-State: AOJu0YzfQoxdP0NLEJRNjbswZhilOwJdnGqC2gXwDDq8fnejgp2FRHJQ
 tv37lv2LfjutFXsrRF8cYDx8jvjgEljoSkRg5UNswqI4yAIicTS3aMgyrHqvBKxgkFBukRgtOJd
 Vg6j5yGvh07CFcXyy1gPNNtG0qXC9Ln4=
X-Gm-Gg: AZuq6aJEOgRrZOywpjSJafh4EgXieCJllCD+RZB6XJbrr8adNWTsg3CNy3FtgFfyZaY
 YW+e74laP8Bqof7r1sIGCQkNyWmk4TEo+RBI7jtO2NPYAxdLLog+KvR0Xgi9V3GGhY458Nd77Im
 C7KDNFlPersE3S7Nw9MxHa6PCEQocONYAtYfm2sfsmU+r+a5oAUFYllKpQUcytmb5KPGMOOeRgD
 S6AGux3m8Blx94ZTPkmKMI5Qru33yWTcAuy4cuodPgpbyj1Gs9YPk52zUTOWUhZGOvm9e62kmX8
 CC8u4omwZy80pL9Nus6BXpxnREc=
X-Received: by 2002:a05:6512:10c1:b0:598:853e:72f9 with SMTP id
 2adb3069b0e04-59df3a86e29mr2187539e87.51.1769447845364; Mon, 26 Jan 2026
 09:17:25 -0800 (PST)
MIME-Version: 1.0
References: <20260123161907.392211-1-festevam@gmail.com>
 <20260123201202.GO3416603@bill-the-cat>
 <CAOMZO5DVFO=A6g1CWOrRbqy4VNgL+VcUw0Q5pgELXm30puGz4w@mail.gmail.com>
 <20260126162756.GU3416603@bill-the-cat>
In-Reply-To: <20260126162756.GU3416603@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 26 Jan 2026 14:17:14 -0300
X-Gm-Features: AZwV_QjUsljrk31K2_EFrrySyW33x0083WU-KyN6NFRC_MLODgEd8AOPSIjKqxQ
Message-ID: <CAOMZO5BJDzeJg6cah4hG2G-gwgi4AA6T7WKqnpspr4_26gUrdw@mail.gmail.com>
Subject: Re: [PATCH] arm: spl: Fix DTB offset after binman symbol table
To: Tom Rini <trini@konsulko.com>
Cc: marek.vasut@mailbox.org, u-boot@lists.denx.de, sjg@chromium.org, 
 ilias.apalodimas@linaro.org, Fabio Estevam <festevam@nabladev.com>
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

On Mon, Jan 26, 2026 at 1:27=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> After talking more with Ilias, we're going to handle this in two-steps.
> Step one gets more platforms booting today. It's *slightly* different
> than what I posted here, however it's binary identical (I just checked
> and got the same checksum as this patch produces, build-testing
> sonoff-ihost-rv1126). So I'll add your tags to the commit.

Sounds good.

When you send the formal patch, I'll test it again on RV1103 to be on
the safe side.

Thanks
