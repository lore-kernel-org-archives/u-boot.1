Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF1BE748E9
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 14:15:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1681D86D61;
	Sun,  1 Oct 2023 16:15:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cf/qbyYK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71B0486D65; Sun,  1 Oct 2023 16:15:50 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 971E686C00
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 16:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer+oss@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-533f193fc8dso16273120a12.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 07:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696169747; x=1696774547; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JmiUdJyK7iudLhXdrtJ55nlWLUngd7qMlaM8J3Jj95I=;
 b=Cf/qbyYKBPJeVgU0o0Mo4Gd6DFvtyqAH5rh9om7O7ZvRKdIFrP0xSvQhV6QxJ1SZsD
 /M3crLiNemectkz4yGeFrEb+t7lITlHh4SLqI5IT+J8KOKVGONKwWfPc4UVrDZNOZv4s
 WTgRPpT3hbN6ABwqrHcZUP9GmTGr7yhMO9XR4Clapm9/gZJvHDdY8/m9cUMRlUcS3PA6
 9ATG6266eVw5O4rlguieMYclXroRnfY1OFPiYOUORqO9c+I996xoOvQuGrmwRmRMy1K1
 CpryJ6DXwSu5KvrBTiARmtN1dGWdMDSikCjN170rO4lF1qT4rsToMWTByHGUPAUXViHQ
 bODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696169747; x=1696774547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JmiUdJyK7iudLhXdrtJ55nlWLUngd7qMlaM8J3Jj95I=;
 b=WGFiY4LVdpPjaX66HJL9p0UjHso0N59z9Dp7QZT2JwRU4XcUbkNpvCJoADT3WcNgje
 f9ur/oiKtUW/tAWxc/Wv9zNsVjQlkK5xDcnmCQBhDWuquhx2soYDX3ZGvprDouDpAD9H
 L7/YWX2L3zvTDjlR28Our8nJS6NjEQJKn8uTxuupHs44c8B/n5wMOrl7L21oCoJ9T4wi
 wHLpFnfElCNkmHmUHkC6fqC6wPJ8a0C/WCIbQJkDGBy8QlTVyirC8KRyISvjAQKJf9oc
 KRtnTtDMnnA1+7q9xoeqLr95b3V6bCXXZ0NTpULjgOK/m90NL9cpfZocC1cjIkLofBBs
 Gj8Q==
X-Gm-Message-State: AOJu0Ywc5eknEgtM0+GTgGCRgZhgBdWwq9isvshacGixsV9cSYOgbE6D
 lQLTZW+0kYasQGofzlcXRf4WxMDjvZdKkw==
X-Google-Smtp-Source: AGHT+IEt83JV97aXrlNI6m/s9P+CTHV/xjvHjeEznnG16Ht2/ENz8hlqxERtO2JsWXK9PtLOX9HcKA==
X-Received: by 2002:a17:906:10cc:b0:9ad:f7e5:67d9 with SMTP id
 v12-20020a17090610cc00b009adf7e567d9mr8418087ejv.4.1696169746887; 
 Sun, 01 Oct 2023 07:15:46 -0700 (PDT)
Received: from pegmas-T15.fritz.box ([151.51.187.8])
 by smtp.gmail.com with ESMTPSA id
 w27-20020a17090633db00b009a2235ed496sm15800415eja.141.2023.10.01.07.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 07:15:45 -0700 (PDT)
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
To: u-boot@lists.denx.de,
	Kever Yang <kever.yang@rock-chips.com>
Cc: Akash Gajjar <gajjar04akash@gmail.com>, Andy Yan <andy.yan@rock-chips.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Jayantajit Gogoi <jayanta.gogoi525@gmail.com>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH v2] configs: rockchip: add DOS_PARTITION to RK3308 boards
 defconfig
Date: Sun,  1 Oct 2023 16:15:29 +0200
Message-Id: <20231001141529.1784336-1-massimo.pegorer+oss@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230902171507.351774-1-massimo.pegorer+oss@gmail.com>
References: <20230902171507.351774-1-massimo.pegorer+oss@gmail.com>
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

Without DOS_PARTITION support U-Boot is not able to boot an OS stored
into an SD card with MBR partitions table. This is still a quite common
case so add DOS_PARTITION (only for U-Boot proper build) to Rockchip
RK3308 EVB, Radxa ROCK Pi S and Firefly roc-rk3308-cc boards: they are
the only RK boards missing of DOS_PARTITION.

Reported-by: Jayantajit Gogoi <jayanta.gogoi525@gmail.com>
Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 configs/evb-rk3308_defconfig       | 2 +-
 configs/roc-cc-rk3308_defconfig    | 2 +-
 configs/rock-pi-s-rk3308_defconfig | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/configs/evb-rk3308_defconfig b/configs/evb-rk3308_defconfig
index a13a809c1e..c6472a2c9c 100644
--- a/configs/evb-rk3308_defconfig
+++ b/configs/evb-rk3308_defconfig
@@ -47,7 +47,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_ITEST is not set
 # CONFIG_CMD_SETEXPR is not set
 # CONFIG_CMD_SLEEP is not set
-# CONFIG_DOS_PARTITION is not set
+# CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_ISO_PARTITION is not set
 CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
 CONFIG_SPL_OF_CONTROL=y
diff --git a/configs/roc-cc-rk3308_defconfig b/configs/roc-cc-rk3308_defconfig
index 9a789b212f..ca92b8f744 100644
--- a/configs/roc-cc-rk3308_defconfig
+++ b/configs/roc-cc-rk3308_defconfig
@@ -47,7 +47,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_ITEST is not set
 # CONFIG_CMD_SETEXPR is not set
 # CONFIG_CMD_SLEEP is not set
-# CONFIG_DOS_PARTITION is not set
+# CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_ISO_PARTITION is not set
 CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
 CONFIG_SPL_OF_CONTROL=y
diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
index cc3274a98b..1c1fdc6611 100644
--- a/configs/rock-pi-s-rk3308_defconfig
+++ b/configs/rock-pi-s-rk3308_defconfig
@@ -48,7 +48,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_ITEST is not set
 # CONFIG_CMD_SETEXPR is not set
 # CONFIG_CMD_SLEEP is not set
-# CONFIG_DOS_PARTITION is not set
+# CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_ISO_PARTITION is not set
 CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
 CONFIG_SPL_OF_CONTROL=y
-- 
2.34.1

