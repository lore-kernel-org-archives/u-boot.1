Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2129DF94CB5
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:49:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87CED84333;
	Wed, 22 Apr 2026 00:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Tg/qmHLr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE02484355; Wed, 22 Apr 2026 00:49:38 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99DE0841F2
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ba9ad0fbc3aso169310166b.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811776; cv=none;
 d=google.com; s=arc-20240605;
 b=GD0agNUiTtfx18y0RfBGTK5+VepW9hbha9w3MXMSAJXDuRHIgxcDUz25N/sun1Y+1S
 2smFA1HGNQnMQk3hLjrggdNaiO9UvRREJYWgPbqfDfK75sY6qR1yU8shV9GqAO7DeBw2
 U9+OgpF24zufyi7rdNr2kOP0nqbASKvMA/eimVhnnQ5UrQudg64ATCKpcx4x7p7T8E/K
 mrS7jFcc/rMNzBrrREPGXXZE3ns/veU15+MqYYJXO67TLNQ4dUmAccvVMGPhp1OasYwU
 ceCnay6vod42yN1HDPO54ZFWCsEdZqs7A4Km3K8EV81O0FSNAluDR6yPGXPC88PvXGmX
 94ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=owvtQLYNGntSyvozJirvvmVtrDkE7aYwHc6QHKSoItQ=;
 fh=q89F+Hk236NBin7Pn625k1/DTCSlW07o+Hb59cGfDWI=;
 b=ODuY7XHRq3gXYskmUrr0SqE03PRGxKiux11Q3RCnMblIiAjsUqO1/xw1v/N+s0hs4p
 IbnOFkELUs3E1rErtdHu4AZ5jZfYqjAVE77F/LJIA6TrsMR8ajdzVj1phnE5iyk4YSiG
 6UQUpc5Jkd7UqFxNnc5AG+VhR6AhK7ErTgMH0ZgNmgU9PLAKUEW+6ziqrHTleYKxpv8W
 khlJyJj1S960L3VYrVRvoF6x3tFjvN5W0pDr9k4By8gJfJ4EaJKJjGOKL1qzeH0DZD2U
 JZ9BH74ZHwxo6A9c1xhjwXyoNIZhi9SLK0S8BudqJwBMvo51hIOywiAJJYQPeTJBpJO/
 xb1Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776811776; x=1777416576; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=owvtQLYNGntSyvozJirvvmVtrDkE7aYwHc6QHKSoItQ=;
 b=Tg/qmHLryA23hUfGvc/Abdk+b69ysVAudVsO1JlrHikILx/0IBKGEEfguIoo085ii7
 3CUeS2/EL+/q36VQoLWzAzAoswWKMByCAhhl/hG0R6F8R71BwcOC6CeZRtZpiYORADxM
 iD4/bOhJ66wz98QJkw9siaigGIETOskg2GqKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811776; x=1777416576;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=owvtQLYNGntSyvozJirvvmVtrDkE7aYwHc6QHKSoItQ=;
 b=BD+Aj5dtj8gYDFqlKRkv88ALmgNsTwAmELhJjS5z5Buz4darkyoGLQNQjVuxO9M8lh
 KPI6WudKW2nK3UGgc7YoKG1UkgMd16ymDk7VvxY2tdzJss2M8kjuTOEhHEIg7nwkyBNd
 zbk95bh5NpMmcyrWqMiIXcyJ1ZasTNsiL+96Jf7GB/CmstbwoQHzmpVvyvKvIo3AFCEg
 bclHnoftl8j1xKu+r1/U2z3KF7OCvtlhSHwoPHDS+4lfW2zhJuZUm4GH+HnTUW05vRNr
 WV3C4CFqCWmIzD7beufXuAsKkGupeZSmI1uZfCHRbXOV/bclVlxcUBRyyNCEgP/Ahf33
 dg9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FSfj7E+dnb2vcdI6tpA7llLZ87lM3kWzNcczec0wk3Y1/hwDZNoi9psM5K5kHeYyZ9Zwyh10=@lists.denx.de
X-Gm-Message-State: AOJu0Yyujgi5WXO7+OTzShgGkOyleJ76YxW+rtgmTvEKBjGUI9ArGeLw
 mQkxPlJf6JUE2thTcX3tSTrNDyqCUUFxL7KcvVnOfhnrlHODBWUfncYyGCWbN21m1mRUPpiPxMH
 I1N+nhQKLXX4nr9lFHmULLW7EkB+6nAbxhZjwZVgy
X-Gm-Gg: AeBDietaPqRk4bkrN04Ip3OSRDrwITPT+hY/Q3XY4xCPwcXFBZQXs8pa6aF1uE9YF1S
 sZaguYesQY66UlBDAJnmswi30kSMjJ5pu1+Mc+Ok1a2ELdLNjoOSem9bihZudGTc11gw80iz6VX
 78V5VVCLCNib34vle+9dTNC46n1MXe348hd7rv8+9suf78QJ359s6WNe3GGQBGUU5dtf87jERvA
 R6S6MC6iR+ouPFAT0tdWSDnTtYY3xi2iyaps4nnHgKSmr+KQQSRK7btd9+/a5B1NbiJsqOwWHuk
 84WQ5AGDkhAPNyCn3YZo
X-Received: by 2002:a17:907:1b1d:b0:b9d:ffb1:17aa with SMTP id
 a640c23a62f3a-ba41aa16185mr949784966b.24.1776811776042; Tue, 21 Apr 2026
 15:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260421044555.368486-1-gurumoorthy.santhakumar@oss.qualcomm.com>
In-Reply-To: <20260421044555.368486-1-gurumoorthy.santhakumar@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 10:49:21 +1200
X-Gm-Features: AQROBzBhjEaqyWw7FIcfcSuOr8LOt05eYooQ3zC3h6Yx7wdieQGUPTmQLuzXHb4
Message-ID: <CAFLszTgjn4OokRZD5E57DTnOqJ+5Q6Vc9rNb5Xwn1RPwW9dfKw@mail.gmail.com>
Subject: Re: [PATCH v1] serial: msm-geni: configure RX watermark register
To: gurumoorthy.santhakumar@oss.qualcomm.com
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, trini@konsulko.com, andrew.goodbody@linaro.org, 
 quic_timple@quicinc.com, swboyd@chromium.org, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
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

On 2026-04-21T04:45:55, Gurumoorthy Santhakumar
<gurumoorthy.santhakumar@oss.qualcomm.com> wrote:
> serial: msm-geni: configure RX watermark register
>
> The SE_GENI_RX_WATERMARK_REG was not being programmed in the RX
> setup paths. Set it to DEF_RX_WM (2) in qcom_geni_serial_start_rx(),
> msm_geni_serial_setup_rx() and _debug_uart_init() to align with the
> Linux kernel driver behaviour.
>
> Without this, the RX FIFO watermark interrupt threshold is left at
> its hardware reset value, which may differ from the expected value
> and can cause RX data loss or missed watermark interrupts.
>
> Link: https://lore.kernel.org/all/20200227132223.864425794@linuxfoundation.org/
> Signed-off-by: Timple Raj M <quic_timple@quicinc.com>
> Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
>
> drivers/serial/serial_msm_geni.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
