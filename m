Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE59C43327
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:53:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84045848BF;
	Thu,  2 Jul 2026 12:53:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S763FXz7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CD3A848EB; Thu,  2 Jul 2026 12:53:09 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93FD4846FD
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:53:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6986578d8c0so2830804a12.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 03:53:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782989587; cv=none;
 d=google.com; s=arc-20260327;
 b=hePSvoqOpu31ODI3dZ09xVP0oV32xpuqF5yq2wdE9GpkzZKZa+KrSvK2+tMxBopP50
 A4be5GAzmtgAXEvRF4XRDFZoIpnWVQT3OBsFx0BXS5B0sAITPH8Az/v1pdpFwUVmMSj/
 bEeG2unZxe54KHOg8MkQKUy6KmhLx7+Ida06PbdgoOLP8hbDCR7ukrh1FLKdxbAy+KPS
 D256V0H7MZXERDXbBIB3sDu+rt7v4zrsn5Rg60P5rm5Tm+pIj+Xms8MaG82ckGCCE8vn
 S+0DICPrmBEB7wTg60WfEDnOmwT913NfL+W4tCe+jFKrJmaWjxpsqFGJXsylp3KpkaSL
 OdLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5t6tscPU2TVrnyj/SX8HjYX5/NwvPo5QWAptpke7AtY=;
 fh=fDRPFfo8wg+H7JA8tulyVp5A5WsiHidgebHesXw8vT8=;
 b=lCTdu14k5AM9UgJ9EwLxNTEGsSFe89cuk/zM58PcgqdMK3V7rE3grIa2HV8sC060oQ
 JGjaAvobynFL5bjFZUk0gx/gJOBy0RttxltOEcm7Mgwy8Bn7DjbiMnjXUcYbWweDSA5o
 P+wE4tIUatvi5ZzHxd5wlqCZcJw6MTLI66mEo4mqnOg3aGcPd4lFxiL3108lK26BMeqw
 T+rL6OybJhRTqfDwE3MYUM6/j0mchfb9d5vxkWqPzqNmM3XKqhCMBBzZCmZ71JcrO/6M
 Py/QaBSatj3oXl2A8TstJfyP7RDt2t8Sgis8Um4GFFhLSKNlyC9zmhWr/Bp0LYAZnugh
 hKaA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782989587; x=1783594387; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5t6tscPU2TVrnyj/SX8HjYX5/NwvPo5QWAptpke7AtY=;
 b=S763FXz7YASxGJDpmHSqF29dzx9DXn6ATRkXfAMHJ/ITR1M9p/tyUowbn+5Y06NNB6
 ExQAZET4PvxSwse+fs8jIBXRhh6IZzM+iegdAqLMgZVqsRs7YRr/zPIo//VwclSP+9dm
 DXvOswDD3MpaK9prAhcn7/VRlZ719Y1DMO0D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782989587; x=1783594387;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5t6tscPU2TVrnyj/SX8HjYX5/NwvPo5QWAptpke7AtY=;
 b=fXOfVLT3tLlrGXYMzBAR7+yZuGSeZTWNTj51Sjgv09Y5XelQsuT2Hc19daHYW9TCpc
 HoOkTBlG0tmAwWTAIF8kZ9+bb3Lid0mcfkt1+Th2YR3LS5K2CWhd/PeB0FjVtf8c/f7j
 L4g5V5NjGMw8WyuEmw2ASmGCSB5JoMFQ0XBy5FgMrVW+uO1w+4sXI3WltJE5/YMVoCCI
 J8GzY+v59mbWIpmHC/JbJ/LLWvUCQUm3eCFCcmoA8kJQQ+T0ycYPd8aQf/TsTlF6jLvs
 TODeeg39vFiCa2jCJA6g11lXBuQEqdlfAap+245lozeqVhoMtGX4xHyP+BMCFeHKPBX9
 JwaQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRpCoANOOJKi1iB6Mb7CtKNcoQirJsivn5UUhwhhcgksRj1NqDsLHgCiysG4jh/tlGEt7YBXY=@lists.denx.de
X-Gm-Message-State: AOJu0YyYppIgOf3VblgJpANLoC3C0SqFCWrH0TUp5FM/1bH2WiCz/nAj
 WbTmB+V0G/ImEoXa5b/+V65I/ReHlFfBo5gcHg+0Xm7EDL3iiTSw5digyXB91NXqHi5LNWrB2ii
 +Ypb/lQAjZtYvNIkk2yAvYw+T71OCF73ETyfOcTvB
X-Gm-Gg: AfdE7ckI7Wh3hpiHXZgw3Ilnck7YDyNF9voZHgjUnv+Xu4rnOXetAB6rq81y+7uWzQp
 OB/2rkRIaL1hHso8W2vWyZYfjoXoeyP2keA/KwXSnof8x29Ti5XEOhZzQ74x5ezfKbllVosUllJ
 K8ysEAAW6FnVFq/H7DFE4w1Iyo6Djpmpqi1uNfX/hg10A8wDJRlNh9DVM4kczcDud0egk9AEu0v
 9wJiRKFhZoyaGC4954ApzgxlieZEUk20GVmagVXhIP97QViUBtVr3Tfbb7T4XmluwaZ/EUlvQ==
X-Received: by 2002:a05:6402:42c4:b0:698:becd:8712 with SMTP id
 4fb4d7f45d1cf-698becd8b5dmr52645a12.8.1782989586717; Thu, 02 Jul 2026
 03:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
 <20260702055744.2164975-2-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20260702055744.2164975-2-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 11:52:53 +0100
X-Gm-Features: AVVi8CfXq0tAn91TbUdLZgQzbuQ6gdCpdwvSacXXWL3pLVq4hnPldGwACdv7Iuc
Message-ID: <CAFLszThh=UUzNbR5LakdQvWY1iq-QPQ=8MxPcK7F4jx1gEPGSA@mail.gmail.com>
Subject: Re: [PATCH v14 01/18] bitops: import BITS_PER_TYPE() macro from linux
To: mikhail.kshevetskiy@iopsys.eu
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>, 
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de, 
 Markus Gothe <markus.gothe@genexis.eu>, 
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-07-02T05:57:27, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
> bitops: import BITS_PER_TYPE() macro from linux
>
> This macro will be used by include/linux/bitfield.h header.
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
>
> include/linux/bitops.h | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
