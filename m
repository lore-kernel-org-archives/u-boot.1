Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F828CA0FF6
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 00:09:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AE078657B;
	Sat,  2 Sep 2023 02:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H40tmXBd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D78AF867B5; Sat,  2 Sep 2023 02:09:37 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3410A86453
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 02:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-52a49a42353so3318621a12.2
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 17:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693613374; x=1694218174; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a3BVgyYP09N+5k5CKIyBrQ8tX6ushJq2viSgpY8P66Y=;
 b=H40tmXBdIQtaqvZ8kCjy0mQNElfhSCa1pq6Ny8PWg4Fabf3nYskUWhEWJ2eY+mUek7
 N1bSpQx37ATmBSz7sbOfwFKoAufqmXWwGDJmn8EGy0ZA/eIrw40c97VwLoIQV9STBPHD
 ZOqawa91rCWvf2lVKfZpEQD0Brck9Camhtnqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693613374; x=1694218174;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a3BVgyYP09N+5k5CKIyBrQ8tX6ushJq2viSgpY8P66Y=;
 b=b1oVQ1D0mXhy4i5uMKBw2HHwRlhIWxBe7jHTKM2PBzXxMIckgpsC9oJ5UlNNGTACl0
 Zp3xIZU8g6OWdj6axUpmSM3gtdKdvY7hXfNVjx3CJ5BmgUG5nl3JWxu+YM0Q/zVlrOBz
 +o2kMqg9Gf0cDUq8fA9eeDoR6kMTNcETmUKyUbV5k9yfeQDZrP5ozcyAqWgmMOl25+p+
 BrSoXvpaPudutv+XCuQv8Ch06p0aezdh55OQgoLNeyW/pYM7MEE5dDVdHW7zXkmM83eS
 9DTfi3L0wCfjtimYFIVicUD6vLTU8+P5/Y1zfqTPLWO4XyJVGzAo/OvqJs+IY6zddnhj
 JK3g==
X-Gm-Message-State: AOJu0YwDeQyhznLYHBVsMZ3WT+55MC99pxyjmQDZLwCOoKsBGqd6dpiX
 C6E7kddJBQDb3iAHsEnpt4Z0fmEVSfJxUQHjjSpTazU+ttxW6ytvJ8o=
X-Google-Smtp-Source: AGHT+IHbVuQ8if4y5Z7AHiEaTARuXBVweFJzaA3CkM7O5fczIOayEzhfry1TMrSGGE23AcqPtjK6DdQHADs24zZNmVg=
X-Received: by 2002:a05:6402:553:b0:52a:1d54:2533 with SMTP id
 i19-20020a056402055300b0052a1d542533mr3376698edx.9.1693613374524; Fri, 01 Sep
 2023 17:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230901102542.609239-1-masahisa.kojima@linaro.org>
 <20230901102542.609239-2-masahisa.kojima@linaro.org>
In-Reply-To: <20230901102542.609239-2-masahisa.kojima@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 1 Sep 2023 18:09:16 -0600
Message-ID: <CAPnjgZ22G-F1_VfFPge6hDOQC9eOgRdZ2U-NftrYx=XsJ-opsA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] net: wget: prevent overwriting reserved memory
To: Masahisa Kojima <masahisa.kojima@linaro.org>
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

Hi Masahisa,

