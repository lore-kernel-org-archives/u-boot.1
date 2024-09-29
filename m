Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D0DCF6497
	for <u-boot@archiver.kernel.org>; Sun, 29 Sep 2024 20:56:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEC67886B1;
	Sun, 29 Sep 2024 22:56:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R8Llu9TB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7788688D61; Sun, 29 Sep 2024 22:56:00 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2CE2881A2
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 22:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-53988c54ec8so2332211e87.0
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 13:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727643357; x=1728248157; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rzy0yXvRmj/HlYGPi9Np5B1XHxrfWUPhuK8ARtHfZrs=;
 b=R8Llu9TBKXfbx7XatvLNoO0gFqzHj3s8jZIV3iqrVDJAQCWRo1hI1STKEGFWQOoYqa
 UX74s47/pX0fOGgiham7nbCnqGkh+f9SAsYk1SwaewbwR1/dWHApTucYMBzjMCdYOLSe
 gKj5iU6h7TUTsrBjUaxB2I0gczk0/CD20YGwERgh5G9D088LDesWjWlO97k4NrAhti6b
 bUDG6nUs5WIg8xtYrkn74CbEiAhtIvQKhS3Oc81OViyw+9J405x0YdI8tqDV01U3cBKJ
 M2gvrc1/3ijI30R85V6jVZHVYkFi6Blm2T3Bnyf/YTOYSHg+kHofxi1XxFrU+IYfdyQU
 znDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727643357; x=1728248157;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rzy0yXvRmj/HlYGPi9Np5B1XHxrfWUPhuK8ARtHfZrs=;
 b=Qnap1vNjYQQGq2gPFxzHAAH0nHONmPx8khzwsKRq4zyHhEHMwlw5JIPtuz5mbOaamq
 L5QMMvOv06w0K8atjkPJM3sAZsFNf1koB+1B62BaOst8OGuRT2bZgaF1f9imoxKRwlS9
 8+z8gh1N5+PPuBpFiEIBVuIB5+PbSNJf+dFZttROR8KW4f1qw0OXBwEMeN64zcnqTYgU
 /k/S33vzTWacMjM/44sbja8mHjDrlWvrP8cynAsWedlRJYbNzprDHzucbZrIK4BbjL34
 /P2PO18qvbGlDWRQ+LHVW9gEMx/5e12N+1zailhYS5FT4BUNYmNtXSKWHIULm7KEkuhQ
 pbng==
X-Gm-Message-State: AOJu0YzrjnfmZOd86Y+tHnUE3wefhkH+oCL2XkHeZdlhvUUZeX0mEMhS
 wTfmDawkGYgiAZBTMba6YFPBtesG4F+U66Xyssgvs4BKPClt1SGUcmEllbnQDjDWgGPO2AyPGub
 x/7T1zY6KdI2I4rdQp4kiviiRZUk17x/f
X-Google-Smtp-Source: AGHT+IGtc91Ft650KKvBXzs/LnnAwkr2aX/EYZyCPIgFYClN1nP5uFW57OOH1KTBs7ddBpM95JP1bygaHH4Wel59dho=
X-Received: by 2002:a05:6512:1293:b0:535:82eb:21d1 with SMTP id
 2adb3069b0e04-5389fc8422bmr4952859e87.57.1727643357090; Sun, 29 Sep 2024
 13:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240928235325.358821-1-marex@denx.de>
In-Reply-To: <20240928235325.358821-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 29 Sep 2024 17:55:45 -0300
Message-ID: <CAOMZO5COHQ7GhrM3REO+0obQhL5JCRGRKcfVvK9f2MRPfcFgkw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: Add support for DH electronics i.MX8M
 Plus DHCOM PicoITX
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>, 
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
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

On Sat, Sep 28, 2024 at 8:54=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Add support for DH electronics i.MX8M Plus DHCOM SoM on PicoITX carrier b=
oard.
> This system is populated with serial console, EQoS ethernet, eMMC, SD, SP=
I NOR,
> LEDs and USB 3.0 host used in USB 2.0 mode on PicoITX.
>
> Matching Linux kernel patch has been posted:
> https://lore.kernel.org/imx/20240928234949.357893-2-marex@denx.de/
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
