Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE2DC36017
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 22:53:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3BF081FC0;
	Wed,  2 Apr 2025 00:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EEqZQMgP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8051481E6C; Wed,  2 Apr 2025 00:52:43 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8780C80F6B
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 00:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so42696075e9.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 15:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743547961; x=1744152761; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NUquF9iuIp7lnMmDFY1KTqf87iUW2mnFLaVtn9tKXPY=;
 b=EEqZQMgPHkd+McHXvDNxFjoBXw3b3uZGSaIyuFUvhXpL3uzf0Koj+gWHNjRkUk88Aa
 0qsJD4UUTfnXdttWGv7s0iDsbMo9R5l8fszs6MwYtfFQp2Tvvg0Q88GV2olsj130kSph
 Nreev83fRYR6EQu7Np4y/R5J69/t64uVg/W5Q9zIPh96ASo70EJEV+vlLRbaizuszpKf
 h625+pqoaNUt7k1QgeRNfB4+X7LEv5XngErhUBdMBYCWPWnLXaAjcCZ6kzb+m04I0HZt
 nOz5GLkeq42MWOHN6r17tLb3qYsnbVAYXw5gbVAuzoQvPIB0UMCkMOdAgeBtRcnfmqNQ
 y+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743547961; x=1744152761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NUquF9iuIp7lnMmDFY1KTqf87iUW2mnFLaVtn9tKXPY=;
 b=ourRkMODomPesOQNnwipmFjCkoYbgbPHgUzbfadB3MDdTacTG0+IBhorYDre3j5Nk3
 XdcxfZv6LnL7CZWQ78SWPTfREOcnFx9eLZLyD5yIzlp1acRfo6NFRuKekAea/W3pSVXK
 /fqJ2HaC5ADp7o4ggINqNWYh0Ettc0nhFhbCSHFmcw/MOz2tDkShUs/Xe1n2ZzotAUZQ
 OvPrLpqetFHjfktMIOdVrbx/BbNDOo10rSeePFku46a/x7NyymBmoCCIx7dezdyMrXGS
 P3ZfgKIWi6cgxhqfxSTD/6/qwBZfF2lL9s5H7CYj8nzXkc63bgOd8KNXubO8/WMhw++Y
 AyTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT31+pcxTNN4YdWam7ulxIiTp8i79/ZVmuaEHqVPmEl1RzCpGl1RKdQLYvnnmLCSRQugGJRSw=@lists.denx.de
X-Gm-Message-State: AOJu0YysgrlIcVtr2+ry8z9QNrQhGZgnCPEaPNTE9/5u/xNSNasL7yYr
 3d91nP3X+bljy5KxDmohtkbhU6l167ocEtMroeRwqPv8M0cZyNeV
X-Gm-Gg: ASbGncvY/cSY4EZLMhUn6Q7W0FdeKkMA67bS/k5CDgmiP+iD7nfmYDeM9JmWMEE35y1
 Li+EP0QV5guOKEDy4z1bKVZm5t3/F2sfdMS0nmmxweM2/F4TY8NetVDsbE6ZPPIqxQzIhdAOCm+
 tu4fL0s7rJ8Iy8OtYsIgEoi+q3rmSxOMQ298lcm/VOzwQFp0CO+T0mjgPrkHPT7jWjo6Z7dF9PQ
 3fIhzlzKP2LVM3lFJrVl05kMhpvbyulmyu0BDZqRQfOkUvhcfkZSH7cQhC0ZGTVdfVNnpXP6th6
 /gdjfraHChPB2ndRRp/I4G3QfXnoX+SsC3fOS56Icx7LgZtecvbhx5kwfYTQ6Vj4L9pU93YHBhi
 679ikRwI39U/79Q==
X-Google-Smtp-Source: AGHT+IG+pKWXXUUM1vGbVlF0s/9EblZ2gvs2BcPW5Jde7L2T+APv0XJeKbmtMwlDJQuLFanfk+TgRw==
X-Received: by 2002:a05:600c:5124:b0:43d:24d:bbe2 with SMTP id
 5b1f17b1804b1-43eb5c95c04mr1630395e9.28.1743547960939; 
 Tue, 01 Apr 2025 15:52:40 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43eb60cd77bsm2478625e9.19.2025.04.01.15.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 15:52:40 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Bruce Suen <bruce_suen@163.com>,
 u-boot@lists.denx.de
Subject: [PATCH 05/14] mmc: mediatek: permit to also build for Airoha arch
Date: Wed,  2 Apr 2025 00:51:37 +0200
Message-ID: <20250401225156.25790-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250401225156.25790-1-ansuelsmth@gmail.com>
References: <20250401225156.25790-1-ansuelsmth@gmail.com>
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

Airoha new SoC implement the same Mediatek driver for MMC. Permit to
also build for Airoha arch.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/mmc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 4827834b4aa..2e33dbd3fb7 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -860,7 +860,7 @@ config FTSDC010_SDIO
 
 config MMC_MTK
 	bool "MediaTek SD/MMC Card Interface support"
-	depends on ARCH_MEDIATEK || ARCH_MTMIPS
+	depends on ARCH_MEDIATEK || ARCH_MTMIPS || ARCH_AIROHA
 	depends on OF_CONTROL
 	help
 	  This selects the MediaTek(R) Secure digital and Multimedia card Interface.
-- 
2.48.1