On Fri, 1 Sept 2023 at 04:26, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> This introduces the valid range check to store the received
> blocks using lmb. The same logic is implemented in tftp.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  net/wget.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 69 insertions(+), 7 deletions(-)
>
> diff --git a/net/wget.c b/net/wget.c
> index 2dbfeb1a1d..8bf4db4d04 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -4,16 +4,20 @@
>   * Copyright Duncan Hare <dh@synoia.com> 2017
>   */
>
> +#include <asm/global_data.h>
>  #include <command.h>
>  #include <common.h>
>  #include <display_options.h>
>  #include <env.h>
>  #include <image.h>
> +#include <lmb.h>
>  #include <mapmem.h>
>  #include <net.h>
>  #include <net/tcp.h>
>  #include <net/wget.h>
>
> +DECLARE_GLOBAL_DATA_PTR;
> +
>  static const char bootfile1[] = "GET ";
>  static const char bootfile3[] = " HTTP/1.0\r\n\r\n";
>  static const char http_eom[] = "\r\n\r\n";
> @@ -55,6 +59,32 @@ static unsigned int retry_tcp_ack_num;       /* TCP retry acknowledge number*/
>  static unsigned int retry_tcp_seq_num; /* TCP retry sequence number */
>  static int retry_len;                  /* TCP retry length */
>
> +#ifdef CONFIG_LMB
> +static ulong wget_load_size;
> +#endif
> +
> +/**
> + * wget_init_max_size() - initialize maximum load size
> + *
> + * Return:     0 if success, -1 if fails
> + */
> +static int wget_init_load_size(void)
> +{
> +#ifdef CONFIG_LMB

please can you use if IS_ENABLED() throughout?

> +       struct lmb lmb;
> +       phys_size_t max_size;
> +
> +       lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
> +
> +       max_size = lmb_get_free_size(&lmb, image_load_addr);
> +       if (!max_size)
> +               return -1;
> +
> +       wget_load_size = max_size;
> +#endif
> +       return 0;
> +}
> +
>  /**
>   * store_block() - store block in memory
>   * @src: source of data
> @@ -63,10 +93,24 @@ static int retry_len;                       /* TCP retry length */
>   */
>  static inline int store_block(uchar *src, unsigned int offset, unsigned int len)
>  {
> +       ulong store_addr = image_load_addr + offset;
>         ulong newsize = offset + len;
>         uchar *ptr;
>
> -       ptr = map_sysmem(image_load_addr + offset, len);
> +#ifdef CONFIG_LMB
> +       ulong end_addr = image_load_addr + wget_load_size;
> +
> +       if (!end_addr)
> +               end_addr = ULONG_MAX;
> +
> +       if (store_addr < image_load_addr ||
> +               store_addr + len > end_addr) {
> +               puts("\nwget error: ");
> +               puts("trying to overwrite reserved memory...\n");
> +               return -1;
> +       }
> +#endif
> +       ptr = map_sysmem(store_addr, len);
>         memcpy(ptr, src, len);
>         unmap_sysmem(ptr);
>
> @@ -240,25 +284,37 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
>
>                         net_boot_file_size = 0;
>
> -                       if (len > hlen)
> -                               store_block(pkt + hlen, 0, len - hlen);
> +                       if (len > hlen) {
> +                               if (store_block(pkt + hlen, 0, len - hlen) != 0) {
> +                                       wget_loop_state = NETLOOP_FAIL;
> +                                       wget_fail("wget: store error\n", tcp_seq_num, tcp_ack_num, action);
> +                                       return;
> +                               }
> +                       }
>
>                         debug_cond(DEBUG_WGET,
>                                    "wget: Connected Pkt %p hlen %x\n",
>                                    pkt, hlen);
>
>                         for (i = 0; i < pkt_q_idx; i++) {
> +                               int err;
> +
>                                 ptr1 = map_sysmem(
>                                         (phys_addr_t)(pkt_q[i].pkt),
>                                         pkt_q[i].len);
> -                               store_block(ptr1,
> -                                           pkt_q[i].tcp_seq_num -
> -                                           initial_data_seq_num,
> -                                           pkt_q[i].len);
> +                               err = store_block(ptr1,
> +                                                 pkt_q[i].tcp_seq_num -
> +                                                 initial_data_seq_num,
> +                                                 pkt_q[i].len);
>                                 unmap_sysmem(ptr1);
>                                 debug_cond(DEBUG_WGET,
>                                            "wget: Connctd pkt Q %p len %x\n",
>                                            pkt_q[i].pkt, pkt_q[i].len);
> +                               if (err) {
> +                                       wget_loop_state = NETLOOP_FAIL;
> +                                       wget_fail("wget: store error\n", tcp_seq_num, tcp_ack_num, action);
> +                                       return;
> +                               }
>                         }
>                 }
>         }
> @@ -420,6 +476,12 @@ void wget_start(void)
>         debug_cond(DEBUG_WGET,
>                    "\nwget:Load address: 0x%lx\nLoading: *\b", image_load_addr);
>
> +       if (wget_init_load_size()) {
> +               puts("\nwget error: ");
> +               puts("trying to overwrite reserved memory...\n");

I think it is OK to use printf() here.

> +               return;

Needs to return the error code

> +       }
> +
>         net_set_timeout_handler(wget_timeout, wget_timeout_handler);
>         tcp_set_tcp_handler(wget_handler);
>
> --
> 2.34.1
>

Regards,
Simon
