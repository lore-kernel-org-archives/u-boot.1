Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F948C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 00:17:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE83383032;
	Tue,  8 Apr 2025 02:17:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EsFmL649";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 713BA8307F; Tue,  8 Apr 2025 02:17:01 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 367D583028
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 02:16:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7359aca7ef2so6792772b3a.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 17:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744071418; x=1744676218; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s1HUOcOd0oUojtJGae2gcCH+UJUQnAvyqejDv19YCj4=;
 b=EsFmL6498t4qZZSZL9d/APK+jH1+6WSweVYSq37O2vbI4c/lxbNMNVP+SR55Hkekmy
 /J/joNY9mjjhNMDa1GNfwZW3WupoYumGQSomKcVIRHmqahs+zK4LUY5XdrFuv9W6qJDU
 8dFRpj9HhjzArxJ0JAn5ZMUJlWVGCFivfAyABBCeCMDgMeLDWLxe/m1KcFJwhHWOnte+
 XHCNS858CVmphgGQW08lvuTa64ofHbN5DAKF7sRwm0AaZXr/51Ot0Juzvnh++9F9F+6n
 S1WwyhaYmH0k407dJb7X+E2ny7riMC1Qx5hZ2KhEdTScQ3QLfUPHMOrLOJe9NGZ/JnQT
 gLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744071418; x=1744676218;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s1HUOcOd0oUojtJGae2gcCH+UJUQnAvyqejDv19YCj4=;
 b=lTlNibWniPKSyE5VtVYtva4SUWeGWPvGbqbDbBWRwNR24O4/olXLJdvi2zcL1BWcE6
 wqI1gw8hpJUgBm+qorOXzL/C1e3z9WtYTvDjTiOBFjKo/3XgOOot8CBddCcxZsUFqb72
 LOEYibyozeaA61x3Mdl6Lfo+miWds71DoH2eAxbyKrj0LliennLcpLLn1Oko7DO4Sa7Y
 m+XB0cpW9GP97yLLtu/kvsq+a5nHdyuS+hDR8tPaQv7exvJlpLu5CdtL85Yr4a4bwuH1
 9Xvl0uVjo8m4vwjG8KnnmkHpgP9yKAon2tJFULSfYIkB3UJwSwPS9yK+PHY7Gv4DDS2V
 2z2Q==
X-Gm-Message-State: AOJu0YyNm2y4tR/F4IVkJD1J+nMHCnzvGbA+MO67AlH6qzCWXEx1W1gx
 dOt6EB/UH4pmeZOQnAFcHRYqQv9UoixCSg+HRhGOITbgHqf86sbrwKIo/g==
X-Gm-Gg: ASbGnctZoJyo4/uiu6imHxkY8qCSwKBkT4m0CY8NXFdfxMwSTUkl7tqKRBu3lAHHlwR
 k68oZgCNpLFYa7DlEZd1Tf7Fsd8DNKij8wk4YAN3YS5CQY+ATzRhh6YNpSGpKQiDRGNk2rtQ5Ih
 bq4uzX7AhsCzlUBe/YIQC8r6bJVVrJNGDg3VEHvm9LpW7FVG7jueg+E0z6yvJiUZ9dVLW5MKw9h
 Sq9cEUj3h8kjCxwruaCK5QBfTPU86XkR34inZqaKOmWfhvKsxDAX61QCKlhZ7SHarrEUPDP3oPA
 GAdH0cbhzWG53IVysOY3ve3BdVPrX+DVJO0PpG9IICu38HlX4ZooQCzynmUKe5rY1Qin1A==
X-Google-Smtp-Source: AGHT+IHORxA9fWSPNYTMQS2lFxoEsqGWlBoyfGgt2uuRXttz7Kb6TPaQBOuJmZ8KLWGP0inm3LDeSw==
X-Received: by 2002:a05:6a20:ce4d:b0:1f5:8153:9407 with SMTP id
 adf61e73a8af0-2010801598emr19928269637.20.1744071417669; 
 Mon, 07 Apr 2025 17:16:57 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:b709:c041:6c2e:b6d7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97d32b2sm9204408b3a.5.2025.04.07.17.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 17:16:57 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: eugen.hristev@linaro.org
Cc: u-boot@lists.denx.de, trini@konsulko.com, Fabio Estevam <festevam@denx.de>
Subject: [PATCH] configs: sama5d27_wlsom1_ek: Select CONFIG_NET_RANDOM_ETHADDR
Date: Mon,  7 Apr 2025 21:16:39 -0300
Message-Id: <20250408001639.469298-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

Currently, Ethernet fails to probe due to the lack of a valid MAC address:

```
Net:   
Error: ethernet@f8008000 No valid MAC address found.
No ethernet found.
```
Select CONFIG_NET_RANDOM_ETHADDR so that a random MAC address is generated
and Ethernet can work by default.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 configs/sama5d27_wlsom1_ek_mmc_defconfig       | 1 +
 configs/sama5d27_wlsom1_ek_qspiflash_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/sama5d27_wlsom1_ek_mmc_defconfig b/configs/sama5d27_wlsom1_ek_mmc_defconfig
index 378a8af20810..171081310904 100644
--- a/configs/sama5d27_wlsom1_ek_mmc_defconfig
+++ b/configs/sama5d27_wlsom1_ek_mmc_defconfig
@@ -72,6 +72,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_CLK=y
diff --git a/configs/sama5d27_wlsom1_ek_qspiflash_defconfig b/configs/sama5d27_wlsom1_ek_qspiflash_defconfig
index 6b75825a13e6..f0831ffe4c52 100644
--- a/configs/sama5d27_wlsom1_ek_qspiflash_defconfig
+++ b/configs/sama5d27_wlsom1_ek_qspiflash_defconfig
@@ -76,6 +76,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_CLK=y
-- 
2.34.1

