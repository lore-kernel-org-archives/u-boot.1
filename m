Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF3EC3ABDD
	for <u-boot@archiver.kernel.org>; Sat, 17 May 2025 20:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEFD18081A;
	Sat, 17 May 2025 22:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="P2eX/tb6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BAB88081A; Sat, 17 May 2025 22:15:11 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B13968004F
 for <u-boot@lists.denx.de>; Sat, 17 May 2025 22:15:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22e033a3a07so32095735ad.0
 for <u-boot@lists.denx.de>; Sat, 17 May 2025 13:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747512907; x=1748117707;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZUgsWCYhKDHfBMirOEzY46lDwOCgRIECBOJlzzgaIjk=;
 b=P2eX/tb6wmAw4bPzIf+Mpfm6loP7XFFdzUWB+d+x6GtxWOdm3XN4qL+WB/mOGtMOJE
 /NT4OYxr8BGXyjnxqTKirkK6MEOUzlX2yNBM9y+Dbg9IgMVgENjxwoa9Gd0RXMKB7C6x
 rp5rQ6KUWjZRSzf5CEED+y7vkW4myi7X/yc0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747512907; x=1748117707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZUgsWCYhKDHfBMirOEzY46lDwOCgRIECBOJlzzgaIjk=;
 b=THIFaV+rC8cZJR4wSuNIfvDRRehjfsnu+2diV3qgo0Ontm0xVRSz1MglpSRnsVqcJY
 tnERepZt7xI20iyVOqEDcJgViS5ogSLZjprGc89J13wyDP+TO/hRr6G/rYd3SDwY5ePn
 WoEiGR2THOF4D6SsHoqOkRdcmY3jXarOlXqnLc8+zpB7Ba99FHrluY9uFCOXSzRhxw5l
 YsxJ/TaVn+a7W47fadn6Q/Ge4BAsWAJYXF5kUC/eJCOdNxNH6xkRoOV//Wa1VggRPwQf
 npfbK2zw3yvG6zQDLU1pDu+/EwUMymHa34S9iNvqLOBUm4yHZLNF9ucY4L968FHpIAfO
 /1eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGK3TNtz4daoeXfP5GoXOLfKQ8OrqTAXBV+9zme/p27YgQx36zJ1f3Y68zlnCaGt31XnPxiaI=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7DzSYCWORAc+zauL66L3R4+lnwTgFNHR8e0501eHWQ+2f/PHn
 jfzY28wnldhJqdY6YJqWvry3yYL3wvw511Q5bEtV4nN8oTB9oBB5LYLFU2CoMRz7F3KhOvt6Hdb
 HFSXkh+2dGRShTlnw9FxasKX3ERbF3k0/1a2IcVM0ag==
X-Gm-Gg: ASbGncurkGwR9hmzFLmo18WZQlLWnIgGNDePJTmGNR8jq3AVsOmstAmDckFN5RnCV17
 3RocMza+Kdvle5kJFafvHjCxsAzb78iSRDiBBLjItaZ7EquDTSzqPjdOQyB50er1C9EwOyZEi1e
 y02AKE/rCaAXv5banFjjKVP4hRJVTynw==
X-Google-Smtp-Source: AGHT+IGC+eorZIeoTLhygRBKrWtxQVAszQe4gEhQ9DcbSdPGhKnjgg8ooVd04Q4TidoUOExOmdpi1rCUQX/8jM0BmWo=
X-Received: by 2002:a17:903:1987:b0:223:5e76:637a with SMTP id
 d9443c01a7336-231d451906dmr117838055ad.23.1747512907150; Sat, 17 May 2025
 13:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250515131246.784206-1-dario.binacchi@amarulasolutions.com>
 <20250515131246.784206-4-dario.binacchi@amarulasolutions.com>
 <CAOMZO5DdjRT=qGVd+qLXraud8xC=noioduLvDObd1B-n--7CdQ@mail.gmail.com>
 <CAOf5uw=iBNKu3Qvpa1WoYPy-RoKXM7PQtcdBaXupwrtWAKNAFw@mail.gmail.com>
 <CAOMZO5Ac3NdTu=rWJ4e=YR5t=ck+qbNbf9SH3zikUghqMineMQ@mail.gmail.com>
In-Reply-To: <CAOMZO5Ac3NdTu=rWJ4e=YR5t=ck+qbNbf9SH3zikUghqMineMQ@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 17 May 2025 22:14:55 +0200
X-Gm-Features: AX0GCFuY-7XTTJ1RuxUWIVk7GzG_fAds99Ozrx1Tszk6GlNQJYTpSR2j4i1KPf8
Message-ID: <CAOf5uwnfC0nLBy1QhcDe_VpqE9LGh5fKV_Br4_=rZxMBNHw1ww@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] serial: mxc: restore booting for imx8mn_bsh_smm_s2
To: Fabio Estevam <festevam@gmail.com>
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

Hi Fabio

On Sat, May 17, 2025 at 9:56=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Michael,
>
> On Thu, May 15, 2025 at 5:12=E2=80=AFPM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
>
> > The serial is not up at that time so we need to buffer the error and pr=
int later. Right now
> > we are working on other fixes
>
> Please share more details about the boot problem on the imx8mn_bsh_smm_s2=
 board.
>
> Does a hang occur at SPL? Do you get anything in the console?
>
> The mx8mn_bsh_smm_s2 board uses UART4 as the console.
>
> The other i.MX8MN boards where we tested this patch used UART2.
>

Can you please point me to an example of a tested board?

> UART4 does not have U-Boot/Linux permission by default.
>

TF-A is not in the game, the board is working fine.

> TF-A enables the other UART port permission access at:
> https://github.com/ARM-software/arm-trusted-firmware/blob/v2.12/plat/imx/=
imx8m/imx8mn/imx8mn_bl31_setup.c#L124-L143

I think we have upstream the fix there. Anyway...

>
> Is the UART clock access falling in your case?
>

If the uart is failing you don't have the console

> Is clk_enable_bulk() the one that fails?

I think that something connected to -u-boot.dtsi if you have tested
with some imx8mn

Michael


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
