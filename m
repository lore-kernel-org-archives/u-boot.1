Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F907C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 06:28:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55E99880A5;
	Mon, 22 Jul 2024 08:28:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zJo+FfBX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82E9C8800C; Mon, 22 Jul 2024 08:28:32 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CED28813A
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 08:28:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a77af4cd570so182403566b.1
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 23:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721629710; x=1722234510; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FZjJ2Cintlhg3idWIHMW+ovGYNWrskULMfH5goDqRtw=;
 b=zJo+FfBX3sqCzrRkbAAhGjlqrLAynuoNMpNPu1gK9LLpNWmGsHI6eUYYLDqx/Hnmkh
 McgJ1Ap3rlzehfBMXnss7G+5IGK6ijGXWiz68JjrBaxqjt4Bp4DDl5amB3v9zVcyG8Bh
 vE0LVJ40TyojUmC+0EukrKGTkpUYpuYrX0PyqCjpEj37Or4KX2BG6vuEAcRJSM8rlbAI
 1mkj2YRmFsfw9zWz9um0sQjaA/iX/w16BlCX45zqtqNkr3TeqVvuVnGAyfTUHIdUuITc
 EOVmzXxHMasGY+kX27fDOj9zf/llhyVZwCD9kmvrMcZkUrebCbEu1Sc/trFxBvYbR+2h
 Xseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721629710; x=1722234510;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FZjJ2Cintlhg3idWIHMW+ovGYNWrskULMfH5goDqRtw=;
 b=EfQnK+mHebnYXbMFteI/8SsU4XwOqvJZIhTR7V0X1KU6lwHBeKOBAIrt0ydXRWrc8I
 UKUzxzDzmdE83XZkAtqiFfumn2Rg80di1Sj0fMkL4zf63iuC6Vzd/Ei7Eed02OVI5ORp
 CaX2YHepk5181wpvToA4CHRE/yy+GbORt6veQ22kn3IEYoWINBYQ/YLM17aAHQsagyDb
 sr1eLrWtCBXqR/byg1GDCW8itEkAjkqz9GEb5pn65yB/bocWPX5LovYLnRZLlm8NRIDh
 g3Bc8vEBjbaqzwrIYnF9n3f7w7ti0XhI3XO44w7+a6Q5syswNmXgSCkgNvC9e4Tvv/Il
 86yw==
X-Gm-Message-State: AOJu0Yx7j7/DenrL9/X1+j1dR83E2tIe3BBL7QT5kVzgCn6FI/b0VYU3
 x8kGBs7DM5xCC6ioyiVw4OfvRcX8kploS6Sse/qTsG6uiGjUFRUwFXW8Pfxq1ZsEKR8GObcWraw
 tDljv+LmJl3a0Q1gsmVZHH4Ve/L9wi3ZtritAyQ==
X-Google-Smtp-Source: AGHT+IGLOvIPqjjVveOT4k4oN5qRxYroplIItKWmOrnMSIPLteN6qiQssLivBTRK50IPnkCGuJA3cmpQTRGQ3+XUwe0=
X-Received: by 2002:a50:9553:0:b0:5a2:8f7d:aff4 with SMTP id
 4fb4d7f45d1cf-5a479b729b2mr4521897a12.20.1721629709616; Sun, 21 Jul 2024
 23:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240708140242.GA38804@bill-the-cat>
In-Reply-To: <20240708140242.GA38804@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 22 Jul 2024 11:58:18 +0530
Message-ID: <CADg8p968x-UsiHEazS81+DxSXN0DLHpjTEDYDA+0LO=3hGK86A@mail.gmail.com>
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

On Mon, 8 Jul 2024 at 19:32, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jul 04, 2024 at 01:04:56PM +0530, Sughosh Ganu wrote:
>
> > The aim of this patch series is to fix the current state of
> > incoherence between modules when it comes to memory usage. The primary
> > issue that this series is trying to fix is that the EFI memory module
> > which is responsible for allocating and freeing memory, does not have
> > any visibility of the memory that is being used by the LMB
> > module. This is further complicated by the fact that the LMB
> > allocations are caller specific -- the LMB memory map is not global
> > nor persistent. This means that the memory "allocated" by the LMB
> > module might be relevant only for a given function. Hence one of the
> > requirements for making the memory usage visible across modules is to
> > make LMB allocations persistent and global, and then have means to
> > communicate the use of memory across modules.
> >
> > The first set of patches in this series work on making the LMB memory
> > map persistent and global. This is being done keeping in mind the
> > usage of LMB memory by platforms where the same memory region can be
> > used to load multiple different images. What is not allowed is to
> > overwrite memory that has been allocated by the other module,
> > currently the EFI memory module. This is being achieved by introducing
> > a new flag, LMB_NOOVERWRITE, which represents memory which cannot be
> > re-requested once allocated.
> >
> > A review comment on the earlier version was to do away with the static
> > arrays for the LMB lists of free and used memory. This version
> > uses the alloced list data structure for the LMB lists.
> >
> > The second set of patches are making changes to the EFI memory module
> > to make use of the LMB functions to allocate and free memory. A
> > *_flags() version of LMB API's has been introduced for the same. The
> > earlier version was using notification mechanism from both LMB and EFI
> > modules to maintain memory coherence. This version makes use of the
> > LMB API functions for the memory allocations. This is based on review
> > comments of EFI maintainers.
>
> On am64x_evm_a53, the last test in test/py/tests/test_net_boot.py fails
> due to:
> ...
> TFTP from server 192.168.116.10; our IP address is 192.168.116.23
> Filename 'pxelinux.cfg/default-arm-k3'.
> Load address: 0x80100000
> Loading: ##################################################  64 Bytes
>          8.8 KiB/s
> done
> Bytes transferred = 64 (40 hex)
>   1  pxe          ready   ethernet     0  port@1.bootdev.0          extlinux/extlinux.conf
> ** Booting bootflow 'port@1.bootdev.0' with pxe
> Retrieving file: pxelinux.cfg/default-arm
> am65_cpsw_nuss_port ethernet@8000000port@1: K3 CPSW: rflow_id_base: 16
> link up on port 1, speed 1000, full duplex
> Using ethernet@8000000port@1 device
> TFTP from server 192.168.116.10; our IP address is 192.168.116.23
> Filename 'pxelinux.cfg/default-arm'.
>
> TFTP error: trying to overwrite reserved memory...
> Couldn't retrieve pxelinux.cfg/default-arm

So this seems to be failing because the address used to load the pxe
config file seems to be overlapping with an already reserved region of
memory. Can you please check if modifying the address works?

>
> And note that the pxelinux.cfg files are created as defined by the
> example within the test. This test is also still fine on Pi 4.

If this is working fine on the Pi 4, this is mostly to do with needing
to tweak the load address.

-sughosh

>
> --
> Tom
