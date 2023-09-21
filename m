Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4C4CD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 440A286CB1;
	Thu, 21 Sep 2023 03:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iJQCqMOs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51CA786CAF; Thu, 21 Sep 2023 03:02:51 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3384A86C9F
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-503397ee920so770621e87.1
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695258167; x=1695862967; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dEYdlcSMYP5/sjgcowFtwCe06+5HIv49v33hPaN/34U=;
 b=iJQCqMOsxPA6E/Ze8uXw7dh9wsfN5nNCd8YPrU2b6vN22J6vvwznXAuscm4o70ixU8
 /ARAfLE07uNaPRIrujEsvXS/Maxl2lP+totxnLjI+9dTfO9a3o5sMT5MbxP/wIvS4Fkd
 Ak3udhTexNYW4SnwqiaJ/XExj2Angpih2cmSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258167; x=1695862967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dEYdlcSMYP5/sjgcowFtwCe06+5HIv49v33hPaN/34U=;
 b=ej+SdS0VXEV4eAHCCIo6dd8jPcSpm4VVmb16X7DG92KeY135SztXaaH4eKhtOwmjS+
 jVyC/yOTvQZtU7tsRmQtpA4ix/bMR3dVoY1c+tZaKffdHQXej2sVznptJtSxeX07L1MM
 ZJ7rTA9/OJuqodyWUV7M+slGgLsfMwLAzmOVuK4aFz6fVLfIhmwQXQvHAnl3gyrg5Obb
 4L9jFVQ5U6/k0goKFcHgGC3BlPe+SUtA2HWh9op7Vmv85FM7rDNiHdG7NxT9nS+pTLxL
 r63iSc9gU/+oeckUzpaKw/1h+tlfe8fIaac2sBdQ2eXC9h7B8IW0sHZnnAKEKdfAo7ao
 9+oQ==
X-Gm-Message-State: AOJu0YyHia5ffy1GBS+hkkC/eKK8a1DtF9ziGXu9xa3p3xFCgRplzn76
 iHXM2goZbltuI4IUwSE3OXeULoF82JbYROIyTbT6ZQ==
X-Google-Smtp-Source: AGHT+IFf/lFPydr/rWBaMSyh7m9fpZ4HKtbt67XE7EVMvcMC2QA+0A7+qqehP7pixgYSSQV1juU5Ss1lYGIP8POil/c=
X-Received: by 2002:ac2:5b1d:0:b0:503:1746:6882 with SMTP id
 v29-20020ac25b1d000000b0050317466882mr3675880lfn.37.1695258167407; Wed, 20
 Sep 2023 18:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230915101640.1166332-1-masahisa.kojima@linaro.org>
 <20230915101640.1166332-3-masahisa.kojima@linaro.org>
In-Reply-To: <20230915101640.1166332-3-masahisa.kojima@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 19:02:27 -0600
Message-ID: <CAPnjgZ05X8-KMSvYOSzsdWxcJcD43HDeiY0Jnh_6MTczKRmAEA@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] net: wget: add wget with dns utility function
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

On Fri, 15 Sept 2023 at 04:17, Masahisa Kojima
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
> ---
>  include/net.h |  2 ++
>  net/wget.c    | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
>
> diff --git a/include/net.h b/include/net.h
> index e254df7d7f..b9cba5244a 100644
> --- a/include/net.h
> +++ b/include/net.h
> @@ -926,4 +926,6 @@ void eth_set_enable_bootdevs(bool enable);
>  static inline void eth_set_enable_bootdevs(bool enable) {}
>  #endif
>
> +int wget_with_dns(ulong dst_addr, char *uri);

Please add a comment about what this does, including args and return
value. We comment all global functions and non-trvial static ones.

> +
>  #endif /* __NET_H__ */
> diff --git a/net/wget.c b/net/wget.c
> index 9690e4539c..bdf940a315 100644
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
> +        *  "<http server ip>:<file path>"  e.g.) 192.168.1.1:/sample/test.iso
> +        * Need to resolve the http server ip address before starting wget.
> +        */
> +       str_copy = strdup(uri);
> +       if (!str_copy)
> +               return -ENOMEM;
> +
> +       s = str_copy + strlen("http://");
> +       host_name = strsep(&s, "/");
> +       if (!s) {
> +               log_err("Error: invalied uri, no file path\n");
> +               ret = -EINVAL;
> +               goto out;
> +       }
> +       file_name = s;
> +
> +       /* TODO: If the given uri has ip address for the http server, skip dns */
> +       net_dns_resolve = host_name;
> +       net_dns_env_var = "httpserverip";
> +       if (net_loop(DNS) < 0) {
> +               log_err("Error: dns lookup of %s failed, check setup\n", net_dns_resolve);
> +               ret = -EINVAL;
> +               goto out;
> +       }
> +       s = env_get("httpserverip");
> +       if (!s) {
> +               ret = -EINVAL;
> +               goto out;
> +       }
> +
> +       strlcpy(net_boot_file_name, s, sizeof(net_boot_file_name));
> +       strlcat(net_boot_file_name, ":/", sizeof(net_boot_file_name)); /* append '/' which is removed by strsep() */
> +       strlcat(net_boot_file_name, file_name, sizeof(net_boot_file_name));
> +       image_load_addr = dst_addr;
> +       ret = net_loop(WGET);
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

Regards,
Simon
