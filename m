Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3148ACA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 07:43:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB32F831EA;
	Tue, 12 Aug 2025 09:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RS8ybCL8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F1BE831C2; Tue, 12 Aug 2025 06:00:06 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41B3F831B4
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 06:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ejona86@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-455b00339c8so31874995e9.3
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 21:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754971200; x=1755576000; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0c1GMSRzJgw1VyGTUJNouoNdUcXSTz0PpZU4PZzYAas=;
 b=RS8ybCL8uUYfUfMcSXlFfmhzH9spY20ncpe9FV3ebW4M/7pGcY3y0/CirbqNC//TXe
 yo80HtFqcVduvvCJzSwH9owHDdT3uVz2UIvYlEAQHRM0qdJ2tiAlS6b2y2gXOOYdNvyq
 Dqji3w1bfCEcKwBn/R8KowLPOS8vxfTyOh4pLwIyC5JDiWCTZeDLgqWSvE+YFevOvDkE
 iM7lpfNhIBk5e9TxSFKOCBbIlrUicj+7T8NOgbGDTS5NJIHJEA2/7hBKXPaknD0FSKE1
 GT5akz8agdO+WH31Tq2OVQltpvJy0Aw2CbkATCsgUDanUrfcbxwVv4xvSP+U9swVCHtI
 oWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754971200; x=1755576000;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0c1GMSRzJgw1VyGTUJNouoNdUcXSTz0PpZU4PZzYAas=;
 b=vVH7glfbKJlm1G0c2MdQGDl2+cKcZ4dc6+VniQWLjc2+zXdzXNbW02srAFs+kRBWxP
 mKKQlpC6jP++//O8ONi0gJ/cLFTFCNaWjM8UgvWdGSQO4McDnYOAFkhX3yTmsyg9p0aZ
 sSXq/jQp54ij5kkJ0NFNDOMdEjGUbOTM4Iy6pnuqjySrA4lohnyn3poV0cE1WZ8EMFI2
 7RPUtI/UIf3v8TbZQfzo5HUFige7I/Q9mzLl/SlnRPR7hFnVuHh15o54o2LFwqR2LSWs
 BebmynsuXu2IYB62COB9n+dCer11t+HtaAno9+ndPVotDDk4shwxnNnrCmq4vhTyA+6O
 QKOA==
X-Gm-Message-State: AOJu0Yz/rEO6tp32aJeJfGqL2zMcWMlKJvhmnwbMBN8/+s7CkSLBtDOR
 SzZQYbkMRBDm/zTihrV+z9KrRwzFme2Gf+1MZSz+Yn9z6x2tZ2ELi84d7N4htVErLqMoE86brPz
 qoX30yCCgrYNlyepub40O2VFtG/26C6sZQHtI
X-Gm-Gg: ASbGncsYM8CW/v1rYuhVq71B3C1brCzLGo9BiejiUjwKARNbUWmRcU7wOSFL2uUjo2e
 zNjE30vBrGvwqZNGR1HTZLHbfgMnU7YMPQt4HWCoCQMDc/12Bfxq2NMOoGdKWmFmJzhpnWprVXZ
 hLxyn4/2NK2iXohDJbKQ2tuMX+OD1gQ0kYlGVeFwRht0rf4S9zD/0d66UEUSz4/kMKRBK6kn0fc
 8XU5vgfuZ7aKfkA0DM4st32uLTWr5ZjHtjH40mw
X-Google-Smtp-Source: AGHT+IFAHjifxEPFvVM9RtM81jQ6M0pqG97zHgGcyrSvgAJHJSdAmE/eFdbmTa6DzZMNTZx9s5GL1xb9M3rQXLygrJY=
X-Received: by 2002:a05:6000:250a:b0:3b8:d1a4:bab9 with SMTP id
 ffacd0b85a97d-3b9110323c1mr1444691f8f.45.1754971199470; Mon, 11 Aug 2025
 20:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250713002741.367252-1-ejona86@gmail.com>
 <20250812003057.0068a65e@minigeek.lan>
In-Reply-To: <20250812003057.0068a65e@minigeek.lan>
From: Eric Anderson <ejona86@gmail.com>
Date: Mon, 11 Aug 2025 20:59:48 -0700
X-Gm-Features: Ac12FXxskpIDlwSu6B_XSY4PEZxpved26US70OVdyT5AWMcq6rZnhhkVR2K6L7w
Message-ID: <CAFyMnzY1+e814mVek2GczOpX16TySVT2mdAvbt3x7jz3JVAdBw@mail.gmail.com>
Subject: Re: [PATCH] sunxi: Enable SPL/SPI boot for OLinuXino Lime2
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, linux-sunxi <linux-sunxi@lists.linux.dev>, 
 Stefan Mavrodiev <stefan@olimex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 12 Aug 2025 09:43:35 +0200
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

On Mon, Aug 11, 2025 at 4:33=E2=80=AFPM Andre Przywara <andre.przywara@arm.=
com> wrote:
> But actually I wonder why Olimex has two different DTs for the
> eMMC-less boards and the board with eMMC.
> ...snip...
> So I wonder if anyone wants to clean this up, because I think we would
> only need the A20-OLinuXino-Lime2-eMMC_defconfig,
> A20-OLinuXino_MICRO-eMMC_defconfig and a64-olinuxino_defconfig.

I had wondered the same, but expected I'd not understand. Looking just
now, it sounds like it doesn't mix with the NAND variant (-n8G) well?

https://github.com/torvalds/linux/commit/27dd9af6bc000ab21fdd41e58e3dddedba=
57ab92

It looks like the emmc DT has gotten slightly slimmer since being
introduced. It doesn't seem the eMMC DT turns off any part of the NAND
DT, so I might try to poke at this some. But I don't have a NAND
version of the board to fully test.

> >  CONFIG_SPL=3Dy
> > +CONFIG_SPL_SPI_SUNXI=3Dy
>
> This needs to go further down below. After configuring for a board, run
> "make savedefconfig", then compare the generated "defconfig" file
> with your ..._defconfig version (or just copy ./defconfig over).

Oh, right, the tooling would know the proper order. I just sorted it,
but I forgot I had wondered earlier how things were ordered. Thanks
for the explanation.

Thanks for fixing it up.
