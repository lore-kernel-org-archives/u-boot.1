Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD28C54791
	for <u-boot@archiver.kernel.org>; Sat,  9 Mar 2024 22:01:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAF1287F03;
	Sat,  9 Mar 2024 22:59:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BRaql9v7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34A3487D5E; Sat,  9 Mar 2024 18:54:02 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD46E87D46
 for <u-boot@lists.denx.de>; Sat,  9 Mar 2024 18:53:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6da9c834646so2883364b3a.3
 for <u-boot@lists.denx.de>; Sat, 09 Mar 2024 09:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710006835; x=1710611635; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m06Y0kK13P1H6NkqaeqpsIh58OtgW+SOEEKN5UWkkR0=;
 b=BRaql9v7GXUxC003b3o3bkQmoBD5d6rRd5R/i+omGUyPD3eS2QX/7OaTlBPH8DfBgw
 7qw6LYPIFY+zlcFvgx0O+b6EgBOD+krfUM2NJgz79SpDOEvwuwglN2ghuiahrRP5kUuX
 /o/h6xW4uL5GULiF/c0emS1E6iPoIjg32jGJ92SttxtOaBeROQGcTxiGt2gOrvYl8QfU
 N+bJQjCa0BBUA0761gefma4mO3As0g7rJyirQXeLu32Fd1lFwytgJ9zfKnHhBNE6KeQh
 pSWHZlcRRxLIKeS49sxjWIFhgSvpFSERj5VIeZ03dwvlDw4kXs5uS2X2RQbSCTGDS5Hh
 LLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710006835; x=1710611635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m06Y0kK13P1H6NkqaeqpsIh58OtgW+SOEEKN5UWkkR0=;
 b=GotcIOsJaiKFH/MIvvveeTHWD6pFqqMddtmUwgSkCzoUwAwM74OUlHNuUT4uOB+XB+
 +1aRYM58DknKzr5Es3QIf81l7YXZ3sUYfqBJwaA8LU6QwVlI4Om3lsWLbbo23kcMzhF/
 IdDKxT7J/TF46EygZB+XieWZhxHbp5L2CJw8neuHd1PYVsneyTFY9JsipiSJQIdqabbD
 zLAbw1+ZSaSRJ7v0LjXvCegHeI1d1n1urigPZ1fi6c558nipvLHmGd0ByZvg94We3Spv
 6oETc5dWYd7W8QvV5yMAKClRxyLjlQRLx3KUTDQPjyEnSRkO1fQAmYrTjDPeRkieU8Jg
 gf6g==
X-Gm-Message-State: AOJu0YxjmY3jXqVefNPaHj+ojD6WBxjncYFIPHkWfNH3i5dqNFslMhAm
 84SaAYbppXzSLjQP74zoCV2HQ7vxjYFZiund1yzX1xeyhINW9m1//PeZmOIXFPBJSw==
X-Google-Smtp-Source: AGHT+IFcYsmAg96yG1epLZ9A4/GUide2z8toQbY/nRffehcJLNtjZ1R/qej5HJUVlJdLqK3laTImcQ==
X-Received: by 2002:a05:6a20:4294:b0:1a1:8c29:6dfe with SMTP id
 o20-20020a056a20429400b001a18c296dfemr3080170pzj.13.1710006835056; 
 Sat, 09 Mar 2024 09:53:55 -0800 (PST)
Received: from localhost.localdomain ([117.135.91.249])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a631e02000000b005d7994a08dcsm1530651pge.36.2024.03.09.09.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 09:53:54 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/3] configs: milkv_duo: Add SD card configs
Date: Sun, 10 Mar 2024 01:51:57 +0800
Message-ID: <20240309175330.79267-4-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309175330.79267-1-seashell11234455@gmail.com>
References: <20240309175330.79267-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 09 Mar 2024 22:59:37 +0100
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

Add configs related to sdhci and mmc for Sophgo Milk-V Duo board

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
---

(no changes since v1)

 configs/milkv_duo_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
index 548adf174c..e8413d7aa9 100644
--- a/configs/milkv_duo_defconfig
+++ b/configs/milkv_duo_defconfig
@@ -17,6 +17,16 @@ CONFIG_SYS_CBSIZE=512
 CONFIG_SYS_PBSIZE=544
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="milkv_duo# "
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
 CONFIG_ENV_OVERWRITE=y
+CONFIG_MMC=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_CV1800B=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
-- 
2.41.0

