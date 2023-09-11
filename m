Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FDAEE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 15:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 290DB86E7D;
	Mon, 11 Sep 2023 17:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hylCKtyP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA5A486E53; Mon, 11 Sep 2023 17:34:45 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5B1D86E44
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 17:34:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jamipkettunen@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2bf66a32f25so54774501fa.2
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 08:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694446482; x=1695051282; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WMq4cmWQMnVfAz5vwydlKgr66RhqG1H+WlEOFt9Mek4=;
 b=hylCKtyPeMAG6Wwwzf4r4SnETO3PZoODareGP5hBpOZph2yqdYjD++elOMqACYey/L
 ZS854frsbVbhKKRyaKswG4NzeMiRcXg6GlihHyWCDdesfqDA4EjvWyaJKL9TSBKdIPF7
 K+GLNNeoKx6SX4/hsTNvC78gccedAHS3abh54EnB9EIcokjTBWSt2JGqNBjKfBxSWQFg
 zha+b8aq/M1Eb6C6Tt7W17ru178ppXrKr1tVPilt4u3keTo/s5dWMoOSmQZhS5zse2LD
 VF253XDdzQSJiZM642XlVFgGMu6wv4P7NslSO2lWlG4Wb0mwxQ8ILlRdw/4JitQcoHzo
 idWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694446482; x=1695051282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WMq4cmWQMnVfAz5vwydlKgr66RhqG1H+WlEOFt9Mek4=;
 b=rXcg7qYA5CP2MbIpK8auayEbFGxJeh34xrGtiRh6mrQSo96RBhM3oeWWfMnIuTA5ve
 otbtN8RANx7NJOBrxx/XGA/RCUrtgnuCNhjvICkJdbMkFudSkmucM8ujFvutsFnl0QTi
 +1lsvZPhY6qeFI9la22wTB0HESEBQc7919Z/9QNyb/3pPqIUJqwIVjkOX/RKw0QH4UxJ
 p++C9PmPzxyj4sgDAdUHIu7frEIlS2hzz8I+HUQ8DC/tYp5AqOmRhQZWfs1L3luafeAN
 LahI9We9i/G/mDzqLjt4jETlgldvxakDUy8Rlh0Kmy5zoss1IIUPDXUbepWDn30p+a6/
 jk2Q==
X-Gm-Message-State: AOJu0YwaAlZrYWG5XIxSosvZg4sCRoYUPP9SIKQ5JOe1IQTyE2heBP6r
 keXtE40vDfWErbe7nGT+hhwgEzu89YPiUg==
X-Google-Smtp-Source: AGHT+IFGeR40s3PkYOpoaXjUjHmBeGpTI4aAM5Mw8nqUa2Kw3rM13L7Wud2xULHUaqEsU8m1mqOQ4Q==
X-Received: by 2002:a2e:9254:0:b0:2b6:c886:681 with SMTP id
 v20-20020a2e9254000000b002b6c8860681mr8095908ljg.6.1694446481788; 
 Mon, 11 Sep 2023 08:34:41 -0700 (PDT)
Received: from localhost.localdomain (62-78-201-188.bb.dnainternet.fi.
 [62.78.201.188]) by smtp.gmail.com with ESMTPSA id
 x20-20020a05651c105400b002bcebc7713bsm1572280ljm.120.2023.09.11.08.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 08:34:41 -0700 (PDT)
From: Jami Kettunen <jamipkettunen@gmail.com>
To: u-boot@lists.denx.de
Cc: Mason Huo <mason.huo@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Shengyu Qu <wiagn233@outlook.com>, Jami Kettunen <jamipkettunen@gmail.com>,
 Jami Kettunen <jami.kettunen@protonmail.com>
Subject: [PATCH RFC 1/2] board: visionfive2: Select fdtfile based on revision
Date: Mon, 11 Sep 2023 18:32:35 +0300
Message-ID: <20230911153253.20701-2-jamipkettunen@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911153253.20701-1-jamipkettunen@gmail.com>
References: <20230911153253.20701-1-jamipkettunen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 11 Sep 2023 17:46:53 +0200
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

From: Jami Kettunen <jami.kettunen@protonmail.com>

Linux mainline kernel device tree files[1] are named:
- jh7110-starfive-visionfive-2-v1.2a
- jh7110-starfive-visionfive-2-v1.3b

which should be selected accordingly by U-Boot to have a proper extlinux
experience with fdtdir set by the distribution.

[1] https://github.com/torvalds/linux/tree/master/arch/riscv/boot/dts/starfive

Signed-off-by: Jami Kettunen <jami.kettunen@protonmail.com>
---
 .../visionfive2/starfive_visionfive2.c        | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index d609262b67..9244d4654b 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -10,6 +10,8 @@
 #include <cpu_func.h>
 #include <dm.h>
 #include <linux/bitops.h>
+#include <asm/arch-jh7110/eeprom.h>
+#include <env.h>
 
 #define JH7110_L2_PREFETCHER_BASE_ADDR		0x2030000
 #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
@@ -41,6 +43,29 @@ int board_init(void)
 	return 0;
 }
 
+int misc_init_r(void)
+{
+	u8 rev;
+	const char *linux_dtb_file;
+
+	rev = get_pcb_revision_from_eeprom();
+	switch (rev) {
+	case 'a':
+	case 'A':
+		linux_dtb_file = "starfive/jh7110-starfive-visionfive-2-v1.2a.dtb";
+		break;
+
+	case 'b':
+	case 'B':
+	default:
+		linux_dtb_file = "starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
+		break;
+	};
+
+	env_set("fdtfile", linux_dtb_file);
+	return 0;
+}
+
 void *board_fdt_blob_setup(int *err)
 {
 	*err = 0;
-- 
2.42.0

