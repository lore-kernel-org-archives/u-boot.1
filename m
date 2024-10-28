Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01299D1039A
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:49:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58BE38917A;
	Mon, 28 Oct 2024 13:48:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eGtWLxwD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A89889156; Mon, 28 Oct 2024 13:48:40 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22BA788C53
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:48:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9a0c40849cso701980366b.3
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119716; x=1730724516; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7uVRf7QRD51QIyxuqZsEDRqnk4PsytbESlbXh1RbDU=;
 b=eGtWLxwDAsQiDhf0/w7bNH033lLdVY+wBMVhiWsIGWGeW1TMb23YMDAC0FAvBXB5Cj
 9yShu+e37XCi73iAGEPv1Wt3cd0L0Y17A2PcAw2YthbK2atlQMoeP4X1YS7HhB/hf4eJ
 AYaZmoKeO4lBy+JUjv3q9oFl7eFhdk1FY/Ivg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119716; x=1730724516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b7uVRf7QRD51QIyxuqZsEDRqnk4PsytbESlbXh1RbDU=;
 b=KYWgnLAnz5R5qVS/yei9OtiyC0GbFdAEUHJx5aDJjHPQSEsdI+ByyTQEvoUENSjUmj
 KDVR2VSZz/+kkcwYZCl+clKtEEZ6TPQk55Hbj9NT/VrI0cM9XZONiOGIFZUfPpAiDuGi
 gLCoCk5aqVJLSvSTSGlXAEKkhyBDbn2EjeCBMSgCxVVU3chP93PYSlczJm/YMs8lOcp/
 Gx4U9l00hMdhBIG5U2H0A1iSBdFE86wE942aJRDg6MI8vit32LuBIQwsCbenRwb1v8wX
 Pu6JWetHEXb3JWDVYa0+auYc9+cIz+2Lq+GqAMtDf973+bpZ/k550X3NE6Rc/JgrHd6X
 mXDg==
X-Gm-Message-State: AOJu0YxLr6a9/0TnAEm31wHGS+njT6RXwNEVVlVJDwj17VRUsOUpHWMK
 dC13+siI7AeIx6Eciy9pIb6jZukNsHKELEXOhU53gJnZ7MKDSoqy+ZFg2/0mAJ7tOTpIHjtaKWE
 4xw==
X-Google-Smtp-Source: AGHT+IFJ5TsI9i7cSI5R4WmMps0vu7YxXXqi64bLCGbzl6j+3C5AbTKFa0PL6CKl8dSypJEqH+LJTg==
X-Received: by 2002:a17:907:97d1:b0:a9a:6b4c:9d2c with SMTP id
 a640c23a62f3a-a9de618d417mr719956166b.59.1730119716517; 
 Mon, 28 Oct 2024 05:48:36 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30d6fdc5sm375593366b.163.2024.10.28.05.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:48:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 08/15] lmb: Drop extra 16KB of stack space
Date: Mon, 28 Oct 2024 13:47:59 +0100
Message-ID: <20241028124815.47262-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124815.47262-1-sjg@chromium.org>
References: <20241028124815.47262-1-sjg@chromium.org>
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

There is already a defined stack-size which is used to reserve space for
the stack. It is confusing to add more in the lmb module, since then the
memory map (with meminfo command) seems to have a hole in it.

Drop this unnecessary feature.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/lmb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index eec99c185ee..9d60865122f 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -219,8 +219,6 @@ static void lmb_reserve_uboot_region(void)
 	 */
 	debug("## Current stack ends at 0x%08lx ", (ulong)rsv_start);
 
-	/* adjust sp by 16K to be safe */
-	rsv_start -= SZ_16K;
 	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
 		if (!gd->bd->bi_dram[bank].size ||
 		    rsv_start < gd->bd->bi_dram[bank].start)
-- 
2.43.0

