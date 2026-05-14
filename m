Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EC7CD37AC
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 17:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30CFB846AA;
	Thu, 14 May 2026 19:55:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ebre4jLb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A009D8464D; Thu, 14 May 2026 19:55:07 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 700EF8466F
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 19:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-479ef2b78f3so7090822b6e.2
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 10:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778781303; x=1779386103; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=34FJaf4knvnqZVd5Y+bCNTClRyxmesQXVUKDNWLDyCo=;
 b=ebre4jLb/8dwFp09HfFe6oDuAIa2wWwP3AKmOL22ifvexvNRBgw0oM3jXqDXPkiyYh
 mlfRCjSwc287erKXzvUIV4J7Ws20JF7VOFTQuFJ5AvguoPyrtcA03h76hUAuDZJPg7I0
 Vs1sfqywGyKsz365foSXsXI+/7mC4k+a7TpFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778781303; x=1779386103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=34FJaf4knvnqZVd5Y+bCNTClRyxmesQXVUKDNWLDyCo=;
 b=OhKcyXc1+PCbr3N7BQSVBPsat+bDKbYdO/Sg8AxXYvrdiMsTVZMRLpM+ez9FzSO2xh
 6Bucnc2RpLsk1Q+pdbTCcP1Nqtm2qMYNlD0k1uwCZnk7zRL8lP1ODcxK2rSlFQpc+jOK
 jhkbmhpO43QzWu0nrjVAVyZIGGexT1TVAjJEEMfD7Hfsgrh5IotsVldJkwi1WNP0IY6l
 Kl5OHB/gCWAH5sIDRAnUTr0hggZqqb7pIWQmexFIsIl1/jKTh3D35VxrwKXN/2H0UKYM
 mHYNmepyCGOsbVf7sIctjVAOTfHHBOYqmt06qiVrCiYwnGAMdT8qOz8mKB8NLbyxk1k7
 fgDA==
X-Gm-Message-State: AOJu0YyiQB67O6Awo59DWQN1CtbooDHnSPdRe6ZwOrDxFVItnRYxGiDh
 p7ouBiVHEeFuXralrwL/CRoW/R6BayzMvfFiGyUEHZfyj+pHst0HAqsXKDePsGuKNRVoKqeVh75
 jjpKqcEzKTiXi
X-Gm-Gg: Acq92OE9iAIoL5jYtrYZdtKqjk0Y3H7IkXPkMv2fMz2kijINfRWChm2hNHfcfX51LL4
 IpE6PDenHDQppJUkebVkf8BYimJegCZqSveXWJjClGmwjsDx9gRNru/XFPuobm1fJOfCi/bnh91
 cAT5o4j68g+nlarIfERWvyCDsFjSy3FU6X16pjU7D1mK94Sddm3fFxLuBv2wd5g9SZ23JbuXIDt
 WeGqMYFXnLLbijlZfIpm8iWeZ9Vkz3nRsO8CJHZtAwbXULVx08oyj/1vjYSZTfh93lEVXobD9oh
 d3idAGMrBdRcOrAEbqEJ5LBYxzx1gah3W9cLelzzVHvQbnwf3EvjM6cOM4U2ue5fgg30isgd9ww
 SxP4kKnqVL7fX7BI3GJ9S6BPVbFO+0rc3hYdC3JQsItD/l0RGnKdmkuJbyqiDjk5+V7poq1hzzF
 LmjjvQERBYXy4hojsHwfG7CvZxJf+OwIX8yxoV0FZl9WQuBB256jjihvnqmbgB2oYS1KTkhoyZn
 ARWhFqyHQzXdJBlzLJjqBSQad+cjWRG4Lo4kWEbeZF1hj4fNpXBM1bNdu24CwD5QrMRWlVIbB8=
X-Received: by 2002:a05:6808:c186:b0:45e:b623:f9b3 with SMTP id
 5614622812f47-482e57ad7cdmr295447b6e.42.1778781303554; 
 Thu, 14 May 2026 10:55:03 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-106-235.totalplay.net. [189.203.106.235])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-482d379f062sm1758710b6e.6.2026.05.14.10.55.03
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:55:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/3] bloblist / handoff: Make this depend on BLOBLIST_FIXED
Date: Thu, 14 May 2026 11:42:27 -0600
Message-ID: <20260514175457.4047707-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514175457.4047707-1-trini@konsulko.com>
References: <20260514175457.4047707-1-trini@konsulko.com>
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

Currently, the only way we support passing a bloblist from one stage to
the next is via the BLOBLIST_FIXED mechanism. Update the Kconfig logic
to express this constraint.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 common/spl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 5fa94098e498..cc819344cad2 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -220,7 +220,7 @@ source "common/spl/Kconfig.nxp"
 
 config HANDOFF
 	bool "Pass hand-off information from SPL to U-Boot proper"
-	depends on BLOBLIST
+	depends on BLOBLIST_FIXED
 	help
 	  It is useful to be able to pass information from SPL to U-Boot
 	  proper to preserve state that is known in SPL and is needed in U-Boot.
-- 
2.43.0

