Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4E5D75E3B
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 13:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE0D8897ED;
	Fri, 22 Nov 2024 14:11:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CMO9zlC/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B057189806; Fri, 22 Nov 2024 14:11:41 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30729897ED
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 14:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2124a86f4cbso19478695ad.3
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 05:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732281098; x=1732885898; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yvDBKEqbbRT1x/zwgu9gD2I2U8ku7Beg3JArGpHB0m0=;
 b=CMO9zlC/MyFWe3mnDRXlztKbAHkOIB6NGPCT5eXDW00I/UVMcwr+dE6Huzd4ZdKIR9
 uPWlhz3GLuvVoqL+ZfHP/XALcwRULGz97eusNDmhP9NEximVm624i6b79uxrw4CYaSJL
 ekoxea7gcr2BgVnQaVG/6LdY30oxCrTsEDAtdElwIuu3fVXH9ow2IU8L+yYc7Rt6NTo7
 j9MI2gZ2S/4CAbfXIqdZK1leR3cVXDn7chiERXsakZMzq6FdtmRhiS0phZIbgNo2kVKQ
 YKMujwTcAYrQy1hX7dvRG2X3bSTM2ICG6aiDDSY3sbn/h6U4OMm56iliSeiCDnBNjwUv
 1Ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732281098; x=1732885898;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yvDBKEqbbRT1x/zwgu9gD2I2U8ku7Beg3JArGpHB0m0=;
 b=v/Gp0upniFJy49rwYat3Ex/jz94WtEjP4nazrZKr/n7NO/Ke2DpMKVwySZmhV9E+qr
 rFai6JUcjuLFRc5dk+f1OMzZpzAMLDtNq6sXAB8iZ8MBTPSq3GNi/+8jredbMlmA+ATV
 MUSIFlb9feSt/olpm2EAeTWjfOYohk554yq5Q4eo9uWzhsQh00i4yu/TR7vX+ZOaUiHT
 7w5nylw/JKHLu0uy2bfJH9HvHvuQwAq5AI15rXn1zY741XVMSaJYCpBUyqcqBD6h72eB
 ZB6fQSBXOWoHPXgRsHjakPs9VkUMHt+yBN1JsChYAQp93vpoLREpZGzqYalG3aliLTMr
 fYfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaVOE/7YmrzNcjDE0f1LFbxOUcQ1tBUPBm60SQnnEo1l+Odw9hIQiip2mvdBsiDqzt6N5Opl0=@lists.denx.de
X-Gm-Message-State: AOJu0YyD+cZ/Lupzus7ndo5/GlEm9e4sxTQ/Y6+cl+AMYEOB6x6s0IiM
 WUNhzEb34ZWxwZ9ubAQRCVjdR69Ml8G4RBbusu2tCPhmHd30mvM5WnSrwrQGSdVr99pQx4VdZd1
 k5WZv+QwXT0o3LRZqmobL7XTiZak=
X-Gm-Gg: ASbGncszadbc9u3i8J10GtTuYgKNbNUhhHALnnpoJZvUHsSxKHmKBU3sw5REjRZ0FV8
 BbW4x7hbJV/5W1LBuOV2vSUgcxx1ZgEY=
X-Google-Smtp-Source: AGHT+IHfy4NjvWtnnt/lFrgSKFyaGV2lTjbv/h6qULHIQGCm/NPa6epPlP1FXXugqlJfzuLjTg6fe9DnQBG04ZVO3Sw=
X-Received: by 2002:a17:902:f705:b0:20b:fd73:32bb with SMTP id
 d9443c01a7336-2129f730378mr36057605ad.2.1732281097462; Fri, 22 Nov 2024
 05:11:37 -0800 (PST)
MIME-Version: 1.0
References: <20240707082001.20746-1-michael@amarulasolutions.com>
 <20240707082001.20746-2-michael@amarulasolutions.com>
 <CAHCN7xK4YgEt7xaA6Ln3Q3GzvOP-iZM+YtZwP1Hg402VstBcOg@mail.gmail.com>
 <CAOf5uwn4T573-BDegO8giorZXeePbYszuo3dk1TEmdPvY0+dQw@mail.gmail.com>
 <CAHCN7xLgLwSv_EySui38ePeDqOfetWPi5R7dHJs+exVdZYnjHg@mail.gmail.com>
 <CAOf5uw=r=FsRRmD3tgONbxzCnv-rd2DS3d1bvt4zBHgQn1zomg@mail.gmail.com>
 <CAHCN7xLc0hzXmDaES9961jQ6fXtqof093Tga6d6748gxGYA+Jg@mail.gmail.com>
 <CAOf5uwnZeWTM=doUQ1P+OAoq3pnMPt060LtwaXt_Rnj+GBwjhg@mail.gmail.com>
 <CAHCN7xKg2jBJVfhvz2gCeTBgvMVR-mm0b-L_wEQsZBX4z0UHVw@mail.gmail.com>
 <CAHCN7xKCEjwyhfnCi3un94ssONdJjApMVo3FCRAydGd8Co34Uw@mail.gmail.com>
 <CAOMZO5B7Yedk3G022s_Uoqu=8v9Ds5qD+pg+UNjnObcWNWUv7g@mail.gmail.com>
In-Reply-To: <CAOMZO5B7Yedk3G022s_Uoqu=8v9Ds5qD+pg+UNjnObcWNWUv7g@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Fri, 22 Nov 2024 07:11:25 -0600
Message-ID: <CAHCN7xJ1g3KxzbOYJTONZN1z97mSUtjkHkoxyUSAo-g8DWE1hQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] clk: imx: clk-imx8mn Fix nand and spi clock parent
To: Fabio Estevam <festevam@gmail.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, 
 linux-amarula@amarulasolutions.com, u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>
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

On Fri, Nov 22, 2024 at 6:38=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Adam,
>
> On Sat, Nov 9, 2024 at 8:23=E2=80=AFPM Adam Ford <aford173@gmail.com> wro=
te:
>
> > I did some more investigating, and  with the device tree debugging
> > turned on, I get the following:
> ...
> > clk_set_defaults(clock-controller@30380000)
> > clk_set_default_parents: could not read assigned-clock-parents for 970a=
b8
> > clk_get_by_name_nodev(node=3D92a30c, name=3Dosc_24m, clk=3D96fd38)
> > clk_get_by_index_tail: Node 'clock-controller@30380000', property
> > 'clocks', failed to request CLK index 1: -22
> > Failed to find clock node. Check device tree
> > Trying to boot from BOOTROM
> > Boot Stage: Recovery boot
>
> Could you please test Marek's patch?
>
> https://patchwork.ozlabs.org/project/uboot/patch/20241122015858.557561-1-=
marex@denx.de/

Sure.  Do you want me to test it against a specific branch or the
master mainline branch?

adam
>
> I plan to apply it for 2025.01 to fix this regression.
