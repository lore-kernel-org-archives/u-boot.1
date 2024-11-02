Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A12E67805
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 19:48:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C66089100;
	Sat,  2 Nov 2024 20:48:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IblTjxl3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1657F89082; Sat,  2 Nov 2024 20:33:27 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1826088FD6
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 20:33:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9aa8895facso504565166b.2
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 12:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730576004; x=1731180804; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ldlo3jBBXmhS7u9+yJJq2qOHYWRDf6TSg4tcQ2yDA4g=;
 b=IblTjxl3ITKI8leVgbB+YfnDB59o5T4FTaF+FYTbUyGMNQhqpiwcEcf3SL3unxeE3m
 Kkt0C3ejjCv8VfH9BEC4BkQdbwa5+XSQWhhuCW/DucfxRBCALBMiRzQ3zxqPOLVydrrs
 hSRKCXk6cyDQVVTtFKYrR3hK6XzyauTazHWhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730576004; x=1731180804;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ldlo3jBBXmhS7u9+yJJq2qOHYWRDf6TSg4tcQ2yDA4g=;
 b=HqDN4Ci5uRmmjMSB72Mu1z1HY4uOFB49SQYODYw15e04iyfDPjZdYPVxGujs+L1YJt
 rep426HfniZepgB+zRz8O7qyYAkhH/xIdWwdArChZT+6qLQaWRtVps5WblqbcW/C4fTu
 YNOcarsVt6NsTVWruPlebj/L0K8V7Mf21595tbPjOefqedxJtTolefJJOK0PR7u+21Bu
 vxKnzSh2Pw2IcktPGpd4NRdmWHvZOEy7saRvmeNdkyv8KPbl6vhaSo8Eump8soGLBuJl
 24khWqe0Yqwsj4Bf4C7EqIOVzOTEhsgF1qr4xe6Rp8vJ55G9JAjGBuei7s54om33Nj12
 90pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo+8G6qw6HFeq0Zl9ISius9M4pFBI35/H0xCkIVtxOzIeI/A5tsyU6o9bPmRsePjGT70Mzjcs=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8JCoHR+qfflPGCl7rB1ORntP6+eRgu527a6W6zQGlWVA+gtOW
 AzcX7ZFarwVbIg+7cK5sRilA/Ro+nlEQTFNAU8zTWVQOKsVgL4aGFFMYbjnVrRC2CqjvWOaw6eM
 l2SSKAYWCrvSLILYVCTqh9HdGFCapQWyDJOvO
X-Google-Smtp-Source: AGHT+IGplvb6iGYJFlqU/F9dPZ/3dJ2DT6aQFI64EKqlSoVI6BxGb5+gajy7LTzoE34IamzK1zAQZ5CjMcUVDj8Hd+I=
X-Received: by 2002:a17:907:9807:b0:a99:ed0c:1d6 with SMTP id
 a640c23a62f3a-a9de61cf1a5mr2295058066b.49.1730576004359; Sat, 02 Nov 2024
 12:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <20241001122511.8832-1-ansuelsmth@gmail.com>
 <20241001122511.8832-4-ansuelsmth@gmail.com>
 <CAFLszTjB4OV-k65rhqJ9pBTmKUnnWthbDJ2Vk3eRxzBgmMeOOg@mail.gmail.com>
In-Reply-To: <CAFLszTjB4OV-k65rhqJ9pBTmKUnnWthbDJ2Vk3eRxzBgmMeOOg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Nov 2024 13:33:10 -0600
Message-ID: <CAFLszTh9WYnya=8YXXFEcSuVUYuhCGy-+iYFRucgMZq+-1H5UQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] led: implement LED boot API
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Alexander Gendin <agendin@matrox.com>, Yang Xiwen <forbidden405@outlook.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>, 
 Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 02 Nov 2024 20:48:44 +0100
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

Hi Christian,

On Wed, 2 Oct 2024 at 16:55, Simon Glass <sjg@chromium.org> wrote:
>
> On Tue, 1 Oct 2024 at 06:25, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > Implement LED boot API to signal correct boot of the system.
> >
> > led_boot_on/off/blink() are introduced to turn ON, OFF and BLINK the
> > designated boot LED.
> >
> > New Kconfig is introduced, CONFIG_LED_BOOT to enable the feature.
> > This makes use of the /options/u-boot property "boot-led" to the
> > define the boot LED.
> > It's also introduced a new /options/u-boot property "boot-led-period"
> > to define the default period when the LED is set to blink mode.
>
> BTW could you please send a schema update for this so that Linux accepts it?

I'm just checking that you did this?

>
> >
> > If "boot-led-period" is not defined, the value of 250 (ms) is
> > used by default.
> >
> > If CONFIG_LED_BLINK or CONFIG_LED_SW_BLINK is not enabled,
> > led_boot_blink call will fallback to simple LED ON.
> >
> > To cache the data we repurpose the now unused led_uc_priv for storage of
> > global LED uclass info.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/led/Kconfig      | 11 ++++++
> >  drivers/led/led-uclass.c | 85 ++++++++++++++++++++++++++++++++++++++++
> >  include/led.h            | 55 +++++++++++++++++++++++++-
> >  3 files changed, 149 insertions(+), 2 deletions(-)
> >
>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
