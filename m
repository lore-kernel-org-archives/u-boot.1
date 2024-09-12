Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62883EE57FB
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C819288DFC;
	Thu, 12 Sep 2024 03:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nJF0vCda";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63D5788DCC; Thu, 12 Sep 2024 03:00:28 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E75D088DCB
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:00:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-718d8d6af8fso256129b3a.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102817; x=1726707617; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H5cwPpZfKmK1ShthvHa+rff3Qmt/5ZJK5AtZzejvWnw=;
 b=nJF0vCdaneRUS0R2E+kDnRTBFMv5qMn5hwieFqSib4RE4/ax+RhN/usSlJ9M8sZ/SI
 Hmq3VT3s33ZXjf5WeU5RulX4/JOBTVCAjG5XOsNydSYm+6K0o/WkKD0mIyeIGNSSP8OP
 A0ucMnDCJLPMETV601E7LglT4r6Rl8eLET0qA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102817; x=1726707617;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H5cwPpZfKmK1ShthvHa+rff3Qmt/5ZJK5AtZzejvWnw=;
 b=uXyqvjRZ/NY/AWwjoOdIGW4SUCG7i907+gl8XYvGqoMHiUxVd72Kqs1mrHdS5b5ubG
 pJ6DJ9OQEkMyiWrLOs+VBpD9CisB2M3NLdLzxJY3kpjgqttAHkWvI6QdF9TmINudkplg
 OPz2+JyR200gulZ3vzHG6uzLsfIVao8zTOhObX8R//Nqeao6sbqIb8928s9wawXjpPxk
 u1R96tY/16O3bB2gBkyjXhuzNgldUuvN7d/ixul6z0MxnqyHCxPq6sYXPjqZTEUM6EI8
 QgQMQIP9x570l2S+tkJfWVH9eKisj9tA3iba+55IhUw3+uve27MqPJcfZpmFU+DGDq+N
 +Avw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu2d+NUoqWsbq2l8VAUMFimWER7fM9qDKep34NdV0dgCQdmaZm8HsGRk9AvQsfAtWufs7l8i4=@lists.denx.de
X-Gm-Message-State: AOJu0Ywhok9wE/ZspM65jJV/k1J5+CHUEYqpRj8YuFOe5E809PvJzM5/
 s9r1HPVH7nimxY+HR8AQ1mOmXwsZnlYTUOXbLIPsvfc9OW6mmImf8FrHWeOg7FsHuIezhcS8Jmy
 A9f4ayNgix5xsptQZP+/x0QO7XhAs2mD9gFMq
X-Google-Smtp-Source: AGHT+IFFcyhCzWaqk+Vl3U4DB11i6aW6fyUqIu8ppCxRqoKztTZAQOSGJCWBnAoEnA7lNd8orEi6omI6vE9koUcsP2o=
X-Received: by 2002:a05:6a00:4f90:b0:717:97ac:ef46 with SMTP id
 d2e1a72fcca58-7192609615amr1875215b3a.15.1726102816833; Wed, 11 Sep 2024
 18:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240909222720.2563118-1-mikhail.kshevetskiy@iopsys.eu>
 <20240909222720.2563118-13-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240909222720.2563118-13-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:59:57 -0600
Message-ID: <CAFLszTisj16rMWddxmvnaCTZCunV+NDxk6KH0sYNJ6tD6OAdWQ@mail.gmail.com>
Subject: Re: [PATCH v6 12/12] net/httpd-upload: an example web-server
 implementation for file uploading
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Baruch Siach <baruch@tkos.co.il>, Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de
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

Hi Mikhail,

