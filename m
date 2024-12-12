Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E231E77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83F23801F5;
	Thu, 12 Dec 2024 11:37:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="POwtML91";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D50D8020B; Thu, 12 Dec 2024 11:37:41 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67AD3801A9
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:37:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9e8522445dso81785666b.1
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733999859; x=1734604659; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Qonlm4PLh0H/GtsdhuXFZVKBAtt0qOXU+ZQOS/vDvI=;
 b=POwtML91ARn1UNEne3uOnceCJ6Sf25j7jB6m0DRiZlE6CLpnZV1JUslgkGWp1Dd7fw
 w86+tdJ+j3ZdU7nkF17ZoMVaZBHPGBORjgIVNtoq5+MJXKC1bEFAZmMG3FNUL+p9Tpx+
 lcA7Xih0yb+FIdKf06GMcNtVs7uWi6tY2lXS3uyIFLsxQI++6qEYri5jG6nuB1VbTbFI
 3YQ2coUEijdQ4SnYPXN1HbZRODaEEXZ/wJ2z0xjlr8EbMpYpD/c8MeAif69pau9GbtU5
 TEsrugdcEOP5NA57Qr0kRvpIBEuous7FH3zmHZatV/TH5kr0HAo2rBCM6haL7NpWykSJ
 EobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733999859; x=1734604659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Qonlm4PLh0H/GtsdhuXFZVKBAtt0qOXU+ZQOS/vDvI=;
 b=pGO9M+soQVHMlgkpcgnfBMpftlk2NYQmg9no3upsgNgt7LY4qtjgRJ7lW94TSewI5z
 0PSra47Pja+eNE5RA91tIEQo0GbdXG4DfoqEs83wTAQwE+hTeCMQg3P2jkJJH6ZkQMhj
 GIr+n5xEDdfGGggAOrHDVLzEvy53MaGibViBEs8yFwaLUAANK5bHGrjM8Dx47FynL5Sc
 QAMErwHLbJlt/eovO8xLTJIjjYoBMKRwY5W+kSN+vEOWaZFbf7mQgNbSJYSfKVAABvbv
 6Y8nCO8dGHFiENkcu8okoK12TqB00JHZbW2MkpL99iHZnRU2W2kTO9pwX+MkgpJzc/yb
 clww==
X-Gm-Message-State: AOJu0YwyTjVnyWT4f+vgrA74rqgRkRM+8BWI6kTSDeW8ncYOE/iQEGqO
 9iX2229xnUa4D0ugGujW3plPoUW5XPCnmp/M9PN4VWzkGz5GDTikTpJDgw==
X-Gm-Gg: ASbGncvVgkwQd2L5UVdyhsVaM0DN4qLQFmsJCvo4MUFm3+HD4FwfQsgSFQtcZwPnO9Q
 Af26r9TQGtOi/XFtnoDyIQKpS1mL/JIY3UI2KJpbO9BAfTsBlkIU7upygnszIfCCCg/IUfmn9Tc
 knVlcb7UoJFNnY5fStbN5L2EvrXPk1LUhpo0tpuc8l+fMCuthix3P52XuvH1ss7vWef+s2S0wU1
 huFZf4xRLozzrpf/4XkE7v+slJ5wCz1pqJD/ekAScVsYTAr
X-Google-Smtp-Source: AGHT+IGsipIEfVfdCygQTm2AezMiGBUKKNlAzLTujyujg0S6lwkzn6UhLH6rQWiy/2qq6xHCullIEg==
X-Received: by 2002:a17:906:30c3:b0:aa6:8dcb:365c with SMTP id
 a640c23a62f3a-aa6b13cc1f7mr590240566b.49.1733999858624; 
 Thu, 12 Dec 2024 02:37:38 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa68770c481sm569415966b.110.2024.12.12.02.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:37:28 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Thierry Reding <treding@nvidia.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/2] pinctrl: tegra20: adjust pin type detection
Date: Thu, 12 Dec 2024 12:37:05 +0200
Message-ID: <20241212103711.7516-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212103711.7516-1-clamor95@gmail.com>
References: <20241212103711.7516-1-clamor95@gmail.com>
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

Pin detection on t20 depends on node name. With recent changes
in node naming, let's remove '_' to be safe about both '_' or
'-' use.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/pinctrl/tegra/pinctrl-tegra20.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra20.c b/drivers/pinctrl/tegra/pinctrl-tegra20.c
index d5171b8be23..d59b3ec7b5d 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra20.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra20.c
@@ -97,9 +97,9 @@ static int tegra_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 		 * then actual pins setup (with node name prefix
 		 * conf_*) and then drive setup.
 		 */
-		if (!strncmp(child->name, "conf_", 5))
+		if (!strncmp(child->name, "conf", 4))
 			tegra_pinctrl_set_pin(child);
-		else if (!strncmp(child->name, "drive_", 6))
+		else if (!strncmp(child->name, "drive", 5))
 			debug("%s: drive configuration is not supported\n", __func__);
 		else
 			tegra_pinctrl_set_func(child);
-- 
2.43.0

