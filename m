Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB45EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F0AA864EB;
	Tue, 22 Aug 2023 20:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="JzaX1kiI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3263B855CE; Tue, 22 Aug 2023 20:58:07 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59EC6864EB
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 20:58:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d690c9fbda3so4588793276.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692730679; x=1693335479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BQ8p8nFQS0l/7AQHKxeVAK+OLlm3ly0IP+CrVBAs9mc=;
 b=JzaX1kiI3fSMitSY2SQZ9t3qOEM83O00g02fMXcs/YAW6kWRPZGvqY9J4gNEbjZY8Y
 SvFGy36TVQeo17/HC/WJ5Ibv3njjUGmepO1klP1x4w+O9dNXzvhq0dYX4nsUt+khHRO0
 hzIUtwjWKG7oHx+HmD+Yw13IBxD87u/O8Ob9jbA+Z7cLZrugKqhov3JNyD3QMdh2vh4Z
 OA3w6aQdv/3ABupj1T8B19oRiNN26BLI6YOJeFmoIyO2cHFZrcj8LEl+8kq+aL7bUqA5
 6oSIuzUe1BmO/F/8pCqWJqM/Y15oXbtzT8CX/qDDLi1qtmZt4tGQ/pdyiPKVH0MtNMA+
 IeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692730679; x=1693335479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BQ8p8nFQS0l/7AQHKxeVAK+OLlm3ly0IP+CrVBAs9mc=;
 b=be3/Y9+ca4NkQHetzTTbODFuK5avqhhAMiZVjKgFkFpGekpAX7si0Nq6qZ50sxswf0
 VPZQbl7384YzZiT3Mmg9+pT7YFKWTCdWIHKE7QM+sEjZaae38cF4CE6wHuHsep54hNwk
 PmMIrXLw7nsTy8M0aNoZCDNCz42tgrsQ+x2mCAMlFfJaloz+Yiz7ed6mFobKGN3bSeMD
 W+Ocy2IM7GbeoTXSURxXA2DrJeh3QlwMtmzmheJVsX8xBqfu9pfKl8tM58UymuQuj+X9
 YFpL7z6e4FY/2kZmwOwuXeDFBidb+1w3hOcR7QrmIXJpk+hU5eGfKGuipASIWiNwatRL
 QNPw==
X-Gm-Message-State: AOJu0YygvXYpFyIPSRNzPNpc3cLC6wlZPUylTDgbTu40rN3I/uc8e9Ts
 H43IO+6IbfrjQtWumEzrAdbDL8ToEZrs3SKExPOeTg==
X-Google-Smtp-Source: AGHT+IElbQGipGlJievcEklDxEvVqmATalASt8nM2O7febEhv2lUUS2LScSIXQ6zhhRKaPxWLDVsYOXFxZDGm6+GxGM=
X-Received: by 2002:a25:bc53:0:b0:ce8:4567:a382 with SMTP id
 d19-20020a25bc53000000b00ce84567a382mr10574368ybk.1.1692730678875; Tue, 22
 Aug 2023 11:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230822093614.4717-1-maxim.uvarov@linaro.org>
 <20230822093614.4717-6-maxim.uvarov@linaro.org>
In-Reply-To: <20230822093614.4717-6-maxim.uvarov@linaro.org>
From: Simon Glass <sjg@google.com>
Date: Tue, 22 Aug 2023 12:56:46 -0600
Message-ID: <CAPnjgZ2f_Q9QEayR2rmGN+aaEwGj6+7WpFVy+JFH+nOPX7nikw@mail.gmail.com>
Subject: Re: [PATCHv7 05/15] net/lwip: implement tftp cmd
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com, 
 goldsimon@gmx.de
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

Hi Maxim,

