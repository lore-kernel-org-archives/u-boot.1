Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358ACC001E0
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 18:50:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6BF081F54;
	Sat, 21 Oct 2023 20:50:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xo7IRVUl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B806386823; Sat, 21 Oct 2023 20:50:24 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CF8B8071F
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 20:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a7b91faf40so19831567b3.1
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 11:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697914219; x=1698519019; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ODA7aittb2UC8fm22duq6ma0ZuVUFQ3b9J6DGrz7iS4=;
 b=Xo7IRVUlsX35TYbOe+AsXdweJOgvWrrEr/VzU8yQwoZJA4cbUHz2R+hloIa5Ilh3zq
 B2tV2Hb8+m1z7kNpafDJRlDfMTw8k+c+qaL6gOeg8gQef4b6f6Yv/DKRrEL5QEKY6xfN
 jJ4Y7KmxNeT1GOzsQH8TyhpKUAHXOzmuiZwlsxcc/OD4p3YOHZMYZK7zmF9GyjFhm7lw
 DtJflVfhh0g7CD0LQrfOQFZ07LiogsaMxvicZWek0KlS0SRFxXHuC7TBwuNrh+WRqT4f
 iBBVFqyZ2oEuv/m7PMhA2LCRwWDCqQNdx5/n91JGA4Lv7dKWc2avPIsIWtaB2fz5ItAk
 sDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697914219; x=1698519019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ODA7aittb2UC8fm22duq6ma0ZuVUFQ3b9J6DGrz7iS4=;
 b=O+QAoohlv0ERIAB4jlJ5zyYjCJmQxgOj82KaBGdt6uqI2kx2CrZPkEqDCQG1xejc5X
 8kX0nB/L6rlva/c2A1vHBoiR7RL9Hathpxy5jPka/XuuI7ZZcNB8a77/AUNvEB9M8URI
 4mo0o9fQx7fbkXp7N7vyhoSqqG36dXv78G7brqDGIFRyIAcvRxywH+fr+mAptbhDCBEM
 PpizcLbwr5nUfTve6Kbayz8Kkj0gid4BtEv2mwbxrqWK7ph+uXE1+4L75yGd2y/TzAGJ
 EDynhi9nQuz23A/P0qQLoD1ms7bg2Pi2H3XKWno1C0ou3/A+aZZy7n7p5ENpRhrtwpPO
 ckyQ==
X-Gm-Message-State: AOJu0Yyev2lXb/x5+WdhnPYn8d2jl+33FRdubPHoZ3YV+iSHBdHuGOKn
 IkER5a4rIUOekBxArZfGYHzn4djBPUm1XNeXCkmptQ==
X-Google-Smtp-Source: AGHT+IFZEy+nKg/NkAdDV+MZoYjN/KH1vHHFBjVdgnt3Au5deVlJedBjXPahOO2HpHQBtZxOGN8VKWgUJ0/BIcbJY+E=
X-Received: by 2002:a81:84d1:0:b0:5a8:204c:5c9b with SMTP id
 u200-20020a8184d1000000b005a8204c5c9bmr5231262ywf.18.1697914219048; Sat, 21
 Oct 2023 11:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231018062745.3153436-1-qi.feng@arm.com>
 <20231018062745.3153436-3-qi.feng@arm.com>
In-Reply-To: <20231018062745.3153436-3-qi.feng@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 21 Oct 2023 20:50:07 +0200
Message-ID: <CACRpkdYb0_cyLmXyZDKMr9pbyq7sWUyvZqgY8jhr3QcUv0bGFg@mail.gmail.com>
Subject: Re: [PATCH 2/2] vexpress64: Add MMC card to the BOOT_TARGET_DEVICES
 of FVP
To: Qi Feng <qi.feng@arm.com>
Cc: u-boot@lists.denx.de, liviu.dudau@foss.arm.com, fenghua@phytium.com.cn, 
 Peter.Hoyes@arm.com, wei.chen@arm.com, Robbie.Cao@arm.com
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

On Wed, Oct 18, 2023 at 8:28=E2=80=AFAM Qi Feng <qi.feng@arm.com> wrote:

> From: Wei Chen <wei.chen@arm.com>>
> Add MMC disk to FVP's BOOT_TARGET_DEVICES. This allows the user to boot
> from MMC devices.
>
> Signed-off-by: Wei Chen <wei.chen@arm.com>
> Signed-off-by: Qi Feng <qi.feng@arm.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
