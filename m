Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4959CC98332
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 15:05:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D62460680;
	Sun, 27 Sep 2026 15:05:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cO3tNBcQl4mk; Sun, 27 Sep 2026 15:05:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2D7D460657
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790521525;
	b=qrGJuZKC4Z9D9K2O0tkAd2EMz0Q9mTbTVpLsYlEIO5+vDIq2e127gAtmYUIVdt4BVRT7
	 mKbesbb3APOE+s9xLI9FE8QQfuVl/M+Dudk1NlNjKbn5TsbwUl0bE9CmaWnYZjAK6wFhR
	 dsZD69v21lIBgpdTP+J5xK7740rp60ni8KQjzigWYilx1s5y5pBVqFk/BtskZ99Jocw1i
	 BkqPD7qJsDzrLso4ZsSaFWG1vFJ3wsdu9mU0E2tU/HiOFQEeE7jMoGv7dfAyJbchP1nBM
	 5sgtxnbSYOdvTQAVdUvO20GJjCVXCK9SEpX3PsulLYKmSiMWXRRwBZ6Q1LNgsGD8Vxw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790521525;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=jMgxNQfIWRvhe6JfcvIL7hqqrFZ07GEVu2Hl4BhD4QE=;
	b=LW+t/fpt2/AW1pdqOmgpsjk799pGfyqd6XoJRUihItPYWaYIa2KipXS4RpdUpqHS9L4f
	 tBEItp5bumNA5ldw77nY8SQLPcrzvRdOvZxphDor74r+GBJanaRxPGdhPl2Q5rFu5VbxN
	 uJ096mpEWqAt1GSc2Y3UP2/ZX2+ZPgo54OgD0pqjbavS3DtX5FYxxwr+xusvGpglzCo2W
	 o8vx+AyVJwC/w+kKC99CxUYEBrOapGBSJfi/z5P28L/aIxbHEgjih0JWmDRU2NedeuLHi
	 TJgy9GmiZ+fgfpCU34FRRxJxeJEMB+/rgGdgTvppLJA2VcaVFbuxOUfqpYyhPhOC7Qg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=oXgjxmv4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790521525;
	bh=jMgxNQfIWRvhe6JfcvIL7hqqrFZ07GEVu2Hl4BhD4QE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q98KFRTSwt3fkutk8rqg00fEsrT5sr6MIHqp2HTjGgxKHPduS4lkC5Bjp/t/wMhz0
	 TGncGafmsl2bqOoRGbBD+4sofS4oWRUU96sQ/GzFthJQNgd6pK647o2zYeTVT1rYML
	 N9lkLexC5BKf1uJslsLeyYh9b6a3cPdUuYVyALWN3KIJJ8jeiOH8MryzZNBaGmKQqH
	 jCowaHSCU5V4vtCY0oYisytTvD43hi9fZegDss9xkZeKvI2jd4HfjTIv1J3YF6q3wV
	 oftyY0EQYB5RFtQA2lovQqWBHC+hKda5K87L31aTJ/pPedOsSudXAiEddDYp5/FHDj
	 95GTgKqxFhtIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D7D460657;
	Sun, 27 Sep 2026 15:05:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C54672
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:05:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 022C660657
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:05:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1fdsddAVlb4x for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 15:05:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E55CD60619
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::18"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790521522;
 b=p9uYZR0mCVM+r/YNI0Iz9v/R4Kf58paoRXEcd55VboPSLoAFyjU0qVVxRJkOeLca5rVI
 vXUfMQp3AmDXnQnxQR8n6uRomIzXRUq763xLGepCcFWVXTPqEutIw+KPz1S9okpo7AOBX
 gUOvQ/gnxRd9MTyDOqZ6rTi71OIDV6Z2u8iKmsLaYyS136hFxfTrBhKP6Tm612FaJiDPl
 kM243xmiYECSYaivCwY0Fzj5jAyblHQqpP6G8Pi/nBP1vM1f0O34VObpQ1L3mV4KxAENt
 jPTCK4oOJkyRVUGGMKoP7Gr1lAHp78Xs1wBt93ss/M/k2OLBzjvMIDu2wjF9k5V6pHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790521522;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=jMgxNQfIWRvhe6JfcvIL7hqqrFZ07GEVu2Hl4BhD4QE=;
 b=f/ZlZ8ZtW7JVK7nx8ukTWXdmvkpzDQancu+5uBoqF2lcb5onotzJhYLto0MZf69o3wc2
 JE9DMmyspgXhdD/6ncybZNU/CUB8LNQcsVYCboNGvawj15ykpHoQ8tUDcSMXOAU5Q7uGY
 TqRRBV927ljWPBvqAQNlQfKPcgEIskgraXOsfuAfs/2zcFU2GgZB3+8J3gP/VJz51FELO
 I2f/7QqRseK6L8SWC+u9mUpY4zZoYxErwuKDVtQy+9jWXu2eW3B8VOm8sdEXFvE07jVO/
 DJFCyv0qjBRzAqJJcu1+3ZTTzviJgk5yIZi1Pm898CVFGeWuLykGiqU3qCNI0Fd+xKA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=oXgjxmv4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::18"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::18; helo=mail-ed2-x18.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=oXgjxmv4
