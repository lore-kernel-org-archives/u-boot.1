Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A48F43699
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:46:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 902AB84372;
	Fri, 17 Apr 2026 14:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K63m0mLp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9CEE8407E; Thu, 16 Apr 2026 22:54:40 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBD4E83EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 22:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-672bd8d2400so345859a12.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 13:54:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776372878; cv=none;
 d=google.com; s=arc-20240605;
 b=hs9OAO+bSvT+JLTYWZq5V9ovG4oFUA9X1yZxdk9/UbzDWXZIUK1xyB/pRh7ZBWRimy
 1pxoj+38j3VfvXC1ZZ42IHfBd+n3TGb09MfCAArRDfXfNS/lg//7qzFpuXjBJ+Qxhq5W
 QYfJZO3VDP1IVaNFxsF3fEAE9vYypxfecf957kzDVEuMAUr0f9pg/L2kQPA18eSzcwd8
 TN282nQObC+QQpXJjxWxPV6bqsl3uXn1IJ83tDZDsUhouWYZdLjMgi0yzlqp7qEBvSwP
 FAZXlN2yfiMKK2gawBRREmrpWeC56Dx3LUPuGLNf+qKqTtlrgQFKhjFL0xp+j6lZC3Vn
 aKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Pl5bX6YwBr6/FuDLad5VR93gR+g5Q8i5dDrIKwXLKjI=;
 fh=Xs636b9cxoz7QiX8lA0xHfFF4N8UAO0T7pnns8a2EOs=;
 b=IL2bYstsyy1EtF9I2+kW44xA2J93c+XSuCRPG/Vm8xK1otfeYhp4/5whVhUSNQnw8d
 ki2jvnBTIcS+QvPZb5MnnMGpQW4kvJpZs5wvoqGUE4SOWrYb2E5V8B66N/L3gpt6E0wZ
 i36B22I32gkLWg6VpAUVOzPn3yNqj/kPJXu0HhzBPLZ8Eg1CreHcvqvUy4Fawp3OnVmt
 /uIz4AA7RZt+WcxFehKfTzSCK31PY+RP13TAl45RDdbnt6ws9Gm9gv9r80hkqIRuMlbP
 SyhytpXVKFyL5cF0nURDgJJTr+/rI0Neklye9SAbtiTMxD10lOIHTNx1kh2Di88Uafcd
 CSKQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776372878; x=1776977678; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pl5bX6YwBr6/FuDLad5VR93gR+g5Q8i5dDrIKwXLKjI=;
 b=K63m0mLpDs0SLP898ZrbOoKod+4EveezxAgY4yLP7yZsW9ze5VUDz/ZVYO32/k9h+l
 KfpA0pbKmg8xmL0aLUbC+YCj9JQv8bW+y5SXe2slXhUYnlTzOMJRSBqTD4iOc8yBj0Yt
 Dp91sKEOJ9motRZH4Z4ExW6vhJoZEcmwRZGpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776372878; x=1776977678;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pl5bX6YwBr6/FuDLad5VR93gR+g5Q8i5dDrIKwXLKjI=;
 b=khfoXs4vkpx8L/fxDQVmCEm/63DI0ILPfB8reEO/VIYiDcIHmhn+lRDBEX1qSi3wPO
 3j5m38DmlOTEJMtV7A0h8ehVUkDi0DihUEEhgo5JDEvuGhj7QTdbQjPpc8bWvNkQ1Who
 suE5iPpMQczqKSJW9KUM5azuusvFbD1H81ll/OBG+rgBzx63Me1OWExkZKyyBcG6A0lE
 QEDwZ8LpyNcdrkI9IqGdoZt4nI15rUyd6eYsVnceQ9q+qe2VytrChqj1MRInVNCGF0wS
 baJC3Bb78e+ai/YchxEPF7opmQWSf0PGr+s4oW8jwEoHhZP3Vy+cuY2DqUOa/ZjDLL/7
 GL8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Zrv3z0NvLvv6o6Ub2oelYBk5uLTK3qUnc/3bCQ6Lbue4ENHZcPjkJg2zbcuqKdYjmECsZfFM=@lists.denx.de
