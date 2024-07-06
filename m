Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC32C38150
	for <u-boot@archiver.kernel.org>; Sat,  6 Jul 2024 20:50:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44897884FF;
	Sat,  6 Jul 2024 22:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DGPEKdhi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DDC8881AD; Sat,  6 Jul 2024 22:50:01 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2647884FF
 for <u-boot@lists.denx.de>; Sat,  6 Jul 2024 22:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52ea333534cso164239e87.3
 for <u-boot@lists.denx.de>; Sat, 06 Jul 2024 13:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720298998; x=1720903798; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FdLpN0zOuoYNx9AzIdd8rPZMD76ExW+b+mlKqtIKKac=;
 b=DGPEKdhivNkhO6ptypxlAnS3xrKOrkxjPrs6qOj9yIWbZHpGFt9YHqxVoFLq7fiFl2
 olmoQsg9Y85ZsLhaHOoRn4x24Sc5xW9klQM4AsXrSuUtYxu15qGfAnPIazTElXHBV96U
 yPVVS2hWALzu0hq2oHxmJR/PWBEKlkGgjCr5VVrDF8jbBcbL6Wz722UG7xiw1T2BCawc
 JABdcUsYE0KPvOlOTchJM4nZjCuJIq+iNLUCYgzp3uaXMPqD7R8gDYBXyC8/p5b4twNq
 pmTE3Nf5EkyeZRDxOLqf1eF6JuYxsEYuL/+aMUhRdSy34hUtV58vTNCPIieysHT+lC3E
 URVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720298998; x=1720903798;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FdLpN0zOuoYNx9AzIdd8rPZMD76ExW+b+mlKqtIKKac=;
 b=mVnoCE3CsHn62SpRUxQwY4REp2bfwkYZkeuNb+BwmN9WegKC3ODSpUd57gfQKV/FAy
 K16nGcndh/TXgaIPge9AIfKjosx/X2TU5UJuGZVDCCw9MZybO1Zs6gCspmbDP7mwaLmT
 uwdRu7VBgUn7StmpJRdaG2dB9m8tuGl5n2nS9g05ZQBIZfHUe+cqvmNoOp2NilPx34dx
 LobJFWs0DYjS9QK4k7DCxjyBkeYqIdTmDNIdJHd1wP/Fm8p6WLhaZl50hI1pgnjTLkiw
 v6mDZwxQyJUcBGN0EsUaIj4zzmJTNzVObMNuACDSlM7LXC9DoDpyPfYQ4bK9am8GzFuf
 ldRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYQxndAvOsCi6ealivTovTzHkErBhjd+/BDH/xtwTPyTYo5xAS2J4vuRV/HexX/fWnMnl7BC86uWZ1/jcKmUOKCSs1lw==
X-Gm-Message-State: AOJu0Yz3pA+nhfSbjA0l3v6mKER4YSlR/CePofMS4nLKjnscyR4WqQ1W
 fuc9RQiM7PRhLG6Q6MmpxhRM4BUWcWaUcleo6ng1NrN+FBnoCBc977XiopJN88X0ylP8WwpI43F
 4IWpK07IWcuRIe5dWVF63OXbIZUQ=
X-Google-Smtp-Source: AGHT+IH1hcYDvH4+eh+kteKggHdo5OaffseHStO/Sjr77E1N2QYVSPjF7ZQNP/ZpCXjxMUlWiPJ1zYOR8OpHzMHaw8I=
X-Received: by 2002:a19:4308:0:b0:52c:ce28:82bf with SMTP id
 2adb3069b0e04-52ea075dd8bmr4248084e87.5.1720298997987; Sat, 06 Jul 2024
 13:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240702102618.466652-1-michael@amarulasolutions.com>
In-Reply-To: <20240702102618.466652-1-michael@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 6 Jul 2024 17:49:46 -0300
Message-ID: <CAOMZO5BC9D9yaBHu_Z=VfGYVB1ZOcgeFnSOEq0pY_nis2mrHnA@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: imx: Fix wrong flags assignment clk-composite-8m
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 linux-amarula@amarulasolutions.com, u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
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

On Tue, Jul 2, 2024 at 7:26=E2=80=AFAM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> The mux flags (u8), div flags (u8), and gate flags (u8)  are not the clk
> flags (unsigned long). They have different meanings
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

Applied both, thanks.
