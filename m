Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72B3EE2084
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 10:43:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1585C83A64;
	Fri,  6 Feb 2026 11:43:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mLkCZOXC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FD2583AA7; Fri,  6 Feb 2026 11:43:16 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22C5D8382A
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 11:43:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-59b6f04cae6so1959659e87.2
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 02:43:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770374593; cv=none;
 d=google.com; s=arc-20240605;
 b=EuuhtkmufsA1FPyC4wxklhLCJFBc8f2UngHp/3cbeNSw/ZVY0vdCRRgj5/9t7PVi+v
 Ln5CJklDoPXDdWBF1MJwp/2tagiIfMy4yMwwuqx4vzC7aEQAKkicMApod4hf0NaVM5yU
 UxgbEMDo7MmP/mj3XfMrIyN4xFsOF1vqRa+3mBFRstwEr9aAouvwZaOLY7ujKV4jk82J
 2AOa9Pc7j1VXpInw808K26AuaUcwavhGk4IS2HGnp90c5rK3aCz73SLHnA1/lcTjHssW
 RevgFokSf5CycEH6YWNEKZIWilOWVK9TpFIam35Zj5qRlb+9h1xCUZOD/9iCn6g7vHPj
 hPTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oN46g/vPsGtciym/DLU9QwWdkwk4T1kNRhWjtzvcjQA=;
 fh=tgZDYE9j4/7VTyUtEO+EN3louCFgEbOnpDj7Rm7tR3Y=;
 b=ZgSH1hZgsgOYZrK4kU0qfR5LoyaytZ6BLoMJqzMLWKAU/e1pAlshsZ2TOnuz8g8JYE
 iwZqRwvRZtnPnq0yqqbhfPq6ZIb5RRM8lTp1HhBm7vY2H4JbP/plRk/XZfsoJT8oxAiL
 UdNHFrOr/nxUDpXKDlwNbzJtdYVuJCdFPSTCYfK5/upGOw8XJi1bwZkl4zedWmOEDKNC
 wZfSCrrqWwvHzIBWs02oVfVaFhIiJAqBX583HMpGuI+4LobFz+JCX+AW5Mav36818bFz
 e85yGjJGY4mwzkAjtjPEE8ITvysIn4dzkFqp4Jifed12VIH1qelBeBSBsjPEY9p/rhNQ
 uzog==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770374593; x=1770979393; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oN46g/vPsGtciym/DLU9QwWdkwk4T1kNRhWjtzvcjQA=;
 b=mLkCZOXCRGEsIowLG4pvyNs7NyO/6zVZx1L580p472X8kHvCPABp3ZVg9zcvATNIli
 tfbjL5L3xAf1cSbtjUaIIeveXtkp8P672RPy6jL83SUtMFNEOrZkS9gl1mTo9t2Igy/Y
 Vxg+Qi1E9ut7CHuQ/q3P2HV1VZ3/jNRS3uEd9SBLKqfSOKdm402ecXz0sDbGg2uWmJLA
 O4rUufO9Rn7aFwFwk/2ohI/cGTFhVBZaZfOqCX866BYI5jx3FwjLcFx53KV6FXG5CcIv
 3tcTKsm4dXX0wLn7zuaizCLqKChwLm2Y4d47BO+C8SZGeFU+tWC7pbXydOJzopBjCDRG
 LulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770374593; x=1770979393;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oN46g/vPsGtciym/DLU9QwWdkwk4T1kNRhWjtzvcjQA=;
 b=SYqStY2cYdwlNXN1ldehgikmhtKsd9suKNcXHEICCglxfXYg8Ce+JTQgISmOerAmQf
 Y4v1NGfg+6GJdhZMLB6Cvz1iVzdMYpkEBvUM0YhyuKnRonV12nLQb0re4f8/YIWgbEYW
 G2FeDlMILe1JaRIBOpNKEM3i5Z3fvx00ByfI1gEg5M5J77PAgopLsgNhM2F48eIYJpPZ
 orKgb3Z/cwsHe1ih8IMF02FFbr+qTB83moLDKwx+KFEANbUP2QQCnvzkdikpIMgUuY+T
 x1GsxENfnXWSgSVd6KKZ10wt+1OeVP75AwcScdwUvBiICXEiIPMNUwtiWRv1NRcXD6xZ
 JTMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaaLa3wrH4yzMwT8oHx59V5c07cGbGKytf8xd+VN8GXhtNw3YDFIuND8rcTWRw5vjWP2Tv8GM=@lists.denx.de
X-Gm-Message-State: AOJu0YxJxQzS0HEMlujJkM7JwYn4QyTXeVUSb6uIAVdTKMWmPgmqqZzE
 xBfZtHm+yt/VcYhbcyCECDSD37WJ1b8BeXPDDDWb79UfXU3rUoAaREb5jx5RNJwy0hemexZX/ci
 O0oMXQfwY8tJd97+BflOpTdswlkRvdeY=
X-Gm-Gg: AZuq6aJcAPMHgtOdg5AxS+qgkSedSkd0cQooVpMCpdirvsArApofaCBIcALd+Njpn+5
 imSwg+Gr6VPDKqM0sZn6iPvjzY452UHygYe7cOrZIDgPeq7sy5jl+jNyhA+8jH6TyzVG6cY+n38
 XeFTQ2kUQPLtbqKcGpxVjQ8nghqlTfUU+z7Nx8kkC1s7LgUE3dYD71T9wDTpwUPzYsVyaldZdNe
 Hvs+SL5hFQYe1zFf9LBPV6D/WTiPIiNRPrdnRr3R0d93b8l13S6L01aMsnfoAXtqidgbKtYH/73
 xRxFvOkFDnVxu+fK6oRzYchG04JyZ8ASEzHh1w==
X-Received: by 2002:a05:6512:23a4:b0:59b:7c9f:625e with SMTP id
 2adb3069b0e04-59e4516ebd8mr684446e87.44.1770374593021; Fri, 06 Feb 2026
 02:43:13 -0800 (PST)
MIME-Version: 1.0
References: <20260206-imx9-board-clean-uart-v1-0-3965b4e7f79d@nxp.com>
 <20260206-imx9-board-clean-uart-v1-1-3965b4e7f79d@nxp.com>
In-Reply-To: <20260206-imx9-board-clean-uart-v1-1-3965b4e7f79d@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 6 Feb 2026 07:43:01 -0300
X-Gm-Features: AZwV_Qid72SaKASyy6seQQ1kEyQDZu21rhPldOxPmrwygQf6YZo4A-tBw7teRqI
Message-ID: <CAOMZO5DovEGrWOWYbnJuNLpcHtZCH53rZ2mZOrYRF+fyON_Phg@mail.gmail.com>
Subject: Re: [PATCH 1/2] nxp: imx95_evk: Drop init_uart_clk
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Alice Guo <alice.guo@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
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

Hi Peng,

On Fri, Feb 6, 2026 at 12:11=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:

> diff --git a/board/nxp/imx95_evk/imx95_evk.c b/board/nxp/imx95_evk/imx95_=
evk.c
> index ca1d916deab..9cb69543f0f 100644
> --- a/board/nxp/imx95_evk/imx95_evk.c
> +++ b/board/nxp/imx95_evk/imx95_evk.c
> @@ -9,9 +9,6 @@
>
>  int board_early_init_f(void)
>  {
> -       /* UART1: A55, UART2: M33, UART3: M7 */
> -       init_uart_clk(0);
> -
>         return 0;

Can board_early_init_f() be completely removed from the board file now?
