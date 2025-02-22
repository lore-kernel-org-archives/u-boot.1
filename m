Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3694C021B5
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 05:35:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 304A980F96;
	Sat, 22 Feb 2025 06:35:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DxAgWszp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5443380EC0; Sat, 22 Feb 2025 01:20:51 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 701C28056B
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 01:20:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7be6fdeee35so493401485a.1
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 16:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740183647; x=1740788447; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:user-agent:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to; bh=r5KJ4FdEacVvfu6FmTF28EL9z0I01d21Hj3A7BoPr4c=;
 b=DxAgWszpnszS/wyhFJHkjXJUhuRp7sqAcs12C8lbA+XLxiSj0pFmXjaWYOsGU0R0gX
 zxjZ2YmZF/RmlbKzICC4xrw1L9t0YEsFVNWz8XiyDGvriZ7VuCCWu7BPPt8NVY/JtvTv
 BXFwcgbdFJsaPGCfl05qV/IvhPDd7h/6ly5B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740183647; x=1740788447;
 h=cc:to:subject:message-id:date:user-agent:from:references
 :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r5KJ4FdEacVvfu6FmTF28EL9z0I01d21Hj3A7BoPr4c=;
 b=q7v30y7RNBUMIuq7JbbGBntTKPVJJ6iMJAVAVUm6JQuzKTnvW/ANhnuwa0FqTU5e92
 208oU9SYrCQR4k99VQjtPEtwE3YiRga/TRIG4Qk9d6MHpd7EgVhFuAGjfPszP8b8rmd1
 RDDE6gQ4YALRJyaopQC9fWjILtr71QN3fGit+lqPGyn+2YROoxzeDG+4lBJ+haIFjWjg
 up7fl18lLPNAOK8NXo50c7TG3t+RVber0gAnFRaTzMJyRh11PYe8RjLvRYVD2gaAkS8p
 MlkVxCIJXAM3dspRbLCgainPCPdMLTyNNnzRlB29zyfbTBxPBzWY/qqxWBBBoHjg4kLk
 gi6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+B0xzh9G8oCoybXeq3fFab4X/SYzyJGs/yixTneDMA75Hj+wilwim4fcOXdYLwS1p5vh/C34=@lists.denx.de
X-Gm-Message-State: AOJu0YzynRb0ojSwnvCjYiI7PauuyZ7orNRNvVlMypaXG17CVObjNJAe
 KDylJRVc3EQDu2g/ReAFp1vL9ufwmqRyQ9JV29oSj84NP2TlxQ6bCaeffeC7wgZFdSJaWph4rSJ
 1wS7hgQtzSayEK7ERj2QEegJAReXwtL4vc4Di
X-Gm-Gg: ASbGncvx5pvMUMrohNf96STt7h37/5M0xBfs0dEXiI/cflIaN/0mOl4ISXmcXrHEby4
 6KEB8vjgyl2kKVf0EimmDHaq/ZGnYXAGxLeH6rPhwgoXKNLn7+NZep9JGfxiFu10603SpZsgdqM
 yHSIk3/S/1PMzoVnKApuafkIsKXD+HibBzhW8=
X-Google-Smtp-Source: AGHT+IHYeWyLft49A1g57yl+Oomt+Tjn5k0S+3wzY3x1wSTUxte+VoZOAxyeZIiOomk1acM8/+e/hqWMFV1qHUlUvvw=
X-Received: by 2002:a05:620a:171f:b0:7c0:b0a8:52f8 with SMTP id
 af79cd13be357-7c0ceef864amr698718985a.23.1740183647291; Fri, 21 Feb 2025
 16:20:47 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Feb 2025 16:20:46 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Feb 2025 16:20:46 -0800
MIME-Version: 1.0
In-Reply-To: <af7c7c35-04e0-4374-b99b-addeec485619@linaro.org>
References: <20250220205900.3127680-1-swboyd@chromium.org>
 <af7c7c35-04e0-4374-b99b-addeec485619@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Fri, 21 Feb 2025 16:20:46 -0800
