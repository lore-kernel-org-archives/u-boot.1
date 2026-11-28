Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0D5606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZInA8dAF;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=Ni4Wuh6e
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA97281101;
	Sat, 28 Nov 2026 13:12:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yI_l8YN-mL6J; Sat, 28 Nov 2026 13:12:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2CEB780F5F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871545;
	b=Dq1eWbA7ZmJajU9xSVz9cgRdji7sFt84wI9LbyVl5USfwRMvA5SxND3/xtx9yP17Tko5
	 aEkBO3EKdE5a1TfLiJUWFjT/YBbQkwnn8xZJ0qkpvqRvYca2nSY16zj3cR+AQLqtEzuul
	 /9xQ+oE4dfMbPGXp3JvaW3Ax8q9oYSkKOgx4o2KuBYRKv6lerKOQmLbHfIxzWts01Im63
	 N739t7dBGrdlqk6a7cffwkv26m+ovdbgfDRwOaG/eRxIp+hzsPWFfo5d4RAS4JY+j75tH
	 itO1V9a21/CVfSvOvMg42nJ8zCMHlT9drwccAWNezYlOLkeHV4X1JrY9ax9Yx3t2Hqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871545;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HUylzTuSkkO7OZGHyVFcXnMtuszTSi5m05t9X0BjhMQ=;
	b=IZjfiNXd0nKhSQd+ZyfmwEcQqm+9Kps+P8EvRISgjlYolfacqmYBItMbfildrTRUqQee
	 wtOh7XdkPjv4bu2Ue6U/vkezltsZXQU464CpGE/yJfr2iXan0ObUlLwSTei4ETKsMc3xL
	 k7WVYuHwF2llwezd/WigR4F/pfhrWki72vOcm2A66RqEjC88WNJ6xjDnakuIXv+DMtxCh
	 4em6tXwhucC9cHc79z78A3zDu/CQB4xGEZ0MqI/yHXb2w8Du+LlVRW2QZeepkXZfohR5i
	 bp+tbLPX1c2cnw4lBCiX5qsBNT82GHhDXOTGyzJOJ7M0Ni88YhwJ4BecPfxy9UBQu3g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871545;
	bh=HUylzTuSkkO7OZGHyVFcXnMtuszTSi5m05t9X0BjhMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZInA8dAFATl7hXkbFm3Sbzjn9/7aeu1cj1pTA3HJrb0jTBmKHoPJ6irA60d6Dnxjt
	 U7wuz6//o6uRnrJwwZcWMxT6jVvzcfblk7QKMuTT63o6RwCicFXrcYfrwvj1yKdzsr
	 q1+8zNWB15y9igwOQ/S7Zk9Cbiea77rcsCnLPS9DVmgfxleaJjYo9fAZjmTyYVgnrW
	 SK6QFOiHdrdh3GoTbaWKD50ocByI9NuLqLitD8u9xeVAa2Ok8K4VHHJSEldnyWOVWe
	 6F22wD/M1wqkn4ZZ+P2bBet+rBfGZdX9cXsmkHLuhllPy08A5it/SvnfC7LxokZ4ad
	 CRFIcsKblOYDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CEB780F5F;
	Sat, 28 Nov 2026 13:12:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 850D826D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 82C74400E0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ERh7T-IUgkfa for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:12:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 910924005D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=Ni4Wuh6e
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 910924005D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:05 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso47465905e9.0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871523; x=1796476323;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HUylzTuSkkO7OZGHyVFcXnMtuszTSi5m05t9X0BjhMQ=;
 b=Ni4Wuh6en0JiOA4ZxxcPO7xa/9THFvGRpVu8o02l8B+z9P5Mk5ht8Oh/Z0k3c42ZT3
 ls+C+Dbk9hA5r0LPKOQ8vK90dIBniHqzsL5jjXXLbDibyuAGNujByeqqGP6ZkPIkP4rF
 uXgXGbvbtfD/HcXQjgClHNRH+L4XHoAycbyVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871523; x=1796476323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HUylzTuSkkO7OZGHyVFcXnMtuszTSi5m05t9X0BjhMQ=;
 b=of54r7QsixfJSQ6yEZ783sJvNg9RFF+Xx/8jzjp2K5KAJVkfpLTyFhmPvxWGMPhLVB
 /kpIETH7NgK6rBZK+H0SwiHg94xvNYIaj0OH9oBaLv3e6O8MO2dVotHKuqUDW+HHDHYd
 RcnceoSxY0dDPll+v2+0jzkyHOrFSrgy1P9O+hvQJqR3NCnugvFrz+QRk6lqtVeucNng
 XZlC6VzZz4dS9tdo6oFTR5cJanI/WuRHm+b9vgOf1eEPuGzQUYSIDAR9oawODD06101r
 kKmuCSU6blY1V6ZiXwGiwbou5QKJlsUyPN5gOyWzYOdSfM2s9aFRzlx8sHHYGSlOpJjA
 laEg==
X-Forwarded-Encrypted: i=1;
 AL+hErFuvJIGpKtRzgdQF8JVAAd8HYpjGrb8bqMOFGyBeQFba4sHxI0TN7Ls8JLN2BzWXx8OpQw1bds=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9kF709M/OKyBTVwwH7W9VU1lfmT3fvYy+xW/ICDNWdFLkFc/yu
 zP4OqmYg+h7akbGnA9LP5OjJ4Pmu9IZKWLJ5lCZbPr4XWLVNgmn/LfxyxGRg73WLg0A=
