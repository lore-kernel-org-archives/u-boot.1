Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C5BE94114
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 20:37:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC0C486BE7;
	Fri,  6 Oct 2023 22:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WsKn7/E6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 175C086D6E; Fri,  6 Oct 2023 22:37:21 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E76CD86B02
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 22:37:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rfried.dev@gmail.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-57bd4e4ada6so1451089eaf.3
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 13:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696624637; x=1697229437; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HeNd+4WJRCHIw5KqMk1mCQMnK2z3tVLxjcnqdkN+oWo=;
 b=WsKn7/E6yu4PABcraVUftLRfNDd8dWDQb/na4bam9maTHORRYXaxbTpQ9tTfEDPrwT
 F3PXY4fWSfLpaFscsFfmqg6x2fzt/aPgeZ9411l0PrW+Ol+rrZ8Q1CMyGPpP4aXbIxs6
 US8BYymiIPWkT2T32FjTIRVdylHfYwkGlidyJ6TTaH4doBoGPdwAEnqpzTuO12oX1TsY
 qvt6uUO+nCNcNgxaC9+Y358wbsif7woJdtDVVyQrO4gb895uOA+2K/z4V/IlPWR4nP0h
 HZNlnEXkWtiRBmlF0mEF1GfQn9mfLkv5S4n5r91stYyncu+Ok1goQjjCHl1h4wcpEL84
 +85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696624637; x=1697229437;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HeNd+4WJRCHIw5KqMk1mCQMnK2z3tVLxjcnqdkN+oWo=;
 b=veASKE9kfGlLRAE/9SroTrIWLncTP/9G9RgpbOWcst4o4+Xf3bkUM8YBx1q+D4op7A
 pKl4gSTtocTWyvvgppdpSSrCx5YB/DGi0JYSZKtzwT6P1K2bG16UGWnftNrxAvyc+YGD
 ttHv9NGyKfyjFprxmujv2rUCZmVeOvpDxpxnOto6mwNgbo6GqGI1pw1dE9ySuDS9CTmn
 1ftrwvy6NmZNzQyKHb16Tiok9ijBg/QkJ54i5/vfZMoCyCe91duBc+4lMc/bXh8GiL/X
 yWTrce38kepqdJGScKZ2qChDIC2Tefm7Y3ovyl96mmFp47UxTbJuJXK60LyLg5/FCdYi
 1B8A==
X-Gm-Message-State: AOJu0YweThZgWoKcMvkJIZTz66i+2zSXthWyMDc+A3xkVu4tujR4L7hl
 LZ3HgVp+9XBoLYxQCgN4+TZVNa2Rf9zW7dUFIYY=
X-Google-Smtp-Source: AGHT+IFDhgRdbvn/MMDoPPe8EbwKgZ3TD0WDOoPyszQD2Qvg9ck1sFSAffle9CuCjkf8QjVtiV5qbbpTFsRB9y96mXk=
X-Received: by 2002:a4a:2a5a:0:b0:57b:63a6:306d with SMTP id
 x26-20020a4a2a5a000000b0057b63a6306dmr8930419oox.6.1696624637638; Fri, 06 Oct
 2023 13:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230927093631.1595494-1-masahisa.kojima@linaro.org>
 <20230927093631.1595494-3-masahisa.kojima@linaro.org>
In-Reply-To: <20230927093631.1595494-3-masahisa.kojima@linaro.org>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Fri, 6 Oct 2023 23:37:06 +0300
Message-ID: <CAGi-RUJLYeeYdzjyc0=osJ9Bcz747B064O1TOo2VNkq8EVMajw@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] net: wget: add wget with dns utility function
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Sep 27, 2023 at 12:37=E2=80=AFPM Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> Current wget takes the target uri in this format:
>  "<http server ip>:<file path>"  e.g.) 192.168.1.1:/bar
> The http server ip address must be resolved before
> calling wget.
>
> This commit adds the utility function runs wget with dhs.
> User can call wget with the uri like "http://foo/bar".
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  include/net.h |  9 +++++++++
>  net/wget.c    | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+)
>
> diff --git a/include/net.h b/include/net.h
> index e254df7d7f..57889d8b7a 100644
> --- a/include/net.h
> +++ b/include/net.h
> @@ -926,4 +926,13 @@ void eth_set_enable_bootdevs(bool enable);
>  static inline void eth_set_enable_bootdevs(bool enable) {}
>  #endif
>
> +/**
> + * wget_with_dns() - runs dns host IP address resulution before wget
> + *
> + * @dst_addr:  destination address to download the file
> + * @uri:       uri string of target file of wget
> + * Return:     downloaded file size, negative if failed
> + */
> +int wget_with_dns(ulong dst_addr, char *uri);
> +
>  #endif /* __NET_H__ */
> diff --git a/net/wget.c b/net/wget.c
> index a48a8cb624..4801e28eb9 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -15,6 +15,7 @@
>  #include <net.h>
>  #include <net/tcp.h>
>  #include <net/wget.h>
> +#include <stdlib.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> @@ -504,3 +505,56 @@ void wget_start(void)
>
>         wget_send(TCP_SYN, 0, 0, 0);
>  }
> +
> +#if (IS_ENABLED(CONFIG_CMD_DNS))
> +int wget_with_dns(ulong dst_addr, char *uri)
> +{
> +       int ret;
> +       char *s, *host_name, *file_name, *str_copy;
> +
> +       /*
> +        * Download file using wget.
> +        *
> +        * U-Boot wget takes the target uri in this format.
> +        *  "<http server ip>:<file path>"  e.g.) 192.168.1.1:/sample/tes=
t.iso
> +        * Need to resolve the http server ip address before starting wge=
t.
> +        */
> +       str_copy =3D strdup(uri);
> +       if (!str_copy)
> +               return -ENOMEM;
> +
> +       s =3D str_copy + strlen("http://");
> +       host_name =3D strsep(&s, "/");
> +       if (!s) {
> +               log_err("Error: invalied uri, no file path\n");
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +       file_name =3D s;
> +
> +       /* TODO: If the given uri has ip address for the http server, ski=
p dns */
> +       net_dns_resolve =3D host_name;
> +       net_dns_env_var =3D "httpserverip";
> +       if (net_loop(DNS) < 0) {
> +               log_err("Error: dns lookup of %s failed, check setup\n", =
net_dns_resolve);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +       s =3D env_get("httpserverip");
> +       if (!s) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       strlcpy(net_boot_file_name, s, sizeof(net_boot_file_name));
> +       strlcat(net_boot_file_name, ":/", sizeof(net_boot_file_name)); /*=
 append '/' which is removed by strsep() */
> +       strlcat(net_boot_file_name, file_name, sizeof(net_boot_file_name)=
);
> +       image_load_addr =3D dst_addr;
> +       ret =3D net_loop(WGET);
> +
> +out:
> +       free(str_copy);
> +
> +       return ret;
> +}
> +#endif
> --
> 2.34.1
>
Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
