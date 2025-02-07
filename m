Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A82C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 17:22:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5910B801BE;
	Fri,  7 Feb 2025 18:22:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="oNDnAf0V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEEA280207; Fri,  7 Feb 2025 18:22:04 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1341800B3
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 18:22:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1B4B53F866
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 17:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1738948921;
 bh=R8yCVWE+iE00xymiGhNWsupmu3mketxG2z5I2wSR4HQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=oNDnAf0VzZphXxJAvI9DCDHM2R+2RHtIYMNNWi5NWcI00UefV46EQ5o8/eKPTd2Au
 R1eztT2IKvZOmQK6EwO9xv97cGgr1Y/Gd3EtXR/RqO2ACMrtQqngPbZ1A6yOVjv2Vh
 m64MqCLFWs11Af4ltsNNHRYH9Z0PXXRtZts/BzSltUAHSNx4QJjevlCwtKHMXcnnCA
 5BgNL73eBCbhRaaGZUa2KALGegfm27MFVxpmnE8j5U/EALuqsnjB8eOWKAta/VuYG/
 qtfOaGhMdQQCsQQFYIruu/SCc9pr2gza6gJKnSpNVrFsud4EBJ68V/7ugdyhcq+AIz
 mXa8Up6hJTP8g==
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5dcc86ceafeso2635070a12.1
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 09:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738948920; x=1739553720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R8yCVWE+iE00xymiGhNWsupmu3mketxG2z5I2wSR4HQ=;
 b=ZD0w5tZvTT48c8p9IPLQlKgUd8IIc5hQh0vK94JLVz7QWTpwjELuQwpnJGP8enuyF7
 sQxPB67DEp1GkeTzVxuYboqhie7GE/Zk3TKHP7aq7Jj3sAGQ2NCAp9WfbTVIbJArjkx1
 zekQ93LOC3ME9PqrSIC+eJ2SyPcBvf8kkrx5Y8wGVCSUpiXESD3gG0+o7AYRqoBa0gVR
 kRW14BRoKUFjwoRmnqlbaXT/kXIEhCPkuUJ0raEsMfmw/XUHQGXk+sfp/GnzrJgmbPq/
 vdEG6BIXFRkg8ay2X4SaXKVOyzFg/e2ovVE+fbUcSffY06l7FjYzhfiT6XvfN2CNtNV7
 8eYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULbuVYp8eNt/QhMxZ96yjd9qSnhGJpblI7q/AuDcTNCpnm9F0nEDlCebrlirsuDcriynt8Eak=@lists.denx.de
X-Gm-Message-State: AOJu0YymtzVpteUWecDGU6O+A02XUlAeGmmiOsT6zBN7yTEWSRhVYanH
 JE942rWoRmzw4oTB2TgVzNIpuwKtuDMEExWbn8wELSYWaUZIClXg1Vue6yVbySJZs5LYD+B/PuP
 tTlz1qk7ApFrCyU34lfZt/rfYOu12vOTIi9PAZ9l1G0s2DFIrT5tcQnBwfzikYyUMS24=
X-Gm-Gg: ASbGnctGofqYXbA1jJwU1ZZ4jo9VU+pdqUeOaHjWXqPNGRv8gWDNzGs2z9SsQ4hIBwr
 0b1jN7RkASynho6reRfhVqUQvKCMlxo8ONsN9/WXnO1bl6wie27Ah5JHEufm+rawjblRSIxIZbr
 gD6u7NOThkaUIpEg7dXZbLA75eHAvE0LyZgJXAx1iGdp/SFSDPWzAyhvXmOaK2obVdiR8pVs4M5
 0z1sINwdHE9Qvoaz1Yv/dnfsXKezdjnspHghGldpieAqs5g6SQwOmP3AzOe3msqMwj9+ppfnKWm
 qmqzUndjbArZJSdbFYCy8aHtDGM+tEPpWAAOV1qel7BLBvwNHJUnx1G2Qjxzn5VZ3RVDAL3URgU
 LG/6XhLI=
X-Received: by 2002:a05:6402:40cd:b0:5da:105b:86c1 with SMTP id
 4fb4d7f45d1cf-5de45073493mr4246245a12.23.1738948920683; 
 Fri, 07 Feb 2025 09:22:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExVGwfui8UftCfIhJ7HAsXX7KxjPmd707S7se3yAPRkZYpXpIKNIyR8XVEoxL8AgInZN7TfA==
X-Received: by 2002:a05:6402:40cd:b0:5da:105b:86c1 with SMTP id
 4fb4d7f45d1cf-5de45073493mr4246218a12.23.1738948920322; 
 Fri, 07 Feb 2025 09:22:00 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcf6c9f8besm2866914a12.52.2025.02.07.09.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 09:21:59 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
Cc: Sandie Cao <sandie.cao@deepcomputing.io>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, E Shattow <e@freeshell.de>,
 "E . Shattow" <lucent@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 H Bell <dmoo_dv@protonmail.com>, Lukas Funke <lukas.funke@weidmueller.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Matthias Brugger <mbrugger@suse.com>, Simon Glass <sjg@chromium.org>,
 Andreas Schwab <schwab@suse.de>, Nam Cao <namcao@linutronix.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/6] configs: add jh7110-deepcomputing-fml13v01 to VF2
 defconfig
Date: Fri,  7 Feb 2025 18:21:11 +0100
Message-ID: <20250207172116.117749-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250207172116.117749-1-heinrich.schuchardt@canonical.com>
References: <20250207172116.117749-1-heinrich.schuchardt@canonical.com>
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

The DeepComputing Framework motherboard is a JH7110 device support by the
upstream kernel. Add its device-tree to the list of device-trees to be
included into the starfive_visionfive_defconfig.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 configs/starfive_visionfive2_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index c3f2142ae1b..821aea9c236 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -78,7 +78,7 @@ CONFIG_CMD_WDT=y
 CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_OF_BOARD=y
-CONFIG_OF_LIST="starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b"
+CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-- 
2.47.1

