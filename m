Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18314D711D5
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 08:16:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4820C83BF1;
	Mon, 22 Dec 2025 09:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HIkM4qp+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A9F983C28; Mon, 22 Dec 2025 09:16:38 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2513783AAE
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 09:16:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-78fc84772abso11575157b3.1
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 00:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766391394; x=1766996194; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BBuKXajL+BaXZtfNjxx/5dQUtCXsV+i7+JcZLmySKrM=;
 b=HIkM4qp+U0K4FuEW50xrb3FXuDsgGCaC1puR5AHHNGTdiJCe7j1gHYAYFO0z33hiFq
 6HHjj710UJKntyH3f62Ng/t3AI+TWiELJwdF9pJ0y6G23QkfNKvt0BB82KUfNPWfck2s
 JkXNHxxl74DBkB25y6eOwyz1lOik+phTNRgG6m0qGWsGKsr9g/sHbDRzH+Y7WRy8JB1I
 PpQhFS+CtMsOob71Zu6lVgImbfybcYcgsLZi0wGelaY4WqSdYjY4184MyM6rLeXyYgQY
 vyyYiEj8nhIUZNjGcedaEE0NKMdxDaS125wZeVOtF5ykwxsJmDN++Dmfc0typTPnXr2p
 x4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766391394; x=1766996194;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BBuKXajL+BaXZtfNjxx/5dQUtCXsV+i7+JcZLmySKrM=;
 b=l2BM78TpAyUahGbj9l3O1C9E37pUQFakTMFanTDjm4L8elvmiDOlB7jxtJHtwmVoAt
 HQ58TcOaMibi7r8xmWlMWWAfdrSQalLpbMgmjU7xmuiuA8/zwir4PX5uPegZx0JM3jMS
 7o4WuZxRvFyGn+xXIvsr9qVj8SPGyXOl9Nwd/qatEifqJH9j7T/mZKYHFi1NMl759bxF
 k2Xu1RUhWQ8dR95sknw2C6ADLDq9+EbQJWza1uHMVxQLTPYs+WaFhSSuMMV/N29Xcz4P
 BOSqI+hGjLqQ55z0ywZJ33ADdmcbVMSznsSILC7NSbV8DxUVF38eg1bbK0vIkUwjEgK9
 1Hwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmIykljiQRp1QXgCX52ZrjR6Lcw8NJlHHNC7bRAfy/m+5PLqfpii/ODNCXep0k9RqE/VAW4Vc=@lists.denx.de
X-Gm-Message-State: AOJu0YwttdhzhY+a6UFpmyGBO7GisiIk+pBu+t+y468maBOOIFV+9gBC
 w6yd9Tb4L4WrZF2GhdVdj+petRGFF9rGQ2H08kFbySuuZYD3atelw6j5yTCgXRW8U0VQ8bJVpan
 S8bo9LfrP76Xv+LXnzRqjFuPLDAZGpyWe82+NBAWp6w==
X-Gm-Gg: AY/fxX418pkDoy6YTen8ZSXRSceoE0RlbJ63GlRHQh6Vys1faKd5S6FYIz7thE03Cco
 Tp4Gr/SssW5gy19pk4BjW96Fd6E+f0i1qVW7Dxn7hIigjk0rXFAqKx8FH2zxJlzJiVpvk+gAd1v
 WfOT9BgLTfQC9UAXIMUOW8mTDN3JLwuzyrL7JEWe6QWV9wrRatWS2KFltcMXH6pffECh2QYMuYa
 Sp4bDkil5wSquojxi/G0gxdySha4Apl0cE3vF4CS+se/wtB/H7H3dUHbwY735qEXPlJ6cG1aaRp
 JccLlNiZtTNaG3kMZY/3MiFO1Xxb2YcKqTDQPPH6d6pib/YxkAavkIf1YaskgwlSyLOwIs1w7of
 T6xj6ogNemrEeUdNUs6fuFO57i7dJWHmhajC+FxBxra4cKkqbtXPrih+BFm32hzqJhSl/b6QWJo
 5QjotoUqi0H5WbTYe5HiQy+V40q7q+H3mv0ggMz2Q1GRQqD6p41l5HOjpLOjQGxlO9dJeLorduc
 REkzLF6RWB3bqxxY4NgSfgxuhiyuOxwy5nW9XKr3b7HjocH+LHwQ97SCEs3g7uc2ACRtbTP+Qbj
 UqtSabCTB2pOgEjjWCjxh8xwqyTrSWaF
