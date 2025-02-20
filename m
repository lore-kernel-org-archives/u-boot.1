Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60810C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 12:26:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A977801BE;
	Thu, 20 Feb 2025 13:25:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eBUnfFYE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3979C801DE; Thu, 20 Feb 2025 13:25:57 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E3E08007D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 13:25:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e02eba02e8so1153393a12.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 04:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740054354; x=1740659154; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HRgGvpPuDmY9W47mlQ1naetSHLOHYTuuZoYyZTEoZPY=;
 b=eBUnfFYE/HRAWxuO2NO7EDaTW5Gl55c3kIFZ4GBu5qGpFOhaVsrCmEr306ZDpSGqot
 4jJMO/mE844CqbaefLz9KnMPKMtW/1OIaZi1cjMG1lZrIEdgp4BOztGopLmlDQmQKOso
 AWASxuIhfpEj3tePIWriFnzIVbrAR+Ji+98wGng/WyYMfw54lwo0Pc4+YaKNOvNetQZo
 EnOX+tOcad0B7FYmLzKevTTyeaV1NWIYO3Ittb5F2PF4+4DqM1brn0rdAl27T7V77a6M
 OW1mYCuMRw7DdRXLHm+tcNXR7AnUnFpfQc9anjrDc9tPa72gy0sSe1XwIbZcsdUoMxA8
 4t5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740054354; x=1740659154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HRgGvpPuDmY9W47mlQ1naetSHLOHYTuuZoYyZTEoZPY=;
 b=LvnDwruqPajKcG5dInUuuC7YFbcNNa+EZI8qeL2mDcxsTnRhmAgjwbYoVyEat0AH0N
 HjVf14jTRYUFW/6Zc9CQMXoyo8TECHbfhUs6RxOtz2LHIFwyya75DVaeXw4AP6blVV6A
 3kwe2tDgCFG7cPwFiXltLgEO/f8vbu92ZkbMqVw5Gx3nYy5IQSFgk5QTTYoI7jGKiqRV
 DhVah6JU6lnElnlcaRRbigN6tAOJ3b+i6wSpY76FCbpeHFeTk/gC7nNyxN/sBjr9HqoF
 Sx7bF/qDrw/FFjXvEA/8dbyN3HN3Ck3RpuKcCsRbnqC6vQ9/12v3IJQRUCSdh7+zYklP
 vkHg==
X-Gm-Message-State: AOJu0YzNoWb7wUCD/Bx0kB2PPLOyAAkDp1NBfDwNYXtvjKifYap3xWlH
 pJXe3p4S7qNOHZlqVN4KU3AeKa1IUpRoQaYGSLdRN1GnVie+rAcunsOYfcRfumFD9yE8+MLrwhs
 5VbnQZ+a/kiNl58KYCahNt/Fj2JM=
X-Gm-Gg: ASbGncuwiaAE1eGA7KUw7Vnelc5O3rPSMMgdx+CuTQvmM9IosS43FBLG8QlKjV3Ecgs
 HcNoop4dStPgX+TQlgctjOiKsayPcwP7nlm9bxltkeZifKN79WAS4qgpYTmv+ArmM4yz/opYnPi
 vBAtRUGsWAoRagnsWTlOi/LNfEdMgVJg==
X-Google-Smtp-Source: AGHT+IHVkq8ifAu06W+2OtD9NP4oRTr36DnffqVhrpa8E7mgZIcHN3gKrDJMDZW/tuhCQd2kWi7nJ/LMYAdbg1aMXdk=
X-Received: by 2002:a05:6402:51cd:b0:5e0:5feb:57d5 with SMTP id
 4fb4d7f45d1cf-5e089f30ff9mr7085461a12.32.1740054354201; Thu, 20 Feb 2025
 04:25:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
 <CALeDE9M1gvJ1Z=vNr345V35QjgfGU_Q2Wki5dMF-zAqY-ko=BQ@mail.gmail.com>
 <f5074534-b565-460d-9943-6493174db3f9@epam.com>
In-Reply-To: <f5074534-b565-460d-9943-6493174db3f9@epam.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 20 Feb 2025 12:25:39 +0000
X-Gm-Features: AWEUYZlYU6CEzqwC41vla8uIdXleuYEp0f6cyHjFNIJ54Rn6JNhK4OxDyC6zZfk
Message-ID: <CALeDE9NwC8SGJygparLbL+AfeOCVw6LBxGECvLBFf+_5EA5BpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/20] Introduce support for Raspberry PI 5.
To: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Lukasz Majewski <lukma@denx.de>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marjolaine Amate <marjolaine.amate@odyssee-systemes.fr>,
 Matthias Brugger <mbrugger@suse.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, 
 Tom Rini <trini@konsulko.com>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 20 Feb 2025 at 08:54, Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
wrote:

> Hi Peter,
>
> On 19/02/2025 21:37, Peter Robinson wrote:
> > Hi Oleksii,
> >
> > I've started to look at this.
> >
> > On Wed, 5 Feb 2025 at 10:15, Oleksii Moisieiev
> > <Oleksii_Moisieiev@epam.com> wrote:
> >
> >     This patch series provides generic support for Raspberry PI 5 in
> >     U-Boot with additional hardware drivers.
> >     The following features were implemented:
> >     1) add generic board config for Raspberry PI5 including device-tree
> >     files;
> >
> >
> > We already have basic support for the RPi5 since Jan last year, you
> > can see the patches [1]. This serious should build on that rather than
> > add new duplicated bits. It supports basic serial and mSD support.
>
> Thanks mentioning. I will do full rebase after upstreaming of the
> dt-bindings to the Linux Kernel.


Awesome, thanks.
