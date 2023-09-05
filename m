Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46590C83F33
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 07:13:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E23C86637;
	Tue,  5 Sep 2023 09:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Jux6s3fA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CFE086879; Tue,  5 Sep 2023 09:13:26 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 807C0864DD
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 09:13:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6bd8639e7e5so1652407a34.1
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 00:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693898002; x=1694502802; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vtBzyDnTBXGXVlzn09aq746Yl4tDGmEa9Iuxe/r/M08=;
 b=Jux6s3fA74fW+kRwxyK6neXTc/aDhp21W5FcdbDerBUaxcLP8mbivSKYyoNjGGN2bH
 h1Ii+FzrbJt+7AgLLhFD5vvwfA3mmpaVhP+au13BiuSZ/9XpGZQ/INt0JeDHe7d3ZmcF
 SDMfNzwNwkgaZ5IIXySRLs+9GqsK4DnGyuhfld2xMU5XXHnLJdeGIvE9/z2rpXg1wXYU
 Gn97p0w+/9D/MJ78E5D7dKHxHrI3yKWcZ+tx707YSBSIr6C/nASNnDRMZGpzZFAhL6Lw
 85F9/evB3mgJX/R62i42FSyDJvHEw2ZFr4n0rH/BzS5rNxbZH1fUlA6hEHH17/oUG+YM
 2uAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693898002; x=1694502802;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vtBzyDnTBXGXVlzn09aq746Yl4tDGmEa9Iuxe/r/M08=;
 b=RNXodle+W0Cu+240dlX0H07nqYL1VPx/cI9QfbAhraHyV7bpIPV8vV0Esscz7m/4GG
 pNtuEovvsqn4aAwF+HtpH9S+kvUW9D6/kdHtUiD4udvM9YmDjG1FEtYouaUbsQ7SJHT4
 cdih1obPS2qa9f2FEhi5gW7PZ1mlbuNOeaFTVjEhovMMT+dL6G4IZTRnS+gTIOQo7+4e
 WfZ+CKLYRBcU7Y3xBnlRwXAcP6MXee4B3tRsGIhkmsVshrjkbQ64/Z9BGW0rNDvECoV7
 hDbv8DyXk5oMzbxUaqebyIm/A+BW2RYNTOQuwH8NfV1ILPtl+Fyeakyt8bNqgVV6b7Ck
 cidQ==
X-Gm-Message-State: AOJu0YyTEBweTHT6eHjxR4dPgj0eOYIABJJuxdBTJcH33hbuUR1c1lcE
 5k2ugG45lXyddT+LhfPyUtS5osFIrOjKn7QiQrSbVQ==
X-Google-Smtp-Source: AGHT+IGV+pv/Gs70R7Hw5tjs0rkF81/3qvnZ7xLWbLhR+yFSNG98fZ5KMsCxe3+3Ut6jdoIX4pUc0y7Frswn96qVZcI=
X-Received: by 2002:a05:6358:9184:b0:133:e286:9259 with SMTP id
 j4-20020a056358918400b00133e2869259mr12784271rwa.17.1693898002014; Tue, 05
 Sep 2023 00:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230901102542.609239-1-masahisa.kojima@linaro.org>
 <20230901102542.609239-2-masahisa.kojima@linaro.org>
 <CAPnjgZ22G-F1_VfFPge6hDOQC9eOgRdZ2U-NftrYx=XsJ-opsA@mail.gmail.com>
In-Reply-To: <CAPnjgZ22G-F1_VfFPge6hDOQC9eOgRdZ2U-NftrYx=XsJ-opsA@mail.gmail.com>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Tue, 5 Sep 2023 16:13:10 +0900
Message-ID: <CADQ0-X-aoFupCo2LOhsSSz6zcfcx3EUSXkmxEbWj9aX5Jt_q0w@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] net: wget: prevent overwriting reserved memory
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
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

Hi Simon,