X-Google-Smtp-Source: AGHT+IFF/SEWTCsi3yDSSQWCFReSCGGe8pLPS+QhmjAJzS8X52vcn/SrHDaH0Df/q0SX3zbhq7SpeNE3FbaB5vWkcOY=
X-Received: by 2002:a05:690c:6002:b0:784:8338:ff78 with SMTP id
 00721157ae682-78fb3f4942fmr95850767b3.29.1766391393786; Mon, 22 Dec 2025
 00:16:33 -0800 (PST)
MIME-Version: 1.0
References: <20251220000531.278098-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251220000531.278098-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 22 Dec 2025 10:15:57 +0200
X-Gm-Features: AQt7F2r-WR5pjGRty9LcivT_UCpfKpCOBMMH9qhX_-5fnca4ogPIICAGuDPWIf8
Message-ID: <CAC_iWjK4CDh3UN3P38TL=JV_=EgD8d6+oWqAMMRVECr+BNRpsg@mail.gmail.com>
Subject: Re: [PATCH 1/1] cmd/bdinfo: LMB and device-tree are not related
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Michal Simek <michal.simek@amd.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
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

On Sat, 20 Dec 2025 at 02:05, Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:

> The usage of the LMB library and the device-tree source are not related.
>
> Remove the dependency in the bdinfo output and adjuste


adjust

the unit test.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


> ---
>  cmd/bdinfo.c      | 9 +++++----
>  test/cmd/bdinfo.c | 8 ++++----
>  2 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
> index 20c8c97f0cd..8e2bbfa9c20 100644
> --- a/cmd/bdinfo.c
> +++ b/cmd/bdinfo.c
> @@ -160,11 +160,12 @@ static int bdinfo_print_all(struct bd_info *bd)
>  #if CONFIG_IS_ENABLED(MULTI_DTB_FIT)
>         bdinfo_print_num_l("multi_dtb_fit", (ulong)gd->multi_dtb_fit);
>  #endif
> -       if (IS_ENABLED(CONFIG_LMB) && gd->fdt_blob) {
> +       if (IS_ENABLED(CONFIG_LMB))
>                 lmb_dump_all_force();
> -               if (IS_ENABLED(CONFIG_OF_REAL))
> -                       printf("devicetree  = %s\n", fdtdec_get_srcname());
> -       }
> +
> +       if (IS_ENABLED(CONFIG_OF_REAL) && gd->fdt_blob)
> +               printf("devicetree  = %s\n", fdtdec_get_srcname());
> +
>         print_serial(gd->cur_serial_dev);
>
>         if (IS_ENABLED(CONFIG_CMD_BDINFO_EXTRA)) {
> diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
> index 2b4866a172e..3005c85d4a0 100644
> --- a/test/cmd/bdinfo.c
> +++ b/test/cmd/bdinfo.c
> @@ -191,11 +191,11 @@ static int bdinfo_test_all(struct unit_test_state
> *uts)
>         ut_assertok(test_num_l(uts, "multi_dtb_fit",
> (ulong)gd->multi_dtb_fit));
>  #endif
>
> -       if (IS_ENABLED(CONFIG_LMB) && gd->fdt_blob) {
> +       if (IS_ENABLED(CONFIG_LMB))
>                 ut_assertok(lmb_test_dump_all(uts));
> -               if (IS_ENABLED(CONFIG_OF_REAL))
> -                       ut_assert_nextline("devicetree  = %s",
> fdtdec_get_srcname());
> -       }
> +
> +       if (IS_ENABLED(CONFIG_OF_REAL) && gd->fdt_blob)
> +               ut_assert_nextline("devicetree  = %s",
> fdtdec_get_srcname());
>
>         if (IS_ENABLED(CONFIG_DM_SERIAL)) {
>                 struct serial_device_info info;
> --
> 2.51.0
>
>
