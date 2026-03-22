Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B34FC72AD
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 13:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28ADF840B5;
	Sun, 22 Mar 2026 14:44:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G81edBLs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25BBC840C1; Sun, 22 Mar 2026 14:44:13 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F105E840A2
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 14:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5a1443780c4so3647197e87.0
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 06:44:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774187050; cv=none;
 d=google.com; s=arc-20240605;
 b=fsmE6W4CvOofR4jVcpgdJ/jlVaszCatQvGgwQsEwnuINMvcWKdxsMKxSQRb3fuGGv8
 CJj2j57qNzGwTel7kjcJXqUev2c8x16WIuW5DzFf1nV1FTTLXvqj6x68LKM4a9t56DLi
 plbIEUB/GsoNW7GGU8j03FzSl7LOD3swJDfbgS3UruXN6DiU6l2JL7EjXBbZxHRmAMhu
 p2txuUAgLA5d7rgQO3cQ+75vzoDQQW7USHj0RPhmEz4a5UFBXB2UEkfTUgmGOqfww1nS
 DxUp2nHAs2pW+YWR41xfHSBKklptj0qU7uFPJ9MW7pgQsJD4jQjFYJI2CkxUlrjL/XMM
 l2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rvep1E+zfwi/o7h5VDVD4lEeEHl4h3SPxxd1JDvy3lI=;
 fh=mYEfraaR+GBhI8TU8IK4P5hlgg7Wwawa3nYHIMh7uWo=;
 b=ZbmquaxeL2exMhYkfRUBQbTDdANCiwpNXnEeh+oTX56KNzJkY9HKJi0qU+EbhQAAqG
 XMxQS4MMjhJt3WwbpnRnMWhv3owJJ9tiEg2D7kruWsosj+/KfU/Ux0t9E8c9SwVTCmtn
 kpcB5IGmhV6ufw8J37DxxeNEGImlqovmtH6IP3ODHTSOMkeJCHmqjxFQFFfDd64xcaIb
 ePYhoKsG/FeijzE3JZI9ogMgZncSE7RZkZTwGDGives9PyEVW+JpXoT7hbTyiBtljPY9
 1r3MfBm32yC/x71mBcFmvv5vt2FqkcFaKEq3i12I4vP5y+TGl5W6SHBKiVYLXUMfWkuA
 rg9A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774187050; x=1774791850; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvep1E+zfwi/o7h5VDVD4lEeEHl4h3SPxxd1JDvy3lI=;
 b=G81edBLspZANywaIqOGpFw8jvVG3knjtqcWIpdwNIKory47a5MhFdomCtTy2fJxxOw
 SqjQZiV+WnjT/lzDHwodSatKI3haf+boRmMWdVKGffAYV7a6j+Fe/27utinzYpw3nnf9
 zC7oE7gJS0ElyPWyuBUacdOO7dbqXnMt/Zc5zi33x+UfN9Aiv5PCOE+v/PqOQ7VA3d6a
 FvCnrwyGRTTuBBfjYyJHqdedHX4FULwWmOV6Tt96jTgHdm0tEzexLrUgz//p1zqbXo7M
 8cn336w8eAc4V6zYZu6I53P2NTEVKcF993svmK4O/UHepbJD/tdm9o7PxGpzsvAA4Zrx
 fX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774187050; x=1774791850;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rvep1E+zfwi/o7h5VDVD4lEeEHl4h3SPxxd1JDvy3lI=;
 b=HMvhbC8ALuNldwxHHdWNSsHRQjU+kV0wezA1wp7d7yqWUQwQqCy1pI3andjxDm3Yg3
 4DZQB2Ky8JKuKqESuJmDO6JzGC0y9OTPy6rRqNcgm0TKhN0I1mRm6QU8mfpVK14PuqRX
 ud60OHZc0IZH0ATkS58CAMOBJmjn7t3yRzidJ8CF/7ugYEUV5mxzdT61Y4Re269mxKn3
 O7VA4tRKkX6YpqCtJI8IbD3D/koEEjHNvHnPvjYm1fBdjGHsuFv9yemIV+P3vGxODr2Q
 mlOyWCAqLHoamVWtQunzwYGmCrwESxYNXtU300cH75uiZcEXP1NayblG9QqpacW4zEe1
 EkAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3V8U67lMUCdByi22r+Y/CR+ffw8r7KWl9aWWzfOuOtmNwlAJ6pdH91iorzz54xyZWh6e3llY=@lists.denx.de
X-Gm-Message-State: AOJu0YxDR2Up1p6fQrHzLxVKrgyYLB5HKLaF7uXXW+LcCb5+ewaqrvrA
 FmJ7hXhBkjOVNP2KK/d5xKjOuNNfdxEX7Vn4LvXdVkbNICdpTe1VriMdVS3lDe2eH+RyzeXSXkE
 QXYcKC66uttGDFdDrEq+Q3IjNfbAAS3ITag==
X-Gm-Gg: ATEYQzxD7jp2BQ0jsoV9rNchFIkjpYKEeiUSi1n8kbkja8qdhGfKZvzkGYAUr41Y6SN
 vx0IcT9BeDQCYB6B/ghvsF1vVTM2kJmZFSwX50pjlVnR+wKu5AZADOC/skA84r5yJVvpRRW2zuw
 1QTSmkWvFX68fFYmru+Ja+V18m6L0KBdS0JC1P/crWzKGkvS0kTGGeqikpcCTuvOizZW5uVrFMj
 lLSA7Sm34VfHfBYhHMzFWsvl5PSrScpBY0WxsT9KQh4mosEsKbyxRQ2nDDBghMbFoujaNOPyKwv
 /Jj8O/yRrx65SH0g6w6w4aMvKPC1z1flGgxZ0HUM5hkd2ze1CsPGqUKDGoQm3OeYDcdk0pk=
X-Received: by 2002:a05:6512:acf:b0:5a2:7bff:b21c with SMTP id
 2adb3069b0e04-5a2855b9d7bmr2745713e87.2.1774187050016; Sun, 22 Mar 2026
 06:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260312143118.1677859-1-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260312143118.1677859-1-Alexander.Feilke@ew.tq-group.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 22 Mar 2026 10:43:58 -0300
X-Gm-Features: AaiRm50BfWsNJp_iQ4Z_Kmo7FPw9GyA6bpvrkO3LNlqhjhmzu277SQqyQTunj9A
Message-ID: <CAOMZO5BfJRsyk81WduOWTZNrun8U4+DMAdpMsge-isGQWc6VkQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] Add support for TQMa7x
To: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, 
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
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

Hi Alexander,

On Thu, Mar 12, 2026 at 11:31=E2=80=AFAM Alexander Feilke
<Alexander.Feilke@ew.tq-group.com> wrote:
>
> From: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> This series adds support for TQMa7x and is based on the preparations for
> additional TQ boards series [1]. It has 512M, 1G and 2G RAM variants
> which are detected by the SPL by initializing them in descending order.
> It can boot from SD, MMC, SPI and USB (SDP). SPI however requires an addi=
tional
> prepended NXP header image which is currently unsupported in u-boot.
>
> The i.MX7S variant boots but is not being actively supported.
>
> Best regards,
> Alexander
>
> [1] "TQMa6 with preparations for integrating additional TQ boards"
> https://patchwork.ozlabs.org/project/uboot/cover/20260312095711.3219756-1=
-Max.Merchel@ew.tq-group.com/

Your series looks good at first glance, but please improve the commit logs.

I have just sent feedback to your colleague Max that applies to your
series as well.
