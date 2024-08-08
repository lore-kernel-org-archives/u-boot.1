Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CBFC3DA7F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 02:23:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B7888718;
	Thu,  8 Aug 2024 04:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B3ti5lWK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD32A88729; Thu,  8 Aug 2024 04:23:23 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94E95883D2
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 04:23:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-66a048806e6so4585467b3.3
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 19:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723083800; x=1723688600; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+LlzoqtkGPhk0t+A1cgZ1o+Lf8lNtxSbv7NpUcG+l6E=;
 b=B3ti5lWKPh1U4ZPLYuTRdwX0i9ZvOlbklAaMtUAI1X79BSHygomAJ2btbVwMmBqSLa
 kk5RmfjHorqAiV+LkUOr/KWlesV+drms688053/sNUjQvVPcvzzVqrDZJW6DlJdYRHi+
 cv4FhkrnbXr/ZDtXrYkONbOzGjefAjS8Jfxihdsxr+ONjWGfBWXyqyokJJ7UpkxXbH+1
 NPzfc0a9V5qGBlH4E+C600SO80CtCSk3s8AH4mTk322KeNpjFT1Ar+y8yCiAaMki5rmB
 tihXBF+PoUwM89nYiaoVF+teDL/fkA0gUZvu3+51YKyzhptT0f6YP/IZF6my/kwEkAu6
 TsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723083800; x=1723688600;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+LlzoqtkGPhk0t+A1cgZ1o+Lf8lNtxSbv7NpUcG+l6E=;
 b=mRc0GPOaX766eHa/0KGJA3iUEGVEYeuWwp46TlQlsPiciAJ8apF1/cj70+TkxcUi7Z
 YoOJV8pOPJdohczeMUQeP0cKOkCQOSuDDXR6MrnbVoPL3JDJyXXsHMs58p+hU+XJ0Oc0
 +aNkKZi8iQIrAveqkNAXXIz/nI1PA7nOOzwJxUnavfTr8fSYHPc1o/eNl1jMt3k5ROUj
 7PVkRCncpjQCUtrh+Wc6vJ9CJtjfKIU5TXl4IxAYyOzbwvF5QVmgsLM7HV3LDgFKBvWn
 o1GfeQ2lru5aF4cHJ5yK1zNISYpZ0ngbaVHjJw2CplE2iZxI9WgYKgqmoK0Ori+cvTkO
 xGLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDjd1FsNo1gytSzvY/3y6U+y+8oyQQJ/GiZFqcXfsvjTiqNkD9Sv7p97NTHYjXAVDjacKXrDFAbKKRfnJT+9zzZMlb4A==
X-Gm-Message-State: AOJu0Yzq02pk2EWxPk6TroZOtsFSgOe5SUqU20DrK5xIoUZMAuY5jNJs
 /ePQlbSIrHfiTAm0DUcEkvL2sLwRoSS47dzK4TotoGXsj54jEE39QJOqD/zwfSxLspHoEq3XiiS
 NhYKYfRVeQAo0F/Mf6v5SY1iulspxuLlTsnayjg==
X-Google-Smtp-Source: AGHT+IEsqUAQ9xGI8sqx6ulJJwy6cIFG3wPAF0Xj7aenGQEZbJCQ6sJZECrWe7QQZn1eNNsG4wR52/RawazEXCmmYFI=
X-Received: by 2002:a05:690c:448e:b0:65f:851d:8fb with SMTP id
 00721157ae682-69bf87ab991mr4193127b3.19.1723083800358; Wed, 07 Aug 2024
 19:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240725204520.18134-1-semen.protsenko@linaro.org>
 <20240725204520.18134-15-semen.protsenko@linaro.org>
 <20240803233350.GA194598@l14.localdomain>
In-Reply-To: <20240803233350.GA194598@l14.localdomain>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 7 Aug 2024 21:23:08 -0500
Message-ID: <CAPLW+4nLwNNOmd74Gg5fTcmXMVu8EMKznWeq5L+f4spdDfjuqA@mail.gmail.com>
Subject: Re: [PATCH v4 14/38] arm: dts: exynos: Add upstream DW MMC properties
 to all Exynos dts
To: Henrik Grimler <henrik@grimler.se>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Minkyu Kang <promsoft@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Yang Xiwen <forbidden405@outlook.com>, 
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, 
 uboot-snps-arc@synopsys.com
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

On Sat, Aug 3, 2024 at 6:33=E2=80=AFPM Henrik Grimler <henrik@grimler.se> w=
rote:
>
> Hi Sam,
>
> Thanks for working on this, makes switching to upstream dts'es easier
> :)
>
> I tested the series on exynos4412-odroid-u2 and exynos5422-odroid-xu4.
> One issue for exynos4412-odroid to resolve below, with that fixed
> booting from both eMMC and sdcard works on my devices.
>

Thanks for testing it, and good catch! I've checked all other
occurrences and this node (sdhci2 in exynos4412-odroid.dts) is the
only place where I forgot to add 'bus-width'. Will fix it in v5 and
send it out soon.

[snip]
