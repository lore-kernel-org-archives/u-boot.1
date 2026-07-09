Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592A5C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA1D484B62;
	Thu,  9 Jul 2026 03:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DKIsf3tB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F8B584A8F; Thu,  9 Jul 2026 03:28:06 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 197A684994
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 03:28:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-69a50189d25so2357077a12.3
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 18:28:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783560483; cv=none;
 d=google.com; s=arc-20260327;
 b=QB3dyfwO3tHNUm04jGkSzZTcr7oheyBKo8xpGyjkHf4d2T4fmJsZ1fY0Di5CA9kYXj
 11YJrwkpQwByLcBjYi7TZX+/m7NMartN1fHLTJ4PE5egeqloqjrSqAMFwOhRq+y33nJp
 vZ3T0KFS2SViT070KAHGrglCJfN+CwvVlnCiKmY8q7BtVqM3Nc2MRHql8Pq4femiJL00
 2EmT0aIauDOjcbVpX05ZmPZWAPqguwIC6L5PA9Nfd+6GcmPmuGm7Z5Dv+GifnEjyfOfi
 88/8Wd/7soZxdHAcWVYEHgIQ8u9fn6VkR7dKYj4M9bgx7+5LQqJN4wv5DlNpgz6D9Hvd
 a+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tkGH0oYS9lWibLX910LrG+GrsYOF6LUdlgv7Euk48s4=;
 fh=cIieWWq0sQXGIpsmr9XJ7yBzdHRSEPDfzIO+1YmWnWk=;
 b=BMRgV9nN6mThiQdzJn0dX4vLQOk6dIubg5PpFE9yPb38BA9Hi2APrXXrVXYcPQsbeZ
 w8FPusD9x+APIIGMg2fA6TTs9Ur1JgodhgAqcxLtUO5LyNSOoiQof0GlJNZ01iXC963m
 +Yxyesq3lW5A7nXMdCJ6bl6avT201AN+XJLl8J2B50cnL+NRX4jXEQ8mXJwg2IMkD5X7
 O1UoftDMXnZ6leIMDPsyqM8PDj7Q2oLyv71GlhxnPwuKZDF7KhM729On/zN0t/Hmb4Mb
 9NwsyiDXM9oWcNc8gtNrVqIUzfCJMwNCgFhDj4xzTjxxRiHh9pggRwfQt1jtfHoAd16I
 6w1g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783560483; x=1784165283; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tkGH0oYS9lWibLX910LrG+GrsYOF6LUdlgv7Euk48s4=;
 b=DKIsf3tBFpRzoXQDRN3SpuReAg0iu1B8BTG9HnVmWvXDQQOLcITXuBrSSya3Uxukbi
 5uL8CEH196Mta0Utkyu8gtga2nUDIHRieofLW/TC7YybAwUC/LiqN7Yjs/vnL84N5peg
 bFNuXRQev55nAyz8D2m2P2qG+v+HylgGpFrKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783560483; x=1784165283;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tkGH0oYS9lWibLX910LrG+GrsYOF6LUdlgv7Euk48s4=;
 b=ZuY7LT8MvfQ1GA2gndgDBNNGc5p+QHz3c2QdA75KFBPhDGWq4bNVQdbPmqz/KR/89h
 LvrI8CE5wiAa6jeQ7QEoxh4an+j7+5PSL9FhXsbbnCIt1T19oZRarR/59UD3wGX+TNAQ
 RxQtMIIuW7uvmxnJTtaRNr02rPPlJi3pNSneIiOayFckh0SakAKvNEa463pSXZO9PqkY
 KSV4QdWGr8GIxtWBA+So7zoRlwn0Z1yEA+Sc4C4MFz483bT5zY3ddpSHsISD1P28lCi3
 seCCHvq8bj2JDCy0TJwboIekHegQqdSCPhGotFjAMvXSzhKbsqi8erYpoVVqpxUOBEUU
 nBnA==
X-Gm-Message-State: AOJu0YzAFiYlDnOH+qy6KudyKUMpsdSZUmFc2/Op2NiK5/MycqqG+Req
 l+gu8YPXrJTyZGnfN5U+23vwDrJUW1gqcWtRT6ZPrqtJMNdd/qQp7B+9uSTvI2WsiDUU8S0zEgn
 IysCdVTwnhcYjoxvLPUUrbeoOkLHdwWOBWZmAZsso
