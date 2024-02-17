Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6E9C48BC3
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 17:39:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B762E87DBB;
	Sat, 17 Feb 2024 18:38:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CAnENuTF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B211E87DCD; Sat, 17 Feb 2024 18:38:57 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B647687CD4
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 18:38:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d0b4ea773eso38879921fa.0
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 09:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708191531; x=1708796331; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aICLmoM0UnDIHGvHVuR1/kWl06Jr8sER1bVuzJXUGY0=;
 b=CAnENuTFI8WDvWu1MefS0OWjTRr40VI9FYT/ZeQhu0KamMjZp3EaZ7+m4sRBWHqR0J
 TNOay4vKQlCE2tYzlJiTY55Rfc4bHyXaMyDMRhLGe1VitjqGCggali44krxNABmzNHaY
 g8TRyxnho6L/8b82LWEBZ0h5+QdWS+OSOgPxswwL54Sn/VJtv/XvUY5PH2Z0u3u756b5
 D3qGQ7wZ67+dXY4BnuTuI5DhxKvEX0EvocRjvIrReu5dkYNJtJNQRD9JqIt75urIgw1T
 LUFYvxeOKfQiG1PcgC3uxmi4XeMDBJEScBw6QlA+fvo4bJ1dVlpBQW2frXzzAu9OWVgy
 jsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708191531; x=1708796331;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aICLmoM0UnDIHGvHVuR1/kWl06Jr8sER1bVuzJXUGY0=;
 b=dMk64TlfHsJFrjbF66Z4KvHpNHuG8AfP+XHEfETfqNGv2XK0aJPcFIvIufzGuPYYCE
 HSdcDtZKiKh01y+vwnKJtpY1nmCu2Z2zWga9h2Rxp11QKZmXjm1gcxzAvOVQV6Jl+Iux
 VGl5Kw2mWr7RLglqSOP4Y1Qo+jLK09+UscZjaYyqbmh7HdaAdjdbJBE6/gkr0Kpp1ibf
 sYML+45qoHYZOlJ+ch9dK6RRJ4ezJAY1H9yORvo0dSBH1WghEGcbXaUYNpueAo0n+3lj
 7GAJMQAzjW7IgGoHJXezgCrydiZdCKGItnUKrRkdtBpk+eRn0E7/ML3JuWGs/3nOgB5K
 9gaQ==
X-Gm-Message-State: AOJu0YzGVzaEkiw9uSlSMvbZ+6+0Xo6b+c5GvZ/pfBCsumbylIhqjsR+
 mkA2iXwHaxHD29PHR0RkY2h1STSiCRT0ncRTVzn5E5inOPiCQ3R4d1bUGUJqDdXlGG+7bDt0Ldu
 EOswp8e1G9dVkoyj4mLWsia6frDs=
X-Google-Smtp-Source: AGHT+IFwSjogzAKnD8atryF3GSWg+ty/09mtPJKAumqenByPdoE4+2tBWrDDg+N2cBSbx66lyEuIiIKxfJaakXFs17U=
X-Received: by 2002:a05:6512:488b:b0:511:86c0:dad2 with SMTP id
 eq11-20020a056512488b00b0051186c0dad2mr5457166lfb.62.1708191530418; Sat, 17
 Feb 2024 09:38:50 -0800 (PST)
MIME-Version: 1.0
References: <VhjYVKfXb22i7OLAE71TUsea5YoQHzRZl2a-pTntu6mAGWiAuixDG1380ukg9ag-1j7_JZUXh8mLYxId4j3mmvjopigOO6NgqVF0aBxC8Io=@proton.me>
In-Reply-To: <VhjYVKfXb22i7OLAE71TUsea5YoQHzRZl2a-pTntu6mAGWiAuixDG1380ukg9ag-1j7_JZUXh8mLYxId4j3mmvjopigOO6NgqVF0aBxC8Io=@proton.me>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 17 Feb 2024 17:38:38 +0000
Message-ID: <CALeDE9NQ9a9_rBmm2YF28S1TqNmW0ucmMH1LQXBVwihV+9LMAg@mail.gmail.com>
Subject: Re: Booting RPi5B with latest git
To: John <therealgraysky@proton.me>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

On Sat, 17 Feb 2024 at 16:53, John <therealgraysky@proton.me> wrote:
>
> I am running Arch ARM on a RPi4B and also on a RPi5B. My RPi4B can boot t=
he vanilla kernel package (linux-aarch64) with the latest uboot-raspberrypi=
 (2024.04-rc2) just fine. Yet, if I take that uSD card and place it in my R=
Pi5B, it does not boot. I only see the "U-Boot" submarine logo in the upper=
 right of the screen/no debug output. Any thoughts are appreciated.
>
> I built u-boot like this:
>
> unset CFLAGS
> unset CXXFLAGS
> unset CPPFLAGS
>
> make rpi_arm64_config
> echo 'CONFIG_IDENT_STRING=3D" Arch Linux ARM"' >> .config
> make EXTRAVERSION=3D-2024.04rc2

Do you have a serial console to attach? The current support is very
basic, I don't believe display output is supported yet, and thinks
like USB for keyboard input most definitely isn't.

Peter
