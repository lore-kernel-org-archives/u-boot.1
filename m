Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3453DD2502E
	for <u-boot@archiver.kernel.org>; Sun, 11 Jan 2026 16:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E7CB83B85;
	Sun, 11 Jan 2026 17:30:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AXdjRqtY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3B8783C51; Sun, 11 Jan 2026 17:30:26 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD76483A79
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 17:30:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b8718e54398so5532366b.0
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 08:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768149024; x=1768753824; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Rd7WqqwGr073ZiDHVFHQd9ohL85TA5lkN+fhprlXnNc=;
 b=AXdjRqtYPJmkRWlpi8Un4tbKwmw9fybBgaGR2sm/elQDBhuR7q9D4vmwIEIYXg0vRu
 pSIOUEiSrQBFY5KLFAGAye7fxTfH4xQ2dH6mtO5pdq8e82gGEux0GbhC4X9ZizGHW8OA
 7SyZKUsiA0woWw/mayLnPzkxjIh+xjoxayZQYXy9rDh1VAuT0QVspvydiULMpoxggSBs
 fT47NksHZpPrSa8n8zcPp+ppuB23/Eu7ch0V8Ql5JX9iEaTZzDTnRUj8pDbLgnMoNKLY
 0bQX1mLdu+9gfzirNr7iZSTj4P6gDftG5Qg/Rmb4th20PBx1HB1/JfXvHHLkMqHWGbSh
 k8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768149024; x=1768753824;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rd7WqqwGr073ZiDHVFHQd9ohL85TA5lkN+fhprlXnNc=;
 b=k9C4LvZmO+PgHwuV1Q4imkw2VDU3ZYAG15JMPT41UskgKrgjwSeBD2lwKvRAcdP1gC
 1Nto/+4t/r5/l8Tx+GO+BaIMMH+eKZJOWOjIYO+4fh+e4UdkZgGyqyuSKQpnPJfsGX+E
 gJazHXSCYOcREVVEccQRNmkSNUCJm1zAMvjP3/OPHY4/U4j9fTi6uwk4xxlKjJoBQe5h
 EIApmssWEvaVVb3i4ADwXWps3cxvNxAMxo/HlqLEhOHbS6kUJ7X5FbhY8m1rQfEPsHfF
 RYx9fHSURSMoTdZqpCpcmufiqjYQacD+95BamfaZ9gFMRO1558jAiyz9zWsscJTyNfMI
 nRfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVasURuSeseaxQXP8g1mTBv+Z2c05X/XVzxoB25VokrsNTeKJHiAg9pAw8lu4RpkS2jetl1nqM=@lists.denx.de
X-Gm-Message-State: AOJu0YwHLtYcjcZn+nZo02NkL4vkZpzu4+5+UgoZ2qUWSxhVspNRYw15
 wqoIThfQM4CgNT1R/czP7yOLrBEGAsEUxOYMu8AgGPdqzVSCGYhGWUZa
X-Gm-Gg: AY/fxX5wVTuFvimqClfyBR2l/VtOy2QCybiLLHpZuF7uTCTRneTEhtQThnJF0+zhz4f
 ikJyN9YG5P4/Ye5WQjuRj2z6q4h8V70YhoGzfXS0kuDbnDiDoHQmJoVitRATsJdGa7r8eRuwige
 Ab0WBCIOFeAcCCxZ8cqFYnncNx3hu9hkAx792UHpe/LEpstzNUKa945lZWna0UWVkTS5fmqm71G
 ifw32V6CsUjhwLBCYUyDImfq2udmN5+tOOBF0SBLY279tldaaqrj4wYDMYNoxrDGm3WCALzXU0l
 60cT3YRLd5Q2Lu0SZdDIamspdDNhhr9nsTf4zE8fsZxcCdNNv+QIEumSAnvgmd6XDMk/R7wpqtT
 1HISa/hsjWxwtGEvKR8Q27hh6pLK4UiZtJafexZB0oYFZE1L8sJWDCyQSSAS50pGB7ksyHKayCS
 m15cDuco0FMOEGMmd6x7x/Xj3kdDE8GY8UF7rIQ6mYErXaiBXFKw==
X-Google-Smtp-Source: AGHT+IF8D94SW7uc1ZjUgMlYicXyZ4vZ5NlbNQegrgNdqXk4MnJ8hMJaZSK33Fl9HcLvcPMiV7hJag==
X-Received: by 2002:a17:907:96a1:b0:b80:50b:6c77 with SMTP id
 a640c23a62f3a-b8445330d57mr755239666b.5.1768149023794; 
 Sun, 11 Jan 2026 08:30:23 -0800 (PST)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8717a10ae1sm109138766b.32.2026.01.11.08.30.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Jan 2026 08:30:23 -0800 (PST)
Message-ID: <8fee4d0e-aa11-4edc-93ad-8d24148f73c9@gmail.com>
Date: Sun, 11 Jan 2026 17:30:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 2/6] ARM: dts: rockchip: Add spi_flash label to
 rk3288-veyron
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, sumit.garg@kernel.org,
 trini@konsulko.com, u-boot@lists.denx.de, hl@rock-chips.com,
 jagan@amarulasolutions.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jonas@kwiboo.se, michael@amarulasolutions.com
References: <deeedc19-e992-44d4-ad77-2b9b2d891675@gmail.com>
Content-Language: en-US
In-Reply-To: <deeedc19-e992-44d4-ad77-2b9b2d891675@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

The u-boot,spl-boot-order property requires a label at a boot
device node. In order to migrate to OF_UPSTREAM more easier
add a spi_flash label to the rk3288-veyron.dtsi file.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Link: https://patch.msgid.link/8a423a6f-bfdc-4947-aef9-35ee7c4f6ca2@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: ac7116a626e00d3024adedb43b74bdf2ce45efc2 ]

(cherry picked from commit 38e6f7cd300f66cc9f657cd0e8881a01acc664d0)
---
 dts/upstream/src/arm/rockchip/rk3288-veyron.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/upstream/src/arm/rockchip/rk3288-veyron.dtsi b/dts/upstream/src/arm/rockchip/rk3288-veyron.dtsi
index 260d6c92cfd1..2d6cf08d00f9 100644
--- a/dts/upstream/src/arm/rockchip/rk3288-veyron.dtsi
+++ b/dts/upstream/src/arm/rockchip/rk3288-veyron.dtsi
@@ -388,7 +388,7 @@

 	rx-sample-delay-ns = <12>;

-	flash@0 {
+	spi_flash: flash@0 {
 		compatible = "jedec,spi-nor";
 		spi-max-frequency = <50000000>;
 		reg = <0>;
--
2.39.5

