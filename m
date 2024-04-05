Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED5ECD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 16:47:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D985884B6;
	Fri,  5 Apr 2024 18:47:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DEoDSVGo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65405884B6; Fri,  5 Apr 2024 18:47:55 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2E56883E0
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 18:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2a36776a2cdso241627a91.0
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712335670; x=1712940470; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hZsbZYaTIro1CXBozhJ+lS0KREYtfJV8/+fBLEXFTfo=;
 b=DEoDSVGo8+PrvwPXosTHUJHVrkpJRVZLlrfEfO1axnyuw3bRioz3Mc8ClN1uo/QYjY
 fWA6LIBuYe5B7t83vItDiQdzTFUXlhYcDXyWK0oLXOavZfQhDUpsO7TqAXERjvTuyFv2
 ZjjZfS3V1f8h/bG79Oga/zh9eFFBAGkjMHMyoIP9zF7MbcyHrOFVtfcGqOz7uzd0uX/6
 2YPuAy4SgNioFxxcAT0u6DPdJ2+39UvVWA/xWz8/Ip60X96HgAPx74qu2NgNdg+QUYpj
 9tfWQiYI1zUpWrfMjKlJlM9HO5KTPSIsQxvCQY6XW7Szact+7QU4iKw1nNowzoy5Khfv
 kFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712335670; x=1712940470;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hZsbZYaTIro1CXBozhJ+lS0KREYtfJV8/+fBLEXFTfo=;
 b=HyUOkwqE6MMke/IidG3V/zANkEVRU1i9p+EQ5Vtju3lGEdgr7PGo+LrGRxVmb7IgAm
 DOjQQgyTxM78n02XVVbTmgRwzyZAlBWLns+PYzwLetm4Hzb39KoCKlNVFF0nTiomCHcq
 PSOLUHxC2nt904EGJw13UC1Ur+2SbldsXQU0AjOvSUVkRXLv1RrvfZOj3sieg0StZ0Um
 Qu72ReDqm5nw9PHgObLXPROmqqCAI3Hi01TTZ+P6jqBATq50UBwC07tsOTW0AIqu4vyf
 2XC3our6MnR1osCHhPScr2d6lmhVq4riXebzhXc+WnkRr0guQiGAmR067amGNGFKPHuI
 F40Q==
X-Gm-Message-State: AOJu0YwNwW337Ln38/kBrSIqo3Xi/gQhQ8lQGd+T3jwhuZQYu5zU5zMF
 vFIeJp3lSmS2kyiQZSGqHpux9BvlaCt29UfKMr+/QmOBcJKUO5H7yljNTix4OVRvc3Y5BoM+cWG
 iW4cCX+KRDyWTqvywPvJgbiOqRDo=
X-Google-Smtp-Source: AGHT+IFeGEdh9LbrurFO2Kzyp2dvZeBg4HH/Rh9ZGKtiGRBiLSn+BMfmlxhfuLG02nluETyotTf5KkSuB7GFkkR0OIU=
X-Received: by 2002:a17:90a:c392:b0:2a2:5a91:1d2f with SMTP id
 h18-20020a17090ac39200b002a25a911d2fmr1836720pjt.4.1712335670207; Fri, 05 Apr
 2024 09:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240404025920.4466-1-aford173@gmail.com>
In-Reply-To: <20240404025920.4466-1-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Apr 2024 13:47:38 -0300
Message-ID: <CAOMZO5Bw-qrwZ72=YNpPFYmovhsubeywEc=sivWF5u31S4vJ1A@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: imx: imx8mp-beacon: Migrate to OF_UPSTREAM
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marex@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Hai Pham <hai.pham.ud@renesas.com>, 
 Peng Fan <peng.fan@nxp.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Patrick Wildt <patrick@blueri.se>, Gilles Talis <gilles.talis@gmail.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon Glass <sjg@chromium.org>, 
 Martyn Welch <martyn.welch@collabora.com>
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

On Wed, Apr 3, 2024 at 11:59=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> The imx8mp-beacon boards can migrate to OF_UPSTREAM which also
> allows for the removal the device tree files.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.