On Mon, 9 Sept 2024 at 16:27, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> This is an example web-server implementation. It can be used for files
> uploading to u-boot using a web-browser. It acts much like tftpget, but no
> special servers needs to be installed by the user.
>
> This code can be used as a base for other implementations like firmware
> upgrade web-server used by some vendors.
>
> Usage:
>   u-boot: start the we-server using the "httpd_upload" command
>   PC:     open the "http://your_uboot_ip" link in the browser
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  cmd/Kconfig                     |  14 ++++
>  cmd/net.c                       |  20 ++++++
>  include/net/httpd-upload.h      |  12 ++++
>  net/Makefile                    |  19 +++++
>  net/httpd-upload.c              | 123 ++++++++++++++++++++++++++++++++
>  net/httpd_upload/error_400.html |   9 +++
>  net/httpd_upload/error_404.html |  10 +++
>  net/httpd_upload/index.html     |  14 ++++
>  net/httpd_upload/upload_ok.html |   7 ++
>  9 files changed, 228 insertions(+)
>  create mode 100644 include/net/httpd-upload.h
>  create mode 100644 net/httpd-upload.c
>  create mode 100644 net/httpd_upload/error_400.html
>  create mode 100644 net/httpd_upload/error_404.html
>  create mode 100644 net/httpd_upload/index.html
>  create mode 100644 net/httpd_upload/upload_ok.html

Can you just include the strings in the C file?

>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index abcd003f7f1..55b9d04f2fa 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2014,6 +2014,20 @@ config CMD_NETCAT
>           netcat is a simple command to load/store kernel, or other files,
>           using netcat like manner over TCP.
>
> +config CMD_HTTPD_UPLOAD
> +       bool "an example HTTP server for file uploading"
> +       depends on HTTPD_COMMON
> +       help
> +         HTTP/1.1 compatible server for file uploading.

Please expand help

> +
> +config CMD_HTTPD_UPLOAD_MAX_SIZE
> +       int "Maximum uploading size"
> +       depends on CMD_HTTPD_UPLOAD
> +       default 209715200
> +       help
> +         This sets maximum size of uploaded file. Real transfer will be

sets the maximum

of any uploaded

> +         slightly more than this limit.

Please describe why

