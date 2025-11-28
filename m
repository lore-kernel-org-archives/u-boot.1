Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5CCD116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 17:41:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2FB983BBE;
	Fri, 28 Nov 2025 18:41:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GRijdMju";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61F8483BEF; Fri, 28 Nov 2025 18:41:28 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2642683BBE
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 18:41:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c77fc7c11bso1565554a34.1
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 09:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764351685; x=1764956485; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XylOzTV/4TXNvPe2EvlBv86Ur9D0UTVlvD2IMJnNG+o=;
 b=GRijdMjuk/9yTVnDqp7yuWCTReGit7JwIJgxI+wSocwjYe6wdtpHXjSSaDUvWDOIcu
 85AfCQR/FyGfiTJUAFTHOTyVoTsZeg+brQYYmk2bWmJficWzkuWbIklIRFtOl3IQ/Wbm
 dua8mGG2/hISq4pqKQ1w3D+S06sK8Ps6hs2pI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764351685; x=1764956485;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XylOzTV/4TXNvPe2EvlBv86Ur9D0UTVlvD2IMJnNG+o=;
 b=Q7Hrw0IZAbJFZoxU3eFekNU6IA6MfwsePAjEEa4UTxi2hkyro13gEuVWW/HRLxo1Yy
 FE5EjQrgDbc2qPAFW5PnGmNyX34xqyTPFudMOOAsJV6FZiiQJQG7zuIHAjp4aR87RAp3
 hv+YIn30LAxht06t/pKJdFIcriog9Vn20IoBHS0zMbIBM24ykDf8TSzBYqCEg04ChiHt
 xs4LMPRduHowNtL8zkFUOsxvB9TcOw2yzPDlavIQi+wvTl/F5DyM0j6Jw9FQBQagY6lD
 +MoOgI53a1wsqMcaE6Q8Vvw5Prpb6Myt8FU/RQrnYrVjzDD+xpXKOS0OsK/PAgj2xq/8
 Qq9g==
X-Gm-Message-State: AOJu0YyusmNsn0CW93N5dcucsi4H+0AWBRPyes4WQNY+bmQmDuhDMnp3
 gfJ2qJLydhcFFaQlayH7DrqHYdlTCCZoj46IjFccb65CGcvBC4yX6tck2Jm/1NDcWnM=
X-Gm-Gg: ASbGncv3jY/2sS0odQNQ/9ar2aWmTp+9ZIp+vuIt3Y9mm6EB/wY8v1NMe7suKF+EeQE
 Q/Bj6/C1pN6EmITv7TNc20FPeiqMZgkoSaVIPdGUTnoaTFFzGhbNRVw8As0mrpOxBPYZ4Z59lX+
 mjyHMgSBe4V5Ifz5lQBVsbOdYybvXZKmu9SZiF7XR8bE7qBq3dH6Jmn6+orOH/mGe0XKcM2uI0F
 DbuDhYc6meDIxqUMpTKOBme/IQU4DYQMMfo9hJrR1LpsDLV9ov72DzRHJQRvXGHYBvdCR/Dn/sS
 dUrnU9yJlyFOLzhHQGmSAPWKhyehEzS6NxJs/VzQmnQclL4A57geNzFUOsY+pnx8s+8JSvW22so
 89aqHIZTqTOO1m9tx1J5Ta2fu0uzAInk2kICRR1aEOvxKjPToLUc8Xa55T28fR3XYTx5c3bkvFN
 +dMd9uzSIy8HZZVDgkC67fe79y8cTm2lXsbTCvi/sFyjGlsjha
X-Google-Smtp-Source: AGHT+IGpyKiT2QidWvdgYjaklYXsVSK2LjHVzFq4Aa6V6UM8mHlU+cg5a7Ai60vDNgpwAmb0NybyKw==
X-Received: by 2002:a05:6830:3365:b0:7c5:38d2:fe1e with SMTP id
 46e09a7af769-7c78eafeffbmr11802734a34.11.1764351684944; 
 Fri, 28 Nov 2025 09:41:24 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90fe0f650sm1771543a34.23.2025.11.28.09.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 09:41:24 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
In-Reply-To: <20251113115658.947953-1-marek.vasut+renesas@mailbox.org>
References: <20251113115658.947953-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/2] sandbox: Fix DT compiler address warnings in
 sandbox DTs
Message-Id: <176435168382.233357.1086758424564850596.b4-ty@konsulko.com>
Date: Fri, 28 Nov 2025 11:41:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 13 Nov 2025 12:56:29 +0100, Marek Vasut wrote:

> Trivially fix the following warnings in sandbox DTs, which show up with
> DTC 1.7.2. Fill in the missing address and adjust emulated I2C address
> to fit the 7bit address limit:
> 
> "
> arch/sandbox/dts/sandbox.dtsi:138.30-140.5: Warning (i2c_bus_reg): /i2c@0/sandbox_pmic: I2C bus unit address format error, expected "40"
> arch/sandbox/dts/sandbox.dtsi:146.18-161.5: Warning (i2c_bus_reg): /i2c@0/emul: I2C bus unit address format error, expected "ff"
> arch/sandbox/dts/sandbox.dtsi:148.4-17: Warning (i2c_bus_reg): /i2c@0/emul:reg: I2C address must be less than 7-bits, got "0xff". Set I2C_TEN_BIT_ADDRESS for 10 bit addresses or fix the property
> "
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] sandbox: Fix DT compiler address warnings in sandbox DTs
      commit: 9bde0c1da52e9421c84fa622849d85dbb77603e6
[2/2] sandbox: Fix DT compiler pin warnings in sandbox DTs
      commit: 416ceee82f7abe4065446a0b97252c8c1573438c
-- 
Tom


