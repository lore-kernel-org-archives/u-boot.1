Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE07EC02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 15:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4650380819;
	Sun,  9 Feb 2025 16:23:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="goab1i8j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69D8C80821; Sun,  9 Feb 2025 16:23:40 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3316080141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 16:23:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 221B63F2BE
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 15:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739114617;
 bh=BuWc7v8Wg5qU8DNdCu8qjCODxjKfftCHUYl70EEnnmE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=goab1i8jXl8MeFSC6RR9YQU5YtVLIiJV0cr3gWEfWVoY9poVlL2Uc4tzN/KfKXuCs
 gba2cP+JE+xa9mn8AMTPhFtiVrdZRoiK0nnQJFbfMGhtWKjRtZdXXSQk76Kq0ywkcN
 RBkALO+L/gCNWH0TEc6PotsC/nHLlXO+Fmnp+VLXv3B7w3w1P1tnAqqEnbX5ilBXgR
 QWOm3G8yU32ySyghxbHYlg70wDwEN7tA9bCTwqaDxB3GKD1nfEnhvMSwsQdl4hZDos
 7lVtWKWnrN9rDyJbdAQTl93nD91kgUxVEyYM8rkt7FJ0+mwSuujw5JOdbb4R40bj2D
 riPARyet6wt5Q==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43626224274so21268425e9.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 07:23:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739114616; x=1739719416;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BuWc7v8Wg5qU8DNdCu8qjCODxjKfftCHUYl70EEnnmE=;
 b=cFHhHwwVHl0BZfDXu1pTME/sngYjn289t6viGwmUvGPMNUksuAPX2nm3+p9qc1yEMU
 yniiyScwVOCAXNJiWIHIBbZpvcCmwugJvR3FgAe+z/UmwjLDl/1cWN2auAj3lO7aIdHX
 NsCzc01kbxHCwdQncKAnO37MG07a+tZCK2X4M389wxhF7UwcmhkL5WnXekxs81F6kRqT
 CECjJDAZQRv3wyeZpG2JyWNyP+gA8VAzrMIQf87061r2jnsk2eiUtHJTt5YwNjsChRzw
 Kxa5iMX8i/0nzv+MX1LA5Eq0EDasF6QGZD9DEvTM/wauU+MX1Bmcj6Rai64jVQ+1/9ap
 95JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlc5BFOJ4NhwJn2OSIMpfekJpl52yP/Z/9IUKYIxuZlDfmlcWvWn6upE24f4eksOWekR9LHv4=@lists.denx.de
X-Gm-Message-State: AOJu0YwTlA2+Cy+FQaqtwf2AD0I6WF5VW8eMKuFlTbutAdymmaWZx1PA
 8wpfJ2/7RYADXTaqoh1x7XfdVMEYnNhUZXVsLifYmIpvLLTwhQD+EHbQKMXCVOVv6uek0kZJNiN
 THEGOhbREgdmNRoiLsdSxoMZh4Z2zwSaYgnt3m8hC7QorKf9wN90fj4nhJskbNF9JXWc=
X-Gm-Gg: ASbGncv2z1YNGGeuu9zgcfjtfsXMiPr/daTJP3Dbd61uX/ut6GeD/lOiyVpDidlTgDv
 D9964ZTcL7QocYB9/VMZfMYmJQe6T0LqHF09bdpLNn7QS05OgtwyKdXb2SasScyWXchWc1wEvzo
 0hAg4kIfJU6tKGZiNI/7UCVWQmEpSkIbrwV4fg2HvYFYWh3zaKdn/hlBwVwbwxmfi1+StSzH1lH
 0CKFLrOfF1TlYmuWTdBiSd7RzhbHYbpqLA1IuX5IBh/FvVL08rl+caqW3FnofRkYCTkPjFFIvyh
 XnrCuZT4NYkejqCHxKn5E2LnunHJngFMKfawfgEu6JA7J6u1Ww1zUwbRwKMo0VVFXH2bg6lEAUJ
 DYaRBzJE=
X-Received: by 2002:a5d:5988:0:b0:38d:dcf1:d159 with SMTP id
 ffacd0b85a97d-38ddcf1d5afmr1896280f8f.21.1739114616587; 
 Sun, 09 Feb 2025 07:23:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpUJ4w5y3RlRgcR4A6N3KXOvF1a6LZqB7yvywO/RdizWOAAfzci8l/6ykAyw6X6hqmqGYvPQ==
X-Received: by 2002:a5d:5988:0:b0:38d:dcf1:d159 with SMTP id
 ffacd0b85a97d-38ddcf1d5afmr1896257f8f.21.1739114616281; 
 Sun, 09 Feb 2025 07:23:36 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd016496esm5912663f8f.19.2025.02.09.07.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 07:23:34 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>, Yu-Chien Peter Lin <peter.lin@sifive.com>,
 E Shattow <e@freeshell.de>, "E . Shattow" <lucent@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 H Bell <dmoo_dv@protonmail.com>, Lukas Funke <lukas.funke@weidmueller.com>,
 Andreas Schwab <schwab@suse.de>, Nam Cao <namcao@linutronix.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/4] riscv: dts: starfive: simplify binman config
Date: Sun,  9 Feb 2025 16:23:25 +0100
Message-ID: <20250209152329.187194-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

All StarFive JH7110 are supported via starfive_visionfive2_defconfig.
Up to now we have explicitly specified the multi-device-tree FIT
configuration. This more complicated than needed.

Binman can use the information from CONFIG_OF_LIST to automatically
generated a FIT image containing the necessary device-trees and
configurations.

This also removes the non-functional default configuration without a
device-tree that binman added up to now.

Thanks to Simon for the suggestion.

Heinrich Schuchardt (4):
  riscv: dts: add OF_LIST handling to binman.dtsi
  board: starfive: spl: strip off 'starfive/' prefix
  riscv: dts: starfive: remove duplicate itb entries
  configs: starfive: default to jh7110-starfive-visionfive-2-v1.3b

 arch/riscv/dts/binman.dtsi                    |  7 +-
 .../dts/starfive-visionfive2-binman.dtsi      | 76 -------------------
 board/starfive/visionfive2/spl.c              |  4 +
 configs/starfive_visionfive2_defconfig        |  2 +-
 4 files changed, 9 insertions(+), 80 deletions(-)

-- 
2.47.1

