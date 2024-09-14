Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35663C35FE7
	for <u-boot@archiver.kernel.org>; Sun, 15 Sep 2024 05:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32C0E88BF2;
	Sun, 15 Sep 2024 07:28:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gGyACv5m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A2D688B55; Sat, 14 Sep 2024 22:06:34 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDE97886F3
 for <u-boot@lists.denx.de>; Sat, 14 Sep 2024 22:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e1a7fa52bacso471770276.1
 for <u-boot@lists.denx.de>; Sat, 14 Sep 2024 13:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726344390; x=1726949190; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fC/lwERf3QJ0x4fU+H0czlxuz66WmLnb68qmGw9n2oo=;
 b=gGyACv5mSadMBVX8Ab3pGXk8/QmDezh9HqTOq4m5ub8hXcOrZqdFdvaOmnQVQPJ0j4
 xknIwlSEHJglH1iRPQmA01U8C1pCOcY288/Cy7jHZR9p8Ov290yL6HVn6HyMHueIW/kR
 lLKREcMazjOM7vm5ujcKpUhudfXLaB6vwLIg+XcX468ySvs/GwKK79SCdgelEJkRJ+pQ
 wLVPa3GjI+FlkhfHgeDbm00gcNIQRF/PPH+LbjBWQ0OvCnGBLpWFmq/JZxUeKNUXtsDT
 9PosssSjYiBraYoc8HcpB+uAPwwqAGe5pelxiCwvEXO57isegIXRvOHY+mwYG+mQhx76
 Qlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726344390; x=1726949190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fC/lwERf3QJ0x4fU+H0czlxuz66WmLnb68qmGw9n2oo=;
 b=wXbu4cf3bYQKbq9PbkLKAu/Ci7qd0tV7kmRT6mqn7NI022+CmXPRGbljpAPgMN1U1c
 MIxXKFawCHfuWZWp4GajSnnGkkqa7T+0ry5ZN4jM1eDhM3T5s5A25Q/xOf5e+dXaJZ8K
 3YSenKdivUKMASFsZbBjYbbJ25RQyGVVbUjDEOyEj0qBHhT7Y0ZD16gtIWf14AdSnosk
 r6vkCoHmMvtlo18WEWC36Jj6a19rC2OAYUQ6Kz75Fm2bLMlZaps00gv3gveLqt85ImeV
 qCkr5CHrnpw3zW2hAUlCWYUb2D7S2VRuGB6A5bB8MX0rr9CgabmhdMumVz8rZj4JsDN4
 zQ7A==
X-Gm-Message-State: AOJu0Yxr3Sff8iOvd0+qYwZGY4tKCsytRlZOxMJirr3m69YkeBUjRqh1
 5fNN3LNcx5biB5DEt75GfXT2gimlO9YxptDUcb4HmXNP9yAbhRtXiaQRVGQWoUwf5Z+8N8yOKsS
 JTJcd1fzvqMj5J5GtZ2kS0gZMow4JDQ==
X-Google-Smtp-Source: AGHT+IFy9LeSX4ED4kD0/6mbjZhT2mfQW9QeVyEMGQw9WdmUqzs4nWAKM5AsNSAIfZDrOnX0gU3jmOnA68e2DSf3PPo=
X-Received: by 2002:a05:6902:2589:b0:e11:65fa:b97f with SMTP id
 3f1490d57ef6-e1d9db9b755mr4135012276.2.1726344389600; Sat, 14 Sep 2024
 13:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240912060649.190-1-l.rubusch@gmail.com>
 <20240912060649.190-9-l.rubusch@gmail.com>
 <c0861d70-afd8-4235-86ad-dee1d8bec79e@denx.de>
In-Reply-To: <c0861d70-afd8-4235-86ad-dee1d8bec79e@denx.de>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sat, 14 Sep 2024 22:05:53 +0200
Message-ID: <CAFXKEHaDrr3zJFjFUhcRfVJ-LSD1psTXkyTKuUktjc3+O2Z7rw@mail.gmail.com>
Subject: Re: [PATCH 8/9] ARM: socfpga: add si5338 clock generator support
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 15 Sep 2024 07:28:04 +0200
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

On Fri, Sep 13, 2024 at 1:12=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 9/12/24 8:06 AM, Lothar Rubusch wrote:
> > The si5338 clock generator is needed on some Enclustra Socfpga SoMs.
> > Introduce minimal support of this device.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >   drivers/clk/Kconfig                          |   1 +
> >   drivers/clk/Makefile                         |   1 +
> >   drivers/clk/skyworks/Kconfig                 |  10 +
> >   drivers/clk/skyworks/Makefile                |   3 +
> >   drivers/clk/skyworks/Si5338-RevB-Registers.h | 441 ++++++++++++++++++=
+
>
> Is there a matching Linux driver which could be imported instead ?

Well, not that I'm aware of. To be honest, I removed the si5338
related patches. I'm unsure about the approach. The idea is to
initialize the clock generator. This is supposed to be done as early
as possible. So, at Enclustra u-boot/spl or similar would be
preferable. In case I'll present this separately.
