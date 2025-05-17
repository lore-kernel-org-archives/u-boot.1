Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E0FC2D0CD
	for <u-boot@archiver.kernel.org>; Sat, 17 May 2025 20:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C52181FFC;
	Sat, 17 May 2025 22:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RwQ1FYfj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC9908205B; Sat, 17 May 2025 22:50:53 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09104808AF
 for <u-boot@lists.denx.de>; Sat, 17 May 2025 22:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-54e8e5d2cf0so4034227e87.2
 for <u-boot@lists.denx.de>; Sat, 17 May 2025 13:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747515051; x=1748119851; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VOAvAKVI73za0NRfPZkp/HN5FIMAZViIxW4/GlReLh8=;
 b=RwQ1FYfj3R5kEfeTaUt/vfI1cHp/4Poj1dwTONhANE9xCr2gvJW7fHxLvhIKim+5iw
 k6AJMJbfd5ezhjmx0jR66D8YtNbiabYHjOHIsNNXPRrycZyuGgSLEDbOLhODh7ZKBvaR
 aqKT8gnrypepmsj5hHaNkK4776RLkOKps779NAQBKCHZsbjcdwj5UOUUedpc1lUJahVT
 tDzU2BxWtRy4NkMBgqwTAovGOlybA1BJ+R/okLpbmKJ1PaC1WDzXgdG+yeUpfpayo/11
 omN+uOTdVP/3jQ0G1pY4/WII9mhfeSkftbnM103Civuh3aXWuh/WB9nTEGEyxwPH4bdI
 OnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747515051; x=1748119851;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VOAvAKVI73za0NRfPZkp/HN5FIMAZViIxW4/GlReLh8=;
 b=px1NQ4mdaO5SMvSLFDRdIZoOjHQJLj81xfzX4mcqAWeVl4ET505Sy3Puqv7qbC3hxK
 O6ujsNoG37QwVE3QmBhZC0iQCnXfDYX6DlHrsW23iPUp02zQ9Hl0AkKgdIMVxv+OFiDG
 OPcwtHzVwspbkmwmOCV5ECW81O12SJ/madL6uje1cinMWSi6mbmYjR9HFbD+aq5Un0hK
 wTef0XeoU+za5MunXmIwMgvSJssDKxz9TLPGNzyst8EsvvYwP49nuE4TA+fglhYY5xp8
 OLv7Uy7p/wZJHxDCtUVgfzdfLBaA/xaj5/YdJBThBPgMFfobNqJZg0sCi1RyjnranwdY
 /j6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzE8TPjvU35r7adNkQ1bENGmxbqP97bxHfdrUpQiv5BzZKKnjFxVfhnqWNweJAUHV1HG7zjUA=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+p2Jnk2P3p2DGxQls5xawzjkBKg6znSqkvZo0ZEotgeogV/xk
 cMz2OQxO2rmGve24Ek4STUG/sQkdfVYbJ19D4RQaxtVNetDL0fvyTAhu/SMe4EPRovJ9HzRYb/P
 djFt9vGl4rLYldmarae9S2v0CKz9MI+c=
X-Gm-Gg: ASbGncvFN7a4x9aLX2cSa2CWZ92RovhcFM5vzVQ1NtsTxOzql8Y4z/Eq15DC8f2Ld29
 j+7u+yT0GOR5w0RmuMJcWRnL3RN/uAQWENBjTZrZpxVXOYWU+genp92V+Qlu7ttTF0OTCd+26Yt
 gDLsXg3Jd9a+XUb9mnt/RW4mKQSnJ5bcJX/gmrsZuVGjAlGp607KwboQDXkZXz/1g=
X-Google-Smtp-Source: AGHT+IGG7c2LiE4+DX2oAYx8ieQL304W8ZBlUxjROYiboAtgOftTMG37e8akW8ioZsnpfOShGwO2JB55ie8YhssN52Q=
X-Received: by 2002:a05:6512:428b:b0:54e:859b:b9c7 with SMTP id
 2adb3069b0e04-550e97b91a4mr1344333e87.13.1747515051094; Sat, 17 May 2025
 13:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250515131246.784206-1-dario.binacchi@amarulasolutions.com>
 <20250515131246.784206-4-dario.binacchi@amarulasolutions.com>
 <CAOMZO5DdjRT=qGVd+qLXraud8xC=noioduLvDObd1B-n--7CdQ@mail.gmail.com>
 <CAOf5uw=iBNKu3Qvpa1WoYPy-RoKXM7PQtcdBaXupwrtWAKNAFw@mail.gmail.com>
 <CAOMZO5Ac3NdTu=rWJ4e=YR5t=ck+qbNbf9SH3zikUghqMineMQ@mail.gmail.com>
 <CAOf5uwnfC0nLBy1QhcDe_VpqE9LGh5fKV_Br4_=rZxMBNHw1ww@mail.gmail.com>
 <CAOMZO5AcUbYa0+40jZ=2a1dxO7D+tif82Arkguf_vVsP=CkzAA@mail.gmail.com>
 <CAOf5uw=cb2jQK1f-avqRvYxukYb-Sy-jWDvqEyM+nRLTnXcAwQ@mail.gmail.com>
 <CAOf5uw=099igk1=dEXH6dbUDMSH+bVo67mek_P=+G3Sw-f4B3A@mail.gmail.com>
In-Reply-To: <CAOf5uw=099igk1=dEXH6dbUDMSH+bVo67mek_P=+G3Sw-f4B3A@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 17 May 2025 17:50:39 -0300
X-Gm-Features: AX0GCFv8jVlzbQ9k4S77tlvuahJ6K_PAymoIOKnAKPDiOLOVlm5npNU56FcGbAA
Message-ID: <CAOMZO5BM8y1ojYONMRBm+gBAgQ7ThWarzWZqfrEHwm3fM8_2Yw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] serial: mxc: restore booting for imx8mn_bsh_smm_s2
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 linux-amarula@amarulasolutions.com, Adam Ford <aford173@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>
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

On Sat, May 17, 2025 at 5:46=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:

> > I was on master except this commit
> >
> > commit 128d997a8772cc174f38d529d8b25f90b3aa8ad8
> > Author: Jonas Karlman <jonas@kwiboo.se>
> > Date:   Sat May 10 15:32:01 2025 +0000
> >
> >     clk: Fix clk_set_parent() regression
> >
> >     The commit ac30d90f3367 ("clk: Ensure the parent clocks are enabled
> >     while reparenting") add a call to clk_enable() for the parent clock=
.
> >
> >     For clock drivers that do not implement the enable() ops, like most
> >     Rockchip clock drivers, this now cause the set_parent() ops to neve=
r
> >     be called when CLK_CCF=3Dn (default for Rockchip).

CLK_CCF=3Dy in your case, so this does not help for you.
>
> BTW is really needed now?
>
> git grep init_uart_clk board/freescale/imx8mn_evk/
> board/freescale/imx8mn_evk/spl.c:       init_uart_clk(1);

This can be removed. I tested without this line, and it boots fine.
