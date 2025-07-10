Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABFFC83F1B
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 17:20:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88BE383653;
	Thu, 10 Jul 2025 19:20:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ImPBOvwk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2972483666; Thu, 10 Jul 2025 19:20:56 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 026AE8362C
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 19:20:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e81749142b3so1070886276.3
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 10:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752168053; x=1752772853; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QOHhmMHcmIJvN36A937+1Sef2TDaU85FmtpAICJA27Q=;
 b=ImPBOvwkJ7QdFTRHQ7C7OUU9NEqa+ARwZG6HfUrsxRzEks/TBZaw3NXSxSmlEbOQVf
 Zaw0idRp+pCyseq41Bxcqt20hUV95HsJUUzFWossjsHepvXCYaMUzj2fbdxnrFv2Ar/n
 r4a0Mp86DazvEk7BjwNhXgLarKaO70BjSw/CSzs1oxo/zy7B/Yzjc51EopuwkBht+CGK
 OnsxbRzVC7EGSu2lFRcsvAcrAVKTg1VsmRBGLk1FD2xfrKkwpwNqKdMf85pV/pQdnUAz
 VLmSksajy3to60wp45wbOTwgJSZ2tIiunI7fTYBAtXXojP4mv2Mm2BHgD72nuMwTmabf
 4hyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752168053; x=1752772853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QOHhmMHcmIJvN36A937+1Sef2TDaU85FmtpAICJA27Q=;
 b=YcGG4adMJ90cn3fyRoX/6rhQnQjSDV8e4/loNEi7A2qFIpSnsRIyCK8Kt8WRFvYtUk
 GIxkAyXf/UWjZneiUpew8Z8vLZMp3wQKgvc0FF4RY0qGzqF8a4dHIYoBNCqP5U7Ezyxo
 fVLQ6ilTD/Ldf7semRwz5HtIkYM7Ql9LMOA4Y9WCJZWsS5Sq0yzkoyc4ecddotlA1Goa
 3XzVALqSZB0EVDc2WNaz/Gg0Pz09BI4PFs6PWspP3/8fC7XWtDTwX/QBCG/Jjl1hRG/0
 Ehyo01FZmJSdx2BkrkC9gGUukFrqrsyYH+3WnznHS718K+QK1hzTKcB616lxcvxmajkh
 YIlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSRcJhsvMZCrbdhQcO3zNUFT2HCiiuAERU9bs3mv5k6X/gTxVb3OGP5xPv3XE1xkPY/BM+cYk=@lists.denx.de
X-Gm-Message-State: AOJu0YwIXQH5ZL1vbFR1QdDJl2YYmqIPhZCCOxOoqHuVjWp1ZJVUVWJL
 Urn0JnLvTiGydVjE2YCddYUI7QJlXOVDcHDNOrt7PlBZABs6hNOG02YsTG0jjfWCBFsfdOvBg6X
 yst1/nr17RZzLBPGaaX5aCGldnLreh7JyHKtHYygH4w==
X-Gm-Gg: ASbGnct4a02p9O3iRovDJUINxi8k+VtA1SMx1UgIn1rY64Xskcw2H53E8aFGaIznR7D
 FwViCfupg+7wyMu3+ZcMeGVvCCoeHIvfihojxFDDdKUIMS6IeoGBp2y3ETYqsyNdc6LrM4Ipf1h
 /BcXyHWoZtV6vP2xWmi0A4ChleV5KHjfZPd0/z5BZa8AM=
X-Google-Smtp-Source: AGHT+IEyCr+236tzcjBTGvZ1mXOxTJZwseSLUBIBExC9854LqijdeLZ5X5H+Y3nmkX3FgnEFtAAZU+CprnIXYjmwUek=
X-Received: by 2002:a05:690c:630d:b0:717:b35b:94d1 with SMTP id
 00721157ae682-717d5bbe0ccmr5525417b3.9.1752168052483; Thu, 10 Jul 2025
 10:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250529150213.27149-1-richard@nod.at>
 <1752760284.mgMEAqHVhB@nailgun>
 <CAPLW+4nz81kT=uTofbf86sqQnGZYB2d4A=mr5P3zT0kOstRKQA@mail.gmail.com>
 <18562990.Emhk5qWAgF@nailgun>
In-Reply-To: <18562990.Emhk5qWAgF@nailgun>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 10 Jul 2025 12:20:40 -0500
X-Gm-Features: Ac12FXw2hNcqjywp4YiSWQBt4yHjj48R2cs8Rx2JVB2t2ulxJd1FFeg449juHpI
Message-ID: <CAPLW+4n42ctJC2j5vUnibcWNYr+V1t8jfmD7p1ju95q8R89C-Q@mail.gmail.com>
Subject: Re: [RFC, PATCH] fdt: Make sure there is no stale initrd left
To: Richard Weinberger <richard@sigma-star.at>
Cc: Tom Rini <trini@konsulko.com>, Richard Weinberger <richard@nod.at>,
 upstream@sigma-star.at, 
 u-boot@lists.denx.de, ddrokosov@salutedevices.com, sjg@chromium.org, 
 tharvey@gateworks.com, ilias.apalodimas@linaro.org, 
 kojima.masahisa@socionext.com, upstream+uboot@sigma-star.at
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

On Thu, Jul 10, 2025 at 9:40=E2=80=AFAM Richard Weinberger
<richard@sigma-star.at> wrote:
>
> On Mittwoch, 9. Juli 2025 19:05 Sam Protsenko wrote:
> > > I think we need to distinguish two cases:
> > > 1. The caller explicitly does not want to have an initramfs. e.g. you=
 run  "bootm addr1 - addr3".
> >
> > Yes, so fdt_delprop() lines should be probably moved to appropriate
> > users, e.g. image_setup_linux(). Can you take care of this? I'm in the
> > middle of something else right now and can't spend too much time on
> > this. Or we can just revert this patch for now, to fix EFI apps
> > breakage.
>
> I'll try to allocate time for that.
> Are we in a hurry? I'm fine with reverting but since the next release is =
months
> away and the change is only in next I'd first try to find a solution.
>

No, you're right, we have time. I specifically reported the issue
instead of sending a revert, so that we can try and look for a
solution. So I'm ok waiting, if you have time to sort this out. Please
add me to Cc: when you send a patch, I can test it on my HW for you.

P.S. The change is in master already btw, not only in -next, it's MW right =
now.

> Thanks,
> //richard
>
> --
> sigma star gmbh | Eduard-Bodem-Gasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
> ATU 66964118 | FN: 374287y
>
>
