Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9C9C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 19:19:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0915810F2;
	Wed, 19 Mar 2025 20:19:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WltY329m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DEF481E6C; Wed, 19 Mar 2025 17:17:18 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C30481E18
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 17:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eichest@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac25313ea37so1352161666b.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 09:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742401035; x=1743005835; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0rso69+AlS22omh7WRbX7hTW6y4JJF+9Rs8wkGGCbgc=;
 b=WltY329mRpg6ZIF9Am6WGj1dIb7VFVF6gBQz4zekDB2xKBPgnD0n6L3E0ASCpoSN06
 Duj0NUas2cxm9ySJrtXrLoXfE0j2cBIHc4idQBiU9eXpLAgRRbaBpcGwT1nOvTENp+qK
 AFWOSD6m/xwxVpTQu3oFQbbS1NBJhdCA630svLn0eFT0IkRNrWDBvnOB5/u2oNN6Ayat
 qxYsMXvrN0iX8qziA+v1kfTSZGiFUHCQLN8WgcwWBVpukTfvcVLgteNxZtVHGoCr7wC5
 GUXfmfHZS0yFVlSN68p6dZgVE20uTdppJAyPv2n4uApVMnZzO/5qyGdSKrBkkgqf2EmA
 Mtmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742401035; x=1743005835;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0rso69+AlS22omh7WRbX7hTW6y4JJF+9Rs8wkGGCbgc=;
 b=M91PqUMdsP4y+iLZxDm8lBgUlsTwJ+FC8Y5Ftgc/HeOnr9u0oUtzRAyODvHO2uLqPm
 anNSom2F5fH7QhyThqxgy1xIxQApbje3gDwLZTePZ3BmiP0qKWG8vweqZhHGMefIdzSe
 qhu4V64ndlP3csc2hpSxDjkrsMH0HZbwRZXaIwGPS2qFV/mQVG/zHwNTn8vp4Epj3qI2
 MtPACRCwIBjvm2amILNki65+kiZ/n1vH21rjlnd4g4R0SQg5qcMPfPMxni4CjyYlea1S
 PKiq1T3riRdtzd/ss2lZWdo8rwGiGboR4Qp0sdRrrcF/dfohfd8xl0G2Czlz9WIlnuUv
 YiqQ==
X-Gm-Message-State: AOJu0YxdQxuWwSkN7P/lBEgRR/xU7NEG06jclsu3VRi+eUUxvEeiJm4V
 KNx74RW3SbfbHy4OQ8+SwecrAVJ4vnqyzxMHSAQ0aNhzdA5EIpw5I1wNKQ==
X-Gm-Gg: ASbGncuaTjxfNolm1aq/T5oCWnpgTr9bNeRrx7+j/TF0s3MIbglETYCBQ+rr10K7omr
 o9sXl4GRCf/0462nR/UgMFAmEr03KP6I4i4dpC1oasshq+zc6GnGbFIGiZlYa2Z63KwcTPkTu4K
 2FrZPIbSdVlGSMxGNSt5RjEWm5x0L/nDXeeGjVOk3f0gfYdc5Covg38VWijPmUjDPUWrPHLIdwc
 mHwDBJH81AFH/vdEwQZaStY00BM4YcjQ6+M52zDwGhvNXnqCrDr7eihJjPYBCL6PhKqBi1OQnoZ
 7P2WmYkSwMkdLO5EkCGVLAfhhQ/A5LJPcx61tvB7LjYx6c3t5t7CT8pFpp0QogfBVVd3iGJSdRV
 FN2MY8TNWyX0qynDRZas=
X-Google-Smtp-Source: AGHT+IG/sVhuGO1dNhl2Nsqur4FrEUt47wZ9rC6Ynpd610Kjt0FqEhGMvgIKacd2bWBRMuWxxkVjUQ==
X-Received: by 2002:a17:907:d7c7:b0:ac3:49f0:4d10 with SMTP id
 a640c23a62f3a-ac3b7fa0078mr436877866b.38.1742401034426; 
 Wed, 19 Mar 2025 09:17:14 -0700 (PDT)
Received: from eichest-laptop.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3147e6fc5sm1026877466b.41.2025.03.19.09.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 09:17:14 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de, Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v1] board: verdin-am62: remove spl_perform_fixups
Date: Wed, 19 Mar 2025 17:16:23 +0100
Message-ID: <20250319161704.1618876-1-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Mar 2025 20:19:29 +0100
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

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

spl_perform_fixups is redundant in the current implementation. SPLs call
dram_init during spl_enable_cache in arch/arm/mach-k3/common.c. In
U-Boot, dram_init and dram_init_banksize are automatically called in
init_sequence_f. Therefore, SPLs and U-Boot always determine the correct
RAM size. During Linux boot, fdt_fixup_memory_banks adjusts the RAM size
in the Linux device tree, ensuring correct RAM usage.

dram_init() calls get_ram_size() for the Verdin AM62, which determines
the correct RAM size through read/write operations. However, due to the
K3 bootflow placing ATF in RAM and requiring cache coherence, calling
get_ram_size() with caches enabled prevents ATF boot. Removing this call
restores ATF boot functionality.

This fixes a regression introduced in commit 4164289db882 ("board:
verdin-am62: fix missing memory fixup call") which prevents some of our
Verdin AM62 modules from booting.

Fixes: 4164289db882 ("board: verdin-am62: fix missing memory fixup call")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
We will analyze the other issues from
https://lore.kernel.org/all/20250314100734.23777-1-eichest@gmail.com/
separately, because it might hide another issue. However, we need this
fix so that all our Verdin AM62 modules boot again.
---
 board/toradex/verdin-am62/verdin-am62.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
index a1c471111a0..7b2eecbf659 100644
--- a/board/toradex/verdin-am62/verdin-am62.c
+++ b/board/toradex/verdin-am62/verdin-am62.c
@@ -112,13 +112,6 @@ int board_late_init(void)
 #define CORE_VOLTAGE			0x80000000
 #define MCU_CTRL_LFXOSC_32K_BYPASS_VAL	BIT(4)
 
-#if IS_ENABLED(CONFIG_XPL_BUILD)
-void spl_perform_fixups(struct spl_image_info *spl_image)
-{
-	fixup_memory_node(spl_image);
-}
-#endif
-
 #ifdef CONFIG_SPL_BOARD_INIT
 void spl_board_init(void)
 {
-- 
2.45.2

