Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825A6C3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 06:43:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D73EB88E5F;
	Mon, 16 Sep 2024 08:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YqeWotFc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 046AF88DC6; Mon, 16 Sep 2024 08:43:29 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D72B288E7C
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 08:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c4226a5af8so3507736a12.1
 for <u-boot@lists.denx.de>; Sun, 15 Sep 2024 23:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726469006; x=1727073806; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z48yVjzdGSmchCcXTy+CP6lhZsGTgrw8FcFNctZ59GA=;
 b=YqeWotFcn23r2y3CR8eTuL3d/fDK/yj7hHXrZSclEIoEvZNwwt708SMn30wZafgklM
 pAHjRjTl34BsHv1lwROF4HbwxsIBitkpVf4LVCFM60dSkvtTDlbVKqUnGsd01tqTLKXR
 GFxY5npkmK9fAh0FGUL7hJKswL2Fb2rXzMieWZiRkJlc729GZmqp00TBzoVrRDNYJ4rU
 09IR9bhEqnHYD0KVNst2yBUILJ6oZEzGWKlQLXYPm7QnBjB5/iCYKenWjUTmFWwLwH0q
 JjER/YZxXpyw6ZzuJhJxsKeXR7Reyds86ynp0Q2mjnHI0lyVP1OEfcxW6dYpGrSLlgAI
 x+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726469006; x=1727073806;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z48yVjzdGSmchCcXTy+CP6lhZsGTgrw8FcFNctZ59GA=;
 b=uMGxQKoCq0KHLskJh7B6fMHKvyhcL1gurmXgqUeiZ6L5618d/AKxcl6UJSBAbDSULS
 iJLI5LkH176OnpjL8nzg8iBtXAPgcrJvxOOh+ttZ4fnUons039KmsyGD1rOwZRWBpckN
 81KFCmohd4/eWJ/rZexCJ15VD0lm5Om+RTvrP3d/CCPRlGpVfH+ANEyyLhP11RJk9zxq
 HFvhcbWLQfDumaqZML4yhM2c5YiheHqUOPIB+doCRXirMVZPFO4SYAaJCxhtDm0m9o0N
 0VDgLQtRD0w4egl+HQVXblpAU/2iqyV0RPmzArY7YTNT6kXQAh90i/e5f9SaHCBee95I
 KMZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCwibjY2K6Xke8cPNFvdTKLsyu/pFaF331ewhNONPzv0ailZhmn4xxSVM9f2Ov3pDcdUuRkXc=@lists.denx.de
X-Gm-Message-State: AOJu0YyY979Ws0TqVVvwwbS/h/fY5U3B9c1exgG4Yksb5kjG5NW+cp1l
 OIxsLzqiJORT1A/GVW5T8ffZFkIgQYwNOWTAV/aEd9JLvgrbFi92erTppi7LlNYKfvXNY0bM+kn
 AQyIqnJ7uNwMgrLKz5Jx5a/Mhuc4WORM4YxR8gw==
X-Google-Smtp-Source: AGHT+IHUGHXlfjLJhjPOhOwtAZEK21UC1HsQC2w49wXLHBs/Qhz1vs94rfvw6vk/ShlAGCyvS85jTIMCQdC32J1SZC0=
X-Received: by 2002:a05:6402:4310:b0:5c4:2c97:bcb with SMTP id
 4fb4d7f45d1cf-5c42c970de0mr6715373a12.1.1726469006007; Sun, 15 Sep 2024
 23:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240913073251.2286529-2-prasad.kummari@amd.com>
 <c9e22782-8645-420c-9017-18f3aafcbb12@ti.com>
In-Reply-To: <c9e22782-8645-420c-9017-18f3aafcbb12@ti.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 16 Sep 2024 12:13:15 +0530
Message-ID: <CADg8p95RA_iOUYmjLaED52C7ebGPuor=Zd+16zmVvDiEV3aesw@mail.gmail.com>
Subject: Re: [PATCH v4] cmd: sf: prevent overwriting the reserved memory
To: Vaishnav Achath <vaishnav.a@ti.com>
Cc: Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de, git@amd.com,
 michal.simek@amd.com, venkatesh.abbarapu@amd.com, padmarao.begari@amd.com, 
 git@xilinx.com, jagan@amarulasolutions.com, n-francis@ti.com, d-gole@ti.com, 
 Vignesh Raghavendra <vigneshr@ti.com>, "Kumar, Udit" <u-kumar1@ti.com>
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

