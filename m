Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81DAE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 10:57:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D42680224;
	Wed, 11 Dec 2024 11:57:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zzWqGuJG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80DEB8026A; Wed, 11 Dec 2024 11:56:59 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EC478021C
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 11:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6ef7f8acc33so58521257b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 02:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733914616; x=1734519416; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AedkV/er7LGfIfJ6F+P6BglpnpYc4me/rRkOVjN/j4U=;
 b=zzWqGuJGjIAcoaWd5YmvadJ+dV88EUuFDk9bDA4m1VoH/0Wa1RlkuTzEftzaqmCaNp
 GOdQlE+9+RxlngXkAO6LG4DuqZEk5U02nsIumL/dwdrPnEAeO2iB+s0z90SqV02/heRE
 IFF1ow4wwuYDvirslQqjJ1i7McT6i+ySv+e48rJuNDMgiBjA319OS6ZglRzXPpD6E+k8
 lXWdk4/+qx+l68QgB8DYNql4imTXmoLEx5sOf39oww9uFEOUt5CleipxWp/UAYt8rVCQ
 23gxTgNEWkvX1nJyvKmhZs1zPMtdM/66vJiwulv+s20SmqimoOVnQZiCuTOAMRWH5cZk
 Vkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733914616; x=1734519416;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AedkV/er7LGfIfJ6F+P6BglpnpYc4me/rRkOVjN/j4U=;
 b=eotuEUNaGmWI+/osOcdhspe1tZNmXqv6sQBlcb+kKaIANdLKmEmsNRUgwxFmaF8HOv
 ZKf1Mrb+ro22XpX/OIbUWOfQ0rqVIadPguUqhSbgKfWKv9GD3f6z+mH3nBX8INXA9n25
 AGkzoWAasRnxxF8cHZgQXOw8aoymodtmkC0a5MU8q/mUtHG9RSyvINECFDLvqMscIHel
 xC5b/bigz9Iu2y8lF7ONMIlbNcYDjGUIi73C7HbZTqj/rURJbGz5DzNR8au6ljUcE53C
 OS7WySsEveHaYLKHUNc5Os953RA1Aj92Gn1IXFPBtwt23Th0YWvCHjm36pndm+FGyq2C
 R2Xw==
X-Gm-Message-State: AOJu0YxYAML9YCApeNjgTooI3dKAMmt5Keud4Z38NHJj4YRN9+mi836T
 H4wRs4erydzepnnTy4KU+rTpAXsg8lP0DaNrOcozShQWsKpalsJPNVq0zo7AX68mBxGMPs8+dOI
 c3dbIQXVByCZ6VfQ20nGXzdllbo4dFaiKmShrqg==
X-Gm-Gg: ASbGncsd1ihk7vuPOQhhj5KP81pCNMxjDQMu/TVeMra4aaEkRL04rut9AidBlS71xUP
 +aqLR6YPzjhOvC1Ff93xZVaYGwuTvECfS5Jk=
X-Google-Smtp-Source: AGHT+IGcdVJIOmiT94yLrDtiIXpyJ9bClq2tDNg+UrS0gERUvBgox54XyvYlh7OYjoiyNq7ZIltxq5IKFiJB6f4Hqng=
X-Received: by 2002:a05:690c:3392:b0:6ef:96f9:2f48 with SMTP id
 00721157ae682-6f148085108mr27824617b3.37.1733914616004; Wed, 11 Dec 2024
 02:56:56 -0800 (PST)
MIME-Version: 1.0
References: <20241206101132.1094545-1-jerome.forissier@linaro.org>
In-Reply-To: <20241206101132.1094545-1-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Dec 2024 12:56:20 +0200
Message-ID: <CAC_iWj+ktPxQjicOD4_iUGn9wpQnShdVF+AaLGn0VfiJfFn7uA@mail.gmail.com>
Subject: Re: [PATCH] trace: proftool: dump-ftrace should write funcgraph times
 in ns not us
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

On Fri, 6 Dec 2024 at 12:11, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> When converting a U-Boot trace records file to ftrace function graph
> format for use by trace-cmd ('proftool -f funcgraph dump-ftrace'), the
> time associated to each function is incorrectly saved in microseconds
> instead of nanoseconds. Multuply the value by 1000 to fix the issue.
>
> With this change, the trace-cmd output looks consistent. Here is an
> example with udelay(25) added to mem_malloc_init() as a test case:
>
>  $ ./tools/proftool -m System.map -t /tmp/trace.bin -f funcgraph \
>                     dump-ftrace -o /tmp/trace.dat
>  $ trace-cmd report  /tmp/trace.dat >/tmp/trace.log
>  $ vi /tmp/trace.log
>  [...]
>  u-boot-1     [000]     6.719659: funcgraph_entry:                   |    mem_malloc_init() {
>  u-boot-1     [000]     6.719659: funcgraph_entry:                   |      udelay() {
>  u-boot-1     [000]     6.719660: funcgraph_entry:                   |        schedule() {
>  u-boot-1     [000]     6.719660: funcgraph_entry:                   |          cyclic_run() {
>  u-boot-1     [000]     6.719660: funcgraph_entry:        1.000 us   |            cyclic_get_list();
>  u-boot-1     [000]     6.719661: funcgraph_exit:         1.000 us   |            }
>  u-boot-1     [000]     6.719661: funcgraph_exit:         1.000 us   |          }
>  u-boot-1     [000]     6.719661: funcgraph_entry:                   |        __udelay() {
>  u-boot-1     [000]     6.719662: funcgraph_entry:        0.000 us   |          usec_to_tick();
>  u-boot-1     [000]     6.719687: funcgraph_exit:       + 26.000 us  |          }
>  u-boot-1     [000]     6.719687: funcgraph_exit:       + 28.000 us  |        }
>  u-boot-1     [000]     6.719687: funcgraph_entry:      # 37971.000 us |      memset();
>  u-boot-1     [000]     6.757658: funcgraph_exit:       # 37999.000 us |      }
>  u-boot-1     [000]     6.757658: funcgraph_exit:       # 38000.000 us |    }
>
> In the above dump, the udelay() call is reported as taking 26 us which
> is consistent with the timestamps (6.719687 - 6.719659 = 0.000026).
> Without this patch we would have "0.026 us" instead of "+ 26.000 us".
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  tools/proftool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/proftool.c b/tools/proftool.c
> index c2e38099354..af2cdb6d584 100644
> --- a/tools/proftool.c
> +++ b/tools/proftool.c
> @@ -1456,8 +1456,8 @@ static int write_pages(struct twriter *tw, enum out_format_t out_format,
>                                 }
>                                 tw->ptr += tputl(fout, 0);      /* overrun */
>                                 tw->ptr += tputq(fout, 0);      /* calltime */
> -                               /* rettime */
> -                               tw->ptr += tputq(fout, func_duration);
> +                               /* rettime (nanoseconds) */
> +                               tw->ptr += tputq(fout, func_duration * 1000);
>                         }
>                 }
>
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
