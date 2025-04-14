Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BAFC369B5
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 11:49:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E0F38209C;
	Mon, 14 Apr 2025 13:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nzuZ5IwF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 414ED820E8; Mon, 14 Apr 2025 13:49:57 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F35782054
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 13:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5A32B3F342
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 11:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744631394;
 bh=PCjW8YhDNCg9k57seWjVNpwVk9sIFlI2KdOpgW8hWrk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=nzuZ5IwFTt1aKpkp+YE7tBin4s2N3q4jmBbSFJkfFcxebwoCfRql6T8VmZyiI6JGN
 mJJGVmx52sN1kZIYodV+taY8sVGImHFYLwrGmvni5J33v+hFMAxYpyr6/jUrAJ6foy
 hvgubVE6157SA/+MeSGnfsSLVSjH42IinWsCOGvh8ybNRLs4vTTvORVkEBTcdtjZyh
 WFujpk31AH8DZYZpoRkcUo8FzGdFqN86j0dsLlfImrdtuU5JCN3nMKur7qHaGKReqU
 zqCvLTx9AtHXUf8OVWFyEWQqvGTxrXMi1Rw2fVxKu/mRoszTbF7DWiGkaWggiTWbWE
 Xd/h8+8n4PjIg==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d4d15058dso33072485e9.0
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 04:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744631394; x=1745236194;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PCjW8YhDNCg9k57seWjVNpwVk9sIFlI2KdOpgW8hWrk=;
 b=Lf0zoa2WZmD4fOM8+lGU1dyeugGH8GR32OFe+8U63pKHetWqhUCekC7pa37okhAFtY
 3zaERk/wtm9xAg8oh1pDN3a8DQxNJuFh+Pf7cI7ZWQ42Vd39pPMkxIxGrPFhcTAQFC+M
 GWVF8mnudkVyg7OK5rQwlOcY+ISpGdaRN4of5pa6lGG4uQ3h+3lmP+/kDkOKy/ILyX6K
 UCOaQ1KC2LeCPhMHQ0Qpm/etZ2U45A3A4EI+dstiT82iKjgll5r0ec2VzrUCMLBUstVt
 2Iz3a1uSYHvO4/WaWw97xIrY1Zh7DBsaDxCYDFe60+4c8lbVBgbMNr+8c9YMUojFaHiW
 bcnQ==
X-Gm-Message-State: AOJu0YycefoPYR90QXi/6OwkH41QTOZfoZElj20hZ9zasuf+dYEwa5he
 w6dfaqpaxSpCyGwY6JRHS6KwICkJiaW7sTTtIvGzpgFYaSAYdDqaNBrHIOG6SbNoUOIJ9ZXvYcn
 G/uV3V83EAYNvWyjc740zJMa3gjs1p4wRlqiyL8sIiRRwVfIuAxV06aAQpx3F9BquaE4=
X-Gm-Gg: ASbGncsl6mKfKoUCnumRcz9TL4O4d9ol027qv0x5WtwstC7gg88+QIl0lZSCVUgXMkf
 Kj/k7mQmQugWHGwnKXS2cTaujVuhPh9ON9DBOaLlQ68XOi22L3w6SpR7zcnM5i/Q5x8IJjaHQJb
 i0/2yq1tsaCyTWIncfIRPAKtolwtY9tzp5MekqI4rWxJRLrtoFQn4UgfmL+23viLPFhNWHaYjr6
 DibnISVp8UeQzj6J7JT8mx8DymKRS4Ee+O/9tJWZpbFNOx8SenidAa//BAADsNVIcqV6ApyLmsW
 kYkpOkV1UdAiEyEVQLsOWYpJfarK333FdR9HRNzQYIXP1ZlwlBFWywqqmtyYmkVC55QtS/pMpJQ
 SxCFO2GoFTV2uayloODzVmaKV
X-Received: by 2002:a05:600c:1c8e:b0:43c:fe15:41cb with SMTP id
 5b1f17b1804b1-43f3a95dc30mr99919805e9.15.1744631393834; 
 Mon, 14 Apr 2025 04:49:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERAt0u8DsGnT4n3UubWFcg+T2Wzl9EtuoFi0ciCzq8RMjMORR7HzBJ6fvMAplJkuj5vjrQFQ==
X-Received: by 2002:a05:600c:1c8e:b0:43c:fe15:41cb with SMTP id
 5b1f17b1804b1-43f3a95dc30mr99919695e9.15.1744631393438; 
 Mon, 14 Apr 2025 04:49:53 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-046-114-107-129.46.114.pool.telefonica.de. [46.114.107.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233a273fsm172068435e9.9.2025.04.14.04.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 04:49:52 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Peng Fan <peng.fan@nxp.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] mmc: type 'Relatvie'
Date: Mon, 14 Apr 2025 13:49:43 +0200
Message-ID: <20250414114943.55224-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

%s/Relatvie/Relative'

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/mmc/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 31a72366206..9753b1aff38 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -2550,7 +2550,7 @@ static int mmc_startup(struct mmc *mmc)
 
 	/*
 	 * For MMC cards, set the Relative Address.
-	 * For SD cards, get the Relatvie Address.
+	 * For SD cards, get the Relative Address.
 	 * This also puts the cards into Standby State
 	 */
 	if (!mmc_host_is_spi(mmc)) { /* cmd not supported in spi */
-- 
2.48.1