Received: from mail-ed2-x18.google.com (mail-ed2-x18.google.com
 [IPv6:2a00:1450:4864:33::18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E55CD60619
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:05:21 +0000 (UTC)
Received: by mail-ed2-x18.google.com with SMTP id
 4fb4d7f45d1cf-6aafe2a64efso1772761a12.2
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 08:05:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790521519; cv=none;
 d=google.com; s=arc-20260327;
 b=UFtP/y0Jefn05ahmAQlhl9uNGI73Dbq1DmNWbBm0BDn2ZXCifL27zRBouN/XXoy/Tx
 8P1DIV14NjWmcSaHKVLKz+4RMUj6oK7mvir3+JFPRjo00STnbWfX3YdWHcECbuH3DSQt
 7QBns3qtuE9/TNQ9mSzDRTb3g/jhCMz/mo19Sbu7NO5LjdfrmH6RjGYWp/+DZNP19jir
 ObOMP7JK8RmhOxdJP2VJ8EAsBt4FM0YZ7oMLFg47AmQTADPQ3looZDj2mbxL92OHkD4p
 wjBBOqX6zpV1s3UAipp27So3WwJ0DeBWILQXA4ni0W8Xhf8mLHpzIaNgKE7tMixZB3xL
 TAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jMgxNQfIWRvhe6JfcvIL7hqqrFZ07GEVu2Hl4BhD4QE=;
 fh=+2nv7UYwcy2tPqAlgqUhut+0T5msRumaKRll3Py55Dg=;
 b=CGit2dw3/xLt7H8D74LRoWz1PILMuf/fI3ipi4rLOsiZAtiEGoxThDslsM5c0IMjSi
 iMSriYPg5G1m8ZMqz35AfvfX5kbRN2JI3zJVJKHTobDoX5rCCKBQOsQo1ynlYkqT3AXU
 NVjInTvO6OTUAQ2oLE+FCjfP8KVT22Uv1he6DlkdjkutYKP/Z73sl1W6xmSMh1bFfquk
 rDscSOTm7/UCHaxtkF+LGg+ysLiB6ltqmyP0s3Bo2pEpwIgZCXiy5baTGiX2AVqTzEi8
 IqqDdeggW1ODqfsyZHlF/4hn1i0RTQ+/XB1EPEZs0dLSAl4NOpU45/US4Jf6D33upjPg
 wp6w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790521519; x=1791126319;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jMgxNQfIWRvhe6JfcvIL7hqqrFZ07GEVu2Hl4BhD4QE=;
 b=oXgjxmv4Z6bvXYaie8sqk3t3Jn5v7oJHVcBqZrVS1VGhFoLYFHpisXkSOK0s4AsKXs
 OlPtMT7HOQpv3tQSYc81+4jzOj+nNSDe3IKmlQHT9W3O90lrg8JgVN10R+4cCIPc+oTx
 8VFFDy99lQdb23lMamOmo4XD14ad1XFdGGeTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790521519; x=1791126319;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jMgxNQfIWRvhe6JfcvIL7hqqrFZ07GEVu2Hl4BhD4QE=;
 b=L0Wf/JFsEw5ZaF7sdrwPdYAZSYRfatXQFqzzpuqzsgpmfWAMkpwhPMPuDNaVenZZQl
 IXOE+mIt3KhjenGUhSCE5a7qIXGQtSQ180QmnpPZN9+mmV1S8klGyKvm4tkCTLlm7yD4
 hJcG+LCHI282/g3jiJ1j+lMvRx494owR0niQvm8H6OhiAc5YKZvWHKsGoAMox1OFFiyv
 8lovklIImYye7NBm4Bm2LqPZ7DIMyI+4UDtWBwwh24yqNakRbqMYE3UWvmUp+Aj8eFVL
 kfI/KZhkbl5qcj3PWSJOrOWVX8+0axZ50NXww0SsDYNgkqmbf02RfYnHIq/IZkTLHOIW
 LjKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMe2fKi51Wgdf/JJ4jxWNxUYIYmEXIOoHVKg5ZXHUcAesHhuSI4/YdGX+6VKvFRXB7TzTf+HM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK85tUPyat6yM6uGVTk39uBoI/BpdmD7gTI3chzFe6P1JrpAv/v
 pFgsEMzwiMdtFKVmWyr0qEaKPA2Dg6ADbmQct/6N25bQq4i71UCyJV4gc79hNkGVikxKBZfknSo
 EuYB5f5O2QNY2EUeRzxgrb19It60F1UzFNLaddIY+
X-Gm-Gg: AYBFou24ou1fd9VeZIbgZnstJnGnIxfYDOD6cJBsTnBA5r1sFlBz/Azzx79WocX0Nv7
 ArGJMA4kvM7PfsmahQrETv5QO/CFRDQt7WxVzYwCUFZZvSNy0GmEFA1AZ5KpsAVkMNurjVZBNp4
 r5BLKfT0eZBajFrnbEVgIR4yzMgrDAZyxD4a83SA55tfI3x829HEtfSGFL1DELOwhC8pgC6IVee
 KSQajUbQWnXZ5DhdgRdu/O5mep2Ckqvt4cauXVGJdgIsMXMXdQQTxmPlRHyglgIT3sPX7ygrdiC
 GM+xmRDv8yc/dbuwA71UIXxRuF9VVKwh1y4EWFy5869acz7v/5gR4pAIX9HPko4U
X-Received: by 2002:a05:6402:13ca:b0:6ab:eb3e:ef50 with SMTP id
 4fb4d7f45d1cf-6abeb3ef714mr2089558a12.36.1790521519365; Sun, 27 Sep 2026
 08:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260925105432.0F27E68C4E@verein.lst.de>
 <20260925105624.AADAE68D09@verein.lst.de>
In-Reply-To: <20260925105624.AADAE68D09@verein.lst.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Sep 2026 09:05:06 -0600
X-Gm-Features: AclHuK9SKY1vfn5WIGJE86ikNfglsJo00zCFz2_xEPjy-0ecykWwC6Pyce079fA
Message-ID: <CAFLszTj=sHviidk6vVvbi_vSofzKpQJAhP2GjsxLyvO7UDvtaw@mail.gmail.com>
Subject: Re: [PATCH 5/8] gpio: add support for RPi5 RP1 chip GPIO
To: duwe@lst.de
Cc: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Martin Schwan <m.schwan@phytec.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 =?UTF-8?Q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>, 
 Anders Roxell <anders.roxell@linaro.org>, Michal Simek <michal.simek@amd.com>, 
 Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>, 
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, u-boot@lists.denx.de, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Torsten,

On 2026-09-25T10:54:32, Torsten Duwe <duwe@lst.de> wrote:
> gpio: add support for RPi5 RP1 chip GPIO
>
> RP1 GPIO driver, derived from Linux drivers/pinctrl/pinctrl-rp1.c;
> mainly stripped the pins' alternate function handling and fine-grained
> driving current controls.
>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Co-authored-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
>
> configs/rpi_arm64_defconfig |   1 +
>  drivers/gpio/Kconfig        |   7 +
>  drivers/gpio/Makefile       |   1 +
>  drivers/gpio/rp1_gpio.c     | 374 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 383 insertions(+)

> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> @@ -413,6 +413,13 @@ config RCAR_GPIO
> +config RP1_GPIO
> +     bool "Raspberry PR1 GPIO driver"
> +     help
> +       This driver supports the GPIO banks on Raspberry RP1 chip.
> +       Raspberry PI5 has an external chip RP1 installed, which
> +       provides it's own GPIO controller.
> +

Two typos in the help text: 'Raspberry PR1' should be 'Raspberry RP1',
and 'it's own' should be 'its own'. Please also add 'depends on
DM_GPIO' as the neighbouring GPIO entries do - the driver will not
build without it.

> diff --git a/drivers/gpio/rp1_gpio.c b/drivers/gpio/rp1_gpio.c
> @@ -0,0 +1,374 @@
> +const struct rp1_iobank_desc rp1_iobanks[RP1_NUM_BANKS] = {
> +     /*         gpio   inte    ints     rio    pads */
> +     {  0, 28, 0x0000, 0x011c, 0x0124, 0x0000, 0x0004 },
> +     { 28,  6, 0x4000, 0x411c, 0x4124, 0x4000, 0x4004 },
> +     { 34, 20, 0x8000, 0x811c, 0x8124, 0x8000, 0x8004 },
> +};

Please make this 'static const' - it is only used within this translation unit.

> diff --git a/drivers/gpio/rp1_gpio.c b/drivers/gpio/rp1_gpio.c
> @@ -0,0 +1,374 @@
> +static int rp1_gpio_set(struct udevice *dev, unsigned int offset, int value)
> +{
> +     struct rp1_pin_info *pin = rp1_get_pin(dev, offset);
> +
> +     if (pin)
> +             rp1_set_value(pin, value);
> +
> +     return 0;
> +}

Silently returning 0 on a bad offset is inconsistent with the
direction_input/direction_output ops, which return -EINVAL. Please
return -EINVAL here too.

> diff --git a/drivers/gpio/rp1_gpio.c b/drivers/gpio/rp1_gpio.c
> @@ -0,0 +1,374 @@
> +static int rp1_gpio_get_direction(struct udevice *dev, unsigned int offset)
> +{
> +     struct rp1_pin_info *pin = rp1_get_pin(dev, offset);
> +     u32 fsel;
> +
> +     if (!pin)
> +             return -EINVAL;
> +
> +     fsel = rp1_get_fsel(pin);
> +     if (fsel != RP1_FSEL_GPIO)
> +             return -EINVAL;
> +
> +     return (rp1_get_dir(pin) == RP1_DIR_OUTPUT) ?
> +                     GPIOF_OUTPUT :
> +                     GPIOF_INPUT;
> +}

This is wired up as .get_function, so it must return one of the
GPIOF_* values, not an errno. When fsel != RP1_FSEL_GPIO the pin is in
an alternate function - please return GPIOF_FUNC to match
intel_gpio/at91_gpio/stm32_gpio. Otherwise 'gpio status' will report a
stray error for every non-GPIO pin.

> diff --git a/drivers/gpio/rp1_gpio.c b/drivers/gpio/rp1_gpio.c
> @@ -0,0 +1,374 @@
> +struct rp1_pin_info {
> +     u8 num;
> +     u8 bank;
> +     u8 offset;
> +     u8 fsel;
> +
> +     void __iomem *gpio;
> +     void __iomem *rio;
> +     void __iomem *inte;
> +     void __iomem *ints;
> +     void __iomem *pad;
> +};

num, fsel, inte and ints are populated in probe but never read - the
IRQ paths from the Linux driver were dropped. How about dropping the
dead fields?

Regards,
Simon
