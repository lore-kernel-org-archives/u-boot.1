Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E13C3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 13:40:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A66288D79;
	Tue, 20 Aug 2024 15:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PHK8gIy5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93A7885B66; Tue, 20 Aug 2024 15:40:46 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D3A188D7A
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 15:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52efd530a4eso8576552e87.0
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 06:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1724161244; x=1724766044;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nZJ44i3pwYQzuSE5bLwo0SJ1D0jlPW3+G1Ul41n1lvo=;
 b=PHK8gIy5Q+fHa/ghnno/jF/Bcou5ZvOQ+jzd7ZusVR9AJHfFN759NJckmnYaK6S4MB
 7JTgoEugSjP1+P1AAgU+4Kcj5Jbi6cDr1xK5R2uiJamGVnN2nnS31ABMnJaHsSxq6ur+
 VNBDhXIl0KtfK3fltBUN4gGOjnakQNFg68Kds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724161244; x=1724766044;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nZJ44i3pwYQzuSE5bLwo0SJ1D0jlPW3+G1Ul41n1lvo=;
 b=kDBBcHcndhMrRjpyG23W/LQA0tE/Larg586wo7JkOGOPwOslzgbPpQ6okvZMGYvC1E
 vErlzGALlh++zE7VwAfFsGbj0UpCdskVEADx3zDL9OxUdAOAjK+K+gBL48Q0JZAJRl1y
 PSvzYy1JZss5mAYIEG+6hnHB/H+KgWGla3KRpQmoxjUP/ax9Lr7dHZANxdMZH7IKyFd0
 0TMZk6IivB6VFmC8pxyxDao500wa9HHSFRpGKGeUulrOEO4OjR9i7MMAkx0z3e/dwTvN
 pLjXbvpbjkuqFx9I6VRKhGa5E3yDBnBbVl87LRxINpKWXS1Q1vzv++j7i/EhBfW0UxoF
 12pQ==
X-Gm-Message-State: AOJu0YzIh27yJqTmeRv+/ISk+k4rDYcujWjwy1I1vW6oG0aOxVzLb2+f
 jQvUbENR9WHAgJxDaS0WL59FE4xLpBBiH2zVGTVHI1ilPl1JfHNUX/EnGuK/XaFzWDxn5TNyxnn
 Htc2GIEnHYjXGaVtxZRcXzW2qWhEtRCaBAUd3OzvS6cweb6dkqk0=
X-Google-Smtp-Source: AGHT+IFBPfzN0+zsLxfr6xmWQkBcK0OkrutbF5Dm/jZJdzUyhxudsUQPo3Pws2VINIKaYjZHt9631qJ3968YbsCYbj0=
X-Received: by 2002:a05:6512:4017:b0:52f:3ba9:3bfb with SMTP id
 2adb3069b0e04-5331c695a6dmr11407093e87.6.1724161243063; Tue, 20 Aug 2024
 06:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <8d76d952-7f64-428f-abcd-d9563eb9b391.nick.huang@molchip.com>
In-Reply-To: <8d76d952-7f64-428f-abcd-d9563eb9b391.nick.huang@molchip.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 20 Aug 2024 15:40:32 +0200
Message-ID: <CAOf5uwkUtBa1orCJ+kPEUnzBUrBJOTuGSBWDHbDkExADZuS1tA@mail.gmail.com>
Subject: Re: Uboot net phy.c query
To: =?UTF-8?B?6buE5LqR6L6J?= <nick.huang@molchip.com>
Cc: u-boot <u-boot@lists.denx.de>
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

Hi Nick

On Tue, Aug 20, 2024 at 3:28=E2=80=AFPM =E9=BB=84=E4=BA=91=E8=BE=89 <nick.h=
uang@molchip.com> wrote:
>
> Dear=EF=BC=9A
> When I was debugging the network under uboot, I found unreasonable operat=
ions when configuring the network phy, as shown in the following figure:
> Why is the configuration phy restarted in forced network mode, which I th=
ink is unreasonable! Please give me an explanation if it is reasonable.
> Best Regards=EF=BC=81
> nick.huang

Please explain your problem better and what you are experiencing. A
worked a bit on phy network on uboot but you should provide much more
context
on your problem

Michael


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