X-Gm-Gg: AfdE7cnavcluQY2HKHSBxDtjtGhXQWmoJQLlV9Dr9YUurVSCRQGm3eZI82M9SOV2x/i
 T+QhNAi+2KLtWNgqBq24R/j6deQJof4myDT5tvoD44MDmNdmvUWaH4KPKzAFXmrQbWzJ8aZnaoI
 MBm0gEs4dlkWZMQxENf7J4uKxXrb3txDzOhiJyUg0TAl7k127EoLuFRyG5SYecOnAL0YBhVTxBF
 hgFm+al5w4ePwS1dEVbuQ70Ez6QP1fwWtHEUVtO+p6oYNCpZ6ary3dv15YkQdscsOP84bg=
X-Received: by 2002:a05:6402:13d4:b0:699:8397:55f8 with SMTP id
 4fb4d7f45d1cf-69ab4486282mr2025973a12.18.1783560483554; Wed, 08 Jul 2026
 18:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260707153135.2048115-1-sjg@chromium.org>
 <20260707153518.GI749385@bill-the-cat>
 <CAFLszTjyo-Xizh8p_tv6xPLvM+yu_3KCoH6G2J-hCqPn_zKUHA@mail.gmail.com>
 <20260709003834.GI749385@bill-the-cat>
In-Reply-To: <20260709003834.GI749385@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Jul 2026 19:27:52 -0600
X-Gm-Features: AUfX_mxqB38u10q_tuVymOhKyHbf_y8-d9ePqwb0otlB3mvUOu4AxgwEl4zp-Wo
Message-ID: <CAFLszTjyuz_5XyHxFN7Td-r-fyEHf2rhobd0PLPjC7f=vwzZ4w@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 09 Jul 2026 03:53:48 +0200
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

On Wed, 8 Jul 2026 at 18:38, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jul 08, 2026 at 04:36:57PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 7 Jul 2026 at 09:35, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Jul 07, 2026 at 09:30:58AM -0600, Simon Glass wrote:
> > >
> > > > This series adds support for three small Rockchip camera SoCs and two
> > > > boards which use them.
> > > >
> > > > The first eight patches are Fabio Estevam's series adding the RV1103B
> > > > and the Onion Omega4 board, updated here to address the review
> > > > comments on v2: the board patch is split into SoC and board patches,
> > > > the devicetree files move into the patches where they belong and the
> > > > pinctrl driver uses regmap_update_bits() throughout. All credit for
> > > > this work goes to Fabio. The devicetree concern raised in the v2
> > > > review is also resolved now: the devicetree files carried here are the
> > > > versions merged in Linux v7.1, verbatim, and can be dropped once the
> > > > next dts/upstream sync brings them in.
> > > >
> > > > The remaining patches add the RV1106 and its RV1103 package variant,
> > > > following the same structure as the RV1103B patches, together with
> > > > the Luckfox Pico Mini B board. These SoCs have no mainline Linux
> > > > support yet, so their devicetrees are local for now. The clock and
> > > > pinctrl drivers are ported from the Rockchip vendor tree and are the
> > > > work of Elaine Zhang and Ye Zhang. The final patch makes the
> > > > maskrom-mode RAM-boot images work on 32-bit boards without OP-TEE,
> > > > which both of these boards rely on.
> > > >
> > > > Tested on the Luckfox Pico Mini B: U-Boot runs from RAM over the USB
> > > > maskrom path and both the SPI NAND and a microSD card are usable. THe
> > > > board is running in my lab.
> > >
> > > I did ask you not to do this, Simon, as your patches aren't being picked
> > > up until we've resolved the status of u-boot.org.
> >
> > I just saw that email Tom...OK, so I should not send any patches at all?
>
> As I told you on the community call over two weeks ago now, I'm not
> comfortable taking your patches until we have resolved the u-boot.org
> domain transfer. So no, your patches are not being merged.

Do you mean:

- still send patches, they might be reviewed but will not be merged
until we resolve the Concept tree / domain
- stop sending patches completely

Regards,
Simon
