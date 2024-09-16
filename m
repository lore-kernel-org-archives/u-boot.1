Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1A9C3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 14:36:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAF7C88EAA;
	Mon, 16 Sep 2024 16:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WcJ3PjxT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C89E88E42; Mon, 16 Sep 2024 16:36:39 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EE0B88E7A
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 16:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a8d3e662791so254124866b.1
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 07:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726497395; x=1727102195; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UbBsm8BTqaK3sAg0JQdzA1H4yxAy3cI/iNHM7HrULPM=;
 b=WcJ3PjxTuJznFGum+q66HbUTrUzqWw5w1zwGmFUmzWgDO+gJTN2OQZ57TY/lusl7TP
 867HLxVYIJ1RQ6pWbGd1PFk7IPm06tccaE3+PLQbsg/kxCtLPvMZHCchTC6K7h4sT1L6
 z2tH9sLKtZ2QrNvVyJIswhwfaRP1cX26XZMZVqkpWpyGXeovyR6pspjyJOI6Wh1hqSZ+
 kP4ZaDH5sBsP0UKSZld3l5mF5HRqYFxyp81v9q8FN7DYWnaTegjsLUFs53k9KQmiSYIH
 kue9lDT2zL4EtVCXmC/1ZlMQbQTaULvvjhV73kg0Vb53LTf61g0QKTqyeavDrHEpj5wZ
 GKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726497395; x=1727102195;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UbBsm8BTqaK3sAg0JQdzA1H4yxAy3cI/iNHM7HrULPM=;
 b=jy2W3+3paZBTeJNViafq+2PbrUeK3VAD4GWUZJVTwySOQG0n0lcYkQN/EpIa490/FP
 Qmfk1LNym0CTzDwBmJ1PsP1gFSKx1uYkpXs47nNllyxhJlChXN8ttsfsPU2Ou2LJJNlC
 ioerMiI5pVIW0+8yIcCcfIThTnFE+rCMtqMpRWdS+usJ019l6j2eWZu1+x1LcCfF4Rv6
 LWvQU/8NoWHYVp/fM0gT5RIUZ4ieF7NpJ6MpJkWm92COp+WdRS4eRyhMvO6td+WV3FMR
 hy/LemxY521fzObtaZLoNINSOoEf932J6mn487rWSO7BmzlpURce/oC1O0x+Le3kSPH1
 p0xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7MqnPAlMOJmRvDpNuA1gKpC3XRo64lbhtKOzvCT0WLVAmRTu/C9mTeDi7nCs+Mw+eKidx1JE=@lists.denx.de
X-Gm-Message-State: AOJu0YyI4+tjWAVqm9RHp6G5v4vj6mvisuqoGB5uWFrj3fcjOzyfyU81
 d+F8sYuBkwjcJKazrWN9EJ0qKe2/6vCunwpGDXHmqvVY6Q1WhzY0thcZQ5OxXfoS83LhKt/p6Xm
 011rl/sxVJSLtWSrJ+TJsAG/rY3oirP6CkyUnTQ==
X-Google-Smtp-Source: AGHT+IGNL8HbQMR4CIQujUYddp1TeYScdMUjgBAsWKSlVuhJg7Tzf2QVkI+PvPZ/bKsG+f6vQPrGd67t/KNFa2EARHY=
X-Received: by 2002:a05:6402:27cc:b0:5be:cdda:1c6b with SMTP id
 4fb4d7f45d1cf-5c41e2af3a8mr18537807a12.31.1726497394659; Mon, 16 Sep 2024
 07:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240913073251.2286529-2-prasad.kummari@amd.com>
 <c9e22782-8645-420c-9017-18f3aafcbb12@ti.com>
 <CADg8p95RA_iOUYmjLaED52C7ebGPuor=Zd+16zmVvDiEV3aesw@mail.gmail.com>
 <acca0730-1bb5-4ea5-9666-9271110ddb43@ti.com>
 <CADg8p94qiashAzNvLJHxgf-msMDNhOiSPyVA_JOAtesO96sYdA@mail.gmail.com>
 <7b55c50d-49d1-493f-8ab2-a554f99e265c@ti.com>
 <CADg8p94bEoyr1wOLa4onQBEd-wTGNqFcgR8XD1vGQHf3HNYrGg@mail.gmail.com>
 <24a01e64-a6ef-49eb-8e10-d28161002468@ti.com>
