Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76CBEE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 15:57:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 325E18648B;
	Wed, 23 Aug 2023 17:57:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dawes.za.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dawes-za-net.20221208.gappssmtp.com header.i=@dawes-za-net.20221208.gappssmtp.com header.b="rtX5mhXC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C691A8647B; Wed, 23 Aug 2023 17:57:15 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E67A986422
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 17:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dawes.za.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogan.dawes@gmail.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6b9e478e122so4100247a34.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 08:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dawes-za-net.20221208.gappssmtp.com; s=20221208; t=1692806231; x=1693411031; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uWGgXAdgNf84P4Q2USTAwfoSZF0AnTzqGyt3d1V5qms=;
 b=rtX5mhXC4GVe9afx2CPDpRD5GBzAIcZ/eVyfgOlAgjjBI3SoBwRE4ysJ1IqLvh0SD2
 UX+E8vFptnwvVR/ny16Tw8KfIufOzr2bvU31VK9pvbzg4yVA0novAfsOn+vp1VGkQbY9
 SVwlaDMUtcSi/WOemx3aZ9wm65qfrQBuzeOMRPgiNxA5iZs3HamH+yH15Mu5FY/6+OWw
 xbQMh268uqyFPbhRe1z7OcabEt6mvv0jhPE1Suarj66jVFL1XD9ZuaLNDaxuVjYRl24a
 AfF3/WiRCECQPMMln2H5LuEzrrvajSq2d+xfHetlsEqsDJItohN1b8MttquvOcNgI6+d
 UimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692806231; x=1693411031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uWGgXAdgNf84P4Q2USTAwfoSZF0AnTzqGyt3d1V5qms=;
 b=HWNgArhssxb8pUg7Fgiv6ehcON6mzvIEce3y0VK4unYoIPbv+QQFKyHR8/2Mr2P9uV
 tNnkI9RMjVbS2v9bhFqarLNBvMQX/cArmVnzvKDHYaGVCJWUG8xJkdQg937Q56i7vFTL
 CSXCk9xRKCaiZS1ABSuX2NlrpSj7GesKWekcKdOV/W3pME+dm2gp6EaicWLzQcb2wbXk
 5Y/KRiHlJ91DqYipQlau8py//lmVmgRy6+rx3dGjhM/S1OaaUQ889aKHKF58G7CUj0dh
 A/SFcKe1n03s4cHgvIc8E1AoZqYUPLaI4TBLLiOqSuamCbZ6gcxM/f0q1dlTkP/JRed0
 fWYQ==
X-Gm-Message-State: AOJu0YxMB+tjwocVN51M8DsyGtk9ydoeCccALzyAFXRJpDtUaO6doIbO
 JopQq/ODv+6grafmpnUK7tx6/v2T5SsbrKd7WBQ=
X-Google-Smtp-Source: AGHT+IFivvJDEyxiyU6oyay21IOiOnT1tRwVgE5g/ZPhgYp91NI5OUB0v+l1mh4Ctfvu4asqV9rDKKMavpt7ZKTxcHw=
X-Received: by 2002:a05:6830:3b0c:b0:6b9:db92:9bd3 with SMTP id
 dk12-20020a0568303b0c00b006b9db929bd3mr14225411otb.13.1692806231381; Wed, 23
 Aug 2023 08:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAOYdKdjW6Ut3QCMWpu8W7TKuuv9OfehC7tdW7-vkdcN8ZbK3Jg@mail.gmail.com>
 <CAOMZO5BtN6xQJ9j35Wz4wH9p5Q=JoC2Ffb1aN-yrTzUeb0AvYQ@mail.gmail.com>
 <CAOYdKdjnVpt=YOrAzjKiaAZomB7=hgAHe1TE+7MM8PK3g+WjRQ@mail.gmail.com>
 <CAOYdKdirq-H+ZaBmy0sT05sL=C=cJWLixgJLsA5ES9PcwZrXyw@mail.gmail.com>
 <CAOMZO5CTG8bqNoP2XO=6VXXquutg-MFqBTbi9Y2q4Dcg0Mfftw@mail.gmail.com>
 <CAOMZO5ArFiQO=BWvDbR91XhADJ0ks4JTe45zOb+z3aaiED2gkg@mail.gmail.com>
 <CAOMZO5CYnkCC5pmG35+8qHqeCaEJwM3Z3eyoJaTrOMMWj5AWWg@mail.gmail.com>
 <CAOYdKdgLaAx8krbBZV=yaUGTwtf6cbgaTU3=+pRKJ4-w_V3_Sg@mail.gmail.com>
 <CAOMZO5DqKS2w1G3iKKGPS_piXx8JcGoWCFOqCQOoB524O9KyOQ@mail.gmail.com>
 <CAOYdKdjPrRT7F_LFf8YeafX1MWep_p91CFdwc-SH8+diCu+2sw@mail.gmail.com>
 <CAOMZO5BzrfvLDrtqBk1dmLqb9-GxzZs8nRVY7GxqCRY34pKg4w@mail.gmail.com>
