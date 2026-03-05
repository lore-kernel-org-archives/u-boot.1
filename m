Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5C3F47CA9
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 18:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07A2B839A8;
	Thu,  5 Mar 2026 19:49:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MfWz3IZz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C3C383F2D; Thu,  5 Mar 2026 19:49:43 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A87681E18
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 19:49:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-65c5a7785b4so12510799a12.1
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 10:49:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772736581; cv=none;
 d=google.com; s=arc-20240605;
 b=BWsbuhcD2TzFCk12AKwPhuQYMhsUeIIIKRrBmrDSbj30QpGOb1qR7RjGtpRmi5qM/g
 ozSuICaGxgVCLUAnYGU8O6fGr7qoaDCp8/5tRG7hpfEeQkHgFPPJOk4P7Fh0VCusS9HT
 VeCG/BaCzZoJdVLwaRXFQEGbrCxji3+9XlWiqvdmFetbew3QqH9ho/fRU4VrDZLs6xk8
 jiOLnRhwk3nETU7eDsNWi6JmEIXQ8dOU7JOFgxNywiyHtp7su8vhQnZdlERbJ2F17h9R
 bN0g2ZixoG9xDFswwHr3N065yCYFu2sqsjb4gicL6qLO13gAltky3+knfNrHbrJF9+1z
 0baw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CUs9eLUwB3+S5IF2KkOhqNJWWPHck2IBTen7bz3xuBQ=;
 fh=BVaHhR1Tjp7gsZhfgsmijfTvCfVKZQSUWNg58kmvhuM=;
 b=VZCVe1XOdz96CZ5YCl3wERSq8N4QUttHT5avbNbM2IaSIhLdA+QvVh3rpfMDy4oQ7w
 73zPPGJxT6wazCDtTL5TFjLMEdi/ohovNW2Ba1vBgbMQqpm3CNuEt4XloXTyZN1aPecj
 3SzQeYeJZZb0tRPv6Z1kyYXVoyp483gM8aHVm2arz+r7AGXxnufAls1VepCRw4kP9gJi
 YTRY3R/YrVXdzfS/Pl2UgSl6Ko3tP3FdeWkeq7EsgO1/xTcWMjUqlnHFWp6bAck36HfX
 OS/9/PMqeEkpCMRnoVfy4KXMsy0UBx52GV6vnLJbvvnf9mE9EeQ5H03zsRWIHslmpwwJ
 OnoA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772736581; x=1773341381; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CUs9eLUwB3+S5IF2KkOhqNJWWPHck2IBTen7bz3xuBQ=;
 b=MfWz3IZzYH7Vr1pzNaMrVQXS0H350RWLnRlc5RUwhToV9frZ1fTQv+rB0hxysLHrCA
 jsp0Ow5gnTyyfaIARN6AAqB5Swr11do7iX3qzI5OfDqude9AYxkrGYIC0Sp0I9zNdM1o
 lHV/LuXQvXuF+f5/fv31alot3uGjxawEfCUkdNJHbDMiJBAt0lNgCrkwPRGj8bfqFmXt
 GWwNMdYw8YuFj0zpdkUHq14kyFbkroCmwvSRlOV8FDQKGtEolp4/tfvq8K52JglwH7cz
 u/w+/f4lpMhvqLDxHkBCaioC0nwuE6ErAqJLqMeOpJQ0qfHxr+jpWp/1DvYo+fIGFhke
 XMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772736581; x=1773341381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CUs9eLUwB3+S5IF2KkOhqNJWWPHck2IBTen7bz3xuBQ=;
 b=SMy2SDyeoUgRxI0iYDNwwTfVjyEhuEuBzMfOrfNNwleKrjYoyjb+hEsWuAcl28p942
 +uQ6nsSaawaDBzrUyXaoWDVbEMCfxDKAGt6AldYV87rIhAXJsqDjZfuHMXXQpZC39qSM
 BSVCr83BQUlocAHkgK1gBDkl9pAdnMc+qU9e/n5VyIyA0BY6lsNelUMpl7T7kN2ozblt
 SUOW1TlNa6oISXPstDNpV+uxBA6OS5TcymtsVhEL/2FzQUbu3MhyVShdlQKhGUFqlkCe
 7QLrwqWsNm9ZFdJE7uJ4oTFjLV0BIfFXG2d1Mp/Qzfk8CIJPoZxj6fVLJCbV3INOxh4w
 0BvQ==
