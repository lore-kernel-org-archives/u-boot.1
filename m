Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3D2C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7E7884B01;
	Thu,  9 Jul 2026 03:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fKls4ahL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BB9084AB7; Thu,  9 Jul 2026 00:37:13 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4C2E84A1F
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 00:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-69a0ccd9669so1271428a12.0
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 15:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783550230; cv=none;
 d=google.com; s=arc-20260327;
 b=mB+EfPdFFF8HOUQ3nPMpht5gQbXuAZj1v1v4NdvgXmM79/dE3aQqoLxYu0skh79UDk
 NmqJATCvuGnKYkItEZeXLmvFCKgtkkKHKN9llVBDzjIgKxGbwG3eZSee81KfmJWJ9moI
 ocS3ZFyoHCN/00wNFMzUMInstLmEMmcBuzdx78vY9WSAZp0NboIICPReN/Z3hEy3pyAA
 CfQ4fxfpiXk/9rvZWQpjkxF0+VoE91vQspigc8XstgN6yzz3PpZNt3uEOJJeNaiRA3kX
 AuGTzGnpzd6Nv44DIKwBdX9fYQC/8PcU/ap3HfE2cdbBl2MY4qWrAj0xo9xVyIEG0sHW
 4fnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OiO3rrTJjA4MLY2tfqjel4jrOP0HnD23U2Z7/xk4FsY=;
 fh=cIieWWq0sQXGIpsmr9XJ7yBzdHRSEPDfzIO+1YmWnWk=;
 b=VhME/n616r4q6JIdZHE0ZsSpfI0aPYfnk3n6ASnLalTJaiRk1XNFnIOHLmcsgilsOU
 xy28Jshi8sNmU6khC0nM8dN+a+O5sf+d2h9IMjDYyTyYAUSZxNBmTLqTTN6WFERfkT8P
 8owM4pt66ce7wOOuaIEyx64tZLDBsrkJWVVNBsfXvRZnbAQj9XzBWBg80MGBdhiOQ4QV
 21XumrJXE724iCZ2BsKKRMe8DkCXZGayQdl4gtBxfu6cQ9qhHad57uxnz7wAnGNGwgll
 oZOwg5qkGuCmKqXVk0sdMaDvnI/Kud8dKj1gTIac/ac8ZvKmU6+88+eOowhbhu4eE8gy
 Ut7A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783550230; x=1784155030; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OiO3rrTJjA4MLY2tfqjel4jrOP0HnD23U2Z7/xk4FsY=;
 b=fKls4ahL+UcWd7GnYYW2ujbsq8bc7c71Lws3UXcfQ0B0NDRXGuYHtmkapBbH9hReS+
 08fMU/6QkAzGMHetblwWRiH8UlmMy5VX+vXWmpzHxDz3JuBdr2by4W8U+qGIgmiI18M5
 ayLnE2Z/j1b5NaIAo72ztmton5i0+yrIkOidI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783550230; x=1784155030;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OiO3rrTJjA4MLY2tfqjel4jrOP0HnD23U2Z7/xk4FsY=;
 b=bIGbXsj6/+b0GRmpXyi62YuB6yVx0cWEDXs+7BCaOwrikbo9Vum6YZvX2fK6pIzhZT
 YBxYLChmPXHzH89hv8shYdzODojRoM/LYrFDnX5+nYnPW2tn88jhairFjEXwTEvJnfcW
 +sc9S0gIJ1LzGGP/w3Y2NaQDkOGWdd1DjigWcC4uRVliL61Z9OyzDORKkB40Z2x9vFJF
 k7GHrgRwUyH2+yMj6aktOt6vNeeZNYqExv7t87DvsAgoNpkYmTsBvv+giAP6PCm5fXT9
 atN43tlzKFRNmS0nAEUqZ3FoR+VFQxnZwWCm6xJTzkNay2cz3WJWCJRivZSO1nF7RfbQ
 TXlg==
X-Gm-Message-State: AOJu0Yz5SFGe0lEuV4iIMvtO93mm6O3/Cn7Xu3yeWoTLbM47LX5eBOJy
 epS6PPgx2XiR1AxsJCnhxfKHq4hSodAKux7v+q7cCj1or9b6sKYbnLSpOirzEwXvQbVysKaMLB3
 1fqVNFuQ62e3wnAmN4085T3B/srVIFiGgZpCgngnC
