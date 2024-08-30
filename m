Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0C5CA101C
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 22:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C63C08888F;
	Sat, 31 Aug 2024 00:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A6u4+Vjg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 531AB886E5; Sat, 31 Aug 2024 00:44:20 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 031E388D14
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 00:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-533521cd1c3so2748775e87.1
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 15:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725057856; x=1725662656; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TPc2D1Bq3gFngKn//slA/dPXZIgd1zzG1lPMW63aCss=;
 b=A6u4+VjgvsQ07ytjTNcfepYWhnBYX501pj4W/1LmmCNjtEGvqDoIxNPl7C4X6XEEMJ
 rAPLdtnoPEUNS73EjEq6wpsGBnx7ZAcrxdJ8Qpf/5gEOe0vRe3OhxM5HWZ3HdVei8Ga5
 pVST+swOvh7UJ4JRtjq43tSbqrHQ6IfJ9Czmt87GKn3qF2hYZJJQeqqaaGPd8oZtwHgV
 BKnjldjHSFMoYwt9IisheBsc26paxrD4c+o37bS2diXAFDAUz8xy53hfLt3B49AIUVjo
 ryYs7h1V0HukteCYspWhIpyEIykW5Ure6tr169Co/Yl60O3mckS8MZk6VVGMt3M+iBPQ
 Kqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725057856; x=1725662656;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TPc2D1Bq3gFngKn//slA/dPXZIgd1zzG1lPMW63aCss=;
 b=cDIcWCjhk71ryoT1qfZz4LOMuUtLr5gDSAY4O2LJCEgPbxBJzrsJOoR5bz9pxw/qx8
 +U6GUblfD61padv7RGmDpO2CvN5uGa+37VNdFEdUaZSEnf9dAg7bOm8nYK94CGSO1mjh
 GPhe7Z68RUF6bK6uTMCVlMhwbeHCcrisZmoP94cnbe469BWkKiT2BYy59f+3nRD6XskU
 HYc/BgEE9f6gRbT4xIIAnNRxK1IqiNvRqW0U35MXo66xfzyl4kp+2kJhTCrwLPtP3tod
 uWoWddEhjJVJWW52dTkPc8UXhgPiy0N1wnHs8dAbAKu+yjFtYwF/WeNMtrUeK5OmzH4I
 8U9w==
X-Gm-Message-State: AOJu0YztQw//4duF6ytSezwJkDuIx8AJtrqQGQkNIrcU0KQ2DzPFCho2
 m41kuXKlZUbylSai8CO/CuYpy73TockxG6Q3qLiN7G71wHKlVx1+Do1iJsVwBWdWPChOHH8Xnpr
 FcQsLtQFtXmk0d8qGSOrhGIidTmAj/yma7+fDNw==
X-Google-Smtp-Source: AGHT+IEUsA6wsox9JMLBmQ3GtX6vg0xr2rmKkEEytRu/QzjTwtqhXjTaVmgRui3EJLf/P+Oat4tImStylwLUs4cDm+M=
X-Received: by 2002:a05:6512:3b95:b0:52d:582e:4111 with SMTP id
 2adb3069b0e04-53546b36865mr3142206e87.18.1725057855170; Fri, 30 Aug 2024
 15:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240826143851.8020-1-marek.vasut+renesas@mailbox.org>
 <20240826143851.8020-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240826143851.8020-6-marek.vasut+renesas@mailbox.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 31 Aug 2024 00:44:04 +0200
Message-ID: <CACRpkdanZmv+eO-sTfzCQ_wasLM=N5GzfxNNkGxTgQFbZ=Ji1A@mail.gmail.com>
Subject: Re: [PATCH 6/6] usb: gadget: Pass struct udevice to
 usb_add_gadget_udc()
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Zixun LI <admin@hifiphile.com>
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

On Mon, Aug 26, 2024 at 4:39=E2=80=AFPM Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:

> Almost every UDC driver already passes casted pointer to struct udevice
> usb_add_gadget_udc(), even if the behavior is not exactly correct. That
> struct udevice is at risk of being corrupted in case something modified
> it in the UDC core, which does not happen right now. Switch UDC core to
> use struct udevice outright and drop the casts.
>
> UX500 has to be updated slightly, as that is the last place which does
> correctly use private struct device instance.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
