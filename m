Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591F9CF6D28
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 14:49:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B426D890BD;
	Wed,  2 Oct 2024 16:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GXigSzwp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E43B88FE7; Wed,  2 Oct 2024 16:49:08 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E604890BD
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 16:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cb6f3a5bcso83477775e9.2
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 07:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727880546; x=1728485346; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W9/Q2fj3msO80Wgbd3JMg0DS4YPsnU9ve3XG56N/5iM=;
 b=GXigSzwpGuCAZnlj+dNX5L5+Y+bliGQfOGT2O7kah9rHHRlqQ2JQl+zq08f0+Tql1G
 ntNv5eeelvvqWxzmfCGI0wgt99M5583TH8JakMuOVZ72XHWa6IxXax4c8fPnHLFrrnUx
 Pj3eLPQCbAgPuD1igM9uAH3jweEAbJw0VFhM3HZYWS0zqeAm79wRI5asdkeIO6XaSqxm
 CWiyAAoN2n4sVEeCsmvj0TrEaiPsmVUNhhq9s98xKJVoMkYFsPDXkUop2jSPKDZ4d8V4
 hNkM45TugcXtlo/sy1hBhuCivusbHtkVwvnW2H6PxJ+tOMvq8T0uQwuWQrVknxvOfeYo
 zWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727880546; x=1728485346;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W9/Q2fj3msO80Wgbd3JMg0DS4YPsnU9ve3XG56N/5iM=;
 b=OWwUMZ0tE58m/Q8Uawe3GfrCoEYiCQ0WkgVIKGNwrwLzq7vyBDoHM20L1FX0oZq/He
 +ku7qb3ebsfnbPeI9GopJUHZ11S2p/MvMaMVpfydQax7FCE86Fqh4NJNcUuGHoz8M9ay
 3S2BMMKK9/151jpztutCRx12XQN4R9343VMr9uZtEvGiaB1uLoyZHyqAxeLK79XYk7le
 MIfaijkb4xQY9WOe6w5MmPc58gIrkhjUAbR/PZN6Am2zXYFyGPS4i0H1yQNPfEj7nWiq
 b/90t+pbM+Pqb3QaTDqDJhoPqoSSpEQv6zG0NoKqFr+L93ZS3vPjTHm6lRrxaZfv+fqi
 IBmA==
X-Gm-Message-State: AOJu0Ywk4G2EMlKA98mHukeLqAFnf7BR7VdZj67Jt1MTFRB/bP2Ef5Mr
 V9BylFvtnBJ+7p8OoBH2i7dKx+o7au8iTSrhXP7mIG/aRfOC56U1XPbXbiEvRhPRg2gE7o2pmOC
 46DHfsQ==
X-Google-Smtp-Source: AGHT+IHGxJygUYwO4QAt2AlRsuz/eKjLclQ2mZldRh/sHPKJFav+zcLQqAAxZuAXYycGMtjUODwP8w==
X-Received: by 2002:a05:600c:4751:b0:42c:bbd5:727b with SMTP id
 5b1f17b1804b1-42f777f07b2mr35162175e9.25.1727880545647; 
 Wed, 02 Oct 2024 07:49:05 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d322:a747:4ce1:c692])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f7a02f262sm20338605e9.46.2024.10.02.07.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 07:49:05 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Joshua Watt <jpewhacker@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] Make AVB_VERIFY depend on FASTBOOT
Date: Wed,  2 Oct 2024 16:48:45 +0200
Message-Id: <20241002144845.1439316-1-jerome.forissier@linaro.org>
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

AVB_BUF_ADDR, which is under "if AVB_VERIFY", defaults to
FASTBOOT_BUF_ADDR. Therefore AVB_VERIFY should depend on FASTBOOT.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 common/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/Kconfig b/common/Kconfig
index 957de0c5c02..c011ab6e820 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -850,6 +850,7 @@ config AVB_VERIFY
 	depends on LIBAVB
 	depends on MMC
 	depends on PARTITION_UUIDS
+	depends on FASTBOOT
 	help
 	  This option enables compilation of bootloader-dependent operations,
 	  used by Android Verified Boot 2.0 library (libavb). Includes:
-- 
2.40.1

