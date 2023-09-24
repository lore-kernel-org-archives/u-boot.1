Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339BACE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:16:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 121258698D;
	Sun, 24 Sep 2023 22:16:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dawes.za.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail-com.20230601.gappssmtp.com header.i=@gmail-com.20230601.gappssmtp.com header.b="eFZXeNjZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 117AA86A23; Sun, 24 Sep 2023 22:16:31 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CAB58694A
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:16:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dawes.za.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogan.dawes@gmail.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6c4b9e09528so2497776a34.3
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail-com.20230601.gappssmtp.com; s=20230601; t=1695586586; x=1696191386;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jd7Xow4q38dew7fO1Jmjqq2EJ+iTVX2aoeuXGL+V0CI=;
 b=eFZXeNjZZLpifVLFjPm+uFCQca82e1vCilRj5sPzKRlco969gQ9WARIhjssxdzNSiG
 VelduQwmWnxtOTUZn4HuE7/PtwFbTnI6D0BU/UX9WhPRiVhqw/wRpgaEVca1sZhHtsGW
 7qjwrxRr3F35plbENjT9Y6YRUyRvqr8HSsB02iWHR7wrZrkaGYaGfEulMx36VN7BRJ2Y
 uyJYlDqTzWhWhVRK04eHc9B21SVTcEn7HjoACVIX69Yh3tFPv4SoLVPMaTYW8mGqumfF
 Y2/6ZGz7xMMrDEg97R8jaDcS7YbIDnOV8h0J0VpzfdOzur6cbJD1ecZudLDQaxF45Fvn
 DZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695586586; x=1696191386;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jd7Xow4q38dew7fO1Jmjqq2EJ+iTVX2aoeuXGL+V0CI=;
 b=NCp4S7+mDlMr0s+oTKXlaBrEJtvM7/2BmXtTi5CEvGq01uNoUh8aR03Mk78WX7YySz
 9WmXFkNTHiYEFsS2iq0FdWbGW+oPKNRMlgmC5anE/hSuey+heWbrsLra58Lg0+oQ9TLA
 BBJZvKKDgXSpQl04jsE6tCzf7F5Sfs6mQCwOmzB2x5exMxEPUDziYWx++8f3yG/ByK7i
 bTUQpYXVFlekDGNbsEyfsIHMaJa3jfvGaoKCUMEOViMhOYzDxSLgDJmYLLWSKy0sf2Os
 f5jXy53lnqOL526+l9YB5HFktcy8at04WaTIuUH8PYS68/sGp/639f1tKfffzpfy/32B
 lwpg==
X-Gm-Message-State: AOJu0YyOCp7fYwIxAwHytHrtWNRGq7m8DbQd+fA2FOjoCY8XN1EYvNLO
 WxzXXnpuMIneoNegwuzH7iM6+teK99mcRlj1ETM=
X-Google-Smtp-Source: AGHT+IFKcA3GhJXS4RdsykhntbGCGBAMd0c8fwQ7pNT0T2wy0JqRhFiMAxhWRVBVegteTAEaYmMurIIy7NZ4Nuw3JRA=
X-Received: by 2002:a9d:68d3:0:b0:6c4:9ca1:f13a with SMTP id
 i19-20020a9d68d3000000b006c49ca1f13amr5472996oto.35.1695586586415; Sun, 24
 Sep 2023 13:16:26 -0700 (PDT)
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
 <CAOYdKdgyXi5g9zPNOCBtsrA8KV0L1O0Oyh4Ne-Q79Z=EgGs=zw@mail.gmail.com>
In-Reply-To: <CAOYdKdgyXi5g9zPNOCBtsrA8KV0L1O0Oyh4Ne-Q79Z=EgGs=zw@mail.gmail.com>
From: Rogan Dawes <rogan@dawes.za.net>
Date: Sun, 24 Sep 2023 22:16:15 +0200
Message-ID: <CAOYdKdhvKEaeyv5zhXiswuF-Kd6ee8FmdN8MoMS9=5VTWVgMXA@mail.gmail.com>
Subject: Re: Trying to boot custom kernel on Wink Hub (i.MX28)
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi folks,

