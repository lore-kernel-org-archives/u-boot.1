Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAC3C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 02:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52E9B87613;
	Sat,  2 Dec 2023 03:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WG+kwKqa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5204876AB; Sat,  2 Dec 2023 03:28:33 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B6FF869DA
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 03:28:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-58962bf3f89so334396a12.0
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 18:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701484109; x=1702088909; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFscTaIjOA3q34uLxXE9kPLWiZJMVzJ2u5C9OquhHuA=;
 b=WG+kwKqaZgDKDFM0r+D1PXbfuGV66cK3WBiYRMvOQkCEeBRhJR5TYRCr0LP7xb8Cp7
 z0goMZBMOGy0AmPdk0U3gWqVMQL2oiRCVBj3WDWhX2wmREjHqjh1+NZZWKHe0nmuaXiu
 XYI8rHGxg2FcblWPje43XHjafisH4gYt6/ZtGxfR4Vg94vl+TdqOmGtFF4gRfT0+KUAZ
 8cnSddNfxiticTjvwoh2nHG1S82dr1xIYBj4dRNeT4LWBHJ0UEdZKuAvIlClQS6gTWoa
 pyuMWUxBfZidsFjQcFFVNPlQZ0yA2EJm4iE4sY0UAKbIUhlgjDEzKRar8/pt56RJoqKz
 ykDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701484109; x=1702088909;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qFscTaIjOA3q34uLxXE9kPLWiZJMVzJ2u5C9OquhHuA=;
 b=m4J7JIXtPbJYfJL8xMPQNBkCXPlK1SS8EV9KIHbQkFc3F/mPuY6gGryDiDZxNHzzJJ
 OrUElfrSP6IT0W+ixbXYiwoWlDNmF9g1RMOHNpL66WusUEinSqPosX9TYzc0jy7jmVD4
 GoooPkgOTnR3lGcWym7wMNAQLOrlLv2EG8CUYhcgXLWAB+/UQYJgzFlXqQ50iguRdqyJ
 7LsDV1lDfs/VtRW6TXTRR4jD3cils/gBpBGeMYCObS1iEyppot09s3sg8IMrR7/QpqnC
 Jg5MgoZW9YPsGnGdFxHgkGFcys4fUqaV4STDPDMItaksF19FtkOSbt+s50Ln4Vkwj7Uf
 eEzw==
X-Gm-Message-State: AOJu0YyUQIg/CYyIVQ+OX3MUBZ2ClQG3XEUUIonPsaC1CjbrUhwX6IdN
 6UkzijdkH0CfS92uC2/Lr3uqmixmtarF/awOMrDRgudHjA0=
X-Google-Smtp-Source: AGHT+IE0CuYMlKUf8iY+BqRfRicC/amVNx6Oo6KQyKlWkEHAONilyQ4CSHkrXWR1ClXEs4mtiLhOsImAMjkWNogLMXc=
X-Received: by 2002:a17:90a:db4f:b0:286:5123:ddaf with SMTP id
 u15-20020a17090adb4f00b002865123ddafmr5294449pjx.3.1701484109567; Fri, 01 Dec
 2023 18:28:29 -0800 (PST)
MIME-Version: 1.0
References: <20231202015839.213942-1-marex@denx.de>
In-Reply-To: <20231202015839.213942-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 1 Dec 2023 23:28:18 -0300
Message-ID: <CAOMZO5C3ZXRMByx84QrXNn=BbaxPK5pA3KTP7TGCLDjqV1AJXg@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Enable CAAM on DH i.MX8M Plus DHCOM
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com
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

On Fri, Dec 1, 2023 at 10:58=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Enable CAAM in U-Boot to make crypto available early in the boot process.
>
> This has a side-effect that in case an older kernel version contains a
> broken CAAM initialization timeout code, initialization in bootloader
> will help that old kernel version function correctly.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
