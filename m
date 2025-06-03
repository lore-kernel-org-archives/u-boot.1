Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9520C5B555
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 23:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF5E981FEE;
	Wed,  4 Jun 2025 01:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P4Kp8DAU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5746681FEE; Wed,  4 Jun 2025 01:19:22 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E90782103
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 01:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-735a6c02a96so215697a34.0
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 16:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748992758; x=1749597558; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ehfTv7aVI1QyA9WxiCwasgGoDgbbTPqvP9Z2V6pr17A=;
 b=P4Kp8DAU3LeBWnZUZsB34n4NUuJEIp0Qg4x3wlc9grTeDzeblnJUkyxEBG1eFpTWni
 zIL6ZsBMVsnW72S+dVbLhWADJf0ltv5HKoI31EVA4XAo93T8ZpxSqLRFlaD2t+AbH9Vb
 moXILTlsSA+vydUsna4FsVvNmhASUma85suh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748992758; x=1749597558;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ehfTv7aVI1QyA9WxiCwasgGoDgbbTPqvP9Z2V6pr17A=;
 b=PDLtNF9m5LGrFX3Wdh++SD+df3fOdkhzHMkPd/m5In69UhAgog8x7phw8FUD/x/bSb
 5HF/3/Z2UDlcGAyUzev37MaFWN7oPT2J+tiWpPsPVo+bMAJdzXpwFD4jNViQdfZWqGk8
 VtXHgjlWKoL0m2gTxjbkhE7tWwdWOhgoewFFH2BrRRANFaq1dNVlhTndXCZCLutayKM2
 mje/UBRorJ9EyKvm73Y2U4mT4YRk86WJq/7kDNe1x8nY6vMCsbYDN7WctVMXmqmhRJLw
 UMre1tTWVvBLvhNtsFFJVYGtGd94CVyHG34XMRm6nuuEL/QrWkSVKGWT5vKhruRqBNgy
 vCCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP2Dab+pXIwlvpv7zqcPcv7ubc2+Dj+I+NhCt9+q33dRtAuhfaU47crejOWfvBz61sucKg5GY=@lists.denx.de
X-Gm-Message-State: AOJu0Ywf6YAXnqRY73wcNpERwX3YU0um7kMIU+6Q3YGjT6zriqhHmWGb
 LVl53gXD5jeeKbDxPcmuZTz1tbCqjJZQBtq6SHSrN3/J3RizXaFvS1H56cWWVBt31HRvXPCoNsO
 dkL+kJfA=
X-Gm-Gg: ASbGncs+MN6GlRPRAQ0y7Ur+TcwGu3pyGdEXL5iux+crvTvgKPoDCmC0T6bI19ozGfP
 MfvYiS89b8KieC8HI6saKwQDFeIHmPS7usQCRy/M+kc0PjyIWef+8AdnPiEsk5m1yqyQjEnUcI5
 GQ5+bDLI3E5aV8PWr1mb5Vh4RCw3+stnuyc6YMLEAWKq4coMXM3n1u0JmdB9V4JGh0ZwsN7UuzC
 s3ie84KtVj9BCnyOlEys1KRB4JMoP62vOZnDS6WNvPryq5Ul4ID2oAp7xJ6eXTvEhWTy229Wg8R
 /+Vfo+lgNsE1Sr0LfV3Idywujt3vxPyEF5mjHEE0n+SOINUIiWn8lyiWNpT95v3snSzymaryt+k
 84NOaaXJYfFU=
X-Google-Smtp-Source: AGHT+IEbB2oRANuu/S/PMbgqIdPyjUKX1+qyx4tfCtCsMKZbg/uFNahAARvXwo1txacRCGe+657yng==
X-Received: by 2002:a05:6808:4486:b0:407:39f1:ac80 with SMTP id
 5614622812f47-408e352914amr3506573b6e.5.1748992758243; 
 Tue, 03 Jun 2025 16:19:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678c1db4asm1990941b6e.12.2025.06.03.16.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 16:19:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Vitor Soares <ivitro@gmail.com>
Cc: Parth Pancholi <parth.pancholi@toradex.com>, u-boot@lists.denx.de, 
 Vitor Soares <vitor.soares@toradex.com>
In-Reply-To: <20250519154745.429751-1-ivitro@gmail.com>
References: <20250519154745.429751-1-ivitro@gmail.com>
Subject: Re: [PATCH v1] board: toradex: add verdin am62p support
Message-Id: <174899275664.1527530.17358325352075388123.b4-ty@konsulko.com>
Date: Tue, 03 Jun 2025 17:19:16 -0600
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

On Mon, 19 May 2025 16:47:45 +0100, Vitor Soares wrote:

> This adds initial support for the Toradex Verdin AM62P module.
> 
> The module consists of an TI AM62P family SoC, a TPS65219 PMIC, a
> Gigabit Ethernet PHY, up to 8GB of LPDDR4 RAM, an eMMC, a TLA2024 ADC,
> an I2C EEPROM, an RX8130 RTC, plus an optional Bluetooth/Wi-Fi module.
> 
> These specific changes adds support for Toradex Verdin AM62P Quad 2GB WB
> IT module.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] board: toradex: add verdin am62p support
      commit: b8c43968b801c568b66b1d2985e8542275d9d49a
-- 
Tom


