Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB89FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 18:58:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5687846A0;
	Mon,  4 May 2026 20:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sZ4lNZCF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D4AE846B1; Mon,  4 May 2026 20:57:47 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 387AC846AD
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 20:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso33191135e9.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 11:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777921064; x=1778525864; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WDOtRuxUPKt2sn84t6IeeVBf0gpvrj8SBSZi3CtBzCA=;
 b=sZ4lNZCF4Xv6ZInLYvyLhDQ8JgRXrL4drrbftvwGeQsvADzx4HLPfu+aocwbWS2wTW
 Xb5tWEKCFyRWiUyi8L4zoeBMayNBtuUfC9PKMIO7cnao+/E6sTTf6quIQXVVjLwqrgua
 87CUzqCp+8qO6/AIHqfS2+wrNVHqNaB8lSHmFKkYxMXmY3U6zdI/pd9lY1XFd0grq08u
 FaKe/yV1Rrb9r9rQQ0fvsFyIGFp8weZLeM1bBjDQALsaDramYc5oHfCuS8psxRrwm7+F
 wc5jY8qrL222vENETyOgEb14jEjcrsMGPcvfvKUAMtKfa0uvy+MaiyOZrpF+tXlb27QI
 Za0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777921064; x=1778525864;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WDOtRuxUPKt2sn84t6IeeVBf0gpvrj8SBSZi3CtBzCA=;
 b=UeN1llerKUSr+O1WHaY4mNf1VP4mpJ/GCOBFmndF+EzXtQeMcvdBMgxNKOJgzVEL7X
 3Ut3llE9IKvyPOJApWgaEzilAyh3rdRh2tFDsnK2mrvhgVT4/E+4TYgiei/SgDC3BMRv
 nCHtw7JxahvPlxkUpXr9oJAGA8J4/Jms3Str+j+wD88ueWXEsnCvz5Mnusz0AfO6TItL
 5IPNnTM0aoHA9W/bJ3FYVtZrRIPUqJcuoYMLtMPJYdmTOT5z51vLsFccrff0dEt9PH/T
 wH9oF5ETpF3ceHwZ7tx9MEL2QDnmJzIjXD7FqQJHgIIhfAfcvDkRWS73f9u8rUtzvB6O
 7Tqw==
X-Gm-Message-State: AOJu0Yy2OOPV3+LncWbuTB9YKZ2CU9AkuB8b87EBrUzU1dyDqJx7f6Jh
 oE1pOJK6aABd+QvbwAlwRCgwiXkPDDzIZD9oUtCJjf67G1S4wM0Gg78PH9oe02CJPVc=
X-Gm-Gg: AeBDiet7e9/L7g/93+/mDGRJlafRlEo1S1hXygUEXoQfBQBhh/UxJy8mkyWsgkNaEz9
 yCmiaZmlTlbtuvSOL1rMdM4okH47X7ub19hws4h3oaenaTCH3Vspg7p3OZ/LORxb9LUj5AQYcuZ
 4LQUsJ3Dl8WAad8r7VYUvxQ2Bbt3z6LjU6ESTsX6tes87eRRR0Wz306/5f2hqHZedxgL7mH/Msy
 3zqZjuGQwMXXi0xvnJUOSRSbmg1SVKUMjib0WeVc1YCvI48XYvikNUC4H3nYRvogcAhO934fAee
 O+Ru9r8c2cCdM4wW/VxjNwSMNMBBQfGK5IUfcZvBT+zCZCnrcqFxjZ3J5VXV851mAWIILN09WW0
 keLqufT3uf6LexqNjmFXtyC8FLo8FOxEutOSfuUEvxdxKh4s3y4KpGBn9EYDKHJrYWycifFEonQ
 3sPh3VEJkbnq8kb7a0KgNnYMfulGiW/y6dZxaTKM6bUmtEhQ2hwKaCeSGDzb/YnIX8GESy08xLD
 8i8xZY=
X-Received: by 2002:a05:600c:a302:b0:48a:568f:ae8a with SMTP id
 5b1f17b1804b1-48a98638a65mr127886165e9.8.1777921063702; 
 Mon, 04 May 2026 11:57:43 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4500f9c2cd5sm2861f8f.23.2026.05.04.11.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 11:57:43 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 04 May 2026 20:57:32 +0200
Subject: [PATCH v2 04/15] Revert "drivers: smem: sandbox"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-b4-modernise-smem-v2-4-c01ec2ff3886@linaro.org>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
In-Reply-To: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1578;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=YPLZZYP/80vJr2YbP1s0XqlKPvUsWkotbUqCk9VWx0M=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhswfb+Tub5gSwfxpxfW26sKzLmnKJRvW3xf9lHHMK885t
 4Hl0VOOjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRkJeMDDvlvvh3pZxj/pFR
 +SDO9PoJFledj7PPfVqwT6f5/4eVdzYy/NPSjy7+x+Kw5HiV8IuwwkcZa25k9mUb6ifW/xWWDu+
 PfAYA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

This reverts commit 7fd7e2cf339ea2ec570f6dae1cdfaf8e066eb4af.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/sandbox/dts/test.dts   | 4 ----
 configs/sandbox64_defconfig | 2 --
 configs/sandbox_defconfig   | 2 --
 3 files changed, 8 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index ac92ebf1afd7..50201ad61ccd 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1521,12 +1521,8 @@
 		compatible = "sandbox,scsi";
 		sandbox,filepath = "scsi.img";
 	};
 
-	smem@0 {
-		compatible = "sandbox,smem";
-	};
-
 	sound {
 		compatible = "sandbox,sound";
 		cpu {
 			sound-dai = <&i2s 0>;
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 60a30d048750..53f7af4270af 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -240,10 +240,8 @@ CONFIG_SANDBOX_RESET=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_RV8803=y
 CONFIG_SCSI=y
 CONFIG_SANDBOX_SERIAL=y
-CONFIG_SMEM=y
-CONFIG_SANDBOX_SMEM=y
 CONFIG_SOUND=y
 CONFIG_SOUND_SANDBOX=y
 CONFIG_SOC_DEVICE=y
 CONFIG_SANDBOX_SPI=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index f26295103f1c..7f26405e6ed0 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -331,10 +331,8 @@ CONFIG_RTC_RV8803=y
 CONFIG_RTC_HT1380=y
 CONFIG_SCSI=y
 CONFIG_SANDBOX_SERIAL=y
 CONFIG_SANDBOX_SM=y
-CONFIG_SMEM=y
-CONFIG_SANDBOX_SMEM=y
 CONFIG_SOUND=y
 CONFIG_SOUND_DA7219=y
 CONFIG_SOUND_MAX98357A=y
 CONFIG_SOUND_SANDBOX=y

-- 
2.53.0

