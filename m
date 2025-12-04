Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414FAD216B2
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 16:42:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC7CB8415E;
	Thu,  4 Dec 2025 17:41:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jI58eWoG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D43458415E; Thu,  4 Dec 2025 17:41:56 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78AE384144
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 17:41:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.oss.09@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-645a13e2b17so1637313a12.2
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 08:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764866512; x=1765471312; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NEJSWnZBsVUeTjn+XozyJ+zsAGuOfPjJdUA4/Jn99j0=;
 b=jI58eWoG1CIkUp5w6Jm6IRWcuID8EPls5gpHQ5CQAHlEkfLeqG/eeCeX3ya+r6AMLY
 ZNtajP3cynzzGyDG0zR7kdcinlJt3uJAfKZw5tURfGwBgM3p2vcECPzcZ90Fn7Iy0t+0
 EwTig778ha7wPtuyVWuqzB9Vz6f5NgmYWFxFhs09hTYAbHHeifL+U8HfUcg9dygzh6Hw
 9GiydLBsS9aiGQgMT3LFqDiWLA9Tim09ahp0+HiXEzVgsDoaYKj8kvF2xnar/DgKqXJc
 2UiWeSUQ+PDcdR8aklzPFOUjaUt4DaqTpc10MPi/pogNiTDn686TOqgEAv+Pi9iIuw6g
 qnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764866512; x=1765471312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NEJSWnZBsVUeTjn+XozyJ+zsAGuOfPjJdUA4/Jn99j0=;
 b=mRDp2iXURQ837aRvtQhtWsNC8Wf5atQlENpzOHcjVuum1MGXDX9eQ1Tpr8tr4rxvCk
 TK/0jR5NgdxK4AfvMXTgdXJ/TInG9BEl3wN7w+NNPMhDzy0jKO60B3+5BGuNnmdLSfty
 f5SghQS+OHlnVyL2c1FYbi2t0LpLiLWb1Q/OjLlvFY375f+93Z9ZyDDrxF5guylTzd5A
 Tc32V4bb3UtAQKgv7cAXX1Vm9wwEU5oOXmCMqA85douSfoQzoCEI4MEGywh0BaD668ER
 icxcEWkJza2vQ1/zGDQSFqk16Td/By+Ekp/yCX40hU6Q/cNkNlzS4FxqsZiyz8/6l6OA
 n1lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrAeXqtzbiQJBAG4M2BIJWpZ31P9W0O7KU272AcAC+qgOCndqUbO8j82i7qc9iekChwyeFfSA=@lists.denx.de
X-Gm-Message-State: AOJu0YwBG5hHeXdlNjINWcjSnmXjwaAYN3sztmivoDcnn1egpe0eEZmR
 uITUqAWOC56t+8jHW91wK1vTsYqroXiH9xe1txwSHJci5cv8Ro4Yj5vo
X-Gm-Gg: ASbGncu3shvydSmqJY/01FrcJM0N1fDbpAArsIMkXUFhTW+C8c/RQi4TVWVMA6/dSJa
 02ef5nAF2pQ6UU8JIoiVmR6qPAFKaQiDWeGeAY2NT+XiBqmCsHiO8ArXkujBRp0SGeJHWd3iDtM
 4vQg7EmVrjEATzLHiYsql+K/8vW+f1SfVnakSLr6YXa2uw2mHclkSNF1WHNIuT5cBC/ZejCjvWz
 b71hGfqFCzUCqQaUeL4CWkoBBASBomfcYmJUFAINlRq6tGxW1Ge6NcumI4O5GVV7Y/4mSJVkB6n
 aeVjGotRhpPkbhvfEpg1cgX3TNOSkIdnJyRZguIWtGSy9zueJWreoPK9VhwtyEBd2Raz/F1HASp
 W8Nky2xRGB4mhgUotqiP8yPCJ5gtDGcFOVn+CVqC9H0Nb71plNcqJ6OhYINuhxotRjRIV2KR24o
 NTZEJXM/UujMFgJJVb+nLiYp0A8Ce0ei/W1XB+kbHnqbTxoEBfqXK9Rmf5Qm/CBZy3z3rzK6tAa
 +b0di5H7HKL7+/6
X-Google-Smtp-Source: AGHT+IGhbVJJeYTI5ibugbxx6eYu64biazJwty/kdvLCebkfzTUg16vpOHZte/e02e5FLtj5IunkWg==
X-Received: by 2002:a05:6402:3583:b0:640:b99c:de83 with SMTP id
 4fb4d7f45d1cf-647abdd591fmr3488296a12.17.1764866511589; 
 Thu, 04 Dec 2025 08:41:51 -0800 (PST)
Received: from toolbox.int.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b2ec300esm1750465a12.1.2025.12.04.08.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 08:41:51 -0800 (PST)
From: max.oss.09@gmail.com
To: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH 1/2] configs: apalis-imx8: use default for SYS_MALLOC_F_LEN
Date: Thu,  4 Dec 2025 17:41:28 +0100
Message-ID: <20251204164133.1677471-2-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251204164133.1677471-1-max.oss.09@gmail.com>
References: <20251204164133.1677471-1-max.oss.09@gmail.com>
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

From: Max Krummenacher <max.krummenacher@toradex.com>

Drop setting an explicit value for SYS_MALLOC_F_LEN. This increases
the available space to 0x10000.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 configs/apalis-imx8_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/apalis-imx8_defconfig b/configs/apalis-imx8_defconfig
index b8754f912a4f..064ab0546f12 100644
--- a/configs/apalis-imx8_defconfig
+++ b/configs/apalis-imx8_defconfig
@@ -2,7 +2,6 @@ CONFIG_ARM=y
 CONFIG_ARCH_IMX8=y
 CONFIG_TEXT_BASE=0x80020000
 CONFIG_SYS_MALLOC_LEN=0x2800000
-CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_NR_DRAM_BANKS=3
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
-- 
2.42.0

