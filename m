Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D14CD342E
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 01:05:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB55486A3A;
	Tue, 19 Sep 2023 03:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="JZL4XkYv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FEDA869F1; Tue, 19 Sep 2023 03:05:10 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9857D86A38
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 03:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32008e339adso2171618f8f.2
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 18:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695085507; x=1695690307; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a4JBA064AgXmgZDHrDtlHsitfsoeIvrobIHhAOnOCHU=;
 b=JZL4XkYvEXvRotwdk+mij92pNymn/++snAYHPT1Ifu0DXNhWnGQwArisk+2pCNzle3
 CuB8LrA+tn/ioV6sEv3FBO8zmT7lnxvw+sgktD3yCIy/GeFHLIvSECC6s3MKuDIrQDRn
 HFsMYTPTHFgvkzIvWzSBqjLs8Ab38806ryNYLLgvCM3JXvddlmEknKE3Y76aTQMl1uDl
 iKSSy3bz/4essrE9DPgxB5U38wRoavt66QfrrC0YWCDP2vdzwXDto64txKWiM0/DO0pd
 y7deGJUMZSx8GXn3spWpKPl5YRjdZA18rOQduKLaY3jjwbKu8KOtfcTUJCuiJ/yVIOCA
 2UlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695085507; x=1695690307;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a4JBA064AgXmgZDHrDtlHsitfsoeIvrobIHhAOnOCHU=;
 b=I59uKYzKQ5Ke+T0N+yhInP3CL3KszB0H5lkE6/p+NjFwDJ2fFAfjOeDO9hGCAA8l3g
 oSdHFqOZ27Ezs6i1NeWgkezElwgjYwXBar9ehAugm3i+R9isxMzzoyqETRVM+ijBwLFW
 O3Xk6katpbAtZI9bGi25zRiLzbcxMjLaStbcIxy0hZ9wrBPtRUjoK5f+fQmIQfY2T75Q
 3SgiQXwfxjccEFSBFT40L5iuocfFkJyK4iL5+9fEiFu+pl2vc+Q8/FTeSa2XfA6WVAET
 EI0wb9yG8zfzEG16rILc4K5Ri44OTYBIfkfFxMo2lE2Zz9XcmbXfqaifaER+5F9z2fF+
 OkeQ==
X-Gm-Message-State: AOJu0YwHXBK+n6u67fbKIbVcTG8uipEqn0Xth7asy8MhjedEnk6raiVt
 HbpdJ8/IT00KbYzN0c9FLcKQS6uSqhgoiomb9rFhjA==
X-Google-Smtp-Source: AGHT+IGfykER7ZVQONxw/MLc31M5x8AE2tP4p+N992N+CJECBNkIglYJxs2E3YTyiiPueOFDVbnX8NhJn0y2TPlopUk=
X-Received: by 2002:adf:ef88:0:b0:317:7af4:5294 with SMTP id
 d8-20020adfef88000000b003177af45294mr8762838wro.44.1695085506907; Mon, 18 Sep
 2023 18:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230917101308.1250-1-ivprusov@salutedevices.com>
 <20230917101308.1250-3-ivprusov@salutedevices.com>
In-Reply-To: <20230917101308.1250-3-ivprusov@salutedevices.com>
From: Simon Glass <sjg@google.com>
Date: Mon, 18 Sep 2023 19:04:47 -0600
Message-ID: <CAPnjgZ2NsSiArxW2gn0bD2JgMxqXXA=Lqx48NLfGeKVhxTMeEQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 2/2] clk: Add clock driver for Amlogic A1
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, prusovigor@gmail.com, kernel@sberdevices.ru,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
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

On Sun, 17 Sept 2023 at 04:14, Igor Prusov <ivprusov@salutedevices.com> wrote:
>
> This patch adds basic clock driver for Amlogic A1 Family which supports
> enabling/disabling some gates, getting frequencies and setting rate
> with limited reparenting.
>
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> ---
>  arch/arm/include/asm/arch-meson/clock-a1.h |  23 +
>  drivers/clk/meson/Kconfig                  |   8 +
>  drivers/clk/meson/Makefile                 |   1 +
>  drivers/clk/meson/a1.c                     | 681 +++++++++++++++++++++
>  4 files changed, 713 insertions(+)
>  create mode 100644 arch/arm/include/asm/arch-meson/clock-a1.h
>  create mode 100644 drivers/clk/meson/a1.c

Reviewed-by: Simon Glass <sjg@chromium.org>

This could use a few more comments, IMO. Did it come from Linux?
