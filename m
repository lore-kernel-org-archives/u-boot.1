Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52BCEDEC4D
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 13:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25EEE8645F;
	Wed, 13 Sep 2023 15:38:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZlcQ1UL2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA873864D7; Wed, 13 Sep 2023 15:38:21 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E24558640F
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 15:38:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9a65f9147ccso876532666b.1
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 06:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694612298; x=1695217098; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RUf5GyMt7NxQdxxwRE58EJkDK1gXnrKxp7IW41kGU1U=;
 b=ZlcQ1UL2bUz6IPeuKhryBFLjywV7LdosZDtKehhe0s8gULF+lq2K/Fc3FvsFH01ZJw
 upa5rc6nXqRG37CmqLZxLSdECUEYosXxwS0fpbJah+qEHW5k+rA5hHQ/IOGXHoobJDv/
 Lh6ThmdthLhuQJY5F8JUhWqneV2LFqFGHBB2UYGNduc4Nuh7jioy83NJSUCOwN6k/M2g
 UtAV6YogJ65WE70L5OaIDzhJmIYyD1+8Y620YfAxiPrxYQNWz9E2atBO4Gm2O6EMfYWo
 Lb0IWpwCTz40cTRcSxNnj3f8k7dv5eC1F9tK9ZrFxAsjedrBmX9M4nqPeMaq3lNOCUyo
 c2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694612298; x=1695217098;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RUf5GyMt7NxQdxxwRE58EJkDK1gXnrKxp7IW41kGU1U=;
 b=l/CYfc2PryG738eAEkojyyy46lOd+kUyiHVNuggdjOCDUq6FD1W+aC+0IrjXR9hjhx
 DvayVZJSx/v9TZU0l2j6s9aBcH+WMcdNpySSTEJObaUEOra1D4e1WcCfSJjO08SHSR9C
 pVk1vN7jZbPqoWJSNUSQvTr1JWvToYWuTLS9rI6eb2/yvJoa8OdM9yvUb1Hd7ksHViy0
 DQoLPY4oTbb4pzFBCLsVVsL4++JoexP0I50nCRs340PTEMDPGJ+8atqW4Leo+9s/Vv2m
 ZhM91KKh9MuAIzxU/vlW2cw3GeYXCVOGxkjKeODLJnP9TZD/P3UwHgGQORCX2ZcEp3aN
 qbEw==
X-Gm-Message-State: AOJu0YwoIxwY4CbKjotjOvJow2XM7hOXk/sNJjwX0Arrc8oLAVbzpg6U
 xvLr6SOTh5Xh3sxT61XIbxuVcCApxgaA06HRxUFERA==
X-Google-Smtp-Source: AGHT+IFPPRXvVUYdnqyHq83HIfhAImpUoBgAM0qWg9oQsfvUNmly0Z1OEpeGjUWGzoVh5XTxu1vK2NE4VphKNRXh8eY=
X-Received: by 2002:a17:907:784e:b0:9a9:e5bb:edc5 with SMTP id
 lb14-20020a170907784e00b009a9e5bbedc5mr1906642ejc.65.1694612298356; Wed, 13
 Sep 2023 06:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
 <20230908135320.7066-6-maxim.uvarov@linaro.org> <ZQFTbcuLihQm2qoI@hera>
 <e5931bb5-2dfd-d5f9-69b2-38d14eebf181@gmx.de>
In-Reply-To: <e5931bb5-2dfd-d5f9-69b2-38d14eebf181@gmx.de>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Wed, 13 Sep 2023 19:38:05 +0600
Message-ID: <CAD8XO3ZXoygUEagnpQhkQtK_XJF-o9n0bA953cdDD-=CDc43mw@mail.gmail.com>
Subject: Re: [PATCHv8 05/15] net/lwip: implement tftp cmd
To: Simon Goldschmidt <goldsimon@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 pbrobinson@gmail.com, 
 joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com
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

On Wed, 13 Sept 2023 at 14:38, Simon Goldschmidt <goldsimon@gmx.de> wrote:

