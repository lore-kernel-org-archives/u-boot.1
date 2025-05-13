Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90017C3ABCC
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 16:37:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B848C82A0A;
	Tue, 13 May 2025 18:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cUKVn9+I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C504A82A4D; Tue, 13 May 2025 18:36:43 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCAB082A0A
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 18:36:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ad243b49ef1so609774866b.0
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 09:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747154200; x=1747759000;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qML0S4mWAxYxEV7SiXYurOd9OrqfouKhHOZYxY7Z65w=;
 b=cUKVn9+IMDNtHZqfE151HFtdG7deTgx6sZHFjUJ+WjfCJMnM4ZEHsEorev2P+PEtOv
 TnuXHWzRgXFfCTZFT8pKpRpqqiWqm2jjZURv3o41zk0bQwuHRbRFVFxmjEaxPjBE4Fjf
 7c8oevf9r7tQZhL6TZQK7/dT27mVeFVlEdt64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747154200; x=1747759000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qML0S4mWAxYxEV7SiXYurOd9OrqfouKhHOZYxY7Z65w=;
 b=W9M8SuBmTYD75Yxp/qxIeAvArDrgne7aojeCEeIZYkCsdrQT6z4wGf34TYpfuRm5Zn
 IvMbEpIRSZE9fj6v8HabhMGHU249RLGYBAioYplAlNcgCq1GLQKuzLfucS6ZetbKvqgE
 07k9fUiDecprpWz/OwwH+QNpCgbJdz2ipgTIgoUU6OSf2qBPzADg6Rw56eQbof/ieEhC
 sYQ5pArjBJ67jANVCKFnXz9fevlo31eOSTMECYZuj4I+X5qq4Z+s0yckuhXPz8yTo8X9
 X/BR88ZN0IEooNgQhtZ8YyH0wew16YiAWKWj2X2NOmZscrxfvDplQXXgLyvJS0ofkM5l
 LuIA==
X-Gm-Message-State: AOJu0Yw96gUf08gSykC6zKmAgDt0mP6o34I7tzW3lubq2X8c+POAiPuN
 OOY5f47Dt/bFseAb9zxYbNDlph5Qu16peCjLnmAqdjkxWFGfdSaHSngmt6o+oMjK9aOHHaKZbJK
 pBs8=
X-Gm-Gg: ASbGncucWzY8eHpEHkTngshF91UYWS/TGx/Yb7Y3kpheWaaVxmxuB7THzKBqdf2XFAE
 s8YteXPfVb2ciGr2UAW94XS+0acT1x6sHmXlZ82YQcJgS0xKNW21SL7TEcJ/9SGRjKg4RoBdRoH
 koBR3KAqpVHn8OrKmxE0xODAevkexGt2ZIm5s/b9jQM0+heGejeUgzN9UdYaHfG3yV9jqEcW6Pt
 89G44u732wDjHJnzedVmkNncCgG2ZO38Dt8udevS6rMClfoA2ZoY3vejyBi9mRpkc4SDOnArXY5
 UGdWH536vFW1TjxCGBeZQqRrXPVpMNBkeHqkcR44tjx10v5XgLPEBwhgQs7odL2NyiEgsCjMWyl
 cP44V7cq2hvCwTsG2eF7vNMKRVLZGKLyG+ca9ILbP/WPoBjyfVLfl
X-Google-Smtp-Source: AGHT+IG/jvE4Mm236u6mgiuGH82rTMWTHwufbv2mBTov0vpa519XOw5i1univU/dkCOfGU0cIRkGDQ==
X-Received: by 2002:a17:907:c296:b0:ad4:d135:cf68 with SMTP id
 a640c23a62f3a-ad4f7581ffdmr21347966b.59.1747154200056; 
 Tue, 13 May 2025 09:36:40 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([46.189.28.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad23eafca8bsm565334966b.87.2025.05.13.09.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 09:36:39 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Bode <michael.bode@bshg.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Holesch <simon.holesch@bshg.com>, Tom Rini <trini@konsulko.com>,
 Wolfgang Birkner <wolfgang.birkner@bshg.com>
Subject: [PATCH 4/4] board: bsh: imx6ulz_smm_m2: Add delay between DRAM read
 access
Date: Tue, 13 May 2025 18:36:18 +0200
Message-ID: <20250513163633.1803464-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250513163633.1803464-1-dario.binacchi@amarulasolutions.com>
References: <20250513163633.1803464-1-dario.binacchi@amarulasolutions.com>
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

From: Michael Bode <michael.bode@bshg.com>

A small delay between DRAM read access with wrong parameters and
reconfiguration is necessary.
Without a delay between DRAM read access and a following reconfiguration
this reconfiguration fails for certain DRAM chips (Nanya).

Signed-off-by: Michael Bode <michael.bode@bshg.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 board/bsh/imx6ulz_smm_m2/spl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/bsh/imx6ulz_smm_m2/spl.c b/board/bsh/imx6ulz_smm_m2/spl.c
index dba5982d0865..d1d38163ec19 100644
--- a/board/bsh/imx6ulz_smm_m2/spl.c
+++ b/board/bsh/imx6ulz_smm_m2/spl.c
@@ -13,6 +13,7 @@
 #include <asm/gpio.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/mach-imx/boot_mode.h>
+#include <linux/delay.h>
 #include <linux/libfdt.h>
 #include <spl.h>
 #include <asm/arch/mx6-ddr.h>
@@ -65,10 +66,12 @@ static void spl_dram_init(void)
 		/* Already configured, nothing to do */
 		break;
 	case SZ_256M:
+		udelay(1);
 		ddr_cfg_write(&bsh_dram_timing_256mb);
 		break;
 	case SZ_128M:
 	default:
+		udelay(1);
 		ddr_cfg_write(&bsh_dram_timing_128mb);
 		break;
 	}
-- 
2.43.0

base-commit: cf37480bc8335494cf88b7180dc3f1eb8cf63a9d
branch: bsh-202505-RAM
