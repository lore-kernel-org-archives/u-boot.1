Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB91CC54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 12:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38C9987E6D;
	Wed, 20 Mar 2024 13:24:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FEFaS/j5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D833D87F88; Wed, 20 Mar 2024 13:24:15 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49B8887D83
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 13:24:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56bb33a907bso253511a12.2
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 05:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710937452; x=1711542252; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5W3Y+HREWuBX4luGzeTyoKbqlqXqAxhI8wEPzGe3KpY=;
 b=FEFaS/j5d458VJpOWcoisg09AwjFzDeUh5uxD5A5NdGzoIH4EXMKejRzVoWvfe7hTq
 iZ0DJ8e2CuKYPEEki6Gmty8iI6E32Q1HP6a22xxzVh+IIiF9auhJLR1WyLjJ871hjDRp
 Bh7+6WzXG2Lsl91R76nJuB1LGpU5gw3WjRndgFwWp2mRzYPBboBGX7YsjPp1OYsgdLRN
 1y6l8JyAdNKkS9NpQ3gvt/V7QXzqzveVnLkiPBVK2lgBKYjfIsOlFa1iDdzF8s8AyvKg
 BLoYDgVEsD4WjrYlQggZiCYcB1uLbKMSBeowO4qrnq04y46/NHzHdNWJvpuYyCV8pWEr
 Oj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710937452; x=1711542252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5W3Y+HREWuBX4luGzeTyoKbqlqXqAxhI8wEPzGe3KpY=;
 b=JPhVYQwEkYsFduXgx1a88HS5D2T+eV5YDucBCeqjMr0V3ykNeFCamMZ/2zi+PaxPNZ
 X6iYCKFVJaypTEh7ZB3BWL8oyIBCFU1bbk3DJjJiJBJURgGdQfsUSn45q5x4Do6C4tLR
 46jhUUSNr3vmclGA2KEkN78gB76UvBOOcdLPcSPIAvYJW4BiBmY5Y6c0cZ8o98tCvR+U
 f4L02S67IuSVDzDWan3JbOFAUEkfJQOvfUPv1MA11VvoiM0vjqtA6veDh4RQbyFGj/5y
 wa2Htpev3UCY8NqWrfvPFT+kXbIAgFtDxpd+Jlh2hbk7AlfhKo2fLBX0QHQnjzJFGvnl
 BYnw==
X-Gm-Message-State: AOJu0Yw0ovAgebkOWNUflzD/XsdtsmMlRk2hoq9KUzoLrYoAbJjAL1Pn
 K7TZbJkoOgqkPp38dtPZ0j+vyc7+NIGSk4yMvQgAw/fpwxBNOM62cDmurbJK0EvLbceNN7W07LQ
 Y+U5TYroJgUPzhJZLgNPehWpN9EM=
X-Google-Smtp-Source: AGHT+IGCN1UX9RUs9+SgPpCmj0J8vT7YarIi1JJm2f+ygyxViD2G4up0vKcvcEza2bb4QxJ9wmB3d09hrYLGKV9Zq8g=
X-Received: by 2002:a05:6402:2418:b0:568:d19e:7ab0 with SMTP id
 t24-20020a056402241800b00568d19e7ab0mr10206328eda.36.1710937451607; Wed, 20
 Mar 2024 05:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240317183029.7450-1-martin@wetterwald.eu>
 <20240319215836.48178-1-martin@wetterwald.eu>
 <CAFERDQ233hBSp9p8sqhTR3XCuvtaDyxq8mQcOfwYWZPEEHViPw@mail.gmail.com>
In-Reply-To: <CAFERDQ233hBSp9p8sqhTR3XCuvtaDyxq8mQcOfwYWZPEEHViPw@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 20 Mar 2024 12:24:00 +0000
Message-ID: <CALeDE9NjrspzqSeCCpcvZpuV_UUWQENf8cNg++4wJ0r=tXeGhQ@mail.gmail.com>
Subject: Re: [PATCH v2] rpi: Copy eth MAC address from fw DT to loaded DT
To: Martin Wetterwald <martin@wetterwald.eu>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>, 
 Antoine Mazeas <antoine@karthanis.net>
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

Hi Martin,

> I reworked the commit message because I noticed the upstream Linux kernel has a
> difference with the Raspberry Pi fork of the kernel regarding the algorithm
> used to determine the MAC address of the smsc95xx.

So looking at this on an original 3B because that's what I had booted
for other testing.

> There is no smsc95xx.macaddr in the upstream kernel, and using the upstream
> kernel is actually the real use case for the patch.

In most cases in device tree this is dealt with aliases [1] to
ethernet0, 1 etc. In the U-Boot env I have two env set, ethaddr and
usbethaddr both to the same MAC address with b8:27:eb prefix which is
assigned to RPi foundation [2]. When I boot Linux I get that MAC
address on the interface as expected.

> I'm now wondering whether some users are using the module parameter
> smsc95xx.macaddr of the Raspberry Pi fork of the kernel to try to change the
> MAC, and put one which is not the factory default?

I would have thought that the recent RPi kernels would also fall back
to the upstream variation too if their fork option wasn't available.

> Does this use case exists? If this is the case, the current algorithm in the
> forked kernel would mean that, the FDT-provided MAC would have priority over
> anything set in the module parameter.
> This is already the case anyway when people give to the forked kernel the
> firmware-provided FDT (smsc95xx.macaddr is ignored). So this patch aligns
> behaviors.
> But we should be aware that applying this patch would change the behavior in
> the following situation (all conditions need to be true):
> - Forked kernel is used
> - Fresh FDT (not firmware one) is provided to the kernel
> - Custom (not factory) MAC was set in smsc95xx.macaddr parameter

Can we take a step back, I'm still unsure what you're trying to
resolve here. For me with the upstream U-Boot and the upstream kernel
I get the vendor MAC address as I would expect. It should work on any
kernel/DT combo as long as the ether ethernet alias is present in the
DT.

Peter

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi#n3
[2] https://maclookup.app/search/result?mac=b8:27:eb:
