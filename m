Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D78EECD6CA
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 17:05:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A03A8367F;
	Wed, 11 Feb 2026 18:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S1JnIhXu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7274A8367F; Wed, 11 Feb 2026 18:05:05 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C88482BF2
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 18:05:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-385c2f88618so16944231fa.2
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 09:05:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770829502; cv=none;
 d=google.com; s=arc-20240605;
 b=GiXUbFaMjbTUmBRA3whWVsPytgoWCtBSj6kaIARvd+NtGr2K5L1SIRlQIRWmRl1qal
 YjltLZmWQ8mKJqiWGThDuyi0Fyeuxwn8h4EFc6n7Hp9lyULVK44EQ7jiUMjhVmblHpXe
 9SLXKqiTw4aranIzxBWXFRSrmE+S4aEVRV6qF67C4JXZfzrSpEhASZ0l4A97qeAkaAaK
 UlppdgM3nbUWkxp7wuePMfEXkZpuGl1OGEosw6ivXebL8074L3DLdcl6mXD3dzjn1Jpw
 YCEvPo5PtyNPfwyBxyQssQPEoKIHCgDJJja2BV/iPtwlcRYRq8M8goLMRk653hd+HAUP
 Jttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NQu7LLHMXU7+vVDQFBbQ0QoHmruB/pNATuntNtFfTnc=;
 fh=VLd45aDj+CEvRnVEhHCFKWXi+6GRCD5RzIZk+F6RKOM=;
 b=j6BLzz6LdznsaN7YQsGo0FT/Hc4souOOi6bBI3icrdUSGOTBvui33lkWCleVRQGmTc
 PMGZofogkT116yksafu0luLYqRDEHyfZN7HqTcHL10nuLuBlzb/61el8BhEIBMyt7OHX
 04hDy3UVrjibR6J4g2+JiBHKFq1OQ8c1yajsBvl3SfhS+ocl0rfOiQb8PRJdxZtj1KT+
 a6xqLEum0UWIPv8Ng+ZJ3RSZv1smi1q36DWKEVwMlFWDlHfkU1ZdjFS2tJ/R5Jifbg5e
 ypd9nD94ihXjx5l5m3nTovWa1lr10GoAjvM5ZfXFqNCUF+KaMx79GkP3CCX40kkvsZdh
 w66w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770829502; x=1771434302; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQu7LLHMXU7+vVDQFBbQ0QoHmruB/pNATuntNtFfTnc=;
 b=S1JnIhXuLCAGLY/s1Inci8u1m3r46W5QxdLRV2hulG1PWilcoULJplhrG19Gsm9Hg4
 ZjGl7BSLDov7J/F2kov/98FQmwfS2vOEc5jI909CNPemKkokhY1a6HMY3k+cZzsKMRjD
 G83rxr8JgK5c4P1p9rjdKgX6qxZeuMfDDO6m2OZ6renVkN2KeGeahbR7wdcg3ixQcsBq
 InHpvdn/MyUzhLfYHtpF7G4Bb+WQlHKNTgNCZihtcHgIQTEmEGMwbqiodiSMHmZGGylz
 xCsKc011hgwkazEmCuz/WwoMIKLXGA1ZeA067HTkKWhod39iXrtAizaR5PimWZxPBaFI
 V3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770829502; x=1771434302;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NQu7LLHMXU7+vVDQFBbQ0QoHmruB/pNATuntNtFfTnc=;
 b=EHy8inpvVFkQvF3rr0iz+Iv0wXprBXONs78/lbLcD+NwlI2UgaoJhk4Uj7rVw76taq
 wyupk9/x7XIzZm4/v1iGynmxJ2p1nuj304JGsvJTmCZYSQGoLt9vMXw73+Z6bJpNyNWF
 Ey7xbPbM/jg/1lSR6W3SyXvOQafK+4qaWpY/3KGdoXAwOYyLS+VnSJP7AsLXBI+SK+Wq
 sdKlRedwx8zkF62fN8RYcyT3FQiBD6AtEXeQC3/owo7RWHPn6vDkzH3A4LFQteScpmjk
 mCc6Fge918kaTfuKiCArKnyqanoODnME/gg9sxJcYY1U70+grPogQvpZV0iELmK9/uNZ
 g+jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkGHBQTNpjWj+7lXyNmd4MzbujcTmf/6EL3NVWQ2wVSOTcCq2zxKVNYIIQkoTnCpSopzLRypI=@lists.denx.de
X-Gm-Message-State: AOJu0YzP6CVRawUTOozch5vzSZDf59ZbOLxUtAo07281/E1NTButB3mt
 1HpcczTv85ZhF57EIDdX/abA0KoHfPYyXL0NbWr9uhexc1NnLW4JT3v3sGLtCIAU3SWzQdrJXnt
 pkFYizDLL7zmG2Vm1eInnkWvCxavWaNg=
