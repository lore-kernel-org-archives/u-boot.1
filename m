Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D749FC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DB0384B72;
	Tue, 30 Jun 2026 14:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KjIAC6IK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CD9E84A4F; Tue, 30 Jun 2026 14:40:00 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD0BC8490A
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 14:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=shofiqtest@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-39b22d0e488so5137441fa.3
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 05:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782823197; x=1783427997; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q5eH7z9hFnBQ5GMXEsNUwAQ7XcGtjIQNqeFWuDLoHas=;
 b=KjIAC6IK2PRWhlHGUALIgEprarbZLlRpWLSee7jr2shbWcl0aCE/QCRBCOaWHDHxAn
 lTV8H/fB7ka0xdVPbboOYM3bqOTPAdyptTrAC1D5HC+0Mkvs2sz2+qZMcQ4YkA4xVg5f
 bwJXMci/7raucULkAbSS164AhLTNp77SPsv8JLzDYa8SAt9ifYjALNmhjEHHI0yD5aUH
 ArkoKT6oGbgGG+p02p5n5GqPj1Nju/mkieAdUUn/n56TtpxERgmmOkx4IPI7ZASvPVcF
 93JtKuTh6sC4lQBJbrBwlU4+Jb3g7uyQFlsFj0wDBpT3l4Yqk0T+zy/4aR3ds1gHuAGN
 003Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782823197; x=1783427997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q5eH7z9hFnBQ5GMXEsNUwAQ7XcGtjIQNqeFWuDLoHas=;
 b=Lwdqeph+ML7zPI0dJap0b36gLtEvGnfALiScEMbjOYJkN3i3PGtZ2Mi4eyq7540qNe
 Oq3qlmjAeaUn7uVlr9xaFTmgSC73ZWL6k3gyTti0KJMzKhDEzCN6RT51kINrYEyyIBfo
 0XL273Ts/M9gJGlHLSCiCSMYah88g26jhqlSv3QbV5iieQqt+IsKXxpVHwUsyUzWEGOT
 DKnfEZJ9CzmyDf3CpID465wvSWP9FNZNfgMMMzE6TZr1qehEekbCT/4rpIrc9jq0AwYj
 +v1rKc94eg7dkRAJoHDlcnwdrSa9wf3a+TvhrIdlC/ROSz7g+Xcsytpl73AvqzbkzQYI
 L5gg==
X-Gm-Message-State: AOJu0YzymHqq1zEl5ZjhcEI6sgdsfwJerbG5YtQTn1jR7/3h1Ggl4A+n
 x8NbJMAt9JTkRimoRkSpcowGBcLax7Mw3TWB9/S53zDogIrINWEyO/KhBVLEuSxlT1vmrQ==
X-Gm-Gg: AfdE7ckfAE6kG/VeJLFV1VSSI9prYZiV3G6saxDEy7bh0YN3QYzTTXksrnijSV4O+VQ
 Gqx7EDj3Q5e43zGinMb7/giiXHccFMPDJPZWfBYTlapmL9vkKimGAZfpr7yC1vPgq/ajo1/G3WQ
 xk5vXR/mVsd2TFfy7/Nfy3jQ0ir4K/uOrAIeIPG0V/tNp8niGJIONjGt35fxRPjhwX+7jY9lZ02
 EGWPyBRPQqQqDwfugDVTWePOKm+Hw/0Hum9E76eFiFytZIpxXgaYG1q4z1XFo7IXSBFq+FYthSW
 brQ00eOb9ytOvkuil72NfK2tzLCNHZc+75Dkdf+W15GmFjQguzdCMUQRHhcH8RDeyD26EAPqY0H
 7HPcZ0urGlQT9VK583w87WRwYOwiGDHsJBl7sXvqqiBxBabjScT35mGbV7wkp1UfdzCRsNDVnmx
 2JFDsUNVVQRA9IHO1uZLASjHnlpURmPiATrQegVL3yjuu8vQ==
X-Received: by 2002:a2e:bcc1:0:b0:39b:d76:5cb8 with SMTP id
 38308e7fff4ca-39b28d61b8amr1816031fa.12.1782823196629; 
 Tue, 30 Jun 2026 05:39:56 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39b1da4ca90sm4905721fa.31.2026.06.30.05.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 05:39:55 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: u-boot@lists.denx.de
Cc: ian.ray@gehealthcare.com, HuanWang@gehealthcare.com,
 brian.ruley@gehealthcare.com, martyn.welch@collabora.com, hs@nabladev.com,
 lukma@denx.de, sbabic@nabladev.com, festevam@gmail.com,
 Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v2 2/2] imx6: clock: fix clk0/clk1 swap in
 select_ldb_di_clock_source()
Date: Tue, 30 Jun 2026 15:39:51 +0300
Message-ID: <20260630123951.13385-3-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260630123951.13385-1-shofiqtest@gmail.com>
References: <20260630123951.13385-1-shofiqtest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Jun 2026 14:50:53 +0200
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

Fixes: bd3e19dbd901 ("imx6: clock: allow different clock sources for ldb")
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

