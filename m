Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0829C4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 19:23:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30DCF87C6F;
	Fri, 15 Dec 2023 20:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CJNdfFGP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29E8687C6F; Fri, 15 Dec 2023 20:23:35 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 962C687C46
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 20:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-27fe16e8e02so147138a91.0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 11:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702668211; x=1703273011; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VW/luWXRBA0rcZmnhbTG2EpP+cLibkUDOLGCpPeQzbs=;
 b=CJNdfFGPK0b2BHhkYF9KgH/A7Q3rbsO2FPTyxFNq4iSR0w78IC6wAidc52eq0nQRNM
 ZhIH30Leib4NzyH4wvQxGDWSJhF/gGtPhWrvCtq8K80+oEt5nYgIf47a/3Xad1iy48z/
 8i0Qg93WAOu3P0zTZzo0MSL+GZaIgyTwvdN8dowrAwUYmD2ydXmgk9oLZh+fwyngou2/
 BQKzatwyUY6kNj9KPEXGfaj/HCxhsAqpC9pkNFSGhexRaeae0YtlH8HlfeJlWNwI9Ikn
 gcLXo3GXUS2NzyudMTo6eJ0tEIP+hrjWWUxNtGuKC1c9NyE3zpPAmuPpVGwlFh9WqxBb
 LhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702668211; x=1703273011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VW/luWXRBA0rcZmnhbTG2EpP+cLibkUDOLGCpPeQzbs=;
 b=PfLYdmWCBA0D7JsHqHH8a6LJ2Hrs93o/PuytfxyfYHCMsIIWZxpE0CsCK+pVT2AToK
 VfzNNocL2G3RL9++HAL0yt436mXSsPgzOKhOvTy9KERSI00CluIu9ag2roplJgdO4T11
 LgY5+oQdmG7evek4ZNHYmLOonDJLcyAOnxxhyIsjyBlQBNkTG2UbK5ALTDANJxUxMf8w
 zs5dWfG7oJgROlFG/U+iWG0kLJ56y+qnI/YDO4hVSf5CRhacXmWcVECbAhdd9+nk8pgD
 VRcFWSslUDEjksc2nF8OxBa6FVvuVIz439ZhG7N15H43PgPJa5NFxZT4o2Eao5fmCwy5
 C7Dw==
X-Gm-Message-State: AOJu0Yz+9gAVw7sF7DCfm9LWItMfjcd1/2naTj+Sn5hWWonLuFC9jvbO
 /OtPAZrujI5aBiKwFxm/1b/53khiwxsSG7Aufc8=
X-Google-Smtp-Source: AGHT+IEXz/2K2xvPLCfjub3ljvKprPtAe0IQfkmTCXSqC8KOedlq9TG8J6Fz9ZKwEmIPvQlR2mUChZiOZeixDdec6Zc=
X-Received: by 2002:a17:90a:4f4e:b0:28b:3d3b:865f with SMTP id
 w14-20020a17090a4f4e00b0028b3d3b865fmr1369784pjl.0.1702668210931; Fri, 15 Dec
 2023 11:23:30 -0800 (PST)
MIME-Version: 1.0
References: <20220830174932.96360-1-alan@londelec.com>
 <CAOMZO5BJyoxUTBuygdL7tOyzJfRGJT1BQHJ_r0qAD8jYfC+CbQ@mail.gmail.com>
 <20231009094924.56042353@wsk>
 <CAFQdmxK-TdWajPzZnCGGNr_rWKbNL=6gYfmDOKBRxGd9nrHK1A@mail.gmail.com>
 <CAOMZO5Di2RxqmrCW-OYt+b4g-823wrP0JF6Gkb3P7=gMb3kEwQ@mail.gmail.com>
In-Reply-To: <CAOMZO5Di2RxqmrCW-OYt+b4g-823wrP0JF6Gkb3P7=gMb3kEwQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 15 Dec 2023 16:23:18 -0300
Message-ID: <CAOMZO5Cj9WcNKLUWzcNgjUOjyb7DGaTV+WTcSvoMgBPuJobuow@mail.gmail.com>
Subject: Re: [RFC PATCH] mxs: Don't enable 4P2 reg if mx28 is powered only
 from DCDC_BATT without 5V
To: Alan Kay <alan@londelec.com>
Cc: Lukasz Majewski <lukma@denx.de>, cody@londelec.com,
 Stefano Babic <sbabic@denx.de>, 
 Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de
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

On Fri, Dec 15, 2023 at 1:20=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:

> Ok, what about the patch below?
>
> https://patchwork.ozlabs.org/project/uboot/patch/20230703205700.9120-1-co=
dy@londelec.com/
>
> Is this still needed?

I looked in the i.MX28 Reference Manual, and the one above looks a
correct fix. I will queue it.
