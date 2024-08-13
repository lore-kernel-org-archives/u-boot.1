Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5386C52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 16:27:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 483E1889B4;
	Tue, 13 Aug 2024 18:27:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WC848Num";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17DAF889AE; Tue, 13 Aug 2024 18:27:50 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3011E889B4
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 18:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52f008b40d7so908938e87.2
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 09:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723566467; x=1724171267; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGb/uPBeTPK79sKE6gMoM5N9JqJ2ZDClah/Bu/L/dxo=;
 b=WC848NumbqY7q6/Wv0LsJMcxWV3Ef3h8xdttQODbb1X+gwmK2DpnxcDGlrbYLuRE44
 zjyKHDChKsEQZoK9ethKtZCX5kA4kXrEnXJCszKC5G0jM8YIzmKqLzwjSJB+sIelPbQt
 8soGmTnrnrK57pJ+bx7QZTib3zs3Vp20XcARoUvX+KgoahArUHJ1ZseUyF1puBw2dRZS
 jV2BCf18dCtswgTKe3PlSjrbJCy4xDhi3dxPA1/OajAhtpRL82M3IINKqFvp0vvHRaYB
 PE8G+ujn77OE2GPvPe1b9wtrtFtbDEthW12Pwse+ZaXdohBOX95Ou4Hka6J8kfzPNLCV
 IIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723566467; x=1724171267;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GGb/uPBeTPK79sKE6gMoM5N9JqJ2ZDClah/Bu/L/dxo=;
 b=VH1FkbBNLRmpOS5qslogToC8lpx4GuInH5APWkqD6/Q5kkPHh9+xCAduktnKLtRG3c
 aT92SdP3ld0zlpUS+5Z8F2ja5+TRNBcGBAKX5mTV0ECri/2Mz0931cRGUUWn5FoL2LN9
 9Tflzf5CPcnbonUzrOhEPdm7G1SDOMWcjocgLqroBo1U0o9qY4zsiK/v43nHD43FAiX3
 tXlo2Fgg5etWdyYQ84t7+Qyy2zDTJkkrcOSmWhyHmQszHeV0I2Uk3tbLz+fP6b+nhXMH
 mX3t4NUbGZRCaAVzualXZ213GCsSnf4QEMgAHQTbWDGH57t/evFa0zoZdOdklQu4YdSh
 xhMQ==
X-Gm-Message-State: AOJu0YwmIafFM4xHDIYgDBdh3s3yEJSVKObKO7KLqwpoW/gwyQlIe4kB
 pcFbnrKGkQN2MgFjubgP5FX4+pt0HDv4FOvqXpljcf8fu2aLRjBVzl+oGKX5CSUxHS0xsf+xJKb
 hRsAvP9iOSjZ1gUBwB5cQ7iGnYRMb3A==
X-Google-Smtp-Source: AGHT+IHQkRmli2iBXmAMxcvc6QdDWtxmahhDxqTMvdkKqZWCWKenLRKYScTswpUbc4dzsHNT8urNG/Y+mvXc9XW5RAM=
X-Received: by 2002:a05:6512:1329:b0:52e:f99e:5dd3 with SMTP id
 2adb3069b0e04-53215d866fbmr1062523e87.8.1723566466993; Tue, 13 Aug 2024
 09:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240809152548.552796-1-festevam@gmail.com>
In-Reply-To: <20240809152548.552796-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 13 Aug 2024 13:27:34 -0300
Message-ID: <CAOMZO5D3urwToECWZu6WGL7nB_TqPvkDoD4FOgt5jaN3wnOtqQ@mail.gmail.com>
Subject: Re: [PATCH] imx6-tqma6: Convert to OF_UPSTREAM
To: Markus.Niebel@tq-group.com
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
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

On Fri, Aug 9, 2024 at 12:26=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Instead of using the local imx6-tqma6 devicetree copies from U-Boot,
> convert the imx6-tqma6 target to OF_UPSTREAM so that the upstream
> kernel devicetrees can be used instead.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied, thanks.
