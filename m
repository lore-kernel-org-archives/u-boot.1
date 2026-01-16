Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D458C98302
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 22:12:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96D1F8394E;
	Fri, 16 Jan 2026 23:12:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dC7m/caI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDEA2838BB; Fri, 16 Jan 2026 23:12:13 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6498E8394E
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 23:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b8718e54398so41454266b.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 14:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768601530; x=1769206330; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Rd7WqqwGr073ZiDHVFHQd9ohL85TA5lkN+fhprlXnNc=;
 b=dC7m/caINQahXIrUjwQTct7mz+P663bbGNKpHPGxOhIkb/ljhPDkPbTcW+6LnYZBt+
 spvCu16QVN40pgGkrPd2I3t+8G8hAUM1d9rueI2oRMpea74H5YUBZOC3SY/gt85jFIFc
 nQSS4L0GBhs8IBHMKONAtyvQ6rNftXwg5BR2z22eJl88fyJUbBBEO6EYRvKlkNmyiqei
 +wWgPlZIEKbdhsAmjIM52NKyEPoPCrh/xroqKDLw/VTk5ZK3xFDlN/vDF5HjdCuuWUba
 aZNaWbuRc8PZJuSRx2/tG6bPVJ7rxqbaiGtcONKFi7tPjVVPQETBa8pbTrXWElFEvoS9
 qQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768601530; x=1769206330;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rd7WqqwGr073ZiDHVFHQd9ohL85TA5lkN+fhprlXnNc=;
 b=YDDpvRQfXpbJv1j819EkwqDhU7Z4XCaJ7j4HA3iNATsAh2xdfgMOiiYa8K29wHoZnT
 x74n1dBnudB2Okb3QzZqOZS0jR30Og4YDXp6K9c9r058zYxsf+J92ixLG+kf8mQKHn8b
 aIBElXuv1kig6rQx5MRbKHmpqo0FOG4lLbgYD+To0OWoWrn8TH6qvG960ZlYpR8scAjX
 4Xl/E2L4f4VCBD39AsAqDPu7K4yZCDxtwA3CwCmYrTDEjj189JW5mZxZU0vx8hDu/PsO
 dUaz+SHYigT/NB+IQIqxkhMWNucGb1f90CuL6sCGTv6DN7m+jhjNaH4knAjmw8XR5cuu
 TCkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLffmtr7DzUw7pjbo0fO4yJwTEv00pYOJ9dtgPBiU24ZUWZ21qeXwpa3FVrx3im+n8z2T6xpg=@lists.denx.de
X-Gm-Message-State: AOJu0YxUJcmWjo6/rV/8usRj7uTU2R0J15Z+T0+a7+Qu5fstppOygXFk
 srDks9oVubhxWabFE1QVto71SBeNw/bNIPe5kapqtTtxjsgKBNx7cRv4
X-Gm-Gg: AY/fxX7HcaZYPFx/H6q2NWMpBRg2o3W4QMccnpow0DZjk3ZHenSYRUoZVjHirjX/48C
 Wzn7w71V6iYCr0oV35DZEhFNqWfwqYaMIDp4k1QGyAIpyDUqo/ZuJcC92Jm2boTGRXCC8rYQMYX
 V2yyycHkk197zPROkvXffdecQsiocJ05uTaJeWfY95HjVgVHThFkFEe5B5u0WtNnxJBeeAUEsz8
 9TTOjfhzEYnRc9KZ2wyTF7H+/PYCHD/ozkmlqeCc2jyYjjFX/LAfkmVPgo2DCfYDkhoon/mpuPc
 unFjMO6vktvoqD7vNL/Q26xh9fNQRSoaWulQhvRP5PSNXOUgzTUYS2XJ0OTccmrSqzwiVNgSSQo
 ySoUk/iqq+Q4dkBAZo3dqgVNYkk/EStRV3qvbGl89ik87A2vzHC/Xa83gTZW4rG/PCDdXs0R9ol
 U3BhRYQerAANo7eEmnq/WcgLpurOjWaOb/hMJWvd5kJGTI0C/JLQ==
X-Received: by 2002:a17:907:970d:b0:b87:763b:3d9f with SMTP id
 a640c23a62f3a-b8792bed528mr198725666b.0.1768601529637; 
 Fri, 16 Jan 2026 14:12:09 -0800 (PST)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795a2f1a3sm351900066b.62.2026.01.16.14.12.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 14:12:09 -0800 (PST)
Message-ID: <12e44bc6-4e45-43e4-9c61-0816b90ce75f@gmail.com>
Date: Fri, 16 Jan 2026 23:12:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 2/6] ARM: dts: rockchip: Add spi_flash label to
 rk3288-veyron
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, sumit.garg@kernel.org,
 trini@konsulko.com, u-boot@lists.denx.de, hl@rock-chips.com,
 jagan@amarulasolutions.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jonas@kwiboo.se, michael@amarulasolutions.com
References: <a6eba53c-a2db-44fc-9785-d817dbb4ef11@gmail.com>
Content-Language: en-US
In-Reply-To: <a6eba53c-a2db-44fc-9785-d817dbb4ef11@gmail.com>
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

