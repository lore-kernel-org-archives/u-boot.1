Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83E5E7D0D5
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 06:51:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D029A863DE;
	Fri, 22 Sep 2023 08:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f0jPnM0h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AEEB864AA; Fri, 22 Sep 2023 08:51:03 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA402803AE
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 08:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-274e392a5c1so1308677a91.0
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 23:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695365459; x=1695970259; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DC5dwaLT7xUbe5ZC8xSTVvvVV+mg5w00N5PpyutGVBg=;
 b=f0jPnM0hBWgswqwOWAH3KeN049m2aeKkGrmQaAxRt54oodifQqr6G+WxDXizW8nOD9
 n3KNP66AJ+9zoA5vBCTOQnZAlkEh0yd9m65GK/8GB6DQ9CFiK6qMymjEvdSd7RYjuCwc
 N5ylcUBSs+5k003uQKpuZTsXZv8lFrAkGRoCdjQIG6XHLh8e8eon9JXVV/jmCTshghuD
 hI56UmSK5XqNWB1xmVvx50qs5OY+1rrmYVEXLlJHSjEVWviDTA0kBMUrc9VRtBfgYhC/
 2mXaHIc7M39CXpIe4PqumAN6L1/8SD1HdGPlbSqnx2Q2tmVsFCQODqNnis3PqHuiHV4z
 fSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695365459; x=1695970259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DC5dwaLT7xUbe5ZC8xSTVvvVV+mg5w00N5PpyutGVBg=;
 b=mX+ZlyC2Fh9nOIp1Lkyq0DldnREdviW433JyRlrnW+6AJYtCNQ3Wp8yMNyovrWBJur
 T9GtbAXC2Qdr+ovKOGRcGtLeQigilUO/LpUSwAFQvS7rUatnoIrrnrc9EX5SNW8RQtJ9
 UYe2T0/1adwokLhcmLYlkPYNudjQoTLRklxGHEIj7XtcOnXPslJAE4Y7y22JgeUJvWU6
 dUUHrW0BmihyTfYZ6QspVATInG0eSL2kdwYL4F6JyZDm/c2R/ZvrVKibQeEgsg4Wwk/f
 Dd2vxnsGp0bXegwUEMuMRH2Ts9i4slyaa4Jn0lnpYxwOMLx8v5aSEDaXDxYujgD9JShL
 rsww==
X-Gm-Message-State: AOJu0Yw9cMAVzLwHD7ToIStl+T/P+VCBxAUrx+6x+sK7hyBn4XRviTPu
 GOPkCfXkTuDAhDjCRtO2UMxf8liwI0xMVs+LrVnJJQ==
X-Google-Smtp-Source: AGHT+IFZPnlPpoT+gAB6jxxrDPEzrs5XtFcB3r+UT3RcyfLNxqmkuiZsfQAVejUriHOdCfkJW3/7ZEveYINExAQTSjc=
X-Received: by 2002:a17:90a:4f4b:b0:26d:43f0:7ce4 with SMTP id
 w11-20020a17090a4f4b00b0026d43f07ce4mr7916065pjl.8.1695365459177; Thu, 21 Sep
 2023 23:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230915101640.1166332-1-masahisa.kojima@linaro.org>
 <20230915101640.1166332-3-masahisa.kojima@linaro.org>
 <CAPnjgZ05X8-KMSvYOSzsdWxcJcD43HDeiY0Jnh_6MTczKRmAEA@mail.gmail.com>
In-Reply-To: <CAPnjgZ05X8-KMSvYOSzsdWxcJcD43HDeiY0Jnh_6MTczKRmAEA@mail.gmail.com>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Fri, 22 Sep 2023 15:50:48 +0900
Message-ID: <CADQ0-X_CTQEGCJuBPjWEfRB_-hmEeMMkt_dX+jp3vv-hXpiwTg@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] net: wget: add wget with dns utility function
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

