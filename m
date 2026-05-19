Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD551CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 18:29:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 072748485A;
	Tue, 19 May 2026 20:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a/l7v2JB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C380584879; Tue, 19 May 2026 20:29:02 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6319784852
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 20:28:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7dbe437b072so1989148a34.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 11:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779215338; x=1779820138; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SaFv36kNEVHGKpaJArgrkTFCTV5igwB7rb414ipEA/I=;
 b=a/l7v2JBMuux/Snks2WGzIUeSV/QhUOTSBBKUoqSSs8RiirfkVMBmMYRP43erjIXzf
 I9okBq87Xy0jId+4o145++TUHxu8SSCJKgwMTU1b4czzs4Z4TjI27Lv8STqaV6UptQ77
 Pieh4fehFiiG4cf2pOyP8uYyPatuPiMZd+el4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779215338; x=1779820138;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SaFv36kNEVHGKpaJArgrkTFCTV5igwB7rb414ipEA/I=;
 b=rz4+FzH0ix6GFXQe7I0GXlVoI5NzwrbN9Rs27jzYJ6Z+Q9uML+7FTsJImvn/dEjHbn
 W12XcFawLTQUd2YJ3whgZ9sthta42QsLrKGaR8cLp15pM1h80rqgjQndhXZt9/SiLJDN
 1LsPPlPOJjtNm/tVupoqdcir51utpIh2zrYMHXinXkiZTyLLOAbgwdL5fRNIFKC77L6q
 5wsdXnuXCY8JfJSEQhA3z1xvbWA4Dte47wdkV70PZSAPzK9Mmy32Ietz9VWWcH+x09lv
 uUHJ81urzpwz6+04eONrLFMoBax1LNQyWY8wvIKbqnSKIuQVM2sC+efoCBbpFVW8SqW8
 4aYg==
X-Gm-Message-State: AOJu0Yz01hrvnld9G6UoPjeEjqNFDN4zsJXPjXQlDRzJNLGjd6uFFtXo
 rV9o8x+atyBBMKYcYzvybm4y4UPjB5f/HKBbUagfgBy0dmnQSoUMIjYHMa/v3hj65dRg/gBl+Ms
 4Y24qFwqvLjOo
X-Gm-Gg: Acq92OEzBGwhFSc1ut2iO4oV48Ard7lrTmpu2hbSafS0nYsE2PJf0J0zgNNZQOW4wjm
 EB335MIXqQ4XkR/Vt+ZsaVB0OZ7dokSKConCz5PjPGxyhIiA10lhmy272RF0vbAmC1b9JP3pPMD
 p3W4JFV01NlJ451Y0taJqv+7kahYrXvewWXQrY/+w9HgyfcigEHLEzxts6z8IGMC02TCDFVs/C3
 sojuVvfvHxzv0k9mkIuovm7+gG4hpoeCpPWfpd9ZlQYerSgARwdyNQB1VQ3XYeoh+U8pfpnLi1/
 zmvMGC7xrgX+76NZ7uRbes+gTqgpqcgg4S13ihlw4Pi/Cvk0rw0v5axmv8lC2NMWNJR1T9ED3PI
 kJRNHHlYtovUjSvC02rxW8O+fQ74BcqW7uQDFA5tG//8jMZ0OoADCckr64s4qsRzfBglQ7R7QYb
 tBjBvM58+APh4TqVBAUgDvGRex0BMxQ3fJwdjd1jj0itXC35A39vuZJ1ScMuUlsCtyOIGU9zjec
 bfxR1K29qqL3N54ERnk5UWy7WryHyboQ8XD5eoy1tKN/RXMw5Xtgnp+huqjJsGqPsqsey0p5rM=
X-Received: by 2002:a05:6820:207:b0:696:1c20:722d with SMTP id
 006d021491bc7-69c9bfe7be4mr12785801eaf.53.1779215338130; 
 Tue, 19 May 2026 11:28:58 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-106-235.totalplay.net. [189.203.106.235])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d046130cbsm7851379eaf.5.2026.05.19.11.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 11:28:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH 1/2] toradex: common: Make TDX_CFG_BLOCK select EVENT
Date: Tue, 19 May 2026 12:28:55 -0600
Message-ID: <20260519182856.865924-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Part of the TDX_CFG_BLOCK code makes use of an event to run one of the
functions. Make this have a "select EVENT" so that it is always enabled.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
This was only the case on colibri_vf today.

Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/common/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/toradex/common/Kconfig b/board/toradex/common/Kconfig
index b85893ab44e4..05f8341e4c36 100644
--- a/board/toradex/common/Kconfig
+++ b/board/toradex/common/Kconfig
@@ -3,6 +3,7 @@
 
 menuconfig TDX_CFG_BLOCK
 	bool "Enable Toradex config block support"
+	select EVENT
 	select OF_BOARD_SETUP
 	select SYSINFO
 	help
-- 
2.43.0

