Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C67C30653
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 12:29:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EBCA884BE;
	Wed, 26 Jun 2024 14:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AQBRZqpn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB7CE87F8B; Wed, 26 Jun 2024 11:43:53 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC70188452
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 11:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2eaafda3b5cso67158491fa.3
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 02:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719395030; x=1719999830; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f9yXouYFFVoeh+wzgUNghZOG6eQE4xLISuuG/NrBTh4=;
 b=AQBRZqpnHPbXfRcoklb1hO/tqG4GfJF1b8XFUm6VFgIdq+KSSwTi90JBCvwYsCB/gE
 H7nBHNJIWDrNIVLzDX/lSy2bFEwv5uYZ/3sHDCqzyV62MvLvpOeEZgMSHUHbwPFUn3/P
 tA/m32lt9m5l6HDUfihCuYOsBCLgteAswxSOhoHR3t6DBXLKrwOhDtATP2iIGrQpB4Zx
 887uV02PnmN4twuensOo/PNt6JbU+gDkrdUOfGfb4owJHDKYAuAZmRxA/sS6Sr8RfHzg
 c87p48fIRO3fTKeQTubQ8c6IPQXjmgpEKCHqp1qGEJTVqgKVYrRyk9uC//3+Z5Snt5Ih
 vp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719395030; x=1719999830;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f9yXouYFFVoeh+wzgUNghZOG6eQE4xLISuuG/NrBTh4=;
 b=V329NRoXXjzM79hPDuSv+YLxGm3JfSsVHqYez4GPEoR4Eq88c6ZmjLT/Cspmu9vXtG
 hwXggIOkv+M3eEGf8k1k2Y+9dIZPZgpOH0jFUwDzoJ0Eh7Fa4RVzsyEuiFcuOweQEKHy
 K3mQsiZEcm4SKx8f4of16pp24qaPHaf2dDM4IfiS3YzxIYf57afZfKc6E36nCOmZqN0X
 WJTM3uqFZ9wQvp5KITKhySxlENh7yeq83bdtImOtP1krq2cXduiqXAejBf8j2oLRRcSs
 iT3O48yV4ABSxAxqor8FW5Y4F6JJyUHk9ZHT9RfHRPm4GuDcAxZozhBkXGugqDH2Nid4
 /dMw==
X-Gm-Message-State: AOJu0YxuRbIKmgQ8stvf+fx5R+5iZlfzHyR6qjrQ9kHEbFUb6GsQsE1S
 ZvpXK5Hki9GtWS21Xe0e9NKuKg1mX6OZ1Bpo/1hoMDz1dWC4bjZQ6dPZnOFgq5A=
X-Google-Smtp-Source: AGHT+IHysr8Tgc5ey5jrgRUt5Qg2zyfxJ/YAUp2E2EN6PHVL/ZhhgxHZGrHQoak+XPgNwj8vKXUiGg==
X-Received: by 2002:a05:651c:1a1e:b0:2ec:59b6:ad71 with SMTP id
 38308e7fff4ca-2ec59b6ae47mr75393621fa.40.1719395029661; 
 Wed, 26 Jun 2024 02:43:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c84692c0sm18857175e9.43.2024.06.26.02.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 02:43:49 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, 
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>, 
 Allen Martin <amartin@nvidia.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Andrew Davis <afd@ti.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christian Taedcke <christian.taedcke@weidmueller.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
 Neha Malcom Francis <n-francis@ti.com>, Nishanth Menon <nm@ti.com>, 
 Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Trevor Woerner <twoerner@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, u-boot-amlogic@groups.io
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
Subject: Re: (subset) [PATCH 00/42] labgrid: Provide an integration with
 Labgrid
Message-Id: <171939502804.2754394.6148007977344212026.b4-ty@linaro.org>
Date: Wed, 26 Jun 2024 11:43:48 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Mailman-Approved-At: Wed, 26 Jun 2024 14:29:28 +0200
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

Hi,

On Tue, 11 Jun 2024 14:01:14 -0600, Simon Glass wrote:
> Labgrid provides access to a hardware lab in an automated way. It is
> possible to boot U-Boot on boards in the lab without physically touching
> them. It relies on relays, USB UARTs and SD muxes, among other things.
> 
> By way of background, about 4 years ago I wrong a thing called Labman[1]
> which allowed my lab of about 30 devices to be operated remotely, using
> tbot for the console and build integration. While it worked OK and I
> used it for many bisects, I didn't take it any further.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[18/42] meson: Correct driver declaration for meson_axg_gpio
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/96e1a156e90a0674b21c56e7121b17a9211176ec

-- 
Neil

