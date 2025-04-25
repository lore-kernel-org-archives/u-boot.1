Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A07C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 13:55:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03AE5820F6;
	Fri, 25 Apr 2025 15:55:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GJQiEuSN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58ED08210D; Fri, 25 Apr 2025 15:55:43 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EEC7810EB
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 15:55:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-54b10956398so2619979e87.0
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 06:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745589341; x=1746194141; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQKqUn+f6Rn10knKYSHSxedv5v6hbI9b2hZGu/VDgN4=;
 b=GJQiEuSNZd2i7HtlmEOO2Nbt5URtI+P7TyX7kpDVPO0mDrgz/gdDiTPe1KXZo7VS0Q
 NxTziHuEnd85qgy720xsSxmPc6esofFDg4y4tH+neM+RxdxL7rDxJR8/s8R4BCrraktK
 z2/nIrNS6EbpUmtMaSW+u2oG+C0bKUJy1VOpvP2pm2QyGX5W7UhxAMqksqL8oCcL3MiA
 hSKf5mG3f4bCzWc4QixzpCIkICHvoWovUSBIZS7P6QtsWENLQKuIxcCTmwQaKl2gu0NN
 2AoKKQd+WXWEdHKAAnfRWc/PjF7y00IFUjQ6FYcf9DW8W2VYEjF5uJtLiqE32PxePKA8
 xpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745589341; x=1746194141;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mQKqUn+f6Rn10knKYSHSxedv5v6hbI9b2hZGu/VDgN4=;
 b=d0vtAYoLeJnYz8SRi/OMsep5VIoeVtxY1K3wQZzPwOEKGSIUMeg78AxHcDgrqV5CJ8
 QymnpxkGSDXin0GAp3/mI5+lS9J3uvUb7mogJSITJhtmHAL83GRlqRvxk6MQyKh2XkJe
 I6eAw93tgMcToZZTYRRGfdtHSKXv5RC8vc6P4Q7kCr8M5WE899PyjLwarcBF/13eO71c
 qy38aXlQJ67IXz9o6aNQ/b4uKlXtjTwRC65EHrAQlVW2+BNWyBxQGikImgMjSIxiALt4
 emkp0ubyAtFe1kMKD618wz3hdyZiVTyzCsNNBHBSapeQcJ2cxMqlPVr2tY9fJd6HsgY/
 CACA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDkrTD8WX86c9GPdrTGUhT467S5r35iTlCpkCOaHaTItvnLoIGsPqqvtJNJOD/QuqDDR2wZpA=@lists.denx.de
X-Gm-Message-State: AOJu0YxG9jek/OtKjKurBV/yIzlBjgvyBud71c7j6APaQPyacW54GM6H
 IWrfGVWgX4M5jZDX48UMkuweerzf4swmsgLAaDdOjJXS9ZlRWFBPXz4x9c6Bc4B96jTNjpXQK8/
 SO69Fs1quovV3w7p8pZ/pb+oeSEY=
X-Gm-Gg: ASbGncvNIv4MSSG8Vj3KpTlg4X3Shcj7sobxPCbrHYePz0IK4h7utH6oUZf9wAk4M9N
 VHwa3TqVhgNtoVkor0IHFYvhQ/S9ZQvBDA+GhJTmZQPyAncLHUatjnDArif8UAoMbeuw/DEAyNr
 KtZdGhTwnBApA4JtA43PXTj5KZg6ZBWn7YfdW2cGH25vvPHFiVNUWmPw==
X-Google-Smtp-Source: AGHT+IHHxaT+ktv9xIf54440bQywlAHSNH6fkOPKGvtbxdOXgfLNB9MCaKXiHzSawRr9VB+j0zF79fnJqqL22ArsCSY=
X-Received: by 2002:a05:6512:31c8:b0:54b:117f:67a0 with SMTP id
 2adb3069b0e04-54e7da0f17fmr2052516e87.28.1745589340326; Fri, 25 Apr 2025
 06:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250417171101.2566447-1-festevam@gmail.com>
 <5eb55cce-28b0-436a-85c4-dcf86e6c6554@denx.de>
 <CAOMZO5C_9yojvxO1NoNjtTHxD85ZcGd_cK2t-rofyY_Zxm1xcg@mail.gmail.com>
 <CAHCN7xLkDnLX5PHFNjXYn7AFXA5+S22aksgv62PpWpg80ZDQmA@mail.gmail.com>
 <d81112ad-017b-491a-b517-de828dd30c25@denx.de>
 <CAOMZO5CpQ-yv=8GhNv7=yjnA+uzzP9ZmB=P2d+xmhY1ktQJX9A@mail.gmail.com>
 <28b4bb24-4c56-4fe3-ae9b-db43c63290b1@denx.de>
 <CAOMZO5Cz1atyi0OSOrzUfSGiLb-9XdnyX-d8L7un5PuAdkBeBQ@mail.gmail.com>
 <703a0297-24b2-42f3-9fa7-62a78e38f1a2@denx.de>
 <CAOMZO5BitKDL2QRAzBuKK9rdfPsob_jdsYx86CRXJq8RjC8xoA@mail.gmail.com>
 <CAOMZO5B6V4=5et8XpnN0-TkaCSLaiAf2sRw8C+_H97LeU17U+g@mail.gmail.com>
In-Reply-To: <CAOMZO5B6V4=5et8XpnN0-TkaCSLaiAf2sRw8C+_H97LeU17U+g@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 25 Apr 2025 10:55:27 -0300
X-Gm-Features: ATxdqUGEpNfnFyRB_N5qQmqiuk5VDT5YM9pUEa_77717p_4HTEe_u6po6hG946I
Message-ID: <CAOMZO5B4_7bZ_+evgWUsEHtOhnhWtdNi4qavCAyes=91W9qjPg@mail.gmail.com>
Subject: Re: [PATCH v2] clk: fixed-rate: Use "clock-output-names" to name
 fixed clocks
To: Marek Vasut <marex@denx.de>
Cc: Adam Ford <aford173@gmail.com>, trini@konsulko.com, lukma@denx.de, 
 seanga2@gmail.com, francesco.dolcini@toradex.com, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>
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

On Fri, Apr 25, 2025 at 9:55=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:

> With the top-of-tree U-Boot, SPL calculates the wrong sdhc_clk on the
> imx8mm-evk:
>
> U-Boot SPL 2025.04-01380-ga9820e12db18-dirty (Apr 25 2025 - 09:40:45 -030=
0)
> No pmic
> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout=
)
> SEC0:  RNG instantiated
> Trying to boot from MMC1
> ****** sdhc clk is 204522251

I have just sent a series that fixes this problem.

It contains some clock patches from Marek that I missed applying
earlier, as well as an IMX8MM SPL OSC24 M clock fix.

Marek, care to submit your clk.diff patch formally so that the i.MX8MP
USB functionality could be restored?

Thanks
