Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6985AEE4998
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 11:56:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96B498929D;
	Wed, 11 Sep 2024 13:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Jg/JmoF/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF3478929E; Wed, 11 Sep 2024 13:56:33 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA6A389299
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 13:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c241feb80dso1634426a12.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 04:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726055788; x=1726660588; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J73L/dXKyjEsTaPPfK/6igfKyJpQtshOxvZST9Ypwmc=;
 b=Jg/JmoF/ktUroP1WJRmLZDFhWGyLnLEOamWzKa1kz99aeaTeSrUMCwlRkI8J0JmMY+
 po411f4GLCW0omMe6p+eM8B5NiZsa9XglBO+DRFhz7Otc2+RBoZMOGBx8P6Iuj5YV0em
 Lgysmo8EV8+pZ/7IMac3K79R0iTRX8z2q6p6CGk//zjzIcviikR+k+nYasYb0D5Yf+Yp
 LUM6eXsju0xeJbdcytdt4TyOfy1q5KenfazZXxyVVJpmAYqTQoBG4Da6dnEoZmOe14Zg
 1HTqtCgxH7PomjdHdWWHNBK3/6G6smcmaqVbNfij0nm5oUq9QtXnirE0sHwSuGCyBuzF
 aQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726055788; x=1726660588;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J73L/dXKyjEsTaPPfK/6igfKyJpQtshOxvZST9Ypwmc=;
 b=Z/CIjxhKtHuJocgR0zKziqOK+I5aPAPwMvXOzgubwIHKnO8e70KOB/YgbHcWwRnzyG
 PHlCg4VZlbfRGEbwjtBFGzEW01f4ztuwttp+X5rkIRLrFFx8YDwEX5oXdgY9vqmAejix
 wz89eRyoE3evp0tW+j3sv8Mja/2Ha2RSphMhuIFcfukg8K60NS2uFgJ1Snzx8vo89g8U
 lyWyo1ysp8u1gJUQOUFzUey0T47sE92/hO3JqnPTRv1OGpVH4lIlsUtGV8lpyw9RiSol
 GxvRoTLIVj2Jt744cY4CThxRqts0/EC11iIQeh6MG9Q1XsUrFv/xwAwioZ2zNtNDSL8u
 qRQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOyt3wTDc0jTqv6pDdpIcdu3Xioqgo54oplI09mRElYcW5g/Z1Phqopamv5YEroMSrJ0y50B0=@lists.denx.de
X-Gm-Message-State: AOJu0YzYvOy+c0+jtEnQYNiHgaEOHMjQGcla+z2YIhT44+5fjFzHQ3yy
 fAqIaNcCApxycSE3C4w6vRzZUVWXfpRhDuIgfyyQKKpdIuHkAtMUPyfw3Nea0s4R91LNw7pK7IY
 TutfIBn7CeN7GgsP0T7iJ51MsjctviWddUJK9sw==
X-Google-Smtp-Source: AGHT+IFXeTPsEvKmhWpJmGuZ0qqv+Fnfzk3ZSjIB/e310fdLaYLSS8Z8covfHPLLUTO4NLgWR9jYBJ9Nz0ej91Vd6Ew=
X-Received: by 2002:a05:6402:280f:b0:5c3:cc44:570a with SMTP id
 4fb4d7f45d1cf-5c4015ce2c8mr7185873a12.2.1726055787511; Wed, 11 Sep 2024
 04:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240910154344.1837906-2-prasad.kummari@amd.com>
 <CADg8p94Fc55EYFVca8V5NPq6xWePgLhV93ebRfFEf-H_GoFgpA@mail.gmail.com>
 <3f149f20-7663-4e37-8a9c-52e4f87b62c8@amd.com>
 <CADg8p97E-Kj_7Sf=_PmgrMAoQwks3wx1Gkqx4Mk9yHhG4Mz1_w@mail.gmail.com>
 <9fd1ffac-4045-44b1-b0b9-e2a7442d2fa9@amd.com>
In-Reply-To: <9fd1ffac-4045-44b1-b0b9-e2a7442d2fa9@amd.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 11 Sep 2024 17:26:15 +0530
Message-ID: <CADg8p97OnGd43GQF1Oy8WGnXMkH7BVpVKbcQgRX_+3q+0ond6g@mail.gmail.com>
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

