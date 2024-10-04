Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8A0CFA74C
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 06:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4771D88F55;
	Fri,  4 Oct 2024 08:53:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YO9mBC4R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8441A88FB9; Fri,  4 Oct 2024 08:53:29 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B14588D7F
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 08:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7e6cbf6cd1dso1183154a12.3
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 23:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728024805; x=1728629605; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LVDdVE14lhC6j76xBltRX1N0gPPX9gzMKDQsb9YQzJk=;
 b=YO9mBC4R9i/L/SPpM/grd9Jiy1UShX+m4RdcD44A/HaOPw+kv0ebJxuy9T+aSZuHd7
 REq+c88v0t0DpYJH0JLWDdeWSWt1P1CEVfIs0MrX6BdP5WcR48/Ai4mShQDq61emkJVW
 VPoor/hx+xZn/P2KV3Kqz/iYaS/5CQi+KW4Vh3TBe+riXs2lPJkxRFDyRXCop98VBqH5
 AM7IMnizDo40DEPm9S3bkU6YUpi0dyU+/tlUitlj2M8Fwlj/s2Xfn9+69vfqom34VS5O
 GTZTtCP9On7SMcQDD1QecFJWDXCrG62PU4OZdakbMSUqFOYGdoI+PhzeXVJIe5jeemYI
 IS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728024805; x=1728629605;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LVDdVE14lhC6j76xBltRX1N0gPPX9gzMKDQsb9YQzJk=;
 b=YFJrtzmK3YfIBABBNCzwQtTy609dh2+pVuF1VOr2v52x9YvdrEp+D5VV2T/IWYd6bv
 ONKzZPY+0sVJb0Jst2IwPzDkWD9KvgyoM+X5YDKD6ZXfexWXdHjDKUfRn7+Oek6Tgxlr
 E4vas5QViYFdUz+hXV8yqaxax4imCqk/338+AbA2VelngrxS4FLg1s80wBY/fk6jOGIX
 oSRPHSwI4Xkqbybx5eP3xJ4T1QEMMHSbYNMCZ6KoDlLV+M5ZzgVpST1LkWXv+WvU2ADX
 m6m9V5vjhm03F/uk0HAdMDlt/Skorb20kvQaPEnYGI6wQ3xEiHoxNwoJzUqYjLFAI2fa
 Hj/w==
X-Gm-Message-State: AOJu0YytGp4TSb5BJOCNrdGsoeIQEtpfQGXsHkeFeKAbNg5IXg/pfjIL
 rOigLDNXDVKRurqMJskj6stt7XT4qXl5TVSENx2qBjG6DZ+dpBPkBM0ga7TJ/G6wv2MB23xlHB/
 TfjwNxodJSlaG66AN9mK+GzjErWZGXWthBsm/CA==
X-Google-Smtp-Source: AGHT+IFBZjEFen/4VOXsW27mFfwQUvVwaIEuPYzNbigOQjBKWq4FewQ70QyztrFk5J2UJgH/10gQBosHOgBeex77pa8=
X-Received: by 2002:a17:90a:2e89:b0:2e0:8e36:128 with SMTP id
 98e67ed59e1d1-2e1e620f811mr2081193a91.5.1728024805551; Thu, 03 Oct 2024
 23:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <bc7f7365861fb75269f30300d341dafea92d76b5.1727968902.git.jerome.forissier@linaro.org>
In-Reply-To: <bc7f7365861fb75269f30300d341dafea92d76b5.1727968902.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 4 Oct 2024 09:52:49 +0300
Message-ID: <CAC_iWj+w7YV3W-hMB+X_pcE8vDs8mTwyo-c7feS0e7nvop8Ubg@mail.gmail.com>
Subject: Re: [PATCH v11 10/29] net: move copy_filename() to new file
 net/net-common.c
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Anton Antonov <Anton.Antonov@arm.com>, 
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Thu, 3 Oct 2024 at 18:24, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> copy_filename() can be useful when NET_LWIP is enabled, therefore
> move it out of net/net.c which is built only when networking choice
> is NET.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  net/Makefile     |  2 ++
>  net/net-common.c | 13 +++++++++++++
>  net/net.c        | 12 ------------
>  3 files changed, 15 insertions(+), 12 deletions(-)
>  create mode 100644 net/net-common.c
>
> diff --git a/net/Makefile b/net/Makefile
> index 70eec8caf0d..a9cecee637a 100644
> --- a/net/Makefile
> +++ b/net/Makefile
> @@ -42,3 +42,5 @@ obj-$(CONFIG_CMD_WGET) += wget.o
>  CFLAGS_eth_common.o += -Wno-format-extra-args
>
>  endif
> +
> +obj-y += net-common.o

This seems to belong in the net-common split patch?

> diff --git a/net/net-common.c b/net/net-common.c
> new file mode 100644
> index 00000000000..a7f767d5e9c
> --- /dev/null
> +++ b/net/net-common.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +void copy_filename(char *dst, const char *src, int size)
> +{
> +       if (src && *src && (*src == '"')) {
> +               ++src;
> +               --size;
> +       }
> +
> +       while ((--size > 0) && src && *src && (*src != '"'))
> +               *dst++ = *src++;
> +       *dst = '\0';
> +}
> diff --git a/net/net.c b/net/net.c
> index 1e0b7c85624..c1d10a77b9e 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1689,18 +1689,6 @@ void net_set_udp_header(uchar *pkt, struct in_addr dest, int dport, int sport,
>         ip->udp_xsum = 0;
>  }
>
> -void copy_filename(char *dst, const char *src, int size)
> -{
> -       if (src && *src && (*src == '"')) {
> -               ++src;
> -               --size;
> -       }
> -
> -       while ((--size > 0) && src && *src && (*src != '"'))
> -               *dst++ = *src++;
> -       *dst = '\0';
> -}
> -
>  int is_serverip_in_cmd(void)
>  {
>         return !!strchr(net_boot_file_name, ':');
> --
> 2.40.1
>

With the the above fixed
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
