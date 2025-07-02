Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5824C7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:05:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 802ED82F00;
	Wed,  2 Jul 2025 03:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MxT66QSe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABB3C81FEE; Wed,  2 Jul 2025 03:04:24 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9177B82F00
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-736f1953673so1599255a34.0
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418261; x=1752023061; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DRki5Eyf7+4CsXuI9gJ+19DxxdrR8FhQSpQVD9HWWTQ=;
 b=MxT66QSeoaPkzK6KoaTF4ZfwudDKBods6XOF0qs5kjXtXavg+Pp6UUVLKwxH9QQab9
 xaK05ML1dkVgbzKXl/MQ3+GBg6TqJl9Loto4XU4om00tk2FME3N6MQSW7vwcL2qqNMsj
 IhkQanlKqxPQDJRB6JWMOYw7b6TTWTEIkVwJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418261; x=1752023061;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DRki5Eyf7+4CsXuI9gJ+19DxxdrR8FhQSpQVD9HWWTQ=;
 b=PwVsoebySvvrxbS+5iS2H9nLpy2D84EV4rEoIsZ9IagO9XT04Gl9W8DigxqRG2vLOz
 v0Xpm5VyrTDTfjR9/PLbE/+sZokWtU9GIfsLiEdCIGJmm9lyoyTJsEk61lof9eIPXgss
 M2Hrw/Mj3jEBe/b1DToRY3LuPPc+69Ne0y5kBxmqCcGiOvqAh4R/Xg+QlyaRALLC5RUk
 39kIlCejW/JE+6o23P9q2Dhfv42YWfs55D0n0z/XCE3b+kCfKBEuqe5RNVCjyfExEU+i
 zYtkuf9LH6LbCHqEFjI3meI9a6wsLluf8tmf7nKY4ypWOWpvQp+g+YP287KuUmPVOpav
 2dsw==
X-Gm-Message-State: AOJu0Yz9NucU0XNL/m3p+vycWua6L8Bz0t6M+25TU8LhX3gP1TdjyEsA
 k7mUmfJh1ZSclgc17vfk95COqqdmMUAJv3KlbAk7aYShUu36ecuuox6ZhP4/QzvRqJ7B8TMU1yj
 jpSRXNhk=
X-Gm-Gg: ASbGnctGY7/wjGg78V+M3Zc0WjKh4iWBHfwVkgGFpaUVLvyqII2VNnTuaoa8nGv9OTz
 /7mrW/qoUXA3BZAHFlqffe9ZUZCagd/SxSLWGlHEt7iChzGa5Ru5df+lax2eN7/tD+ZlhgjMBhl
 sDk0rjdzy/6b/OaAqxct4vusrpp0qZCHnlqO9o259ZZkfAJkBW2mrCrvzmNpLRO/wANq5hmjP3F
 tBhGPNHg5cTfTvzKnWRo27FORLUZ2pmbB+zTcsfO+HvWyLsDuHbqheCbCOhks7IM2TIU9FRhk7V
 YbFkUsE2PxdZqxkZzT7kPMUfbpblkI9D1O5ELb/YEtH03UTRqTVlOiDzi63Yv7mCeeit6AMODMr
 /4V/xQbxHr9dGyetNhrr1Fzc=
X-Google-Smtp-Source: AGHT+IFYpmoCSG8CXuPwd6lKZhWT7o8PSkG50CSA/dzJNlZO1pzJBMzygRtrlfpvisbUrCsEbKm2Iw==
X-Received: by 2002:a05:6830:6489:b0:72b:8889:8226 with SMTP id
 46e09a7af769-73b4cdf6427mr679726a34.7.1751418261237; 
 Tue, 01 Jul 2025 18:04:21 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb006480sm2335903a34.21.2025.07.01.18.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:04:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Gaurav Jain <gaurav.jain@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] crypto: fsl: Only allow these to be chosen on ARM/PowerPC
Date: Tue,  1 Jul 2025 19:04:19 -0600
Message-ID: <20250702010419.18890-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

These drivers require various headers which only exist on the ARM /
PowerPC platforms which implement the hardware. Express that requirement
in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Gaurav Jain <gaurav.jain@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
---
 drivers/crypto/fsl/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/fsl/Kconfig b/drivers/crypto/fsl/Kconfig
index 9ed56632fcde..fe694f6022c2 100644
--- a/drivers/crypto/fsl/Kconfig
+++ b/drivers/crypto/fsl/Kconfig
@@ -1,3 +1,5 @@
+if ARM || PPC
+
 config FSL_CAAM
 	bool "Freescale Crypto Driver Support"
 	select SHA_HW_ACCEL
@@ -95,3 +97,5 @@ config FSL_DCP_RNG
 	  module of the DCP. It uses the True Random Number Generator (TRNG)
 	  and a Pseudo-Random Number Generator (PRNG) to achieve a true
 	  randomness and cryptographic strength.
+
+endif
-- 
2.43.0