X-Gm-Message-State: AOJu0YwqgonYHVVfEbzqVPXzduudlk1JWcUhrxAE8P14uxb25zGnruOd
 91wrTwt4eh+R3WT26b25+5b7eWrQtKbm2ihPhF+v54H6uFGK/RNoQPiy9yysWDZCH97NSx2dQvD
 5IPIwlItmFRFnl67qTiryb5KnvwWQXNmp+UChi9Td
X-Gm-Gg: AeBDieu9Ze8WEb6AwAcUPQNs9b2nXywpYzWI+SEl23po46zjsaGp8XDb+oS5ybq1kwa
 L+wPD/Oaz24rKLigY9FaEZBKvGYTCSecT7qNmlttHDlQ6ciC/PRZRVCxELucPiU6ATmKInXr8eN
 eH0ocQS8qSQr+YO9ZAzOi4XUtqfqhishmcbLijjZkI3mB3fsusbwXamYL4sYUaU+7yH37spIN9K
 JMDAaMpzHsjmLSITLyGqqro7xqMjAN0gy8QziZTRGSnvfd9hB5a6hGK4IqVMNZpm7fl323MwnUr
 NjhIuZiG97uxfqDJ2+7j
X-Received: by 2002:a17:907:a60b:b0:b9c:b069:8ab6 with SMTP id
 a640c23a62f3a-ba418b7e7d6mr5761466b.7.1776372878070; Thu, 16 Apr 2026
 13:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260416053928.2834699-9-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260416053928.2834699-9-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 08:54:23 +1200
X-Gm-Features: AQROBzD_VkL-V5Lsqku1jH6RE7RoNCXuzgriUM9bQDUK323GAvxrCrkqFXBTY1I
Message-ID: <CAFLszThnBSX2vOdH+ieE_DXub0UuJNknq8Y_0X3AjfQSYDoLig@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] mach-snapdragon: Add commands to create wrapper
 ELF
To: varadarajan.narayanan@oss.qualcomm.com
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, 
 tien.fong.chee@altera.com, tingting.meng@altera.com, anshuld@ti.com, 
 alif.zakuan.yuslaimi@altera.com, alice.guo@nxp.com, quentin.schulz@cherry.de, 
 ilias.apalodimas@linaro.org, sjg@chromium.org, mkorpershoek@kernel.org, 
 h-salunke@ti.com, alchark@gmail.com, dario.binacchi@amarulasolutions.com, 
 ye.li@nxp.com, andre.przywara@arm.com, dinesh.maniyam@altera.com, 
 luca.weiss@fairphone.com, danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com, 
 balaji.selvanathan@oss.qualcomm.com, adrian@mainlining.org, n-francis@ti.com, 
 wens@kernel.org, jamie.gibbons@microchip.com, justin@tidylabs.net, 
 ycliang@andestech.com, david.wronek@mainlining.org, james.hilliard1@gmail.com, 
 richard.genoud@bootlin.com, michael@amarulasolutions.com, 
 philip.molloy@analog.com, sughosh.ganu@arm.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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

Hi Varadarajan,

On 2026-04-16T05:39:18, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
> mach-snapdragon: Add commands to create wrapper ELF
>
> The IPQ5210 boot ROM expects the SPL binary image to be embedded within
> an ELF along with additional binaries. Hence add the relevant commands
> and linker script needed to convert u-boot-spl.bin to the expected
> format.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>
> arch/arm/mach-snapdragon/Kconfig                  |  7 +++++++
>  arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds | 18 +++++++++++++++++
>  scripts/Makefile.xpl                              | 24 +++++++++++++++++++++++
>  3 files changed, 49 insertions(+)

> +ifeq ($(CONFIG_ARCH_SNAPDRAGON),y)
> +INPUTS-$(CONFIG_SPL_WRAPPER_ELF) += spl/u-boot-spl.wrap-elf
> +endif

Please can you use $(obj)/$(SPL_BIN).wrap-elf here to follow the
convention used elsewhere in this file. The hardcoded path would break
out-of-tree builds.

> +/*
> + * SPDX-License-Identifier: GPL-2.0

U-Boot convention for new files is GPL-2.0+ - is that OK, or do you need 2.0 ?

Regards,
Simon