X-Gm-Features: AWEUYZnukgN15pHklquCIbsRH0p2eLXR54uptm_hOdruPRdB_AIB9K3F3wsEiwE
Message-ID: <CAE-0n502oMFrpxpu1bdh2zGj4--SybHbAPE1ndXr1f90vTme1Q@mail.gmail.com>
Subject: Re: [PATCH 00/12] Support to run U-Boot on sc7180 Trogdor Chromebooks
To: Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 22 Feb 2025 06:35:05 +0100
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

Quoting Caleb Connolly (2025-02-20 17:00:30)
> Hi Stephen,
>
> On 2/20/25 20:58, Stephen Boyd wrote:
> > This series supports running U-Boot as a payload on sc7180 Trogdor
> > Chromebooks like Lazor or Wormdingler. This is a jumble of different
> > patches to get to the final goal of booting a Linux distro from the eMMC
> > on Lazor. I've yet to craft a USB stick with a stock distro but I'll
> > probably do that next week.
>
> \o/ wow, this is awesome!

Thanks!

>
> you might have some luck booting pmOS, we build depthcharge compatible
> images for trogdor
>
> https://images.postmarketos.org/bpo/edge/google-trogdor/
>
> There's also a generic ARM64 EFI image that should work. You may need to
> edit the image and remove efi/systemd/drivers/dtbloader.efi from the ESP:
>
> https://images.postmarketos.org/bpo/edge/postmarketos-trailblazer/
>

Cool thanks for the pointers. I'm loading u-boot as a payload from
depthcharge so that I don't have to remove the write protect on the
flash. It's the altfw boot method.

I tried to boot the Debian ISO from a USB stick but it looks like the
FDT memory node isn't modified when I use u-boot to load the DTB from
the one flashed to the eMMC for the ChromeOS installation. Does the
efi_dt_fixup_protocol run in that case? I've never tried any of this
stuff before so I'm learning while I go.

I've been using this sort of flow to read the DTB from the FIT image
that chromeos has:

 bootflow scan -l
 bootflow select 2 # Select the MMC partition for cros bootmethod
 bootflow read
 bootflow info
 fit=$hex_address_for_FDT_from_info_above
 imxtract ${fit} fdt-22 ${fdt_addr_r} # fdt-22 matches my board variant
 fdt addr ${fdt_addr_r}
 load usb 0:2 ${kernel_add_r} /EFI/BOOT/BOOTAA64.EFI
 bootefi ${kernel_addr_r} ${fdt_addr_r}

This seems to work to get me to the installation menu but then when I
run installation the kernel doesn't boot and it looks like memory hasn't
been updated per the earlycon info that I see. I'll continue debugging.

> >
> > The first few patches add support for the particular SoC sc7180 used on
> > Trogdor devices. The next set of patches move the coreboot logic out of
> > x86 into lib to find the coreboot tables on ARM and stash them in global
> > data. Then I have a handful of patches to let the coreboot commands and
> > utilities parse and populate various things like pstore and DT with the
> > proper data from the coreboot tables. Finally, I add the calls to
> > coreboot dram parsing code in the snapdragon board so that if coreboot
> > tables exist we get the memory info from coreboot instead of from an
> > earlier stage DTB.
> >
> > I tested the spi driver with the crosec command. The cros bootflow
> > method almost works, but it seems like chromeos userspace blows up
> > spectacularly likely because crossystem can't figure out what board it
> > is running on. I don't really care too much about booting chromeos
> > userspace here so I'm going to ignore that problem and assume that I can
> > boot some Linux distro because the eMMC can be read by U-Boot and the
> > kernel boots.
>
> Guess it's time I finally get my hands on one of these devices :D
>

I bought a Lazor from eBay for a couple hundred dollars refurbished and
it is basically brand new because the battery was replaced. I want to
get the display working, which I think will require me to port the dsi
and eDP bridge code over even though coreboot would have left everything
largely configured.
