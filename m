Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8C9C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 18:43:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5722888D8B;
	Wed, 21 Aug 2024 20:43:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="acLhoV4u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94671889AE; Wed, 21 Aug 2024 20:43:08 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B66DB88E3B
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 20:43:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-202089e57d8so15945ad.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 11:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724265784; x=1724870584; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3e5A/Zrx7EHFJB8X/66W67b5cr2nk+ewJH/NIoq3Epo=;
 b=acLhoV4uyIzTfaPFNj1qqoyM6TnCRs0HPuadY71XmWLTyhJbFqLU5SunyyUGGZ1ip8
 R9ndGdYBnwG5ynjbwwocvPSVM3vOZGWDbqKeWHY3wufWQRCr5VR7UlKUHR0osW3ENLdw
 S1abOJfPsC9cMHNLNtwUBLfW2CjzuWkC+s42xtAHEZWHI4EgsvX1JAsdaaB5jfgw5r+E
 OMEF96ihUFPCSyq0UpNVRVWbMtTHoy5/2gcJZZKe/G4VAPL35vGi6EH5Bv1zJqr8MkQU
 Omvlf3Zq8e/Wxqgd9ny7OOU1x31VH/SOjuaa/6onjup5yR7BB7NQN31vGTBLjs6ACngZ
 QUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724265784; x=1724870584;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3e5A/Zrx7EHFJB8X/66W67b5cr2nk+ewJH/NIoq3Epo=;
 b=gznU30BILlipOeQVjL7IccmEKPBN2m4XxImAfWN2unqnYdiJzQAy4PrBAFwQ1CH9sq
 wmlbE25AIrDkI7ks0qejndwOpSmTsIWgP02c3YQq7DcgfSWSYlj5ax+95UKbycnuv2FC
 9BHod/FaR83tmS8wswEbNjoftUtDxMuMbZ2+JT6C97ZKa/FemWMThLHedRfX1z754ZBO
 gWKhq4V9XIDAf2BldlJEoXyJ7iTYGOPiG0rcEbT/DvcIKHnkUIV93szuq3bK5ZFc+mpT
 m5Ir5fmgXLCjlcI9wPUudFFCKygrVYi1caTDLpZYh36sZ/VoixZV7Px+89dJNjMwPJOT
 iO2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB9Nf4oIAPA9ikOQc4jz584fZmdfY9VH9uL3ORBAQPTQoL8GFADq2bV9CuCwEynZDxZFxJkrY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9mTBETxju/iMNNavpLJMjact+RUcyaY+EbcwShocJbqZImlhv
 lCkmwKTLY8N+y1lOw44AhyrRgMcUcUUB72NS4tN1ZeLRhh5S6mH5DEeXZHhlo7xs5ojt/ZYS+Hc
 cOjm2fqojMSj7SD5A7r7vOtG6H4u6AJ5G+faOWku+GJXuNP5x
X-Google-Smtp-Source: AGHT+IHU3NmhJX21pDEDCzma3WzePI37qZ950byjcNX9oZg+aEkG+4m/kCD3a8VstuR63OlhWmFRoKVj8d+qayYD3z4=
X-Received: by 2002:a17:902:d2cc:b0:201:eb46:1be5 with SMTP id
 d9443c01a7336-2037ef22e4cmr9061295ad.3.1724265783860; Wed, 21 Aug 2024
 11:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <b24ba149599b9e0261676110894d14a0f69eb6a2.camel@opensuse.org>
 <311e1dd1-a887-461f-b984-bfc1807c63e6@linaro.org>
 <ff64557053d3f00d42c1b3a8c0d9237e870b30af.camel@opensuse.org>
In-Reply-To: <ff64557053d3f00d42c1b3a8c0d9237e870b30af.camel@opensuse.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 21 Aug 2024 21:42:52 +0300
Message-ID: <CAC_iWj+qS7VzT89nF5ZO2bHzxRhaM6BRmLQVhipKtFktGfVbFw@mail.gmail.com>
Subject: Re: u-boot on raspberry pi with secure boot
To: Jonas Kvinge <jonaski@opensuse.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Jonas on mobile and on vacation, I'll respond in a week or so. In the
meantime https://www.linaro.org/blog/uefi-secureboot-in-u-boot/ this might
help.


In sort you have to include the efi keys in the uboot binary.

Cheers
Ilias

On Wed, Aug 21, 2024, 20:35 Jonas Kvinge <jonaski@opensuse.org> wrote:

> On Tue, 2024-08-20 at 16:29 +0200, Caleb Connolly wrote:
> > Hi Jonas,
> >
> >
> > I don't know the details of how this is implemented, but the way to
> > solve this is by doing EFI secureboot in U-Boot. The trick is to
> > embed
> > the securebook public key hash into U-Boot, there it will be
> > validated
> > by the bootrom stage and can be trusted to validate the signed kernel
> > EFI.
> >
> > The kernel would then need to be booted as a "UKI" (refer to the uapi
> > group uki docs), this embeds the kernel, ramdisk, and DTB into a
> > single
> > EFI image which can be signed and verified.
> >
> > Hopefully this points you in the right direction.
> >
>
> Thanks, this got me a bit further, I have managed to produce a UKI
> using dracut on openSUSE, this is written as /boot/efi/EFI/Linux/linux-
> 6.10.5-1-default-69b6602716a8442d94a79481993e2ded.efi,
> I verified that it works by copying it to
> /boot/efi/EFI/BOOT/bootaa64.efi.
> I've also signed it now following the instructions on
> https://github.com/u-boot/u-boot/blob/master/doc/develop/uefi/uefi.rst
> So it produced a signed file (/boot/efi/EFI/Linux/linux-6.10.5-1-
> default-69b6602716a8442d94a79481993e2ded.efi.signed).
> So the next step is to restrict booting to this signed efi file.
> But I'm still not sure how to configure U-Boot to only accept to boot
> EFI files with my certificate.
> I don't see anywhere to configure that in 'make menuconfig', of course,
> if I copy the files to the UEFI partition, someone could just replace
> the .auth files.
> Do I need to use FIT image like described on
> https://trac.gateworks.com/wiki/secure_boot ?
> In that case how do I configure the .its file to include the efi file
> and the certificate instead of the kernel, ramdisk and fdt files
> described in the wiki?
>
> Jonas
>
>
