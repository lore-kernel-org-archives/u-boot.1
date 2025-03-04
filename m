Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FA0C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:48:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8952D80F92;
	Tue,  4 Mar 2025 16:48:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VEYH2IjF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA2158004F; Tue,  4 Mar 2025 16:48:03 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 730A080805
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:48:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso1103264266b.2
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741103281; x=1741708081; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UmUNYU+Aams7v4/txx2SpATyo8eEldRieqfeH4jB1ik=;
 b=VEYH2IjFF6fiCgAzc1N4oYhdDKj570MBPasprIkcKlJERZATJBR3papK7/WVZy0Jfk
 Y5xLLHbyd6+9JOzHId3d6kZ5+VsdFGmLdQvTtOgwvfQGmW9Y0yMx+c4T4LZ36mkV2VDT
 LGROi3fDiBlRUN1fq0Y6GEfGObT8BmaH9Uc08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741103281; x=1741708081;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UmUNYU+Aams7v4/txx2SpATyo8eEldRieqfeH4jB1ik=;
 b=i+GLAhlgCqQFlSypThAWpjYS6etMv1DXRyxSuC6LbgWnU/nUcf4Gw6giPBK5085nbw
 Wmc6VE3vvSCMUCuCmS7BKHkuQVYPuoBwBTLlYf8LI2yRdoe6+YSfg2HmMeLpRZA0owle
 TpRNt4szB/Q4QS05hOmY6TUnH5Zf69zRF3oWawRdAW4sC5zX4b/DLuuLXJH2/7hAIifm
 WsABtXasHKoej+ovYFbJvIoM8dK+3uQh/tTPYVgpV0+ir1cp4KPdB48BQJJy2I7BNi24
 wcxXshUUmgNn4Cn7lQC7fOxWzP8GPP4sRLpvr1HOlWcl6dAW2DUHBQbGDyrzc/0Y+Vei
 7WaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh2yH8zDplvfZM7FbtUV0Wmb+yBL+raiPte9GoufnLvnMw+bfZFgbLe3cKDuE6cRL2Q8RSVC0=@lists.denx.de
X-Gm-Message-State: AOJu0YyywYeJy+1GbvVeT659QHb2g6/InPVZjuiVabdCuC2nhxDYJSSw
 T0AQsnOHEcr+9zfwADkcsmOOGQnpHVs3pcgMDnjLz85o7ni4lAAisrGppuYJwBnbF/2DMMfB/+W
 E7d8ou2M/6ukYR2UT/AFMByrwcN+GbtCNFUOL
X-Gm-Gg: ASbGnctVQFa/R30DDFvDOMQ1hUHcKw2Qs7W3RJWDjPDyARSJxJYChCMkC05IPU/hcE3
 iA//4bO8wc3a1WuZWV9Pq1d27QvX17wYhl4DZXtlw9lsiMZUj4tyKcw0fFFw19g1DBf3Ie4L4Ew
 RxpFUffPCfOUsrOdruKjUC+DBIPAY=
X-Google-Smtp-Source: AGHT+IHUtC0kwhBTHu5aBDslbbOfZI24mmcp4rx3zfEMWOMW/C99RlTDT3OKtPkyUUdfKI68Dnq//QsbXyVFaYYBH2A=
X-Received: by 2002:a17:906:3c09:b0:abf:46cd:5e39 with SMTP id
 a640c23a62f3a-abf46cd6821mr1415903466b.13.1741103280921; Tue, 04 Mar 2025
 07:48:00 -0800 (PST)
MIME-Version: 1.0
References: <20250224120214.147646-1-clamor95@gmail.com>
 <20250224120214.147646-3-clamor95@gmail.com>
In-Reply-To: <20250224120214.147646-3-clamor95@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Mar 2025 08:47:49 -0700
X-Gm-Features: AQ5f1JrvExaAdRNc6lRgbxN19HZ8L6_wWhZkNdRO9bYB1BxzVJ1joX9U8jG7MPc
Message-ID: <CAFLszTgNMd4yfQeWeiRO_yhJSytZ1XGYMbROk9_bAunzOjpZGQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] video: bridge-uclass: add inline fallbacks of
 video bridge functions
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Heiko Schocher <hs@denx.de>, Guillaume La Roque <glaroque@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
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

On Mon, 24 Feb 2025 at 05:02, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> Hide video bridge functions behind config condition and add inline
> fallbacks to avoid erroring out when using header without config
> enabled.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  include/video_bridge.h | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
