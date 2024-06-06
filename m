Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34D5C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 16:03:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2A01881A1;
	Thu,  6 Jun 2024 18:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Yk7kkMVe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45DFC88216; Thu,  6 Jun 2024 18:03:28 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1718F88149
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 18:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f64ecb1766so9886945ad.1
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 09:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717689804; x=1718294604; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8hA8XkufnksS06tEwdf8lyb18TG3ZWLdSg2jYasc1m0=;
 b=Yk7kkMVe9yzg+G4xWG9EqeYSQd3FIjv8h6AFguZnwAR9PcVoh/TBf2Tgif0iQxkPqz
 OT+JofLNyfyiagq6xOg9PxC1j7eO7UnPqMaBgt5ycDpGIrpKR51ZF/UIr3clYvMED3S7
 pzI+w7xala3yzvgWHJEXwmhAldb1B8cY+DhhzrVtyi2IkNgbzp0FdlLwkyiCLtlsiy0Z
 0HD3HhwltP6oCRTyH6BYj7jM4sXXmJGkfss9M/nK5ZCj3JDJ5Qclh9kPpVp8qaR5uQNJ
 PUKfpbRwnGSHxs7BX6mbO2u2qlTZXFGsB4bv2ypuG+Wa6ikrNweEuSFLtLrb82f4mrcz
 TPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717689804; x=1718294604;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8hA8XkufnksS06tEwdf8lyb18TG3ZWLdSg2jYasc1m0=;
 b=lxcca2wPH6fiTEQIpq4WK5bYMWMy1VYo3tXPfJuTs1BKy6E61C1/4cwWiFRi1KNXO+
 E3hLt+JskaWGzYGFHo26ogIMZoIufxg0HGWBSJADfDAqYPewk2x/N3Yx6akceqdAzDwt
 yO89asIAozjGxTjLh/49stMKY10BE0f38jJMDFFuKRAJ9DckkgsIQdyKBClBNCpnd8ct
 wQKFZmBU04DNZX6MA58zAYjB6frcL/ONYuI9GomffYAF6ULAMPlHCVkljbKQWftFmEd0
 pp9Fll3WBDWn2t93wz+sT2opBggCMtYlGIqVZUXSyDLEHkgZuyCw7Z/smPyUvC8r1aOm
 33hw==
X-Gm-Message-State: AOJu0Yy0GpRxAG5RRF3zxvE2utfEsK48fqxmojHeLyCGxJdgnXTOw04w
 CCNMINRTmY3DddhPghYwv2hk+JG76Z9mC6+5J9l3sWPkqBBqbAY3y/Qgtd2pSruaxcBKX01d0GA
 Ttp9k5Fg/mvZjDmopRp94bbRfMY8vHz39DmiNaA==
X-Google-Smtp-Source: AGHT+IFQwjNBqa9LjgR/IHAai6aa0dcb8/L5e2Bn/BBWSY54A0YLpHouKmKynq1ZjiReY4vDkygQ2wLNb0U0aB/dJzM=
X-Received: by 2002:a17:902:d510:b0:1f4:466f:8ca4 with SMTP id
 d9443c01a7336-1f6d0223593mr1235715ad.0.1717689804524; Thu, 06 Jun 2024
 09:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1717680809.git.jerome.forissier@linaro.org>
 <a81309b7d6f3a5bbccc7a5ad45b11f071a3f50b1.1717680809.git.jerome.forissier@linaro.org>
 <CAC_iWjJCGv+CCLQ5R8jH8248Pe-mAEihdd_YbUr_Eq2J4iTjMg@mail.gmail.com>
 <590d8389-defe-4297-91f3-f5dcfef5595d@linaro.org>
In-Reply-To: <590d8389-defe-4297-91f3-f5dcfef5595d@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 6 Jun 2024 19:02:47 +0300
Message-ID: <CAC_iWjJJr_mb6=0Yp_FpZN8cK2s_wx9ZpGYHc7n4UtWxJrqhjQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] net-lwip: add dns command
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>
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

[...]

> >> +
> >> +       if (!ipaddr) {
> >> +               printf("DNS: host not found\n");
> >> +               host_ipaddr.addr = 0;
> >> +               return;
> >> +       }
> >> +
> >> +       if (var)
> >> +               env_set(var, ipstr);
> >
> > Do we need this? Won't this set <dns_name> == ipaddr?
>
> No, the syntax of the dns command is: 'dns hostname [env_var]' so one can
> pretty much give any variable name to receive the IP address.
>
> > If we do not need it repurpose the void *arg and get rid of the global 'done'
>
> I could probably use a struct to get rid of the globals. Let me see what I can do.

Yea just pass a struct with char* and a bool * and you should be fine

Thanks
/Ilias
>
> >> +
> >> +       printf("%s\n", ipstr);
> >> +}
> >> +
> >> +int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> >> +{
> >> +       bool has_server = false;
> >> +       ip_addr_t ipaddr;
> >> +       ip_addr_t ns;
> >> +       char *nsenv;
> >> +       char *name;
> >> +       char *var;
> >> +       int ret;
> >
> > [...]
> >
> > Thanks
> > /Ilias
