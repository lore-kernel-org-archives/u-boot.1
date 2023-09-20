Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BECCE79D7
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 14:27:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03B0B86BC2;
	Wed, 20 Sep 2023 16:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VPdKYDAu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4256886BDC; Wed, 20 Sep 2023 09:41:38 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6219086B69
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 09:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pbiel7@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2b9c907bc68so108199461fa.2
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 00:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695195695; x=1695800495; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ihaopa70YTvgKUSarlQF9CxeH1fhCQVYTiGtqGpD+3g=;
 b=VPdKYDAu+E4749U8nGtTuW4m/bZ2YUEPnwG9Z/cQaxR6vMAUTRQTlLLGlHDTg5Bhte
 qJFMEgDTAnjZ6MsPcf+9n4VO5gXb7ge/KFYZxA7ZEK1ih/IunORPUCPzTuJQSl6r4sW9
 MC9re5WeORwop0RdYM0lc3/aIvKCPRH1Xn+hDmQZ8M4mWe69/ljkGVwk557qANVZJJLk
 O8zKjZAlDIJMHMqJ13qxb0/CeCJx1SXUJ3Ows6+v0YaAEW4d5grMlcjgZ6y4pMfIUNTD
 uSxJm0kid30THLhyO0j5Uovdl39XmhyHdIKamq/jHtGRyC0kc9XtwlXeRp5dsNePyxgi
 kEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695195695; x=1695800495;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ihaopa70YTvgKUSarlQF9CxeH1fhCQVYTiGtqGpD+3g=;
 b=b+kH8DPtTnfJFkll0LTCX+B04EMKGbu5euj+4uTOWcKdotuaSIQFJQKC/pHcBjsxjb
 9wEnrdNAYkLlkXqim+yMu3qPBTqzugk7DFTEFPC02yUcyalgGvX+XA8bseGdciERR5o7
 DYVPNXUS1T8AsRx8ek9TFRJJo9KUQcpOgkXFdjkkH/uolZfmlAgSQirkBjXfjlRFyfvL
 0dN3sVUDvC69dpW6R1AoQhdBXBzwLboSPYchZiNfU+a+G5blbFrUI4l3axmWMN5nC/0e
 3CXkxxsdHTYCRtlo6pAagm5LsBDKU/i7HCiGLZnJCZimAavnpu28MhJPkovJmIYbZklk
 3cPw==
X-Gm-Message-State: AOJu0YxmiPcH68pfWXWm2Wu27yaHqK6Eu57ghbbQdzTyRiczB1RFs4S7
 KHWbZ9GifzdQCCE9Pd3gM+ixH+GK5DhN8vW6
X-Google-Smtp-Source: AGHT+IGf5RJFOtdFnQCKpGs2ujTUsDAQxogqb7fUbiKuKyXGb6Blp00m79WF48qvdEDYCEhwStvSWw==
X-Received: by 2002:a2e:920f:0:b0:2bc:cff6:f506 with SMTP id
 k15-20020a2e920f000000b002bccff6f506mr1422600ljg.0.1695195694948; 
 Wed, 20 Sep 2023 00:41:34 -0700 (PDT)
Received: from patryk-Latitude-5491.corp.trumpf.com
 (89-70-29-32.dynamic.chello.pl. [89.70.29.32])
 by smtp.gmail.com with ESMTPSA id
 y22-20020a2ebb96000000b002bcbb464a28sm139282lje.59.2023.09.20.00.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 00:41:34 -0700 (PDT)
From: Patryk Biel <pbiel7@gmail.com>
To: u-boot@lists.denx.de
Cc: Patryk Biel <pbiel7@gmail.com>,
 Kristian Amlie <kristian.amlie@northern.tech>
Subject: [PATCH] ARM: vexpress_ca9x4: Add missing flash width config option
Date: Wed, 20 Sep 2023 09:41:20 +0200
Message-Id: <20230920074120.394487-1-pbiel7@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 Sep 2023 16:27:33 +0200
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

Allow for a proper configuration of CFI flash banks avaialble on the vexpress_ca9x4
board. Without this option, the CFI flash incorrectly detects that the board has two
banks of 32MB flash devices, while in reality, the board provides
two flash banks, each with 64MB size. As a result, it becomes impossible to e.g. to
save u-boot env in flash. According to device tree for this board and
its implementation in QEMU, the CFI width should be set to 32 bits.

After applying this fix, CFI flash will correctly detect both flash
banks each with a size of 64MB. As as result the functionality of e.g. saving u-boot
env will work correctly.

Tested on QEMU 6.2.0.

Cc: Kristian Amlie <kristian.amlie@northern.tech>
Signed-off-by: Patryk Biel <pbiel7@gmail.com>
---
 configs/vexpress_ca9x4_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/vexpress_ca9x4_defconfig b/configs/vexpress_ca9x4_defconfig
index 5cacecc7cb..ac9c0e1d71 100644
--- a/configs/vexpress_ca9x4_defconfig
+++ b/configs/vexpress_ca9x4_defconfig
@@ -55,3 +55,4 @@ CONFIG_SMC911X_32_BIT=y
 CONFIG_BAUDRATE=38400
 CONFIG_CONS_INDEX=0
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
+CONFIG_SYS_FLASH_CFI_WIDTH_32BIT=y
-- 
2.34.1

