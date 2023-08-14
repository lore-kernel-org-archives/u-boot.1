Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60448EB64DD
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 18:54:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D21A5868D0;
	Mon, 14 Aug 2023 20:54:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ew04tS/v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 573EE80842; Mon, 14 Aug 2023 20:54:50 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41451868D0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 20:54:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-99bccc9ec02so655841766b.2
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 11:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692039288; x=1692644088;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u8zSgfxd6pUfOTBihdYLg0vXr/UbG14eAOF1VZ7bmPs=;
 b=Ew04tS/vmh+HwCLVbbSWnT4rLNAePRAJfuPIlOYUETDRupzlJvqbqmz1ySikM/K16b
 9t9hJdMOLWKK4hqiTzcRHqkkVWYLd1sPf83Fl3BOWkZVzKu/0qSIQq3tcKrb1F/iTKsd
 j2bWrvfCmtfIZgRPQDiovJSLe0o9PRsg3nLW0doJGmov1fHclkNmu278s2+3Z0XcHDxO
 okOiE6e0vYSb0duY2ZsU0xm/5CBUUhIAAZAbfzMKXt7sixn/SVpzFIQWSyhWhCcrIqnv
 QVzJCG8hxDC/1d+WFmuavbE8CZMuzN+ng+e2BsfuQKGW1cBtudNnMSyYob+AMSf8tNv5
 JhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692039288; x=1692644088;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u8zSgfxd6pUfOTBihdYLg0vXr/UbG14eAOF1VZ7bmPs=;
 b=EJlyzbEVvzCpKJF/dWekcN6YMPa/cYe03BlCNJXZqlUVnusUzumneOMjYsiK1SEYsI
 pklBn/B4nXGmzX1tfUB/jsu878rqFyKNoVX9L+gdxZAg45ptR0lXZdx+slf9R3Pa1E7r
 KI71qFsnsUEHQV/x/rHihF/W6l9kCdANOjiKkBAE5nhAhh8zy3xi3RtfUe4hfLQyMyKg
 Xy9mF+/fHJTA0Cl6QzrAc3q+v5lZJTEH2ycPFAiOfMu5mXXw2KPjnDik9HGl+W6vSLok
 mJmMDCObFwLp70exAMzPfJQrqoNK5uZYDtubcPVHmszUxiv+ZwBz50JaE/R7rYnaiLNg
 8X2Q==
X-Gm-Message-State: AOJu0Yxba4MhMO6DxxsMOGS72B6FjIVdXBde9LYaYOjS+1+WtKlrMm76
 fpSZ8CWD4Sx/dRvjVq/jSJf2Jy2R3BR89b0UTlCmOlqXuwIxwSSV
X-Google-Smtp-Source: AGHT+IHG/Vb4+jppU4e7VC+DgC2pswfYYOwp80z2EqVUbTbiwPzbp4KwvwU7zjW0gIfWqegA7Iej4AreVHMtru3bn9o=
X-Received: by 2002:a17:906:256:b0:99c:6c29:7871 with SMTP id
 22-20020a170906025600b0099c6c297871mr7563341ejl.65.1692039287762; Mon, 14 Aug
 2023 11:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230814133253.4150-1-maxim.uvarov@linaro.org>
 <20230814133253.4150-6-maxim.uvarov@linaro.org> <ZNo5Vlg8pgvnW8hw@hades>
In-Reply-To: <ZNo5Vlg8pgvnW8hw@hades>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Tue, 15 Aug 2023 00:54:34 +0600
Message-ID: <CAD8XO3Z71w-4rwkGj2Or5nS+HuGm18ZsbBLLxP=HsZ0kGmjGkQ@mail.gmail.com>
Subject: Re: [PATCHv6 05/14] net/lwip: implement tftp cmd
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@redhat.com, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de, 
 lwip-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Mon, 14 Aug 2023 at 20:25, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
> > + */
> > +
> > +#include <common.h>
> > +#include <command.h>
> > +#include <console.h>
> > +#include <bootstage.h>
> > +
> > +#include "lwip/apps/tftp_client.h"
> > +#include "lwip/apps/tftp_server.h"
> > +#include <tftp_example.h>
> > +
> > +#include <string.h>
> > +
> > +#include <net/ulwip.h>
> > +
> > +#if LWIP_UDP
>
> Why do we have this?  I dont think it makes sense to start reasoning about
> LWIP config options from within U-Boot code.  Instead U-Boot makefiles
> should enable all the LWIP features we need when a command is included
>
>
That is how example used it. Agree do drop this if.


