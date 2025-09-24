Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCEACAC5AE
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 15:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30054835CD;
	Wed, 24 Sep 2025 17:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="aK/oS9vL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 708C282998; Wed, 24 Sep 2025 13:31:32 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD3348350A
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 13:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b33d2f0f5f4so45281666b.2
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 04:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1758713488; x=1759318288; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RLMLS3KnmK9p3i31EI/V+cSRwZlDjekR6pN9gV2ey4Q=;
 b=aK/oS9vL/UeBI23j7dQNyPs5sNVWyxyPTjODA9HKJCwpgueaRzB/mA8/hCEUA8XHCl
 hwnRbt5uu29fKC5fVFMQSEJkvAu6sY1JasKTlIgyJK9AR+PU6sEeMSIwQVb30XrwYZL9
 EPIrRG8iu9Rt6lgcdR3hVLOKd3HE81JDh9MOrAs2MIKCKRWwXWpLrhcbkbM8PGKoDC9T
 MUHxNNkpNxDlhasMl1o5HfNo+KFFeZAsFs13sNVIc1EvoQRe5lMgxU4uTgI9OLy/vckO
 +D4V/8hGrD01W3Qx9xhIr9tGoc82Mx7i+oZHxLkGKPbekzllZj99iKFfbtdIcsvqhyQe
 6yAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758713488; x=1759318288;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RLMLS3KnmK9p3i31EI/V+cSRwZlDjekR6pN9gV2ey4Q=;
 b=tfmo9KncSwMfBpLNooAiWyXgNpjbfXaGsN0/FuoOtLQAP2Q0K8t0rGMnKisEORjZDJ
 dbkZWaE8jK6DwK4hfzuKPvJ8v9Fd0jNLjc+CsYGC6sszknbt2khmWkNnOlEJTUKrCAzs
 y7PvwR/PJ4n000gVfQis9KyLaRAkiJxQLI5M54OA1V6zpVsoMQev3w9E5x1Hvza/3n93
 PJgCDH0tqgK3IAFksUxERCUfqoyoLFYesV8IBYBAlKGWDQWloaZ1KPRl6nDBXZ6w5D+W
 77XkbXzjf9SGJjD8uKkQ6Z4QS6aCcmrh9Dc74vqXJMFEb4MaNU4S5jernbKe9r2Y8VoU
 CaOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhEDIgFSHbd6A06hF9j0nZ25IddXFl8hzg9ewgGsPUnuySgLv7N2xWnoa35KswfDXfmAKsBzI=@lists.denx.de
X-Gm-Message-State: AOJu0YwO0ex1wqZxtSmyX2RA65IU7lRPNbJ0NRDUd02CxcENEdI0F3Fj
 MJ/8rpp2XjNR78lxXBpwdDWe4e/rEJ/VZFjK9NykqE+cHQxnh+9eo159FWz0UCA4sqI=
X-Gm-Gg: ASbGnctRF5fDZkfbJ1zjNQ/gUZerBCJbQJK7qYgSXpHVLQdJfgOpDjwnGtLueS3j0dX
 S9dS9ozgn22i1H+qqoOGAONODzT7VKEiAiJbg4o/dKaxzbAaXihSCnVJDNBWMUMVwaC4FrnFDUC
 HmVdieE7HmGHroJrUrprFLeF8WLLdT6s0Gid5pLynDIBwwobW0xDJOB1qPiu+VNKZ48emfvomxZ
 iP/InbBuLAWeQ2P+zsaeGsb7IV9wbNyVf6Uy26Gm8w7sfclJS7viKFlK5Y8dPYssNcieWg8Vf0a
 xMWPxSVJ+p9VUPNzGDZbwrQi8ciJeTcx6E7oAhbjQNITHi/QHHyQ14ZWOJ6GyUjMH67N19oFtQf
 1vF+LUaTalIhdOsxOiRwUw+RabF5IyqcmJDtlprnW+vh+R0AJTPZLXJPdJ7bOMKFGkMxHHQ==
X-Google-Smtp-Source: AGHT+IFtjvuEmL/Tc4ci2FPhrf2eRyQbkRVG9/wR7z7zPu8GdK7radMSVPd++fQAeoTy24o9w12ysA==
X-Received: by 2002:a17:906:f58a:b0:b2b:5b40:1cb1 with SMTP id
 a640c23a62f3a-b3021108f6cmr608907566b.0.1758713487873; 
 Wed, 24 Sep 2025 04:31:27 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3339789812sm96698266b.17.2025.09.24.04.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 04:31:27 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 24 Sep 2025 13:30:10 +0200
Subject: [PATCH 4/5] doc: board/qualcomm: Clean up debug options for QUP UART
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-2025-10-misc-v1-4-7e75842ca714@fairphone.com>
References: <20250924-2025-10-misc-v1-0-7e75842ca714@fairphone.com>
In-Reply-To: <20250924-2025-10-misc-v1-0-7e75842ca714@fairphone.com>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758713484; l=985;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=e3kNC8fXo+3M4DeJAqKEUu0PPPTWy+isKkwuOoJwQ98=;
 b=u36w/gLKJsi8gCR1vADdx4J+Q3rCuuqNNt/Ui/hKJoaEGBIWDujbzeEr9UGPDwsP6oIr1LEiT
 ZGoGDheIx2fDNPa8m3ZdV11sJH05RsdR3tHOox8O3H2VXtYNQVYzV7P
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 24 Sep 2025 17:25:44 +0200
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

CONFIG_BAUDRATE is not relevant for the QUP driver, and neither is
CONFIG_DEBUG_UART_SKIP_INIT so remove them from the doc.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 doc/board/qualcomm/debugging.rst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/doc/board/qualcomm/debugging.rst b/doc/board/qualcomm/debugging.rst
index c3289c9e4e346058943afd9c803cc44426841544..42821f6546c6425c4b55e1f89501b94bbf9d0623 100644
--- a/doc/board/qualcomm/debugging.rst
+++ b/doc/board/qualcomm/debugging.rst
@@ -42,7 +42,6 @@ Older boards (db410c and db820c)
 
 Open ``configs/dragonboard<BOARD>_defconfig``
 
-	CONFIG_BAUDRATE=115200
 	CONFIG_DEBUG_UART=y
 	CONFIG_DEBUG_UART_ANNOUNCE=y
 	# db410c - 0x78b0000
@@ -50,7 +49,6 @@ Open ``configs/dragonboard<BOARD>_defconfig``
 	CONFIG_DEBUG_UART_BASE=0x75b0000
 	CONFIG_DEBUG_UART_MSM=y
 	CONFIG_DEBUG_UART_CLOCK=7372800
-	#CONFIG_DEBUG_UART_SKIP_INIT=y
 
 	CONFIG_LOG=y
 	CONFIG_HEXDUMP=y

-- 
2.51.0