>
>
> On 13.09.2023 08:15, Ilias Apalodimas wrote:
> >> +
> >> +/*
> >> + * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
> >> + */
> >> +
> >> +#include <common.h>
> >> +#include <command.h>
> >> +#include <console.h>
> >> +#include <bootstage.h>
> >> +
> >> +#include "tftp_client.h"
> >> +#include "tftp_server.h"
> >> +#include <tftp_example.h>
> >> +
> >> +#include <string.h>
> >> +
> >> +#include <net/ulwip.h>
> >> +
> >> +static ulong daddr;
> >> +static ulong size;
> >> +
> >> +static void *tftp_open(const char *fname, const char *mode, u8_t
> is_write)
> >> +{
> >> +    return NULL;
> >> +}
> >> +
> >> +static void tftp_close(void *handle)
> >> +{
> >> +    log_info("\ndone\n");
> >> +    log_info("Bytes transferred = %ld (0x%lx hex)\n", size, size);
> >> +
> >> +    bootstage_mark_name(BOOTSTAGE_KERNELREAD_STOP, "tftp_done");
> >> +    if (env_set_hex("filesize", size)) {
> >> +            log_err("filesize not updated\n");
> >> +            ulwip_exit(-1);
> >> +            return;
> >> +    }
> >> +    ulwip_exit(0);
> >> +}
> >> +
> >> +static int tftp_read(void *handle, void *buf, int bytes)
> >> +{
> >> +    return 0;
> >> +}
> >> +
> >> +static int tftp_write(void *handle, struct pbuf *p)
> >> +{
> >> +    struct pbuf *q;
> >> +
> >> +    for (q = p; q != NULL; q = q->next) {
> >> +            memcpy((void *)daddr, q->payload, q->len);
> >> +            daddr += q->len;
> >> +            size += q->len;
> >> +            log_info("#");
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static void tftp_error(void *handle, int err, const char *msg, int
> size)
> >> +{
> >> +    char message[100];
> >> +
> >> +    memset(message, 0, sizeof(message));
> >> +    memcpy(message, msg, LWIP_MIN(sizeof(message) - 1, (size_t)size));
> >> +
> >> +    log_info("TFTP error: %d (%s)", err, message);
> >> +}
> >> +
> >> +static const struct tftp_context tftp = {
> >> +    tftp_open,
> >> +    tftp_close,
> >> +    tftp_read,
> >> +    tftp_write,
> >> +    tftp_error
> >> +};
> >> +
> >> +int ulwip_tftp(ulong addr, char *fname)
> >> +{
> >> +    void *f = (void *)0x1; /* unused fake file handle*/
> >
> > I haven't dug into lwip details yet, but I am not sure this is safe to
> use.
> > Simon, since you maintain the lwip part can you elaborate a bit more?
>
>  From the lwIP design, using an invalid pointer here is ok: that pointer
> is only used as a client handle which is never dereferenced internally.
> The only requirement is that it is not NULL, as that is the validity
> check for the tftp client to know the handle is valid (or e.g. open
> failed etc.).
>
> So while we can leave 0x1 here, using a static uint8_t would probably be
> better, at the expense of using a byte for nothing.
>
> Regards,
> Simon
>

U-Boot does not like statics due to the fact that it can relocate itself to
another address.

BR,
Maxim.


>
> >
> >> +    err_t err;
> >> +    ip_addr_t srv;
> >> +    int ret;
> >> +    char *server_ip;
> >> +
> >> +    if (!fname || addr == 0)
> >> +            return CMD_RET_FAILURE;
> >> +
> >> +    size = 0;
> >> +    daddr = addr;
> >> +    server_ip = env_get("serverip");
> >> +    if (!server_ip) {
> >> +            log_err("error: serverip variable has to be set\n");
> >> +            return CMD_RET_FAILURE;
> >> +    }
> >> +
> >> +    ret = ipaddr_aton(server_ip, &srv);
> >> +    if (!ret) {
> >> +            log_err("error: ipaddr_aton\n");
> >> +            return CMD_RET_FAILURE;
> >> +    }
> >> +
> >> +    log_info("TFTP from server %s; our IP address is %s\n",
> >> +             server_ip, env_get("ipaddr"));
> >> +    log_info("Filename '%s'.\n", fname);
> >> +    log_info("Load address: 0x%lx\n", daddr);
> >> +    log_info("Loading:");
> >> +
> >> +    bootstage_mark_name(BOOTSTAGE_KERNELREAD_START, "tftp_start");
> >> +
> >> +    err = tftp_init_client(&tftp);
> >> +    if (!(err == ERR_OK || err == ERR_USE))
> >> +            log_err("tftp_init_client err: %d\n", err);
> >> +
> >> +    err = tftp_get(f, &srv, TFTP_PORT, fname, TFTP_MODE_OCTET);
> >> +    /* might return different errors, like routing problems */
> >> +    if (err != ERR_OK) {
> >> +            log_err("tftp_get err=%d\n", err);
> >> +            return CMD_RET_FAILURE;
> >> +    }
> >> +
> >> +    if (env_set_hex("fileaddr", addr)) {
> >> +            log_err("fileaddr not updated\n");
> >> +            return CMD_RET_FAILURE;
> >> +    }
> >> +
> >> +    return CMD_RET_SUCCESS;
> >> +}
> >> --
> >> 2.30.2
> >>
> >
> > Thanks
> > /Ilias
>