X-Gm-Gg: AZFdTZcZpj5mtUhTdEpFTiPyNw6/T0XtDsrte6rwnZA8+thwihrGNChvs110l+Fqi0Z
 n3pGal0jSFCBarzFeSNUCSVWX8Gpg1nWLA/JCVOysZoT4RCmGhog+EUm/ZCiy69c2zCNzUfe0j7
 14ibQIoKEPvmN9Hzsu7p/qAOPIWxVOUzYNTJogFok4oMc6n3e9B3Rjg5XmNPtIq7AoLxWzs+9cW
 xpuwJdDzqELPpS1goBvr2CEqVqLZFYw1KNfBlI86GWRF81xRVWgdwQ9mSoZMIQtDI96AqS9Sady
 dYLBQ09K8dhWBhDUM5BHag7p/dV98dufqG6eZy9yr3eEEIBzeDjpjzYyO6wXjHK2yLJeTfhsfEN
 BfgwODQuM8bmxWYHePioOrsROY1rZUf5+dVgw0WO8T5/t3ShGAVQttIV0HcMv3/u23b+o57mgRS
 MwTRKvVV+4dBpVeEjdTQnPkUVvv/m7S65j5sR7EblutflLlHHcVf3X8ck0fUyAmC5SMfPLfH58M
 6uZ5z6bUfLw21cmGPx1lSq7yac7KNIVYNmPOR5/DGBP/j0Ez/dCemyDONq24Lyyvof1SWkcRZDh
 enTnG0FCENPjsCvQ6kLJP3l8CFH2j925Omf1hJAmG2aRGTJNGJiPEnrdLvgiuu9T4rTL76vjJDy
 +tw6ELXFuJpSmzX/eFzxNWOG6pN8Xb6jskX4fvImVjxKahVLiottdnwZypx4zDp8mVaoLGQ/zGE
 Er1znx1KXDUFUN79Xx/k0m4aWgHv0=
X-Received: by 2002:a05:600c:a087:b0:4bb:60bd:53b2 with SMTP id
 5b1f17b1804b1-4bb887fe7bdmr570498535e9.6.1795871523584; 
 Sat, 28 Nov 2026 05:12:03 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:12:03 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org (open list)
Subject: [PATCH v3 21/29] configs: stm32mp25: move FWU A/B boot environment to
 common settings
Date: Sat, 28 Nov 2026 14:10:38 +0100
Message-ID: <20261128131125.2141352-22-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
References: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The distro boot environment booting from the bootfs partition of the
bank selected by the TF-A only depends on the FWU multi-bank support, so
it is not specific to the STMicroelectronics boards.

Move it to the STM32MP25 common settings, so that other vendor boards
can use it too.

No functional change intended.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

Changes in v3:
- Add Reviewed-by tag

 include/configs/stm32mp25_common.h    | 20 ++++++++++++++++++++
 include/configs/stm32mp25_st_common.h | 15 ---------------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/configs/stm32mp25_common.h b/include/configs/stm32mp25_common.h
index a334b47b555b..7eb5c4ffc00f 100644
--- a/include/configs/stm32mp25_common.h
+++ b/include/configs/stm32mp25_common.h
@@ -86,6 +86,25 @@
 #define STM32MP_BOARD_EXTRA_ENV
 #endif
 
+/*
+ * With FWU multi-bank update, boot from the bootfs partition of the bank
+ * selected by the TF-A ("boot_partuuid" set from the FWU metadata),
+ * falling back to the bootable partitions if it is not available.
+ */
+#ifdef CONFIG_FWU_MULTI_BANK_UPDATE
+#define SCAN_DEV_FOR_BOOT_PARTS \
+	"setenv devplist; " \
+	"env exists boot_partuuid && " \
+		"part number ${devtype} ${devnum} ${boot_partuuid} devplist; " \
+	"env exists devplist || " \
+		"part list ${devtype} ${devnum} -bootable devplist; "
+
+#define STM32MP_FWU_ENV \
+	"altbootcmd=${bootcmd}\0"
+#else
+#define STM32MP_FWU_ENV
+#endif
+
 #define STM32MP_EXTRA \
 	"env_check=if env info -p -d -q; then env save; fi\0" \
 	"boot_net_usb_start=true\0"
@@ -119,6 +138,7 @@
 	STM32MP_BOOTCMD \
 	BOOTENV \
 	STM32MP_EXTRA \
+	STM32MP_FWU_ENV \
 	STM32MP_BOARD_EXTRA_ENV
 
 #endif
diff --git a/include/configs/stm32mp25_st_common.h b/include/configs/stm32mp25_st_common.h
index 0b0267ae99b0..cb679eb1be22 100644
--- a/include/configs/stm32mp25_st_common.h
+++ b/include/configs/stm32mp25_st_common.h
@@ -8,22 +8,7 @@
 #ifndef __CONFIG_STM32MP25_ST_COMMON_H__
 #define __CONFIG_STM32MP25_ST_COMMON_H__
 
-#ifdef CONFIG_FWU_MULTI_BANK_UPDATE
-#define SCAN_DEV_FOR_BOOT_PARTS \
-	"setenv devplist; " \
-	"env exists boot_partuuid && " \
-		"part number ${devtype} ${devnum} ${boot_partuuid} devplist; " \
-	"env exists devplist || " \
-		"part list ${devtype} ${devnum} -bootable devplist; "
-
-#define ST_STM32MP25_FWU_ENV \
-	"altbootcmd=${bootcmd}\0"
-#else
-#define ST_STM32MP25_FWU_ENV
-#endif
-
 #define STM32MP_BOARD_EXTRA_ENV \
-	ST_STM32MP25_FWU_ENV \
 	"usb_pgood_delay=2000\0" \
 	"console=ttySTM0\0"
 
-- 
2.43.0