I eventually decided that I did need to figure out the DRAM timings for the
Micron chip on my board, but I found an easier way than actually
"understanding what I'm doing"! :-)

I pulled the vendor U-Boot image off the flash, skipped the
appropriate number of bytes until I was actually dealing with a u-boot.sb
formatted image (looking for the STMP signature I found in the compiled
mainline u-boot), then used the Rockbox project's sbtoelf tool to convert
the SB back to two ELF files, the SPL.elf and the u-boot.elf. From there I
loaded the SPL.elf into ghidra, then went looking for byte sequences found
in arch/arm/cpu/arm926ejs/mxs/spl_mem_init.c to see if I could locate them
in the vendor blob. I did, right at the end of the binary, then converted
bytes into uint32 sequences so that I could compare with the mxs_dram_vals
for CONFIG_MX28.

Did the compare and found a single bit that is different between the two
sequences of initialisation values. Literally a 1 to a 0, and that is all.
So I built mainline with that change, and an updated iomux_setup because
the Wink Hub v1 uses MX28_PAD_I2C0_SCL__DUART_RX and
MX28_PAD_I2C0_SDA__DUART_TX for its console pins. i was hoping to see it
boot via mxsldr, but unfortunately, I got nothing.

How can I get the SPL to emit something on the console to confirm it is
running? i.e. before the DRAM initialisation?

Regards,

Rogan


On Wed, 23 Aug 2023 at 17:56, Rogan Dawes <rogan@dawes.za.net> wrote:

> Hi Fabio,
>
> On Tue, 22 Aug 2023 at 13:44, Fabio Estevam <festevam@gmail.com> wrote:
> >
> > Hi Rogan,
> >
> > On Tue, Aug 22, 2023 at 6:42=E2=80=AFAM Rogan Dawes <rogan@dawes.za.net=
> wrote:
> > >
> > > Hi Fabio,
> > >
> > > As far as I am aware, the U-boot source for the Wink hub has not been
> > > made available anywhere. That said, the RAM chip in use on the board
> >
> > Was there a formal request for the U-Boot source code to Wink?
> >
> > As per the GPL license, they have to share the U-Boot source code.
> >
>
> I have just asked them for it, so let's see what happens. I'm not
> optimistic, though, given their financial troubles. I am not aware of
> anyone else asking them. However, I do believe that there have been
> requests for the kernel sources for the Wink Hub 2, which were
> ignored, suggesting that they are not the best GPL citizen.
>
> > > is marked D9LPX, which apparently corresponds to the following item:
> > >
> https://media-www.micron.com/-/media/client/global/documents/products/dat=
a-sheet/dram/ddr2/512mbddr2.pdf?rev=3D2c70f8a2b207452584b2bf040de8d771
> >
> > There is a tool from NXP that helps with the i.MX28 DDR2 controller
> > initialization for a specific DDR model:
> >
> >
> https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/imx-processor=
s/9552/1/MX28_DDR2_register_programming_aid_v0.2.xlsx
> >
> > The DDR initialization values obtained from this tool are then used in
> > U-Boot inside the 'mxs_dram_vals' array.
> >
> > There is a common DDR configuration at
> > arch/arm/cpu/arm926ejs/mxs/spl_mem_init.c.
> >
> > Most likely, in your case, it will require a custom mxs_dram_vals
> > initialization, like it is done at board/liebherr/xea/spl_xea.c.
> >
> > > I did try to change the iomux_cfg_t as suggested above, built using
> > > make mx28evk_defconfig && make u-boot.sb, and used mxsldr to try load
> > > it, to no avail. There was no output on the serial port at all, or an=
y
> > > other suggestion that anything was running.
> >
> > It has been a long time since I used the mxsldr tool.
> >
> > When time permits, I can try to load a recent U-Boot over USB using
> > this tool on a imx28-evk.
> >
> > Cheers
>
> I think fiddling with RAM timings is a little more in the weeds than I
> am ready to go at this point. I did see this post
> (http://web.archive.org/web/20151005053615/http://jalderman.org/?p=3D348)=
,
> suggesting that it was not too difficult to get it working using
> mainline u-boot. That said, I also note that some teardowns mention
> that the RAM is a Nanya part, while I have Micron, so perhaps I should
> not place too much reliance on that.
>
> Rogan
>