On Tue, 22 Aug 2023 at 03:39, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> U-Boot recently got support for an alternative network stack using LWIP.
> Replace tftp command with the LWIP variant while keeping the output and
> error messages identical.
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  include/net/lwip.h             |  14 +++-
>  net/lwip/Makefile              |   1 +
>  net/lwip/apps/tftp/Makefile    |  16 +++++
>  net/lwip/apps/tftp/lwip-tftp.c | 124 +++++++++++++++++++++++++++++++++
>  4 files changed, 154 insertions(+), 1 deletion(-)
>  create mode 100644 net/lwip/apps/tftp/Makefile
>  create mode 100644 net/lwip/apps/tftp/lwip-tftp.c
>
> diff --git a/include/net/lwip.h b/include/net/lwip.h
> index 240ebba354..14a65470ee 100644
> --- a/include/net/lwip.h
> +++ b/include/net/lwip.h
> @@ -28,4 +28,16 @@ int ulwip_dns(char *name, char *varname);
>   * Returns: 0 if success
>   *         Other value < 0, if error
>  */
> -int ulwip_dhcp(void);
> +
> +/**
> + * ulwip_tftp() - load file with tftp
> + *
> + * Load file with tftp to specific address
> + *
> + * @addr: Address to store downloaded file
> + * @filename: File name on remote tftp server to download
> + *
> + *
> + * Returns:  0 if success, !0 if error
> + */
> +int ulwip_tftp(ulong addr, const char *filename);

Does this load it, or initiate the load? When will this function return?

Please check your return values too. I believe they should all return
errno values, so -ve on error, rather than !0

> diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> index 59323fb325..0337d82cf5 100644
> --- a/net/lwip/Makefile
> +++ b/net/lwip/Makefile
> @@ -67,3 +67,4 @@ obj-$(CONFIG_NET) += port/sys-arch.o
>
>  obj-$(CONFIG_CMD_DHCP) += apps/dhcp/lwip-dhcp.o
>  obj-$(CONFIG_CMD_DNS) += apps/dns/lwip-dns.o
> +obj-$(CONFIG_CMD_TFTPBOOT) += apps/tftp/

We should separate the CMD configs from the functionality, i.e. I
should be able to have CONFIG_TFTPBOOT but not CONFIG_CMD_TFTPBOOT.
For standard boot, we need to be able to boot without CONFIG_CMDLINE
enabled.

This merging of CMD and functionality CONFIG options has historically
been a problem in U-Boot, but it is mostly tidied up now.

> diff --git a/net/lwip/apps/tftp/Makefile b/net/lwip/apps/tftp/Makefile
> new file mode 100644
> index 0000000000..0e50fcad45
> --- /dev/null
> +++ b/net/lwip/apps/tftp/Makefile
> @@ -0,0 +1,16 @@
> +
> +ccflags-y += -I$(srctree)/net/lwip/port/include
> +ccflags-y += -I$(srctree)/net/lwip/lwip-external/src/include -I$(srctree)/net/lwip
> +ccflags-y += -I$(obj)

Should we move this to

> +
> +$(obj)/tftp.o: $(obj)/tftp.c
> +.PHONY: $(obj)/tftp.c
> +$(obj)/tftp.c:
> +       cp $(srctree)/net/lwip/lwip-external/src/apps/tftp/tftp.c $(obj)/tftp.c
> +       cp $(srctree)/net/lwip/lwip-external/src/include/lwip/apps/tftp_client.h $(obj)/tftp_client.h
> +       cp $(srctree)/net/lwip/lwip-external/src/include/lwip/apps/tftp_common.h $(obj)/tftp_common.h
> +       cp $(srctree)/net/lwip/lwip-external/contrib/examples/tftp/tftp_example.h $(obj)/tftp_example.h

What is going on here?

> +
> +obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
> +obj-$(CONFIG_CMD_TFTPBOOT) += lwip-tftp.o
> +
> diff --git a/net/lwip/apps/tftp/lwip-tftp.c b/net/lwip/apps/tftp/lwip-tftp.c
> new file mode 100644
> index 0000000000..e6e4883de8
> --- /dev/null
> +++ b/net/lwip/apps/tftp/lwip-tftp.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
> + */
> +
> +#include <common.h>
> +#include <command.h>
> +#include <console.h>
> +#include <bootstage.h>
> +
> +#include "lwip/apps/tftp_client.h"
> +#include "lwip/apps/tftp_server.h"

