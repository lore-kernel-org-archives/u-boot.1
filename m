Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0A9EE4995
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 11:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC6E889297;
	Wed, 11 Sep 2024 13:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JxAEbgGJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07C6E89242; Wed, 11 Sep 2024 13:29:17 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C57DE89298
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 13:29:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2f7657f9f62so37740621fa.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 04:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726054154; x=1726658954; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/TzFVCr1rk1XJlHoVQybYybhZKB02dNz5VWkIoZxrj8=;
 b=JxAEbgGJMqUYhO4yZ/WYxg610LhFmYSkdb57lW42kzQBDIVochcQM9nyu0Jv6cFRPC
 t+TuXQc46HFrNw9Evt1f2gYoIEHb7mR8rGiAOf0WJVghF9CX0V+9i/L9ly5NM86P9Fi8
 qnN0ruSzfzji4c0BYQo2XjWyb9PdmcjeZRCtyQgIcSM7/KXoCdjBY44KX82z0h78/mxB
 B/snVHe33AATK25FPX+MvULODI4R4PX8180/l3g//SoRSLF4kmNYGYt0tihJbItljc57
 oGx2dJAddHH8+DmDA9r3Gs1ZzFYZupwQBIuUch0mgxkeiy/QtlDaHhdvJAbRHDv7BXDw
 l5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726054154; x=1726658954;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/TzFVCr1rk1XJlHoVQybYybhZKB02dNz5VWkIoZxrj8=;
 b=lQznJ1yBqq1DtzmePPvUl+fzEZivfiv0YGaeuDE0xroPxLgwlGMAJzdHcW3kyaO13c
 ghHK/o+9OMd7x+jfluh/0OBYC/ma/OqIJzbSVS4L2MB1BVj50b/i0Xg1aBsa80r3mOCj
 bnyOZNXUZRyuqVGUJXEF5JNrwr7DXFH2YpLly5TYSot+3cqNlOxOclofr9KjwF3lMArN
 gsnRq9XLqf0RWcI2wYd1CDnhceOctjmEVG/R+tmG8Sufci3APtJkWm0C9cMOPTbvED6w
 0zuFhyCVIDAaIwcjBHOtmLlqejfUavMYB9OLo/oUfcHhi4eDKIuD57E73mYVVLuCSbTh
 Ts7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKUeeJvnrnBOL86Ub1OGWfGEKEtBNQqX//ZuJ/s6turIyVXgehsAtrSMwpAeryUoMbc2eHdcM=@lists.denx.de
X-Gm-Message-State: AOJu0YycSayAuWB2Gk2nORFbMNUHuB1Q1GcRQ7NBshz8jHCnb3LMcEip
 vZPIELGhH04SNcO+CEmDCKI0BpgCnWGlw1xF7b6oxSLHSjgml4GkrUIH8iq4rQF0E755pWcqyD0
 e7pbqC4p86pegKq8MlrbJgyCrRNMvxlVA/bXiow==
X-Google-Smtp-Source: AGHT+IGMFGWT5dAeJ0B846GZgf8R9i22PY5RjXhiRcQNUKeEEEqDnhv3UtZYoN4LO2sUDhv3kzyj01/qf6AJBTuOzaE=
X-Received: by 2002:a2e:750:0:b0:2f6:6029:c63e with SMTP id
 38308e7fff4ca-2f75232695emr86388201fa.23.1726054153698; Wed, 11 Sep 2024
 04:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240910154344.1837906-2-prasad.kummari@amd.com>
 <CADg8p94Fc55EYFVca8V5NPq6xWePgLhV93ebRfFEf-H_GoFgpA@mail.gmail.com>
 <3f149f20-7663-4e37-8a9c-52e4f87b62c8@amd.com>
In-Reply-To: <3f149f20-7663-4e37-8a9c-52e4f87b62c8@amd.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 11 Sep 2024 16:59:02 +0530
Message-ID: <CADg8p97E-Kj_7Sf=_PmgrMAoQwks3wx1Gkqx4Mk9yHhG4Mz1_w@mail.gmail.com>
Subject: Re: [PATCH v3] cmd: sf: prevent overwriting the reserved memory
To: Michal Simek <michal.simek@amd.com>
Cc: Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de, git@amd.com,
 venkatesh.abbarapu@amd.com, padmarao.begari@amd.com, git@xilinx.com, 
 jagan@amarulasolutions.com, n-francis@ti.com, d-gole@ti.com
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

