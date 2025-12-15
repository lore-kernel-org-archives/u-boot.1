Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76754D5B87A
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 23:26:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A41CA800D0;
	Tue, 16 Dec 2025 00:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gvUV7ste";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A62B8036B; Tue, 16 Dec 2025 00:26:39 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3914A80077
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 00:26:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-3e89d226c3aso2733641fac.2
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 15:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765841196; x=1766445996; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3f3eZsXTnF8mAis4EZsTp3QIEJ/32I3uL5rcarFw44E=;
 b=gvUV7steUkNIfcGa0FbA0L5kcgPOe0bpWi3/IgxV5fBw3oEPvu2VOsGvu/XyOjfnsa
 6qOrR+VGY4eczqeW0UwNgJda9DUroMWS/cDViL708T681k6zuTN9bYFrncmWlvmGygar
 oN76/jYwJm4iI0mdc+FSGgwH/zksaWXm8vlCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765841196; x=1766445996;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3f3eZsXTnF8mAis4EZsTp3QIEJ/32I3uL5rcarFw44E=;
 b=RAHGuUObcyoksFXCW413LA5yjSEm2CXyqjuoX+i5Z0wRiUQBKnfgmAbSc9N3DcZs51
 rJ82rv6tJrs2tDY9LMdb2c1ZcJ1TlgAybC3lEjKBaU4Toya8McN3cgzBfizBtNDypwQ5
 NvHbwMJo1Vr8hUI0n3dCsUAOTgxCEPweCdBaWwOX6yk7hiuWgFKTB6Dz1fdDRm8BYCS+
 1UmSsU2B8USkA8rx9+DrLq+SYrIOxA8X1DWwpwSg/RK5yKYJfv+uTPqvBxuUaEQlPNZF
 4xC+qOmg+aCkckKcCp1mG0lzx7Nksuk6iyZBeADFj8+zncfjBcUdu7+c2IBCg8x24ZdT
 Ao1Q==
X-Gm-Message-State: AOJu0Yz5L8vb+yB9yGan6jI7bpxa4KwVOo1MDkui+QyPAfWlLF3p8aTd
 KtsqXfTbUv/QzrzXnMQHVSn0BcCrewFJfW1gJ6kMkVj5MGGYdFwTF5NBe+2cSruoGexHwa6Vz0N
 1I2EGuzs=
X-Gm-Gg: AY/fxX4H2R2Wi3b/uZ47bBk9GaGJDPZygjAWbAZ1LHaaB2vUlnhaKPEi2zn0OGmYH07
 g+Qp6rJkYV+1XwdJNxrf46hnhvEYlnbsQZpcYoCd+iuh1bk70WH/phiUWwLZlZCPrMoMckub0l1
 uOJaWdubqjW2Lrp9QqnA9ekBmH8DLNgwRmfvcZqrs24z/rayhu4zXRjh4xJuemlzYWFXLAqpSbY
 6sXsSr/heecrNjq39R61yYCkBFWWEQG21x/FAH0ZDHprQ6xrx5GfzflWYg8Ben/H5CWRL3yzNGe
 FhkfBiYzJjBupCZ9gCeOdTP6Bx5CLe5Ia3OPTiZf+Quz0YBOgnVjjOgfNyZznfnZMXAJeVT4dnt
 VNgkRZ/7xfftIEf8PJUPQiPQH3wIuWiM3jPP9fAKZHGy1+r8Lw4n4xawa4VEbXL8StgAY5PRmn2
 MSgUMRKn8g5S2qD4u0n2mBGDXOdwrZWURUBN4X9ofj+pkA1i5u
X-Google-Smtp-Source: AGHT+IFMJoaaFP+8xQY3WpIaJ0R/eGfVqN/lIGqOuiXeVPTGEEy/MYQ+M7jLRKec8ZOaGN+JVNJRqg==
X-Received: by 2002:a05:6870:85ce:b0:3f5:4172:17 with SMTP id
 586e51a60fabf-3f5f8d1a7b6mr5909862fac.56.1765841195861; 
 Mon, 15 Dec 2025 15:26:35 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f614b7efd3sm5284880fac.2.2025.12.15.15.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 15:26:35 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20251214151030.1461567-1-kever.yang@rock-chips.com>
References: <20251214151030.1461567-1-kever.yang@rock-chips.com>
Subject: Re: Pull request: u-boot-rockchip-20251214
Message-Id: <176584119496.1912790.3995873637248103534.b4-ty@konsulko.com>
Date: Mon, 15 Dec 2025 17:26:34 -0600
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

On Sun, 14 Dec 2025 23:10:30 +0800, Kever Yang wrote:

> Please pull the updates for rockchip platform:
> - New Board support: rk3588 Radxa ROCK 5T, ROCK 5B+;
> - I2C Fixes;
> - RAM boot from maskrom;
> 
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/28748
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


