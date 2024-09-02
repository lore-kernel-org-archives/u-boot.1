Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DB7CA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 17:44:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E06A88C67;
	Mon,  2 Sep 2024 19:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dtEzJ2//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADAFC88C75; Mon,  2 Sep 2024 19:44:37 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA40F882EF
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 19:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5353d0b7463so7540807e87.3
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 10:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725299075; x=1725903875; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XDAJSLssxS9RoXx2ItZbFyzOaOqU9gtHRrEGJyVpv/k=;
 b=dtEzJ2//GSLUhvjk6Hi5t0TPE84jSWY2w6KG7ChcmAZsUZJIl/5PGfUDUfaRWia2F/
 f0/oymsEKdGmXtEIrrME84/i2onbqBs7saRa6xPCtaXlxg9LmqM67eKJwkdCi3WU8Bhp
 ibiCUXz0PLPtzlXdVpEYyKl0C0f5X3Go2GQsut/aLJj9rusrB8KQma4zuUQQ2PGTlP3F
 Wx5NE7n04R6IA+zWj/vJLXOeN5cDwhULfoK0b3gjDX2Ma9qH9GT9AMaHj0v/pY96ZZzk
 8auJnds7pcstWf0XmHJsSCAxCe8HVV8H1beM2+hbbYGm+z34myebwZe7HLBcHJcE4fmN
 pTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725299075; x=1725903875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XDAJSLssxS9RoXx2ItZbFyzOaOqU9gtHRrEGJyVpv/k=;
 b=WWM0oq7EQiWF+uNb/0Yfs6GUl6geIVJvFf0HezXTKeAdz4ZCTxYEq+/tXz/aanx0jU
 cH0Yg6pD7LrYbnu3nhIhwyTLo36kElk9+DWBoOg9t0ro7O0/XE7QVXPC1UJNO1jP5BFS
 9Lg7rLrUDnB2O1eUdPtoIWWw2c3qwQllr//7k3Ijch8W8bJdmh0nTGG+oZ3LjuE1qJGG
 JNRRTdV9QUM0Z2gKb/zRIzSSjyO5rJ4XsJDgiuQM0zbpc8KjQSCM4IyUZo8agwX2MqYw
 1K6kkOrINBoktj3RgTbaz1W1j2zNry1n02nVzEIpl2/PGlUxOiet08WfNRAfhc4KP3EC
 Yv7g==
X-Gm-Message-State: AOJu0Yz3M5RFGAXhxgWCwxmaKSFUtGS971F3YcmLmDaDc6uu23s/h/17
 1UAyNnlCtyaOfG3Am55xZtJTkXuhOBBJR01v1Cv3DFMJzAt7LFoflz4FrtAQT43ipu44RSFVIEc
 vUT0V5+hrQc8dGxRIR/lYAIKDdT3kMg==
X-Google-Smtp-Source: AGHT+IHJH/18tAmIslMoSYi/k2zoiAYkZaPRYdc7gHYwQm6WL/InIKhO/mOc/+Q9L66lslDGmTpvKPJraxj15K6KNH8=
X-Received: by 2002:a05:6512:3e28:b0:534:3cdc:dbe6 with SMTP id
 2adb3069b0e04-53546b1968emr8971353e87.9.1725299074838; Mon, 02 Sep 2024
 10:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240827200441.217109-1-marex@denx.de>
In-Reply-To: <20240827200441.217109-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 2 Sep 2024 14:44:22 -0300
Message-ID: <CAOMZO5DGx7wSTfPi-+orPAh+-qFDH8y49TP_yBHcrr+VxdCOBw@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Make PLL settings configurable at board level
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>
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

On Tue, Aug 27, 2024 at 5:04=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Staticize intpll_configure(). Add weak board_imx_intpll_override()
> function which can be defined at board level to override specific
> PLL frequency settings early during boot. This can be used to for
> example force faster CPU core clock frequency if the hardware can
> handle it.
>
> Example of increasing CPU core clock to 1600 MHz on i.MX8M Plus:
> ```
> int board_imx_intpll_override(enum pll_clocks pll, ulong *freq)
> {
>        if (pll =3D=3D ANATOP_ARM_PLL)
>                *freq =3D MHZ(1600);
>        return 0;
> }
> ```
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.
