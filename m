Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A5ACA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 13:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D8A588B49;
	Mon,  2 Sep 2024 15:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dW1H50aI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B64188C01; Mon,  2 Sep 2024 15:19:19 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70B3B88AFA
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 15:19:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-58ef19aa69dso3874889a12.3
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 06:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725283157; x=1725887957; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zerHVKIxYVYFNaJLwO00Ff2JqXQkMQ3VpMmf9bgc700=;
 b=dW1H50aINoU+6EuaUiBQhUsZUM7MjJDXUG178J1B6Nb5E8pdKlitkfkt6Hh1Qboi6b
 FvU89NqHg171rru9x8oHqpiQKN/wObqHJJ7X4jrtxcC/y1jdAmkLDDx+eRXh5P22UbWO
 sfkYEiFePMcefXgNA1ScKztOauDtuK+Vmzr5Z9vS8tbn/Y7iFUh0ioiJjaCr8ZxlUR7J
 gx+VOErWRPzDushyXXASJrCbG8oxIn+AaAj2zycJWZl3VTT7jx4MeowsdvLGR+HEbDGH
 9H9PXYeM9uRJrMHUeHnkmeHoIKQzSdjC7xBSyePcfnaPJQQaVPrtiKDAzf6eRyFShHOz
 nAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725283157; x=1725887957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zerHVKIxYVYFNaJLwO00Ff2JqXQkMQ3VpMmf9bgc700=;
 b=FZAawRsro1n1rheMlOBwxrkLUBi7b+TVnV22s4v3zk0hM7Pan80cDwwY59CsaCsKnb
 PCOnkDT6dXZOC3DoRJdYtjXNipEZViw6sdZ//qpGMRQfSgOtIx4h2MX3L6e8cBYrddv8
 udT/MUpvY4MKSvGMD2eNl5T0nw68YbrJoG/wbVosDD93yfdPTc/Ritpdniq1R/8w/fLE
 sB/TZXSZz7VhSSuphR2BhXgUK0XcIy2IEDP6u3NJt6vNy30sHEqTYBOPFaHHUrwuvgWW
 /iFgkoZvtXK8ldM9/aas2kaXfo9jDKMbEfcgjOr0lncFAlG34tj42Z9oHk1DUJIn9S1P
 H+iQ==
X-Gm-Message-State: AOJu0YwGvFbVWeyMs8S3kJ/WvG1pk4uif8mttsnn1tjMbYZgzm+i6HTm
 5scupwI7Ph3Guam9sWwpIHA9jO+MpzxApUmxWF6hzj/XfkUmwXmlssfd25qTxKNkfs2oFqtXCFB
 vY02IjFaIr3UB/HL7mqC3ouCkfX8=
X-Google-Smtp-Source: AGHT+IGzJDq7fpAMOoCRMBC4o6pREj9m5kE3VqXwyNioLZxS1j20wKoFUwod0GTkaXW0Qolaq2CMGGl+oa3uuoEtoG4=
X-Received: by 2002:a05:6402:3490:b0:5be:e01c:6b5f with SMTP id
 4fb4d7f45d1cf-5c24301d953mr5217969a12.33.1725283156065; Mon, 02 Sep 2024
 06:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240902131246.127897-1-jerome.forissier@linaro.org>
In-Reply-To: <20240902131246.127897-1-jerome.forissier@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 2 Sep 2024 14:19:04 +0100
Message-ID: <CALeDE9M2uNVouXb_2zjp7KYjz=wrrC2pN7Hn921mdszmATJbbA@mail.gmail.com>
Subject: Re: [PATCH] configs/ethernut5.h: define CFG_SYS_I2C_RTC_ADDR
 unconditionally
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, egnite GmbH <info@egnite.de>,
 Tom Rini <trini@konsulko.com>, 
 Heiko Schocher <hs@denx.de>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

Tom,

I wonder if it makes sense just to drop this board altogether? I
looked at it for some other unloved feature at the beginning of the
year and I never heard from the maintainers.

Peter

On Mon, 2 Sept 2024 at 14:13, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> The PCF6563 RTC driver needs the I2C address of the chip on the board
> to be defined as CFG_SYS_I2C_RTC_ADDR. ethernut5 selects this driver
> but defines CFG_SYS_I2C_RTC_ADDR only when CMD_DATE or CMD_SNTP is
> enabled which is clearly wrong. The condition should be on the driver's
> Kconfig instead (#ifdef CONFIG_RTC_PCF8563), but there is no harm in
> defining the symbol even when the driver is not selected, as all other
> boards do. So just remove the condition.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  include/configs/ethernut5.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/include/configs/ethernut5.h b/include/configs/ethernut5.h
> index c327bbbe07d..338306dfe08 100644
> --- a/include/configs/ethernut5.h
> +++ b/include/configs/ethernut5.h
> @@ -55,9 +55,7 @@
>  #endif
>
>  /* RTC */
> -#if defined(CONFIG_CMD_DATE) || defined(CONFIG_CMD_SNTP)
>  #define CFG_SYS_I2C_RTC_ADDR           0x51
> -#endif
>
>  #define I2C_SOFT_DECLARATIONS
>
> --
> 2.40.1
>
