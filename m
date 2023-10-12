Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D197CDB483
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 15:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0DED86E14;
	Thu, 12 Oct 2023 17:28:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KeckuzQL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05BDD86DC7; Thu, 12 Oct 2023 17:28:38 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7230486A6B
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 17:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9ba081173a3so185396366b.1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697124492; x=1697729292; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oSN//LiSum67HisSr3psyONLTzfZs01JKAo1iy5uAW4=;
 b=KeckuzQLAMrO/3M8eZNeL5LnFBkX14m9jeyYelDp8ekM1CPre1rxJHt7C36DEjBGVX
 Md3maif8vvlTgCZPlbKRcOG3ozQWr6Tc4QJ9WCvfBSQz/njthE9bxXU2rJa/JVczSK+F
 eb5B5Z+ilQn4yj8g2kwQ4XNiAvU/gTfyBw6o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697124492; x=1697729292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oSN//LiSum67HisSr3psyONLTzfZs01JKAo1iy5uAW4=;
 b=hKsGWBftoRxnbzBzNG2C1uzdO+PyC7/+08NN0da4Y9COw8Fta5O6AVJH0GpypLT/0c
 1dNxA9yBKREylbLVu6e0QyE17iFZwFln5G9bPwmBPqVlPr3/jKswaLG/FruSus6t3tEL
 S3shINxlV7iwPhqDhkO4PqN/JyJH/b5tlofliy1l52EQYpbQGq99OCnSAGLIhGSLRfSI
 AbIM0fzZ6ffcgGQiSDFzlQSdliYrPDnx9CM8z2SY+ITeSKluDpyx3x14PhexAkjs8yQw
 6ySMkwLqOmN+Aj5Bv+j3BRmUpMBjEz79UVkP4OYaLN0vljCWaUXDcPh9PV4GGUiGUJRj
 /Bww==
X-Gm-Message-State: AOJu0YyomScJGsZqntXVztFScTajbkr7KeM9lpxhz8DqcwRjn27heOJ7
 Uee7JmQ7gkLsPrme8fqip1Lp+E8YKUXHLSIbL09w+L3iMi/1Zbw1mDPKyg==
X-Google-Smtp-Source: AGHT+IEeOoTRwvkDzqa9QEihx2XVtTvLJcGMeovSMy5FtJnbcWvNsSvTYV6ahZBSLSCHOhZhacHPoT5n7vgsBcKW7NQ=
X-Received: by 2002:a17:906:20d8:b0:9b9:f990:c701 with SMTP id
 c24-20020a17090620d800b009b9f990c701mr16171700ejc.52.1697124491862; Thu, 12
 Oct 2023 08:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR22MB22626D184E4A7038A3648C97BBD3A@DM6PR22MB2262.namprd22.prod.outlook.com>
 <CAPnjgZ28JE+8Tb4ft-B73fey_TOiWuJ1tyrxgOSwAMEud==iEQ@mail.gmail.com>
 <DM6PR22MB226237E796813B4981D73827BBD3A@DM6PR22MB2262.namprd22.prod.outlook.com>
In-Reply-To: <DM6PR22MB226237E796813B4981D73827BBD3A@DM6PR22MB2262.namprd22.prod.outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 12 Oct 2023 08:27:52 -0700
Message-ID: <CAPnjgZ0Xib632FQmbqfHNwagH3R-5qrwQSnWJMxQxy15QO3q9g@mail.gmail.com>
Subject: Re: coreboot 4.11 + U-boot master
To: Jay Talbott <JayTalbott@sysproconsulting.com>
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

Hi Jay,

On Wed, 11 Oct 2023 at 21:03, Jay Talbott
<JayTalbott@sysproconsulting.com> wrote:
>
> Hi Simon,
>
> I had openssl installed, but apparently not libssl-dev. But when I added =
that, it still failed in the same spot. So then I just installed all the pr=
erequisites (cut/paste from [1]), even though many of them were already ins=
talled, and then it finally built. So at least I have something building at=
 this point.

OK good.

>
> We will need the 64-bit build. Not sure if it was the right thing to do, =
but I did put coreboot64_defconfig in make menuconfig for the U-boot config=
 file.
>
> If you have a patch for making the 64-bit build an option, I'll need to a=
pply that to the 4.11 branch for this build.

There are some pending patches in U-Boot for distro tweaks:

https://patchwork.ozlabs.org/project/uboot/list/?series=3D375672

I pushed a tree to my github (sjg20) in branch 'cmos' if that helps.
That is what I used for the talk this week.

For 64-bit you need to use u-boot-x86-with-spl.bin instead of u-boot.bin

Regards,
Simon
