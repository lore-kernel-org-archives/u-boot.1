Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29C2C8303C
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 12:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE0D9803DF;
	Fri, 11 Jul 2025 14:11:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IkQK/KOM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B31AF800D7; Fri, 11 Jul 2025 14:11:52 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E070800D7
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 14:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-553be4d2fbfso2289915e87.0
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 05:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752235910; x=1752840710; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQhcRUNxG9CYSp4CnrjEijLId+e6Ff1JfcL8z6jlAtQ=;
 b=IkQK/KOMCdY/BW6jTC9lcFtiHJ1A6uAgVxT4rflpbIrU2abzWB0wW017Oe2oMij5t+
 X/9PCUCmz1Eo8nlizL1cmNxv87L4Tkyp78ryzJTYzsj3VQOYPiT/tZeddLXgArRy+UJv
 g+/UIcTAMxIqswlhMm7rzIC4059QbbQN15jH8T9zg2f1Fke10yGlAMwm6jUHNPzj/TkE
 zxHbidmftp+Sq0ilIsnhjvZL2hZw8esh+Ql4MZ+DBL8n/0gkCyR9J8CW5hveMo3nMN4P
 ooQUpyt7nRTc32yNbIL9OxSK7y0fUlCNhcZ9bzA1woCrVn1LFA4Fimqux5gBuUbSP3cC
 g0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752235910; x=1752840710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EQhcRUNxG9CYSp4CnrjEijLId+e6Ff1JfcL8z6jlAtQ=;
 b=nEb7hzDxsPgGmOAI+l5BfjsDI2WMtvrpw812Vkdh0iiLpV9HlkDTnX7Xfzi9Zr82TX
 EvyMISPyJGH75y7afLzfy0jzmetlGoszpThdri3bgYZEF/es9ILuMdWqx5G+WkNz7ybD
 PUKxQNO1CUOBiPet/RQg7eYi6iDnU7sf+YTjf0+0IL78R4uZjkO7CXwBUqy3wIwXkhWy
 NfzUxOnEJoVYEz9PSW4d7WCeFZP7s4pc/iAzK2eUbK5ygxtc4IdkIwOjf96CJsIATPQi
 8j21Bmb1A2y17Y81iKoFxA+1LHooHV0cm2N34HNF1lAwvVLzCyBlIICwziI8E6u6fcUx
 0vpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1dBpZhIWL4IkBKg7hPya0Wp8LqReQ7+L693BrmgAGJYwA5X7bQwL52YKxJdMkHn+R/dV+qPQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzeR1pjXeh1zjFsrK4EFoY/GWQwB5cHOFo6nBLR4dItFASK6CIk
 BpkRaBrvIDL4FnJIkFmCaTfgxv7yMR5eU9+NwPV+qKIZZlNtVby7838ggUL15yS7TlodIT4rUdq
 9OpAeoKtGr1wLAYbKgv5mT5yFA3TnyLYqWg==
X-Gm-Gg: ASbGncuAO3C1M8KjgTXZRhWnlM3OB5+bHUXdQIgdKNIjXyGysVgdMiXY1UTVIwxeeCu
 rGVN2uvc9olvZxEBSmvbcN4Y5x4BAaWcSNqT31tG1Y69GIyJeqB42QD6pgaP4fgmUpg+KRnUNRy
 U49GhAronclDk5uaiA1ttm/Tm12cR8izjCfTtk02y89i3VOhQmh9242xvCIIEO79egzwkNvQt5/
 8HCmy4foKlXi/uF92oc0kEQLJ9DXnt1afpUhzs=
X-Google-Smtp-Source: AGHT+IE1cGoddLh92MM/E95Db1wQc4qKpaci2aMDzdlQv0UdrhVYreyV294RxcLZdatoR/ZWtdmbB732siXHoqS457w=
X-Received: by 2002:a05:6512:68b:b0:553:3770:c907 with SMTP id
 2adb3069b0e04-55a044af1c9mr859482e87.10.1752235909212; Fri, 11 Jul 2025
 05:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250627185723.342553-1-ilias.apalodimas@linaro.org>
 <20250627185723.342553-2-ilias.apalodimas@linaro.org>
 <CAOMZO5DP=8Jebnm32mPQ6s7rcTX62dgKqyzyrdco9dHNewyWKQ@mail.gmail.com>
 <CAC_iWj+rJgUGkpEV-vYRei9R-UPj3J_2ix++K3P-ZXK8C7Vneg@mail.gmail.com>
 <CAOMZO5CDkeD633fG-pELUF+QyzW3ftP_eQ3LmrjUTuaidY1c1g@mail.gmail.com>
 <8df9cfba-662d-416e-ac21-5ae6d4448708@amd.com>
 <20250710150154.GC6424@bill-the-cat> <aHC0oK7symjF2hEO@pie.lan>
 <CAC_iWjLMU73F0wQB9Q1YxzHO_VcqqPmy3WOUOE==4k4CeU2BaQ@mail.gmail.com>
In-Reply-To: <CAC_iWjLMU73F0wQB9Q1YxzHO_VcqqPmy3WOUOE==4k4CeU2BaQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 11 Jul 2025 09:11:37 -0300
X-Gm-Features: Ac12FXwZ-yBchKMt9MhLAYC1jucgl_7BmF8RMZYqX5fRyRK83citmEh2DelY_zQ
Message-ID: <CAOMZO5BfxPhDNswGiWw8QgYBkZnoYHHAgm_MB_XdwrBXQv8qQw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: Bump the build system to 5.1
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Yao Zi <ziyao@disroot.org>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, sughosh.ganu@linaro.org, 
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>, 
 Olaf Mandel <o.mandel@menlosystems.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Yannic Moog <y.moog@phytec.de>, 
 Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>, 
 Prasad Kummari <prasad.kummari@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, u-boot@lists.denx.de
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

On Fri, Jul 11, 2025 at 4:10=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:

> That's interesting. Can the rest of the people that reproduce it apply
> it and try ?

Yao's patch fixes the mx6sabresd_defconfig build on my Ubuntu 2022.04 machi=
ne.

Thanks
