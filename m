Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04529C5AD4C
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 07:04:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E99CB87572;
	Thu, 23 Nov 2023 08:04:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Dbdv1bkN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4CDD87499; Thu, 23 Nov 2023 08:04:35 +0100 (CET)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8221087590
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 08:04:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-4abf80eab14so220496e0c.2
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 23:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700723070; x=1701327870; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d9DMREvkJOtbPy0+Scmw1Yb/onhNyKhOIhGeMRqYyhQ=;
 b=Dbdv1bkNsKJl3cvSkvWDNuF1zyZjm7UTtv3AMEEXFls31xlgI+lxD6Ri6qs39Lg6UT
 kd7EbXHy6Y2ngls+RJ98o03ffrQKRIgLD3FN+YNBp+6r/Z6/XkOkcjUpbaYRCEBu4t0m
 7dRIyhl1BjInSQhuQ1DmpKSiN84q2AizLgHfRx4YKp/5kD3quN8qDnA8zAWNgOKKTEKG
 134aw0eKBY9oStk3Jkg0nTbcsNW5yzov7zywVVc/8n8z9tJm/Y+XEWoOUPgOamnGzz0j
 TlGmOFh3w4ylFaRWdEv6JoA191GW2NnmOrVBbrY3jQvrWuD43JgajYhCW+0L2HlYSYW9
 eT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700723070; x=1701327870;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d9DMREvkJOtbPy0+Scmw1Yb/onhNyKhOIhGeMRqYyhQ=;
 b=q3p24UmF0AcFHAUFLlaREB8mais100PD6QedPvRWtgNseKGrPSGxSE/EkmYV9NqXI+
 VI/9gJHOajwg8nfOSxEVkReLYTYabfEizuplTrM3D4k4734zyW2firzHy3xNGZd0eSz1
 SmfOfdk+pCEEnTgYW37cwUb3aInmu+PT/mLnJgjudj1ao7zoayP8UoS99HYPwykc58XF
 pTBoBqP+KbFnx237cdcaZVkDBc8N3+m6azfQENdaq+rOheukkRkHmOXL2ZWel33nrVpk
 7rQrgiQ/8OvByypmV75AEtVFYeIjAwdKJPdjSlPFZbHyx+WMSBGDA/fQeuOwM5aUUNXv
 RlrA==
X-Gm-Message-State: AOJu0Yz2v73+kwP6SBrIxnINB/pBNIfk59KWnps9l3atXx7fEFqROR24
 uv4ya+D7uxllk6rPcj2fsy7H++EzgSXZPd9lAWwelg==
X-Google-Smtp-Source: AGHT+IHdfgd7RPseJhGDBwZ6yuEHEiNuH+s/eQeY6Hv0PKZSjKQcM5Qub0HAhk55//bm//qxI1jKLgicoUj2ZkNaWhA=
X-Received: by 2002:a1f:ea81:0:b0:4ac:593b:e9f4 with SMTP id
 i123-20020a1fea81000000b004ac593be9f4mr4616000vkh.9.1700723070213; Wed, 22
 Nov 2023 23:04:30 -0800 (PST)
MIME-Version: 1.0
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <CAFA6WYPe8_onKNYzAVr9RHVbwUZCTiEkDizwnfL6QRsqii-JUg@mail.gmail.com>
 <20231122140100.GT2513409@bill-the-cat>
 <CAFA6WYNoz-Pqn38FpKLj9eJxX6B019HvQoukdCma3S=+O6tOCg@mail.gmail.com>
 <20231122142758.GU2513409@bill-the-cat>
 <c47b163b-d0d9-4de6-8ea8-ebe884b28e4b@linaro.org>
In-Reply-To: <c47b163b-d0d9-4de6-8ea8-ebe884b28e4b@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 23 Nov 2023 12:34:18 +0530
Message-ID: <CAFA6WYO_Dk+7FWDGjUdDub27YCwVKRjS+vZfMrT8otjvv-QO_Q@mail.gmail.com>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
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

