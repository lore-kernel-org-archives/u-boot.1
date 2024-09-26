Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A72CDE03F
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6615488EA3;
	Fri, 27 Sep 2024 00:40:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WeXiF1e5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B109E88966; Fri, 27 Sep 2024 00:40:56 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA28E88F77
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cb321145easo10267636d6.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390453; x=1727995253; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/8I/2QoaQ9TO8cumRv47d3g/+m581u7Ac82nmmv1BHo=;
 b=WeXiF1e5AePNrOOAi8VPi61wyA646L/ctzDXqHG+cQF/+zwnRxV/T+UZkVwuHBy+T9
 x9BNSjFSk52HSaGoMWetAqvRxC44mZMX6ga/dIzbeYRpZQM6lWv3Ug+R7DMBmMxdVGUm
 XS9TDJtLP/ikwWS/9+qtNjJY/x4i5bj12zp2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390453; x=1727995253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/8I/2QoaQ9TO8cumRv47d3g/+m581u7Ac82nmmv1BHo=;
 b=XTahoXuKSMWbDFvRlrhbCoSPoQhBUtKcxjN6JGDv1+VhQgU6q5Xvce28Fouha/awNM
 /G06QzyV0rwm7e47DyRWXBiKI7ODzjwmTAru5q6Nm9DYoewM01ndbXrEoOUUAFh67ZKa
 ruvbbzqMf30yI2jp8MFMNUpSAbnC0+QjWjf0jFKhS+7+TmWL+kMgJIyeXCq4AcGCJeB0
 skSRtdtor9P19qXyIuFIFSSnsYqUaSRh+J/0CRS3S7Tn92TtdWtjohPD8Eki5YEPCS7q
 bhTDakoLhz01EVBnPH2wGtRJ3tLeHpgz6+jJCXjXvjq1BdLU+huWbzRMMfVnNFN5YAQL
 HX/A==
X-Gm-Message-State: AOJu0YxVTfbnZClLTP6Xh5y8IXtcaUrPz1y4viBm0aZc7JfeaJnpex2O
 QgRdOPRR4bPGqWUATmmd4tJyKHSZkayDdABDg9BJpORUy9JQvr4HRmftqLrXyESAKjXLup+vcAC
 F41R8zfY=
X-Google-Smtp-Source: AGHT+IG9gA9JQsuofyrRPt27Czm9Q6qZPbDWR8TssycznI+zW3HEhoST59LDPUdwBPDKEYU64bkNWA==
X-Received: by 2002:a05:6214:19c4:b0:6cb:2c7d:835 with SMTP id
 6a1803df08f44-6cb2f2707dcmr89821776d6.7.1727390453520; 
 Thu, 26 Sep 2024 15:40:53 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:40:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Boon Khai Ng <boon.khai.ng@intel.com>, Gabor Juhos <j4g8y7@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Philip Oberfichtner <pro@denx.de>,
 Ramon Fried <rfried.dev@gmail.com>, Robert Marko <robert.marko@sartura.hr>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH 07/42] net: freescale: Drop use of SPL_BUILD dependency
Date: Fri, 27 Sep 2024 00:35:32 +0200
Message-ID: <20240926223814.1276764-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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

SPL_BUILD is not a Kconfig symbol. Perhaps the intent here is to use
SPL instead. However, this causes build errors, e.g. with T1024RDB_NAND

So drop the dependency on !SPL_BUILD since it does nothing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/net/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index e7d0ddfe25a..403d7e1c679 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -891,7 +891,7 @@ config FEC2_PHY_NORXERR
 
 config SYS_DPAA_QBMAN
 	bool "Device tree fixup for QBMan on freescale SOCs"
-	depends on (ARM || PPC) && !SPL_BUILD
+	depends on ARM || PPC
 	default y if ARCH_B4860 || \
 		     ARCH_B4420 || \
 		     ARCH_P1023 || \
-- 
2.43.0