X-Gm-Gg: AZuq6aLE/I6lbnuewZLoM7wI9k4vjvADcWw+JWLbhwjLOrLx9use8kbRcqgf/0K/nl6
 iNITz0ZxsAPbS471xFd/M0RKL7EzV5AZLs6GLbhv7cKJJAss2XLUDZ6+oawzFsd5uGhd+GnF5Be
 +ilsQ86wB46piAvBHBFNZEuXUYqK5QtT8LV0o/XICD2dIULByAAD0umqt8qVWOcvfKJ4vHaACuy
 j4bYGXxj4CzoH3EBbYj7+0766SZX6xXDmpIPHw9ut7OlxPeayjW/uF8/WdrPAViqleomXTJJZRy
 6mQ1NTIgpqc3epLbcvALXZ7JeW88S9ih7JapuDs=
X-Received: by 2002:a2e:a7c1:0:b0:386:e8bd:505e with SMTP id
 38308e7fff4ca-386e8bd5260mr31262411fa.40.1770829501958; Wed, 11 Feb 2026
 09:05:01 -0800 (PST)
MIME-Version: 1.0
References: <20260203074721.25520-1-dinesh.maniyam@altera.com>
 <20260203074721.25520-2-dinesh.maniyam@altera.com>
 <20260203145742.GH2603314@bill-the-cat>
 <074a310c-5ba3-4304-ab37-2c85d8cd58da@altera.com>
 <CAOf5uwkE_hfjLkxbOn-O2o3sYSGqAV0TVdZ7yg6eZqJgWGjDCg@mail.gmail.com>
In-Reply-To: <CAOf5uwkE_hfjLkxbOn-O2o3sYSGqAV0TVdZ7yg6eZqJgWGjDCg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 11 Feb 2026 14:04:50 -0300
X-Gm-Features: AZwV_QiZF3uM6OajQhzixwKKK-Utqk9xL2FOnQfr9sjZMs8xxnq_aP-5KPatYuU
Message-ID: <CAOMZO5BBnfj59iDR4J4n+EHUVEDq4Fuws9ess5xjRMPCB3GQxw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mtd: nand: introduce SPL_NAND_FRAMEWORK_CAPABLE
 Kconfig option
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Tien Fong <tien.fong.chee@altera.com>, 
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>, 
 Alif <alif.zakuan.yuslaimi@altera.com>
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

Hi Dinesh,

On Wed, Feb 11, 2026 at 4:20=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:

> This what I have asked in the beginning, for now I don't like to have
> this change
> in the framework unless we have more consumer. For the patch that you sen=
t for
> make simple spl load, I will try to start to apply on one of my board

I'm also interested in SPL NAND support. I have recently made an
attempt to add SPI NAND SPL support:

https://lore.kernel.org/u-boot/20260208212624.3413494-7-festevam@gmail.com/

And then Jonas pointed out your series.

Do you think it can be extended to support SPI NAND?

> > +config SPL_NAND_FRAMEWORK_CAPABLE
> > + bool
> > + depends on SPL_DM
> > + depends on SPL_HAS_BSS_LINKER_SECTION

This is not defined on my platform.

> > + depends on SPL_MAX_SIZE >=3D 0x40000

This is also not defined.

> > + help
> > +  Indicates that the platform has sufficient SPL capabilities
> > +  (driver model, BSS support, and SRAM size) to support the
> > +  full NAND/MTD framework in SPL.
> > +
> > +config SPL_NAND_USE_NAND_FRAMEWORK
> > + bool "Use NAND/MTD framework in SPL"
> > + depends on SPL_NAND_SUPPORT && MTD
> > + depends on SPL_NAND_FRAMEWORK_CAPABLE
> > + depends on SPL_ENV_SUPPORT
> > + depends on ENV_IS_IN_NAND
> > + select SPL_SYS_NAND_SELF_INIT
> > + select SPL_NAND_BASE
> > + select SPL_NAND_DRIVERS
> > + select SPL_NAND_IDENT
> > + select SPL_NAND_INIT
> > + select SPL_NAND_ECC
> > + help
> > + Enable loading U-Boot from NAND in SPL using the full
> > + NAND/MTD framework instead of the minimal SPL NAND loaders.
> > + This provides bad-block aware reads and flexible offset
> > + handling via the common NAND/MTD infrastructure.
> > + Platforms enabling this option must also provide working
> > + driver model support and sufficient SPL memory resources.

When I try to build it, I get the following error:

drivers/mtd/nand/raw/nand.c:15:34: error: =E2=80=98CFG_SYS_NAND_BASE=E2=80=
=99
undeclared here (not in a function); did you mean
=E2=80=98CFG_SYS_SDRAM_BASE=E2=80=99?
   15 | #define CFG_SYS_NAND_BASE_LIST { CFG_SYS_NAND_BASE }

In my SPI NAND case, there is no NAND controller, so no
CFG_SYS_NAND_BASE is defined.
