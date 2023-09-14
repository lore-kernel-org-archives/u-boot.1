Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA41EEAA7A
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 23:21:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E099A86741;
	Fri, 15 Sep 2023 01:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BOKJJyy7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 998AF864D7; Fri, 15 Sep 2023 01:21:06 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67320864D7
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 01:21:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2747b49cac4so864956a91.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 16:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694733663; x=1695338463; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JNSor/Da2fzNm4Z7aE/b/qJAirRVGn92/iY3M8yskAM=;
 b=BOKJJyy7MuJl6JHk1DtjRZSmIIoqrd3C49oPTJqnujFgfUZbCQvcPeyCegMN+vWz4A
 O1Bc/egH7iHPBE2ycNHS/aEFdBdKHmguVGty2rpvofGwUvgVUqUyYeO5w52PCOikAdv+
 kLjDrTS5/qCz1MDfI2FtjbNrI9+CdgFMa3FGkLfbm5bIemnV5SlPnS6xuRNZpBlviEw3
 iC9btN8r9pHuY7s1JWKqIsu0nPMkbqCxRkx39l/2tnvUxVyfXl8yN9ahhieFc7NQY/bH
 /u5zxuzub5eJWIqGvkH1QSbBn4aM3gdF7Q+ZZyFmKBFg7qZuoq1dObGYVkA8mVz4KeGT
 EOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694733663; x=1695338463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JNSor/Da2fzNm4Z7aE/b/qJAirRVGn92/iY3M8yskAM=;
 b=vzh3euF4WknV79ayeLwcH4lNQiYe/tixf+sJbAK6b4aX4UbYiiD7fF24lu6B3Cav1S
 RQVVGNihixLFED1OqZnAWzjUWx4lx3hZO1tosqtbFUhyE/V9P+h/2Wim4f+d8+m2IElR
 +ypXZ9yUpjnFPb9ygicPI5bzc0YSidO+h8fo9bd2L4qKPNlZOdSJq/SeUpiHhntSumII
 HiWb7eHRPH4b9gZ0p7wgWQa6JJgXTHPXnd5jNs0IbZZa+qs1gp29zuUNT8y2G/i5gnqY
 0nyXM5bP0kbDxpSfIkKDqNi62lvv8qf6WgzV8DFaxo34hnp8YMTAtQunIUotJW012Ma3
 WVKw==
X-Gm-Message-State: AOJu0YyQx6SYO6d5yfWnrMqmIqjZBZry/tsdlM8HaNabNe5t1PRn+apW
 sCjsFgilCWzn5ZbDU0HUA2738+C1Wu6AQ0b4RPmLyw==
X-Google-Smtp-Source: AGHT+IG6cyIqH8cHwu7WAzxsF7dd4rXI5xptROCjK6/GojHiCJfQrGka4PSUXrFwG30RcYRwqbM7eyJovod9XSxc+bU=
X-Received: by 2002:a17:90a:f00e:b0:274:922d:4b35 with SMTP id
 bt14-20020a17090af00e00b00274922d4b35mr1061756pjb.1.1694733662772; Thu, 14
 Sep 2023 16:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230901102542.609239-1-masahisa.kojima@linaro.org>
 <20230901102542.609239-3-masahisa.kojima@linaro.org> <ZQMB+VZ6msAaK5da@hera>
In-Reply-To: <ZQMB+VZ6msAaK5da@hera>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Fri, 15 Sep 2023 08:20:51 +0900
Message-ID: <CADQ0-X9BXXWLJKYCQAp6gSRGtapuR_yS3Bs0cFQDQt7_D2ysWg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] net: wget: add wget with dns utility function
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, 
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

Hi Ilias,

On Thu, 14 Sept 2023 at 21:52, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Kojima-san
>
> [...]
>
> >  }
> > +
> > +#if (IS_ENABLED(CONFIG_CMD_DNS))
> > +int wget_with_dns(ulong dst_addr, char *uri)
> > +{
> > +     int ret;
> > +     char *s, *host_name, *file_name, *str_copy;
> > +
> > +     /*
> > +      * Download file using wget.
> > +      *
> > +      * U-Boot wget takes the target uri in this format.
> > +      *  "<http server ip>:<file path>"  e.g.) 192.168.1.1:/sample/test.iso
> > +      * Need to resolve the http server ip address before starting wget.
> > +      */
> > +     str_copy = strdup(uri);
> > +     if (!str_copy)
> > +             return -ENOMEM;
> > +
> > +     s = str_copy + strlen("http://");
> > +     host_name = strsep(&s, "/");
> > +     if (!s) {
> > +             log_err("Error: invalied uri, no file path\n");
> > +             ret = -EINVAL;
> > +             goto out;
> > +     }
> > +     file_name = s;
> > +
> > +     /* TODO: If the given uri has ip address for the http server, skip dns */
> > +     net_dns_resolve = host_name;
> > +     net_dns_env_var = "httpserverip";
>
> This is not idea, but I understand this is how dns currently works.  We
> can take another look on improving this when LWIP lands

Yes.
Note that the prototype of this function is the same as the  Maxim's LWIP port
"int ulwip_wget(ulong addr, char *url)", so we can easily replace it
when the LWIP lands.

>
> > +     if (net_loop(DNS) < 0) {
> > +             log_err("Error: dns lookup of %s failed, check setup\n", net_dns_resolve);
> > +             ret = -EINVAL;
> > +             goto out;
> > +     }
> > +     s = env_get("httpserverip");
> > +     if (!s) {
> > +             ret = -EINVAL;
> > +             goto out;
> > +     }
> > +
> > +     strlcpy(net_boot_file_name, s, 1024);
>
> sizeof(net_boot_file_name) here please
OK.

>
> > +     strlcat(net_boot_file_name, ":/", 1024); /* append '/' which is removed by strsep() */
> > +     strlcat(net_boot_file_name, file_name, 1024);
>
> Don't you have to limit the size of subsequent writes depending on what
> previous calls wrote? IOW that can't always be 1024.

strlcat() appends the string with the limit of "buf_size - strlen(dst)
- 1", so current code should be OK.
1024 should be sizeof(net_boot_file_name) same as above.

Thanks,
Masahisa Kojima

>
> > +     image_load_addr = dst_addr;
> > +     ret = net_loop(WGET);
> > +
> > +out:
> > +     free(str_copy);
> > +
> > +     return ret;
> > +}
> > +#endif
> > --
> > 2.34.1
> >
>
> Thanks
> /Ilias
