Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BDCC4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 20:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 904CD88235;
	Thu, 25 Apr 2024 22:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="iUg+Le/x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8093188229; Thu, 25 Apr 2024 22:34:43 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C40598823F
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 22:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a519e1b0e2dso205486066b.2
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 13:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1714077280; x=1714682080; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ymn5Wkd+NLpdESw35Vt4s15ZuJ5RyvefCIooO62Ups0=;
 b=iUg+Le/xlYm8QiM2mo0rEDIJDc/YSC3cdSqDnZyJ9fTZCbDojeDDkl3Xwrz0B5E4v1
 xdqJF7YeRPwtOptG9lTS9oGIuc6yaGNvxNQNe/o6vCMR5j+jwhSJH3ytoVQIYfvbJm+I
 N/+jELQdMRlAkHQ7y8U3AyI7uAnVDZAGa00BYC+wV9t6ikj96zu8o4i2bx47TqzvnhQZ
 HVjZRKRp04aUNMYETl9eRw0RQxbLRU6s6/QaIe4+xCBHJ27rDkYMEBR18R/dB4ctIPAd
 LJClU5DJpOdtvhnMJdLRigteE1RkLEdBOo+3MCPCCJ0lE+TlGkFkTYbo8MNiNwEFwYSr
 PFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714077280; x=1714682080;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ymn5Wkd+NLpdESw35Vt4s15ZuJ5RyvefCIooO62Ups0=;
 b=QThUVf7S1ykWLB/xBEWn0pLna2o9d/MZT7qvZJRdktQHCvh4UK9sdXkRhz/xAJFqSD
 CicKZPHJWzuQmRS2MIkFwnFoRWNlc4Jn7pVf305FYvjg6qpoG3/X6KpTzD7ZRg/VT9R+
 S67wy6Vrwb/tlX23yTIMfLc0v4DSHqesPuAwSAnUYPlqrEX6cIHJp8fSjbxThXEIuB2M
 xiqpKHxT+EO7RWrs586XPexaXUE5RGKs1xtdfqeItGlMV2KtCJd+rxKH0grD3zva0Y4G
 wit8o5rgw9lFphipRZq3EcgXDxVJ/aFGx2JjiOa+2hishFeTS3h1dGx/08u6pdp3xUwE
 mqXQ==
X-Gm-Message-State: AOJu0YyEf5i6deRhC9MWDKcDp0uwXcteQbGdu64URmOROKkODtv82mz2
 tGTv/+Qn+GuH4ygdTq5+u33Qr16faSaLwAge7iCi5UReMYRp7q5pEGuqUntdkEi+YzPnDMbxpNQ
 PQMHR+ZoPwMvQ7GJY/NvVUAIASxfs8v1XDWTSXw==
X-Google-Smtp-Source: AGHT+IFKor4LWbK8Ge179u+KlytroSDhpLKqAquhHq8Ya9p5EJAzptabxBj6iUIyHf+GzpVNPAsJSMjykfAKII9XxdI=
X-Received: by 2002:a17:906:c1d6:b0:a55:bf86:3ccd with SMTP id
 bw22-20020a170906c1d600b00a55bf863ccdmr497921ejb.40.1714077280048; Thu, 25
 Apr 2024 13:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240423183247.335791-1-marex@denx.de>
 <20240423183247.335791-3-marex@denx.de>
In-Reply-To: <20240423183247.335791-3-marex@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 25 Apr 2024 13:34:28 -0700
Message-ID: <CAJ+vNU1fvffzukqr0-u92EyLqXHiwRkvs3CA+1K_A+9p6xrgUg@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: imx: Convert i.MX8M flash.bin image
 generation to binman
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Simon Glass <sjg@chromium.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>, 
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>, kernel@puri.sm, 
 u-boot@dh-electronics.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Apr 23, 2024 at 11:33=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> Rework the flash.bin image generation such that it uses the new binman
> nxp_imx8mimage etype. This way, the flash.bin is assembled in correct
> order using plain binman, without any workarounds or sections assembled
> in special DT node order.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> WARNING: This is very likely to break corner case uses, so please do
>          test this on your platform.
> NOTE: This also opens the implementation for proper CST signing etype,
>       the CST signing would look similar to nxp-imx8mimage section, and
>       it would likely wrap the whole topmost section {} in the binman
>       node.

Marek,

Thanks - this is neat and I look forward to seeing a CST signing etype!

Reviewed-By: Tim Harvey <tharvey@gateworks.com>

I did test this on imx8mm_venice_defconfig and it worked great:
Tested-By: Tim Harvey <tharvey@gateworks.com> # imx8mm_venice

This likely paves the way for removing IMX_CONFIG

Best Regards,

Tim
