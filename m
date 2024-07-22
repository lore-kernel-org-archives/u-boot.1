Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8C8C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 17:38:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70C3588387;
	Mon, 22 Jul 2024 19:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qXdI+M1O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69F9E87A09; Mon, 22 Jul 2024 19:38:05 +0200 (CEST)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CFAC87D74
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:37:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-4ef12e5658bso1385504e0c.2
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721669877; x=1722274677; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e11WXnVUbrXSVo1L1cKam2thLTO1fC9rohwOOWhGvuk=;
 b=qXdI+M1OBZNRsLh2+3v8K/U4RV6UszIH0ZE5iuvPaikrdlGzJQ1Q1ulPTTa9vNER6V
 XY1lzRMAr1kXIr+TI0mA8wMFOq2SzIpMqI3j3gPSVUedc04TqcIAjC+Q/uOn1eJJNC0z
 ZkyxzvMMS40JWp2jndB5cKy6ndrzHW7yFzhvwXEaKhT/5hpSpkCwGc1+LGsrlxgBZOhn
 hOgkLhMXc0RGlGvm/x4t34HF+E3cL/vh4HfEfBlxiMhMQPX1GP4T/yLB8Trzuagz98ZD
 H/BHBVAdtgxv44jiUXn8yIHdJzq4dpXTQLAmJzqambACZ8FuZ7grvyCBpQxoRzY5X5pM
 ZlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721669877; x=1722274677;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e11WXnVUbrXSVo1L1cKam2thLTO1fC9rohwOOWhGvuk=;
 b=v3H3/cx1Funm2td84bxy/UtnPGAGue5c00djw9NAg/1itRChp8K8nl5PxfznjTWxBx
 sMFxM0byGaULcY6Z2Hv4VwUcCf961tbi/TucBKFy72kiysddUvRcM3aKNByJPjV75CkD
 ++JExKW8YWAtE6Lh8c4OML/pG17h4qXu3E2ol78Uh2OuJE2hgYQjeBx6H+MjcBA4iyu8
 GhCtzMwE9TU5C7WnxlnJYlXRjV4n2mugkdHSUwZ/l+q3i/nqiyjvlojqIPf7NLBgcJ+/
 vfkWPAXQOUToRoO0MD98lOtGeRodchyGMvIsMZXNaFkm6Frr9kaCKIU24exzBq/CYmD7
 O5kA==
X-Gm-Message-State: AOJu0YyW3AxDbrXX5NJaDcsUg6tClLNnaN82sn36O6GieTOsw+uQjltS
 +J6REIv51HVtO4qtpE6nT6qAdsvVsYp3iGf/SVMVdKbv2Tez8+CToCzkKuLZL9JcBsFBPfRStNz
 SjNyeO1MbC1FS3z4FFQ/6KJ77vhyUlKNEPRb7AzC9Scsq5PW8
X-Google-Smtp-Source: AGHT+IE6t9AO1wd/xnjh0N0Ag4sMfnhc2ZCjCi5ImSyVoOgXRMELMtqzT8haTyjFZYFc6zMauYQlWmKA60F+GmzA0yA=
X-Received: by 2002:a05:6122:88a:b0:4ef:281f:84d7 with SMTP id
 71dfb90a1353d-4f50665886emr6479979e0c.2.1721669876898; Mon, 22 Jul 2024
 10:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240708140242.GA38804@bill-the-cat>
 <CADg8p968x-UsiHEazS81+DxSXN0DLHpjTEDYDA+0LO=3hGK86A@mail.gmail.com>
 <20240722173325.GA989285@bill-the-cat>
In-Reply-To: <20240722173325.GA989285@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 22 Jul 2024 23:07:45 +0530
Message-ID: <CADg8p97bFNApmT+sPPs4MYhyOwzAdK_7M6n__0CaX5iV1MvK-w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/48] Make U-Boot memory reservations coherent
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>, 
 Michal Simek <michal.simek@amd.com>
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