On Wed, 11 Sept 2024 at 16:53, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 9/11/24 13:20, Sughosh Ganu wrote:
> > On Tue, 10 Sept 2024 at 21:14, Prasad Kummari <prasad.kummari@amd.com> wrote:
> >>
> >> Added LMB API to prevent SF command from overwriting reserved
> >> memory areas. The current SPI code does not use LMB APIs for
> >> loading data into memory addresses. To resolve this, LMB APIs
> >> were added to check the load address of an SF command and ensure it
> >> does not overwrite reserved memory addresses. Similar checks are
> >> used in TFTP, serial load, and boot code to prevent overwriting
> >> reserved memory.
> >>
> >> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> >> ---
> >>
> >> Changes in V3:
> >> - Removed lmb_init_and_reserve() as part of latest LMB series.
> >> - Error message moved to one place.
> >> - lmb_alloc_addr() is not required because the given memory address is
> >>    being checked to ensure it is free or not.
> >>
> >> Changes in V2:
> >> - Rebased the code changes on top of the next branch.
> >>
> >> UT:
> >> Tested on Versal NET board
> >>
> >> Versal NET> fdt print /reserved-memory
> >> reserved-memory {
> >>          ranges;
> >>          #size-cells = <0x00000002>;
> >>          #address-cells = <0x00000002>;
> >>          tf-a {
> >>                  reg = <0x00000000 0x70000000 0x00000000 0x00050000>;
> >>                  no-map;
> >>          };
> >> };
> >> Versal NET> sf read 0x70000000 0x0 0x40
> >> device 0 offset 0x0, size 0x40
> >> ERROR: trying to overwrite reserved memory...
> >>
> >> Versal NET> sf write 0x70000000 0x0 0x40
> >> device 0 offset 0x0, size 0x40
> >> ERROR: trying to overwrite reserved memory...
> >>
> >> relocaddr   = 0x000000007febc000
> >>
> >> Versal NET> sf read 0x000000007febc000 0x0 0x40
> >> device 0 offset 0x0, size 0x40
> >> ERROR: trying to overwrite reserved memory...
> >>
> >> Versal NET> sf write 0x000000007febc000 0x0 0x40
> >> device 0 offset 0x0, size 0x40
> >> ERROR: trying to overwrite reserved memory...
> >>
> >>   cmd/sf.c | 36 +++++++++++++++++++++++++++++++++++-
> >>   1 file changed, 35 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/cmd/sf.c b/cmd/sf.c
> >> index f43a2e08b3..7bb8bcfce2 100644
> >> --- a/cmd/sf.c
> >> +++ b/cmd/sf.c
> >> @@ -10,6 +10,7 @@
> >>   #include <div64.h>
> >>   #include <dm.h>
> >>   #include <log.h>
> >> +#include <lmb.h>
> >>   #include <malloc.h>
> >>   #include <mapmem.h>
> >>   #include <spi.h>
> >> @@ -272,6 +273,31 @@ static int spi_flash_update(struct spi_flash *flash, u32 offset,
> >>          return 0;
> >>   }
> >>
> >> +#ifdef CONFIG_LMB
> >> +static int do_spi_read_lmb_check(ulong start_addr, loff_t len)
> >> +{
> >> +       phys_size_t max_size;
> >> +       ulong end_addr;
> >> +
> >> +       lmb_dump_all();
> >> +
> >> +       max_size = lmb_get_free_size(start_addr);
> >> +       if (!max_size) {
> >> +               return CMD_RET_FAILURE;
> >> +       }
> >> +
> >> +       end_addr = start_addr + max_size;
> >> +       if (!end_addr)
> >> +               end_addr = ULONG_MAX;
> >> +
> >> +       if ((start_addr + len) > end_addr) {
> >> +               return CMD_RET_FAILURE;
> >> +       }
> >
> > This is one way to get the load address, yes. But please do note that
> > with this method, if the region of memory has already been marked as
> > reserved, the call to lmb_get_free_size() will fail, i.e. return a
> > value of 0. Whereas if you call lmb_alloc_addr(), and if the memory
> > region is marked reserved with the flags set to LMB_NONE, that call
> > will not fail, as we can re-reserve memory marked as LMB_NONE. Hence a
> > better approach would be to use the logic used in the fs module
> > function that I had pointed to in my earlier email.
> >
> > Also, like I mentioned earlier, it will be better to refactor the
> > functionality, especially if the plan is to introduce this check for
> > loading stuff through other interfaces like nand, mmc etc. You can add
> > a function in the lmb.c like lmb_read_check() which does that.
>
> Is this something what you are going to work on?

Can that not be done as part of this work? It is about having a single
function in the lmb.c file, which simply does a check for
lmb_alloc_addr(). It's not very complicated tbh.

-sughosh
