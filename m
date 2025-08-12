Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E74CA0EDF
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 17:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FA8C82AC4;
	Tue, 12 Aug 2025 19:31:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nAEebEEQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10E8482BCD; Tue, 12 Aug 2025 19:31:15 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7E3E829F5
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 19:31:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-741b8c26e70so1218835a34.0
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 10:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755019871; x=1755624671; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3HOhfGqs//AJcox+s4SNUbddGyEWkm0UrbCc73cZHwU=;
 b=nAEebEEQMW+A9qnkkCSdaTErWpcWQTWr7KEJ7Xk2tOzRyzyO4xnya0Gw7DHOpKaKkA
 naEC52wQfMjY9k+r/HhOhjigRrCnMO4AqKQfkLcI1+IWDJSA4mXbq9C/6CNPqWlIABoN
 WK9KkW+vOmxPvqhzHeMzpiSszaUIxbdmVM8Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755019871; x=1755624671;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3HOhfGqs//AJcox+s4SNUbddGyEWkm0UrbCc73cZHwU=;
 b=u+aTcXeG20GOQiNF7Cr+ubZz5WeoVWjNnd4gaztAyO6L4noZsBN7fALrW4LPqgeRHV
 XJaaGKLzruO6NNTH9LyUHkyUrba1Pj8WQHlZ4ZUxHIWCcz14o9o42gJAsY3IW/AZhO/l
 RFakAhFQegTSp3EW6AGo+0HzHpa+12fw7hlLQ8PImB+8DpJVd+oMCrI3aqN8Bs2q+WWu
 qqL+Xism4Wh8aBOO4P3r20dVQqQfDPBS/J6EombJ+YIK44A+cM1IKwa4sbgy0QATbw0z
 ciMinAotzO3aqNYzRWUVcseVQ1O1YW1Ljt5CpwWQ5pmvPeXvi2yA1agbcu4gYTCYIgqB
 /igA==
X-Gm-Message-State: AOJu0YxbrsgSy5WtoM0ao3K3RK1CsKFBQW4T9brpLceHuXSjQ8gt454k
 rcaZ+EABJA3TVE3/EPDjpvmGFXk44/GDhMZiVGaVQpzW5tzh/x9IPp5tKNQJDyS+Cx+ClWSV6yW
 VsE0XhIQ=
X-Gm-Gg: ASbGncvwnieCzD/oI0D3Ezw/UVYcyxumW4gvmEwkbXG/EJFAC/1NxBeVN/Lv5c1PKUc
 DYCE/zxOwIYGVXDouUvqtbyvYLBYPbH0JctA0/FWoGQEidrw5SJlGb/XW4IfSaE3oYdZEDC/U0G
 lqhR0DMuRzBAtZUcBt2eYjZfQyzCG6Axc2ycLFC+CmXOb4ktUpVHdfixOPybvhxxCL1s4Qz90nr
 z+bqWvy0H3WchFdJS+3FJ5gruHOycrzXYW3BUkdhb+0Amnsg+jFlpgTABGb+PQKDMStFiz/3pOV
 w3Mv0+JxUCN+oxttHA3fVoR3JaDI1OcbfldqUQoe8Chz7rhWQ/oWyxhzOR/k5AVa05PYxzCSRBP
 2x9MMcz4qnBgLJYIlokip0NiWG0HIi9Dae6NLp2R6qcXhT5RN497sIoahSzc=
X-Google-Smtp-Source: AGHT+IFDULGputRnHA3EKXiX9+7ups6SxhimXI6r22bMPFlf41005s/IeN1hlPIj+DdhZVQgrxR3ZA==
X-Received: by 2002:a05:6830:4d81:20b0:741:dffb:13fa with SMTP id
 46e09a7af769-743754c4009mr98522a34.21.1755019871582; 
 Tue, 12 Aug 2025 10:31:11 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7436f85f6besm342670a34.8.2025.08.12.10.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 10:31:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH] env: Correct Kconfig type for ENV_MMC_SW_PARTITION
Date: Tue, 12 Aug 2025 11:31:09 -0600
Message-ID: <20250812173109.1813657-1-trini@konsulko.com>
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

As part of renaming environment related Kconfig options,
ENV_MMC_SW_PARTITION was inadvertently changed from a string to a bool.
Correct this.

Fixes: ffc4914703a2 ("env: Rename ENV_MMC_PARTITION to ENV_MMC_SW_PARTITION")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 env/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/env/Kconfig b/env/Kconfig
index 1df7ebd547e6..03c189b7266f 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -732,7 +732,7 @@ config ENV_MMC_USE_SW_PARTITION
 	depends on ENV_IS_IN_MMC
 
 config ENV_MMC_SW_PARTITION
-	bool "SD/MMC environment software partition name"
+	string "SD/MMC environment software partition name"
 	depends on ENV_MMC_USE_SW_PARTITION
 	help
 	  SD/MMC software partition name used to save environment variables.
-- 
2.43.0

