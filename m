Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9235DCE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 14:36:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D060867EF;
	Sat, 23 Sep 2023 16:36:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jJwCu+BS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B1A7868C1; Sat, 23 Sep 2023 16:36:46 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A9ED8641B
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 16:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-503397ee920so5908938e87.1
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 07:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695479804; x=1696084604; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l3jcuUWf5LSRARLHtpi3YyDMWlo6PT+y7zATTWuVPVk=;
 b=jJwCu+BS1UhUg5t8rmOsNz+tnlZsL+VY2mVQs91XJDj9daPWmQ0z5Kd7mg6gxGb7eW
 4vh8CCjw5C7ZrArKXObX8NTEujB09SiMJaq2BiTPv0thxaazMcq+kLLssFTJMKbfF7Qx
 5MtaI5zQKpfd9PpnQ3ZPjVDASljOsVWIOAgdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695479804; x=1696084604;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l3jcuUWf5LSRARLHtpi3YyDMWlo6PT+y7zATTWuVPVk=;
 b=bG6N+uEhE3lwoi61ReYRV5oqIQdskaKXv8mPTLWgcht5HW/n+Za3fw4JswIiCL0s70
 ZsPubma0bhFvVbN4B1mWPEM3vMNix1ZbjfLVA6ndLH2HalsWsrbctJs6OEOVwElVfQps
 cjmme2lzf8z+W2DbFUaghzUgghn6rd3GviLuNYPQ+FMxMCcJaP8POD4gBUF4hPK7YI6M
 zxZvSaJw5MdxynO0q0iVg3SUYee/4tuQ2+C35fUtNlRlO+uHaN/wyc6E2n3OdJBO43QI
 sG42+cJcDAH3b14HWF1/r0HtomzpiBY30bdkRNOWfYpkF9jYP1kodh75EkcATHjwGd0h
 AM4g==
X-Gm-Message-State: AOJu0YwsCKjIUpArpa5DhDxpuLqZqWYi/M9RAv10Ghgks76Sdh7XLTlJ
 1ULLgyZX2ivV3KZYKBLlDId1jlKgbHZmQMj9Bb0+ng==
X-Google-Smtp-Source: AGHT+IFxZeNXWn+Y4U4I/oJ3WRyq2WM0zPF0Jr/81S5xr7PpMj1N20hhm2RVJ9GXzCBxLSiEXRBJUHqPAmQHBQ9CUOE=
X-Received: by 2002:a05:6512:694:b0:500:91c1:9642 with SMTP id
 t20-20020a056512069400b0050091c19642mr2513847lfe.21.1695479803627; Sat, 23
 Sep 2023 07:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ2mhRhOWoObKbw0R+8jmFT0QY4THpXR=f2s1svi6cwEvQ@mail.gmail.com>
 <e43c5b16-e626-4c7a-9bef-44f192d2a703@gmx.de>
In-Reply-To: <e43c5b16-e626-4c7a-9bef-44f192d2a703@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 23 Sep 2023 08:36:32 -0600
Message-ID: <CAPnjgZ1CEBbeQzKNJBYtQx=rVZayJyZVwo1CPW-ZgFiKNbT6hQ@mail.gmail.com>
Subject: Re: Reading from ISO9660 in U-Boot
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>
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

Hi Heinrich,

On Fri, 22 Sept 2023 at 19:38, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 9/23/23 00:13, Simon Glass wrote:
> > Hi Heinrich & Bin,
> >
> > I'd like to be able to figure out in U-Boot what OS is on a USB stick.
> > For example, with the Ubuntu installer, I can boot it (through grub),
> > but I cannot see how to read anything useful from the USB stick that
> > would indicate that it is Ubuntu, what version it is, etc.
> >
> > Does U-Boot need an ISO9660-filesystem driver for that? Is there any other way?
> >
> > With Debian I can see the actual files (linux and initrd) , so it is a
> > bit easier.
> >
> > Regards,
> > SImon
>
> U-Boot only needs to support reading the ESP to boot. GRUB comes with a
> 9660 driver.

Yes, but this is not about booting, it is about visibility into what
is being booted. Perhaps Ubuntu could put some information in
partition 2?

>
> On Ubuntu server installer images linux and initrd are in directory
> casper/ in the ISO9660 file-system.
>
> There is also a file dists/mantic/Release
>
> $ cat dists/mantic/Release
> Origin: Ubuntu
> Label: Ubuntu
> Suite: mantic
> Version: 23.10
> Codename: mantic
> Date: Tue, 19 Sep 2023 23:07:01 UTC
> Architectures: amd64 i386
> Components: main restricted
> Description: Ubuntu Mantic 23.10
> Acquire-By-Hash: yes
>

That would be useful info. Ideally we would have a standard format for
this file across all distros, perhaps something that VBE can help
with.

Regards,
Simon
