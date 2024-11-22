Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62071D75E3B
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 13:17:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CF0689824;
	Fri, 22 Nov 2024 14:17:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MM8RaZ2n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D5E6897ED; Fri, 22 Nov 2024 14:17:49 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 473D389820
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 14:17:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fb388e64b0so25373071fa.0
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 05:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732281466; x=1732886266; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fsS22XiJE44JXnjwlOrpkPfG4JK/HLdPkBEHsF4MibQ=;
 b=MM8RaZ2n4XMpNShthK9MP5lsmS5UrciqBYc/BaXsVDbw5JTgBCiKUHLwgQDS901dIC
 mwyNzb3x/lIUbHCZMbuaoCMut0njquNzKDlxDMxgmyMNjfepzfAnuLqJ/D6AoiqyGlC+
 9d90n1hXLLv2RsCxptyNi5XmIneq8Byw5suuMAUfsDVEuR/3tWPQvLZ42R8Ht2hNgs0S
 TSgPWBZAmOS9QEzvO+ZP6sNHF2hEEwYME2dMpzw01hbHzmuyu6tofYk5Kdo/mA5WSm8N
 Tb55pUV+QX36Fb2cLZpKVOq8IuoHMW+fsANlDKhWYFg/6PnvMuL+QXJNnbfqc5+3D03/
 i4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732281466; x=1732886266;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fsS22XiJE44JXnjwlOrpkPfG4JK/HLdPkBEHsF4MibQ=;
 b=BnY5oUtiKvsJE58YNJ5L5xL1S5fM+K12Ba/hDitf0O6P2ZMRYKynakDbu3oNVIRM0f
 OqyhnSKypvLF/kpN6gxd+64V9iPOZeULAZeISEcwWUj9DoQxwXZpofiBckR4l+8CK4jt
 hMjf87hP95EN1Vhj9Z3T7GMz4lsNPfzWT2U+tP7Er010r1YY2afEQS/0fYMQ2Lh7FW/1
 yIFE136Go6w5Vk/QLX1nasfRroZyL07tzDolnSkrH6/YCp5qs5XQd3ehkGDYTv9ALqrH
 FsclzClg8/2ZhuH+UHN6SAa5TWZ6u32HHM2JCcqrA5dKv3rP/l3tU8T+5v2+JCIG8PpI
 JNvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPSJvRomddlcRJBuh8/iP2aK86E7d7R/6KmKSW9UsEiYlwHs29Tkt2ZwUZ4DtakeaQcDel+m0=@lists.denx.de
X-Gm-Message-State: AOJu0YymdHb/N/iBvLJsSPWacSV93+lVz5D1CAA9Pzynhwad5D666f4Y
 9ZBkaztBaO8YROBY75LAwpD3Vrvf+QqGtbmQb2KMSyz27W9LmG4VxRSokZwuQBTtoXKgtpp8AoK
 mN4m76pfX5Bq+vn2JxKp5u0SkEdYzLQ==
X-Gm-Gg: ASbGncusAIFfeVPipZnUaYUDl/GxCeGOpdxoGWz+nXAocPQs7e9cpe04RdAplc3Daui
 Pi8bJKwU076WknYcPUUwKgMk+Uy12FdtuzlXmhpJAb19DD14tP1VvX+44KvP+PpA=
X-Google-Smtp-Source: AGHT+IFIAAdUHPIlee9y0mg9TLyx8EFgnlw699Jgzfj8aWb4BZbdkbnhXp5A5i0x75iTXxFY1JYORD72QxxkBjc4IRU=
X-Received: by 2002:a05:651c:503:b0:2f3:b71a:1e91 with SMTP id
 38308e7fff4ca-2ffa711f98amr15513861fa.17.1732281466422; Fri, 22 Nov 2024
 05:17:46 -0800 (PST)
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
 <CAHCN7xJ1g3KxzbOYJTONZN1z97mSUtjkHkoxyUSAo-g8DWE1hQ@mail.gmail.com>
In-Reply-To: <CAHCN7xJ1g3KxzbOYJTONZN1z97mSUtjkHkoxyUSAo-g8DWE1hQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 22 Nov 2024 10:17:35 -0300
Message-ID: <CAOMZO5CcC4UksuwbR=eNb6cp=t5WLmO48q+yb22GiCfyCmo-yQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] clk: imx: clk-imx8mn Fix nand and spi clock parent
To: Adam Ford <aford173@gmail.com>
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

On Fri, Nov 22, 2024 at 10:11=E2=80=AFAM Adam Ford <aford173@gmail.com> wro=
te:

> Sure.  Do you want me to test it against a specific branch or the
> master mainline branch?

Master branch, please.
