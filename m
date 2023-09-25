Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED46CE7AA5
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 16:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49E6C86B4E;
	Mon, 25 Sep 2023 18:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NpOZU/f4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5752B86D4E; Mon, 25 Sep 2023 18:08:45 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6772786B09
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 18:08:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5042bfb4fe9so10525792e87.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 09:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695658122; x=1696262922; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IybnYXd156HSmumk6fJUDh8F/Z9ax94GJf50euhTh9Y=;
 b=NpOZU/f4SjaNlK70y/mKQ3jwfLa29JfpNLzt7MLlg8PptzoQbiQsqF37lH8vo/PLnr
 jRTg+vXZchLR6HDzOiYrwxrX2QcBC7FL1O09p5cy0gQzDWY2YbUURXabtWUMa+iYEJ9R
 u0hlV3oBSA2+w1yZdd0R5HiG5/NhEQ7tDoXl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695658122; x=1696262922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IybnYXd156HSmumk6fJUDh8F/Z9ax94GJf50euhTh9Y=;
 b=P2Kk01/dwnoaJpBFpp6pRgSC1fKZE1NcNo9eZSwcrHNJdJYW7Y6DEqbHFpySFHJ4Ir
 YQfa9ZKcU3mpOLWl1HrEOxogdfGyDNpfbTFYDVIKI68tgjJ0HGWw65l/p7sjsuKdVJX6
 OoUSdKgF30Nll0TP0cw199/j5U+P7W0hI4kFNHoQrf27l3Lfmd/E4HRjmK2iewSrvput
 k84yZKPNDzA3q5gEqTBNo4lFNwHAMe2tu89pC0b5cuTnsPgdUz5YqUhNBmLt/kes4Qk+
 s7U/EemvgaUKuc/Y7c+j7sk1Oj7uaKwJIswedAAz5UFJloC7IxRbrK2nNrumLooJYPDc
 DrWQ==
X-Gm-Message-State: AOJu0YwSyVQznzLr+AoWAHe6BLsbNKbRYEACh9keO6cay3k/3I6v0Ngf
 SNSIU8WnQuNZmmw4PliuN85bXwG86QGu0fyj1JWCG+8+E5yypAr0F4w=
X-Google-Smtp-Source: AGHT+IF6XZJBX48ZIm0R0B+9MvNN82mcPjnwofy8MNsD0guNG5ReBnBhNa6TEyTNsXT0OUd/J8sX/uwNqoAEMxijcPs=
X-Received: by 2002:a05:6512:488e:b0:502:ffff:feff with SMTP id
 eq14-20020a056512488e00b00502fffffeffmr5267062lfb.58.1695658122258; Mon, 25
 Sep 2023 09:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230924192536.1812799-1-sjg@chromium.org>
 <20230924192536.1812799-2-sjg@chromium.org>
 <2a727cd4-bbda-409e-8d0e-1aafba182873@ltec.ch>
In-Reply-To: <2a727cd4-bbda-409e-8d0e-1aafba182873@ltec.ch>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 Sep 2023 10:08:30 -0600
Message-ID: <CAPnjgZ1a9hjodoEuYFuM9x+tiSZkL05_daJA4Rd5fzdwJ5KPMQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/38] spl: Use CONFIG_SPL... instead of
 CONFIG_..._SPL_...
To: Felix Brack <fb@ltec.ch>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Adam Ford <aford173@gmail.com>, Alison Wang <alison.wang@nxp.com>, 
 Allen Martin <amartin@nvidia.com>,
 "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>, 
 Chee Hong Ang <chee.hong.ang@intel.com>, Chin-Liang See <clsee@altera.com>, 
 Dave Gerlach <d-gerlach@ti.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Fabio Estevam <festevam@denx.de>, 
 Green Wan <green.wan@sifive.com>, Heiko Thiery <heiko.thiery@gmail.com>,
 Ian Ray <ian.ray@ge.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 =?UTF-8?Q?Javier_Mart=C3=ADnez_Canillas?= <javier@dowhile0.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Michal Simek <michal.simek@amd.com>, 
 Mike Looijmans <mike.looijmans@topic.nl>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Oliver Graute <oliver.graute@kococonnector.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Parthiban Nallathambi <parthiban@linumiz.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Peter.Chubb@data61.csiro.au, Philip Oberfichtner <pro@denx.de>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Raffaele RECALCATI <raffaele.recalcati@bticino.it>,
 Roger Quadros <rogerq@kernel.org>, 
 Stefan Roese <sr@denx.de>, Teresa Remmet <t.remmet@phytec.de>,
 Tianrui Wei <tianrui-wei@outlook.com>, 
 Tim Harvey <tharvey@gateworks.com>, Uri Mashiach <uri.mashiach@compulab.co.il>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, kernel@puri.sm, 
 uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 25 Sep 2023 18:58:17 +0200
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

Hi Felix,

On Mon, 25 Sept 2023 at 08:56, Felix Brack <fb@ltec.ch> wrote:
>
> Hi Simon,
>
> On 24.09.23 21:24, Simon Glass wrote:
> > We like to put the SPL first so it is clear that it relates to SPL. Rename
> > various malloc-related options which have crept in, to stick to this
> > convention.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > Reviewed-by: Martyn Welch <martyn.welch@collabora.com>
> > Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >
> > (no changes since v1)
> > .....
>
> I just tried to apply the patch to master for testing and got the
> following result:
>
> error: patch failed: configs/am335x_baltos_defconfig:18
> error: configs/am335x_baltos_defconfig: patch does not apply
> error: patch failed: configs/am335x_igep003x_defconfig:20
> error: configs/am335x_igep003x_defconfig: patch does not apply
> error: patch failed: configs/dh_imx6_defconfig:39
> error: configs/dh_imx6_defconfig: patch does not apply
> error: patch failed: configs/starfive_visionfive2_defconfig:47
> error: configs/starfive_visionfive2_defconfig: patch does not apply
>
> For what I want to test (changes for PDU001 board) this doesn't matter
> however. I'm just not sure: should I go ahead with testing or wait for
> an updated patch?

I had to resync the defconfigs before this patch, to avoid conflicts
when applied.

So you can use './tools/moveconfig -Cy' and then the series should apply OK.

Regards,
Simon