In-Reply-To: <24a01e64-a6ef-49eb-8e10-d28161002468@ti.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 16 Sep 2024 20:06:23 +0530
Message-ID: <CADg8p95w+BozMj_JSuGh4S4TrB0rSBU=2FWO+SeFHfSgiBt8Zw@mail.gmail.com>
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

On Mon, 16 Sept 2024 at 19:47, Vaishnav Achath <vaishnav.a@ti.com> wrote:
>
> Hi Sughosh,
>
> On 16/09/24 16:40, Sughosh Ganu wrote:
> > On Mon, 16 Sept 2024 at 16:07, Vaishnav Achath <vaishnav.a@ti.com> wrote:
> >>
> >> Hi Sughosh,
> >>
> >> On 16/09/24 14:53, Sughosh Ganu wrote:
> >>> On Mon, 16 Sept 2024 at 14:22, Vaishnav Achath <vaishnav.a@ti.com> wrote:
> >>>>
> >>>> Hi Sughosh,
> >>>>
> >>>> On 16/09/24 12:13, Sughosh Ganu wrote:
> >>>>> On Mon, 16 Sept 2024 at 11:47, Vaishnav Achath <vaishnav.a@ti.com> wrote:
> >>>>>>
> >>>>>> Hi Prasad,
> >>>>>>
> >>>>>> On 13/09/24 13:02, Prasad Kummari wrote:
> >>>>>>> Added LMB API to prevent SF command from overwriting reserved
> >>>>>>> memory areas. The current SPI code does not use LMB APIs for
> >>>>>>> loading data into memory addresses. To resolve this, LMB APIs
> >>>>>>> were added to check the load address of an SF command and ensure it
> >>>>>>> does not overwrite reserved memory addresses. Similar checks are
> >>>>>>> used in TFTP, serial load, and boot code to prevent overwriting
> >>>>>>> reserved memory.
> >>>>>>>
> >>>>>>> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> >>>>>>> ---
> >>>>>>> Changes in V4:
> >>>>>>> - Removed do_spi_read_lmb_check().
> >>>>>>> - Added the lmb_read_check() function in lmb.c, making it reusable for
> >>>>>>>       NAND, MMC, etc.
> >>>>>>> - Addressed review comments.
> >>>>>>>
> >>>>>>> Changes in V3:
> >>>>>>> - Removed lmb_init_and_reserve() as part of latest LMB series.
> >>>>>>> - Error message moved to one place.
> >>>>>>> - lmb_alloc_addr() is not required because the given memory address is
> >>>>>>>       being checked to ensure it is free or not.
> >>>>>>>
> >>>>>>> Changes in V2:
> >>>>>>> - Rebased the code changes on top of the next branch.
> >>>>>>>
> >>>>>>> UT:
> >>>>>>> Tested on Versal NET board.
> >>>>>>>
> >>>>>>> relocaddr   = 0x000000007febc000
> >>>>>>>
> >>>>>>> Versal NET> sf read 0x000000007febc000 0x0 0x40
> >>>>>>> device 0 offset 0x0, size 0x40
> >>>>>>> ERROR: trying to overwrite reserved memory...
> >>>>>>> Versal NET> sf write 0x000000007febc000 0x0 0x40
> >>>>>>> device 0 offset 0x0, size 0x40
> >>>>>>> ERROR: trying to overwrite reserved memory...
> >>>>>>>
> >>>>>>> Versal NET> fdt print /reserved-memory
> >>>>>>> reserved-memory {
> >>>>>>>          ranges;
> >>>>>>>          #size-cells = <0x00000002>;
> >>>>>>>          #address-cells = <0x00000002>;
> >>>>>>>          tf-a {
> >>>>>>>                  reg = <0x00000000 0x70000000 0x00000000 0x00050000>;
> >>>>>>>                  no-map;
> >>>>>>>          };
> >>>>>>> };
> >>>>>>> Versal NET> sf read 0x70000000 0x0 0x40
> >>>>>>> device 0 offset 0x0, size 0x40
> >>>>>>> ERROR: trying to overwrite reserved memory...
> >>>>>>> Versal NET> sf write 0x70000000 0x0 0x40
> >>>>>>> device 0 offset 0x0, size 0x40
> >>>>>>> ERROR: trying to overwrite reserved memory...
> >>>>>>> Versal NET> sf erase 0x0 0x1000000;mw.b 0x8000 aabbccdd 0x1000000;sf
> >>>>>>> write 0x8000 0x0 0x1000000;mw.b 0x8008000 0x0 0x1000000;sf read
> >>>>>>> 0x8008000 0x0 0x1000000;cmp.b 0x8000 0x8008000 0x01000000
> >>>>>>> SF: 16777216 bytes @ 0x0 Erased: OK
> >>>>>>> device 0 offset 0x0, size 0x1000000
> >>>>>>> SF: 16777216 bytes @ 0x0 Written: OK
> >>>>>>> device 0 offset 0x0, size 0x1000000
> >>>>>>> SF: 16777216 bytes @ 0x0 Read: OK
> >>>>>>> Total of 16777216 byte(s) were the same
> >>>>>>>
> >>>>>>>      cmd/sf.c      | 8 ++++++++
> >>>>>>>      include/lmb.h | 5 +++++
> >>>>>>>      2 files changed, 13 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/cmd/sf.c b/cmd/sf.c
> >>>>>>> index f43a2e08b3..08e364e191 100644
> >>>>>>> --- a/cmd/sf.c
> >>>>>>> +++ b/cmd/sf.c
> >>>>>>> @@ -10,6 +10,7 @@
> >>>>>>>      #include <div64.h>
> >>>>>>>      #include <dm.h>
> >>>>>>>      #include <log.h>
> >>>>>>> +#include <lmb.h>
> >>>>>>>      #include <malloc.h>
> >>>>>>>      #include <mapmem.h>
> >>>>>>>      #include <spi.h>
> >>>>>>> @@ -317,6 +318,13 @@ static int do_spi_flash_read_write(int argc, char *const argv[])
> >>>>>>>                          strncmp(argv[0], "write", 5) == 0) {
> >>>>>>>                  int read;
> >>>>>>>
> >>>>>>> +             if (CONFIG_IS_ENABLED(LMB)) {
> >>>>>>> +                     if (lmb_read_check(addr, len)) {
> >>>>>>
> >>>>>> Even though the function is named lmb_read_check(), it performs an alloc
> >>>>>> which is never freed, thus it makes it difficult for other callers to
> >>>>>> use the same region for other purposes (some callers use
> >>>>>> lmb_get_free_size() ), as mentioned in the commit message the check is
> >>>>>> only to prevent sf from overwriting reserved region, but it looks like
> >>>>>> this patch makes the load region also as reserved, is this necessary?
> >>>>>
> >>>>> Like I mentioned in my other reply, using a check for lmb_alloc_addr()
> >>>>> allows for memory re-use, which is the behaviour that a large number
> >>>>> of use cases rely on -- if you go through the test scripts, it is
> >>>>> assumed that memory re-use is allowed. That there is no need to
> >>>>> explicitly free up memory, and that has been how the LMB memory has
> >>>>> been used historically. So it is allowed to use some address to load
> >>>>> an image to that address, and then use the same address to load a
> >>>>> different image. The LMB rework series does keep this behaviour
> >>>>> consistent. So it would be better to change the behaviour of the tftp
> >>>>> command to use the same API. I was planning on working on this
> >>>>> cleanup. If you want, you can take it up.
> >>>>>
> >>>>
> >>>> Please let me know if you are planning to work on this in the coming few
> >>>> days, otherwise I can pick it up as we have platforms failing due to this.
> >>>
> >>> I can take this up. Will keep you on Cc so that you can test the
> >>> patches on your boards.
> >>>
> >>
> >> Thanks, I will test and report the results once you post the patches.
> >
> > I have pushed a couple of patches to my github branch [1]. Can you
> > please try these on your platforms and check if this fixes the issues
> > that you see. I will also set up a board with network access on my end
> > and try it out. Thanks.
> >
> > -sughosh
> >
> > [1] - https://github.com/sughoshg/u-boot/tree/tftp_wget_lmb_changes
> >
>
> I tested with your patches on our failing platforms and it is working,
> Thanks, In the logs, initially a mmc load of remoteproc firmware happens
> and then Kernel/DTB load through TFTP which was failing, now it is fixed
> with your patches:

Thanks much for testing the patches! I have put the patches through
CI. Will post them on the list once the CI completes.

-sughosh

>
> https://gist.github.com/vachath/bb7c8c7b5a38a58298026b831db58424
>
> Thanks and Regards,
> Vaishnav
>
> >>
> >>>>
> >>>>>>
> >>>>>>
> >>>>>>> +                             printf("ERROR: trying to overwrite reserved memory...\n");
> >>>>>>> +                             return CMD_RET_FAILURE;
> >>>>>>> +                     }
> >>>>>>> +             }
> >>>>>>> +
> >>>>>>>                  read = strncmp(argv[0], "read", 4) == 0;
> >>>>>>>                  if (read)
> >>>>>>>                          ret = spi_flash_read(flash, offset, len, buf);
> >>>>>>> diff --git a/include/lmb.h b/include/lmb.h
> >>>>>>> index fc2daaa7bf..aee2f9fcda 100644
> >>>>>>> --- a/include/lmb.h
> >>>>>>> +++ b/include/lmb.h
> >>>>>>> @@ -111,6 +111,11 @@ struct lmb *lmb_get(void);
> >>>>>>>      int lmb_push(struct lmb *store);
> >>>>>>>      void lmb_pop(struct lmb *store);
> >>>>>>>
> >>>>>>> +static inline int lmb_read_check(phys_addr_t addr, phys_size_t len)
> >>>>>>> +{
> >>>>>>> +     return lmb_alloc_addr(addr, len) == addr ? 0 : -1;
> >>>>>>
> >>>>>> who frees this? can we free this right after checking?
> >>>>>
> >>>>> It is not required to explicitly free up this memory, as it is not an
> >>>>> actual allocation per-se. Why were these functions called alloc
> >>>>> something, I am not sure. But the point is, if you change the tftp
> >>>>> command code to use this API instead, and then use it after a previous
> >>>>> load, it would not fail.
> >>>>>
> >>>>> -sughosh
> >>>>>
> >>>>
> >>>> Agreed, but the commit message says to "ensure it does not overwrite
> >>>> reserved memory addresses" but the implementation marks the region as
> >>>> reserved in the global memory map and is visible in lmb_dump_all() ,
> >>>> which is not expected, is there really a need to mark the region as
> >>>> reserved.
> >>>
> >>> What can be overwritten, and what cannot be can now be determined from
> >>> the flags. If you check the LMB memory map from the bdinfo command,
> >>> you will see that the regions which cannot be overwritten are now
> >>> being marked with the "no-overwrite" flag. The other LMB memory which
> >>> can be re-used to load multiple different images is being marked with
> >>> the "none" flag. One issue with all this is that currently there is no
> >>> document which explains all these concepts. I will work on adding such
> >>> a document. Thanks.
> >>>
> >>
> >> Yes, documenting the behavior will clear the confusion.
> >>
> >> Thanks and Regards,
> >> Vaishnav
> >>
> >>> -sughosh
> >>>
> >>>>
> >>>> Thanks and Regards,
> >>>> Vaishnav
> >>>>
> >>>>>>
> >>>>>> Thanks and Regards,
> >>>>>> Vaishnav
> >>>>>>
> >>>>>>> +}
> >>>>>>> +
> >>>>>>>      #endif /* __KERNEL__ */
> >>>>>>>
> >>>>>>>      #endif /* _LINUX_LMB_H */
