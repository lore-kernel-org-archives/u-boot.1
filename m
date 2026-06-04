Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2F3CD6E6D
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 16:04:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 753BE8495E;
	Thu,  4 Jun 2026 18:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iPj62mbF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA8AB84948; Thu,  4 Jun 2026 18:04:16 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEE0B84879
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 18:04:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=shofiqtest@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-3967726bc47so8579001fa.1
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 09:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780589054; x=1781193854; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bS8zWtoDL5dnhTuKcBNA9HWAw1ABWgJXSd56RFnyukE=;
 b=iPj62mbFcVAD++K+GkonxVDSjdqZMyqxI4bRfZ/+3VJERXENu3a7llUK+KC6y3UTh/
 C/G0daHQDQw9P4HM08CUTsXIiargnls82D1COfF3Sim4i+D5NW4wAjRHOZkTnWGqZJct
 r4a/r2spM+uOZj+XfQpM6Aec4qU5OB7en/pHIRPxFJBwOK6Cw+hMxINgb7AbwoS00DgR
 fUrZgsIermvXvmCBt/OpOwUIrBFLisNryhiiLe7FEJ/ePD4unvntK17Zl4l8fJLCDwUO
 wf3CD1OCartmIcd7AMdt2XQkbWUr7dPDeP7MSNqoH2obAROwIJI8Ozj324/yuvEEseUf
 +qYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780589054; x=1781193854;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bS8zWtoDL5dnhTuKcBNA9HWAw1ABWgJXSd56RFnyukE=;
 b=bdUYjqBD2FN1DHnBKox68OknNpoli3z+dACii8Lv+DdKNYiYC9CP9SGIPj3Gv6NnLu
 IF2kSMvIslSMkVlyw4LWEpSEq2FUOQuE3dkX6JtiVD5FpoDxvw0c8C8wlaL377hGyX6h
 1Ph/jX5JBMqqyLvUA4MRgJv2HS81CmZrgnHFe2yB70rDczP/1V2HKLtlOjQqxrXCKJJW
 YToPt810k0YGmjTCjD8BgSX1EuWOAzkILruppD7tmlduidHzJU0uEuk7TCTM/FbpVHPF
 JtOIDoKuQLEsE44iYNfUKvfcwfbUR1/PZkPQP86pa1ixVBpJMZpYbeK9vRf1/UaPRCsc
 t90g==
X-Gm-Message-State: AOJu0YzroMB1fxbBz0HL29skGuHQYooVWT57fL5LNM3SR8oh8/gZVSYV
 J6oiBtxLPhmoEWOSJRFXT7jnRUdDJ4GaI3owXre5NyxL/42bwktsmo8h
X-Gm-Gg: Acq92OH9rMce75/at0r5y9iGRQBB6ztdDVetHViUgZgmdpQO43XwPgD6400A3Vflz0+
 rmQFaZ5zQem6lZEq+ri2k90JexTVhgQs7kPXRrcugwxShIVtbJMR9UEOiQvYYn6MEGwOs+RCUwv
 O50OR/S7N0a0EJdyqQ0kuOy/5QhBklLkyppnPLfVmwGMSY3lSd3W0CPvTOne8Ysp86GrMIA2s6h
 7TmhhFTqtLQeUrmWiDSbtUWk+UHGmVR4t6aCVBhGRAuDTFgenuNdl/4EbuVOQdjTifp7hEhiFAj
 eUPOrIEaTx4bdDmB7/M1E5BsB4gYodyQbnkm7y0HuT4wZWJZgvvaLuHZuh3mUmQsxLGc+7rn88L
 bo0wJ7euHeiJfzqpFjJUnqem0+DQYHSoohKQWKPtUA2Zu67So+at3/X0FG7efkmDooHNZWUMUS8
 EFf1V+NhXayiBb9E7J80eh/Bura+P4C97U1moyLVMQ/wXDGNTqSU1gNxuHMHpbiT75C1y+qWetk
 KrWdw==
X-Received: by 2002:a2e:bd12:0:b0:396:881d:ef32 with SMTP id
 38308e7fff4ca-396af16aad4mr27968021fa.10.1780589053872; 
 Thu, 04 Jun 2026 09:04:13 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-396ac2be369sm17135821fa.26.2026.06.04.09.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 09:04:13 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: brian.ruley@gehealthcare.com
Cc: u-boot@lists.denx.de, festevam@gmail.com,
 Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH 1/2] imx6: clock: fix clk0/clk1 swap in
 select_ldb_di_clock_source()
Date: Thu,  4 Jun 2026 19:04:09 +0300
Message-ID: <20260604160410.7756-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
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

clk0 was being written to LDB_DI1_CLK_SEL and clk1 to LDB_DI0_CLK_SEL.
The arguments were silently effective before because all callers passed
the same value for both, but the mapping was reversed.

Fixes: bd3e19dbd90 ("imx6: clock: allow different clock sources for ldb")
Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 arch/arm/mach-imx/mx6/clock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mx6/clock.c b/arch/arm/mach-imx/mx6/clock.c
index 828a101ba05..646d1fff6d7 100644
--- a/arch/arm/mach-imx/mx6/clock.c
+++ b/arch/arm/mach-imx/mx6/clock.c
@@ -1525,8 +1525,8 @@ void select_ldb_di_clock_source(enum ldb_di_clock clk0, enum ldb_di_clock clk1)
 	reg = readl(&mxc_ccm->cs2cdr);
 	reg &= ~(MXC_CCM_CS2CDR_LDB_DI1_CLK_SEL_MASK
 	      | MXC_CCM_CS2CDR_LDB_DI0_CLK_SEL_MASK);
-	reg |= ((clk0 << MXC_CCM_CS2CDR_LDB_DI1_CLK_SEL_OFFSET)
-	      | (clk1 << MXC_CCM_CS2CDR_LDB_DI0_CLK_SEL_OFFSET));
+	reg |= ((clk1 << MXC_CCM_CS2CDR_LDB_DI1_CLK_SEL_OFFSET)
+	      | (clk0 << MXC_CCM_CS2CDR_LDB_DI0_CLK_SEL_OFFSET));
 	writel(reg, &mxc_ccm->cs2cdr);
 
 	/* Unbypass pll3_sw_clk */
-- 
2.51.1

