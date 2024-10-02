Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D637CF318C
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 04:41:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E50D088FE1;
	Thu,  3 Oct 2024 06:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fdy7TSmC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9EE788F8A; Thu,  3 Oct 2024 00:55:57 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A013F890BD
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 00:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cb3cbc28deso2926336d6.3
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 15:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727909753; x=1728514553; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZM3ACc4IXcxlrMy5y/raw+Obtp01K7zg8c7H7gp/Nj0=;
 b=fdy7TSmCLnyw3y/+UPuwrRQO775VBo6SEIziy14eSyACN8iJ68rvYc8T2wcKg37Squ
 YtAVy+Kj+Hp4W4DFvqkk8LQdGCVeb8X0I2SxLLWn68m5twLCtGWPUvCVTo/e8s229q6W
 qjJirXc6DI4MOBDc/z0QCpScOER+CeNCmlmA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727909753; x=1728514553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZM3ACc4IXcxlrMy5y/raw+Obtp01K7zg8c7H7gp/Nj0=;
 b=MxjFF3subEri0KwfH1wRCgM68s2GH8Ujk8DaPL5JBb7waRyBp80qHlYJ417E8mFMnH
 9OiWycrhs2dQt1qeUtGNw8Gwsz+wap9gYlLfzx056a8SFcPSVlFVYaHX+3SfXhoe8TYz
 eDxvFixtUsC8XgI2rgoOVt48p1tFyDYaIWoSfNd11OcS//hbaUCvB5wf/z5Gc/K5qL7t
 wGYvXqWePtRYoK71wNkIXuMdEu+yEMIKGi2rlA/jkBVhz2sIZ66VbphN1dy+Jthq3MFy
 s9LkYtfgfEtIWHkRQRe10ROgRxWqKW6b5FF25+0+vW+JPZPDmGtXHItN7O+zT43oofCM
 H46A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe/Jft83zxOo63OZWQ+tFaGdcSDu5jy5nFNH4+cjJr6DIR4bGTtLl9YNuWqV/Mvn/c0V4+X/s=@lists.denx.de
X-Gm-Message-State: AOJu0YyGsfkIFSoAQA9Bnh8Xxv5j0it1yQYzwqq6QDxaTQbGIK9uFbar
 1/mPz16UVsGtLcdafUP6NSKDXgQ0b/gLG/ZdIT5OtzVS032VovMhkfhc67j/c7sctRlY7JVVkN6
 TqH9OnP+Ar6PvGKcuN4jwt0WR5QmQ7q3bq3rx
X-Google-Smtp-Source: AGHT+IEZmD3pxfxeL0oOkHLz588z9q6U7nv9pWbf0f3/8ix/IaHbjmkaEq8OnDLrG6YEWYKYXh0qPdCBEzeTMtN+51w=
X-Received: by 2002:a05:6214:428f:b0:6cb:5f56:e375 with SMTP id
 6a1803df08f44-6cb81a330a9mr87098446d6.26.1727909753489; Wed, 02 Oct 2024
 15:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20241001122511.8832-1-ansuelsmth@gmail.com>
 <20241001122511.8832-4-ansuelsmth@gmail.com>
In-Reply-To: <20241001122511.8832-4-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Oct 2024 16:55:42 -0600
Message-ID: <CAFLszTjB4OV-k65rhqJ9pBTmKUnnWthbDJ2Vk3eRxzBgmMeOOg@mail.gmail.com>
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
X-Mailman-Approved-At: Thu, 03 Oct 2024 06:40:55 +0200
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

On Tue, 1 Oct 2024 at 06:25, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Implement LED boot API to signal correct boot of the system.
>
> led_boot_on/off/blink() are introduced to turn ON, OFF and BLINK the
> designated boot LED.
>
> New Kconfig is introduced, CONFIG_LED_BOOT to enable the feature.
> This makes use of the /options/u-boot property "boot-led" to the
> define the boot LED.
> It's also introduced a new /options/u-boot property "boot-led-period"
> to define the default period when the LED is set to blink mode.

BTW could you please send a schema update for this so that Linux accepts it?

>
> If "boot-led-period" is not defined, the value of 250 (ms) is
> used by default.
>
> If CONFIG_LED_BLINK or CONFIG_LED_SW_BLINK is not enabled,
> led_boot_blink call will fallback to simple LED ON.
>
> To cache the data we repurpose the now unused led_uc_priv for storage of
> global LED uclass info.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/led/Kconfig      | 11 ++++++
>  drivers/led/led-uclass.c | 85 ++++++++++++++++++++++++++++++++++++++++
>  include/led.h            | 55 +++++++++++++++++++++++++-
>  3 files changed, 149 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