On Mon, 16 Sept 2024 at 11:47, Vaishnav Achath <vaishnav.a@ti.com> wrote:
>
> Hi Prasad,
>
> On 13/09/24 13:02, Prasad Kummari wrote:
> > Added LMB API to prevent SF command from overwriting reserved
> > memory areas. The current SPI code does not use LMB APIs for
> > loading data into memory addresses. To resolve this, LMB APIs
> > were added to check the load address of an SF command and ensure it
> > does not overwrite reserved memory addresses. Similar checks are
> > used in TFTP, serial load, and boot code to prevent overwriting
> > reserved memory.
> >
> > Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> > ---
> > Changes in V4:
> > - Removed do_spi_read_lmb_check().
> > - Added the lmb_read_check() function in lmb.c, making it reusable for
> >    NAND, MMC, etc.
> > - Addressed review comments.
> >
> > Changes in V3:
> > - Removed lmb_init_and_reserve() as part of latest LMB series.
> > - Error message moved to one place.
> > - lmb_alloc_addr() is not required because the given memory address is
> >    being checked to ensure it is free or not.
> >
> > Changes in V2:
> > - Rebased the code changes on top of the next branch.
> >
> > UT:
> > Tested on Versal NET board.
> >
> > relocaddr   = 0x000000007febc000
> >
> > Versal NET> sf read 0x000000007febc000 0x0 0x40
> > device 0 offset 0x0, size 0x40
> > ERROR: trying to overwrite reserved memory...
> > Versal NET> sf write 0x000000007febc000 0x0 0x40
> > device 0 offset 0x0, size 0x40
> > ERROR: trying to overwrite reserved memory...
> >
> > Versal NET> fdt print /reserved-memory
> > reserved-memory {
> >       ranges;
> >       #size-cells = <0x00000002>;
> >       #address-cells = <0x00000002>;
> >       tf-a {
> >               reg = <0x00000000 0x70000000 0x00000000 0x00050000>;
> >               no-map;
> >       };
> > };
> > Versal NET> sf read 0x70000000 0x0 0x40
> > device 0 offset 0x0, size 0x40
> > ERROR: trying to overwrite reserved memory...
> > Versal NET> sf write 0x70000000 0x0 0x40
> > device 0 offset 0x0, size 0x40
> > ERROR: trying to overwrite reserved memory...
> > Versal NET> sf erase 0x0 0x1000000;mw.b 0x8000 aabbccdd 0x1000000;sf
> > write 0x8000 0x0 0x1000000;mw.b 0x8008000 0x0 0x1000000;sf read
> > 0x8008000 0x0 0x1000000;cmp.b 0x8000 0x8008000 0x01000000
> > SF: 16777216 bytes @ 0x0 Erased: OK
> > device 0 offset 0x0, size 0x1000000
> > SF: 16777216 bytes @ 0x0 Written: OK
> > device 0 offset 0x0, size 0x1000000
> > SF: 16777216 bytes @ 0x0 Read: OK
> > Total of 16777216 byte(s) were the same
> >
> >   cmd/sf.c      | 8 ++++++++
> >   include/lmb.h | 5 +++++
> >   2 files changed, 13 insertions(+)
> >
> > diff --git a/cmd/sf.c b/cmd/sf.c
> > index f43a2e08b3..08e364e191 100644
> > --- a/cmd/sf.c
> > +++ b/cmd/sf.c
> > @@ -10,6 +10,7 @@
> >   #include <div64.h>
> >   #include <dm.h>
> >   #include <log.h>
> > +#include <lmb.h>
> >   #include <malloc.h>
> >   #include <mapmem.h>
> >   #include <spi.h>
> > @@ -317,6 +318,13 @@ static int do_spi_flash_read_write(int argc, char *const argv[])
> >                       strncmp(argv[0], "write", 5) == 0) {
> >               int read;
> >
> > +             if (CONFIG_IS_ENABLED(LMB)) {
> > +                     if (lmb_read_check(addr, len)) {
>
> Even though the function is named lmb_read_check(), it performs an alloc
> which is never freed, thus it makes it difficult for other callers to
> use the same region for other purposes (some callers use
> lmb_get_free_size() ), as mentioned in the commit message the check is
> only to prevent sf from overwriting reserved region, but it looks like
> this patch makes the load region also as reserved, is this necessary?

Like I mentioned in my other reply, using a check for lmb_alloc_addr()
allows for memory re-use, which is the behaviour that a large number
of use cases rely on -- if you go through the test scripts, it is
assumed that memory re-use is allowed. That there is no need to
explicitly free up memory, and that has been how the LMB memory has
been used historically. So it is allowed to use some address to load
an image to that address, and then use the same address to load a
different image. The LMB rework series does keep this behaviour
consistent. So it would be better to change the behaviour of the tftp
command to use the same API. I was planning on working on this
cleanup. If you want, you can take it up.

>
>
> > +                             printf("ERROR: trying to overwrite reserved memory...\n");
> > +                             return CMD_RET_FAILURE;
> > +                     }
> > +             }
> > +
> >               read = strncmp(argv[0], "read", 4) == 0;
> >               if (read)
> >                       ret = spi_flash_read(flash, offset, len, buf);
> > diff --git a/include/lmb.h b/include/lmb.h
> > index fc2daaa7bf..aee2f9fcda 100644
> > --- a/include/lmb.h
> > +++ b/include/lmb.h
> > @@ -111,6 +111,11 @@ struct lmb *lmb_get(void);
> >   int lmb_push(struct lmb *store);
> >   void lmb_pop(struct lmb *store);
> >
> > +static inline int lmb_read_check(phys_addr_t addr, phys_size_t len)
> > +{
> > +     return lmb_alloc_addr(addr, len) == addr ? 0 : -1;
>
> who frees this? can we free this right after checking?

It is not required to explicitly free up this memory, as it is not an
actual allocation per-se. Why were these functions called alloc
something, I am not sure. But the point is, if you change the tftp
command code to use this API instead, and then use it after a previous
load, it would not fail.

-sughosh

>
> Thanks and Regards,
> Vaishnav
>
> > +}
> > +
> >   #endif /* __KERNEL__ */
> >
> >   #endif /* _LINUX_LMB_H */
