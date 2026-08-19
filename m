Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCD2C5DF81
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 13:42:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54BD940722;
	Wed, 19 Aug 2026 13:42:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q0TALtlg8D1J; Wed, 19 Aug 2026 13:42:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787146932;
	bh=4g/D0gC2ROGCu3J/nnvbQ59vnyNBYleFVVXc1hGXH1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ULXw2iTUClWxsjUgd6yGmBMyNrLJMXq9kQp+cHmIPQ/TohX3UqMCFc/wQ3S5tragO
	 pzIzNAUPhF9BUm2jlnD0cdBZW+XlQQ0HyBvDJTSsNvvFWMT7L/qJHvlb0kZDIZD83q
	 St21LrL5RAPIp/Zkx91iKTAJEJ4JI7Cb6zByi96BohkO6gq13OYq2eAwwMKO3/N+eQ
	 SKB+b60ZMspcpNLttvLkRP6AdjTWJIfxmDf3WHb3iCIREApM+ZLTPYkYCfVzZKV0Nk
	 iO4gVblcJeNMppl87JK1nXajdv2rdZPntuCkYOIPuFueVyrm66T1J1N+uDymyZmjoc
	 A0zwSMYKWmzdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1A7C40799;
	Wed, 19 Aug 2026 13:42:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 57F33230
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 13:39:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3DF8440561
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 13:39:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y2aFtcwSy4Ff for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 13:39:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=rRmRn3JE
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 62F4E405CD
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 13:39:09 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47de008b020so590567f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 06:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787146747; x=1787751547;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4g/D0gC2ROGCu3J/nnvbQ59vnyNBYleFVVXc1hGXH1c=;
 b=rRmRn3JE6TylzS80deqarDbaKZbIB5ohB+EOxQhfjg+lsshljs207jjpvwptRbUpgh
 9mS2An1a1W9WQm7N2sae9YJKjsfDCJoKPiMy4CTuNLTHRFJk6/fmGwffrRg2Ic3jQATC
 Ot1uOD8z2ywxQt2HykgrLiHhmT9OtVd7IeIJvlY6qLBXrUgdYAMklnIoa7uhbLch0Nh7
 yZs3etYoimbeh6lsuC3zv/isaPUYer+Sk7QDr6ClGftKByqtPPktdwaj8Ol4aNhjBPlR
 F7D8B1H7vcCPlvOwVOwxIkcUFuiGtJxaozyLJOJbe7bP/vqpydSkhEXWatwl2hCaSI3b
 RfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787146747; x=1787751547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4g/D0gC2ROGCu3J/nnvbQ59vnyNBYleFVVXc1hGXH1c=;
 b=m5NoOu9TmNwS3oaa9mZ38499OLWs2UeMggYMOoDQDumaiVEn+HitclAadIRac/bKMd
 V216vuVbNPlmRh2P16jBKO3gy0Haj5Rq10BOZaNTYyiXqJK6eiTSvy2xxLc977cNBQP+
 iX26SmCTuJRmBCDneWb4IjfaTTpPUXmUPbJ3mjsFyRA0T5hzAygwpxYa70ID3M+ugWcj
 qaygMspiw54aLFV39DNujiTultIrzs76TJlYJu0VFkiqALdv69Cgs70Ngg6sncYLb2FL
 ApCeL1Txa5VMLjLsi/BfvE4PoSdzx52fM/qRYB1e/3GJbV/5cn49GRrugT02ZjvjJlj4
 4EIA==
X-Gm-Message-State: AFuF++mtnRsjB+mBA0uqp6/C1rDlJSjevoAK+jmiUFRj7+8orDe94+ln
 hc+iWMfnJyhS+KsjrndTyB1g2qLg6qm8Xye3nyUNyujI5WaTV2EnWkuY
X-Gm-Gg: AR+sD10VepLDWeaKWZVL06d+ok7aS1Z7LSDV7F2IyUT9OdjlBIzQB5QAH6PYZEathGg
 jQePII8KFSkpjQ49gnXLXmR0HCRJCFIQVXE+J3rGQFZcaqT1cGpmGWw16AkAp4PHORxNxQjO3Zl
 g9QgH7VIIy1tUaEZvrZnrc0BJIaX3JSveRtMGlBgQezGTqOKUgta8AURV8CInbDTfIZiGTA+65h
 XNP+Da5Ztv1cwGLWaxntpmBer0Mv/LJhIPLFnk5JnnAafaVOFDfcx6MV/nbP9T0vPpnK22QzCCX
 F8Q4PNhYHBORSc0i2jVZa7MCg2AOVQujTa0r6JPb6WSIdFCtSPRgzaXyGP7hIBWVXmTcuKJ9stR
 FqVzKahtfEBeoUlPgd7deKlaRKdncwPSZ65xV5wyfqDG+7GDm6Zs+pji3OENWnwhdQrqLHPVuxB
 FTzpgoASNlubyFSMxG7mKe6hY0uWuRF7LZKovYviLZUG+9GYDuTfUjD+rxsm6AQJjNXCOuxTT2E
 dK/VBpC9HnznS66VWpKeONQNaUl7SEVj43W9+XV3bcn8HheXA==
X-Received: by 2002:a05:6000:220c:b0:481:50ae:df9a with SMTP id
 ffacd0b85a97d-482b106a680mr8177524f8f.9.1787146746905; 
 Wed, 19 Aug 2026 06:39:06 -0700 (PDT)
Received: from eichest-laptop
 (90.251.200.213.static.wline.lns.sme.cust.swisscom.ch. [213.200.251.90])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441753sm6463070f8f.5.2026.08.19.06.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 06:39:06 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, trini@konsulko.com, franz.schnyder@toradex.com,
 emanuele.ghidoli@toradex.com, stefan.eichenberger@toradex.com,
 ernest.vanhoecke@toradex.com, alice.guo@nxp.com, peng.fan@nxp.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 2/2] imx: verdin-imx95: remove unused WDOG_BASE_ADDR
Date: Wed, 19 Aug 2026 15:38:37 +0200
Message-ID: <20260819133900.167046-3-eichest@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819133900.167046-1-eichest@gmail.com>
References: <20260819133900.167046-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 13:42:00 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

The ULP watchdog driver obtains its base address from the devicetree
since commit 3cacd1b1809d ("watchdog: ulp_wdog: Use driver model for
reset_cpu()"), so WDOG_BASE_ADDR has no user left. Commit 4f8d6c8f417c
("imx: Remove hardcoded watchdog base address macros") dropped the macro
from the other i.MX9 boards, including toradex-smarc-imx95, but missed
verdin-imx95.

The definition is in fact dangling: WDG3_BASE_ADDR was removed from
arch-imx9/imx-regs.h by that same commit, so anything expanding
WDOG_BASE_ADDR would now fail to build.

Remove the leftover definition.

Fixes: 4f8d6c8f417c ("imx: Remove hardcoded watchdog base address macros")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 include/configs/verdin-imx95.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/configs/verdin-imx95.h b/include/configs/verdin-imx95.h
index 30eb2e01460..b6df4d48695 100644
--- a/include/configs/verdin-imx95.h
+++ b/include/configs/verdin-imx95.h
@@ -22,6 +22,4 @@
 #define PHYS_SDRAM_SIZE		(SZ_2G - PHYS_SDRAM_FW_RSVD)
 #define PHYS_SDRAM_2_SIZE	SZ_30G
 
-#define WDOG_BASE_ADDR		WDG3_BASE_ADDR
-
 #endif
-- 
2.55.0

