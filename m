Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6327AC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 21:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2E8F884BC;
	Mon, 22 Jul 2024 23:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f9XAzl40";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72F4587D43; Mon, 22 Jul 2024 23:05:06 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50D16884BC
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 23:05:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52f00427236so321922e87.0
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 14:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721682301; x=1722287101; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pBqTN/BU+J+3fvtrqHGIR8Sg218IPZ75ToXicrbmmZ0=;
 b=f9XAzl40yTk754ktJGGXPglGadnIgXvFQITa/S2aR1GgZGpe1X97WRtPprJb8N7NU5
 vdRYmfR8ihWJAXkFLLgSj73tCgNzAmxjah+XDK1kYqLJDsAm9BZUvHcOBE1OR8YnSwzZ
 1mmffaO0YwOfo5RFA9eEzOJD66rwrU3v1O6h4fkg3prYL/mnN+Q26d0qeqf04o4Vhphg
 +js4Y4DMRGpYgipqkN+CFMVl1WwvwhCHVIrEdyqSTANKm4o3AUt3juXlsnZGv12XSZOF
 gbFx6DO8T7GLObQRLW8aLdlNS6Jx2WxkhyEPKu3ZWopTsudOfssj26Pe1DSb/kB/2wxH
 wooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721682301; x=1722287101;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pBqTN/BU+J+3fvtrqHGIR8Sg218IPZ75ToXicrbmmZ0=;
 b=v0YpsT6tCH+FVnGmaTj1S01tCeT5mLiGIyxOgF8B75uC9gXSP/oetjFBVaHIeTDzKb
 MbGfg2MOLwTI7/0LK0rw32j5LZRSuo523o9HGeAJznbkt++0dQd1L6UIuPuEs6mJ1ssv
 DZ16LkP/w3A8u6O9e6g3xtwwXh8EykqbEa7Y/Vuksje21YOHUaQUUqSzZMp+aICKJpDq
 xdfCbGXNWOxZkFQ2DCIYMl0WTQCMxNO94Plelz04tBbc1GJpUx+cjNLi4ZCTbdAknI5h
 TRZS4WsFLPuEyueHYjrNEIx+Qb8YfgU5zXGPDO7xWszKtn6tO7QrZvJg08nhDpUd+WyS
 XQpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOEGJLzr9FxgiBIaVfAa6ms7P6EZCjYv6toa1aoN3LbJ1q96HFcQkjM+oXpqPwS237NgYodzF9xYHleU9t86UTjFRJvA==
X-Gm-Message-State: AOJu0YyK0XjBCz2p5MMXkxV8PQ+XcDKXd6vd+l9oNuxr1km0AXwkN5Kc
 yHcAOqND6swv60dURltcR5aYu5djYp0lRTA6i0s3mPypHnIjm5pnDcdgejR0CzXcwCrKCMaxwq4
 1XgqmXumbbhKHL0t5OWwtqzHcMc7VRNQZ
X-Google-Smtp-Source: AGHT+IHvap+csdgTD4K+0ECs4hEds2itFJfUOag3CiMD6fHP8sTlRGAzICiZAtGY5b6wpsMsvJxCZXE8UlOANzSWtvw=
X-Received: by 2002:a2e:1f09:0:b0:2ef:2346:9135 with SMTP id
 38308e7fff4ca-2ef2346924cmr25301051fa.9.1721682300596; Mon, 22 Jul 2024
 14:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240712141907.27677-1-emil.kronborg@protonmail.com>
In-Reply-To: <20240712141907.27677-1-emil.kronborg@protonmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Jul 2024 18:04:49 -0300
Message-ID: <CAOMZO5DW6FBfsbRBmpGZx2qwKRb6R4GKUr90Jr7PyumJsGtzEg@mail.gmail.com>
Subject: Re: [PATCH] clk: imx6q: Add definition for IMX6QDL_CLK_I2C3
To: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: lukma@denx.de, seanga2@gmail.com, trini@konsulko.com, 
 rasmus.villemoes@prevas.dk, u-boot@lists.denx.de
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

On Fri, Jul 12, 2024 at 8:10=E2=80=AFPM Emil Kronborg
<emil.kronborg@protonmail.com> wrote:
>
> Commit 727fa4539ca2 ("clk: Add support for I2C clocks on NXP's imx6q SoC
> which use CCF") added I2C clocks for I2C1 and I2C2, but not I2C3.
> Consequently, devices using I2C3 fail after enabling CONFIG_CLK_IMX6Q
> and thus CONFIG_CLK. Therefore, this commit adds the last I2C clock.
>
> Signed-off-by: Emil Kronborg <emil.kronborg@protonmail.com>

Applied, thanks.
