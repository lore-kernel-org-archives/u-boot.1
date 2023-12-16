Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C9DC46CA2
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C742A87C11;
	Sat, 16 Dec 2023 19:48:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SrsWUjBO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 959F187BDB; Sat, 16 Dec 2023 19:48:23 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DC5A87BDB
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dbd085edf43so686962276.1
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752500; x=1703357300; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YIeMeq6YiZezYm8BiWkj136DvZCqlRY1wUErOF+tHE8=;
 b=SrsWUjBOonUHI0B601VvCkEoPDMpQcwyawz83PWxMh+AltjgroshW26audwdVADQ3l
 J8PGqO0LYPioDb9LkZRbWrRoTdrQcauZgC53Y5SysMABj4GvDSspsdxpVh7Zq39264wl
 TYmXZsld38g/6reYlDMeoShjieluWiVkrIYVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752500; x=1703357300;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YIeMeq6YiZezYm8BiWkj136DvZCqlRY1wUErOF+tHE8=;
 b=ag244gqSj4Yn/4cw1gt6a3KIU78CGqOcJ8O9HXxYx02+ldHXwXILo1xjZt1mi6yI/I
 J1Y7T3Jc/IUeCsKPB8NWsU72lloBMrc+aEIgee6eV61EF1hMlmhh9FNTFq+/1JV2ssPa
 OAUEWrFMHGYnXxO5zgw26mxZ4FrqOSd2kV3CyRCuu37VZL5aj+7ccktZxk/f/5pDovQL
 imF+gXskJfdFKldXgkKYC+E81BaQJrgFvElJYhdFKSByvou3g+ofuRnUPfr7DvYP/xcD
 3ZqqHRHOl0b+oCXuYXCLDh6QoaqDcHalNmJ7Jy8etEdUJXVKxHCmsu/g1jLxGU2XjE4l
 79hg==
X-Gm-Message-State: AOJu0YyjeuSHz/ZWWgcVvuHESd52xJCVMMkiJCxXdJqt/NatPqqrwo3P
 jC2iRUz1F9ith9sCfvxDn/5xc5+DKumdannMgh6Yzw==
X-Google-Smtp-Source: AGHT+IGaxThX7hTGFTSh6CNFGQFp5lAJ7+vI5ZEYHD4Dd41RGlXjYT3HYcRWjV5tglZWIOqHHiqoTyQj66J43rfCVCM=
X-Received: by 2002:a81:a155:0:b0:5e4:e7ff:957f with SMTP id
 y82-20020a81a155000000b005e4e7ff957fmr1688089ywg.29.1702752500071; Sat, 16
 Dec 2023 10:48:20 -0800 (PST)
MIME-Version: 1.0
References: <acfe7ea1-a25a-4293-9e05-bfe4ed7c2a05@gmx.de>
In-Reply-To: <acfe7ea1-a25a-4293-9e05-bfe4ed7c2a05@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:45:39 -0700
Message-ID: <CAPnjgZ1CmmEHxOKPRVbo1zjQ8FDQ1HxdU9ww6c5fJBFc7+Dtjw@mail.gmail.com>
Subject: Re: Booting fails on the sandbox
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Sat, 16 Dec 2023 at 07:50, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Hello Simon,
>
> I have built sandbox_defconfig with PREBOOT='host bind 0 ../sct.img'
>
> On the image I have an ESP with file EFI/BOOT/BOOTX64.EFI.
>
> I would expect the sandbox to boot from the ESP.
>
> But when starting the sandbox is does not boot. Instead it shows a menu
> with some Fedora related entry:
>
> Fedora-Workstation-armhfp-31-1.9 Boot Options.
> 1:      Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
>
> This makes absolutely no sense on an x86_64 system. Could you, please,
> fix sandbox_defconfig to boot according to distroboot.

What sort of 'fix' are you thinking of? You should be able to discover
all the options with 'bootflow scan' and then use 'bootflow select' or
'bootflow menu' to choose which one you want.

The Fedora thing is used for testing and development.

Regards.

Simon
