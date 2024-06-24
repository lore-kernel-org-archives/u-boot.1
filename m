Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F186CC2D0D1
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 13:39:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E464882BE;
	Mon, 24 Jun 2024 15:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H/oe5tVy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0418882BE; Mon, 24 Jun 2024 15:39:44 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9375887DEA
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 15:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-71798c1488bso188941a12.1
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 06:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719236380; x=1719841180; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B2GoULLKfMukg9eDa5x05DCYJ5F8Wzj7mxrAOHKfQCs=;
 b=H/oe5tVyTCBaoQnyeELUVsdtIomAxtdmu6+v9l6guEHgRzKQo8BaZlcB7nEsCS+lX5
 Pte7IhstUhomEHsJO2yf2Yap9wo7NdLgWvApPPJezNJOS1fX3h6IvTz+Mmwe4RIVC3Yk
 7H0Xfa726Fw9L4WcahjvijPPt12dESfQoignrhT+hQ5UAgFCehwTGj61oXKoxhh1upot
 uYnbKXwT8pkTISvNMePswRwti1zWKQuW65HDtN4GE4PuHYdp9U86RdIt0rj7G2AAwMFO
 BZ9K1C1ttDvAgUWcNZk5lr/Ri59kWWsyHdn0+Jxttbulq9Ec5scjsc4zzTJ/p/M2Mvyx
 GnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719236380; x=1719841180;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B2GoULLKfMukg9eDa5x05DCYJ5F8Wzj7mxrAOHKfQCs=;
 b=O14uidS9WgRvVBhErRsKnC0IcJ2XPHQqR8KEYvDYrQMO7T5wqTFCqygAP4J0MVxqxF
 6ju3+mYsgD9ETEAZEvY8PYaRidqzbmzjFgS38Khl9d12FFVO70nhGlpqpQMXieXt1Cd7
 RCSe7lRKn9gmj3LqFSE/QWw002MSCNoEAMCmRA+/FKjCpbVrKsq1dP85AAemDpRQdi2F
 LIvVto4Iu/YNTp/C/WHDqpYQAigZlJImQG4XBmZ8lBdkKo7796PID/3Azty32QwKDm7J
 cIudxJMMesDFpQ9CXg/U8r5zrdSJTOn0Kqwv7t/M37wIWcHqredu1qnbpVBNpeHAHacX
 amQw==
X-Gm-Message-State: AOJu0YxuJ2AbFrdhK/GEG6kROTZ6Wh/1HXuxS9+2ZvCJ0kI41w3Mr9iI
 y28N1d5ki3DubLNWLzXzusAIP57UbxMlwfoffrALdeVuOnfBHIG0vbsQf/hwmfJJAlwBxKIXb7s
 L3LMF6ROU+lFLynS5JR5EbT5EyVE=
X-Google-Smtp-Source: AGHT+IG0QUG788q0mQp3+hVX78p3pejpcuII/uvhoirhEgK0f8AB+vOKSYXCf7iOTY2YYdi+wFilj9XtStz9aUz80Zk=
X-Received: by 2002:a05:6a20:3d86:b0:1b5:ae2c:c730 with SMTP id
 adf61e73a8af0-1bcea5b2a1fmr7178792637.3.1719236380049; Mon, 24 Jun 2024
 06:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240619125310.94867-1-sumit.garg@linaro.org>
In-Reply-To: <20240619125310.94867-1-sumit.garg@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 24 Jun 2024 10:39:28 -0300
Message-ID: <CAOMZO5Bq6wk19MZAWs+6GAEMrL4dgnBrgmpuMn1mxKN21WgwNQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: imx: Drop redundant imports with dts/upstream
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, patrick.barsanti@amarulasolutions.com, 
 michael@amarulasolutions.com, trini@konsulko.com, festevam@denx.de, 
 aford173@gmail.com, peng.fan@nxp.com, sebastien.szymanski@armadeus.com, 
 sjg@chromium.org, xypron.glpk@gmx.de, marek.vasut+renesas@mailbox.org, 
 afd@ti.com, bb@ti.com
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

On Wed, Jun 19, 2024 at 12:10=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> Drop redundant header imports with dts/upstream already providing
> updated headers which have been checked to be backwards compatibility.
>
> The imx headers which aren't present in dts/upstream are as follows:
>
> - include/dt-bindings/clock/imxrt1020-clock.h
> - include/dt-bindings/clock/imx8qm-clock.h
> - include/dt-bindings/clock/imxrt1170-clock.h
> - include/dt-bindings/clock/imx8qxp-clock.h
> - include/dt-bindings/memory/imxrt-sdram.h
> - include/dt-bindings/pinctrl/pads-imx8qxp.h
> - include/dt-bindings/pinctrl/pads-imx8qm.h
> - include/dt-bindings/soc/imx8_pd.h
> - include/dt-bindings/soc/imx_rsrc.h
>
> hence these aren't dropped yet but there was an unused header:
>
> - include/dt-bindings/pinctrl/pins-imx8mq.h
>
> which has been dropped as well. There shouldn't be any funtional impact
> with this change but it rather allows iMX platforms to use upstream
> dt-bindings headers in a backwards compatible manner.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Applied to u-boot-imx/next, thanks.