In-Reply-To: <CAOMZO5BzrfvLDrtqBk1dmLqb9-GxzZs8nRVY7GxqCRY34pKg4w@mail.gmail.com>
From: Rogan Dawes <rogan@dawes.za.net>
Date: Wed, 23 Aug 2023 17:56:59 +0200
Message-ID: <CAOYdKdgyXi5g9zPNOCBtsrA8KV0L1O0Oyh4Ne-Q79Z=EgGs=zw@mail.gmail.com>
Subject: Re: Trying to boot custom kernel on Wink Hub (i.MX28)
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
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

Hi Fabio,

On Tue, 22 Aug 2023 at 13:44, Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Rogan,
>
> On Tue, Aug 22, 2023 at 6:42=E2=80=AFAM Rogan Dawes <rogan@dawes.za.net> =
wrote:
> >
> > Hi Fabio,
> >
> > As far as I am aware, the U-boot source for the Wink hub has not been
> > made available anywhere. That said, the RAM chip in use on the board
>
> Was there a formal request for the U-Boot source code to Wink?
>
> As per the GPL license, they have to share the U-Boot source code.
>

I have just asked them for it, so let's see what happens. I'm not
optimistic, though, given their financial troubles. I am not aware of
anyone else asking them. However, I do believe that there have been
requests for the kernel sources for the Wink Hub 2, which were
ignored, suggesting that they are not the best GPL citizen.

> > is marked D9LPX, which apparently corresponds to the following item:
> > https://media-www.micron.com/-/media/client/global/documents/products/d=
ata-sheet/dram/ddr2/512mbddr2.pdf?rev=3D2c70f8a2b207452584b2bf040de8d771
>
> There is a tool from NXP that helps with the i.MX28 DDR2 controller
> initialization for a specific DDR model:
>
> https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/imx-processor=
s/9552/1/MX28_DDR2_register_programming_aid_v0.2.xlsx
>
> The DDR initialization values obtained from this tool are then used in
> U-Boot inside the 'mxs_dram_vals' array.
>
> There is a common DDR configuration at
> arch/arm/cpu/arm926ejs/mxs/spl_mem_init.c.
>
> Most likely, in your case, it will require a custom mxs_dram_vals
> initialization, like it is done at board/liebherr/xea/spl_xea.c.
>
> > I did try to change the iomux_cfg_t as suggested above, built using
> > make mx28evk_defconfig && make u-boot.sb, and used mxsldr to try load
> > it, to no avail. There was no output on the serial port at all, or any
> > other suggestion that anything was running.
>
> It has been a long time since I used the mxsldr tool.
>
> When time permits, I can try to load a recent U-Boot over USB using
> this tool on a imx28-evk.
>
> Cheers

I think fiddling with RAM timings is a little more in the weeds than I
am ready to go at this point. I did see this post
(http://web.archive.org/web/20151005053615/http://jalderman.org/?p=3D348),
suggesting that it was not too difficult to get it working using
mainline u-boot. That said, I also note that some teardowns mention
that the RAM is a Nanya part, while I have Micron, so perhaps I should
not place too much reliance on that.

Rogan
