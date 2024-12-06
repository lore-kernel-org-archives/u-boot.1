Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF8AE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 19:17:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98F648974F;
	Fri,  6 Dec 2024 20:17:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n0v0dZDR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AEED89376; Fri,  6 Dec 2024 20:17:54 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 846358921B
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 20:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7fd21e4a9c0so1588856a12.3
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 11:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733512670; x=1734117470; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t/w3Ktjts7jc/rvxgeZsT32WDRW0mA2lkiErzlKCmbY=;
 b=n0v0dZDR0uoX5EfYFXSTnhlzlfQ2mEaZt1SPwJogh5GiP9kxJSYqWhWwdeIoePOeBE
 1DjkIFHUaDefomJKS8Htmx2EDw4PfZDdP8PKNQog1YlGpTOaa+cKI1b4aL9HM4nWge2D
 fwuwDCGG44SPkzt9Fp1CmV4JWC3ge5mzaMJQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512670; x=1734117470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t/w3Ktjts7jc/rvxgeZsT32WDRW0mA2lkiErzlKCmbY=;
 b=cpwFA4s7+r9ZxYiw57MxPGwdfcrzGmMFHNGGtIb9Ozj3JkxZWRnHTbJC8UagYiq9KS
 LLpc/0rDG87r4F2sefRVD3p+JrrrjgfnVdRYdS8aoK/CO3DGFJ5zgbggT+ToDf/t1FA4
 X68GoTGnJz8t2d/SUEcbRThV8ziV/U0bdu/HiWt6ew+I9tXPhvbpC7Tk8m6gghNMwCoF
 lX5B4udQvBDoJCsAbwY7J2oDQRAKPhoxPUW6/9Rtp0M05J4qR5vCEBvX0PQFrO03DsMv
 NR1LMYTbjs256qUlLbCyN4+YYoVYs/pmkbbAzYYVkG0c1WkiVeBhd8hhEtqWekJdJC3w
 G1mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc54tAOq1nwiblFV+xMzM5xrv8dnux1e3oJap5sQPnqbTO1tHQqAbsI8zjufVce9fJ9hdrgw0=@lists.denx.de
X-Gm-Message-State: AOJu0YwhepDIaZrPY+PCZ65vsU7FxsCMeHBDHhnV/hC/oPNo2kVf1UE0
 K3k9NrJwg+5tALbVBpMnMwIDE7PH1LAbOyc6dM5SgenlFWSrE6vyap9yEYrvsD/KxBpsybZzQ3b
 NeA+05JSA+5lxuI0UrnCkzQrot45CLrhP8P+m
X-Gm-Gg: ASbGncsqaCHIggRLtjCvg2JDQWbanbMWGapghYgd9UfA0FKKjp6t3paBT8Dqxi+eM8X
 zAoWljJHBSYlcttRwpgnmBInfjjyMWQsd
X-Google-Smtp-Source: AGHT+IGt6lF9R8acuAdfHCDq5FQ+Mpfu2XSUbWnCEii8NScgZZYr80aHN7fPekfGMWWPOQvTIQBm4Ba8kE+ORRD+96U=
X-Received: by 2002:a17:90b:54c8:b0:2ef:2d9f:8e55 with SMTP id
 98e67ed59e1d1-2ef6a6c11d3mr6174956a91.17.1733512670055; Fri, 06 Dec 2024
 11:17:50 -0800 (PST)
MIME-Version: 1.0
References: <de1b8dbabd5ab7f20d7aac217ec4f5074d39f1da.1728462767.git.michal.simek@amd.com>
 <CAFLszTh6s5n4nzC7UKhFnQuXFOucGA6amjN1eV4NqwjV6-NEeQ@mail.gmail.com>
 <1048553d-4818-4aba-8bd1-c958dc0b7c5e@amd.com>
 <178d29b0-d82c-4b18-a3ed-3d46dcc02446@amd.com>
 <20241101135220.GJ3600562@bill-the-cat>
 <CAFLszTgSX1cn1y3C=QHuVfvVr4486ezaFAL4pmdPAvi6m==Lcg@mail.gmail.com>
 <c5b1aabb-c9e5-42b8-a73e-1ddab887a774@amd.com>
In-Reply-To: <c5b1aabb-c9e5-42b8-a73e-1ddab887a774@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 12:17:31 -0700
Message-ID: <CAFLszTij49uGbacoUaqP315OZRO_JvHY5yLuAdKEuV3WeO2GFQ@mail.gmail.com>
Subject: Re: [RFC PATCH] zynqmp: Add binman description for SOM
To: Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, git@xilinx.com, 
 neal.frager@amd.com, Charlie Johnston <charlie.johnston@loftorbital.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tony Dinh <mibodhi@gmail.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

Hi Michal,

