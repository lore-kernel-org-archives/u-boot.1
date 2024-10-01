Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B4DCF64BE
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 13:35:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8902B891F4;
	Tue,  1 Oct 2024 15:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F+GlU0wS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BAD4891FF; Tue,  1 Oct 2024 15:35:23 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1BEA891FA
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 15:35:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-71116d8504bso3472549a34.3
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 06:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727789719; x=1728394519; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LmkEUmu1Rbc2T65RLnGDFxitQ/RJM3a2ldcmfa+Exoc=;
 b=F+GlU0wSP1Xvh+NJRY1GKgflUeODt4wMqy+Qcf70MLYw+U+bzoOKQgJvIdCxDu84J9
 D4wL2PHs+Jn7jtrvhgFWgOd2c5ox7sLISz7WDrIvW6DyXIr5l35wAc4SyCQNhTn/FCCy
 JAcNPR/l/WzOZJUo+8/bV4rhxBdVo5MvXA0FWMVYAU5YXv5rxUwIFNV4vw3i9mFce1QJ
 adBbzxSS+vvpfgdS4D/pkdN9mtvZVC7PB7rKhSDboYSIHVUvwcGEVpEG5lFxROJwLa15
 nEZKeJ59OU4GNjqyIB6p4zsnAQ6bklzn2oxlBskk7/0FSVnz6CyFHr5+L2C+HQyAzt1k
 lsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727789719; x=1728394519;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LmkEUmu1Rbc2T65RLnGDFxitQ/RJM3a2ldcmfa+Exoc=;
 b=XTCK7E4LT/ecJsfY0T8d7vV7VgTmB+cHPbnN57ofregkW3W8TdhvTqIkwzDebQsHee
 uRJyy9JvbIpNssL/FvxtK+Mx0pLdOuOyzre6lqvnHy8zkR6tiCnSISc8vwqvkeCL2aIy
 /tSAsIv66BEir9RZ1AympyvQeORpEGW1uAgV4UH9zMRCyIf0Y5I1kWON5aBvPHUJD9WN
 JnqZe58kW6lCpdV3SS7gCLmf0jBw0oP+u8NhdO9VIN90ZgUMxZWDpEgNxvq/E/8h074i
 mZWr0xNoXARzUY6kxjliIIu4Zcsr872+8GyiFmoGastzMypZRdkN79g7s8uzIHTG56an
 4P+A==
X-Gm-Message-State: AOJu0Yx/3Za/hgFvQTDsGVWvSTlV09q+OLdPcrthHEvq/xoqw6rMA66b
 gBOewwSNVd5fuw8mDOmdrvCxhfPWiR1oPehybrJfhO5+hb6hmQJSet9mRBpmJhY3Esq/+X3Kq/A
 lh1dqp20FgY71k9AzuOGKCKM5243pcahg+XOpww==
X-Google-Smtp-Source: AGHT+IGn+grlzSlF4msCqs5umohUtmRpdqaUdOauaUwsT2WR36VgxbMXXLIRZ1vQMkbOySFYhYuOMw9LPRctAI0HqbI=
X-Received: by 2002:a05:6830:6308:b0:708:a300:a6db with SMTP id
 46e09a7af769-714fbe835c4mr10590221a34.7.1727789719620; Tue, 01 Oct 2024
 06:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240927214955.394224-1-marex@denx.de>
 <20240927214955.394224-2-marex@denx.de>
 <CAFA6WYPPXDJC4kSiBAR=jL-Z0v3a8+=_=+hLx+Ug0+yu407y3Q@mail.gmail.com>
 <75eb6eb6-dd55-4509-a041-a5941286493f@denx.de>
In-Reply-To: <75eb6eb6-dd55-4509-a041-a5941286493f@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 1 Oct 2024 19:05:08 +0530
Message-ID: <CAFA6WYM8KJQkTQ6YtMC7ByKU-h1Yss9K50veWmsnni3gYsgj_w@mail.gmail.com>
Subject: Re: [PATCH 2/3] dts: Add ability to build DTOs only from
 arch/$(ARCH)/dts
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Lothar Rubusch <l.rubusch@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@dh-electronics.com, Jan Kiszka <jan.kiszka@siemens.com>
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

On Mon, 30 Sept 2024 at 23:05, Marek Vasut <marex@denx.de> wrote:
>
> On 9/30/24 8:02 AM, Sumit Garg wrote:
> > + Jan
> >
> > Hi Marek,
>
> Hi,
>
> > On Sat, 28 Sept 2024 at 03:20, Marek Vasut <marex@denx.de> wrote:
> >>
> >> Currently the enablement of OF_UPSTREAM results on the build system
> >> searching for DTs only in dts/upstream/ . There are platforms which
> >> use U-Boot specific DTBOs applied on top of U-Boot control DT during
> >> SPL stage, and source DTs for these are located in arch/$(ARCH)/dtb.
> >
> > I would like to understand the need to maintain DTBOs separately from
> > DTBs. Why aren't we pushing DTBOs to Linux kernel sources as we do for
> > DTBs?
>
> This is a stopgap measure, I would like to start reducing the amount of
> U-Boot DTs for iMX platforms, but the DTBOs are still in U-Boot only, so
> I would like to have some middle-of-the-road solution until the DTOs get
> upstreamed to Linux too.
>
> > Jan recently pushed those so-called U-Boot specific DTBOs for a
> > TI platform which were accepted in the Linux kernel upstream. This
> > patch will just deny the ability to build those DTBOs from dts
> > upstream tree. IMHO, this takes a step backwards on the whole notion
> > of OF_UPSTREAM.
>
> I don't think this will deny building those DTOs which are already
> upstream. With OF_UPSTREAM enabled, this will build:
> - Upstream DTBs
> - Upstream DTBOs
> - U-Boot local DTBOs (and NOT U-Boot local DTBs)
> The DTs that are bundled into u-boot.itb are searched exactly in that
> order too, upstream ones first, upstream DTBOs second and finally the
> U-Boot local DTBOs. The upstream content should always get higher
> priority if there are any leftover DTBOs in U-Boot which are also upstream.
>
> > If we really want a middle ground solution to allow migration to
> > OF_UPSTREAM easier then we need to find a way to build DTBOs from both
> > directories (local and upstream dts). I would imagine that will likely
> > complicate building and packaging DTBOs.
>
> I believe this is exactly what this commit does ?

Okay I see, probably the commit subject was too confusing for me:

"dts: Add ability to build DTOs only from arch/$(ARCH)/dts"

I can see the benefit that it provides to people migrating to
OF_UPSTREAM. The negative part can be people just not pushing the
DTBOs upstream which should rather be easier as we have seen Jan
pushing DTBOs upstream. There is also magic added by this patch
regarding which DTBO is actually being used (local or upstream one),
the packaging ordering can be magic to someone debugging a boot issue
on a particular platform.

IMHO, the OF_UPSTREAM migration can wait until all the required DT
sources (.dts and .dtso) are present upstream. If we start to mix and
match DT sources then it is going to turn into maintainers' hardship
again. However, I am still open to further convincing arguments for
this.

-Sumit
