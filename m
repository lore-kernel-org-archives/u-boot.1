Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281BAEB64CA
	for <u-boot@archiver.kernel.org>; Sat,  7 Sep 2024 16:02:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8085C88AD8;
	Sat,  7 Sep 2024 18:02:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NvJYMQtJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4373F88B3F; Sat,  7 Sep 2024 18:02:41 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5390488AD7
 for <u-boot@lists.denx.de>; Sat,  7 Sep 2024 18:02:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-536584f6c84so2293729e87.0
 for <u-boot@lists.denx.de>; Sat, 07 Sep 2024 09:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725724959; x=1726329759; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lcqWeRAvY0MmB1ZarKRB3nSM3lJuSckRoU8Wd24AXL4=;
 b=NvJYMQtJ8/KThaOcl6lWYb1uIrV/TjgOET09SwnPZd+98nRWX20rJdbqsQwux4L29I
 tD4AQvuW29VJvGNTNNO+fYClzey80y91f3g8LJY2GIPydxXdoe8UCpVOSKy0Vr7cWUzV
 lNmaRqdPIaXtE/VNGwdHl2dRrKUZwaPqPQL7SI+HCnBFKdMWbhKRssgBlfYucydh/pVk
 qtblm9EK4BT8uEZLIQTOoU8gcw1ZiPLitRoUKDj63x5H9jkdLx6FpKe9ATWDh5ytEbu5
 lR4yftB3UiRQvUlsiFbtL1tD2veYZ6EpmhjxW+1o4CAU6MM5aXZS3fUOPNDd181pyZaI
 mkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725724959; x=1726329759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lcqWeRAvY0MmB1ZarKRB3nSM3lJuSckRoU8Wd24AXL4=;
 b=dhQUcK07ZDkY9KWMTxQSktwKaMuq/sfEfoQYykMZkA29VqZW5jjakysd6BhOfvgtWu
 W82LY9XoMTkPtfYmqnEXNjb2X+qckXCn2bfETz+OBw9exTidFKVIGhSG0Tkt4ZDhk033
 bBAOYo2m91cV9iyHlTfwus5GBsZmDBwNY8NpVGhrLJ93usYTe0VYRetuWE9R3H9NZqO7
 E/FW5xsjzh4YOy0LjRPkowLMn5rX1yxTgTGozd07HYGtjYsypHICHwTyKPuF+X7NoppI
 jh2njJjrFNObAT6K7DQcr4Uf0XFLp2ZEU6xTXWSDMENKqB383UfOLCqTfaouod51rk5a
 z1ig==
X-Gm-Message-State: AOJu0YyKWpmFr1EMuTAvHDXFZJ9gOZ2zW8tAj9BDSmux3r1QCAyXdWYz
 J4adeyS199rnzCaFmecb0kiknVltTGS+0xuEOm/M90Hmgmqoq7vCL75tcAuijhMu5zHFo2RYFKT
 Fo3az/APx07LXOht9HWhytUqJV9I=
X-Google-Smtp-Source: AGHT+IHU8evFdxyr7zHRVxbh9NmhszvAybKOHPd4U8tsZJClz2+M+1uQif3llzYIyUWU2TTrZ5hpe32Z3Ad+zzMMkK8=
X-Received: by 2002:a05:6512:3987:b0:52f:244:206f with SMTP id
 2adb3069b0e04-53658809f15mr3598571e87.53.1725724958337; Sat, 07 Sep 2024
 09:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240905153517.24887-1-marex@denx.de>
In-Reply-To: <20240905153517.24887-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 7 Sep 2024 13:02:27 -0300
Message-ID: <CAOMZO5CAX0FKYZS5e9vbzfWcMmVr-SGe3SH7_DhR5=anTsD4yA@mail.gmail.com>
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
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> V2: Include linux/sizes.h to fix build error due to SZ_64K undefined

Reviewed-by: Fabio Estevam <festevam@gmail.com>