On Mon, 4 Nov 2024 at 01:32, Michal Simek <michal.simek@amd.com> wrote:
>
> Hi Simon,
>
> On 11/2/24 17:28, Simon Glass wrote:
> > Hi Michal,
> >
> > On Fri, 1 Nov 2024 at 14:52, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Fri, Nov 01, 2024 at 02:09:38PM +0100, Michal Simek wrote:
> >>> Hi Simon,
> >>>
> >>> On 11/1/24 09:27, Michal Simek wrote:
> >>>>
> >>>>
> >>>> On 10/31/24 19:03, Simon Glass wrote:
> >>>>> Hi Michal,
> >>>>>
> >>>>> On Wed, 9 Oct 2024 at 10:33, Michal Simek <michal.simek@amd.com> wrote:
> >>>>>>
> >>>>>> There is necessary to do some steps to compose boot images. These steps
> >>>>>> were in scripts in layers for a while. That's why introduce description via
> >>>>>> binman to simplify wiring and remove all scripting around.
> >>>>>> This should make sure that everybody is up2date with the latest versions.
> >>>>>>
> >>>>>> The first step is to create fit image with DTBs with descriptions in
> >>>>>> configuration node which is written as regular expression to match all SOM
> >>>>>> versions.
> >>>>>> Description is there for k24 and k26 in spite of low level psu_init
> >>>>>> configuration is different. The reason is that it goes to u-boot.itb image
> >>>>>> which is the same for k24 and k26.
> >>>>>> u-boot.itb is another image which is generated. It is normally generated
> >>>>>> via arch/arm/mach-zynqmp/mkimage_fit_atf.sh but this script is supposed to
> >>>>>> be deprecated.
> >>>>>> FIT image by purpose is using 64bit addresses to have default option to
> >>>>>> move images to high DDR (above 4GB). TF-A and TEE are optional components
> >>>>>> but in the most cases TF-A is present all the time and TEE(OP-TEE) is used
> >>>>>> by some configurations too.
> >>>>>>
> >>>>>> 3rd generated image is boot.bin with updated user field which contains
> >>>>>> version number. This image can be used with updated Image Selector
> >>>>>> which supports A/B update mechanisms with rollback protection.
> >>>>>>
> >>>>>> 4th image is image.bin which binary file which contains boot.bin and
> >>>>>> u-boot.itb together and can be programmed via origin Image Selector.
> >>>>>> This image can be also used for creating one capsule which contains both
> >>>>>> boot images (in SPL boot flow).
> >>>>>>
> >>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> >>>>>> ---
> >>>>>>
> >>>>>> Currently I have this for testing purpose only to find missing bits and
> >>>>>> pieces in binman for cases I want to support.
> >>>>>>
> >>>>>> This patch depends on
> >>>>>> https://lore.kernel.org/r/ fbed0251437b61a2f7a85596d7403b5b9c8237c1.1728306322.git.michal.simek@amd.com
> >>>>>>
> >>>>>> ---
> >>>>>>    arch/arm/dts/Makefile                |   1 +
> >>>>>>    arch/arm/dts/zynqmp-som-binman.dts   | 224 +++++++++++++++++++++++++++
> >>>>>>    arch/arm/mach-zynqmp/Kconfig         |  17 ++
> >>>>>>    configs/xilinx_zynqmp_kria_defconfig |   2 +
> >>>>>>    4 files changed, 244 insertions(+)
> >>>>>>    create mode 100644 arch/arm/dts/zynqmp-som-binman.dts
> >>>>>
> >>>>> I'm pleased to see this. My only suggestion is to use '/bits/ 64'
> >>>>> instead of the macros, for 64-bit values.
> >>>>
> >>>> When I was playing with it some time ago it didn't work but it works now
> >>>> that's why no issue with it.
> >>>
> >>> One more thing on this one. I pretty much dislike that images are generated
> >>> to u-boot root folder. Isn't there a way that they will be written to
> >>> separate folder (deploy for example)?
> >>
> >> Or perhaps $(obj) ?
> >
> > Yes $(obj) is where they end up today. I consider output files from
> > binman to be on the same level as other files created by the build.
> > Then again, it does end up a bit of a mess, when mixed with the output
> > files.
>
> Some cleanup would be good. I remember a lot of discussion about if people
> should be using u-boot or u-boot.elf. Answer was simple but if output images are
> in separate folder it would IMHO better to understand.
>
> > I am not keen on 'deploy' as it nothing is being deployed - also it
> > sounds like a satellite or military attack.
>
> No problem with different name.
>
> >
> > One long-standing issue is that intermediate files are created in the
> > same directory. Perhaps we could put those in a binman-tmp directory?
> > They are necessary when things go wrong, but don't need to be used all
> > the time.
>
> +1
>
> But I think we should try to move also that images which users should be using
> to separate folder completely. Again it doesn't need to be done by default but a
> way to configure it would be good.

Perhaps file an issue for this? I haven't got to it yet.

Regards,
Simon