> > +
> > +static ulong daddr;
> > +static ulong size;
> > +
> > +static void *tftp_open(const char *fname, const char *mode, u8_t
> is_write)
> > +{
> > +     LWIP_UNUSED_ARG(mode);
> > +     return NULL;
> > +}
> > +
> > +static void tftp_close(void *handle)
> > +{
> > +     log_info("\ndone\n");
> > +     log_info("Bytes transferred = %ld (0x%lx hex)\n", size, size);
> > +
> > +     bootstage_mark_name(BOOTSTAGE_KERNELREAD_STOP, "tftp_done");
> > +     env_set_ulong("filesize", size);
> > +     ulwip_exit(0);
> > +}
> > +
> > +static int tftp_read(void *handle, void *buf, int bytes)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int tftp_write(void *handle, struct pbuf *p)
> > +{
> > +     struct pbuf *q;
> > +
> > +     for (q = p; q != NULL; q = q->next) {
> > +             memcpy((void *)daddr, q->payload, q->len);
> > +             daddr += q->len;
> > +             size += q->len;
> > +             log_info("#");
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void tftp_error(void *handle, int err, const char *msg, int size)
> > +{
> > +     char message[100];
> > +
> > +     LWIP_UNUSED_ARG(handle);
> > +
> > +     memset(message, 0, sizeof(message));
> > +     MEMCPY(message, msg, LWIP_MIN(sizeof(message)-1, (size_t)size));
> > +
> > +     log_info("TFTP error: %d (%s)", err, message);
> > +}
> > +
> > +static const struct tftp_context tftp = {
> > +     tftp_open,
> > +     tftp_close,
> > +     tftp_read,
> > +     tftp_write,
> > +     tftp_error
> > +};
> > +
> > +int ulwip_tftp(ulong addr, char *fname)
> > +{
> > +     void *f = (void *)0x1; /* unused fake file handle*/
> > +     err_t err;
> > +     ip_addr_t srv;
> > +     int ret;
> > +     char *server_ip;
> > +
> > +     if (!fname || addr == 0)
> > +             return CMD_RET_FAILURE;
> > +
> > +     size = 0;
> > +     daddr = addr;
> > +     server_ip = env_get("serverip");
> > +     if (!server_ip) {
> > +             log_err("error: serverip variable has to be set\n");
> > +             return CMD_RET_FAILURE;
> > +     }
> > +
> > +     ret = ipaddr_aton(server_ip, &srv);
> > +     if (!ret) {
> > +             log_err("error: ipaddr_aton\n");
> > +             return CMD_RET_FAILURE;
> > +     }
> > +
> > +     log_info("TFTP from server %s; our IP address is %s\n",
> > +              server_ip, env_get("ipaddr"));
> > +     log_info("Filename '%s'.\n", fname);
> > +     log_info("Load address: 0x%lx\n", daddr);
> > +     log_info("Loading:");
> > +
> > +     bootstage_mark_name(BOOTSTAGE_KERNELREAD_START, "tftp_start");
> > +
> > +     err = tftp_init_client(&tftp);
> > +     if (!(err == ERR_OK || err == ERR_USE))
> > +             log_err("tftp_init_client err: %d\n", err);
> > +
> > +     err = tftp_get(f, &srv, TFTP_PORT, fname, TFTP_MODE_OCTET);
>
> Shouldn't this be part of tftp_read()?
>
>
tft_get() actually does some initialization. Then when the polling loop
works tftp_write() or tftp_read() callbacks will be called.
So here it should stay as is.


> > +     /* might return different errors, like routing problems */
> > +     if (err != ERR_OK) {
> > +             log_err("tftp_get err=%d\n", err);
> > +             return CMD_RET_FAILURE;
> > +     }
> > +
> > +     env_set_hex("fileaddr", addr);
> > +     return err;
> > +}
> > +#else
> > +#error "UDP has to be supported"
> > +#endif /* LWIP_UDP */
> > --
> > 2.30.2
> >
>
