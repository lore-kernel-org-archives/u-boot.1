Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960FBEE57F6
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 23:26:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F15BB88744;
	Thu, 12 Sep 2024 01:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NBvVxq9D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 069D488CC8; Thu, 12 Sep 2024 01:26:35 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 183B7886B1
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 01:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-53653ff0251so438784e87.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 16:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726097191; x=1726701991; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HALuJyfGm9GxTJ1N8WxPkdk2meaD6OPqD9U5XM7cmsw=;
 b=NBvVxq9DYu7coWbLiumMKR7Eq2j7PFl4gbNZLBIvRuo9xpi1SYZi8yvw3Nd0xDoGC6
 RUh2OXzeWPk/3TCSnw/4zOExbNbi6VvuBJPTNSZWe9IB3KZ7oTNP6uBSmHhn1h4i1USj
 Y7YI17rzZLD4BCsG+SqgZhOE87ln3d/CrjPi/9W+9LhtVpZ0iQ22yfaABWiNqmY/0WV6
 rP9ImAiBp6ERz9iB7YOTOB36AHDnB0hC9/26v4YAwEuC4kdNzfRzlUr1ia8J5gkjFMX3
 TpOG1kDP26Tc+rhFWeAymjdPVqivVkdByhD9hG5B9gZdk39q3FL2TboV2wW2/Pkf/mLH
 txhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726097191; x=1726701991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HALuJyfGm9GxTJ1N8WxPkdk2meaD6OPqD9U5XM7cmsw=;
 b=xPd7gEjhjGVXzaDjds7f/HsUKMwFCpC5yI7RpRq9GXuhr5/SGa1MxVGzcoAi+BNTRz
 it2Jt0/E0udusM5WyV6O3vTV+347VeN2enP9pknFRDO4mQaGvTWVDgP4r3JWb9fPfuWm
 5zfcod130NPytQ7trMwdZl/Xv/jgwu3JTHYPLAvSMbsYC5Gyia51pCsbEq42clKH++VB
 nNy2nkZOWTBX3GA9z4LI+RWrBHNFU5zubYGSCbYXbQFGkw8YIEmU1+xLvREFmpuuTbMl
 bfNT1fWDkUwTEV0HFoLKp0JXLqijMF6Uu6Pxrb1wxu763cLV/nyFartRClVdi77d3U8j
 B3hw==
X-Gm-Message-State: AOJu0YzdK6CqHbdEfob/+lgYg4RRQQh/d5L/kAF4fgdXHBmEceHXzgCt
 lNMvB9Uood/tB49eDU7aO5bbYpUPwK6AigXrMST7tfvCTpkV6VX58VmhsubhT1iy9lxARP3hTd+
 jsr6hfLzQYzuwFKEvRkOUYR+MY/g=
X-Google-Smtp-Source: AGHT+IG+7R6KIVIW/ynuvYYzbunllnbDWl7vQJu/rGwkhikNYAxuU88YZfTs6jXZXXpnNEQk8IWcHW5xFmHZPH2R3Sk=
X-Received: by 2002:a05:6512:304b:b0:536:54df:bff2 with SMTP id
 2adb3069b0e04-53678fec625mr499234e87.54.1726097191232; Wed, 11 Sep 2024
 16:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240905153517.24887-1-marex@denx.de>
In-Reply-To: <20240905153517.24887-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 11 Sep 2024 20:26:19 -0300
Message-ID: <CAOMZO5DSPgqsRjG_8UvM0zXTO2Z_hb8R_0gUyv0JAUAQwQntxw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: imx: Enable MMU and dcache very early on i.MX8M
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>
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

On Thu, Sep 5, 2024 at 12:35=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Enable MMU and caches very early on in the boot process on i.MX8M
> in U-Boot proper. This allows board_init_f to run with icache and
> dcache enabled, which saves some 700 milliseconds of boot time on
> i.MX8M Plus based device.
>
> The 'bootstage report' output is below:
>
> Before:
> ```
> Timer summary in microseconds (8 records):
>        Mark    Elapsed  Stage
>           0          0  reset
>     961,363    961,363  board_init_f
>   1,818,874    857,511  board_init_r
>   1,921,474    102,600  eth_common_init
>   2,013,702     92,228  eth_initialize
>   2,015,238      1,536  main_loop
>
> Accumulated time:
>                 32,775  dm_r
>                289,165  dm_f
> ```
>
> After:
> ```
> Timer summary in microseconds (8 records):
>        Mark    Elapsed  Stage
>           0          0  reset
>     989,466    989,466  board_init_f
>   1,179,100    189,634  board_init_r
>   1,281,456    102,356  eth_common_init
>   1,373,857     92,401  eth_initialize
>   1,375,396      1,539  main_loop
>
> Accumulated time:
>                 12,630  dm_f
>                 32,635  dm_r
> ```
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied to u-boot-imx/next, thanks.
