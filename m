Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E88CC87FC5
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 07:26:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A320583013;
	Mon, 21 Jul 2025 09:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YiCzuQEW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6F4083013; Mon, 21 Jul 2025 09:26:42 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7621A8309A
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 09:26:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-70e3c6b88dbso27509197b3.0
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 00:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753082799; x=1753687599; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hFvV5mgZBsi9rESWGP7PwQFNzd7Qfxu4NIDzPqCCgsw=;
 b=YiCzuQEW5B6FqA/pjalujyMqq7LrfdXuPtIEGk+Hm5rzk0vt78ztTMAiFiJeBcc7N9
 +ZH7egDhW5SrUo0IH7Y1xfnSjIaJPsnaVSfvUCI2Oxh0slWGAwRRAzriY2ELFxS0yo3m
 r2lEXHkCNE3qwO7mvZtu0Qfv0zRheLGjwRf84APT0Xx+gOff7QPHgHdEQTprilRcUYkJ
 3F6bW/aLlkcnBl5/2tMe1S2AYt5DCuZJL8tJSGgIy/vRpcgqBX52eE4Nx5SdnyhdL+TD
 nvlwT4Dg+FiwEl9VRb532ukyTHPzHsJVylzFGCF3pxar9TorlucQ2F9lLl+MvcHq7qy/
 gh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753082799; x=1753687599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hFvV5mgZBsi9rESWGP7PwQFNzd7Qfxu4NIDzPqCCgsw=;
 b=IDD+RdALMZUtRRUXSw8oLNhxk+9HLkGDa6W0SjoyRCAfnruw16TwNz0efCeaUB9UGt
 T5Mrp/tYu19+CLeU+H5Emrr4SW1O+CsDCUgBKyflPnV03CBovrcO9k/8BsGGMqglVk2k
 wqzZizih7cyNrQM3tJnyoDcufFkdtX3pDqCbffjE4yUCgV8DVbiytxrf9lTwusv6sExb
 gcyxGo5xis87ZeAYZ/BaEFeQMb3c+hyx02X9ZdE6vFnBvtIy8ubwlO/iGx+vUdaCi4sf
 PiTtmfUhkDugkd0suSv1a/AxQAgZJmUm/ZM3+konxD41f/RsYealeeP5D2RYo/d4H6Nj
 gq5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/XDH1Z4lUNgcnVmdxeAJRwsOiHMGucpdUY18pG2lUAcPquBsw4Q+6U9gCTeQw78mtEg7twbo=@lists.denx.de
X-Gm-Message-State: AOJu0YyRelcnRoLUNUe+YPzqrEjQYykpYbZD7m3/k/CztoIMTGvoKgUH
 NIX7iinODrbmg8kOhjWefhoODwkGHGtTZ3xoEa7eCr3GnyuNITx5vWONDywDA5xdPKxROKj85uR
 gIfwerfmt4KU7BX/k9sXLYpfZ27jscwO7g7hZJRnNmg==
X-Gm-Gg: ASbGncsEQFIsA5PZWUycEN0JcZcOHjVR25WXTxxbqtOKGyOttF1SAk1mFThuAL23Zww
 XKDhtwiFGmeJ/InX8/YqShXtvfcHDrjZULdlauYy62gYOvNKsLVrRgKpXXm2prfN+sjq7cye9wh
 Y4R3GoLwtLIbuOh/5n3BG9MFmfNHvf1zZaDBqxf83ICWJHk6rwuRBe5A2n27g/8VNowac7rXUYB
 H3mCCc=
X-Google-Smtp-Source: AGHT+IG1/rVgC+7J4NSipKP5wWpaEEPqqkjnrW2dNCagPuvssqfeFhnLmwIstASj8orUIr2295/lXxEC1w5q+eapAl0=
X-Received: by 2002:a05:690c:2601:b0:70d:ecdd:9bd1 with SMTP id
 00721157ae682-718a9798fa7mr226191997b3.24.1753082799176; Mon, 21 Jul 2025
 00:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250627185723.342553-1-ilias.apalodimas@linaro.org>
 <20250627185723.342553-2-ilias.apalodimas@linaro.org>
 <CAPKp9uZPPOdQi_vFKEjTA4NE3oy0WPth-ugc21wKR7GPu4OD1Q@mail.gmail.com>
 <20250717174148.GO193579@bill-the-cat>
 <20250718-knowing-ludicrous-myna-ff5d69@sudeepholla>
In-Reply-To: <20250718-knowing-ludicrous-myna-ff5d69@sudeepholla>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 21 Jul 2025 10:26:02 +0300
X-Gm-Features: Ac12FXwfhpQ_EqjIybtHt4RjzKY8cYkg3jbaWQw_KBdZy8RMGd4buwrFVgYAJo0
Message-ID: <CAC_iWjLHywMVnh0X6-PdpeuzrQfq11GXvfNPgAvNktFGWiP0eA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: Bump the build system to 5.1
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Tom Rini <trini@konsulko.com>, sughosh.ganu@linaro.org, 
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Marek Vasut <marex@denx.de>, 
 Olaf Mandel <o.mandel@menlosystems.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Yannic Moog <y.moog@phytec.de>, 
 Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>, 
 Prasad Kummari <prasad.kummari@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Michal Simek <michal.simek@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, u-boot@lists.denx.de
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

Hi Sudeep

On Fri, 18 Jul 2025 at 11:30, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Jul 17, 2025 at 11:41:48AM -0600, Tom Rini wrote:
> > On Thu, Jul 17, 2025 at 06:03:09PM +0100, Sudeep Holla wrote:
> >
> > > Hi,
> > >
> > > I see build break with clang after the commit 5f520875bdf0 ("kbuild:
> > > Bump the build system to 5.1"):
> > >
> > > Build command:
> > > $make -j`nproc` ARCH=arm64 O=$BUILD_DIR
> > > CROSS_COMPILE=aarch64-none-linux-gnu- HOSTCC=clang
> > > vexpress_aemv8a_semi_defconfig
> > > $make -j`nproc` ARCH=arm   O=$BUILD_DIR
> > > CROSS_COMPILE=aarch64-none-linux-gnu- HOSTCC=clang CC=clang all
> >
> > Does it still fail if you don't pass ARCH=? That's not valid in U-Boot
> > and can lead to breakage.
> >
>
> Yes it still breaks. I wasn't aware that ARCH= was not need in the build
> step, thanks for that info. I always passed it AFAIR.

Thanks for the report. There's a bigger upgrade we are doing to 6.10+
kbuild as we speak.
That will have  bigger changes wrt to clang. In the meantime I'll have
a look at the current breakage

Cheers
/Ilias
>
> --
> Regards,
> Sudeep
