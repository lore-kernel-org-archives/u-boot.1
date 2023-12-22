Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800DDC41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 14:01:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3DAB8775F;
	Fri, 22 Dec 2023 15:01:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gfTGMiZh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF8DD87872; Fri, 22 Dec 2023 15:01:06 +0100 (CET)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C51938775F
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 15:01:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7c5f29423c5so362642241.1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 06:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703253663; x=1703858463; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QVnH+BJhr4h9aM9XiF+3yh7xp/1ECVHso4e2czYVg6U=;
 b=gfTGMiZhUhwEEZ0Wlw7gUZO0DGPS008lF7l2/Y3VcMyhwpisPAV7aP5J60QMfwMYsB
 Q9EITIa/XdJdxfzQ1FGbTDqiv5iw2aD8S3Yp4dD48Tt27UbI81Nmj9SxUxvAn28bnYbm
 ciewXK1EWh24RHttNEOYH5qDw42Ue547gdOB+GFFDWERUclpr/bh9TcpgGdH9DUm1ruo
 JKz5hM9R1sNA1GkU+7AqfmgXey82iUTI9QJNVJUUmqa7Ukdt7Ie4HJDTLSdHVmY+N4t1
 C/RUOs4abxt8ZjfXyBvWPsCrmkn9HGYDJYS7ejYCbjsY582yq6A79mixxVwrk6ySyOaE
 4Zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703253663; x=1703858463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QVnH+BJhr4h9aM9XiF+3yh7xp/1ECVHso4e2czYVg6U=;
 b=wdeUdv4kXmgAsvPuqJwC2I9hWceM9CFt45k8yivcTCi9o7qkFu9TSmM/PcFp812b1h
 PiDVK3AWyYmyRPjQWfYgiTqVkcEoUgsiDvlk4aQEI9CxxE7RXIk90jMSfn6x9X2DL4Xr
 tPZsQw/v1yk1aisLdD5WyIGG8Zht9kYpUCPOT7jk9X7LBtk2TXvkIxswC4RgIymw9dQD
 VP53JFaRGfxpHcI9eftlci+lluVtSnK3Nc0WNK5A+rE+QmaNx+ZuEXiMgI9byI7RVLbt
 sb/QMYCO26OisVSWGNSgaOo5D91xWPEeLuvM0lA89XXM/5TJskF/pzGoTVS8wmXQjH6F
 HEhQ==
X-Gm-Message-State: AOJu0YyHvGHfvTrHILMhTYQpB6acRccer+XD68RdBMgW85yBMVLG9hAQ
 wwkrJEecIuTL5sLaRpKngA3dqVMaQM8jsDNHIM7zvJGS+BovuQ==
X-Google-Smtp-Source: AGHT+IEaI0WFdDBCBKQZmqGZWx+9rOdllCCktu34BFyh9FCLJhv6yfqrIoMNBTzGmyAsEFnjyiG6PAXWZKmY0knwvfg=
X-Received: by 2002:ac5:c184:0:b0:4b6:beb3:99c3 with SMTP id
 z4-20020ac5c184000000b004b6beb399c3mr386922vkb.19.1703253663406; Fri, 22 Dec
 2023 06:01:03 -0800 (PST)
MIME-Version: 1.0
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <20231222061208.3009970-8-sumit.garg@linaro.org>
 <20231222123133.GX2513409@bill-the-cat>
 <CAFA6WYNbLRVZJq_geK4h9Z4oDdJ=8ne39AUqLMfL-Bf4zpnF_g@mail.gmail.com>
 <20231222135427.GB2513409@bill-the-cat>
In-Reply-To: <20231222135427.GB2513409@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 22 Dec 2023 19:30:52 +0530
Message-ID: <CAFA6WYNH=mFKOLL_fz0cu1oKUmjENxf8PMEgv78k5KG61wTO8Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] dts: meson-gxbb: Switch to using upstream DT
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, sjg@chromium.org, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de
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

On Fri, 22 Dec 2023 at 19:24, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Dec 22, 2023 at 06:50:32PM +0530, Sumit Garg wrote:
> > On Fri, 22 Dec 2023 at 18:01, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Dec 22, 2023 at 11:42:07AM +0530, Sumit Garg wrote:
> > >
> > > > Although there were still some variations in board DTS files based on
> > > > meson-gxbb SoC but I think those were minor differences from upstream
> > > > and shouldn't impact boot on these devices.
> > > >
> > > > So switch to upstream DT via mirroring amlogic/ directory from
> > > > devicetree-rebasing/src/arm64/amlogic/ directory. And thereby directly
> > > > building DTB from there including *-u-boot.dtsi files from
> > > > arch/$(ARCH)/dts/ directory.
> > > >
> > > > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > ---
> > > >  configs/nanopi-k2_defconfig           | 3 ++-
> > > >  configs/odroid-c2_defconfig           | 3 ++-
> > > >  configs/p200_defconfig                | 3 ++-
> > > >  configs/p201_defconfig                | 3 ++-
> > > >  configs/videostrong-kii-pro_defconfig | 3 ++-
> > > >  configs/wetek-hub_defconfig           | 3 ++-
> > > >  configs/wetek-play2_defconfig         | 3 ++-
> > > >  dts/arch/arm64/Makefile               | 9 +++++++++
> > > >  dts/arch/arm64/amlogic                | 1 +
> > > >  9 files changed, 24 insertions(+), 7 deletions(-)
> > > >  create mode 120000 dts/arch/arm64/amlogic
> > >
> > > Do we need all of the Makefile portions of this? One of the things that
> > > works today is that trees listed in ONFIG_DEFAULT_DEVICE_TREE (and a few
> > > other variables) will be automatically built. We might just need the new
> > > Makefiles to just have:
> > > include $(srctree)/scripts/Makefile.dts
> > > and then the trees a given config will need will be built.
> >
> > That sounds fine for Amlogic SoC and many others too with
> > CONFIG_DEFAULT_DEVICE_TREE="" CONFIG_OF_LIST="" options available.
> > However, if in future we have truely generalized U-Boot (like efforts
> > for Qcom platform) then CONFIG_OF_LIST="" may become an overloaded
> > choice.
>
> I don't object to listing them when needed, I'm just not totally sure on
> how the use case really works out. But we can cross that when we get
> there, too.

Agree and I have similar concerns about it.

-Sumit

>
> --
> Tom