X-Gm-Gg: AfdE7ckjflxxC/Sa533bJxQSVjuhKkE2shffvN6ncsNhdl/dwfbmmOJZ03ggD716hcU
 tYWDvTwv4Y1z/Wd7ZZuoymSDJB4J+eKKFifORcdtyekwsGtbyukeo7S54lT4GirCblsqlv5vR4U
 4Lr4loYvI7bt9mtv0ciXizhz6rsXCtNzCcip/+tL4fsNOKhuYgLQwQczvV2mW7yDUD9GdBQjilm
 fssSms4cwIXBkGbOER5q2ISkMiAbKIJQTrcvWC4Q/ry7/F+emZUvu2SumDW3u2aI++5XJYk9WrG
 tm45j4TmzSYpZJrqSnI0e1QO4PBwFc1yYdFtEoE=
X-Received: by 2002:a05:6402:320d:b0:698:50ea:2d97 with SMTP id
 4fb4d7f45d1cf-69ab449f344mr1818365a12.20.1783550230239; Wed, 08 Jul 2026
 15:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260707153135.2048115-1-sjg@chromium.org>
 <20260707153518.GI749385@bill-the-cat>
In-Reply-To: <20260707153518.GI749385@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Jul 2026 16:36:57 -0600
X-Gm-Features: AVVi8CdJ6h-p4ImqQOxfaezXpuU27TWRj1eD_u1GAYW23VCpFqONXde_NH2OJnI
Message-ID: <CAFLszTjyo-Xizh8p_tv6xPLvM+yu_3KCoH6G2J-hCqPn_zKUHA@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] rockchip: Add support for the RV1103B, RV1103
 and RV1106
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@nabladev.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Albert Aribaud <albert.u.boot@aribaud.net>, 
 Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Alexey Charkov <alchark@flipper.net>, 
 Alexey Charkov <alchark@gmail.com>, Andrew Davis <afd@ti.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Chris Morgan <macromorgan@hotmail.com>, 
 Chris Packham <judge.packham@gmail.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, 
 FUKAUMI Naoki <naoki@radxa.com>, Finley Xiao <finley.xiao@rock-chips.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Hrushikesh Salunke <h-salunke@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Niu Zhihong <zhihong@nzhnb.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tianling Shen <cnsztl@gmail.com>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Ye Zhang <ye.zhang@rock-chips.com>, 
 huang lin <hl@rock-chips.com>
X-Mailman-Approved-At: Thu, 09 Jul 2026 03:53:48 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tom,

On Tue, 7 Jul 2026 at 09:35, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jul 07, 2026 at 09:30:58AM -0600, Simon Glass wrote:
>
> > This series adds support for three small Rockchip camera SoCs and two
> > boards which use them.
> >
> > The first eight patches are Fabio Estevam's series adding the RV1103B
> > and the Onion Omega4 board, updated here to address the review
> > comments on v2: the board patch is split into SoC and board patches,
> > the devicetree files move into the patches where they belong and the
> > pinctrl driver uses regmap_update_bits() throughout. All credit for
> > this work goes to Fabio. The devicetree concern raised in the v2
> > review is also resolved now: the devicetree files carried here are the
> > versions merged in Linux v7.1, verbatim, and can be dropped once the
> > next dts/upstream sync brings them in.
> >
> > The remaining patches add the RV1106 and its RV1103 package variant,
> > following the same structure as the RV1103B patches, together with
> > the Luckfox Pico Mini B board. These SoCs have no mainline Linux
> > support yet, so their devicetrees are local for now. The clock and
> > pinctrl drivers are ported from the Rockchip vendor tree and are the
> > work of Elaine Zhang and Ye Zhang. The final patch makes the
> > maskrom-mode RAM-boot images work on 32-bit boards without OP-TEE,
> > which both of these boards rely on.
> >
> > Tested on the Luckfox Pico Mini B: U-Boot runs from RAM over the USB
> > maskrom path and both the SPI NAND and a microSD card are usable. THe
> > board is running in my lab.
>
> I did ask you not to do this, Simon, as your patches aren't being picked
> up until we've resolved the status of u-boot.org.

I just saw that email Tom...OK, so I should not send any patches at all?

Regards,
Simon