On Mon, 22 Jul 2024 at 23:03, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jul 22, 2024 at 11:58:18AM +0530, Sughosh Ganu wrote:
> > On Mon, 8 Jul 2024 at 19:32, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Jul 04, 2024 at 01:04:56PM +0530, Sughosh Ganu wrote:
> > >
> > > > The aim of this patch series is to fix the current state of
> > > > incoherence between modules when it comes to memory usage. The primary
> > > > issue that this series is trying to fix is that the EFI memory module
> > > > which is responsible for allocating and freeing memory, does not have
> > > > any visibility of the memory that is being used by the LMB
> > > > module. This is further complicated by the fact that the LMB
> > > > allocations are caller specific -- the LMB memory map is not global
> > > > nor persistent. This means that the memory "allocated" by the LMB
> > > > module might be relevant only for a given function. Hence one of the
> > > > requirements for making the memory usage visible across modules is to
> > > > make LMB allocations persistent and global, and then have means to
> > > > communicate the use of memory across modules.
> > > >
> > > > The first set of patches in this series work on making the LMB memory
> > > > map persistent and global. This is being done keeping in mind the
> > > > usage of LMB memory by platforms where the same memory region can be
> > > > used to load multiple different images. What is not allowed is to
> > > > overwrite memory that has been allocated by the other module,
> > > > currently the EFI memory module. This is being achieved by introducing
> > > > a new flag, LMB_NOOVERWRITE, which represents memory which cannot be
> > > > re-requested once allocated.
> > > >
> > > > A review comment on the earlier version was to do away with the static
> > > > arrays for the LMB lists of free and used memory. This version
> > > > uses the alloced list data structure for the LMB lists.
> > > >
> > > > The second set of patches are making changes to the EFI memory module
> > > > to make use of the LMB functions to allocate and free memory. A
> > > > *_flags() version of LMB API's has been introduced for the same. The
> > > > earlier version was using notification mechanism from both LMB and EFI
> > > > modules to maintain memory coherence. This version makes use of the
> > > > LMB API functions for the memory allocations. This is based on review
> > > > comments of EFI maintainers.
> > >
> > > On am64x_evm_a53, the last test in test/py/tests/test_net_boot.py fails
> > > due to:
> > > ...
> > > TFTP from server 192.168.116.10; our IP address is 192.168.116.23
> > > Filename 'pxelinux.cfg/default-arm-k3'.
> > > Load address: 0x80100000
> > > Loading: ##################################################  64 Bytes
> > >          8.8 KiB/s
> > > done
> > > Bytes transferred = 64 (40 hex)
> > >   1  pxe          ready   ethernet     0  port@1.bootdev.0          extlinux/extlinux.conf
> > > ** Booting bootflow 'port@1.bootdev.0' with pxe
> > > Retrieving file: pxelinux.cfg/default-arm
> > > am65_cpsw_nuss_port ethernet@8000000port@1: K3 CPSW: rflow_id_base: 16
> > > link up on port 1, speed 1000, full duplex
> > > Using ethernet@8000000port@1 device
> > > TFTP from server 192.168.116.10; our IP address is 192.168.116.23
> > > Filename 'pxelinux.cfg/default-arm'.
> > >
> > > TFTP error: trying to overwrite reserved memory...
> > > Couldn't retrieve pxelinux.cfg/default-arm
> >
> > So this seems to be failing because the address used to load the pxe
> > config file seems to be overlapping with an already reserved region of
> > memory. Can you please check if modifying the address works?
>
> I'm not sure what address you're thinking of modifying but, this isn't
> overwriting U-Boot itself so it's a case that needs to work.

Can you please print the lmb memory map through bdinfo and share it
with me. That will give some info on what is causing the issue. Thing
is, with this patchset, if there is another reservation with a
different flag(like LMB_NOMAP, LMB_NOOVERWRITE), this would cause the
load to fail.

-sughosh

>
> --
> Tom
