Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4217CEE49A4
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 18:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A93986CD6;
	Sun, 10 Sep 2023 20:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cXkOKsde";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3614686CEF; Sun, 10 Sep 2023 20:25:06 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5524486BFE
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 20:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=abbaraju.manojsai@amarulasolutions.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-565334377d0so3170337a12.2
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 11:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1694370301; x=1694975101;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PTY2PKPjWjmmj46UtEpcqBPEeIUke5rhsaY+AjwO/nY=;
 b=cXkOKsdetfpxf4qxOD1uNlja8lIUuzH461qwXIINrcYLll3d1RVtX4Z0sl0xzdMQah
 gt+KQOzzXI7B2xHeSeOxNFAo4QXJaPGf/+iK2/YAG4QMe0gUraEOC3W1HFpizCb7yCc5
 Jr6cC4YqDS84QCF5juw3aUpE8Eb57W5QubVys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694370301; x=1694975101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PTY2PKPjWjmmj46UtEpcqBPEeIUke5rhsaY+AjwO/nY=;
 b=ZNwhGaT3gDYu4lBgs+1UE4yAeQeR2gbhJAwpx0cZE7pSFifCwCZFUSvShSQWbI4BA4
 Uf4kiMC9j1yK2PV0UNlPS8yeMFSrJ/7vP2fEb22k2zjvfiMgYXsuqrhdaAbxGBPiDtMJ
 Y6cfgtF0oe8QyIuieqwHIzwRo/G+HnvlmtVK5mI0oBEYwbQqG239wKsG0G2yI0hK8KVf
 ZJNf+ba+mATf5Az2PuUnFT2FNqV6FCB0bGKBR6aFNeQ776eBzF9tpwrOQF4XUwv/aP1G
 NrBZiYedyntsicbk+rXMo9UvNpXnANt0PeP5VjkjCC+hZFlkW6ZqekKFSJeOU6MOMYso
 5NSg==
X-Gm-Message-State: AOJu0YwymqywRErDhC4iEjyIgbBEtuquuqQm8OB9JqkwELkLshI3hGbD
 ux33k6HI8p9ofpbjCOhrikyDjA==
X-Google-Smtp-Source: AGHT+IE4tgtyfs/n4XbM8r5QoWx181nAzNRpDKg1Vh+SlaT33EGG5prl6BMBb9ukhfAggf37KrOKpQ==
X-Received: by 2002:a05:6a21:4982:b0:14b:ee48:85b4 with SMTP id
 ax2-20020a056a21498200b0014bee4885b4mr8112064pzc.60.1694370301517; 
 Sun, 10 Sep 2023 11:25:01 -0700 (PDT)
Received: from localhost.localdomain ([49.204.31.103])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a655c85000000b0055b61cd99a1sm3720593pgt.81.2023.09.10.11.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 11:25:01 -0700 (PDT)
From: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Cc: dsx724 <da@lessconfused.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Subject: [PATCH v3 2/4] spl: fit: support for booting a LZMA-compressed U-boot
 binary
Date: Sun, 10 Sep 2023 23:54:46 +0530
Message-Id: <20230910182448.285542-3-abbaraju.manojsai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230910182448.285542-1-abbaraju.manojsai@amarulasolutions.com>
References: <20230725035101.281325-1-abbaraju.manojsai@amarulasolutions.com>
 <20230910182448.285542-1-abbaraju.manojsai@amarulasolutions.com>
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

If LZMA Compression support is enabled, LZMA compressed U-Boot
binary will be placed at a specified RAM location which is
defined at CONFIG_SYS_LOAD_ADDR and will be assigned  as the
source address.

image_decomp() function, will decompress the LZMA compressed
U-Boot binary which is placed at source address(CONFIG_SYS_LOAD_ADDR)
to the default CONFIG_SYS_TEXT_BASE location.

spl_load_fit_image function will load the decompressed U-Boot
binary, which is placed at the CONFIG_SYS_TEXT_BASE location.

Signed-off-by: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Signed-off-by: Suniel Mahesh <sunil@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
Changes in v3:
 - added IS_ENABLED(CONFIG_SPL_LZMA) to spl_decompression_enabled() function.
 - Removed extra parentheses.

Changes in v2:
 - New patch for v2

 common/spl/spl_fit.c | 13 ++++++++++++-
 include/spl.h        |  2 +-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index eb97259f57..75895ef15c 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -281,7 +281,8 @@ static int spl_load_fit_image(struct spl_load_info *info, ulong sector,
 			return 0;
 		}
 
-		if (spl_decompression_enabled() && image_comp == IH_COMP_GZIP)
+		if (spl_decompression_enabled() &&
+		    (image_comp == IH_COMP_GZIP || image_comp == IH_COMP_LZMA))
 			src_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR, ARCH_DMA_MINALIGN), len);
 		else
 			src_ptr = map_sysmem(ALIGN(load_addr, ARCH_DMA_MINALIGN), len);
@@ -329,6 +330,16 @@ static int spl_load_fit_image(struct spl_load_info *info, ulong sector,
 			return -EIO;
 		}
 		length = size;
+	} else if (IS_ENABLED(CONFIG_SPL_LZMA) && image_comp == IH_COMP_LZMA) {
+		size = CONFIG_SYS_BOOTM_LEN;
+		ulong loadEnd;
+
+		if (image_decomp(IH_COMP_LZMA, CONFIG_SYS_LOAD_ADDR, 0, 0,
+				 load_ptr, src, length, size, &loadEnd)) {
+			puts("Uncompressing error\n");
+			return -EIO;
+		}
+		length = loadEnd - CONFIG_SYS_LOAD_ADDR;
 	} else {
 		memcpy(load_ptr, src, length);
 	}
diff --git a/include/spl.h b/include/spl.h
index 3a7e448cc7..9de93a34cd 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -905,6 +905,6 @@ void spl_save_restore_data(void);
  */
 static inline bool spl_decompression_enabled(void)
 {
-	return IS_ENABLED(CONFIG_SPL_GZIP);
+	return IS_ENABLED(CONFIG_SPL_GZIP) || IS_ENABLED(CONFIG_SPL_LZMA);
 }
 #endif
-- 
2.25.1