On Wed, 11 Sept 2024 at 17:02, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 9/11/24 13:29, Sughosh Ganu wrote:
> > On Wed, 11 Sept 2024 at 16:53, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >>
> >>
> >> On 9/11/24 13:20, Sughosh Ganu wrote:
> >>> On Tue, 10 Sept 2024 at 21:14, Prasad Kummari <prasad.kummari@amd.com> wrote:
> >>>>
> >>>> Added LMB API to prevent SF command from overwriting reserved
> >>>> memory areas. The current SPI code does not use LMB APIs for
> >>>> loading data into memory addresses. To resolve this, LMB APIs
> >>>> were added to check the load address of an SF command and ensure it
> >>>> does not overwrite reserved memory addresses. Similar checks are
> >>>> used in TFTP, serial load, and boot code to prevent overwriting
> >>>> reserved memory.
> >>>>
> >>>> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> >>>> ---
> >>>>
> >>>> Changes in V3:
> >>>> - Removed lmb_init_and_reserve() as part of latest LMB series.
> >>>> - Error message moved to one place.
> >>>> - lmb_alloc_addr() is not required because the given memory address is
> >>>>     being checked to ensure it is free or not.
> >>>>
> >>>> Changes in V2:
> >>>> - Rebased the code changes on top of the next branch.
> >>>>
> >>>> UT:
> >>>> Tested on Versal NET board
> >>>>
> >>>> Versal NET> fdt print /reserved-memory
> >>>> reserved-memory {
> >>>>           ranges;
> >>>>           #size-cells = <0x00000002>;
> >>>>           #address-cells = <0x00000002>;
> >>>>           tf-a {
> >>>>                   reg = <0x00000000 0x70000000 0x00000000 0x00050000>;
> >>>>                   no-map;
> >>>>           };
> >>>> };
> >>>> Versal NET> sf read 0x70000000 0x0 0x40
> >>>> device 0 offset 0x0, size 0x40
> >>>> ERROR: trying to overwrite reserved memory...
> >>>>
> >>>> Versal NET> sf write 0x70000000 0x0 0x40
> >>>> device 0 offset 0x0, size 0x40
> >>>> ERROR: trying to overwrite reserved memory...
> >>>>
> >>>> relocaddr   = 0x000000007febc000
> >>>>
> >>>> Versal NET> sf read 0x000000007febc000 0x0 0x40
> >>>> device 0 offset 0x0, size 0x40
> >>>> ERROR: trying to overwrite reserved memory...
> >>>>
> >>>> Versal NET> sf write 0x000000007febc000 0x0 0x40
> >>>> device 0 offset 0x0, size 0x40
> >>>> ERROR: trying to overwrite reserved memory...
> >>>>
> >>>>    cmd/sf.c | 36 +++++++++++++++++++++++++++++++++++-
> >>>>    1 file changed, 35 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/cmd/sf.c b/cmd/sf.c
> >>>> index f43a2e08b3..7bb8bcfce2 100644
> >>>> --- a/cmd/sf.c
> >>>> +++ b/cmd/sf.c
> >>>> @@ -10,6 +10,7 @@
> >>>>    #include <div64.h>
> >>>>    #include <dm.h>
> >>>>    #include <log.h>
> >>>> +#include <lmb.h>
> >>>>    #include <malloc.h>
> >>>>    #include <mapmem.h>
> >>>>    #include <spi.h>
> >>>> @@ -272,6 +273,31 @@ static int spi_flash_update(struct spi_flash *flash, u32 offset,
> >>>>           return 0;
> >>>>    }
> >>>>
> >>>> +#ifdef CONFIG_LMB
> >>>> +static int do_spi_read_lmb_check(ulong start_addr, loff_t len)
> >>>> +{
> >>>> +       phys_size_t max_size;
> >>>> +       ulong end_addr;
> >>>> +
> >>>> +       lmb_dump_all();
> >>>> +
> >>>> +       max_size = lmb_get_free_size(start_addr);
> >>>> +       if (!max_size) {
> >>>> +               return CMD_RET_FAILURE;
> >>>> +       }
> >>>> +
> >>>> +       end_addr = start_addr + max_size;
> >>>> +       if (!end_addr)
> >>>> +               end_addr = ULONG_MAX;
> >>>> +
> >>>> +       if ((start_addr + len) > end_addr) {
> >>>> +               return CMD_RET_FAILURE;
> >>>> +       }
> >>>
> >>> This is one way to get the load address, yes. But please do note that
> >>> with this method, if the region of memory has already been marked as
> >>> reserved, the call to lmb_get_free_size() will fail, i.e. return a
> >>> value of 0. Whereas if you call lmb_alloc_addr(), and if the memory
> >>> region is marked reserved with the flags set to LMB_NONE, that call
> >>> will not fail, as we can re-reserve memory marked as LMB_NONE. Hence a
> >>> better approach would be to use the logic used in the fs module
> >>> function that I had pointed to in my earlier email.
> >>>
> >>> Also, like I mentioned earlier, it will be better to refactor the
> >>> functionality, especially if the plan is to introduce this check for
> >>> loading stuff through other interfaces like nand, mmc etc. You can add
> >>> a function in the lmb.c like lmb_read_check() which does that.
> >>
> >> Is this something what you are going to work on?
> >
> > Can that not be done as part of this work? It is about having a single
> > function in the lmb.c file, which simply does a check for
> > lmb_alloc_addr(). It's not very complicated tbh.
>
> It is more about time spent on it. If you know how exactly it should look like
> it would be easier for you to put it together and Prasad can validate it on our
> platforms.

Prasad, Can you try this change? If this works, you can use this. I
will work on using this in other functions later.

diff --git a/cmd/sf.c b/cmd/sf.c
index 7bb8bcfce2..33d88a3531 100644
--- a/cmd/sf.c
+++ b/cmd/sf.c
@@ -343,13 +343,12 @@ static int do_spi_flash_read_write(int argc,
char *const argv[])
                        strncmp(argv[0], "write", 5) == 0) {
                int read, ret;

-#ifdef CONFIG_LMB
-               ret = do_spi_read_lmb_check(addr, len);
-               if (ret) {
-                       printf("ERROR: trying to overwrite reserved
memory...\n");
-                       return ret;
+               if (CONFIG_IS_ENABLED(LMB)) {
+                       if (lmb_read_check(addr, len)) {
+                               printf("ERROR: trying to overwrite
reserved memory...\n");
+                               return CMD_RET_FAILURE;
+                       }
                }
-#endif

                read = strncmp(argv[0], "read", 4) == 0;
                if (read)
diff --git a/include/lmb.h b/include/lmb.h
index 6ef03f9b63..601055a837 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -122,6 +122,11 @@ struct lmb *lmb_get(void);
 int lmb_push(struct lmb *store);
 void lmb_pop(struct lmb *store);

+static inline int lmb_read_check(phys_addr_t addr, phys_size_t len)
+{
+       return lmb_alloc_addr(addr, len) == addr ? 0 : -1;
+}
+
 #endif /* __KERNEL__ */

 #endif /* _LINUX_LMB_H */

-sughosh
