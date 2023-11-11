Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79449C4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 00:14:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEC6C871E6;
	Sat, 11 Nov 2023 01:14:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="Xn4ujhhX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE14E87243; Sat, 11 Nov 2023 01:14:39 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9EF58709A
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 01:14:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32d9d8284abso1556464f8f.3
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 16:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1699661677; x=1700266477;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SA0e3XOhvnNxwXhxtp3ElaKNudAbMXQpJ8bKHTBiFWM=;
 b=Xn4ujhhXjKWfNL3qCI/yoD8yH7fzVLL3g6n0mr9TylZNeECDextEopEMhWcT6KnXJp
 VQzzxOUhEhHF9xRFhp+Sg/CMhnCR9biheRKdH7J1CLiUlk8tsnTQlBTzHUp1BGJKQy6G
 DeKEwJ3LRlZkfgRK38g3bEHUpHlzXGkrvnfswJ4MopuQ5VZ24VHXTMzQtzLKtGc1U7FL
 twoYRK5d6pK1UXV9q6PvMr96mlMq0RiAbaErz8TIl0kJbQXrby7w6Oe2wYpD/GV8cx3e
 1+YUclRwoq7XrR0vhr95KV7HOA7PIRLTUrP16IziSwU9gt7wqlFopf4Gj/96W4/0mx0Q
 duqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699661677; x=1700266477;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SA0e3XOhvnNxwXhxtp3ElaKNudAbMXQpJ8bKHTBiFWM=;
 b=ZJYAPUUprwjlQ9TW7j4wpoUNB42nkeuILwEOIpn5z4DpihVcZE7VZhCVGq7D+fd830
 g3HIahuUtEobdzg1/wGpYkNMJJSvYvcuErsE5Y8T5GniM3PrtIFhEzcAl1+wZq+GbmiZ
 0kBhe88Iyn8QMsmYku7/MgCNz7RDgTIOl4ChP+KM9rXQwvcAfuMbxUr6PAkdaOcYKkOp
 V+8Vg8WzyJQIL4mB5EUR897Yg2TUrHbNs0g50ICLt68NSkHTkpJBg87LpLgSVWZEAqML
 iSAuqJLSHXHhgRof1C79g1zugu1fsNihj58TYjQWpLkqx18ok6akNf7tbNI8S69hnHBz
 Pnlw==
X-Gm-Message-State: AOJu0Yw+a5mcKfKab2BA1XkptgTN54HEChOJCHIdleAsJ3HR2I4whaEK
 5jMscfsW6Rbpk4nXzOSRvhfJ81sr46hErHnK9PGIcyNa
X-Google-Smtp-Source: AGHT+IFa1eF3prpi6Eu6aXJdFlz5nnPvBnyk0rTlyofGKqNak7Maet1kErODi5T27qQ1HFdm5+ERcA==
X-Received: by 2002:adf:a4c7:0:b0:32f:ad68:7477 with SMTP id
 h7-20020adfa4c7000000b0032fad687477mr428974wrb.30.1699661676687; 
 Fri, 10 Nov 2023 16:14:36 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 l10-20020adfa38a000000b0032dbf26e7aesm376139wrb.65.2023.11.10.16.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 16:14:36 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 Shantur Rathore <i@shantur.com>
Subject: [PATCH] configs: rockpro64: Enable SPI command and full BOOTSTD
Date: Sat, 11 Nov 2023 00:13:29 +0000
Message-Id: <20231111001329.537704-1-i@shantur.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

RockPro64 has a 16MB onboard SPI chip and current u-boot takes
around 2MB, we can enable more features.
Updating config to enable SPI commands and full BootSTD support.
---
 configs/rockpro64-rk3399_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
index 4cd6b76665..cad0b8a5d7 100644
--- a/configs/rockpro64-rk3399_defconfig
+++ b/configs/rockpro64-rk3399_defconfig
@@ -46,10 +46,12 @@ CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_CMD_BOOTSTAGE=y
+CONFIG_BOOTSTD_FULL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-- 
2.40.1