Can we add a -I to the top-level Makefile so we can use #include
<ttfp_client.h> ?

> +#include <tftp_example.h>
> +
> +#include <string.h>

Should go up  the top

> +
> +#include <net/ulwip.h>
> +
> +static ulong daddr;
> +static ulong size;

Again please see if you can keep your state together rather than
sprinkling it around static vars.

> +
> +static void *tftp_open(const char *fname, const char *mode, u8_t is_write)
> +{
> +       LWIP_UNUSED_ARG(mode);
> +       return NULL;
> +}
> +
> +static void tftp_close(void *handle)
> +{
> +       log_info("\ndone\n");
> +       log_info("Bytes transferred = %ld (0x%lx hex)\n", size, size);
> +
> +       bootstage_mark_name(BOOTSTAGE_KERNELREAD_STOP, "tftp_done");
> +       env_set_ulong("filesize", size);

Error check...

> +       ulwip_exit(0);
> +}
> +
> +static int tftp_read(void *handle, void *buf, int bytes)
> +{
> +       return 0;
> +}
> +
> +static int tftp_write(void *handle, struct pbuf *p)
> +{
> +       struct pbuf *q;
> +
> +       for (q = p; q != NULL; q = q->next) {
> +               memcpy((void *)daddr, q->payload, q->len);
> +               daddr += q->len;
> +               size += q->len;
> +               log_info("#");
> +       }
> +
> +       return 0;
> +}
> +
> +static void tftp_error(void *handle, int err, const char *msg, int size)
> +{
> +       char message[100];
> +
> +       LWIP_UNUSED_ARG(handle);



> +
> +       memset(message, 0, sizeof(message));
> +       MEMCPY(message, msg, LWIP_MIN(sizeof(message)-1, (size_t)size));

what is MEMCPY() ?

> +
> +       log_info("TFTP error: %d (%s)", err, message);
> +}
> +
> +static const struct tftp_context tftp = {
> +       tftp_open,
> +       tftp_close,
> +       tftp_read,
> +       tftp_write,
> +       tftp_error
> +};
> +
> +int ulwip_tftp(ulong addr, char *fname)
> +{
> +       void *f = (void *)0x1; /* unused fake file handle*/
> +       err_t err;
> +       ip_addr_t srv;
> +       int ret;
> +       char *server_ip;
> +
> +       if (!fname || addr == 0)
> +               return CMD_RET_FAILURE;
> +
> +       size = 0;
> +       daddr = addr;
> +       server_ip = env_get("serverip");
> +       if (!server_ip) {
> +               log_err("error: serverip variable has to be set\n");
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       ret = ipaddr_aton(server_ip, &srv);
> +       if (!ret) {
> +               log_err("error: ipaddr_aton\n");
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       log_info("TFTP from server %s; our IP address is %s\n",
> +                server_ip, env_get("ipaddr"));
> +       log_info("Filename '%s'.\n", fname);
> +       log_info("Load address: 0x%lx\n", daddr);
> +       log_info("Loading:");
> +
> +       bootstage_mark_name(BOOTSTAGE_KERNELREAD_START, "tftp_start");
> +
> +       err = tftp_init_client(&tftp);
> +       if (!(err == ERR_OK || err == ERR_USE))
> +               log_err("tftp_init_client err: %d\n", err);
> +
> +       err = tftp_get(f, &srv, TFTP_PORT, fname, TFTP_MODE_OCTET);
> +       /* might return different errors, like routing problems */
> +       if (err != ERR_OK) {
> +               log_err("tftp_get err=%d\n", err);
> +               return CMD_RET_FAILURE;
> +       }
> +
> +       env_set_hex("fileaddr", addr);
> +       return err;
> +}
> --
> 2.30.2
>

I'm going to stop at this patch...

Regards,
Simon
