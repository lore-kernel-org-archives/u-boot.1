Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB4CC87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 17:19:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC19D8313B;
	Wed, 30 Jul 2025 19:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QIXwRUEL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16F9A82BA7; Wed, 30 Jul 2025 19:18:50 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB48783102
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 19:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2ffb85aed35so84585fac.0
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753895927; x=1754500727; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bIgPfkke9L+gt3Y+xzk7up30nLE9ee9GkO3g0N8HBW4=;
 b=QIXwRUELL3LcNae6mtDjBIysbStHa3Qe99YpA7/LewY9c+Tf6+zxquP9HpygfiMARk
 4jkeMDIFqkWa6XTIaFXSTBFgdx9Vnwcbgo0oGURKEspC9DmQVRUScwKJ2PQ1EywSicro
 WqG0MAxxdu3+IKRi32+wbF0TpqbMV+8ZzlHAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753895927; x=1754500727;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bIgPfkke9L+gt3Y+xzk7up30nLE9ee9GkO3g0N8HBW4=;
 b=igR0x1YGDNos+cAl8tt/tiE6i4+A9rKiWsssdvMM1uFkCAySlBRcSy+yPxDHAVSz7A
 4h2OhP+sNfEj0+gzpaXvXD6kNcuS/b6/JYdihAQQeAOZZokRsjDbAqbMqNiSufYH75AT
 haL+YCJrwVmzH7qG0rGlxJQZqjz7CxVN0uAj7E2of8h1d7xZhXn7n3sY9rSOa9+2dmeD
 3wOzl0+9MAChmweHdYBtA3eARaXRcTtbGRGPKDbvxtK0w/rN5LI7dIHoSXbAnIh6rKxV
 W6iMq+F5pchUkUrYRJ4vi93EyzG1RQqLFh/BVxAV5LhgNYTfHe7zZ8qsMXIrUHDVdFtn
 WoGQ==
X-Gm-Message-State: AOJu0YwXb9MVgAisp9ervs6OZWP3mWnYKb90O01kNNi5yqlg2XnBaReJ
 jJblc79geFpLt1alevZ5Z3MLPV9CR2uReBjtWp1ywIFAvKu+sKO6sEKuTZNSa58M62CffolYVy1
 jxLgmHww=
X-Gm-Gg: ASbGncv8BLbaa3XzjlcJvwoTB1u4g5o2WB42lNxXkL04JK+ZTWUdvyc74DauEWMeXv7
 wNEzTPXi8iEJKgoFkdwQvdV5bpqAY6ENrYyrD++b9n1aoE2gCPY2h8hOe/0gwUkYfIBDoqbylZD
 PojQzDJRz1SmKg8Nd+Ntwsg4FSZq4WbceWWJuGqmBwWiXOFb9xZyiyzobFzVrYhe0GL0KZdVoFr
 z5rO0i8fa7/Eq+v0P8YjuAk0PWpb6/aFSZmJC/+76qNFkelKzEV1LdK3RUYPgwlRgJjjwQWnTaZ
 8k4GXdcEATo1xS1Yp9djkdo5JrF5mAdyeZ85LWGKSwuosVQJjLtYCmha1IPEVRiQrwxObIspv3Z
 fTQ4+DAdSKY/jwK2c1pWbokhKHmr3+j1GhfN4kXm87RMigHRA5tHl07A=
X-Google-Smtp-Source: AGHT+IHuTmWxI4i8r7ZHOjUOwORgqYc37RB7JdviVo2iiGM1xg2pazuUrfsKeAcOpVwoAltr7qSk0A==
X-Received: by 2002:a05:6870:b417:b0:301:5fc8:d0b1 with SMTP id
 586e51a60fabf-307859d3a4emr2813245fac.6.1753895926645; 
 Wed, 30 Jul 2025 10:18:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3071323a99csm3016751fac.12.2025.07.30.10.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 10:18:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Klaus Goger <klaus.goger@cherry.de>, Sumit Garg <sumit.garg@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Benjamin Bara <benjamin.bara@skidata.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Rob Herring (Arm)" <robh@kernel.org>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, stable@vger.kernel.org, 
 Heiko Stuebner <heiko@sntech.de>
In-Reply-To: <20250730-puma-usb-cypress-v1-0-b1c203c733f9@cherry.de>
References: <20250730-puma-usb-cypress-v1-0-b1c203c733f9@cherry.de>
Subject: Re: [PATCH 0/6] rockchip: puma-rk3399: anticipate breakage with
 v6.16 DT
Message-Id: <175389592490.3621398.12846810223384732149.b4-ty@konsulko.com>
Date: Wed, 30 Jul 2025 11:18:44 -0600
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

On Wed, 30 Jul 2025 13:10:16 +0200, Quentin Schulz wrote:

> Due to updates to the Device Tree (migrating to onboard USB hub nodes
> instead of (badly) hacking things with a gpio regulator that doesn't
> actually work properly), we now need to enable the onboard USB hub
> driver in U-Boot.
> 
> This anticipates upcoming breakage when 6.16 DT will be merged into
> U-Boot's dts/upstream.
> 
> [...]

Applied to u-boot/master, thanks!

[1/6] configs: puma-rk3399: enable onboard USB hub support
      commit: 7810d079adfa7bc7b73085896d3a00d736b5cafb
[2/6] dt-bindings: usb: usb-device: relax compatible pattern to a contains
      commit: 7c0491ccc6a772a13b326b76a47cb6b3cc5e3f7f
[3/6] dt-bindings: usb: cypress,hx3: Add support for all variants
      commit: c419fd81349efaf4301c3b6e66ee12d500738105
[4/6] arm64: dts: rockchip: fix internal USB hub instability on RK3399 Puma
      commit: 6dd61725a2207c0ac3a01138ed34fd73af2e9dde
[5/6] arm64: dts: rockchip: disable unrouted USB controllers and PHY on RK3399 Puma
      commit: d0681cf0c8cde4dcf98d02912d5f0ef2ec786c9e
[6/6] arm64: dts: rockchip: disable unrouted USB controllers and PHY on RK3399 Puma with Haikou
      commit: e12e9320a39cd26368aecd8961ec11c7526ff1c3
-- 
Tom


