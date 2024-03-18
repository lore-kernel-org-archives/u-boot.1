Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0EFC54E68
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 13:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06C9C87D66;
	Mon, 18 Mar 2024 14:31:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IRf9YEgF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C611E87DCA; Mon, 18 Mar 2024 14:31:42 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD3A287D46
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 14:31:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-29f8403166aso644958a91.1
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 06:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710768698; x=1711373498; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=07Bue/A/bGt1CA358NFNAtNqWnzMM3sCtQ2wo/vycqA=;
 b=IRf9YEgFJigk3cdmE4sOZlo5SsbBAZXCXJMgbh/22doX0OnYELTcSztBjz89BdF6hn
 Qiuk2pboq1F55Dc/abRrj7LrDbZIg2N4oo3nt19/Szrg8f9304SvnFyqbLrMoqPUlEVy
 2Wg/SF2ALI6RfGuy8MoQ9cY4QCOWmckRWxUfHxU7uXYlKl5eYg6WfWs3azh+ceAmD3/u
 BhmmOSQpgJN07c43gY/1y17z1DJvUYBwA8L1kQQOuHDwr35RyX4NFdmWtW2I270cbzOB
 ZgF2UBKDhZYY78O8gbilTpJpPNkyGwE8Ut/OBV3PNVVMNiGV2oPJXaY2clvPmsNE1KpT
 x/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710768698; x=1711373498;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=07Bue/A/bGt1CA358NFNAtNqWnzMM3sCtQ2wo/vycqA=;
 b=wlHy9p9r8S4sOBgDSME6gduLxNs1nQ3sBGQlrZUcpe/8BzQ2VvSsoSyJcFNo0g3SWz
 3An2A8HiB0Qdeu1UuoNoyOrrgrnIVoGv3s1kY39xHYL4GGjT0pyfeASLsUFVGamKB5cm
 ONStO1B8LiXYGqjIaOgv0Xoyenz7ocIL6GO+VSdew11NfJeCH95fz7u5VvcaX3LNpVRZ
 HplssbBx/9a8ejnQPd+SP4ndG6tfBbQnV2tsNyukCTHRUpuMVza911jWwfYrauAW4+eM
 gYahxuxDc5Bp8Jvs8IIsH9kzwACNgHowghEkoUOoMd1k+yCLHR1EaC0P6+6UxNWcgCke
 f+eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4VP8nBSSaGuDkh8WjlrHzwZMA8nM1AzXuyF5cqF6q10uHK06O2worVScw/9Rw9hOv4FLU4mlaniGpwf+DsZv+T/Ge0w==
X-Gm-Message-State: AOJu0YyWn5LfxSyE4bPkZjiS6n5JK3noYamYooF2sd9aaABkb71AJbU7
 bg/tmhL8ehFltYWWvQmAHzKq5GxsZGhko4HSQTRz/9blb9thYRYToIclTUeVWvCZHTzxQKQXQEY
 oXbtSDxjhLvkjwXlIBNn/cIWFQAY=
X-Google-Smtp-Source: AGHT+IFgFrD6fvNt4Aj/D99IrD2BekArpapw5gaaXMXEO39WC9rU6by3a5/IYDuXZWZZUfHVK2/T5hwtJXW8FSyoshg=
X-Received: by 2002:a17:90a:8d10:b0:29b:ef73:44ff with SMTP id
 c16-20020a17090a8d1000b0029bef7344ffmr10534726pjo.1.1710768698094; Mon, 18
 Mar 2024 06:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230214133814.4173549-1-paul.liu@linaro.org>
 <20230214133814.4173549-2-paul.liu@linaro.org>
 <CAOMZO5B=EYPSNXkr=FM+iRvRYiv9fysB8DfhntuhQ_jhkKz38Q@mail.gmail.com>
 <875xxvratg.wl-maz@kernel.org>
 <CAOMZO5DBzEcga0-QGBBP3twT6imLuCv0cD6EYLOTwGN47wTxsA@mail.gmail.com>
 <87zfv7pojq.wl-maz@kernel.org>
 <CAOMZO5AMi_5XqYUodPcfiFtbn9A7P1HVn__F-BLavLqnwMeNkg@mail.gmail.com>
 <CAOMZO5CqH1OuVQDNH7+CuzPbBt9M8F7OOhDgCZZ0ad7rBfT52w@mail.gmail.com>
 <vozturnswioy4b46tp5j45tq4kv7gnfkklwnw2bipn3mi3q2zi@4f4q2bwf7qun>
In-Reply-To: <vozturnswioy4b46tp5j45tq4kv7gnfkklwnw2bipn3mi3q2zi@4f4q2bwf7qun>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 18 Mar 2024 10:31:25 -0300
Message-ID: <CAOMZO5D0TeJ8BDCZ73Txq_OvxcNN8KAASOgyzAU3EYtR7igAsw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: Reduce add_map() complexity
To: =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>
Cc: Marc Zyngier <maz@kernel.org>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
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

Hi Pierre,

On Fri, Mar 15, 2024 at 12:13=E2=80=AFPM Pierre-Cl=C3=A9ment Tosi <ptosi@go=
ogle.com> wrote:

> I had a quick look through your logs and notice that U-Boot master attemp=
ts to
> map addresses in the high VA range e.g.
>
>   Checking if pte fits for virt=3Dffffffffe4000000 [...]
>
> while the logs that boot successfully only use the low VA range e.g.
>
>   Checking if pte fits for virt=3D80193000 [...]
>
> Unless that has recently changed (since I last worked with U-Boot), U-Boo=
t on
> AArch64 only supports identity mappings and therefore was only taught how=
 to
> program TTBR0_ELx (i.e. is only able to map low virtual addresses). This =
means
> that the code - with or without 41e2787f5ec4 - would be unable to map add=
resses
> such as 0xffffffffe4000000.

Yes, I found it strange too. I may have done something wrong the last
time I instrumented the code.

I tried it again and no longer see these unexpected high virtual addresses.

Please find the new logs here:

https://pastebin.com/raw/qF3GbJry

> Now, given that 41e2787f5ec4 only affects implementation details of add_m=
ap(),
> I am surprised that reverting that commit changes the arguments received =
by the
> function such as virt. As a reminder, add_map() is exclusively used on me=
m_map:
>
>   for (i =3D 0; mem_map[i].size || mem_map[i].attrs; i++)
>           add_map(&mem_map[i]);
>
> >
> > That's the only issue preventing colibri-imx8x from booting mainline U-=
Boot.
>
> If I read the U-Boot configs right i.e.
>
>  - configs/colibri-imx8x_defconfig: CONFIG_ARCH_IMX8=3Dy
>  - arch/arm/mach-imx/imx8/Makefile: obj-y +=3D cpu.o
>  - arch/arm/mach-imx/imx8/cpu.c: struct mm_region *mem_map =3D imx8_mem_m=
ap;

Correct, these are the relevant files for the i.MXQ8XP.

> There is a possibility that your mem_map is getting modified by MACH-spec=
ific
> code. In particular, enable_caches() seems to dynamically get the MMU map=
pings
> from some RPC mechanism (see get_owned_memreg() and sc_rm_get_memreg_info=
()).
>
> Could it be that whatever services those requests might be returning unex=
pected
> values? Instrumenting arch/arm/mach-imx/imx8/cpu.c and dumping mem_map (a=
nd
> the RPC messages) with/without the patch would help clear this up.

I tried dumping the page table entries, but could not notice anything
that looked suspicious.

Please let me know if you have any suggestions.

Thanks
