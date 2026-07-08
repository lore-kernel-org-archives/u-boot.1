Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA56C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 01:31:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 780A484A3E;
	Wed,  8 Jul 2026 03:30:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="naNbnqKS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0EEB84A20; Wed,  8 Jul 2026 03:30:30 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A1EC84A0F
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 03:30:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7eb3865ea6fso163480a34.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 18:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783474227; x=1784079027; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HMG8xehSDhANdEmkl6ock6nRfefVgNvk6D/DA7gdOU4=;
 b=naNbnqKSebStBmjJQpKmMKpR558I5fA+b+G9Pgn7AjSPG7JZDGy5L6Phb9FhinE4LY
 mYSafcc/iO3wls28eAt/bmk7QCujJG4kwsSM56Mq+DBkFtu+6KFntyWY0YnrDd6eYdRG
 YI/HBqpFz+fxlJoTEyPhcC96ihAR/zZQSg4ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783474227; x=1784079027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HMG8xehSDhANdEmkl6ock6nRfefVgNvk6D/DA7gdOU4=;
 b=F6U9wjlDwtqDdwqb3I+tgLuP7ktgGPm5U4Okk5ET4pX9eoYrSx7bYb+1G/9OwWGpiy
 uQpynDu/qXaa8Ma89NON3hBjp6SWvxNVauZpDueI1bE8K8Q1IvL87qYhwTff/jsM21vj
 FwlTuYp8qfy0FlKuUFsvdVY5MEmyDf/o+9ipm3fDL0Hcn2VKprx5DJHQ1v4wdI4l1xw8
 bW4yrgMAr2qwIj+EjcjvB22zeZfckaou+hNfG5fJxrQaJdRYblT6PE76jvPvfnx5lYgn
 2Qcb5wfRlFYSFi+vz0497llpKKiy2ln38zhKmfpbFlEi5+ZyQK2e3E5tYlpucyxFRUBJ
 zoYA==
X-Gm-Message-State: AOJu0YzwGX8diXG4KDwOJ4Xvs/nf+PgzuZCzbFm+oa6UrzqRuLDSVtmO
 ABUqfPQL6rWG4Rm+JoCFvMFJazhNV9D63s4tMQI0gpssMihlmKhji/CozJtdsBZfVIqJ7xth/0U
 LU5CIbSk=
X-Gm-Gg: AfdE7clfB6/I/4L/PfcuivbzP620WfDHBMVslLRb38uayP4oMztoidjCH2PUti78pYA
 NPT6cftz5Ys3EYABI/AmAMHAjFDkYXcaY8v30e57sWqhZ7BLJEyodT6yHGup/1COxcE3nxuzUnn
 XrhaAEmPo2GCZu4HVU96JpCJ++PqpE32luhgzJ76o+LPtFXrEJu5WHK16Xq1vlKq8FAUOFUntg/
 G7GIDMCNa+4DuUQBZHnd8NhSrJv0Nmzz2y0Xmdrc84pD651I+uQq6OEY7PispJSrakzv557fv0s
 DlWAUb25BRqH4rX3buOqDLLtPsuGGwCLPX+d/8ti1TBKeqNOq4+ySbde6ByN3vkgF+IX8s4ZiVq
 mRSNGeBpBiZs49NWZznusBMUjaVsMCP34sJGaGk+L8R2N8Z/gxw3GUtIrdWqQHopVWts1YFCORE
 SFTtPXq2c86KRwgRvQutZvFV0BNXzkCAzohTjNkR13cYBzpvV+zK5N2E5XrmmKS7w9MKDramcGP
 wJwaPi/VF528+altVP773tU5JYu6Y0wEl4B9DZvWuv+yg4FCVt4gaKyKZEHVA==
X-Received: by 2002:a05:6830:6609:b0:7e9:e9a0:9a8b with SMTP id
 46e09a7af769-7ebcff5f37fmr267277a34.16.1783474227246; 
 Tue, 07 Jul 2026 18:30:27 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcaf77ba4sm780182a34.9.2026.07.07.18.30.26
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 18:30:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 5/7] dts: Correct entry for OF_OMIT_DTB
Date: Tue,  7 Jul 2026 19:25:15 -0600
Message-ID: <20260708013019.288985-6-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708013019.288985-1-trini@konsulko.com>
References: <20260708013019.288985-1-trini@konsulko.com>
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

When we omit writing a device tree file is not something that should be
prompted for but rather it should be selected when needed, and the
"default y if ..." conditions should be used for when this should be
enabled without being selected.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 dts/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/dts/Kconfig b/dts/Kconfig
index 2eb48223de2b..7457e0a5bb2e 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -205,8 +205,7 @@ config OF_HAS_PRIOR_STAGE
 	  disabled in the board's defconfig file.
 
 config OF_OMIT_DTB
-	bool "Omit the device tree output when building"
-	default y if OF_HAS_PRIOR_STAGE && !BINMAN
+	def_bool y if OF_HAS_PRIOR_STAGE && !BINMAN
 	help
 	  As a special case, avoid writing a device tree file u-boot.dtb when
 	  building. Also don't include that file in u-boot.bin
-- 
2.43.0