On Wed, 22 Nov 2023 at 21:34, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 22/11/2023 14:27, Tom Rini wrote:
> > On Wed, Nov 22, 2023 at 07:44:09PM +0530, Sumit Garg wrote:
> >> On Wed, 22 Nov 2023 at 19:31, Tom Rini <trini@konsulko.com> wrote:
> >>>
> >>> On Wed, Nov 22, 2023 at 11:51:29AM +0530, Sumit Garg wrote:
> >>>> Hi Caleb,
> >>>>
> >>>> On Tue, 21 Nov 2023 at 22:39, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>> [snip]
> >>>>> == DT loading ==
> >>>>>
> >>>>> Previously, boards used the FDT blob embedded into U-Boot (via
> >>>>> OF_SEPARATE). However, most Qualcomm boards run U-Boot as a secondary
> >>>>> bootloader, so we can instead rely on the first-stage bootloader to
> >>>>> populate some useful FDT properties for us (notably the /memory node and
> >>>>> KASLR seed) and fetch the DTB that it provides. Combined with the memory
> >>>>> map changes above, this let's us entirely avoid configuring the memory
> >>>>> map explicitly.
> >>>>
> >>>> Since with this change, we don't need to embed FDT blob in the u-boot
> >>>> binary, so I was thinking if we really need to import DTs from Linux
> >>>> for different platforms and then play a catchup game?
>
> For now, yes.

But why? Is there any value added by larger u-boot specific DT (most
of the nodes being unused by u-boot) than what currently u-boot
supports? The more important part is to get alignment with Linux DT
bindings. If you need to have memory/reserved-memory nodes in u-boot
DT for generalization purposes then you should import those particular
nodes only.

> There are quite a few features which aren't handled by
> U-Boot that it shouldn't need to handle (rpm/h resources for example).
> Also the fixed-regulator / regulator-gpio binding differences.

IMO, we should fix them first and then use Linux DT as it is.

>
> I would definitely like to move towards supporting Linux DT directly,
> but this approach gives us a nice middleground of minimising the U-Boot
> specific DT parts.

I don't see any real benefits here apart from the maintenance burden.
If it had been an actual Linux DT then that can be passed to Linux as
it is. However, the current modified import you are trying to do
doesn't solve that purpose as well.

-Sumit

> >>>>
> >>>> IMO, the build command would look like following if we import
> >>>> pre-built FDT blob from Linux:
> >>>>
> >>>> - Build u-boot::
> >>>>
> >>>>        $ export CROSS_COMPILE=<aarch64 toolchain prefix>
> >>>>        $ make qcom_defconfig
> >>>>        $ make
> >>>>
> >>>> - gzip u-boot::
> >>>>
> >>>>        gzip u-boot-nodtb.bin
> >>>>
> >>>> - Append dtb to gzipped u-boot::
> >>>>
> >>>>         cat u-boot-nodtb.bin.gz
> >>>> <linux-tree>/arch/arm64/boot/dts/qcom/your-board.dtb >
> >>>> u-boot-nodtb.bin.gz-dtb
> >>>>
> >>>> This would avoid the maintenance burden to keep DT in sync with that
> >>>> of Linux. And since DT bindings in Linux are backwards compatible, we
> >>>> can say u-boot should work with DTB picked up from any Linux kernel
> >>>> stable release.
> >>>
> >>> I guess one question I have is, are we being passed the device tree
> >>> (since we're acting like the Linux Kernel)
> >>
> >> Yeah that is the case here, see patch #1 in this series regarding how
> >> FDT address is being retrieved from previous stage bootloader (ABL on
> >> sdm845 and qcs404 SoCs).
> >
> > That's what I thought.
> >
> >>> or knowing that we have the
> >>> dtb attached to the end of us and making use of the old kernel appended
> >>> dtb option? We're fine in for example the rpi_arm64 case of just being
> >>> given a device tree from the previous stage and not needing one in-tree.
> >>
> >> That's good to know and we can replicate that for Qcom platforms which
> >> are chainloaded and don't need an embedded DT.
> >
> > So yes, moving these towards the direction of rpi_arm64 and specifically
> > using imply OF_HAS_PRIOR_STAGE or select OF_HAS_PRIOR_STAGE (force that
> > the dtb must be provided to us) sounds like the right direction to take
> > these platforms.
> >
>
> --
> // Caleb (they/them)