X-Gm-Message-State: AOJu0Yxn0uM7SWUMy01Y8O2LGYOPtkSfEhS6fc4CdjnEPvYPvdU5E06r
 MoVKVW5QItzeyyhIu3YirUxw6ZiwS4zfFEXf8DzApG8K6gDeFu8biCGhhWsXqhfRRNYyBJV06uw
 wW95JQ0QAUbuPGsCFKzy1oiGHe/j6T/8=
X-Gm-Gg: ATEYQzxYQgPn1h1x3mNtt1TRUrzhMt1mJavkoeS5Pg6zP/L5i6YB2buJTMCCrQ7x5tX
 Pkvdyb1RKfCmcPBfTMmrn6zZSzHMmhBplIltC3efPR8IMVOkSf9iXPHPd1tiz9YopD6L37utF5g
 JwBpGE36hQpXsd88BT6cMo/+djRnkQ1nXEVogQTuB45Vgd0K58me79MIE995IwpFYFtBeQmfmtr
 JlU5ASvEWZl5+F/n+VKaLrA4PndEPkepKtj3dEulkznsfTU3ESuoMIiwFF6ng8XFsYN1tOtmyEL
 PGj4JYx4X+OVSvj1v+FtOQ2R4ycNRrvdZWsVw134H44mdIotcd7OjVCqpBrylOAJyrCB2imDjM3
 6nZEYWVC1rV26tVpFyZIuxbbt2/Np9YApFjxbMjLa4Yb/5iWA
X-Received: by 2002:a05:6402:2753:b0:660:dca2:d1f4 with SMTP id
 4fb4d7f45d1cf-6618874c172mr261729a12.1.1772736580651; Thu, 05 Mar 2026
 10:49:40 -0800 (PST)
MIME-Version: 1.0
References: <CA+V_-YSfX5aExhhpXp3PMdbm8qseyJqTJc7Sm8vM2sB_br8i+Q@mail.gmail.com>
In-Reply-To: <CA+V_-YSfX5aExhhpXp3PMdbm8qseyJqTJc7Sm8vM2sB_br8i+Q@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 5 Mar 2026 18:49:29 +0000
X-Gm-Features: AaiRm52VhB5m8vdYBO6iXJBzD1iASDedYEuXzQrhFL1k8PnTH4NUxF4ZyfMii-Q
Message-ID: <CALeDE9NFvP+8Wd8BiHLZjV1u0=w2W4Yzc0K_-OST8jgTQdH_zQ@mail.gmail.com>
Subject: Re: [QUESTION] CM5 / BCM2712: RP1 UART console support in U-Boot
To: Chris Punt <chris@janga.la>
Cc: u-boot@lists.denx.de
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

Hi Chris,

> I'm working with a Raspberry Pi Compute Module 5 and trying to expose a
> debug UART via GPIO 8/9 (UART3 on RP1).
>
> In Linux this works using:
>   dtoverlay=uart3-pi5
>   dtoverlay=stdout-uart3
>
> However I cannot get U-Boot console output on these pins.
>
> My understanding is that access to these UARTs requires RP1 support
> through the BCM2712 PCIe root complex, which does not yet appear to be
> implemented in U-Boot.
>
> Is it currently expected that RP1 UARTs cannot be used for the U-Boot
> console on Pi5 / CM5?

That is correct, ATM the uart10 which is on the main SoC is currently
the only supported console option.

Generally we've only supported the default console on the RPis so it's
possible that even when the RP1 support lands there may be more work
to be done to support non default UARTs, the driver itself is standard
pl011 UART so the driver should be there.

Peter
