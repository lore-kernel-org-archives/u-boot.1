Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4C8C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 17:19:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 707F58313F;
	Wed, 30 Jul 2025 19:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Bh78G4XJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FDD78312E; Wed, 30 Jul 2025 19:18:48 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2471B82BA1
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 19:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3004ade907bso64019fac.0
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 10:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753895925; x=1754500725; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+6MoszXtTpio3uzE4P2yxp52ARXfDytGIKlMbDh61O4=;
 b=Bh78G4XJOD+dvTnfmHZzfqTHKaoZMYTP151YWs/HjqxRzPFnyfov5r4FjSLX2dWlEf
 W7iZn4PIWJ3M8ZJSVir8GGgDI8YIlpQGo4QSUgJpkwiY7HaF1uAteb9eUdUENO34vobx
 pimVL/zPG91lYHqz8jeE2KQxab1GL08eqMrXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753895925; x=1754500725;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+6MoszXtTpio3uzE4P2yxp52ARXfDytGIKlMbDh61O4=;
 b=bIAgtnwyVI+pN7Zj9gVkV8crMjkmGcwDA4hiS2MUI1l60ZTovZGUHO2h4qINhZieLG
 INTKg3Vqx5UdYGBj61e5Hho8KnOc3Td97THH5DupwZRQMpFpxaTxYnC5Yd/Egfkc7POf
 KRUHR4LWTS4tZ9cKLZADUI7t6oF40LGJVAS8CnGSV1MTspdNgHodM0NLA4hhDMtTXSRw
 9/XOiqiIeuLVVPzOedqGh8TUZeagaVe4UCB+NM6SNcLiO6AMk/mN7qxCOJ/otj0/4Yim
 yT0LC+uvxHqQjLdlOVUhoEc+16vZV0MVr+VoeJGhp66oiuU87elYEeffNfigeYuMuLxl
 GNbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVopNcfbuX9IbGQmnfXeaYg7D6swuaoldT8nr7MRI0vMhSqAV2BimS9OC0X9fesPePaTauklXU=@lists.denx.de
X-Gm-Message-State: AOJu0YycxjJASyPx0B3Lxzzc9l86X7/HiUqPLB2FV+DkpXxL820YUUGF
 uqvcx7dFUjIBwXjNZFjEyXpfoW+H8Gli1O/sv4qYzy1oGNzzg03yNg/pEKDuXPuzAx0Wa/GqQnc
 oPDI2IeI=
X-Gm-Gg: ASbGncsCG8bsgzgKhR18leAcH8LpVh2kWoK0knoY1/3NG7QBmYWN+3zz6qXo5fPLEdi
 0MFNzkYAT7yf5WS3GL2/i060Wj8jagXMYus+l631yIK6anCd2mtNy05Ff5TcjKbW7+LHfHtLBrW
 Za0wq8XaDvW/eFkEZmoy2xEBqJRlK+litRBd34zI1QpypsMgbjRmE/I+Ie9xegmkoVLs2TXH3uP
 xlmzTiwuVuIT6Vf5v37XW2y4Bmxma7ARyAmL5P97ejpzF1RCbdZubq9o7gufyncIw/RSL5LvnoC
 k4l7t6wEbltvwqgT6FDh4CyyLRPuGdZhyNRet8AYPntbw5vPczFB+HmYy6de6xg+rQ1hJgLmFBh
 UfkzsGxfU3aRuuCBtMiJamirgG9DV2qd3VXABW6gnTORpfEDjL0kSfHNa7p03xbnAMQ==
X-Google-Smtp-Source: AGHT+IGksdcGBmMxabC9GsEb3oeV16hYPJRfGs4hSh89pgIW+yCmBooP+Bl4cvTxSDH3gHpHgnf1PA==
X-Received: by 2002:a05:6870:8197:b0:2ef:98fc:6f59 with SMTP id
 586e51a60fabf-30785ccc738mr2780995fac.35.1753895924734; 
 Wed, 30 Jul 2025 10:18:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3071323a99csm3016751fac.12.2025.07.30.10.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 10:18:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Klaus Goger <klaus.goger@cherry.de>, 
 Quentin Schulz <foss+uboot@0leil.net>
Cc: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
In-Reply-To: <20250611-ringneck-mdio-v1-0-529a40a0f966@cherry.de>
References: <20250611-ringneck-mdio-v1-0-529a40a0f966@cherry.de>
Subject: Re: [PATCH 0/3] rockchip: ringneck-px30: anticipate breakage with
 v6.16-rc1 DT
Message-Id: <175389592341.3621398.8675602336509157588.b4-ty@konsulko.com>
Date: Wed, 30 Jul 2025 11:18:43 -0600
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

On Wed, 11 Jun 2025 10:59:30 +0200, Quentin Schulz wrote:

> v6.16-rc1 will bring an incompatible change to the Device Tree of PX30
> Ringneck which will break Ethernet support.
> 
> Unfortunately, the designware net driver's logic doesn't seem to allow
> having the old Device Tree (without MDIO bus and Ethernet PHY nodes)
> with DM_MDIO and DM_ETH_PHY enabled so there cannot be a smooth
> transition.
> 
> [...]

Applied to u-boot/master, thanks!

[1/3] arm64: dts: rockchip: add basic mdio node to px30
      commit: b279bd7282094e83fffa522081d1bb8e58b7794e
[2/3] arm64: dts: rockchip: move reset to dedicated eth-phy node on ringneck
      commit: 8279df493c7a4fa7c81c232cc6d9783f8bdec5b2
[3/3] configs: ringneck-px30: fix Ethernet
      commit: 21c3a37f074e195c849659b1bf3bef2a30381f26
-- 
Tom


