Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15587C369C2
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 12:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11945809D4;
	Thu, 24 Apr 2025 14:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="HJ+NbXMZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EDE2820E2; Thu, 24 Apr 2025 14:14:04 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5302F81F0B
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 14:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8CF38402E5
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 12:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745496830;
 bh=9v7Y1Hs7F0tFRNNjlic64uhqYvwNCw6JsYWulzYGbxQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=HJ+NbXMZHWEEirBUE6aCOTJ/p06UDktYMVJ58lHFEFLo2JWrRJcAO2TkZoC9z7GOG
 GwPbIGvTyxuQRu/ik9/W6UtFB6IfJ6ZYS+1nsqWq2NcJ0QdmBFj3Ft4R3eXFzNcGem
 6Bl2d4OpCAqpZFjQL32Gg4I2tVUFiRlQG6RMWP+smQd48T/NzTr9d/Nw/0iCAGsp+o
 qYx3Y7JRkH8d5yIT+hAkUlZzCwagCEASS0zKrWyvF2+sXv2YX39S7SQoc9o0HnfmkS
 CkQ55etUEZf2u/TSEHCy2sJmXjJLMpFf4uRYw6gE349piGV1lXssnupwmaLA4pjhtE
 B0+sDPYTpq6Gw==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d0830c3f7so7139115e9.2
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 05:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745496807; x=1746101607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9v7Y1Hs7F0tFRNNjlic64uhqYvwNCw6JsYWulzYGbxQ=;
 b=cAAf9ZwyKvwOLfCKoG9Sj39GI2y8zaZ3ETvHqkEEKyOTJJdQYNdZmm2J2bcUqhwtA4
 p+LRTOLEmhKkZcOu3e9ax4ewbhAxiSmfgfpPuL6s1Kbg/4p75qkOC0dBX6N3C2vHCKJq
 hvOV3PWzNiu8egx95597c2z5VscrMHpp2A2pTVO7krzagCoaGXZoQm7J/+WMqZZ1DbIV
 r4K67SnB4t0Npb7kSduPiUyAMHjpfrINAdmdipfmkQboNHcxFVhgJAvJl8YQW+EaluSw
 /bYurKQA4m+HNbZAICDV4cav21gB4zMA1JzBvcmxXpOWBHTAhFeggjeAZDzOv4faU0MM
 Ie9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWTWdM1qVt2vNSoNXosGtIB2VdVq/ra0klz1PjU21/i+KFsvF6AbN1R/EZueUj2XGIMnvXIII=@lists.denx.de
X-Gm-Message-State: AOJu0YwGQjnnlGADsvrZ9f1rRgQRq52Nn6wp8kCfbK7HWewIpigtiKot
 1+i7YH8MZxlwICEKvHlMALmiCV8sjEchy/DBMMyHESpgUXInMIoo9HA3AUDqu8RG6FjgQOTD2yB
 WuY99r0zsTQriE+8h74hKYAopN0aATgIz1X6Uj+ILSzPMDUvu7ou0Cs2qP9tQIjOzpWY=
X-Gm-Gg: ASbGncsJ0ch903EDOnFs56w05viQyfcZxIL2lEZpjetDFdiwZ9UkG7gAt6yf3+uPgjR
 4xGmUo3E4plgKQZeO+9sJFvAKD8ofMhwWnIWbYt22hul/LDsegk5rvrTSQAHXE68HxPfcTTduQc
 2w4yX/+ucDsdM1gg5AtbnI5fC4ySds5sf1ujZItP6ByvahNYbird51SMnIZQKcanHdyKw4aTknR
 mLahCpKxqa+Mqh2Wk9rSBO9FuxCDmrwJSFo+kTr4OvziMDwqZfOHmySZr1T7+KphC3mdHffYV2h
 HPFlkGl6ZPn7tk9bS72yfqejm33axL/Mit7bYJGcQzaVglWOXLNueQKxWttu4iQgLutd0O/2Zfc
 +Ob6B7hRYuvzS7w==
X-Received: by 2002:a05:600c:3d86:b0:43d:fa59:a685 with SMTP id
 5b1f17b1804b1-4409bdafd98mr20551695e9.33.1745496807055; 
 Thu, 24 Apr 2025 05:13:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbUkFIQwitbdeVGo0dzBLcAQ4mAwEt5B9RrhfyXBPLcPdJK1fbLZfAgBIWC1mbb+FbodP3jA==
X-Received: by 2002:a05:600c:3d86:b0:43d:fa59:a685 with SMTP id
 5b1f17b1804b1-4409bdafd98mr20551425e9.33.1745496806579; 
 Thu, 24 Apr 2025 05:13:26 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d5326e1sm1900906f8f.70.2025.04.24.05.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 05:13:25 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Tom Rini <trini@konsulko.com>, E Shattow <e@freeshell.de>,
 Sumit Garg <sumit.garg@kernel.org>, H Bell <dmoo_dv@protonmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Matthias Brugger <mbrugger@suse.com>, "E . Shattow" <lucent@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Andreas Schwab <schwab@suse.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v4 4/8] board: starfive: spl: support DeepComputing FML13V01
Date: Thu, 24 Apr 2025 14:13:11 +0200
Message-ID: <20250424121315.144549-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250424121315.144549-1-heinrich.schuchardt@canonical.com>
References: <20250424121315.144549-1-heinrich.schuchardt@canonical.com>
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

On the DeepComputing Framework motherboard (FML13V01) choose the matching
FIT configuration.

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
Reviewed-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v4:
	no change
v3:
	no change
v2:
	rebased
---
 board/starfive/visionfive2/spl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 3e4d3e21988..9a3081ef06f 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -125,7 +125,10 @@ int board_fit_config_name_match(const char *name)
 	if (strncmp(name, "starfive/", 9))
 		return -EINVAL;
 	name += 9;
-	if (!strncmp(product_id, "VF7110", 6)) {
+	if (!strncmp(product_id, "FML13V01", 8) &&
+	    !strcmp(name, "jh7110-deepcomputing-fml13v01")) {
+		return 0;
+	} else if (!strncmp(product_id, "VF7110", 6)) {
 		version = get_pcb_revision_from_eeprom();
 		if ((version == 'b' || version == 'B') &&
 		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.3b"))
-- 
2.48.1

