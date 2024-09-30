Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAADECE8359
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 15:07:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55E9C88C7D;
	Mon, 30 Sep 2024 17:07:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mZf4Qve7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D76188E56; Mon, 30 Sep 2024 15:08:00 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C18D88E63
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 15:07:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6e20a8141c7so39842587b3.0
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 06:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1727701674; x=1728306474;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I07UDFo2c3AKz30udHA706rmDftWknYWG6Tamh7HJ70=;
 b=mZf4Qve73e4WAw27ooyFuL547OvmPOqGqxaCgE77sQXAI755zZ079ySkyUiEXFG7qh
 o0bXN+057BM/uZVdO5NwMxvX1UkwFxNlITq6rUhGYzTHvOUMDw//4pxqTHKozsLKVnng
 LmPFvki2BUR8N9e60P/Lv55ygC6kjINbJg45w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727701674; x=1728306474;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I07UDFo2c3AKz30udHA706rmDftWknYWG6Tamh7HJ70=;
 b=eLjJPLKnR+8ktV2zmQCNvnM43SCTiGX7cexx6Zzu6B7bcxId+PuCLbIxpIFD0EuoAD
 Ap7JpH5wJuDcBfsQr+A9KFZyc8/DH6giq5myQh+vcDfllstKGZ+7DfjA0wHbbrgu8/dr
 ufuGjlFh4L4NQjYcpE2kqiVX3ASDDw35KZ6lVWCxONKcQ/4YeVHGGpBute3D0nnKehMC
 lltylivY/tA8MYxqbBmfEZcWiZc1FpTppcOeMMT330/Ht23/jL/UEv3fhSVhEGjcARZU
 mTAgWhzhE+zYULAbNKzOurGTCVUsUdDDBkyfPBjTbaGugIrwa9X0BIqTJLexpNufB0I2
 t/rg==
X-Gm-Message-State: AOJu0Yw+oNnzm94+A5TouvY6BfVwtbJ0c+z1PLE8t0G8BxKZv0s59C14
 D//jF2szteiV6LEdGxM6miry+rQuDUxkSNnJOcaDgqsoAbJE9saCrr2xmqhS+EpaB56FBsOe9OI
 WP93DJGlwJ/MtwtqBPwgl2H1VFRtSDBb7zySRPA==
X-Google-Smtp-Source: AGHT+IHw2/Q8ksjFGnypQOBC/C8iwHFm00NOCjspvi00Cs4y+DxvtZ4oypo69D/InSZpLUWBwYD/ga+ugxy0VkQ7y4g=
X-Received: by 2002:a05:690c:6788:b0:6dc:97d6:bf7d with SMTP id
 00721157ae682-6e24754dfa9mr95018177b3.10.1727701674303; Mon, 30 Sep 2024
 06:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
 <20240930114314.30b9e1f5@xps-13>
In-Reply-To: <20240930114314.30b9e1f5@xps-13>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Mon, 30 Sep 2024 15:07:43 +0200
Message-ID: <CABGWkvo24fJnyQMau1y2K543mfwFmRdzt2OwTSvbTjv==Pa_OA@mail.gmail.com>
Subject: Re: [PATCH 00/26] Support display (and even more) on the BSH SMM
 S2/PRO boards
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>, 
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Alexander Dahl <ada@thorsis.com>, 
 Anatolij Gustschin <agust@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Anton Bambura <jenneron@protonmail.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 Fabio Estevam <festevam@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Igor Prusov <ivprusov@salutedevices.com>, 
 Igor Prusov <ivprusov@sberdevices.ru>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Julien Masson <jmasson@baylibre.com>, Liu Ying <victor.liu@nxp.com>, 
 Lukasz Majewski <lukma@denx.de>, Maksim Kiselev <bigunclemax@gmail.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marco Felsch <m.felsch@pengutronix.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Minkyu Kang <mk7.kang@samsung.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Nicolas Heemeryck <nicolas.heemeryck@devialet.com>,
 Nikhil M Jain <n-jain1@ti.com>, 
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Stefan Bosch <stefan_b@posteo.net>,
 Stefano Babic <sbabic@denx.de>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>, 
 Vinod Koul <vkoul@kernel.org>, Yang Xiwen <forbidden405@outlook.com>,
 Ye Li <ye.li@nxp.com>, u-boot-amlogic@groups.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 30 Sep 2024 17:07:37 +0200
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

Hi Miquel,

On Mon, Sep 30, 2024 at 11:43=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hi Dario,
>
> dario.binacchi@amarulasolutions.com wrote on Fri, 13 Sep 2024 11:55:42
> +0200:
>
> > This series was created out of the need to supportsimple-framebuffer fo=
r
> > BSH boards SMM_S2 and SMM_S2PRO. To achieve this goal, it was necessary
> > to develop additional code and/or drivers for all the required componen=
ts
> > (i. e. clock, power domain, video, etc.). This series has a Linux
> > counterpart that will also be submitted upstream as soon as possible.
> > Furthermore, given the overlap in topics with the recent series [1], we
> > are open to collaborate on the common parts to ensure proper developmen=
t.
> >
> > [1] https://lore.kernel.org/all/20240910101344.110633-1-miquel.raynal@b=
ootlin.com/T/#mb7cd440abc6fcc0de205f577eb3225e1c1c76823
>
> I received a bit of feedback on this U-Boot series, I can take the
> feedback into account and send a v2. Then, if you are still okay, you
> can stack your patches on top of mine and do the required adaptations
> (on both sides).

Sure, go ahead with version 2.

Thanks and regards,
Dario
>
> Thanks,
> Miqu=C3=A8l



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
