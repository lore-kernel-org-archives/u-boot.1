Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C69C61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 14:14:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C6D987017;
	Wed, 22 Nov 2023 15:14:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GVhQzqNn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AF0D869F7; Wed, 22 Nov 2023 15:14:27 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C299875F5
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 15:14:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3b8412723c4so248051b6e.0
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 06:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700662461; x=1701267261; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x7lHF9sR2pHMYrs97s0mzrEBHzYr9zzf/Z+uAhtfPNQ=;
 b=GVhQzqNndlmtDYZlkdOGVtAeOgNMtuGUCzSEKlhD+rkMwLczoCSXS6c3kafHAmqCAo
 cg1gA6/GAwSW9gQ8ElXYcqpLCggydqcfnYqioErDWmkAeRayc/sDmvY3XHv3FTBcyHvT
 Mn8zTYq45IPrf6/4mteg+2jqngNTOvg73z5AoAo1x+G6N+nG7xBdaj3EkeinzYoTnOfD
 UVMsHK6sOdCS4PMrlF4XZIlgE3nO9gaNypl6pRGHxEi5Tyl3M2c/l+V/7tM2HABPOtmJ
 wSjQLZqFFNuKTaRZA/L0bNr/76ZSKW4jvmKi7rqLUbqpPECbxQsc9WnRCzkv1zpb3RiY
 DvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700662461; x=1701267261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x7lHF9sR2pHMYrs97s0mzrEBHzYr9zzf/Z+uAhtfPNQ=;
 b=nh9JJgn4d9hCGE+TXS6wwu27Cj1k90UhEBaq0Y5cfNRWBmGWlH/0n/8t4MLKdpe34n
 v0A68OpZxhpVJp3fyJ5EGNV5MniDnudmRUa79iQbumq8pwCx9NO0Sq+C+Bx9lWl4iHzf
 a/5EXwLj+1qk8FnkdVjpAC1dG1yhsvf567o9RlnitGmih/DHw4CnwSFYNxNTIPxjfXUa
 dnmh90WSvd35W+yqx/qLirtqBOvDh11Rhyj7nmWcHpRMFHWpxHb0YvUY5Cnt3ho6gmPJ
 RobqULIbS6jPcQmjZDK+ZBNcszDIHw99WffR5aUdPX+xE9GBPYQoyBPIwKDDF8oSVKRF
 UctA==
X-Gm-Message-State: AOJu0YxdZpsrgM9yNwYYBRTWwxNbyvneKJAdovBqTmUG3YI+VUbJDrKm
 ZtFfV3o+lpU7FsWuj3xf01ecWVCVywKLnQOjXfVrRQ==
X-Google-Smtp-Source: AGHT+IG9byZUNTt6FYR/6w+imDSYh/g1QAizt+z3ujsSmk9iiglj/3Y89ZkkLmxmfbPu4YtxBn1O9IvYi7ATmRMoFnw=
X-Received: by 2002:aca:1902:0:b0:3a9:e8e2:5799 with SMTP id
 l2-20020aca1902000000b003a9e8e25799mr2660279oii.14.1700662461139; Wed, 22 Nov
 2023 06:14:21 -0800 (PST)
MIME-Version: 1.0
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <CAFA6WYPe8_onKNYzAVr9RHVbwUZCTiEkDizwnfL6QRsqii-JUg@mail.gmail.com>
 <20231122140100.GT2513409@bill-the-cat>
In-Reply-To: <20231122140100.GT2513409@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 22 Nov 2023 19:44:09 +0530
Message-ID: <CAFA6WYNoz-Pqn38FpKLj9eJxX6B019HvQoukdCma3S=+O6tOCg@mail.gmail.com>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
To: Tom Rini <trini@konsulko.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ramon Fried <rfried.dev@gmail.com>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
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

On Wed, 22 Nov 2023 at 19:31, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Nov 22, 2023 at 11:51:29AM +0530, Sumit Garg wrote:
> > Hi Caleb,
> >
> > On Tue, 21 Nov 2023 at 22:39, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> [snip]
> > > == DT loading ==
> > >
> > > Previously, boards used the FDT blob embedded into U-Boot (via
> > > OF_SEPARATE). However, most Qualcomm boards run U-Boot as a secondary
> > > bootloader, so we can instead rely on the first-stage bootloader to
> > > populate some useful FDT properties for us (notably the /memory node and
> > > KASLR seed) and fetch the DTB that it provides. Combined with the memory
> > > map changes above, this let's us entirely avoid configuring the memory
> > > map explicitly.
> >
> > Since with this change, we don't need to embed FDT blob in the u-boot
> > binary, so I was thinking if we really need to import DTs from Linux
> > for different platforms and then play a catchup game?
> >
> > IMO, the build command would look like following if we import
> > pre-built FDT blob from Linux:
> >
> > - Build u-boot::
> >
> >        $ export CROSS_COMPILE=<aarch64 toolchain prefix>
> >        $ make qcom_defconfig
> >        $ make
> >
> > - gzip u-boot::
> >
> >        gzip u-boot-nodtb.bin
> >
> > - Append dtb to gzipped u-boot::
> >
> >         cat u-boot-nodtb.bin.gz
> > <linux-tree>/arch/arm64/boot/dts/qcom/your-board.dtb >
> > u-boot-nodtb.bin.gz-dtb
> >
> > This would avoid the maintenance burden to keep DT in sync with that
> > of Linux. And since DT bindings in Linux are backwards compatible, we
> > can say u-boot should work with DTB picked up from any Linux kernel
> > stable release.
>
> I guess one question I have is, are we being passed the device tree
> (since we're acting like the Linux Kernel)

Yeah that is the case here, see patch #1 in this series regarding how
FDT address is being retrieved from previous stage bootloader (ABL on
sdm845 and qcs404 SoCs).

> or knowing that we have the
> dtb attached to the end of us and making use of the old kernel appended
> dtb option? We're fine in for example the rpi_arm64 case of just being
> given a device tree from the previous stage and not needing one in-tree.
>

That's good to know and we can replicate that for Qcom platforms which
are chainloaded and don't need an embedded DT.

-Sumit

> --
> Tom