> +
>  config CMD_MII
>         bool "mii"
>         imply CMD_MDIO
> diff --git a/cmd/net.c b/cmd/net.c
> index 364139ec5b9..e5fddc8c7c5 100644
> --- a/cmd/net.c
> +++ b/cmd/net.c
> @@ -21,6 +21,9 @@
>  #include <net/udp.h>
>  #include <net/sntp.h>
>  #include <net/ncsi.h>
> +#if defined(CONFIG_CMD_HTTPD_UPLOAD)
> +#include <net/httpd-upload.h>
> +#endif
>
>  static int netboot_common(enum proto_t, struct cmd_tbl *, int, char * const []);
>
> @@ -228,6 +231,23 @@ U_BOOT_CMD(
>  );
>  #endif
>
> +#if defined(CONFIG_CMD_HTTPD_UPLOAD)
> +static int do_httpd_upload(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +{
> +       if (argc < 2)
> +               return 1;
> +
> +       httpd_upload_prepare();
> +       return netboot_common(HTTPD, cmdtp, argc, argv);
> +}
> +
> +U_BOOT_CMD(
> +       httpd_upload,   2,      1,      do_httpd_upload,
> +       "starts httpd server for file uploading",
> +       "[loadAddress]\n"
> +);
> +#endif
> +
>  static void netboot_update_env(void)
>  {
>         char tmp[46];
> diff --git a/include/net/httpd-upload.h b/include/net/httpd-upload.h
> new file mode 100644
> index 00000000000..a80df214668
> --- /dev/null
> +++ b/include/net/httpd-upload.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: BSD-2-Clause
> + *
> + * httpd-upload include file
> + * Copyright (C) 2024 IOPSYS Software Solutions AB
> + * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> + */
> +#ifndef __NET_HTTPD_UPLOAD_TCP_H__
> +#define __NET_HTTPD_UPLOAD_TCP_H__
> +
> +void httpd_upload_prepare(void);
> +
> +#endif /* __NET_HTTPD_UPLOAD_TCP_H__ */
> diff --git a/net/Makefile b/net/Makefile
> index c1f491fad02..e7cbbc2248e 100644
> --- a/net/Makefile
> +++ b/net/Makefile
> @@ -35,8 +35,27 @@ obj-$(CONFIG_PROT_TCP) += tcp.o
>  obj-$(CONFIG_CMD_WGET) += wget.o
>  obj-$(CONFIG_CMD_NETCAT) += netcat.o
>  obj-$(CONFIG_HTTPD_COMMON) += httpd.o
> +obj-$(CONFIG_CMD_HTTPD_UPLOAD) += httpd-upload.o
>
>  # Disable this warning as it is triggered by:
>  # sprintf(buf, index ? "foo%d" : "foo", index)
>  # and this is intentional usage.
>  CFLAGS_eth_common.o += -Wno-format-extra-args
> +
> +STATIC_SUBST := 's/^\(unsigned char \)/static \1/'
> +SIZE_REMOVE_SUBST := 's/^unsigned int .*//'
> +
> +httpd_upload_generated:
> +       rm -rf $(src)/httpd_upload_generated
> +       mkdir -p $(src)/httpd_upload_generated
> +       cd $(src)/httpd_upload && find . -type f | while read fname; do \
> +               name="$${fname##*/}" && \
> +               name="$${name%%.*}"  && \
> +               set -o pipefail && xxd -i "$${fname##./}" | \
> +                       sed $(STATIC_SUBST) | \
> +                       sed $(SIZE_REMOVE_SUBST) > ../httpd_upload_generated/$${name}.h; \
> +       done
> +
> +.PHONY: httpd_upload_generated
> +
> +net/httpd-upload.o:    httpd_upload_generated
> diff --git a/net/httpd-upload.c b/net/httpd-upload.c
> new file mode 100644
> index 00000000000..1e1e0b1cf75
> --- /dev/null
> +++ b/net/httpd-upload.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * httpd-upload support driver
> + * Copyright (C) 2024 IOPSYS Software Solutions AB
> + * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> + */
> +
> +#include <command.h>
> +#include <net.h>
> +#include <net/httpd.h>
> +#include <net/httpd-upload.h>
> +
> +#define MAX_FILE_SIZE  CONFIG_CMD_HTTPD_UPLOAD_MAX_SIZE
> +
> +static enum net_loop_state  httpd_on_stop(void);
> +
> +static enum httpd_req_check httpd_pre_post(void *req_id, const char *url,
> +                                          struct httpd_post_data *post);
> +static struct http_reply    *httpd_get(void *req_id, const char *url);
> +static struct http_reply    *httpd_post(void *req_id, const char *url,
> +                                       struct httpd_post_data *post);
> +static void                 httpd_on_req_end(void *req_id);
> +
> +#include "httpd_upload_generated/error_400.h"
> +#include "httpd_upload_generated/error_404.h"
> +#include "httpd_upload_generated/index.h"
> +#include "httpd_upload_generated/upload_ok.h"
> +
> +static struct http_reply error_400 = {
> +       .code      = 400,
> +       .code_msg  = "Bad Request",
> +       .data_type = "text/html; charset=utf-8",
> +       .data      = error_400_html,
> +       .len       = sizeof(error_400_html)
> +};
> +
> +static struct http_reply error_404 = {
> +       .code      = 404,
> +       .code_msg  = "Not Found",
> +       .data_type = "text/html; charset=utf-8",
> +       .data      = error_404_html,
> +       .len       = sizeof(error_404_html)
> +};
> +
> +static struct http_reply index = {
> +       .code      = 200,
> +       .code_msg  = "OK",
> +       .data_type = "text/html; charset=utf-8",
> +       .data      = index_html,
> +       .len       = sizeof(index_html)
> +};
> +
> +static struct http_reply upload_ok = {
> +       .code      = 200,
> +       .code_msg  = "OK",
> +       .data_type = "text/html; charset=utf-8",
> +       .data      = upload_ok_html,
> +       .len       = sizeof(upload_ok_html)
> +};
> +
> +static struct httpd_config cfg = {
> +       .on_stop    = httpd_on_stop,
> +       .on_req_end = httpd_on_req_end,
> +       .get        = httpd_get,
> +       .post       = httpd_post,
> +       .pre_post   = httpd_pre_post,
> +       .error_400  = &error_400,
> +       .error_404  = &error_404,
> +};
> +
> +static enum net_loop_state     httpd_loop_state;
> +static void                    *post_req_id;
> +
> +void httpd_upload_prepare(void)
> +{
> +       httpd_setup(&cfg);
> +       httpd_loop_state = NETLOOP_FAIL;
> +}
> +
> +static enum httpd_req_check httpd_pre_post(void *req_id, const char *url,
> +                                          struct httpd_post_data *post)
> +{
> +       if (post->size > MAX_FILE_SIZE) {
> +               printf("HTTPD: reset connection, upload file is too large\n");
> +               return HTTPD_CLNT_RST;
> +       }
> +
> +       post_req_id = req_id;
> +       return HTTPD_REQ_OK;
> +}
> +
> +static struct http_reply *httpd_post(void *req_id, const char *url,
> +                                    struct httpd_post_data *post)
> +{
> +       if (strcmp(url, "/file_upload"))
> +               return &error_404;
> +
> +       httpd_loop_state = NETLOOP_SUCCESS;
> +       printf("HTTPD: upload OK\n");
> +       return &upload_ok;
> +}
> +
> +static struct http_reply *httpd_get(void *req_id, const char *url)
> +{
> +       if (!strcmp(url, "/"))
> +               return &index;
> +       if (!strcmp(url, "/index.html"))
> +               return &index;
> +       return &error_404;
> +}
> +
> +static void httpd_on_req_end(void *req_id)
> +{
> +       if (req_id == post_req_id) {
> +               post_req_id = NULL;
> +               httpd_stop();
> +       }
> +}
> +
> +static enum net_loop_state httpd_on_stop(void)
> +{
> +       return httpd_loop_state;
> +}
> diff --git a/net/httpd_upload/error_400.html b/net/httpd_upload/error_400.html
> new file mode 100644
> index 00000000000..de654364edf
> --- /dev/null
> +++ b/net/httpd_upload/error_400.html
> @@ -0,0 +1,9 @@
> +<html>
> +  <head><title>400</title></head>
> +  <body>
> +    <h1>400 - Bad Request</h1>
> +    <p>
> +      Sorry, the request you are trying to do is wrong.
> +    </p>
> +  </body>
> +</html>
> diff --git a/net/httpd_upload/error_404.html b/net/httpd_upload/error_404.html
> new file mode 100644
> index 00000000000..9dac22d497d
> --- /dev/null
> +++ b/net/httpd_upload/error_404.html
> @@ -0,0 +1,10 @@
> +<html>
> +  <head><title>404</title></head>
> +  <body>
> +    <h1>404 - Page not found</h1>
> +    <p>
> +      Sorry, the page you are requesting was not found on this
> +      server.
> +    </p>
> +  </body>
> +</html>
> diff --git a/net/httpd_upload/index.html b/net/httpd_upload/index.html
> new file mode 100644
> index 00000000000..e7d5ac943b6
> --- /dev/null
> +++ b/net/httpd_upload/index.html
> @@ -0,0 +1,14 @@
> +<html>
> +  <head><title>Upload File</title></head>
> +  <body>
> +    <h1>Upload File.</h1>
> +    <p>This will write the uploaded file to the memory arear pointed by ${loadaddr}.
> +      <form method="post" enctype="multipart/form-data" action="file_upload">
> +        File to upload:
> +        <input type="file" name="fileID" size="500" /><br />
> +        <p>&nbsp;&nbsp;<input type="submit" value="upload" />
> +        <p>It takes no more than a second after the file has been uploaded until status OK is shown.
> +      </form>
> +    </p>
> +  </body>
> +</html>
> diff --git a/net/httpd_upload/upload_ok.html b/net/httpd_upload/upload_ok.html
> new file mode 100644
> index 00000000000..8d2e561982f
> --- /dev/null
> +++ b/net/httpd_upload/upload_ok.html
> @@ -0,0 +1,7 @@
> +<html>
> +  <head><title>OK</title></head>
> +  <body>
> +    <h1>Upload OK</h1>
> +    <p>The file was uploaded.</p>
> +  </body>
> +</html>
> --
> 2.45.2
>

REgards,
Simon
