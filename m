Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB315CCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 05:51:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59073836C8;
	Mon, 27 Oct 2025 06:51:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CMeOU/vO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0955836C8; Mon, 27 Oct 2025 06:51:09 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D711282A9E
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 06:51:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c53c863172so296377a34.1
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 22:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761544266; x=1762149066; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jsXAgUGvL9T+VNLF2cQPkdjHdzXKkb0CFaNe3rUv73Y=;
 b=CMeOU/vOBdJ3ienJmwYCZ2W6UIYhKocjMyc0rjDar/pwAQ0WRp2tgSHHJ+7RJPgsUc
 YELLjllI6EeWbSArcS6Ew5pNtfSxXBLa+EbNcXiYoMC1nZM4idOHEtMHL7NTnZOrh7Cu
 fgiRoaMzhMNvhcZK3/Tk7DGCe2Bprz2wI51lCE2PxxAdmTrQpMVgos18YXmvgQhvYQUr
 GQ3HXAeOW29aCTD54ZtOFqUg7Mf6g3ddIQGTFBEuWAiRzZav9yKf3P8c5GgAtluZe6yM
 aUOS3elHbWTacG4O8LbijUjGtkpHNcziPP0POprxdeWNEb06MaVOYfkQl+KenG6stN6c
 W39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761544266; x=1762149066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jsXAgUGvL9T+VNLF2cQPkdjHdzXKkb0CFaNe3rUv73Y=;
 b=fmBWiluAK+XxLiWeliH2hJ1ks/cbjopSJtyPy38f15FpbJ+/WApXtb2q9pD3uCd1lX
 20//Mr59+I9Jelqt95mNLIaaMXw9+orZqn1SBZ28NELJu1LDTWAACMlzJ6L5Mf+fUXe3
 59TLEdlhNqtK/on83Lr7x70KztOjEbRUWGl8yeZy4kMga8FEv0FcrqwlJ85fvV28CTSi
 n6ECPlTOhaW2C3tB6ezFDFGgLOMjaDSnm0PXktWu53ySvEfwZ0SClxI1OLXdhM0Uoq6d
 Vu7JZb9nopPJOcVdTnnzTR0mo2mcEWzhoiHDDf0qsQP0mTglm/6WJg/3xIjZ0eiLUNhB
 RcBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHEBdRvFvPAHk0RAqzyN3htzfQOgh5zXcUr8dFnXpDXf5I+TK140xe1M9LsHtme6j3wdYX1Hg=@lists.denx.de
X-Gm-Message-State: AOJu0YweLMrKyeB7nVu3RiSACN6zcE5qYSf69STGTbbMrT0mbMODP/TG
 W/7OFaJ8gC4PQxAClDFSf+hiKunhNiXtlFJL6OQIs0PikAEhr1UG9Ez0BijYq+iBV8w=
X-Gm-Gg: ASbGncsXAUpuBloPAJQUHe6YRkgM5EfQbL6HrxLhnq3Qa/jWY6IsIM/+c+zpw8z/OXM
 jfrcqxa/dgXc4qgo4FjxYH7dLUW00iMeTc3ZQG8riU7BllNOoxtZkgTt2U1ecwuMwXP95C4rRSw
 61YeueJIWb34FydSbc3YkvbfQUSLU1gtdU5HTAbMU2sFUY2wWI3aygJc7OU/Vud2EPai1FXKe4y
 Sz7GHdMLxAEzPtXJACoVkQe8psZVMkLbUYDNl+eylz9m/ZE9XulqdUMw9aw9S4mHWvPdiVU0e7T
 IwFPIcPTUTlfAZAfWlrCwpYwWRDaZEuHO2bhGWjZTRUto/2iWS3GZofMt2N+lGIL8ZVkAQ6Jp3W
 tAS9ak9m7GOCvThT62B6GtnPo2pbdQ7X2e6gaFpOdH/D6gvIsotY6IrLv2B3UUI6vICA7ddYxkm
 xpPb6FTz/tKQ==
X-Google-Smtp-Source: AGHT+IHjm7Yv0OKOZLFBR/gwAFXvLCfo/qJkIBAVOS8igvqumXS99cphaGfbaLpxBulXRWn3xFp0oA==
X-Received: by 2002:a05:6830:7207:b0:7c5:3045:6c6f with SMTP id
 46e09a7af769-7c5304575d4mr4078441a34.20.1761544266577; 
 Sun, 26 Oct 2025 22:51:06 -0700 (PDT)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c530136068sm1966330a34.13.2025.10.26.22.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Oct 2025 22:51:06 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	u-boot@lists.denx.de
Subject: [PATCH 1/5] board: samsung: e850-96: Keep public functions together
Date: Mon, 27 Oct 2025 00:51:01 -0500
Message-Id: <20251027055105.720-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251027055105.720-1-semen.protsenko@linaro.org>
References: <20251027055105.720-1-semen.protsenko@linaro.org>
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

Move DRAM init functions close to other public functions, to make things
visually distinct and improve the readability.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 board/samsung/e850-96/e850-96.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/board/samsung/e850-96/e850-96.c b/board/samsung/e850-96/e850-96.c
index 3df241edde2a..34e01914032c 100644
--- a/board/samsung/e850-96/e850-96.c
+++ b/board/samsung/e850-96/e850-96.c
@@ -77,16 +77,6 @@ static struct acpm acpm = {
 	.ipc_ch		= EXYNOS850_IPC_AP_I3C,
 };
 
-int dram_init(void)
-{
-	return fdtdec_setup_mem_size_base();
-}
-
-int dram_init_banksize(void)
-{
-	return fdtdec_setup_memory_banksize();
-}
-
 /* Read the unique SoC ID from OTP registers */
 static u64 get_chip_id(void)
 {
@@ -166,6 +156,16 @@ void load_firmware(void)
 		printf("ERROR: LDFW loading failed (%d)\n", err);
 }
 
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
+
 int board_late_init(void)
 {
 	setup_serial();
-- 
2.39.5