On Sat, 2 Sept 2023 at 09:09, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Masahisa,
>
> On Fri, 1 Sept 2023 at 04:26, Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:
> >
> > This introduces the valid range check to store the received
> > blocks using lmb. The same logic is implemented in tftp.
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >  net/wget.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 69 insertions(+), 7 deletions(-)
> >
> > diff --git a/net/wget.c b/net/wget.c
> > index 2dbfeb1a1d..8bf4db4d04 100644
> > --- a/net/wget.c
> > +++ b/net/wget.c
> > @@ -4,16 +4,20 @@
> >   * Copyright Duncan Hare <dh@synoia.com> 2017
> >   */
> >
> > +#include <asm/global_data.h>
> >  #include <command.h>
> >  #include <common.h>
> >  #include <display_options.h>
> >  #include <env.h>
> >  #include <image.h>
> > +#include <lmb.h>
> >  #include <mapmem.h>
> >  #include <net.h>
> >  #include <net/tcp.h>
> >  #include <net/wget.h>
> >
> > +DECLARE_GLOBAL_DATA_PTR;
> > +
> >  static const char bootfile1[] = "GET ";
> >  static const char bootfile3[] = " HTTP/1.0\r\n\r\n";
> >  static const char http_eom[] = "\r\n\r\n";
> > @@ -55,6 +59,32 @@ static unsigned int retry_tcp_ack_num;       /* TCP retry acknowledge number*/
> >  static unsigned int retry_tcp_seq_num; /* TCP retry sequence number */
> >  static int retry_len;                  /* TCP retry length */
> >
> > +#ifdef CONFIG_LMB
> > +static ulong wget_load_size;
> > +#endif
> > +
> > +/**
> > + * wget_init_max_size() - initialize maximum load size
> > + *
> > + * Return:     0 if success, -1 if fails
> > + */
> > +static int wget_init_load_size(void)
> > +{
> > +#ifdef CONFIG_LMB
>
> please can you use if IS_ENABLED() throughout?
OK.

>
> > +       struct lmb lmb;
> > +       phys_size_t max_size;
> > +
> > +       lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
> > +
> > +       max_size = lmb_get_free_size(&lmb, image_load_addr);
> > +       if (!max_size)
> > +               return -1;
> > +
> > +       wget_load_size = max_size;
> > +#endif
> > +       return 0;
> > +}
> > +
> >  /**
> >   * store_block() - store block in memory
> >   * @src: source of data
> > @@ -63,10 +93,24 @@ static int retry_len;                       /* TCP retry length */
> >   */
> >  static inline int store_block(uchar *src, unsigned int offset, unsigned int len)
> >  {
> > +       ulong store_addr = image_load_addr + offset;
> >         ulong newsize = offset + len;
> >         uchar *ptr;
> >
> > -       ptr = map_sysmem(image_load_addr + offset, len);
> > +#ifdef CONFIG_LMB
> > +       ulong end_addr = image_load_addr + wget_load_size;
> > +
> > +       if (!end_addr)
> > +               end_addr = ULONG_MAX;
> > +
> > +       if (store_addr < image_load_addr ||
> > +               store_addr + len > end_addr) {
> > +               puts("\nwget error: ");
> > +               puts("trying to overwrite reserved memory...\n");
> > +               return -1;
> > +       }
> > +#endif
> > +       ptr = map_sysmem(store_addr, len);
> >         memcpy(ptr, src, len);
> >         unmap_sysmem(ptr);
> >
> > @@ -240,25 +284,37 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
> >
> >                         net_boot_file_size = 0;
> >
> > -                       if (len > hlen)
> > -                               store_block(pkt + hlen, 0, len - hlen);
> > +                       if (len > hlen) {
> > +                               if (store_block(pkt + hlen, 0, len - hlen) != 0) {
> > +                                       wget_loop_state = NETLOOP_FAIL;
> > +                                       wget_fail("wget: store error\n", tcp_seq_num, tcp_ack_num, action);
> > +                                       return;
> > +                               }
> > +                       }
> >
> >                         debug_cond(DEBUG_WGET,
> >                                    "wget: Connected Pkt %p hlen %x\n",
> >                                    pkt, hlen);
> >
> >                         for (i = 0; i < pkt_q_idx; i++) {
> > +                               int err;
> > +
> >                                 ptr1 = map_sysmem(
> >                                         (phys_addr_t)(pkt_q[i].pkt),
> >                                         pkt_q[i].len);
> > -                               store_block(ptr1,
> > -                                           pkt_q[i].tcp_seq_num -
> > -                                           initial_data_seq_num,
> > -                                           pkt_q[i].len);
> > +                               err = store_block(ptr1,
> > +                                                 pkt_q[i].tcp_seq_num -
> > +                                                 initial_data_seq_num,
> > +                                                 pkt_q[i].len);
> >                                 unmap_sysmem(ptr1);
> >                                 debug_cond(DEBUG_WGET,
> >                                            "wget: Connctd pkt Q %p len %x\n",
> >                                            pkt_q[i].pkt, pkt_q[i].len);
> > +                               if (err) {
> > +                                       wget_loop_state = NETLOOP_FAIL;
> > +                                       wget_fail("wget: store error\n", tcp_seq_num, tcp_ack_num, action);
> > +                                       return;
> > +                               }
> >                         }
> >                 }
> >         }
> > @@ -420,6 +476,12 @@ void wget_start(void)
> >         debug_cond(DEBUG_WGET,
> >                    "\nwget:Load address: 0x%lx\nLoading: *\b", image_load_addr);
> >
> > +       if (wget_init_load_size()) {
> > +               puts("\nwget error: ");
> > +               puts("trying to overwrite reserved memory...\n");
>
> I think it is OK to use printf() here.
OK.

>
> > +               return;
>
> Needs to return the error code

I will modify it to notify the caller of the  error by calling
"net_set_state(NETLOOP_FAIL);"
instead of returning the error code.

Thanks,
Masahisa Kojima

>
> > +       }
> > +
> >         net_set_timeout_handler(wget_timeout, wget_timeout_handler);
> >         tcp_set_tcp_handler(wget_handler);
> >
> > --
> > 2.34.1
> >
>
> Regards,
> Simon