On Thu, 21 Sept 2023 at 10:02, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Masahisa,
>
> On Fri, 15 Sept 2023 at 04:17, Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:
> >
> > Current wget takes the target uri in this format:
> >  "<http server ip>:<file path>"  e.g.) 192.168.1.1:/bar
> > The http server ip address must be resolved before
> > calling wget.
> >
> > This commit adds the utility function runs wget with dhs.
> > User can call wget with the uri like "http://foo/bar".
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >  include/net.h |  2 ++
> >  net/wget.c    | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 56 insertions(+)
> >
> > diff --git a/include/net.h b/include/net.h
> > index e254df7d7f..b9cba5244a 100644
> > --- a/include/net.h
> > +++ b/include/net.h
> > @@ -926,4 +926,6 @@ void eth_set_enable_bootdevs(bool enable);
> >  static inline void eth_set_enable_bootdevs(bool enable) {}
> >  #endif
> >
> > +int wget_with_dns(ulong dst_addr, char *uri);
>
> Please add a comment about what this does, including args and return
> value. We comment all global functions and non-trvial static ones.

Yes, I will add a comment for the global function.

Thanks,
Masahisa Kojima

>
> > +
> >  #endif /* __NET_H__ */
> > diff --git a/net/wget.c b/net/wget.c
> > index 9690e4539c..bdf940a315 100644
> > --- a/net/wget.c
> > +++ b/net/wget.c
> > @@ -15,6 +15,7 @@
> >  #include <net.h>
> >  #include <net/tcp.h>
> >  #include <net/wget.h>
> > +#include <stdlib.h>
> >
> >  DECLARE_GLOBAL_DATA_PTR;
> >
> > @@ -504,3 +505,56 @@ void wget_start(void)
> >
> >         wget_send(TCP_SYN, 0, 0, 0);
> >  }
> > +
> > +#if (IS_ENABLED(CONFIG_CMD_DNS))
> > +int wget_with_dns(ulong dst_addr, char *uri)
> > +{
> > +       int ret;
> > +       char *s, *host_name, *file_name, *str_copy;
> > +
> > +       /*
> > +        * Download file using wget.
> > +        *
> > +        * U-Boot wget takes the target uri in this format.
> > +        *  "<http server ip>:<file path>"  e.g.) 192.168.1.1:/sample/test.iso
> > +        * Need to resolve the http server ip address before starting wget.
> > +        */
> > +       str_copy = strdup(uri);
> > +       if (!str_copy)
> > +               return -ENOMEM;
> > +
> > +       s = str_copy + strlen("http://");
> > +       host_name = strsep(&s, "/");
> > +       if (!s) {
> > +               log_err("Error: invalied uri, no file path\n");
> > +               ret = -EINVAL;
> > +               goto out;
> > +       }
> > +       file_name = s;
> > +
> > +       /* TODO: If the given uri has ip address for the http server, skip dns */
> > +       net_dns_resolve = host_name;
> > +       net_dns_env_var = "httpserverip";
> > +       if (net_loop(DNS) < 0) {
> > +               log_err("Error: dns lookup of %s failed, check setup\n", net_dns_resolve);
> > +               ret = -EINVAL;
> > +               goto out;
> > +       }
> > +       s = env_get("httpserverip");
> > +       if (!s) {
> > +               ret = -EINVAL;
> > +               goto out;
> > +       }
> > +
> > +       strlcpy(net_boot_file_name, s, sizeof(net_boot_file_name));
> > +       strlcat(net_boot_file_name, ":/", sizeof(net_boot_file_name)); /* append '/' which is removed by strsep() */
> > +       strlcat(net_boot_file_name, file_name, sizeof(net_boot_file_name));
> > +       image_load_addr = dst_addr;
> > +       ret = net_loop(WGET);
> > +
> > +out:
> > +       free(str_copy);
> > +
> > +       return ret;
> > +}
> > +#endif
> > --
> > 2.34.1
> >
>
> Regards,
> Simon
