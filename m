Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EE4CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 12:53:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D101848A1;
	Wed, 10 Jun 2026 14:53:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BL32kJRx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99DA784874; Wed, 10 Jun 2026 11:37:37 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A303807C4
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 11:37:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vk092kumar@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-36bd175fdbaso3988554a91.0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 02:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781084254; x=1781689054; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wdy2po3zBVPfJJaZjTWqLg4he2IggyHOl7BxGn9vhPE=;
 b=BL32kJRxjw+nTL9B0vNkt5Ke11YVXGZvRBDh0zg6xsAvjkxRlLL1CLini+FWwZRYAp
 Mf9PVu4ZQ67S8BWF5ZcaNDcI39GGBNT9Axqgn1gpj8p0HlK71lWEwj234IwEf+bOas07
 hMrY84x6jE5mXSnVc413LeHOEpH6ckp5CRvk0kY+FHuAdz5w+/7GkGQg03q0oS7HjVRe
 GIcSTXY6rJOeQXLfAM0TxXvbL0a7K4ZfpRowlrmmk7sgKeGB+yDFgFKPZiEwO5Jilbcf
 h76vTsJrgwQ5SUzd3+NrPeydw93O9/Ml8scm5BZVrXra2hnmm57jZANVkc8G6sctAMIz
 5mpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781084254; x=1781689054;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wdy2po3zBVPfJJaZjTWqLg4he2IggyHOl7BxGn9vhPE=;
 b=IeB5ordSKVwjCiD+FVUDlcF1Ci11EcffFv2cCm8cGXEmPm/5cuAcblINYYCFB2ACsb
 d18XBtyJamS6ASdRGrWwm3yVokG1DsqDXqO+LS2x51fPIwf7S25ia05ZL6irL+kYVv2j
 K2VcaWIPob+9GRvZDySIMPc/2gI5e8HTHSzh1oBJfAvEvCyQqMYZoBrnZFN+P+ywQ0uM
 fg/IrPQCYuCrc5A6eHMPtPzUWdY50KHP2KT6ftYU9ve0UGoVHJhibq3oO4TzmAfHWh4v
 E1qX8yITs3r5F4Bf6mmK9YFNarWwTGPReUw5bhz7lIO4F6j5OlRWG9FvaoAF70lk0b8d
 36UA==
X-Gm-Message-State: AOJu0YwQWuXG8Jw8g/oXYEnV+ltlEVakXcDzEFPHE/kG3xog5Br9Pc2T
 ArYayUGpL1kL4nnj7jmtYQud4Ixa3bN5EjmmgKNXiyr0agdHcniFHmxJcKTLgCHY
X-Gm-Gg: Acq92OFCc9zl4OKhG1IA/bgPTC/FnHNmNHychMAiscC++Eu9d/Rey9PiwBNY7wUxoaB
 HeCjTDrhKHu03vIrX61AOoptGQBUAcNKC9rIFzUI8RXN5W4LofyFlvvoNjknLcBhmC9bdwQyecV
 X4IQ/62C7IESaD5XIUQ14+mQUTZibqdAzBdC7fYjbv54A/AxVBcA4TddZc57Mt566/ZstO2RY93
 VMReRTDzaVilGBx4nHbj1/KJmC9mAtlSO+myy8VEiJZPYh8t4Y2QDddJOYoyR52dcpufto0S6BC
 7L69xxvMO366eg7NlOgMmZfgXUbBcdflyMqWry1oIvSJyRu6h7aERtK70wkmKCYycsofN3ol8cb
 oHVoqi36VKMOt0SpRdmYaPSWkgG8XQaBTkKwO1MZVI5NrjBLjyE7hjKLX6FkpXABZS1ejvWWmg1
 ieQtpHUtISQ5T/zgO3bE9HjddGe7TUowZd3db4eeZdIsX19jJtuMDTdNY7n62h47B3UloLzThXX
 ZEAkzS6ZnwXk0WIoILklJcf01i/R+siAt9duppSwSeZsWY=
X-Received: by 2002:a17:90b:5787:b0:36b:e8b9:46a4 with SMTP id
 98e67ed59e1d1-370f0284a87mr25431110a91.14.1781084253796; 
 Wed, 10 Jun 2026 02:37:33 -0700 (PDT)
Received: from vk092-VivoBook-ASUSLaptop-X421EAYB-K413EA..
 ([2402:a00:163:2ce9:3030:82e1:fd09:4ad])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16629d55esm244071095ad.63.2026.06.10.02.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 02:37:33 -0700 (PDT)
From: Vivek Ray <vk092kumar@gmail.com>
To: u-boot@lists.denx.de
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 u-boot-qcom@groups.io, Vivek Ray <vk092kumar@gmail.com>
Subject: [PATCH] arm: mach-snapdragon: warn on root compatible string
 truncation
Date: Wed, 10 Jun 2026 15:07:26 +0530
Message-Id: <20260610093726.1231041-1-vk092kumar@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 10 Jun 2026 14:53:33 +0200
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

The configure_env() function copies root compatible strings into a
32-byte buffer prior to parsing. If a compatible string exceeds this
limit, strlcpy() silently truncates it, producing a malformed fdtfile
path and a boot failure with no indication of the root cause.

Add explicit truncation checks after both strlcpy() calls and emit a
log_warning() with the offending compatible string to make such
failures easier to diagnose.

Signed-off-by: Vivek Ray <vk092kumar@gmail.com>
---
 arch/arm/mach-snapdragon/board.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 829a0109ac7..9324030ae4d 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -391,6 +391,7 @@ static void configure_env(void)
 	const char *first_compat, *last_compat;
 	char *tmp;
 	char buf[32] = { 0 };
+	int len = 0;
 	/*
 	 * Most DTB filenames follow the scheme: qcom/<soc>-[vendor]-<board>.dtb
 	 * The vendor is skipped when it's a Qualcomm reference board, or the
@@ -417,7 +418,10 @@ static void configure_env(void)
 		return;
 	}
 
-	strlcpy(buf, first_compat, sizeof(buf) - 1);
+	/* A safety check to avoid silent failure due to name truncation */
+	len = strlcpy(buf, first_compat, sizeof(buf) - 1);
+	if (len >= sizeof(buf) - 1)
+		log_warning("compatible '%s' got truncated, fdtfile name too long\n", first_compat);
 	tmp = buf;
 
 	/* The Qualcomm reference boards (RBx, HDK, etc)  */
@@ -468,7 +472,11 @@ static void configure_env(void)
 
 		/* Copy the last compat (e.g. "qcom,sdm845") into buf */
 		memset(buf, 0, sizeof(buf));
-		strlcpy(buf, last_compat, sizeof(buf) - 1);
+
+		/* check for name truncation */
+		len = strlcpy(buf, last_compat, sizeof(buf) - 1);
+		if (len >= sizeof(buf) - 1)
+			log_warning("compatible '%s' got truncated, fdtfile name too long\n", last_compat);
 		tmp = buf;
 
 		/* strsep() is destructive, it replaces the comma with a \0 */
-- 
2.34.1

